Return-Path: <cyrus@holtmann.org>
Date: Thu, 20 Mar 2014 14:32:24 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v5 09/10] tools/mgmt-tester: Refactor
 setup_start_discovery function
Message-ID: <20140320123224.GA7170@t440s.lan>
References: <1395314713-13104-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1395314713-13104-10-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395314713-13104-10-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Mar 20, 2014, Lukasz Rymanowski wrote:
> This patch removes handling hook register from this
> function and its callback as this is no longer necessary for any stop
> discovery tests.
> 
> This patch also adds setup_send_param and setup_send_len  parameters to
> test data so it is easy to control start discovery command parameters.
> It is useful for tests:
> Stop Discovery - Invalid parameters 1
> Stop Discovery - BR/EDR (Inquiry) Success 1
> ---
>  tools/mgmt-tester.c | 62 ++++++++++++++---------------------------------------
>  1 file changed, 16 insertions(+), 46 deletions(-)

I've applied all other patches in the set besides this one.

> --- a/tools/mgmt-tester.c
> +++ b/tools/mgmt-tester.c
> @@ -362,6 +362,9 @@ struct generic_data {
>  	uint16_t setup_expect_hci_command;
>  	const void *setup_expect_hci_param;
>  	uint8_t setup_expect_hci_len;
> +	uint16_t setup_send_opcode;
> +	const void *setup_send_param;
> +	uint16_t setup_send_len;
>  	bool send_index_none;
>  	uint16_t send_opcode;
>  	const void *send_param;
> @@ -1734,6 +1737,8 @@ static const struct generic_data stop_discovery_success_test_1 = {
>  
>  static const struct generic_data stop_discovery_bredr_success_test_1 = {
>  	.setup_settings = settings_powered,
> +	.setup_send_param = start_discovery_bredr_param,
> +	.setup_send_len = sizeof(start_discovery_bredr_param),
>  	.send_opcode = MGMT_OP_STOP_DISCOVERY,
>  	.send_param = stop_discovery_bredr_param,
>  	.send_len = sizeof(stop_discovery_bredr_param),

Where's the setup_send_opcode which you added to the struct? Since
you're calling these by generic names you really should be setting all
of them.

> @@ -1758,6 +1763,8 @@ static const struct generic_data stop_discovery_rejected_test_1 = {
>  
>  static const struct generic_data stop_discovery_invalid_param_test_1 = {
>  	.setup_settings = settings_powered_le,
> +	.setup_send_param = start_discovery_bredrle_param,
> +	.setup_send_len = sizeof(start_discovery_bredrle_param),
>  	.send_opcode = MGMT_OP_STOP_DISCOVERY,
>  	.send_param = stop_discovery_bredrle_invalid_param,
>  	.send_len = sizeof(stop_discovery_bredrle_invalid_param),

Same here.

>  static void setup_start_discovery(const void *test_data)
>  {
>  	struct test_data *data = tester_get_data();
>  	const struct generic_data *test = data->test_data;
> -	const void *send_param = test->send_param;
> -	uint16_t send_len = test->send_len;
> -
> -	if (test->setup_expect_hci_command) {
> -		tester_print("Registering HCI command callback (setup)");
> -		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_PRE_EVT,
> -				test->setup_expect_hci_command,
> -				setup_command_hci_callback,
> -				NULL);
> +	const void *send_param = test->setup_send_param;
> +	uint16_t send_len = test->setup_send_len;
> +	unsigned char disc_param[] = { 0x07 };
>  
> -		mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
> -				send_len, send_param, NULL, NULL, NULL);
> -	} else {
> -		unsigned char disc_param[] = { 0x07 };
> +	if (!send_param) {
> +		send_param = disc_param;
> +		send_len = 1;
> +	}
>  
> -		mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
> -					sizeof(disc_param), disc_param,
> +	mgmt_send(data->mgmt, MGMT_OP_START_DISCOVERY, data->mgmt_index,
> +					send_len, send_param,
>  					setup_discovery_callback, NULL, NULL);

And here you shouldn't have a hard-coded MGMT_OP_START_DISCOVERY but use
setup_send_opcode instead.

Johan
