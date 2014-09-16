Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android: Fix wrong check
Date: Tue, 16 Sep 2014 10:46:59 +0200
Message-ID: <42755799.4GjsktgIel@leonov>
In-Reply-To: <1410855047-13147-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1410855047-13147-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Tuesday 16 of September 2014 11:10:47 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  android/tester-main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/android/tester-main.c b/android/tester-main.c
> index 385c00d..5f0563d 100644
> --- a/android/tester-main.c
> +++ b/android/tester-main.c
> @@ -1631,7 +1631,7 @@ static void setup_avrcp(const void *test_data)
>  	}
> 
>  	avrcp = if_bt->get_profile_interface(BT_PROFILE_AV_RC_ID);
> -	if (!a2dp) {
> +	if (!avrcp) {
>  		tester_setup_failed();
>  		return;
>  	}

Applied, thanks.

-- 
BR
Szymon Janc
