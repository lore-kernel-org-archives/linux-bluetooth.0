Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EB0CD8CA2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 15:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233408AbjJJPjV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 11:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjJJPjR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 11:39:17 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34B393
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 08:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VvxkZvZRCiGMS+D9Uy8bWPCmutzit47yqaMXnWScW+lUC/kP2K6iBbEkVcvT9zaN5Awd+Vmv7z/8yl1kaxAELTYmLdHsz9rSlELZ6vkjWfinTZScph8mOTjDT9icGio/z7twMGTiylQzKfcdwKl0Nnf+fXb+Z3gxMxqvCIF3A1ztXJCYKLlFAokipIgy+uIIitLfqg7vCp6QXV8MCspprBQF8cf7vQQQl/qQdhkbRU1Zg6Zf0/cupldhVZ9hkAr2XvFb5BFhX0CVJS5DXIKmiCohM0eIz0ZPwiezee5CWeLpfouKDTghhUoWWtd+hgZHozuJj9KQDIDgrjUlfuUaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v6LOnU5/aByVjQoVb7+5mQOyMg+KhAMcBDJbMo+rrxA=;
 b=WTOqHtFemVk4KqS6W3p1jWfyQh2Sn3HxqWC9EmK/H9WqeSbC9Z1E0CiHWjvk0csf0v2rw9lWmhxni0Mf6L9NIzOEam7WlIerNdRe+gbbkC89TeGaZRWb9GnpQgvNeudACBll0v3VYtfjeNb4s9hv3Sz5VoWsXSb1LTd19JMyaRfjH84n+aWhHQEIQiGL+/JAWVkNa4pFEe37AVrwwkYODxqoAF5ycP9jfUdS0kLfdadnycuWqCmGBtZLlZHFhWZ8MRqw/3pt0/eMIOqLclUVx3p/gRaL+1oQZ7jJ99F1IV0TsWh+BTc07+BZz8cU5Nr+AImKwiuA56a6obD0MYv4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v6LOnU5/aByVjQoVb7+5mQOyMg+KhAMcBDJbMo+rrxA=;
 b=hgSBR5jLMEuQA8eIUHM1qN0fnUxccz0X3ZI6coBWDa42GCHPAF+/FAQj1pnc+ZvBV2sNq66gOTwMlIAfNdfxLvn7HkOcla1FB18Nb4/RPoZLObhQH6ghGc/YS0CUs1tK2aU4GfDV9Ytk/wHLM+X7NDYr0EVh5uUAbbP1rukaw3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7916.eurprd04.prod.outlook.com (2603:10a6:10:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 15:39:12 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:39:11 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 1/1] test-bass: Add unit tests for the SPE suite
