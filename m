Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2083.outbound.protection.outlook.com [40.107.247.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EA20263B
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858961; cv=fail; b=T5ugUuePgwgoPGIXEicHKdCJ90YVO7zq4Dg7OoZ2jtUYmTbeJMtkkeL/UYIqdSNMF0+kDVz6baGzjoiPUJMnTKWyHXWJ4X0XhfU5IJ+1mDauhdP63oMvV/qbqlD+FBs1Cv9ShAOyKScj08C7Neu92ZQS25U5e/ygoTo64o+XCCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858961; c=relaxed/simple;
	bh=DBjw1HuhG9Hc1TTXpFthYCiqbR6nNuTPlts6WlPno80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BOf2xCV1aaz5VqlYxR5w2tOUEAklDrOxfNKakuvY/+fa+Y9N564ZF0yN40Z2RldrwGle/cEmBfOjGzlTLY1JGb69mhbnWf3yjiUrYkEIa60wZtQNusw2znV2NNWY4XXPAQfKUPyy3lPSJ0U48qYHVKsi9xT/dT+PuV2hOAj7Pdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QGPA03EC; arc=fail smtp.client-ip=40.107.247.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QGPA03EC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQ9WuSFxuAjG3zO/mqWrZxdyxldnHzdR1S8x+6aAqz+KlJZOccuHN5JPfMoqxWVsh/B5Rh+yyVejCXacOn6cIp2LJ4GybpqeR+HGaw6Qi2BhZuOAUtZtaxdZ29/+F8p0Q0vi0Z5YGaMaGTOXme4k77hI9L03GNQQcy8yf7kCJ1WYKUYSHgAzMRkC7LocY7xLaUCfasUxdXI2Hm9WibS5Fm70u/ZSDzh9mpCz9Hg19tFR16upfcCe6q5ZT9Wl2TL+VfH2hiuXODhRHmOT3jTqOTfstfVH/kbJefj34ZH2k3x13E2Aig+vAqIqifXwV/v8HKkOd9wpxaPCBv59983chw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kwWf7rVpAhkvNGcoWH8mWav+kcSOW7QebguyLx4xXQE=;
 b=hcepwA8cwNjYOGI/W6cbx06BpwrN0/ziIeeH5d3kyHYRIjGRYbV3vTjOWdQCB2p+OiWmtKHLl3tWA9iyEx6zjIsHJWD1jlmaGne/M+UvuOByPs8mTuoCQDryOj3xUKpntu1mtLUZ6HSkWFnypy6wf9buZgLz3crgc4/0mosfKviOfRDVC9E5bRqV/Dur08oybvMFhx0+WNCEYYkvq5PwrUawmxjYt26T1Zl2nodfaTIz+eAoWEZWZNhYmYnlu7XTpXTrFMCZiDeDfZL5PxyE3b+j7b4w7Gi/2OxdHsSDzuY3TmlFpFsWIykwqbN854131J24vXvecS+7LGvbris6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kwWf7rVpAhkvNGcoWH8mWav+kcSOW7QebguyLx4xXQE=;
 b=QGPA03ECiUKFkEXnGotwmGnH4J32Q0kouoQUHlHzOTQhCMmLSKo4j3QXZkrrG1h0Tiyhf65SEHFkzFr2SX7UG8LoEcz5jSICUeXrOSqxKJ6ti4cYqt/a6+uNarLXhvaJUCnGFJTv0I8bMcZSUkJaNN10nfM98ohmWVZfW3X2hM+v8BjHKo8NQPRToPHRCTxSmksNKEfG+eCHN90qsZRWVzfzPfxtGTUqUc/9rfc0G+1JAcwLGGTvPQ1KsF0xeBghvCZgGQxWitz/NE2t5qqFiiRclvINNyA8TMPook3xnAMWobE5dkeHdJPNz93jSSTMl2tR+eiKnPkVZxeEq+A7UA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:32 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:31 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 10/14] transport: Set bap_update_links as transport op
