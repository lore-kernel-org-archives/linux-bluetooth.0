Return-Path: <cyrus@holtmann.org>
Date: Mon, 7 May 2012 11:35:05 -0700
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] hcidump: Process A2MP Assoc Rsp
Message-ID: <20120507183505.GC7230@x220.hpllc.com>
References: <1336398567-27842-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1336398567-27842-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336398567-27842-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, May 07, 2012, Andrei Emeltchenko wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> ---
>  lib/a2mp.h     |   38 +++++++++++++++++++++
>  parser/l2cap.c |  100 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
>  2 files changed, 130 insertions(+), 8 deletions(-)

I can't apply this since it wont apply to bluez.git (bluez lib/ should
stay in sync with hcidump). Please split this into two patches.

Johan
