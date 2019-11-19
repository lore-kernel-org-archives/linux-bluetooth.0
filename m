Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E0EAC432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 23:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AC692240C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 23:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="zhvptK9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbfKSXyw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Nov 2019 18:54:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:51864 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfKSXyv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Nov 2019 18:54:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2019 15:54:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,219,1571727600"; 
   d="scan'208";a="218424365"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga002.jf.intel.com with ESMTP; 19 Nov 2019 15:54:50 -0800
Received: from fmsmsx123.amr.corp.intel.com (10.18.125.38) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 Nov 2019 15:54:50 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx123.amr.corp.intel.com (10.18.125.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 19 Nov 2019 15:54:50 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.54) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 19 Nov 2019 15:54:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFbdym4KNSx9aqHwcpaSN0tIm6JxGFJ4lrfKVZ3AJt8cZpEQk+0DPpKx0SEB4yJDvO/VJrRHPBsLxkJ2AlNf2MXjvp3hqx2B72q4YilQ+W9OQpTMlIKHPGc/pqvr8i7a7wbQnfoRNksGYb3VJgDmg5rrbn4SoeQeDRQs5a28t1QlY6vpnQv4h20rOqNYKMgWevlNq934dcVVOAX+FGkRJg4y5KrE4d/CMRkmZGAbj/GDejqIKqFZSLam+1vR3rsgii6Gkkd0AQtRf0zxj+dez/0qDcWhd1Cz4jZ3C9nRtlx37dAooAAf3DTr7K9sLs1A+LlOl/WSkM6L87uBh/7HKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+rhQyFnQ83fCQ4muf+yGe8P4slrqwCTtQVDZmCaMio=;
 b=Ox0RbboWogEuB1p75aQmn8uK/nZmj/mmqauHwUwZCbyYtuS2KcFBNgLan38bstC5HV2vMUDZUuH1Zk4ErzA1tqV8LlDIMBiaWpKvtEx7LOS9QnmsRk/rnalhCoKtuO3BcmwYbj40FilZlNtF4I/rynL3V+yjLbBTH/rHErGIG+P8Uxtz4uO+j/T7mIsILBI74kY8m/+buE50OrrwpxQ30vqBXzTGD7LoMlZ4ttA7ZeCt81+j0xD9HWA1Okz84nWL/HG4qU2GRgOj5uQfAurcSyOuWp2cEtspLa5xkaGvhxf6HXvuaSMC4R+YLH3pa+2X8wUhdndhcg23P3N4UWWImQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+rhQyFnQ83fCQ4muf+yGe8P4slrqwCTtQVDZmCaMio=;
 b=zhvptK9rJ6E/73Q9ZwlKAggz1lmNKeYpf4DVXd9bI8hVko8Vz57CbFFBzuDXpWwqL4FipQmSY4fO3VUnasch5UijQQZHexlRPiMGnHDq0bwlx8GjHzMBsFZwFby5wvquzBHajwHEO+kSnKUbRm5d4aOdMpfsWeGMOSE2cUD/P+w=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2342.namprd11.prod.outlook.com (10.173.191.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Tue, 19 Nov 2019 23:54:48 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2451.031; Tue, 19 Nov 2019
 23:54:48 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "sbrown@ewol.com" <sbrown@ewol.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Correct typo in cfg_cmd table
Thread-Topic: [PATCH BlueZ] mesh: Correct typo in cfg_cmd table
Thread-Index: AQHVnaj54cMAeMl6pUaTa8rApdwyHqeTLiCA
Date:   Tue, 19 Nov 2019 23:54:48 +0000
Message-ID: <6ad63f6c2622361f538a3dccaf790183b6ad099e.camel@intel.com>
References: <20191118000951.5982-1-sbrown@ewol.com>
In-Reply-To: <20191118000951.5982-1-sbrown@ewol.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c5dd433-4ea6-4438-2fe6-08d76d4bdc99
x-ms-traffictypediagnostic: CY4PR1101MB2342:
x-microsoft-antispam-prvs: <CY4PR1101MB2342BE082BB21B988E7B19BAE14C0@CY4PR1101MB2342.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 022649CC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(346002)(396003)(39860400002)(376002)(199004)(189003)(486006)(7736002)(6116002)(2906002)(6506007)(86362001)(256004)(71200400001)(71190400001)(3846002)(66446008)(66946007)(66476007)(4744005)(5660300002)(305945005)(76116006)(91956017)(14454004)(478600001)(118296001)(25786009)(36756003)(229853002)(66066001)(316002)(6246003)(102836004)(64756008)(66556008)(6436002)(6486002)(110136005)(2616005)(2501003)(99286004)(446003)(186003)(6512007)(81166006)(81156014)(8676002)(26005)(4001150100001)(76176011)(476003)(11346002)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2342;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y9aqppL4MTR84LLfqJAI+ojfzPd0W4ZOi/Wpc07RQ7TkRykWzG7SSgPoEp+qVO/fH0GrMXm/xdDL6pi39yn5/3PcDu6egfTbhBYsdIVVT+bfV9eqb8fg3RD30LWzsbUK04UeqY7q+tVGqoFaN9ed50AxoI0bdIUvzsdHcw3eVDHDfCk/6u+3ijJ8qX3+TgmSDYtpsLfOOd1xg16PX8pL1flkYDYD/zX59DY3oPKEi1JA/f3VBtt3LM4TAWB3BwqWWxp1BjAt6B5Bo9ZE9T42BpMkEvvC/WCWQb/ACjavN9PoX5uSKp2ZHo7KkGqanmvHtNBJt95Wqt+V788x1jMt6rbSbQ1UMs9TOPdjzuWO+EP9mgdjlLw5q3cTDce2acKsM/JhK/vNLi+98E2EpJQNQbOGF3TYuv9QWkUANeycgc65/TukpCjKzKXp4qbME1hK
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4D572768FDA95489A280DF92D716250@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5dd433-4ea6-4438-2fe6-08d76d4bdc99
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2019 23:54:48.6026
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YH/YDIHZqaDhpdNJBo8j0/mAmSrHswkkBVbXqRJ5JBgDM7K9B3WPaAwSQPnan6YpMV3q80LyifItYVqPM0SIdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2342
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgdGhhbmtzDQoNCk9uIFN1biwgMjAxOS0xMS0xNyBhdCAxOTowOSAtMDUwMCwgc2Jy
b3duQGV3b2wuY29tIHdyb3RlOg0KPiBGcm9tOiBTdGV2ZSBCcm93biA8c2Jyb3duQGV3b2wuY29t
Pg0KPiANCj4gLS0tDQo+ICB0b29scy9tZXNoL2NmZ2NsaS5jIHwgNCArKy0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL3Rvb2xzL21lc2gvY2ZnY2xpLmMgYi90b29scy9tZXNoL2NmZ2NsaS5jDQo+IGluZGV4IDQ0
ZjdkYWMxZS4uZGM3YjI2NmY4IDEwMDY0NA0KPiAtLS0gYS90b29scy9tZXNoL2NmZ2NsaS5jDQo+
ICsrKyBiL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gQEAgLTE0MCw5ICsxNDAsOSBAQCBzdGF0aWMg
c3RydWN0IGNmZ19jbWQgY21kc1tdID0gew0KPiAgCXsgT1BfQ09ORklHX0hFQVJUQkVBVF9QVUJf
U0VULCBPUF9DT05GSUdfSEVBUlRCRUFUX1BVQl9TVEFUVVMsDQo+ICAJCQkJCQkJIkhlYXJ0YmVh
dFB1YlNldCIgfSwNCj4gIAl7IE9QX0NPTkZJR19IRUFSVEJFQVRfUFVCX1NUQVRVUywgTk9fUkVT
UE9OU0UsICJIZWFydGJlYXRQdWJTdGF0dXMiIH0sDQo+IC0JeyBPUF9DT05GSUdfSEVBUlRCRUFU
X1NVQl9HRVQsIE9QX0NPTkZJR19IRUFSVEJFQVRfU1VCX0dFVCwNCj4gKwl7IE9QX0NPTkZJR19I
RUFSVEJFQVRfU1VCX0dFVCwgT1BfQ09ORklHX0hFQVJUQkVBVF9TVUJfU1RBVFVTLA0KPiAgCQkJ
CQkJCSJIZWFydGJlYXRTdWJHZXQiIH0sDQo+IC0JeyBPUF9DT05GSUdfSEVBUlRCRUFUX1NVQl9T
RVQsIE9QX0NPTkZJR19IRUFSVEJFQVRfU1VCX0dFVCwNCj4gKwl7IE9QX0NPTkZJR19IRUFSVEJF
QVRfU1VCX1NFVCwgT1BfQ09ORklHX0hFQVJUQkVBVF9TVUJfU1RBVFVTLA0KPiAgCQkJCQkJCSJI
ZWFydGJlYXRTdWJTZXQiIH0sDQo+ICAJeyBPUF9DT05GSUdfSEVBUlRCRUFUX1NVQl9TVEFUVVMs
IE5PX1JFU1BPTlNFLCAiSGVhcnRiZWF0U3ViU3RhdHVzIiB9LA0KPiAgCXsgT1BfTU9ERUxfQVBQ
X0JJTkQsIE9QX01PREVMX0FQUF9TVEFUVVMsICJNb2RlbEFwcEJpbmQiIH0sDQo=
