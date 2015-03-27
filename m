Return-Path: <cyrus@holtmann.org>
Date: Fri, 27 Mar 2015 07:36:01 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] tools/btmgmt: Fix crash in interactive mode
Message-ID: <20150327053601.GA23428@t440s.P-661HNU-F1>
References: <1427407164-20354-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427407164-20354-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

On Thu, Mar 26, 2015, Lukasz Rymanowski wrote:
> Optind needs to be reset to 0 so getopt_long do reinitialization on new
> parsing. Otherwise we got crash:
> 
> [hci1]# find --help
> Usage: find [-l|-b]>
> [hci1]# find --help
> ==16382== Invalid read of size 1
> ==16382==    at 0x513CA96: _getopt_internal_r (getopt.c:429)
> ==16382==    by 0x513DBFA: _getopt_internal (getopt.c:1177)
> ==16382==    by 0x513DC82: getopt_long (getopt1.c:66)
> ==16382==    by 0x406721: cmd_find (btmgmt.c:2111)
> ==16382==    by 0x40C712: rl_handler (btmgmt.c:4275)
> ==16382==    by 0x4E5A727: rl_callback_read_char (in
> /lib/x86_64-linux-gnu/libreadline.so.6.2)
> ==16382==    by 0x402ED8: prompt_read (btmgmt.c:4340)
> ==16382==    by 0x41D117: io_callback (io-mainloop.c:123)
> ==16382==    by 0x41D9F3: mainloop_run (mainloop.c:157)
> ==16382==    by 0x4026C2: main (btmgmt.c:4427)
> ==16382==  Address 0x567e576 is 6 bytes inside a block of size 101
> free'd
> ==16382==    at 0x4C2A82E: free (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==16382==    by 0x5158DE8: wordfree (wordexp.c:2235)
> ==16382==    by 0x40C71A: rl_handler (btmgmt.c:4304)
> ==16382==    by 0x4E5A727: rl_callback_read_char (in
> /lib/x86_64-linux-gnu/libreadline.so.6.2)
> ==16382==    by 0x402ED8: prompt_read (btmgmt.c:4340)
> ==16382==    by 0x41D117: io_callback (io-mainloop.c:123)
> ==16382==    by 0x41D9F3: mainloop_run (mainloop.c:157)
> ==16382==    by 0x4026C2: main (btmgmt.c:4427)
> ==16382==
> ---
>  tools/btmgmt.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Applied. Thanks.

Johan
