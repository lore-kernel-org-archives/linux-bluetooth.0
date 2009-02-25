Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Fix segfault: If the interface name is NULL the
 bluetoothd daemon will crash
From: Marcel Holtmann <marcel@holtmann.org>
To: evermind@tuxfamily.org
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1235563011-1432-1-git-send-email-evermind@tuxfamily.org>
References: <1235563011-1432-1-git-send-email-evermind@tuxfamily.org>
Content-Type: text/plain
Date: Wed, 25 Feb 2009 15:13:34 +0100
Message-Id: <1235571214.24169.18.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frieder,

> ---
>  gdbus/object.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/gdbus/object.c b/gdbus/object.c
> index 0786aeb..d920eac 100644
> --- a/gdbus/object.c
> +++ b/gdbus/object.c
> @@ -224,11 +224,12 @@ static struct interface_data *find_interface(GSList *interfaces,
>  {
>  	GSList *list;
>  
> -	for (list = interfaces; list; list = list->next) {
> -		struct interface_data *iface = list->data;
> -		if (!strcmp(name, iface->name))
> -			return iface;
> -	}
> +	if (name)
> +		for (list = interfaces; list; list = list->next) {
> +			struct interface_data *iface = list->data;
> +			if (!strcmp(name, iface->name))
> +				return iface;
> +		}
>  
>  	return NULL;
>  }

what about something like this:

	if (name == NULL)
		return NULL;

Regards

Marcel


