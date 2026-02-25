Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88191392809
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036418; cv=fail; b=QzDorCEr4edINPNh4+dJk7EEc/rw7iPhe4nxdb/wi1sZXHMPhhAge/nK8uhSmUw1/DtO+36TRzyTrfU0v04CLw2EeMuctkfQo62HZBP/NaylsH2kg/R79j6n14BBAxbEuGJpaHCi+0a/p3w6C3Jnf8VazfkhNeNzmt20WX+fg40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036418; c=relaxed/simple;
	bh=Aw43W8BcNVMPGf6FP7+DoQodmDFo2qf5fv7Zj0th604=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmsD6MscSS1Rsat+Bq7R8CCa4vSI09IWqr5Qjg9ozWLlXnavzczsHbE7LEKBVauFpWdRyX4N+6EC3OI1HJIArvxo24vxOsaymDs2gTPhY2QHxhc7n5hDuY71LbDF//KvSIlYxJYZGPbe9rlFqhewgXwDlACWYFomMW1gS/x42yI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=koWsDziY; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="koWsDziY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4ANX7s2d12PGq7dlphX87Z+GU3/QaQ9Rl/dG4O8/GeexQ5Gtd6eI7BiXKkGgmyz/jlrnVftdVTGH4hSNEKR7uFfsqFYlzaMxO7Ksght2VO0x6ZEfaHZl6hGU7Cni8KpXoWqHD/4fvgjPfVa6pSjlY+cKLQMX3oftMgzV1d1X2RnyIx1yAqjob97uJPOYpzorotK/4RnTHSnqqhHXHavauU6/yNBdvafn88y/C9GHt6Et5g1gDgbtzfB21jl2K3Om51kZH28MixNI7IO+R44pi78W+5kY48+noBRrYN9s2pbw8lgc6uoPY29FoN1cP3N3iXvPknXCVuxKarGlLUivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbGzJC16Wf95W+ifUXYrKTS6MK7whQi9LM2ewqYaVBc=;
 b=Ulp3x1NLPPoWIJsW21AhecLCg2PVdSPvyNhfqO48Ou8/c+QOKIq51lmIUtpt/kHO8/rxK5oOP5u4j0To05OFDI94TmQTtDGZPh4x631GOGpn98fDP617I4YLBlveW5Q7uDI9CKPMFHsEYv2LRP9M+iDCEIedR6OuTfNxHbjdL/oI35KEqM/EPUvsxr1B/LtTkMQB5PyoWaudnfdW4lD3U9tJR30cvIx9LTJvGDChaVLPKgHlvHLhqp6HfCRRgchtskwfGYhT53pM5dVluSYuzsjeUKTEHrg2QGfr2cxE7OFxlLE8wWX7CgOTyn2AbycGhm38LFsgdF5xFiUWCzU2Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbGzJC16Wf95W+ifUXYrKTS6MK7whQi9LM2ewqYaVBc=;
 b=koWsDziYfDtPfEEv1KVeRO7NknhT6Q+o2j3XMFiQgVIMG3uHENfAX360eYXsmQjL6XN8HlzJH//2FGXFm/7wRlaGO0hKGd1HcOWqEqHsTcOHNjuLrSBa8YOeyfnnaz84aUfn64cmQmB2rl4VcdvFtYrXcy48qxL0+ALT+ejujZM=
Received: from DU2PR04CA0340.eurprd04.prod.outlook.com (2603:10a6:10:2b4::12)
 by PAWPR03MB9010.eurprd03.prod.outlook.com (2603:10a6:102:338::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 16:20:04 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::e4) by DU2PR04CA0340.outlook.office365.com
 (2603:10a6:10:2b4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 16:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:20:02 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 17:20:02 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 10/12] l2test: small improvements for deferred setup
