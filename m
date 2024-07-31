Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D571BC3F
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406616; cv=fail; b=ZCDAoR9CLPC364r7gaHF75szUYGRpjsZHI6Whd0SHX8+uNjewWps2PNA2aDo4HnSu3dcHBuBkQJodDkfv2xArf25NYOF6yequzWencmexJJpUC/kPjhC1ZAQAwokPSp73nQyw43Ph7Er45FO7omKRwqFoLR9qKwM6RbM0ylJcZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406616; c=relaxed/simple;
	bh=IL6uwnHBpDKFeCcE8fzJjOtx8ZaBilWWAoBTx8w2VhA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m3dMCf2btBSiXRHJF4lsGLWCS8nPTR5o528uGqL2AGmiH7NM1OG3yp9vSOpxtkmdHj6WEy/Duz9beMid6Ek2i9xfRo+JBlkF+nFx8b9ziyClccj44Kci12jTawDTxyfX6l6PRCcD58jmudz+099UK7PUmwIjwhpeJZsLZWyX/J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wlw0x9ZH; arc=fail smtp.client-ip=52.101.69.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wlw0x9ZH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AzJX0Se4N4KxQjpcjSvUVfLhuqcoTuIWMKX+EdHToRDBV+xv2kjXpgHXhbUyXU84zwUkICmKxoTiO2e2OJuRdJWXXjGyvOAJ76YbizhzNEdp8IzCZGZ2dLG+Dl/UdT1Z2P1bo+uOdMqULtuPjAmwDBQbu7sTWG8r+FbpKz3DHWvh3pEuV3ABsrmZfkgEWus2FQjinazy6yh2HUPvkcpRi4Pbw/XC59ivAmBWWbtLgjNy4S2xFI472R5iE4rTkECA5+jrC3N+imvuJIY86paAYvx9x/okIGNcL70Yut/i2cP8FncRG3HJ9B234wLhV/i5p3M3zQvR5qQ1T/FjAtQEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IL6uwnHBpDKFeCcE8fzJjOtx8ZaBilWWAoBTx8w2VhA=;
 b=ItJ5CgTDnf+amvLvKJC0zFDIYeiXE5VIpQBO/QLdvrirWNnaCa1rRLSayXnxk0OGg6D+RhnHw2Rsyx1RCgevDtCzAC3gkIoEtWoFEkueAvdJ8JHGZMLr2zlBYKXlJG1+BUy7cXR/ks1yWzNhtP/JQUTb0iFtD+TO+e4QEfSP33mCkbfWDEoT3cXF8JPbVfB+XZyjgv8v4dVfmqb2UUGeLJAux+Gfrn8i81ttXGmqtWLB6kBGiXQjcIPgzBp7eBQ4tGKmg6tXbM6QmaFNdgzgkzK4mEiaJJYoGif3PpFhjGB83tpqEEGDGyPLbvr1uQqXCt/Xoh2dkWwqd9vRpGYp+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IL6uwnHBpDKFeCcE8fzJjOtx8ZaBilWWAoBTx8w2VhA=;
 b=Wlw0x9ZH97v8IoS9URShtZuqO+QGUlQrEJXKHJ/oa/7JvYE1KkdGpCrjk6MR90PPoMivF1C+RCibQUw5Ol/hS6D1nNq3Hnx4iml/MkUrGtpiNcl4By4HdFSZFeeOu3F1zA4xMbXnNyXdDvy/4s6pxmAmpabaYSemwY42TCG8SBig6UjC32JWuzR2VdPZBDPSl8RJcVKODBmu7oiYZ66niEv6rZTisT7NkeHD4XIAqcCnSkVlUX4rrJG0SkOPU/SXKCWfONdeaqzsSAYBwGk2uEuSca2L7r6EQUjccTW0eYowuufVX0AEoqNiVuleDO+uMbfVKA5vkj1A9xblzTSRqA==
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 06:16:50 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:16:50 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: Pauli Virtanen <pav@iki.fi>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
CC: Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>, Iulia Tanasescu
	<iulia.tanasescu@nxp.com>, Andrei Istodorescu <andrei.istodorescu@nxp.com>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [PATCH BlueZ v4 1/8] doc/media: Add 'broadcasting' state and
 'select' method
Thread-Topic: [PATCH BlueZ v4 1/8] doc/media: Add 'broadcasting' state and
 'select' method
