Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987A91C3027;
	Wed, 23 Oct 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729694286; cv=fail; b=VQ51+86/ElLpcYXgZ9CkaRpHxyOnedLlLjaIej/ARcd9kl5e6kifx+J8OUR+YBRo/Y4KpZUp9ztU5k2bMR/0ONZxfT/uQnu7be6N4EPOjXfZz4u2v8X+hiK/vo6UdvxTcipOgJTd6mroM68fhiSPfNrDDQgU897Ou0WJK5+BP8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729694286; c=relaxed/simple;
	bh=e8KLgFWik/Q7gItm3m0R1BV3UeNtqZiX4A9b9LXg3Lc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bw9QQvocw/ZMxH330LWIMEoS5FdUnTTbU/TywcjKZCtRv8myljmoDbZJALVitr6F36SnR6oE2sBO/ifbFmu+8xEmNjMovDaTcOj6fQlZ7O0gAFDFjllQuCYOvmEyFQxu0uBtYw+k9j8QFIsz1s9nKFStqVVjPCFFBzxWTAeEV84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=gL5Kq+VE; arc=fail smtp.client-ip=40.107.20.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="gL5Kq+VE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JuSHxrt7fQjEOOHiD7VE2QwTAycSeXLYgl3wxByieJCGjmqUHr83eevFbAx4dJsPbCbM6qc8OYQ8uNyQp8nw3LMVQl0jWfZCEekRszWJZvQYZ8v5dX/rrHcLmA8us5ZYdJ4k5kWtehZLe34x6W5bP2RCeZTq4dQVR2ckd5Pgp5tsYz2bJ8UiQgb5LUJF8qEehbe2mqfsojVFgKQNKfu6SUNfN9rqiatbJfeNGW407PdNg+SaeqP/J7Q2PTUWQcNmj6BlmSTbIO2g+5clPSgxHWBNHDdLM64GyaqRQzxbTIce25KjYnJm5scPdZYY1lkFjGW+yuKwbCk4KMsdL3HqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8KLgFWik/Q7gItm3m0R1BV3UeNtqZiX4A9b9LXg3Lc=;
 b=icDhOKxZZ/U4TrpvAXtKkTSZm9J+ahk5WDlYQy7UJCwZSBNtuV0TtnxYfs5F9gxBOWGNLTMndaydI+hQFOYPIHcf8Xs1ERaS6vUMpcIE4jed1aDBGuyYWZlUYrjg8QFwjIDvbM81hNNeCHzX5Lzkgw2SU/3D+XDqPTFc4Y7KFU5BM7Wjutz0HBQagU4LYZIy2zdm/WNerYgdvfU4VFAz3FmxM6f2y4cysqauNb+iDeGdZYqdXOGO7hr8iJyMrC0khkr3awYmslqDv+zXHN/nBqGMrAZJZNWAKp53phGImxz4TGuF0w46Qr7rsz8bJZqIqvgiVPI9j1+y8vdWf3o3Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8KLgFWik/Q7gItm3m0R1BV3UeNtqZiX4A9b9LXg3Lc=;
 b=gL5Kq+VEBlwj0+xHLYYvNTsTPb+CzPemNwN64q69n8sb/iqKK4BF8IVz4UFMBkww8EQ1wI7Chwpt0YKD5e8BqojuLtJiNYbZjVZDzYjwrb+BPYVMutJqYw+G8D5lxOyEecPGQd1wUGVxYvenckPy3u8dmjmF+onSMB8RnJaZWZY=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by VI1PR06MB6800.eurprd06.prod.outlook.com (2603:10a6:800:18c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 14:38:01 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%4]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 14:38:01 +0000
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
 AQHbFlGYxegmsfkbQ0S2PUUKI4YS47J5bJAAgAAtywCAAao9AIAAIGOAgBV25oCAABNWAIAAK2IAgAE7AYCAACRCgIAADPSAgAADvgCAAGT1gIAAF8QAgAF4YACAAAYGAA==
Date: Wed, 23 Oct 2024 14:38:01 +0000
Message-ID: <1b8864e5-0ec7-49c4-932a-89cfbaeacc9f@leica-geosystems.com>
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
 <9b09774e-d0ed-4c97-b6a0-e976580b5bb5@leica-geosystems.com>
 <DB9PR04MB8429CF700571FE42C997FB9C924D2@DB9PR04MB8429.eurprd04.prod.outlook.com>
In-Reply-To:
 <DB9PR04MB8429CF700571FE42C997FB9C924D2@DB9PR04MB8429.eurprd04.prod.outlook.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|VI1PR06MB6800:EE_
