Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/2] Bluetooth: Pass desired connection role to hci_connect_le()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404734548-3380-2-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 7 Jul 2014 15:21:03 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0FB01297-396A-4DCA-A65B-5D3BB29F6DC9@holtmann.org>
References: <1404734548-3380-1-git-send-email-johan.hedberg@gmail.com> <1404734548-3380-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If we have both LE scanning and advertising simultaneously enabled we
> need a way to tell hci_connect_le() in which role to initiate a
> connection. This patch adds a new parameter to the function to give it
> the necessary information. For auto-connect and mgmt_pair_device we
> always use master role, whereas for L2CAP users (in practice sockets) we
> use slave role whenever HCI_ADVERTISING is set and master role
> otherwise.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 3 ++-
> net/bluetooth/hci_conn.c         | 6 ++++--
> net/bluetooth/hci_event.c        | 3 ++-
> net/bluetooth/l2cap_core.c       | 6 +++++-
> net/bluetooth/mgmt.c             | 3 ++-
> 5 files changed, 15 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

