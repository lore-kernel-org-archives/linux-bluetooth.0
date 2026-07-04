Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592811AAE17;
	Sat,  4 Jul 2026 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783136294; cv=fail; b=ujimkLaugOkVKM+jbpB80ZmKw+2xQrnZCfVhRnOKUP3UDel7NEw+Sx8XHHEW5pxSqRzzH40sBXl76FeFmGdz2Mm0NhZ6SWpnAh6OUjyA/SYZoX162sHygHfUcwcwcMyZltPboFgPYz91BYiwyYAWI6xXUBEy1tXXKZvEi3fRA8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783136294; c=relaxed/simple;
	bh=ysGn5g3darENVtxUKBupojlReEatJFEXuoyvfR3Zq8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=paI0Z0ZSUSnkVMHMpT+fHL+YBj25eCP9EHEcvDiDwMFfXGsJDzi60orW5ocyxT1Af6hEB0Esxzc9ospH9/aG/b+JaIPbXTvi0AngOIW6Ek3OFdeiWFrf8mumS05BKEcqTX28Wo+teLmFsVlVM9zW959swxKek4SgGGtOZxAjf5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=WHLIJveu; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=I//je1gM; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="WHLIJveu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="I//je1gM"
X-UUID: bf1eacac775911f18dc8c9802ae25ab1-20260704
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ysGn5g3darENVtxUKBupojlReEatJFEXuoyvfR3Zq8I=;
	b=WHLIJveuMY91cIq8TczmAOYzUOTLDqVSkvn762T7h3r4M+GuRzJNY1y6hU1p4vYBdhqUi9XiDOZOOIiN1achKoJjaMaz33jTJOlF/0lRgmOxCECsZyn39O3LEAmgmAedY3TFjTcFYeV8k4AfxrVuRg0SEELdaPN1f/MvLZ6p2Yc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:8bb142b5-cab3-4b3f-abc6-fd75820cab14,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:d497b38,CLOUDID:0e62d0d6-4504-45e1-b7e4-0b9331be048a,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
	:-5,Content:0|15|50|99|200|213,EDM:-3|-100,IP:nil,URL:11|94|82|106|1,File:
	130,RT:0,Bulk:nil,QS:nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: bf1eacac775911f18dc8c9802ae25ab1-20260704
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1735342895; Sat, 04 Jul 2026 11:37:56 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Sat, 4 Jul 2026 11:37:55 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Sat, 4 Jul 2026 11:37:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bjg+lQ97PSmmcerF1QUXcAJQnOywxCCPv5i8NkjONr7eKfC1wqIRB2T9Eil+ioiY/7LlHeY6Z2r3GCwQQWSL8up0Hxr0L131QDx8BZaENcfLEsjD+/xJPTJatrlMtfmIWNg8M84ppO4+0BPb3LTdXEJKA5oAObRTyF0z1TbRHC60SZiwJS+h+Y/Y1ezHTylBQVaXDqprfCW9hS1RQ7Ad9pWrb+4EkduFvf2HAi2D+A7jX1D5YGMl9Eeo66JZZdD1QSG39J9ql6RnTPM5O6Rl17GvghlEe+redRet/3VFxStYge9OAIbYMmD4huo86sxKiWtRGKKElw5Eq+FRzBK8Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysGn5g3darENVtxUKBupojlReEatJFEXuoyvfR3Zq8I=;
 b=seHcLizsZIXn3zuHaY73FBgJ3lsdmfT+idqOavdw7tG1UmMxW0GEqu+g1mYWTu4EiOPyNbGpyWwuIFSwkl5gZm+3lr2Nsj3NJ0/Smofpr0CXosqdgpZeSPZKM4MxHY/i6vboqU3qiG3hAHdl7NT4m6kFz2bJuhlov8+ZJNEuAj7k+zeLY9tQYP7G/43UJTnqgRRKCj2NjJd/VVwW1Sn1f3ugnKQRihfxM5z6lrcwCaIoGEITZBFVposCDPcMzUI7ZzeAbEWwtYBZcbewsLsLbVm2rCVgBnwB09fCDkhlXvgfrgwridaFZmnHbAEzC96Eyu7AQ646dH2jquboV1mzlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysGn5g3darENVtxUKBupojlReEatJFEXuoyvfR3Zq8I=;
 b=I//je1gM60YbaAkFZqF2M0TBbdh5PxWsNC26l+yjJ3lR/iwpUR+R8UPZSGTMw+piL6mCRRv7+aGJj/XRyfBx/MqewY6JR0B1dIFyGOKxMAFcwbvHiZAtf3mGfdw2KoCpGMe/7BuifJnJiGBv/6x+82yXcuAyGbHjVmmaBwtf/Pk=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by TY0PR03MB7239.apcprd03.prod.outlook.com (2603:1096:400:277::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Sat, 4 Jul 2026
 03:37:52 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%4]) with mapi id 15.21.0181.010; Sat, 4 Jul 2026
 03:37:52 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "marcel@holtmann.org" <marcel@holtmann.org>
