Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B8F5EE6C
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 12:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014317; cv=fail; b=dn4zEeyxNivO0IpDq8WjijHrSI1iCKGHj9oghfRypmhcN219e5Opb4b4ERIfwSO/+vaL9h6TwsLgAjhVUXqUd4YtwRegCbl/JdoTgITrYZGxwoUnPS/zzkqT3cC/2V4/CCSEJg6I0hb1MBYsjLDD0cohcZDCU9WU0jCFw9DGcG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014317; c=relaxed/simple;
	bh=cMAJaDBZu7Km7mOtvkEnwMMLXr1jPaXj0mN53UJ/fMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=P0vR1jDrRiwSq5d5cqypi5zm+cCvADRA24ExpbhpPTsTmonFVQhWCGpKKH8SAbcU//chFpTK873YUxiNh0qf8J6G9ASiN9nOzmRInT1p5U69ecv1UbuHBlfAZg0dJ2Af3BjfS64te3evU4PagGcw2DZGaSCCU3NULwq6Z4vbytw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WDs8tx6j; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WDs8tx6j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVWUmF59+u1dyXsrKYku3jBa7EEJJOdIAM7cfc5DQoHxSFxxEO/KMmDQRDP5se75yEGJnDTn1w89C3S6eTq4siWJ0pVbs67JVi0g79CyU/Xwww/y2m7OVwDAWleeGR1Uhpxw9HY+OftBKkAJZc6vUwMvNyivCj4RRQrfBTvRP5YGYxwJHEp3ZZkl/nPZWDxxcYCl1WoUFDD2m442Pq7G5SQdAm4ahzJuOMvBzDp/fhXF5HwW1wlLlfUt5vy2R1HohXgvZdlf3Xc4FbjXjVsHQGqDXSw3m8nqSiAn7j9jlW+OVjUEaeQqVh09WWvqWzXzSXgaBUkvUxYGcp3490oyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f6c4Q8qv3ZGAvuUU9bSqmuj7/tms4VlI8e8roSkM/U=;
 b=YN1EGzbmTfLYHcfblPMExSsb+lnAP8yaX0FBewRHIMTuUH0oHVvtOPierA4Smy05XwuUFv46GxpYKE3xKkILEZgHa728chb8Q4RwwcNe+FxhBtxwgmNQt9TCmQvaPfPjpoeRykDNTqDjcws5atQN7ySPLJXUXc8+JyAMbCNu7iaKAWwb4Ay9T1EHBwfzeAF8FezWfrPJYJfWKOU42Dt1PVCX31msUG+dc3HvbTdzrxgxktTCXcoOoWnJf7llxWURglvS+0NxwzbZOudGEy3x4YhI5AO8fEXwIjAbogNjhH7F1gnHgg49rx9irWqt4qO5wJb4Tk/HFyqrIGAxaPZGsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f6c4Q8qv3ZGAvuUU9bSqmuj7/tms4VlI8e8roSkM/U=;
 b=WDs8tx6jpipRtgdZOp02yAqRDN/M8jAkQ0corpuOhX2Tc3SstOFKATDz0v8aH/kT6ahv+V/fveK6KyGjlz7mOvoxcZGY7Xysh/mPnPjD11PqnA13hYAWnYXUJbrwX32KNCi9sOie2XfKJQ5DTwjNqSCdsbXqIctImnpB1zfsS1Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB7864.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 12:51:52 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 12:51:52 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 1/3] shared/bap: Code to generate bcast source BASE
