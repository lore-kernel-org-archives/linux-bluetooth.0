Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C291E7677;
	Wed, 30 Oct 2024 11:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730286213; cv=fail; b=h7x6qv9bPSu8LAM0Tj3vqlkqQUookFgPZ5bSWYiil6X88Vhdcc8lANH2IpQmdEDSFzIArVPvjywkPDLRxX1eggdSIcIcZIO2azEEgrEuBP1xOLSnyh/jNKqtzmVfRJ0bPWp+XlePtQaNkq0yjBVHFCXtolBa3nPRR0nNNsbEhYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730286213; c=relaxed/simple;
	bh=CN4sJ2SZwH0ZYQA8XbHxtaCoFXEfQkMim20JQmOnyLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iTwLh3XvSkJGXuUOK4TEi4pUYmmvyM6O+b3QJ7PT+Dwy7plcJQIgIzO75w3Ze4HCeoriwZgcE8r3QVO3stU+mSQEuxmfJgU5+jxmr9Rv3cmVPyYDqwjq1mlbERGBXod4gG1tS03WI+3PYGBfEmDTpnCpM2npyksft2RwNYE6zC8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=MyJZezLf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=r5ao/WKH; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="MyJZezLf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="r5ao/WKH"
X-UUID: 96a3c36c96ae11efb88477ffae1fc7a5-20241030
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CN4sJ2SZwH0ZYQA8XbHxtaCoFXEfQkMim20JQmOnyLQ=;
	b=MyJZezLfB3Tvnd0GYzJbqx7Mr1IfHzDmTLlQIVt5IxNWaIedlkaQLBwadsMgFFmQ2k0YkN6cB1k4lGwW1TndtJolUV0LVKfWCyKGpWfE7htVoxo4DGeemSfvlfOo2lzii9ILICxpv1yUq40HGNP1YHSs/C+2XalIvJWMk7urZXw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:d2e1ea12-4f66-4c40-ac74-a6e6ef1c13d2,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:7e806d48-ca13-40ea-8070-fa012edab362,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 96a3c36c96ae11efb88477ffae1fc7a5-20241030
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1368970221; Wed, 30 Oct 2024 19:03:26 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 30 Oct 2024 19:03:25 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 30 Oct 2024 19:03:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pphp3tLqx5ALO39mXOepd5k0S5DC5odJAqKcs6J8Euy/FSoQZ6GrGV2S7BpiISVd6Yox9DHdh4LPtUdHcZY4VVt8tBRBW8J2nj1fUDdzRbH6WPRg1d73O0IzbJ1hY/CMX1++l7l402jtxbJ7RcV31FtxrJJVby7KFUs1JzVhAeg1qv8d+lH2bCX1QZRf7P3zQRl9ehoZyLTPImhw5BSzDAc/bA7mI7OgOcgYB4vmwt3+betI57rfrADJ7FiGiCYzl/jV6SjnrytHcKJYEWbZwqFnC3QkaoVRCG9ewfm3R5lZ+IMTLBFQAwQKCqU/RtBNTJIZiPg7jvI1udrkuud1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CN4sJ2SZwH0ZYQA8XbHxtaCoFXEfQkMim20JQmOnyLQ=;
 b=Hf9+HE5FlEU4gEPBIEXPkS1N0R80s+8VHXR0ND0qV9Kj0XSxCiX2osnmoc5KYKICctmfQAhbcJKTFmIjeH7a39BM62ZV8W2He8jmBHW+Pv0CBO5Uy9CEFoeE8iRXYL3M9srvRC1uk4pqg1oLcJ/QHL6dHu9J1XgqUzjb3PM/0CYx41po04gXAfN98C1ZcH4pnOw/R4B0S0jy6Ye9/MgvVhjlV81LXNtu2rRYMSXKNDAzmKI/0Yif8hVMKf/Zt/sQoUR9bqH0z8vNi18ya3Bmy8OL3TWLFdfSB3q12vhBHIVKM146OxQ/NKOHXpA6VHMonktMl5X4ndhwit8jwvYQlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CN4sJ2SZwH0ZYQA8XbHxtaCoFXEfQkMim20JQmOnyLQ=;
 b=r5ao/WKHjPq9kJSWUQOJsbQZRnVVNTGjYXojd8RO7tnGDxxTH4PxkEiO0Og6FRCKc2+Bn/9rIudil3GskMtPMIDFc/+6zUGfKIcz7tUoH80TmSPQkyHwdKpqk+wIUftlO2wXs6vIS411R+8PbLnOnN0WGhLe3X/59acrLRUaR7s=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by TYSPR03MB8428.apcprd03.prod.outlook.com (2603:1096:405:56::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 11:03:22 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%6]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 11:03:21 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "regressions@leemhuis.info" <regressions@leemhuis.info>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	=?utf-8?B?SGFvIFFpbiAo56em5rWpKQ==?= <Hao.Qin@mediatek.com>
