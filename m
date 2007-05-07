Return-Path: <linux-kernel-owner+marcel=40holtmann.org-S1754015AbXEGFZN@vger.kernel.org>
Date: Mon, 7 May 2007 07:25:10 +0200
From: Adrian Bunk <bunk@stusta.de>
To: CIJOML <cijoml@volny.cz>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
        linux-kernel@vger.kernel.org, marcel@holtmann.de,
        bluez-users@lists.sourceforge.net
Subject: Re: OOPS when swsusp/resume when connected to the internet via BT
	and GPRS
Message-ID: <20070507052510.GA4226@stusta.de>
References: <200705070005.33834.cijoml@volny.cz> <6bffcb0e0705061534l4cdd2496w8e2e2a0606f17f2e@mail.gmail.com> <200705070704.30361.cijoml@volny.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <200705070704.30361.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <bluez-users.lists.sourceforge.net>

On Mon, May 07, 2007 at 07:04:29AM +0200, CIJOML wrote:
> Hi Michal,
> 
> my kernel is tainted with madwifi opensource driver :). Only binary part is 
> ath_hal module, which doesn't have anythink to do with this part of kernel.

Any module can change any part of the kernel, e.g. a part of the code 
executed when loading the ath_hal module could accidentally corrupt a 
kernel data structure.

> Ath_hal is doing RF part of card to protect others tune/transmit in other 
> frequency than 2.5/5.8GHz (Wifi 802.11a/b/g).
> 
> My kernel is 100% opensource :)

That's wrong, the binary-only blob from ath_hal loaded into your kernel 
is not opensource.

> And BTW this happens also with madwifi kernel modules unloaded.

An Oops without any external module ever loaded since booting is 
strongly preferred.

> Best regards
> 
> Michal

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