Date: Tue, 23 Jan 2024 14:51:43 +0200
Message-Id: <20240123125145.70371-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123125145.70371-1-silviu.barbulescu@nxp.com>
References: <20240123125145.70371-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0039.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::19) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: b4fa05eb-3056-483c-5d9e-08dc1c12126c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Eyqdzgr2/kAPxspkAX82vn0eSpAihRI9GU0xSVcscJoxWFZePnfGC3i+riG2yqFJ2ItWXgvm+2vEL+EZyBgQ7TfnWnxAqIBCjAHA+GktIscKkS81CXVdMTqy4amn3C2N/yTY9VooiPqvxj55wuQ4YDFueHilsa+Suv7YqAld52DpEpQGtI8Z0tF81Ecabis6JlAjxMH505XGxBcRabqZ4n5a4go/bTDLlaHUbCT1zgmAOe7gfPAV4fonmP/YVobZcIxI1gwHUndWuz9+eQcmioXLC/V0dX5ExrT4z5QVt0TtCf6riM1v+XjP8syhXKSLt5rF8Nb3fzQJf1ze5iy4fUlXrJSQ4Qr4ayNcKSh7kNZ+zPjY/ohK5jXHIZbAHHLqc3A+exzCVDMm3LBlTzReXnMIxhqqFS470dEpeBAEH0EF/GsGKApn5jjYo9O/weLGuy38D2HzAVmA1cVRLLzziROkitEtDdB59+AuTUepnKvpuOvlec2zqNmXVNiq06TZW87XWUiCgGvmOUezIANVoWLZFt+Uo+doB0ESVDAbtMoUKbiX/QpSy2xmILB6kvm6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(366004)(136003)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(8676002)(8936002)(4326008)(2906002)(41300700001)(1076003)(83380400001)(6512007)(6506007)(6486002)(478600001)(6666004)(26005)(2616005)(86362001)(38100700002)(36756003)(316002)(6916009)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HnLkgpevYIAY/QUmOfx8qu6dK1+CHFWyS8Veo+ZMAWzDuzC7kP2FLoYt++47?=
 =?us-ascii?Q?iWkHjDs3gp6PjJGAeuooaHWOEVRY5uvHEsbl88Tn5rzE8aWIkTM+V3yMoNig?=
 =?us-ascii?Q?p6M1K2J9UflpBULVBKQat5wbIPjHxKd6T1wox1G78HfZKbHa8dUIP5q73Wbz?=
 =?us-ascii?Q?YqsyrEE5KK5dNNeCqWE/P4mm/z4eIvXdsZ89ARRgIAW6lT/TpvBApeExVXsX?=
 =?us-ascii?Q?HT+bTY6RGGuqfwfSQuqGp/+wAV/OX7yK0IS3SyB1IWClcgsRZmBdKLe8loTI?=
 =?us-ascii?Q?SCKEQ/9C+Snx518FVXbqAufzRi06CVhX0PrFES/sTqmKlTOtD6+2CwaS7zSn?=
 =?us-ascii?Q?qk5NJ/WuNyg3pBF1VyucJ825w9nEmD9CyS/MnEwJEe6fXAefkLVBnYmdfQwc?=
 =?us-ascii?Q?vY3V6cfuEjOx1NeXl2CxROwU02FOhDQIbq8vOCvwASU7or4ZzcUg62/eCc52?=
 =?us-ascii?Q?nTmmh4DjlsNkP9H1DJqru1JHLslv24LeSCON7Z5lrLUxqTyBzW1HjudbmYqw?=
 =?us-ascii?Q?sTA3TtWfUCnoFJ9TnCGU3G04wVvx4ywXI25wAE5xzU3CJqvjgmyxQ69Uds9R?=
 =?us-ascii?Q?Yc2ObfzmRUsEJVR5ALIWcvbm+qmx8opHG59wLFYAGH+nXOeVzyxj+FJjjXc3?=
 =?us-ascii?Q?zm2P3pFWCGTFE69P0ZWmlnUxTUjAPMLv1u+XJzdhe5C8DBdMU9KhqDQAilfM?=
 =?us-ascii?Q?SOrYyeoY0uKhHtkN+v7+8buDIzxGSK4Ele+WXmvXOlr9otj0K8VXk7kkECb9?=
 =?us-ascii?Q?3xn7/OdHs8Iud9u9hezdSli21CqFfEpxX0qQgy7gqeNZSH/Y9XRRO44ozLGL?=
 =?us-ascii?Q?ThdXrO+uEIHs4myI0QZbnC3DhAt9mXIA8qFH9c+Net2mOUTIJFx8OZsPJ2ey?=
 =?us-ascii?Q?gIkr8er0g2QUurCgN62aSFICg+3sTNDEYTYZLdGXb11Rljk6SGf/a8bdDKKQ?=
 =?us-ascii?Q?wkR1aF19jMMzF9uKnUn8eds9vN5UntsDhwSxpJAwxM+KPKQxAutehYZ6UQ8M?=
 =?us-ascii?Q?I0P9/x/Dk7A5TvvwQz+e5ce26yOpN24YSQl7r9+UXoeCeFNysGiWiXGCMUiF?=
 =?us-ascii?Q?DedsinzI+9N97PlA4vqlgAgHXnvKViGtthCQ1EIMlesCkI97hsPlTiBmwOG6?=
 =?us-ascii?Q?Uy8qNrDAn6KXyL77x9/af7Y22i5ZCyLmXdGseIgmbxIzFtwk00dUCJ00hBGC?=
 =?us-ascii?Q?zekcUSD3lebmKx7XaeIMl7Th5M+3UKiCvynCbhZOhDO8rGOMlcoj8H1d540n?=
 =?us-ascii?Q?q68CYVvtKAGDeeiaDL9zzE/EzoCysB5zHgOG8uIS6kgR1dmkA3hrNhgfuZka?=
 =?us-ascii?Q?NUqh2FO+0eOb/j3dJBCT8oQfFRo0fH3681jSmFXazRcMce4JZSjr9f7+O8y/?=
 =?us-ascii?Q?IhCyNB+BEH2u2X4NzhWgOF4pOU33mMAUAb4aLEw/pgFYw/MsNk7xzPWOQaW2?=
 =?us-ascii?Q?a0pQ2CEGWtJbTsmBcn8+Rx8245iJESramDA67R8HxnCmbe9KAMC/yXQ1yCIT?=
 =?us-ascii?Q?8dP1QXijvujPoTEYMYUIODdIpITijDg5Bo+Cg/RjXW5JyAksoDa5X/Zkc9Pi?=
 =?us-ascii?Q?Gou7qniEjzUcUJr6W2oPwKp3r+sj360QOyePH8F0Om57ADtmIDRdyGmA0BZ1?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fa05eb-3056-483c-5d9e-08dc1c12126c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 12:51:52.4962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8dGSzZkx3kC7qR0fxWHmBfHCsykeVWXwML5LJNF5wrkb3wDtZu9ud1Ce9mOia5ou/UD+Dxeg9j8B3GWJAVBhpcreLvmvo/3ghcend1j//U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7864

