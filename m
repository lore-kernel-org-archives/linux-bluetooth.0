Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20EE175A91;
	Sun,  7 Jun 2026 00:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780793795; cv=fail; b=F2uO6Z0jiaNiKBEROtcG9c3CTNHlE+yLulaT6ZYqNgv5CHa/ixeTU9NnkQeYbJ99C0tmq+DcXXumH+VhSt4LEfqyqCL6hmkRJ+3U407j4vB5ltiwIWdKobjXm/7RbRverHLMBuHJJkVQNsjK4vL95tN5k5/kT7dD9M35c/Mp/nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780793795; c=relaxed/simple;
	bh=KUgfgLj7OUTPBA8hcI2M9yob1MGdOuunqFjO5AHMJqU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hBBgN+ivZtynJWp1PVLjVdwia3nyXUTlEzr2O1BSAnFvWi9zgjRYPcbJvVtAWhVE4ZCQ162orikBzUBPA2wMpAcmxl3dPSSPHMrpOjZWCxIyH2jop4KSunPdeMOxAotX6b4XndrEcz5F9ncX3F6LeRrx8n9GJw6t0CfebD63hC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=PSU.EDU; spf=pass smtp.mailfrom=PSU.EDU; dkim=pass (2048-bit key) header.d=psu.edu header.i=@psu.edu header.b=oFtHXcGW; arc=fail smtp.client-ip=52.101.46.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=PSU.EDU
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=PSU.EDU
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=psu.edu header.i=@psu.edu header.b="oFtHXcGW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHs6nKekBl8FN5X9v/PvQUdKIokWZ6s+feHzlPphgPTFpz3zn7KfBjmSFN81kcaihrDJeJYKI7l8SOFb40Ikbl0Fz5WrCHBHQJUjgak6gdol/ad+/T+UQcv4eDDxN8ytplroxuqcyI8+8tUzgSeBCejTsLQ95faCH1fD0ZbdGnt6KX8/eQk/una9LrTkgGmoyU9oQIjX0vXSwqazeIqADyNj19ZNWIfUzmbW58Be/RXzI4+gE2i3rAGSTn4+WkdEqliFj8NHv0qcq36ZReXuILdWb4sT7ivp3jYxGJCUzj+Sv+6a1wVJb6yKAPT7uNSQHihGNqKtRCi6gSY6EYhL9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUgfgLj7OUTPBA8hcI2M9yob1MGdOuunqFjO5AHMJqU=;
 b=v5lmuAjkow4yhgQg+7pJfpkIRQks82iEopZ4Wd0oDRLff9scTMZJQb6/VBtk+x8/rFuZldH+x0bjcwZmkv9QESuDaYHR4QCvvM9Efnjy5Lv+jc36+HsUGIPi4W8DFk9M86YOfRlbe3RRyTZypLHUa20SBRnBDp5f/JXHrxvBBSoTsVokpxMWFx0r2rlBrV6t9j6QE0vje0zQIYkwDg/SKUPSU6L3l0WUZsmVKSLGJV+L4eTPnamwYXimDxmnltA22GQ2egv9zfFol4yjF1oO2ZTpBVROdwaae5NWc5spfZ4DsxVZ4pNdQdb8JGwl2BaoQUKP6A0TTdLQfjraF1xH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=psu.edu; dmarc=pass action=none header.from=psu.edu; dkim=pass
 header.d=psu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=psu.edu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUgfgLj7OUTPBA8hcI2M9yob1MGdOuunqFjO5AHMJqU=;
 b=oFtHXcGWMjxmTOgm1G+31qiqaxxKTW7BQam2lF5VlBbirK8KpVLg5CdDWdHPkj1SuD1adw7+xlEj+iAsaJobri7/p8AQJrT8Au270xM5woaP1BLgGbM0tmgeo8XwqjPuWDk43PiCv3hTnUozCH3a16Tqt/zP/eP0rvnaihKbCNvQCWTLPxF3ggQGF9ZEcZwr2yZSWdqhrNlQa0EuqgJH/5AJA5yeSK4Ls94FmHYtyVfos9ce1mRBUUSjmq625VJfEaMT+c3icZKkxk5LGrybVEUak8OD5Jp4J7P3PQMEl8KeeSYArJDNow1vYu4KObdYP0UZxcd6Pp1PyB4CPO0C8Q==
