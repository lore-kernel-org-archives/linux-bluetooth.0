Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004301A01BE;
	Tue, 22 Oct 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612167; cv=fail; b=KlbnOtVorAh2VPvGa31BTchVa8iPlEPtX2I104vY6ZdLfiLk3lxhzxCQO6h0FGbcKniiIBpxUbv38ZVNG5NiSNw4SjBb9rYv/T6UWfVLu+8EFzwGSXtK75LAa1BxLcP1AvhiopGJu/Sprk/pfHCKeKm0NhPofl0+Wws5CXDl5ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612167; c=relaxed/simple;
	bh=OND9KHjdgCYcDKUgaiP+CrQzNCp58UqZe/uchPb8MBg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EIEGj32CpewCG/j5TESPsicIe02qt7Xy05rH6rnCNkpw90UY+7ycgKmSNBOf63FA+3hzPZqKCgBeRcB3j/INNZY/VVvfzi1oScxiDwGr/PamZWbDesv9MPkFh4kUYEASjo+ir826M+QHGjXpnXQfjRaRnc/4nMDKHzcJl/gW18w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=NHXbWMrT; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="NHXbWMrT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vpI9pTDq5B2yKEsnJqUVNl7TIXlTKoBfabJfIqsFeWYFAfi/Oc8oq/3rK5RCxcbBeaPfH3mX5lnXBKdGV+Q/SCRHNa/KRy+jHk2HZ2h5R8JfFymMUuqkDiqJvcaXEoNd8raJJUVAkpA7aJ9o84dleJMnjSjN61hlMWpuTe655GpiSQIMNW8Rq2/fE/QRzSzASwMrC4/OQbLO/2ZR8Cf1jKUH+EtzXrBLvyqWNNenaLisPUQ9D4xgCbui4Xo6u1CB7k1c3CDL8EPNLcpanVdyByfW/Oci68ZXKOshLGiAdxDEg8cU4vD9+ex4+0MqC2uB3bHmm6vE6KD7pmjN7c+vlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OND9KHjdgCYcDKUgaiP+CrQzNCp58UqZe/uchPb8MBg=;
 b=CIiqCboX7hF1vrsnPl5WF0RHd8adL3wSDI2GlInSPzjyJuXrRwhnuoxyhQmscfzuhHLfuie9x7u1vtJFNoXH5eBJQ/SU+ifTiL18Gyl5IU9odmxI3xXuy43f5+qT1nCtNNk9X0zjp0wy+iqwVSlJKpsD49dNjRfG+Pl0Ogj1NNpkyoR90c6mieGZcWsXBK4dMTo1mBqdOzneYRV5nI7599sCwM+FtpOzfYW5tTlmuRi1Bk+awQr0oXe/kFq74OaZG6xRqELI4xA3lQQhr+SazMo8LFL/L52IHxVStYEN2Qm5ayp9IZrM8WSH8dBxdWKchrw3xVbS/OaSbK0KgsVijA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OND9KHjdgCYcDKUgaiP+CrQzNCp58UqZe/uchPb8MBg=;
 b=NHXbWMrTRblK5QL0zeHts8dQqi//Kva22EnaODwfOTs9geyHghAGrr0in1D6f5eJqEecQKWqogl1RVUk6BtMR4RxjEY26BjlcpbLgIQYMemcfExYTAdhXszuuBFuLrJeOVjaFhIRAnwH6oRIX84w/mxuYqN5BM8BLa8PsL1w/jY=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by PA1PR06MB9252.eurprd06.prod.outlook.com (2603:10a6:102:456::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 15:49:21 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 15:49:21 +0000
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
 AQHbFlGYxegmsfkbQ0S2PUUKI4YS47J5bJAAgAAtywCAAao9AIAAIGOAgBV25oCAABNWAIAAK2IAgAE7AYCAACRCgIAADPSAgAADvgCAAGT1gIAAF8QA
Date: Tue, 22 Oct 2024 15:49:20 +0000
Message-ID: <9b09774e-d0ed-4c97-b6a0-e976580b5bb5@leica-geosystems.com>
References:
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
 <20241022082256.nzfxqp67tdaxtn56@pengutronix.de>
 <DB9PR04MB84292445D0FEDB8211ED52C3924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
In-Reply-To:
 <DB9PR04MB84292445D0FEDB8211ED52C3924C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|PA1PR06MB9252:EE_
