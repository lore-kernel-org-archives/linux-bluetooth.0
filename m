Return-Path: <SRS0=qr/Y=ZO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58CEC432C3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 19:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854042068F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Nov 2019 19:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="vGulJJ/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKVTXA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:23:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:15544 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbfKVTXA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Nov 2019 14:23:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Nov 2019 11:22:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,230,1571727600"; 
   d="scan'208";a="238717913"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by fmsmga002.fm.intel.com with ESMTP; 22 Nov 2019 11:22:58 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 22 Nov 2019 11:22:29 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Nov 2019 11:22:29 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 22 Nov 2019 11:22:29 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.56) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 22 Nov 2019 11:22:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MO/N1s3xJrBeBA+vjyuMHmZO46zxtNqcGYC9NcvMVhgu/aSCTmAlrqu5T0lKtV+gVpnPrMKTe15Tk63NYUI+DDK4pGdr3tXEGQ3lUutBvNHu0CpZV5CG3LpEIDn6a4nAha8zSUyoflAB4wiAX8/ExLNLKEiOimoTkyJTsS5z3DBrPUk6lb9xyk4WNO6XVRkVYg9aN1+uDL4UlgyijUW9AjiIyYTsoZXZoJq7KdFjH3Uu4DSdq1i9lBdZkG2TfBffrNMaiuup5ofkSTscDODD7CdWcUWz64MP7IPqUfurGOMu+pwzMeS4ASSfTS07VOvAw7XPQaG7P2eHeNuhume7Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCPLcBT9o/g9SDkPsOS9BHtd+VX+C7xmHDBJFi0rg6E=;
 b=ZjvayEN9ZQCA0W48HHQuuba6fX3kFEb0B5FbgXzftBMT1zLQibjpEXfVNL7sh2JVmqAo0ftz3NXJp0aSX2s6XTzJPR5MB7hDUnrC02LpG6fc8pIjtp7S+o7vZxaq0e8HlQu/j5s3psLyrprb91HBjhaEd1c+i2NRP9jNPMICFc0A32QX8ORR/wmxEswf9vjD6+e1qeZIVtpAdbG9rK/pmy9/aQPNVI17UnYPrvwXlIDn/G7hL/HMaBlmWLsmwVtwBM+Z2m9zueFBalCWbk3rBJECdLpBS5tFAATZdPtj9RXq7dcnF/6YBnl+FAENrDkFeF42PPqwbvuWh4GDWd1/lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UCPLcBT9o/g9SDkPsOS9BHtd+VX+C7xmHDBJFi0rg6E=;
 b=vGulJJ/oWxzY1o7TutfGfTJDaCD19Pq1fNZEyPgrTwvpdU2quAIU/TcerONwiFV1ej5280GWZU3Ek+ELj9YesWG51YTv6tZ7vzWMCoeKqcxjjJtUD1C7XOdgLFLe9c7zTOA5PW2tOShl8zLKesMj7cjxnDnZ1o/q0M/vAIHmoXk=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2166.namprd11.prod.outlook.com (10.172.79.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.27; Fri, 22 Nov 2019 19:22:28 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2451.031; Fri, 22 Nov 2019
 19:22:27 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "sbrown@ewol.com" <sbrown@ewol.com>
Subject: Re: [PATCH BlueZ] tools/mesh-cfgclient: Fix signatures in agent
 methods
Thread-Topic: [PATCH BlueZ] tools/mesh-cfgclient: Fix signatures in agent
 methods
Thread-Index: AQHVoVFIkUIOsqZI9EuxU5PaZ0sEiaeXkbeA
Date:   Fri, 22 Nov 2019 19:22:27 +0000
Message-ID: <74dbd5a24110ca0531ac9722dd448a1e9fedfc33.camel@intel.com>
References: <20191122162331.10096-1-inga.stotland@intel.com>
In-Reply-To: <20191122162331.10096-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3789bea6-ec8e-4bd2-b6d6-08d76f814ffd
x-ms-traffictypediagnostic: CY4PR1101MB2166:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB2166CC1F186C724E958F7A92E1490@CY4PR1101MB2166.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(39860400002)(366004)(376002)(189003)(199004)(2501003)(6436002)(6486002)(25786009)(186003)(66476007)(14454004)(4001150100001)(6506007)(81166006)(6246003)(3846002)(110136005)(81156014)(26005)(71190400001)(86362001)(36756003)(7736002)(66556008)(8676002)(6512007)(64756008)(66446008)(66946007)(478600001)(229853002)(6116002)(99286004)(118296001)(76176011)(71200400001)(102836004)(6636002)(316002)(4326008)(5660300002)(66066001)(446003)(2616005)(11346002)(91956017)(256004)(8936002)(76116006)(305945005)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2166;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UPlzSdYpCOHgmaCO+8cFKQ5UrjKyBzk852lPanAsAHQqXU0AEZN69nRAqEegWcdiAD7QBpp6A50brvxhKpao8jHwyI8VoFKCRZxFNfGPUQuUqFoZ8Q+CcKyDxiaeFYFvl3CkVmgBXt1bPaTTucEB1a919JBru1fo5FD2sqbcZxargfUZlFxZ/OkSQ7MgbQaieMmiasaoVjfHWT42hdawCHnCdOqEucisBuoG5C0GsGosWvxkwqmvT2rl5iqouLkf1OLGzTlbJqefYCdND6CBeGNf3uie0WUQHhqGNNKHCQ7I3rgt9hlRcDM3Q4cXdAq2B2vZ1MyT50xtH9HsL25W0ywvq19bzPiuR8BccWi/l0tROCnhY6hctsQMNVHldBZlD0GkyKlEkGjZZgDDVozxaHZ9s60+J8DpOt6n4Go+tZ+9YNM6YZWRB8anY0Y9BK46
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB069B34F2DB174C9EC3B438967C40E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3789bea6-ec8e-4bd2-b6d6-08d76f814ffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 19:22:27.8546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 56uRpNOOCTOIBl+iv3tw2pbnmh2KSfJTZYPDVgq5fvRjRmvKtibJFwLPk72ujBqgqw5u6Yi7NceS509X6T/V/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2166
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCB3aXRoIGNvbW1pdCBtc2cgbW9kaWZpY2F0aW9ucywgVGhhbmtzDQoNCk9uIEZyaSwg
MjAxOS0xMS0yMiBhdCAwODoyMyAtMDgwMCwgSW5nYSBTdG90bGFuZCB3cm90ZToNCj4gVGhpcyBy
ZW1vdmVzIGFuIGV4dHJhIHJldHVybiBwYXJhbWV0ZXIgZnJvbSBQcm9tcHROdW1lcmljIGFuZCBQ
cm9tcHRTdGF0aWMNCj4gbWV0aG9kIHNpZ25hdHVyZXMuIEFsc28sIHN0eWxlIGZpeGVzLg0KPiAt
LS0NCj4gIHRvb2xzL21lc2gtY2ZnY2xpZW50LmMgfCA5ICsrKysrLS0tLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS90b29scy9tZXNoLWNmZ2NsaWVudC5jIGIvdG9vbHMvbWVzaC1jZmdjbGllbnQuYw0KPiBpbmRl
eCAxYzYxN2EzN2IuLjIwMGViNWI4NCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbWVzaC1jZmdjbGll
bnQuYw0KPiArKysgYi90b29scy9tZXNoLWNmZ2NsaWVudC5jDQo+IEBAIC00NzgsNiArNDc4LDcg
QEAgc3RhdGljIHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqZGlzcF9zdHJpbmdfY2FsbChzdHJ1Y3Qg
bF9kYnVzICpkYnVzLA0KPiAgCQkJCQkJc3RydWN0IGxfZGJ1c19tZXNzYWdlICptc2csDQo+ICAJ
CQkJCQl2b2lkICp1c2VyX2RhdGEpDQo+ICB7DQo+ICsJY29uc3QgY2hhciAqcHJvbXB0ID0gIkVu
dGVyIEFscGhhTnVtZXJpYyBjb2RlIG9uIHJlbW90ZSBkZXZpY2U6IjsNCj4gIAljaGFyICpzdHI7
DQo+ICANCj4gIAlpZiAoIWxfZGJ1c19tZXNzYWdlX2dldF9hcmd1bWVudHMobXNnLCAicyIsICZz
dHIpKSB7DQo+IEBAIC00ODUsNyArNDg2LDcgQEAgc3RhdGljIHN0cnVjdCBsX2RidXNfbWVzc2Fn
ZSAqZGlzcF9zdHJpbmdfY2FsbChzdHJ1Y3QgbF9kYnVzICpkYnVzLA0KPiAgCQlyZXR1cm4gbF9k
YnVzX21lc3NhZ2VfbmV3X2Vycm9yKG1zZywgZGJ1c19lcnJfZmFpbCwgTlVMTCk7DQo+ICAJfQ0K
PiAgDQo+IC0JYnRfc2hlbGxfcHJpbnRmKENPTE9SX1lFTExPVyAiRW50ZXIgQWxwaGFOdW1lcmlj
IGNvZGUgb24gcmVtb3RlIGRldmljZTogJXNcbiIgQ09MT1JfT0ZGLCBzdHIpOw0KPiArCWJ0X3No
ZWxsX3ByaW50ZihDT0xPUl9ZRUxMT1cgIiVzICVzXG4iIENPTE9SX09GRiwgcHJvbXB0LCBzdHIp
Ow0KPiAgDQo+ICAJcmV0dXJuIGxfZGJ1c19tZXNzYWdlX25ld19tZXRob2RfcmV0dXJuKG1zZyk7
DQo+ICB9DQo+IEBAIC01NDIsMTMgKzU0MywxMyBAQCBzdGF0aWMgdm9pZCBzZXR1cF9hZ2VudF9p
ZmFjZShzdHJ1Y3QgbF9kYnVzX2ludGVyZmFjZSAqaWZhY2UpDQo+ICAJCQkJCQkJCU5VTEwpOw0K
PiAgCS8qIFRPRE86IE90aGVyIHByb3BlcnRpZXMgKi8NCj4gIAlsX2RidXNfaW50ZXJmYWNlX21l
dGhvZChpZmFjZSwgIkRpc3BsYXlTdHJpbmciLCAwLCBkaXNwX3N0cmluZ19jYWxsLA0KPiAtCQkJ
CQkJIiIsICJzIiwgInZhbHVlIik7DQo+ICsJCQkJCQkJIiIsICJzIiwgInZhbHVlIik7DQo+ICAJ
bF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJEaXNwbGF5TnVtZXJpYyIsIDAsIGRpc3Bf
bnVtZXJpY19jYWxsLA0KPiAgCQkJCQkJIiIsICJzdSIsICJ0eXBlIiwgIm51bWJlciIpOw0KPiAg
CWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiUHJvbXB0TnVtZXJpYyIsIDAsIHByb21w
dF9udW1lcmljX2NhbGwsDQo+IC0JCQkJCQkidSIsICJzIiwgInR5cGUiKTsNCj4gKwkJCQkJCSJ1
IiwgInMiLCAibnVtYmVyIiwgInR5cGUiKTsNCj4gIAlsX2RidXNfaW50ZXJmYWNlX21ldGhvZChp
ZmFjZSwgIlByb21wdFN0YXRpYyIsIDAsIHByb21wdF9zdGF0aWNfY2FsbCwNCj4gLQkJCQkJCSJh
eSIsICJzIiwgInR5cGUiKTsNCj4gKwkJCQkJCSJheSIsICJzIiwgImRhdGEiLCAidHlwZSIpOw0K
PiAgfQ0KPiAgDQo+ICBzdGF0aWMgYm9vbCByZWdpc3Rlcl9hZ2VudCh2b2lkKQ0K
