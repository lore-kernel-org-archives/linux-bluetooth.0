Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F662C001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 13:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbjHBNZd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 09:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbjHBNZ2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 09:25:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1972E2711
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 06:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YXfIal3bmLlOOtNqYoFwQIQohtLYuuHn5kSc6+L+IuO2tSh8Gw1mMnQTB/HjluEtbZUTbfN8jEW7m3gT6mWF1tdvKTBX/z63ozHtq81khcqkPgolMv6PSA3IxNhHaKqoiJZXXRuzOkI4c/iLPlvYDxwfJrIL/zF6nglOsQSwPyPBKwdpEjWG/lnM22bYwe1HnSH2/3lSLXWlSyrA4xGvB2b3uxeovaPGb9cK1nYwup3nSgPpcmCfyvgA2RKAHdvSIwqRydSeWW+1URv24blYlN0Vm3Az0sz5KTXeTBC8kT4ZHyU7rVtCiiUaz/ofs7+4rXeD48wTr8KBIaRG4wQ2sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2gF34zHGQhAiE+qOW3zUC6g7lbjiTV0/SimCcSCaYc=;
 b=mYCsE+ntxk9lZ7ytXT3gUH5Y/B8UHnPFz2arfRHRGgCLMGHDOyPExo5MbJv2W3HHHQVBB0hmqX4wigiH5l/3yZs/BLoF+WfGr3ZUCzPH3P6ouF7gIs+4M72IwRQwKBx2BJ8lVd8XkaYA9OBgJPpNLY8KVi4/hJNP9dCTWap8nZmRMwDUnZz1XL7RfZuvaBe2gKUs4Zxl/FFJZC046oj6gI8ve8gBigSB4rmK67sqAbQ+6mw2Y3YI+gHuZ7TuRhmkfxDBl+shb7+Pqt8ygK4MWO+yPnyyWyaXJojmosNSZdnkSCqzusqqYGN5Lf99kbYiuZ+fXl5MTePl26rqWqR5Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2gF34zHGQhAiE+qOW3zUC6g7lbjiTV0/SimCcSCaYc=;
 b=CMlemSmIUOEROoEYdmRX1hWxS3gLcsvFMf26kkPq6i+UbrEV6CNpPBROn375DzsC4Yy5IqawHuqhQ/FC0cbRDSh8GFQjzjG1eSyRCZu2h66NynMbqfeqM8ofbS4HHNgHIqgRlccn9t9kNClID4Jl24KftGMov6Dkh6/8mbqeGGI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB8613.eurprd04.prod.outlook.com (2603:10a6:10:2d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:25:23 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:25:23 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v4 3/6] adapter: Broadcast source discovery
