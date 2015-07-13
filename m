Return-Path: <cyrus@holtmann.org>
Date: Mon, 13 Jul 2015 14:49:26 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jakub Pawlowski <jpawlowski@google.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/mgmt-tester: Add RPA Add Device test case
Message-ID: <20150713114926.GA25400@t440s.lan>
References: <1436779564-2955-1-git-send-email-jpawlowski@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436779564-2955-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Mon, Jul 13, 2015, Jakub Pawlowski wrote:
> +static const uint8_t add_device_nval_4[] = {
> +					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
> +					0x02,
> +					0x02,
> +};
> +static const uint8_t add_device_rsp_4[] =  {
> +					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
> +					0x02,
> +};
> +static const struct generic_data add_device_fail_4 = {
> +	.send_opcode = MGMT_OP_ADD_DEVICE,
> +	.send_param = add_device_nval_4,
> +	.send_len = sizeof(add_device_nval_4),
> +	.expect_param = add_device_rsp_4,
> +	.expect_len = sizeof(add_device_rsp_4),
> +	.expect_status = MGMT_STATUS_FAILED,

Why is the kernel returning FAILED here? Wouldn't INVALID_PARAMS be a
more accurate error (since you're passing invalid parameters to the mgmt
command).

If I got this right it's the hci_conn_params_set() call that's failing
and mapping to FAILED? You might want to update that function to use
a ERR_PTR() return and then look at the returned value to decide what
mgmt error to send.

Johan
