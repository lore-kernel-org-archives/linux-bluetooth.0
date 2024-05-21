Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B307E8C13;
	Tue, 21 May 2024 00:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716250801; cv=fail; b=k8HCZwLHro1/1saYIbiTfLRR682RZ2e9GxwXg22JU/Bgdo+Du/Wwx90EZ6u05bZoDHfj3F8516Z08OhAz6z7K16Qdn65X+xlSN5fKa0q4GcM1w0B2WykFlPFRMplV7SzxBOrKSLy35Zp5jjZ7MArCyl+wNleM/sZIfo8gyt4QgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716250801; c=relaxed/simple;
	bh=9ZvEeCRnHnR1xTTYBObaHb9m8NNtE/HpWRAVRRwLFwQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZgIRWn5rZadO7qfushJXHg3ahx9eT0qn+VzX8ZILvsaifSyZ+0L0P8YYGIjzkG+mv0ZwyQX9bqzXyqda8O6nngwZsrMvcU4Eqd3wGVb8ZqmwVqbRG8cHaO/8fDXioHSwDeUv6WDIf7qyI4xiW5f9Lfu2oqOGMRMAMuH3re9RBlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Edz65E2q; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Edz65E2q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716250800; x=1747786800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9ZvEeCRnHnR1xTTYBObaHb9m8NNtE/HpWRAVRRwLFwQ=;
  b=Edz65E2qGRm68BdPj0G/OzPe5QX+rzXPFu307Cmzsx/7566YNoZgvTNm
   g8pEE+uvpHjDU7PAZ/CE+epbSd+FvkyzlfZzdQy0Q8I8VUevnPMltUiWm
   9X2QMFkDdpyKbghaRtr2OX9rVxy/odUsrpmHrFgP4TH5WTHnDb8jdEh2G
   U8EIjXPa6d3l4EZ2vYE/5VunTJnlMyNesN4Lmip+nSRrSEGVNOaNWGSqF
   PTn4UFjlgSf6VEHW58EjMHqUd5NA3JauAZvstZAR57mMU32ZpQc+94IrN
   D2t5WqSnJg1WErleLV9ub7tcMYXRxjMCS+b69zYcp0t6UPRZ59360CuSz
   g==;
X-CSE-ConnectionGUID: rNdx5bsWSOur5g3vm8nbuQ==
X-CSE-MsgGUID: haXdnhu/SDObLMRpCzDhNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="11618849"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="11618849"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2024 17:19:59 -0700
X-CSE-ConnectionGUID: KU/RmbCKQyGQMq+7aESbLA==
X-CSE-MsgGUID: hTpYlpyGRb2PcCnD1bsFTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; 
   d="scan'208";a="32892536"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 May 2024 17:19:59 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 17:19:58 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 17:19:58 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 17:19:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J93GB1usZ+SdZnHwk1VUuiX/8Ni7a6K242CdKJ5oXRZb+hjr9Kt2y0Zc22R86VCSNRn6SBso1RY8V9dNLzJk1wF0HculHuKhMeK2vdIuk1TNzXVIVIBM1xny0kvl2hQ9yHdAYjdUquLEzVouQD6YMVMIh1x9Fd2jFryiQg9VHkno5G+dtiSJkLzPUDfmMqavALW4Usid74X+EHZzHA+pJjYJCGOQ7aRu4ZzuAPstvXdngKiVQB+xV1BZ+gOPOjCRTXlpoXf7Yz39atw69VrNYHWaV7eX0rsKnCaNYm80I+XAxDJ7U47YHVx95BI9nr6L5IUdg5E9q2RjgKFihp5RIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRziHGjDF832ZuqUkvWQ06ONtfLRErWuEkha6P9Zx+I=;
 b=EP9pALy9n+QtJNAz475jEgGKwO/J8TFv5xT1XvARBIrTZKTAH2sJsbrVEJ7YDYisfvIrPhjvEOY6JJ4vjLYTPivBzNbdL71IkhttNZufjHWILmNj8Tv4dkyW6tVEp0WAYBCoXigeIKqPQQDgS8QvNyMO97ubOs0S3ptoxemmvh9dg1w2pPmSmkkxOmNU6kYxUEeRQHdWFs/Ph5jvYF3tZPSEE7dwezqmNL9hNP31FgdMjJC9oauXaREdfuvUfWaLAzh7b+tEn1EEheHkF/o+gLzK8AVsJ1Fla5Qz5NzE7MsUe2qaV8HEmQHX7lJo8hGoFNG1bVMC+NR89ri9VXYcbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SN7PR11MB6969.namprd11.prod.outlook.com (2603:10b6:806:2a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 00:19:56 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::9ba4:34:81ac:5010%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 00:19:56 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Su Hui <suhui@nfschina.com>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "nathan@kernel.org"
	<nathan@kernel.org>, "ndesaulniers@google.com" <ndesaulniers@google.com>,
	"morbo@google.com" <morbo@google.com>, "justinstitt@google.com"
	<justinstitt@google.com>
CC: "seema.sreemantha@intel.com" <seema.sreemantha@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH 2/2]  Bluetooth: btintel: fix use after free problem in
 btintel_ppag_callback()
