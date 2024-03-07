Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF551E897
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 15:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827156; cv=fail; b=ns539rXcf216jGD2vBTdB9kJfss9o1YbrjPsLQzpYrLCXJi4F83X9pnK7CCBbyu7GTQwoenAjkEFnPUMxHiqoU9uWWbG6HdGNp2UsCer+5tKf8RDvLlu/IaQeEwjREsQa4CROy/SaJhDxtRPI1PC7gU8rC0vZH72VyhGhClcQdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827156; c=relaxed/simple;
	bh=vl1jSDNJ2nahIYb+rAa7gexmFZhIK8hAOnu2PewIdik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IZHlBTKmIsi5CAGZJw7o436lVV6dzlko05lWdyAP83NbGIeoxl4c4EpzgVMjgGj71wTA1O5txomoOK1LZ7H2o35aWOOP4+EZW6UG38sGPk2PITI/6+ibN1TL5vH+DXGnbXi9ED0XfZ3AsKd4D270FpMmHZzGow2NB5a70wIP9L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eBGG0f+y; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eBGG0f+y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAGR/toQoSXtuQUtLnhENo/8mu1nYF/w7tSwLuBET/8XjuFQ7BiKSngi+m6ZCqs+ZQQWIlgoeVtOyoe79TDzTW/8hjXUdeSikf2Th/4exFnbw1NhmqUToAv3qrjK9vo1lGwWnzzONGWns+Rqd31F4zi13Hw2IC4wizaX17MTizSIK6K4Gb5pI3KmDB+P8CXrBTPyCvi+v7sxuBsMYuwAYl/gqRPt8/4pBcgWL6gbMUsGCiL1Iqjr8t8UJQ6L1RPKNpn2nE6cE4YKDr1J/SjVxQ5lSFFNtIxRia2f/25irwq0fy4dr+2ehpyBP3yXyzMjE/X1XIQudh0xtGjAsx4ceA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBL1+u47G/dFlowULJNiJL8Tged8zLx4DVsiVpFUyuk=;
 b=K1eeRSssWgg5J4l2q7LImSHwzrs3WqeL+dNGTHcarecxpKzHokYsS8lso3IYJ4MQgbCEizMAS/tIJwepzwl/XhWUrduWEYoKjM7XflNxv+vdIp1QuOId6tD+PNMeWN7sXp/lbbiquQKp1K2wUsqq8tuVAxxxHIRXYnSW5aMmdlDeAh8JP7qqjKRK8LApnb0mfB9mHJB1NPtJeuVm6+maIU5FA7ZKLwfNRkwMNAJTNkI3rwvdo3YxMpgfn2SnmwzSKHf0fcFDj76RLF8S5MNjo6vsr4M8/pywy/B9XsSXgnu1zir3TP8VN9YiZcRW8Re46SHclMClzAmGg8v9HDde/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBL1+u47G/dFlowULJNiJL8Tged8zLx4DVsiVpFUyuk=;
 b=eBGG0f+ypx+Orp7hbcbw6zZ/JMm9Jc/vBZFhk6yzoq5RFAqLUMcrvGT7jWoHavUOyh/akLmB5dTuxjO65coOz26nFE2UjLxf5Cmg1expEOPgqC4eo5TQPs3OwV/ibwZsG+U6fqAziVI/8Bh/UWnunZg1Vc1+Jh4+2/0wtgL+7Gg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by DU0PR04MB9672.eurprd04.prod.outlook.com (2603:10a6:10:31d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 15:59:11 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2%6]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 15:59:11 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/4] shared/shell: Add fixes for the init script scenario
