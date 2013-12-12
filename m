Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH bluetooth-next] 6lowpan: fix/move/cleanup debug functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1386875725-4436-1-git-send-email-alex.aring@gmail.com>
Date: Thu, 12 Dec 2013 21:16:46 +0100
Cc: linux-zigbee-devel@lists.sourceforge.net, werner@almesberger.net,
	"linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <977F4F36-7A08-4D53-8E64-B56413EA5D96@holtmann.org>
References: <1386875725-4436-1-git-send-email-alex.aring@gmail.com>
To: Alexander Aring <alex.aring@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

> There are several issues on current debug behaviour.
> This patch fix the following issues:
> 
> - Fix debug printout only if DEBUG is defined.
> - Move debug functions of 6LoWPAN code into 6lowpan header.
> - Cleanup codestyle of debug functions.
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> ---
> net/bluetooth/6lowpan.c       | 27 ---------------------------
> net/ieee802154/6lowpan.c      | 43 +++++--------------------------------------
> net/ieee802154/6lowpan.h      | 32 ++++++++++++++++++++++++++++++++
> net/ieee802154/6lowpan_iphc.c | 26 --------------------------
> 4 files changed, 37 insertions(+), 91 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

