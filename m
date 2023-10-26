Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D65C25B6E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Oct 2023 14:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345328AbjJZOvM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Oct 2023 10:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345305AbjJZOvK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Oct 2023 10:51:10 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2734B9
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 07:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+HKWJ9cEcHAo72CGEv9+HjetwUd8qXmkfeLATTPx61pKIuPNyylIOQxHxOWal9mlE8C7mSwfn9oTAgPjSlw9LpFaylo73r1KSv5lwZ6Cn+Q69thZyQmDf5f9GnWvd29Qd2ej/t71iP5A3L9kIeTuAYCzC69ogX9gmmbSTZXHJcoYUlqiSgfHsU1hU37h8x6ARznIwDqK8F7gbcsWAC3sMlYSLUiqXhgRjdyPImblBHbt7UZEv+qBm38ItEljbu9WtNnLacfNjHWWQB/+/1HfNsDygDC0hWw1WcIOxkscQSD31zm2RX362Wlmi0ZpiJz6HXHADOqQgMI4hjpbFbhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QezM3gJIZfcElwYAqnIRxFG0PSytrfSC+ovU3cpPRgQ=;
 b=fHLZ3iLfVjWdkzOch8zjp5k1tjS2u32aElFHpxYTPDDj2LeaxAdv9GxTTGvSDzK3VmJWAeHia5YOo+n36QXxwmZFdypUYRiL7dvjezdeer8b1E5X6vRWuTA18K4C3/WsGxBukCFmySxciI2hR6W2k/vJp5qDWq8fQDbLq049/p5My1IsCYGYGcIDBu7YbkGRNgjBqRFdP873OZ2eMvB7HLhNbEVKQs9YW8qy50W2YaGMMFhlf4asnCpRqZPtAkB9wE70gq/ONYv+GFukWsnk4p6szxd0V/+W7TGTJblITiS+hTAv3ShVx4XjGNGptbNUAUJ5K1W7MX8faz7NySd4uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QezM3gJIZfcElwYAqnIRxFG0PSytrfSC+ovU3cpPRgQ=;
 b=kFJrJwgx/QQHN7K94z8irIe78vvzM7bMSbPfjOBavVl5/DRRTIFMY5DGFx2dD+hXcKkzEAAo5ITm2YcoI5kPhmxMXBYz07bL/rJ8KWAc3ak+ZCXqVJintR1UV3RoKQ6QhB7T8G2gp5z46TEXgj9r4P8Y1d8q75ecHnpXt6QpUfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 26 Oct
 2023 14:51:07 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Thu, 26 Oct 2023
 14:51:07 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH 3/6] src: Add support for the number of BISes in the main.conf
