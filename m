Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Fix race condition with HCI_RESET flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427534256-2395-1-git-send-email-johan.hedberg@gmail.com>
Date: Sat, 28 Mar 2015 12:05:53 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <C1579699-4AD3-429C-BDDC-E633DB760FF7@holtmann.org>
References: <1427534256-2395-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> During the HCI init phase a completed request might be the last part of
> the setup procedure after which the actual init procedure starts. The
> init procedure begins with a call to hci_reset_req() which sets the
> HCI_RESET flag. The purpose of this flag is to make us ignore any
> updates to ncmd/cmd_cnt as long as we haven't received the command
> complete event for the HCI_Reset. There's a potential race with this
> however:
> 
> 	hci_req_cmd_complete(hdev, opcode, status);
> 
> 	if (ev->ncmd && !test_bit(HCI_RESET, &hdev->flags)) {
> 		atomic_set(&hdev->cmd_cnt, 1);
> 		if (!skb_queue_empty(&hdev->cmd_q))
> 			queue_work(hdev->workqueue, &hdev->cmd_work);
> 	}
> 
> Since the hci_req_cmd_complete() will trigger the completion of the
> setup stage, it's possible that hci_reset_req() gets called before we
> try to read ev->ncmd and the HCI_RESET flag. Because of this the cmd_cnt
> would never be updated and the hci_reset_req() in practice ends up
> blocking itself.
> 
> This patch fixes the issue by updating cmd_cnt before notifying the
> request completion, and then reading it again to determine whether the
> cmd_work should be queued or not.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_event.c | 20 ++++++++++----------
> 1 file changed, 10 insertions(+), 10 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

