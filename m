Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011054.outbound.protection.outlook.com [40.107.130.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2992F296BA8
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768809244; cv=fail; b=AJSpFFY5MBwoCfxANKn4sqYhfQZDG3fgww3u0KON9oEZYaSZWD1HCBLbaLKtWf9iR3jSehjsW8ByJB3RxifO/WPcWlXPSsXMI3UN/2XnOqzqTMDrJeJENHMgUcpu19eN7vUbcJhVFCWFxVRfeJnN0wQcBfqBUjgKP+0yHICSY1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768809244; c=relaxed/simple;
	bh=XypggTM/nm8B57ChNwCG5JDEEYtyfRizO97vnh8TrUc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ddxvl0lfPfboOfvArWch3cnA4SJYWdzpXsNRucR+phxyeIxKg+T4QQC3YXrwyXVzXDjAUv2fwY8KC0gaeFC/dVq/yv28Ky0aSzPk6k8B5QEwLSlZ7eBhHCBZx8RDTDD+yn8o7XRkrzltpGGvDKzmps3lKjUg2Eohhca5e2djsG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mtw95eNt; arc=fail smtp.client-ip=40.107.130.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mtw95eNt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xy3g1IxKPv0zIGO2hgQeouIDE7pQ9rfZKBviyr3tqm14wMCQAGxJK9lC75SPV4y5IJEcW/nLS4NrBoB/iz5ClUKaNfcIUhx6iLW3FWg8eJtxJ+j0l4lDAVxOcBZrB8xwRZI+7yrbcJsgcDiiQGYTdg9QQ/fkSmltdJWXZ9s1SFMWDco8D6v+WI56/DGSXzYVjemAvLv0guswo05IiJIq4wvpfWNKKzYlfi4GM13fiMWndMBvyfuYVsqYGD6UThIF9a+pxYnIdGPwJ3w6pA2Q6yoPagFPQiSMWANUw+ql/F69g9Dh0vcbz1ZO8yZ8S5ftCzKTjh4JZ+FyhGoAzWksDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YiBjdBAGM+nMQkKL/i9RiOdSMufRBt2TZP68Pzh2s0U=;
 b=dmo1lMHhh4XXfT6qzEvxMEs8LI2zYwIkag8LwD+gNzIlkjuwu+dPs/WENlJ3xg+6dfSGj6TswpMfkdreQUf7EQt3fRALwy7n4YMQcn4/l5RVfTXtbWA+UQtkwlyjcWdecrOm8MxyqTdxp3gex5XA/EgwdCwmaRQ+N+cxQo4wmUP//uVFBumgFGFP21zjZwnYIzbwsbticuLyYxAjg2rIMWY1EDvIyxAKEAL5kG6TXFjBHCDNfGDbOQNNGBonFIXSdG+H2jrILzrZm7XuqG9TPJAWjcgb5hPykWPp2ykM3Lm20zg0/sAzKaAzXIEjHWl/N6lKOBWpBO9zHJrJWeguqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YiBjdBAGM+nMQkKL/i9RiOdSMufRBt2TZP68Pzh2s0U=;
 b=mtw95eNtLHy73phuuEMmPiDOc7RHKeYRIR/Sl8BQN+VR8iXotPfHSJ2v0BCjNjH78zbUnRwiLT746D/Zn5rtWvAH8G63tlgdcSv9uyNk9jfLUw6zjw0ErCOLygrskiTy/rcn3wtpAE1jlCByWCGDJNfpt1fH/ufaNOhg5ZZn/8m1mhrL2V2McaK5Me8kutQcbfsvHev9a+eXG07s+XKzr3EXIciPLwl2ei3gi9+IwUgSbbiqh1mpEEOnkf9suT04vb5Q8Q0D4FvUS1bcKgOTmivXaTAvgxNLAMkHuCpk5xK69wR3x4zPZvovUlPU+RF+z2aWz9eRBcOMiOU67ueO/Q==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VI0PR04MB11868.eurprd04.prod.outlook.com (2603:10a6:800:31e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 07:53:57 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 07:53:57 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: kernel test robot <lkp@intel.com>, Bastien Nocera <hadess@hadess.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>
Subject: Re: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
Thread-Topic: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM
 ifdef
Thread-Index: AQHciRjDB3SqPWyvTkCoLUgr7e/qOQ==
Date: Mon, 19 Jan 2026 07:53:57 +0000
Message-ID:
 <AS4PR04MB969210BA5934C14282B8F104E788A@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260116125803.598552-3-hadess@hadess.net>
 <202601170322.MZrwlt6M-lkp@intel.com>
In-Reply-To: <202601170322.MZrwlt6M-lkp@intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|VI0PR04MB11868:EE_
x-ms-office365-filtering-correlation-id: 3fb7b131-b619-4730-8e26-08de572fe66e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BrM4PiYWF/DhnDjToqmye3Ya7XKZX7ffTI8x1L+hwAJ6Vw4d4XPdxQGQs2TR?=
 =?us-ascii?Q?aZDFA6f7bfmb/yHy+4Im4CFghbhp1DqQ8Wtt1poZounwcaMchdRwhbixO53M?=
 =?us-ascii?Q?nNphEP7LlONVCKQGlVDLkYu5kzwS4XSszLe7Co9mQEIEZjGVjkyj64PW6GHF?=
 =?us-ascii?Q?WdalGVUJ3NCww0A0a4YbxzmU09J6hh6TguFPy9hiFzV7E6rSfbYxjMKnea9/?=
 =?us-ascii?Q?uod/2/bBqzKWSTpVr9K6GO50qlGMWVW6mGSKE6KAaElftQruUPG7ulw7OU46?=
 =?us-ascii?Q?K1sX4cHvoHJXsgTCFWxEGzYTnzCZ0jWcTiH7V1/pHUllPz11Yv8lhcTBEA5h?=
 =?us-ascii?Q?ctIq2C+RZ1jE4G9ZYGamZVu6vcXiGN15WJMqXI39GAMbPIl467Tv5w6bqlx0?=
 =?us-ascii?Q?8P81UzWwpljBH7g0qM1QzU075dJ4EX0Fr/x/jOBiWfjrWXuv/AZhxJrn/XbT?=
 =?us-ascii?Q?gUf63D5JOICMi+KnvtlTRyhjaNeiE0MGKmf0DogrGjpdgImsx6mIryr2e+fI?=
 =?us-ascii?Q?UcLDkIgwoJ/sv+OXUErVE5tkTAHWABWR9RaP95NIT4NmzBUYpLjmubWjcI+f?=
 =?us-ascii?Q?Yyfge3FrMlIjEWIJypm2WdHradGWnKXNbIqNWQ7sGRyphCOxU9yOPqKRIECp?=
 =?us-ascii?Q?os4W5qZ2ld+48A0gtd0Q8O6nDGDLYQ+Rv3Mo6+bOtkazZKmIcp2Rl8j8o/0S?=
 =?us-ascii?Q?V+naBtZgzVQrfdggKqbZZ0AB32hFnZ8ldu2JTp76kOyJvPkmnQ4EH97ykdBK?=
 =?us-ascii?Q?+IXO9LPclmjTKGrzk0pb9VdyL6EcEepGlGUcKswBs6+NlwkJsneO/O8H/T5m?=
 =?us-ascii?Q?ikettizrWokVDlhJh569Yjy7dRie/ohKhjheNIFIwwe/p4Y0u0CXr5nXU3S5?=
 =?us-ascii?Q?Ry+cGDMzL+5++121OjL5xLPz1TrfveQG5TCQL5cTv6sFhE+fuDyx5aoujj7d?=
 =?us-ascii?Q?7UceUYYflD4vlfkYAN6vXfGiQKPni3qrtLYeL3I2J40Na3m8mCEgv1ZKx3ih?=
 =?us-ascii?Q?soL1EtbjHqi4veIgHfVsVI5B4XUhRE9DHx0uXpr4/xKVEoFzJQTxYCtDGJEj?=
 =?us-ascii?Q?j2F09iPfdbFwN0AXTU67VCyme8gGeWy67rnlumKIYccMRPsn1KT5af7SMw4E?=
 =?us-ascii?Q?NZ1/uiV8S7QfyL3WucEyL/voTpKQkEvrCB4W5GTtP6cFQLoIixA/8lLoLC5E?=
 =?us-ascii?Q?bpCkHYaPBfO9KoNKkveafNBjDT28emlF47lDtuZ80M8OBIdDVT2gKKdXgakp?=
 =?us-ascii?Q?N4y5WQDt9VAvNAB1cPi4UaZen9EiKvjceZFEDF5r5PeXoopiltlk2bAxWQNf?=
 =?us-ascii?Q?Pzw0AFGKb+GkqVz8ABQwz1HZzRNdqKYlxZmHPZ7A+/txCAwzYbbel2s7lGP0?=
 =?us-ascii?Q?xB5/fHUwAMwmXyN7Ggv2MPMQzxDWJntOg/AYGTGc7cEF21tjbmlx7m6NnqIa?=
 =?us-ascii?Q?OyNE2/ehe15eF6KmucGUZHLVzl0Kp3lWoS/Nb4XBLcXM8b0iQdnHoZw8b0cP?=
 =?us-ascii?Q?BrR38hJJVA78/aB3U15qGZn20dbDrtEoGhj40L6ScRkIWPCVhygYGv/FMmkF?=
 =?us-ascii?Q?SG4vMEt0I65qasaVSew=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bHWTvJPBFJvRlorvQCV3lPtb1DMtPViYJO1YzOqo03S/bYixDnGBbXAMcBlE?=
 =?us-ascii?Q?Nng6WwgxDPAUrqRGOu5LvHnss3KK5LrAS7TvuUcZGP57eLsVFh90n4xXPLxY?=
 =?us-ascii?Q?vbWH1DFqnMyEydeS5YBaEp4xRylqaixKHKV8tCy9ptE0zWp0dEqwyMlAWXSd?=
 =?us-ascii?Q?UOTZW6CmN9wbQgugqj3O2HC0lAbfq7h/W6I3wsoWvTVIZwZyDSRIopavkvyK?=
 =?us-ascii?Q?sKbo5PTSmjNlNLvsSCTOSm2Om8bfvGNC4WNUlA7vJAe7voClpxdO3Fe9TQ6N?=
 =?us-ascii?Q?rBwhEE/weygQWY1czvvWIgZyNxgMsRZg+smhRUuhK/yrZOP5IGFbitDI3LUZ?=
 =?us-ascii?Q?466yCB2Nzt1LDJ1w4Hs+M4vGFUNoaX9V9TxjFkHpi4MAwgQCNk7qh3axYoFc?=
 =?us-ascii?Q?VFtE8lAuWgkaX+yBqHanpIz0xykoLJkSV+GXxbGCO9UTIZpjRvaJM2/vF7y1?=
 =?us-ascii?Q?4a2lhv3v7/rWQyQrL9BpuEdaGmej8quTF7FZumR4RY3MRkgF1BR/CVswKX5V?=
 =?us-ascii?Q?1Asm6X58Ra4QiO2jzRX/4tdFfxBPKe9p1GL1bDhpylPf5SzRGVWWW2SjEqBo?=
 =?us-ascii?Q?fsGuAmegxywRrZaF7VwaCLFx3z2TQjMSabsy3ACQF79LSxbIBrL2th3cOPJA?=
 =?us-ascii?Q?ESO1XGgqenMsSsIDIrvntNVMID7jooRqzT0a0ZlWl3Nzx1D69gYFg7BVP1ax?=
 =?us-ascii?Q?NIiR90MtuLrJxprYfiWgVNQU1VqSudt6AireP9xumRahxVw58SMt0txgCfiD?=
 =?us-ascii?Q?OOdduRtspoL1EUQ38eFyuo4RRuqhNZQUdmKBnKonzNW7DoGKtrUK0EiHAJ4g?=
 =?us-ascii?Q?YHE4qkp8W2lmT/rIyGABFqTU23RBCbKEJai7Lp/pBRhbztBD5SRn0j7fb851?=
 =?us-ascii?Q?kBwWAZgPjxNQbb/vta59jMIRW60sJO/8niiCfnZSMAnAglfnp9FfVuHxgPSp?=
 =?us-ascii?Q?7j3okGAo+bGn6zWb6+BEfFXu4BKYpAgX43AAEkxqHXOGhlo6ChFLLpmtuW0+?=
 =?us-ascii?Q?s5xLV/uOI0aurKCJBNv0OGvtuhKK+upcmThmGJ38C8UTdU/KShfVloW1g3VZ?=
 =?us-ascii?Q?DF4uP0jXaD7I3cOxJNqpAcUDtbyAvymnSA5abyxh7+FAx9QfIzo0LlLMFxFV?=
 =?us-ascii?Q?k/DuwfwKb01HHs+WkrBmqAWxM+yxU5WST9SLuaIq0PXaa3tlXdwsRIVfn5my?=
 =?us-ascii?Q?HlSqU47Vlv9636thuoilDyoCQAtcEITObBzwE0IVFqCJ5JUo/z1BtJXUjoW8?=
 =?us-ascii?Q?i6atcKWkG+JdVmlJBm9ru5a82wTl81l7YARbEd6wwNEB+us7g+UwGdnaoSBl?=
 =?us-ascii?Q?5mcbzaCrwML9Ul2gF/RkShDQdlfCqdvUhS1KfOuhE9A/O4yQwuDngXI63v0B?=
 =?us-ascii?Q?Wbyc3bviGlTC4slXi3NW42I0A0r7p0zQVP0a41KEI/9HYepJhLAqvJBlJHRI?=
 =?us-ascii?Q?DckWC/eIHyGQ6y79hK0ahBRP2DBnu9llvBXwDUhgMNYgaJsA7L/3ztrFfS54?=
 =?us-ascii?Q?2zNcQCa6+Gz92FkEboCrT3h+ehfKqqHg5rhM2vMKtpg53bgWPCxle0qZ3a+Z?=
 =?us-ascii?Q?SvzuJyEjij1z8wvh88tTDXVmanIn4jpbXNpvtdDB7r2aurJ3120qQRSWiZCN?=
 =?us-ascii?Q?FMWkd8HJ4lH8hu/m4S6FkFL+oNrqjMvw5yIGr1DdQQRk8nNjaXvV4hObsqi/?=
 =?us-ascii?Q?rRUQMw/GwBBvcy8nfhakDpw1EPIR/A77t8IJemcn8X7/ta7GNbxvMiWN99Ja?=
 =?us-ascii?Q?sDt0QtYv4Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb7b131-b619-4730-8e26-08de572fe66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 07:53:57.4100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GbzcMPbaajTULNMuVPEJbbmJN/9rNF0KFv8zemiPGNFRH/OFMbTDUFncNs/JPWrNxnJ6ra/c2AEeeaNFaLofvg+fjQGHt3pNCEQoVN7eHHI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11868

Hi Bastien,

Thank you for your patch.

Just an FYI, the " #ifdef CONFIG_PM_SLEEP" was added on purpose to resolve =
such build warning reported by kernel test bot:
https://lore.kernel.org/all/20240710123426.935122-1-neeraj.sanjaykale@nxp.c=
om/

Thanks,
Neeraj

> Hi Bastien,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on bluetooth/master] [also build test WARNING on
> linus/master v6.19-rc5] [cannot apply to bluetooth-next/master next-
> 20260116] [If your patch is applied to the wrong git tree, kindly drop us=
 a
> note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-/
> scm.com%2Fdocs%2Fgit-format-
> patch%23_base_tree_information&data=3D05%7C02%7Cneeraj.sanjaykale%40n
> xp.com%7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92
> cd99c5c301635%7C0%7C0%7C639041898935601715%7CUnknown%7CTWFp
> bGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4z
> MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DW4jhk2S
> VUr77jirvKdK%2FrKuKAVyXSbY9iO2pQ1%2BL7Fs%3D&reserved=3D0]
>
> url:
> https://github/.
> com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FBastien-Nocera%2FBluetooth-
> btmtksdio-Simplify-dev_pm_ops-usage%2F20260116-
> 210400&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f3219146a754
> 0774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C639041898935632879%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcG
> kiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIj
> oyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dl2nEr61x%2F00NrtEqmvX2qhJ%2F0d
> %2Fc6T%2BI6e5YRiz1TAM%3D&reserved=3D0
> base:
> https://git.kern/
> el.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fbluetooth%2Fbluetooth.gi
> t&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f3219146a7540774e
> da08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> 9041898935651605%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
> dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3
> D%3D%7C0%7C%7C%7C&sdata=3D%2BKZxHj6EXqJXKC8%2FsiYrPOJczts%2BMEX
> ycXixKcxUcf8%3D&reserved=3D0 master
> patch link:
> https://lore.ke/
> rnel.org%2Fr%2F20260116125803.598552-3-
> hadess%2540hadess.net&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%
> 7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C639041898935668808%7CUnknown%7CTWFpbGZsb3d8
> eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
> oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Da3gomBec5GENv5B
> RsBv%2Butzd11I3QunXE2yAaDg5f4Q%3D&reserved=3D0
> patch subject: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded
> CONFIG_PM ifdef
> config: x86_64-randconfig-002-20260116
> (https://downl/
> oad.01.org%2F0day-ci%2Farchive%2F20260117%2F202601170322.MZrwlt6M-
> lkp%40intel.com%2Fconfig&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com
> %7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c
> 301635%7C0%7C0%7C639041898935685518%7CUnknown%7CTWFpbGZsb3d
> 8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOI
> joiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DhR230cwqc4FucDn
> 9TPmv79VLdAd8kHHwc2Q8SdPtHtk%3D&reserved=3D0)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0 reproduce (this is a W=3D1 bui=
ld):
> (https://downl/
> oad.01.org%2F0day-ci%2Farchive%2F20260117%2F202601170322.MZrwlt6M-
> lkp%40intel.com%2Freproduce&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.
> com%7C6f3219146a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301635%7C0%7C0%7C639041898935702245%7CUnknown%7CTWFpbGZ
> sb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIs
> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DdsZA9O8KQy
> QZJK2Fn%2FYtexA8zdrw%2FCcpwnEb7AwhiqU%3D&reserved=3D0)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore/
> | .kernel.org%2Foe-kbuild-all%2F202601170322.MZrwlt6M-
> lkp%40intel.com%2F
> |
> &data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f3219146a7540774e
> da08de
> |
> 5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63904189
> 89357202
> |
> 33%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjA
> uMDAwMCI
> |
> sIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sd
> ata=3D2
> | s046Nm4SrgCfY%2BqPyoYr8tf5xqoBw%2BqDiJ0YQ%2BiAt8%3D&reserved=3D0
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/bluetooth/btnxpuart.c:1964:12: warning: 'nxp_serdev_resume'
> >> defined but not used [-Wunused-function]
>     1964 | static int nxp_serdev_resume(struct device *dev)
>          |            ^~~~~~~~~~~~~~~~~
> >> drivers/bluetooth/btnxpuart.c:1950:12: warning: 'nxp_serdev_suspend'
> >> defined but not used [-Wunused-function]
>     1950 | static int nxp_serdev_suspend(struct device *dev)
>          |            ^~~~~~~~~~~~~~~~~~
>
>
> vim +/nxp_serdev_resume +1964 drivers/bluetooth/btnxpuart.c
>
> 689ca16e5232784 Neeraj Sanjay Kale 2023-03-16  1949
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05 @1950  static int
> nxp_serdev_suspend(struct device *dev)
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1951  {
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1952     struct
> btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1953     struct ps_data
> *psdata =3D &nxpdev->psdata;
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1954
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1955     ps_control(psdata=
-
> >hdev, PS_STATE_SLEEP);
> c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1956
> c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1957     if (psdata-
> >wakeup_source) {
> c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1958
> enable_irq_wake(psdata->irq_handler);
> c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1959
> enable_irq(psdata->irq_handler);
> c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1960     }
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1961     return 0;
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1962  }
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1963
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05 @1964  static int
> nxp_serdev_resume(struct device *dev)
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1965  {
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1966     struct
> btnxpuart_dev *nxpdev =3D dev_get_drvdata(dev);
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1967     struct ps_data
> *psdata =3D &nxpdev->psdata;
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1968
> c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1969     if (psdata-
> >wakeup_source) {
> c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1970
> disable_irq(psdata->irq_handler);
> c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1971
> disable_irq_wake(psdata->irq_handler);
> c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1972     }
> c50b56664e48b66 Neeraj Sanjay Kale 2025-04-14  1973
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1974     ps_control(psdata=
-
> >hdev, PS_STATE_AWAKE);
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1975     return 0;
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1976  }
> 658c56d5b3b3a41 Neeraj Sanjay Kale 2024-07-05  1977
>
> --
> 0-DAY CI Kernel Test Service
> https://github/.
> com%2Fintel%2Flkp-
> tests%2Fwiki&data=3D05%7C02%7Cneeraj.sanjaykale%40nxp.com%7C6f321914
> 6a7540774eda08de5538a471%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C639041898935740752%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0e
> U1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCI
> sIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DIqE%2B%2BS2ZXcZb5PFvsvemp
> dQffNOiktBLNpxdDx5JJJg%3D&reserved=3D0

