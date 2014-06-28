Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH 2/3] Bluetooth: Add tracking of local and piconet clock values
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1403967247-15728-2-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 28 Jun 2014 18:54:49 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A2652086-7744-455D-B78A-144677E2C699@holtmann.org>
References: <1403967247-15728-1-git-send-email-johan.hedberg@gmail.com> <1403967247-15728-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds support for storing the local and piconet clock values
> from the HCI_Read_Clock command response to the hci_dev and hci_conn
> structs. This will be later used in another patch to implement support
> for the Get Clock Info mgmt command.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci.h      | 12 ++++++++++++
> include/net/bluetooth/hci_core.h |  4 ++++
> net/bluetooth/hci_event.c        | 39 +++++++++++++++++++++++++++++++++++++++
> 3 files changed, 55 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