Thread-Index: AQHa4xE75IkWCPwzxUyat5G3+FngYA==
Date: Wed, 31 Jul 2024 06:16:50 +0000
Message-ID:
 <GV1PR04MB90882529C16C4FFC52FAC2F6FEB12@GV1PR04MB9088.eurprd04.prod.outlook.com>
References: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
	 <20240730140947.411655-2-vlad.pruteanu@nxp.com>
 <efffe9727c4f26064d9db2d73f0a9404ea045064.camel@iki.fi>
In-Reply-To: <efffe9727c4f26064d9db2d73f0a9404ea045064.camel@iki.fi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR04MB9088:EE_|DB8PR04MB6924:EE_
x-ms-office365-filtering-correlation-id: cf6b5556-b64e-4cee-7f17-08dcb1285daf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aENOK3RIUlNKS1dINHhqUjVlSGE4TVUvSjJTYnNlRHI2UDlOY2pESlNNM0FQ?=
 =?utf-8?B?K3pMQTFtK0pUbGJrblZxeDh1Y2svbEY2RGtHa2pRa2pxaUhFdzRaTTNaWENG?=
 =?utf-8?B?eWJBR3RlQVEzNlB3ZXMxdU44TVh6S2tFVjZUWmJlWFBRZk1wcFJHa1dSTmtC?=
 =?utf-8?B?MWkwazM4T1orZ1htU3ptbHdvWkZrYTBmMHliMlVOaTlmNHZ5bGJ3bzRQdUFk?=
 =?utf-8?B?WkhKaWVTMXZGYW95STNTVkxPSUlTY1JZQXAvaU1BYU9OR3NFSUFZNWxVdDRF?=
 =?utf-8?B?VmRVRHRKRmFwdFRBTTZDc1hTeENuTHRaYWliT05sV3dJc0wydDdQUVkvZE53?=
 =?utf-8?B?eFAxcGRqRDZZcFAxbFJPZEgxYVZPMkdzT0R4TEQrV0hhZjlyYzFITWsvSURl?=
 =?utf-8?B?WGhwY25hTk1GRUw0c0hxTmFKckcxOEhSRDJPMFFyUm9mQ2dCQkJ4cmRPVFJ2?=
 =?utf-8?B?VTBwVHNiSW85bDZQQ1J3UTlPSGNrTCtrMTZMTWI5WjlXTE1SbFFmbXdIOFdQ?=
 =?utf-8?B?M1dCSW1kWWQ5V2VxeGNmblRJd0kxeHQ0R2F6VjFOQ1kyOFdvLzFQcU9jcUVj?=
 =?utf-8?B?VkRJOC8rdkVHTHgvSmZvd2loMms0SlVvOCthNTErSVV0aDkyRUwrTTRYUVBW?=
 =?utf-8?B?Um9qMkpIQk9kZndTMXFwdStaQXVWWDREc1JNQWhrT0hjWXArNjNnTmkrSzZY?=
 =?utf-8?B?MXQ5V0pFWjlKVUFFWnVhUGtwZ3crTG5JZG4vK2VDcWlFZENaUW5UN0F5VjJ2?=
 =?utf-8?B?dFVFTTFVUTFkY01Eb3NvWGdXWHErOTVrVk83Z25wMlFQdmVYR0ZOQS9qaGZ3?=
 =?utf-8?B?K0J6NmxaazZ5S3pSc0E5Z2hER2E1L01DenRBbGJ5Vi9wM2c0eU0ydGhKSDZN?=
 =?utf-8?B?R1JiYnFtL0NTdFU1MExpcG90S3M0TERpdVpXSFhiZjZ5cTNOWG1mMlNRL1VF?=
 =?utf-8?B?WkNDZWc2UkN2ZnBiVWIrN0RPTlVkQkM4cUowU04yNVFCQnNMN2ZoQ2JPYzd4?=
 =?utf-8?B?YWpLakdrUktWdUhCaVZUR0xBa2dobDdrLy82bW12YUZmemxZblZONCsvN2ty?=
 =?utf-8?B?ZzNKVU9oZjJ4SGxIOGtKempyS2ppSXBVdmNZWWVJcm1LMHRUZ1Q2aG5ueHdI?=
 =?utf-8?B?UkJyVjJ6TytVQTB2REUyN2x0Y2RkNWJWSXd6VmxOWHB2Ym02MndKOGdNUnE5?=
 =?utf-8?B?anpnaW02VHJNTGFueFU1T1JJbXRhSi9xY015OUFwaHpyYnlKZ0NxNHBHTnBl?=
 =?utf-8?B?dVR5ZXJOUHZWZllpT0pocEVLYUE1SWlaZDVFRTkwdlpQeDcvRjIzSzluWmtX?=
 =?utf-8?B?Z1RJVGFsalFrMjVLdElPNXFPbndGTVdDWjJHQU9qU3lyTGxONUo4M0NWelZP?=
 =?utf-8?B?SFNVL3FhaS9helRqUXAyN2p5eWwraXhJQ0taWUtWMWFzQmFXYVIvL3NQb3Ba?=
 =?utf-8?B?dkpuOGRScXI2NUVieFNZWWJidnRnampIRXNjN1JTYndEZ3U1RDNlemZDa1NN?=
 =?utf-8?B?Mm85SFNhRExQbUthb2ptV1BZN2tRSi92bU8zaDA3dDZnbzRhOHZLL0RjTGdy?=
 =?utf-8?B?Qmt3TWNkTldSTGdMNE1jRzZmSjlCeCtMNUpjMDliVTB3b0ducDhqeFdiYjRC?=
 =?utf-8?B?REY4MWErTjZCZzlwR01yOTJVeWNKUmlORXFyeXFxR2FwNjRaNXVXQ3JreVNW?=
 =?utf-8?B?c0dtaUo5Ui9oL29UaDJFN1c0NCtLK1hKRGRKMmxwVnl3RFMvRVIyMndJWVYv?=
 =?utf-8?B?U2FNb2hkNFBWYWltZU92SnVVeXhxZG5kQ2srb1FiZ3Jlb2ZRYmFkQVlqSHZi?=
 =?utf-8?B?S1hld0orMVpSYlhKVWhSdkhJUTBOSHg5UENydHRqSmhJRWZJMTB3WlA2MmdV?=
 =?utf-8?B?WmkwQVVvUFBrTG9nTlExV0hGQkZtNVVQWDBPU1hSSVpEMlE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1BoeXlRWDI1a1B6K09KQy84blRiNHZwQWdJSWZGejZ4djAyOTVnOEw3ek81?=
 =?utf-8?B?ZU53ZldYclFua0RsM29xQnpXK1R6L0Y2RXhUODV3RGh3eUVHcm1yenZlcFFE?=
 =?utf-8?B?NVdMUm5SejNLMW9iMzNySmdHUE1pbENQckhRQy9jWHdaVFFJcmlNN0h3YkQw?=
 =?utf-8?B?aUtjK2ZyQ29KYW4vdm1OSFNqT0tETGxBeEU4dHNrZWJQL0QzRmt1dDB5TEc5?=
 =?utf-8?B?elNIR0c5elJOWDhhQ1hWdnNYVDZaanJMU1paeXkwdUxIaEV4ME9kOHhJb1FW?=
 =?utf-8?B?MUVYL1RsQi92TjFmUE1xNDhIeTlPRW5RVFdzNUtiY1paZDBWb2NCN2cxSy8y?=
 =?utf-8?B?S3UxdEZzbHJNdWRkbWw3M0h2WVVhdXFpaTVZd09zRzN6Z3ZNb2RDdlgyZWpy?=
 =?utf-8?B?VHFiTUI0bWJBV2l2MFRhY1RTMUtwWHZwZjN5L3FTYjVhZnV1VkZKY2pHUmpY?=
 =?utf-8?B?NkZXZnV5WFdxY0I3dUpLa2JjSDZxUHpaM0c3SEp5UmYwdjY0QmVZYkJXRGJC?=
 =?utf-8?B?TlhIdUo0aG9ORzBMRSttaFBTMTNYTk5kZmpQcFc4WG1Qakh1cDk5cWR5T09D?=
 =?utf-8?B?clpubXYwRzhtSkZBbW1yejFrYlNSc2FmZjlNbTVGTDh3TEZnbUl6Tnk5OXdw?=
 =?utf-8?B?MzlPaXkxaytmRCtuTjNEelRhMXpPNDJKM0lUSjNud1F1aGNaM3JDMEFUZHcy?=
 =?utf-8?B?VEc0cE5KWTgxSUZYRFhrMU9JWklaYVJTUU9FOE9UZk1HeFVDZ0g3L3ZKMTJD?=
 =?utf-8?B?eWZ0cXAxQWNmVTB0NlkxblVpeUZRYlNIWThvc1d5RGVQUXJRL1k2TXZTSUl0?=
 =?utf-8?B?b0lMbmZKak1WWS9QMDdCY1NUOVlTbW9LZ1k0SVR4dlVDblcyU0pjeUtXMktJ?=
 =?utf-8?B?dzVrSEkyT3VTNFRsNDl6MFl6eUpwcnlVL2FiTFJjWFJrb3ovWDB4cDcyYklh?=
 =?utf-8?B?NHBVbFJGV3VUSVc1ZlU2RFdSb3J2Q2JSQXB4UkczNllDRHd4MTdBRXBBN3Z4?=
 =?utf-8?B?Q3VoMnpFK214YjUwVHRCLzNXR0ZHOFkxUHdSVkxNSVg2YnV5RjhZVlFqZ3Nu?=
 =?utf-8?B?ekZLbFlKR1o1bWNUQkIzY0wxTWxVdEF6bjY3VUV6a240UjFSdDlJcVRwM1hU?=
 =?utf-8?B?L2dkTjhpcDA1eUZYM2RJNW0rdzA0Vm04bVZ1SFFDTVZ4VWp0RThXWDRVMkU0?=
 =?utf-8?B?VDJnL0s2ancyd0x0MndDc29Yb0JwU3ZBN1Y3bU1PdjdtdWFIa1N2NjcxRmFQ?=
 =?utf-8?B?VGszQml4TGNLRldyUHJMSUhMbk1qR0d1d2VRekhDcEgxa2M5REcxU01UcDVO?=
 =?utf-8?B?c0cwUG03NjErVmk5cW52UWJNZG5UQ3c3V3U2ZXRLb1U1OUxKcHdrcmdwbUxh?=
 =?utf-8?B?eUpsenJhYy81RFZJaTQySW5DSG1xSnRBT1JTL3p5dFN0R2FsbFN6dUk3aThJ?=
 =?utf-8?B?dTU2cm1sZjFpU2t0VndEMEdiT3VrelAvOFNXUkF6cXlPN0JuRW93aGo5T1dm?=
 =?utf-8?B?NE15bUlQUTRBMlkxdWtCM0R5T2hoa1NrS29ZbERKbHE4YTBOTmxXOTJpejBZ?=
 =?utf-8?B?MGJpa2FHeXRORlBSaGVjL2xwcUxjYUs2RS9mdTVoSG9xSDhwMWFBRUpLcmdD?=
 =?utf-8?B?MGpHMTYzamFDZTVXZVJ2TzQ3U0JUaG1rNGVsU1dGRnlYaitaN25CK2JhNGVG?=
 =?utf-8?B?QWZxcFBXVU9Dd2xMWFMwbGI5UDZHUXRmdmxNY3JYZFlrZVJLVXhNM2gwVlFy?=
 =?utf-8?B?ODNIL3VZOCtnTGNZQ1c2Zm9oeHBUdkY5L0xoa2tqVit6QXVFa2UzMytOdmh3?=
 =?utf-8?B?WGtuZ2xoNGpXcGYrTEJ4NUp0K25FZXpvVWFueUxpaVNvY2x4QmZwTm1yRlcz?=
 =?utf-8?B?Yyt2T3JORDl3aGNQdi9GOUxRK1JKTHl2ZDR2eThLclI4aHBOdnJaTmtlZFp5?=
 =?utf-8?B?NTUwbDVUVmVoQTNrMUVIbkIybnNGMnRzM1k3eVRjS3lNRE1sUFRiYVBGeGZo?=
 =?utf-8?B?MjliOFF0SnhTV0NGendJOFRmZlg5NW13L3p3ZjN4QjFMN3FWSCtVWE9TbG1h?=
 =?utf-8?B?SG40VVdYWEdZbEoreDFDQll1MWVvbk5DbzFWb2JNTlhWeDJXNUZ5a25Lb0NU?=
 =?utf-8?Q?vRo/K++Mx+Fv25IgIGzmDPq7F?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6b5556-b64e-4cee-7f17-08dcb1285daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2024 06:16:50.8063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVLY+fw90IUOxnEWdHdpXyPVciTPx0DsK2yoQT7OJUOtetxU+DP1F0f+OiZq5eMW2Wj8XjJBQH3FffgI4aWCTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924

