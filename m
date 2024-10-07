Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2F1D3653;
	Mon,  7 Oct 2024 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305158; cv=fail; b=n6iS148XDiWe7YhJvTK42VuVknnDdn7N2MjdZtdvYndWj+G3zx6LjMnmHOVyoqkEubTkAjcHQ1vB9CBZ2M1ryQ+zTPftjZxrTTNLmJJkhm2nco4SgAcvZGbNohIY4mEUhVLpec6KcAUCeya9sLpTnMbVdjrQ8M/AbVgYUQyG/gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305158; c=relaxed/simple;
	bh=NgbtXqhqd23JFgpfG+p4eg+2YWo1o1wM6kHtMNMd1rQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bt3Pkl9rCY3rnpWLk8lDYeKKBOjkfjq94iBsuYHZiXY6WHEEMdUqE4OmwmvAGm6FmWxTZR5c2TyKdoduKTf9yjPUIcXC6esibh5crL7vfgkByJLHq6H6bv+DXoatSGaIxCBphpxpulHCXrxZ3vMiv8oSXiSm6UII0R3gothjEos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=pgVSjU3u; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="pgVSjU3u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpSK0LS2m50zi7saSbkqHv5OwL0jfQfI9EwJjRKK5qnfkZpzEpNByurWTW0QkRpeQmg0S+L+e044FXChH6SWOyKePhsqDumDk0hdOeSewwcRdheG75lbTnxMyQwYZWrO6xhng+2owqfcWd7FuvRaSg8O0Impg2GaflAGqGgLwUxZfBf9em/CZJ2ffmRgsLqleHRmQH96FKYaKMudC7sThDJxRg7l4NWID9Ysr31Zcv+17IaMx1k3IQ060CqBhCFsUYuayx7pc2HNl5eB4eFE8jdyzQxsJHuwk+hkME0fEktbXuGbSFsBwbL8QVcPaYt5Z4tGXf/QP7J/nZQZCcoybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgbtXqhqd23JFgpfG+p4eg+2YWo1o1wM6kHtMNMd1rQ=;
 b=N1yWqooGYMSJmhN9yGOHdPGg9a8R85yr++F8e84GPDWmSUvXYpfPFrARsZ+6KZ5gA4bzHr2z3p5X+bP/AWRQamg3tMW5lXsRbJgodxbUFenffMHs1SZb3F5tBN7Hn8bN+XU1kVVWVAafTOQKkNjERL2HhkfwyeZX69A8oA3AsGmUWN0YZUS7/Vu16TNvdgCr5w98kp++K1UJdB805plm825hvM8KUxEVSi5xbtRP9ATFPCNF/8ipUtFuSASukAhKMzK59J+T5ajZjqODqibRf4+sef2npqsxlj7oQ27X2N+VxGGqJSgH+Kos1HnxXUnHds/m+mgEkZeTo18BXrP9Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgbtXqhqd23JFgpfG+p4eg+2YWo1o1wM6kHtMNMd1rQ=;
 b=pgVSjU3u54NzuCnO2AzKOxbVF8eip5S4PYfKTmc/3WjQkYsoUKto3OUrljhYzVE2L7Q+irMZwYWa8XCq9N57SxNkM9YIyr5RFRy0atb6saQmCzUVhmG/rk8mV/Vh6vN5JogCw9qZGmyOEmzhVDo7UQaT9b3Y6bjm3bjf/46/Jxo=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by PR3PR06MB7052.eurprd06.prod.outlook.com (2603:10a6:102:8f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 12:45:52 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 12:45:52 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Sherry Sun <sherry.sun@nxp.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 2/2] Bluetooth: btnxpuart: implement powerup sequence.
Thread-Topic: [PATCH 2/2] Bluetooth: btnxpuart: implement powerup sequence.
Thread-Index: AQHbFlGY+Tlj3xyvrk6D8R3pK4wfIrJ5cLuAgAHQUQA=
Date: Mon, 7 Oct 2024 12:45:52 +0000
Message-ID: <7f40433e-0474-449f-b4e6-de69d5082043@leica-geosystems.com>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
 <20241004113557.2851060-2-catalin.popescu@leica-geosystems.com>
 <DB9PR04MB84296D227CDA74D732399B9C927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
