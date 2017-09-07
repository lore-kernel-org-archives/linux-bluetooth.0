Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH] autopair: Don't handle the iCade
To: Bastien Nocera <hadess@hadess.net>,
        <linux-bluetooth@vger.kernel.org>
References: <20170904175446.4798-1-hadess@hadess.net>
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
Message-ID: <973c2ecf-7916-b070-bbe5-1b92f7565b8c@jp.fujitsu.com>
Date: Thu, 7 Sep 2017 16:46:44 +0900
MIME-Version: 1.0
In-Reply-To: <20170904175446.4798-1-hadess@hadess.net>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On 09/05/2017 02:54 AM, Bastien Nocera wrote:
> We can't easily enter digits other than 1 through 4 (inclusive)
> so leave it up to the agent to figure out a good passcode
> for the iCade.
> 
> Note that we can not use the VID/PID of the device, as it is not
> yet known at that point.

Does not the device class of iCade include its unique value or a value 
for similar devices?

> ---
>  plugins/autopair.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/plugins/autopair.c b/plugins/autopair.c
> index d44cf539b..a9d2a930a 100644
> --- a/plugins/autopair.c
> +++ b/plugins/autopair.c
> @@ -60,13 +60,24 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
>  {
>  	char addr[18];
>  	char pinstr[7];
> +	char name[25];
>  	uint32_t class;
>  
>  	ba2str(device_get_address(device), addr);
>  
>  	class = btd_device_get_class(device);
>  
> -	DBG("device %s 0x%x", addr, class);
> +	device_get_name(device, name, sizeof(name));
> +	name[sizeof(name) - 1] = 0;
> +
> +	DBG("device '%s' (%s) class: 0x%x vid/pid: 0x%X/0x%X",
> +		name, addr, class,
> +		btd_device_get_vendor (device),
> +		btd_device_get_product (device));
> +
> +	/* The iCade shouldn't use random PINs like normal keyboards */
> +	if (name != NULL && strstr(name, "iCade") != NULL)
> +		return 0;

If there is not a value identified as iCade in the device class, 
I think that it is better to use simply device->name instead of 
copying since the full device name is used.


Regards,
Eramoto

>  
>  	/* This is a class-based pincode guesser. Ignore devices with an
>  	 * unknown class.
> 

