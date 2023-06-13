Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2607EB64D0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Jun 2023 14:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239740AbjFMOR3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Jun 2023 10:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242587AbjFMOR2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Jun 2023 10:17:28 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A5194
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jun 2023 07:17:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxEE6+MifvsOuP9p0+KGvoZ+4Awzih3vpPRuK+1GyJw3h6zqxaAxYsI2QGoTr/gOIdomUVfZ504rwx9IOdPK5vRcVsYksCYb4zjmyGavH3JmeDQbKg1i1/AOqQZQtQjQZhJ00hfU9NqTU98Ff0oLMN4Kmd7/DpGXBce+yfKz64+DMKkHWRE6pxJTAdh5BBPJt51lVMYvRpEJtsz7zocWK85VkmuatHXPeJYZjnTvbr0RKJnerEXTWhkPK4rg/SX54KFMmUiFIBz9oENBLMvQEJ+WHiJdg/jAxZyjgoOG/DrkWIdSx78qvbm2JG6C/6YNCHoiKftvnoAIcerrmioM3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbyLpPX5EjS/ZFm33P3s2yJVn3Zj6z2uBGzBXU2aw0g=;
 b=NgL0FsCWnLpFBJxpjFzsFe8QkYyn4h3MQ7Yc/qJATFtPJX4JwBx7H453Sfu0qbVjqpgw7KrKgM0U79cqeIZGuUQLl/zwnE3lhrKou9U2HzdW6CmsLlt7zValwy6d/Gr9aIhPZFZ/Ll2lIfkCRG1EDoqX199mEUTaKRrYdZMIJa9jTpXkmaTRyG/MG0H//N8rVJ0rLcm1FW4aWowFF6A0FUcz9eCW/gtCQjR3R7ErVnMCqkhhVKpL5aINGngUFHIaHb5uM1bzLWi9CZ3TqDQi/MQCREPTlMZ7NZBGNRlGxDfot/gUEAFiMG8x+HUG1CG5nV+VtFPc1wlsJ4i1onRPyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbyLpPX5EjS/ZFm33P3s2yJVn3Zj6z2uBGzBXU2aw0g=;
 b=CapkCzyBdEPj6xu0zWbPGZMeZCVVF4NV4plJD30RoGXE3GvPrbqTHBRpVfyVEU0VRE6dsfyqYxNNF5NMZsYjsQRgHAT5ptz0Q49afK9NyZ7Yg1fcnzjJ9y7HYQq/tNIwlO4LDtYm4oBk2VdU0NCNTzg2FJK041N64qhC890nvnE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7213.eurprd04.prod.outlook.com (2603:10a6:800:1b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 14:17:22 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%6]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 14:17:21 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, silviu.barbulescu@nxp.com,
        andrei.istodorescu@nxp.com, mihai-octavian.urzica@nxp.com,
        vlad.pruteanu@nxp.com, Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/2] shared/bass: Implement CP opcode handlers
