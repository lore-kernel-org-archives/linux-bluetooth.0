Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2102.outbound.protection.outlook.com [40.107.237.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D5134CEA
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708608179; cv=fail; b=VbdnTixLxa/tPEO/EH1PFopPlof9vjiOk/rUQHOjz5iRfTnDkrBBEnvZVA3nZRoE20DUHaMC+4H32Me8Y1SfKzusLINsLMuSPN+vYdw/wey3DtlhLXE8lk0vSBFcoFCXsVoJb3nDO/iKHqpJCIc1a2rONq9UtPehInZROIQnXzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708608179; c=relaxed/simple;
	bh=HlccImGdG9/lhzUzKkCSDQK+BQgIyDQZ9njUU1EnTNY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GeHAh1csYqHCAVBCp0c148lVMFVFFUS9ZLMqtxdy+EEGJPLECYFo9WskLHmOdetZWyilI9TbFclrWodp5PMtn/yMhJdAJ+K+IvM42szTWltmrGVudPJ4h100QcavoHSap55iylZ7nNDxWVFYgvX7YqK84PitsmS8gnuVlY+a4Gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=cWAl7WVC; arc=fail smtp.client-ip=40.107.237.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="cWAl7WVC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NICFGX40WZFETZ8j5MjRBygyRSEHrZM4Uj5cAoXykpqhhsV+B+Im603bSgEU0JDX/Q9MddBzrIPNJcKyX+CzWnfgnnZ31oHmptXcn3pqYDUBP3II4oVh6HUB1meEZP6u2hjs5Cs0t/cJUNCgNGXwr9cAKQDUTOXlsnwRL8HxpU1R9LJ8FIgDN1e66rswgIBIdwQTncWL2dWa25DpgJ2YTdxCGuX49mHtwJkQhNcYOlTsw5+RBqXp4pPl3x5ll8X+g+sjgEXV5cV0EwnxqL6ulfz3NAo87xrMoUYhXB1Mz1RGd6o19ju+QkugS/krtsZZmMLRF/YzCvvqxW409Pjemw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlccImGdG9/lhzUzKkCSDQK+BQgIyDQZ9njUU1EnTNY=;
 b=b01BrN3RaOjc/HYCZCtQr1Lk7/dgJKaf02mR3pWmMMEBzpHPw0WryBTyss3gVxy2z3ur0WYnnlANos6pGbVZVXvM87Z5kRYp25Wh23kXbMk4Le+TZqeiwcP29VAShcDmSnpG4x6fvDJvlIOr42MXrtBr6w3ggkXJsdgwo+Oy7Qh7pg0lwosG0vlDRvRbBu45IZTZo9gxbLAZtfO/7o06Gach+mJt4ssc5y8rRNzLAiMUuqLrL8aA30CzvmzVd/OTCsaH7S4r8I7oOTGqLjjFy45QYLbNsVWYccJqNr0lZ+rLGstcHZ0rPU+03Qtk+VhsEVxI/VsyYXu9bwIRY+oILA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlccImGdG9/lhzUzKkCSDQK+BQgIyDQZ9njUU1EnTNY=;
 b=cWAl7WVCRbrXhqmeeM2Dn4X7Dtf0Z+BC/DFxkNk2IpnyOWWjeaW3xkC5SSlyy6Ta9JFfKO02l1S0wThw6i5GsRdrYvSnVCadNO8/UPu2BFS1HzwH6IqkZRRdLi8vor68sErDLgUXnn1pJjqKOzB3Vs6KyVeBP72iSTzuunZfUKDuyCMq34XcP1/fbfWWhZKnD+W2XvZvpIw7t+GnVzprHhegchqN0EogTKNDZUan0Fgm2D2hbTqckKOYjM8ak8Tv3qUbEVeY7kf71agWTE7u5qW0FpOzHtyhlc3UBc+HQZshbQ8mDZ/ZRDWHps7zkUATFap/Qos9WZFHW7GHFUgtuw==
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by SJ0PR10MB4495.namprd10.prod.outlook.com (2603:10b6:a03:2d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Thu, 22 Feb
 2024 13:22:55 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::4d76:4230:708c:9eea]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::4d76:4230:708c:9eea%7]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 13:22:55 +0000
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "emil.l.velikov@gmail.com" <emil.l.velikov@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] CUPS lives in libexecdir
Thread-Topic: [PATCH] CUPS lives in libexecdir
Thread-Index: AQHaZLfT1nCv5+aVKkC52rrUBwIM8bEWVl8AgAAErQA=
Date: Thu, 22 Feb 2024 13:22:54 +0000
Message-ID: <4fdde6807ed152d0d24e086fd3357b7c4e410391.camel@infinera.com>
References: <20240221111901.2807853-1-joakim.tjernlund@infinera.com>
	 <20240221111901.2807853-2-joakim.tjernlund@infinera.com>
	 <CACvgo52M-Efhp92u=fd8qDjV39SWvuoakLgt2JtFftDmZ2pn4g@mail.gmail.com>
