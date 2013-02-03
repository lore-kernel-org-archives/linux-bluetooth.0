Return-Path: <cyrus@holtmann.org>
Message-ID: <1359892069.6873.2.camel@aeonflux>
Subject: Re: [PATCH] shared: Fix use after free in read_watch_destroy
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Date: Sun, 03 Feb 2013 12:47:49 +0100
In-Reply-To: <1359830398-23165-1-git-send-email-szymon@janc.net.pl>
References: <1359830398-23165-1-git-send-email-szymon@janc.net.pl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> read_watch_destroy is called when received_data returns FALSE.
> free mgmt in read_watch_destroy instead of received_data to avoid
> use after free.
> 
> Invalid write of size 4
>    at 0x8051604: read_watch_destroy (mgmt.c:271)
>    by 0x48C7468E: g_source_callback_unref (gmain.c:1457)
>    by 0x48C77287: g_main_context_dispatch (gmain.c:2723)
>    by 0x48C774FF: g_main_context_iterate.isra.22 (gmain.c:3290)
>    by 0x48C77962: g_main_loop_run (gmain.c:3484)
>    by 0x805393E: tester_run (tester.c:784)
>    by 0x804D1C7: main (mgmt-tester.c:2558)
>  Address 0x4039b80 is 16 bytes inside a block of size 76 free'd
>    at 0x4007F0F: free (vg_replace_malloc.c:446)
>    by 0x48C7D44B: standard_free (gmem.c:98)
>    by 0x48C7D607: g_free (gmem.c:252)
>    by 0x8051BB6: received_data (mgmt.c:337)
>    by 0x48CBA72E: g_io_unix_dispatch (giounix.c:167)
>    by 0x48C7715A: g_main_context_dispatch (gmain.c:2715)
>    by 0x48C774FF: g_main_context_iterate.isra.22 (gmain.c:3290)
>    by 0x48C77962: g_main_loop_run (gmain.c:3484)
>    by 0x805393E: tester_run (tester.c:784)
>    by 0x804D1C7: main (mgmt-tester.c:2558)
> ---
>  src/shared/mgmt.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

excellent catch here. I totally overlooked this code path when fixing
unregister from event callback. Patch has been applied.

Regards

Marcel


