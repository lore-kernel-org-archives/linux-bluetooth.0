Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF3916FF2B
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Mar 2024 05:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710220351; cv=fail; b=r4fPT/caBdt5YCXeNfJ8vhsC+WhMKLbC76nt32pVkeQ5+aTCVtZXSpW3Jjqh+wOlt+ELCu01gTxYmyTFuvAANTFsD5L0vQ3R6VlbInSTt60IMGCsi2VjcEsWFJRiTWt6G8zs5wv843TWvnsv4Y5OQFk9adK+ll+f/bl6k8lIWcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710220351; c=relaxed/simple;
	bh=9g1t0TOO5T93ESEp9g3HbrQvTIUYbjnZjr/Tmzf9QgU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fdYgFIoVJmAlE1Q480VTviutWQVdYsB5EEr1L4y/Ze5iQ6ceWRssSd6/5Pa7nrEWMSjaeynKmR5bYPgSOA7jF3nw/dUKskIanOUWFQh5BoIGqGND+V6nzKWDNslOHuNkFl9wVz/BQGxFt00F65wv/Rl4dE7+lcxwqsiWb64rEvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T/MeC0/m; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T/MeC0/m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710220349; x=1741756349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9g1t0TOO5T93ESEp9g3HbrQvTIUYbjnZjr/Tmzf9QgU=;
  b=T/MeC0/mSm5uhOMLllu7Olxp2977mNKmdwIJooEmvQK/a2+EkRkkEzUy
   sZHAWNNKCCosK0IGQ2e83WTexRuTZeGFB5Bbjx3/XKNx3ZKcuG0vvg3cx
   oAGCjNn0fuXy4MxHEEdPK/YvVhw3BTbo6UPMvaT0hRtaYfzg7JmvBZeEM
   1fCLhfCNiChtiXj8T9p1o98bMTME9uSvbl/5NdS6pMvZlRi1ZvT8it892
   +WRrMkf/f1FbAiLWd876iGKx/aBCtLwK12Ng9/G/WAaCRy8E09QJM9+UN
   Mg/C0F+JmL2tVAS1wQxBNACfwN0Je7RZIyv50c2wXxrMN5jpUdg1dpnkn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="22431019"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="22431019"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 22:12:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="11482482"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 22:12:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 22:12:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 22:12:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 22:12:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 22:12:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO2epKO1CrNX0irdjZkHG/Tn6/kH6AxaLsEL0pJMWCjH7ST99bi+IJkvO/1MIKUdk3khpUxtybdBfa+7noRTHjPorGqkOKop7pCfAFezQPzGOStbmJ59rkAQHcUGSlEZ4EGqdjmQ8M/HQIk7e9iSf28lU2QymQAg9C21XaebFd8l/r+bf+D/+dYwWMFlA6qT79vI1SUe9Dfsv7fM/248WZHKcJ40LTHbLt4xyfOrn9Cs3Ws0bRGZeSOFqmuxEBwQmPhmOAku59N4wibN71J+pqLIrAzTlLgUlNNaZigcg/YiYy2L+4bHif1zPZVfvE/flL5joO9w+AC9KroPvKCSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IdWjamaBLw5uKLL4p6t+qczdEOuIui6VXjG0DYBbNWo=;
 b=Kslx5Ha8mIuj/pMjSNhdLoLaowFhHO/f95k0YaCoVQiDiHeU9ta9GilpYAqNdwU4mQwppGrUsAUgRoNanvWCgc0uGoQ561Y5SscqLJzGAjnLkIBaQhUiUYwRe8y2HOtVMZ9u+/EpaYC4FnsYuPcrJaoFjJ5HNRH4PylodKbJrLnWQKfbP8RPg0SeKf4SdFU3404vvDGaArP5bU4ggGFggYuYmZrPySD4To7FhWntPQMhoLi4tN0vk69yU9/OF+w1I0sWUpQjq+gfnhYqMsbqO/JPkdzT3usHHVryUra8zIDR8e+neRis0xmIJ8UDDgbAyxAHTsJTje3eF5/2GjmGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by PH8PR11MB6856.namprd11.prod.outlook.com (2603:10b6:510:22b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Tue, 12 Mar
 2024 05:12:24 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::b517:edd4:27fa:580e]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::b517:edd4:27fa:580e%7]) with mapi id 15.20.7339.019; Tue, 12 Mar 2024
 05:12:23 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1] monitor/intel: Add decoding of firmware SHA1 in read
 version event
Thread-Topic: [PATCH v1] monitor/intel: Add decoding of firmware SHA1 in read
 version event
