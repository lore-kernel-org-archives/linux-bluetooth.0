Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/mgmt-tester: Add power on testcase with adv and privacy
Date: Mon, 23 Nov 2015 19:52:23 +0100
Message-ID: <5231128.4gHGcjJv1p@ix>
In-Reply-To: <1447360987-4129-2-git-send-email-andrzej.kaczmarek@codecoup.pl>
References: <1447360987-4129-1-git-send-email-andrzej.kaczmarek@codecoup.pl> <1447360987-4129-2-git-send-email-andrzej.kaczmarek@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrzej,

On Thursday 12 November 2015 21:43:07 Andrzej Kaczmarek wrote:
> This test verifies if kernel can properly enable advertising during
> power on with privacy also enabled. This requires to generate new RPA
> which will fail if not done after SMP is registered. As a consequence
> advertising is not enabled in controller which means it cannot be also
> disabled (controller will reject HCI command).
> ---
>  tools/mgmt-tester.c | 29 +++++++++++++++++++++++++++--
>  1 file changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
> index b224543..670c580 100644
> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -584,6 +584,22 @@ static const struct generic_data
> set_powered_on_invalid_index_test = { .expect_status =
> MGMT_STATUS_INVALID_INDEX,
>  };
> 
> +static uint16_t settings_powered_advertising_privacy[] = {
> +						MGMT_OP_SET_PRIVACY,
> +						MGMT_OP_SET_ADVERTISING,
> +						MGMT_OP_SET_POWERED, 0 };
> +
> +static const char set_adv_off_param[] = { 0x00 };
> +
> +static const struct generic_data set_powered_on_privacy_adv_test = {
> +	.setup_settings = settings_powered_advertising_privacy,
> +	.send_opcode = MGMT_OP_SET_ADVERTISING,
> +	.send_param = set_adv_off_param,
> +	.send_len = sizeof(set_adv_off_param),
> +	.expect_status = MGMT_STATUS_SUCCESS,
> +	.expect_ignore_param = true,
> +};
> +
>  static const uint16_t settings_powered[] = { MGMT_OP_SET_POWERED, 0 };
> 
>  static const char set_powered_off_param[] = { 0x00 };
> @@ -4356,8 +4372,6 @@ static const struct generic_data
> add_advertising_success_4 = { .expect_hci_len = sizeof(set_adv_data_txpwr),
>  };
> 
> -static const char set_adv_off_param[] = { 0x00 };
> -
>  static const struct generic_data add_advertising_success_5 = {
>  	.send_opcode = MGMT_OP_SET_ADVERTISING,
>  	.send_param = set_adv_off_param,
> @@ -5566,6 +5580,9 @@ proceed:
>  	for (cmd = test->setup_settings; *cmd; cmd++) {
>  		unsigned char simple_param[] = { 0x01 };
>  		unsigned char discov_param[] = { 0x01, 0x00, 0x00 };
> +		unsigned char privacy_param[] = { 0x01,
> +			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
> +			0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 };
>  		unsigned char *param = simple_param;
>  		size_t param_size = sizeof(simple_param);
>  		mgmt_request_func_t func = NULL;
> @@ -5584,6 +5601,11 @@ proceed:
>  			param = discov_param;
>  		}
> 
> +		if (*cmd == MGMT_OP_SET_PRIVACY) {
> +			param_size = sizeof(privacy_param);
> +			param = privacy_param;
> +		}
> +
>  		if (*cmd == MGMT_OP_SET_LE && test->setup_nobredr) {
>  			unsigned char off[] = { 0x00 };
>  			mgmt_send(data->mgmt, *cmd, data->mgmt_index,
> @@ -6075,6 +6097,9 @@ int main(int argc, char *argv[])
>  	test_bredrle("Set powered on - Invalid index",
>  				&set_powered_on_invalid_index_test,
>  				NULL, test_command_generic);
> +	test_le("Set powered on - Privacy and Advertising",
> +				&set_powered_on_privacy_adv_test,
> +				NULL, test_command_generic);
> 
>  	test_bredrle("Set powered off - Success",
>  				&set_powered_off_success_test,

This patch is now applied, thanks.

-- 
pozdrawiam
Szymon Janc
