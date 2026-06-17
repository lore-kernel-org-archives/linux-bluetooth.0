Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0622BEFEF
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 01:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661228; cv=fail; b=oNZXv0P+nlCD4Sch1oNhxmxsUByurpwrCsc9FXnT0WyZFLagMkro3t10lClPfkrWJYU7COlJdDfdSj+rqM9UmyUVnJZtJaV+2u2jN9Pvxb9IIyFHwHybvMVamXFfTV0BtHWEw/REveUCH2qbamOenP0RaXwyGq0NZaagxkMf+Qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661228; c=relaxed/simple;
	bh=/tgG7c5Tl6EcjXzHTKuDQhW/jx54jXZhpUB75uk6ybY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=twuPq86Nz7/zX1T/G7daqek6k3Mk4GeixkAs7vtN2FGOaaOKhDMEWsPluYA7zZzhh1iuejjfxBVgTNn3G8uMwoqghWTeB/rwr7w7kHC/AlaJAkEmTplkVo2U2d+8WDx0DUULENMzmpxryyxEUBMAXpU8yt/TjKDI1+xY3XysJmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FOSO26Fu; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=wGLjdwSU; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FOSO26Fu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wGLjdwSU"
X-UUID: 5ce150fc69ef11f1b1788b6acf885367-20260617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/tgG7c5Tl6EcjXzHTKuDQhW/jx54jXZhpUB75uk6ybY=;
	b=FOSO26FussjgLqi1ZJwITnZXDrlxkt47M5LM2llPDV0LkFHVhe3H4l/vnCZg7MIaFwBDCEXCjf68SvcLaz+ck3GZZOS4ZP3agMC1Sro+K9DCMTONSIJM8aLI2inw2X/RZ8x2N7oLqdCV8DJU9oORj9SbpbeAcHGUCxM9DPkIblY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:abcc9eaf-0556-4b07-a04a-489f69ceb73b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:0c84c1ed-45e6-4692-a476-3f71842ee83b,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
	:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:
	-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5ce150fc69ef11f1b1788b6acf885367-20260617
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 50256600; Wed, 17 Jun 2026 09:53:40 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Jun 2026 09:53:39 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 17 Jun 2026 09:53:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DD1YDaglSMHrpHTtIe3r03O6cYuLNy8gNCx8Z3fIio+LV194KRGcMNprCyJ1mUQOIA+Wrl4no+7UTR+AglM8C2fotxLahhlU3+2H4hGzYzQ6GaW7OIElW825I6CFCXs4yHW6CMW4MGgu7wZShpMy92GDHKmTL4NgQiWcH2yQCNL5na8TqJaZtv7RSqRw8ZpcAzruY1mJ/5bTox2oTsM5LY5s19GkaVU5nmDnkH7eeQWA5PYQKr24dyRt6gptiUE3dKQ+C1MDeX9tlPLe4vj3gOMlCOTZjRSZWXOq4a4kxC5FVrBxNr7i+bLhP/DU7Iqgmd8N0/DxfivWhG7FNvnr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tgG7c5Tl6EcjXzHTKuDQhW/jx54jXZhpUB75uk6ybY=;
 b=TgDn6/dHx05eFi6sQdfm9ssjapPp1dk5xQaaRGsQIhsXFv1RtF+brF90CF6GBpTYbQrXwre3I2lumN6dSU70OFS05QdzNO0gvswzNj2qXDXnYo9JduH7rvaQUZx36v+2gzZYV2X7aSwaM4N/NWHRoVyRPYGbDKwZE9f8rt8yIj3SYvMOfIBldNk3JyDblqgkkr0WaBGTRRbWSAcopP7VKoH34fD1lFej6c5yf5S39t4ASwebWigfCiBOarl/24U3fxApO+TJ1NSNdBUphJ26I0y/W/+gpN9FRaebvqWv01mofrTXlBEwB6FaaIAiU5lQLhJIwcXMbjIgZwza8Sw9dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tgG7c5Tl6EcjXzHTKuDQhW/jx54jXZhpUB75uk6ybY=;
 b=wGLjdwSUGjfwrWxmdDU8SAvPlV0ub2X365STtJhrysm5gVlHayML35k083V5TRJlwz0ocBkp27LTqy9TRHiAMFofvWlEwyNFrE5+biBX21zOiHzuj5uHad/3u9PchtE3G8u/mHcs6+U868lpodLN7+C9O77/VWGRCpkVeOlGmuE=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by KUZPR03MB10241.apcprd03.prod.outlook.com (2603:1096:d10:88::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 01:53:37 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 01:53:36 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"pav@iki.fi" <pav@iki.fi>
CC: Sean Wang <Sean.Wang@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, =?utf-8?B?U1MgV3UgKOW3q+aGsuasoyk=?=
	<ss.wu@mediatek.com>, =?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?=
	<steve.lee@mediatek.com>, =?utf-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?=
	<Will-CY.Lee@mediatek.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v1] Bluetooth: btmtk: Add MT7928 support