Thread-Index: AQHaaiZOiNOGlq3E50iktPIX0H+vrbEzo0TQ
Date: Tue, 12 Mar 2024 05:12:23 +0000
Message-ID: <PH0PR11MB758519AFF52DAB5A86422715F52B2@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240228092504.3716904-1-kiran.k@intel.com>
In-Reply-To: <20240228092504.3716904-1-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|PH8PR11MB6856:EE_
x-ms-office365-filtering-correlation-id: c06a6bd7-a4c6-45cf-b741-08dc4253006d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Os8JE4M06o1oYrYI+WzTapFXtCbbSzE1zoNJykeZQa9aceNaiB4ij7HU1iBDmykTxgGNgQj0a4RbADh/1IoAQd/VUzzyW2XBkSiDYn+TIb5aM+XrRiE5tpAnecxe7zdtIxev31bvjVfNy0OTR7Nw8Qkgm02kSGLWZ4dzcfb0NumCySmjQyE6wAKM49JU4ZnF2wwjgzj1DAN7SLg+Lp1Z2NGGRChV9cG/bJuAP2YeA+RbNtWweG0tiVegGjpVOq5DvNb7TcFRiy6gb2c88uQR5R6HNwncQ2qtR4u1Xi9sMKf0Iwbx5TEDHMK/HdGu6bV3LOE+Qb/y4ud22NoUelgIduWoGrf1x7EMdlQyQDlrIyD82LKk02vQ2E4eEPKi+VmTamInJg3Z/XSWfH5h5MkBei+2aAM2GKnJXu9EwqsJuORz9IWYfW8CyfVshdcXYfvAz3P9tWNbmxCn6BiJNA8EuKyscsvYvtGWNJ9NStbtL/kVLOhQgH04+DMm2wb9ss4nbNL9LlJifTaQwOuM/d+OTlGjbO5batEbu3yE/rp6x+O927Wek2C2Eiv+lFCCdxq6AdI8oiO40iSkdpAheRHtpi2kypq2i2EYnuoTD2K0IjGW39YU4li7VQHJ3C+6RRxWX1KAIk0qErS+JW9E9/5TGxQ8DknQvQZxrmDSqCkGE+/uAEuQtECOTQ8bIGb6nekMrGTpvET2ooYMhJw9knA07Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?95Trc3vjL8DmduDZdhZbBtiL/1lTabRntv6MVI4XCBTooAP55wMLtnOgDxoy?=
 =?us-ascii?Q?YjZd3zd7DOPXlelG1hR3W1te+OO6kWJ6axTD6L0REThelzOe55y1zcKqPycW?=
 =?us-ascii?Q?PkA4UYbSdgmlfu+/DVD4fPwpiR6EBoqGni0EoA8ivjHYIWOORZsjiJ553AU8?=
 =?us-ascii?Q?QquuhtoYNSYnRyVX/bsx37SpWuATM2ymx81t6no2pY9+uR5j6nFogxqIK1US?=
 =?us-ascii?Q?F4uj7o7cIB4w5TLiUuSfxwIcPX8vx4fTN6DbvUKM1z6gy3yy6raagw3Uyy+6?=
 =?us-ascii?Q?pmKUqZ0pEJDj9LCogylQrLpUv9g9KOCOGFLPoelPqxeKoZ/U9OtySb2zNyB1?=
 =?us-ascii?Q?OEwrufWYZ10y1kBqRqCVcxfWpm8PVznukSH54a7eBflQz+0YQ+VLeiolZZqz?=
 =?us-ascii?Q?7CRfSfMJ0rQ2RcJlB3kBzu/2lStKLwGZPf0nTOry/3EVCSmXcTBjqCfv9KH7?=
 =?us-ascii?Q?0LOInMK+4l7pFccVexZ/RBPwcid7x9FBHtkMNETJ+8KSnTnocW6hlCg7v766?=
 =?us-ascii?Q?16kldkb1OkGK6XqfScCbLsAojToWZtOqLQLxZXTxf6yqpMFbTpg2cAFREflP?=
 =?us-ascii?Q?/53/+JbGHfCKxkJcoq0VovgDi561hZmyqZYfsXQPhVRkTljuMgV08GpJRt9B?=
 =?us-ascii?Q?VScb0ySo10f/XDVCGB0gUc6WbcGy3Ou3t61RF/Qw2ANh88fXB3Jxr+ONbadG?=
 =?us-ascii?Q?Drn/EJ8d+JFsWRYPGcEQ7CtgVNg6PvEvpuwsWM6qQ7rM1/YBFcv4W2ZkY7RB?=
 =?us-ascii?Q?8/IaGZ67U5TRn9c3/tTAF8/XRMqKSVEk6qo95lLiGV3rS9L3AW/+9DqetGbT?=
 =?us-ascii?Q?SNsRa6mL/QaK9Z8rzazDi3GwzLWVv7tKOMzNfwBOXUx7iIyZs84FW9fKenlV?=
 =?us-ascii?Q?ZDvqXqN6Fnvx2ZbqIyXJx4aly1dSg5RHF8z1t7BbjPlIXi12JIaMrqfRTiSo?=
 =?us-ascii?Q?4k7+Vv+bNihhKLqA7jE6/IiXSbbmpBh0AUy26cNpPYUsDCsnXCfVl/W3xyH2?=
 =?us-ascii?Q?86X95jiYFD5WgeBVJBrgqFf44xBgT70hoUIQDZin3GBBOk0+BgHyVhnhmz3P?=
 =?us-ascii?Q?HW6WrzSfCiafyuTgRUUrlHLFb1Ezx2spPVrRFcYDP2vj+2mCM9ukhaOXan3M?=
 =?us-ascii?Q?2L0vJtV6wVca4OO0EtZVWgGzbNbIGVooYzNpvWL8wsdy5ZuJiYuPuKRcHBJg?=
 =?us-ascii?Q?8JpaE5URS04UpQOaNpRtLvMvP32QteHgMdEd9bU+PaNAKtDh/KAuy0youDGD?=
 =?us-ascii?Q?z3HM+sk8BaMsKprmUZ0275jQpOxONS/HyvhCwOT/ZgfQ+lhg88ADscUTjsy6?=
 =?us-ascii?Q?Rg2fqo2T8Ipm58d7Gnw+My6Jr6ntxFeZ1cpdIIXcZzT9tQApuLq9CQ5lXtJl?=
 =?us-ascii?Q?/BZXsA5hx/wso9x4IuBvUVsHO/pn2YIftOeApqF7Ghzg5CrjOJoApt38MwAF?=
 =?us-ascii?Q?llnm9Qo3Qd5b8ahq0vUgnTh18eKyfWuZK0zNDQaPPo8ivrc9PdLYBOtJYsA9?=
 =?us-ascii?Q?d4wPc/dun45CFT8qsrra4tkmyyH60M+VcYLWwQnIdw+B4SW+IS1bXwc8KYBN?=
 =?us-ascii?Q?GKd1pauiU+MiPcSSzBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06a6bd7-a4c6-45cf-b741-08dc4253006d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 05:12:23.6142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y/Zk19zoh7s/YIBNQyHqlFYh3iRWVNBd5Hn613XXEt51MPkMfrHJShUglrkrjWp5lgud/pwfH3kJDXAj8jd+fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6856
