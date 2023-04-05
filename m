Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5342CC7619A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 10:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237590AbjDEKzN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 06:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbjDEKzL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 06:55:11 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737A0D8
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 03:55:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXCcu0NaeOBOinno74dSHifEj3C37QohfK7U/qUCgqO0wMGJSsAV4QwD+vCShugghAyCkBhJB7GbpHm1TotQ4ySFvq4AdeaLcgWt8Azlrd0eeH1D2NqU8G+pY+0y6vdAuThfykvjo5kG+4wP5lyu0Rp1jwerpZPAj/V+hHX28vtjhkwPdheR8WXG+vwBJuHPJD2QLM4iNphgbFPoizw2ngDovn2mR3s20bT4J3KA1xkyhcAZoAPqypgpEcr/T9HoUWQ/o3DNaT1JOhAMaFFG2VDGjq6Xp8MXwTkiqPqM5X8gdxXEQWop7AuoKRWabzLRzFoC9l7TIJJpvS42QUc0fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V80nClBVz1UPeCgugTmJVUWvxVlxvQhvxSo2CPINSjM=;
 b=Ktnrl4TfKXoOmFrTpgzDBYuVrFipnXHzmf26AFKZOx4Ddl6N/h0hcXfKmLm1RIzA2yAf5ko5XPx23shu09Rg8WOD5C6yJHeVIPpV5zQEQXlb7o5yE0N4zL4v6G9KubXFlN+lh3prn3y+rV+j1azN5Q+uf8ujxOHb7TVl0iloV+Ub4a5DOaFSFE2H7+otXCil8dzkyxYErl86Xm8pmzzpmMq1aNMRFLtli+Ni8HCd0mRphwHcq6E4PLinX56Jfslc9fb6H3AWFKjqkoNK0t7mGZi3CZQ/UMbfJqS5Vp545sqsVJdVPO/K/MJSYkj+WYvgX1WVxvgB61/7RlLbu8yYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V80nClBVz1UPeCgugTmJVUWvxVlxvQhvxSo2CPINSjM=;
 b=qUFNwqgUVFGVi4PbXzk7zajDjp/7vg2CqfG/nqoB7CXxlJoFPIWo3Sf7kchxIML5pd4NT3/XxSwHnT9aiipXwX4ppqZ92nuPS87FnXk4nsjZenJ0WaQYPdpluDmpAlzdgKEJVpFVygmOb3MD0YA2Sh0CWJe99jekIeacpWOkLUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9351.eurprd04.prod.outlook.com (2603:10a6:102:2b6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Wed, 5 Apr
 2023 10:55:06 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 10:55:06 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/1] monitor/att: Add decoding support for BASS
