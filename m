Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Feb 2015 22:02:10 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/btmgmt: Fix crash in completion in interactive
 mode
Message-ID: <20150212200210.GA10096@t440s.P-661HNU-F1>
References: <1423758644-3122-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423758644-3122-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Thu, Feb 12, 2015, Szymon Janc wrote:
> Use separate indexes while iterating over all_cmd and interactive_cmd.
> Fix following crash:
> 
> [mgmt]# ==2224== Invalid read of size 1
> ==2224==    at 0x4A092F2: strlen (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==2224==    by 0x323C8860AD: strdup (in /usr/lib64/libc-2.18.so)
> ==2224==    by 0x323EC1D550: rl_completion_matches (in /usr/lib64/libreadline.so.6.2)
> ==2224==    by 0x402BBC: cmd_completion (btmgmt.c:3427)
> ==2224==    by 0x323EC1D608: ??? (in /usr/lib64/libreadline.so.6.2)
> ==2224==    by 0x323EC1D783: rl_complete_internal (in /usr/lib64/libreadline.so.6.2)
> ==2224==    by 0x323EC156DD: _rl_dispatch_subseq (in /usr/lib64/libreadline.so.6.2)
> ==2224==    by 0x323EC159FF: readline_internal_char (in /usr/lib64/libreadline.so.6.2)
> ==2224==    by 0x323EC2AB6C: rl_callback_read_char (in /usr/lib64/libreadline.so.6.2)
> ==2224==    by 0x4032E8: prompt_read (btmgmt.c:3551)
> ==2224==    by 0x419048: io_callback (io-mainloop.c:123)
> ==2224==    by 0x419842: mainloop_run (mainloop.c:157)
> ==2224==  Address 0x68 is not stack'd, malloc'd or (recently) free'd
> ---
>  tools/btmgmt.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

This patch has been applied. Thanks.

For your second patch I went actually in the other directions and used
NELEM() everywhere. I prefer that since it's a stronger guarantee of the
table length than having to remember to put an empty element at the end
of it.

Johan
