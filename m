Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9482036EE
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858940; cv=fail; b=SKSqBTnJaL53MpB7tTb5RZG8WAsqWUkhnwWKGjqTCG68jkCE6k2c1mtHka1IqcwOhYQUBnvv6E+nGV9iQw/9INM9ZfS6+WMHPqkMOOOh9irQun3+L0s2uj6+EGrSyh4kRluoFdvD5HB3n8if5SBW0K2dLMlsuLuGHM7aNz6yt8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858940; c=relaxed/simple;
	bh=v3yn1+9S/OBVpoKXu+nEbzLp4IIM3dvjfpbKIGwLGxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HY3MmzzVL3+PfF+xmihtNR8Tlvy7FtaKrYUuL9RRuQnrhMdDzmAgEG5UJnF0Ras20ei8AzhM6uwANo77eHxmA91Sau7FWyIzpb1/iV+Wu4xi4Hy/krH+xlxFLMcHm0QwqcRNKFo9/ogjr50qIoJdAb2DtPcmJBzKdXljbZMZP0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=euxkHnnr; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="euxkHnnr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmTuX3tNjvvRqmd7fnPRyGhOw/3ACQo/nqu9mFZmwmRcecAtZMly2XNygYx8ouanSsX7jfsdfW8g7Yvhqe9UiS0qScFeEiSEDaODXgyGGMbWEP/rNehg5T/kr+cAFWFJOC48du2SdEc5Ey7si0p2unjWrJc4G6KBUATLrusCoYXjopnqlINlpsiIu7hN4YDw26DW8psGB+6r6H9nJvsK0uTEIwME7J+VUeHkgMCmjEyxtgZ8eHzAqwBvXnx9q0Bg7fZZu1Qe/4cJhZT+QXJ9atmf5S3UawfgcLvSZflP54hBEzooLa9P9b9Dpj3Vyri7SNUdOxjmAj6OWN7jCNfLlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDHyKfTuDytPTaU7MQs8CrrrgX+6fFMAFGruoAnBAGM=;
 b=t2JTmbTQH1aKK6+t5DnX6POS7ex0S0dEVzNn91llwPZO2Qm5HD/JZeYS1IabWcFLXWbLNF8iMQcDaQZJ6O2WVc8JIOFjSxtD153YdqSiV/Y9ucu8UiR18LnPoG1Y1c03Un4XoAhYHx64tZOFuWmxUKGxR+ODU3NJJRDGyZKBBYCUYWQ6ZRMA7AdbNQl3kLYbrEEklABdWBvtwWkSV/+A63fq38bTYi5djaYkfhEjE4jf9hGrWh39BeqrWGXvvuv68TH8+WCNYiECEU3sTKnvcTozJoxHq9ONBwaXWYTX0dT9SJ3BSCpAQ54avblt4C9RT29yLMq1mVF1jSyOJHakPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDHyKfTuDytPTaU7MQs8CrrrgX+6fFMAFGruoAnBAGM=;
 b=euxkHnnr7lDHvr1raNES8vwGIOuI7hGrY/gTIqSnD7Ra9iwwTEzyuyAkiZGsRZzEoyWlmetMtWU4JkvaSrkw2B1YWjakbtur50sXYUPSrW1EXf58NbpqNOApdxGc8k+DrPrtu50E+dFsZj+Jyp+HbCXMdE+IaJm92rg8XwyspohEUoGAVqavD6Yzn1fWpziHB6lueKEK5sEMOcqjppBN7DuMxIaWbxgJmCm03ePu4o3I4IcprSykd4xn03D+Q5W0tE+hQubPkeorTGAEkUhhqBi6WvsWSbA/bLpTbvPAwpyLYpbbj5/L6vdzeKVP/1EHtxLdi9KQFmfo+QNIXXZrjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:13 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:13 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 01/14] shared/bap: Allow multiple links per stream
