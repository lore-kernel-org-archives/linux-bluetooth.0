Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 10:00:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 5/7] android/tester: Add TOD set prop fail test case
Message-ID: <20131218080010.GC12649@x220.p-661hnu-f1>
References: <1387283874-29721-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
 <1387283874-29721-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387283874-29721-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tue, Dec 17, 2013, Grzegorz Kolodziejczyk wrote:
> This adds TYPE_OF_DEVICE set property fail test case due to only
> get possibility.
> ---
>  android/android-tester.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index a6f66c2..4923a6c 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -618,6 +618,16 @@ static const struct generic_data bluetooth_setprop_cod_invalid_test = {
>  	.expected_property.len = sizeof(uint32_t)
>  };
>  
> +static bt_device_type_t setprop_type_of_device = BT_DEVICE_DEVTYPE_BREDR;
> +
> +static const struct generic_data bluetooth_setprop_tod_invalid_test = {
> +	.expected_hal_callbacks = {ADAPTER_TEST_END},
> +	.expected_adapter_status = BT_STATUS_FAIL,
> +	.expected_property.type = BT_PROPERTY_TYPE_OF_DEVICE,
> +	.expected_property.val = &setprop_type_of_device,
> +	.expected_property.len = sizeof(bt_device_type_t)

sizeof(setprop_type_of_device)

Johan
