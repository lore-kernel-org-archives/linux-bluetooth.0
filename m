Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEE1154C09;
	Tue, 22 Oct 2024 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729585307; cv=fail; b=ca4jEgtBcHZu3hW6zgdyw4cQArA0tb3f4YeLrIda+slVnB/er+rbPolmZEHOik+ZZlUgRxWIXW8Yno5tZRWV7QNM7d1nmyrTWR2E0Df/7ybv9FxtTZJskfkgwmskSUb4Tvutu3alnM+/9e9EdijscsNJoXlK2p/snb9mglABUUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729585307; c=relaxed/simple;
	bh=FtGshSZFCd34bYUaAN/iN+L3L3pqQvG6du8tliyiBPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JzJK1Yi/zaOJoOe3RydpuUCtF/rKwsyJJTX4smsTJS8HBmlenRqop3fzNzHrwq8k3B29Z15rvlx+yn0373zTKGztvw1nE+7wnRtDaALj5jAx5dZIkkv5sVRlrb1dBlmmHQFgku+8ZG3CagI8aDupt0eQoCwl8LS2TtL4jR9hPiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=HW3VYkFq; arc=fail smtp.client-ip=40.107.241.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="HW3VYkFq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6nAruZLBaUbjeQyVKy6KDdJG50ykSnlKY0JU4gi2XSKfbY6JgJ65ffeAjArXo4aXrVWD0fazGxNPdCEb6fzKWd0O6u78OPkn7Da62JT4yjyiiZOeDNHEwN8Z9xgNYNWbeV27MFAhgfT57BsDhkjwx8GD9OBwpQq4kkd7RwFM2kwHbrO0lj58UATXmzZx1gAU+Wtr0DTynkOS7beOuiSTMw3jaXHpvXY7BPe9ltyIcd8qlJrn5/YRvFlmgu1yQDTrJBC+0How/MARYO3Iy+fXlHOjcA1LAD0mwujtjqh4T/TOjgWkztlmqCJ7TRgF1d2WIxGI4vE6ZHiS2y58TsYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FtGshSZFCd34bYUaAN/iN+L3L3pqQvG6du8tliyiBPk=;
 b=p1kY6kWC3xlKOJjRdXL+ElMr6WJ3SaXISr7BnRo+AVV+bR9VQ0VR7gI7uq5VUw6L9iLFT3kRXehH0cXpcx5H7v/DdQV1pR/DeMMPCtcF616/NRvWgqiQNGSypvtMiePiKxs8Pdjfv2jpBUqjpDlWxup2nZ73WmCOFcu/kwgBLB/7YLFEikD2FPvEyMCCxk6yX5/4si98sZm0rmKiPFu6sx2ov7jaFHIUuPilU7TrP4jEM/KGS1aiBtuy/tUAjrulWnei5l803Zfa+NmCS0YTsIVsxvT7HYrss7EL46YeSesYALD6kmaoqn7OWPobc5/T7aZ/zZoM9i4HqMcEE47ylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FtGshSZFCd34bYUaAN/iN+L3L3pqQvG6du8tliyiBPk=;
 b=HW3VYkFq5idh6t696IQTgb7xO0YV/8vRVr5conPU+rcHBIMT9mZ1KqceQaTYfgT6V30LbrC5R/n38U/Mgdu15CPnz5AoKU9o73ibX8Nq3hGoRmOFABu/Dh7RsIBdUPGEFX114N2uMXYaaxE0vVMo57dqVygtblc6+6uxfqWL8SY=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by AM9PR06MB7268.eurprd06.prod.outlook.com (2603:10a6:20b:2d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 08:21:40 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 08:21:40 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Sherry Sun <sherry.sun@nxp.com>, Marco Felsch <m.felsch@pengutronix.de>
CC: Amitkumar Karwar <amitkumar.karwar@nxp.com>, Neeraj Sanjay Kale
	<neeraj.sanjaykale@nxp.com>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Topic: [PATCH 1/2] dt-bindings: net: bluetooth: nxp: add support for
 supply and reset
Thread-Index:
 AQHbFlGYxegmsfkbQ0S2PUUKI4YS47J5bJAAgAAtywCAAao9AIAAIGOAgBV25oCAABNWAIAAK2IAgAE7AYCAACRCgIAADPSAgAADYwA=
Date: Tue, 22 Oct 2024 08:21:40 +0000
Message-ID: <a2d9a0f2-afc1-42dc-81ab-6ad0f49f5601@leica-geosystems.com>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
 <DB9PR04MB8429B4535422D3AE07D8EE79927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <3fa35cd2-e52c-4873-8a7f-db459b016a97@kernel.org>
 <2b7f61a8-e91a-4b32-be1d-753a19e4d81f@leica-geosystems.com>
 <0d460226-4ea7-4a9b-a119-468343727996@kernel.org>
 <20241021064129.trchqa2oickna7pc@pengutronix.de>
 <bb34f4ae-92b3-48b7-b0d6-5937756cdbb9@kernel.org>
 <20241021102558.rfnz7nxcg5knibxs@pengutronix.de>
 <DB9PR04MB842939900805C080F2CC32B2924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <20241022072311.ubh2sia5lwgvebsg@pengutronix.de>
 <DB9PR04MB8429657FCB48ACAD74FDD471924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
In-Reply-To:
 <DB9PR04MB8429657FCB48ACAD74FDD471924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|AM9PR06MB7268:EE_
x-ms-office365-filtering-correlation-id: b3ef1fe7-4430-4768-3f29-08dcf2728e49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZTBlTGYvN2Y4UVF1b2h4THdYTHVlb2xza1hOQ0FjUktnaDNsbEppaFJVRTZo?=
 =?utf-8?B?c0NLekdnSlRjMGFERENqTU1ZTExIVzFZdWI1RUlRWU1WUnNLSXNMMktyTnNn?=
 =?utf-8?B?aDA4UzI2c0xCS3VzSnk3SUlVMmorZ04zNEhJbnVmYnhPQ0xKa0JwOVZtTEFJ?=
 =?utf-8?B?YnJiM1k0OEhvTWVqQzEvTXZkR3dHbjRyYmhKSVAxSGV0OHFzOEUvWlI0dFRP?=
 =?utf-8?B?V3ZwRks3WHZZMDVRRGtZUUEyclFjME5vVVdhRWkrZ3pwYVdPYnhrNDJQRTlO?=
 =?utf-8?B?Q3FjYUd6QXFyU1FDNVVnNCtTTGZtTzAwYW42Z3dsSlc1azZHLzBydGV4cVdR?=
 =?utf-8?B?Rkx2KzErVVM5S1lsZjJDZTBnUkljVmhRZVZOSCtvTjlRZm1vNEZaMS9jbm5C?=
 =?utf-8?B?ekIrWVF3NDVaNWZDTENGY1BUQS95UkVIOVR5dlFzVFVVS1ZKMkl5UGhyN3BJ?=
 =?utf-8?B?czIvY2o2WjIxWFh4RXMrcGJkc3NHZmVwWTdTbmFZeWhJMTMxZFR3bDV6L0JG?=
 =?utf-8?B?QUVNOGVva1BaMDE5bThrbVdpV2Zic3JFTXZwMWllOWNCUjVYZFkwbHRqV0J2?=
 =?utf-8?B?empGamsxdHg2VjVhM2grT2V6cHoyQTVtV1JRUW5mYjY3ZCtyZXVxSTNwbFRh?=
 =?utf-8?B?SFVsOTFCbFk0MWtwRlVjOVkyaFNvWTJ1UHlOc1BOZVJGVXpVUjRFU0VFTTRV?=
 =?utf-8?B?WnVYbWVTRGRxNkU2M3RKNDNhTTBaZWNWYzFrVnNNdThlY29GU1JqRVRxdktt?=
 =?utf-8?B?SHFDSjdVODBYajhYbjhsUTZsaU52ZlFRTXNrdC9wTCt0bSsrZFlYWFpKLzBL?=
 =?utf-8?B?SFoya2JMTU05dmdvUkhxOXkzMW9GWURWVE5SckZJdy9ObGNaTkFOVzIwTzFO?=
 =?utf-8?B?ZVBlN3ZNTS94cEpqNTdDR0U4TlhtUmZ6SmVmMWUwWlNWb2c4NXlRYUY2UjB4?=
 =?utf-8?B?dW5sSFc1WnRDdk5vaVRETVVKWUR2SXM2U3l0VEg5NVhOdThiZFRVS0h6cWhM?=
 =?utf-8?B?QUp0SmM1dGc0ODBwNU1pdkhmVk4xdE5jb0VlcW9rbVg0NjcweFE5Qjc1dE5J?=
 =?utf-8?B?MnZCK0RXY21vSjd4dXJ5anBzSkx3andyTHlBN0F2SjJOYjk5QjVHQ1NyV05m?=
 =?utf-8?B?czZ5Qno1UnI3WFFKZ2JsR281UGFZeVhqa3U3L1Z3TEN1N1MzQjIrdkRJSFFY?=
 =?utf-8?B?YVhtL1dJcGhPMjNITmdXRE1TU1BkRTFZQS9LdFJvMWJrZ0JaUUlCSEg4MXhj?=
 =?utf-8?B?UW5CZXBKakt1b2ErSTJlM0VydEEyMW1TYkhKemxSWWo4V2c5UlVoNVVIRkp1?=
 =?utf-8?B?dHIwTVRTVExNNmI0bWY1LzlMYnc1RkVabklRRFRyRVduOXVwa0Q5TUpYWnU4?=
 =?utf-8?B?N3d4UWdFRERJMGJLd0ZRSkVaaDFLa1I5bFUvbHQ2TDNiSWJkSm9ySmxXNFlL?=
 =?utf-8?B?V2VIVlJYdElScHJ5NUJvWG1aZmZwaDhCV3BwbHdqNkZkNE1OVWVXV0hvWjNu?=
 =?utf-8?B?M01OWnR0Y29hR1gwV2ZMOWxSUTVPUWwzU1ZzMFZjNTBNY21Pd2Q3UEp2aXhT?=
 =?utf-8?B?a2x2WTdTSFpDbFRLMEI5TUM5cDhWampFKzJHRmdsenBBUEkwVlR4a3N2ckJL?=
 =?utf-8?B?MEptcXNkMVhoQk5SVm01ZXdhQUx1VFZEdEtzUlFYdnJxMi9aa0xpSC9rbXVF?=
 =?utf-8?B?bG1FNW5sdWw5dzArSEtzVHliWGdpTnI4R28weTdZRnZTdXljVDBhSjBpekw0?=
 =?utf-8?B?bkFFSWwwd0hYRVBaUDBqaUQvRjBuekhmWW9TOWJGd2owckNtTGNnRGl2N1dL?=
 =?utf-8?Q?D+7fWggwcypcAxced2DEidrjrqke52FKWzgzs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0NFSU52cjA0dUs4Z3VRL21GdHhVMGUyOCtGWnQ4MHBzMDI0bXpIaTR0bWpO?=
 =?utf-8?B?VmRFeUZsQTNEcndEQllqdXJDL1BmM3lZK1kzVWdiaUd2SHMrdUkxVFJUcHFh?=
 =?utf-8?B?UFZhK1YrL2NhdE5JekRia3dna0xXQ0tmTEdLaytnbHdjcGRCNHRBYlNEVmZB?=
 =?utf-8?B?YTh4ZHBhbXZhOXdIblZtNVkvczZCeXVFZ0JYd1RYMk1aRFBBSXE3SWgvaTRm?=
 =?utf-8?B?R1lOSElabFVobjlUYVZsU0ZHSjRoWmQrK0lYV2FtZlZHNGY5cktSaUpQb20v?=
 =?utf-8?B?QkI2R04vV1FSNGZCanE2eG0zQU5BTHBNdFBydXpPZzNzeUdFRlJGWEh2TlNz?=
 =?utf-8?B?YUh5Wmc2eU5CRWVkUGZBakxjSGtIbzdqNmJOQlM3V1E4Y2xVaXN4SHlmSDZl?=
 =?utf-8?B?VTFiVkh6bS9oYWh3NGVJY0NwSlV2eG1XUGFreXJ6VE5WVWJMdmJtalI3WTlu?=
 =?utf-8?B?K0k4RDdERWgvOStPYnpSdnQ5Undya09oMFM1VVBRM3E1WXdzR3NjTFZDSldO?=
 =?utf-8?B?UkFuSVlaZllGeTY0OFlSdmVvVGpzbnA1L2VRc1FtekswOFpKSDVSSGlrWnhh?=
 =?utf-8?B?L1B6MWZ3UHlodUt3dGxFRGNHRzlxa1ZaNHZ2aWFDMEIvakRxTUlZREExd255?=
 =?utf-8?B?UHozOUFZVFVPbGpOK1EzWHdzbzllT3l2ZW45YXZ4TUV6MndjV1RMM29iM1Nn?=
 =?utf-8?B?dW5Zd014T2orclNUR21JMG82dW1pWHdUVE1EWHVWRE1QSDEvMlFLVmxpbUZK?=
 =?utf-8?B?dTV4TnV2WXRzamZMazJ3K2JsZitCNWxvV0x5am5WYVJjSk1xY1dvTVoxTmJa?=
 =?utf-8?B?cUtUNGFXUWtCQnFIQlJOTkM1cnJ5VktoS1VxY3IxTmlIM01BQkp0MlptdkdL?=
 =?utf-8?B?VlZoOHQ0d2tncURiZ0lNMGcyNUZWR0Y4QnpRZXg0UjBydDFlTURUZWIxMEh4?=
 =?utf-8?B?aTVpUEtHNmhJRGhhV3UzNkFrRnZGeTFGQVFHelhjNE03YlJPdzdTc1duV01L?=
 =?utf-8?B?Z3BpV2hGaXVQN3hVOXp0TXZEY0ZtN0FiMGZwR2JVYXpGclJiSWI5SmJJYzNG?=
 =?utf-8?B?dnZXSGRyc003clRtUEpGUU04aWVLMHpMaVByOHJ6Qk9IV2hNN21FV0YxQ0tL?=
 =?utf-8?B?SENUWWJTSWN6ZWlPTWtiSTYxUVE4RlowT2RIZG5QS21lMXJIR0tjSDNOemxN?=
 =?utf-8?B?Vm5oOVBrL1hwUU9vcTUvR3lTUUxnQTJqVzF5MEpUbVpzVzBvMXkvUzhvcmx4?=
 =?utf-8?B?Nk1UUGRHU2VVK1YreFlLVmE2T25uQ2xzM0R6bkErZmFGVlVLNjF6SVpRbXFL?=
 =?utf-8?B?cXRZOUhoaFo0SndHdDZ3Mi9NcTY3MGhXSk8wZElWTDd5V0dEN1N5azZNdTNP?=
 =?utf-8?B?OHlLaFo0eEkrN2UxSXkrUzBUeVFkbStzMGtaSDJCQ2RoMVR4MFA0SCtnNDlq?=
 =?utf-8?B?R1I0NFFNTjNRSCthMElZbmxVWURiVENNTTdvdHNlbktVMTdoTnZubW5nVTNa?=
 =?utf-8?B?TXpFOUNLWFhRUFN0L3hlbVFRMU9zTDZLZVpwc0o0Rm52anVPcmM1ZW1xRmoy?=
 =?utf-8?B?azEvYWtNdU9mT3ZNYjBPLzNRNWdGOUZHdm5ldVVIWVRlcVVBUW1lLzQ1dWg5?=
 =?utf-8?B?RjZTRWhYaFE5UXcvVm5zalhtZ01DclQ1cU5FenNESnBBSFZ6bExNQlVaMVlh?=
 =?utf-8?B?SHA2b1RGUS9BZWRCd1Z4Ulp1a0hpeE5hL05oMEhuOE8yZkk4czNrNFVTaTJM?=
 =?utf-8?B?OUg5NkprZXN1UjdWTU1EaU5yakZybXk0YXRZTWNjOTBMMEM4MWN0a05BSGZH?=
 =?utf-8?B?bEQrQXpLZGl2aUZEMHNaMHo0N2QxblNWK3RWd2lZWXRPNlk3L0VPQXRWRGZ1?=
 =?utf-8?B?bnpRSFlHa2E4cmgwQThvYjdaNTVpbUdOWFhCL0IvZUkwQ3RYZERxNkZERjdy?=
 =?utf-8?B?OVprVzRiTHU3WXNSSmEwNzEwVmhtZTllL1krSTR1NHMxR1BLK2p2YkQzbFh2?=
 =?utf-8?B?TTJKWUY3ZFVDYm1CazhIeU1JM3Q5ZHd0dFdONUt6MnVHTkJDZVY2OXFvK05H?=
 =?utf-8?B?aXBSY0FVS1ovY2lCUExvK2VPNDl4L0plTkJhc3BRTzNIMFJXTlRjT3dDbi9z?=
 =?utf-8?B?cGlFYnFqYzA0SEp1YW4ycGV2WGE3cVZQU3ROL1locm4vWS80UVhJVDBvRjB0?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B08C70B6209E514D8217700DE32C0E2A@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR06MB6901.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ef1fe7-4430-4768-3f29-08dcf2728e49
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 08:21:40.7088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KaF8+2K1XgX6+GA/VrGwsd/jx9xNQDplOHRqiJYzXGIsuhU31dXBmZLvUMSEXE7r76/nxGrOUFBrfkprUlGCWe/NVmnVE1Kp+bXcTtnFBUMS7uXMfnAyvsivh2FTbkjk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7268

T24gMjIvMTAvMjAyNCAxMDowOSwgU2hlcnJ5IFN1biB3cm90ZToNCj4gW+aUtuWIsOatpOmCruS7
tueahOafkOS6m+S6uumAmuW4uOS4jeS8muaUtuWIsOadpeiHqiBzaGVycnkuc3VuQG54cC5jb20g
55qE55S15a2Q6YKu5Lu244CC6K+36K6/6ZeuIGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5k
ZXJJZGVudGlmaWNhdGlvbu+8jOS7peS6huino+S4uuS7gOS5iOi/meS4gOeCueW+iOmHjeimgeOA
gl0NCj4NCj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGlu
c3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBh
dHRhY2htZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4NCj4NCj4NCj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBNYXJjbyBGZWxzY2ggPG0uZmVsc2NoQHBlbmd1
dHJvbml4LmRlPg0KPj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAyMiwgMjAyNCAzOjIzIFBNDQo+
PiBUbzogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPj4gQ2M6IFBPUEVTQ1UgQ2F0
YWxpbiA8Y2F0YWxpbi5wb3Blc2N1QGxlaWNhLWdlb3N5c3RlbXMuY29tPjsgQW1pdGt1bWFyDQo+
PiBLYXJ3YXIgPGFtaXRrdW1hci5rYXJ3YXJAbnhwLmNvbT47IE5lZXJhaiBTYW5qYXkgS2FsZQ0K
Pj4gPG5lZXJhai5zYW5qYXlrYWxlQG54cC5jb20+OyBtYXJjZWxAaG9sdG1hbm4ub3JnOw0KPj4g
bHVpei5kZW50ekBnbWFpbC5jb207IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3Jn
Ow0KPj4gY29ub3IrZHRAa2VybmVsLm9yZzsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsgbGludXgt
DQo+PiBibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBHRU8tQ0hIRVItYnNwLWRldmVs
b3BtZW50IDxic3AtDQo+PiBkZXZlbG9wbWVudC5nZW9AbGVpY2EtZ2Vvc3lzdGVtcy5jb20+OyBL
cnp5c3p0b2YgS296bG93c2tpDQo+PiA8a3J6a0BrZXJuZWwub3JnPg0KPj4gU3ViamVjdDogUmU6
IFtQQVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IGJsdWV0b290aDogbnhwOiBhZGQgc3VwcG9y
dCBmb3INCj4+IHN1cHBseSBhbmQgcmVzZXQNCj4+DQo+PiBPbiAyNC0xMC0yMiwgU2hlcnJ5IFN1
biB3cm90ZToNCj4+Pj4gT24gMjQtMTAtMjEsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+
Pj4+PiBPbiAyMS8xMC8yMDI0IDA4OjQxLCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+Pj4+Pj4gT24g
MjQtMTAtMDcsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4+Pj4+IE9uIDA3LzEwLzIw
MjQgMTQ6NTgsIFBPUEVTQ1UgQ2F0YWxpbiB3cm90ZToNCj4+Pj4+Pj4+Pj4+ICsgIHZjYy1zdXBw
bHk6DQo+Pj4+Pj4+Pj4+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4+Pj4+Pj4+Pj4gKyAgICAgIHBo
YW5kbGUgb2YgdGhlIHJlZ3VsYXRvciB0aGF0IHByb3ZpZGVzIHRoZSBzdXBwbHkgdm9sdGFnZS4N
Cj4+Pj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+Pj4+ICsgIHJlc2V0LWdwaW9zOg0KPj4+Pj4+Pj4+Pj4g
KyAgICBkZXNjcmlwdGlvbjoNCj4+Pj4+Pj4+Pj4+ICsgICAgICBDaGlwIHBvd2VyZG93bi9yZXNl
dCBzaWduYWwgKFBEbikuDQo+Pj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4+IEhpIENhdGFsaW4sDQo+
Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IEZvciBOWFAgV0lGSS9CVCBjaGlwLCBXSUZJIGFuZCBCVCBz
aGFyZSB0aGUgb25lIFBEbiBwaW4sDQo+Pj4+Pj4+Pj4+IHdoaWNoDQo+Pj4+IG1lYW5zIHRoYXQg
Ym90aCB3aWZpIGFuZCBCVCBjb250cm9sbGVyIHdpbGwgYmUgcG93ZXJlZCBvbiBhbmQgb2ZmIGF0
DQo+Pj4+IHRoZSBzYW1lIHRpbWUuDQo+Pj4+Pj4+Pj4+IFRha2luZyB0aGUgTS4yIE5YUCBXSUZJ
L0JUIG1vZHVsZSBhcyBhbiBleGFtcGxlLA0KPj4+PiBwaW41NihXX0RJU0FCTEUxKSBpcyBjb25u
ZWN0ZWQgdG8gdGhlIFdJRkkvQlQgY2hpcCBQRG4gcGluLCB3ZSBoYXMNCj4+Pj4gYWxyZWFkeSBj
b250cm9sbGVkIHRoaXMgcGluIGluIHRoZSBjb3JyZXNwb25kaW5nIFBDSWUvU0RJTyBjb250cm9s
bGVyIGR0cw0KPj4gbm9kZXMuDQo+Pj4+Pj4+Pj4+IEl0IGlzIG5vdCBjbGVhciB0byBtZSB3aGF0
IGV4YWN0bHkgcGlucyBmb3IgdmNjLXN1cHBseSBhbmQNCj4+Pj4+Pj4+Pj4gcmVzZXQtZ3Bpb3MN
Cj4+Pj4geW91IGRlc2NyaWJpbmcgaGVyZS4gQ2FuIHlvdSBoZWxwIHVuZGVyc3RhbmQgdGhlIGNv
cnJlc3BvbmRpbmcgcGlucw0KPj4+PiBvbiBNLjIgaW50ZXJmYWNlIGFzIGFuIGV4YW1wbGU/IFRo
YW5rcy4NCj4+Pj4+Pj4+IEhpIFNoZXJyeSwNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBSZWd1bGF0b3Jz
IGFuZCByZXNldCBjb250cm9scyBiZWluZyByZWZjb3VudGVkLCB3ZSBjYW4gdGhlbg0KPj4+Pj4+
Pj4gaW1wbGVtZW50IHBvd2VydXAgc2VxdWVuY2UgaW4gYm90aCBibHVldG9vdGgvd2xhbiBkcml2
ZXJzIGFuZA0KPj4+Pj4+Pj4gaGF2ZSB0aGUgZHJpdmVycyBvcGVyYXRlIGluZGVwZW5kZW50bHku
IFRoaXMgd2F5IGJsdWV0b290aA0KPj4+Pj4+Pj4gZHJpdmVyIHdvdWxkIGhhcyBubyBkZXBlbmRh
bmNlIG9uIHRoZSB3bGFuIGRyaXZlciBmb3IgOg0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IC0gaXRzIHBv
d2VyIHN1cHBseQ0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IC0gaXRzIHJlc2V0IHBpbiAoUERuKQ0KPj4+
Pj4+Pj4NCj4+Pj4+Pj4+IC0gaXRzIGZpcm13YXJlIChiZWluZyBkb3dubG9hZGVkIGFzIHBhcnQg
b2YgdGhlIGNvbWJvDQo+Pj4+Pj4+PiBmaXJtd2FyZSkNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBGb3Ig
dGhlIHdsYW4gZHJpdmVyIHdlIHVzZSBtbWMgcG93ZXIgc2VxdWVuY2UgdG8gZHJpdmUgdGhlDQo+
Pj4+Pj4+PiBjaGlwIHJlc2V0IHBpbiBhbmQgdGhlcmUncyBhbm90aGVyIHBhdGNoc2V0IHRoYXQg
YWRkcyBzdXBwb3J0DQo+Pj4+Pj4+PiBmb3IgcmVzZXQgY29udHJvbCBpbnRvIHRoZSBtbWMgcHdy
c2VxIHNpbXBsZSBkcml2ZXIuDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IFBsZWFzZSB3cmFwIHlvdXIg
cmVwbGllcy4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IEl0IHNlZW1zIHlvdSBuZWVkIHBvd2VyIHNl
cXVlbmNpbmcganVzdCBsaWtlIEJhcnRvc3ogZGlkIGZvcg0KPj4+PiBRdWFsY29tbSBXQ04uDQo+
Pj4+Pj4+PiBIaSBLcnp5c3p0b2YsDQo+Pj4+Pj4+Pg0KPj4+Pj4+Pj4gSSdtIG5vdCBmYW1pbGlh
ciB3aXRoIHBvd2VyIHNlcXVlbmNpbmcsIGJ1dCBsb29rcyBsaWtlIHdheQ0KPj4+Pj4+Pj4gbW9y
ZSBjb21wbGljYXRlZCB0aGFuIHJlc2V0IGNvbnRyb2xzLiBTbywgd2h5IHBvd2VyIHNlcXVlbmNp
bmcNCj4+Pj4+Pj4+IGlzIHJlY29tbWVuZGVkIGhlcmUgPyBJcyBpdCBiL2MgYSBzdXBwbHkgaXMg
aW52b2x2ZWQgPw0KPj4+Pj4+PiBCYXNlZCBvbiBlYXJsaWVyIG1lc3NhZ2U6DQo+Pj4+Pj4+DQo+
Pj4+Pj4+ICJGb3IgTlhQIFdJRkkvQlQgY2hpcCwgV0lGSSBhbmQgQlQgc2hhcmUgdGhlIG9uZSBQ
RG4gcGluLCB3aGljaA0KPj4+Pj4+PiBtZWFucyB0aGF0IGJvdGggd2lmaSBhbmQgQlQgY29udHJv
bGxlciB3aWxsIGJlIHBvd2VyZWQgb24gYW5kDQo+Pj4+Pj4+IG9mZiBhdCB0aGUgc2FtZSB0aW1l
LiINCj4+Pj4+Pj4NCj4+Pj4+Pj4gYnV0IG1heWJlIHRoYXQncyBub3QgbmVlZGVkLiBObyBjbHVl
LCBJIGRvbid0IGtub3cgdGhlIGhhcmR3YXJlLg0KPj4+Pj4+PiBCdXQgYmUgY2FyZWZ1bGx5IHdo
YXQgeW91IHdyaXRlIGluIHRoZSBiaW5kaW5ncywgYmVjYXVzZSB0aGVuDQo+Pj4+Pj4+IGl0IHdp
bGwgYmUNCj4+Pj4gQUJJLg0KPj4+Pj4+IFdlIG5vdGljZWQgdGhlIG5ldyBwb3dlci1zZXF1ZW5j
aW5nIGluZnJhc3RydWN0dXJlIHdoaWNoIGlzIHBhcnQNCj4+Pj4+PiBvZg0KPj4+Pj4+IDYuMTEg
dG9vIGJ1dCBJIGRvbid0IHRoaW5rIHRoYXQgdGhpcyBwYXRjaCBpcyB3cm9uZy4gVGhlIERUIEFC
SQ0KPj4+Pj4+IHdvbid0IGJyZWFrIGlmIHdlIHN3aXRjaCB0byB0aGUgcG93ZXItc2VxdWVuY2lu
ZyBsYXRlciBvbiBzaW5jZQ0KPj4+Pj4+IHRoZQ0KPj4+PiAicmVzZXQtZ3Bpb3MiDQo+Pj4+Pj4g
YXJlIG5vdCBtYXJrZWQgYXMgcmVxdWlyZWQuIFNvIGl0IGlzIHVwIHRvIHRoZSBkcml2ZXIgdG8g
aGFuZGxlDQo+Pj4+Pj4gaXQgZWl0aGVyIHZpYSBhIHNlcGFyYXRlIHBvd2VyLXNlcXVlbmNlIGRy
aXZlciBvciB2aWEgInBvd2VyLXN1cHBseSINCj4+Pj4+PiBhbmQgInJlc2V0LWdwaW9zIiBkaXJl
Y3RseS4NCj4+Pj4+IFRoYXQncyBub3QgdGhlIHBvaW50LiBXZSBleHBlY3QgY29ycmVjdCBoYXJk
d2FyZSBkZXNjcmlwdGlvbi4gSWYNCj4+Pj4+IHlvdSBzYXkgbm93IGl0IGhhcyAicmVzZXQtZ3Bp
b3MiIGJ1dCBsYXRlciBzYXkgImFjdHVhbGx5IG5vLA0KPj4+Pj4gYmVjYXVzZSBpdCBoYXMgUE1V
IiwgSSByZXNwb25kOiBuby4gRGVzY3JpYmUgdGhlIGhhcmR3YXJlLCBub3QgY3VycmVudA0KPj4g
TGludXguDQo+Pj4+IEkga25vdyB0aGF0IERUIGFic3RyYWN0cyB0aGUgSFcuIFRoYXQgc2FpZCBJ
IGRvbid0IHNlZSB0aGUgcHJvYmxlbQ0KPj4+PiB3aXRoIHRoaXMgcGF0Y2guIFRoZSBIVyBpcyBh
YnN0cmFjdGVkIGp1c3QgZmluZToNCj4+Pj4NCj4+Pj4gc2hhcmVkIFBEbiAgICAgICAgICAtPiBy
ZXNldC1ncGlvcw0KPj4+PiBzaGFyZWQgcG93ZXItc3VwcGx5IC0+IHZjYy1zdXBwbHkNCj4+PiBB
Y3R1YWxseSB3ZSBzaG91bGQgdXNlIHZjYy1zdXBwbHkgdG8gY29udHJvbCB0aGUgUERuIHBpbiwg
dGhpcyBpcyB0aGUNCj4+PiBwb3dlciBzdXBwbHkgZm9yIE5YUCB3aWZpL0JULg0KPj4gUGxlYXNl
IGRvbid0IHNpbmNlIHRoaXMgaXMgcmVndWxhciBwaW4gb24gdGhlIHdsYW4vYnQgZGV2aWNlIG5v
dCB0aGUgcmVndWxhdG9yLg0KPj4gUGVvcGxlIG9mdGVuIGRvIHRoYXQgZm9yIEdQSU9zIGlmIHRo
ZSBkcml2ZXIgaXMgbWlzc2luZyB0aGUgc3VwcG9ydCB0byBwdWxsIHRoZQ0KPj4gcmVzZXQvcGRu
L2VuYWJsZSBncGlvIGJ1dCB0aGUgZW5hYmxlLWdwaW8gb24gdGhlIHJlZ3VsYXRvciBpcyB0byBl
bmFibGUgdGhlDQo+PiByZWd1bGF0b3IgYW5kIF9ub3RfIHRoZSBidC93bGFuIGRldmljZS4NCj4+
DQo+PiBUaGVyZWZvcmUgdGhlIGltcGxlbWVudGF0aW9uIENhdGFsaW4gcHJvdmlkZWQgaXMgdGhl
IGNvcnJlY3Qgb25lLg0KPj4NCj4gRm9yIE5YUCB3aWZpL0JULCB0aGUgUERuIGlzIHRoZSBvbmx5
IHBvd2VyIGNvbnRyb2wgcGluLCBubyBzcGVjaWZpYyByZWd1bGF0b3IsIHBlciBteSB1bmRlcnN0
YW5kaW5nLA0KPiBpdCBpcyBhIGNvbW1vbiB3YXkgdG8gY29uZmlndXJlIHRoaXMgcGluIGFzIHRo
ZSB2Y2Mtc3VwcGx5IGZvciB0aGUgd2lmaSBpbnRlcmZhY2UoU0RJTyBvciBQQ0llKS4NCj4NCj4g
cmVnX3VzZGhjM192bW1jOiByZWd1bGF0b3ItdXNkaGMzIHsNCj4gICAgICAgICAgIGNvbXBhdGli
bGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4gICAgICAgICAgIHJlZ3VsYXRvci1uYW1lID0gIldM
QU5fRU4iOw0KPiAgICAgICAgICAgcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MzMwMDAwMD47
DQo+ICAgICAgICAgICByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4gICAg
ICAgICAgIGdwaW8gPSA8JnBjYWw2NTI0IDIwIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiAgICAgICAg
ICAgZW5hYmxlLWFjdGl2ZS1oaWdoOw0KPiB9Ow0KPg0KPiAmdXNkaGMzIHsNCj4gLi4uDQo+ICAg
ICAgICB2bW1jLXN1cHBseSA9IDwmcmVnX3VzZGhjM192bW1jPjsNCj4gLi4uDQo+IH0NCj4NCj4g
QmVzdCBSZWdhcmRzDQo+IFNoZXJyeQ0KDQpIaSBTaGVycnksDQoNCkknbSBzb3JyeSBidXTCoCBJ
IGhhdmUgdG8gZGlzYWdyZWUuIEkgY2hlY2tlZCBhZ2FpbiBibG9jayBkaWFncmFtcyBmb3IgDQpJ
VzYxMSwgSVc2MTIsIElXNDE2IHdoaWNoIGFyZSBhdmFpbGFibGUgb24gTlhQIHdlYnNpdGUgYW5k
IHRoZXkgY2xlYXJseSANCmRpZmZlcmVudGlhdGUgYmV0d2VlbiBwb3dlciBzdXBwbHkocykgYW5k
IHBvd2VyLWRvd24uIFBvd2VyLWRvd24gaXMgDQphY3R1YWxseSBhIHJlc2V0IGFuZCBzaG91bGQg
YmUgdHJlYXRlZCBhcyBzdWNoIGluIHRoZSBEVCwgbm90IGFzIGEgDQpzdXBwbHkgcmVndWxhdG9y
Lg0KDQpCUiwNCg0KQ2F0YWxpbg0KDQo=
