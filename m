Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2 00/10] Bluetooth: Connection parameter support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 2 Jul 2014 17:00:57 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <DA664E45-45BE-49D4-9982-D05CB9FC4572@holtmann.org>
References: <1404311854-12233-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's a v2 of my set with off-list feedback taken into account.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (10):
>      Bluetooth: Rename hci_conn_params_clear to hci_conn_params_clear_all
>      Bluetooth: Add specific connection parameter clear functions
>      Bluetooth: Add new auto_conn value matching mgmt action 0x00
>      Bluetooth: Remove only enabled entries with Remove Device command
>      Bluetooth: Add Load Connection Parameters command
>      Bluetooth: Fix missing update of conn params
>      Bluetooth: Make hci_le_conn_update return the store hint
>      Bluetooth: Pass store hint to mgmt_new_conn_param
>      Bluetooth: Make is_identity_address a global function
>      Bluetooth: Don't send connection parameters without identity address
> 
> include/net/bluetooth/hci_core.h |  25 ++++++--
> include/net/bluetooth/mgmt.h     |  15 +++++
> net/bluetooth/hci_conn.c         |   9 ++-
> net/bluetooth/hci_core.c         |  51 ++++++++++-----
> net/bluetooth/hci_event.c        |  26 +++++++-
> net/bluetooth/l2cap_core.c       |   8 ++-
> net/bluetooth/mgmt.c             | 113 +++++++++++++++++++++++++++++++--
> 7 files changed, 214 insertions(+), 33 deletions(-)

all 10 patches have been applied to bluetooth-next tree.

Regards

Marcel

