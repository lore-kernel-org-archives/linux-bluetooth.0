Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBA199E80
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336842; cv=fail; b=orH/jjZqCvA/T0nF9GaxTJZDXsjMKAaW7MTP5MtxulP47ydr3ChMlO+qtyeVclfR16YdDLWB7AHMR1qxB/6PJJ9Xd7r734nZA94jNeR/9GZ5cdUu/DzsxpckcPZZuPEFfeaxpGZR4Hqc/YMWrr56nDrgQLTfZystSBikxOkFgJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336842; c=relaxed/simple;
	bh=GGUzoKwepzzYOs67VvmSFww144aRNxXpeSk9OFxDv58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dQgzK22vG9/6qBcFxCe++N1Eri58xm2zHMcvLM/FhAKr7hSDUD9T1JKeyotiXIzFbmEoE80S0nu4m2+4Z0dsCncnQhUHZ/l8FUfSIwRsfg6GE+YX/L2PjYBS2ptB6CGrJ+vEx027PAkaA4Gdf6H8rrHyouZG2LUcG/mwe7I5+8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mgRrSHZv; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mgRrSHZv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnXMg3VWKlYU3m6gcI3zKnX8YGsj40CJEibi9R5Gjqp3WMTFqkc/DNEE6eBj2lvnI0EIF9kD+udNlcVF485GFjoxNzJbHHzBmS5qHqwtpfixsivS325MlhCeGr+9E1oZ5iP5LZ0VTSatlvdFwkwAGljVXHBvMiLgLS9Aq9axvOmbi1DN2Q5ZbtXiOKUWp/crUMRlHCaAq5t+5ThusI1GElTXG+x6sE7JWnEUTDFrYldbnae2xacmecH803VbvLHTBbKohAA5kMxdL1tKSQDfu8YD36Uva93jaB4sOU4eVx/bCon/4aTH9jJTzzIdnAfy4pVIl7qECgNsppUwMvR5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+b1/6wCj/VG+A58Xkz3ufjLh2cdiy+bvd2TTSHja78=;
 b=Shta71LuasUSmh9kE5jciwPtKfU03G9VtK9LggGsI+oWMujrtePQ7e9GKsqa9ltyt8A7mQwjqS2DNnJzDLhLsqPM/BTRR7vf8D8V4+EIe9wYW/ACSLu3dUVj2who/SqG1Pb3GuFb3gjiX2vFdTMZfk4XatQpc6v3fGgdohZIDTzTJEmo7ztv3Sues5Ppw72O0uBf2Xk1Kjft0ZkNnNR7turvcc4TetiveSqX21W6dYKbckeqqqfv3JbBSaPycRb4QMMh/l8tIKTFhOGjYtL785F+VzcnkF1TCkXfBBHQnmAGlpufkuZ0Tr2dubX8r1HSweUWyUhEYq5xBULBQbqhOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+b1/6wCj/VG+A58Xkz3ufjLh2cdiy+bvd2TTSHja78=;
 b=mgRrSHZv2+Pal8Et77PIqQWlPY0qJpOzAWyGrs0hs2moWxMht+mQdeRQQHwmy5iyeRI+QIwYakR0fSfsq/UzFc5HfahHHsXqTdeMUfPGHxBEsGqCj+tfOpzVwv/zilFv+nl6Olz8i7LYH3xfqXDl2qiyKIq4/XEr+QcP/b9kC9X62QXrv3sLyDHeDEJsYl1Z4sqerpI0AuJVoCFS/W94LjCYyj5zZIFcELyqkXR0kJx0yhRus/HF4o2hdtATmmDfcyQupsvLPmedKS2xTAhQen+kmPRYjWwNFeVVo4k3ApnT77B4UJf5ZYfGGiAnRQEt37z4Jr4yion+IGRkL756uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAWPR04MB10007.eurprd04.prod.outlook.com (2603:10a6:102:387::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 10:53:52 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:53:52 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v3 6/8] doc/media: Add 'unselect' method
