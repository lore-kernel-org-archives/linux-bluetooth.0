Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06F21EEA5F;
	Mon,  3 Mar 2025 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741001168; cv=fail; b=POTge6CqRbRSBBgPkOpZ/5+7AgORulIiUA//3DTpamb4/rJ+EcXso6QhaCNGSfuPjccN6KjlPoj2bftnvNQjnGFtkge1A6GCNcV7xuv07GP3lN4RtD3/XBJl5bXWZgtw9n0CY+GvHZfAoex2e/FjG30ly7YVvof/xZfixo1IvkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741001168; c=relaxed/simple;
	bh=UuFwMo6wr1pcl9GHYSVFb4LCh1HqtlocFxSufZh/N2o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DcEcLQGaZ3vxn5feiAoZbuGJRxe/t5of1Q8hM+EixxKjUikCyYujR0PplyxwMLpZ/PbhTzYUokmNLHkkrfnh3Em+N19yUqj71KZOo8nhDEb5TqZpQoFvmHv716ZLEa+3YfiJLs4vxGBHmgk3E2P1EBw4yp7M5BiwB1ArOr/tBxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KSL+Amap; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KSL+Amap"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZTTv1fnc/N5GhXkEu/zkNaeYtS6F4vkeEVPDJ9VM0yZHrRKLbZRMP+xe/aT8/bWDPCXjL5euI8bY80PiwqDIqS9nGaAi1BT7w8kAfXJuSc6D1VO39QdvU/uUmKmE8qBr1N2CyTyYNUh6Q/BDHGAQmcBKOhUwN4ZcXJeb8KxuPJTyX05KwiFL2SsfN2WbgUhGjo8/eLMWhLu+UhvFm9MIcquWnd1swAc0zpSplKVFD0OnzyEM42tFKopK+KTE4abZEv6I5NbScuElN5WTyUGMlqWv9zcqcrLJFRBcf6pwIfOxAIEDHhMaT0zGr3GcXCN+ZPlRwU6wZSaT0f9YNPSAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Kc9h3Y2ZYHdDU6Cs7gxhOy5j9GQLx1w5aXqhLVUrIg=;
 b=VnnxWk5UJrbCFuS4qEijHAUG2rXWtTY7T21p75vdIfbi3h2qlM4d5jCDJT8hAH/P9+ZluJPHX0vu2JHsYEUy/7mPQbN25B4eDN2EpdY6ogekBgLnnudWYxNUyeKfLNqVo0Ni2RXXn6Mo4w24mJI+iTVxncTmWOKA85MTDSoWn25sCu1N5js5vSfSVNCrTSgOS9bv3bdRmB7G8WX5+V0lz0hRmz1Dsn6Epx7N6L1ckccyrtaxfaBkJtaCXdVA1HgEdVTPqrkjghVbbzbrfhSbAZtJkrH4QknsT8qYVDkXdaHX3awJnpdtj/PxEONHVZv9QttrcQoEGm/rOAjVdlyhqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Kc9h3Y2ZYHdDU6Cs7gxhOy5j9GQLx1w5aXqhLVUrIg=;
 b=KSL+AmapXu+liIf/9LAXCMw6PRMhf3ja9BSkUtm7IVL9k0lZ1iVDIaSs4fydBjkxQU+d21C4HOqNxaqQxMddXJ6oz/6bQsMtZgf/JbRA6tn+tgbVCoscXPl6qGG4saBiGJhboeFvhqO+YAAVp8NWkFn6sOb2k+CWNn0cW0zr5GOZtyf2a/775xl4d4O+/61yL41bYRrOAEAWGTBaJy74c1rJlzwWE6alf0/w9ao27quxrFSJN7euKUNdBVWBeiapIz2VCjXWBc/znf9inLVPpMcGmUV5hg9Si/MrXCDK0e74K9azkaj1VcC+7gVvZyb6LldFejOYmGvsBgBrlSe2Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM0PR04MB6994.eurprd04.prod.outlook.com (2603:10a6:208:188::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 11:26:03 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 11:26:03 +0000
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
Subject: [PATCH v7 1/2] dt-bindings: net: bluetooth: nxp: Add support to set BD address
Date: Mon,  3 Mar 2025 16:57:51 +0530
Message-Id: <20250303112752.7292-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0018.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::7) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AM0PR04MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: b14f3a01-9bf6-40e9-921c-08dd5a462e36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ox+o3LVg2BvX+V3w4OaGvUsvnknjEsQvCiBKc0INgcF00Le/ivBd1MWxqCWp?=
 =?us-ascii?Q?gD+bfiHtqVwltAYeRtLpTLm79z23A0reaWuf+smtJKxVfyPJESGSoAf83KjH?=
 =?us-ascii?Q?QqcQLmBIn/sr8OfYgHqqIzIR8hpe+nHk0KQ6/DL/Id5nHjybtXjLW87rDJ46?=
 =?us-ascii?Q?yC9QwU1qqgdynlsGykhbEN5YRhnaaiXGIqGhM5qYgv8RQT2+q/CKWyfJzeJz?=
 =?us-ascii?Q?DfT98BW/VuUT78WfhAYXvO7j9a4AVC92WWPcqv5C1D0iWcs+PHYxc4YCatCz?=
 =?us-ascii?Q?u9w7zlvRMKFvJV6VwGYn547OYbB6sl/0s9jv4dvSQTJbt0ipsvpo61WmLh3j?=
 =?us-ascii?Q?JqtYONbvQCP6ewfFFLVSm/gx8BcgCER+tPP4ha7a+ixecDcbb6zUBqXoE4OJ?=
 =?us-ascii?Q?3cbjwkq9IkB5CTL3KChn5sdttBVvt0wRPpc43+eMGE0IodYbflAZ+59yYJWM?=
 =?us-ascii?Q?Ms8yT8CL3dOWOdACjhB5ZuvlVL+9EqPzQHkGNISpJ2wCqNoi1RYDhvIRqYK3?=
 =?us-ascii?Q?picMRxKjJvbHsA4kpqVB5ka2dVnU8nBg6WMUq4VwqCDvvHfz8x7lGcDYHzQZ?=
 =?us-ascii?Q?Id9eGwL6q7Pe6X4D10Y2KLnrrjuSJb7xfmW19wjTaCknnCWccA/A5sx/3USm?=
 =?us-ascii?Q?JlmG7B86w9xKf86eBbP5Kl0GYZgW10yf10YDDll9qhMxIk+UZmXqusNZySFp?=
 =?us-ascii?Q?cOewF66Rzz4GPPIKXjnVTz/zEBV+b9ikyjKwpjtxPYFE/1yLBHi97ap+L0ar?=
 =?us-ascii?Q?aGhbu0oQRKFNEEtM2cmH/ABDu3s8kKIwZkQ9fLGEZ8zo8nIGIngUxyTBKgGz?=
 =?us-ascii?Q?8fjcP2ryVdVOPI4Ps+s6SOiot58sLvdCemzo8egh0hJV8LICPuLKIp08tZjn?=
 =?us-ascii?Q?ph/Ju6XMp0iZjF9wfH49uzRUpo2q561KqUQOr1b5iwNyqtVRGEhTjjuhZnBy?=
 =?us-ascii?Q?6PLPd50MZFts8R7BZ68S7XUdx+U8BIaMBEZhwq6k18Q2Tn2dUTof8VsfjmLw?=
 =?us-ascii?Q?kS2SC1peCEwYSVdlzTREedYaRXCe1rWt14xcEtXVMbMllnKajjZSVdL9wKCJ?=
 =?us-ascii?Q?Gd49Q3GCzEGIbgFn0fixj2S4HtzaTrAbbOhkayd3rtXDO4WLwRg3Byjw/I/6?=
 =?us-ascii?Q?ncE63MeVrDRgmlUQBbVj8GMx3DmrAkB5jUgMjtmsL945eVMuckxQiGBdDodJ?=
 =?us-ascii?Q?CYX4Grl5eA++J148OMHx1nuyQgHWmCKOs6W6EUEx9nIc3GIxa6UpUyPdlrM1?=
 =?us-ascii?Q?nLrJVSeAVPX0fIjerQVWcDlyQ00DVBrpwtdrKx1n+OSKfgn19ezBi3mVb+VH?=
 =?us-ascii?Q?ipXjLuevGFYr48zSFl+e4tmjE/IhO1PFSY5fLHibYaPDCTHdTwLSW+kzuejM?=
 =?us-ascii?Q?6CIq2JG15CrX36pOPymdaU8L5AzOpFSGxP8kFap5x9fQ2+zdfERXl5qQ3PP0?=
 =?us-ascii?Q?DJv1JwwKkLY1KC4ibfeOK85qC6OA0eWs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Hwj8upxXPLI+i8hNTOt4VmSCQbbkqL8QnrlHItYn4YiLOTejdWxrjECbw6v?=
 =?us-ascii?Q?fZMt8yppI43ot+DOmVB7xzcMQ3GaAiFHh/3mBlbF1cpJ84LUFAfSiV5jXSjl?=
 =?us-ascii?Q?PxIEoOhF6f1+QvGaaw4AEqPmzbc+LkepcY29oz8Hd4I+kiL1Nau9LHCrdEom?=
 =?us-ascii?Q?xxBfx62+WWigJbAqtHKCgyb2toieAKUbboGQ+In4argM9gBwKs5oT0327HRv?=
 =?us-ascii?Q?2jU6MYQVcj/AKWevElwXlpCzb195/OGrpzgQ4QnBJEydHuyHMDpZ+NWX9Fa3?=
 =?us-ascii?Q?qIHxMlv54yGGuqHIZb/gngXgDkezxUFcUYDnRIPCIhxzXvWnUiDQk4TTG4xQ?=
 =?us-ascii?Q?A4Oy7G37eQoxmfD1W17Ju51qdCbaSAWZnlgQYfKnZ5vTKP4CP/Pkwy0S4F4w?=
 =?us-ascii?Q?cH64O2abIhaM26cpV2vpUZH0FUqAk8YriUYDE65d7ow8gI9IKut/dc46fTR4?=
 =?us-ascii?Q?z2W8A/eWArzo3IvWM4x4bgLD3RjCGtzuEQOYdrCrwNqiJiy+PkMcJH0TuxKg?=
 =?us-ascii?Q?yIOG4TfLK5qe5J4++rt6+HNV537/5RiM5QxveGs3IU2PnVov2hGOzsLQBx5f?=
 =?us-ascii?Q?3OAYfPY30wVeSZeU85p7qpuwzulMiueEtMu3ZHeLPQYcgQK9GiQNSC5DhQAV?=
 =?us-ascii?Q?cnOv+BBQWp4qjRR98FPF/pjKXtFoejWmH1WcyEFZC5x5Cn/K6i2NSbw2A75k?=
 =?us-ascii?Q?oXMi4RYPpL9wVw/A7kwsr4G92FxBMZP0jZXhexjJ0ljSg72i8rHPzfBUDwSN?=
 =?us-ascii?Q?/ff233y5uLXtLUj9eBPQLpkHKEYopQykCMEuCrmXZh+RdQYAfIcLLQpSHbpu?=
 =?us-ascii?Q?I7BDb3MwXdzGg5JSyilSsX+YDr3+sB19hXIGBZSORhj4x+4mUNlUMtKX3WQN?=
 =?us-ascii?Q?hRHe+nC85fKEBXD1/ca74xDt9fRiZgf47YaI2awgR/mkWWq7XAsLng9NYUmB?=
 =?us-ascii?Q?ObuRX5aREvUHnY2Vn2Jn9j5p15u7oMeob7Z2TQNeqXuruX36JjCRMclLFT9j?=
 =?us-ascii?Q?ZC3NcXOJMXWlyUxmw33w2MrVm5ndf3hDHpkdy+7xZhERht7VpyqETfH5Z25J?=
 =?us-ascii?Q?prczWgFLu2PRj+TUjqwduTxa9+izrgDJegNDkeOlcS8TAx7z19V0UsJjJjiy?=
 =?us-ascii?Q?5WzG5mEwlsLrlIYSbPDVDO5ke2sf6YUyOtbjIOJleBRI+EhuFALhSTvGbHuv?=
 =?us-ascii?Q?ce/nih8AZ2EBR1ve7dxpzsEFgnbHjUQQaUCzGd89PN4LAWAv627bI0JrMCP5?=
 =?us-ascii?Q?uZGlAoFjI7Y4biuvmLKDQllIrhUlBzgXtPKAwea6QJQGEmPDrRV6aWpMTPkE?=
 =?us-ascii?Q?b4RdrokCRaXUYRQT9FlYVyIIQj5P8FoAunPLbWEmAmKVIyL0d6dAsT78LGpm?=
 =?us-ascii?Q?dVgBiprNJfgKfeyZ2D229FJEBEnfCqVTyiWfbGT885UDzh/k5aYqPwuziSft?=
 =?us-ascii?Q?GG0UwXE6qjsOlqt2ZHgA7+UMDPCfYNzBCIVRqIPd23cME+EwYI+6huq9LYHw?=
 =?us-ascii?Q?jjrhM5FujbRxyfaNm+shKUBbi8X4XJqJumJeffR+Ac84m2hdsqAkn67S9nxv?=
 =?us-ascii?Q?2r4mCWelA4xCyYFGCeU3YvhPNI+ft7oYVb/e3xeNsgAI3H45ScSTWcbAnQw4?=
 =?us-ascii?Q?uQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b14f3a01-9bf6-40e9-921c-08dd5a462e36
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 11:26:02.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RUYYnuy9xB039wGYscXssfQBHq6LN4aNwwpGHk+4HqQDpbbvd7ZFWLXkos706OGBz4C37t23e7e0DW7xuShKopI1usbog8a4NpbLAPIVAsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6994

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
index 04f55fac42ce..d02e9dd847ef 100644
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
@@ -53,7 +56,7 @@ properties:
 required:
   - compatible
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
@@ -66,5 +69,6 @@ examples:
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
             nxp,wakein-pin = /bits/ 8 <18>;
             nxp,wakeout-pin = /bits/ 8 <19>;
+            local-bd-address = [66 55 44 33 22 11];
         };
     };
-- 
2.25.1

