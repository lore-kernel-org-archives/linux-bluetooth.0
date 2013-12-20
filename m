Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Dec 2013 12:20:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcin Kraglak <marcin.kraglak@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2] tools/l2cap-tester: Fix memory leak
Message-ID: <20131220102036.GA21469@x220.p-661hnu-f1>
References: <1387531829-31079-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1387531829-31079-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcin,

On Fri, Dec 20, 2013, Marcin Kraglak wrote:
> Set close_on_unref on new created GIOChannel and don't close
> its file descriptor.
> 
> 126 (120 direct, 6 indirect) bytes in 1 blocks aredefinitely
> 	lost in loss record 24 of 28
> at 0x4A06409: malloc (in/usr/lib64/valgrind/vgpreload_memcheck
> 	-amd64-linux.so)
> by 0x3C9564D88E: g_malloc (in /usr/lib64/libglib-2.0.so.0.3600.3)
> by 0x3C956881F4: g_io_channel_unix_new (in/usr/lib64/libglib-
> 	2.0.so.0.3600.3)
> by 0x402A5A: l2cap_listen_cb (l2cap-tester.c:774)
> by 0x3C95647DF5: g_main_context_dispatch (in/usr/lib64/
> 	libglib-2.0.so.0.3600.3)
> by 0x3C95648147: ??? (in /usr/lib64/libglib-2.0.so.0.3600.3)
> by 0x3C95648549: g_main_loop_run
> 	(in/usr/lib64/libglib-2.0.so.0.3600.3)
> by 0x40A67C: tester_run (tester.c:784)
> by 0x4026A9: main (l2cap-tester.c:991)
> ---
>  tools/l2cap-tester.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied. Thanks.

Johan
