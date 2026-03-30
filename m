Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023139.outbound.protection.outlook.com [40.107.159.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AA133FE0A;
	Mon, 30 Mar 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884804; cv=fail; b=mHwjPJce/0kOzN/772Dr+lT7R5oKH/RQVbVTrFxUoJxmG2KGhlP2/+UjbSxFK6mabgbTFRUJ6IdNoei9jhGx08zjAKtnl5oH7z7hBeotTsQ/AfBaZtLzakGCb/Ca6ir1l0ZMWPUCTfZVhIAJzC6YJF3xLQ9VGvfhnl+Gd55/FSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884804; c=relaxed/simple;
	bh=4WjsRUp3JppEulvBbPgXVqZZdmqV+8A/N+x9bAuWW0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HFx59va146HL8r4olN8K+VZrhpDNUCMGQBv3FNQsRWJQM+9uH8DdNnQa0JKmReUljGZPZ9127aTg0euiTmA6XM1mSpzIViI0G/WUnZCkeC3kucibGZbTj/xLv1bLlmqaiIpDUFWR/jChXvO1bXpzzujZRExH6VeMhdsZsQ+Nx68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=WxETJgYF; arc=fail smtp.client-ip=40.107.159.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="WxETJgYF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xkZS/bWkJ6XLldCaLQaMPA9Lty+Uq33J4RZn0rH2k3vEUYhVFoeF9nPJGGsrbGZA3USsfiIG8mphsyR5Jp2as3QG8WPSBQbosHi/GfbtyxebIHzAxPayOEfUADQN+OQIdPnwydh2Qfb+KWunFPd7hofNEACSEk5aWhQqv4AVdr27YLv2w4M72paWIsmIShfxLvigM/uz0MmrHh1TtE8KgaAHIievisAizcGv+062C2KJqRF2AkqjVr8buKLpysAFGh5wj1MP8SrEC/7gctu+wSJZWedB1BpL/ZYgLk2GUQmpL+a+nZsUQ4pgKFtZZH4jquJS9IFvFl/Q1wdIjuvoSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WjsRUp3JppEulvBbPgXVqZZdmqV+8A/N+x9bAuWW0I=;
 b=scNwixqUdBipEX34Vcx5YQBLUeXYsq9V/9DyqETEKZZ9VBimWY4QtpkJrBBSzGeWWhoffd/1LmyMocdz45zlMonajWBmM4X5MspqUS/qNSHgmWk0eR73KAd/D7JfmOfRn0WpN0DGKpcnOPlzJIen8Jc2pKWq01Y0A9OyCZNcMpuTbuXRrKICT3PtxQTi9pYRuTmfgjOyGjBIDzqTXAQAekYygz5fR0HDF8aC4T+eaCNCQXGP/rwHrQr05i2kdmRQ9zO90pb2kCdw5ftf1Ni4bW6QO0sErOWR8mcqOEPOt9Sb/wk5k+MdTXCmrmJRrU1gRFrXh5qLOXWkixjXQnpIMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WjsRUp3JppEulvBbPgXVqZZdmqV+8A/N+x9bAuWW0I=;
 b=WxETJgYFZIO0f/vkhFr+wvNP2YEbzXhmC0b6TLzoHDoyCY1u8nBL23essHLCvJn0dPSKiQcsX7l6Evox4srDLdkQeXBDfvbK14efoP9UbSzFqyF1pGmvZuz+gnYN+uMcAvqNm2NweECKaQ6NlTfMnnekYXQkX9bRzgMehQHPm755xsRCyJWq5ekoi3BYRnQCFkd4KCDNE7UKr0lzKj6P2490cXt3qvWyusyWWcy72OzF1fXPl7kvvjOsFtx2762qqGSarz3ADXNAKxjHdHkGyhElZfeQl+utbPUp27c2JwM/St7DBy0mBurzpMjkXBbszuhDcbHFqbHCT/Vtb2eJpg==
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5)
 by PA1PR04MB10099.eurprd04.prod.outlook.com (2603:10a6:102:45d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 15:33:19 +0000
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419]) by DBBPR04MB7673.eurprd04.prod.outlook.com
 ([fe80::cf39:9ba0:2b9c:419%3]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 15:33:19 +0000
From: Oleh Konko <security@1seal.org>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] Bluetooth: SMP: honor local HIGH security when
 selecting legacy pairing method