Date:   Wed,  5 Apr 2023 13:54:42 +0300
Message-Id: <20230405105442.14281-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230405105442.14281-1-iulia.tanasescu@nxp.com>
References: <20230405105442.14281-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0005.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::10) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9351:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b3e555-dfc9-4fc7-7e3b-08db35c43784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: njff/2PAX43eHFCLvlv7tWz1SHcNa6N7Fum8+G479GtcokllFYzuX1/1yrQb2AvQie32TxXA1bketRKirmwvcQYXq8aLNSoOATYHglOXUk7TRq1hPW2XDRJXRONrVBT2BO32y8oJwicqeCtCFIY8VKnKejp9msNg8iVNTkE9MCnyWzkoE0/OJJNZjqjKyw6qst0dc4kTVF0kqNHwOTUY+bGjSeCxIOOsHe+YaK3axioZl1xDb96ave/pxUN38y3TKhmMaoBx/hYj52DO5VpIpw4OmHp7F8xUqph2/d0b0F1O3jlKO0/9za9PWcrHyTdf7Ho/lryjZ/uRUJOuNmhPQpXt54N+FQCaxx/Jre0hEfSbzF3QOezIOVo9d8ZcKI4Sw/jdRHc5lVbG5CzhntjGhfuVDnnSjSLiK6/gu6h6Uk/2mM/xMIYGBL8wuxb+7TiyJFREE8K0tdDLYt88y9cTqSkhzsIv+Kafsu11Z78h1na8NkcgLuX7P33wAPIq/9gJpVnnykyRPRfRuN8rcR8X/idYWBZbP9yhfRw2e5mKT7FMOMaRiB0q1AoTtc1DhycggV71vsYPSUGudSmSGa5rA66KaAS1DRSTThbapZM5mz6/KCIt6/kuKeJs4nYzVKak
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199021)(6512007)(55236004)(6506007)(1076003)(6666004)(83380400001)(6486002)(26005)(2616005)(38100700002)(66556008)(38350700002)(41300700001)(52116002)(66476007)(186003)(316002)(66946007)(478600001)(44832011)(2906002)(30864003)(86362001)(8676002)(6916009)(4326008)(5660300002)(36756003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mmCafUbSPckDjQwqxDiLER86/uMrx13Epgba8NXEPswHZBowpj7l8nsuowWW?=
 =?us-ascii?Q?Us7jR5eh2AVNhVLbAjBwQCkEB4MkCeAjd9V7QkQT9p38EKtUTSJ0U09XDD/7?=
 =?us-ascii?Q?T8WXE4jFjdRgrAVxyaaly00hazHWDuNESXsWxMNIcL70RuZtis79u5jGZX8b?=
 =?us-ascii?Q?KZaPpC5eu3RGrEet8rnJ8ntRvanRwObs2sYXQ1k8jSJgRmvzn6n0B/ii0Z4T?=
 =?us-ascii?Q?UCiHWJaCmiY6QHH3QPBmrkIQ0i91m9R17Yfs2Fw//VKRQFcW2GJlTe+53a6Q?=
 =?us-ascii?Q?rXWeQThfISpMdj/OCpvgVgSvK+4t3TbECQppha36Fwtx6xx5V6yCgCmi3ayG?=
 =?us-ascii?Q?LC6GZxDWUJB2DwwR/yUVECvRdapXiEfrUptuy8zzi7OTFw0C2yTDE4B6QXzj?=
 =?us-ascii?Q?zbtAQugSFHyWnIm79y3bbQTvKOq37rWsJ+WWbmBugZf8v5uo4mEDNsq+mxBK?=
 =?us-ascii?Q?ucZN/p9Zf8CKUOjPbrN+8WzpJFeg+BvXLeP8GATaQoZxda6mgIUcxvNIhAML?=
 =?us-ascii?Q?1oUjYsj7NqP0qobQbXeCEOZaAH/ZevBMymZiahq2fBniNSI3J85bhdFDs0Z6?=
 =?us-ascii?Q?iVycb6+rvXJK2+td5rS8ACHiugrEzfKiuITqbBEEQBTdR2mkXhLN6oYKl85f?=
 =?us-ascii?Q?pQ58sFTW36aDeFUz4p++OJvus+IVD2ckyB3qHnOnnkLqjl/Oi37AZ6l9I3Vi?=
 =?us-ascii?Q?0c//rnoShx8LbN2UEf0gfmwM7M/2XFSL/e8FySJM/zsEzXZ4D4YxSTuTeCBz?=
 =?us-ascii?Q?tiarD+TziBg3hC6qws47rzJ2/Jo+Mst3QQVFLlPi7BRs3cOWbyDhpNOhU4qe?=
 =?us-ascii?Q?+4esnY2vHd81Ajk44jTpsMhNt9txkfI87pqHdXNhPOFCF0lJywTf6isMTQpC?=
 =?us-ascii?Q?+/SmdQj+0gi4jYGnOvrCDDzUF7q2idCdoSuwRMDZJY+cflbqbC4ZH2AC4QUA?=
 =?us-ascii?Q?HvGfrTTPSABGHFOBI2hixBQH2TT5HQlHMLzHFy3PeyW7vlZlBrNxzLxlNAR9?=
 =?us-ascii?Q?VZq04d5lsDYNwGaylLamtL0YJJtcA4rSOXpSXBD/kaBZgJJgRgsFGdT7Nasj?=
 =?us-ascii?Q?woAXEPJQP4xBMIs7vLANRJ7mcU7c1gcaMUcrcWpYKrVW6i4q1CNIjhT03CTZ?=
 =?us-ascii?Q?LQtw9sjgRsrn28/nUYwhI02Ff/znCujdmcDldBiA8BQlaNJaZz0bUOZyDqx9?=
 =?us-ascii?Q?gbBMrtdX9WwkiSFiTcxOOAeZGNU+wK/TpSIrCgYizZLQRFjizVxBCJC1S50x?=
 =?us-ascii?Q?GzyiNoGZdqDcm+/rOo7Gdm6zjZHpni7Ep+4RmAYKlvHKrhpdVPDeeAgy69oQ?=
 =?us-ascii?Q?ECn7uNXt78BDR+2aDfsoe+RhM//joF2Q7XbqT0c9/8+YjXzreA5cPnTJqR8K?=
 =?us-ascii?Q?6d6eodytgzp15nn3PJdwraG5c0m3b3XXTNSfwKMSF1HhoO6EbmNuk0YuncUf?=
 =?us-ascii?Q?BmreQBmLFwD68BxDUVaEYqi+IsG4Pb3/0Jjb/el7t98dKpOg4RXlvDMIrXfL?=
 =?us-ascii?Q?4P3p9W4t9AtvKz1COV2yDVhBgqY9Chio+gg6lb7egilGcp02V2a/eMVOZOR3?=
 =?us-ascii?Q?F5sOC/Xk1k6yLrpKtQ5E2v8BQ02yNEy9cIM+vYVtnfNvWs2YvqidHsiw+Q3q?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b3e555-dfc9-4fc7-7e3b-08db35c43784
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 10:55:06.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS7rbXxc4rbL/8WlHYNLxLqDebhQtplcBfF/GVnqt1Z46/tLIeEyHtj3XketgXMF3rwB8XTOkKJkwTdcb/B56w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9351
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds decoding support for BASS attributes:

> ACL Data RX: Handle 0 flags 0x02 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)

