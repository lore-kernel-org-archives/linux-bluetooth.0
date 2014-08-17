Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/4] Bluetooth: Fix hci_conn reference counting with hci_chan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1408311704-31747-2-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 17 Aug 2014 17:15:22 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C0B3F46F-3881-405F-86FE-585B89220570@holtmann.org>
References: <1408311704-31747-1-git-send-email-johan.hedberg@gmail.com> <1408311704-31747-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The hci_chan_del() function was doing a hci_conn_drop() but there was no
> matching hci_conn_hold() in the hci_chan_create() function. Furthermore,
> as the hci_chan struct holds a pointer to the hci_conn there should be
> proper use of hci_conn_get/put. This patch fixes both issues so that
> hci_chan does correct reference counting of the hci_conn object.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_conn.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

