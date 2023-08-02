Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7D7C001DE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 08:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjHBIm2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 04:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbjHBIm1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 04:42:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F682121
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 01:42:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ML12gTEXMzonxiBtHJOsiMvcjlCjpUG2K45jIWMzRHgkjvtGnTxxllomx7dRj6qLqE6mQPgrso0qIapz02QGZZbp9vLoGD8kQP6ScKIUou+M/YtPTvmirh2T1TOYSys0bvc/6I/8WrChDEDgb7nZtPJlmobTIAt0/NdkRemYxkm6aHCKBf72ifkgeI7gU6t/JsT99IY3ME5Wavgf54091PIh1LNoEeAnt+yhw+c541pN6xGb+y4kYb7Up6q+wiUFuz2xhB1fFa0BfkY4xea8JrehY1ROT2RiPHMzPV/AzW3oZYNH1KfylG7ggU7qx4JGN/eAonq8/AUk8ujei+YeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OqfCzjm1oA7lEogXlD/Y2Pi7RYif+KEFmg09y5U7KI=;
 b=TNw8KYiuC6IRmIiVAeSdz9ovWWNMk/s3cpCi/PFyCuKTfoBd2VVAE4HAMOR0pu/Mqts6fxQUifL0F+ahjUGG2L5sL9Ueu1w7UHpX0n+dX1vrYItlp+9p7ebNGi+WdY1elfyu14pXqH5qmoAwi7MRBEaa5GyMpQpd5ontKVs/XTMoyUu6jrqpkYdaBTEbUT7aBJ4DXSGDsMp9r+OoYCle4XJtxVDD76MIgSm2jJpAPOCoEQcjz9VmBICsEqeV/6Pc8yawydvQExCft8BN+G6GpW9i4o8wfbcgVxgcLmCLklHIV5se1MJrm8yO6Ybwnu07Ffwe9JRPWIoDXihJ5s5eng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OqfCzjm1oA7lEogXlD/Y2Pi7RYif+KEFmg09y5U7KI=;
 b=qO7cQ/VcgnSZ+EAblfFX2hhMl/dELIeKDd40wW8x9+3F+HSDuAKiqPzIlXAxcnlrDCpW931u/lzmZkB39RLxbHXhuoxACS1H22spHU+WM/kP68Tbxv2Ygr8aoyy4a/v0J75bUt3AIH+LFfNTypKuJCB1D3wibKDBm9c6RfQuFnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DB8PR04MB7162.eurprd04.prod.outlook.com (2603:10a6:10:12c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 08:42:11 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 08:42:11 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v3 6/6] adapter: Trigger adapter driver when a broadcast source is discovered
