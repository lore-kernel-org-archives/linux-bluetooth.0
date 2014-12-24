Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2] Bluetooth: Fix accepting connections when not using mgmt
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1419446591-22129-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 24 Dec 2014 11:03:34 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DBDEB65A-C9BB-4C8F-B09A-EAF0B6417C25@holtmann.org>
References: <1419446591-22129-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When connectable mode is enabled (page scan on) through some non-mgmt
> method the HCI_CONNECTABLE flag will not be set. For backwards
> compatibility with user space versions not using mgmt we should not
> require HCI_CONNECTABLE to be set if HCI_MGMT is not set.
> 
> Reported-and-tested-by: Pali Rohár <pali.rohar@gmail.com>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> Cc: stable@vger.kernel.org # 3.17+
> ---
> v2: Add clarifying code comment
> 
> net/bluetooth/hci_event.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)

patch has been applied bluetooth tree.

Regards

Marcel