Date: Fri, 25 Oct 2024 15:21:42 +0300
Message-ID: <20241025122146.17925-11-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 57217cc0-ca19-44c4-d0a4-08dcf4efb30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qZUiFMmDCRWnxQaR3gG/j6Jj/HyUN7BjIeMA0wsNtpDe1fHPG0SKftoRMWPJ?=
 =?us-ascii?Q?Por4e9e+H8qTIYF03OUUFdoIW0PdqYxTWBAhgzzt02GAtBfabacyYbbkeZ9A?=
 =?us-ascii?Q?VzJC0W5zso+MCasnh2SjraW9Qc0pPS9n2yz6A2PnI1WuetDqVMcFOMLBX57E?=
 =?us-ascii?Q?DGPd1+elM3NLallhwoHHVG6JQsOYJCBIT9M1KyoF3fj9KRLY0/gIcQwwEnAr?=
 =?us-ascii?Q?zzZkf+33+5wW7XxPY7/BsWIoVDfaT8EHCTcoCt0XmTwhtHDzQdyfscj93oWK?=
 =?us-ascii?Q?MO//Z42as7EJAxnzQs1IcbRQzrDDyqdhpqQ5mbgvZeTslPnj5KBtG6WFrtws?=
 =?us-ascii?Q?tVAy1KloWP/J0BZRQpMgdFlsVou2rUo9WOBpn1tbvIoimGwsS0WzBbbBuMPK?=
 =?us-ascii?Q?BC4+QY+3OLhPiP99GJfdykLHDDmxGiq61przIuMRWzyptcVlNwzDgTMPhO1x?=
 =?us-ascii?Q?W3DCyo42gSW8So5/qx+FOBgSxM+mZHrhDMyoxNpfGQ+G4MzHfOn+EraFOIXP?=
 =?us-ascii?Q?mZcYnTa74FREkN/9RE2FMnjh8MET7kmf4XdI7A29YNygpukFXb5DUxZrn8Sq?=
 =?us-ascii?Q?LLfoz9KALvAHeTcFsjfvIdmIZ51kixhgC5ttZi1PKLQKxTr6YhA2FjFwSZJi?=
 =?us-ascii?Q?Gf+tjhKvvFDDG0ODCTYY9gOrf+Eoz27ZhRSTii1XlA5bmIWX/9CyxYaYfWV2?=
 =?us-ascii?Q?6dxMTzXwvKS7TxWs9I1eUwaDdYXVvM+DAFKgmZuD1xDtx9/Yi/FpjgvZ2i76?=
 =?us-ascii?Q?q4LPVvEIT+RuYQ5jGLY8Q8CR+9HIghay0LtAmiiq6gT7JOD4N1t+KlneTAdd?=
 =?us-ascii?Q?EkuoabJ2DHMwM7TXVQPL/8iau7YVDNRPiUh31se4NOg8bVIDxDriJGQtunMY?=
 =?us-ascii?Q?NQJwJJh5j+v9/0huMUn7mebrZ2ildaCZCWI23gz36w6oUw7ONSFXnvpXMO2h?=
 =?us-ascii?Q?BXXPsLbqIw+NPJwCmIlwSKgYR6oToobMpA4WBCAZBZPdYeVffYQd5jbRZqrj?=
 =?us-ascii?Q?fzSbs87Rcx+/Jl/I1b1r5bYATxP8DmEKurQxZM85zxc/BwglGtTxdLW8Yov2?=
 =?us-ascii?Q?4swporU3xsZhicEGkO3j/ERGBYkecRej46yzlo5vSSzYlxe5u0g5c16wDVyA?=
 =?us-ascii?Q?lLTZLFFx0MwvQlwlzF2oi/Bd0/cCcLkfrD4otvG33rtZMoksY4SBnKsJtC7I?=
 =?us-ascii?Q?3/iZSxiAsMUoOr1aG8UnyGbxPmdE3qYfRjtdIo7JYFQifmUT/2UHie6skN+X?=
 =?us-ascii?Q?w+IyvFQS9QcO9fyWRmZ6v/3vb0KrDWjkfxXxzUa6ZroiJRVGqt5RZtP8YV6I?=
 =?us-ascii?Q?jqOW866Y8+KvH4x3GqS1gfL+v7Bzj0OuiWQQq21+9pJNSPdqyYfG1IQL01q1?=
 =?us-ascii?Q?5rXzJic=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x8RiH6+LXChgontwqEOYpEp4Q/+gpR3r9wUqHG9ZMWNP1D9TTwvcaAR2wtVh?=
 =?us-ascii?Q?7SaKYr4S2+gRs89rJG/z9EuatvUnORXH1TQGEHfxfcR6ZUNIsELaPIR2OULX?=
 =?us-ascii?Q?5ViLo8My/JX1yrrhDil3kYUFbIavE50vWH7q9ceTMFDkfeRbiFEFoSpemYNE?=
 =?us-ascii?Q?D4qNs3FYXeV/bZRV4FG2oZLAQiyep4JpzP1JtM39o2/FfMLUnIjlPbq83/2x?=
 =?us-ascii?Q?CtNUnuGFpcbIn7O1eB/8MHVqG/RsPxc2B4fT6yTUqa16lSc/y08UlZHLKAPj?=
 =?us-ascii?Q?TxY+OdjHw+bWQ6IWjPQEvjnJ1+JtjTqc6YFZxyw24gPvWqz7sPBrOsvUtQrQ?=
 =?us-ascii?Q?6yfB38RTyTXXrdjCRje77Qa3rcAmgV5SSuj4SRv33EiNCTpmir27p99oKSE2?=
 =?us-ascii?Q?M5f2ZJ0jXIQesSEEWeeFiJnXORj1qWJyz21k6U7d3gPyAaLA7ecOlapvjfyd?=
 =?us-ascii?Q?jTjKn7SnDNQssC34qeDEEaNrsP++YztbRYyabVRG4goiDTBSBquGm4/KmBqF?=
 =?us-ascii?Q?ripFKhgLsrrsTRb6OnyzwyLoSW8ZS7IF6JSwpfiDUWoA87MzOUyw22zqzLXV?=
 =?us-ascii?Q?/JSy03VbkolZFgII59XTyaqaVEzJAutJJBUKPLZUyDgQM/r4ffSj1XnDYiNp?=
 =?us-ascii?Q?EkkhCSd2TLt9P2OxuGLt3tLiPGBlUyU3kQVCKaZwvAY9LOloZ/w09tFGSRlw?=
 =?us-ascii?Q?N5GXImGi2xjfUJh8NUwkowkp1ZGwYVrgRvafTRoK6t/P/H3o54CyH5D2FT53?=
 =?us-ascii?Q?RmfEdOaSBZg3yJdnCxANfnagHow8AVPpbzRwpgk0uDQxLlN2aRjEGAO1RL4o?=
 =?us-ascii?Q?XK3dsk4Ht7Eo/C0PxdHrGS/JOjK0hPN+tlbAgNTsGVCupPCrCxxvrOHprVSG?=
 =?us-ascii?Q?Xyhtq74GO4ZVZct4lT4QfnvyT2dKcQyzVrNuCYCGbijy2sicw6Kx5aK+vpA+?=
 =?us-ascii?Q?biOIgIUot6MBEGZUFLeHnePuTxKzI7SLOJB4PHl4ejGXjblkvo+Vc5DU/sNU?=
 =?us-ascii?Q?rhCLjBA341tlPLUDrqhKsNw9boOoLBFLD6hTNWjyB/tV9clBU/IBhMbOS6Xd?=
 =?us-ascii?Q?lc9xxDGTdW7DuxPklXktc3MD6iQnjF95N8ZFo+rwrD9mPtOdmgzRX2o4tS1F?=
 =?us-ascii?Q?85YK/Tu6Gy3wXjkx8jPryB1bbRrgtGpkHuLhAGG3A+0EFXgFG1jZOzL6HfiR?=
 =?us-ascii?Q?zZvSjx3lGVBDTEPfui+7TpDF912pB6FUwjHZ+644vz3090nyKRE3Ton6Dbqz?=
 =?us-ascii?Q?DpkrITftSICOiq/tonuKnDND5eNueVTLgypQBLZuwjGVZW2TiopceDXYHCiJ?=
 =?us-ascii?Q?Pfbaz9riE4l/mslldgesVE3JIVGmu/1kUDnnYLf+hUDvDTQlwWO+Lwe9EP89?=
 =?us-ascii?Q?WjikAdwAeDS1qIA4lnShF2cCmvvP8/sSqtTYxnH9i1cqCj4QtpcS9p9OOdFv?=
 =?us-ascii?Q?Lfn4HidtLYY2jsFJKu7pmnPwGz1IG6T9vQyru/nKUAUywdWpcBAMpCl/1ER4?=
 =?us-ascii?Q?inZpGqn6vID8AX4t9FXgufOgELPQdwr/O5xXOco9hNPgoTnZUwjRzuDSRirz?=
 =?us-ascii?Q?BXu4KrY9d0vPjILoaKErqipvynJFJokEEsPhpByjyHNSsfr66E5MvngqHytn?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57217cc0-ca19-44c4-d0a4-08dcf4efb30e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:31.9196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/pDI1POgs9F6qpcoBomQtVmarVhK9c+Wu3MknMeUbXYKjCNslRDtgs2C8Py9mTBJT3QO2bmAf0O0bjYekzaqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