Date: Thu,  7 Mar 2024 17:58:49 +0200
Message-Id: <20240307155850.68395-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307155850.68395-1-iulia.tanasescu@nxp.com>
References: <20240307155850.68395-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0139.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::32) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|DU0PR04MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: 532b70db-dcc5-424e-f704-08dc3ebf8742
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/3/AR73seMU3Wl/p1/dRfEwIxryd6aM74Btk0xWWRTmYV2TVq38P8jxgnP5uoNJnm/MggpxyUSi7BhYqgXJaPsrlrmYlFA3jh8clDSQ853Mstx7UljJPPGKZq+5kHusOOdOoi4KPTCwz9WdOc9/B7IWEmw7fkNPKJFILwnY1SUsDccqRxTfFB7wSH07Ae3nxtcMJ4QktHUttMch6F/D6fKuCNc9zw5Hqu68Pc9hmeAvfNC+YoMyuqYfEnBNPYt02YKD6IDzJliH5TQlbT3bQP2sddVwP4iRa9m/etMWTX5m16fDrDIvSOqOxHw5NmfiGXQqR5nM9nujSVfpxv4u8oEz2CxRZjo9t8aBAPzXuHolmMiZJYogCIGKBocOign3cl+uwnjmg2xkfsVxxZ+jrwBXg/v+88iKqhQI+Hhs4e6U64ATW+6ymzYLDzArd+xODmTF2602Go2R/9MlFVdmiLay1uNiBaePlzPStB3y22oePcBJG8Vysqcsq1hSK72JWK8ul1yID0uGf6eX/8NVjMqvNVT+0ttlpIvJZw/gcuz+Yv+pLcm257gBCfP+por0wwYABtHi/Ue2Rvg59+yiFP+FpsGIuMMTFSlYfvS9ryo87XrGL+LJkKKFGG6sdHwVwPxWjcXPepsjw8JJ3hYuTPepYW1MrbJYhDJ4TgAuHCqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?38aOwBbHNbk9Lv6tB8atP4+N4nqFVvWStDnTJ2NpXmL7IXF01N8pSNMCk5mq?=
 =?us-ascii?Q?yY7SoPcZHmWoYZQdV1U8cijKRtxL6IJ8cSQxuIc7LfIRgHPM0XcoEvsiPMzl?=
 =?us-ascii?Q?7CCJUG7zJi0U5ioYfBMRizuwScqNL5XmGk209SQzhKsj0XMA3I7fq1elH2yu?=
 =?us-ascii?Q?0umlU1W2Oo18236/hgVhp+mPOyxJbBQ+JtqTYGDxgn+0PWoXNF0c6BlyAQqy?=
 =?us-ascii?Q?GdRVJDa6wp76SzK3ysmLqyPiyp8ff0SXupM4cuEkKp4ubaxpJc/DgGm23xJS?=
 =?us-ascii?Q?vIDflLF7IA1y42QoKL2xDHz3cMqmXkGSf0FgmNzTe4AMccg7UL+17VTGylFN?=
 =?us-ascii?Q?6veZpT8+RQMmFbPKlqdCjP0Mska126cadGBWJxvyC+o5ezwewrb3QXntMYyM?=
 =?us-ascii?Q?Ikirn9j10q/aa4SueY5kk1j7us2agU0d/3k9N6zIwtMIxrdO0kq5iQgzGt49?=
 =?us-ascii?Q?8pKPnixyUHzv9urLf4HBb5YnyEvitzoYNeCRf4sfIYyevRIEOHpfShO3Bo5E?=
 =?us-ascii?Q?TwWnU/l/AlS2ppHh6ek6f+jee4ig28l6n+seeqVsqoPPqLygu7tDMHkCdip/?=
 =?us-ascii?Q?rFrsLu65/gmve21MsMg9MHcs9KxmHOQA4az9tNFbvMZC2s/YYCTYwDkL35vy?=
 =?us-ascii?Q?8TGO2fqfDVW7ns6koWTJ7/FpVUTHi6xDXoerOJDwTVeJEFjbFZRjugSZI/rO?=
 =?us-ascii?Q?9k6FThJQok6qFevKuqqmyHhVfYtC7lIZBpa2j0fhx39ABZNaDcIjKedr/hK8?=
 =?us-ascii?Q?cjZQrLKAMWB1U2rOiYDy2JoLqgncSLn5zUO9/x0hsHOHZMGcr9tqbS7OzlsN?=
 =?us-ascii?Q?bswR4PQ+/g6TRPFZBcZuWhuB39LshGFkJPoXpzNfl7eWmcdX1TFoN/fH9RJm?=
 =?us-ascii?Q?6ek2nTtAkRdOf4gMbDPtEC+xh3sZdDNl6uQPzqkP7pOkD2f9s+XNW/xDAB0+?=
 =?us-ascii?Q?KVEWE36xi3YeMtKmiTUbxfGF/HWvuG1QeSL+sdyaw/1DAivTjZekFhXeo8Ch?=
 =?us-ascii?Q?lXMYd9SuKPG2pSlGPM/8Yk03gDVxgyqmIHaC79X4SV5vLZe6BgIbfvgHajiv?=
 =?us-ascii?Q?vEgzWyfojJqMVwwaQTgi/irzq/uZ27z9v43zX1OdEXiY9vdNeVqgLppdfMM/?=
 =?us-ascii?Q?FNeFe2tSnt2Db4U+Razk4pJ8ymGNZ9HjcIjxs9ZXh5uTxvVpS4Pa2ji2NgVE?=
 =?us-ascii?Q?P4GU0UoBIvy8gsaORaNhZR/Vt6LRrmeRJywID2j/SyaztVXwKXpW/xFzisbP?=
 =?us-ascii?Q?G0bwB8dEHfkI8CbWXf2asm5SXoHhaV8Y3TLcjko4dCZi4EPPravm8rrTpbGF?=
 =?us-ascii?Q?MYd/q+gKkFqwsf1ifdI7NOwdtRbO+MtuyOVYSB3dmZrPLjKzwQJjYO62pdUl?=
 =?us-ascii?Q?k90/1784rBDVPfsfcw0qlgo2f84NmvDmZhIeQAPZ0qrsUwOvGAL0GwFtSypL?=
 =?us-ascii?Q?qH/t8HU/Jeu7ZY4bWvkrC5dvh5woG6WeN04nTV20Tcsrcn9z/VW8xbWQbgm4?=
 =?us-ascii?Q?Qz1jCEZqF3Mzk6qQ+wyiQPjuCJ8IrvhslsUqsL9X2npAGrF6WOWoxwwkwHuU?=
 =?us-ascii?Q?OpGwj2ZjTvCWFADzfaRfIn7Y53OKJY5ttiS4sfH5+t1QdB9rl1u25ejvp15B?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532b70db-dcc5-424e-f704-08dc3ebf8742
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:59:10.9770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IobBcBZQTeyimu+uocGjBDkW4JFetNcesPp2Wlc+taGv/Il+ztkoz3hTHDlHMzx4T7uTtO9rzGztGEiBRmRYIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9672

