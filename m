Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2135.outbound.protection.outlook.com [40.107.220.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE63F9ED
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607445; cv=fail; b=HJMS1wD3lCXEWcngwHM/yBxy0wH6ugYTRxmUiJeLiDaueJTIgE9mW5HOJZrl7wjXnyAZ7yDi3jC3iGlsMPeOpYL0WQxXKPZNEgcHtJgYv1LYDaFYIAgm/2Ajko1NM22IB3eWaoMotYitwygG3uek/RJcC4ZZAOtns1rHL4Dl/OE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607445; c=relaxed/simple;
	bh=kxafom1U9DqKXYAbmF06zcdUE2R5ILprbu6V9J/TMa0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iP5cXuS4/sRkYZYnR7NQgb3kPyKFGjuiMHpO+zU/DNuJqk65AjLBpAGqoYuckA3isax+3EkZbewbLld1503UoYa1K6YoYUGB4h/D8qBECu8QMaWdpMaAM6X10yUjb9cpVjXwPBmW17ApxdHMPwwqzvfAb5MOymrw4Z0FaVLFUjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=s1KMziyq; arc=fail smtp.client-ip=40.107.220.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="s1KMziyq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeDFScblYvxIhbGsG9iClNSUxKBt1PTZ9VS2DrQThf8TBme8ApUfcx7bYfLDAc4W0qczLR7QR0aCvbZAInZqVvAyoAX2kPcvot+pFB5yQi9DwLX+qENYurpsOs6hjpVnvHOA7jUBwmm5OdSU/DRWX60Abg6MJ4Dbz39TxjOuFSRsnFm/mO1I+q4/n1IT79YsZO+TlRGFfPfltd+jiVNWcfu2LOv5zacRlsm8C8Q2W9RRG42JduFRv6ewWkCq6ogCoBOLi98h5WEdiOSbZCWXeZ6CWqzwwXEy9X3k6qMl469K2fBlOb4eOkjS9zEdAhh2yfS4WM2qq3AA4Lcb0YjU0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxafom1U9DqKXYAbmF06zcdUE2R5ILprbu6V9J/TMa0=;
 b=d9Ad5NswTjTGAJSMI9B8xufw+uTbFztI5Xi0oK2wyv1wH0jl/uhwIOcSm40WKjHqLPumT+k8S/MFvKHPuW6CoIDe/98L1m50IICmurj7il9pqH2ekIkolJanGnMzCYHR4ZXtVOHzNlRvIgPCCvTgVyoYCCr45kThafXkIqTlMnlpm9hhjGd/TVI2oxtbH1bwLNDJ4/8QpzSXc5gOrL9vm3wtAv0utteToWbnx7QAkg0rzG8VY6WF3G9mTFtz1ckRbU1n7RzJOyvwdb1Ha8FtY1Hsmtrlm5mjVc8dr3nZppZb0bYxaT3R3RGrv/J328+meOUo5+XSh3umbuRKrb/yjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kxafom1U9DqKXYAbmF06zcdUE2R5ILprbu6V9J/TMa0=;
 b=s1KMziyq+MBHQJZ7q3k+35tG/2fm02OxBMY60ndbzEWG3RA9DpZtLRjl8njE6aYMiFBrdM4olkD/EV/WB+hKuwrKkCvRzvtOmOYqKAl2tQS5lc9SNikdUUZDV5/JM7Fc2B1PB0nfwPnzcLoiYCS+tYhcF29BkiWsUptVtKTUWxZe6HZfbMRnAu81Evpjj6Otl7dluq+MiKXnSgJhvk2OMhiZs3lIx/e47hKNonH4Uz23Cyikdpe0rXws4Y1CKUr6skpdaD/PjqjPs9TT/VlQZQ2NI48CMaDWW+5h7+cnhoAQcVSYEHtwAb1uxR7k3E+z96YPbUnueVSebfqHqI5XBw==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by CY8PR10MB6564.namprd10.prod.outlook.com (2603:10b6:930:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 13:10:41 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::4d76:4230:708c:9eea]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::4d76:4230:708c:9eea%7]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 13:10:41 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "emil.l.velikov@gmail.com" <emil.l.velikov@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] bluez.pc.in: Add definition of libexecdir
