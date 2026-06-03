Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B6396D29
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 07:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472020; cv=fail; b=XVUsWmUHg5kDFpdjdaphTseteBmqRT2ZIwbHDPOqWTIDKiuuX51P8M9i1nkHONs37jgP9s311scgzEkK0KYOKz2L1WQ6snEJWML8RHClxD4n+WP+iNSKNWTf0ZCB7b80dAOS17DihKLe6urV2o0BUQlpQGn4oQB2EX0PtynrN0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472020; c=relaxed/simple;
	bh=haAxQrBIztwbRa+tugQWjwCHkGyXaCefSEr9M1Tt9RY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hvoh2TN5x8S5A1uQd8sS97KTtt6rqytWVHMgQvFh39sAuaOOhNUB04OalY8gwbeKWW3tbkBiG4lHTOTn6DADg0JFXdbvHMZuAbFzYSMML1Rf7QQ5erUJ0rABMge5dAYksKp3adXzFHK4Abfr5z7KlF8R+G2Mr7rZu/IQnsEl1KQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d+Bl+zhV; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d+Bl+zhV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFN2KF2urzQVeQVUlr25KRQ3fSjWzvTWiDzot/H2VSjgAdlD4uD++baXOAiWyIxfqLse1Pj3gZvzkytCYIpdcA2u9lZsLcRvxqGbWMCPBjY5Bka90NSOes+RB7+X3+IYlQ/5vhphDexhJkdoPEF6MgP7I4vtRtqWk0TRmpmhqxIY+3eu6RxJpc77ZgXWgMgYooJGmZSSVOPO+unKaWVqANwjHh1w7ItDiDuiBWnej4hd9KwDwLN9BgOYnCCflBd2/hIETsfnsWnhHJfoR9dCEqGTBjmX4rNP/jKOEDBv8QGMMTGHV/T+vZaQHcF1KziUC4voA92iPI+5a85V7TESqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haAxQrBIztwbRa+tugQWjwCHkGyXaCefSEr9M1Tt9RY=;
 b=Yfhix3jxmQA06EmoR6lkrrAcUcHQOQvAunKAwMfHvou/seCEPVCyv/SqO/v01KNMw2gdUKiFLs7yh2ch818KsxYZ1bQ47oa5SqvahUrDnFQUriNm/qEDO6nc8xaa15aJ8G1whv98/7SO/wU0vQV3URqn7lNNHcOeaNpFeY9Wajxd5nEu1LMR0FOAMHESTRbzOHa01biQi+aTDNOTb+Vj6bTjumU8fzGx4ibLPHgFDauHJeOVUStsVVyqhcKOytNQ3FJTxmxr3tlFHXEzxITvZlrZza3ljMQeK8EbEgvwjb9nvTWHWbVD2RJ1IaJ5FQYxBpnSXINpudk9sy73frK4IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haAxQrBIztwbRa+tugQWjwCHkGyXaCefSEr9M1Tt9RY=;
 b=d+Bl+zhVvH/rXfHvuZuAc2Gd7J19n4GvqEQl8YZcARdAcA4mHljg3JKi+bqKPvTPUXekdTVeRbRLW6SXLtgxqiS1tWJE0UWvGif17sofzbla2TIAp4r1GQqM6njJwjXjySYAcl3HBCGADkK1auuOb2aK8jlDA5Xys2sD8YRRb+q9nKQtjZlc83+qfQF+okGbC3IJ62+NP67Z3oTe/oBCHaQVtUyxH2HAtOfTqUC2oFZ3QDLmY4Zk6e+ndHJFs0rW1BFym8UKEfoedcLb82dL/SJJXUhiIKxDfdJW3raLW+98g1fRXWFpk1qCznrQ8kMyvbUa6UR20w2T+AKGEBxWag==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GVXPR04MB10430.eurprd04.prod.outlook.com (2603:10a6:150:1e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 07:33:32 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::9fb:29a:671a:cbe8%7]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 07:33:32 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Zhao Dongdong
	<winter91@foxmail.com>
