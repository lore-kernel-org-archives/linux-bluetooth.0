Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: Style fix - align block comments
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170722014707.10485-1-robsonde@gmail.com>
Date: Sat, 22 Jul 2017 08:41:05 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <2469432F-B100-4F7B-BE3E-0E0AE6FBFBD0@holtmann.org>
References: <20170722014707.10485-1-robsonde@gmail.com>
To: Derek Robson <robsonde@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Derek,

> Fixed alignment of all block comments.
> Found using checkpatch
> 
> Signed-off-by: Derek Robson <robsonde@gmail.com>
> ---
> drivers/bluetooth/ath3k.c       |  3 ++-
> drivers/bluetooth/bt3c_cs.c     |  8 +++++---
> drivers/bluetooth/btmrvl_sdio.c |  6 ++++--
> drivers/bluetooth/btsdio.c      |  3 ++-
> drivers/bluetooth/btuart_cs.c   |  8 +++++---
> drivers/bluetooth/btusb.c       | 15 ++++++++++-----
> drivers/bluetooth/btwilink.c    |  6 +++---
> drivers/bluetooth/hci_ldisc.c   |  3 ++-
> drivers/bluetooth/hci_ll.c      |  3 ++-
> 9 files changed, 35 insertions(+), 20 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
