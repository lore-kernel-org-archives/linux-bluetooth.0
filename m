Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB10C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 22:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359236AbiELWjR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 18:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242098AbiELWjO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 18:39:14 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB41282000
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 15:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652395152; x=1683931152;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MtFfPGQM0+TdBKnOlj9PIEGY6hSeXhopENVzs7V8sEo=;
  b=ZNCVf2LpEilXn13uZpXB+J9s4J/QiUIXrB0HUFuruFPuVPKbajm1T0wt
   R05s99c/IrtWG+Ah+RHt1rCO/pVEFaGB2FSVYnhvIQiD+x+mgqwOOzriD
   saW5AgTXKxWKiLiHbuQ22qr/NlCQmzvrQm2stWyM/zQHTErFNobjj+lpI
   jV+MLSmuiWSWQSvoc3KbJ4hGDT+yN2GJAoZVpAhGUXy4tM8MHRgdFRU/I
   bPLf+4hTm3l6C7tERX+MFlGMRV+dPZ4bR3EolyAYrForJ11+LSkLuUl0g
   5t57BpSNbfwoNLTjPjAXDAAV/Lnpr5PLpIY8RKtZ9oFlqEmiSsRjUd04v
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="295411522"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="295411522"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 15:39:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="739904490"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga005.jf.intel.com with ESMTP; 12 May 2022 15:39:12 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 12 May 2022 15:39:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 12 May 2022 15:39:11 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 12 May 2022 15:39:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mLp/0sXAXbKgeSPGYZSmrNZWA+eyJQc1nnNSpm/1IUnse70PSPEbMiWV3dlAE3RGvJxb/sxaZvWHKM3PayiTN1sB8v+HlFgpGiGssuP/zwctkWUPgC3eeW9vFuyut8c6/NfgoGuV33ndBGLudMAH3UEBMUCP/tKTBtBpCNS6HD/uzYm2Ccf+1+senuAP6+LfRZeCevd3TpCvb8wVeaam7x5xWB+zJ/oxXO4sZ2ec/lauGMPzUlWx0PFsBqGEudl+jGjR55/NQe0gXBXKjaqkzLzgTsQ9XY2hkl4FgiZzUXzWuXEWl92FM8ddsJhNhthEGGEzEmmQ770HlelaCo/9UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtFfPGQM0+TdBKnOlj9PIEGY6hSeXhopENVzs7V8sEo=;
 b=evckWeaXCEkQN8EmebdrCPWA8iFS7BeLzBAVDNs2gYOnhUOUb5g68AnP9osZhEo6WvPjYij2vztfXD7PnTrE3z1ekdKlrwx8LHDDBxx7qhZz3DAXUUAN/DYqcZzcHrnpQOY6wTQDXrYRaDCdSNWanKE9izIUfzTymOGc//d3m5atbVWiv/ogd4vWerxzqhWOgN6z0v/Zy+9PBlj5BxV8MAX0rP/cP8Ryuu/0sBznmJdkzWnX/2OWusMRXWjWQPT/tOEDz5hpn28Ra45W6m5QLcHaxBNzKhKAdg0c1yIYyH8JTgmasvUb8DV1cqbO2EAdT/nAFOGZ31isVs5TcM+Mvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by CY5PR11MB6344.namprd11.prod.outlook.com (2603:10b6:930:3b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Thu, 12 May
 2022 22:39:05 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::e93c:bcf9:fdc7:f75f]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::e93c:bcf9:fdc7:f75f%3]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 22:39:05 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] Bluetooth: Implement support for Mesh
Thread-Topic: [PATCH v4 1/2] Bluetooth: Implement support for Mesh
Thread-Index: AQHYZU9mGuYcI2XIIk+93brMAMigoa0aK9mAgAGrsgA=
Date:   Thu, 12 May 2022 22:39:05 +0000
Message-ID: <ad43c4b75fd160fb42db77cd47d947427bf35df4.camel@intel.com>
References: <20220511155412.740249-1-brian.gix@intel.com>
         <20220511155412.740249-2-brian.gix@intel.com>
         <CABBYNZ+37fsMBP=t+cJDpXcUp=rRgWmHxXGBg083aM9pvqyWZQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+37fsMBP=t+cJDpXcUp=rRgWmHxXGBg083aM9pvqyWZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.4 (3.42.4-2.fc35) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d95a73a-4bcc-4b1e-1898-08da3468385e
