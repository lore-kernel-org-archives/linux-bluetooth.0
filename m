Return-Path: <cyrus@holtmann.org>
Date: Wed, 19 Feb 2014 17:23:33 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] emulator/bthost: Fix command queue
Message-ID: <20140219152333.GA12683@x220.p-661hnu-f1>
References: <1392817178-15022-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392817178-15022-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Wed, Feb 19, 2014, Marcin Kraglak wrote:
> Now new commands will be pushed to tail. Queue will be consumed
> from head, firstly added commands will be sent. It repairs this
> warning from android-tester:
> ==20561== 1,904 bytes in 7 blocks are definitely
> lost in loss record 30 of 31
> ==20561==    at 0x4006AB1: malloc (in /usr/lib/valgrind/
> vgpreload_memcheck-x86-linux.so)
> ==20561==    by 0x8050293: send_command (bthost.c:389)
> ==20561==    by 0x80543E1: start_stack (hciemu.c:299)
> ==20561==    by 0x41043D00: ??? (in /usr/lib/libglib-2.0.so.0.3600.4)
> ==20561==    by 0x410470E5: g_main_context_dispatch (in
> /usr/lib/libglib-2.0.so.0.3600.4)
> ==20561==    by 0x41047497: ??? (in
> /usr/lib/libglib-2.0.so.0.3600.4)
> ==20561==    by 0x41047912: g_main_loop_run (in
> /usr/lib/libglib-2.0.so.0.3600.4)
> ==20561==    by 0x8055870: tester_run (tester.c:798)
> ==20561==    by 0x804B980: main (android-tester.c:3984)
> ---
>  emulator/bthost.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
