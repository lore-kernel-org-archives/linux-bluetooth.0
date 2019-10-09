Return-Path: <SRS0=7chU=YC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BED1C47404
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 16:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64AF218AC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Oct 2019 16:01:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Lxcq/P19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbfJIQBW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:01:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:24934 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730708AbfJIQBW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Oct 2019 12:01:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Oct 2019 09:01:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,276,1566889200"; 
   d="scan'208";a="184105132"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga007.jf.intel.com with ESMTP; 09 Oct 2019 09:01:21 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 9 Oct 2019 09:01:21 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 9 Oct 2019 09:01:20 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.55) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 9 Oct 2019 09:01:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMxM7dncF8r16RrtpNCGH9njJIg8gnu/PSfW1BN5urZCo3qHkUck/xc7YJNr7/h2GFf1sw04od5qzsro+5/PxL6bTNJ7lR8dX0tiPWBCpO6beygIVb6AmXN/oyEA5HPI9ytvdO5ZZ+HfCmk9eYIE2+saBdhpOW0hUw0lSuKyGEW3mkq2pkMU8Z6R+rdsXvFNJgdz3BbOwFm0t8pxkGQb7d1N+F3q9R9UslZqT++m162KtRdZKKC0wQ8V2RfXXxa5+1gkB17fOkybn0U+UTGU4YbOzFp405gyb+oZi/ceupZZY/uP9qV4l0CZTlvBLyzgVaao58bkFuu7AYDUpq1yxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OTBBUSHOQhM7y6cS9BmQmELacptX6nCM9Pl4qY4mnY=;
 b=aRgoqfjcF6qSiIfnedhxuJej1TEzbN0z4fjA/D905AF3+jXzTaaY1wUjrxmH6nKJFZSosdoa78XfVSmGrEKLk1vhHej8hU4EyuMDMmSJBzAyh1BWe/Tu9oRhpAxrt3AFJJsbVBxuItbxG8btoXuMowp1By50Xhv9XrrR3BQ37F6W/3U5/rfVxVXDZXSVDznhlScWr5HOzFyqzgQXAchlLy0kmYAzD6otCB0n0xI3PjLAJo0pDUej/QlxgV1CxR79c+oZBp7b6+WseloRKn9XVpRHhfY9OTxZWNXA2wO3/kgbC7Y74MgybX4hzTHqUGNpxA14IK/pRUMIm9T85iS28A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OTBBUSHOQhM7y6cS9BmQmELacptX6nCM9Pl4qY4mnY=;
 b=Lxcq/P19tSkEN7QVXOWbHp0fWlUWGcp/npd6F5DIApK+qSHIkf1ZQNg3aJ2fhC5rfE3I4+B9ven8rGYJhAvtHnLVl6rnF2WSbeZZGnUhzlMKiOyIV4/m3eOUe5l/eqsxnWzHvfXwWH6PlBc3JKGCP3/h89JxSZupCu+o4bQuzCc=
Received: from DM6PR11MB4412.namprd11.prod.outlook.com (52.132.248.86) by
 DM6PR11MB2874.namprd11.prod.outlook.com (20.176.100.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.25; Wed, 9 Oct 2019 16:01:05 +0000
Received: from DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::256c:4683:ec9f:6a19]) by DM6PR11MB4412.namprd11.prod.outlook.com
 ([fe80::256c:4683:ec9f:6a19%5]) with mapi id 15.20.2347.016; Wed, 9 Oct 2019
 16:01:05 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] unit: Add Mesh Crypto tests from Mesh Profile
 Spec
Thread-Topic: [PATCH BlueZ v2] unit: Add Mesh Crypto tests from Mesh Profile
 Spec
Thread-Index: AQHVeitnvuZ0M/6ZWESMbo6b5FGjo6dMOyMAgAY0uQCAABFOAA==
Date:   Wed, 9 Oct 2019 16:01:05 +0000
Message-ID: <eccd2dff7fa5e04605a3b0302315060f99c80e53.camel@intel.com>
References: <20191003204405.27285-1-brian.gix@intel.com>
         <e9d186c8d89be278252ddfe3982602be984f3c14.camel@intel.com>
         <CABBYNZJ1L6ZaMe-Vf97jc=NxBEHwAs4gOGMQX_THJ-++w7Rnvg@mail.gmail.com>
