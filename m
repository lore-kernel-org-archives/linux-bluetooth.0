Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH 06/11] Bluetooth: Introduce new hci_req_cmd function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362391748-21653-7-git-send-email-johan.hedberg@gmail.com>
Date: Mon, 4 Mar 2013 11:06:47 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <1FE9A64A-4DC5-4C74-A335-E274CE62CEDE@holtmann.org>
References: <1362391748-21653-1-git-send-email-johan.hedberg@gmail.com> <1362391748-21653-7-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This function is analogous to hci_send_cmd() but instead of directly
> queuing the command to hdev->cmd_q it adds it to the local queue of the
> asynchronous HCI request being build (inside struct hci_request).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |    1 +
> net/bluetooth/hci_core.c         |   22 ++++++++++++++++++++++
> 2 files changed, 23 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 7191217..1a75d2a 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1048,6 +1048,7 @@ struct hci_request {
> 
> void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
> int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
> +int hci_req_cmd(struct hci_request *req, u16 opcode, u32 plen, void *param);

this is a nitpick, but maybe hci_req_add or hci_req_append is a better name. The combination of req_cmd looks a bit weird to me.

Regards

Marcel

