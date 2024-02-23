Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2060.outbound.protection.outlook.com [40.107.241.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AF5129A76
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706910; cv=fail; b=EM/wPI/Ru1dHsbBexLRh5rNgd0AJHYEiT9pqA2MZZHjBwz27GvU3vHcJ3JiobO4KpU2qD8wfUdA2FSFvuQb87u1p9Y4NYYjZEU61T7114AH2tpsJ+LwFC9vzSgsXybym2ZmFNtFkUg0JupM/1zdKKXsDRf5Bq2/NDiw7mS9vHi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706910; c=relaxed/simple;
	bh=XeHNuvswBO9BhPanb6sn0ZRu4A7hde785ea2R4I7kMI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cf8hoBztGG7MCYtzbd94GTH69h5jxFMyzRQ0o8CAZMi5jJZQG+2PqbU0IL4dK+F6v5DV/FvrCallANLBOtxX7kjFC3C3ir9uXnvfrlakG3KVrVRPnWkfXHFMhn9C+Fp/2WAyXvssnrKQsWwH6zYyGNZJ4fO/P7Xhej/TQVa4oLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JRhSZ+zp; arc=fail smtp.client-ip=40.107.241.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JRhSZ+zp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBR+1RTGzDPjlgUAIbcbxe2euKqBZbH28j4TZK8+TC+Ld3JHrrWQ/5TN7KbWOYNgdpd5Y+PCorzCQz8K7oeJmKGZs/uB0Pl8jlEY7ZcYbwQCtKzeNzDhro9QfcjRS/CGn89raKnBTXic05Ge3fYKDptaNCpFY5Lev/f0l7edbOGt8oAinVZtvUHY4uo7zyCoe/J8roP9btZoEGLaAI3SNM7C9Y9PAbKMG+E6nc92xBr/BP1YQDBte389AWu431QltGUBMdCeaQI1pmJZHXHzKeE+h6tMUZRDSpb086fyky/u9pBq/lUHn8RjOHRq8cHAVL4yQwcYOE+2CNmTWY76DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCKP+nCk9WoQw0qWqjUAHr1oOzpTiWvzmHHUdw+qX/o=;
 b=PQs6WJ40MWDat2XtJWAG0dJmlMvFEtxlTyphEC6Hhl+rt4GvuGbN/IQvuP+afON9y8skQpuciJx/7rPKyIsiYf2uO7hpzBNrodAo13atIAx9aBv5ICLWlu+SbrjI+8daWLrUoq5ow2qJuqEWKmYXsPY6xjd1TToWRljbcM5h2zPCkVH2sKB/x0X3VAkEByix5gx33aMM9kaoLlp0cFmppiFER3CH8GXirxpE1Lp+1mEpTQkWQD7RbsMMDMRjCX+xsIgfRSooHXKAZsTcdGZr7Rk+WV2zPgl+hYctJPoA7vAZJ6w7fNiCUQ3JFetSAwWAYWsHOEduc6hT76MFC1Su3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCKP+nCk9WoQw0qWqjUAHr1oOzpTiWvzmHHUdw+qX/o=;
 b=JRhSZ+zpYCC0HuXAZ7iAQ5HtbB5V/Qjj5x5KTYTzB+qttJ5htHDGbgEv+fgYxIlLfZEL9mZR4ja2ay6mDZns7j30tOYuU8YSM1wSJ/x5sJ6t2niq0sFeVgttG4efSuDQt0VkR+yIQ/pxQ6kLPR1A+/ziKL4av+pfNHHkO/hIdlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DB9PR04MB8479.eurprd04.prod.outlook.com (2603:10a6:10:2c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 16:48:24 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 16:48:24 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 4/5] bap: Add a callback to create a new stream
Date: Fri, 23 Feb 2024 18:48:12 +0200
Message-Id: <20240223164813.66484-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
References: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0013.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::16) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DB9PR04MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: a26f72d1-82d4-4c83-f722-08dc348f4058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uFwbOy6zAs4SM0oCFBE5Zyz3/3XCIxT6vsKyC4DqRp9pRVO2hDDoSXxkhPW/ej+jumetCGzsoGqZaDTL870P+i+bXAcYwzKey5Za5kuBJgfH8YvJMR/aA9mdDZ0ruvxCslvdWhUTfxHBqgJJOQBcw6vkyNF8DtulD7xGl1cCsI9xWBhfl2QmukEh7bBEXR+fJKKfRS3l4tbbh0dUwFGqQ1u5d/v07r8xlxQ9LrVAIcL8cSxf9daywZXM5nAtbeP5M8G5wuZ4AcWj1e2Q1tE/PHEMZG80R2/E+EQMO2/mmYcgn6WPlGV447laox0UzFJD8mE8P0nA+SfgywDACy0vQKYxGghqgiaycRlv39TAAcIubgBfmwek4QC/+tAz9HKvIPba+nojpbgGxqv3fMst6KjedbLcctTseKEQa2IcyJ9cYlqZ3n9vot8fk9+He6MJpsufFhHeiQ8QLQkIPxeDqFeliDET8wwlEIjb2Zls97W9H1JF++P5KhbN6aK/z5Hpf6fDgYUbMF8SW/FLPZ6u533x99lvjRSWj6ymRWQZOF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ePsUqpZ3nao/2rvY5jp8v7uRfrzjmrl/I+L9IfJ4+T9yX+Ie3oU3EtgoUxp2?=
 =?us-ascii?Q?TN16kfLlZx9x6MMLyPkq6pR0ESQXCO5wmqmOk6tq4WHoDcM9RBDaGfWUASUg?=
 =?us-ascii?Q?ImpQp03zYSGufkSnWewIM+JsnihhkIgGgiMlDtxbYxtAgLKAOrBzPmlf++0y?=
 =?us-ascii?Q?B0gBN4b2Fa/akbYDfARLeKK4Iu491UTkDUS4K9W6CAigwFwbZG0WHUC6GDp/?=
 =?us-ascii?Q?EtIvVMuUYdUtD11UEI0gVr/H/2+WcurLVJTWIx68Vt7VXSkp6j0O/G3nwSYk?=
 =?us-ascii?Q?cav7ZNx5bWjGR7482mwQNj5edyGc4TL2IiGcZR7wH/Et0XmBlvHjFcR39kh2?=
 =?us-ascii?Q?l+s0MaW7ACm64mySFUoYCWqzMjnypd9dtNKvl7w/aOjZe6md3lAC8RWxOpWm?=
 =?us-ascii?Q?iuph+rIZfbyJ1tockl71sV3ADG2hkexFFeLcoH1ebr6Ia6QfEJ0zaDoaSpo1?=
 =?us-ascii?Q?3hhQoPJS3gBDMZw1sskS9+3T3qNVMrctYL/vrHhH0x8QMOMu+HDsE494VzA1?=
 =?us-ascii?Q?hLzmQ8ac9FsL/haqRXfXiLJlEfuGdnGrqxUsYFizAOH+dryj82cZI8lXdgpZ?=
 =?us-ascii?Q?iC8B9fWSdVezf0uBQ++XV8GyOmtTlHcsDTXnJrOuuiLLANfRhcmhMyBFLvw0?=
 =?us-ascii?Q?/ly0ngYd/zCHDW67hH0UD6PFQ54Yw5+HbB4/q35zVVEeEjd8ITotuL2fmCUq?=
 =?us-ascii?Q?p2OTMfmK2pRJoHWWMkXQlbZ9SvV+IWGjo5OlGpt3UE4nISyIRyRSKsa0HTw5?=
 =?us-ascii?Q?TAB+ivP1v/N/M85b/n6a/zFBR6/iru+6OZU32DiuOXgYFfjzLgGDxfwN9H4X?=
 =?us-ascii?Q?i8vY/pNZc01byxBMxgRWFyPQpy2nm9FGAeOif3SvL1L2Oo+06nUF9WqQcA3m?=
 =?us-ascii?Q?nRDxskqgi6/yrC8LbK8PwNRUgmUh4NHEjlUen5Luj7VXzQOfvFagbrwZM9Sa?=
 =?us-ascii?Q?sL2TV9Lqlnf62xsZ+aNrJPGCqEVZ3Ws/+8NShe8grrhCRufjaN2Jv0WiqMBF?=
 =?us-ascii?Q?TGeO2Mwvzet3MpnyKuxJScuistKpeUwL7dJxlQSfAqJpeCiXMP15ZeuzrDwW?=
 =?us-ascii?Q?0cMaP0+IrO+ijKgodQipwcnhuJpi9f4cKuO/kXXg4H5AxMwlhaFeI3rGN8f5?=
 =?us-ascii?Q?z1rMGMXRz+s1FYL6GCAuR+8zqIHqkM4wB4TeH9Id++SwUZZojw8Ct5LbZCv/?=
 =?us-ascii?Q?5RNZnljVsikXa7l+5aIG8+nleneyW0lRJKJCshbTBqzHjqTSJAPkgSgiqXxh?=
 =?us-ascii?Q?+SIZycSj0wx2BcnlOWJjjQWtKGSYOCS19ZC5SevSVUgpdYS4FGRndjq02A3W?=
 =?us-ascii?Q?ItEtYSwjMNYc9RLzP/aobYmpO9N/uGdX4Tp2OoD79NPEaoZ8rG+1FLzIMFXO?=
 =?us-ascii?Q?f2j8GPSy7754kAGyQKsGMxDEHsVrFXclk4VjWqVjRLzdKOyPPUnLMmg8TMUY?=
 =?us-ascii?Q?9B2hpcoDxucFdcj+y8n6XsOSOpxls2AYjSsQqB0LjBn39DnzQ/WqPDRfZOJ6?=
 =?us-ascii?Q?bws2UeMBRvPKPBEwGF72uxcf4aJsZOZbTo0OkbfoUW2Q+BMHL5iDiOUDdQIR?=
 =?us-ascii?Q?LGftTjT82xWPXxyolwoeKQAvvzrSYJquwT+TeqIPn8991UbUgvxo7PsVmCrk?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26f72d1-82d4-4c83-f722-08dc348f4058
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:48:24.5482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQGC4FDGANS+27RseZ17yd0BsROEXa2qo2xWFbIGamXOVGpxVSYSk2WMAwCo1du6oaHtsN6LwUnn5+DDQVvZqKDVuoV/tRJLfvvjqADLdgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8479

