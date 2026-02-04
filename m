Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB46D3ED11B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Feb 2026 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206425; cv=fail; b=pG3AIfgVExmpERLg4N6eVPRZjBi9eIQJk5nRYIz0yNoqohjUcsSOmzPoXccRFW21q/B5YvTHv0OvTu3Nl8cfDQc4+m5uhxUpoT6IKnf4qX/YBs45x90u+TDlZ5RNEELLQXEKbbxxpYZc6rY7lkFJkPqXPQV47k+MVRkZa7+MPLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206425; c=relaxed/simple;
	bh=ezCAsRcVeCnEP27Ez97tXocCtDXA7O0DVoN6csADEzc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=odq1FwvfDF610bNZx/+qqGTSOMLiYUG3/g3IjzpzMaHiz1hB9wdFh48qA+NKauvHovMhG+nbxpk5+lhirJW9vpjDsVyaKddcyUisF5eBjVX4ouej/gTexzBZK9XVTfvFuh+zANMIfg+L+QmHUnyIL5chXAWHuIf0f+wy0+ngmeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=S8jnwgw0; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=As91OGn7; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="S8jnwgw0";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="As91OGn7"
X-UUID: 133f3dba01c111f1b7fc4fdb8733b2bc-20260204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ezCAsRcVeCnEP27Ez97tXocCtDXA7O0DVoN6csADEzc=;
	b=S8jnwgw07p4E/3hA6DaoU0tl2Vp7icS7ucsGlurZ+PiVsyg06GF8oj/DMJypndX8AW92DLThHmZMPp8xty9fw7mgQseHEkMK7ksIsA5pcyVxtI3V0re1FnF/LxdEXSbRr88fZE2ZbMZtCc8368xAwl/6imLTOdfkVJvmrertqzI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11,REQID:9f9d1dad-75d2-4476-ac07-cf7ccea2ba39,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:89c9d04,CLOUDID:0d3fec5a-a957-4259-bcca-d3af718d7034,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
	C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 133f3dba01c111f1b7fc4fdb8733b2bc-20260204
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <chris.lu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 237994139; Wed, 04 Feb 2026 20:00:18 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 4 Feb 2026 20:00:17 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 4 Feb 2026 20:00:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OobHQ0Vnjst822pFPUGePqDbeIB8gxxQhBBr5lsg9/9AcU5ATCMrNAEq336E/doMw60LZN7vFNjO8JWpb/2prc4T6Br7YXzMdDPD67+yRtAK0JaVkHnaPnR6tjk+AtlPs974sCz54oprAOqVWm0ZG8VxSgxqjegRfRvqQus3Vb2HichNr+KAKw878WnJ/DyUYrWjYtzxwUp6zJZhofZV8J83jMVY/s+6W1CjFliz93NTzMl0Pmuy7sEeF1OTal5qZ+iF9faXNsJT3heBWk0csS2VKAofmfK/jWgguRl/4361tEtQFOBCjaIwwbz2qz35BCjwnZKfUxhVpAOSG32SOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezCAsRcVeCnEP27Ez97tXocCtDXA7O0DVoN6csADEzc=;
 b=Mv7sGjp24Sgy/6AWiBGEAM1Npk/JkFrCjjIpQDoXMcmmZYggHuvejeKF8rHZERT49HPNxTNjdqWXZjiwG70mfLuGFqIIVv+wQONzJLYqeM/YZlCSRIY1n+QqnokATxlFY8GD5hQ/knccOSgIpwkHz31X6EZzbXx/W5B9lgE+lk8pijPMm/j1fVr61ZLOJpimsNO2UxjSb13HsY8h46q0oJtAYV8cmIZjEBGNLwjLnH5QCXFQGqPZqffyvoAwTWL9RN0qTR8/P7a8Ek7/FztdaexysQrFs2p9heS0BLkJq6zIMdFDtRiLiWvsSUuqMyXgeMZeqGaHk2oN1GIrjIB93Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezCAsRcVeCnEP27Ez97tXocCtDXA7O0DVoN6csADEzc=;
 b=As91OGn7kHsG7BQQ5w2rGLhnE7P68VKlXtc5Tl5obVJHjHihLS25WdhSCGCk0VEI0XSoDr3DuFtY0Rv/sTPuWlbcF2bsORUiv0k2qLeFc0ztJVCM9qxCNdnwHXmPYAzegfmCWbLPFHN/ilXeRZgb/8q8nWG5+DSBPkAJWFsicmc=
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com (2603:1096:400:72::8)
 by SEYPR03MB7564.apcprd03.prod.outlook.com (2603:1096:101:146::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 12:00:15 +0000
Received: from TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf]) by TYZPR03MB5741.apcprd03.prod.outlook.com
 ([fe80::110c:1c24:758d:5daf%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 12:00:03 +0000
From: =?utf-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
To: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"khalee27@students.rowan.edu" <khalee27@students.rowan.edu>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: Bluetooth not booting with MediaTek MT792
Thread-Topic: Bluetooth not booting with MediaTek MT792
Thread-Index: AQHclTZLgySIX+TYNkuopFiuR/M1FrVycOyA
Date: Wed, 4 Feb 2026 12:00:03 +0000
Message-ID: <c224f5707c4362318f2076307fe283d6801890f9.camel@mediatek.com>
References: <CALpOmYvQUnA6YGinVxfDzqewP1dcL_-X7NVfto4YsMtZL3x2og@mail.gmail.com>
	 <CABBYNZJGUcO3AjVf-APKtmmvUHnq88SmNMmYCrhBXZEVpPDNog@mail.gmail.com>
In-Reply-To: <CABBYNZJGUcO3AjVf-APKtmmvUHnq88SmNMmYCrhBXZEVpPDNog@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5741:EE_|SEYPR03MB7564:EE_
x-ms-office365-filtering-correlation-id: ff6b34e6-1152-494e-902e-08de63e4ee3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OHNVU1VZL3J1RGFRTW9uZ3lRQ0hsY1luYmpaRVI5Ui9rOXlnZlVOamFNc3ly?=
 =?utf-8?B?c1FrOVJTNVkwMkZlU3NYWVlXTFFNeHF5QXRFamRNTjd0dDh1T2lwS2NvVTcx?=
 =?utf-8?B?NWtoUEUzc2prTWJEUE5DbEpYeEhXQzNiMUM5UVVFYkJGSVdCSnljeWJtMlZU?=
 =?utf-8?B?S05SMjFQeTZzeEtnZ3Nld0ZqOTR2cFlqVkdJcVk0UGN5WUVER0hUMmNQOGhS?=
 =?utf-8?B?ZEFoUk51ZGRRdzdWY3MwTUZGTmFVMHk4cTZERHFvajRKUzM4KzNFdXVQNTBq?=
 =?utf-8?B?clU4MURya1dyWUdjbE8zWUh0QkcxSzhRY09qNEprcHU3dzVHbEJnZkZRd1Vw?=
 =?utf-8?B?T2c0K3EvUStsbW1FVTI3V0dLZS9tU0hXMHZWbUJhL210bTlFclk1S1c0Zmdi?=
 =?utf-8?B?Y0pBSlZScDQ0Um9saFExVDQvV3JEcDgveGN6Y1d6bUZvT2xRWUZqRVFaWmdK?=
 =?utf-8?B?V2hIVzdnMzJYdkgxQ3FwWGFmcStwR3JNclZKejBmeVcxZGloUkpXeEtZTVlS?=
 =?utf-8?B?eEh4VU5RVllxNklmMkZnTlo2ZzROZ1NaRm4vQ0dMaDdFRzdNR1N5UlZFRXBJ?=
 =?utf-8?B?T3lkZzFNY3phdll0SUdWdWFlNXBxTWZnTTBzNDlvMnl4R0F1a25KTzlmOFVX?=
 =?utf-8?B?NHlxbGdSZ3lLMVNRbzkySzFncWVxWFdDWG1HV0RqVlB0VGdxZ1pWQU14QTUz?=
 =?utf-8?B?bEZWa2ZZR1VyR3RwSTA0cGhOQkhhUGlaOEtyZTc4MnAwY3grUnJGWW5nRDRP?=
 =?utf-8?B?NC9zbzJUb0FQd0EzS2NQYkdrWjlSaVZFZFRFL0ZWWEdTb2gxNDl4a1l4d3Fv?=
 =?utf-8?B?WmtKOWFZYklNRDFhRXZsV3Btc2d1akt1SjJnK2syNlV2aGpUTERXVGh2cEMr?=
 =?utf-8?B?T3lzdVk5eVhEcHNrejNyaHVjNXpSTnlEQnJDUmtaL1ZzZkUzWjRYRDJZUWhY?=
 =?utf-8?B?a29ZSWdMQmo1TlhMT0RDSTc1VjYwTkhTOFdhTlVINFJOcjhZUWQ4ODJsOHlw?=
 =?utf-8?B?SUZBclVVOUROeG8yOWtmY0dMd0hzTm1iamYrWjY4WFp3aXJRQzVZWWd3aGRM?=
 =?utf-8?B?Mkp2bWlxalVQaWxoUXFtY1U1K3lYTTd3aHd3bkM1L1Iyd3lwckhkQlBVZ0dQ?=
 =?utf-8?B?dnJvSnZRV240YmNSZHVlbXZZYTVoRC9QMXR2a2hPM0lZaXF2SVRjdkZ4TDhD?=
 =?utf-8?B?dTVtdldMN0RuQXVJQmJDMWMxL3c0WVJhM3FkVnFFdHgvZjF4VWxFSXk1dGM4?=
 =?utf-8?B?TldpSnpoQ0R2YnphdU40eGJUVjExYjMwQWdIOTdSUHpuMnJwSlo1THpQUnhl?=
 =?utf-8?B?Ymh4enlrclBsU3ZEMnNPdXNYZUsxQTZjSlFMQnI4amc1TGE3V1JYSWo1WFo4?=
 =?utf-8?B?aitFT1ZpK2tjNHNEVGJIanI1WHZDU2t3ZlZ5K1JzNVB5MGdQT0FyN3FMaVZm?=
 =?utf-8?B?T1ZjRFhGSG5uS3U5UEVQQ2RZNkdnY2JucXhqQ09pMVcvYkVrM2MxOFJyVW9r?=
 =?utf-8?B?UnA5d1oxYm9lYWdkOWx1STA3ZCt3ekZDQ0RPSEVHUk9xUzdOVHhpejFHKzN2?=
 =?utf-8?B?WEpCZmtHZFRiYmFiTGs0MUU2QTNRcWJHKy9TUFpRMHNJWVRUa1Y5ZFZpOWV2?=
 =?utf-8?B?NlRMRjhhTWxmK1p2VndvRTM5SDJpVWsyTGx6NTMwV2RZZWI2bFRoaWt1djJV?=
 =?utf-8?B?NjE4c1RjSnhPN3ZSa21FcXgxNE1qV3JLRFREb21jV2pIQmtMTWtncjlxblZ5?=
 =?utf-8?B?MWRKRkN1dDcyOEpTaGJLNk1PUU53R2FORnN5bjZtNDlEN2Mvd21aZ3QvN1pr?=
 =?utf-8?B?VjkzY1FVK1NxVlk4R2FHLzRaVWtrekdwVFlhTm9iT0FuYmFXT0JieERnUVM2?=
 =?utf-8?B?cHNoR1QwTnN5ZldvaGc1cVgxS3czZ0xDbklsWUZyQ3dwK2loUERqc1NhOGxa?=
 =?utf-8?B?dTNTRkZzUFFWeTFja1dtWkhyNWVhaDhRR2IwYmFiSmtkMVFXZ2dvUVpyTE12?=
 =?utf-8?B?WlQ0OE05OHJoVWp2cnVBYVM5QzJ5dWhiVzRUeVZtTll3V1dPbDNGVXQzL1BT?=
 =?utf-8?B?NUh5dCt1WXJxTmNHeWJTTENiQ1pXUWc2dG9MZ0Z2WCtjemU5Z3NRMk5uV2JT?=
 =?utf-8?B?VXpmM3ZjVXF2MVRyTjhqL0xnazdYdHVnbUx6RjRPUTJXWmExWG1rei8wSUt0?=
 =?utf-8?Q?HkB1n5HEpzIhukH/c2nKEEc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5741.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnBrdWFWSTN4TDZseHMyTmRxZHF3Y2NoVm5YMVRuemJLV0NWWE9HaHF5L2dL?=
 =?utf-8?B?aXNLdEc3NjNqRXJMMkltR29jTk1uRjF6RXYxUnJvZU96UGxUNTZ3dkNQcUdE?=
 =?utf-8?B?Y0F5djJaUWdoZkFNWFFCQ2RpMkhaWFRWTUdZN205SDNRTG5hR3YwUFA5WjFM?=
 =?utf-8?B?eVpTaGpyWkRYOGpwV0ZYbEF0SkZTVURsM3gxbjArODhIRW9nSkhRcGZwa2s4?=
 =?utf-8?B?QkN0THZJV1lsSjMxYlRjSmttMVI0L0xKcDB4NjR0OUdRbjBBODRYM2FWQWQ2?=
 =?utf-8?B?ZVJjYThpRnMwc0VmaGw3L3JnVUxEeHVxaXNTb3hreWJkOVV2Z3hubVlNUDNx?=
 =?utf-8?B?RUpKZTJMWTFIYVdnL3FwRU85Rm9tdVc2ZFRmTFl4M1pqWk1tYUlLT3dlcndZ?=
 =?utf-8?B?dFR1MkJCeExiWnpCT2JyeHhtdGtRelNLcVZBRHlUQ3E5dDdOTE0wbUx0VHUx?=
 =?utf-8?B?YzlNcGhtalpqVGV6Z3hoRzQzMzR2WUtHNW0rK0dia3l6aThsMVMwZW1URUVo?=
 =?utf-8?B?ZElHdk9kYlJkMHNLVVNRZWRQUmNqaXBoNjBzeDdRMUlDU2tob1N5U1VLUFJT?=
 =?utf-8?B?eHpUM2xNaG4yZzRqcHlNR2NReHpEbEF2WnJ0eGhUR0hBeGJlYUxxK1hSTU1V?=
 =?utf-8?B?QWVUNmROZnB0b0ZpMmNIR0plUnp2NG9wd3dCUC9uS0tFMm5IQ1hnOCtSZjBS?=
 =?utf-8?B?ZzZzNkp1K0NoZlBWVWxhY2ZLZWg3Q3VtN2c2RFMzSU9hWDFVS2xBSVBLeFZ6?=
 =?utf-8?B?d1lMN21yRHBLcmg3clJ4WmtGQUpKQm1rczM0VFphalhWN3hDYUIwNDlidHR3?=
 =?utf-8?B?NkFxdzVWTkJWa2ZwbjZvS3NLUlBEYjdFRjg2RkEwbzFRN2tqWkxXZjB0Wi9r?=
 =?utf-8?B?eDFrbllVWTV6a1cvc0dBRW5Eb0o0OGZEM2w3MlpiQXMvOEFCdnBaNktxcXZZ?=
 =?utf-8?B?cGY0b2VKcCs5bUJpa2NCT0k0S1o0dU1YdzREc2dtenZmdUxCS2JtMy9nbHR2?=
 =?utf-8?B?Q1BCK0hSUlJZVVk2ejJ5WDFJYUViclk0ZmZyOWVVaFhBNU55R0VmUEEvRHRL?=
 =?utf-8?B?a1R3L3JYQVRIZ3BtVlVhbzVnTGJTdjFJdXRlSDd0bEhHSitXd0RhSks0Wi9L?=
 =?utf-8?B?UVl1RlpVTjJGbk10dnRWRDJ3Z09PbTBmYkVGVHlORWxJcjBTTC9YMUo5Um5h?=
 =?utf-8?B?NFBvajNpdDEraFRSa01lYlM2V0owMTRxUXZkd2JaWFlYL1JGVXUvOXhqWVhD?=
 =?utf-8?B?ZUFleCs1Y2ZEaUQwa1VYejBZS2JmZkx2OExBdy84NS9SeGh6RldURkZzQVdX?=
 =?utf-8?B?N05WUThxSllOeFIyY2F5ZG0zcEJ3a3YvRkxjZkl2NnZQUGFjZXc3WnlBcVdH?=
 =?utf-8?B?dVZpdUZKcXpUcmM0ZVU1VVhjYzV4OGlCR2t0ZDZDcW5zZms3MnBOOENta3po?=
 =?utf-8?B?RFhkQUxTbk1zSm5qaEFFZjk1UzRlbUNuWElIU3l3K3BHdG5GY2FJWHNZZVJQ?=
 =?utf-8?B?ZnVWcG9tS1JVTS9RR3U0VUVDTnpFRk5KMm1VTExNM3ZYbUM4TnFXMmJWRWs3?=
 =?utf-8?B?V3dhQVUyeUlVQ1BMRFo3cjU3R3Z4RzQ3VjNTNmliNXljQlRhQWdic1dYbzZt?=
 =?utf-8?B?QTMwVmxRMXRDQXZYaWtFanAwWlBSV3pIdVFQWkV0M2tCOGhmNS9rK1FJeE8z?=
 =?utf-8?B?U0dCejlUWXdqVWExZFQ5NEQwd1lwTmVLVElLcUZxcG9YOFZsYWRqOXVxMDB3?=
 =?utf-8?B?WlpVNDNnTzRUU0F6Nlk4bTg3a05EQVgxRFBZeVlvNG9tcTNPMlZlQXgyczlp?=
 =?utf-8?B?TXUxOXd5enJhRlhVdWRpM2M5amRvR2tZUGJuVWNhRlBNbmdLUkVZbm1XOFFw?=
 =?utf-8?B?Wk9BV2FOZFBzRHdpeGdVY085N0VnUEEwT3YrZEV2Y2dJenVVZHBwOEdNbi9j?=
 =?utf-8?B?MXBNL3NOcnRFZWxzU0xoMndzN0dBbmt5T0hmNmthSUFSa0pGeGZGNWw2Njc2?=
 =?utf-8?B?cXVqTklCMUVCa1Z1OGszMm56cDdtanRvbHlDZDJHTGhySUtoVVJUOTBEaEZz?=
 =?utf-8?B?UHRNdlJxTVp4VVFnZEVrWVpQZGhmMkNnZE9LczF4NDJ3OXFIbDJhSk9hR2s5?=
 =?utf-8?B?ckpwbUYyZ1hUNEdqbGFaelNHQVljRk9IUm9PVml0YTA3YlIrVXNxWXRhMk5F?=
 =?utf-8?B?bVRwTE1qS1NjV1AzQ3BTTUlwMUFMNm5LaUhUM2RENDBTd3JNVVNiSXczb1dV?=
 =?utf-8?B?d1lFM2tVclNnMiszcFFVbXRVbGJ1ckZicnIzVHlZdlcwWmpvT3B6R3JVbnJC?=
 =?utf-8?B?TkZFcE9FcnpkNGF0S2ZmM3d3eG5qS3BpdnJQODFzdzhFaEJ1WlVOZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5536A70DE608C43843E95662E528BB3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5741.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff6b34e6-1152-494e-902e-08de63e4ee3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 12:00:03.3565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qWStJdkqvbtNCNkNoFe+mxykCp0CrgaevZ0LLjlAhL2pHAFlnSExlThKWmb/nvK8RRj7TALNget7wPxlfmYZ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7564

SGkgTHVpeiBhbmQgQWRuYW4sDQoNCk9uIFR1ZSwgMjAyNi0wMi0wMyBhdCAxMjo1NCAtMDUwMCwg
THVpeiBBdWd1c3RvIHZvbiBEZW50eiB3cm90ZToNCj4gDQo+IEhpIEFkbmFuLA0KPiANCj4gT24g
TW9uLCBGZWIgMiwgMjAyNiBhdCA5OjI24oCvQU0gS2hhbGVlbGksIEFkbmFuDQo+IDxraGFsZWUy
N0BzdHVkZW50cy5yb3dhbi5lZHU+IHdyb3RlOg0KPiA+IA0KPiA+IEhlbGxvLA0KPiA+IA0KPiA+
IEkgYW0gaGF2aW5nIGFuIGlzc3VlIHdpdGggQmx1ZXRvb3RoIG5vdCBiZWluZyBkZXRlY3RlZCBv
biBhIG5ldw0KPiA+IFVidW50dQ0KPiA+IFBDIHVzaW5nIGEgTWVkaWFUZWNrIE1UNzkyMSBXaWZp
L0JsdWV0b290aCBjb21ibyBhZGFwdGVyLg0KPiA+IA0KPiA+IFRoZSBXaWZpIGludGVyZmFjZSB3
b3JrcyBjb3JyZWN0bHksIGJ1dCBibHVldG9vdGggaXMgbm90IGRldGVjdGVkDQo+ID4gYXQNCj4g
PiBhbGwuIFJ1bm5pbmcgYmx1ZXRvb3RoY3RsIHJlc3VsdHMgaW4gIk5vIERlZmF1bHQgY29udHJv
bGxlcg0KPiA+IGF2YWlsYWJsZSIuIEkgcHJldmlvdXNseSBtYW5hZ2VkIHRvIGJyaW5nIEJsdWV0
b290aCBvbmxpbmUNCj4gPiB0ZW1wb3JhcmlseQ0KPiA+IGJ5IHJ1bm5pbmc6DQo+ID4gDQo+ID4g
c3VkbyByZmtpbGwgdW5ibG9jayBibHVldG9vdGgNCj4gPiBzdWRvIHN5c3RlbWN0bCBzdG9wIGJs
dWV0b290aA0KPiA+IHN1ZG8gbW9kcHJvYmUgLXIgYnR1c2INCj4gPiBzdWRvIG1vZHByb2JlIGJ0
dXNiDQo+ID4gc3VkbyBzeXN0ZW1jdGwgc3RhcnQgYmx1ZXRvb3RoDQo+ID4gDQo+ID4gSG93ZXZl
ciwgdGhpcyB3b3JrYXJvdW5kIG5vIGxvbmdlciB3b3JrcyBhZnRlciByZWluc3RhbGxpbmcgdGhl
DQo+ID4gbGludXgtZmlybXdhcmUgZm9yIGJsdWV6LiBJZiBJIGNhbiBnZXQgYW55IGhlbHAgd2l0
aCB0aGlzIGl0IHdvdWxkDQo+ID4gYmUNCj4gPiBncmVhdGx5IGFwcHJlY2lhdGVkLg0KPiA+IA0K
PiA+IEZyb20sIEFkbmFuIEtoYWxlZWxpDQo+IA0KPiBXaGF0IGlzIHRoZSBrZXJuZWwgdmVyc2lv
biwgYWxzbyBpdCB3b3VsZCBoZWxwIGlmIHlvdSBzZW5kIHVzIHRoZSBIQ0kNCj4gdHJhY2UsIHlv
dSBjYW4gY29sbGVjdCBpdCB1c2luZyBidG1vbiAtciA8ZmlsZW5hbWU+IGFuZCB0aGVuIGF0dGVt
cHQNCj4gdG8gcmVsb2FkIGJ0dXNiIHRvIHNlZSBpZiBpdCBjYXB0dXJlcyBhbnl0aGluZy4NCj4g
DQo+IEBDaHJpcyBMdSBvciBwZXJoYXBzIHlvdSBoYXZlIGFueSBpbnNpZ2h0IG9mIHdoYXQgdGhl
IHByb2JsZW0gY291bGQNCj4gYmU/DQo+IEsNCj4gDQpNZWRpYVRlayBCVCB0ZWFtIGRpZG4ndCBn
ZXQgc3VjaCByZXBvcnQgcmVjZW50bHkuDQpJIG1heSBuZWVkIGtlcm5lbCBsb2dzIHRvIGNoZWNr
IE1UNzkyMSdzIGluZm9ybWF0aW9uLHN1Y2ggYXMgbW9kdWxlDQpJRC9maXJtd2FyZSB2ZXJzaW9u
L2RyaXZlciBzdGF0dXMuDQoNCg0KIk1UNzkyMSBXaWZpL0JsdWV0b290aCBjb21ibyBhZGFwdGVy
IiBJcyB0aGlzIGEgVVNCIGRvbmdsZSBvciBtLjINCm1vZHVsZSBvbiB5b3VyIFBDPw0KDQpCUnMs
DQpDaHJpcyBMdQ0K
