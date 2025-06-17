Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010032.outbound.protection.outlook.com [52.101.84.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903FF218AA0;
	Tue, 17 Jun 2025 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153969; cv=fail; b=aBeMfkg0yz2OmACrVyLax3qQvtft9WWvdwEUueaHGDbthg3YtXtTR0RrxG04eVdIZ8j3Xmrz5BKPWIdXqaRo2Z0jM6yYUetsQDSUe6qS2IiO/vYUKisLnWlOOPsvK8HTgW6qB4usQPAXAWyJH7ERkx4oaZa6p8Wm+JTbfGomF9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153969; c=relaxed/simple;
	bh=67ICjblqArcA+lU1ofot0JnB1FWafqbChH10zVB7L2E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q1d4JWwxOiyF07GUkwNKbapCulYE81G4PLxnvP5NQKpNJlym0jiM48F1QYmPbCA/kiSbO4pNWIy4uPxqUhxYxArKLLiUf+v4XdKQTJ4i1gY3gfqhs1eFCSpmexsS0ErTVXwQAYs7i9+sNeODLR5d8RTIrWpTk8rYezNdlbARHNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UrmGc9RZ; arc=fail smtp.client-ip=52.101.84.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UrmGc9RZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyQHBUZt+lOKFI3XAck3T27N+vSVlNYDjnb0S3Vpczhb2KQM23iXklpCKXtvyQv0hzpNzDb/niHXFRNqOtIhcyVGHVXnXj6z/NCp1TbM51iJ5bjGZPCRhwW7/Ewc/ak6eYVnf16O2f+aR7bwiVQxpiiPjS2NkKJwr4fcWXvq9M2p8Gx+CNWzVoOTKZp2667QVmRfxNHluuewAjtDek/dq6TJpMISm5ygInhP+BSWUyeXbwQA+0MJfdNgB1eAtBA1zWcLbFGHGUxjzWmdKbDCEdzmOLtLX+7PXhnV9zbM7NMANdrrzx6yFZx+qFBlCQooiciGPHUKwVPBO48sjzZrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67ICjblqArcA+lU1ofot0JnB1FWafqbChH10zVB7L2E=;
 b=WxxCc1BPhtPD8IBvuD2lwpVsXD5vmAoiT7tjkvEoYUpRZxmMSPUP0fJ752zO4Bj8ik7tB08fT0Nwn8giTgUDYQL8Ejk8yVsxG7NjrHvc2oY/rzukNsgNXovtRGU+75qGm831gMPhGuL6v1w2XSOiNwjRiKRcR58evQ8jqrx+xC0HKDVXDG1YgTmklKnkgrZlMouWyWJ6Xtw9vLGXqpD5gjcTNSKkFviHqh5kiiN/Ipo7wgRaIv8p7D7WarLvu9HS0k2puFDwBkq3Z+sqnTkcRuyb8dEGwYGtsYRXc2cBBPK9y3YS6Q1NUUvOv9tg+aZr4MjRpuEmEg6SyZGxDgWYmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67ICjblqArcA+lU1ofot0JnB1FWafqbChH10zVB7L2E=;
 b=UrmGc9RZEbAWoqv/9Z+tb1oxC1gchO25IFJlWyL2Dfyixlws/3qfFKf6gYN9VRTlYpIKv2WLh3dpuCRhzU9bmlNT5/cGlylUAUssomX1SfGc9XmoSIlanIhWpNV0pedT5vSKuXLMET532fFElipyBOvL05Tg1co9SvMl3ir+xK7daAYsw4sS3HXBAIFwenlK9ww9GBEt7MVMk161g3I/5DPJ6N6453Si/Ve3YcM1bd57AsKQXwGlcGN0KZ7c4CNs4ccTWZE0moBLH7bzqcag6ZLLJBHNlMiblHaj4wyEVYF18EnvNBTNfFydRTYmVbvyPaMspURotdshM56hamNtDA==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DU4PR04MB10765.eurprd04.prod.outlook.com (2603:10a6:10:593::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 09:52:43 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 09:52:43 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Manjeet Gupta
	<manjeet.gupta@nxp.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 4M baudrate
Thread-Topic: [PATCH v1 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 4M baudrate
Thread-Index: AQHb322SN2g+bQpZlE+DeI96xWdmaw==
Date: Tue, 17 Jun 2025 09:52:43 +0000
Message-ID:
 <AS4PR04MB9692790DAB0B376EA0F6B279E773A@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250616150919.8821-1-neeraj.sanjaykale@nxp.com>
 <e15f4d39-379d-436f-b401-36f5b3f6f010@kernel.org>
In-Reply-To: <e15f4d39-379d-436f-b401-36f5b3f6f010@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|DU4PR04MB10765:EE_
x-ms-office365-filtering-correlation-id: d5108a19-eaeb-4549-d3d6-08ddad84b4a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ti9RY2JVZlFHd2dOeU9WaUdrclpsQUFhaUlEeDhqSXpLTUxuZkRMQktEVmxY?=
 =?utf-8?B?OWtQOEgzWVExRnpSamYzVnhNY0ZoU2lyaktDdFowTXhWZ2w0aFJ5czBBc2hT?=
 =?utf-8?B?cG53dmhXRVREK2kvSUFLRWhYZHRZazRVUzUyK3ZOdTZPU3N6c0kvY011Sysx?=
 =?utf-8?B?V0paTldqeithK21LV2s5TWVFdnBldzJXdW1Xbk9FZCtwd0hwUUhxYnRsQ3Mv?=
 =?utf-8?B?K1E1eXN5akhYOXhMcGlqQTNlZWF3aWcwTEpYekJ5bDc5NCtFSThPOFFMdVJx?=
 =?utf-8?B?VkVzbEo3ODlvdmd1a2J6SjlsS0RteVc1RWlDTEN0Yjh1NTFQWEU5amkyZmls?=
 =?utf-8?B?elpsYnYvbXRJTmw4OGVEaWNGRFpmZ0ZrL3ExeGN5dU5rcVBxNFFFOXV6cVpu?=
 =?utf-8?B?dzhkcmdmaU4wVmNTdGZlMHFWL2IybHQrc0toOWJuQWN6WVh0OTlYVUdzMVRn?=
 =?utf-8?B?TUxYVFpObnVkaEIwQ3FIbWZjYlpwbHB6c1E0RGRvQ3FWVWNnd3Y0WmV0eVE1?=
 =?utf-8?B?dUNFb21jeWk0aDE2akw1VUU3R3ZJKzZ3VnZaMzQ2VVZnMXJqenNybXlrNktt?=
 =?utf-8?B?czlZQzFFcFRJZlVDWURwVDRsZzQ2QmkvTHJWZXVua0wyMmxuOFY5U2x0MW4r?=
 =?utf-8?B?aTYvLzhBWUg2ZXlEeUQyT2pmVlltamEwY2FsTy9pc2dzNGwwbCsreGVpNGZx?=
 =?utf-8?B?d2h5d1NYS2w1SXBkTGdWNFdUdGhLRHdobXVBMDBiTURWTnFNQW1YREJhUGNW?=
 =?utf-8?B?YjAvZHNZMVVhS1pUZ1p0cllZVnJuSlZDWTRobFpFUS91Rm4zS2JFOXlxaHdU?=
 =?utf-8?B?TUFRa3haUDE3MmF4SjluRzJlV2M2TlE4Qm8vZDl0Zkc2NW8xVDQ3bUtHbGEx?=
 =?utf-8?B?M0JQNGVMQmhnOHVtdUxybmxaOE9HNWpOWVpuM1FYUGZ2Z1J3SnNrNlh1L01G?=
 =?utf-8?B?WUx4dmZjTnZ2dnoyaEdGck5IYjRuQ2RTMit3d3JLcnkvOTZKZGZ2TFlobG5a?=
 =?utf-8?B?aHZ6WHJpeEVFVmlmd2NEdlBnUitxelM0V1FWYmlqNTRnd1dEV1N5OWZPeVNR?=
 =?utf-8?B?ZXVKODM2N0t4cHBSbVdxUU45dDJvcExCaHI4VTZHVzB5N2RRcU1XR01FdFQx?=
 =?utf-8?B?QlE1OG5DMzZhUHBpWGpOUnFlTUREcU5seUVSeW5La1FTQnB0WFlHRjJuRVo0?=
 =?utf-8?B?YWFITFhJSHNudnh2cDJTbE5VWE4wcE9wVHlrYUpFeXhkMmhWSU04aDBaWWZv?=
 =?utf-8?B?cE1SS3VrZEQrN0NsOTR2WUpCOEtDUHduTGlvSSs2cVVNamlpZzVLbDhhMWR6?=
 =?utf-8?B?QU1DazV0ZmZXM082MlBhS1BTK2graTdjV3hNWXJFVmxsMUE2QWZ2U1kwMWo0?=
 =?utf-8?B?aHByRGtoaFFQWjE1WVJOSG1LSXFrRUk5OUo3T0xSTUxaV2Rrb3F5MDB5RzhH?=
 =?utf-8?B?eWprTEoyWFZoOE9BWnhZN2Z6S3BmektZb3FqaGVhOWhxbzJwbHErRk5HeGRL?=
 =?utf-8?B?Ym1XenQvSUZscDRrYUlxRzNuMHlteTZ5TVdSU05XN3pxSTBWQUxuemVVWUZp?=
 =?utf-8?B?UjE1TVVDcUhXcjZNa2VsbFpqOC9vTlpKQzRUaHRVUGtocGFNUW1MNTRJcmJW?=
 =?utf-8?B?MW9vam80RUQ0dFd0RUxoeUZiWk5scTJsbEdtbzFoZlQ5endmZzV4cTE2RWlR?=
 =?utf-8?B?THpTWjNBSFk4RUdRVVVvZGoxN0JpTWVlQWZtdG5WSzlQWTllb1c4SU4vUUlk?=
 =?utf-8?B?Tm9MZEtGV0RZVkoxMWhpWWswazNPTHF0WjBTTDJ5YUVOekFwd3ZJdVhtVGdv?=
 =?utf-8?B?OWdBQXJ4cXpBUzNBQmhjb2U4R3BIY2RmRy9vUEpkeWVWVnByMHgyUjJXVXhk?=
 =?utf-8?B?WFJ1TUpKTWd4T3VoQTl6dHNzME0vQVBMMWkwY3VzYkRQbVVmajlWYVF6MSs3?=
 =?utf-8?B?U0UxWXFCWFdXQlZwRlJ3ek9wbTlWWVFlZE1UR2VyYzlJcjVYZHZ4TVlJR1hZ?=
 =?utf-8?B?SGppNnlKOWdRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M3JtRWJ6QkVMWnpUWjFITGdLTFFaSFJlL1BROExhdnJuLzVZdE5PUW55NkI0?=
 =?utf-8?B?KzhkQy9QMmNaWlpQM0MxZHVuZ3F4cjRUTHFZMnQreWlPL1pCOVFTNG5STGw3?=
 =?utf-8?B?dkhIWVRjcWdQaHlOOTZDb2s5OXgvOE13MjIrMXVIRnJFZzBrT21NUVhVcW5T?=
 =?utf-8?B?cmwxZDRKNm5xbU41MWNKMG8raEdOTzZUZlh0RTFxcDR1TDVIWE9zQkhITEtQ?=
 =?utf-8?B?d2hLakljOEZEOXErejhmbENQTHJrMXpianZoK2Y0eFozT0s3NFQ4TXUzK3c5?=
 =?utf-8?B?QWxIaEtoU1FFd0FSYk5ZdVFPTWsraERmS1VyL1VSYzY5ZGx3clErVmZwWnZ2?=
 =?utf-8?B?bEl0bk41YTU5UW5xNjdSSXk2M0QzeUgwRGV2WWhtcjVwM3ZZZGlsTXowbTFN?=
 =?utf-8?B?dThCSGczeXdVdnladlV6eWQyWGxvMFlONHNMZldJa1E1YSs2bUt2aU52TFl0?=
 =?utf-8?B?MThUcTFoVTkzaGNML1cwSGxhUURKd1JUZDFNdXRjZUllWEFuTnQ1TU1xeXNK?=
 =?utf-8?B?Vm5xNzRCeVp0cjh3bWVoWkkvd1NkL3hKQ3FLd0xlYWhZdUN4bmZ5RTl0ZUpB?=
 =?utf-8?B?SlJoT0drWXVMRGhJMnR1eXFQMG42NFhQVXdEc0RJQXJ5cFBIMmVObE4yanR2?=
 =?utf-8?B?QnZHakF5Vk5DZnhnTkRTbjBRcS9VZXRqR0p4czB3YWF6SzAyVjRrYTNDeGUz?=
 =?utf-8?B?U01jeGczdkJ0WG1Md1RjU2hBNG1sSVhCaTFENnk2WUZoc3ZWVUdkQSthazkz?=
 =?utf-8?B?eXBVcG84ZnJaM1hnVXlOY1JDNndRZndYaXpGZWhad1ZiTTBkVXJBaS9hMFVr?=
 =?utf-8?B?K2wrejBaMHc4NWRpY21od3dGVnNscFk3RDlPOVVQWnFXN1JNZmlJUjlDWmFj?=
 =?utf-8?B?eXlhaTM0TXVSbG5rZ1dSVzlWM1k5b05YRHRvb2E5WCthc3BVMVVTRzUzQ1hX?=
 =?utf-8?B?cGl4VURzRW1vSEJ2NStuYzE3bEQ1NEJXL3B4RFJPelRSK3dpU3g0eTNSelNB?=
 =?utf-8?B?SGpYQVEvL2Z4bkFMWk1MaTdRUWUvYTZ0OFRFMW54dm8wTnJyQmRVMmY0NkZZ?=
 =?utf-8?B?b2JXUXhyK2YvdGJqNGJ4R2ZFTVRaeVY3Y2U0R3RSZkxBYjNyWEZWbFh5eGY3?=
 =?utf-8?B?eFpHMW9hUWFpYnZlYXIreVUyaWhUcHZRU21zQk1GMk5KZjlnQVB0YnZ2Z0xm?=
 =?utf-8?B?czlsNmU1S0h0TUZqSjFSYTU1ek13blpxSlZ0SUdWUHllUElNS29XbmV3SE14?=
 =?utf-8?B?R3A1dEFMVUVIeGJGWXlFNTlnUEVWYkVVeFk5SzJsYnh6YXJFa1NpTkd6QkNx?=
 =?utf-8?B?RnkzdHQ5TVNQRmtMQVZ4UlZZY05GY1REcjRTOEY4TGhpRWFERWFxRUxpa1dx?=
 =?utf-8?B?RUY2enVSbG8yWFBsWWFVWWFiaDdncCtZc3piYlVEcVhFZCsvYWMxakozclZa?=
 =?utf-8?B?NHd3SlZyK1VVcGI1SXY2Um42ZTd2RzlHQkJmMEVnbWZhTTlpRDRtV3lrSGVK?=
 =?utf-8?B?MTMwZHlLZitIcFFFUVF6M1VBK2Nhb2ZFUWJFVnF5R0wyVC9lVmEyZ0Y3RlNG?=
 =?utf-8?B?QXFiSUdyWDNCK0lyVHNBV29tZU5YQUVHejdwN2xDN1FZeVNINUlLZEtiU3By?=
 =?utf-8?B?WTlZU2JLTTNRekVJRFlsTjRYb0dBYnZiVUNSTnBVWGl6VVVwakFWWkFBTmVV?=
 =?utf-8?B?RzZRaGpiV1E3enZ6SnU1dUtYZnpKMzZIT0tCT2RGSjdtS1RENXh6RFNuaVcy?=
 =?utf-8?B?STBsdG9ma3BOZDluNnVnTCt3ai9GempQUUdjYVdMRzZCVElaM2F0NlkwTkdv?=
 =?utf-8?B?VjN1ZzVnQ2hMMmRZd2dqaGRYd1dPdjFrdWp0OGp2MGo1WEV2UzYzN2N0Qkg5?=
 =?utf-8?B?UFFFdU94UmVxZm0yZHNiK2RVNkV1UTdlczVnbTdKRHQ4cXVQKzFyMDJUQWFV?=
 =?utf-8?B?QUthdml3ZFZTL3UxQTlEM1VrN3JVS1hldkdHYjRQY0VBZzl4SnJnTmtsOW40?=
 =?utf-8?B?dXlQeVU2TXdUbzl5M2hTazBjWXBBN1hpNWFQS0JuYzRYTkNQcHBJWXRYYmt3?=
 =?utf-8?B?eHlkUVdLTXJPcXJMWWpBNkFLVkh6WFRzTWIvU2RRVFBKZjZVQWEvSk9GdjB2?=
 =?utf-8?Q?2M/2V+6ZAzC9hKktNbOvhqTvk?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5108a19-eaeb-4549-d3d6-08ddad84b4a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 09:52:43.4282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PznDWYJaaJEVohWI4O19b9hdeTRbSfU2eHKRmxojvq48C5KbJu9hhXpqDHbBuTmxxcYoLg4ZUDp/+5umWUmGCBWHR5yQOttnSi18nLs1kOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10765

SGkgS3J6eXN6dG9mLA0KDQpUaGFuayB5b3UgZm9yIHJldmlld2luZyB0aGUgcGF0Y2guDQoNCj4g
DQo+IE9uIDE2LzA2LzIwMjUgMTc6MDksIE5lZXJhaiBTYW5qYXkgS2FsZSB3cm90ZToNCj4gPiBB
ZGQgc3VwcG9ydCBmb3IgNDAwMDAwMCBhcyBzZWNvbmRhcnkgYmF1ZHJhdGUgZm9yIGRvd25sb2Fk
aW5nIEZXDQo+ID4gY2h1bmtzIGFuZCBhZnRlciBIQ0kgaW5pdGlhbGl6YXRpb24gaXMgZG9uZSBh
dCBmdy1pbml0LWJhdWRyYXRlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogTmVlcmFqIFNhbmph
eSBLYWxlIDxuZWVyYWouc2FuamF5a2FsZUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmlu
ZGluZ3MvbmV0L2JsdWV0b290aC9ueHAsODh3ODk4Ny1idC55YW1sICAgICAgICAgfCAxMCArKysr
KysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBk
aWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2Js
dWV0b290aC9ueHAsODh3ODk4Ny1idC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvbmV0L2JsdWV0b290aC9ueHAsODh3ODk4Ny1idC55YW1sDQo+ID4gaW5kZXgg
M2FiNjBjNzAyODZmLi5mMWM3ZjkwMDAwMWMgMTAwNjQ0DQo+ID4gLS0tDQo+ID4gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2JsdWV0b290aC9ueHAsODh3ODk4Ny1idC55
YW1sDQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9ibHVl
dG9vdGgvbnhwLDg4dzg5ODctYnQueQ0KPiA+ICsrKyBhbWwNCj4gPiBAQCAtMzQsNiArMzQsMTYg
QEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgVGhpcyBwcm9wZXJ0eSBkZXBlbmRzIG9uIHRoZSBt
b2R1bGUgdmVuZG9yJ3MNCj4gPiAgICAgICAgY29uZmlndXJhdGlvbi4NCj4gPg0KPiA+ICsgIHNl
Y29uZGFyeS1iYXVkcmF0ZToNCj4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2Rl
ZmluaXRpb25zL3VpbnQzMg0KPiANCj4gYmF1ZHJhdGUgaXMgaW4gc29tZSB2YWx1ZSwgc28gdXNl
IHVuaXQgc3VmZml4IGZyb20gcHJvcGVydHktdW5pdHMgYW5kIGRyb3AgdGhlDQo+IHJlZi4NCklu
IHByb3BlcnR5LXVuaXRzLnlhbWwsIEkgY2FuIHNlZSAiLWJwcyIgd2l0aCByZWYgdHlwZSB1aW50
MzIuDQpJIHdpbGwgY2hhbmdlIHRoaXMgcHJvcGVydHkgdG8gInNlY29uZGFyeS1iYXVkcmF0ZS1i
cHMiIGFuZCBkcm9wIHJlZiBpbiB2MiBwYXRjaC4NCg0KPiANCj4gQW5kIHRoZW4geW91IHdpbGwg
c2VlIHRoYXQgaXQgY291bGQgYmUgYWN0dWFsbHkgYW4gYXJyYXksIHNvIHdoeSBub3QgdXNpbmcN
Cj4gZXhpc3RpbmcgcHJvcGVydGllcz8gT3RoZXJ3aXNlIHlvdSB3aWxsIGFkZCBzb29uICJ0ZXJ0
aWFyeSIgZXRjPw0KPiBUaGlzIGRvZXMgbm90IHNjYWxlLg0KPiANCg0KVGhlcmUgd29uJ3QgYmUg
YSB0ZXJ0aWFyeSBiYXVkcmF0ZSBhcyBmYXIgYXMgSSBrbm93LiANCkFsc28sIGlmIHdlIHJlbW92
ZSB0aGUgZXhpc3RpbmcgZnctaW5pdC1iYXVkcmF0ZSBwcm9wZXJ0eSB0byBjb21iaW5lIGZ3LWlu
aXQtYmF1ZHJhdGUgYW5kIHNlY29uZGFyeSBiYXVkcmF0ZSBpbiBhbiBhcnJheSwgaXQgd291bGQg
Y2F1c2UgYmFja3dhcmQgY29tcGF0aWJpbGl0eSBpc3N1ZXMgZm9yIGV4aXN0aW5nIGN1c3RvbWVy
cy4NCg0KTGV0IG1lIGV4cGxhaW4gdGhlIG9iamVjdGl2ZSBoZXJlLg0KVGhlIE5YUCBCVCBjaGlw
IHdpbGwgcG93ZXItb24gYW5kIGJvb3Rsb2FkZXIgd2lsbCBhbHdheXMgY29uZmlndXJlIGl0IGF0
IDExNTIwMCBiYXVkcmF0ZSwgZXZlbiBmb3IgdGhlIHBsYW5uZWQgZnV0dXJlIGNoaXBzZXRzLg0K
VGhlIGRyaXZlciB3aWxsIHJlYWQgY2hpcCBzaWduYXR1cmUgYW5kIGZsYWdzIHRvIHNlbGVjdCB0
aGUgY2hpcCBzcGVjaWZpYyBGVyBmaWxlIGFuZCBzZXQgdGhlIGNoaXAgYmF1ZHJhdGUgdG8gYSBo
aWdoZXIvc2Vjb25kYXJ5IGJhdWRyYXRlIGZvciB0aGUgYWN0dWFsIEZXIGRvd25sb2FkLg0KDQpP
bmNlIEZXIGRvd25sb2FkIGlzIGNvbXBsZXRlLCBGVyB3aWxsIGluaXRpYWxpemUgYW5kIGJhc2Vk
IG9uIG1vZHVsZSB2ZW5kb3IncyBPVFAgc2V0dGluZyBzZXQgdGhlIGNoaXAncyBVQVJUIGJhdWRy
YXRlIHRvICJmdy1pbml0LWJhdWRyYXRlIi4NCkhDSSBpbml0aWFsaXphdGlvbiB3aWxsIGhhcHBl
biBhdCB0aGlzIGZ3LWluaXQtYmF1ZHJhdGUsIGFuZCBwb3N0LWluaXQsIGRyaXZlciB3aWxsIHNl
dCBjaGlwIGJhdWRyYXRlIHRvIGhpZ2hlci9zZWNvbmRhcnkgYmF1ZHJhdGUgZm9yIG5vcm1hbCBv
cGVyYXRpb24uDQoNCkN1cnJlbnRseSwgdGhpcyBoaWdoZXIvc2Vjb25kYXJ5IGJhdWRyYXRlIGlz
IGhhcmRjb2RlZCB0byAzMDAwMDAwIGluIGRyaXZlci4gQnV0IGlmIEJUIGNoaXAgYW5kIGhvc3Qg
cHJvY2Vzc29yIGFyZSBjbG9zZS1ieSwgb3IgbW91bnRlZCBvbiB0aGUgc2FtZSBQQ0IsIFVBUlQg
Y29tbXVuaWNhdGlvbiBhdCA0MDAwMDAwIGlzIHBvc3NpYmxlLg0KDQpUaGlzIGNhbiBiZSBhY2hp
ZXZlZCBieSBhZGRpbmcgdGhlIG5ldyBkZXZpY2UgdHJlZSBwcm9wZXJ0eSAic2Vjb25kYXJ5LWJh
dWRyYXRlLWJwcyA9IDw0MDAwMDAwPiIuDQoNCkNvbm5lY3Rpb25zIHdpdGggRlJDIGNhYmxlcyBv
ciBmbHktd2lyZXMgc2hvdyBjb21tYW5kIHRpbWVvdXQgZXJyb3JzIGF0IDQwMDAwMDAgYmF1ZHJh
dGUuDQpIZW5jZSwgd2Uga2VlcCBkZWZhdWx0IHNlY29uZGFyeSBiYXVkcmF0ZSBhcyAzMDAwMDAw
Lg0KDQpQbGVhc2UgbGV0IG1lIGtub3csIGJhc2VkIG9uIGFib3ZlIGV4cGxhbmF0aW9uIGlmIHdl
IHNob3VsZCBjaGFuZ2UgdGhlIGJhdWRyYXRlIHBhcmFtZXRlciB0byBhcnJheSBpbiBEVCBhbmQg
RHJpdmVyLg0KDQpUaGFua3MsDQpOZWVyYWoNCg0K
