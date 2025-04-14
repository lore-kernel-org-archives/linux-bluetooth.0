Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2045.outbound.protection.outlook.com [40.107.21.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7AC28A1D8;
	Mon, 14 Apr 2025 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744653473; cv=fail; b=uQ5bim6T32eciFd+3xrjEbryifHn65TywzwYn1rbVRgtU6x8jSZQKKWUfGO2vC9vE0469S9W7Hf0+52nKQz8xY+9JBEMhoUR5oN6J8hDhFzOS9IAmJx72jQi1Uuc7iWjqeuUWFRHUORYsc/gwq/siLf3emFww4qg0xSWJNDL7pM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744653473; c=relaxed/simple;
	bh=BA2OCBkZldVkvoV0By4k2xpyGQ3Xfg3KeShkc7qxeTE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ttUsKwJ08dnkFUT8uwY9t0bJ1bgHWgGP5iL99bsHeGhyEysWxal6OadMgX7Jm18rfP7Hi7qv96j5kDe7x7xLA9hF4NbLl3WZGXZdzJtk0WUHVgNf7W/tc3I1cf4kW7nkNFJ6812YOsGwVnPLaEwrj1R3zG98wg33MzVWhd5bTZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Hl8UDrRd; arc=fail smtp.client-ip=40.107.21.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Hl8UDrRd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zD/I3n7PTMHRicRF778vgTixop2wZr++VwRKLzVt0SUq+yIl0i8JTn1GdL0SAB0EisfiuRAGY+wwtIrsNBYSK7cFGnbElkrH9J2wkFn4Ybc0jkTD8PODshxzNgHBJinbhI3FHu2qZ4i+JBuEQO4MX3TXQvktscixpRgpGbK/KbpQFn/rT0slneD6k1BV+CvtFAAW2+QILNTkXmNLJmcMhH+948qUSGg2yeo10yXOJajdlQa9hBEPK5uGgnhu2CJ2Iz3YyexgqYBtkLwIwwZd4M1Od1SF9t1Vk9FKmQSd5dXSGCE69ZRt1r4gE9MN0Sj9LRXkdKmBgnYm1FknbYenUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzUkVf/NMS6Uom74iJePBh9Ltytf14A/T+RhLlNYueo=;
 b=CBgMGn4PmWGKNfc3uG4uxJQaIsv066He2X/HUbQ0McU6oPJqEevcVsBOJHTpIvV6B+unN1DwRuoB8qmwqeDDx8aIJgA7z/c7S9UqrBiFwusOrvA6uHTF53FPRMnMNsgg34xff1swHI1XKd1IWks3MN8n6AQvZkvQEiq/mC/67c87UcO3DAxG1zCeb4pU/LBR8AbHDW2ExP8HZ9GTrHeFJysd0B63Fhnwzp5sg8LhpN24IstQ/7TDPzsBALfyziv290d8MH7JqEFl2NJoAxIv5So57NnI8KIUVl6bkG0vl/tcObOGrO9LR9YN5x16mxy15toSqzO0uBwKAqh/yi1JRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nzUkVf/NMS6Uom74iJePBh9Ltytf14A/T+RhLlNYueo=;
 b=Hl8UDrRdYy60oZpizm4U1G8Ehslf2NubQUhC7Ic0wS7cPj/3xVR3Vw5/cBdVXd49Ox7kWNc7csDENY2kv3Qho6EnpLmLBxJGKXwon3kFrT0HFeHhH7AXYS1Qem3E1k50y5izF9oKpOTE2iU1HO+7yFA4iSw9YGjH5gLqwEJOIbIMBeIpcnCUGcrxE8J9ao8fvW5miD2t/D/hEJWNKdzSjl76YcKdT3CnAMHlNRlkom5dWM3+doBhCc5ZZm4ABfQiVoTDuZefsp4ciNQOQUUOx8ZZw/Z7DY7mbjV3UPFDpZgLq6AXi0RJtLMekqcTP2N+AkSuJWRLSngKFW7hYXiSTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AM8PR04MB7985.eurprd04.prod.outlook.com (2603:10a6:20b:234::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Mon, 14 Apr
 2025 17:57:47 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 17:57:47 +0000
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
	manjeet.gupta@nxp.com
Subject: [PATCH v3 1/2] dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
Date: Mon, 14 Apr 2025 23:29:51 +0530
Message-Id: <20250414175952.403002-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0054.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::18) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AM8PR04MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0dfc9f-70e0-43d8-2f7b-08dd7b7ddd5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yv4Zsy9H6qlvi9wpH6ZJCBquh8ufaX9VHb3e0vX5SIvJl6CHjtqpN83Jfjgs?=
 =?us-ascii?Q?fPmlGsGW6cpRjP1pgiyOfj4KDGmITdCughnI/Q+9G0QXP8KomF8GYTGX0uf2?=
 =?us-ascii?Q?wcp8EY2T57F1UByyfqEWvolLmO/VLTk/+w4nOspTmo6ZBYEV8NAwC/FctNK2?=
 =?us-ascii?Q?4vTuQ+K2QAKMTDZ6YhHBGOy/ZURNShWCzFJUZDNSCaLj2n4W6ZgGBlM1wEcl?=
 =?us-ascii?Q?QG+7h6yWZxLVcUbBF7RQBL/ekpb0xU7dKQGl6J5WYSEcJruXsxSils7onMqJ?=
 =?us-ascii?Q?gK5keCYyscKt14JQUHAAsoHJQOK3k13DM6SkuXmQ/OC+sXoZjU6bqndvWibp?=
 =?us-ascii?Q?Fx3ByrENmunbqFQeWnyNo4dkj2HGQicg6OHChxY3xU7Ctwh/dMCILz+dfYha?=
 =?us-ascii?Q?Xt5aGrVTg6Y65CJSLGsAygrAlEubJbpZ5qhRmkL3HijJuTqTzZqEnrcCmfmH?=
 =?us-ascii?Q?1pdPVfLArV9sJsx07mfmXIz2oNWHZCP52nJQIhObB07qiJeHzjAqZIs57zli?=
 =?us-ascii?Q?wFdcpxXAaLOYiYfHb5rervJnms+WjzWLLbBmo2zqEkZ2nZUAv10MZu1TQuA6?=
 =?us-ascii?Q?KFaMGVJ7mdLmUf8WSgvMVIqa2JSapvb/UcyGSeDVgqA50tpS9PtiKEiGNhFk?=
 =?us-ascii?Q?h3pfyqkQ+BXah8HLUqfwxG3sopS8KmxRuEui4JrOnhff7DQRWqILGolHqpEX?=
 =?us-ascii?Q?GsGjrMfdSWuzMoCvVjEtVU63dtkjUsQsY02GPYNfmXejNBxhCicl1WT5E9eL?=
 =?us-ascii?Q?wOE/R2uVncVX6iqas1mX9duhxWOa8SdxpQ43irQOKwQd6j384M9/23RQJ2h6?=
 =?us-ascii?Q?5qxG8Q36nXZZrclMtuxUbh1Ivb7i3lVDkx5S0ozHArplHPHNS7KQJw21E38e?=
 =?us-ascii?Q?uNEiVRN2IxfTo9usQHndSNK0nDhhOT1qs69VuWnrXIXt3IG2k3A+8pkRVb1C?=
 =?us-ascii?Q?4DG0BiI4hlCipoKZsg79DEotgxbR1qovoYkwESrjGp5x2JkPGEbd7jbB0gHz?=
 =?us-ascii?Q?GKvxC1U9EwnH/nBM96IqgPB9fINoj9jnoLPRdufmMc0wLLXriZX2xBpqooGU?=
 =?us-ascii?Q?1c/wlD1DGZo6j+QValTV/UpA7cz4MCstSBkGUU6jxrIzRRa/ZPoTgTKg+HvN?=
 =?us-ascii?Q?+st63UVRdR/7jC0m39Ek//hSGav4qDA2KsKDEGQXyy6wKe/xD+ZAqQMSryEC?=
 =?us-ascii?Q?w1r6OACuRLZRwbZu6wu7/ToAFCEXQMTMXqS1vUYn5PssGQuqjQDPVTrJl446?=
 =?us-ascii?Q?PIeqESOrRunCsGNviB5OKnCpBzzt1ZVpz+vdlNCsQfhc0ObHiiUHG4QNnt+3?=
 =?us-ascii?Q?1DU9evEElV/3iEJBKAVTalMj/Qoss8UM/y15KTgioZRLFrwnoR4EryTEp97U?=
 =?us-ascii?Q?Gx6l2BWU3O0QQ7ltzyw6ICfQUEvZKRZgex+oKI5+NysPeOtVtBe+ZSNbgVqp?=
 =?us-ascii?Q?WdfaruyiHZLIxD78mm3uLuo60zx4oD+EltYwvhsbshn3ZzwK0JrJaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y2NhI8eqrPc92wZgoo6n3xcVfaB6lONcLxyBqZ6zHrtVDj/g6BHK1llett/p?=
 =?us-ascii?Q?c4+Bc7SbRmcDncF+kyWITogGn0vUu0cYjQXc3duSzEmiRaUartbSSl3cCfOT?=
 =?us-ascii?Q?ZR1/QsTp3IxXE5Ruv7xyt/+vshnDX4v7vhf5e5DWxHI8s/6/XSrSiej1OpAr?=
 =?us-ascii?Q?AxomhaOmwLRb4E66KEGN6uOPvhejlwVDM4malb73EpTIq2UGj9adGXdeCTTQ?=
 =?us-ascii?Q?z3apsQxk5wyZVo/QqVRLqckG9s1K7UtETM6SxoWiIyfIzWBtjTokMu6ZFYMf?=
 =?us-ascii?Q?SAa7Icz1KCscShh6C+k6qgV680jdggpK3O0FNQM7aGDtnYePBOwVUcYtY5vs?=
 =?us-ascii?Q?ZECaejeJh+P/8t6FB+7NduYvG4iGvTJ9QjQAPI4UxMErMoh/Qww0/TSy0JWu?=
 =?us-ascii?Q?a9V0jqUR1HbDZVL3ihZQTdoq2/C7YS+AA3mkSGtruVgXS3XTU85cGCVNIyd5?=
 =?us-ascii?Q?69+kxuJQvs0LXEWaATAPGYyrB1MiqrKzeWfyVCgGkT5f4WN+t2bHHAsunT2q?=
 =?us-ascii?Q?38xfzyAUHzIfOjMtOd4KdNUzV89AhJK4S4eYS+SHd1PX/yp9ka+x1Igrwta4?=
 =?us-ascii?Q?fH/oc7O84MDQQYDMO24UpG1xDaMS9qIIotwrQ3CxLaIUlZ69KoufZJLvz08L?=
 =?us-ascii?Q?eET7eeuMjCbyScelZFsoVKf1VNCQfkXGYZ/uVPdyo2l5R5tjTIasyJ+urpsd?=
 =?us-ascii?Q?PjcZ4tufTdmodonVQQDlVe42ialDqNtoGhv+FFM+XozM22Bzo63E1v21QN7j?=
 =?us-ascii?Q?1KpmjztIsFTpveX4/vKPFFAZzwVZtHM87mHtLGSxoDkk69cRvN4kdf9malk8?=
 =?us-ascii?Q?hqA5FwbdYm8BLSD0Mgumy2//da0qakU8WKN7VIJoev61K53QO0/EPV63aIAX?=
 =?us-ascii?Q?DrMHx5W8Lw5NmSJiTBhHZU/YtdPe+YH//6YQh+W2lWOWYCE34raTa//uAvZs?=
 =?us-ascii?Q?0mfAms6/gNX01UMYJtRdMIaXhHMX9H1fmmb1winO68BIGS1T81W/cx4LshRI?=
 =?us-ascii?Q?by8hgw0I3S+UFi6GtmnlXn1zMoP48XIu8KQ7QasQEOodmrQNFnsy+KS1DjUO?=
 =?us-ascii?Q?um6bx+wgTcgL94T64KmhCJOusgNJOgc8wcMu3mOrnlgJmmI/7Mc9fBWgSeHA?=
 =?us-ascii?Q?RNI+o2Bov1Si6vPs+tVwhnMtzjw7Xg927271PNVj79Hx/2suEuWbJ7YX1Ihw?=
 =?us-ascii?Q?Uq+gGTUeNzgtA0Yg79Uahzt2nCtMPbi2+viXuz3ufIB69TWuSUKM2nAGZzqu?=
 =?us-ascii?Q?WuQtLMXmd5TH1l0eAsimRF+5F6QNQjdt72SNvhp00OSLEbBFQmyb5PWQEwwB?=
 =?us-ascii?Q?vxeu95Yvr/V5SBFSKiprPNBEqYrEUdpMK4Yi15aiVqWS/pnNZTdfz87N9Rvp?=
 =?us-ascii?Q?i2+tWMMK3WHOoPhY7nNlsZ/VeJkfoMZAgrd0Ra3aNw5Lvsg7S9JMFLzXGnwg?=
 =?us-ascii?Q?UHh58vHgg+Rc6dJmznbpy6IkeMgpMlgEXwkqbAD5gdi/GrDcCkdv3j5T4uSj?=
 =?us-ascii?Q?5rY4RAZml29SSSiyYC6LfInZ8mxPqy0z6UWD5wj7Rxper3bLaXeoWNzqsncy?=
 =?us-ascii?Q?RZlVoypfGEhpr2mPsr9JZ/YN3/487dZlFVLZxq/yy03OWxU2RPHA9NBg23b7?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0dfc9f-70e0-43d8-2f7b-08dd7b7ddd5b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:57:47.5439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEhTBf7F72atB056GKDLaPnT9mq+mDS5BBZmlqZd3WkwfGfEIz6mPD+yBd+qlWzKtfpnXyOlZ/WIDOBwJ0ZZXUKFrmjxaJyJXzz27YAFRtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7985

Add support for host wakeup on interrupt.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Use interrupt instead of host-wakeup-gpios. (Rob Herring)
v3: Fix errors in dt_binding_check. (Neeraj Kale)
---
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index d02e9dd847ef..3ab60c70286f 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -48,6 +48,18 @@ properties:
     description:
       The GPIO number of the NXP chipset used for BT_WAKE_IN.
 
+  interrupts:
+    maxItems: 1
+    description:
+      Host wakeup by falling edge interrupt on this pin which is
+      connected to BT_WAKE_OUT pin of the NXP chipset.
+
+  interrupt-names:
+    items:
+      - const: wakeup
+
+  wakeup-source: true
+
   nxp,wakeout-pin:
     $ref: /schemas/types.yaml#/definitions/uint8
     description:
@@ -61,6 +73,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     serial {
         bluetooth {
             compatible = "nxp,88w8987-bt";
@@ -70,5 +83,9 @@ examples:
             nxp,wakein-pin = /bits/ 8 <18>;
             nxp,wakeout-pin = /bits/ 8 <19>;
             local-bd-address = [66 55 44 33 22 11];
+            interrupt-parent = <&gpio>;
+            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
+            interrupt-names = "wakeup";
+            wakeup-source;
         };
     };
-- 
2.25.1