X-OriginatorOrg: intel.com

Hi Luiz,

Friendly reminder.

> -----Original Message-----
> From: K, Kiran <kiran.k@intel.com>
> Sent: Wednesday, February 28, 2024 2:55 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Tumkur Naraya=
n,
> Chethan <chethan.tumkur.narayan@intel.com>; K, Kiran <kiran.k@intel.com>
> Subject: [PATCH v1] monitor/intel: Add decoding of firmware SHA1 in read
> version event
>=20
> < HCI Command: Intel Read Version (0x3f|0x0005) plen 1
>         Requested Type:
>           All Supported Types(0xff)
> > HCI Event: Command Complete (0x0e) plen 107
>       Intel Read Version (0x3f|0x0005) ncmd 1
>         Status: Success (0x00)
>         CNVi TOP(16): 0x00400410
>         CNVr TOP(17): 0x00400410
>         CNVi BT(18): 0x00173700
>         CNVr BT(19): 0x00123720
>         CNVr OTP(21): 0x0413
>         Device Rev ID(22): 0x0000
>         USB VID(23): 0x8087
>         USB PID(24): 0x0032
>         Image Type(28): Firmware(0x03)
>         Time Stamp(29): 23-42
>         Build Type(30): 0x01
>         Build Num(31): 0x00011d97
>         FW Build Product(32): 0x06
>         FW Build HW(33): 0x06
>         FW Build Step(34): 0xa0
>         BT Spec(35): 0x00
>         Manufacturer(36): Intel Corp. (2)
>         HCI Revision(37): 0x3597
>         LMP SubVersion(38): 0x3597
>         OTP Lock(42): Disabled(0)
>         API Lock(43): Disabled(0)
>         Firmware SHA1(50): 0x2e575f2a
>         Unknown Type(51):
>         00
>         Unknown Type(52):
>         Unknown Type(53):
>         00 00 00 00
> ---
>  monitor/intel.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/monitor/intel.c b/monitor/intel.c index
> 0de864d8a41e..aa05a803bf8e 100644
> --- a/monitor/intel.c
> +++ b/monitor/intel.c
> @@ -291,6 +291,7 @@ static const struct intel_version_tlv_desc {
>  	{ 47, "SBE Type", print_version_tlv_u8 },
>  	{ 48, "OTP BDADDR", print_version_tlv_otp_bdaddr },
>  	{ 49, "Unlocked State", print_version_tlv_enabled },
> +	{ 50, "Firmware SHA1", print_version_tlv_u32 },
>  	{ 0, NULL, NULL },
>  };
>=20
> --
> 2.34.1

Thanks,
Kiran


