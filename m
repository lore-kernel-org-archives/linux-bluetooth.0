Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3094\))
Subject: Re: [PATCH bluetooth-next 0/6] 6lowpan: iphc defines and rework tc and flow label handling
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
Date: Tue, 20 Oct 2015 10:06:09 +0200
Cc: linux-wpan@vger.kernel.org, kernel@pengutronix.de,
	linux-bluetooth@vger.kernel.org, jukka.rissanen@linux.intel.com
Message-Id: <49979CD2-52AD-4767-BC4D-A310386D3C2F@holtmann.org>
References: <1445322686-2952-1-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> this patch series based on my previous series "[PATCH bluetooth-next 1/6]
> mac802154: llsec: use kzfree" and contains changes for iphc defines and
> reworking the tc/flow label handling.
> 
> I tested the tc/flow label handling with fakelb and wireshark. So it should
> be wrong, when wireshark is wrong also. I hope wireshark has some correct
> mechanism to handle it. I used "wireshark 1.12.7".
> 
> - Alex
> 
> Alexander Aring (6):
>  6lowpan: nhc: move iphc manipulation out of nhc
>  6lowpan: move IPHC functionality defines
>  6lowpan: remove lowpan_is_addr_broadcast
>  6lowpan: iphc: change define values
>  6lowpan: rework tc and flow label handling
>  6lowpan: put mcast compression in an own function
> 
> include/net/6lowpan.h       | 133 -----------
> net/6lowpan/iphc.c          | 565 +++++++++++++++++++++++++++++++-------------
> net/6lowpan/nhc.c           |  13 +-
> net/6lowpan/nhc.h           |   9 +-
> net/6lowpan/nhc_udp.c       |  22 +-
> net/ieee802154/6lowpan/tx.c |   5 +-
> 6 files changed, 430 insertions(+), 317 deletions(-)

all 6 patches have been applied to bluetooth-next tree.

Regards

Marcel