Thread-Topic: [PATCH] bluez.pc.in: Add definition of libexecdir
Thread-Index: AQHaZLfPWdSMnNWnT0SJKydIksfsmLEWUxEAgAAEkAA=
Date: Thu, 22 Feb 2024 13:10:40 +0000
Message-ID: <38504363a13524443f21f1c0a50653bead0742bb.camel@infinera.com>
References: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
	 <CACvgo529avv_gypHc4tO6VNmZU6Md0V9ZapQnLLCE_3vdjOT2Q@mail.gmail.com>
In-Reply-To:
 <CACvgo529avv_gypHc4tO6VNmZU6Md0V9ZapQnLLCE_3vdjOT2Q@mail.gmail.com>
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
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|CY8PR10MB6564:EE_
x-ms-office365-filtering-correlation-id: 10838d81-9150-4999-2c0e-08dc33a7ab89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LIqiP6yXb9iBm8NNkRrhc0EaPW8ZIK6f6NvTOIFrY3yGYDNGiqCQwPFPydpQ88zfdmBPeIQBBP9p5/G7nkP5zJVx67h/U9/HlBxB2uLBYPZERh3HUoIlhivuhfesxjSQ5oP2wD4B3yoTwA0mxRttlXAKRA7f5hm8mGBPDE4xJ6LD2uNAzUXPUvIzFE2Yz4+miysQXXgUUJycO/TZGhhT9W7D/u4oemtbR6o7aNel26Eu4qYkCEdN4ry6bwQtmkOI4NjzY/XMKruXKCZ4gZBxCpO7cwq3CcXLvTBE0cXnvtX53rjeXZTz1IAH2ofSCJ7CnIv53Nsi7b6wIwhd28oZuo632euauSThNh8j/1EAavZvQBLZqTPoR89YvmIdCi6EO3f+xxL1w9yHeQXxwvJr6Y4GPYVTHtQTLmlTiQZUso28TQdrIcQVT3oxfyP4QLFe6tFG4FHXZwePZOS4AGfULCw1nZGw+Sv5akfP3Jnz+i426beT+OqOnVEBn/QIrPuD6uYf5lZKh3PueUbqFFplVCsjSJGLW2Xa6ssSDTc3A8fcO1AIdL6qxN0nCc6UilzCRjknlNKGTCIKWMJWn8D8sSCWT6V08P9kAQx0kJN0j2pQMwQbrBf79tL3PJXLbm4n
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QlZUc1JJb2M5cVhJdERHZU83cEpwcTY0S1NvdTN2VVBuOGhmdUwrSHBZd1lq?=
 =?utf-8?B?WTR1bEgyWlhHZEJDTm9VSW45WkJETVZPQWY1UWhUbVpoQ2xPeDJOZzl3MXZV?=
 =?utf-8?B?amNVUGhrbld5Y1J2RWoyRG1INUd3VTZ2RzNlb21zR1BCSHhtVjNyenI2TlpI?=
 =?utf-8?B?eHUwV0VzZmxDd29WQ2pFYnk0L0ZlSUV4M3U5ZlNoL2l4b1lQSkx5MFFSUmQy?=
 =?utf-8?B?YVowb2tvVjJzSjlIa05tV0lmYUFsbFpSaUthREx6NUFqVGlzQXlDeCtOQ3Bw?=
 =?utf-8?B?TVhEeDJQVXNLUDFQWUZJWUQ3UVpKR1UxdkUzc2JEbHQ0WnNPRXF3cTRIOXhJ?=
 =?utf-8?B?TzM5TGVjeEZ1am9jenlqK0RpcTgyYnhYK29icTJkbURqYnhITWNEQWFPY1Zw?=
 =?utf-8?B?eXNQL1J5ZjlybWJWeG5sRDRNenFjKzZpMnFHVlFZOXVud3hIbkZaYXZTQXJX?=
 =?utf-8?B?ZWdERFM5Q1BEdTVxMHliUmpDcDVaK1V5cjB4YjRRZHZuVjc1TVE2ZWdoZXBX?=
 =?utf-8?B?WVdTQWlqT00rclF4QUROUjNrbUlOeStvaWtxSUVZeEhoT2dnVTkxdzRZdzFF?=
 =?utf-8?B?bDF2TjE5eS83VkZXS0UyNENOY245aVlacVBGTjBsclpMYnBLMW53NmRuUUNC?=
 =?utf-8?B?YXhjOU5LWGVlQ1ZDTGxJU1Vyd2pjWWRKei8vS1BrVlVidjF6ckxnRjNkemEy?=
 =?utf-8?B?STJvWVlpUHU2ZkF4V2R0TVFnK2c0Z2RjMU54OVVnZWNqa0lTdTltQ2JqQXgz?=
 =?utf-8?B?RWd3QlJYZFJ0MzZxWjRZWmZRMER3K1RPNXE0d04yZ2dTcWRnQmxLYW9PdG1I?=
 =?utf-8?B?V1JnRjFaTVVnV1IwNFFta2tjcEFQdWpTaE1CYjRCZGR1Vk1rYjRqU2s3a1lD?=
 =?utf-8?B?N0x1dUFSS3JzbStuNE53UDFHaDhqMzRGcjdkWlNXSWdYSE5rNDAzUXZHai8v?=
 =?utf-8?B?OUpKQ0JRbU1FSlVabDNucVdCeUxLMmk2elYrNkU0d3o4cElaVWh6dHgxaHZ1?=
 =?utf-8?B?eTlRZE1FU0c0bm5FdnRtUS9ENGRweG0yWVhhelpzcHgvWjJFSjBVcGMrNVFN?=
 =?utf-8?B?bGwvT1JFVUg4SUNTQlFZM1ZPY1VsM2NPUndEV3lVVlhidWtudGxyU0FSd0c5?=
 =?utf-8?B?TFpTeWhvdnNlcU1RQXpXWUlVMS9MaEo2WWdhV3M0N2pRNThNY1Z4MVA4ZThL?=
 =?utf-8?B?QVpOYUxyckltQkFBNmRONEU2UkJHaHREdDJJWit2aXBMWExuelB1aTEyN21V?=
 =?utf-8?B?VGxsQWtKZWJEL0dLK0pzQnpkb0hvSWJyejVoejhnbm9DLzlrVVRXY1NCQmc0?=
 =?utf-8?B?cWFFbEJyRy9BMTBzZ3VvbmRmWXZ3dUo0OGVWc3lSOEhycEx2M21KQnRudjBQ?=
 =?utf-8?B?d2hjdmpkMmJ3S2ttN0tEa1NiT3Vab0lXSC9KbHJpQzhwQXhYY0JHREpkcW43?=
 =?utf-8?B?UzdTcDA0Z1BIRFVETUMyclN5Z2FIVGFRcDlxOEMzQ0hiZVpOdHpXcXd2d25r?=
 =?utf-8?B?UW5ycnRkQkpaRGF2VDVxOFZyY1czR2JiUk5KbFRRVXhMN2s0QnNhSGZIOWR5?=
 =?utf-8?B?YjVsODNqNkpoeEltZ0wyVERqNjBaUXE3WG8xaGhkcmNEdzVEUWhVbVJ1U1kz?=
 =?utf-8?B?SzZucUs3NEdDdkYyY1huaExFWHV2ZzRYRWdGT0pCMHlnbWVrdDUrdXhqdjAz?=
 =?utf-8?B?eW4yTDM3eGRLZ1RRY3dEeWFrRk5YYzhCOHArUlBJQktoeXlVRCtuNlpDVzV0?=
 =?utf-8?B?T0J4WENncEt3MlNjcFNsUVc0ZnFyTHpxT213dFFuMnJrenF4aU80ZThITDNJ?=
 =?utf-8?B?a1BFTHJXS0hBbS9wVFRRY3czNEY4NUI0bFdkMC8xeEg2NURYaWs3cG5yVkpt?=
 =?utf-8?B?OTIzVUJLZURxUUFFVWdHOVJha1RZS3hPYkpJeUZFWDhwYjFtbTRFM1Z4bVdr?=
 =?utf-8?B?a1lPWmphR1ZhaG9jTWZWM284QjAycHBVbTRuenlYVklPd3hmNDdaU2NFc0NM?=
 =?utf-8?B?RE5sTHltcDZ3dHBsamtBME9NQnZJZ0VSWHlnSW81ZDRKV09lTm9JUGxBTmtO?=
 =?utf-8?B?RzJvMmZDWXJxQkxNVjU1RHl4blVycngxckpuQnZkUS82My8vYTFjOTdjMzk2?=
 =?utf-8?B?dExEMVFZWVJnanc1b2l5WFRPYUhMcHQyTjJ5ODUyQUNMbmt4V1BoSUN2VG5m?=
 =?utf-8?Q?QsiZ0sHOl6DgBwaIhm4c6+H7aCY+cm08lScKmvc4Q4FU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86105A0B1AC3D04099EC8EB4233F1E13@namprd10.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 10838d81-9150-4999-2c0e-08dc33a7ab89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 13:10:41.0015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ef/rwZ7sl+TPNAzlepNUF7vzhKHkVKflc2Fe10LhSn6AJwaGuxa5JmCloZCHBmE0hFYhBQOObazzzPBo0dm/Qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6564