This adds some fixes to the scenario when the shell is run with
the -i/--init-script command line option.

In bt_shell_dequeue_exec, if a prompt was released with the current
line, all other prompts, if any left, should also try to be released.
If no other prompts are available, the next line should be executed
on bt_shell_noninteractive_quit.

In bt_shell_prompt_input, if data is already available in data.queue,
execution should continue and the prompt should be released with the
input.
---
 src/shared/shell.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index 7bcfcff3e..0e4cbb7b1 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -638,7 +638,15 @@ static void bt_shell_dequeue_exec(void)
 	bt_shell_printf("%s\n", data.line);
 
 	if (!bt_shell_release_prompt(data.line)) {
-		bt_shell_dequeue_exec();
+		/* If a prompt was released with this line,
+		 * try to release all the other prompts,
+		 * if any are left. Otherwise, the next
+		 * line will be executed on
+		 * bt_shell_noninteractive_quit.
+		 */
+		if (data.saved_prompt)
+			bt_shell_dequeue_exec();
+
 		return;
 	}
 
@@ -693,6 +701,13 @@ void bt_shell_prompt_input(const char *label, const char *msg,
 	prompt_input(str, func, user_data);
 
 	free(str);
+
+	if (data.line && !queue_isempty(data.queue))
+		/* If a prompt was set to receive input and
+		 * data is already available, try to execute
+		 * the line and release the prompt.
+		 */
+		bt_shell_dequeue_exec();
 }
 
 static void prompt_free(void *data)
-- 
2.39.2

