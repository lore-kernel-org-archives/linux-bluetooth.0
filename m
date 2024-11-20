Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD81494DF;
	Wed, 20 Nov 2024 04:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732078112; cv=fail; b=VMx4zpkQ5qr3pH7Z6bprRUxj+xFplGSS1guaqAuOO8qHXiKbIsShc3WnhHiDdxlCXSAbAzG5fJVkdju1/IrG2QXUjrj9nQ9QcAaL8tVgG+VcS63x4LWP2xrM99ofqBjUkKom6P9o5c42vRSqgEnMUqiSZyZnIVgF92uKcS70bPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732078112; c=relaxed/simple;
	bh=tdoiL7L6/nKWIQDaygDDhIJxNTdH83gc9N+8WgcD6FM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pfXY/yG7hEEXG0uYEgGkAv7Ze4oJXA+eO+VBjdQQrbhPEhuAE+PJWQnt6hB3gZWv93tx4U8aq3ZN4DnmMAm/h/1jISe8hgcHmLZ48iHFIhqiI6/HpIG/kSQx+ZUgIaXN9+tw1yCZ8leZtHp5kCPQweyFuHjQtM6g6BzPoNed/8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kYaHhzrN; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kYaHhzrN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1cK2lfVvgmzyx+gpgpYljYtN4xYKozwMJyos1ghX9YioTr2Rdb5tLubxm25eA0hGWTG8+0RR1X60eEXu8GkkKFObGCXTcMLIfmI8daY/HrNS3Tn+ShZJaE36DQhs4YZPh57/51NLAxlzSjiGqqnZDBJCfi2oVnaEgfE44s3B+Hb5iV7smd+6Yq9pzvWQqOysVW7i1+5lC3+T1qo7yiMaPmDtRWlxMTm5q2Zu+Szx4inhK7j87efHRpJNhYaxtaN5fus3xYn9giaAALILr3/yyikJME3jHYVnXaS4PeWaQF0JoLqPywK3WFzcGfLTPCk4K7tgH6qkjnkibMGrGhrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdoiL7L6/nKWIQDaygDDhIJxNTdH83gc9N+8WgcD6FM=;
 b=jrgDgPIeDuOdKpeV3aCJpKvPW0FeBmzUuik5mpgVx6m2xa296S4rbgR74PJ8Ca7jhPeftceCG19dJ8/0TSgQJA5SkMr7bmyKzcUBA707fNVuCO8u1DZX4i50nk6jPzgKFcqsNluVpakq1sB0xAlrPMOqmZBImVJfhviu6DVwZCLZDAOqULkUWgbBULYCCIaZqxx6eSGIeneHk1AXjTKRABpKLleBU+ackpbnsixNsV/bIUM6OFoPYVsk8j37rIYyhBL3X89w0a8R52JEtHS2hFotzBs2p7+8FHmx98eFonnQbPmMsdX2qkH5zPVl5IDhz+o04B+H9iodEbeCvf0bBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tdoiL7L6/nKWIQDaygDDhIJxNTdH83gc9N+8WgcD6FM=;
 b=kYaHhzrNyi/+Xb1CglDe7og5uCfHOVnEOuVgte64Tcm0JL0BfwF0QcNQKBBJaHIuJ6BeQQMPaekAK0B20erNIcoXVV0d4S7I20exInhpVTPMJIoKbR8glDjponq2HmtFxDsAVz3VGb55G80jVANbdJ3sH7W7PYXnsNJdQLqCtNl/D64x11vThcg735ZqYTKdsMh/HnJNuaXjza8kZKJIzzbe+BkIRy0Z/WihxbP4ZqPEGeEHWzP5spKS+hX65PXQfhT4BoLKFIRnhy14fL7yYAEfdBFYrmer+c6Pys2nZOAlQ9poG4RQtK1ccjdsh0SIErq3jxMXiGO0uoYXbJZcdQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GVXPR04MB10235.eurprd04.prod.outlook.com (2603:10a6:150:1be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 04:48:24 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%3]) with mapi id 15.20.8158.021; Wed, 20 Nov 2024
 04:48:24 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>, Sherry Sun
	<sherry.sun@nxp.com>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
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
Thread-Index: AQHbOwduGCX/L1R1dUWpA4xXjsuCQg==
Date: Wed, 20 Nov 2024 04:48:24 +0000
Message-ID:
 <AS4PR04MB96927FD617D139087C38D437E7212@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20241004113557.2851060-1-catalin.popescu@leica-geosystems.com>
 <20241004113557.2851060-2-catalin.popescu@leica-geosystems.com>
 <DB9PR04MB84296D227CDA74D732399B9C927C2@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <7f40433e-0474-449f-b4e6-de69d5082043@leica-geosystems.com>