Date:   Tue, 10 Oct 2023 18:38:55 +0300
Message-Id: <20231010153855.13825-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231010153855.13825-1-iulia.tanasescu@nxp.com>
References: <20231010153855.13825-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0226.eurprd07.prod.outlook.com
 (2603:10a6:802:58::29) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 0928beb8-ac44-4db3-0b98-08dbc9a70cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SUeoCdm3ccZYn3cmt+FpycFlAOKfxtGPEq9xRacz4u8bFGgZ9YTiwqX+OYgcUK9d7cZSwyKBcaN/sMP/p35CcXRvOcXcBNwYrsz2JMvP1ALt53tDFui5NpVuKfahsKCmn24Wude/KyDzlIJrkCglc8OSlReBISsyjg9VIGaLaf5BQS53neZ+doKGZoCGZSclflpHgF9xk3bv/LQeD8F5vFKZkXQPVHhDeF9FEzgdT4fylYu2b4p+pHA9WDqB9d7WWLf5vfxq2fvgTQKKT6Bl59feu5GY0a3ybEP1uFY5cUq24BbCBF0WLRf/LvJpzPC3mbNenOtgr9zJgvSLNG7MAolJANOwOrgpXcTKYxvRgMBPqYHm42E/wgOYXKm+dFnXMRErcHVRYGHn46j6LFAJDvjmN9k783l2Q/YyPXcA+KXILVQj3BKbWrDBb7AKSi56RZ0veDGR8b6QaQZ2yF+0jaYisuKAxaCA/l9ksNBlmeLWEIQRtXJA8lbuWboWy4NJlKBDYVFY+7s9Aozuh8iUVXM3rYmO1InVi+jSKk8GoM/9uUnv29obqggkd/Gtq2U4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2906002)(30864003)(6512007)(86362001)(1076003)(2616005)(6666004)(6506007)(478600001)(36756003)(38100700002)(26005)(83380400001)(6486002)(41300700001)(5660300002)(44832011)(66476007)(66556008)(66946007)(316002)(6916009)(8676002)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1daNVDbYzCFwVnQOSHR9UKizXMgs2v60C1oNAYEBCUVuQ9a798ZEW26jLu3x?=
 =?us-ascii?Q?iMWqxO+mVWeRSeBmxzS6e7r0cdkBKBxU2UWJbYs3Zy6FXCwgxrZCLdPEFRjO?=
 =?us-ascii?Q?nPkCzJVtgGePZNivLRe2rv857J86KMNFY79+lGEne4clmYYUyBs3BLVDojdL?=
 =?us-ascii?Q?y0xG41Tp+AufjOoRQWftpCjv2qCoLAPhAmDUdSRmAJrr2yxhuKDJkp7s4G1R?=
 =?us-ascii?Q?3sLHSriFr7s6XieTOnRt1d/aSNni3K/bWss4WT3gt4tipsGK4Iuvv4Rmv03o?=
 =?us-ascii?Q?VB+j3vCXpyTc6h5sqlvd+8DAHwQyqpXFOtLyJMROpKvtW2Lxo5VQ0qfTpCES?=
 =?us-ascii?Q?z+fZtso/P2yUs50WEOM5aVm0dYr2jXssGzs0Www3aGDNWglcvRNAofGgqiYR?=
 =?us-ascii?Q?Z9PgelQ0sM9tbLHWPExcNRVQGwMyu49ObW0laFRKrZ5adCL84yOL/QsYDLLR?=
 =?us-ascii?Q?bsKeKG1anWZ7avqLrqBZehp7+Ptu9aog9AM5PqQoUFY7hdKU7Hm1L1S+uvcF?=
 =?us-ascii?Q?8s6+aDIl5KN31QBZLlAr3mA1PCQx7u6DF6E/6HiceSeq7FH6gyA/GPH6b5gt?=
 =?us-ascii?Q?O2QHdNHUSpywIWNXSUrKoUGuapkZ/+zh+uqPYjPmc/qH3c9ibLtcqbNQLSs3?=
 =?us-ascii?Q?Q315W546glKKbYxUMdsDp9n03+WUj4vJWSOpcXXO8PtDsc9SNNIGbrzi49Do?=
 =?us-ascii?Q?BACw+xH1asmaiaYLVT3Lj6OP66XFvb7qt2qY/rLrhbDh/ovKC6g1QUnyr/4D?=
 =?us-ascii?Q?DDQGVy+ZsyzpAe06wu49U/e3qdIwrMJfCp0UwBERY66yWBf5DyQt1/OCz013?=
 =?us-ascii?Q?CLcAg00g/dJ81IlN/EfzBnlQAoLJlFS/rtN79kplS77d1U0I2iyfxWYD87tI?=
 =?us-ascii?Q?HHNO9Dh2BDOndzBq4FreyYT1jnP127UC1E4nMvCG0P0sDpO0QqOA/bu1yBcf?=
 =?us-ascii?Q?1QgjEOVV1YNW/NUIRr226qqQFwpD3rPUsqGgBDZkysOqSKUuKRNHOebnEcCH?=
 =?us-ascii?Q?0o0vB4VbRIucxmMML9viAfoaEzqgbDA6Xz0zxuFs8yQi0GmG6pbtiv6q2x3U?=
 =?us-ascii?Q?g0LhaAktfVeC8Ej/N0NTgqxRVIF27BeZ+PF4S+praqf+A4SjcztiUGsRMxcc?=
 =?us-ascii?Q?MNLTHP5sRnjS6l/qPxW9VTdrk3DqXZW+lrWb9WCNu3UU+s/PpQFQS8PfeC0b?=
 =?us-ascii?Q?7wRAjRR2OsWxiIK6UH6eCI+2EK9gR4cxJ6wCmtmKfFI/4Hl9yruCKJZkIuiO?=
 =?us-ascii?Q?KZUzeym02TVyikXbZM+J3KbNEJbwWAFz7Gl0clSBxjVO1vYkqmW7BGfqi8fS?=
 =?us-ascii?Q?JKAcCC5vOkcHDCXVUA1yIEsVj/MK8XVVm0894xEtRysUQPA9Dtn6ajBUnlTf?=
 =?us-ascii?Q?a5KcKDRCIZeIq/yArgSluwBky0rGILYdB/hVLDlmgR56LVcD/euPEz9KjoEu?=
 =?us-ascii?Q?20an9S1vRamU/RYBzsPDCHSJgoH+p3YP7HipHXe8mhKGwa0OrGO6yQLWpA0R?=
 =?us-ascii?Q?Qf5sjvgeaFoREIx8YzV1Fym5vhBWChutQbAKWrKgVXUB6it/1yT8Zq2HzgpZ?=
 =?us-ascii?Q?owySawtM4MipWTTDJvsUyua/S/6dHSGmf1613Fl5I7gA9GvqVkbiFq7k/WKP?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0928beb8-ac44-4db3-0b98-08dbc9a70cdd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:39:11.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UrskT8YLcEtpRVIrcd9Q0Lz/4Ft6Yp0n+Zu+zdrEFVudQb97FF3vaUaNLyRtnRP4prFPCdlHHZcgZjRHUtop4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7916
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds BASS unit tests for the Service Procedures Error
Handling suite.

