Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D235548F6
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 16:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779946; cv=fail; b=WkvZQe0wXosOfnZv2Mt1iQ4O0uq65qNa95w2Xwp6DgZ5kJPvPbV/wyX5JHwk9ba/PqIjhVtZqmL1RhLOi5F/pSAW37SQ7vEe194SJDYvry3GLJ/nV8ewnPNTHecT7QN1WkXirp3rVMlV7gsCZqdiBOgqc6s0P0JxOkKWPL1aqvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779946; c=relaxed/simple;
	bh=0dRFxR0jNHmTqolxKejhwi7qMMg123Zb7P9CbwTAVrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZtdaFn5bRd4sebMEPrTrQU2YuUA2kfZNwQgNcnQiUvOzo7L6WyRhqE5hdSpDDvBUV9QVQwcGiAFMKmlMZtaP2lNhisf+taOK++nGIx55H4t8cSjsfTT+e4bznHWOsufZn3ixyoWFOXoNQEEsxjYdPKTcamR4thhM9czCyeY0LvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fq+Lp/mG; arc=fail smtp.client-ip=40.107.21.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fq+Lp/mG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9x1SuF0wMY3P9ZEwEicprDCYG3mxAiFTjqT3uwfP5vu+fluRHHySV3F/fWwvHr/Gy+Yxd8BdOteJuA7aTdISLB3R6/riol0AsKNBNrDdWNagbzoJsS9eJlCIjMOKg7Lf5kKhEtKJOGnTBzrU39R5tI3UNInbNYEMnNPcyRG+Lgl81uOIBUV7U46IoCouaEc6ayt9WwKNl+KwFE6+Squ6wEecLntdh1PWLp5HYr8I631Y83ul+80wEo/pDddXDcmlObk1zQsEGQMMtXbzwbrZ+D6MvIDLGxHQd+I3HvWv4l+xpXpMlEGGyf0IJaB4sxcqBBaXHpFPhiEkvB0vk6yOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UYUph4A2tuOEUiY5ABfQI102bIvYPhwc10RJ5GtO5Q=;
 b=cTgzePIM4bYn/teV48bgrFNiKqBPrakjKSBXfEPQMSi1kFjJDD3HYF7NNZIIz8Mj3J9YlL75p+Hj1leZtmDwNGsKDIqUkx5spCTaBqUzNdS29WhM9iikZlTDK2S96+5b3x77Ae0Tk4yfXugGiN0NkKATiamCxi1puo6WBGqPFI9HjC3R8KQbHP3p9jzNqlJWpS+wsLPYxoRM6uaFdEQ8I/u4qI0FSCUSvCNaryOk4eQc7nj3VXtfaHiGh7jQr65hwlHSJsACt2YyQku6c4OkO0692SjdlCekODpseblSejHY0kyxnxAet1X1I8IIh1yFVSnapTgs/FU8lGo4A310mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UYUph4A2tuOEUiY5ABfQI102bIvYPhwc10RJ5GtO5Q=;
 b=fq+Lp/mGb0OB/YUVK2YyNKljsWrumYblcmQ39Rp3bUZJCioo0I0SWUoJGNda9w5Xk5Aym9JJ9isF6XKpYVe0Udri7puVN+XErrDnjsbbGtrUNZVIvOKi7ekae3DX52vyzeLmsQIJlSDF86eZRdFt4gyFuD4gPbuo6bX11A1oJ84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:39:01 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:39:01 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 2/5] transport: Add support to update the transport config
