Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2056.outbound.protection.outlook.com [40.107.6.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2337146D6B
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 May 2024 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715864658; cv=fail; b=K+eQRZMnE8r7KTfZIcCwbkCPxmLt0/L/Mc7CJKvo/BzsJn9uslX/Hm7hsEGvFDOwH5nYPq5k+G/h9Y3DMatXmXim2eB9+5TeSlqnwSsPePmYkCCCOHO9U7EbON8uP9sCqSG1d09qy02BaMZGUmOarJqU0sqXDdVbyIckbS11o5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715864658; c=relaxed/simple;
	bh=GJsWe5zYbNZgn2eD9C2EleJpaDA4zdi3UFO0/dXaD4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S0DSdAxk4BmT7fk6G2CYUr04jHQuvyfS/p7KsEx+cbmDW46u29HtR+EoiNtiHljTkBz+DB5qESjqd+AL3F0nPgG/cmHELIYdlLVNCI3BBTY/eDrwXovxqZggwQ/FZyIBGQ2JrlqVXK25oMfMGbmses+etDO8H4lBuJdm8aeAG3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XRChifyX; arc=fail smtp.client-ip=40.107.6.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XRChifyX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+o1NI2jnfDkl8D1jdvlzS+L0JAoTEwNaXQgl/0ksCJ+Q+Vn9qnlYMhk3YEPUrkxjr0pcsgfjIjNhO4JiX14C9JTMUMvNmT3pOtYrRTmTSTGnXNwmyNP0AxEj1KDgR+01uhUmpGTLzYqgNcAnZgJDJy4SI3gDm2pDgqMirTem5DKtf6Da7Ki9e6vK++q/PJ9pnPkAn1J2R8dcfcw1Yog4kG7ZtVu2sON/2MzTOqgiP8LF2FdPur7EQLdZvA70bwWC8kAftWv/S46wuIsTBufgPo7tzwARyPLYSclTg5zG5CgtGswZ9eqwIYyJK31O7Nl/9Cz7y4fw2aXqL89QXI8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghzBLmSUYKsUmy3Y71Vnn49p/9OtkBaeHIiD0bisQlE=;
 b=ExnNxjm1o+v5cgg4Y2eibWOe5V2iorP7tugsRF9PGYLdH4a3phKoAehjrF+S+Sc7O0UG0TqeLVCpSoXmv2H0sjJ9iiF4Off6ey3dEP7ob/8LAUqoyNGKjwsMfsW7pJ6FUXD6w2dRh6vUq/zhiDydQBJlTBfHO7GxIMfnR+93p9B+AOj0Bp26Iaem8EeBA4j0X3YM9JA+ul7v7npsUOguQs59ItPc60RjN88bpA9SpFLYautcnePpZbDn3GJKGewOcTIKTSQZntTHxzOT8ZrtP9GK7jjun8+NARsUDnWLqSjw8evXizMnztZHglduN6gGxfFKGL8SPnn6raMT/MxFwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghzBLmSUYKsUmy3Y71Vnn49p/9OtkBaeHIiD0bisQlE=;
 b=XRChifyXoUPmQu4mopCT65J/BNjluSAJHKXP3X0Lgiaq3mxGwOiOU0v0mUrpx/Ia8bKBkGtXAs4SX4JQTsw+DFlYlXULbTE2C33xhp2xKdB2zLS9+00GBRr/mBAbAm/SrwIR3Z12KyzJcAupZg++IFGbeWEG+uR8S7vxfBCLmCo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DB9PR04MB9332.eurprd04.prod.outlook.com (2603:10a6:10:36c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Thu, 16 May
 2024 13:04:12 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 13:04:12 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 6/6] shared/bap: Add stream ops for get_location, get_dir and get_state
Date: Thu, 16 May 2024 16:04:00 +0300
Message-Id: <20240516130400.16713-7-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
References: <20240516130400.16713-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:208:122::20) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DB9PR04MB9332:EE_
X-MS-Office365-Filtering-Correlation-Id: 317eb268-d049-494f-103d-08dc75a8aec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xNqpDnpIAUE0u+AoYjwac1nAUtLU+qrsTbGGWCgCt/GoaDV+NTbcJRxa+TmC?=
 =?us-ascii?Q?31BcSXSCk4m6oZCGCaJWhm7YFCuWxgmsR9q2pqI4Lc57ht6JaVHtalGbjZoj?=
 =?us-ascii?Q?4j9lf876+43V42bvZd5UtBjrRzxk5yWh+iuYqaZ8RP1tw0DgEAm9r075wjhJ?=
 =?us-ascii?Q?s2Wvpz8hc1hqQiDl1/41s7DKA9Gi3AB7Iv36IV8K/YiRImZf7r/olnCR0Rdt?=
 =?us-ascii?Q?/40rKvIB86ffA4C2mOYrdSoFLDBdF2jrvy0CBNNRI9yp0o42YzSQIrJsyjHF?=
 =?us-ascii?Q?SYL2JVs6sHE6Nvei4JOnV9dGWawQAJ0+XwWYSTlwwiktIhWaR5ljwEBMeU2N?=
 =?us-ascii?Q?i8R4vGddtwRUos8H5qBrV7ETGEqwYVaKlwSbHmlI2OthloQEAn5UO0gPD0sP?=
 =?us-ascii?Q?ZINvo+w7pOK46C5oPNlQRqlYBhjRywNOO3XUGXrw14KG/Q9W3Q8269MZRI91?=
 =?us-ascii?Q?mdygoYYiz1wg7tXVlnL/ozKgxSvg80P1Hr1AAtVgwYUhPJdUdUdtp4O5lR25?=
 =?us-ascii?Q?D5NSg5h7xmQslzuxchGq1otmfmmqIHtjUHK1I/DC8mQ9fQtsqjRmnEz3vnnH?=
 =?us-ascii?Q?6Sax6PTMrxH7iwRvOLdsxI27vH5oa9zs3k63ifwgpioGkg1hsaoI2QGpktL+?=
 =?us-ascii?Q?uh/39aBRJ0kF2LKa9nvQ3W3wYwT+2zIn83U5zAhKxvAVYxUagGoKcmAyRbA1?=
 =?us-ascii?Q?qvRgg1/JKiI78InC7fDaTXczTnpOZWVxSmWahYrjEb1IGr8ltqgF/KHuPUPS?=
 =?us-ascii?Q?CZnzBI/TFaFQHEU+P9gOiXlVyy4jQcr9HLCpLwS/ZaOsOoUUqN/J1V8PPh98?=
 =?us-ascii?Q?AqIprxtFCuTc5aCMEs7BkM8E2323pFTj8Xx+3kledMsytDIUOpLmgCSgitGT?=
 =?us-ascii?Q?tE9d0Yf7y96kB7NtHIZuzGNITeu/SgN9oOralxSQgBNGQ/NYiask+kChfoRz?=
 =?us-ascii?Q?YUkQBpKTFAu60BCGEfZ/Dw8P2E8usCCQHxHzelDek9cQe8iQR4tJ6MXgjod2?=
 =?us-ascii?Q?C3OlCk14ReM7VIqtqh7iLC62QPx6jGaHm4ue/6IqRcG7gsxAQNi+PIbMc7LG?=
 =?us-ascii?Q?JmMfk7f15UN3869pDW8MQWPEhKJqGw3FuBBFvhSiPqiaH5puhKQBM/jnghwc?=
 =?us-ascii?Q?ujm3+H27ghCxB/vmUOXriwo9iJceMhJ8qjaEG++6M8kbb6mXkSwPtJuxO14G?=
 =?us-ascii?Q?w2WJ4bVRGHeB/Zmipqpm+Z2ULf20olP8VISvkml0QA140Vhqi2SxnUWQvzrz?=
 =?us-ascii?Q?9SLt3Zd6+Z3RQfsA1OqMfnRyOUH0MjsY5kdfRzDhXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LhOimFqxdUfyEtwbHNCmiV7lp00T7gajOLPqYbtb+Ix52NjuZY5zbr819xt4?=
 =?us-ascii?Q?6PbsYtbeft/l81gEz+KEs8rkjW+TD0mrBhseHoea9zg/lLnYxGCBzdbbCLnH?=
 =?us-ascii?Q?2mCFSjO8izGvV1sBY02Y7yWpmKHTS+1Xqi8wpAWI+IRqQK+7kNb15fR2iPLZ?=
 =?us-ascii?Q?DSHCTZBND6J0TrxpZ4JhKCQCrH672MEFlGeDGRRzK4djWiBpa0zTyUEgmb3c?=
 =?us-ascii?Q?CNLKOJ6JX+Y1/DGGhlkqhQ1HFFiLE4s8AX/7IirDlPUhU7G/AHIvQBEWBFBR?=
 =?us-ascii?Q?Rt/N1I8rg7UVyZPzoA+XkfSGbhXNZGoGvHNwSZ1PWUnfDDrTcX+u0IlHenoo?=
 =?us-ascii?Q?W+4pd8PElX34uQpQy5lVVjhdIoefNht3fPc3xvnHliRcI6+xvot9J6Oo0B8c?=
 =?us-ascii?Q?6HXfbvIHC8FJPJaR5y00gtGAhC1orZ8zZSogi1Je8QnzULCOoDE9dxbjZM7h?=
 =?us-ascii?Q?baLJkPn4cT9NIBLqQACaqxM3uz1O/MBdNHykNjqtfDWRoHBoZUYc7+Jo71wM?=
 =?us-ascii?Q?lukEsI0izjk+9SMRC88WWodyyvYavxUNPL1cpWFcG97VEhmzrGW6Fp8cY4CJ?=
 =?us-ascii?Q?8//pVq9Wob+4W3PToJbJo/AqYmLI5ZwHCpUPrBwuvfUrPHw8CmajphqsF56p?=
 =?us-ascii?Q?oT0tae8g/Qv5xBxhGDVY1LzzbGL4Boot9FueKUpcAmaSvr2AA45g1nPAxv9d?=
 =?us-ascii?Q?MF2nVOEIXMk9EWTsXitvL7J95+Sp/yQQg7WwZmw8eQjZZAJELBvFIff89ZOs?=
 =?us-ascii?Q?HK667VDlaS7tUwjTmwgUbVnHtmvH0M6Re/vk7ur4ASFxXG8cz58KbOZ/SlMN?=
 =?us-ascii?Q?w9lkHFCrjr9DXds5jcb2VmWL9WdqLTEU/rGx4MxDECimZadc1r1aVsofxMsQ?=
 =?us-ascii?Q?lnkeF3vxIl552iOF7NJyTdafFfS44oFk4AO+TuvAPyk0ymKvY66uk9Fzck9x?=
 =?us-ascii?Q?in80JTYAAQS415u3PNpvLLTFSfz4nifJVWBKrlobODHKgzMnNjK6SjfbSxN2?=
 =?us-ascii?Q?sVnIIDk6Mmu+4Tp2wQ2MExcuceHZYnTmFff3Ggb6PVucQ2pCG17E/X6g5sxV?=
 =?us-ascii?Q?cD2jqn03RmnnAsDn8VVoMXEsoidtJjlfnQbliWqiIqgNzH7ZcrYp4iT22y7g?=
 =?us-ascii?Q?iz00mKRqE/BEyIVpp3+RJSyCPr/UHVsJUf+hGOUBD6X93opsdm3yvDoStrVd?=
 =?us-ascii?Q?+EZc/kNTMPUEFr6aoGFwVbfIlQR/6qdpTHrDr2UC7WNyXlP45HQVBcF1+uXy?=
 =?us-ascii?Q?pnnrLM8jLzkkwSPzdN7d2r7LXp4V/yutiU0t8rces6xKDwnEaeO9s68VJKOo?=
 =?us-ascii?Q?gPKRoPtsncJFlToMrzPRAPenaBuo//p+x3RQWhwslIQAnbdMWq2u5M65pzR4?=
 =?us-ascii?Q?RmwPy36eKIvTAzZoG5gknVoXrdjztQ1Jvq4zsuzrh5AkD7vB5GFgPQukZf+a?=
 =?us-ascii?Q?xEkSVTcOuDznnvo8/E97wUZGJ8hv8Ugs0eebxzGl0U/+q1ueYoXE9ktPH3dI?=
 =?us-ascii?Q?JnNk5a4xXqfPTyzzbvfZFrms1YxvzyiA0pnJUIBls+s4Ijn1wSmBXn+wzSrO?=
 =?us-ascii?Q?6S5FcGT5eUoil2/pEU1KZu5u1JqJE1bx/WDfCakq+bcxE7ZQg4WZ6NQ1b43T?=
 =?us-ascii?Q?tA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317eb268-d049-494f-103d-08dc75a8aec7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 13:04:12.7979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dUzrSyqVr8ciO8gANuWrg5YiMeLN672fx5Q3bZ4f4cCBbTqtzUwcUVtHXs0YcPj2s9PTB388Dvh2T9TtXELUV9hLuqP6ekftl7p7ugImAr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9332

