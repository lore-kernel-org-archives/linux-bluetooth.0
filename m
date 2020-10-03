Return-Path: <SRS0=jDol=DK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B69C4363D
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 07:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C48206CD
	for <linux-bluetooth@archiver.kernel.org>; Sat,  3 Oct 2020 07:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="c13ISPOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725710AbgJCH15 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 3 Oct 2020 03:27:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:5539 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJCH14 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 3 Oct 2020 03:27:56 -0400
IronPort-SDR: CEc2g8912Pqv1s6G7EDFskEwH6IsmEOhHPayWgaAIOTAMvibSbExClX4Bug6JdmTuWOJUWZH7K
 xUvdCze1NP6A==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="247904445"
X-IronPort-AV: E=Sophos;i="5.77,330,1596524400"; 
   d="scan'208";a="247904445"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2020 00:27:53 -0700
IronPort-SDR: 7wZQkjnRWqNgMPSK/6fH/cyprwHD5Iw/9qqMxhV8i7rLYKgFpEzAsTSPz1cIQe5QECaMWcD7C/
 /7Ag4/n+NfHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,330,1596524400"; 
   d="scan'208";a="458868339"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga004.jf.intel.com with ESMTP; 03 Oct 2020 00:27:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 3 Oct 2020 00:27:52 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 3 Oct 2020 00:27:52 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 3 Oct 2020 00:27:52 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sat, 3 Oct 2020 00:27:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKTmefxpi6UYO0YrKApH8YlAmkqI7Ym+aCWmenGGakTx1/tI/A9wf7XuBk+33T/sShUnkin5oD+I6FE3iGcM353E6AvCoVIEJo5YiRfpS+AtHAKShEOUwEBrsbpQODUIsRqYvjF54ulbPvwZh9jmgV/QwUZhGQlFWEEl3EcGjdchlXbFCVADP8GRXI6J3UxXCYqzW+UnOcicIyNUCZ1SQ7yRf6P2uRpKoE+gAu9Rc7t5U8ZuG3oe/gSkdYk/GTveODoN1L4shX2W808+K/KdbcS9d2Yl6MKv/gp2akkBmyTwRPEuD+Qhofh0GTS6GCpN6jItefmAQuZ5AG9DBcz4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unK7YgaBsB9miY4PKyCu8ousp+9ubkn0H5BXUfasXOc=;
 b=X6y4MJ9KSmnJPnmxgksQ5Kbeyy8TsQmmI+ZutLF1BhnLjCQT/fSSpSGFQwahRZqk1iJIX3BgqHKqf7wq2swiEKODCW1z6s8x+LS/gyXq7Uf0DG4brNPiae6wEgoJf9IY1empUj0ERNW9b4dC1QYpdYtei/ROHhjQ4yRCNRxmoe39+3PGTicMoE5in87YYNv7w78KpJzXxwLXWjgXE5uAM3XdNg1ZBvOMpLngP91gsW9D5nkS8ErRKdUsCRLt+bznY5DlWX/YKIp4C+FZyvgTKtCZMa0WsQshA9zVtWOU5735VRcir36kQsnh8oDzRApqpGJ8vrmvBJk5HdrN/3SDZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unK7YgaBsB9miY4PKyCu8ousp+9ubkn0H5BXUfasXOc=;
 b=c13ISPOowlBtnUgZa9trSIn3txJDVVymjSVGgyRX3rp3LXQnNRbd8UllySpUS4c0o7LN5MvkhM1t9wNvCcdyPBNUztvJviIjd33Fs5BecBp+71eL4yBF1oytdINNOuoExiD335jh8EXamkcjnf/Vha3//nAMov5c+muJeI//kw8=
Received: from BYAPR11MB3141.namprd11.prod.outlook.com (2603:10b6:a03:8d::13)
 by BYAPR11MB2824.namprd11.prod.outlook.com (2603:10b6:a02:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.39; Sat, 3 Oct
 2020 07:27:48 +0000
Received: from BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::85cf:4ba6:9402:b396]) by BYAPR11MB3141.namprd11.prod.outlook.com
 ([fe80::85cf:4ba6:9402:b396%5]) with mapi id 15.20.3412.029; Sat, 3 Oct 2020
 07:27:48 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     Kiran K <kiraank@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Narasimman, Sathish" <sathish.narasimman@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Bag, Amit K" <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: RE: [PATCH v4] Bluetooth: btintel: Add *setup* function for new
 generation Intel controllers
