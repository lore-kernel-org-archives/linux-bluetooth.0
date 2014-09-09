Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Fix not handled ssp requests in AVRCP cases
Date: Tue, 09 Sep 2014 13:53:45 +0200
Message-ID: <8249079.MjFWCsRB8x@leonov>
In-Reply-To: <1410259918-28023-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1410259918-28023-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 09 of September 2014 12:51:58 Jakub Tyszkowski wrote:
> Those were previously passing because of ssp handler being not cleaned
> between test cases. This is now fixed in tester framework thus test cases
> needs to be updated.
> ---
>  android/tester-avrcp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
> index 337a621..07b95f5 100644
> --- a/android/tester-avrcp.c
> +++ b/android/tester-avrcp.c
> @@ -241,6 +241,7 @@ static struct test_case test_cases[] = {
>  		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
>  		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
>  		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
> +		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
>  		ACTION_SUCCESS(emu_add_l2cap_server_action, &sdp_setup_data),
>  		ACTION_SUCCESS(emu_add_l2cap_server_action, &a2dp_setup_data),
>  		ACTION_SUCCESS(emu_add_l2cap_server_action, &avrcp_setup_data),
> @@ -257,6 +258,7 @@ static struct test_case test_cases[] = {
>  		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
>  		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
>  		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
> +		ACTION_SUCCESS(set_default_ssp_request_handler, NULL),
>  		ACTION_SUCCESS(emu_add_l2cap_server_action, &sdp_setup_data),
>  		ACTION_SUCCESS(emu_add_l2cap_server_action, &a2dp_setup_data),
>  		ACTION_SUCCESS(emu_add_l2cap_server_action, &avrcp_setup_data),

Patch applied, thanks.

-- 
BR
Szymon Janc
