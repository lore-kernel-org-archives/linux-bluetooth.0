Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA430AD58;
	Wed, 25 Jun 2025 03:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750822963; cv=fail; b=Xv6cWChT5a7vengjAnGLo5mjzap9+pHha1jcaHggk/JAmkNyZ4mI+PbCf0d1+Q2Z7CZfvlSTzQLONGCFnz4KPu/uVuAIDGb2sOVY7Ek73e0D8by8bikIVsBBb11dk5T7Pzw6LuZUvQvA2PDEy4vgXNROOPljYYI7Fx6UtZojpK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750822963; c=relaxed/simple;
	bh=zW9qo6nKnM7PnL0lcoY2WTazT1BjPhxASv1Ob8In6AY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ipA9BCb303PtlboJ/LGzZ5I57hqmXJZmrUwXNzZmv7aqyakPHCh2nRexZ8yu7m4j7pTM5boqlO0S16jkRTrgwRfnh1TrkjokygsQbdweZ4OLQ61DoI2yBd1832FNzhPl0TGGj3kz666K8Ms73DtjdxHKfL610ZvhJ097HYzixLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gLT/0ext; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=MfxpXeIi; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gLT/0ext";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="MfxpXeIi"
X-UUID: 6dd14a94517611f0b33aeb1e7f16c2b6-20250625
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zW9qo6nKnM7PnL0lcoY2WTazT1BjPhxASv1Ob8In6AY=;
	b=gLT/0extgihfe74cMDNv7BrMJjVOZyFu64/FYbzJ+zCgAehIvX6emZxvkkit3yVGtPZ+jEQScfR8EQN9CfOKiTAq+gnRrrGSi6Z1B4Eq2s1mP/qsb7rUx2XxwJu0cukKp4JmfyxNJhYnGmkgIuFXcwzuRGjT9HaKfmii9vnOXu0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:c0b86f0f-c48f-4960-9936-4985259a6886,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:f9908973-15a7-4ae6-ad4b-94c27b45c266,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6dd14a94517611f0b33aeb1e7f16c2b6-20250625
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 926140540; Wed, 25 Jun 2025 11:42:33 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 25 Jun 2025 11:42:31 +0800
Received: from TYPPR03CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 25 Jun 2025 11:42:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+S2d82JS/rLx+pmKnfsuxDVXm3BI+iTQf3SLCS/qG9JPpsEGXBfdryCFTsFq98/DTZWRX0KsPd0C/MKGrRk8xbHKGpFyhe4D9WVUZ1T2liQeGpKto7H5R69jE27Yk+SNbl8O/drR95etklf6xtHROaSsKQZ5y6JI+qxt7Y4qg9cyvk/LV/8Yv9iD4KRVMv99e5TwfkY/9fmPBIV4Bf7DuiOsfgGa2Vu8sPRFZeVEVLGvuMrdASr9JPS+diz0wukT/Fiiadmrno8938nSLsqlkIbrG91h/yYNTnl+Hzp8g1grjN3QJPil54NPX5bl1b2apmoEMkQESRTl5X13CITBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zW9qo6nKnM7PnL0lcoY2WTazT1BjPhxASv1Ob8In6AY=;
 b=h9RPfievDK9Fv5MdvW4TQYApTESzFh1ZMBAefpgjA9Qoh8LHOikvwuRRA2OmJ/jbpHmcZRu7bIp3eDPNQqVeI4AkU5mhsQe/QrLmI6tdDTSi6GmMFHuxWtbM2T/V6SgEOHJ0peCZlvnxL3BIHz03h4rC/zKiA3E89al04KKcMsnYNrQ4p4OKquJV8XVRPzbQ/ilcECC4IRT8NSTy8zRce78J6g4Erzz+gvCgPPxZE/JWWuVp10INkqTyWiAD4DHHEQldA7Bg1RevydofE+98z9QxQrs6dSJXvK2blZKiyDPDCUR4CWHwNkkrFmhfBvMdPZGIeIeue1fwqwkyvbUmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zW9qo6nKnM7PnL0lcoY2WTazT1BjPhxASv1Ob8In6AY=;
 b=MfxpXeIiItQhN2OnR2w80Xk7a4j+ww4tBi5FcKDZb10INEEqs60S2T2Eu6lpIZx0faXSSGgYgUHKz6z90e5nynCHbOK81Z2c7P9lL5zsyyRNAf9xWVUb3ZbedwhYkRxDMPuuU6kd+Civ/UCMezT26aXCbaC/notNl4R3XE3jT5Q=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SEYPR03MB6482.apcprd03.prod.outlook.com (2603:1096:101:52::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 03:42:30 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%4]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 03:42:30 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: =?utf-8?B?WmhhbmdjaGFvIFpoYW5nICjlvKDotoUp?=
	<ot_zhangchao.zhang@mediatek.com>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "krzk@kernel.org"
	<krzk@kernel.org>