This implements bap_update_links as transport op, since broadcast links
need to be handled differently for unicast, which only allows one link.
For broadcast, the property changed signal should be emitted everytime
a new link is added or removed.
---
 profiles/audio/transport.c | 45 +++++++++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index b3bcbaa19..2f5ff6de0 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -116,6 +116,7 @@ struct media_transport_ops {
 	void *(*get_stream)(struct media_transport *transport);
 	int8_t (*get_volume)(struct media_transport *transport);
 	int (*set_volume)(struct media_transport *transport, int8_t level);
+	void (*update_links)(const struct media_transport *transport);
 	GDestroyNotify destroy;
 };
 
@@ -1628,7 +1629,8 @@ static bool match_link_transport(const void *data, const void *user_data)
 	return true;
 }
 
-static void bap_update_links(const struct media_transport *transport)
+static void transport_bap_update_links_uc(
+	const struct media_transport *transport)
 {
 	struct bap_transport *bap = transport->data;
 	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
@@ -1651,6 +1653,30 @@ static void bap_update_links(const struct media_transport *transport)
 	DBG("stream %p linked %s", bap->stream, bap->linked ? "true" : "false");
 }
 
+static void transport_bap_update_links_bc(
+	const struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+	struct queue *links = bt_bap_stream_io_get_links(bap->stream);
+
+	if (!queue_isempty(links))
+		bap->linked = true;
+	else
+		bap->linked = false;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"Links");
+
+	DBG("stream %p linked %s", bap->stream, bap->linked ? "true" : "false");
+}
+
+static void bap_update_links(const struct media_transport *transport)
+{
+	if (transport->ops && transport->ops->update_links)
+		transport->ops->update_links(transport);
+}
+
 static void bap_update_qos(const struct media_transport *transport)
 {
 	struct bap_transport *bap = transport->data;
@@ -2105,7 +2131,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 
 #define TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner, _init, \
 		      _resume, _suspend, _cancel, _set_state, _get_stream, \
-		      _get_volume, _set_volume, _destroy) \
+		      _get_volume, _set_volume, _update_links, _destroy) \
 { \
 	.uuid = _uuid, \
 	.properties = _props, \
@@ -2119,6 +2145,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 	.get_stream = _get_stream, \
 	.get_volume = _get_volume, \
 	.set_volume = _set_volume, \
+	.update_links = _update_links, \
 	.destroy = _destroy \
 }
 
