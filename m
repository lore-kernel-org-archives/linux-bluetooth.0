Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30127E7C4D4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Oct 2023 15:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjJDPc0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Oct 2023 11:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjJDPcZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Oct 2023 11:32:25 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E1ABD
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Oct 2023 08:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBrEU3Y2E86JkXiLy6cY5B+p6DzzqEjgoEo68UdQQDgOxv+m+88lfCw1NExllsuhn+6blxyYJFjk+TQZVYWNNfzmRSTCFSHCGPjMMRF6IC00kNQ4LaAe3LGI0uC7suBbWbfy4EHuFLk0uHayO/lSQS6km/J1YzBqDpdGL19ueyPzzXhD/BwwuRewGgCt5Fa9fJJDIN+bR9ZzkHJwzyY2eCX1uFYD2cAWL6wsgNISvg08DAqMHs1GCm1ZJks6glpP5g+ZowHSc230CTh3sSlxXgtaS3/RwTFI5hO2bJyZufDnlh8uSx8CGnqN+zhMOMIz+uzYxHpmGrs5QKZH6ktikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEPpdqhuq9g/mY5mmM01Vp3t/co5CyYSqwh/DYBBQ4k=;
 b=mbTzXjVnaH6FHJR9CRCahxNxAyo2DS+lIdZTvTney7KysMHaU+mtZg5YLRVo+4cFmqNJbRASx9fHL0MOZ1sDSCNUrKBuxOoINDmed886kRaAEZv158WjoRJvwpwCtCV/xUjiimyCSl6UcgngYF+6hQIy2iZkC4npk6NkQqk9aDkjmc1iz/IDC2PXXKNi/cQtX8vohImFqC4VVWzjuk2ESdbTbbFZgQERex8p8Mrd5dxaSXzut1FSKmVPVi7UCH1K5GJnEoKV6di8ldarqZU2XiViAvNd6Qw/NMxqh5a0TbDyB21R1GL3mIomImNBk9Gobp5zhnpb9K8vnYOSRAq8kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEPpdqhuq9g/mY5mmM01Vp3t/co5CyYSqwh/DYBBQ4k=;
 b=rUASf2e0LaAlNub2M387D28NZMHBZEILB6rK0AaYQptKhw3q6OVz3icOIeac2JRaStuWttL8Hi+q0V8GEOi8xRh0RppMcrZYbsTpFYjfOuAwQF+WOd3zWkStGgoZO+CPG/aTPdMKKv3bhBKqOKDnQzTGd/eUficlVBxZVtmdQVE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 15:32:17 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 15:32:17 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/4] test-bass: Add unit tests for the SPE suite
