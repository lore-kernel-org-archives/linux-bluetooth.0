Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD289171C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716479286; cv=fail; b=l47j0z5Bhq6T7kbOfDAxLp8l2iBmD7YSkRhN3m1c2YDjs48gwK94xvZMroCtzKd2v+PkYpiOmc2yKPPmnmhyUVyhHyUfUedsEuK/ASAdGZOa26e33mBn1gfa6tRg6BSSMYN1mdDEJXqkJT9jTfS7xKXEvpnRr7avPlqurkc+bgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716479286; c=relaxed/simple;
	bh=TreIvJmyRqECPnHV3uU4VxTJz+tFbTbJ3EJ41rWU5MU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YGsbPZhqDUIwtN50r03ppNH9RpcHtlgMRbhgUuVyaB+m8RCzMvMR8wixnQv79fElgqLKMt7/e/A3RmAmYmb3UsBS5acJTqej9dlG6DYcygCW3enN/ZlkKIaGz3L2KTMtuN0A/YYzksfbq9ZXADYnpV3/fv36zYbn7bmrYFe+tIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m/vXuWxE; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m/vXuWxE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J9SdrcFJeaREkx8XOP9RQhmKjG1ZRYrOOnYLmmMTsnAYTRlMPKxsXIXGeu3AoJ1xCOW9CWkH5Hf8Fapunql1sJDgwSF/XrgY8Oles4bzrUuSv78diN5TN7mYIi4lfLS6M7i4/36ywXGJv3ZlgjlF16fCs322W/NDSG7I7/C8dnR+80rGpAg0lGk99wYuhvzv9PEMmc8bZBQcWMHEuA/7Y9Ckr+Y8Dx/K8vjS1eZBZjOY3SCqvljrzx7Lik2VKP2cOygehovkJvoKJFLVt6T5aI4R+NcfrcCgJePW5UCTQSjwZDP7uMdWesQFcNzSjLO3nXs289d/w3y0sfVyzAOobQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gB6tQGfZLGCv4UAvDOJhSFDvyJqB2PP6R9zEPGRJIEg=;
 b=YylQtDEpzkBKmIV3fSJQIlHx15KbwMHQyb049SBEphPgsuJ3qGQGrKBx5NX76HziaqeBrOh0jsvN4JB+fK8nCo3C4M69Mop7nNVwghVuhAUGeDpYed/8bDWAYv2qTslqjtoGoB6r1IXx7PfhnNqvLZcKr6ONt07yPs6q5VQaBadD+y6FR1gudo6bmRD1Ou9Tf8T5rd4xu6C9s2ukIWIc9Gh8RB/kGJRyAgo20HBqF5kJPhlOQczIZaiz4OFMeL3yCH7l8b2UVWU7lTK9lav9Po86+Us+RcxRkWb0jrR/MNzASJmlGpg5hAMcTZ/uMMrCaOTuZWYWUiHxh9SqI4ImCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gB6tQGfZLGCv4UAvDOJhSFDvyJqB2PP6R9zEPGRJIEg=;
 b=m/vXuWxEwoHpu1XiomxOL3iC23ODalYtuM5s8rsv+g7b7/NrSaKtbEYYUdT83pFwlEXRhXX5PuaZ04rRxI0uUpfq1u+LTNKMqPsbpnoAMX7a75jSIwMlcdGQc9UR1Zx7fx2ir3dSJn4yiIoj3vRy4UWsLx9j0sBHzGrvREFMkww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by GVXPR04MB10658.eurprd04.prod.outlook.com (2603:10a6:150:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 15:48:01 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::5d49:58b0:19c5:a38]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::5d49:58b0:19c5:a38%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 15:48:01 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 2/2] bap: Update BAP Broadcast Source state machine states
