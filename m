Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012070.outbound.protection.outlook.com [52.101.71.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F7022DFBA;
	Thu, 19 Jun 2025 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332869; cv=fail; b=FXiOKGpPSziNHs2fAm0vY4w8wiaxLqNBjpaOxjvAl+t/6vh81hGuLQXQ3zlQ/JmlfbaRWeQ1a3JHd2pBjBr/ruAU/8gdcxGg8Yc3UWQrEEkK0db9TmjpMXPY0EWivAO/sN9PH6OtFYCIdo6CitCsfSL8sisUjxWGiQp2+tUogO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332869; c=relaxed/simple;
	bh=SLX/ddJmgOaJiCcm4jHI23G6rr5M+jcOQ90X5PZw6HM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ikbDn1DdQUNb8dYWfLHAtMK5KVeFOCjDxkOyQhOBfyCAFU8nkeW138FiWV5APEWJAK7UOl2Wi8+HmwvN/EcHww2Roomh44j9SmzVl/zRFZ686Gr2cJb4gHPGW08IQYcXQbl3eJir7jeJDv6v+nmEr207mUAgbaxVG1mHKjlVgrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hYkyDCGA; arc=fail smtp.client-ip=52.101.71.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hYkyDCGA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M9Y/cHpic0jlbbZixqVoak6hW+a7foklylIHHdWCRNWIrmNMHvx4ARiVMfWKuYhV+2zund/sX+kCVVrGEvba4H/5TjDnxoupsAoELBVaDo4Kw1jkEHTEwF5kggNl8lbmDW96eYhETGdVfDY05c9j7FhQ/4P35AzZEoFz4Ucc803DLCxFxQiBxg/wyfedyJVZ4jYzWWnSzhKzSfUmiaze7IJ7ivz7caxMbNfIEd7Up0fiodCZntw9hBqkOsEtA/KhjjON5tLSITngdx1Uk6/cuM62hPyxi78uG0ETu9yZgIeHndA/nR9xKEiMWCr9E9xIbcxPYzVgW5kQm9J+u5whSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wNlgzeV62fPXHHefcNgJTVwxwIwcxGtCzAJoUnLsAI=;
 b=YQhzbK5aYLmMXtu8rlXVKWRnjmzOFhXO+52/ND+EimZVy3N8ZMw5TYQ0UwiRGDQN5Edygj1hjGWcq570PinETrY4963vUNauQYCwBwCDxAM6oKHkkkrFnaz8WkwFlMhYo308gLhUNS2owvbfv4C8y/bGAgLF8xfaon5Gw8byBujES2AByAKwwE/rF/X+wwdfw8hA5AOPaf4fER9ewL3xl5l/vhUoVlbwKuQ94iQSVFpb5deBJQdao+MQVe+MOum/DAuc2JdAFbAL6FlyJPMgoVQf5f2gXcEUD4brS5mOl5nDLgBDoZcI3m2t9xxOutVZPVYWSEsgtR8OqGU0gLm5ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wNlgzeV62fPXHHefcNgJTVwxwIwcxGtCzAJoUnLsAI=;
 b=hYkyDCGAB8WNw2TgrVMdRqhtPAQExbWVcjNIG1v8QXnbYaEPu4W4VwCJi1TKDnUkzGB8fUp3cyty6Dj4TsqqHTgHsb2eRQ9/EQBOFluaLcDJ6/fbyFR9jfxtUoROPLHVOByAwgbthbqGyOJCq74h9osmhxRgeZu2dHve1Xh4a4Em7aTJr4nFuqVfEPDy/T8oexPtMX63Gr7BidJ8/Z7pvdpB2gQ8UmGSb0BDDxug1LNSLy+O2TKZ3cq+Q1xAgIKH2DQUIgFb7O3dneYyQPe7IdgP8cgGp8J8yhwG7IkDXz4x9aWygGiQ9thy85XgAOFfzhm0vRw3K8TIDwbIyX1vdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB8341.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 11:34:25 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 11:34:24 +0000
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
Subject: [PATCH v4 1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
Date: Thu, 19 Jun 2025 16:46:28 +0530
Message-Id: <20250619111629.30098-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0017.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::7) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AS8PR04MB8341:EE_
X-MS-Office365-Filtering-Correlation-Id: af91e4ca-0d43-4b68-9523-08ddaf253dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lhs91Qjo9Mk0WLAG62d2BMucewq29s+JfXXMq8BfOnHTQCiDpfRrxbC4zpdL?=
 =?us-ascii?Q?tjpLhHaU9r0E83uyp1gN9DHfwjPg5CpFuiWSI+txqKhZ7KDzrnLCeyhDVZ/Q?=
 =?us-ascii?Q?NVhLGn0TLqWfWW/PhwAL1ZbOv/lyYmieR/1o+Cl3fVwLUTd4mvJG8jPAQNdK?=
 =?us-ascii?Q?y/AKWeOG6xErcmwctC+xz1c7s8vPf1jBgoZHfvfYZ/tTO8RCxVlOfooHRHyg?=
 =?us-ascii?Q?ebDsOaXs+azYh546Du1cKmu9EEkAvdQ+kuhMOP9oq4sOA9wEJcESsLzZBJpF?=
 =?us-ascii?Q?iyW0Rh+jdatl9cpkwHAZr602kdNAuDMnO+lRiKhDYqdOe6RhKkf3u0QfYQb0?=
 =?us-ascii?Q?7qro/ZoF93eOudA1J94MDd1xGf7d5QNkkIG/w6T7buP+nD1ROBS/A61YJ116?=
 =?us-ascii?Q?rocKVveJ7hOGR1vZEUW80gndXvFQjiAS9BzwWFHB/N68Yyku+ijNJ/mwaXsS?=
 =?us-ascii?Q?6h9hUoqDwl0UZwFqDh4LHUvAXHU9bQT/4lvvSe7TEyUtawRN7uhl7InyQRNG?=
 =?us-ascii?Q?aHVwwRjxRgjByxV2CprRzENEdxoSbaoZtldM9iaoRFvXE+GgTlMSUBfVffv3?=
 =?us-ascii?Q?m+XdXw+TGNvUQjbyc7LndwbW3ZZEeOOui9GYgbtsm8NbtuToh08JlHY9GbuE?=
 =?us-ascii?Q?8m+0Qa4DYQnnGOHYjt6ChWSw/WAFOS+jlQ8jh5AYpt4OnLWjkNqaLmYy9n8z?=
 =?us-ascii?Q?EF1eaRUuhSMC2xreFk2+75ld1KDOsEGqBV0vu6RSEWwdXbGlhqWJqUOTstyl?=
 =?us-ascii?Q?h05IVjKKmmAIlDUoZJ9wIal+eZr8WB7BOvAFGjukhm1V+g/enUoyUnfMDoeZ?=
 =?us-ascii?Q?MhFC/9RAuYe96HkJ1Ku0o59Aa94It5MKrACibcTa9bhEyOMUDveWtNbpC72C?=
 =?us-ascii?Q?n/5V+cokKb3HAkQ+P5sC8D/wGk5Qfog2nBJgp6qbKwwGb167Hvc8+T3h3PqW?=
 =?us-ascii?Q?6TF3VjW+kVCewIBxTwkGNsAV62NwekM7ORcltdQPACfL9m80jTaTQyaZdw3J?=
 =?us-ascii?Q?aPw8Izi2QkLW6fbA9jPJgds8NX2tZfupp9BM8bkeRkcOY3to4K3hjNu5NtTJ?=
 =?us-ascii?Q?/t+zbJXTuofdoz1Q/ZJmYPUSi7fyCZWGHrOxPz9xFmLFMfCPr2mLpHd5vtEK?=
 =?us-ascii?Q?jcghOr0eSKXDRqj9Aq6Yip9y3WVCMS7U5j/4eeNbWJ4qzNDE8mXH4HOFWe5R?=
 =?us-ascii?Q?fc5USIQGLmfbCpzkyudiXcau8B0JcK/CedZzZ+DqpsZ5903B+1JsMiqadNBX?=
 =?us-ascii?Q?jzY9Iw+dO1YloTza7z6Wa7U3jzxJzXdNn92/0nbfU0gxPbet7bH35Rs424f+?=
 =?us-ascii?Q?YzLMRtgTDvdTaGsm+gHu6RVN7wyLVfxuBI8DHV2LxalNMU3BXFO7BNYdeHoF?=
 =?us-ascii?Q?AUgu8JPrLI7jnaYTQU2a+DMGmRD4smh6cHYYbhPQu5fRmG4RaCdGjFKVRQB6?=
 =?us-ascii?Q?Y18qNYhG9NP5iZu7O6a9X4JGbAJsdL+rPVW14S6+rsODuCEug2w7fTEVfc5F?=
 =?us-ascii?Q?x6rBSISOM+HNSM0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BF+wEEKSqfY42sQcgXvJDd61Ppgye3OTORWjQskg1Rpx9dLHmOVCX4ryCG87?=
 =?us-ascii?Q?LVdVeiktqQIm2R6+q6HGj6DeWmBfaIEdk8+X5CyJhtuoXHmfE8uJcXzhmpcT?=
 =?us-ascii?Q?62wcBso5wMdk8324GwPnIwbzU1ALIMfGWOh8BqZAXJHvRK8uz3W0NhXAm2/C?=
 =?us-ascii?Q?4YeftJjEkIDnUNG76HdN9gQjHM+yg8cOL2doLEmcj8ONHq56RvfVVL+1Az4e?=
 =?us-ascii?Q?dv/l6kWTH399NnOVgbtQsgQ9EmjJ1jkSaLNh4VbIfM672cHvo+iWxFuouQrE?=
 =?us-ascii?Q?sNFLOwGeg32weKaQRudmzj7ErWAVdfiUaO+yM+CLFTIvSTOJc3efibXFNnFi?=
 =?us-ascii?Q?9kW93TVYf35IJakle9o+il1t0YfPaCYL5BAyR4hWaqqLsO4M7k2uSIfdgbJK?=
 =?us-ascii?Q?QCH8NFG248NKzZ9AzCRWoysA/3UBYYk3abY1YHyakg99UhnlZlbguQW3Algb?=
 =?us-ascii?Q?SVZixcSKGm/yJY8obsfkJ4gKWw5GldVPonwRnWYvah+vKurAIOHePzO4sl5/?=
 =?us-ascii?Q?T83tjlxvNkKKjSCly9gbAnKAuTsKnHRi4FNiUHnwntIYG8ihVn+IVhLOUT8A?=
 =?us-ascii?Q?IibW3vKj5T0VZHRry3pgbgJ5uH17mrTvMgVBRemL/HbHEdaBqRoNOY3XzWcC?=
 =?us-ascii?Q?iF29virz1AsW04nrhHTpv+FqvH7/pNN8W1/qSuajhPIY3/EYJz2MA9jwqglH?=
 =?us-ascii?Q?4gEnHiqu3Wkq5F7APy72XNhxjPvoMBg77v5bJZWK2pftKWKt4bty/BlgVWXs?=
 =?us-ascii?Q?1jwIqQEStOjMQ7aFmgkczwP93DkjHHVfAhYsT0aVTZXetWHdO1+K0E2iGEw/?=
 =?us-ascii?Q?8pvOcFKEjiOEPELL1iWdf6Br69PjvwzjsC0rVnQ4EDjsxUpBugQ+pPSahnVo?=
 =?us-ascii?Q?kpi7MBuK3Rn36hp24wWzli1iRjY2MHLpmx1ieQuV2e9jLysIgYFBwOhMoNUE?=
 =?us-ascii?Q?qVLR7yDBq9hUrNHdddW02JvqyXyETr5EZhE5F87wq1HnY/tj+nNRiQQBq5Tj?=
 =?us-ascii?Q?Ep7zlQcHbqJgcC/yZemDrsSaw/WNW+lqVYVrpGWS9f5+iaZMnYMGdbKsLBhE?=
 =?us-ascii?Q?s7YxikwKnA88XPBeow+VU79ej23NZrj1NKnK7se/NfLFTFcerfcbnwL2Qn3s?=
 =?us-ascii?Q?576L94+WqpyzOknAmQePOZTpq7+6g8hx9tEjpZBSipjr3HQ4zgevrG1jKnde?=
 =?us-ascii?Q?c+YrWBm7xNRCtKN05tuCBSLeYM4lTHx7cneGde5hjvgFr8y2DgMFWOdx9Hdm?=
 =?us-ascii?Q?wx4fIqGI4V7yTCrqn1Jc3ORmn8a5rIAhlPiUX159NsxkJl8oekEtmdZsVlix?=
 =?us-ascii?Q?di2SbSllj0vn+1ejbqSfXDk/wH5lB1KfDNr/37jxNI3WLpMEhz69BBMu7Cg4?=
 =?us-ascii?Q?Ju0JkSn6nCAjCtxzc29X4sJqYj1j5hl4gPpk//ivqTc34swSnZCw7ZXSTFxg?=
 =?us-ascii?Q?W6fO+iB6qsFY3OELkHDEG0F9Sr8A8ezMyr/6vIseDgsIv3ulbLL4uwkrWVlI?=
 =?us-ascii?Q?eezuHGAaCHkOsXqUgqVLNg8YUIu0QyJkdu0Zqv/38EkuWa34CX8hkd9Dko5d?=
 =?us-ascii?Q?iEBDgh+eZ4Md7BhZiNcYZTN+LhUuoR0IezjONmuV3z6a9dAnd3s3rBE/zK5G?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af91e4ca-0d43-4b68-9523-08ddaf253dfb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:34:24.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gwLMsBpt2NE/b4hgiJlXUr3ljsLQDQl7STZ8iivpm+JejCxB7dBezVwif6vMKoBP1qWwlhX2q7jdq8MexT5pu4yBFez2r7IrgnxhtO3zXWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8341

Add support for 4000000 as secondary baudrate.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Use the available 'max-speed' device tree property. (Krzysztof)
v3: No Change
v4: Add ref for max-speed. (Krzysztof)
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 3ab60c70286f..bb9ab5dd3b4a 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -34,6 +34,13 @@ properties:
       This property depends on the module vendor's
       configuration.
 
+  max-speed:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 3000000
+      - 4000000
+    default: 3000000
+
   firmware-name:
     maxItems: 1
 
@@ -78,6 +85,7 @@ examples:
         bluetooth {
             compatible = "nxp,88w8987-bt";
             fw-init-baudrate = <3000000>;
+            max-speed = <4000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
             nxp,wakein-pin = /bits/ 8 <18>;
-- 
2.34.1