CC: Amitkumar Karwar <amitkumar.karwar@nxp.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, Zhao Dongdong <zhaodongdong@kylinos.cn>
Subject: Re: [PATCH v3] Bluetooth: btnxpuart: Fix use-after-free in probe
 error path
Thread-Topic: [PATCH v3] Bluetooth: btnxpuart: Fix use-after-free in probe
 error path
Thread-Index: AQHc8ytHwyuAxvsRYkeD71s3e8MW6A==
Date: Wed, 3 Jun 2026 07:33:32 +0000
Message-ID:
 <AS4PR04MB96925D8EB8E7C6B02B5CE164E7132@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <tencent_F2E2AF1B6F510577B10C6897ED768BBBAF07@qq.com>
 <CABBYNZLQU_dqZkUP_EUcT5bYGif=dqC-sYEM+yV9Y=TrWwNWMg@mail.gmail.com>
In-Reply-To:
 <CABBYNZLQU_dqZkUP_EUcT5bYGif=dqC-sYEM+yV9Y=TrWwNWMg@mail.gmail.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|GVXPR04MB10430:EE_
x-ms-office365-filtering-correlation-id: 5d8ccd44-1d8e-4b17-91cb-08dec14269f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|4143699003|11063799006|3023799007|4133799003|56012099006|22082099003|6133799003|38070700021|18002099003;
x-microsoft-antispam-message-info:
 UOWmK3CTY4o2pvVqPZjFEhPJiHDOYjhWQbjmQI///VFgFyydrzCyvZjdOERmmwtHnhr1YmSoq+dmYz3KJfEEmBjWYzQR8q+JUuXM4jMsj0Jmp9t6BnYDz8jyVD3TWecdBBPoBpupdyKE8ng4CwVOd6LfoNmMW2yRzpxF1j8ECd84YIOok4GSqSUPp3Z+Hih9w72cBOpc6JsAUuRuEDRu5OM8IUGScp/HYSkrE4mIov5m/x8e7prcBwMejtY9gC3WjViYWCT9GAY27r6K+p24dulBPZs/W/8OCEy/VhaWK9aSH60jLO0w659QN1Hmn8Pho6LLlnQ1s+Rw0hqUZtMr7SwPBynm3fE1uxyPrabg6jxyJJpfO7Hqh/w0uIAlPcBzbyVkpolg+Mu4YZcMRMBi3Mspe9jakB1XJkbK8v5rpHaVOywsAwtcZpbGSMuk32ibg0SPd1s58EemezKnaQnU35eickyP3Ruqp/E01RcRrOBqjSDW1rDcVREFv2QKDgAPn9Qm+watzMiHh8Ptf5RYbYi3/WqjW2j4odxUztciFCyHmU/4FV+mB+9p4IvsGgDVxoMzGdmjyIOW+HrEUVdMugaqeFNgrWqlo1dxePlG27ArYy7gJyj7HaTes+56hxQXN2F6adSuVikGuxaHaeI6k3nfnb/b0DFoqXt7epGwpXIb4lR2Om6DGhbXblVPalr013PE1Y2bJfs0nQmKERt2L8iJHpXlgkS9lr2/1d+haBPOx1uu4YFdsoAZofF2I/RS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(4143699003)(11063799006)(3023799007)(4133799003)(56012099006)(22082099003)(6133799003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEh6OVV3YlU5cTZlYnFvcG01YkFqVnREMGNaRGQ4cDVxdEg3czRLcEZoaENj?=
 =?utf-8?B?MkdJU1JRUXBtbk9yWWYwaXRPQWNRZHRYcmlKeG9OMVd5MEpjZ2loRHBWVFFX?=
 =?utf-8?B?UWF3eCt0cXEwaHhMVGk4UkkvK0RYdDlscFQvYTFCK0V2STVzZGZLWFdCblYz?=
 =?utf-8?B?YnNCeUFFeFpuZVUwdlRjUkNhc3VjL3hxc0pUM1dsYVJEb1BPUFhSd3E4SmNn?=
 =?utf-8?B?Y3RKL1F5bWIrTjJOYlIzdzh0RGJTTEEyM2NSemlmcVNNVlg1TCtsVzlFL0dm?=
 =?utf-8?B?UTREV0N3MFZPRm5Ca2sxMyt0NTFYMGt6VEJ1TVJPaUZwcTIrRVRHNklBUFJu?=
 =?utf-8?B?bGdjNkY0SU10bWFMNGdTRTVxdzFhRGVFZVZHbHk2d3ZpT2YrV2MxMk5JVmd4?=
 =?utf-8?B?ektMRlc5MzQ1QStzZC9yTnpSOElLaFRLVWZ3UVQ1WnhWeFZFYTB0MlhzWWZZ?=
 =?utf-8?B?Y3F1NGtFMkFHRDVxOW5Tc1RZUW50UDNwVVhqUGRrR3RNeG84ZjloLzBQVVhF?=
 =?utf-8?B?RCt1UEM1VC9WaCs0bElQL1B4aVdoSHJRNnVGU0FkYzVuNXNlbURUNUliTTRt?=
 =?utf-8?B?RGRCNGtSWXRPR3Yza0FYZDZEN1ZKclFZbXYvaC9wWmk1V3BQamhwekpVUUx6?=
 =?utf-8?B?Y1paL3YxcE0vSzI4eEVGTlRRL1VRd2ZBaEtxbDN5d1dWRE9oUUUybWFYREw5?=
 =?utf-8?B?aW16YlNCWWROeEYrTlBqZ3lsMXltZ0poNHhHYXJ3MlB1d1R5b293NmhDb3hQ?=
 =?utf-8?B?K2UwdnNnZWk5dENkNDJIVHJBTU9KOTY3OEdsRkIyZjZlaXJ3WnFnVjcwdk80?=
 =?utf-8?B?b0k4WW5wL3lTaFNKUkhNZnRMcU54OWxNMTV6MVkwZE5zTkIyYUxCOTFhNFEy?=
 =?utf-8?B?MmVDSnM2SUZYZ2ROclRmZ0FTQy9tQmR6MU04Q0g1b0d1dG1PVkVFUU5KU0cw?=
 =?utf-8?B?UXNTUlVkSm5DNDhpTFRRTmRubzhUWUFrWEw0RE9oUFZFNm5xRStYd2JmcnNp?=
 =?utf-8?B?UEQ0MWVFd2RWamhCWDU0NlQvZ1p6eEhiYXJoQnlKMGhhajRDY3FIK0x6ZDNw?=
 =?utf-8?B?bFc5djV6LzVaRWRpaHNkMnRjWmVhV3IxZWV0bXRKUWVxeUVJZWpZT2lqZi9T?=
 =?utf-8?B?YjZid1FvVU9abXg3K2RMc3U3SUtYRFZ5dTF2ZzJraXk2VDhHa1NKV3hTNTYz?=
 =?utf-8?B?aG0wdGlaS2J6U1JGeHE1QlBjVTRFZWdYTm1IS0lscGhjWGlmNUR4UjMyZGcz?=
 =?utf-8?B?Y0lsTEhJR1FuV0srdmFtRUJ4R3YrNjdvYzNYZFlISWdSdjlSd2JENTNUdWVo?=
 =?utf-8?B?eThTRFh3QVpXUVc0QWhTNi81a0MzdVBibmY4OVZERW9KVWd2Z1gvcndNOFR0?=
 =?utf-8?B?YTNBL3hwdVAxemhTb1loblJCR2xEMFdVQVp3RU9qQ1Iya1hCaTN3NWN5dHFZ?=
 =?utf-8?B?YTdJcDRtRnU0RnVzaU9mTjZhbTF0akdPcW0wVHc2VlFJUlp3WVFsazRreE81?=
 =?utf-8?B?VTU3N1orelYrc051NGJmWGlpNk5qUXVxanN2dGZ5Y1BWL2VHU0crcW80Ulgz?=
 =?utf-8?B?TjVTb20xejhXODFubU56SVNsd2lBTlZLQUMxY3hSR1BiVUVyUlU4Y2pwdG52?=
 =?utf-8?B?TUx1VE9JK3phMDdRZWFUYUJrUUl1TGFmYTQwZHJmakQxNjlpRnVDR2cwSEdz?=
 =?utf-8?B?emZ0ZnZXSFpKNEM2Q0NqYUxHck42WWRDaWFPeUErNTB2ZlBrQXhwMVNRNFdF?=
 =?utf-8?B?RWszL0tqNG5jWGk3cEc0S3JlZStCWlJXd00wT21zQkVRQkNoaEg3dmlJLzk2?=
 =?utf-8?B?RExuSVRzdlZwdUJaMWhPU3pFMUMvcGE5OGRqcnRzRFcvRlU1YUhnNGxZTEpL?=
 =?utf-8?B?QWpwYjlhUTBUaVhwdjdOUzRoOTRGUnNrelJRaTIxdnNqT1Fwc3FCcHQzUnNo?=
 =?utf-8?B?b1JLLzF1RnVibWs1WFdWSThYN3VsNWJhdlBwRmFPSDFTa1ZMSXMvanpwNE9w?=
 =?utf-8?B?SVdNSHFRb0JERmJGMjFKNm1OOFZ4RDFKeWovelV2dkUraFU2VmdWSmtIcmRT?=
 =?utf-8?B?ZmdBYXpZT0pTZUFiZkNad09WQkVHSHJyMUlKS0hTSXVBbzNxYTgyRFpSY1VC?=
 =?utf-8?B?Qkp4azJIUmx0a1l2TWUycVdLMjE0NmMvWDRWSU8wZjJXMFBiY0U5N0hIcW5l?=
 =?utf-8?B?bE15Q05pYXRWcENLKzVVL2lJUlVWNGkwTjNzZ1M2QitITFJpSUZmVng3RzVZ?=
 =?utf-8?B?YTZHRGdMQzlzbmlaTTBnWXFrRTNMSFh1Qi84bm5KNmIyZFhsamwvWjJvdEtN?=
 =?utf-8?B?dkdIUzhhVmdmaHREVWJCQ01YWnBtOVUzeFJSZHRlR3ZobmVBenhKUT09?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8ccd44-1d8e-4b17-91cb-08dec14269f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 07:33:32.2714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rAPLgJmXi048yuiVRzHcbsFRcUoN+93qt7QazEy7+6JiSaN+dFXWcuMkoktiU1shJ/WvIkItuablyjp7Cg8P1J3fO9TT81VM6K7MMWM9Dbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10430

