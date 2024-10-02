Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2076.outbound.protection.outlook.com [40.107.247.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FDB1D0B8B
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878449; cv=fail; b=FYQLboHgWfTxKCWSXyEdamvGaut5ODEWRKWvPAyv0s4NLoSSXkGrror3qcmpU/S0FV/2pzGjvV+2o4TZVcyQm4DWPOuNTCRuLek3wrFmIt4fUp3eXTeHxuEoX953v3JKseO0Gw4gRW6ZJZe7z/bn6zrHAY6MzsSNd6U7Q9kG5ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878449; c=relaxed/simple;
	bh=BFB01X2CwPElqIETDOudubnDwEMe3W506W6X8nseTOo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Kg4D18Qow+ydPQcyMmJJWFaTco0huUDcev3NBYVSdL8kafXxwwr2MtnChOau161a8mafudoOMyPN9WEIsT8he1Hg/Og8nHf9G9Rwt952iIhDr+KGmcsssDHI8peToLE4neK+S3MdMGguwTmLKI3SlhNbpXF/KZTnx2+DhJ5Hc64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jS8Q3KnH; arc=fail smtp.client-ip=40.107.247.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jS8Q3KnH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDL6unZba9B6zz7GS6oCHhkZJl+OKGGKOeqZi1QVQh4steoh6DID/EietWFguooDe9O5vRaHpCT0jncDfwZlVEmVXi+RhuEMcJ56MCP41w5iVm0kmj2nIhtiKb+f/bPPy2gEK979KEPBB+nuiGOdqpj8YbXh4XKLkPR0Wly3fWEOZfomNL+SjyiKr/ilOoU9LzGpNuIN/UaXBXjHRDhfdkWJjSFfGBAe4ZbdrExWVwKbSbxkhcHZaAZfFOCDK2o75I99bWHyOMCClS9NWM2wThxEG/641LxWA1rkD3/JYr2MJMqcAdnyjQ7uy0qhyQc4prZeQ7JhtMlCl1FmHUHQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVTiaHOTCPvmhOs8bnvTbzuyBusSST8hT+ILF06OBao=;
 b=dJxImFQzVjSNk0l5jc2dH8+zCW5kRW4/8G+klrAXHzW4w4vDtrvkYWTr0gH02OKn9rZQYvDXhst1gDnbhnBtH+mzF8dI0i8qh+d9PwAfG6iWbrlXvpn/c9+YMFO2HgVd/91e4oh5EjR5WWYWrtMBr/ijnxGcRF2pUFpdwvSa9LtLiZqrfzJtHTSShkHUWTacEvLxuh0q8E0+tYNRW00AK0my9YscRTCNAE6rd4l7xI5ekFMuNu/0fAVym5wzUeA3TBsygEWyGwvNBorkF0MsHF9Ft+ZTpc7opGcHfShAszGnRfGcOABmBGvtam2dt9KTGhkY+DX4spmYUcvYjDmg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVTiaHOTCPvmhOs8bnvTbzuyBusSST8hT+ILF06OBao=;
 b=jS8Q3KnHgH3QrMNo0Wnp/DVgVcccFqcLRhX3quJQjas+brTEolkNzeGXWeQ/NvVlq4kdII4rhr0/nEcfhWG8kCM/as3ZX3ESYGSVhVtlXq+W/mthS7pahA4OnjmcupHkxnTM6r/N/JQiWadconCRN1qYp6DOf2GKN571GWLfweo2XGviYZeMw6aoky7kM7V7i4zfFtJ/bWOUPs+H9XKbYowk83kmOzdH1TBE5/Ko9P98STmjSI51nFoGP5blkR0l2DllOQlIcEBy+19AX7jBRdH21chvlxus2MVCbtxJ+qQyMbBdymPm/OIWUM7CZ5Nzuedmad+F0FIh5+b5xSokwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB8400.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 14:14:04 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8026.014; Wed, 2 Oct 2024
 14:14:04 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] client: Add Broadcast Assistant/Scan Delegator scripts
