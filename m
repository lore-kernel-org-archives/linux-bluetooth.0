Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9CAEE57DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Sep 2023 06:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjIKGQr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Sep 2023 02:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjIKGQq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Sep 2023 02:16:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27141109
        for <linux-bluetooth@vger.kernel.org>; Sun, 10 Sep 2023 23:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mmHKpyv+iiL1CY7l1/hIvSnb7h12G2ij8KDghwxISm4cIF/pjlko0pocVRg86uopiT/fdIGL3BRHAgtVmeWvO6HCWn7H7s3LYDhnL8wVbKAwb1qdZeEXHw7VSf/vQRtuK0IIQd9OsQADpAlX7ZWlPg32QGvlWh+6XRk1+KIBvwwgbbUchb3GChlbOBvuO0wjTSAipomd8nLKWWQmbkWRTe0ZeBl2Fabg2UCX3ekUvkd/B7vUlW7y7Zmw7mzUqLa4sZjVL3lp9svcS2EnLj2jsNUSOt6lRCPBMN7HplHBnazvA/ohabJSsRugULhQLUxEnE1XAMngtmRLx22zoNXtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RLV7si4j0cV6BUz196VmSoaQ8uDebNAVdXMCrpunerI=;
 b=ECTSqPh+6ai5KcgvKFHxFjdoCIvkmmq2KqwwHWPJEVJN9fgRzzTht7HZN5CfF6X4C9FCZIn8obSYKSwmg9GNEKEnM0LeeTUnuNDSXxPADScrlEVZOKdChpvsjY+4a89Gn0uNHdbalSrigqxwfTv2EkQnGv/RPgz+3iqbAIOBVyyl9y0BYNngOFBxBTVhqTHEs9r13uRqLpq6oEH7QFKedNYs2jLUyRecetiW+iBKO6KwXstwK0b0iFIahxRfsXxVabpHZWNx6acqiiiSeERRk3SSNsYJMKSQCK9GaLwTsWW/d1f3lRiEEZgaTOwYM6w7ofh2tV2RBZSBODkggDhELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RLV7si4j0cV6BUz196VmSoaQ8uDebNAVdXMCrpunerI=;
 b=aP7HNJI2iF5CwToK4Nva2zWiqNgKxucfmxzd10OF+KqFaPH1dhh0BKxrcKXZQKZU6Fu9YqTRC0P9zWZYkDA4AlkT2P/QX2HQIeMqrWTDdph7UzMgSDw4uhHVdiP0+4kk9QD9gyBkAKZDO8cKFsUDGs8niCC2aysUmyOrKytsfmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by DBBPR04MB7915.eurprd04.prod.outlook.com (2603:10a6:10:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 06:16:41 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Mon, 11 Sep 2023
 06:16:41 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 1/1] bap: Use defer setup when syncing to a BIS source
Date:   Mon, 11 Sep 2023 09:16:24 +0300
Message-Id: <20230911061624.30600-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230911061624.30600-1-vlad.pruteanu@nxp.com>
References: <20230911061624.30600-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0050.eurprd03.prod.outlook.com (2603:10a6:208::27)
 To PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|DBBPR04MB7915:EE_