Date: Mon, 18 Mar 2024 18:38:50 +0200
Message-Id: <20240318163853.68598-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318163853.68598-1-silviu.barbulescu@nxp.com>
References: <20240318163853.68598-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0034.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::12) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DU2PR04MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: f17918ce-7a4f-4df6-9163-08dc4769ea8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0L96pppBge0i77BqLXcxgrrwfsKEAwK8+eINftWMs4b0BA9PHGeO8H9TG0M39/8CJY2jEHhenqXP9wb/FZLkhf6bqZ4Y34ryCB+stli/ltA6T8kvptKK0mTPnhopJf8Bp3L5GgJRUJJTgR9AwVy26AfAu4t+jwSFjR2afXjtszzXUW5EOvqoMoWhYtmIg1PhBSVgeju1kiiuY+h/wmxWNvGggfOTtoVeadBLmL+N3wR7syYggVfSNcUJSbJ9MF6lZRpO7gV3NlMC8eOsrMcMff7sNVR8cA86vPqdjniXnRZW7AVkiTdONTEYGNBVaVrHV12Na31f7rt7aoZ7EtDnGThckBs+fBZQ1t8gj+j27Fi7ej4aiHxtfu062C+jbojJfY+yT0TECNslPxdmJBRdLsVj0uFGEsNdHaEkHEC7mF3gtKkx/BtHWJzFu1qLMZdyukbp/LontqKRkkBItMP4ZP1+Bbi5jtdwWgRU3Zmwl/Ue3+j12Su1RjUi2pT8Eb8cU0gfv8+o3UL9HCRpslUODiJ16oHKR2cokNwfedh/cFgNl3Nf/cdT7+mxbMVMXE2HeN9nSrJQv08xTclhHPPATsLDJiDKLA/DfhC6mDDbm42g43mAChTkAW/FQAEUW/lIvm7ZnEtZUAdzBKI8l8hgpyZXAA9JYW+hVjTaF/eAU5I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wxiEHMwX3h50Jw7LUaIquv7wmKbzTHTyF77ET+H4RNdYUHJoLnj1AYBSUTlu?=
 =?us-ascii?Q?jSMSaq3voH/NYzGqxZgVq2gswQhTDJeCEbsCrg4IliU2tq7ZHVEaLqi8UxOd?=
 =?us-ascii?Q?GoVjUOMI8KfCIagmGESHJVmy1TFGdrkPL8nHhXLAKscUip2z+RNZQCSoqD5+?=
 =?us-ascii?Q?vqbtY3Xxd5pHFVNEd/kkJ6WGHVgQby/nmfzk/+n+pL71tifoZjEKKwHKipdR?=
 =?us-ascii?Q?MII4u0okvvcbBjECP6hH6F8U87FPPHLIOapE6MviBjWYa1dbrXHyPaGMg3Yd?=
 =?us-ascii?Q?bJ0/txF8zxW49FNlnl4qBfPTICVxa821ljBymGIxBhvIMuFpuorRPTWWXoFf?=
 =?us-ascii?Q?hO5rGDg88ly6bST5jvCfU8BodAXo9V2CTMYVVbbguUJDXeUpckZslF2PyStk?=
 =?us-ascii?Q?jtt2bmhhk6qIqfXFCQWeQzbF4X3vN92l4HfjWT/Jj7ZAJm9qTTRCCp3wdtyY?=
 =?us-ascii?Q?lh8PK4GeMTtbocJuQ/3RfSw7UI4a+rlVrolkfzGPJKG65elTh73oY3SO68eF?=
 =?us-ascii?Q?PQoG+gehe0b7iDXCIJ9N08DWV2L3pXgm2F0/IK8loJ6SxQ8IUwb8GjhDpPgr?=
 =?us-ascii?Q?yXmvkAvj17+lCArrica0S5ir3V2+88o/219R2MDdZJbUKnXUmhOgXa2oU1rh?=
 =?us-ascii?Q?TSsrnOL+rnQRMFGClha8F2se5e6wQnot3KkNNeuN2/9vkQJS9vBvjKlP9zp6?=
 =?us-ascii?Q?UVrLcqfcpWrq0cWckPwLwOD8CMUK6sPbi+koqipKPvsRSbWYOTAoTztv9RYl?=
 =?us-ascii?Q?MHOqkOYVpUSPe46scZQ32fQqSmLzzI6By6NoaEMCXINAf8eU/f9M38ZB5r0f?=
 =?us-ascii?Q?8scDH7Bbn6xW3EPKlYFCwBIxfby8C+rr3RRNxvQW7ChSM7s/k6BikVi7hIVL?=
 =?us-ascii?Q?pd7XtBUpGeFFVctbChd88ykba9qhAJHu2S4nxcY7TspiGneqiDIAidh68H5P?=
 =?us-ascii?Q?UnBuSHqQS2ZEXjrSa6FzUSYB+bxM01I88SwTxDZsuldlxeN7BHUVk1tNOV2J?=
 =?us-ascii?Q?pszIOEhf4CugS0UFh3HxogoLxrzCaUXU9ZYQNZDqN5dEhjpEMhCWQs2QAW7k?=
 =?us-ascii?Q?6TNJDtn0L3qCWMNoeLAC0i9q0c7+TgztI5jPRLm/VfKyTzECN07VKUeJwhsT?=
 =?us-ascii?Q?+Sl0xImqIkXkdJ0Lqw47o4zUM0dL+McbG6+9e82Lo1gwMKNNDHs6WZ6avulx?=
 =?us-ascii?Q?UetUZb0+1YWYL39kOymmAxSbtfwCo+VRgWTKJz9Ox253KPaGYqS0ezsHbhjG?=
 =?us-ascii?Q?1dn8dcmvQR5gMgftx95zPdreUIRqJ08gET/SJhG1eTiePGMqNsc0EPuSQiTC?=
 =?us-ascii?Q?B5oC7CQZIAIbblSkQFYCtF6fwJ9JQx8msL7jP0/mz+iL5NKPTUSmCHBwqwOq?=
 =?us-ascii?Q?uVsXZ8hSQwBrzS29y1TVuWJNIJ98Fd2AceEEoeluuCR+J3wzCB6YHtqWFp0+?=
 =?us-ascii?Q?RA8lj6YHeT//vrMxwyuJRpwezOqICWEIpCFRJYJgIvyWfjxwaCRiD/8gnwnO?=
 =?us-ascii?Q?6d6sTo6uhkGb/vnurRT4cj9hRPxlfRejNXf0uzyBOEnCZdzKNVW/Vv6ZZzwg?=
 =?us-ascii?Q?saeBndqvmjWiM++pvmLmoOYWzFfHwYoGqKFwe+6r++C0q0H4AeKCzKCLCRuI?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17918ce-7a4f-4df6-9163-08dc4769ea8d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:39:01.3334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbN7mpkSUE9N/1EDZmQra9eSjsdSthnCvOFwQV4y0xzMnKqsR4D+xsClDnm2hcW8aKrVm9V0P27dBHkgS0Tbw5/hEt3W2TNHLYNit/4eVIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132

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

