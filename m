Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android: Add resolve_name parameter to confirm_device_name
Date: Fri, 21 Feb 2014 12:02:41 +0100
Message-ID: <3205434.KKceAMNG0C@uw000953>
In-Reply-To: <1392654390-19913-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1392654390-19913-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Łukasz,

On Monday 17 of February 2014 17:26:29 Lukasz Rymanowski wrote:
> ---
>  android/bluetooth.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 525fd27..1827834 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -1012,7 +1012,8 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
>  			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
>  }
>  
> -static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type)
> +static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type,
> +							bool resolve_name)
>  {
>  	struct mgmt_cp_confirm_name cp;
>  
> @@ -1020,6 +1021,9 @@ static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type)
>  	bacpy(&cp.addr.bdaddr, addr);
>  	cp.addr.type = addr_type;
>  
> +	if (!resolve_name)
> +		cp.name_known = 1;
> +
>  	if (mgmt_reply(mgmt_if, MGMT_OP_CONFIRM_NAME, adapter.index,
>  				sizeof(cp), &cp, NULL, NULL, NULL) == 0)
>  		error("Failed to send confirm name request");
> @@ -1179,10 +1183,12 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
>  
>  	if (confirm) {
>  		char addr[18];
> +		bool resolve_name = true;
>  
>  		ba2str(bdaddr, addr);
> -		info("Device %s needs name confirmation.", addr);
> -		confirm_device_name(bdaddr, bdaddr_type);
> +		info("Device %s needs name confirmation (resolve_name=%d)",
> +							addr, resolve_name);
> +		confirm_device_name(bdaddr, bdaddr_type, resolve_name);
>  	}
>  }
>  

Both patches applied, thanks.

-- 
Best regards, 
Szymon Janc
