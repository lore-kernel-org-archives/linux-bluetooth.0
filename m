Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0B418DB0D;
	Thu,  3 Jul 2025 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549047; cv=fail; b=XFFXT5uyj+j9Fj4PK3zDEwOFByQMCbH7kC9V5tr3Maufq4Bw3VSeUik09THJO4IM15vZtHeoGvzLzsabr8hv+La+CZU3J4WhCm9WdDvs+i9kcRhFgyc+C+ILQlaJhyF3p2hhLK4vFccD7qaisC0cPbgMCk23SX9HcCeqLmaVDL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549047; c=relaxed/simple;
	bh=8lns0L44Y9UYBkaqbdM4V8uBtBjVNWBZ8yOOLAfNmGI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E4Mjj9+TMW/7cXCzDWRwYmfh4CWTcdj7sGFQdiGd4VvmYcCF00/wWkEFTuLOhQ25/pVmmSeHzXTzPTtEBknWnTGlBZbtO03uXI1mgtYxlsezSOv+F7JL53FVhl5JrGZ4a80V6B6dRMZ00sttgNuIYaDjowBff43J9/oeE+tF5Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JEIYV50t; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JEIYV50t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIqGbLSc+NRAgzpGLJO3ka4TkdKHT7ta2SP7u/yTJuKl3vAM9A7u4rNt+YGPO5Jfz/wPuPduBMB2MD9RJ0e1L79ki6U7GMPjIfqHrBWfFZUsko8Btb6JWaJCAwxwaMureUak1AgdzAgfW0ixw3DuAuzkXUihtaBHmC0hmIk572iUsXXxGIy+JkByopJIXX8Yxbth6YPVLEOtxGDeTJmrqBgQw9ZhERk0JdBHgLmeI4hVqHxYCVe9/5CeAE3mtT79iceAiI62rQKrYRrsP0fwKWVQ1v87DI0yynE+qpg/3ltpqbc2Iz5/CpfGGNja39Xjiql//5BV8/quPznsArsdsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxiVz8W/dG/C1nkA4LUFTdOCj0QC+pphrTe4IVhtV3A=;
 b=B5ntpglPy/dof+9LWro28eJA0PXY1QbKvJqmvWRO6Iy5aUiEnkdyBwcTSf5NYCDKt+SKWDPt+ITYFY/1tJDWzgjmOXdLqpeeztEuqmPkd5DuSYA2G2ySPskopwdcH9tzH2zfyvpkIH3WKVhNxEZJTimX1v9YCuPfZCERFRvlI+jEIkPj4qs0A7eHSgkDmei6jUd08Uc2QEAtg5GA8KNMQywirjye6jgURY2/GB5zbquJacPfH0fFc6UKAaCqu//nwHKiqshfjh2ma7NmtHdshZpTqpAlawuN76VwNFmlncU2X8xnh1rYWiN3yAQyJNTklNahFgQOjayH5CyDNZ3hbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxiVz8W/dG/C1nkA4LUFTdOCj0QC+pphrTe4IVhtV3A=;
 b=JEIYV50t2xbub/xZcCSHPtNeiqd4viKyB/B008Zp1KsT889makWgMmysOOoJ2ptBkGU1J4Jj7nJsN0fH9MXUyCgRn1iYBRxtM+QTUt/Fx3eZdMZknbM3HUpweZAIYIFi7ErEq7tuhGtC0Zx6ngcJK7MnF9ErCYxiduCWN3ThWB6chMh7M8FtFvrjHRtd/FZPj7/Mf4IWh6VbQrJmqm+ep1S9F3/f972w/xMvO8FngT02YLve8F6qOllwl9XzncVlVFSCrgxNslqQVzkrSp3b++ezJ1rnSPLooBP92d0J6tOPwIhJdKZ3i0cyfOSXv4NVY9getSOTp5j/iyHyL+3wnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VI1PR04MB6896.eurprd04.prod.outlook.com (2603:10a6:803:12e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 13:24:02 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8901.018; Thu, 3 Jul 2025
 13:24:02 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	manjeet.gupta@nxp.com,
	jean-yves.salaun@nxp.com
Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Add uevents for FW dump and FW download complete
Date: Thu,  3 Jul 2025 18:35:49 +0530
Message-Id: <20250703130549.1659732-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703130549.1659732-1-neeraj.sanjaykale@nxp.com>
References: <20250703130549.1659732-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::16) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|VI1PR04MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bee76ca-ff7a-4694-9b0d-08ddba34e06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekJoOG44dGdyRFBZWEl0cGtDZjNmZ1lTU2VkZTF2eWtSYlBadWxZUEVaWnlt?=
 =?utf-8?B?U1h3QkxwTGFCb1lLWkVUbE1RaTNiSGV2bk5nQlBPNldIdWxMSVlWVFpieUMx?=
 =?utf-8?B?c01NVXYxaXhTRlNwUzJzSzMya1NMTUdVOTN1OEdoaEFXazR5MlZ3ZnZpOTNp?=
 =?utf-8?B?NjMyUGFpeDV3bE03bjArcTUzOTQ5bkRFNVgvT2dHRjNGT1BMejloQXJxNkVs?=
 =?utf-8?B?K0dJRys3cWVUZ1ZZWDNZSmprSGVRRGdxQ28xVXBLWmhxY1d2RGZaeWdrajgx?=
 =?utf-8?B?b1NVeURIaXgvNGprQkF0UCt2VHIxbFdPMmp3THZJVUNqeVYxSTFnUVozSlA5?=
 =?utf-8?B?alI4RFkyU0hLREFzSmdYZjNlM2RzR3l0emxrbDRQaUtQblV3Q3pHU3ViU01C?=
 =?utf-8?B?VERIVFdHTk1HWmp1K21qS2c1V0RCUTEvUUgzQXNVT0wya0EwNUhmQ1FXdTJW?=
 =?utf-8?B?VDBVTUx4OVRGZTEyZm5ISnJCaExpMHQraDV3SjM1a2NJMHcyTDRjUzl4N0hr?=
 =?utf-8?B?cWk4ZGFGeHM3Mjgyc2JYN0ExZ0JtRHdLTTY4ZHNWQUlKMmtGaGwvRm9OM1hx?=
 =?utf-8?B?c01VZXlCK2lqckRZVjE2RFVHZXVSWXF5ZGlMTEpOWFJWcWFmNm5BU1ZaTW56?=
 =?utf-8?B?SUNUOHJmMkhHUHpHQkk3VWR4YjVEWk9CTHdBK1VuWXJOeHdsUkt4cjNuWXdt?=
 =?utf-8?B?YkpZQk4vRXlCT0VtQjIxaXlzZm9pZFlyMDNMY25nTjhxQzVtUEtUNGlTMHJ4?=
 =?utf-8?B?ZElHQ1pldkdaVFdwaHZ3WnJycThRVkpIN2o3c0RBbWhJNGZzK0xMdW90angy?=
 =?utf-8?B?by9zT0p5MmV3OUZ3ajRLVHdrektXR1crSTNsRGxLZzAvKzZRSU1abFZYOW9n?=
 =?utf-8?B?RWtBNlRRNG9OajFHb3VzLzNkL3QwZ1ZoZ1V1MC9RY3F2cDRSYVdCdEdUb2lG?=
 =?utf-8?B?NlB3TXY4bXcvcHBZdHNvbzY5VGFtZFk4RllXNGluY2RSaFB4SkF3UTMxOCsy?=
 =?utf-8?B?Z1ZQb2xvckNFQ05SbDNuejd4Ri94RVhYVXFkVzBNUnBUYVBPK1VOVEN5akln?=
 =?utf-8?B?K0lQRHNNK2NqQkxtR1JJQ0dabldHOEI5aHpRTEZkSUVNZ21Pc01lSDd6R04r?=
 =?utf-8?B?K1MveDU4clVQRDA0Z3lBenljZUdZZHhPK001WFZSNzh0clE4TVQzcW5FU2I2?=
 =?utf-8?B?ZFJ5WVRJZUdKRHFGc1FPOVdaS2ZNL2ZYcStsbm5zYVlRcnM5aVNISzlQbnNs?=
 =?utf-8?B?SDJhRnBBU1U0RDhtN3lIemUzWWRRdzFIa2M0Yno2blFCcGlCdkVSVlRUVWFq?=
 =?utf-8?B?LzBFWGJLNEpBcWNoVnBWMkgzdlRMa2hhUm1Dc0N3Y0xTSUFTUkh3by9iUjZ4?=
 =?utf-8?B?VXhTcDdjWkRBQ3o2MlBDS3pwOGVWMkxaRHVQSDRDS1FLbHpmaEw5UHlVOHJs?=
 =?utf-8?B?NUJvK09lVGRTRDJaUnU2U0oyVHg0Q0VCeGMxdDV2QkFhSWN0K1ZjK2ljUDhm?=
 =?utf-8?B?RVFVb2xkYkVEcC9UZ002YmdDTUNKSTkyR3loR2NmczdPV0ZtdUtFY0FrVDFp?=
 =?utf-8?B?dTBmN1lJL1RYUkE4aEluVC9YU1BOVG9RUGpDN2ptQ3JHdjliWTQyVHF4SmJk?=
 =?utf-8?B?dm9reU9WaG5DeGExNSs5aFZiZjBNMGJmNWRkcmZ2U2JSeTEwMUtaaXZBOUF3?=
 =?utf-8?B?N1FWbVFPOEp6Q1hnNGdaMmQra2JEV0xHdWdLamlVcjBsNFFOMjc2MlZqMFFH?=
 =?utf-8?B?OCtWeDg0TVdCT29PcWxnWUhtL0dCVjY2bExncXkrTG9XU29wZERvaVlmVVpm?=
 =?utf-8?B?T2NRR082Z2FxL1RETHdob1liM0E4bDhtT09VZXlYc0pQWUJPbGxhd2M5bHB0?=
 =?utf-8?B?dm4vTCtQWW5NOHVMNUgwSHJhUUtSOEd3V0p0R1ZFdXljaUF0R3lkamc4SVRX?=
 =?utf-8?B?T1UxREd2bWdidnNOVUxOYlE2RWtxSnRXdlZxbkd3OU5zRVdBME1ld3pOc3Ft?=
 =?utf-8?B?OWlicEpVcE5BPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVhXTU96YWphK1Y4MzE3QXp4T2FYYXVVWHN1Uy90QXJXYTF1Q0lDelJrYjRZ?=
 =?utf-8?B?MlpNWHRsWkZpS3FjWERDQnVZcy90RERiZG5nbEQ5OGNWbjl2d3lLYy9aTy9a?=
 =?utf-8?B?SVlRcWpLTzk5OCtZRWx4YXJudk1qaTE4VXdaNXZGaXp0MWp5QTNGQjQ3cGgz?=
 =?utf-8?B?c3B4dGZ0UytNMWlORUllcjBneGx3Q20vNWJRZ0Z4UVozK3NDSExaT3V4UzJ0?=
 =?utf-8?B?UE5xSEFyTE9EQzZ6YVVFcDU0U0ZNcTZnRHhiV2RWeDlEVTRnNjcxeDFjWEpJ?=
 =?utf-8?B?STJweHBPSXk3b2IyZ3hFb1pIdUlPNnM1dzB4VnBDSU81VGlzYkVLMVJjSWNy?=
 =?utf-8?B?TDdWSHQ2ZzVSOXFKWXNaZ3lwSUw1T1psVWozU1hYNHdOTlNoYkZjTG00RjZx?=
 =?utf-8?B?OFVIWEQzdENHbkl4N28yV2VLYmd3TUtCWUpMT3pFb2M5Q2MraG95eEl5V1Y0?=
 =?utf-8?B?R0pXT2pueHlDSmIzMWdHWTdOaFE3Qkc2aVFteHg0M1FaREMxNnNMWWNzTG41?=
 =?utf-8?B?aXJxd2NZeU05VnozQjJYMHZkZEdGdzVRMDEwQnMwMDljMlptN2NpbFdDREtw?=
 =?utf-8?B?bzJhVEU4Smw5WFk0WWU0NFRSUzE5WTgrenBRZ3NWWU5obHNDTlV1a3NTYXpY?=
 =?utf-8?B?QUx6My9VSGc1QWRIMU8wTzZGZmczYVdUaTNEeG5LUUg0Z083V0l6eWU0K3Rt?=
 =?utf-8?B?NjBUWENXK3h2cEF3YkFYUHRsMU8rWXlWVjZIODRYTC85SzNEVXFrZGVyUWhy?=
 =?utf-8?B?UEl6T3VJUzFEVXMzdHBTa2lERzdVdXZHN3J3YWZhOGk2ZXFmeEFqdWJhL0w0?=
 =?utf-8?B?cnhDaUdXbFNERmVHUm5yZFR1Rk4xUVFyckl0ZFNETlBKZHFYRnUyRkdBQit4?=
 =?utf-8?B?QW5jZGIxOUw5Q0k4VytBRGJweStaQUQwTUNDMzBJNVNvRHRha3VXNlJTUkVt?=
 =?utf-8?B?LzI3ZzY4eEx3QnJqOEtKWEJ1cGlIbGpYVHNRc2YvMndxZWRraFprUVU5UWU5?=
 =?utf-8?B?QlU2K2dhNjNORWNtRkpGQVF1Nis5YmJob1Q2b0grelNTQnMwcUQ4Q0xDWkhJ?=
 =?utf-8?B?d1UyWWJ6QjFhbFpkNUtDZXlsR0FnU0ZxZW1WUnZSZ0E1N3hQMWdSVThwT3hm?=
 =?utf-8?B?NXdhQ2F2dzZ0MDBPZU1uRk5JMXIxcU5TRjZGcldwL1I1cVplL2ZJdXBtN1Ja?=
 =?utf-8?B?SldTVWxKMUVTdXM1SEFtMDdVNjlYaE5MV0JhczF6MW9rWTVlNzR3UHlFOFFC?=
 =?utf-8?B?RTFKczh3RDFzZjNaUXpnbEhiVE0yQ3cyNkxtVzNRRXk0dDJHRU1RYm9sM3Ry?=
 =?utf-8?B?aGtyVU9uSVFGT3N5MURZU3YyQythaXJvYW9HOVRTSHBoUkhLdjFjOGZ1QXlF?=
 =?utf-8?B?NDY0TlJ6aHJFUzBMb0c3dTlTM3RNNnMyTUdBS1ZYSnEvQVdicXF5VXVJclZ2?=
 =?utf-8?B?UGRwQzVWNVZOa3Y5VEF3WjNlbTdReDBGbWNmWEh1MGpUZ0VpKzRidTBjdzBj?=
 =?utf-8?B?dmxjeVkzTHNyK1RGSVI2Njdtc1AwdThTcTZBWHVkYkxKT0QvdE9veWFUOEVU?=
 =?utf-8?B?RUhxZnJ2V2dQenpvbkQzMThGSURIb0JsYlNMeUJSZHI2dCtzM0pxRFNreWVU?=
 =?utf-8?B?ZFlCRlk4d094TnNEWUZpWmRjeGlxaHpWL1FGYjlENlFXSzNhWHdBT3hDblpm?=
 =?utf-8?B?cU1aaXUzMlVpaUpUZW51dGhkL3A2YjhQVElRTHJyYTVmZmVJYWZIbng3Yko3?=
 =?utf-8?B?SkVzaWFSRURzVW5MWFBMeGVydTFjeHBJdkpFTmQ4dU5Uc2FiaFVtbTVmYzFZ?=
 =?utf-8?B?VmY2b0UrWG5yL2pQSmptUHUvZnIxZGZ3RjJaaUZ0dGRpbDVVRGdZTWRxOTlW?=
 =?utf-8?B?Nm1EOVYxb0k3R0RuQitvckdWaFdkTVdSc0g1R0RNMGRRYnpKcGduN1crQUo5?=
 =?utf-8?B?S0JvQnFBQkdYazdocUJDMmc2ejFBOEpxeHdvcXh3SHpudzZ4MWZuNnJMaFV5?=
 =?utf-8?B?YnFTSjQvdlMzRi9MNjlTMzhMdmN1dWVYL3RYRjF5M0JIWVhQdDV5Znk0MVdJ?=
 =?utf-8?B?WmlCYzJ1bDBZUlowNWdnUG5sWVB2ZllLOERxdlBjdlU0WFlpUE9FVUdacitk?=
 =?utf-8?B?Zm5aVExDZW1udkprUGJWUWlhdjB3NGI5OUdjSFlJdjEzTUNaZklYZUtuQ25h?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bee76ca-ff7a-4694-9b0d-08ddba34e06f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 13:24:02.7040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNOdErYU3Wcgn3HRqPrFcXOYk6FnSCJkG0pC7l7kIqe2GLm0fl603/fJlXBWPq9wENXjf7yNhJnLPUtSuRPfn84Wp3ox0qOWCxN/0gO2fnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6896

