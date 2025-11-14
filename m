Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90187199230;
	Fri, 14 Nov 2025 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763096953; cv=fail; b=BeuIVRweMMG/Lj3rk8vrvpmUMJ8aHpv42sfmIMzqMlrh+kVxl2gsW9nbRdGaaohrS1oLXjZaPfVQUCZq8tJPetTJoTU3MmFax9BokCQfISHNjr/r8pfSODxLlOMcMz9pZI9CaSmhC6G/OXZlBa/AyTi2GB1xbhAnxdv5TLWuJgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763096953; c=relaxed/simple;
	bh=DXiOvXUdh5rNp8mp58iA53Ck1Kao3nTkr08NI8OwncE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VkiKKzsaXXxJnjZLQSZDkDKiI3UXkesU2o0qZC5mHR+oxzQE4NFB13teLKW3UK+rnXfq4KXovduWXWywlyLdGsgAwa090zuJSeWp9LjXHE0u/xiBVVkCg0PFKk1qiPBStpF4Z8tMsPhsOe30WvJl2cLeWBBTCyuZJ4WbRWcdZlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WVebemAz; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=gevK/3Kt; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WVebemAz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="gevK/3Kt"
X-UUID: 0613041cc11811f08ac0a938fc7cd336-20251114
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=DXiOvXUdh5rNp8mp58iA53Ck1Kao3nTkr08NI8OwncE=;
	b=WVebemAzJ+RYDNKCx1l2OqwnHi0yrOt+W8Q9tRxXWalIkbRrsYHN1349CfqtP1Fj3oCIkG/mBapz4dAfbqHrUwJ0fyqCZ4tCUndYrWTJf/yK+zBDui0q4i7DnVQF/FQIMtYA8ODAjqDclUhlyuUUN2GSrtRlLBLCigiepXbb1hg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:e6a762e1-0d29-45ac-87a0-f0befbf3782f,IP:0,UR
	L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:-5
X-CID-META: VersionHash:a9d874c,CLOUDID:89a2e257-17e4-43d2-bf73-55337eed999a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:1,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0613041cc11811f08ac0a938fc7cd336-20251114
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2050938667; Fri, 14 Nov 2025 13:08:57 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 14 Nov 2025 13:08:56 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 14 Nov 2025 13:08:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AG2QTO6Sfdng1oFGol8c2JgTwLlFVtmE+OSagiGnaM5sZF2HziFeQD5p6TF8kLMRPUafT53Yoto18M5NiGebYmNfTEIVzkCJAVSqPd/r0pSfOAcDB7yEKKA9nM8FYUm6xJwteQSrYeSwymLarldESt+ASbPzkloRIuKN2p6uBsgLzGY58hb8H+GXxVt8mTj8K5f6uQG0gpVewAHnhLSE+kzA6yOrCPwLY1hW2O8tVhlipVkz3rimH9WrZ3+wg4zH+FTcTJFvD8KPlWieuCE5/rf4BRPp2TCe+9o8zqiGJ8M+a60u7tMbJn/M9NnTDvWrr+t9Q+ibO4NXKsqw8K5rBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXiOvXUdh5rNp8mp58iA53Ck1Kao3nTkr08NI8OwncE=;
 b=GhUUXqncZAxookZhN34wT9JDqy4jUBBey9HP1z1FPr1VzYjKAs/yN3Zi4Rcikux9Mtfl7Z5wnm/XRswBlsXmLRWvvwKTOMO0dFDeSx6q7fqBZf3bBa7FHNxvmuQyPT3WFipKeDLTlhjw61doLyQhoKxXGBUiYlrCO9a4Dnkgfe4LfT02nfdkI6oAIEtDcNg4AvVfai//u1FxXbq6VvpVS8ZPFxGcjpC5mSdBXMXNj54pJUvmZOwnzk7FcFhhXJeZpI5R0OW2r1OWyD/XzB53EU0qizaybpwp5iM5FKxc9IoVc5uAGh1tglvSvyYtdjPboZ1UsutdnK9uUPIgJwmA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXiOvXUdh5rNp8mp58iA53Ck1Kao3nTkr08NI8OwncE=;
 b=gevK/3KtwQKm8S8R4xUHlFvEmBSeptFchIbqNZVF8ITcHtsVMLJleSbgttxI2oe5H0PlIfHFav1AxzUQoevEmrk9bJjsZYXp8s55RrxYPjngKnuZRDNmecuiKUPXTaS+MEFRUbA2zdnZ/LtXz4ZBL9XmTkzlTVXGI4nlYL3vZS4=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by TY0PR03MB6775.apcprd03.prod.outlook.com (2603:1096:400:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Fri, 14 Nov
 2025 05:08:52 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 05:08:52 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: =?utf-8?B?SGFvIFFpbiAo56em5rWpKQ==?= <Hao.Qin@mediatek.com>,
	=?utf-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	=?utf-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, Sean Wang
	<Sean.Wang@mediatek.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1] Bluetooth: btusb: mediatek: Fix kernel crash when
 releasing mtk iso interface