In-Reply-To:
 <CACvgo52M-Efhp92u=fd8qDjV39SWvuoakLgt2JtFftDmZ2pn4g@mail.gmail.com>
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
x-ms-traffictypediagnostic: PH0PR10MB4615:EE_|SJ0PR10MB4495:EE_
x-ms-office365-filtering-correlation-id: 2ee196a8-7830-4958-d015-08dc33a96109
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4/2DDfqY+p9PMqQCvUXLosEXyTdawqG11Op6lm70P4ajb66kgga8xDmZSRDE3ysOoQAAjgQskeb8VHxCkPwi+DeNolo3JpkExlVeotBxmuLi/UJhTzeYj6GHwMAsXZZacjWZbdOervzTlshjcey1C3xLR/aK2yVLBIRaGycMuaAPUta/s+IVynhMm9KE78P3H8SfZS5wM80XxZlg/edtlItOtaYkE+K5Lgc9d8yEkIf8vH5HkFLuBWIJ0bZ6MLVx5pnGOWC3u1XS984fC3DmniFT20LtNYctG0UW/GDy2ttHBiqytIG7gKD7Q3+rYlK+yJx7JBnbpmgAvqnVWzOSSExyxr7Hoqb83QPp6MDwNYxIsZHvdNamDzng1FogaRP0yFE9N104lCq2/YJXyPLfBNk63HC9w72eF0+jIYUkeDN5cJvFmz9Z5s4ZZHw5OK4hm7Dzl7Y4C7pctMKVfJtRxAHV/wggdNnrX9lkfuR2S0b1UsA5Du5QYy7Bl7NKYg0wDT0kYsmrao29dY0vkPBlhqBbZPUb+LRhpRTbb4nffYbGG7VKS4TC4kOKTKC2k+UvsYcuu/3dS5HxmfN1UIVVv6HTNLmlQqsSuzEMH7I9vEw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzVXbDJMMFFmc09MU0NoZld5c05FUFpVcW9FOXpYQU9pMmJIdE55ZCtvekM3?=
 =?utf-8?B?UGdTa2dMdU9vSCtmakdXYlJvR1FYbWlWZmtuOWxrRGpxWFlEMEV6Lzdlc3J3?=
 =?utf-8?B?OEthWG10U3A1UFFESVJHWFZzWm1QdXJoNUhtZ0dyMFA0Mm1JK1hFSXpRR2ph?=
 =?utf-8?B?YUZlRVJyN3VxN3VjbVgrQVU0N2JZMWJzVlkzM0d1WGNmSXpZUFBjNWpqZDJ4?=
 =?utf-8?B?eXVlbmg3ZEVJYzFBS1pTVHk0b3pSS0xKTmV6RURxY1U4d2hwRUFWcEdFZ0h2?=
 =?utf-8?B?aEhUTW9BODVCMkIzVDBEZ3B0b1pVbGpncks1L2l4WjVMUVl4aTc5MVYvdG1D?=
 =?utf-8?B?QnV5WHJFYlh1YVgvUlR6M0NycTYrdWx2ams4VGIzN3c1WGJtMkowaVZiS05i?=
 =?utf-8?B?TFkvcDBwRWpqNHB2NWdCV2szMUtmMTM1d0EvbmJKZkZpc3BRZmt2NUk3Qmlq?=
 =?utf-8?B?Vm1rY2NzVGRNRTVMQ25EL3M5eUMrdzlQNGJxR2l0NlZCV1RmRG1hTHBsVytJ?=
 =?utf-8?B?MGEwanhhckQ2bmQ4ako1ejd4SjRYdnA2QlZvSzVGTVZkZXZSZ0hIZHcvYnlS?=
 =?utf-8?B?cU44RTJqOStzSlVoeUpRSlFQb1pHY211Y0lhbWJ2YWV6d1FPVWRuS0gra2tE?=
 =?utf-8?B?M3RoRHdqUkU0N3NOc2pkbVRzMC8wUkM4Z2EwakxNWFNNY296L2NXWXY3VWVR?=
 =?utf-8?B?MHZzQlZGSmwyemExa3ZHZkJ2MG1Sb2hVYkZKTnpzdzFpNUxkRi9wZGxaS3B4?=
 =?utf-8?B?V2kxTDhWZkRFS0owUVZMLzJDRE9pRGlTVWIvOEJFWGlreFBGdUIrZXhXWS8r?=
 =?utf-8?B?TFVweW0xWnBxakJNcVhYSGRyWHEvY0I3VjVXTk44YXo5R3VZMzFVYUxKcG5R?=
 =?utf-8?B?VVpjQk5XT09nMFFQVGZHK2drMmVPQmtUamVQLzVCRHhwY3JUeS9takhYeVVm?=
 =?utf-8?B?clQ5MTUyZ1IwZHlieGN0dHI5YjUyaUVWYldmUDgwQi9VT0NmaXhPMTJrZ01z?=
 =?utf-8?B?NzRWb09ic280eXZTUzE0QWlzbndGWGpKMUhKUE90bnNyV1h6R0FuOWt5Smk5?=
 =?utf-8?B?VjB1YXBrdzRuV1JxRUxuSUhOMzZ2ZzFmdDBpRy90MWoyL05DQmJsT05lQ2lJ?=
 =?utf-8?B?NGMvd0kvTHFpOStJNUk5bytvRUhKajZBMlB3NGVVUGx4NHlzRmI1Y1pHa1BV?=
 =?utf-8?B?V2JkL3N1WnZmcEZxQ1BFYnRhNThVTzRuQVMrZ0U3ZGZBT1BpWUFQeFQ2L1RR?=
 =?utf-8?B?MUxjZlRVeUdibS9CN0ZWTG5zUStoY3lqNkNuK1VjWlBqeWFYVWFZRlpiY3da?=
 =?utf-8?B?QUl1aGpwQjN0cUMwRGlvTG4wZWJuVlpEL2RyaEZ0bXc5Z2FtcGluUEtocktW?=
 =?utf-8?B?MkJTaysxNjdRS3R5R09VMEthZktxSzZ1VWtTczZ0SzdHcCtEZmtiUithbll2?=
 =?utf-8?B?cmt4dEZzOEZBS2JDaS9uYVFoRUtSOHE0VjhNa2d5ejlHWkpQbGhyUnhEWFlR?=
 =?utf-8?B?ejhkRHpNLzJ6Qm1OY3N6RlNQbHFDOG5TRGlINFgrTGxRcy9tQTZrSXowU3lP?=
 =?utf-8?B?S2FnWW52bSt1QStHTVk4Zk55c3haZ0svQnBTNGt4Wm5qUlF6WVZ3ZWdSRTZx?=
 =?utf-8?B?em5icEJPd2IrRHNjdWFkeDJDYzgrTm5TOFBqTWEySTQ4ZTZ3SDhqYUtXRnY2?=
 =?utf-8?B?SHBKNzZ5UC9tZTlHMm1KV0E0V092MGdLa1N6d0NJdUNidzNSRFBoeHVOalhR?=
 =?utf-8?B?Q2N0Z0RocElKQWptM1ViS202Y1YreFNndStJTWVrYUxnVWJBa0l2YnRQTmJG?=
 =?utf-8?B?TXJxWmg2WHI0WEttZXEwUWQ0SURYRWNCSmh0U1lMeGcvL0prVkdNdll2NEp2?=
 =?utf-8?B?U2lac1NqNGt0dktGUmFVUHlNb3FaR0tCNHhEVnREeFJrSWpxamZOejBkZGlm?=
 =?utf-8?B?dGVyaW1kZVRxSDRPQ3FQOXFpK2xyUlpQZ1hCUmU2WmhadkZEMXA1TzBjT2Q5?=
 =?utf-8?B?RkxWQmxCMmJTWHlvTnFHT3FKTHhPaFowNXZZL2xUeEQ2eVFFMFQ0S1JFeUg1?=
 =?utf-8?B?NmNydUcrUlNtOEdIMTZPTjYwYkRLZFpuM3dtR25SMk9NMjJRSnEwOEQxdEw3?=
 =?utf-8?B?QlZaK3pOSWdURGFTKzRqeFFOZUJwV2tGSDA5UkxKZUpzanYwNzUxRklKVUdK?=
 =?utf-8?Q?80Quro2v1Xu0YrEVGtnyaRSgD/14FCTSQviM6novMLoX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA56B08042CA1B4A9B65F33CB89A6C22@namprd10.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ee196a8-7830-4958-d015-08dc33a96109
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 13:22:54.9689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LlxWGZ4NzbJlFtKKrT4QvTE85Uj/fkapUWcQUAbk7V+erAWbxKxbMV4Eont7vQQ2zpglXbF4jPFEiIwvN94rQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4495

