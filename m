Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/2] Bluetooth: Fix setting STOPPING state for discovery
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1404824706-1057-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 8 Jul 2014 15:12:43 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <AC4FB5F4-E3AF-41F7-BE76-F1BE2C8E1705@holtmann.org>
References: <1404824706-1057-1-git-send-email-johan.hedberg@gmail.com> <1404824706-1057-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> If any of the HCI commands from the hci_stop_discovery function were
> successfully sent we need to set the discovery state to STOPPING. The
> Stop Discovery code was already handling this, but the code in
> clean_up_hci_state was not. This patch updates the hci_stop_discovery to
> return a bool to indicate whether it queued any commands and the
> clean_up_hci_state() function respectively to look at the return value
> and call hci_discovery_set_state() if necessary.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/mgmt.c | 25 ++++++++++++++++++-------
> 1 file changed, 18 insertions(+), 7 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

