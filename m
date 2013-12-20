Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Dec 2013 14:42:46 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] android/tester: Fix memory leak
Message-ID: <20131220124246.GA31439@x220.p-661hnu-f1>
References: <1387542935-15736-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387542935-15736-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Dec 20, 2013, Andrei Emeltchenko wrote:
> Call del_hook() after add_hook(). This fixes valgrind warnings:
> 
> ...
> ==15303==
> ==15303== HEAP SUMMARY:
> ==15303==     in use at exit: 3,060 bytes in 27 blocks
> ==15303==   total heap usage: 6,410 allocs, 6,383 frees, 332,477 bytes
> allocated
> ==15303==
> ==15303== 24 bytes in 1 blocks are definitely lost in loss record 9 of
> 27
> ==15303==    at 0x4C2A2DB: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==15303==    by 0x406E20: btdev_add_hook (btdev.c:2166)
> ==15303==    by 0x40BFC2: test_discovery_start_done
> (android-tester.c:1401)
> ==15303==    by 0x409C65: run_callback (tester.c:385)
> ==15303==    by 0x4E7C3B5: g_main_context_dispatch (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
> ==15303==    by 0x4E7C707: ??? (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
> ==15303==    by 0x4E7CB09: g_main_loop_run (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
> ==15303==    by 0x40A85C: tester_run (tester.c:784)
> ==15303==    by 0x40368B: main (android-tester.c:1654)
> ==15303==
> ==15303== 24 bytes in 1 blocks are definitely lost in loss record 10 of
> 27
> ==15303==    at 0x4C2A2DB: malloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==15303==    by 0x406E20: btdev_add_hook (btdev.c:2166)
> ==15303==    by 0x40BF12: test_discovery_stop_success
> (android-tester.c:1386)
> ==15303==    by 0x409C65: run_callback (tester.c:385)
> ==15303==    by 0x4E7C3B5: g_main_context_dispatch (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
> ==15303==    by 0x4E7C707: ??? (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
> ==15303==    by 0x4E7CB09: g_main_loop_run (in
> /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
> ==15303==    by 0x40A85C: tester_run (tester.c:784)
> ==15303==    by 0x40368B: main (android-tester.c:1654)
> ==15303==
> ...
> ---
>  android/android-tester.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied. Thanks.

Johan
