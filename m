Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA92178CC5;
	Tue,  8 Oct 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378658; cv=fail; b=Q/1H7PGSRz5Myitov6511f83ektMIH97MeYJh9dpxFLuqSbKkxwgCq6R//nDFkawlzN0NUg5/4gX7teR+3gdrTjDHCydqeG/7JBL7ffhuqrHRpwCrVdmAFGzVDmJC7avS0o1VYDNXFJTlGhQYoedcjJ18Jhf7WL6VieCugynApA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378658; c=relaxed/simple;
	bh=AbADff0WuzI8qiEOAjSlKjIgfjoBiz8i5whiFpKxFCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hm7VY+QWhezf0viUeKTI0w8ePVQVQT9EicMhycvixpxV+IXVp3802or3OVXyhFrz6+cUeiZkrYw1eIK50sdMRCn3ticcF8S3IIiWnXkTK9QKOx4X8+L2dfaurr6r5zRxMwEN1N70G6WsWwm6egu497jSzL4CNhev+/BW0VJC5Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A6p0qLtJ; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A6p0qLtJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eQyYw2vdn+u9HlNOIo7WJNhh9jRVlQ7z5tWY3XJXrPgMnLZCp9S4k0spxQx30+Lg9lr3aqKQVrXtBjO1MnwtRyq4A48AFFE8pIFh5zqNGk04PVJPzr4PHHmiFcaE5Zop/Mx9E2YZfduUyFhz2FNIPlKMJ460XgshPmOLEnQTqTEqXGOSzz7vc33fJ5VY9nGszX4dRMkgJBy9Ouwda7PxQ35tTjEmQZySwAjpl5+zJ/3y56g+K05JS4SYBRMOW2sUAjR3nrUxpyCE82OstOtKqz+Ks4R3+tepm139w6oO3QEFJzqHU9Ym7QEZ/g2XPxyhmPQuFtPqKggXUyC2Vito0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fscn+LlJB3G9Ni/ragW15/byPX5JPkpf8d/ugCTFEUI=;
 b=aZjwrJJ44gNJw3+/qRM/b8NYfXDixmPhds+7sBUEroBP/XmxJngjXkxYjPZ1DXaH5wTv83HKbPb+n1TI+nOHCOTy3JxNzTB34rHpqEzMlGD1kpJ33bX+H3YMh7R95VKTYen3aUx3o0N4+U0JE95MJ9uBgifGEzM+XuK2iBS12CPtM+y373zUXqrkAQnSUKh1f6YnXiRl0Bzqkh2AWIbXEhe5CGmWpDZU35XV6AqdUpntbgo1ga642m/O8a8ZP80TGlyUOkccND40GeBa++Qthy5GbgFzI4gbTbBmZ8DsuSQnyA95rpkF6fwZDxqDGSgglit+N/ZN1UQKYD5PTraGUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fscn+LlJB3G9Ni/ragW15/byPX5JPkpf8d/ugCTFEUI=;
 b=A6p0qLtJrnj9krLA0sksfCKbpDR6JKvbWdPdQkO+6G2MTsNkA3Ai9HkukLOkF/Qn7kJPu1RH4RvKXWQlXO2yJDg/Aq646/T/Mj88KxyDzTtJjnf5W53h07U3I9QMFAm5+ed9ZKC99dp5Q8CBMG6L1WygzM5+W2x+0rlUo3w1zZaL22fH0QYUDf2H2r55MXPNRd2S2mHyZZlMLNjpmE7bQ+mCP1980mHDvXtsguho5o+PhTYz9GBcy3vLvusWPAAyV1Z1L3CXuPX8jKjh6fVekHGDbf74ZljelqyDPqPlUDNxv1DZsHXr1bnkacPJzZU3dly65Lk8QZlYuaco+ge3gg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB7544.eurprd04.prod.outlook.com (2603:10a6:20b:23f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 8 Oct
 2024 09:10:50 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 09:10:50 +0000
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
Subject: [PATCH v5 0/2] Bluetooth: btnxpuart: Add GPIO mechanism to
Date: Tue,  8 Oct 2024 14:41:57 +0530
Message-Id: <20241008091159.650531-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: 824de24c-b1cc-4efe-6088-08dce7791ac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s8268m0/+RKmYFVZw5coQ5Sbqb7EhA2XvbR1MnfzO2szteISNMtoPr+ilTq7?=
 =?us-ascii?Q?VTP4G8hOZM42txfA9cK+rDdsYPL7cUpkiHrWv0idRfFVhK9azYTPQ6Dpp1Q9?=
 =?us-ascii?Q?qTmIps5TrXzTIVw+suXhiczY0HnkQWoz4uRpCH1zloOwl+9cnyBkivdFKAfN?=
 =?us-ascii?Q?k7pMGzYkZNk7+ZU0It95aqlzP8U4m63605ByInm5SPEsYZmodZswBaVlItAK?=
 =?us-ascii?Q?p7UEe4XPYDE0QuZINNntZjBkbTo7q9eEmJfpHyNMUzTI/0Hkg+n+eJsJyZys?=
 =?us-ascii?Q?FFrI2yHP4/dvVj8wO7iMGArg4w8u1FwGe69Fad2f3KsKPP4pE1eQvuxJEapN?=
 =?us-ascii?Q?B7n6mzSoUBabhncSM9sglonXnnhVIRm6oDneSiywA9i/CT2iCcdrJkvoWBhN?=
 =?us-ascii?Q?K1OBHcqS+9LMSLI7IoNM/AriE9Y50zqYjYPomt1KKdzYk4bM6Xhb2GJaIRjt?=
 =?us-ascii?Q?0bFES7wcWuualHcCFy//uP7Ilz0+NatvoF9kJo594BD+ctxRLHTr5DHqVV1Z?=
 =?us-ascii?Q?qciAubN73HRfNFe7xLza1xZNmrOTdy95lMaVzDWfvFMf4b+gvHiTsbd+yora?=
 =?us-ascii?Q?rYgdmjidy1sLLnGq4hHyr9ySGiG6mg0czaJQ8RaIhKObyB3T7AgwUUI7yWJA?=
 =?us-ascii?Q?OZatZmb9lq7GI88BWQe8h8PIhN+fX0YYxsgVxCHz4e7a8Fg4xgsSUBBE9NAt?=
 =?us-ascii?Q?Z2ch9Nuqq8vH5fdhk4Y50MU9kRvOzjNM0vg4iDwWKF/khKtlhA8mlV33hKck?=
 =?us-ascii?Q?bPXFUgGPLD4Bgc5qEnrYhL42/jiVDDY/Yg7Ij/5lJCpn/EwxfmN2ANw/xjSd?=
 =?us-ascii?Q?fExUZBD7aH+xCfYjPgycRd7QVAPE7i9kNzZBtekp75gmu15s7oMr2qzO5MX1?=
 =?us-ascii?Q?mY0P9rbO2TnwNh37ngOIa/4CqG5UdQ6k4TJPIld2nEnj3Fzp0vSW2hyAQpKe?=
 =?us-ascii?Q?5D88OOXtvxZ88tfzLqXbv3FlrHEur7T79lpX0zj9yWZI/6nJRpBdANM7Wm9k?=
 =?us-ascii?Q?D3NOQNb5BKdcc+JmBMRdJGWLnEBrJr26brERsG8a9oPUCH87ofkp2yxzx1GE?=
 =?us-ascii?Q?FbNkzXnVhw6azR5NjFmBjpEtQrPt0DCvpk/zNCN5ZZoQgSqhIycykrs6Yr0F?=
 =?us-ascii?Q?R/+fcsM5bUP3raTqUcJa/UKMHPHaYB6m1D6tPr1MLbkBh4lfK8vka4+GQPsa?=
 =?us-ascii?Q?/YVD4RtYmp6rtbAYoipsNXFYg2k5vMODaVVqtXApkvPc3fZGCGIwQQiLybG1?=
 =?us-ascii?Q?LKfuFLHXxqlUwbb1g8bLEBdyZPm7M0eHkBGMVVf9NWbg4Qi2mraPwzm/+2jG?=
 =?us-ascii?Q?uJpLY0qW4JKWT4fggoVeqWAeZZrNX1GS9jCT8fev9BS19A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eims2BMJh3QxrPYbluIJsBYIsVIfn26IC9rNXhwh+Tt8A7uOCZEQtWDi1XjG?=
 =?us-ascii?Q?/oDCMI9EMLjuM2kZkRzfekdPVcNlN5ArBRo6NI0uQPXr3iszrYqDKaIao1NT?=
 =?us-ascii?Q?L16iXglbez9sZsbCsTHPOXXuQHqavwO/GqU6JgjR1JzKXO0LMOOM/GBzkt2p?=
 =?us-ascii?Q?0qbPS+PBn5H6Pf4cAZoXTnxTcdNCVk66uFGNOGg+tYAEpYHNiksYPApSHbf9?=
 =?us-ascii?Q?GJBySJmrAlgt7OIDuJFCCGoSV9T4hHf4ic72wm8HdpE8T8jEtLK/gk9DBAYM?=
 =?us-ascii?Q?fVgp/KMmec+TKjShnQ7qCKtGtMhYpl/BJGG6QT81b6U8h90cU83oSriMf9Sj?=
 =?us-ascii?Q?1FvGzF1o/0R70+NXOXO+NapndTbVHFL/hORgjQOapYXMHYPIsqKVfeiJeoPX?=
 =?us-ascii?Q?WtvqTXLplwhSbB+1F6xumfgK7B6M3lNQouXcC8tAV6yqUE3vTDIcGls+rCLV?=
 =?us-ascii?Q?MXB2fFocwhFR7ehajg6Tiy/Jfxzcs3ZDXK5MrXWD3LgUh5zFQC51WSClkamQ?=
 =?us-ascii?Q?C2ehpI61uUPv8j0pYmB12ENfEx0FtY1zelT236a0QkQ1JKM4u7Ad9LpjQgPu?=
 =?us-ascii?Q?6sBOVJBKPSjCdN7Fc04KWKPBtoq+2j9G9HDkwZmKVDfXDBC8hm28aGc2tgSe?=
 =?us-ascii?Q?c5bERjVaS+8GQS0YqRGl5bF/hVlQDlUt0S+sm50nZd3oVho2Ikl2YN9l6ePE?=
 =?us-ascii?Q?cPpXvFd7OdNPzbVwP8ypneSNEFqyWAGJj3v8DykQ+XIgJ5cHVURulaMGlqnZ?=
 =?us-ascii?Q?sptmsiJbhQnhl+5RiSFIxIUSNQVpLzgxF/0FRtkMejSLX298KPnUEuHfpFiP?=
 =?us-ascii?Q?LWImjcvk4MAVN0tSBkeC7dMlMeY5CRG/YF5IUGH0C2FQZuF1d6WCC3fskAtw?=
 =?us-ascii?Q?3dzjumTY+EwFD71udR+6q73vMFLZC7L3IViwTaYmHHKErh7Qsamb/gmXiFIJ?=
 =?us-ascii?Q?M4S0JtCp4LeAj1bV7zdd+I1C+yJZtz3W0VqlisXC5luP+ffahXcYKpOpej/n?=
 =?us-ascii?Q?2F2Zl36x6/yEQRley+GlxuGkjbNyApjAX8aKyuDT1y7LLGQlm671DaEuHSEj?=
 =?us-ascii?Q?e82P4vyZnCet20kwThBIf2RGxhCtmG7mEio2MuUifSsjCjBzQT/s4GHBPQNX?=
 =?us-ascii?Q?f9+k87dN5YzTY3HC7kQaqb6JJOqhntl2ETTXh0BNVflQOe/z0cesK6/JqUi2?=
 =?us-ascii?Q?NN7l1QEthEKQUGUG4UcsoiUZN32XpJD5QsmuyQ1LLF/I/C3HMgLFOgwgCIRz?=
 =?us-ascii?Q?ooTYeScc/TCb8UHtErwiuYOgQqwsFOxdWdOjDDvAZGfRe6XOOzilD4QiGqEH?=
 =?us-ascii?Q?s+S0R5NaVKPYPyhNkfv8+NvbhAy/81Qt44swchJgdaeX9F5R1A7adJ4lNdY3?=
 =?us-ascii?Q?qJgzFfLUxlpfXgKLyQBZPWQZY5e/Y3H6grr6qBd5G2hReiOTTjLcKKe9HDJ8?=
 =?us-ascii?Q?0jME7rSl7bxToOkwIuyQRHc+iuidq8HB4VYHqjtMl9EsG9E15rG0oMtZFfMo?=
 =?us-ascii?Q?fsOebwnlalMBqFR36VzLtOYQIzlhoDSwBPz1idTjqPTLV7TgvnagAbJBcN+1?=
 =?us-ascii?Q?UwizRenAyD0Zf0hx4TUDebMC/pbPJRXELXeWnF7Efxuj6eTnAcFZGpecKaYu?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 824de24c-b1cc-4efe-6088-08dce7791ac8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 09:10:50.8680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ITKUegy53ZdmZte3eKcAu2z2iLtTpmZYh8S3R18NsnBOCdAOHfRYtA3Mw1WwZdhUWmB2EAAQscNDwANE11HPLWbH6eklgJVbDbJDHcUO8Fc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7544

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

