Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985AD210F4A;
	Wed, 23 Jul 2025 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753274651; cv=fail; b=RybnVaGjsADHP4imJhDanAJff1NE3WX33YptJVzyWVkxfh3odj1T5A11UOQ0QunTVDxV5d+APWaGBdJEvifhSn/6mAhmXsrTbndJvB/T6qknjWeuxhtEpkTT8UzCYcQ0zQZiX9Hj5iO/tPDrmwps5gMMpr05S4lbaWKAin25Oqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753274651; c=relaxed/simple;
	bh=/RBXTjLHexNsuPE9+CGVYNjOS42il1pTAT7CZqvOFOU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rijazkBoCNstlozG/knARRZJTWI9jkRUftW1hBWpxKGoUOoOU8qEvMtuw3u5tf2Xj4QUNLHY/prCumQJILt6XurR1euTo82MSdUBDOFrx2B8Xjkvz+dl3oICpag4F7tsVaUDvqRHDn+83xTmiu3wEwTe7rZO2gxtZmg6zVsYwE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q77chXgl; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q77chXgl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753274650; x=1784810650;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/RBXTjLHexNsuPE9+CGVYNjOS42il1pTAT7CZqvOFOU=;
  b=Q77chXglC3KvkfmKsukUCQ6nZP+q44lZ6DbNg0PwW9nQ77xXMlRJjt+5
   g7/03WgeU7kHkAb2kO/FVWMJRWkTtMrV/HdeqDF2e/rLMIH/0FqkRuShA
   5/YZukHK/5blQpXuE4jnu2HrtJvSwyNhzPmW7epeI+7kaYbdGIRFM1SUE
   GuNird5OhjshMq6YiQv0TAr49MGUCADQFjoLYgX7sXTfRIV1XgYqouBp/
   5LKqV1Ov4SUBETKysDcvBASLSfjSGjsryg7M/sDmcIh8KhEC4msES/Zh+
   /at9PwDJb8PcyrVSHPF6AMrOB8LFQKSGYnogAeAUfWIG+HAOPpDwjg8N6
   A==;
X-CSE-ConnectionGUID: 54S2UuUBR2mN6cwSO4/YiQ==
X-CSE-MsgGUID: menNKsTHRpaYdUccAyNHsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="78091421"
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="78091421"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 05:44:09 -0700
X-CSE-ConnectionGUID: kV4Pz5RPSlyDfBHb3AkJnw==
X-CSE-MsgGUID: JvtKCQWjTUOf48Iils4N1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,333,1744095600"; 
   d="scan'208";a="159518210"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 05:44:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 05:44:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 23 Jul 2025 05:44:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.72) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 23 Jul 2025 05:44:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI6tYtj3bmS+jagRsbji6H/VZOqE27ocD75lAmT0aTtdE3T/G5uwhEcyr8SWEuz4jCfrpmoXgIRw+Ny79Egx69riyQ9Yfz6zXF/9XhKd0bu/vNHbuBgq832h6k1CVxV6ZsKgdSeOIxBMRUlq9Z7zAs4o1l5/RBGTlF/ljoFHXgXJHpEj9WDUgo0t9w9V0ybmkxzBcz4Duil71K3dYYzOojcGkqpbjNvG84YyDb8ZSd1mKcUNHGDCs28k3N6T80VMh9NBXybr3cFsWODIzeN4Bm5Lm4v924y5OUwhT8wzz1j0AWdVvaqt0KotqVLwj7ua+ttgUmhyKrarFxQ3u+fXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMN1IlEbJCE0GbBeBMY2a7BSVIFlQWcxpiBSyXXVrtc=;
 b=Yges8MegZeFSqneT3/ulpHkBB8cZnVJ7UgZrMK+57D5HGOCXMlzUgTQpJ6LOTMYFkxhQ5vSxHIfCiG9KlPGv6yrwGVaNvXmB/iu52/FiWLYwXdl/ZcLCKkd/NpiN0EuQNNg4VjNIgqQh8+10nM9HzGXQqIfJIADpl62x0TAisQEqLLLc4+kpFu2NOMSCqzZ5V93gBZhMgF9ZZoSK1FBYAQ4T0SrK5r05DfswAexbjgAtLW9Fd3CMygFE3KhqyqLcvG59W0yRP7LvY9p3H/hKeLrC0cVyt2BHH4deCrLPR/wb8ahdb/5LqaSpKvnSDVCGPO17mM01M6qqnUf0d4z5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SJ0PR11MB6816.namprd11.prod.outlook.com (2603:10b6:a03:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Wed, 23 Jul
 2025 12:43:23 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%2]) with mapi id 15.20.8943.028; Wed, 23 Jul 2025
 12:43:23 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Salah Triki <salah.triki@gmail.com>, Marcel Holtmann
	<marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: btintel_pcie: Drop pci_set_drvdata(pdev, NULL)
