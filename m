Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407A3C04FE0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Aug 2023 16:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjHHQZz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjHHQYi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Aug 2023 12:24:38 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2072.outbound.protection.outlook.com [40.107.8.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB9044BA
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Aug 2023 08:50:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4zwYhyhvddoKXPcuQevpeicDiGS4W1lJ8ITXstbcIc9zD4auC1ZJCuxF0bPxUw23EHZnydGRdP+R3Sn7uVpDWrPFDmydsOo/tpkUdLNiwwwejoX540wgMrwOF/JU9QM3FZZQ1g1CQ5b2SlMMpu3Gvj7PM30zo58lcNEGgI4NutyT9XjZnvHpvZzAfT+AAXGXqGsJ3PQ4+FBmUpKn52LPAN4DWyIWJdvgg5EWVy8E1ChLPovFrHj+IvGCWKPpF2CAU9FRF0YQ9A62ZKLUCy3EpaRpZm8fpzTheN+LN8/X98/SnI/24V1Ow60Hn1poH5BRaS1gxziUpbziGB/urRxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JxMoU9EkIJYeRYuv9CedGg9/Xy7p0cCOhujKOR5XX84=;
 b=c5mz32pU6MYH25k/9Zo3EQzL1Sw3qFDi6klAPQr4L6YNVbsuD15pQrT6gpitgxVyP/QPAqloes9obnEm0diwIQC8LCMgF2tuYF3iwWr9xmvoqteYNxhgUzx3nm8gDtzseGKg7e0R4eRpU23Zv5riZpezf2NdGJGSpV7bVs0oGZB7PX5nPU0wBzU5RfV3kxL6azyu7+1s3qnAQCGLAda6xSbh8MgcpTuz8YYdYm37DM3fwjBBAzeRvFfL7J3qw0pimSmqKAWYkyOBFkBKL/mp8n3cjSPrMpLG8QBMNk1b253ju3nhnXfibEwh2J9vbqKHYOnLfygLg5upr/T+DM5YkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JxMoU9EkIJYeRYuv9CedGg9/Xy7p0cCOhujKOR5XX84=;
 b=Pi97i54EkL1fZXVwRBNVlKYZ8miPkWkEdShxuLTaX5rRT8Lj3rH10RbU37m9mm2tnf00Nb+tzqEUWuQpIEg5Ra82++5r8ZqBcafZStvUZsouacY2PCt2ZHNqFyvKeZWlfeqFDeX7lRWqvEwngPzz6bgxFnyw+i3gTQYtQj1Z52Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DUZPR04MB10062.eurprd04.prod.outlook.com (2603:10a6:10:4e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Tue, 8 Aug
 2023 11:53:09 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6652.021; Tue, 8 Aug 2023
 11:53:08 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v5 4/7] profile: Add probe_on_discover flag
Date:   Tue,  8 Aug 2023 14:50:37 +0300
Message-Id: <20230808115040.4403-5-claudia.rosu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3e91332c-1d61-41ab-1dba-08db980608bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bceOBA6Ing5i0sk5qAQlMFcGZbHoIoTaWXcj8QPxXEEu9pXqHq6mKFE2PdXkSi3JaFCEwYQw3n8C6Wg5rUzpDWkjZ5BhC95T2k6OgOIghP6vGFd81l0bMcrHkHprBlrwDmqhMEN1Qsb92zBvT+K1SgS+IRzU+HZWomdkQexkwc0kg4kfA+kPnNIKHxYstFl2kEbOE7sDz8nYxkopd53wZpcZWyHbHJBJY2kgv6Dkb6Eu5gCDVBb72erTuS5NAB+sJCP2IwD1AvfNGvLZTqKh3bjoZL4btmm3n3Pbu3jYoFSbOwmE1OKrJCriIH/KiCH2U2Qm2Lv8LqbbSyu3GQiwMgLecdqS7QpVVFQluoZSzhKPb0zhiNnA7Cq0duGxXzPlDCLZyXEsWJYPp/KoJEsKEgDluHxUCfLSXP3xaE4OgWP4GNUczJGIjACof2xszL7ezW7mLOdWM5XqE9B4SO4AJjv3kPDPguxXvUj5g9QjfpogwkxBMcwmkIst5gf0/Cauj0LIpA1JA88+vMzAzzquZlcZJHd45Qo8g8vnuma+9sknGX0Wte3dPPJKcq0xRmwt8VpNDWmmklTTEK0AFGSQ7vkWp5TKaSuDDXVaGMi2e94TOXHns2jLO3u3AbH/oFp/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(1800799003)(186006)(451199021)(83380400001)(2616005)(52116002)(6916009)(38100700002)(38350700002)(41300700001)(2906002)(4326008)(5660300002)(316002)(8676002)(8936002)(66476007)(66946007)(66556008)(6512007)(86362001)(478600001)(6666004)(6486002)(6506007)(36756003)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TcIIuuM+b/KuhPNT+OsjmICwKz6CQkXxqVqb428GHK7WC4qRst5DOIaue1Fp?=
 =?us-ascii?Q?P9LGtz19cSQjkT8fTAKOZvde6Ll/sZpDKrWnPjGN/91dXaPqt7gvy6agbgLu?=
 =?us-ascii?Q?5lcV1GPOZOYWnLxmIP6JdyN8+hLc7mKIgZtSHBwxRNhF4uLYe1U9crA4T9QS?=
 =?us-ascii?Q?2g3POQfpdNE0xdStJJ2uxvYGIZqVBKf44Mtgcq5i7IKta/ubiOkKKmzw1Ags?=
 =?us-ascii?Q?OxaFzzl3mpSshhIfNWiA3Ya3DdXXJrtzC/owJL5jhOX5zU9lzDOncDuKz8yv?=
 =?us-ascii?Q?cBfJhW+T7hrvpVMywZPScOS6bacs4pBWm+iW2KKHG5buNK+pm+Hw+kNegE8G?=
 =?us-ascii?Q?1Uk2/1yCdvaelfWlP2VCl3B7kQlgLrmjqkl2xm+zs2ALLwW86LOKsTNElq+7?=
 =?us-ascii?Q?X8GcJwW0HqSKX0SjfcHi9p2ApfWOcYnU7d8bs85VqClq3rSV9lRZKj1nUYph?=
 =?us-ascii?Q?6cDleebNOxDJZUH0BBhtqwlxcEghW0V3rmkGtCsnAVrH3L+qqoBIS9nRl6u1?=
 =?us-ascii?Q?GQ87PSahpvI8dpUeRs2fDQfyCWO94ViaLdG46U6zFaJlKsjgOQOV4NTL+Op/?=
 =?us-ascii?Q?anbtMkrLNi5Sycsi6ovucpFRJCBteMTIDNgZ1iUQp3WRgxqDpdUga/WVyMNW?=
 =?us-ascii?Q?q6F88Xxtc7RZ2aQGgGHHbzASmcfijlyXmto1GOiR21wVqrfqo616PjOX0FLv?=
 =?us-ascii?Q?ngqZPMcTLGDpbvYzcqzO8ZyoxF2spQuhz6Pu+2M8ncAl3psq5D16FM4zBg/3?=
 =?us-ascii?Q?aIpKGXXxpkVF/EVij8as5SPkVznJW4ixA1sOtzNI7UJaofJO+bmRlnWN8PHg?=
 =?us-ascii?Q?nv1B/l/ybG1oniUBBymF5ZKc++VByrE1mmem1n8WpP9tNWfijIVlfvKTnKXv?=
 =?us-ascii?Q?r2ou9ljE+5wEkLHoQ4WrrYg4FdGhqgCl5pRgv4yFOghGxKhbt3d3wAFjKqRq?=
 =?us-ascii?Q?88/Mq50948BA+nAFh8JdoCajLNBFGijKUi3J0U2wQkMgb7nnhnt0huO5vfR0?=
 =?us-ascii?Q?R0ojCEak4uRF2UPu+cNcFKmg8TMqKS2nEqzD2L2Ci4zj/L0VXETX0P1eKv54?=
 =?us-ascii?Q?hrvfqxviFFGtndj+JxIacQ1n9A+12vkSm6Q+J4g2zSVTxTmJ57EX+lYHCMys?=
 =?us-ascii?Q?0rN4+zMos+j0y8QextwADLCiTEOo2fEqQhN4cqiXYYjeqw0i/oDL5PUSD/jW?=
 =?us-ascii?Q?AlImvvDlluglkLZRpgTrbF5jH4TYTMvYtRyRcwp9Afl1VgQ2LHzy4vy6zWe+?=
 =?us-ascii?Q?Bq01rwgl6qqHDa8sk2qO+rQyqOBg5H58cKc5tUBWb0cBlxuZclf7SNRy/D/F?=
 =?us-ascii?Q?nAaL6PNKVaZarzDWUR0OeTppQtL9C07m/Z6XHZFHAUmM/CRg1+DYkqJosYSF?=
 =?us-ascii?Q?IYNGtQaBWb/sGj4sZqqA3XYY4UgKSQH6QC0Foc+le0806Wu+bdCJ6iKq/1FT?=
 =?us-ascii?Q?pcvwf8HJHaN/QmSrG6ImwMDzOlEF9tw/A6cDFw2/GK+YvTGIMHqpjTSPN9gX?=
 =?us-ascii?Q?FOyhEIf46njFzoDUy6pJMdnIeHlEFkNUWBSTx8d9DGkHXyMBAh4/56lWWFjh?=
 =?us-ascii?Q?9UPOT5X6rNg9aPEuewRmpMxBgAnmw1c9vVCNke0T7N0T8Sl8ud2SHiFBs8+X?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e91332c-1d61-41ab-1dba-08db980608bb
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 11:53:08.8640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1uk66GtBjz/heDjGgQNU0lzA631lHBTwNj1HSljvxUKpvd7KTibolYqo7DlUtaJ2qdlC9GzS/cNB4l0O1beSAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10062
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds probe_on_discover flag which indicates if profile needs to be
probed when the remote_uuid is discovered and changes device logic to
attempt to probe driver when a new UUID is discovered and
probe_on_discover is set.
---
 src/device.c  | 22 +++++++++++++++++-----
 src/profile.h |  5 +++++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/src/device.c b/src/device.c
index b43ced8b5..19ae03f7d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2156,7 +2156,7 @@ done:
 void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
 {
 	GSList *l;
-	bool added = false;
+	GSList *added = NULL;
 
 	if (dev->bredr_state.svc_resolved || dev->le_state.svc_resolved)
 		return;
@@ -2165,13 +2165,11 @@ void device_add_eir_uuids(struct btd_device *dev, GSList *uuids)
 		const char *str = l->data;
 		if (g_slist_find_custom(dev->eir_uuids, str, bt_uuid_strcmp))
 			continue;
-		added = true;
+		added = g_slist_append(added, (void *)str);
 		dev->eir_uuids = g_slist_append(dev->eir_uuids, g_strdup(str));
 	}
 
-	if (added)
-		g_dbus_emit_property_changed(dbus_conn, dev->path,
-						DEVICE_INTERFACE, "UUIDs");
+	device_probe_profiles(dev, added);
 }
 
 static void add_manufacturer_data(void *data, void *user_data)
