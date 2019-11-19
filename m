Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC903C432C3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 23:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674C02240C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 23:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="LBD7LMCw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbfKSXxg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:53:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:34501 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfKSXxg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 18:53:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 15:53:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,219,1571727600"; 
   d="scan'208";a="381184599"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2019 15:53:35 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 Nov 2019 15:53:35 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.59) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 19 Nov 2019 15:53:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFvkltsPj1LBWUEq0PHz5qwxy55gW1Pm3Bbxca5mJLXJrrC2DOBd1bZqjw1ql2kWADf1797mi+rsaJCsMBLFPAnAMy82w5dtFcf9DH18S4z22DMUfZVTyMOFuFG75WwAYsX512Vl6ew57ovcS1HcAMufo/WrvSetLlSezM5aUEnNPlVTDk2ktyvEUXAGTIMZFnRYL9K7taq+3VCIjXwiIFsCWYl8dVULYC7taj0d4BBEHgzisqx6wV3c8twOorV7fjBAZMnamStlxONIxLPj6AZi6vgrfxMca/HdNkFcKNtD0KyGr4DyoQYsFo4MyVBTyafUny4M7M6q6mjMGsmGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSFZ1TcKo4AthwULV1Hjx2XkowwhP4Mubvq9YAv/k3Q=;
 b=VfabIRmJ5XXwedxwUw3SO7t8jlofGfkOfh2oM2BEd4nbOadeNRX4Q+nSqgzInXHxeCjph5xcP9hS5h1HFZV40yKcuCo1hEfdnoyj3FiXJCjEbKB/Gw4J75ZHcXC6H8G7OW+oqtqKMZ7O7BKRVQ9VFjmmRnTmNKzbfAXPMSJdtORr3l3ka8GC7xxj5iBQ0VuOgSXZjYBL6ZnhNj451DUngbrkf1D8bHd1lyfFXfZfO5IUI7sEHXU4yDZFJFB7UvYrLo/B7KQc5T/miEBKSxxpbQu22aqaOP1uJvl5A0vNqD2eYLkfhKP43Z7w+TiuHKxCOq2QQv9IN7aKMfojRSzhdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bSFZ1TcKo4AthwULV1Hjx2XkowwhP4Mubvq9YAv/k3Q=;
 b=LBD7LMCwVhhAim0USNSOKYG5z3Yamn0yCHdMWyaUuNYT3lDMLSDbx/a/0UiLk9v74V4MSDhys9/ircNhRqSolClW4S4qVJP4nI+cwodmbvTAgCxknyQMucvQHfQwnJk25j/B64H2dqvgQmoMRroHfxFxDtpJ5XNooZwbXVtNvhg=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2151.namprd11.prod.outlook.com (10.172.79.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Tue, 19 Nov 2019 23:53:34 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 23:53:34 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "rafal.gajda@silvair.com" <rafal.gajda@silvair.com>
Subject: Re: [PATCH BlueZ] mesh: Fix crash after deleting all subscriptions
Thread-Topic: [PATCH BlueZ] mesh: Fix crash after deleting all subscriptions
Thread-Index: AQHVnf49+Hwv+TCcDESam207XpTBnaeTLRwA
Date:   Tue, 19 Nov 2019 23:53:34 +0000
Message-ID: <485ffd4405f3e6e81e7f00e9609a20f83d238942.camel@intel.com>
References: <20191118105118.28881-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20191118105118.28881-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 201a8731-9dd5-485d-9334-08d76d4bb02c
x-ms-traffictypediagnostic: CY4PR1101MB2151:
x-microsoft-antispam-prvs: <CY4PR1101MB21515D445FCD50B749F9D81EE14C0@CY4PR1101MB2151.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:121;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(366004)(39860400002)(136003)(189003)(199004)(14454004)(2616005)(256004)(4744005)(5660300002)(6436002)(229853002)(26005)(8676002)(11346002)(305945005)(36756003)(66476007)(2906002)(66556008)(64756008)(66446008)(6116002)(478600001)(3846002)(316002)(110136005)(99286004)(66946007)(86362001)(76116006)(91956017)(446003)(76176011)(7736002)(6486002)(25786009)(66066001)(6512007)(476003)(118296001)(486006)(186003)(8936002)(102836004)(81156014)(4001150100001)(6246003)(81166006)(2501003)(71200400001)(71190400001)(6506007)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2151;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PocnAi2s/aVrg2ESWdcvqGJBvWsbhD44x5IfmWq4wC/S8szmvijk0AbhX+ElZMZ60KkSwoUcoFhUv2egKOYUUzuxKiMj7VNRmNChKEM+QihVlgPjeHdZIAtqrLHD6Ng33JKsS38uAZHEKbPxndPatcXxkXwVSN0g6hT3+7zg0CCw5lBzR1bJ6lNZVBouKS5i5ZNMDg/N3ez70EJLsFPw3QMYRFn2JHDMdUU6XEYCmKvySoWgxpn4yVAZj67Gx95XN0jAL5I4QsgSTMkUT+J+oFjxkUgSC6hTc1QhpmN/Sw9qkZTBoRrumGcuxG+bFAIUfgQTqPyAom4xXsKvX1dusKkLKj68hrFFjaEcbpsrElPJXdkG9Ng9u0Vvlwq1+GRt654FdEeI17UduRyujSUbWSYQ4qzI27y140sYzhnP+zFnQxMTkgpdNHE98H4Op0s0
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4FA41A6BC2CFB4DAB9314903763B755@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 201a8731-9dd5-485d-9334-08d76d4bb02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 23:53:34.0361
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QnHKgoFYWIbjgLy849XjLIKqePuc2dF3ADESKdPxqhQIhm5h2sGPvJUC8CVJ2QF2SJ6matW6UBsHgbaK0AeADA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2151
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgdGhhbmtzDQoNCk9uIE1vbiwgMjAxOS0xMS0xOCBhdCAxMTo1MSArMDEwMCwgTWlj
aGHFgiBMb3dhcy1SemVjaG9uZWsgd3JvdGU6DQo+IEZyb206IFJhZmHFgiBHYWpkYSA8cmFmYWwu
Z2FqZGFAc2lsdmFpci5jb20+DQo+IA0KPiAtLS0NCj4gIG1lc2gvbW9kZWwuYyB8IDUgKystLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvbWVzaC9tb2RlbC5jIGIvbWVzaC9tb2RlbC5jDQo+IGluZGV4IGEwNmI2
ODRhNS4uNDBjNWU2YjE4IDEwMDY0NA0KPiAtLS0gYS9tZXNoL21vZGVsLmMNCj4gKysrIGIvbWVz
aC9tb2RlbC5jDQo+IEBAIC0xNDI2LDkgKzE0MjYsOCBAQCBpbnQgbWVzaF9tb2RlbF9zdWJfZGVs
X2FsbChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBhZGRyLCB1aW50MzJfdCBpZCkN
Cj4gIAlmb3IgKDsgZW50cnk7IGVudHJ5ID0gZW50cnktPm5leHQpDQo+ICAJCW1lc2hfbmV0X2Rz
dF91bnJlZyhuZXQsICh1aW50MTZfdCkgTF9QVFJfVE9fVUlOVChlbnRyeS0+ZGF0YSkpOw0KPiAg
DQo+IC0JbF9xdWV1ZV9kZXN0cm95KG1vZC0+c3VicywgTlVMTCk7DQo+IC0JbF9xdWV1ZV9kZXN0
cm95KG1vZC0+dmlydHVhbHMsIHVucmVmX3ZpcnQpOw0KPiAtCW1vZC0+dmlydHVhbHMgPSBsX3F1
ZXVlX25ldygpOw0KPiArCWxfcXVldWVfY2xlYXIobW9kLT5zdWJzLCBOVUxMKTsNCj4gKwlsX3F1
ZXVlX2NsZWFyKG1vZC0+dmlydHVhbHMsIHVucmVmX3ZpcnQpOw0KPiAgDQo+ICAJcmV0dXJuIE1F
U0hfU1RBVFVTX1NVQ0NFU1M7DQo+ICB9DQo=