Date:   Thu, 26 Oct 2023 17:50:44 +0300
Message-Id: <20231026145047.4637-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
References: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR03CA0063.eurprd03.prod.outlook.com
 (2603:10a6:803:50::34) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: f20c6aaa-765a-4bed-b92a-08dbd632fc54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L6q3biRFuBWwRaTVtbgH9Cj2zLyCQ9hMzx3UXM8f9XbDlwys+0YdTUiHAwCQofCKY2Kmz9orSgNv7/4pslwtS7FOik1+slE8B60OOqn9s5x4V7mW5fWz5tNRfPI9XNehjkthfP/DKinzbfqt2HRhmtWZGZn/L5MGqgcKJkunLmlqb953mUs7/hyqP82muKdcOMHylNkoleIh7v8FWUkyPBv6rybvBlHIxKHDMYdkE8Lt7D0IOeSy9s6XIc7yerhCenzP2cTQQW0xEoPTzinmDuTceoLYcc+JaEz1BrRrjDAIEdGe9BFHUysfCweXOS99XGdDHKaeko5wXOq29rGkrb3MvK+thb2ZgU53C4+FYI7TTvDbH2Fxqs8PfdbR/4SqJw2o51bMC0VltVoEuMgYEycZRHO0kPx6VIthReJcIHysI7YmiXjvKYquMi54uG5OxPRF7CMHwGolk9Bi9vGBCvg6c3wm9GGUV061jte0m7VIqD87UfvG9tzGF6cuc8RqgzN8zfCKIDP3rcT0B8FvxNm+Tyzz2EZ/B9IhAaNdo7ZVth6CHYfEqgFZc71hwe1f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(66556008)(66946007)(316002)(41300700001)(66476007)(478600001)(6916009)(4326008)(6506007)(6512007)(6666004)(8676002)(8936002)(6486002)(1076003)(26005)(19627235002)(5660300002)(2616005)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GfFQWvEzrSYOWZyQ5TEJp7OSlTFLAwALTGaIcbGjTD6LeIPoMJVNxk732lV0?=
 =?us-ascii?Q?JKQS+8iTD6RgyUxvnRODMbF1K90m/0TQ4sO+aToivB8j84bDts4avQnia+Da?=
 =?us-ascii?Q?KXmt4n6P+4HjS5nZsf/6b9Dmzd6A4GIMr+IDBehgrnTxF4BLOcotUoH1R7wv?=
 =?us-ascii?Q?Llu7xNzmNXADtOFEgCe9123VRM2UaSHEeYp/yIseYEPtIuiB7OI5vX+6sEAw?=
 =?us-ascii?Q?lfiTgCaOcAm9yeRJBV/a22xVqBRd/EAooHpr4FlW6kAYdu1ty6KIl5lcmxir?=
 =?us-ascii?Q?eRrooesY1KoRAZ55PQ6RbL731MbP3FUV45mZdGWScUcK3QX0h6+Y8lucOsJU?=
 =?us-ascii?Q?Vzo3b0DGdHb762NlMDvbzN5PkZHtCdCTbpLhC9diTH6cQ+TC95uG//mQ4ic9?=
 =?us-ascii?Q?bHlaIxbGIKNen7J71heIRp5HR2KvBNWPi9IMJlks06Jai8MFtppO2/0CLv8d?=
 =?us-ascii?Q?VmNzoQG8V0IV855Aice4ZIvbbXwQd4xABhjqg5+MVwGFo8ftPOZ2UU8cc5xq?=
 =?us-ascii?Q?mjf7jB6Ef7am11r0Bs24vrxrxB3Mz3PrimQ3nlzzW/hnt8rd0PhmgMHH6ROS?=
 =?us-ascii?Q?fcKj8dUIdEIcIzN+2qtK9MyILgUHFGPQwuYIGwA47OI/g9j7TIWWEwakI7m2?=
 =?us-ascii?Q?ccbd6V2RQNJx0VQ00vYL5IR6IFudtwW2n9UANNQWvsAgy4j0kmodlaiN9L8b?=
 =?us-ascii?Q?0rye4k37QSXfxssudxLpnUYOL3bSUZ4c0TurVOBYhzadzuTRJ+ncccUfCCTn?=
 =?us-ascii?Q?sbA07PAIlvvRv3gcYMfUc8mgCAwvDBO/T6k272P5t0lFNrWYvZ4dA1Y0vS10?=
 =?us-ascii?Q?xex1q9gbQt4sQQQ1kZUuJdE5DC8OWAHUAR2IbM6Q2bO75M9clU4yn4nCcABe?=
 =?us-ascii?Q?Ie4gqD0EjubM7I2lYj9C0gcc2WtVX2JaXfsbeoZ62M72oZQTTbw6bxyVLctd?=
 =?us-ascii?Q?/bq0FbVKkpXuMpnf/zF0lHfv17hhrF4IYAISY0mOaHb8RSVkxhlB1XG3RUzx?=
 =?us-ascii?Q?7shyNebvfxxKil65HJtNz/UJpSAoGfMi25/XQo0f154thoFSZ6QfbeDNsova?=
 =?us-ascii?Q?TPPC/SUmXkkJE0bOe09gDghZT3IVTEiYcKpmw9SHJXzCgpmaq7NxZXtI8JpT?=
 =?us-ascii?Q?+3EEsGpJtT7IwL+OL3dc08AKpnApe0PSYu4aQzm9BZqyMdbX3LXfPq4fDxiR?=
 =?us-ascii?Q?TuNF89LjjoeCp/ot6dsWet+GY0+jaTYS82yEO5oJNeJ+f4/FC4hDjOaEMvV+?=
 =?us-ascii?Q?Rzpn9M/Ex9QeSDPRtQrDSJYPhR1W1r6JvK73CwOos41HUUACkhu5ioSgOJiD?=
 =?us-ascii?Q?IhrDdxk+crhs6ipNvlHtSQMUn8Yd2ha3P3ko+0cZzFOgcxB7oOgE9W7MPibV?=
 =?us-ascii?Q?M3qLvvm+dQkqyDcIvuzDzcQOHNw81qApnapZvBtOPH2QJqXwPqPfhL7SN4ij?=
 =?us-ascii?Q?zDvmu/IW2JmodRHqEnSRwxHUKq0fNKmsnAmyut+6TcsvwyUwos8aFBTia/OK?=
 =?us-ascii?Q?sLyz0EjH3ZE48MbFZDZts1sFhbiozuIqgpUzX9teh8cjGAuYF4NIO/k+AdXy?=
 =?us-ascii?Q?AlxZ0kvlRgJjDZyLtYnGxlVNZtsA/3TPxnaDHuATeensVLarqhwQjQgSMjcV?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20c6aaa-765a-4bed-b92a-08dbd632fc54
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:51:07.4692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0w+326K/ZuncVwOWzg1d2/SRn1NbPOkIgi0zsUQO1qdokU/sTO5NLBJp+tDtV9MwDiC8BZYXKzu7vKLY8A9vFLwoSkZyr1zfprbM/LqQ+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for the number of BISes in the main.conf