Thread-Topic: [PATCH] Bluetooth: btintel_pcie: Drop pci_set_drvdata(pdev,
 NULL)
Thread-Index: AQHb9sp89z0+ODq8mU++U4T6yuV6l7Q/sNOw
Date: Wed, 23 Jul 2025 12:43:23 +0000
Message-ID: <PH0PR11MB7585C9C53264028687071050F55FA@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <aHhtIL3jyVbCEMqh@pc>
In-Reply-To: <aHhtIL3jyVbCEMqh@pc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SJ0PR11MB6816:EE_
x-ms-office365-filtering-correlation-id: a160da58-213e-4a93-08af-08ddc9e68300
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?O3Z5FCbeC6WUTP/kwMOoka43OgNwj3HVnso/PeBrVUy9lqB3SvvIPUu7inWD?=
 =?us-ascii?Q?dvZsgHhW/5L+Gx3vzjbTeXCri61G/nva2mZ9at9afmD1Li2nmh8qEN6RseKT?=
 =?us-ascii?Q?q3KbXKdAs+r6h1r09XC0wsxNO4XeSvdJIce+nG+waaVDvOtp08BGrv9Px0gi?=
 =?us-ascii?Q?uI578Fp9rnL+HrjArWD4fl6HeoZ9CDPNnnEe66uKlJR3pVGGVJ3GfDtQ7+vY?=
 =?us-ascii?Q?VezHmoRYSWUGYYjKv6YSKmX7xWPBivWm7j5B7xgHHtnTRKIMWGiJYkkjmJIF?=
 =?us-ascii?Q?bJrbz69osgHMFtzETrt7hFDufjjtz/0N1l8GB+Fg5XyRVcX159VaWLRWL6fL?=
 =?us-ascii?Q?NsSDXlMKo540I+ab0te330BXwh+zRRjSKGYcwa5QS4rR1osYcXD5L4//X0t8?=
 =?us-ascii?Q?1jeJHFkUaMrSn2GduIms0+YKbtbmw49qDmmGovyC/ETW3EczfO259H1z81br?=
 =?us-ascii?Q?R59wtVSCV2N19axTxZWXJEPi2kq8mbSzkZu89lVgPZ7an2a1+TW9R9HT7PRL?=
 =?us-ascii?Q?Olthby0XQ1q790UwYp93p35PmtseJQejwfDtR53GznFeFzV9fEkOZBcWkuWp?=
 =?us-ascii?Q?7dRi8gdebxsPuwY6TG0hIOHq5U98nUswihTE8K4qQViMMA9FpEjSFDLe6WBa?=
 =?us-ascii?Q?Oc4Bzh0XS96LNAhcqNprl8lSsxbbZMeQL3f0RIilg+AMZn2ibxs2bK5rTipw?=
 =?us-ascii?Q?PSwn2Qx/z6fSWymJMbclFxlSYMCeSi++0RfOj3fzJWhMQcUu1FY+DAajISde?=
 =?us-ascii?Q?gXEfxJvLE4brO9jK20uVY+3g19N+SGDKUN7kOKIzJn1Qm4C+M5KIzcoD97qj?=
 =?us-ascii?Q?uLnTrRkNox4J5oQ+RpxEwbmwhNIZPCjmrV4qaHBAje493cYeu+zZGCSYRZzM?=
 =?us-ascii?Q?DHN+WPtt4AbgczHOExPf/CTajUG9In7BzQAyiRIJBIiYjy/pI8zFEq3bVoiK?=
 =?us-ascii?Q?PF8M35gbZkwWqus6I2DEnrsG7XtKF4EWVhLwUPxIzdyA9QNz4iBU5OTw+Rkk?=
 =?us-ascii?Q?00SQx+I//dh7LcpgdPcm10wWiTnDtfUDTT+FGaI9P4wktK8SuIsP4VarcR4h?=
 =?us-ascii?Q?5kIhi27UsCYvjk4mKTqy33fvnkapwuFByFGU+fTpDrZFuhPKdL4gRHC827et?=
 =?us-ascii?Q?DkePJLj8YB24u2QJ1WexiG6TPg8aq0GSqd7d0fbdFr9UEHvPe5rZV72FbSRL?=
 =?us-ascii?Q?4oM/4Z2JMbUCbQDsiw5p2DKgpMlx9KAfMJVFSurojaM3MpS4AHGtKFi2RFI9?=
 =?us-ascii?Q?YX1c8wcenM3GSavUIkpDNCeA4NLvtmBXy512kcNJv2Tk7gVX0/sL8yRjwVYs?=
 =?us-ascii?Q?2WWJjc2u9YbsOC+dwHlW3frW6i0RqyVLA8OoCqm1AHsz7iPHSElkhRheTC6m?=
 =?us-ascii?Q?GQyZ2s3G6G26cl3FDnuu1TU6QKjMtnOeqtOg02Y1a0m+2R8/aocShcPCb4MM?=
 =?us-ascii?Q?WYKTHVxOB563fv7ruqi4KXt3PHY2cIJ5Qg1AskqS0ISnx7mepyKVhQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9ffFZSd7cX2Qyhm4oZACoSS/8zMCI64lDgBUF9mIpeykGIHEdTaPD8KAwcPn?=
 =?us-ascii?Q?RP84NSYpjQyHXzzuwXm5FzBaZmi7H2FYbelCQrdvstt3Tt33ZWHUwLIekN4R?=
 =?us-ascii?Q?xx5p0eOgzp2WVmBnyrzOOSkKHfDmR62Qm3O7Ag5mZYRQTOj4L8V/070fwhP4?=
 =?us-ascii?Q?pkuFFpGYLF1yJYHy7lZppxcD5CbnlpBlOpNsVymV+dC3Zux7WcnF8BijcZdN?=
 =?us-ascii?Q?/2v9/wa7mjAm9WoIZz01Sa3Ny4A3BdfQWN/HZBClL/rCH3DaSrOtWxaKfwcT?=
 =?us-ascii?Q?eUNeC8+pQo+mpTSQj267rSt0ZOf1B5773RSl1kcj85mTXW/apMB2js2VnfRb?=
 =?us-ascii?Q?rtZbH/2yl9gpLn2Vav3TGIJMLsG7P4F2xop/MQKNfkXYO+v7JxZQJkKs7q7I?=
 =?us-ascii?Q?jCyYdyrU+Iz367J4HFqAvlNa2a6X1Kc7Ls0RHpCWZnFJxX+RcUE8ZdnK+S0q?=
 =?us-ascii?Q?4NS9bcTIzTQN51iiM89k20Q/MdslAGi7Al61l3ZCjRiRIvKc591uW3Tc9S/P?=
 =?us-ascii?Q?eHA2oFQQBMyxfjRUo0OZuiK5dn+S9snToZUFTgrgFXc3QO8sSGUvmXCtMXsw?=
 =?us-ascii?Q?Nv9HnX2I8NLwYHFITBlRkf1EJJvFa2H9ocYNuy7SYzkBc/xy1VxFGERJvBwQ?=
 =?us-ascii?Q?epfgyyBDRtsJjsF6g7BZtQoZBDZvvU0V35Z45WhJ6pkvv4yu4rzPsEl/ZkCY?=
 =?us-ascii?Q?oDmQokJVQX4lc+RMh15cu8Sb/5+wFJTQyY/3zqoOvTNhNY+yfnzQyuy1sa+B?=
 =?us-ascii?Q?nPAauvgeZirfUz1+nvSw58XupXbU/f8DMEuyNiPv5F2wAKfWqNLyuc91FAyc?=
 =?us-ascii?Q?dJso/w3nMY/yojjYoW3BqC40ZJcv+XGMpgJLG7y8r5lPv7d2hDeZDfGNO8R1?=
 =?us-ascii?Q?NWwBQt20ZI0aKUwEQLIgN807I+d5MMKCxhPT++qkveiDzMu/aDm1krwgyGDn?=
 =?us-ascii?Q?Jasxnt3Fq6+2bHm4GtZmNGo1zzuuKKAaO3GXlKwT9lASvwNEOprhPoRerjC+?=
 =?us-ascii?Q?BWFCz7ofyXhJH4OFnBCHVRvngtlCXFMZ0/bKI1Qc0x8PiynB3Zwk15W1z4t9?=
 =?us-ascii?Q?YHtR8BzCp2EfjhlHzkig455SjKrgNGPjiUfmNAG+clmDqdhwSYkrpxEkMaOC?=
 =?us-ascii?Q?bVL7hzLaxBSh9rYZiNm7T4KdHMN2860ToP09oEW+LgKaQUzqBiqooR726Hwc?=
 =?us-ascii?Q?oqzJExPzg5MS4Eag1aRdlECuPq0hKl9kiJnWcjeEAiavU8ENd6DniSEGPv25?=
 =?us-ascii?Q?HtW36+eN3dXl5vDyagVAMPr8egOyxn48arWHSTj9b+qT8yG+arkzmAddrE5t?=
 =?us-ascii?Q?nEONmDohfCFDrg5bbRI5YDsSrKRZd4WqWLpo0ZmPwdHIydRofdNyrTxRDW7n?=
 =?us-ascii?Q?UXK1g3AvQEryIqfpQ4zTDnNrkDCI46iXhFfaAp8sFEa7usGtIa5RPK8oKlQf?=
 =?us-ascii?Q?ObfH9FE5FBW7fd9YMnu663BS03xOzc28s+qMJ/VwXvsggPqjwbWKe0URejKj?=
 =?us-ascii?Q?7eFch/VB7k0q1oVTSscDs6F5w+PxswceH9E89bQTfjF703WaWtyT7Ew3UCFI?=
 =?us-ascii?Q?ils73G/IkxyNUJuxalE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a160da58-213e-4a93-08af-08ddc9e68300
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 12:43:23.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDKsAUyz2pvj2EiCmN04Kgv14pSRDqeCDZ2jjsJhvSfRNc5VT9bYTiqZB7slY4h1MLaRpTw1deA7sHTBVgzFQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6816
X-OriginatorOrg: intel.com

