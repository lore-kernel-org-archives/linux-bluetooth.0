Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B0777640
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g8EmL2ri"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3czWP6vk8dI6+8KzLaOASHTQ3HqedPpisAnU4vvUcIqy/oVX9oLKlm43Y5sNSVcOScH8cdXDnNWtDks9b5OOMEY9UhmWmf5pieU6yR7PnFFJdn05ibNlqXur74VtuOnWlDh2GZXtBBfcZD3rO/4urj8dIcGNYMZrcLxEvkhlw9LIN4H2rNKpqJfrFuP6Ls8o1m58cednG43n4Gbz2ZR4GNW4FRn8x8gMf09YhUPY6/E0YcvLMbGPCAA583V0T1LnIG1eHQYvmWmekxRqICdzOibKLQgLazvFH8nfez+bLfQqXXqQW+JK+9EFcDAbJ68oBYxkOWKwS76RHleV47PjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9mLdza9I043NFFb16vpYc6i4jtGNXOthQWOqgBRgKQ=;
 b=FrNsq9WbrmKddj27GaZVzLxLjho7raJxlwrOj06onNl/7u0alXkzPhJIkMxYy+vbCe4AtQL1XXrU0LVZiy0lXdihuDO+aWV+gD9OzgoKjaNCk24PVbXJIWq60vACEaENsfV7WsGDUcwQGVu/+MRjt1fpU6aeAo6bUaUVG2xmMBjw+1dnxIQikO6mCH6Us1+Ng0jqbN7dTZm7nj7fXgXavgqZK946anmnWmUTmFgdtvC88tXeHgSpjmu74pvDZK0xdkASEXTlaRKFbp3RepdMZ75NSDnpJ9osLRK5nIH9uB2GStLwF5pC3k5hCiB0Nuk2tcJJj3iFTsoG+0uZz4kjPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9mLdza9I043NFFb16vpYc6i4jtGNXOthQWOqgBRgKQ=;
 b=g8EmL2riRkueU903rkhc1JSwlp2+X+Kh+4PC+UYS3TRjS99LdKflnT864ymO9JavYgkOZa/IZii9CJl4bylUH8f3zUaMTF0MhVCV9YcAifbl81y22jGpBZk/Op0oiEH7KHRbGmRyYrHbNnk0yXuRnqAWim7UN+2FThtIbNEvXFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 16:56:08 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 16:56:08 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 1/2] shared/bap: Fix dereference of null pointer