SGVsbG8sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGF1bGkgVmly
dGFuZW4gPHBhdkBpa2kuZmk+DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMzAsIDIwMjQgOTo0NSBQ
TQ0KPiBUbzogVmxhZCBQcnV0ZWFudSA8dmxhZC5wcnV0ZWFudUBueHAuY29tPjsgbGludXgtYmx1
ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KPiBDYzogTWloYWktT2N0YXZpYW4gVXJ6aWNhIDxtaWhh
aS1vY3Rhdmlhbi51cnppY2FAbnhwLmNvbT47IEl1bGlhIFRhbmFzZXNjdQ0KPiA8aXVsaWEudGFu
YXNlc2N1QG54cC5jb20+OyBBbmRyZWkgSXN0b2RvcmVzY3UgPGFuZHJlaS5pc3RvZG9yZXNjdUBu
eHAuY29tPjsNCj4gbHVpei5kZW50ekBnbWFpbC5jb20NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQ
QVRDSCBCbHVlWiB2NCAxLzhdIGRvYy9tZWRpYTogQWRkICdicm9hZGNhc3RpbmcnIHN0YXRlIGFu
ZA0KPiAnc2VsZWN0JyBtZXRob2QNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwg
ZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nDQo+
IGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhl
ICdSZXBvcnQgdGhpcyBlbWFpbCcNCj4gYnV0dG9uDQo+IA0KPiANCj4gSGksDQo+IA0KPiB0aSwg
MjAyNC0wNy0zMCBrZWxsbyAxNzowOSArMDMwMCwgVmxhZCBQcnV0ZWFudSBraXJqb2l0dGk6DQo+
ID4gVGhpcyBhZGRzIGEgbmV3IHN0YXRlIGZvciB0cmFuc3BvcnRzIGNyZWF0ZWQgYnkgdGhlIEJy
b2FkY2FzdA0KPiA+IFNpbmsuIFN1Y2ggdHJhbnNwb3J0cyB3aWxsIHJlbWFpbiAgaW4gdGhlICdp
ZGxlJyBzdGF0ZSB1bnRpbCB0aGUNCj4gPiB1c2VyIGNhbGxzICdzZWxlY3QnIG9uIHRoZW0sIGF0
IHdoaWNoIHBvaW50IHRoZXkgd2lsbCBiZSBtb3ZlZCB0bw0KPiA+ICdicm9hZGNhc3RpbmcnLiBU
aGlzIGFsbG93cyB0aGUgdXNlciB0byBzZWxlY3QgdGhlIGRlc2lyZWQgQklTIGFzDQo+ID4gdGhl
IGF1ZGlvIHNlcnZlciBhdXRvbWF0aWNhbGx5IGFjcXVpcmVzIHRyYW5zcG9ydHMgdGhhdCBhcmUg
aW4gdGhpcw0KPiA+IHN0YXRlLg0KPiA+IC0tLQ0KPiA+ICBkb2Mvb3JnLmJsdWV6Lk1lZGlhVHJh
bnNwb3J0LnJzdCB8IDE4ICsrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MTcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2Rv
Yy9vcmcuYmx1ZXouTWVkaWFUcmFuc3BvcnQucnN0DQo+IGIvZG9jL29yZy5ibHVlei5NZWRpYVRy
YW5zcG9ydC5yc3QNCj4gPiBpbmRleCA2ZTk1ZGY4ZjIuLmMyM2QxZjU5ZiAxMDA2NDQNCj4gPiAt
LS0gYS9kb2Mvb3JnLmJsdWV6Lk1lZGlhVHJhbnNwb3J0LnJzdA0KPiA+ICsrKyBiL2RvYy9vcmcu
Ymx1ZXouTWVkaWFUcmFuc3BvcnQucnN0DQo+ID4gQEAgLTcsNyArNyw3IEBAIEJsdWVaIEQtQnVz
IE1lZGlhVHJhbnNwb3J0IEFQSSBkb2N1bWVudGF0aW9uDQo+ID4gIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4NCj4gPiAgOlZlcnNpb246IEJsdWVaDQo+
ID4gLTpEYXRlOiBTZXB0ZW1iZXIgMjAyMw0KPiA+ICs6RGF0ZTogSnVseSAyMDI0DQo+ID4gIDpN
YW51YWwgc2VjdGlvbjogNQ0KPiA+ICA6TWFudWFsIGdyb3VwOiBMaW51eCBTeXN0ZW0gQWRtaW5p
c3RyYXRpb24NCj4gPg0KPiA+IEBAIC01MSw2ICs1MSwyMCBAQCB2b2lkIFJlbGVhc2UoKQ0KPiA+
DQo+ID4gICAgICAgUmVsZWFzZXMgZmlsZSBkZXNjcmlwdG9yLg0KPiA+DQo+ID4gK3ZvaWQgU2Vs
ZWN0X3RyYW5zcG9ydCgpDQo+IA0KPiBJbiB0aGUgY29kZSBJIHNlZSB0aGUgREJ1cyBtZXRob2Qg
bmFtZXMgYWN0dWFsbHkgYXJlOg0KPiANCj4gU2VsZWN0KCkNCj4gVW5zZWxlY3QoKQ0KVGhhbmsg
eW91IGZvciBwb2ludGluZyB0aGlzIG91dCwgaXQgYXBwZWFycyB0aGF0IEkgbWlzdGFrZW5seSB1
c2VkIHRoZSBuYW1lcw0Kb2YgdGhlIGFjdHVhbCBmdW5jdGlvbnMgZnJvbSB0cmFuc3BvcnQuYw0K
DQo+IA0KPiBUaGUgREJ1cyBuYW1lcyBhcmUgYWxzbyBjb252ZW50aW9uYWxseSBpbiBDYW1lbENh
c2UoKS4NCj4gDQo+ID4gK2BgYGBgYGBgYGBgYGBgYGBgYGBgYGBgDQo+ID4gKw0KPiA+ICsgICAg
IEFwcGxpY2FibGUgb25seSBmb3IgdHJhbnNwb3J0cyBjcmVhdGVkIGJ5IGEgYnJvYWRjYXN0IHNp
bmsuIFRoaXMgbW92ZXMNCj4gPiArICAgICB0aGUgdHJhbnNwb3J0IGZyb20gJ2lkbGUnIHRvICdi
cm9hZGNhc3RpbmcnLiBUaGlzIGFsbG93cyB0aGUgdXNlciB0bw0KPiA+ICsgICAgIHNlbGVjdCB3
aGljaCBCSVNlcyBoZSB3aXNoZXMgdG8gc3luYyB0byB2aWEgYSAyIHN0ZXAgcHJvY2VzczoNCj4g
PiArICAgICAxKSB0aGUgdXNlciBjYWxscyB0aGlzIG1ldGhvZCwgY2hhbmdpbmcgdGhlIHRyYW5z
cG9ydCdzIHN0YXRlIHRvIGlkbGUNCj4gPiArICAgICAyKSB0aGUgYXVkaW8gc2VydmVyIGRldGVj
dHMgdGhhdCB0aGUgdHJhbnNwb3J0IGlzIGluIHRoZSAnYnJvYWRjYXN0aW5nJw0KPiA+ICsgICAg
IHN0YXRlIGFuZCBhdXRvbWF0aWNhbGx5IGFjcXVpcmVzIGl0DQo+ID4gKw0KPiA+ICsgICAgIFBv
c3NpYmxlIEVycm9yczoNCj4gPiArDQo+ID4gKyAgICAgOm9yZy5ibHVlei5FcnJvci5Ob3RBdXRo
b3JpemVkOg0KPiA+ICsNCj4gPiAgUHJvcGVydGllcw0KPiA+ICAtLS0tLS0tLS0tDQo+ID4NCj4g
PiBAQCAtODQsNiArOTgsOCBAQCBzdHJpbmcgU3RhdGUgW3JlYWRvbmx5XQ0KPiA+DQo+ID4gICAg
ICAgOiJpZGxlIjogbm90IHN0cmVhbWluZw0KPiA+ICAgICAgIDoicGVuZGluZyI6IHN0cmVhbWlu
ZyBidXQgbm90IGFjcXVpcmVkDQo+ID4gKyAgICAgOiJicm9hZGNhc3RpbmciOiBzdHJlYW1pbmcg
YnV0IG5vdCBhY3F1aXJlZCwgYXBwbGljYWJsZSBvbmx5IGZvciB0cmFuc3BvcnRzDQo+ID4gKyAg
ICAgICAgICAgICBjcmVhdGVkIGJ5IGEgYnJvYWRjYXN0IHNpbmsNCj4gPiAgICAgICA6ImFjdGl2
ZSI6IHN0cmVhbWluZyBhbmQgYWNxdWlyZWQNCj4gPg0KPiA+ICB1aW50MTYgRGVsYXkgW3JlYWR3
cml0ZSwgb3B0aW9uYWxdDQo+IA0KPiAtLQ0KPiBQYXVsaSBWaXJ0YW5lbg0KDQpSZWdhcmRzLA0K
VmxhZA0K
