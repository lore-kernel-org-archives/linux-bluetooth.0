Return-Path: <SRS0=bfEF=6B=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A12C2D0EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 18:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C699B22201
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Apr 2020 18:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="p5G9av6h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgDQSof (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:44:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:56981 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbgDQSoe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Apr 2020 14:44:34 -0400
IronPort-SDR: FTkSVIut/TQlKfELFAwBGffTMn9s+W7//3rlPRgiItjXJW78MlvWHmSc+kt/Q+pTg/ZKnzOzMQ
 bwdSEF2aZuRw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2020 11:44:34 -0700
IronPort-SDR: w3/o9u74sfp/GWUSbcXA+sqnugyiVcgG7EpKff0j9BSFWuhwwxOI6c1o0SyUouCKsEWeTU2NGk
 HMa1JUQTmFTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,395,1580803200"; 
   d="scan'208";a="299686378"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Apr 2020 11:44:34 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Apr 2020 11:44:33 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 17 Apr 2020 11:44:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 17 Apr 2020 11:44:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IvaZ5pMOaSXPa5Zeh8L5vb26b8jsVMkiuCKGBvZ1prQsFI0FF7aOGkUkMhXJHaAMcGC5A2hptIe07/ZGJJbesxPdzijj/bjCuSiWmVm/eK6Fs8yfkX6bgETgLcTbXruesroXVFn/GzPOFeWZLeCjxBQ6lqp2eUi1D+eN2bXNJF1sR1KxST9O85GfNtRuRA1cjwjtd9UpEWIq5qRIZDBOtqyQ/yAdTPRAGXCKqyDPwMoW3k+z3X++sJjpN+dfRoiHqg8D3xQQF3rsLJPAnetEvu74RLPR5q7KvfIQPXj6OE8OFawGWVyQHut7zoadbSdmNqfTOFwKUCFbkY8Pu8nfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGBLvJ4vdub/cmuqTRqbCiba//eiKtwbYdv/Ze+A094=;
 b=Sac+bDo97v6kgB18kE2DJ6CBdBMgXJa4Rbxz/sSHpy2ncs/ChebsISF8cJet8mwhGI6VN45QhrptMRELfVN9O+peyur5q7PSz7ITeVDA6W729HV5EbWKN9r56FTnPq90xm/xpHeI7rW8XqWfxTULZQacI1qBM9lUuuxfnFJry83ddx8TnVzfQk+1iF0QSnRLLvSzr9PmU8wwcqbkLVUJ0rFvrVs6AeaMZkqJT2TxMMsYgP4lqBHUGmBvTF+MrPQXWX0/EnMrdVbWxsdfhW83D6j2bR56SOW7oMrICcitboSrdp8DT5LRJrTIazs9NvIlbDjrZKIpTg4OyW/RRtWZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGBLvJ4vdub/cmuqTRqbCiba//eiKtwbYdv/Ze+A094=;
 b=p5G9av6hTEF6L3RQRVA8YcSLPMddOGcolo9LwAsKsbeX9gWgVw3FPAglJ0/gGomOLTy5jPddzBaf1ApXeyeY4cgEUXrP7VCHp/ujqBnFRA5XoAcOdQcz5Z7kdYw4UJ0GWHfObZDxdKo+1AKBOv7/pJERPFKl3SnNuDepcWvehKI=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4522.namprd11.prod.outlook.com (2603:10b6:303:2d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Fri, 17 Apr
 2020 18:44:30 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5552:f057:3dbf:716c]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5552:f057:3dbf:716c%3]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 18:44:30 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: Build errors under Fedora 32 beta distro / GCC 10.0.1
