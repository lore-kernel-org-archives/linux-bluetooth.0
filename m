Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com
References: <1421229458-11207-1-git-send-email-gowtham.ab@samsung.com>
 <1421229458-11207-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1421229458-11207-3-git-send-email-gowtham.ab@samsung.com>
Subject: RE: [PATCH  2/3] shared/gatt-client: Fix usage of freed memory
Date: Tue, 20 Jan 2015 15:05:11 +0530
Message-id: <001401d03494$687b4e60$3971eb20$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ping.

> -----Original Message-----
> From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-
> owner@vger.kernel.org] On Behalf Of Gowtham Anandha Babu
> Sent: Wednesday, January 14, 2015 3:28 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: bharat.panda@samsung.com; cpgs@samsung.com; Gowtham Anandha
> Babu
> Subject: [PATCH 2/3] shared/gatt-client: Fix usage of freed memory
> 
> src/shared/gatt-client.c:472:14: warning: Use of memory after it is freed
>         op->success = false;
>         ~~~~~~~~~~~ ^
> src/shared/gatt-client.c:627:14: warning: Use of memory after it is freed
>         op->success = success;
>         ~~~~~~~~~~~ ^
> src/shared/gatt-client.c:728:14: warning: Use of memory after it is freed
>         op->success = success;
>         ~~~~~~~~~~~ ^
> src/shared/gatt-client.c:820:14: warning: Use of memory after it is freed
>         op->success = success;
>         ~~~~~~~~~~~ ^
> src/shared/gatt-client.c:888:14: warning: Use of memory after it is freed
>         op->success = success;
>         ~~~~~~~~~~~ ^
> src/shared/gatt-client.c:1909:2: warning: Use of memory after it is freed
>         complete_read_long_op(op, success, att_ecode);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:2126:2: warning: Use of memory after it is freed
>         complete_write_long_op(op, success, 0, false);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> src/shared/gatt-client.c:2194:6: warning: Use of memory after it is freed
>         if (op->callback)
>             ^~~~~~~~~~~~
> ---
>  src/shared/gatt-client.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c index
> 3042a6c..371e89f 100644
> --- a/src/shared/gatt-client.c
> +++ b/src/shared/gatt-client.c
> @@ -449,7 +449,6 @@ next:
> 
>  		util_debug(client->debug_callback, client->debug_data,
>  				"Failed to start characteristic discovery");
> -		discovery_op_unref(op);
>  		goto failed;
>  	}
> 
> @@ -466,11 +465,11 @@ next:
> 
>  	util_debug(client->debug_callback, client->debug_data,
>  					"Failed to start included
discovery");
> -	discovery_op_unref(op);
> 
>  failed:
>  	op->success = false;
>  	op->complete_func(op, false, att_ecode);
> +	discovery_op_unref(op);
>  }
> 
>  struct chrc {
> @@ -618,7 +617,6 @@ next:
> 
>  	util_debug(client->debug_callback, client->debug_data,
>  				"Failed to start characteristic discovery");
> -	discovery_op_unref(op);
> 
>  failed:
>  	success = false;
> @@ -626,6 +624,7 @@ failed:
>  done:
>  	op->success = success;
>  	op->complete_func(op, success, att_ecode);
> +	discovery_op_unref(op);
>  }
> 
>  static void discover_chrcs_cb(bool success, uint8_t att_ecode, @@ -719,7
> +718,6 @@ next:
> 
>  	util_debug(client->debug_callback, client->debug_data,
>  				"Failed to start characteristic discovery");
> -	discovery_op_unref(op);
> 
>  failed:
>  	success = false;
> @@ -727,6 +725,7 @@ failed:
>  done:
>  	op->success = success;
>  	op->complete_func(op, success, att_ecode);
> +	discovery_op_unref(op);
>  }
> 
>  static void discover_secondary_cb(bool success, uint8_t att_ecode, @@ -
> 814,11 +813,11 @@ next:
> 
>  	util_debug(client->debug_callback, client->debug_data,
>  				"Failed to start included services
discovery");
> -	discovery_op_unref(op);
> 
>  done:
>  	op->success = success;
>  	op->complete_func(op, success, att_ecode);
> +	discovery_op_unref(op);
>  }
> 
>  static void discover_primary_cb(bool success, uint8_t att_ecode, @@ -
> 881,12 +880,12 @@ static void discover_primary_cb(bool success, uint8_t
> att_ecode,
> 
>  	util_debug(client->debug_callback, client->debug_data,
>  				"Failed to start secondary service
discovery");
> -	discovery_op_unref(op);
>  	success = false;
> 
>  done:
>  	op->success = success;
>  	op->complete_func(op, success, att_ecode);
> +	discovery_op_unref(op);
>  }
> 
>  static void notify_client_ready(struct bt_gatt_client *client, bool
success,
> @@ -1897,7 +1896,6 @@ static void read_long_cb(uint8_t opcode, const void
> *pdu,
> 
> 	read_long_op_unref))
>  			return;
> 
> -		read_long_op_unref(op);
>  		success = false;
>  		goto done;
>  	}
> @@ -1907,6 +1905,7 @@ success:
> 
>  done:
>  	complete_read_long_op(op, success, att_ecode);
> +	read_long_op_unref(op);
>  }
> 
>  bool bt_gatt_client_read_long_value(struct bt_gatt_client *client, @@ -
> 2109,7 +2108,6 @@ static void handle_next_prep_write(struct
> long_write_op *op)
>  							prepare_write_cb,
> 
> 	long_write_op_ref(op),
> 
> 	long_write_op_unref)) {
> -		long_write_op_unref(op);
>  		success = false;
>  	}
> 
> @@ -2124,6 +2122,7 @@ static void handle_next_prep_write(struct
> long_write_op *op)
> 
>  done:
>  	complete_write_long_op(op, success, 0, false);
> +	long_write_op_unref(op);
>  }
> 
>  static void start_next_long_write(struct bt_gatt_client *client) @@
-2141,10
> +2140,10 @@ static void start_next_long_write(struct bt_gatt_client
*client)
> 
>  	handle_next_prep_write(op);
> 
> -	/* send_next_prep_write adds an extra ref. Unref here to clean up if
> -	 * necessary, since we also added a ref before pushing to the queue.
> +	/* send_next_prep_write adds an extra ref. Unref is handled inside
> +	 * handle_next_prep_write, since we also added a ref before
> pushing
> +	 * to the queue.
>  	 */
> -	long_write_op_unref(op);
>  }
> 
>  static void execute_write_cb(uint8_t opcode, const void *pdu, uint16_t
> length, @@ -2188,13 +2187,13 @@ static void
> complete_write_long_op(struct long_write_op *op, bool success,
> 
> 	long_write_op_unref))
>  		return;
> 
> -	long_write_op_unref(op);
>  	success = false;
> 
>  	if (op->callback)
>  		op->callback(success, reliable_error, att_ecode, op-
> >user_data);
> 
>  	start_next_long_write(op->client);
> +	long_write_op_unref(op);
>  }
> 
>  static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t
> length,
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth"
in
> the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html

