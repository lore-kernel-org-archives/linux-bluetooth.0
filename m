Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012032.outbound.protection.outlook.com [52.101.71.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5371C289363;
	Mon, 14 Apr 2025 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651221; cv=fail; b=Pzu/XTwyS6qF8XQlkrEXxnw94UdEM7USfrbdUX+NaL2KfLZJPbzLd8jo3XI7fMPxoFyZ8OmuNTupWFJhzJ5ApnBogiaz+gVjqG/MREl73DuyQxAkuYx2jN5iBbzOmw0xg4YIgFU/Bp23ClUuRV29bh+3/Xzn6MFoTQU1y9hfBRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651221; c=relaxed/simple;
	bh=GQqLc563ZSbJCDRPZlndTM359F5aqP9Az0/2flEEYPw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sfvj3fSkvbcb0288kLWzLkP4faVoqGtbpnKRs+NApYqIBpTwwsElC9gVnd2Jq0HYipRPUWFInwnaFDQK1gQmTYsT3ZBTRYzYIuV7RnIyTq9OkGzhmTcSwSuVarv+jpXcEfNU18jkYAefM2o/54ml3h7llsZITuTZ9d/ICetLODA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=chKxpUkb; arc=fail smtp.client-ip=52.101.71.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="chKxpUkb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adhksdAbQPh/LfY2PQUTkG+fdKjOmNDyWJQ5PnoqF8yIiZdxDtH17aKeE6I9pQUF0vUu9W8wcI6f3EKh8ad7O8Sw1JSpXG1uIa808aC2R1Gj9FN4zO+GsZVcZg6BUgO60AC7Y1zzTyKFOCwUrc/UZKjgbWHQc7dECTZmZmEofx9OGr9qvQwU/nW5zuDOLQGLZ+fStVCtUAyCN3cN93Tmzmb+DdMZLzjZh+bUZ3+RQSlXn8rFd3sAAbTIjNmDLbd7KvNo7krd9Mfs1CqBUb6Iarmh0W1gdDqhxrVRsWIJkHTfk1n9qnBam9uiOqtAgyroMd00oWWwVyMmyw0XjSd5YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wFS3FsVbS8MCloZQpVchtoR1ePdsykVm1er8TXTh9k=;
 b=L2y4LAqiGZ5Es0eccjixBuThaKydwp5fmt2BlRM+eGqQMNitnHPipNF5YcXGUDirW9Y13yruPrTnaIQ8z0ED8Az1WdDVjQGVtHEM9zdWnkP13NO9HzEfq8TT7RIZ1Ocb2Yqod6P4vMbmbWPMXO9upSj7/neLd7ccyKfSDuLuPKnQsvLq6cssesFGCK5Prt7ze3e5xIb5+QvYFZPxNEXhNL72LDw2r6I+gNVI1w3AsPtYUO6qcpld8ROJRbfTnQcWXcxdOxO220LGrcI1f0e1vqg1KgoOhaNe2X7oWNPFD3G751p9IBvyCypkPHjx9DfMzJOmtxxibfyZ5UxlpiEF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wFS3FsVbS8MCloZQpVchtoR1ePdsykVm1er8TXTh9k=;
 b=chKxpUkbqoIrEymIbayCKP74T4VydJ4gZu/9toqsxINlHn4vNEGircrCeeUruDTQevjzgcVdRNsNJXBRHIPSPpV3Zy1jRnlRMwNudFWLe+2+LMwt7gTXh9FTjqupoQbxn/YdHJu5aeY7STmyoNIFG0lHonC9xhzbeIekf7KEdu0lmahZ23xPpMUT8AUvaH7WFlXq++azrvAkLKgl56qDQA3aqNNnCvLe+Og8LVkZeoLhLdLv5h34mPF64Wi4wTavyU9Cx+Jz5vQyk4YYbROaJf7X3Yr8j62gk0wPgQGbpSg4TH4jjFQCfIAsdwmLB8no6n3C+HY1oRBOs1RSpg+vDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DBBPR04MB7897.eurprd04.prod.outlook.com (2603:10a6:10:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 17:20:14 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 17:20:14 +0000
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
Subject: [PATCH v2 2/2] Bluetooth: btnxpuart: Implement host-wakeup feature
Date: Mon, 14 Apr 2025 22:52:00 +0530
Message-Id: <20250414172200.401437-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250414172200.401437-1-neeraj.sanjaykale@nxp.com>
References: <20250414172200.401437-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0140.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::45) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DBBPR04MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c132e46-8078-4821-aad8-08dd7b789e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mb62+jYpy23hUvLFWHx5qtndEIWmxhWDdfXKskxyENiKErDKT9tjgk5kpldN?=
 =?us-ascii?Q?pdk8Y1poZEDnh6JCmtOjvy01kPjWi1LXbotqPlQ2GCfdbxzbGwXrNiyTy8JB?=
 =?us-ascii?Q?eqT0LGFBd6TYNbCpMkZSR/NJr8BNr2jc7jb+7/Ha35yRZ7FDGhRsTklQH0tj?=
 =?us-ascii?Q?XNu4MpJqpIU8NE+z6YvihUkElgt2Y/2G+K8jiGwOUc4qKURHIXGqrBDyCXj3?=
 =?us-ascii?Q?s4McOspsQutvlPuWih7GRJsacKYLAPGLwPwMmtPhUrjth5cM5nxDWOX+3iZX?=
 =?us-ascii?Q?58S5h6J8JL0vzDMaUgcoD5UEMKuIUrFt+QL+686+GanlSupCWjc9utHZddbs?=
 =?us-ascii?Q?5wm1GlKvxv0GiF6CBC6qsdMl5F3c/aUkXOtBBqZIXwTpkJ/F9EGwkDKNlVAu?=
 =?us-ascii?Q?SfxIuqeX2hv91D7zFZtTXz/sasIxEgKMU7vA9t3G4/iwPbJZMvE7zFWPKjEM?=
 =?us-ascii?Q?sZfeWsBLgougYIGxRITqpq+453pI80WPShnD1xo2eOTuWk7yeDlBfdAvttTc?=
 =?us-ascii?Q?ujrEMDVHsqmJzywqCcYOuKpQmInl1R0ryf8EzNNaxlUN39FA5rRLmz5Kwndq?=
 =?us-ascii?Q?dNeS2v28Z3P3WESsFZKgVhyn3qgPHcv33o2gc69R0TfyifPDJ70VQLncd0Um?=
 =?us-ascii?Q?W5CzcU4K92rP62wnlXPZoKfnLBT0jK7os0UCs9SimyG8TITwXJWw23c/n4dy?=
 =?us-ascii?Q?dm4IHBVW2Wh1//vtOwiuSKTeRAOQY333RFqY5ToEGeRs6U6y/hFELv3dC5di?=
 =?us-ascii?Q?WyjAuunDPDz2jZOsiTKhdRa6rYowy5BxH2f3dQlePFRvqPplN42e/ssqA1Da?=
 =?us-ascii?Q?k6kNGJ0UbtcAukX1ZXyGzFAd4ks7S2GlBdEy7k+gVW+GOgDsEr+xn4Be6jTg?=
 =?us-ascii?Q?U6Bl4UZEFMuupurOyaXBey0ye+SAZNudDSF4HlsHrxfEPgAkjjCxuziQQujU?=
 =?us-ascii?Q?T40cHHBLr/1ALvw6sTZQrVGsOcz2L5IHJLfaS1m+BfH28H8QyzlrKqzIrZhn?=
 =?us-ascii?Q?Ihr7bhjBFiDc7ThDKbxjkV1BTANEEP9KVny61glfOs8kXlMi0hAJgiJDDkMZ?=
 =?us-ascii?Q?FlL3dLWqc/jRN8bdtJP9snURGGxo7Q9tRp0xlG9t+U7iie/p36SXECpqnMiA?=
 =?us-ascii?Q?OmxA1Kd6UlBGQdEtMjhDStlhBfbfZvQ0QjtO9htYCG9CLZIunB0nMSg9RQda?=
 =?us-ascii?Q?mEKgvXbDy0uq+hSLZuPnR+9i0uV8Fz6y6sTMD6EkBLR1c7ci+79i5F2G3D6W?=
 =?us-ascii?Q?BCi/gyfhgFyH0Aox14Br4tI149DpH0JjpzXOL5vPPlqpxKQhE+zScCeMYWRi?=
 =?us-ascii?Q?3+mb8PB/X15qvj2WzQMCQxZB17K4jzny44OrMacWfReZKXhW4uJWRKYIT131?=
 =?us-ascii?Q?LGyLn1cb5XGeWnrOCtqVPbfxvqqlEe8/xA9jkOKMQnloqoBcKgBAAJ0dYqEj?=
 =?us-ascii?Q?4VlNnJmySLkguS9dv+Kuq4muPWAiGaYRyeFKm70QlXYWs/Vhw6WP4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QkpvmDTMvo8MZncB+IWLA0uVowmKlT310ELuPOZxMAx1N2OIBRV50jUb2j0W?=
 =?us-ascii?Q?1sasKRcwKlrOByiV++r7403tjLvUUbl//hIo9vQMtaqwbC45s1Ya6Mthxoe9?=
 =?us-ascii?Q?9hOi42KeFkxSGm/6EULqlirvr/7M9LHbt+/xTzsz+qnSw5OwQ4vnux45Y9B9?=
 =?us-ascii?Q?BuyhxvVofS14Ie5hNLBFq9T4n48pRnb41hnjDsX6gXVdjxhRzy0Dr4kTOop4?=
 =?us-ascii?Q?7IZCg9lp2smwjrR3YGqeuPkMLmo3wp5aBSqPUjC8uXNwyrUv2AX2JTjQGVJn?=
 =?us-ascii?Q?OpJ5KJLw+W92+4IBEqWMNJ2J2xd28X0/mQ8lFAg9QFcNVlTlp05Dwo2m7I6Q?=
 =?us-ascii?Q?ytWJmg1H1jZqWX2TMOQwNdrMLWZB6LA1IKBBXNXmeWR1A3JJsGVQq9i6s3kB?=
 =?us-ascii?Q?fObDmzf303PLG6Z+Y4+WwHrkKfqp3Ybl9dOasolQ+I7+yg4LdLwEFZ7BMnFu?=
 =?us-ascii?Q?Oku/Fxfj29iWRKVVdarYebINkCwIGk0X/Qj+UYouN0IuWulIwUksZUtAwGb2?=
 =?us-ascii?Q?uSNw1j2+VeSs4aZS6EIPvHY9L1RD20QSmJUbMLSYM9Ws3jRYiwDwIVPGNT0D?=
 =?us-ascii?Q?H1naX8HmhiP9+9ydO19F2iPWCPKzt9LxdYVmB2uHmk6+lN6Hp3k1Iq6wj/fL?=
 =?us-ascii?Q?uiPwg0+jl0QwiMsyH1bTGtDazJ4Fvxhj/yZmmMDg/vFUVBjX2iHEjRR9M8bi?=
 =?us-ascii?Q?S77YyxJhTVJrZhQvmVBTQLBW0Kccj+ouHjssnd9O/vubVJzuzB5KfveRodLw?=
 =?us-ascii?Q?IzeJSvPlsiV6yJp7X+eYi7LXWW5dCDPM5h9MoI6l7wtDl25dt6j755GdYbeX?=
 =?us-ascii?Q?365RGWIMfJh5UV0tNZlCcrWJKj+DokcxHRHRGFxwwah4y97U0hYMd+mCcSKr?=
 =?us-ascii?Q?xym2CD2Ue74MoPOg3MMDm2Buy/ANT4nlyCbu3cC6Ei2Yn1brChz7ODrSQ1Xy?=
 =?us-ascii?Q?96sgmkCO8o9apU0yDQMa4L+eqyd80AT1mSA3gXnMl56cuSpTIuY2Y5k9+pvx?=
 =?us-ascii?Q?kObj5cRNVFKEp1VV5iyoIJGWU5o6O9XRQFBODkgBuhq8r56ViPZaOirTYiBq?=
 =?us-ascii?Q?lSCclKJjtTliUwbJhj2ZqZvTx4uGk/oRwc26QGLsRU++P0yaYaklSmQJWRiZ?=
 =?us-ascii?Q?Q5OjlOFYOpMsYq8faHFvE7PN7pX2i1PN7JyMfJoWGT+z7hMUWa4TuZnNeNln?=
 =?us-ascii?Q?68u0R+JoL7Xkp6g27yWD+OW731f4gWjXkRdQnPeXLqhQ7Cf8tctG3Gpxzh3i?=
 =?us-ascii?Q?+vecaxk6NUgoNSc7QulAJAyirPHD1bAAu7zrh3LieAgZRA9huhUAsdYTaBEv?=
 =?us-ascii?Q?FA2J4dYs5V4bm5N3ezPs9jD0KysDJOiMdU5M46CVcrVXmhQE3qbb5ZgrYyK7?=
 =?us-ascii?Q?B/lZrQGlVrX2xvlmF+KBegN67EvdXmTv2wB/Um8X5jAQxw/knGSrVVMLY/f2?=
 =?us-ascii?Q?VssPch3s1/vBmwio7EwgwxJp7x0gyhT+x9yFCv3wmyMx0YDWL8hhIlAUZeTK?=
 =?us-ascii?Q?GsRJIG5uuOEQQ/IKKJhNfW4qbl6AiUb25avMlB4K/0roWCSzyTSzdXzLSzIU?=
 =?us-ascii?Q?RdnIU9B3UVDHSEv2U5yRZEscJk3F3fGoN8s0vbQ+gvLdJtK7xHUUcXxaVaVK?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c132e46-8078-4821-aad8-08dd7b789e2c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:20:13.9442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fDyMn1iRwDX7jeWptVE7mUyKgc0/BdmvV4D5l97reXY7h0lbMUY1SXqKvBu3UFsXylHlyRApUwWLXOs13oYLj6G6XIKlUWg4Ks8kS61dtHc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897

This implements host wakeup feature by reading the device tree property
wakeup-source and 'wakeup' interrupt, and nxp,wakeout-pin, and configuring
it as a FALLING EDGE triggered interrupt.

When host is suspended, a trigger from the WAKE_OUT pin of the
controller wakes it up.

To enable this feature, both device tree properties are needed to be
defined.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Use interrupt instead of host-wakeup-gpios. (Rob Herring)
---
 drivers/bluetooth/btnxpuart.c | 58 +++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 604ab2bba231..069a394a7eb8 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -17,6 +17,7 @@
 #include <linux/crc32.h>
 #include <linux/string_helpers.h>
 #include <linux/gpio/consumer.h>
+#include <linux/of_irq.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -143,7 +144,9 @@ struct ps_data {
 	bool  driver_sent_cmd;
 	u16   h2c_ps_interval;
 	u16   c2h_ps_interval;
+	bool  wakeup_source;
 	struct gpio_desc *h2c_ps_gpio;
+	s32 irq_handler;
 	struct hci_dev *hdev;
 	struct work_struct work;
 	struct timer_list ps_timer;
@@ -476,12 +479,21 @@ static void ps_timeout_func(struct timer_list *t)
 	}
 }
 
