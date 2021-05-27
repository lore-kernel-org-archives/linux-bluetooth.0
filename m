Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665D2C47089
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 15:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF5A6135F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 15:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhE0PUk convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 May 2021 11:20:40 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:44990 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234529AbhE0PUk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 May 2021 11:20:40 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id A64ECCED34;
        Thu, 27 May 2021 17:27:01 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH] Bluetooth: hci_intel: prevent reads beyond the end of
 skb->data
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <YK+Yo6c1UuiACSZA@mwanda>
Date:   Thu, 27 May 2021 17:19:04 +0200
Cc:     Loic Poulain <loic.poulain@intel.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <ED41E619-3AC3-41B4-AC59-004ED6446537@holtmann.org>
References: <YK+Yo6c1UuiACSZA@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Dan,

> There doesn't appear to be any checks to ensure that skb->data is large
> enough in these functions.  For most of these, if we specify a header
> length, then h4_recv_buf() will ensure that all packets are at least the
> minimum length.  The intel_recv_lpm() function needs an additional
> check for LPM_OP_TX_NOTIFY packets.
> 
> Fixes: ca93cee5a56e ("Bluetooth: hci_uart: Add basic support for Intel Lightning Peak devices")
> 
> No signed-off-by because I can't test this and just wanted to collect
> feedback.  This is part of a static checker warning because someone
> reported the hci_event.c read overflows to security@kernel.org.  This
> stuff is quite complicated for static checkers of course and I don't
> understand all the rules yet.  Right now I have about 2000 warnings
> that look like this:
> 
> drivers/bluetooth/hci_intel.c:877 intel_recv_event() warn: assignment assumes 'skb->len' is '2' bytes
> drivers/bluetooth/hci_intel.c:922 intel_recv_lpm() warn: assignment assumes 'skb->len' is '2' bytes
> drivers/bluetooth/hci_intel.c:1028 intel_dequeue() warn: assignment assumes 'skb->len' is '3' bytes

I think it will be hard to find people with this hardware. LnP devices are rare, but maybe someone will speak up here.

> 
> I think there should be a different additional static checker warning
> for h4_recv_pkt structs like in this patch if you fail to specify a
> .hlen value?
> 
> regards,
> dan carpenter
> ---
> drivers/bluetooth/hci_intel.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 7249b91d9b91..3e4bccacad9b 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -925,7 +925,7 @@ static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
> 
> 	switch (lpm->opcode) {
> 	case LPM_OP_TX_NOTIFY:
> -		if (lpm->dlen < 1) {
> +		if (lpm->dlen < 1 || skb->len < struct_size(lpm, data, 1)) {
> 			bt_dev_err(hu->hdev, "Invalid LPM notification packet");
> 			break;
> 		}

This change looks fine to me and I would accept a patch for it.

> @@ -959,10 +959,10 @@ static int intel_recv_lpm(struct hci_dev *hdev, struct sk_buff *skb)
> 	.maxlen = HCI_LPM_MAX_SIZE
> 
> static const struct h4_recv_pkt intel_recv_pkts[] = {
> -	{ H4_RECV_ACL,    .recv = hci_recv_frame   },
> -	{ H4_RECV_SCO,    .recv = hci_recv_frame   },
> -	{ H4_RECV_EVENT,  .recv = intel_recv_event },
> -	{ INTEL_RECV_LPM, .recv = intel_recv_lpm   },
> +	{ H4_RECV_ACL,    .recv = hci_recv_frame, .hlen = sizeof(struct bt_skb_cb) },
> +	{ H4_RECV_SCO,    .recv = hci_recv_frame, .hlen = sizeof(struct bt_skb_cb) },
> +	{ H4_RECV_EVENT,  .recv = intel_recv_event, .hlen = sizeof(struct hci_event_hdr) },
> +	{ INTEL_RECV_LPM, .recv = intel_recv_lpm, .hlen = sizeof(struct hci_lpm_pkt) },

This part I do not understand, all the H4_RECV_* and even INTEL_RECV_* provide the hlen. So I have no idea what your change is doing here. And the two for H4_RECV_{ACL,SCO} are actually wrong. In case you wonder this is how they are defined:

#define H4_RECV_ACL \
        .type = HCI_ACLDATA_PKT, \
        .hlen = HCI_ACL_HDR_SIZE, \
        .loff = 2, \
        .lsize = 2, \
        .maxlen = HCI_MAX_FRAME_SIZE \

#define H4_RECV_SCO \
        .type = HCI_SCODATA_PKT, \
        .hlen = HCI_SCO_HDR_SIZE, \
        .loff = 2, \
        .lsize = 1, \
        .maxlen = HCI_MAX_SCO_SIZE

#define H4_RECV_EVENT \
        .type = HCI_EVENT_PKT, \
        .hlen = HCI_EVENT_HDR_SIZE, \
        .loff = 1, \
        .lsize = 1, \
        .maxlen = HCI_MAX_EVENT_SIZE

Regards

Marcel