Add a callback to create a new stream

---
 profiles/audio/bap.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b4acdd9ef..2c7daa6d4 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -68,6 +68,11 @@ struct bap_setup {
 	struct bt_bap_qos qos;
 	int (*qos_parser)(struct bap_setup *setup, const char *key, int var,
 							DBusMessageIter *iter);
+	struct bt_bap_stream* (*stream_new)(struct bt_bap *bap,
+					struct bt_bap_pac *lpac,
+					struct bt_bap_pac *rpac,
+					struct bt_bap_qos *pqos,
+					struct iovec *data);
 	GIOChannel *io;
 	unsigned int io_id;
 	bool recreate;
@@ -888,11 +893,13 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 		setup->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
 		setup->qos_parser = setup_parse_bcast_qos;
 		setup->destroy = setup_bcast_destroy;
+		setup->stream_new = bt_bap_stream_bcast_new;
 	} else {
 		/* Mark CIG and CIS to be auto assigned */
 		setup->qos.ucast.cig_id = BT_ISO_QOS_CIG_UNSET;
 		setup->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 		setup->qos_parser = setup_parse_ucast_qos;
+		setup->stream_new = bt_bap_stream_new;
 	}
 
 	if (!ep->setups)
@@ -954,7 +961,7 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
-	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
+	setup->stream = setup->stream_new(ep->data->bap, ep->lpac, ep->rpac,
 						&setup->qos, setup->caps);
 
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
@@ -1290,7 +1297,7 @@ static void setup_config(void *data, void *user_data)
 	 * and PHY.
 	 */
 	if (!setup->stream)
-		setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac,
+		setup->stream = setup->stream_new(ep->data->bap, ep->lpac,
 						ep->rpac, &setup->qos,
 						setup->caps);
 
-- 
2.39.2

