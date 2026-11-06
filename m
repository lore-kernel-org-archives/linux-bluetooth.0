Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793958418;
	b=yslFPn/+ILAwqCNyt2FX+AXj2OC7wXVtOY7c7h6nw5LmFP8z1F4uzzFXj/AQD5Liz9nd
	 xR4qKey9mvQOjwU4TLDVaBw2VVVW3eCRcN5e/FjcG5lnSQGb1ks357x7gFrumgX8J1MbQ
	 wSUX/gcSn5eLUblT0le7tP5yb7Jf1cuvId9G5Pua33Vgvv6ct+stNQXu5Vp1gQbB8rAT0
	 Hi4BKISBrecwAEVF9VXChg2vApnfz/1cc1mus0M/jSyp3avPtCjPYWPd/JNY9VbzgSvqU
	 3u91dXUOh0JO/sdiQAgHDmnv1kDu1plD/9Rsb5vDMILkRrPHWMJ92aelJM4azii3mWw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793958418;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=t/gU/l80mEdqlNYwmSoppiz8J7Cf8XzczkftVh45820=;
	b=C2PZTkSjaf0OgLY+ISMnbY3be23UclhoBzWnSg3XRZehpJm9GjPgve6IK8QzgDAJNKH1
	 FpRUqx2S3jsvft/BZjElIVdJKmfztADf1O0KQYtSpawN8OxLQ0Dd7INJmdu8TOugaGPAX
	 6qXT03hX5wQlHV0GqQIiCvrtgUy0un9UYrL11tZMXlG+1aWcurqFEVJB7WNbvi1Vf+fMO
	 FYDSGJXYS5NOjvVYgJGi9qBbejJd5L/fVrSWCmr9aKbtwzmmgGzgvq437XnLTMRu7XOgg
	 vqSyc5+R5fmxDbG9UTHYtUv/XF04cvFfzipZhpX6is+MY49o+bzqCBlXoexrszX/I8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FKlBBghs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F9E606A32D
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 09:46:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41F9E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FKlBBghs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793958418; x=1825494418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t/gU/l80mEdqlNYwmSoppiz8J7Cf8XzczkftVh45820=;
  b=FKlBBghsKgvJIv6q2mLE5vs9oMwV6DnAvipK+nFmi13bU6CUuJJl6LtD
   N0dC6Fa9XYRs5d4fPugxA+WCxDlVh4RdjxwhvRq6ZbibFPiEjNx7qiydE
   OOAEQXAFMSGzACcgYYHmNLZFKEW+t//Bm6d75yGTcFGo07nOcE6jXoq3T
   AUCmfe5cokxtiQIrhdI1xZWeCsfNJRhTPpZ0YBr1tFBBLrtncy+P8DZzL
   oR+spSzsYrNm6O3hHWRu4egoRHycsipHwnaESV/vP1r/2OuqMLgqDcwdV
   tsVJiquE0KdTfBvh4o0QHSCT5/FOH7gCtDEoCnMnnSIMrAfIVjgBvhgz7
   A==;
