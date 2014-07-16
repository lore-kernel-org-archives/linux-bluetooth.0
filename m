Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/3] Bluetooth: Track number of LE slave connections
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405500969-17578-2-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 16 Jul 2014 12:01:17 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6FC59D32-C527-48C8-8D67-8068B17550AA@holtmann.org>
References: <1405500969-17578-1-git-send-email-johan.hedberg@gmail.com> <1405500969-17578-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Most (probably all) controllers can only deal with a single slave LE
> connection at a time. This patch adds a counter for such connections so
> that the number can be quickly looked up without iterating the
> connections list.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

