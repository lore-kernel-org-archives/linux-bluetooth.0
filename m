Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023128.outbound.protection.outlook.com [40.107.159.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4979D3DD501;
	Tue, 31 Mar 2026 11:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957940; cv=fail; b=g8fSKpTy+USdCK7aquLTBFcNq9Xg6KA09xFFEa+W0rLQQCYDA1YS0RhWnxYHblLaysiCSTQ9sJtTq1q7o5liVa9N/pAL26v8IqR5kgEATLjyeNp358OOztMY2b58EFH1tKxDla0tBDARt60o5JQef83uwB3ssKvb9fO6akZvblE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957940; c=relaxed/simple;
	bh=WEfVexNHEVaNfW1o/iRZHOp5ebP/Ic8sSAe+f7OeGDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ChT7HdIgmIPreZR3/a3VAmCjh8sGtpHM7P1TR6GD+1tyRVT7VQFsOAIWdHw6vfxfbwn4y4xBdQ+QzuscEx5zGZ6Ll/ZNpbElrwPB8xvvBp+paA7xgMgXpmTMmPPtlnamJnjd7rSmJ5o4rlMG6jGLHxIUNREPv3d2uYvA8IikT/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=Mi5pP7cR; arc=fail smtp.client-ip=40.107.159.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="Mi5pP7cR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uejrFhQMCxpGni1snheAtPmjEBH3MUdcHcTkmIR7abPbpFOw+dt6h+qVtyb9lv2Ts4I7dSSxRWQWoClEJIkxBEBK6XERBZn6TAqoWS08k5C8qU34ZTNb3uV27bGfshQaVtbE5vQ9QRwyVI07CTzzIgwyzr9JdaxELETm/ZGhvB6BMZgGBn074xX0h7yzlLUDXhivFqC6BmSXLuxZAtQj30N8NzKwiFB8uuL7KgmTXSIcpTwplZlfa1r8CQJCL3N3eNbCyNyM48DHn/26SYkILIGEuPpA52aCNJ2vU7GHkbyT4/k9y7lOtxggEe1auD2ZiLo4+tgMebYrf1MyOeatVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WEfVexNHEVaNfW1o/iRZHOp5ebP/Ic8sSAe+f7OeGDY=;
 b=fcqJXg4LSJFQSYsBw36SCYzNvVEuKL+HyUpiyEPieVFmjyoXDCkTByTL2PgGPzjr4MMN6HqIqTlDWResP60FPkxjQZz4/CfuHrtWstZuP87Qz/ZpP/yZWGpiBcISaD3+yToDACRKxnbz7RiNSr6gIvHSko8uo/xBi/d+LFVYIgGPKaueJogfYEG7yvFyW7SN6k6njdloPBYOcJJExzp/IzIFwiURiS2whcQntpe2pxEMjehEYEE+oPnpJe1B1GZzRmKzveK5EggbHmMTJEM9UX6bUE4IrNuzCaYU0FDz4ru1gP1p/i7f9ITjbXu+xm+Jf85tYZ+ngPq6lRXc5pMIQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEfVexNHEVaNfW1o/iRZHOp5ebP/Ic8sSAe+f7OeGDY=;
 b=Mi5pP7cRhTmATPBkzvD+3YjrpeocksnyOmm1ej9S/Xu/yNNcQxqQg/NLxGIY4+IwIdetBzHInZaBBrFIJd6Za1p/sGKV6vxwKC3dOnXdFol2dFAuxEpEBC5r79CUH8xoDv/zHUmDsZnNauhG/bzPZ2bBcWTEjrmqkwphJ6fPgdk8pW5iHg9jEE5wSgCRh/KvQUOWabQGmRYW4eaKjLO8hnylv6+LVozZ/HIfN+FePu6898VkMGh/8nL/jJKz1lU8P9VJ2p/L5Ywet1p1toq4Ywo0rZ0CQT+oJdSFRgOZZz2/8Syi7971bpkS+got60bUeDPIBSyQ1ihVh61AQiKxcQ==
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5)
 by VI2PR04MB11219.eurprd04.prod.outlook.com (2603:10a6:800:29a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:52:13 +0000
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419]) by DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419%3]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 11:52:13 +0000
From: Oleh Konko <security@1seal.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/2] Bluetooth: SMP: derive legacy responder STK
 authentication from MITM state
Thread-Topic: [PATCH v4 2/2] Bluetooth: SMP: derive legacy responder STK
 authentication from MITM state
