Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2053.outbound.protection.outlook.com [40.107.13.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1D112FB15
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555830; cv=fail; b=qMW50l9PrTFTJ87MiduNwma0Ld9YZH+dK32anx1cTzmPoOvfgNGMSJf17SfzykKxpe5ZG9QrbUlZiuu83R7yLIa7EmlZnBfbJRBSYiG+xpoMfzr38Ggx88TlziMqi0pzggjVVezyKHowGg8vfUVwPHIGWrv8frns2jeUK97w3Ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555830; c=relaxed/simple;
	bh=zIH9iSgIXT548tfy5viO+YEuUTeKYSEwp+GLdwdr8Y4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KJzkwW7KYOteFvW+I5FWB6yAOvL3jW7LyQw5u1iPfnHBoZ/pKaYe5G9TNC6bj83xGfdrd5NCWmhMWauogIqHO3oRTfUyEqRIzI2Z0PFyOi3lphRNyA7zTDVfcKa+Httn1FyMIudOJGc3//F+sggP2aEZv+tyP2SBhFtnFp+2YRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pz0vhDB+; arc=fail smtp.client-ip=40.107.13.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pz0vhDB+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sz4Ip42EbGWFiuZU2WmE1YOsHodyibmqolJKxpDE7YBe8zrSGARLlAua0zpnjeqjgK5Eq1Jo41T8eFPbJl3Y8920ZKav9vl8tpsVRILZqAQf0NMmGZqhmKKzKLZGyMU9Q9+zzAooBXYWm4snYe8MWH5MGKWB67FBLc9dWRm/sY0v36wsxNfVGmsuu4GQpwIg/ZJ1ERWnENLE10w4FTPtKLGl17AumZSy6v9gUoB2na7/rrRtUt0GmanA3g2ocreBemmjt3kDq1lDBtxbLUOoNXET/ipDKctTdX+2wHmtsqIR0yw8qJHZMmpwtqGAvselpzjwwpsYFIqGKyfXF7HB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wxjpBmVDK9NBSoV+ZI2+ywhrdy3FkUas6+HuckxLBsQ=;
 b=cpYNJX/jJf6IKqgiC5Sx9nbv3Gp+1vLKpwqxtYBG0UgDxdUL/zEiW/vIu/4kPWnmIxyK0bXUt/P3nGpXksQnAe8XWVTG3vwKfV/COJP8fjJEg/jy2qfS9Qj1AS+9iuC6dlr0MDxy1NuOY3eFD8S8xDGbxbJc0mY2VPh4IJzrso3HpM8upTW483L2lmbjzVL0yOxaZv8KH9ohOsdd9NOTWJ6qvDsZrrLH6SQJG8RdUeUID5KnyQTdZvcX++ATQ+20Q6MtM6JOON/UduGxTN9Gh5YIie4MibwA/dJ7MjGoFpNO20PH/wvLSND+evziH2uJFAaI6HI5Kpuy7bYLIsRt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxjpBmVDK9NBSoV+ZI2+ywhrdy3FkUas6+HuckxLBsQ=;
 b=pz0vhDB+PcIIb2CvpGNa9ns/ieXE8SA2YAiY+RqHYNhuQSXn7mULi68iAwhcyOEvD+9x1etzvtM61CoV3SyZKvT2GXAvdGCP63kdyKIsDoheAj2mAvoL5234FYjM/XtB8dfBS0YXjIsv17uEMQa7FzUfShZaAKi9I/9cr57abBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7648.eurprd04.prod.outlook.com (2603:10a6:102:e4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 16:10:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%7]) with mapi id 15.20.7409.028; Wed, 27 Mar 2024
 16:10:26 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] btio: Remove POLLOUT check from bt_io_bcast_accept