This adds uevents which will be generated whenever FW dump is triggered,
FW dump is complete and FW (re)download is done.

This feature is needed for IW612 chipset, which is a tri-radio chipset,
where WLAN runs on CPU1 and BT and Zigbee runs on CPU2.

Currently, whenever BT FW crashes, and FW dump is in progress, there is
no way for 15.4 application to know that CPU2 is in bad state, and when
it will be recovered.

With the help of these uevents and udev rules, the 15.4 app, or any
userspace application can be alerted whenever CPU2 goes in bad state and
recoveres after BTNXPUART reloads the firmware.

[  334.255154] Bluetooth: hci0: ==== Start FW dump ===
[  334.261003] Bluetooth: hci0: ==== Send uevent: BTNXPUART_DEV=serial0-0:BTNXPUART_STATE=FW_DUMP_ACTIVE ===
[  351.486048] Bluetooth: hci0: ==== FW dump complete ===
[  351.491356] Bluetooth: hci0: ==== Send uevent: BTNXPUART_DEV=serial0-0:BTNXPUART_STATE=FW_DUMP_DONE ===
[  352.028974] Bluetooth: hci0: ChipID: 7601, Version: 0
[  352.034490] Bluetooth: hci0: Request Firmware: nxp/uartspi_n61x_v1.bin.se
[  353.979977] Bluetooth: hci0: FW Download Complete: 417064 bytes
[  355.197222] Bluetooth: hci0: ==== Send uevent: BTNXPUART_DEV=serial0-0:BTNXPUART_STATE=FW_READY ===

