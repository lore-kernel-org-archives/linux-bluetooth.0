Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Fix slang "never used" warning
Date: Fri, 21 Feb 2014 17:00:26 +0100
Message-ID: <1480378.m0ANBe2P0I@uw000953>
In-Reply-To: <1392997607-21896-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1392997607-21896-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Friday 21 of February 2014 17:46:47 Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> The patch fixes following warning:
> ...
> android/android-tester.c:2185:2: warning: Value stored to
> 'adapter_status' is never read
>         adapter_status = data->if_bluetooth->set_adapter_property(prop);
>         ^                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ...
> ---
>  android/android-tester.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index 84c6ca9..47f918c 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -2190,6 +2190,10 @@ static void test_getprop_bdname_success(const void *test_data)
>  	init_test_conditions(data);
>  
>  	adapter_status = data->if_bluetooth->set_adapter_property(prop);
> +	if (adapter_status != BT_STATUS_SUCCESS) {
> +		tester_setup_failed();

This should be tester_test_failed().

> +		return;
> +	}
>  
>  	adapter_status = data->if_bluetooth->get_adapter_property((*prop).type);
>  	check_expected_status(adapter_status);
> 

-- 
Best regards, 
Szymon Janc
