Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2125.outbound.protection.outlook.com [40.107.92.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820388527D
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709813501; cv=fail; b=WUh3xyOZ+TsnHybGvGSPzN57JeLwmYVuKa/E0GERB3hVEoFegQf+uquW/R7Y48msZAZW3IKAJbt0GxD1WceakpUWQH9WA0c4eHEVKcX2iMT1ouFZ+ce+wpp5Bak2b2Hzk+d7TT45wFe+DHZbHtX08MyugZdLsHNSL5PNPePMAWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709813501; c=relaxed/simple;
	bh=IuseWzv67kw6kHPA+ZDuI/0Vx2kgJTvuVmS9+SBbom4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pHm8xmsy1xx2tgPoUGtpt7twrYL3+kTUY/UMuUD62vPG6r84r8GqzbK2cl/vp/rHkejxYe5LFbNUfC+SA+zU6BuzGh7je4muw3PyBuRQLF3HVUQ3khhRPhkxugZI53ppNnCzMZpH+tjkYosCweFK/oLBhImYmlfB+RjGIltwAVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=bCTB5Ria; arc=fail smtp.client-ip=40.107.92.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="bCTB5Ria"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7vEIzQggVJ6GTSDQg/IHNEQIwhPvgRu3svAkMcHy9tg6DCiXn2Ty91DhbmiaY7JAHQVKtw548cjLMQx0RYr1m1sb2O9g34E/hBDK4p3I24DzhySQJWdqHxzGnnNi+PKZDhDUUg1GhLZMre9/fmqz/kbuM1FJ098HhG3wY3NyrLkj6PphL/94cyDq0BagoJQQZyZwWmPt01+cyGO6G9w4Kr+feeUVrfw0MiNFclwI2U74LGWGr+M/LHU5bxbwvMEZmhbumKBh0m9Pac/6S/0OG6IEjq4Z56lf2HFJZX/owdxodFrEE70If/DjyRePW259POqKazyEhIeLnFS8LGsiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IuseWzv67kw6kHPA+ZDuI/0Vx2kgJTvuVmS9+SBbom4=;
 b=UqM1MV8Ix1fpzssem8teqoMi6dsQu/HyKYd0VDxP6LVxxmH5xrUDgMiGEmcsHQEXpo5v42elZlpg55dyRDWvncUcAWn9HNc4CjAAtQHlPOTnie3XJuM36HX2zyhlfosJlWAuwu5jriyUSmMLQSICr7pZ8Xx/8xpfyOq2LVdxxYlMPrCSyaFLJEVNJtDjbVpSoMmVtHh/xLU8x8mdIxW7wZrGKg3aNfhGoyzZIBJ1Rfa9owSe4nOWr2vOt718iIhFjT2tF+XMI6XwTbXD0RdhL5fmIYLWw7XTOQ3w4lsYtgr8Ohk/JEVnv20z2ugfmnGZMLF2wCADx5JHqj7fz0NYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IuseWzv67kw6kHPA+ZDuI/0Vx2kgJTvuVmS9+SBbom4=;
 b=bCTB5Ria4cJm43AKLVZE8JZ+e5NzvHhlZ3NFqwBVj3YnIgocXyoYDcpnv7oAdKynMkxZOrN5NH9xXvfKGIb85WIlYNaH9pE8mTb+eUgTiqFJIhbSOG8Hq6NtmG6oRu+TIxN9gGbVNyXLucQ7061kzE81xGylz8QVMi9k1RvqYqufcWc8vv3rsWUrCMAfEPgfrIgtq6xKSq2d5PMsdrgB1KqeRBtU+WDRSmcZU57TVSPqaVGdMZnNyBg0S8Y++dE5+HK/htu1da9kTb4F4KZIRP/njkoHAneOY/PrmftKTzA18MIYQA1QpT9913eBFY7bF/K+LaRUXwEYobgUIBAmTA==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by CO1PR10MB4628.namprd10.prod.outlook.com (2603:10b6:303:6c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 12:11:37 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::729a:781f:69e3:b6c0]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::729a:781f:69e3:b6c0%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 12:11:37 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2] obexd: Install D-BUS service for non systemd
