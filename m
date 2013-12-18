Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 12:25:22 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 1/5] android/tester: Add UUIDS set prop fail test case
Message-ID: <20131218102520.GD26311@aemeltch-MOBL1>
References: <1387360393-853-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387360393-853-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Wed, Dec 18, 2013 at 10:53:09AM +0100, Grzegorz Kolodziejczyk wrote:
> This adds UUIDS set property fail test case due to only get
> possibility.
> ---
>  android/android-tester.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index 92e6080..0025f20 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -596,6 +596,18 @@ static const struct generic_data bluetooth_getprop_bdname_success_test = {
>  	.expected_property.len = 17
>  };
>  
> +static unsigned char setprop_uuids[] = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
> +			0x00, 0x80, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
> +			0x00, 0x00 };
> +
> +static const struct generic_data bluetooth_setprop_uuid_invalid_test = {
> +	.expected_hal_callbacks = {ADAPTER_TEST_END},

Do we agree to use spaces before and after braces?

Best regards 
Andrei Emeltchenko 

