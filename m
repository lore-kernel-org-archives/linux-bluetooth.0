Return-Path: <SRS0=lMkY=B6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF74C433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 14:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A272A20738
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 14:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="FbQHYxJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgHTO31 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:29:27 -0400
Received: from mga18.intel.com ([134.134.136.126]:38139 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgHTO3Y (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Aug 2020 10:29:24 -0400
IronPort-SDR: iY85XEP/d8SlYoSqyyWtvgRmJNAjCnr9HFDY5SKK54V6VDq7KMv2sFn0dwH7Pf42hYpUjsRa72
 jf9dbMOEkKXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="142939559"
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="142939559"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 07:29:21 -0700
IronPort-SDR: NKXgLCZRzrq+ON+/sJMV5lQ+2+6VsrJXUxKac86OGrC1Y3c6URw0RD+vIG4VJIfNDko9E8tzDO
 MuaTisixAoeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="335020457"
Received: from fmsmsx603-2.cps.intel.com (HELO fmsmsx603.amr.corp.intel.com) ([10.18.84.213])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Aug 2020 07:29:21 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 07:29:20 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Aug 2020 07:29:20 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.59) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 20 Aug 2020 07:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1w+QKve8fIOnhJUhxiaMguZeulVNkSnz4K+uFIgjy1ZaWuH11q8zgVeSmfqZfPGk06YbmCPI2A2FHGq4UxmdWJlHe0Kz6+taozkop3qXKVvsHsbEKany2ETO+owJd7A49yedZ2Mu74JIequMl772P/Zx52Q2wZ0k1aeHHCGSg1Y2hh7ry5Cqx2U+GM0i1z1aFuVtsH+EPxHIsXXjhu+/zeRuVmFlPE1axomdgQ2cIi+NIA0xl1GQwGmnqXnIrf/XvBKVAJS9cYIxwlyXlREHK4ngV9IMDjl9+KEDVgNsUTaU06AQfmH3tn60cL0OrR5yzWwUGR6lgkuCnn1+keZrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QcuiS3Yvtdjl/w+bt+8JVF/h05tWp3FSA1BldGHkm0=;
 b=S1cbw476tTZE2BjvNsuSK6AXhPQzxgFXfJVQo2YgPrO3s1PS9DQ9heeT+cSBmo0PMwzqO50kmrYomk0oNpsDB7u+3f2rjiymK6eaacrIHNVGlNpknSw0t0HhzmOeBNhKXo5pPnmiOXJ6HoM4SWG0hzoonwKyVaVBkBZp6CIla8B6cINXV0rRCH/d+Ci6ofUOmC4Byao+sVK/8EQEe50K3hAwoIecj9CZj1WjxNFfAxvL5gxQWLnG+QtteokNTToEJmiSqAs9nmAKpbPPhiSqmZS66wScHs8q0jmBX3LsRpq7UHGpZDgiVf5M2rHr3e0kt1gnBNd+GVCFCjWy8l6tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QcuiS3Yvtdjl/w+bt+8JVF/h05tWp3FSA1BldGHkm0=;
 b=FbQHYxJE2+DEZiZJ/p37t/gUXTq3WjD1cTG61HHq1MIDdhbfn06cgWJDUpDqbIGKteFiZr4TiRZLBgqxuo6+ap+SVB5wV+nWR5L5Eab3qs1K13/Ex0jX52Qgm1/mGjKyqz9SoysXBgIOhUmXbcJuOKtPgzK/Jqa7Knx/bzjg3ko=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1376.namprd11.prod.outlook.com (2603:10b6:300:1d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 14:29:19 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 14:29:19 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Send correct NetKey index in
 DevKeyMessageReceived
Thread-Topic: [PATCH BlueZ] mesh: Send correct NetKey index in
 DevKeyMessageReceived
Thread-Index: AQHWdnJt0OW6VjSYpUyye6w14UAuwalBD6yA
Date:   Thu, 20 Aug 2020 14:29:18 +0000
Message-ID: <01cbff2b3bc7d6c7b97e75fa93e6444480fbf262.camel@intel.com>
References: <20200819214802.83756-1-inga.stotland@intel.com>
In-Reply-To: <20200819214802.83756-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6d96215-13c9-482b-52b8-08d845156c89
x-ms-traffictypediagnostic: MWHPR11MB1376:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB137661852780682C96D844C2E15A0@MWHPR11MB1376.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s6HlGvxKlZkjdy+WYcO5hrmbfJxo/SeznKNEYvXRN5iZOWVSf219Dh2+wavsXxmDqRZTDFIvMbIpNMulFUu3gXcR1YsXhaS7KADDJswfaLGJkw3WgL4HMLFFb8GEg0ip86L9OF+DzyOODpN3nTWoQtZfvYch46aihphUmuzCOReEv+dZBIrPI9tcqr9wm7ecBzcofJVrg/kxYpBH0lngGxLy/oSBFc8RONYKzXCxcZNZcIMAKg2YKcOlvSgfbaPVyVYa3o4OUgK7+Nl4rrusXS7kAiI3xMlOjM47s6X1S0VFkaguZlH5G0Ric3LtfUKmD/dBWG5tlaesUtP5KZGHMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(26005)(5660300002)(186003)(8676002)(66476007)(66946007)(6486002)(4744005)(66446008)(8936002)(64756008)(478600001)(2616005)(66556008)(6636002)(76116006)(91956017)(316002)(6512007)(110136005)(6506007)(83380400001)(2906002)(71200400001)(36756003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OIYWy8TDDSNltbp2HrdolLAUMs+jxpWlmQmJK7J5qg8UxpfvO/BDNOK++vBbAw+wM5sXa9H3vHWVzCftGx6nvZhmOJkZpGHyosttl89mLFRCoM/dAYOCK1dPQkYheTlmz8AxnVOHpmt5zPsTwAvzZaDAB+0axDG3ZVcDMawFeDBR4do5h9VxJj58c1zfTv7V+/IMbeVG28UOMS0LtN6uGESC1NQ1xDVdrlBwvb/472N4BMceVTWhC9LHe++7K2etOR0qGLaQ3fnSg6TogyQytFjEyZzAVQzsjZqKrl7IYF8bojFoZUTIvvsPausXW6APTIoueaYG/RlGbuijQL1OQ+NHKN3Cyq9D/y26c2hc4WTHklwqsHAFPp93GmXNLutQ6xCEC+bJY3GCKkXE0sAt4Yzauzk7nhxT2xOJZSn0QZnwd3RnPDmTuVwTs21/weGYLL4bFfFzeNpWJlq3mluvQVnVc1oDdFf2iSHTgiD4Aj61nOkcBtD8XmjdM2Llu3moYoekzrEdqdefPKKPU6pZEsufeHf5dBWjw0PKtmWjXnMAaY2VgwYgaOLiBrNXV7CfHY8PXyKEWXvnEDqYp0mXuPWfoM2SrYB8tKkyvOHlyB8uTjLQ4QsqeJbymrevo/9TyVcL3V2O/KBIFfzUuRu9SQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BCDF94F0545CE478A203F7B2417EE03@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d96215-13c9-482b-52b8-08d845156c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 14:29:19.0045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zb0ZN+i260vB9WrRYH4hObqMSrghnoPSTA33rFuQsAc0bJYW3b39r/8FAiDYfITWTzIja5KpGEqLCS3y6UW+xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1376
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTA4LTE5IGF0IDE0OjQ4IC0wNzAwLCBJbmdhIFN0b3RsYW5k
IHdyb3RlOg0KPiBUaGUgdmFsdWUgb2YgbmV0X2luZGV4IGluIERldktleU1lc3NhZ2VSZWNlaXZl
ZCgpIG1ldGhvZCBtdXN0IGJlIHNldA0KPiB0byB0aGUgdmFsdWUgb2YgYSBzdWJuZXQgaW5kZXgg
b24gd2hpY2ggYSBkZXZpY2Uga2V5IGVuY29kZWQgbWVzc2FnZQ0KPiBoYXMgYmVlbiByZWNlaXZl
ZC4gV2FzIGhhcmQgY29kZWQgdG8gMC4gRml4ZWQuDQo+IC0tLQ0KPiAgbWVzaC9tb2RlbC5jIHwg
MyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9tZXNoL21vZGVsLmMgYi9tZXNoL21vZGVsLmMNCj4gaW5kZXgg
YjQ0ZTJmNjY5Li45NTI5ZGZiMmUgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbW9kZWwuYw0KPiArKysg
Yi9tZXNoL21vZGVsLmMNCj4gQEAgLTk2NSw3ICs5NjUsOCBAQCBib29sIG1lc2hfbW9kZWxfcngo
c3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgYm9vbCBzem1pY3QsIHVpbnQzMl90IHNlcTAsDQo+ICAJ
CQllbHNlIGlmIChkZWNyeXB0X2lkeCA9PSBBUFBfSURYX0RFVl9SRU1PVEUgfHwNCj4gIAkJCQkg
ZGVjcnlwdF9pZHggPT0gQVBQX0lEWF9ERVZfTE9DQUwpDQo+ICAJCQkJc2VuZF9kZXZfa2V5X21z
Z19yY3ZkKG5vZGUsIGksIHNyYywgZGVjcnlwdF9pZHgsDQo+IC0JCQkJCQkwLCBmb3J3YXJkLnNp
emUsIGZvcndhcmQuZGF0YSk7DQo+ICsJCQkJCQkJbmV0X2lkeCwgZm9yd2FyZC5zaXplLA0KPiAr
CQkJCQkJCQlmb3J3YXJkLmRhdGEpOw0KPiAgCQl9DQo+ICANCj4gIAkJLyoNCg==
