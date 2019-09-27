Return-Path: <SRS0=evP7=XW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EEEC4360C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 15:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0CA21924
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Sep 2019 15:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="uE0+7lHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbfI0PBJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:01:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:61708 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727747AbfI0PBJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Sep 2019 11:01:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 08:01:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; 
   d="scan'208";a="189463806"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga008.fm.intel.com with ESMTP; 27 Sep 2019 08:01:08 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Sep 2019 08:01:08 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX121.amr.corp.intel.com (10.22.225.226) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Sep 2019 08:01:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.52) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 27 Sep 2019 08:01:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utk+pthnqbVruvRVKiUqwLMwOf42JpP46Lh3xB4BAEUiOe3sE6h0/A6PufFpaghivQAibcKpOPn7izu+n1ujaPmkvHByKCBazQD4mPBZBjdi+dvAE7WXySwFLkDaFuizr/ZhZ+xb5zOnNgQp6OWOCFB6S6mq7mfvWYfY6NXz/za0LiWaPV39BZqrDwEUhDpTRDSENKINNY/joPVsBJa51y7/qj1Jafuo/NJDj04YsTQ5WNMTpXLHlve7oa2ou5xfMviSlPs3C3OqRPkUdM4oTzX40WCXDoc6Iu64G7+GpE3AZJp7Etg0wReZGrHIW7TbZIvYlVfHXeB5wJaAt10r+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF+wneVt3+NIQMPI46EtQA9zSyalXvZRhoguZNl8pXM=;
 b=c2v5SfscOSsmItKut96w1Woujy8osCZDy8nEX7qGTJUgxvX9GUzpmddbVv8Hqasnelf3BpPGFwiwdLwDc6/o8GCiA80HNRb/pI2miMhAx/jkmVNItwKfE9RJhoq+nUPHmLSDujlqjBdb5vHL4ee4P5MV7jnXMnZPC9dNSSwT29sVyoeetp/t35YpWpj6sBPXmgDHLPngK2HDPUXWWOEPM0DC0kFaXUKtQyFxoKDSUn8sYd1pDMoUW1UwJ7V1gdwFLcES2i3N6j4a4M7J44u1A22nhjA+842d2BD52zyDGOZiexvvsjdK11CCwaXsVIjP+DbXP2Uu2mi36QptsuPD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zF+wneVt3+NIQMPI46EtQA9zSyalXvZRhoguZNl8pXM=;
 b=uE0+7lHC3FcutNKuo3OyefLBXFkhyD65n8IkNx7G8KQDH+NuTCVOxn6NQXd3ZI0iLZHcwmD4YHapBtpMBgk7v3+mkNHvwMxJlbAb+i/lxyVWcHT7IqXo/cHrVQmpuGaQFJnT79ONjkZ0WMFNsCq8pMco2Ax9Jb6MFgW3dlXYq98=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB3147.namprd11.prod.outlook.com (20.177.219.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.15; Fri, 27 Sep 2019 15:01:04 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::5d45:636:6a4a:9397%7]) with mapi id 15.20.2305.017; Fri, 27 Sep 2019
 15:01:04 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Topic: mesh: org.bluez.mesh.Element.MessageReceived method does not
 provide destination address
