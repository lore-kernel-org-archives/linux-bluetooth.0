Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Subject: Re: [PATCH 1/2] Bluetooth: Clean up advertising initialization in powered_update_hci()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1448875305-1347-2-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 1 Dec 2015 21:45:00 -1000
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <6FBA880E-720C-4A80-A12F-B2A87843BFB0@holtmann.org>
References: <1448875305-1347-1-git-send-email-johan.hedberg@gmail.com> <1448875305-1347-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The logic in powered_update_hci() to initialize the advertising data &
> state is a bit more complicated than it needs to be. It was previously
> not doing anything if HCI_LE_ENABLED wasn't set, but this was not
> obvious by quickly looking at the code. Now the conditions for the
> various actions are more explicit. Another simplification is due to
> the fact that __hci_req_schedule_adv_instance() takes care of setting
> hdev->cur_adv_instance so there's no need to set it before calling the
> function.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/hci_request.c | 30 ++++++++++++------------------
> 1 file changed, 12 insertions(+), 18 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

