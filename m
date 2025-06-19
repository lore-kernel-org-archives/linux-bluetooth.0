Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012070.outbound.protection.outlook.com [52.101.71.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0536C23B627;
	Thu, 19 Jun 2025 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332872; cv=fail; b=EzaCuLtpwth9Qq+z1avIi0Avw8ESNXQLoMAYMVJ73JPuwupQ14jy2ID9BcVrulw1y0RxQWdafRYf0CXjLgJFP0f9zQ/cwdclCbnNj0MKnqBfvGrCK5jlJflFr2+uUT5VIGaXIE5E1ikFVo2978Qxdep7Fipd5jpjnwE8cL7rVfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332872; c=relaxed/simple;
	bh=b3B3gpqzYnVZYQ9VQsZeiaW2dpb9E8Upq9pfJnkqY1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Po6Ztgs6QGFcfi8y65y3UD4BrrLfoTBFuUarsR4ze6refffpqQrWIq9pOOPQKVKkyZl5bZJ21l6TYt1a/n/qAsw5UZinYaMuGy+yNwmWu5oJatduEz6LDjBm5JU1HptMyXWaUa6+6m/9vgWe2DIT8TrxEn+Nb0/Li25xIyVLQeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dH1hKpEK; arc=fail smtp.client-ip=52.101.71.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dH1hKpEK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u895vlsQO0vqqegHiXGykt7ScouF3FrDTRSVcNIeGdyv9LCCyERi43EC3u2Rx0M7sPULv+/ykTyf3yTzO1HmAaiDufA9CCYBD1pzIzBaaDE8RBVWtr4TvjhsHkWGzUr04GVUS+pugblFzQeUcDnopISn3Jbvng7n9oV313+v2GEe/q55HO1Rvb07wOrYeFznDZSGwyl3eznX7HaCKKAEthXvfOwlFBYIEroI7p0ryzFL1M2L4ZJ9Sz7pjtubqHcqCGB3Z89cURdZ9zerMig681Yaskt3VefZAP9c/pWS0Z+RrqH2mkPFbS0wXiAD3NxDC1L2XEeF1bgc0/akyNDcJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOHqPAjjV94RD77ipMam3CNdnjdMY3IKpbRfR3SRPzM=;
 b=y7kgmyoRe1ZX5DXWG6kD/QrAvtkA1Dp1SOxcwWQPu97CMbuQVSudufuNBFqJAkuTQ7dIIzK8Hw/1uheCnqMDyjbj5Lze4H+Dw2mwXQXtpbkd8PIPKIIAJyfRwr0kx+264ToyHg6icjMPg6Y65gJcUFfs1I0U+bQuqdGOfV+RAklVd6WXmCy5pp4FLjvMTD0Eot0MHDvGRLmQjaEGUzILvNlg6fj62DnwmcQmF+1ovlCSC3v+CuyFx7ObfBR0ni+P+pdgLDeNsgK6Al2ZYuaY5voi3elaHxhVuaWbfIE/qtSNHcoUYcQAbOnEdLHcGdZrW4mH+9Ytccnz/J/gfmydQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOHqPAjjV94RD77ipMam3CNdnjdMY3IKpbRfR3SRPzM=;
 b=dH1hKpEKUvhQ1HMpGjsJoCIZ+93Mz9jgWEnQjmhxk6QJWBOTYtOXsoIZ9b6MMccA3U/QK3VqIqt2fqPtWvNm/trR1ggGoohY1Lv4Xus4tPKejQFxWNguAjeQv0UNQmMl+0Hb3sUJkkqZJV3z4Vmx2ssty7/wXRsMNtbyTqgqg2NiBK4MbVhVw8u2m18QSM7JoT75BWu+ltZ1RSVTC+g6luOimCBjP97JeoHA68wl+v8ZJTDE1PgyPPFjofLvjRS+Hgu1h5W1ArEaRRCZp20wax/gfi/cnWYOFEtCOlKYVJRoWO6e86J8ynoWcW9s47g3Kb7gOwZHK1xkJ7BXXosBHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB8341.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 11:34:27 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 11:34:27 +0000
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
Subject: [PATCH v4 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Date: Thu, 19 Jun 2025 16:46:29 +0530
Message-Id: <20250619111629.30098-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619111629.30098-1-neeraj.sanjaykale@nxp.com>
References: <20250619111629.30098-1-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e139bddd-e3ee-41f2-b79c-08ddaf253fb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gf0u00yhWVXv41K/3xWQhlOdGwlUbhZheo522pwyGRs+tu2nbQPzYtBDwpuF?=
 =?us-ascii?Q?XAg9OGm9dPlWfWZi0ClhjAlNfkxArAYivLJTrinO4fnmpYP5O2EYO42s5isj?=
 =?us-ascii?Q?5vu6t1fN6EZDPg4/yYeC02n9eZGi7bLKJvSyBAa9AFxlNJjKHmPU19ok7afO?=
 =?us-ascii?Q?cylVKX9SAZgCwfio/QZVNR81O/2ZKCTDSyB+KJgx/+kR4JQBmKvQ3f80kLz1?=
 =?us-ascii?Q?/bQOjvKA+RHiaC2yXGqGNuoLtGzKailmap4y5+iceCWDqW6a7ynMYL3ZHoUW?=
 =?us-ascii?Q?AJJenm584vtFoaZ9SbH1KB0JytDiEna/J4HAlECaKlfrn62puhZWHVurbbVp?=
 =?us-ascii?Q?yq8EUIxKZIFTE6MGAO+iHzC/9WXfGhT+beA3S7QheGw5D/2aCZWbEKpmgRMq?=
 =?us-ascii?Q?UqfrtVDPEjPRW8TKqyQtKizekAzu1K8OXofUGzmk+LbifLNEfMV9/BnLrRkg?=
 =?us-ascii?Q?y2MLb5mlS0Ws66rB3UnqKzWLXfllZkpL8e0/hEaxeQRoUazIEPE3rGdpHxVo?=
 =?us-ascii?Q?IIBkLAI4X88zMcqIGkp6c+hwGow3mxX2bdhkGhwAnYlSagTPBhdlVd6PjdZU?=
 =?us-ascii?Q?4nw3sKFHy6UtJHCVg7hIRELweJu9YAs1Iy8lQFnEuf9supRnpTX81TMJXVB2?=
 =?us-ascii?Q?2056ENzo4LT4zXEIWbmmFxnX+lc3+7qjP0XScF4i29o7zCMB+ZVtIv91qJyA?=
 =?us-ascii?Q?8RN3EHNlxENFoFXIvz/pU/5fHWdFNvxYcYPZLmKHKMGP93dl1YFalLyyRUb3?=
 =?us-ascii?Q?3IU+pWdB3uwOga4WTgJq+JbBZNn2A5dTRHuh0IQazOa5iEwr1upYsGoqOWQ6?=
 =?us-ascii?Q?nNqb6gU6KINeSit7FrqvNlMCNY1rncsRExrV0stmcpiTuqe7mVG4O75v2dA7?=
 =?us-ascii?Q?yKRX17ca6/GOx4eBW0R3c/zD3M6cQqq2N+zLHsJuBY3FR4g5N0CwKnNH7iPK?=
 =?us-ascii?Q?jphZ69Vn+KyUOE6Crz++SgoFkIKrrTPzrich2mj7qsQXg0AOM4OWGSjXJADj?=
 =?us-ascii?Q?ISwbBN/P0xy1n4ljL8khDEweRIAy1UylDBTmNUF9IxTrcd8+atlXhEc3Nf6I?=
 =?us-ascii?Q?lOzEgCQruADhxt7qT6OoCbLqCuNswnSyRdysp1Wiqf5WWExkkfnKqUZGUJd4?=
 =?us-ascii?Q?VFxt80LMJ+fNlVhcMN3Bj9jspiJpI+TAVzZ03MhNaomGJJozc3ORKoUjTrvF?=
 =?us-ascii?Q?m6BHJdNwLtl/ikFQFUCjzuNxKHj0zuSYv66W9es2mmlElyZ8Ma2+xGZ8BYf1?=
 =?us-ascii?Q?kI8gV7C4FkvXH4THtv5o2EWvKhuvofkIeUv1PUB0UP/HXTEww9ilPEBH65YI?=
 =?us-ascii?Q?aXm9uYkNW3+Y2vO1QuEkHGTLVY68zluix4FziAcHk8RJWis9qsKzJFAPdQHY?=
 =?us-ascii?Q?7oqzE/xkYAqIRaxSnNfZrtO+EWrCd0e6+M6IavpFpZgfMlmPZ+CyPkuFFE4J?=
 =?us-ascii?Q?X49KAnnjEIW+TR7IR28N40QXBcAZzI7+drZ3o7j08tJGVTMEfWgAXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ie0qIk26ADtVWrTjZyOZPS42P5439rGrJnZxZc2eS9Z/HkUyCtOVpGsGTect?=
 =?us-ascii?Q?7swj+HuY3a4Az9SeyBPE/sEomfw8UJuZREW63cGrThKiPxcUke3Mbi8Oq601?=
 =?us-ascii?Q?GHVmWy8eGOnM5UdPTfwAny1ZQ2levFtsRUWQZ7xoadOsiJltppv+dMvun0Iz?=
 =?us-ascii?Q?Ghpd0Y0fj58jCyrbRh1/JWLoIDUIGtTpwCA7s5t0nYQ8h2/7qWsZB8C+zvf6?=
 =?us-ascii?Q?XNIc4mVqnfqmtDwcYShZ3srKYgrnvLDXU2ECNV98NWHMnhnWKEGoWS1NBoNm?=
 =?us-ascii?Q?2qTsDUut5kxcJY2y3Q2OpIRRM5y7U3yc/2O3lxaLnkMPxgcWFFlHfeUIURhq?=
 =?us-ascii?Q?I9vUus8hikx5Pbvh8pqrzLOvhHmhX85GiG4M1WrHm+nkPMth/B7eh/OJVJAS?=
 =?us-ascii?Q?n5LNwYHJaLPb2LjEUVZxWh2MR9anIDUNrqTCQwPy8O2aK7Xx+uS1RlpEFZ5F?=
 =?us-ascii?Q?Kh0tebE5/QobmpJIU3wm6qMp209pU+n2RJEAGW3W8XYd94QtC36bxskcELXB?=
 =?us-ascii?Q?XudFQG/NzQmr1zTMXpUP5UzMdAu/KGPr5l8ymmjSKWdTVKEJQ4zVE/ODzciC?=
 =?us-ascii?Q?Y4lYX3JG3PSdWscHnTKvgG06tWUbv3XUfDA5+cUZXECuXI7jhRqZgvz97g+n?=
 =?us-ascii?Q?4xkd8mOpn31sW5yq0O0ZD11jn2kG4FgAbGwtdHj4Og9jPn7WsiglW3xgrKam?=
 =?us-ascii?Q?UIXedmEfcUg42B2ONafY8F60nIteqJSmv7T/FD1iYIpzskzqx4s0DkkkwmV0?=
 =?us-ascii?Q?AJSyE1VwocB2EmRfi2CF0ZmfzTZQcrWGrOdy8ZtDiQHgUCZrw7HfICxtMXU9?=
 =?us-ascii?Q?a42/vs8otA/7dovZgIR0shXEaNHsyDCXvLOwoBxYFIF+s7vIMg3ub0577kdm?=
 =?us-ascii?Q?AocGNufV3x4yBSUzPTjsN6g6T0gIK3iWEnLHUHyPSNj/fU3qisW+zPJYZGCO?=
 =?us-ascii?Q?868vweQqvye9lEPonXp8VOAkU2nZ6nEmnDSbF8XETvi7YpkverPvMdyjAirF?=
 =?us-ascii?Q?XWUHFCVWp6e8xp+OzomjfSbyHgsEnToHDg7sIppbcb4Ea+aJY4KALKsZLapr?=
 =?us-ascii?Q?8qVt5XMBsA4eLAPt3y+lJJk0rzM/uJiRckdvZjAWa2ZPO/S9T7W9+EwKwrVT?=
 =?us-ascii?Q?ZqXyW5PCET68l6SnFG4XfccyXhVX0kQY85AGt905EKnQ6RtatpOz7KtWNRh9?=
 =?us-ascii?Q?0VVWvpdhHcrLUPCHJvoDLMAiKGFeRIm+skreAsm13Xr9uwvzu8jlwdHso/oq?=
 =?us-ascii?Q?k28NK2t+cffU3aTr639a8VlzLieWOtIO9UVeO0zm5ebqaujAviuF6WjqWQ+v?=
 =?us-ascii?Q?Prph1SbhnaWzEMCfVCS0yX0IG1qrx0fxZKN9ZbeDWafned2Jm+Aywa2a0obK?=
 =?us-ascii?Q?0zPggQ7zpMetogKK37NDQD2+8vAQdwuU6uS+UuuZd1ZFwTQQkN0qEM9tWKsm?=
 =?us-ascii?Q?Eys4hBdJ1uMnj9RFhTx6M5sFITwwA+scNJbnlOMIvjHCXdwNg+/CmUacly9C?=
 =?us-ascii?Q?Fo3pUfUS3bedIs5Qg+IXsubZy90NQlN1SY4bPVVHVwNto9cMgk2pUb6fX1zv?=
 =?us-ascii?Q?KuvSvFHgHAN1CTGg+XSWJ7JYReKlkZayHxQaUfaGDES2/E6z76RXR+CBvmhF?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e139bddd-e3ee-41f2-b79c-08ddaf253fb6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:34:27.7354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: li32OD2as/tZujK/rrio74gdyMlBL3hYe457kmS7/1P6vc9+sMzMwz07GnqqnfkFX7K1dPVsqK3zorlNOFulEUeffdmtsK6/qRrKTHSZMkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8341

This adds support for 4000000 as secondary baudrate.

This value is selected from device tree property "max-speed"
which is then used to download FW chunks, and as operational baudrate after
HCI initialization is done.

Earlier, the secondary baudrate was fixed to 3000000 in driver, but now
with "max-speed" property, this secondary baudrate can be set to
4000000.

The secondary baudrate is set by the driver by sending a vendor command
(3F 09) to the firmware, with secondary baudrate parameter, in
nxp_post_init().

Any other value set for max-speed other than 3000000 or 4000000 will
default to 3000000, which is supported by all legacy and new NXP chipsets.

This feature is applicable for all new V3 bootloader chips and w8987 V1
bootloader chip.

This property does not apply for w8997 compatible device, since it
downloads a helper.bin FW file that sets secondary baudrate as 3000000
only.

The switch to 4000000 baudrate is validated using a Saleae Logic Analyzer
and imx8m-mini with AW693 M.2 module.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Change DT property to 'max-speed'. (Krzysztof)
    Add support for 4M baudrate to w8987. Update commit message.
    (Sherry)
v3: Add check for 'max-speed' and set default to 3000000. (Sherry)
    Add functional and testing details in commit message. (Paul)
v4: Add error message for invalid max-speed. (Sherry)
---
 drivers/bluetooth/btnxpuart.c | 36 ++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 6b13feed06df..c56b52bd8d98 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -73,7 +73,8 @@
 #define FW_AUTH_ENC		0xc0
 
 #define HCI_NXP_PRI_BAUDRATE	115200
-#define HCI_NXP_SEC_BAUDRATE	3000000
+#define HCI_NXP_SEC_BAUDRATE_3M	3000000
+#define HCI_NXP_SEC_BAUDRATE_4M	4000000
 
 #define MAX_FW_FILE_NAME_LEN    50
 
@@ -201,6 +202,7 @@ struct btnxpuart_dev {
 	u32 new_baudrate;
 	u32 current_baudrate;
 	u32 fw_init_baudrate;
+	u32 secondary_baudrate;
 	enum bootloader_param_change timeout_changed;
 	enum bootloader_param_change baudrate_changed;
 	bool helper_downloaded;
@@ -802,7 +804,10 @@ static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
 		nxpdev->fw_v3_offset_correction += req_len;
 	} else if (req_len == sizeof(uart_config)) {
 		uart_config.clkdiv.address = __cpu_to_le32(clkdivaddr);
-		uart_config.clkdiv.value = __cpu_to_le32(0x00c00000);
+		if (nxpdev->new_baudrate == HCI_NXP_SEC_BAUDRATE_4M)
+			uart_config.clkdiv.value = __cpu_to_le32(0x01000000);
+		else
+			uart_config.clkdiv.value = __cpu_to_le32(0x00c00000);
 		uart_config.uartdiv.address = __cpu_to_le32(uartdivaddr);
 		uart_config.uartdiv.value = __cpu_to_le32(1);
 		uart_config.mcr.address = __cpu_to_le32(uartmcraddr);
@@ -966,12 +971,13 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			goto free_skb;
 		}
 		if (nxpdev->baudrate_changed != changed) {
+			nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 			if (nxp_fw_change_baudrate(hdev, len)) {
 				nxpdev->baudrate_changed = changed;
 				serdev_device_set_baudrate(nxpdev->serdev,
-							   HCI_NXP_SEC_BAUDRATE);
+							   nxpdev->secondary_baudrate);
 				serdev_device_set_flow_control(nxpdev->serdev, true);
-				nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
+				nxpdev->current_baudrate = nxpdev->secondary_baudrate;
 			}
 			goto free_skb;
 		}
@@ -992,7 +998,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			nxpdev->helper_downloaded = true;
 			serdev_device_wait_until_sent(nxpdev->serdev, 0);
 			serdev_device_set_baudrate(nxpdev->serdev,
-						   HCI_NXP_SEC_BAUDRATE);
+						   HCI_NXP_SEC_BAUDRATE_3M);
 			serdev_device_set_flow_control(nxpdev->serdev, true);
 		} else {
 			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
@@ -1216,12 +1222,13 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (nxpdev->baudrate_changed != changed) {
+		nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 		if (nxp_fw_change_baudrate(hdev, len)) {
 			nxpdev->baudrate_changed = cmd_sent;
 			serdev_device_set_baudrate(nxpdev->serdev,
-						   HCI_NXP_SEC_BAUDRATE);
+						   nxpdev->secondary_baudrate);
 			serdev_device_set_flow_control(nxpdev->serdev, true);
-			nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
+			nxpdev->current_baudrate = nxpdev->secondary_baudrate;
 		}
 		goto free_skb;
 	}
