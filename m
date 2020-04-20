Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2203FC3815B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 16:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA78E214AF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 16:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="S3hEIkYE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDTQlk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:41:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:64237 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgDTQlk (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 12:41:40 -0400
IronPort-SDR: 9cS1QvOSS7hiWWmmiffTfkhsDJXe3QtZyQo0PWDfYZQTnIjWxKodYaz2QJ3LOdqszbVxQtASfg
 JNyAMptrYRcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 09:41:38 -0700
IronPort-SDR: 2cGgmP6kDKKzzn/kBneGvfXWF3IPnq6wb7chmUMC++xpP8IcZS96kpx6xjn1OYDhRU9CtB2eCZ
 3gYS+XaRHjng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="455760489"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2020 09:41:38 -0700
Received: from fmsmsx151.amr.corp.intel.com (10.18.125.4) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 09:41:36 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX151.amr.corp.intel.com (10.18.125.4) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 09:41:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 20 Apr 2020 09:41:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joQoI5liXSOnoLS8Lt93goXLt1zKUyivO62PPrDh9Iu0bCVrIuJfxH0hAjVme3Fs8uN07GyfPsXsRFkAyKm/G73I7G6c8ej6egvTYZkYxaX++1O4DTin7qC93WmUAOhhKau/ixJku6//IHoZlOnp2zOUHdnEURx/u3T15l0JAAmEUxyz5rfPdckfbbDCV6JHF2t17MoRI4cRr/d85/tnvIO/OKacYSAWfLHDoZBy6+E18PfWJhfE3wElZ0Y88Ngi/SQPfXfp5uXjHPE7uMZqmKEYwI8OtGXrT3Kp4ioh5EoPhuZPSCvrj1k5LyN3G1k3uyBwcXj5IAymgXS90KX11w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QceK9/g6ttga9qkKnFyuKMHNKcVSMQav5Z38VSGypUA=;
 b=Uul0/VPtGwFUiW9pSdtCbtSxhfDp6NjZRYDFvZCyOX3twohPBGwPNcJKVeJYv4bm2vIGh4vWVb36KyDIR++dsl7foL4p982ZFyeXOZD9lyBMDicYZToSkA3kKBLC+mv7+TBrs5QcPWBZV8A58VXXsoPYgtoJu0Mi3gUCXppCf4kcIkaJMYTwih4r+iQBtriqfLxoROl5LMr8JIqSniW3KLxFCLq9bWvuL6C9M0dEMFByaRia6oaBk3xjoE3dMTXUP/EzfWyyLmaG9G0b4XkYcMh1gfN3s0mD0xKX3Xa40RV8Sn5mLuV/Ghy1tFWfFdrOKqPKiFxbuTfmOPcC88VSoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QceK9/g6ttga9qkKnFyuKMHNKcVSMQav5Z38VSGypUA=;
 b=S3hEIkYEVvmGgX9ZYGDn1YLDoLDQsd96DE5YVFc610+HjNAnErOImi9EZTnyVMIZlWYvciUvFL11RFymWisuxmHDzCyBOKR0leOt8kqnUF+f4nuLNFjIajb+fLh/CErd4Zo6W64SDglarz/xvcFItutD1RLyv8G6LDxK8PQxpq4=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4571.namprd11.prod.outlook.com (2603:10b6:303:59::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 16:41:05 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5552:f057:3dbf:716c]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5552:f057:3dbf:716c%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 16:41:05 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "szymon.janc@codecoup.pl" <szymon.janc@codecoup.pl>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [PATCH 1/4] android: Fix build with GCC 10