CC: "marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
	"marc.payne@mdpsys.co.uk" <marc.payne@mdpsys.co.uk>, "tiwai@suse.de"
	<tiwai@suse.de>, Sean Wang <Sean.Wang@mediatek.com>,
	=?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before
 downloading the fw
Thread-Topic: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before
 downloading the fw
Thread-Index: AQHa9FNmoMNrfHOpSUGvzt/DtokMqLJRX6GAgAsunzeAASkiBIACJd5SgCZxi0+ADKqeAIAMeB+AgAAceQA=
Date: Wed, 30 Oct 2024 11:03:21 +0000
Message-ID: <d0f70e662f5e9329cff43f92a5c191601cc599f1.camel@mediatek.com>
References: <20240822052310.25220-1-hao.qin@mediatek.com>
	 <ZuB3omUkdUHLggYu@mdpsys.co.uk>
	 <790e542aa9d08c7efeee6ef298fce2a87d8035e4.camel@mediatek.com>
	 <ZuneSM4SvyUFX86j@mdpsys.co.uk>
	 <9bfbbf24ac2480d94d3455f7e33e4b5502b38ced.camel@mediatek.com>
	 <CABBYNZKYsL9jcF2n9TsA1BjU-CjXOdXu7MDLP9Sz_Ly8hBAf1w@mail.gmail.com>
	 <c01e6dfa730dd10a7d4dba60fe31e82b9c296b37.camel@mediatek.com>
	 <Zuyk1c6Gkxx3G0PB@mdpsys.co.uk>
	 <f9e8688ebe559e10c019d0cbab4e8b1f5a7d2339.camel@mediatek.com>
	 <ff502f63-2d87-4dee-a893-cce53353df8b@leemhuis.info>
	 <87iktk4d9l.wl-tiwai@suse.de>
	 <75f671b6-ce2a-4404-b662-2c9c7d28a598@leemhuis.info>
