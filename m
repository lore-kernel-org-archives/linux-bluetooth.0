Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 2/3] Update EIR whenever record is added or removed
From: Marcel Holtmann <marcel@holtmann.org>
To: Inga Stotland <ingas@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	rshaffer@codeaurora.org
In-Reply-To: <1278540518-18620-3-git-send-email-ingas@codeaurora.org>
References: <1278540518-18620-1-git-send-email-ingas@codeaurora.org>
	 <1278540518-18620-3-git-send-email-ingas@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 14:21:05 -0300
Message-ID: <1278609665.10421.34.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Inga,

> index 96280bd..8ec4df4 100644
> --- a/plugins/service.c
> +++ b/plugins/service.c
> @@ -4,6 +4,7 @@
>   *
>   *  Copyright (C) 2006-2010  Nokia Corporation
>   *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
> + *  Copyright (C) 2010, Code Aurora Forum. All rights reserved.

see my comment from the other email.

>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> @@ -445,6 +446,8 @@ static DBusMessage *update_record(DBusConnection *conn, DBusMessage *msg,
>  				strerror(EIO));
>  	}
>  
> +	adapter_update_ext_inquiry_response(&src);
> +
>  	return dbus_message_new_method_return(msg);
>  }
>  
> @@ -516,6 +519,7 @@ static DBusMessage *add_service_record(DBusConnection *conn,
>  	const char *sender, *record;
>  	dbus_uint32_t handle;
>  	int err;
> +	bdaddr_t addr;

Use bdaddr as variable name. In general the addr name is used for the
string version of the address.
 
>  	if (dbus_message_get_args(msg, NULL,
>  			DBUS_TYPE_STRING, &record, DBUS_TYPE_INVALID) == FALSE)
> @@ -526,6 +530,13 @@ static DBusMessage *add_service_record(DBusConnection *conn,
>  	if (err < 0)
>  		return failed_strerror(msg, err);
>  
> +	if (serv_adapter->adapter)
> +		adapter_get_address(serv_adapter->adapter, &addr);
> +	else
> +		bacpy(&addr, BDADDR_ANY);
> +
> +	adapter_update_ext_inquiry_response(&addr);
> +
>  	reply = dbus_message_new_method_return(msg);
>  	if (!reply)
>  		return NULL;
> @@ -550,6 +561,7 @@ static DBusMessage *remove_service_record(DBusConnection *conn,
>  	struct service_adapter *serv_adapter = data;
>  	dbus_uint32_t handle;
>  	const char *sender;
> +	bdaddr_t addr;

See above.

>  
>  	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &handle,
>  						DBUS_TYPE_INVALID) == FALSE)
> @@ -560,6 +572,13 @@ static DBusMessage *remove_service_record(DBusConnection *conn,
>  	if (remove_record(conn, sender, serv_adapter, handle) < 0)
>  		return not_available(msg);
>  
> +	if (serv_adapter->adapter)
> +		adapter_get_address(serv_adapter->adapter, &addr);
> +	else
> +		bacpy(&addr, BDADDR_ANY);
> +
> +	adapter_update_ext_inquiry_response(&addr);
> +
>  	return dbus_message_new_method_return(msg);
>  }
>  
> diff --git a/src/adapter.c b/src/adapter.c
> index 2a6ac18..8a05356 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4,6 +4,7 @@
>   *
>   *  Copyright (C) 2006-2010  Nokia Corporation
>   *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
> + *  Copyright (C) 2010, Code Aurora Forum. All rights reserved.
>   *
>   *
>   *  This program is free software; you can redistribute it and/or modify
> @@ -820,7 +821,7 @@ static DBusMessage *set_pairable_timeout(DBusConnection *conn,
>  
>  static void update_ext_inquiry_response(struct btd_adapter *adapter)
>  {
> -	uint8_t fec = 0, data[240];
> +	uint8_t fec = 0, data[EIR_DATA_LENGTH];
>  	struct hci_dev *dev = &adapter->dev;
>  	int dd;
>  
> @@ -846,6 +847,27 @@ static void update_ext_inquiry_response(struct btd_adapter *adapter)
>  	hci_close_dev(dd);
>  }
>  
> +void adapter_update_ext_inquiry_response(const bdaddr_t *src)

Call this adapter_update_eir_data().

Feel free to fix the update_ext_... into update_eir_data() if you want
in a separate patch.

Regards

Marcel


