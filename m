Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000AD1BBBFC
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809690; cv=fail; b=t7PUSlCKotQQJ5SVz1QUwCcwu1S5iB5E49STB6ML7Q3ycF+Owq9rhidD8bPd2R2BKlUJczypeACsWmfh2FsBNtuXeIq1mShm8/OtJKVWEDwRllhptJRRAmcfw5oMWETkP/MBx+QrTgVMsD92OUMtq0fF9J3QwqZuBF+TAljb2Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809690; c=relaxed/simple;
	bh=aXyHDjj2yHVMDPwt2bb3kqE5NAjLfeMmOZWJiFYLOq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=naWgZJViAQ/KK2Ujgts2Futysp1aMa2RfOF5OK7cJYLq9BCbFErCKo7uAw7cRjk8zzQacp1kCwuWIELhMEEYc79IC/BvzjFtmgwzud8s8ODlt7fDivrRSJnaDsjJak6xoaEZ/Gv79EqhyK5aNF4z3hmV5KT/YH/VZ5+GiY3dcMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hYMR5TIl; arc=fail smtp.client-ip=40.107.104.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hYMR5TIl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ANER0f009jrlF98WfKq3kXFmWAlAWrsCGRvG7Z+yzQ+j6KCJXdxcrcq48uHyhbqs+BgYx2N+dCJUxa7gg+qpmWUe2b08DNTz0OqG7Blk2ZDQ5D4Z9xEqY8+zWOSwkWKIT5v5J47AsDBJykvFUKr00h0sKWtXNBePI6/ug697Nr4z/6UK17lBQywIImGVDZ1jsPoSNclUa5j95+1zAgHn8kM4K/prfhWcg1tyVUiT9a6Q4EgorFoZDWsJw8cjiifPEkBIm+IoOhszAWa05hy6H+b0TYF6ZaTnUmVh7cIMLMWh4nGUqpRY1oCwQxt3gmsJaWPuRKlkJeA0N4j8K5gF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OdYVl4Yl6GeKI9fiOnJEcnPSQ5wAzf6t5Qkyf0T+U8=;
 b=QVMNZnfl7p1oJlpaDTMnNBtfUZ1hKCSs4xIyIQvjxtoXOy62NGwrsPcCKlS0xLEL08n0Ia2hV4Zt7XBSvHxqsOHiG29SVeF7gKCECQupt2v++EikiTzSipHwaS+K27M92WqC8g19LC1r1AgYRgM816P83SQlALk8VTNlpCDjINA9cxCq4g3AnBvN2aGVKMAkPujYTpWbFTjWFVceMhaqhgAicAdmh+XlUv0W1ofNfWGI/jz0vDqDgHpjLXwSmawMCRM7Nf2in3XORbJJMpPv/wz1WZF3swQvQhkNfeb4gisDFDGk2HiX4I+f5tpWrlfDtbjYO2sel/TJXUMtB8/yfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1OdYVl4Yl6GeKI9fiOnJEcnPSQ5wAzf6t5Qkyf0T+U8=;
 b=hYMR5TIl8n4i0uFRhc1JpjMoGN5oJxTRl3BQB9FVs2MnHB8biB/5ReyMfXoV58LIkIl52TAaLiuW48ljpivQrGE4p70WMg09gtDYEoINgh2XtEuGYiaZb8fB/fpmaJNhymK3B+NzhWVpWBQWjcAk+jua7zFm0IhJGrpV4j2UPOkpkOtmU6Q28HUHjXCt+WLiiS2s3S+QZpi/oXRo0O8WsZJ4lUqEMeN2mekevaDjw+kusl0j2AsuGPHdDhvU/Rlq65f1FhlenaS58mBELUejAlwDCiUGyx66pw55UFg+zVIOAjnW5PuW7NmLyuJP8zD4YrR3EaVlRPgBEUDjpsyezQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB7191.eurprd04.prod.outlook.com (2603:10a6:20b:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Thu, 28 Nov
 2024 16:01:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 16:01:26 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/2] iso-tester: Add test for ISO Broadcaster Receiver Defer Reconnect
