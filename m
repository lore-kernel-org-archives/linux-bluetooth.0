Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60B5C001E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 12:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjGXMaZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 08:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjGXMaS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 08:30:18 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2048.outbound.protection.outlook.com [40.107.247.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE0110C8
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 05:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6h+LVuizh3LKtCHEMV4sQU7IMHu/M0VJ7fScEoLr1d7p1WicAkk25lVPjSQ6ArwaOaVY76ni6cIb6LtPAtyon6t2CR28veEeQK/P4dXkXC64WIi4TLJ+zI1PpZqobJfOH6QM5ntWBPygpLNq3Dlcjz14Xtvko/j6ThE5UtTXTVB610U4oZiQ92wv/y+EXSL93pR//vJf0UA3MFLp1GTiE6oDmfGYA77eI8tUQRfhGS4Uq9knbFYL0P8rA0xtL5678/71JzMad8qtzBQjgpJI5OMWVAJFxZTiaZt+UVany9oqO9XfoPVtUFVZt7RXR+nGbFPrfIsdRVsjpNN6bvYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7q/hTUQ0rpAoR8MIIcnzCDztY8IJGc7zXpLK4CsdXL4=;
 b=df//4rhgKyt9Eag8IY0o5O+1c6PDPxfDG7DljtuJ6PoZz3RPQ+fawF3xDw88B/muy2sLHEBq2Wqmh+/miX1dwt5xHS0DpH5Wip3L3D3sT54UhmMoTfOct3oyAWy1ubYVhmmiuvMf3blEzuMUjWI6lE4A7rgQJoPqg9gO3mnh2X9YmKNqM1rP8RHeEFsYkXElv5eRGPmtUX4KIDaPKIWH1mQQaIvion56p9UaPU1t9gfareOfx4NKL9LM52Gx6FZzFf0JWXlBHlzbSN9kxGsrI64imXJ+cbqZbhe74VXsAjYe3P0obsTd0wio1iIzwaBhRfF+MAUPBORxcZ7f+dqHZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7q/hTUQ0rpAoR8MIIcnzCDztY8IJGc7zXpLK4CsdXL4=;
 b=cETpW1fW4gGHS4J2kuWmH4oQkNPjagsL5lOaj0qIS6LGdcXEXHMtu4cevcW++/CgnlD3IvWHsselZZ6dpy8Objr1b6ZwxX+QB4hJ1HoVeXWaq2mZv3e6JabJ2Cm25bdNdl3V3m84r92aI8C0i/LBG5ibHABh+j9ZH7tsrBMqlmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by AM8PR04MB8020.eurprd04.prod.outlook.com (2603:10a6:20b:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 12:29:57 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 12:29:57 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, pav@iki.fi, luiz.dentz@gmail.com,
        sathish.narasimman@intel.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v2 1/1] shared/vcp: Fixed the crash observed with VOCS
Date:   Mon, 24 Jul 2023 15:29:08 +0300
Message-Id: <20230724122908.42409-2-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724122908.42409-1-nitin.jadhav@nxp.com>
References: <20230724122908.42409-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::17) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|AM8PR04MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: 87631648-af25-42f5-b13e-08db8c41b104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klqSjCwokJzwSGYFdnKBtYX4ssinzd8Gkfih5KARLZ38TO6p7yt8aPZcZJWh/04IJHphC6Ns44mYVG3jN0Y8vXKDpi4OaqX9L4amqtmNA7CqIvRwd7N/1CF3XIpfzZplbz14AB0DjUJ5UkbsT7UQpfpaUdrIhhpJWgqUgVXnzYErcOfq8+4ZRBKlEf/SqKqT8SrcsV9JHGcUj3luzby/zwuifixlzA61eEnF7MOFUA3CL5EF+ZyoCd1otH7Wpz++J0ls4PwtwA/ra1q2NFoPgRNtiNp3wN17rZNgrBjvnhW60QGeeD2+iYC1Zz2RXfbfybYwZha8cObxqFTxdPCT1aOO/5VJo7w/xwJW3BsTRI44hFzlXzc9Gyf7YM4ypig5XyYC5SFLDpMZI+8T9IGBRFlb7qQoQXxntiWUFdkBBGhnbEiotO4XKWT5JUmP/XafAyGDFcum16IHbjsRLdxx/V0X3Hs6Q/H/1jc0ulvqNOBZAaVUCIQQyQ9exCAssPbin2UJvp3jtGvGSo6DMXqHAVCQkO8CL1n2qVb8B0JRBDh+hX/ao4KSpmiB6izlXbd1EPSfeEtoGdvmIQPjWuC8c2oHuMmgSRb21l9oA6LHXCje8n3V6BgI133DJODT9w82
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(38100700002)(38350700002)(66556008)(36756003)(55236004)(2616005)(83380400001)(8676002)(8936002)(5660300002)(44832011)(478600001)(66476007)(6916009)(4326008)(316002)(66946007)(41300700001)(186003)(26005)(6506007)(1076003)(52116002)(6486002)(6512007)(6666004)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J0Muxt50/riN3vYWDIUEQ+yPEe3TV83bCtQHrLeCY8W53u0gLOFpoag5FDPL?=
 =?us-ascii?Q?fJeAdJZny9Vc60L4ZnplgutNIPjArpfaLnR22x0h9DYN0MNuAtA3zxry2kmK?=
 =?us-ascii?Q?zvguHJqL+btqAvHDo6RiA9KPMsZzgGOHi4LBLwEd4BOgHV+6U0oV1t3NcheC?=
 =?us-ascii?Q?F0GPt0Plvi27Wh9/3PqfkQ9EnigHvbmsdYuakajrSE6rKmJXrBdn/8O+F2D5?=
 =?us-ascii?Q?h7ZEKFDYStC3xIKyeqgJFTN/v6fBZVJExbvmdPwG3WuKqsR0E4bbOrIL8tSm?=
 =?us-ascii?Q?e2S2goKZpvWMirubRVEIL+4QLJ4da51PiAYmtD5XRrgNP/wYDwHU4OikaS8w?=
 =?us-ascii?Q?Ea1Fo6lnyxkjWbl2uwjkucleGBbJyeaDzqJ/isgm76BooMy/gQiJYujaFaGa?=
 =?us-ascii?Q?/XKrC7iqKi+ZDB3vxByICyb85mJepaP2TX8D5LQ9H6egTXWacxc6OdkaMHDg?=
 =?us-ascii?Q?hoAHPTVVh0tPFiFyJztuHXlDQ3Wr/I+QD/52xnE9lFzBXNyKM0pWG4DkXBcB?=
 =?us-ascii?Q?ueFF4GH8xnJ2MD3JQc8sjXvTYIxMZvVZwSyRi/GnFcVhoIWWtRuwVUbd4fOd?=
 =?us-ascii?Q?97t2dC6fV7rbZzYbzMzgAGngfwlsxRTsAJOeNx3t+kGstyVKfLcvK1O04gzC?=
 =?us-ascii?Q?OCPs2U2vGPCsXaOYdw0J4YnG/Ld2gHv2hBd5raaqikM49dyuDKYgOnWQYT4z?=
 =?us-ascii?Q?zFbJXoXgd71hjonIvQN9EBZWSKNAp5tKoV4s4MRVFmuo+DzJdYpsNYHbXP+6?=
 =?us-ascii?Q?8FZfgVoFUZB3KQQdI5lAPbr07/HOx5zGC7HH8c1ztDk9V2uRtoPPiNKTNFnB?=
 =?us-ascii?Q?KBNAaRLFQZPX3PViK589M7NtkfZz5QPnBFJ3pE/M8ATIH3c2CiRS8Qk6esH2?=
 =?us-ascii?Q?wd433Na+lfsT3cTwxAEAx/CKy5iXVNT1m778DlHQr0Jppi/n5Gu3k6dBFd7o?=
 =?us-ascii?Q?Ea6yoTgIVnSqdr5Y+gDID6aVbm7d/Mt0EElTqneU2hyC1iO+vnvTcdIrKRbC?=
 =?us-ascii?Q?hviTDBpxqxCcnX2RBdze7x/0OVqvPs5XqNpp5ONj1cVztf0I2nmHb8ddyNSd?=
 =?us-ascii?Q?z+BARhbbfCs07zh6dU2UqUp+tcQHj02pYvEqqr9n/dliKTcbM/O+1CorNuyI?=
 =?us-ascii?Q?+b9GvdOuIEhqahUuAshwz9LYQeTJXXVC0Mwr783ngHjjgUOLHzklMt8uHEhj?=
 =?us-ascii?Q?CDOTQ6IFO1RAdI82UuaEqgHmEUVFcBlVdFWk+aSycK+BadBvZ6hGYoO+ORFE?=
 =?us-ascii?Q?3XX8VDDFDTsEbYhgGAVjYeJJQ5oFqD4ddlj/5LAtVNeJ6HrvbZi0QSMtmF5i?=
 =?us-ascii?Q?LHQc/P0D1F7YfiGs5YHy0LZD1UwPkKc5eHVjDcoKYn9QpnymmenzDhIQOKI0?=
 =?us-ascii?Q?duW+v2mc24ZRFzC/TuSebiyBDOgJR0wjv8WS20clY+zTD/BUeoVVx71fmdja?=
 =?us-ascii?Q?UTLSZfHiiUlhDbk/gp1kv6vhD/kgrnt22iO+RLkV1WdvUgwzj3cFsjtEFwZ7?=
 =?us-ascii?Q?JFMkG4Q/GrLvr3VF/oL7y5ddR2QldTMmcGcU0kF8u+rb0hMdyqXolhQ5VUCH?=
 =?us-ascii?Q?ZVY2rUZYlW89PaKz5wWIj3JQNLUGjCusmFGfyi1u?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87631648-af25-42f5-b13e-08db8c41b104
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 12:29:57.5937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oV38LeZqnt0vEAwJujhlidmLRkboZhxgBXbeIUXIAFwmrYEdzwYYzqyiTCLiaOVaB3oYzIlChMM1NRNZ2jhIuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8020
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Root cause
- There are two types of database- Remote and Local (rdb and ldb).
- In client mode currently the code was written to access ldb.

