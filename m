Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192885F54F
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014321; cv=fail; b=HKXa0qF4xhp3ZBGhHI31wIyIYwln+slx4UNKArC2Xfpi7SdN4pZrzeUSgNq1bIydGjTKdpCEdxtSOdMAvzKVcaA9mM4Sg6XoKJ3OfTF00ySk0kS4TK7RUvWZw1Ul+sOs1RpFXz3/IEs2MWSlLxlgO176Ra2j8ZYSEZTwQIkXLG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014321; c=relaxed/simple;
	bh=wh6h/IuEpt+P2DTNpIf5fQuuR01n1aDe91PSuob159E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gsww45uN2GNhn6HkFX9pR2tXefN2kdh1icrazoTaUwsiqlBGGLiSGTmgawByN7cHuONKr09flVPz3sEFrXhA6iUc7ffCGLkJ5kw2ECeVjAWGX/Kbk8/ohUN5vI2n2SpzwHaVF/zhky24G0pGZaLaGsLG4oMgBV4rroVRdpRLnSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=G2vySLr7; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G2vySLr7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jf7BHVoJhdiO1G0a7bZMxKWSmq9j6oUwgnBU1nt0jE+etCA5VMA5Tl47tExEsW8EAYpBazeGEp4iGNClIkFfWaFzjMnkB44IGCiV9kPo9t8JYL//QEezeADHwcS+nfZ/INLHq/GwngD8Zb6hnynXUngnSeS1Ih2m13qO3/kBaO2FP0jMrPAWAb7RwCOFgRK4mN1NY3DwwcOfWd1R6beMok53E2EpzZ3aqV0b7mpKT7DpQeYMJIXW/yoLZ91hYuT6uiMJXShja5HrriDRbGNTnTHQgR0UKXwM8tXuIuR5JfuoWTi9wiuI4R7hqt624IGddgoLyVDk6gbojnCeSnyJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJ8BuVhcVHgIjL8L0RHqr+AdFwZqyvpb1wBaB2Z/t1Y=;
 b=ZyoQfVjbB21z/eiXCykfpx9XmGmybaEmVIcB87pvh82GyiPyvnGcWSIlL8R7SrzHtqodcexgKHUiY9DuuAaPpqs9R+8NLqL7t9y89Qxby7Isdlw1ab7AWxaKu6V82yBqM96HmilkUnyiRSH3cYR6yRsMebVg7xGlqBqCRMsbagvuBziKI1vGha8odVn65FEaFugab2mWctyunUNe1hz41zF4eEUsDw/G54JpL5NiPhv0cdhjeC1uNiPS5R3K7bg9vhkxMLAeb9rqeYvre105R9+rJ/9NMFQ9e18iIyph9F9gykrsBttLsELlrtkwPZuwTnt4co9enAzvlFYI8lNo8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ8BuVhcVHgIjL8L0RHqr+AdFwZqyvpb1wBaB2Z/t1Y=;
 b=G2vySLr78ySsuYSacv1U/hwvZePO6RGGYGuyFQOe/CgAZzRftNvXe+zxKRcSdchkvztEOdE1SnHYJJzzlboTcjEsI0oStTlyBc+JcQK2awMIqGBAoyOoYhqiIJdecvt2xHuc/6KQQ22BtRZYR5ePhMSZmb/orM1NaMB2NygK1t0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB7864.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 12:51:57 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 12:51:57 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 3/3] bap: Use SetConfiguration info to generate BASE
