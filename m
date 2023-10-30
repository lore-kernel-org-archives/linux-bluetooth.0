Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DFDC4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Oct 2023 15:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjJ3Pt2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Oct 2023 11:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233600AbjJ3Pt1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Oct 2023 11:49:27 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3734F5
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Oct 2023 08:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMCjD/RQEtP9NTWjp0+CcURsRikNzQ8dLugweRWRelTmeUsTllFzX5j24ERmRB4a394PvftJc7u2LqAWImk8YfDa7kCmmql7XW0mwBx0YsDT/Cy08bAF2cgtsYgeScDu2MhjT9h8MNhAe5uTRyqRhHenva5N7NuUEhbtXazABJzo8uag8DVaoxsHd9xnu63VW4gGqIIcakFVTXe8IBbQXT1v8n81wpuiZVGrBU6K5zSQziaYzV81PGr++1IM4xbtTKdTuQQDiEMtCd7dvdQkZetdox/cQZ2J0n4EXeVCq+nkw4bvflDgVF/6J+rZPozEtUi37wRgfWbiyTU+jUOPDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZtqAv+sSidZ21jw4s2ezgizbscRDUoKLVo5ZTCQ0fw=;
 b=b4JwqKp1AeQ1j+pv1RNux/tfSxEHpWAgBSfbsaMNa5thfyTBOtweZHNTmHx+Ns9pFbpff8MyztjhuSlCwC4BBqgphRoIo6WDjloxHaqCw4Yyq05XnLl8BP75ktCBk7uFGJQN4VfrzRW6KifZV7icvA2fx+cMKPZw1u82r/myYvtlHGaiDYiJgIs5xezVIwbO7EuivMah8tSPnWqTas6Stfysh8JdTAwdDUHMheF77iIJnXt2Bxd8Quh2uXfVecSeJa+YybfdF1O4s4JfiP2fIqid/yGU5IZvtAmL1C/696N5eq7yKSeFZFq/4vb3D3ZkuvriJIzrqR8PMEQvMwSKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZtqAv+sSidZ21jw4s2ezgizbscRDUoKLVo5ZTCQ0fw=;
 b=BpyfBEbY0Mk4VsRQQcKj+0ynYIZXG9Zuozbm26WmwZxurwTvwfFfMNbzblKyOdcKzPPf6fSzOYPxFXmtNRYs6rTgwJz4mZclE3Cmlt9dT6FICv0TWrarop9jjzTKxRouzAtC71Alkk+6fM1zvwy54hXdwCyDhusLDaCokFza1sg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7975.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Mon, 30 Oct
 2023 15:49:20 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d%4]) with mapi id 15.20.6954.014; Mon, 30 Oct 2023
 15:49:20 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] iso-tester: Add test for bcast AC 13 reconnect
