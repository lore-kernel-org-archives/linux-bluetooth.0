Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v2 1/4] Bluetooth: Track received events in hdev
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1365062347-860-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 4 Apr 2013 08:24:20 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AA9A658E-8C32-415B-AEA9-6E343AD66476@holtmann.org>
References: <1365062347-860-1-git-send-email-johan.hedberg@gmail.com> <1365062347-860-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds tracking of received HCI events to the hci_dev struct.
> This is necessary so that a subsequent patch can implement a function
> for sending a single command synchronously and returning the resulting
> command complete parameters in the function return value.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |    1 +
> net/bluetooth/hci_core.c         |    3 +++
> net/bluetooth/hci_event.c        |   12 ++++++++++++
> 3 files changed, 16 insertions(+)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

