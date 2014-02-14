Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH] Bluetooth: Officially enable LE CoC support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1392356451-14435-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 14 Feb 2014 13:15:12 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <374C1FC4-D787-4EA8-B2DA-CAB02CA2B785@holtmann.org>
References: <1392356451-14435-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Now that the LE Connection oriented Channel support has undergone a
> decent amount of testing we can make it officially supported. This patch
> removes the enable_lecoc debugfs switch which was previously needed to
> enable support for LE CoC.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/l2cap_core.c | 11 -----------
> net/bluetooth/l2cap_sock.c | 29 -----------------------------
> 2 files changed, 40 deletions(-)

I had to fix the description a bit ;)

Patch has been applied to bluetooth-next tree.

Regards

Marcel

