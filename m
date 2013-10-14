Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH 0/5] Bluetooth: Clean up Set Connectable related code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381756807-14900-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 14 Oct 2013 15:46:22 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E7F808EA-BF99-4C6B-8A62-8E5BEBC859E9@holtmann.org>
References: <1381756807-14900-1-git-send-email-johan.hedberg@gmail.com>
To: johan.hedberg@gmail.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This is a set of cleanup patches (and one fix) split out from my earlier
> set. I'm hoping to get these in first to make it easier to understand
> how the code works and what the possible ways of adding LE Advertising
> hooks are.
> 
> The main thing with these patches is that we make a clear separation of
> what happens if someone uses a raw HCI socket compared to sending a Set
> Connectable command using the management interface. Now both cases have
> their clear functions for handling the HCI_CONNECTABLE flag and the
> necessary mgmt events.
> 
> ----------------------------------------------------------------
> Johan Hedberg (5):
>      Bluetooth: Reorganize set_connectable HCI command sending
>      Bluetooth: Move move logic into set_connectable complete callback
>      Bluetooth: Add missing error handling for Set Connectable
>      Bluetooth: Move static advertising functions to avoid forward declarations
>      Bluetooth: Fix updating advertising data needlessly
> 
> net/bluetooth/hci_event.c |   2 +-
> net/bluetooth/mgmt.c      | 122 ++++++++++++++++++++++++++++------------------
> 2 files changed, 75 insertions(+), 49 deletions(-)

all 5 patches have been applied to bluetooth-next tree.

Regards

Marcel

