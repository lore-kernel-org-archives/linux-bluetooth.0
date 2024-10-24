Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61D1CACE9
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767796; cv=fail; b=dcZQseaa/4ywS+FOpbF3V99Co1+moBLiX3iV1SIWwqXYQPlmeA2dXYosyVPB6inzihmUOoHwXvuZB0Qz5dt3XCrObNzHJy4lQm5FrZLbgQs3LenWlreShK1hrcfnR8gP3WT0NdhKvxN7NgvC13sci8GH1IXmRb5BAU7b5dvyGyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767796; c=relaxed/simple;
	bh=RBkN4v8HbOrapJSD7ZWet5Tdlo6IkOvkm2+1rTmxx1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IiczaaX/QBKPT50az6BMmSh/JbXnr4ljWHvZ93dJ7LUc2uji4/+NObw3zJ3D5bKwM599H4X144C8WyyEXc44dogDTpEdtsf5UCGwS8RUX/hw5kSHcCl37Ng72CIyh2b7+O0CkOdqsu3RAlugsCmRL6iFRqL+eVUXba5Gnhh6Q1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dZn9aTWd; arc=fail smtp.client-ip=40.107.249.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dZn9aTWd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOrKXAIQFa/HdhjyeklXXIlZdA9mqyVrYPWV2NlPBOk5wzaLBXDIS3QNQuNWAfZ+sQcQTnAwL7jt7t9XtIkHBdgs1zi3Geyka3lIA6G8vxbiZz9o1A8iNpoVLiDzSGEhmW6/r0GkCU75mPEMXwIuOBxTIYraibf5ROK65TGG3GDz5N07PXTxDK1qGKdY1dOCiw9pnx/an3RbGdbYjkTv9lJNpp0OfNblZkJnfMtZR+hx8dZ59W1WiD1Yi86zkS3E4qFe3C2C2U94u/cC6Uv/G+OB7ZVru+jFCHl/K5nCzD0fQn4c+uNPoEyvpK58QBI/wm5vuLszznDChnp73qKHPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW2MlkTctZWRz39nmD/nTbjenO9cNqJ5OKsAgyabizQ=;
 b=vQTst+hh902ioJxRf9POO8RP4fgsGEsyB9Nv3MEl+AMVsBrydV8JZ3EwiH0im3tf91/lyLjAlnsybY/zBNawzxQ1Bacfp+y1Dl8QQgmOHM9bmc3xIYbhFUefltTfRzRjSC9bwkkJagZg/VT1Kt/QOeDdqGzNtDVragjQNYE3LoeTa/ZNDb5Y8CtQtfYb3TDv/YwfmPzpqRATKICjT5LOt9XpxQaLlIY2qZV7zEHV7Jy2rUVBNcs1nhBkimL24yqMSfR1wwm2QpkYd2exQGeqR0FT8yJ19W83THiIZXv3tSWYh+qb+8MLS+EZDTTgdTL3X2eQuzbXnyIF/ztjHFs/ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW2MlkTctZWRz39nmD/nTbjenO9cNqJ5OKsAgyabizQ=;
 b=dZn9aTWdLZDbfoWzqbKmm6IXQk5jcmOMnG0Ktt3NAEjN3iGcqgCTE4of2jwKIpyuXhXbCX3mf3h++kfJiBugVwIivHMM/4uzlbijuClaA1SiiDQHfAMfZ1uKK9sPEbpACOTVsIQhJnK6IKwdxeJOn7EhfOhuh48M7KoQdB0RnO/D7Tw9Lxz8uWkUppXVvaE7JYEosJkOWmuHDdeTSGZ/gX1SMudZWElJPpoJgQEww2kEXkav/lkCc1Giq/sA7Nxgl32EYPaoa6fHul8eLi5wgq5D5HyXHPSyYCilKdUYfuqGp25zHyaz/ejxa/sbmK4ZAsIhj8MwzcOsFJFhjZnh0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Thu, 24 Oct
 2024 11:03:03 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:03:03 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 07/14] transport: Unset transport owner before owner free
