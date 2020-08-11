Return-Path: <SRS0=5Aiy=BV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AFF5C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 14:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D8142076C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Aug 2020 14:45:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="yBWYKBm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgHKOpm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:45:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:42784 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728794AbgHKOpl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Aug 2020 10:45:41 -0400
IronPort-SDR: /VTP3db7TndUaGyVzSNud4vTAYpLcZJCnNcEUPcnCge9a2rf0d1swNdHAp0tcfHziM4yQ8P/Es
 YO+Qh1Y1Oa/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="133790179"
X-IronPort-AV: E=Sophos;i="5.76,461,1592895600"; 
   d="scan'208";a="133790179"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 07:45:40 -0700
IronPort-SDR: ZK/iLEJ15/2Gp89LmraZRB7ouSMYEKXHQSLCr9dEsvi6LOPiVZzxL6xUbfPd2PhyZO9IRfpsBZ
 GQUxcrPrMS7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,461,1592895600"; 
   d="scan'208";a="276311653"
Received: from orsmsx605-2.jf.intel.com (HELO ORSMSX605.amr.corp.intel.com) ([10.22.229.85])
  by fmsmga007.fm.intel.com with ESMTP; 11 Aug 2020 07:45:39 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 11 Aug 2020 07:45:39 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 11 Aug 2020 07:45:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 11 Aug 2020 07:45:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJhhmaQtWc2zJBHAEl52CK4oxqtDDYJWoIojfdcCu1LNQagFgt4w+1elwmw9FInD9WTv2ANCaBUPYNm9RBHTpceolczB8CQkOGCZ0fbEdNsWQCidTKo+gQSIE6qlNJeAf1u60dj+jPXjav9ku0J1ID/8zMfoO/bu6EDMlg5BSAcsB1aUsxe37jMVt0ivnmDf2uTXFz6c14mRa2VRI0vEW8Bpa5H5Y25SunMpHxMqVHo/323Lh9yGJRUF46QeLFICV+zbxKqvTS7dzyjUuOvk5yfrUlpPYm8dJALHdaUQ7EzkCEYS+b+uhP/IjxfJIduGVChuhSDB0C8+rlROdW0OhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku4Jzp8qaohDkLYr1wbrismdZI/3mj474AdX3srNSbg=;
 b=LCGqVwlDa+arRTR2oHhQbLaPOIE4ZltTQChH50ekxuHHte4Frarb/pemR07+wMh7C/93x6gv7WLXQ/mNUeKTxJ2MuLZMZnObkcwA6wWfJgnfKexul2VIPVRn2q/slRlG70OZ4TeFQy9r2FdeCm+ajGMPYlSCm0jSI1zUzo+UcdoHDnNEIqYQfFxMh27diNTuT9SrvFqzmTWW4ps2EANbF/aVEY9fHUMaVcPBZtTDul3xpEGKzxz1/xURZzhIyNp/sRP7KMkJyIeHrWnreaE4ZNlaQiRFxa7RM24iaAVi+2Atbdpggs3Ab6SDpvYle8muwF1rS8f43uRACQMyMIhzWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku4Jzp8qaohDkLYr1wbrismdZI/3mj474AdX3srNSbg=;
 b=yBWYKBm/5iubqGfAyPPgNEG9aaywOGONeCajgtl1KoLx9yGGch9QQ59XlTjTHfWlH2E/iT7IdsiGuuKky+2eeWN1g0dZqwTp/hah2Oa20BjwdUz4rhgzyjDTYjTV9APnS30prdPAk/g6qjI0iMfv9ogHv31vczaJBUYN/sCJ5CY=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1680.namprd11.prod.outlook.com (2603:10b6:301:d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Tue, 11 Aug
 2020 14:45:37 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 14:45:36 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix application key binding lookup
Thread-Topic: [PATCH BlueZ] mesh: Fix application key binding lookup
Thread-Index: AQHWb+Swk4oatecJNkO/IyZuZpxm2Kky/FqA
Date:   Tue, 11 Aug 2020 14:45:36 +0000
Message-ID: <98f53d6f9bf01499848b4409a9bca17ad2a7d173.camel@intel.com>
References: <20200811133907.8249-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200811133907.8249-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e40e385-c52e-4384-2f42-08d83e0535b6
x-ms-traffictypediagnostic: MWHPR11MB1680:
x-microsoft-antispam-prvs: <MWHPR11MB1680BAB488E0AF9B978236A6E1450@MWHPR11MB1680.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N4OaQZ+jqOVS1Vxm2qsCVtLwKAD2kBhfTfMiu30+9S6VqhXk+FLNxde6PXXK5qBxp13XnHM/2J76xfCDi9cGHeoVAYR9uIjy9DvACQHu9cwEVmhTVmmyspROZbZTFrBLWuyCkX28cj5fOKyU6mXCCaxyIBJSSu88p6sQJWd3X2Om82uAwzYO7MNaLGpbe7Ph2tL1YHIxejQfO0ist5PUoxQ/asbkwm03WUszpRi+KfDQYc4j16A8TSG26TWWu85XAdvcIII0yWEVAL1K+A51DH0P+LjtTlFPTXrJc/qjWtVJmLKASlXJTQECa2sjGlouAZ6pWftPrrZs+NfsGyty/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(66556008)(66476007)(66446008)(64756008)(66946007)(6512007)(8676002)(36756003)(71200400001)(86362001)(5660300002)(2906002)(91956017)(76116006)(8936002)(83380400001)(26005)(6506007)(316002)(6486002)(186003)(2616005)(478600001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jUmzG6q2L25/W4ZiQZFg9rJpG+SSSMmG1lIPXUgvcaP13T5LVoBg1MCj8EaZbbr3L2ylbMxdekxF6A4NQ+tDRgFBEVsm0jzShpQ7B9auIoif90MZx661EJNMdgQLzcHELRaFKzz8yOkzm1NgtkyBiqpLDNJGRf4pu/Za1cOapcnRc8JSavX+TkEi0+Pnz5Cl03rlJI5XNhHsJY1G1BfEkkW1Bek9aUpg6L1ujRV7JwZBiNxBQ0G4K/l+vvAVr/4vgGepN/iV8NP+rZIH0GmieAfcbwsdivBX/dCVhMzNDTEY5KxxgflaxbutsxOAM6BrTvJmk+U7P4Cvcl1XFg2IbYqeoodd0jifQiZYt5BaZR5FxvbDRkgZ8sH7UjS8htqQvymO1FwWCQFu28wG9eSA91xZwuDq/TWLMGHt5fEjvYqBR+gj6jARDGX4jMeghNlAWuaHWK/7ugD3Ouv9+HrwtowXouRsi3ccyfGAdaiQdUOzAhTaAC0XTxNnE9+IPuNSoW1qpwCicK4tjtrNAJilmuZBB4lTGCwwYZsNB5bHxK5cPraQVXuiDTI/cRFTyPmp62iMI4szwCNiWZ5XoYqw4jwBZuSa9pcY9Lwrto2FcsEj4w5UQpxQBWJZ1wBGdbcZ51PPyH9GSKxmJN3/YECEnA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB60050838811A43A70C00C8A1F71BE5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e40e385-c52e-4384-2f42-08d83e0535b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 14:45:36.8073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /RYTZMCsD3QL+F7A8TkTvCGK9Y4gWAo+e0DdHYZ4svWI52U4V0GNoAgP6HG2riZYFmu3k3GlqW0ginXunO2NjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1680
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzLg0KDQpPbiBUdWUsIDIwMjAtMDgtMTEgYXQgMTU6MzkgKzAyMDAsIE1p
Y2hhxYIgTG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBCZWNhdXNlIGxfcXVldWVfZmluZCBjYW4n
dCBkaXN0aW5ndWlzaCBiZXR3ZWVuIGVudHJ5LT5kYXRhIGVxdWFsIHRvIHplcm8NCj4gYW5kIG1p
c3NpbmcgZW50cnksIGhhc19iaW5kaW5nKCkgZmFpbHMgd2hlbiB3ZSBiaW5kIGFwcCBrZXkgd2l0
aCBpbmRleA0KPiAwLCB2aWEgTF9VSU5UX1RPX1BUUi4NCj4gDQo+IEJ1ZyBoYXMgYmVlbiBpbnRy
b2R1Y2VkIGluIGNvbW1pdCAxYTJhNmRlYmQNCj4gLS0tDQo+ICBtZXNoL21vZGVsLmMgfCAxMCAr
KysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9u
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tb2RlbC5jIGIvbWVzaC9tb2RlbC5jDQo+IGlu
ZGV4IDRlYWFkMzFiZS4uN2Q3ZjE1NTFhIDEwMDY0NA0KPiAtLS0gYS9tZXNoL21vZGVsLmMNCj4g
KysrIGIvbWVzaC9tb2RlbC5jDQo+IEBAIC0xNDAsNyArMTQwLDE1IEBAIHN0YXRpYyBib29sIHNp
bXBsZV9tYXRjaChjb25zdCB2b2lkICphLCBjb25zdCB2b2lkICpiKQ0KPiAgDQo+ICBzdGF0aWMg
Ym9vbCBoYXNfYmluZGluZyhzdHJ1Y3QgbF9xdWV1ZSAqYmluZGluZ3MsIHVpbnQxNl90IGlkeCkN
Cj4gIHsNCj4gLQlyZXR1cm4gbF9xdWV1ZV9maW5kKGJpbmRpbmdzLCBzaW1wbGVfbWF0Y2gsIExf
VUlOVF9UT19QVFIoaWR4KSkgIT0gTlVMTDsNCj4gKwkvKiBkb24ndCB1c2UgbF9xdWV1ZV9maW5k
LCBpdCBjYW4ndCBkaXN0aW5ndWlzaCBiZXR3ZWVuIG1pc3NpbmcgZW50cnkNCj4gKwkgKiBhbmQg
ZW50cnkgd2l0aCBkYXRhIGVxdWFsIHRvIE5VTEwgKi8NCj4gKwljb25zdCBzdHJ1Y3QgbF9xdWV1
ZV9lbnRyeSAqZW50cnk7DQo+ICsNCj4gKwlmb3IgKGVudHJ5ID0gbF9xdWV1ZV9nZXRfZW50cmll
cyhiaW5kaW5ncyk7IGVudHJ5OyBlbnRyeSA9IGVudHJ5LT5uZXh0KQ0KPiArCQlpZiAoTF9QVFJf
VE9fSU5UKGVudHJ5LT5kYXRhKSA9PSBpZHgpDQo+ICsJCQlyZXR1cm4gdHJ1ZTsNCj4gKw0KPiAr
CXJldHVybiBmYWxzZTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIGJvb2wgZmluZF92aXJ0X2J5X2xh
YmVsKGNvbnN0IHZvaWQgKmEsIGNvbnN0IHZvaWQgKmIpDQo=
