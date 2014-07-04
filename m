Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Don't take actions on blocked devices when scanning
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404479749-7816-1-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 4 Jul 2014 15:56:31 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0708E38A-624D-4B17-AC9E-554A500188AF@holtmann.org>
References: <1404479749-7816-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If a found device is marked as blocked while doing passive LE scanning,
> neither report it nor try to connect to it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 4 ++++
> 1 file changed, 4 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