Date: Wed, 25 Feb 2026 17:17:13 +0100
Message-ID: <20260225161715.20394-10-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225161715.20394-1-ceggers@arri.de>
References: <20260225161715.20394-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|PAWPR03MB9010:EE_
X-MS-Office365-Filtering-Correlation-Id: 40d70b2c-b4c4-47e0-e652-08de7489bb01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	G5p+d/9fqxYFfiCnzi37+mFqM4dTYaMrMeqJ8My4BmLAOG31trtI6YobC96aEVWnouTU9295unbcp7PoBViOnclRIMPwHk7zd07Bs23aVB2ge07pJTT5cSmj3oR8vomDS2vwebC6wFb72yhaFOIc/dec/G1Z/77w/Xvx9zBM/pMoN/sV5Jklvw4aE9XZcepOxwbLmtVNhLQUwqoQyQOyK1XOgZi8zaiZrLA7dTWbGpDfo7WzSoYQDryyU+DqqMemxOwMlvGviIxDtX4jqP1ouzqgIPSUooH6Z3mKesVSfNMyaPvrYk9cJZcFyFLGd3tRxusa/xF/52459LEhtcOrICrxoDzBrosxaP1vm+1SF8yYinLFR8slyUbff3Dxfkw1wk4Zw1tzt6lw8tsDCHwVapz1+/l0hmc+rIWipNmq6vG60TJghsnK4/lBYKRyz1JEw1+hOV53S3Cqv/zhbTIb0IPZGWUgoUz/P4Zf5v3DtMQmTbyPo0keh7bqJcBSqBQe3gbTRXZKD4jnhxOyL1Ufu8WOWElG8UOtiZi1hbUpQPBC+8qmlhk2JE/nbHRQ3g/k5/xk4i0w2pPoDC05JJJbdfP6G32YY/HJ+yfnwGMz5IirSE2gBXibA3z5gby4NTCjKME0skZfEcHURaliAkP8Q1MiR01nUWvQtoqW1incZ9VAasIFcK2bDQ2dkj8JgYo/fFTYDRmhLl0Qh6ptMYyrmraiEUy2U8oLul0TQHU8LL1y7g68QdpZPpx9S52/rgMC9SShDg0owxBVrpl4VlQ1YGoiVvXjF2P+2wLfYDmMSUy4Q9KN4M7KiTokNxISNukI5VxHK9Qfg2qAVOdKtphWpQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4IQK43T6vOh5LnyGEMzP5SXAehsX2Oic8t4DmCQC/pbimEqHQNaPPUwipYIpGABHRpuQTI2OqEPF0er12iXi2+ZQr1OoI0OfGZmrwtn2gqWPjmtRHD0qayR4lw2LBPqZeqoQhXubHwVXvkCa+R1oiLwG4m1Z1XMLydDbNUSSSkFctwApWkXn8Nx4VVX6ir7aXbkbdD8cd/AXzRnEcgtSk+ZqK8vWxYMbOLbpZPxLBYja/UkkJrNXEAiHOIonL96k2WU4amRDTUFTl8JKuN7XVSmXY1RBjCNKWPRrynRQQgk9brEYLMlyKfWpzwP9B55goV8kYExa8/bfhdjypMz+wnmmGj+QgXeGLO77zTbcz0JPbzi+tLcLJWv+HdU/SnivXhUZ2X1na/Qo/zvI1DHhUNCSHdie13ChNmwSDm2Hmi57MvCI1QMqKX/DWWZZpt/B
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:20:02.9097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d70b2c-b4c4-47e0-e652-08de7489bb01
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9010

- don't pass arbitrary option values to the kernel (the kernel only
checks for zero / non-zero)
- centralize authorization of new connections in listen()
- improve documentation of command line option
---
 tools/l2test.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/tools/l2test.c b/tools/l2test.c
index 7bdf58f0e776..3351f2e0feb9 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -658,7 +658,7 @@ static void do_listen(void (*handler)(int sk))
 	}
 
 	/* Enable deferred setup */
-	opt = defer_setup;
+	opt = !!defer_setup;
 
 	if (opt && setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
 						&opt, sizeof(opt)) < 0) {
@@ -768,6 +768,8 @@ static void do_listen(void (*handler)(int sk))
 
 		/* Handle deferred setup */
 		if (defer_setup) {
+			int len;
+
 			syslog(LOG_INFO, "Waiting for %d seconds",
 							abs(defer_setup) - 1);
 			sleep(abs(defer_setup) - 1);
@@ -776,6 +778,13 @@ static void do_listen(void (*handler)(int sk))
 				close(nsk);
 				goto error;
 			}
+
+			len = read(sk, buf, buffer_size);
+			if (len < 0)
+				syslog(LOG_ERR, "Initial read error: %s (%d)",
+							strerror(errno), errno);
+			else
+				syslog(LOG_INFO, "Initial bytes %d", len);
 		}
 
 		handler(nsk);
@@ -798,15 +807,6 @@ static void dump_mode(int sk)
 	if (data_size < 0)
 		data_size = imtu;
 
-	if (defer_setup) {
-		len = read(sk, buf, data_size);
-		if (len < 0)
-			syslog(LOG_ERR, "Initial read error: %s (%d)",
-						strerror(errno), errno);
-		else
-			syslog(LOG_INFO, "Initial bytes %d", len);
-	}
-
 	syslog(LOG_INFO, "Receiving ...");
 	while (1) {
 		fd_set rset;
@@ -858,15 +858,6 @@ static void recv_mode(int sk)
 	if (data_size < 0)
 		data_size = imtu;
 
-	if (defer_setup) {
-		len = read(sk, buf, data_size);
-		if (len < 0)
-			syslog(LOG_ERR, "Initial read error: %s (%d)",
-						strerror(errno), errno);
-		else
-			syslog(LOG_INFO, "Initial bytes %d", len);
-	}
-
 	if (recv_delay)
 		usleep(recv_delay);
 
@@ -1342,6 +1333,9 @@ static void usage(void)
 		"\t[-O omtu] (affects BR/EDR sockets only)\n"
 		"\t[-L seconds] enable SO_LINGER\n"
 		"\t[-W seconds] enable deferred setup\n"
+		"\t   0: don't enable (default)\n"
+		"\t  >0: authorize after <seconds>\n"
+		"\t  <0: deny after abs(<seconds>)\n"
 		"\t[-B filename] use data packets from file\n"
 		"\t[-N num] send num frames (default = infinite)\n"
 		"\t[-C num] send num frames before delay (default = 1)\n"
-- 
2.51.0

