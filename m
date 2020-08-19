Return-Path: <SRS0=ZhIC=B5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3489EC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 03:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00AE32065F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Aug 2020 03:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="wH3eTDVs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgHSDM7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Aug 2020 23:12:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:17186 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgHSDM6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Aug 2020 23:12:58 -0400
IronPort-SDR: KYeUWiPjLtqXyJPTHpXTtpHGGOieCGGCUSg944goWW9fNldmDmI5OOfpWV8sJyAA6e93XFkCiz
 Ln91oM9TexUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="216564635"
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="216564635"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 20:12:57 -0700
IronPort-SDR: EL9dASr36AJvHM5zL57VzNE04q65oz6C7nVqq8xpnCM0MHu1DK9ARrtxrH+H+GuvJiZEloMzd2
 qOAGsTIYtXfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,329,1592895600"; 
   d="scan'208";a="292970639"
Received: from orsmsx602-2.jf.intel.com (HELO ORSMSX602.amr.corp.intel.com) ([10.22.229.82])
  by orsmga003.jf.intel.com with ESMTP; 18 Aug 2020 20:12:57 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Aug 2020 20:12:56 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Aug 2020 20:12:56 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 18 Aug 2020 20:12:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Aug 2020 20:12:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rap4+kT2m8VyelJ9+ThuX2TBg+KVH6JIisVxPigc4KhMS0czme+rGsmt7bnfNMHMWr/q/YJAS7Y1Oc3pIry4NQWf0I23+6Qf5SkvgzNkdOsUPYkgwtPQSsFbCwCx2EvDlXV9y6ilzSddR/28X/tNxr7Jzli9nBFyRxyWYqV0Lp74xNFRCwMjxG2VulDf2QMLAwOf9biziIvNWvy6SDGKiE317rNqBXyvlP5uiuTCMPr+lt3L6PLwZngszbwPMKwpPauVJb/BTJMWFp5DLJtz4SW1Kos5gGjQHXaGbGvokmzFG1tXi/xXIx2HKS6OCFsVmoSDC9b70iamEqy8r19rlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWGo23ebG+CsALybDC/46kfUIULfeFSh1h5D6TZbU3c=;
 b=aakCzr4UX5dnP36e7g1pHfQ5wPW0JC4bBrQBFewkVmDs1eWxBzuGVOQRoCr3hFAsjtpcJ5a7911TIu6ofpZAORYmN+eREpqFHQR7axuyNx4FvPL75RaYm4TCShOrebr+BSr1/tfgwaXnDQCaJ98aTfMy3FHBrMTcolGfp6OqazRr5I7KikbDxRDNsugUpLCkyJJkDYJ3Y6LkEpxwK0b/WzQg01JsBMN/UhfaXoKo0YasaqhCDo2JWau2VgFdQ933jOAwLyE1ZKZMpS5999BaYaUofLhWvpCWQ99pxi6266xR0yi6LXFbrvSQBy0imEOuNhS+/Gz5S7BXKdlcXf+SiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PWGo23ebG+CsALybDC/46kfUIULfeFSh1h5D6TZbU3c=;
 b=wH3eTDVsKMhb0iarHYNFdX0KnpJYq3Xa+MSVQ+tAiKQzk+U3qnNzEWhHDDG4PGJ8xplRHRi6X7Et9M4lsPFxhMwaoWtUGwGDB3oAu76SCf6iUJEkg7D1J3DB94GGufMxGRR1ex6SqpbK2WrDtT/uew+nAyktIOUMjgJpZ+hP+6g=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB2032.namprd11.prod.outlook.com (2603:10b6:300:2b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Wed, 19 Aug
 2020 03:12:54 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3305.024; Wed, 19 Aug 2020
 03:12:54 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "daan@dptechnics.com" <daan@dptechnics.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/1] Fixed issue in bluetooth-meshd which causes HCI
 error 0x12 when LE scanning is enabled because no random address was set.
 This is fixed by using the default HCI own device address option.
Thread-Topic: [PATCH BlueZ 1/1] Fixed issue in bluetooth-meshd which causes
 HCI error 0x12 when LE scanning is enabled because no random address was set.
 This is fixed by using the default HCI own device address option.
