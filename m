Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0691BDD5
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 06:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709791376; cv=fail; b=AzPgxwjz5Oj/gpjjAze9YKlQfrD14ucv5Rpzr+Of2aPBFCAdqDmjleJKXzF7lf4Mh9M2A2oKyS7XtKSxZlQSDzo0o8vyOeliEMR+HDyOixTOTpUBoO8cxLw5nkJ4RIanxD0rIKgUDaBcKSfqDl9zUbU09TZmBqcGgRH3ucn9A5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709791376; c=relaxed/simple;
	bh=dAeOcM1U7cV1IoPUWe38Q9F0sGU4Xd4BqlC0nuxJfeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6/bpt3icwc/9FY5jBeVaVRL4NimDlkxBkAlGlo/860i1Wr5QL0yWtZtjgBn67JC4KxOwFzpsVY+CXSoon+DJ/FEKYlpD9uZSPFa+B7sJ7oyxoLeJUtLgwrkwjheqgPnPCWkDiE149S5dJ3ChlFb2nFHkjegZ5vnp3VNbVfYi1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbJZhJj6; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbJZhJj6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709791374; x=1741327374;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dAeOcM1U7cV1IoPUWe38Q9F0sGU4Xd4BqlC0nuxJfeI=;
  b=DbJZhJj68IsoBSSQAOIe1BIoiCdT/fbIZFB6ZqSIgeoAE7+wPOfQfLFw
   B+pfJyxSB1/adqpRVL32joXa71YGpd1mh1BluyAK4czLsxuwmYq60bzhr
   9lNLXOY+qEkL7aaBx/CrZxHBxASbg084qaAzO786YdI6SYuPgFpuO/hld
   H5tRpBfQUBs55HYEAZcHSqAasShm6ynSc256565APiBkzTH/p4bDDT/Fl
   xUpTThGAiCXpkrQ7Aezq+4E5rAM9iKv/piMxW6byY543eYQPsTBTuQf/7
   7znacFE2OGLvirMoEeuVs8eVTflx97Le0qdgsTgQL7U66hbuswI47RzJI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="4566039"
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="4566039"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 22:02:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,210,1705392000"; 
   d="scan'208";a="14693628"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Mar 2024 22:02:53 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 22:02:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 22:02:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Mar 2024 22:02:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G29fTixjV9OOqnuneR5hZaVcg/kEkkrJor9n515M/KOY8WPvZBJfAU/cw9tfCO5W+SzitOAIqUug5uZ5JzezYXRzuz+lpaB5XKiGeBvjMd0NpfkKi0RO5zerZ3k2wpuGmUysfyOAxVGthIOmphCkAbGD+DJz896eELyXn20OTorrMWaSmBEDp/FeNwsZi0illULPwl1ivSoZ0yU9c+/BY6yn8wf9t+Bfz/VMDfoPO6cxxS+fDYBAANCwThXWs5nRQTSMQvTAeP7x35b386wil9FSQ/UiozebGbAD+OdP/SQFbSXo9jwzrC+BLka6gC2LGvSQafbJY963wuA9bJ/AQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAeOcM1U7cV1IoPUWe38Q9F0sGU4Xd4BqlC0nuxJfeI=;
 b=iBiRaBI3VFETCueuzHKDo2d2W7i0peme8hQFz/Kwu/BteTv9U9RmQn57TxIf8csnaFSFrZM5Z24KaUJEd84iNimVC76ucRR5+pOrYRkW6bspbIilfIM35ZwGPVx604+EO6hfA7x7SqEFuB2c0hhfbM8Gb5P9TCVxY/Zb2IntbmeXPHFHPbC3RBRMLKXTSk3RHJg828y6+H3MQ/8ri89odfAeTnoG0nsc81djkX78P35YfYl5RxHDuIg/VeSBj8hraKP1Ibq6POJrL27h+imI6Fc8wjsRT5VeJFCET7Sfjr0l3Tj9fVIdW7L0j95NG+Lx2ci8nUhxLWvUkROMtDlYTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by CH3PR11MB7673.namprd11.prod.outlook.com (2603:10b6:610:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.8; Thu, 7 Mar
 2024 06:02:49 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::b517:edd4:27fa:580e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::b517:edd4:27fa:580e%7]) with mapi id 15.20.7339.019; Thu, 7 Mar 2024
 06:02:48 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v3 2/2] Bluetooth: btintel: Add support for downloading
 intermediate loader
