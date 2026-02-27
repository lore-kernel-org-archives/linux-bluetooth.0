Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FAC441047
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 16:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208057; cv=fail; b=aN8+Xlx/BBOUGnq9xbt0Zri0Hb5Tkne8SCpncDkBtGr5bKP3xdJjB5qzIiKmAFmRLrOnFBtSiVsRrSTBZLQa/4LfFsv5kG8r9QUXz65M4UzRrldlO+uAKBPyCRmnhHX76+3XxiisZtDyGfdYlxQCZAEVb9+CwfYvxAcWoDxrS50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208057; c=relaxed/simple;
	bh=jztkB+Xvh7x4Ybp1zC3d4KyFkkvjX2BfXwPEOF4tId8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjVc2sEo5vEQM+zsKuvKwn6EVZDAX22Tle2gNhSqYRsg+1xRvzjuexr24oR7aRcQ2o8RdTluDOI0gobvsDZs0ktMK0d7OCfXIwtskW+Yug+0TeR7kfYouku26XJHZuymQqjsan5tI6hUc4TftlCPM6zh060djqerM3Zc46ZdTqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=XpdXtYtF; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="XpdXtYtF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cFQY3t4woI7ckRLGiDwL21oxaAiHa+EEASM1+CpFOzOIsf3TDQllee40eRmEcG1qxO8hv6m1FwTcCEhw6uLfXzY/4cyiZBwgCyUVBAZ+vlggGXx5IwoUc9angFaB/O/XvZ80GFZEefZe3mhEyPDG991NoojI3I5AOERe+2CyMOKpFBn1HmYlNthB1Tt7DdGO645s4SZnvgnzGXy76XlMAK9UOd5XM2lVBnez/8AaJi/GAx8cPoHAcdfBmZQUv+IjImYPQcE93M36JKI1qolAVD8795P6zTCIc/kNu15oSmMkb0L27kwbySvEMida2Ss7F4io3Pt1UCXfZAy2FPPzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYcjSF2U07LdpeGYknjRzESOeGNQc6ME4S1bhdUH5ZM=;
 b=PpH/ZsaOlPOxlV3uqBzyLIRaigODcpp0GzmzlM57zHqxJicYEnX9yItgPOUzT2Q+EG1QJK2ke5jGywZ00SsFYEnX4DmHdj/IZh4iVV47F1LSlwol+l8XMuc3MH/Bzwi7fPcIxwYaPQjIFXvuruR3NMGFVfNmTxpB5gbFMprKt5hh32PxujLYmBbSJwnXMSxfXCzG2glmRLN+P5gPjLtF48liRAEhVQT9xAElrhL+XoEJz/y2JZJrrUdFq9ZqslMmpgSYL7PvtTaevNOBm4qAMHHJyVaNVLDL28hH+0sJs6lpr1aeyGKL2ZUElgO4m00oTtCgrGnEfu3xBt6mY/kHiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYcjSF2U07LdpeGYknjRzESOeGNQc6ME4S1bhdUH5ZM=;
 b=XpdXtYtFIBuM2i3ceiEPl04dh7UBRhqYI+NtXg0NXbk0CfWmOP2J5Dg9LMTdBU8bdC2U9q6La4HtZvSCynFppGJN1db5GZZjxI38uZTWYa9ZUIk8uXs+/41TWbzdXqXqBIxl901zqKrlmf+vVQ111H6CiqdLR6d07IS5xDgiGJk=
