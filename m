Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17113847B;
	Mon, 16 Dec 2024 02:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734317976; cv=fail; b=Fd73cUAUbA/68jaPUjP3KTh61A+K15ar/FIdUPbWQlR50eE/G09ksY6nwoV4PirlkoBF9jAVjrYCbuUC+s7ga9qP//ouC8gVleQgj8gdR42UracEh+cZDZtFiiuTCIESKMtzXj+RKBd7MKD0eG8vpvSqe9fJmTKSGxyKP6Mqh/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734317976; c=relaxed/simple;
	bh=LcSEPr4lRGHHCib3SdBR6CPX3vKzFwt1zC4Pdtv39RE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XOSaJFPnbDDwtoN0qWUl6QUnu+RCSGh02R9IdbC4hQuYxxjgjMlLm6oSZl6FwrRBCErXRtHmivCEMbpVRj3MkSPFtNs/f4GcQtr6sVllFXIqdY/GcZZqq6K65WaL1+1Tka60nhtt1qdLjZarHfGTJ91956GR3T/7Ew+xiqxnfZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sTNschh7; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=F1p+irVZ; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sTNschh7";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="F1p+irVZ"
X-UUID: a68e062abb5711efbd192953cf12861f-20241216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=LcSEPr4lRGHHCib3SdBR6CPX3vKzFwt1zC4Pdtv39RE=;
	b=sTNschh7xvuRLIIrDstRWkNLC9gt2JOfIr3fxzaMRytZJuCZimWuEv7Q4pqrzqwXgs8Ajb7ns4eu+r7S7J9znu1D3TwAP21xt7Hmk3Bo88jV8nCA5gdgs2Q5Ny/bDM737IY/hBocgYApcFnCN1nZKUj0RYzvuAHrcnjmXUZLDG4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:c15316a5-1d17-4cb9-a90f-595a18483d75,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:433f9128-d2eb-4de2-b5c9-495d1bc17256,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0,EDM
	:-3,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: a68e062abb5711efbd192953cf12861f-20241216
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2121017775; Mon, 16 Dec 2024 10:44:20 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 16 Dec 2024 10:44:18 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 16 Dec 2024 10:44:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9GAbC70S/46FI+k15M00FLwCTdf0MQY2xWR/DZj6miL72r67gbrSGDTtdMmAlQIMdrJpWSax8+uGgCf7JdRXwLMZEjIPL28SzFJ3Fw2wSX1K4o7FnfH9I2AjUaxKU7Z7/biCqBlMU3XVdP1zyQmqxnckBmy7WjkNi+Zh8AK0wB1zV9bmbeK9BKnnpZnkoMNhZDWU/AHNtLmT+QGotxlapR9QxHJMOcB9zg3EFMKj+gLimdgfbgy8YhYLdFQWOXMP9ad+4rZMRNh8sUZS+UriLrPGDZkWCZmbgntQVUj78SpGH44W16G5idGrtAw0JxUL527CPk2DDQB3CUM+Y0oiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcSEPr4lRGHHCib3SdBR6CPX3vKzFwt1zC4Pdtv39RE=;
 b=o9JuoBX05p4gOU1QG8RelujbBphYnNwrDGoAzJPb9LVIwOTefLwQumPgRZcGGUliwMzbsH6QEZ1wCQfk154o/+3erDmKVVF4Jlr1A0nXWv+VBjgoJ6qSUe9FbNZh3EyBCMhXAkIfaeLTmgx1x8570UqJX6Ig+YSiRYy1yIR5X5hVUeohmc4hTu2Z1g6u3rlbmfboDhEs0e0tAsUbFHbFSE4OHFBggkD3rzI2upInR4UhucP6i46LDeWxjjo/2f9+KZ0g/N1j5IxtBeZ5I7o/+Tzow0ldZcOMTf0OfX7u3SKMTFzjSvjHnN3RNzdF3pfR2tOfYl8q8mFEuNWXv1WeHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcSEPr4lRGHHCib3SdBR6CPX3vKzFwt1zC4Pdtv39RE=;
 b=F1p+irVZMOSx8mp0MBkTO+6n8igVKy8rz9QSZdiT1staDNzYW4P+Qv6s1uMunVwzFmuV8JY/zladUHObcZKmLIjacxkEf3ebkBkQ4RvankNA0cEltm3SKU1bRWT5UOm2WiXApKSD6q5pmOn/rhiRegmNUFP0d9YrXDTcDysrWGk=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by JH0PR03MB8100.apcprd03.prod.outlook.com (2603:1096:990:37::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 02:44:16 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%5]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 02:44:15 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
	=?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>,
	=?utf-8?B?SGFvIFFpbiAo56em5rWpKQ==?= <Hao.Qin@mediatek.com>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: add quirk to support
 HCI_QUIRK_SIMULTANEOUS_DISCOVERY
