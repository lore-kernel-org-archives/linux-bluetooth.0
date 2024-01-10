Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2089.outbound.protection.outlook.com [40.107.8.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C3A4CDF3
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jan 2024 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qVlS4b/N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBMTLGc2XVZoVqEMw80aZX3cl7q1gYU530fngXKR0uEn20zPipacG7DoIaWp5ES8txhGJGGk+Cy25IZG05Ff77Pe0xeMZnZf46VSBjroKsBWkI95M801Xk5i3pOqStHWa61DUuN/zD2yMLhhN5eabX8V0ixX5JQHYKU9fpD36oP74AFgiKalsDsB8cEg2Do8Pks30oXFBkZdwWcj5n/q6ZN1AjMEkDJM6SpjuL9O5rKTyX41nffD65tTfoCWnqjMg7IL6JiU9oacudK1FAq2Mvo9HOAklQ1fToOLVJyYnXG+McY/Wthn1NaLXsKtvjbqNMVLjbYqjAmPxItoVQwm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+Zc0XaRnat8ckEP4oXJ6gOsfqGdRdObLFhwb5b69yY=;
 b=fghpYXy4z/FCSEom+NKn6FPSj821gR1rSMyiNVYUePJPkbIVCwV6pIUEvNEU5NS2OVn4CtS72VgySuhP06ga+FRsQxB165MskC+u9+HDDwVkU1BK7WXQgx6qXrFnS67kzmQ0rQsXIDLMx3G/6OjhJWiVavxdt4MZR6vhp06i1sot4g7mcLPy4xlVnkh11EX+d8Br2z6f0LcBkqtfJvZw7iKbw5lc7h9d0qqUWEY62S4b7DFE4oDxTywYCJkmndv+h/xq/uRUyMvHXdpCUXkJrcxpwhgllSkGTlIC27/gSmAmEnjMSk6kw5N0qc+c+3GbON6GRu2K0BXK/WKS8vkZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+Zc0XaRnat8ckEP4oXJ6gOsfqGdRdObLFhwb5b69yY=;
 b=qVlS4b/NDJI02tR3QX0uqoxYOXHeZFF26IhB5CI83HJXi3ynXXZLsep8+xTtbQq+A6LNGr7BYXiXvfx+jjAqOa+0N3WKfy6hj/EuVDJ1NakR8SuXsPR6mrgXFEzCqn5YLIR7gh7i2vwEmFBr4LBKbI4+ZpUEVcPyqOXFYUcjYC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM9PR04MB7539.eurprd04.prod.outlook.com (2603:10a6:20b:2da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 16:58:38 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 16:58:38 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v5 3/3] client/player.c:Adjust the SDU on locations
Date: Wed, 10 Jan 2024 18:58:24 +0200
Message-Id: <20240110165824.114022-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240110165824.114022-1-silviu.barbulescu@nxp.com>
References: <20240110165824.114022-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0022.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::14) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM9PR04MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ffb4f5-0fd8-431b-66c3-08dc11fd640e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	f+ez6wE0F8vRc3/9YXcfU4yyMuAe+x3Iq6sdngin1EUstxCweRxnVyDjOY1fsN4UhiTnC0ElPZRUyOhS16ISRk0Z1pTfdzVOYCEhgCchtW/e58V4WlmIAlSh5azt3gkB2kuebzHK+3Kjk09m3oz5RboTJcFOAvEex2bxtGvwd6X7U6rPNWCF2GkncvQRv07pjPqhUeTxP/SA3MZMVpRZvMychFHPOhBr2MC91bWs5qSR9lBiLnpQl2GVlkkICT7NARBtcP/Uryxg9x8tXcYRIWK94jwOyU3JYDrGP+UJYc9TWjkEXemaf8NwY/UpN7lCECkvh2xJIjvnXYEo8MkBiE+6fpAFdaIswsWfZpjnzfiGngBuEopaP6aDWpTJXJaWS2qibA6GEQYcMpmaYFCcZcZ8S4KYaKdUVEakHgFM0obTaCseDDaOjvM5TiwTUbXDq5hKb2+LeWTY9anyPfbiHSzYD6i2NcDOWqnITKehlMHDUbARpX5flUiQ8kx1PMwGL4s2fn+TYFf2+lGwbH+miER2erFAOO/Dg5Cw6Vgzavbu6KUBhLvEIXkYZIBN9NiZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(41300700001)(36756003)(86362001)(38100700002)(66946007)(2616005)(1076003)(26005)(6512007)(6486002)(2906002)(6916009)(66556008)(66476007)(478600001)(316002)(8936002)(6506007)(6666004)(5660300002)(4326008)(4744005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yI+HAsx1k4sJpVxi7uqJN765ctg7eSfdQTKnrUsp8BusMFKXi4As99GTs6Lj?=
 =?us-ascii?Q?cAl1Je8hxgAE7W5mw76bn148zJFcIjOvV28YJIjeXNn0+Z7J1NhbEwd2jqcx?=
 =?us-ascii?Q?cX7cPsP3AS0J4w3ScgL5WYJAkt1q8wU0oHpN/cFPV5rgfLR0QMjcD0egKa38?=
 =?us-ascii?Q?4gaVUUGe0dBFVVCAxwbdaDqTv9K+MVJawgWzULLLJt5tLz2zWfPUV0SnIX3K?=
 =?us-ascii?Q?mGlVJZWKUFqXpWd6+yua17R2qX1PktSmS536O0VxNxReycuzV3sHMkENNt+h?=
 =?us-ascii?Q?tCM1Akj2tDL51WjOYmqFHnDh2wtaguFjod4Mrp5HM3IwwJKZCJMCH1EWRpn/?=
 =?us-ascii?Q?WwKHU/8MUP471nt0BM2Dy3/oWuEvskp6ub5GzVRZAH8zgSL0jDcu5wbwByT+?=
 =?us-ascii?Q?yCDnIklhCfI/wF/pl3PZyHLKD/yTQjH78goYUPSYdfKHQnS0dsuAZgQJqk03?=
 =?us-ascii?Q?dULVM3LDnFm9OozH8hEey24nNP68yz5dh7mZgKrLHp+MyfDyM6UOWmIDxirh?=
 =?us-ascii?Q?zRcOpAyXiVT5aP0Pqv0B7ub+FMCxShOVYZSHL7kzPisBENxH/bJgHXlIPg6c?=
 =?us-ascii?Q?xmsUH92qwnmMcSeCiDfD/1ih+wI+GZ+ugpU5eM6yXqACxoa1l0nWYtz30kQi?=
 =?us-ascii?Q?7w0xi5ww3SkdpmrIfGAmaP9UgS8O1rwFKCcbgWhsltYu7QN0TX3L6bjn9ybJ?=
 =?us-ascii?Q?nHgR6syS4135WGn2pyuJVQpi48nxS2WVSmNh5CSSTxzIy0hUTooVEpRmb4KI?=
 =?us-ascii?Q?E6dBleSi5TNAlqlD9U1lyWg29UCDEk78yEfBpPF7gbm7vxWMW9CDdCTmHvWg?=
 =?us-ascii?Q?buhRFBg9LpNMr98DGJmEKs53f21RmOe4lMqROUs5AZKQucsJE339Yoi0E/hs?=
 =?us-ascii?Q?hVRpp5ovLoVOPJoS+9+XlMxvBluDxIWJWCTbAxGFieuPcoOLCIu4H3jEQTT2?=
 =?us-ascii?Q?O+AMdw/0nz1vwV1g9ofA4Wp51ftYy40jTbKEVP3C4J7xQe0gC5mVHfB5+BS3?=
 =?us-ascii?Q?9sENIH7XMtoAYQ1o3hgOhaKZHU2ncl5IJ64CmtfLykQtLTBeA2FwORiFdh3E?=
 =?us-ascii?Q?aAiiChFZBrcS/K9llfX3zmzkBQJHEGgstDrFczLqnm1V6EwfkFtc3Z8lV9/Z?=
 =?us-ascii?Q?6l3hjjg+hKqqEEa+YRzhHzk7Jj2QJ6Oc3zgVPJDwYOTJSUB/eTUtPQNKKOfl?=
 =?us-ascii?Q?7ElhEHJlK+DxPIw0A4JaZs/nJCn/iwR+gBNpxr5gIYE6tAEbsTO4/aerlc6h?=
 =?us-ascii?Q?TsuiUUIqctfpv3rRN3kyVp0aISPt2HkQwZbM560XFQSSH0wtPXyTDA6tPyk6?=
 =?us-ascii?Q?Sjj9PpDnt6G7bYu6eGpmFSZx6VuwO2dkmMzxMpVjGyz26WMNGh2xJSHer0T+?=
 =?us-ascii?Q?w7yzGUe9itbQ/5Eo12jW3TuchHv26PargoZbwqHBJQ/2vb8ZTwcRie1I5eH2?=
 =?us-ascii?Q?0lIsKZJh2TejE4gAPQ+ygKcDImXcdko6LP+IVs3K9YbUNn3gmSnMadhuh4Pb?=
 =?us-ascii?Q?/wBubq9LpspN9UPFfNVk/LiiHn8WNYXIrYRhSGryA5VMP7RNVNBV+/oEdDDi?=
 =?us-ascii?Q?4RQulEU8kNChPXVQA/OnEYJIGAgMauAJ2w9HeSFNG2XIyVbGYVlN7EzykWu7?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ffb4f5-0fd8-431b-66c3-08dc11fd640e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 16:58:38.4105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lc/S74fp3xPOXJt3KvkzUTgzn9GPizrfpd7pROcX8dkpELNXOzBUUUIFQJ92XbuCE1Y8wyuDMxjQqyWLz1JcjxRIN2HYTV8bkdWE59DqKYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7539

Adjust the SDU size based on the locations number of
locations for broadcast BISes.

---
 client/player.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/client/player.c b/client/player.c
index fc5ebd602..c892dc6df 100644
--- a/client/player.c
+++ b/client/player.c
@@ -2882,6 +2882,7 @@ static void config_endpoint_channel_location(const char *input, void *user_data)
 	char *endptr = NULL;
 	int value;
 	uint32_t location;
+	uint8_t channels = 1;
 
 	value = strtol(input, &endptr, 0);
 
@@ -2899,6 +2900,13 @@ static void config_endpoint_channel_location(const char *input, void *user_data)
 		iov_append(&cfg->caps, ltv, sizeof(ltv));
 	}
 
+	/* Adjust the SDU size based on the number of
+	 * locations/channels that is being requested.
+	 */
+	channels = __builtin_popcount(location);
+	if (channels > 1)
+		cfg->qos.sdu *= channels;
+
 	/* Add metadata */
 	bt_shell_prompt_input(cfg->ep->path, "Enter Metadata (value/no):",
 			endpoint_set_metadata_cfg, cfg);
-- 
2.39.2

