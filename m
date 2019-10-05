Return-Path: <SRS0=lq+R=X6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CDDC4740A
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Oct 2019 16:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70236222CC
	for <linux-bluetooth@archiver.kernel.org>; Sat,  5 Oct 2019 16:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="NiIYL5gE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbfJEQOS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 5 Oct 2019 12:14:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:33952 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726114AbfJEQOS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 5 Oct 2019 12:14:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2019 09:14:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,260,1566889200"; 
   d="scan'208";a="393853862"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga006.fm.intel.com with ESMTP; 05 Oct 2019 09:14:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 5 Oct 2019 09:14:17 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 5 Oct 2019 09:14:16 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 5 Oct 2019 09:14:16 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.56) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sat, 5 Oct 2019 09:14:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5x4S/163ltY5zg5Ors7Xh8/E29JCK65AenlMYLroDma5sr06PmZEbO5wVqYfzdTqg8n4TIg072hSOSjv/7D4RPWXD+cisfAIVtgGz/MjkXXa1RK1y1jeMk3frqrbfxFjgY8q8ZDSMAf76DHzX2pnQE+FFbxmnDvxwLqlAlXzL06oeFvkQQD1j0p0ZsGZdjbcBje8voQXBNswZSb3yNxdBG6VeUQQ/R9dfJ+sr5OcCCr93TAIO/Wo/diJoMTkyX8RD6C5kgCt4W7QiIAB6InXygipkTIDJce4ASrDIuUocFfvfI9qD/LufPUMLIq70ytHnErkhGddbT6ZaSBMqIbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIHWKYayyLmU0/qyjfBdfUlPJ3f7AGGcJqHYixduZ4c=;
 b=UhKo2ntpxrqhZ6cbdJKLztWa8LdA5iSEjCRTurap7y2arUYDp6libmoH25Rl8/YeWEpu/gy60SB96kvtvqn/F5whZeMGukC1Ap7S1PQFDjAF0oszI8IYQHQNlX+zuM5bXN9SbiXuBYeFgff4h+OL6mpHpwlRNwkYEA/AznJzejW+Fnqg1tD9gUIgZR4C++HGfTonE8yQiUGsciblGVNkNaTjrGurT9mpJbPAELTljEVeVv03LJz43fOMgB5zx3nw7LjgYmbj5Luw2ZieZ+c3jXY5iN/PfHwcRJ+1xNQOZu7Xv0RQchvarT2oSfmDkzs/yQeY18aK92oSYqnZPbMXpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIHWKYayyLmU0/qyjfBdfUlPJ3f7AGGcJqHYixduZ4c=;
 b=NiIYL5gEx+2bm5OQmi/k+GNxw18lLP10ObgBH2paqlgK6G3jLIyiCHRs/F3LsSTwRyl7dbXQARQzY2EWWSCa1KAqStGbm46cWVLka8lej1qk0ZIFTmkZLLVRPd9is2BcTuPc1N4Jl6OgETXGBV77wBtBlWSWsrFhZHoz3YcZO9o=
