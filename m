Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848C44E80CA
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Sep 2026 16:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614747; cv=fail; b=mHbNs/VX8/tI0HYH56aGeu7v3WraUOYE6GG9/LSFYhuiR2jE/Enr6mgT37mUb0FYLvDYIBrmDckMB/pxNUB1tqbzN8YSfyD0mJ9HXBB5Elyjq23aYewu/7If1I/is8bLmK6yRHUBGOmrxwVQDIusSTvVal2Zs6s8MAjzqLn59Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614747; c=relaxed/simple;
	bh=XWbg4amAp0tLzh0kX6FCxBBuFWdNdRbscQnc/tt86ac=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mRY4J4mo9bRGP5z1VdZId5TsOCo5lKmyQVwsjsq9ElXNkIHPAAAWJxm94loRWDTl3aBN+G0IQ884iH7Qfd9tYImBce7EOwoKm2LatSALO3xsNJ/zAVL/tHZOOj9QrL48+gtSdEEIKlG2OvqCEDVbD0hxZWUASLfNCqmwxSZRTlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TD6qUGTK; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TD6qUGTK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790614745; x=1822150745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XWbg4amAp0tLzh0kX6FCxBBuFWdNdRbscQnc/tt86ac=;
  b=TD6qUGTK26Fo08EgLkDEHfShIkeNHld+k/89oJEsd9/Q5679UVKlpMb7
   8inN2tDC7B56LZskyDaz9UWiIhFha+kAZF7HBkQFG6kPK8lNqQXw8QHAX
   E4A4LQjOqRGQGp94Jyxq+//3gGPbx/fMRF4wVboRhBzaq/3cbWqb73s6M
   exk1g7JFnz+LIfK3WzgAxi5MQW9S3tmc7Un65ei3TcMPvGCAiyTHrTiZ0
   wizw34su9H4yg/qJMZ0yzL5U887eVWhcuA9qLJ9FYcU8Uu6HzugocXJJ7
   qCsxBz8ktbh6IhrgvYosASALCtPCoLbgGXzHzU2VJf45jxh+z2YQLMAxO
   Q==;
X-CSE-ConnectionGUID: 4jl91acKT3CwhWm7l9p6Sg==
X-CSE-MsgGUID: dtb8hGIfSFmAfFakmiyxug==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="108809950"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="108809950"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 09:59:04 -0700
X-CSE-ConnectionGUID: dSiTbx2XS4qztcFVyUT8/Q==
X-CSE-MsgGUID: /u5scz5tSdC2/FWcbTTVaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="274611173"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 09:59:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 09:59:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 28 Sep 2026 09:59:04 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 28 Sep 2026 09:59:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5EeJhqk6ltkhmNIudreMymhcebov7A6z6hnR5ayzcKtUUxNbYHt/xZqUtFpivOu+kssOdgfS9D11a588rSF2stCTMaTauG7R2Ie0QfyYr/NQUN8FkdKGnNWJiAcWR4G1sFW3JOAOTJaFSC0s79nC3LUEohqyYxzBOPVso6SyT95BQdaHZqHpzYnhIZsX/ywN4qrxd8qAcEjWPZRjpV29z1vqaJ9YFx9ZBFyw6ehyej+WX3exv3HhhCQRMfep9N/Sj6j8oVnn9mEpaVVsFKtfDJOGLgm1AVBlq8igHdKcUFZmY45imyHaL5F7Jhp8ACbAO/XgnPnE7ZsGXPNaOuZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmmT0bmBeqvIsVjFU9QC3PeqvdP/igqFAGql+pY3YY0=;
 b=KZ5T5jYCSF9epScXlw5mZ0CBf3AzK9tnb7tReB6lfH9xpgSKOWW5q5Nz5X0F1ALlYlMBJ9XGOzYVj+scv1CPcP9guZgg1i1ib2QXSNCzmINFP0f+RS2pIH0oVbnXZo2SmX0ZJOsRaFXT3oFdZOiegfTxgWWszLaFMsuAali9B2LWb/PuH7hfNmEd6+55u/o2u06+RyGzBzBLJZ3CrGHgD6SKnWeLhojbymM9Vs2g7hoRFkjeiPtUvkM2uNz10M138A9WRSAOmX8beUg+YwQHurr2os6AexCGXiiTUZFtQKnCLCnQM8gatwMPaVgFE/jAr09HB/Y4Nuikuzy0yNc1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SA7PR11MB9594.namprd11.prod.outlook.com (2603:10b6:806:4cf::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Mon, 28 Sep
 2026 16:59:01 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::b803:4643:8d14:f071]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::b803:4643:8d14:f071%6]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 16:59:01 +0000
