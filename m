Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH v2 2/4] Bluetooth: Add __hci_cmd_sync() helper function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1365062347-860-3-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 4 Apr 2013 08:27:05 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <8A2CF36D-1BFF-4365-A8B1-935EB0CBBF21@holtmann.org>
References: <1365062347-860-1-git-send-email-johan.hedberg@gmail.com> <1365062347-860-3-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds a helper function for sending a single HCI command
> waiting for its completion and then returning back the parameters in the
> resulting command complete event (if there was one).
> 
> The implementation is very similar to that of hci_req_sync() except that
> instead of invocing a callback for sending HCI commands the function
> constructs and sends one itself and after being woken up picks the last
> received event from hdev->recv_evt (if it matches the right criteria)
> and returns it.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |    3 ++
> net/bluetooth/hci_core.c         |   96 ++++++++++++++++++++++++++++++++++++++
> 2 files changed, 99 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index beae2e8..38b653d 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1056,6 +1056,9 @@ int hci_req_run(struct hci_request *req, hci_req_complete_t complete);
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
> index 6739cce..d0c12c0 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -79,6 +79,102 @@ static void hci_req_cancel(struct hci_dev *hdev, int err)
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
> +	skb = hdev->recv_evt;
> +	hdev->recv_evt = NULL;
> +
> +	hci_dev_unlock(hdev);
> +
> +	if (!skb)
> +		return ERR_PTR(-ENODATA);
> +
> +	hdr = (void *) skb->data;
> +	skb_pull(skb, HCI_EVENT_HDR_SIZE);

do we check the event header length earlier and can rely on that it is valid? If not, then lets add another sanity check here.

Otherwise this patch looks fine to me.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel

