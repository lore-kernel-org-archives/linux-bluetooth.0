Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AB218DF7A
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150612; cv=fail; b=tvqA0jtWD5kZH30GBdKagHyPAH3YaSpeQrgXIqFcwssfj1z7WJ05jkmuch6lAmy7KG1Y1yINNSVhU4inRXq3KGG5+R2qlJgoXPcOzcw0L3rz95CKMnMdUBlNvWwM5m7ubT1mkVAiVdGtWtf5n5O1DcaRxT8SXbSbVV4EvRz7udY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150612; c=relaxed/simple;
	bh=IDLawUEyvX3s1kl+lmawmPvc8zXhR0vZvVKZhYumhdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EUzvfVVQH264xOpHVjh1Xt43cQmsYMWkH6uE9c/iu5Q2Ti//3JfyWPFrWhs8SKts43kECtRlyCLf+BxpJynqarF8GeoLkmAJZX32FyveqSVX2566pdPMR/aoG4YGAXSN/kNQBvOx0CCgJH3uKLbINVU+ASoPnPUkLDth74aAx2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R4QtsO7N; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R4QtsO7N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNA5so0W4x6ysBAfyo3gT3NFf/W+FS8CqC5x2Vj4J9/lu68aMW9/z+PxdV1ngpJGx/L+1FDtLJQOOlsjeczFRwnHjqAPeQFTrlog8uwLP+TnUeqlz7GSHNxfuKJK6euVtyex/rOp3zXZ1la1XFNYOquF2HMl6BFTqjqiRl6H9THN68SmygV0ldzU//LYjmlLC+KntTRDlxG6EKkNdcpupDKzjaVsGYyHRI9l974sTcLOtG65eFDHSCR/brPVMPalCCmG5OSgdJzxtodVHkNpzjoOcUfu9KxrH2lrHQ/f/Hveq6Szk19zhrg2JPCqG2aIGhJPkhUWEx1speTozJJpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yi6f/mQOkXTT2HCAmu98ROPUTLGLhJFYiPnzUa3oRGk=;
 b=TXAoywYnmJcM1SwrU+3yLC0J7VzJJU7fRRXvwkUHTyd7cwMzlFNzCeT2RSQeLXeN7a/GRNwkiWkGVMAhhecJyJDSpjTGJBcg54eVHoxpPJfhXV45QRw6yGuk4TZkAxkEE8kwlYho1SfK9nLU4wv2U/SDT9EJ0y6KExaGOf+GQhtJJgjgnDCxpIj6bQmcaSmiV5W4AEBcn3scow/81mPs1JeE9FDiofs124R6h9FCgrtwcGqbBGsBovlf/2+5vGFG6R7tqVQpAjRbDb9matIHDQxB3nG6ZJCA2zNEKNePd2tdVKPfwSwvfRjvDsxeykLhHT6gz/r6EJO8qQbzofnAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi6f/mQOkXTT2HCAmu98ROPUTLGLhJFYiPnzUa3oRGk=;
 b=R4QtsO7N+ANpAOGZCTsY872pnc1TxfSPT2sjf/7t8TdgrAMSTVzt4jpKeCa7uSUap2uePiKY3Q2WWYsbK46RTCDCalUeerdON3TmaeVvVg4b71J8oAZDMV8ZQIqjIKHJx+LqRBgf1hwbJIf4ZNxn3bJMCbi/xg9EnSqTNvU/wPBep7k5eaPHwOuHyb/KBWcHc9fl/FQY2VjHZRT4Un4N6RCboDRqD0aVpuHXmyRc3zsu8KhCDj75os/rFlppokuEjKRq4CnpiNFzlJgPTgI4wVpwLHmTrAvfTeV/zsnQsuKdXQP3oKY0Cw/RL4uE0YYCi8NQEe0KIP2rzrbIjdd8XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Tue, 20 Aug
 2024 10:43:25 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 10:43:25 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 8/8] bap: Refresh qos stored in setup before doing BIG sync
