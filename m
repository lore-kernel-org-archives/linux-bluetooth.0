Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH v4 1/2] Bluetooth: Use HCI request for LE connection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1381231278-20534-1-git-send-email-andre.guedes@openbossa.org>
Date: Thu, 10 Oct 2013 10:31:29 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <0AEB24A8-B18E-4107-AD06-DD25534ACC83@holtmann.org>
References: <1381231278-20534-1-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch introduces a new helper, which uses the HCI request
> framework, for creating LE connectons. All the handling is now
> done by this function so we can remove the hci_cs_le_create_conn()
> event handler.
> 
> This patch also removes the old hci_le_create_connection() since
> it is not used anymore.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> net/bluetooth/hci_conn.c  | 91 ++++++++++++++++++++++++++++++++++-------------
> net/bluetooth/hci_event.c | 31 ----------------
> 2 files changed, 67 insertions(+), 55 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

