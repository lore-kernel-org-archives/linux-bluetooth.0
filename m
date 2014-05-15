Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 May 2014 16:16:03 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH ] Add device type info to device info(btd_device)
Message-ID: <20140515131603.GA7144@t440s.lan>
References: <1400147738-23861-1-git-send-email-bharat.panda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1400147738-23861-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Thu, May 15, 2014, Bharat Panda wrote:
> Add device type information whether LE or BR/EDR or
> LE/BR/EDR to device info, which can be further
> exposed as a device property.
> 
> Signed-off-by: Bharat Panda <bharat.panda@samsung.com>
> ---
>  src/adapter.c |    6 ++++++
>  src/device.c  |   11 +++++++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/src/adapter.c b/src/adapter.c
> index f5abfe3..5154448 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -4355,6 +4355,12 @@ static void update_found_devices(struct btd_adapter *adapter,
>  					!(eir_data.flags & EIR_BREDR_UNSUP))
>  		device_set_bredr_support(dev, true);
>  
> +	if (eir_data.flags & (EIR_BREDR_UNSUP))
> +		device_set_le_support(dev, true);

Simply the address type should be enough to know that LE is supported.
No need to check for any AD flags. Anyway, it seems to me that this
chunk is addressing the only real issue (although in a wrong way), but
I'll get to that later.

> +	if (eir_data.flags & (EIR_CONTROLLER | EIR_SIM_HOST | (!EIR_BREDR_UNSUP)))
> +		device_set_dual_mode_support(dev, true);

Since Bluetooth 4.1 these flags should not be set and can be ignored
(see volume 3, part C, section 13.1.1).

> @@ -169,6 +169,7 @@ struct btd_device {
>  	char		*path;
>  	bool		bredr;
>  	bool		le;
> +	bool		dual_mode;

This seems completely pointless to me since dual_mode == true would be
exactly the same as bredr && le.

So, regarding the only potential issue that I could see: it seems we're
lacking code for updating LE support if a device was first discovered
and created over BR/EDR and then we come across it later through LE
discovery. In such a case dev->le would stay untouched.

I just pushed several patches related to this which should hopefully fix
the issue. Let me know if something is still not working for you the way
you'd want with latest git.

Johan
