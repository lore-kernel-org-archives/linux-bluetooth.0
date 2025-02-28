Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013030.outbound.protection.outlook.com [52.101.67.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3F527293A
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740758233; cv=fail; b=G6j0OpyPGnN2MwLooo/Ljq7PwtTa4nwjl58Oj48l44zPUpJq9wP0aFLqE/+HJ4fVhj9zeRI0bx2cL5f7FufE3TYNJSvh/NrsMlpSeZd8tNF8HDIsbjbHUIbOY5eAvRNXGrO+itEmwIGMIdQ+9/Xa0qaSFo7Z+FgJwgXAUOaHb+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740758233; c=relaxed/simple;
	bh=oz7DrcEp3tGXvapJyE/OoEUdiTUgewdE4MO75aYqLao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rXttOEDWHbBX96xPE63BUVfLmIuMhbzl/F5CAOvAPcHGvdx3bekoqZwC3hpONGv+h1vJbVOXeHTCi88S7GliNnp51mwRpizG11KzhEqd0IOc59GzA6QD9UNPP7rslRIoc1ZAB6jL2AsDrY4yZ+QzkC1dqhHQJjZRKWb2pPiK3Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P6ji8q9v; arc=fail smtp.client-ip=52.101.67.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P6ji8q9v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hh2GiaNnO4RYi7A0ow+aojJHpvn1bHe9dhOf4PIleTPGQwsQCGTEf189EVm+eMDis131gqc8UDnSv28AX0YJyrvOSpIbmGZnYFD3aFH52BRsx4TIk//pUOhI+Lh2O/iv71lhvIjU0acmYQoCfc+Opqp8JEAJMEBBRh8xV5lfnckGbUHZw8Y83Ppwkm87hwHykIrg1zosBJlpERu3+aIT4uZCYqTvnvIyZYjE/qRmbmfgx5NOu/8PdDaGru2uJQlY/M8bYppS8NyyKKCBS+aY5RjiP1ePn3N5OOupjBGDxnkS+MoPRvQejezPAvo7MS+hQ4JcAVlkHB99W5TRxKP9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0blx4qU4oMSl8wfuKKrHuQzH5v+NNkE/oKMjnT+StL8=;
 b=ED8H/4UDZoEmXzHMzq6N1DV4uNz4rslEZtnTwbNcWHk+jEo9eqQw8m+SDes4rlWbQOkF44tfg1WpA13iJy3E5GDcWbMMjkgdqtiDI0E78YaGIxDZc0XvB896Gtj8oVgr8TBHsdMSyH76ptRHandTeHFYXQMXmSp9m6O+c9IP0Rem0L8dCXkYSVSIHaYLACCGiVOn4JLz/Rmg/MyzEC4RChGupek+Qb+8ffwH/fvLaybXawN1oSVnKQZElhwE+2IoQzc5d3BkuVz7WjW+Y8+sU+3BO5ffJ/T82JtLWDd0xaYn8w6yEDLHWTyh7ypYyaKz+Q0tdS4l3a92xvFQzwWRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0blx4qU4oMSl8wfuKKrHuQzH5v+NNkE/oKMjnT+StL8=;
 b=P6ji8q9vS3QE3gYhtGqaMtEdT2NgIKpjG5SAxSdJ1y+h074JUVeAhzFpCSErj+EOWUjBuUIRMKkPyJJvb9rmzp+XksEnWxo86xLmt7art5fIYljVx6fjWTC9zC8aNIR7+zaISHhXerrsYlRmxS3+nJth09C776w6s7ZSUe0zaBOu/38jjC1QnO+EtNzF26LBbnJs4tA1TdsWVYWxPvs8zRrbAIGxEBpEKC7Up+pNd8fWX+q0gjXT26d8UjxWtQlQdUf2PwaNGUquscOaHcH4OupSWroXeE5v4dyTE/TU5wXsRH3zO1LewQMNGWMFAbzu3e66DInT5U0S82ZDNWhptg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB9118.eurprd04.prod.outlook.com (2603:10a6:150:25::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Fri, 28 Feb
 2025 15:57:08 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 15:57:08 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/3] bass: Remove interface
Date: Fri, 28 Feb 2025 17:56:34 +0200
Message-ID: <20250228155634.57979-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228155634.57979-1-iulia.tanasescu@nxp.com>
References: <20250228155634.57979-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0121.eurprd04.prod.outlook.com
 (2603:10a6:208:55::26) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB9118:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ac964b-f251-4687-4ccb-08dd58108de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dEFdSajyDs/Bbl/oR/54G74vZuhX7/q6+7K6v0pYs3esU1lK56pYRoqgURS5?=
 =?us-ascii?Q?1xft2fulhzvf0yOKKXROq7nJcjkPsHVG9VyPExOTFgwHqtjsFECT6M1ARRNd?=
 =?us-ascii?Q?qWFp7WcW0qSLMGa7EhPF+w8GDrRD/KidVABhnZe2EQdaYc1W66UcuQR/7Ibj?=
 =?us-ascii?Q?KE7E06Joh7HpomsVwr/mgkXXioRjlQqMbLe85y3dcEuDc5jJrC4/rD9q2gEg?=
 =?us-ascii?Q?lkZgL1fYPgmAFk0gJJ/m1y1lWmd+cf9vGOOP1KWGuKPHmce52g/KvY/LLUbk?=
 =?us-ascii?Q?WWUMnA8vMacqJS9DDAAKOUKST7Fv5W30V9tN1fX5kv3MUBnkmihJr/Zl743s?=
 =?us-ascii?Q?MUqRpaJLJIUQuB4YR4P4V7/9TIU6TnfjrKp6UH83yH1yjlEHwfP1BRHKSEgi?=
 =?us-ascii?Q?N0EhP1VRfqmMPcM5/U3J+PJAR/sWZVD/AC6OrW7juExm1QrgfUU/VyxllY5z?=
 =?us-ascii?Q?RYukceGDoTRzJnobikFKexRE7Hbuq6Y6F8HO35ZgKd72OlP/nZjwEtedFc1e?=
 =?us-ascii?Q?mYyRHMRauZDefjntKvlLp9nvss/YYjLKECf1l3MmAr7xdMbL8eKvbb4VQrIs?=
 =?us-ascii?Q?V5lneVifzjpDsFLxhDsn05NdILNrUQpNhP8AvyFVszli9nmP2DV+DGQViEo9?=
 =?us-ascii?Q?RK7lBOXLmYNI9/JwdjIXxJdInTfWpVvtJomrAgldaYfqIl1YjT7+lZ+awnyF?=
 =?us-ascii?Q?Vkz9R8NudR3Md07xWUfGMpnbSP68yKYK3ggGWjE85QxPw+vhughws0ot88W3?=
 =?us-ascii?Q?dSVvGvnXmNvUlnpu3iZHuOyxsAYjwOxAf4Tru88smXVEAp3L2eIzwIU5VwFT?=
 =?us-ascii?Q?lXWimmGSA2i9F8J+2YhGxSBBuzvYg0Eu8am4I37IlNbHb1S2kA2wG34czi7l?=
 =?us-ascii?Q?JsSNzuHE2ZXKEyTAM1KRvok/U/kwyGBvkiv5VX5riRx3jAscdOdIv38URcOJ?=
 =?us-ascii?Q?wuiAA8e1M7nQEHpTcEXZ6Cfi/wPKsW78rGlyuzkDRqOvG5Kh62uRo/VWDCrt?=
 =?us-ascii?Q?v+EXN9q86pKJzbsD8clWzP23W9zzfxDCCkk4iC/OiP3YIo05oP4D567mo+G6?=
 =?us-ascii?Q?lgvrNdRh8WH77VGvaWq+Rt6TB9VcBf7P+z4mtm/cQYsfi4tZUMkoV22Vih6q?=
 =?us-ascii?Q?xTI2UOaXMVTCNf54k9lgKnKmONqdrzI06zhUQ60IAUYJFQd3oFN48eoIX3CP?=
 =?us-ascii?Q?Vdg4FaYmPjS3Ht0TE5DsBITRe3gHX/CmSnnPBgJF1Mgwh0UEzw3BC+N8Ae+b?=
 =?us-ascii?Q?dZQeW1miAYHNO2M3pVgCmZPfY8PqDq9YLWaBlZdNi9DJ+U72DJt6qVPUdfS3?=
 =?us-ascii?Q?PKXMkqg6QFFYfo58sszAeOCsK/+MRAeGFNNptxEPoPqXEVnvSnrJrtcPD0nD?=
 =?us-ascii?Q?0hnf+kKMCOOrkFgitcbCt7p8doT3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+L1lNyp7ChSCOpc4oPj+9xbm0qO581Ah8rLDI+RmGagTgRuHKCA+V8ai4l0l?=
 =?us-ascii?Q?1zmAImrxyzCoSxbxaXpCIDRxXd8/fK37fuzELGaRY4GpdDm8y/dShnbspn9I?=
 =?us-ascii?Q?sW8FVgzpkQwLLf1uCuvdsu2L9bcNudXOQW3wPzakQeWH2yv99I9/9wz/6nr9?=
 =?us-ascii?Q?lRBef2BYceRrGBuaPw/IYv1HqFeCATb/KzlzZHP/mJfH7OvWJBevNhxAFsMp?=
 =?us-ascii?Q?OMNn7BUqIO6pWFyacG1b5lZ357h9erVOJ9caUgW51WwR7ofg9HEf2bRVAEe2?=
 =?us-ascii?Q?eu1MQUbGlMbAzjdj5nTiLirX7wfp0v0d2/AgdikX4mMSzmSOB3Qb6RGBpmX8?=
 =?us-ascii?Q?YMgKx7mjx1/TaP0WXFE9aoYEIiSTkCWeHsCs0dLPFfLoE+/0uUZ2oyRSCdtK?=
 =?us-ascii?Q?zOiOESsrUKT2WmKD7C5VNU+CLvvzoEYmIg7TgwFtHRDF8FYT4j+F11VuzTr4?=
 =?us-ascii?Q?ZezxeA6rDokfF5OysPkkmnevaybNrCiQBGYQPlZGc6tLWbmdjYcG7AEiGruV?=
 =?us-ascii?Q?3uaFLEqTf9ojerYayC9CTF0Wc+Lnij8UgJcb5bJNlcTqLjYw9g8XYsSRa8wz?=
 =?us-ascii?Q?On1qK+wjLQEjTt6MyiM4rxqBzOIPPyGju1aEIBTLJxDWl7lmA/MlJdu+w/qL?=
 =?us-ascii?Q?oHU6jNKeSVeGB6l+owLbvZpG/GufZZRXEFrbWDKDLmVKT3svPWl52eZ3oqiF?=
 =?us-ascii?Q?NKTOdvaI3/iHOLk9UUcFDxOk2MTWygt+teCR9FXkVzOE1MwrnIXZux2XAaDt?=
 =?us-ascii?Q?iJDWDpISr5ETKQkdkp+lPq1JX0sj3uTkzxRWQjweNBaEbfk4Bl/rPTBUIGtx?=
 =?us-ascii?Q?7o8yxDfyVFD1ZEDmNw1alUwSDK5ze/GQdv/HAq0PgT68eTpvB8WzIOUEFA7a?=
 =?us-ascii?Q?1/RRhyirMYZNs2ESMp5B1c3JBj6h0fOvvlb3MqHDGZW1oz/q8evCMBJLjuA8?=
 =?us-ascii?Q?0ty5EkxGoakOTQtBNOLQijHKnLnD2paMXVvSemuGMWEYaNYMjnuapmh8yj4b?=
 =?us-ascii?Q?SkfRoNcD+kuMdQmiiREn2Nby6EbePzqd+EKFzlZC/icnHI3F3Q4nMdWcXZxv?=
 =?us-ascii?Q?AP+ixXEE9d3dXzZqmcpRbn5k0CZWx/fr2snJHlyg3Ylar3WLa7OirIksdIDg?=
 =?us-ascii?Q?jf91W+nNVMVwW5lqjmCXASSPE70635Q3P2iu/b4OSZ826GfCk0YUkqMzy6Us?=
 =?us-ascii?Q?dTRm/jfD335FuMhyCLMZNxJ8JX/0F/a0o+Klxad/O0Y0TGFPmdH0KCf+eRLY?=
 =?us-ascii?Q?cVttpLwZcyn/mXFs7kYODwgjtbOE/qF6WQdjbINz1pCWETZ4aBNZvEMkfeOb?=
 =?us-ascii?Q?VXmpngFvm6jfN+FI5v5Kn0GjxMMVcQ++n0DtFupkIcrek8f53+LJ/pTzcah5?=
 =?us-ascii?Q?suqMAB6IzndLfhWnshXDazy/PStlWpTFywVnbpIFBjIOMgk63lP0A0SXjOLp?=
 =?us-ascii?Q?bhMDHSnttlCdrYGOD51Zoizvt5bFrh00kBfMRT0aSMzfqyF+Nh88abah84z/?=
 =?us-ascii?Q?FTgefZpASTd4QSdddas9huKuWVdey0cKbQox4IHtGQ8mVcpu0p8+rqJBEDpu?=
 =?us-ascii?Q?oRtLghuhj4Lywq0C+zWlTBVT0ckL8dFlZXp8uaTngY11I9A5Oqc7FI+xnHZ5?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ac964b-f251-4687-4ccb-08dd58108de3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 15:57:08.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bXY0CbR1TzBPIarlGiavTKou3+KWLmG+d75ieA9Vg4+LSw87CP8F1Z+32gMHgRmefjkmBrxF0dDXTeDmKI7vJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9118

This removes the BASS plugin interface, since plugins should not make
direct calls between each other, but use the shared files instead.
---
 Makefile.plugins           | 2 +-
 profiles/audio/bap.c       | 1 -
 profiles/audio/bass.c      | 1 -
 profiles/audio/bass.h      | 9 ---------
 profiles/audio/transport.c | 1 -
 5 files changed, 1 insertion(+), 13 deletions(-)
 delete mode 100644 profiles/audio/bass.h

diff --git a/Makefile.plugins b/Makefile.plugins
index 81cf3155a..43e665432 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -118,7 +118,7 @@ endif
 
 if BASS
 builtin_modules += bass
-builtin_sources += profiles/audio/bass.h profiles/audio/bass.c
+builtin_sources += profiles/audio/bass.c
 endif
 
 if MCP
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 37168e58c..0489f6655 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -57,7 +57,6 @@
 #include "src/error.h"
 
 #include "bap.h"
-#include "bass.h"
 
 #define ISO_SOCKET_UUID "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
 #define PACS_UUID_STR "00001850-0000-1000-8000-00805f9b34fb"
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index ec5b88ff3..44320a78a 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -52,7 +52,6 @@
 #include "src/log.h"
 #include "src/error.h"
 
-#include "bass.h"
 #include "bap.h"
 
 #define BASS_UUID_STR "0000184f-0000-1000-8000-00805f9b34fb"
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
deleted file mode 100644
index 32c7e4def..000000000
--- a/profiles/audio/bass.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright 2024-2025 NXP
- *
- */
-
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index bc7ee6e45..3d1f55b70 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -54,7 +54,6 @@
 
 #include "media.h"
 #include "transport.h"
-#include "bass.h"
 #include "vcp.h"
 
 #define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
-- 
2.43.0

