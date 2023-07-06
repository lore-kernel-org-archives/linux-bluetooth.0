Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA759EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jul 2023 13:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjGFNh2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jul 2023 09:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGFNh1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jul 2023 09:37:27 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2059.outbound.protection.outlook.com [40.107.7.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AB3129
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jul 2023 06:37:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OINXocktTRhQEESR50KAVibQBRxJztdmR/VSgOO5HEQzjllOEXZpiAVY3/wMbsnRfU8qhDfBxPLVQqlnh7tbMlPzyKgMHQ5y7S+0tUDkmeETOdpbbTms7sikjIhaWeGv68JazJ3H6IMH/Cicsr1JcASddqRrXuiF8CxnPStd+938D/vN8YdA5YiqWU68dOSzlyKcOcugRumyKMBOqvhNTyb/oM2Mk0fDrtnZGpBLyzOUnH21tJZiy1s366qSimlJ8MRUg2CkWuhcFtQp/2oZkvuwYyolyYiO791LqGOx9kMHeno174aPOr2pYphnjFDVisQCYtLfPURrktfbe9inaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90s8TEgOFGgkcss5bTpzsR80AyW2gC+SD+DC6rL2yg8=;
 b=iJPU0e57F0ZRLjMHWBknfMDrw/BVFgV5obCOfM97OLdsTUK9oO8BzeeDuOyVdrdeAEzrqmv2b89rBQ+EE9t35cvwXJ+8Rv0X+CyPBKaL3zsneN/2H1H9nMl8mh3b+NmGp2I2YEARJaNq76il321egG4k+VeXIBIuwjIXYwMWaXvWWftvFb94PJpot127c9pkwaVrc7j7wiNqvKn4zp/uTlkaAPRtxqclPkOPQ+pGrHCR6IdqmfMlwA583O+YIQ9o+Hi5LCfZZWd9RVzEW2Oj0Ul9YuOdbDIYcHQa80nkHGzIYTHTlV4u/0wO8JTc25bxCYSPIZ0RJ48DzmITySTc3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90s8TEgOFGgkcss5bTpzsR80AyW2gC+SD+DC6rL2yg8=;
 b=EwCYw8ywmCpUosH4nZWAfwPxqPaLVGgiUCNPD565lGR1V9l7rr3LkFV9DmxMKJpE9buR73L3VnVi0VDWrZ3jf31N33WkEG2muAFmBUA2Vs0okFvFo1M+TyHKEIHacex5IInlyAxI6YVgOBRxI9l95BtrXPbVQ45RcCrVl+TKr8Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM9PR04MB8275.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 13:37:23 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 13:37:23 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v3 1/1] adapter: Allow broadcaster to be passed up to application