x-ms-office365-filtering-correlation-id: 75fbc406-b43e-45ad-2af4-08dcf2b1183f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?anFjcWFGRndxU3hEME11SUpZelY0L2JTZ082LytGVERoT0RmejZtekpWWUVH?=
 =?utf-8?B?VlhtRXBOS1Z1RUZqTytNK1hEMy9vd1p5alBoUEV4bDd0UDErYjJDVkhidnhZ?=
 =?utf-8?B?VW5xMWVHbTFDYkFGVkFUWFg3UXJOMnI1RlhmUmwzbkVNUXk3Ym1pbjVrSjVV?=
 =?utf-8?B?ZXA1VHpRQkNKbTRmYld1ZFV4STlYN0k5ZUFiZEEwTHFpSjU3WDdaRkcwVThL?=
 =?utf-8?B?VkhVOXRyUGU3TGlMeC8xZi91TkxIWVJUZUtFNTVlS3hIUUFuQy9JbnJkZS9p?=
 =?utf-8?B?Z3RIS3JnS05nK3pKNU9qM3RRSkFTWTdvc212c1dWd0JneEY3YlUvd1UxZS9x?=
 =?utf-8?B?L3pYM0ZWem1XbjlIK0FNOFJWMC8zWE1SWUlsS1Vzam1oZW1IUm4vaUZuVGJG?=
 =?utf-8?B?KzFtRSs4OEFKemlCL0E5S0xwSWRxMTFhcGt0UmVHMnJ5dlVuYzE2dW05cnFx?=
 =?utf-8?B?dlJ2VWJoaENva2I0QUhVSTlpalFrM3RQZ1pGV3ErUGtpUXJOVCtCMUlwM3NY?=
 =?utf-8?B?UWZnajBFZ25pUDVOSzhvWVZpWkt3bEJCTnZRS3BHZUptRWlXUWh3WElIazFq?=
 =?utf-8?B?TjU1TUhkL29kOVNjb3QrODYra1JyQ3o1Z3E0REJSVTM2Q25RM0N6c0x3Y3NZ?=
 =?utf-8?B?bktQZmJuOXdRZ28zNmQyQjZoR1o3a3I1TjRFZVFRcUZZSWlvQ3NiRS9TdmFF?=
 =?utf-8?B?L3NSNDlmc2kvdG5jVUtVUkwwZDhLTSsyMWdWL2pTelNmRlBiVVluRTk0VUZG?=
 =?utf-8?B?ajlKSW9XaSsyTU82bUxiRkMvRHFQRWY5OUF5YWxVdUlqaktzanRxbXBKZjdx?=
 =?utf-8?B?aU1rQXNPbFY4T1psb2s0Yy96cEt3Z0ROVWFiMStkUHlhUElnQndubys4N3lV?=
 =?utf-8?B?WU1JeTF6SGlwWlpLaGV5ZkNQMGRIalVneTJHOG9Ncmo2Tmh6QlpMZ21nSjRD?=
 =?utf-8?B?VHBQODNxU05VejRHQVhtM0pkbXZmdzNEQ01ITERoKzN2elZPdVM0K0YwRzlR?=
 =?utf-8?B?cEVOOXFiRHphbCtiL09ESkdUdE9vd2tsNW1adGV2SE9TVDJ5eFU0dElsMGJK?=
 =?utf-8?B?K0grVFJ4eERCeG9IYnUrQURWcy8vb1ZIeEhrUURkeEl0b0NVMWczSGlXQnU0?=
 =?utf-8?B?Q2NBS0ZaUFBEQ0FtQkZpcE91RzR3Rk1WK2ZnMUdld2Y0eGxWR3U0L000RGJh?=
 =?utf-8?B?K0RQQU5PNVB3aEFLZC8zWVMvbGttWjRLVkxxUVNucDlLTEVWSE9NWHJrem1R?=
 =?utf-8?B?M3VTenJSS0k5MEtKY0tkOG9halVSemxnaXh5K1hNRUpHd1J4QWVwT0J5blVB?=
 =?utf-8?B?Z0pnak8vY0laZzc1MS9jZFRXZms0RnZEcktlcEdwdUdVUUZnVWNoQTFiYVpp?=
 =?utf-8?B?QmtwblpON3dtb3hNSXFlek9pMWdITUdUdXNHRG1xRER3azhJVFhleVFqV2Q3?=
 =?utf-8?B?di9KZFNraUxMb1dYQ2tveGxaZW1xQWFidHNwaHFSNndqZmFSSWpOUHN3ZGh4?=
 =?utf-8?B?dzlCZFdNY2EyeTJ6azhPWnlhUkh5UEFBSkZWZm1TWWZuNEkwUHg2UGQzbWxN?=
 =?utf-8?B?MnVqOVJUVHVwVlBoMldQZFRLN1VXQzJQS1BESXhFVVJrdzhDUTJGdnk0QW1v?=
 =?utf-8?B?aUdxSXNreEs0R3lVRE9vcXZTTUJGTW4vVXFGNjUyNUlkTE1ETkpRekxMeEdB?=
 =?utf-8?B?ZXNFbG8wVW91cnNTczBldXpJdndSSEF6N1RqLzY4UkFVMEtpUTYzNXg1QUN4?=
 =?utf-8?B?YnNNNStxOU15SkZra2Z5UnAwZDVGU2tPYUtVZDBkWFUrRXYzcE4yeGwzZm02?=
 =?utf-8?Q?Mvh2J9HeHxt7ZwFgDoynSLIgjidbvwpU9igOo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1ZqN2FDNjZDaFVuUWlZUDNqVm9KZE9WQlNaTUxoSk1DU0pEaFoyckh3Q1l5?=
 =?utf-8?B?ak1UVXJ3d3cyVUp2Mnp3cE5UWDBvZWtKODEwbkk0ME1aVXNsQ3ltZmd2M1Fx?=
 =?utf-8?B?Z3IyemdjUjVRbkFjWSs2cTFTZzBCalkveE9wS0h6TDVUN1NvVXJLOEpkWGxj?=
 =?utf-8?B?SW5XazZjTW9BSzdTcFBSci9hSzhRcTJYdVJ2ZjhjZjZzVWNXQ3lld1hnMHla?=
 =?utf-8?B?NlhzSlNqcXBscDlRTWFvRUkycnlqNGdsWXI1MDlVbnNEQjVEMW1qcThHV3o0?=
 =?utf-8?B?UnlWYWVZYUJ2SUdyUzVrWk1yc0ZTTzB6VGpPOFlZdFVjMkhNbWI1Skx4ZFd4?=
 =?utf-8?B?b1VpQlJVY3VjVHpyTzZuV3dldEZXZlM2WHBhSkxkdGVDTHAwSGRWNGMweXFH?=
 =?utf-8?B?c0h6cTgySmo4RDZDK0FJOGZCcVFQS3R1alZxV2tyZ1doaVdMNkNHL09kM1Yr?=
 =?utf-8?B?UVppTG5YYUpPcnAvdGx5T2p6cVNlN2dRKzhSMUUwZ2VUbWVHVUx2blBZdzVI?=
 =?utf-8?B?eVI3MUlJRmpPZ1FsenZMUWs2a3FKTEJjNVJMdWNiY2poTkxmZ1RFVG42YUVs?=
 =?utf-8?B?emEwZFRKd0dndmpTaUM1aGFUKzZZelliM0Q0bmgzWTZQMFNCUWNlNFRuc3Nw?=
 =?utf-8?B?KzRDN1JPOHlPeHdTWkdRdFFzTmt4Z0VEOGdrMWljNzhoaWJKWFo5Umd2eXIr?=
 =?utf-8?B?eDdDaTJRN0VhMWd3MTZ4R1phN2dVVXVBclA2Zm5UT3c5V0wybzBra3pldnhL?=
 =?utf-8?B?elE1emhKbnRTRlh1NDg1ZzNJVGs1SE9NS3U1ZjRFdk9qT2pRT0dqYUlFa1hX?=
 =?utf-8?B?bENZcmVESlkwcjhhVDhLQkNQNnhQQ0pJVW9CT2tIeVdKOW9zU0Y0NnQvRW9C?=
 =?utf-8?B?VlB4d0hKRzZtcnB0dlJ5QWVyVHFOTDh2N3F4dW1aeWpOT3RSSC82NnkxcEtH?=
 =?utf-8?B?d1BCZ21EeWVEOTBqU0xkSGZRdU55bnFIS0pDaEdaK0I3YWsrZFROQW4wMG0x?=
 =?utf-8?B?eWU4MG1BMHF3a1U0eVFaQVVCUU90aEIvTlgwb0c2OWZzQ0FzS2ZoY1pxTHd1?=
 =?utf-8?B?alNrTGdtZmNFT0NsU1pxZk5LaVI3UHhWTUZBQTNoSEw1SkV1bmxmakRmK0NL?=
 =?utf-8?B?U0RxWFVLNUZoUXZaajBFT3gyUFRVb1hJN2UyVG4yYTZEaGFzZHNyTldHUzhI?=
 =?utf-8?B?a1dZZFpKTUgyRFdobjd0ZTR2K1JTdER3WnZsZ045bmlmTUhEVFhMWG0xeVBa?=
 =?utf-8?B?c29lSkQwU1l0T1grYjFNR01CUjN4VjdyQkw2b0NVVVRGeXVCeElxNnJRTkZH?=
 =?utf-8?B?S3paa1dMWGpTME4vNWhpSElKK1Z1clB5cysyRW10LzdPQ0RJWUFST3hmcFVm?=
 =?utf-8?B?amJXQTY5Q0VjK2RjQWxURThsMUdyMUpsUUNGYTlzem1BUi95S091MWpzclRx?=
 =?utf-8?B?Ym5oRFdiYnB2cTRieStBbWpTRE9GTXZ5MlBPUWU2NWoyK0ErZHlhMy96Uklj?=
 =?utf-8?B?Zjg2UlJWZ2lxMm9mTG5Sc28rQ3NMRXFOL0dITGJXaWpwSjhJeE5QUWRubEZS?=
 =?utf-8?B?YkZ1ZHhxaHBFcGlhSWtjMFVpd2syaWw1ZTFQMzQ2N05sR1NxVmpka05meDBs?=
 =?utf-8?B?ZlNkNFZheUpKUldHQmhMbnJlS1V1REFQcXVsZWxSajZQMmhyU2gxQ2psMlo4?=
 =?utf-8?B?TEpxNUdNSTJTQ2pXK3FBUm4rbXhsbnJQeEl3eERCd21NWTNGYVlHYTE4UFRm?=
 =?utf-8?B?QWo2TzdGdXFEZ29PTTk5Y1lYUEVsRFZjL01KTmpTaHlqdjh6eFgzNkEyOUJM?=
 =?utf-8?B?bnRkWXRQR1BxdDdoaTF5MkRlNStJUmFnYWdhT3phU3FEeVI3d2Q2OG9GanlG?=
 =?utf-8?B?b1VHd0pVSGtsL1UrbEs5KzNyeGhncVhtaDd4ZHpmK1lhUWxRc1NJTUdMWUZU?=
 =?utf-8?B?ajdRbDBHUVJ5cStPYUdyOWp1ODNMMmFpZmxpWTd0MkFLZWJFb250ZndBcFZs?=
 =?utf-8?B?cEE0OHc5clR5UThINTBMOUNIZFpSU3JXNVBTYWdTV0gwV0RRS2FrSDRCVVM5?=
 =?utf-8?B?TXZPdDZsaDdjOEtPTFJKbEZRSThCbkl2UVZoVC9jZGZkOXBtaHMvVWkwdWlD?=
 =?utf-8?B?c1lFT3BOQldTSFBjdWF6R2N3M1E5TEIxS3h5NU1TSFMyK2JnK2xNU01CYTNG?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C2EB8A63A88B74882C194156A43568D@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 75fbc406-b43e-45ad-2af4-08dcf2b1183f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 15:49:20.9089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: batF0nyPxdhQmJqIzShmaqjk0S3XOUqI/qcCv9Ygbr1ZcSp3hN68qp+MjGtkERZcJIzKljSLbfs4rIbIRMy+DbbzpmGcz3V9BIexklmsNS2a/neWqDexwkDvVseracDU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9252

