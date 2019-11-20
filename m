Return-Path: <SRS0=VswU=ZM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1479AC432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 16:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F7020715
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 16:14:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="tfZeBmMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfKTQOY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Nov 2019 11:14:24 -0500
Received: from mga04.intel.com ([192.55.52.120]:30152 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728164AbfKTQOY (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Nov 2019 11:14:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 08:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,222,1571727600"; 
   d="scan'208";a="204863315"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga007.fm.intel.com with ESMTP; 20 Nov 2019 08:14:23 -0800
Received: from fmsmsx161.amr.corp.intel.com (10.18.125.9) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 Nov 2019 08:14:23 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX161.amr.corp.intel.com (10.18.125.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 Nov 2019 08:14:22 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.52) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 20 Nov 2019 08:14:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OnffzVJZ1rGWGfepK+g0DSXTDLHtGsWlr7UR+NKNTPWc3m9cldal/+QfF3Kuv2FVZXOhdkij1Ju+HPnPe/nQ3Cmwt8qBkp7GC3bdtwk9VxTz54jigGyjQLjy/9R7bRyqTRgXPYgP25sg6Arx//jfUnGuM3G3j3bi5iiftime+E7igA7qrJ9N4mkaEFznZrpYl4eBAU50OEZCbd+4hlzSsV5D0QAXb6rmnEIgeyErUfWO0rDpfQ0G0CbBzv48vIponxQ3UibYsGk0zpvVpIfODAnmZVJo76584tF5sEsJYKBwMvLy1z6qFxJT+8MqmwY4RgJm8DeH4gaOVoXuPMjprA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgPj7S+JszHinkVxxpEnml1XfIzAMoOLPkdUQQ5zZxY=;
 b=n/pcTFNlCfarmFzpVwKMFu03gbnTS5xrIOyf5b8+xJTv6wlkO619uj6FlzfT2GbSmdeXZ4c+lIrN/X5uBBKHZ3wszuVpGsOvlP6TOtKSEElOTW1YBSRLYzeQIeTb/TkROS1DIHErsrRJNSTqsVad2eicU1+w7awV1posXFZKDQYi+IMCq6JNXKbirjMcnSMfvWiID4bMXIhw9J1VAGw9oF3721WBarTz8k+zR+F5a54mT9x2NFEIYH8alUfRJmsfoAxXT9ZFHPJkVEkATx+MhN9sHHT1/x0U8dFPqvheAs/fbN5ariub0ip8YuzWE6xI38gqNpWik+vFx/Et+30a1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgPj7S+JszHinkVxxpEnml1XfIzAMoOLPkdUQQ5zZxY=;
 b=tfZeBmMycvmPh3y8XahqpOPG+H30OyCThoRmeggblrzUMfhJ+8AxdB5fVQJG0Cft8XXfsKkz5RDnUI4SIgn19sIz36JFCBB8CELWZk8e8W+5lFNBKrm8vvbQKuLastbTXfwTnwxCfGfwXhyfjQASqn+FC/xArShJ3YxI3klxWwE=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2070.namprd11.prod.outlook.com (10.172.78.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Wed, 20 Nov 2019 16:14:20 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 16:14:20 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "aurelien@aurel32.net" <aurelien@aurel32.net>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v3 0/2] mesh: Fix inOOB and outOOB issues
Thread-Topic: [PATCH BlueZ v3 0/2] mesh: Fix inOOB and outOOB issues
Thread-Index: AQHVnyPK7bU9EgI0KE+HwbqiMLROIqeUPNiA
Date:   Wed, 20 Nov 2019 16:14:20 +0000
Message-ID: <f3bac4dc1aee3d242a0ba09d69b43bea7474b391.camel@intel.com>
References: <20191119215227.27730-1-brian.gix@intel.com>
In-Reply-To: <20191119215227.27730-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07303614-55a3-40c0-c9a0-08d76dd4b37f
x-ms-traffictypediagnostic: CY4PR1101MB2070:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB207004FFF85A8F3A2FF24C30E14F0@CY4PR1101MB2070.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(376002)(396003)(346002)(189003)(199004)(2906002)(2501003)(66066001)(6116002)(316002)(6246003)(76116006)(256004)(478600001)(91956017)(36756003)(107886003)(4326008)(5660300002)(54906003)(25786009)(71190400001)(64756008)(71200400001)(6512007)(66446008)(66556008)(5640700003)(66946007)(99286004)(3846002)(66476007)(102836004)(7736002)(6506007)(86362001)(2616005)(4001150100001)(11346002)(14454004)(446003)(6486002)(476003)(6436002)(486006)(26005)(186003)(4744005)(6916009)(76176011)(81156014)(8676002)(118296001)(2351001)(8936002)(81166006)(229853002)(305945005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2070;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u4l8gbfxKxpI73in0DH7iexq/sqYoggfn73YWnG4cxAcM91uZT+IqG38Ur9ZpuaCZM6vHb2mNidCwe2o/7wPGDljGH+sBMC8wngrX5LeyK2iPLu3PqFWxwj7YfEB+ruV4LucoFnc9dWEu9E73S8WJidpvmFzVUGksfY/Ov2u66aRPTWstk860rInIryBsf6p3wcoZmQ2Qshx4eDJNI/q4bG3JTcCuocyA3u9f1c/OYyhvSot8ufWC8Lmy3JruwvSmLEs82hc9Pfh4R7xawxsEkKILinFwChKf3D+R2ej51jKSiw0vC/Be6hfZptZzzFwmTP3siLwiU9D40mrbHNdvOzceYTXw1/v9OH8h2NABZJ9wrYTQsz3vyfG00WlSkdu9QH3E2cC+f+Vaw9QpPjS3QcX75uOjD3P+OknBUU2jNC5qnkxt6FG09+xTbVWbFkv
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABFE2B626E48FF4EACFDA124F384E9DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 07303614-55a3-40c0-c9a0-08d76dd4b37f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 16:14:20.6545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXgNYHm5marQD1tqVBGXidWxLozaNUPmmHRsLuZ3YP61tvRauMaOBTRaurVOgEOm6ttpgMm2zuXDFhrMpo3C8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2070
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2gtc2V0IGFwcGxpZWQNCg0KT24gVHVlLCAyMDE5LTExLTE5IGF0IDEzOjUyIC0wODAwLCBC
cmlhbiBHaXggd3JvdGU6DQo+IFZlcnNpb24gMyBvZiB0aGlzIHBhdGNoLXNldCBhZGRyZXNzZXMg
cHJvYmxlbSBmb3VuZCBieSBBdXJlbGllbg0KPiByZWdhcmRpbmcgdGhlIGFjdGlvbiBzdHJpbmcg
cGFzc2VkIHRvIHRoZSBleHRlcm5hbCBhZ2VudCBjb2xsZWN0aW5nDQo+IGFscGhhLW51bWVyaWMg
c3RyaW5ncyBvbiAib3V0LWFscGhhIiBwcm9tcHRzLg0KPiANCj4gVGhpcyBmaXggdGhlcmVmb3Jl
IG5vdyBkaWZmZXJlbnRpYXRlcyBhbHBoYW51bWVyaWMgY29sbGVjdGlvbiBkdWUgdG8NCj4gImlu
LWFscGhhIiAoYWNjZXB0b3Igcm9sZSkgZnJvbSAib3V0LWFscGhhIiAoaW5pdGlhdG9yIHJvbGUp
Lg0KPiANCj4gQnJpYW4gR2l4ICgxKToNCj4gICBtZXNoOiBGaXggaW5PT0IgYW5kIG91dE9PQiBh
Z2VudCBoYW5kbGluZyBvbiBwcm92IGluaXRpYXRlDQo+IA0KPiBJbmdhIFN0b3RsYW5kICgxKToN
Cj4gICB0b29scy9tZXNoLWNmZ2NsaWVudDogQWRkIGZ1bGwgc3VwcG9ydCBpbk9PQiBhbmQgb3V0
T09CDQo+IA0KPiAgbWVzaC9hZ2VudC5jICAgICAgICAgICB8ICAyOCArKysrLS0tDQo+ICBtZXNo
L2FnZW50LmggICAgICAgICAgIHwgICA0ICstDQo+ICBtZXNoL3Byb3YtYWNjZXB0b3IuYyAgIHwg
ICAyICstDQo+ICBtZXNoL3Byb3YtaW5pdGlhdG9yLmMgIHwgIDcxICsrKysrKysrKysrKystLS0N
Cj4gIHRvb2xzL21lc2gtY2ZnY2xpZW50LmMgfCAxNzggKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0NCj4gIHRvb2xzL21lc2gtZ2F0dC9wcm92LmMgfCAgIDkgKystDQo+
ICB0b29scy9tZXNoL2FnZW50LmMgICAgIHwgIDIxICsrKy0tDQo+ICB0b29scy9tZXNoL2FnZW50
LmggICAgIHwgICA0ICstDQo+ICA4IGZpbGVzIGNoYW5nZWQsIDI0OSBpbnNlcnRpb25zKCspLCA2
OCBkZWxldGlvbnMoLSkNCj4gDQo=
