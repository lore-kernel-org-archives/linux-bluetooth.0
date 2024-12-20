Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B0B215F49
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Dec 2024 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734705102; cv=fail; b=INUkcEyYDN/h8tOgeeLsF3klPImakxK1KiFcD3BeGJzCFDuEkEL/fWuoUg6FQXq87WPTPx6ef/CLI3J29dWkIi8ilj1mI9tRbST2REVOynWXhQSvXolp6Lt5X1TGO7ra0FT4AXE1LxwSXlJEfacJXhHq4+A/upUPZN825HS141Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734705102; c=relaxed/simple;
	bh=jviiYO+7+mBDMg2OIdVatzB8GTM6u+1b8RynIoKYt/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CMAUZapgastgrIa2wnrbINQd4BceU0IpYKu68F8nqDCcUJUrM9DZkLcXyBCGyA8aKPoEtyGeDeHGucocaBQ3PDdsnkfDMZhEU1wzZH0e33sCMN6HMZfad25Wrh65RhuhvryuDxvPmQGL60xkz+sehZWmsWPiZv70rQF3TfGW1Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rlex+Awp; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rlex+Awp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZPS5P9tZKu+AZWybsiXKRXIlgVKEl9epoTXb6yY/NKWFXMcUeHPqkfSII+9nAcNwty7H102NT/oF7mvoE+J5vds7knDDOOk3H4+XSZCUs5EAd8+7xO3i9onCtsjVvGTpqZ239tkpv+aMByp1Guo7sOtu+MYdnsv0CSeO190PuCSYgRVDfq1a7optPQCsSXRMZjrORXKc0Xu2HU1tNLKpT1hWchMCus1nu0Imf4Cu+eOYCyoa1M2xdRljO8eJZLoFifzlciW/XsOjZ9Lk7FClQJ+NH2eCTGb5a8eXMe/ZJqGKs5OLHyaNFBlNVDtT9hxwgeHfqwQg2OFoSqBaGnSGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KT72gMCcFezcJYQXftq8rqQZeHo/enn68bf9N19z/8M=;
 b=ZAZpLYJEsYhKqoWT4thQuyPSVWP+DSHHx+QpY89El59XsQ+SqQzuNlMbBRwO/RLOIb0Yy16KODSJPK6PJSa4t3M/cbNWCxJbr+fbWgewOWVPaRHNtsvGx6U2IPtiA+e7Zw/sCMpqsx7BlF3g99xjolhuihjNOIYbfaTJ+cdsG03s9QSdz3qbWG2ZyhbOdNpo3QEvRNQV28T2qMEhT4kn/z2ddOFRzRGfzKtHE0+WP8dYTscNZf9MtaImt3OMCYQBwq43ZgD3+T5O+pt/EErcjITe98Hqhmevyh8dSaZpfet/0GTRGHO0eM4mtddxKKXk6lVZp2uSYwzPVMmpfnIyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KT72gMCcFezcJYQXftq8rqQZeHo/enn68bf9N19z/8M=;
 b=Rlex+AwptaYcp8ldYPmFkYNIe6UWKTqeKdfjijI3xDG/HomaNPUmq7xcLEsP6JBUixNYkfTGcOxPcx5OTNLBQtZoipXjbBGJkgfsokE19Cm1+erMaErkYXKzOfAUafq1eAkfeb9nARjxbCRUoYLDCk68+NGLK6ONv5NEdkS4/n/MjLoeQOoEMFdoQEn2J1AXSFuSWv7PM2MNUUKS4We4dObWww4xl89WGW3FlbrN29YMIgIvPUUc++PRG1ws5V9VL5JUBJOhqZpmuRwYFNDOiHVzCvi+B/fDWkadgShcElwrOCaY8gXtIMbi4pd8SriYKSQEcOyCPPuZLS0jHqpjnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GV1PR04MB10105.eurprd04.prod.outlook.com (2603:10a6:150:1a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.15; Fri, 20 Dec
 2024 14:31:37 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 14:31:37 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 5/6] bass: Pass delegator reference to connect_cb
