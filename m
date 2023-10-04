Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745B1E7C4CE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 15:32:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbjJDPcX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 11:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbjJDPcW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 11:32:22 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB503C9
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 08:32:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eKx8FTN6OhFCLsqEL3ibB/0MnFKcazfydRfvOUhz0b1NFrF/DE6z2LBRm6Zjl4CcY/OzmLYpLrOr0shuui+FXopdR4x0CHRdFdErgD/Qhi5Zzz1nKws9GU+yD7fMWYlwTJoYHHYhevXZJw5F7f5Ovf+VRvjFJ22THf29VOiSQ7R1Jjc/uCQ7sRbEjNQMiucQLCmEXcuNu30hCdi07OcxvHfB8gSnxqqsG32PfP6hsTTHZCs+IHbXVTEF4Klgu8TFPZWpPBqOoIjXZa/iuVcs9MeLjW2Tlo7ctFxUOKh6AEjBGiTmwVHBvILhs8/dWjDFNNuMWFd9Axi5HrLKEuO5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHq6qJsCjeE/MxMfVNowA2Q8cHRC7JAXM72tjGyGsEg=;
 b=QJ3sHKZ2mcPwQ9mX8I1jSBbR0t+DS27TGG08n1qBy855GV2jZgzv3wbxjomdScSZLdpIWodC5rKXHl2d/m6ClzmgE9CHAAAcX+/TFYFMW1u2gO9Ad4TxAfKXeVuQvibndAR36lQjT9lLn8IZFFRp0sdwAnnOW3vCkUsc+8/YlWgK5IHWEheF5zx4xDFSE533i/wfEaf096rmXbPsZa7HsvKeydS56+YjzOWzuKJdYMMWyz0qHZCOABbap4YykHsD7dKKFMlkkWNgmK+Qe41Mdw49DF1hOH8ckQoGBIx1Mfy6w662MCyKSDA5nKJGk3f5f+rmpme454LiRoJ6VZXtaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHq6qJsCjeE/MxMfVNowA2Q8cHRC7JAXM72tjGyGsEg=;
 b=Az1RrBXSqyi8xsvuXnLVyaBorIskXemC2ziuwbPX/4GQ4s968pnw+t/o8WsKjQzcb8iWLJX2wuDM4zWm4mXbvNRy4qdJo8rwjUyR/+laOgVSxu18vubs20UQ94nCh3bc0PHu1HoEuoTXsFMA4u6fk4VaYydTuLEylJf2/FoCioY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 15:32:13 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 15:32:13 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/4] shared/bass: Add miscellaneous fixes