Date: Fri, 25 Oct 2024 15:21:33 +0300
Message-ID: <20241025122146.17925-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
References: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI2PR04MB11052:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e16d7e-1e85-4c7a-946b-08dcf4efa7cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UnwhnRnGoRpkyyqDxftD6Zk+dzfKsU0xxyFNDIGOJ+LBNHKZsMB9JunZzGnR?=
 =?us-ascii?Q?AsfuwoyPsZDEX3Rf2U1Z2SPYR0AWIZQrceGTZf3fijGFxUdbzfG0jhL/KrOO?=
 =?us-ascii?Q?qfJv6Dtve1MXkcaiUhv9Pl+Ho1vbUnXrf/i4fp/asDpFRiH1cMpVUtErleHA?=
 =?us-ascii?Q?f0oUnG3Kq0oCjfbROSNMBTrXxd6R4m1vIfg2vOc1ijOeeoqS0B9rfeE0Q58W?=
 =?us-ascii?Q?F/69K2hgfomR4+giDg3cUD7cQFE3HUuq21+IsE3FJcqqCrv/sgu5ILoX8WF+?=
 =?us-ascii?Q?D3pCOQ+qgyzb9yaCkR8rob4RaYSCSsZh562nEgHDMleOvRWZAxnoKU3R0YZC?=
 =?us-ascii?Q?MbC90KHwz7aHZ/7P5yJnnmk0E4syU0r5TV51NsAh3QawmTOYa8i6MJBIjWq+?=
 =?us-ascii?Q?kN/Jfy9oFiMlvj/Pr8C5Ngcu0PDUw9yzTmQlRHJIRUj+YebEp6a6CNg+Zu0H?=
 =?us-ascii?Q?y63NxOzrwuq0/U5OPlyILjGwKuK2jHmX8/BsEaATpgeibpyequsVXBBAURfm?=
 =?us-ascii?Q?UvCacXRoqoqr2MqXk8FAaH3QY6r8U9A1UJrA5vHcRlS7JSCTCSDkrEy8KwL+?=
 =?us-ascii?Q?Qxa4TLoZnUwe1Wgz1zv3Hhmlps4Go5txqeV5bslgRHmDbQCB0FGwto9sYINN?=
 =?us-ascii?Q?EHwy7Hd3iyh8jJ8D2pXAphwqsOLpmP0X3amtd/R7U7iFYbGWwztO7l3ZPkR6?=
 =?us-ascii?Q?7Bfz5eKRzajEbuJf00aQHx2b4YCoNBBRqp6RZxAKyapeSx9X7NPTQ+3UNJif?=
 =?us-ascii?Q?QGU6G5/2W+sDSYA2o+KTLCIpyX7auc5cjcMTgWJBKYIaZ8tKITYYwVycPma+?=
 =?us-ascii?Q?1FtB5V2UXAqtYocUfvLhHPzyB5H7Qko7Un4RdfSc8wVzkcN1CZOmvlIoBMOP?=
 =?us-ascii?Q?76GnpJAA71QXSObl9llcZP5hcbDHFP9+/K0PIikfjaFgGDnQTjOf5eXLPAG9?=
 =?us-ascii?Q?zMRm7PZAWzWhnOnGRXQu3aBgCTzHf7xyddc9ZGvy2bdXeS0LZE1xfaVqzkkm?=
 =?us-ascii?Q?B+tgxZmTixHGTuuvJN1r9hiL+LTFmHe5ujK3vWDohZ5Z6IQzMQXQAu5VfbLp?=
 =?us-ascii?Q?bb9Y06szjU+7toFGrqO+UI6YDQzdzwXB2R5H024HRJWMRZV0HKoT4keB83Mh?=
 =?us-ascii?Q?4lbKgmP4icxMWnSQk0D3CYWYMCLeJeGs/GzWYOcJHElbbiszsN53yw3vKw6e?=
 =?us-ascii?Q?mQUEzojjcDvw+xyLUMM7mwjOCkLndJRU8OcXwaW05nOhQ+baQzp50KgOfvUv?=
 =?us-ascii?Q?wT1npdCPLfag5rrSd5W0f1sQgM0F3rOK8eXlxyjJ3s9yL2XB0qKLOttd03b4?=
 =?us-ascii?Q?pRmdR1HQVooh8vrTay9R1tV/Y3rewNmDmibTR3oI105MsacD10HZmkUk8mqk?=
 =?us-ascii?Q?MRKCBtk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nqnjTB/w3vaovfkjPMnbzexu4g6Z9m0A4NnIYl0OGypWlp6g9Wl+JtSqhtcB?=
 =?us-ascii?Q?5XNUv9IK6LXVDoJYsp4BbC2eHwoJPeoP2fhFK7uXTtpnYmOfBeChjMandVKh?=
 =?us-ascii?Q?dav413L114IRzlusB4wsqDkMFk1mM3NgJuyPpJju1oEa/LLBRbv0Lga/3QdO?=
 =?us-ascii?Q?KPPTqzPgMFbH5yf2E22mRq+65+NlY8ZdR54EIW9x2pVKx9SNTVlcev+Ugfm4?=
 =?us-ascii?Q?nbTyGU7vkGj/KI+VOcPvM6tfa33RBUiCdz4OU9RLkdgCuSeDMDOb2ojfAaGr?=
 =?us-ascii?Q?KrPoLx9i3GCB4EzKMp98XIvcw5WDMbvNCG/x2yekBR29sql9soecdr1jYX6q?=
 =?us-ascii?Q?8vH3OfPkqNXqyPyh8Y2fVQwa46G6DI3Jh+LIlx4sua0XMdS38LJu3YkhTGjH?=
 =?us-ascii?Q?uZI7lyICJMZVE97RO+Mh9Pwp4avMHQzw6F0664vx90IfAi3MUDmpCDlYR5XK?=
 =?us-ascii?Q?c/B8DyPU3IJRl5w1gorpyNfXptgt5YOZkF8UbQKihM0coOyrzQMB+tUv/yjs?=
 =?us-ascii?Q?8Z/uMYfz+Z6VD8YioMfskrtt016hQW/xg2vw3s2cB9HjZe+psBQP9eCTIIfR?=
 =?us-ascii?Q?xTNN+18TkbZdLKaSWW1t9br+UlkqtQgf7bUXLPKWkpRSY2Pdm1f1GxSg0tIp?=
 =?us-ascii?Q?xVv82j8G+qQdXm3tqgMhPv8Qs2n9uiVl7cjWhJmyvGzuhYiKo1HwsrIIaUKN?=
 =?us-ascii?Q?vNaW9I0zujQLl/wL8uxjP4+vEEthlvrlBWs0H/tThJ2BDiA+83Q8KT2TmwDS?=
 =?us-ascii?Q?oUufBvqqLuldHQ6zjbs12iV+WCVXgeLRexCO/egExMo07LA56Tg4PQvHBFTt?=
 =?us-ascii?Q?4ag1pPSGhg6FvR5pWcERXbggK3AXB8qxgh7TaV7zVJa9mQeYjh7WUuHuQX/o?=
 =?us-ascii?Q?D1VXcIuojuokLAgOdotm//rP5RihKeESqBGmaIdAh8d+idnWG1Jalh2QbKjR?=
 =?us-ascii?Q?SoKH8Vjhin8Uv8/SPczT5c1ks1UQgo8Y2QoD7/nQQzyWcF+LDJfskFAZR8BC?=
 =?us-ascii?Q?UlK9ATDlBUGDNkxDMPDQpUVlPC+IoSv5MN7l8oiCF98+UEe1Usvzb39WZdEH?=
 =?us-ascii?Q?irQEZEgBf+A+u9ifzFgHP5EzDkPebgn+5rNCNtBZAVevDwHFeY8sUTJxEfuM?=
 =?us-ascii?Q?9+FLJtTau/zqj3T7JM7x6LoSglohI7644pRoWZJqBMNWVoQf0iB7jwGYQ8OA?=
 =?us-ascii?Q?p2CHpBRrRe18sdLAmtX3McJgrWvSJJC6cDDzd24sCsR8lpnGSnCSJLzRrVeF?=
 =?us-ascii?Q?5tI7j7Oo6QN79rbvzTJJd4/qJ7Np7Y2d+CmOxToKHxtYo9Kvr+SoKyuQqOle?=
 =?us-ascii?Q?skXTYASxjJGN6Ovr3cjhUpE9YMLxMI+cKrvvdJpfsLYWTUM2g/zhkWajo7r2?=
 =?us-ascii?Q?+RP9ODMhW+p8NcbfifCIk5qTwVgqj//1zKhbhsJxE5tZAPgmndSkfnbHb3Zj?=
 =?us-ascii?Q?zoIqgCzzjh5m7IVAMqgPCGccZsONUV8BqDQUxm8HGoZbG0SDbwOYJAZK3rK9?=
 =?us-ascii?Q?UpVEV3JrMYw0v1jXZdz9L35SFNQRmJPDmdIe5tSgAG0te3DD67lGszM+UNfZ?=
 =?us-ascii?Q?J6gIA575fN15ylXzMs/u8EqarLI5SJnSf60ljzm9eOaUNJfxTfRikZSZ7PfU?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e16d7e-1e85-4c7a-946b-08dcf4efa7cd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:13.1907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ud8kYuqimKnEI5yQ8INZvNmOiHWOqGxLx2/5nGRpsR6JuUdEqw7xk2UpSVfvZdhfm2KIo4rSYRZcoQwKKvc8ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

