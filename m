Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE78115442D
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706542189; cv=fail; b=tPtvjdRV1bTrJnb9l+/ppy5vRAasULFIsiPN9lip3pPpYs3NM6swvSODwvRKLbVgrBP0F3rsN7Gbq0PJ7al1vBSp5Y8inG9Z71bV8x7YSc1gHZtl0dPUtJ9kfKH0nttWTtJezLXMSjBzK7aeYwgrPEKFfOhhahbz/DPO9838eGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706542189; c=relaxed/simple;
	bh=cq07RZWCCJr9WcSjjywnkDUz/r6xMuO6qdxc6zOUm3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G4SaVnThUlBE2NlytH4bgsyVWi8iALBewLQ8qLPBlU8B4F745ADWsMmQBzPRSYRe2OCEx36KgPUkpXMMaoocxX6EZ5Lc+2f2eHW0HJ9E7Uv34NDsap6lL+leydaM3GBWv1/rMUW4QcvHBcyNQx+fnQXscx+Us1U67OSjNFj1q4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=THky6e7Z; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="THky6e7Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kxx8S+Fw9QJOWP0cQEztiEBbEPmOzRMB8CExgCWo4VAIr75I9h7s3NOMwiEEzwfyKop9l2AguVzQZ+0rXbDvVJ9qKSfn7QsmFLTztLPJkoViwG3Sq8Fe9SskFDtPCeqo0AUlscDRM1yqYw11JjbLFvGCMhSe+9RznRwZCxFnPmeh5D460gkt9JkBxYqZ52R4APXuAkztFrbAD3mXDrQ5sYHkfFXRCTjgXmya7n9BUj4ARevzOnq5CdBwYgf47RAiIw48D23cIzIoVW3oHBwvNLCyyN6yCP4cAkbL7AMF0p+mzUYJlQtbWru8fZEyH1JsEgFSQYx3FNgVzLTWHMlYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s87yWYOocYHfdoe5TSnkYD3DkXqyt7MlvHqQPI+pnRs=;
 b=EKUmVNFKXBq3rlgJujgZ94S1bI7J/4MUGXF/qJvWVc1u0z364zNWWjXLWn4nDXOgAz8geGWdyaDfLgHkQpfGvBJ9WHMlGVD1AWhQkk7Z57j618IulQqUOcvdGIcr1ZkVjcKbuOpQR968/YxE876h8GxTkxfPEd3FJxQk2iY9fRcjrNoB3SSAiSxSYkhA6f3RGcaY0MK2mJOI5zTLUWorG77BM902nc28dBQOXx138rt4llP0RZR7idlSTvi2J6d0UP1n7JTzZD53Ynf2/Ei4FFixUc3z8yRdVz0u0iwfHiASoMqeHgfwPaRUu+Yk3YoLdbp0jgNWuTJCUKodrtMlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s87yWYOocYHfdoe5TSnkYD3DkXqyt7MlvHqQPI+pnRs=;
 b=THky6e7Zk8A191CX8GIflVrdNoeOCZCEVxwKemlz+vErHsG+n6WBt4fDwc2aclH3fLSHv2FhmwIELIz6/U3HZT6bxQyNPUNly2gr4NA7bBor3FY4UQx/00VXT/wvCmMakZQZuXz/FsUvepVKI3O4bV3w6U+tF0OktjRtLxIQ8Ks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7105.eurprd04.prod.outlook.com (2603:10a6:208:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 15:29:45 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 15:29:45 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/3] shared/bap: Set bcast stream metadata
Date: Mon, 29 Jan 2024 17:29:27 +0200
Message-Id: <20240129152928.3904-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129152928.3904-1-iulia.tanasescu@nxp.com>
References: <20240129152928.3904-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0024.eurprd02.prod.outlook.com
 (2603:10a6:803:14::37) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7105:EE_
