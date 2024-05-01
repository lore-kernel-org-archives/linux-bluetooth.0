Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2098.outbound.protection.outlook.com [40.107.15.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43233CD1
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 May 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714560967; cv=fail; b=P+gi8DH2e9FrHjuxT3aNPEtodbmB+C26k1RzPlZFsT2ckvMorizWXw25scoAowiFYZJPdBbVPqzQOrlC/zQCW15dyT95L6fiHXhlEqYR3pIrpgjS6JQ5sjUZTe+XvvvO0A7Wvnjh2CDBK34BetwLUdVfeJZSDdUiH86UoTohwms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714560967; c=relaxed/simple;
	bh=bC6TXObexyuc/HhJochXqANLrjQKsrc0lx8jQN7hI78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HzwIUMNaSDbTgFtuX2LeGZLWSmbt79mPfsVo3ZHPPxCBtf1j7lrWD9eZREc0vzvdsk0eBJSKIPV7w1CzdkPs4lnVbFfmoiAW4ErugRG1jtdi0zZURxcbRDFEHC6P8lZDmyWLs8tXzUYtrM62+BIvObxkBGqILbvCpl/wTyoiADw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net; spf=pass smtp.mailfrom=surban.net; dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b=CtqQ/wDi; arc=fail smtp.client-ip=40.107.15.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surban.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surban.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=surbannet.onmicrosoft.com header.i=@surbannet.onmicrosoft.com header.b="CtqQ/wDi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jeo/UNBA87vNh/K9i57tef4lYHBUcVto2Vg5hPyu8P+aCwiJxgdnYB/WCxj0WsRRDvBJNzft7wnUrYRscagOjiEN5jS+1Sc9QFD0pAvRi4zpkuLb7KMZQTl8DVcUt8o1cUOqBAxj3YteMUqxi3fuEHZGOmveMG5qaIaXNd1j6G/c/Q95EVzItJ/GxypjyBZZA2WmpuQXZ4+DSI449swDZD7FDGgov0a9EY7ScoVJxZt1TS9pSrHMLGsXjLKPZCdCyvo2mWQ+NIEzHV2Io8E6E5D2nJYcwu1qaAjSxKjLgjHE0ENi4Gn7zXNtuF/OocH+l1G1K6bYiZYQQQmeIXbsEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC6TXObexyuc/HhJochXqANLrjQKsrc0lx8jQN7hI78=;
 b=DtnED9vmwIhzFzUXLa1hQRG6dkYyrfcu9bbgriNbLyMaX//PbnFkQ11WqJwhk0cea6zP00oxPLd0DTuVOLAd/JlYh5uW7W8dVOk+sh+ryuGTjavVFusEWJlnYyvH5TDPIvKdFlyITYhMmpMuVpj78UntHC9bCkwGHFSVvGSgUNbO5omdp/yuwI2ouiAsIJm8Et/tlfywUaw7JM3S050on4JMv1jpYR2hMKVfnqw1TVDKdTPOHN5rOWcawRGxkPlu8lWvjW924KdLdZDPadqMM3x/G0xPsuuFXN4AD+QvLw2G/UQpF+zlagQ3US9QBkSIBlAARAFrbvZu8wt4DAfBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=surban.net; dmarc=pass action=none header.from=surban.net;
 dkim=pass header.d=surban.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=surbannet.onmicrosoft.com; s=selector2-surbannet-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC6TXObexyuc/HhJochXqANLrjQKsrc0lx8jQN7hI78=;
 b=CtqQ/wDiihq1qLNgiXCBQMKIIlK8XmNWpKVrn+FMySPPgf6qiAc7wtPkKthsLfAThcTmpeeNuyHvXgD547pw0JHoKgb29QhBO1VMHoW4ZZ+DtTYXiFyHh7D4bXbxklZmy3/oEPDpQQrACAF7aZ56FfmHng3iuao1ejCj6hlUPRc=
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:37d::18)
 by VI0P189MB2797.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:257::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Wed, 1 May
 2024 10:55:56 +0000
Received: from DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1]) by DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
 ([fe80::7185:1ee3:7e5f:f9b1%3]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 10:55:55 +0000
From: Sebastian Urban <surban@surban.net>
To: Pauli Virtanen <pav@iki.fi>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v8] Bluetooth: compute LE flow credits based on recvbuf
 space
Thread-Topic: [PATCH v8] Bluetooth: compute LE flow credits based on recvbuf
 space
