Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2118.outbound.protection.outlook.com [40.107.102.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA21391
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 00:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709772016; cv=fail; b=eVsfu09SKkQMk858dKdp37fiOR0tj5bGtWqATHHLp37aozfTQRVBgVUTFEKDiJtcSCF5SlKsAzYQQgb1sVUFl2dyC8PthW7HRRHfMOZmR70NilEkcqxlNPG7n96UZ5J8vQ6LZPiSIEsHu2utp0LC3RnI1iWMw4vu7cfk4+CifcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709772016; c=relaxed/simple;
	bh=1MEE6FuxC7P+cfmgbeW0FL2sS7OE6cTcPy/6QYQ/ceM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I6/DtTTwR/R1sretZ6zhWZd/eOdstRTaJIHA9ZGc8lxkUE0LUWpA98mQp75zhLta+ahNLvPWWaO2rhr2uiKMXdV7B4w8vS9q9sWtYQZP2ViPQ4G9LOVtJGoWWAyLaLXR/vOtFa3AlXF5fjC7WpdC1IIzNbCCiVk3etBf5tR3AYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com; spf=pass smtp.mailfrom=infinera.com; dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b=TR7bVQkW; arc=fail smtp.client-ip=40.107.102.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinera.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinera.com header.i=@infinera.com header.b="TR7bVQkW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcpAJgf2ngRnoCmZQPz9wzljIainfCHDCzw/hp6ouAoqu2CqSpwVW4qgsC+GlrPs4hvKXHG2/fFYmE8VD62MqxDd93V8OL8CtCjd/KvtR3NFDa40iKzNO2OOZtt+QGeVymI6Zluc6rBfitbUGE0KlYljUhSd017v6Ch9nEyGRLQ15hyPcJP6CQoEvzFUFi9tVT+xjjps57y/EgDPkboKhy/HEZM4DWH9r+HwoIcr8GtJSYjMb5EcUBrOracfxkyQsGeTe1QzBAd6f9ZwAVmNEp6MwOkzvi2lNI2rlDwJWK8Hps/Gu5JwywGdHdwwB38LwL3Tv8b0KOridqCu+79DDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BAPkKZx0Ri5N/gzrF2WdqtxeX/1qyEHpPgtaTHrdDF0=;
 b=YK67IA29vwWs1vaN2nFGkMUVOmM6pHTWWT9tTs3k8TnEnke+MPZmh2jgrX6o1Zr3Rwrutb443jk2DpaOiQ7GRU1x5ABtmiNEu+jBi8XVugsT3JANss9UInTAZxKRHQ0L4l4nSkhKUHRdNF5McqHHs+lB2FD0k1KSv7eC1lxW/jAb8Zmzilm+jbCachPOrq2LJpcMg5VHvSaPqbagc2OogezVKWcKZNlTmrPeG3BoEB/DIJM/jMb7AXkW/F3wn9N8rS7BJFooCPpJ6kjsw/QD6ecTqZOODzxk2IXnzoQAWieeOuMySyjDmiUNQL6pxUTiHUxpjZlEr91N8br0b5cNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.4.225.30) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=infinera.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=infinera.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAPkKZx0Ri5N/gzrF2WdqtxeX/1qyEHpPgtaTHrdDF0=;
 b=TR7bVQkWWO9ga6omzLohhhbNN9YkUSo1JJ2yiB+X6TtG96GYgdTuJPJQJr2IUXAtLb1xrPqIjReGoOOKCRmnFfdngtbLi52RAvgL1kIax7DT/SEVbNsXtbYdgavFXev4Kb4zh+0+b8jUdvqV56e20QOuL73Ns/70uvmtq7ovZ0Nztzw2lO3HMxNEpMsLcviScSaP0AfH398sg3HItr3c8ATTub4SRYTgliEW/fB69F+uPA0wikiJRALHEHunXy/1UIiicqI64YamA+gnWqmRAUtbpFhiPRbQ6fbVzk2zzExFR10v2MU5apPclN4d2mMk5TWMAsSj77IGtVmZNa4/Mw==
Received: from CH5PR03CA0014.namprd03.prod.outlook.com (2603:10b6:610:1f1::16)
 by SN7PR10MB6954.namprd10.prod.outlook.com (2603:10b6:806:34f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Thu, 7 Mar
 2024 00:40:11 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::54) by CH5PR03CA0014.outlook.office365.com
 (2603:10b6:610:1f1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Thu, 7 Mar 2024 00:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.4.225.30)
 smtp.mailfrom=infinera.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=infinera.com;
