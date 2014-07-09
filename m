Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v3 0/7] Bluetooth: White list support for BR/EDR
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404899959-16479-1-git-send-email-johan.hedberg@gmail.com>
Date: Wed, 9 Jul 2014 12:27:38 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <28524F06-BB05-4DDB-B769-A3D118FE86E9@holtmann.org>
References: <1404899959-16479-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's v3 of the set with the feedback from Marcel taken into account.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (7):
>      Bluetooth: Unify helpers for bdaddr_list manipulations
>      Bluetooth: Introduce a whitelist for BR/EDR devices
>      Bluetooth: Update page scan when necessary for Add/Remove Device
>      Bluetooth: Fix incorrectly setting HCI_CONNECTABLE
>      Bluetooth: Refactor connection request handling
>      Bluetooth: Enable page scan also if there are white list entries
>      Bluetooth: Add white list lookup for incoming connection requests
> 
> include/net/bluetooth/hci_core.h |  16 ++---
> net/bluetooth/hci_core.c         | 114 +++++++++++-------------------
> net/bluetooth/hci_event.c        | 133 ++++++++++++++++++++---------------
> net/bluetooth/hci_sock.c         |   4 +-
> net/bluetooth/l2cap_core.c       |   7 +-
> net/bluetooth/mgmt.c             | 100 ++++++++++++++++++++++++--
> 6 files changed, 223 insertions(+), 151 deletions(-)

all 7 patches have been applied to bluetooth-next tree.

Regards

Marcel

