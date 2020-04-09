Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61788C2D0EA
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 06:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16ACA2072F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 06:23:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="rpYYi4vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgDIGXi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 02:23:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:11775 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgDIGXi (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 02:23:38 -0400
IronPort-SDR: B96il+Beq1AmChkXdbvGWLTQdRbi3WNZfIK7T7zZMuVqDHszVo+TPcKHkc/oPEARlUFE7PqdXI
 90cRV0n51KEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 23:23:38 -0700
IronPort-SDR: FTpdDE2WOTOSOtiDVM5YJXuywT9fxqsgQn/MwJB+y/jMHcfcU5q9vt8flUXFmv8M61UQ9nXaPP
 +6ldenwrhxaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,361,1580803200"; 
   d="scan'208";a="425401657"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2020 23:23:38 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 23:23:38 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 23:23:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 8 Apr 2020 23:23:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwkomkybEutEokMWvjSl1j6JQUP8O5AwZ4DTK8kDbN0Ky5qXZf0QDoIcz0eQ4vxkYCY6sPHKAbwKmvPBzC0RYyic51xutZB6Fb3fOPdXGAcykydjKL4ZX+6Glmhhjko8qd7oNlNoFKI0qIHW2bX5JBk356aud64T86n4MS5seSEK8P6rWnm5ayt6mqylMK1KzgNfcSPSge7jWnquXornZdEuZ/3FoqO0aqdAtpDKfUeX3PPdf5OOr3T4f3UasP2q2WvbtXQm03/97IguMVuqX2a2GnBu87o+q4xswLg/DNWt8qDlRcnQbJfIk6/W6pf8xe1W8UdpRdxycXBRuaDppA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLgFELP7lj8qg+jxgThtoDSRBKaTVLoTysJ+t2hHmUs=;
 b=VvLojrnhI37pnTAqzpyF93RESgdhdDY+JAmAOhpfmzTOsfUWMcvhRqPXEbG2S/66FLtDslUEJMBZV/r8dsxdtxUK+RQJshfDI93TgblbzojUJXg9CK0tgt6N8RkYaWD0ECnkqvYgyXYWhXg5kUATzt1agUygKr2Ujn2Jf2YR0fjz+Pz2Mj2IxDQwm3dG0zcGN+E6poLoqytn8sj7x3e6qgF/yAmnNsq8VAKf5mYDuq9ShhyYxI7yPD45t35DspGpsmBdfuENDUQ5Sa9RaI+e9/WMJpN0t0U2Y5ELN4276iLOwT98fRaXJjKU7R8WirNda5jfWIsFtqKeQljBGbNoCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pLgFELP7lj8qg+jxgThtoDSRBKaTVLoTysJ+t2hHmUs=;
 b=rpYYi4vyf95iHJqyO/9yKccJrHJcqHqxjifMFdNXrncN1aiC8WPXd1ISG2ODb4k79gwPhoPDCdwqv2fCLuYVOyxcWNl+UJIFrXt5Rxmn9inLh9Lb9o/ASzd6dufGMLto77/x5RkS3rVGWEk192WPLFTaV9HLjgWWkvGrFwABHLE=