Hi Luiz,

>-----Original Message-----
>From: Salah Triki <salah.triki@gmail.com>
>Sent: Thursday, July 17, 2025 8:55 AM
>To: Marcel Holtmann <marcel@holtmann.org>; Luiz Augusto von Dentz
><luiz.dentz@gmail.com>; linux-bluetooth@vger.kernel.org; linux-
>kernel@vger.kernel.org
>Cc: salah.triki@gmail.com
>Subject: [PATCH] Bluetooth: btintel_pcie: Drop pci_set_drvdata(pdev, NULL)
>
>Drop pci_set_drvdata(pdev, NULL) in the remove function of the pci driver
>since it is useless, the data is not accessible when the driver is removed=
.
>
>Signed-off-by: Salah Triki <salah.triki@gmail.com>

Tested-by: Kiran K <kiran.k@intel.com>
>---
> drivers/bluetooth/btintel_pcie.c | 2 --
> 1 file changed, 2 deletions(-)
>
>diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_=
pcie.c
>index e1c688dd2d45..28fa4ca3199a 100644
>--- a/drivers/bluetooth/btintel_pcie.c
>+++ b/drivers/bluetooth/btintel_pcie.c
>@@ -2339,8 +2339,6 @@ static void btintel_pcie_remove(struct pci_dev
>*pdev)
> 	btintel_pcie_free(data);
>
> 	pci_clear_master(pdev);
>-
>-	pci_set_drvdata(pdev, NULL);
> }
>
> #ifdef CONFIG_DEV_COREDUMP
>--
>2.43.0
>
Thanks,
Kiran