@@ -2201,6 +2199,7 @@ static void add_service_data(void *data, void *user_data)
 	struct eir_sd *sd = data;
 	struct btd_device *dev = user_data;
 	bt_uuid_t uuid;
+	GSList *l;
 
 	if (bt_string_to_uuid(&uuid, sd->uuid) < 0)
 		return;
@@ -2208,6 +2207,10 @@ static void add_service_data(void *data, void *user_data)
 	if (!bt_ad_add_service_data(dev->ad, &uuid, sd->data, sd->data_len))
 		return;
 
+	l = g_slist_append(NULL, sd->uuid);
+	device_add_eir_uuids(dev, l);
+	g_slist_free(l);
+
 	g_dbus_emit_property_changed(dbus_conn, dev->path,
 					DEVICE_INTERFACE, "ServiceData");
 }
@@ -3930,6 +3933,12 @@ static bool device_match_profile(struct btd_device *device,
 	if (profile->remote_uuid == NULL)
 		return false;
 
+	/* Don't match if device was just discovered (not connected) and the
+	 * profile don't have probe_on_discover flag set.
+	 */
+	if (!btd_device_is_connected(device) && !profile->probe_on_discover)
+		return false;
+
 	if (g_slist_find_custom(uuids, profile->remote_uuid,
 							bt_uuid_strcmp) == NULL)
 		return false;
@@ -4884,6 +4893,9 @@ void device_probe_profiles(struct btd_device *device, GSList *uuids)
 	struct probe_data d = { device, uuids };
 	char addr[18];
 
+	if (!uuids)
+		return;
+
 	ba2str(&device->bdaddr, addr);
 
 	if (device->blocked) {
diff --git a/src/profile.h b/src/profile.h
index 6871f2f0d..cfc500588 100644
--- a/src/profile.h
+++ b/src/profile.h
@@ -33,6 +33,11 @@ struct btd_profile {
 	 */
 	bool experimental;
 
+	/* Indicates the profile needs to be probed when the remote_uuid is
+	 * discovered.
+	 */
+	bool probe_on_discover;
+
 	int (*device_probe) (struct btd_service *service);
 	void (*device_remove) (struct btd_service *service);
 
-- 
2.34.1

