Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Jan 2014 21:11:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Szymon Janc <szymon.janc@tieto.com>
Subject: Re: [PATCH v2] shared: Fix not calling destroy callback while
 clearing up handlers
Message-ID: <20140109191158.GA30881@x220.p-661hnu-f1>
References: <1389286573-8986-1-git-send-email-szymon.janc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389286573-8986-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Jan 09, 2014, Szymon Janc wrote:
> read/write_watch_destroy is be called after io_set_read/write_handler
> exits. This was resulting in io destroy callback being NULLem before
> destroy was called resulting in io destroy not being called at all.
> 
> Fix this by assigning destroy callback only if setting non-NULL
> callback. destroy_watch will clean it when called.
> 
> Fix following valgrind report:
> 
> 168 (120 direct, 48 indirect) bytes in 1 blocks are definitely lost in
>        loss record 34 of 36
>    at 0x4C2C494: calloc (in /usr/lib/valgrind/
>        vgpreload_memcheck-amd64-linux.so)
>    by 0x409BAE: mgmt_new (mgmt.c:372)
>    by 0x409D05: mgmt_new_default (mgmt.c:469)
>    by 0x40E100: test_pre_setup (android-tester.c:371)
>    by 0x40AD84: start_tester (tester.c:586)
>    by 0x4E7C3B5: g_main_context_dispatch (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x4E7C707: ??? (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
>    by 0x4E7CB09: g_main_loop_run (in /lib/x86_64-linux-gnu/
>        libglib-2.0.so.0.3800.1)
>    by 0x40B76C: tester_run (tester.c:784)
>    by 0x4034F4: main (android-tester.c:2127)
> ---
>  src/shared/io-glib.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied. Thanks.

Johan
