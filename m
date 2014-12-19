Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH 2/2] Bluetooth: Split hci_request helpers to hci_request.[ch]
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1418989220-4066-2-git-send-email-johan.hedberg@gmail.com>
Date: Fri, 19 Dec 2014 13:06:13 +0100
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6603E83E-8851-4325-99F8-F3326BA7CAAE@holtmann.org>
References: <1418989220-4066-1-git-send-email-johan.hedberg@gmail.com> <1418989220-4066-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> None of the hci_request related things in net/bluetooth/hci_core.h are
> needed anywhere outside of the core bluetooth module. This patch creates
> a new net/bluetooth/hci_request.c file with its corresponding h-file and
> moves the functionality there from hci_core.c and hci_core.h.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  25 ---
> net/bluetooth/Makefile           |   2 +-
> net/bluetooth/hci_conn.c         |   1 +
> net/bluetooth/hci_core.c         | 370 +-----------------------------------
> net/bluetooth/hci_event.c        |   1 +
> net/bluetooth/hci_request.c      | 397 +++++++++++++++++++++++++++++++++++++++
> net/bluetooth/hci_request.h      |  51 +++++
> net/bluetooth/mgmt.c             |   1 +
> 8 files changed, 453 insertions(+), 395 deletions(-)
> create mode 100644 net/bluetooth/hci_request.c
> create mode 100644 net/bluetooth/hci_request.h

patch has been applied to bluetooth-next tree.

Regards

Marcel

