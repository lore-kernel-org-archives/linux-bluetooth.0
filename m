Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 7/7] Add /hfp/test_hfp_gw_register_3 and /hfp/test_hfp_gw_register_4
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393835812-24238-7-git-send-email-marcin.kraglak@tieto.com>
Date: Mon, 3 Mar 2014 07:23:05 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E6E2219B-6B0E-435F-AA12-4194885D0691@holtmann.org>
References: <1393835812-24238-1-git-send-email-marcin.kraglak@tieto.com> <1393835812-24238-7-git-send-email-marcin.kraglak@tieto.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

> unit/test-hfp.c | 31 +++++++++++++++++++++++++++++++
> 1 file changed, 31 insertions(+)
> 
> diff --git a/unit/test-hfp.c b/unit/test-hfp.c
> index 5e4fc11..64ecc60 100644
> --- a/unit/test-hfp.c
> +++ b/unit/test-hfp.c
> @@ -266,6 +266,33 @@ static const struct test_data test_register_2 = {
> 	.prefix = prefix_brsf
> };
> 
> +static const char atbrsf_read[] = {'A', 'T', '+', 'B', 'R', 'S', 'F', '?',
> +									'\r'};
> +

	= “AT+BRSF?\r”;

> +static const struct test_data test_register_3 = {
> +	.command_cb = cmd_handler,
> +	.server_send = atbrsf_read,
> +	.data_len = sizeof(atbrsf_read),
> +	.expected_rsp = err_rsp,
> +	.expected_rsp_len = sizeof(err_rsp),
> +	.result_cb = prefix_handler,
> +	.expected_cmd_type = HFP_GW_CMD_TYPE_READ,
> +	.prefix = prefix_brsf
> +};
> +
> +static const char prefix_d[] = "D”;

I wonder why here it is acceptable and above you are making the huge effort to give every character separately.

Regards

Marcel

