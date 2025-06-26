Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023090.outbound.protection.outlook.com [52.101.127.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016F41B6CE3
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Jun 2025 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750911594; cv=fail; b=AjJm4xm9QAW4pwirenj2dszrBJ9LUDihZePp6CMip409me9qjmoCFgydoDxMLz9QGUOigPYHgyOod00ilprl7Ba9ptruNwYBda5LkZzfsXHG7NEn1n/gTyQxtsp0bthSfAaHhIrZ/pLGpx+nfeRmvYJFicXVCkrCEpWFJRkJsZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750911594; c=relaxed/simple;
	bh=qeMj9JtPz6fq1Bxmu/OWzn1r5B4df2mtdsS5Pz7u3+E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iVp1CN+4KPk2O9CCpqouk68samC2P9AMh8Mu3YFsxfOo4qcCkF/Upbcoo9ufD10N/pFo4/TKsD7wSb/3N31o9NDb/nOvGQVQX52j/Xa8S4JTaUbk8m3HNYYK7whyDpYR3KOc78CfcmydbOFmtTx/aZgQmpgwmOnnHsd+d7+Uj+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=LCH3vgJO; arc=fail smtp.client-ip=52.101.127.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="LCH3vgJO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZG+SKRQuOORZgApgC7eISeRGzy0nCVYCPgg0T1BF5a9ATM7iIJIpYizaKHyAqCAiNaiL8yOtD5MaCaROPASNKWzdySHfBi8rBsySHGIItNQMVAQKfBVGDZ+Nx3a+RUE/SphzQZCsg3S0gFSjL1E3vImB8CuoBY+soIJDxKRXcGOZe7CgdcVWIyZIqiq5420LQCXI9Wxjw145tYO9Gquhpph3uREK+ELo9bDu68aPtSCZX93PCy9lh8wIFXxgKYHyzi/iGjfM3p1U1N96L5/r3KCGR3xAS5uvN5Sg2s1DPHgFLRrzhURdjPhTpry59SufZE2Sc3F25s3Poz/UH5MzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XWG4L0lIKaf/aj6gnBKEik8KgVLB1O8g+Q2+AaOPzM=;
 b=r5/kNYzYjItIv+dwpDJMNYIGJGxP9vz0TgCyCu0NY8hHBiZ7P4q+I43GYHheMkWcRV450R7FobPa9PbioXS+EscIIsHXicCVS37gIGurs9UOe673W3r548gYc3A0PsWrCn9E5TsoP9cMiKGDt/WEur8lILgWuqHwAjkDqLUZ9LhTo8je/4n9wLDxprz2jaa/JrLGxbKgbYGYRfwpFn0E8VxuDU9qU4n1nfYPWyhEpSqdeLI5nK7zlsWCU3I5rhiSrpSIhCXJuTTl/9n7PFyGBuCFBjn+G5O2EL4+6GUaduCRRt1d2/G/xVrHp2uAD04d2NPm+aWx6IpEPy0TI1FSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XWG4L0lIKaf/aj6gnBKEik8KgVLB1O8g+Q2+AaOPzM=;
 b=LCH3vgJOOUWgLr0iwOWGhP28H4FuN/7O4aoDA2kr6/mUf42NZcp5cHl5Sx92GLZ/2PmlvCGdkx1FOougXTmTB3QLb5y2HuvDnyq/x+UsyA88zE3QiOn5dk7ucysnw5Z5fK6pgpsF8H34WBnvIk85I8UwGGXyACEEMFhL8bcANmBvLi/9nDg7sxcJCnGuKx7+mKP4nvv4K6udACJmc7CX7QAl3imKOse4qch6aSlufkPxdBR1UHwqaZboc3zM8fHPHsCQSVi2YXTBUF3PX3xzQ8IYfGiGBkeP+FVTjXFemrgKWgFKDzer83VFSsL7UceAqKbytGbhBGyZy4HATBFdcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEYPR03MB8302.apcprd03.prod.outlook.com (2603:1096:101:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Thu, 26 Jun
 2025 04:19:43 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.8835.023; Thu, 26 Jun 2025
 04:19:43 +0000
Message-ID: <28726e2c-aa65-4e64-b2a4-98d59ed5270f@amlogic.com>
Date: Thu, 26 Jun 2025 12:19:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez] shared/bap: Set stream to idle when I/O is
 disconnected
To: Pauli Virtanen <pav@iki.fi>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com>
 <CABBYNZK=5-N8wcHhSp5ii8FmM5CzPFqKheKHOcCs8brNhVp_ww@mail.gmail.com>
 <1f2fe697-6437-4000-8aa3-d09bb7090a46@amlogic.com>
 <3ac16d0a7c5569bce0b28f18bc2245bef8ab64c2.camel@iki.fi>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <3ac16d0a7c5569bce0b28f18bc2245bef8ab64c2.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:4:197::23) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEYPR03MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc3c072-4e99-4c93-72c9-08ddb468ad1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnpXcm1CZ1ZUNng0VVhKYmlaWW93aXRRMlFXNFpBb3h2TjJmdVVLaEdzQXhB?=
 =?utf-8?B?M2thbEU1Ulc5TTRzWFl5SUJDVG53U1Z5ZklEdDVHSUx3dGI2U21PNThRSnM4?=
 =?utf-8?B?SWlEN1ZaZjRwYjF0SlFDL3FpTnN1MUYzaUt3NzVkNVVDZDVTbDR2bVhXRWw4?=
 =?utf-8?B?dVN3Y1Z3NVdoVjVRZUxLL080d1pLUk1XdGEweEZFZWxUVUcyMGZ3SW02dDNh?=
 =?utf-8?B?aFVrdWRCamFaRzBlYUV5M2RoMlVFVzY2OEVSWFVaLzhDRzBWSWNKQ1p4WndN?=
 =?utf-8?B?NlU3emMrR3Q5WTNnNkQ5YXROdCt1aEQvM3pYL1VQZFhkOG1WUVNndk9PZHgr?=
 =?utf-8?B?NGYxc2hiY0tLdzIyQ0NmSCtxU2RiKzdWNlRxWmgwcWo1akZaUEZvc29ncFFN?=
 =?utf-8?B?d2EvTTNxeDVUcHB1alRkTXllTlduT3lLNVdta2pwb1NJWlMxTFVUYU96ZkZt?=
 =?utf-8?B?a285NDhmS1V6c0ZHZFFjVk9xelplSlZsb3FXaXROZThtS3RzTDl1OUZFcFpk?=
 =?utf-8?B?WmhSLzY1eFYrSHhBcEw0WHp2TCt4UkhXMVZIazl1cGZUMDJzeExmT3BBYm5p?=
 =?utf-8?B?cHpMZ2RTWHljV2srSzBBSWc0UlRhM1pVMy9yMzgzTjhLT1QvL2g2eEhXdUlX?=
 =?utf-8?B?SStNWU1xdUMwdElmT01jVUFLdnNhSUtvNnpNZXJDK0RxQ0JPdndZck1LNHJj?=
 =?utf-8?B?UTRYemtiYmEvVktqRU9DYmFxTmFHVDFMSmNSNSt0SEhiWXBtUEZNSk96Mkg0?=
 =?utf-8?B?WlVpRGtLdkpLUnF2YitBWDNMRjVtMDd5dXNJTFhWNmtRSE5hNGFDMEtyTDBX?=
 =?utf-8?B?MGM3Wlg0YmtVeVkvNGczeWw3S1Z2MjE3ci9teE9KaU44S3F0cHJZODN1dksy?=
 =?utf-8?B?Y21teTQyRUpJb0k1M0ptLzJ4cEIyTmJvdGJnZC90SFhSbU5aTGdSaU1rZWww?=
 =?utf-8?B?QmxlU2R1S2dkOTEyTDZ1TEN3RTBvQk5LaHpJQkY4cS9zemRNU2gzRmJuRnFJ?=
 =?utf-8?B?TnJyT0xmZXhJN1BrUXJQdFBUK20ycWpOd1NQbjhUMHVEK3FuU09qdmNiaUZ3?=
 =?utf-8?B?bTlOOC9uNVcrUnRzcmdGZUlTRHZsZ2dYY2Y3Q3BCR2c3ZkIvWG9ZL3J2SFVP?=
 =?utf-8?B?UHg1Y0ZkUEg0bmFSc3d4M1V3NS9COG9Xay9USEtjaE1kaFhHcTEyZnh0clhk?=
 =?utf-8?B?YkthZzRNU0crSkxzeGZyYzkySkZRblkxS2RjRGZYTTBSRHptUmZPQTlHeEFX?=
 =?utf-8?B?NWF0dy9vdlNtdENqVU5YNkVhZDVXVjRKcjFETnRzTUR4aWJlTHg3N1I4MVR3?=
 =?utf-8?B?YUREUm1UU0FCUk8rYmhPREFGRVNjT2xCd1pXeHFEeFJ2V0NKbmRoNXp3SXlt?=
 =?utf-8?B?M3FBOS9kcklWZDdQMFV5c1J6cXV4Qk5FN2hnbkErUkN4SnV3cTNKN05EQVJt?=
 =?utf-8?B?dk5CRmFablZRSWRUSjFsYWVnczA2akRsYkt5ZVNuY25lNTVFK1FTZ3VHTlcw?=
 =?utf-8?B?RHNwWU9aL1pDRkY3dHpOSWxYWnA4MmJ3VzM3OTJ4N3JRRkN6cmFRZGJoYml0?=
 =?utf-8?B?YnpKbmxHT1R6ZlBxQ0lVWWo5RERtNXNHSU56ZnBwcXhwRE9ZdXZDcFpkOVVM?=
 =?utf-8?B?NCszS2tBWGFQY0JJeWJmVnhlOHBTTmt1VkJZR0piQ1hkbmRIWDRUQjRDTWZX?=
 =?utf-8?B?NEcyOFN1VFp3VEhVVzRMcFI2VzEzN3c2MXQ2TTJTckxJbWN2cU1Tc3dxMW9j?=
 =?utf-8?B?elNieGpmMkpicW4xQVFSR2JrVXJXczUyL1kwekt1RXBNbmtNV2VUNFJ5Q05D?=
 =?utf-8?B?UGMyeER3ZGQ4MG1acTh4eHcyYnBaYWErd2ozbkJiemcvTDZSczNmSjdiNUVk?=
 =?utf-8?B?NFg2dXhpM0IxRHdmcTNRV2xvZ3QreFJJRzZxT0QrS1d1Ty85SDdUQkQvVi91?=
 =?utf-8?Q?npT21eTPq78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVFOT2JQUW9tZTAxOVdBa2NDa09GL2dIVitERCtuVFFLdExIQ2h1SzA3aE5X?=
 =?utf-8?B?MUIwMEdiNnJlN1kveGpqR2RGUEljUzZJc0hLSmhkM1ZIME9TdmJPcnJNSjNu?=
 =?utf-8?B?QVBxVmdEWHhzdGZwTTVheHd4aDdMU0NRR1hDSXNZM3hsMXJFNEd5Y2x3anRK?=
 =?utf-8?B?Y3pOZHgzcG9iZFhJVG5sbEgzcHkzZEQwUDZjS1d1WWhEUjRNNjFlaWcydUZZ?=
 =?utf-8?B?SlRFaFpDejhkaEcrTDNQMFVmbU9VbG5WYWFEN1k0ZlBqTWUvbnIwUVpvOUM4?=
 =?utf-8?B?elY1bndnMUw1Vkh3OU5MdFJHRGszZXo1UXVVSUhjTkVxd0dMeGNYUE9sMkM0?=
 =?utf-8?B?TkdTcThlRjV4SU5ZYXg2WXlEbWQzZVBJWE9JemxBUWcwTEZDNzdtWWJOWDIw?=
 =?utf-8?B?VUo2Yng0TUlTUk5xclQrODY1SUQ4cXJxNkg5TGUwR1lwL0pZc09OLzNxdjM2?=
 =?utf-8?B?ZmQ2WEU0Ym1KRXpzN2dtc1RzakpQMDdqVCs5UGE5OWtOMHRqOEpyRGhsRXlF?=
 =?utf-8?B?NTNKL1IwSUpaUk9zOTNBbjdzdkY2eDdMY1ZHd2FUVmIxVFVZZ2FzR2QwdFVi?=
 =?utf-8?B?SW0xaC84U25RS2w1M1lRTEFnazNkL1QwTlBHQUNJOFl6eHAyR1RXSXhneHgy?=
 =?utf-8?B?Tm1neExQTkFLS25IZHZmMXcxRWZvVENnRUpsZHhIa3BjamtqQ01YU1dZMjNv?=
 =?utf-8?B?WE10NWgwN3FtVU9NZjc1THBsTmkwUG9KTHRNN0Q2T3YxWHkrYmt6L1h0eUw4?=
 =?utf-8?B?dkJMaHJPOTZnd09lTGFSS1dXbTNOTHlXT1Z0bDFCZmgzZVJIaDh6ZVdQakxx?=
 =?utf-8?B?cUZZYnRUSGdYdmEwNXQ0c0RISzRKQXpxeWZkMlZwaVNqcEhXVkZtY3NFMDJZ?=
 =?utf-8?B?T09HbGtoYjZ4cm1UYUNEZUU0elJmQloxbXVUMXRibVh5dk9VemxCVzBQZDdP?=
 =?utf-8?B?N1dQZEVNV2dRdnBCMytBbjZZc09OY1p5U0RwdVlmRUlEcGxLNXpPVGViUG1a?=
 =?utf-8?B?emdqb1ZzNHNDWWczVHFZelhPcEVSR0p2am5ROHY4SkVPcGFlTTFXK0tJN2xC?=
 =?utf-8?B?WXlqTDdnZUlqVUFESjZoa0dydXRVTW5xdkU4MUtQajBRWFdQd2g5NXhweFVO?=
 =?utf-8?B?VjBidG14NnpKcFpkZUJ6ai9vN3N3b0R3bWxTTC85dzhzOWRGRkFVeEh0Ri9Y?=
 =?utf-8?B?OVRKOXRQWTB6M0N6RmYwY2VEWnh2NU13K01EQUdMa3owdkZxemVSVGc5WEE4?=
 =?utf-8?B?YWxPK1RtV3A3cGtRMDlPRTRyNHZ3d1dZMzN0elBlV1ZYV2dSdHkyVHoyTFBr?=
 =?utf-8?B?TzlTUnRZM1FXMGEwek9adzdIQmU2cm95ODFyNWFMME80V25UR0xYdmFNRSt2?=
 =?utf-8?B?bE5WU1dkT1hzQWREWENSN3d2VGExVXcyNHd0WTByN2hLUTRuNzFEaUxSRGxs?=
 =?utf-8?B?Z3VlUmdMb091djE0c0VPYWsyT1N0eGhPNjJlVXVNaTJGSkgzTFNRQTVLRm16?=
 =?utf-8?B?Tkd4VlVoV0RTVlZ5aTByNndRUGp1Zk1nWTN2WEdjTE85Q043WmpHcHNIb2g1?=
 =?utf-8?B?ck5xV2FZd3graitjbXV6OS85cUM5NzdTNG1RY3VwbWRkemtHM1UwYzRFamIw?=
 =?utf-8?B?TUZtS2FtcVE2SXNFTUtQUjMxZjhnYjVSYWRLWTFSYU9xRXZLbWlCUzkxM2Y0?=
 =?utf-8?B?b29XVWpveFJ3YkNYM1Axc0NQbGliY01VOWxwZXk4dUc1TFRacDFLZDM2ZHlt?=
 =?utf-8?B?NXpPb2tvYUhtb3hKZGFvckxwOFUzUjllRlJsKzBOVFZHT1ROUmlTcmd2SnBk?=
 =?utf-8?B?bEdBdTVtWVpHL0ZHNFAxdDhQTnNFYmJINTJuMzNIcW9LaXZwaDRlR1VVdXJU?=
 =?utf-8?B?c1d2VjV1clpua2dtUlRLUEJFY2NJMG1LdFNHRXVGeXNQcDR0VnMvS1l6azRZ?=
 =?utf-8?B?V3FuU2J2aFZLSGhicjJqZDdTSmgrNUdYKy9iRFV2UWdxd24vUG01dndPWktO?=
 =?utf-8?B?Q1ZQYTVRc3R2MXRSMFdlVk1zeDJvMmNlQlplaVFSdHJFSTFEVEtpcHRZUWxV?=
 =?utf-8?B?OWtOdWViekZKYWYzQlYyL3RhNERGMDNLUzJueE5sMGlCRm9NWTJwSDlMYVFH?=
 =?utf-8?Q?4HahJzDuji48Zi+/SDGqMVvyr?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc3c072-4e99-4c93-72c9-08ddb468ad1d
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 04:19:43.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKZGdWJEbzT+LtBBP9qVtJUETU75tOL3y1OQXxUbSZRNGi21rL5nhVlfLA4bb2+eiLzTbTLmGtaoo56ztK3t8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8302