x-ms-office365-filtering-correlation-id: 062967cb-408c-4eab-dc10-08dcf3704bb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MmNSVmRnaUIvMG9DSGFIUUxnN09HQktzeFhSczh4dUxPUXFERFF6UDF2czZo?=
 =?utf-8?B?K1hWanFkRWtYZzU1K0NxL3lreDc2d2o5NFQyTVo2SW01THR2ZUhCMzFIMi9o?=
 =?utf-8?B?NTRlZnI3YnA5MHl6c0NQT0JTZ2tHZFZVam1hMEYrV3FWcGErd3kwY3FoMFBL?=
 =?utf-8?B?aGVPQlY2VkJGSE9mMEVjQ1VjbFg1aU9oY2dkQUg4RWlsaWlUTWNzVmVLUVdR?=
 =?utf-8?B?TGhYY0I2ZXR5bmt4ekg0RjdhWG1JVHpHQ3BLV0tOUWw0MDQ4M1hzbUUwSGhp?=
 =?utf-8?B?OE1LeG1rOHN2bldUdlBtaU9Ld0JnQlJOcjJqa1IzZlltL1c5ekxqQVROMXVE?=
 =?utf-8?B?UmxsUnI2ZTdPUDA5eXB5UHIvZ3pmU1hhK2JBT05RRXZLRTJtVHpxemFHRmh0?=
 =?utf-8?B?cVBueWk5VE1zU3FrQjJmRXZKR28xRWpZSCtVaWM5ZlhvRkZHekZkWk5ZUkJX?=
 =?utf-8?B?b1UwdmY5azQwZC91c0loS0FJWFdHL0NWTzgyZWJPWi9hZlV4TkgrMExheEZ6?=
 =?utf-8?B?OEtXcysrSG1nOWRRRVNlbHZGc2tpMm1kSlJkcm5hSlNJa05mWDU5L1hqeWky?=
 =?utf-8?B?aUU3cUxEWEx0SHQ3c0tOODJyVTZoYUJhRDJ1MmxRL1V6a3ZVaWVibjl4WEVZ?=
 =?utf-8?B?MlJOWE5JcUNYeW1CWjkrbXZHMjBmS0F3TVdnTUE2UUpYMmhxOXRpbURiZWhp?=
 =?utf-8?B?TjZORFlwaGRsV3FpZXVDblhJMkFSRFlxQndOcWh1U0JIbFhvdUFweXcveEc4?=
 =?utf-8?B?V1JtZ3kxZW9vM1l2bE4xSENsZVpwTTVyd25QSm42SWNEeTBYbk1lZlJBS1pD?=
 =?utf-8?B?TzhXcGxJMnFvaUNKSi9FU3hsUkIvcU4ycWg1MGI0UkJ2TVdSVDY1aVZUYThE?=
 =?utf-8?B?UDUyTWw1ZmFVMVJQaE9YZ1VNNjlORHhRSmFIblVFQzcvK1pqSGNUUHd1OTlM?=
 =?utf-8?B?dURRRDFiNnBFanJWa043d1NuWGVreHN4Y1B0QVFKWUNWd0I3VExIRlBlR1NM?=
 =?utf-8?B?VFE0M2l5UlpCYUFCMXM3dzMrV252WVk1Mzh5SC9RWUV0Mi83SUNIeUEyVlZi?=
 =?utf-8?B?WTJNRVVJWERaZEgyUkpSV21aemFqWDVBL2luT2NrdHJSRjBYWjlZSVRDbmZa?=
 =?utf-8?B?QnRNcFZqVUJIc1prTDNOQlk0Rm9vcTZnbHJiOEpPL3ZTQnNXNUdINURCYUhD?=
 =?utf-8?B?NkF4UDNsaE1VcitUYTBaRHNzU3NhR3EwalZWY25DL1ZLeUFTQ1J6aTFrQVpP?=
 =?utf-8?B?Mm4vQUxvSzRQM2FpeVJqbEI3Ni9UaUd3OVkvdUk0TFRDdFE2Wm5QclVJQkFo?=
 =?utf-8?B?eXM5OWtuSEhuOWRoWm5KdnRwTUljRkV0cE9mWUtLeEZRMUVWT3A1MFFyTFJR?=
 =?utf-8?B?cXBHdDF0ZjR4Sy80aE5la0s2MUNtQ01jODE4d3pMRmdyNVFvUTF6MnRQZlpy?=
 =?utf-8?B?T0VlTVIrL0k3WUpvd2ltN3ZzWCszb2dxWnFIcm15ejhQcXNNd0h3ZE9lWGlL?=
 =?utf-8?B?Zk83MzYxcjFObVY0OGpqREdmUFZPcW9PMVJRcGh3M3hDR0xuZXlNSzBtcXRP?=
 =?utf-8?B?NW0rRDVkZFlOM1hRSzdWcVl2dFFRaHVRb1JLMVNNNDd4dDE4WW1PTzFxUWVh?=
 =?utf-8?B?WndtNDVsUW9IKzlaZmlBdHZmQUE4emIyUnJUdG5mTmFJYlRNc3AwYUtrbmRP?=
 =?utf-8?B?SkUwVll6ZlplTHVqR3RNaldrNjdvZ1Zub1pabjdiRXZlMHVlZlhIbVFwRC9w?=
 =?utf-8?B?a2FRcjhvTVRtb2FCaXpvYXVraFN1UDg5aHVDQmNEWGJsVmsrUUtEVWpoejQ4?=
 =?utf-8?B?UkVtVmhtY0owSXI1L2VmNnpOTnIyMTdheitjN3EyVmZ6UG5VUGgwdlZJRnVD?=
 =?utf-8?Q?P9HQ93U1ZLJMt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlJGeUczUnBPc3p0cERYdTJEb3lRYzhkd0xEdjg1dDBacStEQkVoaXRUMmxX?=
 =?utf-8?B?TUF6NkxkVVd6K1FUbHBnYmJKeFZ3RFNpdzdjQ1pCNDhKNXFtUGdrcHhRc0pU?=
 =?utf-8?B?aU5lbEt5Y3RFcUdqWEpQaWE0TDgvaXVJOXJrTCtHSUpDS0JEcEgxQy9UYThm?=
 =?utf-8?B?N0xxcG9pRTlBNzcwKzRjb3BqVXAvajlRaVFzZGhaWnpHRzZiTVB3M2oxRWIw?=
 =?utf-8?B?NHFkVjVwUHlWQ0VlU3NqTVNSTHFOc2lwMi9yUm5ISk05VWw4VFB6NDB3aTZZ?=
 =?utf-8?B?VDk2L21VUmwzYzhBWmZpeHhneE5kdGhqTjFIR0hicGYxbno1Y1B0VU9KN1ZB?=
 =?utf-8?B?dEd1bUR1bFZmOG9McURmUjl3R2hacHRDcVpXbDhlemVvTTEzMnB6VjFmK1E1?=
 =?utf-8?B?TDJ3UW15T0I3MHlMWmRnVnZUMW1WSEs0OHRZbmtnZlRVRW4xelZ1a1M1VHVR?=
 =?utf-8?B?eU13OW1xN25FdDd4ZXpxYkNOQ280dXhqS3ZYUUJtbGxXOW16MVpaUXhoQWZP?=
 =?utf-8?B?NExTc01WWENlR3BsTVo5NndZZjFlM2QwVHZ6L2M5WG1pUWRDcy93VFN4bHZu?=
 =?utf-8?B?RDIvWDc5VnI4Ui9JM2VQMkg5c2VaNU5raTlQNHh1WWtGdWg1dlpybWY0djI4?=
 =?utf-8?B?T3ozZTFUaXRZZDdWcGg0WFQ1dVZBbnF0VkttZlV3R1FjSEJ5RHVpckNVQ1M0?=
 =?utf-8?B?Q0xrMVUwbGpOVW1kajBESHdrYjh5V0VUaVp6cVEzaTZ1NnFPY0l3TGxydEw5?=
 =?utf-8?B?ZHkwbTZoaytUTWVVWWllVy9mVVdhUXpnWnAvbWdDM1ZjZ0dIRWhXZDFqUjBv?=
 =?utf-8?B?RERhVXZHdUFVL3NGdzR5L3RYSnliME9yVlo1S1l3c1dWdVNySUcwQWdUTnZ4?=
 =?utf-8?B?WlJ2ZjUwMUEzTitzSmswSFZEVDJYWUpIU2ZwUzBrSkpabW5JZDQyL3kzT296?=
 =?utf-8?B?YjJEcFlpQ2JWK0lWeVpwM2N0Y1dxTGJGVTZIckw1WlRjV2tFRWl5d3p6dStB?=
 =?utf-8?B?OTloYnRwQ3NGSXF6NExvL0RxMVRkVk4raHorOWg2aUJVcTRldXBXZHY2MTZN?=
 =?utf-8?B?VVhPcWtYOCsrVkIrdTdaN20rVzlQeEdZVjFwSUtNV2xSbER6RlkzWjhtZngv?=
 =?utf-8?B?MEZKM1F5Q1JyT01NUmFReFNtMnp3YjdndmVjenVLWW43UTloMjRFTTNZV29w?=
 =?utf-8?B?QkR6cDJBaGdaNUFxMWxMNFFQM0hQR3REekhQdXJuYmhrOVJrUU1jRHNYK2Zz?=
 =?utf-8?B?bm1RbEJEblFQVG16NmxBSkJpQTAxa3g4alJWMkI2ZkZaVXlBSHJ3Nm5VTTNk?=
 =?utf-8?B?a3F0YU0zcXhXU0M0aEQyNDZ3Q0ZhWnBqYVE4N2Q0dTIyV2Rac1NpaVNTTG1t?=
 =?utf-8?B?UmVjV0Nlc3hpL1Iyb0VkNHFMTWNaY0UzRC8rcUIvV2tqNmw4Q0NoRWxZeE1G?=
 =?utf-8?B?T3NmL3lvWjYydjhFYTlwdnFhNDVQWTlOdms0Z2VhOW5kNlpvSzRieWpYd2VH?=
 =?utf-8?B?K1RkdWJJZU04RHREODRyVzJBTHlWQ2lLQTFhdUVJUXVIeDJCYW1XVEI1N0NH?=
 =?utf-8?B?Rlp2Y0tKbjB6Yys1UlNhREVnSmZhV0tSYVVoRGd0NnluWGlxdVNRZ09BZkNH?=
 =?utf-8?B?RmR4SEM2MS9yYlg4eHE2dERKOG5ZV1RHclFKeXRyQVQyTGw5TVpCbHo4c1hO?=
 =?utf-8?B?RVlseFdRcW5PbFRqWjh6YzVkOVYyZDB6KzBjd1ZzSmJEcm95REdkVG5ocm1Q?=
 =?utf-8?B?YmlhZjBENzdVY1QrUVlqaFVUdkVoSDZDNEtsTjZwYzh5aVpuWWczdGVvL0tm?=
 =?utf-8?B?YUNPVVJBNldSWHJXTzJqdW9mc2dxWHJLK2w0aHNFQkZ6eFltVWNOL3AwOFgv?=
 =?utf-8?B?d1lGYXBVR2l2VmpSSjA1cnRidUZzaER1bnVZZyt6amh6RS91ZHJwUUFxcHhx?=
 =?utf-8?B?S1FKNWI1NW84bEo0R3lRWVJuemUrTk5wT212L0pJOER2SHdweHBFWm1LSlRZ?=
 =?utf-8?B?WExFaDQxN1hvL0l2TUJrMzVDVVVxQXMySG5LWlVLZFpiYjVSSExua1R4ZlpE?=
 =?utf-8?B?ZitFNnB4QUZoU1gyVmxQVkUyWVFnelltQjQrSjNWeVNySW0vSVVqaGx0OVlE?=
 =?utf-8?B?a2JubXFYYXlQSVpHVGl5ZlAzUUdmc0NzWlNNNWxYMEVlZVdhMDVDVXZiMWRw?=
 =?utf-8?Q?sgYPHi+SqhRXuKIaSuaNUC4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAC65529D81ACB44A7560BFE1FC23EE2@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 062967cb-408c-4eab-dc10-08dcf3704bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 14:38:01.1628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dCEEoZ8xvunimGG0pZC5oxHvNJK6jnn6giY2pWwZuPt7N1t9TIfWG2FGrJbEhuPKYr+7g9hpFwH26td+kbQXiO64aZ9Ksvh46gDx/d9ne9UnAE/yMNUmacr9YWJzP2rR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB6800