+static irqreturn_t ps_host_wakeup_irq_handler(int irq, void *priv)
+{
+	struct btnxpuart_dev *nxpdev = (struct btnxpuart_dev *)priv;
+
+	bt_dev_dbg(nxpdev->hdev, "Host wakeup interrupt");
+	return IRQ_HANDLED;
+}
 static int ps_setup(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct serdev_device *serdev = nxpdev->serdev;
 	struct ps_data *psdata = &nxpdev->psdata;
+	int ret = 0;
 
+	/* Out-Of-Band Device Wakeup */
 	psdata->h2c_ps_gpio = devm_gpiod_get_optional(&serdev->dev, "device-wakeup",
 						      GPIOD_OUT_LOW);
 	if (IS_ERR(psdata->h2c_ps_gpio)) {
@@ -493,11 +505,37 @@ static int ps_setup(struct hci_dev *hdev)
 	if (device_property_read_u8(&serdev->dev, "nxp,wakein-pin", &psdata->h2c_wakeup_gpio)) {
 		psdata->h2c_wakeup_gpio = 0xff; /* 0xff: use default pin/gpio */
 	} else if (!psdata->h2c_ps_gpio) {
-		bt_dev_warn(hdev, "nxp,wakein-pin property without device-wakeup GPIO");
+		bt_dev_warn(hdev, "nxp,wakein-pin property without device-wakeup-gpios");
 		psdata->h2c_wakeup_gpio = 0xff;
 	}
 
-	device_property_read_u8(&serdev->dev, "nxp,wakeout-pin", &psdata->c2h_wakeup_gpio);
+	/* Out-Of-Band Host Wakeup */
+	if (of_property_read_bool(serdev->dev.of_node, "wakeup-source")) {
+		psdata->irq_handler = of_irq_get_byname(serdev->dev.of_node, "wakeup");
+		bt_dev_info(nxpdev->hdev, "irq_handler: %d", psdata->irq_handler);
+		if (psdata->irq_handler > 0)
+			psdata->wakeup_source = true;
+	}
+
+	if (device_property_read_u8(&serdev->dev, "nxp,wakeout-pin", &psdata->c2h_wakeup_gpio)) {
+		psdata->c2h_wakeup_gpio = 0xff;
+		if (psdata->wakeup_source) {
+			bt_dev_warn(hdev, "host wakeup interrupt without nxp,wakeout-pin");
+			psdata->wakeup_source = false;
+		}
+	} else if (!psdata->wakeup_source) {
+		bt_dev_warn(hdev, "nxp,wakeout-pin property without host wakeup interrupt");
+		psdata->c2h_wakeup_gpio = 0xff;
+	}
+
+	if (psdata->wakeup_source) {
+		ret = devm_request_irq(&serdev->dev, psdata->irq_handler,
+					ps_host_wakeup_irq_handler,
+					IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
+					dev_name(&serdev->dev), nxpdev);
+		disable_irq(psdata->irq_handler);
+		device_init_wakeup(&serdev->dev, true);
+	}
 
 	psdata->hdev = hdev;
 	INIT_WORK(&psdata->work, ps_work_func);
@@ -637,12 +675,10 @@ static void ps_init(struct hci_dev *hdev)
 
 	psdata->ps_state = PS_STATE_AWAKE;
 
-	if (psdata->c2h_wakeup_gpio) {
+	if (psdata->c2h_wakeup_gpio != 0xff)
 		psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_GPIO;
-	} else {
+	else
 		psdata->c2h_wakeupmode = BT_HOST_WAKEUP_METHOD_NONE;
-		psdata->c2h_wakeup_gpio = 0xff;
-	}
 
 	psdata->cur_h2c_wakeupmode = WAKEUP_METHOD_INVALID;
 	if (psdata->h2c_ps_gpio)
@@ -1821,6 +1857,11 @@ static int nxp_serdev_suspend(struct device *dev)
 	struct ps_data *psdata = &nxpdev->psdata;
 
 	ps_control(psdata->hdev, PS_STATE_SLEEP);
+
+	if (psdata->wakeup_source) {
+		enable_irq_wake(psdata->irq_handler);
+		enable_irq(psdata->irq_handler);
+	}
 	return 0;
 }
 
@@ -1829,6 +1870,11 @@ static int nxp_serdev_resume(struct device *dev)
 	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
 	struct ps_data *psdata = &nxpdev->psdata;
 
+	if (psdata->wakeup_source) {
+		disable_irq(psdata->irq_handler);
+		disable_irq_wake(psdata->irq_handler);
+	}
+
 	ps_control(psdata->hdev, PS_STATE_AWAKE);
 	return 0;
 }
-- 
2.25.1

