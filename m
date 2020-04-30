Return-Path: <SRS0=orbE=6O=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881BAC47247
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 17:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DB420731
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Apr 2020 17:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="O6ghFdO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgD3R7t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Apr 2020 13:59:49 -0400
Received: from mga03.intel.com ([134.134.136.65]:11925 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD3R7s (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Apr 2020 13:59:48 -0400
IronPort-SDR: b94cNb9rxVd1i2Gred5cKE+/E00Ww9SXb1eBaDk3/EYu+hfIvAW0ZRN/lJtHCJOd/R9ANjfMYg
 UoNlabqsOdNA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 10:59:48 -0700
IronPort-SDR: +ZlvaPe47Zn0bPTLD1Tszu7Vbi9kybcIPnPDM8a+VG7ccUqGmJUbauKaERCThMya2mQ8qqxn14
 La2BqT6iHdLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,336,1583222400"; 
   d="scan'208";a="249813447"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 30 Apr 2020 10:59:47 -0700
Received: from fmsmsx158.amr.corp.intel.com (10.18.116.75) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Apr 2020 10:59:47 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx158.amr.corp.intel.com (10.18.116.75) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 30 Apr 2020 10:59:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 30 Apr 2020 10:59:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWEK3MYQWob+oPdSVt1M8QW5hkhSPfJ2f2VwO+utnvhUUQDpg2q01G7+kJc6MJYUw9QWakcmfwL/+A5dHRMm40C9XXAqIkwUwsFvZOyCPsVEhVuFSsSbusJnomZvaAy/MB6JJp6qlUWErWiO+5oF0+vb6HVK/Nf/LWhMEBN2y8QJGOXOWThcRbkYt12CPzwpkxd0EaRMgaVVxNP4FAYTwEDBUyW9i1HBu6lVVz3JCPEfBrWS2vukqkRV86rxKr9ERyL4upLzQUWMM0WPlnQ+xOVIr60uADVpZaD9/VbN0A7LIIIPB5SxIvrR4HwWDn1xoPVeaSUIK0BSaYQ4z5LttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/FYS8L0ggCNQJEe2t6SJZfL2mPgRqccrLo5vTkr7Gg=;
 b=jOUZWDSqRCG5e8IhxWVoc1H+VxaEPvrooVCunqzbsRwlahJkibq8Ekjw/b4/peXvAKRrhTs2DagGiqWasKEK6KilR/yn3ZQVg3TRPRfgciaU0Ht8s/pjTG6CkZGowbBgODzkUscr2DpJ8sbyjUCIobTBdPXwyMMJZ5gUw1++Y802QAye2Hy2JoGjxBz80K1DLn0zDQabGjzyVo5EGRSudnLFr7mVjfWo44yOWWAKujzUpOsiFn1VAut9yzs200s4NQP6lb9c3XmEgUjkKfy45pmTKBfWBN6tFbWhQanVJtA7JJWXmHgMiv67Jc1/FEu/NPGXUSKOgViNPnwT95lk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/FYS8L0ggCNQJEe2t6SJZfL2mPgRqccrLo5vTkr7Gg=;
 b=O6ghFdO7Ru+ccRKKBKDJwrTjTJzbYTpftTGA6L6RYJZGkEBIoS5PULH9LESUkhrKEF1CJJhatnarX/aO/Q1Rvtg4C2BXZDzXT0meoOF7U4HxyPlF+HQrthamQwvycxNsExKc3UTbJQYZ4ESq3hTvCS3BZHUSV6YIWYF93JEGbfc=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4730.namprd11.prod.outlook.com (2603:10b6:303:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 17:59:46 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5552:f057:3dbf:716c]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5552:f057:3dbf:716c%3]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 17:59:46 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix publication setup for vendor models
Thread-Topic: [PATCH BlueZ] mesh: Fix publication setup for vendor models
Thread-Index: AQHWHmPLHlDAj9lezU2u54bBgat+QaiR9XuA
Date:   Thu, 30 Apr 2020 17:59:46 +0000
Message-ID: <36b56f312ec63aed0dbf594021299d616588f022.camel@intel.com>
References: <20200429202054.2397-1-inga.stotland@intel.com>
In-Reply-To: <20200429202054.2397-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8d81709-fa78-490a-c296-08d7ed3044a0
x-ms-traffictypediagnostic: MW3PR11MB4730:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4730AA074FE7FA3DA5F4AE97E1AA0@MW3PR11MB4730.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0389EDA07F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dg/JjNLFruBu9HRSpcDjdyq2ycMDnxWhgSj0vQuh0+yNjpbyp3Z9PKPOejJfpuTJatKOmRm+4rmnbeleUOjvbdXofJR0VCCj+6gb/jg3/tlCergOb0h/gXi7ROZ/6QCKFFcKASAGm2r6N3kxXBGIHnyWp0Auo+6A64EbyyZtD+7Ay3Ez9O4aBN0BlGyV/6I4WQLRn0FBw4yW1+TfHf3BS1bi79PFcqh1iUh97quqAg0MbbHkXZD3pxoGbQ9UCITI1SDbvgw678DADFeABn6uog4y99qeV4OUjiX1VbyjV+LCffWA9Z7tSM9uYWgCEybyIuQ24jHQFXNAVztO7XSGby/0isYfKPcrSoYVqJjdmSmgzaL+SB6nCaAAp4+qX3CdeeGFU2Tj34EfrlALnjLqNeLU6QePba86iE47xPNlQ1YbsYlIlEx3FPu9KjlkaATXSylkBKtG9xCDbu1iTNW3iN5VPwCOi7t2n6nixo2g8b59NjFaVGKcUvJF1REWq1SU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(39860400002)(396003)(346002)(366004)(2616005)(86362001)(64756008)(66446008)(2906002)(66946007)(478600001)(110136005)(5660300002)(8936002)(91956017)(76116006)(316002)(6636002)(6486002)(36756003)(66476007)(186003)(6512007)(66556008)(26005)(6506007)(71200400001)(8676002)(170073001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1WxWj/Ye5KR0KX89SUgmjTxyv6JCh6FsrFmtVmUmWqDiwQeOsDu+61IlRT2C1wGj3huzqVyl41YqiBZwC5WNJc7XAN174/pS9KK5PGtjmEhxP6fVOoQ1dr+qwSuTqZdU3GEKtu3X/5h3Z5xjqNuuDOfwNrQdpefIGpw/XKwwVoGJoaITf1IDM0i8Th37cLHG+hh1gHNjQ2bfXBuFA9mPIoeCFvVBukvCHJ3nBpoey9H9H0oowRconuqi7GTmTtMhQZTou6TDKyvCmWMGUulGp26STM35lWRySPe4SkzMyKxYjqVGsKX4EPMI9zAVaBtHw8q5FZZ4oevGRf075L3m4SE/RZa0NJs7eyn1LYUjrJugMzLcJl2wG6ws2OwoEZLrcZ/jujEPnHwQeRhudb3v7wH5abhjZ2bQ7L/66SL15o/d1hyyGDwoZedykvg/5ctdaZuABOBg1/Z0P/MmiKGe2AG4F6mHRCtXAehKB6uFjiDOAN92cUaQ+Ht8yoL5X6SlIiGrw0p+VEru7tXRtmcRALG7ClMIDq/NUyxVZGhYbtpdymjGWNN0VyTDWfgsT6AA8vDpAaWWsjCuawCxrZ9yJ01s7aGA1M900o947GjUqAtZ1Ziz745X0affcuBLGkDp1xt++q3/yoR6aUhDA04w7z/WIDzeF23BtQf+168dGlQgLghVnnmMsE5H/tzv9SkgnYYwEfZGmgL3MdUbs4ILSCSSYdAupB0uV+j6uC17FGZAFdrlSnek8LoXQ241XXyn6NPRsYXxop+hb94zn+rzq2PP82JkL+ljSReUeo0h5Bo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C0BC335CD850049B75B9445BFB56E94@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d81709-fa78-490a-c296-08d7ed3044a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2020 17:59:46.0818
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /jenXMqVhIoJtxZibMIMyIMzrpKZrdJLwrGDdWK/SvwYJGELYlPDC6kT52NOJ354BVlsY7Ua3C3kwCERWyDANQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4730
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBXZWQsIDIwMjAtMDQtMjkgYXQgMTM6MjAgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgbW9kZWwgSUQgZ2VuZXJhdGlvbiB3aGVuIHByb2Nlc3Np
bmcgQ29uZmlnIFB1YiBTZXQNCj4gbWVzc2FnZS4gQWxzbywgY2xlYW51cCBzb21lIGRlYnVnIHBy
aW50cy4NCj4gLS0tDQo+ICBtZXNoL2NmZ21vZC1zZXJ2ZXIuYyB8IDggKysrKy0tLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvbWVzaC9jZmdtb2Qtc2VydmVyLmMgYi9tZXNoL2NmZ21vZC1zZXJ2ZXIuYw0KPiBp
bmRleCA4NTZlYjZiMjcuLjE1NjQxNzVjNyAxMDA2NDQNCj4gLS0tIGEvbWVzaC9jZmdtb2Qtc2Vy
dmVyLmMNCj4gKysrIGIvbWVzaC9jZmdtb2Qtc2VydmVyLmMNCj4gQEAgLTEyNCw3ICsxMjQsNyBA
QCBzdGF0aWMgdm9pZCBjb25maWdfcHViX3NldChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50
MTZfdCBuZXRfaWR4LA0KPiAgCWlmICghdmVuZG9yKQ0KPiAgCQltb2RfaWQgfD0gVkVORE9SX0lE
X01BU0s7DQo+ICAJZWxzZQ0KPiAtCQltb2RfaWQgfD0gbF9nZXRfbGUxNihwa3QgKyAxMSArIHZp
cnRfb2Zmc2V0KTsNCj4gKwkJbW9kX2lkID0gKG1vZF9pZCA8PCAxNikgfCBsX2dldF9sZTE2KHBr
dCArIDExICsgdmlydF9vZmZzZXQpOw0KPiAgDQo+ICAJZWxlX2FkZHIgPSBsX2dldF9sZTE2KHBr
dCk7DQo+ICAJcHViX2FkZHIgPSBwa3QgKyAyOw0KPiBAQCAtMjMyLDcgKzIzMiw3IEBAIHN0YXRp
YyBib29sIGNvbmZpZ19zdWJfZ2V0KHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IG5l
dF9pZHgsDQo+ICANCj4gIAlzd2l0Y2ggKHNpemUpIHsNCj4gIAlkZWZhdWx0Og0KPiAtCQlsX2Rl
YnVnKCJCYWQgTGVuIENmZ19QdWJfU2V0OiAlZCIsIHNpemUpOw0KPiArCQlsX2RlYnVnKCJCYWQg
bGVuZ3RoICVkIiwgc2l6ZSk7DQo+ICAJCXJldHVybiBmYWxzZTsNCj4gIA0KPiAgCWNhc2UgNDoN
Cj4gQEAgLTMyMiw3ICszMjIsNyBAQCBzdGF0aWMgdm9pZCBjb25maWdfc3ViX3NldChzdHJ1Y3Qg
bWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBuZXRfaWR4LA0KPiAgDQo+ICAJc3dpdGNoIChzaXpl
KSB7DQo+ICAJZGVmYXVsdDoNCj4gLQkJbF9lcnJvcigiQmFkIExlbiBDZmdfU3ViX1NldDogJWQi
LCBzaXplKTsNCj4gKwkJbF9lcnJvcigiQmFkIGxlbmd0aDogJWQiLCBzaXplKTsNCj4gIAkJcmV0
dXJuOw0KPiAgCWNhc2UgNDoNCj4gIAkJaWYgKG9wY29kZSAhPSBPUF9DT05GSUdfTU9ERUxfU1VC
X0RFTEVURV9BTEwpDQo+IEBAIC01NjcsNyArNTY3LDYgQEAgc3RhdGljIHZvaWQgaGJfcHViX3Rp
bWVvdXRfZnVuYyhzdHJ1Y3QgbF90aW1lb3V0ICp0aW1lb3V0LCB2b2lkICp1c2VyX2RhdGEpDQo+
ICAJCWxfdGltZW91dF9yZW1vdmUoaGItPnB1Yl90aW1lcik7DQo+ICAJCWhiLT5wdWJfdGltZXIg
PSBOVUxMOw0KPiAgCX0NCj4gLQlsX2RlYnVnKCIlZCBsZWZ0IiwgaGItPnB1Yl9jb3VudCk7DQo+
ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIHVwZGF0ZV9oYl9wdWJfdGltZXIoc3RydWN0IG1lc2hf
bmV0ICpuZXQsDQo+IEBAIC02NTEsNiArNjUwLDcgQEAgc3RhdGljIGludCBoYl9zdWJzY3JpcHRp
b25fc2V0KHN0cnVjdCBtZXNoX25ldCAqbmV0LCB1aW50MTZfdCBzcmMsDQo+ICAJCWhiLT5zdWJf
bWluX2hvcHMgPSAwOw0KPiAgCQloYi0+c3ViX21heF9ob3BzID0gMDsNCj4gIAkJcmV0dXJuIE1F
U0hfU1RBVFVTX1NVQ0NFU1M7DQo+ICsNCj4gIAl9IGVsc2UgaWYgKCFwZXJpb2RfbG9nICYmIHNy
YyA9PSBoYi0+c3ViX3NyYyAmJiBkc3QgPT0gaGItPnN1Yl9kc3QpIHsNCj4gIAkJLyogUHJlc2Vy
dmUgY29sbGVjdGVkIGRhdGEsIGJ1dCBkaXNhYmxlICovDQo+ICAJCWxfdGltZW91dF9yZW1vdmUo
aGItPnN1Yl90aW1lcik7DQo=