Date: Thu, 24 Oct 2024 14:02:16 +0300
Message-ID: <20241024110223.77254-8-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: dca8abc7-1ea0-48fa-58e5-08dcf41b6e5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D5hD6NQ32btTtp+ciVQn/++jLLT9HybfYlSKx4cxleMBQ+JTNIYEWnf0EFK4?=
 =?us-ascii?Q?3iSYPaRKgnEPswt9AxWaN3X0QO8l2x9PO0f4QkygYU7V0reU7NsPCzuJN8+D?=
 =?us-ascii?Q?viBdTcO8GUdUafusrlsQR7f7wAa8eD84NZ/DTE2JKyT1LjCvtfygGFonVh/Z?=
 =?us-ascii?Q?7tT9zw1D6Vy5n2rG0K3TwjuOP/ZJBQjRnCNm1AuZVM+qjfCa6FZdoxSQd5WT?=
 =?us-ascii?Q?kCKYBJpA7jQXTdBeqft9msGQt4w31Mtu3xBA+PVj1w8n8pH17K7QsnIY8kbg?=
 =?us-ascii?Q?YVAlexc907thpRY0/xgOlcqUpHOhZZnjcYARvCk293eC7M+60od+Wz48Z8ip?=
 =?us-ascii?Q?8UtFQIjg9PYL3BYAJ63Hv3BRHMNkyw+m45miBRQKmo/Ts8P9dJHqgeahg6R5?=
 =?us-ascii?Q?Ygnf45Xkoy64PO79p5080x2ySwc0rHlvVBw2ye8YTtFPiqnSegdp7UAkSvmW?=
 =?us-ascii?Q?bGj+tF9ekntO928ztY0G4d/gwZWBzibDBBNlxewmx6OBsHiuMVNiHicGzkx2?=
 =?us-ascii?Q?GbJae8OppEGhfjdeSbfCpb/fKzWtHbSDrHpV5wqHlLoXM8+wcfZfe/qqiHLf?=
 =?us-ascii?Q?NrcE04+1eQ+nPdX8qciUqG02hbgrRdLobZAq4mtSp6XgRglxM8yaIBFrDsKQ?=
 =?us-ascii?Q?ZL0+qkJBRu3NocFURe6asgSLaimlUlFqS/+iC0Y6sb94o7d4qYvxpAu0N+w3?=
 =?us-ascii?Q?BIi939iDojp/Mcw5t8nFRXXJTJEE+2in0W34PRn93++ZKQkfnR0VhMv6qgOl?=
 =?us-ascii?Q?yck1Xw3hLeVw+yR6uPNmWsaU7vBQB9SSt5I8qPc8qzkambEWOs05S+MHwZgD?=
 =?us-ascii?Q?G4KotjUG8Qbl53tCk2jAaHHTSFpvQUnTAVt8zIu9tVwKNHm8LWFnn1nd9SAT?=
 =?us-ascii?Q?yeUQ3wvw5O6/Uz4TMFMGaV1dOCkOrfmFqTB85jqrOb+rP+UX3qcF5EiZXrtU?=
 =?us-ascii?Q?ymcYuE8N8CIDTwtmWif/L4F+vOGR2anGmOpCxx5R0GV2QHxXy6GQjbWD/OmH?=
 =?us-ascii?Q?Kfr+TcF5/vlaPXR7SJ+L+4fBij1ICkMEOQi/2Ox9NEGsbfjiTt83/D2JR1uI?=
 =?us-ascii?Q?B+taif2TIPKpWNdOmG6xo1RXHRoCItrPzYr+z+ZZdmGf8icNX9A9qJTcHPSR?=
 =?us-ascii?Q?f7bf9cqhLWxjMsMhDhrSIutoselBCSr+tqUswBz02kwA2pdqmUnK4/Mfu+h+?=
 =?us-ascii?Q?wCPEhGVlJ0KJ/Q7LDGW82vr7vJcqLQB5mR2N1ki3ArKKFZcYAViKdqu1oq+t?=
 =?us-ascii?Q?E/JXaemuYfKzsJchW3DPY7jW1XWavenOgV9Ks+6rllZkLf9taSGGKSl7Z4kN?=
 =?us-ascii?Q?pq3sboh4gxHWhoqkNpwYUU8P/Rg7uxtfrZkG10xD1xo0kbjk5AC8B6JT7Uq8?=
 =?us-ascii?Q?TTS52X4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?27wASaqysL7gKpK5tRbKIWZXnwnJ3lrXqCWsSrrHzbZCkwGlVzBdx11bYJrO?=
 =?us-ascii?Q?bx/I/A+wZS8oxnXtA1/pcUgcb22XLY7tJxec1mFV6agQNeTnZeFhIzgLGyz4?=
 =?us-ascii?Q?3R0tkqUgC9tQ2XkhmDkcix6+01LFMLmr/Q7fMlQXUa3BViHteVrF0Z41Yo+B?=
 =?us-ascii?Q?twqGvSCyxCB4XboHNGmVqsMSlyFydwUOXrrpputosK5aLn4l3z6WfpF5GYLs?=
 =?us-ascii?Q?tLta7HsC9gysca4YLBZj+sC7Epkeiazszr9noIFKd31X6iKLkZYpuRu/89mZ?=
 =?us-ascii?Q?LrrCrDtqVtRxLcNR9JFXQSWxAjTpEgyqlCiOAvQ0g6FoMT49G6hy+x0W/q1O?=
 =?us-ascii?Q?do7XPIOPPdcVb//ysZai/IMdO9Bn6+YdGieoFjv3GfDAbr/zljJfxO7joiJf?=
 =?us-ascii?Q?IDxcKkeAZj1lVeZIHDeSmJh5xzr6VcKziBTWoYYQfgul0JI8V4XVZdBwHa4t?=
 =?us-ascii?Q?0rWCF9OiE+9wJ0tVCdFb4RK42jab3jSo6UUp8KQCZHEYN2XHCOkBtxfFt0DD?=
 =?us-ascii?Q?nD0w6ceNNdTAL7BMEVVKy+jLbXrBlXIKPHCoyi/TiY3yVWMZ1EpV/WFcgqTW?=
 =?us-ascii?Q?a1OVmkhc4g4XGnJiqCIDC3G8/t3f0/BSi40JD4DDNeEWF2yvthhhpK2waVel?=
 =?us-ascii?Q?JCx5v/tLa4pEK0UI4dT/XuDEpaAt7HjY8Jb12b1hHl5e7lKZN4GHnk3oqDwb?=
 =?us-ascii?Q?/qRrJfByLEOshBuEgnl8mFp82ivPd+T1keAOjqt16EDg6z8Cya0RX0H1LkSt?=
 =?us-ascii?Q?t4IHyZyppdWv54TNBNWXvu4b6W9FC/o9So9981Qj6OTUcRl9S3BTXFtV3Lq/?=
 =?us-ascii?Q?vC9nLOEHCY+MEDLElZT0F+KJ3sfDN6XabTa6Dn+C7Qb0MBoLiXb+HHiKYIgF?=
 =?us-ascii?Q?b4AR/UMPsKnRxnnP6xX40WU1jSfVyTS9TKGA2vMCYsUn8NJlV6qRZGQAlkqs?=
 =?us-ascii?Q?P5sm29d8JcRvDgHiPqhFXfaW/BUfWtaILguwz6jnzt1+ZSF+0I+4qhmCx+Xi?=
 =?us-ascii?Q?hWZNgVa8Yq2L/SBnWMtIKLgNBXwatSAi2GBL0EPmFIiTeGrXPGZY8w5U2sI4?=
 =?us-ascii?Q?erEdxeu1MeHc7sGamRCcYljVJlp0uVb0MoEmIczkSOSIQTmLRo5jDUWOUm50?=
 =?us-ascii?Q?BZKj/oEreBJVJJ2ntTTJvpGeo2aKJ1qAXxh/C1+KV4uhiu7NjkipUYZQdy7S?=
 =?us-ascii?Q?FVlmoidIgxC3QyGWysmuTEHboFgIFSQCHm0mbDN4cAm68ykKSBtX9C/DAwZ2?=
 =?us-ascii?Q?/Krol1sywT+7NaYFhOdaho6A6BuGi+fltupTm6emWORHPTYP6+Twb6sdEpcW?=
 =?us-ascii?Q?1YD/wJuFx/KaOqm2F9X74dmOAnAsu9+j9DZ20kZPCEngaMPnnTtoLr0lSTHt?=
 =?us-ascii?Q?p8ubJZhRjthIpZrFAOf+Wct2pyO4s+6nzOihj26AS+kS3U2FVr9pysLy5qMn?=
 =?us-ascii?Q?cPgSAKBrgZEfMhdalRIWXW8HmwN/SNFD8JczRsXNYBvSQQaP1IjR2Lo8AQ0C?=
 =?us-ascii?Q?NOrJ3Z+ALAAAg1Ok2x4W71vgScYGfZO1oK/cSR7LPE+ms6mPlzU67LzJmfgu?=
 =?us-ascii?Q?Bb/fM9L5uRBQjgi/iFjAA3UMeslSX5IBF7cpXvuKwoWN948WP2FnzlrQQM7/?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dca8abc7-1ea0-48fa-58e5-08dcf41b6e5c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:03:03.3323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VM1QWtwPMxmH57NekpRju2pKhF3ZnLsHu09GooNdYugEvhgCPmwRVc3vy39Rbmfpp5vFIWf7H2Qrv4fFjLZ3EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622

This sets the transport owner back to NULL, before the owner object
is freed.
---
 profiles/audio/transport.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index d71013077..dafd1c471 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -287,10 +287,15 @@ static void media_owner_remove(struct media_owner *owner)
 
 static void media_owner_free(struct media_owner *owner)
 {
+	struct media_transport *transport = owner->transport;
+
 	DBG("Owner %s", owner->name);
 
 	media_owner_remove(owner);
 
+	if (transport)
+		transport->owner = NULL;
+
 	g_free(owner->name);
 	g_free(owner);
 }
-- 
2.43.0