< ACL Data TX: Handle 0 flags 0x00 dlen 45
      ATT: Read Response (0x0b) len 40
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
        Value: 0100f2698be807c0013a6501020101000000000403020400
          Source_ID: 1
          Source_Address_Type: 0
          Source_Address: C0:07:E8:8B:69:F2
          Source_Adv_SID: 1
          Broadcast_ID: 0x01653a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Broadcast_Code required
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
            Metadata #0: len 0x03 type 0x02
            Metadata: 0400

> ACL Data RX: Handle 0 flags 0x02 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x003d Type: Broadcast Receive State (0x2bc8)

< ACL Data TX: Handle 0 flags 0x00 dlen 5
      ATT: Read Response (0x0b) len 0
        Handle: 0x003d Type: Broadcast Receive State (0x2bc8)
        Value: 
          Empty characteristic

> ACL Data RX: Handle 0 flags 0x02 dlen 8
      ATT: Write Request (0x12) len 3
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data: 00
            Opcode: Remote Scan Stopped (0x00)

< ACL Data TX: Handle 0 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Write Request (0x12)
        Handle: 0x0040
        Error: Reserved (0x80)

> ACL Data RX: Handle 0 flags 0x02 dlen 8
      ATT: Write Request (0x12) len 3
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data: 01
            Opcode: Remote Scan Started (0x01)

< ACL Data TX: Handle 0 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Write Request (0x12)
        Handle: 0x0040
        Error: Reserved (0x80)

