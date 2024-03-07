Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2137.outbound.protection.outlook.com [40.107.223.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A9C6311F
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799539; cv=fail; b=tQHL8B8Do9zJCcoOp7EXVgSeP+/QKMYYyCD6S/5LOdwSK2eD/WBZ6gqHtFmGdOtqhpqFzWbjQhztZ4bmMXp6+qnvylqlK24bOvfK28/dy/CAHqoq+JVLIiehaWkit+UGToPAuiU1Hm4LcwbfFhEpSTMa/dyh5Zqt3wTlgngxKUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799539; c=relaxed/simple;
	bh=n8YyF6IBSR6xpkIrqvcCr5FyUJFh/dpjd8LUZDMa0IE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p0ATFL1bcTklYQKutg06Uaqu44GxVEWU8c2AY2h6WooZ3nZWuiT36xrHOvBbe0j2WhrY86yYSzZ1iukK1u4ixnaHP12hJrYwKiE2YuiSAOvkkvnDC64Jm8NnuQhFq5Ko+jLkvzLrkz6rwdyMmF/PnoYRXfixTApObgi4Jg1a+fE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=fNqEeI8y; arc=fail smtp.client-ip=40.107.223.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="fNqEeI8y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZBnTQgzIJazWqTVfCl1iH7Af7EqAnzU3m7sYonHx1ouVIjCXzgrkCKXO2gY+BsyzmMydTmfTJfrdzKjYpgzFMWLVglsnBefO2HmSrEiAREIESrNLsFj3Sagmlfdl9EgYrrcNEJ4Lq0itI8Fg4Un3VhW8yy+jJptPjRT38Q/mZBFaH1QtkNrAZxw8p3aesA4TP+ySzXPpS2jHdO8IFOTEQXpPAwHMUIPsDNeDGTRrI2n1ceeBSTpAQiO95plqBXJeJU4ak6dndx6YoD1d9juyzU/bHNyX/I6r4hC/FUrpcqq0CO0r0UBQKAmi+T/G4RhA/bRwkgImQHzmXKwBF5YgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8YyF6IBSR6xpkIrqvcCr5FyUJFh/dpjd8LUZDMa0IE=;
 b=Tr9Jg/orTPhTWhg9QL+YwwFFQ/PoAxyVLM0iQflEoFwezWfwhX7wimKqaP6jun3OZvolxWO0bDrrBtTfjCy2p7FV5cPbdc4o217tBuKZ1g9GuMECXKV0+W5E2YS7FZ+RcYjlnJG4ny0O0KQG9KrAXv0dlWSHHYJ5NG+JLHFg32ZulcPR+g1kC5DVFA/8jTXTRnZJ2VeA3f4D/I8T5J6oZ2xzc9M3epns2G7lHMzV39VYCP+2PMJZsGlF6NPYZbCrHS2yRmBQ8FslvKv+iceTgKr1ukPEkQCpC++vDP9Cc6zOxs7ws1SjU2YloLQNPSqlzMMRks9C8eNs/yUkCCLP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8YyF6IBSR6xpkIrqvcCr5FyUJFh/dpjd8LUZDMa0IE=;
 b=fNqEeI8ykfdaGG6R02QjbnNxTobtchxta0mnK6GbMVxEcSb7oG96G0LF2kvl9696LMfaqjYPQ5yPXtFUlAkjh9ZWvKFmw2uWaQQxJs+CsJr3gjjMeZEQDu7RTgqpc1kFGlge9oRbXO3XxvU3Wkz9mKomi1XSXFQjT7Zw/LGRYVv3SvO2rBLLwTQ6yxXNL5+sMfCS8ephn6uOGgInhyamZ+1NIJSY45SEhQGWFiCXWCZ5UA3Y8f3uLoX1eRtplfaMYKXykivKuDNKjsCsCOZ1juqAbJGXysYkkzbjH1o4DkeW7YRWIHNfLXvH+M0EysFjA1AvMY2zP4qeU5WEgr5pVg==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by PH0PR10MB5731.namprd10.prod.outlook.com (2603:10b6:510:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 08:18:54 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::729a:781f:69e3:b6c0]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::729a:781f:69e3:b6c0%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 08:18:54 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] obexd: Install D-BUS service for non systemd