Date: Tue, 30 Jul 2024 13:53:11 +0300
Message-Id: <20240730105313.403238-7-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240730105313.403238-1-vlad.pruteanu@nxp.com>
References: <20240730105313.403238-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0212.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::27) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAWPR04MB10007:EE_
X-MS-Office365-Filtering-Correlation-Id: efeb712d-2899-49d1-bbf7-08dcb085df6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h3EHChhkHHVUtRgkVel5S4l/r4E53AKTLi62UrzbKdT1sceJIIzKpO8fDSbY?=
 =?us-ascii?Q?UA7b1mkGK2EVlO7WaoGJTG5EM5h+DmyGByLB0hEk+SkO2MY5VguRs9Os5jp3?=
 =?us-ascii?Q?egyyDmWNp4c8ExU8wblz9IFiGXEIbP0UTIf/pBYhWdbhkOnP4LpVbGoWq4kv?=
 =?us-ascii?Q?A3idnRhsLuA7fUrFOjKgtk/lSptc+5NReAB1vin9FkoKQ849ZHATioqfCMX3?=
 =?us-ascii?Q?pQwwKnVx2OYo4D5Sa79GM77kOXZN4VWSN5HUYYFtDC0FBgel9+624FyzwGrE?=
 =?us-ascii?Q?G8jQsbNDrY14xTsZ/3EGYQ8LevV0sxVe3aAAYLCR5lCMqhoNGSdCsA9WM08p?=
 =?us-ascii?Q?d+9wnXu5xSPvebZLT2QUV5glfUreA0OS+oHx63KEMSCHNy9PHO1ijkgJkw68?=
 =?us-ascii?Q?2SZ6eF8dUhksSpEW2P24r7oEG2gVzrprKJCtZvINk8nWrn/2VjRJvLjh27lg?=
 =?us-ascii?Q?6RVFllPvoNCAPzxIoRiWf/yuMyxFJ7iDX9e1XvL1lqEP8sMmA9Dudjaid1S7?=
 =?us-ascii?Q?Kx++oeYQL/ch7Gq49CCo6SCE4Wym9jqxRpQsd6i8pZZ2CZidSCmLc3wiFwcM?=
 =?us-ascii?Q?K56Pk8aHq4PRxSlIOjGnqyxPsbwqoZmXdVEWUgr9CWtlsPj5VL5pWltGM5fx?=
 =?us-ascii?Q?BZ/nghV/5tCJP1/5mwSIVyk2kxoSCO0Yl9HviS4tWXw6RZ7tLq3SFs51USyl?=
 =?us-ascii?Q?EM5/1OAbzQfRnFp7hv/+SK6OsK9k/0h+30NjU9CeBn80XDUZNSVYq1no+uXu?=
 =?us-ascii?Q?N2SmZdJgw9uQ10qzKL5q7zZGajrXsgctK3UGPEBuLWGitql1/00TDabLGQgM?=
 =?us-ascii?Q?+mHsae0gNJwRoHewfSL/k1GRK/bQR+/L741QmYxboQM0f5uLm7vyTXfPIA61?=
 =?us-ascii?Q?w4h5jEFnMa8Q3HhAZQfMozhe7cGnw79cXfZpnEx03ErVOYOYHIRcGK4BYfSg?=
 =?us-ascii?Q?qcDDpJafeeLPFwauWXXaA+2ZolbD8SeSj3mpdyKmEDICAZ/LktU2FJCXF21/?=
 =?us-ascii?Q?xm/Ho5+Aq7q8haBXuX8tdMOGerKxYLWXol0vviypJB9S5j88QY5rzkRsXPpM?=
 =?us-ascii?Q?LhUiyEh+Qjojx7HZGzPfol94O3dMudubaoBRlib9oOIksuvHO228k3b8/Rlx?=
 =?us-ascii?Q?spYng0MugXfkESLZ83ZvRjIW10aPsqRURt9mSd6oLUJbhgW801Wk6JWLJfH6?=
 =?us-ascii?Q?fL7iQmWAiM9EKJT6t5QC9NuLA+U+gYxfW2iN+q61BBAz6p//onyP+IHKYgEZ?=
 =?us-ascii?Q?ZWJL8WrWnsRk9uWtgwNNsnzWUGmq/7OEpfWerL4C3R+RHvU+p8bqHzVcOGqb?=
 =?us-ascii?Q?aQX1ESchP46apEl8CzvsnJCPcfSOgDVKU8FVIJZDSWYBMY3tokFxHFVS2X6m?=
 =?us-ascii?Q?CdmnMQjStdZrt9k12InEl/7nJYHnG4PaOyBQqDxbK0nFxc8RdA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c+uzR9U2tRXbs4kd3HfglAquEyge1WY489d4a01CPQ98Xr4x//UAlhdsSG3o?=
 =?us-ascii?Q?WPqupMo3ZnY5RjpXFa0W0goSwU+uUfL4sfmCzS8lau2J/0n4ZGU/MchNAq6t?=
 =?us-ascii?Q?5ptsfH9gpV4CIdrz11xUGHcpU73xVKLCfZK9OBfoAvkIKw/SqRFdTels6FLR?=
 =?us-ascii?Q?LckZdcE1Knb02Et+hAKWXzEk0N6NXq4UwN1/kBaISwiFe5LgXIBCqrOyyHf1?=
 =?us-ascii?Q?zMtPZMtS9qimtXlgbjafS5NraIvSMa6j3q3RewKsUSpjOl2SAj8qIWIDAnSg?=
 =?us-ascii?Q?2dQMAc1rINNLsDQw64rVK4yjzQHPiR3fj44+v9E+/flgWruC6EryYBRlWJME?=
 =?us-ascii?Q?jlOLKESfRVOSv0Wsc1GA5DUEJogVhAYSxLPqcM+X1fDMWBfl+1F6OgNctWCq?=
 =?us-ascii?Q?qPxnc/BHR+jBxEq5mp9jqtmc0itngkVOEvlT8XF6Hm+i7gPNL5IL237gZsl5?=
 =?us-ascii?Q?vyWTqT715f9QDzgnydyMgljMFkNh0wDSfRrKW9ZK+ApItfjzs7KNQzmsw3Wf?=
 =?us-ascii?Q?fe6epKPioUIIJpXVtykGF9BhBESjQrKxi09ibETFbkrsfclJFDi4Jod2XIIe?=
 =?us-ascii?Q?GKGB6EJT3gItPUqVCGalctSeqfCKb73PUQtotgHwjvJa5DP4Qij2xo1tk9eJ?=
 =?us-ascii?Q?ZnZ3zrfy8lHBxWKiBQ5SRvvcMVnBjsZziJEBU6G8U1dAXIdzXFoKveBt8krm?=
 =?us-ascii?Q?pgGbS+NgLJRjS9z3EOM5F1Oh8Ye2Pw2Mh3qNS5vlQ73GI9dA+L78lxmuKyP6?=
 =?us-ascii?Q?bwBSHBLM3utwG/zi4nzWdkrGJk12icvyhiXicpmu1b+kjlixUoWsgWOh9+0R?=
 =?us-ascii?Q?CxOVOaYmRgSAnqo0u3eb8Ort9ItlMcXFuiFeaDGuNn6niqjgG5VrsT7XrgyN?=
 =?us-ascii?Q?BogWXMV1uOQLjGanTRiZkOb0z/QKE0RLnsym+rXutx7PlIVkLfNLEkBDcDQl?=
 =?us-ascii?Q?+g81OA4vA66hY2tR1gmel/poGOcYh0qCforX3N7my4DZcPF2fzavFbSXKJr9?=
 =?us-ascii?Q?OCIu7OwStXmE9OGOaYWZkEKKUQQAcDZzgNK5iKS4JNoEocG7BCan5eq63YXi?=
 =?us-ascii?Q?OxO0TPKbbgD+ik3Moz+Y7hy8FpSSR5j8ZM2mm6na66Tz3KY61skYUGNsh2FX?=
 =?us-ascii?Q?jUoXICZuYVwTRK/0Iu14vm5rk6xXFSurRxWC9lbT1jVOslIK+45zZ1rsnEo2?=
 =?us-ascii?Q?gl5gmEaPE9ckzmugXO5hEKuJ182drmH6nanILKuNLux13COQYRzZFg1vwYv2?=
 =?us-ascii?Q?xFEqCB5owSPTZx3LMgPvtPtWiEu7/KDI9IX27sHpMoAC1UNRXB11lPoDXQxe?=
 =?us-ascii?Q?xKKP/e+yS5CzCcjMUdb25Xn6qNurCxYHR+Bv23D/82RY5L0ecamhK/zGQgs6?=
 =?us-ascii?Q?t9wkB2aWpJnOUlCzRfF5VyfM3mKnQOBGkLXd+PZzwLgEMcWiaWdxA7Vk06kR?=
 =?us-ascii?Q?8VjubsiJXGN6we5BhDy4L393VYC9QIp6A1bZezEcg/Q2K4UgUmY67mbetUjw?=
 =?us-ascii?Q?1yklQ0qygjL618AbbgVTIrdeVj7RM96pmMuD2r28bhpk4sMi7fpJMiZy4SCA?=
 =?us-ascii?Q?lph3HMd8rOwgh41pumELSQCMpddcGj5O9MOVKych?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efeb712d-2899-49d1-bbf7-08dcb085df6c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:53:40.6958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jINqLPBylCfrvDgAAMqhr+UeTIxzU1IzItSt1XzFqP1XzTeu0ITx6029+c5VG1cQzE0v2SR2sjCBizbNOYflOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10007