From: Ravindra <ravindra@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"lsa.uz@pm.me" <lsa.uz@pm.me>, "vladimirkondratyev2@gmail.com"
	<vladimirkondratyev2@gmail.com>
CC: "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>, "K, Kiran"
	<kiran.k@intel.com>, "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
Subject: RE: [PATCH v5 3/4] Bluetooth: btintel_pcie: verify state after alive
 interrupt
Thread-Topic: [PATCH v5 3/4] Bluetooth: btintel_pcie: verify state after alive
 interrupt
Thread-Index: AQHdTwZsTJJcN+kDkkmp7tyXhC2g0bbkMVGQ
Date: Mon, 28 Sep 2026 16:59:01 +0000
Message-ID: <IA1PR11MB78693AFCD2E7939E76D4F511DA8D2@IA1PR11MB7869.namprd11.prod.outlook.com>
References: <20260928050344.2893790-1-ravindra@intel.com>
 <20260928050344.2893790-4-ravindra@intel.com>
In-Reply-To: <20260928050344.2893790-4-ravindra@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7869:EE_|SA7PR11MB9594:EE_
x-ms-office365-filtering-correlation-id: 8b981d5c-342c-4c16-d89c-08df1d81cbbb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|5023799004|6133799003|18002099003|22082099003|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info: ZH2Uxnyrjxr+cBP4bihGqLu1UV/nvUKBxWQRwjAlPLsOWb5WdaB/EkGiK65lUzYErUHHN1BcmMyyS5aUfxaFzgaCsrW2aDuvhkgkSkIiCwmwUa2qQjlT2AaiLy+3KEsEQARnDJsks7LLoBkt/Xs3l2riXpndM/AQyTxar1G7j5fZC3eWc4UIU9eeWFIqbSvjlk9U/n4V9jXy/Gn0i9d9XZdvP9AnopiRU6TDZirs6KVsHcpsgJ3MjtzUl6XBfbUdYBiv9A9U8GxwjwQsyS9M3/1BLmQSKU3vYvqfRQHPr1iLChpcoi+wMTRZFzfnrBnSCANXOKBrXgWqqQyUDttl9s5FpFnwqU19o4mnfXvbjv7Qd1jVNzCLiBsnUvM2f+n2azWcE7PVWKUdY8udeAWVFX3daeYzSfDANtwPGitUPl2xKjcZ0bkB10Vre2luXzQnkTGqZKdAxmbQzcHPA2X0qOlh+8dgHPUsu6EpnoyipQ7j0yEmShaUQDwMCL+hhO/Pp5mzxzuqEv3VywcYRgyPBGFZ9jGj18xil8Tc+Mnmb1nOQhtuABRekfbo1q1XmqbszX97br77BosjJm5s1+fhuRlLl30KPnFRCFKCPUuaFJ4IZglBhNGN1EcHFRi/sKoj1fwXwZ0vAvR+LmsbzhP9CATc6MkZmnFTAYmPsgk4rfU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(5023799004)(6133799003)(18002099003)(22082099003)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DNxX+M5AZXG3azsxd+uD0hB1VVoqJr1+x9uRCsCfATTfkr+QOEeUZd4w3EAM?=
 =?us-ascii?Q?4Dt9ZjAG2sT1Qje+iKLdOmqhMKRxkEyFT6swiF5ecRDmy4VHXK34FEsIl7yI?=
 =?us-ascii?Q?DAJJ39nJ9kdnDKOuXI+zOW6AdMbnn7C1E4KCTt4z4iTUAYUpNCGbCmJx8YxM?=
 =?us-ascii?Q?fQv8L/uV+xSL1F5F+wSbnWMhi/wOjljcBVTSrPqSKAWqOJ4WjwYeV1N40WPT?=
 =?us-ascii?Q?qiJmbalCPWqKaLA/ogikHkk2fUxjUA4V7gpgnQ28B20Ll+GTRi8asN7kZtLq?=
 =?us-ascii?Q?9UYofNRWfdM9fINiZsz0j10lO2S/RuXB6SRKrwpSm/uRgdearlaU3twemXwn?=
 =?us-ascii?Q?5WOduFS+kbhmlg0hA4zxiYo/bTDSPiuJ+YH4RckpMyoYnjOFCS+4AjMZcy5X?=
 =?us-ascii?Q?VuhxcYePw4sd5dBwQh8Q9th2EWkMh7noKQy3IcZUoRjvUG9Gz0Z//yyxvCrA?=
 =?us-ascii?Q?Q81kKW7DXd/k9I7pt0uRTdtrmeU4swSKctIIAwEVAq2PBrNalEo1js4pehCW?=
 =?us-ascii?Q?YEQ1606KaOflwe6Ay2PHks39T5K7jHd95x7Nd5iSeCYB554fCFFeADOA8dAt?=
 =?us-ascii?Q?ADaGOSFu5tBv/obOmJuyZBMHivOCJWSRsGL0nmtUlYVJcfo/5+/pnB5g46VT?=
 =?us-ascii?Q?3jzFqt4GTZXMWo+H8EC0AnL2pKkqek66slWdw/hVsrD8JbEmbAlGSO6+Zi+G?=
 =?us-ascii?Q?Y2XpKEU78OCP3lXYyXxYUhOST4Ms9Tq29Ny/ZVu9fs3c6wMs1yy5zuY48Vjx?=
 =?us-ascii?Q?tnurm+LK3el2S1MGZwkBgLa1p1SY6W1leH0Q/JPV536SzeplIfB2sC3oJswj?=
 =?us-ascii?Q?L6Df5Gr28GH1IGSdydqMHqq73LJX8vN5WU7v8VrQ4SvDKbCMgMqh2z2lwHTL?=
 =?us-ascii?Q?NV53DfNJtpQxjsWD1fwWD9kYhPYavQTSrFNPj97QWPFPj/rSzVTJb8iO5z2n?=
 =?us-ascii?Q?mhecTmUQMf8PwRneeGYAdI3REN2/t6jtno2n4HxYyHJLlwstEzHwmuNEPWg7?=
 =?us-ascii?Q?4Sm88FT63iZSU4Zxd8MiUEg4nvcOjGxGcYujNWbvhKa83urAQhaKDFkeihfX?=
 =?us-ascii?Q?KFF+VWMTKnT4qq5COBNh8IlAzLH997PStbjVta03acr0WbIT5QPBAGZDAoEC?=
 =?us-ascii?Q?dlrXDVEmVtDpJpyG5dsdrNh8paCnIXsrGB6bSDMRtS0FqPycxE5KzRjZ+Aiz?=
 =?us-ascii?Q?sv4VgF59JBWE/F/W5RO82qaCEQhEdNyJAUYAhZFWAKfXxaP7yVfQBPCX3FiR?=
 =?us-ascii?Q?mCtdCmNvWoH41DGEs2nRfJXnaMGtPF1vNRQaNZtZ2gz3cPco3awNhkmmG0rv?=
 =?us-ascii?Q?5RL7pEIfwF1IdYL0YtCw1VpwQh1ZXbd6Ay4NkuNYy/cTZTUDhUampFPSDUW1?=
 =?us-ascii?Q?O+ugL6AY0sIVd/1cMZPJ+42P4wqB4TfwXZ2GklLOJEElJjTPrNGKSrZ03AaI?=
 =?us-ascii?Q?1T0N7dc3jKp/KtFvvpEMBcUcBLGtNdHM1fHIPYCLXGA4sFrih08c41wxXOWx?=
 =?us-ascii?Q?Jtn8WbNt9FQI7XZKDkFrVlsMNooxfOYjVC/Me5KgLmCeU1ub8JYGubaw1xkQ?=
 =?us-ascii?Q?T4o8SIzqbH04uR/5KB8JRP5loPt6AdjnxrQ4yqs3AR26uJQ/pOzzotsEOJUb?=
 =?us-ascii?Q?oSbB8cPsRkz2Pausw3a/dXZWIEljgFqb5jsvyArImPCZfGLI2uuXxbYQ4VSC?=
 =?us-ascii?Q?+n2j4FPAI4fH0n8wkuCmnpAYsFoj2BGk2G9hrQwXl51EPVlS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HUgoIzBkhKfEBa6Pw0PGrAe+DqtgnCno5aHssWroufaFOM+O48evNcDjlfCH/MaYPCKzhmX+IBeqT4Gume2qOp2aqjVebrbQ8d0D6GuagQhw9cUeFbjPbd/JmVjbs2Xr2bdzbp68wIIe0qAH0JTjEOJ45LHg7xC1IaG06fCN2XjjZj3ChgCRneUbRr2u91zsg6WLVmax21DBY2cnrULObmVXlXhMrFYIGG9JvHEXzUBHbTb5FNaIDj53FiBHpdOw8iDWCrfwu+rOp4cXRQHFa6mdzEs8DHctwMVFvQ6S6HhQ8gyNc77wkZ4RvWVlK5syhWgYMN7vLqQKYGu3B6aXpQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b981d5c-342c-4c16-d89c-08df1d81cbbb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 16:59:01.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PowilaFp7EpCudZ/DoR5sZDUfqz2e+bGJXP3US/bwLCIWA5di3RrEhVVkAPpHmSkFoRNIx5ROy7WjXviYosvOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR11MB9594
