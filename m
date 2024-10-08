Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2068.outbound.protection.outlook.com [40.107.105.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518771E9060
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374520; cv=fail; b=aAUkU9BO7uGJCRuuLzkV6VHOTnxJqeznARGP33ez53fg1KpgVA0Ox6YwQ5Yb5eXcvTzzqrsyzVSH5XsGuu+fw18Ks+RTK1LQWtI03PGdzgPWaf+Dyc+S+Q/FjWd+6to8PIySUOmUXQv4IwmYrwmamQpg7Scoo7rHoOPzG7eoaxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374520; c=relaxed/simple;
	bh=AV1vV1n58c7AhXeTZ1yYRSVtK28wk14DI+k2D+FDa+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gl6gKSv6TKe4MsecrxxpaXzoZW6BMMTbrpyF58s18l6OPRheK8ym3ZHrOU86QpQrDdkDK++p+5uavwEhkiAN1ZnnFbD5NbXX5kc9zgOLCWYaC0KEAsgkpQhgc3NaL0SVMKWj+iM1hENB8C1t2kAccY0XJawg15gYnp5WuFA1Sik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NTovQoZD; arc=fail smtp.client-ip=40.107.105.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NTovQoZD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tibj00uVl98jOygTLnvVCi5/HEpJufzVTMJu236HvkPXkRj9gFZQLk4ooKcr+RcQ6r51RyZ79NBdrf6xIdCOXhMcV0ym3mCs6SxBb2LOt9PfoYCsAorU8GhL5x4cgKtvCkKH0lsV6AvA0oubCb9KAjj5ttOskMkwLiVj3JGQFZKm6D3tMMVcGAGzRPV1Ir4qxnk8j4zqd23fowOmCPILT1GEjyLd04rHS95ZgvgncPphiDD7NVNddPzUjdfPEZ1ETMVGZpga8Tp96PjSITLUCEMzSwWzkKiBC9gZZ8oEIIbOo4jBpCPiSRokutx1Dr56l2eWTTmiHRAWAlCaj2qh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qSgq3ljGwWpIXHLnfCf490g9kSxQf6rcDuOJQowQnjc=;
 b=u2XcxWc/voCm282wSrBugH5KLcT766RZM6P/HHxy5yjOoU/pUvZhTuYaxl0/laDZFgv6FWXmbtDxENOiTYY9KycD7vZfvlbLOfVPBskdmJ5LrF5UQTEED1M3dx7Wt9oVRI73LyBaND/CFi+N/rOcvov7LSj1VvXkrcmaf/1OfHLfNXieFCtFqM2SJkB1pChN9d/ljCRlMku1qb6TOqpI6/rf/KeiOfAnGrB/IXZb4tZPuPxY713GMGnmeZEIwAPVxpBzRhUz33dotchwn1rQyYavLmQvFsokcECt/ZI2ypRRjTOnOp+ySbko1AvklPVrih4OZSJ4br3Hjk+Ht98S0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSgq3ljGwWpIXHLnfCf490g9kSxQf6rcDuOJQowQnjc=;
 b=NTovQoZD+gB/cA/uf17BK8PckNQKh8+TuQE0HDoYeW9Wd8gv0kp5zKlwRBMkkejo62eVmoNtTeUW6Kzhu8PBg2WZu4JXOPRJN2jioP0Pefed3mWYqC+7kuKgCtzs8fNuTvCp8/pIYsrdGoCKtC/jUbbdpZuQpqWGAqsKFxOqtkuQ2gfbU9XvTlAuWsVewqotm+UXeaYaapEpUDh6p7y+fnTVw13nKILM/AwrWrlvdbUQyPcJ10n+yP+4PN2ga1qo04TMiOQn5o6tz5Oefb0jtBD3STX7KZp3jwa/MllWlE/bmR4M09CBaHI02NvJabjN9aeQfJwtm9Vg3XmajGs/Sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9343.eurprd04.prod.outlook.com (2603:10a6:102:2a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 08:01:54 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:01:53 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/7] shared/bass: Add API to set BIG enc state
Date: Tue,  8 Oct 2024 11:01:21 +0300
Message-ID: <20241008080126.48703-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
References: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:208:136::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: c05ded0d-cd2f-4c5d-a41c-08dce76f7750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uEKOj4+o8Bx5xRdsM/dt3UB9b6mCh3YEEs2wiTmnewAhGbWqpT6MsgNEhETE?=
 =?us-ascii?Q?EQ0+aAsRqpIM3Mn49AdVrqI/ufFlbrQeIpcceYjfl6Vz8JjsLmcP7twMdtG3?=
 =?us-ascii?Q?8rAFjqcGtvULQ+4di2nx4uMZXVxjVuPeHWqeijx2mZDb02pCkZQVCUKGYLPM?=
 =?us-ascii?Q?LQBmfylKyiheCVmF0A0eFD5OTickgDgD3YExx7R48eSOlLFFcnqWMXzuAUFA?=
 =?us-ascii?Q?U2oVHH7BWrsXWuRr+ZemgX0Gn5oKhsvZ9Gir+/A/FaedPF2L8YLGEWi5JxK7?=
 =?us-ascii?Q?nhi7oxPFYqKkxDXTcc5dRHsWNcpzcOmWvejgo3ON+BNd6R4omMp8taPXtX2P?=
 =?us-ascii?Q?EMed8S7fPiiJUFvmPxwJsMAzG4aT/+ffhUyZqMKs7GQ9bOeCwGn6BUklnAnC?=
 =?us-ascii?Q?hDxcAGYsrE4mBBJ2UqmesXPnkX3Q7O1K90RzpadqOYyozalK9uNgCxbXNZ6Z?=
 =?us-ascii?Q?edzxhSP7XxtFPfkBL3JCdSEiD7XazeZ+0X18uqcN3McMxLGtSkP7OcXz11ls?=
 =?us-ascii?Q?LYY0WzFw/ib5Yt+uKAtksAEz0pA79WPnLBROMPiiiVQYFo5ivlrbMUMcarE9?=
 =?us-ascii?Q?UCgDiUfiak0JZRIhCH5Q6J6x0sX/WJcYHq1ilnjkDJs/9zRZYiU0qnnMnoRJ?=
 =?us-ascii?Q?r/iEb4T0WunX2TBPpd5td7hKd6OJIaikj3nGhwNaRE/bebYt0H3uqdA2i4KK?=
 =?us-ascii?Q?AaPXzyWPc8Q6rmzmIPrAPAnvs3ZfIwLOA+ZR7xSG3K2FInoOIxKjB4IElD24?=
 =?us-ascii?Q?iMk/UzoHBD0jsXTQyh2YELzLQ8eLBiZ61qi0Kd9OH62TdJOYQIaB1KY2KgaK?=
 =?us-ascii?Q?ANJck6spDJBASm01rhPeIqRk4hr2GM59bk60Y73ouK1g0ISPiDYhM0Lmkhkt?=
 =?us-ascii?Q?Tr0bMKMrwGajU6BW0YkjxD1tZpTZpUNHWuSaa+kv2aH+QxqbeeU/wE1OryJ6?=
 =?us-ascii?Q?LjT4I1QLjdy6yCsnltlYXuRGwzkGxRiC99dH7eg98Gr/pXRe3xQ7nIQnuNQJ?=
 =?us-ascii?Q?K1iwxpGw/c6/jlZWZGlZOrhkT+Ky8DceDFigsJ7MKRfWYESJwgJbaz3AYudV?=
 =?us-ascii?Q?w2wF4APGhu192LH4kDVskczKQ5gBGaaF0CI7Nu18CEa4jORKre5bCB++NXk+?=
 =?us-ascii?Q?vLS8LcjiP04kL4YprUmdqz/PFuUDSnNGY51D9q4QD/BBDjDozVw6JO8ZXkyT?=
 =?us-ascii?Q?r7IZYML8Ita3L4FxDFL5TfImbno2cSVuCqdIlYqqs4sQAY53uyw7JbogwH5H?=
 =?us-ascii?Q?GHXH3m65lg4qCVtT+UpeqlQSUd8wzC8dQhMehvZryUJBySgfcl44tq9XrkBF?=
 =?us-ascii?Q?BFryBy+X5cqW6lvhNpW+upkYN3PsNuZO9N6ubKD0ezh1oQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c+aBR4MQ7EwrsENDQiVhAcWUGr7C/KNmSp62vCiuxxZu0yPn63tErD5rPJ+p?=
 =?us-ascii?Q?Mgo3E+xtlxmk6nLzcq6ZnLsdSr+KVzuHcyHyhzToiVKKQSu7zTwzBfDaC94t?=
 =?us-ascii?Q?3CoaowEMgHS6J+14bSblQv2XR1EV6biCWTmnYUC6M1VH20E3invfl4RsaIKa?=
 =?us-ascii?Q?0olomQcd1Re6ILTuZ19JPWI3g48ctdLrMu/S2BfwfzzUutN0OeK8y9eD5uEg?=
 =?us-ascii?Q?2iQu/2bTw6RW2EusDVErsuB34QxtI2/qw2pD95m6hMtWa/KSoSw83mbqihSP?=
 =?us-ascii?Q?BV2aum+7H9bn14macuAIp5GngbzYlxlxx8aCcc0qP2g2k2NR7ClFpucTaAMp?=
 =?us-ascii?Q?0hmVe81ekkcZHEeSTrD4sYJJlYuMGOZgAr+cgeByAOaDu1MjfUqwzZkCF635?=
 =?us-ascii?Q?SWFIulGmk20nILntgbZPP9B2V7ar2MoRg3N81hSD+VaAJc9NrBrtyIjVab5q?=
 =?us-ascii?Q?FTe3o+PwLyPHMJKLL6IFi1n1C+3fiFZZMj2DhYPBcjdk5yvVVXpt5Dm7Gz7B?=
 =?us-ascii?Q?2M99t7l9pysJ50718IJraccWIwr1OOlJlV8Kfg09Y077JMjXgHJn2lrxOooi?=
 =?us-ascii?Q?jY7PGOMzSWUUntlE1+Je8kGFSg9qyK6hYVLvLqAa/JS2hele/m7no47+hCkz?=
 =?us-ascii?Q?krVbdCrUbTkkdASQ8rBbijkFQrdxzTLTVaLFbMz3MFsf6yJ9wI5epWmwgR5a?=
 =?us-ascii?Q?WxlP8lUuu5wehxzlcrShTsyZGx0RN0FC09bx1hxa+ClThEmZAff1TkKJbwgs?=
 =?us-ascii?Q?46xWOCtyvqgcnT5VFrKeHGiNJTLyc5RYBpbf/sHH9yhlWMbsXCPSuHgSSo6A?=
 =?us-ascii?Q?QZPRdsONWpz1n29bx/M5tBzO+qQaJa3aZtEDKsic+amH+JQEtAZ8k7PtUYK1?=
 =?us-ascii?Q?17Amab4K/UDraYSqPQGTDdLO29wmJMGtyAOV0OiPPibgNn6brmUc2rh3K3Si?=
 =?us-ascii?Q?p8HdbtLi6+VgvILlPJYLn2SdQ31ne8aFuPUCgVKL38k7ZfgFy0lVMe8WSG89?=
 =?us-ascii?Q?Tz0MuNOZPNAQHlvF2YDMYUxXmCK3L7iadcAg0mLHm3ltcZFp9luFJT+Cw57W?=
 =?us-ascii?Q?wcMwMKcKMooLfci5jBkvXOhRx6jJpKgJdPdux0fp0ypNeA0F2QuTWuA8aJRQ?=
 =?us-ascii?Q?RI55pdl2bFALva4xfOoVAeXqYMb+uRCjcOwrD8Et8yJUIqh0XOHOsHyAGuiV?=
 =?us-ascii?Q?Rd11iJDX/XXOGzBfhEvmfV1Wt5g4hgJaguaWgcnPjMMQcXo+KJn6+/8rGlRH?=
 =?us-ascii?Q?qtasQbKklxNljw67ZioIRuOBWItugV0WbmW6/B9X0wxI/I67xPXSs13B9Oj6?=
 =?us-ascii?Q?YW6RV6WRQqaUJkV8Tq2l5M0ZqevLeN8nLRC/AGUdfxdZq3SgLuFA0wLVYTRf?=
 =?us-ascii?Q?iYS9D0a+Bm3RmiZnDjNbYrQrhNqHPb5PW0/AUX49xVDTX/c7lCxLixHR+8EJ?=
 =?us-ascii?Q?o9KWMZsVp/CelyIKjVkZjTYZ2MvvfUzK+Nyyfgpjp8bxbyWpADfj3/lkfDrr?=
 =?us-ascii?Q?6l7+uD08c2s7JURSApnqkmAsVpbh/hLNxYpuwwWcnnxDLma3wqpHwMOmwc5b?=
 =?us-ascii?Q?uDO7HiHTLoT5+KGOKVHSpN1HkV5fQ8ZLS9m6oq8R5LfItRP36E4FkGTAcBIE?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05ded0d-cd2f-4c5d-a41c-08dce76f7750
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 08:01:53.8431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 58i1QcOrhDOe6ksAYyaCjNsBqoPgm1gnfv8WT0j+YpSlmXGzaR9pxBsd8EkUgve/bneidLMZvNZCEiPUz6YXFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9343

This adds a shared/bass API to set the BIG encryption state field inside
a Broadcast Receive State characteristic. Notifications are then sent to
inform all peers about the update.
---
 src/shared/bass.c | 24 ++++++++++++++++++++++++
 src/shared/bass.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 76287cfbc..9ee13bf4a 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1832,3 +1832,27 @@ bool bt_bass_check_bis(struct bt_bcast_src *bcast_src, uint8_t bis)
 
 	return false;
 }
+
+int bt_bass_set_enc(struct bt_bcast_src *bcast_src, uint8_t enc)
+{
+	struct iovec *iov;
+
+	if (!bcast_src)
+		return -EINVAL;
+
+	if (bcast_src->enc == enc)
+		return 0;
+
+	bcast_src->enc = enc;
+
+	iov = bass_parse_bcast_src(bcast_src);
+	if (!iov)
+		return -ENOMEM;
+
+	bt_bass_notify_all(bcast_src->attr, iov);
+
+	free(iov->iov_base);
+	free(iov);
+
+	return 0;
+}
diff --git a/src/shared/bass.h b/src/shared/bass.h
index b21256efd..d256b920d 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -133,3 +133,4 @@ int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state);
 int bt_bass_set_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis);
 int bt_bass_clear_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis);
 bool bt_bass_check_bis(struct bt_bcast_src *bcast_src, uint8_t bis);
+int bt_bass_set_enc(struct bt_bcast_src *bcast_src, uint8_t enc);
-- 
2.43.0

