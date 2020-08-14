Return-Path: <SRS0=Aqt4=BY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44F4C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 19:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29C22065C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Aug 2020 19:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="f8asNupI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgHNTVO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:21:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:13702 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgHNTVK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Aug 2020 15:21:10 -0400
IronPort-SDR: bvM9jGbroV69AGdDVl+sjhZ8IyeaF50V+8qRiu2MgwFbH1J8lU02Q5Nn6KUn8obJZMNuiolE/5
 YBvGCR125z8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="134542258"
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600"; 
   d="scan'208";a="134542258"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 12:21:04 -0700
IronPort-SDR: TPlx6sB/KvdPA18U7Xl6nhrnAKKgCvvNjlmbOgNr6WdSvJHPB1fdsgJIyjmC4OVvuciWJBnOVl
 4m8F12IXifkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,313,1592895600"; 
   d="scan'208";a="309468116"
Received: from orsmsx601-2.jf.intel.com (HELO ORSMSX601.amr.corp.intel.com) ([10.22.229.81])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2020 12:21:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Aug 2020 12:21:04 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 14 Aug 2020 12:21:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 14 Aug 2020 12:20:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZH2v0PKRf+420OpPA0uDz5I+tTtsqttEQDlGWW+WMX7qK1PoZo5ICIr4g2bZSOqWcavxRcF2eMHJi/Sy5d/SFyM9zu8jA97AtQkK6YF0htEvrdmsq3Xv8Su4VQjnKgjwV6jHNaoH+vDc9snfgAhkoHUcDH79LZCaGmB65nZpoSJWUio0FPMOPozttXG0O1kC6gc1TAAmTPti5xfLUjt2cJaLtcPoFTT2VVioToX8Op08mkbDfkH69z27PRhX+yAEE0FdnlWTsmYzOutuCgUOLGMIdlFBy7U89TvMI56TIFO++Y2IzDgZlbYryLYs8GoeZgikis6j7JFcPIfV+sgdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrMR+e2YXAHVOAwZBoSK6aDhWcjxWTLkKfMR6eA4xoY=;
 b=L1yBnOznW8a0djXaGIqhB2SdZ8Gw1YDYwBIiWzigvZ6wzDjF3fLvI2Sk1Xu+DVJd014kWY2EcUTqCir+tc+uACURIrMg4kj7CSExNbnlVjL2+QpOiFKFjL6ye82IglrtTaXCjVuka9PaI+mSOuWfsiM7P5mv4yYDIit2Pvbe9tUtQhXlenDhvcq8Ttp4/QTEC8np6hcNKAGRSk8+fNN6pblMKectz9pylefd+t9AJrgsnhRwh6W0uFwOj9QRRS253/A61E8DQizwdWg3Q/8YP470eXIUXlqMs6e2srlWRsYNKNKfoSDRh9QlhGg9sC9xRTdxhky2QX0QieAnxWyJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrMR+e2YXAHVOAwZBoSK6aDhWcjxWTLkKfMR6eA4xoY=;
 b=f8asNupISmmk8xCLBdijvcV7Gss5ex24opb4WRiw6VpC+4x3dcXjpmmoIC++rLaurqurWbhzB9/XkYGFm8mqg3Mv5xZE26u11uPpExQhrcSCsfzdLDJOyQI53851m7mfr1yWAnbtLjdiIyHtTTymAYQHsx1DqzTJcNv8tdw47Bk=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1487.namprd11.prod.outlook.com (2603:10b6:301:b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Fri, 14 Aug
 2020 19:20:57 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3283.015; Fri, 14 Aug 2020
 19:20:57 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "brian.gix@gmail.com" <brian.gix@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: fix double-free of outbound tx data
Thread-Topic: [PATCH BlueZ] mesh: fix double-free of outbound tx data
Thread-Index: AQHWcm8LUWsrR6ccTU6US6EW6xm9jKk3+zMA
Date:   Fri, 14 Aug 2020 19:20:57 +0000
Message-ID: <251b18820d7fe8960efae2df2ba185d7e9e59622.camel@intel.com>
References: <20200814191339.955528-1-brian.gix@intel.com>
In-Reply-To: <20200814191339.955528-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ffa0cd1-099b-4475-afcc-08d840872bc4
x-ms-traffictypediagnostic: MWHPR11MB1487:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB14876301FBC10D779193BC42E1400@MWHPR11MB1487.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xr6Qm1eUvS+igLnX0f0EabCPp8A7lDdXqwqG5XS0easd+L9R7T147fPhS/m238DF7vcx57h+Kw67cMcto9w/0tBE0kZopp2UbUYQDD+FYEjm0p+1Fpfvs238/oWfRzKQnY9RTaMWoIx+8/TbCdlkjQyudPoKkBPAM4xCWDSYmUACIa3u359JoT7FeF1wrF4iHr9vdha1PI5n6TZobHc3bLJYzN+RM/yKcxIi68TXqGYUs3i4U3ghR9nwotWWGtiav9JG1Fpd6Z7STqP1owr81smLp19i9EhBL2ap4E/XzBXisZAn9P7RtSdgkJFxbWDGuc1S/sQWxjarMVddPniCzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(6506007)(76116006)(107886003)(478600001)(66476007)(6916009)(83380400001)(86362001)(66446008)(64756008)(316002)(6486002)(66556008)(66946007)(8676002)(91956017)(8936002)(6512007)(36756003)(186003)(4326008)(5660300002)(2616005)(54906003)(71200400001)(2906002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pKEEF6iTfrNxlqfaFoiOGI7CTvU0UJyAJp3ZPpyxn3k8iycNsrcdDgxphTXvqe8TB1KlNXOxvjMBWwLU6d5l/Hw4qF9albBqXhjeYY4uFLVztjRt9O1QsB7tm4JCNBu+XzK0mq5689Ia3PLDK8ipQ8f4i9JHGlTE5eLvxCaUKovqaJMwxqs3jEC1jjkP8a1wmRoA57p74EIOHEQixU/zR9gP+Cu79xWZO9Nd8DWJnR8SkGt1aIXEqB7RtnZCrG4I2vFeH28BUMAS7ISeG5aJivW6GIRKCxa89ed54Mg0T9GYlaJyG0C3jrp2hX0cvGWnsz+4hKrsTDY9ybnRR4ooJQAiZfnRLoy0nr3z1W9G6jKNz8Tf5FCezhQsPSVcIebSz/yCS+6JpweoQXd7O0uun8WYt0QWB/+e4YZOtEEKj6dBkVyz1cB1SREBA16Rhc5Rxf/O0wi4a5Vau/WplITlyt8e/G2at/V3ObTrv9SJwO7Frbi8HaksCW2/CtBiMLUwyteZ2pD7V93wrxODa4B4xci6dIfC6rG1ctFgxmnTwNCB0q6lSzBHi6do0VUXMbbkLdFDOPFR2mqZPsi8475p5VHt1fx8Ai3PYrbYXe10HRLZ4LlfWVq58KKnfaOeKWuBBlk7LFynYQbBsDe9rYoWKg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <07B75A2BC77D4D42AC1B26E1F8CEA964@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ffa0cd1-099b-4475-afcc-08d840872bc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2020 19:20:57.0763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QW266y6qa4orBTPNSc4FQoVBNiQ033ymXuMpaBRlMeNmPiZPfJNdlBs/K9fLfPGRjcTNqlCu2lYWyFX/tarzOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1487
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gRnJpLCAyMDIwLTA4LTE0IGF0IDEyOjEzIC0wNzAwLCBCcmlhbiBHaXggd3Jv
dGU6DQo+IER1ZSB0byB0aGUgYXN5bmNyb25vdXMgbXVsdGktc3RlcCBwcm9jZXNzIHRvIHNlbmQg
YSBwYWNrZXQgb24gYW4gSENJDQo+IHNvY2tldCwgYW4gb3V0Ym91bmQgcGFja2V0IGNvdWxkIGJl
IHN1cGVyY2VkZWQgYmVmb3JlIHNlbmQgcHJvY2VkdXJlDQo+IGlzIGNvbXBsZXRlZC4gIFRoaXMg
Y2hhbmdlIGVuc3VyZXMgdGhhdCBhdCBhbnkgc3RhZ2UgaW4gdGhlIHByb2Nlc3MsDQo+IHRoYXQg
dGhlIHBvaW50ZXIgdG8gdGhlIHBhY2tldCBoYXMgYmVlbiBmdWxseSBkaXNwb3NlZC4NCj4gLS0t
DQo+ICBtZXNoL21lc2gtaW8tZ2VuZXJpYy5jIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzEgaW5zZXJ0aW9ucygrKSwg
MjEgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tZXNoLWlvLWdlbmVyaWMu
YyBiL21lc2gvbWVzaC1pby1nZW5lcmljLmMNCj4gaW5kZXggNGIyNmIxMTgxLi42N2IxM2ExYjkg
MTAwNjQ0DQo+IC0tLSBhL21lc2gvbWVzaC1pby1nZW5lcmljLmMNCj4gKysrIGIvbWVzaC9tZXNo
LWlvLWdlbmVyaWMuYw0KPiBAQCAtMzI5LDYgKzMyOSwzMCBAQCBzdGF0aWMgdm9pZCBzY2FuX2Rp
c2FibGVfcnNwKGNvbnN0IHZvaWQgKmJ1ZiwgdWludDhfdCBzaXplLA0KPiAgCQkJc2V0X3JlY3Zf
c2Nhbl9lbmFibGUsIHB2dCwgTlVMTCk7DQo+ICB9DQo+ICANCj4gK3N0YXRpYyBib29sIHNpbXBs
ZV9tYXRjaChjb25zdCB2b2lkICphLCBjb25zdCB2b2lkICpiKQ0KPiArew0KPiArCXJldHVybiBh
ID09IGI7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBib29sIGZpbmRfYnlfYWRfdHlwZShjb25zdCB2
b2lkICphLCBjb25zdCB2b2lkICpiKQ0KPiArew0KPiArCWNvbnN0IHN0cnVjdCB0eF9wa3QgKnR4
ID0gYTsNCj4gKwl1aW50OF90IGFkX3R5cGUgPSBMX1BUUl9UT19VSU5UKGIpOw0KPiArDQo+ICsJ
cmV0dXJuICFhZF90eXBlIHx8IGFkX3R5cGUgPT0gdHgtPnBrdFswXTsNCj4gK30NCj4gKw0KPiAr
c3RhdGljIGJvb2wgZmluZF9ieV9wYXR0ZXJuKGNvbnN0IHZvaWQgKmEsIGNvbnN0IHZvaWQgKmIp
DQo+ICt7DQo+ICsJY29uc3Qgc3RydWN0IHR4X3BrdCAqdHggPSBhOw0KPiArCWNvbnN0IHN0cnVj
dCB0eF9wYXR0ZXJuICpwYXR0ZXJuID0gYjsNCj4gKw0KPiArCWlmICh0eC0+bGVuIDwgcGF0dGVy
bi0+bGVuKQ0KPiArCQlyZXR1cm4gZmFsc2U7DQo+ICsNCj4gKwlyZXR1cm4gKCFtZW1jbXAodHgt
PnBrdCwgcGF0dGVybi0+ZGF0YSwgcGF0dGVybi0+bGVuKSk7DQo+ICt9DQo+ICsNCj4gIHN0YXRp
YyBib29sIGZpbmRfYWN0aXZlKGNvbnN0IHZvaWQgKmEsIGNvbnN0IHZvaWQgKmIpDQo+ICB7DQo+
ICAJY29uc3Qgc3RydWN0IHB2dF9yeF9yZWcgKnJ4X3JlZyA9IGE7DQo+IEBAIC01MzMsOCArNTU3
LDEwIEBAIHN0YXRpYyB2b2lkIHNldF9zZW5kX2Fkdl9kYXRhKGNvbnN0IHZvaWQgKmJ1ZiwgdWlu
dDhfdCBzaXplLA0KPiAgCQkJCQkmY21kLCBzaXplb2YoY21kKSwNCj4gIAkJCQkJc2V0X3NlbmRf
YWR2X2VuYWJsZSwgcHZ0LCBOVUxMKTsNCj4gIGRvbmU6DQo+IC0JaWYgKHR4LT5kZWxldGUpDQo+
ICsJaWYgKHR4LT5kZWxldGUpIHsNCj4gKwkJbF9xdWV1ZV9yZW1vdmVfaWYocHZ0LT50eF9wa3Rz
LCBzaW1wbGVfbWF0Y2gsIHR4KTsNCj4gIAkJbF9mcmVlKHR4KTsNCj4gKwl9DQo+ICANCj4gIAlw
dnQtPnR4ID0gTlVMTDsNCj4gIH0NCj4gQEAgLTU2OSw4ICs1OTUsMTEgQEAgc3RhdGljIHZvaWQg
c2VuZF9wa3Qoc3RydWN0IG1lc2hfaW9fcHJpdmF0ZSAqcHZ0LCBzdHJ1Y3QgdHhfcGt0ICp0eCwN
Cj4gIHsNCj4gIAlzdHJ1Y3QgYnRfaGNpX2NtZF9sZV9zZXRfYWR2X2VuYWJsZSBjbWQ7DQo+ICAN
Cj4gLQlpZiAocHZ0LT50eCAmJiBwdnQtPnR4LT5kZWxldGUpDQo+ICsJLyogRGVsZXRlIHN1cGVy
c2VkZWQgcGFja2V0IGluIGZhdm9yIG9mIG5ldyBwYWNrZXQgKi8NCj4gKwlpZiAocHZ0LT50eCAm
JiBwdnQtPnR4ICE9IHR4ICYmIHB2dC0+dHgtPmRlbGV0ZSkgew0KPiArCQlsX3F1ZXVlX3JlbW92
ZV9pZihwdnQtPnR4X3BrdHMsIHNpbXBsZV9tYXRjaCwgcHZ0LT50eCk7DQo+ICAJCWxfZnJlZShw
dnQtPnR4KTsNCj4gKwl9DQo+ICANCj4gIAlwdnQtPnR4ID0gdHg7DQo+ICAJcHZ0LT5pbnRlcnZh
bCA9IGludGVydmFsOw0KPiBAQCAtNzMzLDI1ICs3NjIsNiBAQCBzdGF0aWMgYm9vbCBzZW5kX3R4
KHN0cnVjdCBtZXNoX2lvICppbywgc3RydWN0IG1lc2hfaW9fc2VuZF9pbmZvICppbmZvLA0KPiAg
CXJldHVybiB0cnVlOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgYm9vbCBmaW5kX2J5X2FkX3R5cGUo
Y29uc3Qgdm9pZCAqYSwgY29uc3Qgdm9pZCAqYikNCj4gLXsNCj4gLQljb25zdCBzdHJ1Y3QgdHhf
cGt0ICp0eCA9IGE7DQo+IC0JdWludDhfdCBhZF90eXBlID0gTF9QVFJfVE9fVUlOVChiKTsNCj4g
LQ0KPiAtCXJldHVybiAhYWRfdHlwZSB8fCBhZF90eXBlID09IHR4LT5wa3RbMF07DQo+IC19DQo+
IC0NCj4gLXN0YXRpYyBib29sIGZpbmRfYnlfcGF0dGVybihjb25zdCB2b2lkICphLCBjb25zdCB2
b2lkICpiKQ0KPiAtew0KPiAtCWNvbnN0IHN0cnVjdCB0eF9wa3QgKnR4ID0gYTsNCj4gLQljb25z
dCBzdHJ1Y3QgdHhfcGF0dGVybiAqcGF0dGVybiA9IGI7DQo+IC0NCj4gLQlpZiAodHgtPmxlbiA8
IHBhdHRlcm4tPmxlbikNCj4gLQkJcmV0dXJuIGZhbHNlOw0KPiAtDQo+IC0JcmV0dXJuICghbWVt
Y21wKHR4LT5wa3QsIHBhdHRlcm4tPmRhdGEsIHBhdHRlcm4tPmxlbikpOw0KPiAtfQ0KPiAtDQo+
ICBzdGF0aWMgYm9vbCB0eF9jYW5jZWwoc3RydWN0IG1lc2hfaW8gKmlvLCBjb25zdCB1aW50OF90
ICpkYXRhLCB1aW50OF90IGxlbikNCj4gIHsNCj4gIAlzdHJ1Y3QgbWVzaF9pb19wcml2YXRlICpw
dnQgPSBpby0+cHZ0Ow0K
