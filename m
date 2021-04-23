Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DF5C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 12:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BBE60C40
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 12:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242319AbhDWM1A convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 08:27:00 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:48506 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230225AbhDWM07 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 08:26:59 -0400
Received: from marcel-macbook.holtmann.net (p4fefc624.dip0.t-ipconnect.de [79.239.198.36])
        by mail.holtmann.org (Postfix) with ESMTPSA id 6AD24CED00;
        Fri, 23 Apr 2021 14:34:09 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2 01/10] Bluetooth: HCI: Use skb_pull to parse BR/EDR
 events
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210419171257.3865181-2-luiz.dentz@gmail.com>
Date:   Fri, 23 Apr 2021 14:26:21 +0200
Cc:     linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <25D86C94-89CE-44CC-BB9C-724486444C12@holtmann.org>
References: <20210419171257.3865181-1-luiz.dentz@gmail.com>
 <20210419171257.3865181-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> This uses skb_pull to check the BR/EDR events received have the minimum
> required length.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
> include/net/bluetooth/hci.h |   4 +
> net/bluetooth/hci_event.c   | 272 +++++++++++++++++++++++++++++-------
> 2 files changed, 229 insertions(+), 47 deletions(-)
> 
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ea4ae551c426..f1f505355e81 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1894,6 +1894,10 @@ struct hci_cp_le_reject_cis {
> } __packed;
> 
> /* ---- HCI Events ---- */
> +struct hci_ev_status {
> +	__u8    status;
> +} __packed;
> +
> #define HCI_EV_INQUIRY_COMPLETE		0x01
> 
> #define HCI_EV_INQUIRY_RESULT		0x02
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 5e99968939ce..077541fcba41 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -42,6 +42,30 @@
> 
> /* Handle HCI Event packets */
> 
> +static void *hci_skb_pull(struct sk_buff *skb, size_t len)
> +{
> +	void *data = skb->data;
> +
> +	if (skb->len < len)
> +		return NULL;
> +
> +	skb_pull(skb, len);
> +
> +	return data;
> +}
> +
> +static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,
> +			     u8 ev, size_t len)
> +{
> +	void *data;
> +
> +	data = hci_skb_pull(skb, len);
> +	if (!data)
> +		bt_dev_err(hdev, "Malformed Event: 0x%2.2x", ev);
> +
> +	return data;
> +}
> +

so if you do it in one function, this will look like this:

	static void *hci_ev_skb_pull(..)
	{
		void *data = skb->data;

		if (skb->len < len) {
			bt_dev_err(hdev, “Malformed ..”);
			return NULL;
		}

		skb_pull(skb, len);
		return data;
	}

	static void *hci_cc_skb_pull(..)
	{
		void *data = skb->data;

		if (skb->len < len) {
			bt_dev_err(..);
			return NULL;
		}

		skb_pull(..);
		return data;
	}

I realize that you want to optimize the code with hci_skb_pull, but I don’t see how that makes it simpler or cleaner. In the end you just have spaghetti code and don’t win anything in size reduction or complexity.



> static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb,
> 				  u8 *new_status)
> {
> @@ -2507,11 +2531,15 @@ static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
> 
> static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> {
> -	__u8 status = *((__u8 *) skb->data);
> +	struct hci_ev_status *ev;
> 	struct discovery_state *discov = &hdev->discovery;
> 	struct inquiry_entry *e;
> 
> -	BT_DBG("%s status 0x%2.2x", hdev->name, status);
> +	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_INQUIRY_COMPLETE, sizeof(*ev));
> +	if (!ev)
> +		return;
> +

Now since we also have this pattern:

	ev = hci_ev_skb_pull(..);
	if (!ev)
		return;

The question is now why not just use a #define here.

	hci_ev_skb_pull(HCI_EV_INQUIRY_COMPLETE, ev);

And then the define would look like this (untested):

#define hci_ev_skb_pull(evt, var) do {			  \
		(var) = skb->data;			  \
		if (skb->len < sizeof(*(var))) {	  \
			bt_dev_err(hdev, “Malformed ..”); \
			return NULL;			  \
		}					  \
		skb_pull(skb, sizeof(*(var)));		  \
	} while (0);


> +	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);

If we have every event with an ev->status, we could even include bt_dev_dbg in the macro.

> 
> 	hci_conn_check_pending(hdev);
> 
> @@ -2604,9 +2632,13 @@ static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
> 
> static void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> {
> -	struct hci_ev_conn_complete *ev = (void *) skb->data;
> +	struct hci_ev_conn_complete *ev;
> 	struct hci_conn *conn;
> 
> +	ev = hci_ev_skb_pull(hdev, skb, HCI_EV_CONN_COMPLETE, sizeof(*ev));
> +	if (!ev)
> +		return;
> +
> 	BT_DBG("%s", hdev->name);

If you are touching the above part anyway, then move towards bt_dev_dbg() at the same time.

Regards

Marcel

