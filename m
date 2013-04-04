Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH 2/2] Bluetooth: Add __hci_cmd_sync() helper function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1364997166-24236-3-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 4 Apr 2013 00:14:20 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <A819DB7F-5E04-4E5F-A150-CB31B08CFB1A@holtmann.org>
References: <1364997166-24236-1-git-send-email-johan.hedberg@gmail.com> <1364997166-24236-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds a helper function for sending a single HCI command
> waiting for its completion and then returning back the parameters in the
> resulting command complete event (if there was one).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |    3 ++
> net/bluetooth/hci_core.c         |   93 ++++++++++++++++++++++++++++++++++++++
> 2 files changed, 96 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 0a1cb19..064b057 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1057,6 +1057,9 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
> void hci_req_add(struct hci_request *req, u16 opcode, u32 plen, void *param);
> void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status);
> 
> +struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
> +			       void *param, u32 timeout);
> +
> int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
> void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
> void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 7008b4d..689c959 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -79,6 +79,99 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
> 	}
> }
> 
> +struct sk_buff *hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode)
> +{
> +	struct hci_ev_cmd_complete *ev;
> +	struct hci_event_hdr *hdr;
> +	struct sk_buff *skb;
> +
> +	hci_dev_lock(hdev);
> +
> +	if (hdev->recv_evt)
> +		skb = skb_clone(hdev->recv_evt, GFP_KERNEL);

why are we cloning this again. Can we not just return recv_evt and set it to NULL afterwards.

> +	else
> +		skb = NULL;
> +
> +	hci_dev_unlock(hdev);
> +
> +	if (!skb)
> +		return ERR_PTR(-ENODATA);
> +
> +	hdr = (void *) skb->data;
> +	skb_pull(skb, HCI_EVENT_HDR_SIZE);
> +
> +	if (hdr->evt != HCI_EV_CMD_COMPLETE) {
> +		BT_DBG("Last event is not cmd complete (0x%2.2x)", hdr->evt);
> +		goto failed;
> +	}
> +
> +	ev = (void *) skb->data;
> +	skb_pull(skb, sizeof(*ev));

Don't you think we should add some sanity length checks here.

> +
> +	if (opcode == __le16_to_cpu(ev->opcode))
> +		return skb;
> +
> +	BT_DBG("opcode doesn't match (0x%2.2x != 0x%2.2x)", opcode,
> +	       __le16_to_cpu(ev->opcode));
> +
> +failed:
> +	kfree_skb(skb);
> +	return ERR_PTR(-ENODATA);
> +}
> +
> +struct sk_buff *__hci_cmd_sync(struct hci_dev *hdev, u16 opcode, u32 plen,
> +			       void *param, u32 timeout)
> +{
> +	DECLARE_WAITQUEUE(wait, current);
> +	struct hci_request req;
> +	int err = 0;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	hci_req_init(&req, hdev);
> +
> +	hci_req_add(&req, opcode, plen, param);
> +
> +	hdev->req_status = HCI_REQ_PEND;
> +
> +	err = hci_req_run(&req, hci_req_sync_complete);
> +	if (err < 0)
> +		return ERR_PTR(err);
> +
> +	add_wait_queue(&hdev->req_wait_q, &wait);
> +	set_current_state(TASK_INTERRUPTIBLE);
> +
> +	schedule_timeout(timeout);
> +
> +	remove_wait_queue(&hdev->req_wait_q, &wait);
> +
> +	if (signal_pending(current))
> +		return ERR_PTR(-EINTR);
> +
> +	switch (hdev->req_status) {
> +	case HCI_REQ_DONE:
> +		err = -bt_to_errno(hdev->req_result);
> +		break;
> +
> +	case HCI_REQ_CANCELED:
> +		err = -hdev->req_result;
> +		break;
> +
> +	default:
> +		err = -ETIMEDOUT;
> +		break;
> +	}
> +
> +	hdev->req_status = hdev->req_result = 0;
> +
> +	BT_DBG("%s end: err %d", hdev->name, err);
> +
> +	if (err < 0)
> +		return ERR_PTR(err);
> +
> +	return hci_get_cmd_complete(hdev, opcode);
> +}
> +
> /* Execute request and wait for completion. */
> static int __hci_req_sync(struct hci_dev *hdev,
> 			  void (*func)(struct hci_request *req,

Regards

Marcel