Add code to support dynamically generated BASE from
endpoint configuration.

---
 src/shared/bap.c | 364 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h |   2 +
 2 files changed, 366 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 49eb8d057..d56911e6b 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -255,6 +255,26 @@ struct bt_pacs_context {
 	uint16_t  src;
 } __packed;
 
+struct bt_base {
+	uint8_t big_id;
+	uint32_t pres_delay;
+	uint8_t next_bis_index;
+	struct queue *subgroups;
+};
+
+struct bt_subgroup {
+	uint8_t index;
+	struct bt_bap_codec codec;
+	struct iovec *caps;
+	struct iovec *meta;
+	struct queue *bises;
+};
+
+struct bt_bis {
+	uint8_t index;
+	struct iovec *caps;
+};
+
 /* Contains local bt_bap_db */
 static struct queue *bap_db;
 static struct queue *bap_cbs;
@@ -5492,3 +5512,347 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 	bap_pac_merge(pac, data, metadata);
 	pac->codec = *codec;
 }
+
+static void destroy_base_bis(void *data)
+{
+	struct bt_bis *bis = data;
+
+	if (!bis)
+		return;
+
+	if (bis->caps)
+		util_iov_free(bis->caps, 1);
+
+	free(bis);
+}
+
+static void generate_bis_base(void *data, void *user_data)
+{
+	struct bt_bis *bis = data;
+	struct iovec *base_iov = user_data;
+	uint8_t cc_length = bis->caps->iov_len;
+
+	if (!util_iov_push_u8(base_iov, bis->index))
+		return;
+
+	if (!util_iov_push_u8(base_iov, cc_length))
+		return;
+
+	if (cc_length)
+		util_iov_push_mem(base_iov, bis->caps->iov_len,
+			bis->caps->iov_base);
+}
+
+static void generate_subgroup_base(void *data, void *user_data)
+{
+	struct bt_subgroup *sgrp = data;
+	struct iovec *base_iov = user_data;
+
+	if (!util_iov_push_u8(base_iov, queue_length(sgrp->bises)))
+		return;
+
+	if (!util_iov_push_u8(base_iov, sgrp->codec.id))
+		return;
+
+	if (!util_iov_push_le16(base_iov, sgrp->codec.cid))
+		return;
+
+	if (!util_iov_push_le16(base_iov, sgrp->codec.vid))
+		return;
+
+	if (sgrp->caps) {
+		if (!util_iov_push_u8(base_iov, sgrp->caps->iov_len))
+			return;
+
+		if (sgrp->caps->iov_len)
+			util_iov_push_mem(base_iov, sgrp->caps->iov_len,
+				sgrp->caps->iov_base);
+	} else if (!util_iov_push_u8(base_iov, 0))
+		return;
+
+	if (sgrp->meta) {
+		if (!util_iov_push_u8(base_iov, sgrp->meta->iov_len))
+			return;
+
+		if (sgrp->meta->iov_len)
+			util_iov_push_mem(base_iov, sgrp->meta->iov_len,
+				sgrp->meta->iov_base);
+	} else if (!util_iov_push_u8(base_iov, 0))
+		return;
+
+	queue_foreach(sgrp->bises, generate_bis_base, base_iov);
+}
+
+static struct iovec *generate_base(struct bt_base *base)
+{
+	struct iovec *base_iov = new0(struct iovec, 0x1);
+
+	base_iov->iov_base = util_malloc(BASE_MAX_LENGTH);
+
+	if (!util_iov_push_le24(base_iov, base->pres_delay))
+		return NULL;
+
+	if (!util_iov_push_u8(base_iov,
+			queue_length(base->subgroups)))
+		return NULL;
+
+	queue_foreach(base->subgroups, generate_subgroup_base,
+				base_iov);
+
+	return base_iov;
+}
+
+static void add_new_bis(struct bt_subgroup *subgroup,
+			uint8_t bis_index, struct iovec *caps)
+{
+	struct bt_bis *bis = new0(struct bt_bis, 1);
+
+	bis->index = bis_index;
+
+	if (caps)
+		bis->caps = caps;
+	else
+		bis->caps = new0(struct iovec, 1);
+
+	queue_push_tail(subgroup->bises, bis);
+}
+
+static void add_new_subgroup(struct bt_base *base,
+			struct bt_bap_stream *stream)
+{
+	struct bt_bap_pac *lpac = stream->lpac;
+	struct bt_subgroup *sgrp = new0(
+				struct bt_subgroup, 1);
+	uint16_t cid = 0;
+	uint16_t vid = 0;
+
+	bt_bap_pac_get_vendor_codec(lpac, &sgrp->codec.id, &cid,
+			&vid, NULL, NULL);
+	sgrp->codec.cid = cid;
+	sgrp->codec.vid = vid;
+	sgrp->caps = util_iov_dup(stream->cc, 1);
+	sgrp->meta = util_iov_dup(stream->meta, 1);
+	sgrp->bises = queue_new();
+
+	stream->qos.bcast.bis = base->next_bis_index++;
+	add_new_bis(sgrp, stream->qos.bcast.bis,
+					NULL);
+	queue_push_tail(base->subgroups, sgrp);
+}
+
+struct bt_ltv_match {
+	uint8_t l;
+	uint8_t *v;
+	bool found;
+};
+
+struct bt_ltv_search {
+	struct iovec *iov;
+	bool found;
+};
+
+static void match_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
+{
+	struct bt_ltv_match *ltv_match = user_data;
+
+	if (ltv_match->found == true)
+		return;
+
+	if (ltv_match->l != l)
+		return;
+
+	if (!memcmp(v, ltv_match->v, l))
+		ltv_match->found = true;
+}
+
+static void search_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
+{
+	struct bt_ltv_search *ltv_search = user_data;
+	struct bt_ltv_match ltv_match;
+
+	ltv_match.found = false;
+	ltv_match.l = l;
+	ltv_match.v = v;
+
+	util_ltv_foreach(ltv_search->iov->iov_base,
+			ltv_search->iov->iov_len, &t,
+			match_ltv, &ltv_match);
+
+	/* Once "found" has been updated to "false",
+	 * do not overwrite it anymore.
+	 * It means that an ltv was not found in the search list,
+	 * and this should be detected back in the parent function.
+	 */
+	if (ltv_search->found)
+		ltv_search->found = ltv_match.found;
+}
+
+static bool compare_ltv(struct iovec *iov1,
+		struct iovec *iov2)
+{
+	struct bt_ltv_search ltv_search;
+
+	if ((!iov1) && (!iov2))
+		return true;
+
+	if ((!iov1) || (!iov2))
+		return false;
+
+	/* Compare metadata length */
+	if (iov1->iov_len != iov2->iov_len)
+		return false;
+
+	ltv_search.found = true;
+	ltv_search.iov = iov2;
+
+	util_ltv_foreach(iov1->iov_base,
+			iov1->iov_len, NULL,
+			search_ltv, &ltv_search);
+
+	return ltv_search.found;
+}
+
+struct bt_ltv_extract {
+	struct iovec *result;
+	struct iovec *src;
+};
+
+static void extract_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
+					void *user_data)
+{
+	struct bt_ltv_extract *ext_data = user_data;
+	struct bt_ltv_match ltv_match;
+	uint8_t ltv_len = 0;
+
+	ltv_match.found = false;
+	ltv_match.l = l;
+	ltv_match.v = v;
+
+	/* Search each BIS caps ltv in subgroup caps
+	 * to extract the one that are BIS specific
+	 */
+	util_ltv_foreach(ext_data->src->iov_base,
+			ext_data->src->iov_len, &t,
+			match_ltv, &ltv_match);
+
+	if (!ltv_match.found) {
+		ltv_len = l + 1;
+		iov_append(ext_data->result, 1, &ltv_len);
+		iov_append(ext_data->result, 1, &t);
+		iov_append(ext_data->result, l, &v);
+	}
+}
+
+static struct iovec *extract_diff_caps(
+		struct iovec *subgroup_caps, struct iovec *bis_caps)
+{
+	struct bt_ltv_extract ext_data;
+
+	ext_data.src = subgroup_caps;
+	ext_data.result = new0(struct iovec, 1);
+
+	util_ltv_foreach(bis_caps->iov_base,
+			bis_caps->iov_len, NULL,
+			extract_ltv, &ext_data);
+
+	return ext_data.result;
+}
+
+static void set_base_subgroup(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	struct bt_base *base = user_data;
+	/* BIS specific codec capabilities */
+	struct iovec *bis_caps;
+
+	if (bt_bap_pac_get_type(stream->lpac) != BT_BAP_BCAST_SOURCE)
+		return;
+
+	if (stream->qos.bcast.big != base->big_id)
+		return;
+
+	if (base->pres_delay < stream->qos.bcast.delay)
+		base->pres_delay = stream->qos.bcast.delay;
+
+	if (queue_isempty(base->subgroups)) {
+		add_new_subgroup(base, stream);
+	} else {
+		/* Verify if a subgroup has the same metadata */
+		const struct queue_entry *entry;
+		struct bt_subgroup *subgroup = NULL;
+		bool same_meta = false;
+
+		for (entry = queue_get_entries(base->subgroups);
+						entry; entry = entry->next) {
+			subgroup = entry->data;
+			same_meta = compare_ltv(subgroup->meta,	stream->meta);
+			if (same_meta)
+				break;
+		}
+
+		if (!same_meta) {
+			/* No subgroup with the same metadata found.
+			 * Create a new one.
+			 */
+			add_new_subgroup(base, stream);
+		} else {
+			/* Subgroup found with the same metadata.
+			 * Extract different codec capabilities.
+			 */
+			bis_caps = extract_diff_caps(
+					subgroup->caps,
+					stream->cc);
+
+			stream->qos.bcast.bis = base->next_bis_index++;
+			add_new_bis(subgroup,
+					stream->qos.bcast.bis,
+					bis_caps);
+		}
+	}
+}
+
+static void destroy_base_subgroup(void *data)
+{
+	struct bt_subgroup *subgroup = data;
+
+	if (!subgroup)
+		return;
+
+	if (subgroup->caps)
+		util_iov_free(subgroup->caps, 1);
+
+	if (subgroup->meta)
+		util_iov_free(subgroup->meta, 1);
+
+	queue_destroy(subgroup->bises, destroy_base_bis);
+
+	free(subgroup);
+}
+
+/*
+ * Function to update the BASE using configuration data
+ * from each BIS belonging to the same BIG
+ */
+struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
+{
+	struct bt_base base;
+	struct iovec *base_iov;
+
+	base.subgroups = queue_new();
+	base.next_bis_index = 1;
+	base.big_id = stream->qos.bcast.big;
+
+	/*
+	 * Create subgroups with each different Metadata and Codec
+	 * Specific Configuration from all streams having the same BIG ID.
+	 */
+	queue_foreach(stream->bap->streams, set_base_subgroup, &base);
+
+	base_iov = generate_base(&base);
+
+	queue_destroy(base.subgroups, destroy_base_subgroup);
+
+	return base_iov;
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 51edc08ab..2c3550921 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -88,6 +88,7 @@ struct bt_bap_bcast_qos {
 	uint16_t timeout;
 	uint8_t  pa_sync;
 	struct bt_bap_io_qos io_qos;
+	uint32_t delay;			/* Presentation Delay */
 };
 
 struct bt_bap_qos {
@@ -321,3 +322,4 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
+struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
-- 
2.39.2

