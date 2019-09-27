Return-Path: <SRS0=evP7=XW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505E3C4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 15:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A360207E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 15:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="yMVz9i+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfI0Pvh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:51:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:52935 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726251AbfI0Pvh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Sep 2019 11:51:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 08:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,556,1559545200"; 
   d="scan'208";a="180546180"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga007.jf.intel.com with ESMTP; 27 Sep 2019 08:51:36 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Sep 2019 08:51:36 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX113.amr.corp.intel.com (10.22.240.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Sep 2019 08:51:36 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (104.47.50.59) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 27 Sep 2019 08:50:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QaK5F5HLynXF6cGCB1GLIHQPKPDlSkCLS3fG1Hk3rmQklnQd2x2aZGAj+YBTyxh0iVNWlPpXlt/lr6HhDm+FUDPgUrTSyTwkgB6Ue1BvyUqCXfIMu3jzDSyacuMDHC6wbtIcLIL/zd2i20Crv9yqUjESuQFflXXcccnlK1N7QoL5EDJPc8TQbr7fG3yaTWw3Z+3+uBrVqb6t3/AD/OQIpjXdBaPHnsIDTlaYbdSa6Y20cWQZiq6NvpT9k/a0j0ZPhF2+xOEYTjyLesowDReMy6fTdPijwjz3AWRqqZ5oZJIiXslWk0aoxogjJ03Gd4KSKURevkCbOjqcZ2soOh81wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2USbhD01xZIWytcG+DR82bMsY4F7vuKv5tQ0eW0dM0=;
 b=iM2UTcJWUOvgAxoo7qqX6yOnS4KKXLIWdNcmYS1Yo6tcfF8rPwtaoeKICWIi7LBKHAchhFA8zimxNP/fCNTLQPTKAPkPAHBZd1mIQeIaCDjhyRnWYKP1JFm5Uw+9PCFiuJl4/zzL4/T1TMWYWibNCBuvpGjZT/u6GbDisR5GjXHBNhHcr374vDU8TaocBDBQTNNs2pic7Gfo6v1NYUE807tHy6/ZzO2nGmHZ3s/TPfbStffFbc8fExQVFHOmPvpy6lc9YajTOKpA8DbcHdl39K15Vv65uZOzUqlaisaBZkwmmvmSTXSxCyYIn7V1FW2LTMLvoaEnuwvlDa2w9aAZBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2USbhD01xZIWytcG+DR82bMsY4F7vuKv5tQ0eW0dM0=;
 b=yMVz9i+1ZbDEVg4ScoFx8CeYWEh3hyQq5c+xUnWx7UCA0XYevP2FjfuCCdE86hjct8TrFBChEIzgvzrl+r7lQIC3g76EwjdfQV4xXbWE6JH9iTyvAxK0oM4q4rQBrhSAXBUPgeABw6EQt/eIWjOAWcv7xLNF3c1hLXae8R014PM=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3387.namprd11.prod.outlook.com (20.176.123.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.17; Fri, 27 Sep 2019 15:50:02 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397%7]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 15:50:02 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Topic: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Index: AQHVX2LEF/rrCs91wE6OiENpKqkMj6cxPhOAgAuqqYCAAVPegIAAWhSAgADMPACAAHTBgA==
Date:   Fri, 27 Sep 2019 15:50:02 +0000
Message-ID: <01c84f55db98fbcc2790d11fd6090589881c36cf.camel@intel.com>
References: <20190830184301.zd3zaqrw7mv6r252@kynes>
         <20190918085239.xhahxoeqjkcrk3bl@mlowasrzechonek2133>
         <3c5858c94b3e08a61c5ff8493f9b00f5f77d0aac.camel@intel.com>
         <4b57242b15ccb44ac123858ce7bdf6e0e526b3e0.camel@intel.com>
         <a0442c7485fef2bfde9bc52283a5c9dfc0b43515.camel@intel.com>
         <20190927085208.sxy2x5656ci3opo6@mlowasrzechonek2133>
In-Reply-To: <20190927085208.sxy2x5656ci3opo6@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe4d0fa5-9caf-4099-b1a2-08d743625c07
x-ms-traffictypediagnostic: DM6PR11MB3387:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3387753A3A1F79B227ABAB6CE1810@DM6PR11MB3387.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(39860400002)(346002)(366004)(189003)(199004)(11346002)(4326008)(99286004)(3846002)(76176011)(316002)(36756003)(6512007)(476003)(71200400001)(486006)(5660300002)(102836004)(2501003)(71190400001)(256004)(8936002)(186003)(26005)(6246003)(25786009)(6506007)(6116002)(2616005)(15650500001)(446003)(81156014)(81166006)(8676002)(66446008)(66556008)(91956017)(66946007)(76116006)(6486002)(7736002)(229853002)(6436002)(86362001)(478600001)(110136005)(66476007)(64756008)(2906002)(118296001)(14454004)(305945005)(66066001)(6636002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3387;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lUSOT64psYQ4o0FZseURM2hAJ3HSMhnSMGmweKqsTjn/aMnv9TLOeF7ebWiSwgKy9Tv6HNcWyMV9IXYTy76bH7hByRyVu6XNL80kpvYnOuGaP3U4MwpA/CTCIkvWx1oPdlmNDAdRirWupF8sJLt5MumsR7wf03AnVzDUqThAvR0W+C6pmn5AUx/n/ZyrJPouHzVhTq17NmYg7fcARuXxWctX4ZvgsNuCHeItbF6ujboCEqC7c/WmuHc1ZwQl4yWJCWdxX/0fBNO+tykX9C0bkP7edocmQRX9WriFJeU/1mjkWPX+gzU2Lh0I5azMZS+PHXxYRYW3vjE8jnXB2xCgyzN+E/6iq/nU9eUhb5m7Su2/73F84af4hF4AT+L4bNXwRPgmH+Fu9ejOLOwjjq5btEavDsS3tVMRRxKj75OBGCY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2103D4C35D1A89429EA5B59DFA76C4CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4d0fa5-9caf-4099-b1a2-08d743625c07
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 15:50:02.5219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t2/MKUlfuuvWPDxGk45zldnRjNjf2g0hpMiQ/9UuAI2P0ou6CmNIBg6EYC3tKjBwT9C0RLxBn5Q9E7tDO7xQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3387
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gRnJpLCAyMDE5LTA5LTI3IGF0IDEwOjUyICswMjAwLCBtaWNoYWwubG93YXMtcnplY2hvbmVr
QHNpbHZhaXIuY29tIHdyb3RlOg0KPiBJbmdhLCBCcmlhbiwNCj4gDQo+IFN0aWxsLCBldmVuIGlm
IHdlIGFkZCBhIG1ldGhvZCwgdGhlIGFwcGxpY2F0aW9uIGlzIGZyZWUgKm5vdCogdG8NCj4gaW1w
bGVtZW50IGl0LCBzaW5jZSB3ZSBhZ3JlZWQgYmFjayBpbiB0aGUgZGF5IHRoYXQgY2FsbHMgdG8N
Cj4gTWVzc2FnZVJlY2VpdmVkIGRvIG5vdCByZXF1aXJlIGEgcmVzcG9uc2UsIHNvIGFueSBlcnJv
cnMgd291bGQgYmUgc2ltcGx5DQo+IGlnbm9yZWQgYnkgdGhlIGRhZW1vbi4NCg0KVGhpcyBpcyBu
b3QgYW4gb3B0aW9uLg0KDQpBIG5vZGUgZG9lcyBub3QgZ2V0IHRvIGRlY2lkZSB3aGljaCBzdXNi
c2NyaXB0aW9ucyBhcmUgInZhbGlkIi4gIElmIGEgVmlydHVhbCBBZGRyZXNzIHN1YnNjcmlwdGlv
biBpcyBhZGRlZCB0bw0KYSBub2RlLCBhbmQgdGhlbiBhIG1lc3NhZ2UgaXMgc2VudCB0byB0aGF0
IHZpcnR1YSBhZGRyZXNzLCB0aGUgQXBwIG5lZWRzIHRvIGJlIGFibGUgdG8gcmVjZWl2ZSBpdC4N
Cg0KWWVzLCBhbnkgZGlzY3JldGUgbWVzc2FnZSBtYXkgYmUgbG9zdCwgYnV0IEkgZG9uJ3QgdGhp
bmsgd2UgaGF2ZSB0aGUgb3B0aW9uIG9mIGxldHRpbmcgKmFsbCogdmlydHVhbCBhZGRyZXNzZWQN
Cm1lc3NhZ2VzIHRvIGFuIEFwcCB0byBiZSBpZ25vcmVkLiAgSWYgd2UgYWRkIGFuIEFwcCBBUEks
IGl0IHdpbGwgbmVlZCB0byBiZSBtYW5kYXRvcnksIHdoaWNoIGlzIHdoeSBJIGFtDQphZ2FpbnN0
IGl0Lg0KDQpJIHN0cm9uZ2x5IGJlbGlldmUgd2UgbmVlZDoNCg0KMS4gQSBzaW5nbGUgbWV0aG9k
IGZvciBkZWxpdmVyaW5nIChub24gZGV2IGtleSkgcmVjZWl2ZWQgbWVzc2FnZXMNCjIuIEEgbWV0
aG9kIHRoYXQgZG9lcyBub3QgcmVxdWlyZSBkaWN0aW9uYXJ5IHBhcnNpbmcNCg0KSG93IGFyZSB3
ZSBmZWVsaW5nIGFib3V0Og0KCXZvaWQgTWVzc2FnZVJlY2VpdmVkKHVpbnQxNiBzb3VyY2UsIHVp
bnQxNiBrZXlfaW5kZXgsDQoJCQkJYXJyYXl7Ynl0ZX0gZGVzdGluYXRpb24sIGFycmF5e2J5dGV9
IGRhdGEpDQoNCg0KV2hlcmUgZGVzdGluYXRpb24gbGVuZ3RoIG9mOg0KCTAgLSBVbmljYXN0IGFk
ZHJlc3Mgb2YgZWxlbWVudA0KCTIgLSBHcm91cCBBZGRyZXNzDQoJMTYgLSBWYXJpYWJsZSBMYWJl
bA0KDQpJIHRoaW5rIHRoaXMgZnVsZmlsbHMgYWxsIG9mIG91ciByZXF1aXJlbWVudHMuDQoNCg0K
DQoNCg0KDQoNCg==