Thread-Topic: [PATCH] Bluetooth: btmtk: add quirk to support
 HCI_QUIRK_SIMULTANEOUS_DISCOVERY
Thread-Index: AQHbTUMwRkszlv2/u0aWMyD9oFN1NrLj7RsAgARBJwA=
Date: Mon, 16 Dec 2024 02:44:15 +0000
Message-ID: <aa8b24291fd5c88f65e6e196796c16de6102b27a.camel@mediatek.com>
References: <20241213094118.23647-1-chris.lu@mediatek.com>
	 <6bbe0989-babd-4a99-85ad-fdeea47deb09@molgen.mpg.de>
In-Reply-To: <6bbe0989-babd-4a99-85ad-fdeea47deb09@molgen.mpg.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|JH0PR03MB8100:EE_
x-ms-office365-filtering-correlation-id: 8af08258-607e-43f3-8623-08dd1d7b8829
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?WmRwUDFMY3JiS1BpYnV4NEdZU3V3MzZoZWI5dWZjb2RLVEkyTFJWeXhXby9T?=
 =?utf-8?B?TTdXUWhlRGxVWWNCaXVLUmI1b0RldmlGRlgvdGZ5b3FMZDdQRkwvRlk0bTN3?=
 =?utf-8?B?eUlkZWsvZFFwYjVvam1YYWc0Z1FJVlg1eDBzemRhUnBoR2dnV2M0MklVbnVS?=
 =?utf-8?B?TkplWmdHY2hzM24zNWgrRWpBZXpsKzB2R2Zjc21HaG1mYXZhTmpVVjg2bTYw?=
 =?utf-8?B?MWl5QTJNSW9qak9VOHVYQ1IydkQ1MmpPWGpHRENVUnJsUTQzV0U5NzE1TTA4?=
 =?utf-8?B?QTlIaXdSRU4vUDY2T1NUQkVPUzJDTmFIK0MwanVSVEtUMWZPcWdXREg5MFFN?=
 =?utf-8?B?L3pSMUxDVUU2WVJObkRzZFBkbC9YYmpJMnZUa2pBMEUxZXVwSm1pVEhYdUxK?=
 =?utf-8?B?ajE3S2FFYmhnTjhlMDZVNzhZdm5UajE0akJYQjBLQkEydysvMU5tZmpicFR0?=
 =?utf-8?B?TWU4cE9CQUdKOEphZkI2QVN4bkJ3cmo2bHl0b3FrbFBnWTlwSXROcGZBWHN5?=
 =?utf-8?B?MU1kNFJId2w5OXJDejY3QkplcndUU0tDeDd1cjN0R3BYWDRjamsxNjJudE5H?=
 =?utf-8?B?OUovRXAwTHY0a1VJY1RienZScE9xelVZSTBNU0FrVGJMeTdLNzhiV0VrTVZV?=
 =?utf-8?B?a0RjamJtRzhHa2Zhb0s5Vm5qbFZaeG9nSEh4SVRkc0s1K2dLeGNwZkZYcmJW?=
 =?utf-8?B?Qk5WaWRKSXptRXVQN0NGR3ZrS21lM1JHbUFuNlNrRE16UjNGUTYyZVpDZS9W?=
 =?utf-8?B?MmNtNTUwUlhkTGcwSDdFQjN4SVhsdGJCdW83MnplWHE1VFRVRnhzcXJKaW1v?=
 =?utf-8?B?WlZDKzQ1b0M1SjFMczlxNVQ5WUszT0hIdUR1ajdqeGc0NTVpamdCdTlkbThn?=
 =?utf-8?B?aDVvRE83MGt0VlBsR3hweFlUMXBOYVc4ai81TlZ6bU0xenJ6YXdxdU9Ici9F?=
 =?utf-8?B?clZ5OE0zbzk0YmhwblhaMURta3F0c01WS0pLbnNLcFErRGJ1TkRSclB6Z2FB?=
 =?utf-8?B?cVgrWmxoVEJSL1VrdEpMRXVFVDIzT1cxeU9OTTJKQzBNUVdMTWxOckFBRWNJ?=
 =?utf-8?B?dGZOWHZOTWQ4Zm5saG5ZTzIraGNvemU3ZGdnZGdhdHJDSDlWeTNkT25TTjRZ?=
 =?utf-8?B?M2NubzdMUkRaUUxVSmdBeXEyelBSVzJEcVI4aUtITGhxQk5ia2JBZTZvUzdy?=
 =?utf-8?B?VlJ6NGFvVlpubExKYWRxY0Y5SW01MkhGTmdlTFRPaGhvcFBHNXNUN3Q5WCtW?=
 =?utf-8?B?MzdHZWh1aC8rcTN4c29XT2lmK0w3b0hlL1RhY20rU1lFdlAxd1YwaTZFTytz?=
 =?utf-8?B?UFVoQm1UaDl0aHRkeFQ1VkZ2blRBdjE0dG5jS1U4T0N6bGJxN0dwVWhtUzd2?=
 =?utf-8?B?c1RCQzRlOEZQeTU1bW41VUZqRHRNTmNRZjdNKzU5N20ydmg0dFRQYjloYnMv?=
 =?utf-8?B?T0pkOEpXdG9mK2EyNC9RMTBnUXVlRVBHWmlNRkVHWTNEcGcwYUt6VnRERFN2?=
 =?utf-8?B?UlR3Qit0UDhWbVZNVGdFcTJkVWdJUkVGNkJxSVVnSm1BaHhQaWJINllncVB6?=
 =?utf-8?B?azZ4YVlLMmd1Z0V0WG40dDd6SEJpWFVQUVNIZlVPZ2U5ZGtnOWVLQU5EeHJ2?=
 =?utf-8?B?MzR5KzVpaTJtSHdVcTYwSnZWRzJXc0tzZWh2SkNydkRvcUZIT2ZvS0M0eGd3?=
 =?utf-8?B?VlZpeGhZc2haaUJNbkhTWW5OcjlydEh2OU5qV1NWNENzU3oySCttaHhIbEU0?=
 =?utf-8?B?Rnl5aXZYUVExZlo5eVhyUDJZWXk4LzhINnhsa3dUdFcvRStkYVZiVjdXV21L?=
 =?utf-8?B?VElia3dkVVJCT0xyeFcrUG5ZQnlXT2EzUHpOR2ZNaE5nbHpwTXpvRWJDTXEz?=
 =?utf-8?B?OWdjQ1Y3bFF2Vm56OGFPOG1ETmZtRmtTNUVWVTNPanFNV1VOVUJVUnlQdVhu?=
 =?utf-8?Q?+lx7W+yWKDXK21YJWDriMUCXIbIiB/sK?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDgrd2tuVEpUVkQwKzVyT1pFcFdhWnQrQzUxa015MlZ2SGY5WnQ4ZFdOYm9t?=
 =?utf-8?B?dUtJYnNYeitBWlhGU3ltRVRUVG0rQlpvWmwwb2JSZEFlY2ZXdWIwejA3VlRO?=
 =?utf-8?B?NGMzdHNpU21mVkJxSFIzNGFPdmdoOGdoa05DdStpd0tvTExRd0NHVHB0c1Zq?=
 =?utf-8?B?R1l5c2Z5Y1ljV1pNN1BvNnJlQ0NXeDYrN1ZXcGlsQUhYcjBnc3R3dWVyNCs3?=
 =?utf-8?B?eDE1bUdXR0hkcjN6aSs0N3h3RGhIWHdUWlVzVHprai9reVdvK3BxL2VIdStG?=
 =?utf-8?B?cWtlcnpwOHJzZm5XejI0cGF6bEFqSGNoc1IzdkE0SjNnTVVpSkFwVklIU3Zh?=
 =?utf-8?B?MzlJam13VVNYOVBEdGRwYmNBYWJ2NjEyaXpsdG1rejk5ZDNFYld1V01rK2Fu?=
 =?utf-8?B?cXdWWVlmNWVkVExEZGJ1ZzUxdE02MU5FL2dOenRVNVdoTko0bFNNN2l0R3RG?=
 =?utf-8?B?QVNnVWJvS2lVWGhnaHhLSkhwdE1OdUhzRmNvMW5UZFVib0Q4aC9FUC9Wd0g4?=
 =?utf-8?B?TTl3WVkzbVhscGJLVU5ra2xjYzZkNlY2STJ3OGFxR01ZdTBGdU1PZUhIYjJB?=
 =?utf-8?B?a3NBZWZibUV4cXIvUEkvWXpSd2M2RmFuZ2toU2NEeXRkbDMyWUJubzIxZnFk?=
 =?utf-8?B?dmcyZUl0VmFWOE5pQ0g3T2w2RG90WVl1cVlYcTRnK1dodzZ5eUhhc2ZpdHFW?=
 =?utf-8?B?R3pLdkp2bGRGK0k5TXJwMWxOTFRyRjdob2VPWVRocWRWRkhBK1ppdzFkejg3?=
 =?utf-8?B?MVFFQ0FVOFpPVWRGM3RLNXBtWVFtYVU3M3g4dTNpb3B5SjJadkI1TjdlNFFV?=
 =?utf-8?B?STR3d1lBUEZ3TldDSE90RlhPYzBjc1llN0crcTJkZ3ZrUGg1SyszK216ODdq?=
 =?utf-8?B?U3hOZ1FFcU44VXJ0Sm82bllrNnV4a0dJVTNjWThBaDJ6RTdqL3liUVdDQ2NQ?=
 =?utf-8?B?aDNpcGUvV1luVEU3QkVZVlhSQ2FTK2wzK2V4NEptMzBqaEZTYzVYV1MzRDZ6?=
 =?utf-8?B?ZmpRMlNjWmM5dFBXdU1CRmdra1FveXpCeWZiZmxHdVhYYkpSNTc4b1luZlkx?=
 =?utf-8?B?eCtnN1gyREZ4Umc3YnhNUlJVRUdXU3lGM3BUVUd4bm5meER4bTBFS2VmZjhY?=
 =?utf-8?B?bjJhV1ZlT2VEOXA3cDFxaVV2TG8rMXZDSzFtbk81bW9rbm54TndVdE9Ed3Zq?=
 =?utf-8?B?ODFuaHI5TFU4UlpmNFNheDZtYmswSTBlRDFPZVY3RVdDKzFUd0UyYmRra05Z?=
 =?utf-8?B?QVlHOTRJczZteFRVY2hrMUhIK0hxR3psZ3RZY2hqZzRaREtFcDIrTjB1SjJw?=
 =?utf-8?B?blJsaU1mTWpzeUZVSXI0SUNGUHplWlpNVFFrazlyTUlRS3hXeDN6bTNBbXVz?=
 =?utf-8?B?TThxMU9BUU9kZC9xZ0RERG5aakRDam9rWHNMcHFGOENjZlVVVWQxQUJieHJP?=
 =?utf-8?B?QXpYeS81T2NwUkt6a0c5dnF5MFUrbjkraDYwc3FRMEtRMmlYZ3R3TlVsQlNH?=
 =?utf-8?B?d1FCdnBudkR5TjdhR0prbysrdnVnS3BnZEl4NEkvN2JHNmVtMTJsRHVXVlhR?=
 =?utf-8?B?Z0JPUjZZNk1McnNnWW9GZzlQQ3RRZmRoQVJrelY5bi9GeFFKSVNxVWNRcHZ6?=
 =?utf-8?B?eHpQcm9LTFRXQUVKZ1BrYjlXZVZ1REE0SzJYbkRTaUlEK0lWeVo3bEdUUzJz?=
 =?utf-8?B?Q2FIaXd3OUYrZExSNWZxNXhzWER5QkFiSUhDTHJBOEQvTXFwM0U5a04xUC90?=
 =?utf-8?B?UXNqV1BSK24rZW1ielMrQkRQalRGOTBBd2x2TlNwTStsNVQ2VnRsa1hSVlZB?=
 =?utf-8?B?TGJ0SE9OVDhwczdibW9yWENzZk1IMFRVdEZ6STZUV3NhQ0NTVHBMaEZwd3do?=
 =?utf-8?B?dDQxUnVKR0V3d0d2UWlMd1RpcVAxeG0yN0ZFWXNKUjdJS0FaMm9RaXNpeHVl?=
 =?utf-8?B?L0ZmUDRqaVhqQWNSWmcrZ0NXVDZWcEdEYWVGN29JSmhJQVlsNzlUa3J2ZVJX?=
 =?utf-8?B?NWM2Q0NxTk9wa2g4cmZiZXRGcW9WdU11ZVNlVW5MbVkxUDMwVk9oQ1BZQXhZ?=
 =?utf-8?B?RlFJcHkvQ3NrMWpGZjdyNjdiNkhlclFrTkdqRzNCT3RuUFpiZU5IUWluamlF?=
 =?utf-8?B?bUMvYmZMaWhOY2hSY0lrbHVwMm5lVUtjb3JNTzlBZ1dOT1hWQnZrOURrY0to?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <309B74B56C0F1646B265D1A919017FA2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af08258-607e-43f3-8623-08dd1d7b8829
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2024 02:44:15.8944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wv607T92Sw2RD70THUvbVDVDk7r5Et6HfyTRt/FWBUZVmqj08V+7d1YwST8tiArbKlb6t9zeReXO8T1SKCTB+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8100
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--21.941200-8.000000
X-TMASE-MatchedRID: +f/wAVSGjuinykMun0J1wpmug812qIbzFk73i4rVVIENcckEPxfz2DEU
	xl1gE1bkfdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+CxF0vHVf0FWQKsBzqYcu+TQspH
	3OU9/R7b0oTsvScnHSukj+9vm/sSG/gYpKALyUUGJQ9k+Ypk5CWEF8bGZ0cKCNEJplIoT86wXCc
	LhoQw82diutipnYWQsFn5gr3vsZAQdpD3DKTh+QNFVbTerMAe+QKuv8uQBDjq0ObdxMohq2Gb6P
	phVtfZgD855hkFOPoIWx66+1HmL9Pqr/zl/vMnxngIgpj8eDcDBa6VG2+9jFGWCfbzydb0g2EuZ
	q9zngaeNo+PRbWqfRMprJP8FBOIaA/3R8k/14e0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.941200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0586F6190994ECD13ABE0B704E68586B9ADB2BF3CAE2659A32DCA8A946E8AF582000:8