Thread-Index: AQHVX2LEF/rrCs91wE6OiENpKqkMj6cxPhOAgAuqqYCAAVPegIAAWhSAgADMPACAAGcTgA==
Date:   Fri, 27 Sep 2019 15:01:04 +0000
Message-ID: <9b14b4b5ae3a0a04f441ff750da107022a4066c9.camel@intel.com>
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
x-ms-office365-filtering-correlation-id: a8f04ebe-cc79-483e-5dd1-08d7435b84ab
x-ms-traffictypediagnostic: DM6PR11MB3147:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB314711782803787FE722D266E1810@DM6PR11MB3147.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(486006)(36756003)(446003)(25786009)(6436002)(14454004)(6512007)(91956017)(229853002)(66946007)(66446008)(478600001)(4326008)(2501003)(99286004)(6246003)(66556008)(76176011)(6506007)(76116006)(64756008)(86362001)(7736002)(476003)(2616005)(11346002)(66066001)(316002)(118296001)(110136005)(305945005)(102836004)(71190400001)(6486002)(26005)(186003)(66476007)(8676002)(256004)(6636002)(2906002)(3846002)(6116002)(8936002)(71200400001)(5660300002)(81156014)(81166006)(15650500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3147;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yo/BHLzKibLnH3KFCD/+012xpDNeoMaPeBhbigGDQk6W7tjr8LHJmDRoYmEF+26trVTw9j16ikBhmaWIhkZInOUCV7MUM+tl6eFOlrwrnBCyS14aWDtkG2defkeb1soJoXapitsmGjzTFetqFDqariomczMXQv8tGKqX3ZzCZUdfho1LGh9XHQlk7Dat/ogBuC0QvVnsyBGaf3O19DbqDcYQAAbHEZOSfHOLi8S/5B5N6LY90XkzWmmqppyf0Da0GzGMgU6kM2TnzUCEJsFBc05tIB+GBKqRw2B2rsoPQbTGE8/gs2s74JOC8AlOFE2i03y1VEgR55cTAakumEjsZBLzgmde52gAZHaln53hi9Qsq80tt3sCbg3/l6GYgDPoydnvDKlDN0pHkN6B64YNnFeYRvpcxWowtVr3x+6DbbQ=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A8D8050DFEE28448EBAC6568A4902E9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f04ebe-cc79-483e-5dd1-08d7435b84ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 15:01:04.2123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1P5lgPEN4NnPl51vfeb/OjNaYRaDeSj+eZ1KkaBvt9UaZwUVxCazoCY0+4ElmAzvYlVC2Y5qxK/6Tp878gDg/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3147
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwgSW5nYSwNCg0KT24gRnJpLCAyMDE5LTA5LTI3IGF0IDEwOjUyICswMjAwLCBt
aWNoYWwubG93YXMtcnplY2hvbmVrQHNpbHZhaXIuY29tIHdyb3RlOg0KPiBJbmdhLCBCcmlhbiwN
Cj4gDQo+IE9uIDA5LzI2LCBTdG90bGFuZCwgSW5nYSB3cm90ZToNCj4gPiBXaGlsZSBJIGFtIHN0
aWxsIGluIGZhdm9yIG9mIHR3byBkaXN0aW5jdCBtZXRob2RzIChnaXZlbiBjaG9pY2UsIEknZA0K
PiA+IGFsd2F5cyBnbyB3aXRoIHNlbGYtZXhwbGFuYXRvcnkgQVBJKQ0KPiANCj4gU28gZG8gSS4N
Cj4gDQo+ID4gSSB2b3RlIGFnYWluc3QgdTE2IGRlc3RpbmF0aW9uIGZpZWxkIHNpbmNlIHRoZXJl
IGlzIG5vIHJlYXNvbiB0bw0KPiA+IGNyZWF0ZSBhZGRyZXNzIHNwYWNlIGNvbGxpc2lvbiBldmVu
IHRob3VnaCB0aGUgY2hhbmNlcyBhcmUgc21hbGwuDQo+ID4gDQo+ID4gQSBzaW5nbGUgbWV0aG9k
ICJNZXNzYWdlUmVjZWl2ZWQiIG1ldGhvZCBjYW4gYmUgbW9kaWZpZWQgdG8gaW5jbHVkZSBhDQo+
ID4gc3Vic2NyaXB0aW9uIHBhcmFtZXRlciBhczoNCj4gPiAxKSBhIGRpY3Rpb25hcnkgd2l0aCBr
ZXlzICJHcm91cCIgYW5kICJMYWJlbCIgKHNlbGYgZXhwbGFuYXRvcnkgaWYgYQ0KPiA+IGJpdCBj
dW1iZXJzb21lKS4NCj4gDQo+IElmIHdlIHJlYWxseSBuZWVkIHRvIGF2b2lkIHR3byBzZXBhcmF0
ZSBtZXRob2RzLCBJIHRoaW5rIGl0IHdvdWxkIGJlIGENCj4gYml0IGNsZWFuZXIgdG8gcGFzcyB0
aGlzIHBhcmFtZXRlciBhcyBhIEQtQnVzIHZhcmlhbnQgb2YgKHUxNiwNCj4gYXJyYXlbMTZdKSBp
bnN0ZWFkIG9mIGEgZGljdGlvbmFyeS4NCg0KSGVyZSBpcyBhbiBpbnRlcmVzdGluZyBpZGVhLi4u
DQoNCklzIGl0IHBvc3NpYmxlIHRvIHVzZSBhIHZhcmlhYmxlIHNpemVkIGFycmF5IGZvciB0aGUg
YWRkcmVzcz8NCg0KMCBvY3RldHMgLS0gRGVzdGluYXRpb24gaXMgdGhlIFVuaWNhc3QgYWRkcmVz
cw0KMiBvY3RldHMgLS0gRGVzdGluYXRpb24gaXMgYSBuZXR3b3JrIGJ5dGUgb3JkZXJlIChCaWcg
RW5kaWFuKSB1MTYNCjE2IG9jdGV0cyAtLSBEZXN0aW5hdGlvbiBpcyBhIDEyOGJpdCBWaXJ0dWFs
IGxhYmVsDQoNClRoZSBjYXZlYXQgaGVyZSBpcyB0aGF0IHRoZXJlIHdvdWxkIGJlIHR3byB2YXJp
YWJsZSBvY3RldCBhcnJheXMgaW4gdGhlIG1lc3NhZ2UsDQpidXQgZnJvbSBhIEQtQnVzIGVmZmlj
aWVuY3kgc3RhbmRwb2ludCwgbWlnaHQgYmUgdGhlIGJlc3Qgd2UgYXJlIGdvaW5nIHRvIGRvLg0K
DQo+IA0K
