Return-Path: <SRS0=6MVD=75=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CF5C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF9F20B1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jun 2020 17:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="CC3efDlt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgFPRNO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:13:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:12982 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729897AbgFPRNM (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jun 2020 13:13:12 -0400
IronPort-SDR: 9IrqyveMgEKNVQ6Oqo5Umu4jx+/F5w3Gy9KY17ujkDXNo99utv2ZUEvNzPrkEAvmFOE/PiL3W4
 yh64HtUjMSYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2020 10:12:53 -0700
IronPort-SDR: mN3ppD17cP3ouFCNVrOJ4Ip+8DGI3yz+EftFKHmIK/pymDOY+2CdmuXs195vAF8GHwkC0SzMbR
 UyAlNAFMGRkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,518,1583222400"; 
   d="scan'208";a="308524362"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga008.jf.intel.com with ESMTP; 16 Jun 2020 10:12:53 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 10:12:53 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX123.amr.corp.intel.com (10.22.240.116) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 10:12:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 16 Jun 2020 10:12:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M1niEjXVgzGgoIOZ8bHyj0EhdiHjOsN5v/zgc5cpTSYNKxwQ6lLgXGR9g+6mxxIiHNKvr/WmOLCVasRMMUciOmxviVbegnPigZbGvU5xYlNdQwf9t7QRuyJyDL2zHONJXPshYjgD+v56G97qQvNKYB17uZigu8wD9WTDeIEkebKNtE8cdaZAoShYi5hfEML77NtWDn4d4W/qh0UsrBLpTkn4a/uxxLlX+dshhP/vt1LU155Eug3uOfWU3pIxn8jo8rnhmC2eDd8XY+c9LQsgh2TTaIFZ/uRvO+1Wr+BqmhjxlQrYWiiZATGrT5eHgsJos3VW9quglOvFz2TmBjNlCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkjQEgD2agDYMionLtKBHzaPhZ4Dh/lmFvj/OO0tNIw=;
 b=F2sd1quS3dGRRLLr9roQC6GGrPLeejFKc4U/FFN22xisqTgnPXSlUc0ndiNh1QVJeKyG6Bwo7p9I+DkBs6BShDxcot2T3nPRuDvGM2DryGnWyONu001IqnNzMB7QBaDm8ceG4JJUwmPANSXD5JWzBFi6caAjqmCRI5PzBU359DWn99lzvqaGv8s8GclMsnrSfKY5r4p9c/hmRy5Ahl4u+vIKSEV6/+eq36GIyQurH972j/+0hRta6NM98I+SOQQPaYtLCrJaQSE0q8r/EKai9ffYB52+k9bY8WX+1Jz/UuH+T0luEzYYO6/2uUiMKrHdKozUgky/RsfW9xYgeW1kCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dkjQEgD2agDYMionLtKBHzaPhZ4Dh/lmFvj/OO0tNIw=;
 b=CC3efDltqhDI8PEfsi0g9YAj5IFHO89joU7/VoZcXZo9ZuJU4W8Np+hfpP/GMB6wsTMWU2ULg7cw26Kj/utQMeIaku14Tih0KGV9mcIlwP+oEFe89v4L5s6Vznw1wN5j0pHRTuVXXEIpxNUo4YgW7b+cQoRvjqiWhhcqM+LH40w=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR1101MB2109.namprd11.prod.outlook.com (2603:10b6:301:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Tue, 16 Jun
 2020 17:12:51 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%6]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 17:12:51 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v3 5/5] mesh: Add "node is busy" check for Leave() &
 Attach()
Thread-Topic: [PATCH BlueZ v3 5/5] mesh: Add "node is busy" check for Leave()
 & Attach()
Thread-Index: AQHWP0o0Jeh0ITVbG0G5y9ap/TqDrqjZXcaAgACAoICAAEtIgIAAH4UAgAE68gA=
Date:   Tue, 16 Jun 2020 17:12:51 +0000
Message-ID: <b90b3ff1af7fe6258d8bfab91ef9bfbe8af0eed0.camel@intel.com>
References: <20200610171121.46910-1-inga.stotland@intel.com>
         <20200610171121.46910-6-inga.stotland@intel.com>
         <20200615082259.bpstucduyunyqvmt@mlowasrzechonek2133>
         <72efc0bd23669143a0c1b9749a6c523f1ea49f5f.camel@intel.com>
         <20200615203247.4zw2vhauuducewws@kynes>
         <8ffbba6a5ce2506fc1a6d5f4d38c9d53c0b119de.camel@intel.com>
