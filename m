Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 00/13] Make android-tester callbacks thread safe
Date: Thu, 27 Feb 2014 15:10:02 +0100
Message-ID: <3495623.2knxJs63KX@uw000953>
In-Reply-To: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1392987473-19994-1-git-send-email-jakub.tyszkowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jakub,

On Friday 21 of February 2014 13:57:40 Jakub Tyszkowski wrote:
> 
> This patch set makes all callbacks executions in HAL's notification thread being
> transfered to tester's context. As test-specific callbacks are called by generic
> callbacks, making the later executed in tester's main loop makes all custom
> callbacks (and newly added) automatically executed in the right contex.
> 
> This is basically RFCv2 resend as PATCH with two follow-up patches.
> 
> Changes in relation to RFCv2:
>   * [PATCH 12/13]: Changed daemon termination checks to non-blocking
>   * [PATCH 13/13]: Added guard to execute all scheduled callbacks in current
>     test's context
> 
> Best regards,
> 
> Jakub Tyszkowski (13):
>   android/tester: Execute device found cbacks in main loop
>   android/tester: Execute discovery state cbacks in main loop
>   android/tester: Execute device properties cbacks in main loop
>   android/tester: Execute adapter props cbacks in main loop
>   android/tester: Execute adapter state changed cbacks in main loop
>   android/tester: Execute socket cbacks in main loop
>   android/tester: Execute hh connection state cbacks in main loop
>   android/tester: Execute hh info cbacks in main loop
>   android/tester: Execute hh protocol mode cbacks in main loop
>   android/tester: Execute hh report cbacks in main loop
>   android/tester: Execute hh virtual unplug cbacks in main loop
>   android/tester: Non-blocking check for daemon termination
>   android/tester: Add guard for late callback calls
> 
>  android/android-tester.c | 375 ++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 326 insertions(+), 49 deletions(-)

All patches except 12/13 are now applied. Thanks.
For waiting for daemon I pushed fix that is using signalfd instead.

-- 
Best regards, 
Szymon Janc
