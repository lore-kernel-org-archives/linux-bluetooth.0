Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Expire RPA if encryption fails
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1410412595-12157-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 10 Sep 2014 22:34:04 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <54D159C8-A048-422B-AC58-6EF5B64177B2@holtmann.org>
References: <1410412595-12157-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If encryption fails and we're using an RPA it may be because of a
> conflict with another device. To avoid repeated failures the safest
> action is to simply mark the RPA as expired so that a new one gets
> generated as soon as the connection drops.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