Date: Wed, 27 Mar 2024 18:10:18 +0200
Message-Id: <20240327161019.3078-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240327161019.3078-1-iulia.tanasescu@nxp.com>
References: <20240327161019.3078-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:803:50::42) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 61ef5eee-1f5c-4eca-08a6-08dc4e786a53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	emoD+CNIbftMZEHT5YjRnIXsiO9a5YFKOkR5QjcAq4a+5WahLrRXw68TWyYotEClXeO4coPZG76lEF2xjDea542kp+bhEpmjfymguduUqWcVQ4g2ZTowGYdJrSuDAQBWP4rsB6yIh8Dvi0VSBirU4OSZL3sX99WN0uqiDUgDY0k9DQLU58fKcwYb9I+htCTFITPrOsGxXvpQpI55vXN8Tce1+73rC4GGLgWoNNxKFCzHH/Baj4hY9yMey0t/ivZEGewEkPnPPlxvdZPU1NlNZMiV+IGMslDLiZb+z6YFJk/7VfWPUTbuFe1tBaTd4aEhf9sxU2su1L8+QxummeoDzuFdsBrxDN4z/Z89AYDewIQdcLm6IkP4VrmlLrk+5GSVkBJLhxE/7br1afPzLoq4FzRX9Kugj/RwQDvwpCeNHW/1J2APzKVNEfeSLZ3EwDFw09cp6e3YV830vzfAsmIVpJs+n6RkKOxDQKugnE+82adGl+r2DAoVzhZYRjpVX4psFzvMzbQgZpnJxaUzpb5rUoHttBZUqt5B5bZGBN4sFeDwgnMkz2ihhEliT3xtG69VMixPG4qIVTc1k1ga+hC/TCyqARAy3trM9Jfa03f3Xobaao0Ornw0YuHV0WNUtK78tYyjcWP3RoxyBxcNX1L/++Z3Br8JHdyhQBycyj/EKLg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tKvIdQlWxvdRn/hsbH56TdeA0L6D8+DR1evseq89icTVWoSds+S7MOcIbgtN?=
 =?us-ascii?Q?LDMalbIYN4DAd2mBSqubAyhEsYHtyAavBS8kv40N5U3xiP8M95+s2caZanFH?=
 =?us-ascii?Q?xIs5QjcxlQ6/KqkAXI7cgu7c53URhtLRsZuyL2gOatdbhlLIkAWbASiWvbf7?=
 =?us-ascii?Q?0f8pY2aMc6bF9JP8I+cq691gmfulR2bZbW+ypFVfV7KsRKnUAT43kIXbihIu?=
 =?us-ascii?Q?9JhV4LiIT25lcDj4aY/g0VDLwnR/S/KJCYnjAkvvfvrVj4t+NOBnsWiR4d3v?=
 =?us-ascii?Q?rWYmGqmash/dUugMeIsv0f+V7qS/H84yudBBRuHqGkwD0jZg8+n98yDAxnBT?=
 =?us-ascii?Q?dPzRHVDfGKvFU+HW12YrYeMmjIOgEkM1m5H+38lvr2m57KgtGu9qD79F5Cvg?=
 =?us-ascii?Q?gS+rGlxa0XNFoe3E59r38YoXullT+NIV91jHdeL28ZO0VHi3H9AvkJi0JQug?=
 =?us-ascii?Q?QQr9KL13XGM/MjuBT55/cBSxrDO6gIBqLKJHbqiFMDIRBkYQHMYVhz/A+t8e?=
 =?us-ascii?Q?mNN9ps95zW6DaBtztBfsB9cEGRHdmToRRISnm2CjQe5AR0Ieyhg/YHBPN8rr?=
 =?us-ascii?Q?DCNPUfs+ciscWAWrlQT9IWnFiIslT1yaYc3aAKuhZjDdoGvFf4V8eO+FC3/8?=
 =?us-ascii?Q?Z66yBQxf7I7ouK7B7g7Mm+Z7zur1z0GdgAhpruJyNSC3h+hKAUmlWfH7jgzI?=
 =?us-ascii?Q?Whseug7diJrVt+Sd2F2qBXr02BcFtwirdb66ljUPhk7H+fFDc9raxUWPTmQk?=
 =?us-ascii?Q?vfCGPX6ISYcErPdxuUK5NOBvvqU3119XQ9ZEmlv8pPM1YAH3xV7mIZ3Aml9W?=
 =?us-ascii?Q?pl3ANxMZDzTB305Dd3yNksyK9czAzwqZS90b8OhEJcTRt3ayT3VlwuEJYkgp?=
 =?us-ascii?Q?GUsZe14Qyjf1/+d1T2JzDR18uWmVH7qTUkyZ9B/cLlg+nnIk64lmvu975LcN?=
 =?us-ascii?Q?jcAMOLJ2HKAJ3uZ1D8ksmyjTBxQ/8avcG+ss4+KKNyfW//AlxOWAOSGIZfvd?=
 =?us-ascii?Q?xQijliPssYqQNPDFI+czOL1J+xSRfmO0TB1dUTsQ3emA7MG9Liz5q76IQ3Gt?=
 =?us-ascii?Q?Aae6AR6oCmm+oNGLajWo/1ndO6zn9CEFzFN24OWuN8GxLefkYgNQrtdlbOUR?=
 =?us-ascii?Q?K0mNZPED2zyGjMB0CbslY7U/R7FAYhSMx74ZfXaWGTadlaZDotRrNZB2LmrR?=
 =?us-ascii?Q?pACjih2Rt7Vgst748y1rcin5FOMdudgVTEFOB4SPe+KPt2dx+Eq3o/0UxNnS?=
 =?us-ascii?Q?5IRxZu7PkYgl3r5HKl206ecCOX9o5YQxFyYGKSFB/lPLOi4TugN4Zw/nb7RG?=
 =?us-ascii?Q?L2vSUPE0vHjGi64kB8jEoB9U2N/5fCkELRKWl6nZCyeGXdgpGviCpvdziWjj?=
 =?us-ascii?Q?BAzUp7/K0H45TNCwpultgRGbAkfNXeje/sieNTXgnXQ8uO08HdFccnfVmoQr?=
 =?us-ascii?Q?cSjERgyzX8RbGNq52aJkJOcS1+2fj96+TTZZnkTODUz0VScjaX+3CsR6Xd6H?=
 =?us-ascii?Q?k00axZEf9XfS5P5klNMSKJ8KXcrxVseOLn1BmrwTaQuE6MHOUiptw2GJ7m5N?=
 =?us-ascii?Q?0UjmxaCTpv4YYNbMdiZdj7RDB1MOOFRfO+61jWYVTAYrcf3zKTIxucACy/X9?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61ef5eee-1f5c-4eca-08a6-08dc4e786a53
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 16:10:26.7727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DE04yRMb2cvBgSAOgnRihJ5k5CvQm6kX7+ZIDfzyxYLV3uq3o5hxVDazqGkuN1BcGXuppD1wI/80llKCgCYLHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7648