Thread-Topic: [PATCH v1] Bluetooth: btusb: mediatek: Fix kernel crash when
 releasing mtk iso interface
Thread-Index: AQHcU6l5PynVBsxdIEOcHaUFCvky97TxoimA
Date: Fri, 14 Nov 2025 05:08:52 +0000
Message-ID: <ddde6e32c358c4847c1aa561f4c77a09d34d46bc.camel@mediatek.com>
References: <20251112075334.1162328-1-chris.lu@mediatek.com>
In-Reply-To: <20251112075334.1162328-1-chris.lu@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|TY0PR03MB6775:EE_
x-ms-office365-filtering-correlation-id: da88da8a-c894-4edb-e45c-08de233be75c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M3I1VmJXbENKSU1JTGg1Ykl6UkNpTlo3UXROaTBGOTJoYzR1NzB6a0djSXVR?=
 =?utf-8?B?VTNFdTR2RnQ0eWxJMGZ5RVBkTGs2MFVGQUZrY3cyNTk2TGxCcFdBbXNkVEwx?=
 =?utf-8?B?a241RHBBNGFzMDdsVUpqZ2FMcndLdURxMFpBNXVneElwNWhwTm8yUWpNeHlj?=
 =?utf-8?B?UnNLbW84WnhTemZwYUpWRlJEL24rQXltVkoxcDJNTUN0cW5aL3FVYUROeG1v?=
 =?utf-8?B?VW9Gd0hjQ1pnQUdrZ3cxM09hK3pPR2FCZ3NPUFFsNjc2alYrTmRENEZtd1N4?=
 =?utf-8?B?elZJOHMxWkFJZTdIUXVPQTBYbVg3Z21pWUppdVVHN1RPV1NtNzNEWDlINWFN?=
 =?utf-8?B?QVFXQ0ZRMllYcXZ6b2Z3VFVLbFljWXlWcEUrSjF6ckRUM1dSOU1WaWoxRElV?=
 =?utf-8?B?SFZ4Yk02SUU3MmRjMEUzcnduQ0F0eWZ6ZGdlVGsrbVk2eDV3cHQ2OEFyUGxj?=
 =?utf-8?B?RGJEa2hSUm85MHhtOElXQW1saFVyRUVZa1hicncrcStyWTNWSjFOYndBRFpI?=
 =?utf-8?B?NU9FMWRyVzU3MFFvd2c1Yzk0VlJUWm0rQ1FML3A4bXJkN1E1YlFKVzUzNXJq?=
 =?utf-8?B?TTB1TkRERTNEYzF1RXp1QVFHQkxMLzRXRGtGUGtIWlNkRS9YNmNxa2NxQ2Fh?=
 =?utf-8?B?bkpoVFpYa0dHckg1WVgxUjBWTXo5K3MrNUlDNCsrYUxCSytZQVVqMDl2TVlJ?=
 =?utf-8?B?QkRrOTFtdWJPWHp0L2NOU3NRakdyeFlQR2RyQmFPVVhHTXo5clpWeDYwTEt5?=
 =?utf-8?B?eVFrUjlubDlKd0lUN0RqTm1nOXpHQnpBSjAvS1I5SnROdEVDb2xqTkd1eFJz?=
 =?utf-8?B?NzBLNW4zZ0JpY08ySUxFcm1LRlNGZTB0aTJTeXdYeEhENXVQNS9kSStYMlhm?=
 =?utf-8?B?emNOOWVybjc4K01sRHRRMWVEZ3VBeTVaNGI1SUY4cEVHZit1ZlZvOUtRK2Iy?=
 =?utf-8?B?MkxGVU0vVU1qdmV0NU1IUld6UDVCcUxtWWJ1OEd2VHQ0YmtEdDE0d3M5SEhp?=
 =?utf-8?B?dERLbjZJRXoyUFl3VUlCamJDd2xRamRnVnpYd3l3SGoycHRzLzM0b0YxeERJ?=
 =?utf-8?B?eWxlcnl6eUo1cGRBSnY0MGg2UVYxZmljclExejgrTHBzcVJidUdVRE9KYUZQ?=
 =?utf-8?B?dmFwbTBLK3VpZDBrZ0dEQUpWbitvd0JrZnpXd0hidUYvNWRWQS9GVURwL2sr?=
 =?utf-8?B?a1ZtTTRmOXNMdERxVEhpVi90UWNLQjQrRzNwQzcxV1Z2bEhYOGRuRFV0VXlF?=
 =?utf-8?B?OTFTb2xuaGladWVKNzVEQkNYRmFhOUI5Mzg4WEM2bkkrUERrQnROaUxLaVo2?=
 =?utf-8?B?NXNPZDU5SUJKcTE5RnVyL0QyRkw0Z3dhZEpQVU1GNUVsaUdrWmI1NVdDRzdU?=
 =?utf-8?B?d1hocE4xeG1IMHBiM3JVQnUzeHV2Mjc3MHpZb1h3N0k3TE42QXpTeHVuVlFM?=
 =?utf-8?B?cG1kNmlRbFB2bklyUkhRZ0tJdXlNaDdqeEtUbW5VaXFJYjhESkY3NnBLUzdr?=
 =?utf-8?B?MUFXQlRacEYwZTNLaDUyM0gwZTJPdi91Mi9mbVVXNWNsN01aZ2FhejdqNzk3?=
 =?utf-8?B?YWZZdXlxeVBnWEdnTy9FdmYzZGhWTmVCUE02TnhvdGFyMXlQaU53THVWRGFQ?=
 =?utf-8?B?ZG1qKzZYVXZudVVGa2ZTZFY2NHcra2dLTXh5VGR0MlNwOG9NaTZyT2VGVFBJ?=
 =?utf-8?B?UnBEbjE1ckVoNzdYT21kUkQ2TmRHc0xId0dDRUNldHV6S0tBanlyUGF4NzlY?=
 =?utf-8?B?cVlXWkZNSnFmRTlLaTZjWDNPZUVGTTM1dDErMSs5b3ZpUDdXU1FvZ1ZXalN4?=
 =?utf-8?B?RythSERySGxFUG4ya0Vzdk1KeWJGTFgvbnBJM21GbEJFRVJRU0VNVDk2NzRT?=
 =?utf-8?B?ekVGTVo4VHVBTEx2dENyaWh6OU5PVUcwVy90R1AvbGxnV25NMEhMK3pLRi9r?=
 =?utf-8?B?bk9QZG9ZcWlxVHNjdlo0N1ZnTXpTSmR6dndiQW1lRHpyVnBXeUdCUUxscVVY?=
 =?utf-8?B?YUhjUEFEN1RVYzJCeFpGU3c4YU9haS9udTM2VWw2eUxPQTJod3VHVkM3dSto?=
 =?utf-8?Q?b03UHU?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azlLdmZBbUNOUG5aSnVUZXJmOEtBREpxWG4xbk4rN1Rka3c4Q0Jlak4wL0hQ?=
 =?utf-8?B?c0FBcnJBWHVVeC91Q21wZnYzOVFER3NTUWJ6ODZlb3hMQkVxZG02UnlzQjJR?=
 =?utf-8?B?UW5LZUs1NHRySWVyd0J0RVRQZURiUm93OXJQSlR1RDk2b2RGMFE4RU42cWRG?=
 =?utf-8?B?YUdraXRQVHh3Nk1qWUh3cnpkY0VYL3lPS2liUi9oc1hGdjdMaU1HN0RraGpO?=
 =?utf-8?B?dXk0OVRVR09GbmJXZ1FzZlFJOFd4RnlhL21qM0R2d05lR1VUNWZHMVN1ckhi?=
 =?utf-8?B?di92eFMwS3dRZVlmWUMzdHhGSDdyTXhaYVdTNm1TOUtwUTNzUU0yTFZjSXky?=
 =?utf-8?B?TnNhTFNobmRyUjViMEZhK2VhcEFDbmtCNUJ2REFENzRzUGZXOElCYnpHaUlH?=
 =?utf-8?B?aUZ2WTQvVlIwWDlneGxZWllncEZwdGkrTzZxTGgvVlh0UC9IZXNjNk4wMDlI?=
 =?utf-8?B?YXRROFM2WUgxNFVuZU9OczIvWnh0WGlhQ09jby92QnF5Y21vbWpHUXh2aDdC?=
 =?utf-8?B?NVpZb3Y1T0lQcVV0TEMzc01SRlhhNWxsOHlVdkozdmNQSHRLdlpCbDNrWDAv?=
 =?utf-8?B?Z0VpQzAxQ081MkhiTkc2dDF5YWNCV051OERZOHpjUXI4T0pWM0NlUzRGS250?=
 =?utf-8?B?RDQxZ01UMUxmZ2ZMSmIyZVdRbGVjSFQ3ZHVTRUVGYzRyQ1Jpc204bFJUKzgz?=
 =?utf-8?B?SXFrR2c4YXRtSFBaNWFtUHhiakF3SFBtdXQyejJnRUJwc1djMCt5bisrSWUx?=
 =?utf-8?B?TVhuOHVwa2tHeFQ0cHNyNUFUcUlGYlVuckN6UDViMXpDTFk4QTc4NzJ0N1Mx?=
 =?utf-8?B?Yjh6Y1BLczRjVkUvWUtzZXFlSkU1TDNXdDRvNU1heHFod3BUeFUyd2xFa1hz?=
 =?utf-8?B?dkI3MVlMNGs3R1VQcmpPc0ZUa29jeEZ4QVdEcnF1Q3kzMTVRT1c3N1BIRUJV?=
 =?utf-8?B?R2Vyc0lvaFNpQlZXZWxEeXVEalRzazdXMG1jUHFhdng0U1c5OUlKZ3k1d1kx?=
 =?utf-8?B?MCs4MnBhQTdWYWp3NkNSY2xnVGFmUHcvdXhQTEZEcGRQOGlaQVduaEtiZHNO?=
 =?utf-8?B?S1pibGlTVkw4MnQyT0NXcVZYdUlXdlMzZFZBaW5ENUJuRW9hQjZsSVJjcTh5?=
 =?utf-8?B?ZWUzYnNMakEzb3QvVDJQYkZ4aTNwNDFOakJMd2dVeG9XbUlSaXNLTElqY2l1?=
 =?utf-8?B?OStwY1BGQTlMWktCN2JReFFNd0VSVXNMOHh1clF3aXNKQlNLZmIybjR1aUwz?=
 =?utf-8?B?T3Y0c1phVnBjVXp3UTVBUjMzUGZlQmRZQzdITk1wMHVyTEI4RFpJbm1rVFB2?=
 =?utf-8?B?YTdMbU9TOTBSd0F4NHBoK0l6UTM3amNNVlkrcFVqakZZZmV6TjVKcENqMkxP?=
 =?utf-8?B?cUlWM1hiazhWZzAyd3BEWmxRb3J5REI4Y25hdmpuYlBOVzlVeVU2Tmh4RkF1?=
 =?utf-8?B?NEdPbWtJTnBGNjJqbzA5cW5WTmpMTlM4ei9HQnhlR01GeXJUOTJVTHVtU3lJ?=
 =?utf-8?B?cno1RElud0VGNm9TSmJoYnNYVm9rL3JaUDdSUWNBK0FhK2JwRlMxQytPb3dF?=
 =?utf-8?B?d0NGYi9zaEl3U1ZhWGJnc3M1YlRsOHBkejBxb3NmK0pvUy91SzBWcERKVUxP?=
 =?utf-8?B?Tzd6TXdra2c4NVdOSW9oUkV6R3M0R0xWakZ6NGpRWUxDc3FaTXdQTkN1UGhI?=
 =?utf-8?B?dU5RSGlGbXN6d080eFBVZ01ObXhaa0FCZzBUcysrUld1dEx5ZzdmVkQ4MTAx?=
 =?utf-8?B?YXdXVEZ5T2hDR2U3TlBlK1VKckh6R21lOUVDMmZDaWZIY3F5a0o5Y0VLSXVk?=
 =?utf-8?B?M2RvSElzbklhci9hUm9MaStJQXM5SUNlVjRQdG80VWMxRm50L05QbUQremZW?=
 =?utf-8?B?N0ZFWWpReURGWTcwdms5cXFTbWlvV1FXRXZzM0ZHTmdmYzU1dG1PSDNFOE8x?=
 =?utf-8?B?S2RYSWgwT1Fvbm81dm9mQU0xQ1V1V2pYM3ZzOXN0bmZUbnh1OTdDRWJud3Jj?=
 =?utf-8?B?OEt2Mm1INjZaRVJJTjUyeUl4cHprK2lRdEtQbndHaFlyTnN2RDVQeXJTSVQv?=
 =?utf-8?B?WWJrYjNCQWJDc1dZZi95ZUlLZi80d210cDVJZC96SExsenc1QUpRVXA0RXNR?=
 =?utf-8?B?VmYvbUZjU2ZiZlFvMXlIRnNzODlMT01xamJyeTBhRW13UlNvcGhlZ25DTmsy?=
 =?utf-8?B?WGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C657AF626C26140AE3949D2F343036E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da88da8a-c894-4edb-e45c-08de233be75c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2025 05:08:52.4281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1vL67tkMCXk43I8kJwWXv1PVY/t0Z1XbE5sV9tgyqbi0gmNYfV4ygRql6P0Z7HEU4SnhbH6416mSAW57k8KBJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6775

