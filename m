Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC59F196BA7
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349393; cv=fail; b=DnVZlZhOJjxCWlvNA1aPaRwJMy5qwqNLCFNnU+Q92i6CkrT+JYrea05fI2PVLC86lQL4Ie8252jy/16rWvvoFR67I9cZdnz6w87YrEJqZyIhfqib4ELndT5VvovEkNrme/DFw8nnajcNpHHN2oPZNg9Tkb0HfJXzqON48CVs3C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349393; c=relaxed/simple;
	bh=0dRFxR0jNHmTqolxKejhwi7qMMg123Zb7P9CbwTAVrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=otnLJMY/lmclDrkorGtMe4f3/GfgTaQPtQRfvN2DazE4Tctd9hr93Ale1jBh8XoZM1idl+x6AK+8Y1KecEEzqsiin7ztRbrrIkIDNW76sQRFaA96vA6o+bXqEN2AxN/vG/EBbqOvhSsPr1QILSg+q30mtT5G4OlqbPTRX9Dz9/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ERhKt4Pq; arc=fail smtp.client-ip=40.107.6.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ERhKt4Pq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mf6rG6EMuu54/Sim/NL9VhJk/8xLOqBzU4dzPY14JI+RKyehUcFOIJaAwWJeCnUNWe3TTZ6vYn5ICpMT9tz2ZCLxcIdeDWkkLhdX0X0VRO6+EgqFLHxK/bMz0raiwcfDAKEo9PZBvnDmyfsXihtiFl6tahCeCGCbHkUW9ZynlLkIXJRwdf40dBR6VwmOs0CeRCdUm/RxuYtq8LOwwWy8jp8dnymQz0psyOZnxOE/72Ms+D8STf+C0t4ZClHVP5zjGHEHE0/U2dZH8xya2xO13Gu5eNd6z0raSj+6oSrY7oHHvw+8TQPs2CIE7+zV9zXSg8dc6/hXqYS7Z1JpK87idw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UYUph4A2tuOEUiY5ABfQI102bIvYPhwc10RJ5GtO5Q=;
 b=M4c2tkBRCQloGS8Yzv0Ca+hHKutNWLFtp7e2s5WVWwpozOceu/XZ3W0pWSgrp3Et/wW937Zj2l0BWXVpxG3iHo0ry1v0KUIOk7WadUYwY2KFOtADWEh4whDI/1+bMcuEbrAxffeAogoz9E7aXKzUqFFXMbau9ms47hFd03QcouGf7l5lh2T2LcQNMxsBZ0EbrE7Q4HWsvJuQljmI/uUNp92B5rgxtM4ZwT4pktTJw/13n7ZRn+6psAEqn1UtEQsbTAyq5xQoU5M4c1Iea45t896Oe/NfKiLg8TElS1ISf+PL/SGHDWU5ny79fJgkpF+lWr2JUp6PAV4qLFOotKUEDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UYUph4A2tuOEUiY5ABfQI102bIvYPhwc10RJ5GtO5Q=;
 b=ERhKt4PqlUkhc2UTIImZzMI6Aepu+drvd00Dwqxli8y/k+w25jhkF8NpUt/fGuVmXW9WWD3NI1DI6/ReBWjf/MXkRBI2Ih9fr1833lQwQ+iiZbdQtC77vcoXXbMlANT/hnNuFdxBGhwvcRhbdYEJFejzrGnSJ3I9S8q7MPuwC6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 17:03:09 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 17:03:09 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 2/3] transport: Add support to update the transport config