In-Reply-To: <8ffbba6a5ce2506fc1a6d5f4d38c9d53c0b119de.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d60f7ec3-75b4-4d63-009b-08d812188082
x-ms-traffictypediagnostic: MWHPR1101MB2109:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB21094EF27F4993A2D7686240E19D0@MWHPR1101MB2109.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1zkzp/qwMzi680xrMdhY51Ht0weS1Y65YQ5ykpj+7/ADUSL7mcFIDH5nyVVL936eMLORoevgUQoyXv32er+JbD0iEm7m/KBZKGcbm9MM3hz+qr60gqutZvABMvlqifFvf9H0LnBQczIEAyzS2FquDJWsosk3ClC8HYoW9XzWQacJRhy9o+2nBoQITPxbrNeoScytwyJ3y5Tc2NWZxY+0qALsbYIrUu9OiwXCGG9ulSllkEoI0aHJVWR1QiZOI9H+UJMns7ie9/XuZqPIwPvop4SNo291WiruG5VffRzgCeRZsaxpYSvPagftlZg8QLocE4PtlzKkcxeMJQnKDvXaIg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(8936002)(5660300002)(186003)(6486002)(8676002)(478600001)(6506007)(86362001)(4326008)(6636002)(2906002)(26005)(6512007)(110136005)(316002)(83380400001)(36756003)(2616005)(66946007)(64756008)(66476007)(66446008)(66556008)(71200400001)(76116006)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: y+MenC9lUbu6ctKWKnP3sa6auzwaB+xwLfy5Sr1EqS7koqnRL5ShBafW0NSoGII3h5Ca/apsTyF9r/t/dlMW8DdG3aMjIF8CcVMjNuxSI5Q0CxZZoFofDB7axeCCBNAge5qpmmezbgntOmWCI030rQTb3mVIRJ5j2lSxkWc6vsgDnas26Ru8XzJgYhAOu4GBHofakblzns7YMiV95giaANfh6ipXSi0A1saEo0fN89SP5fXUdp4yNDUoMZ9AOt6bX2eR2pM2+rXA/zOsbwpdygKdGMOY8Olm7oAr1TMLg2yKt1JbKCDTTY8aRwK90aYA5PxLYuR3A5XfOiuyMCA9UzuERxvter/7PXRZTI+8wYTG8wZGRehTuarrX4Z/3lQwq01UL6mc+Uu5FDEHyYNrLxdoGu2VAKQLJLNwgtaejp0Svgc80BZSWhFTck9Nidz5DWG6JgiZpwoYcQfoQqW6U6TKYWwIuYS4i12ooeIHzh0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C2412E7BDE2D44ABC83B06758EE6B32@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d60f7ec3-75b4-4d63-009b-08d812188082
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 17:12:51.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y02tGI/QQXUHHHYgg+qwStQzozCyI4QOOBImAHfBNfcXi6H0VUf74q1Zdr6suZ3feMFeFnQp77550gCG9u+jWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2109
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQpIaSBNaWNoYcWCLCBJbmdhLA0KDQoNCk9uIE1vbiwgMjAyMC0wNi0xNSBhdCAyMjoyNSArMDAw
MCwgU3RvdGxhbmQsIEluZ2Egd3JvdGU6DQo+IEhpIE1pY2hhbCwNCj4gDQo+IE9uIE1vbiwgMjAy
MC0wNi0xNSBhdCAyMjozMiArMDIwMCwgbWljaGFsLmxvd2FzLXJ6ZWNob25la0BzaWx2YWlyLmNv
bQ0KPiB3cm90ZToNCj4gPiBJbmdhLCBCcmlhbiwNCj4gPiANCj4gPiBPbiAwNi8xNSwgR2l4LCBC
cmlhbiB3cm90ZToNCj4gPiA+ID4gV2l0aCB0aGlzIHBhdGNoLCB0aGlzIGNhbGwgc2VxdWVuY2Ug
ZmFpbHMsIGJlY2F1c2Ugbm93IHdlJ3JlIHN1cHBvc2VkIHRvDQo+ID4gPiA+IHNlbmQgYSAqcmVw
bHkqIHRvIEpvaW5Db21wbGV0ZSBmaXJzdCwgYW5kIG9ubHkgdGhlbiBjYWxsIEF0dGFjaCgpPw0K
PiA+ID4gDQo+ID4gPiBBIGNvdXBsZSBtb250aHMgYWdvLCB3ZSBtYWRlIHRoZSBkZWNpc2lvbiAo
d2l0aCB5b3VyIGlucHV0LCBJIGJlbGlldmUpDQo+ID4gPiB0aGF0IHdlIG5lZWRlZCB0byB1c2Ug
Sm9pbkNvbXBsZXRlIG9uIGV2ZXJ5IG5vZGUgY3JlYXRpb24gKEpvaW4sDQo+ID4gPiBJbXBvcnQs
IENyZWF0ZSksIHRvIGVuc3VyZSB0aGF0IHRoZSBBcHAgaGFzIHRoZSB0b2tlbiAoLi4uKQ0KPiA+
IA0KPiA+IFllcywgSSByZW1lbWJlciB0aGF0IGRpc2N1c3Npb24uIFRoZSByYXRpb25hbGUgd2Fz
IGFiaWxpdHkgdG8gY2F0Y2gNCj4gPiBidWdzIGluIHRoZSBhcHBsaWNhdGlvbiwgYW5kIGdldCBy
aWQgb2YgY3JlYXRlZCwgYnV0IGVmZmVjdGl2ZWx5DQo+ID4gdW51c2FibGUgbm9kZXMuDQo+ID4g
DQo+ID4gPiBUaGlzIGNyZWF0ZXMgKC4uLikgdGhlIHVuZm9ydHVuYXRlIHNpdHVhdGlvbiByZXZl
YWxlZCBpbiBvbmUgb2YgeW91cg0KPiA+ID4gdGVzdC1zdWl0ZSBjYXNlcyB3aGVyZSBpZiBMZWF2
ZSgpIHdhcyBjYWxsZWQgYmVmb3JlIHJldHVybmluZyB0aGUNCj4gPiA+IEpvaW5Db21wbGV0ZSgp
IGNhbGwsIHdlIFNlZy1GYXVsdGVkLg0KPiA+IA0KPiA+IEluZGVlZCwgYWx0aG91Z2ggSSBkb24n
dCB0aGluayBpdCdzIG5lY2Vzc2FyeSB0byBpbnRyb2R1Y2UgYSAiYnVzeSINCj4gPiBzdGF0ZS4u
Lg0KPiA+IA0KPiA+IEluIGNhc2Ugb2YgTGVhdmUoKSwgdGhpcyBjYWxsIHJlbW92ZXMgdGhlIG5v
ZGUgYW55d2F5LCBzbyB3aGF0IEkgdGhpbmsNCj4gPiB3b3VsZCBzdWZmaWNlIGlzIHRvIGNoZWNr
IHdoZXRoZXIgdGhlIG5vZGUgc3RpbGwgZXhpc3RzIHdoZW4NCj4gPiBKb2luQ29tcGxldGUgcmVw
bHkgYXJyaXZlcywgdG8gYXZvaWQgZnJlZWluZyB0aGUgbm9kZSB0d2ljZSAoY2F1c2luZw0KPiA+
IFNFR1YpLg0KPiA+IA0KPiA+IHZvaWQgbm9kZV9maW5hbGl6ZV9uZXdfbm9kZShzdHJ1Y3QgbWVz
aF9ub2RlICpub2RlLCBzdHJ1Y3QgbWVzaF9pbyAqaW8pDQo+ID4gew0KPiA+IAlpZiAoIW5vZGUp
DQo+ID4gCQlyZXR1cm47DQo+ID4gDQo+ID4gCWlmICghbF9xdWV1ZV9maW5kKG5vZGVzLCBtYXRj
aF9zaW1wbGUsIExfVUlOVF9UT19QVFIobm9kZSkpKQ0KPiA+IAkJcmV0dXJuOw0KPiA+IA0KPiAN
Cj4gSSBhbSBhZnJhaWQgdGhhdCB0aGlzIGtpbmQgb2YgY2hlY2sgbWF5IGxlYWQgdG8gYSByYWNl
IGNvbmRpdGlvbiAocmFyZSwgYnV0IHBvc3NpYmxlKSB3aGVuOg0KPiAgLSBhIHVuLWZpbmFsaXpl
ZCBub2RlIGhhcyBiZWVuIHJlbW92ZWQgdmlhIExlYXZlIGFuZA0KPiAgLSB0aGUgZGFlbW9uIHN0
aWxsIHdhaXRpbmcgZm9yIEpvaW5DT21wbGV0ZSgpIHJlcGx5IGFuZA0KPiAgLSBtZWFud2hpbGUg
YW5vdGhlciBvbmUgaGFzIGVpdGhlciBiZWVuIGNyZWF0ZWQgb3IgaW1wb3J0ZWQgcmV1c2luZyB0
aGUgbWVtb3J5IGFsbG9jYXRpb24gKGVudGlyZWx5DQo+IHBvc3NpYmxlKSBhbmQgaGFzIGJlZW4g
YXR0YWNoZWQNCj4gIA0KPiBTbyB3aGVuIHRoZSBvcmlnaW5hbCBKb2luQ29tcGxldGUgcmV0dXJu
cyBlaXRoZXIgdmlhIHRpbWVvdXQvZXJyb3Ivb2ssd2UgbWF5IHVuaW50ZW50aW9uYWxseSByZW1v
dmUgZGJ1cw0KPiByZXNvdXJjZXMgb2YgYSBuZXcgbm9kZSB0aGF0IGhhcyBiZWVuIHZhbGlkYXRl
ZCBhbmQgYXR0YWNoZWQuDQo+IA0KPiANCj4gPiAgICAgLy8gLi4uDQo+ID4gfQ0KPiA+IA0KPiA+
IFRoaXMgd291bGQgYWxsb3cgdGhlIGFwcGxpY2F0aW9uIHRvIGNhbGwgTGVhdmUgKmJlZm9yZSog
c2VuZGluZyBhIHJlcGx5DQo+ID4gdG8gSm9pbkNvbXBsZXRlLg0KPiA+IA0KPiA+IEFzIGZvciBB
dHRhY2goKSwgSSBhbHNvIHRoaW5rIGl0IHNob3VsZCBiZSBsZWdhbCB0byBjYWxsIGl0IGJlZm9y
ZQ0KPiA+IHJlcGx5aW5nIHRvIEpvaW5Db21wbGV0ZS4gVGhlIHdvcnN0IHRoaW5nIHRoYXQgY2Fu
IGhhcHBlbiBpcyB0aGF0DQo+ID4gYXBwbGljYXRpb24gc3VjY2Vzc2Z1bGx5IGF0dGFjaGVzLCB0
aGVuIHJlcGxpZXMgdG8gSm9pbkNvbXBsZXRlIHdpdGggYW4NCj4gPiBlcnJvci4gVGhpcyB3b3Vs
ZCBzaW1wbHkgcmVtb3ZlIHRoZSBub2RlLCBhbmQgdGhlIGFwcGxpY2F0aW9uIHdvdWxkIGJlDQo+
ID4gcHJvbXB0bHkgZGV0YWNoZWQuDQo+ID4gDQo+ID4gDQo+IA0KPiBJIGd1ZXNzIHdlIGNvdWxk
IGludHJvZHVjZSBhbiBpbnRlcm5hbCB0aW1lciBpbnNpZGUgdGhlIGRhZW1vbiB0byBwdXQNCj4g
QXR0YWNoIG9uIGhvbGQgdW50aWwgSm9pbkNvbXBsZXRlIGlzIGRvbmUuIElmIEpvaW5Db21wbGV0
ZSByZXR1cm5zIGFuDQo+IGVycm9yLCB0aGVuIEF0dGFjaCB3b24nciBnbyB0aHJvdWdoIGFuZCB3
b3VsZCByZXR1cm4gZXJyb3IgYXMgd2VsbA0KDQpTbyBJIGhhdmUgY3JlYXRlZCBhIHBhdGNoIHdp
dGggdGhpcyBvcHRpb24sIHRoYXQgSSBoYXZlIHNlbnQgdG8gdGhlIHJlZmxlY3Rvci4NCg0KKFNl
ZTogW1BBVENIIEJsdWVaXSBtZXNoOiBBZGQgZGVmZXJhbCBvZiBBdHRhY2goKSBhbmQgTGVhdmUo
KSBpZiBidXN5ICkNCg0KSXQgbWFpbnRhaW5zIHRoZSAqYnVzeSogY2hlY2sgdG8gbWFrZSBzdXJl
IHdlIGFyZSBpbiBhIHNhZmUgc3RhdGUgdG8gcGVyZm9ybSB0aGUgQXR0YWNoIG9yIExlYXZlLCBh
bmQgaWYgbm90IHdlDQpkZWZlciB0aGUgY2FsbCBmb3IgMSBzZWNvbmQuLi4gIFdpdGggdGhlIHVu
ZGVyc3RhbmRpbmcgdGhhdCAqbm9ib2R5KiBzaG91bGQgYmUgZGVsYXlpbmcgdGhlIHJlc3BvbnNl
IHRvDQpKb2luQ29tcGxldGUuICBUaGlzIGhhbmRsZXMganVzdCB0aGUgc2ltcGxlICJPdXQgT2Yg
RXhwZWN0ZWQgT3JkZXIiIGlzc3VlLCBidXQgd2lsbCBzdGlsbCByZXNwb25kIHRvIEF0dGFjaCBh
bmQNCkxlYXZlIHdpdGggdGhlIEJ1c3kgZXJyb3IgaWYgd2hlbiB3ZSByZWNvbnNpZGVyIHRoZSBj
YWxsLCB0aGUgbm9kZSBoYXMgc3RpbGwgbm90IGJlZW4gY29tcGxldGVkLg0KDQpJIGhhdmUgdGVz
dGVkIHRoaXMgd2l0aCBubyBtZW1vcnkgbGVha3MsIGFuZCB2ZXJpZmllZCB0aGF0IGVpdGhlciBB
dHRhY2ggb3IgTGVhdmUgY2FuIGJlIGNhbGxlZCB3aXRoaW4gdGhlDQpKb2luQ29tcGxldGUgYXBw
bGljYXRpb24gaGFuZGxlci4NCg0KDQo+IA0KPiA+ID4gPiBJJ20gdXNpbmcgYSBoaWdoLWxldmVs
IEFQSSBmb3IgRC1CdXMsIHNvIEkgZG9uJ3QgcmVhbGx5IGNvbnRyb2wgd2hlbiB0aGUNCj4gPiA+
ID4gcmVwbHkgaXMgc2VudCwgc28gYXQgdGhlIG1vbWVudCB0aGUgb25seSB3YXkgdG8gaW1wbGVt
ZW50IHRoaXMgd291bGQgYmUNCj4gPiA+ID4gYnkgZGVsYXlpbmcgQXR0YWNoKCkgYnkgYSBmaXhl
ZCB0aW1lb3V0IC0gYW5kIEknbSBub3QgY29tZm9ydGFibGUgd2l0aA0KPiA+ID4gPiB0aGF0Lg0K
PiA+ID4gDQo+ID4gPiBZZWFoLCBJIGNhbiBzZWUgaG93IHRoaXMgaXMgbm93IHJlcXVpcmVkLi4u
ICANCj4gPiA+IA0KPiA+ID4gSW4gdGhlIG1lc2gtY2ZnY2xpZW50IHRvb2wgKHdoaWNoIGlzIGFs
c28gYnVpbHQgb24gRUxMKSB3ZSBhY2NvbXBsaXNoDQo+ID4gPiB0aGlzIGJ5IHNjaGVkdWxpbmcg
YW4gaWRsZV9vbmVzaG90IGZvciB0aGUgQXR0YWNoLiAgDQo+ID4gDQo+ID4gVW5mb3J0dW5hdGVs
eSwgbm90IGFsbCBtYWluIGxvb3BzIGhhdmUgQVBJIHRvIHNjaGVkdWxlICJpZGxlIiBjYWxscywN
Cj4gPiBpLmUuIGNhbGxzIGV4ZWN1dGVkIHdoZW4gdGhlIGxvb3AgZG9lc24ndCBoYXZlIGFueXRo
aW5nIGJldHRlciB0byBkby4NCj4gPiANCj4gPiBJIGtub3cgdGhhdCBib3RoIEVMTCBhbmQgR2xp
YiBkbywgYnV0IEFGQUlSIFF0IGRvZXMgbm90IChpdCB1c2VzIHRpbWVycw0KPiA+IHdpdGggdGlt
ZW91dCBzZXQgdG8gMCwgaWYgSSdtIG5vdCBtaXN0YWtlbiksIGFuZCBQeXRob24ncyBhc3luY2lv
DQo+ID4gZG9lc24ndCBlaXRoZXIuDQo+ID4gDQo+ID4gSSBkb24ndCB0aGluayByZXF1aXJpbmcg
YSBzcGVjaWZpYyBzZXF1ZW5jZSBvZiBkYnVzIG1lc3NhZ2VzIGlzIGEgZ29vZA0KPiA+IGlkZWEg
OigNCj4gPiANCj4gPiByZWdhcmRzDQo=