In-Reply-To: <75f671b6-ce2a-4404-b662-2c9c7d28a598@leemhuis.info>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|TYSPR03MB8428:EE_
x-ms-office365-filtering-correlation-id: e6b7f966-faff-43be-1ebc-08dcf8d277de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NjBXK3NsSFlTaFVuSlMwdTdSQnlFZ040WStORE9ERTliREx3S0JpM3RLWlVI?=
 =?utf-8?B?NStjUHdGVFVkZ1BxWmdqa21yNUZPK1pPWlNVWDBWTFJQTzhrd0R6S0traC9Z?=
 =?utf-8?B?Qm9tbm50Vk4vbkM3TVk1QmVUT2d5Zmh6OGFtUDVEZ3hhcytBTmF2aG1pNkwx?=
 =?utf-8?B?dS84TWloVm92MkQrblFLL3NBd1FuRGdXZXpHVjVHSTFPancwS1kvQkI5WXlP?=
 =?utf-8?B?bGYyMGhXNU0wd2loUXJJbWJDaDFlNUZ2bXp2eml6K2IzdHlBRFRYZ1FxVWt2?=
 =?utf-8?B?K2sxSlR3NXdOWFF5bHZ1WHROVzl3OGRSSEdCYWF4N2liYnV0TDJrTlA2TlBn?=
 =?utf-8?B?SFVnMW9jQVk1NzU0RFRtZzR2SW96YWxUV2JWUVhzNEV6S1dBN1prSjJRRmMz?=
 =?utf-8?B?TnlEa3MyemV6c2dZOHJ2bFA0UzBTTVBhZVE3YXJVR2J0WFpmczI2OEw0UUdw?=
 =?utf-8?B?NEU0MGRodGtIbDZzcVhGelEwYVF1dDFMTGc2anYyRjFTOWVyYzdIUm5BU1dT?=
 =?utf-8?B?SmNrZktlNlNvanU2YVJBWmJMWWRod21telk1M2J3TkZTY3gwY2JFbXQyMFQx?=
 =?utf-8?B?Mlc5dzJibmJ4RVk1aWpBRTkyVzhGcDNvTDlvZUtqWmw2OFRsNXprc0FFVTUv?=
 =?utf-8?B?UUwyK1pyQlVSSWhhS25HME1Nekw0Q2NvclJaOU1rVzdQVkQweXZFdVBXUy9y?=
 =?utf-8?B?RFE2VUt0V0NobllSVGdRaDFNaFYrc2oxQXhMQU1raG91U0ZpVCs4V1pJQU0z?=
 =?utf-8?B?ZDZqMFdHYUJqVEZoZHllTG0rWWRja0VQQWFQcDZ1K3BBZWhwMnIxNVpOeGlF?=
 =?utf-8?B?TzQ0RVVtekIwSmUrRGR1dlFKV3pMclhRMmt4a2dtTHU2WHp1b0ZQQ2MvYWNx?=
 =?utf-8?B?ZDR5d2V3b1VwMTNSdXQ5R1U5MXJ5R084blpPc3JCWnQ2aExNSWJQVHBGbnZz?=
 =?utf-8?B?bkVNZEFseERXQkxiZDZ2bSt1NmtKUHpLV2h6SDJrZ240a054UitNcWVzYXpX?=
 =?utf-8?B?U3ltU2hPdTJoRjdYZVFrRnRUZ2ZGZzVpZmlLTElNZi9tUGx4MnpoQTF6U1c4?=
 =?utf-8?B?K2ZOS0J4aVFNYTZwY29XSEo1bVp4OVJ4Y1dBblhkZ0RJQk43SCswc2tzcTNo?=
 =?utf-8?B?L1ZkZWVCTlg3YnI0THY0OTlRRS8veXo1K1BSZU5BUGYxWHRsNzZSV1o5N2xE?=
 =?utf-8?B?cE52bGlhcVArNG5yWGF6bWwrV0F6eWFQa01YWllqKzRkc3RWTWZQQ1JiN0dl?=
 =?utf-8?B?MnRZNG14U0V3WGxWdlBMd042a28zRXRlYWxBSXdBK2tKanNSVGdSeTB5c3hx?=
 =?utf-8?B?WmMzZ2pWTnVzVE5oZEpmUU9XbGlVMGlCdm5SRFVEdGY3cTdJOGRjbFh6Qmpk?=
 =?utf-8?B?dVh1QWcwOGJSWjZlT0w1UHcxOWRuWU1pZU5pOG9rMEpoVmVhY3l3Rnpib1Jv?=
 =?utf-8?B?enhlYm5iQlk4NVcxUUhyc3JwU2RVTVZnK3dOV2dnVDJnR2F4aXFQVjg4UVdD?=
 =?utf-8?B?ck94cnoxZHdkRWNKWmk1eXZHb0NMR29TWFRMbXRIanpQekNoMDBPSmRDS2JR?=
 =?utf-8?B?T3VUbHRXRkdvWU5QVmhGRmNTdWI0T0pKeTI0Qmk1V1QwMnYvVGpXK29FaDBm?=
 =?utf-8?B?QlBoNGo5NndtZ1g2MHAvYVQ2SVl5bzA3SWN5SVlrZjNTb2grYno5ZjBsVnBq?=
 =?utf-8?B?L0h5Y1JJWmpxU2VIcE1SVHNlcm1DUXU4SWtmazFGNDlWM0w4Z3kzZ2JDbnhn?=
 =?utf-8?B?aFF6N3B6NDhLREE3UGFMbjVFNFMyaFJ1ZUlIOHBMMmFUTFhITmZuYUhQN2Fu?=
 =?utf-8?B?WStVM2RZUitHQVJHUnZkNEprbktuNEd5QldnbmpKRlBVcjNuc2tJVHdWSnNy?=
 =?utf-8?Q?94UBiJUl5g4m0?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2VpTVNCek5vWFdNTDdzU2t3a2Z4S0cwNG92eVdIaXZCNFFybE9ZRHgzYm83?=
 =?utf-8?B?RmpnZmtRTnVnSjMrSE54Q0V5Z0FLK2JJVDBSM1VaWHdpQWpXNGVSWi84Z2Nl?=
 =?utf-8?B?d3NQN3RKR3YvVjlPQzdBRU5RWmZkNENXb2hqQTM5c3dxbXkyREhpN1RHVVV1?=
 =?utf-8?B?ellXNzA0L2pTMHNmbHFTTHZnTlBhTnVCOVFWcW8vQlpDb2RReHhXMzNmNHlx?=
 =?utf-8?B?NmVBR0tkZE5odHNvQThKWE5iRXZaME1lSTdvVlllV29oTk94OVlYNVNYUHFU?=
 =?utf-8?B?M2loV2Y0R040bGQ5V1Z1R25ISUpYYXRZRmRWWUJWMnFtS3lRa0NsN3JnSjRB?=
 =?utf-8?B?UGJGVWk5c1pOWnNxUmY5dkNTOE15bTFXSXVjZVQ5WW9LUFVPMi9CTExScCs1?=
 =?utf-8?B?Qk5PTkttM2dxU2RmZWsrQlVDc2ROclVnWCsxbXJ2S1ppN0c2M1VpREZMeGlw?=
 =?utf-8?B?MkxrZm9oN042V2RzY0RpUElyZlgzMm5pVm9hTmozd0NPekJEZnp3aFZIZWxX?=
 =?utf-8?B?UDkvOXR4M0tLSHVGcnllMXNOMFhVemVCU0VubE5XYW8xaVhMU3hIYWV2QWZv?=
 =?utf-8?B?b21ueHdkUWw1VW5lR3AySjJuTWVKcDBYaFgvYVpiZm5ZTlZORnc1eGNuNVdK?=
 =?utf-8?B?TkgxdE5ZVlc1TExtQnNnMmdwekMwNHdwZkE0eUNidTA4SjFMNUVaUTFHODAw?=
 =?utf-8?B?akk3ZjhGU1J3WFJsbkdlejRBV3V2Q24vdG12N2k5OS9vR2lSejc3N2ZDSzlU?=
 =?utf-8?B?cnV4dHFteDZBLzlpWWdQWnFxR1Q1OHFvZkpKNURGdEJ0bTdVWXpxQmNlNVpX?=
 =?utf-8?B?TGxmYUpvcUhaNWUyNGFCbHJhRXJCcTFmSnFqR1VHZ2xiU3JKVFJMM01WWkR4?=
 =?utf-8?B?Z2YzdXUzaThMTjE3Q3hrYVI1ZzhIUVRoaWJNNTNvOGRFTitUL0xpUC9PWHhV?=
 =?utf-8?B?Q0FPR2FqMUptejY5eDJSMElKdDhCQUhJYnhRK1NhWXYrVGZ3QWxzVkxHOTVl?=
 =?utf-8?B?MkFpMytYZmJjcTMvV09iWFJKWElxcW1jWWhYK3RBeVZSSjVqMlkwa1BMRVlr?=
 =?utf-8?B?WllRRndnbklsdGN0enZxSkNFRlEyV2V4a2FlcjNSUXpYU2JDY3JoUS9HSXlD?=
 =?utf-8?B?SXo0S2g3bnZqQlhBWEFvQ25CTmE1bG5odndXNEwxYnhTVnBzWDk4YlYwekNB?=
 =?utf-8?B?Zk5yNTR4M1dIemxUMHFvcWkvQlBsbExXclBFYVBRYmF3NVlqQzU1SkJUTkU3?=
 =?utf-8?B?K0RCdzY5bW5OdG5teERiK3BzQkkzMW8za29tQ0pFUnJ0TU54OVorUVNMclhl?=
 =?utf-8?B?d0s3a1VDYWZpekdIYzByWVV1aXNZeVNiVTVKZWk0bUFFOG42UDYxam1XNXlj?=
 =?utf-8?B?L0FCU3AyblpGZjdWeURkbWhGZ2RTc2gyTFBZZnZWM0NqUWUrU1dhbnR1WHZn?=
 =?utf-8?B?MWUvdW1Nc2pSc0NaMDU5TG9udHo5WW53ai9KMkFQVlFWakdEYTIyN095OVpU?=
 =?utf-8?B?ZVduS2w4aXRMVW10L3JRcHBSQ243alZjN2FNRkdweDdqYk5Eb3E3MjlXTzB3?=
 =?utf-8?B?d1VKNDRRNWFKME1ialBaNTB1NU5rdmZVMUJxL2lqRFVWaDgwSlRib2lhYVJY?=
 =?utf-8?B?Uk5TUFdFcjA0elRkVVUzOU13Z0JPZ0tXYjQwSzI5MFBMbzBZZTRJbjd0ZTBx?=
 =?utf-8?B?TkVDalFhOHF6dnpreFJvVC9nQlV1VXU5dEZaQWU1TTFkL0JaYmNDUkFCZjYy?=
 =?utf-8?B?dldIUThSakIwRURLZVJSMVpiS29teVBGWnRkR0pPcTVidUsyTFBhVGRtcVgx?=
 =?utf-8?B?ZjhaMzFIR3lGRHRQaFBLL0xob3lSejMwallteHlXeHE5TEtpVTJzZjVxOXFt?=
 =?utf-8?B?RlFmK2RFZlRva1FMZ25jTWhSYzVsRGs1V1V5M2Rsa2hZTDNpOUM1UEhYa1dw?=
 =?utf-8?B?UnBteWJmbDlQMFBPNjFLb09IM0dPdGZ6Tkwxc1gvQWloemJyTTluTDBua3d3?=
 =?utf-8?B?ZXkvMTZ0QXM4M2dXUlBDcEh1ZjRlUXAzVWFqa1ZNTWJlZkdOQkptY3FKSjBG?=
 =?utf-8?B?OWkzb2kxbFdnVGlZL2Z4K2JKVlRyWWY1cisrODZVUmhLZmN4ZTNSaDNQaThr?=
 =?utf-8?B?SGxmdFgzZmdLMWg2ZnZnQzJjUnp1V2FTMkk3MUNlRUg1NUtLbDB0cytMT2lz?=
 =?utf-8?B?ckE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A90D31ED30A054FAD217D1DF7A4F8D7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6b7f966-faff-43be-1ebc-08dcf8d277de
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 11:03:21.7362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yNq5MEAs6NQWBu2WivpnI4iF/ggTgDD76nsh+47RUbF0Y3fYHELWzQwkkreRbJ1TGAIVE9Y3h+V9uJ2UpLv6pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8428