---
 unit/test-bass.c | 430 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 428 insertions(+), 2 deletions(-)

diff --git a/unit/test-bass.c b/unit/test-bass.c
index 2ab61f760..ace47d9ed 100644
--- a/unit/test-bass.c
+++ b/unit/test-bass.c
@@ -190,6 +190,301 @@ struct ccc_state {
 	DISC_BCAST_AUDIO_SCAN_CP, \
 	BASS_READ_CHAR_DESC
 
+/* ATT: Write Request (0x12) len 4
+ *   Handle: 0x0004 Type: Client Characteristic Configuration (0x2902)
+ *     Data: 0100
+ *       Notification (0x01)
+ * ATT: Write Response (0x13) len 0
+ * ATT: Write Request (0x12) len 4
+ *   Handle: 0x0007 Type: Client Characteristic Configuration (0x2902)
+ *     Data: 0100
+ *       Notification (0x01)
+ * ATT: Write Response (0x13) len 0
+ */
+#define BASS_WRITE_CHAR_DESC \
+	IOV_DATA(0x12, 0x04, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x13), \
+	IOV_DATA(0x12, 0x07, 0x00, 0x01, 0x00), \
+	IOV_DATA(0x13)
+
+/* ATT: Read Request (0x0a) len 2
+ *   Handle: 0x0003 Type: Broadcast Receive State (0x2bc8)
+ * ATT: Read Response (0x0b) len 0
+ *   Handle: 0x0003 Broadcast Receive State (0x2bc8)
+ * ATT: Read Request (0x0a) len 2
+ *   Handle: 0x0006 Type: Broadcast Receive State (0x2bc8)
+ * ATT: Read Response (0x0b) len 0
+ *   Handle: 0x0006 Broadcast Receive State (0x2bc8)
+ */
+#define BASS_READ_BCAST_RECV_STATE_CHARS \
+	IOV_DATA(0x0a, 0x03, 0x00), \
+	IOV_DATA(0x0b), \
+	IOV_DATA(0x0a, 0x06, 0x00), \
+	IOV_DATA(0x0b)
+
+#define BASS_CP_WRITE_CMD(_op, _args...) \
+	IOV_DATA(0x52, 0x09, 0x00, _op, _args)
+
+#define BASS_CP_WRITE_REQ(_op, _args...) \
+	IOV_DATA(0x12, 0x09, 0x00, _op, _args)
+
+/* ATT: Write Command (0x52) len 19
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 0401693C4572685526613465597073275455
+ *       Opcode: Set Broadcast_Code
+ *       Source_ID: 1
+ *       Broadcast_Code: 0x55542773705965346126556872453c69
+ * ATT: Write Command (0x52) len 2
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 0501
+ *       Opcode: Remove Source
+ *       Source_ID: 1
+ */
+#define IGNORE_INVALID_SRC_ID \
+	EXCHANGE_MTU, \
+	BASS_FIND_BY_TYPE_VALUE, \
+	DISC_BASS_CHAR, \
+	BASS_FIND_INFO, \
+	BASS_WRITE_CHAR_DESC, \
+	BASS_READ_BCAST_RECV_STATE_CHARS, \
+	BASS_CP_WRITE_CMD(0x04, 0x01, 0x69, 0x3C, 0x45, 0x72, 0x68, \
+			0x55, 0x26, 0x61, 0x34, 0x65, 0x59, 0x70, \
+			0x73, 0x27, 0x54, 0x55), \
+	IOV_NULL, \
+	BASS_CP_WRITE_CMD(0x05, 0x01)
+
+/* ATT: Write Command (0x52) len 26
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 0200F2698BE807C0003412000610270200000000000000000000
+ *       Opcode: Add Source
+ *       Advertiser_Address_Type: Public Device or Public Identity Address
+ *       Advertiser_Address: c0:07:e8:8b:69:f2
+ *       Advertising_SID: 0x00
+ *       Broadcast_ID: 0x001234
+ *       PA_Sync: 0x06 (Reserved for Future Use)
+ *       PA_Interval: 0x2710
+ *       Num_Subgroups: 2
+ *         Subgroup #0:
+ *           BIS_Sync: 00000000000000000000000000000000
+ *           Metadata_Length: 0
+ *         Subgroup #1:
+ *           BIS_Sync: 00000000000000000000000000000000
+ *           Metadata_Length: 0
+ * ATT: Write Command (0x52) len 26
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 0205F2698BE807C0003412000210270200000000000000000000
+ *       Opcode: Add Source
+ *       Advertiser_Address_Type: 0x05 (Reserved for Future Use)
+ *       Advertiser_Address: c0:07:e8:8b:69:f2
+ *       Advertising_SID: 0x00
+ *       Broadcast_ID: 0x001234
+ *       PA_Sync: Synchronize to PA (PAST not available)
+ *       PA_Interval: 0x2710
+ *       Num_Subgroups: 2
+ *         Subgroup #0:
+ *           BIS_Sync: 00000000000000000000000000000000
+ *           Metadata_Length: 0
+ *         Subgroup #1:
+ *           BIS_Sync: 00000000000000000000000000000000
+ *           Metadata_Length: 0
+ * ATT: Write Command (0x52) len 26
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 0200F2698BE807C0003412000210270201000000000100000000
+ *       Opcode: Add Source
+ *       Advertiser_Address_Type: Public Device or Public Identity Address
+ *       Advertiser_Address: c0:07:e8:8b:69:f2
+ *       Advertising_SID: 0x00
+ *       Broadcast_ID: 0x001234
+ *       PA_Sync: Synchronize to PA (PAST not available)
+ *       PA_Interval: 0x2710
+ *       Num_Subgroups: 2
+ *         Subgroup #0:
+ *           BIS_Sync: 00000000000000000000000000000001
+ *           Metadata_Length: 0
+ *         Subgroup #1:
+ *           BIS_Sync: 00000000000000000000000000000001
+ *           Metadata_Length: 0
+ */
+#define ADD_SRC_INVALID_PARAMS \
+	EXCHANGE_MTU, \
+	BASS_FIND_BY_TYPE_VALUE, \
+	DISC_BASS_CHAR, \
+	BASS_FIND_INFO, \
+	BASS_WRITE_CHAR_DESC,\
+	BASS_READ_BCAST_RECV_STATE_CHARS, \
+	BASS_CP_WRITE_CMD(0x02, 0x00, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0, \
+			0x00, 0x34, 0x12, 0x00, 0x06, 0x10, 0x27, 0x02, \
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
+			0x00, 0x00), \
+	IOV_NULL, \
+	BASS_CP_WRITE_CMD(0x02, 0x05, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0, \
+			0x00, 0x34, 0x12, 0x00, 0x02, 0x10, 0x27, 0x02, \
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
+			0x00, 0x00), \
+	IOV_NULL, \
+	BASS_CP_WRITE_CMD(0x02, 0x05, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0, \
+			0x3F, 0x34, 0x12, 0x00, 0x02, 0x10, 0x27, 0x02, \
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
+			0x00, 0x00), \
+	IOV_NULL, \
+	BASS_CP_WRITE_CMD(0x02, 0x00, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0, \
+			0x00, 0x34, 0x12, 0x00, 0x02, 0x10, 0x27, 0x02, \
+			0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, \
+			0x00, 0x00)
+
+/* ATT: Write Request (0x12) len 3
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: FF
+ *       Opcode: 0xff (Reserved  For Future Use)
+ * ATT: Error Response (0x01) len 4
+ *   Write Request (0x12)
+ *   Handle: 0x0009
+ *   Error: Opcode Not Supported (0x80)
+ */
+#define OPCODE_NOT_SUPPORTED \
+	EXCHANGE_MTU, \
+	BASS_FIND_BY_TYPE_VALUE, \
+	DISC_BASS_CHAR, \
+	BASS_FIND_INFO, \
+	BASS_WRITE_CHAR_DESC,\
+	BASS_READ_BCAST_RECV_STATE_CHARS, \
+	BASS_CP_WRITE_REQ(0xFF), \
+	IOV_DATA(0x01, 0x12, 0x09, 0x00, 0x80)
+
+/* ATT: Write Request (0x12) len 5
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 006dfe
+ *       Opcode: Remote Scan Stopped
+ *       Extra Data: 0xfe6d
+ * ATT: Error Response (0x01) len 4
+ *   Write Request (0x12)
+ *   Handle: 0x0009
+ *   Error: Write Request Rejected (0xFC)
+ * ATT: Write Request (0x12) len 5
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 006dfe
+ *       Opcode: Remote Scan Started
+ *       Extra Data: 0xa2c2
+ * ATT: Error Response (0x01) len 4
+ *   Write Request (0x12)
+ *   Handle: 0x0009
+ *   Error: Write Request Rejected (0xFC)
+ * ATT: Write Request (0x12) len 25
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 0200F2698BE807C0003412000210270100000000000000
+ *       Opcode: Add Source
+ *       Advertiser_Address_Type: Public Device or Public Identity Address
+ *       Advertiser_Address: c0:07:e8:8b:69:f2
+ *       Advertising_SID: 0x00
+ *       Broadcast_ID: 0x001234
+ *       PA_Sync: Synchronize to PA (PAST not available)
+ *       PA_Interval: 0x2710
+ *       Num_Subgroups: 1
+ *         Subgroup #0:
+ *           BIS_Sync: 00000000000000000000000000000001
+ *           Metadata_Length: 0
+ *       Extra Data: 0x0000
+ * ATT: Error Response (0x01) len 4
+ *   Write Request (0x12)
+ *   Handle: 0x0009
+ *   Error: Write Request Rejected (0xFC)
+ * ATT: Write Request (0x12) len 13
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 03000210270100000000001500
+ *       Opcode: Modify Source
+ *       Source_ID: 0x00
+ *       PA_Sync: Synchronize to PA (PAST not available)
+ *       PA_Interval: 0x2710
+ *       Num_Subgroups: 1
+ *         Subgroup #0:
+ *           BIS_Sync: 00000000000000000000000000000001
+ *           Metadata_Length: 0
+ *       Extra Data: 0x0015
+ * ATT: Error Response (0x01) len 4
+ *   Write Request (0x12)
+ *   Handle: 0x0009
+ *   Error: Write Request Rejected (0xFC)
+ * ATT: Write Request (0x12) len 20
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 0400B803EAC6AFBB65A25A41F153056802010000
+ *       Opcode: Set Broadcast_Code
+ *       Source_ID: 0x00
+ *       Broadcast_Code: 0x0102680553f1415aa265bbafc6ea03b8
+ *       Extra Data: 0x0000
+ * ATT: Error Response (0x01) len 4
+ *   Write Request (0x12)
+ *   Handle: 0x0009
+ *   Error: Write Request Rejected (0xFC)
+ * ATT: Write Request (0x12) len 4
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 05008F13
+ *       Opcode: Remove Source
+ *       Source_ID: 0x00
+ *       Extra Data: 0x138f
+ * ATT: Error Response (0x01) len 4
+ *   Write Request (0x12)
+ *   Handle: 0x0009
+ *   Error: Write Request Rejected (0xFC)
+ */
+#define INVALID_LEN \
+	EXCHANGE_MTU, \
+	BASS_FIND_BY_TYPE_VALUE, \
+	DISC_BASS_CHAR, \
+	BASS_FIND_INFO, \
+	BASS_WRITE_CHAR_DESC,\
+	BASS_READ_BCAST_RECV_STATE_CHARS, \
+	BASS_CP_WRITE_REQ(0x00, 0x6D, 0xFE), \
+	IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFC), \
+	BASS_CP_WRITE_REQ(0x01, 0xC2, 0xA2), \
+	IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFC), \
+	BASS_CP_WRITE_REQ(0x02, 0x00, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0, \
+			0x00, 0x34, 0x12, 0x00, 0x02, 0x10, 0x27, 0x01, \
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00), \
+	IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFC), \
+	BASS_CP_WRITE_REQ(0x03, 0x00, 0x02, 0x10, 0x27, 0x01, 0x00, 0x00, \
+			0x00, 0x00, 0x00, 0x15, 0x00), \
+	IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFC), \
+	BASS_CP_WRITE_REQ(0x04, 0x00, 0xB8, 0x03, 0xEA, 0xC6, 0xAF, 0xBB, \
+			0x65, 0xA2, 0x5A, 0x41, 0xF1, 0x53, 0x05, 0x68, \
+			0x02, 0x01, 0x00, 0x00), \
+	IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFC), \
+	BASS_CP_WRITE_REQ(0x05, 0x00, 0x8F, 0x13), \
+	IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFC)
+
+/* ATT: Write Request (0x12) len 20
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 0400B803EAC6AFBB65A25A41F153056802010000
+ *       Opcode: Set Broadcast_Code
+ *       Source_ID: 0x05
+ *       Broadcast_Code: 0x0102680553f1415aa265bbafc6ea03b
+ * ATT: Error Response (0x01) len 4
+ *   Write Request (0x12)
+ *   Handle: 0x0009
+ *   Error: Invalid Source ID (0x81)
+ * ATT: Write Request (0x12) len 4
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 005
+ *       Opcode: Remove Source
+ *       Source_ID: 0x05
+ * ATT: Error Response (0x01) len 4
+ *   Write Request (0x12)
+ *   Handle: 0x0009
+ *   Error: Invalid Source ID (0x81)
+ */
+#define INVALID_SRC_ID \
+	EXCHANGE_MTU, \
+	BASS_FIND_BY_TYPE_VALUE, \
+	DISC_BASS_CHAR, \
+	BASS_FIND_INFO, \
+	BASS_WRITE_CHAR_DESC, \
+	BASS_READ_BCAST_RECV_STATE_CHARS, \
+	BASS_CP_WRITE_REQ(0x04, 0x05, 0xB8, 0x03, 0xEA, 0xC6, 0xAF, 0xBB, \
+			0x65, 0xA2, 0x5A, 0x41, 0xF1, 0x53, 0x05, 0x68, \
+			0x02, 0x01), \
+	IOV_DATA(0x01, 0x12, 0x09, 0x00, 0x81), \
+	BASS_CP_WRITE_REQ(0x05, 0x05), \
+	IOV_DATA(0x01, 0x12, 0x09, 0x00, 0x81)
+
 #define iov_data(args...) ((const struct iovec[]) { args })
 
 #define define_test(name, function, _cfg, args...)		\
