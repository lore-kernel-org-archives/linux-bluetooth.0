Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B072F1D3621;
	Mon,  7 Oct 2024 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306743; cv=fail; b=IOX6qA3xJs/hyO3uWMJhhX73ng3380otPPxyH4fhJ71bPvXOs0UF5Ah05FKWtZrC3BrPh6Lu+X9NBRaWG6rOVCL6sc7zjcWGFU3dmgZN8qQiJA8BMFrFpDEyksPPT2CRQJUYvTcAJ56QWTiX6u2lEmfUwgW/2xgjKrAzTgZy4Cs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306743; c=relaxed/simple;
	bh=R6sNBlJudpvV20qC6/tPL/SM9V/5GIi/PFwJWCWcSjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SKrWEoSd6ZAcB2WsQ0/Z/8iS+R/zKuxyX8Le/A0ahKcAqgzIk7//Yq0AVcdVzPMA2UPN5FphQCSDSpSAOC4hfQ+OtbBRwaYxmy8vOfNmBKtKKjWisOSXWdGFHfw5LieMPmwNlYzaD2sAXoPeeraKUUo4RUkojM5pdzxO5oR3m3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A2Kcdqjn; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A2Kcdqjn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KLfjRGpiQ1z/1VcuxErEBt9wGm/KEZOYQePO94M6uOrFEEPH/4GgeP24O7O1j0WOjqcfVI9CSEaCkur0MkvMZDkE+ZVfH7wWwNpdRkovvI0UxWn+aCFd1otv9BqwPzTFjEO83+t8dWONz+/UQmadezz/HXf+Lt50rZrKdDGwVn1mHgLAYCcJ/f8wd53YsxDMxqbvwQUhRTxjLhis3EhLj8coFC72u5d+Wq0OzNEDiYPEihF8nqEZMYM1g/szctuASCwXxyG5ZqenPFuZ5bFjA8dwPLca3IgN8lPHx6wbwcoSgLmCtULmFZwaTbppgywDB8pGex8OQGHW55Nu+/nV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6ohec0CYSFqkDPt1MNpQwKYdTxT10eBLWFOYN1ARcc=;
 b=qKA+x2NZ2HQ13r/kowmmN3Wev35f/vN12pY27fAPpeIYIY/xaPt+QYSyf7JQhvl5dOrlJPzuwjxZ7Gv1DnT/SLMZcNriRB64uWv1nZ4GBtmmgG2wqLFI4QJA0spqpTyD3P9TKnbL3LdVlmU6V9HwejHfJUfhrJfhf9D6Yuj5nyWlOtsBWiS5QZPwzBTJb1uyUvKLLh0wYAu6/5Le6usGaiLtXfcMfc/s8ulMRlkxs/Ywbzxd7umg/ro2OLSXODqAC6+Oa8Hw20XQ2b3bM/2OX7laC9NIUuxMjFhS63399yn7A41Uu7RT5TfZqNQyvoE3X7gOv/M8UgLLNojIAHn9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6ohec0CYSFqkDPt1MNpQwKYdTxT10eBLWFOYN1ARcc=;
 b=A2KcdqjnCMUlCtYhSYna5ludvMx4WVJRE7vCk1E9d7rQ37E0V8G6LGjBs3Tg/HikDm9Sxa9PhLni6Xh7nUXywUykwY2+SMWWRmxeU9lV3vgYr4s9iUAuW15Lmf3EIW1l+6V3zojKvXS1U1zuLxWcQWR7+AoFG4vfZSXDXwJHHarpFYyx7xdv0xi3nf2BOAkakWUcT6sdCwbX/Y+xBBNH8vr4/+k8Ixrnl41FX7qpnpX5+3iatNOPPfVUlA5yWGcwU5fZ2aHRAHDAt9LshWaBdFUIxnTfefYl9XYBK2jlQN2DnpvcQ+9dsGTihgU3z8PognY5VxD4CuNAkpy3W1KDNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB11036.eurprd04.prod.outlook.com (2603:10a6:102:48b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 13:12:17 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:12:17 +0000
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
Subject: [PATCH v4 1/2] dt-bindings: net: bluetooth: nxp: Add support for power save feature using GPIO
Date: Mon,  7 Oct 2024 18:43:15 +0530
Message-Id: <20241007131316.626690-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007131316.626690-1-neeraj.sanjaykale@nxp.com>
References: <20241007131316.626690-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PA1PR04MB11036:EE_
X-MS-Office365-Filtering-Correlation-Id: 88696622-3aef-4542-2668-08dce6d1ab50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZX/Ju3EtFggQzei3cIp8bdW/EE6bLnl0I9sF6lHIvN94J6p/ToiBurxjbndM?=
 =?us-ascii?Q?yUHChBg6erHq1p/RGjkvEyH46QSvlR+j31+qqLI6EPdheQR0DOaPjtXZ91Sl?=
 =?us-ascii?Q?xSHB2M7JgGt05RFkTwqpW+EITs8eg1frwuqqvN2jWidhXLvohwQnxRKXktuH?=
 =?us-ascii?Q?Kf2RQwEFE2W3782vCKTNSwAgXZYsMgl24jYMk3xIX6cUa/qSoHOtzCAbsMgR?=
 =?us-ascii?Q?4qe1ONpS7GxS5Mx/4yNx+B5gCyySSuRrXRZSAJoCLOFfPoERNAHdeuflUi4l?=
 =?us-ascii?Q?i/QT3y7vzdcuwngt6no6dNocAZxTxF59VhVN90ZGtxOUJzt6LR66avUDZ0El?=
 =?us-ascii?Q?ZpwyuJrgU1/qZKNmaOyr9EZp8R9Ad6whOftSOGRBuhBYRdPkC4/UbJ3y3xFq?=
 =?us-ascii?Q?uC/lvE/oJJslzIc1hPKmEK/mp2NuA5txyvMDCI0Lbr7lL1uTqQhu5cEFMarM?=
 =?us-ascii?Q?nTy6Sq1foyNjmPkA5soDX5PRIEZfmyRF2CaNoQyaXmfJXH9nQCW+jiw5R6PY?=
 =?us-ascii?Q?dxSMdLOxej7qfowbkFEc4bSjUOfltgs3sWwSsvvRSS7jZL2bUeSYal09Bay/?=
 =?us-ascii?Q?klkDeTUkp4bb3vxQTseyLUePpSTHd0StqJS7c/EpkpC63ncf2geARAT6UZFZ?=
 =?us-ascii?Q?1cvUm/Jw3LeEthg0itQKK/W+YViLXq7wsZrWsfpzlAJYhmq1yXRIsbvZz/nT?=
 =?us-ascii?Q?86yFIJGl2lBSX9e5t687RJERqNvwtCtYPzR4bKbqZjVVOH4AM/VxxHccu77v?=
 =?us-ascii?Q?R5AVx0VO8XI32k4riMH/kak9sQdesklW6SqDt5zGZBvYzq9JU9Db7+QoVYNR?=
 =?us-ascii?Q?JOTAeBQpl4YINekQUREuqHquKknfSXWSIztwjIwCgRfSJSvvx/U35aVI8Svq?=
 =?us-ascii?Q?eK7SkmsTX5rOLAfg2v9h7gVM2t0OV7TgDmTYGN88janEP21pw9u8yYf/wVln?=
 =?us-ascii?Q?Iy37935bo3cCYrkpr1CgsokbcC5COrxAjI1Sr53bjVZGpY/ISXUXtlvXqeef?=
 =?us-ascii?Q?xBpnUkQp5te6LjNuLMzQedg632Ti+rGVhzRiH4HN8ombDbGOAJEhL95IU8fC?=
 =?us-ascii?Q?uEANrYu6h+z58v/4WMTa+R8fD4YK0kEj58blhHZaXjgRh5hZWK1J2Z7+GArr?=
 =?us-ascii?Q?9SNVBohpXrtIAZinl7ah1xyeKoJbwyNejBjoLlO/RQcz3YTqjdQBGOq1tztS?=
 =?us-ascii?Q?Mgf+1hOzxpFLYXkddqypzMzZjj6Hz1A9MdaueQP6Zcwvy11qmUxUdcSPWIX9?=
 =?us-ascii?Q?hk+YnFkAybKv39Arbp089Phc+2HR06EQvzBrPCcYSWd8+4R5DuT/A9txHwPi?=
 =?us-ascii?Q?xRUorRI0ng+2V71c3NP5P1nEFoRtivPVqnl45wk6itsiWw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1jdBrhyZN3OGE2Fk2HDN7rXdbFvwH3/YxG5juGFtXPA7KRPP+EWAgt2D39lY?=
 =?us-ascii?Q?8CKJqsk5wglanSDD73bkeb4JxAbPpP30IsHAxeSqqwTgVynYpxsvrK/Ii4RO?=
 =?us-ascii?Q?1m1FFtHyGHHXajtRwPPBEvyflVM4iavQfhEYxMgQLu76jtAjtj1osCDHN6S7?=
 =?us-ascii?Q?NPwq/Wojnt4u+Em7YMgx/9KfwsuSa2hGSVIKY3DEl7S/e8G1nEiegsADmreD?=
 =?us-ascii?Q?ObpUenKi9sNjt39NqSzDkzcZ9A8YVqpLCKqoDM7SY/e085YRw+2v0OQ4/+Pb?=
 =?us-ascii?Q?UMkIt2JcuGDjuztddcXwBeJC+2kzRhoUdr6JEdbAXimuGWMEv7TggAmjux1T?=
 =?us-ascii?Q?3YEjnfxWT1uNUHP1oGXe7yFX4ApDf7FjplNECm2Hd5fLhUlPn9b0P25ijFID?=
 =?us-ascii?Q?s2NbOl/qfo5AuDK3ZPGZwZBu1rXWd6mrnIxYSrFXqS6xCyeCfYvRDboKfheZ?=
 =?us-ascii?Q?tSTqNGxdLJvhBQxKQ8TjbdVaQIgkXSw1uHf5KKPHhlJ5O2/rlZNIw0St0vfo?=
 =?us-ascii?Q?tv1floBLO1ftv43fXM4cB4c1IJTHDwMMO6AfY05JNaNpo7WwK0K+DiNxL0Bb?=
 =?us-ascii?Q?JMMZKKgN8tNStzbla8mqIwuhVOzWajufAaHRBiVcYeqobjuA1vxy21OgeRiI?=
 =?us-ascii?Q?j/re33/WsMRuEwvQA3DvbIaY5tpb6qguB5sQfOTfHmGylS3mFWWeJEtQtyrK?=
 =?us-ascii?Q?sgfwf0gNXV9D4BXC7WboIOVhQpVhrR3jqwPY7+fUmGTNe45KmfChsobCKEnG?=
 =?us-ascii?Q?g9W5cN3BWNOWmma9Vy9CAv7KfsZJFAkHY3f/JNryzXkIgxXNGpuJD8qtiUJD?=
 =?us-ascii?Q?DGHMI2aJCCADSlLn7TZo2i5r2MFYeJCJNLRh2QuTAWlqOJIcifFlbpQkbk/E?=
 =?us-ascii?Q?yBGKTWhJpLjHQeQbQfbGqjxRTN5DmCpg8oicaIsUPpd53gL688llHDLC7wwL?=
 =?us-ascii?Q?maUX3srRYl8rPoZ6K9bdWAil892sv06NVz8U+1xBOuDGg1DJTjVqO31ESXev?=
 =?us-ascii?Q?JrLLkxJcnlXnNdxqLz3bAGp7qQbgRYdfF69/RW5kMiwqVWWi0bfvmXT55AkA?=
 =?us-ascii?Q?I3y3wuuBblwBas5XbzV/kY0mBzsYh4YLrFA7C0WFIahpDz71Jk3ENwyputFL?=
 =?us-ascii?Q?CgWPRfXI3TuN0l0aV7q9R3bs+tduRwp2mnrcx6DZiYWpZZ1hg+fati1noaYe?=
 =?us-ascii?Q?f5sQaVxI6MTkV/NhIzQ/A+GTkL6cw5SMh/RXS+D+yAe8OJH8QoTosuqKCDB7?=
 =?us-ascii?Q?HJC1jYVT1zvC7PmlSdmwyHJ9pZyUJoCEaEp7k/GUCzml5oLuOyF5queHqUPA?=
 =?us-ascii?Q?vYxtUiYqdtnoCr1IG2gu4lOjBqPPQryHky4E3Onod0ycUDsyHWkMAQg3BulT?=
 =?us-ascii?Q?hmy6N0IetKRYI2aYP5FlCYuOcao4SUAVLWfcSDi4txuxROI2FcxA34sjzRnv?=
 =?us-ascii?Q?tNMlsKPqHqNEIb1+QsikvnUABsIaw7xLcFsD45ry5BTBLtJAXkNr+lfh7geh?=
 =?us-ascii?Q?uwFWD89/xfLWyel22x4kPBWDsKG+YLOCJ3mrnKMpf9c0NEFOXhZD2T/dmgdB?=
 =?us-ascii?Q?xl38aPmz0IkQ2V3cKm2yZU2Am48lQm5Or6uCWEEKTfb/Xc/yPMWtVIblB2ZT?=
 =?us-ascii?Q?Ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88696622-3aef-4542-2668-08dce6d1ab50
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:12:17.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KwjZw1AdM4DOCDSAhHkkNVPOkxO6B1GSGRNeVsZ6B0nUFeBwHsLQ0ywIvYsCFuug8kmdSr1JnAbGoITGBz3aA/pLlb/+jQ3LYXYX/upCCZ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11036

This adds a new optional device tree property device-wakeup-gpios, which specifies
the GPIO connected to BT_WAKE_IN pin of the NXP chipset.

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

