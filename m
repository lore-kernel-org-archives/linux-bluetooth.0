Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2065.outbound.protection.outlook.com [40.107.241.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7191F2B83;
	Thu, 20 Feb 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051624; cv=fail; b=VR+GKX60Dmnr0l37JRj0/ezrr+nW3vGiDJKiAFsdJOTixvi9cSwdLLPDTlVtwXFxp2Ma2Ak7RVE7Mqy95wF/slPI86GV0j12CCLIqw4mYXp5w/2/gIKSC/L6nG2uP77ZemCBc7ruPxCAc1nVyhh4i9dpC5vJEWlCxD8AdIs2DoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051624; c=relaxed/simple;
	bh=QKilRpM1GOK0/1eazCteUzILU5562UmYG8xApcNXkRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BFfz7LiAj5RVqXP6yg+FUYe3X1wuYDBOfU/JtQVdN3dIwNkwSz/PaQHx8AqcuR7PsXiil1RfhmZT4vf1F+lAkt33lBHfSltklLO+jMeK9oGcyPCn0aozYTdJ/nmfbRF/4lXiyLVbdaxCmOzsplVEvxS/NOqxkUydNLg9kn/McPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cVgwjfAW; arc=fail smtp.client-ip=40.107.241.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cVgwjfAW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCUzaLxQEM2Qux50GGHti2j9huGsqyZDpD4xwN1M94EAie0WRsFFvHIx+/4SjvU7Me4No8sp9l2S7xAL2vMoKQUmbaY3Q9vzPS6Q9Muj9AE1nGWk8b1UqXQakKsoW4+63UbUFg5o/ZMBmnhTU96Zsl7wcdvqIJ6k+kmV6IQ36945tVplOinQBjMd2LMYhcngeCs0j+8amXqqUvJT0CP6RTHOX/BymtlMx04REjhuQA6/hC+kgEiJEbRApKa1JigcfAJo28Gbr/pGVAQQXl5Vx5eM8N62YlUFz5I5iWFAilvzJaVhh/9alVF1z56W2ll76hY6s2vEXU9HExr7a+E3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=238kcuI9VnEgk+SX0WJmEK10qL4LdeTDe5BiGl/SIVU=;
 b=kXqGiUuGwHIeJ6Rps30rh+6dug/yGVdFG0bFaiulWjo/1zNkGMACPNaLGMLfEtBGh/Bsfnr1Fxd1d9v4BgLVjb+5OgfV2PrlWhN/TI6qKDvIxmHYSqbJJIthDobbqhJ0f4x3w4PiYIGCLKytZUvTtrpzkeV1JASr/O1LtQGiNtWc1IHVTITRAydY+1psuDEbmF6q8fyEzGz/7tw9pj5fGHwZN7ne6FXqSkQYQgyzvV6lW2xzCnGNZlO9BpxcAQeQvmjAbzLjfOxGD1QyWPVmUcVYguEfTUITbac6x1k1f6KXS89muq9TTzKohbxFCYvgiUoMKb4m4xKA8udsvyGn+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=238kcuI9VnEgk+SX0WJmEK10qL4LdeTDe5BiGl/SIVU=;
 b=cVgwjfAWFL98sgRkvcT9khYBLRZRu+MUJuWlBdrtaZ1ZOeK4cnl/60b+m/aD5CL2G0Kwa9YQn6cHdsIFIIMLhg7OO6Bj9wDOEin3rL2EYng7LudW/DA3KX2tTFUezJKpYy2P0iWMwPgef0wN1x8f4t2fsHOt8HcrFX6aVvbJzXCUF6vLB/4XVMNXn7J+lm68Fjwr+XBnrX6/e0BjznMtWDUGsuWG1Or4i+u10aMX8rBuJoRMvZLFklB0XEvCe6VkqKIRmC0TiUJ4+Flc3d0ZZiIEptArnminlJkoXq/Gh0OnTZ8LhwweClHus6+bv3pF/fXA6YYX2nFz0cf4KlCz3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM9PR04MB8827.eurprd04.prod.outlook.com (2603:10a6:20b:40a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Thu, 20 Feb
 2025 11:40:18 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 11:40:18 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	johan.korsnes@remarkable.no,
	kristian.krohn@remarkable.no,
	manjeet.gupta@nxp.com
Subject: [PATCH v5 1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
Date: Thu, 20 Feb 2025 17:11:56 +0530
Message-Id: <20250220114157.232997-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0027.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::7) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AM9PR04MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: b0df1bc0-4fe5-4352-1f88-08dd51a359c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I++on28vtoCDzwpyA/4qG/m1SNQM9AqY9DBFmeH8+3L4tXXZopIDUOvYJEsV?=
 =?us-ascii?Q?5qDu9mgKCZGkqs4YhFBNyWc5MxEOvu2wlu4wdgGjyn1kPX/+ZxJRnDB0bPEH?=
 =?us-ascii?Q?XrBLZtKYWFN9gAeDxDcHRsHpZj2iJ5S4ZPXLnmMfy3wj7N+ENwKqIYRYHQ8I?=
 =?us-ascii?Q?OUhtZYxkxDBFrd4SGVtRphGTBWd2plLGP9yk5Kql0mEwZ1Sk6lbKO8mptVcW?=
 =?us-ascii?Q?M/VMG/N7Yhj4kjYq81GhjNbR8xklddZDjwZRdsxWGLjhIBEKEaNLvvHkJLmO?=
 =?us-ascii?Q?esiHUXXgWgULi4OH1HD1kQyM0iONuG+CzjnWMZi35Ut091l7NF6j2oPki+A1?=
 =?us-ascii?Q?7MRvHVWHahS4B6I9o2r/vO2PqziJ/uwhON4cfmtHCANIYfgEHIVJU+gDWZgp?=
 =?us-ascii?Q?horwJbVQuifrSsNoYrmLHUCe7GSJk1G5ZK6FmJxffaQLK3GODBLeWSDG9GOb?=
 =?us-ascii?Q?ITAOv0BS6ABu2kH1MJw3dSA/v050W2xjijsXZPtmVZ+4AJhV80Quyn5j9qyG?=
 =?us-ascii?Q?5y8yD7gaVit3ThGk4q0EVfChspxACWdYEdhwliLMzGTDmbyI4wtmq4EUnGZ/?=
 =?us-ascii?Q?qFxtGCkS20u8m5fDCkv5K8oZBYnNoRInl5Pb2PQv3GvOfS5qmAuHfGpVyOyp?=
 =?us-ascii?Q?MhykYRMW5URH73BuhHX9UoYjHXESa+6ItwFMgwGITdFPWeQL6JTnovLCeOI4?=
 =?us-ascii?Q?YX5qPW1dXugyZ/vHJCBwHCdWLlWVf3EvWm9L1sZgIiaIpGQCMqrwVP++YceB?=
 =?us-ascii?Q?GGlpjC9q+8KwKsuenf3GnAVKLgE6NmD2CA8UzB/wLwUyifLS9G6az+VSo/ek?=
 =?us-ascii?Q?7aHnPl536UUpO7aaj1BOEuFbfrHnKiE6xEXuJ+9T1sBjSSHNIAIV4HbMcNua?=
 =?us-ascii?Q?JgV6SsBYZJComOtvUJ01QQdiBGF36p6EK+gwEardpYQgcpI8olRg0PeShwZN?=
 =?us-ascii?Q?8Isp7l1LOzeWMs/ZKoet3WEhxBopB2LYuJqJS7jv4Z0TBCtDqkPr1JuL5MSy?=
 =?us-ascii?Q?L9VlKPy4THIaCKbXFOjGi1gYn4ed17SlXsb71EDtgxf+hoMUlW1hnHQs2Hir?=
 =?us-ascii?Q?vtKpR+8hQFeTAWP6oEar5k/sAMQS7Gr674Bat3CkDC9oUPowF9MMB0Tbmyj2?=
 =?us-ascii?Q?42pCrFwbViqJNNIUdEilvOAaai62+s6x+2S+zCITF5ZSt6U+IG7/4zZRmh5Y?=
 =?us-ascii?Q?aPejLmkFtTd6Pd8gGgyI0CN9nQ6klupvZonOVtzB5tHvhLHv9ceu9aGvtDit?=
 =?us-ascii?Q?deQE2FC5PatqHJmFaB6HQORfiXCjhlei2bNLWBxsCZpz3La3x5kpHRkmQO9Z?=
 =?us-ascii?Q?bEwTODTIYPzFg1RiClki2zPhRTKEBz3EqGMWuJICTOJjwiggQwleKGpoPx+Q?=
 =?us-ascii?Q?rkKvrLTf8LeJ/tVT5PE8kABWhYBouy1BwFVBSx7TjFLTIp6EgnYIJDVMDrWh?=
 =?us-ascii?Q?uPfnV5sZT/XBTL6+cgw0PCSSyHiu8Hrg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kea42EPYpANj+UOWlBSrniofdi/xgFVmMsQN0AF7GpmUD7YPIbsD+zZ2Khtx?=
 =?us-ascii?Q?/jVrtY4zqLD8dGQgFpEANNw4uX0B7l5ebzU6nhKUI7qKRWCnfrx7w43/aw9z?=
 =?us-ascii?Q?p8y+vQurX6Ecb28P64Fb2z4o2QqfVwy1TmjgCf2TeVMQjf8DfMm3F6QpIwhW?=
 =?us-ascii?Q?oAikElMor6Rkgk+RCa3s3iDMD/wn2e1DlmhNUhaT1+W/xkH/4mrd8OsVnvne?=
 =?us-ascii?Q?Ghvus6UzsJUqVRhOL6yQz88rpao+58ezfZPZEzloHje9oRsv8aixG1Ggw6Qc?=
 =?us-ascii?Q?1jrWm06A2UfKKwnp2q5saD8BTkvGmfE3WSA2kIiziOBT17zQF03M2a6/cQE8?=
 =?us-ascii?Q?AvfzzVL4y6VVpc4XVd0QW5vld3t/oGGzWPLhaeK66UEr/0Ge3Xd26Y0S78Uo?=
 =?us-ascii?Q?ObcVJfAtzWkDu//s8TAk0yNNkMjZk7UqoKAEd1yeEDSiCpGN0UQg2zHluV11?=
 =?us-ascii?Q?Ks1h6UYmgzjAZupxtaR5ditW4s0dkXKbLQnG4m7E8Mhz0hDPOO6fAdE7kZ4t?=
 =?us-ascii?Q?kop5fZEiL/EIXvF8i3iaaTiTuvYHW+cMoLOlOAK5HWBhNQZLwkpTDqAclamV?=
 =?us-ascii?Q?2PEZgakDNBwxS3POSpWMATbF/2oHu3iZgJXalueCxKsbgH2anGH8rVQrZ1fd?=
 =?us-ascii?Q?f6luOdFMDazcAsYSt+gUjdi1/nmBGQ6U0kqNphTb8OIbVdbC9cZZ3oI6brDM?=
 =?us-ascii?Q?nzzKSG4Ebdv5aIbhFhm/TfEZD+hZeL7cuqkVEfH3nX9dNRjCD9ZZUXHrCoB/?=
 =?us-ascii?Q?uPshSO+8nxiLe9u4qb8rRe707OADrY9CQyoOXdq7al4x6aZUSpIfDRbN0AyT?=
 =?us-ascii?Q?eS7P3ScP+wVGkrpT+0+IiKFifMYhrxzGdkFVtAzD9PHKKkYLys/ajm6tNlis?=
 =?us-ascii?Q?/NkQ9aGKX9jO6X5INdEfKHc2TBhF7bP1hr4j/lnzdhPg//iGqx+z8DHQAlzr?=
 =?us-ascii?Q?cArSUiebs+9yGlRmh1R14oKmjdkTSZuLcOfJnk4IZlwdcZZRSgJBzZaKvVcg?=
 =?us-ascii?Q?0nqB6MEsgNQegsy76VjM/KtCL54PF8WSQGFNkRogqzLR8gNOYmrZbnO8hYQC?=
 =?us-ascii?Q?tAe7bHr4vAd5StC2YOBlDsPz9yn/bVu4uq9hqRhCFfXPJeu63Aj8Cn4g2UpW?=
 =?us-ascii?Q?+xOtsVdlER5A7PsHTP0eZLwpEBOxl0Cq5Wq3TO7BfhQ4BSQKbAfNCr03NNZw?=
 =?us-ascii?Q?lWvRsBcCuwjkRzR8MVy9L5xI0yahs3iSBSBKmu261sxpk7Dy5t4S/NEiq6Hb?=
 =?us-ascii?Q?OAYeKNdn3mygLrQ3F2DK1wEPT1FAEl6HY67M13fE+OjfPjewuSp4NqodLOnd?=
 =?us-ascii?Q?ENp/jQuD/10D+oVq/4rZCPHizvADvBPiHdul+uSnxGm3j+JWO1Y+dLCITcPD?=
 =?us-ascii?Q?ShzVEsgAFObqFfxLSeBDPDxW71OKVUYdHhCtslMXzRVsOryRS6zYzWaFWklX?=
 =?us-ascii?Q?pN/cDFZn/kmAEQ1BRFTteSiGlrwE/LkiESbl57cxQaet0tFdpdfiBDg6Bqxf?=
 =?us-ascii?Q?/uPM2hFSJYFtMt6Jr5VdicoTlTGxQBc2lFbIneConQfUN+R0ylFZPdASWF8X?=
 =?us-ascii?Q?wqZp1EYhwp4pjojmXDmjoEqQoLGlYBbjyPRcucN/rdUR8jy0+LelID1xyGJn?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0df1bc0-4fe5-4352-1f88-08dd51a359c5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 11:40:18.7410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IvfUuVLvBR6L5FVeW1zyYoonlcqv+UNYoafuEqWjHEiOp3H+iozbHkCFVSRWrhOrUKZ9aqtXmiIFA5vResoTPGL6saB8toVE3DuZHKy1dSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8827

Allow user to set custom BD address for NXP chipsets.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2: Add allOf and unevaluatedProperties: false (Krzysztof)
v3: Drop local-bd-address: true (Krzysztof)
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml   | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 0a2d7baf5db3..a84c1c21b024 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -17,6 +17,9 @@ description:
 maintainers:
   - Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
 
+allOf:
+  - $ref: bluetooth-controller.yaml#
+
 properties:
   compatible:
     enum:
@@ -43,7 +46,7 @@ properties:
 required:
   - compatible
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -54,5 +57,6 @@ examples:
             fw-init-baudrate = <3000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+            local-bd-address = [66 55 44 33 22 11];
         };
     };
-- 
2.25.1

