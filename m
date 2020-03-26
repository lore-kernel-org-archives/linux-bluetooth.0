Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DA5C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 17:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A9C2073E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 17:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="iQ3OvL/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbgCZRCB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:02:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:49664 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbgCZRCA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 13:02:00 -0400
IronPort-SDR: G4+6Ey0FV1ON7ilcR6ILq7M/gI9cCXXDeEpqP3jj9ijozU4UJzsGoH+EAGLQw+33794yYqiEEl
 FbtszIJlqMYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 10:01:59 -0700
IronPort-SDR: /AzGbU3pZsOReafMpIw6fclzKwednYsNBC34iJGeBfFVmUqcWF8k96w4vCReLHI8o7KitIVqNF
 iqou1dzBCZYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,309,1580803200"; 
   d="scan'208";a="448699983"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga006.fm.intel.com with ESMTP; 26 Mar 2020 10:01:59 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 26 Mar 2020 10:01:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 10:01:58 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 10:01:58 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.54) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 26 Mar 2020 10:01:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kikXX7b8j82TmRMrFSmkdVQNioNveMF7owJQXg+oVZWI6SzivSOkZdlY1Qvd25aBXgtHj9+PDfBPiWZ3JKmSILPF8RwKgqDgPp1GKdCiHGKe8nSepUurjYi2H17LkG1uAGUMoAH09djLq9ONmgPiH+meBkjqDchcIv2xA2dajN/8EW3Q5Shycx2+TYctD8SPQ5/8VqANif4C0w+E3qk8/9hRO/Xq0ooMQ0+5z+lIKn0mWBI6K4pS1gGf9O7gy6VhKd2l5SbCEdbuiXKQj5KYFFd3bVlB4zMVwVqblK6u3dy+AMhv6BPz/WuirCB6lPCsf25vI0qP0yg7bjD6iVdDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m56cqWgT0nZOVf2AJT3F1BZnY9Pw2qC2SREeAB3YA3w=;
 b=WcwfKMut2ZCb2Sk96/zP0W6G5xZm2jDazM9F6GvdvhKjWQU8+07wnCPzIxHSyUCSWUd+dxUcdmHs/bBG+ZQPPzedB8WKKOV4k+8uDddqAt9d1pHXMjD8igde7VSwBM9a3hompo2WNnFFg3o0xv7e8hHzNn/NUcfZ2wSreQOnU1jE6S8ImBonr56+cn4+1Gnwu/lwpA1hip4sQOn7G9oecGgtJOMLiPTYDe1bFV+eOclmF1oWFpb0Uv9Lq8pFzJju3DgokpnXsADYZ6RsPpiPxk8x/nBXl1P4pEki09gnLE6Jq8ibWVQcr/IsnNH1IrcWF2i2Pncy6LilAI+Y+EqsZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m56cqWgT0nZOVf2AJT3F1BZnY9Pw2qC2SREeAB3YA3w=;
 b=iQ3OvL/+dsbcs1ED+qSSkKoKYc+k0XOcCHmXbWN/TNv0v8+XzObLata2O2xh73OWHG9QBfXJPrFmeU2QtJJgtS+sQe9W1S3qt6MBtbpMyg5+z4S/DSctXmvqWgPjPCP2ocQGCYiba6TrCC3JhlKeSziAgHHjEPc5+NcDcav20uE=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4537.namprd11.prod.outlook.com (2603:10b6:303:5d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 26 Mar
 2020 17:01:46 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Thu, 26 Mar 2020
 17:01:46 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix model publication status after set
Thread-Topic: [PATCH BlueZ] mesh: Fix model publication status after set
Thread-Index: AQHWAu9Ehzx6DchsZEeU6yDOfOlnQKhbGpaA
Date:   Thu, 26 Mar 2020 17:01:46 +0000
Message-ID: <a4c9a24aec16adda445cde4ecd25d7681b662444.camel@intel.com>
References: <20200325214847.67394-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200325214847.67394-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43a9df48-fe84-4c71-fb05-08d7d1a75e0e
x-ms-traffictypediagnostic: MW3PR11MB4537:
x-microsoft-antispam-prvs: <MW3PR11MB453751C327842A7AA32F08B4E1CF0@MW3PR11MB4537.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(366004)(376002)(136003)(346002)(4744005)(478600001)(316002)(8936002)(110136005)(86362001)(5660300002)(6486002)(6512007)(64756008)(36756003)(26005)(81166006)(186003)(8676002)(81156014)(76116006)(91956017)(66446008)(66556008)(66476007)(66946007)(2616005)(2906002)(71200400001)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4537;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZxxgaQIWuTsPectGhydtECdP3WElhsow+QWS4qUBhUXMZeta/p5ZtV1Pobzy6CwezJb9rNWboUmcPooj1ZR4gEIE6+0Vwi5YNZj81QDiAjwltRy+B8i01zF0BVyduLENpbkmpF8Z/Cr2xpSL0i+nnrVYuTs9cd7+/en71imCmNktf94WAjqzVZM4H3C3TbBPPAV9WDXADLGRT9eDlh7Rj8c8T+c97jmIpKeRbEFcg1m5OChAZYme+hbAMSu5Ez7YsXQmXJRilUDg2LdlcRaVxCyDTiRh5My935b/GXWpnG0aCc5XeawSZDz5oAYbABGj6htB66WPxtX/XbFrubEthwUlsLWI2qTJuO02XVlpDe1znt/2hdYt76Mh/qcIZLGvP3o4cR1nE3CtSOxRsh8KjJZ79jk5xm8vQZTO9zaImRZFpY7x+dSHDjeIUyq54958
x-ms-exchange-antispam-messagedata: Dy2/6y1sZuQlswA744xgfGiHZEG2uL6IRJm4+mNBtY74wLi0AKiC6l7Ah0Tz9R9Zr54F6q7af6MNp+UZAo0imRjENQ9luCEg17V62f0Jf8IrNx0Az1OzpFOnVIM74fotL0bdU32XC9fd7rDM0wOuow==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B295839C38EF1A4581AE994D29CBF7FE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a9df48-fe84-4c71-fb05-08d7d1a75e0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 17:01:46.2056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uWYh0iGKZzMi7hdhePlIzog24fF8KEQ6i86tJlFnvo4uRLzShVK1NE+Z0Yi+1AJ3kzgLZoizO5badsJticvjZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4537
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAzLTI1IGF0IDIyOjQ4ICswMTAwLCBNaWNoYcWCIExvd2Fz
LVJ6ZWNob25layB3cm90ZToNCj4gVGhpcyBwYXRjaCBmaXhlcyB1c2FnZSBvZiBzZW5kX3B1Yl9z
dGF0dXMoKSB3aGVuIGhhbmRsaW5nIHB1YmxpY2F0aW9uDQo+IHNldCBtZXNzYWdlIC0gbW9kX2lk
IHdhcyBzd2FwcGVkIHdpdGggcHViX2FkZHIsIHJlc3VsdGluZyBpbiBtYWxmb3JtZWQNCj4gbWVz
c2FnZSBiZWluZyBzZW50IGJhY2sgdG8gdGhlIENvbmZpZyBDbGllbnQuDQo+IC0tLQ0KPiAgbWVz
aC9jZmdtb2Qtc2VydmVyLmMgfCA0ICsrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9jZmdtb2Qtc2Vy
dmVyLmMgYi9tZXNoL2NmZ21vZC1zZXJ2ZXIuYw0KPiBpbmRleCBjNWM3NTZhMzMuLjg1NmViNmIy
NyAxMDA2NDQNCj4gLS0tIGEvbWVzaC9jZmdtb2Qtc2VydmVyLmMNCj4gKysrIGIvbWVzaC9jZmdt
b2Qtc2VydmVyLmMNCj4gQEAgLTE4NSw4ICsxODUsOCBAQCBzdGF0aWMgdm9pZCBjb25maWdfcHVi
X3NldChzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCBuZXRfaWR4LA0KPiAgCX0NCj4g
IA0KPiAgCWlmICghdW5yZWxpYWJsZSkNCj4gLQkJc2VuZF9wdWJfc3RhdHVzKG5vZGUsIG5ldF9p
ZHgsIHNyYywgZHN0LCBzdGF0dXMsIGVsZV9hZGRyLCBvdGEsDQo+IC0JCQltb2RfaWQsIGlkeCwg
Y3JlZF9mbGFnLCB0dGwsIHBlcmlvZCwgcmV0cmFuc21pdCk7DQo+ICsJCXNlbmRfcHViX3N0YXR1
cyhub2RlLCBuZXRfaWR4LCBzcmMsIGRzdCwgc3RhdHVzLCBlbGVfYWRkciwNCj4gKwkJCW1vZF9p
ZCwgb3RhLCBpZHgsIGNyZWRfZmxhZywgdHRsLCBwZXJpb2QsIHJldHJhbnNtaXQpOw0KPiAgfQ0K
PiAgDQo+ICBzdGF0aWMgdm9pZCBzZW5kX3N1Yl9zdGF0dXMoc3RydWN0IG1lc2hfbm9kZSAqbm9k
ZSwgdWludDE2X3QgbmV0X2lkeCwNCg==
