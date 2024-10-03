Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DB554FAD
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 05:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727933023; cv=fail; b=JiEjeQ0wmO0qTzSjEnkbUbDkMGBINA0xYj0A64pj8zamtZHm2i8o1DAmhYGeCJ7foCZZgt/1NCiWEssax8s2up4jFx2t1pgBwrHjV3ZPHvQSzH8AtdAME53TfQb+BjItBRSmXhXwVERud4pC0XWti8Yx3Eq5t/DhdCELozIpzLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727933023; c=relaxed/simple;
	bh=A3KDV+pc1vljMFXfo7xNDc4ve3K25XdNKAgtVvkfliA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IKPtAZJ7h33u3ChJ7M2LxcDx2rHQ164MCL+IV3NlSukqVdwQQtWdQQhE7V9ya2fE4qxoZ/PjOx1KI5cXFMs4Q9Qs38ntJ8UVa5BnrXx3qLF+RDH3QIPjGXvRK7wwpYbL4iPhHxG82QjhN647SUvxgfmqbeyOGBv2kfh8yhKWjL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fx16/PO1; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fx16/PO1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727933021; x=1759469021;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=A3KDV+pc1vljMFXfo7xNDc4ve3K25XdNKAgtVvkfliA=;
  b=fx16/PO1XHST0Z0TkapT5t5fb7lW77t6WWWAGBYELqyhxfMPPn5vvlV7
   WeZ5EU/SHcpWXBbc7kGCyV+QpD+3rvYWcqFSlwD1GLTUXdh5HoodMHUwG
   vSYIQcB4XmAteXdpF2m8X80pAtCUPr49kQYJvvmUrPr8wNDCKyTJrgQdK
   ERejyyheS9rPnE2NNVFDwFunV5DAbsGEg0R3bfDkQs7OLQLWiWbbgl1ca
   OqTsRdGiZWD4utx8bFddwIvh4dGV51jz8RwSphLH1X8hAW5e1bTPoDlz7
   IW4pBLdwkQVhhB0uu/HrG1Ct0XmJYGb30VJkpHNn6Urypq6P9bGtd69Lg
   w==;
X-CSE-ConnectionGUID: kd7s1HCGR1CJlMt6PaoxFg==
X-CSE-MsgGUID: 9sDOalbITS+i4RVnureasw==
X-IronPort-AV: E=McAfee;i="6700,10204,11213"; a="37675434"
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="37675434"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 22:23:41 -0700
X-CSE-ConnectionGUID: 4HcQocxhR5eNvTpKpU+kTQ==
X-CSE-MsgGUID: 2m9ynUfXS3qFMDm+8/uA+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,173,1725346800"; 
   d="scan'208";a="74350635"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 22:23:40 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 22:23:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 22:23:39 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 22:23:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqjfQjeDA6NbLPeOEkf0QLF0nF3kmzEy9w90r1rJmUMriPffObMRFwX2xOa/qffl+E2wNh+7cex0es3Dplwer7hNZ36Hys11QK7WOl9lEUz9DpaObzGBFkyoM3ureIq9Xp1sWv1vZRVcB9EDl+wU1sJ+fy1//PDfAiPMoIKHvkb6a9ND3v7XG7t5TlKK9MW1YQCizCJFR/bS6YyjCDdLDU/Xjst6uZ/vVEVGBlSfpVPCYiKniQtEeca9XQ0KAoYfyuOiKoAjp3mGLCXXM8ah3mBPcD+I9+qvSKYn57Fassv6nKTeiNviuYvpF5/cPzbrR+8gewcy1p6tVfu3/xzTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp6VEeFzleQZTNJ2nWaJAYOJ7RcJRW3zs6LO7qAxfQ4=;
 b=gtynL+KtSPb4j1J+n+kK1l3NlKQ3D7cwz3Re/oVLmrT+sCSlbjnFPrpPRs84BBzK8pKnwEOB0PBzG1vHgsVgu0s0AyGd/bRoqbjS5i252NXfKFsxSVv1ZTniayabY+UW2eEzkvhIJD4bcRSTc5rHAR0fz84yExcWb15yz3DojDImZ8cHcpVpDqOQ0oBl8f5zVxve+ZqISgxR39Z8tMX0FCwDztSnLyJp8eJmm+A4sZB6d1HGGu1Se0lbhx4JhrrpOZ8sHU3u0d6FbH8JC+3iNqFo0NZ8mD8Wwukdz1kTmrIkKpaQj863hFw39F/TWtkf5hSwEL2YkdYdDaLjKcTiBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 05:23:34 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%3]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 05:23:34 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [RESEND v3] Bluetooth: btusb: Don't fail external suspend
 requests