---
 src/shared/bap.c | 159 +++++++++++++++++++++++++++++++----------------
 1 file changed, 107 insertions(+), 52 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 802b8a21da73..fe91cd67f491 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -226,6 +226,7 @@ struct bt_bap_stream_io {
 struct bt_bap_stream_ops {
 	uint8_t type;
 	void (*set_state)(struct bt_bap_stream *stream, uint8_t state);
+	unsigned int (*get_state)(struct bt_bap_stream *stream);
 	unsigned int (*config)(struct bt_bap_stream *stream,
 				struct bt_bap_qos *qos, struct iovec *data,
 				bt_bap_stream_func_t func, void *user_data);
@@ -245,6 +246,8 @@ struct bt_bap_stream_ops {
 	unsigned int (*metadata)(struct bt_bap_stream *stream,
 				struct iovec *data, bt_bap_stream_func_t func,
 				void *user_data);
+	unsigned int (*get_dir)(struct bt_bap_stream *stream);
+	unsigned int (*get_loc)(struct bt_bap_stream *stream);
 	unsigned int (*release)(struct bt_bap_stream *stream,
 				bt_bap_stream_func_t func, void *user_data);
 };
@@ -1578,6 +1581,11 @@ done:
 	bap_stream_state_changed(stream);
 }
 
+static unsigned int bap_ucast_get_state(struct bt_bap_stream *stream)
+{
+	return stream->ep->state;
+}
+
 static unsigned int bap_ucast_config(struct bt_bap_stream *stream,
 					struct bt_bap_qos *qos,
 					struct iovec *data,
@@ -1923,6 +1931,27 @@ static bool bap_stream_valid(struct bt_bap_stream *stream)
 	return queue_find(stream->bap->streams, NULL, stream);
 }
 
+static unsigned int bap_ucast_get_dir(struct bt_bap_stream *stream)
+{
+	return stream->ep->dir;
+}
+
+static unsigned int bap_ucast_get_location(struct bt_bap_stream *stream)
+{
+	struct bt_pacs *pacs;
+
+	if (!stream)
+		return 0x00000000;
+
+	pacs = stream->client ? stream->bap->rdb->pacs : stream->bap->ldb->pacs;
+
+	if (stream->ep->dir == BT_BAP_SOURCE)
+		return pacs->source_loc_value;
+	else if (stream->ep->dir == BT_BAP_SINK)
+		return pacs->sink_loc_value;
+	return 0x00000000;
+}
+
 static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
@@ -2000,6 +2029,11 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	}
 }
 