Received: from MWHPR11MB1423.namprd11.prod.outlook.com (2603:10b6:300:22::14)
 by MWHPR11MB1421.namprd11.prod.outlook.com (2603:10b6:300:24::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 9 Apr
 2020 06:23:36 +0000
Received: from MWHPR11MB1423.namprd11.prod.outlook.com
 ([fe80::d0f6:281b:de0a:36d1]) by MWHPR11MB1423.namprd11.prod.outlook.com
 ([fe80::d0f6:281b:de0a:36d1%5]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 06:23:36 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "przemyslaw.fierek@silvair.com" <przemyslaw.fierek@silvair.com>
CC:     "Gix, Brian" <brian.gix@intel.com>,
        "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 4/4] tools/mesh-cfgclient: Add waiting for
 'JoinComplete'
Thread-Topic: [PATCH BlueZ 4/4] tools/mesh-cfgclient: Add waiting for
 'JoinComplete'
Thread-Index: AQHWDefPD0H45yOpq0iSP0LnaMpkaKhwUvyA
Date:   Thu, 9 Apr 2020 06:23:36 +0000
Message-ID: <ccad40a9f394bfa76ed0c5daa4575784b663f018.camel@intel.com>
References: <20200408205255.45112-1-michal.lowas-rzechonek@silvair.com>
         <20200408205255.45112-5-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200408205255.45112-5-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bab32926-c8a5-4834-f9e2-08d7dc4e8941
x-ms-traffictypediagnostic: MWHPR11MB1421:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1421F4115700D55B3F856169FBC10@MWHPR11MB1421.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:590;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(366004)(396003)(136003)(376002)(346002)(81156014)(2616005)(6916009)(8676002)(316002)(8936002)(6512007)(36756003)(478600001)(86362001)(81166007)(6506007)(6486002)(2906002)(4326008)(26005)(66476007)(66556008)(66946007)(66446008)(71200400001)(186003)(64756008)(76116006)(91956017)(5660300002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FU/B9GNuNqIxLBG/eYYWCXkOhJjYzPOX0e5kAIc/vNSHTMtmwghyQAEbXgQyRAUj6wXUoRsZ3FapIQFlvuVYHPRnz+trrcTfRQD8PwzkhBDMDoPy9QS9panxZBv01UoEpZ+UAC2zH4FbOXotdPd7B6ZkxjEWCXF2fM1qLQu7rOg0oZzQUMkoDrmJF1QyaWNKjFbPpNTjIt+vwK3UWpEWEWr9ooH8dtPb+WNl5xgTRjdROJsuo+Vcc0IqGdutrnqvexs9SFveCGI8YCRIbGflMJZuXF487Sv0IIF6EyIly+HPgFcONI1VxjbmdMlRAjzmYsmJcfPdNm8ArZCdm2tlFr9Sa4m/xTGQNZBOswIqs+/9jVK9rdqNjY8e0WKtWFub7iAsWPPEeNlL1bDJ6pR/98ZIngcJrwtzC/Pj3TRnl4nudS//YIOgcAY992NW7yFk
x-ms-exchange-antispam-messagedata: XL9lxRo92FVxDDyFF49nqh0Ny8YN4zgGvKbUAQ9FdBDrI8sIdhpldp59Gdma4tO7zv8iLtwYm8T/5okHLIBfGRgiWh+BMHXFH/3ACw2jNC2Ziz4LJMgZsX+c5V7347ZsT03qJOUO3hODGF9iZCFL/A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <F95FCB3BB68DAD42A753C7B334C18AB2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bab32926-c8a5-4834-f9e2-08d7dc4e8941
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 06:23:36.3387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVeWzh4R7jp/AVFoQC0OGv0T8TvfT4kzVa/hcsSc7t/xujXrm7W+T/l+qTB3WPDqbBSNGgXXITdt8NkG0v6Kkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1421
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgRmllcmVrLA0KDQpPbiBXZWQsIDIwMjAtMDQtMDggYXQgMjI6NTIgKzAyMDAsIE1pY2hhxYIg
TG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBGcm9tOiBQcnplbXlzxYJhdyBGaWVyZWsgPA0KPiBw
cnplbXlzbGF3LmZpZXJla0BzaWx2YWlyLmNvbQ0KPiA+DQo+IA0KPiAtLS0NCj4gIHRvb2xzL21l
c2gtY2ZnY2xpZW50LmMgfCA3MyArKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
LQ0KPiAtLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMzIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbWVzaC1jZmdjbGllbnQuYyBiL3Rvb2xz
L21lc2gtY2ZnY2xpZW50LmMNCj4gaW5kZXggNWIwMThlYjRhLi5jNWI2OTM4ZWQgMTAwNjQ0DQo+
IC0tLSBhL3Rvb2xzL21lc2gtY2ZnY2xpZW50LmMNCj4gKysrIGIvdG9vbHMvbWVzaC1jZmdjbGll
bnQuYw0KPiBAQCAtNzA3LDQ0ICs3MDcsMTMgQEAgc3RhdGljIHZvaWQgYXR0YWNoX25vZGVfc2V0
dXAoc3RydWN0DQo+IGxfZGJ1c19tZXNzYWdlICptc2csIHZvaWQgKnVzZXJfZGF0YSkNCj4gIHN0
YXRpYyB2b2lkIGNyZWF0ZV9uZXRfcmVwbHkoc3RydWN0IGxfZGJ1c19wcm94eSAqcHJveHksDQo+
ICAJCQkJc3RydWN0IGxfZGJ1c19tZXNzYWdlICptc2csIHZvaWQNCj4gKnVzZXJfZGF0YSkNCj4g
IHsNCj4gLQljaGFyICpzdHI7DQo+IC0JdWludDY0X3QgdG1wOw0KPiAtDQo+ICAJaWYgKGxfZGJ1
c19tZXNzYWdlX2lzX2Vycm9yKG1zZykpIHsNCj4gIAkJY29uc3QgY2hhciAqbmFtZTsNCj4gIA0K
PiAgCQlsX2RidXNfbWVzc2FnZV9nZXRfZXJyb3IobXNnLCAmbmFtZSwgTlVMTCk7DQo+ICAJCWxf
ZXJyb3IoIkZhaWxlZCB0byBjcmVhdGUgbmV0d29yazogJXMiLCBuYW1lKTsNCj4gIAkJcmV0dXJu
Ow0KPiAtDQo+IC0JfQ0KPiAtDQo+IC0JaWYgKCFsX2RidXNfbWVzc2FnZV9nZXRfYXJndW1lbnRz
KG1zZywgInQiLCAmdG1wKSkNCj4gLQkJcmV0dXJuOw0KPiAtDQo+IC0JbG9jYWwgPSBsX25ldyhz
dHJ1Y3QgbWVzaGNmZ19ub2RlLCAxKTsNCj4gLQlsb2NhbC0+dG9rZW4udTY0ID0gbF9nZXRfYmU2
NCgmdG1wKTsNCj4gLQlzdHIgPSBsX3V0aWxfaGV4c3RyaW5nKCZsb2NhbC0+dG9rZW4udThbMF0s
IDgpOw0KPiAtCWJ0X3NoZWxsX3ByaW50ZigiQ3JlYXRlZCBuZXcgbm9kZSB3aXRoIHRva2VuICVz
XG4iLCBzdHIpOw0KPiAtCWxfZnJlZShzdHIpOw0KPiAtDQo+IC0JaWYgKCFtZXNoX2RiX2NyZWF0
ZShjZmdfZm5hbWUsIGxvY2FsLT50b2tlbi51OCwNCj4gLQkJCQkJCSJNZXNoIENvbmZpZyBDbGll
bnQNCj4gTmV0d29yayIpKSB7DQo+IC0JCWxfZnJlZShsb2NhbCk7DQo+IC0JCWxvY2FsID0gTlVM
TDsNCj4gLQkJcmV0dXJuOw0KPiAgCX0NCj4gLQ0KPiAtCW1lc2hfZGJfc2V0X2FkZHJfcmFuZ2Uo
bG93X2FkZHIsIGhpZ2hfYWRkcik7DQo+IC0Ja2V5c19hZGRfbmV0X2tleShQUklNQVJZX05FVF9J
RFgpOw0KPiAtCW1lc2hfZGJfbmV0X2tleV9hZGQoUFJJTUFSWV9ORVRfSURYKTsNCj4gLQ0KPiAt
CXJlbW90ZV9hZGRfbm9kZShhcHAudXVpZCwgMHgwMDAxLCAxLCBQUklNQVJZX05FVF9JRFgpOw0K
PiAtCW1lc2hfZGJfYWRkX25vZGUoYXBwLnV1aWQsIDB4MDAwMSwgMSwgUFJJTUFSWV9ORVRfSURY
KTsNCj4gLQ0KPiAtCWxfZGJ1c19wcm94eV9tZXRob2RfY2FsbChuZXRfcHJveHksICJBdHRhY2gi
LA0KPiBhdHRhY2hfbm9kZV9zZXR1cCwNCj4gLQkJCQkJCWF0dGFjaF9ub2RlX3JlcGx5LA0KPiBO
VUxMLA0KPiAtCQkJCQkJTlVMTCk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIGNyZWF0ZV9u
ZXRfc2V0dXAoc3RydWN0IGxfZGJ1c19tZXNzYWdlICptc2csIHZvaWQNCj4gKnVzZXJfZGF0YSkN
Cj4gQEAgLTE3MjcsNyArMTY5Niw3IEBAIHN0YXRpYyBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UNCj4g
KmFkZF9ub2RlX2ZhaWxfY2FsbChzdHJ1Y3QgbF9kYnVzICpkYnVzLA0KPiAgc3RhdGljIHZvaWQg
c2V0dXBfcHJvdl9pZmFjZShzdHJ1Y3QgbF9kYnVzX2ludGVyZmFjZSAqaWZhY2UpDQo+ICB7DQo+
ICAJbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJTY2FuUmVzdWx0IiwgMCwNCj4gc2Nh
bl9yZXN1bHRfY2FsbCwgIiIsDQo+IC0JCQkJCQkibmF5YXtzdn0iLCAicnNzaSIsDQo+ICJkYXRh
IiwgIm9wdGlvbnMiKTsNCj4gKwkJCQkJIm5heWF7c3Z9IiwgInJzc2kiLCAiZGF0YSIsDQo+ICJv
cHRpb25zIik7DQo+ICANCj4gIAlsX2RidXNfaW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIlJlcXVl
c3RQcm92RGF0YSIsIDAsDQo+IHJlcV9wcm92X2NhbGwsDQo+ICAJCQkJInFxIiwgInkiLCAibmV0
X2luZGV4IiwgInVuaWNhc3QiLA0KPiAiY291bnQiKTsNCj4gQEAgLTE3NzksNiArMTc0OCw0MyBA
QCBzdGF0aWMgYm9vbCBjcnBsX2dldHRlcihzdHJ1Y3QgbF9kYnVzICpkYnVzLA0KPiAgCXJldHVy
biB0cnVlOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgc3RydWN0IGxfZGJ1c19tZXNzYWdlICpqb2lu
X2NvbXBsZXRlKHN0cnVjdCBsX2RidXMgKmRidXMsDQo+ICsJCQkJCQlzdHJ1Y3QgbF9kYnVzX21l
c3NhZ2UNCj4gKm1lc3NhZ2UsDQo+ICsJCQkJCQl2b2lkICp1c2VyX2RhdGEpDQo+ICt7DQo+ICsJ
Y2hhciAqc3RyOw0KPiArCXVpbnQ2NF90IHRtcDsNCj4gKw0KPiArCWlmICghbF9kYnVzX21lc3Nh
Z2VfZ2V0X2FyZ3VtZW50cyhtZXNzYWdlLCAidCIsICZ0bXApKQ0KPiArCQlyZXR1cm4gbF9kYnVz
X21lc3NhZ2VfbmV3X2Vycm9yKG1lc3NhZ2UsIGRidXNfZXJyX2FyZ3MsDQo+IE5VTEwpOw0KPiAr
DQo+ICsJbG9jYWwgPSBsX25ldyhzdHJ1Y3QgbWVzaGNmZ19ub2RlLCAxKTsNCj4gKwlsb2NhbC0+
dG9rZW4udTY0ID0gbF9nZXRfYmU2NCgmdG1wKTsNCj4gKwlzdHIgPSBsX3V0aWxfaGV4c3RyaW5n
KCZsb2NhbC0+dG9rZW4udThbMF0sIDgpOw0KPiArCWJ0X3NoZWxsX3ByaW50ZigiQ3JlYXRlZCBu
ZXcgbm9kZSB3aXRoIHRva2VuICVzXG4iLCBzdHIpOw0KPiArCWxfZnJlZShzdHIpOw0KPiArDQo+
ICsJaWYgKCFtZXNoX2RiX2NyZWF0ZShjZmdfZm5hbWUsIGxvY2FsLT50b2tlbi51OCwNCj4gKwkJ
CQkJIk1lc2ggQ29uZmlnIENsaWVudCBOZXR3b3JrIikpDQo+IHsNCj4gKwkJbF9mcmVlKGxvY2Fs
KTsNCj4gKwkJbG9jYWwgPSBOVUxMOw0KPiArCQlyZXR1cm4gbF9kYnVzX21lc3NhZ2VfbmV3X2Vy
cm9yKG1lc3NhZ2UsIGRidXNfZXJyX2ZhaWwsDQo+IE5VTEwpOw0KPiArCX0NCj4gKw0KPiArCW1l
c2hfZGJfc2V0X2FkZHJfcmFuZ2UobG93X2FkZHIsIGhpZ2hfYWRkcik7DQo+ICsJa2V5c19hZGRf
bmV0X2tleShQUklNQVJZX05FVF9JRFgpOw0KPiArCW1lc2hfZGJfbmV0X2tleV9hZGQoUFJJTUFS
WV9ORVRfSURYKTsNCj4gKw0KPiArCXJlbW90ZV9hZGRfbm9kZShhcHAudXVpZCwgMHgwMDAxLCAx
LCBQUklNQVJZX05FVF9JRFgpOw0KPiArCW1lc2hfZGJfYWRkX25vZGUoYXBwLnV1aWQsIDB4MDAw
MSwgMSwgUFJJTUFSWV9ORVRfSURYKTsNCj4gKw0KPiArCWxfZGJ1c19wcm94eV9tZXRob2RfY2Fs
bChuZXRfcHJveHksICJBdHRhY2giLA0KPiBhdHRhY2hfbm9kZV9zZXR1cCwNCj4gKwkJCQkJCWF0
dGFjaF9ub2RlX3JlcGx5LA0KPiBOVUxMLA0KPiArCQkJCQkJTlVMTCk7DQoNCkkgZG9uJ3QgdGhp
bmsgaXQncyBhIGdvb2QgaWRlYSB0byBjYWxsIEF0dGFjaCgpIGJlZm9yZSBzZW5kaW5nIGENCnN1
Y2Nlc3NmdWwgcmVwbHkgdG8gSm9pbkNvbXBsZXRlLiBPbmUgd2F5IG9mIGRlYWxpbmcgd2l0aCB0
aGlzICh0bw0KYXZvaWQgY3JlYXRpbmcgYSBzZXBhcmF0ZSBtZW51IGNvbW1hbmQgZm9yIGF0dGFj
aGluZykgd291bGQgYmUgdG8gd3JhcA0KQXR0YWNoIGluIGxfaWRsZV9vbmVzaG90KCkgDQoNCj4g
Kw0KPiArCXJldHVybiBsX2RidXNfbWVzc2FnZV9uZXdfbWV0aG9kX3JldHVybihtZXNzYWdlKTsN
Cj4gK30NCj4gKw0KPiAgc3RhdGljIHZvaWQgc2V0dXBfYXBwX2lmYWNlKHN0cnVjdCBsX2RidXNf
aW50ZXJmYWNlICppZmFjZSkNCj4gIHsNCj4gIAlsX2RidXNfaW50ZXJmYWNlX3Byb3BlcnR5KGlm
YWNlLCAiQ29tcGFueUlEIiwgMCwgInEiLA0KPiBjaWRfZ2V0dGVyLA0KPiBAQCAtMTc4OSw2ICsx
Nzk1LDkgQEAgc3RhdGljIHZvaWQgc2V0dXBfYXBwX2lmYWNlKHN0cnVjdA0KPiBsX2RidXNfaW50
ZXJmYWNlICppZmFjZSkNCj4gIAkJCQkJCQkJCQ0KPiBOVUxMKTsNCj4gIAlsX2RidXNfaW50ZXJm
YWNlX3Byb3BlcnR5KGlmYWNlLCAiQ1JQTCIsIDAsICJxIiwgY3JwbF9nZXR0ZXIsDQo+IE5VTEwp
Ow0KPiAgDQo+ICsJbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJKb2luQ29tcGxldGUi
LCAwLA0KPiBqb2luX2NvbXBsZXRlLA0KPiArCQkJCQkJCSIiLCAidCIsDQo+ICJ0b2tlbiIpOw0K
PiArDQo+ICAJLyogVE9ETzogTWV0aG9kcyAqLw0KPiAgfQ0KDQpSZWdhcmRzLA0KSW5nYQ0K