Thread-Topic: [PATCH v2] obexd: Install D-BUS service for non systemd
Thread-Index: AQHacIcTi/3qlwwoeEKjMXWtWJpzf7EsMCUA
Date: Thu, 7 Mar 2024 12:11:37 +0000
Message-ID: <3edf931d06cf146d9e142edadbba40a039863ab0.camel@infinera.com>
References: <20240307120033.1327905-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20240307120033.1327905-1-joakim.tjernlund@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.4 
autocrypt: addr=joakim.tjernlund@infinera.com; prefer-encrypt=mutual;
 keydata=mQENBFp0f28BCADPn4XzN2HEzkY4BZKE6/T/S4M/Qjlf01K6gmECJZi5LQgOt0jOUAdvsXVd8yKYeqCq+eWvlfrLU9OXPGoCqwj95P2YjMsttqaPBEAnf4XyBs67Snz2wHyBDONoRxGoyq2Ondy+TPicWEm0mh404h9EzKxRNxwrRyKhsjWoVeaucuybAiGbJvqQj0CLmuMCl4PUBYDmXFzt3yx0g54z8E9/8ON+z0J7yZbA0aftZAjFLv6nn0Th/2dpD8d3vWtkJw4yBjLX2KFvlzJfQqkd6RI4Cn1OP9sguXDob123dMiMk/5XbjXz+0C21QFxejxt3HGisvKes+8swplyni7KdiDtABEBAAG0MEpvYWtpbSBUamVybmx1bmQgPGpvYWtpbS50amVybmx1bmRAaW5maW5lcmEuY29tPokBVAQTAQgAPhYhBFtMG/jmfqy7x0aBp4VMQ6CbDpcaBQJadH9vAhsDBQkDwmcABQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEIVMQ6CbDpcasFAH/j64dpHpjY55tVoUg5yK8hcmxS/buKQQP9H3e2DdHeYrK0qeQ97AXiWTh63UvzvEXchiKjua6kYhUUkDObaltmwkKgPv0qb9lP6yfFBzvllriS6LrdIMCOLgtnQW2x28m5mC1hYT08jlqEXluYDoj2dTll9HGMsqn0JkhRjBsuzTXq8VyJjjnNLpzsAlTOGEQoAi7SqtDHs9PSNyOAKH5jRjATdNbPAsTKuI1veJf7Zzyc98yG0ya43Hqal1scoa+9GJZXNQPRaMVkyxKGbEEncdtnQl9e/DUMH4SUQ5vbM/+U4WvkX5Cvc+KwI6JAm1PhrAaVHSkDNAU5LqUqEbbHY=
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=infinera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|CO1PR10MB4628:EE_
x-ms-office365-filtering-correlation-id: 132e70ef-f05e-42e0-be5b-08dc3e9fbd23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lBmdWfmyvXou9DGcQd77EpTaW7pEvAFtpJC/yj23JqDcls3D/pgci7DPfte20DK7efOEXHjrG0Pl0piYmcy2I9/hEsJrZgCJYV+NQJo813/H2724qJbPCRggn6UQAonuRIMjEdU3OgNdnV0fXXsnjMvWYTvs7XUb7w4dgvOGrg6Eq9ftf334092jFeSsyZG2IiyudH+6Z2RRA0IhVeE9ZXdsOUpzZjTIef2jTCRiuSY97ycsLZDHZe9jHUpqwh0xCJKJV6vknK1q2/YMFBE8HTk2j/QoMb1BDOtCKVzBXAj1KyVblmkH5pBzkr3RV6mVF1otyKhYwtaZVEJ/Ca6vzEG2n+E7CPR2JLVR0IEu7CPS92o0SLV2K381ZKXERhDpStJ4NftQQODXJ+QQeSAO6AtsZVKPwLNnj0y3FkqmNJcsuKSm3KiJOVYow+4Dt8f0NfGDFyQzAIw3kG1q4gbdq7db0dDwkjcyXtDtwNkLpIVrJHDEIU7sAaLDLNyKpZqAmLhw2tYn9JOeA6lGP2+tQSy7z847PlN8hCguov9xHntiZDY0aj6MocqhSh+CiS7WubhmzzymLafJSAFE+qaCM+ceH9rNl5YWR6ACRjOIhHAoBIc1AlzbH4tCvgKtm9R/IohsY3DoffUlv6wqjbepPCyb0ugLR8upnNlxPzegtobHe67HIdxZY7U6kw9DEgvmtZyhPQ3gieSg8w6HORwzWLLPcd6HRxC2le4kzbiQj7g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eTNJUlVlMUR1cEE1Q1F1cVhlMUxDZW1VU1pJY2ZMVXlmcU9rSWp1K2J5Sito?=
 =?utf-8?B?clVlcldaT3hWbmVZMnN4cnpsY3RvRGZUSXJYcHVwYTJ5ZDZzanpUV1RQb0hZ?=
 =?utf-8?B?VkZsSFJ5bFJJWXhWZm45SUF3bk5zQndpTlNqNEwxQmVVQkFHajdIeG03anF1?=
 =?utf-8?B?S1JySml5M3BlL21JOWdzVjQrbGwzZ3Rockpaa0NsemlYMm5xanNnaFNvR29l?=
 =?utf-8?B?dXYwM054RVlZTXdPOGtuclp2U1ppcDJXWXptNms3ZzNZV2xRU3NwOWNqRjho?=
 =?utf-8?B?cDY4bmIxZjNKWVdXLzNMTGtHN28vM3RZK0lHYVRDZnBNOEMxV3hNbGhzNi9x?=
 =?utf-8?B?QWREY0xVQy9GRGdIMUVTSFAxdHc4ODFqcEdsZkljemx3ZE90S3RWazN6WFda?=
 =?utf-8?B?NEEySkNYTDRZd20zL2tMaTN4UURFckRBYmpqQVZ4S09OOHlOeFZiejB3cUZm?=
 =?utf-8?B?d0J3VlpFSVVPSThGTUQ4VVJRdlFtMTJDQ2dCTHNIVGt5em9PR1VTaUlxTjVL?=
 =?utf-8?B?RlZFR2lJUWRIUmlCZ1RjUDh5YlFWV2NZUDNheEZMeTBvaUtMSVU3SzNHbTcr?=
 =?utf-8?B?eTJqRjVIYnlFNFhJQWNuazdnODB6YzQxc2JkaTVMb0NqOFFlU2RST25kRjdM?=
 =?utf-8?B?NWJvSTU2MEwzUnJiUFRnY3FCcGZPYW1yRkJrelRpYTROV3pIL29TL1haYm9p?=
 =?utf-8?B?eUJiTWxlWGNaY0ZlbTZNMUxMcWpNVHJVNElSdU0vTXZvM0wzRUE2c2crYTBW?=
 =?utf-8?B?dVArbmtFMXBXQU9sendSc0paUEM2NHpya1VHZ3ZTQWJNaXNWSHVtUmZOYXAx?=
 =?utf-8?B?R214U3dKMW83SGtjVnBEVU11K2ZIc0NYTkRjWERIVnd0aS8wdDJ3MlZjNEtn?=
 =?utf-8?B?TFlJY2ZlUVRGZTFXUHRrc3dneVpBQVE3SFFXMGpCaGhUQkdxdm1kUXJDSVdC?=
 =?utf-8?B?QXV3V1AyTVhObEVzdys0RWgzWkQ3RE11bEV1OG1MWjZYdHJRMnNNRmZqQVBi?=
 =?utf-8?B?RlcyNDc0Y2cweHZMRU1rY09DVnVOS2RBSEtzc1BLbk00ZlZraXZpekRuTldH?=
 =?utf-8?B?Q2VUQ0tNMHp3Ym1HbXI0OTBiV1I5NnJYTzJYZ1FGQStCdDdOeFpTTFNFWVB0?=
 =?utf-8?B?ZGRvWFhTdVJTM3cvY1hPaXl2blJGc2o1TUZPbXlhVzc0NEFZRmxHOXU5dU1t?=
 =?utf-8?B?R0V6aW1vOStQRkVIWElOc041cVBiMDdQSGpEckd3RjJUd2Rmd20zQ3pOUkRJ?=
 =?utf-8?B?RUR4d2M5eUZxOURWWHFBeHg3SlFmZXNzMmZ4c01BQzNFbm0vTjh4WnREZ25q?=
 =?utf-8?B?ZHlDR1ZEMm1FODBBNW9CbVN3QmR6cnNVMzZHdlh3aUNNOXVMNTB4ZVlJblZy?=
 =?utf-8?B?VVZaY0pvYUhadGhhT2RIYjdXS1BIYXNFaVgvbExjME1xb2s4c1oxbFB3TXFX?=
 =?utf-8?B?bXFrYVJHZ3pJQmlwc3duNDIzOFpGYmhXSHZUcS90U2JmY1czQW1LOVpITHkx?=
 =?utf-8?B?VXMvWWdndzQybEhubVYxalNIRittVVVVWU9lVzJ4UVg2c25vR3JhejBNNHJz?=
 =?utf-8?B?YmQ2NHJvdXV4VmZWMUwra0wzdjUvdmovSTNxSDcvK290ak9TMkd5NGwyUHJt?=
 =?utf-8?B?SWRMYUFlOUpwa0RtL2VHdmQ2V2IrYU1mbnlVWVp5S29SZC9MNkVMcWtQbTZT?=
 =?utf-8?B?QTNwTUhxdTRKeVhiNitMKzNqd1lhR2w5MDdnVUNKN2MzeXpLVDczSGtLcUJx?=
 =?utf-8?B?Ty9ISStaQjhaWnRTVHpzbGlycDJYamViN2lTOUtJYzQ1ekV2MWRJbm9XTDRR?=
 =?utf-8?B?WDJ2TUFoaDZ0UEJnYnRSSVdzdkd0dEM0TmN6OEdhTHlyeE9FUmMrL1V0SmlV?=
 =?utf-8?B?WXVGTjVHR0ZxVE9rUmtpZ3dHWnByZHdCeWZaaXBsMFdSNi9ZUlVWZ1pnUFVT?=
 =?utf-8?B?QUw2L1pIUzBBTm5XSndLbWo3ZmtFU0I5UjRwcG9FOUZkN3NZa3V5SUMxWUw1?=
 =?utf-8?B?djVqNDVieUpHSGlqNlJNV3lYemIzR1lzVWExYmNsVE5LRmEzRVRKY29rM2ph?=
 =?utf-8?B?akZSOGN4T0tHSzFXcDI1WjBna3ZsdEJWcTAxTFZEM0dhTitBSW81bzJMOGJ2?=
 =?utf-8?B?UFlFQ0dZdFUyMWtjd1J0bDhBSGlsOTdQaUU3QUN0aDFnWEphYVdXL0lvVGpR?=
 =?utf-8?Q?X/1ChIKxXdiEhIzxsha6kbRAcZtqQ6LGk4uT//E6xEMt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB19A2C2ED1459498972952F15A98257@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132e70ef-f05e-42e0-be5b-08dc3e9fbd23
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 12:11:37.3548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KpY3FQy0Sf0N/R2HEMwyfqXYEDl1yX90zI40xqhVjrO/1bcbNYEOBZqn8/lz4tgZncoqtarY/qBcI5SgUDk5LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4628

