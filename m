Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Subject: Re: [PATCH 1/2] Bluetooth: Track received events in hdev
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1364997166-24236-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 4 Apr 2013 00:11:03 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <95E2D219-B8DF-4B91-BEEE-00CF8A42495A@holtmann.org>
References: <1364997166-24236-1-git-send-email-johan.hedberg@gmail.com> <1364997166-24236-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> This patch adds tracking of received HCI events to the hci_dev struct.
> This is necessary so that a subsequent patch can implement a function
> for sending a single command synchronously and returning the resulting
> command complete parameters in the function return value.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/hci_core.h |    2 ++
> net/bluetooth/hci_core.c         |    5 +++++
> net/bluetooth/hci_event.c        |    8 ++++++++
> 3 files changed, 15 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 88dd46e..0a1cb19 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -244,6 +244,8 @@ struct hci_dev {
> 	struct sk_buff_head	raw_q;
> 	struct sk_buff_head	cmd_q;
> 
> +	struct sk_buff		*recv_evt;
> +

loose the empty line here.

> 	struct sk_buff		*sent_cmd;
> 	struct sk_buff		*reassembly[NUM_REASSEMBLY];
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 2b488ed..7008b4d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1123,6 +1123,11 @@ static int hci_dev_do_close(struct hci_dev *hdev)
> 		hdev->sent_cmd = NULL;
> 	}
> 
> +	if (hdev->recv_evt) {
> +		kfree_skb(hdev->recv_evt);
> +		hdev->recv_evt = NULL;
> +	}
> +

Actually kfree_skb does the NULL pointer check. So you do not need that one.

> 	/* After this point our queues are empty
> 	 * and no tasks are scheduled. */
> 	hdev->close(hdev);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 7e7fbca..24906fb 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3699,6 +3699,14 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
> 	struct hci_event_hdr *hdr = (void *) skb->data;
> 	__u8 event = hdr->evt;
> 
> +	hci_dev_lock(hdev);
> +
> +	if (hdev->recv_evt)
> +		kfree_skb(hdev->recv_evt);
> +	hdev->recv_evt = skb_clone(skb, GFP_KERNEL);

Same here.

However since this actually means memory allocation for every single event we receive, can we just optimize this to be only done when we actually have a HCI request ongoing.

Regards

Marcel