T24gMjIvMTAvMjAyNCAxNjoyNCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gW+aUtuWIsOatpOmCruS7
tueahOafkOS6m+S6uumAmuW4uOS4jeS8muaUtuWIsOadpeiHqiBzaGVycnkuc3VuQG54cC5jb20g
55qE55S15a2Q6YKu5Lu244CC6K+36K6/6ZeuIGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5k
ZXJJZGVudGlmaWNhdGlvbu+8jOS7peS6huino+S4uuS7gOS5iOi/meS4gOeCueW+iOmHjeimgeOA
gl0NCj4NCj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGlu
c3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBh
dHRhY2htZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4NCj4NCj4NCj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBNYXJjbyBGZWxzY2ggPG0uZmVsc2NoQHBlbmd1
dHJvbml4LmRlPg0KPj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAyMiwgMjAyNCA0OjIzIFBNDQo+
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
biB3cm90ZToNCj4+Pg0KPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+PiBGcm9t
OiBNYXJjbyBGZWxzY2ggPG0uZmVsc2NoQHBlbmd1dHJvbml4LmRlPg0KPj4+PiBTZW50OiBUdWVz
ZGF5LCBPY3RvYmVyIDIyLCAyMDI0IDM6MjMgUE0NCj4+Pj4gVG86IFNoZXJyeSBTdW4gPHNoZXJy
eS5zdW5AbnhwLmNvbT4NCj4+Pj4gQ2M6IFBPUEVTQ1UgQ2F0YWxpbiA8Y2F0YWxpbi5wb3Blc2N1
QGxlaWNhLWdlb3N5c3RlbXMuY29tPjsNCj4+Pj4gQW1pdGt1bWFyIEthcndhciA8YW1pdGt1bWFy
LmthcndhckBueHAuY29tPjsgTmVlcmFqIFNhbmpheSBLYWxlDQo+Pj4+IDxuZWVyYWouc2FuamF5
a2FsZUBueHAuY29tPjsgbWFyY2VsQGhvbHRtYW5uLm9yZzsNCj4+Pj4gbHVpei5kZW50ekBnbWFp
bC5jb207IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOw0KPj4+PiBjb25vcitk
dEBrZXJuZWwub3JnOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlOyBsaW51eC0NCj4+Pj4gYmx1ZXRv
b3RoQHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0K
Pj4+PiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBHRU8tQ0hIRVItYnNwLWRldmVsb3BtZW50IDxi
c3AtDQo+Pj4+IGRldmVsb3BtZW50Lmdlb0BsZWljYS1nZW9zeXN0ZW1zLmNvbT47IEtyenlzenRv
ZiBLb3psb3dza2kNCj4+Pj4gPGtyemtAa2VybmVsLm9yZz4NCj4+Pj4gU3ViamVjdDogUmU6IFtQ
QVRDSCAxLzJdIGR0LWJpbmRpbmdzOiBuZXQ6IGJsdWV0b290aDogbnhwOiBhZGQNCj4+Pj4gc3Vw
cG9ydCBmb3Igc3VwcGx5IGFuZCByZXNldA0KPj4+Pg0KPj4+PiBPbiAyNC0xMC0yMiwgU2hlcnJ5
IFN1biB3cm90ZToNCj4+Pj4+PiBPbiAyNC0xMC0yMSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90
ZToNCj4+Pj4+Pj4gT24gMjEvMTAvMjAyNCAwODo0MSwgTWFyY28gRmVsc2NoIHdyb3RlOg0KPj4+
Pj4+Pj4gT24gMjQtMTAtMDcsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4+Pj4+Pj4g
T24gMDcvMTAvMjAyNCAxNDo1OCwgUE9QRVNDVSBDYXRhbGluIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+
PiArICB2Y2Mtc3VwcGx5Og0KPj4+Pj4+Pj4+Pj4+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4+Pj4+
Pj4+Pj4+PiArICAgICAgcGhhbmRsZSBvZiB0aGUgcmVndWxhdG9yIHRoYXQgcHJvdmlkZXMgdGhl
IHN1cHBseQ0KPj4gdm9sdGFnZS4NCj4+Pj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+Pj4+PiArICBy
ZXNldC1ncGlvczoNCj4+Pj4+Pj4+Pj4+Pj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+Pj4+Pj4+Pj4+
Pj4gKyAgICAgIENoaXAgcG93ZXJkb3duL3Jlc2V0IHNpZ25hbCAoUERuKS4NCj4+Pj4+Pj4+Pj4+
Pj4gKw0KPj4+Pj4+Pj4+Pj4+IEhpIENhdGFsaW4sDQo+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+
PiBGb3IgTlhQIFdJRkkvQlQgY2hpcCwgV0lGSSBhbmQgQlQgc2hhcmUgdGhlIG9uZSBQRG4gcGlu
LA0KPj4+Pj4+Pj4+Pj4+IHdoaWNoDQo+Pj4+Pj4gbWVhbnMgdGhhdCBib3RoIHdpZmkgYW5kIEJU
IGNvbnRyb2xsZXIgd2lsbCBiZSBwb3dlcmVkIG9uIGFuZA0KPj4+Pj4+IG9mZiBhdCB0aGUgc2Ft
ZSB0aW1lLg0KPj4+Pj4+Pj4+Pj4+IFRha2luZyB0aGUgTS4yIE5YUCBXSUZJL0JUIG1vZHVsZSBh
cyBhbiBleGFtcGxlLA0KPj4+Pj4+IHBpbjU2KFdfRElTQUJMRTEpIGlzIGNvbm5lY3RlZCB0byB0
aGUgV0lGSS9CVCBjaGlwIFBEbiBwaW4sIHdlDQo+Pj4+Pj4gaGFzIGFscmVhZHkgY29udHJvbGxl
ZCB0aGlzIHBpbiBpbiB0aGUgY29ycmVzcG9uZGluZyBQQ0llL1NESU8NCj4+Pj4+PiBjb250cm9s
bGVyIGR0cw0KPj4+PiBub2Rlcy4NCj4+Pj4+Pj4+Pj4+PiBJdCBpcyBub3QgY2xlYXIgdG8gbWUg
d2hhdCBleGFjdGx5IHBpbnMgZm9yIHZjYy1zdXBwbHkNCj4+Pj4+Pj4+Pj4+PiBhbmQgcmVzZXQt
Z3Bpb3MNCj4+Pj4+PiB5b3UgZGVzY3JpYmluZyBoZXJlLiBDYW4geW91IGhlbHAgdW5kZXJzdGFu
ZCB0aGUgY29ycmVzcG9uZGluZw0KPj4+Pj4+IHBpbnMgb24gTS4yIGludGVyZmFjZSBhcyBhbiBl
eGFtcGxlPyBUaGFua3MuDQo+Pj4+Pj4+Pj4+IEhpIFNoZXJyeSwNCj4+Pj4+Pj4+Pj4NCj4+Pj4+
Pj4+Pj4gUmVndWxhdG9ycyBhbmQgcmVzZXQgY29udHJvbHMgYmVpbmcgcmVmY291bnRlZCwgd2Ug
Y2FuDQo+Pj4+Pj4+Pj4+IHRoZW4gaW1wbGVtZW50IHBvd2VydXAgc2VxdWVuY2UgaW4gYm90aCBi
bHVldG9vdGgvd2xhbg0KPj4+Pj4+Pj4+PiBkcml2ZXJzIGFuZCBoYXZlIHRoZSBkcml2ZXJzIG9w
ZXJhdGUgaW5kZXBlbmRlbnRseS4gVGhpcw0KPj4+Pj4+Pj4+PiB3YXkgYmx1ZXRvb3RoIGRyaXZl
ciB3b3VsZCBoYXMgbm8gZGVwZW5kYW5jZSBvbiB0aGUgd2xhbg0KPj4gZHJpdmVyIGZvciA6DQo+
Pj4+Pj4+Pj4+IC0gaXRzIHBvd2VyIHN1cHBseQ0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiAtIGl0
cyByZXNldCBwaW4gKFBEbikNCj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4gLSBpdHMgZmlybXdhcmUg
KGJlaW5nIGRvd25sb2FkZWQgYXMgcGFydCBvZiB0aGUgY29tYm8NCj4+Pj4+Pj4+Pj4gZmlybXdh
cmUpDQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IEZvciB0aGUgd2xhbiBkcml2ZXIgd2UgdXNlIG1t
YyBwb3dlciBzZXF1ZW5jZSB0byBkcml2ZSB0aGUNCj4+Pj4+Pj4+Pj4gY2hpcCByZXNldCBwaW4g
YW5kIHRoZXJlJ3MgYW5vdGhlciBwYXRjaHNldCB0aGF0IGFkZHMNCj4+Pj4+Pj4+Pj4gc3VwcG9y
dCBmb3IgcmVzZXQgY29udHJvbCBpbnRvIHRoZSBtbWMgcHdyc2VxIHNpbXBsZSBkcml2ZXIuDQo+
Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+PiBQbGVhc2Ugd3JhcCB5b3VyIHJlcGxpZXMuDQo+Pj4+Pj4+
Pj4+Pg0KPj4+Pj4+Pj4+Pj4gSXQgc2VlbXMgeW91IG5lZWQgcG93ZXIgc2VxdWVuY2luZyBqdXN0
IGxpa2UgQmFydG9zeiBkaWQNCj4+Pj4+Pj4+Pj4+IGZvcg0KPj4+Pj4+IFF1YWxjb21tIFdDTi4N
Cj4+Pj4+Pj4+Pj4gSGkgS3J6eXN6dG9mLA0KPj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+PiBJJ20gbm90
IGZhbWlsaWFyIHdpdGggcG93ZXIgc2VxdWVuY2luZywgYnV0IGxvb2tzIGxpa2Ugd2F5DQo+Pj4+
Pj4+Pj4+IG1vcmUgY29tcGxpY2F0ZWQgdGhhbiByZXNldCBjb250cm9scy4gU28sIHdoeSBwb3dl
cg0KPj4+Pj4+Pj4+PiBzZXF1ZW5jaW5nIGlzIHJlY29tbWVuZGVkIGhlcmUgPyBJcyBpdCBiL2Mg
YSBzdXBwbHkgaXMNCj4+IGludm9sdmVkID8NCj4+Pj4+Pj4+PiBCYXNlZCBvbiBlYXJsaWVyIG1l
c3NhZ2U6DQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiAiRm9yIE5YUCBXSUZJL0JUIGNoaXAsIFdJRkkg
YW5kIEJUIHNoYXJlIHRoZSBvbmUgUERuIHBpbiwNCj4+Pj4+Pj4+PiB3aGljaCBtZWFucyB0aGF0
IGJvdGggd2lmaSBhbmQgQlQgY29udHJvbGxlciB3aWxsIGJlDQo+Pj4+Pj4+Pj4gcG93ZXJlZCBv
biBhbmQgb2ZmIGF0IHRoZSBzYW1lIHRpbWUuIg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gYnV0IG1h
eWJlIHRoYXQncyBub3QgbmVlZGVkLiBObyBjbHVlLCBJIGRvbid0IGtub3cgdGhlIGhhcmR3YXJl
Lg0KPj4+Pj4+Pj4+IEJ1dCBiZSBjYXJlZnVsbHkgd2hhdCB5b3Ugd3JpdGUgaW4gdGhlIGJpbmRp
bmdzLCBiZWNhdXNlDQo+Pj4+Pj4+Pj4gdGhlbiBpdCB3aWxsIGJlDQo+Pj4+Pj4gQUJJLg0KPj4+
Pj4+Pj4gV2Ugbm90aWNlZCB0aGUgbmV3IHBvd2VyLXNlcXVlbmNpbmcgaW5mcmFzdHJ1Y3R1cmUg
d2hpY2ggaXMNCj4+Pj4+Pj4+IHBhcnQgb2YNCj4+Pj4+Pj4+IDYuMTEgdG9vIGJ1dCBJIGRvbid0
IHRoaW5rIHRoYXQgdGhpcyBwYXRjaCBpcyB3cm9uZy4gVGhlIERUDQo+Pj4+Pj4+PiBBQkkgd29u
J3QgYnJlYWsgaWYgd2Ugc3dpdGNoIHRvIHRoZSBwb3dlci1zZXF1ZW5jaW5nIGxhdGVyDQo+Pj4+
Pj4+PiBvbiBzaW5jZSB0aGUNCj4+Pj4+PiAicmVzZXQtZ3Bpb3MiDQo+Pj4+Pj4+PiBhcmUgbm90
IG1hcmtlZCBhcyByZXF1aXJlZC4gU28gaXQgaXMgdXAgdG8gdGhlIGRyaXZlciB0bw0KPj4+Pj4+
Pj4gaGFuZGxlIGl0IGVpdGhlciB2aWEgYSBzZXBhcmF0ZSBwb3dlci1zZXF1ZW5jZSBkcml2ZXIg
b3IgdmlhDQo+PiAicG93ZXItc3VwcGx5Ig0KPj4+Pj4+Pj4gYW5kICJyZXNldC1ncGlvcyIgZGly
ZWN0bHkuDQo+Pj4+Pj4+IFRoYXQncyBub3QgdGhlIHBvaW50LiBXZSBleHBlY3QgY29ycmVjdCBo
YXJkd2FyZSBkZXNjcmlwdGlvbi4NCj4+Pj4+Pj4gSWYgeW91IHNheSBub3cgaXQgaGFzICJyZXNl
dC1ncGlvcyIgYnV0IGxhdGVyIHNheSAiYWN0dWFsbHkNCj4+Pj4+Pj4gbm8sIGJlY2F1c2UgaXQg
aGFzIFBNVSIsIEkgcmVzcG9uZDogbm8uIERlc2NyaWJlIHRoZSBoYXJkd2FyZSwNCj4+Pj4+Pj4g
bm90IGN1cnJlbnQNCj4+Pj4gTGludXguDQo+Pj4+Pj4gSSBrbm93IHRoYXQgRFQgYWJzdHJhY3Rz
IHRoZSBIVy4gVGhhdCBzYWlkIEkgZG9uJ3Qgc2VlIHRoZQ0KPj4+Pj4+IHByb2JsZW0gd2l0aCB0
aGlzIHBhdGNoLiBUaGUgSFcgaXMgYWJzdHJhY3RlZCBqdXN0IGZpbmU6DQo+Pj4+Pj4NCj4+Pj4+
PiBzaGFyZWQgUERuICAgICAgICAgIC0+IHJlc2V0LWdwaW9zDQo+Pj4+Pj4gc2hhcmVkIHBvd2Vy
LXN1cHBseSAtPiB2Y2Mtc3VwcGx5DQo+Pj4+PiBBY3R1YWxseSB3ZSBzaG91bGQgdXNlIHZjYy1z
dXBwbHkgdG8gY29udHJvbCB0aGUgUERuIHBpbiwgdGhpcyBpcw0KPj4+Pj4gdGhlIHBvd2VyIHN1
cHBseSBmb3IgTlhQIHdpZmkvQlQuDQo+Pj4+IFBsZWFzZSBkb24ndCBzaW5jZSB0aGlzIGlzIHJl
Z3VsYXIgcGluIG9uIHRoZSB3bGFuL2J0IGRldmljZSBub3QgdGhlDQo+PiByZWd1bGF0b3IuDQo+
Pj4+IFBlb3BsZSBvZnRlbiBkbyB0aGF0IGZvciBHUElPcyBpZiB0aGUgZHJpdmVyIGlzIG1pc3Np
bmcgdGhlIHN1cHBvcnQNCj4+Pj4gdG8gcHVsbCB0aGUgcmVzZXQvcGRuL2VuYWJsZSBncGlvIGJ1
dCB0aGUgZW5hYmxlLWdwaW8gb24gdGhlDQo+Pj4+IHJlZ3VsYXRvciBpcyB0byBlbmFibGUgdGhl
IHJlZ3VsYXRvciBhbmQgX25vdF8gdGhlIGJ0L3dsYW4gZGV2aWNlLg0KPj4+Pg0KPj4+PiBUaGVy
ZWZvcmUgdGhlIGltcGxlbWVudGF0aW9uIENhdGFsaW4gcHJvdmlkZWQgaXMgdGhlIGNvcnJlY3Qg
b25lLg0KPj4+Pg0KPj4+IEZvciBOWFAgd2lmaS9CVCwgdGhlIFBEbiBpcyB0aGUgb25seSBwb3dl
ciBjb250cm9sIHBpbiwgbm8gc3BlY2lmaWMNCj4+PiByZWd1bGF0b3IsIHBlciBteSB1bmRlcnN0
YW5kaW5nLCBpdCBpcyBhIGNvbW1vbiB3YXkgdG8gY29uZmlndXJlIHRoaXMNCj4+PiBwaW4gYXMg
dGhlIHZjYy1zdXBwbHkgZm9yIHRoZSB3aWZpIGludGVyZmFjZShTRElPIG9yIFBDSWUpLg0KPj4g
TkFDSy4gRWFjaCBhY3RpdmUgZXh0ZXJuYWwgY2hpcCBuZWVkcyBwb3dlciwgdGhpcyBpcyBzdXBw
bGllZCB2aWEgYW4gc3VwcGx5LQ0KPj4gcmFpbCBhbmQgdGhpcyBpcyB3aGF0IHZjYy92ZGQvdmEv
dmRpby92KioqLXN1cHBseSBhcmUgdXNlZCBmb3IuDQo+Pg0KPj4gVGhlIFBEbiBpcyBhIGRpZ2l0
YWwgaW5wdXQgc2lnbmFsIHdoaWNoIHRlbGxzIHRoZSBjaGlwIHRvIGdvIGludG8gcG93ZXItDQo+
PiBkb3duL3Jlc2V0IG1vZGUgb3Igbm90Lg0KPj4NCj4+PiByZWdfdXNkaGMzX3ZtbWM6IHJlZ3Vs
YXRvci11c2RoYzMgew0KPj4+ICAgICAgICAgICBjb21wYXRpYmxlID0gInJlZ3VsYXRvci1maXhl
ZCI7DQo+Pj4gICAgICAgICAgIHJlZ3VsYXRvci1uYW1lID0gIldMQU5fRU4iOw0KPj4+ICAgICAg
ICAgICByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4+PiAgICAgICAgICAg
cmVndWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8MzMwMDAwMD47DQo+Pj4gICAgICAgICAgIGdwaW8g
PSA8JnBjYWw2NTI0IDIwIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPj4+ICAgICAgICAgICBlbmFibGUt
YWN0aXZlLWhpZ2g7DQo+Pj4gfTsNCj4+IFRoaXMgaXMgd2hhdCBJIG1lYW50IHByZXZpb3VzbHks
IHlvdSBkbyB1c2UgYSByZWd1YWx0b3IgZGV2aWNlIGZvciBzd2l0Y2hpbmcNCj4+IHRoZSBQRG4g
c2lnbmFsLiBUaGlzIGlzIG5vdCBjb3JyZWN0LCBhbGJlaXQgYSBsb3Qgb2YgcGVvcGxlIGFyZSBk
b2luZyB0aGlzDQo+PiBiZWNhdXNlIHRoZXkgZG9uJ3Qgd2FudCB0byBhZGFwdCB0aGUgZHJpdmVy
LiBUaGUgJ2dwaW8nDQo+PiB3aXRoaW4gdGhpcyByZWd1YWx0b3Igc2hvdWxkIGVuYWJsZS9kaXNh
YmxlIHRoaXMgcGFydGljdWxhciBwaHlzaWNhbCByZWd1YWx0b3IuDQo+Pg0KPiBTb3JyeSBJIHNl
ZSBpdCBkaWZmZXJlbnRseS4gSSBjaGVja2VkIHRoZSBkYXRhc2hlZXQgb2YgTlhQIHdpZmkgY2hp
cCh0YWtpbmcgSVc2MTINCj4gYXMgYW4gZXhhbXBsZSksIHRoZSBQRG4gcGluIGlzIG5vdCB0aGUg
QlQgcmVzZXQgcGluLCB3ZSB1c3VhbGx5IHRha2UgaXQgYXMgdGhlDQo+IFBNSUNfRU4vV0xfUkVH
X09OIHBpbiB0byBjb250cm9sIHRoZSB3aG9sZSBjaGlwIHBvd2VyIHN1cHBseS4NCj4NCj4gSSB0
aGluayB0aGUgcmVzZXQtZ3BpbyBhZGRlZCBoZXJlIHNob3VsZCBjb250cm9sIHRoZSBJTkRfUlNU
X0JUIHBpbg0KPiAoSW5kZXBlbmRlbnQgc29mdHdhcmUgcmVzZXQgZm9yIEJsdWV0b290aCksIHNp
bWlsYXIgZm9yIHRoZQ0KPiBJTkRfUlNUX1dMIHBpbihJbmRlcGVuZGVudCBzb2Z0d2FyZSByZXNl
dCBmb3IgV2ktRmkpLg0KPg0KPiBCZXN0IFJlZ2FyZHMNCj4gU2hlcnJ5DQoNClBEbiBpcyBub3Qg
dGhlIEJUIHJlc2V0IDoNCg0KLSBQRG4gaXMgYSBjaGlwIHJlc2V0IGFuZCBpcyBzaGFyZWQgYi93
IEJUIGFuZCBXSUZJIDogaGVuY2UsIGl0IG5lZWRzIHRvIA0KYmUgbWFuYWdlZCBhcyBhIHJlc2V0
IGNvbnRyb2wNCg0KLSBCVCByZXNldCBpcyBzcGVjaWZpYyB0byBCVCBhbmQgY2FuIGJlIGhhbmRs
ZWQgYXMgYSBzaW1wbGUgZ3BpbyBhcyBpdCdzIA0Kbm90IGJlaW5nIHNoYXJlZCB3aXRoIG90aGVy
IGRyaXZlciAoZS5nIFdJRkkpDQoNCkkndmUgb25seSBhZGRlZCBzdXBwb3J0IGZvciBwb3dlci1z
dXBwbHkgYW5kIFBEbi4NCg0KQlQgc3BlY2lmaWMgcmVzZXQgaGFzIGJlZW4gaWdub3JlZCBzbyBm
YXIgYXMgaXQncyBvcHRpb25hbCBzb2Z0d2FyZSANCnJlc2V0IGFuZCBpdCBjYW4gYmUgbGVmdCBv
cGVuIGlmIG5vdCBuZWVkZWQgaW4gdGhlIGRlc2lnbi4NCg0KDQo=
