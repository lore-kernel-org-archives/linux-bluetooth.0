Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7609AC77B7E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 May 2023 15:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241738AbjEYPfT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 May 2023 11:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbjEYPfS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 May 2023 11:35:18 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488D0A3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 May 2023 08:35:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx+r2ORI7sGQ2+c/TxsY5B3X0FWWCuXmsl4JB74SEUv+0f9P1ommlNp93EskX71hpicjKP9HLMhgSTIBY69T0adCPWLOxHXad5H2TGZulwahmPRAYXPW6NOYHS7RbuHOGaaSRDToyaEdmA+pKgCEV/yAqiJUSlCth0HraknAVXTRFf0zphueYyz2EQz9+8esICi8z3g6m/aQKp/UA0O9W2i4PaJTo9xVlaasuIxSPtoJ+SbGNflbeKTfrT3ZAX43BVdu2UCPZjI5cPScyt9GNn5JB5J9b48Q8FU8B1pc+Dd3vgLZyM8yLKlOpknRDMzqDpV8tiwRTrbPoc2kMS0KHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWdnifu10Bn4XueLkGix6CSkZc7Tcs8J+s1YoDDeSro=;
 b=SfCFFocg9yaGshNrMCH6kxBvfznrMzxFu16+kncA2lf8nsa5THYeSsO2sDSHYfp+CpzQkmbk9S/Dq9kR6dGRgRp3djctASuF1NIh+RHX5NOtSzWGjLBlOfaA7vy4TZf62zqPngRR5BE7I5zYI9aC38ok1/H/FHepm5ntJ2Npi0gKKOJkIgCLlj+HCR0Bp6u+izSRRVSUSjOnt09VJco6LcspUZumVHkXSMSRRUVxzR6qfwaiutMY6f0+z+pD6LAdkEQE83QOeST9bR4TTjorMAjOTgOPK1EgabZmOjRJ1HWadDGI/7y7gN0b1xz1sNsqu0U+dtRPU/UlixSF887CMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWdnifu10Bn4XueLkGix6CSkZc7Tcs8J+s1YoDDeSro=;
 b=HKt3KMWtwcr6weGdEox/PfvRyjoDzja0MTgjt+sBm2SCYiSZWC50nAMyR0vMFXfnnvtQVMPVWd3ulVBjyQWWuv64TdbDiftHUnOw7wFl6u6oqlvfbQd97foUkfDG9YhzfCaz9COnCH8dAPr2oOKol+stjnFle+N5RUi7cQoiIog=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AS8PR04MB7848.eurprd04.prod.outlook.com (2603:10a6:20b:288::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Thu, 25 May
 2023 15:35:14 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::981d:d04a:5851:1578%4]) with mapi id 15.20.6411.029; Thu, 25 May 2023
 15:35:14 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH v2 2/6] Add macro definitions for BAP broadcast source support
