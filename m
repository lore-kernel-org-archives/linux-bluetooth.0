Return-Path: <SRS0=VFYa=Y5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E69C5DF60
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Nov 2019 21:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052BA2087E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Nov 2019 21:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="RAOsF7/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfKEVGp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 5 Nov 2019 16:06:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:10570 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfKEVGp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 5 Nov 2019 16:06:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 13:06:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,271,1569308400"; 
   d="scan'208";a="353270348"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga004.jf.intel.com with ESMTP; 05 Nov 2019 13:06:44 -0800
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 5 Nov 2019 13:06:44 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 5 Nov 2019 13:06:44 -0800
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (104.47.49.53) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 5 Nov 2019 13:06:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TTCwIXhQdbd+iroER8/1kzO6KhfqEHWdc/VOWrIFu6u5tS0Flz87y9/ob7b5M+DoEeCoDuu+Q8FEt8tA9W+o6HTuWIwLB/pYrTqk5BQCtZJAEVi0YKmLcVr6CTs3lo06BRuDP+wLPHPuW06txCA0+YS8qwjeGbNnVxXH3vFqIDSCBzStcME3jcwYHXfpZU6N6FDhza9/zJr2aSt1Jns0qa2f2JLj5RIG6055GhtmMCF/TcT+H81LYDMVm8VTO4cXNxRyKVlqCIlScbzwZgG7dZpexXmMiQxaTd5lOwncLAa/HyZD9M0tflT6vXLH32qYM41JJ+AQqXJ9tRW/pjYfhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeCFe8ZvIKFdyBS2MF3p2AeuPSO5If7hBragKxbfyI4=;
 b=GUCR4/Y8flusvjEb1lv8U2ti6lUhkj3enS6Dg/euCs4fGvEb9mXmFDxzVcnvV5MhiyObM1lo7o6mGdENW+IoxekAjmOUezDQ0PYH9TG/czwSVPDtZp/y4Bn7ELKw2I6x71L7xl0KrAJ3fSVMtQC/wMPZsIjDhJJ1Srm4yHHMKJCJTfgVsUZfsoqeYiGxgXEKGyVGCiU6a9FrUNcIe527lnfbjv9FDFoefAxYs+Q3MxbfzCCqlE3Ku1RFvvpVbbc/PO9vAkvBiw/6f92rAIG0ebG/eFJeXklF8YeyBLXFxTEhdenrcdvmf3hoBS1NF852ZQyVH4QSOwVziYTyzyffVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aeCFe8ZvIKFdyBS2MF3p2AeuPSO5If7hBragKxbfyI4=;
 b=RAOsF7/qti4GTwJAsxCrCjunpw+Z8EWoLvJ/bP4P1HPcMNmOp3sp3EmZUCRdr8kk+FEe3ardnC/GG3gIOI/bn4YUSbokoLPM5cj7y3xjYB/IbGZj+i+/ByGzRVK3z4BvuaP+dD1Akq6xCDMCxZXV+opKIGtNKYgmXzcJb7bvJzI=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2343.namprd11.prod.outlook.com (10.173.193.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 5 Nov 2019 21:06:25 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c143:8007:1ec5:fdba%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 21:06:25 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 00/10 v2] Mesh provisioning and configuration tool