Thread-Topic: [RESEND v3] Bluetooth: btusb: Don't fail external suspend
 requests
Thread-Index: AQHbFBWqb30GKyC280qt7ypWDr7PG7J0gDgQ
Date: Thu, 3 Oct 2024 05:23:34 +0000
Message-ID: <PH0PR11MB7585D2B62D7590A59DFA154FF5712@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20241001152137.3071690-1-luiz.dentz@gmail.com>
In-Reply-To: <20241001152137.3071690-1-luiz.dentz@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|DM4PR11MB6144:EE_
x-ms-office365-filtering-correlation-id: 0f065e0f-9c4c-468f-3442-08dce36b8725
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?kcB2Fjl9WZftvn8w7eJUon38SwQyUyaYndJGWyyrc7VwFs/+UZnH1KNS2NGz?=
 =?us-ascii?Q?5KvCaNL/SeJsMzn3KHhC6aDPZTU0CAf5egs1QbtVAzeNLNl4DzzfOry1LWUw?=
 =?us-ascii?Q?H4aG/H6Vxeoe7UIRx4c1naDXR3q2vAVQLK83yNAVahUtzGm2u1CEmOP2qTzg?=
 =?us-ascii?Q?Q8jNPG8xxTQbjz4LW8ab1aig45JF4niazRekwzOgDrVr/2zDPGQWkWK86CPj?=
 =?us-ascii?Q?uOqxOGZssbVs8/45Y9zhpSj5h8VCuEDv6dxF9DEZCJwty5Wkj/+9gAayNaKW?=
 =?us-ascii?Q?Ux0HWiPwajW8VK16fNoPq3Gjg3z3Va4KEiojz/zl9UiypotZDOQcfPuyReOR?=
 =?us-ascii?Q?2mhOu46szlhW0X82F3NLeHnfE9E8L6+zm1BxCsLoajYLXTCB/eAe/oFbGuJt?=
 =?us-ascii?Q?QVWQvHw2oA+QwM2lS4CZ4I31pSMWSswElgqmptFYzg5cpiUQw5BUALQW/YYc?=
 =?us-ascii?Q?WQ2zN2X58QIQwmPQFi/f7dF1/0UUPS8V0JJKsgsOAOJPMRNDxpU2RLAKtnEq?=
 =?us-ascii?Q?PzdD5i9Cs17EjOOLStWBAfHOnHFclWuIIP0jRF1WnZpbi4XN2MxlaPK79kbK?=
 =?us-ascii?Q?1TpQGHcMBTAs8CFbfoxu5s8kneaMqHcTzQJZwzT0rkkGpVk/sm8cKixZJXrI?=
 =?us-ascii?Q?j74ArkrfBIFS5CVGq0zlwf7yoYRi+spF1/5VRH2/K6fo0jNXwd52/2QQlesK?=
 =?us-ascii?Q?rf7E870Dso7Ab0APhJVfEXWr7eHcmBArnkTsD/QXOEvcnnPW8BzJaVB5RQUl?=
 =?us-ascii?Q?liRQkovu19Vu3a/JzZUQhWU3AGMg6nxrjPoEnMp/RPmhXmYHTf93PVk7SKvl?=
 =?us-ascii?Q?eejsZSM4W5GAZq0gucGBKwwaCP8aPJKL64y+mxHv1iAudlkdYVYgbFlnh80d?=
 =?us-ascii?Q?+K3FtC2hnCdhG602FwI4zWInn+1rUr4T2nayNf70SaDwUtZOgXdo1nUJYgS1?=
 =?us-ascii?Q?3yu711lrN/YPLVZJQaYnQ331mwetSm3+elCgPwnQTRov5UanyRKUdPe2cNKW?=
 =?us-ascii?Q?YUw0QMTwA+dPRipIPQkJRWH01gjCBKxTisVrXmLrVhfhntQe1SWcXDCUiivw?=
 =?us-ascii?Q?Oxwy+PkG7MnkN7hNMQG/p8Jk3SakHE1FbKQzNAZ8UjSQT20gWzkPNanTnTli?=
 =?us-ascii?Q?6droZNJA/Z1oqW87YVJZ1WTIbAybH3ZKfa8kiwSBOKNwzU5UxpP4+kOIL47j?=
 =?us-ascii?Q?wBk+jUx3r/Bq+j7yAr1J0QLfg/cu/bngK+1sEPISQiipqiVzI3TtPrq5JMBW?=
 =?us-ascii?Q?9XdYnuVFAfVNEEVWvUpyMl98cGpuEgcCWoqU0N+Wioezv/os6W8RBYNLlG0w?=
 =?us-ascii?Q?89OemD2+gdWlHIXIcJ4rR4saIHhUWhfFJz+J+o1cAbUkpg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZQBk8n7B7NR7R9YIcaiz4gZVQDkylT2nuzyVcQbBeIFadq90DmJcpaPJAMWH?=
 =?us-ascii?Q?UlCQOdztqn7qe4JqIqByb+0vTqvdIMUhIMDu0GrYxMTkpY0Jjff/7gS51iSm?=
 =?us-ascii?Q?Ic7LIVMDipA8x8e23nCL79aG3qItEJAiT2btJuYenLKoeRwTkpgbnyV0b6eu?=
 =?us-ascii?Q?rlZTHS8XYf2xcZnehj21is0IS/rcOzS1MEeQzhOBcGFuEqOou0KCZQW5wm60?=
 =?us-ascii?Q?M6tUGDU6we6pFBmO2Iyu+bOMtik6et1afokKW//7hS8uHMI9K6rFXuSrTCsa?=
 =?us-ascii?Q?NnHKZj9yT2vCwHZlW2zTWUhv1sWHNt6DDOqPGgzECgRuG5NR9dnOepFrPHYG?=
 =?us-ascii?Q?ERCfVux9xF7LJi11ptq/7FsIS+hxSxjT21+M58qKHgkzxXY9RyNXRuu5TaFD?=
 =?us-ascii?Q?fSJ2l1oRoqBjT1D2K6KPJ2MtK3i6u0Kts0yol8Z52Eq8BPfzRLjtvwTsJNdq?=
 =?us-ascii?Q?eV0ybeYifjgM6vhbm+QLvk7K6M8HxEFQRMEoQkpFE2M+oMj8e1WnGMzmVx0y?=
 =?us-ascii?Q?i9aOIr+XQey3ABAwDv/0jvVH+cbzLNVUTeOMouKYbksLDT7Oqgaf65pAFOqP?=
 =?us-ascii?Q?xI9qgeC2lBtgmeCSZRmMCqDne/D4oJ+rSm2nsHm4He/qj9jouxdmRyFQGBlG?=
 =?us-ascii?Q?YJNnt0JBOd1hKP0v7xNO2Z/VbDZqHzjPr8GS3TtUGpp2NlfoVgatUDznVGkz?=
 =?us-ascii?Q?T5D++A9p0WgHHDGv4XjsCY3+YLTrMfg2S6Tg5YHHeZ0HujYRQMNzDDBVQnox?=
 =?us-ascii?Q?tzCJgcp/eFaBvMF+lSgmtSsG8+BdxdrsFm+XkBCnwXlQLwUClmC/ElSFntSu?=
 =?us-ascii?Q?AwFMxagN0noJ+J/Z0xLdLh9/n9H0NWpV8vESUN2kb+sYdDwHc5ys1NcorMp1?=
 =?us-ascii?Q?YvGi3WiPIDnFopaTjlxrnxId/Np++IDe2LO5uH5KDaieYprnbl4lgPT81jVs?=
 =?us-ascii?Q?Z/5CxKuegDSP7lqv+u4XFDtdsAe5VcOt72ePOkKy5X9P+rjP91aQcgheoi1p?=
 =?us-ascii?Q?tr/iYam0oYzbthOfXs6Dg78ReHLOn0Bh9fS1GqdNjtBC3M4wYFMtRZX9Wf7x?=
 =?us-ascii?Q?IzZSiLYDIoDpPcKoBlH7TdY2SC6OxQXSBTsp0ELbIoTa89YCL9bdzpTe2h3F?=
 =?us-ascii?Q?GX2S98jT+OL91aeCukCbY6qdf5TMJXia0zoOLg1vD/XVQ6voqo6rIxazceZp?=
 =?us-ascii?Q?sjdEO9xWsqFTNdPHVPD3x9xdwJ4uNKdUIvxOXDXagCEQqB2XeFmTjvtKE2Oy?=
 =?us-ascii?Q?uEf8k1tjfbjR4z70J5GjO91dhW4LyiyN323vS35vw1ClX5fzVaQg4Es8Co/m?=
 =?us-ascii?Q?vLSKeZaxAHHZgJRzSaOKV/FtsPXLpu3a5oXs66w85lXD+XPVcWrbovLyHrP1?=
 =?us-ascii?Q?BpuDE/6MBsEt1NRkV7mjVeAxxCI5t4vgOyY2BREfvudt1JePnIAM4nkC276W?=
 =?us-ascii?Q?Nst2ouiPRGuDNfBI7FPsOyFW3xFLSevELJmfGFgIW2k3B35e1uY2BjqxFb5/?=
 =?us-ascii?Q?05V6/1sfeypy3d85XylhfRBnP7VIiU63yoz/S0GRAcq/7Fggvd+Czs6cXV9C?=
 =?us-ascii?Q?U/ZIHJ70DVw2wQKAg/w=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f065e0f-9c4c-468f-3442-08dce36b8725
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2024 05:23:34.7585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UJ1cKmC1IuRfwxhl42ynsMoXm3i9fjFNjpp7M+2bLVeKSJaAitv4IcBo+eoZNcRn5SdyDA5cFTyjamkki3py3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144
X-OriginatorOrg: intel.com

