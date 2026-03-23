Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013005.outbound.protection.outlook.com [40.107.159.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11B3A63EF
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2026 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774269345; cv=fail; b=c+f/8hl24IowPqsVkFDW8mAv/M29q4WLnXkX8BCKsdm/TtUboQ3Hdwr11K2OhI7O3z9sRTFW3y6vlwQ/2dKMAWLj9/FhOiNgw4MGiThZNJUj24Ock1BZDPNRvx+00uKFnJjlAumC6Cyt45rLrLMogamMI91SbbmcRRSml7A9vTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774269345; c=relaxed/simple;
	bh=RSGGbGHxhu/5nKR8XmhTWPsYLEFHwRb4pRD/ZZfj8XM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DDc+qnsXi2bgo1OzuDITE9gBsRw2Uj0GxMntjlMlpkM3dPWycMZSkfsmnTCakTDqsaVmVtHQ737IVyI2nHFW2cjdz0scoedDcZNFChZq8T5wtdPkCHa9D7DZew11hNRRImnIlzxczpCqH5AyIwQ1CgJiWfxOqiXKf2Z9hPnlsMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N/QsTeYZ; arc=fail smtp.client-ip=40.107.159.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N/QsTeYZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkJPSFPAs6lZrW7nKqiyyVVcnfKhC40ivmuDJ0MEP+/5yyMh6r7zv1lcGwZLWWCnEIhPkn/pnvLY4oVOaMw6NonT+O7RRDBBGpjUIFKdEP/dr7FEv8SDf0nwXzILnbjrjntVGBii4fKf2aIVaVmnNQ2xo9q4o6DnF+8lvGvbrp0A1fxuC7W9+dhaQmNU67XccFJSmUi2E0EK+MVB6ZJBondOG4ZN7bU2Kk11sVSbYxLkfrTexvMp73Z+YMT+2CxjtbgfWWyhGoLWSwa/w9l/fFNBIYvFhknQ1FuwZbzzJNMuuRD7pwsnnVbm3r/h1b+yEMSXIUYuax+0QJEtLmhtvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RSGGbGHxhu/5nKR8XmhTWPsYLEFHwRb4pRD/ZZfj8XM=;
 b=BkcN0LQylL/1oA9p9GYQMnH/H9Qc3Q6R+HdSj2FOaFur4lMuDNGCMrcNIthsns25MU0lANGQ/aje0pSYpzNqSvor9DCkye7PgeRD0ulCaKT5jRpJLdGl2agAl4wRX4isoOhH2A1MjutYAkceGj48Z5lnxSiFD3UVgdvkKRE6JyFlprjspZY7cPXXdIevuCeVcfYP9ZiZRE7hNPbP9hHCnXderrPPJhs1bgNyU8xtHPEX+3DpQ3AwexSsR94qsNjqiVDdT5jmk2jID/JkLsTb9lLbFD7tXON1i+eT41HetM2cqpFNtopND40eAp3OWKsvOwYsEmXpH+KvrKuGXhneSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RSGGbGHxhu/5nKR8XmhTWPsYLEFHwRb4pRD/ZZfj8XM=;
 b=N/QsTeYZx50ueFtW1FMuCFyLMSexa0WeaX7/5XB7+m75r3XulpdphKp5FGQUILuIPZ+mRaofr/o0uqA3dVIicyQqYZwQDyn1BQmtZ47YUtHtvodlnou6ctxh2gd9F6z8Q5Cmle/b/ivhTy446IN/cSWzlv3ZBwzjVXt3ImHGgyy6lrIOG88X6HAibtzZF4QUDdicw8xux8ke3gYBe/1SBGjE04P8SC1NJ7Arc/yVSlqjRSt9AL6evwjXrwE2CqcBEWjbVPRMo6B4E4B/w/YGiVeZB876HMt+wwbMYYzFp3rkDC7VZKzhBmJD74ocIHbxRkX/9p4jsBQXGQTdxMDMFQ==
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15) by AM7PR04MB7192.eurprd04.prod.outlook.com
 (2603:10a6:20b:11e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 23 Mar
 2026 12:35:38 +0000
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8]) by GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8%5]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 12:35:12 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "luiz.von.dentz@intel.com" <luiz.von.dentz@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Vinit
 Mehta <vinit.mehta@nxp.com>, Devyani Godbole <devyani.godbole@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v1 1/1] test: Fix pbap-client to work with
 system bus obexd
