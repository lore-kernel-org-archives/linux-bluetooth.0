Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2050.outbound.protection.outlook.com [40.107.20.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3291F460D;
	Thu, 20 Feb 2025 11:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052791; cv=fail; b=NDXaWETM/amhfAwfB/uoVUw0m8Ci7x2DPaP6knxJasTo7J7UfXJmyMAFM3oB7CGytc6gefOGtNDSTpPUi5leOiewAsWNLW7rdZ0jmc/Qa5DgOPECvDFZef4dcEH/vaW/ojME1eOys4llkESkAnrpXLaT0cEnxOCOGntUXKaqj74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052791; c=relaxed/simple;
	bh=i/V/0L+Q9w8+KI2dvbtZTsSWq9M5NsQTve8WlH+UYfY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DYuBgtpS3KDSdjoMcas3coge7ePmuHNSWOL5mH0GdQ6XycNMyjxOs/VuNs8d+ujloBuksr0HSR1ri2YfnO6KyPDpqIFosCMpDecS3Do/n8egIwp905MxymrnzPGoNrxUZ/v/FleExq6m6sZnQip9nD6EXvjQVwoYHM7J3J9CT1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yco3ivpF; arc=fail smtp.client-ip=40.107.20.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yco3ivpF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bghwa42Rrwxe/J8cFUjJv/UNso5YeuZfXdm6zD/PddNMEejCk0zBXtqcFDJqFyQOjn2gj6d7rnUmSTNlc/iTx5YBdAbJ1v11SaIZB8sl7GFa/QZZ+DapaG35fM15m1DP5kKUL6MtvtGRqd3wkbTaYGOXLdj7d5z8vuUGDOWif2efOAFPmrMfj6zDWDY3HkA9Dv5e+8M0r7i9Fyp30vJcESA6QDobQZjHrb1fI+rf5YxvHbTOc+nZytRfqCmnAAVYXgjDKDLMgF0vSIPebSMSr/EFSWMJE6onUXoNTp+M4kaM3uRm5SgHSQeZnqr3ZzL3Uy/dIUOn1XXlh4N7t4mA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/V/0L+Q9w8+KI2dvbtZTsSWq9M5NsQTve8WlH+UYfY=;
 b=jFy6/FMZBTIenIWDweGKCbyCSdBSgxSt4OallIj2jeh/IAPfnjVnEB97pJRlALpGoVAyeXL7uvik+hKZgJo+jJHhIcXXd89V/CQM8+FCtXzJUXNXToriLxQBfhR7+0N9qj46OdQdakx5K5VGSzjArFsWQhAx/6xTPKfrV/eym6JbcGQ+fYtBnd/MbEzGHBj4llUJYtpJl3TO0P68AR4QHIMRoyU8NhyisIsMA/QkrlBE5QnhBtNzLNNUREvPnKf9A++GhygYSqy1ocpQE4UBpOB/1Iq7CJSQDGUkmGI5A+wYfnyHpqAGuHW1AlOkL4XntkwctY/iChwpnUt4mt/qTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/V/0L+Q9w8+KI2dvbtZTsSWq9M5NsQTve8WlH+UYfY=;
 b=Yco3ivpF0nYFzxf56cwFE0U/6T93hDx+Auz9DJOy0tnhodFGwB/ckTv0FgK9zDq/GguyG1RBzmFFtQq4W6wCdNcDPCTWM2sZGXNNYE8w/gpX5vef6Z7eVDjX92wLaHniMZvzJrRNevbwstnl0CZTHjjkiTYCGuDkfLxLZIEej2ujFHZ9+WjmWqSqCv9yXuInzwI4xO6W3+nsqvgGZwNLXYqrKTW5+65pjwRt779aNfcSK37Tk7Ns2FADfAu94qWmgqNGPLkbW4ddM+jeUhTJlA6NGasyGOn4t2rJyoAl5DCY56eQb4HcrGM23gLq9yIrex9oi52Ow+J30NUJlHnrrA==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 11:59:46 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 11:59:46 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Sherry Sun <sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>,
	"johan.korsnes@remarkable.no" <johan.korsnes@remarkable.no>,
	"kristian.krohn@remarkable.no" <kristian.krohn@remarkable.no>, Manjeet Gupta
	<manjeet.gupta@nxp.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: net: bluetooth: nxp: Add support to
 set BD address
Thread-Topic: [PATCH v5 1/2] dt-bindings: net: bluetooth: nxp: Add support to
 set BD address
Thread-Index: AQHbg47v72hY/2YNMEOpidSeJW8Ifg==
Date: Thu, 20 Feb 2025 11:59:46 +0000
Message-ID:
 <AS4PR04MB96921164DAA8A63B2C0841AAE7C42@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
 <184919f9-25bd-4f65-9ed9-dc452a6f4418@molgen.mpg.de>
In-Reply-To: <184919f9-25bd-4f65-9ed9-dc452a6f4418@molgen.mpg.de>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|AM7PR04MB6789:EE_
x-ms-office365-filtering-correlation-id: c384af72-4ef5-48d4-aa37-08dd51a61229
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZndraU1qRmdkbHRNN0lCbmQrOUtzMUtqYXFTWSt6aFljM0hJNVgrbUh6THor?=
 =?utf-8?B?UTVFV2FSTnNNL0lXMHlSK1ZZV3VkczYrRjFMR3dwSlllYzVkek9IcFdqYWkr?=
 =?utf-8?B?MDRTWFYxZnVaSkFEYjlUbFhNeWFXOXZmNzZMSkJZR21sNDN3NkJtYU1kbmph?=
 =?utf-8?B?SW50YXlSampLa3o2c1RDQTNEV2daMkhmS2tFSlJNcVl4OTd4Q1NvRnB0Qjl5?=
 =?utf-8?B?TGRHMzY4Q05GcHRRR0xhWStZb0pmNjh3R2ZZZzloK0cxTGRWUVNwZ1U5M3FX?=
 =?utf-8?B?R0Iyb0RMRy9FRk5XbzdiakV4c1I5UVhFTjVpMExvWTl2S3czbkh5L3BTdEIr?=
 =?utf-8?B?RXhwK2JXb3BuK0RHZ0MxdmZlekZxY0NhNC9HOGo0NnVyQTArRENIZXBVaG1t?=
 =?utf-8?B?cmpNRGFmMzJ0VWw2NkFNd29sTlJXd1Q5bmtQLzNtRnNtM3UwM01GUEpDOUp1?=
 =?utf-8?B?N2JhTTdVUDNicnVJOGIwanF2WUt5bWVGc3VBUnNheTRBVjdpQjAvWVFzWkNz?=
 =?utf-8?B?M3ZOdlZvTnNRZjI1L1p1bTBjOEt5c1BjNGM1aCt3bnZ1WW1wS3RBSnNyY1Y5?=
 =?utf-8?B?R3gzVkl4enNHOUZKSHBEazhhdkJUMWRZMnlUZk5yZURuazdYdVU5djBQOWpP?=
 =?utf-8?B?TVNmR2h3MVI2c2R3QytNdHpCbVFXRXFVS3FZTnlMM3pzSU9ocEZJUVhqTEMy?=
 =?utf-8?B?Y3RPVHhjYXR1TzJzTW8wNUVGUlJwT29xQ2FuR1pYOE9wZWZWOTYrTS9Na3F4?=
 =?utf-8?B?Q3M3U0JOd0I5M2QxL004VFRaZHA3SnNuN3pyMk5IMnc2djV1aTJMUWh6bTBr?=
 =?utf-8?B?MmwxSU84ZE81c3BXd3pjTWdOVlB4QmVXRm5OZzc3ajF1YXZ6RU1OKy83OFJk?=
 =?utf-8?B?UlhTajh6dWVybURrb3hldGxCUkJBK2U4RHJrTGxvVWFPUlpPZmQwZmVnWTBa?=
 =?utf-8?B?RFZidC9NTUZQSmpTcE9lTnZYWS9HcHl5dEI4bitndjdYbVZOcWpsRG9jMElT?=
 =?utf-8?B?QThsU0dLSzdpY1dhKzgyTkxLNWVYelBITXpnNDVVR0doc1RSTHVIMmdVQ2hR?=
 =?utf-8?B?NCt6RzJGL2VTVE1lY0N4a2JpaWpUWExQd2JGYVpmZ0c1dUZqUVZPejBTSy9C?=
 =?utf-8?B?VDZYY25nTUpIWmczbElQa2p3SFBXQ1VWTmVXSnJHT2I2dlhzbXo1VFdyRXN3?=
 =?utf-8?B?NmtMOVp4NnpZNkw1ekpmQnpnQllBU0VON01McGVqTXpXK0VmZGZYcWlPL1Fn?=
 =?utf-8?B?a1EvWS9EelgxTklXQW5BdVVGdWpIMlBPRndvM1gzUGxGano3YWd4NDFJczBr?=
 =?utf-8?B?VlBXbk5rT3A0dEQrbXFLQTJvQW1QRDJ5ZUhoc1ZiUWdoWS9qWGg1WnYvVXFZ?=
 =?utf-8?B?V1d2SkZ1Q1MxMVVvRlMvcUxnaHduSVB0VitZaU56T1dCT1pPMWNZSVZ3ZXNp?=
 =?utf-8?B?a1RxblJTOFFITzdOYWdiZCtoVXFkT3h6bVJHOHVxQmN1Y3F0UVcwZEs0OFpu?=
 =?utf-8?B?dEpPUVYvc3ViVGZkOVNnV1NpWW1MbVN6Nyt5M3RrQjMyeEo1TzVacnA4ZXZD?=
 =?utf-8?B?WE9Wdit3RXhKcGUrNlVYSXZibWh5KzV6ZnAveitOUjBsRm9JVzZsRElqVVJW?=
 =?utf-8?B?MTNOcGZFcTM5dzlNc1NYYmd5N0VxampYOUVmR2NxVjI3cjVtc2VpeUxGRVN2?=
 =?utf-8?B?NUxSUG4rS0tOc0lrcGJKSHczVlFjZnp4WVFXL0tOZTQ0bGtOKzYveC9adjgz?=
 =?utf-8?B?MlBTdXpSWm00SDUvUHRuWVhmN2gwR1hLTDZlRXFLZk5SUkZxTnpmTTVJNUhM?=
 =?utf-8?B?NytGMTFnbnFqdGVxb2sxTWhMTFR4RmRCejM0bmJvS0NVVXJ1WlR2R1JpVUlj?=
 =?utf-8?Q?MgldkFiQpDgAE?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlBTNFZSTjF5dElvTTFFSlpLNWlzYjJUQkcrakJ3bi92OWNHRExmVEpBYUk5?=
 =?utf-8?B?MXJpTlJxNkQ2eGd6L1VNM083WXd4VVBoK2hzR0dBQU1mTGwyZE51a2ZXczlG?=
 =?utf-8?B?dU1Lc1o1MGFmSmpieWRRakkwRzBuZTZndmZycWdzNHpKTjZrQ2x1dGVLeGpN?=
 =?utf-8?B?bEtzV01BYTJzck0ycUIwYVB3Z05pUGlCTG5oc0ErSkVQRHNnbHFTRS9Kckx1?=
 =?utf-8?B?ZFF0ZWY2UUFSbmxrUDk1NTgvU1ZJK0pjY3l6TGJ1cUhNNkhFL1Q2NFZsdmx4?=
 =?utf-8?B?eFNIWDNacXdrTEJEUE40U1llM2JXL1BoOXNGREltU05YRWVOT0RkQXNZWkVI?=
 =?utf-8?B?aDA3QUloSmdzOVdyRThKbFl6YUs2M1RMN1hkVFJ6OHFDcUg4NlpiaXhxdEND?=
 =?utf-8?B?QVNCZWNhUExpTWx1blZPSkRFUElSOHZENUhnZkI0Nk1Ra3J2N2s3Mi9Vdkdm?=
 =?utf-8?B?Y0lwUFUzRTUremxNWU8wbUcxMms4NkZ6ZTcyU1E5bWNVYlE0RUdIZFpKd3Ur?=
 =?utf-8?B?L2tPZG9ObEM3TU13OGhBd2t3SFZYVTQ0V2xiZ25UZVk1VTRqYWtVa0NLVkYz?=
 =?utf-8?B?NFFZcFpIdnR1RHNUQkNhZnE5a1VyVGF1WTJVWXdUUDV1SGNwTk1YSWRPa1Bp?=
 =?utf-8?B?ZUUzSWU5SVE2MllCSzlldDZVbTVxSmRqS284My94VkRJUyswSHk1ODdORGVa?=
 =?utf-8?B?dHNCQUpkTVJUNW5xQUdFUTlWNmp5MHJXYlluOHAvL1lDbDZpVk51ZHVTL1FQ?=
 =?utf-8?B?MURBcnVuVjRTdDNqd2VDajVsTHRzc0o1TG0xU0tFMUc3dXVDTGJwV1JkMmRq?=
 =?utf-8?B?dTJCS3Q0dFFWcUJGQzVtaU82RG5zc21WdGdtQ0dtVzZKUk53WDBJdjd4UXlj?=
 =?utf-8?B?bTdiVHIyNnFQL2sxYjlVcDJEUFJrODA4aWNkSFBSZW5sZjJsTGhGS0tYMDRF?=
 =?utf-8?B?OGh0S1BrWFk4ZHdHRUhYdHVRVEZBNnVLUXFUSERDZE50ZEU2dFgyUVZGUlpY?=
 =?utf-8?B?NTFaTlZhaDJzUGJwQXZGVFcrc1drZytqWTVlejVWZUZ3dnltQ2NoWlZCWmty?=
 =?utf-8?B?b1FoYk1vYVVUZ0Mwbk5HTWw5OVZyaW01eFRjdEwzenFxVklRUnZSQnVzSjJ2?=
 =?utf-8?B?OUk1S0wyWW5Td3RheTVWRzl4NEk2QUdZTjc2S0xicEVyVjhERE5UbjVuaTdh?=
 =?utf-8?B?WDVWM25pZVVkUUVTL29nS3BtUC9waGdvRExacGIxcDhSU29qRi9BY21EM05Y?=
 =?utf-8?B?ZHUwa2RxNEFyY2tLVzZObUg5NUswZXU5NDd2am5YQUpqK1hNOFBUTXlnanNR?=
 =?utf-8?B?MXFLWVdyK3FzUXpaekRZWitEbXpaaEE4ZnJWaTdQdXJEMmMwMjJ5akpMREp1?=
 =?utf-8?B?bkRMSGNDMUsvUFFmVEY1Y3NrOEZGazkyd0d5TXVmSVBwdVFXV0JiUFdCSTB4?=
 =?utf-8?B?VVlETkpUVHBoWnRqdmlkTy9GTC81aXpIck8wYmQ2bEpvNHcySmhhQXozb3NZ?=
 =?utf-8?B?S3NaTnpxcWZOQU9XVE5kUklDOVdJVFJ2K2lwN253L3ZMS2pTUEZDYUdpcmdP?=
 =?utf-8?B?dHhlbWs1TE1rL3p3TFpOSnYwWnRUcVByVzNkeG43MUFpcllwb2h4eGp2dEJn?=
 =?utf-8?B?R015MTc5Z3kyT2tkTkVxQ0J0NjBvdlVQWm5HQXBURVF6MEE4TnJJK05iam5L?=
 =?utf-8?B?c2RLeGpRSUIyTzdkWnVSamJNUklpNFROMjdpVFBnRmoyeWlDcWs1cWZTTWV0?=
 =?utf-8?B?WU1ETWh1RjZNTHhiMSt6OFIvL1Q4a3VrZm56WStEdHROWnZoS0d1RkR1QnNC?=
 =?utf-8?B?ekd4R3R2NjFDZGlHaUxTNGFOWUVhSU9pcmYzWVMvZy9STVM0Y0wyQWZLYjhE?=
 =?utf-8?B?MnRnbHZXTC9NZklValhTTW5CV3JJWnlldHM3QlpTa3hSZlIxTlVIQkNCNHNX?=
 =?utf-8?B?YzBldEdEYzljaENqNkVRYThVb1dVb3cwQkZrQUVIdmYyOC80R3pZUnpxUGd2?=
 =?utf-8?B?b0Fsb0p5UDhIZzJaWEpmRW5GMnUvbkt5MXZEdjljRzM2ZTJhNWRyYlJGQ3BJ?=
 =?utf-8?B?V3JCcTZ2V0RjL1p4YzNMbUlsbWRGZkxCazFGdkZNR0ZFckFQQkFBRXVtS1VG?=
 =?utf-8?Q?WClicRDGr2S9jEj2Tjs4nw0HA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c384af72-4ef5-48d4-aa37-08dd51a61229
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 11:59:46.7143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aEUD7rriB+2cJu/BLSb/x1yxzZwzeUweLlpBwB40DPrgyk0NxqD/o6WxEq8JHxvWkat/PHm5rEojogmKIK7OfMF1t6IBc/UFFjok22OSF2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

SGkgUGF1bCwNCg0KVGhhbmsgeW91IHlvdXIgcmV2aWV3IGNvbW1lbnQuDQogDQo+IA0KPiBEZWFy
IE5lZXJhaiwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2guDQo+IA0KPiANCj4g
QW0gMjAuMDIuMjUgdW0gMTI6NDEgc2NocmllYiBOZWVyYWogU2FuamF5IEthbGU6DQo+ID4gQWxs
b3cgdXNlciB0byBzZXQgY3VzdG9tIEJEIGFkZHJlc3MgZm9yIE5YUCBjaGlwc2V0cy4NCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IE5lZXJhaiBTYW5qYXkgS2FsZSA8bmVlcmFqLnNhbmpheWthbGVA
bnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9m
Lmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiA+IC0tLQ0KPiA+IHYyOiBBZGQgYWxsT2YgYW5kIHVu
ZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UgKEtyenlzenRvZikNCj4gPiB2MzogRHJvcCBsb2Nh
bC1iZC1hZGRyZXNzOiB0cnVlIChLcnp5c3p0b2YpDQo+ID4gLS0tDQo+ID4gICAuLi4vZGV2aWNl
dHJlZS9iaW5kaW5ncy9uZXQvYmx1ZXRvb3RoL254cCw4OHc4OTg3LWJ0LnlhbWwgICB8IDYgKysr
KystDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+ID4NCj4gPiBkaWZmIC0tZ2l0DQo+IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC9ibHVldG9vdGgvbnhwLDg4dzg5ODctYnQueWFtbA0KPiBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvYmx1ZXRvb3RoL254cCw4OHc4OTg3LWJ0LnlhbWwNCj4g
PiBpbmRleCAwYTJkN2JhZjVkYjMuLmE4NGMxYzIxYjAyNCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2JsdWV0b290aC9ueHAsODh3ODk4Ny0N
Cj4gYnQueWFtbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9u
ZXQvYmx1ZXRvb3RoL254cCw4OHc4OTg3LQ0KPiBidC55YW1sDQo+ID4gQEAgLTE3LDYgKzE3LDkg
QEAgZGVzY3JpcHRpb246DQo+ID4gICBtYWludGFpbmVyczoNCj4gPiAgICAgLSBOZWVyYWogU2Fu
amF5IEthbGUgPG5lZXJhai5zYW5qYXlrYWxlQG54cC5jb20+DQo+ID4NCj4gPiArYWxsT2Y6DQo+
ID4gKyAgLSAkcmVmOiBibHVldG9vdGgtY29udHJvbGxlci55YW1sIw0KPiA+ICsNCj4gPiAgIHBy
b3BlcnRpZXM6DQo+ID4gICAgIGNvbXBhdGlibGU6DQo+ID4gICAgICAgZW51bToNCj4gPiBAQCAt
NDMsNyArNDYsNyBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgcmVxdWlyZWQ6DQo+ID4gICAgIC0gY29t
cGF0aWJsZQ0KPiA+DQo+ID4gLWFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICt1bmV2
YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+IA0KPiBIb3cgaXMgdGhpcyBkaWZmIHJlbGF0ZWQg
dG8gdGhlIGNoYW5nZSBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlPw0KDQpUaGlzIGlz
IGJhc2VkIG9uIHJldmlldyBjb21tZW50IGZyb20gS3J6eXN6dG9mIGluIFYxIERUIHBhdGNoLg0K
YWxsT2YgcmVmIHdpbGwgaW1wb3J0IGFsbCBwcm9wZXJ0aWVzIGRlZmluZWQgaW4gYmx1ZXRvb3Ro
LWNvbnRyb2xsZXIueWFtbCwgaW5jbHVkaW5nIGxvY2FsLWJkLWFkZHJlc3M6DQpodHRwczovL2dp
dGh1Yi5jb20vdG9ydmFsZHMvbGludXgvYmxvYi9tYXN0ZXIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL25ldC9ibHVldG9vdGgvYmx1ZXRvb3RoLWNvbnRyb2xsZXIueWFtbCNMMTgN
Cg0KPiANCj4gPg0KPiA+ICAgZXhhbXBsZXM6DQo+ID4gICAgIC0gfA0KPiA+IEBAIC01NCw1ICs1
Nyw2IEBAIGV4YW1wbGVzOg0KPiA+ICAgICAgICAgICAgICAgZnctaW5pdC1iYXVkcmF0ZSA9IDwz
MDAwMDAwPjsNCj4gPiAgICAgICAgICAgICAgIGZpcm13YXJlLW5hbWUgPSAidWFydHVhcnQ4OTg3
X2J0X3YwLmJpbiI7DQo+ID4gICAgICAgICAgICAgICBkZXZpY2Utd2FrZXVwLWdwaW9zID0gPCZn
cGlvIDExIEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiA+ICsgICAgICAgICAgICBsb2NhbC1iZC1hZGRy
ZXNzID0gWzY2IDU1IDQ0IDMzIDIyIDExXTsNCj4gPiAgICAgICAgICAgfTsNCj4gPiAgICAgICB9
Ow0KPiANCg0KVGhhbmtzLA0KTmVlcmFqDQo=
