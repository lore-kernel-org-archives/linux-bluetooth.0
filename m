Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A913DBBC
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883062; cv=fail; b=l7uUUXc06vWBmAuQ9+RNOELVDzvSa2yuf2bBnO3TLgTTU/kUpW67W1KIMm7rN8mnIdwJNk8G/DJ01+9PUBfgqfZBSmfoazF8KlVrksfDpghXJGzPdgzId3i92iQ/584WL7iuzXN+o5m05MN9npOzMhCaV1+bIMfB5IvxpyXt29A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883062; c=relaxed/simple;
	bh=VY6q9tTnmpK3Xk2Jp1LLqHaOIl9jMA/PrhKiaUkf2dY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VeyykA5A4FkXmvIioLh5QN7Agb/9QGPB24cbC7SAy1IW5GunYLS7sf284tx6ohW7VDYQXIjcWeWM/5zp+ViwqgHmWF3+Y22dwl9Ponbmy1Jv+keMbSBoD+nJZy4bdJ37cgtyVTtrmPsVCUom0i7cD2Zm9hvdLzgDaO7+A4ak7to=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=lKG7HjWn; arc=fail smtp.client-ip=40.107.15.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="lKG7HjWn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZSp7abM+tWNDtytJC5MPaa0BHzv1h0isYEKD5xscVYBHHA6nr7JrpRCc6Yiq2DOn/+1637ysmqKUqlqqVr25dis6mnRYX6Cm9rmacUCLQEA84XK+YQp/ghOv++JkmC1IVRiLLgA56sg62zSmULqEpy1uJWYayErZ8pLSFrx0O6nyrOcTLO+1NjwxloGUFOti3MmdCT7FzKMydnt90yNOgNJx05VZvgEfN9D7NpBvrL7ggGx9U3lrt6nE+SyRm5tfMCW4EDXy126z+EVDz2ry/vuhtiiUWi7avv4W6bW7JrjZ1h/gPXsJH/YjTr176LWAJecF75AM7B/I5YhL3ffqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjpYAqn5x2KCa0IJUTyQe3dhAmPVvUFtmp9yGBlW8nc=;
 b=K54oZQszcD/LgsR5CyK+IDkii/boVcau66LO1Qg9A3QqeJml67FSaN4N6CgeeWumBvxQc1iRhB1LE/EnHDe6HcFJgAIaLo1cNtCFLprEY3QvH7K3klBh5gg/EO2i0nSHEgxMbz9S/DsrQret5NspD95a9TwjGo+2Gz3vIRS8mBYmS/y/RtnqY7wOvsvfk7dI7XoNtno2YeUpB5vDAw94yZg0pq9Fo07K6P3chF073wF34iYlxKNx2ZqLAkg7JajxVNOe6Wb9bu+kvEE8v0XY32MfJmy5vRyBUOWtGTTBuTTpyNIc43AACSp4+IFOGCF9ccLICz9L7jQIe0VaifBTZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjpYAqn5x2KCa0IJUTyQe3dhAmPVvUFtmp9yGBlW8nc=;
 b=lKG7HjWn9yIEAHhl9oIM05tD4/yP5tzB4TVFoaxbfDmnFra8Shl5JWGTV5CTrKGiagUWggn8v91FSKaSAJA7gwaEFMDGoA5cUVOhHQRaVrH39EWuQe581342zJbk6VoLOnLbyhW4AXkHlCx4NsYqEXw0VE79lxi/EcqY/Mvf7M4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7999.eurprd04.prod.outlook.com (2603:10a6:102:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:10:58 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 14:10:58 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/3] bap: Remove incorrect assignment of listen io
