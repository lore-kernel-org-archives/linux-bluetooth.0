Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480C036404B;
	Tue, 18 Nov 2025 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475682; cv=fail; b=Ne/bRRVveGXo5W4k5RJsFIEZz2/m6/OGVbeXGcxFfll/2EE0LfUIrPxvJ/vv2fAkXSveMoKW89usKF14IZDgV/w+UkI3bJCYfG1VbmlD7y5OuaZlWyF0n8hIjkZelLYx90qa1kv5zJCvp7Rl+LvFpBjtJICUz+39vcnItWDY0mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475682; c=relaxed/simple;
	bh=km4rF4bUyuzo0BOALXZNdiZPw+ibd8um95ktiwdxCBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VxL0er58uYBlqfWxsvovgHMn4chw59pxW5ufEe43cR9oaqLNCtXIkOWhBbsCPczqH1heYzW9gJ5bqKDZUpiHD76+QgYYHslcwQywC9Ic5o+RgRGX4/CZjn/VTsWCdKi+ImxFEhK65EPMP1zTqmXad17N/5BahI9jsVV4i97Qus4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LEOSp+Sa; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LEOSp+Sa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arD6DCLFWFnHNebhPO9vcHqwBVWfRz35+P/4U5X4tmJiF74U7oB5JGl17lu3pEkyT8ZhRkZUc6w0wS37MeSmpHinrTaq+BLEdEeKdKH30CP+kCvRAgR8NGTt8gmUBi2sQwAlMpRNJJNVSG0MxPumSgSRoYTKKC0MCcA7/JITq/JiTv+Ii5rShqsqZ/JGMsEnjUjt/9EAJiMAduqouuvjdWp2ZjUOcjxPxTkIku2W/gbTHMR5s444M41RAGj5ZRiY0w125U5AVWYZhf3Kn8dRsL6N97AewT8LVWF7pXOrBAbb5gMDxJ3jcf4SE4+eEThzBFUytfzLJpxefmw7+wvz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmk5HxOxbST06yXZAnFLte9/3JclGzg5IaB5E33aOb4=;
 b=dOLbAXSaLZFht6ui0FGJXrZZGosaPzkHMXbVPu9FyIK/iYHK03IcJk3MDyrevpEUd6hqErYkjG0t29Coz6xZ2FNQRKctFrcERGCMGsjjazTBs6hOH4OkUO4/HbF8XkFus1lNfgapGv0cAiDoLhzqXhEuca0U0ZioatnyOduh+l2uY0SWlczV6z4xfjZcMcV7Xsh/R6fe2Wk8+JrMsRy9LurUGnKQTSd8OcKn8b82UnFTIWqCxRgDQnA9KHiCTLddo2s9p4W4xMKEnoQtrLai4FTN7XEac0xQI9HLPvP15+rIbunglKGKMwJsTcS4EnqHLVB6+o66vzgfkD4ZBhgZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmk5HxOxbST06yXZAnFLte9/3JclGzg5IaB5E33aOb4=;
 b=LEOSp+SaaS4aTXKtz7Z2QJ4pdcLDhpWvf0EuY/txtBikeLyo8JI18M0NOs9UkcKq88MmLYdvdeyOYuqG9nlvPwPmTy7yy82ElqgNBDAk/io+G6s/xA9NmaMSb/+jp72jV4gdbwwGBfTLk1/pJOjz6cx8LdksV1WVMvjgaoPV88oVuD/gtzuew7L85T7KiYAFCVO342mGHwjGMSM64tSAPTHNVhYG4A+flekK3gRUe9d/N0sIJHeMHK/DSF+ef04Nnpg9TJ0vzk1FLAipgJspKnEAE3McejTLcDVgJ7JToVkZFJ9VKxppSWgaIpKS+/9//rnb3DjC8utuJi7e2WGSog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB10179.eurprd04.prod.outlook.com (2603:10a6:102:460::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:21:13 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:21:12 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 11/11] Bluetooth: btnxpuart: Select crypto algorithms for secure interface