X-CSE-ConnectionGUID: rqUV025fRYuzJOVaBnAIWg==
X-CSE-MsgGUID: EzK+2/1FSoqu8j5mVDt9sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2807476"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2807476"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 01:46:57 -0800
X-CSE-ConnectionGUID: A8VsM+TwSXuY98RtsMqaNQ==
X-CSE-MsgGUID: go8pLED+ToKILB5QPSMR8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7281538"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 01:46:57 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 01:46:56 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 01:46:55 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.29) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 01:46:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1zgkg6KkCF8COaVrIyjfQXfMDEUhORqRhF4I0fJExT3GJgpLNUBtf5EGJ3dOwmPhdrLXpaphvS6Y3FGwxOmCRW2+DtCVaJiLmM9sMlY1FMETHJ7fohmI67bKzTXI5Eeb90dfontJp8Wp7D6d8AFQPtIxP4G2lKIkrLz1pt1FH4VD7F2oHm2PIQTz16CdewEEjSAptlnSY9k2U27BgKW/dZKmyASKx5rixuPByIgQVSrNtZ4lXS3sdwBNdAo1AYHPwezoaHJD4uFEdy7ppVCg16uH1GouBt8kdKX8ErYViKowE+i7zWOnUYCUHvvo+XOaMuVgUyk95+ZYLs7FDC57w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/gU/l80mEdqlNYwmSoppiz8J7Cf8XzczkftVh45820=;
 b=SRZQWS3R5rmWtfAT0xgBkdoCRpy+gbyeF5xIieGyorLnQtTttjzonK1n+KgiR/jUtlzoD3KOecrSpFIu3RiQvIIU3cJeLWps1a82YiaLaK6aLW52k75NV9//c/ZPwB4Q7WN69bye7ABymjYg7N1fzUcTmqSpj+Aj0KjemUSezf/g5yuIMwSt/HUOEbixB1fu805HZZbQmSy/VR29mf9kkS0z0EgkVOWbrIgQcGL5jYNDsZqmHwbqEiIKgAHMxp7y6/dy6J3Eg9qBPeRin4mRIark9dTe5rzau5b6OYtuPcpkKutBIqPgQfEWrz7EukDlGQkpGLvxgTRataHnM/oksg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9016.namprd11.prod.outlook.com (2603:10b6:208:582::17)
 by DS4PPF2A0C3F85C.namprd11.prod.outlook.com (2603:10b6:f:fc02::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 09:44:53 +0000
Received: from IA3PR11MB9016.namprd11.prod.outlook.com
 ([fe80::bb82:7df8:d6c5:5ce0]) by IA3PR11MB9016.namprd11.prod.outlook.com
 ([fe80::bb82:7df8:d6c5:5ce0%5]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 09:44:52 +0000
From: "Devegowda, Chandrashekar" <chandrashekar.devegowda@intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>, "K, Kiran"
	<kiran.k@intel.com>, Aluvala Sai Teja <aluvala.sai.teja@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel_pcie: Fix SCP DBGC base address
Thread-Topic: [PATCH v1] Bluetooth: btintel_pcie: Fix SCP DBGC base address
Thread-Index: AQHdbCgjuQ8V0zMe/kK9LtBycFJoMLcdfVEAgAIMFEA=
Date: Fri, 6 Nov 2026 09:44:52 +0000
Message-ID: <IA3PR11MB90167262994AEA840C19DD98FC762@IA3PR11MB9016.namprd11.prod.outlook.com>
References: <20261104064507.2600483-1-chandrashekar.devegowda@intel.com>
 <eb3eedc6-35a7-42ff-abce-b5a3fcabcb25@molgen.mpg.de>
In-Reply-To: <eb3eedc6-35a7-42ff-abce-b5a3fcabcb25@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9016:EE_|DS4PPF2A0C3F85C:EE_
x-ms-office365-filtering-correlation-id: 03a723f7-b099-4b91-ee32-08df3bea9b74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|6133799003|10067099003|38070700021|4143699003|11063799006|261102123227099003|261026140227099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|56012099006|261009223027099003;
x-microsoft-antispam-message-info: 4wg2KWBDMKTHBwZSMcJSVRMbS7v8MvpAYMjEX/Xh4y3Cs6IKOH9bcqubKF05cH1AyJuCizTua7MdcwZwPo068i14q7hiAF4SlMA48HMm2vZyaxxmhHfHXYdizcdvoVlokdY1OPC6hdP80JFJUu3jIUWrDk6LDuUOez7W13HW5Yj+eavZ7kZAqbkL6Wu1yrhIl4sav2PRv1avun3A54UDa/QL96qxROXkSBJR9BgbiMnTDRDxUwU4+4FzwZGk8mAY3/fx54t3xrMUuO0NqpH8MHAE4BZCCR9UOPoNh8qse8C62RVKY3IJSCX7471k2CebYmIV61xWX+tBpwWRDtbDruhYpGrhHImfPZfYY/LTjrHpZ69WwqZIa84T+lUMyhv1/XgGcYXGfJxLEVmOxSI9F7ydaGZr3uxMHSFhiDWOtWZqx/jJvoQdS7JHspvMtF+0tFPhFdur76PRsqIH3N2L3xgOlrThhyBN4+N6CWJA84erDhuMUpw+w0bMcabutUvLXqqrFLvS3H5x9xmXBjsI8Fd02ZhQ6P3fDBiQD7M0p07Z8N0O9FCOonrlPdIn/QKEGSceRsolT4H99m3EozLFa3CikVGtwV0xrv4Nrb2WL7P5MqJmkkAvH//QE8fdZjMpVkj8+fM+VfNOTdJhOOCeTefNO2gsSmDT4VPdXSqDVdNn485gHzne8ohOL4pAVhvTbdkQS6AIDDosG6cMHHhJd+e/+NMLZuMskkhlRUtjru4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB9016.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(38070700021)(4143699003)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmZyUkYwdjZXZTdURHhrT3JCUVoxb2RFQkhDQmQ3U2JMTGs4UU9TMzF3Q0Jr?=
 =?utf-8?B?dkVjZWdYYXZncE9Iem5UVFcvNGZTZ0lIRC9CNXI1MkFteElXY25CbGZNNjRi?=
 =?utf-8?B?bG0xcW5GWmJDelEwQkdtL2NXYXp2QTA4TDZwS1ZFc3cvb2ExZ202eHNrZlla?=
 =?utf-8?B?L1p4STVBYWVKU0NDanhtd0k4aUtGdG4yNnNYcE5PZEhzbW9IMWVoaWh3ZGNQ?=
 =?utf-8?B?L1NUbWh6SjIwS3lHY2c5dUNiQm40VDdCTkpvSGx5emJMZjBLK0M2VXhvaDZ0?=
 =?utf-8?B?T3JmSzE1TUcwZ1dhTCtXcldsOHl0ZS9UVjNpUFJUK1phQUdQLzg4S05GSFpN?=
 =?utf-8?B?L1I3YTc1WFBHQWZjVlJOcnBCODBod3Q4d1haR0JhWjhuOGVLb0NWRUE3VFBY?=
 =?utf-8?B?aldiV1hGS0lWRm0xUnZ5YWNzUDNXNGNubFB5WCtGVzcyMVpsMlkveC96a0Fr?=
 =?utf-8?B?MUxyeUpGRWVZNHJxK1JCcFRDejZ4VCs4S2tSOVFzRW5mSWJKK2crcmRaOWVH?=
 =?utf-8?B?THdUc3h6ZzF2NUVRU3hZM1BRbmRaSTdUOXpMVEtDWHBRelRnY1NKMGU0SWRu?=
 =?utf-8?B?QVRjR2c3ZEpRU1ZkVnRIUWtOTUY1RWJPMmJhKytiK1k2SUlRMjJwWHh2YldO?=
 =?utf-8?B?NXl6bEVyRkh4VnRUZFl5MU9wZldtRnc2eStEQlgvYjB1NEFOZFBwWU1ZUlh3?=
 =?utf-8?B?U3U5c3kvMGJxQUFWT044UFQ0Q3VFZ0JvaGJGcG9PT1dZbE43UER4a0h2TXg1?=
 =?utf-8?B?WnA5VDBFeFRhaTh4bFhMb0FnSkpJNnFSMkE3NXQ2SDNlYkZNVEFvMU9jbTdk?=
 =?utf-8?B?V2dGTDluYit1UldwWTN2U2pKWnFuM3NOMnFEbmk3eUQvL3B5SlBXVlR4dlEz?=
 =?utf-8?B?aUo0UmFaajgySVBaNm1jZnNwMnpCaGswYnBwQTZIMkQ3WmJBbm52VDhtVDhR?=
 =?utf-8?B?SmZmeGZYVlVzUmFlaGxBczZ0SWVzQkFpcXVxLy9Hdk1tRk9yNW5aN1J0ZkZm?=
 =?utf-8?B?LzV1R3puNjFQRWExSkZPL2kreldZTVZzK1VubVlFVUU1WWhBRGF6VG5oT3JO?=
 =?utf-8?B?RjRMaHZMTlBIREE4Mi9SZUtmS3ZtY0JmaWtQZy9mWDVsUStFQUZCbmdqRVZO?=
 =?utf-8?B?MUpqMjFSbnFCSXo4eThHak5hVnM5Uzl6YkJERC9GeWdPbDRMSUY5V1I4bGhH?=
 =?utf-8?B?RmN2RVB2dkZKMVAydzRYUEZzR2hhTHh0dXZJMWNqempvYnV2YWs5a0tqTDZR?=
 =?utf-8?B?ZDFPSTA0aExBRnBkS2dyS2I5cWpQbFk4WmRmTW4wWHRvMnJkWUtyRlNsWDMy?=
 =?utf-8?B?VVd4WUNYcnM5TU1NWWtKNEk5MDNsa282K3REeWxFZ1Z6dEhPWGhSWXROU2hu?=
 =?utf-8?B?QkRIcmFJRHJwUzBDUVd6Ykh3Mk9ZcXNqc2NBYUk5VklhOUpSUE5RUVJVeUl6?=
 =?utf-8?B?cTI1Vmp3M0Q0VHMxQ2lZa1IxK2M5RlBwRS9kZWgzNDNGWFRaNXlqMDJpSWRm?=
 =?utf-8?B?WXNkVG1QU1VtbHIxdXlua2FrWjNsUTVHV2pJSG9FTGJFbjQ5SDJtZnB1blNa?=
 =?utf-8?B?TU1yV2Jvd1R1NjkyVmllaVg1MkIrbkJKYlhnV0pyS016WXAxM29YRWZsdTQ4?=
 =?utf-8?B?Rm50M0Q1eGl3OGI2WnM0cEk0YUpSS1JmMG9HNzhGa20zendmeVpoVk5WejhD?=
 =?utf-8?B?UkhvOUhuaGw5M0ZBc2p3dzQvblF3Q01BbE1sazJVVForVzA2ZkdWNzBHQzRq?=
 =?utf-8?B?VDJ3QVpsTmhibVlrZ0pNL3FOY2hOd3poT2YrQUdyazJZYmZkOFRPN2poUHA1?=
 =?utf-8?B?Z290U0duc2sxWWtRa3I5STBlM09MWkI1Rk1aM3oyd0x1dXJlOFFFWmtGbHpt?=
 =?utf-8?B?b2JiSEhoNFlTZ0dLV29TdG9MTEVJSS94ODZXcU5IQ3hEaWhOVFBOSmpCNTNJ?=
 =?utf-8?B?UENKWkZvMWpBajBwMlhOejRhejNCalhpMEF0eUplTmlvZS9aczJGWDNwL0N1?=
 =?utf-8?B?WlNpcU9pNWlWbDJINS9HMjNkREljNlVuQllubVJaVjZYUXI5RmQ3WkhJdUdj?=
 =?utf-8?B?T1BFRXIzR2ZORDBKN2poSUZqVmVHbUdDNHBaU1k4NEtHbS93ZUJUdzExbjNY?=
 =?utf-8?B?YnBpUzVTM2prNmFiWWsrRFV2Vk9NRXlZei8zRnpUOTF6b1JwaTBlNHRIaE1r?=
 =?utf-8?B?R3lWOFBoLzVmbC9Md2RCd3FWTnJhSGpoVnhiUXQ3QmRYQW91K1pLNklrQ2hs?=
 =?utf-8?B?cVdGemVrWjZMbFZJeVUweXZNQlBCaFp2TmJKWWdGaDArTnBwUWlnUllWek9G?=
 =?utf-8?B?K05GYjR5ZUVJZ3pkcThLVjBDa05iaE1Sc0FUSHFqT0xMKzFobFBnTklSS2Fy?=
 =?utf-8?Q?yJlG4PRwoCDXqQGY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: mDyZvLELhRI0ZTtBVIYFtm+0198NSNk8gR9/CfQ7BTscwN5gTAag/qAsreeh6u49tx4R5zbqDH6n1wuLPG5MGJK+FXfDpID2xVaQPmLzjt8QPL3CIMEf1Ufyig6NGSbtHahuP+T/l6mgRcYtqBZQuSjlEVMtxfyI++C3WyVd/cs+aRlXNr7EjdNaUZtTdgbleMQRrPoDyaoiESmFCEXZFk3ay1kfslgQyYzozMJiWFjlc8swVryZzl2jKuXixLEZknFuf0X6YVcsK5PPjvRSD6y2BLUVhfr0dUgu4mol5fNKyZETo/rDYV/TX/BzTzf1CuDYbDBhBHGwK93KPIuumw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9016.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a723f7-b099-4b91-ee32-08df3bea9b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 09:44:52.6079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOg75Dr+myYwbsxbfwyDjVIzOJUX6PP9f3VdsqN3b52VOGr7jPrHiAQJiq9GE2KsympqF6vE96jstJXbcWkDtU4b0gnzT+fsAH1q603rsQO1QWFBSWmR23pDmun9iHCs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF2A0C3F85C
X-OriginatorOrg: intel.com

SGkgUGF1bA0KICAgIFRoYW5rcyBmb3IgdGhlIGNvbW1lbnRzLg0KDQo+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+IEZyb206IFBhdWwgTWVuemVsIDxwbWVuemVsQG1vbGdlbi5tcGcuZGU+
DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMDQsIDIwMjYgMTI6MzUgUE0NCj4gVG86IERl
dmVnb3dkYSwgQ2hhbmRyYXNoZWthciA8Y2hhbmRyYXNoZWthci5kZXZlZ293ZGFAaW50ZWwuY29t
Pg0KPiBDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgVHVta3VyIE5hcmF5YW4s
IENoZXRoYW4NCj4gPGNoZXRoYW4udHVta3VyLm5hcmF5YW5AaW50ZWwuY29tPjsgSywgS2lyYW4g
PGtpcmFuLmtAaW50ZWwuY29tPjsgQWx1dmFsYQ0KPiBTYWkgVGVqYSA8YWx1dmFsYS5zYWkudGVq
YUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEJsdWV0b290aDogYnRpbnRl
bF9wY2llOiBGaXggU0NQIERCR0MgYmFzZSBhZGRyZXNzDQo+IA0KPiBbQ2M6ICtTYWkgYXMgdGhl
IGF1dGhvciBvZiB0aGUgZml4ZWQgY29tbWl0XQ0KPiANCj4gRGVhciBDaGFuZHJhc2hla2FyLA0K
PiANCj4gDQo+IFRoYW5rIHlvdSBmb3IgeW91ciBwYXRjaC4NCj4gDQo+IEFtIDA0LjExLjI2IHVt
IDA3OjQ1IHNjaHJpZWIgQ2hhbmRyYXNoZWthciBEZXZlZ293ZGE6DQo+ID4gQlRJTlRFTF9QQ0lF
X0RCR0NfQkFTRV9BRERSX1NDUCBpcyBkZWZpbmVkIGFzIDB4ZjBkNWQ1MDAsIG9uZQ0KPiByZWdp
c3Rlcg0KPiA+IHJvdyBwYXN0IHRoZSBiYXNlIG9mIHRoZSBTQ1AgZGVidWcgY29udHJvbGxlci4N
Cj4gDQo+IFBsZWFzZSBtZW50aW9uIHRoZSBzb3VyY2Ugd2hlcmUgdG8gdmVyaWZ5IHRoYXQ/IFdh
cyBzb21lIHR5cG8gaW4gdGhlDQo+IGRhdGFzaGVldCBjb3JyZWN0ZWQ/DQoNClRoaXMgd2FzIGEg
dHlwbyBhbmQgdGhlIGR1bXAgd2FzIHZlcmlmaWVkIHdpdGggdGhlIGNvcnJlY3RlZCBiYXNlIGFk
ZHJlc3MuDQogDQo+ID4gVGhlIHN0YXR1cyBhbmQNCj4gPiB3cmFwLWFyb3VuZCByZWdpc3RlcnMg
ZGVyaXZlZCBmcm9tIGl0IGF0IG9mZnNldHMgMHgxQyBhbmQgMHgyQw0KPiA+IHRoZXJlZm9yZSBw
b2ludCBhdCB0aGUgd3JvbmcgYWRkcmVzc2VzLCBhbmQgdGhlIGRlYnVnIGJ1ZmZlciBzdGF0dXMN
Cj4gPiBhbmQgd3JhcC1hcm91bmQgc3RhdGUgcmVhZCB3aGlsZSBkdW1waW5nIFNDUCBkZWJ1ZyB0
cmFjZXMgYXJlDQo+ID4gaW5jb3JyZWN0Lg0KPiA+DQo+ID4gVXNlIDB4ZjBkNWQ0MDAgc28gdGhh
dCB0aGUgZGVyaXZlZCBvZmZzZXRzIGxhbmQgb24gdGhlIGludGVuZGVkDQo+ID4gcmVnaXN0ZXJz
Lg0KPiANCj4gUGxlYXNlIGNvbmZpZ3VyZSB5b3VyIGVkaXRvciB0byB1c2UgdGhlIG9mZmljaWFs
IGxpbmUgbGVuZ3RoIGxpbWl0IG9mIDc1DQo+IGNoYXJhY3RlcnMuIFRoYXQgd291bGQgc2F2ZSB0
d28gbGluZXMgaGVyZS4NCg0KQWNrDQoNCj4gDQo+IFBsZWFzZSBhZGQgYSBwYXJhZ3JhcGggdG8g
aG93IHRvIHRlc3QgdGhpcy4NCg0KQWNrLCB3aWxsIGFkZCB0aGUgZGV0YWlscy4NCg0KPiANCj4g
PiBGaXhlczogZTQzYjMzYmY4ZDY3ICgiQmx1ZXRvb3RoOiBidGludGVsX3BjaWU6IExvYWQgSU9T
RiBkZWJ1ZyByZWdzIGJ5DQo+ID4gY29udHJvbGxlciB2YXJpYW50IikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBDaGFuZHJhc2hla2FyIERldmVnb3dkYQ0KPiA+IDxjaGFuZHJhc2hla2FyLmRldmVnb3dk
YUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsX3Bj
aWUuaCB8IDIgKy0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWxf
cGNpZS5oDQo+ID4gYi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsX3BjaWUuaA0KPiA+IGluZGV4
IGYwNGRmYjBiMzBmYS4uYzExNjIwZGJlYzQ2IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0aW50ZWxfcGNpZS5oDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRl
bF9wY2llLmgNCj4gPiBAQCAtODIsNyArODIsNyBAQA0KPiA+ICAgI2RlZmluZSBCVElOVEVMX1BD
SUVfREJHQ19DVVJfREJHQlVGRl9TVEFUVVMNCj4gCShCVElOVEVMX1BDSUVfREJHQ19CQVNFX0FE
RFIgKyAweDFDKQ0KPiA+ICAgI2RlZmluZSBCVElOVEVMX1BDSUVfREJHQ19EQkdCVUZGX1dSQVBf
QVJORA0KPiAJKEJUSU5URUxfUENJRV9EQkdDX0JBU0VfQUREUiArIDB4MkMpDQo+ID4NCj4gPiAt
I2RlZmluZSBCVElOVEVMX1BDSUVfREJHQ19CQVNFX0FERFJfU0NQDQo+IAkoMHhmMGQ1ZDUwMCkN
Cj4gPiArI2RlZmluZSBCVElOVEVMX1BDSUVfREJHQ19CQVNFX0FERFJfU0NQDQo+IAkoMHhmMGQ1
ZDQwMCkNCj4gPiAgICNkZWZpbmUgQlRJTlRFTF9QQ0lFX0RCR0NfQ1VSX0RCR0JVRkZfU1RBVFVT
X1NDUA0KPiAJKEJUSU5URUxfUENJRV9EQkdDX0JBU0VfQUREUl9TQ1AgKyAweDFDKQ0KPiA+ICAg
I2RlZmluZSBCVElOVEVMX1BDSUVfREJHQ19EQkdCVUZGX1dSQVBfQVJORF9TQ1ANCj4gCShCVElO
VEVMX1BDSUVfREJHQ19CQVNFX0FERFJfU0NQICsgMHgyQykNCj4gPiAgICNkZWZpbmUgQlRJTlRF
TF9QQ0lFX0RCR0NfQUxMT0NBVElPTl9PRkZTRVQJCTB4MTAwDQo+IA0KPiANCj4gS2luZCByZWdh
cmRzLA0KPiANCj4gUGF1bA0KDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpDaGFuZHJ1DQo=
