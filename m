Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CF0C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 17:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3FA12076A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 17:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="DYXd63Hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbgCZRDx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:03:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:14973 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726401AbgCZRDx (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 13:03:53 -0400
IronPort-SDR: TBB6QEl63r0I3ggjdKutvZrHUvPUrIWql8tnTtvGFjOA1YSjU+meR14sxFl+9iVMZARgigJXcr
 U878MMuGfHnQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 10:03:43 -0700
IronPort-SDR: SrPVPZy4LG3kXaN8Jcf7by2f1x6gdq7JLlKTxt19suLxwC5GLADSTIsFt0XKCwWrRrygS5PGkP
 klCo5Onmy3BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="240729388"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2020 10:03:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 10:03:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 10:03:42 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 10:03:42 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 26 Mar 2020 10:03:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvNQBq7yDsQRzpfAiaij9UrQeN6OQI2ekWPqSYm95NYVAgFxh+bJBeDDOkhDKw4Iu5DRSEWO/AlCDeD2NdkbadSIo1qYlQItGDQWHEd6kWLcR9wBPyBKDGSOMJ0iHfTXW6rSbgm99ECnskIonMF5NPhGPi/AN0JSVLgSVuVb/1tgZIEqvRTnwjTH2cjBxRpGewgj/h1ZjtU2ljqwZ1h3/7qtZMCKujni+ss4hwbVJD5jj7ItPXzcOsd2uK7A/J6JAwI2X6XfsoX6HZYIwhwx8U1TKTW8z3J1nx+BYab0Ax+MzfR9sCB75viYk0T2wZu2IFB4+xODxq3uObOTYGw11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z2azhlnux4crerqLGMYVjocwDZbAE+xeJ4ckUjNTnI=;
 b=gvOPl5S7+jEzYI/E6iH42UXFUyxMrsRbRCTYtI+LDxsFClWGGvzJjBer3s+vOY/8fA3jSfpMNNvfQwG2XQX+tg2kpZeuqDzRl5vrNBiqIOykdRZzA8c5v+/cwr60gumvvMifD0Gn76b+BrCLLt4sGEzJxzafw2N6Uy/8CANyQszty3fPxIjFSVD98aX+hAdx6pXcjuIpZ17sj9V1sb9J4CgtxZMqWUEoj/swZEE8q5IiP40I6cBkSa4BET8Y2geR+bqgkxuCDXXNQ+v4PXqCUhs+VuWcRFw3L92TsUKQhlnmYeBMt13tC/F7sYWxQXgJ5YPETT5prE7CKQ33BalOHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Z2azhlnux4crerqLGMYVjocwDZbAE+xeJ4ckUjNTnI=;
 b=DYXd63HvEkyJ+OHVh0JXyzzWkJreoLKpmZ3h3NpR0O9OeEWh5dv2+t1ilu+vLd1Clj5pPwjZ0emtuAeJgJQ5yS/W1bNYmUswnhUgl0I0LTMYDe6KXZ4RIU4eKqMJnk/K96z3g/cyQMhKTKToev9mM4cqq5B2MJ6lpSQgBCACAmw=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Thu, 26 Mar
 2020 17:03:39 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 17:03:39 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "prathyusha.n@samsung.com" <prathyusha.n@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "s.syam@samsung.com" <s.syam@samsung.com>
Subject: Re: [PATCH 1/1] mesh: Handle netkey delete when netkey is not in
 netkeylist
Thread-Topic: [PATCH 1/1] mesh: Handle netkey delete when netkey is not in
 netkeylist
Thread-Index: AQHWAhJ+SXRJf/qQEUO2mWL81gowvahbHNaA
Date:   Thu, 26 Mar 2020 17:03:39 +0000
Message-ID: <d429b3092ce4b164819388533129b41a410ff593.camel@intel.com>
References: <1585078044-14974-1-git-send-email-prathyusha.n@samsung.com>
         <CGME20200324192824epcas5p1de37a38491d79ea6dca2cc5da50cd289@epcas5p1.samsung.com>
         <1585078044-14974-7-git-send-email-prathyusha.n@samsung.com>