Thread-Topic: [PATCH 2/2]  Bluetooth: btintel: fix use after free problem in
 btintel_ppag_callback()
Thread-Index: AQHaqlvaj+o7AieD+kykBUFft0mKDLGg045w
Date: Tue, 21 May 2024 00:19:56 +0000
Message-ID: <PH0PR11MB7585ADB11BA022103C6394EFF5EA2@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20240520021625.110430-1-suhui@nfschina.com>
 <20240520021625.110430-2-suhui@nfschina.com>
In-Reply-To: <20240520021625.110430-2-suhui@nfschina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SN7PR11MB6969:EE_
x-ms-office365-filtering-correlation-id: a0039e4b-08b1-4275-4ea4-08dc792bbe65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?LmMLHs0emNB40ubqC8fJimVwX9Qd+aHOw6+d+9Ue31pew2boLuyIumjEp8ae?=
 =?us-ascii?Q?2fjUDei+njPs4HNWc5TCQi9hhEW1jSw4KvGds1fcofwcviE0cFQ6cYeQFhyM?=
 =?us-ascii?Q?1D5W2SjluzUofjZDg1jY+zA5iDD8yKFBad5CuJDLVVhm6iZdFRs1E2Iv+ScX?=
 =?us-ascii?Q?Z1VPhyrASXuQe9cQcr95DoZ+7K19FebT/q72OgRxV0J/jUp3tQh77sUVakhl?=
 =?us-ascii?Q?L6movRy0DwDRNlQ0xyn6Nfzis7lA72hT3l/q/M19XxGzpdeGHEIjosLvMrah?=
 =?us-ascii?Q?xx1bAJYGNbyuub+DRQH0OUspL3pyFJslGPAw6KNkMFE3X3LpSXisB0anZodT?=
 =?us-ascii?Q?7ppsK52FyrBuaf6vl5wEqHkCP6kqcYO45eEpoVXQsxEsC+lY9X3hxj0MHN7b?=
 =?us-ascii?Q?p3nbzaA2XJ2sdAqtQPIn5gwiaYZ0Dih7iudyglbFwq4+8hnYm/pDdDe4CL/t?=
 =?us-ascii?Q?5cSXij6LCGYEfWINu4kN9jRt8pqMXr0wQ+hnfQt3scYXjuVMvg0jQXGNtcj8?=
 =?us-ascii?Q?liGZKX1mVfUVgB3905guYIqWz6jsaPRoEIyM3oKWal/chO8h1uUbnz3WHFiA?=
 =?us-ascii?Q?Cn8vlsI1HJgkQARCZoDZv56DvwN6Q7ilj6TjHYmef0R0zIMKGYreaU7PD33P?=
 =?us-ascii?Q?F7eqfwF9VHeT1d0KkoT7wkRftVDIbh3qJwAJznHvXOdbd1Kj5o5UmMsdVect?=
 =?us-ascii?Q?QFngwGSpl/kFIHvyykituXs2UsetuA18U73Rz15cYXiZ7V1KKZerh050o/oa?=
 =?us-ascii?Q?XtATBq/SkXtZjnwvMAxOyBKqxCAiou6VMST+/x95nSLLfynUKuFRPpPp7BN0?=
 =?us-ascii?Q?jyA3hudV2ghZnIi6160vDxSRjmX7D0ja9IETdbaB++mLWovizneLUW/2KhVF?=
 =?us-ascii?Q?K2qju+1XtWBjyOTUaEsGD0njsONb5m2sZBxSxzk2G7s0Vv5i2mnr0cFVXRiD?=
 =?us-ascii?Q?bbBCYUixJ2fNV7/diAifvsOlVmsHjs4vJ8xCHTk2w/vPR7ydTOrXayPDcymO?=
 =?us-ascii?Q?mg6rayXKoYu6arpR7f7knqnUnQ3+VGZbrduB8iQ+iRYSoJIGXDr5ax4fcD9J?=
 =?us-ascii?Q?VGXhugdCt4OEejbN2DXlGcEDjYBrGz68TXLGMS0awaz1hLq/w1htjRBPvDe6?=
 =?us-ascii?Q?J7Kzlrj5JpVvIT3RTpfKHT5onG7aV/ZYc36lJUnl41GSAxQyAerQzzHfN65F?=
 =?us-ascii?Q?ZcPfXkIgGEYvWv5W9Gf/l9knVMAkoPfs/krN7DfV0KOGCDLaxTQ668B1F08V?=
 =?us-ascii?Q?jRPaefs1oG60wdbUo9FnxO6Ry3UVbHrnfNB5iswH8iXoDtmKyLxEmicN6Up2?=
 =?us-ascii?Q?dd1tDnoFOXmR8vdq1YVkfPLYDiBmlerHbcS4S3vgcAfoPQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?I0rNb7Rkd4uMO9O47f3EXpKlmaiis2T00x3KSQSRNsR2kI5GmoAg1gKzjI2C?=
 =?us-ascii?Q?wkD9r4QYeNUAfl/j4D9wtluRftjnn1Mbu6lsRjFHyBrKQcIi8H+P8+TF6MBV?=
 =?us-ascii?Q?n3MgNbkkJrKmeHKybik7ltb/ovI/RxIPBVpM8PyMAXS47qiQIvJK9qW3n3co?=
 =?us-ascii?Q?Znc9m9dL583qgf5Hwt0M2so7mwWO9IDrg9B/2FPXPF5CcJe2DtAXC25zmlph?=
 =?us-ascii?Q?Fit9LetKcBOwMkg49JmI1e62ZQKCuXRTO/E2s84mBAxZjCC+OoKM3qS8+AGF?=
 =?us-ascii?Q?V6g8G+hkUhnaWSzqdDE7pCuxlCqDZsD6pvlqoY7tA3MuVc4M9WtNuwmqKSw3?=
 =?us-ascii?Q?4LHplgTqnsVYiuiAOCYZw6Gx6lra01G0QKtXE5h1BT8b7CciFCmG6Th40NYL?=
 =?us-ascii?Q?3xiITu6vgMU+5fy2LvR0CRkERp+bpFkOS3oSz8KE+A1OPcq2Y/Au2oIPm0gp?=
 =?us-ascii?Q?kwX9q2y9IaNjHfJbAoZ2QO1mvoPNCW6MCSfSZMgunSo1o29rSFOVxB534lZT?=
 =?us-ascii?Q?BVDaBRdrfFS8QPObyWWZjeDVLuAqzmv5yXxg88rOLV/RNB64znZKSMsF/Q0w?=
 =?us-ascii?Q?hjDUTq3ehMq0+bXCKTJ11EwrKRXzjzH4Dpc131sNpiYu2FMtPtRQ3NiHzfiA?=
 =?us-ascii?Q?2MQz6dIdQyQCkaaiP04eiCIcG0vfrYLJtqQZS//G3pH70hCKQrAl3Zde5ze7?=
 =?us-ascii?Q?BbWO19SVoA8TZf7rP9EOD2pn0NEGCZ5lzh0uOaV3XeQYQGZBlSpd1Ub48Jit?=
 =?us-ascii?Q?v6wxd+1LJHfV/RWE2fXWs/IN8KptezLF/jbHNptahuFivcrIZdl1B8kiT2+Y?=
 =?us-ascii?Q?lfH0JnJMRbBW2fv3Cy3HQFPvZqiohlefH/ihycmEVpnES2igUHiaatM3Je5P?=
 =?us-ascii?Q?bIS6mrKzOi2L0LorQQuxs0wlYHqNtZ9jxs3U26GYMMWUW57QJAw5yKB87WZy?=
 =?us-ascii?Q?lihEc/d227velg/YhtH4NIt8iS0qRBeMqyuuueYLpes2eSZ0d/W46e0S1TNM?=
 =?us-ascii?Q?rlVSp/aPAjUzOvgd4RhoFUjKXREvS0XfRbMyptYnidAhV59KhEDAqH5IWeYM?=
 =?us-ascii?Q?X6myFdujFftZIK1PyDx88PFrqJtofMffCOAGUbKTvjVLnRNJ4sNtXmY4/BVR?=
 =?us-ascii?Q?2EjPg9pluPMZAAxAvvjGid+n5HBH0IKTvHdLj3UxepGi5PLVb/9Eq59dewPc?=
 =?us-ascii?Q?XVnsm5fypxDppav8r+6fjUg++KGkaa5fCHZWwZzr+xGyi9uocCyDb++tKGT6?=
 =?us-ascii?Q?lV8szmy+Covlodkxu3ntTv4Zijflctx+gYT95SlCerWMSQR+9ijSRv7SqXP4?=
 =?us-ascii?Q?V6Ayhc6VyuoTBu97r/zYjcAr6uqICF4E+Kk3b+WJi8fXQexFfdXRbQUn4KsV?=
 =?us-ascii?Q?7yTnx60xmob2rgDTeeczacmiQyXrD1MCeHEtJnukZNcCguKKBVSCTYUrRHVJ?=
 =?us-ascii?Q?OCXrtT9pUbA5nSYr8jE1X2VHosHoyHF00bCQV1/lC/IgX+/U5KqqbJSobTT2?=
 =?us-ascii?Q?szzGlKsJLod/VHVARVyxxvHzVaGDFOG81a/bqsEhCLvaELtnoLf/xMjBXddV?=
 =?us-ascii?Q?U/3upU4A1gD7vHGBwzk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a0039e4b-08b1-4275-4ea4-08dc792bbe65
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 00:19:56.4172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIdORdhL41/dPm36AmnbeLaXPE+zKdQTWedrL3plmY+IwM7+5J6CPZDnfQ57FPteTIs8GQbs9YJQM+G237InVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6969
X-OriginatorOrg: intel.com