CC: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
	=?utf-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
	=?utf-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sean Wang
	<Sean.Wang@mediatek.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v9 0/6] Bluetooth: btmtk: Add MT7928 support
Thread-Topic: [PATCH v9 0/6] Bluetooth: btmtk: Add MT7928 support
Thread-Index: AQHdCguc/4B4RId4YUqTkHFQPNRU1LZcuOOA
Date: Sat, 4 Jul 2026 03:37:52 +0000
Message-ID: <12d1d3bd5c8c270e5118ec327b14ba8b1aee5d76.camel@mediatek.com>
References: <20260702101437.1787800-1-chris.lu@mediatek.com>
In-Reply-To: <20260702101437.1787800-1-chris.lu@mediatek.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|TY0PR03MB7239:EE_
x-ms-office365-filtering-correlation-id: baf9037d-8a3d-44e3-7250-08ded97da0a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|38070700021|22082099003|18002099003|3023799007|11063799006|56012099006;
x-microsoft-antispam-message-info: jmNjjFppkE6L7r8G/l2v5utBs2/rT0KanCkCd7EfyuUFE+xO7C4H40tSeQpZnjRc9Vxu4I6kDe9qKahVHZSr8sjygzW0ZwrXXMlUsvfDMqNv1SRaliD2pHPEETL+fyk2qoBQxyTzHIROaiyJpIOcWkMJW5Ev675a31RAiuWtRBzZm8yoL2R6xiK8apvlIPCet5E3XIy/R/nanWON86hDlvgqmJCeERO/5qBlATDe1aCQCVjS88clKR/8MH1VyCuBVhZKfkf59YzmoT2rOnvIxZf4VmjABgt2UeHtace0GBecA3+eA421lOGBhOdTqPq4EEFNgAx+AqlMPp2axM0lGjXHJDLSBzyvXWoBPCaGYS5P7lRfAF1db0VZdXpUWFN4PnRVrS/K8ykiXLKNtmbe3pSSwwtpkaqGJgbtDbQh6Xr9PeqQMuECo5sh2YOmXM5FmxZnms70r7QfDeXVJd6v59dQfMSBL5UJxIwWM+utMnZSNfONBCblY9YDg4lTzfgtOwG9T5v8xKbiB1YPH5Tg+XyD+SF4ptTWbxZKIr1yig5Yci9tAf44y4VmWz8lLeafAAcvATfmlO9tbjzkh58ipsujh+Mp2JLtHnlO96t5Mk1a4To2sV7ok678gN+yj0qOmeR89xdqc2j4CgMWr29YvnPkFzQWJStcaTw29CSdksg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(38070700021)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SklwcHRSdGU5bEFuV2ZScWRNVVcwU0ZydHJucUFWMUNOVFZkdlkyZ2V2UEww?=
 =?utf-8?B?UnQ2Wm5XS1JpSnI0SDBiSmZrUHFHL3l6SlkreXhxRy9pTERpMVdSNGxEbWI3?=
 =?utf-8?B?c2c5R2hMV2pnQWJZS1pOb2t4RkVCclA0akt0QURsUWxZTVBBTEtKeGJwdDJ0?=
 =?utf-8?B?NzQ2OTlnYkppWCtGTGhqZzdIK2Jvc3dJSnVzRUpjejlJdFlTNk9oN1k1RThw?=
 =?utf-8?B?dlNPeXBONUUvZEZ4RjdBbDc0RXdIa1Jwa3hRN1BCbjFzcUhqWnV5RVpRbFpv?=
 =?utf-8?B?TWJnZXkxUHVrQ0pQaE0zeGFZQjFaa3Bid2FKYTVFaW41WmZ2UUI3UFRyYUNF?=
 =?utf-8?B?czl2bzBlMjBQTWxScjNXN0FkdW14VWIyb04yTXZ3WVhDUTRkeGQ0eDBnTGUx?=
 =?utf-8?B?dlV4NHIrUW16cjZmdWZyNkFPdGIvMEFIYWp4SHEvekFJc0NIVXZKaFhZVjlG?=
 =?utf-8?B?R0JPdllhaU9kYW5pQTRWTXdHR0Q2ZjhDd01oSzJ4dDN5c0pZTHpIUXlHYk11?=
 =?utf-8?B?RHNYWFJvcjRRQnZjSEFtQitjcVZ3K21JaWZmREYwNjNNWU5od1FMTHhYakFv?=
 =?utf-8?B?K2NiL0E5Tk9UTFJYeGwwQ0RnN1NEa1RQbkxHR0JkME40Sm93elYwd2JxWHk3?=
 =?utf-8?B?d2ZpckJRU2Z0VEJNaFpwRkFkMDBHem5NSEVmUTNPTCtueGxHRVdCQm5Tb0NU?=
 =?utf-8?B?RFlGaHplNTFvOHFNczZHMVRURVpEM09GbThzZ3F6Z0tVenVGUzJkVzQ2Zyt0?=
 =?utf-8?B?cGRSZnN2QnpZdi82aG8yZWIzaFdKRXJFVlVqUzNyS1J5bGh1S1hNcUtLNlhH?=
 =?utf-8?B?eXBkZFJZQmt6d0tWT05aNFpnbGZ5TG9naFhUUTQxQlE5TmVaSkxRSXlyRTA5?=
 =?utf-8?B?NlcxY2p4V0FWOTVpNDNJMkEwbmcyNm14UUUvdERFS1c4dHEwM2RReEJsazBO?=
 =?utf-8?B?dSs4cmdVcWJPT3d6UWxtdVZRckZNMjdyblZIZS9xVzllS2NOTFlxM3VBZU0z?=
 =?utf-8?B?UncwUFQyVGZ6VEQ2ejhQcUxvekVhMEVwVHlJaHhNZG9LNnhkcXNOMDQrTTdQ?=
 =?utf-8?B?Q0U1Y21Jd1pycUEvZng4cytTbmNyVms0anMyK2xvVUl1b1R4aC9vNnRaaVNx?=
 =?utf-8?B?bHNRT3hmd0FMNE4vRU9mWlZldWFxcjhHTUFxeDh0aUlkdjY3TEJQQjFvQnZx?=
 =?utf-8?B?Y1FVaHFrNkdqSUFhODdWYUczdHZSYmYycjA3UEczMFMwOGpsRUZZR3ZlNVly?=
 =?utf-8?B?aFV5MmJjOHRRZ0JKMHp6SmM2Qko3S2p1aWRJTDhBN1lXQXIvaHNKQnh3MUNT?=
 =?utf-8?B?bkwwbno4Nlg3MTdiZXVETWtBeFNDQzVnakxQM3pXV0tZSEtmT3Fjem5naUk3?=
 =?utf-8?B?elF0U2JNcjZjVEN2S1c1ckh3YkxOOTN3Q0RCcThjbHZqNDBETnkwU0Vadnlt?=
 =?utf-8?B?WXFBNEorN1BibGlGNTh2RVVZOEt5ZjNIaGI1TDM3Z1JoM3dUNDAxT3JLVjMx?=
 =?utf-8?B?T3ZqS21MSzYrWFlNN2R5c0htdi9EaXpEOE1WSFhUMzhlSS84eVhrMW54Vi9T?=
 =?utf-8?B?dmYzL0Z0Q2JpNkZyWHNpb2MwNDZ5L3hXYXZHa3JpWG9NZkg0WHpRM0FHczJn?=
 =?utf-8?B?RUxTWVBaQ3NXb3NvUnZJMHJscDNVbnl6TU9mSGxHMmxpL0Nwd2dmNHEzY3dK?=
 =?utf-8?B?M2tEQ2xHdjFhYWFJRUVxSnhmZFR1RE9tMFIvU3pLNnpZeTg0SUgzanZ6Qnh2?=
 =?utf-8?B?NlpFWExoYlhLM0VpdmErSkljRmNTQWVPVldDNTU5WEdNN0lIdlpCWlp3bzFq?=
 =?utf-8?B?Y3ZTMkpyd21SZnl0NThSZlRBMnJ2T3NQWTNWWUNhc25xbm90MlRnay9oaFcy?=
 =?utf-8?B?eFE4cWdZbmdueUgrMFprQ2FkZllFYlMzWEUwOEJseTRuSktDNjdqVm82dEhE?=
 =?utf-8?B?WHVmMy9ERkEwcGM4Yytrd3lwSDJCclY2dDI1VCt0NjhlMXZIUW9GdFpYQnU2?=
 =?utf-8?B?Z1pWeUNzcndSdVN0aHNtMStZc1oxSlY3MVlNa2dVbDM5bGRRaCtpcWF6NjVF?=
 =?utf-8?B?UVVwQzdvSHdmVEU1ZjBHWDhWb3F2ZzUrTzBudjNJWEFBdHc3MUhEQTRsZnRF?=
 =?utf-8?B?ZHA3dklXdkJacVVnbXFyTDdjeUdvbVVNYWp0anBxOVlXbEx5T0hncTM0d2NH?=
 =?utf-8?B?Wm1JRFV3V1IzNmhBRzZUY2o3dTJzTFBsTFcxRGJWRDF6UndsakswWkN3dGdI?=
 =?utf-8?B?L2V5dkU1cGlDcm80OEJRUU4ycTlSUFRZOVBOdUYvZHkzZlN6R2EzK1ZNZnIy?=
 =?utf-8?B?WGpEaXBkWGR6UWh6VW1DTnpubytEZ3pHbGkwdGZoSHhwclBkc1o2YjNrNDNY?=
 =?utf-8?Q?x3KrbQOiZa8CK398=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0E0AFFDBB66F147AC5A2D1AD990A303@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ioIQxraoOosIiM6r3cQCG8l8I/0KKSxDvIxOujkpH2RQrqmo93pkXzF/A7xgqtlA6BHuA5yzxGMqNdneACR19ShY1MF22pdAl7Mf6Lh3qo1+yxAIVpfVUxudBsYjWwmTC91KZEOdFDidsLMhial5YHUVqn5D5CqVUJF1de4qSimd/KL6RU96yZ6clskru6h90M8m7mAuj3CRatf68D0dhbYZN63UjUHd77CZiQ8Ifw58ajgN1dZJcaW6TpwGkyQ34ySc/4P84jt0U9QkCaFD0aDqh8qNdPH+aTfpl93fjilqjnxWTTi2+93kvvts5QtE7EWld+3jYUPOqOKIQgEbvQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf9037d-8a3d-44e3-7250-08ded97da0a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2026 03:37:52.2211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wq2vrbdRx9omV2xECM0uD6j9JfpwekBeCcGYstPHssGSzLQIIq+bWcrAuctALorueSYLDZoaOYl15wH7nmFtNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB7239

