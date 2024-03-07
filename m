Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2104.outbound.protection.outlook.com [40.107.94.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D65812838A
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 11:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812615; cv=fail; b=Y2+oVScKe7rzvAFbV49rbwmTxb6eJfI3eTr86d0kxMGB0iK9FxhNFAWPL/GzR/cc+NWwzDPGgiPBUrib1OWfak+HkyE3gteZzuotSb29yXbJNaiUyHD13a5HbXh6Yp4Pqw2Rk4ZlfjeFrsF1UIm32A+bKw0qt8BCoL2mgTXHtFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812615; c=relaxed/simple;
	bh=tjPqlGfe2wcceGMeJA6mdOoL0D4nvcVbW61y17SqeMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jwLBo7sI8H/A2rlAiXtHo6YG09nCuZOURhCMzZMqSK6o4JxeFaa/pDdAdAZrvwWiGQt3U8CISliM0HF3XPHlLSUhdIf3PtatC4ppxj5FhK7Ig5ABPUpvEu5XtDQy13q+vWzO+EA+Xkr7wbMuv6HsDdQgekKBEgM4foSWjmnK9Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=bX6d5oB2; arc=fail smtp.client-ip=40.107.94.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="bX6d5oB2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNV7O+EckhmbL5IpazTJgVkxEIPHajws5mUp9MtbHMqGMoqNOKpFPfYnldyZXWMqljATNunC6A1NJAYKwU+9bFEz8hG6EqEa1rpn+CAY1SEDWX1/bOp69G2mJ3wWGG7Ich4lBkaPQRTJbrrIx/LgCYaSKioC/tTTsC9NTHYZkS9dcxvPz+lh3EynlVl6nJdvYsA2Vw4J14jv0SmrpA5GQllIj8ilxxFDjeTdIy8peTRzLJHSxgpsAXyxe/nb+C9VZa2hHdJ7wK/1j9V+9RIxlbNSMVVzNxfHYAkjhV9ogzzKOTNZLnpB5vM03N+N8quNPzSuROwnzHaQCdUBlpN8zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjPqlGfe2wcceGMeJA6mdOoL0D4nvcVbW61y17SqeMA=;
 b=ZwWh/kTsyi//b2aAbvet7DnCQDGaavsH0jeQsc5wx5l4rKpo9h+yBQTA0lv7OGkaNh5k/kFjSQ4NFOiw5Y1aZ+d2fakgrIA8QpvFRS1nFrRyysN/dvDJ9fQnTCfidCXlDk3rmY3P4VhD2pQiRk3jjXWbqKKDyD6EzeTEgsYBPqyJgT+pmVtMoy+0aYeSsaOyfxJf7Y2vMpTJ9Nu+RZgNjiGvKxkJNi4ag20Ia/S/AeNZykFbdbw5L/SW5jLbSEiCWTKGCqKdsMgOZETuIIAUy/ajWcHCucGnEjCw/a+pC+bvLutSf/Gg891jZ2FNyfNJP9jeAR49kXsnNi4H+nWJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjPqlGfe2wcceGMeJA6mdOoL0D4nvcVbW61y17SqeMA=;
 b=bX6d5oB2bOA4ihdzMhedQQm9sEdmWAsvonczoL9XlC94DOUz6trrv+xzb/hE4TeWpE60HYZRRfRR0ROCE1hQqyQptyby1Wrm5y5o5LrRdXCvxgXyJ9UU0WCkCmitYtNsjCK/66IVmujRcl5J6TsiJbFJ4E0eI4Cf71Y9OKaBkh08miyAKj8a3O56x03CotHDSn6Q0ZRv8oNg8aVSOBLc/2j5hs17IOWz3BjOO5oQBN1XhCFh9SHwI4YAt5TBrhKB2JN0qaC1WkF9SDO7C+BCt0+0YuVBtE0+HVbIFh77doNvKLSEv1ALsGO/0Fxts5AgrNhdNsx4DIZ7jrkowENxyg==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by IA0PR10MB6746.namprd10.prod.outlook.com (2603:10b6:208:43e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 11:56:51 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::729a:781f:69e3:b6c0]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::729a:781f:69e3:b6c0%4]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 11:56:51 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] obexd: Install D-BUS service for non systemd
