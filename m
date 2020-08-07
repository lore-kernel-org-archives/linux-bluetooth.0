Return-Path: <SRS0=11Tl=BR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE96EC433DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 14:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C20221E2
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Aug 2020 14:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="apo5YAKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgHGOiV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Aug 2020 10:38:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:2918 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgHGOiT (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Aug 2020 10:38:19 -0400
IronPort-SDR: JBKB/iKG94dz3Q6iSwUEZpGz7SBsYt8uEAuSYMZSq9xks7EIXgHSc6nkHptN/BbA77HHyTWJVy
 /nFuHZY/T6Ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="140970079"
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800"; 
   d="scan'208";a="140970079"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 07:38:17 -0700
IronPort-SDR: 2VCzMbhwvmdynh76gLo3uoxmRhCgL10N9hJRkGSSlHbUw1vpgxwrxV9CNPV0SoGOIynhJ8yJRm
 3EH0BNao0BvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,446,1589266800"; 
   d="scan'208";a="316555900"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 07 Aug 2020 07:38:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 7 Aug 2020 07:38:16 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 7 Aug 2020 07:38:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 7 Aug 2020 07:38:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCvEgCh72LtOGPlNcY30CXKp10p3WjYgKPit1X0j4LqXgIKtCaO4QWmbDy7lVBiGeTSzLnS1d4QiDIaQ+LmGgUjz+9jhnubSpgSkqDMpANkIYucamXx32fijOiNZ0vpcyLn99DnbhN9toKaefuy63AlyCz92ztlSOZdUWngmBUAJe9vxcc1ib13DAdHPatfhLbAX1GZrCxd4XqPQPOiw+p2RP2tMRxiWYL308c7jfQIRjBWFYR/af80NkKlm4stWpxXFYcAsrkPLNKDbauN00E0zN3pFRWFiPpJANJ95ckc6CSyUK/Z1Sbrwh+ddHqaJHDZo+4hcjLAkahkB9M0wuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqvkrfHdYsfZQSezKp9/0eIQaxEIX9aNAXTsKYZSSSg=;
 b=fzEAuX023MBXpL5rZ71mtBWdXTtxaV8Meqz1smzNwL2urE6IQegJD2tXTGS/9U5ZpgOWdHLPAkLz2KAaWbdF0yNnviFf0JlYm0WbOa9ZD3E4Db2ck0lIkeKaIFQ6BSRaSS3tnlI/oK4fhG7/qCzA+zytI/PnzW0WtLsUOACF6y1Vx8ddUOXVY75hoHJrxSlHHUdundvuA4TRG14PCt3O6rasmGLXq+yA0pixVS3Ij4PSA/pNDwyDFGpZI/5Z/HbITOYqY4QplJJzDI1nIk3Eh4JG1BPEcp77/6B+cZu0c+9UmibqDrNp68mIphFGQk4nNO54eKpNqXPjRfHl6jFRMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqvkrfHdYsfZQSezKp9/0eIQaxEIX9aNAXTsKYZSSSg=;
 b=apo5YAKKVTWVrJWDPq49fjo5/Q4W0QuuqfqjEEKJzgmIPg95ckJSunnCfzv519KuXEzNVSfTyHAbRLWz9r9gxRpcBRD1w9+I5H5HRKFYbgnhzGs2OKobVkDs4IXJVxJJAGSPX9SODP5EzdbLVXofmpLI/E9tB3iZB51n1Ua0OgQ=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1904.namprd11.prod.outlook.com (2603:10b6:300:111::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Fri, 7 Aug
 2020 14:38:13 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 14:38:13 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Use correct TTL value to send model
 publication
Thread-Topic: [PATCH BlueZ] mesh: Use correct TTL value to send model
 publication
Thread-Index: AQHWbESudHCYPsSHdkuCloOt6dEuzaksuDcA
Date:   Fri, 7 Aug 2020 14:38:13 +0000
Message-ID: <c4626c74a850df528c073e981000dbe5e9c13f1d.camel@intel.com>
References: <20200806225523.109092-1-inga.stotland@intel.com>
In-Reply-To: <20200806225523.109092-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7dc60e5-0bbe-4d0f-202d-08d83adf83b5
x-ms-traffictypediagnostic: MWHPR11MB1904:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB190473083F13D8CA3D788EBFE1490@MWHPR11MB1904.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6RnIceUjBxKctpeiM7U9m5IGk8kRABSZghFt3BbLInUH+YuRJ3poDCFHL+WAZ0R3vjos5PDJRZOgG0chlwIIkiKZsR6SPpWmpAGzNpqr82iamS0PtEc9NN+qW0DP5m/X8bOMTeKP+AvfRnnxt5qstsa+EyC3VtEYgCl71JhMQvk40bNMWVjC0pW6RWI1b/uvurUe7myuRQRQiXb6RF+JC7/mrzkcfbuMRBLep20naKZeawHBrDX8bNtopMjq6jl+WaLu/u/ECgv2Ag689wc7b9jvidbnnM2RQnBQXi4bZNythmTE8HTkrvUkuE5lNG8UoZrQuoKsl0zYgVOxudngmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(478600001)(71200400001)(6636002)(110136005)(8936002)(316002)(6486002)(8676002)(2906002)(186003)(26005)(66446008)(66476007)(66556008)(83380400001)(91956017)(76116006)(36756003)(6506007)(5660300002)(6512007)(2616005)(86362001)(64756008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OyCOzgpcAkx43rSGwE27GoUzKS90AaCvGR4DritoJLWI11reVfVNE7BZPogDwDfU898Ione0s0YNgFrqQyTeTZp3h5PZN2Rd/MKDuD/d04+GHO1vdLIRZ9DL4teN6VN3VSKBWBfzFzwadxU1D9DH9m0+yaYI0QfpAZK9cDASo7AkVeCeJY7LjUosLgq5mZwEwhJ/ozw3CbnvKJAaw8UWCBO5I5XL/7wt1PbLkX707O3hR4sTieAywVyyBP4BkBMdksl9zRGRVPsllF9uk2dlPrxy5cAappcx6kfLg4tQJf9tGKI5CFZUV7m4k49PjCZwtEApirG0v5+/fyUVBpXpXoB/OiyRE1/HerfzUgWxMWX4DCi+4dSWdgMJaqli0PF2A0gm5cYP+5GZlPEvWAlunZI1XGxu5C/Ijg/rab7Us4WtVIsA0JLBXQdGYXo7Ye+NHMShTv1xbO7yQ8K41S/g83gVh0tMM+oBK7j4vLjibY7wB9xpYcV2Fa2RtNaZhhBBH8MT7vUwGBZs5UQuaFh8mKKijfTddHKu1z5vma49FF+3fzs2J8e3EXecMqVU+v4KsidKnt8X9Nxu9Dd58w37SdZXFyiCFhMoUrJk6/wYpGk7EDJlfGSTCp8acsxJkarZXV47BsIAUA5o4rCpJXZS3Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <7940D0DF24EE424780D3F4F344AF1673@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dc60e5-0bbe-4d0f-202d-08d83adf83b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 14:38:13.3932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QFqaAbOciOMS2/OTtcbUXaAqveLAG1JrbnWL/A5XbgvvHzc0TWDnK1iXaX2UlN/2YCBXZlutfGx6dGXdkiS1oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1904
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTA4LTA2IGF0IDE1OjU1IC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBXaGVuIHNlbmRpbmcgbW9kZWwgcHVibGlzaGluZyBkYXRhLCB1c2UgVFRMIHZh
bHVlIGNvbmZpZ3VyZWQgZm9yDQo+IHRoYXQgcHVibGljYXRpb24gaW5zdGVhZCBvZiB0aGUgZGVm
YXVsdCBUVEwgdmFsdWUgdXNlZCBmb3IgcmVndWxhcg0KPiBtZXNzYWdlcy4NCj4gLS0tDQo+ICBt
ZXNoL21vZGVsLmMgfCAgNCArKy0tDQo+ICBtZXNoL21vZGVsLmggfCAgMiArLQ0KPiAgbWVzaC9u
b2RlLmMgIHwgMTEgKysrKy0tLS0tLS0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25z
KCspLCAxMCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21vZGVsLmMgYi9t
ZXNoL21vZGVsLmMNCj4gaW5kZXggZWY3NjY4MTQ3Li4wNDNhZDFkNzAgMTAwNjQ0DQo+IC0tLSBh
L21lc2gvbW9kZWwuYw0KPiArKysgYi9tZXNoL21vZGVsLmMNCj4gQEAgLTEwMjIsNyArMTAyMiw3
IEBAIGRvbmU6DQo+ICB9DQo+ICANCj4gIGludCBtZXNoX21vZGVsX3B1Ymxpc2goc3RydWN0IG1l
c2hfbm9kZSAqbm9kZSwgdWludDMyX3QgaWQsIHVpbnQxNl90IHNyYywNCj4gLQkJCQl1aW50OF90
IHR0bCwgY29uc3Qgdm9pZCAqbXNnLCB1aW50MTZfdCBtc2dfbGVuKQ0KPiArCQkJCQljb25zdCB2
b2lkICptc2csIHVpbnQxNl90IG1zZ19sZW4pDQo+ICB7DQo+ICAJc3RydWN0IG1lc2hfbmV0ICpu
ZXQgPSBub2RlX2dldF9uZXQobm9kZSk7DQo+ICAJc3RydWN0IG1lc2hfbW9kZWwgKm1vZDsNCj4g
QEAgLTEwNjMsNyArMTA2Myw3IEBAIGludCBtZXNoX21vZGVsX3B1Ymxpc2goc3RydWN0IG1lc2hf
bm9kZSAqbm9kZSwgdWludDMyX3QgaWQsIHVpbnQxNl90IHNyYywNCj4gIA0KPiAgCXJlc3VsdCA9
IG1zZ19zZW5kKG5vZGUsIG1vZC0+cHViLT5jcmVkZW50aWFsICE9IDAsIHNyYywNCj4gIAkJCQlt
b2QtPnB1Yi0+YWRkciwgbW9kLT5wdWItPmlkeCwgbmV0X2lkeCwNCj4gLQkJCQlsYWJlbCwgdHRs
LCBmYWxzZSwgbXNnLCBtc2dfbGVuKTsNCj4gKwkJCQlsYWJlbCwgbW9kLT5wdWItPnR0bCwgZmFs
c2UsIG1zZywgbXNnX2xlbik7DQo+ICANCj4gIAlyZXR1cm4gcmVzdWx0ID8gTUVTSF9FUlJPUl9O
T05FIDogTUVTSF9FUlJPUl9GQUlMRUQ7DQo+ICB9DQo+IGRpZmYgLS1naXQgYS9tZXNoL21vZGVs
LmggYi9tZXNoL21vZGVsLmgNCj4gaW5kZXggMGQ4ZGRkZjkyLi5lNDkwNmUzMzAgMTAwNjQ0DQo+
IC0tLSBhL21lc2gvbW9kZWwuaA0KPiArKysgYi9tZXNoL21vZGVsLmgNCj4gQEAgLTEwMyw3ICsx
MDMsNyBAQCBib29sIG1lc2hfbW9kZWxfc2VuZChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50
MTZfdCBzcmMsIHVpbnQxNl90IGRzdCwNCj4gIAkJCQkJdWludDhfdCB0dGwsIGJvb2wgc2VnbWVu
dGVkLA0KPiAgCQkJCQljb25zdCB2b2lkICptc2csIHVpbnQxNl90IG1zZ19sZW4pOw0KPiAgaW50
IG1lc2hfbW9kZWxfcHVibGlzaChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MzJfdCBpZCwg
dWludDE2X3Qgc3JjLA0KPiAtCQkJCXVpbnQ4X3QgdHRsLCBjb25zdCB2b2lkICptc2csIHVpbnQx
Nl90IG1zZ19sZW4pOw0KPiArCQkJCQljb25zdCB2b2lkICptc2csIHVpbnQxNl90IG1zZ19sZW4p
Ow0KPiAgYm9vbCBtZXNoX21vZGVsX3J4KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIGJvb2wgc3pt
aWN0LCB1aW50MzJfdCBzZXEwLA0KPiAgCQkJdWludDMyX3Qgc2VxLCB1aW50MzJfdCBpdl9pbmRl
eCwgdWludDE2X3QgbmV0X2lkeCwNCj4gIAkJCXVpbnQxNl90IHNyYywgdWludDE2X3QgZHN0LCB1
aW50OF90IGtleV9haWQsDQo+IGRpZmYgLS1naXQgYS9tZXNoL25vZGUuYyBiL21lc2gvbm9kZS5j
DQo+IGluZGV4IDNkY2E3M2NlZi4uNGI3MDU4N2FlIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25vZGUu
Yw0KPiArKysgYi9tZXNoL25vZGUuYw0KPiBAQCAtMTk4Myw3ICsxOTgzLDcgQEAgc3RhdGljIHN0
cnVjdCBsX2RidXNfbWVzc2FnZSAqcHVibGlzaF9jYWxsKHN0cnVjdCBsX2RidXMgKmRidXMsDQo+
ICAJc3RydWN0IGxfZGJ1c19tZXNzYWdlX2l0ZXIgaXRlcl9kYXRhOw0KPiAgCXVpbnQxNl90IG1v
ZF9pZCwgc3JjOw0KPiAgCXN0cnVjdCBub2RlX2VsZW1lbnQgKmVsZTsNCj4gLQl1aW50OF90ICpk
YXRhLCB0dGw7DQo+ICsJdWludDhfdCAqZGF0YTsNCj4gIAl1aW50MzJfdCBsZW4sIGlkOw0KPiAg
CWludCByZXN1bHQ7DQo+ICANCj4gQEAgLTIwMTAsMTAgKzIwMTAsOCBAQCBzdGF0aWMgc3RydWN0
IGxfZGJ1c19tZXNzYWdlICpwdWJsaXNoX2NhbGwoc3RydWN0IGxfZGJ1cyAqZGJ1cywNCj4gIAkJ
cmV0dXJuIGRidXNfZXJyb3IobXNnLCBNRVNIX0VSUk9SX0lOVkFMSURfQVJHUywNCj4gIAkJCQkJ
CQkiSW5jb3JyZWN0IGRhdGEiKTsNCj4gIA0KPiAtCXR0bCA9IG1lc2hfbmV0X2dldF9kZWZhdWx0
X3R0bChub2RlLT5uZXQpOw0KPiAtDQo+ICAJaWQgPSBTRVRfSUQoU0lHX1ZFTkRPUiwgbW9kX2lk
KTsNCj4gLQlyZXN1bHQgPSBtZXNoX21vZGVsX3B1Ymxpc2gobm9kZSwgaWQsIHNyYywgdHRsLCBk
YXRhLCBsZW4pOw0KPiArCXJlc3VsdCA9IG1lc2hfbW9kZWxfcHVibGlzaChub2RlLCBpZCwgc3Jj
LCBkYXRhLCBsZW4pOw0KPiAgDQo+ICAJaWYgKHJlc3VsdCAhPSBNRVNIX0VSUk9SX05PTkUpDQo+
ICAJCXJldHVybiBkYnVzX2Vycm9yKG1zZywgcmVzdWx0LCBOVUxMKTsNCj4gQEAgLTIwMzAsNyAr
MjAyOCw3IEBAIHN0YXRpYyBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKnZlbmRvcl9wdWJsaXNoX2Nh
bGwoc3RydWN0IGxfZGJ1cyAqZGJ1cywNCj4gIAlzdHJ1Y3QgbF9kYnVzX21lc3NhZ2VfaXRlciBp
dGVyX2RhdGE7DQo+ICAJdWludDE2X3Qgc3JjLCBtb2RfaWQsIHZlbmRvcl9pZDsNCj4gIAlzdHJ1
Y3Qgbm9kZV9lbGVtZW50ICplbGU7DQo+IC0JdWludDhfdCB0dGwsICpkYXRhID0gTlVMTDsNCj4g
Kwl1aW50OF90ICpkYXRhID0gTlVMTDsNCj4gIAl1aW50MzJfdCBsZW47DQo+ICAJaW50IHJlc3Vs
dDsNCj4gIA0KPiBAQCAtMjA1Nyw4ICsyMDU1LDcgQEAgc3RhdGljIHN0cnVjdCBsX2RidXNfbWVz
c2FnZSAqdmVuZG9yX3B1Ymxpc2hfY2FsbChzdHJ1Y3QgbF9kYnVzICpkYnVzLA0KPiAgCQlyZXR1
cm4gZGJ1c19lcnJvcihtc2csIE1FU0hfRVJST1JfSU5WQUxJRF9BUkdTLA0KPiAgCQkJCQkJCSJJ
bmNvcnJlY3QgZGF0YSIpOw0KPiAgDQo+IC0JdHRsID0gbWVzaF9uZXRfZ2V0X2RlZmF1bHRfdHRs
KG5vZGUtPm5ldCk7DQo+IC0JcmVzdWx0ID0gbWVzaF9tb2RlbF9wdWJsaXNoKG5vZGUsIFNFVF9J
RCh2ZW5kb3JfaWQsIG1vZF9pZCksIHNyYywgdHRsLA0KPiArCXJlc3VsdCA9IG1lc2hfbW9kZWxf
cHVibGlzaChub2RlLCBTRVRfSUQodmVuZG9yX2lkLCBtb2RfaWQpLCBzcmMsDQo+ICAJCQkJCQkJ
CWRhdGEsIGxlbik7DQo+ICANCj4gIAlpZiAocmVzdWx0ICE9IE1FU0hfRVJST1JfTk9ORSkNCg==