Hi Su Hui,

Thanks for your patch. 'btintel_ppag_callback' has been removed as part of =
287da9035b2e.

>-----Original Message-----
>From: Su Hui <suhui@nfschina.com>
>Sent: Monday, May 20, 2024 7:46 AM
>To: marcel@holtmann.org; luiz.dentz@gmail.com; nathan@kernel.org;
>ndesaulniers@google.com; morbo@google.com; justinstitt@google.com
>Cc: Su Hui <suhui@nfschina.com>; K, Kiran <kiran.k@intel.com>;
>seema.sreemantha@intel.com; linux-bluetooth@vger.kernel.org; linux-
>kernel@vger.kernel.org; llvm@lists.linux.dev; kernel-janitors@vger.kernel.=
org
>Subject: [PATCH 2/2] Bluetooth: btintel: fix use after free problem in
>btintel_ppag_callback()
>
>Clang static checker(scan-build) warning:
>drivers/bluetooth/btintel.c:1369:8: Use of memory after it is freed.
>
>'p' is equal to 'buffer.pointer', using of 'p->type' after releasing 'buff=
er.pointer'
>causes this use after free problem.
>Change the order of releasing buffer.pointer to fix this problem.
>
>Fixes: c585a92b2f9c ("Bluetooth: btintel: Set Per Platform Antenna
>Gain(PPAG)")
>Signed-off-by: Su Hui <suhui@nfschina.com>
>---
> drivers/bluetooth/btintel.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c ind=
ex
>f1c101dc0c28..d94a8ccd1428 100644
>--- a/drivers/bluetooth/btintel.c
>+++ b/drivers/bluetooth/btintel.c
>@@ -1364,9 +1364,9 @@ static acpi_status btintel_ppag_callback(acpi_handle
>handle, u32 lvl, void *data
> 	ppag =3D (struct btintel_ppag *)data;
>
> 	if (p->type !=3D ACPI_TYPE_PACKAGE || p->package.count !=3D 2) {
>-		kfree(buffer.pointer);
> 		bt_dev_warn(hdev, "PPAG-BT: Invalid object type: %d or
>package count: %d",
> 			    p->type, p->package.count);
>+		kfree(buffer.pointer);
> 		ppag->status =3D AE_ERROR;
> 		return AE_ERROR;
> 	}
>--
>2.30.2

Thanks,
Kiran

