Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929FB1D3586;
	Mon,  7 Oct 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306741; cv=fail; b=U3lhzN8olTfubDOUif4W+0FOLJJDblu2urTa299r7XhrcdtHnVGXvOkjzuoSpAx4tAcaLxtQQaMvmnI1LKCNVrATWWSlhqoxgyhGf2Gbm0d1h0R0+GWdIJeNGCr8s29L80qFQd48qoshF8NKsWliKrMebbLpefcWhIHAbIme+Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306741; c=relaxed/simple;
	bh=AbADff0WuzI8qiEOAjSlKjIgfjoBiz8i5whiFpKxFCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k9gb3gak0sCnpAr2zPfh3aPB/me/i6xVLk/nXDpub9c06yxWzOWgC8y/KtkM3yJxHsD16UeneZq4GPPaws7e0APZuidw8ZF6J5ww6QyKL3R2lEYe8MZmEAJWgaekXC4VW3ZqwkOO9oaaUSaA1T11+MYFNiePU0696g/Y3u8n6+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=M6irg5EJ; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="M6irg5EJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6G1W0phOi8AkBqipXXUYJPSYFrxfNDmf+qpImXIcHoiV8t5WfpDNJjXtrUJU3+rgrblNlbqlJDTOqtOdCo8yUqgy3Brx/yIQcaRn9xT2lBSwJ74eWaZo5Q9vZ+lqHezvfzde+loI6V4q/Bjdat5IDARmiJKHE16ndS1MGIMxkvJQXCTZMhH29jrjCJkdZqdrVpUTt+7+GZHJbaIBdvIJ/E+Qwg/ajvTfG27dOZisEYPrLDXpQFZhXT4gxJ7P+1vvccI/8PzmwMsitZgfC4ypejr0NYTQ5Wv3SpmymVvql52IMJ6iN767lR5JMFNvEHItaKN2rb1a8VLi6nS9qiruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fscn+LlJB3G9Ni/ragW15/byPX5JPkpf8d/ugCTFEUI=;
 b=q6WsBU0LOMh60KIlTtP4V+CM/pqR9JiXxMpEEPoJygr2vTAY01VlNDT94epbal+gKn4B6NdYaUomjEDjXeL/APOMYmBiP2nlPZgttdUb9fDT/SLXvjAwyU346dBaphQQtbwp7LBIc2iA5MYQIX9NNpe98oqir6ZLAlzLi2DDyqBqiU04D4NpIvL3aGtCtRrm6HRQysUZMJWJeU7gTbuG6IJkIhpqEUSOPEcQCrQf+F2XrcUxOXl0X+Z8VF5KFGpkz+CKmf2BBbCgcE8VwJ9LjbItcERiDZYOynp+9vC2T5+H0peOrs60wGmCFCrms7vtXgstxpXItKDD+qeWKzI9Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fscn+LlJB3G9Ni/ragW15/byPX5JPkpf8d/ugCTFEUI=;
 b=M6irg5EJStQVJrC6jy0VZf/YBZoTf2j8QONFj1C51XKbYkgVTTw9tb4fUPjDlX6kP6MvB0xbKzupZB+aEvWinMZT0KHdZJ3+yvpMo4Y2HAqRnXxqOlKJWPZnSElyqwOftWAKaHbsnxuG3xDY2J/K+hC2bWIxceKc2kda9Cy15xlpZNctUf/YZcg+7XG4ja7puTwqvNX/hPjzp0JTIO4b5VhJH96pOCyb096toVgjPvIGe630tRN5FkWDuE1j6StFGzXJ5+H3d6YqJ+ST/+GaY/Uv2tWosOx4O7noz8RYQ2lu0K/BszHrf7PMCLIwYN72GeMxzy7o+6/99Fxicd+E2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB11036.eurprd04.prod.outlook.com (2603:10a6:102:48b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 13:12:13 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:12:13 +0000
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
Subject: [PATCH v4 0/2] Bluetooth: btnxpuart: Add GPIO mechanism to
Date: Mon,  7 Oct 2024 18:43:14 +0530
Message-Id: <20241007131316.626690-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 9eb78560-3798-4382-4a93-08dce6d1a8ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OSV+ylgdiWK6HBeNA1jMjg7GLMIt9Po5md2SpoF4Nh7096WcpLx7w8b5yM7g?=
 =?us-ascii?Q?RMnZq5Pz6lqpCJ1aM5uwCL08dGtq/FhTznYebgbXJGuLTx2tQ/tmx7iju74K?=
 =?us-ascii?Q?jfptTnExq27LBRtTjscwgxIz4Xq8aV0YTKhQIDg0lloyftj5k7tOFP1OzyrZ?=
 =?us-ascii?Q?jZ+4tPO7oP7OoOqXIwbtAAaqSZurpXqZYOTZpAv2Y12vWlSNklnKPZmHSrg7?=
 =?us-ascii?Q?DxCPKZU9TVugkvLOkq03mgV9BcktjUAyQVvr8lE9ca5fY7go8khJyZFVFYV0?=
 =?us-ascii?Q?HkNu11tpuFu399ECAgZE+ra5tXTGQ89uRs1kRHgiMJUztecGTsYmfZ93vjCk?=
 =?us-ascii?Q?8MVl4ad4TWXJqNd86Dppi0qE4c1SsW5YVYGY6XLs4vFW5eQocHQ7Z2Y+yjgS?=
 =?us-ascii?Q?9XQH1VHlHJmvMvCa/Pa1906cDN12kdQplHF8yJKvrwGhA73iljbMopiE7kO7?=
 =?us-ascii?Q?TipKy2v89CCmtCsulwZhylavIsQCodp16D+DtdrTvbJ6kDhxedUpb7nbUwuj?=
 =?us-ascii?Q?DpCnRb18I52WrlJGKIfWF8WjrGXXiHqH89G56Sf8ChkClRInkOlfJVpO7nnw?=
 =?us-ascii?Q?E0Ih7YwK1GngP/qssGJINXi9yS1B1a8WPktPk0+0VMb0cpWNOz62RUceh7Qb?=
 =?us-ascii?Q?NO1ppLAU++2YQBuwY/hX1Nv+SdBzhJXJ34r2Gmdol9DxWyVlj6ipvxTtVVOK?=
 =?us-ascii?Q?pKz3Kp5nFH/5Yzx8ck7tlxQqY6GHMofHRqdHA74kgD3tdqlYM3m+ID0tM5/f?=
 =?us-ascii?Q?iqvpWwyr9XyuroguwpoK7UmBq1pQFsbuJDPPuIFjH28i8FmKeg5L4WTw7tLB?=
 =?us-ascii?Q?v4PSc0VrtOaQUFZi+GR5ZQCma1LSwJ9SHmPNkVn7zEpEu2ddsKdNtqjydKSR?=
 =?us-ascii?Q?CJw3S9XUcGBiCCIlDMhqPoZJGuzV7LzNPLEYQmiWaGOp9hB+ToHkS06M34Xw?=
 =?us-ascii?Q?QxdnHP/ZPdYSdP95d4QdhV83EjhrLHebPJq67UajJoYzvqLvcWXTTMXwgI6f?=
 =?us-ascii?Q?BuFPY+pVKXQS7x8jwvIjjr17VnwecKQUG22wwWZNAYhVIjYybnvAWa3CfPAl?=
 =?us-ascii?Q?aPmYYY9+JEMkPh1mT3sS5AhtbtV+x4l8UBjMj8ivo1PiyRcBJ/+bDeggADst?=
 =?us-ascii?Q?Xgn4f6sJ71x5mHwgWXVO/cSWPPb6VZl13FOaN/g+6EHAg/26CkSs8exmnwmH?=
 =?us-ascii?Q?kPh9zHt/aCcDWzyZBQt8iuWo8MnQ4B5ROcNl/pxaVPeJ52LKujVJyp2vvrUW?=
 =?us-ascii?Q?CNNq/gZCkhcgxMqvHg/0we7EP5SwbOH5ScZN/rZjVIUUrihxABUv1oCuDJiX?=
 =?us-ascii?Q?Z+Wi2zKmHaVKAEVIB/SD9deBedbl5eos+FhELahVJ3SnAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z1wrkPAka6ItamIFo2D94YBYecY0Eyslo9sfQ2UPV9iTAweNHzuvph5RhT7g?=
 =?us-ascii?Q?7OX0afoepJo4buBgBew55/ybg4OCTZ4lgE0gJfrUzpXD+CnyknlARZBy1sdX?=
 =?us-ascii?Q?tJtNRytShZNkWXNFudbaztPPCfZyEr8XzaWcszGSCQIaoqxgF72EikWP1TBV?=
 =?us-ascii?Q?DZ5bsf4OROKpyqiqxjIpyeu9igUKXyQpOzp0Ings4Dx6SjKwizHdFFP6myuy?=
 =?us-ascii?Q?Pi9bO6Oob1hZ6PgHzQYbUi/OU8881aQWtEuymZtC5uN9jRxZYA0ElXAf/eWK?=
 =?us-ascii?Q?GpbOkCrZcxbvO+aMEHpxQho7aG+idN+x4cxl2TgdhdeMYz4CPn2u6lISYotH?=
 =?us-ascii?Q?JM7arbmrM3vPKKJzRzJb+wPt3wDEk0pR06JuhKoee0YUaiPGJaPnuXKlfp1u?=
 =?us-ascii?Q?jwOXkq7/PTcphzSsex7f2DiIudACrcPOJPldXNERO0isBHt/nZAclMuEab3j?=
 =?us-ascii?Q?ZtWEV+iDI3nBFJuyz3Sf0tzyU7RLWcLg+ZfdcIyn1JHOlL++IW72p0lU7ETw?=
 =?us-ascii?Q?ZmRsiOsalOHnjotz2K3k0xnnQDjT4oQr0j4fanUwDEl/op7wfAAwisXHyawF?=
 =?us-ascii?Q?7mkUxqXyG1aq9nUOJF4FHeE/37aQtSKVx1/etuqltjafj6IYlZrVw8h54eeR?=
 =?us-ascii?Q?ExW+V2thbsejC8K+vXHCOsdZRwKsSpFrh5K4PlzNqOrT0YmBHFiMDamspWDN?=
 =?us-ascii?Q?+dmbTH4HHaHzs5N1Tc4RrqjElyoyAxCSso7HlVBJ7/F6GN7WbgDSy53vrreu?=
 =?us-ascii?Q?UXR/rsCnRmp2h9sqEF+JTbBhlGB/gnw1I36GeOmdxOh+pHtj1YQdkTOiwEe8?=
 =?us-ascii?Q?L0piXfFvUhJDDrUy+0Ttq7NcjgSxMxTpk7n0w3MNxZrc86sd7HvzoN52ARYK?=
 =?us-ascii?Q?swyTn1R9gjAG1viyR63prMVO17GVxSvSYIcGH1KtygrXacbITMKjC9SgHOEY?=
 =?us-ascii?Q?BOmlMjUXQPilNeIDwLBQGOpKgCuMwgXd3zGM9lQyr7doB2WAr6NT7SvsmW0c?=
 =?us-ascii?Q?JiVq4f5LQq3a+jGQm0kK908xk8CuvpWXUXodxvRCv8Il/HApPOksThz/HzC+?=
 =?us-ascii?Q?0hSvi9l3zbxpTpHshKopT3KDBD+iBYvwFGole8spTsf/IxMGfFlwhi3ltVzw?=
 =?us-ascii?Q?UTWEvb6h7pvV1x8K5KImSrzc5u6Y7Y6SxmISZBrHbmKf36N3p3WMTrFaLXQ1?=
 =?us-ascii?Q?2t7DaPmlHBXKJ713JRHsyV9NRUEWX9uVC1D+WZhNXBqTqrAx6lTCeDQ0XTjg?=
 =?us-ascii?Q?a+dtOy7QJDqRBconvHQQXKQ7ARlj3jyG4d2vee3LxSJG8obVzg7jFIz+/uBE?=
 =?us-ascii?Q?vyI3GPsvpDErFX9sOCOLFyQnoBacxA7yQVGoOYZwxL4Y3j7n4McEFI30YU0T?=
 =?us-ascii?Q?fhCBQkwl8GYxmcgYtC6oJUx41Efh82aJPpFsKhT8DCLL9dXrP+XsY9RyA36I?=
 =?us-ascii?Q?tYh+dCKAwY9fA8E9bXE1AFw430fY1vgmBBmPJufqje7rb8FrD/NJRF9y/Yy9?=
 =?us-ascii?Q?1QBoEXteCimegWIaImR/434HVwHbLwcgBmppxItSW66Q7MknTewccpJFrXWR?=
 =?us-ascii?Q?izj8guRNv9aZ+cJEiYg0iBgLhuPUYlmORoIFFwkFV5hc34NnLnxlJg5bm/JF?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb78560-3798-4382-4a93-08dce6d1a8ac
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:12:13.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2IU2l7Rcdodunl9xB/CJDZtdY5UmoxM9UtTiDMpusLdXmSEROsw9UvyTQehjRsbrYgS9pZtWl0HvCdKYymzhrwSsm+07xhQMz5yM/U7Bls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11036

This patch series introduces a new optional device tree property
device-wakeup-gpios, which specifies the GPIO connected to BT_WAKE_IN pin of
the NXP chipset.

If this property is defined, the BTNXPUART driver uses this GPIO to put
the BT controller into sleep or wake it up, instead of the default UART
break mechanism.

The vendor command parameters HCI_NXP_WAKEUP_METHOD are configured to
use GPIO method instead of UART-break signal, to inform the chip about
this new mechanism.

Once power save feature is enabled, the driver puts the chip into power
save state by driving the GPIO high, and wakes it up by driving the GPIO
low.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>

Neeraj Sanjay Kale (2):
  dt-bindings: net: bluetooth: nxp: Add support for power save feature
    using GPIO
  Bluetooth: btnxpuart: Add GPIO support to power save feature

 .../net/bluetooth/nxp,88w8987-bt.yaml         |  8 +++
 drivers/bluetooth/btnxpuart.c                 | 57 +++++++++++++++++--
 2 files changed, 59 insertions(+), 6 deletions(-)

-- 
2.25.1

