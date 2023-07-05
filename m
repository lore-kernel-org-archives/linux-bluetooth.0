Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8454EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 08:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjGEIwL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 04:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjGEIwJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 04:52:09 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6961AE47
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 01:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EUcTrPWbpngVCb2LvVKlOb0SSF3mAnrBlYzjHZ8HzfFvsEZumF7op3Xf6ZApu/Af5USDbqImP1JovvpsqYROseCpaskDYWfk6va6Ri4Os5DV76dzqjNaIKWkS4LBXFYqvvv9xydPij49Pgv0gvnZGNwnUcP1PaEgTdX2aKiSyKgEWrwLOvujh69meZ0ny1BMoU3xxtOpgzsHQuTuUp/mnaa5kOdxJIqThUspd7l2SBwFuzgkGHy2/ti0eMoSzhJpLwCcH72vytdb4L9kYi+KrUh0Qa2Za7dKcTHdK5Ls+up/8RlIL293WBMmVmy0ckE4iesPrC66cNuaZXIl4SoAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X5Q1wslN8niL2WakhQKoHYD9KHuHkSkR+IPBhPR70Lc=;
 b=AytqbAC6w9GYXOeBOZY9wJXP9Ey5rTMdGSC22a5rUKCy5sC5uvcgUdABa9wDa7U9cLFXLJfM4O30Su92dI5GAT++Q6hcMftOdS130DbqOXs0LIxvMduj+jArebj6T0pGJnD18NFuJ+clFAInJlPqNDVZ0t51nxroR0jCKYx4VBPqRnAKykK7GjeVKiOtTs02u3sb7/a/oU/YxcbjtnxT9pFLaTvuFmwG2W4JZjbEp83y/z2cFM6opadcdRSGo2eVTU/e4fLp9dBubxAgZWYsVZu3Qj3f2ThIipNgn8En0JJ5yUW/V0QT0Cbg/sgiLoSPbrxhLItoB30sICzX9Ev5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X5Q1wslN8niL2WakhQKoHYD9KHuHkSkR+IPBhPR70Lc=;
 b=pgLG3UWQtAUbWwIx6OYCbZhzHCVErUIDpFVRYYNt74WH6I2LQGf8qQnzMcFV5FkA4/GJwmpGLKPZ7gr0/wD0CSlylAODmX7sICqriyLoA0aU33ZC43NCNnji7dwPeT8u2hC9HrX2osbTrlW5nirIKAJKn3Df+Ax852HImsuS1HY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by VI1PR04MB6846.eurprd04.prod.outlook.com (2603:10a6:803:12f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 08:52:05 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 08:52:05 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v2 1/1] adapter: Allow broadcaster to be passed up to application