CC: Sean Wang <Sean.Wang@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	=?utf-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?= <Aaron.Hou@mediatek.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: BT Driver: mediatek: add gpio pin to reset bt
Thread-Topic: [PATCH] Bluetooth: BT Driver: mediatek: add gpio pin to reset bt
Thread-Index: AQHbz57bWugt9NwLakO+LQJ1LtAxNrPn8uyAgCt0L4A=
Date: Wed, 25 Jun 2025 03:42:30 +0000
Message-ID: <451afb573ed6b218f2d8eeacdf1c3158c698c421.camel@mediatek.com>
References: <20250528070323.14902-1-ot_zhangchao.zhang@mediatek.com>
	 <5a430a69-6182-4a34-b5df-5fd557411b68@kernel.org>
In-Reply-To: <5a430a69-6182-4a34-b5df-5fd557411b68@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SEYPR03MB6482:EE_
x-ms-office365-filtering-correlation-id: c5b0a899-fa20-44f2-7ef6-08ddb39a5003
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SFNwTGw5cUtlWDRra2x5NytzTkVPOHB4bXNMeS9SRTNtRlNoNHhmMzB2MHZu?=
 =?utf-8?B?Rktyd3F0OTF3ZVlsWllRRmhHeVcvcHJncUZUN05CRXc3dzRtZzc2dEZGVEpG?=
 =?utf-8?B?VlpFRlI5dW1GMm9nUDRGaFFTbUlxQmhnaEd4MC9GTzN1RVZyYnNsZ3FQV0JN?=
 =?utf-8?B?VUdYZHR1OVJFYm1HYklTOWpiTWtDb21zUTFxRklvd3N5bkdMTXRIWmdtRmZa?=
 =?utf-8?B?NjUyd1NxTkJQeEI1S3NqUk9vVHVhVm15Mm4yNW1wRlFNSG9zZ1JZSjhoUWJP?=
 =?utf-8?B?SzlIN1Y3QWlVRGRTcDFWWSt5bENySFl3NGQyNjlpbWFEVENLRkdJcGQ1bGhz?=
 =?utf-8?B?QjBMWFRVTHYvMmZpNXVBdGUxR255Nzc3QUR2d1l1RHlYdGw2eUZ2WGdKTHNy?=
 =?utf-8?B?ZFU0eC92NWRrRXVyR1d1V3pBWkRIR2x0YXQzUmw4WUNoTkRuN1hGcGhMY0Rn?=
 =?utf-8?B?emhRV2hwd2VFalpjRzBkaHR1d042dlpDQUZaK2Ntc1UwOUpUT3JRdDd5Y3p2?=
 =?utf-8?B?dUlPbDcrVGFhQkc4U0hOLzZ5dlg3RjQ5Z0wzNUx6MVJSTktZang3WXNpekJn?=
 =?utf-8?B?dmNad2FWT201bXQ3VGhpaHMyak83YVFheGJmSmQvcGZtMlFhU2F3K1ZpTk5Q?=
 =?utf-8?B?bTVaak1NQ1k2Zy90aWkvUHVmVVdSdllxaUxyNXBhaGVOeHNJZVA5WjYzV0li?=
 =?utf-8?B?Yk1wenBScGlXYytBRllKL3dFVm5yZG1yNkl5SS8yd1NrdSszWGhMd1gyYjNm?=
 =?utf-8?B?dnNNd3plKzJRQ05kQitpVGpvcWRyZWo3bnVqV280UjZZWVNCdGw3ck1OVHBO?=
 =?utf-8?B?T3BPcnpMRUdjRVJDZXc0QVhnU2RteTM1Qi9HWnZJQW04RUY3ZXZyNFlQYTl6?=
 =?utf-8?B?elhRcnJjRHJLV0FWbWRxRy9kTTVDaHhydDZ3R3lOcjl2TnNrby9ubmpacVVz?=
 =?utf-8?B?bGp1eGdPTWltVGMwK1BGTExaZ2FqakVnT1Q4VVpDZjlkYXpFRDhmcE5ObGFx?=
 =?utf-8?B?K1RFM3JBY1BlTzdxMk5OeEFVOHNOV2IwT2FEQXZ6Y2crU0lLOGwydTRES2wv?=
 =?utf-8?B?a3psWXhkQXE5RERFcDhLaDVMeUNxd2ZUUGl5ZVdaT3RGb0ZnNE9MblpRVUNQ?=
 =?utf-8?B?dUZqVmZKcG80aFdQdG5MUzZFTmwrVG9iZlpqakZIc2Z4cmJISm1WeDEwamQz?=
 =?utf-8?B?OThIYWhhT01VVEtXd0lnbWtHcEhqVHdmaTVsamhyVU9sZC84THRZTU43ZzQ4?=
 =?utf-8?B?OVpjTExQakFvMzk0cXdIWFFjR3gvTUczanF0d3M3cUd1OUxMMkpSdW9Ncmg3?=
 =?utf-8?B?QVRrVzJjNFJ2azYwZi9xejEvLy9vVWQ1UlVnODhJZnBNV2NEWk9URm1qT0tI?=
 =?utf-8?B?KzB4RXJCS0x1K2h2U1NtRkVKU3FZMmFWNlVjUEtxK0tPZ2pqQ0lZSUNFcjc0?=
 =?utf-8?B?eHJHUnZsR2xteGxVblNjNGtkcVBjbmRMbDU0QjRFbUprbkQ4R0tJNmZldFA4?=
 =?utf-8?B?Q3djVk04b0NIUzdCdUJUUjNLN0wwQi8rRXhzcDErSE1la1JTcy9YL1dvaGl1?=
 =?utf-8?B?Rmg0M1RBNSthbjZhMG50MUdBQmtDR3B2K2xNWGFzSWZ3K2MrTlRYcnQ4L0Vz?=
 =?utf-8?B?MlhkMzdDYkFDTnY4Nldzb3lmakFsekM4VFlkeUExTjZGSVBCQThZYmNsY1li?=
 =?utf-8?B?b1FkcXB4bDNGd3VuS3pTL1lVSzdld1VudDFzS1l4SXlZR2lUTmpabVFNZmho?=
 =?utf-8?B?L3FVUUFYc3JXcUF0ekRRUEMyN1NPQ2Z5emxwQW9DRzRERGJlT2QvNkNYSDUy?=
 =?utf-8?B?bmwyYkQrZlFSdDJBTUJTbklNRFdBRmNYN1crQnVSeW90L0VyTTdTdDNZN2w3?=
 =?utf-8?B?V25jWDhUZWE1a0ZpWENPSnY3SHQ1NS9qUmZobmdGTnFKOFhUOWxoWlVHaG0r?=
 =?utf-8?B?ZytGVzhyUlRsNGpWc3I1d1FVcFJTc1l0THlOTTgzQUdRNWJnZ3RwMVUrRWJ5?=
 =?utf-8?Q?4aMfAIBCbIhaxHpgYx1TGGowNk7KYY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm9FM0pxZ0JrK2o0Rk9jcXB5WkwySXliWkQzWFVrWE1kZS8ycWU2dlVGN3dC?=
 =?utf-8?B?Q1hFQ2hMcWJIcDRUd2dBWDZxZnlSZlhpUVRQMVBwOG5VNUZUbE1GRnk2NUQv?=
 =?utf-8?B?dlJvRkRyOWQxenhxZ1dUV2thQlAxNi90aytFNEVsTmVVcmdyVTRXc2c5R2s2?=
 =?utf-8?B?QndPV1lpcUx2eVExUXVJQlRtbktBd2pqVDZjOXJyMmVPQko0dzIzaWovdDJL?=
 =?utf-8?B?OVdraW80citlZ3l4RUd0bWNudE5HaTF1OFAwaWUySlFoYlFlQ0doMzh1Ymta?=
 =?utf-8?B?RGlsanhUdmZKUDhwallDVkhHV1lZaXBtQlArVjd4dUdZeTZSYUQyc0pyVmo1?=
 =?utf-8?B?QzV0NEV0Q2ZkRHNQZkRPc28zZmJhb2ZtdWw2alEzaWt4M3I0MzQwWHFySVEr?=
 =?utf-8?B?QW1WcEg1dWhlRU9VSFovTUQ3MHZka0puUjIzbjh6ZGZQbXJLOUo5ejBTakNR?=
 =?utf-8?B?SWkyYlpidkV6ZTQ2Y1pLdUlXcFJKVnk1bytCY0I3Z3FZaktRYkdObjRqQ004?=
 =?utf-8?B?Q1lrSm42b3F6RCtqVjF5WVFIemdvZGJza3I3NWZXTDJDcjd5dS9jNW1nRmdq?=
 =?utf-8?B?OTAvQytDMlVIMmd4Tm1mQ3lHc0RKaFI2UitJY3NvZUQwSXF6bS9uMHBDTHU3?=
 =?utf-8?B?a2Z2WXFyV0k5WlJBRG42NTB2Qm9kbFFWOUp0ZlRVTG50NEEvYnlDeENQWHdS?=
 =?utf-8?B?cnFmT1BXT1ZsZDlxeEtZUHgyQmJuakpUMC95Y2diZzZPOEc4eW5EVWZPREg0?=
 =?utf-8?B?RDFqQ3VIV1REZG1NMmw4VytaT0labzNMV25mVXprRHVBQXAzWlY1ZnBlYkZH?=
 =?utf-8?B?K1R3ajNPeVdEcmtsZmx4UnpqNWhTT0ZhdkUxcjk2dFdick51dzJCZVBoVVVN?=
 =?utf-8?B?c21zMGh3eC9rOWZuRzFwaWtkTThYTEU4VjF4a09vc3VQRzZvNXpleU9jRmlx?=
 =?utf-8?B?TFI3RC93WTIrZjBjU25EWS8xbGI1c0pVNVRPSHBUM29VR2xxL2t5S0VIeGtR?=
 =?utf-8?B?ak43NnAwUks0N3FlZkdObTd1WWhIR3l1SWRJTXdVL1hQNmlrQm14UmMySU9t?=
 =?utf-8?B?SitubU9tVGgxYW02K0dhNWNuUHBwYnZVTkJ3c3FUMFk3MFNieXpWcGowZU56?=
 =?utf-8?B?Uy9pOHRjNG1Icy9HTW85UURSWVZrSXFpWE5PVlJQY1NGdWhPbisydzlpQlhH?=
 =?utf-8?B?cTIrQmZ4aDVQdHkyNUFtd3RDZlNuZFl1b0ZnRTdjQWYzaDMweUxmZmtiNDEv?=
 =?utf-8?B?Ym5FNVJzNHBBWFJWMDBIYmpWZmkrTFA1SWNEc0lXTUdwOWJpMzhGUmkwQk14?=
 =?utf-8?B?ZS9WRlk0VlIvNUFkVkRMMW90WjA3YjlpY1ArbysvbFJVN3R6UGVuSEg4ZXQx?=
 =?utf-8?B?MkR1ZXRwNUd4M1o2aEFFWE1GK1lnb2Y2cmlld09ObXB4N0RrM1pKckRnS0t2?=
 =?utf-8?B?blBBczZPcndrNlNKTXYraUZydksxUVMxaE9XdStRcExQM1JqL3EybCtRemRT?=
 =?utf-8?B?MVROQVY0dXpOYms3ZE9zMktOcDFwNEZ1WWU0dWQzNmFMaEFYSkt4d1l0aE9x?=
 =?utf-8?B?Z0JtQzZ4dHZTeERjdDIxV2tIMlNBUks3Mm4wQ0Z1ZHNyQU9naWVuaXZBbldM?=
 =?utf-8?B?L1E5S2ZoM0VJamM5T1hobTR6bE9tU1ZYelNzbzI5STNtZzlIYU5qZ0xIeVpE?=
 =?utf-8?B?YStnSjhNSmxZR3F6dkpjUWV5VzFTaUlFUy92RGd2ekk0RXdaS001ZUc3SUxi?=
 =?utf-8?B?L040UWV2UDlkVEhoY3FTM3pnSUhJQlZBQm1vc2paWDkvSDRKOTFZem9KZE9p?=
 =?utf-8?B?T1pIOTVldUdXQjlDN1Q2ZWNEUHVCL29SbERNOHpVSUxFdHYvZXRWSHlOc2x1?=
 =?utf-8?B?ckFIRlVCeCs2NXhUUlpEM3VXUjB3RnBtZXJIU0F4dklFdS9sLzFPZUZ4SWpE?=
 =?utf-8?B?Z05iMDlFMWhvcWtXWFNpUkJmT2xjellxSTBRY0Z4VXhnRXhnZ0lDUXZ6a2x0?=
 =?utf-8?B?ZCtDSklzc2N5bVc0QWdWalBWTjMwUUNJUlgwL2xyL1h6SlBSdC9NZGZpZW14?=
 =?utf-8?B?TzJLR09RTCtXVktHOU1RSUNqRXdleXozUURjK05ReU1YZVZvc0dnZHBtSThz?=
 =?utf-8?B?L3ZKby82Z2htOW0zQzVMR0hHUG1NeVdpaDA4dEdSOHhDMTM3TGEyOVNHTjZh?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A407231CC4E2974A8D9E1C49B8BC5E1C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b0a899-fa20-44f2-7ef6-08ddb39a5003
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 03:42:30.4885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENcthmILrzv5fnqVvO/hS+cQGxk4a2ZZlETThZ6S4mlLzjD7m+rwXfd+yA5AdlD4Pg0rlgJg/16nr4JuEQIinA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6482

