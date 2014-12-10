Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 4/4] android/bluetooth: Enable LE privacy mode on BfA startup
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418220974-12287-5-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 10 Dec 2014 16:43:25 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <BC32EE11-AFF0-40D2-B0D7-D132DA60F1A3@holtmann.org>
References: <1418220974-12287-1-git-send-email-lukasz.rymanowski@tieto.com> <1418220974-12287-5-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> Lets follow Android Lollipop behaviour and enable privacy on
> startup.
> ---
> android/bluetooth.c | 26 ++++++++++++++++++++++++++
> 1 file changed, 26 insertions(+)
> 
> diff --git a/android/bluetooth.c b/android/bluetooth.c
> index 1d5d26d..c0c5137 100644
> --- a/android/bluetooth.c
> +++ b/android/bluetooth.c
> @@ -3413,6 +3413,28 @@ static void clear_auto_connect_list(void)
> 	error("Could not clear auto connect list");
> }
> 
> +static void set_privacy_complete(uint8_t status, uint16_t length,
> +					const void *param, void *user_data)
> +{
> +	if (status != MGMT_STATUS_SUCCESS)
> +		error("Failed to set privacy mode: %s (0x%02x)",
> +						mgmt_errstr(status), status);
> +}
> +
> +static void set_privacy(void)
> +{
> +	struct mgmt_cp_set_privacy cp;
> +
> +	cp.privacy = 0x01;
> +	memcpy(cp.irk, adapter.irk, sizeof(adapter.irk));
> +
> +	if (mgmt_send(mgmt_if, MGMT_OP_SET_PRIVACY, adapter.index, sizeof(cp),
> +				&cp, set_privacy_complete, NULL, NULL) > 0)
> +		return;
> +
> +	error("Could not set privacy mode");
> +}
> +
> static void read_info_complete(uint8_t status, uint16_t length,
> 					const void *param, void *user_data)
> {
> @@ -3487,6 +3509,10 @@ static void read_info_complete(uint8_t status, uint16_t length,
> 	if (missing_settings & MGMT_SETTING_BONDABLE)
> 		set_mode(MGMT_OP_SET_BONDABLE, 0x01);
> 
> +	if ((adapter.supported_settings & MGMT_SETTING_LE) &&
> +			(missing_settings & MGMT_SETTING_PRIVACY))
> +		set_privacy();
> +

the LE check is a bit useless. You want to enable privacy when it is supported and let the kernel figure out the details. I will also not tell you about this mode if LE is not available.

Regards

Marcel

