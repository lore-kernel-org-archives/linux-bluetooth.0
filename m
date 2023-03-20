Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B309BC7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 14:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjCTOj2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjCTOjH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 10:39:07 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8464628EA2
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 07:38:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAJAZQzDLTHuicN5Vyfw/IJi7rT8+ObiUrtiPvS7ot/o8B1oDi8MhLhy4r4RbjfFjbgKXQVu+hd+FwHe/ZKU4Hgotn1PJ9QBJUNLwoh8KRt+BBiRHklSzuqwdcuSR9NoQvCNRtiu8RBrGpulkIIZ1MuEQ7gG/fcLd69zK5gwnKC2RWKr0BBXzLD0l2f0Ioqq0e5u1LbODwATXrWbhk3IYg39HWaYYFgUa25uLOuvFd/KqrXpHQ1hrvO00+1SBRKA8CbLnTH8y83kciyvUh3EWFuOujg7spCW0YZquUHrs/rdzhQK6UgSn/6/BR9pXSJH6YZmbKClkwYoJ2sneFi5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HOZ1OHjekS1voclBEWMErEta2MSQNgUHIT092IPU8s=;
 b=feRmW2xNW3eXdQ89ufFFIvws2CxuO0bS2ZjucUklOLY9FQM7vHgKx5F3I6r7uyJH7t4fW4ZXvVStCkY4AZ3uCFs9ndyYOg04kJJV6TZ95oky9Bg3GRa6Spr/xC8SsJATykVj/xT5U4IC40DA6RGEZaCcQdvRjag37pV4uVUKIZB9wI1MSP//9sWUouzg78DvRFDAgEn4pPECSIRKlEG3TqFz3cca/3Mc8myjMi2VaQLsKRSqvkNBlYC+e/A1oUztzps6bQXNHgYzcU2HV09BmBpussmfrQHVk5l8An55dg0/r5gouc0Yh8wmf6oQd2F2Nh/MWUe15+lAErmNVdg86Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HOZ1OHjekS1voclBEWMErEta2MSQNgUHIT092IPU8s=;
 b=l1/f9cGUe5ds6s76GvKDK630f2CDL1X4DuKokiHEObirUzmndXkAVf5PZP/tHo9erpHMOkBaGjSmWyeo761ZvNuwkZW+3z3N+C5zk9cfEp0GTK1HXS1Er856zf+y+kl2uQdwn2yc9S7a5jZhPqnmhtHb5pcXY1TT98KsPH20eHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7231.eurprd04.prod.outlook.com (2603:10a6:800:1a9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:37:40 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:37:40 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 6/8] tools/btiotest: Use unicast QoS structure for ISO io