Thread-Index: AQHWdX/jPZsUrHlCZ0G9hl3GnNaX2Kk+wjyA
Date:   Wed, 19 Aug 2020 03:12:54 +0000
Message-ID: <0231dfc480da9571cc609f06f5d1155c9d2a0bb0.camel@intel.com>
References: <20200818163611.57656-1-daan@dptechnics.com>
         <20200818163611.57656-2-daan@dptechnics.com>
In-Reply-To: <20200818163611.57656-2-daan@dptechnics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: dptechnics.com; dkim=none (message not signed)
 header.d=none;dptechnics.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c213b197-7b56-473d-7abb-08d843edc420
x-ms-traffictypediagnostic: MWHPR11MB2032:
x-microsoft-antispam-prvs: <MWHPR11MB20320805A83EB00D561DA11FE15D0@MWHPR11MB2032.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ogBbWHYe/IDKYKB5svPvFeZbTh2+qKTv31pzebSwKRxvHKPeD/jwEzFtRYKGt4qZv30xO0+B9gIHgzWay3hKqtCtIzvE2r55MlinBsT9OQvoMy1wpUkgBzW7vINCGcXVfp435nD2uVqTW6n+04ivtgXAe5cMyJx5gVtXmBa0XiNOOhQYmNBdLw93jn8gayYp39pcC3FZ07DKI33veFjEySfVtb2EG2poA3O9Om8rX9o4HZkstoJZe6J3wCJYmtY7kllGzJ+S9MFwUj6eKKkqEzac3QD209fWgdPB6yc/PNjnOY9hB8FV814A+OlvCISiA6Zbasx26peS2zKW3Fikvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(2616005)(8936002)(478600001)(86362001)(36756003)(2906002)(66446008)(66946007)(8676002)(66556008)(66476007)(6486002)(71200400001)(76116006)(64756008)(110136005)(26005)(6512007)(6506007)(5660300002)(316002)(91956017)(83380400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: URd6+3C1KIGzPooNzrNoir95RpeDLT+z5z6dIVfjTbAKG2iiQI50O/mpdB2uWgOsIPSq2EP+gLm4j0lDeX6mqlucV+POffkW0rQGiuQfuW9Lgz95LUJRQIQZPfhfLH9sSqTZjBwKdJochbKkA+uEgy9CPA4RL3vQ1suDLOuL699drIFD9Vxybz+pWB8J+o0NyJc839TpzTJE8PWbaOkHmTxeCTq2Mux1W5bfD/rIGIyGjMtC/YNgS177hPAZHcVCj3+spk+QZ1xEk+brJACCbTD1PZG1kNWck8VAjOdE9CvxmbIP09U7YhynmHA9/10FSdie6ALF4dU2Hw7012586E8Ayec/vZZ7Q+AfSTwd4196Jwg4YPIGcAc1eAFwtRB6OGdl2FKpJbxxf5tYeToKei3rAnaR2IeLmvG35NsfqVA0nV3w29gG8qfWVP7SXq8W1KpyCrAkRj05DlmH7jXL8czMf22fR2kb1PU80PBR6Qf03B3I1hutzw9ww1uyX9xFii3FWpvjeEErGw55KmS9MRxSb/iZ5UVJeLFzu/csHC/NU3PgnVgsBcnPJvGqpju/vuSCzN7CJs1Rh0ODfji+cVIFS1i6Ch/LTj/ckfRfkApQq4+YSPK8sSNXFYrMqmU5JyBxUmoewl4POAv+Tf3fEg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5F86B10FA27F143A305CB0C1485D1C6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c213b197-7b56-473d-7abb-08d843edc420
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 03:12:54.8344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Soxb3dz6k4rQysGZnJX33E7CMmX0tOuanbsh9w3EqiNuLLsIvbrCm7rAyM2rpbuzzDXng/yp0VKT8RBpJbJc7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB2032
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgRGFhbiwNCg0KT24gVHVlLCAyMDIwLTA4LTE4IGF0IDE4OjM2ICswMjAwLCBEYWFuIFBhcGUg
d3JvdGU6DQo+IC0tLQ0KPiAgbWVzaC9tZXNoLWlvLWdlbmVyaWMuYyB8IDQgKystLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9tZXNoL21lc2gtaW8tZ2VuZXJpYy5jIGIvbWVzaC9tZXNoLWlvLWdlbmVyaWMuYw0K
PiBpbmRleCA2N2IxM2ExYjkuLjY1ZmQxYzdiOSAxMDA2NDQNCj4gLS0tIGEvbWVzaC9tZXNoLWlv
LWdlbmVyaWMuYw0KPiArKysgYi9tZXNoL21lc2gtaW8tZ2VuZXJpYy5jDQo+IEBAIC0zMjEsNyAr
MzIxLDcgQEAgc3RhdGljIHZvaWQgc2Nhbl9kaXNhYmxlX3JzcChjb25zdCB2b2lkICpidWYsIHVp
bnQ4X3Qgc2l6ZSwNCj4gIAljbWQudHlwZSA9IHB2dC0+YWN0aXZlID8gMHgwMSA6IDB4MDA7CS8q
IFBhc3NpdmUvQWN0aXZlIHNjYW5uaW5nICovDQo+ICAJY21kLmludGVydmFsID0gTF9DUFVfVE9f
TEUxNigweDAwMTApOwkvKiAxMCBtcyAqLw0KPiAgCWNtZC53aW5kb3cgPSBMX0NQVV9UT19MRTE2
KDB4MDAxMCk7CS8qIDEwIG1zICovDQo+IC0JY21kLm93bl9hZGRyX3R5cGUgPSAweDAxOwkJLyog
QUREUl9UWVBFX1JBTkRPTSAqLw0KPiArCWNtZC5vd25fYWRkcl90eXBlID0gMHgwMDsgCQkvKiBQ
dWJsaWMgRGV2aWNlIEFkZHJlc3MgKi8NCj4gIAljbWQuZmlsdGVyX3BvbGljeSA9IDB4MDA7CQkv
KiBBY2NlcHQgYWxsICovDQo+ICANCg0KT3VyIHBvbGljeSBpcyB0byAqYWx3YXlzKiB1c2UgcmFu
ZG9tIGFkZHJlc3NpbmcgZm9yIG91dGJvdW5kIG1lc2ggYWRkcmVzc2luZy4gIFNvIGlmIHRoaXMg
aXMgdGhlIHJvb3QgY2F1c2Ugb2YNCnRoZSB3YXJuaW5nLCB3ZSB3aWxsIHdhbnQgdG8gZml4IGl0
IGluIHN1Y2ggYSB3YXkgdGhhdCByYW5kb20gYWRkcmVzc2luZyB3b3Jrcy4gIFRoaXMgc2hvdWxk
IG9ubHkgYmUgYW4gaXNzdWUNCndoZW4gc3RhcnRpbmcgdXAsIHNvIHBlcmhhcHMgd2UganVzdCBu
ZWVkIHRvIGFkZCBhIHJhbmRvbSBhZGRyZXNzIHNldCBpbnRvIHRoZSBzdGFydHVwIGNvbW1hbmQg
Y2hhaW4uIA0KDQo+ICAJYnRfaGNpX3NlbmQocHZ0LT5oY2ksIEJUX0hDSV9DTURfTEVfU0VUX1ND
QU5fUEFSQU1FVEVSUywNCj4gQEAgLTU3OSw3ICs1NzksNyBAQCBzdGF0aWMgdm9pZCBzZXRfc2Vu
ZF9hZHZfcGFyYW1zKGNvbnN0IHZvaWQgKmJ1ZiwgdWludDhfdCBzaXplLA0KPiAgCWNtZC5taW5f
aW50ZXJ2YWwgPSBMX0NQVV9UT19MRTE2KGhjaV9pbnRlcnZhbCk7DQo+ICAJY21kLm1heF9pbnRl
cnZhbCA9IExfQ1BVX1RPX0xFMTYoaGNpX2ludGVydmFsKTsNCj4gIAljbWQudHlwZSA9IDB4MDM7
IC8qIEFEVl9OT05DT05OX0lORCAqLw0KPiAtCWNtZC5vd25fYWRkcl90eXBlID0gMHgwMTsgLyog
QUREUl9UWVBFX1JBTkRPTSAqLw0KPiArCWNtZC5vd25fYWRkcl90eXBlID0gMHgwMDsgLyogUHVi
bGljIERldmljZSBBZGRyZXNzICovDQo+ICAJY21kLmRpcmVjdF9hZGRyX3R5cGUgPSAweDAwOw0K
PiAgCW1lbXNldChjbWQuZGlyZWN0X2FkZHIsIDAsIDYpOw0KPiAgCWNtZC5jaGFubmVsX21hcCA9
IDB4MDc7DQo=
