Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2058.outbound.protection.outlook.com [40.107.15.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D385942
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262969; cv=fail; b=RIQNrxM5hs/Oq+XSxRGaO5lK16a0eia9WetU4W9DAiYaZ6tGxRLtJJ8gxgtqtIYRQmtLYq3TVuYDch+Yr7YANvLzxKXskrZ7R6ojXKOeOUBY7YPajIMUSlwy8fUnRCRIF1sasecW9JN+YZjx6y+/23TEcGgGZYeM7U0gMrM5cEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262969; c=relaxed/simple;
	bh=kgHjoHYijbYU2awa63xxBWGf5D4w9rB1/AZwRUWZTmU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=spM7rgK1pD8KZ9INN42V85xo5+PO2eYhGOkinrmrU9UFdC3QQ9vbYUufr8fjdBNgbxSic6ky5iL7j4QkjeBOJop5cRkDiPDzY71j5gg5K5BrZ969x0T2lbf2Ya/Myb7QK5krTlXuYvAd8nJq/aigk+4KjIpMn4fmARxUnIv9yKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ihFS/JVb; arc=fail smtp.client-ip=40.107.15.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ihFS/JVb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOe5PGHTQe8PUGwsZbIhGZi7uhcs5/8eHjMdxXxdLmdZkKapfsWGSPTQdzEQdjuAO2S7IKtHHsjTNgIZmujAuy6leblYEP4DDEjrPdqxSrx3S2hQlDJH1+/HiA00n+Wud4UchZPC+RVz2FXxHCUC1s9gGRSc0/AsDRvMz0XpsSii5TWzlYvudu+b277G6gndAf2fcPFIHg31xM1cXbxNC8l3hg0pZJ64ZImKMYSTa2VaBTLuc9c7jkL34tCokfFkgBy9XgWLDtW/AhNed/9NPZ0/Z3SNWr3XZNRjvQqy4evZbfjP95KdzkB8cGnyQLN1ysxHkiVuaO6mwRxgd5DLlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgHjoHYijbYU2awa63xxBWGf5D4w9rB1/AZwRUWZTmU=;
 b=W+aOtBbWRIReC1PR7o+C/hv/bMN0+Y+aI/tx0NKqFIaEQAN2SRslbjV4PZ/4uyKF2AsqQ0CrO0MbFNbQA64K4bBe/LKhmfsZZFKOtveUFjXHbQGmESKfXUwtVcVIu+4vOwWFTIyTO0Uhv8YA/whKN0qK59onveDDC1LtuQuYd+mqpZfz9Tb7aA5qnH7TPSOK2TOkgFnelpeoa1oH0asmSjEZXNF1CmgzzltRVRVIyL9JvVN/w3ORlzuGUK/Ke/O4NJs94nFl1BL+buFTA7eN34MN5t9Fs2YFAYWrics8Q2Rn+OULUvfts2Itf2sErkCEZbLnu/umfgu382W66pGfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgHjoHYijbYU2awa63xxBWGf5D4w9rB1/AZwRUWZTmU=;
 b=ihFS/JVbCGEFLkE9Sm8eX0QS7GT6TIzyWdyYWlzCKUv6l/ao602VL9vYRe+n0f+hO1bc3Qk+WffVxXMm2AP3eeWP0omQCuYkQ5AC8lUti+n+CaeClWoBX490KeK3noTK0i/uNVG2/lwlss6QBZNCqvKxf87yXDaOi6+LawEX0DM=
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by GVXPR04MB10518.eurprd04.prod.outlook.com (2603:10a6:150:1eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Tue, 16 Apr
 2024 10:22:42 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 10:22:42 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Claudia Cristina Draghicescu <claudia.rosu@nxp.com>, Mihai-Octavian Urzica
	<mihai-octavian.urzica@nxp.com>, Silviu Florian Barbulescu
	<silviu.barbulescu@nxp.com>, Iulia Tanasescu <iulia.tanasescu@nxp.com>,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/1] Bluetooth: hci_event: Fix setting of
 unicast qos interval
Thread-Topic: [EXT] Re: [PATCH 1/1] Bluetooth: hci_event: Fix setting of
 unicast qos interval
Thread-Index: AQHaj0OIUA7z2VEMEkeViXB3Ddmb3bFpboiAgAFCxaA=
Date: Tue, 16 Apr 2024 10:22:42 +0000
Message-ID:
 <VI1PR04MB53899910065D0817F54C5868FE082@VI1PR04MB5389.eurprd04.prod.outlook.com>
References: <20240415144430.34450-1-vlad.pruteanu@nxp.com>
 <20240415144430.34450-2-vlad.pruteanu@nxp.com>
 <CABBYNZ+DXQf6UF-uHSwY4RSA5NjKaFZjEeQvjHWjj5zYL1OdJw@mail.gmail.com>
In-Reply-To:
 <CABBYNZ+DXQf6UF-uHSwY4RSA5NjKaFZjEeQvjHWjj5zYL1OdJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5389:EE_|GVXPR04MB10518:EE_
x-ms-office365-filtering-correlation-id: 678b708c-6b1a-4d29-c835-08dc5dff265a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 p5okQUJnrfl2kUVws6KFp8c0Zzb7pp6TPgkQ6i2oE2KdA/Kt40ShCMPJIC7I/BcA4gd50/1vGWaVG4FKcgPZ+Y+OlJAW/tR26OdBA1Tkbg4wtjMsyXBnd9ljQ6KgPSIkOPafLqE+FeGJxwM5NOtE6TYVoPuVxV+vn5ZLFkmDiiZWAY4i2ubWAcDmtAlBysT68Nxzdg71KI6+PWhoNKbIEbZLZu091VseyCxa/WuUCPzBr1c+klFx0xRbUY24X//Kyc8QbDsKfH6t7jyLwGROg2bw/E2DC8ZGl0yOqYCH3sz83Y1LxFdARWRPW49zfNb8+bXZc/86RCbboYIQy8clnd+C9D3p+A63ktQNDajICN6UKIuMJp5FTtxAR3ssxV8WJIa/51JbGxCMJQIgRGNOwdNIDwm9nCM5VaC0cDWSIiuaxK9cvPKupLXRqB4riNkXGm1dG1VM5nZs/9ez17t5EOxvRSLhguRBpZ5PC8dPfvdOXyjt+XroZ18PKZiiq3jZ893YubTURz+uXVsaqaJVyrI6vF7OmOFzwXMzmjCOXHsfFd30pSI+pV7IQFgCQBzD3MgNKwM21STWqGkhUdAnFTxQf5MgVOBHgRqCQlZwnN3wZzVB8v3tW6SP5KipeHevOHYkGdncgTl4hzVo5o9TgO3mud8jeWsk62dpg74wphTwXHz/ZjU6Kd4j+mR+2E8Z2PnivMRyyneumceOCEXGEw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dENFMVBHZEVhNWFYbFMybkJScGxCT3EwUWRjck5hVHdtQ09xbjF6ejgrc25w?=
 =?utf-8?B?SVptT3djcUVMWk16bk15bk0ycUNZNmlEbm5jVENSTVVZeWFrVjFzb1BGZTY0?=
 =?utf-8?B?elFQbTlRR0NYOVNQTGRsWnozRWk4UEt0M1BGbVRxS1hPVC92UWk3MzNuRGZ4?=
 =?utf-8?B?OTlNY29FUW05WjhLd2dxYmlxYXpWWE9LNG8wRGdUMzJwdDVrL1FDNWRyTGYv?=
 =?utf-8?B?ODBQU29vMDJSdThFeVdWYmlEc0FYVU15QjN5d2Mwb2RoaCtuTlAxOGh1Si82?=
 =?utf-8?B?S2w2QndVUzYwMnQwUXFDTkZxaHIxanJRQ01kSitTUWZsUStzNmpMVHlsNnVW?=
 =?utf-8?B?N0xaL0JLVXpERkdCZW5FT2IxQW4vbUNHVWw5UzhKK0FEdmp0MlpEOHczL25I?=
 =?utf-8?B?QmZEM201Z2QvRnJJaDhoNTU5SldtWmxqV0RuVlBsWVEraTRyZFRXTk53Q3cx?=
 =?utf-8?B?VzQwZVpwYjVUa2lZdHM4YXBmam1KN1RDQkxLN1NSanF6UHpZTXhLelF3OEcr?=
 =?utf-8?B?azdNdit5dnU4MWx0cVExTnB6dks2dFNwR0dHNjA3Wm5oaTA1ZEVMaUU5dHVh?=
 =?utf-8?B?OFI5QXRYc01DM1V4WmIxOW5qUDVSVUxJakVUNnB2KzFVM3o4WHZlUjhKVmNl?=
 =?utf-8?B?blhvYnVEYlRTM0lyaEdoUitCaExkaVVsOTlRWmg1MmRoOHV5ZUNuUzVVcU1R?=
 =?utf-8?B?K0pqYlFrUG9HaG9wNFhGU21OSkNUdkpnTTlZUnhjb1Q3Nm5TbDdzRWdqK2th?=
 =?utf-8?B?akxsYVVXdXA5N3NtZnBhUjZYQmtyL0p0NGtCUStEQ3NteDZ5WHlYRFo0R2pV?=
 =?utf-8?B?ODVjd0RLd0RYbDBKTjZiOTgzVFprNkl2UUlYY0wvdkl2RFdSUERaNXIzT0dT?=
 =?utf-8?B?T0JZekFrRlBCN3R5NzdQTHdJbFlUVmhzbEdEVTA3Ym45SlJ3dDRtQndZVFZT?=
 =?utf-8?B?dE1QcWtWZlNnU2ZUTG5wbm1DSjZOcUxYNzFxOFlpNHpGc0FoZzdXSjNWK292?=
 =?utf-8?B?SEtwQWVmd08vQVhNZVpZalc5MlJVSkFnL0ZvMzd5d2xJdGpQNXZrbU1IR00v?=
 =?utf-8?B?cDNyemdtMlVQNnB2NlRQd3Y3dUVTRnVOemN0dzRsLytGaE5lYVJrS3M2djU0?=
 =?utf-8?B?SUsxSWk0M2pHb1J6QTVSa2YvOHdsaWpBaVV4Mmx1eFl5K0paTHJvZUNITWVx?=
 =?utf-8?B?dzgxbVpCYWgrbFhUZXJBc1MwbnJSdGNEamdwaUJtU2g5YnZTMEo5dGxSd1R3?=
 =?utf-8?B?TnowaldROWpINCt5ZS9lY016ZWJzRzh2UE9ybjVSR2Y3aUNKTVZYQXNPN1pI?=
 =?utf-8?B?dHJ2a1oramlSYXY4R2NWQ0Ixbk1kbDdmOTM2ZFBXNVdUVGdHOVFZc3pyZ1RG?=
 =?utf-8?B?M3I1OW5INFJzYTB6cHhjaGhuTVBJcGNwc0pndml0RmFZaUZKWmNocTc3Q0Iv?=
 =?utf-8?B?cE10T3FBLzlRaFdvMjk3dU1Fa0tkYnZ2Z2grY0Fwc0NGQWVSQ1prZFBTMCt0?=
 =?utf-8?B?Y3pIVVZ1ZUs4cU43Zy9MNHlxN0hBSkJJempXcmhiZFE2aTdEVmNGdXdsSmx0?=
 =?utf-8?B?VUxlTVBvUXpINi9aU1BISjRvMmRzbXdYczlPSllDcVVoNWgzSDgwR2kzSzNn?=
 =?utf-8?B?TWVEaVptUTA1QTRKbkFkZ016QzBlLzNqL1l6TnlQb210THUrcDBtcFZRVCt1?=
 =?utf-8?B?dWI4RzdLLzhTZlovVDFTRlB5U3VGVUcyeGFHQkhmN0pqRDE4NzFQUm9WbFBp?=
 =?utf-8?B?Z29acGhoOENSN0tPTG1EdGZIWFMvN2FRRGd5aW9KbHVGaG1yRzVVOVEwR21p?=
 =?utf-8?B?bm1LcjV6dlNwRVlTNWdjRnZGODZQQkMvNTJsVCtUbHRUTExUeWpTUGNPSE1Y?=
 =?utf-8?B?Nk10bFRjbytzeE4vS0VUR2xzKzdyZnUzOW9LSVFES1lYNzV4Y2NZRDQvNU5w?=
 =?utf-8?B?SjFHWkhETzYxdVJWbDQzSDVsYWFVNWp1bHNaLzk3WFF6cXI2bjNsR0VkYjBJ?=
 =?utf-8?B?RzR4UkZLUzJPSmNFQVk5K0kxVEVWUytEVVdKR2VmditYSjRDTjIwTm9zWGtC?=
 =?utf-8?B?b0lNck4vcVY4T3JUenZ0dVFTZExHVmN2WDRIRmYveVA5azJPdmZnU2tzUGFU?=
 =?utf-8?Q?CVsCYoYNg5CsJS1Qq5wZLPDhp?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 678b708c-6b1a-4d29-c835-08dc5dff265a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 10:22:42.0794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3SKvGDYle14DytkSQ37DyCzM9kj9tY69fxqyxT1nFlMxTe/5Vf1Pr0ftuHIv44mWspuhfjTF/hBk4dvQ2gunAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10518

SGVsbG8gTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6
IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogTW9uZGF5
LCBBcHJpbCAxNSwgMjAyNCA2OjA3IFBNDQo+IFRvOiBWbGFkIFBydXRlYW51IDx2bGFkLnBydXRl
YW51QG54cC5jb20+DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBDbGF1
ZGlhIENyaXN0aW5hIERyYWdoaWNlc2N1DQo+IDxjbGF1ZGlhLnJvc3VAbnhwLmNvbT47IE1paGFp
LU9jdGF2aWFuIFVyemljYSA8bWloYWktDQo+IG9jdGF2aWFuLnVyemljYUBueHAuY29tPjsgU2ls
dml1IEZsb3JpYW4gQmFyYnVsZXNjdQ0KPiA8c2lsdml1LmJhcmJ1bGVzY3VAbnhwLmNvbT47IEl1
bGlhIFRhbmFzZXNjdSA8aXVsaWEudGFuYXNlc2N1QG54cC5jb20+Ow0KPiBBbmRyZWkgSXN0b2Rv
cmVzY3UgPGFuZHJlaS5pc3RvZG9yZXNjdUBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTog
W1BBVENIIDEvMV0gQmx1ZXRvb3RoOiBoY2lfZXZlbnQ6IEZpeCBzZXR0aW5nIG9mIHVuaWNhc3Qg
cW9zDQo+IGludGVydmFsDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWls
LiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4gb3BlbmluZyBhdHRh
Y2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVw
b3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IEhpIFZsYWQsDQo+IA0KPiBPbiBN
b24sIEFwciAxNSwgMjAyNCBhdCAxMDo0NeKAr0FNIFZsYWQgUHJ1dGVhbnUNCj4gPHZsYWQucHJ1
dGVhbnVAbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBxb3MtPnVjYXN0IGludGVydmFsIHJlZmZl
cnMgdG8gdGhlIFNEVSBpbnRlcnZhbCwgYW5kIHNob3VsZCBub3QNCj4gPiBiZSBzZXQgdG8gdGhl
IGludGVydmFsIHZhbHVlIHJlcG9ydGVkIGJ5IHRoZSBMRSBDSVMgRXN0YWJsaXNoZWQNCj4gPiBl
dmVudCBzaW5jZSB0aGUgbGF0dGVyIHJlZmZlcnMgdG8gdGhlIElTTyBpbnRlcnZhbC4gVGhlc2Ug
dHdvDQo+ID4gaW50ZXJ2YWwgYXJlIG5vdCB0aGUgc2FtZSB0aGluZzoNCj4gPg0KPiA+IEJMVUVU
T09USCBDT1JFIFNQRUNJRklDQVRJT04gVmVyc2lvbiA1LjMgfCBWb2wgNiwgUGFydCBHDQo+ID4N
Cj4gPiBJc29jaHJvbm91cyBpbnRlcnZhbDoNCj4gPiBUaGUgdGltZSBiZXR3ZWVuIHR3byBjb25z
ZWN1dGl2ZSBCSVMgb3IgQ0lTIGV2ZW50cyAoZGVzaWduYXRlZA0KPiA+IElTT19JbnRlcnZhbCBp
biB0aGUgTGluayBMYXllcikNCj4gPg0KPiA+IFNEVSBpbnRlcnZhbDoNCj4gPiBUaGUgbm9taW5h
bCB0aW1lIGJldHdlZW4gdHdvIGNvbnNlY3V0aXZlIFNEVXMgdGhhdCBhcmUgc2VudCBvcg0KPiA+
IHJlY2VpdmVkIGJ5IHRoZSB1cHBlciBsYXllci4NCj4gDQo+IEkgYXNzdW1lIHRoZXkgYXJlIG5v
dCB0aGUgc2FtZSBiZWNhdXNlIHRoZSBJU08gaW50ZXJ2YWwgY2FuIGhhdmUgbW9yZQ0KPiB0aGFu
IG9uZSBzdWJldmVudHMsIGJ1dCBvdGhlcndpc2UgaWYgQk49MSB0aGVuIGl0IHNoYWxsIGJlIGFs
aWduZWQsIHNvDQo+IHdlIGFyZSBwcm9iYWJseSBtaXNzaW5nIHRoZSBCTiBjb21wb25lbnQgaGVy
ZS4NCj4gDQpJIGRvbid0IHRoaW5rIHRoYXQgdGhlcmUncyBhbnkgbmVlZCBmb3Igc2V0dGluZyB0
aGUgU0RVIEludGVydmFsIG9mIHRoZSBxb3MNCmhlcmUgc2luY2UgaXQgaGFzIGFscmVhZHkgYmVl
biBzZXQgYnkgdGhlIGhvc3QgcHJpb3IgdG8gaXNzdWluZyB0aGUgTEUgU2V0DQpDSUcgUGFyYW1l
dGVycyBjb21tYW5kLCBzbyB0aGUgY29udHJvbGxlciB3aWxsIGhhdmUgdG8gcmVzcGVjdCB0aGF0
DQp2YWx1ZS4gU2luY2UgdGhlIGl0IGhhcyBiZWVuIHNldCBieSB0aGUgaG9zdCwgdG8gYmUgdXNl
ZCBieSB0aGUgY29udHJvbGxlciwNCnRvIG1lLCBpdCBzZWVtcyBhIGxpdHRsZSBiaXQgcmVkdW5k
YW50IHRvIGRlcml2ZSB0aGUgU0RVIEludGVydmFsDQpvbmNlIGFnYWluIGJhc2VkIG9uIHBhcmFt
ZXRlcnMgcmVjZWl2ZWQgb24gdGhpcyBldmVudC4gSSB0aGluayB0aGF0DQpjb250aW51aW5nIHRv
IHVzZSB0aGUgaW5pdGlhbCB2YWx1ZSBzZXQgYnkgdGhlIEhvc3Qgc2hvdWxkIHN1ZmZpY2UuDQoN
Cj4gPiAtLS0NCj4gPiAgbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYyB8IDQgLS0tLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9uZXQv
Ymx1ZXRvb3RoL2hjaV9ldmVudC5jIGIvbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYw0KPiA+IGlu
ZGV4IDg2OGZmY2NmZjc3My4uODNjZjBlOGE1NmNmIDEwMDY0NA0KPiA+IC0tLSBhL25ldC9ibHVl
dG9vdGgvaGNpX2V2ZW50LmMNCj4gPiArKysgYi9uZXQvYmx1ZXRvb3RoL2hjaV9ldmVudC5jDQo+
ID4gQEAgLTY4MjQsMTAgKzY4MjQsNiBAQCBzdGF0aWMgdm9pZCBoY2lfbGVfY2lzX2VzdGFiaWxp
c2hlZF9ldnQoc3RydWN0DQo+IGhjaV9kZXYgKmhkZXYsIHZvaWQgKmRhdGEsDQo+ID4NCj4gPiAg
ICAgICAgIHBlbmRpbmcgPSB0ZXN0X2FuZF9jbGVhcl9iaXQoSENJX0NPTk5fQ1JFQVRFX0NJUywg
JmNvbm4tPmZsYWdzKTsNCj4gPg0KPiA+IC0gICAgICAgLyogQ29udmVydCBJU08gSW50ZXJ2YWwg
KDEuMjUgbXMgc2xvdHMpIHRvIFNEVSBJbnRlcnZhbCAodXMpICovDQo+ID4gLSAgICAgICBxb3Mt
PnVjYXN0LmluLmludGVydmFsID0gbGUxNl90b19jcHUoZXYtPmludGVydmFsKSAqIDEyNTA7DQo+
IA0KPiBUaGlzIG1vc3QgbGlrZWx5IG5lZWRzIHRvIGJlIGxlMTZfdG9fY3B1KGV2LT5pbnRlcnZh
bCkgKiAxMjUwICoNCj4gZXYtPmJuLCBhbnl3YXkgaXQgcHJvYmFibHkgbWFrZXMgc2Vuc2UgdG8g
aW5kaWNhdGUgd2hhdCB0aGUgQk4gaXMNCj4gY2F1c2luZyB0aGlzIHByb2JsZW0uDQo+IA0KPiA+
IC0gICAgICAgcW9zLT51Y2FzdC5vdXQuaW50ZXJ2YWwgPSBxb3MtPnVjYXN0LmluLmludGVydmFs
Ow0KPiA+DQo+ID4gICAgICAgICBzd2l0Y2ggKGNvbm4tPnJvbGUpIHsNCj4gPiAgICAgICAgIGNh
c2UgSENJX1JPTEVfU0xBVkU6DQo+ID4gICAgICAgICAgICAgICAgIC8qIENvbnZlcnQgVHJhbnNw
b3J0IExhdGVuY3kgKHVzKSB0byBMYXRlbmN5IChtc2VjKSAqLw0KPiA+IC0tDQo+ID4gMi40MC4x
DQo+ID4NCj4gDQo+IA0KPiAtLQ0KPiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo=