Date: Thu, 28 Nov 2024 18:01:01 +0200
Message-ID: <20241128160101.15187-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128160101.15187-1-iulia.tanasescu@nxp.com>
References: <20241128160101.15187-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0115.eurprd04.prod.outlook.com
 (2603:10a6:208:55::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 879ced24-290a-4a83-7b41-08dd0fc5e9c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pN7NYgzy8mSMtzn3Xaonh/pIj64TealhG6AaURV5oeRNyVlOFaTWNepqfaDk?=
 =?us-ascii?Q?dRTwbCIRshTt1D/N1ZBYNebngcQX0r63p21Vxo0UiCAP6eBrZ6KVWaCEGsyT?=
 =?us-ascii?Q?aIGo7ImFbeK3JigStjeT0sKXpa4totpcWSt/DUr2EpxckDEg2+m7pEAMjG6W?=
 =?us-ascii?Q?yCyIQryggQg28vgdxeAV9ipOvNu2zenEO1bja1mt8jGkhhEIwau1l5Gj2wa7?=
 =?us-ascii?Q?8+3fddLzpNu5rg7Xt3+0rRkLD1ITb9GKPNNdwL24Y+ulexkRo/p4ibqhWNKA?=
 =?us-ascii?Q?40P91eUdTCEBLeB6JGrDyYln11tFNUsHFhWXz7ZRk6JrEt/6LFGrNtC4vQ8m?=
 =?us-ascii?Q?G7QarLc10fy3Iz9q0rXyi8S76LHKJsOJbtxN/ZM4IwokINABINFudsf8d3EI?=
 =?us-ascii?Q?x+vCkk6H7qQN5qIzh8JRo2JEDG6V73QAqc5BgT0eQHhSpGYuJ9pFSAfRtQOE?=
 =?us-ascii?Q?NJY4LEaul2l8ZlOXO3zM64Assd1pH/am9GYbtaTQyqDykybMNhDs4IjLhOO/?=
 =?us-ascii?Q?DSyk/tIXVZGqRawtXbCRlC6lvqavWQRaS4uZETPu3vRuNr1XBn4FiJ+tipGF?=
 =?us-ascii?Q?fKYfzVazIlVz1U+4hUZP7/b+3ZZeC363042+GdEfNLFKFownrLmkkdbFqnWY?=
 =?us-ascii?Q?Y0qXz0pif+bZimkFPWgwuJIVPKgukKOHcwaQxEcy3cRlu5x+qGIYhntdomLp?=
 =?us-ascii?Q?LMytQDGXT1SnBkXZefYN+I+eucvbBm7qj7SYxxKZePUbXdG2TQElWg4mCP77?=
 =?us-ascii?Q?UbszAuzwlhzbdkVWTOCY5v+5thD+yGizTCDLgDXV9JGngZ3p7lj6B3/yCyWz?=
 =?us-ascii?Q?4tsl9WeMR+P9jLXXIloRUBFH0GHgx9PkAClmaE1b3Z/FeORsJF7GbmBgjQYn?=
 =?us-ascii?Q?OxXmJqcQDJOOK8w571yYR+fkBA8z83ULlAcqucRZhHnoMRj98XTk2jruHDIF?=
 =?us-ascii?Q?DiPbHHPMCsgu2eQBs4fGBm+03/T1jc3PZM5XRw1ZP8hMFvkUaTSb2LWzOEfq?=
 =?us-ascii?Q?HHtLIO3lL2b1iADZnlpkLdMDKVYEo3Gt/nNEACkxX4qLCQz0Oa1RtxeJl5Ht?=
 =?us-ascii?Q?fpX2yOYYxZT6ZfL/zuDJUTtTl8QU8J0Z1TOzGDEdlQSxN1sj2Fp/AHDj2czR?=
 =?us-ascii?Q?Dt1BQFdxhWNbyHY80HpQjpyz2c3FA1Nb27Pvx8GixIqL0/rto5spaOQID9nl?=
 =?us-ascii?Q?X848n9bPgwmn5AqAX3lyLGgJeDeYI9gnc9byZXyefzwi9T5h/k3p7996//M2?=
 =?us-ascii?Q?LV/AvDbVhuDmw1G/WzeOyFwSEDRE+1uI7am5xOYMfnVEW0j9hekrbo0HctHa?=
 =?us-ascii?Q?/JdAcIZ3yX7LJaVbQrC4JLmvgU+vG+O4F0SaMHsMUc5HuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PggdtzNi0n8pxR3bqruzyGK/ScSTLCsEQ5FszZd/ktbZfcEDKlMnp2pxIi2V?=
 =?us-ascii?Q?QIjP79N80sKl3G4bZ+ShQhJD/opHfYRQ1wB6TYmWvV4xfEu3iWL+s/hqnJgY?=
 =?us-ascii?Q?gQeJ6CD+iRs0tVg1mGjUZvAbO94+pqFQT4Ko5eZvfocua2h7wLYfBL4lwLer?=
 =?us-ascii?Q?SUS9+6HKN5DiTZlDuqCpgIs5FXIbAM8+tBhfxJ119Rpt/UXQjkGUnaEXc8qD?=
 =?us-ascii?Q?4O/7Z5wyMo851nzZ+sKM10F+AW0hCcXPQtt9R+3gsLTUq4ck5w3Nd14Yh1Yn?=
 =?us-ascii?Q?rx5Or3V9QHNSe6KBQ1InacVsSSTq6Et0LZQiwy/IAZR/HLfjgScexWUNA2p7?=
 =?us-ascii?Q?PqDqyEUvV97qYKiO+QY0iE8gh94S9I9uqrywrYaz0ssZ++Sdxa6DkNYrykRV?=
 =?us-ascii?Q?5CIf65PATPTyouUAudwS8gFz+Klzw9SYXBRnj+rHJ3MXWRbvCJHVZ3QyLw4u?=
 =?us-ascii?Q?oC3seyK0YdveSYNeCytQFO85Pr/CnX+O6uKzA5W9KxKPcerIpL8Pf6VGKaSd?=
 =?us-ascii?Q?SnWbY68dZxnlbl9p/hwjeuBOxNYHDyafdCLNVYOZ79UFO65rZudoox/5uNf4?=
 =?us-ascii?Q?TGgE+GEe5S3GYKVT9rTO8lNXvqen1jKvat/INC++nJBYDwwTC3sjPKIBG1UH?=
 =?us-ascii?Q?j7+KIiceoVpvdcNJPgkLSYc+FqVC+1eG1O/NRqqMPKg5fXaPWWnEzH/Uh8f7?=
 =?us-ascii?Q?/9nyx2y3JL9bQY+QJJ58ocNb2KtXGpTC4zYksBGTNtvI2n5f5L/D+4nFla5o?=
 =?us-ascii?Q?HudQarywLp1vx4chHRN0BPNWn3ALzy5JAelDu1lDkkWm7jOwZ2mv7tcsBwoJ?=
 =?us-ascii?Q?5FGuoaIQ6AQBbIitoWP+RtNxgOKhmjUprjrEFEUlhXD3aEX6pweF6CYoWrpC?=
 =?us-ascii?Q?ZlYh4d/LBlRO/7SZ349WjdA0JDr3UdfbI5PyILQtShig932bg0uiHtqhbr8Y?=
 =?us-ascii?Q?XyLWPpZBAeyG3DYamqJ6q54E8gU5TSZbCL9NZeLu3Y/05hG2479aKkGbhnGC?=
 =?us-ascii?Q?8rS2U8xdilns/+um8bF5AzcFBZ1NWdcLXXMUhFN1T8RamjMdrzMdlv4vsk7M?=
 =?us-ascii?Q?kjMqLv8DsXMXtZtBph7TktTLatxICY6D+yMIQEDL4PvfPqKmt9kXbmzio6E4?=
 =?us-ascii?Q?MCketb1DXSuRaHbs4fvWI5+kGHfomimlw0nEQ4AMUyKYLzrQPtB5CjefiGRa?=
 =?us-ascii?Q?Bw6g46zrMaqrf31RPla+Q05KrFh08xu66jIsB/BPVjUK7qibPtJzA07kb4GD?=
 =?us-ascii?Q?we9YzogwG8JAzwjQ7KHd8dSMTxJhDedAOGIw/fnAJ0fGo60BlULR/t4aO126?=
 =?us-ascii?Q?Q0jmDLy48Cphgu3vlEnuodmrR99+pcdb0guT8GyatRqd/6pjg66k9yzGM8OX?=
 =?us-ascii?Q?vLN3ZujRhDx8GDMLCflHqkHdxNxjkU42AkmJWeZ8ysE8KF9/PaU8qPWDFVGH?=
 =?us-ascii?Q?9Bl6QQwxxKy+Nq5ryBIupLxbhl2dYAIWM6gCcXGiHZSG7vEw4AS+lVUue2fX?=
 =?us-ascii?Q?OGgRS1rosSX0E3XNBSnC2ZLUu6/VYQvpdAMYlE8aHb5itmSxxyOFH2GmNoxT?=
 =?us-ascii?Q?adeZzi08g6DW70LozlLRLUsp6xmzlrd91Ly1iNUTpApstgbrh42It310Ca7E?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 879ced24-290a-4a83-7b41-08dd0fc5e9c5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 16:01:26.2728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fXLPAaDyM6gP/o8H3usxzq1gtubbcsGmPefzhyhbBA0YK4wTuyIz/3iKOi5fl7Td2ZX19iVEbe4M2X3yAWn9Kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7191

This adds a test for a Broadcast Receiver terminating BIG sync and
re-establishing it, while keeping PA sync alive:

ISO Broadcaster Receiver Defer Reconnect - Success
---
 tools/iso-tester.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 5ec8634ac..c30c44ce9 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -1447,6 +1447,17 @@ static const struct iso_client_data bcast_16_2_1_recv_defer = {
 	.big = true,
 };
 
+static const struct iso_client_data bcast_16_2_1_recv_defer_reconnect = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.defer = true,
+	.bcast = true,
+	.server = true,
+	.pa_bind = true,
+	.big = true,
+	.disconnect = true,
+};
+
 static const struct iso_client_data bcast_16_2_1_recv2_defer = {
 	.qos = QOS_IN_16_2_1,
 	.expect_err = 0,
@@ -2404,6 +2415,8 @@ static gboolean iso_connect_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data);
 static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data);
