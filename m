Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CF31DF75B
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jun 2026 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475853; cv=fail; b=Nn5aP0rmAxJA4+CjiB//oJzGyBcw30sorOFHgvF1v9VSjGjGk8pv6hDutJPfzUrTIHFV3VkAyRR3gd6PrFc0LG2AMDJHkmI0ojnC5HbKc9ZZ4++ZQyNcccq2iS5gvIyDvYMeEcCc9mv1FxT2g6tWVnVGU2cEW7ctfneFSjZLvDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475853; c=relaxed/simple;
	bh=+8Z76FBPhGZM6zMAVTy6t4Jx1uaUPAu5eWjSudLMHE8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=afVtD4a0xbm6ylOI+HiAiZnu9+VwS9JMtgJOO7TEX7wPMlB3CYg7ijTAXTzQmzJhTF2Fti11bYfEcdJUE6HaGWaqOoohorMA/KYnlHEq/6vsGi7MDecZsV9elQat9h+ZrHnrAZdrU50Ht/PCom7U9+38e2K5bwglvMd5meCrjfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=UOpq633f; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Bkb1aPG6; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UOpq633f";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Bkb1aPG6"
X-UUID: 70f0d3425f2711f1b1788b6acf885367-20260603
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+8Z76FBPhGZM6zMAVTy6t4Jx1uaUPAu5eWjSudLMHE8=;
	b=UOpq633fIaATLbs1YH4XoDzMTIjD+B7NGYNJWZVTFhyiongPdZgHmXND5p0mPnjPlQkdaq/pDnTLKNxnby/YHZihY/yeeTy8JK6sMOEyuFuoHBWeJ8WzxTzAE8s2/Vkhr5rJmAn/MDHGyMYyncWegXozRgNwPT85MeqCw22pySU=;
X-CID-CACHE: Type:Local,Time:202606031549+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:7fdcef96-1248-4717-8384-41d3a66014d4,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e276073,CLOUDID:ca356dff-ece9-4b61-b051-0e792034d0bc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
	898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
	l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 70f0d3425f2711f1b1788b6acf885367-20260603
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 702182820; Wed, 03 Jun 2026 16:37:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 3 Jun 2026 16:37:21 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 3 Jun 2026 16:37:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGgZDJzPg4QgH29Zk2aM+//kjK4ECVybigMrPsdYHf/B9zKBDyGosOfAyYxShfQvNSdgrPbPTPKMpLoIBJPBZc3PghV/zpKbXUyLwZ+/ZUJhm4OfER4lH+7nDU97LrtFTML3a8rK9unQXlSKZ9QCR/iPv2DlTwxrnwb4k/WO5aQIiBVfuANFTHVm9E2mKM0aQoKo818znPJOCAjsxaXZmZAtk7fVos20JVQIB3+vXrNlwJ5fBhvyLpy89SU6UgCog0SSl4l+IoSHylinwNRd+JDQ/Jwn+DWbLmt6GmV9X13hqfRM9jXcXmgBdZb9mh4fGFbYl5YXHD/I2y2NwH50AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8Z76FBPhGZM6zMAVTy6t4Jx1uaUPAu5eWjSudLMHE8=;
 b=YcN4fcfhiFfTCe9EhVVTaiVPaKR/CzalVrZwWBnfV1dri0UB2FP2v2FdtEm8gqZwJ9iMyDm3pzXwN5CeqgfZDkvSMrfRxniTVsnQr5yAK3CvLy5jKk2Upf4guHtjNEmONLI47pCNsx4KUmU9IHqn4W5KAB7UQXhYE/2L3UvhDrt7RXcc5//PTHzGtMdH1F77AnAcIr2NcrxLmO7C0mTlcQ5TyCdbZLXaPYNbuQKHP6uMd3S2oSfLIBNiAybPiINg8YwKUoS1TmpQR4JHL652qeixAgY4SbYH1WocokUmoDY7EAdyyJwrplk439fCx84vU8x0Mh+QQRlZ9fPbAkAZqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+8Z76FBPhGZM6zMAVTy6t4Jx1uaUPAu5eWjSudLMHE8=;
 b=Bkb1aPG63RxOG8aClf+F0cwkFegbUnzmum8LNVpGcD41gJaGAmq1e39F6k2Vm90mGJFsl4n6O7+RO6RUjJniWeUTyfXljJmaCBfxGtWSCa49mOhRly2FUjlsrNplLuTJ0SU9y1GPvNjL3s74J/0t8w5QNUKiFOr2bwi+V4UibfA=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by KUYPR03MB10336.apcprd03.prod.outlook.com (2603:1096:d10:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 08:37:18 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%3]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 08:37:18 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "messinadm@gmail.com" <messinadm@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	=?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>,
	=?utf-8?B?U1MgV3UgKOW3q+aGsuasoyk=?= <ss.wu@mediatek.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	=?utf-8?B?UGV0ZXIgVHNhbyAo5pu554+G5b2wKQ==?= <Peter.Tsao@mediatek.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Fix MT7925 WMT command timeout due to
 sleep protection
