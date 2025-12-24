Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011050.outbound.protection.outlook.com [52.101.70.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7F42C0F8E
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766557834; cv=fail; b=nbBbBwmNLPLh/OUP9VlDfmZvW1GKN24RaEU7KeMVLlAQUMsc7+R/IiZLu9sV748AT2TzAT7LVzb+xK2zEoK1TeQBC9XNk85rDU/F+0eNXwQ9/YHPdjc7w0tkw7Ml9Z5qia2jqriotPDKFw2+qPMBD78VyaMjgDaX9niljbUuen0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766557834; c=relaxed/simple;
	bh=s7qdNw1Ipz0kFQO3/xBDFJiVViJ4jWP87uzYt/AkwBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u9PtTgSCDlwm/b3EUfoy8SXayoF06H+caHaJljmGCcwSIVoSEMAfy27DL2aZhRwELmnrq82LzrAy0nbS13rITM+8Xn/zmYhG6Woh7RKtlqGcQbLBWgVazKWYToP6W6j5cq1dAQNDGSK6eWRJJqnbzy+RoyRZH14OtThpvO7xqSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D+aKepwC; arc=fail smtp.client-ip=52.101.70.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D+aKepwC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zRzZi80yFSaZzkFRWU9EDEk49D6FLyrNLcI/jzjgYEL6vttuEKzHmpsWkrMQC+iWYHfwBOT4HrnXDgkw/uOAaNdqD7lBcwSVGD4cSxY5ZZ3cq4qHUX148PP/QNtFN99CuigtvFF+GskhrLTgUS1tXOw7v55zPp/a/sRMe0E2yEmKfa73nvXQo8Ec6yP0LL0zfG92atOH3r2odVgP7liiSzjts8YCfZndJobh8u/eLxa/bNOseRx8ac7/VFv3ewFCBpj1snYw94yf6imAcrv5fHyjplsxtVARh1BuZ6D8p6tF360Nf8lsBKTrN5DdUoVskHTchNdDEuENjECV9Lmx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uaZEO9aAJnPYhDuLdUURg84MXSVkhWL2hT+3zlcGyw=;
 b=d4INOvHl0pycMF5mhZopH5GPikUDyDyyKz8R52xRvGhaCHdbWqqylg5sLTKRyg5WfELX1JMu6XB3Bu/dzmw8JrLkOM/NdITaJGNgaOnDCksYoUuZDQmvQPEUuvjoG2uf80+H/To/DlqLzFFa3NyOWbs4R9jRQ/aKnErNxw7d7yHp1kNTKG0dZUT54bonnpgLKHmCLMBl2ZphvBlB54NGu2rd4veke+6UgPYdbg5kbSbzPlJuUcWhzCCH1hToq1ZWpLzW/meB/fZ1UyKFgbVgR4j8wx1GQgYfeSVKHDyfzDbiu+5mBwsLmIHVF5zVsBaZt5CmXg4G1x61uFCirtPTrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uaZEO9aAJnPYhDuLdUURg84MXSVkhWL2hT+3zlcGyw=;
 b=D+aKepwCzzcETp7eKnAMcFPbFI9GD9oE8pUPXDTJwJFOW54PYRt2M7bXNTPN3xUeixMGRNypqR7oC5Ujk5CuKd9ImI21Wp8zUQdTaibsReZ58rZ5VGP1vZBZN6X5txR+Uaw2wx5Qzz6ncyiVzLOCo2dak0l4r9iSaAPIzfjqTX71TiNVGTGxlgEzjFvHkdb7k58lXz5IWkUD3EqQT41Sr1i/onMFp5dRAgO6ue0+LD2ENmclBqxI4NlpW8ALVhjw6X2Mvjl9myDvyf+NiG2YKWYdIyEpzpB8PyQKihNpgysOC6jZ2OHlcyzrkznXmxwumD+1tDU6r3BfH2pWxiKeqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9)
 by AMDPR04MB11651.eurprd04.prod.outlook.com (2603:10a6:20b:71c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 06:30:30 +0000
Received: from AS1PR04MB9454.eurprd04.prod.outlook.com
 ([fe80::cb31:6735:6706:519e]) by AS1PR04MB9454.eurprd04.prod.outlook.com
 ([fe80::cb31:6735:6706:519e%6]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 06:30:30 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com,
	vinit.mehta@nxp.com
Subject: [PATCH BlueZ v1 1/1] Enhanced Accept Synchronous Connection Request command is handled in emulator.
Date: Wed, 24 Dec 2025 12:04:39 +0530
Message-Id: <20251224063439.2477969-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251224063439.2477969-1-mahesh.talewad@nxp.com>
References: <20251224063439.2477969-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::14) To AS1PR04MB9454.eurprd04.prod.outlook.com
 (2603:10a6:20b:4d9::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9454:EE_|AMDPR04MB11651:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b530ca8-1cd4-4975-5abd-08de42b5ef49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?50NmxDjOUEtiwvXe7bsO1wZg79ADX2sJY1gDafN/369PlY39T7WqyUe46+D8?=
 =?us-ascii?Q?ICMWebhGG01ZzBzrzTmtyhg2S069fqtqwILUPp+c7nfSEInLWhXvjA+BEMVK?=
 =?us-ascii?Q?c5K96C2ykqHEAIXGFpY150shhnKv7LQwonpMrIjTFRAAzO9aqu5Y3yrYccuB?=
 =?us-ascii?Q?3Mfn6VDYFmpZ4knMWN3OHnK49zcfhmjTBiG48G+6sf48LNSy72g3yEWP1VS8?=
 =?us-ascii?Q?ds1T3CW6LKp66gDSCt9VEZT9oTxeWhdEpKB4MfQzvytXtmgkeyjGbMt2xwRL?=
 =?us-ascii?Q?ju/gdMyg2RnfWWTXZQXyy17ubf5sC8WvHrDg29SFof2E8eDcosxJmYf2aaDJ?=
 =?us-ascii?Q?OyfdNP73RL6m07OGQvdHtKEsPpScJr8B8FAZmlj8WszijkyPnlWub2dlACPI?=
 =?us-ascii?Q?8LnKCwOl7JdFbjVYbDcywYizZ1lWBBWq7npmtRlO35m0OkSpGBxjjIdGK2xt?=
 =?us-ascii?Q?SrsJevQxvuGEz+YDXJ/l2OVeGFAUOLF9JPAqm3M+dnmLvTbf+TmTJkNokUfR?=
 =?us-ascii?Q?g/9kcZXgBMmEoSzt7B4+Ss3nqJ09iruRx0UMZNrXrrN9UvfIxtDrFG9IirzQ?=
 =?us-ascii?Q?OGecmgF73oRSEqHutxdMeBzgxOsJXh1GWWjov5fsJTVj2Tu5H2RmGO+F37aN?=
 =?us-ascii?Q?yutxJSNKwd9MH1lKLtDCm6XrQtmqigj9R1t9R/167+EqqbMEFfPSIX29JuqF?=
 =?us-ascii?Q?xE+/cFQQfQP/XT/jPSD2jfuBh6cYozBswfkSF/7g56PVRJkN2qDcI1OF1ibn?=
 =?us-ascii?Q?CSLI5SrvbzrJPXrfXSOqZ4OJ7PmFGXQRiRvYT4sBLiF650xGQlyN0Y+nU8Pg?=
 =?us-ascii?Q?DnlkAFuvqblcucHhXPz5q/DhQcC6LWV8/xFODfbytBx4tcnYoI5tNM5elBGc?=
 =?us-ascii?Q?WI45ZmFkFet46rKlmJjrrccLXWt+eIpygjin2Ga9QgdFiHD2uiueCNtFremI?=
 =?us-ascii?Q?kg0am5+GLPUMTOX1l63cn/5/h4cxhYlOAch4lx1UWTgPYN/WICbzmXhmRjhS?=
 =?us-ascii?Q?6oAkqXdrLvxtJfW51PQBqq3xH/XikIlNGvXKLg3ZwnBl4O7ODvaecMpN3LpG?=
 =?us-ascii?Q?635b0BiZr9sZAG5hSmzS9Kue9i6ggQyHoeCoMgtmifxTX/ueHF81+Xi+ILlq?=
 =?us-ascii?Q?g6JbyWdoeoeXMz/mnA4jIgYekdYkRwJpWh0nYA0oDGZj2zA5o9FPX7IjK0Ca?=
 =?us-ascii?Q?iI5iAH/z1L8Sx5LCJabmK8yff8FkHkAivdzLV2/n0lm1me6xgw7utqlO7z+J?=
 =?us-ascii?Q?oaMZddrnAOog1AgKQRllst1jmyHGxse+E4tCOFEvi1BnvnyfrGYnquk91SDo?=
 =?us-ascii?Q?PJ/46GUw9dFVF35pAG1tYGipXc/GCdvKkHT+0wdrypoUmnFxDSfkEDXSXDCe?=
 =?us-ascii?Q?UBK1ULfKiWtlsMCxx4FKUdSE+H2YHPocOmJyIAedQOwLxSnwModFPxjvoSz9?=
 =?us-ascii?Q?4ogBh1fFYJPtuShYusx9gEmfIFA86cR4Qw42eMfIOJWJm0xIKaQZYpVSEB/L?=
 =?us-ascii?Q?TnhyRQvD5HCH3J6OMk/VuwITSkMU5x+yw4wv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9454.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m4y4N0JZ5gEOuVxK24iF9p75u/ZhdN9EBYzdFEtcQNEDKDyc3t2ztcHTp4WW?=
 =?us-ascii?Q?NxBGoy+deZXwYG6aLUzKjaHKbMQFwsePTtlAMrRYT8LJEn7JTQCkrbO8sNmf?=
 =?us-ascii?Q?QCKJaCyNtLoj53ifccdMva9jy8GP6Dj3vW6tTY3JpfwmlRSlZlfqFPkvg5lY?=
 =?us-ascii?Q?+pnj2ANDOHeXBT1Pxe9AflqjbUQouNYso/Zy5QS7agoap96wxJus7i/w+ttH?=
 =?us-ascii?Q?8iBnutdv8PUOcMDIYJ99I8NLrvWA5OrvMLvQkc+4Jy6GvyEirHsvtKWgsOv8?=
 =?us-ascii?Q?C/s0SsbrWes1xAJ8JUUVy2umP3LniAiwRbkbv4U8jzNL14YshEowWb6kxNQV?=
 =?us-ascii?Q?S0YWFb4oQei086Y4lX0EyxEV3sTxu1WhWdlc2K9q4B/TRdCs6o72em08+N5P?=
 =?us-ascii?Q?rkjyYqmplRSfxSYnDR8vy/mDqc9ZOYJce/o8jtJUmDthVHBpqoK1LnvN8c2S?=
 =?us-ascii?Q?xf8sJ2sJjC8OwKD0LfAg/CGElSQLmfJN50zybCUjvhESWu9fav0fuaVxM529?=
 =?us-ascii?Q?fFadn5myqwLV0Zp6PZgIdSkmF5GsrNAOCx8jUJPM3yTbjiCV+V9dWDaf9oPl?=
 =?us-ascii?Q?i9xud30dF1+AzhgwOjtHIpfEY4zpkE5Yvptr22uybX2UcVZ2s8H/LBKEXcjS?=
 =?us-ascii?Q?MKAH10EJJz5FbqyemZndhYUXnVol/sYOHjyFfIyeZNoGX2hWZ424ZgPvdMGW?=
 =?us-ascii?Q?YY6y4zluCxSko+5vjYzk7ScbgwtvssTvQltakDbYlEQK8l2XptTggWm5sIgi?=
 =?us-ascii?Q?SvXscXMijuehLSsW48z9FgvsQ1iY9Or6jc1I1fSNIR5EN4w1TxOa7YzS6w7i?=
 =?us-ascii?Q?8+fnsvH+JD+MX1dv+sDXqZBw50/+7wZHMAKeiBg4QZKtZXtQHfeu37zEqdde?=
 =?us-ascii?Q?IwDaXT0aoKJk3ICOqnYSFlxlY0e/rx+EtubJB5kpRDMpVN0fqC6l302oJfLU?=
 =?us-ascii?Q?C/TRBnNNadRL11IdUjD6pC0CqyZPRvL5n0tLJf3KqgXE9IRmlrCGEDwCPCLH?=
 =?us-ascii?Q?5ZKqkSX7NTfA4ZksI7y+LsNtMXOQnPaGS3s0SJIMphhptb1eKrctH/PYPFeg?=
 =?us-ascii?Q?/7hz40bsemKA/pkYKtn1FptzmMPKhJ4YBQ5nVDneW+6OTRNMad83jEcNnxOC?=
 =?us-ascii?Q?BTo3AaTgqU4MHu4R+uJEzWk9IqCwdKKvI3PxY/UuMktcgufM+FMDmfidbuWI?=
 =?us-ascii?Q?cHj3wR2XtoYJGc2doaq6xbeQSpLJ3B13KQt195lmpviduTupV2p9JcvuV0dx?=
 =?us-ascii?Q?oUiSvWYNqvy8qlhL4MxQOxFs8NZbE1DFb9zQNgOSaGyF9mXYMvieyG/If6fM?=
 =?us-ascii?Q?8AWjGOvzmBNYddDovqCZTA9n2Ab1HwFRVz/OWQvdBEKHZoXEnFnukouUjSCF?=
 =?us-ascii?Q?8gDOFh4qHJfckXjeZXrza4r/EJrWLFQOX1+W7UU8Yh1uI68DEUdIHxlGjUnl?=
 =?us-ascii?Q?WbhydEMOz7I5QNUTFJ5MMCfCxTnrxGGfMT5gvn+uVojQ0Em98qwjKm8L11kn?=
 =?us-ascii?Q?DIu+PV15gYfSH490qrrehzYZ7er6A7jnsqgP6sC8PrVqcdcmwSHLauW5TxmZ?=
 =?us-ascii?Q?yqP2ubDFXA6nb4QXH1XYG4B+VKgCyYk0PBZHKK4v2Ukw2BixKCyydPYHktxs?=
 =?us-ascii?Q?G1ovhn2HHqHWz9ekTvfSL7WlCf82R0iBlz8ZqsZ1tXDhWWi5I4lnkQHf5waT?=
 =?us-ascii?Q?nDh2SKNDWRTsZ7pDoGoh9C3+YmVruFjYpkJ1f1RX66VHEZN2P//gyf05uCAD?=
 =?us-ascii?Q?pLz6Er5R+w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b530ca8-1cd4-4975-5abd-08de42b5ef49
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9454.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 06:30:30.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6xkcdSU2w2bkhR9D7XYoasSXpqKsxzHHl/PB3ZT6d/HtY/fAjXkbsXl/GSUEcNv6lOTSlKDqs33WZM4aDL30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11651

Implemented the command - Enhanced Accept Synchronous Connection Request
command in emulator[emulator/btdev.c].

Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
---
 emulator/btdev.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index be43623e8..55367cc7d 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -3434,6 +3434,64 @@ static int cmd_get_mws_transport_config(struct btdev *dev, const void *data,
 	return 0;
 }
 
+static int cmd_enhanced_accept_sync_conn_req(struct btdev *dev,
+				const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_enhanced_accept_sync_conn_request *cmd = data;
+	uint8_t status = BT_HCI_ERR_SUCCESS;
+
+	if (cmd->tx_coding_format[0] > 5)
+		status = BT_HCI_ERR_INVALID_PARAMETERS;
+
+	cmd_status(dev, status, BT_HCI_CMD_ENHANCED_ACCEPT_SYNC_CONN_REQUEST);
+
+	return 0;
+}
+
+static int cmd_enhanced_accept_sync_conn_req_complete(struct btdev *dev,
+					const void *data, uint8_t len)
+{
+	const struct bt_hci_cmd_enhanced_accept_sync_conn_request *cmd = data;
+	struct bt_hci_evt_sync_conn_complete cc;
+	struct btdev_conn *conn;
+
+	memset(&cc, 0, sizeof(cc));
+
+	conn = queue_find(dev->conns, match_bdaddr, cmd->bdaddr);
+	if (!conn) {
+		cc.status = BT_HCI_ERR_INVALID_PARAMETERS;
+		goto done;
+	}
+
+	conn = conn_add_sco(conn);
+	if (!conn) {
+		cc.status = BT_HCI_ERR_MEM_CAPACITY_EXCEEDED;
+		goto done;
+	}
+
+
+	cc.status = BT_HCI_ERR_SUCCESS;
+	memcpy(cc.bdaddr, conn->link->dev->bdaddr, 6);
+
+	cc.handle = cpu_to_le16(conn->handle);
+	cc.link_type = 0x02;
+	cc.tx_interval = 0x000c;
+	cc.retrans_window = 0x06;
+	cc.rx_pkt_len = 60;
+	cc.tx_pkt_len = 60;
+	cc.air_mode = cmd->tx_coding_format[0];
+
+done:
+	send_event(dev, BT_HCI_EVT_SYNC_CONN_COMPLETE, &cc, sizeof(cc));
+
+	if (conn)
+		send_event(conn->link->dev, BT_HCI_EVT_SYNC_CONN_COMPLETE,
+							&cc, sizeof(cc));
+
+	return 0;
+
+}
+
 #define CMD_BREDR \
 	CMD(BT_HCI_CMD_SETUP_SYNC_CONN, cmd_setup_sync_conn, \
 					cmd_setup_sync_conn_complete), \
@@ -3471,7 +3529,10 @@ static int cmd_get_mws_transport_config(struct btdev *dev, const void *data,
 	CMD(BT_HCI_CMD_GET_MWS_TRANSPORT_CONFIG, cmd_get_mws_transport_config, \
 					NULL), \
 	CMD(BT_HCI_CMD_ENHANCED_SETUP_SYNC_CONN, cmd_enhanced_setup_sync_conn, \
-					cmd_enhanced_setup_sync_conn_complete)
+			cmd_enhanced_setup_sync_conn_complete), \
+	CMD(BT_HCI_CMD_ENHANCED_ACCEPT_SYNC_CONN_REQUEST, \
+			cmd_enhanced_accept_sync_conn_req, \
+			cmd_enhanced_accept_sync_conn_req_complete)
 
 static int cmd_set_event_mask_2(struct btdev *dev, const void *data,
 							uint8_t len)
@@ -3604,6 +3665,7 @@ static void set_bredr_commands(struct btdev *btdev)
 	btdev->commands[23] |= 0x04;	/* Read Data Block Size */
 	btdev->commands[29] |= 0x20;	/* Read Local Supported Codecs */
 	btdev->commands[29] |= 0x08;	/* Enhanced Setup Synchronous Conn */
+	btdev->commands[29] |= 0x10;	/* Enhanced Accept Sync Connection */
 	btdev->commands[30] |= 0x08;	/* Get MWS Transport Layer Config */
 	btdev->cmds = cmd_bredr;
 }
-- 
2.34.1

