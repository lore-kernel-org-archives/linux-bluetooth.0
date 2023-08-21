Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66EFEE49AA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 12:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjHUMEd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 08:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHUMEc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 08:04:32 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC19890
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 05:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOmYuPEaHfLMM1pcgvv2ukJ4faVNuzQ5l4WBjvfZZrTlhVsoLDnzJBIaQdq91zyvWp3R4VX52kujZAlTxPSTSFck9qFrswp5kATOwqxW6td/R3xWc4B8qA0PuYabbmYlPf7pHTGjzTYEPvpmnaxE2wqhEc2Zi0DypDP+gsRPNDSOJkc81RlsHacBhfZZJGyFm/BtdTffFrhNq66Vbt1tVALsqPLuaH8YnU8GA+I4njXCCnIY2jtwT/q3oT9RPGT5nztckMaTQ8udqs0xWctpNWLkY73i0fYQ4j08Fh6X6r+p1diPfzyEx5xFXPuyXQeDQgGtiS/7thAp7tZzpADJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwghX3PRVHjCWeOoMTIP7SVIevhN1EwMZcYcAgbARXw=;
 b=Yt7WSYuR9fOSGANSHIQmC9/QuSuLTIND4GgWdEmor3Bd0DIMev9Lr/paYKEUARg1lW8tTy4BR7k3c8nqDmlxfLSX7fuikvDEc+7drozRh0cmZRsooyva/kbH1MbqkXqKAjzI35gWrpf9jv+gwRSJPUIZLMoQ44h+G/d1V/dwTnpepoNujUDwDih9Fk0LFe7DneL68eQXFY1FvzuFtorMN8Nt4Cl7lT4r0YhMetBg69KmtsZfUp7gNSpSDutv9PsGbzuWB9QFOo6t4ZxtE+p+YVvGeyONxGNa0yyxZid6gtSPAYvRwRaK853wL197ir6y2Vpn3tqoqMuFJGWXcqAVnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwghX3PRVHjCWeOoMTIP7SVIevhN1EwMZcYcAgbARXw=;
 b=KJOdLlrADYY9zkTRx6rEmMCuwSpQ77b7nt96QkZ3/HKQW55lej/9OzAOG3jLAwCA5yHADpJIsASZvmW1cHHNCl5ZGtpFnMJGnfDJl3Sn3LBv/tkMgMnwr/QPstJY35w3ZpCARLpxAQmRC55GgMPfSf0NbqFQ1dZsCZjrOnqNqlQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU0PR04MB9586.eurprd04.prod.outlook.com (2603:10a6:10:31e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 12:04:29 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Mon, 21 Aug 2023
 12:04:29 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/4] monitor: Add decoding support for BIGInfo mgmt event
