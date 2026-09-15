Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04E31ED7C;
	Tue, 15 Sep 2026 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458079; cv=fail; b=Fj0tzGMk2zohxoZsyFZxvHpYznTntWZNbD4SglBxZGP60z5GsZ2dkXddDjXe9Jq32MssIzhUgIZT44BSaElk9nsj+0ZxI+LGhfwcGLd0PKjV/517t7Cex/PbhYTnOK7pYJANHfEm6euLdWlzf6ctbwKnJEHa2vigtSvIA/VfsjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458079; c=relaxed/simple;
	bh=lyBz+TdL1yIyKEseuUozozHicGfP8jw16c+WrS+ijoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qrwjeZDuStYE9M/lQSCdC56j83ri4OXFrsfotA4ib1gqWh8kitInZ/RDAOPMGvAuqk+/3C7O0GYhjXURSMnTaR/+5eivOAKtFXKAidXwvvqyLhHVT8ynOdEW1coLARpdAVI2SFvo1lc6Vb9onBil+M+2lmNlWCoIlR6KouFmgGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O/JIJBEV; arc=fail smtp.client-ip=52.101.70.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O/JIJBEV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j2Fh+gBkMEROC31ReNzCP6zQ883lQJnqNVC2f5YgscqBcrgFVv8ts8Uw4bi9F4N3H7BpMdR3PKDGp+oc1TwU4EONA8VJYurV4q2mfqE60gPOovmvSBkyCemBRSoUzwvdTLDR03Tq+M5RbYG1dKk6fXEtyi9ldS1GfoP2902eiOClbK5H74x/pspNZes91JD6bx97ESPAvK9kPDuWwLJHtyyZdhA9+rFPJ99cVYUM1sc5FqoPWOLg0SUAPVasP/yCSNarr4iMNHYV7IFdfyF8GWdqUU080nH8Vatb4uDAvfn4vUTojm7r+lA4iZg1PpTu2bDP5W8tmJ2c3+l5+UBvmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyBz+TdL1yIyKEseuUozozHicGfP8jw16c+WrS+ijoM=;
 b=S9sryTNn8hyyANfmQSBJJyPHHKTee/lDaumkzhX+SI+LlEflMCPhWggJUrwZypJX3BmfsmpXJ2f/772dn7gvm8tpjWwS5TndCEZoh/Ihyvikr4D7iHSRSaCtXYQ4paSuqi+tE6OdxFSaz0rK0wzXqFY3izglWcSFH6PYh9h2MuEqbdbEmYkH5vojkml+jTzU59Ye5p5e2XXJz2/07YuRdJQmpM6OSWZtqP7eF8mLeJuTmDBs7ZfczFxMMmqJnYHl3H+C2ADHF31Cg6mSky9lskBPB2Ls7BL9rq9TOqf/MjRMSIF2KpDgtQimGLQe+IaR2QXqLvQALy157TNZgcFwIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyBz+TdL1yIyKEseuUozozHicGfP8jw16c+WrS+ijoM=;
 b=O/JIJBEVSJ05sl1gPQAIiQ8PmjAsLBSUGiQrT27/sRFkHmh62ZhxCtIsjkHSPBk2VaFR/oDOFyL9Ce5YLG+oSeV4E4VtjkuUhDasgfWWKtLdJnHDAaLFBcfu7Pzg3OGvGAJ7DWIjeWFlhlrwqFBDM0BVWi1bJiJAEjsvcNzC4BpreGU3mO1TYH5iKj/prNwEU+K++5+Na4KK4WgEuGxOkh5eECwFaeTJIawrRLCyXx5rrjBCI7z63YiARu65e3hdxi39Iqg44G5YoVXshkY84hcg7uhU0ZswCN2wylg/LJTtPJcY7MeAi7NS6Ix53f+9OHX8HyEDBV489ZOZdo3oBQ==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA3PR04MB11227.eurprd04.prod.outlook.com (2603:10a6:102:4ab::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.13; Tue, 15 Sep
 2026 07:41:11 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0406.012; Tue, 15 Sep 2026
 07:41:09 +0000
From: Neeraj Kale <neeraj.sanjaykale@nxp.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz
 Augusto von Dentz <luiz.dentz@gmail.com>
CC: Zijun Hu <zijun_hu@icloud.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Luiz Augusto von Dentz
	<luiz.von.dentz@intel.com>
Subject: [PATCH v2 2/2] Bluetooth: btnxpuart: Fix skb leak in
 nxp_process_fw_dump()
Thread-Topic: [PATCH v2 2/2] Bluetooth: btnxpuart: Fix skb leak in
 nxp_process_fw_dump()
Thread-Index: AQHdROWTmKopjOUGA0qj5624GWkwgQ==
Date: Tue, 15 Sep 2026 07:41:09 +0000
Message-ID:
 <AS4PR04MB96927952663AF7812B385EBBE7BA2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20260914-misc_fix-v2-0-6178d838c946@oss.qualcomm.com>
 <20260914-misc_fix-v2-2-6178d838c946@oss.qualcomm.com>
In-Reply-To: <20260914-misc_fix-v2-2-6178d838c946@oss.qualcomm.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-15T07:40:49.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|PA3PR04MB11227:EE_
x-ms-office365-filtering-correlation-id: be9a720e-6185-4a2b-7677-08df12fcb593
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|19092799006|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 LcHcaJ746C9qKC4BJIi5CCFQZkZIBp9Mchho2sAFNiuXr3Lz6PMw/00XOnqZjr9tXZwUEM0d4vZ7o9CouxKluO9H70v/dqIz6eNRg3oNN2xO7TRpWzUgezR0DRgnJrMDWLtSHAvWConbwE1oIff2CKQqx6TU5DU6ZNlObBmQZrWJetPps0saIC7CoAWqC7YznXxOQ1ITSQDYG/AwYrl539CBQZVHuCPX1U3KYOLtHCXTaI88hsg+S/w4hfWedxedI6GKHsp2wcx9kZiv6ebcviKjfsiM1agaSNDkI0QFILuGeO1KwDoolJnUpV0DJC/JAPuofWWZ+up/5ScUbusx/baTibk9wEBQD1iFrHOxtiaDlyH3vD0oCsEDse0Hegu95XYeKX3Foryorxk7gleymtKhSywtXLupgGtMy5wrZjGOwCuLU3uCh/QST5Qn7+k9AEpR9gP2Cd3LJMSs0AHHSrnCbaU7WpbzMTcXOieV1T9v6KaSQdKcc5Qfkl5EwcfzY7DadPp689gGsMwlxIXNEwUlXvrF+tyyF012uvq0yRml+UUQUYlE99hUTGIYhac2ulmZ08gNhe9DKRj6LkM/rvlrTlojdEJgKOKmVBPnhd6IXem0P42YoCGO6nag0sPwaaiRM8J4m7XwReBYKTSGC4kHONFH3Hd5HjVx8SG7PtHPPeJCbIzxyHDOd3gS9i4iawU+exkfz4HZomJdnKAyPGSEdTfToJywi/sfVszLGWU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(19092799006)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OTE1V0dpa1lieFh5OXlBSVNTcGZYc1R2Mm03c1NqNzkvYk5XMHhsejdsU3Uz?=
 =?utf-8?B?Q3Q3ZXFnTFoxbDhlTmdwT0hQYnNzOHJsdmtCOUg2b3hYT1U0Njl0UC84STFm?=
 =?utf-8?B?cE1tOVd0R2haRzRCdHJvRWdQa21mVnd2dlZFbSsxS3BFRTNKMzZ0UFhwQ1RS?=
 =?utf-8?B?cGRubVV1WDNmdVFyQ0N2MjZRbFZQMHA1SHpyZ216aXRnSm0wZ25WclJJaEpC?=
 =?utf-8?B?Q3cxK1pTZjFBRW1TSUZhdkFBcmZ3elMzL1RzMW1nTFdYa290Tk1rQkpSTW04?=
 =?utf-8?B?RzhMTHBYTGVTWnBPZkVJalRjVTVkTGwwejM1bThqOTM0Z1VZZ2dEUWo0WVla?=
 =?utf-8?B?TDhTcElhMm5wNUJzSHpHSzZFZmJzc05pR2s3a2pvMlN4aEFYNTJxaTR2UTRU?=
 =?utf-8?B?bXNlVkFwenlsWkE0ODVYWGVZL2tUdFZkbUUxd21yOWVVY3BMMUUya2JQMjRa?=
 =?utf-8?B?WlpzemVibi9jRXg5a1NuZm5KNHBXY1lhU0wzL3ptRm1VNjd4RThKUDkzalZW?=
 =?utf-8?B?RUhpdVZRcWZKUlpjOHc2V0NGTVQvWXRTYWxMUnhNYVg1UHdhZXA5WFN4MXB1?=
 =?utf-8?B?VjM0QkllZEFiQjR3N0gvRk9KRVpWOXZIVnRpUFEyUXFoZ292VGVlNk9SbWF4?=
 =?utf-8?B?TjAxbXRCZmx5RCt6YkxJWnNPZWdiRWY0R0h3UENTRlEyN0ExaVJpS3Q5N2xy?=
 =?utf-8?B?LzJhNHUrSXJYVEpCS2NlcmFuVlhMcXl6S3BTNW15OEFhODdZVlRaaGYwY3Nl?=
 =?utf-8?B?YjZVejBtVThhb2VZdndURi9UaExUWkFSWVh3aXJoRm5oOGJyd0NRTTBCSmFY?=
 =?utf-8?B?R3ZJdmMvL3Jxa3IwY2FVZHZQVk9oNHpzbVZ0cCtEOCtvSlhYOG1OY2swaVRj?=
 =?utf-8?B?aW5tVmZVZ2JpZnVxQjZZTnc5eHlKVE00Rk5Ja1RWZSt0YmRXYnpEZk8zbnF1?=
 =?utf-8?B?RUY4YlUySnhlY0pJc0ZsQld6TS9aekE2VGZTSnExeTcxUTNSTzlvc3JDaVlz?=
 =?utf-8?B?eTBuMGZrenhldFBHNDhyMW10ZU0rOU1FR1ZrbnhUbHZxWFFRNlYzc0VqcTdn?=
 =?utf-8?B?WktFb3g2MEVVa3U5NWtIUWppdUtyUGFvT3A3bzR4RXUvMlMxV21oNHhRUGdz?=
 =?utf-8?B?Q1FjM2tTSm9Wa0FIdTNHK2FNYjdGbTdtRDFzNG9vOGJGZ2k1a05KaDZmOWhm?=
 =?utf-8?B?OFRGTTE3MnZkN2xzUzN2WkJ4QllQRVQrUXhDMUsxQ3h2d1hsdTFQZFhDZGZR?=
 =?utf-8?B?S3hBRk81cjZ2QVFXR2N1aE5BY3dhV2loeithV3UvbkN5dytDYlAzLzJ1OEVQ?=
 =?utf-8?B?NkpZNjRWUlNCNGRTd3l6SU1YYWJNZHg3TktmdnZLVTd4aU5zMGdoZnE5cHlS?=
 =?utf-8?B?OWhvOEdObVoxYmp1clhjbnBpVGtwYnoyc2o5TWhjZ1NGWnhmRFBoTEQ5UVVQ?=
 =?utf-8?B?azkzQVFyUjNJSlMvMU1MWFJJazFMemI4Z1U1eS9oTHNFNllZUC81RW9VdU5q?=
 =?utf-8?B?Z3hVTWYvUVl0TUE3b3d4OUtTclBTVmhSVUtyKzdjdXRaVGZYTDVSZVBuTEZu?=
 =?utf-8?B?NldMTlp6K1l3c24yc2tzdWUzbEVJUE1DM1cvYXhaSXZpWkhvb3BPWG9IN0Rt?=
 =?utf-8?B?VUx1ZUJGT2poODBFTDFzR0dZZ3hkS1ZjMHVyQnNrU2x6SUlOK1AzZUdRS24x?=
 =?utf-8?B?aDg3MzltazNoNGkySkkyZDJyT3pycFFvNkZ6bkV6OVRJWTNSNVJiVU1UaFRV?=
 =?utf-8?B?dElvR0dUOEp4Q0tGakE2Z3FQKzRodEI4bC9GQWJKUXJHSlphTGtQa3liWENo?=
 =?utf-8?B?QWNBaHMwTGNBQ3pvQWxsYTFTdzN3ZFEyVktaTlJxa1QyY050QnpPMGpMYkZh?=
 =?utf-8?B?MUxwUG4xNFFJeElxSjRPWGVQNHdxZElYUzlJUHBHRXo4cnZEOVh4ZGNaWVpp?=
 =?utf-8?B?bWhGbmZseG5lOXlxMDJodWt1ZnJwTWFLZUs2SEIzQi9POHBIRGRFa0VHNUxa?=
 =?utf-8?B?WXdBWlgzRzFqaE1nN0lnOHFacWhwQmd5QTY2OGZNL2F0ZlhuSXh1Q09QNWNm?=
 =?utf-8?B?NStaV3BXUnlmcFdxc1JxcmZEZFh2c3FtU1hua01ZT01YMDBTV1dmVThFelV3?=
 =?utf-8?B?NWdEaVZ6Y3VhTmVLSVYwZ1VaRG5IRU1TY1pkMmpBdFg5VVhwOGZzblNVdVNs?=
 =?utf-8?B?SUs1UzFMVS9kRVBQdEF4Qkx6bG9Zc3A1QnIvTFl1SmxjZ0ZaTVZHUHc3eElR?=
 =?utf-8?B?WkdISG13NDFNNVRZME53Y0I1V3hzbGZQK0FEK0F5MVFGMmZldE1BL2dOd1Zk?=
 =?utf-8?B?SEhJWEsvdGtyK2N0SjJRMmxIbUNRKzM3VUVxaFVOOU00eitFVE92Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9a720e-6185-4a2b-7677-08df12fcb593
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 07:41:09.7017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FZvjL95pDEkrpGJH+axTY1GeMotB6r8xiJfAYLT6Fn6X767/HowPuY9mLi6rFcSnFRhIy1dULCXcvWFIhFt3TnFauT6QWgxRfwgpdqIL4dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11227

SGkgWmlqdW4sDQoNClRoYW5rIHlvdSBmb3IgdGhlIHBhdGNoLiBUaGUgZml4IGxvb2tzIGdvb2Qg
dG8gbWUuDQoNClJldmlld2VkLWJ5OiBOZWVyYWogU2FuamF5IEthbGUgbmVlcmFqLnNhbmpheWth
bGVAbnhwLmNvbQ0KDQpUaGFua3MsDQpOZWVyYWoNCg0KPiBXaGVuIENPTkZJR19ERVZfQ09SRURV
TVA9biwgaGNpX2RldmNkX2FwcGVuZCgpIHJldHVybnMgLQ0KPiBFT1BOT1RTVVBQIHdpdGhvdXQg
ZnJlZWluZyBpdHMgc2tiIGFyZ3VtZW50LiBUaGlzIGxlYWtzIHRoZSBjbG9uZWQgc2tiIGFuZA0K
PiBhbHNvIHByZXZlbnRzIG54cF9zZXRfaW5kX3Jlc2V0KCkgZnJvbSBiZWluZyBjYWxsZWQgdG8g
cGVyZm9ybSByZWNvdmVyeS4NCj4NCj4gRml4IGJ5IGd1YXJkaW5nIGhjaV9kZXZjZF9hcHBlbmQo
aGRldiwgc2tiX2Nsb25lKHNrYiwgR0ZQX0FUT01JQykpIHdpdGgNCj4gQ09ORklHX0RFVl9DT1JF
RFVNUC4NCj4NCj4gRml4ZXM6IDk5OGU0NDdmNDQzZiAoIkJsdWV0b290aDogYnRueHB1YXJ0OiBB
ZGQgc3VwcG9ydCBmb3IgSENJIGNvcmVkdW1wDQo+IGZlYXR1cmUiKQ0KPiBTaWduZWQtb2ZmLWJ5
OiBaaWp1biBIdSA8emlqdW4uaHVAb3NzLnF1YWxjb21tLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L2JsdWV0b290aC9idG54cHVhcnQuYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5j
IGIvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gaW5kZXggNjllODk3NDQ0MTEyLi5h
MGI2NGZkY2JjYzEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5j
DQo+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bnhwdWFydC5jDQo+IEBAIC0xMzgzLDE5ICsx
MzgzLDIxIEBAIHN0YXRpYyBpbnQgbnhwX3Byb2Nlc3NfZndfZHVtcChzdHJ1Y3QgaGNpX2Rldg0K
PiAqaGRldiwgc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4gICAgICAgICAgICAgICAgIGVyciA9IGhj
aV9kZXZjZF9pbml0KGhkZXYsIE5YUF9GV19EVU1QX1NJWkUpOw0KPiAgICAgICAgICAgICAgICAg
aWYgKGVyciA8IDApDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9za2I7DQo+
DQo+ICAgICAgICAgICAgICAgICBzY2hlZHVsZV9kZWxheWVkX3dvcmsoJmhkZXYtPmR1bXAuZHVt
cF90aW1lb3V0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZWNz
X3RvX2ppZmZpZXMoMjAwMDApKTsNCj4gICAgICAgICB9DQo+DQo+ICsjaWZkZWYgQ09ORklHX0RF
Vl9DT1JFRFVNUA0KPiAgICAgICAgIGVyciA9IGhjaV9kZXZjZF9hcHBlbmQoaGRldiwgc2tiX2Ns
b25lKHNrYiwgR0ZQX0FUT01JQykpOw0KPiAgICAgICAgIGlmIChlcnIgPCAwKQ0KPiAgICAgICAg
ICAgICAgICAgZ290byBmcmVlX3NrYjsNCj4gKyNlbmRpZg0KPg0KPiAgICAgICAgIGlmIChidWZf
bGVuID09IDApIHsNCj4gICAgICAgICAgICAgICAgIGJ0X2Rldl93YXJuKGhkZXYsICI9PT09IEZX
IGR1bXAgY29tcGxldGUgPT09Iik7DQo+ICAgICAgICAgICAgICAgICBoY2lfZGV2Y2RfY29tcGxl
dGUoaGRldik7DQo+ICAgICAgICAgICAgICAgICBueHBfc2V0X2luZF9yZXNldChoZGV2LCBOVUxM
KTsNCj4gICAgICAgICB9DQo+DQo+ICBmcmVlX3NrYjoNCj4NCj4gLS0NCj4gMi4zNC4xDQoNCg0K
TlhQIENvbmZpZGVudGlhbA0K