Date:   Thu, 25 May 2023 18:34:48 +0300
Message-Id: <20230525153452.125789-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
References: <20230525153452.125789-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0001.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::15) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AS8PR04MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 95cfa44c-6842-4ea1-ea94-08db5d35a26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d0gB+834iDlzsemo+SSmTZx8ueZ8/6yz1o2omG7Fx5ytjFKwvQKkEmsdRuDedsdYEzREQCLZDQzfy/cmR0bu15N0Q3coBk62ULrtIRRZowqpiUyYuflD+Vk5xsII9adi7RfgW/V3i7AfE5R7aLC6uGTv6Owhs+lh8JFvxer+5U0z9xdvGUu2T/jN8cLw1PimDTqnW/RiDUDHoKvHgj4EZxaOW3J+iBNM5dPK3GrpgZmqjLZQalIL0vQpGzz+ZySvnNaCsz+w1KMWPEbf0uA7KaHPzsOY5g7ktw0YO+A7TXYySVyBY6KpgLb+5SI+Z0ZJzB7N2plwGgIaimDTDIBIM1K+kQcgynrOim1N3pooZsFYFKn+l3DdEzN8VSo95Zpt3YKNHnY4poVslO4oyGkcUBL0QpkQgfCxO3V+2rojwrvgvjUMZLT0AERVrINEA22egvWqJ7VvtWrwqLE5nIrOIlZeF7E6/yOdV4Aw5tyB94e1QqxeefHcgGzq2dzhQtpG/UF2ip51OtBC1wkcpBWG1/KlVBf04vNarAKxbfN35QY5zWBb8/wRkZXC7zpu9aPXtP7KPhGNsjLrsCsXKwhyC/ifBrTTj5ejl1XrlWC7NXSNPdP/KXzDriz0zUBROfSB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(376002)(396003)(451199021)(5660300002)(36756003)(186003)(2906002)(2616005)(8936002)(6512007)(1076003)(6506007)(26005)(55236004)(478600001)(66946007)(66556008)(66476007)(6916009)(86362001)(4326008)(8676002)(38350700002)(38100700002)(41300700001)(316002)(52116002)(6486002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pPH0NFHZnkq7HYkLqkrJDkc658gVUjbeJMfnVEU6+yNXJhEqPgW8Tyufeukr?=
 =?us-ascii?Q?O5zaimKzGJrMZdRZGjdyY54bBadSVqtxhNgPYZTDphTxpaL4lSjo2oe0n8hH?=
 =?us-ascii?Q?tfs22UPY+HT3hqE/IP/cYGXKESmaElEjLNymXFX3S0UjLdq3TUKHLhy3fGnX?=
 =?us-ascii?Q?+IBS6B8ch39T9S4BBfie495nd/eBWRGb0wG+BowROO97LVHf99V/ZT7joYIZ?=
 =?us-ascii?Q?e0mewE7LTgg9TM892IwiYZm+tgr8/Yyv4gM6ay8u2rB/F7bdZsHb3RUgJ/92?=
 =?us-ascii?Q?D7cFW1cMmr8U6GdsXBcs362U/8GHQejb+/C7EnVwrKsOZILbZgHCgYYc6IcT?=
 =?us-ascii?Q?EVroMFN32DhYVijw7kSfa1kZUCnimrfZSIpPnh+pEo3t1i4ySkdnmNWiEWu5?=
 =?us-ascii?Q?iv/ccRS30dxUt9wFWG4bjoMNC6Kl72Qk7LaJsLeo7K+3PGSZlKcAlLJpzWUl?=
 =?us-ascii?Q?eerQYlcO93syjKKXS3y04aBYGKjF3yhlP1Q4tjU7/DCPHXMDxwwT8W9Xga9B?=
 =?us-ascii?Q?p0Ab6doplHMvQ3Ulwx2sKVJw5aUhagyYuQ+1wISpd27oEREHf+s28q6fkkI8?=
 =?us-ascii?Q?lFfViV8d7Cg25W4w4S+it9gdch/AT6PVmT7LLsRTmJ7zO0HpSw22Lop8wkGM?=
 =?us-ascii?Q?+q0Y4MHvDMKVVwzp5oQdCQWs/zuv3spHdwr+Y0ZoTok2S0nKUqUc0QaKe566?=
 =?us-ascii?Q?aiH+9qLBsj3GUoYtQ4smQR+JM3/RIW41E48WNO41dEg+nKnV5iThSoW75+xK?=
 =?us-ascii?Q?R6MltaFBxBk4LmPm9T2aiLtksi3Ut3UTZ/08DXigYd4rMqGjRtJoEiKtbRGe?=
 =?us-ascii?Q?pxk90MbXMJ4zDLBZYe1coxJ2/EQdu5asYW6kxNLjjy2B6RPaG4Kw1Y7bZDSH?=
 =?us-ascii?Q?7cidjBXl+ZQFEwQp9SLm8/fQyieKVGeoMfn0PP8EZpkQ8ikO8JVTCzXh5Wph?=
 =?us-ascii?Q?DO/ez7GPj5AYj0s9DXlMmctviTliMRUqbfUx3lD3HtjDTaEAdl083n6msMzq?=
 =?us-ascii?Q?MPh5UZ8S2hJgpEbAooUCgJVOin3+bwf6wlvzGiw1pFuJy15bIcyFhNImhA3s?=
 =?us-ascii?Q?uTwTDIKElrQGXMznU3poTvE2QKRO7Akvbqg7z9r2p7v+WVHwf+LSZqZS9b+X?=
 =?us-ascii?Q?qD++5UfIYSqu36I+Wvd6umQibm9JQENn9g7MkhunLD4kpX02bZw5ZsZn5Jz8?=
 =?us-ascii?Q?Qq3DL3nodhbwkBk2U69BTQKFEdNanmeb4FaswGr7gkqVpbhsTmovVsUTxCFp?=
 =?us-ascii?Q?HH8eQSfHUDfFReFeVyi7eszN0MWSiQtZzDBmybv9qDT7LgzlpUdVPFISg+yr?=
 =?us-ascii?Q?workYMdy4oVuz0ynBODSRaP4whOSbSO9W+MqB1sI+rvv7y9OySoaSWnmzS8X?=
 =?us-ascii?Q?DdpgHDbHBLtNzgQ801/SQVfjdQxNLVIysaoDElC8ESNuxY6jD8o8/8N6S4I5?=
 =?us-ascii?Q?lNWnh1+hepAMfrmnh+TTsarBUv7BZOGLWNkCQiOqsWPb8y6EepjmzQZM2/us?=
 =?us-ascii?Q?lmTZpiqVieIas9OJmgTjFJ+Ua9L5nL78BKMzthLVUDRxoSG1GDdax6bPwU/r?=
 =?us-ascii?Q?KJSgg/xnxd4FUaYWqVv6HeKkv6qoRjGG8GFIMs3GXEkD3GjZoc69lv823J8S?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cfa44c-6842-4ea1-ea94-08db5d35a26e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 15:35:14.4402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LNlH+a8JyobmJJkYvLDRVN8zN7EOWgObfVmvg/TyCpMItJxGBIfASpQ1gJk5YhONilVPV9LTYT8TXZhF7t9u8gVPQNE0zEDpeSfOCDcMD6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7848
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds macro definitions for BAP broadcast source support.

---
 lib/bluetooth.h | 9 +++++++++
 lib/mgmt.h      | 2 ++
 lib/uuid.h      | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index b4bb6748f..ca4b0115b 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -150,6 +150,9 @@ struct bt_voice {
 #define BT_ISO_QOS_BIG_UNSET	0xff
 #define BT_ISO_QOS_BIS_UNSET	0xff
 
+#define BT_ISO_QOS_GROUP_UNSET	0xff
+#define BT_ISO_QOS_STREAM_UNSET	0xff
+
 struct bt_iso_io_qos {
 	uint32_t interval;
 	uint16_t latency;
@@ -186,6 +189,12 @@ struct bt_iso_bcast_qos {
 	uint16_t timeout;
 };
 
+#define BASE_MAX_LENGTH 248 /* (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH) */
+struct bt_iso_base {
+	uint8_t base_len;
+	uint8_t base[BASE_MAX_LENGTH];
+};
+
 struct bt_iso_qos {
 	union {
 		struct bt_iso_ucast_qos ucast;
diff --git a/lib/mgmt.h b/lib/mgmt.h
index 59273c85a..c3c905232 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -102,6 +102,8 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_WIDEBAND_SPEECH	BIT(17)
 #define MGMT_SETTING_CIS_CENTRAL	BIT(18)
 #define MGMT_SETTING_CIS_PERIPHERAL	BIT(19)
+#define MGMT_SETTING_ISO_BROADCASTER	BIT(20)
+#define MGMT_SETTING_ISO_SYNC_RECEIVER	BIT(21)
 
 #define MGMT_OP_READ_INFO		0x0004
 struct mgmt_rp_read_info {
diff --git a/lib/uuid.h b/lib/uuid.h
index ddde4bfa3..5cdfedb4b 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -157,6 +157,9 @@ extern "C" {
 #define PAC_SOURCE_UUID		"00002bcb-0000-1000-8000-00805f9b34fb"
 #define PAC_SOURCE_LOC_CHRC_UUID			0x2bcc
 
+#define BAA_SERVICE		0x1852
+#define BAA_SERVICE_UUID	"00001852-0000-1000-8000-00805f9b34fb"
+
 #define PAC_CONTEXT					0x2bcd
 #define PAC_SUPPORTED_CONTEXT				0x2bce
 
-- 
2.34.1

