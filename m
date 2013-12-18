Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 09:59:28 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/7] android/tester: Add COD set prop fail test case
Message-ID: <20131218075928.GB12649@x220.p-661hnu-f1>
References: <1387283874-29721-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
 <1387283874-29721-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387283874-29721-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tue, Dec 17, 2013, Grzegorz Kolodziejczyk wrote:
> This adds CLASS_OF_DEVICE set property fail test case due to only
> get possibility.
> ---
>  android/android-tester.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index 4fe0033..a6f66c2 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -608,6 +608,16 @@ static const struct generic_data bluetooth_setprop_uuid_invalid_test = {
>  	.expected_property.len = 17
>  };
>  
> +static uint32_t setprop_class_of_device = 0;
> +
> +static const struct generic_data bluetooth_setprop_cod_invalid_test = {
> +	.expected_hal_callbacks = {ADAPTER_TEST_END},
> +	.expected_adapter_status = BT_STATUS_FAIL,
> +	.expected_property.type = BT_PROPERTY_CLASS_OF_DEVICE,
> +	.expected_property.val = &setprop_class_of_device,
> +	.expected_property.len = sizeof(uint32_t)

sizeof(setprop_class_of_device) makes more sense than uint32_t.

Johan
