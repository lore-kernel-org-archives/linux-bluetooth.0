Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Subject: Re: [PATCH] Bluetooth: Fix clearing remote OOB data through mgmt
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1416036863-27634-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 15 Nov 2014 16:53:48 +0900
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1CBB3C0F-EFB6-426E-9A71-C70670657251@holtmann.org>
References: <1416036863-27634-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When passed BDADDR_ANY the Remove Remote OOB Data comand is specified to
> clear all entries. This patch adds the necessary check and calls
> hci_remote_oob_data_clear() when necessary.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

