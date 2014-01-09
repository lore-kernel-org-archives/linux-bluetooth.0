Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jan 2014 16:32:07 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared: Fix use after free in queue_foreach
Message-ID: <20140109143207.GA16810@x220.p-661hnu-f1>
References: <1389274357-25902-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389274357-25902-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Jan 09, 2014, Szymon Janc wrote:
> Function passed to queue_foreach may free queue entry. Make loop safe
> with that. Fix number of following valgrin reports.
> 
> Invalid read of size 8
>    at 0x408EEC: queue_foreach (queue.c:181)
>    by 0x409A0E: can_read_data (mgmt.c:286)
>    by 0x40896C: read_callback (io-glib.c:164)
>    by 0x4E7C3B5: g_main_context_dispatch (in
>        /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
>    by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
>    by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x40B5FC: tester_run (tester.c:784)
>    by 0x4034F4: main (android-tester.c:2127)
>  Address 0x59603a8 is 8 bytes inside a block of size 16 free'd
>    at 0x4C2B60C: free (in /usr/lib/valgrind/
>        vgpreload_memcheck-amd64-linux.so)
>    by 0x40910D: queue_remove_all (queue.c:289)
>    by 0x40A0BD: mgmt_unregister_all (mgmt.c:792)
>    by 0x40A0F4: mgmt_unref (mgmt.c:499)
>    by 0x40D814: index_removed_callback (android-tester.c:329)
>    by 0x408EEB: queue_foreach (queue.c:184)
>    by 0x409A0E: can_read_data (mgmt.c:286)
>    by 0x40896C: read_callback (io-glib.c:164)
>    by 0x4E7C3B5: g_main_context_dispatch (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
>    by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x40B5FC: tester_run (tester.c:784)
> ---
>  src/shared/queue.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Applied. Thanks.

Johan