Thread-Topic: [PATCH] obexd: Install D-BUS service for non systemd
Thread-Index: AQHacCgExWWv14AXa0qsIOYna8gO8rEroiGAgABNvYCAADzlAA==
Date: Thu, 7 Mar 2024 11:56:51 +0000
Message-ID: <9d18a05c582dfda902969523fdca95ea79cd60d4.camel@infinera.com>
References: <20240307004006.1173879-1-joakim.tjernlund@infinera.com>
	 <CABBYNZKixCvfq-eZLVgq7ccv_mui-h6QH+5WJ0=mUPut-z4P5Q@mail.gmail.com>
	 <b3090d0c46d51bf8cac9848167fa6d56b8236e53.camel@infinera.com>
In-Reply-To: <b3090d0c46d51bf8cac9848167fa6d56b8236e53.camel@infinera.com>
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
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|IA0PR10MB6746:EE_
x-ms-office365-filtering-correlation-id: 2caaed31-1c71-48ac-4511-08dc3e9dad02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HWqC8HtUJUU9fnxy2Ell8/JAlOFeqWguDIY6XvxSMo9xBIqYr8atInfRes4YF6QxMg6GNQ3xWZ+UK76Mey5IQmoizGkGPgq5JcNyInRLYBqHbRvTBIC1204QPsVi+tlJ69pGVbXNcgN8c+VtUIcKbySydTr8w5o0XLGQoI+okzAWvdDWGTpTfgSZe8WBNRvr4JLaXqKt4VTCSenWhqzb9kKxVHPhYxNPYvGD+xZQYcz1/JwYe0va6AEP8YhT/GR8RPnK0wi+hvjJlpOyObtcfctBKTxw9ttPtSqx7sPlT2ql/0PljsWABYplh6NyEws+z+HC9APKTdciJ/8uaobOMr7RWdYVBcQ7g8I7yw2bM9mcXz+Kqsu7xVz1FnhVhmu2qROdlYB8CJFdIrGW8jnAvBVDQ4bmYoHSbtGH3/Z4J6uwHyZBVucBGBZb7hu+c/rnoGTR9t/FVyLw8luDoblpReYsSI/URFfiXO0Bmq9qAlbzsvwat3JKpM3VudBMT1JJ2NuMXnXu4OyqgEW6jrSxwgRMu7Ua2Y1N8UdtngWppwXduoGWb7DW2J9aWHnANguxoOYTXhgH6rSObyeR3cU+PuTROyg1z0p6EUKkh17XMLUjrRsOg77rKIa7MXcvBF7BoyNi+6y4rQD+N+REMfeVvDJRXysvfwwh3hPfmLI3JmP0N3r8qhWpDU5xLqjjc0W/4k5scoJwKr/tSFNwOo/2e61DHiL7476nInZXH5EAnKk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TGZCNjJ4a0J5OElmKzNucFJHM1BpRUdaMVhSR1VuMVdyUFlLYVpVYjBON05K?=
 =?utf-8?B?UDBMS2FqZkV3YWFDQ1Q2YldLVi93WEozVXlFUHAwQTBHKzlBY2pKY0RXaW1G?=
 =?utf-8?B?eHVmOGlsOHlHNW9kV0F2MGhDQm9DNUZzeTF0ZHRIcFFILy9JREdmZ3haekJz?=
 =?utf-8?B?aThmV28wT011ZURnaEdmRWEvN0JTQ0tVMC9IUDBrWGtTbUcwN01Va1BMWloz?=
 =?utf-8?B?RGFLb2UxYzZ4aEU0WlJLTkJoM3FxUFAyZUh5T1VDQ1FQRmI2RG5MbnBqcXNx?=
 =?utf-8?B?M3dUS1dKbVBpSGZneDhuSi9iakl1a3FlZmdqcFRrTDBPTmV6SHo4eTFRY25v?=
 =?utf-8?B?azJzeFc3UXVFUERvQXRVSUJDbXFQcmYyc2k3d2ZmOEdoRnA0OWliRjN6Z2NP?=
 =?utf-8?B?QzQrTk56MnFyUWNtRkFPWmJTWkpYa3BydHM5Y05lOEk1L1QvUDJETlNwZ2xq?=
 =?utf-8?B?UUNYMzNUTmZvU09JdEpIWHUvWjN5dU0ydDdjNkpoV3RjNDhxWVBFMVZVQnU1?=
 =?utf-8?B?MXdBQzJkUmVjT21RL3FJZ1BwaE5OemdXOGpSQk4yNWdnYkhMWmM5NkdReGN4?=
 =?utf-8?B?ZlJwQ0I0QmIvK0FxdFM1OWsycDJmRGpkellhTzYwT09hWUwvNE1lSEpicWgr?=
 =?utf-8?B?ZkFHRlAzZXdmM1BiM0YrVHgzK0YwRUdsQlJMQ0tXL1pzSmMyUkE4Y1FQYUg1?=
 =?utf-8?B?Q0x2MnRIRndSNlJLdWVkeWJHci9IOXE4YWtIQWdHVEwzTTRPczZRajhYcUth?=
 =?utf-8?B?WGZ4a1JYMmduYko5YXJWTGJJbmtXeDJkeWRHWmRlTFAyRThRTnZ1dHMraHor?=
 =?utf-8?B?amN3Z2dESW8zYllOa3Z3TmdLU2NDMXFvTzB1czRZRllxakVJb0FSRTh1Q0hW?=
 =?utf-8?B?QUUxZWVKUW55NDZVSE1OMXBaZFVHa1BSUGV3U1NpYVFJSFJDNDFEQUZNYkF0?=
 =?utf-8?B?QWU0aTNZbU9WOWJsYmRLOEt0TEVodzB2dU5jRkZNa1l4aGxFUnZEVnpDWU1q?=
 =?utf-8?B?M1BXSXBlMXFnVmptKzY0L09Tc2xPNW9Ob0c2SDRJRlF2bWZ3SFducGtBK2tV?=
 =?utf-8?B?anR2QmpreitlZG9ZcnNmSU4vRU9JSU5ZRS83RmdKdGc4STJOVkFuV1kzbGdm?=
 =?utf-8?B?azVhUkhOR1ZZNlI1d1AwOEtRMkJoMWtJTUJNRFFSVXBjUVlhdis4RVoxaS90?=
 =?utf-8?B?ZmVZYmgvWHB5TS9nSURzY3Y5NkNPVHpIZkxpYnRKTHJrWHFMMTh1aFp1NTVF?=
 =?utf-8?B?NW0yaEhYTnRlcFdPUENOZVFRK1ExUzluZGhlMFdhd0xpR25ZSDgxekgyR2Ju?=
 =?utf-8?B?NzRLWXRYK1VheU1oamQya0dBSVVaRDYvQW95Q1RqUUJ1UnFVZjY2ZHBmZFIz?=
 =?utf-8?B?b3gvbFFhVEVwMUlRT0NLWTVyRW5QQlZyQ1dGaEhYdC9vMG1GcW53TXdZN05G?=
 =?utf-8?B?UERXZGRNa1ppR0hJMGlmbzF5WFZGZTFhcGpMOWRid3ltbU5NcTBSNUNKVDFY?=
 =?utf-8?B?Z0YwWTE0MVdNTE9tUU1oZFRMSzkxdlRwaVM5YXZqdkZiNjl6SCtKUXppYWNV?=
 =?utf-8?B?aXk4djdkVG8rM2xTOVlRNzVKTzdHUXBLYWZWcDFYcjUvWklTNU9BTStaV0tj?=
 =?utf-8?B?ZTd6ajB0MUVzMkUvWUJ0azl0YWl3a1QxR3diRGVDZXg0Z0RPSzM2aER6Wjg5?=
 =?utf-8?B?RitZa2gxNllFTTdVWGM0anlYdjFaZ2dBNXBYZUxUUDY5d2JTd0JJNUpqdW1Z?=
 =?utf-8?B?cW1CYUdTblBseEZnQVF0OEYrZzF0aTZReStRU2xhaHU3OTFhQ2ViT3lQWmsw?=
 =?utf-8?B?Y3hJNTJDZlR0MkhpS1RRYUhsWHlQeUh2d01LVG5oK3o3R2VkRlRnanN6czB3?=
 =?utf-8?B?bm5OU0lPVlNEQ1BSM2hNaFJmQ2NPOThZWWM4QmNFR0YvblRkZEhnaW1zSnRT?=
 =?utf-8?B?T1FQMUVDeC9qWEkva1Z6Zzl3VzcwcEVWRDFUUlN2R1FCNWpQbWYyTEhVTDRh?=
 =?utf-8?B?SWJ3V1hPZEY0bDUyYU5jU2M4cmsrdVB3ZzdCUldjMkhVbk12TS8vQU8xd1Yv?=
 =?utf-8?B?c1E3MFl6ak9vRU1mRU9yTDRWWW1VZHcrVE1OK2hBamlMMWlvekRSNWJDdmJR?=
 =?utf-8?B?YmF6VmRZUWI5V0NQWVdRSGNqL0NxQ2NNbHNOSHUwU3pnNWlVVW93c0tvSUx2?=
 =?utf-8?Q?MNvzugN+fR4jH/VDOASQ89ySi1orCCkgxJQoSwMyuuC1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D3FA2E84F006848B2386AD90E5E6ED7@namprd10.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2caaed31-1c71-48ac-4511-08dc3e9dad02
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 11:56:51.3101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hdkb3N6O6u+QcXPV/UQ1gEelSooJlG/uE0KyLDj6Vor3Pfbh3JXtH7ixq6KR3+YQtATioMdKg+h/ZH2jOqEydw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6746