In-Reply-To: <1585078044-14974-7-git-send-email-prathyusha.n@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8213a07e-2b21-4056-7b04-08d7d1a7a1aa
x-ms-traffictypediagnostic: MW3PR11MB4682:
x-microsoft-antispam-prvs: <MW3PR11MB46826FB8304A0700B027F48DE1CF0@MW3PR11MB4682.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(346002)(136003)(39860400002)(366004)(110136005)(66476007)(66556008)(316002)(6506007)(64756008)(66446008)(2616005)(36756003)(91956017)(76116006)(8936002)(66946007)(4326008)(478600001)(81166006)(6512007)(8676002)(186003)(6486002)(5660300002)(2906002)(26005)(71200400001)(4744005)(81156014)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4682;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jDjWv46fNgmWeJJkX+yWDPWEXOiahtZIxXRsksVZBsZ00JJrJOwsOnvY2262kxC9AR1lZTuUk/WBYFZei54hcMWLZaWENpCLS9hpluJwoywZh2s1Qc7mXsX2aurW9yNPly0wBguheVWbd43K47EaGpa07N6uSPoQPD8sIVJL8j0XjhFnFW1f2BD9hBNuXly+n5OvAIdg+5sbEMnbqPsjjxPcmY7cZvXwknAEXcsDHvvTIUdXSeWCyT/Ji8xjuad/2PZS9lNai50Mt2Od/xGh0rIq8fgfshUZwRDFtOW757we0S2tt4moqdQS8mcSGJJkfzulww9nnGrgideMuzIzkUY+GRBxU7vXaXx3DuWcHnG/ATwIf45/ZSnXS/bKNfbwqrjvcsUAileTptvgD30K9OVnPadIkRfSeshp6BDhWcmDVECY6hnSm43AyzrXeH6I
x-ms-exchange-antispam-messagedata: qwqISmp7cQ9y46gP+6Wf3jB+iGaTeUDKwHR54y4uGfCkYGOunr5Qa1OTn9B70A9JAB/SZqT8hSlaV1BbaaWCWHgs0gRiDEexwTuzgse5O0qipY156qza2kmdYBe3aamxJgs1d1+Lbg3ED47QoGQV7g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CFCD063326E72E48AD30EEB5C333EAFE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8213a07e-2b21-4056-7b04-08d7d1a7a1aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 17:03:39.2657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IF7Lqz4bL3khjHdZ7dU7tjtP81QBBMB/WCw2F22grT+4Z4t141+qQnb04pgBanCakLxRyi1T8GpTpPZk4MLIfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAzLTI1IGF0IDAwOjU3ICswNTMwLCBQcmF0aHl1c2hhIE5l
bGx1cmkgd3JvdGU6DQo+IEZyb206IFByYXRoeXVzaGEgTiA8cHJhdGh5dXNoYS5uQHNhbXN1bmcu
Y29tPg0KPiANCj4gNC40LjEuMi45IG9mIE1lc2ggUHJvZmlsZSBCbHVldG9vdGggc3BlY2lmaWNh
dGlvbjoNCj4gV2hlbiBhbiBlbGVtZW50IHJlY2VpdmVzIGEgQ29uZmlnIE5ldEtleSBEZWxldGUg
bWVzc2FnZSB0aGF0DQo+IGlkZW50aWZpZXMgYSBOZXRLZXkgdGhhdCBpcyBub3QgaW4gdGhlIE5l
dEtleSBMaXN0LCBpdA0KPiByZXNwb25kcyB3aXRoIFN1Y2Nlc3MsIGJlY2F1c2UgdGhlIHJlc3Vs
dCBvZiBkZWxldGluZyB0aGUNCj4ga2V5IHRoYXQgZG9lcyBub3QgZXhpc3QgaW4gdGhlIE5ldEtl
eSBMaXN0IHdpbGwgYmUgdGhlIHNhbWUNCj4gYXMgaWYgdGhlIGtleSB3YXMgZGVsZXRlZCBmcm9t
IHRoZSBOZXRLZXkgTGlzdC4NCj4gLS0tDQo+ICBtZXNoL25ldC5jIHwgMiArLQ0KPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvbWVzaC9uZXQuYyBiL21lc2gvbmV0LmMNCj4gaW5kZXggZWMwNWI2YmU5Li4zNTQ2Yjg3ZDAg
MTAwNjQ0DQo+IC0tLSBhL21lc2gvbmV0LmMNCj4gKysrIGIvbWVzaC9uZXQuYw0KPiBAQCAtOTQx
LDcgKzk0MSw3IEBAIGludCBtZXNoX25ldF9kZWxfa2V5KHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1
aW50MTZfdCBpZHgpDQo+ICAJc3VibmV0ID0gbF9xdWV1ZV9maW5kKG5ldC0+c3VibmV0cywgbWF0
Y2hfa2V5X2luZGV4LA0KPiAgCQkJCQkJCUxfVUlOVF9UT19QVFIoaWR4KSk7DQo+ICAJaWYgKCFz
dWJuZXQpDQo+IC0JCXJldHVybiBNRVNIX1NUQVRVU19DQU5OT1RfUkVNT1ZFOw0KPiArCQlyZXR1
cm4gTUVTSF9TVEFUVVNfU1VDQ0VTUzsNCj4gIA0KPiAgCS8qIERlbGV0ZSBhc3NvY2lhdGVkIGFw
cCBrZXlzICovDQo+ICAJYXBwa2V5X2RlbGV0ZV9ib3VuZF9rZXlzKG5ldCwgaWR4KTsNCg==
