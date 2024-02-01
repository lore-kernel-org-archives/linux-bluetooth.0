Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2088.outbound.protection.outlook.com [40.107.7.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0D515B965
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Feb 2024 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801338; cv=fail; b=AevZc91SDLVHDD//+jtZJwmU0qtijFlFEBKNUx2t3eU2QPtAMlpbzKabujen0XPLTw+xd8kp5WF2HQ9O5yMkL7i7ZFUROscS3TE8T5/rWMBNJIci3zb2fkJ8YEY9s7wXDviYPi1CQCm5vfOXYYsrzXbGlEWwkkgSzkVVayzqMa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801338; c=relaxed/simple;
	bh=XK0PXUtPlHvgCZkfYSl76tsrh3UUPdljYPVssToFD3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPkPcsMe1dlwcyq/ZLZpkohjYlmoRQM5Yp1sUaNVbv/kELnqnm278vJtvbChhr131lQaYO21M69M8EYfRDJLSaigOQCm0WOGN5scaJbWTMKn0lMSou2zX2kAzTKAcljT/R/7MheOA2sMbrl2kNeqAaXAybcLE1Oeg6OQ1jE1dLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UB9ygCx+; arc=fail smtp.client-ip=40.107.7.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UB9ygCx+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2o5XYDtBt5gCwjDeS+d4QE0YBwp19rNt8eVJOTG/kWoKRUK2m7w9r/d2DTebw9zloRfRHZip9qXA9f39pIzVik5Odls2POflvqIM5UoXeULz1WlgxaGZLjoS6vUGZtFhGJY48bLKAllqJ77SrTvoq4eKSopLG4rz2VROp+SvvQpWa0E+MN5JKxteNTdzD9tubelogTAOsGbzNuSazLgGGmSKNwzVZawVKaV47RWItCr0D5rr6T2WXGzKgZOaKrRNUSC59mmdmLHjXr3RYYCqPAo4QTKIpnXUbHn2Azy2oa79QwI2ZS0NDPxEa1TFErtTj23d0ha5noH7P2KeGYJMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+sn7aVtj0Pcb+hkp8gBV1cVx1cF/wfUv+WE4FEIORg=;
 b=SPHT34aSn33U/2mrJPOdGsi0i24fb4H4l55MQEn4qX6QqcexMxC3WYtjkq+YSTf9GOdi7P50nGmEiSkV7K2ILAUwBt1vd6kHuquiLCTHJGzS0b9QeoznwwwXzBMTHUIRQAWkkvBWTDAZU/h9at+bvLG9r4SIEiCJt+DjoYtVv3Rz+wK1QfZ4I+wK4lMO2t6oVKKOXtKWRk+uhEC611vsyG+7Sy91tJvxAy0QH4MeCRkuL09Tm7U8bdlToidXgnflFYiAx2c0/1gOneDw4yXq+13EWcTc+CEXzSNTXEHJ6JbCnWlPCVkDU8gOH5TPgVsthuooJM92/rMW/95o2pxErw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+sn7aVtj0Pcb+hkp8gBV1cVx1cF/wfUv+WE4FEIORg=;
 b=UB9ygCx+RJCza6us9WL336YjjS8iWEO8umvLzJQ2o79oWPT0lpb5cg0FNiFeqyssUkzm5448alLub6Deah3Ojkv8bdQada2C8hwrY95FBJGhUMaLiS//jiGuG/zZ7MQQDGTF+eYRLwG98DYQXhaTPPuYDzu3WtBZ47ttEtP9avs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DBBPR04MB8044.eurprd04.prod.outlook.com (2603:10a6:10:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 15:28:53 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 15:28:53 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 5/7] shared/bap: Check the state of all the streams with the same BIG ID
Date: Thu,  1 Feb 2024 17:28:33 +0200
Message-Id: <20240201152835.196617-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
References: <20240201152835.196617-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::19) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DBBPR04MB8044:EE_
X-MS-Office365-Filtering-Correlation-Id: a784232e-b75c-4785-529f-08dc233a7f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	veWsA5DrUPldWFpCb1QIkrfmK1TG2oYG45Eawk6XYS/GV+AWIQ/ht+qkqtb2+lfvDRMqY9raNu4dpOlu+2V0fvac/En706wAr1bsVD51ijsPgm0c91QBNk8R+w9xEh4IzAL98c41F+RJgzRjD+2EPELvOGdFtIy+Orv8swlPTgF36cAnEHYwk7E0Z+HKMGEPMK2FA5LO6DwpXFYx6GLqBjUVYt0Hvb3GxRbuuAoRW5e/7kQiJfE3fNLCiEf/xcFhtSyPXU4CD6lZ6Z+weGStM6uyq2UzFjNKx3l4Pn26IXj1XCQrAqTtm61Yvj7+k9Y4dXT3/HPBK98PX02XDMLhdvnJ3zKK6dESvYrn13ObpgcC7uBMZCeSzSxNWx6L/Ck+NLMNbatvx15/cGunAaKKXkHjIFvXlsgCVq7ydEzpBK1M2cl9Hy7nPl30Fk7INs19Un6ZT07M4pqornxaTJuXk2TBsni12UPmDPbkVtuvXbMmHwqpl/Yp89hFeKIjdMe11UFFlA0J23TPFq7HzZkJL6TZtRkh1fphh1tOlJpFlEPXOH4EJ3hrDa2TYl/alRvk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(66556008)(66476007)(5660300002)(2906002)(316002)(86362001)(8936002)(4326008)(6916009)(8676002)(66946007)(478600001)(41300700001)(36756003)(38100700002)(6486002)(26005)(6666004)(6512007)(1076003)(83380400001)(6506007)(55236004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kBlzIF6piUSubVC7tugsZri+jmmLwcIh3oLJmmrTQFUn7pDtsMUUYufnjIJE?=
 =?us-ascii?Q?htndKi+ODfb8MvKJhbvo0/qfwXbEDAAZqEi4zKzMqzfSt32cOh08DQrkAan+?=
 =?us-ascii?Q?xUyB2ENrEWaK0d6bfGfP67/JAfj0cnDT1ck9u86te8hd/e02FuNg9OkpcKmq?=
 =?us-ascii?Q?pxNrPIxsf76nPcbbVhzP1yEIV/82XBRCG3wfyqn5ZXlQuuYLyuuP4anESp1A?=
 =?us-ascii?Q?P95YGzwAwyjh1m6nAj/FnePxNGxCQlyeQw/D6N4MVmmUtgRUaeI1KFlHWa0g?=
 =?us-ascii?Q?MjMfK95aV9geKEs0ThL0dbTEp0Aa4XlfGYpRqRfkmJhEQG/S0EkeO7k62CxT?=
 =?us-ascii?Q?/a/rPL17mPEH27uV/NkkPlFYTJVlNfw0moeITrHyzaxftCUEf+bAU0LnOHzy?=
 =?us-ascii?Q?D0cFNm8YDwwYyDFSQLF86g2W4jWTKPrGGbMqpY1NQfS1j6/QEzN/4vbIppUn?=
 =?us-ascii?Q?k58QEr8tWTsRRTx8zuUEeCecpLh9s/+9ZWFffYBaMMnW/pD7FCW/Zq9fRNMA?=
 =?us-ascii?Q?nlJP5r7f8cQHklghMga/x7rP9xj6JKZNYsFqrpdfPftWkGgTLEgViXxkS9IW?=
 =?us-ascii?Q?ftpHZ+ql0TdWOHXMxPKpD7kduMi64S3qowkBhO6A3HCO0UkXRfqeG0hrE6Ko?=
 =?us-ascii?Q?heqxZ+RXbuj29FedMJ8MjMDdXSAg3/NEMM6GUHWn7pYcQb1WDduOWl2mON5u?=
 =?us-ascii?Q?zZG3IpEw/trEqXbzMalrXjigNH5w4eO1C/esCzFX74cuqb55gRyPUIJYNpYJ?=
 =?us-ascii?Q?bRYeKg5cU3HEi+65LceaYFGyU3qgC2GdCc633gsCi8P9LWH4LoFvsdT8r+Qf?=
 =?us-ascii?Q?XBsG7H1RpN34Ko8Y+kizHoZhFJt/zROHkV8lV7YTrn5saEkgLwDdWUfzZ1k9?=
 =?us-ascii?Q?vG/WRN4MmwV8VVNVN76z86pLPn+IqEPDuuyNgELmnkBZYwuTaR7o4iBzAvhi?=
 =?us-ascii?Q?ZkxINUKVfkKPaEXQ0rYZcMwZS5XNO/MhadWX346mqhDF4AvIGzgVEjdsCn7f?=
 =?us-ascii?Q?aDl/fwk6DNeOkECxv3zoblUG7sQn682U2Xb0G+KBu09Mdryz4d8CsS+A5KDK?=
 =?us-ascii?Q?DhrCLwvGhn/Ph1/TVDdsRQQmvbMQ1FdH53jpSTIabCcsEfG7TubiTUw1uCCh?=
 =?us-ascii?Q?sK/ZxtN9hDSMTiJzP5vH107fiIWVcOxCAvB0wjd3P6hHU6dZjkwRqGKu4Q1N?=
 =?us-ascii?Q?g2n8K07eIbCxx318drWxg3HwRDrNDL4qN4mzYk9wQeUpx6Y2McDTxKZjPXyw?=
 =?us-ascii?Q?+oQ6YYCs3Of3VZjYnrM3yNu6Fn45E04cb/PKmS4oOlrx+swrRFuOkTmCa4u7?=
 =?us-ascii?Q?M5eD7C3rwDqfWY/mk2F+k4JXCMJjXRxeQ+qZG10YOINQLYwRsXYWbwI/J3kP?=
 =?us-ascii?Q?HRT6RYVhAY6LlEZDWjTlkYiyKZK5b+SfehFenaP/GFjb7Bcf0Pej91RXiJMv?=
 =?us-ascii?Q?S2Zq6zFvyTdzhEq6Em7v9voov1bdVj/gC5dI6wWkUw5IQaSpN3wqt2dxPqdU?=
 =?us-ascii?Q?GZYhMX7spph5h4IxxDFk0kCravmKj92BLbxacgLlrvwKNFPXFopWPL6VS15d?=
 =?us-ascii?Q?1h04QLlj/b4uhU8oCx5YlX4QtqXNRcKt8sCtMyv8QVG4mHfLiSpuA5BP61Yi?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a784232e-b75c-4785-529f-08dc233a7f4e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:28:53.1896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 34R7rxJ1KIiW/FVi/dQB4+gw6agVxSg1fzpfLka1SItJpGKrf5NsRJNuPVlsT4Gty4A89ojScLe/+iagcHXPRrpw9DskzvaG2//4JlS8IaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8044

Add a function to check the state of all the streams with the same BIG ID

---
 src/shared/bap.c | 26 ++++++++++++++++++++++++++
 src/shared/bap.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index a4c6a1bcd..244bd8c4e 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5884,3 +5884,29 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 
 	return base_iov;
 }
+
+/*
+ * Check the state of all streams with the same BIG ID.
+ * If all these streams are in the checked state, return true.
+ * Else, return false.
+ */
+bool bt_bap_test_bcast_streams_state(struct bt_bap_stream *stream,
+						uint8_t test_state)
+{
+	const struct queue_entry *entry;
+	struct bt_bap_stream *e_str;
+
+	for (entry = queue_get_entries(stream->bap->streams);
+				entry; entry = entry->next) {
+		e_str = entry->data;
+
+		if ((e_str == stream) ||
+			(e_str->qos.bcast.big != stream->qos.bcast.big))
+			continue;
+
+		if (e_str->ep->state != test_state)
+			return false;
+	}
+
+	return true;
+}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 2c3550921..9d46c5ad4 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -323,3 +323,5 @@ void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
+bool bt_bap_test_bcast_streams_state(struct bt_bap_stream *stream,
+						uint8_t test_state);
-- 
2.39.2