Date:   Wed,  2 Aug 2023 16:23:52 +0300
Message-Id: <20230802132355.4953-4-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802132355.4953-1-claudia.rosu@nxp.com>
References: <20230802132355.4953-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::19) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 4af76671-044b-45ce-efc6-08db935becf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tL54uulogXI3VwJQM6I0K2rknKgLZIO6xsjA119eEtsnMzunJ6a8068iZZFjL2n0Jl+butLhqNFINrrj8+tYbxG0uq8dGeW5dQPdc1kscdnr7D0iOEX24wleL3WcXV9LoKMW/6xQvN+HsrTSzMMqqvUynWsj7cyMIZ6UEscYwkz0ONHRDhxj+/CtXcFotN7nsuVy/P7raeFbumWA1kVtpZ6V0pFeBx4/AMWr1M14WYnci0Gy2XtwNEmpmbT1vGlVOEXbExq5xmORfphXEq0uwyAY/3vO10Uzes5W+KF/BaEqbdwPOIPT32FqovcCb571igSEiVd9J+EVNoV36Ni6yoApMlzUMlmcb2mtFjojSJoKjn2qqloE2snFUqWO6vQmf1qL9zPMev17G9ToF7Q2zzSKIGX10sXNr9+YCvRLncnMaeuXEedWmqd2YglUoowHQbYcPWMHoK2COwaCaSLWupPz3gXKeenKLG5WsyfxQQa22bkGlrHpzVnHm14vDqL97tce9SXL79ztjO1kuw2GjxqWJzOg5Ch4gm5VRwnHv2rLJ/zwCgXm674nRBo8HfvH6j0G7r9iIqjN+IrWXK35CneYxW4KitBKWOv2lsYgz0lR5NJcooU8zo7DuNnFbVZ5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(86362001)(36756003)(66556008)(52116002)(478600001)(38350700002)(38100700002)(186003)(2616005)(1076003)(6506007)(26005)(8676002)(8936002)(41300700001)(6666004)(6512007)(6486002)(316002)(5660300002)(6916009)(4326008)(66946007)(2906002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wz4AWJ+XpCGXLtSt2DWblQ8Jf2TiYXfw6pX/xrXdJbTnC4/5rcu8c6YVGb1B?=
 =?us-ascii?Q?JlKQzwfz9Ix8jdscwtlVzArIZabTXOTYZnAIv6c7Ypj911Wmwe7QyKhFR6fb?=
 =?us-ascii?Q?aJ8jTFjmaQM0YGwaTlqLnLAiYcPCleIHM2ME8nWh4aveKdlAIL0E/kkCX9Yx?=
 =?us-ascii?Q?fEU3JvQ304WroNbY4ZkVZWAN/SLb3L5CiCG7NgxCYuv+6h+tqPWp346fUJN6?=
 =?us-ascii?Q?/siY0y32Pog55nodCIeSAmjHW/00ypMqdZZXI9VMBddj/nqxJ9+w/wfO1d5l?=
 =?us-ascii?Q?tgS0owxSDLgjC8Gwcz6P8ly04i6kcyKPTk2jo/qk6yRBv5F+sB5lqopADkS6?=
 =?us-ascii?Q?SSquBQacd4OzhWF6uFyhGeBbaGXuwlid3dK7yD4xYv9M8EFMR3lUQhDXfO6b?=
 =?us-ascii?Q?xNgc1GPIHSze0gSi6L5LhL028urfG+dPnyWKBsBmuR/CD0jYKE4Z+H+qjzJs?=
 =?us-ascii?Q?jCLRNd5AZmHulAPMOk7LNYzI4JO1YPCwv4UTrAi5+dkatHhGf1tn1bufLzzf?=
 =?us-ascii?Q?N04iP/L0f854rxDk+P1jlRlDB6JxpQvejvnctzDMqvr2Fbyx8T4ulNhJqY4m?=
 =?us-ascii?Q?7tFemWYy4tqhIjVA4V5qf5qOUXjpp7cpHj2NcYYhO4YFeqpKPXV0cDsdlqiH?=
 =?us-ascii?Q?q5ptfitda6xbPf96frhrF2lAa8Pl6bw0nNTxqQHLM91wSqDpF2im7+nSHBXz?=
 =?us-ascii?Q?nPYOF/W7VbaoYQ9KakljmbPNfWlrmal5f+JHnRMGJxJOf+HXw8qNEXVXXqAC?=
 =?us-ascii?Q?6erouOuuKw8RPfbkn3+BLE4bXoIFd8AG1b6DC2xJsyEfEi/XIzFohg+/Iv/k?=
 =?us-ascii?Q?gf9fLV3ld1Zcxv27Lf+G79tOrqAnLTcAXARdL6z5g91G2MdgGqqAkyDwIvQy?=
 =?us-ascii?Q?D8ywzmtSQtDZwnRv6e53Dt2NqJACaPtPVw/6Z18CrwtVySUk1WVqjuAxcF0b?=
 =?us-ascii?Q?aZGRmtonNtaQcVStv2Szzc4Y6PxLKbL330UUvxxzpMJG3t4QWwEzlh1qLCwq?=
 =?us-ascii?Q?/AcCpuahJbwK0hN0LZ8B/UO+Xd7j2x7QIqomLDfzbsJDsNMX9rNJqrZw/MaR?=
 =?us-ascii?Q?VA231FodCq7S1uY9WpRpsZgE8geUQo4ZAcXvfMLBxomifWCcHkUWRSmcz5ln?=
 =?us-ascii?Q?cdPQM73XeKJiVnJSlw080voPH+tbYT0mXKRkvLyoAbPzVQm6SD8/ANHjeRf8?=
 =?us-ascii?Q?CjvjwclkawAnEf66bXNc6poqBf4gb6/evDdvdrArUPX7+dH7lvOuTlc3Mpcg?=
 =?us-ascii?Q?BN4i4VGmuRZDd64Ako8n2jKbKFf17o67B8JBDZMj0YvRvK8Z9PfAv6JoxT8X?=
 =?us-ascii?Q?qGHVvaPDjAeIw1E+Z9F7xdrRlD9GlpgBktWlacbowuWY26AGX/HJ+iJ1BC52?=
 =?us-ascii?Q?/cWUMeqA1QUkMjThh8/ZMvSO/VtKqVFkTT7gf3RrW8pzdhHhfWUJh9EWxJfa?=
 =?us-ascii?Q?nOmDaX9Nwn0D8NE+u7uL0YzOwMpDIpI9l1rnNR9+hWFxKlO/zcxuhuTrVTau?=
 =?us-ascii?Q?P5JoorQAmK2H1lCl6EavdXLL7Oth0oaTKngJ9D3r+0/dPXqrfPr2C8z/LKfU?=
 =?us-ascii?Q?pBPtWz8+kn56EiLG1iNvwcGlwMyxqlez2MjBcTLZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af76671-044b-45ce-efc6-08db935becf6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:25:23.1736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pMJddyB/+j+DL9N2KJsN9HBRup5jz1929NHIjJ/LR86jo8pR6N1DaY36keHDkFjacSLQHeu+Cct3JA13Ji2gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8613
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a new method in the adapter driver, device_resolved() called
when a broadcast source that advertises the BCAA_UUID is discovered.

---
 src/adapter.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 491bd7031..29c6a576a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7029,6 +7029,45 @@ static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
 	return got_match;
 }
 
