Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012032.outbound.protection.outlook.com [52.101.71.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A027FD6F;
	Mon, 14 Apr 2025 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651219; cv=fail; b=NzOhr4metopApw4lzGZgvERhSCeZFTu2i++bYigfZnuBGemz7a+8g6UEGlbRF+aeI7+Lu8oMmCubI0s5ZLeuc4HLD+Se6HY0UT0snEzjsmiWPo1MWz16y8JXknEahPH8CabXa0zFZPHG1vCzB9Z1VrJnnV8oL9OiZ5GHrbX370s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651219; c=relaxed/simple;
	bh=QY47Q3P76Un4LNMnTEaGmS49nvRwvdOiRHjuuWFDCKc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fHznvCZCBwUcDYZGXqLCkSbnWiUuoLq0L0jCoAXLiUwtA3xxQA4tneYiN80TgufFkFREN70EIVx8KFh6dMrJ0IvCq3wNsDmUCQ30FViuy76JA6ChRfhMi1u0IqozRJvZ/CylF6I1f0YdwI49yisy3SH/PEYFKFdWsTjUHwUbIwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hWTxIHWI; arc=fail smtp.client-ip=52.101.71.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hWTxIHWI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x3RsKiR3Mpd/aRbWrHBIOU6wAyHPkzEuWtfZy3DXO2kI9Q39gZT4UYI4+6q+Dyz3rM9AuiR7wO3bJRQDxhyJiBndl4zAIWhtOLKsgVPeDMmWqfdJymQa5j6G7+FrdUY1CNtcRELckZ4t9PSa8Zu4GEQc6fHeyXbIJhXyfvqEL/Z3TaYXohpQHKjRDnKFCDO7tHmnSfO40prIiMWlbXgNvVYTYniIgnos2ByKNqHmCVgw9YZzbzVhWvusELpW//GSdDDgxt1FPvyi/DsmMljRKpgM377gfwbEvkmoVBTZISAzw60vHSF0QGIv8t7mizA/cDA0+9UBVbDAqf3juUoLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQC2qQjU1y7kIWv9BDgc/h/gMjLk/AJ63fW0kpyeAiQ=;
 b=bE+b0IHOY2AGEsTD/uZfBP6hXE6kB9U6K8ulAJrkCEg0Cwq1p88U7ihnSKtAC3chwOCvdlgtELm2dDzqneWmmffEEe0rBNEpjdbYAwSWuiSgt5sb5ee2Il8NcOPIPSBipOiESfqMEeAGeh/Q3DWqetXnw+h/CVTSeyoS07Pr1e6aenb4q2OXtU5O+qgtAJ+M9dQb4smdUGWw8pndengUrUIUwaLUfmCThlQ0hTwsD7xBCKRzHLrSd43oVbWAVg0NR7UARDmU3t58TIGGXkd/NJlQi/CQfKfoTsxt1FU8Ka1yj8t4nc3wwhvUFcOTNx+e7PdDRNhZHuXoshmX8ln24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQC2qQjU1y7kIWv9BDgc/h/gMjLk/AJ63fW0kpyeAiQ=;
 b=hWTxIHWI3VhabvUm7RKXNQE1pW0lrdfrV9G3zu3IUCGpsKSvmBx70jUwtU0UTueFidBLtaW1F0+QJxVNs09naVC+f3Bf6fXjJO+uKcUPkE17W3YAd25KVa/0L7jUpCXoy/F87UGRziciKYG1SV7rLsgugqogfxKaJ8Lid2yWQkDa9lBS76wBgXH1YiRh7ZVesShlFp0xJSAial1gn0sU5XiegwE0n90ddOuGQRyMCKItK8JwdDd6XbHIiyquEojTQ0REqDXjZ5e0Ir25+ZR8Wefe60ga4ap1HmPab4ZGTUGtQbxUxhHgUX3zEEy1SdqqCXaiVh4BOzDHGRKNJ/biGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DBBPR04MB7897.eurprd04.prod.outlook.com (2603:10a6:10:1e7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 17:20:11 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 17:20:11 +0000
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
Subject: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add support for host-wakeup
Date: Mon, 14 Apr 2025 22:51:59 +0530
Message-Id: <20250414172200.401437-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 8e29a5e5-ea38-4b69-c934-08dd7b789c97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oDXiLDwPFx4DkPHrLtcJHAeIHoeseuuX8MJzeN3qHXcndE5KsD9CBysJEzrT?=
 =?us-ascii?Q?ol11rsNWIGEm+sCaFrnpy0vCnqdNZjG3eibct049rjuL1wB9zY5X4T61kP1G?=
 =?us-ascii?Q?/7j6Ph5tflhR/IRQ5X9Pq9d5ae1YUL7UHbm0KfJDUppq7nCFtidhmTtEP/lQ?=
 =?us-ascii?Q?vG07EfNs6LehIcsOiPGcxUsYzFgI8CohGCjOy+4kZ3rcSN28YGm2+hlUalZ7?=
 =?us-ascii?Q?Z8vsb5Ck/JFniFKdC4ir6T/xhjdGfmVGdnGLvFcdi1DR5nocEocVMsoz0T7z?=
 =?us-ascii?Q?GZ12MvIeyDkvnqKCix+Qk3NVS4d1qCL83SIbWdcWqKwhYrIdT0ziwqs3vJXy?=
 =?us-ascii?Q?62kYRCLzi39exKrmzyPhvgGPOnWJw6SKwVpnm57ypii0SUqp+djfO4eGhlcX?=
 =?us-ascii?Q?SitBOb4VhMjQeAYNnGCo+ysSTWlFnMq1v8xlI6f0FEXNpuNE/s6zGwqNXFIN?=
 =?us-ascii?Q?OyRjp8xnXGPwwi+p0qzQeOLBvxoZmAA/5wtFsELYeXMwhaV4M9HA9rzZ45uL?=
 =?us-ascii?Q?ZNKCobjgQHlBS5U66dyr8vVXhkQWWopDcRd5JJNgbTBojRT1GqlqheeXsoN8?=
 =?us-ascii?Q?qqlkb0XwmbkNUmNAgbzZ8KocXi0dUvEwZHbZBFPR/22GskubbBqQQbr3X/K0?=
 =?us-ascii?Q?NouXL8w7+lEdR+OaP7lHGXghMIzNDTIVZh9yeqgEC3k5tl4EbKNhNx9XtxHd?=
 =?us-ascii?Q?Xaw355yq2khWkQYoDLysHAjNoxD/VARL5qsx1nK5hxSF/zrg0rSvmVgCZJ0b?=
 =?us-ascii?Q?pvZB9tBuDO/fmK66ywLngogngKJw0bKYmdx3Ny4KvY3MeGT1wYh7na1vf/9/?=
 =?us-ascii?Q?qFpiSp2Inf4LsDs2Fu58kYEjfKPv0+l9Fel13gm9uuDaWEVBOFSB0PzumBhS?=
 =?us-ascii?Q?Z9dawcIfLje7lX9Ztam2iE6+zX63lSew+0gqbTzZokJPe1lnYj0udeNnPu45?=
 =?us-ascii?Q?ZQnOzhPei3O8YBUn+kMBdS9sAoa2zPzfZe1K4JSs1yyUg4Xhnf/rMq18vvi/?=
 =?us-ascii?Q?LGPQXQlnRZZaxOHDwNJtyppJYNRPwYWx2MmgvDXrLPWr2TOEbuozF/2jAz9w?=
 =?us-ascii?Q?UivCQz9MdU7FBxq1Zw/b46AKgspRQ7ckR8nUztt7D33InbgbNrD5CJwyjhfD?=
 =?us-ascii?Q?Xb7bc9e38tOweIJG0ka6dz3C9HxeCaP09hEtaDuB0NLJ+l7oBelqX+gHHbHq?=
 =?us-ascii?Q?hjGYJjsGdT+c4c4mszA3gEM3httzOSf6QqqN+Ypzct0wPcFxhxv1qRhKfRvc?=
 =?us-ascii?Q?+rF0O4d1OGFvHbri6ncL2Tw/lxIb7CoRLa6mDOlTr/5FqGO2LIylaKY0iM+F?=
 =?us-ascii?Q?7+HOu6FL+8K6AnKxfkvqMDnthYe4E2a9iNqAxL23+boaVNGJ+h46OQufRJaF?=
 =?us-ascii?Q?foLunGke3M4PqsDukNEfeStdrgfOvmNi+PhRJj6AHMr8OHNwH3cPwMVP5ICj?=
 =?us-ascii?Q?HAs4mHznGkRnzJkIVdoWoziB2Wet9F2CZRFNUOP+x0tN5bL87npTQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NANSaeOJ507gt7zw43ib/NPLeUYbG+gEMnwK05DLxNxVmVAK/9LKpqKml6fQ?=
 =?us-ascii?Q?1khpGP/742/LoHOinEyit2TDXNnMzChAdtRFJCA+tTs0muaLuYBUmwauSPRB?=
 =?us-ascii?Q?r24uWVSLjTX8Z9iJ+4Ir/OGyfFVVlA/tai9xYEGjp6IJeGuyRE3sOYbmByR8?=
 =?us-ascii?Q?rYEF8Dx8ApJyZ0y9rxNi2Jt/Moep7Hjyg/Vqe4mD/DiTSsz3FlqNUW1a5ag7?=
 =?us-ascii?Q?Yzgwh3l1tjfJtH4lQBVsEp5Ymhz3shQf8FpAgah+seRFJX7rzaGY8T1h5Mov?=
 =?us-ascii?Q?CfuWbO7RJeTYR/pvbCmXsx4JksmiFRqRqScFv16zw0oBzLhLfftWTYLMJAXz?=
 =?us-ascii?Q?vNPf9FGPAdkrg7+8ZnkDD0MdCXoQidjQ4TaMseQN+SszwlwXXPjtDvPnKykl?=
 =?us-ascii?Q?y++Cf+UDEfALmj8JISNEWAQ4UTwE7lBbakVXKsUpgZvqsAtsf9ycDmdR8mSx?=
 =?us-ascii?Q?KqxujkCp9MfTBlSMVVqlFYF2UrVYkAfPvsox/mzBXgRu0jdWJm6HFSeAzZoF?=
 =?us-ascii?Q?q5LL1QTX7JbrsHNj2NGZWMGD6jY1i/CqZy96dphQ3v4szXTiJF6j/4sHmtur?=
 =?us-ascii?Q?GvYTOcisSqOKNEOFKcBFb2YDTQ9zP+K2ihZYqJtRdaZkh23PtLEZ2r94Ltu2?=
 =?us-ascii?Q?8fEJCfH8oOvrW0dhiF9NyrV0E+TntFHtU0uipf9q777QCwOXCfUFbQoFAViB?=
 =?us-ascii?Q?L37GoT91AX/cbtNnSjsv8jVNtKRODqqnCyMha62hiZd0aoksNSm//A+yQhZ8?=
 =?us-ascii?Q?c0aCPhYnY5MCI6uFPnwuCaUjI7BkVACpUf0BSn7QavC6fm1iXq8yMxm7L7nC?=
 =?us-ascii?Q?xCfmCq6wMWxQMAj6Kmh413iF1n39GoI0jDp0WILo7++Kcc30kZULramI2vqt?=
 =?us-ascii?Q?SFpW+gGjiftqB3TGpJR7TpeSDRqGYlwcEayEiEpVrR5MToPUinKl1ByrfPmv?=
 =?us-ascii?Q?MoNWJmp9o5oRuHMff1VNCvJBKu8jpMscjRZuF0ib8WAwgTIN4InHVaIm3Sil?=
 =?us-ascii?Q?pntu9dCMxd2YpnueQI2ILxkNYnozcYBSzBi2BNaSAwktqjbO9uZMgV4cfYXc?=
 =?us-ascii?Q?uhJaF9pkpaTyduxSCrWQlTyRaurEovlXGl6/XbpiYL8mii5lREaRvAQfhqd0?=
 =?us-ascii?Q?ybj/NyCCQz77S/1oFXeRZk2QhzPEJfTlSCpUpy0FWjqAHiecHiT7sKMF+jLC?=
 =?us-ascii?Q?nsrDiniGpQpvlfGwkUQ4dmH76/hY9fhiYSJobJm9wrVwvub1a/pCl61eq5OE?=
 =?us-ascii?Q?6LVKqQHlRqi7s3jMO9PL1B5+1LeUaiXyzn2Ia4+GXAMXvfVj5plohpIjvqhy?=
 =?us-ascii?Q?Ou5SKtecaev2YCqmQYpZqarz1U+SJXt1d+4p0PPN4UVDl2sF440dGxRt0MTU?=
 =?us-ascii?Q?Hv4NnqVHVbNRJ/X81PNEzHYt8PRj8W6eMsy80RCPhBjHPt1pUt/hnDADxJtA?=
 =?us-ascii?Q?NUP484tjNhkvo1GnwZoKLmMoJqS/EqRB2nryq1G98D+xfqTUASJrj2jPqjWX?=
 =?us-ascii?Q?1EHIM+6MQePDCWWTtsJja2JTmKO0iZDJTRFFXzm6F2woSIWMj/zjUd5xMCyV?=
 =?us-ascii?Q?bEMQlHXR7rpkZHidHIHCEr0hjrU5Z7IKh6CT5+HN6Dy7ZJ60bPm9QzQ+J3AD?=
 =?us-ascii?Q?HA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e29a5e5-ea38-4b69-c934-08dd7b789c97
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 17:20:11.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TE8JCPHbgOFQa7C+3j/PaepdIcH5nmGo7BmQKjj21MFMwGLwF4pKc32Od0+8og5r6fRFj/pEFWAHMRG26J3/XFxVLtSqG7XP33p3kcAQw+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7897

Add support for host wakeup on interrupt.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Use interrupt instead of host-wakeup-gpios. (Rob Herring)
---
 .../bindings/net/bluetooth/nxp,88w8987-bt.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index d02e9dd847ef..e52ad8198900 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -48,6 +48,19 @@ properties:
     description:
       The GPIO number of the NXP chipset used for BT_WAKE_IN.
 
+  interrupts:
+    maxItems: 1
+    description:
+      Host wakeup by falling edge interrupt on this pin which is
+      connected to BT_WAKE_OUT pin of the NXP chipset.
+
+  interrupt-names:
+    maxItems: 1
+    items:
+      const: wakeup
+
+  wakeup-source: true
+
   nxp,wakeout-pin:
     $ref: /schemas/types.yaml#/definitions/uint8
     description:
@@ -61,6 +74,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     serial {
         bluetooth {
             compatible = "nxp,88w8987-bt";
@@ -70,5 +84,9 @@ examples:
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