X-OriginatorOrg: intel.com

Hi Sergey,

On Patch 3:
I checked the Sashiko review comments for patch 3:
https://sashiko.dev/#/patchset/20260928050344.2893790-1-ravindra%40intel.co=
m

Your concern is valid. The GP0 threaded IRQ handler and set_dxstate()
fallback can race if the interrupt is delayed or the PM wait times out.
Both paths could claim D0, reset the IA arrays, and re-arm RX concurrently.

I updated patch 3 to serialize the alive_intr_ctxt claim using irq_lock.
Only the winner performs btintel_pcie_reset_ia() and
btintel_pcie_start_rx(); the other path observes the completed state.

The D3 fallback update is protected by the same synchronization. The
changes are folded into patch 3, with no separate patch.

Subject:
Bluetooth: btintel_pcie: verify and serialize D-state transitions

I also added the Co-developed-by me, Fixes, and Tested-by as you tags while
retaining you as the patch author as you. Checkpatch and the driver build p=
ass.
I will be sending this as v6 which includes all the 4 patches and
all the required changes.

On Path 2: Does this logic correctly handle wakeups from hybrid sleep?

if (mesg.event =3D=3D PM_EVENT_RESUME &&
    pm_suspend_target_state =3D=3D PM_SUSPEND_MEM)

