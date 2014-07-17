Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/3] Bluetooth: Introduce a flag to track who really initiates authentication
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405600540-28292-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 17 Jul 2014 14:42:19 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <58568DCB-708E-45F5-B681-2AE9794FF8CC@holtmann.org>
References: <1405600540-28292-1-git-send-email-johan.hedberg@gmail.com> <1405600540-28292-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Even though our side requests authentication, the original action that
> caused it may be remotely triggered, such as an incoming L2CAP or RFCOMM
> connect request. To track this information introduce a new hci_conn flag
> called HCI_CONN_AUTH_INITIATOR.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 1 +
> net/bluetooth/hci_conn.c         | 3 +++
> net/bluetooth/hci_event.c        | 5 +++++
> 3 files changed, 9 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