Date: Fri, 20 Dec 2024 16:31:05 +0200
Message-ID: <20241220143106.27443-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
References: <20241220143106.27443-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P193CA0007.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GV1PR04MB10105:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b700d2f-7650-4bef-84c5-08dd21030320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O/0K20ZqCcVWpQoSYyc734+Iwd7GBZpKIY5mbzLDeu+qCvdtS8siQTYiSxUl?=
 =?us-ascii?Q?DkYi40d2Oe46ritkPcl4VeBTaNn3R4RFibz2rkvwCifCH0RUi5J25/XJMAC/?=
 =?us-ascii?Q?84rDUpIRy9u6QQJ3ip+NBFM/Ynt73xvUwqZItTuMapF44WBAYLIdY86Y572K?=
 =?us-ascii?Q?LSwZTwx3OMuP8H5PcF2u4usZlTRUHhYiYAx9HHYBZjVfXJf3VK0EOli1yrrF?=
 =?us-ascii?Q?4sMzG1+dihL8ZGZmo3lfVSBrowthp5FnRFfN16la/z4m6ZuX/L/fFhkMZdbP?=
 =?us-ascii?Q?Qr4usnFUSb08SrVoGeg++Q3gzttGM9C6sHx8j+A3C5hNWmAApNXMpA3VD+wb?=
 =?us-ascii?Q?eHkDv627rPgDXtZ9rWlRsaO9Ud9hzvIwdhXYg375Qf/K9RVOXL+AIduCts1D?=
 =?us-ascii?Q?IUbD/2am70advlRiX0+ZBc6pr5eA8joL+hTsJ+9CCLR+o2y1xNZM5vm/P1K/?=
 =?us-ascii?Q?PV7iWL3yn94fEkidL2wpfiOgHpAkMPAAVehPVtVdBYdGyrlo0PEYRSkso5m3?=
 =?us-ascii?Q?RYwKbqm+sINfu5qMwk4WVEnQFFFiOI7NFGIJbPvca8IgkXabP+KhoOFSndZW?=
 =?us-ascii?Q?UC2TOCgdnH6b0+rFn2/KBek6hRABhuFD4kucpS2Y7sLVEeQZTwJ8fDdCv7sX?=
 =?us-ascii?Q?Odee3+F61YE3y3iuNH73ms3cuas/cQ6d5TNBZVY+FfM+gJaL135DmOpK0Lsd?=
 =?us-ascii?Q?mefg7E9l1CgLhj9PXe0Ve6PbQRksNPlxcmqzxECD8PSPYtna5JPe+wMeghw2?=
 =?us-ascii?Q?l+g2ahHKY7iFWT5kRUkydT4ecVleVRMPri19a5V0Hr34DKWQRBReTO+rJwxr?=
 =?us-ascii?Q?niaFQLMRxW9morivK5JUjbW2Nx8R7fgKn1SVoGh2i4K2f6DwmyK9fAS5LZwh?=
 =?us-ascii?Q?gKkinNFHFDFZBqqXIfY1nbtJ/gvAra0LPqkU5fOV/XxOdWIBao7udj2NSTCy?=
 =?us-ascii?Q?ye6GOhRblzsRnckFhYLKWZeeUJvYJRMBdld1NJ+LfpNVkGk49TEHiLcdfVth?=
 =?us-ascii?Q?93uDbgBhNVZgA5P5fNTVGCBkYEumyFAPoofEoVr3j0JoCZE8k+4yhGCoAWRc?=
 =?us-ascii?Q?xmqAKc6xIgvOeNpNijPAy+UfK047jzhZIe5duBUOYdo71dzeviibtSEcZm/Z?=
 =?us-ascii?Q?Wqi1F2P0kXaDLBdvvuwAOfoHAtbFiBOaC86v0Mx47N3u4S+7JrfPIdDQTgFy?=
 =?us-ascii?Q?dyw38hgIqjpfzIqjHZ9qHIwKuDN0D1F+Ix3WX8AjuPfUjCiLvpaUHUMYoB2+?=
 =?us-ascii?Q?jaujclEpW7XPCVVuqhmljbRuBYDlxB4oY7fqPjERld7fc4TVcdTK+LGeLFYb?=
 =?us-ascii?Q?O2RMHWH2GocO+DY/DHk+4Wd2ZdGPHP3WtZLG9xVYeSFNkxW/V6Ceq/y/qhCt?=
 =?us-ascii?Q?piVjiYLnUZaOpHYkuK8goaGxWCKV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rAelfXBNldWij3THZqtfZ9gReTCxrgTUOFXNFRosJRKC+UnBf1Vrgi1HyWUH?=
 =?us-ascii?Q?GMZqysS6q68DhGg5+/6A9gHTRL+1xLJLF/7Me5XN94DHE//V7sXZY8tTBi3c?=
 =?us-ascii?Q?jgpRaH/NnIoAoaz1KGf+Wy/1uwpCGn46VNzE4ULigNqg6QdUPkCU7I79SbKM?=
 =?us-ascii?Q?bYeMdZT8J65e6uLJRE8VnMHg9sO7akh+VbjErS8ezYL6dzaSLLXLcmbkIhCL?=
 =?us-ascii?Q?wZn5wUuHNXhIuQpp8drPm7UlwTt4srvkjRdVekv2HAYxxn6IrrfZ9sd3h9if?=
 =?us-ascii?Q?YigOCI5pkhBq8Qq8TthvF7itgT4jFvVkuaKRIogEErsTpUSy+cHAUr5haP03?=
 =?us-ascii?Q?9a7DpYLvMTtceTnMARxf6bNBtstSJ1c5mvV1oEe2zcr5mWWA5FalxrWcc3B9?=
 =?us-ascii?Q?F0shQg79BsKoAvxkOrm0v57JCAl1P04io5JPoVrPwO4h17ggegggsnR9zNg9?=
 =?us-ascii?Q?IFX/oTziNXy4TEUUtES/PwyE+Pr7zKdjYLni6pQLL8VY1KCnVtNYzXEKH/PT?=
 =?us-ascii?Q?5yiwkB6ms7+SAwmAatmZgDtMJjPH8DCDsRPueBnKqDoYyiL5D6yikSmJ/HKr?=
 =?us-ascii?Q?2317cW8bGzw00y7s0l2liY/wSYYUefqQ9koxxCOGi22+g5aqnW3N5Cp9FkSE?=
 =?us-ascii?Q?L6qvq8QxVLkCpxd/xGLICHrAQ5KssbcL0UL1kRlA4HYi0rVpK7KVSe9N05AS?=
 =?us-ascii?Q?GO/spUxK+wZgfa/NiEtWc/5PqXcwdM09boDRDqnBgXwg+dsl8Zi9yIkwcxBM?=
 =?us-ascii?Q?i9i5h0+I8WsgQ4b9awpzffBZZ/TSCFP2l38nRTE00I6KRENZ/6ITMFFBxxJ+?=
 =?us-ascii?Q?q7EZ3KKaHu5lIKkjHkaYhQ7Yb3dfLLVt1r5MnbmMHuGwzQnMGu8YRMcPV0hZ?=
 =?us-ascii?Q?HCdpUQFxOVdJgmvbTaPYBDu4oXLfo8vQxfrTyaqKBQYqO28ya0xQSDqcvgy0?=
 =?us-ascii?Q?lgWPpf0qbKZXd4Btf26kAyMoBB56qi5d7n/wXHAvW+OzhN9OOlhsih0l55Sq?=
 =?us-ascii?Q?0p3auUcQpCoPqaUJr+t1/clAcuzWxWabfz0+KJkG8RqBWYPNHOfuxcnsJhES?=
 =?us-ascii?Q?kVIF2eS5FbJUsKvYHUI+26cDX8iAhdWaFwNxp/LHFa23Dfs2cIZtzaS3rB6Z?=
 =?us-ascii?Q?3F/xxk7naEIci/MN1D7MORCxO8lZV8MLksAKko2wnJC+CASZxXXplPGNYYip?=
 =?us-ascii?Q?ZUHj1NXaUSjBTm1TADr4E28AnS86hCJgRPNEO9KO4psGAAXkSlFzpl0ODNG1?=
 =?us-ascii?Q?dQVKYhzXZZYDSGrkFZCbXUjOhl18bfEfs1nahrIch3FvKmxSGkrG2OYIZ3Gc?=
 =?us-ascii?Q?oHufemC5HeHtBoevXpGptCDhv2AV5hB6wTxQhIt6rtgugODkIVmUM1RB+W38?=
 =?us-ascii?Q?nmflKHHTRH+Q5JidVEMRTLYHM+84CkdJi2D/x7xdR8reUeSsvoSc/KWeeS+F?=
 =?us-ascii?Q?t8clsw5UWLwIP56cpUB9Sk9WFLj0ZUz/7b+UNfF3XDRoKtDQI96nT6CjhnPZ?=
 =?us-ascii?Q?+JzAJy2I9maZ3O8A95iXGccJGKqNyemwDbAw+Em3gU5hsMuvq6JY6ddQQink?=
 =?us-ascii?Q?46t5a25Kq9duQRD0YauVTjj6TYnrJZTSPqhATrK41wmAsCUh/1DDrb552/sQ?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b700d2f-7650-4bef-84c5-08dd21030320
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 14:31:37.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1yJcYP7SX3QWoW3KzMipy5+D6nPUl1PPWqaPxT1obcCNns0WdcaL/XEQtT2TwzUMeaTotIpn731VImt3VtNqqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10105

