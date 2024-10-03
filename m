Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07C81A704D;
	Thu,  3 Oct 2024 15:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970262; cv=fail; b=JEfS3qcm2bhUGSemq8dkTDLpxsgGkiPBiqC8h0VM9PyA4+x6hnMN8kgmYBuNOmqRFJiItxh1fOXDBrQS5tB/JUNepZvha1wCitno3W0CBOh4gN8zZY5rxoVqhwyEwSkKPins600LKEqh0VeSrCBuyY48Bmsu8PvrFFLNaq4QTRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970262; c=relaxed/simple;
	bh=NtMaJac8mGAtyFIordmSzKmqfTiTgRZep0J+cDZej88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ensoAq1nlPHdVY6qWOFBT9pMsn5P/E7VBhk+TibyJ6qEOcOHzg8MCspMYlNVCxg2OEq3WnLDItcN3X0YFSiDJwpo2/kKSkjznhcUsraYrsuGRpfD8FZ7MNRhZ1fNBf0SjvAsFTkS2zcMOXn04w+vVkeGqAw4frBysZy0ye+EdRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ej3eU2sQ; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ej3eU2sQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy3CZfZYbtOlG3VFljbfHdEAVwV/VXdWJMrDRJf3EBFMw5szgSkSPusLwDNszVsdsyYoZZjJy59QXm22HeYS8xYkclRrsYRYgHwRZ5F9QnTpdh2P54OlEI1yJ0JBJ5ljiRBCXnF6NLQPG56LpeOUb89GS7QAff6aRWc28i8vsUdNCRQwtySZzY7cEtiDom3Z24/UI1BxPMKh7nKqeK5SRUqc7B4Dr44LkrWJYeaJqLZ+dx+4BnK47Qf3k5BH3Gkg+TT7sHc3Mer7QyF3TuC+9gd8u8w29DZdshFUZ5kWTdBOzgT+jehLKPE07IShYgrJ1dcf431UeLq80Ej+n58Sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubrrvonXEWsXc6UW6BKfM3J76YREE4wFkYi0VaB+6Co=;
 b=N3sK7+BFd7aX4Nuv3pSSKScGBEOrJKuDh7SsbhWUB+PweMl5YgzN/gH3Gj2qpCs+DxWeakKhOBIseSex5AMpVbGnV+5/FHUpofApGLcl4fm5/5TiQ1mDPRoo2Y9YBDfHfFrnnsxi4ABMd05uNugNQMKko0nHJFX6e/cfj4vOu4UqKK5C5P6B9FQlNxPgUaGr0nRsnjk3LG58bTWhphosluOQjO+p8zwwedisYnno+kWcELsLGWdE94nT6W/De7p6d2g3ZP6FW4AMknox3zgPPuNdLXVtm1TDVneHHkC2NnGiL13q8b7dzIL9MDrBYtJaN/jNlUyrCoVqo0UaEBPDvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubrrvonXEWsXc6UW6BKfM3J76YREE4wFkYi0VaB+6Co=;
 b=ej3eU2sQc0Wq1sEEohb8vSarNRMJFo/N0Q0XbwNl/ybu7axonvtuQcG+6ctoqJNfi1e0HiIhTxPg00Vv2LlRojhJssEzW0JDoyqrTXJPzqjPy2o9h4RZjZf6nFpIwKJNas4jy0ByjNQq7c+w4n+M4I+Xotd2GRLTWFwP2uwDfHXXqfefCKQ7g5yID5pbphsRzXRhnlIr7sYxAZppmYWPydTttL5AHzN9IWavvuJHUaSqxTiTGCI/l5pIIzfOUjMFmAf7Sp3stND6eAYWc0R7v0kBxxCdAnb0gkmbjOzZW/l2Xh5qM4BD6tjnrgWlY6J2rVPU1S5TH15J3zjk52uTcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS1PR04MB9558.eurprd04.prod.outlook.com (2603:10a6:20b:482::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Thu, 3 Oct
 2024 15:44:15 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 15:44:15 +0000
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
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add support for power save feature using GPIO
Date: Thu,  3 Oct 2024 21:15:06 +0530
Message-Id: <20241003154507.537363-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003154507.537363-1-neeraj.sanjaykale@nxp.com>
References: <20241003154507.537363-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0014.eurprd03.prod.outlook.com
 (2603:10a6:208:14::27) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AS1PR04MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: ace76344-280a-4b8b-4c1d-08dce3c23c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LfFtvnzmetFwuFGacr2EFzgEX+yo5FcAWI9E6fcRjb4aZ3GJdZGAJFptwwAb?=
 =?us-ascii?Q?lgLFoOKufbFf1gbUMwxG7HQZB5jC9nSmR9gsov2+OHCvXmK6vT9PQQ8+YD0A?=
 =?us-ascii?Q?2MA6Vyo7G8d9gTmLdllJfm2e+dkAcmjZv87fXip++yE3Cw+LgM5l/sJwZjoy?=
 =?us-ascii?Q?kqS5agb+xyDzJJrDNZnFqEQ2r0yRxRA4VTACo3dkbv+vxb7FiU+I0Oyb1+rJ?=
 =?us-ascii?Q?45sUzmFY3lI5zrLVpD9iZyZX7+iSBVJoYRea9tZBgUcFOaBkAclaASVtpOEY?=
 =?us-ascii?Q?ZoOGJm8hMAgHWIDgSRl7E63YXdnFAnPgCN6uH+8y5J0GHaQCd5Ic0NOhtwHE?=
 =?us-ascii?Q?dONA+JC2Fvlstoq7oucx1y0D1NkubrAzOzoaz9bfMuP7I8vlOJf9/by0gziR?=
 =?us-ascii?Q?Th5N+wcaJhNjWmlveKrpd5RWci2h0s1jFul/0XABdayfR2GhVkNM6Z8r+4IH?=
 =?us-ascii?Q?WtEKSUC0QCbuROAJA5KLeNfIXc8WyS+d82bKTY4rCpqYLArgdLV/PB7ycN7f?=
 =?us-ascii?Q?yuE4VMekHSkBj52l95jHZSu9WgcalYM/IahqP3YoKMiCHxSjS/K+DV0RMLNP?=
 =?us-ascii?Q?7frzElcmdMOU/+jxYvy4H3946hni/GWvhIU3Zf70YUwadI4Aj+2bg6bKXK9C?=
 =?us-ascii?Q?1VCiB+FTUecF5OXtNhzCBNvLofnXdBNZETggzSyRc4oAqZEHuHmGppsiMdEk?=
 =?us-ascii?Q?VZVsdnO5mqtOusAY5uqGE2fM+db7Ra8unRSW+tkDSoi8c9dNP/cRGzkRscde?=
 =?us-ascii?Q?LySNah8paFiptfAP/d8ZK5x9R5CR8raiqKKOpn5v9HnlBvOuUx8CsN87C4yK?=
 =?us-ascii?Q?MROV7fvpjmPaTEW6KtnM4wktZXNCpRCjN/5SoWqd7+D9DAamc8iaZxodGB2e?=
 =?us-ascii?Q?7gxcxHepjGuQEU8LD8S1gPBLFMHIaHGpFpvSL9GYMlX+5OqxA+ZAbDf5bMoG?=
 =?us-ascii?Q?VJAeRX0EQoLw9t1oLRWBG9rzkhK8e3WDBXB5sgR23UFQcYu3IcISl/8vBOEk?=
 =?us-ascii?Q?QwzpoC5g6Hv5mme0RdDhyAKf6R7wW2oGOZTW1CLH4ZaW5pePA0wjqqwOt1Ih?=
 =?us-ascii?Q?KuiRct+xraPisxSryB16UrCBSWlYRbGTMfhpvaDZ6sejZudDn6z1RBvuY2uU?=
 =?us-ascii?Q?bSQcMOodvGLedVz/QTR7OkCfhEBJovxjwy1hFizeC3dnhcRXXhlkGjuinV6t?=
 =?us-ascii?Q?weCYl10Lbz2a9r+DAX4HfTPZviENJvAc3khDimmRcu2kDxCGJT1J/h9rdeHO?=
 =?us-ascii?Q?+zcTyXDHXPLKEwHA+so8oS4ZUmEVqqQ+oPvdP37OGVe3x7xRqb1HgzGXXBVt?=
 =?us-ascii?Q?MzYHzF1Jt/eWi2iF0w8Z9PZ55Q+2uDvgsPqG6bQ6DZyOqg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jlEoNYryLHPqE1DNg3TGRgau8+0CqjW+DsM3rAzcEY+t48KNF36vHMTrCv97?=
 =?us-ascii?Q?eMnxeuRheNEWIGtj3xHeuI8kWad3zEe4roiIq3/wob19vZGauIL6RnWQTlWQ?=
 =?us-ascii?Q?MYxIYN9f1/LgbtvS3XqNmupttuEwpe/yp2dhwGsxqXlslWXwzhE+uPMnku6y?=
 =?us-ascii?Q?+P09FOB2sZYq6LfkxnxgBRDGsuDJfyHdu+sxhwNN8eG7hCwSro/WR1fbxoEf?=
 =?us-ascii?Q?hyuVircrmLw6yeJWb1RHmVsNQvlpQjdb0leTi9iZ23fHu8HrTJjG7Ruj2Fs5?=
 =?us-ascii?Q?2rPJCq4VjCoBj6Z7n62P7LuYW0+CSA9Zuj/n4IwbwXKwl2DUwkE3VLpTRQ2D?=
 =?us-ascii?Q?d3EeU/TvBhW02l1dQlJy7ZxZ6aK2DaMbjnRRCkGKlN1C9PT+gv2iAZhsG0WF?=
 =?us-ascii?Q?c3b8ehTN54F3LVQlxnIXwF6uywxd05zSWrW8zCofodB3sY1BBcF01w1ovVGa?=
 =?us-ascii?Q?PwR/UAwLEeSLp4+LL92JvAco9MqQUVLBUdz6yVRZyqbsUmput5SRp79VMkFz?=
 =?us-ascii?Q?L9TWAqxMMOU/C3CwpDnYnJ4YVp7gazpkKSf9SUJvO5+flBqlMrM7IUWn0JrL?=
 =?us-ascii?Q?wplkeoRNRb2+HnIyhSycVLm/4QESnl1hrAVDyWxMHJMiln0T4fl0ddNAwioa?=
 =?us-ascii?Q?fO6c1iDrVKIkXgOxaWPS/FivKtEgd3oPpx0P4L/7yFinBUld0lP/x4fpzt/a?=
 =?us-ascii?Q?0n/DuqCGwCS7OZa1Cu73qRPLEDbcsr9cqUN4R0GvZTQYJS/M10JZzwr5wbLf?=
 =?us-ascii?Q?JoBg5ySQaK4D8eBk68MGvKam2j0n6bpnWPSdiTk3+eiS97pAEWRoxkJbnLnj?=
 =?us-ascii?Q?Qrs5JZGr5Sm+F7tR+g6N2Jk/Ps4PM608cTms+pog/pRpPfkpXNOuCxycbddN?=
 =?us-ascii?Q?rp7Fjqv9+y2y4/f3lcClIlf5qmrF2JU7mD/VGji00llRL/uaWm0DSU4Ovrr+?=
 =?us-ascii?Q?ERYUu0n0I1r5UoDhRaiJgAdUziusxm21CX2RvsLrh5ipBdmc5uDXuymZmIHy?=
 =?us-ascii?Q?gJ6E4SBIsUe+gbFXI14NZyPInur9rooDE/jTQ31fYRAAa6IlZ7QR69n2HOH8?=
 =?us-ascii?Q?7G3V6HjWgdjZyo9gUPh+gV3kESMKEuKbI9vHoirwHjAWPKDTJ1LWkIPxrazm?=
 =?us-ascii?Q?7tMWeI3qUiULPJhAjbOC4LL8gVHeGedJlBU691PwNlLifAFEGM+cU8oH10Kr?=
 =?us-ascii?Q?KBUGC8PYEXNw1/y65Hz/fit4uLAMOA3h46vP3TPFQtclsU4+W92D3BmuOJfu?=
 =?us-ascii?Q?40P3Owee/X3LWEsic8HJkDsBU38AfIJKSL1g0bJDBpNHcjWhDEoR8JBdbqka?=
 =?us-ascii?Q?6gwHvkyDbIGcXaXcbQJkUMzkupQHsBVRKpYF4DBp7uPhjRgWD4TnitICKYie?=
 =?us-ascii?Q?UdmH803ZmZNDsoRRSe21cuNxoyZSn6zz9jk1pyPPMdJKBwMymigNyabKJ19d?=
 =?us-ascii?Q?TP/shGPXPwEGKq6hWgysTd+h6rOh4RLCkYcAU0BqLEkRV8S7VpiZIGDC5aP2?=
 =?us-ascii?Q?neCbttCxwshMKiSZ2ssEXdZ6iL2iuyQkm8cbPVZX3Cv8RF1csCnK4+YMq9cO?=
 =?us-ascii?Q?7MFjQ+hnOJYrKkPjVg4/XJC3bbqZyFvSZKAGw/FvOtIwMH8yotmo9NpcVT6t?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ace76344-280a-4b8b-4c1d-08dce3c23c5e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:44:15.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPCRnxbZcr9IYKaWq+Ac2RN1OeXzn4YkDxT/4GZFwtd4nKNRMxaA34OezHUUzLXJXq0+aEpvGC8pEEKwRAhfY7MUJcbNaTizbn9jlZ27tkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9558

This adds a new optional device tree property h2c-ps-gpios, which specifies
the GPIO connected to BT_WAKE_IN pin of the NXP chipset.

If this property is defined, the driver will use this GPIO for driving chip
into sleep/wakeup state, else use the UART break signal by default.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Rephrase description and use "-gpios". (Krzysztof, Rob)
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 37a65badb448..cd8236eb31de 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -34,6 +34,12 @@ properties:
   firmware-name:
     maxItems: 1
 
+  h2c-ps-gpios:
+    maxItems: 1
+    description:
+      Host-To-Chip power save mechanism is driven by this GPIO
+      connected to BT_WAKE_IN pin of the NXP chipset.
+
 required:
   - compatible
 
@@ -41,10 +47,12 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     serial {
         bluetooth {
             compatible = "nxp,88w8987-bt";
             fw-init-baudrate = <3000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
+            h2c-ps-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
         };
     };
-- 
2.25.1

