Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jan 2014 15:22:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] shared: Add ref counting to struct io
Message-ID: <20140109132251.GA12109@x220.p-661hnu-f1>
References: <1389271491-20388-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389271491-20388-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Jan 09, 2014, Szymon Janc wrote:
> This fix use after free in watch_destroy callbacks after mgmt_unref.
> Fix number of following valgrind reports:
> 
> Invalid read of size 8
>    at 0x4088A1: read_watch_destroy (io-glib.c:116)
>    by 0x4E794A7: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
>    by 0x4E7C4C1: g_main_context_dispatch (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
>    by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x40B53C: tester_run (tester.c:784)
>    by 0x4034F4: main (android-tester.c:2127)
>  Address 0x595f828 is 24 bytes inside a block of size 72 free'd
>    at 0x4C2B60C: free (in /usr/lib/valgrind/
>        vgpreload_memcheck-amd64-linux.so)
>    by 0x40A079: mgmt_unref (mgmt.c:504)
>    by 0x40D754: index_removed_callback (android-tester.c:329)
>    by 0x408E67: queue_foreach (queue.c:180)
>    by 0x40994E: can_read_data (mgmt.c:282)
>    by 0x40893C: read_callback (io-glib.c:135)
>    by 0x4E7C3B5: g_main_context_dispatch (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
>    by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x40B53C: tester_run (tester.c:784)
>    by 0x4034F4: main (android-tester.c:2127)
> 
> Invalid write of size 4
>    at 0x4088B3: read_watch_destroy (io-glib.c:119)
>    by 0x4E794A7: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
>    by 0x4E7C4C1: g_main_context_dispatch (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
>    by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x40B53C: tester_run (tester.c:784)
>    by 0x4034F4: main (android-tester.c:2127)
>  Address 0x595f818 is 8 bytes inside a block of size 72 free'd
>    at 0x4C2B60C: free (in /usr/lib/valgrind/
>        vgpreload_memcheck-amd64-linux.so)
>    by 0x40A079: mgmt_unref (mgmt.c:504)
>    by 0x40D754: index_removed_callback (android-tester.c:329)
>    by 0x408E67: queue_foreach (queue.c:180)
>    by 0x40994E: can_read_data (mgmt.c:282)
>    by 0x40893C: read_callback (io-glib.c:135)
>    by 0x4E7C3B5: g_main_context_dispatch (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
>    by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x40B53C: tester_run (tester.c:784)
>    by 0x4034F4: main (android-tester.c:2127)
> ---
>  src/shared/io-glib.c | 45 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 6 deletions(-)

Applied. Thanks.

Johan