This commit adds support to link multiple streams together, creating
the foundation for implementing broadcast links: for Broadcast Sinks,
the user could select multiple streams to receive audio from. All
selected streams need to be linked together and considered when
creating BIG sync.
---
 profiles/audio/transport.c |  38 ++++++--------
 src/shared/bap.c           | 104 +++++++++++++++++++++++++++++--------
 src/shared/bap.h           |   2 +-
 3 files changed, 97 insertions(+), 47 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 68192bae6..d71013077 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -330,12 +330,9 @@ static void transport_bap_remove_owner(struct media_transport *transport,
 {
 	struct bap_transport *bap = transport->data;
 
-	if (bap && bap->linked) {
-		struct bt_bap_stream *link;
-
-		link = bt_bap_stream_io_get_link(bap->stream);
-		linked_transport_remove_owner(link, owner);
-	}
+	if (bap && bap->linked)
+		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
+				linked_transport_remove_owner, owner);
 }
 
 static void media_transport_remove_owner(struct media_transport *transport)
@@ -581,12 +578,9 @@ static void transport_bap_set_owner(struct media_transport *transport,
 {
 	struct bap_transport *bap = transport->data;
 
-	if (bap && bap->linked) {
-		struct bt_bap_stream *link;
-
-		link = bt_bap_stream_io_get_link(bap->stream);
-		linked_transport_set_owner(link, owner);
-	}
+	if (bap && bap->linked)
+		queue_foreach(bt_bap_stream_io_get_links(bap->stream),
+				linked_transport_set_owner, owner);
 }
 
 static void media_transport_set_owner(struct media_transport *transport,
@@ -1129,14 +1123,14 @@ static gboolean get_links(const GDBusPropertyTable *property,
 {
 	struct media_transport *transport = data;
 	struct bap_transport *bap = transport->data;
-	struct bt_bap_stream *link = bt_bap_stream_io_get_link(bap->stream);
+	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
 	DBusMessageIter array;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_TYPE_OBJECT_PATH_AS_STRING,
 					&array);
 
-	append_link(link, &array);
+	queue_foreach(links, append_link, &array);
 
 	dbus_message_iter_close_container(iter, &array);
 
@@ -1572,15 +1566,15 @@ static bool match_link_transport(const void *data, const void *user_data)
 static void bap_update_links(const struct media_transport *transport)
 {
 	struct bap_transport *bap = transport->data;
-	struct bt_bap_stream *link = bt_bap_stream_io_get_link(bap->stream);
+	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
 
-	if (bap->linked == (!!link))
+	if (bap->linked == !queue_isempty(links))
 		return;
 
-	bap->linked = link ? true : false;
+	bap->linked = !queue_isempty(links);
 
 	/* Check if the links transport has been create yet */
-	if (bap->linked && !match_link_transport(link, NULL)) {
+	if (bap->linked && !queue_find(links, match_link_transport, NULL)) {
 		bap->linked = false;
 		return;
 	}
@@ -1757,15 +1751,13 @@ static void transport_bap_set_state(struct media_transport *transport,
 					transport_state_t state)
 {
 	struct bap_transport *bap = transport->data;
-	struct bt_bap_stream *link;
 
 	if (!bap->linked)
 		return;
 
-	link = bt_bap_stream_io_get_link(bap->stream);
-
-	/* Update link */
-	link_set_state(link, UINT_TO_PTR(state));
+	/* Update links */
+	queue_foreach(bt_bap_stream_io_get_links(bap->stream), link_set_state,
+							UINT_TO_PTR(state));
 }
 
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 8d04290f8..0b234275c 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -262,7 +262,7 @@ struct bt_bap_stream {
 	struct iovec *cc;
 	struct iovec *meta;
 	struct bt_bap_qos qos;
-	struct bt_bap_stream *link;
+	struct queue *links;
 	struct bt_bap_stream_io *io;
 	const struct bt_bap_stream_ops *ops;
 	uint8_t old_state;
@@ -1101,6 +1101,14 @@ static void stream_io_unref(struct bt_bap_stream_io *io)
 	stream_io_free(io);
 }
 
+static void bap_stream_unlink(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_bap_stream *link = user_data;
+
+	queue_remove(stream->links, link);
+}
+
 static void bap_stream_free(void *data)
 {
 	struct bt_bap_stream *stream = data;
@@ -1110,8 +1118,8 @@ static void bap_stream_free(void *data)
 	if (stream->ep)
 		stream->ep->stream = NULL;
 
-	if (stream->link)
-		stream->link->link = NULL;
+	queue_foreach(stream->links, bap_stream_unlink, stream);
+	queue_destroy(stream->links, NULL);
 
 	stream_io_unref(stream->io);
 	util_iov_free(stream->cc, 1);
@@ -1246,6 +1254,17 @@ static void bap_stream_update_io_links(struct bt_bap_stream *stream)
 	queue_find(bap->streams, bap_stream_io_link, stream);
 }
 
+static bool match_stream_io(const void *data, const void *user_data)
+{
+	const struct bt_bap_stream *stream = data;
+	const struct bt_bap_stream_io *io = user_data;
+
+	if (!stream->io)
+		return false;
+
+	return stream->io == io;
+}
+
 static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 {
 	struct bt_bap_stream *link;
@@ -1259,7 +1278,7 @@ static bool bap_stream_io_detach(struct bt_bap_stream *stream)
 	io = stream->io;
 	stream->io = NULL;
 
-	link = stream->link;
+	link = queue_find(stream->links, match_stream_io, io);
 	if (link) {
 		/* Detach link if in QoS state */
 		if (link->ep->state == BT_ASCS_ASE_STATE_QOS)
@@ -1803,6 +1822,14 @@ static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
 	return 1;
 }
 
+static void bap_stream_enable_link(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct iovec *metadata = user_data;
+
+	bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, NULL, NULL);
+}
+
 static unsigned int bap_ucast_enable(struct bt_bap_stream *stream,
 					bool enable_links, struct iovec *data,
 					bt_bap_stream_func_t func,
@@ -1821,9 +1848,7 @@ static unsigned int bap_ucast_enable(struct bt_bap_stream *stream,
 	if (!ret || !enable_links)
 		return ret;
 
-	if (stream->link)
-		bap_stream_metadata(stream->link, BT_ASCS_ENABLE, data,
-					NULL, NULL);
+	queue_foreach(stream->links, bap_stream_enable_link, data);
 
 	return ret;
 }
@@ -1893,6 +1918,13 @@ static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
 	return 0;
 }
 
+static void bap_stream_disable_link(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+
+	bt_bap_stream_disable(stream, false, NULL, NULL);
+}
+
 static unsigned int bap_ucast_disable(struct bt_bap_stream *stream,
 					bool disable_links,
 					bt_bap_stream_func_t func,
@@ -1919,7 +1951,7 @@ static unsigned int bap_ucast_disable(struct bt_bap_stream *stream,
 	}
 
 	if (disable_links)
-		bt_bap_stream_disable(stream->link, false, NULL, NULL);
+		queue_foreach(stream->links, bap_stream_disable_link, NULL);
 
 	return req->id;
 }
@@ -2351,18 +2383,30 @@ static struct bt_bap_stream_io *stream_io_new(struct bt_bap *bap, int fd)
 	return stream_io_ref(sio);
 }
 
+static void stream_find_io(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_bap_stream_io **io = user_data;
+
+	if (*io)
+		return;
+
+	*io = stream->io;
+}
+
 static struct bt_bap_stream_io *stream_get_io(struct bt_bap_stream *stream)
 {
+	struct bt_bap_stream_io *io = NULL;
+
 	if (!stream)
 		return NULL;
 
 	if (stream->io)
 		return stream->io;
 
-	if (stream->link)
-		return stream->link->io;
+	queue_foreach(stream->links, stream_find_io, &io);
 
-	return NULL;
+	return io;
 }
 
 static bool stream_io_disconnected(struct io *io, void *user_data);
@@ -5849,8 +5893,7 @@ bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd)
 
 	bap_stream_set_io(stream, INT_TO_PTR(fd));
 
-	if (stream->link)
-		bap_stream_set_io(stream->link, INT_TO_PTR(fd));
+	queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
 
 	return true;
 }
@@ -5905,7 +5948,8 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 
 	bap = stream->bap;
 
-	if (stream->link || link->link)
+	if (queue_find(stream->links, NULL, link) ||
+		queue_find(link->links, NULL, stream))
 		return -EALREADY;
 
 	if (stream->client != link->client ||
@@ -5914,8 +5958,14 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 			stream->ep->dir == link->ep->dir)
 		return -EINVAL;
 
-	stream->link = link;
-	link->link = stream;
+	if (!stream->links)
+		stream->links = queue_new();
+
+	if (!link->links)
+		link->links = queue_new();
+
+	queue_push_tail(stream->links, link);
+	queue_push_tail(link->links, stream);
 
 	/* Link IOs if already set on stream/link */
 	if (stream->io && !link->io)
@@ -5928,12 +5978,12 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 	return 0;
 }
 
-struct bt_bap_stream *bt_bap_stream_io_get_link(struct bt_bap_stream *stream)
+struct queue *bt_bap_stream_io_get_links(struct bt_bap_stream *stream)
 {
 	if (!stream)
 		return NULL;
 
-	return stream->link;
+	return stream->links;
 }
 
 static void bap_stream_get_in_qos(void *data, void *user_data)
@@ -5976,11 +6026,11 @@ bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 	switch (stream->ep->dir) {
 	case BT_BAP_SOURCE:
 		bap_stream_get_in_qos(stream, in);
-		bap_stream_get_out_qos(stream->link, out);
+		queue_foreach(stream->links, bap_stream_get_out_qos, out);
 		break;
 	case BT_BAP_SINK:
 		bap_stream_get_out_qos(stream, out);
-		bap_stream_get_in_qos(stream->link, in);
+		queue_foreach(stream->links, bap_stream_get_in_qos, in);
 		break;
 	default:
 		return false;
@@ -5991,6 +6041,14 @@ bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 	return in && out;
 }
 
+static void bap_stream_get_dir(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	uint8_t *dir = user_data;
+
+	*dir |= stream->ep->dir;
+}
+
 uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream)
 {
 	uint8_t dir;
@@ -6010,8 +6068,7 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream)
 
 	}
 
-	if (stream->link)
-		dir |= stream->link->ep->dir;
+	queue_foreach(stream->links, bap_stream_get_dir, &dir);
 
 	return dir;
 }
@@ -6046,7 +6103,8 @@ int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd)
 		return -EINVAL;
 
 	bap_stream_io_connecting(stream, INT_TO_PTR(fd));
-	bap_stream_io_connecting(stream->link, INT_TO_PTR(fd));
+
+	queue_foreach(stream->links, bap_stream_io_connecting, INT_TO_PTR(fd));
 
 	return 0;
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index bf928bc2d..cd5ea2eba 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -231,7 +231,7 @@ int bt_bap_stream_cancel(struct bt_bap_stream *stream, unsigned int id);
 
 int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 					struct bt_bap_stream *link);
-struct bt_bap_stream *bt_bap_stream_io_get_link(struct bt_bap_stream *stream);
+struct queue *bt_bap_stream_io_get_links(struct bt_bap_stream *stream);
 bool bt_bap_stream_io_get_qos(struct bt_bap_stream *stream,
 					struct bt_bap_qos **in,
 					struct bt_bap_qos **out);
-- 
2.43.0