Thread-Topic: [EXT] Re: [PATCH BlueZ v1 1/1] test: Fix pbap-client to work
 with system bus obexd
Thread-Index: AQHcuH0NjJwH/iyWc069axIoWrvdFLW3t2yAgARaNCA=
Date: Mon, 23 Mar 2026 12:35:12 +0000
Message-ID:
 <GV2PR04MB12191ED7BE594E774D9D163DB934BA@GV2PR04MB12191.eurprd04.prod.outlook.com>
References: <20260320151958.851-1-sarveshwar.bajaj@nxp.com>
 <20260320151958.851-2-sarveshwar.bajaj@nxp.com>
 <CABBYNZJyr3-J1pVj_kGWLjjPn1_tYNhkYY9wEoahY-8s2kdWVw@mail.gmail.com>
In-Reply-To:
 <CABBYNZJyr3-J1pVj_kGWLjjPn1_tYNhkYY9wEoahY-8s2kdWVw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: luiz.dentz@gmail.com
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB12191:EE_|AM7PR04MB7192:EE_
x-ms-office365-filtering-correlation-id: 1a8e5785-1c26-4b76-92e1-08de88d8a0f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|56012099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 UFn4YmZZVMs6dhcG44TbmKY80RR9s0IQ2BqntR9z/YRYBhIyhu5+ncr4gHj8POJV5ocXo3zOvfYZSBoxSiPkiCCffmv/GR1veq5VDIh6BcJpqmnOZNiNYAyEDauj1tWSR0Vw3RCIgYujY7nuTdatQCzoeaLkxsGj56Gq1dt+WeQo0OOEHVvuGz6urlxg38vIVjapj5UUlVV/oUqGGwRgiOXH1hn5DhMIgOLj9N+xn8JA6qnskju1T1MrEyPZNQhSWUM0lU4njtfUZ3n+f4tw2jTmMxAITAcDeGcMB16YMfTWcq79opbFgLY1qZ/rHfIppjQ55oYQDzBnE1Bkuc7Wb8q+U+pbVWZYToaTbzoDPTnoXBWQfbJ5qQPPP9JjMjFpf/iS7wd1mkbVNSmtLik9m8yMU5YzqEN49vY5A5hwsLuEe+z/5g3UPk6RQL/PXkypP146Q2OYxH5qProP14Jj5/IRfwaA8PX6JRYCkF43HHFcwxCmbbPkaICzCaA6/HT/xbU49YHNDnnultI6uRtl7xU4hcWe+tkdu0q1ryICGFEJY09iA8d+04pi6tuc+nFCEMTZd1YyHxtEBOs7UI7vh7WaIqX/omNCGAbWAuNY4N4Oh6NdYp3eEKDnKTrjTNbkf/bQAAL+yWWwYynBA4s8bitrm/NTPncTp5oxP4Udc2LgBmhx0nnI/FFoPvzTOOq5NcH+K8JUCfT7Kmqm9uPejQXiByipT4yMsjT8lfKMzCyCJDY862jG9hVlWcvaS3X89sRX4QwndHMciD9coQCx+7jFgdw60FBsHN63k8R7scs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12191.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(56012099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VitjRGtWWUpNbUQ2Q1dmWks5a2hkZSs2ZDBILzZ1eHpJczFTZk54VXJjM1BM?=
 =?utf-8?B?aE1BNTNyTEdmb3ZCdE1LbXZZRm1JdW1la1c5UnpDNmNQclc1Qk81eGQ4OXZV?=
 =?utf-8?B?eC9sOHhvOHkrdnFiTVh1N2Q1ZzBJOWJzR1hENVFaU1ExS1NockQvSDc0N0pI?=
 =?utf-8?B?YnZQYnJvVGxaZW43M0RPNVZZVW1JYnl3Z0R2Z2lVQkxQZzFRdW80Kyt4c0VH?=
 =?utf-8?B?YWRaa3VGWmtHWE82ZHVGdUZtVkJKTU03UjJyajFNcWkxUENsSFdmcjVYRzJQ?=
 =?utf-8?B?VlJwaGxESkJvZ1k0aElsRmRmWG9SQXBVaERVUGhZbnFFZGZoeWtqanhpUFdK?=
 =?utf-8?B?TElWQUJPRzhkc1dmV3VIbzdmdnRVeDZXMnlJTHg4YWtDYi9GVG95WEw2bXI5?=
 =?utf-8?B?eEE4VHVsQXA2NVVQSW1YQWxrKzhrd2trK1A4d1RKd1NxTUtablhGamJIWGVV?=
 =?utf-8?B?M1FKOFY3aXZ3ejZnSlZQL0kydGhsa1FSWWFhK3RSYWJSMjFJYjJubU1KOUha?=
 =?utf-8?B?Qm9hWlgwclg3TFpkdVAzMTQycjRIRTlFYnN5VFltRERzREFGZTZFZXpycnRR?=
 =?utf-8?B?V2lzVXk1bkhEcmlES3F6QUZ6YWQwR1RpNXR3UzFuNWkrd3Y2WkRDTmo2OHRt?=
 =?utf-8?B?VzR4dWdudzVlK3lIMkJtZnAwd1RNSm9xcll2UEQra0xxR0VEYURoUG8yOFJs?=
 =?utf-8?B?MFVQNFRSN2dkT0dNS1FKVkx0YVJ3NUNtOVY1TkpIbGpkTFJ2dzNRdzRjUHBs?=
 =?utf-8?B?M0NzamxhODFZQWIxTGhZZnFFRnlHRVVNSEViSU5YaDk4R0lvRHFtU1U4bEtz?=
 =?utf-8?B?L1JWSU0yWHVLUU1tWVNPaFhKTnJ2VHplemx0SEpERU1wZGI2a294aFQrV3dV?=
 =?utf-8?B?bGFhc2ZoNzNiSWlaRWIzVUVINlhRQnVoMnFwbDZxTXc1cllxTElDeE1vT096?=
 =?utf-8?B?bXpQeW9UTjNlbnlOR3dOeDZUQUVmS2wrakdiS3ZSSHFaN3I5MHFJdmlVUmlK?=
 =?utf-8?B?YzV2Rlp3ZEh4UWhxTHAxYkpReVFuaVZVc2xta3U3bUNEdEE5NVVKdHVPYXF2?=
 =?utf-8?B?akV1L05ZNExpL3JIeC9wcCsxK283WUkxTGJjam1GVXBNREdkUEdFaDBoZHM5?=
 =?utf-8?B?dlRIV2k5NU5neDhXc2JIWml2SWttWXBWRGgySGd4VzliUzJiS1RmQzNBTExN?=
 =?utf-8?B?VWtJblpsYmdiMmg3RUFHWVBUS01BNTVaWkFCZlUzNm5zM0dDbDFBYTgvcG9a?=
 =?utf-8?B?RTBUV3VreEpuUmpkclNHZTNqTXhiZTkzZzVqRmRXcXU0Ym4rUFNINi80UGZD?=
 =?utf-8?B?bXJSOEwrejNERERpc0dEakNWU3lnbFNvWTBjZWwwWHord20zMDNXS01mOE1U?=
 =?utf-8?B?N1k3cU9aY21mUkJ0R3FTTER0SEYzZ1dnM3hGRXZOeFp3WlQzbWFKaWtRalBy?=
 =?utf-8?B?ckhEVTEyaGJwREl0Tm5VczVUa0xuZytVWVBmSU91TDBtbXdTaWQvYUNPQjVl?=
 =?utf-8?B?elBvUUVyNW9kRHRQcFlMQno3OHVySEZjbkxGZlhjRVZtRGQ5NVpmKys1Tnhr?=
 =?utf-8?B?Vkw0VVh6dDkwZVU2bmdib1hhTXorNFpjZHJJVWEvQy83VVh3cGljamJsNUlN?=
 =?utf-8?B?VmNKNTBHczZWYW5wSmVweUp0RXFNWWpPTDQ4TXgzc0hrbjFFRk40Y3dCalNk?=
 =?utf-8?B?bkxhMFl4WWxCRjJUamxIaTA4amQ2U3BKVkpSaE9KWGVNbmxaVk5abURFMnNK?=
 =?utf-8?B?bjhBSEY4aEhDblBmNVlIOUxpblc4ZklHTmNKZzdVdHZaS3BkTWJDbnI3a3pG?=
 =?utf-8?B?ckY3emNUS2c5RVVGMysyV2RUeHo4WVI3UzlYcktzd2Y2RXRQSXpOZkxLSFhE?=
 =?utf-8?B?UURXRUl4MXprdUQyS1BlT3BrdlZQbDh2NExTYm14bDdVVmRIUDF6YlJWT0lP?=
 =?utf-8?B?OGJwTVJXUUI4dkFUTDNteWNPSUVOUTg1RXVqT29BL1lGams1OFUraUcwS2U4?=
 =?utf-8?B?c0xHdCtsUS83cWtyV2F3QTBFUVlmMlkxUUdtQzhSVENvQnVBTmt0UlpoTXFW?=
 =?utf-8?B?Qmx3Vk5SblZzMGF1a0t1R1Vka1h5YkJDRGZDUzB3QVZDb0E1VlNCMzBJb2ZO?=
 =?utf-8?B?K0F5cDBKbndMMGhSSVBScVM5ZlJ5YVd5a21TZkE0Q25KaHJEUDhhZEVsVWd4?=
 =?utf-8?B?RVhENWdWNGVzUnlQZkppMFdLUFdQMzhPTS9GdzdZZUJTVTJraGdwVHFvalFQ?=
 =?utf-8?B?UVhPNDhCbmxSUFQ3bUdlMFJOOTdrRER2L0VZRmZZVW9KVk1HRzBPZC81U1Bz?=
 =?utf-8?B?UzkzZDVtMFp6dDl4dGM4UVFLNk42TW00Q0VENVFqNGh2dE9lYmExdz09?=
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
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12191.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8e5785-1c26-4b76-92e1-08de88d8a0f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 12:35:12.6521
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xDuThFwEwKZclIJfFDIcLQPdDlOAcjAKcu+FmuqSCXHfE24lxUv0aRiru+9bWgbLQjtmEC5AddKolkilwhUKzgKCdLuquocSdLKsYncoGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7192

SGkgQEx1aXosDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQpBZnRlciBjb21taXQgNzY1
MzU2ZTgwMjYyICjigJxvYmV4ZDogVW5yZWdpc3RlciBwcm9maWxlcyB3aGVuIHRoZSB1c2VyIGlz
IGluYWN0aXZl4oCdKSwgb2JleGQgb3BlcmF0ZXMgZXhjbHVzaXZlbHkgb24gdGhlIHN5c3RlbSBi
dXMsIGFuZCBzZXNzaW9uIGJ1cyBtb2RlIGlzIG5vIGxvbmdlciBzdXBwb3J0ZWQuIEJlY2F1c2Ug
b2YgdGhpcywgcGJhcCBjbGllbnQgdGVzdCBzY3JpcHQgbXVzdCBhbHNvIHVzZSB0aGUgc3lzdGVt
IGJ1cyB0byBmdW5jdGlvbiBjb3JyZWN0bHkgd2l0aCBtb2Rlcm4gYmx1ZXouDQoNCldoaWxlIG9i
ZXhjdGwgaXMgaW5kZWVkIHByZWZlcnJlZCB0b29sIGZvciBQQkFQLCB0aGUgc2FtZSBvcGVyYXRp
b25zIGNhbiBiZSBwZXJmb3JtZWQgdGhyb3VnaDoNCm9iZXhjdGwNCltvYmV4Y3RsXSMgY29ubmVj
dCA8ZGV2aWNlPiBwYmFwDQpbb2JleGN0bF0jIHNlbGVjdCBpbnQgcGINCltvYmV4Y3RsXSMgbHMN
CltvYmV4Y3RsXSMgY3AgPHNvdXJjZSBmaWxlPiA8ZGVzdGluYXRpb24gZmlsZT4NCg0KR2l2ZW4g
dGhhdCBzZXZlcmFsIHNjcmlwdHMgdW5kZXIgdGVzdC8gb3ZlcmxhcCB3aXRoIG9iZXhjdGwgZnVu
Y3Rpb25hbGl0eSwgaXQgbWF5IGJlIHdvcnRoIHJldmlld2luZyB3aGV0aGVyIHRoZXNlIHNjcmlw
dHMgc2hvdWxkIGJlIGtlcHQgYXMgRCBCdXMgZXhhbXBsZXMsIG1hcmtlZCBhcyBkZXByZWNhdGVk
IG9yIHJlbW92ZWQgYWx0b2dldGhlci4NCg0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4gDQpT
ZW50OiAyMCBNYXJjaCAyMDI2IDIzOjM2DQpUbzogU2FydmVzaHdhciBCYWphaiA8c2FydmVzaHdh
ci5iYWphakBueHAuY29tPg0KQ2M6IGx1aXoudm9uLmRlbnR6QGludGVsLmNvbTsgbGludXgtYmx1
ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgVmluaXQgTWVodGEgPHZpbml0Lm1laHRhQG54cC5jb20+
OyBEZXZ5YW5pIEdvZGJvbGUgPGRldnlhbmkuZ29kYm9sZUBueHAuY29tPg0KU3ViamVjdDogW0VY
VF0gUmU6IFtQQVRDSCBCbHVlWiB2MSAxLzFdIHRlc3Q6IEZpeCBwYmFwLWNsaWVudCB0byB3b3Jr
IHdpdGggc3lzdGVtIGJ1cyBvYmV4ZA0KDQpDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVt
YWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRh
Y2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVw
b3J0IHRoaXMgZW1haWwnIGJ1dHRvbg0KDQoNCkhpIFNhcnZlc2h3YXIsDQoNCk9uIEZyaSwgTWFy
IDIwLCAyMDI2IGF0IDExOjM34oCvQU0gU2FydmVzaHdhciBCYWphaiA8c2FydmVzaHdhci5iYWph
akBueHAuY29tPiB3cm90ZToNCj4NCj4gY29tbWl0IDc2NTM1NmU4MDI2MiAoIm9iZXhkOiBVbnJl
Z2lzdGVyIHByb2ZpbGVzIHdoZW4gdGhlIHVzZXIgaXMNCj4gaW5hY3RpdmUiKSBhZGRlZCBzdXBw
b3J0IGZvciBydW5uaW5nIG9iZXhkIG9uIHRoZSBzeXN0ZW0gYnVzIHdpdGggDQo+IC0tc3lzdGVt
LWJ1cyBmbGFnLiBIb3dldmVyLCB0ZXN0L3BiYXAtY2xpZW50IHdhcyBub3QgdXBkYXRlZCB0byBt
YXRjaCANCj4gdGhpcyBjaGFuZ2UuDQo+DQo+IEFzIGEgcmVzdWx0LCBwYmFwLWNsaWVudCBmYWls
cyB3aGVuIG9iZXhkIHJ1bnMgb24gdGhlIHN5c3RlbSBidXMgYW5kIA0KPiBwcmludHMgYSBOb1Jl
cGx5IGVycm9yIGR1ZSB0byBjb25uZWN0aW5nIG92ZXIgdGhlIHNlc3Npb24gYnVzIGluc3RlYWQg
DQo+IG9mIHRoZSBzeXN0ZW0gYnVzLg0KPg0KPiBGaXggYnkgc3dpdGNoaW5nIGRidXMuU2Vzc2lv
bkJ1cygpIHRvIGRidXMuU3lzdGVtQnVzKCkgYW5kIHJlcGxhY2luZyANCj4gZGVwcmVjYXRlZCBH
T2JqZWN0Lk1haW5Mb29wIHdpdGggR0xpYi5NYWluTG9vcCBhbmQgcmVtb3ZpbmcgdGhlIGxlZ2Fj
eSANCj4gR09iamVjdCBpbXBvcnQgZmFsbGJhY2suDQo+DQo+IFRlc3RlZCB3aXRoIG9iZXhkIHJ1
bm5pbmcgd2l0aCAtLXN5c3RlbS1idXMgYW5kIHdpdGggYSBwYWlyZWQgDQo+IEJsdWV0b290aCBk
ZXZpY2UuDQo+IC0tLQ0KPiAgdGVzdC9wYmFwLWNsaWVudCB8IDEyICsrKystLS0tLS0tLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4NCj4gZGlm
ZiAtLWdpdCBhL3Rlc3QvcGJhcC1jbGllbnQgYi90ZXN0L3BiYXAtY2xpZW50IGluZGV4IA0KPiA2
ZGFkYTRhMTEuLjRmZjMwMTA1OSAxMDA3NTUNCj4gLS0tIGEvdGVzdC9wYmFwLWNsaWVudA0KPiAr
KysgYi90ZXN0L3BiYXAtY2xpZW50DQo+IEBAIC04LDEwICs4LDcgQEAgaW1wb3J0IHN5cw0KPiAg
aW1wb3J0IGRidXMNCj4gIGltcG9ydCBkYnVzLnNlcnZpY2UNCj4gIGltcG9ydCBkYnVzLm1haW5s
b29wLmdsaWINCj4gLXRyeToNCj4gLSAgZnJvbSBnaS5yZXBvc2l0b3J5IGltcG9ydCBHT2JqZWN0
DQo+IC1leGNlcHQgSW1wb3J0RXJyb3I6DQo+IC0gIGltcG9ydCBnb2JqZWN0IGFzIEdPYmplY3QN
Cj4gK2Zyb20gZ2kucmVwb3NpdG9yeSBpbXBvcnQgR0xpYg0KPg0KPiAgQlVTX05BTUU9J29yZy5i
bHVlei5vYmV4Jw0KPiAgUEFUSCA9ICcvb3JnL2JsdWV6L29iZXgnDQo+IEBAIC0zMSw3ICsyOCw3
IEBAIGNsYXNzIFBiYXBDbGllbnQ6DQo+ICAgICAgICAgICAgICAgICBzZWxmLnRyYW5zZmVycyA9
IDANCj4gICAgICAgICAgICAgICAgIHNlbGYucHJvcHMgPSBkaWN0KCkNCj4gICAgICAgICAgICAg
ICAgIHNlbGYuZmx1c2hfZnVuYyA9IE5vbmUNCj4gLSAgICAgICAgICAgICAgIGJ1cyA9IGRidXMu
U2Vzc2lvbkJ1cygpDQo+ICsgICAgICAgICAgICAgICBidXMgPSBkYnVzLlN5c3RlbUJ1cygpDQoN
CkFyZSB0aGVzZSB0ZXN0cyBzdXBwb3NlZCB0byB3b3JrIG9ubHkgb3ZlciBzeXN0ZW0gYnVzIHRo
b3VnaD8gUGVyaGFwcyB3ZSBzaG91bGQgYXR0ZW1wdCB0byBkZXRlY3QgaXQgc29tZWhvdywgb3Ig
YWN0dWFsbHkgZGVwcmVjYXRlIHBiYXAtY2xpZW50IHNpbmNlIG9iZXhjdGwgY2FuIHByb2JsYWJs
eSBkbyB0aGUgc2FtZSB0aGluZyB3aXRoIGEgc2NyaXB0IG9yIHNvbWV0aGluZy4NCg0KPiAgICAg
ICAgICAgICAgICAgb2JqID0gYnVzLmdldF9vYmplY3QoQlVTX05BTUUsIHNlc3Npb25fcGF0aCkN
Cj4gICAgICAgICAgICAgICAgIHNlbGYuc2Vzc2lvbiA9IGRidXMuSW50ZXJmYWNlKG9iaiwgU0VT
U0lPTl9JTlRFUkZBQ0UpDQo+ICAgICAgICAgICAgICAgICBzZWxmLnBiYXAgPSBkYnVzLkludGVy
ZmFjZShvYmosIA0KPiBQSE9ORUJPT0tfQUNDRVNTX0lOVEVSRkFDRSkgQEAgLTExNCw5ICsxMTEs
OCBAQCBjbGFzcyBQYmFwQ2xpZW50Og0KPiAgaWYgIF9fbmFtZV9fID09ICdfX21haW5fXyc6DQo+
DQo+ICAgICAgICAgZGJ1cy5tYWlubG9vcC5nbGliLkRCdXNHTWFpbkxvb3Aoc2V0X2FzX2RlZmF1
bHQ9VHJ1ZSkNCj4gLQ0KPiAtICAgICAgIGJ1cyA9IGRidXMuU2Vzc2lvbkJ1cygpDQo+IC0gICAg
ICAgbWFpbmxvb3AgPSBHT2JqZWN0Lk1haW5Mb29wKCkNCj4gKyAgICAgICBidXMgPSBkYnVzLlN5
c3RlbUJ1cygpDQo+ICsgICAgICAgbWFpbmxvb3AgPSBHTGliLk1haW5Mb29wKCkNCj4NCj4gICAg
ICAgICBjbGllbnQgPSBkYnVzLkludGVyZmFjZShidXMuZ2V0X29iamVjdChCVVNfTkFNRSwgUEFU
SCksDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgDQo+IENMSUVOVF9JTlRFUkZBQ0UpDQo+IC0tDQo+IDIuMzQuMQ0KPg0KPg0KDQoNCi0t
DQpMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQo=