SGkgS3J6eXN6dG9mLA0KDQpTb3JyeSBmb3IgbGF0ZSByZXBseS4gU29tZSBwcm9ibGVtIHdpdGgg
WmhhbmdjaGFvJ3MgZW52cmlvbm1lbnQgdGhhdCBoZQ0KY2FuJ3QgcmVwbHkgdGhlIG1haWwuIFNv
IEknbGwgcmVwbHkgb24gaGlzIGJlaGFsZi4NCg0KQmVmb3JlIHN1Ym1pdHRpbmcgdGhlIG5leHQg
dmVyc2lvbiwgd2UnZCBsaWtlIHRvIGRpc2N1c3MgYW5kIGNvbmZpcm0NCnRoZSBxdWVzdGlvbnMg
eW91IG1lbnRpb25lZCBpbiB2MSBhY2NvcmRpbmcgdG8gdGhlIHN1Z2dlc3Rpb24gZnJvbQ0KQmx1
ZXRvb3RoIE1haW50YWluZXIgTHVpei4NCg0KT24gV2VkLCAyMDI1LTA1LTI4IGF0IDE0OjA3ICsw
MjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQ
bGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91
IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUgY29udGVudC4NCj4gDQo+IA0KPiBPbiAy
OC8wNS8yMDI1IDA5OjAzLCBaaGFuZ2NoYW8gWmhhbmcgd3JvdGU6DQo+ID4gKw0KPiA+ICtzdGF0
aWMgaW50IGJ0bXRrX3Jlc2V0X2J5X2dwaW8oc3RydWN0IGhjaV9kZXYgKmhkZXYpDQo+ID4gK3sN
Cj4gPiArwqDCoMKgwqAgc3RydWN0IGJ0bXRrX2RhdGEgKmRhdGEgPSBoY2lfZ2V0X3ByaXYoaGRl
dik7DQo+ID4gK8KgwqDCoMKgIHN0cnVjdCBidG10a19yZXNldF9ncGlvICpyZXNldF9ncGlvX2Rh
dGE7DQo+ID4gK8KgwqDCoMKgIHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZTsNCj4gPiArwqDCoMKg
wqAgaW50IHJlc2V0X2dwaW9fbnVtYmVyOw0KPiA+ICsNCj4gPiArwqDCoMKgwqAgbm9kZSA9IG9m
X2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJtZWRpYXRlayx1c2ItDQo+ID4gYmx1
ZXRvb3RoIik7DQo+IA0KPiBUaGVyZSBpcyBubyBzdWNoIGNvbXBhdGlibGUuIEp1c3QgZ2l0IGdy
ZXAgZm9yIGl0Lg0KPiANCj4gPiArwqDCoMKgwqAgaWYgKG5vZGUpIHsNCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJlc2V0X2dwaW9fbnVtYmVyID0gb2ZfZ2V0X25hbWVkX2dwaW8obm9k
ZSwgInJlc2V0LQ0KPiA+IGdwaW9zIiwgMCk7DQo+IA0KPiBXaGVyZSBpcyB0aGUgQUJJIGRvY3Vt
ZW50ZWQ/IEFueXdheSwgeW91IHNob3VsZCBub3QgcGljayBHUElPcyBmcm9tDQo+IHJhbmRvbSBk
ZXZpY2VzLg0KPiANCkluIHYxLCB3ZSBoYXZlbid0IHByZXBhcmVkIHlhbWwgZmlsZSBhYm91dCBk
dHMgc2V0dGluZyB5ZXQuIERvZXMgeW91cg0KcXVlc3Rpb24gYWJvdmUgcmVmZXJyaW5nIHRvIHRo
ZSBzYW1lIHRoaW5nPw0KDQpaaGFuZ2NoYW8gd2lsbCBhZGQgaXQgaW4gdGhlIG5leHQgc3VibWlz
c2lvbiBhbmQgcnVuIGl0IHRocm91Z2gNCiJkdF9iaW5kaW5nX2NoZWNrIiBhY2NvcmRpbmcgdG8g
dGhlIEtlcm5lbCdzIGRvY3VtZW50Lg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0KDQpUaGFua3MgYSBsb3QsDQpDaHJpcyBMdQ0KDQo=
