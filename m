Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F11C282DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 18:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BAEA2067D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 18:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ziG6bDSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgAHSmY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jan 2020 13:42:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:32944 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgAHSmX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jan 2020 13:42:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 10:42:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; 
   d="scan'208";a="211631445"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 10:42:23 -0800
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jan 2020 10:42:22 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Jan 2020 10:42:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 8 Jan 2020 10:42:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGaJGWnd/bwjHilLGaRCUml2tK8S3g9rx3ov0+ycZSxnlT/67f2gd9KbxA7kSAUHw3egF1K8sulRWV4hX/Jprk708u/HvW496unoHhyQhY91kuV3yr/TACFhMuRHIAr5gjWPZ/MIfC48AC0Bey5ZO7ZINs7+kWtCkcm5CPdmHFhye51agv8bWeGEsZvlShsVgLGEduEQI61HNdmN8sh2CG5I/Lf+u5+b744y9e0q62aMPV07Z1aVPTTDyXW5sX2I8F9Ghina/dA8wapmmg56MwQbSTOuoN1xmbl+vrxjOJ7k46g3z/MrWsVf6V6dcpPwAbMwY6Dcho5cOKqtenPPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ5ZmkY/is8jwGLYHDoTJgOn+1sEsNfmYiyNqDRyPj0=;
 b=bysL2s9qpzvV5AEUEeKfK3zsXkGk6UhdagB+5sOx78d7yVVVEIwaeJgyw9V585NSw2eG5/Y2asnPzqJg4f1JJV5kwpsJx5xcYYPgvuV7c/RneTAS4Waz3MibPgrQdSyrExMIgrtYhEW71kNTj4X0eF39+Uch894D37j2sZ00ACyverrc38vJOfhGD6tzv60alDluMJeP8UZ2kfcTp9XAAEqOmQjQ1yX5UVMGyd6v59P/dGqA4Ms0HHlUYG3o7uvy6mG0TnlAHi37CKtc+4qFxuH93wEvqceor1GEqLfRB6QCVvTd7OR6njNsDLOiIfuVSMjddIbAQ/0QDRWJFJnS5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQ5ZmkY/is8jwGLYHDoTJgOn+1sEsNfmYiyNqDRyPj0=;
 b=ziG6bDSBUGvwlg3494v4loPGiZWAmYgz+CLzSUjbf2o4JInYJvmqcvR4RKfWUBCWaF5JICV2tzhZsVjqQ8wjwgLyfVIoukPD8iK8jWTjTRq5JPwjgLGrJ3rOHuQelBACRStlxUBMUWLsLqQLMpi/b/Q1iJtuIW2EKxWo8EUTg1g=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1912.namprd11.prod.outlook.com (10.175.81.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.10; Wed, 8 Jan 2020 18:42:20 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876%7]) with mapi id 15.20.2602.017; Wed, 8 Jan 2020
 18:42:20 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "rafal.gajda@silvair.com" <rafal.gajda@silvair.com>
Subject: Re: [PATCH BlueZ] mesh: Fix IV recovery
Thread-Topic: [PATCH BlueZ] mesh: Fix IV recovery
Thread-Index: AQHVxgR/8xapfAtCSUOKccW41kLVXKfhBtKAgAANDQCAAAbPAA==
Date:   Wed, 8 Jan 2020 18:42:20 +0000
Message-ID: <6a8b24b936b65c1cb58b8bb0ef3072cffa032b1f.camel@intel.com>
References: <20200108091604.15185-1-rafal.gajda@silvair.com>
         <89614c82891524958af2a7c75c1792b0c9ca4467.camel@intel.com>
         <20200108181758.kkgjtqkom4kuvzih@kynes>
