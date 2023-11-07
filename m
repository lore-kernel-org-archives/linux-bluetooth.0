Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0203828E33
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 10:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="EkIq3v5M"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2065.outbound.protection.outlook.com [40.107.6.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522F5B0
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Nov 2023 02:35:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJpuXed0jzT4ENIqH1iO24EbJkF1jnqYwz/idfSfR5p/zvNIW7W485+MPMr6XxQl20XbpVHD6Ig5Way7o2KiE9mNxCRY+0C2O/dbFCPnoA+wgY/M9js5ffOIr4aFBpKiV5uRha2PANWzFInPA+f87NMIk5QHL3C5NtzZVU2kIwVYDDkt3geXh3tw7mqWyly6YBkrFyRzEQGDodc3dARzSM2b8xci3AHKDryJvxjgPy+aFaDfdVQSlMBgPLYjmcxb95uWnvFbhHiugfhxClRFmyLXsAinkkXKcvQl31CDOnILHsAiqLXjpyfbr4923fS/zrhsGzDyEHzcwMsg4wIT6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpzFSPsa96Yi8oSaoMGYcAkUZl3lEwL4ZRsquhqYAyI=;
 b=koFW+CFLKHd8qThqxA/te7YcDY1QSUFCEp5nxcz7ASe4Hnyo2J65+RGfOkzjVmcZ3BMwNYeiocGXmMwERmla2A6aIdEi1crdvnOhoveIciLqmtntT5dR2B51jx1gcULx7frNRuQ6M3w2nqkx/7RGZ/nBoZveSrrruBPWO6H0mng1eP684DT9fJhjPCUQf4aahvXolMouXZe/O3G4I3uG/qj6j+L0uPw2kKdBK8XpSsDtOL4LQnWBCqgwiNUPqcBAjJ3vzoXzoLeq3K5QBvzqo3TtwlSLYJJUW6852kXHSMYra+GKWllf4RHHnEmEIwhGhrV8a3KGJTHMRl3XQs7pjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpzFSPsa96Yi8oSaoMGYcAkUZl3lEwL4ZRsquhqYAyI=;
 b=EkIq3v5MwlARlOykHOP+dZpRC0LgWNDfLhfMGo7SDN87d1MbObIDoXNWiLAhlp6mX3KB7jouos0aDRwDymEjNWJDhWRSF9YikqA/0lI69x00h0bO2RV39rtC0/Xu0W63tTcWNuF63r4GlZqxeUR4OzxdIuNtgP3Lg7gnoFBbxzY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AM9PR08MB6033.eurprd08.prod.outlook.com (2603:10a6:20b:286::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 10:35:14 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::b914:d9b5:6462:13b6%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 10:35:14 +0000
From: lukas.funke-oss@weidmueller.com
To: linux-bluetooth@vger.kernel.org
Cc: Lukas Funke <Lukas.Funke@weidmueller.com>,
	Philipp Meyer <Philipp.Meyer@weidmueller.com>
Subject: [PATCH BlueZ] adapter: fix heap corruption during discovery filter parsing
Date: Tue,  7 Nov 2023 11:35:07 +0100
Message-Id: <20231107103507.505581-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::16) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AM9PR08MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c840e1-a1e7-493a-0076-08dbdf7d3a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1pN62UT2u1nxqeiEMMkqbxJ/ahHft9zIc9nDMq7CiSxzpK6oD+CRB7t6yowCXY3YNm4xFtz11uJ6judynKs/LSShu+qHL1zV4qh3Nz1AFqYJH/BnUCB8CJrNOri+H1gQ8Mj7wlY5c8K2R/BOcE339Pn2D6c+qnC6V54UaOnFAZfZOraaP7BrUdBxt9tSXkIUnqdMKeJB305L1xIP0vrOmRAjtbTycs7YjDC2BMsWHrjSyANumWmMXWxczX57ggTKUdNtCeGBTCInok6VTfwI65ok6l3DHzOtRshHFKAy3HHhO1ByzPcB8IXFak9Om55x7Mnyhb2+3F4bfRbyHZwK7uEK1+kfSvs0uRgnSbM26MfFoJ761O2ouBSvd1U6GpUZFDSwzFgKvFEwp4EAGWbBE+paAJ3dr7dlX6G0WjmGfIRKb9fmFaaY2ADcnmhicJvsQZJZMKcdw1KNZWFVFK8tFl17t4VTsA7ysYiTZwmclGEljf+jVg27Mie3mG5eCZDJ8cKox+qv3SryFtr0N1OeZJMBsZAFmorNOFMInPilz+yjNDblIEDk7ddwWsXYuJcT33UrKMIgi+KD0+exGZuXE6xOAM3GG4A1d3KpSyG7QUCvVqvwLjgq7kqcgSfBqysN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR08MB8431.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(396003)(39860400002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38350700005)(36756003)(8936002)(83380400001)(316002)(4326008)(8676002)(26005)(66476007)(1076003)(54906003)(66946007)(6916009)(66556008)(5660300002)(478600001)(41300700001)(9686003)(107886003)(6512007)(6486002)(6666004)(6506007)(52116002)(2616005)(2906002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?39Z8jHNG1PbIZZbs8JLtWnTGcTzwQW4M56P3hOjpeo9To7ebnk0mW2EgAeLR?=
 =?us-ascii?Q?hxy1EvpiHW9I0qkUFz6mtGzEWMc+hctsDcyFTXST5MruLMKV0BtgghM7K9Fl?=
 =?us-ascii?Q?43mlINN+kcllK9yJqOX2SVb58pA89ImV54zj6R5cIPWDZWrivpdGJa7iTVz/?=
 =?us-ascii?Q?jSPa3vfKpug/1XaYL57MQ8eGg+ntBK/C1pgdmGOJqlD6H5nqvtYJDJuGHY4n?=
 =?us-ascii?Q?C8c0yykaNeRKXp2AkWzymu6weesPmpcZlU77XDvE1eNLRx7hN4Qh488WOfr2?=
 =?us-ascii?Q?e9XHTIUlAfXL47HJzNXfL2N/kTjLEVR9OMeM2ft+AY6ke+7O9yugMsv9Eo7k?=
 =?us-ascii?Q?SKhgdogMA8IJ9WRj/YqWHWQPD6JPFakwKBDf9PkC0t5an/csbT/9LuDP1sb0?=
 =?us-ascii?Q?jDgMs2E03qB14PZnOaQnork3WqotUZrv5XHhxQRzdBV4wIo42TyL5xUOKzFE?=
 =?us-ascii?Q?U+7lxGwZH8NEBsyUUZ7NljJge9tUN3LrGVF5PP3GdJo0kdTb2jinQo0jnSUm?=
 =?us-ascii?Q?0On4asGrr9N3Q+slYOdhwO7Qs8/BuHR7t7t61n3xHVudYpTdhx/RyYUs2F/c?=
 =?us-ascii?Q?CcKXSkP7Ix9VIVCLjMnDf0eYWFFkShE6eaO5Z+YWvCZ4IbC+ux3I5+ZD6qvv?=
 =?us-ascii?Q?xutfL6gvxZd3xWOgmOpkEUBPJ2vJ4N3Sxv179i78ddmEh8zD26TiB4ANMb/N?=
 =?us-ascii?Q?38HKSeiKPrxjEBwDbelXZmo2eDjYCQ0wxJvA5M8FH7XlXowiM9V6TLxTxDE6?=
 =?us-ascii?Q?3BGs/1acHwWiYyuvyvf7SSDfi/CGgeOR59wpmmhU8qg4GRLaqF9Iy8ZKKNyY?=
 =?us-ascii?Q?GAhrTNm9j6j8T5gUb/NXzILdOU89MaCLTlezfEYM7Y0G21zrIult6+prmnQm?=
 =?us-ascii?Q?2KvkNbUu4/4NO8shAbY4eQFji+2yy3N2mSfJCbQ4TDDbd45cOQvDwHSjajQL?=
 =?us-ascii?Q?BGXyf4lJdVwa/RpaHKHaJdDbkknKRCLRGMA+MKTlVtqlvotQ/52malqw/ZF/?=
 =?us-ascii?Q?2l5SJ0/58bs7d4v38yQT0m1wcUHZ1gZ18n5hn0QdAlVuRDRnEtK3QsEvgv+d?=
 =?us-ascii?Q?a9FhrZOMhqE44yqD0URnG1oMeXqjHMeJo8+ojn0ncvDXOJC54YJPAzlYizs7?=
 =?us-ascii?Q?htZXYWaCEbP3ZA+srNMcgQQB0nKd90bvWHkRSk9rldWLTjB628ciM9fHlz1b?=
 =?us-ascii?Q?e0P3siWL/qxR42ryiJOSdCpH3Yxcg3jxPTUc6Gt1f+oltWzjBtFLqVPahuq1?=
 =?us-ascii?Q?ip1qMjMmT9lxKco1rmuZl2voPAvLAEzVlcc3ncjeFdYo/iaXYu3I7Ks6+ykt?=
 =?us-ascii?Q?RrCNhAOUcyZNiGcb0mXKQ/xEADPCLr5rNdsYprgCNazZxpPy2xybMqBvC5M/?=
 =?us-ascii?Q?/qm4OhAvRCPKTkTPy0CUUkrVE4pe6kGJK0AdSEJjryAX8tHJozoYUAoszZXo?=
 =?us-ascii?Q?79VulZGtoRFIVS2NDo13B1R7c3hTSaWU8mXfCX6Ttmh7eevgvLdmkdEYghsV?=
 =?us-ascii?Q?KOrhLnhe6TEuQfx7pUr50aWG9CTGttk2JvAUtzCQedL1WvHV3DXa9MSgbWmx?=
 =?us-ascii?Q?8oM3x5BSeOx4uHxL/1fKNTWJDxPwxNZ0ajFK1rOeTgYH+UHkf/k5aPavv456?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c840e1-a1e7-493a-0076-08dbdf7d3a49
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 10:35:14.5849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgzq/ZajLpHE3O/jL3xIOQd2wddYZPRYjTwCSZNzx2lK4SIu23T0eYpUmKlY/ImQzbfaHifj6dYM4c+phl+EVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6033

From: Philipp Meyer <Philipp.Meyer@weidmueller.com>

Must parse as dbus_bool_t, as booleans MUST be 4 bytes for dbus.
stdbool from the filter only has 1 byte in many cases. This will crash
dbus if parsing filter->duplicate directly in
dbus_message_iter_get_basic.
---
 src/adapter.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6c539a81e..3655076c4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2646,10 +2646,14 @@ static bool parse_transport(DBusMessageIter *value,
 static bool parse_duplicate_data(DBusMessageIter *value,
 					struct discovery_filter *filter)
 {
+	dbus_bool_t duplicate = false;
+
 	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
 		return false;
 
-	dbus_message_iter_get_basic(value, &filter->duplicate);
+	DBG("Reading 'duplicate' flag from discovery filter...\n");
+	dbus_message_iter_get_basic(value, &duplicate);
+	filter->duplicate = duplicate;
 
 	return true;
 }
@@ -2657,10 +2661,14 @@ static bool parse_duplicate_data(DBusMessageIter *value,
 static bool parse_discoverable(DBusMessageIter *value,
 					struct discovery_filter *filter)
 {
+	dbus_bool_t discoverable = false;
+
 	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
 		return false;
 
-	dbus_message_iter_get_basic(value, &filter->discoverable);
+	DBG("Reading 'discoverable' flag from discovery filter...\n");
+	dbus_message_iter_get_basic(value, &discoverable);
+	filter->discoverable = discoverable;
 
 	return true;
 }
-- 
2.30.2