Thread-Topic: [PATCH v3 1/2] Bluetooth: SMP: honor local HIGH security when
 selecting legacy pairing method
Thread-Index: AQHcwFqIovupBjPvE0q94pJqy0uNGw==
Date: Mon, 30 Mar 2026 15:33:19 +0000
Message-ID: <78570f37f1da48f38336480ba61e29d9.security@1seal.org>
References: <bt-smp-v3-b13a5d5f53ed4efaba74be7539453366@1seal.org>
In-Reply-To: <bt-smp-v3-b13a5d5f53ed4efaba74be7539453366@1seal.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7673:EE_|PA1PR04MB10099:EE_
x-ms-office365-filtering-correlation-id: 0f75bc83-d7df-4308-83d2-08de8e71ab8d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7055299006|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 sYR+uEmgOXUdtHnT/Kj4bhnloesLxrMs8KmauIUnFJN6g1xFMKULAueGtiWrj+THtBz/ZrvMDub5adxPylCuQa6s3iOskv4m8gHcTjuWJ9FbrHv5mB3xTeyjYjfXdWFWh+8ZoaC89tqsP4lRRBfTxyczmN+AUtcdK0cW0wdyZbGsP7uEHQYRYU01CoefNbljnNygYIuplG+cL7l1kn5ExUyJvJlIjwYOCM8whrVdk1T1Anmmx4bunnJjLBM3BPJYJ3HFnPt764lcu8plFPgQDEmoggWsjpaz5HxN/DTA8wlzfV3rMflhIP70o7isG2kZwR3/p9XBMhDQK6ZoImdQieL5R/1lSQ7SigH8lmdNIhkIxsIqczclduYb2HAgBxh1VawL9wgXgwH2UQt2CEvMX2sLgbgm/dwlcfJthjl8K6NQGpBZjNzCVNPz4TcK+WYH1aGMkNLTULhtX390kctX84dRjMG4HKlDDfUYYVagWskN23p9W7EwUtwPmxAriKD12pShyAukC/g9Gp4Y1KlSuke/DAx2IuRiUhYealeaAEDRxvvDtOPi9q+cbCxSq49iXPPq5OQuU3tVN7URg78s4TLs1JI1WoplWUM4tzdYclN+X7W4sAA+a/1uVlA+NQ4Ba4Wtz7OxvZS0Vjl6CSDaTXHIM2r4qvH4+Gc5qD4rso0Yl4KzEYK2vnDcYs26h5tXGQ1Erb9ARQoKa+xEzBqZkn3xGlnLlpFT/VrC6urEZROxXrZT0pIhJyMv25WS5ZoiO7P4EZeUuDRNLD2zMUjP3fLhHn/CGxzNypAwOKMAQpGDAJJ30u5sF85BfDU9XJHw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7055299006)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZnpiSUoweStlTndjWk8vSEQ0OUdNeCtqRHJSQ3NIeEYwK2dOV2d0TGY4elRV?=
 =?utf-8?B?TGI1WTZWWUJWOVBBa1lvS3o0TUVCV2dJL1VQWHhETm4zdS9DdWRZNUIwT0pC?=
 =?utf-8?B?N01kUW1jY0xrbERxSlRza2dtdWJUenoyaHBDQ2xwN1dUVDBhd1hyMWY1M0cx?=
 =?utf-8?B?aHE2bllHVDhqODhCK0E5QzJhaDJDNDlzVjhzWUgxSWJNYU1rUTg4UXRabktU?=
 =?utf-8?B?OVIvUHJDVGNkZkFHSmRuTWlqeFFQakl2REltcy91VzBVT1NqNUxDeW1yOG1i?=
 =?utf-8?B?dHd1enUwVFQyS2Jsak9LbW1UOW9KeDJLM09PWkpxVGF3Smg3SUJFQklMNVRO?=
 =?utf-8?B?L0NYTHdnd0pNNkc4NS83THY2NXQzL0g1VlU3Z1BreU83OHM2WjRMWWVtL3Ar?=
 =?utf-8?B?UjRKVjRFUTdnY2pxbFJmRkpDSUFUZE9pZVgzWjJ2RFJTVWQvNU4wS2NMWlpy?=
 =?utf-8?B?NU9VTTJSRTVPQlVjMThnaE9ZRXdWM3RuZXFza3dHUEI0QzRCZWlRaFZQVEFr?=
 =?utf-8?B?YWR4R0VwbDRSdS95QVJaNnVxeFVPeU1JQ3NEYS96eDY0OUYrZjJvakdHZWJy?=
 =?utf-8?B?SjJxSVdMNmtQSnJhYm1UTTE4YmxOMXJYYkNydUUvTWZyeDZiKzQweVhFRWhL?=
 =?utf-8?B?RjhGWndrWWZGRjNObWxKa3RhTEQ3NG1tdVdwWUpwRk9rS21UUXduMWFBYXhx?=
 =?utf-8?B?Uk43YUY4S0hmQnhteE9sYmhLQk1HZ1k5dkNpdGZKZVVNNlJWWlYwUFE1a3JE?=
 =?utf-8?B?TnV3dHNRaGlMa0IrU1g5T0ZDayt6cG1FZVMxb05XbzVQdU93My9xbUJPUVF0?=
 =?utf-8?B?emY0U3c5YXBwV2U3R29jL3BoV2JqcnBPUVM3bERmODFmRDJYOHVTNkxCR0h6?=
 =?utf-8?B?ckRrUU4yMDJOU3dTREdtVDVEME5IMHF2QkRyN3RyaUJUZHcrRVRrZy80elor?=
 =?utf-8?B?K1dHT003d0ZoLzNjMGEyN2pMQTF4cDM5WGhYc1NCclhkQlQ3OXdpMmNOb0tG?=
 =?utf-8?B?ejZ5Ym4zb200MGp2TVVIejA0UHRac05Md1BrTHNoSENuWWRCallQNmtkQUtI?=
 =?utf-8?B?RXc0VmpmdUM2MlEzRktJNk1qTVRrekVyWE50NFZtY0JhZmV2eGZuT1EvR25k?=
 =?utf-8?B?VWdndStyd1UyN3d6MC9LUGowT1B0cmgrZ0RqcGlMazEvQ1d2SWh5NVA1bjRx?=
 =?utf-8?B?K0VnMjBEUjd3dVArbFcyVnVCYjZRcUYzUEdYblFNc2Y3bnBmU0wrOURtVlB2?=
 =?utf-8?B?NTNIeU9FdXJJMklPb2IvM29PNmxuOXgyUThkV3hsV2toT2lDQVcyRVJITy9l?=
 =?utf-8?B?ek5oT3pSQUpiUzRRdHNsUjJ1NWpKREJBT0RaWHVzSkJKRkZycUExS0ZkZ3VM?=
 =?utf-8?B?QlJWSEdzbCsrNVlBSkpYVzRONUMvNTAwanlBSXpCazdobTVkcHNNQUx0dFVE?=
 =?utf-8?B?UkZab2dkL1c1NTBMSlBUaDQvTk15WnRYcFArcUFGZmsrbUc4dllBb3BXSFlj?=
 =?utf-8?B?VFI3dlhpZngra2g3dVhGTGNHQ1h5c1lQSDBDeHI3VTBwa2V6YXhxV0pIRjg5?=
 =?utf-8?B?UkkwcmJUc2ZOUkhCdTdQcnd1SkozU2gzeW9kdi9Ncll3MDBLS3BYMlRrWU1v?=
 =?utf-8?B?a3JJdXVXbURmUDBjS1J5UG1KTWVVUEFxU0g0WGpqSWp0aEt3ZHgwWDU2bk4z?=
 =?utf-8?B?ZHhNajI3azIwYm1FT0pvWDRYeDl2NkMwVzREZ3A5Wk1kUlRGaWRXVld1dkkr?=
 =?utf-8?B?WGFBUzljMDMrN2trZElMUmF5QWZXUWVhcExhTnFYOFB3bW9GSEJQTnlGc3Bx?=
 =?utf-8?B?MVRkRGVWdHdONEVxaHc2ZGRSejRYT0lGbzJSbDc4MmZid3ZyUytQM3pBM2E2?=
 =?utf-8?B?SUZGLzJNbG41bmxPK0h4NlNMVzJrTit1emJrNW53YnRzdWYzMWlnM0RzSmJu?=
 =?utf-8?B?czAyTHdYZ3d1SnBZSVZBM0w2Q2VRQlcrTDFCdHlGR1dhRlpjUW5FekFaZEhz?=
 =?utf-8?B?L1orSzFPMnJhT1Q4TVF2SUpWRGhCNWRHcGU1REdEUEdTaGp0cGI5QjUrVkRh?=
 =?utf-8?B?SE1sOFk4cmZCQ0RjNFp3S1FSM1Rzb3hzSHFaZlAvdGpYNDJrakhPMzBTNC8x?=
 =?utf-8?B?cU1UbGhaZ3RNZjE3L2tHMWRTUDBUVTdkMG5uenZPN2VoQ1lQV3ZFL3U3U0pQ?=
 =?utf-8?B?cDhjRTBncFNLMGlvS05OckwzeUdhcTFSRStVQ0tmS1UwK0xxeGhnNzBRNUgy?=
 =?utf-8?B?T2dtV1Fvcy9jS3U5NGxrU1pZdnFvQi9jN1ZzWXF5amNQK1VvdmQzZ0MybGx1?=
 =?utf-8?Q?a4QBiEA+2scQDrxbpy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DDC6C7F6EF60B4BBFBBD9D503D32666@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f75bc83-d7df-4308-83d2-08de8e71ab8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 15:33:19.0354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7udZ+lfKTWHz9EKb9WG96MC0YlICYROvJo6Iyl9BkSX2Oy9i2O+omn1DpwDBBJWeQGWehDJISCPj2e6fpJPWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10099

