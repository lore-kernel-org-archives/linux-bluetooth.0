Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA3AE7AD58
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 14:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbjJCOiz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 10:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240044AbjJCOiy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 10:38:54 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2047.outbound.protection.outlook.com [40.107.247.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70ABAF
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 07:38:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVzCuYhWl054yvFfndf6EXu7sx+W7tsBL3DNrkPOWQYqOzhXVXDtCQMEpPAUXENx1ir8JkOtm6nxloqCkj5dTJNdk7Qwm2EHJX9TBpWsksUyaNDo6BMbcL/YrvqSJQTtr73LcekjNnNOKBh/uz2V+Y7UJCeL+FAOVuVR+TMHNiEuNXcpp4htdmOou/0YtxDpnXsKOkuJPtEfMiAdxSExeMXhsNcQzO82mKV8h0bLF3kaFg4yfWB9nNct6SOeVP8gRlc7foWjNF+bCAxqQOtZYwcUk77Mos7PUetJ+tKoqTpRDTmHMzpRIQpmewUJIcqi9TRGNvN6iWpxQfdyq4ew2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=op0FYvyLP263u5DCW2Rc8A1bAQeOeZq1BEMHFA6VztU=;
 b=S0QMCbgj54CAiRWacMxLdpzX1XV4uCKlcto59aYLN/228qrc0SpnLtOJPFpfNoKQnWxpcZQ3m4xM+cyKqdg/oOIZmN9PaeTp1Ck8L+9xbXU1Cm28KzSuMNnhKz1bYb8KPe/AIOAl6im08z8dG142VjVDdm9Tv52hD0x7hiFxjQW1LY6Iz7xb9wc7Gz/dZDW2zkVNw7Fnoyp4nR5Po7RkItcXxpdIaoCMykDZbaQyZRZ3WFolnmKtIYcmS/8tQwti5UngupP/KUZccvg6bogw8oZmZCGPh9R+ojLu3Kfkga+gpoB/1ePOR1e4Iwj5KYSaRl20ziuYGwGN9s7JrlUU5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=op0FYvyLP263u5DCW2Rc8A1bAQeOeZq1BEMHFA6VztU=;
 b=Q1Y9Hw3pfzmTfDY2W87UMyOhPoEgcnHKNf5Vir49HEQg77lLtaxSvp8YDsrCTf+/L2Kni7cwV59JBuVIAlZNBhpVvPG5RZ5tAP3p3tTAIfKqDfURJRyealp5NqsKIagKAllTNhK1UivZ9j58FA2swK98vBzuWDoJBkdZdnCuxwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7882.eurprd04.prod.outlook.com (2603:10a6:10:1e7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 3 Oct
 2023 14:38:49 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Tue, 3 Oct 2023
 14:38:49 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] iso-tester: Add test for bcast AC 13 BIS unset
Date:   Tue,  3 Oct 2023 17:38:40 +0300
Message-Id: <20231003143840.3009-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231003143840.3009-1-iulia.tanasescu@nxp.com>
References: <20231003143840.3009-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR04CA0084.eurprd04.prod.outlook.com
 (2603:10a6:803:64::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7882:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3c3550-2daa-4583-0232-08dbc41e750d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3lgb6lwfCKao+yCAnOdhxGlY1XMTF57EWHowjpevpUBhUkcxXeY7hjvTuAfWNnJR73CKTIo5TMZs4IOlSe89QlRA04FoBqV7DbBOQ+7dsYAyRtdhKLlep47fzZwejgbb5nJoCR0X2UquYorCqNJEuID0DYy85LKyd/uSBTq9f0542qFwNoszaerQ1OHLoJFpdLDg9ioVHxSOs2cXCjFXFOKLzl41qjI478s0XjVk5OdQmjE2oRfCMl9r7tIUhwvo1+9fEYkJ3HUDAvgqXf6HrGC93FsmITDM3o+t2qzo1V46TFhCLszfvqbjl0orlu9sDm920YNAVln1s8w/S6HW6aQm/RLCemv1SvgZeg0Z1O4aMB+Xfywtj3fT7Ekh1M/1hg8qcBBQ3sclv9ZQu8dJ0m/m9pyhmcASOOAnGrG/wtB37hPeBKxTD5r8Einn59j0RjTkkjSYyT8GGkrtj279hQdxEENjpzXoZg0pmWPbRKar4KmtTHJSx6WFDqnAR/ET4iJveRrCW9y70fssvaTDteEAo3998iBN/WRzIx45Ebk9E1RGF/K/zxOeWsVA3MfO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(478600001)(6486002)(6666004)(86362001)(38100700002)(2906002)(6512007)(26005)(1076003)(2616005)(83380400001)(36756003)(5660300002)(66946007)(41300700001)(6916009)(316002)(4326008)(44832011)(8676002)(66556008)(8936002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?olhcvu832OQOjsndAq7Kx8nPpeDXhTZP5zClJ8NSKLvojEUhdqMGvWGMn8fz?=
 =?us-ascii?Q?OYmVBLiA7D72ruy7Wu/XPuwHUqW4KZtuIAc8HWea/DnqCJDrD2ASy5KxUeDE?=
 =?us-ascii?Q?dnumEpQf0oZPg/DPIZQbXAYwnD97K5Wu7OekdeMt1aYbELXkCnmiVP78vWm9?=
 =?us-ascii?Q?yqQqxq7u5Y65FE1KOzBHKDwSXzLvTfraIc0qqM1woK5U17pcrlIekNVcccL/?=
 =?us-ascii?Q?R2dhpXCKQRP6iNY3Emtd0/liNo5LrcTk6VwmSe8ehCSJ1QMjR3LBJZpKMNr9?=
 =?us-ascii?Q?GPamGNoc/H9Q8N7BXTokf2IAHzkMpm09+8YjF/H23qW0Ge38q574Qu5X7jeq?=
 =?us-ascii?Q?ZC34yiO692Tx80StvASt2GmGYJAvBP/7rOzsPW48OPoglOUpu0Waa0l/3waX?=
 =?us-ascii?Q?3D5w3MQmuBnIYZXq4Z+TlaQGyrBmopbWjdTDDLgSW1DF1n7qst4W9VBPsdnG?=
 =?us-ascii?Q?x8CdBga0ATSvvEPtLB8MFw+4/qQt0oE3k0n3Qqau3yPU4cqMIcC5zZiFNbdC?=
 =?us-ascii?Q?sHYHAsNdpBOcWQQTo8PokBMCD1xJiaHJZ+oe1rLHKm4mvJSDaKJ3mFlLgxhT?=
 =?us-ascii?Q?jGBKSdDLp0fCIn0LudeQzO0psu0faSY2ng9P+Y9pwPW6CjE1Pg15IGTKK9R3?=
 =?us-ascii?Q?lLYRO5UZgrf0wbXGr0F9XpmwaSZWaGPCRkzf5lrG8ylT3JFY9fDu5ahdJwBP?=
 =?us-ascii?Q?pV1/9HiOLyfRfnmcbm7+F4qwyfqo+EnM8WwF7lO/RTL9eXuE0Z1yXAxRAD2G?=
 =?us-ascii?Q?/rudPatDXX/j4xzGpivdDbDDZx8LIZGPfX1CX+wDvFrOwDhJp7o62ZK5r1DZ?=
 =?us-ascii?Q?E9TGVS3YdRTqBlYCXs6/SfNFhacdT5bEIYuyJ8g1b07j8UD+fiRflmWJJTxW?=
 =?us-ascii?Q?D5CSyoO6Et4R8kJ7nWhDDDa/Q/t83abykxWBMKxJdLTSHbMcHaQ9OQv8SORw?=
 =?us-ascii?Q?noZwVVhIMtlO+SoGzcJ+3L6FG3zqqVvil+2O7rRv4nhypV00KnxIzZdUOP3f?=
 =?us-ascii?Q?ZC4mnegU5a/Pqm9oYQrt3Nuzhmbzqkigo4F6gIKr+GQibJo3DE2vO/qY7czL?=
 =?us-ascii?Q?KWn+iuGlLZHSwy2yTO8E99IEcWTDsHMMIf5AIx1LSVIJvp8+gUvOuNAS5ZzN?=
 =?us-ascii?Q?8C4yxFD0NzWKG4mGGRfCXKsMo3p+tU1PLZ2VKVWc88YgOD3H+MlhDjr53Cf/?=
 =?us-ascii?Q?KdMGwSQg1At63ZePFri3l+2/z161/sUHgrpaSHzUwBN2KVPBLU4YFDDzUeT9?=
 =?us-ascii?Q?OI2YD1uEFjHFnAfEPx8tkhMx39f2t7bGOjD/x2XwbwfbZVzck1Mkqq+WBFes?=
 =?us-ascii?Q?IVFkDNCgcEtsRqcH0EzhnebQGU9PqGkifL4Gb23RTR+s1ZJRtmwC0C1fla7S?=
 =?us-ascii?Q?6YUZLXZxN2GwqRIIoFKPwQmEuSlNH6LWsbgyypk7PDzaaYLm9eSbyKY3IAGH?=
 =?us-ascii?Q?BU5n9wB+TkSWVVY5WvfMXUevtCyj0kKhty2p0cOosI50frf49YsPJzttMB+D?=
 =?us-ascii?Q?qk4UcNWFXJp8aggsRF0DX+my3sTt220AByJ18a7HmcnY+eY9tRQ8CaD2bMsT?=
 =?us-ascii?Q?c9kC9s3qcymktxIertIV3pmkPJCPTC08kQDgqaSRuSWGoKDawMLfQ7fUBTP6?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3c3550-2daa-4583-0232-08dbc41e750d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 14:38:49.5833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5echVfIeKYD3ExhdiRX+hcqS/ROB/KRFWAGbzpNysKCehk9q4lFbzf6sATcBaJ0XXouqakNa64pjhjOCuv7WRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7882
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds a new test for the ISO Broadcast AC 13, when the BIG handle
is set but the advertising handle is unset:

ISO Broadcaster AC 13 BIG 0x01 - Success

---
 tools/iso-tester.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 410da2c93..10b42dec2 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -330,7 +330,8 @@ static const uint8_t base_lc3_ac_12[] = {
 };
 
 /* Multiple Audio Channels. Two BISes. */
-#define BCAST_AC_13 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
+#define BCAST_AC_13_1_1 BCAST_QOS_OUT_1_1(10000, 10, 40, 0x02, 2)
+#define BCAST_AC_13_1 BCAST_QOS_OUT_1(10000, 10, 40, 0x02, 2)
 
 static const uint8_t base_lc3_ac_13[] = {
 	0x28, 0x00, 0x00, /* Presentation Delay */
@@ -1151,8 +1152,17 @@ static const struct iso_client_data bcast_ac_12 = {
 	.base_len = sizeof(base_lc3_ac_12),
 };
 
-static const struct iso_client_data bcast_ac_13 = {
-	.qos = BCAST_AC_13,
+static const struct iso_client_data bcast_ac_13_1_1 = {
+	.qos = BCAST_AC_13_1_1,
+	.expect_err = 0,
+	.bcast = true,
+	.mconn = true,
+	.base = base_lc3_ac_13,
+	.base_len = sizeof(base_lc3_ac_13),
+};
+
+static const struct iso_client_data bcast_ac_13_1 = {
+	.qos = BCAST_AC_13_1,
 	.expect_err = 0,
 	.bcast = true,
 	.mconn = true,
@@ -3035,8 +3045,13 @@ int main(int argc, char *argv[])
 	test_iso("ISO Broadcaster AC 12 - Success", &bcast_ac_12, setup_powered,
 							test_bcast);
 
-	test_iso("ISO Broadcaster AC 13 - Success", &bcast_ac_13, setup_powered,
-							test_bcast2);
+	test_iso("ISO Broadcaster AC 13 BIG 0x01 BIS 0x01 - Success",
+						&bcast_ac_13_1_1,
+						setup_powered,
+						test_bcast2);
+
+	test_iso("ISO Broadcaster AC 13 BIG 0x01 - Success", &bcast_ac_13_1,
+						setup_powered, test_bcast2);
 
 	test_iso("ISO Broadcaster AC 14 - Success", &bcast_ac_14, setup_powered,
 							test_bcast);
-- 
2.39.2