Date: Tue, 23 Jan 2024 14:51:45 +0200
Message-Id: <20240123125145.70371-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123125145.70371-1-silviu.barbulescu@nxp.com>
References: <20240123125145.70371-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0057.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::6) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b9e3378-1401-4fc9-ede9-08dc1c121536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7+IYcKFwYeSGQFa+iMxfYO3Gxz5Ob5U3JBrW/FfO+vEOdHKYPX0jHvUf/Bui88hQAo7M8O7P2v3GL/8gu3A8Ld1iCC6hzPG7OBGEtnLo/1oYwY02GAMb1YkSIhaQx8DWEnvurYPbtRbWO4JDnhEXgCjV5fE4X21DTEP6yHvZD1VpbuCjmtiLwaRtTGNNTVEEAuLsYyKDFGqrlQU5Ea70lCE5YHcMU/bEJpVGBd4vtdIaAo8C0qgXJnOgAOfFHrN6fYRPmf4SEvXgNHEKXqxQ1jzWBONW0J2F2h5kHPi6BlhACn7bPsTzGMU0FeknfIIVnl8Ky0GWCOanuP4PZupmpHywvhrH4e4SppZ5nTsqDalRoYc3rmQb009KfIObCvPfab9/3tkJTDRsecPgQghTsMjCGPCIuslqVEPOSx4eA9Qw5HdhXhQIknic+wpB2t2ttgffbYIW5UrT2B+3uTZMiOe+E24rKd4FZBxxjYfACOrcUKD8L3qJnA3Sc9LkA0m5QbQZZFTGirFxeFDkPd+yV22hVii+MYXCnjk9EipfDcqsNaTaFpLh8/E53CLPoboR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(8676002)(8936002)(4326008)(2906002)(41300700001)(1076003)(83380400001)(6512007)(6506007)(6486002)(478600001)(6666004)(26005)(2616005)(86362001)(38100700002)(36756003)(316002)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?26YpWIU4DFCsXgOaddtNrxNM5stj/VrqiBXl3lIc8GmK2FkQyGh2k9uYwcqE?=
 =?us-ascii?Q?LlAYIKVUxE/XDkSFZNY77NMlr455vCH4ClZ4zyu7eTm9FXbr0MP+AjNLx80F?=
 =?us-ascii?Q?To40J41zfZWzwYAeXsk9rqJCtWTD7uJR3tXi5A2gI1N7XF+858sErq0o14Fq?=
 =?us-ascii?Q?Zi15h9eUR5qlsCdCP8WMb8YCcSjgqLfVcC3ZBRbLEGplre0MrfBERCxgqOX8?=
 =?us-ascii?Q?Mw3JVQvMfRXP6AoCRDT+AKqEZEWqb8UYsOeOV2IqJfFhubkYmBZZCc6F2aHd?=
 =?us-ascii?Q?Hawga1pq7VbMCKXM61h1xQCZ5gqIkdAHRa3ZOasbKjo1Puwoj6TlE6j76MJg?=
 =?us-ascii?Q?LUDjKnJz4cDGVsURIZ4W4JEST+/oWRKe8n1qOeDIIq0SZfbjeQ2KMtRHVuzh?=
 =?us-ascii?Q?VqEVAaWzCdLKNFbU0UcysC4iFY5qCMKKDA/1sMbXEYNt1dNpKQnj518iBYOp?=
 =?us-ascii?Q?3S+k7KEl8j8EezvJrAW3AyW0GDTtjT0k2+jKzSOdlMV0AE1KO+uEo9gYcrBy?=
 =?us-ascii?Q?7tjtScc14GxI4nB+sqOflkb49+QtqdKFPiGuZEIIcdhT636dzQRe6J30exRZ?=
 =?us-ascii?Q?YqWmtTQhWE7d1NQkN+jtJOOoK8CxI2Tg3pngivlMJ6gTNkQ06LHuXxvm2Nbz?=
 =?us-ascii?Q?S1xg/zgen+zXkKArTxmhx08IfxbYibgO+MkHZuHl64fUxxl+4C/bM1P7bjJL?=
 =?us-ascii?Q?Jq4w/SzKSTu1pJ1xef1vI/KjGRg0WWTyMJZj+BOzhhM16G1PcqgrKo3Or8Zm?=
 =?us-ascii?Q?ovWdWiiPArb3j+sg/xphT/3xcGK9boUIADMkm722wTAepdhLHNQ0dWVxqcRX?=
 =?us-ascii?Q?pB5wjOYGvvcG3wOryFVD8Fbvsm/VBN5K6Q5lojURUBG06MdEqmZM0xNiAKDo?=
 =?us-ascii?Q?oTN2BPbquty2osmuYVojCsGnbrjhQcrc4EEeCpLz0D5fJi6Gmt8gmI4GqLZm?=
 =?us-ascii?Q?2hqm4xsoHptkn7NNOOZo6FBVOjPCY021Aoi3SI2Mqi4AznmsCnHpoFnRG9pJ?=
 =?us-ascii?Q?aB4ZFJr5gyvf07GYLr938QZYwfht9HBw4MF13BCG5iJFH7WIYIFUrRHGSmQ0?=
 =?us-ascii?Q?kEkBgqqqjAU255+RwmawQZHQGhFP/V+mcjSvY73uN0C9FX5MAEk9er3l6Wat?=
 =?us-ascii?Q?xWXp/YasAOYcVs97jG5vy4tcZz+AHL2Zx+SNgZejUP8caIGRKt2L38ljDJbj?=
 =?us-ascii?Q?LaYgRddmwr7Q+bawuRGcNttwSKSgoiIqeZDlYJxkGO78ifkXHqGmeP4Oc2BZ?=
 =?us-ascii?Q?7+5VauTyRO5JZOyj5phm4EMGQpzRu11b7pVx8rEKweR/e66Jc7f/jvzq52pG?=
 =?us-ascii?Q?phDWiXpNd66AGvI9YfZc0RoFvtHn2USh1s8wCQzTzk4rqF15l3nu3a6leqSX?=
 =?us-ascii?Q?GW+PjA893ZqBR6MSUjLkr+T8o3KMCeBbY8YAY6WkBAtnNHnQ852g4WiWk1iu?=
 =?us-ascii?Q?4ayNl5WWkrCipPouciHG+divWAFf1dvS6w5a12tmWD1qyrsIc0fpijo6G24V?=
 =?us-ascii?Q?6vLjhxaSpMqP/uhannjlHRXghQXn48QC7djszhuurU/eUsS+Q3q9H9yYNLt6?=
 =?us-ascii?Q?He7+bew8mAmvfsurFmn7WkNs8F5+9IlIUmJra9xw8wVn05JA8v06zcvECH3x?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b9e3378-1401-4fc9-ede9-08dc1c121536
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 12:51:57.2081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PvB9EvxmtxWrXxWC3mBYwDez+DiQpJTR4XsY+zjP0/lMOFWTKFp2bqePlpHs7aMB+gFls3dy/A5SC7a+ym3sMMMGjTydaVspI9Drg98CfQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7864

