Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2069.outbound.protection.outlook.com [40.107.20.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7A33FE4;
	Mon, 20 Jan 2025 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737382719; cv=fail; b=dIsdLM7t1KxAETj6EGGF0NPhzLZYQTMAh1o7MHaGd7uT7au0Wv6HmHn6NeQ8iacOcVqXdMJhSW/hTXwWHFycMJt84E3GpumKEVeBgmCEnCeEu3XdjaSyrtLUfCdgdEbP+khfvU+QkP0cb5Xnz/f3xjrxSJ6xrlH2bgBoOCwQSCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737382719; c=relaxed/simple;
	bh=8s8nYwKNrBU1fuQql/j37TDD0VgFk0woijGSargVOTs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SpWep0GQU8TjBVA8rGeBVpGGSInMJk7C2IvePP6XYQTBJzVktmCkROwaASCHDul4nj96k04Y6khNk/ZR203coqcUbrvbK/HHA+EBY+LO+R4VXsuWAan1L9yma5n15cwAPvyvImuP1V2RP40YHkd5yBbv7ZzAW7WeT2NzgHLxYa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hgKmKLKM; arc=fail smtp.client-ip=40.107.20.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hgKmKLKM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpO7TcAsvXy0XHkQWq2gME8FEUfpNuYq8vcHyKE8NKmqnyolty1kBKLDuDtTwjIjQSKINVAQx/PAUVWCxSpP6cuZeg35kH/1In7osS9v2m0dezO6zijtZC4h80nHCySIhcYIlRZ85Klr5RpS7y4Sdeamtfwaf1S2EO7ihjalq4fqwMv2uYEticVDkRPPkPdt7S6CodGHwqZ/oucVOJumeC1ouEVuwf9jFGDNE2V57NqN4CCTqWMgQMX4OlE2KkOE0UUVNT7OGg0rTJpBNsruTXJwHw90bBSDzo3mJfRKfng9n9QQr2ERu2j3/Bu0KKrkeZM8R46HJ2fTaKS2Dn+tLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trqF3wPeTH2the1PnPuvjfMydtVmIW7q7OqrKmfuHpQ=;
 b=qpOp3593tCoweituxrCyZIHbO+G4YCD3pAg1IgusqnnNBgj+qyc5HjcJSallVbWCCA3lYtUhlBRWbbrmrPK+39CgzcTNukzTy4GSPZiDW40M3PkUjm+o7tYKuVh4lXb1JA3ZN+K610KP6TDCJXqiqeLMBzsb08qmCq4hMhRDU8JDSX60GE8MJEMpZfqeXG8FiyQAUA9rWjnMqydCMFFx7QZacicS3aojkV5tnqTP7IZJBfque7UWoRphkMERqxJ0tfQ9Z957kYGr5L13VYx32U2LiJHPN6J+Luct6Orvzfud8ZXBcOj1x6VNAeHBpEFtPt6c5/iRYtnOD4mycqbQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trqF3wPeTH2the1PnPuvjfMydtVmIW7q7OqrKmfuHpQ=;
 b=hgKmKLKMOPKqyKNJ168bdEcVxoobb09XY79rySJAOitaLAk1kfL5RBvZkMojIrr3oLA5iZTVB0mklWDikpQDcSxThtkpZlHofT3DMheKhMGCsD0kz6mwGkaM342r8/viEiqF7Bzk/56Rcde2rgd3javNAxrxLhILFjMA+JWKN9gWamTaeUAHKeApBADkWQcc16V6iWWrsGnDnNAJKgbX9KxkS1p3BBRIH8fr/D0LSzzQO814zYUJ7SwBV4sLzcc1zjLMt1mfMuXGv+K/tgPdRSS6lPLFX17K1qFs/oRNF0OU0du8kTvRScsunLUxNK/3fET+bexCWCFX5LUZ1XX2xQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VI2PR04MB10953.eurprd04.prod.outlook.com (2603:10a6:800:271::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 14:18:31 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%3]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 14:18:31 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ilpo.jarvinen@linux.intel.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Fix glitches seen in dual A2DP streaming
Date: Mon, 20 Jan 2025 19:49:46 +0530
Message-Id: <20250120141946.2690063-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:3:17::31) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|VI2PR04MB10953:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae1f353-16fb-48b8-ed7c-08dd395d511e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7h2HZXfQOYh/U9SsYwir1F7efy0eAIFHV+uQSWS+G+pDlTVOhb5ZepLnQvwy?=
 =?us-ascii?Q?uAKwWTi/QfJvtj8ELxrs5VMR3WGbwERyv9fJ7lzVLSOeL/UF6IWLXNDiYjHw?=
 =?us-ascii?Q?ZTuOAnndSytw5Neb7s90+gQNMcjjnPERgk0CFJSkS0INugpvj8sZ8gs3CLST?=
 =?us-ascii?Q?GNKA3bZGmEGGRe/HAjYtPsQlDmBxk1uf6ew9goE4i2N0hXY4sdhwc+Os03lf?=
 =?us-ascii?Q?ovQ329hSHEANvpgs+RlhIwiDcTRWFnAX6MNOSYgbgWNqBGOzI1MsU2NNMz28?=
 =?us-ascii?Q?1jaCqT7wMolmbP7nvqCARzuWSEBAGFIPzlnCTQEgzTVovxtnMwyLlFJOkiKZ?=
 =?us-ascii?Q?6afTiErWC2C29vMkwnx1xrprduht9jcJY65c2aGdWvLpg6yweivnrbrgstgf?=
 =?us-ascii?Q?QDhlHu8lraTOIy01G/3NTKaVqnZa1saR12fyrGyUk957ET829LQSU+EvV80V?=
 =?us-ascii?Q?kCId0LEd97pij8uQPfjsVYiLXBNll+nuRpxTdjSDSk/KGADSflv8hF+/1aLH?=
 =?us-ascii?Q?buxZRc2kn4Hd+5PIjcnvSbZBRrr3cjXoa+MvN2rrz152lKtyq49FoOIlXq8a?=
 =?us-ascii?Q?RnpfllpgnXekA+DBhgpGJSm1YbxjRhhWx5JIO7gc/bpfg9kTU03VWt0NTTHS?=
 =?us-ascii?Q?a01Jj60HdcEyfWogO9/+XV87kB7J88B211Qlj5g33mDbAuLCuj+EFd6oB5nf?=
 =?us-ascii?Q?hC3HualoabGVxa1bVkFiMKt33zTNb7NiMvKetIJoumD4E2XZNV+PWC5RvdKe?=
 =?us-ascii?Q?1GCKgTQjQmJECBlxkBUdZLwDNCIZhKNmvczqqzvA7VKm1nf42KoEZ2737Bf3?=
 =?us-ascii?Q?7YJRdgOBsUXMr9/PzOU3sQ8n9hjCtqJml+WbfWeiT+IKRq2jKAEYDi8ywSxc?=
 =?us-ascii?Q?3aV9Clpa+Q/6BRRd0POW+uM9iPXWpcE/51G4vllvvd1hPCoEiFp/n9WP7Nr0?=
 =?us-ascii?Q?qjfLqeuCnN5ZnH6AXWzAqs3Hghv1u3orPvWN2LeN/6XPg4yzu7eUWhbaeO92?=
 =?us-ascii?Q?jRJPG6qNCAMtP68Q85kFsXMWiTx+0GYWpYQ2sG7FQ1Qnpn4gt4PMN2A83YwP?=
 =?us-ascii?Q?n/7D5rxJN0OM1k6pXS47PlNxfMtBnfE2OGLx6Ur1C26pS5yUjJijXd0iXZV5?=
 =?us-ascii?Q?AplxYqN6mwZGIltxlU/reSTXf1erX7CMLG0WGL/rETr+vc+AOqypx6GTfNJD?=
 =?us-ascii?Q?3Z4Fogy4P4mgrJvYXFgc740wOfz1Kpy4SY5b1n5dA8sfbHK8lCwZMtBeQexK?=
 =?us-ascii?Q?oDmpfaQ9mgLyAS1uVyZksZWXdSZQsUJUBz4z1ghY3J/XeAh7OZrcPLxIuhlY?=
 =?us-ascii?Q?Dg1lZDL4aEecemExQ/8PZabBuSQq9oPAK5QIYqkWW7xknqEkWYP6sGvWmltv?=
 =?us-ascii?Q?LfKYfrdfWVSePTGbWc0qwb8g5S9Cm5l6+5MkAdeoHxxSjhJAe/AOcf6W0T31?=
 =?us-ascii?Q?iU0yjHcH/VpHVSNXKky0WWfQsJyi00BC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fzWKYUsAEsa1LQu01CBJZgioVQN+PsWJtNLk7EyRh57G1VOnqaW7g2tqwOTR?=
 =?us-ascii?Q?+vOev7QH37PL5ciePl5dbq2YXC/Ce0Fz+oMdPc+uJ5kAAKqNWe22LqxlMqnk?=
 =?us-ascii?Q?T6yEcFzD28HVpS20C7wAN4jodqLTjnaScUA7JIvpdKeiJNgUAs+PKknIQRxM?=
 =?us-ascii?Q?FFaYeNE0ISlTlrD9YpZ+AU9KbGD03sLyqOkBiIGWttrPNf5oLZLyW2Y5VPl8?=
 =?us-ascii?Q?Y6LH6fFXIIu5KX7OGtGsUCRE+AVbuDqp90qsCsZGOyniO6CK5jefGPS9HM7n?=
 =?us-ascii?Q?HP3DSjoKdKw+O7k28SccLbl/u3oDy7KH/ijSsVDm0cz9w5NzNtsQm7f4Y6If?=
 =?us-ascii?Q?E3uPwDRIzWuAcJfU5Mx6LdshfcIa+egJjWtuqI0/IWOObtaUnp61Tgo31SH0?=
 =?us-ascii?Q?fG8aYlzWnKZxvkQlzufC+GGJHaUZVZ5LenuRBmIX8kUqK+3PG6+L1lcz0fLG?=
 =?us-ascii?Q?2dGB930j+2phpw6HXpCFaROACObLAAalbbRdQ26xnKcgOPQLld0bvgRJ2FK3?=
 =?us-ascii?Q?q0grIhZpURjlKQunFGcWRG8R+MPrNP4KabBAXzwptus5b87t9vj1wnA9Au09?=
 =?us-ascii?Q?fbViBwCn9u0NmFr8telzasXJ4vWwkCFGzMXworO3Gi/EQwSOrOkNnvN0Nhxd?=
 =?us-ascii?Q?1NIlxxybyJNaHkMhNX/AkAuXBU3usY5f696HfHc0soedpLHSXegr4HbgW9DV?=
 =?us-ascii?Q?xWtSFzbmaXw6a2WEADCZ1yX3QRUdRZq2W+TxPmoJuLmCIGT0Oyjop1KSo/II?=
 =?us-ascii?Q?R6hdcEkJdJg+LTtlZyRdhjcU2bFftvwCDy3dnt3etATA7xVQ7aPe/LNZfWrW?=
 =?us-ascii?Q?zu5vIeVp+88uklM2UbVALf0IVuLGzbPF0HSImZfpa7NX4JtxfYu1xgZbMLOi?=
 =?us-ascii?Q?zN3BVNCNjcf4pCebClMRRnV54TN1sBPqgGSvxL/WlCyZ6ps3ZaEScATcScpa?=
 =?us-ascii?Q?RXpZZGWM5x4c9pY/5QYylb10aDz81z687Gbhv0Fe7Va5KzCPzecirt0DAvfu?=
 =?us-ascii?Q?FZ3pFf7QsuKNNyX0etBSQF+F+/pnNlnHhX9RSERwFCkvH/uWd1XSyo0z8NNF?=
 =?us-ascii?Q?75Tljmrmwc7t9isD5XiHg0pDdiLnjQNbr4IMl+yv+LyWYOySSWUH1Q8U4Jlq?=
 =?us-ascii?Q?wY3Sdz46ytpDGtYxpah4DpFciLCTv/7NtVAUgAucosPt/0TFkdD4B1tzXE1y?=
 =?us-ascii?Q?wX51YxRf0Cu9QEaqDDN6hABRmybNhNZhrkifgo6DUF1LQkg+fEKzTMz/dMmf?=
 =?us-ascii?Q?GbKgNU34tUpFEm+WgecYM99mPZpqYm0rvyGZ/P9UqvNNiZrXA9XdpizyKF6n?=
 =?us-ascii?Q?yfiAt7h7ycL+kWuGKG19qmjIY6Ej1BtuqOXaCalmVyREGVhtZaXnm1AfnoGj?=
 =?us-ascii?Q?BwQMGJcNTkzeN9YBTVx+0pab26RV6t7RsP+YhhwKL7R4XEL2Ghyx6AFrQQor?=
 =?us-ascii?Q?am1e9kocuuUdX8TMw6sFqCQVbdCppNh6umbF+Fg03CoB+/r1HVZ4NTc7wudR?=
 =?us-ascii?Q?+DnwNRxacYHG4+haLx7+ggmttFndo6ItViEPvkn6BKb4/vzFwnJKB1y/eOqT?=
 =?us-ascii?Q?DHp2bcdNCowZS2y/3ywwxs40HrVOfJ0/QkyubpWFcEntUR62HltOgJAayb+7?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae1f353-16fb-48b8-ed7c-08dd395d511e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 14:18:31.6738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j4MItMcQtrMysxJ2tPFDrtWD0oJgyjJJNRPPX2VyRv9cEGNNKPc9MGhD9c60T2AWdUMhit6jXTDcETvuYlzt1NOvSpN3nBqpM5pTYgPmh7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10953

This fixes a regression caused by previous commit for fixing truncated
ACL data, which is causing some intermittent glitches when running two
A2DP streams.

serdev_device_write_buf() is the root cause of the glitch, which is
reverted, and the TX work will continue to write until the queue is empty.

This change fixes both issues. No A2DP streaming glitches or truncated
ACL data issue observed.

Fixes: 8023dd220425 ("Bluetooth: btnxpuart: Fix driver sending truncated data")
Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 1230045d78a5..aa5ec1d444a9 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1381,13 +1381,12 @@ static void btnxpuart_tx_work(struct work_struct *work)
 
 	while ((skb = nxp_dequeue(nxpdev))) {
 		len = serdev_device_write_buf(serdev, skb->data, skb->len);
-		serdev_device_wait_until_sent(serdev, 0);
 		hdev->stat.byte_tx += len;
 
 		skb_pull(skb, len);
 		if (skb->len > 0) {
 			skb_queue_head(&nxpdev->txq, skb);
-			break;
+			continue;
 		}
 
 		switch (hci_skb_pkt_type(skb)) {
-- 
2.25.1

