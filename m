Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] android/tester: Clarify default properties match names
Date: Fri, 22 Dec 2017 10:27:41 +0100
Message-ID: <4885605.Vzfp4LaIp6@ix>
In-Reply-To: <20171221204413.20998-1-szymon.janc@codecoup.pl>
References: <20171221204413.20998-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thursday, 21 December 2017 21:44:12 CET Szymon Janc wrote:
> ---
>  android/tester-bluetooth.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/android/tester-bluetooth.c b/android/tester-bluetooth.c
> index 22077a064..bab6dc952 100644
> --- a/android/tester-bluetooth.c
> +++ b/android/tester-bluetooth.c
> @@ -231,7 +231,7 @@ static bt_property_t prop_emu_default_set[] = {
>  	{ BT_PROPERTY_UUIDS, sizeof(emu_uuids_val), &emu_uuids_val },
>  };
> 
> -static bt_property_t prop_emu_remote_bles_default_set[] = {
> +static bt_property_t prop_emu_remote_ble_default_set[] = {
>  	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
>  						&emu_remote_bdaddr_val },
>  	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_remote_tod_ble_val),
> @@ -240,7 +240,7 @@ static bt_property_t prop_emu_remote_bles_default_set[]
> = { &emu_remote_ble_rssi_val },
>  };
> 
> -static bt_property_t prop_emu_remotes_default_set[] = {
> +static bt_property_t prop_emu_remote_bredr_default_set[] = {
>  	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
>  						&emu_remote_bdaddr_val },
>  	{ BT_PROPERTY_TYPE_OF_DEVICE, sizeof(emu_remote_type_val),
> @@ -648,7 +648,7 @@ static struct test_case test_cases[] = {
>  		ACTION_SUCCESS(bt_start_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STARTED),
> -		CALLBACK_DEVICE_FOUND(prop_emu_remote_bles_default_set, 3),
> +		CALLBACK_DEVICE_FOUND(prop_emu_remote_ble_default_set, 3),
>  		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STOPPED),
> @@ -996,7 +996,7 @@ static struct test_case test_cases[] = {
>  		ACTION_SUCCESS(bt_start_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STARTED),
> -		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 3),
> +		CALLBACK_DEVICE_FOUND(prop_emu_remote_bredr_default_set, 3),
>  		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STOPPED),
> @@ -1019,7 +1019,7 @@ static struct test_case test_cases[] = {
>  		ACTION_SUCCESS(bt_start_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STARTED),
> -		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 3),
> +		CALLBACK_DEVICE_FOUND(prop_emu_remote_bredr_default_set, 3),
>  		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STOPPED),
> @@ -1044,7 +1044,7 @@ static struct test_case test_cases[] = {
>  		ACTION_SUCCESS(bt_start_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STARTED),
> -		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 3),
> +		CALLBACK_DEVICE_FOUND(prop_emu_remote_bredr_default_set, 3),
>  		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STOPPED),
> @@ -1068,7 +1068,7 @@ static struct test_case test_cases[] = {
>  		ACTION_SUCCESS(bt_start_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STARTED),
> -		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 3),
> +		CALLBACK_DEVICE_FOUND(prop_emu_remote_bredr_default_set, 3),
>  		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STOPPED),
> @@ -1126,7 +1126,7 @@ static struct test_case test_cases[] = {
>  		ACTION_SUCCESS(bt_start_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STARTED),
> -		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 3),
> +		CALLBACK_DEVICE_FOUND(prop_emu_remote_bredr_default_set, 3),
>  		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STOPPED),
> @@ -1152,7 +1152,7 @@ static struct test_case test_cases[] = {
>  		ACTION_SUCCESS(bt_start_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STARTED),
> -		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_set, 3),
> +		CALLBACK_DEVICE_FOUND(prop_emu_remote_bredr_default_set, 3),
>  		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
>  		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
>  							BT_DISCOVERY_STOPPED),

Applied.

-- 
pozdrawiam
Szymon Janc