In-Reply-To: <7f40433e-0474-449f-b4e6-de69d5082043@leica-geosystems.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|GVXPR04MB10235:EE_
x-ms-office365-filtering-correlation-id: 1fe61481-7149-4b38-799f-08dd091e912c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OVRwcFg4cjg2cFhoK0Z0SURGWnQ3em5qUnpTSmtoSlo0TWlaL2VUcjg4WmV6?=
 =?utf-8?B?cWR2UEZraDlxODNFb2xkaG16bGtOMTlST05qWVR2VzRRbkFZZCtwaVJaelBj?=
 =?utf-8?B?aGwxRW5Qckxod3FDVDVqUmJCazRmU2lMcUFMWjg2b0s2N0RaVVJXdWl6MEIv?=
 =?utf-8?B?NjZ5VUsxcXA0eVdyM2oyNHZVeHU5a1EwQjJJTEJIZWFXZmpML0lxNm05d1dr?=
 =?utf-8?B?RTgxRDZ2VTNsYnByaHl4ajFRdFlUMFVZUlBpaWw1L216c1Ywc3RHVVhTMTBV?=
 =?utf-8?B?STVWRFlLSmJqRE10UFZxNWZmZWFZT1pXOUMySDdFampoaHJnS2ZpRTBFZHFv?=
 =?utf-8?B?aDNYQ2c3ZUxXZXFqWldhTVUzSmtqMmlmcWtlSkkyUWlmWWlaaTNNN1JzV21S?=
 =?utf-8?B?c1BKcGZQYWw5N2xDSEFhamdSdWRSSHorVGR6RUNPMHkwZVlFSng3NVQ5SXZm?=
 =?utf-8?B?Y0hLN3VFcHBUendFcXROdHFpRVlpRGxsSlkxV2tjaXlaQVErQmVHSi9mQmd0?=
 =?utf-8?B?Tjc4dWZiY3VqSVp2UXlSN2hrSndhQlU2T003SkJqbnpFK1JpdFFlYWdiOEFo?=
 =?utf-8?B?TXl0d3VZMmdVMk52aTNnT1dTblQ0ZFNaNVRMcHpid1BYQ21Ra2p2c1ZGLzI1?=
 =?utf-8?B?RmJzQ2JON0hjVXhYQjBYTXptVTF0UWxVYzRGSnVhZzRjYkZwL3M5UVRHbDAr?=
 =?utf-8?B?S0s1SVlFTnV3ejJvUVpCd1MxdG4zTWNhMjNESWE2YWo3dmEwTjVwMEVmbmNZ?=
 =?utf-8?B?UG5yY3NHMjU2QkhkNVRLWlUwWGxyclN5VU1YTmJUeW1sRlJLbEs0UVVsWTZX?=
 =?utf-8?B?UGtia2RmTzZrUHdKak9Ba2hVNmxlbGRHQXhkS1pvUGhSWkpCM01CMDhZeHdm?=
 =?utf-8?B?UVVKVDJWWWF2aW9CN1NyTk9rVjZrdklZbkdsbUNxbDgwZzhVSnJwVVZ3MS9C?=
 =?utf-8?B?bzdLUVpVZVpsdWRsYS8yNjNRaCswNFJhQjNwS29qeXo1dldiTXVLNG5Udjh6?=
 =?utf-8?B?cFlod2JVVkxteWt2R0g4T0xsQlBIbUdEWjkzTkxYY3pyNG9nSVdOLy91RFJ2?=
 =?utf-8?B?MlljM2NpYUdaOGdHVCtDSXcydHpNWllhRlluZzZFWkNiOW1zMkJHaEw3c3Zx?=
 =?utf-8?B?TjdGNVNoWXZqVUUvdUVPaXZQU0k5aC9EZWtEWHhDempnZjZCTXBrQ1FrelBl?=
 =?utf-8?B?NVlLNGtQQkU1NHZYc21WQXFKT2drdHlHenkwM0R4WjZWU0FVY00vSDFLTnVa?=
 =?utf-8?B?L3ZieEdpcXpvdFIrWHRKVUdUWG1nSEIyOGQyQ2FidU9NUk9UZ29LNWRSN0dZ?=
 =?utf-8?B?YTZmVjBRQzhKYW1Ua0VVeUpkM21zWjJqMFF4NFFKRllIaHB1dkdlUCtla1ZT?=
 =?utf-8?B?SStDeGdDYitZMFRodVBnV05iR2tGdmlsM1BjY1ZPZjZhcWZyTFN0d2JlNFIy?=
 =?utf-8?B?eHNJZTk1NEhzT2dHY3BHUWJTUjFQTytHeVRVSVREc2FQekFkaFBQbzlZWXVm?=
 =?utf-8?B?TUlJdEV4S1Y3NzRITmpXSjlUcU1QUHRqSzRTbWlyQjJINWVWUWo5R2FZdnI0?=
 =?utf-8?B?N1p3WFBSSzU1U0YxcFlTOGxPVWZ3SXVzVGdkMGF0c2pXaE9aR3RlQnM4YTMz?=
 =?utf-8?B?NzA1MkF4TFVGNXdaOHh4cDNoc3BrUmU3bi9zMDlNZFltWHZRaEFIZXJRem1O?=
 =?utf-8?B?UDZDWWNpdUV1NGVUQjIzQ2VCU1VOQ0xmRTNjYnZ1dUYxSFg1b21FM3dMVVR6?=
 =?utf-8?B?Rm5RQ3BZVlVLTXo0UGhnb3J6Z29za2NXNlNDTFc5L1gwQTJ0dVRiRnNOS094?=
 =?utf-8?Q?23ynN6KXpQOfzTu+mX8TxxMoFq6WPxTmmxJyA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjF6MzEwMlptNWt5TEZzZGRaWXlucFNFTEI1cU5PdENOcUZQU3FHQ2FGMjFU?=
 =?utf-8?B?bTRhQllyNThXanBweTFaMVY4NUx0Ty91cTRXK1J4L0RrelVpVTRuTUF5dGhS?=
 =?utf-8?B?dzVEMWFaVzJIbzM3U0ltc1hpWGY1QlBHVEdzT2o3ZEtYbldmOFMvYnZ4YW1V?=
 =?utf-8?B?M1pHWlZDUG5QTEM0Y1ZiTDBiZzZGYlRUQ0NGLzZ2REZTR0g4bHJWOTJCRHRS?=
 =?utf-8?B?c3hsZmVKU0NXNFBUeDZuRGhiRVZQRWE1cmErZUVWL0s5OStOVmlwMFp1TjAx?=
 =?utf-8?B?SlFLSmorTmFwbk11VXZoQzlNMHFOVUUzQzZ5QW84TlZqbjRUTGpxTFdGV0hO?=
 =?utf-8?B?QnEvTTRxSUxieXZYNjdpYXQzUDhtRi9BSGFnbFFEY0o4Z2Q1dHEvZWdoMmhk?=
 =?utf-8?B?ejlIVmlHb2p3YlpSQUd0VUIzckVXbS9yUlFBNHFGSmQyZ1RYdDVYTDgxRGlh?=
 =?utf-8?B?Z0d3bE9aNkJwM21kTzdaQzlTeXMvcXhQOUNINnJaRXpacWtuWk5leFEyTy9u?=
 =?utf-8?B?dmtIN3R2RDVFaStWRmp3cmVRc3NyVkliYjAxVEhIcHQ4K0FIeXlDc2tVUWVS?=
 =?utf-8?B?R2RueGI4ZnJSdS9kNFFWMDdQY2V3OXNLdWFja1VwY0V5WnJscGp5LzYvQjJB?=
 =?utf-8?B?NlJlVllQWnhXaXIva0IrU0JaOTlhVDZrd3lGcDNrc2R6djVhWWNCdDYyb2tm?=
 =?utf-8?B?bm9FQXBvREtFYmhZZWF6YnJZbkxBRzNFb3QvN2VrQStUSThIRXNrUGhFeGFT?=
 =?utf-8?B?YWx2YWdnTElVeUlMVmxva2gvR1JCbUJRbmtOT1hBb1ZjQU1Gb1pqR1VnbjJB?=
 =?utf-8?B?OTU3dFNoZUc0NDFCUk5wYit0cW5QSDUwVzZCNElSTDR3MUFlSVpTb0F1cXgy?=
 =?utf-8?B?Wk12d0VtZ1A1RjlNRmx5TCsxL011Z21mMTFKVHlrZmRvVVRsbFpRZEMwZ2Fv?=
 =?utf-8?B?M1pJR09Td2RWdHozaXZZcU9jZ2ZuS3ZMZVhIaUUzZ1Nrc3JBbXVwcFFxeGlL?=
 =?utf-8?B?QU1jVVZTNElOMFhlU1NhRVFrUTdBYmNUNEs3cVBuRCtkYnU5VVRyVUtEYVdY?=
 =?utf-8?B?WGpYNmlxbkozSWhibWdXYitmN0NuMk5QRUZRZjh0KzQ3cGtUTHZiaUozQUw5?=
 =?utf-8?B?R1BzRUR0SVFUZjJVQzFSZG02K0hUSVR1VmNOQW4wSEovM1MvNTNPYkltdFhm?=
 =?utf-8?B?NFFNWXBqVmpHVmJtcnFXbk95bWtiNy9MVUpwKzY2dStJTUFWY3ZKYjY2RDBH?=
 =?utf-8?B?cXdPSTlFNUxZR1VkbG9qU1NXMzVBdzhTOUJ6WHhXbEFxTXhxbjE5cXRJTC9Q?=
 =?utf-8?B?ZThjaUtIa0xwdnBQL1pPUmMzRjR1S3hWOTJxcHhwbXF6U0QrUHNzRDhnaFlC?=
 =?utf-8?B?VGt4eWVCNnIzMXpYdjVuMHJ3Q3cyQnpTNC9PVGpQQ3NnTDFlMjdhbEFOWnk0?=
 =?utf-8?B?RWgraXBUaFBVVGRHNWtra0xKQXJyZUs4aE9VM20wSlFnblQ0dXdmRlFxblMx?=
 =?utf-8?B?OFUwaFQvSk9SUC9YQnhScG04aExUVXI4SFphTU1uME9HKy9jcFpFakJyWnpu?=
 =?utf-8?B?MjU1eFNvYmdEK0Q2a2dqY3JxV0NiMFdScnFyNE5qS1lBZ3lMaWxpT0xVcGlU?=
 =?utf-8?B?MTlvYzA2SzZNendiSUFVNDFxVkluR0t5ZkVDRHovYyt5MysxdE9WdVdQYUg2?=
 =?utf-8?B?ZUdYTVRmNGFpNXVEYVgyNXQrLy9HR1NEdGhOTHNxN09aT3daM3IyR25pUWhE?=
 =?utf-8?B?ZGRHRXVyN0pKWGR3QmQ4WHUwSmJKS2Y1TnVldEszQUZEQ1J4VFE1dkZLWmVB?=
 =?utf-8?B?V0ZVckdmQ3VpZUthN2NyTzkrUC9uQmFBWm9jaTFxQ1VGYmw3bXcrZ0RIVWpZ?=
 =?utf-8?B?ZXo3MnJpaUhlZ2d1RXNTcEhwUmpnZER1VTMxY1ZPc041NzlWSXRSTXFla0NJ?=
 =?utf-8?B?d08yZjN0YkkzU0RzRzdYQ01sVGlYM2V3RDd2VW5PTU1SSHN6bVhvRnhwWDlB?=
 =?utf-8?B?Yk9vdVRzMGNDZzBFV0EwbGZ4NTFVbjBDb0QycERsbEVRWUlIcHZZMmRoWHZu?=
 =?utf-8?B?UENCZHczZlVUWnpCM1IvZVdCaUE0dCtGNjBtdG4rQkJHcjZXQ04yVE1lbUJk?=
 =?utf-8?Q?c6M1nKF0NdgLShQuE11Ezf5uE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe61481-7149-4b38-799f-08dd091e912c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2024 04:48:24.5257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jB56L7vOvwuEpQluKBteNcjLoiwr2/gDFramCBwGhCxs7Xb6T0le9T9Da+rWOxJn/lEJVjcWdGL09mZjd20SUpwkBmF3ADE95S8acmqf0D0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10235

