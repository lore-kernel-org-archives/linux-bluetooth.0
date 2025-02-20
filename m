Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884081F3FCB;
	Thu, 20 Feb 2025 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051626; cv=fail; b=m0P9Kh3qEt90A58RQTr8AxraMdUOho+rx9Sg9jvUTPQOYPLffPfezewfVC7tpHv+bEaOXnGGKxr4h8avj3hHTnF/fNSuqDmKgrAncnTmA9hnrGYrmokvYNDXKdIokl4zqK8nbir5TBaSWyoO/Y7OdzozlUxu8VCWLdWGW1iow2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051626; c=relaxed/simple;
	bh=wtpNaREMXoeKvZyK2KJIhERJ8JA2vNi/7MLQlh7aSvE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPvIrmC+q6T7eft9YLApVbUX/+rSFvogVXlyA8CAwXJMp2pjkDSVmA+vGB3Pta1d64kBd54qwVTWEFRI252UL1NChmKX27F/OjmDtIhpGbf2BE3n2wE6wS0RnMMfHa8IyCB1RrrZWpy3jHjN3RjRJ7R2LMiHALKPkMj/hHdKmJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nWPD0SYZ; arc=fail smtp.client-ip=40.107.241.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nWPD0SYZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wlZy2pv2OQbmRS5G7S9f0oGfPvesPW7lC1C41MkYvFGAW+b8DetPPe5HoqSQfVyoiD4KD3Qrjwn2ofaCRh0C2h2Wr2ZX0qj2BGYnXqPvJXZfZNHF9/LtBJVELLGx6jlKRMgfPsbmJl3Em7vvXm5kxz7CdKW7YIEyZJ3wV25uQj4+ST/aNpSH1sAOb/Gx2b4hLjjo0YbzXH/x7eXJbNre+vJ1BR/t8oCX2AjUX4BXDag+2fm3DwBDrDMiQkl2KQid5vYdPnzA8q+l/LPQx92TFb3Iwobpk9mffFc3IvS/BGUqp76bIuNp3WX2v4TyHb9Wf8/mnxK+l4wDiKhz2oAszQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jRe9+lZM2I1aLDz7V8EYgNMomijvzqACZ8+BxPNAUmg=;
 b=eLk4su0lzzeihpuc6wMxgqL+f/5QQ9TJ7h6mzZYCpQsAqksz5u208+2tSbvB72wyjqKO9Z6v9vilh7Uisd3B52eayKRzwXfwRKVv0fmyPi0Fh5lhLb7ox3XXJDdHA+w4+fydCrcVqJZ6bEzQRJ8qXZyKLE5Nt+Aajw3Nyem5IfGDGwhUVM0wO9wOxFZWvSEwC9j4oADtm+z0QpPG6zE/8YYqOfL/aghxM48GI90pYTw6mSKNnDC8cd7r4N9LlW7D4qPqislh87qRfKIjWHG83tk9sDxdoFAqbNqbj4ZlIEcJQ+uowqUOfbdE5K0y4+Q5ZyZT9lPhCpilUdcsEXRq4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jRe9+lZM2I1aLDz7V8EYgNMomijvzqACZ8+BxPNAUmg=;
 b=nWPD0SYZh/h5dw/HEjpjzzySrNKDHixBaKELYeJBS4dcAMLq9K+bP3G1VCMeTBJeaH7WuUQG6MN+UmhVOz8zGEKiRJZxsHG6ohWE6pHRoiZMxk6UXsFnttxNT+EqApfu/hxeT5dXRRgfQ0Jaw3WpgZCdx8oLm7ONs3AhRwx9WD+ImZ7OtMQQKQG/od7agJ+g67FYi56S4/FROL1khSOHU5HZO5n6BtVtTjWgMGxT9bhMlMtd4n1rNKAcOapTZrK3bxrnH7et/emNAYgZpbf/2afLj9PO+GLukcYIWZtdZDGZVpIb2zb6POIAWp0gBtuIRm3htFDyAsVfQPnW1KFhTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM9PR04MB8827.eurprd04.prod.outlook.com (2603:10a6:20b:40a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 20 Feb
 2025 11:40:23 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 11:40:23 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	johan.korsnes@remarkable.no,
	kristian.krohn@remarkable.no,
	manjeet.gupta@nxp.com
Subject: [PATCH v5 2/2] Bluetooth: btnxpuart: Add support for set BD address
Date: Thu, 20 Feb 2025 17:11:57 +0530
Message-Id: <20250220114157.232997-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
References: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AM9PR04MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: da905a00-9b84-4a2e-0741-08dd51a35c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bmxqTWRpQzcwTElWN3Nra1FINldHcTBqcWZ2UHd0Y1VENGNPSG8zTkRvV3hX?=
 =?utf-8?B?OHBaVytKUTdjeVhtNk9HYm51T2NXOW03NCs2L25qTC9pUStBbGFscnN2cWYr?=
 =?utf-8?B?aHIyeU91NzdPcTJsOWJaREErR3JMUFAzR3E2SFU0VU9UYndVeVRQYm1CZG9r?=
 =?utf-8?B?Tys4dHRuT1QzOFNXQ2lUM0k0eXZHbVFSNUlSOHg4UUQ0Sm91ZEZXY3dETTNL?=
 =?utf-8?B?bDZZVlUxb0krY1UvcUFtZnJKTjFnai9nYk01RGxVNTZ1a0ZWd0F6b2lEcHl2?=
 =?utf-8?B?UDJZMmVBWGNyK1NsRmNEdnpnczU5S1hyc3ZaNyt3UmQzSUJncTJFYnV4N1Vy?=
 =?utf-8?B?Z3ZKRlh6bTZnbmFSVUl2OEJ1dlB2UVR6Nk5TUzI3MVU3Y3FnY2lEa244dWRW?=
 =?utf-8?B?UTVvbUNLT1p5dVdOU2pwZ1prMVlSK2lnL2pPbnNMMHpWYU04dVRxRTBYUlFj?=
 =?utf-8?B?VnBjbHJ1SjRvQU9TNnphNitMWTZhUlpxa3g0NUh0a2ZFZVJTbmNUYmhmU2tw?=
 =?utf-8?B?akFvVDFPZG9XdmRsK1d4RjFZaW01b0dNRDFjTHZJc2FYL28vclpXbGxMYmE5?=
 =?utf-8?B?eHR1Q2hIUFZjcXEyU0Q4b3RwTmdrZlNMRm1ZQXBhUlQrY0dKKzIzdGUzam5B?=
 =?utf-8?B?NnBDN2lUMjFGR0lVWUk0VDNlcUZXM051V3d4SWU0TjZoZTNrbDhLS0swbHgy?=
 =?utf-8?B?OVh1WEtYQlYvV0VwdkdqN2E3dlhDUCtDN2R6VG0rTjBpYWJZVTFhcEdTSlRp?=
 =?utf-8?B?dWVxRjcvZ1BaMnJtaGdwWjVDWE5zZU1XNVd5UHVwVWtpSEVxVDVuV0dKMUQ3?=
 =?utf-8?B?ZnJoeXUzMXY0UHdQMzBacXdReEtmWG43cVNSV242MWM4dFBZQXQxZHlveEEy?=
 =?utf-8?B?ZlNvVTFaZmcyZzZDUEpzWmNnaWFEVVdFdklrY0NmNFdXakNESGV3bkVhUlEv?=
 =?utf-8?B?dnJROTArRnpwd0p5WThWWjk0T3kzZFFhR1NNSHNVSjI1WTI5M0NpL1hsaElX?=
 =?utf-8?B?N09IZVhjY0xVeDY0RUxJNHRwMWc1MldDMUpXcjI1T3RlUGN1ejFpTm9KMmEx?=
 =?utf-8?B?cER4U3B4KzdOM0xHZjZEMWVIQWdWRkYvRVptRlNvMGptYU1YUDNwQlBBM3VD?=
 =?utf-8?B?OEJWK1VZQzBROGQwdndoaDdnVFZUS2ZrZEMwdWJ6ajByWVMzUnV5VnpVK2U1?=
 =?utf-8?B?WTY3aUgyR3QzY1R6RnNqRFVMd0xhb2FXcVV0SUtwS1IyS1VZeWFQOGQ5QkIv?=
 =?utf-8?B?RGNCeHRRRlBNK21UZllHbGZQMHBqK2o3ZWQ2dDJ1SDdYT3pNeW94ZGxESGV3?=
 =?utf-8?B?NkpPc2xCazJDQUJKMzdLZ2NXYjdXVGI0TmFzM2wzbzhyaENvNTF1MS84QVNv?=
 =?utf-8?B?cE1HV2xlZjNWbFBZYzVhbzRCdm1McjBKQ0ZPb21rTU5mdXV4c1hjTldmQkE4?=
 =?utf-8?B?b3pGeGU4WDlQb0Qyby91Q1ZRZnowYVFxWENMWFM3TnhaaUpHNUI3djlYTTg4?=
 =?utf-8?B?bWlmTlI2bTJqb2d4NXIzVi9RcFBsY056eHluUHdobTdhSkRhWnBZc3ZaNVJk?=
 =?utf-8?B?c3ROWVI5OGQwS1RWdnZTYmFPMHArakhVNEEwOG1aY1VJbFpxSlNIWHpTeW5G?=
 =?utf-8?B?NFBiZldMQzdhOTRBV2pmd2MvR29xZ1Z0ZStZK1NVT0MzZGZFaFhuZFUvemEw?=
 =?utf-8?B?NGtsdHE5RkgvQ3o1K2VEUHpHOGl1U0x4SjdqUVUrRUVORUpwVjRFMjhTUkhs?=
 =?utf-8?B?V3l5VWlKYk5SNGJhaG4wNkRuWXRJQk54WFJlY1Q0dEp5c3VjNWw5ditsS3BF?=
 =?utf-8?B?U2F3cmR6UGYySk1ldnVBaCswMzVqK1ZsM0NtSzlhaG0welBPeVRUZ3Y5TktH?=
 =?utf-8?B?K3UwQXVuUThUZWtZZjRCLzM3ZjlTWHpwQXcvQ05qVmNSL1hiVnkzelJZY2x1?=
 =?utf-8?Q?IiLjHjT7DhC25IodkkI8naFEdZnjSxLs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ckJJWm1JeFZWTC9wMnNsY0lBSGVOR21qVmVCNlcycnZ5bEhNVkx3emc5Uk9x?=
 =?utf-8?B?MWdpakdmaHprZlpnTW9vMlA4eUphYWNFdHVKSW15ZGdlR0tZdm02Snp5YzVR?=
 =?utf-8?B?RE8zQ0pKRGtYL1FSZXdBS0h1TXRVbVlEdGxRVngya2NHN0pvOTIzdFFiTGEy?=
 =?utf-8?B?Y3dQakxROER6KzQ3TlFYR1RTVllxVUZ1Z1ZscGE5ZytzVXVxS294MlpzWFha?=
 =?utf-8?B?SjBrN0RDWmptNmZWZE9vaUQ2cXRVNERoZGVnTFI4NUFNb1JjUjA1ZjlLejdi?=
 =?utf-8?B?MlNLbmZrNk5vM3ZSSTVmbEQwNTkvNUFNR0Q5TFhPUTlIY3N4dGVIdTViR1Br?=
 =?utf-8?B?YlZPU1VXblRZazQ0N3JvNmFzeSt2QmVLVGdmeDRjYTQ0UHN1UHRwa3R5Vlhj?=
 =?utf-8?B?M3RUUFVBdTdqT1RreEVGTFYvdTNJTzJZbjNwYVZPVDZMN3hoaVNROXN5UHlh?=
 =?utf-8?B?YUJGZUovcU1GWWxrUVRhWWpqaS9MeStuTFA0d1VDYnMwdExBT0FvM1BJNlVo?=
 =?utf-8?B?b21HZjFQVkxkbVF0MGdzWkQ3b3doWjU1ZzNZbWJFUFZoUm5LZ2lWWS95T3pt?=
 =?utf-8?B?TmVZM1l2SHRycStmcnpNdWtBMEFrSkw1OTVKRlYzUnpxb2dETi8vM1A3eFdw?=
 =?utf-8?B?S3k2OVlzQkg0VTBQRjI0TVFmYmxPZGducWFvdkxNaWU3Q0M3WW81ZkFadXAv?=
 =?utf-8?B?Q28rVXVPRzRwRFJpN2ZZSUYrWXVUbEtGUmhyRDVwS2NHQS9UeTRIMkVoakor?=
 =?utf-8?B?VkticGx4bDloUExnaDcvVk56ZFEreUtNSDFKWXNUM2MwSzZnZytCd0xGbXZa?=
 =?utf-8?B?b3hxUW55clRlQldXR09vNTdId2tIa1dJUFh2ZXkxQUZyUVpJaVBHK1RiQXdt?=
 =?utf-8?B?MzFDV2pyZ0sxTHl0YWxVSjRtVTVyUmlhVThMNEFvbEZoVVpZOEJBM1JwSVBT?=
 =?utf-8?B?SkNaNUZPOWNBQi9PZmJndHFDUEcwYlBrdFZ5UGxLT2Jpcy9FTVpLN3ljbmU3?=
 =?utf-8?B?ZmNsN3JFc1VOaXR3RkxtRENJZEtXbVhHdzBrT283TC9lemo0TmV0SVp4SGVB?=
 =?utf-8?B?bk1zZ0w0dlF1OGJDNmxSSWRyMGtGUjZIdTZHTmxIaGlVcXh1RkNMRU1wSGk3?=
 =?utf-8?B?VG4vd1Irby9VbTlsbisvb1E5SkxiRjZsdVlPcEZxZHoyWEtCMUJZNldQdUZD?=
 =?utf-8?B?cHJQdSt6cVd1OE5IVjNiMTQ2aWJETlh6TlI1YVFyNmR5SU9WZVZwNEpaTTRS?=
 =?utf-8?B?NzF3eWRUOWdzZkVIMklVWW0veitldWpRblhONzg5eUd5QjZYdDNGd3dvLzBV?=
 =?utf-8?B?RUhnaXVST0V5R1FCMVhlSGpjakNONnRsK1dYQ0E1dnRhRE9KZ3F4dnEzMzFp?=
 =?utf-8?B?MHJPdTh2SW9CVmxabFlJNVBUTFMwQTRRbTQ2QnFpalhhTDd0WmM1Tkl6Mjhn?=
 =?utf-8?B?Q2xSQjZPcENEaDY1UWRQeThlRkxsMnNZd3JxbXQ4UTBvYnRFY09ocy9OY3VF?=
 =?utf-8?B?dDJRY0NTRzFkQllnNU9ScENzaDRZcllZREZNTS9hMnNqbWQ1U2x5OUNFaFBU?=
 =?utf-8?B?MUVsUEpTQzYwejcrTjFWQTc1a1IwQld4NzV0RnFpSG8rc3J0Vms2d0cwQnNs?=
 =?utf-8?B?ZmU0M0Q0L2YwRWV3dXNoSmlaa0xxcityZ3I2M3grZldidGU2NGE3SzBiZUNy?=
 =?utf-8?B?MTRLemRCdjR0M0hnK3ZUenZUbkVUSFh0ZzFYZDlGUHV3ajFBK3ZDQjNHVmlk?=
 =?utf-8?B?dU5RbjJPMG5CYzlFYWFIMHZwL29VT2N3TUt4M09GM2VvVUFMZExGYS80QklJ?=
 =?utf-8?B?R3Fzbk0yTk9kOHVPdys1aXBQK1JHbWIvWGFpRGgrUkNqa2E3bVNaUld2c1d1?=
 =?utf-8?B?WlJBMmxiUmUvRHIyMzFwV1JrcGo2aXV4R1ZIZUtCN0crU2FhcFNXeW1uVU43?=
 =?utf-8?B?ZlowQll1VHp0YlRTS3FvWC9tQ1RrUDRxbG9KK3RBbXl4LzRzMGIyVHRqUzhx?=
 =?utf-8?B?NnZSR1QxbGcrRXdSTGdUNVpKRTZQSFpqcTRJdEIwNXNMYkpYOUg2UDE1ODEx?=
 =?utf-8?B?Q2d1dlJjT1dBM1Z5TzRuQ3UrSHR3MGhUKzA4THF2Y3hQMVlCTkhSRDF0Z0Zo?=
 =?utf-8?B?Uk04TkZmMWE1aHptcjZ6aEx5cFVpRFRpZjlGcVdMdlNua25vc005KzlZb2lN?=
 =?utf-8?B?WUE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da905a00-9b84-4a2e-0741-08dd51a35c73
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:40:23.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxLOvJXGdKhi4+HraetaszLOX+kKlKA+dEXpC4/BABhvOKgzzkWw/YcMrNsP/GvyO0iPtrOpvTfWP0BwOZ/7u4zUDvfnP5vrBWRvQ8GlqzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8827

This adds support for setting BD address during hci registration. NXP
FW does not allow vendor commands unless it receives a reset command
after FW download and initialization done.
As a workaround, the .set_bdaddr callback function will first send the
HCI reset command, followed by the actual vendor command to set BD
address.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Johan Korsnes <johan.korsnes@remarkable.no>
Signed-off-by: Kristian HusevÃ¥g Krohn <kristian.krohn@remarkable.no>
Tested-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v4: hci0 interface shows RAW mode if 'local-bd-address' not defined and
    HCI_QUIRK_USE_BDADDR_PROPERTY is set. Add Quirk only if device tree
    property 'local-bd-address' found. (Neeraj)
v5: Initialize local variable ba, update Copywrite year. (Kristian)
---
 drivers/bluetooth/btnxpuart.c | 39 ++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 1230045d78a5..dd9161bfd52c 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  *  NXP Bluetooth driver
- *  Copyright 2023 NXP
+ *  Copyright 2023-2025 NXP
  */
 
 #include <linux/module.h>
@@ -1197,6 +1197,34 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 	return hci_recv_frame(hdev, skb);
 }
 
+static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	u8 data[8] = { 0xfe, 0x06, 0, 0, 0, 0, 0, 0 };
+	struct sk_buff *skb;
+	int err;
+
+	memcpy(data + 2, bdaddr, 6);
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%ld)",
+			   PTR_ERR(skb));
+		return err;
+	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc22, sizeof(data), data, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "Changing device address failed (%d)", err);
+		return err;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -1500,6 +1528,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 {
 	struct hci_dev *hdev;
 	struct btnxpuart_dev *nxpdev;
+	bdaddr_t ba = {0};
 
 	nxpdev = devm_kzalloc(&serdev->dev, sizeof(*nxpdev), GFP_KERNEL);
 	if (!nxpdev)
@@ -1547,8 +1576,16 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->send  = nxp_enqueue;
 	hdev->hw_error = nxp_hw_err;
 	hdev->shutdown = nxp_shutdown;
+	hdev->set_bdaddr = nxp_set_bdaddr;
+
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
+	device_property_read_u8_array(&nxpdev->serdev->dev,
+				      "local-bd-address",
+				      (u8 *)&ba, sizeof(ba));
+	if (bacmp(&ba, BDADDR_ANY))
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		goto probe_fail;
-- 
2.25.1

