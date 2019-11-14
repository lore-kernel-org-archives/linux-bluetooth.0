Return-Path: <SRS0=JgXz=ZG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B479C432C3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Nov 2019 22:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD33206E6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Nov 2019 22:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="xOar/Jok"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfKNWN7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Nov 2019 17:13:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:29387 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfKNWN6 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Nov 2019 17:13:58 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Nov 2019 14:13:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,306,1569308400"; 
   d="scan'208";a="379728014"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga005.jf.intel.com with ESMTP; 14 Nov 2019 14:13:57 -0800
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 14 Nov 2019 14:13:57 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 14 Nov 2019 14:13:56 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 14 Nov 2019 14:13:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikAZQIyFsZdcpJEOFDh0DHk+Mx8WPQtDkAWgRtItXNrOsKNlDtva+oQkAv9YWzBQg2ZhlJlO5kYoAFp+6GDUmcHdqVjxzY0QJmt72uokNNRxQ27Hwil1PJyw6LVNcURJTqBYt2O8mvkQdwr0BWmw4LXtWFdEXV6W8ZM3NNWdHvxbwKr/O1JZSfNWU12RuYccSumtF6CNrQteV1EHfpXyOKFf7I9SlkHWo4HUG3g5pX1mX8IiivaHj61Xqgdb0ZzToF9q+0DFJTujjeo60ffBWFDEgoUVXHjVqM1CYwOi4L5eVn+9Ye9/9BL+1PnZ/upkzwWL7kVX6CtgSQauePbccA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qF/z/KyeQApQQfqG+xsX28fzQSDH8kJ8tMqCGNFJvMM=;
 b=WPxj/SxfiUSqaaMX15dfS4ffj6RG8bTNxH69qOZL5xe2n/pab1Kcbrvr+GHFqm34rJULEl0Oy7PLS5PEHAyfCckCA4w0g9dp/5tw6AFbuVZUz6caAHrpGJ7xXzmTwUnTEOn+z6edzk0k1fYA9wWBaHmAbHOfP9TtwYG5DnNe4xd8a+HGCGPya0+udlySAAFmcGSdai4AuHYz1qoWbmE7ciws5Zp2cQ49tpMRsL8hm5XuCbILnJubE26Z6gFnOosK0MawWWWJrIRZOTIZBYDsKm3ua/CUO/UZLx+HsT3jy9861K377Z2tV+47oiXGL4d/tEJQl13LtiimBMxCuW9wPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qF/z/KyeQApQQfqG+xsX28fzQSDH8kJ8tMqCGNFJvMM=;
 b=xOar/JokS9ogqBAAHLudn+DavBRi9fGDtaqIPw/9ap88GNIICPCqZA1RkOBzleURNwoJxkP0cshxrITqFMuMLGEgMqLd4BEorLBYaGVt7jTxXD9Qf+Yy7jqLGdH5PnXlLcx6g7cIUGMsRTA/O0DkWa9adZ64zSZscwVgD+G1Cek=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Thu, 14 Nov 2019 22:13:55 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2451.027; Thu, 14 Nov 2019
 22:13:55 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Cancel unprovisioned scan on exit or app
 disconnect
Thread-Topic: [PATCH BlueZ] mesh: Cancel unprovisioned scan on exit or app
 disconnect
