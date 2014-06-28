Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 3/3] Bluetooth: Add support for Get Clock Info mgmt command
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403967247-15728-3-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 28 Jun 2014 18:55:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <860092CB-33D8-4C8A-9D62-8EFB9CE21A15@holtmann.org>
References: <1403967247-15728-1-git-send-email-johan.hedberg@gmail.com> <1403967247-15728-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch implements support for the Get Clock Information mgmt
> command. This is done by performing one or two HCI_Read_Clock commands
> and creating the response from the stored values in the hci_dev and
> hci_conn structs.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/mgmt.h |  12 ++++
> net/bluetooth/mgmt.c         | 145 +++++++++++++++++++++++++++++++++++++++++++
> 2 files changed, 157 insertions(+)

patch has been applied to bluetooth-next tree.

However I replaced hci_conn_put with hci_conn_drop to get the reference counting right. Otherwise your kernel will actually oops eventually.

Regards

Marcel

