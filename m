Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56981252917
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Mar 2025 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742380705; cv=fail; b=oyHi1WxEUzXaVcPI6FT9V4kj+vQZqHshHt+pt8qROLyV4QQVN4F/MQh1H8NmERMmlDReHoABNtWIjQcxKEGJ26D5ETIstOUosq3HXUnWD0fmFU+wcDm0jP+fnm32koZsc7kDFlzVm1jfgR7V6R75x3RY9ZVgqK/xOc1i6w8hOwA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742380705; c=relaxed/simple;
	bh=8MelgsIpBp6vrurh4e5j0J3wNBHadpz/kKh7HB60iO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0DpKHoB+rAjjnbz8HS71Kh1AuMgvKlJGgLISXp3tM/SBNCOevUHKd4vk9OIWuxAzw+1TeE272AbIx7IhCzzUlJ398lJVgtHEOBzufPjlhNYmNUW7Rk6h6Pkc8HzXOMJPvmnTm+TpHtaACYeKEGilTVqmZg65Ld7GpLezIGzGyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=Y0k6YGJB; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="Y0k6YGJB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieMcmjKiN1aWeES7Jk11ToVuDhLrrQG0x2LbYSArks7Grda1KsjALpi3o0Hv6T6q2LW7ioogTZKzGPYFG41XIdMHOjeBy5OragWrsIHRFqENXuRzNl3vVm91TS1RZ/gtY6UTWZc3f1QK33zG/nmJ+mSCS0f38eB62jpB3htU9eG2St18UZCeG8OpYnXRZX1sR4zf+9sdYz05QPWLpLniSUN5MYwc/QrkN5Q3cQ9p+pf9ZAYpiiacN7eRQ2oCV9B6JlRM/02wyf2Prn61J9rf0ize6LwIHx7HJumS35qE/q5aUtolOlMKy2uulSt8MdX5FbDQWoghAEi6ItMNJCTMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJj+ASvSVcu38ttaF0tMW3O6dU5kISX65qo6MO8l1Es=;
 b=ddLvWN7cZ4H1RcYTwTsThFErr/YPF3UC0Ws79E7/k9n5+9ktQO3o93JTMsenEZwltuVuJEdJoLUGhvxPq/IiTfNhb/coi71nQyAdISOfm3XNTXOasPNu8rvi071qeOSDEeiCOM85daOtbEIuxTf5xglu8EpDrCSKGtCKEz5BkVOWg48Mv8gBEmbcnRVTn9ppv9TNb5mJiCWaYNN5zc7KhuhrLV2FmooXJzYN0tn/tUblU6v5SQ0iVd4Rmo6/IftQgSGXOSFMR9j6GsIoIwpsK/AxvL1lxFE5Q3Je8iFKhXVzwO+Te33jWulxvLsQJOiGp4vI0stjZVP9bA/KAnYa8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJj+ASvSVcu38ttaF0tMW3O6dU5kISX65qo6MO8l1Es=;
 b=Y0k6YGJBLULb5d+rjxK0EIzBf5soWzsBQKolnLUDyXsejCCg7lZtGpmukFHus1VFHF9DewIOMndDQo//f7YwchkTOdBM+Lo/teJ08rthVTPF8eHOdRIuqdd/K2u4uoLTfiK5G5f7hdtWp/6qSBwuDp6ccH3zN+dvFjnT3YgZTgQ=
