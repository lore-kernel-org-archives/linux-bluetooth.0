Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC689C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 21:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiIVVLT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 17:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiIVVLQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 17:11:16 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B56110B02
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 14:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663881072; x=1695417072;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=fF2P1cJJnYE/b5zKjuOldTVW5cdG/d2AAQCbWg67DIg=;
  b=Ioe84eebZAoZyFpYvM0qfSds35iCBfphfnHpquKtWWU+aqSLRSTNNE5z
   BE5OOgab48fmtKG/wud9L4R8NBFUCWymPxRBdU+29C4EPUnz7Xxmikywu
   ZqFWcHF5fu9ToG88Wk1+8tzdSHIJnrktYV4jZCX2mSaJsHHnKr/LcQEVh
   WoxH/6iBB1Hv/XH3/lltUaGqTvRTEmVKmx7eGRIqyzS2Ijxun5LsDvr9d
   u9j3l+02sgFqu9oA+p2S9gF7nje6sfQQnniDe62UoqZMQ1ZK0Arcj3eSf
   mov7nPd+7eLUDIvvx4cXjhwnOP09mxG6UUyS99hv5Pq8Jsa9bQzbacbXL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301310377"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301310377"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 14:11:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="688472881"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2022 14:11:10 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 14:11:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 22 Sep 2022 14:11:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 22 Sep 2022 14:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0suD+zYxezrYx56HrLGaFqA0gQZbn/v4nkI38Jyg1Bd1NofgcyJ7rF3SkabpWb5WNTP7ZG1eUUq1mMlhuudmDDV0r5ZHKM9ILDk5ueCoO83CsqyaDp9iGZfIuRm2cqFeRFCVWlqY3t9+vWJ/HLPGlCtaKhdxNK69a33tckJqOfSYIvzVNQA+AHLXAHAFaXuaYTCduhfFzyhwCa8vuU7B7NRZ9CZ3/AWd19zcf+qGybd3ljAUtGxQMgUcpkhM7znZEx+FYwIKhU73XOMXwgU+7FfYjSN1gz8rPkXZBQJ9EsycJQAHaV3pvfM0Sce1pClUfVh/LG2lVxglpyotSiPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fF2P1cJJnYE/b5zKjuOldTVW5cdG/d2AAQCbWg67DIg=;
 b=c+uXfUlsOeV+PgoW27ZahHrAzs1aA2liaXMD1S3ZZ4kKajncL6KCGoK+7VnE67HMqhAyNiDxp7ABIi43+9Dohh4tSXpCLC28uPI0eyhcbRzd2ZvUQd8yEOZt8o5ZGsBREveJDyNDXFkA7GFyizdJ7AyE7SzDPGamFKSVGjODgET1o/wy1phZJGWmk3mn6TmHsedGSpL27oQMihV63nbmFk8YKJVisdqeqyNs6XkNSbamQ47xBANoAhqn/jw6uxRsjBihrWmydBUSJGSpk1C32MZqy9v9pY881gkWkmB/yf1xxOTgVxK1ry28oVWDoGA20pOGJjYIYYOvU5YzLGs6/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by MN0PR11MB6060.namprd11.prod.outlook.com (2603:10b6:208:378::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.16; Thu, 22 Sep
 2022 21:11:08 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 21:11:08 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "isak.westin@hotmail.com" <isak.westin@hotmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v2 1/3] mesh: Add interface output filter
