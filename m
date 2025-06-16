Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B301F5433;
	Mon, 16 Jun 2025 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087645; cv=fail; b=t+CIh8JbWZNGR0es0P5XWNdwfXJhXbfQY2+8wm98oQSiqP2Fum2As+lM44O4nZ71uRGqULF87Oaiz8uEthC4tXQbfaYh5o78C8FRCdmROYp7wUcXoeu1fmJ1+IUNz6EBrL3P1CJvep2NFZQAAXm2qjeCKWzd8bWnX7QYd5x4P18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087645; c=relaxed/simple;
	bh=URjmiwooHEjHlMRQKnDB9xEPSNyhBBwOcBUg5RupJBY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mm28pX/VQzLFsSlPe0yFfvE7WMRpkFtoGSVdOBN4BuEZdiM4h0sYnRY2BXRUemlVadobMTQQZF+3O6ljVyZjvE6mgS2FEHFzArDe/3CLH5pG5cQqVcro+sDL+rEEtH1P5PEJnFqiwOBWIM1mv88tqBe5xYYf6fZXGFNHNL5MfO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N/ivv6MK; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N/ivv6MK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfxD0XC5MiZyqH671tuwHO07Zk6L/E50A+uHjun7DGsMTUJf5TZF9aDPBnFS/qXjtaZhYFfSYSzGs5Brg7h7rE1bpoiHcFvwputuo464D6/oPidARZkquXlXSiHM1dqZ+0axJu6Eqr9zvzJaehkFj2Pel0MgG6fcctalxEPMKZOH6JFIxj5bxBfvqPEN2Zmxa2P74IJDfjV2phG8r9dlfocxkLAoFjiD3Wed6HQ2HXDqPjF4xm5G4k1LIEtaBSZMbY1Y86RGVHq/QRPAtFSaPaPv3sjrwJuZDQGKKeEDWNxZUJvvsMct0noqukXtunGcj0Pwm62NH9dvndTyBN7pZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmACoY+4lTXNN00xJU7vhnZ+Co+fI3ej9udqL+u8+Gg=;
 b=Xnuner6Apus7UPl9MLp7wvYAPZTE0euOBY3ADbIPBvqzW8DVPUEKWYCHNnaoomFvVt/FuZ8qQc/R7u3mZe0fxjUZz9Upm2Zc6AUGKUB+9eAXYD/2jC+hJeMs96IlYmKrFqgQcNlBOY9TWlXXfOx3FNlb6kRRIxs9PnKqvR9YnyOTkdPszcUXZ6zF7xtMJCPOEIEgzfF6+USsp94iMPQ6ObYC8ev6VGadbBhenNS3yTvVvtSOsfWJnEOJ2AGYPXQRO/sFv3IT7CGqZdLcW/b5ThG+Q/TJTPKTqxOmwqFXPRmdguRXXeICWeui6HUoFVtKxH/C0RqAkUjzWjmpk7otSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmACoY+4lTXNN00xJU7vhnZ+Co+fI3ej9udqL+u8+Gg=;
 b=N/ivv6MKo7Q8FeTDXQIjYvsWRdMKN7G6mLIieCD7KyvCl7BMnQClbJa3sl5NmG9LJEFyY70vB+cmfUSPWLQQdi+WY1RFUY079nqwezE6uPmP5i06aNRSEebFJGrRjKEYRHwh8M0CRWyXPM8xx2w+FNkdxVz8bfDC5mHbsbQncxr4Sj4sc2i2B2fYBg9ZID57rw2+GuRYMDhz6/R28nn3UJiGTYjlI32e+HEMvlXbHVrFklUx1XGCN/A/0rqsvmBapC2yqa4PjRvrJmvH3y2w9Fxj6mNUcMk33W8HIuuE7EtdBmusK0JRh+UvFlA9eyCAI/YUwA+6KDYrPALLwzG/lQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB9137.eurprd04.prod.outlook.com (2603:10a6:102:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 15:27:20 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 15:27:19 +0000
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
Subject: [PATCH v1 1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
Date: Mon, 16 Jun 2025 20:39:18 +0530
Message-Id: <20250616150919.8821-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: d1d55c42-b804-40cd-fcac-08ddacea486c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?goX7rvqb0PFZnwjtOFr5Sm2y67ldmHI56jic4NSWgp9rPT+JuEHv3bW/sGKF?=
 =?us-ascii?Q?mCH1mKTGtMXh1iq1YzngrTmXxTp5LuPJ3HZTZebqpnD/Pbrg3d9VVchJa6wo?=
 =?us-ascii?Q?Ye9Y1o4McbWcYAlS2ynGy9hwHfPEyh3jPVMBF7LAULQ8eVjdX9HkQ/GH1vvD?=
 =?us-ascii?Q?Y3w2OtH0q5mn/0nnILXdAXIxLcBa1zQ265FQ1SN0JM00UDz3Ql/0AOTdYGsB?=
 =?us-ascii?Q?c2Z1zCccTQqcRdfIGz0DA9iXV1DYOXAIY/omj2i4sh+nQn1DNKBN1EM7tLVt?=
 =?us-ascii?Q?t4/sTf6IsTwjWVNR+rjBVqtLgTXJkfhsZ6iJaAVGTVWeWIbzG8j88FiBobo9?=
 =?us-ascii?Q?4bPYE/z2GiWIu7Mdjva4T7TXtM4M+aFoS/oiAdyjVwLJx7n1n+PwecldLv7q?=
 =?us-ascii?Q?uC1OifOmiStuOqPF2lyshtZP33LjOb39Cmjj4OfhVyuYek4TGI9xeWIS+S5p?=
 =?us-ascii?Q?SsjIFr6iU+B+h78P89/ON/9mAq+cr4m4xZKlLYLyehpXy3e3Olu3+fwaypd/?=
 =?us-ascii?Q?cnl3LcJ17emJnrg0RAfg2GPBGfRCopCqetQH6XF5QVC2talmSU0YzOEValGy?=
 =?us-ascii?Q?Lvgtd/tocfWd8WRIhpbIkqlsxz6RSxCnnfmEBNBGCqk3fpfKKUKxptFFMSDw?=
 =?us-ascii?Q?cUywHkQWZb6ITFG62qRl2TbhhqUOM+agrOi/nTAHd8VA7+TbeWg8gf4tEaI2?=
 =?us-ascii?Q?IQGjy4wtT2OueWiNqH5Fm93OMpCOBlLWgy73xsOGd4+vUO+rvlq279CgCVDZ?=
 =?us-ascii?Q?pOoG5EZTXfIcfxoaG7cvciMwF+BCudvN1GSp9OBNbtcWoWlTZqeRAhtY5Pkh?=
 =?us-ascii?Q?onl5mXfCbBG3lquxhbvVwyBNVxvtdIH/LZiPf72VGLaXLKNJUox5UW856Nzz?=
 =?us-ascii?Q?v2t00sbnvHhb8dT3a2IfHFJNjEnVC7SYQF1QMnk2hCJTAe2KdrfNg/AAchfq?=
 =?us-ascii?Q?tP6IMqC3InZVrnJkv1R4I4I9gDKt/bwjaxGAdJWkakTYLCWa9SxXBfsVK9xI?=
 =?us-ascii?Q?U3ZNUlEnbvH4JY/g7Ah6oGg0fZrrxouOQBJvhhXLSOEvkK/qHlEL0/ussHSP?=
 =?us-ascii?Q?j3j4mkosJt06cTDOjBM5Umb80au4ozgPpiZ7VozLp94GjysFWBJqakpVe6BB?=
 =?us-ascii?Q?PAYXffjzKw/bssXutj4TmRj7iNOFmsWbefugbcCNea1WvEhiuOAKrfMhrn7j?=
 =?us-ascii?Q?laGBp/NlQjhlBsYqaqaNiokkXkaWCNphLbihdsx6ol/pTHw7VROgXy86GcRR?=
 =?us-ascii?Q?6y1NYceCDL43asktpcJ9JOlRjBVmq6FHJfcdwUE6/MzulCX/sqv5d5a0OlaM?=
 =?us-ascii?Q?9ztg89nKhSO2OZ/+yvoy/686tmSpuC2b42dGzR7Bk0Lbw3YkzM3IJArFKdSO?=
 =?us-ascii?Q?owQqPhoH2GvPuqU81FBHho/5oDCl5eUQnADwoa4ymBSrkk6xAGbUxjOpzMEP?=
 =?us-ascii?Q?fSMlIEtYs6NWIk0mpVqNVnKIo5SuYask3iyp6h3wd3cwfUxeNlo7lA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wF7f0J3pHzkLqEtAsu7ZwgWtCm8zQt4dBY2LiEsDvxf7pR4OQtglULlVp7kq?=
 =?us-ascii?Q?+ujnp/b1lb3Fv4AQJLqsJeT/oUDSE2UQ+9UFRif0sSZgYUNgy7r4GbiG0KN4?=
 =?us-ascii?Q?ulzkZMhbKs9uz5htJi3KpSU7aHz15hnx/TfBtTLsud969B235Fiw2nwiWOov?=
 =?us-ascii?Q?uzbfcf+rv2Bjri06vDH8WrnbrCM4X4r3Z4mTkxMHKVwsSj1y0htYXd5JqCfi?=
 =?us-ascii?Q?r1WRl4MrkihPYLS0+CBg424MJiPcqevJNjouMBsf1c6PsiRAU2o516gLepXO?=
 =?us-ascii?Q?zZwnqGY37OFi8bWar+zrNcB3DzpQ8EN5dVAh/+D4IkZnHiajkIDHrCQFcxA0?=
 =?us-ascii?Q?SByUKOJTcbdZr/8kOFGCTuS9n/NIoIBAEL0dsxcNgamLVDE2o8O0xmtLpUoW?=
 =?us-ascii?Q?TT+kycF5TU8JNYvILBGdfa3Qy+rN4GC16l3DXS1cIkQJBgSDpt0uTWd6wtZm?=
 =?us-ascii?Q?pJh9p2vII8RsqF2pq+rjE0dO3wULTA0dDNhUEwN85rpsI8sSJhy1UuXGRzqk?=
 =?us-ascii?Q?JskBjqi4KEfJBj4dCg3cC4qFi4Hg5/zVG8RkelAWSiPKM5NDbmkiKYArxfjT?=
 =?us-ascii?Q?Wd8j+qQAWPsNbD67EdYhVqIAFFkmdnQ/gU3bpLyKC7AtTWYiBrKUSw2wcVnV?=
 =?us-ascii?Q?i66qb9vT7fJOyL/p3qyK7Z8fE8OrqrTzrsRq1U2nsED3sJM+ObMGizVTYrJt?=
 =?us-ascii?Q?EQOxa49+sQsEizVbuSGzSkN470PrxwUbbOUG4vZEmcfiOwsU7TUL6pw5zvoa?=
 =?us-ascii?Q?e5vVdIIElg1yGepN6jz6cLUwjPmCw9xHZZpgb+aumbLoUBCwsItCXF9XGpBc?=
 =?us-ascii?Q?wny6FSOyVMRyUINCYLssM2ZJRMtTPJYdtW3itMDPgSaqUNRkvv7grqQGcxRm?=
 =?us-ascii?Q?wjr2e4ueW3D4I6FLzhYbEaUzEgp0Z+8PIxvNL0i1Xuz2yWt0EV+RlhKaaoX2?=
 =?us-ascii?Q?/P+S77p18AHztR5YXhO7k0wYnAbHODj56MPfnZB+1JWnivg3m0epOE5noVGH?=
 =?us-ascii?Q?jpsaRFr4zaXtw3KFWABlmMCdpv9pAjsIY4L5RMxsXSzLZTCl4Y36ctOZRsFd?=
 =?us-ascii?Q?l8wIBnZKavCYoR11B/uoDYlgh9FMz/j7XuhmSynIMwFDXlx4jtQlAXX+WkQJ?=
 =?us-ascii?Q?1fQiA5jG2wvz7kQhR9CsVwaWFRTLdHSUfORSiEQmIRcyjGlSXOwz4CYgV6AD?=
 =?us-ascii?Q?tJPFCHsSPx6A1BVi0XOq3o/bOknH1l1I+KAiE8rHWghAiFRH0eMnyJKmtdbO?=
 =?us-ascii?Q?AlcBMHqzMqwHW9jrb4AdynVQxnQPehzaxTN4efk66dFxfp/l9Nhgi/TZB3AR?=
 =?us-ascii?Q?XY1TJ3Mv2p+5+XPLjr88Va3DAL/5O5sEbq8/IOtv0WiMf4p52k7zmYWzqssJ?=
 =?us-ascii?Q?JCBMRCs0yM+Fv5N6/8ozn48xpfcT0VdvLTe+QDW3UPjo0g5BVuaijkfdpMzK?=
 =?us-ascii?Q?Qbhf+ZKwPw8CYjDJ1HC+ZGJsd1cTfmQEBgiNFYgKYcsSIkE/ayD3vhHBaITY?=
 =?us-ascii?Q?iGOhFosBBLBrqDrb3AHBnHaKNkm9UM6W8S2ljlihyeI+K/KZo/mlKvfYlP6b?=
 =?us-ascii?Q?//x7DbQS64ToHNg21uw2EZDX51fsRD14XjOgj4S0DvlXN5FVMBQY4oKeAKmR?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d55c42-b804-40cd-fcac-08ddacea486c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 15:27:19.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skFKRn4yHAHjqsHBL8BdoHyTmP7BjxDP8Eh3eintV81p+vpjeUW/r6LoZ81rK47Lg4k/S1kcGmBtDIc463UOOfUi+dRyDh3XLikjiLVGMoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9137

Add support for 4000000 as secondary baudrate for downloading FW chunks and
after HCI initialization is done at fw-init-baudrate.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 3ab60c70286f..f1c7f900001c 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -34,6 +34,16 @@ properties:
       This property depends on the module vendor's
       configuration.
 
+  secondary-baudrate:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum:
+      - 3000000
+      - 4000000
+    default: 3000000
+    description:
+      Operational baudrate after HCI initialization is done.
+      Also used by FW download mechanism while downloading FW chunks.
+
   firmware-name:
     maxItems: 1
 
-- 
2.34.1

