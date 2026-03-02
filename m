Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010015.outbound.protection.outlook.com [52.101.84.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F1430BA2
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Mar 2026 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459466; cv=fail; b=P/sLAGFA+Hl4BFSrQZ1MTPI88vwkSfFDYsfbl40IuB4QzmV3Q0hTuF2lIs/BkKgIQBwT+O85rDpP5n7XDO2x0y7kbEWdypjERuSqlhZrWpGgX+bTULIKItVbD96JLYtXTCrJLjhqkoOGB5wzjpeXq4HL136siscmduTYWG4OrTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459466; c=relaxed/simple;
	bh=OoPJacQvAtoahkMAq+Ears5JU/jZStoGtLMVPXLUIjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LVipPmoH/Tcoj1rtrQobVlwNGK90rmPRkzcu8T9aq7uxGoPub3nGS2xyPJbHa5H5Y8PxYI2P2180K7TDKS0NB8g31IhV2gZpuAbYQB5vQQoU7cXfNY49CS6ONMArdUXC1FOdiFnPHPGafEaP3j/87nSD4ySCbXYLDd+EU54A0hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=L2EifOxl; arc=fail smtp.client-ip=52.101.84.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="L2EifOxl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ba3bY6enspnquBrpmXiR2br8eSl6709qDdI2WSPTnTMU8w3yHNIbhPhhLO+Xav7sahUM6HLlvfj5hUR+Hd71y4yujbPBu6WxgT/M8ncPA2j4YUV09MjO/EdrqjyIVrnqzGf93EeS2M6Ea+79YPYAVtBcVY+UfBhdVbDjYMEcr74F2043xJ+63QgUxihd7i+gslASQ3Me6CzijQrA8ztU6/g7eqqeTknhB6TeGY2wFpJ4cwTaMFPtG9aZrXofPLScRluuksyLXkrOaUyZBwhcg1FmhoOsU0lkVxzWJE7Bqt6Pbi6SiixDFHGvMfCjjAPWghtD46wfEjimuEKUKnNUYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1z9Zm6kYlVAObxRYFQmk2Sc5CIlxO73dOxVNXCnXN0=;
 b=ruIOZO7vTB4eyta2McnZ2Q3md6dVt9HKlqV9Z2B5QBfqmxK8DOoldOGWofFSspYPzvvfOyswrZFAzgq4JjdM+1De+GDUk9HSc7FS3WII9OSedLRJrT1xspwaoLpYBxGS9cJF6cN2bvc/4F5eU0n8D5znKq3xBcfZXRIplgsUdI5FUsYnsm1XrzAj0WR5DJLqGmMrBVnTDjA5qq/zIwDti49bPs+yZsIgMEzyr41p4rJCE0anEE5a2oZn1Yw5EOolkFstscvHu+Y+2u1uCJdGKq30fHoaQ6ZBbyJKhTOzny3pqoHZ8eGyAMPmTlIoO+A/CYLZxMCouiBgvJOgFlIkUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1z9Zm6kYlVAObxRYFQmk2Sc5CIlxO73dOxVNXCnXN0=;
 b=L2EifOxlUcRkn7g8EPHHP+hZirIS6aQaspIoPIP4xyZT8jCavB8kfTBoneA120WAoZ+1NB503yD901o4qN8/D5mMBIfBD9gQIAnlns1Qv3uEkRFfTz/+yG9pRSXZAuSFmn4zW0UAiuXeFIt2uN4BFQH6fV/uhAM66R4bEhBfia0=
Received: from DU7PR01CA0031.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::10) by AM9PR03MB7378.eurprd03.prod.outlook.com
 (2603:10a6:20b:272::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Mon, 2 Mar
 2026 13:50:59 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::c7) by DU7PR01CA0031.outlook.office365.com
 (2603:10a6:10:50e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 13:50:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 13:50:59 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 2 Mar
 2026 14:50:58 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, <ceggers@arri.de>
Subject: [PATCH BlueZ v2 13/15] doc/qualification: gatt-pts: add description for GATT/SR/GAI/BV-02-C
Date: Mon, 2 Mar 2026 14:30:41 +0100
Message-ID: <20260302134540.25540-14-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|AM9PR03MB7378:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb6735b-5e52-4ede-2015-08de7862bc66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	4exX6+WsKymKahJHnU1ye8wVDDfMU/JtAZn0IyKbWBqKfMrZrN/S9T8w0O+uZLMQcto96OCAV6vGQQObzaC6JYau8CJBB0pMZKBXwAVU4un15NKTRliANiY8nOYksPn6g/Dva2yht++1/iWl7MnKijSbXxfxR7VcpNyHWOoyGvI7LltzFFnS0xq/5FicLzGrHVe7btxguiPmMFz98HDwuJvWXuXxwLDwsDigfYcAVb56Fakw+ldon8VbhFaM3xE+CWqwUMcM4wSBBiVzqHDNBIRtTmNcYJOqFrZxGYQ6o0/61Z72z7lxIEiY9Mop4FUuLnYmkMP8XstMjgQR25aCDltEtNyORcWVRWo4JkNkFnBrUKH2Qg3HHTYQL51ej/TmQqS0LLhQ1vZhXiBVRi6GrzMCVqMHmKDNTfoDqRRGlaHmxT33fSwWACg4w2F4qX6Q2gxO5z/H2d+jwQIp5U/QVmTnMIPbjY2Op081q0b4difk/xeT8whDfLLNQpHGLgWUkUfcd+4uK75RVFTcFddETvrsjk8vajeyI1sTku3GnDxr3FCvdyJUSPHeqVLxhZ6eLpr9ByHSEVzwSHLBzcKShtdzzeocBId0UsdwXcdt3XRegGaQ4rSrz8rfu5GRrAhrmS8sh41Z7wSIjV3cn17VZFf5aRZfK3nCeMpC78D58fFuzYBH4n85X5Mm9+J9Alk3XU7B/8WyP5KGdEG7vHZh/5uCL6o820w1mUtN61xmAVIeVmynbAjsuiRf+6Rwo2FwRkFaS8mTDQwiq+A7YCwLQc4usrryT3V/hgdt9fWZeej3WGCJXMeWpUIxDA9U4F8zto6KF2zmITXL0Vl9hrKw8A==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XT7PdCOGksIn0ivOLwWCTKb5cZ3HWp5QLrCccEmfpFirGBSjdqDbZwCbwiIfI8QW41s/o5jnTG8iwiu6p7D6DUfGpbzu1mUQJCh0l/QmyZ+GjS0gtUkgTb+I0rFkKmiMbuiqlkzPLAE4ZOfwBz6B7Qq5J33o3mWXQkH1fqkMAkdu0fug8DbgkT5JiwXqXCiRLYzimy12p6RARi64bEzs2P4tO9bi+QV9n4mbh0u453gMz5Knvvx1T9SVisx0ALJXdGmqtyjmtp7FHLsYmuuYLaM/nTH2ruV1/jm0olTNl5QMAXGn0sIJp8OP1CMVnRVnvR/JkDBjkdImgCxpn+Xn7WLMj3b7PJJYEokT2pQ9gb9U1Zc0dEYMejh8x1kvMSDWlNmmzQL7Dff7pJ3kZOQmF1eurveDu3TaNMCweYg5UUx6rDYXLTGbIcn1dzbHOasQ
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 13:50:59.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb6735b-5e52-4ede-2015-08de7862bc66
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7378

Same as for GATT/SR/GAI/BV-01-C
---
 doc/qualification/gatt-pts.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/qualification/gatt-pts.rst b/doc/qualification/gatt-pts.rst
index d836e5fb2981..a6fc07f69759 100644
--- a/doc/qualification/gatt-pts.rst
+++ b/doc/qualification/gatt-pts.rst
@@ -1178,6 +1178,24 @@ for which we know the test passed.
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# gatt.register-application                                |
 +------------------------+----------+---------+-------+-------------------------------------------------------------------------+
+| GATT/SR/GAI/BV-02-C    | PASS     |     6.1 | 5.69  | Pre-condition:                                                          |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - Run 'bluetoothctl':                                                   |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# advertise on                                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-service 0xFFFF                           |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - *yes* when asked if primary service                               |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |   - [bluetooth]# gatt.register-characteristic 0xAAAA read,write         |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       |     - enter '1' when prompted                                           |
+|                        |          |         |       +-------------------------------------------------------------------------+
+|                        |          |         |       | On PTS request to send a notification:                                  |
+|                        |          |         |       |                                                                         |
+|                        |          |         |       | - [bluetooth]# gatt.register-application                                |
++------------------------+----------+---------+-------+-------------------------------------------------------------------------+
 | GATT/SR/GAS/BV-01-C    | PASS     |     6.1 | 5.69  | In a first terminal run 'bluetoothctl':                                 |
 |                        |          |         |       |                                                                         |
 |                        |          |         |       | - [bluetooth]# remove <pts_addr>                                        |
-- 
2.51.0

