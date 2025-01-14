Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2058.outbound.protection.outlook.com [40.107.22.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7CF1C4617;
	Tue, 14 Jan 2025 10:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736851186; cv=fail; b=jknZ0bxMortCw4j9jzDxxaQZ3UMBPJhSbARJoHI9syHeuFeVbst9968qaB3IG8lX82baCJrzsjjNTR7FjliitYiyajfpMUz5YYCtJz67Tt0wO9EY85tsutK8TydgoT2x/QoPFYvtc569uKyfC6RFPvdEKwGgk2mZ502sWRdQ0OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736851186; c=relaxed/simple;
	bh=qEwOgUuNtM3MeGJu+fGRwOdHtEdlmeqDutKE/H3W7xM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jC1BrVBslMSiEhwAFx/R8vJKiQVrhrTR3bhzIK9k5ROcEs2365hdf59SJ6vK3EiC3nMv6XPOB0yjoZ1nUi/QgfYG/Vd7Y7cEPxk6y1sWsMq0F3Z+FhH3+NLZdiL6EMmtKy/D9Uh36LXhgmG1KyeGekH+Jl+ISDBHM/N5pb8QF4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lGeb8pB/; arc=fail smtp.client-ip=40.107.22.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lGeb8pB/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eZuIgKvid6oP8UV2fQi8tmsnpN1aAUnAZlCLbAKk5n1yabie/FjEyxxfRwnLcPB493Z4EX1e0axFVfi4Hp1TTa0QEcztNryVSNPbBO3+XKWcp3rA1kO5X6hLqFY983xer/inzz9kD48PGhqWqOcvbZ1Wi2Z0FMl+BKzL+c0LE0UbjQZlPlpemAcFRNZnlAptkTuNkQ0r3TtctuuMrwzQqqw8YvqENS85fcn24a7GrCrMFk+Ns3raD2BdW1AA+gBGL6pNY6bUJ86QWChK6WidAkMn/LnnmPpDTrJ+T3k6lX7x9TqvZdsTGqfeHjQkZo04h+7ztY5dJjfSSyblkJEd2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3GfMA54z6RQBfAsc5L3IwjxdztoEiO/a87y148hXfw=;
 b=Yu99x3fE4UCpgsjdLoYtAh0CmF0AHS2e7stezN6WmOyRgEgLq0oPZO4VRRuJy192wEjOnjNYLGxskMXNNYktaiuS85HrZ6L+ou2LX55nsvY4ZY+z0uCcBEmOQmdpC420s+lbPPPG0dX+9wXRGAiZWJ0+Mcmzfg0xhMkV7PufQpL/8gJe8aphJ9EF9YdIuPOny7wgeFPtIM/NZyNgJstclFilt5hrZQkmNN2agU+aMeodELAJUqN4m3YiwxJoT0Y+uTLVoihhZaSDrXDVPenojjnyZsJCsGqAxgYFF5tOwJErze+zqwb0AchrRZJCmYtsLKbDIczIe+0EUNMvC1HEFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3GfMA54z6RQBfAsc5L3IwjxdztoEiO/a87y148hXfw=;
 b=lGeb8pB/E/g9+1Q1CZeJ+TVTm7u+oSveqsugWR2WDTrzWV4dVQXR1uifS4/zc069qSKuHSLqlT1prTSTWruAOlqhh3VV7ftrnwckMc5/QA00ES0atOPHRpz7uKg1wNscBpxIH+89BvZdVCRP6/KW0Ji6JMufJDCGGetrLA8tmwK7779Uu2oiAuowIHerkjKlpB3uKaeUUyNzdGZATdf1X3K9f72+6/YPIJ1OmrtkGDLrAzNUHmZrQTrI0lJPAdXUPsQ+E5K5VFsV/Lqy4GnGKb0PvVKNM4dRRDA7VxXPm7KpJXUseUtRo1vc7+ZGeDmoD5ynYis+QSTbZxL1YUkAZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GV1PR04MB10377.eurprd04.prod.outlook.com (2603:10a6:150:1d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 10:39:41 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 10:39:41 +0000
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
Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Add support for set BD address
Date: Tue, 14 Jan 2025 16:10:33 +0530
Message-Id: <20250114104033.2324297-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114104033.2324297-1-neeraj.sanjaykale@nxp.com>
References: <20250114104033.2324297-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0008.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::20)
 To AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|GV1PR04MB10377:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ff5e1f-694a-4d25-f26b-08dd3487c0a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHI2YmNNY3Z3K3dGdFk3REFzZ0wxWWhRalp1Z2FIcXRiTlVnVHVLWVRUWkRY?=
 =?utf-8?B?L01yWU5sSGdCUStIZHdOdG5QQURIWWMwWko4cy9YMTZBT0JjLzZWSWFNVEpH?=
 =?utf-8?B?a29OQmtxODZPVEpSbUJQNFp6enlIdUIzWUF2czdYc01tVjZJdkQ4MERtQ3dU?=
 =?utf-8?B?SE1lOWdEZ1I2aGhVTnFrOTRaZkJkYnFSNGhJR2JaMnNITitDL3V1SVZqeXBa?=
 =?utf-8?B?WGRqZ1dJVWVwU1dyR2NHUnF4QWsyWDM4eG16RHZJOVBLYUFWRm5hVVNQYjlF?=
 =?utf-8?B?aytxNFdCUTJGVm9TeHlzL29iSUJUNVNpSjdxeHhFb25vUm1OWG5Oc0xOL3Jy?=
 =?utf-8?B?eGQ0cU5Rc0RUL2h5a1JjVXkzSmFjaVF4cGI3VHEwN0o3YXhyalRLaFhOZng4?=
 =?utf-8?B?QXNNUldiUEd6cGNUbG9wNmM3UVhLRE1GWitpV25sdHRHV1ZReXFmc2lob1pl?=
 =?utf-8?B?OW9jd054dEx6ZnJsY0swdEFKb0dPM2xWYjBTWGFyT2NueUprTng5NWJaUXVh?=
 =?utf-8?B?THZKalE5UHRZOHBpaU54SlVPVXQ2L2FSYVRaNWdHMlZFTXB1cHBScFVKL24x?=
 =?utf-8?B?dE42U3dPdlArYTFXeFlVRnh5WVQzSnpFd3Jrd0Yvam5XRnFtQ3pkUjhDbkdu?=
 =?utf-8?B?YndINkRWSFF6YnFocS9KT2RFMm50THFLZkJ3SXFQaVpRRXpkTFJMdlEwR29G?=
 =?utf-8?B?ei9zVHVUdUNvWXNUWXZHdDJOdVQ1MEdBVU1vdkpGSGx1aFJuMzZXbDJhYm5l?=
 =?utf-8?B?RFZHYy9WdkRTRTRFTGhLT0pVVXN4ZjJFZzZxa1U5blZZWWZiUzZ5dEpIL0g0?=
 =?utf-8?B?azNFRzRzY3RHV2JDY2dtTTN4ZWZTbnV5aVZQL0YrblVGNld5R1BidlRoTC8y?=
 =?utf-8?B?TjlDWGQxMzFMeXUxY3ZLZUFOZUZNY25UTmFoeDIzQkphQkU2S29SaVZ3cHNn?=
 =?utf-8?B?dlZZdzJaVDN5THZDTHNEdjVDQkJpSnBKemZYenM3YjRHOXhCMHZOYm5xcmVS?=
 =?utf-8?B?cGluY3dFVWNBM21MSUE5RGhKeUh6V1haa2JoWjd5Mnd4SDMxMzc5QnIzOVI1?=
 =?utf-8?B?VW5nRG5pOWVkQnF3UWpaUlVZcWdXdmgwbityR1pYdy83ek9HZEwveGtmMEZ2?=
 =?utf-8?B?dGNBSmJHaGVKZVJtSVBlSERJcEhLd2dhTEV3aWp1MmNkczFBMnVJTkRrYjJX?=
 =?utf-8?B?cHJkRys1UUoyRTR3UHVJUWlDQ1hGU2dzWWo5SEcyUi9CWlBtelFYbmlCY1Ay?=
 =?utf-8?B?TFRxbWo0OExvMlBDL0xJYzRHV0QybWpsdkhPa2g2ajVRd3RCRURuR3lXUlRn?=
 =?utf-8?B?VXFkTXBPS0FJRUc5bGlNVUNSUTlzdit0VVBqa2RUN2JodjlhRGh4cUNaRS9L?=
 =?utf-8?B?c09tVkRTdWVpdStxK2xaUEN4SURBcXMvUUI1TEVseWNBY3g1VU1UQWs1STFz?=
 =?utf-8?B?ZGF3OUhtWitVYjh6REZFeWNVdEp2a21XODlPa3JxK3pZUHIxVlVTaWl1dGZ1?=
 =?utf-8?B?dG1GUmdROUJoNzJSaE5hby9CeGpPWmtZSUI3aDhwMXllMWk0b3VjYkQrUU1w?=
 =?utf-8?B?aHhDeHFzL1dlZk81NE5NN0tBL1JWakZhUmVreUQvMHh0T2lmajlvb0E3ZTYy?=
 =?utf-8?B?dnRreXQzRnljdUlaTWcvVjBHK3BPeDZOdzB3b3o4blFUMTNOMzkxSFYxdCtu?=
 =?utf-8?B?TnphMlpaUkFvTkxxSE15TWpBSnBPemVuTGh4OEo4TkpPZjRwQnUxdnBRVlFX?=
 =?utf-8?B?Wk1PVG50cGIxZGdZSUs3TGdxNmdZN1pBbUdhbjF5NVpNUmYwdHhOdXJ1ZFRM?=
 =?utf-8?B?MVdLMlZBV3UwRExZMXBWeWltUWtaYk5SWEZ4S3VWenZpK3g1dDdVTjZlUFo1?=
 =?utf-8?B?ZVNtOUQrRFJBZHZkUmtSS2ovNGFYVktLSlZVSTVNM3o2WDFVV0FPbGlxYVln?=
 =?utf-8?Q?M2+EJC6lKEIN3FKegWJxpyVJBJ1MU7+F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SVpGRVgvVGRRZ21SaGRWbU5hTlY3dzM5TXUwY3BNWkNmN1N5ZXRFS2ZtamlP?=
 =?utf-8?B?K0d3MDYzM0E0RTVLRlRtNUVUL1ZKcjl6cTVSd3dKWm1oNVoxb0tGSFBKcVpS?=
 =?utf-8?B?V2VkWWR0MktFeCtEQWg2QlR6RU1TbFRsSUN0YzFPQjBFSjdpTkhZVmtndGVx?=
 =?utf-8?B?TzRYMHpFYnBGKzVTTjhNOW9YT1kxVDVReGZuNHI1T0lEM1R5WFlQdnJnWXVT?=
 =?utf-8?B?TnZMaThVaHpsTjhCN1ZOWTFncjc0aGViUEE4N25GeWZoS3QwMkJrSEFpcHZz?=
 =?utf-8?B?c2VZcjJNeWZuL2pZQ0VRMVgzNjgwTDV3NDJKZHkxVGJRWTluU1FsMWJPYUgy?=
 =?utf-8?B?VUFwUTBCZnpXOWhhUjBNTy9NRWlqWUt1SGFoNFNxVE0rdGxhM0JqZE4xVzNa?=
 =?utf-8?B?TklBcUhhODU1QXc1d0gydVhsdXBtY1ZOQjZ2WmJWRDFUaHpPdm5PSFBVQXF0?=
 =?utf-8?B?VmJ3cHBlTllmdElyRWNUdTBpdTZkYW5nTkhxd25TaitiTCtYUTEwV3lWSHRt?=
 =?utf-8?B?eFJSK014bHExZEpna1dNaXp3NGJ5SGVwOC9BbjlqZHdFbnE0RnUwVEtmNzdJ?=
 =?utf-8?B?NXZYU3QyODdMMjd1WWx2K1FwcHQ0dHNuZHNBMzRQWEtIUnNZeTU2c0thdS9F?=
 =?utf-8?B?bXpxU0Y1cFRYclVmYTFNN0VkcTlWeHJVRGdjNElVeU5ZSERreFZpWVJhdWFk?=
 =?utf-8?B?QkpkRDRGOFZoY1pBY1lYc2xVVEozblJPZnVmQiswNndScSs2d0g0eldwOXJF?=
 =?utf-8?B?QmJiNVlvUXVDZDE0VkhHNE5tbHdhZTM2RUdNSkZJNk9EU3pZRGdMTkx5dFRR?=
 =?utf-8?B?aWhMNVhCTHhFOVUzQmtlVHpSNWEzTkM1QUhjMTVyNlo0ZW1IM25RdmgyS3hr?=
 =?utf-8?B?OXlOeG92elJYeWdQWnRYbW1LZzNlS1VZSzk0TXJvZk5OQVZKV1J3VDV6NlpN?=
 =?utf-8?B?NGIwK2RGWEdwN2pGZWJBbE8xUXB5RXlDUDAxd1FUUjNMdjRaWldVVEFVeE9h?=
 =?utf-8?B?WXVLNGlVelVSM3I0RVJrOVh5aEYrKzcrSTkzbzJWY3A0MEQ5cTdxWFhvdkFF?=
 =?utf-8?B?M0dHVmZjQmFpeXhpUklkWWdJU2g4cUJ0Qk5zc1ZwSEdDVlUzTzh3MFQ1Y3Y1?=
 =?utf-8?B?TVFxN2FxS1VZMGZFdnVrUEJ1bG9EaW1vbHhyZ0g4Z1BwT2dEbjVkNG9XcEJT?=
 =?utf-8?B?aXUrV0NWRzJvY3hoSTVuWlB6YXJRN2JuTGsxcU9zSjhQQ25uZmNFcExYRkI4?=
 =?utf-8?B?cEpoYU9VMXFicUh5SmQ2WVhteU1GSEt2QTFVSWVwM1d3NEhZZUNNRlRVOGZi?=
 =?utf-8?B?eDhORzNLaTUyZUwxQmk5WWwxdFJOYmd4UjNybkVORDFiRjVkdGJ6UXpGMFd6?=
 =?utf-8?B?Q1ZlMGwvSUZOeUpNbXFRMllzeVYxRWQvc0ovR2Yyei9qODcrS3I2a3l6eDF3?=
 =?utf-8?B?WGxpK0xRTm1ETW95dFRVMnJ5cVkvSHpWTHJwWHF2aWNlNENNbXl1U25ONG12?=
 =?utf-8?B?dDhxMUNMaGkyTzRSZlpPS3dLaGV5REsrYXN2VzNoSm1PTGxaQVZlUnZROHBh?=
 =?utf-8?B?YXlITzFnaFB3Z1Y5NHpadjJla29nVWlsZWtMOWVkZ2JXVFF2WG1pM09veUtD?=
 =?utf-8?B?S2p1MzNrZXBPN2VNN1BOMHdTRlhhWExDZTByaWxHbUY1WWN3WTdJQlBabzFM?=
 =?utf-8?B?bkRFK09tWHR0cU5NVC83dnE2Y1pwMUJvb2IzeFA1cGtja3cyWUN6cm5RYVVF?=
 =?utf-8?B?Ui9uNkFLVlJZbldMUE1TL1pCcTk4dXoxd0FZcUFUZXdMUy8wQ1ZsTU16NnU1?=
 =?utf-8?B?S2Z0YUdtWjQ0MnhqOEtFRWNnSWZvdXFJN3FWWmo1eFlZMG13dncvSXVVMUp0?=
 =?utf-8?B?T2JTV0pvSDZoeENCSEYzVkpJR09HazVLYXBKd3g4YVVaWG5FdWtOQXNMUWho?=
 =?utf-8?B?dU10RzByelVHSkgyRmZ6SUVTSVpveEtBOFo0ZytpUlFWcnQvcTFYcDVxSW9t?=
 =?utf-8?B?cG1BOWxTa1JKbFJnVmJxRTFEcUJrcFBVNmtkZmJWTzkrV1ZzdzZuL3ROaVdP?=
 =?utf-8?B?QzAzTUNYRi83MVdPdVl5YTFtdzNJMHdkSnBIdGhoSi9icjVybVVJK3pRZnBl?=
 =?utf-8?B?aFZEWDY4QmhXN3pEVEpIVmpwUEJNVVlOQm1BV0V2TnE5Q3V2c3dPT1kyOWhq?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ff5e1f-694a-4d25-f26b-08dd3487c0a0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 10:39:41.5221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k+fKvV+NLizMWgcvybjB1X42Q6cuptq0iOpemcBGZ8N8+57aotzdpAA7pqSIZh888LLGwQF9np01vjcsIJHNaVzPUpsnwgdZd2zD76C0MVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10377

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
 drivers/bluetooth/btnxpuart.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 1230045d78a5..deb546a4e664 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
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
@@ -1547,8 +1575,12 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->send  = nxp_enqueue;
 	hdev->hw_error = nxp_hw_err;
 	hdev->shutdown = nxp_shutdown;
+	hdev->set_bdaddr = nxp_set_bdaddr;
+
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
+	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		goto probe_fail;
-- 
2.25.1