Date:   Thu,  6 Jul 2023 16:36:05 +0300
Message-Id: <20230706133605.23325-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230706133605.23325-1-claudia.rosu@nxp.com>
References: <20230706133605.23325-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0109.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::6) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM9PR04MB8275:EE_
X-MS-Office365-Filtering-Correlation-Id: cf2db25e-25b7-47b0-b161-08db7e2620f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lPFZr+9VLFsncNF+fZal2qHm83jeu4y7F65jP96zBYUb0aArIj2qGLH7sXN7SVgw8Nb0bSnPF/DjajURUOGN89ylGBMiVBsvY2eS5l2vffgs1Y/XDbu728zuYsC3F0lPaUwPIcdX8BgbymFluHUMUBMo18bUExs9rFCO+O45NBfwa6uAD95XsVm9ea9lypMbQRXrRfWy4YVVhVOSSCVj66v7jS8uAj0cSzOA4habAvBxTfjJWEoacFTuSa0qE1ulyJStyWbq+psta3tSrx3c5d3fbbOpF0B4jqxOwiBXKLObKIkHkLlEXhr3OQcUuPd+EQN18OhFJtpk1Fxe8bmnRMr/yvOQtPXLltZ1/3rcc1NkVQCOV1HOlvmmw60DF2i69QWzjj4Oi97f4ujraH5/OVmWRV6O6V9oUf4pKfl3CMDYiy5hsU1S37M8KQ+VHzzJiKujVKm3bJCMcWJWyN+mQoTMrU5KY2hqr9YNbGZS7l54AQvz0pnuGG4Hi2cDBEA7FnJKOzzq3la/S0Lv7PdnxOzdudz/Kao5qPUOBRFaK4C2t38s7FduM4o8KuY4Qz7Pj81UeP1ursIk5B9gPC+f+8Dhnw3wOwhKHpZ6UR8Kz3npfWcz4G8ww1f8qBKezyOO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(8936002)(5660300002)(8676002)(41300700001)(66946007)(66556008)(66476007)(316002)(4326008)(6916009)(2906002)(6486002)(6666004)(52116002)(6512007)(2616005)(26005)(1076003)(6506007)(55236004)(186003)(478600001)(86362001)(36756003)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hFJieUvw5e7sHXG9Y3+o1x3og16yW+4ypViuBOvehMuOH6TXWW5loVmAQ7LM?=
 =?us-ascii?Q?zXZKTopMtsn8rlUIh4PrbcviOgeLsrmTpDgc4HTGE3p7EwffjAgoI3KP3dpU?=
 =?us-ascii?Q?c1R8gbygPmO673vrb32PdgBcv2f3i44bUYGX6M5e4r18cLUfRlK3rGG5ALDB?=
 =?us-ascii?Q?EtM4l5kwhR1/XP0rggrfLVQjbs2FjQXeTyKmGLV6o7LnqCAl2U6/kHuNgM8g?=
 =?us-ascii?Q?EtLtBzUAWLigcJRxcttjtnqCj8qFBS58uYwL5kfqQOmIH/1XiqZDbNUy8Cu7?=
 =?us-ascii?Q?+coRpyTuRDd1iSpRnLMr9zFoClCeZeCmnC4FYivgBdIv4xO88oe9tKaYVJlG?=
 =?us-ascii?Q?q7doOWl08JQtn87jrvVc+7aAPFTVnf0WcCKYT/BiM2pht6K4MgvDE1RZ2S+y?=
 =?us-ascii?Q?8+nlIUGs65mn/o/viYjBNafH+mrfUD0JcgCACyIuzHGkrEJBgXpr4byQIU/N?=
 =?us-ascii?Q?ei+rV2mgqQJ1/Eyi9LdVTQst0YT3LRewjCV7BLNvbllKITwoNTWwAkzWBfSF?=
 =?us-ascii?Q?zyHzdaGHXGaYP+chHCGAdATfgVGbC26fuOa46b0kLPtpMuoJhLVzD4oZUrjs?=
 =?us-ascii?Q?a17ysn+gZKOW2G+7SFlyoCa4GPg5Gmz0W0T7YU/i+/gnFI/LnyKHW+w6QJBg?=
 =?us-ascii?Q?ZaVva6VkA/XNABYWJh+YCDrbD0xqXFfJen0ijkplg58BjyPfXct12q4bwEDP?=
 =?us-ascii?Q?h1Ii7D5aveFF8KWLyp+7nKXOWM4RjJ13K3c4HpWWcSt14+tt+JjQ4dI+56zX?=
 =?us-ascii?Q?lkNlsDtxRBixAk1gFC96KTKN/6VKjMMye/X1BIzq2DYvEfe2fE3KDUtSA1Rx?=
 =?us-ascii?Q?v0/17hJAywU4xRFqFfSIWRvOZrrS+v/hQUK9azWW6pOieXC4v48zrFfRpw/b?=
 =?us-ascii?Q?D1NUO1dtZQV2xUW+Lb7oFrTuqA9EUG+ZOlnqt/gSeQ8+To1gXNDA53Qkzv6K?=
 =?us-ascii?Q?P2Pcj3b+qXMrk5KfGINgHdcULouSZRagSNRo9QxKwFEvJilX8yrlG779lzJL?=
 =?us-ascii?Q?voOp1udYYv9UBI20v7KPUB0NnumFrHbGZv2i+f+GOwMUmv1ErcmY9+WmDRxy?=
 =?us-ascii?Q?WoUHyeziFA9oB5KPq3U7muGBxv8FjYkl5MZn2/ynSSUOgftjBA6WrLhSdb+w?=
 =?us-ascii?Q?Uz86ZN92mt4i3SWPccOCwwziWzdpIvVBcWTBLiXPbKmCb4TQ6rEMIR1nUl3a?=
 =?us-ascii?Q?Mg1Cylx+YX1nL2GyaJLPVysKxXHi3hO1lynfP8RIKIDnVJ+/Nw7ZrvnsL9ud?=
 =?us-ascii?Q?haJMp4E6Bj1uXRbs/73XuECihCm4JJqD0c+FDKlhMoGANQFb0fX46n1fKMSx?=
 =?us-ascii?Q?MQYdaooVebcIMun7WYLlPRINpTW+orenztYAlcVet6X3+Jiwf3YUlw5d+JQe?=
 =?us-ascii?Q?HB1HP4FKgGOA5rJ4D5yNU6qIECc3Qv2gxBpISAmGSXYYFOrseqbg/ibJHScq?=
 =?us-ascii?Q?xTK5EpOQDG8a78QJagnYbYW7mbs2ouJApVqGbiXaB5adtZT0QLq09R+GOFk8?=
 =?us-ascii?Q?Yn2YZ6z+76Y92sY1AMNFiHRluXH5+vN/4VWtTipHWlZkNDpQaXCSDVfZWS+U?=
 =?us-ascii?Q?3FkhZWu3z+KlNEdZmW2wGebKsT+CQK0zw8b2z/+K?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2db25e-25b7-47b0-b161-08db7e2620f1
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 13:37:23.1220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZyJcTC+MPq7N1nR8/wMpEzX4TLs11fytQI2tSJwSzhnYxaT/WqFqzfQ9YL2YBYCaIJJ2czwVduXJHr8WbrciQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8275
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Allow a broadcast advertiser to be passed up to application,
if the scanner is an ISO Sync Receiver capable device.
This allows for a broadcast sink to discover broadcast sources.

---
 src/adapter.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 2679d4302..a48d73ddb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7031,6 +7031,27 @@ static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
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
+static bool accept_bcast_adv(struct btd_adapter *adapter,
+				struct eir_data *eir_data)
+{
+	if ((btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_SYNC_RECEIVER))
+		&& !(eir_data->flags & (EIR_LIM_DISC | EIR_GEN_DISC))
+		&& (g_slist_find_custom(eir_data->sd_list,
+					BAA_SERVICE_UUID, find_baas))) {
+		return true;
+	}
+
+	return false;
+}
+
 static void filter_duplicate_data(void *data, void *user_data)
 {
 	struct discovery_client *client = data;
@@ -7154,6 +7175,9 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 			return;
 		}
 
+		if (accept_bcast_adv(adapter, &eir_data))
+			monitoring = true;
+
 		if (!discoverable && !monitoring && !eir_data.rsi) {
 			eir_data_free(&eir_data);
 			return;
-- 
2.34.1

