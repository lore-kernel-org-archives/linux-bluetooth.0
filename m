Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B975FC001DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 16:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjHHQZp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjHHQYd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 12:24:33 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A58A5CC
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 08:50:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0loXT0qo8UfMM111pB+oIFBi9/cMKfulQTxko5VbEs7lVAfZGiQo9thWnp3Nz59/smcwA6JPthGhN5LPS1nfs8lIGEZ/I+ZA04tUwo8XQ10264MnpeZzG8bVPvdPNXT6ZXE9ELhDhmtmqzgh0xtbgTgE8Ous2mT6Djr/xaMvIyleHh/KqVSDrJFNtrXQZgWyMHWjRYIk79Nbb2VJdb4zcLEuAJ2dADEp0BN/gOw04SGFEtpfb7ziZG2N6oOjFtjWyzMfzIKR3wunCTPS9LcZ+0iU0n0pvNk86SEoNV2kCpHj+E74/17j+oj07IeotfZAJB8j9vwN81ZhZZ4CtDNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5bHrovpbdzfJp3RkXhHxPtOX7ZHh/SFYq7JwevtJlc=;
 b=R7SBuJYKADZJQKJ97CzWSXz+ak8orTCc0YfIQhI17ake/00ALK4t3Ikiun1T39tvFMxJVC2BenLexqvMKi4p4EaNOo6ah24fzS5KBo5hB67yEFCchL6ka6baGBYXw1bAu2jqrqWFc6RVdIckcjVxPDSLnIlDn5a7qw8DTerS89y4e26M7y2w+SnkGPYz0dZsiPQtqhb6+sIYVGcVKcx0/N0PkhVKAJc5BijUvMpuRRzPP4+zHmDWMJrLqmCMbi5ovAf5HphAVHKMchxTdce4pxxPRDDLrCD5nHJe/HwyqLOBTU64HjAELy6NXRImiZp8TF4qrJJUrXt1zNH1ysZAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5bHrovpbdzfJp3RkXhHxPtOX7ZHh/SFYq7JwevtJlc=;
 b=INyWMedVTfmVwpIB9COS5A+wiQL3m9AMTA661Y8J9nL8UbdzmpStKVj6stjmk4BNgKPGoFDVxHPAcSYX/kZ93XmJ22M3GvUWUaUPJLjCV14+DM82ldzPmWRC9fAQl5q3vzoh8UOOvHdgEM5DpB3dkSYvpUpjo1S2B3UQzIOpiqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DUZPR04MB10062.eurprd04.prod.outlook.com (2603:10a6:10:4e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 11:53:06 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6652.021; Tue, 8 Aug 2023
 11:53:06 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v5 3/7] adapter: Do not filter out broadcast advertiser