Thread-Index: AQHam6+av24X03I5gUii7C6AFqX1jbGCMWcAgAADgAA=
Date: Wed, 1 May 2024 10:55:55 +0000
Message-ID: <b84db68c-92b6-45b0-936a-690f9c2fc9e5@surban.net>
References: <20240501100859.175690-1-surban@surban.net>
 <4d3f75c22f6f07ffd34ad78f1868e6c0d4969537.camel@iki.fi>
In-Reply-To: <4d3f75c22f6f07ffd34ad78f1868e6c0d4969537.camel@iki.fi>
Accept-Language: en-US, en-DE, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=surban.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P189MB1978:EE_|VI0P189MB2797:EE_
x-ms-office365-filtering-correlation-id: 521dee8d-9474-4100-23c1-08dc69cd4698
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Nk16RytNSnB4dGkxc0grS3RPRzg5THZJUEdyNWJLbi80dmQvVTQwK0dTNlhD?=
 =?utf-8?B?UFpGZ0F3SUpBYVFvNGxNM2c5cUYyTUNDMEl1dU9uZThVa2U3K1F3d0oxSWJT?=
 =?utf-8?B?dnJpaGJWRnFhU2p6OFRMajhHWDVCeVkrVGVGb1gyaWJpNXRtTENMV09PdDZy?=
 =?utf-8?B?ZmtlWFU0YWpPSjFucXF1ankyTjdyUTFDSHRSVk1RbEJGWkp2Z3BzU0VmL0Y2?=
 =?utf-8?B?YWQvTU5KUWJQZ3FiMHY4bU1yeEVkY3UvSFduRkJsRTRKRDZnbXE4Mmx5Q1o3?=
 =?utf-8?B?Z3VoU3RPQXpZdGNDVmhIbENkNDVhOER0RVdPWGc0NmpQVmpMVjlQa0FLa3dL?=
 =?utf-8?B?ZFl3cHVLekI1VTBwN3ZaZVl6UXp1Qnk3TXBjMlVxd2xXTjZmNHJwdzJLb2tY?=
 =?utf-8?B?eWxoSXY1KzdDczFJRjV0ZVZEZFZObHNCR0RlbVVneVNPcUlHMnJMNy9WbW5X?=
 =?utf-8?B?KzRiZWlrSU5acGowbmZRZURDaHJzVjZpMGRDSjlJQW50TU5wWnlNMzJjMldn?=
 =?utf-8?B?ak1Lc3ltYnozL3ZtRVFZK2xQY0dzd0pWbm9rU2tOTlNQd25zNEJ5TXV1elpl?=
 =?utf-8?B?SEhWZ2psbnVhYlk4OGY1M3dSS24xS0krbFFiT3lPczRBWSs1bkNkVFc5UDFk?=
 =?utf-8?B?WEZzU0tOOHBkdnhMdEM0bUM2aFo3Z3JsYVBrTWlWQkNGOE9Xd0hxRHZJZHY1?=
 =?utf-8?B?L3RHQ2F1QXllaUVscUZFaFB1Q0pDWkJENHpSR1Nncnljckl0UWVJMkcrOGx1?=
 =?utf-8?B?ZkZzdWczRC9YNXhsQjlRaW1ISmtqV05YN0tGVmVRUWRzWjhiS09kYWY0Q2Jo?=
 =?utf-8?B?MTdXRUZ0d3puYUlvQ1krQ1NiUXlYalI2SEF2Z3B0endONU9xdVF1SFpUK2VQ?=
 =?utf-8?B?eitSWHpiY0tWdFU4bTN4NWtWVkhHNVdIdVMwL2hwL3p3dG84UUdBM3F4Nnd2?=
 =?utf-8?B?RzN1aDRFaTZHUERBSlA4K2kweWpRcWJSMU95NE92TUNIR3BaS0YrdGl3aGln?=
 =?utf-8?B?RjJzTHI2TmhtSEEwWWs1akFDRlZuTVNvMDB2bjJaSVMvc0MxOHhQMmNocURr?=
 =?utf-8?B?S2tqaTdDUXhkSjBmaEdpWVo0Sk1FTjBXWk42V2hvb3hIenp6b01VOUFhZzFE?=
 =?utf-8?B?Z0ZMZWhsYTkvVGYwR01QcXpXLzM2VmF1clZMWmFTd3lBb3JoQ01yZ2hGK0hw?=
 =?utf-8?B?VEp0cW9zTTMreEVmTW8zWkNjai9Xb09CUndkOFppYjl3OENoYzVCSzZNZnBT?=
 =?utf-8?B?ekYzZG84Rm5ERm9iNkNHLzk0WGI2OHNadWZLRElQK3Y0L3RiZEUxQS9ITGV2?=
 =?utf-8?B?c3FQcXNyTXRvUFQyallkbFhxTWdWbFNFNi9qa1NjUzZnV3A2c1cyaDQwTTB6?=
 =?utf-8?B?aEs5Nm5WNzFHalh2OUZiTmZaTUhHREE3Q016MGtSbllEUDN0c1BvTDJMWW0x?=
 =?utf-8?B?cTFkclBGQWFIZm41Z2FOdEZXREFiWFY2aXBuUnpDLzd0OTNKQytuUFVqSFB5?=
 =?utf-8?B?UlZDUUFiMVRzc0xQNFprTnlhTTVFemFzL0V1Ykd2dVZMcHZzZkR6NjY3Yldj?=
 =?utf-8?B?bWp0NzFxWGdZcHVxVkpRRzBPTjRQWTdXRWI0aDFUbTU2bUZSUHlOVWRqL2Vo?=
 =?utf-8?B?bEptN0J6MUgvQ2VVYVhteVJRZit0QU15VjQveWNxc0ZPQVBCRTJvQVVKZzRG?=
 =?utf-8?B?Q3ZVbXhvcHVEYlpiaHAwSnhCbTl4L3UrZFBnRTNBbGdlOHBsUFVvSGl4VGIy?=
 =?utf-8?B?Tkc2ako3QWx2ejNLZllPbUZrYm5lNC9EdlRvMWJtMHFRNDdiMWRoYWFvZ0J2?=
 =?utf-8?B?a1duOFFMWmtLS2NXWnlTZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P189MB1978.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWZuNmZwc1NxeUFwWm1RQzhIdjdkb2l0S1h4STVJV3J2V3Y1SGQ0UEx4OTZs?=
 =?utf-8?B?ejFGSmJiSUVIelByOC96aTM3K09RODE1d1M2VHJsZEl3RndlREZ6L2Q2RkZT?=
 =?utf-8?B?V2NsblNyNDZraXpMcGxSMUt1MkxHVytTY21UMmxnUmdzNXMzWWNsd1gvWWNh?=
 =?utf-8?B?VlMxM2lPck4zUGloYmd5UHpabURROERmTUwwOTRtMWtXVk1EV0VYM1J4czh0?=
 =?utf-8?B?VkdDYWpZV2hzV3M3bVBDRTVEam1jbU5oSXArdGNCUDgreVNLTGl1ekhLK0U2?=
 =?utf-8?B?QkIyc2NUaGJYTDFYWWVqbmdzdHFjT09pRkRiVHVEeFpQenB2SVhiRzhpdHI5?=
 =?utf-8?B?cnk3ZnYyV2xKaTFPTGJCbGJMdEhlS2E2bTN2OFdRZzl2QTFGcWFOVzE1VmZE?=
 =?utf-8?B?dWd5bTBnK1VhMVlzWDJaK3Y4MG1XYk1kWVNrTzQzdkljUk9TbllkNkczTnBu?=
 =?utf-8?B?OGI5OWdSMStSUHFUaDFSeXYrdEpyUm1xcHdQZUY4alhkdzVLQnVzK0RUTkUv?=
 =?utf-8?B?dzNwclp2TFFnMUtTNzZNdFl3UWVJRkhNRCtISlZrRXNCUFpHNlNQREVub1lU?=
 =?utf-8?B?cG1KRkJUNXFxeVZrZ2owYnp5ZUlxMHNtQSszWjhsMUp5MFdTVHFtQnpYRlV2?=
 =?utf-8?B?MG9rdWM3Z3BqZERNUE93MVlBdHI3QjRFSkNmbnVYSTJrNEE3RXNNOEEzdVJm?=
 =?utf-8?B?cTJaUHNNMlI4UENOYWtCL2padVVGWEMvM1MzSmR1K2lranV2anIzTjNhNEhu?=
 =?utf-8?B?Zm9RMEtTeGsxbm5oenNCS2VMNEhLeFFDYjNyNi9uQ3J4S3EzWTIyd1UxTTVz?=
 =?utf-8?B?eFNzQXlNeFJjck5kM2trZ2VuQXIzMHZlOVZ2VUM0UlBBYnRrTTdrTG1ONFJv?=
 =?utf-8?B?NFU3T2x3RitzRENXQ1VxOHJMckE1Y0lwVEhDMEkzUys4OVRJT3lXdHNQQURp?=
 =?utf-8?B?ejYxVUM1TERRNWQrUFFGRUV6WlN6Yy9ZUEVWSnlwSFlOVHY5dWYvMEo0R1dY?=
 =?utf-8?B?bTFGSjBTZi9taUtFTTlYVkM3WHJQTG5OenBpQTJkYVdUREx2UytWbDd4bHpk?=
 =?utf-8?B?UDRLS0hqNGx1VW5uQ3VCRHpWdkVkRk5tNXhxNlFiN2RsUEpVeVkwWldidjN2?=
 =?utf-8?B?aWNJTlFDM0xzbmNQbm40bUZYb3BvV1JKRWYwZ3Azb29GWXVETVFCQ3l3bUEw?=
 =?utf-8?B?S3gyRWkrT1pjUzV2ZmVKK0JlWEVPSnBDcHd2dkh5VzVJVHpYMVdJTXZBY3Nj?=
 =?utf-8?B?Q2pDekVoaEtWbDZuc1A2SEI3UTJHNksveUlKb1c1VHZXbS9PdUZrK1dsUVRQ?=
 =?utf-8?B?bDhKMVFnTmIwQ3BpclhwNDFyZU1sdlZOdGpZUGxSV1VoQkhoaGtyRU1qNDBW?=
 =?utf-8?B?TWNUcE10emJacDMzWVZBVW9xcEJjb0xaNGwyanE1czAzY0dzRE4zWDZrUldx?=
 =?utf-8?B?QmMyQ3FOWnBHTy9Jc1I0VnhJNHQzL1RPb04vY1A3aFRXdEZ6RU03bE1xZWph?=
 =?utf-8?B?b0sray81N2hqdC90WmZQSVkvYmIwK21CUlZkZGY0dHV2eGZKajR0SGpTeEVR?=
 =?utf-8?B?OG1zYWljZFZtd3E0cXQzY1pjRkI4T01kYXZXNC93NHc2bE1CaEMvQld3U2dm?=
 =?utf-8?B?ZUJOemUzN2VuUGdTNjhXM0ZsYUx6QTZMdTA1aEJJajJ0NU5URDUvSkxRYmZn?=
 =?utf-8?B?WDVNdDFZS01ISWlQajg4UHdUOWNQZ1l0ZndTMHdralpNN256UDRpMGlULzFa?=
 =?utf-8?B?RVBpU2s3TjV1RXJIZk9lbjA2eXZjOTgzYkZ5WVRyNFYwZ3N0UTBaSnp0ZFpi?=
 =?utf-8?B?S2tSK2hyaEw4c3g5QUJXOW5FSTJ3V25OMHhaVnJpbWtyT3QxVGFYRk03eHZt?=
 =?utf-8?B?RkVZM3ZUZEM1Zi9oc21OdVhrRmo3bUNKUU9OZlBTM1RlRnRDclo1WjJ6Rmc4?=
 =?utf-8?B?c1ViZFJoeFVqZ0pQTEZBR3M1bThYZk9mdS9MS3NYbW5uazNacVhPMWVvRDB2?=
 =?utf-8?B?eG52OGxYWVRWc3Frb3I1MjhXenhtYkRoT0VpWTFuYnBMRWNFc1UxYjJNQ2hC?=
 =?utf-8?B?ZzRFeWVzTERyYUhJQ3NMOFJLMVBIa0FIRWdpU0MzQ21TYk5tR0FJUEhvampB?=
 =?utf-8?B?M0V2M0VJNnJoOTRaSlNGbjN6eHJIMDdIWm5zVmlFTG50bGZBL2xEbXVsR3pG?=
 =?utf-8?Q?fIQt3eiQbKyS4X289lk5U2U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08DBE7B3A7254D489C1AACD397C41896@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: surban.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P189MB1978.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 521dee8d-9474-4100-23c1-08dc69cd4698
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 10:55:55.2887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a27af4ff-c4b3-4dec-be8d-845345d2ab67
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z39u4XauKG4YevK/TUKpQTPclSLhc/2SEPigHqJT5owHke9Z9I+4RHGh2SqsC0zdaJ7ljADp53DLmJMMpvuTig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P189MB2797