T24gVGh1LCAyMDI0LTAyLTIyIGF0IDEyOjU0ICswMDAwLCBFbWlsIFZlbGlrb3Ygd3JvdGU6DQo+
IE9uIFdlZCwgMjEgRmViIDIwMjQgYXQgMTE6MTksIEpvYWtpbSBUamVybmx1bmQNCj4gPGpvYWtp
bS50amVybmx1bmRAaW5maW5lcmEuY29tPiB3cm90ZToNCj4gPiANCj4gPiBGcm9tOiBKb2FraW0g
VGplcm5sdW5kIDxKb2FraW0uVGplcm5sdW5kQGluZmluZXJhLmNvbT4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKb2FraW0gVGplcm5sdW5kIDxKb2FraW0uVGplcm5sdW5kQGluZmluZXJhLmNv
bT4NCj4gPiAtLS0NCj4gPiAgbGliL2JsdWV6LnBjLmluIHwgMSArDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9saWIvYmx1ZXoucGMu
aW4gYi9saWIvYmx1ZXoucGMuaW4NCj4gPiBpbmRleCAzZDZlNTk2MTYuLjFjMmYzMGIzMyAxMDA2
NDQNCj4gPiAtLS0gYS9saWIvYmx1ZXoucGMuaW4NCj4gPiArKysgYi9saWIvYmx1ZXoucGMuaW4N
Cj4gPiBAQCAtMSw2ICsxLDcgQEANCj4gPiAgcHJlZml4PUBwcmVmaXhADQo+ID4gIGV4ZWNfcHJl
Zml4PUBleGVjX3ByZWZpeEANCj4gPiAgbGliZGlyPUBsaWJkaXJADQo+ID4gK2xpYmV4ZWNkaXI9
QGxpYmV4ZWNkaXJADQo+ID4gIGluY2x1ZGVkaXI9QGluY2x1ZGVkaXJADQo+ID4gDQo+IA0KPiBJ
dCBzZWVtcyB0byBiZSB1bnVzZWQgaW4gdGhlIHBrZy1jb25maWcgZmlsZS4gV2h5IGRvIHdlIG5l
ZWQgdGhpcz8NCj4gDQo+IA0KDQpCbHVleiBkb2VzIG5vdCBidXQgcGtnLWNvbmZpZyBpcyBmb3Ig
b3RoZXIgYXBwcyBzbyBpZiBzb21lIGFwcCBuZWVkcyB0byBrbm93DQpzb21ldGhpbmcgYWJvdXQg
Ymx1ZXogc3R1ZmYgbGl2aW5nIGluIGxpYmV4ZWNkaXIgaXQgY2FuIGZpbmQgb3V0IHdoZXJlIHRo
YXQgaXMuDQoNCiAgSm9ja2UNCg0K
