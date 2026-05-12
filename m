Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F1B3A542E
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 09:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778578261; cv=fail; b=iA9qud1wMKgi41vcTn5vz/h/pDTrPlnR3XsHGY56z/ndpWwkpF7/WOdL1WBlyjnn7oWNd2ePSvopRiR/01xZg1b3DT8lb/85HBx2hXe9WSFAAdkhUV4U0GvUYRZE6UTabnFoqbF7rHg+gvhguAXcnKLfWZtbDri4qlk0VA1QKbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778578261; c=relaxed/simple;
	bh=XNS00ng3U8M2W0ijtyMzGZJRlOAyVySgSHQXyZr2CK4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ULKYawS4akIZn7Tn2ZHetf6L2TDxWnBWXuE7bnk8ivDB05faCtfSwxaoPX5xUQG0UPhdPtCY4LHM7znzNUy88raT3Imkzfq5GOS/Rs43vhzaiv10PQIxsqQwf2dSrP53nbMQy2080wknAlKh615PYb01nTXt8dk6DTxYp89WZho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AM5JpHz2; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AM5JpHz2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778578260; x=1810114260;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XNS00ng3U8M2W0ijtyMzGZJRlOAyVySgSHQXyZr2CK4=;
  b=AM5JpHz2uZgJSiIkSnORWNh/omTVojRSwenCW5wJnBErV3mTw/lfy3cY
   ILq1/se4qINVR66DXB8OR4eFDeW6iFLBRQ+zxm/mLS/cyu76Cpct5ZWvC
   lZR6meQt8Lxo+OXxlZi7TYuJyWt2NThfR/pWEhqWOcYWPC8m+ZZaJ+I8g
   IjVYh/WUWJf6qNclib8M5r1lBSZrWHlkQND6XzB/orDng3NenucjzWT+g
   19wlVGNwDLiDeGNcB3zWygTFO+UyyNUd8BKw4FESXm42Aop6UUf7Q6jf4
   W0ihsedxSGhmiu9pl1MORqGpRKcbEvUjJsmjBYPltXxDwNgI2oQCMVWfo
   w==;
X-CSE-ConnectionGUID: dgX0ubtkQXWWShm4B7GTuA==
X-CSE-MsgGUID: gZviAkRYRy+WMaJtwGwLCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90946736"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90946736"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:30:59 -0700
X-CSE-ConnectionGUID: XChgsp2+RdexLKMHGOgo5g==
X-CSE-MsgGUID: wOFtWQatSeK4yttXx0dRYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="239548902"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:30:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 02:30:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 12 May 2026 02:30:58 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 12 May 2026 02:30:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOp1iJU44Fzat+HhODgbcaSLp8cdHBdBrVbfd37n0b77pDQkLypxZ2tPhiVzOFzl8sAb66vKAlmQd1NdJVpY+ZrSVeuXe9xku3HaoUToeb7rrAQazhS+2l+NoVBYj0TCQDtvW+LSSCH8bcfhIC81WWYTdodFq3dhgjT92AfhQ9D1r0aiuSInqA2JUYrxiNZwFjJVeIRMGafPYxuog6dqI57L01cH2B7RIl8LoK2sbuhu3IRAHi79Hf371m0uDpUWgxr449TRqVkKS/+j3BCHA6ZvkWblDrcRZ8qLHYd9RMDko7s3X8W9ByxaXn0dhWvmpvFTAmRMLXMgCk4oaJYMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNS00ng3U8M2W0ijtyMzGZJRlOAyVySgSHQXyZr2CK4=;
 b=O5l3LHcD6wTpD4aC8E5Aai/cfiDqqcQ1FgLwKuuUts9RADOImAopiLsAkrFrLtZYmqtx+9RYrYdygVDkY3H/raU/mnaLZiK0qoCWwRMlt5rSZ/vrZ+bHtKbhyrKfrHSa0dAOV/8fJUvaeA5pZ4FqoE/OJnMi6dTiKNOYPS5lEHAL5sCKUoL5cFTOZGhzmdRM/fFU0/sRUkaFgYAJwr4C2HtDKOa104pDtfGtknHz8eW5cDou+3JQwOsph9p85TITtMBIKjgFiRGYUfqg2jhAO6Xq8VBy5FfIk1GeehkDYEhDc3Sgy6GVXOf9PK43gzH2W1P3eWCgzQcXX1I0rY4ZOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by PH7PR11MB6795.namprd11.prod.outlook.com (2603:10b6:510:1b9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 09:30:55 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::b803:4643:8d14:f071]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::b803:4643:8d14:f071%4]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 09:30:55 +0000