Date:   Wed,  4 Oct 2023 18:31:49 +0300
Message-Id: <20231004153150.3051-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004153150.3051-1-iulia.tanasescu@nxp.com>
References: <20231004153150.3051-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0067.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 37efa8cf-b324-4d32-3a7b-08dbc4ef14f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SrbjfiuvZB+AbZ7t+tbNsDhIyn9E/mbJdOu3L0lOgkzO7GxBOr1sFjft0uy/5G2gEMcDY9c+ZE8zpm1ukj9UDgU5kP9qJoiK6nYQe/D7OAp53vY8HtIEWqTJ6ZIa2QTC4cuDp2L7pvhluLQmUVrJ4o7Dnl3F99QihEP79+aIQsaUl21axjk7CHKJFq5D551LkuwAokLj8DlyJKqA4ARtcqXPIy1xQSqN5GAbwT805u8Dh/9UGluqWew4vxRogsEsS6iuZnnbV8f9DTPZADCp6z9txmeo3b1SIEiJXoC11UsNTwQfHRkJiNHdkSESq1daQKachLt91lkM0ol6mLqVtL2oKk9SYkOGpARMJ7AwCPCRzGluw/5X86C/cDmhhyyQPwAtWoeJknO5km7OxIsDPZJL+zUj551S0OeVoJ0Br5HaFHYXd/iqpKhSrfkO9nKyEiwYWaHMEIRjZlidlZ42eVhQe1miicrnNRsThbB6vKqiBOZOawScYKR71LtGcSUQJ1QZqWaG0+2VCbe3dWaxO/ZUPHpJTlS35FxgeAN7JUJjMuRCZr4a5D+WEe62c9W6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6486002)(6512007)(6506007)(478600001)(6666004)(38100700002)(86362001)(66476007)(2906002)(6916009)(4326008)(83380400001)(2616005)(26005)(1076003)(41300700001)(36756003)(66556008)(66946007)(8936002)(44832011)(5660300002)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tzeuL2u/mf8PJjJsbMZi/Wm6Jbic8k+5IVVrV4BKQiIPziM6rjEO31aSULCm?=
 =?us-ascii?Q?8rYp0vxlYqSZAWBcOdJOQ9QNnPA19YqNMwrUpf6meyXVcwesAukgSIp1DDJM?=
 =?us-ascii?Q?zXDF8u1eM6tK0Ogf+yPls9Hm9m7M4qmWEF4zM3r6XuBIknaul1DJc4qnLM+H?=
 =?us-ascii?Q?6peOW/hLhN84rYfbRVQE0pvPtKqThwe60G4Y2YMYIdl5yclf2r+nitc8wXVZ?=
 =?us-ascii?Q?+e+vQq6cY/IIsJ8d5TpQ7/On3Rntm3SgOupk2Cj+g2jfXwCsFU+IijoKIWlb?=
 =?us-ascii?Q?y8hWq0fWH2lzrmkNEfbWUCLh4qOwXm+tcxUOwVpgj7Egvd+90FH5UYsCiDIT?=
 =?us-ascii?Q?rlq4hnNKclAw2y5ZKf4ovnOFV7w+aLbPEpP7TizY+0Lcz8qCELrUK7HQ+Ypr?=
 =?us-ascii?Q?hUa/JxB/hWWBGeebf7R0ghBfYnjvTZ72/9dtOk+lmv9EpTNo6ONhu1O4CqMo?=
 =?us-ascii?Q?WgluJuaeC69GZvzcXlUUeze03Gvjn66Otn2480LZjvJHtRScqrWdOFSmrYtl?=
 =?us-ascii?Q?s0ZKHCzH8zjRVgUMKvTVvpu7K2WsFYLI94lVhm4cy+aMBl2Vda7RhBskVBNZ?=
 =?us-ascii?Q?GRmniNlv1H9Iby1PTSwxtAdihkHHiugupv5Vd0zSF3rFm7hw5iqa/J18KuTV?=
 =?us-ascii?Q?KKKwg53uGoIFj6oX11/aArIvPGifkVhbZIswpSccq6d6CL0i3+0b0qnG5hwE?=
 =?us-ascii?Q?UyPtv7XnlFklNdcYhLrdLUrjj2U/bScoocJOH3B2N9oO+ZR7Bjh5doMI5jjX?=
 =?us-ascii?Q?ntw+Gfm4YTyQaIHLgiSkDnR/5bgIn5vCnUe3tf/VIK93p6m85kRVM0qloOat?=
 =?us-ascii?Q?y3ZsIOQ9V1XLUEq0Wfdem/gBv0gGq1dk/p3wEJUZeEmyIt9FRQji5LGba318?=
 =?us-ascii?Q?4l2KGlyOrrVsjlSGWb+Nw4qK2gEJQGqa7RhuC8hZ3v5CS7f9WIphLvAYM+C0?=
 =?us-ascii?Q?HrfpaTh7BswlpdiH5XmyOiKLrABWzCO9gsGmpzBiqyV934GNcQq7UU5UO0dw?=
 =?us-ascii?Q?dwc0inOd6ItY5QqbqyAN+qXLFvCxtLgK2TlvVV2koCHA0axh7OEBXMA/1kOF?=
 =?us-ascii?Q?Cu6KZvto0FoWehIyUPsHjCeoqnOoWTA2qf7hylvzxnN2CH93ZAnh35VU1V/Z?=
 =?us-ascii?Q?hYbfk0zEmJvIhgbFF7viEMpUxEFv+GuqaWsc+ZJ54qhvY0VyDO54unnRICS5?=
 =?us-ascii?Q?tCqs1hpHs6ha8zZRSffBEYBFqTicZnLUqV5kLq9wjhOGUacEAEl704HCXhPi?=
 =?us-ascii?Q?26g4JX40cAE1XLz3j6V6nPv9xqAHfTjl74gIHIC2iiS0Kms2/zeB/G54G3mL?=
 =?us-ascii?Q?s/ZdTG158cZP7PSo02prpGf1mg6cL+YplEyc0qwWtVthZvdL5XkxHQNtcodH?=
 =?us-ascii?Q?3vv+orzcCuItq387mMe2bQNqzyOyRF9gzlPBkGTdrY5RpznWtszYSV+qP0ve?=
 =?us-ascii?Q?epgLSC996wi1FHMDO8nUj9N+jT2mb/h5HeyZV5NTiAW3sOfhZ/ZWkrZ9dMMc?=
 =?us-ascii?Q?9y/l696AXhMXk1x7t7ZLRmjcoHfjzGto3VEJ5d13z3Xyy7V4VXdMZVqYvS6g?=
 =?us-ascii?Q?4AeIdZREbNEqmjGqAc1LAodBZvpmaYncjyibWYQhm7XfnPeBiVXMD4W/WT3E?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37efa8cf-b324-4d32-3a7b-08dbc4ef14f8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:32:13.2383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa4wMAos+/D840aEkJfQmCb8ECGDWzVp7evx8hIhFjtyTywoX+Mfj2NZWSfDU3k9E0m7JBTj7NoqQs1Y2fBPWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7790
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This introduces miscellaneous BASS updates and fixes discovered
during PTS testing.

