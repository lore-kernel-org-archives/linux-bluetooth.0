Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2060.outbound.protection.outlook.com [40.107.103.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282231A8405;
	Fri, 20 Dec 2024 13:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734699720; cv=fail; b=knNkwxFbsxLumMV1hPC2DqyS3izKjh4aAbNFTXT/+uGkoPiDDeI9p4shbMMLYyxZnoYb3nRHGeIxLle0BmudWs5rmtC/rfhAvZCoHenfKpv70NYBFvRlHYmh0GKX6MCChway0ozo04NqSHoqwtZnjls7/MihXXCgYIdwM6Fo71Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734699720; c=relaxed/simple;
	bh=e0BGz74tte5vkb1NU1feizEJmnBB459kenTTGFSWJno=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YUJmXe2CdlRadzst5l1xzlHYZ2Qy+t51LcajSDkB4sfxXYD364aW+HubuoNPBxZdCw/diEhac63BPgKbxNT769v8cd8TpPZJyK68HosY+DiNWoNtFt/HfPSK0KnPbwQvY19PTIWXYjix750cS2wxkh7IR7W0AgySC9koV4hR7tA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TF7QXrq+; arc=fail smtp.client-ip=40.107.103.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TF7QXrq+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jm9nbK+oatgmJxRyZ4GbwQ7vntcjhJzaqTlb2yN0JRmJQHjnIq2dLc55vuWv9xdDGGDkiuRPWwBA4kJmToFNsPlLSmDMRtlYhg960zljqHgNuntixf4Yb02OVcRqJRUTIQLZbOrd5axWPs5WxmIE5LFKDxZUI0+I48z5HxJm+XWPQH9QvrQm2dcfWCNHrn06qHJo07jafNUp5/IgIxaZxX3EPp4+uuL6eK45aIsVcFZ1MvG/q7hCFlwjHvv8nRxArOUxiKsQHzJK1OVyUKyu+gA2v5ugC+nmvm4hj1xh3oamiTFT+xgwjfpVZfskGTKC1hbLCq1MsZXL76aw91gEvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHEjj25RqOM3qdh8jQojecZHHeCbVFoABuy8f3G8Etc=;
 b=EhUWmLTVO9iYz/vca8NjiMdsIa/JwMaerWNVlQ3PZjumdL+JW/1n2RF6PBgKKXrvLKhicgdx6Sgw7p6ewXtH8flQdGnUb1ltTzLFRevY8OFsOGahoFeC3lf6s9B8w3Dc5bBgluuwIL+Recz7XsxH3y3KDLEOXWkHUEmKxAckHqSeLUY/k+aLbUd7YykXcrKaS7wThTp5FFf6Tf1mBEPATGFuKOugLyGjejpguVE8CxO7DfaT7D1HNilM/YJlrJeg0+osCTvlh0p1fksYRq0rVsq2U6lGi09OngsZ2TDqZ3lC2ZDVd+6bGD3HU2TMgbwHhwOmQP/OkT3zfxnYD6hdeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHEjj25RqOM3qdh8jQojecZHHeCbVFoABuy8f3G8Etc=;
 b=TF7QXrq+US9JN1E0l357FspY3tThurN2YHu5c/zw7Lly99mtee/vYJ/kUhwp8AGdvsbK2SyhEA6x0Nvb5KEtr1AOR5OznJQearUz1qJBNDNqTHprnilTJOltXNESKCkGxhLVJEhPHNlO3RSoCGFuhxOYpjBtorlAX91xohfJ8ZjMohqJKKAmN6ybvqlQpgzvCy3Ei3SNgazDw2nGttYemY+jPGWd8OrCnN3C2CZjM9IY8OA8aoCtWy4ozh5OeftwxPgOWQZUoI3DUP+KDzP2AUFiizwugfgOMrZMUTbyzmVj4Lsp0CZgFd3tCiG0AgCfboL2aOccKc+VKWweSlRV3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by VI1PR04MB7200.eurprd04.prod.outlook.com (2603:10a6:800:12d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 13:01:55 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%3]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 13:01:55 +0000
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
Subject: [PATCH v1] Bluetooth: btnxpuart: Fix driver sending truncated data
Date: Fri, 20 Dec 2024 18:32:52 +0530
Message-Id: <20241220130252.1903536-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0047.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::16)
 To AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|VI1PR04MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a5f959-c1ca-4cfc-93e7-08dd20f67ab6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KpMQlKwOiv5+r4Ebb50XediF2fSLwc1DaIuLxbfGVJfNQ6kQue3nviCSfjKF?=
 =?us-ascii?Q?VrOAMk6FO63aMpvP00KutQeeSiOW4cqXJt7dPxbqBUrbCo5HE6PL9eIT7Y7P?=
 =?us-ascii?Q?2FIBpPpHhE5RcwTFLZqWsuIK5CdaV+oBHAzKRAr0QtORApOYWTHwJGnOMHyu?=
 =?us-ascii?Q?Csgq+Zkgx1zorguktlAISYySlfvtQY5Q6BfbksElxUbGSjGHq1TDQ+l4hqS9?=
 =?us-ascii?Q?DrFrgvJuP7ZnKWQKs79kjGgyua+X0Ij/ULcYA5klmJCI4I+CvFeM5M0d9aLx?=
 =?us-ascii?Q?RPrdN6mTR9V7g6BPje74TE1qLVKlIgrGjsjQE4d3wQcuq8p55u1mAiL+/5zp?=
 =?us-ascii?Q?b1Ep1qFZcgyzlbCSVNkfgtFQ4vRE2k2Dfq0cpsGoRtxcbX/7t+aOOCqsIBf+?=
 =?us-ascii?Q?1l6jyKLgK4mzASOTzUjWPsCluC+VzFCZZDscMLDTzQbv1bTNC3Vun6ajMZuf?=
 =?us-ascii?Q?9Mak8cWCNZUTVFZLqXZROVYUlLvKvkuH5q1j0wMrpF2dECrY4YO+QbV2LrV6?=
 =?us-ascii?Q?63ShrtSSuVw3RFdv2fCjJOrGrCII36o2aIU/eHkP8NRtLrnLYiZbIb8xW/+y?=
 =?us-ascii?Q?IkLRxWWEquI+GwJxZOopVEMJHXKmIp9qpkQA+jo7qMqRGlsRBeYvJYluC2RA?=
 =?us-ascii?Q?BRoewtlRbskzVvOSs6cmAmWaQBz9o0JPCG/FKI4NA95wk7v1BrWziCCHwtGq?=
 =?us-ascii?Q?BSXR+4HTLTxPf7oP7HUpMHxegKPOgvZljdAJrePGRMC2UhypGnR4At4Iez4e?=
 =?us-ascii?Q?pW6gXOoBVdmwF3nX88cBwp48qwsBKhRnbz+FYqFw+Ro4QIebmo2jTSF+M4rW?=
 =?us-ascii?Q?x+yJk0++iv4BfZ12lYjZFb97INPOOB4ErW7IAhj293NqUj/KysIXIgSjTZ8L?=
 =?us-ascii?Q?Y6x2ytTU6p1HPLcUO8Vyp08NWoTT5gaCxYWmQKi3Q/zcqFohFf8W7EuLFB9j?=
 =?us-ascii?Q?ZUkIknwVsoUQTHg0hEPSLpfE5CC8w25opx38Cbv4gmdMDigq1TT6j37fblrK?=
 =?us-ascii?Q?lrOxTnR27UEsJ0xbc4LW3PEEqAy39TV+NdoTMC6pWgtggs+heSYKYkxZQ9Ll?=
 =?us-ascii?Q?osPI2G470vY6s258R159w4V9u4kIsM6a3Qk+T2ULwJDEwx6ETRAAOjkDPYLN?=
 =?us-ascii?Q?zBQ47mrKNU01jnNmRiy9ecy6Qj6uMEnvC+GnMjSlVIzUJW6NeT9yOmK/drao?=
 =?us-ascii?Q?1IoDDJNCOrIgp1ktwT35b+WAj2wzSh+Ku5Wap9CTnAKh7IPuMO72vK2k4VkT?=
 =?us-ascii?Q?ICdH6h6HXvgZKI2GBRu0n0TbLcBL+eMr11UK6ohL4WzpL1+k+35AlLt875t/?=
 =?us-ascii?Q?IO7k8PUpPBG2XrJeeORYdB/aU43fyI1kR8lH39Aa3BkA8FZTbQIWQxTi0WhI?=
 =?us-ascii?Q?2XBxl7uqrkTe4PlZYMGVaKR5ZDGGKimd7ZnYJjasVcjIweoF01x+VpeGkrM/?=
 =?us-ascii?Q?qLJQQcs41WVIiKFs6SIVxBms8XVUrXrO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BI/iiakOLJEU+x2xyTtvpFovhZM99wEcyG11UU+ezfJNveqbmotv5ualkUB+?=
 =?us-ascii?Q?7AYg+5cCyMzz7ejbgWHdMe3gCd12NoVjV9LyUkRmREOlcfKpDaRmazmGV21Q?=
 =?us-ascii?Q?8+V4oloW6p/iLsKOnM3DEbRb+I1UztlCtLUwaB3Niix4Y22gQZPWG8EDrtF3?=
 =?us-ascii?Q?8u5+zNqXlaUijodagpgo+rTW7espGc+zMDaTE6F1rAp+YcTVZi+mHVqK6OMh?=
 =?us-ascii?Q?fOuWZ1dvQN/L+9LRxOCx9P0ixqbBURaYK7iZZSLYFSs4NzqSYC2aoY14ajmS?=
 =?us-ascii?Q?UzRMlUAiKZBA2lqjPMcbLhRBXQs2f5jMj7yznTm3rxZyHC/Z4u8l97ci8YA4?=
 =?us-ascii?Q?hyXAnEWkLSmIfwCYzoFwNT6A4pVJTx2OrNiWj3E41kcMImA4idn84bDKkd2K?=
 =?us-ascii?Q?8Hv0bdyf99Yd1w0QJl1qeTVeZgelRKWt9mQdUIKKRjbnK6I4ql5k/OYJUwNd?=
 =?us-ascii?Q?SDPHp4weM6LA1H1phR2chhc/8QX0gL1Y8hcpDx4mFelHnYDTjJlbLTzq81Hx?=
 =?us-ascii?Q?zCMueFz3JKfF/w4ZvTR2Tqq0HGCCHMwMjrPpDZkn2aWA9SAzmc6ov0yUznmZ?=
 =?us-ascii?Q?3YVv1hhZdkBtDPc4pQCDeFD4jF2E7dcVeD5eMDeDfoe+Am7Nzbi9YLazdoZ+?=
 =?us-ascii?Q?8B6J3KmDIJDcROu2YP8RdydW7csIjYFSMOx5ti8VQ6J6qaZQ88Yxbin+iAfW?=
 =?us-ascii?Q?c9sDqNVjrJhAzb5Dl0DcbHPeAPBXbfle7pFzy4XU46PDr28ss3IGmuu0dapO?=
 =?us-ascii?Q?ZH75IGZbw3hHmz8ZK2Xbb0Gb6zVehOw9OCVNK8SbmvlJR5BvTqT1Yzz/eysr?=
 =?us-ascii?Q?7c+FIjS+V8B6gVcnOpT00MKwfGahlJBt7wRfVm1DrR7vxLiFGMyz88vY+PgT?=
 =?us-ascii?Q?Y8k+N5m1J/gukeek80Ga66pYaUT74Oi2jnDKfASG21s5DD9spAg96Kn7udLM?=
 =?us-ascii?Q?nyBytzW9zG/sLbUUxinWys8MpczqKYQuk+m2TCrtQGjPDBf9UR5XFeWzVpp+?=
 =?us-ascii?Q?cwRm4K4POd1PB9RbbJryxb+jRztGCQenz+jPgN1RJy3X/utnfhdc/Yhs7rFW?=
 =?us-ascii?Q?3lII5JIVinAxU8JiumXlLZvu3tI5jTGjeMkhSNvvBOq4J9r/+sJ9kjR5Z3TP?=
 =?us-ascii?Q?HGFeIhbo3M5umSAj2VDLir10e/36xv7Xo4hWFGy3waaHqaD2iqmOpqxaLrYa?=
 =?us-ascii?Q?d4PzZSSrletm/g2UIn+IuQ9dyZoTOYR5S7x0hdLqJchmc8gWkJBuaQDTnfUa?=
 =?us-ascii?Q?0AnT1opmFH+v0ZXYHlK03hT8Y1fIPS/gz6CLaMoyYun79kXcqkeubVDJYeYK?=
 =?us-ascii?Q?Bwm3YMRd09VyaTHnqY9aDyJtMokkK/pESYJ0+d0Qwk604NYOWyxlLf05NtLX?=
 =?us-ascii?Q?HmrS/uvFY8NwwSLSIp4ykrWKi4LwGXWIIkK8XS+gqhYKJrqw8svhLLpTP+gQ?=
 =?us-ascii?Q?o7OjTcaNQrTyAq3J9wpUr/FzflXIoygURBEhKVn6Ccxb1kwtrQdtpTyboLDr?=
 =?us-ascii?Q?D8sMBzE4XD1MnL7z9SGtovP/1HQxN7xowoYL0Mk2XGNNbNQCKpXTyHSLX2oj?=
 =?us-ascii?Q?0WPSHDP6ZXwWZ0GVh766YJXuriYc0FSmf6NavZxorr179rGeuPEaG5DpPsR5?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a5f959-c1ca-4cfc-93e7-08dd20f67ab6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 13:01:55.2677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbotXaNstTW/48MCncNQEOMGUfk6KuOKTid2FeItwUj5t/Cz0zSyalpbb5C4aCIVTwKu3oe+zD6ljWNUwgUnWmXHT1U0Vr75oAgbIK6RjUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7200

This fixes the apparent controller hang issue seen during stress test
where the host sends a truncated payload, followed by HCI commands. The
controller treats these HCI commands as a part of previously truncated
payload, leading to command timeouts.

Adding a serdev_device_wait_until_sent() call after
serdev_device_write_buf() fixed the issue.

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 569f5b7d6e46..1230045d78a5 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1381,6 +1381,7 @@ static void btnxpuart_tx_work(struct work_struct *work)
 
 	while ((skb = nxp_dequeue(nxpdev))) {
 		len = serdev_device_write_buf(serdev, skb->data, skb->len);
+		serdev_device_wait_until_sent(serdev, 0);
 		hdev->stat.byte_tx += len;
 
 		skb_pull(skb, len);
-- 
2.25.1