From: Ravindra <ravindra@intel.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "K, Kiran"
	<kiran.k@intel.com>, "Tumkur Narayan, Chethan"
	<chethan.tumkur.narayan@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v1] Bluetooth: btusb: Add support for Intel Lizard Peak2
 (0x8087:0x0040)
Thread-Topic: [PATCH v1] Bluetooth: btusb: Add support for Intel Lizard Peak2
 (0x8087:0x0040)
Thread-Index: AQHc4deDA+zXoSFJYUKS9qImGZ49PrYJ7FwAgAAzMEI=
Date: Tue, 12 May 2026 09:30:55 +0000
Message-ID: <IA1PR11MB786983EFDD0F9E7793A8E1F6DA392@IA1PR11MB7869.namprd11.prod.outlook.com>
References: <20260512062045.1213631-1-ravindra@intel.com>
 <33bfcf77-2709-4b5d-a932-ed2987c6410f@molgen.mpg.de>
In-Reply-To: <33bfcf77-2709-4b5d-a932-ed2987c6410f@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB7869:EE_|PH7PR11MB6795:EE_
x-ms-office365-filtering-correlation-id: 539a40b1-2bed-4168-a704-08deb0092ac0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021|11063799003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: 7twayu0Yfxm2uOo7a/eft7CoO7eF65TdslIgwng3zYohjYWhos2orciP/ukW2gCyW09QLCOLnMYvbCRJ6X6S6W6yzWcKY423dIYFYB2NCNZjU20AESRzEHAskDM0SfMo6VSJg7qaelpVV4j4bMr1wFdpTfMmYBjqdw/i+6R98XX8PSpxevIgnRh9IIP3KOkJRzkmL/fpynmfqEIGpKV1ggv5Yf69TeoZZWJ40642jMIk9vCeBrP8tT67zzsFVEp2mkiYTi76LFgu7/CFHM6gwx4KmLizmDmAD+8CIGXyQ9o9BTLzJ8HGafUfqAka9K2umqyTQSzclsWpp+Yxa0IQgxtMcVyA07kyBgazQM4hQ/mAU0sZA/8wJWDfML6AxJg9WVUqXe+Lts5TCJn08X8UjiedijXLug7LnPE47wLwOlwgyQHGb2w9/1anVIFxAj6RWErpdhBED+Rg0PgB8lu4zs8vQltzoYY+VZXyon5bp9w8YFiLhm0/FS4KHB7z0PCjSzwrimRFV3INwLCDDa5J0KCQQo5GOnrQ6kaB+w9LA4wTq79ZYz2RRIYDRkGLPN1N9eRzwAYuuK/RrJvyAsk3yv3u/yuLdvN5+r2uEhazAdkcVgfoCOTEREH1gXRCawN+tHrk8Byc8Vn7qt4HS+BOMQppJPjbnlCAPkgM0aHZo7HCHynrZVgpsg2KNWJqsG4CX+a8kJqpfbSjBUIed6WSrnrc8ssGh7xbW+XXZyAgcIfIHNrDN1v/dUXBG81PvoU5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(11063799003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V94l4vvOu4KJ4vmX9sNDLZUm8dWW2FUNDsAANWB4udbOwfMTjpezs2bLLi?=
 =?iso-8859-1?Q?bJXbvPQN6rTZWNryRxctRP7lrmV2N9RawUrbW6yi/BdAugS5LiZIS7f7ck?=
 =?iso-8859-1?Q?8mJwlobXmAXRM80HcNz5AHzIkVOxFMcgnzvuI+V7gLH7CVwLkIZD+/CANl?=
 =?iso-8859-1?Q?+kbecjz0jEISTIFQPGVPrkqEZivFPz8shZN023lBektOycMDiH/PryvUsT?=
 =?iso-8859-1?Q?okeaSd9iw5qlF+Qpok0bw38tUuN1Bi8xauva0b/1iJ/S0msQpii/0DW95T?=
 =?iso-8859-1?Q?e84lPvOjZu0TW8o3Eb943XLvqUarcdi1wB+q2lq5FaRwODQp+XyS0rnsBc?=
 =?iso-8859-1?Q?e4dERzQ5JTcxWC0MyQcIBjAyXgeEp4c13C8LcqEA58aXt/96ElBJ0/G+lM?=
 =?iso-8859-1?Q?up2+p9Qm2FU1dbwMd2bKY7Ati2uDpYxH0IVo+FGgJamhzcfMYQCQcUMVQu?=
 =?iso-8859-1?Q?3XND5fbYNvgjewGvz21iat2qph9R4eN6qYZEfb8nd/oloYP1ZIAppWPTXu?=
 =?iso-8859-1?Q?WrEX2UPE+erY2h3wYYJ/w4ChsNSzLvsA8jKhf1ujK9sAi6+VosPBie8Lph?=
 =?iso-8859-1?Q?WbWc+C2ceBwSvrtHULKdjtoa+LT4v1NJquOV6lbwmuGFL3FSiPTwQipt6O?=
 =?iso-8859-1?Q?Y4RVELDjgzVdGgnPQu7XtRwOrXa0nTUj6GxtWLtVi4+AhHaYTMh4wvAQdR?=
 =?iso-8859-1?Q?AxkTwRo877X6Ik6ITMU7ZDijSXisk8yieV/ErUF0ikQQ/ktJyoimR5o/Ah?=
 =?iso-8859-1?Q?6mujrN4vnBkydLuoZH7bXGOEi81qHsPisC/zneY/jIHQ+E2AGr4cPpm4aa?=
 =?iso-8859-1?Q?FSGefzlMDXYOQc97kmMQ0UGXHblxW0onEDxxM7hUalklAoVWQkMGnVp8zO?=
 =?iso-8859-1?Q?v7+kyieJR6l9shU7b/qXTHx50WvWs36Vz1uQ4oacEiCRl5kXZKxxwAnXFj?=
 =?iso-8859-1?Q?p1yTAOHN81qK8xanL+gBgajTVNB18+/Ifd22nTY15ocDNEek+HHTwCiWT/?=
 =?iso-8859-1?Q?wgKdYp6n2H2ue20aZYalcH0nI9bsHNiMqROUlznOiuNwH7uFJ9JVyELfZv?=
 =?iso-8859-1?Q?QaJPZI2upINctG98MJReTpCra/5pZ2UaU0Nd9ufSloV8OzWvcYWXEStMR3?=
 =?iso-8859-1?Q?AtbSwxYjiwZM559IQ/TKV+IVK79IANrrpUaQUVZfefCJxPEb1R4YPBoJ9x?=
 =?iso-8859-1?Q?pDa+y144XPTgTN7SIMpnMJh4Sri0V8XHCWkCBcOpbn+zQAXS59ke2Bn5BI?=
 =?iso-8859-1?Q?EQSqeWbEikzI/NsQA+HJ6yS2gj3NF1JkpTv0B/aRmZ9b0sRUsDTTQ28mjd?=
 =?iso-8859-1?Q?LKR5DLDnr/zOXjO9i4hEc5qtJU1dTE1K3NPwOs5lp4xj3R2vQxU2gE6+s7?=
 =?iso-8859-1?Q?vyEaFKwsHixn75Tjl0cJbKjIDF7RP3ocmPTLUZyzgSdH9raGTbqCS+5BoP?=
 =?iso-8859-1?Q?/t9pFcoaaobCUVfcTIfpPxQyMREtLPgFv0qotMnt8EGsp5LjcmXIvORIbC?=
 =?iso-8859-1?Q?TCZ7jkGbmx7Zuve3vbvT57XVnaMb1V+l2Yszi+RTn1kNYbP2yLIU1TNVin?=
 =?iso-8859-1?Q?kYCRwa1XFBkTNZlbFB6W/5JDIBg4BZRM3M2YhCZVWpQIl53pnFLLgxxRq+?=
 =?iso-8859-1?Q?D3ZPCbY5+huSDmX89SzuH5mRw92VPf4S2+vQOtIP5szwoZFn0sZ9vajbBm?=
 =?iso-8859-1?Q?BKVP368franWUedLNhaqXo+n8vSSU5cWaZIrkLdEk0xpxLyP4k0q9ks5Fp?=
 =?iso-8859-1?Q?W2z3N6m1hd+qL+ErXT4djgDKoCnhvo9VuDAKpIeIx9plAW?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: b6VGcrJjl3ebBZt3fsa1R/Ptm5OSGaIZV9Fhvg6fs//FDAaRU4CtM+ZbkmCjlehMOKPq0ZwXcQBRO9fpZFAFjG6hSr862OsF6g5XaThhDfowHRdG7tt9gHT1l+qlJjBqEXLCBx2zk6Gdf/dl9DJ1x9nK0G6wdY03eTESZZtb3U99NzwBf3hMHelBXEFRXId6bSAr0AYbHpQYQxSyagxwkfEJd2wdJCUf1MOQ0SKY3EBBSdnLDrRGAfriMD1yuj/FdiVdHFuSeZCLME+1lxyY7+2C2Lwujf+iTlo5kcenvnD48NPf5fWo3MiBwHnky0H9irdynWT6GoUYGYd+rrtwug==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 539a40b1-2bed-4168-a704-08deb0092ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 09:30:55.1146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o/3/7v/Hrm1EwEnvH2EhwhgDPVYUu9/GP6tv1Tm5+V4l+uQunuOsBO0Y0g1IjPO5pA+FyMTZXt4oKQ5AO4iEvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6795
X-OriginatorOrg: intel.com

=0A=
=0A=
=0A=
=0A=
=0A=
________________________________________=0A=
From:=A0Paul Menzel <pmenzel@molgen.mpg.de>=0A=
Sent:=A0Tuesday, May 12, 2026 11:54 AM=0A=
To:=A0Ravindra <ravindra@intel.com>=0A=
Cc:=A0linux-bluetooth@vger.kernel.org <linux-bluetooth@vger.kernel.org>; Sr=
ivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; K, Kiran <kiran.k@int=
el.com>; Tumkur Narayan, Chethan <chethan.tumkur.narayan@intel.com>=0A=
Subject:=A0Re: [PATCH v1] Bluetooth: btusb: Add support for Intel Lizard Pe=
ak2 (0x8087:0x0040)=0A=
=0A=
=0A=
Dear Ravindra,=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Thank you for your patch.=0A=
=0A=
=0A=
=0A=
(Is the spelling for Lizard Peak2 really without a space before the 2?)=0A=
Yes, that is not correct. According to the hardware specification and the f=
irmware strings, "Lizard Peak 2" is the correct one.=0A=
=0A=
=0A=
Am 12.05.26 um 08:20 schrieb Ravindra:=0A=
=0A=
> Device from /sys/kernel/debug/usb/devices:=0A=
=0A=
>=0A=
=0A=
> T:=A0 Bus=3D09 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D=A0 2 Spd=3D1=
2=A0=A0 MxCh=3D 0=0A=
=0A=
> D:=A0 Ver=3D 2.00 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D=
=A0 1=0A=
=0A=
> P:=A0 Vendor=3D8087 ProdID=3D0040 Rev=3D 0.00=0A=
=0A=
> C:* #Ifs=3D 2 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA=0A=
=0A=
> I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D81(I) Atr=3D03(Int.) MxPS=3D=A0 64 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D=A0 64 Ivl=3D0ms=0A=
=0A=
> E:=A0 Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D=A0 64 Ivl=3D0ms=0A=
=0A=
> I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0=A0 0 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0=A0 0 Ivl=3D1ms=0A=
=0A=
> I:=A0 If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0=A0 9 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0=A0 9 Ivl=3D1ms=0A=
=0A=
> I:=A0 If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0 17 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0 17 Ivl=3D1ms=0A=
=0A=
> I:=A0 If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0 25 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0 25 Ivl=3D1ms=0A=
=0A=
> I:=A0 If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0 33 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0 33 Ivl=3D1ms=0A=
=0A=
> I:=A0 If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0 49 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0 49 Ivl=3D1ms=0A=
=0A=
> I:=A0 If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driv=
er=3Dbtusb=0A=
=0A=
> E:=A0 Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D=A0 63 Ivl=3D1ms=0A=
=0A=
> E:=A0 Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D=A0 63 Ivl=3D1ms=0A=
=0A=
>=0A=
=0A=
> Signed-off-by: Ravindra <ravindra@intel.com>=0A=
=0A=
> ---=0A=
=0A=
>=A0=A0 drivers/bluetooth/btusb.c | 1 +=0A=
=0A=
>=A0=A0 1 file changed, 1 insertion(+)=0A=
=0A=
>=0A=
=0A=
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c=0A=
=0A=
> index 572091e601f9..3f012c2a014a 100644=0A=
=0A=
> --- a/drivers/bluetooth/btusb.c=0A=
=0A=
> +++ b/drivers/bluetooth/btusb.c=0A=
=0A=
> @@ -484,6 +484,7 @@ static const struct usb_device_id quirks_table[] =3D =
{=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 { USB_DEVICE(0x8087, 0x0037), .driver_info =3D BTUSB=
_INTEL_COMBINED },=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 { USB_DEVICE(0x8087, 0x0038), .driver_info =3D BTUSB=
_INTEL_COMBINED },=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 { USB_DEVICE(0x8087, 0x0039), .driver_info =3D BTUSB=
_INTEL_COMBINED },=0A=
=0A=
> +=A0=A0=A0=A0 { USB_DEVICE(0x8087, 0x0040), .driver_info =3D BTUSB_INTEL_=
COMBINED }, /* Lizard Peak2 */=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 { USB_DEVICE(0x8087, 0x07da), .driver_info =3D BTUSB=
_CSR },=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0 { USB_DEVICE(0x8087, 0x07dc), .driver_info =3D BTUSB=
_INTEL_COMBINED |=0A=
=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 BTUSB_INTEL_NO_WBS_SUPPORT |=0A=
=0A=
=0A=
=0A=
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Kind regards,=0A=
=0A=
=0A=
=0A=
Paul=0A=
=0A=