Date:   Mon, 21 Aug 2023 15:03:51 +0300
Message-Id: <20230821120353.28711-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821120353.28711-1-iulia.tanasescu@nxp.com>
References: <20230821120353.28711-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0039.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU0PR04MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: 6392e7af-8d2b-4c2c-c7b7-08dba23ec5a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZEv7sig3CgRhLwRrm/R3/3xeS2EsNXyg635f8j9vugt80awlia8P2Xc4bB3XxHAEUmJ4yIMMi4DuIZUDy6PwJqubjzv2IASBxcdiNmuZkk81v/9z9O7b0IrKk9Yeg9YS0/LwWI74ko03WI6xW30iTV/SchqcopCEFSRpPh910UqFmeOOhmRwnb8jCtWBFzYh0+Pb7LfN7ok/VltPHMsq8lFg2BTpJ+ZXKRSZHPuYPFnKDg6XZ7GvTpJqXK1OUu3CTGnILFNlwyFXLqPlG5LjvXZzM2We3RvmsoOftGsPG9EFVKz3rK8NS2/WNLTkVZRWKJk/U8tLngCJNKNZGq/KaOmBN6DsJ+Uu03dbl7TkBIKiDsX89niwkABAuOeOKqUWSv5WV4aBWoyXsfLiPrfeZQQ9AC27qKj/dvSVldHlzM8XV3rCRoO2++I82G5nq/pp/CjuT7lIwOKi06iTLtJcg48yY7kvMDASwNvDiR5rC6OrojX1XhZjrl6M7Go71DDwOCg+WuaxclPvTwFnksqrUqavFP2Pmubamtw0HLvTeVgM8vVnuevJtkk401zscyYMz/09zX2BStaI77oVmQMc4Opz6ZaRCVJlR7dWSCs+WuM70O6XMad0lJyuCW/exa9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(1800799009)(451199024)(186009)(478600001)(1076003)(6666004)(55236004)(6486002)(6506007)(26005)(52116002)(6512007)(2616005)(4326008)(44832011)(8936002)(83380400001)(5660300002)(8676002)(2906002)(316002)(41300700001)(66946007)(66556008)(66476007)(6916009)(38350700002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NrTja8iFQmDk6kt58cjDFmLPsOR69WRgcqXiW2yt95WNt0n0mzr8QQN+vmkH?=
 =?us-ascii?Q?QTtcmPVKE//jSAojRdGC8xXp3P+jMSoNuXz0ds7csZel3q6CcCgidPM3jS6P?=
 =?us-ascii?Q?Bw2QOa5QWNnNythXCiAp+SR45qtyC+uTlRk0Vy3d4e/JIRZUR90SEqMz/a1A?=
 =?us-ascii?Q?fROziYyNvto1m8rlnGlJb4ychMUJVfhLgDfW/mvFGHoON4Zw4gknlcBM6CsU?=
 =?us-ascii?Q?vMYz6QndheK2J2zs+a3L8rSvgYFSHd7vVcnyaEBLXkbqqx8ldhaw0vrb3dIE?=
 =?us-ascii?Q?VzWaQCvp+047MK0AE9it4R8N6AAPrHIDQW2t+i4856uaU+1QWooy4/RvQ69t?=
 =?us-ascii?Q?dl8127jvE8zm4E870ULnYGItm2hRDZfGUk9nnfdF0yH96fyWosJMKVX7eZij?=
 =?us-ascii?Q?4uaNVxzbaRTSpFplaY15vHNbrjN6VehNLmtkizi9zCs3uZEkWvv2JQvmcRK6?=
 =?us-ascii?Q?5X2Aa1rr8rrsah1yZmfIX+sycycy5FRzRgH2RKPaGR/ZKC1GgGGFj4Q7Nbro?=
 =?us-ascii?Q?tBwnsk1Z/ZMCiJ0q2G6icFU7YMhrgTpD1Hpu3EVgPtIug/9nz/YLFZyvp4Vb?=
 =?us-ascii?Q?w+wS5iFRZ5sILkasw60hegl/QWb5AwZqZqRPEVC0JwsiIHkawfF94T4j9B8h?=
 =?us-ascii?Q?KyMgw5ItAYC9uO+LpmD6JRNeoY7LzzuMSbLaUW0aZLkyV0kE2zQzMk4N7/U7?=
 =?us-ascii?Q?9QriDJChilmFcXikCLOL/NBmHcwMFO+NnMJUXbExmqXLjaE2N744GJs+Ecyn?=
 =?us-ascii?Q?FFiy5/mXq9pcDnv+1BNelpUZH70ujC9eUeMnRQb7KbjeyQWEZ8IESe5/1QkA?=
 =?us-ascii?Q?Y/e8QtirDXofAihDhwcv62bigKtywWI+SEMwV6wlhPM3k3xaUFIGO6FigYMR?=
 =?us-ascii?Q?rT66uovLYqocYziGCRWiFh8cP4ukZfpo0fXU+Iu+nFlOoDDxEYJCO0zywm79?=
 =?us-ascii?Q?pjZl8HJwrTSniPO9v9phCnMyyBvhEdDO24Ugl3VWQwRvQvvyv1aZxduCNyNP?=
 =?us-ascii?Q?FWKtZuYfVxVnTF3IAFo38rdlfL4nT1jt2jcM0KpyBhOi4IMS35yrYeNj+TAA?=
 =?us-ascii?Q?xSTVzl3jsdvQ6jqXxuHiqLKnKjtcToDlnNrARp6gb02Wz/LDi052dG5NcbLh?=
 =?us-ascii?Q?HXYXfMi2HpijbhRA7d7tW9kgl6xo0zgPzM7Ru/EpcQ+SugFo8XcjotQykyND?=
 =?us-ascii?Q?NvTLfY+XzxuCgC/0Zr+ykjNwbtu86qHmssEJ7X8U9OZo6XNzYVpRBlypPsZs?=
 =?us-ascii?Q?x1Qbvxl1DBNeK6nfAjeFFXmG5o67pq8saTZg12NdX0CbbE4tnB/3Uqr8mHyp?=
 =?us-ascii?Q?pcUxN/f2Nv1CMBG+AvDdjqKmunH0hbSf3TZpMmqcePSL+tcobk/IaDFdwK+v?=
 =?us-ascii?Q?Q356Qm8jeV/yiaKCn4W5/mZeHEOYMDoLpoETmxRbhhuaFV/J7n48/BBqZw1U?=
 =?us-ascii?Q?9toe7XsK+r1jt26OP7778fauhkqrIBko6W8vjBqgOKqlHs9o6jdk6tZcRkQ8?=
 =?us-ascii?Q?vz4AT3CaetnfOR55uPmiOwIBrPgnoIu99WEhY+9lkLHmhCcHafEGiX02WKje?=
 =?us-ascii?Q?kZfASovB/S7DqE7heSJccAVMb63qW5aJLbOedj0OFXX7ci59sQVRlpSzs0Ld?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6392e7af-8d2b-4c2c-c7b7-08dba23ec5a3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:04:29.2256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ky9I3Ht7c+XshHhRGMtm+FZWheu0TDE2kXRAR8OrBaJS0wUdjxJdmoJJ74RhusZ/3fQ/FQFi1YinmUPxh7U3Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9586
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds btmon support for decoding BIGInfo MGMT events.

---
 monitor/control.c | 25 +++++++++++++++++++++++++
 monitor/packet.c  | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/monitor/control.c b/monitor/control.c
index 009cf1520..b843d076f 100644
--- a/monitor/control.c
+++ b/monitor/control.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2011-2014  Intel Corporation
  *  Copyright (C) 2002-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -788,6 +789,27 @@ static void mgmt_advertising_removed(uint16_t len, const void *buf)
 	packet_hexdump(buf, len);
 }
 