@@ -287,6 +582,63 @@ done:
 	gatt_db_attribute_read_result(attrib, id, ecode, value, len);
 }
 
+static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
+				unsigned int id, uint16_t offset,
+				const uint8_t *value, size_t len,
+				uint8_t opcode, struct bt_att *att,
+				void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct ccc_state *ccc_state;
+	uint16_t val;
+	uint8_t ecode = 0;
+
+	if (!value || len > 2) {
+		ecode = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
+		goto done;
+	}
+
+	if (offset > 2) {
+		ecode = BT_ATT_ERROR_INVALID_OFFSET;
+		goto done;
+	}
+
+	if (len == 1)
+		val = *value;
+	else
+		val = get_le16(value);
+
+	ccc_state = get_ccc_state(data, gatt_db_attribute_get_handle(attrib));
+	if (!ccc_state)
+		return;
+
+	/* If value is identical, then just succeed */
+	if (val == ccc_state->value)
+		goto done;
+
+	ccc_state->value = val;
+
+done:
+	gatt_db_attribute_write_result(attrib, id, ecode);
+}
+
+static void gatt_notify_cb(struct gatt_db_attribute *attrib,
+				struct gatt_db_attribute *ccc,
+				const uint8_t *value, size_t len,
+				struct bt_att *att, void *user_data)
+{
+	struct test_data *data = user_data;
+	struct ccc_state *ccc_state;
+
+	ccc_state = find_ccc_state(data, gatt_db_attribute_get_handle(ccc));
+	if (!ccc_state || !(ccc_state->value & 0x0001))
+		return;
+
+	bt_gatt_server_send_notification(data->server,
+		gatt_db_attribute_get_handle(attrib),
+		value, len, false);
+}
+
 static void test_server(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
@@ -306,12 +658,17 @@ static void test_server(const void *user_data)
 	data->db = gatt_db_new();
 	g_assert(data->db);
 
-	gatt_db_ccc_register(data->db, gatt_ccc_read_cb, NULL,
-					NULL, data);
+	gatt_db_ccc_register(data->db, gatt_ccc_read_cb, gatt_ccc_write_cb,
+					gatt_notify_cb, data);
 
 	data->bass = bt_bass_new(data->db, NULL, BDADDR_ANY);
 	g_assert(data->bass);
 
+	bt_bass_set_att(data->bass, att);
+	bt_bass_attach(data->bass, NULL);
+
+	bt_bass_set_debug(data->bass, print_debug, "bt_bass:", NULL);
+
 	data->server = bt_gatt_server_new(data->db, att, 64, 0);
 	g_assert(data->server);
 
@@ -387,11 +744,80 @@ static void test_sggit(void)
 						DISC_BCAST_RECV_STATE);
 }
 