Date: Fri, 12 Jan 2024 18:56:00 +0200
Message-Id: <20240112165601.134073-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240112165601.134073-1-silviu.barbulescu@nxp.com>
References: <20240112165601.134073-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 5177225f-d8e6-4409-226e-08dc138f5f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tlVftGLU6SOxTJr/f72u1hIjXKFQ8NyUJKtzIAbL6viVwjtH0aLY+4d39jtVp6QJ0lXC9pvIf3uZzaTzSKvJqYNgN4i+eHLkVPdRPOlZsmOtnMsqtKPQQgN6VPwcYYh7CYCYm0HNy9KPj4a9ZMWNGrVcoTbTPyoWuBW0H2o9KNZp/4FRwKV2FWXT9FgX+cueyzo4qJPQS2gorF5ReRKxEJ4FidAN8mTIa43krxVgrKFETEr2VZVXrsJ4rfLXsFRuIjEQgeLBNDm/QskfQZvz+DEquNT/fbIeubmoUDS+mcOBnkh7pZ+1aojtxRKbTukD1und111L9Z7b+10BIraCnPegqSFya+KwHuG2OT6GhLDqDIizJLW0Ju+lRulrSLGzLg9Ie8yeSaxwN1OK/Yr2Ion/Bm1+5ZWi5a6hxU+pNRMyczJptbtLBX7QO0sSiV3BLObbWSwABjIolRo79Pdfau5u8n1Br51K9X8ziVqApVKXqeWwGogahbEhPxAMngcuFavcJo7SqRyvfH4+Uvtr5llxmBBa+xlUozO8sAgV7qwgOX/ih2fFUvVNGDh6f3nl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6916009)(316002)(66476007)(66556008)(66946007)(2616005)(1076003)(26005)(6486002)(478600001)(6666004)(6506007)(6512007)(41300700001)(5660300002)(2906002)(4744005)(38100700002)(8936002)(8676002)(4326008)(86362001)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VVWfVG6qsE+AhaZlY+aAWo0Z39rHksCUfYyDauSXlzwcww6keto723hZn3r8?=
 =?us-ascii?Q?Au9Y+KD6WqIhfc2amRZW8Ga21sw4P91dmDn26PAtsyoiI/YaLv7qffmsZxi2?=
 =?us-ascii?Q?oJXJkrKwrVJ9neAuO+yi+6wE0X8hY2a0hDoLfNGutlPoIruCsah+Wn2M6euj?=
 =?us-ascii?Q?L9cvnINxhm2LbGNNmiFbsyrmYuWMQkmq9VyU4xakcIwVz6RRooVdgtLrYXkO?=
 =?us-ascii?Q?4lrCun0SZaI+ta7jzjiROa9fex6YySxSH/K0a90Ty9ehDFjPogwGBwPBwxWN?=
 =?us-ascii?Q?bkhTxezjrkqlZq/IaRUXAeRP4fUd3WScXbYhdYJCYd7CgS75lFpL6bg48Nai?=
 =?us-ascii?Q?c+9ARH74CMLdVSy3oAvOudSj3GRi0NRQpwKfOg9o+X00LZ7cjzpJsC0Zjwyd?=
 =?us-ascii?Q?qYATPNnq0ZpZsH1ky+VILUdxvEqejzBIABizTUvelhmM1ZuHULRP6rAzv2xE?=
 =?us-ascii?Q?JrrhHcGNQ46q5Woda0gD7bKuWGwGPfkCoCzwhO0pylO6R1FpJOBur/OMaGbb?=
 =?us-ascii?Q?K0mRKx24cWLbDBZTCWymvsf+FBfZeUkaIytb9gpSNHybNN6bPmzDpUflbdjY?=
 =?us-ascii?Q?7J1mGQ3ABtx3SK9x+BFBYyVbZbxyqDiOIz9bnFmji5gurU++2yIijQQcwl2b?=
 =?us-ascii?Q?DY6oVSw0MDrqCBGG/KfwckwM4nD3pXJsk4+7FfcT2d0aD8eaAhAcNbv5LO3b?=
 =?us-ascii?Q?bKO4HwPEew6Li5vKFs4w7e9nzj4kJTKCSDOz0UcZS6iPZTesAkch2sCeB4Dy?=
 =?us-ascii?Q?zpQrv7g+G+JbWwT7gx236y88VVQOjSzDGEkS4KL/c9f41AypOVf+mdFUnIdd?=
 =?us-ascii?Q?UZa86H6lmcNfZ3qxKppUBmBBtms9VSoOsZXWpRZAPSW79WsaqdgnOE3IWRPV?=
 =?us-ascii?Q?G9KUl2lj/nUA4xX5RTkGZ6cx6V4sQ/BgOUe0rRfCGeicRIfk7WVXg+ov2/Ud?=
 =?us-ascii?Q?HUhGrl2zIbTuzH70BLSDKUun1V06Y1012Alcc64YJAWcRbT6+zMXePgt89S0?=
 =?us-ascii?Q?Qv6vD7RL6RU5bI1nppkcESgJ/spKYN0OPqCeqCTdYMBya9TcTzReezj03vxW?=
 =?us-ascii?Q?+ioOwvhLWdt6CO3lRXBog3ro2qUND6QxbwKQVofghcfnWTx8KH7CiGwGZ6GC?=
 =?us-ascii?Q?/hnFyKVl67/BMzlPGAlssQGScli1NewpwrIB1zflvGOccYNg3RvBRgClsarj?=
 =?us-ascii?Q?i/Pl7Zf31ygFC1DydtjFk+Up1GoT69J9jFqT5uBnaZwzTA98idzcoDR04mm0?=
 =?us-ascii?Q?IPyn16lYLa4p/2D7BTccLUzN4eciklcloQl6Fbc9JYYZNJqoTe2614B1snOR?=
 =?us-ascii?Q?IzVTy8wvi/c24cXWAgVHhpq+1yTRQb/JFDLABlzeTbaQ8AYW9EPEboRO+cIp?=
 =?us-ascii?Q?3G4kcqoXO0haU/BSwaIhOraJbR7rZc1YL6qE/Rc2ZyRNK73uohjK7MOz+iqQ?=
 =?us-ascii?Q?+Pn0MBwbzfQsOqFd4KdJStd/nDr8YouLuNTzAtbU1QS5OU8pd+7C/Xi13aWy?=
 =?us-ascii?Q?5Y5Q1Uq7IX8WK2NXJ/fcOpL71R4MJA4v22LPhxepxwXZc77UK/VMD+WpBsk4?=
 =?us-ascii?Q?zinB1O3WQrMK/13rs68S7Sz6cvI3/YXkpfjO8OZGzxtI5xM/IHeq46D1hRK9?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5177225f-d8e6-4409-226e-08dc138f5f39
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 16:56:07.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hz5pCgpiM3mglvQEt3z1+YXL81Nue8hf81TqaP2w2WossLnU9umwjaG4OUsAb6OX4RXkqJE8vGq5kp/o8SGIv6M//J2dSNMvr7XxkPHgL6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

Fix ScanBuild error: Dereference of null pointer
src/shared/bap.c	bt_bap_stream_new

---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 078d308dc..49eb8d057 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4763,7 +4763,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 			return NULL;
 
 		bt_bap_foreach_pac(bap, type, match_pac, &match);
-		if (!match.lpac)
+		if ((!match.lpac) || (!lpac))
 			return NULL;
 		if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
 			return NULL;
-- 
2.39.2

