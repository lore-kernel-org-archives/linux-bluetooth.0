Return-Path: <SRS0=ILT4=BQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AC1C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Aug 2020 22:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D2720748
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Aug 2020 22:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="A5KvqI/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgHFWrs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:47:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:18324 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgHFWrr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Aug 2020 18:47:47 -0400
IronPort-SDR: H4VCMe3tKpSslees4lf6CG7ThDk17fpFAR2Ihvo0kptv9R2P/npHn6h0hmg0bRuqvn6X3lJRMi
 pWQbQ7C76rNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="152903557"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="152903557"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 15:47:46 -0700
IronPort-SDR: G4RTzh6oOdnF9I7j85D9RrrR6HMc9QoU7TfAQ1c3czwlUPceGh8LzAs6TL5nu/M/6Q8k6NrOLq
 qACC4kkdginA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="437705917"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga004.jf.intel.com with ESMTP; 06 Aug 2020 15:47:46 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Aug 2020 15:47:46 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Aug 2020 15:47:46 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX113.amr.corp.intel.com (10.22.240.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 6 Aug 2020 15:47:46 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 6 Aug 2020 15:47:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FJFK+IE87lbYfc1FcRJgPUpdqXo0gkcZ4ZOLU4tiugINJ30yEUI7WbPrjIu/W1KL/bmwAs0zM+2H4IY+zJOgqN5c9224aGdnFc2uTSTT+Dc9ztYDG2TIgMBjYi/0cc12MFrS5LrLz4yn8kdSN63EuitFVLXtP+eyiz/tU+z5NqLv01F9CqeKqxSkqlmGSt9g2akrzaMcUHhbA93uFqf91mGu9FbO+jwJ+jCs1nSHu2RI5L0gM+tjbFDVeJVuxI2xgz5Y/yrudn/vsTOgeOBd7+n9dWFos4DOZyvbogBHRMfg87Ket+aBKUnG8ScC1K8WithAFmvG46vuL2BEFnHziw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4IjB2IxVo7g0lgxx8sevx5bJFFoRTu4+ckqQK4ueGc=;
 b=jacJbLm4E3ACil6D/BtXYjtnkdGjsTgI/hu2SbrBYDgkEtARyzu4tBZgScIrmkvKIdyO3G1FvdESyns1GB4+Q2HCH8bD2hlCosEo+e/ES5+d+jkcZaF7/IrOnOTcgg6QCbNWhys15w8WDzwApn+J64oJONNRrCaZfM2+E69IS+LwVP3cw+ukg6GmhPMJKNKOPb/Y8u0jI9TZEDGbHoqX2ni/zprtii/7wMcNGL0L/Rrksd5/oAh61+CelqDJ7vxqjC9SGnOuBdFC2b38DVzcQBLal3DkSzmQ7MKYdkYPHcVEcY+yYef8ll512KZ90mesTfQs/XTVhs1yNcub9QNPAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4IjB2IxVo7g0lgxx8sevx5bJFFoRTu4+ckqQK4ueGc=;
 b=A5KvqI/cNc+KeTbcxjej1L6kwR1ac2sOHsP8wU41GByCRsqE3a4R57DCaI77p1K35Sc1KJ1ZZuVORPCcygeQ/uIZakJrCIzOgNJ4GyA0IXVvoMCe+fZFE+8Mx8cq98A2FILKZKDddKzdLjA1eZj7703jX8UFojJLJuBVNM4cpBk=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4763.namprd11.prod.outlook.com (2603:10b6:303:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17; Thu, 6 Aug
 2020 22:47:45 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3261.016; Thu, 6 Aug 2020
 22:47:45 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Allow deleting non-existing app key
Thread-Topic: [PATCH BlueZ] mesh: Allow deleting non-existing app key
Thread-Index: AQHWbBbQz0XSvPCZMUuUqy/znTYKaKkrrwQA
Date:   Thu, 6 Aug 2020 22:47:45 +0000
Message-ID: <90334f4eedbc5c4f6e2da2c17ab4791d6d32dc7b.camel@intel.com>
References: <20200806141309.26007-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200806141309.26007-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7c4bffb6-84c3-4452-3453-08d83a5abc7c
x-ms-traffictypediagnostic: MW3PR11MB4763:
x-microsoft-antispam-prvs: <MW3PR11MB4763D005DF714460E663FBD4E1480@MW3PR11MB4763.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WlgznTksMJe/tFA6N9DIhVMOt5ItB0Spf8Ij66BJWrWm1gUT3jGyJoUxGDIYX9BvNuFXP37ui7WBrzUXG2m7UKOOX+J8acm5ur4EH7Ldh8Zmf9sTCuZm/IrAaPSM5k/XJ21cy4JzKO89hz/2suqVQGOvSDcTWGmZGt/12s9/3WGQFdEft/CYl1AX5uttXmSOqviRgZ1kAVm9NwNgFyfbxEfzo4PZ1+rk5gSWSmGdRnIt95aKUgslaJwPZ/ijQLVzpLbld/RdeXrO7no1CRZXn22bYJ6FgBMGS6ot6c0RhEiMAFlRDUj2XJr7LejlhQ8i5Ug8atp4vUQMydpOmSh+6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(6486002)(71200400001)(64756008)(36756003)(478600001)(66476007)(86362001)(8676002)(26005)(2906002)(66446008)(6506007)(66556008)(4744005)(6512007)(5660300002)(91956017)(8936002)(186003)(316002)(76116006)(110136005)(83380400001)(2616005)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ob9sI0YtnuGbVcTylTfr5R+Sbh0ROp+I5oYkUkOyNUKrWkiSSOKE/Fg3cJbDDdOPyby5I6D/2x2Ua3856WW0ThH9EXH9xNUDftmV2HEvBMG/TnPK3DttevMCqmPtqQ1sS/YOGWrz83Vn3m7GvSno8Xq9o7A5250ASZnP1iQi2XJgNHu4kzgGEUcmbpiOXqqcB5xjuWe2AETxfOMGN/BzLoTUDerDkxnKRuYVcrRkfLau+y4+YXdSHc5KBdigeDw3eU3jbwldriPCOmEE8xshNXexCYtOVUrMH65NwY6/7Y9QCuiND6H8Pd2pACGtJXv2t8Ii2IXgPyfx/l36rE8ith3OEzWXQEX0+UxfGIGqn9wMaAEWbEiozOPzb0jGwrJuuYvfJZ6GbuaobLkYAdFTN+2Lw0LHT9p0PeZCWuFu1nSeD4ApSzUkeJkMA/pLAMJGAnyQj01DVMeHcVWUj7cTiZH+iOBePbzvj/93Pnh69czYDMKFFC3GYP70xu1g9XFBL6oke9OqLUYcDRvU3rWkPolr8TQvxG3woZSREAt+eZwrCpPSlV2uxsyowmlNdDI48R0o1/erPX8lrJpauyUomMUQeNVwKt6N/MIzDBrHxerMpcB5rDnRkDkyiga40nt9ui11qXdTOReNCEf/4zRttg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E64624370AE031418F468E0952ADBA94@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4bffb6-84c3-4452-3453-08d83a5abc7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 22:47:45.5663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFLLgiCuQhqIRyR9ApMyihC2x9pFZ1yI/hwZ+XoWtfF1EZb9h9xg/1ZPxax22vmQj+R1upaC2+ZVSt9R0wG2ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4763
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTA4LTA2IGF0IDE2OjEzICswMjAwLCBNaWNoYcWCIExvd2Fz
LVJ6ZWNob25layB3cm90ZToNCj4gTWVzaCBQcm9maWxlIHYxLjAuMSwgc2VjdGlvbiA0LjMuMi40
MCBDb25maWcgQXBwS2V5IFN0YXR1cw0KPiANCj4gKC4uLikgVGhlIFN0YXR1cyBDb2RlIHNoYWxs
IGJlIFN1Y2Nlc3MgaWYgdGhlIHJlY2VpdmVkIHJlcXVlc3Qgd2FzDQo+IHJlZHVuZGFudCAoYWRk
IG9mIGFuIGlkZW50aWNhbCBleGlzdGluZyBrZXksIHVwZGF0ZSBvZiBhbiBpZGVudGljYWwNCj4g
dXBkYXRlZCBrZXksIG9yIGRlbGV0ZSBvZiBhIG5vbi1leGlzdGVudCBrZXkpLCB3aXRoIG5vIGZ1
cnRoZXIgYWN0aW9uDQo+IHRha2VuLg0KPiAtLS0NCj4gIG1lc2gvYXBwa2V5LmMgfCAyICstDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9tZXNoL2FwcGtleS5jIGIvbWVzaC9hcHBrZXkuYw0KPiBpbmRleCA0NWQ2MDQw
MDcuLmE0NzcxYmQ3ZCAxMDA2NDQNCj4gLS0tIGEvbWVzaC9hcHBrZXkuYw0KPiArKysgYi9tZXNo
L2FwcGtleS5jDQo+IEBAIC0zMjAsNyArMzIwLDcgQEAgaW50IGFwcGtleV9rZXlfZGVsZXRlKHN0
cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBuZXRfaWR4LA0KPiAgCWtleSA9IGxfcXVldWVf
ZmluZChhcHBfa2V5cywgbWF0Y2hfa2V5X2luZGV4LCBMX1VJTlRfVE9fUFRSKGFwcF9pZHgpKTsN
Cj4gIA0KPiAgCWlmICgha2V5KQ0KPiAtCQlyZXR1cm4gTUVTSF9TVEFUVVNfSU5WQUxJRF9BUFBL
RVk7DQo+ICsJCXJldHVybiBNRVNIX1NUQVRVU19TVUNDRVNTOw0KPiAgDQo+ICAJaWYgKGtleS0+
bmV0X2lkeCAhPSBuZXRfaWR4KQ0KPiAgCQlyZXR1cm4gTUVTSF9TVEFUVVNfSU5WQUxJRF9ORVRL
RVk7DQo=