Thread-Topic: [PATCH] obexd: Install D-BUS service for non systemd
Thread-Index: AQHacCgExWWv14AXa0qsIOYna8gO8rEroiGAgABNvYA=
Date: Thu, 7 Mar 2024 08:18:53 +0000
Message-ID: <b3090d0c46d51bf8cac9848167fa6d56b8236e53.camel@infinera.com>
References: <20240307004006.1173879-1-joakim.tjernlund@infinera.com>
	 <CABBYNZKixCvfq-eZLVgq7ccv_mui-h6QH+5WJ0=mUPut-z4P5Q@mail.gmail.com>
In-Reply-To:
 <CABBYNZKixCvfq-eZLVgq7ccv_mui-h6QH+5WJ0=mUPut-z4P5Q@mail.gmail.com>
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
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|PH0PR10MB5731:EE_
x-ms-office365-filtering-correlation-id: cd0b3b25-0af0-4c4d-5ff9-08dc3e7f3a4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kwf/Z/0gcgILDp4ZfwdHcInagQq1bEl1OEQKwFuV5T5BdnrFQhwh9+BD/HYpmgM3t0zhT+CkwxVbTSZEt0l6hkIK3HOo7uNDKdP+Y93Rw1aRpQTk3ZOPgJGSVILPx02BR+3p5cXOgqGdwhZZmgnbS3qOdfnMJVdmsWkmq+3ivthn+yI689ZlAEKl6NSNyzh9iNGBO/jUSeXaNqyqSSz6fm15S5Slb3z5dv6Yf5ewffDZQFexPiZG9VaF1SVB00ol62xpaguWImYEBuh7lopF3ylWE8YPQBAzu4XDdhZocpySCWU5x6EiuiL4moAchFoLj0FM91PvDDkHS8sGbzQ6hTtBFqM0pktaFbfCAdpdoMcN7XULdNJ2T3W74pv9UnDO2BG5zOSgeUyZenUQsKb+pg1Bj7os5L4THZT7YD3/QzM2kUHti+Pki6LZX9+IXZhuS7RpKhZc20yQ3KKIafYPSMVUGpTpbnsKvnXYtHyzim5E7UnZedR0u2NEmStPR5gLSC24N5xlFevLSx3ZbE2SM91claBAdi3MCaFKYEAtCQ8/KyF87Lae48CllU6/beEpy0pNg2mZPyVZNb7VKDFYWkHtobNh3N5RZQGpjwwVmwqgoqomjQRn1S+sAFEKr4725ktjnKHIfkDgx7xvzVAu3W9CCCOndyD4QADPRuVsM4TbpKcPMGEQ84SB0paOV0tsayY48G8Bwn9ICMSPV043zGLwcl2C1AwqF3zRcVTCSac=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djhwMmFRZHdQanA4MnA3QzdkUVlmM2JtOG53eFcydUw1TTNwUjFrTkdjZDZo?=
 =?utf-8?B?OGtkNFRNOGR4NkJuMnR3NkdRc3NQOHc2WFpqc0JETThIUm5Fd1JHT0w5WndU?=
 =?utf-8?B?QkdpeFZsV3A2VlUwb09TcCtSYVZRV0s5c2tpV2ZQTVlrWUdGeGZacytUUFNz?=
 =?utf-8?B?eUM3WU84UnN3UUdPZ2wzbGszWExpWTJSTHFCSCtKQW04MzQrZWl0RHZhTFJC?=
 =?utf-8?B?ak96b0xHQVdLZXUwa2o3U2pCL21YTHd0OWt5ZXFCV0hPeEdYTVpwVlAzUnN5?=
 =?utf-8?B?WmZaQlZob2pWZmIyTit5ajJUaFFuN2ZRVHIyMkdsdEZ6WVA2bG0vREdWWnZW?=
 =?utf-8?B?bnhHZnR1OGhCY3ZPRTBmU3FOQ0JiaTRvWHNhWkd1dkxTR2MvSXF6QStFTExH?=
 =?utf-8?B?RzZ3TUw1dTZZTWR1WlVkVDZ2U1F6OVhFMjY3ZFFrYlBmZS9oYVdNSHV2eXpI?=
 =?utf-8?B?T1I3ZjUvNjRkU2hHQm4yV1MzWFIxdDNvVFR3R0V4QktVZ0orYlpWUkkrWjNE?=
 =?utf-8?B?TXZFS1lyZ3A1RERoUXhBYzRYWUhsU1I1dWl3VHpJdmRGKzFycWQwUlROZklm?=
 =?utf-8?B?L0xKUmluTy9RRkhzT2U1b0J2NVNZWXlJNzk5WE5sNzYyL043VDA0Q2M3ZzB1?=
 =?utf-8?B?RndKOVpMSE1ra0tNY0VJYVhreXhGaGYzRnpGTE9Kc1FGSzk5YzBsRXRlVEJN?=
 =?utf-8?B?NzYyMGtMQkRISzUwUCtUaitMN3MwTFNpZy90NEpna1IwdU9vRnNzNzBwUjdT?=
 =?utf-8?B?UUVpellyK2p4bmZxS2dBRENNaXVqd0hZdHY1K2xoTkN2emRjNWpNak5uclpy?=
 =?utf-8?B?Vkk3UytxR29vUDhxSUQxakV4SFlhU0U3aHNCeTJTVVE5VGNSNWsyVm1CbTFo?=
 =?utf-8?B?ZEFvOER1SC9jeGlhcFlWd25vaE1HcTljdTU0bFlGWEJwM3NnWHMvZnoxcjZ4?=
 =?utf-8?B?cW5OdUJaZmNKMEZFdVlITU1OTHhyci9DbUlNMm0rRHhsNGN3NmUvaExHRDR3?=
 =?utf-8?B?WmVhVFNmamE4NmVSL1RsU05LTGVPeWhma3haMlN5aE90cGhpL0NuUzlsSlEr?=
 =?utf-8?B?Yk9RSUFCbEI4NmRMdGdMK2ZtZTB1alpZbkdaaGcvSEh2QjJ2YVB6YlgxSjJp?=
 =?utf-8?B?dEpzWi83L3hxd3ZUUTU4eUtnK3hoNjQvbkdmYVF3ZHgzcEZFZzJLblB0TXE3?=
 =?utf-8?B?cGhkZUVKaTZsWUFNWUJCZjg2U3ZzeHZNMjc3Q3k4aHBVNFlWY0pVNDNZVjFT?=
 =?utf-8?B?UXVqQ0Nvelg2Vk9RY0tZTjhOZDZqaldONi9FU3pHK2I4NjNBR1FPa01iMitK?=
 =?utf-8?B?b2RiMmtEdk1NME91NXdXcmFaUEx2VmJiMkxaQW0vTmdVYXFtRURyT1Nkekhk?=
 =?utf-8?B?U2FIdVltODFaWWdJU21qQms2ODV6ZEFWQkhmUzRCaGNTanJiS0JmS0p6L3pO?=
 =?utf-8?B?ZlBCUUwzZFpuQVR1SkN1ZmhHUkxRSUxFSU5Kb005NElOK3Zsb09sYWNyTUV4?=
 =?utf-8?B?OHE5NzE0OHNVb1BtUGtmTUVxQ1JseHhpYWNDK0JqSlkwY0wyc3pRYk1Jc3NF?=
 =?utf-8?B?T2ZYU2pWNjB0b0tqdmFnTTUzd0tLNHo5bjFzV2MwOWxBdmVhbTZPeS9OOW12?=
 =?utf-8?B?WWdqUXB3ckJXK3ovVVN2VFVaVG1MK3JmR2pqUVFqMmZSKzJIbjN4dnAvYXpY?=
 =?utf-8?B?aVJLUWZLRGxiUU9sM2YzYjZoYTFUV3NMNzlQYzVXRXRQVHlycElxU2xveFF5?=
 =?utf-8?B?WlI3M0hMdW9jZjJQcEVMc3BVUmNvekJHN3NhV21EN25XVDVuL0ExZTFHcTV5?=
 =?utf-8?B?cHp0Mm9CbUwyTXdBbjJ5dCs5d0xJd2ZJMUFPNE93Rko5OFpsVkRSYThCTDBu?=
 =?utf-8?B?d2VROXlMTXlNOC9scTVWVnN4NXcxc2pOVXY4RGZmcnVYMnI1Z0lVMEFPMndq?=
 =?utf-8?B?aW9rZGdCV1BtSFQ4amVqOWVtdFozei80Z2xBSEc4czgxamw0K3dhQ0RzTW54?=
 =?utf-8?B?VFJnbjJmbUV5UnNIVEErOXluZTVCWUVFa21aZGwzQ25FbDdTMjVlcS93bWUr?=
 =?utf-8?B?eCtFZmc1Z241bldDOXhtbENtNDdPYmpLZE9Ud1lMUXB6MndZVFloSnhGVDh3?=
 =?utf-8?B?UllZYm9nWDRrRTR3c3h6Uy9yOGNxTkxXYk9lemVrRXZhelg2MENxYnpOMXIr?=
 =?utf-8?Q?VvY7WzWy6LbsWNBsZ/vAhPgjdxgOFd/5Xq8yNww2vqUO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18D3CAFBCA03F8478A253B042A85CA34@namprd10.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0b3b25-0af0-4c4d-5ff9-08dc3e7f3a4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 08:18:53.9430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUxZVruI4sEZjer4QVdLjaRQR0wRFA5NqmIia8v+q4LCxDQA9b6UTTkA7X5XboGDbJ4K4qxYL2ynjbk9y04hIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5731

