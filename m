Return-Path: <cyrus@holtmann.org>
Date: Fri, 4 Jul 2014 16:21:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] monitor: Fix possible resource leak
Message-ID: <20140704132144.GA8955@t440s.lan>
References: <1404477938-15036-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1404477938-15036-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Jul 04, 2014, Andrei Emeltchenko wrote:
> This fixes following memory leak:
> ...
> ==14887== 24 bytes in 1 blocks are definitely lost in loss record 2 of 4
> ==14887==    at 0x4C2CC70: calloc (in
> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
> ==14887==    by 0x425B6C: btsnoop_open (btsnoop.c:83)
> ==14887==    by 0x424837: analyze_trace (analyze.c:262)
> ==14887==    by 0x40249A: main (main.c:189)
> ...
> ---
>  monitor/analyze.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

Johan
