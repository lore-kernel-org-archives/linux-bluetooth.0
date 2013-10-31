Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: [PATCH] android: Always enable SSP if supported by controller
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1383216631-28187-1-git-send-email-szymon.janc@tieto.com>
Date: Thu, 31 Oct 2013 12:35:13 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <370BDED4-A87A-4EAC-BFAC-1ADB1075021D@holtmann.org>
References: <1383216631-28187-1-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> There is no HAL function to enable/disable SSP so always enable it if
> supported by controller.
> ---
> android/adapter.c | 5 +++++
> 1 file changed, 5 insertions(+)
> 
> diff --git a/android/adapter.c b/android/adapter.c
> index a3f9aa6..9f2e019 100644
> --- a/android/adapter.c
> +++ b/android/adapter.c
> @@ -528,6 +528,11 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
> 	load_link_keys(NULL);
> 
> 	set_io_capability();
> +
> +	if ((adapter->supported_settings & MGMT_SETTING_SSP) &&
> +			!(adapter->current_settings & MGMT_SETTING_SSP))
> +		set_mode(MGMT_OP_SET_SSP, 0x01);
> +

	missing_settings = current_settings ^ supported_settings;

	if (missing_setting & MGMT_SETTING_SSP)
		..

Regards

Marcel

