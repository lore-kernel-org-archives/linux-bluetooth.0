Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EC13E0259;
	Wed, 17 Jun 2026 08:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686167; cv=fail; b=V99FbSbFpeWQRmN23O4PBGuVJ1zZfOQTcsUL5SqSf1NzZonag2igPn+mmJ+LPrMTaXU08b/mpYQCQv+qE3lOJvQcfz8tLW6MY8g8g802Gpuei0WLsS8tCV/KQzr5eJhMM6C3G0vfKXz0yz5LmwoQ4jLJun9kEikPI3GHeeefk7Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686167; c=relaxed/simple;
	bh=b7sPbS830kqi2vQUvgwjVDHYmwQ9UZUyT/z+D3YNWb8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wtf0NdwiBJSqMNt9hk1XO3N1HnHKstvsuVlURDTTPuGBcuRtAdu/6AwgsnMYs8wi684E9x4O+ZsOiwABNe9SfkZ6gQF+ISSTRFuD593XjfYR6CjyKHPQKPk/IALw0wFdMIk/a3PYa+T2H97Gr9A3YQ4E+/u8OxxCsrzKGPIuBwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=QKQj0XHL; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=W3+1ajBt; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QKQj0XHL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="W3+1ajBt"
X-UUID: 516dc7726a2711f18dc8c9802ae25ab1-20260617
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=b7sPbS830kqi2vQUvgwjVDHYmwQ9UZUyT/z+D3YNWb8=;
	b=QKQj0XHLOS/2hGCeJT0x9RLzA0KJtIjP3ciq7fABrrb40zr/fZQs6GAfUW7jzo7Gv5Xy6dlUMSGDiyExb1wFGDSLJudtKyuGIn5xoNNE8Oj8Hv8CubbE4Ep+O/5rq5uJ/r3wsd+vWqKFrHZZ/X+vTmcybusBu2igqMvxuNRIJq8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.17,REQID:bcb448c0-5181-4d1e-8f3c-5a0a00105824,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:d497b38,CLOUDID:42d63935-6d54-4d6c-8cfd-ce0066c5f3da,B
	ulkID:nil,BulkQuantity:0,SF:80|81|82|83|102|110|111|136|836|865|888|898,TC
	:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:
	-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 516dc7726a2711f18dc8c9802ae25ab1-20260617
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 760200674; Wed, 17 Jun 2026 16:34:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 17 Jun 2026 16:34:11 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 17 Jun 2026 16:34:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+01Au0BTm4Ufjfd5p4zofc9hTyi72nu8gkPstaqapC8Uhd2QE5o9iYzB7X6ZTeM1kMA9cKM8oFBIevDIlc+wFox0L3qSYz6WLhYVnLAG4jvfptmSMxaX9BBlo38E8TjdTrJDHX0suwgJmjDpUNdS0ycISnGzp4o/MzIiUjcTlJ6gZrnheJs0KKwmvSqFOKrDo3MeU6ANim1TTrnJOc4Zm1Kb9usDtxZeYYTueT5x369w59qGrYKOn+AZfEvR54rIyULabYgrdg+XbTFyacupUkPS6iCURk/HNS9+tvcVYhJIiBWnEianHPe9Zg0NpLE3DRByfkmGoWLS8ax8/WeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b7sPbS830kqi2vQUvgwjVDHYmwQ9UZUyT/z+D3YNWb8=;
 b=hh+s5U+g/LaLBOwvBhMSHiQ1XkTR2jfl7ApbkZxxkG1C+iCzU3v6B9JIsfvd1eyZy4j6LttJDRXi3fai0+MCI1l25U368Cpexme3q4WPHt62a3yobGc1rPuHo8NAypgm/fRCc2x5LUCzNvjKofkKUVOrn6rqi4o71afyEogAEcmjXC43ywUQr8qih0OqdzRjQK0RLaVwL3w+1b8B00G99wRtU1hvV4sJ2fa/2Zc80wQEkMqs4llJ5cHyRO4E2fPkSQoc223wpUFikkn8g1DRfx/cBXrr1ZD2bjKyx70ggZ0HNfIjTVLGKGTFpEGYrQ0cPZbkd/0FMfeB5SsXUCWt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b7sPbS830kqi2vQUvgwjVDHYmwQ9UZUyT/z+D3YNWb8=;
 b=W3+1ajBtZ6ft+X+0rDgso+QjD+/OftF5xdPGphfeuImepjWFOSPS2a8AtmlmBo/wYDCKsnnY9Tz/CIVC1N4E0mkiPIkTPSprEJbDArJN7+P4pXBwiooqHz+S11KLBouINqUWQ1u5xYDGOXMKn19/c9+GpifbKxOR4tAFq+AcUlw=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by TYZPR03MB7439.apcprd03.prod.outlook.com (2603:1096:400:41b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:34:08 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::fd68:2f22:b501:b771%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:34:08 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>
CC: =?utf-8?B?V2lsbC1DWSBMZWUgKOadjuaUv+epjik=?= <Will-CY.Lee@mediatek.com>,
	=?utf-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>, =?utf-8?B?U1MgV3UgKOW3q+aGsuasoyk=?=
	<ss.wu@mediatek.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "johan.hedberg@gmail.com"
	<johan.hedberg@gmail.com>, Sean Wang <Sean.Wang@mediatek.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v1] Bluetooth: btmtk: Add MT7928 support