Thread-Topic: Build errors under Fedora 32 beta distro / GCC 10.0.1
Thread-Index: AQHWFOg67f7cw5+eaUKltLlqXH+mBA==
Date:   Fri, 17 Apr 2020 18:44:30 +0000
Message-ID: <5f5cc8a0b25cb7a2a289f83cfbf42b2f86e36f28.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 32c170ca-0e1c-4114-9857-08d7e2ff5d0c
x-ms-traffictypediagnostic: MW3PR11MB4522:
x-microsoft-antispam-prvs: <MW3PR11MB4522318B6F21AF90B746CC83E1D90@MW3PR11MB4522.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(39860400002)(396003)(366004)(346002)(136003)(8676002)(5660300002)(36756003)(8936002)(6916009)(54906003)(81156014)(186003)(2616005)(478600001)(2906002)(6512007)(71200400001)(4326008)(316002)(76116006)(6506007)(64756008)(66446008)(66476007)(26005)(86362001)(6486002)(66556008)(66946007)(91956017)(2004002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FDKop+YGSzjALaYX6INkuI/IX8kJuQGuNm3OfgJiX6R5zoCC2SKGxAy22sBwsiGKaQHcRYeh10Z2DvxfJklCDgqaKf1lzMnJ5pqd+Q9lThAkVbC83fxLMEJNr8cjhtVOzG+p8AyS+Wc0OJp+KPyYP6Y8LBU9DJUBAc5vpArX6goUCy2SOmrlQ6w3pkeum9yWJAdT22ZCSY/UoqK/DIXtjelGEstdrwTd05DIXeIAZRnwJ6k7vYEaHq6oUrkAP+uCMng7/661nPg8xTOVSLUkW+5tl1e0SK3SIps1hkPxMJHzUYQkdVqOWO30R9+O44uv/f/wks0JYjk0Et9mfJMWx06UFQW6Wn248HiCGxQ2CxM60d84ZwwtlziURwCyAf9uQ5YGG6Ht6vBqhgMAmKvLTNqrWZ2ERuGOsCmE4TjPswoGiXMQKsoHefc+eV2c78jT20HFZTc7P6cbxAqWwEXOcbpb9ta+GY4cVPMtnIfzuzE=
x-ms-exchange-antispam-messagedata: U1VXpyw6uo/M4sZZKQTWWLjQu80B/9uU8SAbCamsw8osiL4JyQQs9BPD1O4MsUrl/+GCjxy6wmekQmSNs/m7BCzmCPH+cdwpMGG3aNEkO2YKR8iOiEQspqkHTAxf5E1ai635Xc6aNWZvUAZqBLxDHw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD9745B32F5A2041B04AB0CB1288C820@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c170ca-0e1c-4114-9857-08d7e2ff5d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 18:44:30.1082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fm1RKFt27NB/1u66W2dJ3GpbpqcebgpfDp4KJD9WIUcXRZYa1h/Yx6iDClan1+t3+OYlIUizuAaBLEp2SbRy7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4522
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Q29tcGlsaW5nIEJsdWVaIHVzaW5nIEdDQyAxMC4wLjEsIHdoaWNoIGlzIHRoZSBzdGFuZGFyZCB2
ZXJzaW9uIGZvciBGZWRvcmEgMzIgZGlzdHJvOg0KDQokIGdjYyAtLXZlcnNpb24NCmdjYyAoR0ND
KSAxMC4wLjEgMjAyMDAzMjggKFJlZCBIYXQgMTAuMC4xLTAuMTEpDQpDb3B5cmlnaHQgKEMpIDIw
MjAgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMuDQpUaGlzIGlzIGZyZWUgc29mdHdhcmU7
IHNlZSB0aGUgc291cmNlIGZvciBjb3B5aW5nIGNvbmRpdGlvbnMuICBUaGVyZSBpcyBOTw0Kd2Fy
cmFudHk7IG5vdCBldmVuIGZvciBNRVJDSEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJU
SUNVTEFSIFBVUlBPU0UuDQoNClRoaXMgaXMganVzdCBhIHNuaXBwZXQgb2YgdGhlIHRvcCBvZiB0
aGUgZXJyb3IgbG9nOg0KDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gYW5kcm9pZC90ZXN0ZXItYmx1
ZXRvb3RoLmM6MjQ6DQphbmRyb2lkL3Rlc3Rlci1ibHVldG9vdGguYzo2MjA6ODogZXJyb3I6IGlt
cGxpY2l0IGNvbnZlcnNpb24gZnJvbSDigJhlbnVtIDxhbm9ueW1vdXM+4oCZIHRvIOKAmGVudW0g
PGFub255bW91cz7igJkgWy0NCldlcnJvcj1lbnVtLWNvbnZlcnNpb25dDQogIDYyMCB8ICAgICAg
ICBCVF9ESVNDT1ZFUllfU1RBUlRFRCksDQogICAgICB8ICAgICAgICBefn5+fn5+fn5+fn5+fn5+
fn5+fg0KYW5kcm9pZC90ZXN0ZXItbWFpbi5oOjYzOjI3OiBub3RlOiBpbiBkZWZpbml0aW9uIG9m
IG1hY3JvIOKAmFRFU1RfQ0FTRV9CUkVEUkxF4oCZDQogICA2MyB8ICAgc2l6ZW9mKChzdHJ1Y3Qg
c3RlcFtdKSB7X19WQV9BUkdTX199KSAvIHNpemVvZihzdHJ1Y3Qgc3RlcCksIFwNCiAgICAgIHwg
ICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fg0KYW5kcm9pZC90ZXN0ZXItYmx1
ZXRvb3RoLmM6NjE5OjM6IG5vdGU6IGluIGV4cGFuc2lvbiBvZiBtYWNybyDigJhDQUxMQkFDS19T
VEFUReKAmQ0KICA2MTkgfCAgIENBTExCQUNLX1NUQVRFKENCX0JUX0RJU0NPVkVSWV9TVEFURV9D
SEFOR0VELA0KICAgICAgfCAgIF5+fn5+fn5+fn5+fn5+DQphbmRyb2lkL3Rlc3Rlci1ibHVldG9v
dGguYzo2MjA6ODogZXJyb3I6IGltcGxpY2l0IGNvbnZlcnNpb24gZnJvbSDigJhlbnVtIDxhbm9u
eW1vdXM+4oCZIHRvIOKAmGVudW0gPGFub255bW91cz7igJkgWy0NCldlcnJvcj1lbnVtLWNvbnZl
cnNpb25dDQogIDYyMCB8ICAgICAgICBCVF9ESVNDT1ZFUllfU1RBUlRFRCksDQogICAgICB8ICAg
ICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fg0KYW5kcm9pZC90ZXN0ZXItbWFpbi5oOjY0OjIwOiBu
b3RlOiBpbiBkZWZpbml0aW9uIG9mIG1hY3JvIOKAmFRFU1RfQ0FTRV9CUkVEUkxF4oCZDQogICA2
NCB8ICAgKHN0cnVjdCBzdGVwW10pIHtfX1ZBX0FSR1NfX30sIFwNCiAgICAgIHwgICAgICAgICAg
ICAgICAgICAgIF5+fn5+fn5+fn5+DQo=
