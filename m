Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB68153BDA
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542183; cv=fail; b=j1dhw+H7xDDIfFp6gvEpT70ZUJogMJcIvvzY1Nw09Ihi14Hh8PNRtB37s8zkouRnBlIItrh8Fh4r7sWP3SeGVLjiftg2kkH1DArQUcwYzuVKtNxX5cJDNE+xPYnLacxlT6uNXtoJTrL1o9MruWrk0a08G5hA1+kU8l8B3eBflCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542183; c=relaxed/simple;
	bh=pwMFIYousUur8Ls36TqoZ9CQY8RrSszOZ0fW9GqIKt0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VejXSB+iRBNTHHTnJap0o0UUd7ZQfGiyoQxqseIC+4RcfVuLdQ8Hy+kz+a8ODglxUNvHRhg071oQsBD8iFCnkeenHiSuKKLVnlS7K4g9SV4vyeXSKCbcdcMlNgybm+jLuqmcXaTNrjdyj2gIkEbunTwaQMLnQ1RpyIMf2s4hbb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K9m7U/Ci; arc=fail smtp.client-ip=40.107.22.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K9m7U/Ci"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkODfRMlwX6ZKIEIbTpxPofUpd4kGMw1oOXrvytMkQvEbMa9ImJk+yi+UDlHf2zNkNlHT1bKSxMMT/RY2rPx0P1rO4/W9VgbTzKuerkgJ7BDbGwYG1u18z6uKfo3IvUpkm/Ld4mYcPsrtyHOZ0n15kx5GfeaP3ZAbOvCfYr43E+W5c0UJPPG47Meg+o7yhaQ2tX9/EOE3f+vuhv4DIHqW9T3e18b6tkJhMyn8wHTD0SrG8Egiz5L9z941W6O9ZsO65ZcUnabx23zhpWCtyVgQp6VY/MhkGMsf8iwPcpXNoE+UhNZWFqqHwenxuJFYaPbpDSpJ7OncrBxk1OO49SJzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJsF+7mfs3JuccU0WkVIyt/RxdiDVX48GpN8uDRWab8=;
 b=D/W4ft4J6oPqs8y6K58O0Xp3sRTGknRDiLZP+TM5MhNLcHxUBrLn5wB7s6fYLHreFGrg5LHVFDktooN0lVJk24T3LCVq7H7Y89ouCBBdRMVVYGDB+J388fYgRS/gOYc3w/FXggO6PYGTepjKsTOs6ssu688je4GCDKnAkhnKW5c7tCSyWi49gjX0SVhhhTCXKmUjXWbNEUEJpye7eGo4wGZKMjYC67oHdirm8TJeiwkf+AXwSWwZIb/016aUUKmjSjIvUP/hJk80MYFhO4LFPWk/iZBdi0ge2Rx40J6htwBgj1yhtSG/Lv4RrmQpNP8+oV9QmM0f7Q2yGOfZyN9uqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJsF+7mfs3JuccU0WkVIyt/RxdiDVX48GpN8uDRWab8=;
 b=K9m7U/CiMkANxQEyHWmtvfkoUjmCJPRgTAffLHfhH7+aGa/Q0jui1T4urUb8j7Mb+vK+ZhHp6c5IUZAF4IfqL2lCIo6B+HjELLl2ghkulYMQRrn9ikB7zIWR9wZHyYJm05nE6xfZvetgCjlAeMejkr3p3OydGOD0hcKr8UgXiWg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7105.eurprd04.prod.outlook.com (2603:10a6:208:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 15:29:39 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:29:39 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/3] Update bcast ep register and config props