Date: Thu, 23 May 2024 18:47:54 +0300
Message-Id: <20240523154754.39451-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240523154754.39451-1-silviu.barbulescu@nxp.com>
References: <20240523154754.39451-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0144.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::11) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|GVXPR04MB10658:EE_
X-MS-Office365-Filtering-Correlation-Id: 294bd601-6f6e-445f-99b2-08dc7b3fba01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J+7ppO4sO5GvSzfR1GNW+5TaVi3Wd0V9Us/6eaaSGtO4rBNenhZij66IJWY3?=
 =?us-ascii?Q?8Pg3UJCDIoaCcup8tcaCfT9mtVe6H4h3+ezP9owZi7IFdXsONiVy7Cvt7WFB?=
 =?us-ascii?Q?5+u8uaa9KRPhae1rKViQwbd0gNbVIiv7EgqkAwvpPr54TfBgBBEnquOTONM8?=
 =?us-ascii?Q?K2j8rhTvc0vuDOZGm8cpXjFAt9YEttZ+JTVrKEAl8EkAV4m86bFIXcdkbZGa?=
 =?us-ascii?Q?Uy/H5eFpW840aEP6Xn5cLZxX/4JzkidlhLrN+39T531vhVh2gzc3VSU3xUfH?=
 =?us-ascii?Q?esJ91z8nEu1FXApTJVmDjA+N5dtRQ5iXWnLOOcSs4DxhyZ7SAWbgZXfLIDt4?=
 =?us-ascii?Q?qKigPqiOLpmX/RhSHkWCRswktfAxiTIYUPtCOTjfHXqocvIba6+DMe+oUwhx?=
 =?us-ascii?Q?s0iNcnl/Bw42kFtHIsGdpbNzBJDrE2EwZUVIBlx7+W+rbI/nnZGhKJk0XMaG?=
 =?us-ascii?Q?T9fnMsjD7W+ML0byWym5MhFsHDDi5KOeXQdjfvwSQI6CCZixeCfASOgpSFai?=
 =?us-ascii?Q?T4ymbvdfdcxwBZREBClI2+Yg7+j0ULVTEjggrgqMY0lS1BMmeHHiXx401nMb?=
 =?us-ascii?Q?84x7wqxYtcyJDH8014nDCdB815iVEUab7Ix3gM+LabQIZo0ZNYyVp2evQJ3W?=
 =?us-ascii?Q?NPS4Lkn+zQt+ABIH1NDnTZ1Pvm1/J6pWImq3Dbxo+Av66cr3ADuMLlDRTaL7?=
 =?us-ascii?Q?4UhcJVuzTDoQnmK4uqPWP/y3Nsto3vWp1+YwYWHWNr0Nwn1Iy9c54Jte2t26?=
 =?us-ascii?Q?FLlWnfXcPIrQSy/yqL1UNjvqekyn75WCFmPHhIdBHkXyO7U1S7ff1HzpFRcf?=
 =?us-ascii?Q?iWC0KrcjVisG81LTwJoQEW7LKMQKocYXmUvJEzIaWzE4XVVQZ4fjEz9Gfj3d?=
 =?us-ascii?Q?SLA5tOsDJw4aflSKGlPW9lWc50wPIwRuT0O8Suhx+fYQbTUu9ru3qT7pRhCi?=
 =?us-ascii?Q?mfs1nzhO5fWkNtjzgeWuQcmkhDeoUsLSLnW6RRU4VPUQxRV0XY6qi+QdYGG7?=
 =?us-ascii?Q?Ofg7caAPJYDk7E491xj1XNz61+iGCwfvbZZxdWw9MaRIU1trizfLe4s+uPae?=
 =?us-ascii?Q?HO12Fs+DX6AIin4CLLAKGVXhnoku/rMvpmRfq3MypMfZZyRNB3+qWNM7NI6g?=
 =?us-ascii?Q?JI8rLWaWDbGb3gqGCQbINickD9+ePUanen2oZ31bm8f8umxLQWH7rH2Zi9fc?=
 =?us-ascii?Q?Es9PXT0pV/bRjOqWzQI8HrIvu5a7g4wMNKCLovgoQqPbjkG9Su7OUAQxhnL1?=
 =?us-ascii?Q?eaZt2mapGV7jF4xsQCKtCjNJHFt5qXBQB/YSiKz65w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r1UF3bLtE1Wboubd7eUgrezHWxZHwVh7sctxD/m18WJfGCzDRx0YKQOCpm3U?=
 =?us-ascii?Q?2sYmj2Hq6SIRJ8EIzHW+WXSvLuI4RJmfkH7XB+A7mB568el17ShQitWGFTrs?=
 =?us-ascii?Q?stKt1efS0mB2NIAzMy2wD1Hu2og9rmWQ2OZPPUBs/lES32I3uiGXEZZRiyoj?=
 =?us-ascii?Q?Vwhtj/sRZTUyy72zXRkqMw8Kv10Pzb2fYnQMOsfNn/0SXsT16uqY+kUYwn8l?=
 =?us-ascii?Q?5ARBXK271pzj2kFAW9rvBuUNRLhimOm9PMWH9NJNvZWs/GvQJMD6d6eydmZb?=
 =?us-ascii?Q?ccMZddDYNp+EKGJ35TjqcYQ05KyxdxrPDbLPwWoDyOB8RGuFCuTTak6+D8e7?=
 =?us-ascii?Q?iI/YyYoLx7cM8PQvGojp82qmBS2gXxVVYkPw4WWJmnMAFFgfijfadFUuxA0+?=
 =?us-ascii?Q?4NRBH3jdscZ4AZ9IlzCblzjayAHQ5YKj9rqWMY3G3AhgwYv3tYYkuSs9iDNt?=
 =?us-ascii?Q?jheY43qrRbOJP5MPqo8gPfpalR9NZAygdJY1HeZ4+8Le0yEXNxqOlouqQcAN?=
 =?us-ascii?Q?yqCHanMrK1DN6BqIqMkoGdnpIwwjv4Jwq4UDoKG7t3iWNfpcm+PYsgnxokIA?=
 =?us-ascii?Q?ajYEcnrN5nSiqi76rd4Ys5ooPUNI1uM//hc5QblnNPdT0t91wxqbzntwqSCW?=
 =?us-ascii?Q?e1DAdMPqbGDk5K+7dd4WPO9D0PbbqJqt9vHOZGquGKiCDaTPGGOayva5bGsx?=
 =?us-ascii?Q?ucj8D0nI7DaqVeFLw3tT5IrA0ddrviUPTdSh46hlBXeOn4bhtjv2jqV9Wfo6?=
 =?us-ascii?Q?DGoEkYWG5W26Pf8cTOSqqUea4W5kiLUu0puybe6pAOSJsysOJHlwLnY+ePPZ?=
 =?us-ascii?Q?tBmVDub2xDV51Hqs4Ux/wUa9/dfvdn/RRNmKTeeFA2PHguD/o/ab07JBRr0n?=
 =?us-ascii?Q?0mv3Oq7sARbf/DKENruZFEgtdi6QIlSz3XCkUqCx3isBBwppcvpTk6Ypylqz?=
 =?us-ascii?Q?XtDucInokeTu8F0kFtzDv0ljpomQO9L0ODpYiU+EQB1j35Bdlo4BCKulbIGD?=
 =?us-ascii?Q?OJriRGbdo/GnMnGSPG/ToG8eolE3Edx2ZVWcNfCEUFG3Gz8FDAGnBWa9AOrX?=
 =?us-ascii?Q?zgme1TOe8KVJ/ozpPX6iDwqr+JvPuJzWouMfkOYHgOYPwedyBplgMlRK6lpG?=
 =?us-ascii?Q?YIRSkDeUvRrIeUsGEQ1U/BDPpjVNV5rZTKOaAC/3/skkHV7m44sZ+vlq9pfs?=
 =?us-ascii?Q?qKWH8UIwtd+Cj61mODDMvp/wzVnpGi1LMsJZIci2aZfTgzEn2M/aXd2vP8WT?=
 =?us-ascii?Q?aWLYugc4eK1NDExG0688Zyr7WeZKf+QJFW8h2WW7XS82J/T+ya6g0gQ/LQjd?=
 =?us-ascii?Q?tiNBe7mddhftexeg/AFx0wvmOX0rIp74oPsUS++2Pn3XjT1E8Hd+PvwI1PEK?=
 =?us-ascii?Q?5rVaPa6K74qWt8TgQUbPBCRLejhcvCAK5EVTL4kzxGqTlBqYvyB3reos4XG5?=
 =?us-ascii?Q?gaUKbVMHgHoj+Zq8xmaXEgg5m7+fWYDAIHYpw7HLuabdti9F5Zw2QCnMyiE9?=
 =?us-ascii?Q?Al/nENV0b397GajdXpNZO99R/3/cZWf0wS7hyNv0u4OCOpIOJ6Gb6dMDGKU/?=
 =?us-ascii?Q?bC+oeOVOj86drBbBdmXaFDw57vYkrHr9CNgdC8AGs0wCzKDaUpZuRWkoCAwg?=
 =?us-ascii?Q?vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294bd601-6f6e-445f-99b2-08dc7b3fba01
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 15:48:01.4609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ikpms+XEFWjXbbboahZ9K9X/qS2Ssvg56K8BPZbIjFfwX7lWYnaKXEzJtLPAfhetOjQZCqYQBfF0o0L/kA+7wDGvbmta37iIVkECkX+qJUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10658