Date:   Mon, 30 Oct 2023 17:49:13 +0200
Message-Id: <20231030154913.4442-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030154913.4442-1-iulia.tanasescu@nxp.com>
References: <20231030154913.4442-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0116.eurprd09.prod.outlook.com
 (2603:10a6:803:78::39) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cfa887-f79e-447f-3e37-08dbd95fc7d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PtX7WO/LqbI8rdUCXU/P1XLwZw1mM+IARQtfdDWxe5dHdAIj43tGdTzZcnJv6v7bOSZr1kOaBBNwhG62i7mKIqCAUWKAvCG8/YoTYxUHMHLZTRm4AwrnyWAcN55lHrS1LnW5Vz/cef2bQVD3bdhWFmB51vRMG2vvLYludwBmQEs8EBoBZuUqCUz1xmSWA1+4iKX3gyY/R9TuX9M9IwVVHOlzD/wDnawilW/qc/fUt7mJKZW1Y7cG/7CyfA9h5AnIWAMsTBo6iS8MFvXClOrAGJ2MLDADQd8OGXJn/53cUQY2q/BtAyW7Ek4aM4kKwBQF3AGLQ8vcrQj6g+pRQ64V98/YiDj8hE/eXwAF23XeO7PwXkckQMj0qFAgvhQEBeObxBI5akF4rF6mA72+nXd6hsyFp1wolLUWxRGw/DQNYQH341vNbjoXCvMSDh9JIx5Pa9fqm/AAYewFKyTmeGTQzV5/c7y5OBhcTxUHu2+Vi/rQXGm1Shl+cnzUk8/ASFYCCCWqqHgS36euA9rG7u2MEzxsipmIFM5IpDLU30T0RThUvdN4Q4XwAWGD/JuQvwq+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(346002)(376002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(6666004)(83380400001)(2906002)(478600001)(66556008)(6512007)(41300700001)(6486002)(8936002)(5660300002)(316002)(6916009)(6506007)(86362001)(66946007)(66476007)(8676002)(36756003)(4326008)(38100700002)(44832011)(2616005)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RNHu+Rqp3clvpSyPt+xRpHRlloJ5KFQ2tAjT4PJrUIZPsxxKeHIvnJhsbH6x?=
 =?us-ascii?Q?RjE4+7f4qheZ67uyMP1ynYltBwebqKXQE+LhjycB0qH74qQGUSFIjOKZ2AK0?=
 =?us-ascii?Q?l3gr3p6fRdpyjQnLaXs7EtRuBifeW661RSBtARoqks5GUYFL/KFSmSsUozbX?=
 =?us-ascii?Q?ux7Huw6NiNrXRBgF3vVMTLYg4NnJC6uUc/9GCILwdyq2iDnYPp8oCiZROkdL?=
 =?us-ascii?Q?zwH3flCGmUGsnmhhP4klJdha1KmgdMRjspHdMTWvKVcRYDkReI1EgtTvgjs2?=
 =?us-ascii?Q?UwFZPY82TZFPj2Ep+3X8UkdSJWn6vYH4tLlfEWwrCdhW06sTu0pdzP3rQiBG?=
 =?us-ascii?Q?LmhcylHGwQFZlKqd/wt+GPS/oFDzSNO65GXHcIZx1kEUohyc3kl6IzaTQnAf?=
 =?us-ascii?Q?dtpzEIFYBejdQHsLBASakzCPW+XUyWkkG9Kr6iUEAGIsBRdcqqwFVM0ico4g?=
 =?us-ascii?Q?Wcbh/iWZRFYEnz0tgPSt2s2jJs6LEoHQvFiM/jcvC/GNWlGxmcgajfeeUima?=
 =?us-ascii?Q?0K3F9wEqCkYUP080XTpJ5hv5wYz9gTFKKIjElRSsIBb24bIYK32x8q1hxiit?=
 =?us-ascii?Q?VSBAuhZ28LHPYIacFdNAO3YZ5dfq67SuOB/P3jMW6FJg2guZ/v0xvH9UQTcz?=
 =?us-ascii?Q?iTwMVZ359ogFUjJ1CSAZM2rJ6frz3rPXE/2tHaFLBmX5pql+RY2Nf2KuqLBF?=
 =?us-ascii?Q?Q+fOyJlDsUOEF6JDdOVQ8Qq3RUFDi2ZN/jfYDlH4F44z5clRrVFrpGEUZghu?=
 =?us-ascii?Q?nLiNtSgH5HMTosOr2DZ76JLQj/6qx5IVru2JKNFg9jteUIu5lF2BscTtCxh8?=
 =?us-ascii?Q?4Md0L1jqqcRBEmzv1dlVBjNu3yZAotDIm514VRKm/GJyWqVRXR8QVy03zFsR?=
 =?us-ascii?Q?PuqtQ3NzURKPUmvJS+IZP5gZBtDxItPzUN6LfBBc2DkNJrIl4nvsNHF+KXh4?=
 =?us-ascii?Q?7pSlEj0dTc6WkRgDG0sGKwvxD/LqhwMaahZUzpnzwx69GobZpTjohu3MyXL2?=
 =?us-ascii?Q?aaFoVbgY3jRNfh0NUtz+kdKX1PFKOWMQ76/dn4vAgXAbWzGfCjwaAZIl9Za9?=
 =?us-ascii?Q?aYa5D3VzClc8tHS8zejpxTIF0j+dMLMruU0wv9I1sw3Jj51FSMRxCihAbN6T?=
 =?us-ascii?Q?EJxAp91rJQwZKVvwXP5yzmsPWLup10EuaFV9vl32PGzYYcVg+FPtkj3I+4lV?=
 =?us-ascii?Q?VE3mxEUeUGDvj1BjGA/SJVTXZAEW14+wLvorxfLVK+Ez7J3UlIzr3cEEdp/3?=
 =?us-ascii?Q?EqKQOp+soZ1CTJXGnbuiQaJJpIknN2Za+A+wSRxCWqmAFDSxYWbh6qRCTsWC?=
 =?us-ascii?Q?GZ5juHpPgW7JJpid6ZNFOUE48uF24wgMdTAwd+2F/MYiYspKSzLeyhbehe+6?=
 =?us-ascii?Q?eDBIsr7AcV+i8jIHI+iJGS+su5u4EHfYph9pQ3X06kOyx7ipja4cKdEJUcCB?=
 =?us-ascii?Q?hrvV7vuUoIte7tTsXc0v+OyBXaFDwRYPJPC34wdbKIgdT+nY0HM6tPcz15UQ?=
 =?us-ascii?Q?KwItnC/sQPdHDIgiqYrDMNvelJAHKar2OERDxmeWqbOYYeZzoy2zVTMYse2m?=
 =?us-ascii?Q?62D8Gf8E8yjRiB3r4RYx/SFS50pnguJYf0S/Dzu9bH63+lqfLf3Mxvq4qcDB?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cfa887-f79e-447f-3e37-08dbd95fc7d2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 15:49:20.2186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /KWpyJTEDFpTDAHDN1/qvhpSEOLaojvu1z6gOjHBzJBff/XWIs/trQhOnR5KEOsiMZfJo1U1/G0hoftIMQ0PCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7975
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a test for Broadcast AC 13 reconnect:

ISO Broadcaster AC 13 Reconnect - Success

---
 tools/iso-tester.c | 60 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index ae98af775..9fccbaa80 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -32,6 +32,7 @@
 #include "src/shared/tester.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 #define QOS_IO(_interval, _latency, _sdu, _phy, _rtn) \
 { \
@@ -388,7 +389,7 @@ struct test_data {
 	uint8_t accept_reason;
 	uint16_t handle;
 	uint16_t acl_handle;
-	GIOChannel *io;
+	struct queue *io_queue;
 	unsigned int io_id[2];
 	uint8_t client_num;
 	int step;
@@ -592,12 +593,19 @@ static void test_post_teardown(const void *test_data)
 	data->hciemu = NULL;
 }
 
+static void io_free(void *data)
+{
+	GIOChannel *io = data;
+
+	g_io_channel_unref(io);
+}
+
 static void test_data_free(void *test_data)
 {
 	struct test_data *data = test_data;
 
-	if (data->io)
-		g_io_channel_unref(data->io);
+	if (data->io_queue)
+		queue_destroy(data->io_queue, io_free);
 
 	if (data->io_id[0] > 0)
 		g_source_remove(data->io_id[0]);
@@ -1181,6 +1189,16 @@ static const struct iso_client_data bcast_ac_13_1_1 = {
 	.base_len = sizeof(base_lc3_ac_13),
 };
 
+static const struct iso_client_data bcast_ac_13_1_1_reconn = {
+	.qos = BCAST_AC_13_1_1,
+	.expect_err = 0,
+	.bcast = true,
+	.mconn = true,
+	.base = base_lc3_ac_13,
+	.base_len = sizeof(base_lc3_ac_13),
+	.disconnect = true,
+};
+
 static const struct iso_client_data bcast_ac_13_1 = {
 	.qos = BCAST_AC_13_1,
 	.expect_err = 0,
@@ -1911,10 +1929,14 @@ static gboolean iso_disconnected(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	struct test_data *data = user_data;
+	const struct iso_client_data *isodata = data->test_data;
 
 	data->io_id[0] = 0;
 
-	if ((cond & G_IO_HUP) && !data->handle) {
+	if (cond & G_IO_HUP) {
+		if (!isodata->bcast && data->handle)
+			tester_test_failed();
+
 		tester_print("Successfully disconnected");
 
 		if (data->reconnect) {
@@ -2177,7 +2199,15 @@ static void setup_connect_many(struct test_data *data, uint8_t n, uint8_t *num,
 		data->io_id[num[i]] = g_io_add_watch(io, G_IO_OUT, func[i],
 									NULL);
 
-		g_io_channel_unref(io);
+		if (!isodata->bcast || !data->reconnect)
+			g_io_channel_unref(io);
+		else if (data->io_queue)
+			/* For the broadcast reconnect scenario, do not
+			 * unref channel here, to avoid closing the
+			 * socket. All queued channels will be closed
+			 * by test_data_free.
+			 */
+			queue_push_tail(data->io_queue, io);
 
 		tester_print("Connect %d in progress", num[i]);
 
@@ -2434,7 +2464,9 @@ static bool iso_defer_accept(struct test_data *data, GIOChannel *io)
 
 	tester_print("Accept deferred setup");
 
-	data->io = io;
+	data->io_queue = queue_new();
+	if (data->io_queue)
+		queue_push_tail(data->io_queue, io);
 
 	if (isodata->bcast)
 		data->io_id[0] = g_io_add_watch(io, G_IO_IN,
@@ -2758,6 +2790,18 @@ static void test_bcast2(const void *test_data)
 	setup_connect_many(data, 2, num, funcs);
 }
 
+static void test_bcast2_reconn(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	uint8_t num[2] = {0, 1};
+	GIOFunc funcs[2] = {iso_connect_cb, iso_connect2_cb};
+
+	data->io_queue = queue_new();
+
+	data->reconnect = true;
+	setup_connect_many(data, 2, num, funcs);
+}
+
 static void test_bcast_recv(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -3114,6 +3158,10 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster AC 13 BIG 0x01 - Success", &bcast_ac_13_1,
 						setup_powered, test_bcast2);
 
+	test_iso("ISO Broadcaster AC 13 Reconnect - Success",
+					&bcast_ac_13_1_1_reconn, setup_powered,
+					test_bcast2_reconn);
+
 	test_iso("ISO Broadcaster AC 14 - Success", &bcast_ac_14, setup_powered,
 							test_bcast);
 
-- 
2.39.2