Date: Wed, 13 Mar 2024 19:02:59 +0200
Message-Id: <20240313170300.40974-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313170300.40974-1-silviu.barbulescu@nxp.com>
References: <20240313170300.40974-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0138.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::43) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: ab073a99-0525-48c5-29a4-08dc437f757f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1yqgt6ysbhjMfPEtT3v98Y0wtEFY2sIrLfIfbJ5nYBl4mmRiQA93EKFWkgIircrbvUBL9fbqQpeTiY0/ep9f0z3GIj5tyMCT5YO/Yk5pZa7nvEGUvxikdcxjLKUKq1BWyNgTqZYHuePvxHgh+/WsT5eZV1CZlzJrajoRWWI0uUrY26l2oFwvqd8VDUGGXWuixB9ONY6H254lI2yYIqh0elyFajoYOtfiltnJTiLbpaV1UnDDJgRG11L+pJKtwsUZFCIEKCQzttC5pZnFGbcv1Y7Y6HPFZio80vT5JxPHEWqVnPpUuMoCvYoXLwRsXufdyXf9IMeAJhhfmkVIwO/GDlLKWsBOzjh5eVpVPxKtzPOA5ZDs75/UCs4JLCmltw2nz3xiMPy3LyKcyyX27a5B3Z7XzYY3KYU+M6ILDqf14otjKtleBhhMkslMdOK4/J9UZkEVNgTiAsn1ROGAgg8UuyZS1wQ54rqs8myfZk2RiZcQeqEhY8r74biGzJDe9MxaO2gw/BNc0bX2TDUUkrMBBXHfytZJGzlsVfiwBLjI1PuSYEiGPXzmRF3ZrTgHZ3O2PYuqxYteyawZz9+3VM0SxYqRVivVeH8M0zbccuegQtnl/mxdIorZxxvuRy3rxGvGXCOavUI+7d585tBuLzfOhvUutqaARaxWul6VwKnG3/4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l6gODajkOaOVc53v90MPtnCnyyJHp+oozjNDz7MEKpsxVtB6fWSEfHbEKV7C?=
 =?us-ascii?Q?nlkwfHpasQQFuApuZtmtyJQRYcSj6cKLCjGpaRYwR45ia+GrAg2vgA5/Wc7a?=
 =?us-ascii?Q?KcZb4FCZmMd4mZBs4TgsFQ2ENujbUv/+w4w05VpVe7B3fHSKPhd5EhcfZPFv?=
 =?us-ascii?Q?xJ/c0CV0gkzV2LB/GaetNCrvTFswWpmFubromrCrA0KW8nnQfB96NUrOSirI?=
 =?us-ascii?Q?3opoJz7IYGy5+CTeAmqZSWnid3lbcie8IGB+tABhkETGcrGw1NOxVp43EvWT?=
 =?us-ascii?Q?M7MQuzeumLx69VMh6LdtUK4D/jbK0WyNTgmaJA8MOcpLDbPI56SIfTIbSRnd?=
 =?us-ascii?Q?wm6Hp7EDGHKaaqGGECV1aLthnrbhLiEXFl30s3R5V91n2ISMxeDVXy3dvOXf?=
 =?us-ascii?Q?Q/WzvoSN5E98T8EuhVPtwtGZIr+f6yyyqPIdugGuKx3jNcA2PyTHQhRGe8TY?=
 =?us-ascii?Q?ZCmUhdk1R3co1hA+/RH24aq5X1yikknjALtO6mqXt8NpuvoOolrpJ3UYFR1e?=
 =?us-ascii?Q?Tlhkzz3RCCI9y19ql7ksUpZfdhqRpL/r8CWFQtXlqOGKAV216vkj9qkYhV3h?=
 =?us-ascii?Q?abHGfhj3tbhvlb1BjkDkPjbfAISAL0czvS/gKIj9Cvr5QRmbqWkyoURnnmET?=
 =?us-ascii?Q?0qDuhR4rloMa3lWxj2O1napujwEqK0+C6CboWj5c1KBhK7zXlaoPx0ybFjb9?=
 =?us-ascii?Q?DpQgy9xQ2B1SDxoxCtgIJTgQi/ULMxrq9QNvIYaVt9bInSwjFoFSlWe9o7bL?=
 =?us-ascii?Q?jbJbP/a1iODJxtu8EVVmgvlV/ngMVtKsTbN3N8FLp/7kJSS0q/NrlUcOiNXS?=
 =?us-ascii?Q?FmBCG/1KAdWIpaR5yi/I1ZW2mTv3ozdJV3A4JDhMW/lA14CFyRZTcODpBInR?=
 =?us-ascii?Q?o557uTJVtStehif6Tv+wSyaRZB+eZ1mxiCSiWcQDn60pPkGybEXEpX/XSRoR?=
 =?us-ascii?Q?KTPGm44WL+UjkEDaVKUhWVhWrQ7Ph8debYGFl/vhrshfbSF4sG/bZXLt0VJR?=
 =?us-ascii?Q?cDGvDMNboPyJhGw7ul7dNpKXRH2rAZn2OsZf72dnKqFlmt5uRVWGjDbDr9Ln?=
 =?us-ascii?Q?Ixu28Rl11QYWktwWznh6/gy5+IpX0vzRLskplpI7G6aSHl99gHnL8YQdBnbi?=
 =?us-ascii?Q?MGD0mUChmrGjhUZtdZHWr2GAputbPtuNh7D6iyUuTVcP0fXs63foA4HaLGPe?=
 =?us-ascii?Q?zOoZMJO7XlRRW32QYVGAmqA5VNXhW3cFLntDJAacvUpsE+t5U9zHxUy+NBuQ?=
 =?us-ascii?Q?a8KvIqgwVUfb8lZ0FaWGKPrmfbhD7UY30Xkbq6LDsS4duOmw31yPv97Gxtij?=
 =?us-ascii?Q?qldHP6wzQHrtCZjwE2bjoNLwDM8N2rbZbGwY9Eqly6gwxTaiWcn/N8x0ws5/?=
 =?us-ascii?Q?l4lqibbjTN/jkAAyDY+QtNdHTGTXJDo8TrrmKw1PdMryub7vYAfBsWdqOkKt?=
 =?us-ascii?Q?KNmDKGJKy6xtC4EfsaLThpt3oy5bRJQPTdRi9WRo/QAyTLngc4BAXdv20pxF?=
 =?us-ascii?Q?lsmOz6pHEaBma6RpHkUPF+wCBrWlzPsC1hKqVcYsB6+bQIjy8E71mNZBZK/r?=
 =?us-ascii?Q?PAqeA7pgf8X6HH2DOD4MDtKjVQeGdmjUnyQD9kieWzZhUl9YUpUoVu1Arxio?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab073a99-0525-48c5-29a4-08dc437f757f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 17:03:09.2124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEsQcgoXRSF040mwpn7Ad7L+f0fQxJSvrcqVPFw8Ei1dM9TVIL4as1TifC133Nk6+p+TpXFAhuodD8mMlzX/jbG1k5tS45v44uDQZcdJfTY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517

