Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH v2] Bluetooth: Fix incorrectly overriding conn->src_type
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1401959994-9611-1-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 5 Jun 2014 11:56:32 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CE991719-B34C-4598-9D85-09049E9A1A0F@holtmann.org>
References: <1401958444-6623-1-git-send-email-johan.hedberg@gmail.com> <1401959994-9611-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The src_type member of struct hci_conn should always reflect the address
> type of the src_member. It should never be overridden. There is already
> code in place in the command status handler of HCI_LE_Create_Connection
> to copy the right initiator address into conn->init_addr_type.
> 
> Without this patch, if privacy is enabled, we will send the wrong
> address type in the SMP identity address information PDU (it'll e.g.
> contain our public address but a random address type).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> v2: Reworded misleading commit message
> 
> net/bluetooth/hci_conn.c | 5 -----
> 1 file changed, 5 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

