Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 0/3] Bluetooth: LE Advertising fixes & improvements
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1380967266-28782-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 5 Oct 2013 12:04:41 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C57EDE89-A261-49E9-AEC2-A000FE2B8C27@holtmann.org>
References: <1380967266-28782-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> Here's a patch set to improve and fix LE advertising behavior. The first
> one renames the used flag to something more appropriate, and the two
> other ones fix advertising re-enablement due to the automatic disabling
> that controllers do when they get a new connection.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (3):
>      Bluetooth: Rename HCI_LE_PERIPHERAL to HCI_ADVERTISING
>      Bluetooth: Add public mgmt function to send New Settings event
>      Bluetooth: Fix re-enabling advertising after a connection
> 
> include/net/bluetooth/hci.h      |  2 +-
> include/net/bluetooth/hci_core.h |  1 +
> net/bluetooth/hci_conn.c         |  2 +-
> net/bluetooth/hci_core.c         |  2 +-
> net/bluetooth/hci_event.c        | 57 +++++++++++++++++++++++++++++++++++++---
> net/bluetooth/mgmt.c             | 23 +++++++++-------
> 6 files changed, 71 insertions(+), 16 deletions(-)

all 3 patches have been applied to bluetooth-next tree.

Regards

Marcel