SGkgTHVpeiwNCg0KT24gVGh1LCAyMDI2LTA3LTAyIGF0IDE4OjE0ICswODAwLCBDaHJpcyBMdSB3
cm90ZToNCj4gVGhpcyBwYXRjaCBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciBNVDc5MjggKGRldmlj
ZSBJRCAweDc5MzUpIHRvIHRoZQ0KPiBidG10ayBkcml2ZXIsIHdoaWNoIHJlcXVpcmVzIGEgbmV3
IHR3by1zdGFnZSBmaXJtd2FyZSBsb2FkaW5nIHByb2Nlc3MNCj4gd2l0aCBDQk1DVSBmaXJtd2Fy
ZS4NCj4gDQo+IFRoZSBzZXJpZXMgaXMgb3JnYW5pemVkIHRvIGZpeCBleGlzdGluZyBpc3N1ZXMg
Zmlyc3QsIHRoZW4gaW1wcm92ZQ0KPiBjb2RlDQo+IHF1YWxpdHksIGFuZCBmaW5hbGx5IGFkZCBu
ZXcgZnVuY3Rpb25hbGl0eToNCj4gDQo+IFBhdGNoIDEgZml4ZXMgYSBwcmUtZXhpc3Rpbmcgc2Vj
dXJpdHkgaXNzdWUgaW4NCj4gYnRtdGtfc2V0dXBfZmlybXdhcmVfNzl4eCgpDQo+IGJ5IGFkZGlu
ZyBjb21wcmVoZW5zaXZlIGZpcm13YXJlIHNpemUgdmFsaWRhdGlvbiB0byBwcmV2ZW50IG91dC1v
Zi0NCj4gYm91bmRzDQo+IG1lbW9yeSBhY2Nlc3Mgd2l0aCB0cnVuY2F0ZWQgb3IgbWFsaWNpb3Vz
IGZpcm13YXJlIGZpbGVzLg0KPiANCj4gUGF0Y2ggMiBmaXhlcyBhIHByZS1leGlzdGluZyBidWcg
aW4gYnRtdGtzZGlvX3NldHVwKCkgd2hlcmUNCj4gYnRtdGtfZndfZ2V0X2ZpbGVuYW1lKCkgZ2Vu
ZXJhdGVzIHRoZSBjb3JyZWN0IGZpcm13YXJlIHBhdGggYnV0IGlzDQo+IGltbWVkaWF0ZWx5IG92
ZXJ3cml0dGVuIGJ5IHNucHJpbnRmKCkgd2l0aCBhIGdlbmVyaWMgbGVnYWN5IGZvcm1hdCwNCj4g
Y2F1c2luZyBuZXdlciBjaGlwcyB0byByZXF1ZXN0IGluY29ycmVjdCBmaWxlbmFtZXMuDQo+IA0K
PiBQYXRjaCAzIGZpeGVzIGEgcmVncmVzc2lvbiBpbnRyb2R1Y2VkIGluIGNvbW1pdCAyOGI3YzVh
NmRiNzQNCj4gKCJCbHVldG9vdGg6IGJ0bXRrOiBBZGQgTVQ2NjM5IChNVDc5MjcpIEJsdWV0b290
aCBzdXBwb3J0Iikgd2hlcmUNCj4gU0RJTyBkZXZpY2VzIHdvdWxkIGluY29ycmVjdGx5IGxvZyAi
QlQgSFcgdmVyOiAweDAwMDAiIGR1ZSB0bw0KPiBoYXJkY29kZWQgZGV2X2lkPTAuDQo+IA0KPiBQ
YXRjaCA0IHJlZmFjdG9ycyBleGlzdGluZyBmaXJtd2FyZSBkb3dubG9hZCBjb2RlIGJ5IHJlcGxh
Y2luZyBtYWdpYw0KPiBudW1iZXJzIHdpdGggYSBkZXNjcmlwdGl2ZSBCVE1US19XTVRfUEtUXyog
ZW51bSwgbWFraW5nIHRoZSBwYWNrZXQNCj4gc2VxdWVuY2luZyBsb2dpYyBjbGVhcmVyLg0KPiAN
Cj4gUGF0Y2ggNSBpbXByb3ZlcyBCVCBmaXJtd2FyZSBsb2dnaW5nIHRvIHByb3ZpZGUgbW9yZSB1
c2VmdWwNCj4gaW5mb3JtYXRpb24NCj4gZm9yIGRlYnVnZ2luZzogYWRkcyBmaXJtd2FyZSBmaWxl
bmFtZSBiZWZvcmUgbG9hZGluZyBhbmQgZGlzcGxheXMNCj4gY2hpcCBJRA0KPiBhcyBIVyB2ZXJz
aW9uIGluc3RlYWQgb2YgZmlybXdhcmUncyBod3ZlciBmaWVsZC4NCj4gDQo+IFBhdGNoIDYgaW1w
bGVtZW50cyBNVDc5MjggZmlybXdhcmUgZG93bmxvYWQgZmxvdywgd2hpY2ggcmVxdWlyZXMNCj4g
bG9hZGluZw0KPiBDQk1DVSBmaXJtd2FyZSBiZWZvcmUgQmx1ZXRvb3RoIGZpcm13YXJlLiBUaGUg
Q0JNQ1UgZmlybXdhcmUgdXNlcyBhDQo+IHR3by1waGFzZSBkb3dubG9hZCBzZXF1ZW5jZTogUGhh
c2UgMSBkb3dubG9hZHMgdGhlIHNlY3Rpb24gY29udGFpbmluZw0KPiBnbG9iYWwgZGVzY3JpcHRv
ciBhbmQgc2lnbmF0dXJlIGRhdGEsIFBoYXNlIDIgZG93bmxvYWRzIHRoZSByZW1haW5pbmcNCj4g
ZmlybXdhcmUgc2VjdGlvbnMuDQo+IA0KPiBUZXN0ZWQgb24gTVQ3OTI4IGhhcmR3YXJlIHdpdGgg
c3VjY2Vzc2Z1bCBmaXJtd2FyZSBsb2FkaW5nIGFuZA0KPiBCbHVldG9vdGggZnVuY3Rpb25hbGl0
eSB2ZXJpZmljYXRpb24uDQo+IA0KPiBDaGFuZ2VzIGluIHY5Og0KPiAtIFJlb3JkZXIgcGF0Y2hl
cyB0byBncm91cCBTRElPIGZpeGVzIHRvZ2V0aGVyIChQYXRjaCAyLTMpDQo+IC0gUGF0Y2ggMSAo
d2FzIFBhdGNoIDIpOiBGaXggZmlybXdhcmUgc2l6ZSB2YWxpZGF0aW9uIGluDQo+IMKgIGJ0bXRr
X3NldHVwX2Zpcm13YXJlXzc5eHgoKQ0KPiAtIFBhdGNoIDIgKHdhcyBQYXRjaCAxKTogRml4IGZp
cm13YXJlIGZpbGVuYW1lIG92ZXJyaWRlIGluDQo+IMKgIGJ0bXRrc2Rpb19zZXR1cCgpDQo+IMKg
IGJ0bXRrX2Z3X2dldF9maWxlbmFtZSgpIHJlc3VsdCB3YXMgaW5jb3JyZWN0bHkgb3ZlcndyaXR0
ZW4gYnkNCj4gwqAgc25wcmludGYoKQ0KPiANCj4gQ2hhbmdlcyBpbiB2ODoNCj4gLSBBZGQgUGF0
Y2ggMSAobm93IFBhdGNoIDIpIHRvIGZpeCBmaXJtd2FyZSBzaXplIHZhbGlkYXRpb24gaW4NCj4g
wqAgYnRtdGtfc2V0dXBfZmlybXdhcmVfNzl4eCgpDQo+IC0gQWRkIFBhdGNoIDIgKG5vdyBQYXRj
aCAzKSB0byBmaXggU0RJTyBkZXZpY2UgbG9nZ2luZyByZWdyZXNzaW9uDQo+IMKgIFNESU8gZGV2
aWNlcyB3ZXJlIHBhc3NpbmcgaGFyZGNvZGVkIDAsIGNhdXNpbmcgIkJUIEhXIHZlcjogMHgwMDAw
Ig0KPiBsb2cNCj4gDQo+IENoYW5nZXMgaW4gdjc6DQo+IC0gUGF0Y2ggNCAod2FzIFBhdGNoIDEp
OiBFeHRlbmQgbWFnaWMgbnVtYmVyIHJlZmFjdG9yaW5nIHRvDQo+IMKgIGJ0bXRrX3NldHVwX2Zp
cm13YXJlKCkgaW4gYWRkaXRpb24gdG8gYnRtdGtfc2V0dXBfZmlybXdhcmVfNzl4eCgpDQo+IGZv
cg0KPiDCoCBjb25zaXN0ZW5jeQ0KPiAtIFBhdGNoIDUgKHdhcyBQYXRjaCAyKTogRml4IHBvdGVu
dGlhbCBidWZmZXIgb3Zlci1yZWFkIGJ5DQo+IMKgIHVzaW5nICUuMTZzIGZvcm1hdCBzcGVjaWZp
ZXIgZm9yIGhkci0+ZGF0ZXRpbWUgd2hpY2ggaXMgYSAxNi1ieXRlDQo+IMKgIGFycmF5IHRoYXQg
bWF5IG5vdCBiZSBudWxsLXRlcm1pbmF0ZWQNCj4gLSBQYXRjaCA2ICh3YXMgUGF0Y2ggMyk6IEFw
cGx5IHNhbWUgJS4xNnMgZml4IHRvIENCTUNVIGZpcm13YXJlDQo+IGxvZ2dpbmcNCj4gDQo+IENo
YW5nZXMgaW4gdjY6DQo+IC0gRml4IHRpbWVvdXQgaGFuZGxpbmcgaW4gYnRtdGtfY2JtY3VfcGF0
Y2hfc3RhdHVzKCkgdG8gcmV0dXJuIC0NCj4gRVRJTUVET1VUDQo+IMKgIGluc3RlYWQgb2Ygc3Vj
Y2VzcyB3aGVuIHBvbGxpbmcgZXhoYXVzdHMgcmV0cnkgY291bnQNCj4gLSBBZGQgaW50ZWdlciBv
dmVyZmxvdyBwcm90ZWN0aW9uIGluIGJ0bXRrX2xvYWRfY2JtY3VfZmlybXdhcmUoKQ0KPiB1c2lu
Zw0KPiDCoCBjaGVja19tdWxfb3ZlcmZsb3coKSBhbmQgY2hlY2tfYWRkX292ZXJmbG93KCkNCj4g
DQo+IENoYW5nZXMgaW4gdjU6DQo+IC0gU3BsaXQgaW50byB0aHJlZSBwYXRjaGVzOiByZWZhY3Rv
cmluZywgbG9nZ2luZyBpbXByb3ZlbWVudCwgYW5kDQo+IMKgIG5ldyBmZWF0dXJlDQo+IC0gQWRk
IFBhdGNoIDUgKHdhcyBQYXRjaCAyKSB0byBpbXByb3ZlIEJUIGZpcm13YXJlIGxvZ2dpbmcNCj4g
wqAgaW5kZXBlbmRlbnRseQ0KPiAtIEFwcGx5IHNhbWUgbG9nZ2luZyBpbXByb3ZlbWVudHMgdG8g
Q0JNQ1UgZmlybXdhcmUgaW4gUGF0Y2ggNg0KPiDCoCAod2FzIFBhdGNoIDMpDQo+IA0KPiBDaGFu
Z2VzIGluIHY0Og0KPiAtIFNwbGl0IGludG8gdHdvIHBhdGNoZXM6IHJlZmFjdG9yaW5nIGFuZCBu
ZXcgZmVhdHVyZQ0KPiAtIEFkZCBCVE1US19XTVRfUEtUXyogZW51bSB0byBpbXByb3ZlIGNvZGUg
cmVhZGFiaWxpdHkNCj4gLSBSZXBsYWNlIG1hZ2ljIG51bWJlcnMgKDB4RjAsIDB4RjEpIHdpdGgg
ZGVzY3JpcHRpdmUgbWFjcm9zDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEFkZCBmaXJtd2Fy
ZSBzaXplIHZhbGlkYXRpb24gd2l0aCBib3VuZHMgY2hlY2tpbmcNCj4gLSBJbXByb3ZlIGVycm9y
IG1lc3NhZ2VzIHdpdGggY29udGV4dCBpbmZvcm1hdGlvbg0KPiANCj4gQ2hhbmdlcyBpbiB2MjoN
Cj4gLSBTaW1wbGlmaWVkIGVudW0gdXNhZ2UgYnkgY29uc29saWRhdGluZyBzdGF0dXMgZGVmaW5p
dGlvbnMNCj4gDQo+IENocmlzIEx1ICg2KToNCj4gwqAgQmx1ZXRvb3RoOiBidG10azogQWRkIGZp
cm13YXJlIHNpemUgdmFsaWRhdGlvbiBpbg0KPiDCoMKgwqAgYnRtdGtfc2V0dXBfZmlybXdhcmVf
Nzl4eCgpDQo+IMKgIEJsdWV0b290aDogYnRtdGtzZGlvOiBSZW1vdmUgcmVkdW5kYW50IGZpcm13
YXJlIGZpbGVuYW1lIG92ZXJyaWRlDQo+IMKgIEJsdWV0b290aDogYnRtdGtzZGlvOiBQYXNzIGhh
cmR3YXJlIGRldl9pZCB0byBtdDc5eHhfc2V0dXAoKQ0KPiDCoCBCbHVldG9vdGg6IGJ0bXRrOiBS
ZXBsYWNlIG1hZ2ljIG51bWJlcnMgd2l0aCBXTVQgcGFja2V0IGZsYWcgZW51bQ0KPiDCoCBCbHVl
dG9vdGg6IGJ0bXRrOiBJbXByb3ZlIEJUIGZpcm13YXJlIGxvZ2dpbmcNCj4gwqAgQmx1ZXRvb3Ro
OiBidG10azogQWRkIE1UNzkyOCBzdXBwb3J0DQo+IA0KPiDCoGRyaXZlcnMvYmx1ZXRvb3RoL2J0
bXRrLmPCoMKgwqDCoCB8IDQyNw0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+IMKgZHJpdmVycy9ibHVldG9vdGgvYnRtdGsuaMKgwqDCoMKgIHzCoMKgIDkgKw0KPiDCoGRy
aXZlcnMvYmx1ZXRvb3RoL2J0bXRrc2Rpby5jIHzCoMKgIDkgKy0NCj4gwqAzIGZpbGVzIGNoYW5n
ZWQsIDQzMCBpbnNlcnRpb25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQoNCmh0dHBzOi8vc2Fz
aGlrby5kZXYvIy9wYXRjaHNldC8yMDI2MDcwMjEwMTQzNy4xNzg3ODAwLTEtY2hyaXMubHUlNDBt
ZWRpYXRlay5jb20NClNhc2hpa28gc3RpbGwgaGFzIG9uZSBjb21tZW50IG9uIG15IHBhdGNoIHY5
LCBidXQgaXQgc3RhdGVzIHRoYXQgdGhlDQpwb3RlbnRpYWwgcmlzayBpcyB1bnJlbGF0ZWQgdG8g
bXkgY2hhbmdlIG9uIGJ0bXRrc2Rpby5jIGFuZCBtYXkgYmUgYW4NCmV4aXN0aW5nIGlzc3VlLiBS
ZWdhcmRpbmcgdGhpcyBjb21tZW50LCBJIGxlYW4gdG93YXJkIGFkZHJlc3NpbmcgaXQgaW4NCnRo
ZSBmdXR1cmUsIGZvY3VzIG9uIE1UNzkyOCB0aGlzIHRpbWUuIEknbSBub3Qgc3VyZSB3aGV0aGVy
IHlvdSB3b3VsZA0KYWdyZWUgdG8gbWVyZ2UgdGhlIHY5IGNoYW5nZXMgZmlyc3QuDQoNClRoYW5r
cyBhIGxvdCENCkNocmlzIEx1DQoNCg==