+static void test_spe(void)
+{
+	/* BASS/SR/SPE/BI-01-C [Ignore Invalid Source ID]
+	 *
+	 * Test Purpose:
+	 * Verify that the BASS Server IUT does not respond to a control point
+	 * procedure call that uses an invalid Source_ID parameter.
+	 *
+	 * Pass verdict:
+	 * The IUT does not send a notification of the Broadcast Receive State
+	 * characteristic.
+	 */
+	define_test("BASS/SR/SPE/BI-01-C", test_server, NULL,
+				IGNORE_INVALID_SRC_ID);
+
+	/* BASS/SR/SPE/BI-03-C [Add Source - Ignore Invalid Values]
+	 *
+	 * Test Purpose:
+	 * Verify that the BASS Server IUT ignores Add Source control point
+	 * procedure calls that include an RFU or Invalid parameter.
+	 *
+	 * Pass verdict:
+	 * The IUT does not send a notification of the Broadcast Receive State
+	 * characteristic.
+	 */
+	define_test("BASS/SR/SPE/BI-03-C", test_server, NULL,
+				ADD_SRC_INVALID_PARAMS);
+
+	/* BASS/SR/SPE/BI-04-C [Opcode Not Supported]
+	 *
+	 * Test Purpose:
+	 * Verify that the BASS Server IUT returns an Opcode Not Supported error
+	 * response when the opcode written is not supported by the IUT or is
+	 * within a range that is reserved for future use being written to the
+	 * Broadcast Audio Scan Control Point.
+	 *
+	 * Pass verdict:
+	 * The IUT sends an error response of OPCODE NOT SUPPORTED.
+	 */
+	define_test("BASS/SR/SPE/BI-04-C", test_server, NULL,
+				OPCODE_NOT_SUPPORTED);
+
+	/* BASS/SR/SPE/BI-06-C [Invalid Length]
+	 *
+	 * Test Purpose:
+	 * Verify that the BASS Server IUT rejects writing of an opcode with
+	 * an invalid length.
+	 *
+	 * Pass verdict:
+	 * The IUT rejects the opcode.
+	 */
+	define_test("BASS/SR/SPE/BI-06-C", test_server, NULL,
+				INVALID_LEN);
+
+	/* BASS/SR/SPE/BI-07-C [Invalid Source ID]
+	 *
+	 * Test Purpose:
+	 * Verify that the BASS Server IUT returns an error when a control
+	 * point procedure passing an invalid Source_ID parameter is called.
+	 *
+	 * Pass verdict:
+	 * The IUT sends an ATT Error Response with the Error Code set to
+	 * Invalid Source_ID.
+	 */
+	define_test("BASS/SR/SPE/BI-07-C", test_server, NULL,
+				INVALID_SRC_ID);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
 
 	test_sggit();
+	test_spe();
 
 	return tester_run();
 }
-- 
2.39.2

