Return-Path: <SRS0=zBKN=5Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E43C43331
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 16:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 950BE20786
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Mar 2020 16:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="s/Slo60V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgCaQZn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:25:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:35239 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbgCaQZn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Mar 2020 12:25:43 -0400
IronPort-SDR: LAIXFq0NEz2mtq97W9CKwEX67cQNOTR90nBx5cRK5xlHz6YpDqE8vsgg5WdWFJPRynRibonFwH
 9wIGCgDpGgWQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 09:25:42 -0700
IronPort-SDR: cBStWZk3rXecKMcDOpmtzQ0gI6CumCTNF4u23pRkYxiCIvhJWQoSDI8G+dFX4ZAi+c0Aip8fXQ
 ao9V77JynvCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="249112449"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2020 09:25:42 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 09:25:41 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX113.amr.corp.intel.com (10.22.240.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 09:25:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 09:25:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTMkKdgqSWqOPIryW4tRT+Fz7Q2KlIAAX6f+Vp2gaG+ZHYSNA0+/BJ5W9uHojmBMLBDJDYIwvu3rwXeqaGMMybWIMvhMkkWfRkGE01EgKArMII4L8z5KEsK7Y8b7AS7BUD0uCkUeXZmT67zves3cpqsvne2WLgAELW85rliX7eCzKCPLatBF3++EQtdr7d21QEW3ObjTpJTo7iCT5w5FZN+Q5B4pKJfY0hZx6mL5PQ2JvEpg3cZYv35uQYlhvdp+YiCklcV9syTe+A57kaBuB80Mv95B8Aqnl6N+0QHECRjC8X+iGozw3KiSyRtqje+cJ9fnJ2vVfwriYRIfXQY9wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMg/OsxsTzvu9BVwab0Rv5m5f/C5rDRXorzNi3XCI64=;
 b=gHsfu9vsHBOu3+PHhcCnTvrxaIGpjn6PGd1EuJVqCmezgi5Wc2OwaHmQjB98tynd5I6zPECf/LRKlf7MyZaAx5tebaCBWKIiXNaCejGa9XluVQfdPHoxJ9lQFO7vWoNajqlzNipJ4DDsJLIsktKM2Q36I6QGoWxEhdlpoLQA61pxERaHLCWnRyW+tL4GEYLPJ2/X5h5bPCC9Fi//PN2joz8SR9IYAQGXQ4g+pf7ZFnQZAHs+oiL7w1SYJn+3DDZr+ijos0juPooyfMqwFJ6tqkfMs/BtzYLcRyf56OmENVaJMBAgp4f4xg0IJssvgcAmhzfiFukBa9trTNBIA5Owgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMg/OsxsTzvu9BVwab0Rv5m5f/C5rDRXorzNi3XCI64=;
 b=s/Slo60V6MCENJKxPbICbWbbr5i/aE6JhauiE9osez2+ZT4h5MxTfy0EAMF/N0HkEDHQG/r2izKbSoe0JE/r+iShvXQ5mk85VbddscEaQDHvnAfRFNVKrYCPQDqvZBJ+v973B6AI3JbtzJcMyjJPa1kZWYTvanIRfKyb7BF1kJA=
Received: from MWHPR11MB1423.namprd11.prod.outlook.com (2603:10b6:300:22::14)
 by MWHPR11MB1360.namprd11.prod.outlook.com (2603:10b6:300:26::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Tue, 31 Mar
 2020 16:25:39 +0000
Received: from MWHPR11MB1423.namprd11.prod.outlook.com
 ([fe80::d0f6:281b:de0a:36d1]) by MWHPR11MB1423.namprd11.prod.outlook.com
 ([fe80::d0f6:281b:de0a:36d1%5]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 16:25:39 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 1/6] tools/mesh-cfgclient: Display unprovisioned OOB
 data
Thread-Topic: [PATCH BlueZ 1/6] tools/mesh-cfgclient: Display unprovisioned
 OOB data
Thread-Index: AQHWBzZiR2O9woiS7kasiv6cHCqSiqhi45iA
Date:   Tue, 31 Mar 2020 16:25:39 +0000
Message-ID: <23e3c2f69cdb7685f24751e1b375d2ff2c6a6ed7.camel@intel.com>
References: <20200331082810.10856-1-michal.lowas-rzechonek@silvair.com>
         <20200331082810.10856-2-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200331082810.10856-2-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05a2aeb6-e50b-4f88-ffe3-08d7d59026ce
x-ms-traffictypediagnostic: MWHPR11MB1360:
x-microsoft-antispam-prvs: <MWHPR11MB136037050D46DB9BE004BC6BFBC80@MWHPR11MB1360.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1423.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(366004)(376002)(39860400002)(346002)(136003)(66446008)(26005)(71200400001)(6486002)(2906002)(76116006)(6512007)(5660300002)(186003)(66476007)(66946007)(66556008)(64756008)(2616005)(6506007)(8676002)(36756003)(86362001)(81156014)(316002)(478600001)(110136005)(8936002)(81166006);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2qlLkjWu6m9xzrXsBhWxNctmp5RPuqoyrTOTnV1dLG8/VDZne9a4U7Z9J1Sm6qwAir9qhC8DcLC9EUmck3WT/A19Pnq7YHx7jN4xWDau/dPjc4aBBrnaHbsWj75FZfUwrBKz1MZ9Zo0WepXNIZ0eB+q1HS4sUET98KgX6SNizwOJRbc7H6fBOI4YXV/PEkZnzgt3ePerIPMNCeTrEcmigoOFfzoF+PEiWFYpkD8bEL7zkxtKhD+Vi9FV0tlA3cNfdQJDV4JoYZvplhF80a8SKshmiCtCwpEk8KSkCzqhcKgrtAlBRiuQ9rbbQL7w6/1dJKGaGPwS0Cp8OycuI6RApfSWn1gIvJHwh+79j75uu/pIhZfLwtqW/mC2wORnlyeY42MSIc49TubYOM9Dtz1Iuvd4I33N4+jF4qIG2vhqDmhxHeo/40IEfU3xAArozUa7
x-ms-exchange-antispam-messagedata: gmuhcCdRKvHj1FT9wtAcSJITdchsXm87TsU9jPhS3G3XN+2fMs5mApeCgDKLI2HkT3EsHBF7qmeZUK3gIQhY8/WDmkiVe6ojzbHcONuGRLIIvPLxJGWtBrnXeWno+jHfZA2WwsMuGL00/CkU8tGn+A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AD0D3E478874245A8342CBD88E19B4D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 05a2aeb6-e50b-4f88-ffe3-08d7d59026ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 16:25:39.8242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MO/zlbncK04psCPNAxg3E7V2UWXNj2+NHG1zyEVx4+Vmr7FQn0kc86697skf/Jfc5sfvo0X/OP5H+0ywIaCGew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1360
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVHVlLCAyMDIwLTAzLTMxIGF0IDEwOjI4ICswMjAwLCBNaWNoYcWCIExvd2FzLVJ6ZWNob25l
ayB3cm90ZToNCj4gLS0tDQo+ICB0b29scy9tZXNoLWNmZ2NsaWVudC5jIHwgMTEgKysrKysrKysr
KysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvdG9vbHMvbWVzaC1jZmdjbGllbnQuYyBiL3Rvb2xzL21lc2gtY2ZnY2xpZW50LmMNCj4gaW5k
ZXggYWUxM2M0NDA5Li5lYWZhYmY4MjUgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gtY2ZnY2xp
ZW50LmMNCj4gKysrIGIvdG9vbHMvbWVzaC1jZmdjbGllbnQuYw0KPiBAQCAtMTUzMyw2ICsxNTMz
LDE3IEBAIHN0YXRpYyBzdHJ1Y3QgbF9kYnVzX21lc3NhZ2UgKnNjYW5fcmVzdWx0X2NhbGwoc3Ry
dWN0IGxfZGJ1cyAqZGJ1cywNCj4gIAlidF9zaGVsbF9wcmludGYoIlx0IiBDT0xPUl9HUkVFTiAi
VVVJRCA9ICVzXG4iIENPTE9SX09GRiwgc3RyKTsNCj4gIAlsX2ZyZWUoc3RyKTsNCj4gIA0KPiAr
CWlmIChuID49IDE4KSB7DQo+ICsJCXN0ciA9IGxfdXRpbF9oZXhzdHJpbmdfdXBwZXIocHJvdl9k
YXRhICsgMTYsIDIpOw0KPiArCQlidF9zaGVsbF9wcmludGYoIlx0IiBDT0xPUl9HUkVFTiAiT09C
ID0gJXNcbiIgQ09MT1JfT0ZGLCBzdHIpOw0KDQpsX3V0aWxfaGV4c3RyaW5nX3VwcGVyKCkgcmV0
dXJucyBhIG5ld2x5IGFsbG9jYXRlZCBzdHJpbmcuDQpsX2ZyZWUoc3RyKSBhZnRlciBpdCdzIG5v
IGxvbmdlciBuZWVkZWQuDQoNCj4gKwl9DQo+ICsNCj4gKwlpZiAobiA+PSAyMikgew0KPiArCQlz
dHIgPSBsX3V0aWxfaGV4c3RyaW5nX3VwcGVyKHByb3ZfZGF0YSArIDE4LCA0KTsNCj4gKwkJYnRf
c2hlbGxfcHJpbnRmKCJcdCIgQ09MT1JfR1JFRU4gIlVSSSBIYXNoID0gJXNcbiIgQ09MT1JfT0ZG
LA0KPiArCQkJCQkJCQkJc3RyKTsNCg0KbF91dGlsX2hleHN0cmluZ191cHBlcigpIHJldHVybnMg
YSBuZXdseSBhbGxvY2F0ZWQgc3RyaW5nLg0KbF9mcmVlKHN0cikgYWZ0ZXIgaXQncyBubyBsb25n
ZXIgbmVlZGVkLg0KDQo+ICsJfQ0KPiArDQo+ICAJLyogVE9ETzogSGFuZGxlIHRoZSByZXN0IG9m
IHByb3Zpc2lvbmluZyBkYXRhIGlmIHByZXNlbnQgKi8NCj4gIA0KPiAgCWRldiA9IGxfcXVldWVf
ZmluZChkZXZpY2VzLCBtYXRjaF9kZXZpY2VfdXVpZCwgcHJvdl9kYXRhKTsNCg==