@@ -2127,22 +2154,24 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_a2dp_resume, transport_a2dp_suspend, \
 			transport_a2dp_cancel, NULL, \
 			transport_a2dp_get_stream, transport_a2dp_get_volume, \
-			_set_volume, _destroy)
+			_set_volume, NULL, _destroy)
 
-#define BAP_OPS(_uuid, _props, _set_owner, _remove_owner) \
+#define BAP_OPS(_uuid, _props, _set_owner, _remove_owner, _update_links) \
 	TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner,\
 			transport_bap_init, \
 			transport_bap_resume, transport_bap_suspend, \
 			transport_bap_cancel, transport_bap_set_state, \
-			transport_bap_get_stream, NULL, NULL, \
+			transport_bap_get_stream, NULL, NULL, _update_links, \
 			transport_bap_destroy)
 
 #define BAP_UC_OPS(_uuid) \
 	BAP_OPS(_uuid, transport_bap_uc_properties, \
-			transport_bap_set_owner, transport_bap_remove_owner)
+			transport_bap_set_owner, transport_bap_remove_owner, \
+			transport_bap_update_links_uc)
 
 #define BAP_BC_OPS(_uuid) \
-	BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL)
+	BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL, \
+			transport_bap_update_links_bc)
 
 #define ASHA_OPS(_uuid) \
 	TRANSPORT_OPS(_uuid, transport_asha_properties, NULL, NULL, \
@@ -2150,7 +2179,7 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_asha_resume, transport_asha_suspend, \
 			transport_asha_cancel, NULL, NULL, \
 			transport_asha_get_volume, transport_asha_set_volume, \
-			NULL)
+			NULL, NULL)
 
 static const struct media_transport_ops transport_ops[] = {
 	A2DP_OPS(A2DP_SOURCE_UUID, transport_a2dp_src_init,
-- 
2.43.0

