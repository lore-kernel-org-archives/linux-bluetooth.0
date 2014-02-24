Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [PATCH 0/7] Bluetooth: Graceful power off procedure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 24 Feb 2014 11:12:33 -0800
Cc: "bluez mailin list (linux-bluetooth@vger.kernel.org)"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <8E5054F8-6301-4515-AF7E-FF561E009728@holtmann.org>
References: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This set of patches updates the power off procedure (as triggered
> through mgmt) to perform a graceful power off by first cleaning up HCI
> state such as connections, scan modes and advertising before requesting
> the HCI driver to actually power off.
> 
> Johan
> 
> ----------------------------------------------------------------
> Johan Hedberg (7):
>      Bluetooth: Add convenience function for getting total connection count
>      Bluetooth: Move HCI_ADVERTISING handling into mgmt.c
>      Bluetooth: Move check for MGMT_CONNECTED flag into mgmt.c
>      Bluetooth: Don't clear HCI_DISCOVERABLE when powering off
>      Bluetooth: Don't clear HCI_CONNECTABLE when powering off
>      Bluetooth: Don't clear HCI_ADVERTISING when powering off
>      Bluetooth: Clean up HCI state when doing power off
> 
> include/net/bluetooth/hci_core.h | 11 ++++-
> net/bluetooth/hci_event.c        | 15 +++---
> net/bluetooth/mgmt.c             | 96 ++++++++++++++++++++++++++++++++++--
> 3 files changed, 107 insertions(+), 15 deletions(-)

all 7 patches have been applied to bluetooth-next tree.

Regards

Marcel