Thread-Index: AQHVmSGY+jNdS/q5uEqDC3/8mhxme6eLP1cA
Date:   Thu, 14 Nov 2019 22:13:55 +0000
Message-ID: <acb4b5e259c03092ce33c33cd6e2de6abe3598eb.camel@intel.com>
References: <20191112062205.27876-1-inga.stotland@intel.com>
In-Reply-To: <20191112062205.27876-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6bea7b1-76d5-4ff4-ae00-08d7694ff083
x-ms-traffictypediagnostic: CY4PR1101MB2262:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB2262F21F33DDDB2AECB7830DE1710@CY4PR1101MB2262.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1850;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(136003)(39860400002)(396003)(199004)(189003)(2616005)(81156014)(81166006)(446003)(118296001)(476003)(229853002)(36756003)(11346002)(110136005)(486006)(66476007)(66556008)(64756008)(66446008)(66946007)(305945005)(25786009)(256004)(4001150100001)(2906002)(14454004)(478600001)(3846002)(6116002)(71200400001)(71190400001)(7736002)(2501003)(102836004)(76176011)(186003)(5660300002)(6636002)(91956017)(66066001)(6486002)(6436002)(8936002)(99286004)(86362001)(316002)(6512007)(76116006)(8676002)(6506007)(26005)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2262;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e/L01MfeglFBm673KkF3PzC+vb3pOGZCAlr6eWQAg47SDPqDnKqUEqz1U8jYQC1+YrEHYq5YDdBhe7TsB9SCQzAMSH7kOtsVF5otH8tzgB3SXB9gR7LXE0PY4ZIHXysB/Uwca9zHDa93pt95oa/EMZsJxlQBu1JI2Ng7nMJioA03JtANaWMpjHZAp3cEFQ77cy4BY3TnPheVXHPk4k/OJKEG2D4tcryTdPFMXYk+gzfKL4syEZS/rd9mndaziFBypl5wdYInaFF11/jqrbZa/li+b6Z4t0VarYN5IatzzCIFBNeMOt+F6iBDov8tmvZDwj99AXvz7Z9CnWFTVJWCBm8oKwSotOwhhSJPcMUmFD23uABIyY6e7n4eaBKlceGBreBDlziC1hfWoltI76JcaamONVuPIZP66X3ZrE9xThXWa1OC/pYanGo599YcAHqU
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B9C27408579C847AC90CEB3D9E1E15F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bea7b1-76d5-4ff4-ae00-08d7694ff083
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 22:13:55.3299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h5waMNZo0/db/9fAUMVsocay54xkFOEwV2epHclD/4QCpcIhhdWXGlt2nNEVm7iFxz8H5o0shmwn/mmGkLgDjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2262
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBNb24sIDIwMTktMTEtMTEgYXQgMjI6MjIgLTA4MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IElmIGEgcHJvdmlzaW9uZXIgYXBwIHF1aXRzIG9yIHRoZSBkYWVtb24gaXMg
c3RvcHBlZCB3aGlsZSB0aGVyZSdzDQo+IGFuIGFjdGl2ZSBzY2FuIGZvciB1bnByb3Zpc2lvbmVk
IGRldmljZXMgaW4gcHJvZ3Jlc3MsIHRoZSBzY2FuIG5lZWRzDQo+IHRvIGJlIGV4cGxpY2l0bHkg
Y2FuY2VsZWQuDQo+IC0tLQ0KPiAgbWVzaC9tYW5hZ2VyLmMgfCAgOCArKysrKysrKw0KPiAgbWVz
aC9tYW5hZ2VyLmggfCAgMSArDQo+ICBtZXNoL25vZGUuYyAgICB8IDEwICsrKysrKysrKysNCj4g
IDMgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21l
c2gvbWFuYWdlci5jIGIvbWVzaC9tYW5hZ2VyLmMNCj4gaW5kZXggMGIxMWI0NTQxLi5hZGJiMDEy
ODAgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbWFuYWdlci5jDQo+ICsrKyBiL21lc2gvbWFuYWdlci5j
DQo+IEBAIC03OTQsMyArNzk0LDExIEBAIGJvb2wgbWFuYWdlcl9kYnVzX2luaXQoc3RydWN0IGxf
ZGJ1cyAqYnVzKQ0KPiAgDQo+ICAJcmV0dXJuIHRydWU7DQo+ICB9DQo+ICsNCj4gK3ZvaWQgbWFu
YWdlcl9zY2FuX2NhbmNlbChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlKQ0KPiArew0KPiArCWlmIChz
Y2FuX25vZGUgIT0gbm9kZSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+ICsJc2Nhbl9jYW5jZWwoTlVM
TCwgbm9kZSk7DQo+ICt9DQo+IGRpZmYgLS1naXQgYS9tZXNoL21hbmFnZXIuaCBiL21lc2gvbWFu
YWdlci5oDQo+IGluZGV4IGYyN2NhNDE4MS4uNWE0YzdkOTRhIDEwMDY0NA0KPiAtLS0gYS9tZXNo
L21hbmFnZXIuaA0KPiArKysgYi9tZXNoL21hbmFnZXIuaA0KPiBAQCAtMTgsMyArMTgsNCBAQA0K
PiAgICovDQo+ICANCj4gIGJvb2wgbWFuYWdlcl9kYnVzX2luaXQoc3RydWN0IGxfZGJ1cyAqZGJ1
cyk7DQo+ICt2b2lkIG1hbmFnZXJfc2Nhbl9jYW5jZWwoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSk7
DQo+IGRpZmYgLS1naXQgYS9tZXNoL25vZGUuYyBiL21lc2gvbm9kZS5jDQo+IGluZGV4IGUyM2Yz
MmRkMS4uZDZkZDgxOWViIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25vZGUuYw0KPiArKysgYi9tZXNo
L25vZGUuYw0KPiBAQCAtNDIsNiArNDIsNyBAQA0KPiAgI2luY2x1ZGUgIm1lc2gvZXJyb3IuaCIN
Cj4gICNpbmNsdWRlICJtZXNoL2RidXMuaCINCj4gICNpbmNsdWRlICJtZXNoL2FnZW50LmgiDQo+
ICsjaW5jbHVkZSAibWVzaC9tYW5hZ2VyLmgiDQo+ICAjaW5jbHVkZSAibWVzaC9ub2RlLmgiDQo+
ICANCj4gICNkZWZpbmUgTUlOX0NPTVBfU0laRSAxNA0KPiBAQCAtMzEwLDYgKzMxMSwxMCBAQCBz
dGF0aWMgdm9pZCBmcmVlX25vZGVfcmVzb3VyY2VzKHZvaWQgKmRhdGEpDQo+ICAJbF9xdWV1ZV9k
ZXN0cm95KG5vZGUtPmVsZW1lbnRzLCBlbGVtZW50X2ZyZWUpOw0KPiAgCW5vZGUtPmVsZW1lbnRz
ID0gTlVMTDsNCj4gIA0KPiArCS8qIEluIGNhc2Ugb2YgYSBwcm92aXNpb25lciwgc3RvcCBhY3Rp
dmUgc2Nhbm5pbmcgKi8NCj4gKwlpZiAobm9kZS0+cHJvdmlzaW9uZXIpDQo+ICsJCW1hbmFnZXJf
c2Nhbl9jYW5jZWwobm9kZSk7DQo+ICsNCj4gIAlmcmVlX25vZGVfZGJ1c19yZXNvdXJjZXMobm9k
ZSk7DQo+ICANCj4gIAltZXNoX25ldF9mcmVlKG5vZGUtPm5ldCk7DQo+IEBAIC0xMTY2LDYgKzEx
NzEsMTEgQEAgc3RhdGljIHZvaWQgYXBwX2Rpc2NfY2Ioc3RydWN0IGxfZGJ1cyAqYnVzLCB2b2lk
ICp1c2VyX2RhdGEpDQo+ICAJbF9pbmZvKCJBcHAgJXMgZGlzY29ubmVjdGVkICgldSkiLCBub2Rl
LT5vd25lciwgbm9kZS0+ZGlzY193YXRjaCk7DQo+ICANCj4gIAlub2RlLT5kaXNjX3dhdGNoID0g
MDsNCj4gKw0KPiArCS8qIEluIGNhc2Ugb2YgYSBwcm92aXNpb25lciwgc3RvcCBhY3RpdmUgc2Nh
bm5pbmcgKi8NCj4gKwlpZiAobm9kZS0+cHJvdmlzaW9uZXIpDQo+ICsJCW1hbmFnZXJfc2Nhbl9j
YW5jZWwobm9kZSk7DQo+ICsNCj4gIAlmcmVlX25vZGVfZGJ1c19yZXNvdXJjZXMobm9kZSk7DQo+
ICB9DQo+ICANCg==
