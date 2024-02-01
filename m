Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2050.outbound.protection.outlook.com [40.107.13.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DE415B965
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801345; cv=fail; b=pVqLFFYM2E+WqHRP406/+kPdoDykmGJOs/uVB4lvzyD8cZMyDJhaC+bU3+X6RnoZO4A6KYINlcBNAs5FUFywNBmlEWxjqsqWJ6CXZ6VYGl1E0sRzwBNbWovq/9DVtRjItUVt8SWFyM5gnWvHnRtOumRzSVEebh32YlLw5lwcbcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801345; c=relaxed/simple;
	bh=8PsmsPJ4gTL6dU/NrWvwLX/m42Fq76BlmWs6FA5xpYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6oKvHjDfXhL3tlLE0r2Fs8n5cOSyvk7w+ZfgZGrj7An5cbb6FHviBo3Zt7N3yg81i+YT7PWAPtkSvVnlJw/IruZ/mqdqXaSoX/GlgvzvDZtbaZ+cl5CN0hXIOE8W+O6j5D6yJCf9uvv5S0L4jhi2vrg00akjSC59W8OyVCeEWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=T//PEW6g; arc=fail smtp.client-ip=40.107.13.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T//PEW6g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCp2h8gRYkFSSuiQpkAUbJXSTpta0Mzw4L9vgOwDLWHb/ixceRWT18S6B/ZyqaRXoQxCRWBu3zWDnpf1R5+lrDXAWmdeIh5nHom3HVhe/AH5te0OPpnG/lGPpYgYWpcbalzJnr639V4Dcvh0l/18KUBXQ9M6Vyq+WZiBOa5L0fzthP+/7W1rC0P/3ENMUyn+rq0N8Qc2TsH634dWatxVA4l1E5P53RImSmLk07c4j6z5ErAYbpuPz51nbN1cpJXIyssLuto8bpEgKBf6OxAjV4fB7SgY+0ioSoydb6jbyt+2A1VqzXp+1znvgVuPgpWIrPa9Ue7S/v05AkU4cDhUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=duMycqCLYwgFlSxhvzMw8kjbNbFvFlH/u39cFn6v/+g=;
 b=Ujt7TFUNac2XM5Aj8mb3lb57SWg8p/lxvKemtCamrSxUy6epnOyiDzAWlyjqWgYUGKrH7nbvop1n5cZQ3y9quKQVSeXFBfNgeTwDYpnq/X1VNCoZFyi8R8BiEl50tN8DI9hf08anhgIfAkMD8soOFjEQBZUJ/VLIVpIT8X88b0eAvFNzLVhO6fC5GHWL3n0xyVhJLnwQ9fGX8bsxGOMSk0O1tKH8w1TCSpChfnY4TjTVDBZZc42LiGSKIg2/BkSe4mcN/cFOm/Lv9TyIB4/a/VYwk2elwHT0GqM6Whhx68kAnZPWpjBw/0lYxgeph+HD6W8XmmcNPA0MUCaXazbBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duMycqCLYwgFlSxhvzMw8kjbNbFvFlH/u39cFn6v/+g=;
 b=T//PEW6grZ083N32CuIVSR6iReOYx5TOTuppgNsuz4B3XIypPSrNIFD0bhzxnjn5Ayl8HyJDdsXVayJUwft6+g3rXj34/9mgom/m4HXOzPBCPBDZXEWfrB6uPkuDbb4sFnPKAPQv7bdgmDkd4mUHYSXlutlp89B+OXryKFw9aS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DU2PR04MB8997.eurprd04.prod.outlook.com (2603:10a6:10:2e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 15:28:57 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 15:28:57 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 7/7] shared/bap: Generate single BIS BASE for a configuration with BIG ID 0xFF
Date: Thu,  1 Feb 2024 17:28:35 +0200
Message-Id: <20240201152835.196617-8-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
References: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::12) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DU2PR04MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b93111-416e-409b-4a05-08dc233a8206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	h68XttE7rnDLSELN40gyP/FE20dbpweajwz7q2EJsxkPBzRLcPpQh0/olqCzszzeEn2GNYAzGu/950GXHkh/ZMRreOBFXgnmLcIEk/XJO/qw9uijMVf4AHyPts86UmoEGIDrvWemW3YuDrNgeq7Fly5sn9/WF8F/av5kT5g2N2c8LhvsDFL8ucwVAr7l1FF1I8rW5rpKkh60jrBfTWFwdxbLK7dPnAL1H412S6J+SCXkfyF9RdvC2NgE+fJrlDTgdYig4AlDuLvC1xghzaGc3vsPfCeFskAtW9qKtyturcvQ/fMJe+0uDv2VI3VnopExvGOjssK0duGJyUGzzOAVeA2haLnnbT+ycEgTfdk53MzPRS6ZRPDqCwoz0V1D4xn4OAR2TDfdm8zQSWrnXzPO/tpC0DdEaqTLwG1OsNYKjMexfglcefNY88ds9vIoyJ8MnSilT4xQR8wcMadzZa41GA4Hxs8ynAIJ1YxOl4QLR5aV+Hqnb/iUyqBO0JT/q6uRNjYKi3flxX854/ZXjUJSfjdTwhZZGse0tBOtAwdtvfwfh/L0NAp8hnWxw92ggme2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(83380400001)(6512007)(1076003)(38100700002)(26005)(2616005)(8936002)(4326008)(8676002)(55236004)(478600001)(6486002)(6506007)(2906002)(6666004)(5660300002)(66946007)(6916009)(66556008)(316002)(66476007)(41300700001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q+kJq7DgEFQW+B2/fUMCzGoRnqFrOJgxGRqjlpVkTHk+pHPbVakrqlGpLY+T?=
 =?us-ascii?Q?8CI2sVCnGHsxmRlqOyPNsZ29/B5S1KIl+TIWizMUnn1ivYunlHWqro93ScEQ?=
 =?us-ascii?Q?d5VaPeaEpCdor01+XRTGHxS2RrGHdZyVUhOKulknHKjBvX6m5MFQQXF+d6v4?=
 =?us-ascii?Q?5f1KQ7A/uPu3OfboDazkHeVhW/0Yu82+VjNbkDKc7dJ5bgdZSBQD0olCZD7w?=
 =?us-ascii?Q?AubEXposC9EpyeU0nQzd+nclwAAH2cRm7Ynl5d7b7zJ0ftBft8lyR3kRQN5D?=
 =?us-ascii?Q?yh19oz69r9Z1S99KoN0Sztkb0MnSrnSQZ8pstr4SN1rmZ4+HxBrOcQw/4PEy?=
 =?us-ascii?Q?Tcyw/ULAaSu99LdfuoGcLIRJfA4k0Z3S0eIvBQDfc/Rz8i3u/CQOFqG+j9Zo?=
 =?us-ascii?Q?KKif1VDUuVHR3N729LpKoio3c2H4I9IvEpWdCSR3DfPVaCwjegH2vKmqcCd2?=
 =?us-ascii?Q?ADh/9y4MUmws3WWKcfbNyA9lhApZxJ2jEyS/8QxIaaFRWbSP+L2/YuqytTaB?=
 =?us-ascii?Q?/n4rEilZdoXE7/jeppic9ycdDyCu4jrUgVFnMNTouQ8/MtJd+z9KjudfWYR9?=
 =?us-ascii?Q?zd78mfI9Nj+J0hhvrWDkn/q85l4O98npeF8haBPEoe9oruDFjxmK07ZglB3B?=
 =?us-ascii?Q?qXv7aU0qOEPC5cvULeXYaY3RsoQ1rnGFkxlZZA4C3uC4HbmzQHc3XWyZqgEf?=
 =?us-ascii?Q?soCFUi/Qlg9mSq/eOph1Kh2fqC4ZwnsqI1+4m5RNfslJilpZIRYF/4GZ6WIS?=
 =?us-ascii?Q?dDI5ms28claMXlut9nHMZ/MQbGCx3D3ZAZzzAjpjsLkFVcVVeK5cWdTTnjhf?=
 =?us-ascii?Q?TgiVSzBuEpbPGXs+tvv8PApsO9jwYRaUltHxjbLvPmsAtvafzRrDgBYlGyLy?=
 =?us-ascii?Q?u5ObnlXwPq7iyKbv5NFLIhKcs4tS6AzfdrM29D6h5tUxHm4chmVBdRaA+LRO?=
 =?us-ascii?Q?hGfq8tgSPxPVnLvs5/54asCxHoQeOSD0eAnLEULnndXob49BloOA2+hfSjqb?=
 =?us-ascii?Q?PoWsk4KPA/LM6ZbIeB51wKilGLQgnryGhVyDukbp6s2As2IYsOgghAWK7tdc?=
 =?us-ascii?Q?35j8pRUT3fZivXwiWZ2VWoARXmQVb3EPbu/Q/00Wr7motfLhEUp2UUmSQg2s?=
 =?us-ascii?Q?Uj/JgUuuqrzeHcfZBOOtXSedb/ysDAZOEpArGNpGjh1od7liDIUOdBF/nG8y?=
 =?us-ascii?Q?eZ2EWbn8D33M7vNkh8cH/mCAgjpnTSxszXa9z0KEh9vURFwTl7r5SM1bGGwN?=
 =?us-ascii?Q?MaegsQGvKo0pyi5jA2ne28HAFje9V/0qXYdMc1bXrBGWMwVk85vgxwT+kGde?=
 =?us-ascii?Q?T3cWysUmBtTEyTmz1L5T7bTW5cstU+GC/42/RPQjNgZ6XBl6i42AT3gmW78/?=
 =?us-ascii?Q?nNh2Mjlx0yp2Y+mWnBA9suZ/oXRuIirQ4cKAkyP2YY6CO+FLN/u+9alxQMt4?=
 =?us-ascii?Q?paH0WNVy0wzaLDg9bI/rZoGTjez2WZyYLC8ibM7wbo0leTSu91jCWUteOe2C?=
 =?us-ascii?Q?FVWPDjRVPjwY83t57zOe4btCJec7ZhqZ5yLT5UHPkmtcxOG/VwzoHjLYIt+4?=
 =?us-ascii?Q?Yic+5EeiYlLk3qbMTGQ0hbw1AjphkSDJa/uCFBVfcZApKo74n4gixeq9W7oI?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b93111-416e-409b-4a05-08dc233a8206
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:28:57.7302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOyVzC6mvQVarOaxWEK5SrtxGlXqK8obxM5BTj3rOb/GRdL6wJ3VfqN2YcU3Tphrj/bliq4PZmrmvv0dT7fBAVwdGkdHDu36TJkrXECeL9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8997

If the BIG ID was explicitly set, create a BASE with information
from all streams belonging to this BIG. Otherwise, create a BASE
with only this BIS.

---
 src/shared/bap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 244bd8c4e..c144d4b3b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5872,11 +5872,16 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 	base.next_bis_index = 1;
 	base.big_id = stream->qos.bcast.big;
 
-	/*
-	 * Create subgroups with each different Metadata and Codec
-	 * Specific Configuration from all streams having the same BIG ID.
+	/* If the BIG ID was explicitly set, create a BASE with information
+	 * from all streams belonging to this BIG. Otherwise, create a BASE
+	 * with only this BIS.
 	 */
-	queue_foreach(stream->bap->streams, set_base_subgroup, &base);
+	if (stream->qos.bcast.big != 0xFF)
+		queue_foreach(stream->bap->streams, set_base_subgroup, &base);
+	else {
+		base.pres_delay = stream->qos.bcast.delay;
+		set_base_subgroup(stream, &base);
+	}
 
 	base_iov = generate_base(&base);
 
-- 
2.39.2