Date: Mon, 29 Jan 2024 17:29:25 +0200
Message-Id: <20240129152928.3904-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0160.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: d57f49db-1829-4702-a39f-08dc20df1b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rKnSELOxqIxxTX2f3do9AXrT/mPsZ6WqaaDzIi/ZE9aLoTNsn3/zAI/wsMGqwAYQuIfJbOswBj+MXdBGAlhq0+NNRl1eOATWUdyOOEJtp7mGNBpdJKQwxLHXGBci6kLeA8iN8k4k7RUB19KXcYXf7cbaBkoPSinnaY4HGEcf/zhvWXYt/R5+Vo0w6Ev9XCrt85bHQr1xOagPlPrMb4Hqaf5qdP7fX0q9ZKtL6vKAc1hg83KpAvmrkYmgp+KbaD46N2D5hGyForWU8hKyrx0x0JvY+AttL+eEBqiUskzilmMYrM9L8G4OYO28SdpKXYOux1v0WXCHsw4SI85x9LP2foQBFaIcYlagZwnHtF+Mi4CaULSgQg1/jeff13szBfDN6Cenc7mDGtSXvU7bAAA9wXbkebY9AAZwtNHSniUlOGOMgTXvLYIZHN0SQkelVhqsYS3mI8BvxaiByEUcBljngmuFhz7OhC980cnEdha4/muKp+9gXYYuUf6FigN7ZRDOdGcQb2kTQPzDBLmJshJSu+BVjDTBrxmVRwJlyL1yZtVJUtWUSIeOk8ewFK1detTN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(6916009)(6512007)(38100700002)(2616005)(1076003)(66556008)(15650500001)(8676002)(8936002)(4326008)(5660300002)(44832011)(6486002)(6506007)(2906002)(66476007)(478600001)(6666004)(41300700001)(316002)(66946007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gm02MAuH+5A/syUVya5aU6xEBNFwYWkK//MjkTJH6hvromtvRiQSUOwm6ZA2?=
 =?us-ascii?Q?dmExvvcpvT3mAx3y9+XB3GbHvrlheHgtKIVpQdk7I5cDipmCE4yd9OJheWuj?=
 =?us-ascii?Q?zRQTdcFCnZeEIupwEcqSkSkxfDVpqapfOiatCMAYAo/EvJhkfceJX7lVnqko?=
 =?us-ascii?Q?Kx4KHXMZbHex0+c+K+yciO1dSJYu+++wwZPPUw1oOikbcZB00y1fy+AfAYPH?=
 =?us-ascii?Q?xyMWNTm9GFVmji9nek2WCey6qu2xdoPkMIXBLayfz4py03uRwbGeX9e5MSzb?=
 =?us-ascii?Q?rcBeBH3U99FJ650A7FAbPDQc70Yn8gF4MQDHdpqK9mIBPYwUvRYFItbuvDfK?=
 =?us-ascii?Q?SPWSHhACvH6NYUXHN9fZcUPf+eWhrLvQx9iUDzdZIZek+7BopTLS69kbF3e5?=
 =?us-ascii?Q?AJLzKK8PDlmtR/llP0T54IZfwfkXGVH1k81NDu/zhJTxKSFZoO4ASFZcgzgI?=
 =?us-ascii?Q?ILdRAylmeLkFLlFBMxVEqTi/TJe3lpQ/Ap2p1xfzSzYpdurk4+IaW8K7OHAS?=
 =?us-ascii?Q?1MGmkLdfl6Qf3Ytk+zeHvB0OdgL8cbXCnFL2t/t/eaL5S0rds9BHYljiSJyM?=
 =?us-ascii?Q?RNtMl1DPicCw4N4WhbUXYg4XclsX420b+t1fCVQG6i9D17oc6W8qO9Cq6/ux?=
 =?us-ascii?Q?8IsTuL7K6lpzlVD3lw1w8aLSWkTMsP3w1k3yj34DO4pUiI7BJJKx8o/Y3/HL?=
 =?us-ascii?Q?TYaukm2RPt1Luo9b7GCMXilXQxAKlZzacqW1TNPqmBwSRosutwdLTyXRVXVr?=
 =?us-ascii?Q?JZX0CnkqmdJmrMQvJUUpsCLqqXrvY7MKevRdSNfQeM2sfGST8o+pm1fM0Nke?=
 =?us-ascii?Q?e7m4iBFByUEdwTr3U1/K7jjGFBkNJGYrnlymWE1ScZ5QK0y8WKHqESvsnAcN?=
 =?us-ascii?Q?VziCTRoxVtgBCI+L4IjH1nEeyIFe/OH0UO3t3NzYT/eo5WI8MkgCIqhLfD/Y?=
 =?us-ascii?Q?zBRzoR2kp+4JtmPCB+wI62mE4hzu0Xzkk88Wx2Dnz6nRLG2wk+mScdNONuXX?=
 =?us-ascii?Q?CJ+EpbW+Fr3bAN6FdRpsZZGhbmh6TPyNOd/10JVH4CytDrWIBE/S4T8BrQMg?=
 =?us-ascii?Q?hbCjBGpV9m3zjQ8nDiYClEhenu5rBPU6QDRKrIxWMdfoBBNDv+ja80QiZrsV?=
 =?us-ascii?Q?Fgh9OZ2XJBOLJRnfl8tty6z7oUJ3zMpYYpAfb9YKgz7f57b8JHodPN2uJn/i?=
 =?us-ascii?Q?xDEwk4y0Qnla9o0jPGMzNYMMfQHfJD1HwECWxtNVZZnY4MnpHkWCuma2IfYE?=
 =?us-ascii?Q?tTZruCSMMZ5GsRgc/fZiWYqzanpnrzJnqneJKgsfqz6dhL2p+mMEyfQ1h9Al?=
 =?us-ascii?Q?sFvlZMAIiazHmQLplutx1P/b/4q0U/jfdVwfEuQsL4A635lYglxvMqVMgDMc?=
 =?us-ascii?Q?fNNZO58dDuindSBrzwYoVYNkjeH4aypS5RqSry1jboTy9ZczulbQDvCQyYHz?=
 =?us-ascii?Q?gy6/W+wtHc2at9V4ted5tmbZPS+yYBif8ZOLk9cfHphOK2PKPV4zwex8p+Cd?=
 =?us-ascii?Q?Cowu16Q15Rbcn2+Ml1BJp1LyGD1qvHeFCikYr14z45ctGUr3WJIW64l3B4TF?=
 =?us-ascii?Q?luduqARWzBz3elIsNAm9qlIk1CtiYYFthTBniiP5HBt+s3ZsqfkbiIK8qmun?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d57f49db-1829-4702-a39f-08dc20df1b57
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:29:39.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OigYCT/8tvjwEKyEznjxN7wNIlQlXFKaXTAJSI/quOeuxcQJUHlEGnKpef3E9EgXiuWvvqNBprog2I6WSFkw8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105

This patch removes unnecesary input prompts from broadcast ep register.
It also adds support to provide stream config options at broadcast
source endpoint config.

This is useful for a broadcast source supporting multiple streams,
since each stream could require a different config.

In client/player, the input prompts have been updated for broadcast
endpoint register and config: At broadcast ep register, the user will
enter the locally supported stream locations and context types.

At broacast source ep config, the user will provide the BIG that the
new stream will be part of, the stream Channel Allocation, and the
metadata of the subgroup to include the stream. These options will be
used to configure the BASE and the BIG.

Iulia Tanasescu (3):
  bap: Parse BIG handle at endpoint config
  shared/bap: Set bcast stream metadata
  client/player: Update bcast endpoint input prompts

 client/player.c      | 186 ++++++++++++++++++++++++++++++++++---------
 profiles/audio/bap.c |   7 +-
 src/shared/bap.c     |  20 +++--
 3 files changed, 169 insertions(+), 44 deletions(-)


base-commit: 0de32f67f685b95c35a5c2f1206081af89bd88b6
-- 
2.39.2