dGtfcmVxdWVzdCgpIGN1cnJlbnRseSBmb3JjZXMgSlVTVF9DRk0gd2hlbmV2ZXIgdGhlIHJlbW90
ZSBhdXRoX3JlcQ0Kb21pdHMgU01QX0FVVEhfTUlUTS4gVGhhdCBpZ25vcmVzIHRoZSBsb2NhbCBw
ZW5kaW5nX3NlY19sZXZlbCwgZXZlbg0KdGhvdWdoIHRoZSByZXNwb25kZXIgbWF5IHN0aWxsIHJl
cXVpcmUgQlRfU0VDVVJJVFlfSElHSC4NCg0KVGhlIHBhaXJpbmctcmVxdWVzdCBwYXRoIGFscmVh
ZHkgcmVqZWN0cyBKVVNUX1dPUktTL0pVU1RfQ0ZNIHdoZW4NCnBlbmRpbmdfc2VjX2xldmVsID49
IEJUX1NFQ1VSSVRZX0hJR0gsIHNvIGxldHRpbmcgdGtfcmVxdWVzdCgpIGlnbm9yZSB0aGUNCmxv
Y2FsIE1JVE0gcmVxdWlyZW1lbnQgY2FuIG1ha2UgbWV0aG9kIHNlbGVjdGlvbiBpbmNvbnNpc3Rl
bnQgd2l0aCB0aGUNCnBvbGljeSB0aGUgc3RhY2sgYWxyZWFkeSBlbmZvcmNlcy4NCg0KT25seSBz
ZWxlY3QgSlVTVF9DRk0gd2hlbiB0aGUgcmVtb3RlIGRvZXMgbm90IHJlcXVlc3QgTUlUTSBhbmQg
dGhlIGxvY2FsDQpzaWRlIGRvZXMgbm90IHJlcXVpcmUgSElHSCBzZWN1cml0eS4gT3RoZXJ3aXNl
LCBkZXJpdmUgdGhlIG1ldGhvZCBmcm9tDQp0aGUgSU8gY2FwYWJpbGl0eSB0YWJsZS4NCg0KRml4
ZXM6IDJiNjRkMTUzYTBjYyAoIkJsdWV0b290aDogQWRkIE1JVE0gbWVjaGFuaXNtIHRvIExFLVNN
UCIpDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KU3VnZ2VzdGVkLWJ5OiBMdWl6IEF1Z3Vz
dG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NClNpZ25lZC1vZmYtYnk6IE9sZWgg
S29ua28gPHNlY3VyaXR5QDFzZWFsLm9yZz4NCi0tLQ0KIG5ldC9ibHVldG9vdGgvc21wLmMgfCAx
MyArKysrKysrLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvc21wLmMgYi9uZXQvYmx1ZXRv
b3RoL3NtcC5jDQppbmRleCBlNjdiZjdiMzRlYS4uYTlmYjliNTEzZDYgMTAwNjQ0DQotLS0gYS9u
ZXQvYmx1ZXRvb3RoL3NtcC5jDQorKysgYi9uZXQvYmx1ZXRvb3RoL3NtcC5jDQpAQCAtODYzLDEz
ICs4NjMsMTQgQEAgc3RhdGljIGludCB0a19yZXF1ZXN0KHN0cnVjdCBsMmNhcF9jb25uICpjb25u
LCB1OCByZW1vdGVfb29iLCB1OCBhdXRoLA0KIAlidF9kZXZfZGJnKGhjb24tPmhkZXYsICJhdXRo
OiV1IGxjbDoldSByZW06JXUiLCBhdXRoLCBsb2NhbF9pbywNCiAJCSAgIHJlbW90ZV9pbyk7DQog
DQotCS8qIElmIG5laXRoZXIgc2lkZSB3YW50cyBNSVRNLCBlaXRoZXIgImp1c3QiIGNvbmZpcm0g
YW4gaW5jb21pbmcNCi0JICogcmVxdWVzdCBvciB1c2UganVzdC13b3JrcyBmb3Igb3V0Z29pbmcg
b25lcy4gVGhlIEpVU1RfQ0ZNDQotCSAqIHdpbGwgYmUgY29udmVydGVkIHRvIEpVU1RfV09SS1Mg
aWYgbmVjZXNzYXJ5IGxhdGVyIGluIHRoaXMNCi0JICogZnVuY3Rpb24uIElmIGVpdGhlciBzaWRl
IGhhcyBNSVRNIGxvb2sgdXAgdGhlIG1ldGhvZCBmcm9tIHRoZQ0KLQkgKiB0YWJsZS4NCisJLyog
SWYgdGhlIHJlbW90ZSBkb2Vzbid0IHJlcXVlc3QgTUlUTSBhbmQgdGhlIGxvY2FsIHNpZGUgZG9l
c24ndA0KKwkgKiByZXF1aXJlIEhJR0ggc2VjdXJpdHksIGVpdGhlciAianVzdCIgY29uZmlybSBh
biBpbmNvbWluZyByZXF1ZXN0DQorCSAqIG9yIHVzZSBqdXN0LXdvcmtzIGZvciBvdXRnb2luZyBv
bmVzLiBUaGUgSlVTVF9DRk0gd2lsbCBiZQ0KKwkgKiBjb252ZXJ0ZWQgdG8gSlVTVF9XT1JLUyBp
ZiBuZWNlc3NhcnkgbGF0ZXIgaW4gdGhpcyBmdW5jdGlvbi4NCisJICogT3RoZXJ3aXNlLCBsb29r
IHVwIHRoZSBtZXRob2QgZnJvbSB0aGUgdGFibGUuDQogCSAqLw0KLQlpZiAoIShhdXRoICYgU01Q
X0FVVEhfTUlUTSkpDQorCWlmICghKGF1dGggJiBTTVBfQVVUSF9NSVRNKSAmJg0KKwkgICAgaGNv
bi0+cGVuZGluZ19zZWNfbGV2ZWwgPCBCVF9TRUNVUklUWV9ISUdIKQ0KIAkJc21wLT5tZXRob2Qg
PSBKVVNUX0NGTTsNCiAJZWxzZQ0KIAkJc21wLT5tZXRob2QgPSBnZXRfYXV0aF9tZXRob2Qoc21w
LCBsb2NhbF9pbywgcmVtb3RlX2lvKTsNCi0tIA0KMi41MC4wDQoNCg0K
