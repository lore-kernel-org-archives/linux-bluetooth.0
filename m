Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0BF128395
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 22:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271382; cv=fail; b=SOsrLLDV77WK+BJOwrpLVxgC7qokcQny03ukb21/2skr/OugDkLhNWVwhbvH0UPDjNr9zmVueEb7aKS+4tL+9lAVC6EekFyfdF4E+wJvrx9CGgS9TpSfNjr2TQyPjKjVLpmWdOc1JBza8O3TlmDAU+Vrv86kueQ5UktF0iY6ibA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271382; c=relaxed/simple;
	bh=8As/1xdGrwWjD3FV4KZrZ++VepW1P44sn1VP13dPJNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N8Ts/nA80TI4GMmsFzchTmFc1dzciTuDKkd6GF7FnrKRkCxLMoIewoqhaly48TNldoaOuEQGoZNY6tYcBp6SJ3psngUyllEvZ4ij84TbhJUM9TmefojV6qdb5sE4sw0+Cl+K4WPd+pZgDevqH9rCKiti0QsqibvxHjaZJtCdVTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=b1PBhf7Z; arc=fail smtp.client-ip=40.107.159.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="b1PBhf7Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX/l4bzJsUUPnbo3+rXFNB5Own7wi4OOs3D5lspvytzljw4gdj9IPytHlX87gj9Kl7RoV+TE5LIhnaiAXAmTAw/T9yYMvU7aaLnSr0z7Lm0h5nn+EuBZr8c0kYeybFo4SwQymPoru0W4BR3wKBkGxmzk9o6QKvwr9W5+a1R72UEPT62/j1YMPxyfD5b45j7M+ndu/3ChNsuLMUtCRGimsqlf/EAEIuXnJcDV9r4tJTvmoJf7B9BgytaQXgrBmerSpFGWFEOqeOawxBoHdmuzV6c0DNQ8ZnbOAR/NXVUlBXSNZ4ThQK/rFLY0fBvtHl7Xcec2B/oIp0vXryUH+9ZsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tDTxMuqkRe1LT2aFDhBInTNUMj6ttQA5fslL86AIBQ=;
 b=XX/86FmsNr+clEA59cdtIwxW+3wrtbGoM66uLIZbKvpQxe0OXLQWlaKNoTT0WNHudTvDWe8MQM/VVqLvy3G21aGKQck6D1WfDb4DL3O+OJPqgWJ5EqAinJYKTqTM23C1eGybiLHE6os739LDB2bFz6eWzQfmpjC44Llp6sI7NUbMEqj/RH1bPysGYug7jfq6BekXv5pO62qVd+jKWcpSKH802bBbEqojqWoz0uPAW4Sw1w0Y3GTE0bT3iejFQe+cjSL7tqxqxoreeYHL5b6SBBFHBH05dnZUAYcAGdCpBePusMLuRTqZdHN5nj+uxZV9/+94lhJms0U1n7pwpG0CEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tDTxMuqkRe1LT2aFDhBInTNUMj6ttQA5fslL86AIBQ=;
 b=b1PBhf7Z7V3RrEYgu+KOB9hFiCsIOHChAdaR3MVrsuRUbdAUKescwBOlVJ/SDr3H4cI/JwA5+IJ7MjmvVxczdja1cwXfhkuXZ7C6gtz38rPIXRDKwo8WkdUcSlcdTeBKkbcljrShIoZtbhI1GlJKz7/oddLaFVa1/IvYaGFG7kM=
Received: from DU7PR01CA0005.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::28) by VI0PR03MB10202.eurprd03.prod.outlook.com
 (2603:10a6:800:20f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 22:02:52 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:50f:cafe::9e) by DU7PR01CA0005.outlook.office365.com
 (2603:10a6:10:50f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.25 via Frontend Transport; Fri,
 11 Jul 2025 22:03:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Fri, 11 Jul 2025 22:02:51 +0000
Received: from N9W6SW14.arri.de (192.168.54.11) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Sat, 12 Jul
 2025 00:02:50 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH BlueZ v2 6/9] mesh: net: update comment
