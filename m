Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013017.outbound.protection.outlook.com [40.107.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC00D2EFDA4;
	Wed, 18 Jun 2025 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750261155; cv=fail; b=CKi7/qQ7aZ31sxhgjCB16KFJ4IWmu01n9WVuVDs2Fxb4O4REplj9ZD5W6U7rkjXmowyqW2wYS+NqBPd3lfBNpaD/FsnZGpLvo+HCB5tT8j1mk/+LNzvCIw0tI2U8R1T+YhjRM/lx38YSsNvRcHgG/F/RB1sKib2vhHOoxxH3BPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750261155; c=relaxed/simple;
	bh=UgUr1GgId8vtwwTIxZeoY2GpaA6kL+Eg4Yh3We4aRXE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=N5kYXAOH4ucMoO1QuF5iwIFb+an7/YGBOvP6zcIk89lCjZhdoZBbYWyeg22i73C2syA4lb21n4YTpLadWUDFVoIu7lY6lPIIPRHkS/FBMhfaFxaBIoQeIWvY+ASYHvA1Bsj1BC52It0HZbEr+0HH8sWtB1iUa/JdLYxcoXCoKp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H0Knvsl5; arc=fail smtp.client-ip=40.107.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H0Knvsl5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNUtG1WURuSbjP1Z2igd/EQKhrnLOaEAFn7JdcG3aTXsxLZysX3QqIEXu2TmvCFVpuEs+0WhQ6d5If6/ReTQTGkkeh3TP+mcRvtShvxkLbbDpcpDRmj+KQz3P6YNIOTJMbAiqVm0ZLAOVZtlAoZQAqeKdgKzRxpT96yg9kEPKsuSy13MMArOkc5iOgeHfB1YTR8doiLY03ubAAcBOIbMweGb+cQ3PTR4l3EtZMI4sRcHFaZOU9QYN4GYUIxeTgZMnYbZ0+v/jHwOMzZd1TYNiWlF1BVCum6QKpQjeK6UXmOjZc4MHrA0HBJXrmjxWudv2nxPPkCB2tuxbgHBBKxKAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ji673MPRmZfeD0mls1C7qPX/sxfuqNWtWg0XEqhEAOo=;
 b=XKVfIwvpv5dVMcxPXOeOg5V8ydCwnkm/7SpzrJ8rN0UGlsYHjGNGEom+XPNMSaOo1YG2Lk8btu+kGO81EXwrAaK3ceCq5kTIRcw5SUvjJPZxVpn4vp9+5pE6FiSxeIZUPrqLeeL6dhFlLP5QaRFumPeD35rJLL1gRFQPN5p/baKLdbj+Orycup0I2X9BAtNytMWw9+KiARaW/NjS77Br5bdA/2ncqXFVzRskUOu/x/DSJ55xKvM9NSGxv52/4Z1QUkBOVqu207GTEUKA1gldAqaRHmgWnKI0KSm1IIZnxXFJZib0HhZHMaQcUJaMfGS6L/Xgz1DUf2HBH0vNNOAdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ji673MPRmZfeD0mls1C7qPX/sxfuqNWtWg0XEqhEAOo=;
 b=H0Knvsl5QLJzfOpOB2ze6mdgnD65Zx4OFXvc2OmkGwbJ+MvQKgoeLHneijuvLb513OeBtjRUUgEsvhM7NS2oGJ7NwPTUEgeIRLYhEGhWtvrV8ZlbGgzmqIx4d6oOrr9eJF64m53tYQ4J1aLD602Fvyl/bvAOzjVv2GO1YhchVjCgBompWK1OvAfUbluf31jtyhr0dE6ODT2JeXQEbm2/l4+8zS7T2mQyuSnQqg1Yp7UPocJMw04rfGgcPj9uUsXUEnQHZ9BBNF0o1d8A49j7EtSzZuR1Yc525BVDWcufLDSn/jfiZrYNUGy/YH4JaGsJZktoSeg8f/PBdckf7t9VXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GV1PR04MB10775.eurprd04.prod.outlook.com (2603:10a6:150:213::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 15:39:10 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 15:39:09 +0000
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
Subject: [PATCH v3 1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
Date: Wed, 18 Jun 2025 20:51:12 +0530
Message-Id: <20250618152113.25500-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0003.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::13) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|GV1PR04MB10775:EE_
X-MS-Office365-Filtering-Correlation-Id: 018da3a3-368a-4e33-4486-08ddae7e4424
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0AoiyxVsOMWLBohibuglsKXNEQ7sCvCf1G/nqp0gNuzItxhEIfF3YMIX6zW7?=
 =?us-ascii?Q?4xrJ3voPwWwq6YfnVYwWNQRYloZQSkbeMVlHQDvBtljYc8MzKTt2DjTPEU2j?=
 =?us-ascii?Q?l8NP0TS+lrM25ZCX3d0bLiRMCuregteoqHROJK666dUlJvf/0mZl+Ah/4mi2?=
 =?us-ascii?Q?y+kqGXYs1JP7AjzdlIZN5HDfzwQtsMjlbTJwPpmPWbA2nd11OiZ/w0ZII04k?=
 =?us-ascii?Q?+ZKO0Y+ga1Z8UOMLbKaSyCDA9s4Wl7f0794LahMQ+m5PvZ+W7M+pQB3SFjhg?=
 =?us-ascii?Q?khuxX+QtaxiCJz+zeQZxsVNJMNyY8r2NgpTDJu4RrHR2Zh+BjmFc/ls++VLS?=
 =?us-ascii?Q?9+6pJJl62BAPhB9IxCIwCjjPtwzsdKSpVov+swmstrl7WS0XfwJ9IjzDkVBD?=
 =?us-ascii?Q?pKqHMTBwo9lMBQM88tgXR7VpHVEKmfJE4RIYbNE60fypSkCEFqdI2NVPOh2p?=
 =?us-ascii?Q?kKvx00Gb/iRAL2bO6ASLOifvUZFGM6KXp+1mD9slhnxaSyqqx+1WytTwoGuX?=
 =?us-ascii?Q?91TsM3Sb6w042VcYZTrI7M3qL3jbPu/Hq3bTIAEipDY1G+OZ2J/RnC57DMGU?=
 =?us-ascii?Q?sMJyvH109/H9sURCPn8r/mybmu8pFi8CwR+MvYqwFd2+qgk6X98zy8ZNJeng?=
 =?us-ascii?Q?uQqmNzxIhB3eBrOS0RE9JioJTYm73IPjGRdsfN/OaUZ7jf16NrGoTF4eXGQ+?=
 =?us-ascii?Q?n5mz6XeYFDCuL0RECPgRDopsW1d3Z+ZqA6ZZ5IvYvDrmbUzMXCz35bjPQXNu?=
 =?us-ascii?Q?KuES0mJ0DmXxpxTh8cMBIhBLd7FjUkp8L3JggklxpJoii6CCP3l/Gm5qu3d7?=
 =?us-ascii?Q?ecRpOIWYJyZS7cJNab8XiakL4uzpAbmPs5zz3/lBYurFoyn9gt6b/N1bNXEC?=
 =?us-ascii?Q?jorxE5g4mYp+KWZCNw6MVY/09qO57+ilarKLTFnTHl+MZQ83vXWD2jAZRXNJ?=
 =?us-ascii?Q?mNZrUwkl4hFzb/wksfRyMwDnDVBW7LgHKKRyFgoeoKVEBnR/Vb2JT6lj+uYg?=
 =?us-ascii?Q?Q/QVVmozmRj40vIBwe/D4jxJKWbc1dp6xbTXoHFi+Uqz3lVovNUZoJvco3eb?=
 =?us-ascii?Q?m2NFJgH4Ny2qoWQBU0MlLdtOuUOxe0QNTw0hiGuPmZgiEg2UdR3jq/ZWfUNQ?=
 =?us-ascii?Q?liPEPi44PlplL9HTVSqhxXOXDMFK1ShsBO3IJWp5D6OB+GuyglL4pRCtdGYa?=
 =?us-ascii?Q?uGuonTp0RX6B0Tovwu1I0YwFN+6UkY0ursd0f7dJdym3UZyJosHJrM9/mFpw?=
 =?us-ascii?Q?HcxMrtLCyBS2t5lJTcXeAi67GmT/ZhnjnG4mXmv8LQcAMXivM788jRCEv0vZ?=
 =?us-ascii?Q?OOD7z1SLMPS62iX3ia++FSorjWsVBNSK2jzx5voOmex5EOMHufIVAxb4UQGg?=
 =?us-ascii?Q?Piy6z+NdDKevH1vuZ+dU6EAflurhqf3fdm0J/dfhZCQyHWfSVCKkjd1Kg5b9?=
 =?us-ascii?Q?w7HBX4+D7ImIj20fy0ZV+v/BaMbrLTyHpGywVgzMbvy1r7FNo7WxTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QbztW7ubm2wVIQ26UlcAxmVfWeFpZ7wBG1f+EgUfcKs7vI1WLUo0//CYAGyR?=
 =?us-ascii?Q?wlNxllcbQTIuecC1eBBjZ/cyMnuBd9x5Afb98JDMoKff3yhWM8CDJL71kXCp?=
 =?us-ascii?Q?C1MF3dpHWgkzepORpvPe5K19aZ0dvo3+GmASojpzvne04E+HFjZfgWb5l1Ee?=
 =?us-ascii?Q?aHxhsKD3sYPOp5x1puOi9ITV3gbSeAbcBDq6osMdIKvpkf0AM35PrDxKkIX0?=
 =?us-ascii?Q?dD5E5tSSRWBYdOb78y/zV7yJ2uB6dvTkAL+tssNQXNslKr5T8hc76qKpOlMw?=
 =?us-ascii?Q?VG7Xuc2rUss96EXlXkGwTy8e/KHncJEHJ3GALgtJFMupRykydMyQF1SnnboQ?=
 =?us-ascii?Q?8cWzZYjdO1qURM9aDVlloUf0nFOolk89Dy2NV08rauyNEqlP1uPwaydT8ZCm?=
 =?us-ascii?Q?pXHYOIhJEDDgPdgq2smGiBxUErhc4f6niagKvtjCLO0+Pr5198ednrDkrPwm?=
 =?us-ascii?Q?yfdGSfEKB33i7Vp6D7F4nzKi8nOWFHjTZmomaxJ143Z4DphRG0bTumhZM6ho?=
 =?us-ascii?Q?Ae1M7l8RPrIyVC2zwXB7vh66sMto/CYDlQhpZALyU6/ZtCtGi7m32pX5RTvu?=
 =?us-ascii?Q?Ciz1sXez13fkj9NEiyRDe5aYVb2JSDOTfHfzBYc16FcHJH21THRccbdCO+ps?=
 =?us-ascii?Q?EtkBHeKsnMJx4wtegjKFx7wRK3xh/Y25wtJmztlk5uy9JD1sxK5pUC0lDfy7?=
 =?us-ascii?Q?u3XHQhghSS/yUlYq6mHqvRNmZ+H47tAdxyEJvxYpTUC1WlQmfg77e0t0QgSn?=
 =?us-ascii?Q?xugkwHohIOYtisqZM6HfbuPaUdujZZm/mj2tMnjtsugZNL5O3wsICmsIyY/M?=
 =?us-ascii?Q?WSLst61VBOcK+HWUWbBRcuVbp3OIfCxIW+TqOhYcOEdq4mXXl+mvi3h5rwg5?=
 =?us-ascii?Q?rbo1Q/taIPJBYCOnosl3q3zJlRVfaz0g8Sy0/L9sOwzR+dxp4zAdg5jz6XTb?=
 =?us-ascii?Q?zxPsWygAp28Prx66oskdeYDf3zdw6Y5jbOrCVJnC54SIuZvXistgDnI1hhFl?=
 =?us-ascii?Q?RqNIG2RfYG98PiUdmQR/wWCxAy3IHZMKo6wkDyxuRhZQz38AJsKrjncU0KT+?=
 =?us-ascii?Q?85FyyZmVPTIsQ2bFYRBilCfCXYs8HhkmI4VG1PKPJGUaua02/bWauQcODu6f?=
 =?us-ascii?Q?xpx77hEk3RPa8fbbqIb7Ff7faWwpO1z8UtJRSjocVus+T7SCDYGbnvMb6yfx?=
 =?us-ascii?Q?FYJzwZbGOG+keQ8JCU3bfMvVVl+kp88FDUVlrKyYMndCZOIstFkYID4dUs+d?=
 =?us-ascii?Q?e0OcagH7d5vBpiIQBE1Gwp/AaiNBjFLVFrxW68Ts+sy7QpmiaX30jAbum98x?=
 =?us-ascii?Q?AQqUftpwnQypnvRqCOGIV4nvEPrl6dJfIULmI76+uEDrN7LyZkb9YoJXRToP?=
 =?us-ascii?Q?P32PiYof8Sq0ao/JOvyIyPjhMErl9+aWY/SxhdYttJ8MfahBC8obJdpD9Qqo?=
 =?us-ascii?Q?5Iu/16zDotyy2smkwjy9Ck/u69Y7/NrtWyKCdDgay/JnPRDF+bJwUwk03BwN?=
 =?us-ascii?Q?0NImfhBYYBqBjEr1GJxrmrJYuQHsUvC+gb8nfhxMYdOSmjkghfTpPGYoQpPe?=
 =?us-ascii?Q?EWoAk8Jappv62J4yQ3cpcsX6if4WfWcvIsyOR4dC+5lGDSj4bhbg5VMrKhfQ?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018da3a3-368a-4e33-4486-08ddae7e4424
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 15:39:09.3726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ei5AOPxv7ucBIT4pE97DcvYCPc7oExThl1I9CTBvkGdhyNUpRBYxkhhWpo3CVEaWLBR8edoSuWgpQptolrULDxMQg/clBa7pPkBbgtxQ+Sk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10775

Add support for 4000000 as secondary baudrate.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Use the available 'max-speed' device tree property. (Krzysztof)
v3: No Change
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 3ab60c70286f..4a1b6ea48a2f 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -34,6 +34,12 @@ properties:
       This property depends on the module vendor's
       configuration.
 
+  max-speed:
+    enum:
+      - 3000000
+      - 4000000
+    default: 3000000
+
   firmware-name:
     maxItems: 1
 
@@ -78,6 +84,7 @@ examples:
         bluetooth {
             compatible = "nxp,88w8987-bt";
             fw-init-baudrate = <3000000>;
+            max-speed = <4000000>;
             firmware-name = "uartuart8987_bt_v0.bin";
             device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
             nxp,wakein-pin = /bits/ 8 <18>;
-- 
2.34.1

