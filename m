Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 May 2011 14:38:32 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
	hadess@hadess.net, dforsi@gmail.com
Subject: Re: [PATCH 2/4] Make adapter API accept binary pincodes
Message-ID: <20110505173832.GB2098@joana>
References: <1302455477-27664-1-git-send-email-dh.herrmann@googlemail.com>
 <1302455477-27664-3-git-send-email-dh.herrmann@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1302455477-27664-3-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* David Herrmann <dh.herrmann@googlemail.com> [2011-04-10 19:11:15 +0200]:

> Add pin-length argument to adapter API to allow passing binary pins
> containing \0 characters to the hci handler.
> ---
>  src/adapter.c |    4 ++--
>  src/adapter.h |    2 +-
>  src/event.c   |    6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index 83f3217..14516ac 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -3701,9 +3701,9 @@ int btd_adapter_remove_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr)
>  }
>  
>  int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
> -							const char *pin)
> +							const char *pin, size_t pinlen)

Over column 80 here.

>  {
> -	return adapter_ops->pincode_reply(adapter->dev_id, bdaddr, pin, pin ? strlen(pin) : 0);
> +	return adapter_ops->pincode_reply(adapter->dev_id, bdaddr, pin, pinlen);
>  }
>  
>  int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
> diff --git a/src/adapter.h b/src/adapter.h
> index fd2fc12..b507506 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -273,7 +273,7 @@ int btd_adapter_disconnect_device(struct btd_adapter *adapter,
>  int btd_adapter_remove_bonding(struct btd_adapter *adapter, bdaddr_t *bdaddr);
>  
>  int btd_adapter_pincode_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
> -							const char *pin);
> +							const char *pin, size_t pinlen);

and here.

>  int btd_adapter_confirm_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
>  							gboolean success);
>  int btd_adapter_passkey_reply(struct btd_adapter *adapter, bdaddr_t *bdaddr,
> diff --git a/src/event.c b/src/event.c
> index 4ca1be5..248fb78 100644
> --- a/src/event.c
> +++ b/src/event.c
> @@ -111,13 +111,13 @@ static void pincode_cb(struct agent *agent, DBusError *derr,
>  	device_get_address(device, &dba);
>  
>  	if (derr) {
> -		err = btd_adapter_pincode_reply(adapter, &dba, NULL);
> +		err = btd_adapter_pincode_reply(adapter, &dba, NULL, 0);
>  		if (err < 0)
>  			goto fail;
>  		return;
>  	}
>  
> -	err = btd_adapter_pincode_reply(adapter, &dba, pincode);
> +	err = btd_adapter_pincode_reply(adapter, &dba, pincode, pincode ? strlen(pincode) : 0);

and here.

-- 
Gustavo F. Padovan
http://profusion.mobi
