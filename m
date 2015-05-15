Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH v5 3/4] Bluetooth: btintel: Fix calls to __hci_cmd_sync()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1431683922-20418-3-git-send-email-frederic.danis@linux.intel.com>
Date: Fri, 15 May 2015 16:06:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <91C81A21-38C3-4077-8FCC-858ED5B2C26F@holtmann.org>
References: <1431683922-20418-1-git-send-email-frederic.danis@linux.intel.com> <1431683922-20418-3-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> Remove test of command reply status as it is already performed by
> __hci_cmd_sync().
> 
> __hci_cmd_sync_ev() function already returns an error if it got a
> non-zero status either through a Command Complete or a Command
> Status event.
> 
> For both of these events the status is collected up in the event
> handlers called by hci_event_packet() and then passed as the second
> parameter to req_complete_skb(). The req_complete_skb() callback in
> turn is hci_req_sync_complete() for __hci_cmd_sync_ev() which stores
> the status in hdev->req_result. The hdev->req_result is then further
> converted through bt_to_errno() back in __hci_cmd_sync_ev().
> 
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/btintel.c | 6 ------
> 1 file changed, 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