Thread-Topic: [PATCH BlueZ 00/10 v2] Mesh provisioning and configuration tool
Thread-Index: AQHVkOZCaefrq6Bq5kO5xGNW3/RvOqd9F/WA
Date:   Tue, 5 Nov 2019 21:06:24 +0000
Message-ID: <5c4c02bdfb7d18e79b01d45c8a263c7d425fd04f.camel@intel.com>
References: <20191101185729.31661-1-inga.stotland@intel.com>
In-Reply-To: <20191101185729.31661-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85507189-a2a6-45e5-b249-08d762340487
x-ms-traffictypediagnostic: CY4PR1101MB2343:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB23433FF40ED93F4E76B54FEBE17E0@CY4PR1101MB2343.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(136003)(396003)(39860400002)(189003)(199004)(2501003)(71190400001)(6436002)(71200400001)(66556008)(486006)(446003)(478600001)(118296001)(2616005)(6636002)(11346002)(476003)(6116002)(3846002)(36756003)(66446008)(26005)(86362001)(186003)(6506007)(64756008)(6512007)(229853002)(102836004)(76116006)(5660300002)(91956017)(316002)(8936002)(99286004)(25786009)(66946007)(66066001)(76176011)(81166006)(110136005)(6246003)(6486002)(14444005)(8676002)(81156014)(305945005)(7736002)(2906002)(256004)(14454004)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2343;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5/IIZ6blE6HvM5zRjngHqHTXUTza3e12RjAn+RSjbgGNWyQQQhNb3FjNLFqOWz41U68zK2CGKHHmvf7lhOhRne1YO5vbm1ustLa9FuvTR+gCe8/6RTzcH2fbn2PY+8SE0UZWKBOErCerjsMyP8UaIpWuZ68ZGzr6jabTNNv+pxPGjvhdL+tB6NW4vxMuT3rm8QaOFIyYE+Sim3lUrqrQvMGjjfbl/Ud2JXVjrIn2L2ELn6R1O0kms3y8phNaUzTA4Q4vrKV6MybA8HSqjAPlVUpvdMIZ7jm0h0xZgdAbe6jkcf4kIqf9Z61p46jdcxT0hNxJd2Lj17Nk/ryVvOQLwW/1vGtQtkEaWhnLMxt/xIQHSoLedEFjK4AYF6QfsXiY5LAa7+wwXuRy9oncPfjt8PWgFoVxPB31u9TNXqGqi6MGwEKj1U0/Z2yG99IIkYJh
Content-Type: text/plain; charset="utf-8"
Content-ID: <026B0DDAB6090B40ABFBD708DE6EF765@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 85507189-a2a6-45e5-b249-08d762340487
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 21:06:24.9188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Eg9+Otnj7sxOxAuhjLUSOc1tRu5v5DS1S+L64VZZBZ+rxHoX7VK3wT3U80m5pCgwnSWXUIxYA8f+66kQPDBZCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2343
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggc2V0IGFwcGxpZWQNCg0KT24gRnJpLCAyMDE5LTExLTAxIGF0IDExOjU3IC0wNzAwLCBJ
bmdhIFN0b3RsYW5kIHdyb3RlOg0KPiB2MjoNCj4gMS4gQWRqdXN0IGZvciBjaGFuZ2VkIGxfZGJ1
c19vYmplY3RfbWFuYWdlcl9lbmFibGUgcGFyYW1ldGVycw0KPiAyLiBGaXggQXBwS2V5IGRlbGV0
ZSBhbmQgQWRkIE1vZGVsIGJpbmRpbmdzIGNvbW1hbmRzICh0b29scy9tZXNoL2NmZ2xpLmMpDQo+
IDMuIEFEanVzdCBKU09OIHN0b3JhZ2UgZm9ybWF0IGFuZCBhZGQgc3VwcG9ydCBmb3IgTmV0S2V5
IEFwcEtleSBkZWxldGlvbi4NCj4gDQo+ICoqKioqKioqKioqKioqKioqKioqKg0KPiBUaGlzIHBh
dGNoIHNldCBhZGRzIGEgbWVzaC1jZmdjbGllbnQgdG9vbCB0aGF0IGFsbG93cyB0byBjcmVhdGUN
Cj4gbWVzaCBuZXR3b3JrcyBvcGVyYXRpbmcgb3ZlciBhZHZlcnRpc2luZyAoUEItQURWKSBwcm92
aXNpb25pbmcNCj4gYmVhcmVyLiBUaGUgdG9vbGltcGxlbWVudHMgc3VwcG9ydCBmb3I6DQo+ICAt
IGNyZWF0aW5nIG9mIHRoZSBpbml0YWwgInBjcm92aXNpb25lciIgbm9kZSB3aXRoIHRoZSBpbml0
aWFsIG5ldHdvcmsga2V5DQo+ICAtIGFkZGluZy9yZW1vdmluZyBuZXR3b3JrIGFuZCBhcHBsaWNh
dGlvbiBrZXlzIHRvIHRoZSBuZXR3b3JrDQo+ICAtIHByb3Zpc2lvbmluZyByZW1vdGUgZGV2aWNl
cyBpbnRvIG1lc2ggbmV0d29yaw0KPiAgLSBjb25maWd1cmluZyBvZiB0aGUgcHJvdmlzaW9uZWQg
bm9kZXMgKENvbmZpZyBNb2RlbCBDbGllbnQgb3BlcmF0aW9ucykNCj4gDQo+IE5ldHdvcmsgY29u
ZmlndXJhdGlvbiBpcyBzYXZlZCBpbiBKU09OIGZvcm1hdCBmaWxlLg0KPiBEaXNjbGFpbWVyOiB0
aGUgc3RvcmFnZSBpcyB3b3JrIGluIHByb2dyZXNzIGFuZCBpcyBub3QgZnVsbHkgaW1wbGVtZW50
ZWQuDQo+IA0KPiBBbHNvLCBzb21lIGZ1bmN0aW9uYWxpdHkgb3ZlcmxhcHMgd2l0aCBtZXNoY3Rs
IHRvb2wgKEdBVFQgYmFzZWQgbWVzaA0KPiBuZXR3b3JrIHByb3Zpc2lvbmluZyBhbmQgY29uZmln
dXJhdGlvbiB0b29sKS4gRm9yIHRoZSB0aW1lIGJlaW5nLCB0aGVzZQ0KPiB0d28gdG9vbHMgYXJl
IHNlcGFyYXRlIGFuZCBjb2V4aXN0IHNpZGUgYnkgc2lkZS4gRXZlbnR1YWxseSwgYWRkaXRpb25h
bA0KPiB3b3JrIG5lZWRzIHRvIGJlIGRvbmUgdG8gZWxlaW1pbmF0ZSBvdmVybGFwcGluZyBhcmVh
cyBhbmQgcG90ZW50aWFsbHkNCj4gbWVyZ2UgdGhlIHRvb2xzLiBDdXJyZW50bHksIG1lc2hjdGwg
c3VwcGxlbWVuYWwgZmlsZXMgYXJlIG1vdmVkIHRvDQo+IHRvb2xzL21lc2gtZ2F0dA0KPiANCj4g
DQo+IEluZ2EgU3RvdGxhbmQgKDEwKToNCj4gICB0b29scy9tZXNoOiBSZW1vdmUgZXh0cmEgZGVw
ZW5kZW5jaWVzIGZyb20gYWdlbnQuYw0KPiAgIHRvb2xzL21lc2g6IE1vdmUgbWVzaGN0bCBzcGVj
aWZpYyBmaWxlcyB0byBtZXNoLWdhdHQNCj4gICB0b29sczogQWRkIG1lc2gtY2ZnY2xpZW50IHRv
b2wNCj4gICB0b29scy9tZXNoOiBtb3ZlIHJlbW90ZSBub2RlIHByb2Nlc3NpbmcgdG8gYSBzZXBh
cmF0ZSBmaWxlDQo+ICAgdG9vbHMvbWVzaC1jZmdjbGllbnQ6IENvbW1hbmRzIGZvciBNYW5hZ2Vt
ZW50IGlmYWNlIG1ldGhvZHMNCj4gICB0b29scy9tZXNoLWNmZ2NsaWVudDogQWRkIGNvbmZpZyBt
ZW51IGtleSBjb21tYW5kcw0KPiAgIHRvb2xzL21lc2gtY2ZnY2xpZW50OiBBZGQgdGltZW91dCBm
b3IgZXhwZWN0ZWQgcmVzcG9uc2UNCj4gICB0b29scy9tZXNoLWNmZ2NsaWVudDogQ29tbWFuZCBs
aW5lIG9wdGlvbiBmb3IgY29uZmlnDQo+ICAgdG9vbHMvbWVzaDogYWRkIGluaXRpYWwgc3VwcG9y
dCBmb3IgY29uZmlnIHN0b3JhZ2UNCj4gICB0b29scy9tZXNoLWNmZ2NsaWVudDogQWRkIFJFQURN
RSBmaWxlDQo+IA0KPiAgLmdpdGlnbm9yZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgICAxICsNCj4gIE1ha2VmaWxlLnRvb2xzICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICA0NiArLQ0KPiAgdG9vbHMvbWVzaC1jZmdjbGllbnQuYyAgICAgICAgICAgICAgICAgICAgfCAx
ODYxICsrKysrKysrKysrKysrKysrKysrKw0KPiAgdG9vbHMvbWVzaC1nYXR0L1JFQURNRSAgICAg
ICAgICAgICAgICAgICAgfCAgIDQzICsNCj4gIHRvb2xzL3ttZXNoID0+IG1lc2gtZ2F0dH0vY29u
ZmlnLWNsaWVudC5jIHwgICAxNCArLQ0KPiAgdG9vbHMve21lc2ggPT4gbWVzaC1nYXR0fS9jb25m
aWctc2VydmVyLmMgfCAgIDE0ICstDQo+ICB0b29scy97bWVzaCA9PiBtZXNoLWdhdHR9L2NyeXB0
by5jICAgICAgICB8ICAgIDUgKy0NCj4gIHRvb2xzL3ttZXNoID0+IG1lc2gtZ2F0dH0vY3J5cHRv
LmggICAgICAgIHwgICAgMA0KPiAgdG9vbHMve21lc2ggPT4gbWVzaC1nYXR0fS9nYXR0LmMgICAg
ICAgICAgfCAgIDExICstDQo+ICB0b29scy97bWVzaCA9PiBtZXNoLWdhdHR9L2dhdHQuaCAgICAg
ICAgICB8ICAgIDANCj4gIHRvb2xzL21lc2gtZ2F0dC9rZXlzLmggICAgICAgICAgICAgICAgICAg
IHwgICAzOSArDQo+ICB0b29scy97bWVzaCA9PiBtZXNoLWdhdHR9L2xvY2FsX25vZGUuanNvbiB8
ICAgIDANCj4gIHRvb2xzL3ttZXNoID0+IG1lc2gtZ2F0dH0vbWVzaC1uZXQuaCAgICAgIHwgICAg
MA0KPiAgdG9vbHMve21lc2ggPT4gbWVzaC1nYXR0fS9uZXQuYyAgICAgICAgICAgfCAgIDE2ICst
DQo+ICB0b29scy97bWVzaCA9PiBtZXNoLWdhdHR9L25ldC5oICAgICAgICAgICB8ICAgIDANCj4g
IHRvb2xzL3ttZXNoID0+IG1lc2gtZ2F0dH0vbm9kZS5jICAgICAgICAgIHwgICAxNiArLQ0KPiAg
dG9vbHMve21lc2ggPT4gbWVzaC1nYXR0fS9ub2RlLmggICAgICAgICAgfCAgICAwDQo+ICB0b29s
cy97bWVzaCA9PiBtZXNoLWdhdHR9L29ub2ZmLW1vZGVsLmMgICB8ICAgMTUgKy0NCj4gIHRvb2xz
L3ttZXNoID0+IG1lc2gtZ2F0dH0vb25vZmYtbW9kZWwuaCAgIHwgICAgMA0KPiAgdG9vbHMve21l
c2ggPT4gbWVzaC1nYXR0fS9wcm92LWRiLmMgICAgICAgfCAgIDE0ICstDQo+ICB0b29scy97bWVz
aCA9PiBtZXNoLWdhdHR9L3Byb3YtZGIuaCAgICAgICB8ICAgIDANCj4gIHRvb2xzL3ttZXNoID0+
IG1lc2gtZ2F0dH0vcHJvdi5jICAgICAgICAgIHwgICAxNiArLQ0KPiAgdG9vbHMve21lc2ggPT4g
bWVzaC1nYXR0fS9wcm92LmggICAgICAgICAgfCAgICAwDQo+ICB0b29scy97bWVzaCA9PiBtZXNo
LWdhdHR9L3Byb3ZfZGIuanNvbiAgICB8ICAgIDANCj4gIHRvb2xzL21lc2gtZ2F0dC91dGlsLmMg
ICAgICAgICAgICAgICAgICAgIHwgIDIyMCArKysNCj4gIHRvb2xzL21lc2gtZ2F0dC91dGlsLmgg
ICAgICAgICAgICAgICAgICAgIHwgICA0MSArDQo+ICB0b29scy9tZXNoL1JFQURNRSAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAgNDMgKy0NCj4gIHRvb2xzL21lc2gvYWdlbnQuYyAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAzMiArLQ0KPiAgdG9vbHMvbWVzaC9jZmdjbGkuYyAgICAgICAg
ICAgICAgICAgICAgICAgfCAxNDEzICsrKysrKysrKysrKysrKysNCj4gIHRvb2xzL21lc2gvY2Zn
Y2xpLmggICAgICAgICAgICAgICAgICAgICAgIHwgICAyNSArDQo+ICB0b29scy9tZXNoL2NvbmZp
Zy1tb2RlbC5oICAgICAgICAgICAgICAgICB8ICAgIDMgKy0NCj4gIHRvb2xzL21lc2gva2V5cy5j
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE3NSArKw0KPiAgdG9vbHMvbWVzaC9rZXlzLmgg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDI3ICstDQo+ICB0b29scy9tZXNoL21lc2gtZGIu
YyAgICAgICAgICAgICAgICAgICAgICB8ICA4OTkgKysrKysrKysrKw0KPiAgdG9vbHMvbWVzaC9t
ZXNoLWRiLmggICAgICAgICAgICAgICAgICAgICAgfCAgIDU0ICsNCj4gIHRvb2xzL21lc2gvbW9k
ZWwuaCAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2MyArDQo+ICB0b29scy9tZXNoL3JlbW90
ZS5jICAgICAgICAgICAgICAgICAgICAgICB8ICAyNjYgKysrDQo+ICB0b29scy9tZXNoL3JlbW90
ZS5oICAgICAgICAgICAgICAgICAgICAgICB8ICAgMjkgKw0KPiAgdG9vbHMvbWVzaC91dGlsLmMg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTA3ICstDQo+ICB0b29scy9tZXNoL3V0aWwuaCAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTQgKy0NCj4gIHRvb2xzL21lc2hjdGwuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAyMiArLQ0KPiAgNDEgZmlsZXMgY2hhbmdlZCwgNTMx
MyBpbnNlcnRpb25zKCspLCAyMzEgZGVsZXRpb25zKC0pDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
dG9vbHMvbWVzaC1jZmdjbGllbnQuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL21lc2gt
Z2F0dC9SRUFETUUNCj4gIHJlbmFtZSB0b29scy97bWVzaCA9PiBtZXNoLWdhdHR9L2NvbmZpZy1j
bGllbnQuYyAoOTklKQ0KPiAgcmVuYW1lIHRvb2xzL3ttZXNoID0+IG1lc2gtZ2F0dH0vY29uZmln
LXNlcnZlci5jICg5NCUpDQo+ICByZW5hbWUgdG9vbHMve21lc2ggPT4gbWVzaC1nYXR0fS9jcnlw
dG8uYyAoOTklKQ0KPiAgcmVuYW1lIHRvb2xzL3ttZXNoID0+IG1lc2gtZ2F0dH0vY3J5cHRvLmgg
KDEwMCUpDQo+ICByZW5hbWUgdG9vbHMve21lc2ggPT4gbWVzaC1nYXR0fS9nYXR0LmMgKDk4JSkN
Cj4gIHJlbmFtZSB0b29scy97bWVzaCA9PiBtZXNoLWdhdHR9L2dhdHQuaCAoMTAwJSkNCj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9tZXNoLWdhdHQva2V5cy5oDQo+ICByZW5hbWUgdG9vbHMv
e21lc2ggPT4gbWVzaC1nYXR0fS9sb2NhbF9ub2RlLmpzb24gKDEwMCUpDQo+ICByZW5hbWUgdG9v
bHMve21lc2ggPT4gbWVzaC1nYXR0fS9tZXNoLW5ldC5oICgxMDAlKQ0KPiAgcmVuYW1lIHRvb2xz
L3ttZXNoID0+IG1lc2gtZ2F0dH0vbmV0LmMgKDk5JSkNCj4gIHJlbmFtZSB0b29scy97bWVzaCA9
PiBtZXNoLWdhdHR9L25ldC5oICgxMDAlKQ0KPiAgcmVuYW1lIHRvb2xzL3ttZXNoID0+IG1lc2gt
Z2F0dH0vbm9kZS5jICg5OCUpDQo+ICByZW5hbWUgdG9vbHMve21lc2ggPT4gbWVzaC1nYXR0fS9u
b2RlLmggKDEwMCUpDQo+ICByZW5hbWUgdG9vbHMve21lc2ggPT4gbWVzaC1nYXR0fS9vbm9mZi1t
b2RlbC5jICg5NiUpDQo+ICByZW5hbWUgdG9vbHMve21lc2ggPT4gbWVzaC1nYXR0fS9vbm9mZi1t
b2RlbC5oICgxMDAlKQ0KPiAgcmVuYW1lIHRvb2xzL3ttZXNoID0+IG1lc2gtZ2F0dH0vcHJvdi1k
Yi5jICg5OSUpDQo+ICByZW5hbWUgdG9vbHMve21lc2ggPT4gbWVzaC1nYXR0fS9wcm92LWRiLmgg
KDEwMCUpDQo+ICByZW5hbWUgdG9vbHMve21lc2ggPT4gbWVzaC1nYXR0fS9wcm92LmMgKDk4JSkN
Cj4gIHJlbmFtZSB0b29scy97bWVzaCA9PiBtZXNoLWdhdHR9L3Byb3YuaCAoMTAwJSkNCj4gIHJl
bmFtZSB0b29scy97bWVzaCA9PiBtZXNoLWdhdHR9L3Byb3ZfZGIuanNvbiAoMTAwJSkNCj4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9tZXNoLWdhdHQvdXRpbC5jDQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgdG9vbHMvbWVzaC1nYXR0L3V0aWwuaA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xz
L21lc2gvY2ZnY2xpLmMNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy9tZXNoL2NmZ2NsaS5o
DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvbWVzaC9rZXlzLmMNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCB0b29scy9tZXNoL21lc2gtZGIuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xz
L21lc2gvbWVzaC1kYi5oDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvbWVzaC9tb2RlbC5o
DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdG9vbHMvbWVzaC9yZW1vdGUuYw0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRvb2xzL21lc2gvcmVtb3RlLmgNCj4gDQo=