Received: from SA0PR02MB7276.namprd02.prod.outlook.com (2603:10b6:806:e6::17)
 by MWHPR02MB10499.namprd02.prod.outlook.com (2603:10b6:303:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Sun, 7 Jun 2026
 00:56:29 +0000
Received: from SA0PR02MB7276.namprd02.prod.outlook.com
 ([fe80::8d9:7aae:131a:e46a]) by SA0PR02MB7276.namprd02.prod.outlook.com
 ([fe80::8d9:7aae:131a:e46a%5]) with mapi id 15.21.0071.010; Sun, 7 Jun 2026
 00:56:29 +0000
From: "Bai, Shuangpeng" <SJB7183@PSU.EDU>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [BUG] KASAN: slab-use-after-free in rfcomm_security_cfm
Thread-Topic: [BUG] KASAN: slab-use-after-free in rfcomm_security_cfm
Thread-Index: AQHc9hh5UX0gzyOhOUO7H1r8Q6Vg+Q==
Date: Sun, 7 Jun 2026 00:56:29 +0000
Message-ID: <CFE05E36-B1F4-42B7-A42E-370F7FB76756@psu.edu>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=PSU.EDU;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR02MB7276:EE_|MWHPR02MB10499:EE_
x-ms-office365-filtering-correlation-id: 64a09652-35e3-4c82-458f-08dec42f9c3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|786006|10070799003|38070700021|6133799003|18002099003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 nnx/6G0TNvJF0EqAaE7tqELoew9fLk1MyKj02RQkHrVj0HeBGequvmNqfQH116qzG6QbiiHk0tFnlEARVyQTnsHJGAtMIs6QMlSVkooOrEDghccoPXMUDW4bzZvYfAxQCE2GbbABLe9DbBkLCzz1/i6AJV+J62l2Bmiv7fL/GVEhOfn3yNJo4xdmcprggzD39YFPmmoYyd3KMSoDDb67Xwz6mz/4rwUFFp06zRCfqjrTWUF0yH1Ft+KHIVSWymj1THYLuzMID1NGFxyvJY7/Ozg3UdE81A0yjq+xI8VvA7lkW1G6JZR3zNsNdmXbslK2ijQ9ENF/nzz8YXbA8mgftU8PIsTxYtW7VWREOrwmrEKIn6ckmfw6An2581SDd6vzX2WX347zPlIKzy2kDGsSwPw7pxEzHaaIdI6mqeQ2H9cqvlsvVT2knq/T+bk5h3gPvm8ocI6SWUvAAHrtkICtg/jB61BmTKjOaAEYB+XMxF2zIljzlk5v8LPVuTz7gP/PQLJKAvPb5tfbtecTp35n1euoCXF605IGbgXYJbGusHw1Pfz/d8RUCc1NKZFNrbXJbRDaCeg3Q6bK943AiJR/9VXPlebhfMFTdzD+Q1WEH1iOrWQAPA5oAJYo5kctjFukBmyN61Jwi4k0NKuHrJnNcGp+HD4gdvxUCIhq7L8+H7wr4dRirjpQi8vlZwxLcdC4v0fEsIFgII/8JwsSm1d/stmRyE/gGV3SeCopsHz7Y/LlkmY4AMdlb5rgds1k1Or/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR02MB7276.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(786006)(10070799003)(38070700021)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amFYRXBSa2Izci8wZjdYUVBLS1BTT3RROWpPYWpDQ0w1eC9MREJ4SWZKT3lY?=
 =?utf-8?B?anlLbkkwaG00VEI3YjhNcFBuUVpFMzNVNkVCMEhicTg1dnNRakNaaXd0anhx?=
 =?utf-8?B?bzNjazZHZGpxRnR2MHdLZnZtVG1mV085V1lKQ3VCUEFLOEUvR0JtS2xPdHFr?=
 =?utf-8?B?bk94aUt6NnFScjdrZzhycUVtZEdDelpDQkNzNnhjRU5UOEFWNURvcHIzSkNa?=
 =?utf-8?B?S2puV3BoaVhvMm1FVXNKcnRuNE5XL2szM0pKZ3d3djNrUjUzNDl1bW95OUY1?=
 =?utf-8?B?SHNkY2F1USt1RlRQVWJqOXI0djRyZERhNUIvWGR5R09WQysvYjJPZnZKc0d0?=
 =?utf-8?B?QkZqTmxqVy92dUlENVlvaklpUHlrN2RlZFJvZTAwUUlEMzZSUmhJTjhRZDZO?=
 =?utf-8?B?bkUzMnE0Q0lqQXluUytPTmdidWZTTHBKNXBJa3pxUVpyLys3TUw4SU1tS2hj?=
 =?utf-8?B?YUpZY20rSThHSTl1TlBOVm1VNitoWHkxbTVYYkRGT00wWjhpQlBMc2hjTEV2?=
 =?utf-8?B?TTBRSUpEWlh3UW4xbEs3a29lOVAvSjlscTZ2bU9mOCtrakZEYlI5ZXFzMDVP?=
 =?utf-8?B?NjlQL09MZzdGNVIvL2VkQUFYZlB4aDJZdFRadHBRNCtqZSsvTDZBTXpuUnhL?=
 =?utf-8?B?QmJpVHJ2ZUNhbGdYTVZjdEd5RS9wd1V3c2QydGV4Mm9YZEhrL3YyMHErbTFv?=
 =?utf-8?B?QVJTVDJ1WEpqYUV6eXd6WStYMDZ3MFowMXk5bGI0WTVjb0UyYmpBdmp4STMz?=
 =?utf-8?B?QjlrSFUyUW9GbXBvNCtFYXE5Z2FaZUkzSHlKUElYNE9GUGk5b1M1SEVTUU9u?=
 =?utf-8?B?ek9kNVNvczl2dkFpakFrWm1GTHlERTRlRXNYQldYYk5vNGx1QU5FdStxa20r?=
 =?utf-8?B?cGxiaFAwTUc5c2dkRFZwK01Jc3Qvenh3d1Vqak9DRlcrNWZYaDZpRFpOeGg4?=
 =?utf-8?B?cjh3V09NazlGWC9SQjg2Z216NkplWE9IVXFIT3NUV2tUbzhFclQzTzRGSm5a?=
 =?utf-8?B?d0RjQXJJN1M0UHJGazVGL0RneU9ORVFaYjJZb1NNNTE4cVhsNS9DblpKbHV4?=
 =?utf-8?B?QndFUmtmNWRkQVdLU2VoSmZRd3FhWElOeVh5enkvd1l4Z1pPRU0wSjRsYk1F?=
 =?utf-8?B?R1hTYjNmc0paNmZiQVVzTHBMZ1hoZE1nTXpQYXd6ZHlPalpCdmtYRnA2T0kx?=
 =?utf-8?B?QVd2Qng0RFVkbHlIdmNrSlo5b3RLcmZqbk10Q3JXNlVsUFZhM05aZVZ3aGJr?=
 =?utf-8?B?bVdqMk5QTFhuV1hWZDBjSEI0Tkd4NjdZdjR6bHNkcTZEaFVQSksrbk5qWjdj?=
 =?utf-8?B?cnZvWVdxQnR3Q1UzWkE5V2FsYlVhcnVHdkFVSFNIWVhzSmdxWXZiUW01aGRa?=
 =?utf-8?B?aEFUS3BMOEFmSndvQ2xCSFlxcnM4VmhwZEZ4bnRDWXFmR3ZhM1h3b0h4ZHI1?=
 =?utf-8?B?aWdRUWdBdHhTWDJHc3F1VWhUUG5lL252SCswT00xOXMwSE1HOERyR09ZZkhG?=
 =?utf-8?B?MzRqL1BIMU1XVnVaa1JHT0VSZkUwOU5QVGoxL3VKbGNkVTU3dFdwcXhObUI1?=
 =?utf-8?B?M05zb1RTeTBCNmRCY2dkSWV5WmdLS0VjWktkYWM3NE84QS9idXFidXg5NlJH?=
 =?utf-8?B?OU1FTS93R1RGMjEwY1RCK0VjQUl0NFhTYSszQjNaRUtyalM1WU1TQlIrVTBZ?=
 =?utf-8?B?YTZsK1Rta25IQUlCUmxVdE5ZWFc1ME9FL3NQUGoxanpXMEMvb0xpekN2NDBo?=
 =?utf-8?B?YmdIeVpjZVZVaHV6MUtDOFBwMkxnTEh2K1NFTnppWjdjT1I0UlFDRjJ1Tmpl?=
 =?utf-8?B?T0RqWWdDNzZKTkw1cEkvZFJOTGxBaCtsNTd6SkRudEY0YkwwRFI3Nk1wQWNw?=
 =?utf-8?B?Mk1xeS9uV3U0bU1JT2hVWkxzYlpmMGpBSjArLzJSYlEwNld5QndDVFplR3hl?=
 =?utf-8?B?UDBWR21QSXFnYm1QSUc5UllYMGp1dmlqSFphb0czRGZqNEVyOHRUaE1yNktF?=
 =?utf-8?B?TzQxL05Da2t5RkpHbThvejRnV0NQZUVYSXNxa3dBakpaR29JWXJIN0YxaW12?=
 =?utf-8?B?UWFSSmpnOGFVNFplL3A5RnZoNlkyZzlPUUxJaC9hRnN6SXprZjFJc1JSTm1z?=
 =?utf-8?B?U2FMM2VyVWhUa0pxb2NyMWNJWmdpZGtBdzR0R0czVkp3TnRRQUdxSGl2T0FQ?=
 =?utf-8?B?OUY1czFSdVY5OXdMWTRHTTZtWkJtNFU0SWYzTVFpclpKN1NLTWM2SG54aG9G?=
 =?utf-8?B?eUo2Y0NVNEtibVM2bFVhRmh5RDUrUWlhRXJLajNxb3prZEpyVEpPb2Fqa0xo?=
 =?utf-8?B?QkhJVk9jbkc4cHJ1TWVoSWpQSUZpSDBhMk14TkpUVTNleFpXd3dxOWhWeVlV?=
 =?utf-8?Q?mjIzZ0f22025BjGHhqzNnF0omrkERDJPhphVoHZkDCvIG?=
x-ms-exchange-antispam-messagedata-1: Fyv79AfaS7RSUg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D42D906F7073344B65AFB170B4F09AE@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: psu.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR02MB7276.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64a09652-35e3-4c82-458f-08dec42f9c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2026 00:56:29.6713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7cf48d45-3ddb-4389-a9c1-c115526eb52e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jyV7kzZ+KMbEN3Nm8Ho66sTvJcqVGzsJ+ThAzWKBo+pxS3ZF/hQYMXVdIcI8kxPP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10499

SGkgS2VybmVsIE1haW50YWluZXJzLA0KDQpJIGhpdCB0aGUgZm9sbG93aW5nIEtBU0FOIHJlcG9y
dCB3aGlsZSB0ZXN0aW5nIGN1cnJlbnQgdXBzdHJlYW0ga2VybmVsOg0KDQpLQVNBTjogc2xhYi11
c2UtYWZ0ZXItZnJlZSBpbiByZmNvbW1fc2VjdXJpdHlfY2ZtDQoNCm9uIGNvbW1pdDogZThjMmY5
ZmRhZGVlN2NiYzc1MTM0ZGM0NjNjMWUwZDg1NmQ2ZTVjNyAoTWF5IDI1IDIwMjYpDQoNClRvIGhl
bHAgdHJpZ2dlciB0aGUgYnVnIG1vcmUgcmVsaWFibHksIHdlIGFwcGxpZWQgYSBtaW5pbWFsIGRp
YWdub3N0aWMgcGF0Y2gNCnRoYXQgb25seSBhZGRzIGRlbGF5cyBhbmQgcHJpbnQgc3RhdGVtZW50
cy4NCg0KVGhlIHJlcHJvZHVjZXIgYW5kIC5jb25maWcgZmlsZXMgYXJlIGhlcmUuDQpodHRwczov
L2dpc3QuZ2l0aHViLmNvbS9zaHVhbmdwZW5nYmFpL2FiM2JkMjU1ZjdmNzNhNmIyYmNmNjRkZTVj
ODM0YzEwDQoNCknigJltIGhhcHB5IHRvIHRlc3QgZGVidWcgcGF0Y2hlcyBvciBwcm92aWRlIGFk
ZGl0aW9uYWwgaW5mb3JtYXRpb24uDQoNClJlcG9ydGVkLWJ5OiBTaHVhbmdwZW5nIEJhaSA8c2h1
YW5ncGVuZy5rZXJuZWxAZ21haWwuY29tPg0KDQpbICAxMDIuNTg0NDYxXVsgVDQ0NDhdID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PQ0KWyAgMTAyLjU4NTM5Ml1bIFQ0NDQ4XSBCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1m
cmVlIGluIHJmY29tbV9zZWN1cml0eV9jZm0gKC4vaW5jbHVkZS9saW51eC9pbnN0cnVtZW50ZWQu
aDoxMTIgLi9pbmNsdWRlL2FzbS1nZW5lcmljL2JpdG9wcy9pbnN0cnVtZW50ZWQtYXRvbWljLmg6
ODUgbmV0L2JsdWV0b290aC9yZmNvbW0vY29yZS5jOjIxNjEpDQpbICAxMDIuNTg2MjkzXVsgVDQ0
NDhdIFdyaXRlIG9mIHNpemUgOCBhdCBhZGRyIGZmZmY4ODgxMWI2YjQ2NzggYnkgdGFzayBrd29y
a2VyL3UxMToxLzQ0NDgNClsgIDEwMi41ODcxNzhdWyBUNDQ0OF0NClsgIDEwMi41ODc0ODhdWyBU
NDQ0OF0gSGFyZHdhcmUgbmFtZTogUUVNVSBVYnVudHUgMjQuMDQgUEMgdjIgKGk0NDBGWCArIFBJ
SVgsIGFyY2hfY2FwcyBmaXgsIDE5OTYpLCBCSU9TIDEuMTYuMy1kZWJpYW4tMS4xNi4zLTIgMDQv
MDEvMjAxNA0KWyAgMTAyLjU4NzQ5M11bIFQ0NDQ4XSBXb3JrcXVldWU6IGhjaTAgaGNpX3J4X3dv
cmsNClsgIDEwMi41ODc1MjddWyBUNDQ0OF0gQ2FsbCBUcmFjZToNClsgIDEwMi41ODc1MzZdWyBU
NDQ0OF0gIDxUQVNLPg0KWyAgMTAyLjU4NzU0Ml1bIFQ0NDQ4XSAgZHVtcF9zdGFja19sdmwgKGxp
Yi9kdW1wX3N0YWNrLmM6OTQgbGliL2R1bXBfc3RhY2suYzoxMjApDQpbICAxMDIuNTg3NTU5XVsg
VDQ0NDhdICBwcmludF9yZXBvcnQgKG1tL2thc2FuL3JlcG9ydC5jOjM3OCBtbS9rYXNhbi9yZXBv
cnQuYzo0ODIpDQpbICAxMDIuNTg3NTg5XVsgVDQ0NDhdICBrYXNhbl9yZXBvcnQgKG1tL2thc2Fu
L3JlcG9ydC5jOjU5NSkNClsgIDEwMi41ODc1OTldWyBUNDQ0OF0gIGthc2FuX2NoZWNrX3Jhbmdl
IChtbS9rYXNhbi9nZW5lcmljLmM6PyBtbS9rYXNhbi9nZW5lcmljLmM6MjAwKQ0KWyAgMTAyLjU4
NzYwNF1bIFQ0NDQ4XSAgcmZjb21tX3NlY3VyaXR5X2NmbSAoLi9pbmNsdWRlL2xpbnV4L2luc3Ry
dW1lbnRlZC5oOjExMiAuL2luY2x1ZGUvYXNtLWdlbmVyaWMvYml0b3BzL2luc3RydW1lbnRlZC1h
dG9taWMuaDo4NSBuZXQvYmx1ZXRvb3RoL3JmY29tbS9jb3JlLmM6MjE2MSkNClsgIDEwMi41ODc2
NjBdWyBUNDQ0OF0gIGhjaV9lbmNyeXB0X2NmbSAoLi9pbmNsdWRlL25ldC9ibHVldG9vdGgvaGNp
X2NvcmUuaDoyMjE1KQ0KWyAgMTAyLjU4NzY3MV1bIFQ0NDQ4XSAgaGNpX2VuY3J5cHRfY2hhbmdl
X2V2dCAobmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYzozNjg5KQ0KWyAgMTAyLjU4NzY3OV1bIFQ0
NDQ4XSAgaGNpX2V2ZW50X3BhY2tldCAobmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYzo3Nzk2IG5l
dC9ibHVldG9vdGgvaGNpX2V2ZW50LmM6Nzg0NykNClsgIDEwMi41ODc3MTZdWyBUNDQ0OF0gIGhj
aV9yeF93b3JrIChuZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmM6NDA3NykNClsgIDEwMi41ODc3MjFd
WyBUNDQ0OF0gIHByb2Nlc3Nfc2NoZWR1bGVkX3dvcmtzIChrZXJuZWwvd29ya3F1ZXVlLmM6MzMx
NCBrZXJuZWwvd29ya3F1ZXVlLmM6MzM5NykNClsgIDEwMi41ODc3MzRdWyBUNDQ0OF0gIHdvcmtl
cl90aHJlYWQgKGtlcm5lbC93b3JrcXVldWUuYzozNDc4KQ0KWyAgMTAyLjU4Nzc0NV1bIFQ0NDQ4
XSAga3RocmVhZCAoa2VybmVsL2t0aHJlYWQuYzo0MzYpDQpbICAxMDIuNTg3NzY3XVsgVDQ0NDhd
ICByZXRfZnJvbV9mb3JrIChhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jOjE1OCkNClsgIDEwMi41
ODc3ODldWyBUNDQ0OF0gIHJldF9mcm9tX2ZvcmtfYXNtIChhcmNoL3g4Ni9lbnRyeS9lbnRyeV82
NC5TOjI0NSkNClsgIDEwMi41ODc3OTVdWyBUNDQ0OF0gIDwvVEFTSz4NClsgIDEwMi41ODc3OTdd
WyBUNDQ0OF0NClsgIDEwMi42MTA3NTFdWyBUNDQ0OF0gRnJlZWQgYnkgdGFzayAyNjc4IG9uIGNw
dSAxIGF0IDEwMi41MjQ2NzhzOg0KWyAgMTAyLjYxMTM4OV1bIFQ0NDQ4XSAga2FzYW5fc2F2ZV90
cmFjayAobW0va2FzYW4vY29tbW9uLmM6NTcgbW0va2FzYW4vY29tbW9uLmM6NzgpDQpbICAxMDIu
NjExOTA4XVsgVDQ0NDhdICBrYXNhbl9zYXZlX2ZyZWVfaW5mbyAobW0va2FzYW4vZ2VuZXJpYy5j
OjU4NCkNClsgIDEwMi42MTI0NThdWyBUNDQ0OF0gIF9fa2FzYW5fc2xhYl9mcmVlIChtbS9rYXNh
bi9jb21tb24uYzoyNTMgbW0va2FzYW4vY29tbW9uLmM6Mjg1KQ0KWyAgMTAyLjYxMjk2OF1bIFQ0
NDQ4XSAga2ZyZWUgKC4vaW5jbHVkZS9saW51eC9rYXNhbi5oOjIzNSBtbS9zbHViLmM6MjY4OSBt
bS9zbHViLmM6NjI1MSBtbS9zbHViLmM6NjU2NikNClsgIDEwMi42MTM0MDNdWyBUNDQ0OF0gIF9f
cmZjb21tX2RsY19jbG9zZSAobmV0L2JsdWV0b290aC9yZmNvbW0vY29yZS5jOjMyOSAuL2luY2x1
ZGUvbmV0L2JsdWV0b290aC9yZmNvbW0uaDoyNTcgbmV0L2JsdWV0b290aC9yZmNvbW0vY29yZS5j
OjM1MCBuZXQvYmx1ZXRvb3RoL3JmY29tbS9jb3JlLmM6NDk4KQ0KWyAgMTAyLjYxMzkxOV1bIFQ0
NDQ4XSAgcmZjb21tX3J1biAobmV0L2JsdWV0b290aC9yZmNvbW0vY29yZS5jOj8gbmV0L2JsdWV0
b290aC9yZmNvbW0vY29yZS5jOjIwNDggbmV0L2JsdWV0b290aC9yZmNvbW0vY29yZS5jOjIxMzEp
DQpbICAxMDIuNjE0Mzk1XVsgVDQ0NDhdICBrdGhyZWFkIChrZXJuZWwva3RocmVhZC5jOjQzNikN
ClsgIDEwMi42MTQ0MDJdWyBUNDQ0OF0gIHJldF9mcm9tX2ZvcmsgKGFyY2gveDg2L2tlcm5lbC9w
cm9jZXNzLmM6MTU4KQ0KWyAgMTAyLjYxNDQwN11bIFQ0NDQ4XSAgcmV0X2Zyb21fZm9ya19hc20g
KGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6MjQ1KQ0KWyAgMTAyLjYxNDQxMl1bIFQ0NDQ4XQ0K
WyAgMTAyLjYxNDQxNF1bIFQ0NDQ4XSBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBv
YmplY3QgYXQgZmZmZjg4ODExYjZiNDYwMA0KWyAgMTAyLjYxNDQxNF1bIFQ0NDQ4XSAgd2hpY2gg
YmVsb25ncyB0byB0aGUgY2FjaGUga21hbGxvYy0yNTYgb2Ygc2l6ZSAyNTYNClsgIDEwMi42MTc1
MTVdWyBUNDQ0OF0gVGhlIGJ1Z2d5IGFkZHJlc3MgaXMgbG9jYXRlZCAxMjAgYnl0ZXMgaW5zaWRl
IG9mDQpbICAxMDIuNjE3NTE1XVsgVDQ0NDhdICBmcmVlZCAyNTYtYnl0ZSByZWdpb24gW2ZmZmY4
ODgxMWI2YjQ2MDAsIGZmZmY4ODgxMWI2YjQ3MDApDQoNCg0KQmVzdCwNClNodWFuZ3BlbmcNCg0K
