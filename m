Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F40430BA2
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459485; cv=fail; b=I4Cp14jM+OdN20TeKrTT2fSuqbUVlWfgZYXUM2UUTanHQwJGvmAyhuqPGM1uR8O9ysTlXK0EN2HDveC8K/hLgeBqbA+wfqXZ/SaUNNerVfRfdyK8kc7lAk7jNsQoIpyHFPCilKPRBt6XkV6Ldp3/Fil2DDF0Pd1+CmK3zwl3a8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459485; c=relaxed/simple;
	bh=zKNtk5iDbPhIjOZfiVfQNz4UMqaFLRKkfA6epRmlQhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TaEnG9JwGyKDdFvLgCSoeNfszGzUaFChwCePCQqUT06HSqn5tD4nEk6fKFeQUzFTnhF24wq/4SK4LjTx/qaNBdG+r4fcsoZ0qqdmcyMo9W+k6gY5mowqT/DFI9eEcdHxTv94L42odEgAGIw63guQr/rQWGHUx7KdMDxl00tEjwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=c/srCZRt; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="c/srCZRt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwyD2eMvU6Vxifq5/P5ruqhjgoZ6PUz1nhEzdi/Skf+gXTbLDxwqUHS0m3IUIWrrrf0qLlBtqurPAw0M3dgSpG3W4aQrrxDTBz5NNB2K39a6yoJdt5h88LIc7qlcciLn+iVqMTXe1GM98KRtV/E1SQTr+8mGiDDlaGG8rLGNokVoPproVAPPtAvajVLuRnsITGb790hojoOCjPCSg9uGJnGQpy6HfoK6Ye+hI6hQa9mQWS/qYyZp3h6ClagR1G8g+5dPa4k931oPgFoxfm3eJ/G9PwtBSpj1O7BTwEQhSc7gqTY9Q27h3pUQYbzZLxc1v74gQNOlfdCVls+4oVsiyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VI5qkmz7D72q8ULNjXueOiMASWPPpkCNZW/LOfr+QYE=;
 b=UDIMQQEXmu8NMEdcimX7OhsBURYJFRJcvz+5AlpDu22IpeAL39fL9U924OCrxBH+YJDdbhDXai9CL79t+8mEH6I7EInQ5BHUC2TVHHtUJ0a4i2hOoFTV7sAzVp8UWUouxDrfnpHn6slFSYdggHle7X5ZpErk36mzoAnWds4+u5xGxmiJi2EzhrhmxjjLE/0bWWsIT9NQ5qzztKc3hlo4HgexDixRUyV2UbQXeC8Q7U8jF9zORCxrBBY7KyEDALHl7w1buJQPaf83afTeNtMISSexgzzF81qCF/E/hsV8JKvxKxSTBp3FTMRYMBtSvZAUahp+ySzpy3R7WefHEzCKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VI5qkmz7D72q8ULNjXueOiMASWPPpkCNZW/LOfr+QYE=;
 b=c/srCZRtOOkVbsIiCkYKhTb/vY78XcyXldERhKfIuzBFQmi49/LTZCurrtjAXayztHPCEjNylhMXDiSuw7tlZ+EP7GFV3qTD3QgeRmc/Pt575DtGXdhAiv/oFtXWdna6KRyw1TOv8hUgewYdCvfl3KsJNb1I5MtgN20H9DH6GB0=
Received: from DUZPR01CA0254.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::26) by DU0PR03MB9636.eurprd03.prod.outlook.com
 (2603:10a6:10:42c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 13:51:18 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::50) by DUZPR01CA0254.outlook.office365.com
 (2603:10a6:10:4b5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.19 via Frontend Transport; Mon,
 2 Mar 2026 13:51:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 13:51:17 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:51:17 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 14/15] doc/qualification: l2cap-pts: remove redundant test documentation