Use the preset information provided by SetConfiguration to generate
the source's BASE and not receive the BASE over D-BUS.
---
 profiles/audio/bap.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8d44e48fe..63bdbb52a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -610,6 +610,11 @@ static int setup_parse_bcast_qos(struct bap_setup *setup, const char *key,
 			return -EINVAL;
 
 		dbus_message_iter_get_basic(iter, &qos->bcast.timeout);
+	} else if (!strcasecmp(key, "PresentationDelay")) {
+		if (var != DBUS_TYPE_UINT32)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.delay);
 	} else if (!strcasecmp(key, "BCode")) {
 		struct iovec iov;
 
@@ -666,18 +671,6 @@ static int setup_parse_qos(struct bap_setup *setup, DBusMessageIter *iter)
 		dbus_message_iter_next(&array);
 	}
 
-	if (queue_find(setup->ep->data->bcast, NULL, setup->ep)) {
-		uint32_t presDelay;
-		uint8_t numSubgroups, numBis;
-		struct bt_bap_codec codec;
-
-		util_iov_free(setup->base, 1);
-		setup->base = util_iov_dup(setup->caps, 1);
-		parse_base(setup->base->iov_base, setup->base->iov_len,
-				bap_debug, &presDelay, &numSubgroups, &numBis,
-				&codec, &setup->caps, &setup->metadata);
-	}
-
 	return 0;
 }
 
@@ -924,8 +917,10 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		/* No message sent over the air for broadcast */
 		if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
 			setup->msg = dbus_message_ref(msg);
-		else
+		else {
+			setup->base = bt_bap_stream_get_base(setup->stream);
 			setup->id = 0;
+		}
 
 		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 	}
-- 
2.39.2

