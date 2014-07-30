Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 0/9] android/tester-ng: Add HIDHost test cases
Date: Wed, 30 Jul 2014 11:57:56 +0200
Message-ID: <1637247.nXCj3aHdo6@uw000953>
In-Reply-To: <1406618312-15059-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406618312-15059-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Tuesday 29 of July 2014 09:18:23 Jakub Tyszkowski wrote:
> This adds last set of test cases ported to newer tester framework.
> Last patch removes the old 'android-tester' and renames 'android-tester-ng'
> to 'android-tester'.
> 
> v2changes:
> 	* improved/cleaned up some cases step flow
> 	* renamed the 'android-tester-ng' to 'android-tester'
> 
> Jakub Tyszkowski (9):
>   android/tester-ng: Add HIDHost connect, disconnect cases
>   android/tester-ng: Add HIDHost virtual unplug test case
>   android/tester-ng: Add HIDHost get protocol mode case
>   android/tester-ng: Add HIDHost set protocol mode case
>   android/tester-ng: Add HIDHost get report case
>   android/tester-ng: Add HIDHost set report case
>   android/tester-ng: Add HIDHost send data case
>   android/tester: Remove old HIDHost test cases
>   android/tester: Remove old android-tester
> 
>  .gitignore               |    1 -
>  android/Makefile.am      |   30 +-
>  android/android-tester.c | 2812 ----------------------------------------------
>  android/tester-hidhost.c |  533 ++++++++-
>  android/tester-main.c    |   80 +-
>  android/tester-main.h    |   27 +
>  6 files changed, 637 insertions(+), 2846 deletions(-)
>  delete mode 100644 android/android-tester.c
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

All patches applied. Thanks a lot.

-- 
Best regards, 
Szymon Janc