Date:   Tue,  8 Aug 2023 14:50:36 +0300
Message-Id: <20230808115040.4403-4-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808115040.4403-1-claudia.rosu@nxp.com>
References: <20230808115040.4403-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::6) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DUZPR04MB10062:EE_
X-MS-Office365-Filtering-Correlation-Id: ca60772a-eb4d-4ea8-c99d-08db98060750
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K9DZ5F1WayevU8KvHtehuGrJRb6UQSc+AM30CMc9i9PEfCLNDmpeaBEY/TBIc1aYRzLYNpaL1LcmfsGiMEyrSHHO5ReNlCBSKOvcKC3sPPbc62iBN8qrfkbO0tWIDyWD/bdCm5MyFkp82mo3y35Zw0o1dxzQXy7Aw1yrgWt7PJrWLdrbE1A1LXwzwXy29LqLHuMlMXG9Jjc8ttDIAfiDBWt1gfH96XsDbI8fs5GtCbf4lISdq917r8PQRbgdLW/RGxF/SOQdQCkEQmuOc8BAZbWpWSh5E01P7qwDn/Xo1iG00Mqc0SJjdBAPQi+ukM/g5HxY7bPVVFIOUPdgvxS24wbMOqhc+tlTpwhbCLRbf8cOH1SsYDz77IvUS/N0JjLmspgfsb+i7SzO00GFvcGqmqCviPujkaKDy6rNAzrA6lUicPC62N4Nt7Bxg4zrWsAdR6tsNVUPNsPqKy4jlPsRpGrmwdhmtlwICbQ+unmA3731mi7VnYlLczjURvDAM2hgqHEEO/ZmCyL3sLj1Jwd02rC+thojsx5T+/zozj3TMMipCWfl5pgck4abZrLOiI+Em9Knd/IpkeMaNnGuNxv7LTXS2nNfG/ayi2LOa0M21frWyGIdvmBj1ZpOGfNXsQWg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(1800799003)(186006)(451199021)(2616005)(52116002)(6916009)(38100700002)(38350700002)(41300700001)(2906002)(4326008)(5660300002)(4744005)(316002)(8676002)(8936002)(66476007)(66946007)(66556008)(6512007)(86362001)(478600001)(6666004)(6486002)(6506007)(36756003)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rOoIoqG/UN9uiEKJYUqV0vNp9G/dN5uE1421JnNvVnF5iiaEYx5B4YAGBRP9?=
 =?us-ascii?Q?994P3YMyc/DX30yamdp3f//PsGTiosa+xW4tQwzBBzV7lNyNIT6TNdzX43Gv?=
 =?us-ascii?Q?sGFZbRM3mgDoji+UYuoj1a1SoaUm9fg2xpymeXzLslMnLG+0wkClnORgyAj7?=
 =?us-ascii?Q?ZXcrmfFi6QXrSBXEk5yAmk9sKmPMh16dVMtrvJQi+1LmNvWWgcwYZRzXeW3I?=
 =?us-ascii?Q?2KPbAdxI3xDLskKbYHR4TfHIA6BqgvBPUsW3MPZ+vjrYnfLA675SLbaBq3b+?=
 =?us-ascii?Q?fiJwc+gVuad3u0OET+f56tKZcYvwm/TnALci20x/eGCbsxbrqidK/PgBCRVq?=
 =?us-ascii?Q?eM1Asfs3DV2PwTlmyTvD2gyiGLBtjBdJqWeDyhjjYG24I0S7/Z03/BLrkJWp?=
 =?us-ascii?Q?eyrtwe2+g2aAaSQFjEMKabKZ0XoWXKRT9YUVUf4vK4vwiGz2WloACkB7+C2W?=
 =?us-ascii?Q?/2w2UIhtqTJ8YlwBHvIX+qfSZ75K/dkpYTFUjitnVL8Nwmsfd4xEK9Rdz+48?=
 =?us-ascii?Q?ducPZxv0nGrtENAsuWWirexUEmFyxAE2YIfhjxNvqNz78BhH8Py0uHvO8ZDa?=
 =?us-ascii?Q?aKtBpdYyvshhcLdpgyVqdUCKPmvCql/8f88GeQ050vrHrXDNcrEAp8oyifKF?=
 =?us-ascii?Q?aM4DFBYilvgVVroCMX3FsBStaXSupL3a1cNnvsdYx00xnR6uv6HOnbZG89Ja?=
 =?us-ascii?Q?vvCO8IXpyQFSUuxAV6iCvn51Rjq8RgsVaCEW0Fr0nM+oGnzkvNEZ2YIFiyhX?=
 =?us-ascii?Q?MGdmGpREi8CHbBrdAsqUlTxW2QaJthMt+3XRGuLgykci+XLk3bPEURHHple2?=
 =?us-ascii?Q?2B5lpKHSvgBnMQTTRhu/r8dp7+IC4jPltXAXkBzPMoOt2PrQ3MszAq1gF0fQ?=
 =?us-ascii?Q?sp/7P50U4Rm+llVhIY5GHu41DS29RCQkLXWvTh143+WMClk0RxIE4I3Hwn78?=
 =?us-ascii?Q?Xg+dh2ah8N0/iAJvENAAmtsTU6q30uiCOMMrqmlLy4iTZAm8J87E12i5kw6j?=
 =?us-ascii?Q?UDlc48/ZdkXLIyiKiV3HNQegMmIw2pknhh34XcwnPilN5KhYGXvNxkYTnKSZ?=
 =?us-ascii?Q?HOxcnwjt4nKRIq+MtC6KIZO45HlbF7vtDHU/uZbLdDHeG+WZxFxAGCWZUn/C?=
 =?us-ascii?Q?S0K84KD/1S+AORw8Bcq4PbQVmS9HKgtYamLTKZoL4gPWXHxItPkNkYC6oxbx?=
 =?us-ascii?Q?/fivlY2gCb4UM/bYOBnSqtWVS+SibK9sSIwPAnc3jpZ9ZDOmiHPEaG+lEH45?=
 =?us-ascii?Q?oJhq3ougkcb67K5iep+fdKxjQ8PxB2s2xXAt75GyE+1lwW1xeIsPgWkCuMah?=
 =?us-ascii?Q?WqcqyQAjxy/QITwVPjUHxwc6mpxRgiBD5YGwHaRwvpmVYIibhf3nzQ4vNRqg?=
 =?us-ascii?Q?S08jU35K1M7mlo8xOf1FsMFD+D+STwhDn5672dakzWw6qJZle7sgOLvJPJZG?=
 =?us-ascii?Q?nutTZSncHdzS4qdWQS50XPzzzeAyoyCQwcLO5d0IE4JJ6jVTEywQtxS4pOHd?=
 =?us-ascii?Q?Tl7JC/Txrvb453Jw721Fgqn7UCpQExsKokc+9LVoyccOKW4Qo4akt28i/ra3?=
 =?us-ascii?Q?iOQG7C14sHPVlXnkOxXzrPpS3NvEi/nTkRQhjijFf0b3I+EGlw0giPqClR5V?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca60772a-eb4d-4ea8-c99d-08db98060750
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 11:53:06.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5/AQbwEEE0H82kHY1UEStEEnUAlAaOAajUn7MNmrT3mFGrDjMI3l5ONrc+STQxOhJMdlmfxInRURiT2jmcGcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10062
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This allows a broadcast advertiser to be passed up to application,
if the adapter has the capability of being a Synchronized Receiver.

---
 src/adapter.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 491bd7031..fa15030e0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7029,6 +7029,13 @@ static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
 	return got_match;
 }
 
+static bool accept_bcast_adv(struct btd_adapter *adapter)
+{
+	if ((btd_adapter_has_settings(adapter, MGMT_SETTING_ISO_SYNC_RECEIVER)))
+		return true;
+
+	return false;
+}
 static void filter_duplicate_data(void *data, void *user_data)
 {
 	struct discovery_client *client = data;
@@ -7152,6 +7159,9 @@ void btd_adapter_device_found(struct btd_adapter *adapter,
 			return;
 		}
 
+		if (accept_bcast_adv(adapter))
+			monitoring = true;
+
 		if (!discoverable && !monitoring && !eir_data.rsi) {
 			eir_data_free(&eir_data);
 			return;
-- 
2.34.1

