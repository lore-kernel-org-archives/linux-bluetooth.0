Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Jan 2014 09:59:56 -0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 4/4] emulator: Fix crash if socket(AF_ALG) is not
 supported by the kernel
Message-ID: <20140127175956.GB2452@x220.p-661hnu-f1>
References: <1390512281-26541-1-git-send-email-anderson.lizardo@openbossa.org>
 <1390700642-10482-1-git-send-email-anderson.lizardo@openbossa.org>
 <1390700642-10482-5-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1390700642-10482-5-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lizardo,

On Sat, Jan 25, 2014, Anderson Lizardo wrote:
> In this situation, smp_stop() was being called with NULL pointer.
> 
> Crash detected by valgrind:
> 
> ==7925== Invalid read of size 4
> ==7925==    at 0x8052F18: smp_stop (smp.c:480)
> ==7925==    by 0x8052542: bthost_stop (bthost.c:2073)
> ==7925==    by 0x805521D: hciemu_unref (hciemu.c:372)
> ==7925==    by 0x8058C65: test_post_teardown (android-tester.c:464)
> ==7925==    by 0x8055DE7: tester_teardown_complete (tester.c:533)
> ==7925==    by 0x8055501: teardown_callback (tester.c:312)
> ==7925==    by 0x408348F: g_idle_dispatch (gmain.c:5250)
> ==7925==    by 0x4086A75: g_main_context_dispatch (gmain.c:3065)
> ==7925==    by 0x4086E14: g_main_context_iterate.isra.23 (gmain.c:3712)
> ==7925==    by 0x40872FA: g_main_loop_run (gmain.c:3906)
> ==7925==    by 0x41744D2: (below main) (libc-start.c:226)
> ==7925==  Address 0x8 is not stack'd, malloc'd or (recently) free'd
> ---
>  emulator/bthost.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

This patch has been applied. Thanks.

Johan