Received: from CWLP123CA0083.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:5b::23)
 by AS8PR03MB7399.eurprd03.prod.outlook.com (2603:10a6:20b:2e2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:38:18 +0000
Received: from AMS0EPF00000192.eurprd05.prod.outlook.com
 (2603:10a6:401:5b:cafe::6a) by CWLP123CA0083.outlook.office365.com
 (2603:10a6:401:5b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Wed,
 19 Mar 2025 10:38:17 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF00000192.mail.protection.outlook.com (10.167.16.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 10:38:17 +0000
Received: from N9W6SW14.arri.de (10.30.5.20) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Wed, 19 Mar
 2025 11:38:16 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 4/5] client/player: fix printf format mismatch
Date: Wed, 19 Mar 2025 11:37:23 +0100
Message-ID: <20250319103724.10433-4-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319103724.10433-1-ceggers@arri.de>
References: <20250319103724.10433-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF00000192:EE_|AS8PR03MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: abde979d-ae85-4b16-63ac-08dd66d2290a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OrY8y+zK+Wdq7qS4oEKrDQiZ/bh83PqmCVekoSRu99yyMekbOhNK4IZQeVg5?=
 =?us-ascii?Q?DTyySBDMZft9c9OQyETWZSTnDp9tYE37CXN3xy1djCEFwQyEH0haK6y90WP0?=
 =?us-ascii?Q?xvKxl50G6S8sxMVLxWVwksXrs6B5LDOdbBIhAQ8SWs05Ce0Z7jHe34b9oqFF?=
 =?us-ascii?Q?ywmb93xveUrEXzMm7NWjTmfySF32x3LCozTLAlvBvaAHejJG81vkTyr+S42r?=
 =?us-ascii?Q?GOlcnee3Fj6454BTm0JxyudVeK+FPjTiLvk0J8ynQd/PJHvQqU5RvpRB3ZLd?=
 =?us-ascii?Q?pPAdcdlcFHVxhrstHan8R005tGZyDTNVpaEjoOrk0k/mfxGnDQ9I4fcdHGTU?=
 =?us-ascii?Q?64hDoQ0/qdYBskf3MBXV0QRRj+mkvQF/zJOIVKQyGBBLHAq7NJw+nmHiQJG0?=
 =?us-ascii?Q?6tSsQczKlj9e9aUsCjpFtOY3Ip2M8lpLMeBY4NVrxs3/NFJZ64xOWKRmbFMT?=
 =?us-ascii?Q?uwLl8EG78rQ1K0+fAz6UrAi9avx/WNmSD7GZmfrqEgANoEtxWrI0um0uytDw?=
 =?us-ascii?Q?vbD4jtlo/CI5b8sURxy7fYJygq1aMBFen1MhFNcux4BdiTFOK1XomPQTOE+x?=
 =?us-ascii?Q?XyKcC1XBquYvq0oIN/kwILC8jLW2GzAYZfoDFB2OSw0JoaDR6GTsbZtvS25o?=
 =?us-ascii?Q?PH72LkgMdAsFG9vwkT/bd50lwhLVbgGYTFFwUFqkDg2n0mECT5+/d1BtNCyu?=
 =?us-ascii?Q?NGpUpXEsAeXQNGlHjq9oWXRiv3g7qoCwLF755U8sT0SKC9fdn7sF+VLYo+YI?=
 =?us-ascii?Q?UkenXqZ1vgNpetUOeUc1DC9v19CQqxJcRcmCpg/4ARMPFzB3XdqyerJevBn7?=
 =?us-ascii?Q?kCJbAza6jENwlTH7G7OgSYyHVPC+4BBqA+3VDuCYLgmcbCutqo3pgwtGMz7H?=
 =?us-ascii?Q?73Ey5MZwsvd1p3c3ZH+BmOJda3E8/xEzF4MKfwyNW66L1qNpvx+ZBqoNpyZD?=
 =?us-ascii?Q?SWkJzdYJt+qGYyAad9nqkKAGWRPCqnMgApk9KLHUllEul4/Fah0++cvQ0DeT?=
 =?us-ascii?Q?kg+jqYM7/AAc8+YuwiKv0koHB4/fx8V6vy0P/eCZxTS2K8BP7dDEz5skgtJ7?=
 =?us-ascii?Q?WATkf2+G/LCrbq+7/W/MCih9QPbh9UhX9BBcvpw/BrdYJSZjT46pOBRPHXJ+?=
 =?us-ascii?Q?vIXt6L8R05W7Suuta4LW/X6f+xBAupol3sAyyuYmmypVkkjU2YuEv0CsEItv?=
 =?us-ascii?Q?ZC1P9cz+QSge6LYQfxYG6/0YvFVSD5RQ4Gi22Nktvix4maXicKo+URv3qncT?=
 =?us-ascii?Q?StTVomXpf7uHI2dbjN15wUDBV1uwIL6DZFdk4L5kSv1/0t/FsZW8VDjEp3zg?=
 =?us-ascii?Q?VuO67eKaJYHZ9UcymyJLO+ciP6uirBbEFOnoltlDgxrPXA+gg7nXm1pcd+5f?=
 =?us-ascii?Q?nxk4diFLAdVJg1oOjfNnQevv3g4I9qvyfmWPz+Gbm1qfJNL4S4HwfA+JbgIn?=
 =?us-ascii?Q?jBmnFNd+qzF2lOMIIQrtYFndbMw8HhlWMnLqN1qkMUa9bKAB5t134D8vSGGI?=
 =?us-ascii?Q?qV5yQ3NGd3pQTPY=3D?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:38:17.3877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abde979d-ae85-4b16-63ac-08dd66d2290a
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000192.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7399

%zd is meant for 'size_t' rather than 'off_t'. As there is no printf
length modifier for 'off_t', cast to a standard type which should be
large enough for on all platforms.
---
 client/player.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/client/player.c b/client/player.c
index 76fee0a0597d..acb709924d96 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5551,10 +5551,11 @@ static int transport_send_seq(struct transport *transport, int fd, uint32_t num)
 
 		offset = lseek(fd, 0, SEEK_CUR);
 
-		bt_shell_echo("[seq %d %d.%03ds] send: %zd/%zd bytes",
+		bt_shell_echo("[seq %d %d.%03ds] send: %lld/%lld bytes",
 				transport->seq, secs,
 				(nsecs + 500000) / 1000000,
-				offset, transport->stat.st_size);
+				(long long int)offset,
+				(long long int)transport->stat.st_size);
 	}
 
 	free(buf);
-- 
2.43.0

