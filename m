Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH 2/2] Bluetooth: hci_uart: Fix dereferencing of ERR_PTR
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1434459321-20281-2-git-send-email-chanyeol.park@samsung.com>
Date: Tue, 16 Jun 2015 16:29:27 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <98B3DE38-46E4-44F7-8AA5-774A96C521BE@holtmann.org>
References: <1434459321-20281-1-git-send-email-chanyeol.park@samsung.com> <1434459321-20281-2-git-send-email-chanyeol.park@samsung.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

> If h4_recv() return ERR_PTR instead sk_buff pointer, it should be
> cleared once dereference is completed for the further reference such as
> h4_recv(), or h4_close().

I have no idea what the h4_close has to do with it? Can you explain.

> 
> Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
> ---
> drivers/bluetooth/hci_h4.c | 2 ++
> 1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
> index f7190f0..a8acd99 100644
> --- a/drivers/bluetooth/hci_h4.c
> +++ b/drivers/bluetooth/hci_h4.c
> @@ -133,6 +133,7 @@ static int h4_recv(struct hci_uart *hu, const void *data, int count)
> 	if (IS_ERR(h4->rx_skb)) {
> 		int err = PTR_ERR(h4->rx_skb);
> 		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
> +		h4->rx_skb = NULL;
> 		return err;
> 	}

Isn't this better fixed in h4_recv_buf directly:

@@ -173,7 +173,7 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
        while (count) {
                int i, len;
 
-               if (!skb) {
+               if (IS_ERR_OR_NULL(skb)) {
                        for (i = 0; i < pkts_count; i++) {
                                if (buffer[0] != (&pkts[i])->type)
                                        continue;

> 
> @@ -248,6 +249,7 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
> 				break;
> 			default:
> 				/* Unsupported variable length */
> +

This change seems totally unrelated.

> 				kfree_skb(skb);
> 				return ERR_PTR(-EILSEQ);
> 			}

Regards

Marcel