x-ms-traffictypediagnostic: CY5PR11MB6344:EE_
x-microsoft-antispam-prvs: <CY5PR11MB6344AFC8D362F5B63CD50C47E1CB9@CY5PR11MB6344.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LkZCUByoQbHg4cKgFzlKv0FWIKcEOJgJG3u9qygmCPyxx4yo4faExaZafp/cQSN3+t4p5q+MnH5K3OvhWhc3/7fmg7nFE33XBDHHb03phbhYbXNhRV4NoqVtsnPQc0NLvatJRycZpd/UeAxql9aqJx/0IBNFvtL9D55Mb0j89pgniBxgpgQDI2ZRwV89v32vP5eBt8dQTadYP+TNR2tvl7XaO0NEdlT359J3qFcYILpzrs9BvaL/sjNWjiCKJE52iJ6aUcekobPZtIpZE6VIseT7LS9Dwmlr5rN/ucLHub4fyKkDgSejFUN8ZY5XL9fjg7v/fVjLi+rAGDzwM3mZpF5dJFiNBqJ0vu58I+9SgLtNXBx+A/+r2L8waBoinj0vA48KIrXqAKCopjOrbNeCzNjx5CIuF0nckCtGW/aK7d58/bZg77E27Hd08LfJwS7zIrkqh1qZTCkmyLSl7/XQcvTeU/fRVS0RzaQKoBW5xWUPwmhy+J+avXc2hqr+X9HyhQnRQc4WKU7yNA8Zc2BdfK5IggremW+j3RSnsS8zvq+gW7SBWhM/Z2f/C0iOIyBRYKpz4DbAIYzo0pSRP/aYtZBjLQkHfHYIxADFyj1K3tGc8JHJUZ1GRo2DXYAbMGWu9VoA97or1zfeaKW2y72bfHl34VTFvOvauGbvZoOFWsWjAG4RAGBwO35ldtQBxDc4R0aLt6yG+xCU3iBynT1wyFkd3qOgLe4NYqsQpL/TgNiuSv3pGHJYJHCU1gqTGD/2P5d5bOGIzScmgC9mP6ZJjX71vgu6oh/n1tC1lnc2kOI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38100700002)(122000001)(508600001)(5660300002)(26005)(71200400001)(6506007)(36756003)(66556008)(53546011)(8936002)(38070700005)(316002)(82960400001)(2906002)(6512007)(66446008)(54906003)(83380400001)(66476007)(76116006)(66946007)(6486002)(91956017)(8676002)(966005)(2616005)(6916009)(64756008)(4326008)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UEl6YThmUU5LQndKQUt1M1BQM05qeVJBM2FpWGl5clJmTmIzaG9MbFIxc1gw?=
 =?utf-8?B?Um5NQUlzampzRkp2NXU1ayswTVAySkMyMlVMcFZsdzVRZFFoOUpOZDNJUHM4?=
 =?utf-8?B?cUFnNWQveDhGTExOcmxDQXVCU3YxUUt6YTdNQTBEc3ZQajRLSURWK1FESU8x?=
 =?utf-8?B?ZVhMM080TlJ6K1JUMEdYWmFFdy9CMlVNMk5OWjI4K1NIRUVmYllvbFRod0ky?=
 =?utf-8?B?blVxdmVFOGlvODU2MHF1c3M2OHl5V3VVNm5Tek9FYVIyT3FyWnNMOHBDeUtq?=
 =?utf-8?B?TFNjNHhZcWhRcjRlTm1BOWdMQmNMbmM3MlBlby9PbjJjN0d0aFpDSjlQODhT?=
 =?utf-8?B?V1NNWUxPLzMvRk13aktlUG1hbjFkR1lSc0o3ZGZWdmlMMW42ZXE3TzhKUkRT?=
 =?utf-8?B?akpoclRzUktDTFp5Ry81V0JtNGFJTGlldlJCUC9oQkpyMHhNVG5LL1p6dWUy?=
 =?utf-8?B?RlhDRzlvM1h6UHA0aXFpUHYyV1dXanJlYjhGUS9iWDFQNjRPY3pkeUd0L1hv?=
 =?utf-8?B?VzdKVG5VaURQdGhhOHdzWUFHaXc3K0VQUFBCZ2t5L2QvK2dKbXBJbTZNMStR?=
 =?utf-8?B?aCtaWXpuc1BZODJXVXBGeVVUMUNscVJFVHdEdEVhbngyRU9pN01OSlhjTlBn?=
 =?utf-8?B?Zy9LTEpQR0FjMXB5ZGFBSDBzL25PYkd2YUpKdFBwMDMvTS9BYkxybTZFb2tD?=
 =?utf-8?B?dXlGV2N4emRYbXM2c3VEdlpoamh2MGdWb0VMWWs1R0R2SUlRa3IySTdEcGFl?=
 =?utf-8?B?eVVHOW5hbWIybHNLMTdGNG4zQTFpMTh5bEFFdVpXVTBGWElYMTZFMDJQVEtE?=
 =?utf-8?B?a0tSazZweHU0K0JOYy9yT0ZsMmsram5iRi9YWHVkUG5iSnNIYzlGTXJ5d1Zl?=
 =?utf-8?B?QlYwcG5rSGlLRlRVaExQaCtpNmtmK09oQldqTExiSnNCVFdxY0wrTUs5TFpj?=
 =?utf-8?B?TjYxUU15TE1oVk91REV1b0J0dXlqMndsNGJ2blFxdSticlNHOW50Vnp0dy9L?=
 =?utf-8?B?OFJKdG9MdzdNQ0xQUWxJaUpjbWN5RkQ1eVZIcnhqcU4vRFlKR0s3QnZWbjIv?=
 =?utf-8?B?TDBIR25pU2VWczU2bzFlTWd2S3JWKzFXNTFUOEhzeHFIZVJYSjhiUms1QUM5?=
 =?utf-8?B?QUFyalZlcnRVRTV6azAwUjB6Y2p5K2xGeDRpKzRTV3lvN1o4SGw4YUZ3Yk5h?=
 =?utf-8?B?czJmWEsrY2ZrUDlaT0pMbE12aXF5c2VoY1JUTlhDUGFFeXYwSUtpTXVVbjhn?=
 =?utf-8?B?Wjh4d2hNYllNZVkxRUxoM0RrSXJyeWQ4ZzFDNmcvdTRrdU1oQnN1ekFJdjdj?=
 =?utf-8?B?UVBobkxhWTNldDlOYkJwaTNNTGJWS1M0d3E5Z2tiVThySy84N2NLTFNaY0Rn?=
 =?utf-8?B?ZWcrOGZDTURoT1BBU2liVnVHMGNsUFUxS2dWRVhsQjlxaEE5ZFZ0bVNmQkVq?=
 =?utf-8?B?TDI1SE1BbTlienlrYkJQOXVzM1NrNVVSNHhwbHJ6dXhUaXhkdE9IUCtzU2lD?=
 =?utf-8?B?Nzd2VDAwOFFYREpJVUFVS1I5Ymh3aTA2WVlnQUxyL0c0ZmQ1L3BUQmd0L0RL?=
 =?utf-8?B?Yk1zaFNTOW5ZQXUzZ3NkZlVLOUJOTjJqWVQyT2d4SUZQd1EzQTVlMTZTL3Z0?=
 =?utf-8?B?RmdwODdIMlRZcDRSMmJJR3pGSk9BbFFLZmc3QmUreEszWk16Ny9zdnZyTHZD?=
 =?utf-8?B?d3lFUStTNnhKMnBQbWh0U0ZrL1FkUStaZlhjRzVndElqbUFVaGRsTGlEUEQv?=
 =?utf-8?B?ZUxDNlpNQU9UejJ6TFJVZEorQXR0VzliUTlXNGNYZFI4ZU05RjBQNVY5ZXBP?=
 =?utf-8?B?cnRGckVhUXNhajdSeGpSemdtdzVGOUN3emkrTFhBTTJFVmt6ZERkcjl5dmdW?=
 =?utf-8?B?SDkySU1JZEpGUXg5YTNFdktBYkxNRStxYWxxMGIrM0xkUUQ0V2V6WUVjOGhB?=
 =?utf-8?B?SWJ5MVh5MmZVSmFETDhlZWFSRDhTR2haWmlxcUFnRklGdlJwemE2dHBkTlNZ?=
 =?utf-8?B?M0xHbDRTRitJa2JXUlVqbXR2aFdqa2lhY2p5dFY1L3VDT1NZTVNiR1AzWEZU?=
 =?utf-8?B?TEtHVklwa3lzVnZidHh2RlFUY0dobUtQMWZYLy9FZTFsWHpodzVvdlJFNjdG?=
 =?utf-8?B?VGxNQ3dDczRyS0N1OEtCWHFKMDlGRktRKy9jeUdOdDg1TzNZeGhya0xpWkJD?=
 =?utf-8?B?T1VCb1pJRTRrTGFCQlEyeUd4MVpJOHVUeUhxTTVTUGt5OTQzKy9IMjhVYy9i?=
 =?utf-8?B?YStURVhXNFhoZG4xZldBaVZzaVJBMzNNdnJXb3RrWElTWE16U1dBeUFBcHVm?=
 =?utf-8?B?RWxzbDFCNlpPU1dTK0VTWG1hWU1DdVdQY1dmYXo1ZlhLeE5nNW91dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6BE472F6C42314796C45BB3706F31FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d95a73a-4bcc-4b1e-1898-08da3468385e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 22:39:05.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fQdwvZ5pFvr+D/byGD74/7wBVw4jjqkzDpoNHKcvb1mdwuZH276r5lPYPvyzuO76SOsQ5R/Gn8Ke67M1M9E9HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6344
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KT24gV2VkLCAyMDIyLTA1LTExIGF0IDE0OjA4IC0wNzAwLCBMdWl6IEF1Z3Vz
dG8gdm9uIERlbnR6IHdyb3RlOg0KPiBIaSBCcmlhbiwNCj4gDQo+IE9uIFdlZCwgTWF5IDExLCAy
MDIyIGF0IDg6NTQgQU0gQnJpYW4gR2l4IDxicmlhbi5naXhAaW50ZWwuY29tPg0KPiB3cm90ZToN
Cj4gPiBbLi4uXQ0KDQo+ID4gDQo+ID4gKy8qIFVzZSBleHQgYWR2ZXJ0aXNpbmcgaWYgc3VwcG9y
dGVkIGFuZCBub3QgcnVubmluZyBNZXNoICovDQo+ID4gKyNkZWZpbmUgdXNlX2V4dF9hZHYoZGV2
KSAoZXh0X2Fkdl9jYXBhYmxlKGRldikgJiYgXA0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIWhjaV9kZXZfdGVzdF9mbGFnKGRldiwgSENJX01F
U0gpKQ0KPiANCj4gSW0gbm90IHJlYWxseSBmb2xsb3dpbmcgd2h5IHlvdSBkb24ndCB3YW50IHRv
IHVzZSBFQSB3aXRoIE1FU0gsIGFmYWlrDQo+IHRoYXQgd29yayBwZXJmZWN0bHkgZmluZSB3aXRo
IGVpdGhlciBvbmUgYmVzaWRlcyB0aGVyZSBpcyBhY3R1YWxseSBhbg0KPiBhZGRlZCBiZW5lZml0
IHNpbmNlIHdlIGNhbiB1c2UgYSBkZWRpY2F0ZWQgaW5zdGFuY2Uvc2V0IGZvciBtZXNoIHNvDQo+
IGl0DQo+IGNhbiBjb2V4aXN0IHdpdGggb3RoZXIgaW5zdGFuY2VzLCBhbmQgZXZlbiBvbiBjb250
cm9sbGVycyB0aGF0IGRvZXMNCj4gbm90IHN1cHBvcnQgaXQgd2UgY2FuIHN0aWxsIHVzZSB0aGUg
c29mdHdhcmUgYmFzZWQgcm90YXRpb24gdXNpbmcNCj4gYWR2X2luZm8gaW5zdGFuY2VzLg0KDQpU
aGUgY3VycmVudCBtZXNoIHNwZWMgb25seSB1c2VzIHN0YW5kYXJkIExFIEFkdmVydGlzaW5nIHBh
Y2tldHMuIEkNCmhhdmVuJ3QgYmVlbiBhYmxlIHRvIHRlc3Qgd2l0aCBhbnkgY29udHJvbGxlcnMg
dGhhdCBzdXBwb3J0IEV4dGVuZGVkDQpBZHZlcnRpc2luZyBmb3Igb3V0Ym91bmQgYWR2ZXJ0aXNl
bWVudHMsIHNvIEkgYW0gdW5zdXJlIGlmIHRoZXkgd291bGQNCndvcmsgb3Igbm90IGZvciBNZXNo
IHBhY2tldHMuDQoNCklmIGEgcmVxdWVzdGVkIGFkdmVydGlzZW1lbnQgZml0cyB3aXRoaW4gYSBs
ZWdhY3kgYWR2ZXJ0aXNlbWVudCwgd2lsbCBhDQpuZXdlciBjb250cm9sbGVyIHN0aWxsIHNlbmQg
aXQgb3V0IGFzIGEgTGVnYWN5IEFEVj8NCg0KWy4uLl0NCg0KPiA+IMKgDQo+ID4gwqDCoMKgwqDC
oMKgwqAgaGNpX2Rldl91bmxvY2soaGRldik7DQo+ID4gZGlmZiAtLWdpdCBhL25ldC9ibHVldG9v
dGgvaGNpX3JlcXVlc3QuYw0KPiA+IGIvbmV0L2JsdWV0b290aC9oY2lfcmVxdWVzdC5jDQo+ID4g
aW5kZXggZjRhZmU0ODJlMzAwLi4yNjFlNzE1ODFjNTcgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2Js
dWV0b290aC9oY2lfcmVxdWVzdC5jDQo+ID4gKysrIGIvbmV0L2JsdWV0b290aC9oY2lfcmVxdWVz
dC5jDQo+IA0KPiBXZSBzaG91bGRuJ3QgYmUgdXNpbmcgaGNpX3JlcXVlc3QuYyBhbnltb3JlLCBz
byBpZiB5b3UgYXJlIGNoYW5naW5nDQo+IGl0DQo+IGJlY2F1c2UgdGhpcyBjb2RlIGlzIGFjdHVh
bGx5IGJlaW5nIHVzZWQgZm9yIG1lc2ggdGhhbiB3ZSBoYXZlIHRvDQo+IGNvbnZlcnQgdGhlIGNv
ZGUgdXNpbmcgaXQgdG8gdXNlIGhjaV9zeW5jLmMgaW5zdGVhZC4NCj4gDQoNCkkgZG8gbm90IGtu
b3cgaWYgYW55b25lIGlzIHN0aWxsIHVzaW5nIGhjaV9yZXF1ZXN0LiBIb3dldmVyLCBpbmNvbWlu
Zw0KQURWIGZpbHRlcmluZyBhYnNvbHV0ZWx5IGJyZWFrcyBNZXNoIGltcGxpbWVudGF0aW9ucywg
ZXNwZWNpYWxseSBkdXJpbmcNClByb3Zpc2lvbmluZy4gSXQgc2VlbXMgcHJ1ZGVudCB0byBtZSB0
byBrZWVwIEZpbHRlcmluZyBkaXNhYmxlZCBpZiBtZXNoDQppcyBiZWluZyB1c2VkIG9uIHRoZSBj
b250cm9sbGVyLCByZWdhcmRsZXNzIG9mIHdoeSBvciB3aGVyZQ0KSENJX09QX1NFVF9TQ0FOX0VO
QUJMRSBpcyBiZWluZyBjYWxsZWQgZnJvbS4gIFRoYXQgc2FpZCwgSSB3b3VsZA0KaGFwcGlseSBn
ZXQgcmlkIG9mIHRoZSBlbnRpcmUgaGNpX3JlcV9zdGFydF9zY2FuKCkgZnVuY3Rpb24gaWYNCnBv
c3NpYmxlLg0KDQpbLi4uXQ0KDQo+ID4gK2ludCBoY2lfbWVzaF9zZW5kX3N5bmMoc3RydWN0IGhj
aV9kZXYgKmhkZXYsIGJkYWRkcl90ICpiZGFkZHIsIHU4DQo+ID4gYmRhZGRyX3R5cGUsDQo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1OCAqZGF0YSwgdTgg
bGVuKQ0KPiA+ICt7DQo+ID4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgaGNpX2NwX2xlX3NldF9hZHZf
ZGF0YSBjcF9kYXRhOw0KPiA+ICvCoMKgwqDCoMKgwqAgc3RydWN0IGhjaV9jcF9sZV9zZXRfYWR2
X3BhcmFtIGNwX3BhcmFtOw0KPiA+ICvCoMKgwqDCoMKgwqAgdTggb3duX2FkZHJfdHlwZSwgZW5h
YmxlOw0KPiA+ICvCoMKgwqDCoMKgwqAgaW50IGVycjsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDC
oCBtZW1zZXQoJmNwX2RhdGEsIDAsIHNpemVvZihjcF9kYXRhKSk7DQo+ID4gK8KgwqDCoMKgwqDC
oCBjcF9kYXRhLmxlbmd0aCA9IGxlbiArIDE7DQo+ID4gK8KgwqDCoMKgwqDCoCBjcF9kYXRhLmRh
dGFbMF0gPSBsZW47DQo+ID4gK8KgwqDCoMKgwqDCoCBtZW1jcHkoY3BfZGF0YS5kYXRhICsgMSwg
ZGF0YSwgbGVuKTsNCj4gPiArDQo+ID4gK8KgwqDCoMKgwqDCoCBoY2lfdXBkYXRlX3JhbmRvbV9h
ZGRyZXNzX3N5bmMoaGRldiwgdHJ1ZSwgZmFsc2UsDQo+ID4gJm93bl9hZGRyX3R5cGUpOw0KPiA+
ICsNCj4gPiArwqDCoMKgwqDCoMKgIG1lbXNldCgmY3BfcGFyYW0sIDAsIHNpemVvZihjcF9wYXJh
bSkpOw0KPiA+ICvCoMKgwqDCoMKgwqAgY3BfcGFyYW0udHlwZSA9IExFX0FEVl9OT05DT05OX0lO
RDsNCj4gPiArwqDCoMKgwqDCoMKgIGNwX3BhcmFtLm1pbl9pbnRlcnZhbCA9DQo+ID4gY3B1X3Rv
X2xlMTYoRElTQ09WX0xFX0FEVl9NRVNIX01JTik7DQo+ID4gK8KgwqDCoMKgwqDCoCBjcF9wYXJh
bS5tYXhfaW50ZXJ2YWwgPQ0KPiA+IGNwdV90b19sZTE2KERJU0NPVl9MRV9BRFZfTUVTSF9NQVgp
Ow0KPiA+ICvCoMKgwqDCoMKgwqAgY3BfcGFyYW0ub3duX2FkZHJlc3NfdHlwZSA9IDE7DQo+ID4g
K8KgwqDCoMKgwqDCoCBjcF9wYXJhbS5jaGFubmVsX21hcCA9IDc7DQo+ID4gK8KgwqDCoMKgwqDC
oCBjcF9wYXJhbS5maWx0ZXJfcG9saWN5ID0gMzsNCj4gPiArDQo+IMKgd2hpY2ggPiArwqDCoMKg
wqDCoMKgIF9faGNpX2NtZF9zeW5jX3N0YXR1cyhoZGV2LCBIQ0lfT1BfTEVfU0VUX0FEVl9QQVJB
TSwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc2l6ZW9mKGNwX3BhcmFtKSwgJmNwX3BhcmFtLA0KPiA+IEhDSV9DTURfVElNRU9V
VCk7DQo+IA0KPiBXZSBzaG91bGQgYmUgdXNpbmcgdGhlIGhjaV9hZHZfaW5mbyBpbnN0ZWFkIHNv
IHdlIGhhdmUgYSBkZWRpY2F0ZWQNCj4gaW5zdGFuY2UgZm9yIG1lc2ggcmF0aGVyIHRoYW4gdXNp
bmcgSENJX09QX0xFX1NFVF9BRFZfUEFSQU0gd2hpY2ggYnR3DQo+IHdpbGwgZmFpbCBpZiB0aGVy
ZSBpcyBhbHJlYWR5IGFueXRoaW5nIHVzaW5nIHRoZSBleHRlbmRlZCB2ZXJzaW9uIG9mDQo+IHRo
ZXNlIGNvbW1hbmRzLg0KPiANCj4gUGVyaGFwcyB5b3Ugc2hvdWxkIHNvbWV0aGluZyBsaWtlOg0K
PiANCj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9wYXRj
aC8yMDIyMDUwNjIxNTc0My4zODcwMjEyLTUtbHVpei5kZW50ekBnbWFpbC5jb20vDQo+IA0KPiBJ
dmUgaW50cm9kdWNlZCBoY2lfYWRkX3Blcl9pbnN0YW5jZSBzbyBwZXJoYXBzIHdlIGNvdWxkIGhh
dmUNCj4gc29tZXRoaW5nDQo+IGxpa2UgaGNpX2FkZF9tZXNoX2luc3RhbmNlIGFuZCB0aGVuIGhh
dmUgYSBmbGFnIGluZGljYXRpbmcgaXQgaXMgZm9yDQo+IG1lc2ggc28geW91IGNhbiBsb29rdXAg
Zm9yIGV4aXN0aW5nIGluc3RhbmNlIHdoZW4geW91IHdhbnQgdG8gc2VuZA0KPiB0aGUNCj4gbmV4
dCBwYWNrZXQgeW91IGp1c3QgdXBkYXRlIGl0cyBkYXRhLg0KPiANCj4gDQoNCkkgd2lsbCB0YWtl
IGEgY2xvc2VyIGxvb2sgYXQgdGhpcy4gIFBhcnQgb2YgbXkgb3BpbmlvbiB3aWxsIGJlIGJhc2Vk
IG9uDQp3aGF0IHlvdSBjYW4gdGVsbCBtZSBhYm91dCB0aGUgYmVoYXZpb3Igb2YgRXh0ZW5kZWQg
QWR2ZXJ0aXNpbmcgd2hlbiB3ZQ0Kd2FudCB0byBzZW5kIExlZ2FjeSBBRFZzLiBUaGVyZSBhcmUg
YSBjb3VwbGUgdGhpbmdzIHRoYXQgYXJlIHBvc3NpYmx5DQp1bmlxdWUgYWJvdXQgTWVzaCBBRFZz
LCBzdWNoIGFzIHRpbWluZyBhbmQgZmluZSBjb250cm9sIG92ZXIgKHRoZQ0KdXN1YWxseSBidXQg
bm90IGFsd2F5cyBSYW5kb20pIEJEQUREUi4NCg0KLS1Ccmlhbg0K