Thread-Topic: [PATCH v1] Bluetooth: btmtk: Add MT7928 support
Thread-Index: AQHc/Tx3X72d2Ab250uFpDKW8WMJILZBQSIAgAC8nQA=
Date: Wed, 17 Jun 2026 01:53:36 +0000
Message-ID: <05cdc8b67198ec411842d564189a348b94bde464.camel@mediatek.com>
References: <20260616030132.532184-1-chris.lu@mediatek.com>
	 <cb14eaa1c566ed30119ca66bff0484192f852e91.camel@iki.fi>
In-Reply-To: <cb14eaa1c566ed30119ca66bff0484192f852e91.camel@iki.fi>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|KUZPR03MB10241:EE_
x-ms-office365-filtering-correlation-id: 59bd32f5-73cd-4e7e-b9a0-08decc133f1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|4143699003|38070700021|18002099003|22082099003;
x-microsoft-antispam-message-info: zOxRy0Sn58RnLo8lVUAtiw8K5/ctjqEfJOWg+zSAJok6FWo+JmKCiyQTBTFiNOfwAecZeZ0Wp5+SjANIkSNjsGMA58EcYeIsu1GoCF8S59kQsIOYKNf58zVMutCYwjVxbzPcRdjFgZfeY9EzJXAVnkYDggpl6Cb7n6bM14rKHNXSXpKmhjMB45QUEO0qGz/jOVU36/YLYxAvNOVyb3hzuGKPwu0XmicXEWj+dEcXPg/3b5/DCC6NGxTXvG5em8tA8+DV9n2uG949F3gjtohEVyfJ74V+0H/Jt89YjQt8CAnzdJuS9sPvYRzwgFhp00opCOcOV7KdMT9xEygCHfXDZX42emmll+D/laO/XYAsqB2KIhgFj49ZF4DD+RbtP8tXd/Bs4z3lVV+G2o50H6dZ+0qvaGHSxVdzWfZfSZT/a6hroOvjq8h8D/PGt76fI4Sgh6TQYMS67x6YtK/ksKpPg4C1y2Awlf+3M68sz7KVFf5V2+BvJro1LTYAN0yNdoIc+i5zUq+RQGM0/qxTo+ZidC/Xi024r03MGTM/rEWpyGEGUw5Kq9MZhPMpJXkcQtISiOjwzd8axq0/7Z8MEV9PekNFcVjBU2JFRJBU0pLlbJJPV/swsFj/HXzqFOeERG8dUkNGDjNOgv246I7spFYWeCuXO1rZE+CxJIMZPerh8EPuekGhPeWDBzGWn5gDFoaQPw/pHKuMPSwUb0P+afbPFg+hcl4pzf5IcrjgOL2osuNj/JhBaBzW9/+R3gwoP2il
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(4143699003)(38070700021)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEVIQWdkUC9XUVh3VmJha0VqSlRmc1JrdDdGbGRWZkp1R3licEo4OEpsTU1w?=
 =?utf-8?B?cVhQbHVSdXVwcmpITUtWYzhSaG1QL2lkZ1BrcVl5UTJMQTRpUk9aeGthT2F6?=
 =?utf-8?B?alM2Zk5GczFCWWpBOVNqOGJ0aVpJSTNJSzNqR3dBaWVObFE2d1RVaFc3VUNt?=
 =?utf-8?B?dFRQWDljK2Q3N2V3RmFHT3hFalJoUTZPTUIrYnpQZ3RNT2w5ZWo0MVdMb2Mw?=
 =?utf-8?B?NlFVSDhSOXg5RG5rV1MxVlU1VWFsREdtbHYxVGV5VEVmZytzUnhFQXliN0dt?=
 =?utf-8?B?bDduSnZ0dk1XMkprWjlVa21DOCtZSDlqMkh4NCtxRU5hVXFJTzNZMytjcVVq?=
 =?utf-8?B?WFp5eEtUKzUxTWJwZGJyWEdvUm8yUThnRHRnVXZ2bktYeVBxMytvbjEvRzI3?=
 =?utf-8?B?aXEwTlZKNFhnNm1uWXNPaXdDeHhrUFo2ZEdTc0wxWlFYQlBaM1pBYzBpaTBr?=
 =?utf-8?B?NTVZK1BEOFZ4Y0VtMm1qVmlDYjRUWUhTbm1abDdTenJPWFFNUDlYemVYS2M5?=
 =?utf-8?B?UTNKem05dE5vL01sWFNxYTFRaGM1d3lFNUVrWm1PVlNla0kwenh4L1BwYXVD?=
 =?utf-8?B?cnVYSXRFRjJJUUFNREhHRVd5Zk9TR3NISGZmVVE3L29RTXpxaGxQOVFuWm1Z?=
 =?utf-8?B?dDVLTXZTNDVDVC81TUVLS1VBNkJlb0MzQy9OSU9YQXBDVmpCaWg0YlZ2NnR5?=
 =?utf-8?B?NHpWaitpMFNNc3hHYkdIQWtSSkZ4dzJ3U2dCUEMybjdXMCt0ZVNTdFo1VWdW?=
 =?utf-8?B?MTZoSEJFTXhXRnhOWWxQS3hYNzI0MlFsN2dpTmNlNW8wV1V2YjEvR1Vxd0JE?=
 =?utf-8?B?TTRDWEh5ZDJTWmMxUGRNSVJzNmlMNkpoUEJDUVZmcHpBendKU1Z3RXR2dU1E?=
 =?utf-8?B?bmwvVGh2S1k4aEZRQ2w3NEYrVVJKQ1ZqTC9RbzIzdWhTTk5GcXc2cHZ0c3hr?=
 =?utf-8?B?YzhwWUZDMDhiVk4zdzJpemlzT1NyMzkxdjFsVFEyTlRlbnZiS2JPYysyV2lI?=
 =?utf-8?B?QmVER2RSZnJpTDBFWWkzanRiRlVkS0tZUHFSdVVBVkN6cDZ6R0NmbVRJalcy?=
 =?utf-8?B?aFdsOEZCdndFTzdIYUdtVGNudG8xUG9IV21seDBpb3B6ZWc5MTRLT3htRkFZ?=
 =?utf-8?B?a0lpUllpTzIvR3ZiR3RUWjgvLys5cWZYSytVVjVNeitQV2JRQzdUZzhwSjZr?=
 =?utf-8?B?WkpRcjNjTE1KY2NkcU03NVNjNFdvTW5uZFVOSXBZd3NKOThOQkZ1MlFoL1pR?=
 =?utf-8?B?Q0RzRE9OaHo1SU5LeVNHYmpqWlFCc3hOaXZaK3U0UnNmVHVHL2FkVVlaa1ly?=
 =?utf-8?B?RlJKQlhKTFNHZmNiOFF2WHdldnJvckFqMk9PYUIxLzZxTE14QjBLWkVrNyti?=
 =?utf-8?B?ZUxKUU5FU1laaHVuaXV1UHM3a21Ub2R6ODJvSk90Z3Y2cHVOaW9JZ3NjY3Rk?=
 =?utf-8?B?UUFyNks5QnJWRG9wazdNeCtLWFliOXhZZVdQUGQwaURUYklQK3V2SzFZU29r?=
 =?utf-8?B?RVRVQmVENjBIcmdFVk5YeUhPRUdCRDY5aVNubVBSbkFUU0FtYlNnMUllcE56?=
 =?utf-8?B?N2gwdDYwdHppa0VqRGlMd1lvekJOY2lnVUNwV3JVVUhhYU9KTXZvN3BaVU5a?=
 =?utf-8?B?K0dmNGVsSlo1NE5VOHc1SDNRVHBiZHk2OFA1dTdPdUhwbG9DTlNCYjU2a25k?=
 =?utf-8?B?S1RuTXZ1TWUzNGJlTy9HUzBteE1seXN6VFRwWmZVOGlPbytsNEVTcVIxV21M?=
 =?utf-8?B?elI0V1dKWCtVUStGWjRMRWlQdTJQSllQVHdrR1lZYUJqS0ZTem0zV3RzVGli?=
 =?utf-8?B?b2luM2EyRW9zYTNobjErcVNsbXptaXMvNGpsbTM1RUttZWpvSllaMTUzTzZn?=
 =?utf-8?B?Skg3S0RLUzlLeVFxR0ErMDF5VFF6eEs1Wkw5YWNwRUIzRzdHZEJMdnczZklo?=
 =?utf-8?B?NGVOOWFSMWtOOVB6RUt2L3V1TkY5T2hKQldrUzhKSFN1dko2anQ2VE1IQ05x?=
 =?utf-8?B?MG9pSk8xSFpFdlRhWlNuZEJKeHVJOUJLRW5UOFJNc2dKeno1VWdyQ3I2a0ho?=
 =?utf-8?B?eHEzQmFQbzNNS050djJ3VzlQbWRwYU4waGMrMU1McFZsOXlQVkkxL2RzQnJE?=
 =?utf-8?B?SjFMNTgxM3Nta3JTR0t0RnUrbTIxOTUzTGI1M2hrYkVNdWhwWUpJSXdGTnFs?=
 =?utf-8?B?U3NGakZYV0g4ZHczc0NVUTF5cWl0S0pwMU8yTWJUcnYzQ3U2Zm13a2VhNUxD?=
 =?utf-8?B?TzZvOHo5REN0UW9EUlBwYjVJd3JXc2Q2elQvbXZxaGIyQ0htWWphQjUxOWQ4?=
 =?utf-8?B?a21mdHdHK0w1czdGZWRyamZKWG9MSG9UY1lqcFpNUlRWQmFSdVhPUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74277EC239721B4988B29E2A058E201C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZFmiD55lZa4w4fNjQV3IZqPno1lPhmTJCjFopplB12IXEULHLiSAxgMxpBcMe8krQmIujXH6nDDgjpe33EShymifp7FysQT/iJ5P8kQyPwmNoZuUGZdedv5XgnLb+q/06SYF3HVmMr1v0/SnEzbStn5/b5i8Kjc/XCd1AA/pD8oH+QixmdirfD0OdCceJdHmXPsyAVuYkIBxgVx5WNwByo7Q81kmdsArKtExBpV1eohg0Uh5Z1aSPP2JWc16J8zj+pOMmPkN2h5RtNCMInnjrH5OLtnZAX+ql+GWSVaGpMrBHhcaYUl3GKUug9b7aRH9hsfRnWgZUCI2PJRfmmprow==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59bd32f5-73cd-4e7e-b9a0-08decc133f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 01:53:36.8137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gAyTMuXBXRcZPlUUK36zLN6b7d2bK+6mMEOG/OFRXIOOufj+QfG0ZfJHCIpbcAp/cTB+KoIK+J0q5eWvlURv/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB10241