This adds the documentation for a new method, exclusive to transports
created by the Broadcast Sink. It would allow the user to terminate the
sync to a BIS, via a 2 step process. The first step is the call to this
method, which changes the transport's state to idle, with the second step
being done by the audio server which detects this change and releases
the transport.
---
 doc/org.bluez.MediaTransport.rst | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index 2a3fc6411..f7faba969 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -57,7 +57,7 @@ void Select_transport()
 	Applicable only for transports created by a broadcast sink. This moves
 	the transport from 'idle' to 'broadcasting'. This allows the user to
 	select which BISes he wishes to sync to via a 2 step process:
-	1) the user calls this method, changing the transport's state to idle
+	1) the user calls the method, changing the transport's state to broadcasting
 	2) the audio server detects that the transport is in the 'broadcasting'
 	state and automatically acquires it
 
@@ -65,6 +65,19 @@ void Select_transport()
 
 	:org.bluez.Error.NotAuthorized:
 
+void Unselect_transport()
+```````````````
+
+	Applicable only for transports created by a broadcast sink. This moves
+	the transport from 'broadcasting' or 'active' to 'idle'. This allows the
+	user to terminate the sync to a BIS to via a 2 step process:
+	1) the user calls this method, changing the transport's state to idle
+	2) the audio server detects this event and releases the transport
+
+	Possible Errors:
+
+	:org.bluez.Error.NotAuthorized:
+
 Properties
 ----------
 
-- 
2.40.1