@@ -1447,8 +1454,8 @@ static int nxp_post_init(struct hci_dev *hdev)
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 
-	if (nxpdev->current_baudrate != HCI_NXP_SEC_BAUDRATE) {
-		nxpdev->new_baudrate = HCI_NXP_SEC_BAUDRATE;
+	if (nxpdev->current_baudrate != nxpdev->secondary_baudrate) {
+		nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 		nxp_set_baudrate_cmd(hdev, NULL);
 	}
 	if (psdata->cur_h2c_wakeupmode != psdata->h2c_wakeupmode)
@@ -1773,6 +1780,17 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	if (!nxpdev->fw_init_baudrate)
 		nxpdev->fw_init_baudrate = FW_INIT_BAUDRATE;
 
+	device_property_read_u32(&nxpdev->serdev->dev, "max-speed",
+				 &nxpdev->secondary_baudrate);
+	if (!nxpdev->secondary_baudrate ||
+	    (nxpdev->secondary_baudrate != HCI_NXP_SEC_BAUDRATE_3M &&
+	     nxpdev->secondary_baudrate != HCI_NXP_SEC_BAUDRATE_4M)) {
+		if (nxpdev->secondary_baudrate)
+			dev_err(&serdev->dev,
+				"Invalid max-speed. Using default 3000000.");
+		nxpdev->secondary_baudrate = HCI_NXP_SEC_BAUDRATE_3M;
+	}
+
 	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 
 	crc8_populate_msb(crc8_table, POLYNOMIAL8);
-- 
2.34.1