Thread-Topic: [PATCH v4] Bluetooth: btintel: Add *setup* function for new
 generation Intel controllers
Thread-Index: AQHWmIirS4SOjPuc5EmhHpIj0oveQamEm0yAgADUGACAAAnu8A==
Date:   Sat, 3 Oct 2020 07:27:47 +0000
Message-ID: <BYAPR11MB31418F814CF72BABA4AF8970F50E0@BYAPR11MB3141.namprd11.prod.outlook.com>
References: <1601621530-2803-1-git-send-email-kiran.k@intel.com>
 <CABBYNZJW=9p=wV4okj=_WtJjEsZhuh9ZHEB-U_7ZMLEbxJ+UXQ@mail.gmail.com>
 <9E9FAF70-08C3-465A-98C5-2EBCBB50D699@holtmann.org>
In-Reply-To: <9E9FAF70-08C3-465A-98C5-2EBCBB50D699@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.171.170.99]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baf05875-c24d-4400-b1a0-08d8676dd432
x-ms-traffictypediagnostic: BYAPR11MB2824:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2824ECF45CF588F941EB931BF50E0@BYAPR11MB2824.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gV07vSEO1422QVCfHcIVFT7LFL/+87WKKQl9+4vAzkxx2EscRLXdoTRBsE9KZIQuvw72DTLILkBdbopKoT9d+vsBsYTBqmT2TXvFWsplMA8Pdg80EXhDNZuTbDVkcWZc1lvnpWc4cgZEh1HhZmOyHZ0zZrtdd+kvGy7WGkMVlsSC9qkscH/CCdQb+mhj4/EKGpndLgcNASTyR4SXL5K3XotoP2fqriOdjX+BCSN4Wh4iBXj8e0D4xjy72tJatM+2mi2Gj/6qHl6zgWF/TpewII/C04wZ0B6GNxo3KysFBpZ5f7x4/hYGtM2d2zWuLmd5d8YAHYWGFivF07rgP10U9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3141.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(33656002)(186003)(26005)(54906003)(110136005)(53546011)(6506007)(4326008)(55016002)(83380400001)(107886003)(8676002)(7696005)(5660300002)(316002)(478600001)(8936002)(86362001)(52536014)(9686003)(2906002)(66446008)(64756008)(66556008)(66476007)(76116006)(66946007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: HQ4+CZ0J1abJz4kSDQhRKrORWR3RleulQLZTLPnFnyqgDq1aJe7qPbJvEXEFVJ6R6+LTV7b3ALKsNoNXlrrx76UL3RUzTpHf7lBzhA7ZVK5CqklYH3E7yo85ZmAxO05l+bFd3B5ukfXkvvB6mYvPQ4tLFM3ojzTeyvRzdgSAq8P/pypfikN6Hmyi7tpkviUP0tpLx9d8QrOO6koLXp7aXIIV26TrKIb0v/icb/oFZXRXJ/l3WOUK8wtlzOyKdoWMjLWi+nu6h2JiokycmM5VLB/d/TsgFUKAoQtVAStmq+Pndn5TMDUlFqqSzbBQnlUvdmOQ6StFS6AJqx5p8iy6meIwJKp/WSLgmYOlhd+E4Cn2T1pEMsiTE1ZPcedIT6uU0FC05ioBYSFCJzFdGCCkYlkdEqE68AG6unnKYa5BV0Pfk5kMm/cRE2TvwqCKzVEVo6HiLXDJgKnJMo0gSRWThRFqzCiagUwCfyvfywGQ9EW9OW5PQuwzbbfBEAdgsQMRtq38K19effPmHgQ4XWJz7BJXMg/UHmdeTc0amzndzWktewzlDsVu5+fZOVDX8p4m4fAu4HbskTnt0xJ6+P8lpPZdxpTk7roSKTFvyodxNBhfsI6TvqgVOlqMYio9nuvL3VUKLpKCzg6ClOWcb7gfsQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3141.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf05875-c24d-4400-b1a0-08d8676dd432
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2020 07:27:47.8775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aRqHsRj3V78+1/24ef8pkavYsBysFZJPtrekgxtDaypYK6IBbwR8R8d+MPyaPkpHdurVmRwVX3IC079IZ0+wsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2824
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel, Luiz,

> -----Original Message-----
> From: Marcel Holtmann <marcel@holtmann.org>
> Sent: Saturday, October 3, 2020 12:12 PM
> To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Kiran K <kiraank@gmail.com>; linux-bluetooth@vger.kernel.org;
> Narasimman, Sathish <sathish.narasimman@intel.com>; Tumkur Narayan,
> Chethan <chethan.tumkur.narayan@intel.com>; Srivatsa, Ravishankar
> <ravishankar.srivatsa@intel.com>; K, Kiran <kiran.k@intel.com>; Bag, Amit=
 K
> <amit.k.bag@intel.com>; Raghuram Hegde <raghuram.hegde@intel.com>
> Subject: Re: [PATCH v4] Bluetooth: btintel: Add *setup* function for new
> generation Intel controllers
>=20
> Hi Luiz,
>=20
> >> Signed-off-by: Kiran K <kiran.k@intel.com>
> >> Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
> >> Signed-off-by: Raghuram Hegde <raghuram.hegde@intel.com>
> >> Reviewed-by: Sathish Narasimman <Sathish.Narasimman@intel.com>
> >> Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> >> Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> >> ---
> >> drivers/bluetooth/btintel.h |   6 +
> >> drivers/bluetooth/btusb.c   | 324
> +++++++++++++++++++++++++++++++++++++++++++-
> >> 2 files changed, 328 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/bluetooth/btintel.h
> >> b/drivers/bluetooth/btintel.h index 09346ae..c4e28a8 100644
> >> --- a/drivers/bluetooth/btintel.h
> >> +++ b/drivers/bluetooth/btintel.h
> >> @@ -132,6 +132,12 @@ struct intel_debug_features {
> >>        __u8    page1[16];
> >> } __packed;
> >>
> >> +#define INTEL_HW_PLATFORM(cnvx_bt)     ((u8)(((cnvx_bt) & 0x0000ff00)
> >> 8))
> >> +#define INTEL_HW_VARIANT(cnvx_bt)      ((u8)(((cnvx_bt) & 0x003f0000)
> >> 16))
> >> +#define INTEL_CNVX_TOP_TYPE(cnvx_top)  ((cnvx_top) & 0x00000fff)
> >> +#define INTEL_CNVX_TOP_STEP(cnvx_top)  (((cnvx_top) & 0x0f000000)
> >>
> >> +24) #define INTEL_CNVX_TOP_PACK_SWAB(t, s) __swab16(((__u16)(((t)
> <<
> >> +4) | (s))))
> >> +
> >> #if IS_ENABLED(CONFIG_BT_INTEL)
> >>
> >> int btintel_check_bdaddr(struct hci_dev *hdev); diff --git
> >> a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index
> >> 1005b6e..5e51749 100644
> >> --- a/drivers/bluetooth/btusb.c
> >> +++ b/drivers/bluetooth/btusb.c
> >> @@ -60,6 +60,7 @@ static struct usb_driver btusb_driver; #define
> >> BTUSB_WIDEBAND_SPEECH  0x400000
> >> #define BTUSB_VALID_LE_STATES   0x800000
> >> #define BTUSB_QCA_WCN6855      0x1000000
> >> +#define BTUSB_INTEL_NEWGEN     0x2000000
> >
> > I wonder if it is a good idea to keep adding such flags per model
> > here, it should be possible to pass the pid/vid so we don't have to
> > add generation after generation here.
>=20
> We agreed to first add the next gen controller as an independent setup
> method. And then later combine them into a single one that detects what
> version it is. We also need to unify it with our first generation ROM pro=
ducts.

We can still have an independent setup function for next gen controllers. O=
nly the method to identify the controller type is changed to use PID/VID in=
stead of BTUSB_INTEL_NEW. I will submit the refined patch in V5. Please rev=
iew it. If you still feel that we need to use BTUSB_INTEL_NEW, I will rever=
t to v4.
>=20
> Regards
>=20
> Marcel

Thanks,
Kiran


