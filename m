Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC42178389;
	Tue,  8 Oct 2024 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378660; cv=fail; b=VccmbvSUW0RRC1bFnQu10Mp19VyKObMffEeQEP1ms5iKu0A9V0xRef9YNGM27ZmdJbaieN0HDYbrQ9I90blxmAh1OQV9WZCOYe1Zary09aKwvh5qkqy2GLiWP7wwlqICpxA/I3KEMtmEYyKpX0l2NMZgHrGJ3BMgwqcnpa2C9VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378660; c=relaxed/simple;
	bh=+cMaQLokvahFRR2otSTppMDHy3p/3/JJvFFinvPDe4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rGIUDJ3WcVmPvTqS/KcwxvOJc251xhf30mpVynfwu3OEmoRVRcQag52X7PFc9d4uIhJdXAD0Fkk1eQ7zf2x3/roJAUIhIOIwgu/DVgHw8Y03Rvp+teFthCcku3XVOf8cXbeS1TxHLVdMMiz1ADHdM+yr8KXZ6oAxy0lWdUQ2YBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QpYYo6e8; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QpYYo6e8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxBPm6PWXd7S8SvjlSpH2qgtlLN+pz5sUt2OLNEsXjh4BAl9D9ZbVpa9KT+ILhWUeWTtuPrrOEhypGGTPLLBZMnVE0u0YBeoYmj4xZOUVXs7V6oa+5O3xhv+C1hl8rREBTkS0DQBuzTXPMRx5vHPes/2EHUpHY5fE08jnyCS75iNy2dkbiOepMGpdjbY8jXfWrkUEizIl7SJXixX42Wxdh3rUzbXNnu9rmnNMp7XgUjT3NMy6sqy8yApxUJGOdM+I8IX5/QzKU2dHZy4jtoke1i5G312urUfMKGdZJkJM1PXwYasqX1r9orZLo4QLJedTl9N2EBrKQiFYejg3eHmPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBo4dqDcbD9b3dj8EX/DQX/hN5QgSthhY9reACEwePM=;
 b=H7zO4c8QXeb0X23P4HmS8N2u+D21jG62gQFnDbWt1BTbczzTO2P/ep7WO8adPyB4fZ6LGn/c+4zpQZXS18k1QumVHzhha43kjXDPsHGnBeO1Eo731SNp5TBndv3DQvCH4Xw3UITeDfenoJVdFOvXDvajdJVtJiptUtXC73I/GE2zGY+6WxmnD1mVi4lRP/D7IUkhHdlR89ZLnWohg3rVk+1JATMnjspbFszAb3edG3oFF1GRsFB50CXTMUXDTmGnGJqlRVpSM0inIrurQyQ5IyZiQ4R/ukIdZbr1zC/actwn2Lo69jfCdpgBKkaZ1Els9XjoJ5gglI/mKv7k9WKHHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBo4dqDcbD9b3dj8EX/DQX/hN5QgSthhY9reACEwePM=;
 b=QpYYo6e8nYH55Q+3tQYYyLETexyXO5CpuuDHqiX2igxnKxAqdF32a8xwGp61hCTlj7jaWxZ3logOnMvuKB8w2XYcyjDSsJa4cMIjGJV3lAkMJw2Usw7qxeSsSxFX3r+qi9zwuf8896JPdqxVQd4P0894ifTgduTD0oyayUPkt/vh8FzDSfevIfn4/9Mmw8/j76qy71qoBksGm+DE0J8NT3mfaex2VgTxr3HqElPXIzDKRIUv5t+h2HrhoKA8poitiiOEjpha2ooQ0hMr+HB09nPS70gqej4DrskrdpiHMsGRcrSF8YtBTtFNKKbEMkGIG3nq2TNwATIFzY81dREW5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB7544.eurprd04.prod.outlook.com (2603:10a6:20b:23f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 8 Oct
 2024 09:10:54 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 09:10:53 +0000
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
Subject: [PATCH v5 1/2] dt-bindings: net: bluetooth: nxp: Add support for power save feature using GPIO
Date: Tue,  8 Oct 2024 14:41:58 +0530
Message-Id: <20241008091159.650531-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241008091159.650531-1-neeraj.sanjaykale@nxp.com>
References: <20241008091159.650531-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0047.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::11) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AS8PR04MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b712f6b-1d97-4f30-f5d5-08dce7791c88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TetU+yeqYm/vt4ebnGXes8mh241bl1CBhTZdlatKEaJbFu8O85ajVyqD3WTk?=
 =?us-ascii?Q?Bu/87TM9FgbPqANAkIndRNTiHueZtXXT8G3Myg+o6/1opFZhlyGIxphIq9UT?=
 =?us-ascii?Q?FKKEBx2/8x300E7IA4z6tU4uaRDSHSyLPq3GiyYz1vatAZMD3qcltkK1nDLX?=
 =?us-ascii?Q?ZOyG/QeggF91ZajnSjCF/8tFHnAtrDCeJ9CxoYN+rXaTMocWmFka77JYJ7Nz?=
 =?us-ascii?Q?zt6/cC8a8ivns+Y9eMJ6xq44s4dpiLA2VaZvZUp9j3q9JPQ+0E3RbnokVJEq?=
 =?us-ascii?Q?lBGIGbX/ORW0+TC6cX3mwcNv1CGJOHTa49diKbljWp1tu0zTCtinh0qhFGTZ?=
 =?us-ascii?Q?R4YW7c9kFULKGtW1EwDo848BZliUtPkuniRRbRRD1vLxbIwdqWndos41ujtJ?=
 =?us-ascii?Q?ZY/SO3K3LP2vmtN7m/VIbwiwn3FM8b2fXwmXkdYrX+yF/v/bRLpBBkH4jOZ6?=
 =?us-ascii?Q?GPEhJhTfqggOAMCcp9PBXUfmoMeaCex/DVVTixS1q+KC4/746TkNt/OZgybI?=
 =?us-ascii?Q?+Lw1falZ4F5Bik+YqZ9OFz7iTOYC+flXdQwnWmMgeFOGIo8fYBEEmA/PYIXx?=
 =?us-ascii?Q?iTK01mduCiE+m1wMseYtvQvWtrGfKbVsfJsFtfONPZYSsDqUKluVyzDUXjbK?=
 =?us-ascii?Q?pGQcJNIiq35RziMb9DvDa2Oeb3WTvP8hMBVHRG5VCQ7VVDHw1XyUX84+Rz/v?=
 =?us-ascii?Q?oMK+hVuD8z3aeuEoVTAEt+1mRr3aXbQcy0BnGlnchjH01Gv3UQDCWml/UAB9?=
 =?us-ascii?Q?VJDldaPVjeFpcBKXwsN2tAp61ukOI/S7aIRkxUPguEYpOdQJZkiYDDUlci1r?=
 =?us-ascii?Q?m8k1lUwXJ57gQhpl+VcqTFWXvGXZ97xZfAkeLO3xlvVGVBx+EYbMcVvcRwHd?=
 =?us-ascii?Q?mgNnmfjKQOoUcacVokX+sxOyvw3u3uErThd7e8p2SdNkINkvuibUbl/G1lkS?=
 =?us-ascii?Q?OxtCYkL4rTGLDyE4fDmNlQnhfNz0eXODCs1Kap1wiy3AKQtgZTeCduzlGtzc?=
 =?us-ascii?Q?y9LWzLnCvgH6AMC7UtS2aJCjoIxcm7UlsC+Zqx8tdSKZE/mS2A9+yTIXdCub?=
 =?us-ascii?Q?2rsQJW5w3QrTIUmW/OqbSwnI1fou+htfzEyeluu+7KV68YvJlUmx8HBfg77z?=
 =?us-ascii?Q?VDa4vKC7YWVC/ij8rIhphJe4SI1TiCn4Px+XMuJBEVQpiPGwHUFC2zPdBYgk?=
 =?us-ascii?Q?QUvSgb2rHjoS071QhBiy+KcnunSAYm1BYtsYd7r1QbxPO8leCdj0pG9bWr8v?=
 =?us-ascii?Q?VtWM1CzSVwuaXLwooaJwrWpP1CzwN6lQUk1Y9kt/TVGDbaPzWnuoUDjxT1SG?=
 =?us-ascii?Q?WhxUaXL8SZ8mgHG6JGIIP+0wKJZY7yvb8oVsXKEIhSUiyg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ug4zicIHn9euWi2gByXw5cDsF/PTJ4QWhi3IjyRUhph6hifp3exaMWwXhOjC?=
 =?us-ascii?Q?xkOMULwGR2FJVYvrg473ar8nF6B19wucdtRQzSHAuEtFH+JSfGitEhA4J5Bz?=
 =?us-ascii?Q?GLEmzh9aX2cNrZ8f3K68z4YpA1HOYBqyRmS6CcEdceT1rPYHrAcIr0Bs2E4i?=
 =?us-ascii?Q?FQf68JjoFn7R0E8FupY+iq7fAWPI7z3/+RftPAXWyLeWxIszG5slvBYE4t+h?=
 =?us-ascii?Q?Z7YC0CvsbhWKRZRL3oQCeZy63r9jW6FNPz9PnbZYejQYR8z+N4PwVa9a2jgU?=
 =?us-ascii?Q?1h6CJcqzo3xpR78cMh1SXr9+k3COyym4hvWiGm4o1sCOOf8k6T9NhPBDjZLO?=
 =?us-ascii?Q?3TiA7yDXCwpymNKSFwU6nFaMMTSvjWwXUCaxzfZ+LFhrPG3mBVbn89pPVg0b?=
 =?us-ascii?Q?ME67R/6gQHsKrJ5N94RoxSeEviMWIhqLLEMelTWCqyq9EBlGldk4Qy+n5CLV?=
 =?us-ascii?Q?lX4TKNZDM9BOc5o9bt1pBitCZFsni0UAgsGK3vHoRdsIxQ/ESU1o/bZVPYQa?=
 =?us-ascii?Q?/iyubCxtw9f5YUc7h49G+KSkCIco+jWB+rrA6P6DNorvB4kup383eYnh70aq?=
 =?us-ascii?Q?kqlRGGq6HnZj8EAUOGfIx6hFwvk3Up074nYglyjLknznRGAg+2IfEOc/Z/Av?=
 =?us-ascii?Q?cSXH2f/DEx14HUBmGER6g8goXU3wCR7lXuyBe8PQ3wNzJrVS1lshTIfupMJo?=
 =?us-ascii?Q?OIlZlsaFHgF+zO9EdonDnzhPoH6rI3f8umeqGwzVpVWwsuoZyVbGUNs9GnCP?=
 =?us-ascii?Q?rQ4cIvhakxVvR5W5CJTFCUfb3GBP43MZwkxxMPDKgZ9rQuliIQqTnNEngqVz?=
 =?us-ascii?Q?HMKaLB0Hhx5mpdkpAMpZeW+OUoK+wK1LaQKddkiM/eDcDrOEzHf+82hedOxX?=
 =?us-ascii?Q?BRGAPs1viP5M3waPuGPeciyOvzi3iUwXtD0Ml15h9+yGePyEFbPnpSo2QOph?=
 =?us-ascii?Q?2qZ+LL23vzqjDMpEDoeNz8fQb+UgAYVqZn5HIAYRllRwMTKUkOBATbSyesCs?=
 =?us-ascii?Q?YQRo46IQUcJ3rFTB9VNO0UaIn1s1NQEdfa8cDTCRMPT6kkE24IP6+0SvnVgm?=
 =?us-ascii?Q?DqvnDVFvml38vGO6jUMZXamG99i/JE8LiFmCoxdLpn1UxvgcmRGwS74hWkGs?=
 =?us-ascii?Q?OTmijosQKh/UlyzD8sBaIsW8VcktSQjXt5iUzzPRm33F/WAnyweBK54hluqE?=
 =?us-ascii?Q?smRB+DrF5TWi3tr5kNR9m2apR9LLSXEcIQtBzp8FvZEm2qVzGiZCsecna1ui?=
 =?us-ascii?Q?CKKMsTMr0UPWBLeVVQV5vqYiNEU9Yh751paQi+kyKEprg6o67vb7fYgV/5QW?=
 =?us-ascii?Q?2stf4kHlPiZe0m9QTA1CuVs+TuT27R3Yoq+oUmakXM0wPOeqr2+h0k9nOGrH?=
 =?us-ascii?Q?tT0tX5va+10impwAnFaP+LLOPepvg9UA7WM0+K3wrF7ypjlMOzKSvVo/RC19?=
 =?us-ascii?Q?LXw88utuLWRBiFSYHlNHrfoc+qNuiRRr4r/k2k+L9DwwWcNg1LMrpV73cwMp?=
 =?us-ascii?Q?zTLs8kDcfNVg9FxgP4b/QRSHyUiq4ZKYIeDDMcDbZj3+5X6bjD35TBCdCvUg?=
 =?us-ascii?Q?RkL6zatuVPxxzwSss/pBbGFNa0lnCyDFrG51flDkJ6EFFMBFgRAHIH77cNRj?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b712f6b-1d97-4f30-f5d5-08dce7791c88
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 09:10:53.8475
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35a9c19nNfI4kH6pFfr7BPkrnsXSDm7RBBK/r4EnEFpMPjIOKR2Usz76SyVE99mTqqAJn9uCR64KHJ962hAlb2wk8CT9mKsBwamGRYEw57s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7544

This adds a new optional device tree property device-wakeup-gpios, which
specifies the GPIO connected to BT_WAKE_IN pin of the NXP chipset.

If this property is defined, the driver will use this GPIO for driving chip
into sleep/wakeup state, else use the UART break signal by default.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v2: Rephrase description and use "-gpios". (Krzysztof, Rob)
v3: Use device-wakeup-gpios instead of h2c-ps-gpios. (Krzysztof)
v4: Add Reviewed-by (Rob)
---
 .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
index 37a65badb448..0a2d7baf5db3 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
@@ -34,6 +34,12 @@ properties:
   firmware-name:
     maxItems: 1
 
+  device-wakeup-gpios:
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
+            device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
         };
     };
-- 
2.25.1