X-MS-Office365-Filtering-Correlation-Id: aef6d86e-5313-4651-6881-08dc20df1f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	whqDMzE8rVBlPW1E6yu5bC1jDG/CL1YFfb9YwJ15XVM1TpZsQpd6OmC+2e4TqMgXgxtQdS+01wOYWXQN3uzwRgkT8WzWNTRs8ja1JjOnQDPLZD9V8dmnSecpLjCjDAl63EtEMZtQTpi5wXhfvQ3PcwbzU8okRBDwNo1zykLgUwFKbe3IpwSbS2P9fOtyniOZjWtWfTqf7VuEr5AvQuivVKgbu04+eud/vt0BqldAFREFZxRf5GlYE86OdotZOLswdU4F3woHIEMpoAUUubzCa7TSwsVe+dhvV4DcMCdJxnZtThmYzMGw764gwqk+HKrDH8WzU9oWXLXjagkyKwEqBgpi+VgeMusrPpdbae13Z5cdNDc7mbmX5phkf/LI7sxAcklLXpY3Ghg7Mx5qTH0T0DeviYgz6ew1kYVSeND8ywceUhzVNFvAK64lJZjWtI61YZvJYY+LXbmVU9FwfssXDnchQLqoHvu3pMzRr6gv3SdB+OjM6iiG4M+hotuRyZQppJEd59ZLNCfkH8xHOZw3ESwQYkyzoGdJ8cA7FFEz55CWDagJmdem3vReOTDUX3tO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(26005)(6916009)(6512007)(38100700002)(2616005)(1076003)(66556008)(8676002)(8936002)(4326008)(5660300002)(44832011)(6486002)(6506007)(2906002)(66476007)(478600001)(6666004)(41300700001)(316002)(66946007)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2iYqQRDqeJjxuU4v5iPalm11/sPjX6CGzWhVePzTGC0wQxUyfvgC7Nag1uo3?=
 =?us-ascii?Q?UdYqck2bj4XCPmjx+sjsmqxRJf0EOR0fPXa0ut9KpwtW9u82QQupBXezptTD?=
 =?us-ascii?Q?ZTRfrYLByrpToeNLcix5/xlYUNQp1+Efnqrbh0Tu73h/NUVIey5JE5/HAEUP?=
 =?us-ascii?Q?7tKCPBEc96Uzvw5OaXyBrV9AINfct4C+9oCaR0XCa7oOXCpkhNtpDNfe2XeV?=
 =?us-ascii?Q?RRYNW+ljXGWDmkmq4I3x7UGXu1/dNyOAB0Mbl0hhmNyGn4xv2AbEWP/AmvCq?=
 =?us-ascii?Q?c0PHnjXp11pThGE+UmzpSulsRg1gVtJ7q32H3BLqh1ckAS0qbnPmeZtdpXbZ?=
 =?us-ascii?Q?Ef3aKHhwMTpWsMfHr7JjHT0mnjbPVy5F6KgV0fslsb0Q+cXfV2ArPmjw1y75?=
 =?us-ascii?Q?lLWXFF/DPsAg0q8wCqK4g/NrwEd2uwjOM/svoxPsUBZvgXmNm9ZsW1InECT7?=
 =?us-ascii?Q?cVft0QZeevP5LDRxfja08ZahRbLituKfa5ExpfM37+xEkmWfV8va5XVa7Ikh?=
 =?us-ascii?Q?T2f5wD789W72JqgspHGmD3SAZ9ZqDLYzl8i5ds4ksYtOCUHe/BQuNzvo01Qx?=
 =?us-ascii?Q?0/G2Atw8uSFO3EAB0ZxUjlMMk4jda+l1HUsED3Wkhx5bpncEkXDV+5XfxZsA?=
 =?us-ascii?Q?vLcFcUjFLIJHn6LIoLP+SwfKe4lQ9/vhjnpJzbvZJGTfA2xVMCUoTzYoo5XZ?=
 =?us-ascii?Q?RkTfqS9DNFcmJ1FKuAhL6zqwwiNx9FqT73zqp+QMaMR69UGpbMr/0xYcxknx?=
 =?us-ascii?Q?Kuc6EkLI7NWH0yxaAORA4KeDdyEdaAZPReCqV11d0O3MkNIMRijkRJdeLIVq?=
 =?us-ascii?Q?Nr4jiEewoSZPAYA796A4T+urhhkFBTUQJ/MWZgi5AlWIPUKG5bLaLKNQqTWY?=
 =?us-ascii?Q?NEJFMkyKMwhr2J8MqTZN22s3EpU7EhyNIdgWB6CxhxeR6Q+aDitvl+tSwi85?=
 =?us-ascii?Q?7hUngt3T4Bm8tntPKRTXSt+l8p32+KE/MOdS+J4EJbf2ypZM3la+/i18LNU/?=
 =?us-ascii?Q?aw3vf4LAGr7EI6yxDKS8DZKtD5tHSntjLFykC58DrxSahL+pXZXpPtbSmG8F?=
 =?us-ascii?Q?F1iAYX9/+kswMI2qsIz2AZrCKjI7Af8iciPE2LUE7iqM+2aiJcHG+cXbiAqy?=
 =?us-ascii?Q?g0TUFD6bJI6VajOKKqwX0a4/s2QBTZ3KCFAxw9HccZ0MJh550hIhqrqM9fJV?=
 =?us-ascii?Q?XKrd+0UypboAgYAAmU6UBZ/Qhj6sRIP2l/Lkk3tahM7p8ouedltDRnm3HBvF?=
 =?us-ascii?Q?pu0L2LkXrioaj6oxu3YdUxB24Lc3llkRt90AgOYd+MxB1RvTCMSmMmzSOCuB?=
 =?us-ascii?Q?+he1uq/BrIYT8zpkHnVEuwPnhV8NxI7vCCmHcixzEvQlvHCJdbXcVyYmZDUb?=
 =?us-ascii?Q?JkrNiyb8Bd8miwllRcQfuLJQA94tMMZjM3gMvvpq8dcQ1vOFzz9WLH2JV50k?=
 =?us-ascii?Q?wZQmRvdrjEdE0WGngXGWuWAOajxYB1ZFHtRX6R5qCVexjqnKFhSp9mvdKCSk?=
 =?us-ascii?Q?i0l6g5vWbySK6AjPtk5Ld+lKdbxNV+89CM9aB7kGNyJdVzJPxHAHFbHnh4ij?=
 =?us-ascii?Q?1TD5eurbuR4v337oVdWKbTutx3o/du47emsTfK3qy8GVjPU2qdPgTVGhnsVz?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef6d86e-5313-4651-6881-08dc20df1f26
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 15:29:45.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BShMjQtzNvIjtxDS+n9oiH3Xn+obyyu60u1Ki22MbNlQOdWk3rMJ0PTNHx5K9DK7zH5Eh8P4ETm3b2DLNuOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105

This updates bt_bap_stream_metadata to handle broadcast streams,
by setting stream medatada.
---
 src/shared/bap.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 06cac5bb3..851d6a5fa 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  */
 
@@ -5114,13 +5114,21 @@ unsigned int bt_bap_stream_metadata(struct bt_bap_stream *stream,
 	if (!stream)
 		return 0;
 
-	if (!stream->client) {
-		stream_metadata(stream, metadata, NULL);
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		if (!stream->client) {
+			stream_metadata(stream, metadata, NULL);
+			return 0;
+		}
+		return bap_stream_metadata(stream, BT_ASCS_METADATA,
+				metadata, func,	user_data);
+	case BT_BAP_STREAM_TYPE_BCAST:
+		util_iov_free(stream->meta, 1);
+		stream->meta = util_iov_dup(metadata, 1);
+		return 1;
+	default:
 		return 0;
 	}
-
-	return bap_stream_metadata(stream, BT_ASCS_METADATA, metadata, func,
-								user_data);
 }
 
 unsigned int bt_bap_stream_release(struct bt_bap_stream *stream,
-- 
2.39.2

