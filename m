Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012000.outbound.protection.outlook.com [40.107.75.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE63218B2;
	Mon, 18 Aug 2025 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520613; cv=fail; b=FgOyOzi6MWNp6CUzA31Y2hZP7cJaeBlewG0mJbX8+LUGlVs5gcn5UJkHk79iTXG0BTe8esKH251uPhZqTYFNnP0smHuAeffJ3rS1GQj/ZlZ7SG0pkAkBnNQq1L8L0egmb05ydqgrzla9ExtI2QWUxsZtIsFeK8cxxaD1xwQFnAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520613; c=relaxed/simple;
	bh=wByL69lwjI1A7HxmJjyMPiWuVZPyfuA5WnDqlsxdNgE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IaikVh+wPaIcitVe6Y61oEQ7PsN0OUQToTwSGyMIUfBnYZTPZ/s5sWTtu7LiKGlIENoNpf0nwTvqr7g9uCuyfsSdRUao/nfuKSHiEDzgNQeuuj7Qwv7EXRtKlDiSFouohSiiV3x2Ps1GaIC4yO9jJDhopG9m9ktLN58SF4SM7Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=dz+EDQvT; arc=fail smtp.client-ip=40.107.75.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="dz+EDQvT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQT9k69QCf35TgUYvlVNCrLGTxNj2bym1AfKNRM17wUHIeXI4IIaNC81L9uoOHI9lm/LkYXNq+A+ZWoUJjVT8+JIthMYNcuZsCGw9jYAztIQ+pC2HQU1412BNTU4uaXGbrQzz+gv8JcLsEz+iEJTcbHelCsKVUAq3nACk0Te6mHlH2tl6pkKwyWQXPw8v/beaLob0jWO1fj9lJOAJ9fKtccrMoOxV1jTd7hDuj/L2KQalNz5ig9BDdmJoQ8qZE583Dw2NtfXnKF6ZfzuCGrlNabhOOw9idHa1GdBNqbba/+b84vXgm031NjGBRB+izh6xKDzpQa0XmXr6WdTTv1wVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roUCjjEun2/LmAdk70MkR7uy0T4Q/fdIvWpB7HczQ74=;
 b=XGNHqdeKKEf6xenO/tDPj7F+ctvRxFqvs0AB48jrcOO+39KBrgZlfmcM7I7XJXdynIPdOa8ScoXA75NzqkklAeGMCARSZZHVs+0zDwI6WRBLIuhNUuQNOpkC1TE4nN+nRf9PGhsXA6DQU668t0gknCnuf0H0L5+ltcHuo6tvhjAB8zfb2NxRATwgFvEoOrWE6yq38xYS5crKWBg3UHBbbWTRODLtE7tH7qjz5f/103pR/EZj777tCTqBLUX/97a0uSscFV3dXAba2E65HeBnQkXVA3B38i97LHkMUZOqJAn087zYZptqaABWU2wGFElI8a+drYMiqMUSz+dch1Y9kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roUCjjEun2/LmAdk70MkR7uy0T4Q/fdIvWpB7HczQ74=;
 b=dz+EDQvTW5RAVL1AEW+9B8f2Q8Hyz/jlOGKkI8gvPMZ++QwuSFsUPIuRc5S24UlUPVpCqXQEVw1UvfMPpGUDow9raL97vCvYb6P84wJtu6abgg7YeFHZZ/U7a6NBgAEmmIS4Qw0Rr8iky1oOEhytIpV/vIDYX788uMY5LHNTXmYeo+UviG34PoU7gGwfXI0usw2bMyCiCRIclMDgVdCr9QdrrYxFUjsZHFTRFKv4mp4p4JvghpGgjMx83nz60BLk4NcfF4rAb8lFA/zO99bY5dLQSlXgF1jn22IJ4BaY/RL4eX3txnpXydL88xIKvU4IxhD2JYWChiBzBGNbqPuCeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by TY0PR06MB5379.apcprd06.prod.outlook.com (2603:1096:400:216::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.23; Mon, 18 Aug
 2025 12:36:47 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.023; Mon, 18 Aug 2025
 12:36:47 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org (open list:BLUETOOTH DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] Bluetooth: hci_ldisc: Remove redundant 0 value initialization
Date: Mon, 18 Aug 2025 20:36:37 +0800
Message-Id: <20250818123638.635566-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|TY0PR06MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: c9511926-42aa-4d89-6933-08ddde53e5aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c/Y2NNjlwn7uCp8tNJJHBrdxzQGadCxcmu4v1sAMcK7veA5k16mqZAmI+v6/?=
 =?us-ascii?Q?jZSuhwH0NI6CRT8v0Bjkt2GqBgC5XmwGxFDbipG4Zsm2Y13M49MoscG+yoLl?=
 =?us-ascii?Q?cZ+VZe1Vw01ytcbDMtZFa3wUC6h5kxSIzp7iY30db7ub//uuKBloS9m+S/f2?=
 =?us-ascii?Q?oi2SBpRhZpf7hSob6tFslb9C4NKPA8uEBzgLNM7eQTd8NK0xbUWXYaQPQw8r?=
 =?us-ascii?Q?EffDem+WlLsQ4pIOkGLzlx/s7wv0WnNS1C3aqV+5ZJ2ysNmZtj029u8VQtMZ?=
 =?us-ascii?Q?z7DsRGynoe4SWOy3HZj9rKJbr/auuMg2+kOET6IwzlgufT9XPSzEOtukxrsR?=
 =?us-ascii?Q?Ej346i9ojaoXMYrgNUS236j2spzWPpiAyFeyegOy1Im7hcrKiUFcCN/oJxhk?=
 =?us-ascii?Q?h3UsYbq2DrDnTaFeBWbo9voA7kCvBMIqG/w55MtWu/Zb3nbM/2Z4ABqrFM04?=
 =?us-ascii?Q?PAEQhcpqX/TjWJKBx/O6B4Olb+s8pk+telPUNaR546C5zl6y1GKJqR14Vrtm?=
 =?us-ascii?Q?HYbEtZVnijYTP4CaUBGDA+xlkmKAbeKqkdNYRH3/LRBclGj0wY5GfIV6RV66?=
 =?us-ascii?Q?wwxej3ic1rCz3iojS4zyKdPURBFhBAr5QhYXDEVsU2U1X+7dJIkCuge8vRMg?=
 =?us-ascii?Q?Y6Qe4qym6WLlD0wciy9bZla1uPNa5qhr4Bx6PMOUkdcdlqKkEyihNHc7Zp27?=
 =?us-ascii?Q?oF25X6SexutAfknrEWR6Kvag7qH8KElCqrXt5w7jyoDSo9CsPp5NETS/JNdY?=
 =?us-ascii?Q?IPf+Nn92GSMEzApgHa1cHOMB08hkmobpRQkORiq9qWruGq/fxTDq0IURV5mO?=
 =?us-ascii?Q?7G+89pdMnVh9oP96C3rIth9qVQuhgeh4ZyxAKZ9ghHbM7IGcswvmgGliDJ0z?=
 =?us-ascii?Q?sZsKGAsZfDIhShWCY+w46SCupsRj3Qqp0h13vtgLJpgXsOLlXyhDXK1aTafz?=
 =?us-ascii?Q?ePoDuME1GbiUHH7RdNjl6JCaxVv47xnvNLa2nKYSANbA/CvhER/aeUE7/+cF?=
 =?us-ascii?Q?jipXqWv2J0bl7WduQXOuO1IZl5t771M8Br535aL3mSH/GCgxgsQgdEuvgBTR?=
 =?us-ascii?Q?easjcVNemFQ51g6GPeWIkMBgGKO+mJNHu1D+AWu+/CzKma2JuzIRRmH/FajR?=
 =?us-ascii?Q?gUAwhxbhvWhzLL449vF9fJfPTfkLlW0+lvPbRlMGJDcA3XcIc1u9RWCm9Lny?=
 =?us-ascii?Q?ZEgmFDtwlTHPCTP2iv3CPQRw3zVTVAQwzQwRcNXNIok+EujCyjCMNJ4FBQOi?=
 =?us-ascii?Q?K6wqNrRyp1oM1DzzWT96yhqkXw2eHEwEBgIUv2fdcTuSVLL4z6HdVvRfbTeZ?=
 =?us-ascii?Q?9zsc3oeSyyvO5xZCtzHh495uoePu/JC+K7mejufhzZu9ClvLnlbMoQh7NXPN?=
 =?us-ascii?Q?0B+ruoRsX7ZZWYUhnFGbDPSJwqvXvNIIsYeJogaGpCxh2sSqYU+QdLnfNLAp?=
 =?us-ascii?Q?Vqxv0zvZm42A8EjmUF3mNFHJcgnYMmZ7l9+5QsfFTl/cWiED4u6byA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rVdl8yoKhFTr+BYoCBiXjr5aC+FrjjBxjFy9DTw0HsnnXEgaEHOYL9ENY0oR?=
 =?us-ascii?Q?ztHl5q1QigrWEUuIj0/UN8zm3vRtdMwx6g5oCdF0Sv6/L0o2iw/+v3SCmoaT?=
 =?us-ascii?Q?UkF3PmQ6PWqM9vd5n+ce5y/daZ/+28IMy6Ioq1gX4OM9cshECC6Sa2PXgXAY?=
 =?us-ascii?Q?hKhCZACty9YTHK3jpKVOBIzGaSqbkna6VVz4jSK5z+VyW9faOFePX4hvvVGT?=
 =?us-ascii?Q?ZUEo7IQCDTvxkUBxhYuWj+3Ebg1+bObtJ+PY0ikagFzHgRpya7JKITbvFYPp?=
 =?us-ascii?Q?72Ku873b09PvcCoFwwDnW6QFqjKZ8dXQrY7MtdzVGAQY6uy6flcZoAlyPDCg?=
 =?us-ascii?Q?1PewW3nN45NS5XAIpMbhEIpiSX3TAuf7lFxGprmfZfGYV+tRu6ltRHQfMXM8?=
 =?us-ascii?Q?igoyYPLWbPVRrvNDHbxOkQSBWr6Q73CNFwt1XNGjnA/Q3+FvJPq+iOuiFRZi?=
 =?us-ascii?Q?roooj00MIMUg6Xsq+Zc9b0HJOURqtXOnotKA9XLuk+NZSMEa9yqwW+yZS95D?=
 =?us-ascii?Q?8+KtxeqPRbJA4lSiIWvHuVc7UZY8YNA57BJPBlqijXv6/sME5dtaQ4MmbWOU?=
 =?us-ascii?Q?HkH61xiUK6qSFHufQI3Gkb3VxKTRCMuVfnqVsdyEElXzQcZsemknMnbkzQjE?=
 =?us-ascii?Q?VvqTXLb2EfrZv9Y57M6xDotXmOrCLFf1V38wo3V/0UI3XmYqU+HWyjEQI19Y?=
 =?us-ascii?Q?Kh6dcY9mrLX0bw4X5CNXQP73NxlPIp+fPugK6nBlXt+EXzZNJbDmMPm26aES?=
 =?us-ascii?Q?kz1TVX4y2M5sbTRy7GnwoXBd2SsCaxcsOKJA4OLPvR84E7uwtLEp90raVyi6?=
 =?us-ascii?Q?Gfuoz5To+G0CkSWXmhFdShkYxxf2xZSNvdFejpHNObepa+S/KlF/xHP3be79?=
 =?us-ascii?Q?pXMe3HgIEtI5nayZnIv8aiVd3mpvYqc9Q2/IltJuetE3jSoHijD0ngzULZN4?=
 =?us-ascii?Q?PlkwfeZrLbLy7xXEezh1lFroP/Lqc72stNGqNUlt1Tte8wl59OxtTm8dPeMF?=
 =?us-ascii?Q?PjWfGvoiiLxnq4mPToPl0Q0Ap28oS7TFPdGq3ymhleafZCvnmYNTIxuOM+iD?=
 =?us-ascii?Q?CfxFqfHevFsQCpmp/v8u7lVYcsEScQkFxrSty9CP/Pp6KeLShN5e3YZJEd5J?=
 =?us-ascii?Q?zylaCAf9g+5N/U2Fo/elIdBJtmv25yN9w2GXyKqaPF5DrSSs4xC0XQYUCudu?=
 =?us-ascii?Q?N7B4VWmqGnbfbuvxwOE1X0GbiDZssUmhZ2akUtDrnJPG/kOYRSF06YISEQJh?=
 =?us-ascii?Q?w/9WdqzXeBB2H4ucMB/FYc1S+7Yqfs7FeGCCDr66KBDACquGGQSYif3/LUXv?=
 =?us-ascii?Q?mZHN0e0ezxfNNzckGlQLKC0SUv3C564zbrsKgFqs1QHYN3eKSHzd0O8/gkj0?=
 =?us-ascii?Q?GwW5u1lUpNk+wKkQ/GvEGwnOWTB7Aid9s3jyhw8ZLWfuWX+124bMu1KEidQI?=
 =?us-ascii?Q?WTC1M4xJ8Y8p7GIKQlh5MEaJaefc1LazGcmTDfr04C+cXqPKbCMSVUl45fLI?=
 =?us-ascii?Q?EgR/+iqE2/oMivrq5nf1ltpBN1yisoiUZrvbUZ0jvrXePXkF6M4aKF5kiYEI?=
 =?us-ascii?Q?LQ4Oi4qagZ8uTinn2OBexuve4YXmi57/ElJ0k9Tw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9511926-42aa-4d89-6933-08ddde53e5aa
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 12:36:47.6186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fTNyDwTxS/wOVVePgD/LHagdkbF9tZkj9q13UoMTgkhmWcxPaf3/7QVaWztFWI/2533zDdwqkMt22Wip23kZDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5379

The hci_uart struct is already zeroed by kzalloc(). It's redundant to
initialize hu->padding to 0.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/bluetooth/hci_ldisc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index d0adae3267b4..e7a55c2e63f1 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -508,7 +508,6 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 
 	/* disable alignment support by default */
 	hu->alignment = 1;
-	hu->padding = 0;
 
 	/* Use serial port speed as oper_speed */
 	hu->oper_speed = tty->termios.c_ospeed;
-- 
2.34.1

