Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5632FC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Feb 2022 16:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiBGQBC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Feb 2022 11:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384949AbiBGPxe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Feb 2022 10:53:34 -0500
Received: from mail.holtmann.org (coyote.holtmann.net [212.227.132.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BECAC0401CC
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Feb 2022 07:53:33 -0800 (PST)
Received: from smtpclient.apple (p4ff9f3e5.dip0.t-ipconnect.de [79.249.243.229])
        by mail.holtmann.org (Postfix) with ESMTPSA id CC43ECECF1;
        Mon,  7 Feb 2022 16:53:32 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: [RFC] Bluetooth: hci_core: Introduce hci_recv_event_data
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20220204211236.2690926-2-luiz.dentz@gmail.com>
Date:   Mon, 7 Feb 2022 16:53:32 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <97AF1D34-8429-42C7-AC13-A7247234EC3F@holtmann.org>
References: <20220204211236.2690926-1-luiz.dentz@gmail.com>
 <20220204211236.2690926-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This introduces hci_recv_event_data to make it simpler to access the
> contents of last received event rather than having to pass its contents
> to the likes of *_ind/*_cfm callbacks.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci_core.h |  2 ++
> net/bluetooth/hci_core.c         | 32 ++++++++++++++++++++++++++++++++
> net/bluetooth/hci_event.c        |  3 +++
> 3 files changed, 37 insertions(+)
> 
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index f5caff1ddb29..c454913794bf 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -516,6 +516,7 @@ struct hci_dev {
> 	struct sk_buff_head	cmd_q;
> 
> 	struct sk_buff		*sent_cmd;
> +	struct sk_buff		*recv_event;
> 
> 	struct mutex		req_lock;
> 	wait_queue_head_t	req_wait_q;
> @@ -1727,6 +1728,7 @@ void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
> void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
> 
> void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
> +void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
> 
> u32 hci_conn_get_phy(struct hci_conn *conn);
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index b4782a6c1025..5d1167b67a47 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -2740,6 +2740,7 @@ void hci_release_dev(struct hci_dev *hdev)
> 
> 	ida_simple_remove(&hci_index_ida, hdev->id);
> 	kfree_skb(hdev->sent_cmd);
> +	kfree_skb(hdev->recv_event);
> 	kfree(hdev);
> }
> EXPORT_SYMBOL(hci_release_dev);
> @@ -3024,6 +3025,37 @@ void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode)
> 	return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
> }
> 
> +/* Get data from last received event */
> +void *hci_recv_event_data(struct hci_dev *hdev, __u8 event)
> +{
> +	struct hci_event_hdr *hdr;
> +	int offset;
> +
> +	if (!hdev->recv_event)
> +		return NULL;
> +
> +	hdr = (void *) hdev->recv_event->data;
> +	offset = sizeof(hdr);
> +
> +	if (hdr->evt != event) {
> +		/* In case of LE metaevent check the subevent match */
> +		if (hdr->evt == HCI_EV_LE_META) {
> +			struct hci_ev_le_meta *ev;
> +
> +			ev = (void *) hdev->recv_event->data + offset;
> +			offset += sizeof(*ev);
> +			if (ev->subevent == event)
> +				goto found;
> +		}
> +		return NULL;
> +	}
> +
> +found:
> +	bt_dev_dbg(hdev, "event 0x%2.2x", event);
> +
> +	return hdev->recv_event->data + offset;
> +}
> +
> /* Send ACL data */
> static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
> {
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 63b925921c87..613050bd80cc 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -6898,6 +6898,9 @@ void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb)
> 		goto done;
> 	}
> 
> +	kfree_skb(hdev->recv_event);
> +	hdev->recv_event = skb_clone(skb, GFP_KERNEL);
> +

fill me into why this a good idea. We end up creating clones of an SKB. Is this a good idea?

Regards

Marcel