Thread-Topic: [PATCH BlueZ v2 1/3] mesh: Add interface output filter
Thread-Index: AQHYzavIG3EBT3N4+U+b4m3CCNX4CK3r9FMA
Date:   Thu, 22 Sep 2022 21:11:08 +0000
Message-ID: <c19b921f0d785793d9fd0e4ff0d66c8a66dbd9cb.camel@intel.com>
References: <VI1PR09MB42395F76D2702B0C26F326C2E34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
In-Reply-To: <VI1PR09MB42395F76D2702B0C26F326C2E34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4526:EE_|MN0PR11MB6060:EE_
x-ms-office365-filtering-correlation-id: 5b6a7ec7-7284-4785-a24e-08da9cdef850
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fEEiFVLsvXR3o0CjyJGvlRW8uCp/v/qCNTEaHGRJfg0lzW8KWoCrffVGfzVaHIbivtqSSwJjgbPgIhRyFJbDZTYW4Wou4ybxA+ZHo0nDoxDfhEByFLR/EAkuy+VqL1yu1N4bsfOmKo7rScyQMILJAQp7Eqad1EPQ50Z3yCVwq3tmXnOJnZlwF+nYKDUHI9G8JXC6OXPRDM4KXrmUGfqSH2nC10g1oWdSp16QApplw6/hdix7A3Y5WG7P/vIJIVcFjXjZ7fuAc+izaXgMBQZtSccI6csNE5CQCX9LYlAMVioaiiqNkDQb2hyV1kmr5qi/8cECIZd/eV6Go+dHG6l+x5SsSU2L9sXEvdKS8lKTVp+T/A9iBn0Suxpp3nZ/F/DNmLSOsD2JxQgimGyXAPfU/qh+Cl2uCmCXmGs3ih696CCOJIlEvPjEfGueeM+fYXT7IVOwfvL8qpQsFD2pw/NwRbNTjmJoyDXlxYEa+SdEauvaOY3+mXgxD4FeBOAxJUGAv8/zN/cWEiI+kmlSQogMGTGjiaUad3AvbzQ26iAzZz3Ifjb+yuKLCtUq2ofPHwOZ2ma7iy8LSchYduKpKiBsZEgUdaCF4OGXMWkiYWFP+hz7TusUmwzkH/rwTmIcLS55Mpxlj0XoBxYPeT2w9UFoX8wH1lT/OO+vQfV6u4kjq1RxnIjNk4bWBtkiqWpbl1L3yKdHmKR7NmV2eOEy4ymHMGzdeupnwb7Y9VzfngLzvKsCl1paF2BVefHoycpBZmECtmB1ETczinO/0asBeaD4AQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199015)(6506007)(6486002)(186003)(478600001)(71200400001)(2616005)(83380400001)(66476007)(36756003)(316002)(8936002)(110136005)(91956017)(64756008)(8676002)(76116006)(41300700001)(38070700005)(86362001)(66556008)(38100700002)(5660300002)(26005)(122000001)(82960400001)(66446008)(66946007)(6512007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnJBMkFoaitRbW8yTDY4MEl6SERrNERtV0lwZ04wZUNYMlRZaXovM3EwdFB0?=
 =?utf-8?B?L3FqZ0RwbTNHVTBVMGt3dGRQSStYa2hzbDNLdXUxMm1qQXhXcVVPWGJZNHhs?=
 =?utf-8?B?R2kzRXZCVzVkYlpoTUg0ZkYyYkdmM2tpd0x4aVVSUVI1MnE1dVJ6R0Zqc3BR?=
 =?utf-8?B?Ny91RFRoaWloL0NiQ0NPSUhreGlUSHJNZVFwck0zSGxybGFkQWxIL1V2Zkhy?=
 =?utf-8?B?K0xJKzdGYTgwc2lCL21JS3J2ZElLMHRPdVM5cm5rSmRFdVJicXZtZVgrLzlw?=
 =?utf-8?B?anVoa2MrWUdZcUhKaFhmTHVWSFlHTFlKQ2hkalpaZTdvNStkenlnQ0ltWWds?=
 =?utf-8?B?MnNLdUIxcGdRTVc3d0RZbWduMktNSUxhSnRZd2xmK2xscER0WGk5UWdFUUV6?=
 =?utf-8?B?MTJONS9tMzVaWFFCbklxRnpQMzRUNTc4eWFLaVlVS01mOStYRzhiNUwzSnJJ?=
 =?utf-8?B?QXhrM2FPWnJpNXIrSjMyM1J4Z0lya0U3eXZ5RHJxVGhFU0lRQUtvcy8rZmNB?=
 =?utf-8?B?eXJEeGs3QldoWVFiSWZTZVNZUTIxelBiSzc2VXg1UGJOdHNOTlY4ZTVZMERN?=
 =?utf-8?B?ai9UTHNhSE9JdWRoU3lsaHdUSEFoL2VCTFJyVkppWEFCcVhiTFhZR0k1T0hR?=
 =?utf-8?B?a3k1UzhjMUlwaGZnZE12MThzN1NCK2c1ZXlZSVorWithMXgxRjIzcHdzblJ2?=
 =?utf-8?B?d0NwdURWSG9ZU1NtVUtuYm5xcXNaRXkvbjRpMlA5L0NsazRaVkp5MktieGpF?=
 =?utf-8?B?ZnM0cTljdGFiTTNlME9qcmp5RThOMitjeTFqNWJ2Z1ZYK1NXK3poVnBRRHFh?=
 =?utf-8?B?dGo5WW5TWFZXaTJubW9vK3lqU2d1MnZxNjF3Q0xKTm1BQlp5ellFdTRFQWFn?=
 =?utf-8?B?WXVVaGZkQlFsWnJDaW4rbnhUdE5ZQ0M5WDU5NVFudVd3c0hyS21uQm5xdmdn?=
 =?utf-8?B?NDFIeFd1VkhoSXlXSU0yMnhFNEs4K2VEZTVNNWdieXJZZW1pWXJOM3lFZFhQ?=
 =?utf-8?B?SURKYWNtSldwclpHUENhNW5TUzNIRy9RY2lIa2lrbzNyWjVmMDJXU1U4bWxp?=
 =?utf-8?B?S0owRThRVG9sMlJKY1JlNTYrKzUybytvQjA1UnQzM3A4Zi9kZ2NQS01HQmpF?=
 =?utf-8?B?eFh5dXU3eUUrSjZ6NEdlYmgrMEp3elQ4OXVxd1p0WTQrWHluZENSZ0hwUm4r?=
 =?utf-8?B?d2o1dmpYWjgwRE8xUDZhY0FraXJhMUFLNmszRWZpK0p5WWJGNjR6SFBXaTd0?=
 =?utf-8?B?WHIrb3BrRElqSTd1MXFVclkzV1ByY2JOeU41YVluVHlJTmFtYXRpa3p0OUhj?=
 =?utf-8?B?SXZvNngwekFLbVdIRG9kenlYeUR0Y2xhZUc1dDc0YmhLdCtoTVBUSGJrODI4?=
 =?utf-8?B?eXFtaExaR0d3ZnFPT2F3T1EzZHJIZzFZbHEwekhFZEl3Y0hMakxnZkJkUmN4?=
 =?utf-8?B?RFVkYjNtdEsrYll0KzBKMWpESlZnY01EK21yV081UEJLVCtEWll4TW9nbHp1?=
 =?utf-8?B?aWgzQlNXR3JaTUhMdFRJdHFOWENoZEZBL2F6alhrSEtBOWxMOWZZYUtjTGpM?=
 =?utf-8?B?VjUvMVJuSEJKRUhJeGFwSmJHQkVTdjczcjN3TTJjRXhVQk9oazh2bGVNNFc0?=
 =?utf-8?B?UDhDQ2Y5dWs2SWx5OWF3RitxRFBjZGpabWZUK250dDQyMkhlVDNGcWFJQjkw?=
 =?utf-8?B?bmtkTG1PV0dRZ0Uwak1IeUM2NEx3SndNZmxZVk0vL2RsbXQ4aFVwTDZNSW1K?=
 =?utf-8?B?eGZWR3k1VTlpVXlZR0ZSQzBieEVqWHdJczJmUzFHYjE2ZVNiQ0hjazZadkxX?=
 =?utf-8?B?ZE5lSlpvczdhVTl1bHBKVi84NU41aE5RZG0vcnN1Q2pSekh3dmZIazBtaHRJ?=
 =?utf-8?B?c2Z4Zk5zWXA3Qy9lNUluWm9GS2Y1UXhsb1doRC84T3ozSk5ZZ3NzWXd4aGZj?=
 =?utf-8?B?NmdDd1NFeDRUVDlJNUxEMG9WK2svMUlKQjdRNEJNUllYR2pRS0hUT2g3NXNt?=
 =?utf-8?B?ZVJsQ1RMd0d0Z3RLUFBFMGowUjVXamVENkZDR1dCWXp3cnJySVBVcFFZS3Vt?=
 =?utf-8?B?RncxL1FjblM1Ly8wZEhRRWJaQVhwZWN3TjlkTjh5eCtkZTN6SUtrRUMzUmtN?=
 =?utf-8?Q?xX6buwVaNPhpg5HKZXe+RrvkS?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F44F5A781931474E9292BED7D1EE052F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6a7ec7-7284-4785-a24e-08da9cdef850
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2022 21:11:08.8584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmbqKWrKvZUNI8ibm28X3aFxztBCTzi2WMH/MJo/68aBJ+0j38/xsiMvXXFGtQmPLA3NYNNhPoYJWhVaxW5I9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6060
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgdjIgYXBwbGllZC4gIFRoYW5rcyEKCk9uIFdlZCwgMjAyMi0wOS0yMSBhdCAxMzox
NiArMDIwMCwgSXNhayBXZXN0aW4gd3JvdGU6Cj4gQWNjb3JkaW5nIHRvIHRoZSBtZXNoIHByb2Zp
bGUgKDMuNC41LjIpLCBpZiBUVEwgaXMgc2V0IHRvIDEgZm9yIGFuCj4gb3V0Z29pbmcgbWVzc2Fn
ZSwgdGhhdCBtZXNzYWdlIHNoYWxsIGJlIGRyb3BwZWQuCj4gLS0tCj4gwqBtZXNoL25ldC5jIHwg
MjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+IMKgMSBmaWxlIGNoYW5nZWQsIDI4IGlu
c2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvbWVzaC9uZXQuYyBiL21lc2gvbmV0LmMKPiBp
bmRleCBlOGU2ZDNhNjEuLjY5OTQ2OTI4NCAxMDA2NDQKPiAtLS0gYS9tZXNoL25ldC5jCj4gKysr
IGIvbWVzaC9uZXQuYwo+IEBAIC0zMDY3LDYgKzMwNjcsMTMgQEAgdm9pZCBtZXNoX25ldF9zZW5k
X3NlZyhzdHJ1Y3QgbWVzaF9uZXQgKm5ldCwKPiB1aW50MzJfdCBuZXRfa2V5X2lkLAo+IMKgwqDC
oMKgwqDCoMKgwqB1aW50OF90IHNlZ08gPSAoaGRyID4+IFNFR09fSERSX1NISUZUKSAmIFNFR19N
QVNLOwo+IMKgwqDCoMKgwqDCoMKgwqB1aW50OF90IHNlZ04gPSAoaGRyID4+IFNFR05fSERSX1NI
SUZUKSAmIFNFR19NQVNLOwo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgLyoKPiArwqDCoMKgwqDCoMKg
wqAgKiBNc2hQUkZ2MS4wLjEgc2VjdGlvbiAzLjQuNS4yLCBJbnRlcmZhY2Ugb3V0cHV0IGZpbHRl
cjoKPiArwqDCoMKgwqDCoMKgwqAgKiBJZiBUVEwgaXMgc2V0IHRvIDEsIG1lc3NhZ2Ugc2hhbGwg
YmUgZHJvcHBlZC4KPiArwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqBpZiAodHRs
ID09IDEpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiArCj4gwqDC
oMKgwqDCoMKgwqDCoC8qIFRPRE86IE9ubHkgdXNlZCBmb3IgY3VycmVudCBQT0xMZWQgc2VnbWVu
dHMgdG8gTFBOcyAqLwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGxfZGVidWcoIlNFUTogJTYuNngi
LCBzZXEgKyBzZWdPKTsKPiBAQCAtMzEzNSw2ICszMTQyLDEzIEBAIGJvb2wgbWVzaF9uZXRfYXBw
X3NlbmQoc3RydWN0IG1lc2hfbmV0ICpuZXQsCj4gYm9vbCBmcm5kX2NyZWQsIHVpbnQxNl90IHNy
YywKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoZHN0
ID49IG5ldC0+c3JjX2FkZHIgJiYgZHN0IDw9IG5ldC0KPiA+bGFzdF9hZGRyKSkKPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiB0cnVlOwo+IMKgCj4gK8KgwqDCoMKgwqDC
oMKgLyoKPiArwqDCoMKgwqDCoMKgwqAgKiBNc2hQUkZ2MS4wLjEgc2VjdGlvbiAzLjQuNS4yLCBJ
bnRlcmZhY2Ugb3V0cHV0IGZpbHRlcjoKPiArwqDCoMKgwqDCoMKgwqAgKiBJZiBUVEwgaXMgc2V0
IHRvIDEsIG1lc3NhZ2Ugc2hhbGwgYmUgZHJvcHBlZC4KPiArwqDCoMKgwqDCoMKgwqAgKi8KPiAr
wqDCoMKgwqDCoMKgwqBpZiAodHRsID09IDEpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldHVybiB0cnVlOwo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgLyogU2V0dXAgT1RBIE5ldHdv
cmsgc2VuZCAqLwo+IMKgwqDCoMKgwqDCoMKgwqBwYXlsb2FkID0gbWVzaF9zYXJfbmV3KG1zZ19s
ZW4pOwo+IMKgwqDCoMKgwqDCoMKgwqBtZW1jcHkocGF5bG9hZC0+YnVmLCBtc2csIG1zZ19sZW4p
Owo+IEBAIC0zMjA2LDYgKzMyMjAsMTMgQEAgdm9pZCBtZXNoX25ldF9hY2tfc2VuZChzdHJ1Y3Qg
bWVzaF9uZXQgKm5ldCwKPiB1aW50MzJfdCBuZXRfa2V5X2lkLAo+IMKgwqDCoMKgwqDCoMKgwqB1
aW50OF90IHBrdF9sZW47Cj4gwqDCoMKgwqDCoMKgwqDCoHVpbnQ4X3QgcGt0WzMwXTsKPiDCoAo+
ICvCoMKgwqDCoMKgwqDCoC8qCj4gK8KgwqDCoMKgwqDCoMKgICogTXNoUFJGdjEuMC4xIHNlY3Rp
b24gMy40LjUuMiwgSW50ZXJmYWNlIG91dHB1dCBmaWx0ZXI6Cj4gK8KgwqDCoMKgwqDCoMKgICog
SWYgVFRMIGlzIHNldCB0byAxLCBtZXNzYWdlIHNoYWxsIGJlIGRyb3BwZWQuCj4gK8KgwqDCoMKg
wqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKgaWYgKHR0bCA9PSAxKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqByZXR1cm47Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqBoZHIgPSBORVRf
T1BfU0VHX0FDS05PV0xFREdFIDw8IE9QQ09ERV9IRFJfU0hJRlQ7Cj4gwqDCoMKgwqDCoMKgwqDC
oGhkciB8PSBybHkgPDwgUkVMQVlfSERSX1NISUZUOwo+IMKgwqDCoMKgwqDCoMKgwqBoZHIgfD0g
KHNlcVplcm8gJiBTRVFfWkVST19NQVNLKSA8PCBTRVFfWkVST19IRFJfU0hJRlQ7Cj4gQEAgLTMy
NjQsNiArMzI4NSwxMyBAQCB2b2lkIG1lc2hfbmV0X3RyYW5zcG9ydF9zZW5kKHN0cnVjdCBtZXNo
X25ldAo+ICpuZXQsIHVpbnQzMl90IG5ldF9rZXlfaWQsCj4gwqDCoMKgwqDCoMKgwqDCoGlmICgq
bXNnICYgMHhjMCB8fCAoOSArIG1zZ19sZW4gKyA4ID4gMjkpKQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuOwo+IMKgCj4gK8KgwqDCoMKgwqDCoMKgLyoKPiArwqDCoMKg
wqDCoMKgwqAgKiBNc2hQUkZ2MS4wLjEgc2VjdGlvbiAzLjQuNS4yLCBJbnRlcmZhY2Ugb3V0cHV0
IGZpbHRlcjoKPiArwqDCoMKgwqDCoMKgwqAgKiBJZiBUVEwgaXMgc2V0IHRvIDEsIG1lc3NhZ2Ug
c2hhbGwgYmUgZHJvcHBlZC4KPiArwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqBp
ZiAodHRsID09IDEpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiAr
Cj4gwqDCoMKgwqDCoMKgwqDCoC8qIEVucXVldWUgZm9yIEZyaWVuZCBpZiBmb3J3YXJkYWJsZSBh
bmQgZnJvbSB1cyAqLwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIW5ldF9rZXlfaWQgJiYgc3JjID49
IG5ldC0+c3JjX2FkZHIgJiYgc3JjIDw9IG5ldC0KPiA+bGFzdF9hZGRyKSB7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1aW50MzJfdCBoZHIgPSBtc2dbMF0gPDwgT1BDT0RFX0hE
Ul9TSElGVDsKCg==