In-Reply-To: <20200108181758.kkgjtqkom4kuvzih@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 19a68e8b-fc49-4f8c-33f3-08d7946a7e92
x-ms-traffictypediagnostic: CY4PR11MB1912:
x-microsoft-antispam-prvs: <CY4PR11MB1912A84518CFAF6CA089CAD1E13E0@CY4PR11MB1912.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(39860400002)(376002)(366004)(189003)(199004)(5660300002)(4326008)(316002)(6486002)(6512007)(36756003)(6916009)(71200400001)(54906003)(478600001)(186003)(66946007)(66476007)(8936002)(81156014)(91956017)(76116006)(2616005)(81166006)(6506007)(86362001)(66446008)(64756008)(66556008)(2906002)(8676002)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1912;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kW1wENgP4jZioFOMZ9lSQdjUqkfjdZyPbCXQdd4ju+0hDgnrUM+oV6Ar1ylnCRHcWvJlxvO4aIrjRthdIfEQHnDnhlWq0qT1cTlb9HDG2iUadUH9iqgHCR3y5E7uian9ri2jdeha64UIZ0Eo3YBzBoYsu+iE0hEuODJ9StJbHfWZgzlwl2K/5tH3JkesFkSmrQ3dfENhaqX//lJXRiuwASQaQpLNqIk5ULn4tBexSJrgW21RXVO8DGs3uTncA9BmxBLAsajSx/3ycQKyb9HBOGK2V8dVPOxxbKMApStUI5yZNzZ74obwqNRQ0FqtXJ0xHhWLblhuDBWEmUMlmFkH7T4m2Prh/dRynzUqL97jsYMz9hh0A80RXEy8gcxDCNdM6CRZY0AbTV81ucDSAgYg8GJ3XgbAIV0XF1KVQvz8rYOiXidCPcRbJv7zEW6r17U8
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <CD86FD042B168044BE7B50AF1EF107F9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a68e8b-fc49-4f8c-33f3-08d7946a7e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 18:42:20.5940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0SPFwq3ru2kF83efYtKpKc/HnpfZCGjak3J6bS/REc6UbdgH0hNI3RoKshXYeNqx7EfwlnL+tHZMv/fa89C5pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1912
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gV2VkLCAyMDIwLTAxLTA4IGF0IDE5OjE3ICswMTAwLCBNaWNoYcWCIExvd2FzLVJ6ZWNob25l
ayB3cm90ZToNCj4gQnJpYW4sIFJhZmHFgiwNCj4gDQo+IE9uIDAxLzA4LCBHaXgsIEJyaWFuIHdy
b3RlOg0KPiA+ID4gLQlpZiAoaXZ1ICE9IG5ldC0+aXZfdXBkYXRlIHx8IGxvY2FsX2l2X2luZGV4
ICE9IG5ldC0+aXZfaW5kZXgpIHsNCj4gPiA+ICsJaWYgKGl2dSAhPSBuZXQtPml2X3VwZGF0ZSB8
fCBpdl9pbmRleCAhPSBuZXQtPml2X2luZGV4KSB7DQo+ID4gDQo+ID4gV291bGQgaXQgYmUgZmFp
ciB0byBzYXkgdGhhdCB0aGlzIGlzIHRoZSAqb25seSogY2hhbmdlIHRvIHRoZSBjb2RlIHRoYXQg
Zml4ZXMgdGhlIGxvZ2ljIHRoYXQgd2FzDQo+ID4gbWFsZnVuY3Rpb25pbmc/DQo+IA0KPiBUaGF0
J3MgY29ycmVjdC4NCj4gDQo+ID4gSWYgc28sIEkgd291bGQgbGlrZSB0byBzaHJpbmsgdGhpcyBw
YXRjaCB0byBqdXN0Og0KPiA+IA0KPiA+IC0JaWYgKGl2dSAhPSBuZXQtPml2X3VwZGF0ZSB8fCBs
b2NhbF9pdl9pbmRleCAhPSBuZXQtPml2X2luZGV4KSB7DQo+ID4gKwlpZiAoaXZ1ICE9IGxvY2Fs
X2l2dSB8fCBpdl9pbmRleCAhPSBsb2NhbF9pdl9pbmRleCkgew0KPiA+IA0KPiA+IG9yLCBicmVh
a2luZyB0aGlzIGludG8gYSAyLXBhdGNoIHBhdGNoc2V0LCB3aGVyZSBvbmUgb2YgdGhlIHBhdGNo
ZXMgcmVtb3ZlcyB0aGUgbG9jYWwgY2FjaGluZyBvZiBpdnUgYW5kDQo+ID4gaXZpLA0KPiA+IGFu
ZCB0aGUgc2Vjb25kIHBhdGNoIGZpeGVzIHRoZSBhY3R1YWwgYnVnLg0KPiANCj4gT2ssIGxldCdz
IHNwbGl0IHRoaXMgaW50byAyIHNlcGFyYXRlIHBhdGNoZXMuIEkgc3RpbGwgdGhpbmsgdGhpcyAi
bG9jYWwNCj4gY2FjaGluZyIgd2FzIHRoZSB1bmRlcmx5aW5nIGNhdXNlIG9mIHRoZSBtaXN0YWtl
Lg0KDQpJdCBwcm9iYWJseSBtYWtlcyBtb3JlIHNlbnNlIGZvciB0aGUgKmZpcnN0KiBwYXRjaCBv
ZiB0aGUgc2V0IHRvIGZpeCB0aGUgbG9naWMgZXJyb3IsDQphbmQgd2l0aCB0aGUgc2Vjb25kIHBh
dGNoLCByZW1vdmUgdGhlIGxvY2FsIGNhY2hpbmcuLi4gIE90aGVyd2lzZSB0aGUgY2FjaGUgcmVt
b3ZhbA0KcGF0Y2ggd2lsbCBpbmNsdWRlIHRoZSBhYnN1cmRpdHkgb2YgY29tcGFyaW5nIG5ldC0+
aXZfaW5kZXggYWdhaW5zdCBpdHNlbGYuIA0KDQo+IA0KPiByZWdhcmRzDQo=
