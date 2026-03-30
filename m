Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023104.outbound.protection.outlook.com [52.101.83.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6D0363C6F;
	Mon, 30 Mar 2026 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884806; cv=fail; b=L6NeIW7LerwyDjvcuuI+/I18MgDm+k//cjA1UBq5O+AeoRXOuuURIkE3uPRFcsuGwDbNhqTXJvuf+QlplgrV/ui4sOTAqadJ/+0kzhXIDdr8yc2ecgAWgeAMLnvXydNGU+6SpYLOjRXp1T/omBiFicnkmgim/AoJie4kK0lRnpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884806; c=relaxed/simple;
	bh=3JFN/3ODLn0NKKPhXGwPswT3v3eDPzzH53wsu+aFGNA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QV6nGSXk8cR1Bx2hHHp8tZ1TOJhZQmo8zD9Xu3rA1xD1/R532/wn10vrDS6yRhwgDHrOftmhvciB0dIfOv+5/lT0Kqm7ae7t2J0KVuz+gApvrddmBUqtcWiJR2gGorP/lwK420IUuiDkXqpELLkH5iOA7obnGGoCkge7TM0XcW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=cG6BihQG; arc=fail smtp.client-ip=52.101.83.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="cG6BihQG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXYwr7sAPplKZ+uHxPr9Vd99O0eanvsicUHy3Ph9Ab/pzwRs16wTl3wSbL5aSggEYgrWK1wKXloq1JKQaTw8FCDF1RAuCoqqQabo5ilXpZihzwIxCSfBk2YhFCgmfHBLohHfop5bm74s5wrnf/xU6Vletygn5llIjwPrNAuoa189yzT/aMvaVhk4kWwOANp14fHR4pnEH6bIs29Zdynt1/Yj4Dery3INCeD6gUz6A/RNtp1DAFv7Z97Cud4JIWMjshH24cLFrE1Jea9hX2hZ88UX9CKdDKQKFnXTAA5syLR2/uJ8sXjtnWqNQbKcX2XzZXXZa1SfwFj8Vk6aZKQD2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JFN/3ODLn0NKKPhXGwPswT3v3eDPzzH53wsu+aFGNA=;
 b=UitqU73Hz5hzjuQ+VzC/oFwRMCtqp6H5f+ZdGxHw/pVtmqtViOcyE4tgcImGYCGTAw47GvIthngGRd6+dkPZ14u59c+saF/Azlk+N07tMM2NZN5iz+kuz7UsHgPDj3JJpaGipmxXHpa63vn1AzovD7YQt80k3hTpE8u9UjVy4lbgRIA21J4wi1PPKuQGWVg7EumV7CTMRT9pf3not5Pr4UR5ChLU5QOEurJx52/RVBPCbKCphpQD2KpWufO02YNPFwt4+spamhuXzPTUFjiTrM3mFF9Myx++fZKFKOox0Pbj8+30vcIh74m7MmalV9aiUcErjAnkAHQse2VBAMfxXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JFN/3ODLn0NKKPhXGwPswT3v3eDPzzH53wsu+aFGNA=;
 b=cG6BihQGRGf6JBJHUUJVAbBNDugR0Gs/jLqF5TufhKVc+U4HpwOgUr7GRmy6qWiLxZ93zSPQWO2KL2v4IIVKuIBwUh19s0AxB7kvfYilf9JWaWgtf0I/YYfn1pnvGx+CA9eGU4wQ3uGmrxShIKHQ2hsMaakn8pCfdZHEwPB8QaEEVYOgmjcTIS0VKsqMJ5DGS+Dd3TMmro6Di0IprIKZe2mH+O0utE5NSVOMHB7sqNc+hC3GacEKztN5wxBpKlc+dolz6XKnST2aJnTVrYmtOQHQvXZUo5wfyvJ+MDeuctNX+kwP7AW8nSfoFtlbacdwoaepQ1iYOa5VKZURHQ9jcA==
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5)
 by GV1PR04MB10584.eurprd04.prod.outlook.com (2603:10a6:150:210::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:33:18 +0000
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419]) by DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:33:18 +0000
From: Oleh Konko <security@1seal.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] Bluetooth: SMP: honor local MITM requirements for
 legacy pairing