Date:   Wed,  4 Oct 2023 18:31:50 +0300
Message-Id: <20231004153150.3051-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231004153150.3051-1-iulia.tanasescu@nxp.com>
References: <20231004153150.3051-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0283.eurprd07.prod.outlook.com
 (2603:10a6:800:130::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 02e93b51-8d14-4a20-8f03-08dbc4ef172f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUeGoD9o20TMyjzFp+a2qYuIceQeOFTJefukbaHnIoqVbDbTaCI5s9G4N5XvorkfCha5ZJYi7b6zXVCyRlGu7tJ/4ZpWLkmVv0fLsMbcuBnvAlFNOmhfUXQzU2LUwk1cYhgvaDWBKA+daK1B9OlygT2DGn1HkpgFWZyNDHP9NijbER33zopmyBdvLoyjfx++rL1ePgVtjc/+b5GKzetxtyFxX8NiMxcry14P42o4cUvqo49PCRjQce4dxVmyUIumJmaVqvj5sfnDT00Sr++Rq8yFHJ0Mo5RUBBB7ZRYoM6nRkC2UwZRCCK1TT299zIfzUhSAyZP8LxQZPv/ZePzFdrm3b7yc8/A7PuuDfX6fn1Eb+1xe2Xpm4Sz54C/KTvsBBvWji+DJ+Ilthu+Bv5H2VNf58fauwhgVPRwQnHW5dJocMleJZKB+LpvbQuCGmWKtx3YedKQixcYIUeLTuJjD65WBOl68QwoWXjBAtjfJH6jFqdwN/+bNGBtXIDPyMTcd8b3J/UDioYPuiIuZG8B8/Ab0fgU1LblqeFc1c9G52BRYob7AHizdpoMLbG+3MMpb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(6486002)(6512007)(6506007)(478600001)(6666004)(38100700002)(86362001)(30864003)(66476007)(2906002)(6916009)(4326008)(83380400001)(2616005)(26005)(1076003)(41300700001)(36756003)(66556008)(66946007)(8936002)(44832011)(5660300002)(316002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9HLlVwhPpgwiGP0aNAfLvTWLVORIxSU+BUiEzokh5Up6AUcMYQg6mz4ujlM2?=
 =?us-ascii?Q?D6sSIFh37+SIg75twfvIMnyf2vOALX4ShNI1Ptfbz0ZGFwObZSvvogmHqwiV?=
 =?us-ascii?Q?QShB11v4T/Ou6b4M8ltz3F/6+FTayvic7nu9hB0BjBnqBdwiUO3YIa8vX6R0?=
 =?us-ascii?Q?fwirZ2/KkAIR3S6+AgZOCRRHY4BV2ODrBlDjGudSJeOx5WWhGBh2pBkFZQOw?=
 =?us-ascii?Q?azydrcdyNwo6EM1ZfBF3U/spPCynCzCQ8RcnDLfukKrgHUVupGDPF1VYdv4F?=
 =?us-ascii?Q?R6pd+iEhqbZohDGxnIpb2mxu2kwMJa6CYQz+ROTno8xumJX/cYzv53fGZqoB?=
 =?us-ascii?Q?+5N/L9SvN44BK7s86FtJ8tE775jivzH0PnGMPxqxQEna3tWA1aRMs6hLrvkY?=
 =?us-ascii?Q?fYp/Z2BkKdHZNCeC5YDjqG08UF5hmyOmj9vNbYGmanfifihdvUSdaMWnltDI?=
 =?us-ascii?Q?HC3yTirkPa7wmah0rUyJVMBOKSuF/RdKmznQDkfVLyWzgbShP6+73P0SjVEv?=
 =?us-ascii?Q?2bAclSREKe8xsmc2KmvjXjSfKxKUlGPb8D01Z1dG5/q+Zgvrf9VaQRVqQTYR?=
 =?us-ascii?Q?N878ZfhlxSFDQINzs1UGIKWExJW8myTsCpIzIUrEqC1N4QGbGlwFHqOFleWH?=
 =?us-ascii?Q?O2Zp5qoZKoPNPQFij5CsAIePasOjxU3MK8CDK2f7chycuAtwQp+Cd60BL75k?=
 =?us-ascii?Q?PIw4C/JYhoLkpjBcAOVoTeD6d+0H9tD9K1d4KrKAYJ3L1Qihf2IPvzqhsLid?=
 =?us-ascii?Q?xz4NA23zfngtvzkv6piriDb7q+Vy9uXeryNYAT4azR1xdvC+8gAl0Leoa+NZ?=
 =?us-ascii?Q?2iwd9vNI3iXzC4lubNOYFF3QsOVlxW6FPlFm4gqrsBNm7OnvXpZRVu5j2YCB?=
 =?us-ascii?Q?NZaXhldldRhGtVh5CPXkY6VhWoH9LAUIcPxYupuSsligbE27xAsx5r6Vlpdk?=
 =?us-ascii?Q?nJf3+9xQg4eR0CDrN5BYGjWlXDBcDe6BltD/c9+KfYxx5cIY5fpNvSNJlk/L?=
 =?us-ascii?Q?nC4nUFtIwk6IZF3krcIaIh6tHuk6mfgprQND0d3fa56zGpLDbVeLNaqdqd3D?=
 =?us-ascii?Q?Fn7q3aCiBSEnCX0e4aOhSDwqGRN29AoLUT87oTxiBOsBDE1gOPn11up0Q3Fx?=
 =?us-ascii?Q?cplTijVJPpQjhGbey4BodbrHOk2oTtrOyv0OpcFHDABCGWszRR0cejMpkTnv?=
 =?us-ascii?Q?Z+0DF1ZIIH0njPup1JDwKg51fz+0/Xhp/opiX9aeNla/TAX8whUF84khR7Sf?=
 =?us-ascii?Q?9us6ruNbQNlEkPRFNOvzUEnLQrH5lXPECZkt2Ql8z0w8ldBEZiqTWMDpL52J?=
 =?us-ascii?Q?BOa+a6X6dHN/mE2mxZ6ZUxgFJz3ygRCvPB8kRnHPz6G45M1nO+6TAEA9Yh47?=
 =?us-ascii?Q?lVNo0QnJXPxUMh7RZsPpI/5Y2HEtK0Of3ALj0oIfPdnZ0ojE90PXDPNpp9f7?=
 =?us-ascii?Q?9Cvx8g0U3Q223IM7XiNkzmxFhcXGfmtPdB3Vfx3Tjvn5nptdASJciqwFqFiq?=
 =?us-ascii?Q?3IlJrtmUjsZFIBdJfW5+fswaUbOAbWbS6OFwOOr/k01yG3prTvs3y0JIk11B?=
 =?us-ascii?Q?ls3fv9GBUaauw/NXEPlDWXrvrcI/ACv5JvKTLFUZ7s9xEwdXygxSyCsBND9Y?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e93b51-8d14-4a20-8f03-08dbc4ef172f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 15:32:17.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmAQPxujFdUuENDGrBPw2vY/3IMzUMjIu0pppMSaJ5o1PwhQ9d1a6ZD4dEVFa0Ck+zqethaSXUUlRMRHA0A0Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7790
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds BASS unit tests for the Service Procedures Error Handling
suite.

Some unit tests require the BASS Server to synchronize to a broadcast
source, as instructed by a BASS Client. For this, a testing framework
was added similar to the one used by iso-tester, to emulate hardware.

---
 Makefile.am      |   7 +-
 unit/test-bass.c | 781 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 775 insertions(+), 13 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 30db74a0c..088f5aaef 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -581,7 +581,12 @@ unit_test_bap_LDADD = src/libshared-glib.la \
 
 unit_tests += unit/test-bass
 
-unit_test_bass_SOURCES = unit/test-bass.c $(btio_sources)
+unit_test_bass_SOURCES = unit/test-bass.c $(btio_sources) monitor/bt.h \
+				emulator/hciemu.h emulator/hciemu.c \
+				emulator/vhci.h emulator/vhci.c \
+				emulator/btdev.h emulator/btdev.c \
+				emulator/bthost.h emulator/bthost.c \
+				emulator/smp.c
 unit_test_bass_LDADD = src/libshared-glib.la \
 				lib/libbluetooth-internal.la $(GLIB_LIBS)
 
diff --git a/unit/test-bass.c b/unit/test-bass.c
index 2ab61f760..4407bb4d3 100644
--- a/unit/test-bass.c
+++ b/unit/test-bass.c
@@ -18,13 +18,22 @@
 #include <sys/socket.h>
 #include <fcntl.h>
 
+#include <stdbool.h>
+
 #include <glib.h>
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
+#include "lib/mgmt.h"
+
+#include "monitor/bt.h"
+#include "emulator/bthost.h"
+#include "emulator/hciemu.h"
+
 #include "src/shared/util.h"
 #include "src/shared/io.h"
 #include "src/shared/tester.h"
+#include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
 #include "src/shared/gatt-db.h"
@@ -39,6 +48,9 @@ struct test_data {
 	struct queue *ccc_states;
 	size_t iovcnt;
 	struct iovec *iov;
+	struct mgmt *mgmt;
+	uint16_t mgmt_index;
+	struct hciemu *hciemu;
 };
 
 struct ccc_state {
@@ -190,16 +202,397 @@ struct ccc_state {
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
+/* ATT: Write Command (0x52) len 26
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 0200F2698BE807C000F5D983021027010000000000
+ *       Opcode: Add Source
+ *       Advertiser_Address_Type: Public Device or Public Identity Address
+ *       Advertiser_Address: c0:07:e8:8b:69:f2
+ *       Advertising_SID: 0x00
+ *       Broadcast_ID: 0x83d9f5
+ *       PA_Sync: Synchronize to PA (PAST not available)
+ *       PA_Interval: 0x2710
+ *       Num_Subgroups: 1
+ *         Subgroup #0:
+ *           BIS_Sync: 00000000000000000000000000000000
+ *           Metadata_Length: 0
+ * ATT: Handle Value Notification (0x1b) len 22
+ *   Handle: 0x0003 Type: Broadcast Receive State (0x2bc8)
+ *     Data: 0100F2698BE807C000F5D9830200010000000000
+ *       Source_ID: 0x01
+ *       Source_Address_Type: Public Device or Public Identity Address
+ *       Source_Address: c0:07:e8:8b:69:f2
+ *       Source_Adv_SID: 0x00
+ *       Broadcast_ID: 0x83d9f5
+ *       PA_Sync_State: Synchronized to PA
+ *       BIG_Encryption: Not encrypted
+ *       Num_Subgroups: 1
+ *       Subgroup #0:
+ *         BIS_Sync State: 00000000000000000000000000000000
+ *         Metadata_Length: 0
+ * ATT: Read Request (0x0a) len 2
+ *   Handle: 0x0003 Type: Broadcast Receive State (0x2bc8)
+ * ATT: Read Response (0x0b) len 20
+ *   Handle: 0x0003 Broadcast Receive State (0x2bc8)
+ *     Source_ID: 0x01
+ *     Source_Address_Type: Public Device or Public Identity Address
+ *     Source_Address: c0:07:e8:8b:69:f2
+ *     Source_Adv_SID: 0x00
+ *     Broadcast_ID: 0x83d9f5
+ *     PA_Sync_State: Synchronized to PA
+ *     BIG_Encryption: Not encrypted
+ *     Num_Subgroups: 1
+ *     Subgroup #0:
+ *       BIS_Sync State: 00000000000000000000000000000000
+ *       Metadata_Length: 0
+ * ATT: Write Request (0x12) len 2
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ *     Data: 0501
+ *       Opcode: Remove Source
+ *       Source_ID: 1
+ * ATT: Write Response (0x13) len 0
+ *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
+ */
+#define RM_SRC_WHILE_SYNC \
+	EXCHANGE_MTU, \
+	BASS_FIND_BY_TYPE_VALUE, \
+	DISC_BASS_CHAR, \
+	BASS_FIND_INFO, \
+	BASS_WRITE_CHAR_DESC, \
+	BASS_READ_BCAST_RECV_STATE_CHARS, \
+	BASS_CP_WRITE_CMD(0x02, 0x00, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0, \
+			0x00, 0xF5, 0xD9, 0x83, 0x02, 0x10, 0x27, 0x01, \
+			0x00, 0x00, 0x00, 0x00, 0x00), \
+	IOV_DATA(0x1b, 0x03, 0x00, 0x01, 0x00, 0xF2, 0x69, 0x8B, 0xE8, \
+		0x07, 0xC0, 0x00, 0xF5, 0xD9, 0x83, 0x02, 0x00, 0x01, \
+		0x00, 0x00, 0x00, 0x00, 0x00), \
+	IOV_DATA(0x0a, 0x03, 0x00), \
+	IOV_DATA(0x0b, 0x01, 0x00, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0, 0x00, \
+		0xF5, 0xD9, 0x83, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, \
+		0x00), \
+	BASS_CP_WRITE_REQ(0x05, 0x01), \
+	IOV_DATA(0x13)
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
+static const uint8_t client_bdaddr[] = {0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0};
+
+static const uint8_t set_iso_socket_param[] = {
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6, 0x85, 0x98, /* UUID - ISO Socket */
+	0x6a, 0x49, 0xe0, 0x05, 0x88, 0xf1, 0xba, 0x6f,
+	0x01,						/* Action - enable */
+};
+
+static const uint8_t reset_iso_socket_param[] = {
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6, 0x85, 0x98, /* UUID - ISO Socket */
+	0x6a, 0x49, 0xe0, 0x05, 0x88, 0xf1, 0xba, 0x6f,
+	0x00,						/* Action - disable */
+};
+
 #define iov_data(args...) ((const struct iovec[]) { args })
 
-#define define_test(name, function, _cfg, args...)		\
+#define define_test(name, pre_setup, setup, function, teardown,	\
+					post_teardown, args...)	\
 	do {							\
 		const struct iovec iov[] = { args };		\
 		static struct test_data data;			\
 		data.iovcnt = ARRAY_SIZE(iov_data(args));	\
 		data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
-		tester_add(name, &data, NULL, function,	\
-				test_teardown);			\
+		tester_add_full(name, &data, pre_setup, setup, function, \
+				teardown, post_teardown, 0, NULL, NULL); \
 	} while (0)
 
 static void test_complete_cb(const void *user_data)
@@ -287,11 +680,282 @@ done:
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
+static void set_iso_socket_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_print("ISO socket feature could not be enabled");
+		return;
+	}
+
+	tester_print("ISO socket feature is enabled");
+}
+
+static void read_info_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	const struct mgmt_rp_read_info *rp = param;
+	char addr[18];
+	uint16_t manufacturer;
+	uint32_t supported_settings, current_settings;
+
+	tester_print("Read Info callback");
+	tester_print("  Status: 0x%02x", status);
+
+	if (status || !param) {
+		tester_pre_setup_failed();
+		return;
+	}
+
+	ba2str(&rp->bdaddr, addr);
+	manufacturer = btohs(rp->manufacturer);
+	supported_settings = btohl(rp->supported_settings);
+	current_settings = btohl(rp->current_settings);
+
+	tester_print("  Address: %s", addr);
+	tester_print("  Version: 0x%02x", rp->version);
+	tester_print("  Manufacturer: 0x%04x", manufacturer);
+	tester_print("  Supported settings: 0x%08x", supported_settings);
+	tester_print("  Current settings: 0x%08x", current_settings);
+	tester_print("  Class: 0x%02x%02x%02x",
+			rp->dev_class[2], rp->dev_class[1], rp->dev_class[0]);
+	tester_print("  Name: %s", rp->name);
+	tester_print("  Short name: %s", rp->short_name);
+
+	if (strcmp(hciemu_get_address(data->hciemu), addr)) {
+		tester_pre_setup_failed();
+		return;
+	}
+
+	tester_pre_setup_complete();
+}
+
+static void index_added_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+
+	tester_print("Index Added callback");
+	tester_print("  Index: 0x%04x", index);
+
+	data->mgmt_index = index;
+
+	mgmt_send(data->mgmt, MGMT_OP_READ_INFO, data->mgmt_index, 0, NULL,
+					read_info_callback, data, NULL);
+}
+
+static void index_removed_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+
+	tester_print("Index Removed callback");
+	tester_print("  Index: 0x%04x", index);
+
+	if (index != data->mgmt_index)
+		return;
+
+	mgmt_unregister_index(data->mgmt, data->mgmt_index);
+
+	mgmt_unref(data->mgmt);
+	data->mgmt = NULL;
+
+	tester_post_teardown_complete();
+}
+
+static void read_index_list_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct hciemu_client *client;
+
+	tester_print("Read Index List callback");
+	tester_print("  Status: 0x%02x", status);
+
+	if (status || !param) {
+		tester_pre_setup_failed();
+		return;
+	}
+
+	mgmt_register(data->mgmt, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
+					index_added_callback, data, NULL);
+
+	mgmt_register(data->mgmt, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
+					index_removed_callback, data, NULL);
+
+	data->hciemu = hciemu_new(HCIEMU_TYPE_BREDRLE52);
+	if (!data->hciemu) {
+		tester_warn("Failed to setup HCI emulation");
+		tester_pre_setup_failed();
+		return;
+	}
+
+	client = hciemu_get_client(data->hciemu, 0);
+
+	if (!hciemu_set_client_bdaddr(client, client_bdaddr)) {
+		tester_warn("Failed to setup HCI emulation");
+		tester_pre_setup_failed();
+		return;
+	}
+
+	tester_print("New hciemu instance created");
+}
+
+static void test_pre_setup(const void *test_data)
+{
+	struct test_data *data = (void *)test_data;
+
+	data->mgmt = mgmt_new_default();
+	if (!data->mgmt) {
+		tester_warn("Failed to setup management interface");
+		tester_pre_setup_failed();
+		return;
+	}
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
+		  sizeof(set_iso_socket_param), set_iso_socket_param,
+		  set_iso_socket_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0, NULL,
+					read_index_list_callback, data, NULL);
+}
+
+static void test_post_teardown(const void *test_data)
+{
+	struct test_data *data = (void *)test_data;
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
+		  sizeof(reset_iso_socket_param), reset_iso_socket_param,
+		  NULL, NULL, NULL);
+
+	hciemu_unref(data->hciemu);
+	data->hciemu = NULL;
+}
+
+static void client_connectable_complete(uint16_t opcode, uint8_t status,
+					const void *param, uint8_t len,
+					void *user_data)
+{
+	if (opcode != BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE)
+		return;
+
+	tester_print("Client set connectable status 0x%02x", status);
+
+	if (status)
+		tester_setup_failed();
+	else
+		tester_setup_complete();
+}
+
+static void setup_powered_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = (void *)user_data;
+	struct hciemu_client *client;
+	struct bthost *host;
+	uint8_t bcode[16] = {0x00};
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("Controller powered on");
+
+	client = hciemu_get_client(data->hciemu, 0);
+	host = hciemu_client_host(client);
+	bthost_set_cmd_complete_cb(host, client_connectable_complete,
+								data);
+	bthost_set_ext_adv_params(host);
+	bthost_set_ext_adv_enable(host, 0x01);
+
+	bthost_set_pa_params(host);
+	bthost_set_pa_enable(host, 0x01);
+	bthost_create_big(host, 1, 0x00, bcode);
+}
+
+static void setup_powered(const void *test_data)
+{
+	struct test_data *data = (void *)test_data;
+	unsigned char param[] = { 0x01 };
+
+	tester_print("Powering on controller");
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
+				sizeof(param), param, NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, data, NULL);
+}
+
 static void test_server(const void *user_data)
 {
 	struct test_data *data = (void *)user_data;
 	struct bt_att *att;
 	struct io *io;
+	bdaddr_t adapter_bdaddr = {{0, 0, 0, 0, 0, 0}};
 
 	io = tester_setup_io(data->iov, data->iovcnt);
 	g_assert(io);
@@ -306,12 +970,22 @@ static void test_server(const void *user_data)
 	data->db = gatt_db_new();
 	g_assert(data->db);
 
-	gatt_db_ccc_register(data->db, gatt_ccc_read_cb, NULL,
-					NULL, data);
+	gatt_db_ccc_register(data->db, gatt_ccc_read_cb, gatt_ccc_write_cb,
+					gatt_notify_cb, data);
 
-	data->bass = bt_bass_new(data->db, NULL, BDADDR_ANY);
+	if (data->hciemu)
+		memcpy(&adapter_bdaddr,
+		      hciemu_get_central_bdaddr(data->hciemu),
+		      sizeof(adapter_bdaddr));
+
+	data->bass = bt_bass_new(data->db, NULL, &adapter_bdaddr);
 	g_assert(data->bass);
 
+	bt_bass_set_att(data->bass, att);
+	bt_bass_attach(data->bass, NULL);
+
+	bt_bass_set_debug(data->bass, print_debug, "bt_bass:", NULL);
+
 	data->server = bt_gatt_server_new(data->db, att, 64, 0);
 	g_assert(data->server);
 
@@ -346,8 +1020,8 @@ static void test_sggit(void)
 	 * handle range of the request. The IUT reports all BASS
 	 * characteristics.
 	 */
-	define_test("BASS/SR/SGGIT/SER/BV-01-C", test_server, NULL,
-							DISC_BASS_SER);
+	define_test("BASS/SR/SGGIT/SER/BV-01-C", NULL, NULL, test_server,
+					test_teardown, NULL, DISC_BASS_SER);
 
 	/* BASS/SR/SGGIT/CHA/BV-01-C [Service GGIT -
 	 * Broadcast Audio Scan Control Point]
@@ -359,8 +1033,8 @@ static void test_sggit(void)
 	 * handle range of the request. The IUT reports one instance of the
 	 * Broadcast Audio Scan Control Point characteristic.
 	 */
-	define_test("BASS/SR/SGGIT/CHA/BV-01-C", test_server, NULL,
-						DISC_BCAST_AUDIO_SCAN_CP);
+	define_test("BASS/SR/SGGIT/CHA/BV-01-C", NULL, NULL, test_server,
+				test_teardown, NULL, DISC_BCAST_AUDIO_SCAN_CP);
 
 	/* BASS/SR/SGGIT/CHA/BV-02-C [Service GGIT -
 	 * Broadcast Receive State]
@@ -383,8 +1057,90 @@ static void test_sggit(void)
 	 * The IUT sends an ATT_Read_Response to the Lower Tester for each
 	 * ATT_Read_Request.
 	 */
-	define_test("BASS/SR/SGGIT/CHA/BV-02-C", test_server, NULL,
-						DISC_BCAST_RECV_STATE);
+	define_test("BASS/SR/SGGIT/CHA/BV-02-C", NULL, NULL, test_server,
+				test_teardown, NULL, DISC_BCAST_RECV_STATE);
+}
+
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
+	define_test("BASS/SR/SPE/BI-01-C", NULL, NULL, test_server,
+				test_teardown, NULL, IGNORE_INVALID_SRC_ID);
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
+	define_test("BASS/SR/SPE/BI-03-C", NULL, NULL, test_server,
+				test_teardown, NULL, ADD_SRC_INVALID_PARAMS);
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
+	define_test("BASS/SR/SPE/BI-04-C", NULL, NULL, test_server,
+				test_teardown, NULL, OPCODE_NOT_SUPPORTED);
+
+	/* BASS/SR/SPE/BI-05-C [Remove Source While Synchronized to a Source]
+	 *
+	 * Test Purpose:
+	 * Verify that the BASS Server IUT, if synchronized to PA and/or BIS,
+	 * does not accept the Remove Source operation request.
+	 *
+	 * Pass verdict:
+	 * The IUT does not send a notification to the Lower Tester for the
+	 * Broadcast Receive State characteristic.
+	 */
+	define_test("BASS/SR/SPE/BI-05-C", test_pre_setup, setup_powered,
+				test_server, test_teardown, test_post_teardown,
+				RM_SRC_WHILE_SYNC);
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
+	define_test("BASS/SR/SPE/BI-06-C", NULL, NULL, test_server,
+					test_teardown, NULL, INVALID_LEN);
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
+	define_test("BASS/SR/SPE/BI-07-C", NULL, NULL, test_server,
+					test_teardown, NULL, INVALID_SRC_ID);
 }
 
 int main(int argc, char *argv[])
@@ -392,6 +1148,7 @@ int main(int argc, char *argv[])
 	tester_init(&argc, &argv);
 
 	test_sggit();
+	test_spe();
 
 	return tester_run();
 }
-- 
2.39.2

