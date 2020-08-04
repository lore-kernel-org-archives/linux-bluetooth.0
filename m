Return-Path: <SRS0=ZUSg=BO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759DCC433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 16:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515792177B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Aug 2020 16:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="rbHIQsMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgHDQUE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Aug 2020 12:20:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:7993 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729516AbgHDQT5 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Aug 2020 12:19:57 -0400
IronPort-SDR: wQ4ngPwB5GQY+JhkLWhk1lxPGaBrwr74BZmfoRkXAgBVqnlvbVaCB9cXXaFpYVhvfxGnKSNojX
 wjMY5kPgCxuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9703"; a="131912007"
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="131912007"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 09:19:55 -0700
IronPort-SDR: WpYqCRe08bmPZ0/a6Dz/yXUjbnoN1FB7wuadPLM+5jUxjdSe34LM/RycFVtSPVQuq6WlF+eH5e
 sD5iPz046wOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,434,1589266800"; 
   d="scan'208";a="275846834"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 04 Aug 2020 09:19:55 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 4 Aug 2020 09:19:54 -0700
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 4 Aug 2020 09:19:54 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 4 Aug 2020 09:19:54 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.52) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 4 Aug 2020 09:19:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HOLNeRonXzI9UQkEKtTi+GiUJjXx7Ky1H/gGkXkGd9rSvDwiACITkWFoaDVFeGBh7ZvBmKPwQek9mdPQ7SX6GjdrI+HSC3InH8Lq2Z7/DdGurlckkR6W+ss/kS2/y4PPSDgJ+p2U6ZJwUiyEt7rjQOpoXTxTMM3QYejzt+tv+7ir5Nfm94fkM1WMcDtLwVkOMYIFvBbyKS7RpR9bmpKSc5JC40vd33o1PjiNSLDlNPPpSW00hAqjG7/oqDrbHtlNxVPEv57bgeKEnjE0jaJTh8A8ezZ/cdkwBMKci/+hJ3xMr5GRx4NK+QVVe/DnpCA5Ij8nlgRNIsjc5uxncQjMGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyQUc9baQTwRuc/fnGTTMP9M4QrawMz/v8ZWOOA3mtE=;
 b=FfTZjuhJVIwosU/c77nnRnX7ral9J7QnHeWEG8LWauw/Dm0Qbt0GRg7YvpWs17Zyebl8kKtYJoxjxUqqvhuzmRDkdAX8tjwIBF3wVfht6Advfdp//+wKTO0tTRjf+k+o8BU2C+4GFguSUnpD0EoHAYw/8pRtqJ4YZRfOV4A6RSqC0Do30Y5zpHP6q6Hx6f2y0S0ZFDajlcd47HD0SXN9iErHFEcZneTRAwN4arCyjGY5N0kK9rR/Ku7iRJJu0b4Lj/v4tVi7z1Xp6gnjtUqasiOqMLItOX7+piKWexl5oLvITSx7SXSo3s501O8Dr21g0oYjE7QbXdkpu1GSFcol+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyQUc9baQTwRuc/fnGTTMP9M4QrawMz/v8ZWOOA3mtE=;
 b=rbHIQsMnN6Grksq7ID7UyqkvMj+IUsHO/KWS2j0mkU0KvpqqrkpDPSKxz7InAUS3Y+S6mwloPVWIWAMb0UmHFLVfzy2+6JQpFCJ4M3oAwjVgaR431VtzasNk2SejXrKK1Tx368pqH9VPtoMGuMiWGyLPlwrFSRNIt9iTsCs4WS4=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4537.namprd11.prod.outlook.com (2603:10b6:303:5d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Tue, 4 Aug
 2020 16:19:51 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 16:19:51 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "mike@mnmoran.org" <mike@mnmoran.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v3] mesh: Add strings for SIG Model IDs
