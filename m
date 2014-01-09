Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/4] android/tester: Remove redundant whitespace
Date: Thu, 09 Jan 2014 18:45:42 +0100
Message-ID: <1864228.c6GxQscBtf@athlon>
In-Reply-To: <1389265295-3344-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1389265295-3344-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Grzegorz,

On Thursday 09 January 2014 12:01:32 Grzegorz Kolodziejczyk wrote:
> ---
>  android/android-tester.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/android/android-tester.c b/android/android-tester.c
> index a448ab5..4f733e1 100644
> --- a/android/android-tester.c
> +++ b/android/android-tester.c
> @@ -189,7 +189,6 @@ static void expected_cb_count_init(struct test_data
> *data) data->cb_count = test_data->expected_cb_count;
> 
>  	check_cb_count();
> -
>  }
> 
>  static void mgmt_cb_init(struct test_data *data)

I've applied patch 1-3 but 4 has some issues reported by valgrind.
Please fix that and resent.

-- 
Szymon K. Janc
szymon.janc@gmail.com
