Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28B0C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 14:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235566AbjDDObZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Apr 2023 10:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235488AbjDDObW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Apr 2023 10:31:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2083.outbound.protection.outlook.com [40.107.21.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345854212
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 07:31:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epbrygQyDlEdrMKoIM93xZTQHEvIoWclw4XERdWIkkKA58Z4A7ZxQoe4MdWUi314qChvHJS4Q6SNKV6IFN9xCE0Bj9NZyM1+MyZ/U6UGfwNtkWX3QuNzR2trJGO0+hKRfK69+syGfrD/0rlJecXH2cMa4+DZfd3rZvpz+goulh2QN7yGIOnkAFGMMKGfU6Yw63VYO6kku+np6zC68P0SzZBGS0x9ftfAR7FbIUhW3FkKXrtvgCJALLOf73QK8Xs0fovwms4g1sNgtQKDHGxh7KxWvanbTubCdyacqNdawyGLCCf0vMaFNQ13zISYhWYaPaqQAQwd4hWaWmxoUYiAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6DGkl1jlquw4gJIkLbaIimBoHANQw2Sj4obownAXTQ=;
 b=C2HndWVUUiJfk/rmzS6aQM+JuCq3nZHZDXx98pODXYoAMNIllInSoGtvpizAFYj1ckhROoIpOdKQnO1GfpKGhqnLFm9REzTuZ5MntfeTk1+c2rVVnvK9FYEu/PwEgW6XiTb25f6UhthGchlrrjynKi/f8WYCo2uDq5tDyO/TsULN96VqVKNHpBo+uCiOCl1pvdpiHsrRNRKOIKoN2a4sDJrS+tv2zsRB2Q5IVDFrA17ozlpr0cGeyBRfLrg8CpQjti3U/kZKL9ol5ONWB2tX78fTd0z1NMdB05khBNdOrCjm6EogL68rqplqFDWVlqDhgAoX1/SWyen5d7/WALX0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6DGkl1jlquw4gJIkLbaIimBoHANQw2Sj4obownAXTQ=;
 b=VHT9jQYhxZSNFQ9hgqHR2vMLd9b4OCBPkLHIsR6O6+lLtJm1WDJWuuhX4fsgi+NF1aI2DfH+mUm4a8dzGkA37iD3TuVNOM+QVX+Rd8+ZzftijYJqHU/HrzrLtkPxVQqXqj6T+lgq56g6vATFs2ESnd1LIi5mlV3u957DFj8YaII=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7645.eurprd04.prod.outlook.com (2603:10a6:102:eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 14:31:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%9]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 14:31:17 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] monitor/att: Add decoding support for BASS