Date: Tue, 18 Nov 2025 19:50:24 +0530
Message-ID: <20251118142025.1982263-12-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118142025.1982263-1-neeraj.sanjaykale@nxp.com>
References: <20251118142025.1982263-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0036.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::29) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PA1PR04MB10179:EE_
X-MS-Office365-Filtering-Correlation-Id: 1711123b-8005-4ef5-00c9-08de26adb9f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l7HRurhW4A0nS9VIXjUXee3jBcLcZSeTrAw1lM0Y+ptvPrPL+XNeExy0p1bF?=
 =?us-ascii?Q?XEoaL0Bu0jRpXBM0Jimjev2A2aXGzHiu7sCeOx6EC2/b07YxdcgWl6dxNCXI?=
 =?us-ascii?Q?efVx17FmSnAU30LR0R9mWo10m5PJuTRv/ShUVBrA+ikaRspAIFQZG1F6gfyL?=
 =?us-ascii?Q?qhBj5EdqiUE95oBc+RvtcqFDqnHZP2DhBLw9WGH8+8nQoh9zIZ3eSLppLRxU?=
 =?us-ascii?Q?KuXyFiTAJb77Vi1vqcFPFlZRwhxNiWVrC+qKvsT90SQqj7kENf7WTAH8XWNx?=
 =?us-ascii?Q?qYvMuG5IPjmOohHNneq3JRO696ZsMbCK4kBHH1EfPdzKE6BIUS9bNQOrJepn?=
 =?us-ascii?Q?LrfXxM7ggFmHuAEqMntg6f0GASy3mf6xOX2lZONGUejhykyUL0l05n0jroA4?=
 =?us-ascii?Q?r9+dI3jEERoYcdv1D5CJol6ss9Mk5oZqgYxXtOd0nWhk/SU/OIVwucXZh3qZ?=
 =?us-ascii?Q?zYzEu+/tvlk4r/WCGVbAqrpDqWh1KhtpmgzU6cxO8MfNm8zvQRuA5kHrHUzR?=
 =?us-ascii?Q?jul/Sqq6g4RhD1QjYP8CnrqK68aJO275nQNZVx+Cyi+9ufQruJyhSmr05LfA?=
 =?us-ascii?Q?AHeK6UO/mqT5YVtDuwX/uXggI49mOeKc8nkNCk6iYDTH9KDq7fG1sj0EtZif?=
 =?us-ascii?Q?baF8Apnqj+f11CDsFhNaEJyFCA0oqhB0D2zBF3x92cp0wWji80Cr7ZipRvcd?=
 =?us-ascii?Q?stDHwsT6vXutHSihZ5YxzqYQZ8KY1TaBZYHhYpw2YOReb8ODDfm9g0J7zK+T?=
 =?us-ascii?Q?I/4Ju6mTjMRmkfassyA3WO0FG9vEBDl2GvpJHwyxZf8EIMQI5xwEoWvxy4SF?=
 =?us-ascii?Q?19eDQq8RkZUJLfdMPSatBords1oxOle9wRq/FPHazcNZUuC8vUIzrSyHqWfX?=
 =?us-ascii?Q?GtOFQdvgLH+Pp6EY34dhBzMUHxFnrm19qoHVTtl2ey1U0q2YzDLV+r6jp3ng?=
 =?us-ascii?Q?wfmfFA+X9WKF0cLoVPWPcZcpoBKaAE98E7Wu5iy7oAl533a/GWUPzR5Vshzp?=
 =?us-ascii?Q?w+RevGbzfl8PPOO/n83ppdS3f/ek3gaZ9xv8fItIiCMH7rrA+j411qEoAOc1?=
 =?us-ascii?Q?pkpxJSKbLMM512Yfs6/pWUjN/D65xEZ1XWZARWjEI+FNOjeGdUQ+An3jnD7X?=
 =?us-ascii?Q?RoLKL4/JSz+u5ZRPl4WeeR7MpzvJLs//meRL0/C++XzaIsa8ek2RQcqYwFGU?=
 =?us-ascii?Q?YUVJ3OHpumawm4lWDYpvko481CR5HrGJDxTXIKruhRqAVSZSLdsmFVJB9Zjw?=
 =?us-ascii?Q?ndQtHDlhW4h2cLje5UfFUuP7tqszsqcKarHz5yKBFOWVOiVjTY/g1m1PiSFZ?=
 =?us-ascii?Q?zzOqgB6H9oUNygKM7dwpc7bRz3ig/BEJmWTrBrTATOGb+zoPFWiu6hiS55fx?=
 =?us-ascii?Q?eqQOa4N8K9dTiNT+Ov3MvJuSnLXfC8BpSdB7nP8uxfGchRim015BCQHkkxrK?=
 =?us-ascii?Q?V8SWpwJye3pU8A+yl7qCUBNC1jOnhGzLvGfqQOpSnZ/UMN5IHOt6xTiIbAvf?=
 =?us-ascii?Q?89wAl2npd9XQM/3xbq9GjTG9+klu0kFIaXe3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XtGZr+Rpo8iUwk+/rvo8pD8tGa0nMdTYgBmdJ3Eccl6pbtAyGrgSoco4PKbS?=
 =?us-ascii?Q?VP5rOUv6fqP/RpiqU/X2nnyV6pmKrFoipYD9d8SJljwewGzogGD15I/nJrcz?=
 =?us-ascii?Q?vkvxZGoxR0YqswniX50JTZBZGqtqyTbpBAKrLTCLr2RPFVVylmOcO3mfdyQa?=
 =?us-ascii?Q?kPO0I24VjZYPRiLp8Y/VXQgnvRasfHplDm+Y3K1ctpAiDc+cuB59g5c3f2aH?=
 =?us-ascii?Q?nZKAiTN5g20cE0KOUMDg9uwNyiC1e0RAqhICNrvDEPXNZGTOUDH5V5kZnoJj?=
 =?us-ascii?Q?YG3s/OiImIlzB2vTCQqjRaVGZdNW6cLD0/R9vt1w8YQ4FaGPZy0141YNtmmJ?=
 =?us-ascii?Q?PCHLAW+8/mCIMWNcV3ppvAdq/nYwzvykCP7/+r9sYLzWmWSQF91fuOWocAyv?=
 =?us-ascii?Q?rT9PQH+hxERVnwjrRkWszxZO8Aci6FCqxh/SPB+tUodetqWln1bnrVNpUFyM?=
 =?us-ascii?Q?a0Gw3sJQnKvszW4OJTNeNcIiE961xMYVPR2HD9uwq5SpDDMLUR6VJMJK+RhU?=
 =?us-ascii?Q?GLwSMap6DABOrHqtFLmQj/Rgtho1//F2pIuqh0ZZj28RGs7qGpeR2Pyun3nr?=
 =?us-ascii?Q?XivSKEsHno28IpgIXQAM4+0NEhJaeTBDcP9T+zHIWWdoY0hzf6BPOzXyMOvs?=
 =?us-ascii?Q?mYZ0KItbIJQPlZwm9mzVgQ04Qk/YWJb1ELZUDs2jnsuW8kCW1ryGcsii7X94?=
 =?us-ascii?Q?N3YhHWOBquM7s1x5NNFmJYepvV5iFPS5crzZ9FAqqKV8iU9y7JVQKdeZ/CJg?=
 =?us-ascii?Q?OsyQyoabdmaazI8xB2CZYklwQtsbRzEWRBP6xFIJWo7sQhtIzt977L5Y1uvK?=
 =?us-ascii?Q?1MUY26eZftbhmUxLW/2BsQZ88MM/APc1ZMXxQlmrj/HH1ws/Aq0Ho5+FGwG7?=
 =?us-ascii?Q?D36edcLNbfxi0h0arIhhk2XhTT6td6+uj0yND8ZtWmfO7wGniH+8vNW1KIPu?=
 =?us-ascii?Q?dD2yR5WXVqfIfxL7GjNR1gz3ebiLSjDtZ+mzfKleRk34kK/KEry4yUqFK4FO?=
 =?us-ascii?Q?K4zsF21LieNIXqXekupNK+rgZVzxqmsmgeczBqrayWW0BPpTx1r/uNh/+bHF?=
 =?us-ascii?Q?46cfpkWzMNbhQkJ3hqBa6zu4a52W8tAQaK27i6UEUwXp6rEe4c+1Ypa8bnu5?=
 =?us-ascii?Q?3go1tp5AXdHH+ZZy/VKOClzpvX+zMDfIQJoHzTm3CG1srZkW3hd4PZ0nTfaT?=
 =?us-ascii?Q?5Ucia3/Zrn27fLU3mTtlfCgGmQX7WZrsPXuyd0HPMK3Gp5eh7P8NqeJ9bGnw?=
 =?us-ascii?Q?E0hQWArrR9LW3qAAs6dmX/4WkqoQJznWAJ213OK8mUDP0pfZNWZKZWQf0qF4?=
 =?us-ascii?Q?497nDfDejR4dbe4vCv8plPdevOwh3+sLd42CyfyDVbELP7h11zwFX316zsJr?=
 =?us-ascii?Q?EnOIzfj/2QdNeA7Hy013iOgRfF4Hly/uz95iv5wic64AMVT5sv+dqC4oDJ0C?=
 =?us-ascii?Q?mOFm5nJWf2z0uNv08t98MULrFHgCBCa5/mu3sGs98WbR3/cdBzBM/W/1280o?=
 =?us-ascii?Q?IGgSV5qizMe5wB5fr4RODzIFWZsIYg382L1cfRmny7In3zeYdQvetAuGn7nn?=
 =?us-ascii?Q?tUvVRhREAOJZ46UuDGw2j0Sich+K9ghfbFYmX/dv2oXce9okky0/0DdYdIXk?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1711123b-8005-4ef5-00c9-08de26adb9f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:21:12.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZKyfQHjIOMdETcyUAczTM7CV/6MMnO05SR6YoD3rowbs+UvRfW9hXLZERzsZkHWuZWjPWYspemoYeVyy9m4EVYux/MarLU0xlOFjLIRYNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10179

This adds crypto dependencies (ECDSA, ECDH, AES-GCM, SHA256, HMAC)
needed for TLS-based secure host interface authentication and
encryption.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index c5d45cf91f88..ccbd2e13977e 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -493,6 +493,13 @@ config BT_NXPUART
 	select BT_HCIUART_H4
 	select CRC32
 	select CRC8
+	select CRYPTO
+	select CRYPTO_ECDSA
+	select CRYPTO_ECDH
+	select CRYPTO_AES
+	select CRYPTO_GCM
+	select CRYPTO_SHA256
+	select CRYPTO_HMAC
 	help
 	  NXP is serial driver required for NXP Bluetooth
 	  devices with UART interface.
-- 
2.43.0