The connect_cb callback should receive more generic user_data instead
of the stream reference, since the event source is not removed after
connected fds are notified, and the same event might be generated
multiple times for the same io, expecting to connect different streams.
---
 profiles/audio/bass.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 2984d7697..0904748a2 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -288,14 +288,31 @@ static bool link_io_unset(const void *data, const void *match_data)
 	return !bt_bap_stream_get_io(link);
 }
 
+static bool setup_find_enabling(const void *data, const void *match_data)
+{
+	const struct bass_setup *setup = data;
+
+	return (bt_bap_stream_get_state(setup->stream) ==
+				BT_BAP_STREAM_STATE_ENABLING);
+}
+
 static void connect_cb(GIOChannel *io, GError *err, void *user_data)
 {
-	struct bt_bap_stream *stream = user_data;
-	struct queue *links = bt_bap_stream_io_get_links(stream);
+	struct bass_delegator *dg = user_data;
+	struct bass_setup *setup;
+	struct bt_bap_stream *stream;
+	struct queue *links;
 	int fd;
 
 	DBG("");
 
+	setup = queue_find(dg->setups, setup_find_enabling, NULL);
+	if (!setup || !setup->stream)
+		return;
+
+	stream = setup->stream;
+	links = bt_bap_stream_io_get_links(stream);
+
 	/* Set fds for the stream and all its links. */
 	if (bt_bap_stream_get_io(stream))
 		stream = queue_find(links, link_io_unset, NULL);
@@ -352,7 +369,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		}
 
 		if (!bt_io_bcast_accept(dg->io,
-				connect_cb, stream, NULL, &gerr,
+				connect_cb, dg, NULL, &gerr,
 				BT_IO_OPT_ISO_BC_NUM_BIS,
 				iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
 				iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
-- 
2.43.0

