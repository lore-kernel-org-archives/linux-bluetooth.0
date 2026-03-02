Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012068.outbound.protection.outlook.com [52.101.66.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA85A3FB041
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459170; cv=fail; b=EFM728aIzovkWTSxKEfkvlFfxtFNo0KEXIeeeiO5B1YsS6aYROrGzNu/eNQSme7cQ9RxQ86T28UUSr+Wm3szioaFDwwjCqd3126SLTcLS+GwzQKjDuzeoXA9593ef6Ut+A+oQvKg1OAAy1S4UtsMYD9etjRTrUXCUMXedGMC2nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459170; c=relaxed/simple;
	bh=gJjt+2YeBpWjoqsYJ1aywKa7o/Z/TqKCQ3RL8sDSgAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IqllgbP4a0iqcFUpK0RdpPi+n6VHupKN2Gzb4NUsnbXjAhXOFFOVhGwJuWmePz6gmy0PkcrrPCMxtCbHqIuAdfYZSs3JWXwQs9h2/u8kpg0WZ4XrDweIvaCJvY/PpV3SvOog2tQ+J/k99Lee6q97y7YIR7rcclSFiLdeJyze6zM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=F3CYb4lq; arc=fail smtp.client-ip=52.101.66.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="F3CYb4lq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tVPMnpWM5vZqvC7Bm07kl6ml8ryZZ4tiGmztJGnPyhJpldDl6VsgKGK8qbINijwlT9hB+CPc/2NJZX4a4UhArsY3U/GcfE7rHSbYko/t3tdLpl/vAOpyETR8x6jPO9Rvj5vLt0pKMn93Vyirxixd4rJM8TnD80XRfa35u55XHiSVOzS8i3wyJ7cKQy0nW2Q1oEmbHkKZKGLtrrgci0kRYzBNLNYoErO7GDNqXKexQyTFCHIl5yv+sQ8J1WZMQb9TmbQjgjLb4XoEuelEyB5XeDV3xRlJsH27I3A/UnrhgglTNWFkJbjq/B0L3kcXta8GM2ZF9DwoG1B8lsffOGLsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsHyGWy/d/CpqtErtZfKCzXuncCtdu4817pwGbeJEsA=;
 b=HcVaeRaDacChZ4hje2D0M3bfbgVK+AhwR8v5zd2nDzJ+D+X9GIkZzKg+1z4wsymuIMhh/HEIQIE5ONODO5zdr5HAqvAKHfIEwWXp0g3BZbrq0s62kC8wyq8IDssYmy3qqYMOFjHfiaKr7rWLKJhPEhft77rFyGAi1B6xtMPm8IoHP81AcOVbv2vRS1ma4D5VebfYRwoV+JyQIk3BmWu/pQSA2ZtgORkI64QTiX0iJ4K3yFA2ftDJMDTR78uYMdv66TuFr3UARW0UQzjeEhaRMt+4LzNp8n59cHpXadyrP97prjYS+Taq6/6QoB1e1R1TDNN4/1e9/jW73qcNN+zXfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsHyGWy/d/CpqtErtZfKCzXuncCtdu4817pwGbeJEsA=;
 b=F3CYb4lqV2Qq7Y/UU5HeXlsiZXhorb/iaHS/us/PzsT6IChsMpARkmToq3CRTUJ3N354Ph/cAqRPINAH7eKFhcFhL4q0aFLFCpmlxhHEVo3h+/8kDQd/6e8ZvEXyS2oxN9NMoVpFXfK03RnPeva1QJeBen37B0/iK8kyI+LfNaE=
Received: from DU2P250CA0028.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::33)
 by PAXPR03MB7730.eurprd03.prod.outlook.com (2603:10a6:102:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 13:46:04 +0000
Received: from DB1PEPF00039230.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::89) by DU2P250CA0028.outlook.office365.com
 (2603:10a6:10:231::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 13:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF00039230.mail.protection.outlook.com (10.167.8.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 2 Mar 2026 13:46:03 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:46:03 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 01/15] doc/qualification: gap-pics: add footnote for TSPC_GAP_21_9 feature
Date: Mon, 2 Mar 2026 14:30:29 +0100
Message-ID: <20260302134540.25540-2-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039230:EE_|PAXPR03MB7730:EE_
X-MS-Office365-Filtering-Correlation-Id: 8be5cca8-7e6f-4ae2-d61e-08de78620c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	RAaC83nHwcQwZZUwhzLeg8ZUY4b2N9R3aN4HxjERCgELyf2VcFzRWDLbU8xigGB29aW2zmGTOuOIhSM4lJhb9nXNd2fGqdlM/X4cjqe1stgJNFcUHGxlgwI3K59fRChLggG9CcoAy8UKv4evJ4uWcASVkkY06JXjO/mRScME61+TtErgB88Jyiqjf/fGR8N/Dmq7GeKm1Ez6qg1QkUakr0qNh2ZS5xV7RmNQNV/g5eW23nvxa9QTPnYWiu83x909CVbt9Ji0CDqfF0m9jsA58IyN2itk39lRotbtLuCG7M1ydNBSMrwSTR77aDrJdpBERtQloVO3LJv8b7+XcTQmUnNYrKa5k8JRlQpNq3U2wsZrbZc+GykpDwF1EC/k8nK+4LGA9cNy485Zsh3/+TjkG3uBVhCf7ps0pAUjJjNb7UxcJzv5g8MmLUySuP7gLFEyMZK/78CyjC+3SYUbKdFd5Lk41v5YHeiYwUO+QCqBbwa3axviMnv6P4BeCf/Vfo6tx+Bg+fET1ZDwsioq6SznMw6gwiLyO7yEYrkVEZeEnRFSRMCpSTJxPPjlIiNgoRCCWrovi1/xKRx3Shl75rfk/CoARx+ptzN38HSj9gdmHAiWsiWWHPpF8+ubevtVk4NkDeOiGI2mPjBncHY3GyvSK0g+02pC3yeM2VleQeCpg2DTk8qv2nNThVCZBRI3hItb7iE8eDbs7vkbZQMB8mW3Q9Bq/i46n3u/Wz3YsuiaPBRhqwUwPFs8sKFWMfTx+dRWFXwsVwfnmloUj4AvNMaH/dOMgRzowp+gE5Px/nnR1HLSQQDbnNUpb2ZRDVTByIz9Wtjo8kcY089o7xCuT5r5Tw==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Gn5yMbVewFzwr9ZMVJwCuAfQamvKZtnTICQSTkfn05P7sByZrJuvgjdnQ4IomScqI5C2gYcBtQNzXD7DJPCAzT5jN3MQ4DVuBIDTAycmlQLXTkTfZV1M2ZmZeIY/WbDP70dsTUw0EuQBaqQXtD3n0Nyaf7XQwVjOlAZ4FBl62xlEM2asr7X2TaMag6sRNn7wd2G4Lnfpx31D1qy5QqC49rdYH5hrHPC4iEJvi1d5AKfJoWvJK5vudGbA79aBxACLeyujmJJ9w3ojMgFaejJztieOvwBT/gVUlLPAHyesXEmBKHI1XTRi98Ze9qLKkk4MSSuSq2wwToMVZ3afn/w7RXe40CBmdoiuwTSqqmrbIPmchOmipjxCxePf8OnxenGS032Bvxl8l84O3Y6fwuGocICdfiNifj5pdMmPCpQtf6njFiMTw/HN0VepEFDAOK20
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:46:03.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be5cca8-7e6f-4ae2-d61e-08de78620c2a
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039230.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7730

This feature is not supported by some host controllers (e.g. RTL8761BU)
and must be disabled with such hardware.
---
 doc/qualification/gap-pics.rst | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/doc/qualification/gap-pics.rst b/doc/qualification/gap-pics.rst
index f5b63a00ac98..c9d7b003d547 100644
--- a/doc/qualification/gap-pics.rst
+++ b/doc/qualification/gap-pics.rst
@@ -832,7 +832,7 @@ Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
 | TSPC_GAP_21_8    | x        | Peripheral-initiated Feature Exchange        |
 |                  |          | procedure (C.1)                              |
 +------------------+----------+----------------------------------------------+
-| TSPC_GAP_21_9    | x        | Connection Parameter Request procedure (O)   |
+| TSPC_GAP_21_9    | x(1)     | Connection Parameter Request procedure (O)   |
 +------------------+----------+----------------------------------------------+
 | TSPC_GAP_21_10   |          | Data Length Update procedure (O)             |
 +------------------+----------+----------------------------------------------+
@@ -848,6 +848,18 @@ Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
   otherwise Optional.
 - C.2: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS",
   otherwise Optional.
+- (1) Only set if Bluetooth controller supports the "Connection Parameters
+  Request procedure" LE feature, otherwise, GAP/CONN/CPUP/BV-08-C will fail.
+  To check for this feature, run in bluetoothctl:
+  - power off
+  - hci.open 0 user
+  - hci.cmd 0x2003
+    HCI Command complete:
+    00 bd 5f 66 00 00 00 00 00                       .._f.....       
+       ^^ 
+       ++- This byte must have the 2nd bit (0x02) set.
+  - hci.close
+  - power on
 
 LE Capability Statement
 =======================
-- 
2.51.0