Received: from CH2PR11MB4407.namprd11.prod.outlook.com (10.186.149.28) by
 CH2PR11MB4504.namprd11.prod.outlook.com (10.186.149.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Sat, 5 Oct 2019 16:14:13 +0000
Received: from CH2PR11MB4407.namprd11.prod.outlook.com
 ([fe80::f9fc:2de:f3c9:217e]) by CH2PR11MB4407.namprd11.prod.outlook.com
 ([fe80::f9fc:2de:f3c9:217e%6]) with mapi id 15.20.2327.023; Sat, 5 Oct 2019
 16:14:13 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "istotlan@ingas-xps13.amr.corp.intel.com" 
        <istotlan@ingas-xps13.amr.corp.intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix segmentation fault on Join() call
Thread-Topic: [PATCH BlueZ] mesh: Fix segmentation fault on Join() call
Thread-Index: AQHVeIlCXbCZ5pjXfUmb1dPpTHXMB6dMPscA
Date:   Sat, 5 Oct 2019 16:14:13 +0000
Message-ID: <20fd4bb031257b375840767940315af8c2aab6f3.camel@intel.com>
References: <20191001185108.5656-1-inga.stotland@intel.com>
In-Reply-To: <20191001185108.5656-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5c5d623-c628-49ec-9946-08d749af101c
x-ms-traffictypediagnostic: CH2PR11MB4504:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR11MB4504C7A291F440E4F617C584E1990@CH2PR11MB4504.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0181F4652A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(136003)(376002)(39850400004)(366004)(199004)(189003)(91956017)(5660300002)(4326008)(66066001)(316002)(110136005)(6512007)(6486002)(6246003)(6436002)(81166006)(81156014)(8676002)(76116006)(476003)(486006)(66946007)(66476007)(66556008)(64756008)(66446008)(2616005)(446003)(14444005)(256004)(8936002)(76176011)(11346002)(36756003)(6116002)(3846002)(6506007)(2906002)(26005)(186003)(102836004)(478600001)(25786009)(6636002)(14454004)(86362001)(71200400001)(7736002)(2501003)(71190400001)(99286004)(305945005)(118296001)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR11MB4504;H:CH2PR11MB4407.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NANmO95jA85dcFAHkLWIBLSbzUPg6aoSOZRvcOZJ5qHS+8YKDcFukszS6I8WIZzUEuFlyz2/74dbTBiNF2nNQk0GqnxTqozVkKogTJ4trLOHEp+NHjQqMLfNRNVhuXDV7OgGkhCr+RPedWiTASGzVxFWrv/9REpDOH7z9pMQehSwRUIpabK7Zv1AJ7NRJKK4or523qroeYleCtLyW7rZeFnUqrHyAdcoWL2GS2E+LGLZ10I4uggKhHkqXoDRtcQvjAFXfF4aisdM3MzYNcbFl052BbcnKgOXIKlmz6OP1JZocN2XxfKUy+N2+a3rtqmQJdrefMcnVSRwsehkB/T+NwcKqRdTL7kkw+83KSpTCVeC6YAA5gXMNWWAk4+D7WapDvG5Rrtojm9L1ws8FK2VeyJKcTTD6Y/4eqW5Y1t3lvQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9F2E1F83F2CCB04C94C9C4E033D017B6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c5d623-c628-49ec-9946-08d749af101c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2019 16:14:13.3119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5CPN2Q1CtXI38Uw4GnBASY6o/9OK1pek3jpCYdZxPeAlMaCMF5s8k5TDSw0XHkQ5FxwvWLDAYrKRtXkqRc4tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4504
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUdWUsIDIwMTktMTAtMDEgYXQgMTE6NTEgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IEZyb206IEluZ2EgU3RvdGxhbmQgPGlzdG90bGFuQGluZ2FzLXhwczEzLmFt
ci5jb3JwLmludGVsLmNvbT4NCj4gDQo+IFRoaXMgZml4ZXMgdGhlIGZvbGxvd2luZyBzZWdmYXVs
dDoNCj4gDQo+IG5vZGVfaW5pdF9jYiAobm9kZT0weDAsIGFnZW50PTB4MCkgYXQgbWVzaC9tZXNo
LmM6MzU5DQo+ICAgICAgICAgcmVwbHkgPSBkYnVzX2Vycm9yKGpvaW5fcGVuZGluZy0+bXNnLCBN
RVNIX0VSUk9SX0ZBSUxFRCwNCj4gDQo+ICAgICAgICAgdXNlcl9kYXRhPTB4NTU1NTU1NWJlMTcw
KSBhdCBtZXNoL25vZGUuYzoxNzYwDQo+ICAgICAgICAgZGJ1cz08b3B0aW1pemVkIG91dD4pIGF0
IGVsbC9kYnVzLmM6MjE2DQo+ICAgICAgICAgdXNlcl9kYXRhPTB4NTU1NTU1NWE2ZTAwKSBhdCBl
bGwvZGJ1cy5jOjI3OQ0KPiAgICAgICAgIHVzZXJfZGF0YT0weDU1NTU1NTVhN2VmMCkgYXQgZWxs
L2lvLmM6MTI2DQo+ICAgICAgICAgYXQgZWxsL21haW4uYzo2NDINCj4gICAgICAgICBhdCBtZXNo
L21haW4uYzoyMDUNCj4gDQo+IFRoZSBmYXVsdCB3YXMgY2F1c2VkIGJ5IHRoZSBwcmVtYXR1cmUg
ZGVsZXRpb24gb2YgcHJlc2VydmVkIHN0YXRlLg0KPiANCj4gVGhpcyBtb3ZlcyBzZXR1cCBvZiBk
aXNjb25uZWN0IHdhdGNoIGZvciB0aGUgYXBwbGljYXRpb24gY2FsbGluZyB0aGUgSm9pbigpDQo+
IG1ldGhvZCBpbnRvIHRoZSBub2RlX2luaXRfY2IoKSwgYWZ0ZXIgYSB0ZW1wb3Jhcnkgbm9kZSBo
YXMgYmVlbg0KPiBzdWNjZXNzZnVsbHkgY3JlYXRlZC4NCj4gLS0tDQo+ICBtZXNoL21lc2guYyB8
IDcgKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21lc2guYyBiL21lc2gvbWVzaC5jDQo+IGlu
ZGV4IGI2NjBhN2VmMi4uOWIyYjIwNzNiIDEwMDY0NA0KPiAtLS0gYS9tZXNoL21lc2guYw0KPiAr
KysgYi9tZXNoL21lc2guYw0KPiBAQCAtMzc3LDYgKzM3NywxMSBAQCBzdGF0aWMgdm9pZCBub2Rl
X2luaXRfY2Ioc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgc3RydWN0IG1lc2hfYWdlbnQgKmFnZW50
KQ0KPiAgCWxfZGJ1c19zZW5kKGRidXNfZ2V0X2J1cygpLCByZXBseSk7DQo+ICAJam9pbl9wZW5k
aW5nLT5tc2cgPSBOVUxMOw0KPiAgDQo+ICsJLyogU2V0dXAgZGlzY29ubmVjdCB3YXRjaCAqLw0K
PiArCWpvaW5fcGVuZGluZy0+ZGlzY193YXRjaCA9IGxfZGJ1c19hZGRfZGlzY29ubmVjdF93YXRj
aChkYnVzX2dldF9idXMoKSwNCj4gKwkJCQkJCWpvaW5fcGVuZGluZy0+c2VuZGVyLA0KPiArCQkJ
CQkJcHJvdl9kaXNjX2NiLCBOVUxMLCBOVUxMKTsNCj4gKw0KPiAgCXJldHVybjsNCj4gIA0KPiAg
ZmFpbDoNCj4gQEAgLTQyMyw4ICs0MjgsNiBAQCBzdGF0aWMgc3RydWN0IGxfZGJ1c19tZXNzYWdl
ICpqb2luX25ldHdvcmtfY2FsbChzdHJ1Y3QgbF9kYnVzICpkYnVzLA0KPiAgCXNlbmRlciA9IGxf
ZGJ1c19tZXNzYWdlX2dldF9zZW5kZXIobXNnKTsNCj4gIA0KPiAgCWpvaW5fcGVuZGluZy0+c2Vu
ZGVyID0gbF9zdHJkdXAoc2VuZGVyKTsNCj4gLQlqb2luX3BlbmRpbmctPmRpc2Nfd2F0Y2ggPSBs
X2RidXNfYWRkX2Rpc2Nvbm5lY3Rfd2F0Y2goZGJ1cywgc2VuZGVyLA0KPiAtCQkJCQkJcHJvdl9k
aXNjX2NiLCBOVUxMLCBOVUxMKTsNCj4gIAlqb2luX3BlbmRpbmctPm1zZyA9IGxfZGJ1c19tZXNz
YWdlX3JlZihtc2cpOw0KPiAgCWpvaW5fcGVuZGluZy0+YXBwX3BhdGggPSBhcHBfcGF0aDsNCj4g
IA0K
