Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEC81F5FD
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 11:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711971281; cv=fail; b=q+bIfj32QPHei67r/u004G5wctHPEqquadCfqSgU0dpxQcW/Jx5m7O2Jy1nWJtW6muNEn9iUZTGJxLXQ1XJCrfaaiU3sxIHBZywQF1ch8iwe6hI2nOmI/kyGlRei38zZX6hwrIlZhzS/UGHMzSbFBNtglU18solJY7/7Ln8u+YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711971281; c=relaxed/simple;
	bh=eNrKopgIH7CdXxUryWN9lg9GgHkH3t4rydfUqmgY6jQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k0ivGSsPj71RdFJysuJu4uLimzXB0XcoUMiZ8OOZofNKX5qP3/ftPWe+vNm0+L4dnKKCPyvY4P1a5zhhu6tABGCm+BfiXXDWLdCXGNoH9NlLaARaPH9tvLycmV/DwOt/FvJvkyByMwXW9wwouGtnnLO2eb2hINq9JSqfTtIl8Hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4PZs2Qf; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4PZs2Qf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711971280; x=1743507280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eNrKopgIH7CdXxUryWN9lg9GgHkH3t4rydfUqmgY6jQ=;
  b=H4PZs2QfJGum36/4VPD7UBcTbY1zfuwYZ2Knad+eb0RyM/KNSIWADr/V
   9HTo+csdf75KKGJM0pLgaJoj2LCI127wxmbk4CQYs+Y9Z7Nb0VdtIb8wT
   U0orsM7wuDUGhcpS/Cgh9Fe+amm1YJ5VtCJLofVf0ZTT9gLJPSVFh0u9o
   BZvff/wpDzpf7zLFZU5Vtc6tR+gyb8wP66Wb3Y4Apd2hLdxCsppHKPnJK
   Bi1yedi23f5Xc3pOarV4l6KVqzxN8HIx83runFhBvBzbuavnWEMm1ZlLv
   oS3iCy5LAP1TWZoFtTRidA8M7bp5/T0/XOfPbEn33XFnWZhSoYZghDKfF
   g==;
X-CSE-ConnectionGUID: LjtO8kzgQiakaP0w0k5gaQ==
X-CSE-MsgGUID: tAmMLdPVSF2aSzG64JTAYg==
X-IronPort-AV: E=McAfee;i="6600,9927,11030"; a="6949956"
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="6949956"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 04:34:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,171,1708416000"; 
   d="scan'208";a="22144300"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 04:34:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 04:34:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 04:34:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 04:34:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibw6w7sMAq3B+VNe23RwSixWHF0d/ljTCHsMWcN0BwPosL8lKoaZnNyPMKW/QwDWk2Ux+m4qqvd2QJJjNaT/v0p/fk5CHUvwl/aeT210By9b6xB5RqxacnlvsNJqmm9PPDZ5uE4CVOSeY1hvlIyQzqR3SXamLPOsPtvbL1UirILFz7yHDlrtP5VnLu51gOEWCEXseRWwhNIGiEIJWhw3Q4gNlrC0ns/a/1VsUDDUViUTFz9pmHKIobcsghFcZLBJuB1Jwo1DO+PR/sLWeSovZzMIfxoTrfWYP0elTTJiu6zQPrqLQWawA/rG86aVqzdCA2Qy0EvbNArOpyYWORd8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ajbaoH1pt5eYPaK7a38hPw+3MwdOI0bpcrM9A9ORCGQ=;
 b=GxcqdrmDp9bw/4kWuIVQXYAEY6NgaHwtb3CuqeAljLdiGjtDd60Lis+0vGKCCKryYCScJIHB7vJIKsuO8mt82I7AUiAZ7U9LVxBlKEAjweRQH//ZVW7OvytQqrFNOW9T4HT8fVOij0mTLK/K/21niNDNXaTO9qp6+IedaqGCzl+md6vjbz71IyPS+mG61HsfOgbO9dGiX48Xn2uExpp64ElEo5AIXYQVUQHo81PW1+C563aNuapKhOtq9ehZMOidT9hqVrrvMaEtlS6Hja8SHzyaOPZ3TbsJrJGNZGeQ1asBI9Kb85pwbaAuFXily3xZ8/UQfwPjXRkFahDKjEoGLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DM4PR11MB8160.namprd11.prod.outlook.com (2603:10b6:8:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Mon, 1 Apr
 2024 11:34:27 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::d6c2:e80d:7256:8a15]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::d6c2:e80d:7256:8a15%6]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 11:34:27 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>, "Devegowda, Chandrashekar"
	<chandrashekar.devegowda@intel.com>
