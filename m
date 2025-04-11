Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2066.outbound.protection.outlook.com [40.107.105.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273E1211713;
	Fri, 11 Apr 2025 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744389338; cv=fail; b=WlVTb9IV6b42tZNiJ6A4HkuHbMqjSY1IXWRkxgxxjNO3w56UlhQgr7Rc+4gN1mIAUpDdOeb8b+6eUjsJiskgbMIoYJg8llbgAQcZaUxb4A0GM3We3qV9bCYr+o7B8IPDcKSyNMbIhGwfuN/7C8Lppz8YSXonCiM0E9m/4AyoijE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744389338; c=relaxed/simple;
	bh=+y0XN2yoIHLZFQonQ3h/asiLvRJt4br+jMev6gpt10c=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lQJMmsi0TAYuG4QW3zTKhDcRI45sgNnReNx+sbu/vAQ1UA7ExFGdZCa5p5zmophE+bqKw3wYW0AlEEotrVVvlgXXoogYEB+hnSt4uIEvvvwZnhpa/CbEQ0fsPGiG5/pvIBrBPLPlV+MK0ukPdMoFtEx2/T4fhBjKDAQFRyroAp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L9+LgbrD; arc=fail smtp.client-ip=40.107.105.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L9+LgbrD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFD3GVi8ppdYAPXEC2+CnZOmcLpLsiaV3T8X66Xg1CNQD0c7I5pNjrJrNqoCfNAq9UsiIiTltcG5cBMyF/jCAJLu90fHnOCS8dfo2q0gtqbXer3kshBszLkpH0IEKUlw/LHWbAIJmWXUW9FqYqUKTgVD7x5vXHW2hqqdmNqb2XPDbvKFhAsW2crNoJoqtRwFimPTJUkpMj70jQhF2OXnqQNFqLjjXiJn2kOqpXVEkj+Gg1oR6i7cUifl8NPG2PxvBuPl6fpEMQ4Dth4IoBqxo67YezGeHRQZkhwaoqe3tf+DsgyHh/Z+bOB/qjjLGP2s5h+sj4scMf98tLYGe73VbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq//SMPI11AIN7J8GyHHd7sspC+GKHrHHnKehhHAN5Q=;
 b=t4Vkf0ME+PORsOQN3Y9ZdUWPJRPCzPc6hQ+mJSyiLwR23YUh4OlOLO4J0cpeY5xqKsV8O7EQJr9ea6oESTYxgymBEuMwVqj/lgynrIl+641jPKhi3pqnRcrztumD53s3vqfTqnTkp09tiFQVXRvCXueZt+R0GihnMRVzxVh1QBDmC9IZl5OpzLLeT/j/V6m6E19Oj/ww2n9aTGj0QWBbviEPraQ8m6PWkYXjxDU40aB1Uhmdh9+7p/M7K2v1m/18o9vli5UqzfnUhhNXtz3cNC1EFzIopYrtT+4T3JuDXKCvkqxM0UIXxu+OYbKMBG06SDm4mOfTiONWcoNCED9xtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq//SMPI11AIN7J8GyHHd7sspC+GKHrHHnKehhHAN5Q=;
 b=L9+LgbrDr2kprq3cpPOwt7mGznP9n88RV+UMt5AOePpPWGGE0r0ti3snPDuiBAWeC802VcushmPIvwlyoR9sXpIOMYbbpZL7tegDL4gF+neeQqBGKLhr/iCX3WDHawoe4lQGgvauk7zWWYaNYIwoBnUW+RRfGEnSxDhAhBGGWMge948UVj7Pbd5pujJcnNYvfwqRhVD69Iz1pwz7puQ+D1pamGmXXKtl/ZSjlGE10Vdr35pkcMVJEAfxkes6TzO+IIZQ36DbPnNALgNJJvHHHj0U//ONIxsR62TSIynpjltBpx8u2v9fLgtP+9ZXjzxSfDiHztt4NlZRrb6+azxQCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PR3PR04MB7291.eurprd04.prod.outlook.com (2603:10a6:102:8c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 16:35:32 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8606.029; Fri, 11 Apr 2025
 16:35:32 +0000
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
Subject: [PATCH v1 1/2] dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
Date: Fri, 11 Apr 2025 22:07:18 +0530
Message-Id: <20250411163719.326558-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0214.apcprd06.prod.outlook.com
 (2603:1096:4:68::22) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PR3PR04MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: 31ae4f5c-8f86-4ed3-1ba5-08dd7916e08b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GSaS2CyY0Fze/UASLcJio9CwXdTFS3MwWI70Mg3Jra4bm+wXHmojsB4KSPZt?=
 =?us-ascii?Q?VjDRo1L/5GoFz+y0qFL53N5dLy1E4FPValYaf75Ci2fD1YvaULbB4uux3nyJ?=
 =?us-ascii?Q?zPFDCj0xx8oIOHNYhP6eX4qwEP1NbFZgCdOf5s2w5lQkKirTpx9h6jVCYVeA?=
 =?us-ascii?Q?HBB3pL+EInd7Absp7ywNytslXTi9Zbkub8VxU3zi8NWeKU1s0SU2nbkZUVhK?=
 =?us-ascii?Q?KvAwJe3maagTgowOKMAcjI7sqXy9ysOkYnPaPKnsEI6wJaPGF9ZeAsM3gyPe?=
 =?us-ascii?Q?cv5unvcrRi8NOGX4qSzZNvUrvq1B1lurESw8P03hIuEj+lG+ngKja8DtRu4t?=
 =?us-ascii?Q?Pc/7P0C2y9pZJHFmOhkMnWbsj4VB2DxQt7HPnCm4SiV3B1E5RIe943PT4EmM?=
 =?us-ascii?Q?yTOVh0Ngdd4UVWpp4ENg6jp0nT78Az8128erKq0saazE1In6/XOzeru9xxZj?=
 =?us-ascii?Q?BFp+4OpT4k1DllPa+/OWJGxIzGYGDY103/AznZIB3RckxlrCFHWeCarTkwDz?=
 =?us-ascii?Q?MCIZKFYb3Dm5qorw7KshZQ0NhEJj5DI/JM/Ck2ercXYFkS5Kmk3Y0XlfNfry?=
 =?us-ascii?Q?8f4F9nmpn+Lvq1UJoTEmP1mx/LS4CFg0NSpNrK+iu9vH7nZ78673u0MopaOb?=
 =?us-ascii?Q?TqsYknLL3KlqhSGO9Lty813k3HiIPoOoEvqKM3Qp69upxkGdSOvwu/+nyFRC?=
 =?us-ascii?Q?PqWOVCjGYTtcA0KJot7DiyCtTv5V2yZNALwhg/0zu99LbUvEy5uPfp82Bo0U?=
 =?us-ascii?Q?PdWhtAlAOunDj3lP8dTDmqy2ehyBPShUKmva0XCJIggqxWyl1EiVjr5t/WtK?=
 =?us-ascii?Q?+FCTi3TdYd8XqEtuuEKbGNZIG0dA55Mq5FMg4UxGYnu8z6eUtqVPl+ZpVgZn?=
 =?us-ascii?Q?/C7/IrEm/vO4HdOJK2MYbUQocDhA4F4Wt+HQwi5CYJ/XqkI79CDsjYIUPN7h?=
 =?us-ascii?Q?jtF+m92vbnsYA7QZ8CgWxoRygTTKyvIdQfo5FZ5kEN8gtP137I6XjCq9yLXh?=
 =?us-ascii?Q?faprb2pkmnzznyFbbbxPJXnR5vuwq0BbfoEqw/AT9LqhjVMLGVfnU8BxYlFB?=
 =?us-ascii?Q?axgAo5dcQ7Wsy1IJHL/AtgtE93CWpR3NTKih5g3KVPGRnDJf7mQjzN94yssJ?=
 =?us-ascii?Q?LDnkeXKvoaTKkuxZBZOYkd8qmGmPvbZVhQbc6edqxnfRPYn54+mAzA4d/PL6?=
 =?us-ascii?Q?ndSbq4Mh3uEEGoS12jbUX1pqiqFq+fLZYTxJjo7u055yq2/EwOjspnd51wQ5?=
 =?us-ascii?Q?lbvfLCQNZgUvUYavgrFAUs9SpFYkvDZcAa65tJVn54rtPUMmWNQOnAbPjXtB?=
 =?us-ascii?Q?NY7ch+hPKBr2Jx5ZEquKAGrfIpxhawyRbIf2W4QGIGkxiSP7dCSClyeXkXS+?=
 =?us-ascii?Q?Wt9SyPFBKlNubCGSbQ9NyxpLZYWKBKPb/J0xe95q2I2ZuOzQsfUIRK7ic5y9?=
 =?us-ascii?Q?FhMBpFNDfZKyuyvE7R9pf5PcDkSN/3DoCI9o3fRR1KF4YeeXehKuGg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Y/MfqYwc7VT5Z+RPwKFbI7uS5iQioud4UyN4d4CW5Vay79SOQm0dkBHISi0?=
 =?us-ascii?Q?LnDxzilCcCNYX4dhInBEAWWGmUUxTFYoya7uTRDexPCuDxcfNCwuH9/0JMZv?=
 =?us-ascii?Q?fCX9y4CbNf7dUA/P22Sx0CzUpE0FS+DM8byxWBoJXMJD3SYxOlnwEVS+cK8T?=
 =?us-ascii?Q?ydiQ0eZJ0nDb5wmo/tU5fF1kXRs1119iE0tksZIBaCLkVkt/hN6fRq2R6ayH?=
 =?us-ascii?Q?GbwoJHMJ8QU3d2ZP4xMQnF6gfAwhcZwJ2sd+CQjOFFJq/ccQhvMBt+14qX8v?=
 =?us-ascii?Q?n2jB0VFeL1FJrdd9moiLzudR0qlMC99+8D5GxEBhaNSPGE6gbpX/+0zIiR8Q?=
 =?us-ascii?Q?lSP1UUD36Xllo8IVdHzhsNjoV+Zkl1xp4j/EGPREiEADF+k0xOhZNsxgWLum?=
 =?us-ascii?Q?Yyl9+tqG5dxV5t3vHZsMTEEaiJylRyS62DMiIZgfqeYL3K7NLsKJ7Q+ahUyA?=
 =?us-ascii?Q?nIN+6qyoNy+bow2a9bLg7McRM1pZi3TwPaXwlWoXdUDVHMrZkKbLs5IFiE3f?=
 =?us-ascii?Q?N7+a5wzCvoeL3zx1i4k5bfeD8AZuLCW9VoKaWyJ8V1MEKTLJsNKHCCHdqQjv?=
 =?us-ascii?Q?Grm7UcjiAOv9xDMVkuirGbKBJwANXejfD+/zk4pzzsCTzmQUTY5XvYTSLRcg?=
 =?us-ascii?Q?i6lzw+tRO1sOwL8two08LrVL8w0jl80quy4Kv7XxAtGTiqNSkNd5ygmerufK?=
 =?us-ascii?Q?9vuHi7mRrj+VL7iVUCAu8jmJZ0m5JUes5ruQf9ZDoSo4GJRj4B8rqDnIsOrj?=
 =?us-ascii?Q?698aXgdkwD/4oH9/KnrURxcZRbgOWHY9TvH33uq+Vw81t2JMLP+gGw1JKqHl?=
 =?us-ascii?Q?mbMuTeuL9EHgiwR/EyRlR3gJPdVWuai6gjzucWaYK55lZkVYVgzA4DNsWm+0?=
 =?us-ascii?Q?pUiN1kOLMKBb2H/Soe83Rx//f39ODsTLttMeSUv1YZ7VxAwBZjx/YPt0GtIc?=
 =?us-ascii?Q?Ey0GeLvjNBVxo401ZZZcaaGiI+VwOX1b3Ooay5YIvcWGYSbX1E0JnIvDKm9z?=
 =?us-ascii?Q?pdHPzemmlLmGgf1wvQwt3EAXF7WA3zi09nY23DNCn+e7dGwBj0WQt13sUMX7?=
 =?us-ascii?Q?tMmN70pU3W2wO/WKLTTB+QFcelTHwVRUMwmQBWN+xHvm+R0KfAECT86iXD7T?=
 =?us-ascii?Q?xA+oFo21QgR/i0JudlbCkJWQsTdSXxWrjxGtRbGXkkYj6Rc6ALyhcuTrT8eg?=
 =?us-ascii?Q?SbVCxp+lpHWP1ucqLmeSovDcIt4O5GvFvkTWzjXRnMQP+I1iTcdPz6NkS3rx?=
 =?us-ascii?Q?LAFz2aXoPxgVS0PrdDJflpczv9M/2RWffNDSTuJpjQonRMXSCsIXIj5DQKbp?=
 =?us-ascii?Q?GjhQweLpz5TW2hvjReqyG/SxqODyO3H3yrvQbP3J/+/gELVOB+KSf4Iax0pd?=
 =?us-ascii?Q?X1YfQLlElnFPs6dtLDzqfMN1w3Cd8wVuafLM5xy8Aqk2kxbNnQnVBMlAB1j4?=
 =?us-ascii?Q?JlHl5DnoAoqVpkRCgN6tk0EMS/bayziQRdLxE57XyjxYO/KxkJuOvonGlte/?=
 =?us-ascii?Q?XgrNJ1qUKyIkxcmiWZG7s3OeaIhFjX4fSWSK6vhfi3N5CaU/1nDsQOtRY7Sd?=
 =?us-ascii?Q?0CFhR9UEq7GAxz69wrXHJiNAauUs95DUXkPnfVdzhimVe2VCzfYEeWdmy7lD?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ae4f5c-8f86-4ed3-1ba5-08dd7916e08b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 16:35:32.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pZFPepR0mxwwASZIBOx83DfmaYBm1/1AHD2o3Yei9TR3+xSSTHBxQiq0PtrAdOCFDjmJMn384WkJ+BPqMpmZ/SdSTuCyMedwjr7btAWG1pY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7291

Add support for host-wakeup on GPIO interrupt.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index d02e9dd847ef..ab1411c05f49 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -48,6 +48,12 @@ properties:
     description:
       The GPIO number of the NXP chipset used for BT_WAKE_IN.
 
+  host-wakeup-gpios:
+    maxItems: 1
+    description:
+      Host wakeup by falling edge interrupt on this GPIO which
+      is connected to BT_WAKE_OUT pin of the NXP chipset.
+
   nxp,wakeout-pin:
     $ref: /schemas/types.yaml#/definitions/uint8
     description:
@@ -68,6 +74,7 @@ examples:
             firmware-name = "uartuart8987_bt_v0.bin";
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
             nxp,wakein-pin = /bits/ 8 <18>;
+            host-wakeup-gpios = <&gpio 12 GPIO_ACTIVE_HIGH>;
             nxp,wakeout-pin = /bits/ 8 <19>;
             local-bd-address = [66 55 44 33 22 11];
         };
-- 
2.25.1