Date:   Wed,  5 Jul 2023 11:51:31 +0300
Message-Id: <20230705085131.6643-2-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230705085131.6643-1-claudia.rosu@nxp.com>
References: <20230705085131.6643-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0022.eurprd03.prod.outlook.com
 (2603:10a6:205:2::35) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|VI1PR04MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c55ab05-f515-49eb-0f2a-08db7d351b69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKUF/f1AaHbZgyPgUaE9eY1wpN0TpTYbMMOH2TDpWgCaz0TN8XG5BvCza0IHkQgg/UsnWmnEgHfaYAUgE1rEihWv0vgXq0IT0MKN/zezO9msC6dZ1J+sPZoPGgp05GjpO96mWu7Bo2L+DBbi5TH+MEbz03nofVjxectvVaLmaCsyD6RQDushS5lAZzdA5sN0gdRqzF31JWS2kZcTrtEQvtDuhiM73yDZrz/yBM6hqhoqkfFdU7n086ccmlUxsAHRU+MEMVM5A20mKK5u9/qUyJgwVVtRgV64uxv2vUgFPkUM3bSMzVIFNxbROMoxl0Eqg8EAbVFC5Fp+jTBOjKwDq9DNaclRdbq17z2lur4Ct4SfM+6eLV2NZPwBv/Ux48OYfzKjKyNoFc7EGb3DznVmNpatgV4tbJtn3D0QNXwDp7Yiqnjtfnqc+s6k4Y4PeJsY4vioWLDehqEYRFXgGp9tO2aLUDvHkf1hM7knpADmGKJlUslqn/uhOLL+r2cJPHlvg1U/PuvAcww4DGCUEWVFir05ULY91QiCeMSY3pS1LincmZV+Iy9ON1G9ojaDwz5CpQcUealqu3wOQA8+fXIHEik2PU1tGt3z5CNOQwfOG3Qv6eSKlt2tCwtgdLvHyLwq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199021)(6666004)(478600001)(52116002)(6512007)(86362001)(6486002)(66946007)(6506007)(38100700002)(38350700002)(316002)(55236004)(1076003)(186003)(6916009)(26005)(4326008)(66476007)(66556008)(2616005)(5660300002)(8676002)(8936002)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cGsHmfsWhwyxekts+/iWIpKBSaBImvQH1e147m+D4sVgA/3X6dSF2YG8eimn?=
 =?us-ascii?Q?D2LGrnbQSTc8udEsd6npsDupa8xAG2masLaJaOzqtDo8T3DkU2TRv796izDY?=
 =?us-ascii?Q?CzRkQC26KafT2YvMo4EMVMJc6pC4migomd0FLI+J5a2qI30Q/wtQ7j22CbA6?=
 =?us-ascii?Q?6N+GWWn6IK9o6ru/MkKkanfdDVGIQxQNCZV2t0WA3+gMJmjLZnTJFxfkw8QL?=
 =?us-ascii?Q?e9ZpSeDjZ9zXxumsJ3QBx5xOOTBLdjlm6emAVodk5JIx2sPUnLRidjC5kHfp?=
 =?us-ascii?Q?idPnkp4BF4JxV5OBoM5fvgdrAP+957YNthvi0RUjc1f73CT5Jnle2D2ZEJr3?=
 =?us-ascii?Q?y8Whr7w4y+6wSTleqvisft010pAjhK5Whmf4oXwGDIuEJ5IYHAR6Plz+UgiC?=
 =?us-ascii?Q?ENMCgFr/03PdL30A/QsGMeLNlWAHq8/I5jzzOiiRCRN4gNlzNZDKko/ZYYhW?=
 =?us-ascii?Q?5ulOEO0CErJU97RWtGz0gMWmADd6RIlftN/OrxcfqiCtr7tHJEBttyFtTbaY?=
 =?us-ascii?Q?gsb0IocCzMAqGf/d23OpR7SLtm7by8aI6MVY9llc4d1NFC0tqVIKPLpU0JaU?=
 =?us-ascii?Q?VzzVRaKAhaXRpKuDybkcEcqjsLVxMAAyOAM9K86RQxpVbfH+6PQ5EYeCWN7z?=
 =?us-ascii?Q?0leUqCaJfW0tcihFg2N5TvFz8fn/QQHVi+NNYHtAOFUtIVH7N7wbzirdK4mv?=
 =?us-ascii?Q?UQQCFhuq2quXMY+UVy1Bcoq8HaeOWaB9H3+NEEeNm7xXLzZ+XCm5VA3LDLrj?=
 =?us-ascii?Q?rG3Ow/pv80ju1eOVhvfYmj0toPibAs7xEZhRw4m3acuWbJ221U/Z/dmc2u6w?=
 =?us-ascii?Q?F9EYSHo7nYWT9vHu5vA9/28B28QVAZHLgD1Rn1cUcN8KTbdeVFeeLh8WCDYE?=
 =?us-ascii?Q?JczyPp/BkKNY1JsETz0HqFwMw8sTkX8nCUJ9WyBdtvkrZHg3q3XNv3iMLyqV?=
 =?us-ascii?Q?gWXCPT9BR11P08AdtuEP3XSVlXabEZ9tDyMjAPmwpu8R5yxl5R9JOUrSyoVn?=
 =?us-ascii?Q?tk0hLLW0l+XmO/qd5N8xMWs4xGyp5UkEVdHPV+GBFVpINes0CfprZCrwwWpy?=
 =?us-ascii?Q?23z72LThIArbvX39N0l+JBzUxZyGDPfP8btR2CETEFUuaMD/4cdBMiie89uu?=
 =?us-ascii?Q?nXOO2r1rroDvtosBjen8/KydPf3UeUIfEU4k0EZV29FWXpzvC1T6mfXEwQre?=
 =?us-ascii?Q?tOPnB2a3+/MIkMY5BP7MJou20xP4j1QjsIgKBSOvMKZv935bdwh4L5bbucPF?=
 =?us-ascii?Q?ISWjga/RIVprqvpNN6TAQv/KxXsF6gkP8uR75fsTUE1DdWGHFBLqxXuXbqv/?=
 =?us-ascii?Q?0M04+LToJIBFaT2Qr+bye+d/BiO/eZUqLD46JxGC5SiGT57+lhmtY/C1mqb1?=
 =?us-ascii?Q?Z1UZsbW/YAn2guLpB9sTzgtdHWHI74K/YGtB6FORqUEiur3s/6GDyndPbzp6?=
 =?us-ascii?Q?l3jf3okoM+rxuM93q1Y5eGTPS8Tez56WSJDPukCpc94bgO4TM+I24ag2qGoy?=
 =?us-ascii?Q?2JH20HtysZp9Lp44XmGUuVUiDz0LEWunrSlK9+qJd5ttX1UQ+XDneuwnwqOC?=
 =?us-ascii?Q?69s6j1yc2ly+EMLrk5GBBn4VEEj9cz4hGVT3tCNS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c55ab05-f515-49eb-0f2a-08db7d351b69
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 08:52:05.1409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6hJOlWenmJnzBNQ4hV3I/X+AdekOmL9IK8Mgq1PfZwH4BI3xZUhPYha0XKRXjfXhcnvg6a8BFs3sHTFmXvq1FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6846
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Allow a broadcast advertiser to be passed up to application,
if the scanner is an ISO Sync Receiver capable device.
This allows for a broadcast sink to discover broadcast sources.

---
 src/adapter.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 2679d4302..9c971d488 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7031,6 +7031,16 @@ static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
 	return got_match;
 }
 
+static bool accept_bcast_adv(struct btd_adapter *adapter,
+				struct eir_data *eir_data)
+{
+	if ((btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_SYNC_RECEIVER))
+		&& !(eir_data->flags & (EIR_LIM_DISC | EIR_GEN_DISC)))
+		return true;
+
+	return false;
+}
+
 static void filter_duplicate_data(void *data, void *user_data)
 {
 	struct discovery_client *client = data;
@@ -7154,12 +7164,18 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 			return;
 		}
 
+		if (accept_bcast_adv(adapter, &eir_data))
+			monitoring = true;
+
 		if (!discoverable && !monitoring && !eir_data.rsi) {
 			eir_data_free(&eir_data);
 			return;
 		}
 
 		dev = adapter_create_device(adapter, bdaddr, bdaddr_type);
+
+		if (accept_bcast_adv(adapter, &eir_data))
+			btd_device_set_temporary(dev, false);
 	}
 
 	if (!dev) {
-- 
2.34.1