SGkgTHVpeg0KDQpTb3JyeSBmb3IgbWlzc2luZyB0aGlzIHBhdGNoIGFuZCBkZWxheSBpbiByZXBs
eS4NCg0KPiBIaSwNCj4gDQo+IE9uIFRodSwgTWF5IDE0LCAyMDI2IGF0IDg6NTTigK9QTSBaaGFv
IERvbmdkb25nIDx3aW50ZXI5MUBmb3htYWlsLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9t
OiBaaGFvIERvbmdkb25nIDx6aGFvZG9uZ2RvbmdAa3lsaW5vcy5jbj4NCj4gPg0KPiA+IEluIG54
cF9zZXJkZXZfcHJvYmUoKSwgaWYgaGNpX3JlZ2lzdGVyX2RldigpIHN1Y2NlZWRzIGJ1dCBwc19z
ZXR1cCgpDQo+ID4gZmFpbHMsIHRoZSBlcnJvciBwYXRoIGp1bXBzIHRvICdwcm9iZV9mYWlsJyB3
aGljaCBvbmx5IGNhbGxzDQo+ID4gaGNpX2ZyZWVfZGV2KCkgYW5kIGFzc2VydHMgdGhlIHJlc2V0
IEdQSU8sIGJ1dCBkb2VzIE5PVCBjYWxsDQo+ID4gaGNpX3VucmVnaXN0ZXJfZGV2KCkgZmlyc3Qu
DQo+ID4NCj4gPiBUaGlzIGxlYXZlcyB0aGUgSENJIGRldmljZSByZWdpc3RlcmVkIGluIHRoZSBz
eXN0ZW0gd2l0aCBpdHMgYmFja2luZw0KPiA+IG1lbW9yeSBmcmVlZCwgbGVhZGluZyB0byBhIHVz
ZS1hZnRlci1mcmVlIHdoZW4gdXNlcnNwYWNlIHN1YnNlcXVlbnRseQ0KPiA+IGFjY2Vzc2VzIHRo
ZSBkZXZpY2UgKGUuZy4gdmlhIGhjaWNvbmZpZyBvciBibHVldG9vdGhkKS4NCj4gPg0KPiA+IEZp
eCBieSBhZGRpbmcgYSAncHJvYmVfZmFpbF91bnJlZ2lzdGVyJyBsYWJlbCB0aGF0IGNhbGxzDQo+
ID4gaGNpX3VucmVnaXN0ZXJfZGV2KCkgYmVmb3JlIGZhbGxpbmcgdGhyb3VnaCB0byB0aGUgZXhp
c3RpbmcNCj4gPiAncHJvYmVfZmFpbCcgbGFiZWwuIFRoZSBvcmlnaW5hbCAncHJvYmVfZmFpbCcg
bGFiZWwgaXMgcHJlc2VydmVkIGZvcg0KPiA+IHRoZSBjYXNlIHdoZXJlIGhjaV9yZWdpc3Rlcl9k
ZXYoKSBpdHNlbGYgZmFpbHMgKGRldmljZSB3YXMgbmV2ZXINCj4gPiByZWdpc3RlcmVkLCBzbyBu
byB1bnJlZ2lzdGVyIGlzIG5lZWRlZCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBaaGFvIERv
bmdkb25nIDx6aGFvZG9uZ2RvbmdAa3lsaW5vcy5jbj4NCj4gPiAtLS0NCj4gPiB2MzogZml4IGdp
dGxpbnQgV0FSTklORw0KPiA+IHYyOiBmaXggU3ViamVjdFByZWZpeA0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL2JsdWV0b290aC9idG54cHVhcnQuYyB8IDQgKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gPiBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
bnhwdWFydC5jIGluZGV4IGU3MDM2YTQ4Y2U0OC4uYTRkNzc0N2U1YmUwDQo+ID4gMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnRueHB1YXJ0LmMNCj4gPiArKysgYi9kcml2ZXJz
L2JsdWV0b290aC9idG54cHVhcnQuYw0KPiA+IEBAIC0xOTA3LDEzICsxOTA3LDE1IEBAIHN0YXRp
YyBpbnQgbnhwX3NlcmRldl9wcm9iZShzdHJ1Y3QNCj4gc2VyZGV2X2RldmljZSAqc2VyZGV2KQ0K
PiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBpZiAocHNfc2V0dXAoaGRldikpDQo+ID4g
LSAgICAgICAgICAgICAgIGdvdG8gcHJvYmVfZmFpbDsNCj4gPiArICAgICAgICAgICAgICAgZ290
byBwcm9iZV9mYWlsX3VucmVnaXN0ZXI7DQo+ID4NCj4gPiAgICAgICAgIGhjaV9kZXZjZF9yZWdp
c3RlcihoZGV2LCBueHBfY29yZWR1bXAsIG54cF9jb3JlZHVtcF9oZHIsDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgbnhwX2NvcmVkdW1wX25vdGlmeSk7DQo+ID4NCj4gPiAgICAgICAg
IHJldHVybiAwOw0KPiA+DQo+ID4gK3Byb2JlX2ZhaWxfdW5yZWdpc3RlcjoNCj4gPiArICAgICAg
IGhjaV91bnJlZ2lzdGVyX2RldihoZGV2KTsNCj4gPiAgcHJvYmVfZmFpbDoNCj4gPiAgICAgICAg
IHJlc2V0X2NvbnRyb2xfYXNzZXJ0KG54cGRldi0+cGRuKTsNCj4gPiAgICAgICAgIGhjaV9mcmVl
X2RldihoZGV2KTsNCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiANCj4gaHR0cHM6Ly9ldXIwMS5zYWZl
bGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGc2FzaGlrbw0K
PiAuZGV2JTJGJTIzJTJGcGF0Y2hzZXQlMkZ0ZW5jZW50XzRBMUQzMzIyNUM3NERCMzNFRkFFOEEw
QjZFODg0NTYNCj4gN0REMDklMjU0MHFxLmNvbSZkYXRhPTA1JTdDMDIlN0NuZWVyYWouc2FuamF5
a2FsZSU0MG54cC5jb20lN0NmDQo+IDY2ZjVmMjE0MmNmNGY1OWIyNjEwOGRlYjI4MTg0M2IlN0M2
ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzDQo+IDUlN0MwJTdDMCU3QzYzOTE0NDQ2NjQ5
ODE4NDMxOCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGDQo+IGJYQjBlVTFoY0draU9uUnlk
V1VzSWxZaU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUDQo+IFdGcGJD
SXNJbGRVSWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1wMk80V3JEd2NVZnZZWWU3Z2wN
Cj4gOXVvJTJCMU5vdEJjU05FSFZldE1ERXk2QUJrJTNEJnJlc2VydmVkPTANCj4gDQo+IE5vdCBz
dXJlIGlmIGl0IGlzIHZhbGlkLCBidXQgaXQgcHJvYmFibHkgd29ydGggY2hlY2tpbmcgc2luY2Ug
d2UgY2FuIHBlcmhhcHMNCj4gc2ltcGxpZnkgdGhlIGVycm9yIHBhdGguDQo+IA0KPiANCj4gLS0N
Cj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0KDQoNClJlZ2FyZGluZyB0aGUgQUkgcmV2aWV3IGNv
bW1lbnQgc3VnZ2VzdGluZyB0byBtb3ZlIHBzX3NldHVwKCkgYmVmb3JlIGhjaV9yZWdpc3Rlcl9k
ZXYoKToNCg0KcHNfc2V0dXAoKSB1c2VzIGhkZXYgdGhyb3VnaG91dCBmb3IgbG9nZ2luZyAoYnRf
ZGV2X2Vyci93YXJuL2luZm8pIGFuZCBhbHNvIHNldHMgcHNkYXRhLT5oZGV2ID0gaGRldi4gTW92
aW5nIGl0IGJlZm9yZSBoY2lfcmVnaXN0ZXJfZGV2KCkgd291bGQgcmVxdWlyZSBjaGFuZ2luZyBh
bGwgYnRfZGV2XyogY2FsbHMgdG8gZGV2XyogdmFyaWFudHMgdXNpbmcgc2VyZGV2LT5kZXYsIHdo
aWNoIGFyZSB0cml2aWFsIGJ1dCB1bm5lY2Vzc2FyeSBjb2RlIGNoYW5nZXMuDQpJdCB3b3VsZCBh
bHNvIGJyZWFrIGFueSBhdXRvbWF0aW9uL3Rlc3Qgc3lzdGVtcyBtb25pdG9yaW5nIGxvZ3MgZm9y
IHBhdHRlcm5zIGxpa2UgImhjaTA6IEVycm9yIC4uLiIuDQoNCkFsc28sIHBzX3NldHVwKCkgaXMg
Y2FsbGVkIGltbWVkaWF0ZWx5IGFmdGVyIGhjaV9yZWdpc3Rlcl9kZXYoKSB3aXRoIG5vIHNjaGVk
dWxpbmcgb3Igc2xlZXAgaW4gYmV0d2Vlbi4gaGRldi0+cG93ZXJfb24gaXMgcXVldWVkIGFzeW5j
aHJvbm91c2x5IGFuZCB3aWxsIG9ubHkgYmUgcHJvY2Vzc2VkIGFmdGVyIHByb2JlKCkgY29tcGxl
dGVzLiBTbyB0aGVyZSBpcyBubyByYWNlIGNvbmRpdGlvbiBhcyB0aGUgQUkgcmV2aWV3IHN1Z2dl
c3RlZC4NCg0KVGhlIHBhdGNoIGFzIHN1Ym1pdHRlZCBpcyBzYWZlIHRvIG1lcmdlLiBMZXQgdXMg
a25vdyBvdGhlcndpc2UuDQoNClJlZ2FyZHMsDQpOZWVyYWoNCg==