T24gVGh1LCAyMDI0LTAyLTIyIGF0IDEzOjA2ICswMDAwLCBFbWlsIFZlbGlrb3Ygd3JvdGU6DQo+
IE9uIFdlZCwgMjEgRmViIDIwMjQgYXQgMTE6MTksIEpvYWtpbSBUamVybmx1bmQNCj4gPGpvYWtp
bS50amVybmx1bmRAaW5maW5lcmEuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEpvYWtpbSBU
amVybmx1bmQgPEpvYWtpbS5UamVybmx1bmRAaW5maW5lcmEuY29tPg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSm9ha2ltIFRqZXJubHVuZCA8Sm9ha2ltLlRqZXJubHVuZEBpbmZpbmVyYS5jb20+
DQo+ID4gLS0tDQo+ID4gIE1ha2VmaWxlLnRvb2xzIHwgMiArLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9N
YWtlZmlsZS50b29scyBiL01ha2VmaWxlLnRvb2xzDQo+ID4gaW5kZXggMDQ0MzQyZTI5Li5iNzg1
ZWJlYTggMTAwNjQ0DQo+ID4gLS0tIGEvTWFrZWZpbGUudG9vbHMNCj4gPiArKysgYi9NYWtlZmls
ZS50b29scw0KPiA+IEBAIC01MzgsNyArNTM4LDcgQEAgZW5kaWYNCj4gPiAgZW5kaWYNCj4gPg0K
PiA+ICBpZiBDVVBTDQo+ID4gLWN1cHNkaXIgPSAkKGxpYmRpcikvY3Vwcy9iYWNrZW5kDQo+ID4g
K2N1cHNkaXIgPSAkKGxpYmV4ZWNkaXIpL2N1cHMvYmFja2VuZA0KPiA+DQo+DQo+IElzIHRoaXMg
dHJ1ZSwgY2FuIHlvdSBwcm92aWRlIHNvbWUgcmVmZXJlbmNlcz8NCj4NCj4gTG9va2luZyBhdCBE
ZWJpYW4gWzFdICh3aGljaCBjb250cmFyeSB0byBBcmNoIGhhcyBsaWJleGVjKSAtIGJhY2tlbmRz
DQo+IGFyZSBpbiAvdXNyL2xpYi4gR2xhbmNpbmcgYXQgdGhlIGN1cHMgYmFja2VuZHMgbWFrZWZp
bGUgaXQncyB1c2luZw0KPiBTRVJWRVJCSU4uIENhc3VhbCBncmVwIHNob3dzIHRoYXQgbGliZXhl
YyBjYW4gYmUgYXBwbGljYWJsZSBmb3INCj4gQlNEL0RhcndpbiBwbGF0Zm9ybXMgWzNdLCB3aGlj
aCBhcmUgb3V0IG9mIHNjb3BlIGZvciBibHVleiBJSVJDLg0KDQpvbiBHZW50b28geW91IGhhdmU6
DQoNCnFsaXN0IG5ldC1wcmludC9jdXBzIHwgZ3JlcCBiYWNrZW5kDQouLi4NCi91c3IvbGliZXhl
Yy9jdXBzL2JhY2tlbmQvaW1wbGljaXRjbGFzcw0KL3Vzci9saWJleGVjL2N1cHMvYmFja2VuZC9i
ZWgNCi91c3IvbGliZXhlYy9jdXBzL2JhY2tlbmQvc2VyaWFsDQovdXNyL2xpYmV4ZWMvY3Vwcy9i
YWNrZW5kL3BhcmFsbGVsDQovdXNyL2xpYmV4ZWMvY3Vwcy9iYWNrZW5kL2RyaXZlcmxlc3MtZmF4
DQovdXNyL2xpYmV4ZWMvY3Vwcy9iYWNrZW5kL2RyaXZlcmxlc3MNCi91c3IvbGliZXhlYy9jdXBz
L2JhY2tlbmQvY3Vwcy1wZGYNCg0KYnV0IG5vdyBJIHNlZSB0aGlzIGluIEdlbnRvbyBlYnVpbGQ6
DQogICAgICAgICMgSW5zdGFsbCBpbiAvdXNyL2xpYmV4ZWMgYWx3YXlzLCBpbnN0ZWFkIG9mIHVz
aW5nIC91c3IvbGliL2N1cHMsIGFzIHRoYXQNCiAgICAgICAgIyBtYWtlcyBtb3JlIHNlbnNlIHdo
ZW4gZmFjaW5nIG11bHRpbGliIHN1cHBvcnQuDQogICAgICAgIHNlZCAtaSAtZSAnczpDVVBTX1NF
UlZFUkJJTj0iJGV4ZWNfcHJlZml4L2xpYi9jdXBzIjpDVVBTX1NFUlZFUkJJTj0iJGV4ZWNfcHJl
Zml4L2xpYmV4ZWMvY3VwcyI6ZycgY29uZmlndXJlIHx8ZGllDQoNCiAgICAgICAgZWNvbmYgIiR7
bXllY29uZmFyZ3NbQF19Ig0KDQogICAgICAgIHNlZCAtaSAtZSAiczpTRVJWRVJCSU4uKjpTRVJW
RVJCSU4gPSBcIlwkXChCVUlMRFJPT1RcKSR7RVBSRUZJWH0vdXNyL2xpYmV4ZWMvY3Vwc1wiOiIg
TWFrZWRlZnMgfHwgZGllDQogICAgICAgIHNlZCAtaSAtZSAiczojZGVmaW5lIENVUFNfU0VSVkVS
QklOLio6I2RlZmluZSBDVVBTX1NFUlZFUkJJTiBcIiR7RVBSRUZJWH0vdXNyL2xpYmV4ZWMvY3Vw
c1wiOiIgY29uZmlnLmggfHwgZGllDQogICAgICAgIHNlZCAtaSAtZSAiczpjdXBzX3NlcnZlcmJp
bj0uKjpjdXBzX3NlcnZlcmJpbj1cIiR7RVBSRUZJWH0vdXNyL2xpYmV4ZWMvY3Vwc1wiOiIgY3Vw
cy1jb25maWcgfHwgZGllDQoNCnNvIGl0IGFwcGVhcnMgdG8gYmUgYSBHZW50b28gYWRkaXRpb24u
DQpXb3VsZCBwZXJoYXBzDQogIHBrZy1jb25maWcgY3VwcyAtLXZhcmlhYmxlPWN1cHNfc2VydmVy
YmluDQpvcg0KICBjdXBzLWNvbmZpZyAtLXNlcnZlcmJpbg0KYmUgYWNjZXB0YWJsZT8gSWYgbm8g
d2UgY2FuIGp1c3QgZHJvcCB0aGlzIGFuZCBHZW50b28gd2lsbCBjb250aW51ZSB0byBwYXRjaCBi
bHVleiBmb3IgY3Vwcw0KDQogICAgSm9ja2UNCj4NCj4gLUVtaWwNCj4NCj4gWzFdIGh0dHBzOi8v
cGFja2FnZXMuZGViaWFuLm9yZy9ib29rd29ybS9hbWQ2NC9jdXBzLWRhZW1vbi9maWxlbGlzdA0K
PiBbMl0gaHR0cHM6Ly9naXRodWIuY29tL09wZW5QcmludGluZy9jdXBzL2Jsb2IvbWFzdGVyL2Jh
Y2tlbmQvTWFrZWZpbGUNCj4gWzNdIGh0dHBzOi8vZ2l0aHViLmNvbS9PcGVuUHJpbnRpbmcvY3Vw
cy9ibG9iLzUzNWZkYzJiMzhmYzNmMzgxOTIzMzM0NDU1NmM0NWY0ZThkMjYyMGQvY29uZmlnLXNj
cmlwdHMvY3Vwcy1kaXJlY3Rvcmllcy5tNCNMMjQ2DQoNCg==