> ACL Data RX: Handle 0 flags 0x01 dlen 5
      ATT: Write Request (0x12) len 27
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data: 0200f2698be807c0013a650100ffff01000000000403020400
            Opcode: Add Source (0x02)
            Source_Address_Type: 0
            Source_Address: C0:07:E8:8B:69:F2
            Source_Adv_SID: 1
            Broadcast_ID: 0x01653a
            PA_Sync_State: Do not synchronize to PA
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000000
              Metadata #0: len 0x03 type 0x02
              Metadata: 0400

< ACL Data TX: Handle 0 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Write Request (0x12)
        Handle: 0x0040
        Error: Reserved (0x80)

> ACL Data RX: Handle 0 flags 0x02 dlen 22
      ATT: Write Request (0x12) len 17
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data: 030102780001000000000403040400
            Opcode: Modify Source (0x03)
            Source_ID: 1
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0x0078
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000000
              Metadata #0: len 0x03 type 0x04
              Metadata: 0400

< ACL Data TX: Handle 0 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Write Request (0x12)
        Handle: 0x0040
        Error: Reserved (0x80)

> ACL Data RX: Handle 0 flags 0x02 dlen 25
      ATT: Write Request (0x12) len 20
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data: 0401b803eac6afbb65a25a41f15305680201
            Opcode: Set Broadcast_Code (0x04)
            Source_ID: 1
            Broadcast_Code: b803eac6afbb65a25a41f15305680201

< ACL Data TX: Handle 0 flags 0x00 dlen 5
      ATT: Write Response (0x13) len 0

< ACL Data TX: Handle 0 flags 0x00 dlen 33
      ATT: Handle Multiple Value Notification (0x23) len 28
        Length: 0x0018
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data: 0100f2698be807c0013a6501020201000000000403020400
          Source_ID: 1
          Source_Address_Type: 0
          Source_Address: C0:07:E8:8B:69:F2
          Source_Adv_SID: 1
          Broadcast_ID: 0x01653a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Decrypting
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
            Metadata #0: len 0x03 type 0x02
            Metadata: 0400

> ACL Data RX: Handle 0 flags 0x02 dlen 9
      ATT: Write Request (0x12) len 4
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data: 0501
            Opcode: Remove Source (0x05)
            Source_ID: 1

< ACL Data TX: Handle 0 flags 0x00 dlen 9
      ATT: Error Response (0x01) len 4
        Write Request (0x12)
        Handle: 0x0040
        Error: Reserved (0x80)
---
 monitor/att.c | 464 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 462 insertions(+), 2 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index ff77620c5..e67887861 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2011-2014  Intel Corporation
  *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -2514,6 +2515,462 @@ static void content_control_id_read(const struct l2cap_frame *frame)
 	print_content_control_id(frame);
 }
 