In-Reply-To:
 <DB9PR04MB84296D227CDA74D732399B9C927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|PR3PR06MB7052:EE_
x-ms-office365-filtering-correlation-id: 6fef1b9f-dd7e-46d9-07b2-08dce6cdfab8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c09kNytnRVREYnNNM200R2ovY0ZrSEpTWmNScm1ib3RKZ3hxYTFGQVVidXkw?=
 =?utf-8?B?clNybjFGOWhHNmJrUHZ5NloxUHZ6VTJZOWh3V0ZpaDlPb2JoaGZqZmkwSU9S?=
 =?utf-8?B?ZjcvaFVYTFBSU1VCVGR3Sm1yQ3F3UkpNdjZWd3ZNTnVRdytWVU1Xck9pWlJB?=
 =?utf-8?B?SEl5Q3VOSjdZVERRQmxWT0xuN3hjT0wzamEyTlM2elF0STA4U2Rka3Myc3BB?=
 =?utf-8?B?Vndxd1FyUkJRQ2RFRTB0ZndSbmpEc1NFSVJjQlZFd05tajV5RFVXRGp4djEz?=
 =?utf-8?B?MmZ2d3hQODAyS1RsYVBYY21ERUdBb0cxcnRSNGNYZVJOTTlVMSt4WnZoOTY2?=
 =?utf-8?B?Q0JQU2tXb2gwOFJnMHVLdVNDMGM1YmpPVnVBbEFBejVaYlhHbUlxUE5QbG1H?=
 =?utf-8?B?L0p1LzFYRFJ6NVU0SmJibTZrTDZuN1RVTkUrWEZDV2lOUkFVdWQyaTdhT1Y2?=
 =?utf-8?B?RjlLR01xNzZSYjgxL3N1SGwvMlB3b0Nwd0ltSWZBZkxJR2svR00xRFF4VnI4?=
 =?utf-8?B?aVdFYmRJS1NoMzUvSzZ0blJINm53M0NjbU1LeEtVVVdCOGJHVkdhMXJCRWQz?=
 =?utf-8?B?NTlmT0JlUEhxY0JDS1NHVlloQi9VRnVqOFE3ZGppcWNOdGRuK1FKQkZWTzZ1?=
 =?utf-8?B?WjZTZ1VZVkd1WER3VmVhcFZnUERPcTZaMjhuNkFKOS9ROGUzYTRJMitoS1d2?=
 =?utf-8?B?YWNyUCs0cjFVZXVLRXBBUkxZT1h2T3RBZFFWdjdJWUxia1FlaVVTQVpoVDFI?=
 =?utf-8?B?c01wMXJFYnQ2ZlZEbStoeFBoRmx1NEhmenVseGxCMFRTWmZRa2VBNkhjd0ox?=
 =?utf-8?B?cUViMEwzV0NiUitxUVFvalUvdTRveUlJaU1VaEpJM2R3UGFlUThyWGd3QmVK?=
 =?utf-8?B?cWxyQW9SVFg4bW1HLzUrcm10ZW1hdVdlUnQyTTBBcDI1NHdGeWVNdDB0MUF0?=
 =?utf-8?B?WnVEK05YekhpbDU4TFM5SFBzVCtFK3pzQ1c2dXdZWlVhcmdpWGpEdHBocm1y?=
 =?utf-8?B?dzVLdkNSbVM4VC9DOVRSTExNVVhrTi95eWFoWTZrNWFaWlM0ZmxDbmRCR3l6?=
 =?utf-8?B?VEYvRlY5R3pCTytONnljQkFtOTBoNndTRjZyaUQ3Mkx2V3FvbWpEUGw1WlBD?=
 =?utf-8?B?cHJXZkRRQ0NndFg2eWd6TGhWa0NRb0RQOEluc0lRSXJwNC9BUjQ0UUZkOGhC?=
 =?utf-8?B?TzZOLy9rVUVocGJrRWxRN0h4YzVraXhqcUNhL2gwazFVOVA2bHMvYklKUnQz?=
 =?utf-8?B?a1VpNjQvbVc4SHNGYVVHdERRQzE3VlFCbGduQkZlc3dDTTJsY3RxR1hVUkpv?=
 =?utf-8?B?K2swUHE0alZwNGNxdXlzY3EwMUV0TExHL3pPMVJKRDZoaEVEK01XcUE3cjBn?=
 =?utf-8?B?QzBoaVRweVg2cVY1c2I1NVFuR0I0NWFmUWdRK0lHWlBwdjFxR21WZHhMY1lq?=
 =?utf-8?B?aEp5RjZvRHUwbjdJRUJVdzZJSzZWMWhiOWl6c0haZkw0YmxDVndVbWtjQjdP?=
 =?utf-8?B?cG9HblB6aWprTGVRMFJMd1JOWHM3b2lIY0JkZCs3dW9LUFZ2VGl4dkJwRytL?=
 =?utf-8?B?a0padW9mNzFmOGtqOWkrMzRlRHhPbEhzNUQwaVBSVkpLWFdoUXhYYS9XMytU?=
 =?utf-8?B?Z3ZWZXRPRG4wazRlZERKMEszTUVpeXFXTUxyYi9CNGpjTnE3TnhIbVVBSnp1?=
 =?utf-8?B?bnlPVmhIQUVHL3NiRWlieU5hUnJ2UkZDdm5tR0VOdWVxL3JxcDFQc0p1VGpk?=
 =?utf-8?B?NFNlQ3Vpa1cxbEVuTEV5NUZrQnhtL2Rza0lidkVOQkt6ZUpodjJLdWxyS1BI?=
 =?utf-8?B?MTQ3ZThvamtHdURTSlpDZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eWhSM1NsRjNIVEN4ZmMwSG13aDhpb3BCRm1XMmdWWmkwQVJuODBNeUpZN05H?=
 =?utf-8?B?UUREcFVzRG1LNUpJSlJvbDMvbnoydWNLK2o3K3pBT0NuNEpCQmpXYytrMUtW?=
 =?utf-8?B?K3JCc2QyUU5nSkhrU1ptL21EN2x6Tnc3UWg5NWZOa1g2MUJEZjgyTks0UGR2?=
 =?utf-8?B?RnhOQjNQZUtWQjU3WXVwVU1OcVpzYlZoVUc2bldpMEtBaTZWSHlyTTQvcUY0?=
 =?utf-8?B?WDFCN0p0Q0dBUlpoNTY2SFNvMTRuOVkzWkNtUFRnbG8rMnp5UXRrYmkzaGNi?=
 =?utf-8?B?MWQyRno1MDYrOHV1VkRNb0IyWnBqODg5OWNMNjZYdWpnN3l3cWF5OEZkd2sr?=
 =?utf-8?B?b0g2U0xMSXdhRjlvYlZuRmpCdHp6ZWJQanNPQkRFbXZvcGI4OGtLUHZTZmdZ?=
 =?utf-8?B?bEVnQTh3U1doWkREaVd6ZFQ3bjdab0ZzRnVZeUlxRjRJRm1BTDZqTktLSUdz?=
 =?utf-8?B?UWxybHBpZlVGd3pvaVh3WnZsZlBqK1dpOEIyWWE3dTA5NmtudjRZalRob0Vp?=
 =?utf-8?B?V1VIZWJZQ2FBNGtOR0tHME1rOFk2ZWhseGU2Ri9kNUQwNXU4QnUzM0R2TlZT?=
 =?utf-8?B?K2wvbTh5RUo0dXEzZGhLSXJiRTdQZFFDVTRKY2JCb0czOTNaai8rMUlXZklK?=
 =?utf-8?B?WFgxU2lOM1FYbEhhZHJReVVPY1gyMGJsYXBQcDFCYjJ0eW44K3dKQkMxdnhJ?=
 =?utf-8?B?UFNFVnNrUGczZlhVVGxTNWxpN2hQNTgrOGk0em9zbmpEQWVGblQ5RjR0em1D?=
 =?utf-8?B?STYxV0FablAwYm44TSt1bHpUYm5Qc3BET1VPODc1dCszTjNZMHlEQkR3aCtD?=
 =?utf-8?B?Q0N1Qyt6aVB6cnZkYXJUcnBRVk4yai9RVExXQmx1VEc0NDF0bFR1SWQvT1Yw?=
 =?utf-8?B?QUh2OHhRSFJxSHVBNmVZalJkeHNFYzlta3ZHalprOWVQYWR1VmpaZkEvV0d1?=
 =?utf-8?B?MkRvWlRoOUVTNnNHS2ZUNVhQZEtTRlZmanIxS3IzM3luTytTY2VqTVAyWGxm?=
 =?utf-8?B?K0RSRkxEWFlEbk82eE02d1QvQzVIb0JJV0RydlRXblFpVnY0SGVIS0FyU2dW?=
 =?utf-8?B?NHROZzg0TjAwRCtNZmpDVkx2bGN3RmU1d29pWittWklLaGxsY0ZER0lVWVla?=
 =?utf-8?B?b2tLRWltbWlmWVl2LzVGNzBobVFNekpVWjJlNS84Y2xEOTNJUk9KYXpxMzMr?=
 =?utf-8?B?SU82Yjl4L2dYSHNIVEN2bTErNlVZY1JiV3FQd251R1loVEtxRHlDMnphSkQ0?=
 =?utf-8?B?S3l0R1BsTmxVQnRzRDBTaENiTTVEVVZuWTJCekZDd0NxdVpQUEJrci9JLys0?=
 =?utf-8?B?bW1iYlpCVmRjRVpPaVJqQytMZEI0cXFCaUd1S0pjWGVOZG1SMldoSVA3TUVh?=
 =?utf-8?B?VUlBYWFCVFZyZlhwN3VFY2RCejBuOUJHQUppRWJleEVYNXpTeERndlpzK3Rk?=
 =?utf-8?B?S05rQWtuVXdvcXJLN2VuWm11SEQ5K1VqK2cwdjdkejlibnE3MG1PdFRZbjRN?=
 =?utf-8?B?VnZROU9yZ0ZXbFJpUUlIelFWc2FCeGhRMndleC9TVTRyRDhpTC9obXd4b3c5?=
 =?utf-8?B?TXo0U0VZcGgremY1NTVGYi9KblFseW96djJ1OFM3RXY2dlQzNXpLTWd6M0Mw?=
 =?utf-8?B?Z09LUnFIaHBMcjZObExmblJwaStSc1AxZGVTdlpPSWlENEZzZE4zcXFYdWhF?=
 =?utf-8?B?S2VhSmczUlBYNkJ3ZGRHekFROW9ydG91L29tRndBaXNtQTJKNzFCb2NuamJq?=
 =?utf-8?B?bVZ0VkNKNmN0b0RaYnJHcHMrVlhLZEZwRUdqMVlQWnZBQndKSlUvRlRjRkJs?=
 =?utf-8?B?cjFHT2cyd0c2NHN2cUJURnM3b3pHWTNJQVRaTzRFOERHYzJOb0Y4Y0thcWpt?=
 =?utf-8?B?Z0xXK204MlgrcWJXR3M3L1ZwNHRkKy9mSHBmL1NaM21JM2g3MWduaitQRDdX?=
 =?utf-8?B?RmpOMEc1VTRUNUo4NTJjN1RpVzY5L0QvRTFOVXI4UHVnVy9HNk9GZ3N4Mktz?=
 =?utf-8?B?Q0NkZTJhMVRwWTZhL0ROZkZyVXh1MlFVVGdUT1hVRFhsUFA5eTdwRkI3ay90?=
 =?utf-8?B?R0dkUktyYkZFL0x4TjczdmVWOG5jdG1raXRCN2FEbUZoQzJmZThXc0swZUJ2?=
 =?utf-8?B?SENqZGkwT1hyWGpTN2p4VHNGbnNmdjFsWHBmYWtRWThOMmo5QVNxdlZHT21q?=
 =?utf-8?B?RVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE68BE83A67A34489A78AB45F5D9C648@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fef1b9f-dd7e-46d9-07b2-08dce6cdfab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 12:45:52.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Ig3QOupaWYDmvyvSbBaVJFPsEg9LMsTeuWSQlGu9tO0s/pY9Eb8ZAK1gQGGuYBPpQwdQeR9W26q1ZIPs/cnou6HrLINIOKNE6xRAQubIb9JGHiEm6yXTqvdYrBJnkYc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB7052