Date:   Wed,  2 Aug 2023 11:41:40 +0300
Message-Id: <20230802084140.51105-7-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802084140.51105-1-claudia.rosu@nxp.com>
References: <20230802084140.51105-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0003.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::16) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DB8PR04MB7162:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f062a7d-e262-4c80-38a6-08db93345cf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0zeqnDjXcKYRIr0qj1r0gAcK0t0gxLZDwEbUvlXKquqojESBK/d4TvkqxHZxNMQN5PVNSaew3Ho13e8T8im2c1kZZWypigRbmQOKhG/GgKPAuhJrXgz8XsrLzX2t7aqrF+mhe1/1jU71rBFbACYsZ4ifW8BLukMlvR/h0jiSQWtHuUeyxhhfcf7bzCS5OBVFV3b6h+6w6yfp9FvzgD3k+ek1eZ3qCBNeCJK+xqZaSmSCtqegxPcBmYxtpR4Skpn+j0PRFv/OwonZVgyM7iP8PaNTJkJ2s4KBfpKrPHpalK+MGenn9vsMsdcnekAmYqIxNsa3MfIJxD9/Fidtx/8UXEAeqazJDpajFpqCme+n6+/EvUmDTeIzBW63cTtSshuMc0sSGhaA2MdA2cwAgyz194QxN36I1ms4JrQzNdAKDlIfqqfwpyeJg6vikfPKiBS+Ez1B1vozT4wo3ci0TeJUT6FnKu+G4pEbfbF5QTGIJuT4o21rR3eBVwcYXiaZdFNHxXGDT1q6EfAJ5fOkCqTTAMe2nv4mFXs6x84oyJjL+d+dAq61ORzF6XwP5Am5Ne2vNPHrqFwfefWV5Uav3WwYzk60ix8YhuGlgILeDWoFbUWB18wIUwGjUTUx2JgPSS9a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(2616005)(36756003)(6512007)(316002)(478600001)(86362001)(38350700002)(38100700002)(66946007)(66556008)(6666004)(66476007)(6486002)(52116002)(6916009)(4326008)(1076003)(6506007)(41300700001)(26005)(186003)(8676002)(8936002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3Y+6LTysr9HLDOsr38dFx5zWuzY2tLlW2BDnjCLfMkuNW4AnrfFpPXpHPbJx?=
 =?us-ascii?Q?gLf6NjcF4IN/eQ9XwmZ2InV3bAlpCdjjgTYZLTW3GoUn0Zp/+Rtfhm308YXO?=
 =?us-ascii?Q?m9rbers03Bcfa/IZDm+ivkGrcLdwDUYMA8U9Bvp9VhQn/0hduJ338stk5Vx0?=
 =?us-ascii?Q?3loos3eoAgSvzsvGK7uc0zYh8fAg2HEZYy8hqNfvsYLOfVKnYhCJhc16gklr?=
 =?us-ascii?Q?ZlvD3wuPUiTEbXe+uGFtJtHFh8jUmT84HuIhuPi8MDOL7XnIlPNx5GDOcJhw?=
 =?us-ascii?Q?kE56WMT9mkf4TmtHZy3+BAcmdI3qC5tP/4Jb+eAjDHyMaLcJfT7r3LbGuPb0?=
 =?us-ascii?Q?WkDO7z71C+ptGIn2tMFiaWdw8PevvnVng3eX5KllqCNw2t4ibPzVCXhcb/cL?=
 =?us-ascii?Q?uF35mrS+weNx9Eq5+VcS4DtQGHxdejYjTn3QdoJEcl4GD7vW9EykIeaJilj3?=
 =?us-ascii?Q?Tl8kfFS5cVJKzqBScTTlWbIHjwIGN4kIVhJWwvE05hbWzpSkQobIuy8fZubk?=
 =?us-ascii?Q?Vb8ZbJyzyG1fFVEhsVVGPiCncy+DMEgHvnEDFQiFGT6x2Ti7kS2r0utVnvny?=
 =?us-ascii?Q?sG2rL313nb13MDMw9arCNeUJLE8s8YQHe3a0sy829GlsaOx832lKNBLQNF/o?=
 =?us-ascii?Q?h2ruTKSy3mK5ebb4zFrBUyzSCakcQWV0G0vhjq6u5Hwf3T62l8UhTb3wq2Gf?=
 =?us-ascii?Q?gc5saaGcTwoko73VR7td1DBtyyxxR/8+y8tOPuotsFXazsNoqA/vCy+ERSUW?=
 =?us-ascii?Q?IYeH2ugGB1SqSJz5TcKl1q2S5G7/sw2lgc4QUikQ1becplDgq/r4dneMoPRC?=
 =?us-ascii?Q?QhWBO0GZvpqwVnaFXJKoZTgodUeCncFSfp0KC3yY0pInP4yb9v+l1HnwTNrz?=
 =?us-ascii?Q?tbtNX42+h3EitsjtOkwwMrTOF2Zwn7mX08AthW3joU3qOB2R4UTN/DGIWLQM?=
 =?us-ascii?Q?pUdktl1G3lmIczFkwjJzsjzTCDc5fS9t1A3oFMSl60/WT5IGmfThyOgJtlUD?=
 =?us-ascii?Q?hDM1jN/Krf87nfMjdKpUa5LiwOZGJJtKBhLikVY4hExo8Kbwd5zciC/nf0sH?=
 =?us-ascii?Q?870M3TfZBhVjAGa7F5lLiO3VVCcO5obwRB5WWeV8FVIQXtTyR3q3VvjFJqUZ?=
 =?us-ascii?Q?FJW2dD5LRvhVEit8yKSOLHVoHz33GCbJIMCzsrYU2O/EEzinbJuwstAO/yFK?=
 =?us-ascii?Q?dIk3+7w6mzl9r7hM6jQ4Tmhnad2Gb+ocyaQcdSrvw7bf/9q4tkirppkoZAwd?=
 =?us-ascii?Q?pe/SVKuRRkhWq+g2X5dp8p4dzPAgw2zRBqEq1CdtvTBwo4xCPZYNVQ7mLasl?=
 =?us-ascii?Q?yUHEsQ7bVSvamBn754CB3Xv79U8eNPYZ0tyttEgYJHok1d0HSImrTJxtGlGb?=
 =?us-ascii?Q?nXikyj6DUp10wazUS3nBdJAjDIAwDGo9QfUm3onl3+CVV47yYpDKjkJYRvv6?=
 =?us-ascii?Q?jq6Koe4QFyavMT1ohoJXZ2wsrFwTq5R90I8mJ0mwKO8spspn/JkhKPYUVowj?=
 =?us-ascii?Q?yyGIiuU1d3YoeVWlP9sOt5FhQAZCtdCVWwQcjUWPTSjp6EvRSvoSsMue5dl1?=
 =?us-ascii?Q?kCUz163ljFeAyPXcuC92Bzy0PqTv/dtFbgpPDPD5?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f062a7d-e262-4c80-38a6-08db93345cf3
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 08:42:11.4327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkygVqZCj9xMyUYU/H3pXUO9Txr+YGZvXQ2X2mlrLP907g50aAjY/I3H7XPBXOr3fEOpn75Q9uRQc1MfuZ1LXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7162
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a new method in the adapter driver, device_resolved() called when
a broadcast source that advertises the BCAA_UUID is discovered.

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