Subject: RE: [PATCH v1 1/2] Bluetooth: btintel: Direct exception event to
 bluetooth stack
Thread-Topic: [PATCH v1 1/2] Bluetooth: btintel: Direct exception event to
 bluetooth stack
Thread-Index: AQHahCe+oS0EgrOR7UWulnqqI7Kn3bFTSISQ
Date: Mon, 1 Apr 2024 11:34:27 +0000
Message-ID: <PH0PR11MB7585F23A84D7746681471237F53F2@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240401114214.1082870-1-kiran.k@intel.com>
In-Reply-To: <20240401114214.1082870-1-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DM4PR11MB8160:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /FshFh3fhL6BTbhBdJWBJ2YPXOb9UqUd9hYLjtn/OtZUr6/ymjW/JQc208Q4+Fcekc1vHKLd1u8g+EpvqYHxYRzYdwHv/qdi7/9eXdgpvVL6Hxzb4FJqWc/4LpZ9ud46XmH2kNDNE7bmRgFdapaIPYEyTGt19QhAfmPQoqVCTa1sfwuwSYcaQECRsEO+w/zXHdtbt9R8w0fycHEmrE8Cj2hmF7scbr3eA87m/1yubeiOPfdGF8ly7pyw2OksBedj5PXxzffL0JhM4VDt7hixVtlxgcvpDZrvF6rIpSlQj58LIbiRc15NWv82Xy7Rzq9jKaXjBuUv3DqrfdcD0ni41bV+Ivxw5hJHl0gBurtsR46S3K73d6wntfkb2ojffBCZ4/gWhiKhZnSsdi7oB+R7kUPT0ZA/gveO+Ev/bOYWJAFxQqNQFhgEWcg1znL2XeJ/7wct+wOTQyPJG3cLa431Ep2KCKiNNdBeRXNmy9CrCBarBLjxbRJ4eZm2BgLwI9pheLbfHaGnovjMD3FUBjVTWJjg3S/h/2urtNmTJLAkRAlQPCW6TbH/t2HAOiks9rlxLxhidqdmKhJ7lhkshjffzlpBj+le3l6mdrDZBUdtYpC/BE4LVxVeHwG6AUzYhGgEwuvuhAUvG4QtaHLuJADr5D4qi12hlGiVX86kKlu+rP4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fR3aTKgYD8qqQNqQm2Q3sXPj1zSSw0dv4B00pAhp66oSCerGo/Bl1UEDOJLM?=
 =?us-ascii?Q?RUrYDfAUKlZOsLJUP8KuH8Q7IKQHO3l+BArnezXQMj5C+Ih0gbNfJWo8mxhg?=
 =?us-ascii?Q?ZtvCAkL1k08vh/Cg4IGyDOcAb8j4Z+mEfyk429QzIw9vDF9CpoyQHmjIelTd?=
 =?us-ascii?Q?UwyFlPr2RL71oym+1IXZcNXTiUyNi9h2eEucgiSbH+rGy6Uj9o/ImcEzqlA8?=
 =?us-ascii?Q?dLAKFffKnUAafwd4wPI25rkIt/VsvwHHtYJ3cAQ8EMtA3frTnPj4kOhfdpPv?=
 =?us-ascii?Q?ahrmRm4fRRuo/Iq1upKBJKcBCe5wAdUHxDdUDxtyRFhnsZwWSr4dp55KoAGM?=
 =?us-ascii?Q?KbDbmwhmtrGgH2zH+0bnZo4sw3zSAXST/8OBm8Vd34uTKk3e5vrvl+938tp1?=
 =?us-ascii?Q?KgInLumZ4ZKLQ6coDiAH1/6KlR6eBTXof4C8orn8VT8Abo7joqIc674TcmlH?=
 =?us-ascii?Q?wacdsCbyvT8OhkfLtDddwSP7b9+4mLcoeqshVYJCIRJgvVF/A/jmkE/BPkq/?=
 =?us-ascii?Q?wNyRgHlEUPnDyIw09gDrNrU7wDRtYqtII4ni+Ml5iu2t2vBOUbgVIgWm+VQY?=
 =?us-ascii?Q?GrC8PmTjIbvDbQ4ETdTzISMhPuNBbDg3HjAMbZYDXsqBMM8TmMgZ84waRAc9?=
 =?us-ascii?Q?V1y2ndA30unQ9I+bzfMjnRSM7WZ5KCt/IjeA9vLTD8e4z6uFPu9iSD4nB7Ia?=
 =?us-ascii?Q?e0se7+kJkQKNbibEhE1xfTJwDI/9TeWBt+3lvycSEAyHNWFz/HbMyrPwk+e5?=
 =?us-ascii?Q?K3Xrw2LWCugfswcXZXbHIp/S/V2ZrdJyn2vigSCqhLo4AhptLraEaSCrL2Nn?=
 =?us-ascii?Q?dm26Lt6z35S9eozihHsgVkwlHlnzJYXMYUHx1wDAwsYA/SJwk5Io5CUxNYEJ?=
 =?us-ascii?Q?acWLoZOWim37ucbX+ElGhHzQ/VLETp0BUnZQv3HaMWy47qADBkZII9vlfTiJ?=
 =?us-ascii?Q?joOtGfLgCMYAg+CkmbP8exO5YOjpr4rmn8+4SFisOL5/1EefuO/Pmf2QnoV/?=
 =?us-ascii?Q?1Kjbr49Vu5DTPNb3nFNsUt7ijQhib/Bvp7yA+njzsNPKcOPxQ7gxgftpi/ep?=
 =?us-ascii?Q?FNALYA9J8rsk2ACwYjWUgNa/tGDzkc2VGGqqvhYOVCUU085CE0f06oCfgVgZ?=
 =?us-ascii?Q?rUiHqa4PpTiyV0JwLEkXWUG92az2oOcbp/vgDFOrcDej/m18IYABOfDQScNh?=
 =?us-ascii?Q?91DTchJupCs1m03WBZYSiqgNnv6WhKrponVXhe24qXaMgjsUfpRBUPvlemvF?=
 =?us-ascii?Q?/n4h4SGyehbCrm95YANT7KM4yKzaD/9UPuiPGMk8M64kwrJ6/fEvsQCdrHYq?=
 =?us-ascii?Q?XITzEcc572EFnDW5XIZ99yROYn3pkbem+SnEKC4SbuEPahvY4rCayzgs/wiP?=
 =?us-ascii?Q?83VzHtqgtuPkpSQBZ4hWsROkzgBOqjMiDeB8pQQmflivs6QpRzlxoKdV9Pmv?=
 =?us-ascii?Q?yhIhyb5DGC+Ld9NV5bh8DHwMOm+m1Yhvgowts6CJJT4Gm55zxP/IjvnntdcR?=
 =?us-ascii?Q?VeoOUHPV3YuwVt+/rsFRiuAMZT0xTt0FRjVd89tIfIzf5FGfoffvO61Aw5aa?=
 =?us-ascii?Q?pwnWvljOnRMy243t6rQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 290b950e-be4f-4e80-e9f2-08dc523fb038
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 11:34:27.2338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PUgE9U7WyoZRfrcIxQ73eR60ceQCeBzyWKmfN3tukx3bX/CcxEUyC/A6Zyoz8eCS1agpDq5AiOtFHr4ybEImnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8160
X-OriginatorOrg: intel.com