Thread-Topic: [PATCH v3 0/2] Bluetooth: SMP: honor local MITM requirements for
 legacy pairing
Thread-Index: AQHcwFqIpGtlNAbybkCfnHzodOmzbA==
Date: Mon, 30 Mar 2026 15:33:18 +0000
Message-ID: <bt-smp-v3-b13a5d5f53ed4efaba74be7539453366@1seal.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7673:EE_|GV1PR04MB10584:EE_
x-ms-office365-filtering-correlation-id: a21bfd53-92c2-4927-2657-08de8e71ab18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|18002099003|7055299006;
x-microsoft-antispam-message-info:
 DLovoL8BZt5il2ocYGSnfOxiavwY+NVVHW6jAPGjVtlvGHUuXucRy72c9Sr4ukmFWmKwTYWpD+xIVlxrnJZ8rmgA7K75aGMlUGfNVx4G7pH57rMawrnIWtFc+CKkYPvU3onU01DApEAHssVr9AKBkRpgaIpmpb1YA8MPsysrHIt2sESNFUNPAX7AEN1M1IF2sSwSR8c9xyF5G3tfIvEv/WrlUR1dLh6v5bxP981l9XlbbLmxy4v94WWnNJYOUhR6DN33QFQFbkGL6j2ezESpkbEg3OEDL4HBZWFo1XNBjk/mTwC8jwLFfk9a0cQ4IV0DiYfG1K8niQ7+T4xdeUNuuQYuAet0U6+8sjw7+w9IgodA4z7hr/Lw5jRQPMb+2HJQZsDJXzeX11Se0xPrrrcTGOGAAG8LzweDUJLsJ/y2o9extZKHZBVtI5T/bYGNNOMV5O0z0qmAnyZiK/o5ixfYzxi/2GA9+C6gOW0LoqyrXePQb0cyLGeX9S7+JQDxtLoqxqQBi/vPCiVEQbsUWGhzsMWJ77Mt+Id+rZc9NrYEvI0imBrc9BTW7rsRaRBCaRv9wZYmVrkKIKHDnf/1l7b/WG/bRU9UT8xKzJosINi8P3w/x464RmI9yvzldeQp0ToJ2gHppfx75GgS/0Nqz79XiXvL+dBBwsI3A33qCevG0aOdqQNc5lrMAITtnSnzMckpVNBwW30X4xJXzgDVi6B9B18kf92+bKPON13cbTqd/x65r11pR4/1yaelRHtE67XYm2T5zdOOOTt6Q1bez+D9ygOWFDBlU8lx6gZSs1TdF8VBOZGKimfvmEQsGTTV9AEO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(18002099003)(7055299006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MXdqUy9kZnQybHlsVFRma2c5OGlZMHJMNGJlUE9wRllJeVJlS3FKN3VndXlR?=
 =?utf-8?B?MVVGTTdBRHI3d0dBY0ZRc3NMTnJWUnY4Y0Z4K2lTWkNWeHg3bytpTTZZZmty?=
 =?utf-8?B?VHRTYTR4VWxiOTB5eXlCZU1CdGc2V0o1a05YNHBRUHBTTWlIcFlrZ2N5VEpG?=
 =?utf-8?B?eU5ueUIvOUdrdGVTbzhyWnV3VlFOQlJJQUJsaDhNOTZsVHlxQ2tCdXJuajNB?=
 =?utf-8?B?cEFzNnQyVGFGTmZvMkUrZjZzYzFsQk1wUUVKYktHS2Z3K3NrU3hCWmNLMjM2?=
 =?utf-8?B?ZE14eEZzQXk2UzBMSkF4S1hnRXQ4dll0UWJ3KzR1eWJwaGRwR1BSak1mS3N0?=
 =?utf-8?B?d1k4TEkyT2ZVZWc1K2JyZEZtUGZBM2xmY1BWMkU3cW1CY2NUb3V2dnJ0aDJF?=
 =?utf-8?B?bk1GSm8wY1E4RTZwSWxYRXk2Qzg1OEtsNkNMUmpTTng1ek9qTHZtK0t2ekx3?=
 =?utf-8?B?eDFYR24xYTREcTB5ZzNMS1YvdUFZeUlkeCtWQlNja0V1UGNOU3hPNFBFK2ZV?=
 =?utf-8?B?M1BuQ2k5d3JZdGdWVzJxbUpUMVhOZ0Y2QmlJV1dTL0svOHVSWnN5djhpNkpW?=
 =?utf-8?B?aS9mTEk5elZSRC90TWU3R01odnJCaDVIemFsUFFYYWVONkVIQVQreGZxdXRM?=
 =?utf-8?B?Szd1eTY4Tm1ucXJZUGVMcXU1MWJPM1QyM1JuWTlyQnUxUWFiZUdZaEhva0F5?=
 =?utf-8?B?RWZ1QUpwSXFZNFdmZnB1NmtXaU9ydDNaTnZmMFhHc1BqMEw4SmF4TzlVZDhu?=
 =?utf-8?B?M2ZMUFlpNEMwSktYVzJNeUFyVk1mODMwNDk3K0o5YkdPTnRuWXoreHltTzVM?=
 =?utf-8?B?VDVWanlVYnN0VDFBejJlZU5SQzk0a1BZQWRnNnd6cEt0Ulo5VFYxdFdldmEz?=
 =?utf-8?B?b1pZV1hoemUvSEdLNGRNU2RVK255cGp1cU1HK3Rrd243eU42Q0hud3VKZHFI?=
 =?utf-8?B?U2xRRzZvbTNwWHhPd1BBMHRkc1FJeEdkcEhYZFRvak1OWmJrQWdmNmUwVVBI?=
 =?utf-8?B?QU5KaXdER21jbTMyTWcwd2dhSlVSc0FYVS8wcWdpNWJnR1pUOGV5bTlhYlNL?=
 =?utf-8?B?RFIreFJySS8vMktDemYzWjNwS0RoZnFDZHBQS0VUeDZUUW85U2VBNXBNT0Ji?=
 =?utf-8?B?Y0I3Nzg4UUZnZFVDcmtDd296NFB6b2dSazIvVTYvaExzeEhPRWJsTVlFVWpH?=
 =?utf-8?B?OFkxYmNrU09ONGxEK3FUcEg4Ym95ejJHaXZYRGtvbTdINlRPRFdGN2ZNN0Jw?=
 =?utf-8?B?dWY1dmpySjZkZXkzOVh6ekFYRmhJdWJzUHRkd3V4N21nbTJZM3ppbkwxaDZN?=
 =?utf-8?B?bS9NS0pBREd1UFpvbmFBSHBXVVR0UVJVb2hIenFtTXpqN1hPaW9xNFN5bVNy?=
 =?utf-8?B?ZkNIUEhwYXpLNUQ4VGRsakh3WjF6eGFDZlBLbWgzSDAxREdyYndZTXZRMWZ4?=
 =?utf-8?B?bXJKTTdnNVN3NFpvMllpRDdZeGxubjFWdGoyQklwbjFyU2kwcEdXWE5hdUsy?=
 =?utf-8?B?UGxENkZodTA5TmM2My9ITm9EamxQaXh4UmQ4NjQ2ME82RWU0Q1VYRnpXMHVj?=
 =?utf-8?B?WjZFZmJkT2JVQ0l5U0ROb1BYMk00K3k0N2w3Z0VENmIxV1VPOHJUZndHejRh?=
 =?utf-8?B?ejFtN3o5bCtyZmZZL3RuTU5aT3VraFFhY25FK25HdURxTllYSW5PdUl2ekxa?=
 =?utf-8?B?a0VGV3M2T0JKM0NUK1VuaTZzUTQwOVpMTUVER3JXb1BMMjUrZXFURllteUhu?=
 =?utf-8?B?U1ZDOTlTSDBBbjM0Vk1sallMeG8waFU5S1BIOEx2cVBrbjN3d3oyRGZBUUpu?=
 =?utf-8?B?NDE4UThhakowNURUN2Fka3JkbnBBb1ExU3BWWHZoUko3N1pEWVFuLzgvTTc5?=
 =?utf-8?B?VDFlWUNZTzNpWTRDcktrYkJVMHdoa3phYjM0Y0UrUmxUdllUbk1MeGhuYmtI?=
 =?utf-8?B?NE1GZFplWkhob1FlL2VxKzhPQll5VkZYUEFYNGNLRUhBUkVZQmZLUVFhRXVm?=
 =?utf-8?B?dGJVbUlsa0pINUFyRWdlNFlKVVhPS1NQQmRUUEVWQ08yaGxGU3BSR1VtcFZw?=
 =?utf-8?B?c1BNbEdoaHI3SE9KQVVIbEkyUGtxT1BUYmRSaUZuZjhuV2d5b2FYdEtuNmJK?=
 =?utf-8?B?YmFUNVpuUy9ENlZrVnJybDBYMEdCbXF1U0ZqeFp4elFDcndsMjN3U01hY1FR?=
 =?utf-8?B?a1VwZFZjQlIvRWNRTTVtanNCVFlBMXhwMUc1NFBLZnpXbzdUYTU0M0tSZjRT?=
 =?utf-8?B?WmdTcTRWZ09lN1hZdHJYbEFpakVVR3ZDNHBDSWkwQy82M0VranhTU2srbU9t?=
 =?utf-8?Q?/6q4P0uOjfumsjMQV/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5C067A251013346B165725C0268C1FB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: 1seal.org
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7673.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21bfd53-92c2-4927-2657-08de8e71ab18
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 15:33:18.5888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O+oJD4l6kMHPFJ/6M/uGbepiaQBK42ssUEAe6+kLR6oCX2kkfeCqP47K0/7n/KJRzo2Ymqw32WBHSHujVXFNWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10584

aGksDQoNCnRoaXMgc2VyaWVzIGZvbGxvd3MgdXAgb24gdGhlIHByaXZhdGUgc2VjdXJpdHkgZGlz
Y3Vzc2lvbiBhcm91bmQgbGVnYWN5DQpMRSBwYWlyaW5nIGFuZCBCVF9TRUNVUklUWV9ISUdILg0K
DQoxLzIgZml4ZXMgdGhlIHByaW1hcnkgaXNzdWUgaW4gdGtfcmVxdWVzdCgpOiB3aGVuIHRoZSBs
b2NhbCBzaWRlDQpyZXF1aXJlcyBISUdIIHNlY3VyaXR5LCBtZXRob2Qgc2VsZWN0aW9uIG11c3Qg
c3RpbGwgY29uc2lkZXIgdGhhdCBsb2NhbA0KTUlUTSByZXF1aXJlbWVudCBldmVuIGlmIHRoZSBy
ZW1vdGUgYXV0aF9yZXEgZG9lcyBub3Qgc2V0IFNNUF9BVVRIX01JVE0uDQoNCjIvMiBrZWVwcyB0
aGUgc3RvcmVkIHJlc3BvbmRlciBTVEsgYXV0aGVudGljYXRpb24gYml0IGFsaWduZWQgd2l0aCB0
aGUNCnBhaXJpbmcgcmVzdWx0IGJ5IGRlcml2aW5nIGl0IGZyb20gdGhlIGFjaGlldmVkIE1JVE0g
c3RhdGUgcmF0aGVyIHRoYW4NCmZyb20gcGVuZGluZ19zZWNfbGV2ZWwuIHRoYXQga2VlcHMgdGhl
IGxlZ2FjeSBwYXRoIGNvbnNpc3RlbnQgd2l0aCB0aGUNCmV4aXN0aW5nIFNlY3VyZSBDb25uZWN0
aW9ucyBoYW5kbGluZyBhbmQgYWN0cyBhcyBkZWZlbnNlIGluIGRlcHRoLg0KDQpib3RoIHBhdGNo
ZXMgY2FycnkgRml4ZXMgYW5kIENjOiBzdGFibGUuDQoNCmlmIGFueW9uZSB3aXRoIHJlY2VudCBC
bHVldG9vdGggcXVhbGlmaWNhdGlvbiBhY2Nlc3MgY2FuIHJ1biB0aGlzDQphZ2FpbnN0IFBUUyBh
cyB3ZWxsLCB0aGF0IHdvdWxkIGJlIHZlcnkgaGVscGZ1bC4NCg0KdGhhbmtzLA0KT2xlaA0KDQo=