Date:   Tue,  4 Apr 2023 17:30:53 +0300
Message-Id: <20230404143053.101464-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404143053.101464-1-iulia.tanasescu@nxp.com>
References: <20230404143053.101464-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0018.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::23) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 1074824d-ed02-4230-9d1c-08db35193fdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Makdk1Vzyu3Bg89XYz/gwv0XDLd5RgudL028mM05w6Y4dpS6noVbPay/iluBeAQvHt9pnbUoIT0Fmvc7IiXn01hxA9P9xQ1XRfayPK2Z+KawwhGRQl7OlRUav80dq+vqg1kxWm2rnIzYaxrUH0540aaa3GfhT9RiUkLNV+lKZrCfIn9p0PAv1bffO9rkhMuS9y9o4n6H5Spjk9UzjVhAVNqlEpRd6068tjXuAlJ7rACCU1QbOhHl/YByvs4xOvyRrcwjWzljH8c/A3cnfOIRWJboOJEsbgS+1kQbRW2ntK3oFhXj+IXBNLRr74/F8MjFaghL1R9VbDVm9yRgZLhIYghS0jF7gwF0flO+2V2xp1jkp9KHow/RH4TnCLg0315X5jpIv2xZtpd6AyrYU8d/sJDaG1ugmiwbULaZy/ey3v5/wIoMB3WFIHAeU+gv41aPb+Y9hGoCGAzrUR+DQ3ahyRzulIamMyPxrAMlahFCWK677ys8InI7s+JWV5OKvdrUUwFFQ+4qwRTzd47GUoC2+g1WC/Xa7xgGDbYGPM9D1CTQnglSdOXoBbhd7SI+kwzjNb6aprNCrzj9NkPqD1lRVNPisrQOAN3FI0oHHuYfpix0XEDj7ICI4m1guiDmQdho
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(83380400001)(2616005)(6486002)(6506007)(316002)(6512007)(52116002)(478600001)(1076003)(2906002)(26005)(6666004)(55236004)(186003)(44832011)(30864003)(5660300002)(38100700002)(38350700002)(66946007)(66556008)(66476007)(41300700001)(86362001)(8676002)(8936002)(6916009)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hSHYe0zdp+yk+krfzpwr4lPLsgvl3AlpNxx3/1FMTpgwvykGW33g2swEjy3t?=
 =?us-ascii?Q?//0LuVv9ArtSJpm+90nrIczOylISIJzTsNkWHaKT32lfkHhzCaXLnEcpKtWz?=
 =?us-ascii?Q?AUBK72yFOnY356a2/JWFnbb4KQQEQvAWmE5h23/IsSRSvRWn69QQ7MVj+xUJ?=
 =?us-ascii?Q?rmNogKPYfNg31VYylaPpknxzcetRZxCEcc8oSP7oHIJS7haZJptEyzjzQPjd?=
 =?us-ascii?Q?e7ENJBgMMkl0Ywba0aEJTLV+jgfk+iRkdIofWs2UXzXfg/Vh07N1YNMv8hGD?=
 =?us-ascii?Q?fIj98mKgy2g24bL0lLKMH6/C5637FKe6qGlCrjKZnMUMyekMN1iQb06KEgBW?=
 =?us-ascii?Q?Gqp3ujHzQRkdKeJFZlBBSeVpKzi24SEigpM0MpcO8GwN95E6CxbYvPjlCs+Q?=
 =?us-ascii?Q?vFK2ow/RBOncTug7ojzaWE+pR5DTLGE0OeveGxRuTMNcSb0GEA0k+ye7XFQ5?=
 =?us-ascii?Q?egclxFgrLvbEKkMhQs6fPNDLIAjBEdWhMzxohifAhTogkvJuehGo6unPhceZ?=
 =?us-ascii?Q?QnEpXw6gU1HVoupzxmRRNkVJu89xf2zyFiVdz90ANvkbyobWrOde2PBGSwYU?=
 =?us-ascii?Q?AyoLSBriCmFGA1ukJYBBNyqpb2QG7GvHeccet3iWSoz0txHZdVxhsnUfboeb?=
 =?us-ascii?Q?0CjlRp1Fhmx6MD7aj7KGwfPfOIH5M1Dt531HXRfgBEJ34tS7mi2sGuYSh2Sf?=
 =?us-ascii?Q?Z45/Ce36WBh5p68Y7TuakavNu39Wep7MTVzEhXjf+7dIbwwvnnkkEG2QsAmK?=
 =?us-ascii?Q?HTexAahM18Da/w0z0G8k+7fthPHtChyYefYy90YGuJlm8XFgDvnQlDIyehHH?=
 =?us-ascii?Q?I+IpUna8poAvJLi7Vl6NVU7940poTySQR/pBbVb3G2BM2u8w5p2GDxbynpF1?=
 =?us-ascii?Q?LGpLEWhKNsm7q6vn0N86qw3nSiUaytsqF2CoJ/1CZ9+7Iv0oiY4OoYSzwZu7?=
 =?us-ascii?Q?iRIyQClR9EecZpCOMbZhCtHdUqFhFUHVEAjx/QHRMOxdeJ/scO4ETm75romD?=
 =?us-ascii?Q?hPaD0kA4NhxUeIrHqXs2ImNZR/P+5OQJIiIGBzsmrPVK+546XHe7/aOl3QCp?=
 =?us-ascii?Q?LqXp7SUBPWtJ7ps3yNiq3lwmzT0nN2ceEtle54nMuJwn7e7580asfeNN01GY?=
 =?us-ascii?Q?XlKmwitWp56RwOoEj6bXxpYoHV3JHCIBzC8UjgwXUGPquxQf4BrKI348C4Yi?=
 =?us-ascii?Q?AdFKKN5mXUo3e4F3mrDzqLe0ULn/lmb66Nceyqzf4xMBD0NwAOoW/JjV9zvg?=
 =?us-ascii?Q?Hc4jVryp2fepQywEKCDPaWyzSuROwnS2PKn2hmqgVYGRqYkgaiOmrPOWw/6M?=
 =?us-ascii?Q?SQPegTmp4ullF4A+iD8ehas8u3ZbyMgd7hutOCw0Jq0pyOa2X3KYOJLSeVF4?=
 =?us-ascii?Q?N0ygQlCw+JB9AprwH+Qor2jO3UWrAR7itlp1RzaqW/sUPBF1S/6eMWnaVgKt?=
 =?us-ascii?Q?FLTneef6Nky7IvsaghTfG8LoGKuykArg4rNsMEAC/4mjGDlMorXCeQPtJi1m?=
 =?us-ascii?Q?8X6Iiv3o6qt5CiRcdgOJ9XWy9NVePmsClqMibqzuylcHjCD1Ar4Sej4hnvV0?=
 =?us-ascii?Q?y/iAqFz9uBlvuBPhNEhWKx3oENrcRuNh/mvoFXDFSyPAJkTbt2JISpqFGk9q?=
 =?us-ascii?Q?lQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1074824d-ed02-4230-9d1c-08db35193fdb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 14:31:17.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qke0zAiK1cwIFcp492FvwgKZ1t/Y5D52LcomkZ/YtOq4PX9pgRmgP+sK+m9BohCqmN6YpLTSmOlzlMn2s+NAGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7645
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds decoding support for BASS attributes:

> ACL Data RX: Handle 0 flags 0x02 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)

< ACL Data TX: Handle 0 flags 0x00 dlen 45
      ATT: Read Response (0x0b) len 40
        Value: 0100f2698be807c0013a65010203b803eac6afbb65a25a41f15305
        	68020101000000000403020400
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
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
        Value: 
        Handle: 0x003d Type: Broadcast Receive State (0x2bc8)
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
 monitor/att.c | 461 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 461 insertions(+)

diff --git a/monitor/att.c b/monitor/att.c
index ff77620c5..4baf029ed 100644
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
-- 
2.34.1

