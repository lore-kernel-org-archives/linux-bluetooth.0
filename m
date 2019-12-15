Return-Path: <SRS0=+je2=2F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10162C43603
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Dec 2019 17:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4BD24679
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 Dec 2019 17:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Bi92mr4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfLOR7L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 15 Dec 2019 12:59:11 -0500
Received: from mga01.intel.com ([192.55.52.88]:32012 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbfLOR7K (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 15 Dec 2019 12:59:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Dec 2019 09:59:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,318,1571727600"; 
   d="scan'208";a="211855570"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga007.fm.intel.com with ESMTP; 15 Dec 2019 09:59:10 -0800
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Dec 2019 09:59:09 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX112.amr.corp.intel.com (10.22.240.13) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 15 Dec 2019 09:59:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 15 Dec 2019 09:59:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtqBWNU8zPrmK430e3GvGwVuKErPGsf7wkDfviKy/UU9L7yHFv0YLm8lv67Fbb0mkpqXO/pYo8i9X1b7cVs3jxS3TJQBMbVzM0HP190TZq/yeR1JnODFq4Kras4wGUU0jqRwsrH5xGfZ8jLyG8Ufm7S11x4INEzJYNKFVcR5zVqoJtg1YjFrg8c0pfI/5QnXhzebV3CJHOXyAExn3/nPOLqwYL6rowvT3ACYo/Rz/EoCUSjFsEqt5hy4fWpAofNZTuk+I3eHhhsuAwrtc0/2H/A+TeTHBAwKe9Jzfhs/VkzNpXOplkaeHiReKYoEsPaQQXhyCe51Nysp5virr2fodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlTukfOYvH4NmM6JIPq37HaNu479B3JtI2CXJtjFWMA=;
 b=nMo1qBFlRCyXMhuGDNi1YJH4v8bhwvOgtv/eE9NToystgSVATcnhSoQQJZrNMlbZNe4IDUE+6Qr/hnlvn4imjy3iqDAir3MxIKNgpOMfdyNBA2YQj2Um1+AJX+lP9ZzPllr9A+XWEfK0zJgc/GAroU2TD7AoZ68IdleHzaDhkgGjTw592U1rrCwQ4qtdH9FIY34yHyjKOo/Et8i6pJpfNmjWZOc0Q/1fLejIUAmHS7A1nhPQvPCl2nBHZ+hzLl3zhAZI8rbvzsL9M1/X1/MtjwVAjfWucgkJYIEwtB9aebXPyRyxMLBzJuRXSkWORyu5rBz8gnrusdVQlMNltN+Pqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlTukfOYvH4NmM6JIPq37HaNu479B3JtI2CXJtjFWMA=;
 b=Bi92mr4+CyFYz+kXGGw1yhZlucu6m9Rp83GXCxjI5GK7ilaSxDQZ7j0rA1JxVOOYUwv8h2Gu9tucn1+8mzeJdk9qlKbRckGY9CYcByXZRQcRD9T/1cjoc8YpJb6VWbUFJf7sPPGyPcxO0ypuLyGtT3rGNK0P+rlAdQ6qQadxuhY=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1702.namprd11.prod.outlook.com (10.173.16.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.19; Sun, 15 Dec 2019 17:59:07 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::a12f:7254:eec:b905%3]) with mapi id 15.20.2516.021; Sun, 15 Dec 2019
 17:59:07 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
Subject: Re: [PATCH BlueZ] mesh: Add more checks for element properties
Thread-Topic: [PATCH BlueZ] mesh: Add more checks for element properties
Thread-Index: AQHVsHrSv+6/l8/qIUaOFCJDEF7ns6e7gbiA
Date:   Sun, 15 Dec 2019 17:59:06 +0000
Message-ID: <20e70c9600dc11c2bfd34034f4e22fdaf100335e.camel@intel.com>
References: <20191211232847.31501-1-inga.stotland@intel.com>
In-Reply-To: <20191211232847.31501-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9674ff0d-24bb-4bd4-b09a-08d781887afa
x-ms-traffictypediagnostic: CY4PR11MB1702:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB1702C98610E0B74688FBCBAFE1560@CY4PR11MB1702.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02524402D6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(396003)(376002)(346002)(199004)(189003)(76116006)(66946007)(110136005)(316002)(2906002)(36756003)(71200400001)(66556008)(66476007)(64756008)(66446008)(6486002)(5660300002)(8676002)(4326008)(91956017)(478600001)(6506007)(86362001)(186003)(81156014)(81166006)(4001150100001)(8936002)(26005)(2616005)(6636002)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1702;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ufRTJsgm3RGs0TSt3KtQlDYR/A2oqIQtAgcLFKGCQw6QmM9ryw4Kd5iMFIeYTlxVzta2Vh4FiIOaZbsIKjy0zyytt107TvNBeWooGfpQMRkADpE6IjbYYotj70CSF98OuoHtqkcXSG+e0CrZL6x1TFNLCbsR5f4zhOvoOiyOOOP1+43uqr3f1VU1XcKjXKBm0+Sk1FSZTZJQFI2MbwCMwopRmcd2O5neqBJM069+baiBFl0AP66TovZ0TdQAq2S2NYYLvWZsNhrD00fl29K94jdWttxeLtHZJdNQhdRnvrXdP92eVW6ixpMZXBuxsp33sBb1Q8As/BGrWz3W+4kXv5mU43gb+uKwfdLItZSNemF/w/aYGs+NGP/cW21La+DlRSiMMyU+2iaGVzwtcTZfEft3qnG2iuTNHiSvpMJKSAKEPo3hP5Ry7fuVO9uIE+hS
Content-Type: text/plain; charset="utf-8"
Content-ID: <E409C0EFDFF4DE45B354E56D393E6125@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9674ff0d-24bb-4bd4-b09a-08d781887afa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2019 17:59:06.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HXTPVuEWfhdY/6U3B6UZCiipTfVII2V5DJWHq2IzFdrAJThLXyaqSZNEH3wMaEQ5gQV3yaWNZ0PLCmyaBShZ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1702
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBXZWQsIDIwMTktMTItMTEgYXQgMTU6MjggLTA4MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgYWRkcyBjb25zaXN0ZW5jeSBjaGVja3MgZm9yIG1hbmRhdG9yeSBw
cm9wZXJ0aWVzIG9uDQo+IG9yZy5ibHVlei5tZXNoLkVsZW1lbnQxIGludGVyZmFjZToNCj4gICAg
IC0gZGlzYWxsb3cgZHVwbGljYXRlIG1vZGVscyBvbiB0aGUgc2FtZSBlbGVtZW50DQo+ICAgICAt
IGRpc2FsbG93IGVsZW1lbnRzIHdpdGggZHVwbGljYXRlIGluZGljZXMNCj4gICAgIC0gZGlzYWxs
b3cgY29uZmlndXJhdGlvbiBzZXJ2ZXIgbW9kZWwgb24gYW55IGVsZW1lbnQgYnV0IHByaW1hcnkN
Cj4gLS0tDQo+ICBtZXNoL25vZGUuYyB8IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25z
KCspLCAyMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL25vZGUuYyBiL21l
c2gvbm9kZS5jDQo+IGluZGV4IGY4YWNjNzhjMy4uMWYzMjhiZDIxIDEwMDY0NA0KPiAtLS0gYS9t
ZXNoL25vZGUuYw0KPiArKysgYi9tZXNoL25vZGUuYw0KPiBAQCAtMTA4MSw3ICsxMDgxLDcgQEAg
c3RhdGljIHZvaWQgYXBwX2Rpc2NfY2Ioc3RydWN0IGxfZGJ1cyAqYnVzLCB2b2lkICp1c2VyX2Rh
dGEpDQo+ICAJZnJlZV9ub2RlX2RidXNfcmVzb3VyY2VzKG5vZGUpOw0KPiAgfQ0KPiAgDQo+IC1z
dGF0aWMgdm9pZCBnZXRfc2lnX21vZGVsc19mcm9tX3Byb3BlcnRpZXMoc3RydWN0IG5vZGVfZWxl
bWVudCAqZWxlLA0KPiArc3RhdGljIGJvb2wgZ2V0X3NpZ19tb2RlbHNfZnJvbV9wcm9wZXJ0aWVz
KHN0cnVjdCBub2RlX2VsZW1lbnQgKmVsZSwNCj4gIAkJCQkJc3RydWN0IGxfZGJ1c19tZXNzYWdl
X2l0ZXIgKnByb3BlcnR5KQ0KPiAgew0KPiAgCXN0cnVjdCBsX2RidXNfbWVzc2FnZV9pdGVyIGlk
czsNCj4gQEAgLTEwOTEsMjQgKzEwOTEsMzEgQEAgc3RhdGljIHZvaWQgZ2V0X3NpZ19tb2RlbHNf
ZnJvbV9wcm9wZXJ0aWVzKHN0cnVjdCBub2RlX2VsZW1lbnQgKmVsZSwNCj4gIAkJZWxlLT5tb2Rl
bHMgPSBsX3F1ZXVlX25ldygpOw0KPiAgDQo+ICAJaWYgKCFsX2RidXNfbWVzc2FnZV9pdGVyX2dl
dF92YXJpYW50KHByb3BlcnR5LCAiYXEiLCAmaWRzKSkNCj4gLQkJcmV0dXJuOw0KPiArCQlyZXR1
cm4gZmFsc2U7DQo+ICANCj4gIAkvKiBCbHVldG9vdGggU0lHIGRlZmluZWQgbW9kZWxzICovDQo+
ICAJd2hpbGUgKGxfZGJ1c19tZXNzYWdlX2l0ZXJfbmV4dF9lbnRyeSgmaWRzLCAmbW9kX2lkKSkg
ew0KPiAgCQlzdHJ1Y3QgbWVzaF9tb2RlbCAqbW9kOw0KPiAgCQl1aW50MzJfdCBpZCA9IG1vZF9p
ZCB8IFZFTkRPUl9JRF9NQVNLOw0KPiAgDQo+ICsJCS8qIEFsbG93IENvbmZpZyBTZXJ2ZXIgTW9k
ZWwgb25seSBvbiB0aGUgcHJpbWFyeSBlbGVtZW50ICovDQo+ICsJCWlmIChlbGUtPmlkeCAhPSBQ
UklNQVJZX0VMRV9JRFggJiYgaWQgPT0gQ09ORklHX1NSVl9NT0RFTCkNCj4gKwkJCXJldHVybiBm
YWxzZTsNCj4gKw0KPiArCQkvKiBEaXNhbGxvdyBkdXBsaWNhdGVzICovDQo+ICAJCWlmIChsX3F1
ZXVlX2ZpbmQoZWxlLT5tb2RlbHMsIG1hdGNoX21vZGVsX2lkLA0KPiAgCQkJCQkJTF9VSU5UX1RP
X1BUUihpZCkpKQ0KPiAtCQkJY29udGludWU7DQo+ICsJCQlyZXR1cm4gZmFsc2U7DQo+ICANCj4g
IAkJbW9kID0gbWVzaF9tb2RlbF9uZXcoZWxlLT5pZHgsIGlkKTsNCj4gIA0KPiAgCQlsX3F1ZXVl
X2luc2VydChlbGUtPm1vZGVscywgbW9kLCBjb21wYXJlX21vZGVsX2lkLCBOVUxMKTsNCj4gIAl9
DQo+ICsNCj4gKwlyZXR1cm4gdHJ1ZTsNCj4gIH0NCj4gIA0KPiAtc3RhdGljIHZvaWQgZ2V0X3Zl
bmRvcl9tb2RlbHNfZnJvbV9wcm9wZXJ0aWVzKHN0cnVjdCBub2RlX2VsZW1lbnQgKmVsZSwNCj4g
K3N0YXRpYyBib29sIGdldF92ZW5kb3JfbW9kZWxzX2Zyb21fcHJvcGVydGllcyhzdHJ1Y3Qgbm9k
ZV9lbGVtZW50ICplbGUsDQo+ICAJCQkJCXN0cnVjdCBsX2RidXNfbWVzc2FnZV9pdGVyICpwcm9w
ZXJ0eSkNCj4gIHsNCj4gIAlzdHJ1Y3QgbF9kYnVzX21lc3NhZ2VfaXRlciBpZHM7DQo+IEBAIC0x
MTE4LDIxICsxMTI1LDI0IEBAIHN0YXRpYyB2b2lkIGdldF92ZW5kb3JfbW9kZWxzX2Zyb21fcHJv
cGVydGllcyhzdHJ1Y3Qgbm9kZV9lbGVtZW50ICplbGUsDQo+ICAJCWVsZS0+bW9kZWxzID0gbF9x
dWV1ZV9uZXcoKTsNCj4gIA0KPiAgCWlmICghbF9kYnVzX21lc3NhZ2VfaXRlcl9nZXRfdmFyaWFu
dChwcm9wZXJ0eSwgImEocXEpIiwgJmlkcykpDQo+IC0JCXJldHVybjsNCj4gKwkJcmV0dXJuIGZh
bHNlOw0KPiAgDQo+ICAJLyogVmVuZG9yIGRlZmluZWQgbW9kZWxzICovDQo+ICAJd2hpbGUgKGxf
ZGJ1c19tZXNzYWdlX2l0ZXJfbmV4dF9lbnRyeSgmaWRzLCAmdmVuZG9yX2lkLCAmbW9kX2lkKSkg
ew0KPiAgCQlzdHJ1Y3QgbWVzaF9tb2RlbCAqbW9kOw0KPiAgCQl1aW50MzJfdCBpZCA9IG1vZF9p
ZCB8ICh2ZW5kb3JfaWQgPDwgMTYpOw0KPiAgDQo+ICsJCS8qIERpc2FsbG93IGR1cGxpY2F0ZXMg
Ki8NCj4gIAkJaWYgKGxfcXVldWVfZmluZChlbGUtPm1vZGVscywgbWF0Y2hfbW9kZWxfaWQsDQo+
ICAJCQkJCQkJTF9VSU5UX1RPX1BUUihpZCkpKQ0KPiAtCQkJY29udGludWU7DQo+ICsJCQlyZXR1
cm4gZmFsc2U7DQo+ICANCj4gIAkJbW9kID0gbWVzaF9tb2RlbF9uZXcoZWxlLT5pZHgsIGlkKTsN
Cj4gIA0KPiAgCQlsX3F1ZXVlX2luc2VydChlbGUtPm1vZGVscywgbW9kLCBjb21wYXJlX21vZGVs
X2lkLCBOVUxMKTsNCj4gIAl9DQo+ICsNCj4gKwlyZXR1cm4gdHJ1ZTsNCj4gIH0NCj4gIA0KPiAg
c3RhdGljIGJvb2wgZ2V0X2VsZW1lbnRfcHJvcGVydGllcyhzdHJ1Y3QgbWVzaF9ub2RlICpub2Rl
LCBjb25zdCBjaGFyICpwYXRoLA0KPiBAQCAtMTE1MCwzNCArMTE2MCwzNiBAQCBzdGF0aWMgYm9v
bCBnZXRfZWxlbWVudF9wcm9wZXJ0aWVzKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIGNvbnN0IGNo
YXIgKnBhdGgsDQo+ICAJZWxlLT5sb2NhdGlvbiA9IERFRkFVTFRfTE9DQVRJT047DQo+ICANCj4g
IAl3aGlsZSAobF9kYnVzX21lc3NhZ2VfaXRlcl9uZXh0X2VudHJ5KHByb3BlcnRpZXMsICZrZXks
ICZ2YXIpKSB7DQo+IC0JCWlmICghaWR4ICYmICFzdHJjbXAoa2V5LCAiSW5kZXgiKSkgew0KPiAt
CQkJaWYgKCFsX2RidXNfbWVzc2FnZV9pdGVyX2dldF92YXJpYW50KCZ2YXIsICJ5IiwNCj4gKwkJ
aWYgKCFzdHJjbXAoa2V5LCAiSW5kZXgiKSkgew0KPiArDQo+ICsJCQlpZiAoaWR4IHx8ICFsX2Ri
dXNfbWVzc2FnZV9pdGVyX2dldF92YXJpYW50KCZ2YXIsICJ5IiwNCj4gIAkJCQkJCQkJJmVsZS0+
aWR4KSkNCj4gIAkJCQlnb3RvIGZhaWw7DQo+ICsNCj4gIAkJCWlkeCA9IHRydWU7DQo+IC0JCQlj
b250aW51ZTsNCj4gLQkJfQ0KPiAgDQo+IC0JCWlmICghbW9kcyAmJiAhc3RyY21wKGtleSwgIk1v
ZGVscyIpKSB7DQo+IC0JCQlnZXRfc2lnX21vZGVsc19mcm9tX3Byb3BlcnRpZXMoZWxlLCAmdmFy
KTsNCj4gKwkJfSBlbHNlIGlmICghc3RyY21wKGtleSwgIk1vZGVscyIpKSB7DQo+ICsNCj4gKwkJ
CWlmIChtb2RzIHx8ICFnZXRfc2lnX21vZGVsc19mcm9tX3Byb3BlcnRpZXMoZWxlLCAmdmFyKSkN
Cj4gKwkJCQlnb3RvIGZhaWw7DQo+ICsNCj4gIAkJCW1vZHMgPSB0cnVlOw0KPiAtCQkJY29udGlu
dWU7DQo+IC0JCX0NCj4gKwkJfSBlbHNlIGlmICghc3RyY21wKGtleSwgIlZlbmRvck1vZGVscyIp
KSB7DQo+ICsNCj4gKwkJCWlmICh2ZW5kb3JfbW9kcyB8fA0KPiArCQkJCSFnZXRfdmVuZG9yX21v
ZGVsc19mcm9tX3Byb3BlcnRpZXMoZWxlLCAmdmFyKSkNCj4gKwkJCQlnb3RvIGZhaWw7DQo+ICAN
Cj4gLQkJaWYgKCF2ZW5kb3JfbW9kcyAmJiAhc3RyY21wKGtleSwgIlZlbmRvck1vZGVscyIpKSB7
DQo+IC0JCQlnZXRfdmVuZG9yX21vZGVsc19mcm9tX3Byb3BlcnRpZXMoZWxlLCAmdmFyKTsNCj4g
IAkJCXZlbmRvcl9tb2RzID0gdHJ1ZTsNCj4gLQkJCWNvbnRpbnVlOw0KPiAtCQl9DQo+ICANCj4g
LQkJaWYgKCFzdHJjbXAoa2V5LCAiTG9jYXRpb24iKSkgew0KPiArCQl9IGVsc2UgaWYgKCFzdHJj
bXAoa2V5LCAiTG9jYXRpb24iKSkgew0KPiAgCQkJaWYgKCFsX2RidXNfbWVzc2FnZV9pdGVyX2dl
dF92YXJpYW50KCZ2YXIsICJxIiwNCj4gIAkJCQkJCQkmZWxlLT5sb2NhdGlvbikpDQo+ICAJCQkJ
Z290byBmYWlsOw0KPiAtCQkJY29udGludWU7DQo+ICAJCX0NCj4gIAl9DQo+ICANCj4gKwkvKiBD
aGVjayBmb3IgdGhlIHByZXNlbmNlIG9mIHRoZSByZXF1aXJlZCBwcm9wZXJ0aWVzICovDQo+ICAJ
aWYgKCFpZHggfHwgIW1vZHMgfHwgIXZlbmRvcl9tb2RzKQ0KPiAgCQlnb3RvIGZhaWw7DQo+ICAN
Cg==
