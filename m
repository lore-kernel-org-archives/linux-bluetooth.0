Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix always checking the blacklist for incoming connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405516761-20590-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Jul 2014 15:26:13 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <B3EB78BF-B6CE-4DC7-855A-E00C2CF18874@holtmann.org>
References: <1405516761-20590-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> We should check the blacklist no matter what, meaning also when we're
> not connectable. This patch fixes the respective logic in the function
> making the decision whether to accept a connection or not.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 23 +++++++++++------------
> 1 file changed, 11 insertions(+), 12 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