Tested this change by creating a simple udev rule to store the
BTNXPUART_STATE value in a ~/<BTNXPUART_DEV>/state file, and running
15.4 traffic.

The 15.4 packets were sent over SPI only when BTNXPUART_STATE was
FW_READY.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Tested-by: Jean-Yves Salaün <jean-yves.salaun@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index f40794be2d89..c16ff72c9948 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1434,6 +1434,10 @@ static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 static int nxp_setup(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct serdev_device *serdev = nxpdev->serdev;
+	char device_string[30];
+	char event_string[50];
+	char *envp[] = {device_string, event_string, NULL};
 	int err = 0;
 
 	if (nxp_check_boot_sign(nxpdev)) {
@@ -1446,6 +1450,11 @@ static int nxp_setup(struct hci_dev *hdev)
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 	}
 
+	snprintf(device_string, 30, "BTNXPUART_DEV=%s", dev_name(&serdev->dev));
+	snprintf(event_string, 50, "BTNXPUART_STATE=FW_READY");
+	bt_dev_dbg(hdev, "==== Send uevent: %s:%s ===", device_string, event_string);
+	kobject_uevent_env(&serdev->dev.kobj, KOBJ_CHANGE, envp);
+
 	serdev_device_set_baudrate(nxpdev->serdev, nxpdev->fw_init_baudrate);
 	nxpdev->current_baudrate = nxpdev->fw_init_baudrate;
 
@@ -1766,6 +1775,33 @@ static const struct serdev_device_ops btnxpuart_client_ops = {
 	.write_wakeup = btnxpuart_write_wakeup,
 };
 
+static void nxp_coredump_notify(struct hci_dev *hdev, int state)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct serdev_device *serdev = nxpdev->serdev;
+	char device_string[30];
+	char event_string[50];
+	char *envp[] = {device_string, event_string, NULL};
+
+	snprintf(device_string, 30, "BTNXPUART_DEV=%s", dev_name(&serdev->dev));
+	switch (state) {
+	case HCI_DEVCOREDUMP_ACTIVE:
+		snprintf(event_string, 50, "BTNXPUART_STATE=FW_DUMP_ACTIVE");
+		break;
+	case HCI_DEVCOREDUMP_DONE:
+		snprintf(event_string, 50, "BTNXPUART_STATE=FW_DUMP_DONE");
+		break;
+	case HCI_DEVCOREDUMP_TIMEOUT:
+		snprintf(event_string, 50, "BTNXPUART_STATE=FW_DUMP_TIMEOUT");
+		break;
+	default:
+		snprintf(event_string, 50, "BTNXPUART_STATE=FW_DUMP_STATE_%d", state);
+		break;
+	}
+	bt_dev_dbg(hdev, "==== Send uevent: %s:%s ===", device_string, event_string);
+	kobject_uevent_env(&serdev->dev.kobj, KOBJ_CHANGE, envp);
+}
+
 static int nxp_serdev_probe(struct serdev_device *serdev)
 {
 	struct hci_dev *hdev;
@@ -1849,7 +1885,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	if (ps_setup(hdev))
 		goto probe_fail;
 
-	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr, NULL);
+	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr, nxp_coredump_notify);
 
 	return 0;
 
-- 
2.34.1