+static void mgmt_big_info_adv_report(uint16_t len, const void *buf)
+{
+	const struct mgmt_ev_le_big_info_adv_report *ev = buf;
+	uint16_t sync_handle;
+
+	if (len < sizeof(*ev)) {
+		printf("* Malformed BIGInfo advertising report control\n");
+		return;
+	}
+
+	sync_handle = le16_to_cpu(ev->sync_handle);
+
+	printf("@ BIGInfo Advertising Report: sync_handle 0x%4.4x num_bis %u "
+		"encryption %u\n", sync_handle, ev->num_bis, ev->encryption);
+
+	buf += sizeof(*ev);
+	len -= sizeof(*ev);
+
+	packet_hexdump(buf, len);
+}
+
 void control_message(uint16_t opcode, const void *data, uint16_t size)
 {
 	if (!decode_control)
@@ -893,6 +915,9 @@ void control_message(uint16_t opcode, const void *data, uint16_t size)
 	case MGMT_EV_ADVERTISING_REMOVED:
 		mgmt_advertising_removed(size, data);
 		break;
+	case MGMT_EV_LE_BIG_INFO_ADV_REPORT:
+		mgmt_big_info_adv_report(size, data);
+		break;
 	default:
 		printf("* Unknown control (code %d len %d)\n", opcode, size);
 		packet_hexdump(data, size);
diff --git a/monitor/packet.c b/monitor/packet.c
index 8eae8c9ea..96fc2662e 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -15396,6 +15396,37 @@ static void mgmt_mesh_device_found_evt(const void *data, uint16_t size)
 	print_hex_field("EIR Data", eir_data, size);
 }
 
+static void mgmt_big_info_adv_report(const void *data, uint16_t size)
+{
+	uint16_t sync_handle = get_le16(data);
+	uint8_t num_bis = get_u8(data + 2);
+	uint8_t nse = get_u8(data + 3);
+	uint16_t iso_interval = get_le16(data + 4);
+	uint8_t bn = get_u8(data + 6);
+	uint8_t pto = get_u8(data + 7);
+	uint8_t irc = get_u8(data + 8);
+	uint16_t max_pdu = get_le16(data + 9);
+	const uint8_t *sdu_interval = data + 11;
+	uint16_t max_sdu = get_le16(data + 14);
+	uint8_t phy = get_u8(data + 16);
+	uint8_t framing = get_u8(data + 17);
+	uint8_t encryption = get_u8(data + 18);
+
+	print_field("Sync Handle: 0x%4.4x", sync_handle);
+	print_field("Number BIS: %u", num_bis);
+	print_field("NSE: %u", nse);
+	print_slot_125("ISO Interval", iso_interval);
+	print_field("BN: %u", bn);
+	print_field("PTO: %u", pto);
+	print_field("IRC: %u", irc);
+	print_field("Maximum PDU: %u", max_pdu);
+	print_usec_interval("SDU Interval", sdu_interval);
+	print_field("Maximum SDU: %u", max_sdu);
+	print_le_phy("PHY", phy);
+	print_framing(framing);
+	print_field("Encryption: 0x%02x", encryption);
+}
+
 static void mgmt_mesh_packet_cmplt_evt(const void *data, uint16_t size)
 {
 	uint8_t handle = get_u8(data);
@@ -15500,6 +15531,8 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_mesh_device_found_evt, 22, false },
 	{ 0x0032, "Mesh Packet Complete",
 			mgmt_mesh_packet_cmplt_evt, 1, true },
+	{ 0x0033, "BIGInfo advertising report",
+			mgmt_big_info_adv_report, 19, false },
 	{ }
 };
 
-- 
2.34.1