Date: Wed,  2 Oct 2024 17:13:44 +0300
Message-ID: <20241002141345.27931-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0056.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: faa412c8-c0c4-4f84-2b21-08dce2ec78af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AR0o6kJv3ocOfPxvUR6JU7Kzt+EQDE9SBWDvszSoM2+nhAHUzEcjH0c4AsRs?=
 =?us-ascii?Q?IWZFfQ84GxFFXzXkSm8qywkFmB3iBCPXmbScSfuRpnVBr1oFh5Vj5V2DQweQ?=
 =?us-ascii?Q?z+7qmoJxOuEb6DbX5PfQ0NFqQP4pmEE8/iTf6AgrZVyVjY/I5zAthX3bgMpN?=
 =?us-ascii?Q?ZIgCh0tfUqratwXAkvxuIboKSumvc305WOTq16v4IpXCinLrpyzkwhLZGqh/?=
 =?us-ascii?Q?YJIOo24Z+kV6jQsGkLTz8jeFBFEXkFAdI/sCzXhxhI1RgFrLGbFnPfmv2gyV?=
 =?us-ascii?Q?415aX2MTlL2vogpKgaPz18pV0bmiZlnnzkYXGafGopPMMG+TMe4yxfwruw6U?=
 =?us-ascii?Q?HEMUILB+02paV6izjtn2TRDzuHEUDDD0LpRKJIwW6fW94vQnGF9WgCyLJ4NC?=
 =?us-ascii?Q?rP6IqQVfsCfxeS1/DX+TGjU77+zSote7RXossACyPBf7irFX5H9K6kFDOhAE?=
 =?us-ascii?Q?yElIXR4wdPK8hcQ5cXq0yHpZUP9Sdis/23LIGwd02IY+dnrJhYN8lgskqNvp?=
 =?us-ascii?Q?LNVEbG9Ywv4vhhNeMPJtp0yX1G51MKcKxhmUdZFDUiJNKCTRNgUI3JtdF2ig?=
 =?us-ascii?Q?2tNWxFXa8RhlFOiFgmP0lWldQ+t7WfE5osaYwCaLGVsf6UJtbutl7LKjxF01?=
 =?us-ascii?Q?ntGokaRlHnuXnj2rtkzTq3dDkoYQfgwWVFN3C+xQPzFtPkAnPPbeaFpjp2rP?=
 =?us-ascii?Q?ZaUKsg3tdGoEyEFRkIZUWycwdqaTa9Nj246t3MZvWxr2akBsLDTYrGpPtWfZ?=
 =?us-ascii?Q?+e4D8pZWZ2RrZZv7WBXcUg0DPIE5OD4RdSQJabjpXMqc5/eZaXJpt12WkBFj?=
 =?us-ascii?Q?X0Usxu4G5mueLx9MIv1wxaEt2I1xg6YBgcacBcQMDxUsvkOm579qIdJKYf3d?=
 =?us-ascii?Q?sEPKDj5PiBqE015gVoKjneGcXQznGq+5ngY1np43Co0eJ1zlWte8+ZaD4HeP?=
 =?us-ascii?Q?8z7ZFFnrmycaTlPYtueNRoEC6JC1xkGH3x21pJuvn22JQjVHIva5WSUsPj2f?=
 =?us-ascii?Q?oTbHOSMGlpITVORuhHltHlTPfi/qEc9ImetrxoNo0A8Oxu6jpO8AdpO0WUTb?=
 =?us-ascii?Q?IrFK9jAPpsnRiMXNdyckU6ZZofzNUHElrwws69IsRLK5qs/TlF6WC8lalMug?=
 =?us-ascii?Q?DQ7F3lYZirc7A8qvHakuTa8sASbS3t0aUAduzm3BK987vCWEC4rQNHboWtvw?=
 =?us-ascii?Q?3CtSHNq3h8+myIHFoCNA5U1ULGwHtrmp9avsRyC522I+xtkixQi/Bglc1CQa?=
 =?us-ascii?Q?81KLcho/Yr5Ql5GMU/2I1RmSynPzXBIbzPPJfjELL5TqQutW5H8iyuFE6PvR?=
 =?us-ascii?Q?WG5e/bpVAXrSzuC3z4VaIshxYgE2AKT467WCaa/1Ize4xg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iaW1fTfSF0b2krjTg545dhOssh2idUVluwpXJWGcd5GeISfAnNm5od9a2apB?=
 =?us-ascii?Q?0+v2D9zxTkl98CMd2xfRBSqMGR/l3sDGTlfbDta9+hFzZ1rb3fjTaXNeY407?=
 =?us-ascii?Q?uoxiEvUV27bcPVYBF6N1SroxsoGHr0wm/y4PzE9lPGZJXzGNj73TdvO+/aAk?=
 =?us-ascii?Q?uiuPO2M7bcAe7dmcBc1AsVD4JN61QLxGu6VahDHmzvA1beyvp2MUdwQwdact?=
 =?us-ascii?Q?YYs+JzM2c4MUo1kWXIi9Ph5ch8viBIzqrUvwXzefKrVYyvZxbxY5H5SR2CIu?=
 =?us-ascii?Q?pa0TDq1UjAgyx16M/p8ES5RBIY3tXURXQeyPIRjXFBnGenUyvcKGLIxAo/3S?=
 =?us-ascii?Q?BE/myOmwNu1UghMVpLwFeE7IJAq+8M0cc4dtsduWOw/v4BUX4Cst0nrjPDIp?=
 =?us-ascii?Q?0qiRzpFgMSzWN7p6nWPyA/DObrquXbbbeRyE/JqcLgcowOpM9M/vh3RLOuF4?=
 =?us-ascii?Q?wlYhI/WrgAEz780QmWq7F3GYRK9DS07YbRtRHlYmArmD16+F2chL/znKHmBR?=
 =?us-ascii?Q?//dsh3PbgjKPeM7bIhtqC+jgeBbuOKK8WQtgtWQ4UEhUfreLVoc7thwEWUej?=
 =?us-ascii?Q?v9jFPCmLB/Ri/BcVzhqB78U91+RkNZL1hv6LA/QM1baIBRKmE+O/OnDVU2mJ?=
 =?us-ascii?Q?0AFRAhq/vrF/DTSQW47jBiY7llaQdBOPWV2x3hRW13MwpuGuPdXjTjXa5leb?=
 =?us-ascii?Q?pyKmLmu3238Tlv+prqEIr6yUg9gQSR5ADXFWe+wSkxFKpx1lZNe5vhS+hAos?=
 =?us-ascii?Q?ERX2JVKmNl11RwUZcxuKZHjBBipQdnixbWg2eSOSw+OPkuyYEKQ7Kl7Uuzmm?=
 =?us-ascii?Q?iDwergYMDwroSEVWr8UXGVZPhuvR9Zd02vrK/Hqasg5cOjasDauZaN6oBFzI?=
 =?us-ascii?Q?J4a1RbX95bRvudtmx1jzI9qLvw6CtqIyY5QFok4ijvLGME/W0cNrcsa+DOUv?=
 =?us-ascii?Q?cp7cJNYlmxef3gxBP/3LoznytYEABYZa4Tqe8Vi4bt1jW4IkxcWns6RK8qpI?=
 =?us-ascii?Q?g+39Inflj3yjaP9+dvgWfK3eurPPyhhShooI/8mfP4IdfQSa6j2f1iwACH9B?=
 =?us-ascii?Q?k1KjFCVZPsbGRsU6epr4e4uxIYYLkCSuFJmOQNO6gSvPgzSS+BnV9rUTdp6o?=
 =?us-ascii?Q?Hm+FAIvjEpzKDFDD3TCi0KM4jtTNM5tTcQ1vbWNw7VHjGetx/O0o5ffjYSbJ?=
 =?us-ascii?Q?/WK93qrY7CO1ARoTTMr2c2rjnKmYuX9/f/4t6/M2Tncvr1jT4roKN19xICYP?=
 =?us-ascii?Q?R5TXavXorMZwOeWw7vP28x6l6R8Ix922VuGNLb+Nc+eaFHQCXcz2m4eOOhaw?=
 =?us-ascii?Q?d5AShJ5rwhjraPy17+SJPmjGi0mA1uPnFTbKH3IYoYpCumkuVirM/RNyn4Gx?=
 =?us-ascii?Q?mJ6+PL4f6wX1rmNZ0AIqio11eSoPfOtBGi3OafYGIj0LBROmMB/dPLGtwy1P?=
 =?us-ascii?Q?oPIeKSmYGqyhMr0xczofc1TvLF9LtE2xpWtXw4VKpVrgOVeCOxADCOlTLVSP?=
 =?us-ascii?Q?3anHRegj+rMirGN2GbBD9S4DRHNo/bpasKJweGbEtm3I4xI6VGHZXhpfu0Nv?=
 =?us-ascii?Q?glKu/LKNRzNuWP7/WuiXUKyaqiP4nKRvUgehnrdAufDEFZAzf0zPyoe24hUf?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa412c8-c0c4-4f84-2b21-08dce2ec78af
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:14:04.6402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeIb3dtNbiNKMn1lTwdRAR3eUc/+e5ai5L24G4Tw4V61u8+GkDtzaGO2T1M+d2fUQLU+rRwCrYmvwtjXKvHvjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8400

This adds sample bluetoothctl scripts for the Broadcast
Assistant/Scan Delegator scenarios.

A test setup can be created using these 2 scripts and the
broadcast-source.bt script: The Broadcast Assistant connects
to the Scan Delegator and sends information about a broadcast
stream.

Iulia Tanasescu (1):
  client: Add Broadcast Assistant/Scan Delegator scripts

 client/scripts/broadcast-assistant.bt | 38 +++++++++++++++++++++++++++
 client/scripts/scan-delegator.bt      | 28 ++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 client/scripts/broadcast-assistant.bt
 create mode 100644 client/scripts/scan-delegator.bt


base-commit: 38734e02051364b4b6db6e684beda8c47a1ba452
-- 
2.43.0

