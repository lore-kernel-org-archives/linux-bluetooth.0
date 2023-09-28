Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF98E732DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 14:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjI1O2v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 10:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjI1O2u (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 10:28:50 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2061.outbound.protection.outlook.com [40.107.247.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C0319E
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 07:28:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TniCbWxDc3msJ3uwYyDkAeFP7HS+fDRuNp49exQ7hD0yaAnz0cd/whlwxxunmirkxVKdzfkSpdhELC05zPVXWQOfvNNYyO7bXb0TEF4GqIxfe/KDtms96IjtKNn3i98jcMdF2EIqUB6skMJlGeqEaWPwqNXMf+DeGoqgMB9s+I5K1GYhe68ztv5XR0k2ES2mKdQ2hLLYhOMUFJHZoN6ukELxUw6F3Qic0KwgHcKf2sPkrMh2jgKjnWX39LcWs1YTUii9jdsigF+xRuYqurU/E9Lq+RYhhc6rv+8C7nf6zgbVcPD3CDpm6J8npJldTDHLTefTo+BCSG60vOL4NOyqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKYf26JiSxy6Jy5mplrNxdemiKwkr6mb96uYAT2xFb0=;
 b=AuIJ5FRa0lJP2DBi+phRQJRylokDRhrf5d4TI3BCc90FstRtBeNuYbDTxQq3eN8FaROjcDrQQhMSrHhb5MoP9sU89dH1FgWUnmkZHSwd8+8UAA/2DLhsudOCeEAHvtHaBGiTR9FTlA5iG64ANln8+SqI/eamzCA4+dj/cdnS353mOHZ3YnAKxrnZtGkgkKM+yc9bNfzRM7fW9Gb+0SyRNMTJajnn8eB3XIYa7HJ4iaUA6oGsmT+vJvUmxMw0OLtmjvD9COwVo3nqzr1i5PU3YJ/GKvp9zwTx2vdEXFU1suIX01M5SeaDI3mFfd0lAMHGlrSKd4jGckNlNBK5oSmlOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKYf26JiSxy6Jy5mplrNxdemiKwkr6mb96uYAT2xFb0=;
 b=BW4r89hzHLDiDVpJK73picNIgEa2UWgyMq7dZMQQpwDlBHfnwaH8F6yA1QqrbzWSwqyUYbi9zkl6IJl9WRbyuK9YgCENiBqVaMqqrteHD4Desdp+ZPkWj/mDWowM6xuhPI2cyK5sEM3cl3x/A8ttC14A76FHAt+2UY78NH1Iao0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7619.eurprd04.prod.outlook.com (2603:10a6:20b:284::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Thu, 28 Sep
 2023 14:28:46 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 14:28:46 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] iso-tester: Test bcast receiver with PA sync, no BIS
Date:   Thu, 28 Sep 2023 17:28:32 +0300
Message-Id: <20230928142832.3174-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230928142832.3174-1-iulia.tanasescu@nxp.com>
References: <20230928142832.3174-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0196.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7619:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b21cca-6bf8-4e85-ddea-08dbc02f395a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HPxMhbmtk7BWxDIMBq1UrBTfe27QSxcIoLo3mS3F8gXY0jE9cD/yOM9BEyW4BsmOG9gP3jcNiFAIqAp95Hr8W4Jsm0b/kMTI4rvlDJ6po2c3LzFMcQYm8ID5v7/oXyFVfutCHP/FiyGnT6c/H618mFJx6uJbNIjyqCwvPX2XyJxGnkcPRjlmpelYTV87PKb7D+02HXc1UOb+d8fY29Y3b7HfE8qm/2kkWeaq78TiUyVPXQFEQ1d/U7yDSO82Aj7NBKyqKqWW7mJvS+5BRMoD8yxyrM+qAO7EYfAIStNm1ZFOrCPeV8A1LzneQDgSpv9iQEEMoHl2B/BYBzXhwlUcxxxYpavohJcD1RQprdVFncy+koj9aZ1sOWtchad1DP71a93RwVW7dMbj0qjP2Vh8AlymhZaIFUro5SdtEo9JDaroSc92BM8c0eS+CqGtmocrUlcJJ4nwLpQ3mKlHWRwX+ZCBSTMveqmk/GcAwqUilMX3JONO29CdMV3ajdeJhBcehtVCvmyLcT0qxx0DKtstez8LosAgWBI/dw1boBcDVd/o+jTGlnm70T2i7edVym+l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(38100700002)(6666004)(478600001)(6512007)(6486002)(6506007)(86362001)(26005)(5660300002)(66556008)(8676002)(36756003)(66476007)(8936002)(44832011)(66946007)(41300700001)(4326008)(316002)(6916009)(2906002)(83380400001)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h+cmW1k8OLxBkjdRRAa6RwoQsiyH+Ym5TmBs2Cof8w7+x6EJ5NFTXWYJSh7Y?=
 =?us-ascii?Q?rzoRB952aZx5kkNZ2eXkKpCw6oQ4JhcrApvHeQF9j/MM1cSWqCd8fLs051N1?=
 =?us-ascii?Q?I/nr+y1lqcVmiOXj6Ew2iBVZ+87gdPuwsnZYZsBMo86UsiAaGa6MhV0/bCpI?=
 =?us-ascii?Q?JR9dYj38Pxb1fLy5U+K/H28hsRXSqLnRNqAFUivZTYfMPdbPXWp1ks/O2WpJ?=
 =?us-ascii?Q?4+Zfc++3WOMj0XXC5+jMuFn6WDDwIgMwRu9l0RxcBIi3baz9LHtDpItPS6fl?=
 =?us-ascii?Q?5q1Dpk7OQDJTp583uIoDJK6FcTeyUSyzyTF+sCZCWK4HwLJb1k+hkgdQvfxx?=
 =?us-ascii?Q?cmsUpH7UE4n0/D0/3CHxvH8m8If9s9fRbJAIPPm9L6rfJ/izjnIN4DbWwq7V?=
 =?us-ascii?Q?5Bx9kLTjdxK99WPkNlJTf1jTvqsGNwhicERNL2vGaKd5WCs02/sLZ8JZh/WO?=
 =?us-ascii?Q?roYf5rQwdQD0k2pDX+2TBUpfoaboSLE9zocfTSSIXiUrqn4YfriEq6pfVO94?=
 =?us-ascii?Q?o68f9C2jOuS3ZFsmorOgh46fOeHd+y36bBxy38Yq4Rea2DIFhQ9qStd8wVKc?=
 =?us-ascii?Q?FbN9NCBKa60yJFMauIa5Uwy0Lz/HU6DAxD6HFFnRGytcpIOtEBxdJ+9AUP/i?=
 =?us-ascii?Q?/C9TfLUPMp1ZExILTR0KZ0GL4pCDx0ia2U15nGPx7rd5H50gmEZkv4EExyN/?=
 =?us-ascii?Q?+NOeoe4giHxld8yLdTNNkvGRe0Nm9HSXDtN0kBMFWXaJ9qh1epSIzICUYIYW?=
 =?us-ascii?Q?B1Ev6IcyhmkmHYlfMG9LiH16tV883uW0ojNthUKt9cttMpI42WogpnZVaM7i?=
 =?us-ascii?Q?03gL2Fvg8mABm3h5LSeSLHTrlh29RvbXGx5oZQ3cuZXobq2fL8U9UPJ33T1o?=
 =?us-ascii?Q?H2XqFZwtaBE0Lp4etU49/vBy3HsPu08dHW8lH5wuThBHP5AXFrENsxmYsUos?=
 =?us-ascii?Q?2BoEk4BOofMrVJFpIAH8XnIVoDP3MY1GXF2+sS738iyOt4zzOSVJTwEF8Fzq?=
 =?us-ascii?Q?UCec17PxYGtFXxjVIw3ELmRhXp887cz3YDAIw2v4ptOWoxWmAMIWS5tz6tMx?=
 =?us-ascii?Q?6UPmsgzFt0vdXjSo6HdCWBhfCbcxTLUx8AUTzroulubmc5fzyJfUbn1M/+B0?=
 =?us-ascii?Q?Z+bEhusNRpB1AR5+3JIRhBbYWUZ3cFlEJJwTG5ahZxavmw1N4Cd5DrhIwFXo?=
 =?us-ascii?Q?2VIDhge2h+PCaUpP5lLYqhvsWMy2JYiHkCr+UN+12acZmFqmJg7+wI+d6RpB?=
 =?us-ascii?Q?CBJTk4szUGeaPpccOKCpOh6tjlydB/4maEgAS99srpN5Qc+lJfNgOefK8rN5?=
 =?us-ascii?Q?AzfFBVNYYAFi/QCnUHJK5g7hs/rxHcViTT8ku7evKOtVWnZOfDLGmrb6LUXf?=
 =?us-ascii?Q?dmgt6fVSxTqrQOr6t+QrLpCMkiYIB1Bed7cJtkv+aRQ5rGCIMsdnq+Iw6y23?=
 =?us-ascii?Q?H2PW/g8qWG6AjJmszWhxPHVz0EPGj5Kq4gReRmJfnDeDDXniH81nzrHibvRF?=
 =?us-ascii?Q?9jcWClH7+2KhEYJrxXW8flqVuFbQO2nG3vz/W0MXw/ZIHTZdxTYOelxE+Wrt?=
 =?us-ascii?Q?VQGcj9Z/aq+bvsc7xN7+m1hd5kjvjL4lBJ7bKN2ObF6jmI7XO/4u/VF7o8ss?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b21cca-6bf8-4e85-ddea-08dbc02f395a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 14:28:46.2311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/7hmmIuTDf5qRTy+C6Y2yT1JlFgS3Y32m7MJpXQ8zhXgbZHkd1O8qEPgzpICeMmexm3789u0eCp1DCOpOBvEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7619
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This tests that a broadcast receiver is able to successfully sync to the
PA transmitted by a source, without performing BIS sync also:

ISO Broadcaster Receiver Defer No BIS - Success

---
 tools/iso-tester.c | 41 +++++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 410da2c93..6d24c4c8c 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -411,6 +411,7 @@ struct iso_client_data {
 	uint8_t pkt_status;
 	const uint8_t *base;
 	size_t base_len;
+	bool bcast_defer_accept;
 };
 
 static void mgmt_debug(const char *str, void *user_data)
@@ -1141,6 +1142,16 @@ static const struct iso_client_data bcast_16_2_1_recv_defer = {
 	.recv = &send_16_2_1,
 	.bcast = true,
 	.server = true,
+	.bcast_defer_accept = true,
+};
+
+static const struct iso_client_data bcast_16_2_1_recv_defer_no_bis = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.defer = true,
+	.bcast = true,
+	.server = true,
+	.bcast_defer_accept = false,
 };
 
 static const struct iso_client_data bcast_ac_12 = {
@@ -2257,8 +2268,11 @@ static int listen_iso_sock(struct test_data *data)
 
 		bacpy(&addr->iso_bc->bc_bdaddr, (void *) dst);
 		addr->iso_bc->bc_bdaddr_type = BDADDR_LE_PUBLIC;
-		addr->iso_bc->bc_num_bis = 1;
-		addr->iso_bc->bc_bis[0] = 1;
+
+		if (!isodata->defer || isodata->bcast_defer_accept) {
+			addr->iso_bc->bc_num_bis = 1;
+			addr->iso_bc->bc_bis[0] = 1;
+		}
 
 		err = bind(sk, (struct sockaddr *) addr, sizeof(*addr) +
 						   sizeof(*addr->iso_bc));
@@ -2420,9 +2434,21 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 			return false;
 		}
 
-		if (isodata->bcast && data->step > 1) {
-			data->step--;
-			goto connect;
+		if (isodata->bcast) {
+			if (data->step > 1)
+				data->step--;
+			else
+				data->step++;
+
+			iso_connect(io, cond, user_data);
+
+			if (!data->step)
+				return false;
+
+			if (!isodata->bcast_defer_accept) {
+				tester_test_passed();
+				return false;
+			}
 		}
 
 		if (!iso_defer_accept(data, io)) {
@@ -2444,7 +2470,6 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
-connect:
 	return iso_connect(io, cond, user_data);
 }
 
@@ -3031,6 +3056,10 @@ int main(int argc, char *argv[])
 						&bcast_16_2_1_recv_defer,
 						setup_powered,
 						test_bcast_recv);
+	test_iso("ISO Broadcaster Receiver Defer No BIS - Success",
+						&bcast_16_2_1_recv_defer_no_bis,
+						setup_powered,
+						test_bcast_recv);
 
 	test_iso("ISO Broadcaster AC 12 - Success", &bcast_ac_12, setup_powered,
 							test_bcast);
-- 
2.39.2