SGkgTGVlbWh1aXMsDQoNCkxldCBtZSByZWNhcCBhbmQgdXBkYXRlIHRoZSBzdGF0dXMgb2YgdGhp
cyBwcm9ibGVtLg0KDQpNYXJjIGZlZWRiYWNrIHRoYXQgaGUgaGFzIHNvbWUgcHJvYmxlbSB3aXRo
IE1UNzkyMUFVTiB1c2IgbW9kdWxlLg0KT3JpZ2luYWxseSwgd2UgdGhvdWdodCBpdCB3YXMgY2F1
c2VkIGJ5IHRoZSBjaGFuZ2UgIkZpeGVzOg0KY2NmYzg5NDhkN2U0ZDkgKCJCbHVldG9vdGg6IGJ0
dXNiOiBtZWRpYXRlazogcmVzZXQgdGhlIGNvbnRyb2xsZXIgYmVmb3JlIGRvd25sb2FkaW5nIHRo
ZSBmdyIpIi4gVGhlIGNoYW5nZSBpcyBtYWlubHkgZm9yIE1UNzkyMiwgd2UgZm91bmQgc29tZSBw
cm9ibGVtIHdpdGggTVQ3OTIxIG9uIHNwZWNpZmljIHBsYXRmb3JtIGludGVybmFsbHkuIEFzIGEg
cmVzdWx0LCBIYW8gc2VudCBhbm90aGVyIHBhdGNoIHRvIHJlbW92ZSBNVDc5MjEgZnJvbSB0aGF0
IHJ1bGUoQmx1ZXRvb3RoOiBidG10azogUmVtb3ZlIHJlc2V0dGluZyBtdDc5MjEgYmVmb3JlIGRv
d25sb2FkaW5nIHRoZSBmdykuDQoNCkhvd2V2ZXIsIE1hcmMgYWxzbyBtZW50aW9uZWQgdGhhdCBC
VCBpcyBhYmxlIHRvIHdvcmsgaWYgY2hhbmdpbmcgYmFjaw0KdG8gYW4gb2xkIGZpcm13YXJlIGJp
bi4gQmFzZWQgb24gdGhlIGNsdWUsIHdlIGZvdW5kIGl0IHdhcyBjYXVzZWQgYnkgYQ0KZmlybXdh
cmUgY2hhbmdlIHRoYXQgc3BlY2lmaWMgTVQ3OTIxIG1vZGVsIHdpbGwgbm90IGFibGUgdG8gc2V0
dXANCnN1Y2Nlc3NmdWxseS4gKEluIGZhY3QsIHdlIGRpZG4ndCBleHBlY3QgdGhhdCBNVDc5MjFB
VU4gY2FuIGJlIGdldCBieQ0Kbm9ybWFsIHVzZXIuKQ0KDQpTaW5jZSB3ZSBjYW4ndCBwcmVkaWN0
IHdoaWNoIG1vZGVsIHVzZXIgdXNlIGFuZCBMdWl6IGFsc28gc3VnZ2VzdHMNCk1lZGlhVGVrIHRv
IGZpeCBpdCBpZiB0aGF0IG1vZGVsIGNhbiB3b3JrIGJlZm9yZSwgd2UgaGF2ZSBwcmVwYXJlZCBh
DQpzb2x1dGlvbi4gSSd2ZSB2ZXJpZmllZCB0aGUgc29sdXRpb24gbG9jYWxseSB0aGF0IE1UNzky
MUFVTiBtb2RlbCBjYW4NCndvcmsgbm9ybWFsbHkgb24gVWJ1bnR1IFBDLiBJdCB3aWxsIGJlIGEg
ZmlybXdhcmUgbW9kaWZpY2F0aW9uLiBXZSBwbGFuDQp0byBzdWJtaXQgbmV3IGZpcm13YXJlIHdp
dGggdGhpcyBtb2RpZmljYXRpb24gaW4gMjAyNCBOb3YuDQoNClRoYW5rcyBmb3IgeW91ciByZW1p
bmRlciwNCkNocmlzIEx1DQoNCk9uIFdlZCwgMjAyNC0xMC0zMCBhdCAxMDoyMSArMDEwMCwgVGhv
cnN0ZW4gTGVlbWh1aXMgd3JvdGU6DQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gSGksIFRob3JzdGVuIGhlcmUs
IHRoZSBMaW51eCBrZXJuZWwncyByZWdyZXNzaW9uIHRyYWNrZXIuIFRvcC1wb3N0aW5nDQo+IGZv
ciBvbmNlLCB0byBtYWtlIHRoaXMgZWFzaWx5IGFjY2Vzc2libGUgdG8gZXZlcnlvbmUuDQo+IA0K
PiBJJ20gYSBiaXQgbG9zdCBoZXJlLCBidXQgbWF5YmUgSSdtIG1pc3Npbmcgc29tZXRoaW5nLg0K
PiANCj4gTHVpeiwgY2FuIHlvdSBoZWxwIG91dCBoZXJlPyBJcyB0aGVyZSBhIHJlYXNvbiB3aHkg
dGhpcyBwYXRjaCBpcyBub3QNCj4gbWFraW5nIGFueSBwcm9jZXNzPw0KPiANCj4gQ2hyaXMgTHUg
YW5kL29yIEhhbyBRaW46IENhbiB5b3UgbWF5YmUgaGVscCBvdXQgYXMgd2VsbCBhcyB3ZWxsIGFu
ZA0KPiBoZWxwDQo+IHdpdGggcmVzb2x2aW5nIHNvbWUgb3BlbiBxdWVzdGlvbnMgdGhhdCBtaWdo
dCBvciBtaWdodCBub3QgYmUNCj4gcmVsZXZhbnQNCj4gKHNlZSBiZWxvdykuDQo+IA0KPiBGcm9t
IFRha2FzaGkgcmVwbHksIHRoZSBidWd6aWxsYSB0aWNrZXQgaGUgbGlua2VkIHRvLCBhbmQgdGhl
IG1haWwNCj4gZnJvbQ0KPiB0aGUgTWVkaWFUZWsgZm9sa3MNCj4gKA0KPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzEyYTM0NGUyNWIzMWVjMDBmZThiNTc4MTRkNDNmY2IxNjZlNzFiZTUu
Y2FtZWxAbWVkaWF0ZWsuY29tLw0KPiApIGl0IGZyb20gdGhlIG91dHNpZGUgbG9va3MgbGlrZSB0
aGlzIHBhdGNoIHNob3VsZCByZWFsbHkgYmUgbWVyZ2VkDQo+IHJhdGhlciBzb29uZXIgdGhhdCBs
YXRlciBhcyBpdCBmaXhlcyByZWdyZXNzaW9ucyBmb3Igc29tZSBwZW9wbGUuDQo+IEFmYWljcyBp
dCBzaG91bGQgZ2V0IGEgIkZpeGVzOiBjY2ZjODk0OGQ3ZTRkOSAoIkJsdWV0b290aDogYnR1c2I6
DQo+IG1lZGlhdGVrOiByZXNldCB0aGUgY29udHJvbGxlciBiZWZvcmUgZG93bmxvYWRpbmcgdGhl
IGZ3IikiIHRhZywgYXMNCj4gaXQncw0KPiBhZmFpY3MgdGhhdCBjb21taXQgdGhhdCBjYXVzZXMg
dGhlIHJlZ3Jlc3Npb24gdGhhdCBpcyBrbm93biBzaW5jZQ0KPiBtb3JlDQo+IHRoYW4gdGhyZWUg
bW9udGhzIG5vdw0KPiAoaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1pzVGg3Snl1ZzdNYlpz
TEVAbWRwc3lzLmNvLnVrLyApLg0KPiANCj4gQnV0IG5vdGUsIGl0IHNlZW1zIGl0IGRvZXMgbm90
IGZpeCB0aGUgcmVncmVzc2lvbiBjb21wbGV0ZWx5DQo+IGFjY29yZGluZw0KPiB0byBNYXJjJ3Mg
dGVzdGluZy4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1p1Q0I5OERTZHRLQ2d4YUxA
bWRwc3lzLmNvLnVrLw0KPiANCj4gTWFyYzogSXMgdGhhdCBzdGlsbCBob3cgdGhpbmdzIGFyZSB3
aXRoIGN1cnJlbnQgbWFpbmxpbmU/DQo+IA0KPiBDaWFvLCBUaG9yc3Rlbg0KPiANCj4gDQo+IE9u
IDIyLjEwLjI0IDEyOjU2LCBUYWthc2hpIEl3YWkgd3JvdGU6DQo+ID4gT24gTW9uLCAxNCBPY3Qg
MjAyNCAxMToyOTo0MCArMDIwMCwNCj4gPiBMaW51eCByZWdyZXNzaW9uIHRyYWNraW5nIChUaG9y
c3RlbiBMZWVtaHVpcykgd3JvdGU6DQo+ID4gPiANCj4gPiA+IE9uIDIwLjA5LjI0IDA4OjI3LCBD
aHJpcyBMdSAo6Zm456ia5rOTKSB3cm90ZToNCj4gPiA+ID4gT24gVGh1LCAyMDI0LTA5LTE5IGF0
IDIzOjI1ICswMTAwLCBtYXJjLnBheW5lQG1kcHN5cy5jby51aw0KPiA+ID4gPiB3cm90ZToNCj4g
PiA+ID4gPiANCj4gPiA+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3Blbg0KPiA+ID4gPiA+IGF0dGFjaG1lbnRzIHVudGlsDQo+ID4gPiA+ID4geW91
IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gPiA+ID4gPiAgSGkg
Q2hyaXMgYW5kIEx1aXosDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2hhdCB3ZXJlIHlvdXIgdGhv
dWdodHMgb24gdGhlIGZpbmRpbmdzIGluIG15IGVtYWlsIGRhdGVkDQo+ID4gPiA+ID4gMTh0aA0K
PiA+ID4gPiA+IFNlcHRlbWJlcj8NCj4gPiA+ID4gDQo+ID4gPiA+IFRoYW5rcyBmb3IgeW91ciBz
dWdnZXN0aW9uLg0KPiA+ID4gPiANCj4gPiA+ID4gSSd2ZSBwcmVwYXJlZCB0aGUgc2FtZSBlbnZp
cm9ubWVudCAoS2VybmVsIHY2LjExICsgTVQ3OTIxQVVODQo+ID4gPiA+IGRvbmdsZSkgdG8NCj4g
PiA+ID4gcmVwcm9kdWNlIHRoZSBpc3N1ZSwgY29sbGVjdGVkIG5lY2Vzc2FyeSBsb2dzIGxvY2Fs
bHkgYW5kIGFsc28NCj4gPiA+ID4gaW5pdGlhdGVkIGFuIGludGVybmFsIGRpc2N1c3Npb24gdG8g
Y2xhcmlmeSB0aGUgcm9vdCBjYXVzZSBvZg0KPiA+ID4gPiB0aGlzDQo+ID4gPiA+IHN5bXB0b20u
IFdlJ2xsIHJldmlldyB0aGUgY2hhbmdlcyBiZXR3ZWVuIHR3byBmaXJtd2FyZQ0KPiA+ID4gPiAo
MjAyMzA1MjYvMjAyMzExMDkpIGlmIGl0J3MgYSBidWcgb3Igbm90Lg0KPiA+ID4gPiANCj4gPiA+
ID4gSXQgbWF5IHRha2Ugc29tZSB0aW1lIHRvIGludmVzdGlnYXRlLiBJJ2xsIGxldCB5b3Uga25v
dyBpZg0KPiA+ID4gPiB0aGVyZSBpcyBhbnkNCj4gPiA+ID4gcHJvZ3Jlc3MuDQo+ID4gPiANCj4g
PiA+IEp1c3Qgd29uZGVyaW5nOiBDaHJpcyBMdSwgYW5kIE1hcmMsIHdoYXQncyB0aGUgc3RhdHVz
IGhlcmU/IEZyb20NCj4gPiA+IGhlcmUgaXQNCj4gPiA+IGxvb2tzIGxpa2UgdGhlcmUgd2FzIG5v
IHByb2dyZXNzIHRvIGZpeCB0aGlzIHJlZ3Jlc3Npb24gZm9yIGENCj4gPiA+IHdoaWxlLCBidXQN
Cj4gPiA+IGl0J3MgZWFzeSB0byBtaXNzIHNvbWV0aGluZywgdGhhdCdzIHdoeSBJIGFzay4NCj4g
PiA+IA0KPiA+ID4gQ2lhbywgVGhvcnN0ZW4NCj4gPiANCj4gPiBGV0lXLCB0aGUgc2ltaWxhciBi
dWcgd2FzIHJlcG9ydGVkIGZvciB0aGUgcmVjZW50IDYuMTEueCBrZXJuZWwgb24NCj4gPiBvcGVu
U1VTRSBUdW1ibGV3ZWVkLCBhbmQgdGhpcyBwYXRjaCB3YXMgY29uZmlybWVkIHRvIHdvcmsgYXJv
dW5kDQo+ID4gdGhlDQo+ID4gY3Jhc2ggYXQgYm9vdDoNCj4gPiAgIA0KPiA+IGh0dHBzOi8vdXJs
ZGVmZW5zZS5jb20vdjMvX19odHRwczovL2J1Z3ppbGxhLnN1c2UuY29tL3Nob3dfYnVnLmNnaT9p
ZD0xMjMxNTk5X187ISFDVFJOS0E5d01nMEFSYnchall5SDJvdWJCRXRJS1htS2w5Y0kycnJtSy03
a1NkYWlJSlE4eEg0TlphNWk1WUNUUURIYW9PeENCaE1nZEFBWTZST0lQQW9Qd2JPVi1MTmVNUkpC
bFI2dS1BcyQNCj4gPiANCj4gPiBJdCdkIGJlIGdyZWF0IGlmIHlvdSBjYW4gZ28gYWhlYWQgYW5k
IG1lcmdlIHRoZSBwcm9wZXIgZml4IHRvIHRoZQ0KPiA+IHVwc3RyZWFtLg0KPiA+IA0KPiA+IExl
dCBtZSBrbm93IGlmIHlvdSBoYXZlIGFub3RoZXIgcGF0Y2ggdG8gdGVzdC4gIFRoZW4gSSBjYW4g
Y3JlYXRlIGENCj4gPiB0ZXN0IGtlcm5lbCBwYWNrYWdlIGFuZCBhc2sgdGhlIGJ1ZyByZXBvcnRl
ciBmb3IgdGVzdGluZy4NCj4gPiANCj4gPiANCj4gPiB0aGFua3MsDQo+ID4gDQo+ID4gVGFrYXNo
aQ0KPiA+IA0KPiANCj4gDQo=