SGkgUGF1bCwNCg0KVGhhbmtzIGZvciB5b3VyIGlucHV0LA0KDQpPbiBGcmksIDIwMjQtMTItMTMg
YXQgMTA6NDYgKzAxMDAsIFBhdWwgTWVuemVsIHdyb3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBs
ZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3Ug
aGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IERlYXIg
Q2hyaXMsDQo+IA0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLg0KPiANCj4gDQo+IEFt
IDEzLjEyLjI0IHVtIDEwOjQxIHNjaHJpZWIgQ2hyaXMgTHU6DQo+ID4gQWRkIHF1aXJrIHRvIHN1
cHBvcnQgSENJX1FVSVJLX1NJTVVMVEFORU9VU19ESVNDT1ZFUlkgZmVhdHVyZSBmb3INCj4gPiBN
VDc5eHgNCj4gPiBzZXJpZXMgY2hpcHNldC4NCj4gDQo+IEl04oCZZCBiZSBncmVhdCBpZiB5b3Ug
ZWxhYm9yYXRlZC4gV2hhdCBpcyB0aGUgcHJvYmxlbS4gV2h5IGlzIGEgcXVpcmsNCj4gbmVlZGVk
PyBJcyBhIGZpcm13YXJlIHVwZGF0ZSBnb2luZyB0byBmaXggaXQ/DQoNClRoaXMgcXVpcmsgaXMg
cmVsYXRlZCB0byBkbyBCUi9FRFIgaW5xdWlyeSBhbmQgTEUgc2NhbiBzaW11bHRhbmVvdXNseS4N
Ck1vcmUgZGV0YWlsZWQgd2FzIGRlc2NyaWJlZCBpbiBoY2kuaC4NCg0KRHVlIHRvIHJlcXVpcmVt
ZW50IGZyb20gY3VzdG9tZXIgYW5kIG90aGVyIGNoaXAgdmVuZG9ycyBhbHNvIGVuYWJsZQ0KSENJ
X1FVSVJLX1NJTVVMVEFORU9VU19ESVNDT1ZFUlksIE1lZGlhVGVrIHVwbG9hZCB0aGlzIHBhdGNo
IHRvIGVuYWJsZQ0KdGhlIGZlYXR1cmUgYXMgd2VsbC4gVGhlcmUgaXMgbm8gbmVlZCB0byB1cGRh
dGUgZmlybXdhcmUuDQoNCj4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgTHUgPGNocmlzLmx1
QG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMg
fCAzICsrKw0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idG10ay5jIGIvZHJpdmVycy9ibHVldG9v
dGgvYnRtdGsuYw0KPiA+IGluZGV4IDhhM2Y3YzNmY2ZlYy4uNTYyZDZlY2YwYjcxIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMNCj4gPiArKysgYi9kcml2ZXJzL2Js
dWV0b290aC9idG10ay5jDQo+ID4gQEAgLTEzNjcsNiArMTM2Nyw5IEBAIGludCBidG10a191c2Jf
c2V0dXAoc3RydWN0IGhjaV9kZXYgKmhkZXYpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiBlcnI7DQo+ID4gICAgICAgICAgICAgICB9DQo+ID4gDQo+ID4gKyAgICAgICAgICAgICAv
KiBBcHBseSBjb21tb24gSENJIHF1aXJrcyBmb3IgTWVkaWFUZWsgY2hpcHNldCAqLw0KPiA+ICsg
ICAgICAgICAgICAgc2V0X2JpdChIQ0lfUVVJUktfU0lNVUxUQU5FT1VTX0RJU0NPVkVSWSwgJmhk
ZXYtDQo+ID4gPnF1aXJrcyk7DQo+ID4gKw0KPiANCj4gVGhlIGNvbW1pdCBtZXNzYWdlIG9ubHkg
dGFsa3MgYWJvdXQgTVQ3OXh4IHNlcmllcyBjaGlwc2V0LiBUaGUNCj4gY29tbWVudA0KPiB0YWxr
cyBhYm91dCBhbGwgTWVkaWFUZWsgY2hpcHNldHMuDQpJJ2xsIG1vZGlmeSBjb21taXQgbWVzc2Fn
ZSB0byBhdm9pZCBhbWJpZ3VpdHkgYW5kIHVwbG9hZCBhbm90aGVyDQp2ZXJzaW9uLg0KDQpUaGFu
a3MgYSBsb3QsDQpDaHJpcyBMdQ0KPiANCj4gPiAgICAgICAgICAgICAgIGhjaV9zZXRfbXNmdF9v
cGNvZGUoaGRldiwgMHhGRDMwKTsNCj4gPiAgICAgICAgICAgICAgIGhjaV9zZXRfYW9zcF9jYXBh
YmxlKGhkZXYpOw0KPiANCj4gDQo+IEtpbmQgcmVnYXJkcywNCj4gDQo+IFBhdWwNCg==
