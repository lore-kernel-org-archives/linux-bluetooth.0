Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023104.outbound.protection.outlook.com [52.101.83.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95B7346FA7;
	Mon, 30 Mar 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884805; cv=fail; b=dDn+S+66mpxZB9mvNywN+IAJS/u8zu7DjzrlJYP8alqVIxOkLIvJiW2ZfE+0OKmIG79VnUyGidroZfYIbXaqbyLj0XsyeZyVKQzslXiSXOpdIX5nMTPLF1RXnYVptmQH/GR7dgqQ3EZL21+Jat9J8rb6+pOd8L1JboOrOlwPfxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884805; c=relaxed/simple;
	bh=LUICsXv/hGkJYL1h0rtVlNtMzTikxm2y2BtsRvgFVdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=THzHTzfaiWD79BhtWtSZ0oCTHV69vEKL1Kyg/pAFAjnh6aPduMoNs/bWGM+cOTtnldp4CgGQmfDqRJEzww+i/7RRsLhGGhtbdYvS5DluVOOyh2xE3oPbnXPYFttjipWJdD+eyooWQhlrbJJtwBjX01Qc23MnrhyD/z/hOC8uirA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org; spf=pass smtp.mailfrom=1seal.org; dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b=hf31jjwq; arc=fail smtp.client-ip=52.101.83.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1seal.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1seal.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=1seal.org header.i=@1seal.org header.b="hf31jjwq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSgE6jZ/4/UYzYR4EvH7sn0vhxUFdA3txTFN5oKMYgxbdO6Mw6KDCM9TjRh8fkrPZnmPRCu9Doiwhq/bWROEFmnTnB2cMIso0ZaziznEe01cvpC/rdNF+IX+ajv7ubBPgGD130PZGPJM5leLfJhz3w21CTkWax9a0b/1h/FMi6bJmwtlAIXEfJcYpnqd9cYSiXTsLywir1gzRxQI3gbcUwAAqPvD8WY/DHZ76A9piHsMhT8C+71RTV+Fa8TRpNisbIVYCUbQ6jWRxmmStXVL1he4S44wJSl0MIHl1RHiEeagPd94T4usH6SIPqeZluMUOr6DyTDtJWuZfakK7m3yKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LUICsXv/hGkJYL1h0rtVlNtMzTikxm2y2BtsRvgFVdY=;
 b=lRTyztlWY9LBIN3k+1krYelT++T5lj55I2zBi3OG6lP3UpvrKYI3IMdFdv4jnWmaQBLekP2WUNJhjsjgt4nzGQXxrH+/vA0iDkeN6xHZmy+eoZNGkniZE+SwKwZP1IOk6bqEyTkuTQ34NY6mfga1tCpWV+DXmPBazHdzp4ByX8WMfnqM3neRV0bBW8i6K03wGm714Lkvln9hTPADZdG2aybIuu8OfXfIiUh2SRevl8b0VzUeZLsY/jlkMWWDvcQWQAmTkXQfjIEABY/0SI8m/1j548tk5vLniaHIawllIb+N/OCu8wUG/eWPcyHHYN/PQRnME1DVENta++ysQaR1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=1seal.org; dmarc=pass action=none header.from=1seal.org;
 dkim=pass header.d=1seal.org; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1seal.org;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LUICsXv/hGkJYL1h0rtVlNtMzTikxm2y2BtsRvgFVdY=;
 b=hf31jjwqz5l5WZLtBM/CQMwSEkJgzDT/ZFjQP8JPi050CKIKxfIxwVSjzD5s8qQ5/dUmpTeCFoXGyZkJSbfEXVlCFFTCeIY/xkQO+pS4IY0BsZcz4c8eJjW1uNOR3eTXAKCx3JCcpW/6WGLtI+2cszaY5NQtVX284FI2Omjm2q1MgdHp/h6Hooaf052uL1hkUMMV7hSFaSK4KqQ1nXtCGdQCCEKEND86QUh5C5APzWJnEgimCiVM5Rz6c/WSdntkbPtK23shsfw3dnaVLVTb09y+GmeKs2Rg4FVC0vAoYNBW5JtSV9s08RdFpkCBK4/h+5qd3F+4pq45O15KH0LvRQ==
Received: from DBBPR04MB7673.eurprd04.prod.outlook.com (2603:10a6:10:202::5)
 by GV1PR04MB10584.eurprd04.prod.outlook.com (2603:10a6:150:210::15) with
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
Subject: [PATCH v3 2/2] Bluetooth: SMP: derive legacy responder STK
 authentication from MITM state
Thread-Topic: [PATCH v3 2/2] Bluetooth: SMP: derive legacy responder STK
 authentication from MITM state
Thread-Index: AQHcwFqJQtrYh5hoSEmSk6KlINzJ+Q==
Date: Mon, 30 Mar 2026 15:33:19 +0000
Message-ID: <d96e58df403e416988e4a742cf2267a2.security@1seal.org>
References: <bt-smp-v3-b13a5d5f53ed4efaba74be7539453366@1seal.org>
In-Reply-To: <bt-smp-v3-b13a5d5f53ed4efaba74be7539453366@1seal.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=1seal.org;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBBPR04MB7673:EE_|GV1PR04MB10584:EE_
x-ms-office365-filtering-correlation-id: de92fc76-a48f-4304-048e-08de8e71abd9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|22082099003|56012099003|18002099003|7055299006;
x-microsoft-antispam-message-info:
 4jOcakEY3JwjCKzKa2rmugd9GmYEf8Bo97cRjn1BCExof179AWCKW+NsRhiYT5sINLsnaW49jRCyss8n/h/SzRNI181oZ4bm46++gR6sG1Y4UdxFOkV9qD75RnsIc9jD9yzTwOYxESpWfDYM0x1hmI/fKrjI7iJDJlcB4vwz6Mtt9DKmOT5jySSWsptXVUI1Nr76s0yF9taxAXxSVCQ5dzxl4yULn3isZPrjjOlH5mYtxKPm63F4x1IrFdWZAUEy1i+qWs3viVPqYNa/nd1FjgaUYhAeQT/THCqcsoDfxANsDSGyqS+W8bvm2wZZQP3GcDgN3lWLGNMpb1C9X6ITAFZKVz6db7Hi1UEapoTLzdRGw54W3EzeU0MJzwzQo8qOJBPBSa2oZGgQ/mi7R3UNfH8S++RmctbhM5L3p7XJYiTF0ZD6YyFK0NmcbJqRJOMo7jn9Jxxex3DDlSwZ2CtqmlzVbPtkPegCBs2ZxEHC879cS3TsrshiM64JUfKaqNX7UJyhPPXwJfaf8TdNxAuiyAsayj4BuRoS5tJlxKowI70v29AiIBbymN0e3Vc7ciFJw61+z6p8Fbs9hvl/ytsmqVtmeFGZMxotwi/wtZD+tjbOdNyYCbDpYwzUKqt4SnCYGBHFY+xxa+dZfqxtP/mgWluOm3w9z2Kpqg84F+ZyJ35S5lPt3sgKFmbWu0tfShzNMT7QuXY9oRW2YyYjABSKTFFGU7ZLFiyTAxhmvBgn/gJhbosqrFziEBTCPp4XkksOI2rP7pMleDQUeSrJpfL1bXDfPr0g5v+3j1zCxy7H2gDZnUlci/LEsUoFTGi9ioSb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7673.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(7055299006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SS83NWc5dlAyeWQ5cUpiWktvNkFZN0crbWNtQXc3UzN0b2htQ3J2ZTFTRlFw?=
 =?utf-8?B?RWZ6WjhjMmpxWnBrdnh5QUV3TEd5N1FLR00ybHp1dzhWb05UMm1YWHRTdFFn?=
 =?utf-8?B?K2VvK1I3NytXM2VQU0VGYnUzd0pOVEN5eXJPZjZ3clM3NUVRL0tYNU92bnV0?=
 =?utf-8?B?Q2gyRXU5K3hYWlZ5c1pKLy8wWGErdFZjL2xMUlpRUmpLdVBLY3R1eVIxR1R0?=
 =?utf-8?B?bGVESUNUWU5NRE5qd0RwVXpNVVROK0hWQU1KNlM5bG01MTRXT2REQUovc3gv?=
 =?utf-8?B?TkhQeWo0bGZRcUp4b1NGVXZqa3pPTlBjMEswNjF2UGlyUDM0bXBrMnQvZFpF?=
 =?utf-8?B?MGtETzFUZVJGV1JuZmQ4TjFqTzl4UjZ5UW1BZmErK2FMSU1WaWZsdVpUQ054?=
 =?utf-8?B?MkNjTkFwQ1B6S1JSMWw2L3V6QUhLN2M5OEM0d0JZT0R3VjU1K3U0WUdlQWVK?=
 =?utf-8?B?bXNpcHJmRkx5dkgwY3pFK2x3U25XQTFHWXhRS2R6VkFzQ2oyS3VlUXpiMkFh?=
 =?utf-8?B?dEdpc2ZWREpONU5uY3VLaVZGM3JBSXdoUGpxdU5yVDN6RlduUzhOMEZhRDQ1?=
 =?utf-8?B?eXovMzNmL3Z4ZzR6NWtrdTYxejdXcTlCcGRLSzdtYXhZQzhrNVQ3S2Q5aVRX?=
 =?utf-8?B?czhSSzRLYzNISTIySjJtUStaR1pKekZhbER5eWFwVDVWcTlSenRwVzhiOGFG?=
 =?utf-8?B?Q2kzazJsWElFNWd4ckdwM2x1V3pPdGc2bm5IM25DaTE1V0VhNXlHMGoxdDdV?=
 =?utf-8?B?Vkt5VVBaUXdYbDI1REI2Y3RqU1I2RGlSTDFGWkN4TWFlMEtVU01vSTJOOGc4?=
 =?utf-8?B?RjdHNTNDdmpDTTY1RFgxMlI1a01JSEVJMnhIV3VVeWVYVWFtQmJReTY5L09I?=
 =?utf-8?B?K1hoT0I5UzRaMTk5OXRCMjQ0aG9xdVBmODl6N1UyNDVjUWM0Z0d1bDV5LzFF?=
 =?utf-8?B?VjVxNkg2bnA0U0lsckdhVE5ROHhyTG44bngwcDFCYncxYWVNQTFwZ1lEOUFL?=
 =?utf-8?B?d0dFM1NpSmQrT2RrQ3ZtOEpyT2o2RDcxSGZaK0QvQmVRRm5nN0c4T1hUOUJ2?=
 =?utf-8?B?aHVyS1hndUtIUS9LallnNHBCelAwWlJkNnVFUlZBK2hYRGN5eEdBSEtuekk5?=
 =?utf-8?B?YWs3dVcxaHZkOU5kem1KZHExVG91ZGx4WjBhT3Z0bXRuSjRWUjFjSFozbzNN?=
 =?utf-8?B?OVo5M0NvNHZMNnhPQisvOGpmK2lYZ3R0MjRMRHNNNGhhK1dqQkdFUnNiZHN2?=
 =?utf-8?B?T2IvcWRFZ3kxZXFBTmVyL0svcENwOEJVSWhiQ2gyU1YrM0tLZzN2ekwrVFJH?=
 =?utf-8?B?cHFrZUdBRGxtQmhVTEdVQ25lWFptU1kvQ1N1ajhwV1dMWVMwbnM2R05PSFhs?=
 =?utf-8?B?UEZDdHRWSGdVdnA3ODYvUHJRalc2MEM3UGpBUXhacWMyVUdybnpUMjNhSjBl?=
 =?utf-8?B?S2NWOVVjMVo0UVhPeTJ4L3ovVVRMMEZ0SFdieVRnYkxHb0g3M0R6T2Q4ZmNL?=
 =?utf-8?B?ZzM4NUJVVFFpUmtycjhldm12TUpXczcvVzFqRHV4NUQyemxnbU44QXk1OExp?=
 =?utf-8?B?RUwwZ2VkMjRaMjJQWXZhWHBHTjZib3Q4ZFozWUd6S2E5M2NNVWQ4ci92VVl5?=
 =?utf-8?B?cklvY2tJMnVNVFpoUld1ZUJObEZjSXJhaUdMQzhOUW4zUDY3eWE2Q0lIU0dH?=
 =?utf-8?B?SGhvM3Q0Wng2eUxyZ0JWMVhQS2lkVmw2eGk2ajFzSXh2KzZqKzZvd2h2cEVK?=
 =?utf-8?B?Uk1ITE5Ja3cyRFY2bWJGWitOazBhcno2V25qNnFlTkR1eWdvemhsQ1lhOU1k?=
 =?utf-8?B?R0cvd09ram9mVjNDQ0NFcm00OHd4TWM1WUwxcUFQdDNDR0s0cForU1RPbTZu?=
 =?utf-8?B?ZSthMVhUb1QrUHN6SEZTY3dESWtlMHZ1azBNZWpadzk0bUZWcit4Rm1OU2Jo?=
 =?utf-8?B?NHVidkxyNk12ZDJKcjhZZWFBZDlvRHBNdGkyVXFJa3NaSnovSEdLMk0zZUhI?=
 =?utf-8?B?MTZadmdxczdmT3hKQXZDUWNlajA5SVJINmJyRHduS1B1M2o1bGFGY2hHem5O?=
 =?utf-8?B?QmlLT3RpLzdjZFVZdXhLd1F5S1ZTMHRWS3JnNFpJekwrZVRXVVc3dzI0OStH?=
 =?utf-8?B?TTFBRW1xTnRidFZxdkQrMVdPaU9EYnJOMkptZnV4eUk0bjRFUFBJYXhIVW03?=
 =?utf-8?B?RkNNdWV0OVgxb2plTEJ0U1lVMkx6d1ZVYTlxVkJxa096RzViKzY3MHBWeTgx?=
 =?utf-8?B?OCtQdFpxaXFCeUV1M1U4L1lUQ1hNQzgvWUJHYWlKa29zZmZuUjJTNUxENnNq?=
 =?utf-8?Q?/wOvy1SqVZG/wmdcTA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <00C6091365371A4E8628585CA0288076@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de92fc76-a48f-4304-048e-08de8e71abd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 15:33:19.5703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e701d992-0f02-433e-a019-4256abe96ea1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PR60uyK1AUswrTemSZ6JFQYX/hGO/5ckOxSkKJPO/f2vssF3uFc2LoP6D4Il6gTs47gv8oy4yyE/MH1/yBBPIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10584

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
aC9zbXAuYw0KaW5kZXggYTlmYjliNTEzZDYuLjBlMjA0OTc5ODhlIDEwMDY0NA0KLS0tIGEvbmV0
L2JsdWV0b290aC9zbXAuYw0KKysrIGIvbmV0L2JsdWV0b290aC9zbXAuYw0KQEAgLTEwMTksMTAg
KzEwMTksNyBAQCBzdGF0aWMgdTggc21wX3JhbmRvbShzdHJ1Y3Qgc21wX2NoYW4gKnNtcCkNCiAN
CiAJCXNtcF9zMShzbXAtPnRrLCBzbXAtPnBybmQsIHNtcC0+cnJuZCwgc3RrKTsNCiANCi0JCWlm
IChoY29uLT5wZW5kaW5nX3NlY19sZXZlbCA9PSBCVF9TRUNVUklUWV9ISUdIKQ0KLQkJCWF1dGgg
PSAxOw0KLQkJZWxzZQ0KLQkJCWF1dGggPSAwOw0KKwkJYXV0aCA9IHRlc3RfYml0KFNNUF9GTEFH
X01JVE1fQVVUSCwgJnNtcC0+ZmxhZ3MpID8gMSA6IDA7DQogDQogCQkvKiBFdmVuIHRob3VnaCB0
aGVyZSdzIG5vIF9SRVNQT05ERVIgc3VmZml4IHRoaXMgaXMgdGhlDQogCQkgKiByZXNwb25kZXIg
U1RLIHdlJ3JlIGFkZGluZyBmb3IgbGF0ZXIgbG9va3VwICh0aGUgaW5pdGlhdG9yDQotLSANCjIu
NTAuMA0KDQoNCg==