Thread-Topic: [PATCH BlueZ v3] mesh: Add strings for SIG Model IDs
Thread-Index: AQHWaneRD4JU0jbrQkOP4vmnV3fyD6koITgA
Date:   Tue, 4 Aug 2020 16:19:51 +0000
Message-ID: <d71503cbdc789b59f152794b9d015c4b1cae8fdf.camel@intel.com>
References: <20200804155404.1086789-1-mike@mnmoran.org>
In-Reply-To: <20200804155404.1086789-1-mike@mnmoran.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: mnmoran.org; dkim=none (message not signed)
 header.d=none;mnmoran.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38c20645-099a-4581-ab9f-08d838923758
x-ms-traffictypediagnostic: MW3PR11MB4537:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45373D8114CC48B871452548E14A0@MW3PR11MB4537.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:17;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZOCrY7Jbl+Qv0yE6aLwYCK5IUaSSrTeyU6mdaU3txyH+CUxVHSHCB8lJf/+MAncYCaep6FQQB3zuQ3nD+y4MfHIpBnSY5k2811yN31HJrl7MPa7V11p9SlkV+pQsJod1T4+3mwhRzLJuHNYXDDpaV5P4jtp5IhAFWlpkt8/BvHEh35mJVt2DyPyeRNYjqASG/UQuzf6yrNYDrOirMeqABtHHyC9f68YWDz7s1taRbzqepjkBSUD/D9oTcerJeLsmfE5CEJYZWT9pzEwBgk8XJK4sXrJd55SQRmxao5RYUlf8iMMLkBqfoeAqf7lkQtqdF1HW10LXNzIb4xCJ8M9YKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(39860400002)(396003)(346002)(5660300002)(2616005)(6512007)(66946007)(86362001)(66446008)(83380400001)(66476007)(76116006)(66556008)(91956017)(36756003)(64756008)(71200400001)(8676002)(6486002)(110136005)(316002)(2906002)(4326008)(478600001)(107886003)(6506007)(26005)(8936002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jgFXaam5sB1jug/42MyOnqWiAJ+YtYnJ/3s7AJsTZ/feojk6lCgplEEr/p/CpbDLbem38cdi/luj/5Z1ukpZDC8gBfpRFs/Fzp/WKqw2oqZruHB3bDLXThKk+VFWa6bY6BP6c091HvRV0Nyik1mnRS8N/AQb0++5SSb1DF2VDOELFZmonZe6jRKSKUhq4hgkmrH+go470oksnLqPfCG2W4Fc0FQvN9pZLvBMRPlOka7CRdigto6jJ2j/k+wXMbjvGjDyEpx9Fg46YbCMizzQQynJ4rKMfWFaDEOEBawIcsi05Ey92a0/PSOY85IFT3PYyf0QAqLJr0Et9RLJQTXe2QUVERy5e2se5Bo7w2k+5XNC7IhQEJU8W6iCpHynOjdsnZqFReStJr/IL8EnvnJ42uWFZXV3hvqHjhJAP7VKXUIQgo35ma0gFGzQU3tbnqan4DnjejiMa5cBrVzpG1x/aFlnyBL9p++Wj9xpgR3jkUhXAmctpQ9+JIlet/6UyQ2+OnWm8o2w45ODbcAVWx5Wrpsy2kRyUDS66pXiugLxeoLms7sFafbkTugXEGOUoYHvUIhdzbwg7m+jNg8IZCjTvGlCeAe9G9g14Jt7/G2QdUCClJxunTHO3Cp1prObWWz+D4WMW4LIo7fyYvgi4C/Y1g==
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B774D7A359EE24D82EBAA3ADBE875B8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c20645-099a-4581-ab9f-08d838923758
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 16:19:51.6559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LIAWNJkH70CWAWDuQIOlD5mZUbwt4Z8xE33EJKFMoGxxRcPs3/CUOKGakXwF33k2BWFe4hqfG6KFo9duUp2m3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4537
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQpBcHBsaWVkIHdpdGggZm9sbG93aW5nIHdoaXRlc3BhY2Ugc3R5bGUgZ3VpZGUgZml4ZXM6DQoN
CjgwIGNoYXJhY3RvciB2aW9sYXRpb25zIGF0Og0KdG9vbHMvbWVzaC9jZmdjbGkuYzoyNjcNCnRv
b2xzL21lc2gvcmVtb3RlLmM6Mjk4DQoNCmluY29ycmVjdCBUQUIgaW4gc2lnX21vZGVsX3N0cmlu
ZygpIHByb3RvdHlwZQ0KdG9vbHMvbWVzaC91dGlsLmM6MTQyDQp0b29scy9tZXNoL3V0aWwuaDoz
MA0KDQpPbiBUdWUsIDIwMjAtMDgtMDQgYXQgMTE6NTQgLTA0MDAsIE1pY2hhZWwgTi4gTW9yYW4g
d3JvdGU6DQo+IC0tLQ0KPiAgdG9vbHMvbWVzaC9jZmdjbGkuYyB8ICAzICsrLQ0KPiAgdG9vbHMv
bWVzaC9yZW1vdGUuYyB8ICA1ICsrLS0NCj4gIHRvb2xzL21lc2gvdXRpbC5jICAgfCA2NCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIHRvb2xzL21lc2gv
dXRpbC5oICAgfCAgMSArDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvbWVzaC9jZmdjbGkuYyBiL3Rv
b2xzL21lc2gvY2ZnY2xpLmMNCj4gaW5kZXggZTM2YzhkY2E1Li4zNTFmNDBhZDAgMTAwNjQ0DQo+
IC0tLSBhL3Rvb2xzL21lc2gvY2ZnY2xpLmMNCj4gKysrIGIvdG9vbHMvbWVzaC9jZmdjbGkuYw0K
PiBAQCAtMjYzLDcgKzI2Myw4IEBAIHN0YXRpYyB1aW50MzJfdCBwcmludF9tb2RfaWQodWludDhf
dCAqZGF0YSwgYm9vbCB2ZW5kb3IsIGNvbnN0IGNoYXIgKm9mZnNldCkNCj4gIA0KPiAgCWlmICgh
dmVuZG9yKSB7DQo+ICAJCW1vZF9pZCA9IGdldF9sZTE2KGRhdGEpOw0KPiAtCQlidF9zaGVsbF9w
cmludGYoIiVzTW9kZWwgSURcdCU0LjR4XG4iLCBvZmZzZXQsIG1vZF9pZCk7DQo+ICsJCWJ0X3No
ZWxsX3ByaW50ZigiJXNNb2RlbCBJRFx0JTQuNHggXCIlc1wiXG4iLA0KPiArCQkJCQkJCW9mZnNl
dCwgbW9kX2lkLCBzaWdfbW9kZWxfc3RyaW5nKG1vZF9pZCkpOw0KPiAgCQltb2RfaWQgPSBWRU5E
T1JfSURfTUFTSyB8IG1vZF9pZDsNCj4gIAl9IGVsc2Ugew0KPiAgCQltb2RfaWQgPSBnZXRfbGUx
NihkYXRhICsgMik7DQo+IGRpZmYgLS1naXQgYS90b29scy9tZXNoL3JlbW90ZS5jIGIvdG9vbHMv
bWVzaC9yZW1vdGUuYw0KPiBpbmRleCBjNzRmMGJlYzEuLjIwNjg4NWMwNyAxMDA2NDQNCj4gLS0t
IGEvdG9vbHMvbWVzaC9yZW1vdGUuYw0KPiArKysgYi90b29scy9tZXNoL3JlbW90ZS5jDQo+IEBA
IC0zMCw2ICszMCw3IEBADQo+ICAjaW5jbHVkZSAidG9vbHMvbWVzaC9rZXlzLmgiDQo+ICAjaW5j
bHVkZSAidG9vbHMvbWVzaC9tZXNoLWRiLmgiDQo+ICAjaW5jbHVkZSAidG9vbHMvbWVzaC9yZW1v
dGUuaCINCj4gKyNpbmNsdWRlICJ0b29scy9tZXNoL3V0aWwuaCINCj4gIA0KPiAgI2RlZmluZSBh
YnNfZGlmZihhLCBiKSAoKGEpID4gKGIpID8gKGEpIC0gKGIpIDogKGIpIC0gKGEpKQ0KPiAgDQo+
IEBAIC0yOTMsOCArMjk0LDggQEAgc3RhdGljIHZvaWQgcHJpbnRfbW9kZWwodm9pZCAqbW9kZWws
IHZvaWQgKnVzZXJfZGF0YSkNCj4gIA0KPiAgCWlmIChtb2RfaWQgPj0gVkVORE9SX0lEX01BU0sp
IHsNCj4gIAkJbW9kX2lkICY9IH5WRU5ET1JfSURfTUFTSzsNCj4gLQkJYnRfc2hlbGxfcHJpbnRm
KCJcdFx0XHQiIENPTE9SX0dSRUVOICJTSUcgbW9kZWw6ICU0LjR4XG4iDQo+IC0JCQkJCQkJQ09M
T1JfT0ZGLCBtb2RfaWQpOw0KPiArCQlidF9zaGVsbF9wcmludGYoIlx0XHRcdCIgQ09MT1JfR1JF
RU4gIlNJRyBtb2RlbDogJTQuNHggXCIlc1wiXG4iDQo+ICsJCQkJCQkJQ09MT1JfT0ZGLCBtb2Rf
aWQsIHNpZ19tb2RlbF9zdHJpbmcobW9kX2lkKSk7DQo+ICAJCXJldHVybjsNCj4gIAl9DQo+ICAN
Cj4gZGlmZiAtLWdpdCBhL3Rvb2xzL21lc2gvdXRpbC5jIGIvdG9vbHMvbWVzaC91dGlsLmMNCj4g
aW5kZXggNzE3NmNjNTYyLi44MmU0YzlhZDIgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL21lc2gvdXRp
bC5jDQo+ICsrKyBiL3Rvb2xzL21lc2gvdXRpbC5jDQo+IEBAIC0xMzgsMyArMTM4LDY3IEBAIHZv
aWQgc3dhcF91MjU2X2J5dGVzKHVpbnQ4X3QgKnUyNTYpDQo+ICAJCXUyNTZbaV0gXj0gdTI1Nlsz
MSAtIGldOw0KPiAgCX0NCj4gIH0NCj4gKw0KPiArY29uc3QgY2hhcgkqc2lnX21vZGVsX3N0cmlu
Zyh1aW50MTZfdCBzaWdfbW9kZWxfaWQpDQo+ICt7DQo+ICsJc3dpdGNoIChzaWdfbW9kZWxfaWQp
IHsNCj4gKwljYXNlIDB4MDAwMDogcmV0dXJuICJDb25maWd1cmF0aW9uIFNlcnZlciI7DQo+ICsJ
Y2FzZSAweDAwMDE6IHJldHVybiAiQ29uZmlndXJhdGlvbiBDbGllbnQiOw0KPiArCWNhc2UgMHgw
MDAyOiByZXR1cm4gIkhlYWx0aCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgwMDAzOiByZXR1cm4gIkhl
YWx0aCBDbGllbnQiOw0KPiArCWNhc2UgMHgxMDAwOiByZXR1cm4gIkdlbmVyaWMgT25PZmYgU2Vy
dmVyIjsNCj4gKwljYXNlIDB4MTAwMTogcmV0dXJuICJHZW5lcmljIE9uT2ZmIENsaWVudCI7DQo+
ICsJY2FzZSAweDEwMDI6IHJldHVybiAiR2VuZXJpYyBMZXZlbCBTZXJ2ZXIiOw0KPiArCWNhc2Ug
MHgxMDAzOiByZXR1cm4gIkdlbmVyaWMgTGV2ZWwgQ2xpZW50IjsNCj4gKwljYXNlIDB4MTAwNDog
cmV0dXJuICJHZW5lcmljIERlZmF1bHQgVHJhbnNpdGlvbiBUaW1lIFNlcnZlciI7DQo+ICsJY2Fz
ZSAweDEwMDU6IHJldHVybiAiR2VuZXJpYyBEZWZhdWx0IFRyYW5zaXRpb24gVGltZSBDbGllbnQi
Ow0KPiArCWNhc2UgMHgxMDA2OiByZXR1cm4gIkdlbmVyaWMgUG93ZXIgT25PZmYgU2VydmVyIjsN
Cj4gKwljYXNlIDB4MTAwNzogcmV0dXJuICJHZW5lcmljIFBvd2VyIE9uT2ZmIFNldHVwIFNlcnZl
ciI7DQo+ICsJY2FzZSAweDEwMDg6IHJldHVybiAiR2VuZXJpYyBQb3dlciBPbk9mZiBDbGllbnQi
Ow0KPiArCWNhc2UgMHgxMDA5OiByZXR1cm4gIkdlbmVyaWMgUG93ZXIgTGV2ZWwgU2VydmVyIjsN
Cj4gKwljYXNlIDB4MTAwQTogcmV0dXJuICJHZW5lcmljIFBvd2VyIExldmVsIFNldHVwIFNlcnZl
ciI7DQo+ICsJY2FzZSAweDEwMEI6IHJldHVybiAiR2VuZXJpYyBQb3dlciBMZXZlbCBDbGllbnQi
Ow0KPiArCWNhc2UgMHgxMDBDOiByZXR1cm4gIkdlbmVyaWMgQmF0dGVyeSBTZXJ2ZXIiOw0KPiAr
CWNhc2UgMHgxMDBEOiByZXR1cm4gIkdlbmVyaWMgQmF0dGVyeSBDbGllbnQiOw0KPiArCWNhc2Ug
MHgxMDBFOiByZXR1cm4gIkdlbmVyaWMgTG9jYXRpb24gU2VydmVyIjsNCj4gKwljYXNlIDB4MTAw
RjogcmV0dXJuICJHZW5lcmljIExvY2F0aW9uIFNldHVwIFNlcnZlciI7DQo+ICsJY2FzZSAweDEw
MTA6IHJldHVybiAiR2VuZXJpYyBMb2NhdGlvbiBDbGllbnQiOw0KPiArCWNhc2UgMHgxMDExOiBy
ZXR1cm4gIkdlbmVyaWMgQWRtaW4gUHJvcGVydHkgU2VydmVyIjsNCj4gKwljYXNlIDB4MTAxMjog
cmV0dXJuICJHZW5lcmljIE1hbnVmYWN0dXJlciBQcm9wZXJ0eSBTZXJ2ZXIiOw0KPiArCWNhc2Ug
MHgxMDEzOiByZXR1cm4gIkdlbmVyaWMgVXNlciBQcm9wZXJ0eSBTZXJ2ZXIiOw0KPiArCWNhc2Ug
MHgxMDE0OiByZXR1cm4gIkdlbmVyaWMgQ2xpZW50IFByb3BlcnR5IFNlcnZlciI7DQo+ICsJY2Fz
ZSAweDEwMTU6IHJldHVybiAiR2VuZXJpYyBQcm9wZXJ0eSBDbGllbnQiOw0KPiArCWNhc2UgMHgx
MTAwOiByZXR1cm4gIlNlbnNvciBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMTAxOiByZXR1cm4gIlNl
bnNvciBTZXR1cCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMTAyOiByZXR1cm4gIlNlbnNvciBDbGll
bnQiOw0KPiArCWNhc2UgMHgxMjAwOiByZXR1cm4gIlRpbWUgU2VydmVyIjsNCj4gKwljYXNlIDB4
MTIwMTogcmV0dXJuICJUaW1lIFNldHVwIFNlcnZlciI7DQo+ICsJY2FzZSAweDEyMDI6IHJldHVy
biAiVGltZSBDbGllbnQiOw0KPiArCWNhc2UgMHgxMjAzOiByZXR1cm4gIlNjZW5lIFNlcnZlciI7
DQo+ICsJY2FzZSAweDEyMDQ6IHJldHVybiAiU2NlbmUgU2V0dXAgU2VydmVyIjsNCj4gKwljYXNl
IDB4MTIwNTogcmV0dXJuICJTY2VuZSBDbGllbnQiOw0KPiArCWNhc2UgMHgxMjA2OiByZXR1cm4g
IlNjaGVkdWxlciBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMjA3OiByZXR1cm4gIlNjaGVkdWxlciBT
ZXR1cCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMjA4OiByZXR1cm4gIlNjaGVkdWxlciBDbGllbnQi
Ow0KPiArCWNhc2UgMHgxMzAwOiByZXR1cm4gIkxpZ2h0IExpZ2h0bmVzcyBTZXJ2ZXIiOw0KPiAr
CWNhc2UgMHgxMzAxOiByZXR1cm4gIkxpZ2h0IExpZ2h0bmVzcyBTZXR1cCBTZXJ2ZXIiOw0KPiAr
CWNhc2UgMHgxMzAyOiByZXR1cm4gIkxpZ2h0IExpZ2h0bmVzcyBDbGllbnQiOw0KPiArCWNhc2Ug
MHgxMzAzOiByZXR1cm4gIkxpZ2h0IENUTCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzA0OiByZXR1
cm4gIkxpZ2h0IENUTCBTZXR1cCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzA1OiByZXR1cm4gIkxp
Z2h0IENUTCBDbGllbnQiOw0KPiArCWNhc2UgMHgxMzA2OiByZXR1cm4gIkxpZ2h0IENUTCBUZW1w
ZXJhdHVyZSBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzA3OiByZXR1cm4gIkxpZ2h0IEhTTCBTZXJ2
ZXIiOw0KPiArCWNhc2UgMHgxMzA4OiByZXR1cm4gIkxpZ2h0IEhTTCBTZXR1cCBTZXJ2ZXIiOw0K
PiArCWNhc2UgMHgxMzA5OiByZXR1cm4gIkxpZ2h0IEhTTCBDbGllbnQiOw0KPiArCWNhc2UgMHgx
MzBBOiByZXR1cm4gIkxpZ2h0IEhTTCBIdWUgU2VydmVyIjsNCj4gKwljYXNlIDB4MTMwQjogcmV0
dXJuICJMaWdodCBIU0wgU2F0dXJhdGlvbiBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzBDOiByZXR1
cm4gIkxpZ2h0IHh5TCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzBEOiByZXR1cm4gIkxpZ2h0IHh5
TCBTZXR1cCBTZXJ2ZXIiOw0KPiArCWNhc2UgMHgxMzBFOiByZXR1cm4gIkxpZ2h0IHh5TCBDbGll
bnQiOw0KPiArCWNhc2UgMHgxMzBGOiByZXR1cm4gIkxpZ2h0IExDIFNlcnZlciI7DQo+ICsJY2Fz
ZSAweDEzMTA6IHJldHVybiAiTGlnaHQgTEMgU2V0dXAgU2VydmVyIjsNCj4gKwljYXNlIDB4MTMx
MTogcmV0dXJuICJMaWdodCBMQyBDbGllbnQiOw0KPiArDQo+ICsJZGVmYXVsdDogcmV0dXJuICJV
bmtub3duIjsNCj4gKwl9DQo+ICt9DQo+IGRpZmYgLS1naXQgYS90b29scy9tZXNoL3V0aWwuaCBi
L3Rvb2xzL21lc2gvdXRpbC5oDQo+IGluZGV4IGNjYTA3Y2Y5Ni4uMmI5YjkyNmIxIDEwMDY0NA0K
PiAtLS0gYS90b29scy9tZXNoL3V0aWwuaA0KPiArKysgYi90b29scy9tZXNoL3V0aWwuaA0KPiBA
QCAtMjcsMyArMjcsNCBAQCB1aW50MTZfdCBtZXNoX29wY29kZV9zZXQodWludDMyX3Qgb3Bjb2Rl
LCB1aW50OF90ICpidWYpOw0KPiAgYm9vbCBtZXNoX29wY29kZV9nZXQoY29uc3QgdWludDhfdCAq
YnVmLCB1aW50MTZfdCBzeiwgdWludDMyX3QgKm9wY29kZSwgaW50ICpuKTsNCj4gIGNvbnN0IGNo
YXIgKm1lc2hfc3RhdHVzX3N0cih1aW50OF90IHN0YXR1cyk7DQo+ICB2b2lkIHN3YXBfdTI1Nl9i
eXRlcyh1aW50OF90ICp1MjU2KTsNCj4gK2NvbnN0IGNoYXIJKnNpZ19tb2RlbF9zdHJpbmcodWlu
dDE2X3Qgc2lnX21vZGVsX2lkKTsNCg==