In-Reply-To: <CABBYNZJ1L6ZaMe-Vf97jc=NxBEHwAs4gOGMQX_THJ-++w7Rnvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa551b3f-b12e-4c4c-5018-08d74cd1e434
x-ms-traffictypediagnostic: DM6PR11MB2874:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2874D481FDAF14B475E82FFCE1950@DM6PR11MB2874.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 018577E36E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39850400004)(136003)(346002)(376002)(189003)(199004)(8936002)(66556008)(2906002)(6512007)(66946007)(86362001)(107886003)(14454004)(66446008)(71190400001)(71200400001)(6246003)(118296001)(36756003)(1361003)(76116006)(64756008)(316002)(8676002)(256004)(99286004)(7736002)(3846002)(6116002)(4326008)(91956017)(305945005)(66476007)(66066001)(2501003)(25786009)(11346002)(6486002)(186003)(486006)(478600001)(6436002)(6506007)(102836004)(2616005)(476003)(26005)(2351001)(446003)(76176011)(81156014)(81166006)(5660300002)(54906003)(6916009)(5640700003)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB2874;H:DM6PR11MB4412.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/CYVAZvQ2lwws77L6x64VjXASqMNKHeHZN6a0sbdtGGuWU5RR26I/A5B29vZd6vQPyOi5/gG48VasGFtKl/6V0T8pWclxjv35cvbqdehRx/9+g1xUmidX8DIOcIQeVOllXCJ54HgM86RDmblPWHQN7RcLU1s8HIoY+E/K/Qrw/vi9ZgPaiXwpIjbd2h2lW6bdLxn5DCl4+6fOzfNLxzlla9HTFlcP4CZFqHYqSUsxLKJAviesLsZ/rKxVeWC7AJ4cGp8KcRpFfyBJ96+j8FtRQ2rfPYT7nP71v4QNzB1f03+lbiOoI0See5Zf01ZP1UXxIGamK9IpXVWaVXw7Mi4NRl15VKGR772Gzs45g8kDdUu/Q3iG3mgBpVOMSppN9x8wN6KQlY+ha5J4Suc5o6ByCZIPrB90IHirlhoEWhWrM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E83278C808557C4C9C70DCC9A148AFDA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fa551b3f-b12e-4c4c-5018-08d74cd1e434
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2019 16:01:05.6224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+6c1v2/vfiwKPDiVBzQYCryGG0drLUZ4gEO7DGnLz9iwGCUHpIzn54nB0w4J1KA+ZjZLPpCgtLBJcGz8X6spw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2874
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KT24gV2VkLCAyMDE5LTEwLTA5IGF0IDE3OjU5ICswMzAwLCBMdWl6IEF1Z3Vz
dG8gdm9uIERlbnR6IHdyb3RlOg0KPiBPbiBUaHUsIDIwMTktMTAtMDMgYXQgMTM6NDQgLTA3MDAs
IEJyaWFuIEdpeCB3cm90ZToNCj4gPiA+IFRoaXMgdW5pdCB0ZXN0IHdpbGwgYmUgZ3Jvd24gb3Zl
ciB0aW1lIHRvIGluY2x1ZGUgdGVzdHMgZm9ybWVkIGZyb20gdGhlDQo+ID4gPiBzYW1wbGUgZGF0
YSBpbiB0aGUgQmx1ZXRvb3RoIE1lc2ggUHJvZmlsZSBzcGVjaWZpY2F0aW9uIChDdXJyZW50bHkg
YXQNCj4gPiA+IHZlcnNpb24gdjEuMC4xKS4NCj4gPiA+IA0KPiA+ID4gQ3VycmVudGx5IGl0IGlu
Y2x1ZGVzIHRlc3QgY2FzZXMgZm9yIHRoZSBmb2xsb3dpbmcgc2V0cyBvZiBzYW1wbGUgZGF0YToN
Cj4gPiA+IFNlY3Rpb25zIDguMS4xLTYNCj4gPiA+IFNlY3Rpb25zIDguMi4xLTYNCj4gPiA+IFNl
Y3Rpb25zIDguMy4xLTExDQo+ID4gPiBTZWN0aW9uIDguNC4zDQo+ID4gPiBTZWN0aW9uIDguNi4y
DQo+ID4gPiAtLS0NCj4gPiA+ICBNYWtlZmlsZS5hbSAgICAgICAgICAgICB8ICAgMTAgKw0KPiA+
ID4gIHVuaXQvdGVzdC1tZXNoLWNyeXB0by5jIHwgMjAwMCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDIwMTAgaW5zZXJ0aW9u
cygrKQ0KPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCB1bml0L3Rlc3QtbWVzaC1jcnlwdG8uYw0K
PiA+ID4gDQo+IA0KPiBtYWtlIHRlc3QgaXMgZmFpbGluZyBvbiB0aGlzIG9uZToNCg0KV2hhdCBw
bGF0Zm9ybS9jb21tYW5kIGxpbmUgYXJlIHlvdSBnZXR0aW5nIHRvIHNlZSB0aGlzPyAgb3IgYXJl
IHlvdSBydW5uaW5nIGl0IHVuZGVyIGEgc3RhdGljIGFuYWx5c2lzIHRvb2wgb2YNCnNvbWUgc29y
dD8NCg0KSSBhbSBnZXR0aW5nIG5vIGVycm9ycyBvbiBGMzAsIGJpdGggMzIgYW5kIDY0IGJpdC4u
Lg0KDQpCdXQgSSB3aWxsIGNoZWNrIG91dCB0aGUgY2hlY2tfaWRfYmVhY29uKCkgZnVuY3Rpb24u
Li4NCg0KPiANCj4gPT0yNTU1OT09IDggYnl0ZXMgaW4gMSBibG9ja3MgYXJlIGRlZmluaXRlbHkg
bG9zdCBpbiBsb3NzIHJlY29yZCAxIG9mIDQNCj4gPT0yNTU1OT09ICAgIGF0IDB4NDgzODgwQjog
bWFsbG9jICh2Z19yZXBsYWNlX21hbGxvYy5jOjMwOSkNCj4gPT0yNTU1OT09ICAgIGJ5IDB4MTFG
QjI1OiBsX21hbGxvYyAodXRpbC5jOjYyKQ0KPiA9PTI1NTU5PT0gICAgYnkgMHgxMjAyMzI6IGxf
dXRpbF9mcm9tX2hleHN0cmluZyAodXRpbC5jOjQyNykNCj4gPT0yNTU1OT09ICAgIGJ5IDB4MTE4
MDY5OiBjaGVja19pZF9iZWFjb24gKHRlc3QtbWVzaC1jcnlwdG8uYzoxNzA5KQ0KPiA9PTI1NTU5
PT0gICAgYnkgMHgxMTgwNjk6IG1haW4gKHRlc3QtbWVzaC1jcnlwdG8uYzoxOTk3KQ0KPiANCj4g
QnR3IHVzdWFsbHkgdGhlIHRlc3QgYXJlIHVzaW5nIHRoZSB0ZXN0ZXIgZnJhbWV3b3JrIGFuZCBp
dCBzaG91bGQgYmUNCj4gcG9zc2libGUgdG8gaW50ZWdyYXRlIHdpdGggdGhhdCBidXQgdGhhdCBw
cm9iYWJseSBuZWVkIHNvbWUgd29yayB0bw0KPiBtYWtlIHlvdSBhYmxlIHRvIHJ1biB3aXRoIGVs
bCBtYWlubG9vcC4NCj4gDQo+IA0KPiANCj4gDQo+IC0tDQo+IEx1aXogQXVndXN0byB2b24gRGVu
dHoNCg==