+static unsigned int bap_bcast_get_state(struct bt_bap_stream *stream)
+{
+	return stream->state;
+}
+
 static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
 					bool enable_links, struct iovec *data,
 					bt_bap_stream_func_t func,
@@ -2019,6 +2053,17 @@ static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
 	return 1;
 }
 
+static unsigned int bap_bcast_sink_disable(struct bt_bap_stream *stream,
+					bool disable_links,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	bap_stream_io_detach(stream);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+
+	return 1;
+}
+
 static unsigned int bap_bcast_disable(struct bt_bap_stream *stream,
 					bool disable_links,
 					bt_bap_stream_func_t func,
@@ -2040,6 +2085,43 @@ static unsigned int bap_bcast_metadata(struct bt_bap_stream *stream,
 	return 1;
 }
 
+static unsigned int bap_bcast_src_get_dir(struct bt_bap_stream *stream)
+{
+	return BT_BAP_BCAST_SINK;
+}
+
+static unsigned int bap_bcast_sink_get_dir(struct bt_bap_stream *stream)
+{
+	return BT_BAP_BCAST_SOURCE;
+}
+
+static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
+		uint8_t *v, void *user_data)
+{
+	uint32_t location32;
+
+	if (!v)
+		return;
+
+	memcpy(&location32, v, l);
+	*((uint32_t *)user_data) = le32_to_cpu(location32);
+}
+
+static unsigned int bap_bcast_get_location(struct bt_bap_stream *stream)
+{
+	uint8_t type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
+	uint32_t allocation = 0;
+	struct iovec *caps;
+
+	caps = bt_bap_stream_get_config(stream);
+
+	/* Get stream allocation from capabilities */
+	util_ltv_foreach(caps->iov_base, caps->iov_len, &type,
+			bap_sink_get_allocation, &allocation);
+
+	return allocation;
+}
+
 static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
