Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995FAC001DE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 08:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjGXI4g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjGXI4a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 04:56:30 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36472E7
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 01:56:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K66+sl4N8RLOtWZFcFf9C5gGeOvQYPlPVSiTzg9N547xv3NqAlCtk+/AiU5b57yx6vRgzfT5tiWvsTccvKdtgWPTMX0MHUQFN84+w/IXbCsChU6JsZkCpQFs/PkwMO/1yoTMw1ApLv4vn1zBc4db75g46vEa3KBeLhJ9fhOjKQMtRUl0VwKH6H0P8H5wC7s5edKOaXxGXxT2xaIqCLnCBJhxnl1z7lm1EmuffESw4j8MOxqIhHSoYiv4Qs069GlBNzp8FqeqZ+eLz9o65NOjFBL6gKUAoCs/IziHLMt+zIz6d0HjiqDllu1OqATuJsuxvHiFwPR0JkkoIPA7GDgyzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cp6lHxd6f22aUF5HEP9QvRTWR44J5m11pJnIh1DrzdM=;
 b=IAru/53aCcLQxXLkpG7ReFrE0iTlConnhqXgz//5jGYE7s5tfknmhTRDJhbrVz2XlnV74iwS6ZQ2LrfPgeU+PaK8UKkDs0ZGr3qsLxYUZ8qBaCUK5CsA3zBHydg3A4hgPuWv3rIt+BD1Zjut7ryqkMrZgn5bbYy3rx810t7LxLQv/CEydKsi860YT5ScmIQ512SivbdgAyQ3VMyp5qAIawWJIOjy9m7gwou78FIPl+uZNz1+T158UlrlbKKu7mTOOscKoLhIY0UYkqbDfMBvIHE6Zj172RmkZOniMNYte9edK6bwBU70B1dUZMfzXkfQ83IR9YvPsOH/MCEUPRI5qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cp6lHxd6f22aUF5HEP9QvRTWR44J5m11pJnIh1DrzdM=;
 b=mBCbtxk9Gp3YWcO5cOjgfZe4wYfSFuUnZB+Jgh/p+ZFJt5CJmbdBUUWndPNujXMKedhDBUtTrFwt4L30N+Bzxb7U2ZG2Tbzi7Q2RtTmWhOwyVrjqZ4/2soT8AqrLbu563+Mk7V5hYWpZYmy2cNEDIJh8b9i4Ap1Wk/OdOS/XHFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by AM9PR04MB8537.eurprd04.prod.outlook.com (2603:10a6:20b:434::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 08:56:10 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::273d:f528:aaa9:288%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 08:56:10 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     devyani.godbole@nxp.com, pav@iki.fi, luiz.dentz@gmail.com,
        sathish.narasimman@intel.com, nitin.jadhav@nxp.com
Subject: [PATCH BlueZ v1 1/1] shared/vcp: Fixed the crash observed with VOCS when pairing with LE Audio TWS earbuds
Date:   Mon, 24 Jul 2023 11:55:30 +0300
Message-Id: <20230724085530.5555-2-nitin.jadhav@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724085530.5555-1-nitin.jadhav@nxp.com>
References: <20230724085530.5555-1-nitin.jadhav@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0056.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::7) To AS8PR04MB9126.eurprd04.prod.outlook.com
 (2603:10a6:20b:449::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9126:EE_|AM9PR04MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 90c59792-0e06-4e4a-10af-08db8c23d371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N+05hJ+lc7hFDNGXvuodefy8J4QhRoHwRyfSXWLGZOSuPMPRfMcFAQOQVgfbNbwa+EEMMjafN3k9C19nSMQ42IT+MnfbCr9iRNE4W71B8JrGOs3fhjDxrJi02TO4+Fdsl5gRb/lQeNfmenb7lrn1ZkT1EvThCSqVROr6X5pB5AZSv76pdxyjmZw80xj6KvN6EaNx+TBd0SUAdOj/BpdqYL1N4T777BeUSKcZInkqn62PAr6DPxtC0fTeelei5QAJivRAdsn5gO/mpJAmjmjjqQ2jP1/4ZNSIFhaNMqO04jNg+Dr84bKydreD6WB1rup3iIMPCafrOvjILsXBRBkm+Vg6W6TFpiqWJ/3F7GMn95Txfe6rQLjeSOB6Nx48gHhltNnQuiFZzi3RRPNmEN/VBq2dciRB6mpMnmjhpzL8EFKMdQMrKuZ2pbHT4yaubH1YnQ4Qoa4w98Jf24rjQ3s6+DIGBuUzVNVaeABZB5jsGpNtkOU0TmSTHiV4p1vXXiHxVoxrANpKG4kfLypDU+tt68udrgHCqpcMI1JF6vPOpH8va340RB4llxS57MMPB3H1irp6FTU1dXYO8kLqTzGx1cQmQpwH9q20CRfYD7t8OoNiEbXTF7JMmXAKm+vyHuiQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199021)(86362001)(38100700002)(38350700002)(66476007)(4326008)(6916009)(478600001)(41300700001)(316002)(66946007)(5660300002)(44832011)(8676002)(8936002)(6486002)(6512007)(6666004)(2906002)(186003)(52116002)(1076003)(26005)(6506007)(66556008)(83380400001)(36756003)(55236004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v7Jf15vf/yNYhM86ToZY50ye0YEEBr+3i7S/5eX01J5E6eK+6jwF2Gw2jIUS?=
 =?us-ascii?Q?RaGpc6dRjU9vikC127QvXHlMCegD2IsG3nOe4DkI7h/ARvvQCSJa2VQG6kYk?=
 =?us-ascii?Q?BJuAVUwqA89e4zllMN+KdtZxK0uxLni3cEei7yTCc9Y5mkviLNOVten/dnO4?=
 =?us-ascii?Q?HIy7XDBJBiOV1J9QwNHPMukXboFmbkhAdOn4qyM7HJ5ybLVr+LvdMa8+eOKQ?=
 =?us-ascii?Q?pJSIzZrZSRJ3xEQBTYj4mLjcPXcX2k+HXXQDu/5d54mRkau3znNESdG/6aWx?=
 =?us-ascii?Q?dKrQxRCwqJTjOrY1uz6Qv5JHuJzT8UP/jtcBMgKBeE8LUIQ+b7GCtiPihdCP?=
 =?us-ascii?Q?ZiG86j5Kidj0QIR9jM/CVnNVNN3tMqrJ80vHyvb70G+/E+9ZZXgep4aI/fpe?=
 =?us-ascii?Q?eTRm7Bcs4QQTZpmT1exYrT03cWThaOobR3N2WfAPtU10wqwUwaDi2BimeotP?=
 =?us-ascii?Q?AopIPovhR2GWPS/eH/MUS1CgGgJFAREyyL5qXJldbTjAJ7rJQsZ6Bbud8tHg?=
 =?us-ascii?Q?ysqlg/KB2MFQlGCZyzC0/2FTkxmpM/daGmZzMIl3n5ChgraThqf72G+Ky0k0?=
 =?us-ascii?Q?mM42RsvYsnXs4rsG0ezuT1yNr0PSKFAk8R1ZigkKUaInxJ/eFMuYC66a/C3o?=
 =?us-ascii?Q?iG9OoGva9eOQzbEMIzE4AtTWHABDX8kTvXs8XeYMX/x90Ed3DvAdCtKrqGjH?=
 =?us-ascii?Q?TEvlTM9tzXC+TkQ2asIeSQ2Qpimlpg0ZUcBGsmm2gv3cR6qXiha3aofhcjk8?=
 =?us-ascii?Q?+s760RqSyAwafEC7nuH9gHL6DoUDp91Ude81S9KlHTrBxbC4b1TSNMH/VAEf?=
 =?us-ascii?Q?a1HwRvmSv8Anysv55vtDtkX3USmZz0ZU+in9J1kuDviBVhxY4gcxCgMU15vi?=
 =?us-ascii?Q?wSR+/AYEQ5mR63+PZlAh4rOeQCMq52q3Ab+pIM6p7jJw1dyxuxdfsP832Irz?=
 =?us-ascii?Q?dnk+5NgWNUdCK8dK7lnvcU8YfgGzxYuBGMFrP34FjUBrq38a1cHyT6wU2J+T?=
 =?us-ascii?Q?dvyKU20Dn8ocxvLZfTX+HNnjwovUkGsUqSahNBMBN/tecqA5kGD8hAXNZK18?=
 =?us-ascii?Q?YmU3J/7xMVFdwKcRfwSbEUxKDHgNF8WhRp4KctortWmUYiPcUWVGUsXdcpO1?=
 =?us-ascii?Q?n3fNOlfiC1rNz6+pnZ3lOJFnmKxW8osn9BZoo4jDK2THNuqmduRIGg0VQi8M?=
 =?us-ascii?Q?cjrej1fyl5BWjLdBZOpfD+pVGd1qgteliwfKI4CLyoFyZViZX2Ez1x1z94TH?=
 =?us-ascii?Q?ccbB1DQ6zp/nlIYSuj6+22goaijafXQtOc0VOUobDGalzd9ACcQZfsxmr1u7?=
 =?us-ascii?Q?VWt7PkLdBaOOjZmBtsmdzO5X25UlnoM+JBAI3uEYVsIOv9GXE3O3LGDkqotC?=
 =?us-ascii?Q?LSjlwDBFSxXf/Suo3PYKkTU8GfZD0SIcbgRNgXef0/iE6fwj1UnVDE28yUbC?=
 =?us-ascii?Q?TTRMx1eW+EZJUPvT2F8Yo1zZbyX1FcXpfc/su7sjcmW2xqaFMagMnsss7Jwy?=
 =?us-ascii?Q?B2EYrkhCLg6ILaN9jnJ/BnDdIOFRBGSUsoSLoZd4MVeK4Hw4uR9yecdtUZmH?=
 =?us-ascii?Q?pcIU31D8AuACqf6MrhYObTWRB7r4i6JD8OJISxFE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90c59792-0e06-4e4a-10af-08db8c23d371
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 08:56:10.5018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SYKUShL5s3LynAFaJ4pPyATmPO7+5i4Uv3+LPtO8F6WffbNaLhxZ/bXyDuGsiHk2DR7miJVvaSgeEkbq+CpZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8537
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
 src/shared/vcp.c | 52 +++++++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index 74bd01729..f30d7a533 100644
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
@@ -1397,26 +1400,25 @@ static void read_vocs_audio_location(struct bt_vcp *vcp, bool success,
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
+
+	vocs_ao_dec_r = malloc(length+1);
+	memset(vocs_ao_dec_r, 0, length+1);
 
 	if (!success) {
 		DBG(vcp, "Unable to read VOCS Audio Descriptor: error 0x%02x",
@@ -1424,13 +1426,17 @@ static void read_vocs_audio_descriptor(struct bt_vcp *vcp, bool success,
 		return;
 	}
 
-	vocs_ao_dec_r = iov_pull_mem(&iov, length);
-	if (!*vocs_ao_dec_r) {
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

