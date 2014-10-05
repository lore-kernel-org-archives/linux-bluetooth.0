Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH bluetooth-next 0/2] mac802154: ieee802154: typo and routing fixes
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1412533392-4072-1-git-send-email-alex.aring@gmail.com>
Date: Sun, 5 Oct 2014 21:07:45 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	linux-wpan@vger.kernel.org, kernel@pengutronix.de
Message-Id: <2CDEF1A8-BB53-4EC3-A1FC-A77B28001264@holtmann.org>
References: <1412533392-4072-1-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-wpan-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> this patches series contains a tirivial typo in mac802154 Kconfig entry and
> drop PACKET_OTHERHOST skb's before parsing 6lowpan header.
> 
> - Alex
> 
> Julien Catalano (1):
>  trivial: net/mac802154: Fix Kconfig typo
> 
> Simon Vincent (1):
>  ieee802154: 6lowpan: Drop PACKET_OTHERHOST skbs in 6lowpan
> 
> net/ieee802154/6lowpan_rtnl.c | 3 +++
> net/mac802154/Kconfig         | 2 +-
> 2 files changed, 4 insertions(+), 1 deletion(-)

both patches have been applied to bluetooth-next tree.

Regards

Marcel