@@ -2049,11 +2131,12 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 	return 1;
 }
 
-#define STREAM_OPS(_type, _set_state, _config, _qos, _enable, _start, \
-			_disable, _stop, _metadata, _release) \
+#define STREAM_OPS(_type, _set_state, _get_state, _config, _qos, _enable, \
+	_start, _disable, _stop, _metadata, _get_dir, _get_loc, _release) \
 { \
 	.type = _type, \
 	.set_state = _set_state, \
+	.get_state = _get_state, \
 	.config = _config, \
 	.qos = _qos, \
 	.enable = _enable, \
@@ -2061,26 +2144,40 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 	.disable = _disable, \
 	.stop = _stop, \
 	.metadata = _metadata, \
+	.get_dir = _get_dir,\
+	.get_loc = _get_loc, \
 	.release = _release, \
 }
 
 static const struct bt_bap_stream_ops stream_ops[] = {
 	STREAM_OPS(BT_BAP_SINK, bap_ucast_set_state,
+			bap_ucast_get_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
-			bap_ucast_metadata, bap_ucast_release),
+			bap_ucast_metadata, bap_ucast_get_dir,
+			bap_ucast_get_location,
+			bap_ucast_release),
 	STREAM_OPS(BT_BAP_SOURCE, bap_ucast_set_state,
+			bap_ucast_get_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
-			bap_ucast_metadata, bap_ucast_release),
+			bap_ucast_metadata, bap_ucast_get_dir,
+			bap_ucast_get_location,
+			bap_ucast_release),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
+			bap_bcast_get_state,
 			bap_bcast_config, NULL, bap_bcast_enable,