Update BAP Broadcast Source state machine states

---
 profiles/audio/bap.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 06dc4e254..3fcf21df5 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2474,7 +2474,7 @@ static uint8_t get_streams_nb_by_state(struct bap_setup *setup)
 			 */
 			return 1;
 		else if (bt_bap_stream_get_state(ent_setup->stream) !=
-				BT_BAP_STREAM_STATE_CONFIG)
+				BT_BAP_STREAM_STATE_ENABLING)
 			/* Not all streams form a BIG have received transport
 			 * acquire, so wait for the other streams to.
 			 */
@@ -2516,8 +2516,21 @@ static void bap_state_bcast_src(struct bt_bap_stream *stream, uint8_t old_state,
 			queue_remove(data->streams, stream);
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
-		if (!setup || setup->id)
-			break;
+		// TO DO Reconfiguration
+		break;
+	/* Use the ENABLING state to know when a transport
+	 * linked to a stream has been acquired by a process
+	 * and in the case of a BIG with one BIS stream goes
+	 * in the ENABLING state waiting for the response
+	 * from the kernel that the BIG has been created
+	 * so it can go to the streaming state.
+	 * For the case of a BIG with multiple BISes,
+	 * the BIG is created when all BISes are acquired.
+	 * So we use the ENABLING state to  verify that all
+	 * transports attached to that streams form BIG have
+	 * been acquired so we can create the BIG.
+	 */
+	case BT_BAP_STREAM_STATE_ENABLING:
 		/* If the stream attached to a broadcast
 		 * source endpoint generate the base.
 		 */
@@ -2855,8 +2868,7 @@ static void bap_connecting_bcast(struct bt_bap_stream *stream, bool state,
 
 		setup->qos.bcast.big = iso_qos.bcast.big;
 		setup->qos.bcast.bis = iso_qos.bcast.bis;
-		bt_bap_stream_config(setup->stream, &setup->qos, setup->caps,
-							NULL, NULL);
+		bt_bap_stream_qos(setup->stream, &setup->qos, NULL, NULL);
 	}
 
 	DBG("stream %p fd %d: BIG 0x%02x BIS 0x%02x", stream, fd,
-- 
2.40.1

