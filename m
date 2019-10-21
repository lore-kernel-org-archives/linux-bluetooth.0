Return-Path: <SRS0=7NwR=YO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72052CA9EAF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Oct 2019 17:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307C520679
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Oct 2019 17:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="qfDJOpMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbfJUR0L (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Oct 2019 13:26:11 -0400
Received: from mga06.intel.com ([134.134.136.31]:22919 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfJUR0L (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Oct 2019 13:26:11 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Oct 2019 10:26:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,324,1566889200"; 
   d="scan'208";a="200504538"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga003.jf.intel.com with ESMTP; 21 Oct 2019 10:26:11 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 21 Oct 2019 10:26:10 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 21 Oct 2019 10:26:09 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 21 Oct 2019 10:26:09 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.56) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 21 Oct 2019 10:26:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZUy59gxujHGK3Pjrm2UAiXvuuqB9c4fZVnI+SsC2uX8QpXiUvQRLw1rCCDi8TzbK2mk4KdGzlI3g0ZjW2g1G9s+eJ1pXKm3QQ2lOu3HEEp3H/G4R25rGFej/ihVk/syRaK3cV5wEsXiTApTmeIPw9sXnXJmaSOPMPfNu4kgwBA0W5muXh/S75BzPNMn+JoXtIOjcLAk+RgyHWww8wrMxcoPrRk7XEZp2OBTEW90ZYYDEL36Hyuyu4ZOCiXvqRhv+AkYDIInOxj15cJ3LXJW1rE37GkwCASMJuhBSculicEJwoc/CMcW85NNJjKluJZkXrJ/C5OjV+JoYdQPVjzWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUu37TwO1pwi/hunacWk3F557yNBqERGh69JZQTh6Ek=;
 b=SwEv5VmwDyCAm7Ccjdy1xV6kdO2qHmXFH62U0An7VPmjZWCJAAGUHo5UKPMV8Yd3H0+M+I7gubTnxioNarir1S0dfE1xmbIiXrUTSECjKaJ/iPvj/xKC1zElOfexB3Z/xCoL0tnxddRthBG56CbhYGv5u9ZKXILJesY7R5Tms+nJ/MFTvrd86vZk82mkoFjKl+MRlhDHBgRLa9THjc1x5GllAZnX+omeuor3FV11lfE3f3PzVFVWAe/jw3fv/HmCZjrpLFL/TYZU0PDwO3B+B++J3/JxjOujzg1209toU/TjXH6l1Uf1Is/+2e+ikar1xODoHYhRhjFTS+lxvzjXJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUu37TwO1pwi/hunacWk3F557yNBqERGh69JZQTh6Ek=;
 b=qfDJOpMk4aCKjmIH5DihQA4zcCbsb6I6GP5ToUfM0NzC02VF6yqbzIImhHEvzEwNV3k1csb0XbHxBlfW0w3FCVLCt6HiIDHrJtl06OFZYqbRc3uyP4CcpVZkAJhKT+fAu0HpAWvLvja/AaXfKnnMGJpy2IHHV69uHjlunP7m2sk=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2088.namprd11.prod.outlook.com (10.172.75.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.22; Mon, 21 Oct 2019 17:26:07 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c6d:ebf:5ae2:7501]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::c6d:ebf:5ae2:7501%10]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 17:26:07 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "pachoramos@gmail.com" <pachoramos@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Missing headers for non GLIBC systems
Thread-Topic: [PATCH] Missing headers for non GLIBC systems
Thread-Index: AQHVhyLngUty/ALhAUeGvHUbHHXNeadlWvcA
Date:   Mon, 21 Oct 2019 17:26:07 +0000
Message-ID: <d1ee2805eb120ecfe2c716689252126f5c3a6154.camel@intel.com>
References: <19fda684fa8b3c604a2c763b7cb890e794c734d4.camel@gmail.com>
In-Reply-To: <19fda684fa8b3c604a2c763b7cb890e794c734d4.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0cd10301-372a-425a-f304-08d7564bc229
x-ms-traffictypediagnostic: CY4PR1101MB2088:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR1101MB20880513FEF1657EF93AAF6AE1690@CY4PR1101MB2088.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(376002)(366004)(346002)(189003)(199004)(36756003)(81156014)(110136005)(8936002)(81166006)(25786009)(316002)(8676002)(256004)(305945005)(7736002)(229853002)(14454004)(966005)(478600001)(558084003)(2906002)(71200400001)(71190400001)(118296001)(76176011)(4001150100001)(6116002)(3846002)(446003)(2501003)(102836004)(26005)(86362001)(6506007)(6486002)(2616005)(6512007)(6306002)(5660300002)(186003)(66556008)(6246003)(76116006)(476003)(66946007)(486006)(99286004)(66446008)(66476007)(91956017)(11346002)(66066001)(6436002)(64756008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2088;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YMwDiCax2IBLFU1zUWmkY/xCWfVsymK8v34qDzx4pA6XJoaKlmf6An1sSFZTA9Qb/mN41YrSEAcrRiQ8ZHgKOIsZK3cSoeHK+6VTNQEhmcjJ7jfuo83WJpBvWPQGUop8A7nOpl8a0CpKYtcI06dHaweP1jvzIMM0frDKmgJocQSwc1SNCnjpTvbmwVD14gb/kIuay3rI8T9Ct0h3m30sjwNQE2sCwsnYnLNEGNQnpiibPpBBM5tARC30ObgPNhwe9GWb/GDla3LiXE5tgwdQOzG0n8tm8qkiuHggW/d81AHTfbNkd5hbNYqTdeQzGF/yTOIhGVkpuvmk2TZwTJH/UVVfm4VLNYfTjnMgGvzk4IrRHKAN3i+vhBP5W0W3TvBuuM7ixZUb7kUAsykjR4pecBi5N9E/up4ZBiPHOQSzPzw//wvyIaneEeCc8bUogjlGOksWwVNBacI742YUGdTbJDqmsRfilJ2sfI7pBFheB/c=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9CFD7BD55472B488DD6CB7347AFF2B1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cd10301-372a-425a-f304-08d7564bc229
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 17:26:07.4530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zr2mj+bUm4X0PqPtP4pE16MH5nbtHr4ZOD5sAetB0cp5oDzch3sPFmdVIg3UlPiQmttPUhrTpZrYACBVd6Lcjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2088
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gU3VuLCAyMDE5LTEwLTIwIGF0IDEwOjQ2ICswMjAwLCBGcmFuY2lzY28gUmFtb3Mgd3JvdGU6
DQo+IEFzIGNhbiBiZSBzZWVuIGluIGRvd25zdHJlYW0gYnVnLCB3ZSBuZWVkIHRvIGFwcGx5IDAw
MDEtSW5jbHVkZS1saW1pdHMuaC1mb3ItDQo+IFBBVEhfTUFYLnBhdGNoIHRvIGZpeCBidWlsZGlu
ZyBpbiBub24tZ2xpYmMgc3lzdGVtcw0KPiBodHRwczovL2J1Z3MuZ2VudG9vLm9yZy82OTU5NDAN
Cg0KQXBwbGllZCwgVGhhbmtzDQo=
