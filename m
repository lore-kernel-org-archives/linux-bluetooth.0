Return-Path: <SRS0=5Aiy=BV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754FCC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 16:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A4DE20825
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 16:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="YIwCcLKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgHKQgH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:36:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:13796 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729121AbgHKQfq (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 12:35:46 -0400
IronPort-SDR: pkWSbyIig5YpGEp9b7KJNb5hnKtIwXW6b6lGqGhi8NA/M39rPEB21ThiiFAlO/INdQ8+maURpx
 p1gcEa8zxXNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="218108531"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="218108531"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 09:35:45 -0700
IronPort-SDR: khF0RyFQRNxOxUfgHHMSIP0l/+ykplDdEISSN+LKafAvwpZd9S5wADPjM+xEkfyxZNBC9WA/Qp
 Eh2btyq1nz2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="276335730"
Received: from orsmsx602-2.jf.intel.com (HELO ORSMSX602.amr.corp.intel.com) ([10.22.229.82])
  by fmsmga007.fm.intel.com with ESMTP; 11 Aug 2020 09:35:44 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Aug 2020 09:35:44 -0700
Received: from orsmsx105.amr.corp.intel.com (10.22.225.132) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 11 Aug 2020 09:35:44 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Aug 2020 09:35:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Aug 2020 09:35:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBtUGJGdAlyHVW21S/yRNtzo9PUBqTdzP5Lovo9AW/TqrfwCMJS7dth1oXYArVvG82Tagn+Nabstup4ywtVGLXb9ZjkLmgoXpt3XSoMC9jsw2/td6sHsFCcc7+ICB4dlet5pKySosuoI378LHzCcEBll7p+D70t1Ndis8RJViYauVVdOJCLisr3XwwbLjoZv3llYZFvFOji2bFjSP//kEG8ikZf1BRvcDA7PQobacz+sobewdT/qKXemerIw8r7vdW/znGxnWxGjfEDxKjcdbF5FvUftlPxEotdujelZuEbiT+79cVc5SHAB+3hYWJ5JVJPfqoIK6oEZ3X2vU6vvlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmFLbYhOATAsHB28RazPlVFEC5JoLJWO95nIh5ntNGM=;
 b=h5rhZPZp3pwQ9HDRKE+W4C889HE/2rUTdu7+9gVLCk7OHpsDjPqwI1FiGHVZ9rDjHS939Vu5lenY5LcC3eWZezJ5pEUq9aDFjtcmVUzWCV3MNha/SOcJrFYsNvrGen1NJWhQE078s13MFO8hUb59JxtxvkGJZVTXAPea3BTPY8QoeM8lnN+Sksi9MIAaCg4aow9z9mvu3hEAsohVmRkwZyowLdYl+P12z/H3m/EErUj1RNRXFKLMPzQ/lxFXHt4njWWSOw4ylogITBaPAmSpXy7Z4lz/zJSsrJCKSxl7qles28142f+A59Gc/4sYAVyVpDkqLWQeU2ivtr4UTVZQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TmFLbYhOATAsHB28RazPlVFEC5JoLJWO95nIh5ntNGM=;
 b=YIwCcLKQDhkGPUolR8y4NR/w1rSawbdZtjvpWFVv0P9eAtve/SF5MZVN6St+QPLlfk/rEMgqHkh5zK0nrJyTha5fN77n0TIZZ9SDJv/59/89Gi81w1FaJMZz69nE11RHuM67DMLb/VAlWcBqX6QIkPTB/kFQRhjjeeUNDHFJKrk=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1311.namprd11.prod.outlook.com (2603:10b6:300:2a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 16:35:42 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 16:35:42 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix element index look up for config model
 subs
Thread-Topic: [PATCH BlueZ] mesh: Fix element index look up for config model
 subs
Thread-Index: AQHWb/zq/0NZdSIbE0WrsBFB0HqzxqkzGu4A
Date:   Tue, 11 Aug 2020 16:35:42 +0000
Message-ID: <e277c5f0ab4207198879e0dfa85e7f6a9daea6f4.camel@intel.com>
References: <20200811163134.8561-1-inga.stotland@intel.com>
In-Reply-To: <20200811163134.8561-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2050df03-e21e-4365-3e4c-08d83e14971e
x-ms-traffictypediagnostic: MWHPR11MB1311:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1311485E4D92EA4660DA282EE1450@MWHPR11MB1311.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Uc0MQ0yZgrvW+l/EbOIA/xUQI3we7qHgaBSBqE5kPQmLyVbSLbXb4MDq3lXQV8luqyTIQg+/yC9OusziG/+aod8wlTwf0ZIreSiIC6lHhMb96AAwQaZVto+rgS2OlbJzPIHLuIm+P77Uc/zM4yl1G3ayPU1ZF0q3mDer2653q2WuUqyqPSO5hC7H9DsQLJ5+XlyQzg969yES1dCLV0glLN8/J/rHLGUIbe2q57RH8mXydfRBZQIERYw4TvJgZPKHPUmNP0c6EqEkGdpQM2Nu2rQBs/Z1eOVln70gX1qUSgjpJ8HNVGrizwSPneP3ODPGbvbT8+Hp1dlm0j76hI1Bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(346002)(366004)(136003)(83380400001)(6512007)(8676002)(86362001)(5660300002)(6486002)(6636002)(8936002)(186003)(2616005)(6506007)(478600001)(110136005)(64756008)(66946007)(76116006)(91956017)(66556008)(66446008)(36756003)(2906002)(71200400001)(26005)(66476007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VaJNTHq5LEZ/7meMcmvF3Clz8dtKmoJfceLprEk224v71akrjzynxfCUGoA91uVvKir67b7dLnpuHFywFOgileXCRk1G5Gtf0plaROtIEFvUyhUuvtmJiEA8MYufmLcbU4iq6PwsqFGd6DWaPUJ1WWRZPRbRNLJNT91zcvKtJrase8RvptsSK/1Ut5dIAMZoyc8a5w5f44dQ48o28AY+xQeGqwfUnpRTmruKYEum0NsEzR0yRYCV5pSy/kmorEjvk0Emh4oUPXbJ80Xiy3I/3aT3YECGW7jNMMWkFdvvhbd7BNUnZaH+RQn2OpuMwB2MWaFvi3lJ7ibwLvjubsPXNqe8AOhgt1J7mX+2nBltBZBmT8C94+8ZlMpJHupxEzSUWKzBC2oLK2I9zSR5i+VmQgUihtDTWJgfV58deZ2j1Wz7umAB45xphQ0nMBT4R15Ve/9zc31FrRmLVrcZgOOLC4XAgjVPjtP6RN2tU/Pa9dZLCdWHrtn1merW43k9eYPSGJ6+S0Jy+T0ZL8leip2ANaSgjUq1Nj2bIEWvxvFEngRj8LF2MM/EXahhD62UT4zcOI1PCPsE5qFPa75HfwIYhTr1fuhuRQ/imWG170pOkCZxENdHYJrvIvzLnb+7S05tCBzpkUwwM1Du8u1EsdQ/ew==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B836DBE76063A4687647CBF904FF646@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2050df03-e21e-4365-3e4c-08d83e14971e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 16:35:42.8325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFlSxWRDycbCJoqaMRR7P7jt9A2xiUsfZZt2i/+ZMJHxkzJpUxFT5vP2B3SocgsQgKJeIfJCNqJYETQSvjMoAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1311
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVHVlLCAyMDIwLTA4LTExIGF0IDA5OjMxIC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBVc2UgZWxlbWVudCBhZGRyZXNzIGZvciBsb29raW5nIHVwIGVsZW1lbnQgaW5k
ZXggKHN1YnNjcmlwdGlvbg0KPiBhZGRyZXNzIHdhcyBlcnJvbmVvdXNseSB1c2VkIHRvIHBlcmZv
cm0gdGhlIGxvb2t1cCkuDQo+IC0tLQ0KPiAgbWVzaC9tb2RlbC5jIHwgMTUgKysrKysrKystLS0t
LS0tDQo+ICBtZXNoL21vZGVsLmggfCAgMyArKy0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21vZGVs
LmMgYi9tZXNoL21vZGVsLmMNCj4gaW5kZXggNjkwYmUyOWQ1Li4yM2FmYjkzYTggMTAwNjQ0DQo+
IC0tLSBhL21lc2gvbW9kZWwuYw0KPiArKysgYi9tZXNoL21vZGVsLmMNCj4gQEAgLTE0MDIsMTMg
KzE0MDIsMTMgQEAgZG9uZToNCj4gIAlyZXR1cm4gTUVTSF9TVEFUVVNfU1VDQ0VTUzsNCj4gIH0N
Cj4gIA0KPiAtaW50IG1lc2hfbW9kZWxfc3ViX2dldChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1
aW50MTZfdCBhZGRyLCB1aW50MzJfdCBpZCwNCj4gK2ludCBtZXNoX21vZGVsX3N1Yl9nZXQoc3Ry
dWN0IG1lc2hfbm9kZSAqbm9kZSwgdWludDE2X3QgZWxlX2FkZHIsIHVpbnQzMl90IGlkLA0KPiAg
CQkJdWludDhfdCAqYnVmLCB1aW50MTZfdCBidWZfc2l6ZSwgdWludDE2X3QgKnNpemUpDQo+ICB7
DQo+ICAJaW50MTZfdCBuOw0KPiAgCXN0cnVjdCBtZXNoX21vZGVsICptb2Q7DQo+ICAJY29uc3Qg
c3RydWN0IGxfcXVldWVfZW50cnkgKmVudHJ5Ow0KPiAtCWludCBlbGVfaWR4ID0gbm9kZV9nZXRf
ZWxlbWVudF9pZHgobm9kZSwgYWRkcik7DQo+ICsJaW50IGVsZV9pZHggPSBub2RlX2dldF9lbGVt
ZW50X2lkeChub2RlLCBlbGVfYWRkcik7DQo+ICANCj4gIAlpZiAoZWxlX2lkeCA8IDApDQo+ICAJ
CXJldHVybiBNRVNIX1NUQVRVU19JTlZBTElEX0FERFJFU1M7DQo+IEBAIC0xNDU0LDcgKzE0NTQs
NyBAQCBpbnQgbWVzaF9tb2RlbF9zdWJfYWRkKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQx
Nl90IGVsZV9hZGRyLCB1aW50MzJfdCBpZCwNCj4gIAkJCQkJCQkJdWludDE2X3QgYWRkcikNCj4g
IHsNCj4gIAlzdHJ1Y3QgbWVzaF9tb2RlbCAqbW9kOw0KPiAtCWludCBzdGF0dXMsIGVsZV9pZHgg
PSBub2RlX2dldF9lbGVtZW50X2lkeChub2RlLCBhZGRyKTsNCj4gKwlpbnQgc3RhdHVzLCBlbGVf
aWR4ID0gbm9kZV9nZXRfZWxlbWVudF9pZHgobm9kZSwgZWxlX2FkZHIpOw0KPiAgDQo+ICAJaWYg
KGVsZV9pZHggPCAwKQ0KPiAgCQlyZXR1cm4gTUVTSF9TVEFUVVNfSU5WQUxJRF9BRERSRVNTOw0K
PiBAQCAtMTUxMCw3ICsxNTEwLDcgQEAgaW50IG1lc2hfbW9kZWxfc3ViX292cnQoc3RydWN0IG1l
c2hfbm9kZSAqbm9kZSwgdWludDE2X3QgZWxlX2FkZHIsIHVpbnQzMl90IGlkLA0KPiAgCQkJCQkJ
CQl1aW50MTZfdCBhZGRyKQ0KPiAgew0KPiAgCXN0cnVjdCBtZXNoX21vZGVsICptb2Q7DQo+IC0J
aW50IGVsZV9pZHggPSBub2RlX2dldF9lbGVtZW50X2lkeChub2RlLCBhZGRyKTsNCj4gKwlpbnQg
ZWxlX2lkeCA9IG5vZGVfZ2V0X2VsZW1lbnRfaWR4KG5vZGUsIGVsZV9hZGRyKTsNCj4gIA0KPiAg
CWlmIChlbGVfaWR4IDwgMCkNCj4gIAkJcmV0dXJuIE1FU0hfU1RBVFVTX0lOVkFMSURfQUREUkVT
UzsNCj4gQEAgLTE1NjcsNyArMTU2Nyw3IEBAIGludCBtZXNoX21vZGVsX3N1Yl9kZWwoc3RydWN0
IG1lc2hfbm9kZSAqbm9kZSwgdWludDE2X3QgZWxlX2FkZHIsIHVpbnQzMl90IGlkLA0KPiAgCQkJ
CQkJCQl1aW50MTZfdCBhZGRyKQ0KPiAgew0KPiAgCXN0cnVjdCBtZXNoX21vZGVsICptb2Q7DQo+
IC0JaW50IGVsZV9pZHggPSBub2RlX2dldF9lbGVtZW50X2lkeChub2RlLCBhZGRyKTsNCj4gKwlp
bnQgZWxlX2lkeCA9IG5vZGVfZ2V0X2VsZW1lbnRfaWR4KG5vZGUsIGVsZV9hZGRyKTsNCj4gIA0K
PiAgCWlmIChlbGVfaWR4IDwgMCkNCj4gIAkJcmV0dXJuIE1FU0hfU1RBVFVTX0lOVkFMSURfQURE
UkVTUzsNCj4gQEAgLTE2MjksMTAgKzE2MjksMTEgQEAgaW50IG1lc2hfbW9kZWxfdmlydF9zdWJf
ZGVsKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQxNl90IGVsZV9hZGRyLA0KPiAgCXJldHVy
biBNRVNIX1NUQVRVU19TVUNDRVNTOw0KPiAgfQ0KPiAgDQo+IC1pbnQgbWVzaF9tb2RlbF9zdWJf
ZGVsX2FsbChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBhZGRyLCB1aW50MzJfdCBp
ZCkNCj4gK2ludCBtZXNoX21vZGVsX3N1Yl9kZWxfYWxsKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUs
IHVpbnQxNl90IGVsZV9hZGRyLA0KPiArCQkJCQkJCQl1aW50MzJfdCBpZCkNCj4gIHsNCj4gIAlz
dHJ1Y3QgbWVzaF9tb2RlbCAqbW9kOw0KPiAtCWludCBlbGVfaWR4ID0gbm9kZV9nZXRfZWxlbWVu
dF9pZHgobm9kZSwgYWRkcik7DQo+ICsJaW50IGVsZV9pZHggPSBub2RlX2dldF9lbGVtZW50X2lk
eChub2RlLCBlbGVfYWRkcik7DQo+ICANCj4gIAlpZiAoZWxlX2lkeCA8IDApDQo+ICAJCXJldHVy
biBNRVNIX1NUQVRVU19JTlZBTElEX0FERFJFU1M7DQo+IGRpZmYgLS1naXQgYS9tZXNoL21vZGVs
LmggYi9tZXNoL21vZGVsLmgNCj4gaW5kZXggYTg4ZDI1ZDc3Li4xNDdhMDIyNzkgMTAwNjQ0DQo+
IC0tLSBhL21lc2gvbW9kZWwuaA0KPiArKysgYi9tZXNoL21vZGVsLmgNCj4gQEAgLTk4LDcgKzk4
LDggQEAgaW50IG1lc2hfbW9kZWxfc3ViX2RlbChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50
MTZfdCBlbGVfYWRkciwgdWludDMyX3QgaWQsDQo+ICBpbnQgbWVzaF9tb2RlbF92aXJ0X3N1Yl9k
ZWwoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgdWludDE2X3QgZWxlX2FkZHIsDQo+ICAJCQkJCXVp
bnQzMl90IGlkLCBjb25zdCB1aW50OF90ICpsYWJlbCwNCj4gIAkJCQkJdWludDE2X3QgKmFkZHIp
Ow0KPiAtaW50IG1lc2hfbW9kZWxfc3ViX2RlbF9hbGwoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwg
dWludDE2X3QgYWRkciwgdWludDMyX3QgaWQpOw0KPiAraW50IG1lc2hfbW9kZWxfc3ViX2RlbF9h
bGwoc3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgdWludDE2X3QgZWxlX2FkZHIsDQo+ICsJCQkJCQkJ
CXVpbnQzMl90IGlkKTsNCj4gIGludCBtZXNoX21vZGVsX3N1Yl9vdnJ0KHN0cnVjdCBtZXNoX25v
ZGUgKm5vZGUsIHVpbnQxNl90IGVsZV9hZGRyLCB1aW50MzJfdCBpZCwNCj4gIAkJCQkJCQkJdWlu
dDE2X3QgYWRkcik7DQo+ICBpbnQgbWVzaF9tb2RlbF92aXJ0X3N1Yl9vdnJ0KHN0cnVjdCBtZXNo
X25vZGUgKm5vZGUsIHVpbnQxNl90IGVsZV9hZGRyLA0K