Please ignore this patch. Sent it by mistake :(

> -----Original Message-----
> From: K, Kiran <kiran.k@intel.com>
> Sent: Monday, April 1, 2024 5:12 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Tumkur Naraya=
n,
> Chethan <chethan.tumkur.narayan@intel.com>; Devegowda, Chandrashekar
> <chandrashekar.devegowda@intel.com>; K, Kiran <kiran.k@intel.com>
> Subject: [PATCH v1 1/2] Bluetooth: btintel: Direct exception event to blu=
etooth
> stack
>=20
> Have exception event part of HCI traces which helps for debug.
>=20
> snoop traces:
> > HCI Event: Vendor (0xff) plen 79
>         Vendor Prefix (0x8780)
>       Intel Extended Telemetry (0x03)
>         Unknown extended telemetry event type (0xde)
>         01 01 de
>         Unknown extended subevent 0x07
>         01 01 de 07 01 de 06 1c ef be ad de ef be ad de
>         ef be ad de ef be ad de ef be ad de ef be ad de
>         ef be ad de 05 14 ef be ad de ef be ad de ef be
>         ad de ef be ad de ef be ad de 43 10 ef be ad de
>         ef be ad de ef be ad de ef be ad de
>=20
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c in=
dex
> a19ebe47bd95..f2670bc2367c 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -3135,9 +3135,8 @@ static int btintel_diagnostics(struct hci_dev *hdev=
,
> struct sk_buff *skb)
>  			hci_devcd_complete(hdev);
>  		} else {
>  			bt_dev_err(hdev, "Failed to generate devcoredump");
> -			kfree_skb(skb);
>  		}
> -		return 0;
> +	break;
>  	default:
>  		bt_dev_err(hdev, "Invalid exception type %02X", tlv->val[0]);
>  	}
> --
> 2.34.1