Thread-Topic: [PATCH v3 2/2] Bluetooth: btintel: Add support for downloading
 intermediate loader
Thread-Index: AQHabwnZA1ORBCi/KUmHkTPcywwhx7EpukuAgACl0tCAAFpIAIABDsrg
Date: Thu, 7 Mar 2024 06:02:48 +0000
Message-ID: <PH0PR11MB7585563CD6CC768BC0EE1066F5202@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240305144459.119564-1-kiran.k@intel.com>
 <20240305144459.119564-2-kiran.k@intel.com>
 <CABBYNZJC60s9m8D_KmYOT6R8+QY5_c5-4VgcgO8phpWD7ZTqWQ@mail.gmail.com>
 <PH0PR11MB75853FCEE7FAD4406EA64A34F5212@PH0PR11MB7585.namprd11.prod.outlook.com>
 <CABBYNZJojKayf2zHYGEqXtuYnCrgvd=_EY+nBXx+_CfwFrvZOQ@mail.gmail.com>
In-Reply-To: <CABBYNZJojKayf2zHYGEqXtuYnCrgvd=_EY+nBXx+_CfwFrvZOQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|CH3PR11MB7673:EE_
x-ms-office365-filtering-correlation-id: 1aa335c9-8d35-4c5c-ea2a-08dc3e6c370d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fCBSbOpvFpiw/tCn3/hnJvK7/kQh45fVaBhA+hrEhcVdx01vxWOJ7OoWduExay88xVY7olgHWNZpq7PznPNJ2zJgPAf0LUI0vPw1HSq1uZIq7+cG/ms5oWUFrjkrUGPaNJxsHatp9n6Pr4Zt8BpbZ8787wPRVICNwqAMTTj2LHdkTeAiv9GAHpFsPS1/MwGZVAZgAq8uYBWLi+Gn66OQ8N1UL7VXYSShWJpXbprpnRAHOgmgk/Qv9FHFVbWBk65mEXXw6NNkF/7+vzaZGr7ydCrAhS++jhmeDBQSVIczonCLTah7kpbe56f1UcfCcLYfPi0vjtFkO5ghT+ohcGoiVxfhmuN1OEeOVBaaLW6BcZJUlGe/pMaNFcGc5QvcB4B0hS3V4gJY3k2e8JEehHPnSPDEQmC5lQrkD1x8IGWB3vRmiy9nXr6NP6VHlWNai5M1ImHwEKUrXhUXQAMzKW7pxu5cI4xe3SzeTitjjuI2r8gFRFZAyqgoBkaHyZy0bja/YwaefIEcEMcB+0BU24DoVPv2nWDgVk+QR0h2RfRZ3nz+dlPkbMWqbLmyiZbpM1NGOMGABWtumd0If4BtWK2klxTDxtJoQxNbwSlvrZK22iwKpVzJ6+sruEYSWdWK6G0rV8uoXJNt5WrCKctAYtMrq47syb0eclMIh5pYvPvwKyY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUpEVElkN0swMTlVemE0MDVFK0h0Vkw0Wkk5YWdOS3p0TmtyZjF5c1BzYWxa?=
 =?utf-8?B?dE1xUHZqRmIwR1JWWGw2dXRhYStLQlU4aXljbXVjRGxMNUMyWmxTYms2cDNj?=
 =?utf-8?B?SzFmZkJRMVFkbEloMVdvV2IwN3FZeDRqSllzSFc4M3Z2citaT1A4dUh2SVBH?=
 =?utf-8?B?andLTkhaS0lrREQ5ZXVmNGxET0g0ZnlUYWlnb1dhdkFrK0JaWlhCVG9oTUwy?=
 =?utf-8?B?SHhzVXNFVXR6VGh0RU1KTjE4bExFdHpXRHV5WmkwMjlFRERQOExZanI4Q1dR?=
 =?utf-8?B?Zlk1azNiNndqOEZrRXhWV3hUa2txNXFvMkhjUkdNNFh6V3pFdnJqM3ZRK1pQ?=
 =?utf-8?B?a2RIMWVUZW9PWmxZZUFDZDFWZmxWMG5kMjRzejBUdmwrSEpZTHJPSDFMNDAz?=
 =?utf-8?B?TE5SZUlQWmpCc1lvM3FkcG4vaDFUYnQ2cURWUXJsOU1SRHYxSW1aeStVTVdt?=
 =?utf-8?B?OE1IdlBEWVEzWlA5OFU3UjVlM25ZSVh2eGdPY3hoL1gwNGpsQkU5N1ZWRjcy?=
 =?utf-8?B?cUxkNzJ4OEVMRkJVS1A4QXZpYzJFRUF1OC9MbkY0ejErKzM0bEFEMVpRV0NN?=
 =?utf-8?B?TkludkVPZ2xGeklyZ2JYVEhPbzBFR2FPWUpMWW9TZUZxNlZOOUZkSDhYeUNU?=
 =?utf-8?B?QVhkSnF1Umc4emdERTArbFl4bzNFeG8zUDJKOHloWDY2aFJ4Z25acnFRZzA5?=
 =?utf-8?B?OXFFck9jVjJVMFdhaVROQy92dEE5ZFp5TTFoT1lwU2JzL0RlKzJGTFFER3V4?=
 =?utf-8?B?NGNGU2Y2MHBmbUhzUUF0b2NHbTRJd3Z4aHl3WUJ4S0ZDa1NnUXBBaGxiVndy?=
 =?utf-8?B?VU5tbk1aMElIdTROREY2RUVwaDlCbFk3eWhCaWJlYUJUdG9oa0RoWVhacmRK?=
 =?utf-8?B?Z1RQdFFKaDM3TDBtSWx6dUEzK1U5clBZT0djbkxtdFI0UjFuVDk0Tm1QcHJl?=
 =?utf-8?B?SFFWWWEzR0NhWjJUQWh2S1ZpKzV4QS92RFpYR05sVHRrWE5MVTkzMVJ1N2w3?=
 =?utf-8?B?Q3VtT0thcGhFN1ZraDhPRlpHU3hpRGVRZFd6dVMybTdoYzUwYUx4NXdaQnhG?=
 =?utf-8?B?ekVuS1RPNDFDQm16cUlDTS80MldBZzVJbWxZRHFhOGsrbkFBMy9oR01nRHVB?=
 =?utf-8?B?eUZrQW5XeUhlQUxVRDhLelBOTFJuNlBHYkc2ZlJrOHVnbWlJenZlVld4SWdG?=
 =?utf-8?B?QkR3b3ZwdjJTWER3MnhVcExseENOWE1SZkdpSmNkUlBKNmZWWDVacExGeG9T?=
 =?utf-8?B?bmdGQVNJV2RvUVpFbzMxNWZBWGsrWDdHb3ZUZUdyZTRDcFR3d0xKaVRhYVB0?=
 =?utf-8?B?Yk9SdS85cEZUU3NMQWNFYkZmdXA0ZnZZNXU5TVJRd2FpeEVIWmJZZDloWWpQ?=
 =?utf-8?B?M0ZPRWVhMXZFd3FUc1JzL2h2Z2NSbGEzeWZaV0pMa3RHeXlKU0hjQnhpbVIy?=
 =?utf-8?B?S0ZyTEowN0NCZGF2MEhHdmxBUVhJdFZTNmpSbU52djVySlQ1MC9LUlVvdllY?=
 =?utf-8?B?U1ZnYTlBQXNPejJnQUxaMFJtczdMR1ZkVUtNNVJoektTSGY0bG1KWHBabG5r?=
 =?utf-8?B?SlR4NmVKZ1pGTnRXemd3UDdtVXkwVVlnNStOb0swRUJwd3oxcUdTWTRwanha?=
 =?utf-8?B?dS9paTN5NnZSQXlYOFlFSDZiRnByVHFuQTl2WEJmNERhVFpoZWJvck03cnYy?=
 =?utf-8?B?bm5yNGtCdTBwODA2c0dRN1htaGxOMVZiWVo0a0NWaU9lc2puZysyMklwZXhw?=
 =?utf-8?B?NlFVRjY5SWJ1R1VONEwzNlh2TWJDWmlGYWszTEk1c0M4UE9GOTh5Wk5wczVx?=
 =?utf-8?B?ampCT2x0eTdOSUovdjRXUGF4MCswRkl3QWpMbGlVTTZ6cFhlRFpkeE9SYitQ?=
 =?utf-8?B?U3o5RCtudDhxZUUvUEx0ekRwSmV3bnd1UzBMY3JmSWZCNHBWc1V4VjVjOFN3?=
 =?utf-8?B?MkliQzRPdnlraUhkT0REN1BnelRGbUt5a0Q5UHhBam85UE03M1VqUTdsM0R4?=
 =?utf-8?B?SFdHNHNrNWxxMHJMRllrY3dRRUdUNVVVT1J6bXBoS1E2MW1vSU9kWmFtOXQw?=
 =?utf-8?B?WmdkNnExS1Z5QUdKYnYyUENjU3d1RnV4dGNESEs0UzNGbG1Fa1pCb2MzakNk?=
 =?utf-8?Q?3rHQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aa335c9-8d35-4c5c-ea2a-08dc3e6c370d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 06:02:48.0235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z28RD7GP9ruRTh6AelO4VZ300VXeXO7iUgpoXoV7NsbawaMU/qMte/HqvSizT0rsQLmgD5SjJu9s5Z9d0SKeDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7673
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KPiA+ID4gPiBAQCAtMjE5NCwxMCArMjE5NywyNiBAQCBzdGF0aWMgdm9pZCBi
dGludGVsX2dldF9md19uYW1lX3Rsdihjb25zdA0KPiA+ID4gc3RydWN0IGludGVsX3ZlcnNpb25f
dGx2ICp2ZXIsDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNo
YXIgKmZ3X25hbWUsIHNpemVfdCBsZW4sDQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbnN0IGNoYXIgKnN1ZmZpeCkgIHsNCj4gPiA+ID4gKyAgICAgICBjb25z
dCBjaGFyICpmb3JtYXQ7DQo+ID4gPiA+ICAgICAgICAgLyogVGhlIGZpcm13YXJlIGZpbGUgbmFt
ZSBmb3IgbmV3IGdlbmVyYXRpb24gY29udHJvbGxlcnMgd2lsbCBiZQ0KPiA+ID4gPiAgICAgICAg
ICAqIGlidC08Y252aV90b3AgdHlwZStjbnZpX3RvcCBzdGVwPi08Y252cl90b3AgdHlwZStjbnZy
X3RvcCBzdGVwPg0KPiA+ID4gPiAgICAgICAgICAqLw0KPiA+ID4gPiAtICAgICAgIHNucHJpbnRm
KGZ3X25hbWUsIGxlbiwgImludGVsL2lidC0lMDR4LSUwNHguJXMiLA0KPiA+ID4gPiArICAgICAg
IHN3aXRjaCAodmVyLT5jbnZpX3RvcCAmIDB4ZmZmKSB7DQo+ID4gPiA+ICsgICAgICAgLyogT25s
eSBCbGF6YXIgIHByb2R1Y3Qgc3VwcG9ydHMgZG93bmxvYWRpbmcgb2YgaW50ZXJtZWRpYXRlDQo+
IGxvYWRlcg0KPiA+ID4gPiArICAgICAgICAqIGltYWdlDQo+ID4gPiA+ICsgICAgICAgICovDQo+
ID4gPiA+ICsgICAgICAgY2FzZSBDTlZJX0JMQVpBUkk6DQo+ID4gPiA+ICsgICAgICAgICAgICAg
ICBpZiAodmVyLT5pbWdfdHlwZSA9PSBJTUdfQk9PVExPQURFUikNCj4gPiA+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgZm9ybWF0ID0gImludGVsL2lidC0lMDR4LSUwNHgtaW1sLiVzIjsNCj4g
PiA+DQo+ID4gPiBTaG91bGRuJ3QgaW1sIGJlIHRoZSBleHRlbnNpb24gcmF0aGVyIHRoYW4gdGhl
IG5hbWU/IExpa2UgaW4NCj4gPiA+IGludGVsL2lidC0wMDkwLSAwMjkxLmltbCB3aGljaCB5b3Ug
Y2FuIHByb2JhYmx5IGFjaGlldmUgYnkganVzdA0KPiA+ID4gcmVwbGFjaW5nIHN1ZmZpeCwgdGhh
dCBzYWlkIHRoaXMgZnVuY3Rpb24gc2VlbXMgdG8gYmUgY2FsbGVkIHdpdGgNCj4gPiA+IC5kZGMg
YXMgc3VmZml4IGFzIHdlbGwgc28gSSBhc3N1bWUgdGhlcmUgaXMNCj4gPg0KPiA+IEkgZmVlbCBp
dCdzIGJldHRlciB0byBrZWVwIHRoZSBleHRlbnNpb24gYXMgc2ZpIGFzIHRoZSBpbWFnZSBmb3Jt
YXQgZm9yIElNTCBhbmQNCj4gT1AgYmluYXJpZXMgYXJlIHNhbWUuDQo+IA0KPiBTbyBzZmkgYW5k
IGRkYyBhcmUgZmlsZSBmb3JtYXRzPyBUaGUgb25seSB0aGluZyBJdmUgZm91bmQgd2FzOg0KPiAN
Cj4gaHR0cHM6Ly9maWxleHQuY29tL2ZpbGUtZXh0ZW5zaW9uL1NGSQ0KPiANCj4gVGhleSBzb3Vu
ZCBtb3JlIGxpa2UgYmluYXJ5IGJsb2JzLCAuYmluLCBvciBpbWFnZSBmaWxlcyAuaW1nLCBidXQg
d2UgY2hvb3NlIHRvDQo+IGRpc3RpbmN0IHRoZW0gdmlhIGZpbGUgZXh0ZW5zaW9uLCB0aHVzIHdo
eSBJcyBzdWdnZXN0ZWQgdG8gdXNlIC5pbWwuDQo+IA0KV2hlbiBJIHNhaWQgZm9ybWF0IEkgd2Fz
IHJlZmVycmluZyB0byB0aGUgcGxhY2VtZW50IG9mIElOSVQsIERBVEEsIEtFWSBzZWdtZW50cy4g
IFNvcnJ5IGlmIGl0IHNvdW5kcyBjb25mdXNpbmcuIEJvdGggdGhlIGltYWdlcyBmb2xsb3cgdGhl
IHNhbWUgZm9ybWF0IGFuZCBmaXJtd2FyZSBkb3dubG9hZCBwcm9jZXNzIGlzIGFsc28gc2FtZS4N
Cg0KPiA+ID4gc29tZSBjaGVjayBwcmV2ZW50aW5nIGl0IHRvIGJlIGNhbGxlZCB3aGlsZSB2ZXJz
aW9uIGlzIElNR19CT09UTE9BREVSPw0KPiA+IFRoZXJlIGlzIG5vIHN1Y2ggcmVzdHJpY3Rpb24u
IFRoZSBzYW1lIGZ1bmN0aW9uIGdldHMgY2FsbGVkIGV2ZW4gd2hlbg0KPiB2ZXJzaW9uIGlzIElN
R19CT09UTE9BREVSLiBJbnNpZGUgdGhpcyBmdW5jdGlvbiB3ZSBjaGVjayBmb3IgcHJvZHVjdCBh
bmQNCj4gdmVyc2lvbiB0byBkZWNpZGUgd2hldGhlciB0byBsb2FkIElNTCBvciBPUCBpbWFnZS4N
Cj4gDQo+IFdvdWxkbid0IHdlIGVuZCB1cCBoYXZpbmcgKmltbC5kZGMgdGhlbj8NCj4gDQpOby4g
ZGRjIGlzIG9ubHkgZm9yIG9wZXJhdGlvbmFsIGltYWdlLg0KDQo+ID4gPg0KPiA+ID4gPiArICAg
ICAgICAgICAgICAgZWxzZQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICBmb3JtYXQg
PSAiaW50ZWwvaWJ0LSUwNHgtJTA0eC4lcyI7DQo+ID4gPiA+ICsgICAgICAgICAgICAgICBicmVh
azsNCg0KVGhhbmtzLA0KS2lyYW4NCg0K
