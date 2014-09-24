Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Explicit set of io capabilities for SSP pairing tests
Date: Wed, 24 Sep 2014 21:40:28 +0200
Message-ID: <3868693.LsqkFdMOh4@athlon>
In-Reply-To: <1411547961-30827-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1411547961-30827-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Wednesday 24 September 2014 10:39:21 Jakub Tyszkowski wrote:
> Those tests are periodically broken every time default io capabalities
> are changed. This patch sets them explicitely to avoid this breakage.
> ---
>  android/tester-bluetooth.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
> index a97e28e..2be824d 100644
> --- a/android/tester-bluetooth.c
> +++ b/android/tester-bluetooth.c
> @@ -448,6 +448,10 @@ static  struct bt_action_data no_input_no_output_io_cap
> = { .io_cap = 0x03,
>  };
> 
> +static  struct bt_action_data display_yes_no_io_cap = {
> +	.io_cap = 0x01,
> +};
> +
>  static uint16_t test_conn_handle = 0;
> 
>  static void conn_cb(uint16_t handle, void *user_data)
> @@ -1034,6 +1038,7 @@ static struct test_case test_cases[] = {
>  		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
>  		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
>  		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
> +		ACTION_SUCCESS(emu_set_io_cap, &display_yes_no_io_cap),
>  		ACTION_SUCCESS(bt_start_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STARTED),
> @@ -1057,6 +1062,7 @@ static struct test_case test_cases[] = {
>  		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
>  		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
>  		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
> +		ACTION_SUCCESS(emu_set_io_cap, &display_yes_no_io_cap),
>  		ACTION_SUCCESS(bt_start_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STARTED),
> @@ -1081,6 +1087,7 @@ static struct test_case test_cases[] = {
>  		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
>  		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
>  		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
> +		ACTION_SUCCESS(emu_set_io_cap, &display_yes_no_io_cap),
>  		ACTION_SUCCESS(bt_create_bond_action,
>  					&prop_test_remote_ble_bdaddr_req),
>  		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDING,
> @@ -1113,6 +1120,7 @@ static struct test_case test_cases[] = {
>  		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
>  		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
>  		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
> +		ACTION_SUCCESS(emu_set_io_cap, &display_yes_no_io_cap),
>  		ACTION_SUCCESS(bt_start_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STARTED),
> @@ -1138,6 +1146,7 @@ static struct test_case test_cases[] = {
>  		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
>  		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
>  		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
> +		ACTION_SUCCESS(emu_set_io_cap, &display_yes_no_io_cap),
>  		ACTION_SUCCESS(bt_start_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STARTED),

Applied, thanks.

-- 
Szymon K. Janc
szymon.janc@gmail.com