Date: Mon, 2 Mar 2026 14:30:42 +0100
Message-ID: <20260302134540.25540-15-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260302134540.25540-1-ceggers@arri.de>
References: <20260302134540.25540-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009529:EE_|DU0PR03MB9636:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b3f25b-5251-4fcc-d4f9-08de7862c74e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	Ksjge1HixR/rDq78bqfXNm+nAmk0ini5lMrIpRqh9OLi5d4GBxA/aWPOYQoyEIq9wWIQP5k0ecG/B7vKwEvt1cFwG896qLFpy2g7Rbdmblz9/DDzk8xA1Xar/nmLcM5/bvPGWL3RgRrdRBSS6VtQUN4zt/+bGv+MDEfUeX/rBMT00MNGLEQIku+mI1GZLwKNO9OY61/83bsXy7zSPPUg4VDwhF6agKTWwqgy+x+NT8CZtw5IluwQCD3KPJtvZ4cWEIrhoxVqPIexyAcbwaOmnrqxlM10qCDSY50FHU/fyC36/bwIEsz6tYecp8TMNeF73w9Y7MT8HN7aJIIzE2/UknFE52zyNQeGXO3NW512yAeNeDP8pvSLexbzkE3qWz0jlAGxse743DRY2Yk0C7D/MFvMDhJFZlHxpidkqdhc7t3lC2p0mOrD385kpwmKtXZbjIdcgVraEN25YzBMvTVd14TXmLEX8DY8Wh2oBKRet3/b37eGHALMduI+nxYXojlnl5U/daqVHuyHsNA0KQZjxoU3Yjv+NQ8oP+UxKfmeSPvQ0/IhB1bTmVwd8Mynt1FOf1UiaUV6s0G8G7KOfprrJTgoQuKzBsXJcB4Gb7NU6Ehx47a5ZBZh6cYREhEcMiXhU0iFzuBpUUi5H+uiMu/lCGOd1WaUwnn80yDGD2Rbedpbs5b4uPU1nWwntiycebDNtRiPGNhkkRWwW1IzeAWcfXk3cQ1Q5vBm/5MJzaZN9dNuRjUUnmcR3jZwvHpas5PGX1iIUgltJ5TefGniUKew2lZvtPl9x4tLTJtPxPepACSUhRL1nnHzgJC8yOSfqqnAux+BfgLn/Sj5dyy93b/CHw==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rPwLxS/eTeRBGsOlaYsc1xYgIyTifdyhHxgtltcg+kEBzzCpEsn0QBUxbpkIcoa/cJiFjtaKviEBiJGGHxS7fXMO+xXddqpq+u+w4/GJeIPvSskOYbZNDeBXHhXbJYH+aJ0+DLPMZjHDfn8ns+cd5PhUjhtORVJtpyQbf00NYHrXOVuU7fSlcqhwXXC9wUmxcV2Zym8Ir0LEQ0/LI7a5qCIdPk3ZfQ++vgL0eAlVvgja2yQc4kysUibz2TX/5jZO753OLlomCFiGGGFEC0eyvkNJpKD0deZYRhViEXqqj+xF998VDtNT8RbWd4TprG6P5oFE3tVt8jpKq1SVVpWhCSniJhVfz6Cb6VUftaw95Pe0RwMFd2rn9n7RUkvx0RRIdZT4/+KUXKaW0rBAzBMXVnHHPFk7JwDFEGxoYhyVyl8qv4VLtwpmo382C84IK8QM
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:51:17.8438
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b3f25b-5251-4fcc-d4f9-08de7862c74e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9636

L2CAP/LE/REJ/BI-01-C is documented twice
---
 doc/qualification/l2cap-pts.rst | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/doc/qualification/l2cap-pts.rst b/doc/qualification/l2cap-pts.rst
index 931df7875189..93adffba81f2 100644
--- a/doc/qualification/l2cap-pts.rst
+++ b/doc/qualification/l2cap-pts.rst
@@ -435,9 +435,3 @@ for which we know the test passed.
 |                       |        |        |       |                                                      |
 |                       |        |        |       |   - l2test -r -V le_public -J 4                      |
 +-----------------------+--------+--------+-------+------------------------------------------------------+
-| L2CAP/LE/REJ/BI-01-C  | PASS   |    6.1 | 5.69  | Pre-condition:                                       |
-|                       |        |        |       |                                                      |
-|                       |        |        |       | - Run:                                               |
-|                       |        |        |       |                                                      |
-|                       |        |        |       |   - l2test -d -V le_public -J 4                      |
-+-----------------------+--------+--------+-------+------------------------------------------------------+
-- 
2.51.0