T24gMjMvMTAvMjAyNCAxNjoxNiwgU2hlcnJ5IFN1biB3cm90ZToNCj4gVGhpcyBlbWFpbCBpcyBu
b3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1
bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVwbHlpbmcg
dG8gdGhpcyBlbWFpbC4NCj4NCj4NCj4+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+
Pj4gRnJvbTogTWFyY28gRmVsc2NoIDxtLmZlbHNjaEBwZW5ndXRyb25peC5kZT4NCj4+Pj4gU2Vu
dDogVHVlc2RheSwgT2N0b2JlciAyMiwgMjAyNCA0OjIzIFBNDQo+Pj4+IFRvOiBTaGVycnkgU3Vu
IDxzaGVycnkuc3VuQG54cC5jb20+DQo+Pj4+IENjOiBQT1BFU0NVIENhdGFsaW4gPGNhdGFsaW4u
cG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbT47DQo+PiBBbWl0a3VtYXINCj4+Pj4gS2Fyd2Fy
IDxhbWl0a3VtYXIua2Fyd2FyQG54cC5jb20+OyBOZWVyYWogU2FuamF5IEthbGUNCj4+Pj4gPG5l
ZXJhai5zYW5qYXlrYWxlQG54cC5jb20+OyBtYXJjZWxAaG9sdG1hbm4ub3JnOw0KPj4+PiBsdWl6
LmRlbnR6QGdtYWlsLmNvbTsgcm9iaEBrZXJuZWwub3JnOyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+
Pj4+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LQ0K
Pj4+PiBibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtDQo+Pj4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEdFTy1DSEhFUi1ic3AtZGV2
ZWxvcG1lbnQgPGJzcC0NCj4+Pj4gZGV2ZWxvcG1lbnQuZ2VvQGxlaWNhLWdlb3N5c3RlbXMuY29t
PjsgS3J6eXN6dG9mIEtvemxvd3NraQ0KPj4+PiA8a3J6a0BrZXJuZWwub3JnPg0KPj4+PiBTdWJq
ZWN0OiBSZTogW1BBVENIIDEvMl0gZHQtYmluZGluZ3M6IG5ldDogYmx1ZXRvb3RoOiBueHA6IGFk
ZA0KPj4+PiBzdXBwb3J0IGZvciBzdXBwbHkgYW5kIHJlc2V0DQo+Pj4+DQo+Pj4+IE9uIDI0LTEw
LTIyLCBTaGVycnkgU3VuIHdyb3RlOg0KPj4+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+Pj4+Pj4gRnJvbTogTWFyY28gRmVsc2NoIDxtLmZlbHNjaEBwZW5ndXRyb25peC5kZT4NCj4+
Pj4+PiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIyLCAyMDI0IDM6MjMgUE0NCj4+Pj4+PiBUbzog
U2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPj4+Pj4+IENjOiBQT1BFU0NVIENhdGFs
aW4gPGNhdGFsaW4ucG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbT47DQo+Pj4+Pj4gQW1pdGt1
bWFyIEthcndhciA8YW1pdGt1bWFyLmthcndhckBueHAuY29tPjsgTmVlcmFqIFNhbmpheSBLYWxl
DQo+Pj4+Pj4gPG5lZXJhai5zYW5qYXlrYWxlQG54cC5jb20+OyBtYXJjZWxAaG9sdG1hbm4ub3Jn
Ow0KPj4+Pj4+IGx1aXouZGVudHpAZ21haWwuY29tOyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRA
a2VybmVsLm9yZzsNCj4+Pj4+PiBjb25vcitkdEBrZXJuZWwub3JnOyBwLnphYmVsQHBlbmd1dHJv
bml4LmRlOyBsaW51eC0NCj4+Pj4+PiBibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+Pj4+Pj4ga2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgR0VPLUNISEVSLWJzcC1kZXZlbG9wbWVudCA8YnNwLQ0KPj4+Pj4+IGRldmVsb3BtZW50Lmdl
b0BsZWljYS1nZW9zeXN0ZW1zLmNvbT47IEtyenlzenRvZiBLb3psb3dza2kNCj4+Pj4+PiA8a3J6
a0BrZXJuZWwub3JnPg0KPj4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSBkdC1iaW5kaW5n
czogbmV0OiBibHVldG9vdGg6IG54cDogYWRkDQo+Pj4+Pj4gc3VwcG9ydCBmb3Igc3VwcGx5IGFu
ZCByZXNldA0KPj4+Pj4+DQo+Pj4+Pj4gT24gMjQtMTAtMjIsIFNoZXJyeSBTdW4gd3JvdGU6DQo+
Pj4+Pj4+PiBPbiAyNC0xMC0yMSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+Pj4+Pj4+
PiBPbiAyMS8xMC8yMDI0IDA4OjQxLCBNYXJjbyBGZWxzY2ggd3JvdGU6DQo+Pj4+Pj4+Pj4+IE9u
IDI0LTEwLTA3LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4gT24gMDcv
MTAvMjAyNCAxNDo1OCwgUE9QRVNDVSBDYXRhbGluIHdyb3RlOg0KPj4+Pj4+Pj4+Pj4+Pj4+ICsg
IHZjYy1zdXBwbHk6DQo+Pj4+Pj4+Pj4+Pj4+Pj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+Pj4+Pj4+
Pj4+Pj4+PiArICAgICAgcGhhbmRsZSBvZiB0aGUgcmVndWxhdG9yIHRoYXQgcHJvdmlkZXMgdGhl
IHN1cHBseQ0KPj4+PiB2b2x0YWdlLg0KPj4+Pj4+Pj4+Pj4+Pj4+ICsNCj4+Pj4+Pj4+Pj4+Pj4+
PiArICByZXNldC1ncGlvczoNCj4+Pj4+Pj4+Pj4+Pj4+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4+
Pj4+Pj4+Pj4+Pj4+ICsgICAgICBDaGlwIHBvd2VyZG93bi9yZXNldCBzaWduYWwgKFBEbikuDQo+
Pj4+Pj4+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+Pj4+Pj4gSGkgQ2F0YWxpbiwNCj4+Pj4+Pj4+Pj4+
Pj4+DQo+Pj4+Pj4+Pj4+Pj4+PiBGb3IgTlhQIFdJRkkvQlQgY2hpcCwgV0lGSSBhbmQgQlQgc2hh
cmUgdGhlIG9uZSBQRG4gcGluLA0KPj4+Pj4+Pj4+Pj4+Pj4gd2hpY2gNCj4+Pj4+Pj4+IG1lYW5z
IHRoYXQgYm90aCB3aWZpIGFuZCBCVCBjb250cm9sbGVyIHdpbGwgYmUgcG93ZXJlZCBvbiBhbmQg
b2ZmDQo+Pj4+Pj4+PiBhdCB0aGUgc2FtZSB0aW1lLg0KPj4+Pj4+Pj4+Pj4+Pj4gVGFraW5nIHRo
ZSBNLjIgTlhQIFdJRkkvQlQgbW9kdWxlIGFzIGFuIGV4YW1wbGUsDQo+Pj4+Pj4+PiBwaW41NihX
X0RJU0FCTEUxKSBpcyBjb25uZWN0ZWQgdG8gdGhlIFdJRkkvQlQgY2hpcCBQRG4gcGluLCB3ZQ0K
Pj4+Pj4+Pj4gaGFzIGFscmVhZHkgY29udHJvbGxlZCB0aGlzIHBpbiBpbiB0aGUgY29ycmVzcG9u
ZGluZyBQQ0llL1NESU8NCj4+Pj4+Pj4+IGNvbnRyb2xsZXIgZHRzDQo+Pj4+Pj4gbm9kZXMuDQo+
Pj4+Pj4+Pj4+Pj4+PiBJdCBpcyBub3QgY2xlYXIgdG8gbWUgd2hhdCBleGFjdGx5IHBpbnMgZm9y
IHZjYy1zdXBwbHkgYW5kDQo+Pj4+Pj4+Pj4+Pj4+PiByZXNldC1ncGlvcw0KPj4+Pj4+Pj4geW91
IGRlc2NyaWJpbmcgaGVyZS4gQ2FuIHlvdSBoZWxwIHVuZGVyc3RhbmQgdGhlIGNvcnJlc3BvbmRp
bmcNCj4+Pj4+Pj4+IHBpbnMgb24gTS4yIGludGVyZmFjZSBhcyBhbiBleGFtcGxlPyBUaGFua3Mu
DQo+Pj4+Pj4+Pj4+Pj4gSGkgU2hlcnJ5LA0KPj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4gUmVn
dWxhdG9ycyBhbmQgcmVzZXQgY29udHJvbHMgYmVpbmcgcmVmY291bnRlZCwgd2UgY2FuIHRoZW4N
Cj4+Pj4+Pj4+Pj4+PiBpbXBsZW1lbnQgcG93ZXJ1cCBzZXF1ZW5jZSBpbiBib3RoIGJsdWV0b290
aC93bGFuIGRyaXZlcnMNCj4+IGFuZA0KPj4+Pj4+Pj4+Pj4+IGhhdmUgdGhlIGRyaXZlcnMgb3Bl
cmF0ZSBpbmRlcGVuZGVudGx5LiBUaGlzIHdheSBibHVldG9vdGgNCj4+Pj4+Pj4+Pj4+PiBkcml2
ZXIgd291bGQgaGFzIG5vIGRlcGVuZGFuY2Ugb24gdGhlIHdsYW4NCj4+Pj4gZHJpdmVyIGZvciA6
DQo+Pj4+Pj4+Pj4+Pj4gLSBpdHMgcG93ZXIgc3VwcGx5DQo+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+
Pj4+PiAtIGl0cyByZXNldCBwaW4gKFBEbikNCj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+IC0g
aXRzIGZpcm13YXJlIChiZWluZyBkb3dubG9hZGVkIGFzIHBhcnQgb2YgdGhlIGNvbWJvDQo+Pj4+
Pj4+Pj4+Pj4gZmlybXdhcmUpDQo+Pj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+PiBGb3IgdGhlIHds
YW4gZHJpdmVyIHdlIHVzZSBtbWMgcG93ZXIgc2VxdWVuY2UgdG8gZHJpdmUgdGhlDQo+Pj4+Pj4+
Pj4+Pj4gY2hpcCByZXNldCBwaW4gYW5kIHRoZXJlJ3MgYW5vdGhlciBwYXRjaHNldCB0aGF0IGFk
ZHMgc3VwcG9ydA0KPj4+Pj4+Pj4+Pj4+IGZvciByZXNldCBjb250cm9sIGludG8gdGhlIG1tYyBw
d3JzZXEgc2ltcGxlIGRyaXZlci4NCj4+Pj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+Pj4+PiBQbGVhc2Ug
d3JhcCB5b3VyIHJlcGxpZXMuDQo+Pj4+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+Pj4+IEl0IHNlZW1z
IHlvdSBuZWVkIHBvd2VyIHNlcXVlbmNpbmcganVzdCBsaWtlIEJhcnRvc3ogZGlkIGZvcg0KPj4+
Pj4+Pj4gUXVhbGNvbW0gV0NOLg0KPj4+Pj4+Pj4+Pj4+IEhpIEtyenlzenRvZiwNCj4+Pj4+Pj4+
Pj4+Pg0KPj4+Pj4+Pj4+Pj4+IEknbSBub3QgZmFtaWxpYXIgd2l0aCBwb3dlciBzZXF1ZW5jaW5n
LCBidXQgbG9va3MgbGlrZSB3YXkNCj4+Pj4+Pj4+Pj4+PiBtb3JlIGNvbXBsaWNhdGVkIHRoYW4g
cmVzZXQgY29udHJvbHMuIFNvLCB3aHkgcG93ZXINCj4+Pj4+Pj4+Pj4+PiBzZXF1ZW5jaW5nIGlz
IHJlY29tbWVuZGVkIGhlcmUgPyBJcyBpdCBiL2MgYSBzdXBwbHkgaXMNCj4+Pj4gaW52b2x2ZWQg
Pw0KPj4+Pj4+Pj4+Pj4gQmFzZWQgb24gZWFybGllciBtZXNzYWdlOg0KPj4+Pj4+Pj4+Pj4NCj4+
Pj4+Pj4+Pj4+ICJGb3IgTlhQIFdJRkkvQlQgY2hpcCwgV0lGSSBhbmQgQlQgc2hhcmUgdGhlIG9u
ZSBQRG4gcGluLA0KPj4+Pj4+Pj4+Pj4gd2hpY2ggbWVhbnMgdGhhdCBib3RoIHdpZmkgYW5kIEJU
IGNvbnRyb2xsZXIgd2lsbCBiZSBwb3dlcmVkDQo+Pj4+Pj4+Pj4+PiBvbiBhbmQgb2ZmIGF0IHRo
ZSBzYW1lIHRpbWUuIg0KPj4+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+Pj4+IGJ1dCBtYXliZSB0aGF0J3Mg
bm90IG5lZWRlZC4gTm8gY2x1ZSwgSSBkb24ndCBrbm93IHRoZSBoYXJkd2FyZS4NCj4+Pj4+Pj4+
Pj4+IEJ1dCBiZSBjYXJlZnVsbHkgd2hhdCB5b3Ugd3JpdGUgaW4gdGhlIGJpbmRpbmdzLCBiZWNh
dXNlIHRoZW4NCj4+Pj4+Pj4+Pj4+IGl0IHdpbGwgYmUNCj4+Pj4+Pj4+IEFCSS4NCj4+Pj4+Pj4+
Pj4gV2Ugbm90aWNlZCB0aGUgbmV3IHBvd2VyLXNlcXVlbmNpbmcgaW5mcmFzdHJ1Y3R1cmUgd2hp
Y2ggaXMNCj4+Pj4+Pj4+Pj4gcGFydCBvZg0KPj4+Pj4+Pj4+PiA2LjExIHRvbyBidXQgSSBkb24n
dCB0aGluayB0aGF0IHRoaXMgcGF0Y2ggaXMgd3JvbmcuIFRoZSBEVCBBQkkNCj4+Pj4+Pj4+Pj4g
d29uJ3QgYnJlYWsgaWYgd2Ugc3dpdGNoIHRvIHRoZSBwb3dlci1zZXF1ZW5jaW5nIGxhdGVyIG9u
IHNpbmNlDQo+Pj4+Pj4+Pj4+IHRoZQ0KPj4+Pj4+Pj4gInJlc2V0LWdwaW9zIg0KPj4+Pj4+Pj4+
PiBhcmUgbm90IG1hcmtlZCBhcyByZXF1aXJlZC4gU28gaXQgaXMgdXAgdG8gdGhlIGRyaXZlciB0
byBoYW5kbGUNCj4+Pj4+Pj4+Pj4gaXQgZWl0aGVyIHZpYSBhIHNlcGFyYXRlIHBvd2VyLXNlcXVl
bmNlIGRyaXZlciBvciB2aWENCj4+Pj4gInBvd2VyLXN1cHBseSINCj4+Pj4+Pj4+Pj4gYW5kICJy
ZXNldC1ncGlvcyIgZGlyZWN0bHkuDQo+Pj4+Pj4+Pj4gVGhhdCdzIG5vdCB0aGUgcG9pbnQuIFdl
IGV4cGVjdCBjb3JyZWN0IGhhcmR3YXJlIGRlc2NyaXB0aW9uLg0KPj4+Pj4+Pj4+IElmIHlvdSBz
YXkgbm93IGl0IGhhcyAicmVzZXQtZ3Bpb3MiIGJ1dCBsYXRlciBzYXkgImFjdHVhbGx5IG5vLA0K
Pj4+Pj4+Pj4+IGJlY2F1c2UgaXQgaGFzIFBNVSIsIEkgcmVzcG9uZDogbm8uIERlc2NyaWJlIHRo
ZSBoYXJkd2FyZSwgbm90DQo+Pj4+Pj4+Pj4gY3VycmVudA0KPj4+Pj4+IExpbnV4Lg0KPj4+Pj4+
Pj4gSSBrbm93IHRoYXQgRFQgYWJzdHJhY3RzIHRoZSBIVy4gVGhhdCBzYWlkIEkgZG9uJ3Qgc2Vl
IHRoZQ0KPj4+Pj4+Pj4gcHJvYmxlbSB3aXRoIHRoaXMgcGF0Y2guIFRoZSBIVyBpcyBhYnN0cmFj
dGVkIGp1c3QgZmluZToNCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBzaGFyZWQgUERuICAgICAgICAgIC0+
IHJlc2V0LWdwaW9zDQo+Pj4+Pj4+PiBzaGFyZWQgcG93ZXItc3VwcGx5IC0+IHZjYy1zdXBwbHkN
Cj4+Pj4+Pj4gQWN0dWFsbHkgd2Ugc2hvdWxkIHVzZSB2Y2Mtc3VwcGx5IHRvIGNvbnRyb2wgdGhl
IFBEbiBwaW4sIHRoaXMgaXMNCj4+Pj4+Pj4gdGhlIHBvd2VyIHN1cHBseSBmb3IgTlhQIHdpZmkv
QlQuDQo+Pj4+Pj4gUGxlYXNlIGRvbid0IHNpbmNlIHRoaXMgaXMgcmVndWxhciBwaW4gb24gdGhl
IHdsYW4vYnQgZGV2aWNlIG5vdA0KPj4+Pj4+IHRoZQ0KPj4+PiByZWd1bGF0b3IuDQo+Pj4+Pj4g
UGVvcGxlIG9mdGVuIGRvIHRoYXQgZm9yIEdQSU9zIGlmIHRoZSBkcml2ZXIgaXMgbWlzc2luZyB0
aGUgc3VwcG9ydA0KPj4+Pj4+IHRvIHB1bGwgdGhlIHJlc2V0L3Bkbi9lbmFibGUgZ3BpbyBidXQg
dGhlIGVuYWJsZS1ncGlvIG9uIHRoZQ0KPj4+Pj4+IHJlZ3VsYXRvciBpcyB0byBlbmFibGUgdGhl
IHJlZ3VsYXRvciBhbmQgX25vdF8gdGhlIGJ0L3dsYW4gZGV2aWNlLg0KPj4+Pj4+DQo+Pj4+Pj4g
VGhlcmVmb3JlIHRoZSBpbXBsZW1lbnRhdGlvbiBDYXRhbGluIHByb3ZpZGVkIGlzIHRoZSBjb3Jy
ZWN0IG9uZS4NCj4+Pj4+Pg0KPj4+Pj4gRm9yIE5YUCB3aWZpL0JULCB0aGUgUERuIGlzIHRoZSBv
bmx5IHBvd2VyIGNvbnRyb2wgcGluLCBubyBzcGVjaWZpYw0KPj4+Pj4gcmVndWxhdG9yLCBwZXIg
bXkgdW5kZXJzdGFuZGluZywgaXQgaXMgYSBjb21tb24gd2F5IHRvIGNvbmZpZ3VyZQ0KPj4+Pj4g
dGhpcyBwaW4gYXMgdGhlIHZjYy1zdXBwbHkgZm9yIHRoZSB3aWZpIGludGVyZmFjZShTRElPIG9y
IFBDSWUpLg0KPj4+PiBOQUNLLiBFYWNoIGFjdGl2ZSBleHRlcm5hbCBjaGlwIG5lZWRzIHBvd2Vy
LCB0aGlzIGlzIHN1cHBsaWVkIHZpYSBhbg0KPj4+PiBzdXBwbHktIHJhaWwgYW5kIHRoaXMgaXMg
d2hhdCB2Y2MvdmRkL3ZhL3ZkaW8vdioqKi1zdXBwbHkgYXJlIHVzZWQgZm9yLg0KPj4+Pg0KPj4+
PiBUaGUgUERuIGlzIGEgZGlnaXRhbCBpbnB1dCBzaWduYWwgd2hpY2ggdGVsbHMgdGhlIGNoaXAg
dG8gZ28gaW50bw0KPj4+PiBwb3dlci0gZG93bi9yZXNldCBtb2RlIG9yIG5vdC4NCj4+Pj4NCj4+
Pj4+IHJlZ191c2RoYzNfdm1tYzogcmVndWxhdG9yLXVzZGhjMyB7DQo+Pj4+PiAgICAgICAgICAg
IGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4+Pj4+ICAgICAgICAgICAgcmVndWxh
dG9yLW5hbWUgPSAiV0xBTl9FTiI7DQo+Pj4+PiAgICAgICAgICAgIHJlZ3VsYXRvci1taW4tbWlj
cm92b2x0ID0gPDMzMDAwMDA+Ow0KPj4+Pj4gICAgICAgICAgICByZWd1bGF0b3ItbWF4LW1pY3Jv
dm9sdCA9IDwzMzAwMDAwPjsNCj4+Pj4+ICAgICAgICAgICAgZ3BpbyA9IDwmcGNhbDY1MjQgMjAg
R1BJT19BQ1RJVkVfSElHSD47DQo+Pj4+PiAgICAgICAgICAgIGVuYWJsZS1hY3RpdmUtaGlnaDsN
Cj4+Pj4+IH07DQo+Pj4+IFRoaXMgaXMgd2hhdCBJIG1lYW50IHByZXZpb3VzbHksIHlvdSBkbyB1
c2UgYSByZWd1YWx0b3IgZGV2aWNlIGZvcg0KPj4+PiBzd2l0Y2hpbmcgdGhlIFBEbiBzaWduYWwu
IFRoaXMgaXMgbm90IGNvcnJlY3QsIGFsYmVpdCBhIGxvdCBvZiBwZW9wbGUNCj4+Pj4gYXJlIGRv
aW5nIHRoaXMgYmVjYXVzZSB0aGV5IGRvbid0IHdhbnQgdG8gYWRhcHQgdGhlIGRyaXZlci4gVGhl
ICdncGlvJw0KPj4+PiB3aXRoaW4gdGhpcyByZWd1YWx0b3Igc2hvdWxkIGVuYWJsZS9kaXNhYmxl
IHRoaXMgcGFydGljdWxhciBwaHlzaWNhbA0KPj4gcmVndWFsdG9yLg0KPj4+IFNvcnJ5IEkgc2Vl
IGl0IGRpZmZlcmVudGx5LiBJIGNoZWNrZWQgdGhlIGRhdGFzaGVldCBvZiBOWFAgd2lmaQ0KPj4+
IGNoaXAodGFraW5nIElXNjEyIGFzIGFuIGV4YW1wbGUpLCB0aGUgUERuIHBpbiBpcyBub3QgdGhl
IEJUIHJlc2V0IHBpbiwNCj4+PiB3ZSB1c3VhbGx5IHRha2UgaXQgYXMgdGhlIFBNSUNfRU4vV0xf
UkVHX09OIHBpbiB0byBjb250cm9sIHRoZSB3aG9sZQ0KPj4gY2hpcCBwb3dlciBzdXBwbHkuDQo+
Pj4gSSB0aGluayB0aGUgcmVzZXQtZ3BpbyBhZGRlZCBoZXJlIHNob3VsZCBjb250cm9sIHRoZSBJ
TkRfUlNUX0JUIHBpbg0KPj4+IChJbmRlcGVuZGVudCBzb2Z0d2FyZSByZXNldCBmb3IgQmx1ZXRv
b3RoKSwgc2ltaWxhciBmb3IgdGhlIElORF9SU1RfV0wNCj4+PiBwaW4oSW5kZXBlbmRlbnQgc29m
dHdhcmUgcmVzZXQgZm9yIFdpLUZpKS4NCj4+Pg0KPj4+IEJlc3QgUmVnYXJkcw0KPj4+IFNoZXJy
eQ0KPj4gUERuIGlzIG5vdCB0aGUgQlQgcmVzZXQgOg0KPj4NCj4+IC0gUERuIGlzIGEgY2hpcCBy
ZXNldCBhbmQgaXMgc2hhcmVkIGIvdyBCVCBhbmQgV0lGSSA6IGhlbmNlLCBpdCBuZWVkcyB0byBi
ZQ0KPj4gbWFuYWdlZCBhcyBhIHJlc2V0IGNvbnRyb2wNCj4+DQo+IE9rLCBzbyBjYW4geW91IHBs
ZWFzZSBhbHNvIHNlbmQgb3V0IHRoZSBjb3JyZXNwb25kaW5nIHdpZmkgZHJpdmVyIGNoYW5nZXMN
Cj4gZm9yIHRoZSByZXNldCBjb250cm9sIGZvciByZWZlcmVuY2U/IE90aGVyd2lzZSBJIHN1cHBv
c2UgdGhlIHdpZmkgcGFydCB3aWxsDQo+IGJlIHBvd2VyZWQgb2ZmIHVuZXhwZWN0ZWRseSBpZiB1
bmxvYWQgdGhlIEJUIGRyaXZlciB3aXRoIHlvdXIgcGF0Y2guDQo+DQo+IEJlc3QgUmVnYXJkcw0K
PiBTaGVycnkNCg0KV2UgdXNlIHRoZSBOWFAgZG93bnN0cmVhbSBkcml2ZXIgbXdpZmlleCB3aGlj
aCBkb2Vzbid0IGhhdmUgc3VwcG9ydCBmb3IgDQpyZWd1bGF0b3Igb3IgUERuLg0KDQpIb3dldmVy
LCByZWd1bGF0b3IgaXMgYWxyZWFkeSBzdXBwb3J0ZWQgYnkgdGhlIE1NQyBjb3JlICh2bW1jLXN1
cHBseSkuDQoNCkZvciBQRG4sIHdlIHVzZSBtbWMgcHdyc2VxIHNpbXBsZSBkcml2ZXIgdGhhdCBo
YXMgYmVlbiBwYXRjaGVkIHRvIGFkZCANCnN1cHBvcnQgZm9yIHJlc2V0LWNvbnRyb2wuDQoNClBs
ZWFzZSBjaGVjayA6IA0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQxMDE3MTMxOTU3
LjExNzEzMjMtMS1jYXRhbGluLnBvcGVzY3VAbGVpY2EtZ2Vvc3lzdGVtcy5jb20vDQoNCkJSLA0K
DQo+DQo+PiAtIEJUIHJlc2V0IGlzIHNwZWNpZmljIHRvIEJUIGFuZCBjYW4gYmUgaGFuZGxlZCBh
cyBhIHNpbXBsZSBncGlvIGFzIGl0J3Mgbm90DQo+PiBiZWluZyBzaGFyZWQgd2l0aCBvdGhlciBk
cml2ZXIgKGUuZyBXSUZJKQ0KPj4NCj4+IEkndmUgb25seSBhZGRlZCBzdXBwb3J0IGZvciBwb3dl
ci1zdXBwbHkgYW5kIFBEbi4NCj4+DQo+PiBCVCBzcGVjaWZpYyByZXNldCBoYXMgYmVlbiBpZ25v
cmVkIHNvIGZhciBhcyBpdCdzIG9wdGlvbmFsIHNvZnR3YXJlIHJlc2V0IGFuZCBpdA0KPj4gY2Fu
IGJlIGxlZnQgb3BlbiBpZiBub3QgbmVlZGVkIGluIHRoZSBkZXNpZ24uDQo+Pg0KDQo=
