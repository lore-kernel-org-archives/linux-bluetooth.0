Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 4/4] Bluetooth: Ignore incoming data after initiating disconnection
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1408311704-31747-4-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 17 Aug 2014 17:15:12 -0500
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F3A9ADBE-4DEE-45B9-9DD1-2E173E6F60BB@holtmann.org>
References: <1408311704-31747-1-git-send-email-johan.hedberg@gmail.com> <1408311704-31747-4-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> When hci_chan_del is called the disconnection routines get scheduled
> through a workqueue. If there's any incoming ACL data before the
> routines get executed there's a chance that a new hci_chan is created
> and the disconnection never happens. This patch adds a new hci_conn flag
> to indicate that we're in the process of driving the connection down. We
> set the flag in hci_chan_del and check for it in hci_chan_create so that
> no new channels are created for the same connection.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h | 1 +
> net/bluetooth/hci_conn.c         | 6 ++++++
> 2 files changed, 7 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