Received: from DU2PR04CA0266.eurprd04.prod.outlook.com (2603:10a6:10:28e::31)
 by AS8PR03MB7271.eurprd03.prod.outlook.com (2603:10a6:20b:2ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 16:00:52 +0000
Received: from DB5PEPF00014B88.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::fb) by DU2PR04CA0266.outlook.office365.com
 (2603:10a6:10:28e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 16:00:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB5PEPF00014B88.mail.protection.outlook.com (10.167.8.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 16:00:52 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 17:00:51 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <frederic.danis@collabora.com>, Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 01/15] doc/qualification: gap-pics: add footnote for TSPC_GAP_21_9 feature
Date: Fri, 27 Feb 2026 16:53:47 +0100
Message-ID: <20260227160022.21462-2-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227160022.21462-1-ceggers@arri.de>
References: <20260227160022.21462-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B88:EE_|AS8PR03MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 96af2e6a-8a33-4644-9aa6-08de76196209
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	7K2sE2nX64Jm+UiGv41/zLPgcdgQCwycmZ/G3HX/fHshnNIVH5lIrrAPEZ2hwVu0VdbNW69pLjLU2zW8jAlusb/xPIdM7DqioTatm4P6yZ7+Byb2TtTls6MfsEvdJhnIzt3me3oj4cSgdV6IV1ri1Imx9Z4fDtVYXFEq7/aGxr7PHDBwCrkvI2KyDVB2qdiSLItvdbA4mp9k7LwKZxgZa27NInzZpXOBo85tB3vyu7vgKoTz7FqU2LGBe90ZFiR5DJwiMb7hAYJp/KP3dtA4tfLnU6cjpBqZIG77iU0OrBEkv/z/ySnT1oKZwmVRH4wQ9j4lh8WpX61na2uFI645Kglx9d+tTqhc21WtxKEKheb5M0SKZ7l799/5hbyKHwmqcWJo9v5UyQC3v3aOgBHklK1+a+fh3h8/10UrjQQHF6Wa7wbNsZHSyNSEYk98asf4u3kM78HFxgdLp8udJ8ZpEKDYdiDZVJEQDKTcMJzRs9z7UpmEBR5u+O5seyw3HHu/9R7Hkc/8dQNKM8LfkP7HLH/6WIg+7+Gg+jX26MYJq5HN15wHsNxsIvumhcye5MVz1RfhThGuXpv2t6f2TuJafhjumvwt2QbqjD2uqUa+SnHBj3XO0Sy4obzMyWrl2gS8IGA941Mn+30x10Rvlo9qEqn3OKFfZP2pf9IL8h/DZpUT3PYZxCPHyrEn5qrXpQNHNXBkBRYHnBxPTnA8qgPmwx/jld08RYhJi/3POdM75y9SpovLnTmy7EU+vx3/iWtUGRJ4DpSjZjsylOHz/CRXk0PzGE6m12Jm8upgymXKKyyOkfmixn3J4JY/bg1rCYgljnnQ3gjEozdEa5FCTLwndA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	B1qs8Ve9JnCinUJeqwUaD3U2EsDhaBRrRCmHO8dpf+T3kWUS089j4VGKZZl9CWTa3UG2bwe7qntXYMtrjI/6ba0pw9dYKAtv1Zvu8esdQ85tut/u5+5gzudoWMa6Qa6CaUuIrib4RnitGRY9QKLVrJZaPGt+KKtXr4mR1P9fU5wQW37yeQ8aH4qmECJT+rKUodKO0zIgg9xugIkitESM5NTaMEeWGSly3xOElX+LhgFStG5Rfi4lTzbPY9zpvnP9f/iqIlrc99z1tBe1J3j+TdYqpREfAQXI5RVJPojAop094FqxXYJVj2XBMDlVxW2RVVR94gsE+83P1UiAZAUvRKfN9OjW/l8z9K+d48o4rAQX9Mr2kA838JjsHczaUwE/Bq5gW+sQs0NPJ12tIHJC1GtOSkw84jGO0u1IzmbHlONd2+xrLhbT9hMbRlJ4A4Sk
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 16:00:52.3520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96af2e6a-8a33-4644-9aa6-08de76196209
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B88.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7271

This feature is not supported by some host controllers (e.g. RTL8761BU)
and must be disabled with such hardware.
---
 doc/qualification/gap-pics.rst | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/doc/qualification/gap-pics.rst b/doc/qualification/gap-pics.rst
index f5b63a00ac98..d7673e5da088 100644
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
@@ -848,6 +848,15 @@ Prerequisite: GAP 5/3 "Peripheral (LE)" OR GAP 38/3 "Peripheral (BR/EDR/LE)"
   otherwise Optional.
 - C.2: Excluded IF SUM ICS 31/17 "Core v4.2" OR SUM ICS 31/18 "Core v4.2+HS",
   otherwise Optional.
+- (1) Only set of Bluetooth controller supports the HCI_LE_CONN_PARAM_REQ_PROC
+  LE feature, otherwise, GAP/CONN/CPUP/BV-08-C will fail.
+  # cat /sys/kernel/debug/bluetooth/hci0/features
+   0: ff ff ff fe db fd 7b 87
+   1: 02 00 00 00 00 00 00 00
+   2: 5f 02 00 00 00 00 00 00
+  LE: bd 5f 66 00 00 00 00 00
+      ^^
+      ++- This byte must have the 2nd bit (0x02) set.
 
 LE Capability Statement
 =======================
-- 
2.51.0

