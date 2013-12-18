Return-Path: <cyrus@holtmann.org>
Date: Wed, 18 Dec 2013 10:00:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 7/7] android/tester: Add SERVICE_RECORD set prop fail
 test case
Message-ID: <20131218080058.GE12649@x220.p-661hnu-f1>
References: <1387283874-29721-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
 <1387283874-29721-7-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387283874-29721-7-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Tue, Dec 17, 2013, Grzegorz Kolodziejczyk wrote:
> +static bt_service_record_t setprop_remote_service = {
> +	.uuid = { {0x00} },
> +	.channel = 12,
> +	.name = "bt_name"
> +};
> +
> +static const struct generic_data
> +			bluetooth_setprop_service_record_invalid_test = {
> +	.expected_hal_callbacks = {ADAPTER_TEST_END},
> +	.expected_adapter_status = BT_STATUS_FAIL,
> +	.expected_property.type = BT_PROPERTY_SERVICE_RECORD,
> +	.expected_property.val = &setprop_remote_service,
> +	.expected_property.len = sizeof(bt_service_record_t)

sizeof(setprop_remote_service);


Johan