UGxlYXNlIGRpc3JlZ2FyZA0KDQpPbiBUaHUsIDIwMjQtMDMtMDcgYXQgMTM6MDAgKzAxMDAsIEpv
YWtpbSBUamVybmx1bmQgd3JvdGU6DQo+IG5vbiBzeXN0ZW1kKGxpa2UgT3BlblJDKSBtYWNoaW5l
cyBuZWVkIEQtQlVTIGFjdGl2YXRpb24gZm9yIG9iZXhkIGFzDQo+IHRoZXkgbGFjayAtLXVzZXIg
c2VydmljZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEpvYWtpbSBUamVybmx1bmQgPGpvYWtpbS50
amVybmx1bmRAaW5maW5lcmEuY29tPg0KPiAtLS0NCj4gDQo+ICB2MjogT25seSBpbmNsdWRlIG9y
Zy5ibHVlei5zZXJ2aWNlIGZpbGUNCj4gDQo+ICBNYWtlZmlsZS5hbSB8IDIgKy0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL01ha2VmaWxlLmFtIGIvTWFrZWZpbGUuYW0NCj4gaW5kZXggZWQ0ZjlkYzUxLi5lNzgwZmNi
YjEgMTAwNjQ0DQo+IC0tLSBhL01ha2VmaWxlLmFtDQo+ICsrKyBiL01ha2VmaWxlLmFtDQo+IEBA
IC00OCwxMCArNDgsMTAgQEAgZW5kaWYNCj4gIGlmIFNZU1RFTUQNCj4gIHN5c3RlbWRzeXN0ZW11
bml0ZGlyID0gJChTWVNURU1EX1NZU1RFTVVOSVRESVIpDQo+ICBzeXN0ZW1kc3lzdGVtdW5pdF9E
QVRBID0gc3JjL2JsdWV0b290aC5zZXJ2aWNlDQo+ICtlbmRpZg0KPiAgDQo+ICBkYnVzc3lzdGVt
YnVzZGlyID0gJChEQlVTX1NZU1RFTUJVU0RJUikNCj4gIGRidXNzeXN0ZW1idXNfREFUQSA9IHNy
Yy9vcmcuYmx1ZXouc2VydmljZQ0KPiAtZW5kaWYNCj4gIA0KPiAgRVhUUkFfRElTVCArPSBzcmMv
b3JnLmJsdWV6LnNlcnZpY2UNCj4gIA0KDQo=