Hi Luiz,

>-----Original Message-----
>From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
>Sent: Tuesday, October 1, 2024 8:52 PM
>To: linux-bluetooth@vger.kernel.org
>Subject: [RESEND v3] Bluetooth: btusb: Don't fail external suspend request=
s
>
>From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
>Commit 4e0a1d8b0675
>("Bluetooth: btusb: Don't suspend when there are connections") introduces =
a
>check for connections to prevent auto-suspend but that actually ignored th=
e
>fact the .suspend callback can be called for external suspend requests whi=
ch
>Documentation/driver-api/usb/power-management.rst states the following:
>
> 'External suspend calls should never be allowed to fail in this way,  onl=
y
>autosuspend calls.  The driver can tell them apart by applying  the
>:c:func:`PMSG_IS_AUTO` macro to the message argument to the  ``suspend``
>method; it will return True for internal PM events
> (autosuspend) and False for external PM events.'
>
>In addition to that align system suspend with USB suspend by using
>hci_suspend_dev since otherwise the stack would be expecting events such a=
s
>advertising reports which may not be delivered while the transport is
>suspended.
>
>Fixes: 4e0a1d8b0675 ("Bluetooth: btusb: Don't suspend when there are
>connections")
>Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Tested-by: Kiran K <kiran.k@intel.com>

>---
> drivers/bluetooth/btusb.c | 20 ++++++++++++++++++--
> 1 file changed, 18 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c index
>4d3eea414c2a..d14b941bfde8 100644
>--- a/drivers/bluetooth/btusb.c
>+++ b/drivers/bluetooth/btusb.c
>@@ -4075,16 +4075,29 @@ static void btusb_disconnect(struct usb_interface
>*intf)  static int btusb_suspend(struct usb_interface *intf, pm_message_t
>message)  {
> 	struct btusb_data *data =3D usb_get_intfdata(intf);
>+	int err;
>
> 	BT_DBG("intf %p", intf);
>
>-	/* Don't suspend if there are connections */
>-	if (hci_conn_count(data->hdev))
>+	/* Don't auto-suspend if there are connections; external suspend calls
>+	 * shall never fail.
>+	 */
>+	if (PMSG_IS_AUTO(message) && hci_conn_count(data->hdev))
> 		return -EBUSY;
>
> 	if (data->suspend_count++)
> 		return 0;
>
>+	/* Notify Host stack to suspend; this has to be done before stopping
>+	 * the traffic since the hci_suspend_dev itself may generate some
>+	 * traffic.
>+	 */
>+	err =3D hci_suspend_dev(data->hdev);
>+	if (err) {
>+		data->suspend_count--;
>+		return err;
>+	}
>+
> 	spin_lock_irq(&data->txlock);
> 	if (!(PMSG_IS_AUTO(message) && data->tx_in_flight)) {
> 		set_bit(BTUSB_SUSPENDING, &data->flags); @@ -4092,6
>+4105,7 @@ static int btusb_suspend(struct usb_interface *intf,
>pm_message_t message)
> 	} else {
> 		spin_unlock_irq(&data->txlock);
> 		data->suspend_count--;
>+		hci_resume_dev(data->hdev);
> 		return -EBUSY;
> 	}
>
>@@ -4212,6 +4226,8 @@ static int btusb_resume(struct usb_interface *intf)
> 	spin_unlock_irq(&data->txlock);
> 	schedule_work(&data->work);
>
>+	hci_resume_dev(data->hdev);
>+
> 	return 0;
>
> failed:
>--
>2.46.1
>

Thanks,
Kiran


