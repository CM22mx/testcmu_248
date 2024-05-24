view: orders {
  sql_table_name: "LOOKER_TEST"."ORDERS" ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}."ID" ;;
  }
  dimension_group: created {
    type: time
    timeframes: [  raw, time, time_of_day, hour_of_day, date, day_of_week, day_of_week_index, week, month, month_name, month_num, quarter, year, week_of_year,
      fiscal_year,
      fiscal_quarter,
      fiscal_month_num]
    sql: ${TABLE}."CREATED_AT" ;;
  }

  dimension_group: final_date {
      type: time
      timeframes: [raw, time, time_of_day, hour_of_day, date, day_of_week, day_of_week_index, week, month, month_name, month_num, quarter, year, week_of_year,
        fiscal_year,
        fiscal_quarter,
        fiscal_month_num]
      sql: DATEADD(HOUR, 1, ${TABLE}."CREATED_AT") ;;
    }


  dimension: order_amount {
    type: number
    sql: ${TABLE}."ORDER_AMOUNT" ;;
  }
  dimension: status {
    type: string
    sql: ${TABLE}."STATUS" ;;
  }
  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}."USER_ID" ;;
  }
  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # ----- Sets of fields for drilling ------
  set: detail {
    fields: [
  id,
  users.name,
  users.id,
  billion_orders.count,
  hundred_million_orders.count,
  order_items.count
  ]
  }

}
