Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix setting HCI_CONNECTABLE from ioctl code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404901706-19308-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 9 Jul 2014 12:32:41 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F27C9142-87CE-4A6C-815F-7AA558E49C83@holtmann.org>
References: <1404901706-19308-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When the white list is in use the code would not update the
> HCI_CONNECTABLE flag if it gets changed through the ioctl code (e.g.
> hciconfig hci0 pscan). Since the flag is important for properly
> accepting incoming connections add code to fix it up if necessary and
> emit a New Settings mgmt event.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_core.c         | 17 +++++++++++++++++
> net/bluetooth/mgmt.c             |  5 +++++
> 3 files changed, 23 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

