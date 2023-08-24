Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0043C71145
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Aug 2023 10:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbjHXKYf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Aug 2023 06:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234609AbjHXKYc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Aug 2023 06:24:32 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2052.outbound.protection.outlook.com [40.107.247.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A9B1996
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Aug 2023 03:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ne+0aS/Qs2eJZ4Da83OJsIfC6yyMWoJ0DuXtsQInN2Mjg/7n9e3dGunGGdpS32P/nhlc25pcVGp0yy7Oez3wzbuH69iUJjhZXPUAdfyx+6CPysMZi9eTsc3USGSMELniveOEFICMgQKEHyw5ii53sx8aXJaOHpIAyOUAU5ZUAlWiuY/vvbbNirS4PA2Bf3vJjRVr9OwEMuSvvBVWI8DDdzYk5gBaiqJveO9kUBo71aaopm7xB3Wf+lsE1RsmQh5mo31jhN0H+6ePPFdEj/YLrk50AQieZoNWzjnFUP6UqJauSk+EGx0Ne2wfzp5W0cWmWPZvBeORbL967NvlLHRLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwghX3PRVHjCWeOoMTIP7SVIevhN1EwMZcYcAgbARXw=;
 b=HGD4reBvPt92np+d9PChj15TmQ1m/0+JS/nb1mytYwvJ8Dq0NA1+pvH1ko7ZcYy9P65ZU27CGpdljAJ7yunZDR7KRORRJq8RuD1RxS+Uf6UfmK28NqVe6YhZ7gt2B1xheKcWFUJ10o5rXpyiK0OGNYCpb9WJzruVoCYEzo7wxlhKTkhhEfiJEI2sHgNqtg4rA2gVQjmXR+KY3MlFTkGm4V/4mL536NwC9qDjK8egCH4jKltaSdC1cv5a7kfL+GFlG+1LPf4OYckl00LOdpVGgMzJlpSfgiiNDOQ/P2s2/Z69gZ+KaHh7MrciM9WHMj7MZ1NvMhKQs1KfvqhuAq/ZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwghX3PRVHjCWeOoMTIP7SVIevhN1EwMZcYcAgbARXw=;
 b=Xnhtl2Il8FK3gPm2Z7LKtHSU16oLJKpYHEs3sO6OWJ2xeyctInYwxwgf5ZpMRQo6RQmCacG1YmOxg6ZPYspctBsNsXh01aQ5B9J5bq9aszw63CZGpC2TBx0vDgsC3GMkSj1FyqmRwxorehtp7vzjgYEeZws2gYSblBw2dJVGe38=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8625.eurprd04.prod.outlook.com (2603:10a6:20b:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 10:24:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 10:24:28 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/4] monitor: Add decoding support for BIGInfo mgmt event
Date:   Thu, 24 Aug 2023 13:24:05 +0300
Message-Id: <20230824102407.25883-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824102407.25883-1-iulia.tanasescu@nxp.com>
References: <20230824102407.25883-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0050.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8625:EE_
X-MS-Office365-Filtering-Correlation-Id: ce4b117f-b430-4b94-84cd-08dba48c4c36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P0KYTv9ekViyBRJpptmrbApdSBVU7mcg361AHHcvA4AusfzCJKtXFwCgOMvojhBD+Y6i+1tqCMgiefkLE+ptVK+PyjDLyV1BeJ3ib9D+37d6WvKqtdVUzQlLoL2RTX336ByivHQLAmBJfuustQ/XT7RrlYWtikUOdonpT6xCCKaV81GEOi9nQa4sjaZJSdRebO1OIXBBK5G262ojrG4DwCfgVHhdZrqyC+3WS7tXUSEtvN+I/PoI0pTei1Wk5F3gMRuSDLh5qM04PGwTXXhjPrWWAoEA4b7GDoOL4gsn6ZxBAwWvVJamgVB0QlfkdwWFXSIbDrZ6COM/xXe3PmkZ/RHfLzc46xRze27hj5XTHtST7wQez5PHww8IaMQxpxAw4x3gU+VrMk0Y9kiPh+fUEcZ8z+wUPsamb8fjbXhccQ5o78LXBRU2VP8UjhaCXs7Ow/VV1dx0kO10NgYkN7E72yD2VueF2uI4SBhz2EIKmePCSn/zeB6wyIoYULUg4rGhJZ30uOc7OISCq3pJsgNqBDOQRuj0gUZ9Ex62SRa3VfTEt7QhwsGiV3xciZFUxK/32sjmbQtkPpueYukAzr1lJ0kWh4dFEEWBHQsmXy6vLT3ENTGGz86bS0KtIyV4OSI9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(451199024)(186009)(1800799009)(66476007)(66556008)(66946007)(316002)(6916009)(478600001)(38350700002)(26005)(44832011)(38100700002)(6666004)(41300700001)(52116002)(55236004)(86362001)(6486002)(2906002)(6506007)(6512007)(4326008)(8676002)(8936002)(1076003)(2616005)(5660300002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nGhs8auViD1GtdSMAdGUxSm/DbHJvHsm5rlGHfWYGtSOZcEjKM3rvF2EobcR?=
 =?us-ascii?Q?9kLPIh//GMXzwvg0+uHTft/Sbnoit7VItbybWJKkvpJXQbxLRin4Kl3+gT/U?=
 =?us-ascii?Q?MDHAMYb4QI07aZlx6bdjTCJxk0/HUNE+YFTESg640eKMXCUBPNvnECX/RmxC?=
 =?us-ascii?Q?SLqRxErR1DbK3eXcgkFClaaKVkyamdDTuzR3CNlmAXuDyB/LrFpXK5ktAGI2?=
 =?us-ascii?Q?dKlaGkwUpUASZNaEJ+N7gafa2BWDyAK2BHrwX7iFdZ2NhjHrTbBiHebjMR1r?=
 =?us-ascii?Q?6GkKQuElzaV4fm5T3hd2rn6D4N3/1uVxgvpHuBg6tAgiPYGWcq//N8wg017S?=
 =?us-ascii?Q?ZSHhEIjSD3D34D5rETJE3t8ApE21fDIM2EsPiwPo7softPfbEmzRW24uZTaR?=
 =?us-ascii?Q?9jDzlAwBAoTir6KcgzBvvun3PdZE73pb4pAOjz0mF1UBeHE5BTfZGLIKMXBc?=
 =?us-ascii?Q?hyETmvhZ8iaUjH0zP0Dpo1U2liYmRzhlCqOMysg85MOlGeSMXUeMVh5wNKiO?=
 =?us-ascii?Q?a6796YvjTIKIE6Pnq57vlJC9jEFjx9RycRCScNrNCLtBZx/5PkOIG8RPKIs3?=
 =?us-ascii?Q?JeZCWKayfJlypraZzCPnDxfqM7q4Aas6HQMxmCsp0wlT/vJ2/qLaAkxb8CxA?=
 =?us-ascii?Q?7rUu3s3a5oKrKmHcmbKe647hiHUA/H1WFgxA4zEwRRyRZu+2oB+XVdqOc02D?=
 =?us-ascii?Q?Rr0HAqsCHYPpDRWdFNTz2rlIiKU+mXArStJEaFrknW0r8ronzCcoexDi0C7D?=
 =?us-ascii?Q?3B8mzVDqpdqtOs1S3CzJDUaUyEORYs7vEJEy+oXMwBu07X57XLdhH6SVeYQq?=
 =?us-ascii?Q?WJx6VFJNvrD1+D++xjdcO8bmg+GVN3IR/nCLOkwIM3AIkK/uFy1RNJbYy/IW?=
 =?us-ascii?Q?k6IE6U9eB+B87K+lBzbMjDrWZpfOPRWUg2kSUgh2ro4dxPD9d80Br953MgGr?=
 =?us-ascii?Q?jsnI2ex/bSEamxTec8mzb89tf12Wv8qzcD5781ai+n192/Gt+Z8VMf4lMIoZ?=
 =?us-ascii?Q?Q4fPKdkrVvOtL6jkzfk7iLDx/9smyktqzZ4oPh5WuuWcimlcKMtZ/0IuBarb?=
 =?us-ascii?Q?T/vZ4nUP8jDHFd/BxzGpXoc/0/1fYKZdosjPCzRcuV2MiOyvU1WipQbEX8iE?=
 =?us-ascii?Q?YlzcZzqD2p9RblK0XsezpmqvcKH86/LBPDPftEEp2iEAgTKBZagobmDh37UB?=
 =?us-ascii?Q?LMLVK/6yGl2N0/QG9e5mYjGk2jqA24iHXcrmN5LEymO7lJqX19nFfcuCsfzj?=
 =?us-ascii?Q?mvYLgyFol02V155ceXLQv4umB7qfaLJrBWbgokNiYCMrbhsLMawkQY0XXJiy?=
 =?us-ascii?Q?F5tfv9Gu1HGD3Cz8G3rlSCuilRAGpyAz1OU4NVnZfWhv4C9tp0mgccGdfMzY?=
 =?us-ascii?Q?iajEWutnZ9bjS+aFDcGrhJjQKSGlWkjGbExrrSku/byIpSUVYnpHsdN+suQE?=
 =?us-ascii?Q?RFLd+yMi28T8itde3+dA8MWyuV9TK6L9oW1t/RfEo7egPgia7nl/xJJ8SZ5P?=
 =?us-ascii?Q?i5jVUXNaX3j1lfxd9c6xV6ZBKzbHnxdjKuEmQlCSomrr64EYjw4d/PJiYDvS?=
 =?us-ascii?Q?mUy7QmoJzFW6jNeg8KUNCg91YM304E1guURKB04DBuJ2jwD/GS36IBmitX3Z?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce4b117f-b430-4b94-84cd-08dba48c4c36
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 10:24:28.5333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlbEE+vZUOFbRUZzc5yUFlQAkXJLuLKn3gNiTVY2OxZmysAyACuss8Y6HfGSvzEQzjfWWY71gZVbiZT0x9x2bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8625
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

