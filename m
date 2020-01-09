Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B7FC282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79CD206ED
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 17:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388202AbgAIR2q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 12:28:46 -0500
Received: from mga18.intel.com ([134.134.136.126]:44503 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388162AbgAIR2p (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 12:28:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 09:28:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="396160716"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga005.jf.intel.com with ESMTP; 09 Jan 2020 09:28:44 -0800
Received: from fmsmsx101.amr.corp.intel.com (10.18.124.199) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 09:28:44 -0800
Received: from bgsmsx151.gar.corp.intel.com (10.224.48.42) by
 fmsmsx101.amr.corp.intel.com (10.18.124.199) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 09:28:43 -0800
Received: from bgsmsx104.gar.corp.intel.com ([169.254.5.194]) by
 BGSMSX151.gar.corp.intel.com ([169.254.3.133]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 22:58:41 +0530
From:   "Navik, Ankit P" <ankit.p.navik@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bleutooth: Add definitions for LE Read Tx Power
Thread-Topic: [PATCH] Bleutooth: Add definitions for LE Read Tx Power
Thread-Index: AQHVxmY9wGfyZ5VkM0WpCYJ4ZJ1fJafil0uA
Date:   Thu, 9 Jan 2020 17:28:40 +0000
Message-ID: <2F886D5F95ED3A47BC8C177EADCD1CC72847E069@BGSMSX104.gar.corp.intel.com>
References: <1578386915-1524-1-git-send-email-ankit.p.navik@intel.com>
 <08B392B2-334A-47E3-A60F-AD7E21FAF9B2@holtmann.org>
In-Reply-To: <08B392B2-334A-47E3-A60F-AD7E21FAF9B2@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, 

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Thursday, January 9, 2020 2:27 AM
> To: Navik, Ankit P <ankit.p.navik@intel.com>
> Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
> Subject: Re: [PATCH] Bleutooth: Add definitions for LE Read Tx Power
> 
> Hi Ankit,
> 
> > Add the definitions for LE read transmit power HCI commands to read
> > the minimum and maximum Tx power.
> >
> > Signed-off-by: Ankit Navik <ankit.p.navik@intel.com>
> > ---
> > include/net/bluetooth/hci.h      |  7 +++++++
> > include/net/bluetooth/hci_core.h |  3 +++
> > net/bluetooth/hci_event.c        | 18 ++++++++++++++++++
> > 3 files changed, 28 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 07b6ece..6e8805f 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1641,6 +1641,13 @@ struct hci_cp_le_ext_conn_param {
> > 	__le16 max_ce_len;
> > } __packed;
> >
> > +#define HCI_OP_LE_READ_TX_POWER		0x204b
> > +struct hci_rp_le_read_tx_power {
> > +	__u8 status;
> > +	__s8 min_tx_power;
> > +	__s8 max_tx_power;
> > +} __packed;
> > +
> > #define HCI_OP_LE_READ_NUM_SUPPORTED_ADV_SETS	0x203b
> 
> can we please keep this list sorted by opcode.

Yes, I will fix and submit v2. 
> 
> > struct hci_rp_le_read_num_supported_adv_sets {
> > 	__u8  status;
> > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > index faebe38..88c6e55 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -418,6 +418,9 @@ struct hci_dev {
> > 	__u8			scan_rsp_data[HCI_MAX_AD_LENGTH];
> > 	__u8			scan_rsp_data_len;
> >
> > +	__s8			min_tx_power;
> > +	__s8			max_tx_power;
> > +
> 
> They are LE specific so lets prefix them as le_ and put them together with other
> le_ data.

Agree. 
> 
> > 	struct list_head	adv_instances;
> > 	unsigned int		adv_instance_cnt;
> > 	__u8			cur_adv_instance;
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 6ddc4a7..fc154cf 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -988,6 +988,20 @@ static void hci_cc_le_read_adv_tx_power(struct
> hci_dev *hdev,
> > 	hdev->adv_tx_power = rp->tx_power;
> > }
> >
> > +static void hci_cc_le_read_tx_power(struct hci_dev *hdev,
> > +					struct sk_buff *skb)
> 
> Please do proper indentation.

I'll send v2. 

Regards, 
Ankit
> 
> > +{
> > +	struct hci_rp_le_read_tx_power *rp = (void *) skb->data;
> > +
> > +	BT_DBG("%s status 0x%2.2x", hdev->name, rp->status);
> > +
> > +	if (rp->status)
> > +		return;
> > +
> > +	hdev->min_tx_power = rp->min_tx_power;
> > +	hdev->max_tx_power = rp->max_tx_power; }
> > +
> > static void hci_cc_user_confirm_reply(struct hci_dev *hdev, struct
> > sk_buff *skb) {
> > 	struct hci_rp_user_confirm_reply *rp = (void *) skb->data; @@ -3414,6
> > +3428,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct
> sk_buff *skb,
> > 		hci_cc_le_read_max_data_len(hdev, skb);
> > 		break;
> >
> > +	case HCI_OP_LE_READ_TX_POWER:
> > +		hci_cc_le_read_tx_power(hdev, skb);
> > +		break;
> > +
> > 	case HCI_OP_WRITE_LE_HOST_SUPPORTED:
> > 		hci_cc_write_le_host_supported(hdev, skb);
> > 		break;
> 
> Regards
> 
> Marcel