Date:   Mon, 20 Mar 2023 16:37:11 +0200
Message-Id: <20230320143713.25449-7-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230320143713.25449-1-iulia.tanasescu@nxp.com>
References: <20230320143713.25449-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0147.eurprd07.prod.outlook.com
 (2603:10a6:207:8::33) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 5beb70bd-1f76-496a-73b2-08db2950a892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SV/zHb70AXvID5vUqdb9naAPIW1wO/coTRNcR/Tt9BnUml21xW8zHimDzA9ihg7b+FTeLYxfa5PSFBzHTaWSEuYB4g7SnkRJiPErJIA2lCCPxykb8YnaY7qa2A7mBJ5jJyKWsNdJVuzBBxw5vwHXG8ntP/QzawPbkXP+pX5kKm5b91EoeIkDTknXzqYajaDR+EXtoHwh2yyER+ewwWnKaj1FIqQuYHPaEiYjzteyzYMDu/O7018ahqSNZ3B3c8R/9+oQYULfReeZTeMAZWzzjl3SR0BARYwNIeFNkU21n+NJNTNqk6mumrdC47luY9JW1TF19GchSS4lmoEM8HTCVKUrSkOqB1BkqQe57vHJV0683ySsgtqSF+acAsBPHmtGtLEtk+4jRLfP7VgUxOnlAFv7nNc+qhroHlf85OBmD3Mm7u5USHI59BDG2Q2x/e3hnUKND4R5pBW9zpCHwQ+qM+k8+ZlpiE6G42CtK8vJQDkBNwag6oH7dNiWOEM9Tlf/ZGRunO0iwPpHPRhrgSBJEr/v0OSqO/Akoqiaega5Lz4qPn0R3jR72qAom2h1mpSRn/+Oi5VK6PkfL+TILXk5nWjt7QVRUhVzrDGmAPatUjdoYxfq0Zfkw08nnyslevhvzmEhluDryMs5RNvj/F7aZ60R9c1DcKaZ9w/D1At+/1NCioVbdZl7e5TCJ3b3DP7eLXSoZvGHJ29Qc+JEQID3Gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199018)(6506007)(2616005)(1076003)(55236004)(26005)(6512007)(6666004)(6486002)(8676002)(4326008)(83380400001)(52116002)(316002)(186003)(66476007)(478600001)(66946007)(6916009)(8936002)(5660300002)(4744005)(44832011)(2906002)(41300700001)(38100700002)(38350700002)(86362001)(66556008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/MpxblsNlsQjeCvnfJcD+7ijpvxciOKKWldSZ4KfNJ1k7VOQqae0J/03VvJR?=
 =?us-ascii?Q?WuupT4RM9+Jt2EE2EnluyVLdhnduncmI8M5XqI+DD+U6ySUxcTw6URGe5XhT?=
 =?us-ascii?Q?xswHUSdZfQbsRK9uECv1UsOJRLJo/6qzj1N6nbBP2Kkh8yCcC8eGP0Ebxf/J?=
 =?us-ascii?Q?rEtTCXT4tgitH+swyqLa9lGpTHaGMk2L9jPW+gKmwdKZFtrEONkGwDw4qNMD?=
 =?us-ascii?Q?BlwpzV2ZMqVKbykYsF1yK0PkS5t0oKdN1jYzYPS/52wkkcdw8TJln2/l3qef?=
 =?us-ascii?Q?8WwTm8pe+/AsdAKRFTG9FTU/Kf3ULbjKMox1g9PvvhAHvT1jOfznhNuzoKej?=
 =?us-ascii?Q?jb1Mo/LJuuzkwj9+anRVVuckngQQ2isO0K8LjSDd4Xma2jl7zpxgqEOJZbey?=
 =?us-ascii?Q?oyVilEiDvLhOTBXpZSJgXkmrhnvuEgKiKp8EMuQ5ZA4MEqZqe7Bl8Ulc0zdG?=
 =?us-ascii?Q?YMKp6ulekqA5eLKuceUcL1B5XDHvOFdLtnqz4jAa74qqln/b3SIemdcBnLay?=
 =?us-ascii?Q?N1fEpJg3snh0bD6STIWlK+VElsCnCnONNz7t5G1HV4kedeMvYVQezJ0F6xwt?=
 =?us-ascii?Q?mwB/BEipfefGKs6W5DK4KavN0hBTfmXQ7C01D35Vefy0JmDXDm7SwpzWgJ4V?=
 =?us-ascii?Q?+C0v0NVKlJvyVTO+l1A9vVkFSjnycsS5XznPdwqP44Qr6cKRHdu/mVn6vIra?=
 =?us-ascii?Q?TuAS6s/5m6uVDmfcJMDK7DacCdDrO5LdnJqtvrUYaIKIiSHunpXCTjUahsZ/?=
 =?us-ascii?Q?prNlDVcVU9DemI0XTqycaYzFSkgAUjYtn7wHIBQ0VoeOTL+ypvzdTcwPIx9Q?=
 =?us-ascii?Q?v8dt8H2UQigVsNliGiBLj/v0vDQiJhE2sCGYPmLcuira/11EcxWheCBAQXcB?=
 =?us-ascii?Q?kJLSbVYIYHdgV2At3T3PCeycgoEr4ehbbH9BQxOOvgpyoPEJWayAbaEzKZUH?=
 =?us-ascii?Q?pwfeHOQ1x096w9JYFH038VG9SF8p8/g+SEDWwKWQ+WiyrwJbCFdhyBE+bMBU?=
 =?us-ascii?Q?UUThLr6AWUZ8yqzxtMNDac8vvStiExBjUeD+vuRYbpEUlv86k/LCET7iaPsf?=
 =?us-ascii?Q?3YCcfckUF61JHh7KhyP37k7l98wZeuazjjlBOb29/JvItbKvIXSyOsQAFotb?=
 =?us-ascii?Q?8Z/aYg42+o3oq5bqNSzydzPG6F5/VgzBkK4YDW4ALmhpLIP9fS99mpCVej5V?=
 =?us-ascii?Q?CEmDJ1SWk2ndMJZMnE4Y1Uo0GPpj6D4zkA4rnEotHKQC/3YIU/7pTrIgLESG?=
 =?us-ascii?Q?ycjV/eKbUVDOilgd0WxNlEc1f7Ez0L/DnOnpBrEu8V2qq8SyRRiGTUCtjJg4?=
 =?us-ascii?Q?fKW0NlihfuR7SWJaOvrh4VaJcV8tDGauksdMHN3pcUFmKt/04M4ezFwjkwhY?=
 =?us-ascii?Q?9Qu9LspG4RQWKl8ZzSeWluAV3RBVfG1b1AybJDV5q3RiNE+kWJZb5o2VI2Iy?=
 =?us-ascii?Q?zitLl5ekSzVl4C+MG96BBBYh7zMp0cCsyJ9UlLmaQGVU6icfd0H865rtKImU?=
 =?us-ascii?Q?168zpQZTLPGGUbeXx5DXa1dFacfbsJHH/g3FpBBWvmljxURjdrLDORctZvsR?=
 =?us-ascii?Q?Yin5cmtc+LIDrg9wPNNYczOvmRzE0WcA113oJ5Ve2l/3Y88jQU+DPEsjJ/qK?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5beb70bd-1f76-496a-73b2-08db2950a892
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:37:40.6287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: boiWqH/Sf5mib5K3m/sr6tSKS3s4KmubGnySCtDrbcEjbDFW6guVVo0m/6Q/J0wADOT69MxTwsOkytQtKTwtBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7231
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Convert the generic bt_iso_qos structure into the dedicated unicast
structure for ISO QoS options.

---
 tools/btiotest.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/btiotest.c b/tools/btiotest.c
index 193e1395b..dd2c132ca 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2009-2010  Nokia Corporation
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -38,7 +39,7 @@ static int opt_update_sec = 0;
 	.rtn = 2, \
 }
 
-struct bt_iso_qos qos = {
+struct bt_iso_unicast_qos qos = {
 	.cig = BT_ISO_QOS_CIG_UNSET,
 	.cis = BT_ISO_QOS_CIG_UNSET,
 	.sca = 0x07,
@@ -55,7 +56,7 @@ struct io_data {
 	int disconn;
 	int accept;
 	int voice;
-	struct bt_iso_qos *qos;
+	struct bt_iso_unicast_qos *qos;
 };
 
 static void io_data_unref(struct io_data *data)
-- 
2.34.1