Thread-Index: AQHcwQTQBPWzq9TR0EaHRBcDdug2Yw==
Date: Tue, 31 Mar 2026 11:52:13 +0000
Message-ID: <5fd853078b1a4880b9c598a8e964d357.security@1seal.org>
References: <bt-smp-v4-ea63d24bfcd1416f9da279190fab15fc@1seal.org>
In-Reply-To: <bt-smp-v4-ea63d24bfcd1416f9da279190fab15fc@1seal.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7673:EE_|VI2PR04MB11219:EE_
x-ms-office365-filtering-correlation-id: 63f00e0c-dead-4a83-fda1-08de8f1bf2fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|7055299006|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 u3ERQpsOrhupkfxMBkwKJQd6uM5ibqV37XZfkoJw8bjOmizUec94I3NrdKKuVbrac1VWE8hH8ZMVdAYeXwpFMtGdVm5HGppbVfQCV8xfJ5xALk4tACV5WHtvaNY2n+CFsoqDPoEE+m1q+U9C6Qsm382EZWPfAan3SsD3KA6k6kDBvQObQ7iDnLBAImhZnds561z+mtUu1Q/tfqubk4R0HDztaak53f0XSZovz9idRVGlpgeJhI7L0m31JgUjYFAKfxRAQpfUwIDqx0zRkKRN4o6YPSJ+rIzryfkV8J1iLRS9RXLZvkMS68+eG36xOBryZTtViQLs776ruYi2Aq+8sEoaFTkEaXUeKJ5m4PC5oqbFadUvXa/b7x5Fu810ZHgc/pHi3+pNYNc1H63mGrP3l2U2VY1cvQvJsX0HttccKnN4M0kwBE2ArbHqSXHAf8Sv04kJXbLbJFYHyiofNOOfHlnPWg2wqUlSCpvtNmdI0tvz4xv8Wi7HAkfxnBTgteykc0nyO6fdPh5Lo8QXApPTF9nknbrmTV7PqPE5CFqsFcQiezI0lG3hcmFOfH+Mi7A4vorfzYnO8H7DGldfvMQr/dzPQIgQsZc9J+8GGE1/KTfL9smvZWEKGm/50te8h5ioWq+V0abY3AnIW0VhpavH3m/kZF26eSOFUvu08uvBHfsTcXjxGOOCNQ0AgxZ4XeT4/Jq5u4xPS87p6rf5XIK9sVcJthM2AN00Zlbh409+K1009tTB9fW8RbnQyvMlUqoAIJbjqi8BGEvcJSybJMApUdUVyKA329KqwTe2+TkpoJKvEvfz7NvC4En4NBemt7yS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7055299006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TytneWZIRDlzSU5Oc3IraGlrWlgrV3FqZ1ZTQ1RPeEhqeWlrZFQ1d21yWDBq?=
 =?utf-8?B?VmJZSFN5aGNKL2x2bWRiZnJtWUFMUUo1MUdBbjJURFVFVjBxOXJ6UE9ubjQy?=
 =?utf-8?B?cUNhRENXSk13TFpxYnI1bGZmeUdiMnE0dFFNUFdqZ0gzM0pGdFdBZ21QOE5x?=
 =?utf-8?B?VlJMdnNsRjJzRXdvZnBjTUwrNFRIRHZOVThSZDl5RENIVEcyUldoaVJhQnMz?=
 =?utf-8?B?YkVwWFErektxQWFGc3dxZHk4eEZoV1RoNXNiUmNTalplT3B5SDVRTG10bDM2?=
 =?utf-8?B?NXNyREhyVDdRc1Q4OVZ4cUhodU1MYXB3VTdLUnZNNG1WR0tIL1FBREZEN0g2?=
 =?utf-8?B?c1JBejdqK3o5c21uejJzeEZOcEFVYVp5WDBBVWk5SGZFWnRoazVNTTB5SDRy?=
 =?utf-8?B?SzBrRnBMY200Y3lPUTNjaENMc0s4UVV2U0d3Vnh6a1h1cmptU0M1S2l1aDBL?=
 =?utf-8?B?Z09rMWFYNXZmTVdpVm1wWUliVW1ybUJ0ejBYdDlKYjNVTUp4ZUNXTUlCeDdI?=
 =?utf-8?B?b01UeFl4Uk9uMVl3eGNXdkk5SjRGSjdXcU9kVTRGU2tLMVpNTUYwS3l3L2dT?=
 =?utf-8?B?WTFUTjArWVYxWmUxZzhpQmN6Qy9yL2thZElZYlAraDU0T09FVE9XcVN2ZExI?=
 =?utf-8?B?anp1cVpjYnhKOSticld3WjNjcUpvdWJQeTVQVEpWcjdOaHE1aFVxNEFKWTZr?=
 =?utf-8?B?cWxHWkVBMGoyQ1lTanI5WEpRV1g1dWd4cUdmUk9KVnBkZDZOTTVkZFRKeVQr?=
 =?utf-8?B?Z0pNU09MbVdEQzV6OE55ZDlXNFEyMEoxbFhhbDVuM0IyNXBHcmh3b1Nrak5t?=
 =?utf-8?B?bUI1TVBOYjgxcU9yR1ZhVGtqNzhha0U5UWh6N1pMbk9HQTRUS0dJVU03cGox?=
 =?utf-8?B?S2wzQkpDNUpLYnZRT01xWSt3VXJUdThINjB1QSs3c2htRHpNMXA0R2hhM0ZX?=
 =?utf-8?B?Z1liSHFoVnl5bmNtdWFvamk0WC9JTDYwSEtoVEo4c0hVRlVXVG5halo2Y1dr?=
 =?utf-8?B?cFJvZmwvSUZtOVpMandDM0xFVWZMN1U3bFhObWx5RXlSTWsvQzlyekliYVY5?=
 =?utf-8?B?VXBIYkwxaEc0VkJZWWNpZEp3elc3c3BjckZKV2Y5a1VYNmJyTHh5bnZEM0Y0?=
 =?utf-8?B?L0hWc3hPclQrNVNMaklJd3VQb0JlVDlhMk8yMDFpbE1OaDk3TVN0bzJlTHo5?=
 =?utf-8?B?T2F2QStvcEdwbzJOaHoxTlBMV0Radjc2WkdGUXpRTTRwS0F4VjN1WUlTbE40?=
 =?utf-8?B?aG4wSDJ6cFYzMFhjcFpzM3ROcy9KaTZkLzROS05XNU9GUGJSUEt3bVA0bitZ?=
 =?utf-8?B?ODMxL08rcE5IOUNrbUhxUlVBTHdJMFI3dGl4T05aMTZ2bXFVSDdZTmgydTNK?=
 =?utf-8?B?d2FkRlp3bG0vc0FHTEN2S3ovOVhwblVvK0lBdDFheXcyQ1pOYnpmVGNJb0cr?=
 =?utf-8?B?Z1MxL3c4WVVrVzA5aDdKdWpPUzRabkErdEJJRnpMMGZ4cXQySUY5Ty9Fcnpk?=
 =?utf-8?B?VjdVcFVqWjlYbTZ4Z0taY2xjd1dlVWJROXNxK0FVdTJEQ3hiQ3F6TUF4d0l5?=
 =?utf-8?B?cWpqNkhWRDhiclpSV2hUZ2lBT21PNEdkYnJOMGcwUTVkZnRUOW5EYzVUOGhX?=
 =?utf-8?B?aENuemlJRmFFOXpSa3U4WFZYWFZaOWp6dGswWFU5bkZLRGFZMXdsZ25iSnpk?=
 =?utf-8?B?QTNFMURPeEdqZjZKTzMvTFgrNVRhWXR6bExISEUvOEcxMDRXaStGNFFTQVJj?=
 =?utf-8?B?TW0xRlp0REpjakEyYWtxSmJxdE0xOVd1Z3FaemtDYzJyZlMzWExVTVdwVWJR?=
 =?utf-8?B?Nk9nQ2tja2NrZDJtaEVlUWRvc2xaOElTSDFFRUxzc0s1RVlSVmllMzQ3UUJ5?=
 =?utf-8?B?dk0vY254ajE0T3lqMjFTZTY2MEJoMkFDN2ZvS09yYnZ3UmhUZG1FVjgrMWF3?=
 =?utf-8?B?ME5OZkZyblQ4R2pEelF3a2tJeWpRczNpOERvNkRwWEh1R0tHNnRCYllSZnBw?=
 =?utf-8?B?c1UycVFZczh0c3BxV3A1U3RPeFhod2M5ZVdwTWNuazg1VFJiUVFYS1FuWW9T?=
 =?utf-8?B?cGxDWEs4MGNRRmk5WVRoczBlSFplVmNaRE43SG53VHJRWUtxc1BUem9zVU5W?=
 =?utf-8?B?S3JvRUI1SmxFeGRsNDRHejVBY1NFZ1BuZG04MW5pWnJnRXZDbzJNRWxOcm5x?=
 =?utf-8?B?V1IyK1Q5T2RJSVBXVXNXTS9xWEdYMUdMUGtGZ0NSVmJFWE0rOTdQWkFocWc5?=
 =?utf-8?B?SjIvdU9vY0Yxa3Y5MVhEeVVrUHRxSmZpQVduYys5Sk5HbFRZRjhudkwxekRD?=
 =?utf-8?Q?rNx2E6iBRiEUyKpngj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E5D33AECB46894C9E2A8D9A635DEB7D@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f00e0c-dead-4a83-fda1-08de8f1bf2fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2026 11:52:13.1664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgLkT2jDZyZ/hkpdiZloyfACFI7zD9ecsEwtkD9L1XjCHXnutOfLVSd8/hnu9+7Ocnht6kqPFS7di88ONMDIiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11219