For the Broadcast Sink defer setup scenario, there is no need to check
for the POLLOUT event on the PA sync socket before calling "read" to
issue the Create BIG sync command. This check has been inherited from
unicast, but it is unnecessary for broadcast, since currently after
accept and read, the event to signal BIG sync established is G_IO_IN.
---
 btio/btio.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index d30cfcac7..2d277e409 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2009-2010  Nokia Corporation
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -1800,7 +1800,6 @@ gboolean bt_io_bcast_accept(GIOChannel *io, BtIOConnect connect,
 {
 	int sock;
 	char c;
-	struct pollfd pfd;
 	va_list args;
 	struct sockaddr_iso *addr = NULL;
 	uint8_t bc_num_bis = 0;
@@ -1857,22 +1856,11 @@ gboolean bt_io_bcast_accept(GIOChannel *io, BtIOConnect connect,
 			return FALSE;
 	}
 
-	memset(&pfd, 0, sizeof(pfd));
-	pfd.fd = sock;
-	pfd.events = POLLOUT;
-
-	if (poll(&pfd, 1, 0) < 0) {
-		ERROR_FAILED(err, "poll", errno);
+	if (read(sock, &c, 1) < 0) {
+		ERROR_FAILED(err, "read", errno);
 		return FALSE;
 	}
 
-	if (!(pfd.revents & POLLOUT)) {
-		if (read(sock, &c, 1) < 0) {
-			ERROR_FAILED(err, "read", errno);
-			return FALSE;
-		}
-	}
-
 	server_add(io, connect, NULL, user_data, destroy);
 
 	return TRUE;
-- 
2.39.2

