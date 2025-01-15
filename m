Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2054.outbound.protection.outlook.com [40.107.104.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A01142903;
	Wed, 15 Jan 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736959058; cv=fail; b=uhd10XaKfKx6gc58b0tLS3brEgjiATl7RcbPIzGG/SblQneoRsG00DhpwwDlNMCdy9n14o4FeKcR8iYVzRhO6gWzZSywV46J3LmjhiFsPrFyxVCTKlOtLXN9XIFJc+oPq0AF+902jM3Vj9LBSx+sWi9TpHd98qIAeD3f4//AAhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736959058; c=relaxed/simple;
	bh=QKilRpM1GOK0/1eazCteUzILU5562UmYG8xApcNXkRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uugwNZHEf2+DNFTr9KiiZt2i1bVBXF37vN+FbQ4jGmLllmmO0GVXEhjORLt3h46vRLX1/NvCfxp66vqIzCeS6tIbIq8CJL3pvgxtQIc3xfzwBqXgZeZokZCkT/kO7+2kqFfQFaUR/9tYSMpuV2VGlzKHlNJwM2NSUPGptxA0Kt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PTFvs+Nb; arc=fail smtp.client-ip=40.107.104.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PTFvs+Nb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qN88JaoTTXYsOpJv1iGdK5+GhY61//RpDT9S0sEB9FV1L1dPEZFYki365IKTLoD8OmfCVzM4TwHLdLwIr8wDI+uajnnwEB6MvdahrBsTWcrwCdwTc2cysGH+XX+oYdoH8nTKhGvGJoyadDm0I1gR/MYmKE8EtsByssSr033QbJENIpAV9Cie0Z/fhJ9pD7HyANnoNLzbZkArN7eIR1ZQIuJKTi8UbQSHybecu9kFLPgf1KZXghhIPa3q01UQl/MaRJ9QM6g0g0SU2rfqotmeov0Lu7V1xVDA/OnJQpLv0DtqhIL7swmh8pOckNgirfGaae/NqVKcDKf2oThTMeGsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=238kcuI9VnEgk+SX0WJmEK10qL4LdeTDe5BiGl/SIVU=;
 b=onBzmOQW17tzDIhJ6u9JDf0jhMP1xovKnz+wk2DALndpXm7dySHIMBY26bACB4lFd2Mx2VCvkmnpteq7jSOhyeEPBGuH9beUg/F1woxJPm5ZdR7is0X7T2egUxefoHKkGgLkH9EDVlgg6ZwFJ4K6awr5NO6GbWCb4OPXC41llVUrfqCRNOUWA+1PNbs6ZZV5/35Aw0lDZ3bb2QNvS3qPEbdjl8NyA3G8sK2XJpzZe0wGH56p6KR5KxgIzTs8GsNYlrpktj3SGvjwUNX8NSC59eSYmGA5tz2xVLZcGaiSAe/TqwTAZEQWOKcp4bEVuNpxh+rnZDNz6Gism8Fl7d2wlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=238kcuI9VnEgk+SX0WJmEK10qL4LdeTDe5BiGl/SIVU=;
 b=PTFvs+NbFlNiZsEjbaluSa/CXoaK+TKUizbqY8r1coIBQaWBHLB7VjivfGDf+kb3m2VzKFNjK349kgIwL7HWeBnK+t9SuxyA7ApK5vIF9rhm4xx5iXtifNLGAE6t4eWRn7Wzj8ndwa1n8pdUewpcK6oLkg4FfX+ZeUbGHbNjYzidIOJPXLdnvfc/M45TsSgctgH/979rkCLPG12q6pK6+UOAST6mO1+63bhTKvOBjwIalNWsGhD5UZ42909Ly9Ed/yT96GZ/LysXmAsqNDm+5aIJ29C2t8HVThK8p4xbyFUYLTUm0MzfVa0nZu2i+FKhNc5vnKfSrYPOv+QVJ4/JLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB9079.eurprd04.prod.outlook.com (2603:10a6:20b:446::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 16:37:34 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%3]) with mapi id 15.20.8356.010; Wed, 15 Jan 2025
 16:37:33 +0000
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
Date: Wed, 15 Jan 2025 22:08:45 +0530
Message-Id: <20250115163846.2385345-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0010.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::13) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AS8PR04MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: d163e9a0-2be4-4b15-a101-08dd3582e97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?teTYrPQT4toBf4JLmCHLdTuUFIZaORi7+ZOWYieiSpmvAN68edaotJMbvsNE?=
 =?us-ascii?Q?CjXoX2aOiOAYhmPyHVuQugqRKkf50LvIXXPZ8wGujxjtrZV5InLxvCKfP6wO?=
 =?us-ascii?Q?izDeK5tbM9i7TzyTXe5xkDMzmHVeOIxqlKQwaRrXYYCCFlKkhRXHIHrSTIJQ?=
 =?us-ascii?Q?72HJIj++WF4uWHslEkZXzqcCpCTLPkJLWkpWpJ+nK6UV3T5XtOqEDCMKXBfJ?=
 =?us-ascii?Q?YuZRo17RofM1dFgPMaJLxcXZWbt/541PXiY4wa8c0lFHBS46mLDdhTceCccx?=
 =?us-ascii?Q?gemGcYaMKxZmEKNMJ6bHUKyhU891rkSZnIx93RMBuYX3QEQCxp7VfYnEUsgn?=
 =?us-ascii?Q?oLjXrdIkBSw2gZUxTBBK2aStUBKVGVFTuDVSB5dGaql2TIfVCa3A2SmEZOoZ?=
 =?us-ascii?Q?5IrdGrC0auKUOWdRz/dZleWKuwqmKN1Xq4sIo74RRRJadaMvTrFw5OckP+MJ?=
 =?us-ascii?Q?xSW3tLM7lcnytbeEXfQLbQQn/nIX0nCa6fodC8tsczJ3R0xiEtBa6Q6k5cRM?=
 =?us-ascii?Q?wsK4X30hHOB7sXOJ2OP2kU7WiXoVyfDKyTmqguo6vF+gxKfbWatc8gRoNRGP?=
 =?us-ascii?Q?LKpN+cwRzI+N3PCp10phpudxEX/goQRrdkcALqdf2uHacNyhvFBrw1YUhibr?=
 =?us-ascii?Q?ibiLdoSrwROw+Qs7r1qhOuDfdRcj+NQ82z7/ME9a6w+m+o69mlt82C8yQAoq?=
 =?us-ascii?Q?Wig1Y5wIiJAhTfzZ3Qm695KDLNR9GuPalO4J2w7A54T1dFdy8P7XKBv8V/zU?=
 =?us-ascii?Q?WQipguevOrAi82JLdCc0OokgOhGfJ2JGGSUNw7L8P5heKlOlI2zQLBF21Dcb?=
 =?us-ascii?Q?eau20jzzRIVjhpVwMQXybYkPyRCd8uRRunP898azrKsYNPrRLs5pgc0OwhZg?=
 =?us-ascii?Q?HaxDYLEuOBxhscyzaJ3UnXm0MCtqX+fospAk/Xypf3tE5vYUn5zuiN5LSWc/?=
 =?us-ascii?Q?CwHwxA8sy9ORq4JF1oR7xQPGnvjE8a5ell1kNiNJV4FRbY3rCcsSq2ElYSmu?=
 =?us-ascii?Q?R66Smog6iLNTg6WOd6P61NSgbSN7c1NaoJzAljVxM9f7Er/nc18XVieo99ZY?=
 =?us-ascii?Q?bRYyROV30t6lC203m+3P/0IKPqYWUZMDzVTB6PYUttVPeB02J8Yn1LvUkv85?=
 =?us-ascii?Q?dx9M+7yT8ONemxLpXpiSTHPLHdzlb2wsxw0MIkIZPAj0HMFeGoZwWBgEi5PG?=
 =?us-ascii?Q?JrvforYwe3aETcxyGK0LH+DvsZa1gy5HUxSKT7s8LpjnflkVkfbjJ7gfIybS?=
 =?us-ascii?Q?qlnz8V0rchZry6tAGIc8aXCrnnzkTmMahVcgvJ5cLZB9F1lW4QDaJzy38w5r?=
 =?us-ascii?Q?+HALf4JscEUN9K3Cbndru8Hj2Tk1z4jmdiqQV/SNJdJwIvl+bTsnTk7R6SKx?=
 =?us-ascii?Q?27XT69LbNGdKC3qe0kfqjMZ/H+cljJd1esPvm7LaR8pblTa3DsSNMHNQbO28?=
 =?us-ascii?Q?x9Q/vb1U04A5UJZOii45RBrNRnUld7ka?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T8G3pvReBoiJyznq3Bl2kV7Wz62K5nggf8b0hLtBFKk2bJ+Vl/VzpeoW6ZgE?=
 =?us-ascii?Q?US64mePrZsj4KwX6OWlm7fiw3uw/YfYk0Djptaf/A7LR0CinYEnuh8OnYtT9?=
 =?us-ascii?Q?9w+8aUND4R10T001mQPRs9KbTiBOBPefyF1lszhfRh66MCrN9QmA0Q6L7meX?=
 =?us-ascii?Q?mMa4q2vxPkWqWDWWcSC5ZoU0c3vu9YAYKDk53hvXDrrAcwf+RY/h+ktYsQdu?=
 =?us-ascii?Q?/GuLfrXsQO06tAnwgiaY0iQt52BT9qo6nE/KtA77W3XHJZtTKY/cExN2QN5q?=
 =?us-ascii?Q?429N1oITR4oyz5HfHqKhzGl83BM5EPbPoiI18PV1X2hAH+bnNnbILbSRNyCI?=
 =?us-ascii?Q?brfmA7ZJLhYPAmiOUHz+q2zzg/uuEJaYdpqpLrMmfL4HAS8lTsgNbbi7cce1?=
 =?us-ascii?Q?wiuLLQmi9DNJC58Hd9MHyFdhJ7IEkm9pVF/67QIiLeEBNirZh/jSxBV0c+Ot?=
 =?us-ascii?Q?kAJbD1ngMVEapNVjSuVW5BbNcln3czxT4JRbCYdGXWgxKdD2/6z7oGrMgtAh?=
 =?us-ascii?Q?I2prihI84jCmJL7/DXIoNiSQY+fQzsMRrhm6GvLAE/MTMR9TdW2K4Ho4hAQQ?=
 =?us-ascii?Q?dkl2/Rqns+NYsmHNiXEkS548adr5dxGyIVeLtZBEsWcLTWU3UEtXzH2M4w7u?=
 =?us-ascii?Q?gfVlNpo1FcMlZ724JFqofkgwAg0VVAp1KY+uChMkY+HnHcdnYgcUA9fwc5+u?=
 =?us-ascii?Q?49e81RxlvFDubeDF5WsBg8NMmw9qxIxwPKWzxeoMCsOOWHhL21TCiEJx/XPk?=
 =?us-ascii?Q?hqRLJIHU5cNjYU4hw0tlcatdD4P4qPgsAUrSjBBAkj4uywZbIe55EOe8SKZ2?=
 =?us-ascii?Q?59rL3aovrVybUdBjHnFWOhH4wtgQZwL6L2NNeblrA4GUuZl7tRwimyHYP0lZ?=
 =?us-ascii?Q?7U1MpUqINNKn+gifaDol9pIk6Toaaw0yohLgIqGQE0bSKL6jwSxu29f7Khjl?=
 =?us-ascii?Q?JanPq8/JquP9558fdHZ9qLeRINQgIhCgM7lxGq4XrReWs/UZCgFvsTLqG+DR?=
 =?us-ascii?Q?vnnsD/IIC88OFCz41lH6F6BAhyMwSmSyLErsX6PGGqXEsy0hWLQxhf7OEFkc?=
 =?us-ascii?Q?BFaSnOyzBzPNYgHo5g2obDVMi7MbW2pMRLypyejR+5x4YyADVYEG6Fw7v703?=
 =?us-ascii?Q?GLNraVuMkALZWDZ8Fo0luNnEINGPZroPE4kQRJN6QBwiom60LtYJepUqx2Cm?=
 =?us-ascii?Q?lNs5TL5fvkIwgGFALwwQyq6CtpFgKHpLAIXvi9OKNzHfnwGoJIWXc4fwC9uD?=
 =?us-ascii?Q?Ym0nk3H+klVFRthi1gPFphFUyYiLjersV0ZnMhsHf+XiPhDsqFgCcJdclNii?=
 =?us-ascii?Q?vhRmm/F6s6TP5hLVMmgoP/W302WxGmEYGyFUtvtmWRVN2sEr0a88mX3dJTtW?=
 =?us-ascii?Q?EoD3ZkHRUSOc3t36rpsZBwOodgrN/OnU8Q5FKUfYZiWbkfEoK1X/wSD8XoTW?=
 =?us-ascii?Q?3bF5CAfeMQJR76t8fgzU0dHhKYwXg7XXvVWDBIGW/UklRaz0hr21D3zqn0Er?=
 =?us-ascii?Q?llj9xUXYtp/MxmS45tBL7aupLNQYW+GyFznDODqEUm+X5yywdQSNwsAPvnvC?=
 =?us-ascii?Q?Q7Y+XLHX37ubI+DKuhgiWXWtR6bpVcNAguewIMkTnZbOU3e4EjWZoyLCJ3V0?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d163e9a0-2be4-4b15-a101-08dd3582e97a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:37:33.8657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qH9f10DRGQusisi4dX9qJSTpoZ10kjs4JhwsCscNKysLLSWoKrxkO5JEVq2Pa0KMxoD0xyzeH/crUeTKPUQRaLMBPiAJOel+j/76R0770L0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9079

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