SGkgQ2F0YWxpbiwNCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2guIEl0IGxvb2tzIGdvb2QgdG8g
bWUuDQoNCj4gT24gMDYvMTAvMjAyNCAxMTowNCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gPiBb5pS2
5Yiw5q2k6YKu5Lu255qE5p+Q5Lqb5Lq66YCa5bi45LiN5Lya5pS25Yiw5p2l6IeqIHNoZXJyeS5z
dW5AbnhwLmNvbQ0KPiDnmoTnlLXlrZDpgq7ku7bjgILor7forr/pl64NCj4gPg0KPiBodHRwczov
L2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb27vvIzku6Xkuobop6PkuLrku4Dk
uYjov5nkuIDngrnlvojph40NCj4g6KaB44CCXQ0KPiA+DQo+ID4gVGhpcyBlbWFpbCBpcyBub3Qg
ZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3
aGlsZQ0KPiBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVwbHlpbmcg
dG8gdGhpcyBlbWFpbC4NCj4gPg0KPiA+DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+ID4+IEZyb206IENhdGFsaW4gUG9wZXNjdSA8Y2F0YWxpbi5wb3Blc2N1QGxlaWNhLWdlb3N5
c3RlbXMuY29tPg0KPiA+PiBTZW50OiBGcmlkYXksIE9jdG9iZXIgNCwgMjAyNCA3OjM2IFBNDQo+
ID4+IFRvOiBBbWl0a3VtYXIgS2Fyd2FyIDxhbWl0a3VtYXIua2Fyd2FyQG54cC5jb20+OyBOZWVy
YWogU2FuamF5IEthbGUNCj4gPj4gPG5lZXJhai5zYW5qYXlrYWxlQG54cC5jb20+OyBtYXJjZWxA
aG9sdG1hbm4ub3JnOw0KPiA+PiBsdWl6LmRlbnR6QGdtYWlsLmNvbTsgcm9iaEBrZXJuZWwub3Jn
OyBrcnprK2R0QGtlcm5lbC5vcmc7DQo+ID4+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHAuemFiZWxA
cGVuZ3V0cm9uaXguZGUNCj4gPj4gQ2M6IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiA+PiBsaW51eC0ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgbS5mZWxzY2hAcGVuZ3V0cm9uaXguZGU7IGJzcC0NCj4gPj4gZGV2ZWxvcG1lbnQu
Z2VvQGxlaWNhLWdlb3N5c3RlbXMuY29tOyBDYXRhbGluIFBvcGVzY3UNCj4gPj4gPGNhdGFsaW4u
cG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIIDIvMl0g
Qmx1ZXRvb3RoOiBidG54cHVhcnQ6IGltcGxlbWVudCBwb3dlcnVwIHNlcXVlbmNlLg0KPiA+Pg0K
PiA+PiBOWFAgYmx1ZXRvb3RoIGNoaXAgc2hhcmVzIHBvd2VyIHN1cHBseSBhbmQgcmVzZXQgZ3Bp
byB3aXRoIGEgV0xBTiBjaGlwLg0KPiA+PiBBZGQgc3VwcG9ydCBmb3IgcG93ZXIgc3VwcGx5IGFu
ZCByZXNldCBhbmQgZW5mb3JjZSBwb3dlcnVwDQo+ID4+IHNlcXVlbmNlOg0KPiA+PiAxLiBhcHBs
eSBwb3dlciBzdXBwbHkNCj4gPj4gMi4gZGVhc3NlcnQgcmVzZXQvcG93ZXJkb3duDQo+ID4gSGkg
Q2F0YWxpbiwNCj4gPg0KPiA+IEZvciBOWFAgV0lGSS9CVCBjaGlwLCBXSUZJIGFuZCBCVCBzaGFy
ZSB0aGUgb25lIFBEbiBwaW4sIHdoaWNoIG1lYW5zIHRoYXQNCj4gYm90aCB3aWZpIGFuZCBCVCBj
b250cm9sbGVyIHdpbGwgYmUgcG93ZXJlZCBvbiBhbmQgb2ZmIGF0IHRoZSBzYW1lIHRpbWUuIFNv
DQo+IHlvdSBjb250cm9sIHRoaXMgcGluIGluIHRoZSBCVCBkcml2ZXIgcHJvYmUgYW5kIHJlbW92
ZSBmdW5jdGlvbiB3aWxsIGRpcmVjdGx5DQo+IGJyZWFrIHRoZSB3aWZpIGZ1bmN0aW9uIEkgdGhp
bmsuDQo+IA0KPiBIaSBTaGVycnksDQo+IA0KPiBJIGtub3cgYW5kIHRoYXQncyB3aHkgSSdtIHVz
aW5nIHJlc2V0IGNvbnRyb2wgYW5kIG5vdCBncGlvLi4uIFJlc2V0IGNvbnRyb2wgYXJlDQo+IHJl
ZmNvdW50ZWQsIGdwaW9zIGFyZSBub3QuIFNvLCBiYXNpY2FsbHkgd2UgY2FuIHVzZSBvbmUgcmVz
ZXQgY29udHJvbCBzaGFyZWQgYnkNCj4gYmx1ZXRvb3RoIGFuZCB3bGFuIGRyaXZlcnMsIGVhY2gg
ZHJpdmVyIGNhbiBvcGVyYXRlIGluZGVwZW5kZW50bHkgZnJvbQ0KPiBvdGhlciBhcyBsb25nIGFz
IHRoZXkgaW1wbGVtZW50IHRoZSBwb3dlcnVwIHNlcXVlbmNlIChzaGFyZWQgc3VwcGx5IGFuZA0K
PiByZXNldCBwaW4pIGFuZCBkb3dubG9hZCB0aGVpciBzcGVjaWZpYyBmaXJtd2FyZSAoY29tYm8g
ZmlybXdhcmUgbm90IHVzZWQpLg0KPiBBcyBsb25nIGFzIG9uZSBkcml2ZXIgaXMgZnVuY3Rpb25h
bCwgdGhlIGNoaXAgc3VwcGx5IGFuZCByZXNldCBpcyBub3QgYXNzZXJ0ZWQuDQo+IFNvLCB5b3Ug
Y2FuIGxvb2sgYXQgdGhlIGRyaXZlcnMgYXMgdXNlcnMgb2Ygc2hhcmVkIHJlc291cmNlcyAoc3Vw
cGx5IGFuZA0KPiByZXNldCkuDQo+IA0KPiA+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IENhdGFsaW4g
UG9wZXNjdSA8Y2F0YWxpbi5wb3Blc2N1QGxlaWNhLWdlb3N5c3RlbXMuY29tPg0KPiA+PiAtLS0N
Cj4gPj4gICBkcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYyB8IDE4ICsrKysrKysrKysrKysr
KysrKw0KPiA+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspDQo+ID4+DQo+ID4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYw0KPiA+PiBiL2RyaXZl
cnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jIGluZGV4IDRmNDkzYmU3NjNiOC4uZTU4ZTdhYzc5OTlm
DQo+ID4+IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYw0K
PiA+PiArKysgYi9kcml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYw0KPiA+PiBAQCAtMTYsNiAr
MTYsOCBAQA0KPiA+PiAgICNpbmNsdWRlIDxsaW51eC9jcmM4Lmg+DQo+ID4+ICAgI2luY2x1ZGUg
PGxpbnV4L2NyYzMyLmg+DQo+ID4+ICAgI2luY2x1ZGUgPGxpbnV4L3N0cmluZ19oZWxwZXJzLmg+
DQo+ID4+ICsjaW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+ICNpbmNsdWRlIDxs
aW51eC9yZXNldC5oPg0KPiA+Pg0KPiA+PiAgICNpbmNsdWRlIDxuZXQvYmx1ZXRvb3RoL2JsdWV0
b290aC5oPg0KPiA+PiAgICNpbmNsdWRlIDxuZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmg+IEBAIC0x
ODgsNiArMTkwLDcgQEAgc3RydWN0DQo+ID4+IGJ0bnhwdWFydF9kZXYgew0KPiA+Pg0KPiA+PiAg
ICAgICAgc3RydWN0IHBzX2RhdGEgcHNkYXRhOw0KPiA+PiAgICAgICAgc3RydWN0IGJ0bnhwdWFy
dF9kYXRhICpueHBfZGF0YTsNCj4gPj4gKyAgICAgc3RydWN0IHJlc2V0X2NvbnRyb2wgKnBkbjsN
Cj4gPj4gICB9Ow0KPiA+Pg0KPiA+PiAgICNkZWZpbmUgTlhQX1YxX0ZXX1JFUV9QS1QgICAgMHhh
NQ0KPiA+PiBAQCAtMTQ1OCw2ICsxNDYxLDcgQEAgc3RhdGljIGludCBueHBfc2VyZGV2X3Byb2Jl
KHN0cnVjdA0KPiA+PiBzZXJkZXZfZGV2aWNlDQo+ID4+ICpzZXJkZXYpICB7DQo+ID4+ICAgICAg
ICBzdHJ1Y3QgaGNpX2RldiAqaGRldjsNCj4gPj4gICAgICAgIHN0cnVjdCBidG54cHVhcnRfZGV2
ICpueHBkZXY7DQo+ID4+ICsgICAgIGludCBlcnI7DQo+ID4+DQo+ID4+ICAgICAgICBueHBkZXYg
PSBkZXZtX2t6YWxsb2MoJnNlcmRldi0+ZGV2LCBzaXplb2YoKm54cGRldiksIEdGUF9LRVJORUwp
Ow0KPiA+PiAgICAgICAgaWYgKCFueHBkZXYpDQo+ID4+IEBAIC0xNDg1LDYgKzE0ODksMTYgQEAg
c3RhdGljIGludCBueHBfc2VyZGV2X3Byb2JlKHN0cnVjdA0KPiA+PiBzZXJkZXZfZGV2aWNlDQo+
ID4+ICpzZXJkZXYpDQo+ID4+DQo+ID4+ICAgICAgICBjcmM4X3BvcHVsYXRlX21zYihjcmM4X3Rh
YmxlLCBQT0xZTk9NSUFMOCk7DQo+ID4+DQo+ID4+ICsgICAgIG54cGRldi0+cGRuID0gZGV2bV9y
ZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9zaGFyZWQoJnNlcmRldi0NCj4gPj4+IGRldiwgTlVM
TCk7DQo+ID4+ICsgICAgIGlmIChJU19FUlIobnhwZGV2LT5wZG4pKQ0KPiA+PiArICAgICAgICAg
ICAgIHJldHVybiBQVFJfRVJSKG54cGRldi0+cGRuKTsNCj4gPj4gKw0KPiA+PiArICAgICBlcnIg
PSBkZXZtX3JlZ3VsYXRvcl9nZXRfZW5hYmxlKCZzZXJkZXYtPmRldiwgInZjYyIpOw0KPiA+PiAr
ICAgICBpZiAoZXJyKSB7DQo+ID4+ICsgICAgICAgICAgICAgZGV2X2Vycigmc2VyZGV2LT5kZXYs
ICJGYWlsZWQgdG8gZW5hYmxlIHZjYyByZWd1bGF0b3JcbiIpOw0KPiA+PiArICAgICAgICAgICAg
IHJldHVybiBlcnI7DQo+ID4+ICsgICAgIH0NCj4gPj4gKw0KPiA+IE5vdyBpbiBOWFAgbG9jYWwg
cmVwbywgdGhlIFBEbiBwaW4gaGFzIGJlZW4gY29udHJvbGxlZCBieSB0aGUNCj4gY29ycmVzcG9u
ZGluZyB3aWZpIFBDSWUvU0RJTyBjb250cm9sbGVyLCBzbyB3ZSB3b24ndCBhZGQgdGhlIHZjYy1z
dXBwbHkgYW5kDQo+IHJlc2V0LWdwaW9zIHByb3BlcnRpZXMgZm9yIHRoZSBCVCBkcml2ZXIsIHNl
ZW1zIHRoZSBjb2RlIGhlcmUgd2lsbCByZXR1cm4gZXJyIGlmDQo+IG5vIHZjYy1zdXBwbHkgYW5k
IHJlc2V0LWdwaW9zIHByb3BlcnRpZXMgcHJvdmlkZWQsIHdoaWNoIHdpbGwgYnJlYWsgdGhlIEJU
DQo+IGRyaXZlciBwcm9iZS4NCj4gSWYgeW91IGxvb2sgY2xvc2VseSwgdGhlIGdwaW8gaXMgb3B0
aW9uYWwgYW5kIHRoZSBzdXBwbHkgd2lsbCByZXR1cm4gYSBkdW1teSBpZg0KPiBub25lIGlzIGRl
Y2xhcmVkIGluIHRoZSBEVC4gU28sIHRoaXMgY2hhbmdlIHdvbid0IGJyZWFrIGFueXRoaW5nLg0K
PiA+IEJlc3QgUmVnYXJkcw0KPiA+IFNoZXJyeQ0KPiA+DQo+ID4+ICAgICAgICAvKiBJbml0aWFs
aXplIGFuZCByZWdpc3RlciBIQ0kgZGV2aWNlICovDQo+ID4+ICAgICAgICBoZGV2ID0gaGNpX2Fs
bG9jX2RldigpOw0KPiA+PiAgICAgICAgaWYgKCFoZGV2KSB7DQo+ID4+IEBAIC0xNDkyLDYgKzE1
MDYsOCBAQCBzdGF0aWMgaW50IG54cF9zZXJkZXZfcHJvYmUoc3RydWN0DQo+ID4+IHNlcmRldl9k
ZXZpY2UNCj4gPj4gKnNlcmRldikNCj4gPj4gICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07
DQo+ID4+ICAgICAgICB9DQo+ID4+DQo+ID4+ICsgICAgIHJlc2V0X2NvbnRyb2xfZGVhc3NlcnQo
bnhwZGV2LT5wZG4pOw0KPiA+PiArDQo+ID4+ICAgICAgICBueHBkZXYtPmhkZXYgPSBoZGV2Ow0K
PiA+Pg0KPiA+PiAgICAgICAgaGRldi0+YnVzID0gSENJX1VBUlQ7DQo+ID4+IEBAIC0xNTA5LDYg
KzE1MjUsNyBAQCBzdGF0aWMgaW50IG54cF9zZXJkZXZfcHJvYmUoc3RydWN0DQo+ID4+IHNlcmRl
dl9kZXZpY2UNCj4gPj4gKnNlcmRldikNCj4gPj4NCj4gPj4gICAgICAgIGlmIChoY2lfcmVnaXN0
ZXJfZGV2KGhkZXYpIDwgMCkgew0KPiA+PiAgICAgICAgICAgICAgICBkZXZfZXJyKCZzZXJkZXYt
PmRldiwgIkNhbid0IHJlZ2lzdGVyIEhDSSBkZXZpY2VcbiIpOw0KPiA+PiArICAgICAgICAgICAg
IHJlc2V0X2NvbnRyb2xfYXNzZXJ0KG54cGRldi0+cGRuKTsNCj4gPj4gICAgICAgICAgICAgICAg
aGNpX2ZyZWVfZGV2KGhkZXYpOw0KPiA+PiAgICAgICAgICAgICAgICByZXR1cm4gLUVOT0RFVjsN
Cj4gPj4gICAgICAgIH0NCj4gPj4gQEAgLTE1NDAsNiArMTU1Nyw3IEBAIHN0YXRpYyB2b2lkIG54
cF9zZXJkZXZfcmVtb3ZlKHN0cnVjdA0KPiA+PiBzZXJkZXZfZGV2aWNlICpzZXJkZXYpDQo+ID4+
ICAgICAgICB9DQo+ID4+ICAgICAgICBwc19jbGVhbnVwKG54cGRldik7DQo+ID4+ICAgICAgICBo
Y2lfdW5yZWdpc3Rlcl9kZXYoaGRldik7DQo+ID4+ICsgICAgIHJlc2V0X2NvbnRyb2xfYXNzZXJ0
KG54cGRldi0+cGRuKTsNCj4gPj4gICAgICAgIGhjaV9mcmVlX2RldihoZGV2KTsNCj4gPj4gICB9
DQo+ID4+DQo+ID4+IC0tDQo+ID4+IDIuMzQuMQ0KPiA+Pg0KDQpSZXZpZXdlZC1ieTogTmVlcmFq
IFNhbmpheSBLYWxlIDxuZWVyYWouc2FuamF5a2FsZUBueHAuY29tPg0KDQpUaGFua3MsDQpOZWVy
YWoNCg0K