Add support to update the transport configuration

---
 profiles/audio/transport.c | 21 +++++++++++++++++++++
 profiles/audio/transport.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 159fbd575..122c3339e 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1483,6 +1483,27 @@ static void bap_update_bcast_qos(const struct media_transport *transport)
 			"Configuration");
 }
 
+void bap_update_bcast_config(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct iovec *cc;
+
+	cc = bt_bap_stream_get_config(bap->stream);
+
+	if (((int)cc->iov_len != transport->size) ||
+		(memcmp(cc->iov_base, transport->configuration,
+			transport->size) != 0)) {
+		free(transport->configuration);
+		transport->configuration = util_memdup(cc->iov_base,
+							cc->iov_len);
+		transport->size = cc->iov_len;
+
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+			transport->path, MEDIA_TRANSPORT_INTERFACE,
+			"Configuration");
+	}
+}
+
 static guint transport_bap_resume(struct media_transport *transport,
 				struct media_owner *owner)
 {
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index b46bc8025..6df419a67 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -16,6 +16,7 @@ struct media_transport *media_transport_create(struct btd_device *device,
 						uint8_t *configuration,
 						size_t size, void *data,
 						void *stream);
+void bap_update_bcast_config(struct media_transport *transport);
 
 void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
-- 
2.39.2

