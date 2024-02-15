Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2055.outbound.protection.outlook.com [40.107.7.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D7C13B7AB
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 21:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032260; cv=fail; b=Kb4XxLD8+LUmpC6xiIIBXGNBg+neFFtuwPhkjdiwZb2SW7+nH5zQzkrOlw6w6xlNj3M5WdX3MR5lkYszseWLUItoHbKCspCN5a2Nq7TnTRahaShlhowYUn+53hWgk77TfvcHZJFonKI+8J/g7GWq8QPh+Z+ofCLXZSl7zJDrbvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032260; c=relaxed/simple;
	bh=WQv9nzgbA0HJf9t6Ul6JhEdhcUKJYXpvHNVq8EKg5nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ah96SK9NjUAEhWTO1fZfb4Vni4Bh9qtSLsbN5TSyerMYY7vl9xnsAht4QYJs3ddL8DDTXKqngAVsLJScIIGAabP+bstXY50fw4aAU4nCgke1eiLOvIV5bar6JnXDPjh/aYZ56fNfc2mrrxZ49g7y1ATw1XCQcuGa1fsftG76e8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vn1BMDhx; arc=fail smtp.client-ip=40.107.7.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vn1BMDhx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5RvL9jYiPDarIi7c4KUJctnk976knUF8dmG/oRq3OQAhXzUKzMnUi9ManyLp5qVeu8jtfoMJnEvREH/wK6oY7pUrtd3oROH0tbK3j5RK7dCULlNQmiVT60er9fMiKrzt3mq0QDjHZqPsYoPideusoqqlX3WqaOc7ogeHLa19HaSvlSnoxQLfMbfrQrSLctHYbNmWaltuZBqeArusDY+QN65KIKWzcFUL1EpK56oPjYLkNdzp2zAR9CFDqBSBWMBQvtqFiT1/wWQHOhNPxp5GkyeooR51NRLDpMFRmZMuPNGW0SBEbaeZeEVKwH+0VQbgRlwjRoea/Ms2ACoMqaH1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmPi8+u5IdQwTr0VAz2Ml4KooU3k4eu4lGsZBC+ewHw=;
 b=WRgJ7wVA8OGTgK4rUg2ADpSZ01ZKY7mSVr2hjKlDljQMzV6yW5fMgvnQldwmWy+FOx/X1hE1qc5UNIiZO29UAEQ8GDIZjQl4+xPmbokngexOQiTlMSm4jmfSI3fVYacLoZVUOo7GrRceRUQ+CqayKb/MECzSMG7c4XSdm7MQ35DqJAjHmqWffrDShubal4qz4nNW2rZ8/tmFCydofIFfJ4Ob2AU8+RDqmSVIXfvQu+/CscQrCdfFlmiwxjEdqDuFchu9Ei5iOn6K18jaD3VuFX/OkMgGCn3+S4pF/lqNqrZofN4IO4htrHq4em5rl5uz603tiK6yd9sqysUxsxtKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmPi8+u5IdQwTr0VAz2Ml4KooU3k4eu4lGsZBC+ewHw=;
 b=Vn1BMDhxgJPH746VdTFGDVPMPlwR56FNkzd6NvF8VW5GvThP1IsnGZp0diPt2nShguA7epc9BK/7vo039e7De3DnOGaGrHr1RUYd8228hqoXO/qYggs2nDx4/RlKYXOZ2Zl/SctxykWkrzhULVDXgS7UnlYxvKqcWe5Fcx6NzOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB9128.eurprd04.prod.outlook.com (2603:10a6:20b:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 21:24:16 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 21:24:16 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 5/7] shared/bap: Check state of all streams with same BIG ID
Date: Thu, 15 Feb 2024 23:23:54 +0200
Message-Id: <20240215212356.310301-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
References: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0090.eurprd02.prod.outlook.com
 (2603:10a6:208:154::31) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: c07289cc-b30f-475b-983e-08dc2e6c766d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0/+yAUOXK8leoxZ6cvSqbutheMu6pkSsNnTMqNr78CvuyXK1Ds+nJLSJ+wW6js5VMtL3VLJp/Bj/rp2LkAN/Vn1uAVZ1Lf0eqpJJpkEkXtsuquDVkoJ0hAGd8XHw1w94qdlCVy/SxFvODlcZsf6tqHJYFFP+JFEfQbzg04KhOFkKGdLn6eyR50+KWJHkMbl+Ikmw2x1JyDiQ0rYI4lF7GUDDZmehL8YypFMfkSI99wjhofk1CKGi1jb01RXvo2RlJ+zPxuqOroad0qwxDCAwPte/K6N3i6CkDwI7dgQU5u3NmiKftsMonOvVj2f0VEHgtYHtnzox0OJ8PFw1edjFwl90SHlGaWXPxZ2CLiZbs6d3FqOkROvILMnO8IGegyHlrsTsCJFUIqGEExc2pkFF65jDTw06AgQDUx5+Wh0+obOTA1IqwNuy/RH81+8G7iPhb2zePblRyF5yGbVZ2oZ3RC/8woO9hEegPpWHDKQLFmv5ksPZXU45BFCDuk5BCslySbk4m1gJtpIqZOZ0WmTZJMeb2dybQxBHiO7zRVVdz5KuafMMKuYth6bsbsAiultF
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(316002)(66946007)(2906002)(5660300002)(66556008)(4326008)(66476007)(86362001)(478600001)(41300700001)(8936002)(6916009)(8676002)(6512007)(6506007)(6486002)(26005)(1076003)(36756003)(2616005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PAHF5Vjxq2yTkgns01DbD6d738zWgVM/PfUxbTbfL1e+t2XjlNyEs+E+elnY?=
 =?us-ascii?Q?gZqBrIXTpkgz/pW3pDW6e12Yqi6a+abrOhwJ4gB9Qp6WBeQ4kEwD/3YfmHj8?=
 =?us-ascii?Q?mw5tyGDmcHvoxcEig9oQx2XUF3JL0YKOANchl4wnWjGHCkQLQUnVxb/N/djH?=
 =?us-ascii?Q?5mHYkCIxmn2xmNLBg73f/l7WmR5opGIBKgrae3xwp7Lzf3dwUGjjXysvaUtL?=
 =?us-ascii?Q?cMaQU3zTFHLJtSqoQybFW3OK9ktLJ+ivzie+f2rkyMP+egQEIjGT527VsVhD?=
 =?us-ascii?Q?8Aa4TZw/jVmhgfUm9QdljxfW91VCa1EdVAsK6RtwWRyo91LrH7LkoYbwcIRe?=
 =?us-ascii?Q?OiXEgk/gpampNZpypJcuac+XbhPytegfvdN84jDrbaBhmTnQgu4W0W3M7eB1?=
 =?us-ascii?Q?KHHVWQuD8STG/+TSzmh8emyZ9SDVPymrv3VtABeB79+RHQnM0v48fdXZhI8v?=
 =?us-ascii?Q?WNqR4gsBPRM8zHSag2yTExg2tmWrRtE1S5zbjm+B2IMLCsqcXcV/Dkhh7aCW?=
 =?us-ascii?Q?UJO8A6efJv15+l9tyWrI31iE8ua2jguuU5SgDdhAAJI5nK2dzgTTCqCoeIlZ?=
 =?us-ascii?Q?GT8G6xdZGZ1gWfAf5tBIb1smDu5Q8U4Y/SM/L2/bzFGH4Kw4OCugg7EuXuh3?=
 =?us-ascii?Q?QrdUigmIbWWCLp2+1AGTHJbwKZrTCW3UQycZnpgJmu4MQvFGxKkObjMB3m5w?=
 =?us-ascii?Q?xpH70YcxLGGb9h+vHxSHkySHVz7Ksc3wcrMqTUS4dAbm2vNDIgBtQ+NQzvwT?=
 =?us-ascii?Q?5JoVhLNq3PKV//kHswI5yV2plRBUJc0WzYoiUJoAmBy9Ri0IlSU4Q+A3WynM?=
 =?us-ascii?Q?2793pJTIRpX87z8s0j6TqamEha7sizfJioRhAZ0trS+O23aEYZsrJfHi7RkN?=
 =?us-ascii?Q?+3xOkwIYPGjOjmkADaGhmC7mzM6+toZ1TxGM3XzzIi1Kxioc0VE6FbGvSAam?=
 =?us-ascii?Q?9nPgjkfoy5uDqCUmtWT7EMvKAUwtNGXBrsPf3Ys0EeTWl/aBw3Tla2dNI7uW?=
 =?us-ascii?Q?gbQFguRD1PNdMNNvBold8kChauvMhMfH35fEc6TSDuNcRFJdfwhBWqKb0VP5?=
 =?us-ascii?Q?zQqUiY4MbpyQRiNU9iIrk2GBRZ2UzvZlNJ2g4imwvLvwxIWtkfOm5xXhaJJl?=
 =?us-ascii?Q?m+KeNOK/qgpAm0LG2csNQ8uY3PZ5c/HGvosB0DMAQOrGwe1MuVdU8jm05zA+?=
 =?us-ascii?Q?iJbnzY9L8LukuIm0Rmw9raoYtW8qeLbBR1X0ji1oDrIc1d6RUv6t2N8+35C7?=
 =?us-ascii?Q?mDiBa5OVve/sxMP3tezBOGbRUnJ+SN3Y7rWjRjaTBlLl1o1+lVOQp9VOHu2y?=
 =?us-ascii?Q?Mk7ZUjKt3s/hBaiVogee+G0KjphIVtiuInnkLv5xOh+NjRWE14/mbx1QIu0W?=
 =?us-ascii?Q?xsSPpNY9fdqsuWTlBhTC2od04NNXYdW4pyAA4WWagGJPopGwD6RTV20gbRH2?=
 =?us-ascii?Q?OvpJZ9aWe6S+mA6NQYxVIasCpVOrkHJlRgj8IjLSMeXo7NAyLN2dqnPkV1jq?=
 =?us-ascii?Q?V+cP8BvCZZ2QZOZfDB5BAikO5BEc5fdeotZY+ga/u3xJzaZh7M+hYSyPZqYf?=
 =?us-ascii?Q?7JcvU/BKr3dAgumc21DtbNq8XlI8c6PaUKXL9mCbVU5FXUj9niYR5/0cUZKj?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c07289cc-b30f-475b-983e-08dc2e6c766d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:24:15.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0rTLcuhc0Um6ZpRdMIz+bIL5qowTt7M9nacfoI4k1DoXkLg5s4ZezFrfkIMZwHMpGpNJmy12ybuRxKvrAZYtczLqZ21FEyj8JrvV9sbM3jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9128

The function is used to verify if all the streams from a BIG are in the
same state, and if so it returns the number of BISes in the BIG.
Else, return 0.

---
 src/shared/bap.c | 33 +++++++++++++++++++++++++++++++++
 src/shared/bap.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 524bfa058..49d9838fb 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6115,3 +6115,36 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 
 	return base_iov;
 }
+
+/*
+ * Check the state of all streams with the same BIG ID.
+ * If all the streams are in the checked state, return
+ * number of this streams. Else, return 0.
+ */
+uint8_t bt_bap_get_streams_by_state(struct bt_bap_stream *stream,
+						uint8_t test_state)
+{
+	const struct queue_entry *entry;
+	struct bt_bap_stream *ent_stream;
+	uint8_t nb = 0;
+
+	for (entry = queue_get_entries(stream->bap->streams);
+				entry; entry = entry->next) {
+		ent_stream = entry->data;
+
+		if (ent_stream == stream) {
+			nb++;
+			continue;
+		}
+
+		if (ent_stream->qos.bcast.big != stream->qos.bcast.big)
+			continue;
+
+		if (ent_stream->bcast_state != test_state)
+			return 0;
+
+		nb++;
+	}
+
+	return nb;
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 2c3550921..a37e1528e 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -323,3 +323,5 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
+uint8_t bt_bap_get_streams_by_state(struct bt_bap_stream *stream,
+						uint8_t test_state);
-- 
2.39.2