VGhlIGxlZ2FjeSByZXNwb25kZXIgcGF0aCBpbiBzbXBfcmFuZG9tKCkgY3VycmVudGx5IGxhYmVs
cyB0aGUgc3RvcmVkDQpTVEsgYXMgYXV0aGVudGljYXRlZCB3aGVuZXZlciBwZW5kaW5nX3NlY19s
ZXZlbCBpcyBCVF9TRUNVUklUWV9ISUdILg0KVGhhdCByZWZsZWN0cyB3aGF0IHRoZSBsb2NhbCBz
ZXJ2aWNlIHJlcXVlc3RlZCwgbm90IHdoYXQgdGhlIHBhaXJpbmcNCmZsb3cgYWN0dWFsbHkgYWNo
aWV2ZWQuDQoNCkZvciBKdXN0IFdvcmtzL0NvbmZpcm0gbGVnYWN5IHBhaXJpbmcsIFNNUF9GTEFH
X01JVE1fQVVUSCBzdGF5cyBjbGVhcg0KYW5kIHRoZSByZXN1bHRpbmcgU1RLIHNob3VsZCByZW1h
aW4gdW5hdXRoZW50aWNhdGVkIGV2ZW4gaWYgdGhlIGxvY2FsDQpzaWRlIHJlcXVlc3RlZCBISUdI
IHNlY3VyaXR5LiBVc2UgdGhlIGVzdGFibGlzaGVkIE1JVE0gc3RhdGUgd2hlbg0Kc3RvcmluZyB0
aGUgcmVzcG9uZGVyIFNUSyBzbyB0aGUga2V5IG1ldGFkYXRhIG1hdGNoZXMgdGhlIHBhaXJpbmcg
cmVzdWx0Lg0KDQpUaGlzIGFsc28ga2VlcHMgdGhlIGxlZ2FjeSBwYXRoIGFsaWduZWQgd2l0aCB0
aGUgU2VjdXJlIENvbm5lY3Rpb25zIGNvZGUsDQp3aGljaCBhbHJlYWR5IHRyZWF0cyBKVVNUX1dP
UktTL0pVU1RfQ0ZNIGFzIHVuYXV0aGVudGljYXRlZC4NCg0KRml4ZXM6IGZmZjM0OTBmNDc4MSAo
IkJsdWV0b290aDogRml4IHNldHRpbmcgY29ycmVjdCBhdXRoZW50aWNhdGlvbiBpbmZvcm1hdGlv
biBmb3IgU01QIFNUSyIpDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KU2lnbmVkLW9mZi1i
eTogT2xlaCBLb25rbyA8c2VjdXJpdHlAMXNlYWwub3JnPg0KLS0tDQogbmV0L2JsdWV0b290aC9z
bXAuYyB8IDUgKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL3NtcC5jIGIvbmV0L2JsdWV0b290
aC9zbXAuYw0KaW5kZXggNGVhYWRiZTBkMmYuLmU1MDRjY2Q3NDVhIDEwMDY0NA0KLS0tIGEvbmV0
L2JsdWV0b290aC9zbXAuYw0KKysrIGIvbmV0L2JsdWV0b290aC9zbXAuYw0KQEAgLTEwMTgsMTAg
KzEwMTgsNyBAQCBzdGF0aWMgdTggc21wX3JhbmRvbShzdHJ1Y3Qgc21wX2NoYW4gKnNtcCkNCiAN
CiAJCXNtcF9zMShzbXAtPnRrLCBzbXAtPnBybmQsIHNtcC0+cnJuZCwgc3RrKTsNCiANCi0JCWlm
IChoY29uLT5wZW5kaW5nX3NlY19sZXZlbCA9PSBCVF9TRUNVUklUWV9ISUdIKQ0KLQkJCWF1dGgg
PSAxOw0KLQkJZWxzZQ0KLQkJCWF1dGggPSAwOw0KKwkJYXV0aCA9IHRlc3RfYml0KFNNUF9GTEFH
X01JVE1fQVVUSCwgJnNtcC0+ZmxhZ3MpID8gMSA6IDA7DQogDQogCQkvKiBFdmVuIHRob3VnaCB0
aGVyZSdzIG5vIF9SRVNQT05ERVIgc3VmZml4IHRoaXMgaXMgdGhlDQogCQkgKiByZXNwb25kZXIg
U1RLIHdlJ3JlIGFkZGluZyBmb3IgbGF0ZXIgbG9va3VwICh0aGUgaW5pdGlhdG9yDQotLSANCjIu
NTAuMA0KDQoNCg==