---
 src/btd.h     |  6 ++++++
 src/main.c    | 10 ++++++++++
 src/main.conf |  8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/src/btd.h b/src/btd.h
index b7e7ebd61..2ad494008 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -108,6 +108,10 @@ struct btd_advmon_opts {
 	uint8_t		rssi_sampling_period;
 };
 
+struct btd_bcast_opts {
+	uint8_t		nb_bises;
+};
+
 struct btd_opts {
 	char		*name;
 	uint32_t	class;
@@ -151,6 +155,8 @@ struct btd_opts {
 	struct btd_advmon_opts	advmon;
 
 	struct btd_csis csis;
+
+	struct btd_bcast_opts bcast;
 };
 
 extern struct btd_opts btd_opts;
diff --git a/src/main.c b/src/main.c
index b1339c230..364f899c8 100644
--- a/src/main.c
+++ b/src/main.c
@@ -1137,6 +1137,13 @@ static void parse_advmon(GKeyFile *config)
 				0, UINT8_MAX);
 }
 
+static void parse_bcast(GKeyFile *config)
+{
+	parse_config_u8(config, "Bcast", "NumberOfBISes",
+				&btd_opts.bcast.nb_bises,
+				0, UINT8_MAX);
+}
+
 static void parse_config(GKeyFile *config)
 {
 	if (!config)
@@ -1154,6 +1161,7 @@ static void parse_config(GKeyFile *config)
 	parse_csis(config);
 	parse_avdtp(config);
 	parse_advmon(config);
+	parse_bcast(config);
 }
 
 static void init_defaults(void)
@@ -1195,6 +1203,8 @@ static void init_defaults(void)
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
 
 	btd_opts.advmon.rssi_sampling_period = 0xFF;
+
+	btd_opts.bcast.nb_bises = 0x01;
 	btd_opts.csis.encrypt = true;
 }
 
diff --git a/src/main.conf b/src/main.conf
index 085c81a46..119d27a7b 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -337,3 +337,11 @@
 # 0xFF       Report only one advertisement per device during monitoring period
 # Default: 0xFF
 #RSSISamplingPeriod=0xFF
+
+[Bcast]
+# The number of BISes. This is used, when an application registers a
+# broadcast source endpoint, as the number of BISes in a BIG.
+# Possible values:
+# N = 0xXX   Number of BISes (range: 0x01 to nb of maximum Controller supported BISes)
+# Default: 0x01
+#NumberOfBISes=0x01
-- 
2.39.2

