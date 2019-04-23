Return-Path: <SRS0=r7wX=SZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73482C282E1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2E921738
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Apr 2019 19:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfDWTmm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:42:42 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:33230 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWTmm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Apr 2019 15:42:42 -0400
Received: from marcel-macpro.fritz.box (p4FF9FD9B.dip0.t-ipconnect.de [79.249.253.155])
        by mail.holtmann.org (Postfix) with ESMTPSA id 5B2BDCF2E8;
        Tue, 23 Apr 2019 21:50:51 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: [Patch net v2 1/3] bluetooth: validate HCI_EVENT_PKT packet
 carefully
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20190403230835.1174-2-xiyou.wangcong@gmail.com>
Date:   Tue, 23 Apr 2019 21:42:40 +0200
Cc:     netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com,
        syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tomas Bortoli <tomasbortoli@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <5F6E057E-4897-4F74-9FA4-0CB41222DB5F@holtmann.org>
References: <20190403230835.1174-1-xiyou.wangcong@gmail.com>
 <20190403230835.1174-2-xiyou.wangcong@gmail.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Cong,

> hci_event_packet() blindly assumes all packets are sane, at least
> for packets allocated via vhci_get_user() path this is not true.
> We have to check if we access skb data out-of-bound with
> pskb_may_pull() before each skb->data dereference on RX path.
> 
> Reported-and-tested-by: syzbot+cec7a50c412a2c03f8f5@syzkaller.appspotmail.com
> Reported-and-tested-by: syzbot+660883c56e2fa65d4497@syzkaller.appspotmail.com
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Tomas Bortoli <tomasbortoli@gmail.com>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
> net/bluetooth/hci_event.c | 262 +++++++++++++++++++++++++++++++-------
> 1 file changed, 218 insertions(+), 44 deletions(-)
> 
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 609fd6871c5a..2fef70c0bffe 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -2331,10 +2331,13 @@ static void hci_cs_switch_role(struct hci_dev *hdev, u8 status)
> 
> static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> {
> -	__u8 status = *((__u8 *) skb->data);
> 	struct discovery_state *discov = &hdev->discovery;
> 	struct inquiry_entry *e;
> +	__u8 status;
> 
> +	if (unlikely(!pskb_may_pull(skb, 1)))
> +		return;
> +	status = *((__u8 *)skb->data);
> 	BT_DBG("%s status 0x%2.2x", hdev->name, status);
> 
> 	hci_conn_check_pending(hdev);
> @@ -2391,14 +2394,21 @@ static void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
> static void hci_inquiry_result_evt(struct hci_dev *hdev, struct sk_buff *skb)
> {
> 	struct inquiry_data data;
> -	struct inquiry_info *info = (void *) (skb->data + 1);
> -	int num_rsp = *((__u8 *) skb->data);
> +	struct inquiry_info *info;
> +	int num_rsp;
> 
> 	BT_DBG("%s num_rsp %d", hdev->name, num_rsp);
> 
> +	if (unlikely(!pskb_may_pull(skb, 1)))
> +		return;
> +	num_rsp = *((__u8 *)skb->data);
> 	if (!num_rsp)
> 		return;
> 
> +	if (unlikely(!pskb_may_pull(skb, 1 + num_rsp * sizeof(*info))))
> +		return;
> +	info = (void *)(skb->data + 1);
> +
> 	if (hci_dev_test_flag(hdev, HCI_PERIODIC_INQ))
> 		return;

this really looks like we better create a macro for this. It is repetitive code that can be turned into just a macro usage.

Regards

Marcel

