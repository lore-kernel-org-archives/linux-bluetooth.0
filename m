Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Sep 2012 14:10:49 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH hcidump] amp: Decode Num Completed Data Blocks
Message-ID: <20120928111049.GC14450@x220>
References: <1346398640-8423-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346398640-8423-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Aug 31, 2012, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Adds decoding Number Of Completed Data Blocks Event
> 
> > HCI Event: Number Of Completed Data Blocks (0x48) plen 9
>     Total num blocks 4 Num handles 1
>       Handle 0x0001: Num complt pkts 1 Num complt blks 1
> ---
>  lib/hci.h    |   10 ++++++++++
>  parser/hci.c |   22 ++++++++++++++++++++++
>  2 files changed, 32 insertions(+)

Applied. Thanks.

Johan