SGkgUGF1bGksDQoNCk9uIFR1ZSwgMjAyNi0wNi0xNiBhdCAxNzozOCArMDMwMCwgUGF1bGkgVmly
dGFuZW4gd3JvdGU6DQo+IA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUg
c2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiANCj4gDQo+IEhpLA0KPiANCj4gdGksIDIwMjYtMDYt
MTYga2VsbG8gMTE6MDEgKzA4MDAsIENocmlzIEx1IGtpcmpvaXR0aToNCj4gPiBBZGQgc3VwcG9y
dCBmb3IgTVQ3OTI4IChkZXZpY2UgSUQgMHg3OTM1KSB3aGljaCByZXF1aXJlcyBhZGRpdGlvbmFs
DQo+ID4gZmlybXdhcmUgKENCTUNVIGZpcm13YXJlKSBsb2FkaW5nIGJlZm9yZSBCbHVldG9vdGgg
ZmlybXdhcmUuDQo+ID4gDQo+ID4gSW1wbGVtZW50IHR3by1waGFzZSBDQk1DVSBmaXJtd2FyZSBk
b3dubG9hZDogUGhhc2UgMSBsb2Fkcw0KPiA+IHNlY3Rpb24gd2l0aCB0eXBlIDB4NSBjb250YWlu
aW5nIGdsb2JhbCBkZXNjcmlwdG9yLA0KPiA+IHNlY3Rpb24gbWFwcyBhbmQgc2lnbmF0dXJlIGRh
dGE7IFBoYXNlIDIgbG9hZHMgcmVtYWluaW5nDQo+ID4gZmlybXdhcmUgc2VjdGlvbnMuIEFkZCBy
ZXRyeSBtZWNoYW5pc20gZm9yIGNvbmN1cnJlbnQgZG93bmxvYWQNCj4gPiBwcm90ZWN0aW9uLg0K
PiA+IA0KPiA+IEFmdGVyIENCTUNVIGZpcm13YXJlIGxvYWRzIHN1Y2Nlc3NmdWxseSwgdGhlIGRy
aXZlciBjb250aW51ZXMNCj4gPiB0byBsb2FkIGNvcnJlc3BvbmRpbmcgQlQgZmlybXdhcmUgYmFz
ZWQgb24gZGV2aWNlIElEIHRocm91Z2gNCj4gPiBmYWxsdGhyb3VnaCB0byBjYXNlIDB4NzkyMi8w
eDc5MjUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgTHUgPGNocmlzLmx1QG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gW2NsaXBdDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1
ZXRvb3RoL2J0bXRrLmggYi9kcml2ZXJzL2JsdWV0b290aC9idG10ay5oDQo+ID4gaW5kZXggYzgz
YzI0ODk3Yzk1Li42ZDNiZjZiNzRhMWQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9ibHVldG9v
dGgvYnRtdGsuaA0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmgNCj4gPiBAQCAt
OSw2ICs5LDggQEANCj4gPiDCoCNkZWZpbmUgRklSTVdBUkVfTVQ3OTYxwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqANCj4gPiAibWVkaWF0ZWsvQlRfUkFNX0NPREVfTVQ3OTYxXzFfMl9oZHIuYmlu
Ig0KPiA+IMKgI2RlZmluZSBGSVJNV0FSRV9NVDc5MjXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oA0KPiA+ICJtZWRpYXRlay9tdDc5MjUvQlRfUkFNX0NPREVfTVQ3OTI1XzFfMV9oZHIuYmluIg0K
PiA+IMKgI2RlZmluZSBGSVJNV0FSRV9NVDc5MjfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0K
PiA+ICJtZWRpYXRlay9tdDc5MjcvQlRfUkFNX0NPREVfTVQ2NjM5XzJfMV9oZHIuYmluIg0KPiA+
ICsjZGVmaW5lIEZJUk1XQVJFX01UNzkyOMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgDQo+ID4g
Im1lZGlhdGVrL210NzkyOC9CVF9SQU1fQ09ERV9NVDc5MzVfMV8xX2hkci5iaW4iDQo+ID4gKyNk
ZWZpbmUgRklSTVdBUkVfTVQ3OTI4X0NCTUNVwqDCoMKgwqDCoMKgwqANCj4gPiAibWVkaWF0ZWsv
bXQ3OTI4L0NCTUNVX0NPREVfTVQ3OTM1XzFfMS5iaW4iDQo+IA0KPiBBcmUgdGhlc2UgZmlybXdh
cmUgbmFtZXMgY29ycmVjdD8NCj4gDQo+IFRoZSBhYm92ZSBuYW1lcyBmb3IgTVQ3OTI4IHNheSBN
VDc5KiozNSoqIG5vdCBNVDc5Mjg/DQoNClRoZSBuYW1pbmcgaXMgaW50ZW50aW9uYWwsDQpNVDc5
MjggaXMgdGhlIGV4dGVybmFsL21hcmtldGluZyBuYW1lLCB3aGlsZSBNVDc5MzUgaXMgTWVkaWFU
ZWsncw0KaW50ZXJuYWwgY29kZW5hbWUgZm9yIHNhbWUgY2hpcC4gVGhlIGZpcm13YXJlIGZpbGVu
YW1lIGZvbGxvd3MgYW5kDQpnZW5lcmF0ZSB3aXRoIGludGVybmFsIGNvZGVuYW1lLiBXaW5kb3dz
IFBDIHBhaXJlZCB3aXRoIE1UNzkyOCBhbHNvDQpmb2xsb3dzIHRoaXMgcnVsZS4NCg0KPiANCj4g
PiANCj4gPiDCoCNkZWZpbmUgSENJX0VWX1dNVCAweGU0DQo+ID4gwqAjZGVmaW5lIEhDSV9XTVRf
TUFYX0VWRU5UX1NJWkXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDY0DQo+ID4gQEAgLTU0
LDYgKzU2LDcgQEAgZW51bSB7DQo+ID4gwqDCoMKgwqDCoCBCVE1US19XTVRfUlNUID0gMHg3LA0K
PiA+IMKgwqDCoMKgwqAgQlRNVEtfV01UX1JFR0lTVEVSID0gMHg4LA0KPiA+IMKgwqDCoMKgwqAg
QlRNVEtfV01UX1NFTUFQSE9SRSA9IDB4MTcsDQo+ID4gK8KgwqDCoMKgIEJUTVRLX1dNVF9DQk1D
VV9EV05MRCA9IDB4NTgsDQo+ID4gwqB9Ow0KPiA+IA0KPiA+IMKgZW51bSB7DQo+IA0KPiAtLQ0K
PiBQYXVsaSBWaXJ0YW5lbg0KDQpDaHJpcyBMdQ0KDQo=