Hi Pauli,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> ke, 2025-06-25 kello 13:24 +0800, Yang Li kirjoitti:
>
> [clip]
>> When music is paused on the pixel 9 phone, the CIS link gets
>> disconnected. As the transport state changes from ACTIVE to IDLE, the
>> stream state transitions from config to qos.
>>
>>     > HCI Event: Disconnect Complete (0x05) plen 4           #1425 [hci0]
>> 49.572089
>>             Status: Success (0x00)
>>             Handle: 512 Address: 6A:AB:51:47:3B:80 (Resolvable)
>>               Identity type: Random (0x01)
>>               Identity: E8:D5:2B:59:57:A6 (Static)
>>             Reason: Remote User Terminated Connection (0x13)
>>     bluetoothd[2313]: src/shared/bap.c:stream_io_disconnected() stream
>> 0x1f9fc20 io disconnected
>>     bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream
>> 0x1f9fc20 dir 0x01: releasing -> config
>>     bluetoothd[2313]: src/shared/bap.c:stream_notify() stream 0x1f9fc20
>> state 1
>>     bluetoothd[2313]: profiles/audio/transport.c:bap_state_changed()
>> stream 0x1f9fc20: releasing(6) -> config(1)
>>     bluetoothd[2313]:
>> profiles/audio/transport.c:transport_update_playing()
>> /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 State=TRANSPORT_STATE_ACTIVE
>> Playing=0
>>     bluetoothd[2313]:
>> profiles/audio/transport.c:media_transport_remove_owner() Transport
>> /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner :1.1
>>     bluetoothd[2313]: profiles/audio/transport.c:media_owner_free() Owner
>> :1.1
>>     bluetoothd[2313]:
>> profiles/audio/transport.c:media_transport_suspend() Transport
>> /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner
>>     bluetoothd[2313]: profiles/audio/transport.c:transport_set_state()
>> State changed /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1:
>> TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
>>     bluetoothd[2313]: src/shared/bap.c:stream_disable() stream 0x1f9fc20
> AFAICS the bug appears to be:
>
> - bap.c:stream_disable() should do nothing if stream is
>    not ENABLING or STREAMING
>
> since it's called from bt_bap_stream_disable() which is called on
> transport suspend which should be noop for BAP server if stream is
> already gone.