Fix
- Correcting it, to access rdb has resolved the problem in VOCS.
- Same correction is done for VCS.

Reported-by: Pauli Virtanen <pav@iki.fi>
---
v2: Fixed GitLint and ScanBuild warnings
---
 src/shared/vcp.c | 52 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 74bd01729..80d4dfcd4 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -973,7 +973,7 @@ static void vocs_voaodec_read(struct gatt_db_attribute *attrib,
 	struct bt_vocs *vocs = user_data;
 	struct iovec iov;
 
-	iov.iov_base = &vocs->vocs_ao_dec;
+	iov.iov_base = vocs->vocs_ao_dec;
 	iov.iov_len = strlen(vocs->vocs_ao_dec);
 
 	gatt_db_attribute_read_result(attrib, id, 0, iov.iov_base,
@@ -998,10 +998,12 @@ static struct bt_vcs *vcs_new(struct gatt_db *db, struct bt_vcp_db *vdb)
 
 	/* Populate DB with VCS attributes */
 	bt_uuid16_create(&uuid, VCS_UUID);
-	vcs->service = gatt_db_add_service(db, &uuid, true, 9);
+
+	vcs->service = gatt_db_add_service(db, &uuid, true, 10);
 	gatt_db_service_add_included(vcs->service, vdb->vocs->service);
 	gatt_db_service_set_active(vdb->vocs->service, true);
 
+
 	bt_uuid16_create(&uuid, VOL_STATE_CHRC_UUID);
 	vcs->vs = gatt_db_service_add_characteristic(vcs->service,
 					&uuid,
@@ -1385,11 +1387,12 @@ static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
 				     const uint8_t *value, uint16_t length,
 				     void *user_data)
 {
-	uint32_t *vocs_audio_loc;
-	struct iovec iov = {
-		.iov_base = (void *) value,
-		.iov_len = length,
-	};
+	uint32_t vocs_audio_loc;
+
+	if (!value) {
+		DBG(vcp, "Unable to get VOCS Audio Location");
+		return;
+	}
 
 	if (!success) {
 		DBG(vcp, "Unable to read VOCS Audio Location: error 0x%02x",
@@ -1397,26 +1400,22 @@ static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	vocs_audio_loc = iov_pull_mem(&iov, sizeof(uint32_t));
-	if (!*vocs_audio_loc) {
-		DBG(vcp, "Unable to get VOCS Audio Location");
-		return;
-	}
+	memcpy(&vocs_audio_loc, value, length);
 
-	DBG(vcp, "VOCS Audio Loc:%x", *vocs_audio_loc);
+	DBG(vcp, "VOCS Audio Loc:%x", vocs_audio_loc);
 }
 
-
 static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
 				       uint8_t att_ecode,
 				       const uint8_t *value, uint16_t length,
 				       void *user_data)
 {
 	char *vocs_ao_dec_r;
-	struct iovec iov = {
-		.iov_base = (void *) value,
-		.iov_len = length,
-	};
+
+	if (!value) {
+		DBG(vcp, "Unable to get VOCS Audio Descriptor");
+		return;
+	}
 
 	if (!success) {
 		DBG(vcp, "Unable to read VOCS Audio Descriptor: error 0x%02x",
@@ -1424,13 +1423,20 @@ static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	vocs_ao_dec_r = iov_pull_mem(&iov, length);
-	if (!*vocs_ao_dec_r) {
+	vocs_ao_dec_r = malloc(length+1);
+	memset(vocs_ao_dec_r, 0, length+1);
+
+	memcpy(vocs_ao_dec_r, value, length);
+
+	if (!vocs_ao_dec_r) {
 		DBG(vcp, "Unable to get VOCS Audio Descriptor");
 		return;
 	}
 
-	DBG(vcp, "VOCS Audio Descriptor:%s", *vocs_ao_dec_r);
+	DBG(vcp, "VOCS Audio Descriptor: %s", vocs_ao_dec_r);
+
+	free(vocs_ao_dec_r);
+	vocs_ao_dec_r = NULL;
 }
 
 static void vcp_pending_destroy(void *data)
@@ -1719,10 +1725,10 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 		return false;
 
 	bt_uuid16_create(&uuid, VCS_UUID);
-	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vcs_service, vcp);
+	gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_vcs_service, vcp);
 
 	bt_uuid16_create(&uuid, VOL_OFFSET_CS_UUID);
-	gatt_db_foreach_service(vcp->ldb->db, &uuid, foreach_vocs_service, vcp);
+	gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_vocs_service, vcp);
 
 	return true;
 }
-- 
2.34.1

