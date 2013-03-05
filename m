Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v2 07/11] Bluetooth: Introduce a hci_req_from_skb function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1362472150-30965-8-git-send-email-johan.hedberg@gmail.com>
Date: Tue, 5 Mar 2013 09:04:24 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2B575A96-C37D-42FF-ABE6-76051D97CA31@holtmann.org>
References: <1362472150-30965-1-git-send-email-johan.hedberg@gmail.com> <1362472150-30965-8-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> To have a consistent content for hdev->cmd_q all entries need to follow
> the semantics of asynchronous HCI requests. This means that even single
> commands need to be dressed as requests. This patch introduces a new
> function to create a single-command request and converts the two places
> needing this (hci_send_cmd and hci_sock_sendmsg) to use it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |    1 +
> net/bluetooth/hci_core.c         |   10 ++++++++--
> net/bluetooth/hci_sock.c         |    3 +--
> 3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 67fe661..a5a865d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1049,6 +1049,7 @@ struct hci_request {
> void hci_req_init(struct hci_request *req, struct hci_dev *hdev);
> int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
> int hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param);
> +void hci_req_from_skb(struct hci_dev *hdev, struct sk_buff *skb);
> 
> int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
> void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 0f2a0bf..382642d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2469,6 +2469,13 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete)
> 	return 0;
> }
> 
> +void hci_req_from_skb(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +	bt_cb(skb)->req.start = true;
> +	skb_queue_tail(&hdev->cmd_q, skb);
> +	queue_work(hdev->workqueue, &hdev->cmd_work);
> +}
> +
> static struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode,
> 				       u32 plen, void *param)
> {
> @@ -2511,8 +2518,7 @@ int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param)
> 	if (test_bit(HCI_INIT, &hdev->flags))
> 		hdev->init_last_cmd = opcode;
> 
> -	skb_queue_tail(&hdev->cmd_q, skb);
> -	queue_work(hdev->workqueue, &hdev->cmd_work);
> +	hci_req_from_skb(hdev, skb);
> 
> 	return 0;
> }
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 20c92de..18cb4f3 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -859,8 +859,7 @@ static int hci_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
> 			skb_queue_tail(&hdev->raw_q, skb);
> 			queue_work(hdev->workqueue, &hdev->tx_work);
> 		} else {
> -			skb_queue_tail(&hdev->cmd_q, skb);
> -			queue_work(hdev->workqueue, &hdev->cmd_work);
> +			hci_req_from_skb(hdev, skb);
> 		}
> 	} else {
> 		if (!capable(CAP_NET_RAW)) {

I would actually prefer if we have less public functions. So do we really need the hci_req_from_skb() here or could we just inline it into the two locations and add a small comment that this is a request?

Regards

Marcel