Date: Fri,  2 Feb 2024 16:10:36 +0200
Message-Id: <20240202141036.9797-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202141036.9797-1-iulia.tanasescu@nxp.com>
References: <20240202141036.9797-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR08CA0015.eurprd08.prod.outlook.com
 (2603:10a6:803:104::28) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 960fe505-2d7d-40b4-5547-08dc23f8c70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ni7cg4spcONK07XM3ByVincJ8Ovf6FkCU3rwFNq8k543dLj5LEyOHhHuOchcOTt7C6th7viyaH52indxBnIZnZCkT1qh4WN31Qu9YCn0u/FEz7mr4tpYldCP31bVn1UimB5b/V2zoqjh2Vg5FpdgvdHccnb0L9V3M0DZM8866rMpBuRlrkGICDhjn3+E7wbb0kOSXD5OOmo/J/FiRPGYRTi3KB67qgOSDHjYcY9BYEbrO800guy/SWoCch//cNK2vQcKmdL4OZ4y7QG0JG4QWnZbp4Y5pxU2jqKH2c6BCdvfiLbWxXewSiszu/oylXlaLsDFr4ySRNtLL8E0J9o/qbl/9WUFYOYyarsbvtDAp+f2Tisro7oSPpfgp6adtLSNGRvjUx9E6krCtTJemzjXVFU9VpCJQLeJ6nuYa5pZ2uZVsoFmRTnAtGeigfq8JglLZsNZX68+lBun2PxoWsT3EY/RqsV1q72SSBK7/yjT7s/pU7psQqCd4amGIO3mp71sgCKyARVR0Jh9nKj0wTRUVhGM8OfvI14o0J0oilMxOhq7RT+BFqgI5uSZOiHqb6BpDPa7eAs+jHPcKidtDJV1bhdAhPVb+ZL9w9Q96z+hMB8zbVNdrOE5LaIklNQ5RMTg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(1076003)(2616005)(6512007)(26005)(38100700002)(44832011)(5660300002)(4744005)(4326008)(8936002)(8676002)(66556008)(2906002)(478600001)(6506007)(6486002)(6666004)(66476007)(6916009)(316002)(66946007)(2013699003)(86362001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MFDNhlpCt1TN9y53IwYw63RDFpXsQli/ibKTaQsmrVjNVMciKpDIyiBi6SlP?=
 =?us-ascii?Q?wFFy8IpZ5e9eSIfvG6DKPFquDlxqJeimjr9O+nfvjThTnuoSpxMKRxy2yQcR?=
 =?us-ascii?Q?iIbIhlh0FPONx/564y8Xg7sj94hPca/3ro6qkWkey82ZZa8jlXRzV/0gYU0U?=
 =?us-ascii?Q?g24RBjhaNIBzOm9t4HWmt441jNxNYsAlcMvKXssnFoBNkPbD8j3kRd0MHrJG?=
 =?us-ascii?Q?/hYx8qRn+MxNbMfpVy/oq5sQp2/moqCL348bjyfcy6FFJ+6rdhZVHiQPGg3s?=
 =?us-ascii?Q?KA4ElK0OnY+045ClzLm8uvkBr6d+c3AASISoc40dUMZ0puRoJwzaJmLVuT8E?=
 =?us-ascii?Q?t3Sa9LG6kkwMU0f7SGeuJyP6vgD1ePMIYFHDB52+R0QWevmnbA6j7ytGrSb5?=
 =?us-ascii?Q?IaD1RYapq+jv/sSj8rrMnMzOOPQ09Ewiu8NekZ8XzY4/ZIWiLO/KddcVT27o?=
 =?us-ascii?Q?x+ISFxFTCehbCKAjXXcxEAGQBWvfbb06fAYBa0gdj2sf1wlv1vIDr6sd9VyH?=
 =?us-ascii?Q?5PeJyn9UvTj8Ld9C5rC6L0gOTbyNavO2q9MapV3BvXqJXatJuduZvSoDWOC9?=
 =?us-ascii?Q?Pf7LKSjCsScV6sVJiuj3GAyT31f4wpUpv6s6tisNPsuU6mHv6hCyCqV+Oicp?=
 =?us-ascii?Q?SzvymWclBd8X3/wCLZILLvRqR1qVLvzcP8a9FUr9IyCurf5mUT823CWzIopA?=
 =?us-ascii?Q?GPAkZ6anxk+eJKWapuY5v3OOFq3ZdoVsgzXNv2YnN1kPTNnbiPjHLNmQaCTU?=
 =?us-ascii?Q?a/2NR0DjAi3UlHUQmBqfTKsYjKzdJUQMsZ4Fvc6H/TyIjf6dOGbqkmhNx0Ul?=
 =?us-ascii?Q?n55ZBy2ufQLn3PrqJltpnb3kz762WpOWTTrmM7aqWZkVxPcXYgYBvIl+eVEz?=
 =?us-ascii?Q?h+6+B5mXlNDtFvp/RBIs5lvUUIPiXgHiWbvVYxK7rkIZps+Q32MLkbyTglCU?=
 =?us-ascii?Q?sUFO7TMdEhZiM3PqmPUbBkhrjTvGfow2pyTpdCRA+ky4+Tvn1RgsMe4oE7Iz?=
 =?us-ascii?Q?9iMhHPw52ETmn6ac0mrcEX/jzooV78NAT4rhZOtXIrUzehxG4AwPjiBH38j7?=
 =?us-ascii?Q?TXqzFYOxW6/iRcwqHdHn0DoqC0Pz8FqxqDesHuN6uYUbwc5bzNHFaNjQmWqJ?=
 =?us-ascii?Q?I942AtNUWiG+7tXjRjxAdhRoyjKV0IbXE7QD8epOu7FiyXufE21rMy8mLgYL?=
 =?us-ascii?Q?ZQnv89vctnuD/DN2C6/tOTJXZHy9nSQy2Oo8Afo3NkwlXOGK52ePSoSy/08r?=
 =?us-ascii?Q?ZL2PnKIuXYMOE5aC3HUdfkSPCZZRZY/9utTT3rxN/ozM3ing7I2LUaSSOdOQ?=
 =?us-ascii?Q?Z7goA8uc9EqjvSxYNVoOO32AJ2/8iUN8PyMvSLrC/sCZX7qL7VN+JKuJBxio?=
 =?us-ascii?Q?SH5hx5XCEqpklASVKXNuwYd4p743uyV5haheYIhudHv8mk8idQRktvBl9TLm?=
 =?us-ascii?Q?8nsuPHMn97yBkiqwnyfAxde33pCYiYC+faVxT/6ht7KjM4N/VJgzwDWSqd3+?=
 =?us-ascii?Q?NcRFRv+g4OlWaEPVYKMw6TIYkcS4cwOkqZqd1Uw7cW+xz/CE65W/2aEvinIH?=
 =?us-ascii?Q?63MIYeg+R3AgirJXUJLBYV9usDmgqj4ecJmvhjSO8bHT6ZedHvUtuFtfT4MG?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 960fe505-2d7d-40b4-5547-08dc23f8c70a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:10:57.9489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: an0MpyOL+nC9/G64I2T34X2tR6nsQa9DdNCbSllt6LzDscm4C/smQriJfw+TVqPuCniDARNs7sIeCcZyD+Dpzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7999

For a broadacst sink, the io that is notified in iso_bcast_confirm_cb
is the stream io, so the listen io should not be updated.
---
 profiles/audio/bap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 909d57121..94c1de1c6 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1061,7 +1061,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 					setup->metadata);
 	setup->id = bt_bap_stream_config(setup->stream, &setup->qos,
 					setup->caps, NULL, NULL);
-	data->listen_io = io;
 
 	bt_bap_stream_set_user_data(setup->stream, ep->path);
 
-- 
2.39.2