This condition handles wakeup from hybrid sleep.

PM_EVENT_THAW is called when hibernation is aborted.
Already addressed in previous patch comments.

Best regards,
Ravindra

> Subject: [PATCH v5 3/4] Bluetooth: btintel_pcie: verify state after alive
> interrupt
>=20
> From: Sergey Lebedev <lsa.uz@pm.me>
>=20
> The gp0_received flag only reports that the GP0 handler ran. It does not
> guarantee that the handler completed the requested D-state
> transition: a matched case can leave the state unchanged.
>=20
> Refresh the boot-stage register before treating the transition as success=
ful.
> When the controller is in D0 but the handler did not re-arm the interface=
,
> restore the alive context, reset the interface arrays, restart RX, and co=
mplete
> the mailbox/alive handshake. Propagate RX setup failures to the PM caller=
.
> Likewise, when the controller is in
> D3 but the handler did not record it, restore the alive context so the ne=
xt
> transition dispatches correctly.
>=20
> Signed-off-by: Ravindra <ravindra@intel.com>
> Signed-off-by: Sergey Lebedev <lsa.uz@pm.me>
> ---
>  drivers/bluetooth/btintel_pcie.c | 64 ++++++++++++++++++++++++--------
>  1 file changed, 48 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index 082f5ec8ba71..553fa927cf0a 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -4200,7 +4200,7 @@ static void btintel_pcie_coredump(struct device
> *dev)
>=20
>  static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 =
dxstate)
> {
> -	int retry =3D 0;
> +	int retry =3D 0, err;
>  	long status;
>  	u32 dx_intr_timeout_ms =3D 200;
>=20
> @@ -4212,30 +4212,62 @@ static int btintel_pcie_set_dxstate(struct
> btintel_pcie_data *data, u32 dxstate)
>  		status =3D wait_event_timeout(data->gp0_wait_q, data-
> >gp0_received,
>  			msecs_to_jiffies(dx_intr_timeout_ms));
>=20
> -		if (status)
> -			return 0;
> -
> -		bt_dev_warn(data->hdev,
> -			   "Timeout (%u ms) on alive interrupt for D%d entry,
> retry count %d",
> -			   dx_intr_timeout_ms, dxstate, retry);
> +		if (!status) {
> +			bt_dev_warn(data->hdev,
> +				    "Timeout (%u ms) on alive interrupt for
> D%d entry, retry count %d",
> +				    dx_intr_timeout_ms, dxstate, retry);
>=20
> -		/* clear gp0 cause */
> -		btintel_pcie_clr_reg_bits(data,
> -
> BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
> -
> BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
> +			/* clear gp0 cause */
> +			btintel_pcie_clr_reg_bits(data,
> +
> BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
> +
> BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
> +		}
>=20
> -		/* A hardware bug may cause the alive interrupt to be missed.
> Refresh
> -		 * boot_stage_cache from hardware, since only the interrupt
> handler
> -		 * updates it. Finally retry only if the state check still fails.
> +		/* gp0_received is set at the top of the handler, before the
> switch on
> +		 * alive_intr_ctxt. Error and lockdown are filtered out above it,
> but a
> +		 * matched case can still complete without doing anything -
> D3 breaks
> +		 * unchanged while the controller has not reached D0 - and a
> hardware
> +		 * bug may drop the interrupt outright. Either way the flag
> says a gp0
> +		 * was handled, not that the transition completed, and only
> the register
> +		 * knows. Refresh the cache here and retry only if the state
> check still
> +		 * fails.
>  		 */
>  		data->boot_stage_cache =3D btintel_pcie_rd_reg32(data,
>=20
> BTINTEL_PCIE_CSR_BOOT_STAGE_REG);
>  		if (dxstate =3D=3D BTINTEL_PCIE_STATE_D0) {
> -			if (btintel_pcie_in_d0(data))
> +			if (btintel_pcie_in_d0(data)) {
> +				/* Do what the handler's D3 -> D0 branch
> +				 * would have done, unless it already has.
> +				 */
> +				if (data->alive_intr_ctxt =3D=3D BTINTEL_PCIE_D0)
> +					return 0;
> +
> +				data->alive_intr_ctxt =3D BTINTEL_PCIE_D0;
> +				btintel_pcie_reset_ia(data);
> +				err =3D btintel_pcie_start_rx(data);
> +				if (err)
> +					return err;
> +
> +				/* Complete the mbox<->alive handshake */
> +				if
> (test_and_clear_bit(BTINTEL_PCIE_MBOX_PARSE_PENDING,
> +						       &data->flags)) {
> +
> 	set_bit(BTINTEL_PCIE_MBOX_PARSE_READY, &data->flags);
> +					wake_up(&data-
> >mbox_parse_wait_q);
> +				}
> +
>  				return 0;
> +			}
>  		} else {
> -			if (btintel_pcie_in_d3(data))
> +			if (btintel_pcie_in_d3(data)) {
> +				/* Do what the handler's D0 -> D3 branch
> +				 * would have done, unless it already has.
> +				 */
> +				if (data->alive_intr_ctxt =3D=3D BTINTEL_PCIE_D3)
> +					return 0;
> +
> +				data->alive_intr_ctxt =3D BTINTEL_PCIE_D3;
>  				return 0;
> +			}
>  		}
>=20
>  	} while (++retry < BTINTEL_PCIE_DX_TRANSITION_MAX_RETRIES);
> --
> 2.43.0