T24gV2VkLCAyMDI0LTAzLTA2IGF0IDIyOjQwIC0wNTAwLCBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6
IHdyb3RlOg0KPiBIaSBKb2FraW0sDQpIaSBMdWl6IDopDQoNCj4gDQo+IE9uIFdlZCwgTWFyIDYs
IDIwMjQgYXQgNzo0MOKAr1BNIEpvYWtpbSBUamVybmx1bmQNCj4gPGpvYWtpbS50amVybmx1bmRA
aW5maW5lcmEuY29tPiB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBKb2FraW0gVGplcm5sdW5kIDxK
b2FraW0uVGplcm5sdW5kQGluZmluZXJhLmNvbT4NCj4gPiANCj4gPiBub24gc3lzdGVtZChsaWtl
IE9wZW5SQykgbWFjaGluZXMgbmVlZCBELUJVUyBhY3RpdmF0aW9uIGZvciBvYmV4ZCBhcw0KPiA+
IHRoZXkgbGFjayAtLXVzZXIgc2VydmljZS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb2Fr
aW0gVGplcm5sdW5kIDxKb2FraW0uVGplcm5sdW5kQGluZmluZXJhLmNvbT4NCj4gPiAtLS0NCj4g
PiAgTWFrZWZpbGUub2JleGQgfCA1IC0tLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGRlbGV0
aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9NYWtlZmlsZS5vYmV4ZCBiL01ha2VmaWxl
Lm9iZXhkDQo+ID4gaW5kZXggMzg1ZTU2MThkLi5jZmNjMTE1YjcgMTAwNjQ0DQo+ID4gLS0tIGEv
TWFrZWZpbGUub2JleGQNCj4gPiArKysgYi9NYWtlZmlsZS5vYmV4ZA0KPiA+IEBAIC0xLDcgKzEs
NiBAQA0KPiA+ICAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gIGlmIE9C
RVgNCj4gPiANCj4gPiAtaWYgU1lTVEVNRA0KPiA+ICBzeXN0ZW1kdXNlcnVuaXRkaXIgPSAkKFNZ
U1RFTURfVVNFUlVOSVRESVIpDQo+ID4gIHN5c3RlbWR1c2VydW5pdF9EQVRBID0gb2JleGQvc3Jj
L29iZXguc2VydmljZQ0KPiA+IA0KPiA+IEBAIC0xMCwxMCArOSw2IEBAIG9iZXhkLWFkZC1zZXJ2
aWNlLXN5bWxpbms6DQo+ID4gDQo+ID4gIG9iZXhkLXJlbW92ZS1zZXJ2aWNlLXN5bWxpbms6DQo+
ID4gICAgICAgICBybSAtZiAkKERFU1RESVIpJChTWVNURU1EX1VTRVJVTklURElSKS9kYnVzLW9y
Zy5ibHVlei5vYmV4LnNlcnZpY2UNCj4gPiAtZWxzZQ0KPiA+IC1vYmV4ZC1hZGQtc2VydmljZS1z
eW1saW5rOg0KPiA+IC1vYmV4ZC1yZW1vdmUtc2VydmljZS1zeW1saW5rOg0KPiA+IC1lbmRpZg0K
PiA+IA0KPiA+ICBkYnVzc2Vzc2lvbmJ1c2RpciA9ICQoREJVU19TRVNTSU9OQlVTRElSKQ0KPiA+
ICBkYnVzc2Vzc2lvbmJ1c19EQVRBID0gb2JleGQvc3JjL29yZy5ibHVlei5vYmV4LnNlcnZpY2UN
Cj4gPiAtLQ0KPiA+IDIuNDMuMA0KPiA+IA0KPiANCj4gSSBndWVzcyB5b3Ugd2FudCB0byByZXZl
cnQgOWNjOGI5N2I4ZjVkMDYwZTMzNDIwNzEzNjEwMGU5NDc3MzJhZWQwOCwNCj4gYnV0IHRoZW4g
d2UgbmVlZCB0byBmaXggdGhlIGNoZWNrcGF0Y2ggZXJyb3I6DQoNCkRvbid0IGtub3cgdGhhdCwg
YSBiaXQgY2x1ZWxlc3MgYWJvdXQgZGlzdGNoZWNrIGFuZCB3aGF0IGl0IGRvZXMuDQpGb3IgbWUg
aXQgZmFpbHMgYmVmb3JlIG15IHBhdGNoIGFscmVhZHk6DQoNCi4vYm9vdHN0cmFwDQouL2NvbmZp
Z3VyZQ0KbWFrZSBkaXN0Y2hlY2sNCm1ha2UgLS1uby1wcmludC1kaXJlY3RvcnkgZGlzdC14eiBh
bV9fcG9zdF9yZW1vdmVfZGlzdGRpcj0nQDonDQogIEdFTiAgICAgIGxpYi9ibHVldG9vdGgvYmx1
ZXRvb3RoLmgNCiAgR0VOICAgICAgbGliL2JsdWV0b290aC9oY2kuaA0KICBHRU4gICAgICBsaWIv
Ymx1ZXRvb3RoL2hjaV9saWIuaA0KICBHRU4gICAgICBsaWIvYmx1ZXRvb3RoL3Njby5oDQogIEdF
TiAgICAgIGxpYi9ibHVldG9vdGgvbDJjYXAuaA0KICBHRU4gICAgICBsaWIvYmx1ZXRvb3RoL3Nk
cC5oDQogIEdFTiAgICAgIGxpYi9ibHVldG9vdGgvc2RwX2xpYi5oDQogIEdFTiAgICAgIGxpYi9i
bHVldG9vdGgvcmZjb21tLmgNCiAgR0VOICAgICAgbGliL2JsdWV0b290aC9ibmVwLmgNCiAgR0VO
ICAgICAgbGliL2JsdWV0b290aC9jbXRwLmgNCiAgR0VOICAgICAgbGliL2JsdWV0b290aC9oaWRw
LmgNCiAgR0VOICAgICAgZWxsL3NoYXJlZA0KICBHRU4gICAgICBzcmMvYnVpbHRpbi5oDQogIEdF
TiAgICAgIG9iZXhkL3NyYy9idWlsdGluLmgNCm1ha2UgLS1uby1wcmludC1kaXJlY3RvcnkgZGlz
dGRpci1hbQ0KbWFrZVsyXTogKioqIE5vIHJ1bGUgdG8gbWFrZSB0YXJnZXQgJ2VsbC91dGlsLmgn
LCBuZWVkZWQgYnkgJ2Rpc3RkaXItYW0nLiAgU3RvcC4NCm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6
MTIwMTY6IGRpc3RkaXJdIEVycm9yIDINCm1ha2U6ICoqKiBbTWFrZWZpbGU6MTIwOTY6IGRpc3Rd
IEVycm9yIDINCg0KDQogSm9ja2UNCj4gDQo+IGNvbW1pdCA5Y2M4Yjk3YjhmNWQwNjBlMzM0MjA3
MTM2MTAwZTk0NzczMmFlZDA4DQo+IEF1dGhvcjogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVp
ei52b24uZGVudHpAaW50ZWwuY29tPg0KPiBEYXRlOiAgIE1vbiBNYXIgNCAxMjo0NDowOCAyMDI0
IC0wNTAwDQo+IA0KPiAgICAgYnVpbGQ6IG9iZXhkOiBGaXggbWFrZSBkaXN0Y2hlY2sNCj4gDQo+
ICAgICBUaGlzIGZpeGVzIHRoZSBmb2xsb3dpbmcgZXJyb3I6DQo+IA0KPiAgICAgL3Vzci9iaW4v
aW5zdGFsbDogY2Fubm90IHJlbW92ZQ0KPiAgICAgJy91c3Ivc2hhcmUvZGJ1cy0xL3NlcnZpY2Vz
L29yZy5ibHVlei5vYmV4LnNlcnZpY2UnOiBQZXJtaXNzaW9uIGRlbmllZA0KPiANCj4gDQo+IA0K
DQo=