Thread-Topic: [PATCH v1] Bluetooth: btmtk: Add MT7928 support
Thread-Index: AQHc/Tx3X72d2Ab250uFpDKW8WMJILZA+jwAgAFXog2AABvJAA==
Date: Wed, 17 Jun 2026 08:34:08 +0000
Message-ID: <c983c544a39606e1468158a7b6fdc77b6ca5c8a2.camel@mediatek.com>
References: <20260616030132.532184-1-chris.lu@mediatek.com>
	 <6b29b553-d703-448d-9275-62912a62e356@molgen.mpg.de>
	 <03e0a6787272a445448a3189b4b575aa85396fb0.camel@mediatek.com>
	 <4501985d-c8df-4121-89fd-0b4eb09273c6@molgen.mpg.de>
In-Reply-To: <4501985d-c8df-4121-89fd-0b4eb09273c6@molgen.mpg.de>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|TYZPR03MB7439:EE_
x-ms-office365-filtering-correlation-id: 5209f020-a2b3-4645-17aa-08decc4b334d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: dNxb61FbGwRuZoGsus/8cffqqn7aKuBTBT+vLI7XIO5P3ZV1HfDFbGCkQeqFo+wuS52hbrkIkY3HgIIdAHrpKOUEJOT4Ur8qRi/Xrxps3Rwo4wxdj+kH7pbXbirACGYUZb5E1hB+Nx35dp5zV1/p5O1pQCLHnzAaeqfPNWGu67BJMljILSrZeL1gRLIMPDs9UQNTnfjzTAz1RWYsvxnYK9FGcjBUxxqcOZwYzQhowVJrCbNuxkNg8jsyf14I8fArkoX8gL4aRWGafOHhu9EJZm1mn/zkg042cGN0rrAZXKauKOy7GftT0UHVNXHeP4HMLIzoTM/h/fPTZeVKp5BEXAbj+pYa7+SHNziILGY3hzhL4t9HUQm2EAdc9q3VdM2BalmLm4i5vvscA+KUb0Up3Wley3nYnUH/n1bFOoE3RLkZWC5Gxz3C7cMSQCV43cJRLsJAyjINJxHgWK0VrVd6pGVISlxwfquzhCE85QEqVmOZnNad4s5PsSNwAnabpOm0yyz5TBtwblXt1t19ZzudmWnMnP5qwoKYqnx/bhvYZlkDKSG10ZGjJ1LkUhocy1juEK4SN1gYpqAMGH62Jt1xTPweHYdmrEzSh3pi1Wopsi5XITMvYqcb2bhcM6iRJ0rAedC3gglLv+duYLYstjFQVtv0FCzBycT+eB/Mjquxj1zkzfcpsthdJPZSTacjP/iq1UDpO+LC793bp7zBY9nNM+Jt72z0LTaqz9DLjhSYYMio03M0PgDcOCenOfNByyPU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm1lTjI5QUkwS2ZHMnRrTUw1V3BtU1pTSmY0NCtmK3Q1UXlFRmFYS1hyOEJO?=
 =?utf-8?B?NGdvZlBvZ25oMG1LN3hxQi9DcVVuM3JkemFRZytJQTVmd2I3anRKL1ZIV2ZI?=
 =?utf-8?B?cXZKb2ovclR1MXBYZmJWeFFEdHV3ZHBDZG1jYnYrSVRibW1vUitIc2ZqcTdX?=
 =?utf-8?B?dG51aUVQY0lSUWVUWUM2M0VScEkvNkRTYjJZSXdyOUpoclo3cGJLZzhndzdD?=
 =?utf-8?B?QW0wU3oya0RYT2p4VUtybDFIbmZmbWpRaWg3R3dFOUQxYmVSKzBob1dKcUU2?=
 =?utf-8?B?am5TQ29tTjJJQkJ0UjNiNkxvNTBHNTA1bWZBVVdlTHJubkpQazZpOVhwRTlR?=
 =?utf-8?B?dUVOejlwY0MyMytjdzE3SktMS1RVQVNyM1EvcWxJNWxSMkMrZTR1YjdWcm80?=
 =?utf-8?B?bDRTN3pPcmlBYnBCejd5SUJ3dXJGN1Z3NnN6bndrQktmNm1vWE54NU5uMG5w?=
 =?utf-8?B?THNpcHlMakNMYnVzNmhQQ2xKUXpxcVRaNThncEdvNTcwdFJRTXl1SjU4K0M0?=
 =?utf-8?B?cWE0dEhBbmNBNGxOd2M0VTJ3cm5jcEg4TUNsNmYyRkZjVUFzcnJoN0JocUlp?=
 =?utf-8?B?OG9SbVJQMFl5SjgxdUFWdS9sNmltWDdaVnBVT0c3cU5URlJrRmFIOHl6S3Qv?=
 =?utf-8?B?NEpNV3ZGNFgxRTh6L21SSEFBTENadERmNVRFREkwOHhscUhyZHVOcUdDcmZT?=
 =?utf-8?B?cUJhbVJhV2M4eFhyQzI0Vm5zSWJ4VFMxdEJ3Z1BrVGFwNngyWkdiM3dpcVht?=
 =?utf-8?B?cnBmeVRnQzVCRXpMZHJ4RWVINGtlTEY2SytBWmg2U1JGeVhIS21XWEtoTEgw?=
 =?utf-8?B?bkFQUGptbHVjRzRSUjJWamF2TGZmL1JUbStxR2I0SE5HL3NxSWlTYU15c09T?=
 =?utf-8?B?WFo1VmVKVUc1NmVrN0tMMUx1amFQUVpmTDgzZzVTM0JFdU1wbzZWcTlFZWlZ?=
 =?utf-8?B?SE9USkhUY0pGbHJDTGV6MHRyMUl1ckd5QTdvbUdZMGI4TndMT0JFZElVQkRY?=
 =?utf-8?B?UmFHcDliU3cydDVMQTNuR0xCVVVEVXp5dmJ3djZneE85dnVmRUp4MGRweXhL?=
 =?utf-8?B?b0hSN0RnelN2dVFnUEVoWmJPTzBkeE8wQjZqVW8yWEh3aVNHdzFPTnZMVXJM?=
 =?utf-8?B?Z1pJY0JuWVR5NVdrdjc5WEMrMEliV21SSlZtZEd6RGJaeWxHVEFtUnNzemZP?=
 =?utf-8?B?Zm5hTENrZWcyZHU5cnNYUEx4SWZtc0JBeGhTTHBCNjQ5L09KcVRmbUNLbUJz?=
 =?utf-8?B?ZlFMQ2J3Nnh0bHlJSFNwcERBZmpSWDczOWFNQ1JRdWhRRW5Kc3VQY0w3ak44?=
 =?utf-8?B?ZmJLNFBuSTEySEJaZkJJWmlMOWJtRUwwbVFpc2YyZ3JtTldwWEF1aEk4MFI0?=
 =?utf-8?B?elhBNHl3d1pQSkhLd2J5RWExWXpUcDdTbmN0NURaVTlQdzg5c2hGdk9jdndv?=
 =?utf-8?B?NkxIWk1mcG1MWTU0em42NlhmUnp3RGxuN2NtWWtoc21QdGJkaUk1VCtMaU9j?=
 =?utf-8?B?aEt3Y3NEbEs0K3JwYmJaNVNqcFk2M21Wcm1QN2dBOE5JazkyenhWdFdVT1J3?=
 =?utf-8?B?L1lZdzJLWDJwdGJpejRrR1Z4cjJBU2IwUVFjT3dHWG0wSUhqSlgweGltTnVl?=
 =?utf-8?B?V2IzMmY1VTlITmZ1M213Zmhpd2NOeTJRTXc4QnZQZUJNb1NmcmpTM2VzT1pm?=
 =?utf-8?B?dEIwYng4UG04cEttRzFLaWVBWWpPZWMzdjZaVU91SUJxMVJSNi8yK3d1Znpu?=
 =?utf-8?B?cHVsT0w2SEpuNFpad3R4dWxCYkpzd0IxekF2aFY3SFU1bGdVOE5WSE1mVFJw?=
 =?utf-8?B?a1dJT0t1ZjdlWUFZOUhkM2EweHU1bnFmQUVmNk04cm1MeTkvNlZkNWNhNTc5?=
 =?utf-8?B?eWRqQlMzdVZiUnhRRzA5NVlGdSszeEVXVGgrR1NKMzdVbCtwU0U1Z0hyNkxl?=
 =?utf-8?B?Z0d2cGxVS3J1WjUzWVRNeDdyMER3ZmdNMmtJbktVcU5XUGlxYmh1RUNYRmxS?=
 =?utf-8?B?MEpNTUJjYnJCMzJLOW1VVTVHck91VEdoak0zdWI4Z2hHQW9WTUtSNlBaSER3?=
 =?utf-8?B?Wlp0MEtZTlMyd2Erd1Z3S0p0OXF5aXpsT0t3eVcvYzNOS1JEUExEL1BHV0hT?=
 =?utf-8?B?c05KL1orVDNjQUJzamVMMnRWZEFKd0M1dzE5cVUzZ3ZXV1ZtU1EweENFS1dE?=
 =?utf-8?B?NWNiUkJ4TElmd0tKeGZIM052YmdhelNGOHE4RWZBd1NMRXh0bHhwdUg3NCtv?=
 =?utf-8?B?M2RiWGUvZEdNcU8zTHJuSzlaNndXV0JESWRsTiszWUt2NGdpQldMVzA0dWZs?=
 =?utf-8?B?NTNlRHhRT0tSKzNkY3NtRWVQMFkvTkxhaGwyVEJYRyswQ3I4U0ZuQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EE6347F8B26C747ADAEDA4DE7BE6340@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LAVhO9lCTv/B/RxHx29sYXYVsBgSjgfrODQzcjZdyDP+fyif/hKQCRW0a5gS6kPk8fR2fNqunyvGx3uwKSTh9A+6PsowiZFgET06/QAoihuCThOgSn7dSoCGrdIhiy8tA2MsvshstA6TxwHOqRsLhSxqhh8IDV6G8C7LrXb3X0xrKILpuk/Z5oBsOEqJxmDPPD4xF2plvW+fMKbPHlJWEr5YeDXwIsStHcdHsLqVE+dMUxwPZyOIqr709oaXWGcGz8NRrdPushMLK4JJti9OmsFVTgzt5P6cSYTXAv2IuHBeXWfRjYOV2dRKWpo41nGOx17UAYijy+i3M5PIW8wmtA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5209f020-a2b3-4645-17aa-08decc4b334d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 08:34:08.7444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: al/5A8fi66xcb+N+vQ5W6tFOKxdDonzyLj9jIgHJQHtD7UO2hUfr17MNektiqQVWeblJXNO4MAxfIZ0KEh+6mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7439

