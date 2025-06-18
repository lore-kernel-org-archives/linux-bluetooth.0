Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012029.outbound.protection.outlook.com [52.101.71.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0732EE974;
	Wed, 18 Jun 2025 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259475; cv=fail; b=Xiae7QXO5AhxNsVvWwrNNUs0hQcqzPCPXpvyaU8f53Wau4yRQRmL37SMyMGJ1Pd6kiVp66VQxCTbRSdh0CC/tmInr1OFJZtFvdSpjQ5ea8CkP1KOriEoZUxrUfmJ4ZbQVdA1hh5/SJAoY3oBjQfY8peaRHmmokGC3Okm/RC2AM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259475; c=relaxed/simple;
	bh=ZOU+KSADkeqVqR9RyBBgPun2vxb8opN8hcwGlMqbyBw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kFbXn3y/CB60OveMxaD1A+VkR1uX4U136Ehn4OskYJz342dcwDbualFe5Fe822mNbtt4CL2VydI+mLQZAb0B2l5aeDQLdgJDc9WN0AseJ3/KN1yu8wJFRa1HJEZrWSAI/0b6cK0QkwxcWPQjETeTu1TASMiEzG51EvXvxAoM25k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IyODrtnp; arc=fail smtp.client-ip=52.101.71.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IyODrtnp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwEH0pt0hxTiZQ9mIFwct0Ss1KFw3njTQEsVV2fSy4YTGaLs068CAo0XACX8sIv1rtDtIJ5J1CTpRSqaKSOwxuoMvohpwNDqswFJIbMPsKRISCMQByUCyuvB4Tfr0KjfAyqaxEwaBSyh5dDi11RVBAzTmJqrs2l+ba2270qGJQ8tSjehUdQxWIYNUjpq0XtvnFubZ39hvMrGBOBRvLR0EqzPF+0FJ1F9zn+ivOxZhvKxPo2droVtXr5YqiRiEUaVODesp845La8RLnaB0gWGipOlvbH1iANoKJyFBtD+Pp33Iwfm7YykRcrWXUdYb3NsBJ71xzxzarvkmJgNVQv9Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOU+KSADkeqVqR9RyBBgPun2vxb8opN8hcwGlMqbyBw=;
 b=L/Km8X9Sl6ajYrqSWMKo2bev6YDS+FgaoSdMkQRfXuVNnnMKj95ClfsJpAqZs56efDh1BQq2EaHHsS+b2xqn0jflrdCSL49lO4oVB7KTKZm4/hZk0PS2gbRE7d5J8ezxvhu2QINyw52O74NsemWBtIt2ZieN6hY6fLQ8oL1r2awb81zLaJeWRmBpjeBELXMM5r6Kg76m7x5YnhfHSBaZOZrs6BXzuccMxp3/ys7xoXLHQHMZBs3igKi374Dnqmz0O/G8YQI9qPjzfAEIPtHfM2ycuV38eV4/GUXUn1iKHtKknY7jnYbW9d5fX3Oxp6DnjDmVrjdrV2ZFqCoCDp3ULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOU+KSADkeqVqR9RyBBgPun2vxb8opN8hcwGlMqbyBw=;
 b=IyODrtnpXNx93JwSUStJlIWnu/pC24Vny48CPwT6weJb7IxzIMepu3YlBT1QB9cgNflj1V1hANXIhHCCebyWyz6WkrPqN4DiHquvPsA/mEk8e/0iBGPpSvQ2mTDOYq65sSBmVsEIBKbPcfjg8QJ6+3fG6KyAmk0l4Nd2aEuBA0OLC0lQBri2PHO4e3CJQ1tawkU7jbpkTYlwTgHFi4oLujebvOfIrkAEcLYNTjFc7JWeUapSefWOPaKio2u9y/GuVjZVA5/mAe1DJ+cBXm7xvEMXnne/EVcxPoMmJI5rBHUo8u2RAbWtM5RxWCruXt6SkuQ3XKSuCWSONJazOaidfw==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB7672.eurprd04.prod.outlook.com (2603:10a6:20b:23e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Wed, 18 Jun
 2025 15:11:11 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 15:11:11 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Manjeet Gupta <manjeet.gupta@nxp.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 4M baudrate
Thread-Topic: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 4M baudrate
Thread-Index: AQHb4GM5+QH/LYK3nkmF3zYO4YxFxg==
Date: Wed, 18 Jun 2025 15:11:11 +0000
Message-ID:
 <AS4PR04MB9692263405F56AD71E369110E772A@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250618142012.25153-1-neeraj.sanjaykale@nxp.com>
 <3fb36656-5aeb-45f4-9460-acc8a2bc3c61@molgen.mpg.de>
In-Reply-To: <3fb36656-5aeb-45f4-9460-acc8a2bc3c61@molgen.mpg.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AS8PR04MB7672:EE_
x-ms-office365-filtering-correlation-id: 8ad832fe-0d27-4bdc-0441-08ddae7a5c29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bmxSMnVSck5obEFrTTZKSkZWN1lVNnUveWFFaS9aMitCa2ovOXVCT2t0TzF2?=
 =?utf-8?B?ckRQWEdHWVZ3VlpSZmJ5eUxDT043VkdJY0dYbXREM2VIZzA0VGV1V2VXWWJs?=
 =?utf-8?B?VHkzaTY2SDEzUmNBdTgybENXd0EzRFNUY29ESC9tcE85UExOQkhmZFNhSnRB?=
 =?utf-8?B?QWp3WDBaelV3cEhyK1ljT2oyeEtmR0F4OWFIVjVSWkR6K0FqdUJTRkJObjVU?=
 =?utf-8?B?RlZKTWVpM1JWbGlnVlpiTFV2eVlMT0VrZ1VZVmh2dEljRUhXcW9Id1lPM1BJ?=
 =?utf-8?B?L1NudUFOQmJWS0NELzdreTlMb3NsTDlFcGpNc0VsUzBiTEFqSjRtK1RMaXJJ?=
 =?utf-8?B?WWFpdENNNkV4MWNHZ0ZCTmI5bXVuQndaM0Z1STdWYUdGT1l3UDhrSW40Y2Vl?=
 =?utf-8?B?cG5tMTVMVWdsWG5hc3pnWnlBejdOQjl4N2ZqbWV1bUZ0dVM0MFhhM0NXb0pL?=
 =?utf-8?B?VTd4Rnc4Q3FZUXhEVlpFOWs1bWNhYUIrRzVDS2dxRmsxOHRjazM4Wm1xM21w?=
 =?utf-8?B?TTdnT3lLR2l6VjZtUnBsUkk3M2NXMm0vNExEbWtzcGJtaW00QmRMc1FNNDk2?=
 =?utf-8?B?WWxPMm9uek9nUi9OWmFEMzZUUEhocFNyK2FGckd2cHlpVHhSNzg0NzNUckt4?=
 =?utf-8?B?UjFzVTdXMkViaVdMakhiSGN2MFZpWGFidlRKUWtETXFZckh5akhyeHV6WGtz?=
 =?utf-8?B?d2lET3BtQ2pnc2tNU01XOVFWd1hiYlpTSElHeTZxZkRGQ2tWblIzcCtWMnFa?=
 =?utf-8?B?dHlDdHlhdzY0dDJPMFdJenYvZG1FdDRLSThYcmZ1c0NHNGNiYUtvQjdqTTVD?=
 =?utf-8?B?OFZWRnJ1RVg4VmZXdXVpb1BjVkc3dHhUQVBLdzg3eEZ1UUNMZmtDdXNtQTI5?=
 =?utf-8?B?ZGFsVWlhNnN0dE9EZklHaEJtc21reTRvMWtlRjByRzhkbG9sQ2MrRFBWZ0dy?=
 =?utf-8?B?dlQxSzIyWnhSV3FtamdiTUJ3V2tRdE1wQ2xhWUd0TUZFWlIxcS90dTNCWWRO?=
 =?utf-8?B?Y1pGNEpaaFhxNCt5dUZ5aGpvN01paWRTVlRhNlBhSS9IN0JoYnUxWWVzZTZQ?=
 =?utf-8?B?RlIvKzFHOWZ3bTBVYVc5UDdBekhsbG1BdjkwMXVXN3ZJNmZjRHdZazFjVWtO?=
 =?utf-8?B?cHVQMERJMTZFWmdjZXVYMU9JRU1Xd253SkpBZUZ6SGxlN2o4ZTREQis1bVUv?=
 =?utf-8?B?dVovZWI2aGdtaUI1RVg4b2IxYmZDaFUrNUNkMlBvSGc1WE9WZGNrd0duU1ZS?=
 =?utf-8?B?RDU0dk5XclBJcUNKUXplVlFYN3RISloyR1dLWjloRlJMSmdYMGZmc08rOU1M?=
 =?utf-8?B?OXVXc2xYRnRkTHR5dUUvY1d1alQ4Z3luQXdLMFJHL05MbkJUSm5tb3JxK0Ns?=
 =?utf-8?B?K21vblZWSHYxRVdsK2hWU3lGYk9QV3JMRjh5TUk4M3pNdWtBZjhSektYNmJ3?=
 =?utf-8?B?OS9LV3hWUFh0QUJpcVFCWnFkbk5xeFhEL21aZUtaSDhOclNMM1R3M0dYSmdi?=
 =?utf-8?B?WG92dkJLL0pJVG9ZVXNhYk5QdHJQa0lmVnMxUTlGWU9hYzNzeVVpdVlLcmVC?=
 =?utf-8?B?ZDJzVU9MR0xMVTdMSlRCN0FzajdGcDZKdW1FY0JoK2k3MEVzdGRST0MzZkVR?=
 =?utf-8?B?cDhpZHdxVEZ6SndrY1ZlZnRoeml2Y1BrY0NoWnoyU0hydlVtR3NrZ0FmejZI?=
 =?utf-8?B?VGpDSEh6WGQ0TFRiUk93dTVnQVpVbGh3SitoTlZBdkpTYnkvVEdwb1FYZGVw?=
 =?utf-8?B?ck1wbXhjRUw4VUxkdlVTZUVETUFPNWNpbTRmcWRnREtuRUJYcUp1R1dINVZ5?=
 =?utf-8?B?TXhjMlZKNkFnQXhGVStveFhvblQwQ0RXQ1dTdGdyT3Z0bWJwNWRVUzRZNENw?=
 =?utf-8?B?Q1FwdHpYS0xTZ2tETnVIQlZEUUMvOGFjeTU1aUx4ZEVXMWhjLzhFVTFqNGNK?=
 =?utf-8?B?em1VTmRIZ2QybjNtWFVHZ2F4T3pBYWR6R0p2aEo0SnhOZGExNm5rYVhaUEVi?=
 =?utf-8?B?MFhrUnVIdUlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUEzb1p4S1AxY1hPY1JyaTNkTUkxdWVPdGJOK1NLWCtOeG5aVHNuclZuZ09t?=
 =?utf-8?B?QWQ2QjYrbzlQYnY3UGJ5M3ZZUSs2bDlpMkpCcHVtY3dORGFwS3BpSVBhdG96?=
 =?utf-8?B?VS9hTlNsZ1BzNGkwVXlQVHNza21pNTlTWWU5NGMrMWh1Z1E2NHVxQXplWVVB?=
 =?utf-8?B?Y0p2bDR4Z2FObmRMUitOSm1EY0VFcXU3Ujh4dGNJaHNBNWN0TGQ0Rk0rQk5K?=
 =?utf-8?B?TWhWTnhXNEMxaW9PNFlYT1BlVkNxSW1FUG9WQVlFUTlLYXVuWEQxSGxFcldL?=
 =?utf-8?B?NVl1VFBubnIzU1FKMUpKdnVjNC9qeno3ZTJBdGEzcW5BaDhkellLNGswcXJv?=
 =?utf-8?B?c2xvcndaUjVuV01ERE0yTUg5djRVSEZQWU0walJmcUc0WU9nUFFDZEJWWWV3?=
 =?utf-8?B?dUtmYXErclFJOCtpOTVCbVdiT21KejBBSWJHeDRxVVVCbXlRUk9HelVzelNX?=
 =?utf-8?B?Q3RwUk45cm9hdEJzVndIaHViRVBVZWR3N3dmVEt4ZlVkWVdqN21yNFpnTElG?=
 =?utf-8?B?dU5tcFQwTWhBTHNrYWd5SExLTGFOb2N0cnFRSUJaeXlIWlZTaSs1RkJUaTVV?=
 =?utf-8?B?UENFREtLZmlpUjk0YTV6bWVQcUZXYlIybzVVeVBqUWlPL3VseHB2dWJ3a2lB?=
 =?utf-8?B?UkJjSUprSUtGSHVCcmpVOWtXZkd1MkN4T05jVXFsa3YzNzdqeWd5aEdFclJX?=
 =?utf-8?B?QmJnZHNuNFhxVnEvUURSaWF1SjA3cERXZ1YzeDFabFgrSnhwbTFlSDJjTWhK?=
 =?utf-8?B?cGNJUllYRExVaGNZRTd5K2szNjJUUkh6NDFkWU9USmdMNmVyYk1IbSsxK0tl?=
 =?utf-8?B?L1NzRS81NnpwL050TkZxRHJkeSs1TUJvSEZwQmdCWU1yY2ZTSFFGOUJGdWlL?=
 =?utf-8?B?UFZFWXVrekkxZ01jT3puclpVb2pYOTFmNXdsbjdSN29ielJDcUw4Y2FCdzg3?=
 =?utf-8?B?ZjFIcDNIZ05UTmdMUVE0V2Y1cDFxcVZYVk45MVpaQ25ubkJuczRGdkNSUTFq?=
 =?utf-8?B?SEkwSWlBbUIzdktyQ3BCT1pueGhzQkY5ekVPOVhLcnJUdjFuaGxidjFRYUsx?=
 =?utf-8?B?YlNDaHVlRGRNSTNhUmVnalJQZnprRXZEcUpCT0wwdUgzRW83ODUvcWYrN24r?=
 =?utf-8?B?b3pub3p6N2NpNW9WTmRPZmlSZit2bGVOYlI4dUZBMDhiNThVbmY5Q2phMlJz?=
 =?utf-8?B?V25iYXJ3T0t2QUZXWFZZSjlQTldPSjJUSUQxSUdOd1FaK3l3K0RZL1pZWEp4?=
 =?utf-8?B?bXB0T25GdTFUd3drK2ZJOGp0NlFFTjB0UUZzVWpwWjhVUEVEbkFPUmJVS3J5?=
 =?utf-8?B?cWsrNkw3NnVyMlVLUkQyQUVRMS95MGZuTjhnK3ZzRjZ0angzMDRvMXVrbXBn?=
 =?utf-8?B?cGZRMjQyZ2cySkFsRnY0VThaM3p6VFM0T0kyK2FzbzBQdUV5aGl2ZzlXTHZL?=
 =?utf-8?B?MFJyUWNNbVNaQjZhOGxiQ2wrWXJQMHMxK0loc2lqdjdwbU15Zlp0Ly92TnV5?=
 =?utf-8?B?Zm1NZVhIZnRDTTFkK29DQ1pFMjJUeEMrMEJHM01ocDNrZkUvVEFGZVZSK2tH?=
 =?utf-8?B?ZDRFZk80cGxVamN4TjRXeHN5NFBzbjFFVGNEdllPdkJ1bTBtTk9qRzVteDVi?=
 =?utf-8?B?dmQ1cG52SzZWODNzZVloeUZycWd3djVVRjl5NU1NMkNCVGgvOUlZeW9pdGNi?=
 =?utf-8?B?UEc2cmtsdnU3aXRrWVpaeUFGYXZ0N1hHblNMUWxqUW1iNkJQM1lnTGNVSXhy?=
 =?utf-8?B?QVNpTTFhVG1weUM1YW5mOFNmdnlXa2lCY3RiUWlveCtwYndIbklDQmZPZ3Ny?=
 =?utf-8?B?NVFyYmgzbFRWeWhIVnl1U21oVlZmd1NXN3cvUmtnMDRlcmZMWXhZK3piVS9H?=
 =?utf-8?B?UVhIdFlwc25xbFRFSEh0ZWhya1ovbkFQbFAwUEFlZnFBaldkTHRFTHVpa2d2?=
 =?utf-8?B?Y0wvRmt6ZjVrMzZqS1JxclNkcjhLV0M0aGYvNkF3SUo0UHVvTUovNHFSMXlW?=
 =?utf-8?B?L2lqa1EvaEx6Mm1vblFuQmR1OFBJRXRUTmg3VEt5TnZqUEhKdWNXRmxhOFg2?=
 =?utf-8?B?ejV4NCt3b0VMTE0rOGRGSmdMei9tZVk1VEZ2M01STzFXcDZHcTJZS09SSldz?=
 =?utf-8?Q?qGqz3Qd4Si0rCkfX1zQKnTqOZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad832fe-0d27-4bdc-0441-08ddae7a5c29
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 15:11:11.1074
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nurlYFULd/PR+QJ+QT0lJ50vmiiIVGIBbmy6bhF4dBEh8SvfJ80P/dr6r+2X7pwcqtAUgCNPP34rHo7G+23a8wnOimfuBtSsbhyvqMNoM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7672

SGkgUGF1bCwNCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhpcyBwYXRjaC4NCj4gDQo+IEFt
IDE4LjA2LjI1IHVtIDE2OjIwIHNjaHJpZWIgTmVlcmFqIFNhbmpheSBLYWxlOg0KPiA+IEFkZCBz
dXBwb3J0IGZvciA0MDAwMDAwIGFzIHNlY29uZGFyeSBiYXVkcmF0ZS4NCj4gDQo+IENvdWxkIHlv
dSBzcGVjaWZ5IGhvdyB5b3UgdGVzdGVkIHRoaXMsIHRoYXQgbWVhbnMsIGhvdyBkaWQgeW91IHNl
dCB0aGUNCj4gc3BlZWQsIGFuZCB0aGVuIGRvIHRoZSB0ZXN0LCB0aGF0IGl0IGFjdHVhbGx5IHdv
cmtzIGF0IHRoYXQgc3BlZWQuDQoNClRoZSBkcml2ZXIgc3RhcnRzIGF0IGZ3LWluaXQtYmF1ZHJh
dGUsIGFuZCBpZiB0aGlzICdtYXgtc3BlZWQnIGJhdWRyYXRlIGlzIGRpZmZlcmVudCwgaXQgc2Vu
ZHMgYSB2ZW5kb3IgY29tbWFuZCB0byB0aGUgRlcgdG8gc3dpdGNoIHRvIG1heC1zcGVlZC4NCkFm
dGVyIHRoaXMgcG9pbnQsIGJvdGggZHJpdmVyIGFuZCBjaGlwIGNvbW11bmljYXRlIG92ZXIgNDAw
MDAwMCBiYXVkcmF0ZS4NCg0KSSBoYXZlIHZlcmlmaWVkIHRoaXMgdXNpbmcgU2FsZWFlIExvZ2lj
IEFuYWx5emVyLCB3aGVyZSB3ZSBoYXZlIHRvIHNldCB0aGUgYmF1ZHJhdGUgdG8gZGVjb2RlIHRo
ZSBVQVJUIHBhY2tldHMgcHJvcGVybHkuIA0KDQpJIGNhbiBhZGQgdGhlc2UgZGV0YWlscyBpbiBW
MyBkcml2ZXIgcGF0Y2guDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmVlcmFqIFNhbmpheSBL
YWxlIDxuZWVyYWouc2FuamF5a2FsZUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IHYyOiBVc2UgdGhl
IGF2YWlsYWJsZSAnbWF4LXNwZWVkJyBkZXZpY2UgdHJlZSBwcm9wZXJ0eS4gKEtyenlzenRvZikN
Cj4gPiAtLS0NCj4gPiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9ibHVldG9vdGgvbnhw
LDg4dzg5ODctYnQueWFtbCAgfCA3ICsrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA3IGlu
c2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9uZXQvYmx1ZXRvb3RoL254cCw4OHc4OTg3LWJ0LnlhbWwNCj4gPiBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvYmx1ZXRvb3RoL254cCw4OHc4
OTg3LWJ0LnlhbWwNCj4gPiBpbmRleCAzYWI2MGM3MDI4NmYuLjRhMWI2ZWE0OGEyZiAxMDA2NDQN
Cj4gPiAtLS0NCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvYmx1
ZXRvb3RoL254cCw4OHc4OTg3LWJ0LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbmV0L2JsdWV0b290aC9ueHAsODh3ODk4Ny1idC55DQo+ID4gKysrIGFt
bA0KPiA+IEBAIC0zNCw2ICszNCwxMiBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgVGhpcyBw
cm9wZXJ0eSBkZXBlbmRzIG9uIHRoZSBtb2R1bGUgdmVuZG9yJ3MNCj4gPiAgICAgICAgIGNvbmZp
Z3VyYXRpb24uDQo+ID4NCj4gPiArICBtYXgtc3BlZWQ6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsg
ICAgICAtIDMwMDAwMDANCj4gPiArICAgICAgLSA0MDAwMDAwDQo+ID4gKyAgICBkZWZhdWx0OiAz
MDAwMDAwDQo+ID4gKw0KPiA+ICAgICBmaXJtd2FyZS1uYW1lOg0KPiA+ICAgICAgIG1heEl0ZW1z
OiAxDQo+ID4NCj4gPiBAQCAtNzgsNiArODQsNyBAQCBleGFtcGxlczoNCj4gPiAgICAgICAgICAg
Ymx1ZXRvb3RoIHsNCj4gPiAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibnhwLDg4dzg5ODct
YnQiOw0KPiA+ICAgICAgICAgICAgICAgZnctaW5pdC1iYXVkcmF0ZSA9IDwzMDAwMDAwPjsNCj4g
PiArICAgICAgICAgICAgbWF4LXNwZWVkID0gPDQwMDAwMDA+Ow0KPiA+ICAgICAgICAgICAgICAg
ZmlybXdhcmUtbmFtZSA9ICJ1YXJ0dWFydDg5ODdfYnRfdjAuYmluIjsNCj4gPiAgICAgICAgICAg
ICAgIGRldmljZS13YWtldXAtZ3Bpb3MgPSA8JmdwaW8gMTEgR1BJT19BQ1RJVkVfSElHSD47DQo+
ID4gICAgICAgICAgICAgICBueHAsd2FrZWluLXBpbiA9IC9iaXRzLyA4IDwxOD47DQoNClRoYW5r
cywNCk5lZXJhag0K