Received-SPF: Pass (protection.outlook.com: domain of infinera.com designates
 8.4.225.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.4.225.30; helo=owa.infinera.com; pr=C
Received: from owa.infinera.com (8.4.225.30) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Thu, 7 Mar 2024 00:40:10 +0000
Received: from sv-ex16-prd.infinera.com (10.100.96.229) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Mar 2024 16:40:10 -0800
Received: from sv-smtp-pd1.infinera.com (10.100.98.81) by
 sv-ex16-prd.infinera.com (10.100.96.229) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 6 Mar 2024 16:40:10 -0800
Received: from se-metroit-prd1.infinera.com ([10.210.32.58]) by sv-smtp-pd1.infinera.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 6 Mar 2024 16:40:09 -0800
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com [10.210.71.68])
	by se-metroit-prd1.infinera.com (Postfix) with ESMTP id 04EFA2C06D81
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 01:40:09 +0100 (CET)
Received: by gentoo-jocke.infinera.com (Postfix, from userid 1001)
	id ED5D560FEECE; Thu,  7 Mar 2024 01:40:08 +0100 (CET)
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: "linux-bluetooth @ vger . kernel . org" <linux-bluetooth@vger.kernel.org>
CC: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: [PATCH] obexd: Install D-BUS service for non systemd
Date: Thu, 7 Mar 2024 01:39:47 +0100
Message-ID: <20240307004006.1173879-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Mar 2024 00:40:09.0983 (UTC) FILETIME=[024378F0:01DA7028]
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|SN7PR10MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 16bd361a-65b1-4c7b-748d-08dc3e3f2554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LuMRty6G6lUKobxFnE7JpLkNAKllefo9UhSAps4uOFv0pYoxo/iT7+TdwTj6skDy4fFQgGhNKXqHJx6zjXwIm87RX2m/ZV/GKL2iHHU7gRbVYq5xyovHv9HO/XKrH0vGHmn3+4bbfEcV+wte8x8gDa6RRwFDKiVG4pOynOos1YnGP3EeP4oha/fS06pExncORzL959B8V3lgUmhBp7nimAQa8v9OLugQcLCQ8HqnFWL3x6HXAKS8J1cLITcZOURfL0MbfxAtCYfy3WCmBUrnGtuQGsloT3rlMF71xDzpHgIgQRDUj6QNGxQqA8WchfmieOG3QMVfSevqpnUY4prlMFEA1C2uDU4y1kspkZQ6Ag0uB0UFdSDFxuiVEUTyuC2UEecpuVrwRXcJwR5tRsHJVF7LoxdzFm2sGZjD9G71/hhwODfGRKqcuE5QmgzNjn8gAfvECxZOYHkupdAG1t0tAiZkkAGRnsHrnVuCSeUqeE/lG5etcEEJguOeBRg88639jYx5NEbQbxx5B+G/74DelpTEwAcA56P4MFR2tW3VkVDx7IbcevFFs4GVpHyOf37IVNrRFkVyp1z3dfgJFN3ccHd6GHGAwr0oNlHGTythWc5vwVwjxK83WQQWgrzoHuFqIriOxJ01NpTolL2IwDaLfLGisZcUjcoS3YNZeOCKKA5SQNu9zxC7EHUCk4Lixg+oU+90igvdG5HACDvaF55tIn+SAO4BtArZWvhJCa5uEbaQHg01RoGskSpXwWNrZkhq
X-Forefront-Antispam-Report:
	CIP:8.4.225.30;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:owa.infinera.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1102;
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 00:40:10.8515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16bd361a-65b1-4c7b-748d-08dc3e3f2554
X-MS-Exchange-CrossTenant-Id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=285643de-5f5b-4b03-a153-0ae2dc8aaf77;Ip=[8.4.225.30];Helo=[owa.infinera.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6954

From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>

non systemd(like OpenRC) machines need D-BUS activation for obexd as
they lack --user service.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
---
 Makefile.obexd | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Makefile.obexd b/Makefile.obexd
index 385e5618d..cfcc115b7 100644
--- a/Makefile.obexd
+++ b/Makefile.obexd
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 if OBEX
 
-if SYSTEMD
 systemduserunitdir = $(SYSTEMD_USERUNITDIR)
 systemduserunit_DATA = obexd/src/obex.service
 
@@ -10,10 +9,6 @@ obexd-add-service-symlink:
 
 obexd-remove-service-symlink:
 	rm -f $(DESTDIR)$(SYSTEMD_USERUNITDIR)/dbus-org.bluez.obex.service
-else
-obexd-add-service-symlink:
-obexd-remove-service-symlink:
-endif
 
 dbussessionbusdir = $(DBUS_SESSIONBUSDIR)
 dbussessionbus_DATA = obexd/src/org.bluez.obex.service
-- 
2.43.0