T24gMDYvMTAvMjAyNCAxMTowNCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gW+aUtuWIsOatpOmCruS7
tueahOafkOS6m+S6uumAmuW4uOS4jeS8muaUtuWIsOadpeiHqiBzaGVycnkuc3VuQG54cC5jb20g
55qE55S15a2Q6YKu5Lu244CC6K+36K6/6ZeuIGh0dHBzOi8vYWthLm1zL0xlYXJuQWJvdXRTZW5k
ZXJJZGVudGlmaWNhdGlvbu+8jOS7peS6huino+S4uuS7gOS5iOi/meS4gOeCueW+iOmHjeimgeOA
gl0NCj4NCj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGlu
c3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBh
dHRhY2htZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4NCj4NCj4NCj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+PiBGcm9tOiBDYXRhbGluIFBvcGVzY3UgPGNhdGFsaW4ucG9w
ZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4+IFNlbnQ6IEZyaWRheSwgT2N0b2JlciA0LCAy
MDI0IDc6MzYgUE0NCj4+IFRvOiBBbWl0a3VtYXIgS2Fyd2FyIDxhbWl0a3VtYXIua2Fyd2FyQG54
cC5jb20+OyBOZWVyYWogU2FuamF5IEthbGUNCj4+IDxuZWVyYWouc2FuamF5a2FsZUBueHAuY29t
PjsgbWFyY2VsQGhvbHRtYW5uLm9yZzsNCj4+IGx1aXouZGVudHpAZ21haWwuY29tOyByb2JoQGtl
cm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHAu
emFiZWxAcGVuZ3V0cm9uaXguZGUNCj4+IENjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwu
b3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+PiBrZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBtLmZlbHNjaEBwZW5ndXRyb25peC5kZTsgYnNwLQ0KPj4gZGV2ZWxvcG1lbnQu
Z2VvQGxlaWNhLWdlb3N5c3RlbXMuY29tOyBDYXRhbGluIFBvcGVzY3UNCj4+IDxjYXRhbGluLnBv
cGVzY3VAbGVpY2EtZ2Vvc3lzdGVtcy5jb20+DQo+PiBTdWJqZWN0OiBbUEFUQ0ggMi8yXSBCbHVl
dG9vdGg6IGJ0bnhwdWFydDogaW1wbGVtZW50IHBvd2VydXAgc2VxdWVuY2UuDQo+Pg0KPj4gTlhQ
IGJsdWV0b290aCBjaGlwIHNoYXJlcyBwb3dlciBzdXBwbHkgYW5kIHJlc2V0IGdwaW8gd2l0aCBh
IFdMQU4gY2hpcC4NCj4+IEFkZCBzdXBwb3J0IGZvciBwb3dlciBzdXBwbHkgYW5kIHJlc2V0IGFu
ZCBlbmZvcmNlIHBvd2VydXANCj4+IHNlcXVlbmNlOg0KPj4gMS4gYXBwbHkgcG93ZXIgc3VwcGx5
DQo+PiAyLiBkZWFzc2VydCByZXNldC9wb3dlcmRvd24NCj4gSGkgQ2F0YWxpbiwNCj4NCj4gRm9y
IE5YUCBXSUZJL0JUIGNoaXAsIFdJRkkgYW5kIEJUIHNoYXJlIHRoZSBvbmUgUERuIHBpbiwgd2hp
Y2ggbWVhbnMgdGhhdCBib3RoIHdpZmkgYW5kIEJUIGNvbnRyb2xsZXIgd2lsbCBiZSBwb3dlcmVk
IG9uIGFuZCBvZmYgYXQgdGhlIHNhbWUgdGltZS4gU28geW91IGNvbnRyb2wgdGhpcyBwaW4gaW4g
dGhlIEJUIGRyaXZlciBwcm9iZSBhbmQgcmVtb3ZlIGZ1bmN0aW9uIHdpbGwgZGlyZWN0bHkgYnJl
YWsgdGhlIHdpZmkgZnVuY3Rpb24gSSB0aGluay4NCg0KSGkgU2hlcnJ5LA0KDQpJIGtub3cgYW5k
IHRoYXQncyB3aHkgSSdtIHVzaW5nIHJlc2V0IGNvbnRyb2wgYW5kIG5vdCBncGlvLi4uIFJlc2V0
IA0KY29udHJvbCBhcmUgcmVmY291bnRlZCwgZ3Bpb3MgYXJlIG5vdC4gU28sIGJhc2ljYWxseSB3
ZSBjYW4gdXNlIG9uZSANCnJlc2V0IGNvbnRyb2wgc2hhcmVkIGJ5IGJsdWV0b290aCBhbmQgd2xh
biBkcml2ZXJzLCBlYWNoIGRyaXZlciBjYW4gDQpvcGVyYXRlIGluZGVwZW5kZW50bHkgZnJvbSBv
dGhlciBhcyBsb25nIGFzIHRoZXkgaW1wbGVtZW50IHRoZSBwb3dlcnVwIA0Kc2VxdWVuY2UgKHNo
YXJlZCBzdXBwbHkgYW5kIHJlc2V0IHBpbikgYW5kIGRvd25sb2FkIHRoZWlyIHNwZWNpZmljIA0K
ZmlybXdhcmUgKGNvbWJvIGZpcm13YXJlIG5vdCB1c2VkKS4gQXMgbG9uZyBhcyBvbmUgZHJpdmVy
IGlzIGZ1bmN0aW9uYWwsIA0KdGhlIGNoaXAgc3VwcGx5IGFuZCByZXNldCBpcyBub3QgYXNzZXJ0
ZWQuIFNvLCB5b3UgY2FuIGxvb2sgYXQgdGhlIA0KZHJpdmVycyBhcyB1c2VycyBvZiBzaGFyZWQg
cmVzb3VyY2VzIChzdXBwbHkgYW5kIHJlc2V0KS4NCg0KPg0KPj4gU2lnbmVkLW9mZi1ieTogQ2F0
YWxpbiBQb3Blc2N1IDxjYXRhbGluLnBvcGVzY3VAbGVpY2EtZ2Vvc3lzdGVtcy5jb20+DQo+PiAt
LS0NCj4+ICAgZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMgfCAxOCArKysrKysrKysrKysr
KysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMgYi9kcml2ZXJzL2JsdWV0b290
aC9idG54cHVhcnQuYw0KPj4gaW5kZXggNGY0OTNiZTc2M2I4Li5lNThlN2FjNzk5OWYgMTAwNjQ0
DQo+PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYw0KPj4gKysrIGIvZHJpdmVy
cy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4+IEBAIC0xNiw2ICsxNiw4IEBADQo+PiAgICNpbmNs
dWRlIDxsaW51eC9jcmM4Lmg+DQo+PiAgICNpbmNsdWRlIDxsaW51eC9jcmMzMi5oPg0KPj4gICAj
aW5jbHVkZSA8bGludXgvc3RyaW5nX2hlbHBlcnMuaD4NCj4+ICsjaW5jbHVkZSA8bGludXgvcmVn
dWxhdG9yL2NvbnN1bWVyLmg+DQo+PiArI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQo+Pg0KPj4g
ICAjaW5jbHVkZSA8bmV0L2JsdWV0b290aC9ibHVldG9vdGguaD4NCj4+ICAgI2luY2x1ZGUgPG5l
dC9ibHVldG9vdGgvaGNpX2NvcmUuaD4NCj4+IEBAIC0xODgsNiArMTkwLDcgQEAgc3RydWN0IGJ0
bnhwdWFydF9kZXYgew0KPj4NCj4+ICAgICAgICBzdHJ1Y3QgcHNfZGF0YSBwc2RhdGE7DQo+PiAg
ICAgICAgc3RydWN0IGJ0bnhwdWFydF9kYXRhICpueHBfZGF0YTsNCj4+ICsgICAgIHN0cnVjdCBy
ZXNldF9jb250cm9sICpwZG47DQo+PiAgIH07DQo+Pg0KPj4gICAjZGVmaW5lIE5YUF9WMV9GV19S
RVFfUEtUICAgIDB4YTUNCj4+IEBAIC0xNDU4LDYgKzE0NjEsNyBAQCBzdGF0aWMgaW50IG54cF9z
ZXJkZXZfcHJvYmUoc3RydWN0IHNlcmRldl9kZXZpY2UNCj4+ICpzZXJkZXYpICB7DQo+PiAgICAg
ICAgc3RydWN0IGhjaV9kZXYgKmhkZXY7DQo+PiAgICAgICAgc3RydWN0IGJ0bnhwdWFydF9kZXYg
Km54cGRldjsNCj4+ICsgICAgIGludCBlcnI7DQo+Pg0KPj4gICAgICAgIG54cGRldiA9IGRldm1f
a3phbGxvYygmc2VyZGV2LT5kZXYsIHNpemVvZigqbnhwZGV2KSwgR0ZQX0tFUk5FTCk7DQo+PiAg
ICAgICAgaWYgKCFueHBkZXYpDQo+PiBAQCAtMTQ4NSw2ICsxNDg5LDE2IEBAIHN0YXRpYyBpbnQg
bnhwX3NlcmRldl9wcm9iZShzdHJ1Y3Qgc2VyZGV2X2RldmljZQ0KPj4gKnNlcmRldikNCj4+DQo+
PiAgICAgICAgY3JjOF9wb3B1bGF0ZV9tc2IoY3JjOF90YWJsZSwgUE9MWU5PTUlBTDgpOw0KPj4N
Cj4+ICsgICAgIG54cGRldi0+cGRuID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9z
aGFyZWQoJnNlcmRldi0NCj4+PiBkZXYsIE5VTEwpOw0KPj4gKyAgICAgaWYgKElTX0VSUihueHBk
ZXYtPnBkbikpDQo+PiArICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKG54cGRldi0+cGRuKTsN
Cj4+ICsNCj4+ICsgICAgIGVyciA9IGRldm1fcmVndWxhdG9yX2dldF9lbmFibGUoJnNlcmRldi0+
ZGV2LCAidmNjIik7DQo+PiArICAgICBpZiAoZXJyKSB7DQo+PiArICAgICAgICAgICAgIGRldl9l
cnIoJnNlcmRldi0+ZGV2LCAiRmFpbGVkIHRvIGVuYWJsZSB2Y2MgcmVndWxhdG9yXG4iKTsNCj4+
ICsgICAgICAgICAgICAgcmV0dXJuIGVycjsNCj4+ICsgICAgIH0NCj4+ICsNCj4gTm93IGluIE5Y
UCBsb2NhbCByZXBvLCB0aGUgUERuIHBpbiBoYXMgYmVlbiBjb250cm9sbGVkIGJ5IHRoZSBjb3Jy
ZXNwb25kaW5nIHdpZmkgUENJZS9TRElPIGNvbnRyb2xsZXIsIHNvIHdlIHdvbid0IGFkZCB0aGUg
dmNjLXN1cHBseSBhbmQgcmVzZXQtZ3Bpb3MgcHJvcGVydGllcyBmb3IgdGhlIEJUIGRyaXZlciwg
c2VlbXMgdGhlIGNvZGUgaGVyZSB3aWxsIHJldHVybiBlcnIgaWYgbm8gdmNjLXN1cHBseSBhbmQg
cmVzZXQtZ3Bpb3MgcHJvcGVydGllcyBwcm92aWRlZCwgd2hpY2ggd2lsbCBicmVhayB0aGUgQlQg
ZHJpdmVyIHByb2JlLg0KSWYgeW91IGxvb2sgY2xvc2VseSwgdGhlIGdwaW8gaXMgb3B0aW9uYWwg
YW5kIHRoZSBzdXBwbHkgd2lsbCByZXR1cm4gYSANCmR1bW15IGlmIG5vbmUgaXMgZGVjbGFyZWQg
aW4gdGhlIERULiBTbywgdGhpcyBjaGFuZ2Ugd29uJ3QgYnJlYWsgYW55dGhpbmcuDQo+IEJlc3Qg
UmVnYXJkcw0KPiBTaGVycnkNCj4NCj4+ICAgICAgICAvKiBJbml0aWFsaXplIGFuZCByZWdpc3Rl
ciBIQ0kgZGV2aWNlICovDQo+PiAgICAgICAgaGRldiA9IGhjaV9hbGxvY19kZXYoKTsNCj4+ICAg
ICAgICBpZiAoIWhkZXYpIHsNCj4+IEBAIC0xNDkyLDYgKzE1MDYsOCBAQCBzdGF0aWMgaW50IG54
cF9zZXJkZXZfcHJvYmUoc3RydWN0IHNlcmRldl9kZXZpY2UNCj4+ICpzZXJkZXYpDQo+PiAgICAg
ICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4+ICAgICAgICB9DQo+Pg0KPj4gKyAgICAgcmVz
ZXRfY29udHJvbF9kZWFzc2VydChueHBkZXYtPnBkbik7DQo+PiArDQo+PiAgICAgICAgbnhwZGV2
LT5oZGV2ID0gaGRldjsNCj4+DQo+PiAgICAgICAgaGRldi0+YnVzID0gSENJX1VBUlQ7DQo+PiBA
QCAtMTUwOSw2ICsxNTI1LDcgQEAgc3RhdGljIGludCBueHBfc2VyZGV2X3Byb2JlKHN0cnVjdCBz
ZXJkZXZfZGV2aWNlDQo+PiAqc2VyZGV2KQ0KPj4NCj4+ICAgICAgICBpZiAoaGNpX3JlZ2lzdGVy
X2RldihoZGV2KSA8IDApIHsNCj4+ICAgICAgICAgICAgICAgIGRldl9lcnIoJnNlcmRldi0+ZGV2
LCAiQ2FuJ3QgcmVnaXN0ZXIgSENJIGRldmljZVxuIik7DQo+PiArICAgICAgICAgICAgIHJlc2V0
X2NvbnRyb2xfYXNzZXJ0KG54cGRldi0+cGRuKTsNCj4+ICAgICAgICAgICAgICAgIGhjaV9mcmVl
X2RldihoZGV2KTsNCj4+ICAgICAgICAgICAgICAgIHJldHVybiAtRU5PREVWOw0KPj4gICAgICAg
IH0NCj4+IEBAIC0xNTQwLDYgKzE1NTcsNyBAQCBzdGF0aWMgdm9pZCBueHBfc2VyZGV2X3JlbW92
ZShzdHJ1Y3QNCj4+IHNlcmRldl9kZXZpY2UgKnNlcmRldikNCj4+ICAgICAgICB9DQo+PiAgICAg
ICAgcHNfY2xlYW51cChueHBkZXYpOw0KPj4gICAgICAgIGhjaV91bnJlZ2lzdGVyX2RldihoZGV2
KTsNCj4+ICsgICAgIHJlc2V0X2NvbnRyb2xfYXNzZXJ0KG54cGRldi0+cGRuKTsNCj4+ICAgICAg
ICBoY2lfZnJlZV9kZXYoaGRldik7DQo+PiAgIH0NCj4+DQo+PiAtLQ0KPj4gMi4zNC4xDQo+Pg0K
DQo=