Thread-Topic: [PATCH 1/4] android: Fix build with GCC 10
Thread-Index: AQHWFwxaIQU24n0xmUmUASEhWANyPaiCNt4A
Date:   Mon, 20 Apr 2020 16:41:04 +0000
Message-ID: <d73bac9fdec3a002478cc1a15da1385e1cd6ce12.camel@intel.com>
References: <20200420120705.89691-1-szymon.janc@codecoup.pl>
In-Reply-To: <20200420120705.89691-1-szymon.janc@codecoup.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e28108c-bad8-4acf-4421-08d7e5499e79
x-ms-traffictypediagnostic: MW3PR11MB4571:
x-microsoft-antispam-prvs: <MW3PR11MB4571783109AD21BF413AEFB9E1D40@MW3PR11MB4571.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(366004)(39860400002)(396003)(136003)(346002)(376002)(4744005)(36756003)(6486002)(6512007)(66946007)(76116006)(2616005)(66556008)(64756008)(91956017)(66476007)(66446008)(5660300002)(86362001)(478600001)(81156014)(110136005)(8676002)(8936002)(316002)(2906002)(4326008)(71200400001)(186003)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIaJWkhMp0Qa7Pn+RZp4KymAOkpTKGPsrqmC4DI/cINTuW5ssjhHJmwysQiL2oaIQo4vo6GzASR5TdSBLj14HaQ4GSoEUntzfCyajxkqxBKJnkPs3JJ/rZmHKYe1NI1b39YV9Qxcc1y5CE3FiJTn4YMxiAEYkimhU0iPMmQQtsGSGfvxWjqScKQ6h4H9Slg13ilfLVGsxXfDrMTsA31Qs2pwrwy6eIMkBQUs64msC8Nam3O6F6uERRYZsFFrCp2obIWTt32vIgFiAQM3qB5eTox2nPnsiQSD2v6j1kHugN81K5rmwGfstftLegdEFyivOpQOGMqPUnDMlW/l94VXVZTzzCZh0IRdBLiBojn2gSERmX0Ta98MO0Ltfss/VnuEC1ORCdawoXfwzIFFCvyv2/aqRwfIYS1brORcJljJBXK7O+7Uf90nHogmfsHWL+vl
x-ms-exchange-antispam-messagedata: OuRbPg0pXXWbSF9KGVdt+Z9IXuEXu+sIMEXUP+ULB0OtOUtYkUaZ2a13PHMPZ1bCqaC6+eXHfdUhAvRo/lllaLRFm1NKZkJuEa3GzC/Li5bLFDPxSE0hvKK/lvJ5NbzIYRT9sbPquCHcNvUgDw7RQkPW4SaZsgXRwa5sxjKvJX+KhUFFeduXPn2IDveIPu0DLEUMXc8hUBFPvqPazMwX0SOrv/6TmgAU7ATDD1aSzXTVkgXBR0GD9wgsQ0J5EZbjfzPOV8H1CmxUVKZfMRb1o/qCSIDqHLwXvmm7vmclEsEWzhKvbIsaQ2uun3img1JBkxIWJPclJtaYdxDynozDxc47XqLcY9IelAB0DT9jX3v8TkVs8cPMMB9rTy8spgmQuRMISLeHIJbFELvEFpCPMSi0lP0z3NhsBbkNICVuaLRMYA9Ea5RUXP2w9Jx6fm5nXfhPjob/iv53n2uRtSkgw6BGRrfmvSzTDzCt4p8rX2SJGfscDW/XIY2as42SLPELsPZy0Yk4EjvYAf4sz/f6gXZw3cHaf1S2n4zsvDpyo4FYbJd1Ave9Z1szdCWt424mxsnaL+yl+iYs0/+o5DmqBVLlECDRg0/PPDfrUxqgSXpuhd3aS1AnE77ZxoeRakk9zGQUX1gLLd+PCK1ZSqUv6YIgse7Vo3EHYAxMWyqxB9+g9eev3dXRfwuKTBbyMQHIqamnh5qjoJ6n9yqq5fMHQv7HsLWPlWeTWBaAkJnYJGYC/VZY6if6HZTOtcW2dI80hCRvXkrDEEv02hW5YZGiDMO2gOtdxHIw0gf7f+9zM8Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D281CE9FACF92438C5DD2F2064DF544@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e28108c-bad8-4acf-4421-08d7e5499e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 16:41:04.9419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xPdHf+WFQh4vvLYLY1NtD6+eCNnTTIFfEYLM3CPC3BnEbRDIHeVWiMU0mo2u3bdvjtTJyqBQO8GMkW6VSC1ELw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4571
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KTW9kdWxvIG15IHF1ZXN0aW9uIGFib3V0IG51bCB0ZXJtaW5hdGlvbiBvbiBw
YXRjaCAzLzQsICBUaGlzIHBhdGNoc2V0IHJlc29sdmVzIGFsbCBvZiB0aGUgR0NDIDEwIGJ1aWxk
DQplcnJvci93YXJuaW5ncyBhbmQsIEkgdGhpbmssIHNob3VsZCBiZSBhcHBsaWVkLg0KDQpPbiBN
b24sIDIwMjAtMDQtMjAgYXQgMTQ6MDcgKzAyMDAsIFN6eW1vbiBKYW5jIHdyb3RlOg0KPiBzdGF0
dXMgYW5kIHN0YXRlIGFyZSB1c2VkIHRvIGhvbGQgdmFyaW91cyBlbnVtIHR5cGVzIGRlcGVuZGlu
ZyBvbiB0ZXN0DQo+IGFuZCBjYWxsYmFjayBwYXNzZWQuIERlZmluZSB0aGVtIGFzIGludCB0byBh
dm9pZCB3YXJuaW5ncyBhYm91dCBlbnVtDQo+IGFzc2lnbm1lbnQgZnJvbSBpbnZhbGlkIHR5cGUu
DQo+IC0tLQ0KPiAgYW5kcm9pZC90ZXN0ZXItbWFpbi5oIHwgNCArKy0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2FuZHJvaWQvdGVzdGVyLW1haW4uaCBiL2FuZHJvaWQvdGVzdGVyLW1haW4uaA0KPiBpbmRleCA4
YTczODRjNTcuLjZiZGZkYmNkYiAxMDA2NDQNCj4gLS0tIGEvYW5kcm9pZC90ZXN0ZXItbWFpbi5o
DQo+ICsrKyBiL2FuZHJvaWQvdGVzdGVyLW1haW4uaA0KPiBAQCAtNjUzLDggKzY1Myw4IEBAIHN0
cnVjdCBtYXBfaW5zdF9kYXRhIHsNCj4gICAqIG1hdGNoaW5nIHdpdGggZXhwZWN0ZWQgc3RlcCBk
YXRhLg0KPiAgICovDQo+ICBzdHJ1Y3QgYnRfY2FsbGJhY2tfZGF0YSB7DQo+IC0JYnRfc3RhdGVf
dCBzdGF0ZTsNCj4gLQlidF9zdGF0dXNfdCBzdGF0dXM7DQo+ICsJaW50IHN0YXRlOw0KPiArCWlu
dCBzdGF0dXM7DQo+ICAJaW50IG51bV9wcm9wZXJ0aWVzOw0KPiAgCWJ0X3Byb3BlcnR5X3QgKnBy
b3BlcnRpZXM7DQo+ICAJYnRfdXVpZF90ICp1dWlkOw0K