SGkgUGF1bCwNCg0KT24gV2VkLCAyMDI2LTA2LTE3IGF0IDA4OjUzICswMjAwLCBQYXVsIE1lbnpl
bCB3cm90ZToNCj4gDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5k
ZXIgb3IgdGhlIGNvbnRlbnQuDQo+IA0KPiANCj4gRGVhciBDaHJpcywNCj4gDQo+IA0KPiBUaGFu
ayB5b3UgZm9yIHlvdXIgYW5zd2VyLCBhbmQgc2VuZGluZyBpbiB2Mi4NCj4gDQo+IEFtIDE3LjA2
LjI2IHVtIDA0OjE2IHNjaHJpZWIgQ2hyaXMgTHUgKOmZuOeomuazkyk6DQo+IA0KPiA+IE9uIFR1
ZSwgMjAyNi0wNi0xNiBhdCAxMjoyNCArMDIwMCwgUGF1bCBNZW56ZWwgd3JvdGU6DQo+IA0KPiA+
ID4gQW0gMTYuMDYuMjYgdW0gMDU6MDEgc2NocmllYiBDaHJpcyBMdToNCj4gPiA+ID4gQWRkIHN1
cHBvcnQgZm9yIE1UNzkyOCAoZGV2aWNlIElEIDB4NzkzNSkgd2hpY2ggcmVxdWlyZXMNCj4gPiA+
ID4gYWRkaXRpb25hbA0KPiA+ID4gPiBmaXJtd2FyZSAoQ0JNQ1UgZmlybXdhcmUpIGxvYWRpbmcg
YmVmb3JlIEJsdWV0b290aCBmaXJtd2FyZS4NCj4gPiA+IA0KPiA+ID4gUGxlYXNlIGRldGFpbCB3
aGF0IENCTUNVIGZpcm13YXJlIGlzLg0KPiA+IA0KPiA+IENCTUNVIGlzIGEgbmV3IGNvbXBvbmVu
dCBvbiBNVDc5MjggdG8gaGFuZGxlIGNvbW1vbiBwYXJ0IHNoYXJlZA0KPiA+IGFjcm9zcw0KPiA+
IHRoZSBjb21ibyBjaGlwIChXaS1GaS9CbHVldG9vdGgncyBzdWJzeXN0ZW0pLCBwcm92aWRpbmcg
YSBiZXR0ZXINCj4gPiB1c2VyDQo+ID4gZXhwZXJpZW5jZSB0aHJvdWdoIGltcHJvdmVkIGNvb3Jk
aW5hdGlvbiBiZXR3ZWVuIHN1YnN5c3RlbXMuDQo+IA0KPiBUaGFuayB5b3UsIGJ1dCBwbGVhc2Ug
YWRkIGl0IHRvIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQo+ID4gPiA+IEltcGxlbWVudCB0d28t
cGhhc2UgQ0JNQ1UgZmlybXdhcmUgZG93bmxvYWQ6IFBoYXNlIDEgbG9hZHMNCj4gPiA+ID4gc2Vj
dGlvbiB3aXRoIHR5cGUgMHg1IGNvbnRhaW5pbmcgZ2xvYmFsIGRlc2NyaXB0b3IsDQo+ID4gPiA+
IHNlY3Rpb24gbWFwcyBhbmQgc2lnbmF0dXJlIGRhdGE7IFBoYXNlIDIgbG9hZHMgcmVtYWluaW5n
DQo+ID4gPiA+IGZpcm13YXJlIHNlY3Rpb25zLiBBZGQgcmV0cnkgbWVjaGFuaXNtIGZvciBjb25j
dXJyZW50IGRvd25sb2FkDQo+ID4gPiA+IHByb3RlY3Rpb24uDQo+ID4gPiANCj4gPiA+IFdoYXQg
aXMgdHlwZSAweDU/IEhvdyBiaWcgaXMgdGhlIGZpcm13YXJlLCBhbmQgaG93IGxvbmcgZG9lcyBp
dA0KPiA+ID4gdGFrZT8NCj4gPiA+IA0KPiA+ID4gPiBBZnRlciBDQk1DVSBmaXJtd2FyZSBsb2Fk
cyBzdWNjZXNzZnVsbHksIHRoZSBkcml2ZXIgY29udGludWVzDQo+ID4gPiA+IHRvIGxvYWQgY29y
cmVzcG9uZGluZyBCVCBmaXJtd2FyZSBiYXNlZCBvbiBkZXZpY2UgSUQgdGhyb3VnaA0KPiA+ID4g
PiBmYWxsdGhyb3VnaCB0byBjYXNlIDB4NzkyMi8weDc5MjUuDQo+ID4gPiANCj4gPiA+IFBsZWFz
ZSBhZGQgdGhlIG5ldyBsb2cgbWVzc2FnZSB0byB0aGUgY29tbWl0IG1lc3NhZ2UuDQo+IA0KPiBU
aGFuayB5b3UgZm9yIGFkZGluZyB0aG9zZS4gUGxlYXNlIGFsc28gbWVudGlvbiwgd2hlcmUgdG8g
ZmluZCB0aGUNCj4gbmV3DQo+IGZpcm13YXJlLg0KPiANCj4gW+KApl0NCg0KU2luY2UgTVQ3OTI4
IGhhc24ndCBiZWVuIGRlcGxveWVkIGluIGFueSBjb21tZXJjaWFsbHkgYXZhaWxhYmxlDQpwcm9k
dWN0cyB5ZXQsIE1lZGlhVGVrIGN1cnJlbnRseSBwbGFucyB0byBzZW5kIGRyaXZlciBwYXRjaCBm
aXJzdCBhbmQNCnVwbG9hZCBmaXJtd2FyZSBwYXJ0IGFmdGVyIGRvbmUgYSBzZXJpZXMgb2YgaW50
ZXJuYWwgdGVzdCB0byBtYWtlIHN1cmUNCnRoZSBxdWFsaXR5Lg0KDQo+IA0KPiANCj4gS2luZCBy
ZWdhcmRzLA0KPiANCj4gUGF1bA0KPiANCj4gDQo+IFBTOiBBbHNvLCBQYXVsaeKAmXMgcXVlc3Rp
b24gc2hvdWxkIGJlIGFuc3dlcmVkIGluIHRoZSBjb21taXQgbWVzc2FnZQ0KPiAoaW50ZXJuYWwv
ZXh0ZXJuYWwgbmFtZSkuIChJZiBxdWVzdGlvbnMgc2hvdyB1cCBkdXJpbmcgcmV2aWV3LCBpdOKA
mXMgYQ0KPiBnb29kIGluZGljYXRvciB0byBhbWVuZCB0aGUgY29tbWl0IG1lc3NhZ2UgYW5zd2Vy
aW5nIHRoZXNlDQo+IHF1ZXN0aW9ucy4pDQoNCg0KQ2hyaXMgTHUNCg0K
