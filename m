Return-Path: <cyrus@holtmann.org>
Date: Mon, 11 Aug 2014 16:25:44 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 02/10] monitor: Handle default switch case
Message-ID: <20140811132544.GA28382@t440s>
References: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1407743445-1329-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1407743445-1329-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Aug 11, 2014, Andrei Emeltchenko wrote:
> Fixes issues with junk packets.
> ---
>  monitor/analyze.c | 3 +++
>  1 file changed, 3 insertions(+)

This one doesn't apply cleanly. Please rebase and resend:

Applying: monitor: Handle default switch case
error: patch failed: monitor/analyze.c:339
error: monitor/analyze.c: patch does not apply
Patch failed at 0001 monitor: Handle default switch case

Johan