+static int find_baas(gconstpointer a, gconstpointer b)
+{
+	const struct eir_sd *sd = a;
+	const char *baas_uuid = b;
+
+	return strcmp(sd->uuid, baas_uuid);
+}
+
+static bool accept_bcast_adv(struct btd_adapter *adapter)
+{
+	if ((btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_SYNC_RECEIVER)))
+		return true;
+
+	return false;
+}
+
+static bool is_bcast_source(struct eir_data *eir_data)
+{
+	if (!(eir_data->flags & (EIR_LIM_DISC | EIR_GEN_DISC))
+		&& (g_slist_find_custom(eir_data->sd_list,
+				BCAA_SERVICE_UUID, find_baas))) {
+		return true;
+	}
+
+	return false;
+}
+static void bcast_new_source(struct btd_adapter *adapter,
+				 struct btd_device *device)
+{
+	GSList *l;
+
+	for (l = adapter->drivers; l; l = g_slist_next(l)) {
+		struct btd_adapter_driver *driver = l->data;
+
+		if (!strcmp(driver->name, "bcast"))
+			driver->device_discovered(adapter, device);
+	}
+}
+
 static void filter_duplicate_data(void *data, void *user_data)
 {
 	struct discovery_client *client = data;
@@ -7152,12 +7191,21 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 			return;
 		}
 
+		if (accept_bcast_adv(adapter) && is_bcast_source(&eir_data))
+			monitoring = true;
+
 		if (!discoverable && !monitoring && !eir_data.rsi) {
 			eir_data_free(&eir_data);
 			return;
 		}
 
 		dev = adapter_create_device(adapter, bdaddr, bdaddr_type);
+
+		if (dev && is_bcast_source(&eir_data)) {
+			bcast_new_source(adapter, dev);
+			btd_device_set_temporary(dev, false);
+		}
+
 	}
 
 	if (!dev) {
diff --git a/src/adapter.h b/src/adapter.h
index ca96c1f65..ee32f7110 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -125,6 +125,8 @@ struct btd_adapter_driver {
 						struct btd_device *device);
 	void (*device_resolved)(struct btd_adapter *adapter,
 						struct btd_device *device);
+	void (*device_discovered)(struct btd_adapter *adapter,
+						struct btd_device *device);
 
 	/* Indicates the driver is experimental and shall only be registered
 	 * when experimental has been enabled (see: main.conf:Experimental).
-- 
2.34.1