Date: Fri, 11 Jul 2025 23:57:18 +0200
Message-ID: <20250711220035.10065-7-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250711220035.10065-1-ceggers@arri.de>
References: <20250711220035.10065-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E3:EE_|VI0PR03MB10202:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a1fe1af-9023-45d8-2822-08ddc0c6ae12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Eqsd/TOxBGCdZQHJIqIYDLNFl3xfMTIjI9Zt9jaNiJ9RDSISQr9n1n++v9QA?=
 =?us-ascii?Q?mFy5VLELNRVzarKBE/PLw/rjE8936HA/kgqXJ/l0z2Z9KDLuyQCsh73NkhQ8?=
 =?us-ascii?Q?BVIxZgk9/6G2kUCsM7+j0+jZQn/LnHp9kP4wW8jOYC2PQuMvkHBn8drh2OvS?=
 =?us-ascii?Q?waWhn5DNL4kfI/XrdkxytIhpF4Fy5MFqn01wk3KaJyt+Npz9D+En5KeKL9iz?=
 =?us-ascii?Q?/7hdN6nGFlCcE55+JnQZYmxyUgwjfI2+GFB32dwu0SNkaAks42UZiXxvdf2J?=
 =?us-ascii?Q?/PFhK5+li67x9USVFcjkmOnxIo7fjQi9qZNtZSK45SZr6+muZPbq2OZC5919?=
 =?us-ascii?Q?+B+ORc7ZaPD7zGThlT+p163y6U5iADMGCcnjpcO1/OXT+wKmOkwQrIgt3drz?=
 =?us-ascii?Q?olM0RFNWdOGWGOINXrwh4vHvbxfYhN2sfBvkky9oWak5uhKcERxSQnth6usr?=
 =?us-ascii?Q?KzwT/Hr+yZe6thBVDJyN07+HTgdjVbAJJbxQ1206gHFKQjGqxmFoqnp+/UBm?=
 =?us-ascii?Q?euyjrFEJWU+R/nJsxIDc4btPu/3LKwwxsuxxFvluwej0qU3EtSi3diwKEFCc?=
 =?us-ascii?Q?7hYuRwjyVFMa+GydmKq9zLIx/zS/VIoknV2qBKQs3Jyy+RJt92foNA6VtI4q?=
 =?us-ascii?Q?KF9IIBfrBSCTM83WDx41V6WbRXy1nq12hP2N1oTEgZdPbO7kYGyjfOT77a4s?=
 =?us-ascii?Q?kH48aYMF+53LSVq69b+zYpLBq9zPBUZxlGK8xP7lZnuWIHmmsdk2ck6Yih+d?=
 =?us-ascii?Q?4DxjOuLxLbAKWdv50L1vAblYW4mgGLE91zaVFWHgrquj/EW3gl9ul2hEGGwI?=
 =?us-ascii?Q?/fdw/Mc/SNkBaxAw8/GFFssfX650odkh9d2hlcqkq81Hoxe7ARHrPMHd+Zb8?=
 =?us-ascii?Q?OTJg4hgBkgLkhZ0/zZTKL8TwiGrhlms1D6L1gHqRh4JW9ygzf4gK2fTF5Cd0?=
 =?us-ascii?Q?EV9b98rS9G8rZ3rwMmDNMiydzABvLDUmXvdZ9iJ51MZrHSEGBLjqUStrM6v/?=
 =?us-ascii?Q?qWnyB00YsACuJPaWUfiWrSoFWkrr39GgCf4nQXIocPiRaRqZCfcTCGQltxPV?=
 =?us-ascii?Q?WEuMQ+eob1OEr7htlBeTV7idCutXcbjUgjmuo7xqG/YVsUMcOY0BBz4YekC4?=
 =?us-ascii?Q?W+Xqw5T/BbNbfOc7lT7l3KL1dEaIKFc78cAvbO0ytlJsz7pW+jvLs9/ctaVu?=
 =?us-ascii?Q?sFslz8YNRzsD0ErhYlwNKZPHvMPfFQab2ojW4HnKR1cze255ZKtphNqdXp1o?=
 =?us-ascii?Q?9iYUHOUgihzD1DrEzYt5QtBWpCoNTvQLzrj4br1HMSG7MS6aCGPqWTgNidKp?=
 =?us-ascii?Q?LG80ye4++nkz5VyxWIRQebda3YC8VtAidxls0uIiw8lrsZozqXpuL8iOBs2r?=
 =?us-ascii?Q?q/9KwRJvjaOjMjpeM3GG15RFtFM4VJpWH9R6BOPci+lCPDrXCdP7TwjWIHBk?=
 =?us-ascii?Q?0OenasSH8NfpAA6duvy1rycmE9XtWFoES0S7KBK9Y8+DaTZ82A6eTySevBn5?=
 =?us-ascii?Q?pcw64amBNzb6aK4lRWe/NJ0IcbVWMdyG4hwy?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 22:02:51.2245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a1fe1af-9023-45d8-2822-08ddc0c6ae12
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10202

term 'master credentials' has been replaced by 'flooding credentials' in
commit 09f87c80f1d5 ("mesh: Inclusive language changes")
---
 mesh/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mesh/net.c b/mesh/net.c
index 3a93f6624e8c..b29e24f5d4a9 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2487,7 +2487,7 @@ static void net_rx(void *net_ptr, void *user_data)
 	if (relay_advice > data->relay_advice) {
 		/*
 		 * If packet was encrypted with friendship credentials,
-		 * relay it using master credentials
+		 * relay it using flooding credentials
 		 */
 		if (frnd && !mesh_net_get_key(net, false, net_idx, &net_key_id))
 			return;
-- 
2.43.0