Date:   Tue, 13 Jun 2023 17:16:25 +0300
Message-Id: <20230613141625.9197-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613141625.9197-1-iulia.tanasescu@nxp.com>
References: <20230613141625.9197-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0501CA0046.eurprd05.prod.outlook.com
 (2603:10a6:200:68::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: c8babfc0-bb0a-4585-4d96-08db6c18e6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d3JUaHs+ecNpKNuL41AQYSWgvgYiHOD7Hi/W7TwkBnjfuQ9okOv77wWcXW8nVgzYE/yItpTCH/e2RW2BzhmA8osHH8HvBU/ZYU/hfnSAgU/jaoH0V3iCmyoEn3zgWq1PVU3+sr9JI9cCVVMNHgrEuGPh5ns8GlPw5bn6JVtqNOeSaRyBA9OtX9VdHJZvTk6Aq7ZPOCm5D5wZ4Ee8+yE9KYvgbsz6SDcl73YGAUr3SHlLXd7+rfqDwpUAm8Lt+A+rX6r2UhyG+hqDpTU2BzxCoum7zm3uy7hdizZDY2EmGoAXq7mnaVPlXCFh3Mjz+efOx1ZnZ3w74j887H4k3vYxGq/H5rb1Sn48ijU7JX2WKQpxkNKZHN+sS6AbEHzcnsx2naKG3J46WqHga/in3EDGyw7C369a8NGTV5HRR46YLgu7VlcW0yjpYEppHgxOhMuQKA2TEhCbcivYUs87CcePU+fknD7PKEjM1PyWjnSeJ3qE5fUY7GSucCaTCGDx9xDstOodwQOPGe07uJTALNTXvgFeSsKiSdwgTAibmRh656A4TpRjtAb8u3EoiSAiTxFMol5R27dvnNbd1dcRGUv33IFRGDTmqWmf8ksMC87jeFClD6XRGizs07ANzAK1g8+T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(5660300002)(52116002)(8676002)(8936002)(2906002)(66946007)(66556008)(66476007)(44832011)(6486002)(4326008)(26005)(1076003)(6506007)(6512007)(41300700001)(316002)(6916009)(186003)(83380400001)(2616005)(478600001)(86362001)(38100700002)(36756003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SauqVI2bCKpyiyFvgJ9mFSxyU4HV3ihBMGZp8rdInxlKrhl81C61FXzFs99C?=
 =?us-ascii?Q?lzXTta7n0fNUK9Bvr+qf9IssNgj49u8Co8zpbq1HLYkBWjfAmATE9tAQ88Vi?=
 =?us-ascii?Q?NRFAe510iGm2U+yyG2kQD9+TLv/PPKNBM9NPm9+jNATNwGzqgPeMp8qUFkL2?=
 =?us-ascii?Q?pu9fdleXvPDxaDKJkhdgBLOedEaLgEKN9KEwYYwUKwP/7rr5Kjk94CoIgBre?=
 =?us-ascii?Q?Pm6g0Jh4GL3//7XpnnYJwR14jtyzhuJlD4A8V3PhsyYz0pPpSQuHxHrv9AJw?=
 =?us-ascii?Q?9AoZyEU1sPitCkB+G0/+/fSjRhoOmCSGEojtxE8X3dFBlMoQSnxaqTh4pWkR?=
 =?us-ascii?Q?o4seeFGAqOz75NZmkTSjGRf7vID4G9j2MzgZs03lo9jSno0E1sua59J5UkRO?=
 =?us-ascii?Q?zsq+QQTJ4yUE/v2AeEjkPuqYtHt/Kvc5Bap7hnRRBXg5MpQG1Q2bQAGy027s?=
 =?us-ascii?Q?L0ba5JsfDmg6riKIR7XaS3bDQ7obQaAK5LYWIUq/Ag9PrgcBvJyDmJV9zMAi?=
 =?us-ascii?Q?O2PbSkrzR4WX4qwJ7VWubr5NOJNsZ4HGSeq7o+Xmg8GDgjJBtWrtcM7KlT3Z?=
 =?us-ascii?Q?CSh1wg72JvcCSdZCUGPhiJRYsiaMWky/0Fw+0ZaGbVZPkCna7oGJmcBGAtR7?=
 =?us-ascii?Q?Y0p7IQScmwVlIIKGPNKj6ARlSXtVWTtlC7wg3rZmNo7QD4SvgyMuNFPlS7Ei?=
 =?us-ascii?Q?cfuEYekfZD/6s4+fegWLw0cC8uehSrLthAU0TEE7lY/yybryjo2APjqvBC3O?=
 =?us-ascii?Q?mtwuW1LdkaUQPytQjQYzlJDoK87VouZTOym7MgZTALUtpSqIyGnlIDUBHwOf?=
 =?us-ascii?Q?VwF4rQQc5vRCNKySzIFnSka7CjZMXia+X7AZkU80OyUuObTdqbXnBBtZjH4o?=
 =?us-ascii?Q?mWkfFwzXB9Ma/6mqlIzyWDo5G3WBFWmYzmaOMFoZsLbrL/fhyn1+YkxX6WP+?=
 =?us-ascii?Q?ZJXCA5fwC4Ee2Y8y691dVv6nSadBp1WBxa1cJqIEjLM+1GiLoN5oYxI+k50r?=
 =?us-ascii?Q?2VRqraBGGp0usVeiS/xw8sqLNVM7YMPgxj9pli/0PPoi09Sn9eRfYDWaOkOR?=
 =?us-ascii?Q?LCIxYNH/DdZFxu0kwzOsXGs2Sp2xc6LJbjacxtfYiyIsM0EHzX6JOmnlckGj?=
 =?us-ascii?Q?+qEob4rzynK4Lu/5uhqkK+afJRSu9BnhAL/P3s1w8vICaXZDDYAjwd3MV17t?=
 =?us-ascii?Q?R9td00uRELI1nnVA5uuru4jGuMKtc5ijvHLSrRWmaLS1sCJjMt5PLNZcJqiE?=
 =?us-ascii?Q?VEgbdP/VPVf5LkVPdGP7/Q+bFl5sYoD8lmDzjejyWyH5wKZvw9rWgVzZl6wa?=
 =?us-ascii?Q?4KHuWCkfk56dEXQ3knXfsOTWCPX+hUQrZWy+irTWKeWrTHsWdkay83D2Uyv1?=
 =?us-ascii?Q?lP+Ca5G/DAfEEj68N79gARXFF8yWxflArvAc4NmW+1Ip5u+5QJeJ/JdT5iA8?=
 =?us-ascii?Q?wenWh/2qlvBufqPo12PgCT5DoVi1JmbvFluVjwnuCsuRidRSle4DhJeMTVXk?=
 =?us-ascii?Q?YzaqLWbYxEjPSKfmQbVLithrUqv6PY4bg2CvAkQ0mvWX48OdZcHiVx7OMA8A?=
 =?us-ascii?Q?ey6cPfVJ4fDVATt146eGmu96f4MSfZMb8Luw/FFBHYZAc1IygRyEHlBztZhl?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8babfc0-bb0a-4585-4d96-08db6c18e6b3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 14:17:20.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lohAxsGrHIDyT9Y+iI90yzOD1C24G8JZbRRzxuaK4C0xFBYqRI89blKJsve0RAN0TSGYvxPI8Q7zQnUFQ2jsvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7213
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds handlers for the following BASS Broadcast Audio Scan
Control Point opcodes:
   Remote Scan Stopped
   Remote Scan Started
   Remove Source

---
 src/shared/bass.c | 155 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 142 insertions(+), 13 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 8906ca1ef..423ab5bf7 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -82,6 +82,8 @@ static struct queue *bass_db;
 static struct queue *bass_cbs;
 static struct queue *sessions;
 
+static void bass_bcast_src_free(void *data);
+
 static void bass_debug(struct bt_bass *bass, const char *format, ...)
 {
 	va_list ap;
@@ -385,7 +387,7 @@ static bool bass_check_cp_command_subgroup_data_len(uint8_t num_subgroups,
 	return true;
 }
 
-static bool bass_check_cp_command_len(struct iovec *iov)
+static bool bass_check_cp_command_len(const uint8_t *value, size_t len)
 {
 	struct bt_bass_bcast_audio_scan_cp_hdr *hdr;
 	union {
@@ -395,8 +397,13 @@ static bool bass_check_cp_command_len(struct iovec *iov)
 		struct bt_bass_remove_src_params *remove_src_params;
 	} params;
 
+	struct iovec iov = {
+		.iov_base = (void *)value,
+		.iov_len = len,
+	};
+
 	/* Get command header */
-	hdr = util_iov_pull_mem(iov, sizeof(*hdr));
+	hdr = util_iov_pull_mem(&iov, sizeof(*hdr));
 
 	if (!hdr)
 		return false;
@@ -404,38 +411,38 @@ static bool bass_check_cp_command_len(struct iovec *iov)
 	/* Check command parameters */
 	switch (hdr->op) {
 	case BT_BASS_ADD_SRC:
-		params.add_src_params = util_iov_pull_mem(iov,
+		params.add_src_params = util_iov_pull_mem(&iov,
 						sizeof(*params.add_src_params));
 		if (!params.add_src_params)
 			return false;
 
 		if (!bass_check_cp_command_subgroup_data_len(
 					params.add_src_params->num_subgroups,
-					iov))
+					&iov))
 			return false;
 
 		break;
 	case BT_BASS_MOD_SRC:
-		params.mod_src_params = util_iov_pull_mem(iov,
+		params.mod_src_params = util_iov_pull_mem(&iov,
 						sizeof(*params.mod_src_params));
 		if (!params.mod_src_params)
 			return false;
 
 		if (!bass_check_cp_command_subgroup_data_len(
 					params.mod_src_params->num_subgroups,
-					iov))
+					&iov))
 			return false;
 
 		break;
 	case BT_BASS_SET_BCAST_CODE:
-		params.set_bcast_code_params = util_iov_pull_mem(iov,
+		params.set_bcast_code_params = util_iov_pull_mem(&iov,
 					sizeof(*params.set_bcast_code_params));
 		if (!params.set_bcast_code_params)
 			return false;
 
 		break;
 	case BT_BASS_REMOVE_SRC:
-		params.remove_src_params = util_iov_pull_mem(iov,
+		params.remove_src_params = util_iov_pull_mem(&iov,
 					sizeof(*params.remove_src_params));
 		if (!params.remove_src_params)
 			return false;
@@ -448,25 +455,134 @@ static bool bass_check_cp_command_len(struct iovec *iov)
 		return true;
 	}
 
-	if (iov->iov_len > 0)
+	if (iov.iov_len > 0)
 		return false;
 
 	return true;
 }
 
+static void bass_handle_remote_scan_stopped_op(struct bt_bass_db *bdb,
+					struct gatt_db_attribute *attrib,
+					uint8_t opcode,
+					unsigned int id,
+					struct iovec *iov,
+					struct bt_att *att)
+{
+	if (opcode == BT_ATT_OP_WRITE_REQ)
+		gatt_db_attribute_write_result(attrib, id, 0x00);
+}
+
+static void bass_handle_remote_scan_started_op(struct bt_bass_db *bdb,
+					struct gatt_db_attribute *attrib,
+					uint8_t opcode,
+					unsigned int id,
+					struct iovec *iov,
+					struct bt_att *att)
+{
+	if (opcode == BT_ATT_OP_WRITE_REQ)
+		gatt_db_attribute_write_result(attrib, id, 0x00);
+}
+
+static bool bass_src_id_match(const void *data, const void *match_data)
+{
+	const struct bt_bcast_src *bcast_src = data;
+	const uint8_t *id = match_data;
+
+	return (bcast_src->id == *id);
+}
+
+static void bass_handle_remove_src_op(struct bt_bass_db *bdb,
+					struct gatt_db_attribute *attrib,
+					uint8_t opcode,
+					unsigned int id,
+					struct iovec *iov,
+					struct bt_att *att)
+{
+	struct bt_bass_remove_src_params *params;
+	struct bt_bcast_src *bcast_src;
+
+	/* Get Remove Source command parameters */
+	params = util_iov_pull_mem(iov, sizeof(*params));
+
+	bcast_src = queue_find(bdb->bcast_srcs,
+						bass_src_id_match,
+						&params->id);
+
+	if (!bcast_src) {
+		/* No source matches the written source id */
+		if (opcode == BT_ATT_OP_WRITE_REQ)
+			gatt_db_attribute_write_result(attrib, id,
+					BT_BASS_ERROR_INVALID_SOURCE_ID);
+
+		return;
+	}
+
+	/* Ignore if server is synchronized to the PA
+	 * of the source
+	 */
+	if (bcast_src->sync_state == BT_BASS_SYNCHRONIZED_TO_PA)
+		return;
+
+	/* Ignore if server is synchronized to any BIS
+	 * of the source
+	 */
+	for (int i = 0; i < bcast_src->num_subgroups; i++)
+		if (bcast_src->subgroup_data[i].bis_sync)
+			return;
+
+	/* Accept the operation and remove source */
+	queue_remove(bdb->bcast_srcs, bcast_src);
+	gatt_db_attribute_notify(bcast_src->attr, NULL, 0, att);
+	bass_bcast_src_free(bcast_src);
+
+	if (opcode == BT_ATT_OP_WRITE_REQ)
+		gatt_db_attribute_write_result(attrib, id, 0x00);
+}
+
+#define BASS_OP(_str, _op, _size, _func) \
+	{ \
+		.str = _str, \
+		.op = _op, \
+		.size = _size, \
+		.func = _func, \
+	}
+
+struct bass_op_handler {
+	const char	*str;
+	uint8_t		op;
+	size_t		size;
+	void		(*func)(struct bt_bass_db *bdb,
+				struct gatt_db_attribute *attrib,
+				uint8_t opcode,
+				unsigned int id,
+				struct iovec *iov,
+				struct bt_att *att);
+} bass_handlers[] = {
+	BASS_OP("Remote Scan Stopped", BT_BASS_REMOTE_SCAN_STOPPED,
+		0, bass_handle_remote_scan_stopped_op),
+	BASS_OP("Remote Scan Started", BT_BASS_REMOTE_SCAN_STARTED,
+		0, bass_handle_remote_scan_started_op),
+	BASS_OP("Remove Source", BT_BASS_REMOVE_SRC,
+		0, bass_handle_remove_src_op),
+	{}
+};
+
 static void bass_bcast_audio_scan_cp_write(struct gatt_db_attribute *attrib,
 				unsigned int id, uint16_t offset,
 				const uint8_t *value, size_t len,
 				uint8_t opcode, struct bt_att *att,
 				void *user_data)
 {
+	struct bt_bass_db *bdb = user_data;
+	struct bt_bass_bcast_audio_scan_cp_hdr *hdr;
+	struct bass_op_handler *handler;
 	struct iovec iov = {
 		.iov_base = (void *)value,
 		.iov_len = len,
 	};
 
 	/* Validate written command length */
-	if (!bass_check_cp_command_len(&iov)) {
+	if (!bass_check_cp_command_len(value, len)) {
 		if (opcode == BT_ATT_OP_WRITE_REQ) {
 			gatt_db_attribute_write_result(attrib, id,
 					BT_ERROR_WRITE_REQUEST_REJECTED);
@@ -474,9 +590,22 @@ static void bass_bcast_audio_scan_cp_write(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	/* TODO: Implement handlers for the written opcodes */
-	gatt_db_attribute_write_result(attrib, id,
-			BT_BASS_ERROR_OPCODE_NOT_SUPPORTED);
+	/* Get command header */
+	hdr = util_iov_pull_mem(&iov, sizeof(*hdr));
+
+	/* Call the appropriate opcode handler */
+	for (handler = bass_handlers; handler && handler->str; handler++) {
+		if (handler->op == hdr->op) {
+			handler->func(bdb, attrib, opcode, id, &iov, att);
+			return;
+		}
+	}
+
+	/* Send error response if unsupported opcode was written */
+	if (opcode == BT_ATT_OP_WRITE_REQ) {
+		gatt_db_attribute_write_result(attrib, id,
+				BT_BASS_ERROR_OPCODE_NOT_SUPPORTED);
+	}
 }
 
 static bool bass_src_match_attrib(const void *data, const void *match_data)
-- 
2.34.1