SGkgTHVpeiwNCg0KVGhhbmtzIGZvciByZXZpZXdpbmcgdGhlIHBhdGNoLCBJIHNhdyBteSBwYXRj
aCB3YXMgbWVyZ2VkIHllc3RlcmRheS4NCg0KSG93ZXZlciwgSSBub3RpY2VkIHRoYXQgdGhlcmUg
aXMgYSBtb2RpZmljYXRpb24gdG8gaGNpX2NvcmUuaCB3YXMNCm1lcmdlZCBhbG9uZyB3aXRoIG15
IHBhdGNoIHdoaWNoIHdhc24ndCBteSBjaGFuZ2UuDQpodHRwczovL3dlYi5naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYmx1ZXRvb3RoL2JsdWV0b290aC1uZXh0LmdpdC9j
b21taXQvP2lkPTUyOWFjOGU3MDZjMzA2MmQzYThhZjA3MzlmMDU5MTFhYWNmZmE4NDUNCg0KQ291
bGQgeW91IGhlbHAgdG8gY2hlY2sgaWYgaXQncyBleHBlY3RlZCBvciBub3Q/DQoNCm4gV2VkLCAy
MDI1LTExLTEyIGF0IDE1OjUzICswODAwLCBDaHJpcyBMdSB3cm90ZToNCj4gV2hlbiBwZXJmb3Jt
aW5nIHJlc2V0IHRlc3RzIGFuZCBlbmNvdW50ZXJpbmcgYWJub3JtYWwgY2FyZCBkcm9wDQo+IGlz
c3Vlcw0KPiB0aGF0IGxlYWQgdG8gYSBrZXJuZWwgY3Jhc2gsIGl0IGlzIG5lY2Vzc2FyeSB0byBw
ZXJmb3JtIGEgbnVsbCBjaGVjaw0KPiBiZWZvcmUgcmVsZWFzaW5nIHJlc291cmNlcyB0byBhdm9p
ZCBhdHRlbXB0aW5nIHRvIHJlbGVhc2UgYSBudWxsDQo+IHBvaW50ZXIuDQo+IA0KPiA8ND5bwqDC
oCAyOS4xNTgwNzBdIEhhcmR3YXJlIG5hbWU6IEdvb2dsZSBRdWlnb24gc2t1MTk2NjEyLzE5NjYx
MyBib2FyZA0KPiAoRFQpDQo+IDw0PlvCoMKgIDI5LjE1ODA3Nl0gV29ya3F1ZXVlOiBoY2kwIGhj
aV9jbWRfc3luY193b3JrIFtibHVldG9vdGhdDQo+IDw0PlvCoMKgIDI5LjE1ODE1NF0gcHN0YXRl
OiAyMDQwMDAwOSAobnpDdiBkYWlmICtQQU4gLVVBTyAtVENPIC1ESVQgLQ0KPiBTU0JTIEJUWVBF
PS0tKQ0KPiA8ND5bwqDCoCAyOS4xNTgxNjJdIHBjIDoga2xpc3RfcmVtb3ZlKzB4OTAvMHgxNTgN
Cj4gPDQ+W8KgwqAgMjkuMTU4MTc0XSBsciA6IGtsaXN0X3JlbW92ZSsweDg4LzB4MTU4DQo+IDw0
PlvCoMKgIDI5LjE1ODE4MF0gc3AgOiBmZmZmZmZjMDg0NmIzYzAwDQo+IDw0PlvCoMKgIDI5LjE1
ODE4NV0gcG1yX3NhdmU6IDAwMDAwMGUwDQo+IDw0PlvCoMKgIDI5LjE1ODE4OF0geDI5OiBmZmZm
ZmZjMDg0NmIzYzMwIHgyODogZmZmZmZmODBjZDMxZjg4MCB4Mjc6DQo+IGZmZmZmZjgwYzFiZGMw
NTgNCj4gPDQ+W8KgwqAgMjkuMTU4MTk5XSB4MjY6IGRlYWQwMDAwMDAwMDAxMDAgeDI1OiBmZmZm
ZmZkYmRjNjI0ZWEzIHgyNDoNCj4gZmZmZmZmODBjMWJkYzRjMA0KPiA8ND5bwqDCoCAyOS4xNTgy
MDldIHgyMzogZmZmZmZmZGJkYzYyYTNlNiB4MjI6IGZmZmZmZjgwYzZjMDcwMDAgeDIxOg0KPiBm
ZmZmZmZkYmRjODI5MjkwDQo+IDw0PlvCoMKgIDI5LjE1ODIxOV0geDIwOiAwMDAwMDAwMDAwMDAw
MDAwIHgxOTogZmZmZmZmODBjZDNlMDY0OCB4MTg6DQo+IDAwMDAwMDAzMWVjOTc3ODENCj4gPDQ+
W8KgwqAgMjkuMTU4MjI5XSB4MTc6IGZmZmZmZjgwYzFiZGM0YTggeDE2OiBmZmZmZmZkYzEwNTc2
NTQ4IHgxNToNCj4gZmZmZmZmODBjMTE4MDQyOA0KPiA8ND5bwqDCoCAyOS4xNTgyMzhdIHgxNDog
MDAwMDAwMDAwMDAwMDAwMCB4MTM6IDAwMDAwMDAwMDAwMGUzODAgeDEyOg0KPiAwMDAwMDAwMDAw
MDAwMDE4DQo+IDw0PlvCoMKgIDI5LjE1ODI0OF0geDExOiBmZmZmZmY4MGMyYTdmZDEwIHgxMDog
MDAwMDAwMDAwMDAwMDAwMCB4OSA6DQo+IDAwMDAwMDAxMDAwMDAwMDANCj4gPDQ+W8KgwqAgMjku
MTU4MjU3XSB4OCA6IDAwMDAwMDAwMDAwMDAwMDAgeDcgOiA3ZjdmN2Y3ZjdmN2Y3ZjdmIHg2IDoN
Cj4gMmQ3MjIzZmY2MzY0NjI2ZA0KPiA8ND5bwqDCoCAyOS4xNTgyNjZdIHg1IDogMDAwMDAwODAw
MDAwMDAwMCB4NCA6IDAwMDAwMDAwMDAwMDAwMjAgeDMgOg0KPiAyZTczMjUwMDY0NjU2MzZlDQo+
IDw0PlvCoMKgIDI5LjE1ODI3NV0geDIgOiBmZmZmZmZkYzExYWZlZmY4IHgxIDogMDAwMDAwMDAw
MDAwMDAwMCB4MCA6DQo+IGZmZmZmZmRjMTFiZTRkMGMNCj4gPDQ+W8KgwqAgMjkuMTU4Mjg1XSBD
YWxsIHRyYWNlOg0KPiA8ND5bwqDCoCAyOS4xNTgyOTBdwqAga2xpc3RfcmVtb3ZlKzB4OTAvMHgx
NTgNCj4gPDQ+W8KgwqAgMjkuMTU4Mjk4XcKgIGRldmljZV9yZWxlYXNlX2RyaXZlcl9pbnRlcm5h
bCsweDIwYy8weDI2OA0KPiA8ND5bwqDCoCAyOS4xNTgzMDhdwqAgZGV2aWNlX3JlbGVhc2VfZHJp
dmVyKzB4MWMvMHgzMA0KPiA8ND5bwqDCoCAyOS4xNTgzMTZdwqAgdXNiX2RyaXZlcl9yZWxlYXNl
X2ludGVyZmFjZSsweDcwLzB4ODgNCj4gPDQ+W8KgwqAgMjkuMTU4MzI1XcKgIGJ0dXNiX210a19y
ZWxlYXNlX2lzb19pbnRmKzB4NjgvMHhkOCBbYnR1c2INCj4gKEhBU0g6ZThiNiA1KV0NCj4gPDQ+
W8KgwqAgMjkuMTU4MzQ3XcKgIGJ0dXNiX210a19yZXNldCsweDVjLzB4NDgwIFtidHVzYiAoSEFT
SDplOGI2IDUpXQ0KPiA8ND5bwqDCoCAyOS4xNTgzNjFdwqAgaGNpX2NtZF9zeW5jX3dvcmsrMHgx
MGMvMHgxODggW2JsdWV0b290aA0KPiAoSEFTSDphNGZhIDYpXQ0KPiA8ND5bwqDCoCAyOS4xNTg0
MzBdwqAgcHJvY2Vzc19zY2hlZHVsZWRfd29ya3MrMHgyNTgvMHg0ZTgNCj4gPDQ+W8KgwqAgMjku
MTU4NDQxXcKgIHdvcmtlcl90aHJlYWQrMHgzMDAvMHg0MjgNCj4gPDQ+W8KgwqAgMjkuMTU4NDQ4
XcKgIGt0aHJlYWQrMHgxMDgvMHgxZDANCj4gPDQ+W8KgwqAgMjkuMTU4NDU1XcKgIHJldF9mcm9t
X2ZvcmsrMHgxMC8weDIwDQo+IDwwPlvCoMKgIDI5LjE1ODQ2N10gQ29kZTogOTEzNDMwMDAgOTQw
MTM5ZDEgZjk0MDAyNjggOTI3ZmY5MTQNCj4gKGY5NDAxMjk3KQ0KPiA8ND5bwqDCoCAyOS4xNTg0
NzRdIC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiA8MD5bwqDCoCAyOS4x
NjcxMjldIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBPb3BzOiBGYXRhbCBleGNlcHRpb24N
Cj4gPDI+W8KgwqAgMjkuMTY3MTQ0XSBTTVA6IHN0b3BwaW5nIHNlY29uZGFyeSBDUFVzDQo+IDw0
PlvCoMKgIDI5LjE2NzE1OF0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+
IA0KPiBGaXhlczogY2VhYzFjYjAyNTlkICgiQmx1ZXRvb3RoOiBidHVzYjogbWVkaWF0ZWs6IGFk
ZCBJU08gZGF0YQ0KPiB0cmFuc21pc3Npb24gZnVuY3Rpb25zIikNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IENocmlzIEx1IDxjaHJpcy5sdUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMv
Ymx1ZXRvb3RoL2J0dXNiLmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
DQo+IMKgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYyBiL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0dXNiLmMNCj4gaW5kZXggZTBlMzBmMDBhNjc4Li5mY2M2MmUyZmI2NDEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gKysrIGIvZHJpdmVycy9ibHVl
dG9vdGgvYnR1c2IuYw0KPiBAQCAtMjc0MSw5ICsyNzQxLDE2IEBAIHN0YXRpYyBpbnQgYnR1c2Jf
cmVjdl9ldmVudF9yZWFsdGVrKHN0cnVjdA0KPiBoY2lfZGV2ICpoZGV2LCBzdHJ1Y3Qgc2tfYnVm
ZiAqc2tiKQ0KPiDCoA0KPiDCoHN0YXRpYyB2b2lkIGJ0dXNiX210a19jbGFpbV9pc29faW50Zihz
dHJ1Y3QgYnR1c2JfZGF0YSAqZGF0YSkNCj4gwqB7DQo+IC0Jc3RydWN0IGJ0bXRrX2RhdGEgKmJ0
bXRrX2RhdGEgPSBoY2lfZ2V0X3ByaXYoZGF0YS0+aGRldik7DQo+ICsJc3RydWN0IGJ0bXRrX2Rh
dGEgKmJ0bXRrX2RhdGE7DQo+IMKgCWludCBlcnI7DQo+IMKgDQo+ICsJaWYgKCFkYXRhLT5oZGV2
KQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gKwlidG10a19kYXRhID0gaGNpX2dldF9wcml2KGRhdGEt
PmhkZXYpOw0KPiArCWlmICghYnRtdGtfZGF0YSkNCj4gKwkJcmV0dXJuOw0KPiArDQo+IMKgCS8q
DQo+IMKgCSAqIFRoZSBmdW5jdGlvbiB1c2JfZHJpdmVyX2NsYWltX2ludGVyZmFjZSgpIGlzIGRv
Y3VtZW50ZWQNCj4gdG8gbmVlZA0KPiDCoAkgKiBsb2NrcyBoZWxkIGlmIGl0J3Mgbm90IGNhbGxl
ZCBmcm9tIGEgcHJvYmUgcm91dGluZS4gVGhlDQo+IGNvZGUgaGVyZQ0KPiBAQCAtMjc2NSwxNyAr
Mjc3MiwzMCBAQCBzdGF0aWMgdm9pZCBidHVzYl9tdGtfY2xhaW1faXNvX2ludGYoc3RydWN0DQo+
IGJ0dXNiX2RhdGEgKmRhdGEpDQo+IMKgDQo+IMKgc3RhdGljIHZvaWQgYnR1c2JfbXRrX3JlbGVh
c2VfaXNvX2ludGYoc3RydWN0IGhjaV9kZXYgKmhkZXYpDQo+IMKgew0KPiAtCXN0cnVjdCBidG10
a19kYXRhICpidG10a19kYXRhID0gaGNpX2dldF9wcml2KGhkZXYpOw0KPiArCXN0cnVjdCBidG10
a19kYXRhICpidG10a19kYXRhOw0KPiArDQo+ICsJaWYgKCFoZGV2KQ0KPiArCQlyZXR1cm47DQo+
ICsNCj4gKwlidG10a19kYXRhID0gaGNpX2dldF9wcml2KGhkZXYpOw0KPiArCWlmICghYnRtdGtf
ZGF0YSkNCj4gKwkJcmV0dXJuOw0KPiDCoA0KPiDCoAlpZiAodGVzdF9iaXQoQlRNVEtfSVNPUEtU
X09WRVJfSU5UUiwgJmJ0bXRrX2RhdGEtPmZsYWdzKSkgew0KPiDCoAkJdXNiX2tpbGxfYW5jaG9y
ZWRfdXJicygmYnRtdGtfZGF0YS0+aXNvcGt0X2FuY2hvcik7DQo+IMKgCQljbGVhcl9iaXQoQlRN
VEtfSVNPUEtUX1JVTk5JTkcsICZidG10a19kYXRhLT5mbGFncyk7DQo+IMKgDQo+IC0JCWRldl9r
ZnJlZV9za2JfaXJxKGJ0bXRrX2RhdGEtPmlzb3BrdF9za2IpOw0KPiAtCQlidG10a19kYXRhLT5p
c29wa3Rfc2tiID0gTlVMTDsNCj4gLQkJdXNiX3NldF9pbnRmZGF0YShidG10a19kYXRhLT5pc29w
a3RfaW50ZiwgTlVMTCk7DQo+IC0JCXVzYl9kcml2ZXJfcmVsZWFzZV9pbnRlcmZhY2UoJmJ0dXNi
X2RyaXZlciwNCj4gLQkJCQkJwqDCoMKgwqAgYnRtdGtfZGF0YS0NCj4gPmlzb3BrdF9pbnRmKTsN
Cj4gKwkJaWYgKGJ0bXRrX2RhdGEtPmlzb3BrdF9za2IpIHsNCj4gKwkJCWRldl9rZnJlZV9za2Jf
aXJxKGJ0bXRrX2RhdGEtPmlzb3BrdF9za2IpOw0KPiArCQkJYnRtdGtfZGF0YS0+aXNvcGt0X3Nr
YiA9IE5VTEw7DQo+ICsJCX0NCj4gKw0KPiArCQlpZiAoYnRtdGtfZGF0YS0+aXNvcGt0X2ludGYp
IHsNCj4gKwkJCXVzYl9zZXRfaW50ZmRhdGEoYnRtdGtfZGF0YS0+aXNvcGt0X2ludGYsDQo+IE5V
TEwpOw0KPiArCQkJdXNiX2RyaXZlcl9yZWxlYXNlX2ludGVyZmFjZSgmYnR1c2JfZHJpdmVyLA0K
PiArCQkJCQkJwqDCoMKgwqAgYnRtdGtfZGF0YS0NCj4gPmlzb3BrdF9pbnRmKTsNCj4gKwkJCWJ0
bXRrX2RhdGEtPmlzb3BrdF9pbnRmID0gTlVMTDsNCj4gKwkJfQ0KPiDCoAl9DQo+IMKgDQo+IMKg
CWNsZWFyX2JpdChCVE1US19JU09QS1RfT1ZFUl9JTlRSLCAmYnRtdGtfZGF0YS0+ZmxhZ3MpOw0K
DQpUaGFua3MgYSBsb3QhLA0KQ2hyaXMgTHUNCg==