Following your suggestion, I updated the |stream_disable()| function, 
which successfully resolved the issue.

--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2059,7 +2059,9 @@ static uint8_t stream_disable(struct bt_bap_stream 
*stream, struct iovec *rsp)
         /* Sink can autonomously transit to QOS while source needs to go to
          * Disabling until BT_ASCS_STOP is received.
          */
-       if (stream->ep->dir == BT_BAP_SINK)
+       if (stream->ep->dir == BT_BAP_SINK &&
+          (stream->ep->state == BT_ASCS_ASE_STATE_ENABLING ||
+           stream->ep->state == BT_ASCS_ASE_STATE_STREAMING))
                 stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);

>>     bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream
>> 0x1f9fc20 dir 0x01: config -> qos
>>     ATTbluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1426
>> [hci0] 49.585656
>>         ATT: Handle Value Notification (0x1b) len 46
>>           Handle: 0x007b Type: Sink ASE (0x2bc4)
>>             Data[44]:
>> 01010002050a00204e00409c00204e00409c0006000000001302010302020105030300000003042800020501
>>               ASE ID: 1
>>               State: Codec Configured (0x01)
>>               Framing: Unframed PDUs supported (0x00)
>>               PHY: 0x02
>>               LE 2M PHY preffered (0x02)
>>               RTN: 5
>>               Max Transport Latency: 10
>>               Presentation Delay Min: 20000 us
>>     ...
>>     bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 24 #1427 [hci0]
>> 49.585725
>>         ATT: Handle Value Notification (0x1b) len 19
>>           Handle: 0x007b Type: Sink ASE (0x2bc4)
>>             Data[17]: 0102010010270000025000050a00204e00
>>               ASE ID: 1
>>               State: QoS Configured (0x02)
>>               CIG ID: 0x01
>>               CIS ID: 0x00
>>     ...
>>
>> when playback resumes on the phone, it attempts to set the ASE state to
>> Codec. However, since the stream has already transitioned from config to
>> qos, the phone ends up disconnecting the connection.
>>
>>     bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 12  #1433 [hci0]
>> 60.216004
>>         ATT: Handle Value Notification (0x1b) len 7
>>           Handle: 0x0087 Type: ASE Control Point (0x2bc6)
>>             Data[5]: 0101010000
>>               Opcode: Codec Configuration (0x01)
>>               Number of ASE(s): 1
>>               ASE: #0
>>               ASE ID: 0x01
>>               ASE Response Code: Success (0x00)
>>               ASE Response Reason: None (0x00)
>>     bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1434 [hci0]
>> 60.226086
>>         ATT: Handle Value Notification (0x1b) len 46
>>           Handle: 0x007b Type: Sink ASE (0x2bc4)
>>             Data[44]:
>> 01010002050a00204e00409c00204e00409c0006000000001302010302020105030300000003042800020501
>>               ASE ID: 1
>>               State: Codec Configured (0x01)
>>               Framing: Unframed PDUs supported (0x00)
>>               PHY: 0x02
>>               LE 2M PHY preffered (0x02)
>>               RTN: 5
>>               Max Transport Latency: 10
>>               Presentation Delay Min: 20000 us
>>               Presentation Delay Max: 40000 us
>>               Preferred Presentation Delay Min: 20000 us
>>               Preferred Presentation Delay Max: 40000 us
>>               Codec: LC3 (0x06)
>>               Codec Specific Configuration: #0: len 0x02 type 0x01
>>                 Sampling Frequency: 16 Khz (0x03)
>>               Codec Specific Configuration: #1: len 0x02 type 0x02
>>                 Frame Duration: 10 ms (0x01)
>>               Codec Specific Configuration: #2: len 0x05 type 0x03
>>              Location: 0x00000003
>>                 Front Left (0x00000001)
>>                 Front Right (0x00000002)
>>               Codec Specific Configuration: #3: len 0x03 type 0x04
>>                 Frame Length: 40 (0x0028)
>>               Codec Specific Configuration: #4: len 0x02 type 0x05
>>                 Frame Blocks per SDU: 1 (0x01)
>>
>>     ...
>>
>>     > HCI Event: Disconnect Complete (0x05) plen 4           #1445 [hci0]
>> 63.651497
>>           Status: Success (0x00)
>>           Handle: 16 Address: 6A:AB:51:47:3B:80 (Resolvable)
>>             Identity type: Random (0x01)
>>             Identity: E8:D5:2B:59:57:A6 (Static)
>>           Reason: Remote User Terminated Connection (0x13)
>>
>> Introducing a check in the stream logic to distinguish between Unicast
>> and Broadcast would indeed make it easier to handle different stream
>> types cleanly.
>> However, if we temporarily ignore Unicast caching, a simpler and cleaner
>> approach would be to transition the stream directly to IDLE when I/O is
>> disconnected.
> This disconnect callback is used for all the roles: unicast client,
> unicast server, broadcast. All of those require different handling, so
> it's probably most clear to split it.
>
>
> For unicast server:
>
> The behavior has to follow BAP v1.0.2 Sec. 5.6.8 and ASCS Table 3.2.
> Transition to IDLE is only allowed from RELEASING --- but one can as
> well go to CONFIG like it is in current master.
>
> CIS loss from STREAMING should go to QOS, and I think it currently does
> so, via bap_stream_set_io.
>
>  From a brief look, the current version in master is maybe OK, although
> one could test the above case again with stream_disable() fix.
>
>
> For unicast client:
>
> The current version in master is probably OK, although one could double
> check it again.


