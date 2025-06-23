Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011052.outbound.protection.outlook.com [40.107.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627D1FBEBD;
	Mon, 23 Jun 2025 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671087; cv=fail; b=orRG1vEsS6N1CB8tFMTRgjYl5Ca7ckhyBvmpW9FPBdirP1f5MREMaJPaUI4km0OTM9APdgs7Y8e0fx8seS5NgewNVWILRyLcwhizIiaSUpk/1VZGIRQqo/5TpQBS9198IfSekomzLLkAwHb6z9fTuoweMRT3Y4NTQpw3xjgY9As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671087; c=relaxed/simple;
	bh=M6mj1w1sNiRSmIjBePEiFdkvUBchvnkTXdN+Z4+/1SQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=nUwyMEleD9F6CjUeSTKuZxkGp9HVCVDqaDQaOVMa+ZUOwT4eEqc1Yi+adzfbHz/n2sHskCO6FLMwFtvxSOgmpN4pnGJqXbGwZNKReFOgs7XV2EeywYKI4h6yV7wa32DkEb1WLirFcBfpIfx3baeLuIvekjdk5Mhfjda9eZ/PB0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DcosKgbv; arc=fail smtp.client-ip=40.107.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DcosKgbv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vszXMMOP/fojX5Qc7Wt4JGP2F0J0B+amLevVj5BeGnHmEGHZ6DEDWXW4I0cdYo8yxH6YrBxwqAewxnKOYwpEdsWCKINs6+c5I4Am1b5+OVl19O2/cX6GvbuJTagEfhblNksj9bkEi63ZQEE2GWDHTksUll0PcUBeVbBqD2Jdvk5CFzQXe7KNZQzuEilI1YUbnBwPmX+5Yj3Jnh+hLwm8eTeEknK7JndX0asaYHR+2SW/yXMX1cmguvKxt9FU5hWON00qRaHe3T2wvMc7dE/jS4PP9H0U6Y5oda43Arx1CE36wHMt8vMPZlaBHLtHWrrfTlP9Yv82JBoo9SarnojQXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uTRW7UE1ZnMFbGUAJx1SFg/BQZUyOh8kJc82T7dpcwY=;
 b=M19I6aJ3X3PcjuKW/DPgY0uOOQtDO1WYf5wt0DMkQ2AfeLZvCq7TFRzrmrI5ZQlbgl65mSsfFn5Z9c1dSy/yk3qrKlC7UH61loxr2PbjTlyuXIgmnSdgjEwN+Vd/xKeK/JW9dwWp4z6mVNy9Jsi1bEcup1s0X4GrUiIn1dvSB0Otnk4q9TnOXaGgpzINPKBHi+h2bJ9x8mEMVjqLRJJ2f3SNT5fkxQfTrEBRmKAjNy7KZP1rkZiM/2yFFEAgK4ryl3xbCgtvvQbm2OzR45bmIJYq0QeEb3i2KKDAOmUqrk04Sk04xDBgwVQiRu7BTF9sbmza6e40phNwnNveC7YiZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTRW7UE1ZnMFbGUAJx1SFg/BQZUyOh8kJc82T7dpcwY=;
 b=DcosKgbv5PKotxODpM4ox+jg4rM+4ovuMchzAg/Dkp73ydSamh8lx1Voo70g1Bkz+AoAvcSxaSN22Kk87PEK44rjanw1LQYycB5ZcOIj7qQPHWani6e+nH+z+heSoSCgbJ4UOdvGkVS26XgvsUfksoH7aMTQDrnpzEqnfIbxXArsERCmMXrjcGuwIf80IbdXBoyq05p0xMO/OwyzZcjF8XaIbw2ptIQ+JljA0NPUTiAK7X+2/Ks4uyaPAIS5iTydWfnrv0n2Om5ybD1TJTBnmQU+3weWOcEiPw6QDFstqnpHiIqDXxegMlEgfv5pysH/4ZzjxW8+zTPDkL1imT5MyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by OSKPR04MB11438.eurprd04.prod.outlook.com (2603:10a6:e10:9d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 09:31:21 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8857.025; Mon, 23 Jun 2025
 09:31:21 +0000
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
Subject: [PATCH v6 1/2] dt-bindings: net: bluetooth: nxp: Add support for 4M baudrate
Date: Mon, 23 Jun 2025 14:43:21 +0530
Message-Id: <20250623091322.131502-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|OSKPR04MB11438:EE_
X-MS-Office365-Filtering-Correlation-Id: a2520f41-32bb-42bc-4f3d-08ddb238b701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AGPa4SoWtUFcJfelLcvLK+A7kNS/io2J/cClvzVWscnN0Sko8+ModqSdi7hH?=
 =?us-ascii?Q?ovWeuTTWze5Gj2h/8RpnN5PX/VQk731Hmx3rCP3iAjULtM840dTArYfCRNvW?=
 =?us-ascii?Q?b5FaYtwZmyVhY2EZ6+OE/JaSB3FUeUKWDFdHVSKDPYE8WG8Yg821noXgFDe/?=
 =?us-ascii?Q?T7I3nEPw5Otcwf7ocXpc6t1ru0SwfQMoXydYb5SCMLGzQkO4BDSvkr2na9QX?=
 =?us-ascii?Q?PQ1zpEiNLpaAMGWqOEgbmWX/YG29TVj7QrIx/60pYcKDcbL5LIHP/C8PF64p?=
 =?us-ascii?Q?1ZshTtcxY8GAlIhLHACkrC6+EYZBy28fGpbg6EZTMJtzFS2Pi1sJqjrbFo8B?=
 =?us-ascii?Q?t1zzpWM9BaezPpphMXCxIzRWfb7Hd/1vVtVHtrDCcG0OoKpKFb56TG5temqr?=
 =?us-ascii?Q?+ihI70+JSyDrxuuSrRJmxiIeHa+4GtZqKeddbuIKhnMDy9SYA1MRursJOLIQ?=
 =?us-ascii?Q?OM7TUX2QHdt2XBPyhw1un0baai86bQrZhHyR1Oy+8W6UMIl12YY+Mxp0VPNB?=
 =?us-ascii?Q?DsgbSaB8f46eT/5RZ/GcZLi7YrWGFpBjlFMMDL8KlnODEZquj3jimRyw6FSk?=
 =?us-ascii?Q?9NKhWKN31xq3aeIgEF0WY8S43KtMKMg6SoLgrmB48C5q27iSWgM5wlXQh3Tg?=
 =?us-ascii?Q?mkGQlLMm24UqCDxxNGfKMMhxMPLJF5DSV4eXa1+APAPHtA6X9sqhaboPb3u9?=
 =?us-ascii?Q?Ujy9rld0AbaczyTa9rTaYTbrJ9CsjgzQRPNIksU991gTV9OYwHIcP/w+iFPY?=
 =?us-ascii?Q?k5KNNPO8E0hRXvVRk2StA8nFVK/dXolhgaReVBeKtCLSA6FVvoIzzzHHQ0jP?=
 =?us-ascii?Q?xPB2kIiqVLGP29+ouVl+fBrH3IOSZvwppFZ5nnVxsfKUcSfKEugxkjnYCTR2?=
 =?us-ascii?Q?sVc0BYDfEmXZnbNPske9xLPc8mS0dIZc076GanYGIwtEcztnWpr8UKivREtQ?=
 =?us-ascii?Q?Y5d829Z5DztjBCK1DXa5jzNlMAOVodcjzP7N+KIXX2a176OmsxYsiSkPCevm?=
 =?us-ascii?Q?yKDUk9DS5Ll2lcXEjnI8H8WOK/Q6MyBED/9O/j8pn5dqkgYDLhxfxzS0VUUI?=
 =?us-ascii?Q?/Ers+37YLAm4/YKIEBc9wYDHJL80Q1rIDg+kHVWjSw+INj/0oWvuW9fQQDpL?=
 =?us-ascii?Q?kpVviJXuKo1ZD5NAZDUKVlKaFQYQeWuP7V/W0ZM1dmuO9j19FBIf/4+MDih7?=
 =?us-ascii?Q?T/LDeoUCKlQeVsmqjw6zNcNEDqOv67dEGJ91e6GhH6BjbCxSH9XwPpJzfbGh?=
 =?us-ascii?Q?RpImNCEjPal65+YgSOy0TzXLuwpKNCzSsV0s3DNN/KuMgNRKkttcI9TLVehp?=
 =?us-ascii?Q?pIN23HYft/m8bYdcJ7iCa4p1YgG5B7Pljqk2SPdwOM3mh7Pc/CsAk6L+0SGH?=
 =?us-ascii?Q?viElx8xEFyMlXgJDomukAJzxHtbCpisOb1wo1mJ0XSo0L4R3Hq/9Hi5e4TS9?=
 =?us-ascii?Q?USzLVfZHClguOcP8bybprOgqbmuTUdWhY79irJwIKuYLl02EorEgVw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ONLWqdqYUcUoS8mVHSsYsTpE2SiC+Qfp+mBeK/Vdu1b8dPPcLDXwUpmeEQBf?=
 =?us-ascii?Q?+q+10+fsNGKfK3msuZmuSxv+YV5iWt1IXGvj0f9TbeS6LNZnjOpskRdw5Kuf?=
 =?us-ascii?Q?x5ZLwyiNuAyCPxl15/S5CXeiJ9yFgwwmEGmhT2E6utzVUIGnFskeckd97Rjv?=
 =?us-ascii?Q?VUpC3ysNVS2cKgEcOzDyJrdtxltpBlx51dT2XGotBF8K35i4Q0nLH+39Bgyd?=
 =?us-ascii?Q?NLzQLhfnduYB0Qq42rDnb59Ps7gITalso3MCycaRcijgMwED5fzxJckCUHIG?=
 =?us-ascii?Q?b/OQSm+GpBrNJZyG8A0Qb+jqbQE6z/qu+HGcDQlp5Dn9fS67KqbRYHwvexGA?=
 =?us-ascii?Q?4WWmDH3SZTrZFAUsQ+jnQWp8LXnZUWeD6IFtrBXTfz6YuNWGdHVtOnSwf9R0?=
 =?us-ascii?Q?A1LYAamTZ6veD2HEy9bbJ76z/BQVFAyfYdMGtWzh+0TNl7BPXfBDERcui1NZ?=
 =?us-ascii?Q?ZhaAgS4pzdV0xR4Rq0lNSgivUNOPOldeFc3+Fd08Sk5u83MNlHSjvDUBRufZ?=
 =?us-ascii?Q?dXyMih6Zt/xqjMTiqkhmxBU2Ep4H11G6FavaBtys1/O8eRd89V4T+qWe9AoE?=
 =?us-ascii?Q?MXPkYO88h+JemRa0cXUGx/QsnsJwwyUK+hq6UARAeFIdZ3EWsT2ee2rLcZVO?=
 =?us-ascii?Q?rSHoK51Cx+bWESdUqTk+x379dcnMxJPa3Yk7EX28KyN/cIAyAcTcdwdL90f/?=
 =?us-ascii?Q?PJqomix7541nfjw4NTwydg0TxypJ6KHaEcs+5K9SNDaArPGJliTVb4Is1i1B?=
 =?us-ascii?Q?3aXWspl3VGTWLCwhYIuASspXqvnxglIbEirmCilkOz+IkDaEvSkQU4xSBEUd?=
 =?us-ascii?Q?8przw+eO4YBhf8j1SVkNO1Prpi6YVKgo/nXTK9YkKFkBdKPwTEYN21Arqdxb?=
 =?us-ascii?Q?83PGbklWmYVCtOkI7nnIu2GuAmw6PA2AwPkIo7uxWBb/PDBt3nkpe+X3i9Sk?=
 =?us-ascii?Q?1k5EWiZycrl60Z9mYh1/M2TCKi1oYIIl3ypxfhySXMmN+zdgL11Hi5WdK4qN?=
 =?us-ascii?Q?dELLc2tsfBx664dLayhluQbLA02hiCTRwqBKzAt3FuGVkU5ZilY/nsqIHS5l?=
 =?us-ascii?Q?fNQms24idgqq9OsGJT+jkrUxGQBCYn/Ji9ymmO9+DzdyAT1hj3fMrTuBfOk6?=
 =?us-ascii?Q?Sg+elmf8QOWXJmtpfzqV/++yA9T4/6MA15QgYH/YB7/mVvNyq0ykYJP+/bf5?=
 =?us-ascii?Q?rWDmY59VGGQGRdTh3Gq4/wToNk64kBe4gzOe6nag/CHJp0TyAKv+fV1A7cau?=
 =?us-ascii?Q?V1DYWbfSIx+teBlfz9Oxqyp+w5XJa4+r6rvq0LWzxAuYJ04eQStj/Pul4tDB?=
 =?us-ascii?Q?yCSss/Rj5RmQWrJYqD8raloiEhVkZSVETl5jNS+cwVFcjbsoty+OglltOGXT?=
 =?us-ascii?Q?SnWHtdnN/pQH9PZrbXPRqHhGSoqSJOnZnpbs8X0axVDgPANujRnYj/Ss0qBg?=
 =?us-ascii?Q?ObprvOKNKn/e2IhRWSDdoFjK6Xok9ZjawADARPMM1IkxmhcVerVf6ew8U0gX?=
 =?us-ascii?Q?13DD9EtmTh3i6NSKq+Kd7UFV8OEFqVJ1xI3TaDEb0hUMGd+IQarAWse/jxZa?=
 =?us-ascii?Q?1DYlfgdrkV47jposYcbP3cgMllxy3jeiaKZTav78Q8Eowrp+fkNHjt9Jbao6?=
 =?us-ascii?Q?sw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2520f41-32bb-42bc-4f3d-08ddb238b701
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:31:21.7608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Je4AnwwiJpCbfJrY/YEvOJK7GcOr8yBK51NP/GkoyhTH1x/cQ7UAZuJkpCLkuy1b594uB9S4RznpOf0oworvwxH2s6W/K3xqrnkqaO5jls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11438

Add support for 4000000 as secondary baudrate for NXP chipsets
supporting max baudrate as 4M, and are close to the host processor on
same PCB. This mainly helps with faster FW download.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v2: Use the available 'max-speed' device tree property. (Krzysztof)
v3: No Change
v4: Add ref for max-speed. (Krzysztof)
v5: Add ref for serial-peripheral-props.yaml. (Krzysztof)
v6: Add info to commit message. (Krzysztof)
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