+static const struct pa_sync_state_decoder {
+	uint8_t code;
+	char *value;
+} pa_sync_state_decoders[] = {
+	{ 0x00, "Not synchronized to PA" },
+	{ 0x01, "SyncInfo Request" },
+	{ 0x02, "Synchronized to PA" },
+	{ 0x03, "Failed to synchronize to PA" },
+	{ 0x04, "No PAST" },
+};
+
+static const struct cp_pa_sync_state_decoder {
+	uint8_t code;
+	char *value;
+} cp_pa_sync_state_decoders[] = {
+	{ 0x00, "Do not synchronize to PA" },
+	{ 0x01, "Synchronize to PA - PAST available" },
+	{ 0x02, "Synchronize to PA - PAST not available" },
+};
+
+static const struct big_enc_decoder {
+	uint8_t code;
+	char *value;
+} big_enc_decoders[] = {
+	{ 0x00, "Not encrypted" },
+	{ 0x01, "Broadcast_Code required" },
+	{ 0x02, "Decrypting" },
+	{ 0x03, "Bad_Code (incorrect encryption key)" },
+};
+
+static bool print_subgroup_lv(const struct l2cap_frame *frame,
+		const char *label, struct packet_ltv_decoder *decoder,
+		size_t decoder_len)
+{
+	struct bt_hci_lv_data *lv;
+
+	lv = l2cap_frame_pull((void *)frame, frame, sizeof(*lv));
+	if (!lv) {
+		print_text(COLOR_ERROR, "%s: invalid size", label);
+		return false;
+	}
+
+	if (!l2cap_frame_pull((void *)frame, frame, lv->len)) {
+		print_text(COLOR_ERROR, "%s: invalid size", label);
+		return false;
+	}
+
+	packet_print_ltv(label, lv->data, lv->len, decoder, decoder_len);
+
+	return true;
+}
+
+static bool print_subgroup_metadata(const char *label,
+				const struct l2cap_frame *frame)
+{
+	return print_subgroup_lv(frame, label, NULL, 0);
+}
+
+static void print_bcast_recv_state(const struct l2cap_frame *frame)
+{
+	uint8_t i;
+	uint8_t id;
+	uint8_t addr_type;
+	uint8_t *addr;
+	uint8_t sid;
+	uint32_t bid;
+	uint8_t pa_sync_state;
+	uint8_t enc;
+	uint8_t *bad_code;
+	uint8_t num_subgroups = 0;
+	uint32_t bis_sync_state;
+
+	if (frame->size == 0) {
+		print_field("  Empty characteristic");
+		goto done;
+	}
+
+	if (!l2cap_frame_get_u8((void *)frame, &id)) {
+		print_text(COLOR_ERROR, "Source_ID: invalid size");
+		goto done;
+	}
+
+	print_field("  Source_ID: %u", id);
+
+	if (!l2cap_frame_get_u8((void *)frame, &addr_type)) {
+		print_text(COLOR_ERROR, "Source_Address_Type: invalid size");
+		goto done;
+	}
+
+	print_field("  Source_Address_Type: %u", addr_type);
+
+	addr = l2cap_frame_pull((void *)frame, frame, sizeof(bdaddr_t));
+	if (!addr) {
+		print_text(COLOR_ERROR, "Source_Address: invalid size");
+		goto done;
+	}
+
+	print_field("  Source_Address: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
+					addr[5], addr[4],
+					addr[3], addr[2],
+					addr[1], addr[0]);
+
+	if (!l2cap_frame_get_u8((void *)frame, &sid)) {
+		print_text(COLOR_ERROR, "Source_Adv_SID: invalid size");
+		goto done;
+	}
+
+	print_field("  Source_Adv_SID: %u", sid);
+
+	if (!l2cap_frame_get_le24((void *)frame, &bid)) {
+		print_text(COLOR_ERROR, "Broadcast_ID: invalid size");
+		goto done;
+	}
+
+	print_field("  Broadcast_ID: 0x%06x", bid);
+
+	if (!l2cap_frame_get_u8((void *)frame, &pa_sync_state)) {
+		print_text(COLOR_ERROR, "PA_Sync_State: invalid size");
+		goto done;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(pa_sync_state_decoders); i++) {
+		const struct pa_sync_state_decoder *decoder;
+
+		decoder = &pa_sync_state_decoders[i];
+
+		if (decoder->code == pa_sync_state) {
+			print_field("  PA_Sync_State: %s", decoder->value);
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(pa_sync_state_decoders))
+		print_field("  PA_Sync_State: %s", "Invalid value");
+
+	if (!l2cap_frame_get_u8((void *)frame, &enc)) {
+		print_text(COLOR_ERROR, "BIG_Encryption: invalid size");
+		goto done;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(big_enc_decoders); i++) {
+		const struct big_enc_decoder *decoder;
+
+		decoder = &big_enc_decoders[i];
+
+		if (decoder->code == enc) {
+			print_field("  BIG_Encryption: %s", decoder->value);
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(big_enc_decoders))
+		print_field("  BIG_Encryption: %s", "Invalid value");
+
+	if (enc == 0x03) {
+		bad_code = l2cap_frame_pull((void *)frame, frame, 16);
+		if (!bad_code) {
+			print_text(COLOR_ERROR, "Bad_Code: invalid size");
+			goto done;
+		}
+
+		print_hex_field("  Bad_Code", bad_code, 16);
+	}
+
+	if (!l2cap_frame_get_u8((void *)frame, &num_subgroups)) {
+		print_text(COLOR_ERROR, "Num_Subgroups: invalid size");
+		goto done;
+	}
+
+	print_field("  Num_Subgroups: %u", num_subgroups);
+
+	for (i = 0; i < num_subgroups; i++) {
+		print_field("  Subgroup #%u:", i);
+
+		if (!l2cap_frame_get_le32((void *)frame, &bis_sync_state)) {
+			print_text(COLOR_ERROR, "BIS_Sync State: invalid size");
+			goto done;
+		}
+
+		print_field("    BIS_Sync State: 0x%8.8x", bis_sync_state);
+
+		if (!print_subgroup_metadata("    Metadata", frame))
+			goto done;
+	}
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void bcast_recv_state_read(const struct l2cap_frame *frame)
+{
+	print_bcast_recv_state(frame);
+}
+
+static void bcast_recv_state_notify(const struct l2cap_frame *frame)
+{
+	print_bcast_recv_state(frame);
+}
+
+#define BCAST_AUDIO_SCAN_CP_CMD(_op, _desc, _func) \
+[_op] = { \
+	.desc = _desc, \
+	.func = _func, \
+}
+
+static void bcast_audio_scan_cp_add_src_cmd(const struct l2cap_frame *frame)
+{
+	uint8_t i;
+	uint8_t addr_type;
+	uint8_t *addr;
+	uint8_t sid;
+	uint32_t bid;
+	uint8_t pa_sync_state;
+	uint16_t pa_interval;
+	uint8_t num_subgroups = 0;
+	uint32_t bis_sync_state;
+
+	if (!l2cap_frame_get_u8((void *)frame, &addr_type)) {
+		print_text(COLOR_ERROR, "Source_Address_Type: invalid size");
+		return;
+	}
+
+	print_field("    Source_Address_Type: %u", addr_type);
+
+	addr = l2cap_frame_pull((void *)frame, frame, sizeof(bdaddr_t));
+	if (!addr) {
+		print_text(COLOR_ERROR, "Source_Address: invalid size");
+		return;
+	}
+
+	print_field("    Source_Address: %2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
+					addr[5], addr[4],
+					addr[3], addr[2],
+					addr[1], addr[0]);
+
+	if (!l2cap_frame_get_u8((void *)frame, &sid)) {
+		print_text(COLOR_ERROR, "Source_Adv_SID: invalid size");
+		return;
+	}
+
+	print_field("    Source_Adv_SID: %u", sid);
+
+	if (!l2cap_frame_get_le24((void *)frame, &bid)) {
+		print_text(COLOR_ERROR, "Broadcast_ID: invalid size");
+		return;
+	}
+
+	print_field("    Broadcast_ID: 0x%06x", bid);
+
+	if (!l2cap_frame_get_u8((void *)frame, &pa_sync_state)) {
+		print_text(COLOR_ERROR, "PA_Sync_State: invalid size");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cp_pa_sync_state_decoders); i++) {
+		const struct cp_pa_sync_state_decoder *decoder;
+
+		decoder = &cp_pa_sync_state_decoders[i];
+
+		if (decoder->code == pa_sync_state) {
+			print_field("    PA_Sync_State: %s", decoder->value);
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(cp_pa_sync_state_decoders))
+		print_field("    PA_Sync_State: %s", "Invalid value");
+
+	if (!l2cap_frame_get_le16((void *)frame, &pa_interval)) {
+		print_text(COLOR_ERROR, "PA_Interval: invalid size");
+		return;
+	}
+
+	print_field("    PA_Interval: 0x%04x", pa_interval);
+
+	if (!l2cap_frame_get_u8((void *)frame, &num_subgroups)) {
+		print_text(COLOR_ERROR, "Num_Subgroups: invalid size");
+		return;
+	}
+
+	print_field("    Num_Subgroups: %u", num_subgroups);
+
+	for (i = 0; i < num_subgroups; i++) {
+		print_field("    Subgroup #%u:", i);
+
+		if (!l2cap_frame_get_le32((void *)frame, &bis_sync_state)) {
+			print_text(COLOR_ERROR, "BIS_Sync State: invalid size");
+			return;
+		}
+
+		print_field("      BIS_Sync State: 0x%8.8x", bis_sync_state);
+
+		if (!print_subgroup_metadata("      Metadata", frame))
+			return;
+	}
+}
+
+static void bcast_audio_scan_cp_mod_src_cmd(const struct l2cap_frame *frame)
+{
+	uint8_t i;
+	uint8_t id;
+	uint8_t pa_sync_state;
+	uint16_t pa_interval;
+	uint8_t num_subgroups = 0;
+	uint32_t bis_sync_state;
+
+	if (!l2cap_frame_get_u8((void *)frame, &id)) {
+		print_text(COLOR_ERROR, "Source_ID: invalid size");
+		return;
+	}
+
+	print_field("    Source_ID: %u", id);
+
+	if (!l2cap_frame_get_u8((void *)frame, &pa_sync_state)) {
+		print_text(COLOR_ERROR, "PA_Sync_State: invalid size");
+		return;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(cp_pa_sync_state_decoders); i++) {
+		const struct cp_pa_sync_state_decoder *decoder;
+
+		decoder = &cp_pa_sync_state_decoders[i];
+
+		if (decoder->code == pa_sync_state) {
+			print_field("    PA_Sync_State: %s", decoder->value);
+			break;
+		}
+	}
+
+	if (i == ARRAY_SIZE(cp_pa_sync_state_decoders))
+		print_field("    PA_Sync_State: %s", "Invalid value");
+
+	if (!l2cap_frame_get_le16((void *)frame, &pa_interval)) {
+		print_text(COLOR_ERROR, "PA_Interval: invalid size");
+		return;
+	}
+
+	print_field("    PA_Interval: 0x%04x", pa_interval);
+
+	if (!l2cap_frame_get_u8((void *)frame, &num_subgroups)) {
+		print_text(COLOR_ERROR, "Num_Subgroups: invalid size");
+		return;
+	}
+
+	print_field("    Num_Subgroups: %u", num_subgroups);
+
+	for (i = 0; i < num_subgroups; i++) {
+		print_field("    Subgroup #%u:", i);
+
+		if (!l2cap_frame_get_le32((void *)frame, &bis_sync_state)) {
+			print_text(COLOR_ERROR, "BIS_Sync State: invalid size");
+			return;
+		}
+
+		print_field("      BIS_Sync State: 0x%8.8x", bis_sync_state);
+
+		if (!print_subgroup_metadata("      Metadata", frame))
+			return;
+	}
+}
+
+static void bcast_audio_scan_cp_set_bcode_cmd(const struct l2cap_frame *frame)
+{
+	uint8_t id;
+	uint8_t *bcast_code;
+
+	if (!l2cap_frame_get_u8((void *)frame, &id)) {
+		print_text(COLOR_ERROR, "Source_ID: invalid size");
+		return;
+	}
+
+	print_field("    Source_ID: %u", id);
+
+	bcast_code = l2cap_frame_pull((void *)frame, frame, 16);
+	if (!bcast_code) {
+		print_text(COLOR_ERROR, "Broadcast_Code: invalid size");
+		return;
+	}
+
+	print_hex_field("    Broadcast_Code", bcast_code, 16);
+
+}
+
+static void bcast_audio_scan_cp_remove_src_cmd(const struct l2cap_frame *frame)
+{
+	uint8_t id;
+
+	if (!l2cap_frame_get_u8((void *)frame, &id)) {
+		print_text(COLOR_ERROR, "Source_ID: invalid size");
+		return;
+	}
+
+	print_field("    Source_ID: %u", id);
+}
+
+struct bcast_audio_scan_cp_cmd {
+	const char *desc;
+	void (*func)(const struct l2cap_frame *frame);
+} bcast_audio_scan_cp_cmd_table[] = {
+	/* Opcode = 0x00 (Remote Scan Stopped) */
+	BCAST_AUDIO_SCAN_CP_CMD(0x00, "Remote Scan Stopped", NULL),
+	/* Opcode = 0x01 (Remote Scan Started) */
+	BCAST_AUDIO_SCAN_CP_CMD(0x01, "Remote Scan Started", NULL),
+	/* Opcode = 0x02 (Add Source) */
+	BCAST_AUDIO_SCAN_CP_CMD(0x02, "Add Source",
+					bcast_audio_scan_cp_add_src_cmd),
+	/* Opcode = 0x03 (Modify Source) */
+	BCAST_AUDIO_SCAN_CP_CMD(0x03, "Modify Source",
+					bcast_audio_scan_cp_mod_src_cmd),
+	/* Opcode = 0x04 (Set Broadcast_Code) */
+	BCAST_AUDIO_SCAN_CP_CMD(0x04, "Set Broadcast_Code",
+					bcast_audio_scan_cp_set_bcode_cmd),
+	/* Opcode = 0x05 (Remove Source) */
+	BCAST_AUDIO_SCAN_CP_CMD(0x05, "Remove Source",
+					bcast_audio_scan_cp_remove_src_cmd),
+};
+
+static struct bcast_audio_scan_cp_cmd *bcast_audio_scan_cp_get_cmd(uint8_t op)
+{
+	if (op > ARRAY_SIZE(bcast_audio_scan_cp_cmd_table))
+		return NULL;
+
+	return &bcast_audio_scan_cp_cmd_table[op];
+}
+
+static void print_bcast_audio_scan_cp_cmd(const struct l2cap_frame *frame)
+{
+	uint8_t op;
+	struct bcast_audio_scan_cp_cmd *cmd;
+
+	if (!l2cap_frame_get_u8((void *)frame, &op)) {
+		print_text(COLOR_ERROR, "Opcode: invalid size");
+		goto done;
+	}
+
+	cmd = bcast_audio_scan_cp_get_cmd(op);
+	if (!cmd) {
+		print_field("    Opcode: Reserved (0x%2.2x)", op);
+		goto done;
+	}
+
+	print_field("    Opcode: %s (0x%2.2x)", cmd->desc, op);
+	if (cmd->func)
+		cmd->func(frame);
+
+done:
+	if (frame->size)
+		print_hex_field("  Data", frame->data, frame->size);
+}
+
+static void bcast_audio_scan_cp_write(const struct l2cap_frame *frame)
+{
+	print_bcast_audio_scan_cp_cmd(frame);
+}
+
 #define GATT_HANDLER(_uuid, _read, _write, _notify) \
 { \
 	.uuid = { \
@@ -2568,6 +3025,10 @@ struct gatt_handler {
 	GATT_HANDLER(0x2ba5, media_cp_op_supported_read, NULL,
 					media_cp_op_supported_notify),
 	GATT_HANDLER(0x2bba, content_control_id_read, NULL, NULL),
+
+	GATT_HANDLER(0x2bc7, NULL, bcast_audio_scan_cp_write, NULL),
+	GATT_HANDLER(0x2bc8, bcast_recv_state_read, NULL,
+					bcast_recv_state_notify),
 };
 
 static struct gatt_handler *get_handler_uuid(const bt_uuid_t *uuid)
@@ -2913,13 +3374,12 @@ static void att_read_rsp(const struct l2cap_frame *frame)
 {
 	struct att_read *read;
 
-	print_hex_field("Value", frame->data, frame->size);
-
 	read = att_get_read(frame);
 	if (!read)
 		return;
 
 	print_attribute(read->attr);
+	print_hex_field("Value", frame->data, frame->size);
 
 	read->func(frame);
 
-- 
2.34.1