-			bap_bcast_start, bap_bcast_disable, NULL,
-			bap_bcast_metadata, bap_bcast_release),
+			bap_bcast_start, bap_bcast_sink_disable, NULL,
+			bap_bcast_metadata, bap_bcast_sink_get_dir,
+			bap_bcast_get_location,
+			bap_bcast_release),
 	STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
+			bap_bcast_get_state,
 			bap_bcast_config, NULL, bap_bcast_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
-			bap_bcast_metadata, bap_bcast_release),
+			bap_bcast_metadata, bap_bcast_src_get_dir,
+			bap_bcast_get_location,
+			bap_bcast_release),
 };
 
 static const struct bt_bap_stream_ops *
@@ -5380,11 +5477,7 @@ uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream)
 	if (!stream)
 		return BT_BAP_STREAM_STATE_IDLE;
 
-	if (stream->lpac->type != BT_BAP_BCAST_SOURCE &&
-			stream->lpac->type != BT_BAP_BCAST_SINK)
-		return stream->ep->state;
-	else
-		return stream->state;
+	return stream->ops->get_state(stream);
 }
 
 bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *user_data)
@@ -5568,53 +5661,15 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream)
 	if (!stream)
 		return 0x00;
 
-	if (stream->ep)
-		return stream->ep->dir;
-
-	if (bt_bap_pac_get_type(stream->lpac) == BT_BAP_BCAST_SINK)
-		return BT_BAP_BCAST_SOURCE;
-	else
-		return BT_BAP_BCAST_SINK;
-}
-
-static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
-		uint8_t *v, void *user_data)
-{
-	uint32_t location32;
-
-	if (!v)
-		return;
-
-	memcpy(&location32, v, l);
-	*((uint32_t *)user_data) = le32_to_cpu(location32);
+	return stream->ops->get_dir(stream);
 }
 
 uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
 {
-	struct bt_pacs *pacs;
-	uint8_t type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
-	uint32_t allocation = 0;
-	struct iovec *caps;
-
 	if (!stream)
 		return 0x00000000;
 
-	pacs = stream->client ? stream->bap->rdb->pacs : stream->bap->ldb->pacs;
-
-	if (stream->ep) {
-		if (stream->ep->dir == BT_BAP_SOURCE)
-			return pacs->source_loc_value;
-		else if (stream->ep->dir == BT_BAP_SINK)
-			return pacs->sink_loc_value;
-	}
-
-	caps = bt_bap_stream_get_config(stream);
-
-	/* Get stream allocation from capabilities */
-	util_ltv_foreach(caps->iov_base, caps->iov_len, &type,
-			bap_sink_get_allocation, &allocation);
-
-	return allocation;
+	return stream->ops->get_loc(stream);
 }
 
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream)
-- 
2.40.1

