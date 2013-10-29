Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Oct 2013 14:04:45 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/hal: Set callbacks before initializing IPC
Message-ID: <20131029120445.GA31901@x220.p-661hnu-f1>
References: <1382975137-12604-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1382975137-12604-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Mon, Oct 28, 2013, Szymon Janc wrote:
> Notification thread is started on IPC init and it can be scheduled
> before main thread.
> 
> Fix following crash on HAL init:
> 
> pid: 3392, tid: 3492, name: droid.bluetooth  >>> com.android.bluetooth <<<
> signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr 00000028
>     eax 00000000  ebx ce047f64  ecx ce0405d0  edx f7763724
>     esi cdf3af00  edi f837fb90
>     xcs 00000023  xds 0000002b  xes 0000002b  xfs 00000000  xss 0000002b
>     eip ce042289  ebp cdf3a9f8  esp cdf3a9e0  flags 00010292
> 
> backtrace:
>     #00  pc 00003289  /system/lib/hw/bluetooth.default.so (bt_thread_associate+25)
>     #01  pc 000015f8  /system/lib/hw/bluetooth.default.so (notification_handler+40)
>     #02  pc 0000f804  /system/lib/libc.so (__thread_entry+276)
>     #03  pc 0002999d  /system/lib/libc.so
>     #04  pc 00082ae7  /system/lib/libdvm.so (dvmThreadSelf()+39)
>     #05  pc 00010db9  /system/lib/libc.so (pthread_mutex_unlock+25)
> ---
>  android/hal-bluetooth.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
