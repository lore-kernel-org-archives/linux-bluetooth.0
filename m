Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E4DC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 14:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC648613DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Apr 2021 14:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236341AbhDVOJa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Apr 2021 10:09:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:56443 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236092AbhDVOJa (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Apr 2021 10:09:30 -0400
IronPort-SDR: rZOWGcXWCvve2WY+Obl6gOz+4Wkw7ROLyF1+bdC48MEZN6Bdmh/D61sMAiOc899cT7TNOyAhop
 jnVyxYDoOFJg==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="192704179"
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="192704179"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 07:08:46 -0700
IronPort-SDR: bT6k7sx4u4pUZ9cs9xsKC5j/rKXIrhJf3SjgXfMwP2Yc7DJcQPnpEYGwyOaqEcib9zTzSxFJ8D
 DbjmQPV1o2wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,242,1613462400"; 
   d="scan'208";a="427960342"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2021 07:08:46 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Apr 2021 07:08:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Apr 2021 07:08:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 22 Apr 2021 07:08:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 22 Apr 2021 07:08:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDwedVVmey2lUMEa0hnVZptlaiIJK9JeIY44Tbv4vSBMaT6TCLpjaxPT+Y8mW8gS8+dk+Crg9lPWkva+xp2M1lOwtgRw4/4f+eLd8/tuVS5NJZzVBWCuhzvvHBXjMA7GPnvACWWfrAhRuvrkxqYxwDzRgzqacLZZeWbX4XbJ+dhLf5by6x88G+IqvxDC4XpbMwol02SsbPDNeMQLiHMgoVj1wFeEUQ2hVsCiUwBnicZOdlXG+hSRPa5MmNk0i7UNa2D3eA+2aXAWvwUktztPgLuraq7QEqqfvZBnGcua+bo4DKAv6r19mfkkNkF0JkmXqTy0c1nzlp6jOBMo/X3gDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKB+YtttV3rY9keNRU8Ae/9doNNTfsWxjWYsv6CK7J8=;
 b=JKK3D397obxMiKPP9k4PwcYu9/qy7BLJrsSGtzWhzWNL86B+O6/hNmz54GRC8neS12d5/xjR8rZIHCzWPwpNURK4mSWh/J3k9u5gbwPYK2MCQj0WstB84iLYRMG06Jy1uwgskmU7zFnm17PeSrW6hysel4JKJ1yje3qiu+omIeXO7WP+ANGzbAFOWumdzNYmt5Eb2ozIlQpx/jvwOD2gJ48Op7saqtoS1uLNnWJwHCkuTIZ+EECYE7u/MIcRpdGJ9B6SUydixw/FWGnKHzyUzNl7Se0ko+bRzlfaqkmwBV92VB0DMQdCsXBoyGqxxlS/x05lfyFOqotwQ10WdzuR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKB+YtttV3rY9keNRU8Ae/9doNNTfsWxjWYsv6CK7J8=;
 b=YLz1WGJ5UjFnm9SEjwCFiyJKGxVm9zDbUErq8IU8zOdSWeInsHWfMgqx/hQKBUd4A8PIx0a1dAA7IzlNes41j44JDVzeRTldU/iAt64oqkr3503b1fU1lWOZRygCy0Y94W6dVwxJmQpvAfoHrEyLB+BpyQPtiZWbgwayrMC1a30=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5670.namprd11.prod.outlook.com (2603:10b6:8:37::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.22; Thu, 22 Apr 2021 14:08:32 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4065.023; Thu, 22 Apr 2021
 14:08:32 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: RE: [PATCH v2 1/3] Bluetooth: add support to enumerate codec
 capabilities
Thread-Topic: [PATCH v2 1/3] Bluetooth: add support to enumerate codec
 capabilities
Thread-Index: AQHXL3ZHw8qxP5Rt8k67snZMAKMkIaqy04uAgA3PI7A=
Date:   Thu, 22 Apr 2021 14:08:32 +0000
Message-ID: <DM8PR11MB55730591C18EFDD9FD603717F5469@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210412083538.18600-1-kiran.k@intel.com>
 <3434AC21-8C36-435D-9D0F-3597FE434D54@holtmann.org>
In-Reply-To: <3434AC21-8C36-435D-9D0F-3597FE434D54@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [49.37.165.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d85313d-cc78-4827-6161-08d905981cc7
x-ms-traffictypediagnostic: DM8PR11MB5670:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5670593158DA7300B8825781F5469@DM8PR11MB5670.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H3+QHcrpwh0A8v1oy481QjzDl3xRKhbozqyHQXqYmhzbcqgssySoGNo+D1Y6MdqkButmFRZvOjXMEBHuYDRuXLKGV8GnOo2Icwi5m8LZhi+wZVT3VA89X8HgxlyYBaA2v3ModUDcRt77QYyJ1ynS+JGMYCCk1StQGPoZWEQo9kEKZovdwlNUuB641kILmldnPzabFpLwL8ilAVJFk9TYWY3T4rQ6NymKw2+xjqB4i9ri2/f+TjBullA/UAJ1kh4ZQwptNXfyydGYeh99PoWw5tK/3uFrlodjX1Jws7Gm7QqGo6oirkbjSHQ9YgZzJdY745/eN4u2wqmIa/lZkCSQ5VHPnj8PwNTBNTH28aPWG4Wau9PhOt7yyY8u82AfY+ThRDG5O23u3LrA0j52xa82cOdl6crfLe+ISNnWbj+uS1w+fiWb1rfuyYKJBPvzHQh7LMwbLqW7GX9mr+amIxGlA5urGoGkklNP7gxoCNWpRnjVk7MjPJ0phhzMZts5TEg6qSkRERqIjL0UEaI35oNLClWgfGNbXxlrYb6FKJb08l98aNFyraZhtYbtlVx5HtB1l/csuzAQucqgdX4A0RvvJcEJ8wK+bzRurOTUSlZYSVU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(366004)(39850400004)(396003)(64756008)(66476007)(6506007)(86362001)(53546011)(2906002)(186003)(66556008)(52536014)(5660300002)(9686003)(7696005)(66446008)(55016002)(66946007)(38100700002)(478600001)(76116006)(6916009)(8936002)(33656002)(71200400001)(26005)(8676002)(316002)(54906003)(107886003)(4326008)(83380400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?b6D0rR6VFSv6ro+Ygl3A3X3dY49/re2LZXJn/MYvH1sV+/HK1xIT1S2KUsg4?=
 =?us-ascii?Q?EQ/N5IeEI3aw3MfgXUUQ+5sTXaOQf7wosSfmNBbK+V7E+dDe63Rzhoar+dwb?=
 =?us-ascii?Q?naEBkGB8g+hIrppQH2gCC7om5iweaQ+2ZjWPneh/aeRzYL/tYqBIWzjgmW61?=
 =?us-ascii?Q?w62U2CRjgK+5kH8OE5EMjJF+/q/KFbCBRExB9ffcOJCVnHhnb6ZnYTPDwtHx?=
 =?us-ascii?Q?A0oPId3ql4aqlxAojZJS2OBIRL4tqv12I3TpLOq/5HJm7aYDG3HCy+CihjEs?=
 =?us-ascii?Q?d2xcNMb1VDljqzkyweMc2XmE7A+ZurNTEVPtZIWFWDajLOuxZ0i5brpp9gRt?=
 =?us-ascii?Q?+TV2Y8wpzPmohoznipS56KQnl3dG4QCMxnAkVaGQqW5WolLgyZ5oY5lKhBN5?=
 =?us-ascii?Q?Hex8nBPjLH8Cdgl9hqMir9Ki3bxlKQlqFgPJNt+FlN4ESBPKm9IIsnpgv8pB?=
 =?us-ascii?Q?C9CF05cUqHHgX4q2e1O3Ykl9YTuPk1mOWpMcKas002fQmhAi1vByUuHeCeaI?=
 =?us-ascii?Q?VHr8rpNzsVPT0r+17b5lCbnJN23NLZSSc/7niH2NWW1PZo74SufgonY/Tqgl?=
 =?us-ascii?Q?D5X8hPCOHOS90rzJENDIK+vCJcECbYJFRRCjG1lm9ApJS6UGN9V3FQbd8sFj?=
 =?us-ascii?Q?EOPo1BrTwVnTWehiibDPWqBry6SF1ID/VOEx6bOg0HBaBwckIJkVryyTir2O?=
 =?us-ascii?Q?2CgPIfK8O7rLrWe15nneC8r2b3p3dQLF0hOnkMqTFVY2leuEzRkO7i/AGSwB?=
 =?us-ascii?Q?HYedvQRl7Nm2SBXQLHnvixvqmZxOv0zEFrK68PBYzPE1CJ+e2oEvi6uIb5VA?=
 =?us-ascii?Q?jMFnav0hVtPzw5qg1kwhNnUb3hmYbBUDwQpx7BaWKqLfyexu3SJ7Avghdob7?=
 =?us-ascii?Q?4rxWSpEyY/qnoftwI+52Buems9g3XFxQTEiB7ZjtQyYKGQwNRDYynJuGjwG1?=
 =?us-ascii?Q?JKOpJmqk4QEwvg5LrH02Wfz6Mg+3MxJg5mKYS5UddgFgMp3chIW3joidAv9k?=
 =?us-ascii?Q?0FaIN1CjfqQqIWJsDstlJ5utZodQvvzbfMrdHTNL1IW5zv2gBb8TdND8c2RB?=
 =?us-ascii?Q?Z6To7ZhPNjPgNdWWuYfuccrQvqapH00O1uNEnujQarz2DGrI33cOwbWUfroL?=
 =?us-ascii?Q?0Bfxo8ZB0rosmKJvxg/zyD/+iTT5+Au+dghk2I3PeGDFBUiz1z0xPWGMEdtT?=
 =?us-ascii?Q?JX9Iq+QiDvjvBMu79+DTjOEZZtkJC5g+jYuWLi739fhr/vO4+MprBVeH4GlG?=
 =?us-ascii?Q?TLYb/o8XCvnOHvQZpQd45nsUfJa3+pWGP7dkR0ccP5uSc/chgdTAE5MPDG5j?=
 =?us-ascii?Q?oSYcoovwzzw88l+X98nsyueC?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d85313d-cc78-4827-6161-08d905981cc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2021 14:08:32.4855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9qCjPCP133YLdEpBHzQjSeQGSjRpBUkd7+PEBCdD8ZKDgkOCVea8svIDpA6b3ftZyQ9YZX2zfpZjuRRHUiMCCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5670
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Thanks for the comments. I will send out an updated version of patchset.

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Wednesday, April 14, 2021 12:45 AM
> To: K, Kiran <kiran.k@intel.com>
> Cc: open list:BLUETOOTH DRIVERS <linux-bluetooth@vger.kernel.org>;
> Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Tumkur Narayan,
> Chethan <chethan.tumkur.narayan@intel.com>; Von Dentz, Luiz
> <luiz.von.dentz@intel.com>
> Subject: Re: [PATCH v2 1/3] Bluetooth: add support to enumerate codec
> capabilities
>=20
> Hi Kiran,
>=20
> > add support to enumerate local supported codec capabilities
> >
> > < HCI Command: Read Local Suppor.. (0x04|0x000e) plen 7
> >        Codec: mSBC (0x05)
> >        Logical Transport Type: 0x00
> >        Direction: Input (Host to Controller) (0x00)
> >> HCI Event: Command Complete (0x0e) plen 12
> >      Read Local Supported Codec Capabilities (0x04|0x000e) ncmd 1
> >        Status: Success (0x00)
> >        Number of codec capabilities: 1
> >         Capabilities #0:
> >        00 00 11 15 02 33
> >
> > Signed-off-by: Kiran K <kiran.k@intel.com>
> > Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> > Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> > ---
> > * changes in v2
> >  add skb->len check before accessing event data
> >
> > include/net/bluetooth/hci.h |  7 ++++
> > net/bluetooth/hci_event.c   | 68
> +++++++++++++++++++++++++++++++++++++
> > 2 files changed, 75 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index ea4ae551c426..e3f7771fe84f 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1314,6 +1314,13 @@ struct hci_rp_read_local_pairing_opts {
> > 	__u8     max_key_size;
> > } __packed;
> >
> > +#define HCI_OP_READ_LOCAL_CODEC_CAPS	0x100e
> > +struct hci_op_read_local_codec_caps {
> > +	__u8	codec_id[5];
> > +	__u8	transport;
> > +	__u8	direction;
> > +} __packed;
> > +
> > #define HCI_OP_READ_PAGE_SCAN_ACTIVITY	0x0c1b
> > struct hci_rp_read_page_scan_activity {
> > 	__u8     status;
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 5e99968939ce..a4b905a76c1b 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -887,6 +887,70 @@ static void hci_cc_read_data_block_size(struct
> hci_dev *hdev,
> > 	       hdev->block_cnt, hdev->block_len); }
> >
> > +static void hci_cc_read_local_codecs(struct hci_dev *hdev,
> > +				     struct sk_buff *skb)
> > +{
> > +	__u8 num_codecs;
> > +	struct hci_op_read_local_codec_caps caps;
> > +
> > +	if (skb->len < sizeof(caps))
> > +		return;
> > +
> > +	bt_dev_dbg(hdev, "status 0x%2.2x", skb->data[0]);
> > +
> > +	if (skb->data[0])
> > +		return;
> > +
> > +	/* enumerate standard codecs */
> > +	skb_pull(skb, 1);
> > +
> > +	if (skb->len < 1)
> > +		return;
> > +
> > +	num_codecs =3D skb->data[0];
> > +
> > +	bt_dev_dbg(hdev, "Number of standard codecs: %u", num_codecs);
> > +
> > +	skb_pull(skb, 1);
> > +
> > +	if (skb->len < num_codecs)
> > +		return;
> > +
> > +	while (num_codecs--) {
> > +		caps.codec_id[0] =3D skb->data[0];
> > +		caps.transport =3D 0x00;
> > +		caps.direction =3D 0x00;
> > +
> > +		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS,
> sizeof(caps),
> > +			     &caps);
> > +
> > +		skb_pull(skb, 1);
> > +	}
> > +
> > +	/* enumerate vendor specific codecs */
> > +	if (skb->len < 1)
> > +		return;
> > +
> > +	num_codecs =3D skb->data[0];
> > +	skb_pull(skb, 1);
> > +
> > +	bt_dev_dbg(hdev, "Number of vendor specific codecs: %u",
> > +num_codecs);
> > +
> > +	if (skb->len < (num_codecs * 4))
> > +		return;
> > +
> > +	while (num_codecs--) {
> > +		caps.codec_id[0] =3D 0xFF;
> > +		memcpy(&caps.codec_id[1], skb->data, 4);
> > +		caps.transport =3D 0x00;
> > +		caps.direction =3D 0x00;
> > +
> > +		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS,
> sizeof(caps),
> > +			     &caps);
> > +		skb_pull(skb, 4);
> > +	}
>=20
> instead of sending hci_send_cmd here, I rather do this in a separate init
> stage. Since you want to cache the codec values anyway, start doing it no=
w.
>=20
> Regards
>=20
> Marcel

Regards,
Kiran


