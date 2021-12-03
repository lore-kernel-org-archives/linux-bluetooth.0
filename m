Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7A0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Dec 2021 21:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383214AbhLCVnx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:43:53 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:48236 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhLCVnw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Dec 2021 16:43:52 -0500
Received: from smtpclient.apple (p5b3d2e91.dip0.t-ipconnect.de [91.61.46.145])
        by mail.holtmann.org (Postfix) with ESMTPSA id 95E0ECED20;
        Fri,  3 Dec 2021 22:40:26 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [RFC] Bluetooth: mgmt: Introduce mgmt_alloc_skb and
 mgmt_send_event_skb
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20211203192529.2199867-1-luiz.dentz@gmail.com>
Date:   Fri, 3 Dec 2021 22:40:26 +0100
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <360C8200-95D7-4596-A39B-40703E99E92B@holtmann.org>
References: <20211203192529.2199867-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This introduces mgmt_alloc_skb and mgmt_send_event_skb which are
> convenient when building MGMT events that have variable length as the
> likes of skb_put_data can be used to insert portion directly on the skb
> instead of having to first build an intermediate buffer just to be
> copied over the skb.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> net/bluetooth/mgmt_util.c | 54 +++++++++++++++++++++++++++------------
> net/bluetooth/mgmt_util.h |  3 +++
> 2 files changed, 40 insertions(+), 17 deletions(-)
> 
> diff --git a/net/bluetooth/mgmt_util.c b/net/bluetooth/mgmt_util.c
> index 83875f2a0604..4774e993d774 100644
> --- a/net/bluetooth/mgmt_util.c
> +++ b/net/bluetooth/mgmt_util.c
> @@ -56,40 +56,60 @@ static struct sk_buff *create_monitor_ctrl_event(__le16 index, u32 cookie,
> 	return skb;
> }
> 
> -int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
> -		    void *data, u16 data_len, int flag, struct sock *skip_sk)
> +struct sk_buff *mgmt_alloc_skb(unsigned int size)
> {
> 	struct sk_buff *skb;
> +
> +	skb = alloc_skb(sizeof(struct mgmt_hdr) + size, GFP_KERNEL);
> +	if (skb)
> +		skb_reserve(skb, sizeof(struct mgmt_hdr));
> +
> +	return skb;
> +}
> +
> +int mgmt_send_event_skb(u16 event, struct hci_dev *hdev, unsigned short channel,
> +			struct sk_buff *skb, int flag, struct sock *skip_sk)
> +{
> 	struct mgmt_hdr *hdr;
> +	int len = skb->len;
> 
> -	skb = alloc_skb(sizeof(*hdr) + data_len, GFP_KERNEL);
> -	if (!skb)
> -		return -ENOMEM;
> +	/* Time stamp */
> +	__net_timestamp(skb);
> 
> -	hdr = skb_put(skb, sizeof(*hdr));
> +	/* Send just the data, without headers, to the monitor */
> +	if (channel == HCI_CHANNEL_CONTROL)
> +		hci_send_monitor_ctrl_event(hdev, event, skb->data, skb->len,
> +					    skb_get_ktime(skb), flag, skip_sk);
> +
> +	hdr = skb_push(skb, sizeof(*hdr));
> 	hdr->opcode = cpu_to_le16(event);
> 	if (hdev)
> 		hdr->index = cpu_to_le16(hdev->id);
> 	else
> 		hdr->index = cpu_to_le16(MGMT_INDEX_NONE);
> -	hdr->len = cpu_to_le16(data_len);
> -
> -	if (data)
> -		skb_put_data(skb, data, data_len);
> -
> -	/* Time stamp */
> -	__net_timestamp(skb);
> +	hdr->len = cpu_to_le16(len);
> 
> 	hci_send_to_channel(channel, skb, flag, skip_sk);
> 
> -	if (channel == HCI_CHANNEL_CONTROL)
> -		hci_send_monitor_ctrl_event(hdev, event, data, data_len,
> -					    skb_get_ktime(skb), flag, skip_sk);
> -
> 	kfree_skb(skb);
> 	return 0;
> }
> 
> +int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
> +		    void *data, u16 data_len, int flag, struct sock *skip_sk)
> +{
> +	struct sk_buff *skb;
> +
> +	skb = mgmt_alloc_skb(data_len);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	if (data)
> +		skb_put_data(skb, data, data_len);
> +
> +	return mgmt_send_event_skb(event, hdev, channel, skb, flag, skip_sk);
> +}
> +
> int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status)
> {
> 	struct sk_buff *skb, *mskb;
> diff --git a/net/bluetooth/mgmt_util.h b/net/bluetooth/mgmt_util.h
> index 63b965eaaaac..9f8692d4ce90 100644
> --- a/net/bluetooth/mgmt_util.h
> +++ b/net/bluetooth/mgmt_util.h
> @@ -32,6 +32,9 @@ struct mgmt_pending_cmd {
> 	int (*cmd_complete)(struct mgmt_pending_cmd *cmd, u8 status);
> };
> 
> +struct sk_buff *mgmt_alloc_skb(unsigned int size);
> +int mgmt_send_event_skb(u16 event, struct hci_dev *hdev, unsigned short channel,
> +			struct sk_buff *skb, int flag, struct sock *skip_sk);
> int mgmt_send_event(u16 event, struct hci_dev *hdev, unsigned short channel,
> 		    void *data, u16 data_len, int flag, struct sock *skip_sk);
> int mgmt_cmd_status(struct sock *sk, u16 index, u16 cmd, u8 status);

this altogether doesn’t create nicer to read code. What about doing this:

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 2f31e571f34c..fd0a114a69c6 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -399,6 +399,7 @@ struct bt_skb_cb {
                struct l2cap_ctrl l2cap;
                struct sco_ctrl sco;
                struct hci_ctrl hci;
+               struct mgmt_ctrl mgmt;
        };
 };

And then adding hci_dev and event to mgmt_ctrl. So you can do something like:

struct sk_buff *mgmt_alloc_skb(struct hci_dev *hdev, u16 event, unsigned int size);

Then the send_event becomes easier to read. Right now it is total mess with the allocated skb parameter in the middle. It should be first and center to make sure that is the one that matter.

Regards

Marcel