X-MS-Office365-Filtering-Correlation-Id: e30fd682-a9ab-4941-87f4-08dbb28ea9f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWAxrLntZahjwdjn7qf6DaXnOHPDEIzBezjYxT6DcoONFoqy42ENrFuiFdzyJv+MUV+xQM90HR+K6sUDxQm5iVRlFVsM2Jc5amh7PQpkf9njkE37rFqpOnQotR7oKoZ/k0LaCBgfKZHhd4QRNFdIBZdu/N7x2FFnw4buRTvmYOaIaLG5Dmegwl7DPPOuyDsRZQeI19njC7TbHu/IYvEpbiZaXgibUdGHsIS62QhL8cS5GTDlkyICdaQr7sf2tpMa6V0ihBbLFPxefj6UY/OkeBzOpvL+WYYsq3oI0U1hH3tXmbQmjv1FbIWobQl8PviJbWcsoaisoZX73+b21/jOSTZfRcPO3qjbFDqhpLHVPRflPKh29vtoPvaNkVkqwjlaDuOeagk2EDMwteGZZCSaxa7+G7IKpAr0J2mPw1xQKrpgoDt6mb9rIRmEdC+dTx4g8nUHSUG2mdMfi5AYFX3ucw4DCAGHKimp1n3yY70+47tExeeRuAgDyQJfgXGEvht910+WIgQAyC8k0ILjex4YrsPaNUnAxwEuLMaq5X9+rREvSK+51mWFTv5wHodtC5KjWEIHnTKVr8QV0RCJNiKI/2RfJ6GI3ofMHicuJLuZbtaFEm1x0xPx6hkN4CPXLe6V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(136003)(376002)(186009)(1800799009)(451199024)(52116002)(6486002)(6506007)(41300700001)(316002)(38350700002)(2906002)(36756003)(478600001)(86362001)(66556008)(66476007)(66946007)(6916009)(6666004)(38100700002)(83380400001)(1076003)(5660300002)(2616005)(8936002)(4326008)(8676002)(26005)(44832011)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OGwyWiCy4JrkWfqMihP6Hx50yPVWu17eiC+I3dskxIq01rmHfxtegKYd+9vu?=
 =?us-ascii?Q?dP4EQ+s0cYUkzva2p6EtHi2F6wHGjgGMA4cWxdGu41++1UXcOPXkdBo+/T48?=
 =?us-ascii?Q?0dmEYm9wASc6PhqUesazF1qYts4mAuDabwf4Ubb2x2yLTO6CGGyjV7W7AfuN?=
 =?us-ascii?Q?u9rXIaXmhQgA4fQDSvyxCTtagJjRXXiSfD5LBYbkd2Kj7R7qXp6Ti0r75gVM?=
 =?us-ascii?Q?qXLXU0OAPtT7s0xOiF+FNAqmCwHcnB2Kxz0c67fOz6MMspeX478qnIxzivCf?=
 =?us-ascii?Q?NbO6vay4W1JFVDEh5dQCDYNHCpY7SvcNIdH9f7WSI5yoMlZ4g9rP8F11aI7i?=
 =?us-ascii?Q?tsBXC0F3ZdDG5qMaogVSK2pUTyfzQObA/sjwqthrMIyIpOXsa8LU+aPtfIOI?=
 =?us-ascii?Q?UHUolIWKXRDtnuPcVFeIOZ3NdO2NxZBS9bdFZ8nhTu7q4sSvWxDnmvP/hjcm?=
 =?us-ascii?Q?aSuqZNkLNpIiKhtTRFTBuHH52mhqaBlowat2mhYn57pZy52M0zUhXFovJ3U0?=
 =?us-ascii?Q?Bg/ImgNFqVf7tF69dZCVUIKKFvzthqo297nG47lICOOrO2MZWIYzlw1mFlV7?=
 =?us-ascii?Q?R3Ea5oqHx7yYeq7McWs9pzb1zue143O8BHDXWx4o0gtsW04s5UturGtMlLLG?=
 =?us-ascii?Q?SzCPv2I33Sv4VP331Rz3n93Cu8O5lD2qiqjwXNyQwt+WSOuoooL6hD/pgVl+?=
 =?us-ascii?Q?rOGC0HT3aaDZGU00gr7mRQUVsTh3YFtR1nts77NC7vckpPjRJH+2hHvIqXYG?=
 =?us-ascii?Q?OARsSo5CbXHiVbwqtRZUB+XTKDvObVgbVUe5Yk83Kn9lcK3qJ2sW6LhcAvMt?=
 =?us-ascii?Q?EvnI8ujkmNeCcyKdoNAEwPMTqax3f8BA/h92ao37xVRsfooTmtS4DNRtsDw+?=
 =?us-ascii?Q?TC0uO3+RHO+XlKcEpw4y3NI0cMxfz7Qn2EDAjMOUcvyiv2xzmq1AyzF1FbXP?=
 =?us-ascii?Q?vRCNMowVOD1OkEplH2KsRRWoW2TRkzWsTbEZzRqG/KY8S9ZLsB+ccPBuSgUG?=
 =?us-ascii?Q?79qhxtzUUMLTO8oIPlOitdMPkPNyUVMqi1J+4PQejJuu7Uin/4Umu46mii2d?=
 =?us-ascii?Q?0t1RIAU12gYHwsGKhnnVoGB/ZXQsJ237PSPU1KWejZNQJC/3l/mLS3YPRQ2P?=
 =?us-ascii?Q?zLMgALk7J2wjXa0y7GWK3EoIzYrPGeC+VJKuRgWsjNhAcB2hUIhbfXmOt4lV?=
 =?us-ascii?Q?r3PvuKbXGMcmdtlU349NtDhYxicMAOIetjXnT8GjQJRrG5TBOUgMkXg9VQlj?=
 =?us-ascii?Q?Bvp0FZpuBkKtIXyPXxTGTzuxqOrUm1oRBLkqqv5pKk26Jtq5I0RKWWO4GluY?=
 =?us-ascii?Q?FnZWsH4As4RAEWBT0Nbddzr08RnlDS/Zm+lmdqKBmyRBHlyd/VAlIqy1jMGg?=
 =?us-ascii?Q?grAE6UJJ4GQQWIaSyuT4oroXl05sytVxeD8RK9hHKB+RT3i99c82aD+IYNEy?=
 =?us-ascii?Q?J6aKa2HbARO/Bkolk9Xz/T0q7HNi6tVKLbI9HW+o8VUL1PKSqjCsmWQjxZi2?=
 =?us-ascii?Q?M41emPOU2wJfLsBRCzUdGP61wuI7KxfrWPGGeTQU5h8AlJ5TRhlshFbbg9R1?=
 =?us-ascii?Q?IPqB5WkLrIoPHtcPNY3emysyFqOdot2c9mXZl96mUc+hPoBnmTrRcAv3AbNO?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e30fd682-a9ab-4941-87f4-08dbb28ea9f0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 06:16:41.0481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uUKK9eA3dB/oob+a4PfgqI5oFLN5/UlNBLZNcq+cfJco69+8DeELJkBGVKH7Fd7ng3eXoPcf2teAUoEwNoiQSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7915
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit uses the newly added bt_io_bcast_accept function from
btio.c to implement the defer setup for the BIS sync process.
Now, information from the BIG Info advertising report can be
used when sending the BIG Create Sync command.
---
 profiles/audio/bap.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ee90426b9..8a2da24dd 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -840,6 +840,22 @@ drop:
 
 }
 
+static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
+{
+	GError *err = NULL;
+
+	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
+				user_data, NULL, &err)) {
+		error("bt_io_bcast_accept: %s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+	return;
+
+drop:
+	g_io_channel_shutdown(io, TRUE, NULL);
+}
+
 static bool match_data_bap_data(const void *data, const void *match_data)
 {
 	const struct bap_data *bdata = data;
@@ -1587,7 +1603,7 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 	if (bt_bap_stream_get_io(stream) || data->listen_io)
 		return;
 
-	io = bt_io_listen(iso_bcast_confirm_cb, NULL, ep->data, NULL, &err,
+	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, ep->data, NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
 			btd_adapter_get_address(ep->data->adapter),
 			BT_IO_OPT_DEST_BDADDR,
-- 
2.34.1

