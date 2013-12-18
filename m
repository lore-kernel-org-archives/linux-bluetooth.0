Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 09:58:49 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/7] android/tester: Add UUIDS set prop fail test case
Message-ID: <20131218075849.GA12649@x220.p-661hnu-f1>
References: <1387283874-29721-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
 <1387283874-29721-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387283874-29721-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tue, Dec 17, 2013, Grzegorz Kolodziejczyk wrote:
> This adds UUIDS set property fail test case due to only get
> possibility.
> ---
>  android/android-tester.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

The first two patches have been applied, but a minor thing with this
one:

> +static unsigned char setprop_uuids[] = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
> +			0x00, 0x80, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00,
> +			0x00, 0x00 };
> +
> +static const struct generic_data bluetooth_setprop_uuid_invalid_test = {
> +	.expected_hal_callbacks = {ADAPTER_TEST_END},
> +	.expected_adapter_status = BT_STATUS_FAIL,
> +	.expected_property.type = BT_PROPERTY_UUIDS,
> +	.expected_property.val = &setprop_uuids,
> +	.expected_property.len = 17

How about sizeof(setprop_uuids) here instead of 17?

Johan