Date: Tue, 20 Aug 2024 13:39:18 +0300
Message-Id: <20240820103918.24246-9-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
References: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: 126300cc-596e-4c5d-dd8a-08dcc104eb3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VbsqjKExt7xTFCi4ysMTbJ2nWMQn6HwO5Vv3SmFHw1Po5mUwA0jVeZOjAEWR?=
 =?us-ascii?Q?KHjMQ4pip5WDbVyyU4ISRNKGa5GovIoYkdU154U/243mZnyPR8JtpnSYCCSC?=
 =?us-ascii?Q?B18cDY30z+FCb7BqbjbPPPhOU07xzw+Jrupg+T8nj+sywBaXnBvcE6G4RX8E?=
 =?us-ascii?Q?X27Rh24wAiWrpF2TzOJoAMDMR8bjj/l2PdJlWsW9wCuWZfFIzS0Wlh87kNca?=
 =?us-ascii?Q?zufTlcpn3mHruxpT/th+nKSrrmvzWYe0XE7Jua35VmlT+GWidQcjyGprgx+C?=
 =?us-ascii?Q?kqXBDeRXx1O+Zl1hNb5/gpR7zNAEWjSNzman0Bu+YoQMTk/voi//4r3sXMPD?=
 =?us-ascii?Q?ariE6xhKmfuoUV+ItkanYCRMXwUU6W/021MeFENnh6tbu1ddLmHXkA3uxalt?=
 =?us-ascii?Q?+zKRcn5VXnbiF4428Db1HrAARSskYIDdouOXW6vcbcjwp4zyUX8IQN6jHztB?=
 =?us-ascii?Q?+olqmOL0nL/1FfqUHvUjkf0ucLPlDHoHRnOJIVal/GADivXvl2QOU1TIUMZW?=
 =?us-ascii?Q?rQRYUafIl5Dq7z/cQn6xfrBH3psNiZyuiKaP/1IBE1qYp0fhug+mjHbQD3Ec?=
 =?us-ascii?Q?DG1hEIed3m7hY0w+CpEVT0z71kMB5kGRNak7T00vgIWuU4TKlmK8IuaI/1bN?=
 =?us-ascii?Q?RFKJLpPPCJGl+EFtTz/+SpmDv3CL/f+QK7mx/Bxt4sowEZ7JrVNUnxq/Qn56?=
 =?us-ascii?Q?58xmK0x0d6jYBRNLscNWaG9URBwDQq3QJXO7bbKXWLjiLHBw+qwG4tDz9odG?=
 =?us-ascii?Q?hTt2O4Fv74x4iXP2HIGeR3tBOvM2Qpgg4bhi3n8U/mt8/5JmDlUUDCxpigZi?=
 =?us-ascii?Q?UM2Wjv3+rYHr+/dOdglvNbGFq0k4iJV5V+xFBHQuCQxOK3G2nyJzNUPM/vhN?=
 =?us-ascii?Q?vbG3uRKLvVAFN2vzQWUHPzwc7pFqGNus4PsRBxFk+y7xfECFbaMYUQNFKlmM?=
 =?us-ascii?Q?+cTElrUNbS7MYpFNva+QvgSQdBkYeyAv4yRJV7EcQOk+WbMKQLjZH2YbCeDH?=
 =?us-ascii?Q?gloHsvQnhAfYxoU6NWx96orbKyrNs9mrQr0M9CbkD1kaGBiDmcLrE1tpzM/P?=
 =?us-ascii?Q?a5edF9CPBmsZBMX5gZcc1yiLUjuP2Nl94hDR2jgcezTenF95lLhsbkCbIhuw?=
 =?us-ascii?Q?Yq7c14QS53t96Nv6NFOS7k9scDB2f+bjQsyPnnvzeQYSuZoe90WPbldYjb1X?=
 =?us-ascii?Q?UCALQ8JcwMNZbXIOiKqA5M/jADuFkazNN1X0EO1C9DndrhLGe52rGjafU2t7?=
 =?us-ascii?Q?CD9dsaH7KPcdDPKss8awW6WQLELBnTS7EsFGhqnoZ3IlMbV6YLQE4QeqKr0l?=
 =?us-ascii?Q?VaoQZ5okgYzABmfyZscvxJaHP8K38igwHRYF1tLU7URgwaWLMrmDHeTLe3Kj?=
 =?us-ascii?Q?+wIjgeflTIg3Rbv7wNtbHePq4OjQyYiNQLC3NYEp6c2MyPX2xA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tiJUQZaSagLGHipKAiRvK4w5TsVNa1powcgIbwuCEAbPSD2qUVxsx7YQzxIj?=
 =?us-ascii?Q?NOwQLDX4lCRJddzStbT2psJKYeTGFibIH+VFgLtBbcv6sHV56MKjG1ZPiTPS?=
 =?us-ascii?Q?20yMqnUddXoh3Eqdq5Cqj8AZU6zTtZBCdkN0o2c79BHdj6H79HvvWhaKlX2y?=
 =?us-ascii?Q?+0Ph41eroemkHQ1mMq6MtAhP3U4a+tHj3i6EBczLZChtKLBK2kN513CnbU87?=
 =?us-ascii?Q?4GTWu8sRIBcJ0ncrnKyic66N3/wo0KUESxNvkDQUtQNx4/GPdlBtgHsnYZyg?=
 =?us-ascii?Q?FsUVD/zKVpBkMh47MdviTLQNv80xucTE/Qq4J20x/adQJz9w5Ml5jiXCSKpm?=
 =?us-ascii?Q?ru6f6xjDd9CNFCtIt9YT/DFZa4+lZ5c1H4/vC0PK3hBxXoQOumoob3XmhQBk?=
 =?us-ascii?Q?KIkR668GJ7cnx2BU+33jqF+sLrjlVcA0w5m3OBO1zS8oCvb7rvu8nnG/u45d?=
 =?us-ascii?Q?dOjyImiSl5MiBDfp1B84PmHp7mpD/+gLVznrkrAsDBWI5cdMTVoh6GotXHJg?=
 =?us-ascii?Q?I4AADF0fs+r8cXuULegep3dtUtM4tfg7W76qVTmbVQR/kqp5sQTM0t9Jw30+?=
 =?us-ascii?Q?2uS7QjvXqRoe0+fTxhH3QNlrZ6MEXiu+34LB++5jySfmGb+tNmTO1sYs+4ep?=
 =?us-ascii?Q?hQXvQGCjPZ0p9LpFaoUic0annsxCLGl8h628K+f0fF4ow45nH27x6kXL3/lZ?=
 =?us-ascii?Q?FzXS8GR1SIlogIjS81kESURq5mm6iDyAxlAQkfpOVk0zsyCDI+WYqj6WeC/H?=
 =?us-ascii?Q?UCk1nqWOzBDQ2BC5qfTVfOmuIUbbljlfcyHm9HC48S+R01ZgVavWE0woJYd9?=
 =?us-ascii?Q?QZb36Iuv7GSfBUS1kJ9c4xw6W0NRSk1rXKPTjiAE2ltTKehInTeR9i3RgdGA?=
 =?us-ascii?Q?qi2ln/M5xQtHltSd4f/ZPzxD+fjlP5PoqQlO/GXkEdWclg/R1PVN6Mr5owJW?=
 =?us-ascii?Q?3FU048RsG+ld0sYwPsykh4N1IEWZepK6O0sxtRhuyt/hvfhrdPuZMV1wjyMR?=
 =?us-ascii?Q?zPs45TTanOr617eZytdLKRsMmwWZUbSQnMyx6Tage1ldHrVOBF1rR5DJ3KBJ?=
 =?us-ascii?Q?VpTfTjGcBSVe0bj4BoR7tjNjoAQphrCDlfRUoD7rsGM65a08gF9q10tKDvE+?=
 =?us-ascii?Q?krZFRjOsrOVaYK3alPRVPUiJp4FvUN1zqczJvHgMJ+FvRxR7KzetegUZct8Q?=
 =?us-ascii?Q?4d8ZKR8+Su4rD21f5bWglrXkec/FAM7NQYyX/C7WIkuukLKuo8ZT31m7Mbol?=
 =?us-ascii?Q?XlzylBfuCaK1ZyoMhSujBmK3x3kPgyfAO6MDWGaq0+tjeZ0D95KCT8kS7zl/?=
 =?us-ascii?Q?PaZLvJs9plR3vpEhuS1iJ+LR839rPN3KpSpxcK93euBz7y4JM1sNxuu2ScDR?=
 =?us-ascii?Q?8XLhRulIZHJp/88H45n8JRj8wscT0SEPRcCGV7XLzje/QfNVWbZvkS8Wg4GJ?=
 =?us-ascii?Q?WIYW5IslhtgMkWEqJqea45LE+n1d8i2qFdcAqclYx5wX4W0ohwr324iGU72t?=
 =?us-ascii?Q?7x8cciMZ6YcxoC3lgfPFH26fTHZUbMDi4zKuubEt70teUHVoBMenR217d4Dc?=
 =?us-ascii?Q?Xtokc1Wsl27RWbZwno0OSVyIbGtLO4NyyiPLyaTi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126300cc-596e-4c5d-dd8a-08dcc104eb3c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:43:25.2299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZTWNulm+S2QsnkofpeceFWjSUUSOHI0E6Q/El5xsXFGlk3VTb36TwNGzrlym6cfy7hAyboxnDx4kYrG0oYvkag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641

When syncing to an encrypted stream, after setting the broadcast
code, the qos values stored in the setup must be refreshed so that
they reflect this change.
---
 profiles/audio/bap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a2c5a546d..80ed1a7ea 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3066,6 +3066,8 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	iso_bc_addr.bc_bis[0] = bis_index;
 	iso_bc_addr.bc_num_bis = 1;
 
+	/* Refresh qos stored in setup */
+	setup->qos = *bt_bap_stream_get_qos(setup->stream);
 	/* Set the user requested QOS */
 	memset(&qos, 0, sizeof(qos));
 	qos.bcast.big = setup->qos.bcast.big;
-- 
2.40.1