I've added type checking and made the following modifications. Please 
check if this meets the requirements. I believe that unicast source and 
broadcast source are active behaviors, so there's no need to change the 
stream state through I/O status.

@@ -6584,10 +6584,15 @@ static bool stream_io_disconnected(struct io 
*io, void *user_data)

         DBG(stream->bap, "stream %p io disconnected", stream);

-       if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
+       if (stream->lpac->type == BT_BAP_SINK &&
+           bt_bap_stream_get_state(stream) == 
BT_ASCS_ASE_STATE_RELEASING) {
                 stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+               bt_bap_stream_set_io(stream, -1);
+       }
+
+       if (stream->lpac->type == BT_BAP_BCAST_SINK)
+               stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);

-       bt_bap_stream_set_io(stream, -1);
         return false;
  }

>> Once the Unicast caching issue is properly resolved, we can revisit and
>> introduce stream-type-based handling accordingly.
>>
>>>> +       stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>>>>
>>>> -       bt_bap_stream_set_io(stream, -1);
>>>>           return false;
>>>>    }
>>>>
>>>>
>>>> ---
>>>> base-commit: ae1b7f6ba805f82742bbc32ff275e268248ef9f8
>>>> change-id: 20250624-bap_for_big_sync_lost-63476c679dbb
>>>>
>>>> Best regards,
>>>> --
>>>> Yang Li <yang.li@amlogic.com>
>>>>
>>>>
>>>>
>>> --
>>> Luiz Augusto von Dentz
> --
> Pauli Virtanen