T24gVGh1LCAyMDI0LTAzLTA3IGF0IDA5OjE4ICswMTAwLCBKb2FraW0gVGplcm5sdW5kIHdyb3Rl
Og0KPiBPbiBXZWQsIDIwMjQtMDMtMDYgYXQgMjI6NDAgLTA1MDAsIEx1aXogQXVndXN0byB2b24g
RGVudHogd3JvdGU6DQo+ID4gSGkgSm9ha2ltLA0KPiBIaSBMdWl6IDopDQoNCkZZSSwgdGhhdCBw
YXRjaCBzaG91bGQgaGF2IGJlZW4gc21hbGxlciwgdGhpcyBpcyBlbm91Z2ggdG8gZ2V0IHRoZSBE
LUJVUyBzZXJ2aWNlOg0KZGlmZiAtLWdpdCBhL01ha2VmaWxlLmFtIGIvTWFrZWZpbGUuYW0NCmlu
ZGV4IGVkNGY5ZGM1MS4uZTc4MGZjYmIxIDEwMDY0NA0KLS0tIGEvTWFrZWZpbGUuYW0NCisrKyBi
L01ha2VmaWxlLmFtDQpAQCAtNDgsMTAgKzQ4LDEwIEBAIGVuZGlmDQogaWYgU1lTVEVNRA0KIHN5
c3RlbWRzeXN0ZW11bml0ZGlyID0gJChTWVNURU1EX1NZU1RFTVVOSVRESVIpDQogc3lzdGVtZHN5
c3RlbXVuaXRfREFUQSA9IHNyYy9ibHVldG9vdGguc2VydmljZQ0KK2VuZGlmDQogDQogZGJ1c3N5
c3RlbWJ1c2RpciA9ICQoREJVU19TWVNURU1CVVNESVIpDQogZGJ1c3N5c3RlbWJ1c19EQVRBID0g
c3JjL29yZy5ibHVlei5zZXJ2aWNlDQotZW5kaWYNCg0KDQo+IA0KPiA+IA0KPiA+IE9uIFdlZCwg
TWFyIDYsIDIwMjQgYXQgNzo0MOKAr1BNIEpvYWtpbSBUamVybmx1bmQNCj4gPiA8am9ha2ltLnRq
ZXJubHVuZEBpbmZpbmVyYS5jb20+IHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBGcm9tOiBKb2FraW0g
VGplcm5sdW5kIDxKb2FraW0uVGplcm5sdW5kQGluZmluZXJhLmNvbT4NCj4gPiA+IA0KPiA+ID4g
bm9uIHN5c3RlbWQobGlrZSBPcGVuUkMpIG1hY2hpbmVzIG5lZWQgRC1CVVMgYWN0aXZhdGlvbiBm
b3Igb2JleGQgYXMNCj4gPiA+IHRoZXkgbGFjayAtLXVzZXIgc2VydmljZS4NCj4gPiA+IA0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogSm9ha2ltIFRqZXJubHVuZCA8Sm9ha2ltLlRqZXJubHVuZEBpbmZp
bmVyYS5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBNYWtlZmlsZS5vYmV4ZCB8IDUgLS0tLS0NCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAt
LWdpdCBhL01ha2VmaWxlLm9iZXhkIGIvTWFrZWZpbGUub2JleGQNCj4gPiA+IGluZGV4IDM4NWU1
NjE4ZC4uY2ZjYzExNWI3IDEwMDY0NA0KPiA+ID4gLS0tIGEvTWFrZWZpbGUub2JleGQNCj4gPiA+
ICsrKyBiL01ha2VmaWxlLm9iZXhkDQo+ID4gPiBAQCAtMSw3ICsxLDYgQEANCj4gPiA+ICAjIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gPiAgaWYgT0JFWA0KPiA+ID4gDQo+
ID4gPiAtaWYgU1lTVEVNRA0KPiA+ID4gIHN5c3RlbWR1c2VydW5pdGRpciA9ICQoU1lTVEVNRF9V
U0VSVU5JVERJUikNCj4gPiA+ICBzeXN0ZW1kdXNlcnVuaXRfREFUQSA9IG9iZXhkL3NyYy9vYmV4
LnNlcnZpY2UNCj4gPiA+IA0KPiA+ID4gQEAgLTEwLDEwICs5LDYgQEAgb2JleGQtYWRkLXNlcnZp
Y2Utc3ltbGluazoNCj4gPiA+IA0KPiA+ID4gIG9iZXhkLXJlbW92ZS1zZXJ2aWNlLXN5bWxpbms6
DQo+ID4gPiAgICAgICAgIHJtIC1mICQoREVTVERJUikkKFNZU1RFTURfVVNFUlVOSVRESVIpL2Ri
dXMtb3JnLmJsdWV6Lm9iZXguc2VydmljZQ0KPiA+ID4gLWVsc2UNCj4gPiA+IC1vYmV4ZC1hZGQt
c2VydmljZS1zeW1saW5rOg0KPiA+ID4gLW9iZXhkLXJlbW92ZS1zZXJ2aWNlLXN5bWxpbms6DQo+
ID4gPiAtZW5kaWYNCj4gPiA+IA0KPiA+ID4gIGRidXNzZXNzaW9uYnVzZGlyID0gJChEQlVTX1NF
U1NJT05CVVNESVIpDQo+ID4gPiAgZGJ1c3Nlc3Npb25idXNfREFUQSA9IG9iZXhkL3NyYy9vcmcu
Ymx1ZXoub2JleC5zZXJ2aWNlDQo+ID4gPiAtLQ0KPiA+ID4gMi40My4wDQo+ID4gPiANCj4gPiAN
Cj4gPiBJIGd1ZXNzIHlvdSB3YW50IHRvIHJldmVydCA5Y2M4Yjk3YjhmNWQwNjBlMzM0MjA3MTM2
MTAwZTk0NzczMmFlZDA4LA0KPiA+IGJ1dCB0aGVuIHdlIG5lZWQgdG8gZml4IHRoZSBjaGVja3Bh
dGNoIGVycm9yOg0KPiANCj4gRG9uJ3Qga25vdyB0aGF0LCBhIGJpdCBjbHVlbGVzcyBhYm91dCBk
aXN0Y2hlY2sgYW5kIHdoYXQgaXQgZG9lcy4NCj4gRm9yIG1lIGl0IGZhaWxzIGJlZm9yZSBteSBw
YXRjaCBhbHJlYWR5Og0KPiANCj4gLi9ib290c3RyYXANCj4gLi9jb25maWd1cmUNCj4gbWFrZSBk
aXN0Y2hlY2sNCj4gbWFrZSAtLW5vLXByaW50LWRpcmVjdG9yeSBkaXN0LXh6IGFtX19wb3N0X3Jl
bW92ZV9kaXN0ZGlyPSdAOicNCj4gICBHRU4gICAgICBsaWIvYmx1ZXRvb3RoL2JsdWV0b290aC5o
DQo+ICAgR0VOICAgICAgbGliL2JsdWV0b290aC9oY2kuaA0KPiAgIEdFTiAgICAgIGxpYi9ibHVl
dG9vdGgvaGNpX2xpYi5oDQo+ICAgR0VOICAgICAgbGliL2JsdWV0b290aC9zY28uaA0KPiAgIEdF
TiAgICAgIGxpYi9ibHVldG9vdGgvbDJjYXAuaA0KPiAgIEdFTiAgICAgIGxpYi9ibHVldG9vdGgv
c2RwLmgNCj4gICBHRU4gICAgICBsaWIvYmx1ZXRvb3RoL3NkcF9saWIuaA0KPiAgIEdFTiAgICAg
IGxpYi9ibHVldG9vdGgvcmZjb21tLmgNCj4gICBHRU4gICAgICBsaWIvYmx1ZXRvb3RoL2JuZXAu
aA0KPiAgIEdFTiAgICAgIGxpYi9ibHVldG9vdGgvY210cC5oDQo+ICAgR0VOICAgICAgbGliL2Js
dWV0b290aC9oaWRwLmgNCj4gICBHRU4gICAgICBlbGwvc2hhcmVkDQo+ICAgR0VOICAgICAgc3Jj
L2J1aWx0aW4uaA0KPiAgIEdFTiAgICAgIG9iZXhkL3NyYy9idWlsdGluLmgNCj4gbWFrZSAtLW5v
LXByaW50LWRpcmVjdG9yeSBkaXN0ZGlyLWFtDQo+IG1ha2VbMl06ICoqKiBObyBydWxlIHRvIG1h
a2UgdGFyZ2V0ICdlbGwvdXRpbC5oJywgbmVlZGVkIGJ5ICdkaXN0ZGlyLWFtJy4gIFN0b3AuDQo+
IG1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MTIwMTY6IGRpc3RkaXJdIEVycm9yIDINCj4gbWFrZTog
KioqIFtNYWtlZmlsZToxMjA5NjogZGlzdF0gRXJyb3IgMg0KPiANCj4gDQo+ICBKb2NrZQ0KPiA+
IA0KPiA+IGNvbW1pdCA5Y2M4Yjk3YjhmNWQwNjBlMzM0MjA3MTM2MTAwZTk0NzczMmFlZDA4DQo+
ID4gQXV0aG9yOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZvbi5kZW50ekBpbnRlbC5j
b20+DQo+ID4gRGF0ZTogICBNb24gTWFyIDQgMTI6NDQ6MDggMjAyNCAtMDUwMA0KPiA+IA0KPiA+
ICAgICBidWlsZDogb2JleGQ6IEZpeCBtYWtlIGRpc3RjaGVjaw0KPiA+IA0KPiA+ICAgICBUaGlz
IGZpeGVzIHRoZSBmb2xsb3dpbmcgZXJyb3I6DQo+ID4gDQo+ID4gICAgIC91c3IvYmluL2luc3Rh
bGw6IGNhbm5vdCByZW1vdmUNCj4gPiAgICAgJy91c3Ivc2hhcmUvZGJ1cy0xL3NlcnZpY2VzL29y
Zy5ibHVlei5vYmV4LnNlcnZpY2UnOiBQZXJtaXNzaW9uIGRlbmllZA0KPiA+IA0KPiA+IA0KPiA+
IA0KPiANCg0K
