Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix segfault: If the interface name is NULL the
 bluetoothd daemon will crash
From: Marcel Holtmann <marcel@holtmann.org>
To: Frieder Buerzele <evermind@tuxfamily.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1235638007-22946-2-git-send-email-evermind@tuxfamily.org>
References: <1235638007-22946-1-git-send-email-evermind@tuxfamily.org>
	 <1235638007-22946-2-git-send-email-evermind@tuxfamily.org>
Content-Type: text/plain
Date: Sat, 28 Feb 2009 22:46:30 +0100
Message-Id: <1235857590.6074.40.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frieder,

> diff --git a/gdbus/object.c b/gdbus/object.c
> index 0786aeb..dde654b 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -224,6 +224,9 @@ static struct interface_data *find_interface(GSList *interfaces,
>  {
>  	GSList *list;
>  
> +	if (NULL == name)
> +		return NULL;
> +
>  	for (list = interfaces; list; list = list->next) {
>  		struct interface_data *iface = list->data;
>  		if (!strcmp(name, iface->name))

a similar patch has been applied to bluez, obexd and connmand. Thanks.

Regards

Marcel