T24gNS8xLzI0IDEyOjQzLCBQYXVsaSBWaXJ0YW5lbiB3cm90ZToNCj4+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL25ldC9ibHVldG9vdGgvbDJjYXAuaCBiL2luY2x1ZGUvbmV0L2JsdWV0b290aC9sMmNh
cC5oDQo+PiBpbmRleCBiNmVhYzM3ZjViNzQuLjJkZDc3ZGUzOGQxZCAxMDA2NDQNCj4+IC0tLSBh
L2luY2x1ZGUvbmV0L2JsdWV0b290aC9sMmNhcC5oDQo+PiArKysgYi9pbmNsdWRlL25ldC9ibHVl
dG9vdGgvbDJjYXAuaA0KPj4gQEAgLTU1NCw2ICs1NTQsOSBAQCBzdHJ1Y3QgbDJjYXBfY2hhbiB7
DQo+PiAgIAlfX3UxNgkJdHhfY3JlZGl0czsNCj4+ICAgCV9fdTE2CQlyeF9jcmVkaXRzOw0KPj4g
ICANCj4+ICsJLyogZXN0aW1hdGVkIGF2YWlsYWJsZSByZWNlaXZlIGJ1ZmZlciBzcGFjZSBvciAt
MSBpZiB1bmtub3duICovDQo+PiArCXNzaXplX3QJCXJ4X2F2YWlsOw0KPj4gKw0KPj4gICAJX191
OAkJdHhfc3RhdGU7DQo+PiAgIAlfX3U4CQlyeF9zdGF0ZTsNCj4+ICAgDQo+PiBAQCAtNjg4LDEw
ICs2OTEsMTUgQEAgc3RydWN0IGwyY2FwX3VzZXIgew0KPj4gICAvKiAtLS0tLSBMMkNBUCBzb2Nr
ZXQgaW5mbyAtLS0tLSAqLw0KPj4gICAjZGVmaW5lIGwyY2FwX3BpKHNrKSAoKHN0cnVjdCBsMmNh
cF9waW5mbyAqKSBzaykNCj4+ICAgDQo+PiArc3RydWN0IGwyY2FwX3J4X2J1c3kgew0KPj4gKwlz
dHJ1Y3QgbGlzdF9oZWFkCWxpc3Q7DQo+PiArCXN0cnVjdCBza19idWZmCQkqc2tiOw0KPj4gK307
DQo+PiArDQo+PiAgIHN0cnVjdCBsMmNhcF9waW5mbyB7DQo+PiAgIAlzdHJ1Y3QgYnRfc29jawkJ
YnQ7DQo+PiAgIAlzdHJ1Y3QgbDJjYXBfY2hhbgkqY2hhbjsNCj4+IC0Jc3RydWN0IHNrX2J1ZmYJ
CSpyeF9idXN5X3NrYjsNCj4+ICsJc3RydWN0IGxpc3RfaGVhZAlyeF9idXN5Ow0KPiANCj4gRG9l
cyBpdCBuZWVkIHRvIGJlIGN1c3RvbSBsaXN0LCBvciBjb3VsZCB0aGlzIGJlIHNrYiBxdWV1ZSBp
bnN0ZWFkDQo+IChzdHJ1Y3Qgc2tfYnVmZl9oZWFkKT8NCj4gDQo+IEFGQUlDUywgaWYgdGhlc2Ug
c2tiIGFyZSBnb2luZyB0byBnbyB0byBfX3NvY2tfcXVldWVfcmN2X3NrYigpIHRoZXkNCj4gcHJv
YmFibHkgY2FuIGJlIHB1dCB0byBxdWV1ZSBiZWZvcmUgdGhhdC4NCg0KWWVzLCBpdCBtdXN0IGJl
IGEgY3VzdG9tIGxpc3QuIER1cmluZyBkZXF1ZXVlaW5nIHdlIGRvbid0IGtub3cgaG93IG1hbnkg
DQpza2JzIHdpbGwgZml0IGluIHRoZSBzb2NrZXQncyByZWNlaXZlIGJ1ZmZlciBhbmQgSSBhbSBu
b3QgYXdhcmUgb2YgYW55IA0KbWV0aG9kIHRvIHBhcnRpYWxseSBwdXQgYW4gc2tiIHF1ZXVlIGlu
dG8gYSBzb2NrZXQncyByZWNlaXZlIGJ1ZmZlci4NCg0KLS0NClNlYmFzdGlhbiBVcmJhbg0KDQo=