Thread-Topic: [PATCH] Bluetooth: btmtk: Fix MT7925 WMT command timeout due to
 sleep protection
Thread-Index: AQHc8Sh0pModVjMSxUeRDkTz1yaVY7YsIjhQgABWiICAAAsp4IAAAiUA
Date: Wed, 3 Jun 2026 08:37:18 +0000
Message-ID: <3333c9b420af0b81c0ed21b969ca6e67b9701a84.camel@mediatek.com>
References: <CAJAa45g30APLE4avbWg6EfkcUATR1rDh7a2DOM6dBOYbdF-a1Q@mail.gmail.com>
	 <KL1PR03MB59762013DD64C282D57FA37AFA132@KL1PR03MB5976.apcprd03.prod.outlook.com>
	 <200a9854dcce8a152b75f1c4497210c146f89cbc.camel@mediatek.com>
	 <KL1PR03MB597680711115B27DA7D42571FA132@KL1PR03MB5976.apcprd03.prod.outlook.com>
In-Reply-To: <KL1PR03MB597680711115B27DA7D42571FA132@KL1PR03MB5976.apcprd03.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|KUYPR03MB10336:EE_
x-ms-office365-filtering-correlation-id: 22d2dd99-7594-471c-14ad-08dec14b52ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|3023799007|11063799006|4143699003|22082099003|56012099006|38070700021;
x-microsoft-antispam-message-info: TnVcVI4i78jjMPU3EOvxPAGfPYkr1jpfklvfAEn7qFvfJ7ZQs9z4TDiAE7ZGPp62HJUyC7UE1gLzjX7BFUkUJ1aD9Ld3jzJYrVROkO3DT3babTXFwZ8dCbnqQXeibnOg/XIDqQuuXHa93xK5ldt1cLbe0wKfACB0J+kz9na+C7AqySKmU1e/7OxUdzmZXS8l6/MVjDjOJMdaLPPKfmzea5DZEDv7/vQE2VPtAZJfaDae4W1TV4B3MpL6xsCpL8fzoy5921ry/rMdYZOHpjozr6iO7TzGDCscbTtEIlievxIPvi0FGJk1RbFS82oS7pHnG9B9Pd6iH/kGHLNsJo5kCbjEk4US04BWcNtcHJKUiw0W7Qt3QrUUZavTrfzTkDiAbg1lPKurS0/+RpL+O7RYgzZQg7C2/jgVY/dOZwnOP5j0+kCvnjqtfTocryJ9cPXtXJ5VyZ+WkhKBd0gPmnQOiSCz/XEpHUu0uHg+Jo+TBhp8i0tfLpY6GpQEpiJHDElfBvZktBVo4kO8YDuGAODscuQwUr0XXckRRpprbPWwBPySG5Gv0pxUIQDSLYTENSmm2KHgKB/MT0gb4jviCwyQfnNryNcyEJyw2lX67gJgkdD4xs7Gq2ZuwFf3PT4esQDyfIBfzRW/GSEWvgiS5knFYl+I2xT6Lr156ggK6CedduFxdAcIcmaRS8xDRLG0Dll6vJ5PfYegliZadslHilR42kXzJd03cxmLPtv+zF6Rooq69B3BQVqnzTHKyC927vCj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(3023799007)(11063799006)(4143699003)(22082099003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SStjRTVTRTlRdG42Ynp5Tkd4U1BPMzFmWnJudGt5MFFMZHBTMG9yTG9oRkJM?=
 =?utf-8?B?eDZ6YkJBc3FnWkh3eDZDY0x0Q1hiajdIc0dEYUIyNWdjckpUbWxJWVloQXNO?=
 =?utf-8?B?NVdCZk10UEo3UkE5WVZZRWEvLy81Q0ZoTDhtbE9obnd4WXRQL1FWVEZtN0RR?=
 =?utf-8?B?a3FJUm9UZmRWWXFTWjJsL0l4OUE5bVR5eGl6cEpUYVZvZ3JYZHdEZEQvTXU0?=
 =?utf-8?B?VWJDb3VNY1FBK29KRjJWQ2N5R3RCRm8rQm9XRmJ3MjgwZzhpbVJkZU9uWmdD?=
 =?utf-8?B?YXpwemYxeHdEVnVWNnc4SUNrSHpHWGQ4cHhoQkZXazhJNTQ1dGJUeTBCdGo0?=
 =?utf-8?B?ak9hS0xqYU9XN2RmRHFvcEF6RGZzeStlNUxJZnZaQVpPZm1UVVNlU2I2RXVl?=
 =?utf-8?B?elFuZVBxQjVHT2tMVjhmUXBUK09lRUVnNFlXUUZ2OFhkY0cvTTJiVG0wckl3?=
 =?utf-8?B?SzFNWnpmUUV3dWVMbzBjRkwwV1RCbWoyZDdNM2hMdjB6eE1vd2c5RkNxOWE3?=
 =?utf-8?B?UHdaRGV2Um5vV3EyaXR3WVJrOU83bzJPVmtBMmxHSis3RFo0bVg0bU14YWto?=
 =?utf-8?B?WStUSEZnMSsrK2Y0cGdxVVdpUnR4TERBb3VXR3UvczdUeDlYTGRtOUtlcXJJ?=
 =?utf-8?B?alpNMlRNVmNLQnpJRlR1c0V4N2twdmNJbkJabUQzZTRaZGhrUkh0anJQNnV2?=
 =?utf-8?B?aml0Q0JxVFZHREdtVXNZUGgydURkTUk5SEJSdGQ2ZDNQUmtUZU1KQmYzbnUy?=
 =?utf-8?B?c01adCtmc1M0bjJVQm5JREtpVjArUExPTjJ6b3Y1eGc4OGprZjVLZE9UR2lB?=
 =?utf-8?B?L1M3cDljaWJHekljMlMrdk5QbFFLcXBVZzNraUtrKzZZTFVOY0lFeGdEdWdR?=
 =?utf-8?B?d3pFc1FUa3VmSkRvY0NROFByT3BERURoSnlHdHVlR25xNGd0V3dqNVFTZlMy?=
 =?utf-8?B?aUZBcEZpTU5XUHBTUkxqV1hoVnlYeHhZMUt5L2UwSkUyaFZUNGZvMHltejFX?=
 =?utf-8?B?ZmZGeGdvOFdPTzJFU201Ymh4Z01PVWw5TTdraDFqNi9mTlYyMjU3c3QrSmpI?=
 =?utf-8?B?YmtwRW1jSnh4ZzlHOTZkMVdPVHlHMTdkSkdqdEl0YSs4d1U3Q1gvdFhjSmRI?=
 =?utf-8?B?dXlWbzdCcU0xRzVmZldKRkxYZ0JqQ0JaZTlqUll2Q2x3ZGVJenB5MTc5Z3Ev?=
 =?utf-8?B?NS80Rm1aWnoyelU1NktxRkVFRVBySGxxUisrbW9Fc2s0d3FlamMvQ1dpb2VZ?=
 =?utf-8?B?L0RXSURaV1RrZU9TeUNNRS9IL3RmaFN0SWt1ay9oNy9icURLaXJHalZyTEFV?=
 =?utf-8?B?Si80UVh5V24wTXhkZlFteDJGOWcya01rODNRYnp2L0FjN2NtN0JMdEhmdkpm?=
 =?utf-8?B?U0FaRHhyeHdtbXN0Rk5zNWZBaDJ5TjVYZHdNVkJEeWJZYzBYNjU1OG1GTkVG?=
 =?utf-8?B?cDVVL2xGZnhtcHNqZlhrejNCZkNQNGFqY3dHNGQwQjExaDB6Tk01Z3NTV0J5?=
 =?utf-8?B?SVo4S0FndzhjQzhyOWhTK3FEUXFBODFJSnhhQTRnYXJIQllZMlBWVGViWlg1?=
 =?utf-8?B?WnVZU1VSdHB5amZqZjZaTjc0blhHZWRDT2taMnV3RWRuWUxvNjZJTGZDT3gw?=
 =?utf-8?B?Tkp1SFhoUXBoVnduaXdScFNXT3l0UEdBN253MmRzalVmTVJGdmxrUXRXWVBP?=
 =?utf-8?B?OWxHL0lha0VUbm0vMGJjV3hIaGNib0ZZV1c4WnVYMjBCMnZlaWRPem9tSXpr?=
 =?utf-8?B?QXh6K2c3cUxtaXNlOG4vdkZrdEwyeXRuY3I2bnF0cDZNUmRYZDRDY2RaQnRL?=
 =?utf-8?B?MlJ5MUdhMW1scHZpV0swQlBoQVJjSWNWQUZtRm9mbk5iTXd4U0IySFlUY2Qx?=
 =?utf-8?B?VHppTUw2d3h0UU9aRk5JQ3k5ejdzanNpdUZ1a01EOVIvdHR0THlyQ0dVZ3oz?=
 =?utf-8?B?cGtWaG9UM1NVRjRjWCtGc0RVbG4rNWVpOFh6Y0Z2OGduTDc4L2VjL1Z4S1VG?=
 =?utf-8?B?Qkc1L2JaY2xYSk1XTTZWT1JaT2YrOTMvbjZydHMyL2JYUlNURjNaRnpxNXZ0?=
 =?utf-8?B?UlNWYVVPejd3M1drdHFVQm91VUNyL1NmK09LcG1KekVCOG5MMCtNb3I0MEVU?=
 =?utf-8?B?bVVzanhjYlZQV0JLQ3djMmJZcCtMLy9DR0dMTW1UalA5S1A5N1luZ3FVRkVy?=
 =?utf-8?B?blBzRXBVc2NrQ25Zb0tqa0lDc3JSSW1lTklaZ3loS3NrUFBEOTdYaGtKMS8x?=
 =?utf-8?B?Ukl4bXZmQ082KzVHZVFmRHZvTDFyY0F5aVUzUWFxZHhOY21jaXJEbTdsRDkx?=
 =?utf-8?B?LzVQbU1NeGhFM21IN2x6ZkZrNllLNzI1NDAxcjd2NFk3TTdONDBFQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4B62DBCC4114C4E8892B9EDA292B228@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: JOh3HnFgoglxegfVHE6Yu2hhqI6xtb9QzEcOg56J0V0HGvW5HunrtlSrpmWh49lJu2jkZa3wBeRfmFsW20HTK9gq2vu3Cs3H68BnDIemkTJThEV2uCfoWzUOrgo6didSIc6Ew1wDd1qAyLPMuMQ4g+4buUamI3FmYipY9XrpNi1SxQLFdqrN+hFmhyV8Ra8yiWStVrgwYXKtBgEl7X0fnVZ/MA35SRNm9osAVyuGG2vpj/8eO9A5Dh1rlyYEQ4HYIBPhWpxgePzC7N09oGWyVOHIyuLwrAHeDdpvxcIEEWdVizy6zCgH/8uekgo/UCsOdEojQYZ2NXlBwIkh6eo91Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d2dd99-7594-471c-14ad-08dec14b52ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 08:37:18.6410
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jsgmIeX6UZmS0yJGcHuu6X/7m5LB3bdeA/EeWi7pHdZqlnAPW9HPe2KLNf+dRMlxpJqXf5AbpBKdTT9Y8wCRHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR03MB10336

QWRkIGxpbnV4LWJsdWV0b290aCB0byBtYWlsbGlzdAoKPiBGcm9tOiBDaHJpcyBMdSAo6Zm456ia
5rOTKSA8Q2hyaXMuTHVAbWVkaWF0ZWsuY29tPiAKPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMywg
MjAyNiAzOjUwIFBNCj4gVG86IG1lc3NpbmFkbUBnbWFpbC5jb20KPiBDYzogbHVpei5kZW50ekBn
bWFpbC5jb207IFNTIFd1ICjlt6vmhrLmrKMpIDxzcy53dUBtZWRpYXRlay5jb20+Owo+IG1hcmNl
bEBob2x0bWFubi5vcmc7IFBldGVyIFRzYW8gKOabueePhuW9sCkgPFBldGVyLlRzYW9AbWVkaWF0
ZWsuY29tPgo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIEJsdWV0b290aDogYnRtdGs6IEZpeCBNVDc5
MjUgV01UIGNvbW1hbmQgdGltZW91dAo+IGR1ZSB0byBzbGVlcCBwcm90ZWN0aW9uCj4gCj4gSGkg
RGFubnksCj4gCj4gVGhhbmtzIGZvciB5b3VyIHN1Ym1pc3Npb24uIEkgaGF2ZSBzb21lIHF1ZXN0
aW9uIGFib3V0IHRoaXMgcGF0Y2guCj4gCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+
ID4gRnJvbTogRGFubnkgTWVzc2luYSA8bWVzc2luYWRtQGdtYWlsLmNvbT4KPiA+IFNlbnQ6IE1v
bmRheSwgSnVuZSAxLCAyMDI2IDI6MDcgQU0KPiA+IFRvOiBsaW51eC1ibHVldG9vdGhAdmdlci5r
ZXJuZWwub3JnCj4gPiBDYzogUGV0ZXIgVHNhbyAo5pu554+G5b2wKSA8UGV0ZXIuVHNhb0BtZWRp
YXRlay5jb20+Owo+ID4gbWFyY2VsQGhvbHRtYW5uLm9yZzsgCj4gPiBMdWl6IEF1Z3VzdG8gdm9u
IERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4KPiA+IFN1YmplY3Q6IFtQQVRDSF0gQmx1ZXRv
b3RoOiBidG10azogRml4IE1UNzkyNSBXTVQgY29tbWFuZCB0aW1lb3V0Cj4gPiBkdWUgCj4gPiB0
byBzbGVlcCBwcm90ZWN0aW9uCj4gPiAKPiA+IAo+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2Ug
ZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMKPiA+IHVudGlsIAo+ID4geW91
IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4KPiA+IAo+ID4gwqAgVGhl
IE1lZGlhVGVrIE1UNzkyNSBVU0IgQmx1ZXRvb3RoIGRldmljZSAoMGU4ZDowNzE3KSBmYWlscyB0
byAKPiA+IGluaXRpYWxpemUKPiA+IMKgIHdpdGggcmVwZWF0ZWQgIkV4ZWN1dGlvbiBvZiB3bXQg
Y29tbWFuZCB0aW1lZCBvdXQiIGVycm9yczoKPiA+IAo+ID4gwqDCoMKgIEJsdWV0b290aDogaGNp
MDogRXhlY3V0aW9uIG9mIHdtdCBjb21tYW5kIHRpbWVkIG91dAo+ID4gwqDCoMKgIEJsdWV0b290
aDogaGNpMDogRmFpbGVkIHRvIHNlbmQgd210IHBhdGNoIGR3bmxkICgtMTEwKQo+ID4gwqDCoMKg
IEJsdWV0b290aDogaGNpMDogRmFpbGVkIHRvIHNldCB1cCBmaXJtd2FyZSAoLTExMCkKPiA+IAo+
ID4gwqAgVVNCIGNhcHR1cmUgKHVzYm1vbikgY29uZmlybXMgV01UIGNvbW1hbmRzIHJlYWNoIHRo
ZSBkZXZpY2Ug4oCUIHRoZQo+ID4gwqAgQ29udHJvbCBPVVQgdHJhbnNmZXIgY29tcGxldGVzIHdp
dGggc3RhdHVzIDAg4oCUIGJ1dCB0aGUgZGV2aWNlCj4gPiBuZXZlcgo+ID4gwqAgcmVzcG9uZHMg
b24gYW55IGVuZHBvaW50LiBUaGUgY29udHJvbCBJTiBwb2xsaW5nIFVSQiByZXR1cm5zIHplcm8K
PiA+IGJ5dGVzCj4gPiDCoCBpbmRlZmluaXRlbHkgdW50aWwgSENJX0lOSVRfVElNRU9VVCBleHBp
cmVzLgo+ID4gCj4gPiDCoCBUaGUgcm9vdCBjYXVzZSBpcyB0aGUgTVQ3OTI1IEJUIGNvcmUncyBz
bGVlcCBwcm90ZWN0aW9uIHJlZ2lzdGVyCj4gPiDCoCAoMHgxODAxMTEwMCwgYml0IDEgPSBTTFBQ
Uk9UX0JZUEFTUykuIFdoZW4gU0xQUFJPVCBpcyBhY3RpdmUgdGhlCj4gPiBCVAo+ID4gwqAgcHJv
Y2Vzc29yIGlnbm9yZXMgaW5jb21pbmcgV01UIGNvbW1hbmRzLgo+ID4gCj4gPiDCoCBUd28gYWRk
aXRpb25hbCBpc3N1ZXMgY29tcG91bmQgdGhpczoKPiA+IAo+ID4gwqAgMS4gQWZ0ZXIgcmVwZWF0
ZWQgZHJpdmVyIGxvYWQvdW5sb2FkIGN5Y2xlcyB3aXRob3V0IGEgaGFyZHdhcmUgCj4gPiByZXNl
dCwKPiA+IMKgwqDCoMKgIHRoZSBCVCBzdWJzeXN0ZW0ncyBXTVQgc3RhdGUgbWFjaGluZSBiZWNv
bWVzIHN0dWNrLiBBCj4gPiBzdWJzeXN0ZW0KPiA+IMKgwqDCoMKgIHJlc2V0IHZpYSBidG10a191
c2Jfc3Vic3lzX3Jlc2V0KCkgcmVzdG9yZXMgaXQgdG8gYSB3b3JrYWJsZSAKPiA+IHN0YXRlLgo+
ID4gCj4gPiDCoCAyLiBBZnRlciBidG10a19zZXR1cF9maXJtd2FyZV83OXh4KCkgYWN0aXZhdGVz
IHRoZSBkb3dubG9hZGVkIAo+ID4gZmlybXdhcmUKPiA+IMKgwqDCoMKgICh3aGljaCBlbmRzIHdp
dGggYSAxMDBtcyBhY3RpdmF0aW9uIGRlbGF5KSwgdGhlIGNoaXAgcmUtCj4gPiBlbmFibGVzCj4g
PiDCoMKgwqDCoCBTTFBQUk9ULiBUaGUgc3Vic2VxdWVudCBGVU5DX0NUUkwgV01UIGNvbW1hbmQg
dGhlcmVmb3JlIGFsc28gCj4gPiB0aW1lcwo+ID4gwqDCoMKgwqAgb3V0IHVubGVzcyBTTFBQUk9U
IGlzIGJ5cGFzc2VkIGFnYWluLgo+ID4gCj4gPiDCoCBGaXggdGhpcyBmb3IgZGV2X2lkIDB4Nzky
NSBpbiBidG10a191c2Jfc2V0dXAoKToKPiA+IMKgwqDCoCAxLiBDYWxsIGJ0bXRrX3VzYl9zdWJz
eXNfcmVzZXQoKSB0byBjbGVhciBhbnkgc3R1Y2sgV01UIHN0YXRlLgo+ID4gwqDCoMKgIDIuIFNl
dCAweDE4MDExMTAwIHw9IEJJVCgxKSBiZWZvcmUgZmlybXdhcmUgZG93bmxvYWQuCj4gPiDCoMKg
wqAgMy4gU2V0IDB4MTgwMTExMDAgfD0gQklUKDEpIGFnYWluIGJlZm9yZSBGVU5DX0NUUkwuCj4g
PiAKPiAKPiBDb3VsZCB5b3Ugc2hhcmUgaG93IHlvdSBpZGVudGlmaWVkIHdoaWNoIHJlZ2lzdGVy
L3ZhbHVlIG5lZWQgdG8gYmUKPiBtb2RpZmllZCBvbiBNVDc5MjUgd2l0aCBzdWNoIHNpdHVhdGlv
biBhbmQgd2h5IHBlcmZvcm1lZCByZXNldCBhdAo+IHRoaXMgc3BlY2lmaWMgcG9pbnQgaGVscHMg
YXZvaWQgdGhlIHNldHVwIGlzc3VlPwo+IAo+ID4gwqAgVGVzdGVkIG9uIGEgU3lzdGVtNzYgVGhl
bGlvIGRlc2t0b3Agd2l0aCBNVDc5MjUgUENJZSBjb21ibyBjYXJkLAo+ID4gwqAgVVNCIElEIDBl
OGQ6MDcxNywga2VybmVsIDYuMTguNy4KPiA+IAo+ID4gwqAgU2lnbmVkLW9mZi1ieTogRGFubnkg
TWVzc2luYSA8bWVzc2luYWRtQGdtYWlsLmNvbT4KPiA+IMKgIC0tLQo+ID4gwqDCoCBkcml2ZXJz
L2JsdWV0b290aC9idG10ay5jIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Cj4gPiDCoMKgIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspCj4gPiAKPiA+IMKgIGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idG10ay5jCj4gPiBiL2RyaXZlcnMvYmx1ZXRv
b3RoL2J0bXRrLmMKPiA+IMKgIC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMKPiA+IMKg
ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrLmMKPiA+IMKgIEBAIC0xMzI2LDYgKzEzMjYs
MjQgQEAKPiA+IMKgwqDCoMKgwqDCoMKgIGNhc2UgMHg3OTIyOgo+ID4gwqDCoMKgwqDCoMKgwqAg
Y2FzZSAweDc5MjU6Cj4gPiDCoMKgwqDCoMKgwqDCoCBjYXNlIDB4Nzk2MToKPiA+IMKgICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRldl9pZCA9PSAweDc5MjUpIHsKPiA+IMKgICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUzMiB2YWwgPSAwOwo+ID4gwqAg
Kwo+ID4gwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogUmVz
ZXQgQlQgc3Vic3lzdGVtIHRvIGNsZWFyIGFueSBzdHVjawo+ID4gV01UIAo+ID4gc3RhdGUgKi8K
PiA+IMKgICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVyciA9IGJ0
bXRrX3VzYl9zdWJzeXNfcmVzZXQoaGRldiwgZGV2X2lkKTsKPiA+IMKgICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIgPCAwKQo+ID4gwqAgK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ0X2Rldl93
YXJuKGhkZXYsICJCVCBzdWJzeXMgcmVzZXQgCj4gPiBmYWlsZWQgKCVkKSwgY29udGludWluZyIs
IGVycik7Cj4gPiDCoCArCj4gPiDCoCArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAvKiBCeXBhc3Mgc2xlZXAgcHJvdGVjdGlvbiBzbyBXTVQgY29tbWFuZHMgCj4gPiBy
ZWFjaCB0aGUgQlQgY29yZSAqLwo+ID4gwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZXJyID0gYnRtdGtfdXNiX3Vod19yZWdfcmVhZChoZGV2LAo+ID4gMHgxODAx
MTEwMCwgCj4gPiAmdmFsKTsKPiA+IMKgICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGlmIChlcnIgPCAwKQo+ID4gwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBlcnI7Cj4gPiDCoCArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2YWwgfD0gQklUKDEpOwo+ID4gwqAg
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyID0gYnRtdGtfdXNi
X3Vod19yZWdfd3JpdGUoaGRldiwgCj4gPiAweDE4MDExMTAwLCB2YWwpOwo+ID4gwqAgK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGVyciA8IDApCj4gPiDCoCAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIGVycjsKPiA+IMKgICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gwqAgKwo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJ0bXRrX2Z3X2dldF9maWxlbmFtZShm
d19iaW5fbmFtZSwKPiA+IHNpemVvZihmd19iaW5fbmFtZSksIGRldl9pZCwKPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGZ3X3ZlcnNpb24sIGZ3X2ZsYXZvcik7Cj4gPiAKPiA+IMKgIEBAIC0xMzQyLDYg
KzEzNjAsMTkgQEAKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyIDwg
MCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIGVycjsKPiA+IAo+ID4gwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBSZS1ieXBh
c3Mgc2xlZXAgcHJvdGVjdGlvbiBhZnRlciBmaXJtd2FyZSAKPiA+IGFjdGl2YXRpb24gZm9yIE1U
NzkyNSAqLwo+ID4gwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZGV2X2lkID09IDB4
NzkyNSkgewo+ID4gwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dTMyIHZhbCA9IDA7Cj4gPiDCoCArCj4gPiDCoCArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBlcnIgPSBidG10a191c2JfdWh3X3JlZ19yZWFkKGhkZXYsCj4gPiAweDE4
MDExMTAwLCAKPiA+ICZ2YWwpOwo+ID4gwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKGVyciA8IDApCj4gPiDCoCArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIGVycjsKPiA+IMKgICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHZhbCB8PSBCSVQoMSk7Cj4gPiDC
oCArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSBidG10a191
c2JfdWh3X3JlZ193cml0ZShoZGV2LCAKPiA+IDB4MTgwMTExMDAsIHZhbCk7Cj4gPiDCoCArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoZXJyIDwgMCkKPiA+IMKg
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByZXR1cm4gZXJyOwo+ID4gwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiDCoCAr
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogRW5hYmxlIEJsdWV0b290aCBw
cm90b2NvbCAqLwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHBhcmFtID0gMTsK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB3bXRfcGFyYW1zLm9wID0gQlRNVEtf
V01UX0ZVTkNfQ1RSTDsKPiAKPiBJJ2QgYWxzbyBsaWtlIHRvIHNoYXJlIHNvbWUgcmVsZXZhbnQg
YmFja2dyb3VuZCBvbiB0aGlzIGNoYW5nZToKPiAKPiBNZWRpYVRlayBCbHVldG9vdGggdGVhbSBw
cmV2aW91c2x5IGltcGxlbWVudGVkIGEgc2ltaWxhciByZXNldCBiZWZvcmUKPiBmaXJtd2FyZSBk
b3dubG9hZCB0byBlbnN1cmUgdGhlIGNvbnRyb2xsZXIgd2FzIGFsd2F5cyBpbiBhbiBpbml0aWFs
Cj4gc3RhdGUuIEhvd2V2ZXIsIGl0IHdhcyBsYXRlciByZXBvcnRlZCBieSBrZXJuZWwgY29tbXVu
aXR5IHRoYXQgdGhpcwo+IGNhdXNlZCBVU0IgZW51bWVyYXRpb24gZmFpbHVyZXMgb24gb3RoZXIg
ZGV2aWNlcywgc28gdGhlIGNoYW5nZSB3YXMKPiByZXZlcnRlZCAoY29tbWl0IDMzNjM0ZTJhYiAi
Qmx1ZXRvb3RoOiBidG10azogUmVtb3ZlIHRoZSByZXNldHRpbmcKPiBzdGVwIGJlZm9yZSBkb3du
bG9hZGluZyB0aGUgZnciKS4KPiAKPiBJbiBBcHJpbCB0aGlzIHllYXIsIEkgc3VibWl0dGVkIGEg
Zml4IGFkZHJlc3Npbmcgc2V0dXAgZmFpbHVyZXMgb24KPiBNZWRpYVRlayBCbHVldG9vdGggZGV2
aWNlcywgd2hpY2ggaGFzIGJlZW4gaW5jbHVkZWQgc2luY2Uga2VybmVsCj4gdjcuMS0gcmMuIENv
dWxkIHlvdSB0cnkgcmVwcm9kdWNpbmcgdGhlIGlzc3VlIHdpdGggYSByZWNlbnQga2VybmVsIHRv
Cj4gc2VlIHdoZXRoZXIgdGhlIHByb2JsZW0gc3RpbGwgb2NjdXJzPwo+IAo+IExvb2tpbmcgZm9y
d2FyZCB0byB5b3VyIGZlZWRiYWNrLgo+IAo+IEJlc3QgcmVnYXJkcywKPiBDaHJpcyBMdQoK
