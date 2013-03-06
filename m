Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH 1/7] Bluetooth: Add hci_req_cleanup function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362597059-4102-2-git-send-email-andre.guedes@openbossa.org>
Date: Wed, 6 Mar 2013 12:12:42 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <CB305AD9-31B5-41EB-8DCF-6F5877BAAA0F@holtmann.org>
References: <1362597059-4102-1-git-send-email-andre.guedes@openbossa.org> <1362597059-4102-2-git-send-email-andre.guedes@openbossa.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch adds the hci_req_cleanup function which basically frees
> all HCI commands queued on a given request.
> 
> This function must be called in case something goes wrong during HCI
> request creation. Otherwise, HCI commands already queued on req->cmd_q
> will cause memory leaks.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
> include/net/bluetooth/hci_core.h | 1 +
> net/bluetooth/hci_core.c         | 5 +++++
> 2 files changed, 6 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 3a9cbf2..494f8f5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1045,6 +1045,7 @@ struct hci_request {
> };
> 
> void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
> +void hci_req_cleanup(struct hci_request *req);
> int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
> int hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param);
> void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index b6d44a2..7635c2e 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2443,6 +2443,11 @@ void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
> 	req->hdev = hdev;
> }
> 
> +void hci_req_cleanup(struct hci_request *req)
> +{
> +	skb_queue_purge(&req->cmd_q);
> +}
> +
> int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
> {
> 	struct hci_dev *hdev = req->hdev;

since the other one is called hci_req_run, then this should be named hci_req_abort or hci_req_cancel.

Regards

Marcel