---
 src/shared/bass.c | 179 +++++++++++++++++++++++++++++++++++-----------
 src/shared/bass.h |   1 +
 2 files changed, 140 insertions(+), 40 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 86dab03e3..288e1c7c5 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -504,8 +504,7 @@ static void bass_handle_remote_scan_stopped_op(struct bt_bass *bass,
 					struct iovec *iov,
 					struct bt_att *att)
 {
-	if (opcode == BT_ATT_OP_WRITE_REQ)
-		gatt_db_attribute_write_result(attrib, id, 0x00);
+	gatt_db_attribute_write_result(attrib, id, 0x00);
 }
 
 static void bass_handle_remote_scan_started_op(struct bt_bass *bass,
@@ -515,8 +514,7 @@ static void bass_handle_remote_scan_started_op(struct bt_bass *bass,
 					struct iovec *iov,
 					struct bt_att *att)
 {
-	if (opcode == BT_ATT_OP_WRITE_REQ)
-		gatt_db_attribute_write_result(attrib, id, 0x00);
+	gatt_db_attribute_write_result(attrib, id, 0x00);
 }
 
 static bool bass_src_id_match(const void *data, const void *match_data)
@@ -536,6 +534,7 @@ static void bass_handle_remove_src_op(struct bt_bass *bass,
 {
 	struct bt_bass_remove_src_params *params;
 	struct bt_bcast_src *bcast_src;
+	int att_err = 0;
 
 	/* Get Remove Source command parameters */
 	params = util_iov_pull_mem(iov, sizeof(*params));
@@ -546,33 +545,31 @@ static void bass_handle_remove_src_op(struct bt_bass *bass,
 
 	if (!bcast_src) {
 		/* No source matches the written source id */
-		if (opcode == BT_ATT_OP_WRITE_REQ)
-			gatt_db_attribute_write_result(attrib, id,
-					BT_BASS_ERROR_INVALID_SOURCE_ID);
-
-		return;
+		att_err = BT_BASS_ERROR_INVALID_SOURCE_ID;
+		goto done;
 	}
 
 	/* Ignore if server is synchronized to the PA
 	 * of the source
 	 */
 	if (bcast_src->sync_state == BT_BASS_SYNCHRONIZED_TO_PA)
-		return;
+		goto done;
 
 	/* Ignore if server is synchronized to any BIS
 	 * of the source
 	 */
 	for (int i = 0; i < bcast_src->num_subgroups; i++)
 		if (bcast_src->subgroup_data[i].bis_sync)
-			return;
+			goto done;
 
 	/* Accept the operation and remove source */
 	queue_remove(bass->ldb->bcast_srcs, bcast_src);
 	gatt_db_attribute_notify(bcast_src->attr, NULL, 0, att);
 	bass_bcast_src_free(bcast_src);
 
-	if (opcode == BT_ATT_OP_WRITE_REQ)
-		gatt_db_attribute_write_result(attrib, id, 0x00);
+done:
+	gatt_db_attribute_write_result(attrib, id,
+			att_err);
 }
 
 static bool bass_src_attr_match(const void *data, const void *match_data)
@@ -692,6 +689,21 @@ static void connect_cb(GIOChannel *io, GError *gerr,
 	free(notify_data);
 }
 
+static bool bass_trigger_big_sync(struct bt_bcast_src *bcast_src)
+{
+	for (int i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *data =
+				&bcast_src->subgroup_data[i];
+
+		if (data->pending_bis_sync &&
+			data->pending_bis_sync != BIS_SYNC_NO_PREF)
+			return true;
+	}
+
+	return false;
+}
+
+
 static void confirm_cb(GIOChannel *io, gpointer user_data)
 {
 	struct bt_bcast_src *bcast_src = user_data;
@@ -729,12 +741,17 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 		/* BIG is not encrypted. Try to synchronize */
 		bcast_src->enc = BT_BASS_BIG_ENC_STATE_NO_ENC;
 
-		if (!bt_io_bcast_accept(bcast_src->pa_sync_io,
-			connect_cb, bcast_src, NULL, &gerr)) {
-			DBG(bcast_src->bass, "bt_io_accept: %s", gerr->message);
-			g_error_free(gerr);
+		if (bass_trigger_big_sync(bcast_src)) {
+			if (!bt_io_bcast_accept(bcast_src->pa_sync_io,
+				connect_cb, bcast_src, NULL, &gerr)) {
+				DBG(bcast_src->bass, "bt_io_accept: %s",
+				gerr->message);
+				g_error_free(gerr);
+			}
+			return;
 		}
-		return;
+
+		goto notify;
 	}
 
 	/* BIG is encrypted. Wait for Client to provide the Broadcast_Code */
@@ -773,6 +790,60 @@ static struct bt_bass *bass_get_session(struct bt_att *att, struct gatt_db *db,
 	return bass;
 }
 
+static bool bass_validate_bis_sync(uint8_t num_subgroups,
+				struct iovec *iov)
+{
+	uint32_t bis_sync_state;
+	uint32_t bitmask = 0U;
+	uint8_t *meta_len;
+
+	for (int i = 0; i < num_subgroups; i++) {
+		util_iov_pull_le32(iov, &bis_sync_state);
+
+		if (bis_sync_state != BIS_SYNC_NO_PREF)
+			for (int bis_idx = 0; bis_idx < 31; bis_idx++) {
+				if (bis_sync_state & (1 << bis_idx)) {
+					if (bitmask & (1 << bis_idx))
+						return false;
+
+					bitmask |= (1 << bis_idx);
+				}
+			}
+
+		meta_len = util_iov_pull_mem(iov,
+					sizeof(*meta_len));
+		util_iov_pull_mem(iov, *meta_len);
+	}
+
+	return true;
+}
+
+static bool bass_validate_add_src_params(uint8_t *value, size_t len)
+{
+	struct bt_bass_add_src_params *params;
+	struct iovec iov = {
+		.iov_base = (void *)value,
+		.iov_len = len,
+	};
+
+	params = util_iov_pull_mem(&iov, sizeof(*params));
+
+	if (params->pa_sync > PA_SYNC_NO_PAST)
+		return false;
+
+	if (params->addr_type > 0x01)
+		return false;
+
+	if (params->sid > 0x0F)
+		return false;
+
+	if (!bass_validate_bis_sync(params->num_subgroups,
+					&iov))
+		return false;
+
+	return true;
+}
+
 static void bass_handle_add_src_op(struct bt_bass *bass,
 					struct gatt_db_attribute *attrib,
 					uint8_t opcode,
@@ -791,9 +862,13 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	uint8_t bis[ISO_MAX_NUM_BIS];
 	uint8_t *notify_data;
 	size_t notify_data_len;
+	uint8_t addr_type;
+
+	gatt_db_attribute_write_result(attrib, id, 0x00);
 
-	if (opcode == BT_ATT_OP_WRITE_REQ)
-		gatt_db_attribute_write_result(attrib, id, 0x00);
+	/* Ignore operation if parameters are invalid */
+	if (!bass_validate_add_src_params(iov->iov_base, iov->iov_len))
+		return;
 
 	/* Allocate a new broadcast source */
 	bcast_src = malloc(sizeof(*bcast_src));
@@ -856,10 +931,8 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	bcast_src->id = src_id;
 
 	/* Populate broadcast source fields from command parameters */
-	if (*(uint8_t *)util_iov_pull_mem(iov, sizeof(bcast_src->addr_type)))
-		bcast_src->addr_type = BDADDR_LE_RANDOM;
-	else
-		bcast_src->addr_type = BDADDR_LE_PUBLIC;
+	bcast_src->addr_type = *(uint8_t *)util_iov_pull_mem(iov,
+					sizeof(bcast_src->addr_type));
 
 	bacpy(&bcast_src->addr, (bdaddr_t *)util_iov_pull_mem(iov,
 						sizeof(bdaddr_t)));
@@ -919,7 +992,13 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 					data->meta_len), data->meta_len);
 	}
 
-	if (pa_sync != PA_SYNC_NO_SYNC && num_bis > 0) {
+	if (pa_sync != PA_SYNC_NO_SYNC) {
+		/* Convert to three-value type */
+		if (bcast_src->addr_type)
+			addr_type = BDADDR_LE_RANDOM;
+		else
+			addr_type = BDADDR_LE_PUBLIC;
+
 		/* If requested by client, try to synchronize to the source */
 		io = bt_io_listen(NULL, confirm_cb, bcast_src, NULL, &err,
 					BT_IO_OPT_SOURCE_BDADDR,
@@ -927,7 +1006,7 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 					BT_IO_OPT_DEST_BDADDR,
 					&bcast_src->addr,
 					BT_IO_OPT_DEST_TYPE,
-					bcast_src->addr_type,
+					addr_type,
 					BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 					BT_IO_OPT_QOS, &iso_qos,
 					BT_IO_OPT_ISO_BC_SID, bcast_src->sid,
@@ -944,7 +1023,7 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 		bcast_src->listen_io = io;
 		g_io_channel_ref(bcast_src->listen_io);
 
-		if (!bcast_src->bises)
+		if (num_bis > 0 && !bcast_src->bises)
 			bcast_src->bises = queue_new();
 	} else {
 		for (int i = 0; i < bcast_src->num_subgroups; i++)
@@ -988,9 +1067,8 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 	socklen_t len;
 	struct bt_iso_qos qos;
 	GError *gerr = NULL;
-
-	if (opcode == BT_ATT_OP_WRITE_REQ)
-		gatt_db_attribute_write_result(attrib, id, 0x00);
+	uint8_t *notify_data;
+	size_t notify_data_len;
 
 	/* Get Set Broadcast Code command parameters */
 	params = util_iov_pull_mem(iov, sizeof(*params));
@@ -1001,13 +1079,29 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 
 	if (!bcast_src) {
 		/* No source matches the written source id */
-		if (opcode == BT_ATT_OP_WRITE_REQ)
-			gatt_db_attribute_write_result(attrib, id,
+		gatt_db_attribute_write_result(attrib, id,
 					BT_BASS_ERROR_INVALID_SOURCE_ID);
 
 		return;
 	}
 
+	gatt_db_attribute_write_result(attrib, id, 0x00);
+
+	if (!bass_trigger_big_sync(bcast_src)) {
+		bcast_src->enc = BT_BASS_BIG_ENC_STATE_DEC;
+
+		notify_data = bass_build_notif_from_bcast_src(bcast_src,
+							&notify_data_len);
+
+		gatt_db_attribute_notify(bcast_src->attr,
+					(void *)notify_data,
+					notify_data_len,
+					bt_bass_get_att(bcast_src->bass));
+
+		free(notify_data);
+		return;
+	}
+
 	/* Try to sync to the source using the
 	 * received broadcast code
 	 */
@@ -1091,10 +1185,8 @@ static void bass_bcast_audio_scan_cp_write(struct gatt_db_attribute *attrib,
 
 	/* Validate written command length */
 	if (!bass_check_cp_command_len(value, len)) {
-		if (opcode == BT_ATT_OP_WRITE_REQ) {
-			gatt_db_attribute_write_result(attrib, id,
-					BT_ERROR_WRITE_REQUEST_REJECTED);
-		}
+		gatt_db_attribute_write_result(attrib, id,
+				BT_ERROR_WRITE_REQUEST_REJECTED);
 		return;
 	}
 
@@ -1110,10 +1202,8 @@ static void bass_bcast_audio_scan_cp_write(struct gatt_db_attribute *attrib,
 	}
 
 	/* Send error response if unsupported opcode was written */
-	if (opcode == BT_ATT_OP_WRITE_REQ) {
-		gatt_db_attribute_write_result(attrib, id,
-				BT_BASS_ERROR_OPCODE_NOT_SUPPORTED);
-	}
+	gatt_db_attribute_write_result(attrib, id,
+			BT_BASS_ERROR_OPCODE_NOT_SUPPORTED);
 }
 
 static bool bass_src_match_attrib(const void *data, const void *match_data)
@@ -1459,6 +1549,15 @@ bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 	return true;
 }
 
+bool bt_bass_set_att(struct bt_bass *bass, struct bt_att *att)
+{
+	if (!bass)
+		return false;
+
+	bass->att = att;
+	return true;
+}
+
 static void bass_detached(void *data, void *user_data)
 {
 	struct bt_bass_cb *cb = data;
diff --git a/src/shared/bass.h b/src/shared/bass.h
index b3f83b32e..c4b5b76ba 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -131,5 +131,6 @@ struct bt_bass *bt_bass_new(struct gatt_db *ldb, struct gatt_db *rdb,
 bool bt_bass_set_user_data(struct bt_bass *bass, void *user_data);
 void bt_bass_unref(struct bt_bass *bass);
 bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client);
+bool bt_bass_set_att(struct bt_bass *bass, struct bt_att *att);
 void bt_bass_detach(struct bt_bass *bass);
 void bt_bass_add_db(struct gatt_db *db, const bdaddr_t *adapter_bdaddr);
-- 
2.39.2