+static bool iso_defer_accept_bcast(struct test_data *data, GIOChannel *io,
+						uint8_t num, GIOFunc func);
 
 static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
@@ -2421,7 +2434,19 @@ static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
 
 		if (data->reconnect) {
 			data->reconnect = false;
-			test_connect(data->test_data);
+
+			if (!isodata->server)
+				test_connect(data->test_data);
+			else {
+				GIOChannel *parent =
+					queue_peek_head(data->io_queue);
+
+				data->step++;
+
+				iso_defer_accept_bcast(data,
+					parent, 0, iso_accept_cb);
+			}
+
 			return FALSE;
 		}
 
@@ -3405,6 +3430,16 @@ static void test_bcast_recv_defer(const void *test_data)
 	setup_listen(data, 0, iso_accept_cb);
 }
 
+static void test_bcast_recv_defer_reconnect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->reconnect = true;
+	data->step = 1;
+
+	setup_listen(data, 0, iso_accept_cb);
+}
+
 static void test_bcast_recv2_defer(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -3807,6 +3842,10 @@ int main(int argc, char *argv[])
 						&bcast_16_2_1_recv_defer,
 						setup_powered,
 						test_bcast_recv_defer);
+	test_iso("ISO Broadcaster Receiver Defer Reconnect - Success",
+					&bcast_16_2_1_recv_defer_reconnect,
+					setup_powered,
+					test_bcast_recv_defer_reconnect);
 	test_iso2("ISO Broadcaster Receiver2 Defer - Success",
 						&bcast_16_2_1_recv2_defer,
 						setup_powered,
-- 
2.43.0

