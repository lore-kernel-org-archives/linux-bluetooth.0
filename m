Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2045.outbound.protection.outlook.com [40.107.14.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07498615A
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647803; cv=fail; b=NuJGUr7YFeioaGZOLpyX+6k1d/nNg26iChzC1ZdLk9m2Qjq6jDFhv0UyALzfNbnQCGKLz0R3gnb5KQBw01VKYukQOvnnWR5pwWj2TQJkLRgQl8erVW98FLSPlXEbnaO+lePfYvtPJay6Dtij0X3S3w4JlorKn87UMK8bOtdMllA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647803; c=relaxed/simple;
	bh=Osbkb4J5a2F/Itw961geTUe1UJz7jXx23nodXqCf1f4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sQR3Zt+Z3qKMGkb26Vc79PzT75kXchJmOnR+DZYZYAT56lLdg3s5S0lC6k4RmpqXkPZG84HmSbqywH3Z8/RPDW9HFyNWvePHxF4VNge53s1CiL6IlMRNnVRutfwkacV/PYNBvj+TlXHts8Rw5bYKDPKBrugquNaD8NexQl8Qoag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VkdHVsVk; arc=fail smtp.client-ip=40.107.14.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VkdHVsVk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUMBfGHmjnvHg6ISOztQwaYOAtI60o/0cvGJzowj5YryS0hZx8lbsuuhopy42K/qNpQZLGKobgRxDBIopNpVYNfgbnTJlAJZF403b6Fw5+tmee54CHJoaGpSyBkCwRY7R7OSyjWMq7r0fMTxXVUHGe+CSgYVOyfC7iEwrs7SnTTerRwLRPlL0OoTxtwuXULGkzLoiumPDogfgP5OFq0m5G4+vG5P7FKxMwFDJwOXxtoXgP4iRhO1I7M127H+SYOhIXIp64uGKOG9niSLOdvZ+qjYITCR60LfSVtmI2mRPoOJldEnguKJ/LHGjX5ZwvdFFC7/8C8/PB5Qln3UYVrEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0GN0fRcsVWbK1vYE7QfVnMywL7fnp/cyBYtO/qISJdY=;
 b=fR3UW0wcqdDlN4snZaR+HFHIYQwk9+iZrAccAgHAGvCtcHkJ8r/O366Mo1DYyxM+WOE6UQNOwHXLpOG0wap6F91gYsJRmexY+EKkBKgJ4T7HUtGblGGU5spQxOxB8DAAKh+69Blk3R98wZpguWQbpY56/mqsV+m1uFZZejHR3Gg5EHLfpxapxHMt0wGk/n3IbNHIl+N6Mam7W3hqHpDWxuad9oimrj06LLIfYLTBa/gv+thcwAD8DtbM1XIzDPfj5A+BB84W56kETqV/CMZvpazegE32K3MvRsk0PuLy0swqPaGFQICkr7MAbkOCQZB0N/B5ZygM2ZJr5wC9qdRRAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0GN0fRcsVWbK1vYE7QfVnMywL7fnp/cyBYtO/qISJdY=;
 b=VkdHVsVkDnSGUksUCUFg3eaCWF1W7kyiA7t3tyUJmq48/8wIR9lN9ez3J62il/zVYArrpgfkr+yGi9NKjrhTg3xPIHStmwIyX02XS0agMaFZpdvyHDXSdTD++iPTE6jrSlCx+ZIsjDw2XxxsBmTGYagmcMi8mT7phCg5I358gw4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 14:09:59 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 14:09:59 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 1/2] Bluetooth: ISO: Fix circular locking dependency warning
Date: Tue,  5 Mar 2024 16:09:38 +0200
Message-Id: <20240305140939.5090-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305140939.5090-1-iulia.tanasescu@nxp.com>
References: <20240305140939.5090-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0178.eurprd09.prod.outlook.com
 (2603:10a6:800:120::32) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be93763-ae7d-4499-a1ef-08dc3d1df167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ctNS2xgmS8hRMNBTdAIyiJGRnI/TdlUfaVruyfWPsN0ou1RwPf3Ouk7HS9b2Wfqzp1YikDreJ3GcMhiYvmrJ2x5MlGKKvfOb39xED1VtyjlKUMJUyjeV6YwJwU42gD02PzfaDPW55W6D/iQvAVqz1HABsDnmJGpTkA6REevl/YFmqrkMYWXRpkOZHhn3pq/1coOZcMYJ0b84nydLM7MXWSMGimyZ8RWhgX2trWh/HqjtkDjbKnF4HloxkLpV3BSvnW5Rw8kyAfAZfXhKfJzldqcqODmVKrP+CrsMBrvSwdZzdmu5Bm6rFru+NpKtqk/dGUR+NkgDwfT3RXqLk3uXeh7X/SSrsTbDzGAZ724bcYsHTHA7q3A8zdhGtbUNIa7qARe5MEjmVtVC40e5a3OjoP8tx21AUHTMBqkwOSzcNl3U3/B9CNiRe1LF5pVUqFLVaDbmnyXiEnYzuNTpMvLV/puer2u/Z4lpcYMP+ZoT90YCHXQYk8HfitvoQHxCcaoboRWJHWlLcd2dBj3zOCeMlgRTFFMzzkSnq5dX0bd+KdF5tfKj49h1J7UIOedSiXZ00FvsYoiykZXnkLRXq6Jqc6D/34IqndY5wRHHS7ebdFfTo0axUMSW9ilPFGmyr/EikpUgx2tFBdYFY3XR6ZcMph6W1FiiPk8gDaZ4tLz++SI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Vxj+YELIMTbZfycRQ9iIJUCmQhjMhhsCafh/Mywnv+IEjDh4ZAxjgM5I9vTN?=
 =?us-ascii?Q?aVgcWkd6wneyR9QNqzQcMOdjT5twhG0iPsXVu4/NFef6PxtzUH+JAZVup2S3?=
 =?us-ascii?Q?/kzaozNgv5YQGvQqUsvpdCvqVd8EKpvL0A9ivpW08hEiaYBd8CXmWW/a6Zus?=
 =?us-ascii?Q?iGU/C4iVXSw6X4FM4vnHipaLsuZipYyy6NiszkA5EQIFQOeU70yrMEPEX0QZ?=
 =?us-ascii?Q?ALU0lPbpfRntxP5kpWTjkzEzOzICq0I7AAbkFGPS22z7hjB0e99Y7mAcQuS3?=
 =?us-ascii?Q?D+kpqSXkK/O7aCo8g1OqM9ziwTKpI+xUcUaYXsvUWH9aEtd3rJT7HuHjMxoE?=
 =?us-ascii?Q?eEk59ZtwoZI9qxodqzMqBWhso5AJ1ULS3c9n7MaRDKreYxZ/eSGkwFb9FtP2?=
 =?us-ascii?Q?Z9zVV8PIpa7L0jfBFz1to0nwr9EGWRP+lZbXnnsC7MzFYQv51SH3TYIGIWmx?=
 =?us-ascii?Q?hksFsTS88uZ8lILfaKpaLrs5h3ForjDExWkArvdp+mdNi/lltvMh5OlA6GZM?=
 =?us-ascii?Q?ZH6AEDKWbUH/q4Yk1MoeId2ul0O3WWQzoUvU0wtfQvZSmG7iPgvje3Nl2lB+?=
 =?us-ascii?Q?VV6MtjPJlhMuGOX5L78jE9N5lIMLsUwV3B455tLhQfjZSDvf3doeexcxGCrH?=
 =?us-ascii?Q?HnrcuRxdZTsU0hvTbQNGVd0TP9Ro+4/2WrgTVKxfuBaLa9d1jy/hoQbq7Jek?=
 =?us-ascii?Q?UtgrzuT09kvn3HuDKP+Qfj0hWfRrR9pA0rLPRwq1FdsganAlxzyRtg85A/LL?=
 =?us-ascii?Q?k2Bp3PxqOjZauyjT6Mu7H8OzEqp7+VgOMhTAK4xlLnMhfSGlEtpHQuc3A6CN?=
 =?us-ascii?Q?6rQY7QWEdLOOfbODruBOFWxsRNdsSG/O6/M6dC8K3hnPZqy2TlC4AlZmT4su?=
 =?us-ascii?Q?5Q3PYxnz1ijB8iZrkgJfTlvxf7fC1zjDrAHM2Vu1BHg43F9enJA8eokY1eDK?=
 =?us-ascii?Q?uptMtHeN15BgWVk7T6RGZ5XbWuVY4EdEqcdb0XohMu4wMmT7x30kEr7fQsuK?=
 =?us-ascii?Q?zuev14PykQr7vEIDx+39niF3DelCqqSe8F8iUsrHh9IkVXLTfgHMrWYJ/hLS?=
 =?us-ascii?Q?JkB3ay7hV+RDDjrz0Qv+YgFilieo4tjBaBFSpTkkD86G8XWh/KEQNXnVEbnV?=
 =?us-ascii?Q?FVILXed7C5iu7WdN8ptq0BYgmra0uNuU3b7NgkQVsGNtLaYzyFVjnNPlZLbi?=
 =?us-ascii?Q?kEHsfU6ImwQB4K11cmkt8r+LSMicGQeMmicpzOOHt/cy1pzaQNkrkE/KhR7j?=
 =?us-ascii?Q?XwJyf2yxBhJqv1RRWmYDHsw+Rcy3YqFCQuSWMmAEaKfsewoHcybfCGCEeEjR?=
 =?us-ascii?Q?znVoI6xDFohpDJ20smEsOW2DZbqC4oweJES66Lu7N7TBcCxjrrBc2iyCn3q7?=
 =?us-ascii?Q?ifXlVeKchdVBTWoTVSghI5NVXCLgc3SWgQHVTKS/24R81IFKQE6xvBotw/q1?=
 =?us-ascii?Q?YK7B82nfQiFwekLpRijaIShtDJ9aAHekhag3lMCcLZR7L4ho3bMr5p4qRBR+?=
 =?us-ascii?Q?LNuPCX4THgLKUNYFD8qmX+KOTo1r4kcMhQzOeNBGQ3+itVoiZenEMtQF1DmV?=
 =?us-ascii?Q?R5xk+A7tVFD3W1xCXQCNIZzfGBjbmti5F8mLXHiL1MzZ6YdK444xMFUtCqo+?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be93763-ae7d-4499-a1ef-08dc3d1df167
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:09:59.4527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+hJDpYGdGXjwVqG54lIfGsoNpawWJEYmgIREWfeZaEa2o5XvnFWUN5pXXuQdLBce2eWmBKVfmCBjrxF15O1uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9366

This fixes the circular locking dependency warning caused
by iso_listen_bis acquiring the hdev lock while the socket
has been locked in the caller function.

======================================================
WARNING: possible circular locking dependency detected
6.8.0-rc5+ #1 Not tainted
------------------------------------------------------
iso-tester/2950 is trying to acquire lock:
ffff88817a048080 (&hdev->lock){+.+.}-{3:3}, at: iso_sock_listen+0x305/0x8d0

               but task is already holding lock:
ffff888197c39278 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0},
               at: iso_sock_listen+0x91/0x8d0

               which lock already depends on the new lock.

               the existing dependency chain (in reverse order) is:

 -> #1 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0}:
        lock_sock_nested+0x3b/0xb0
        iso_connect_cis+0x185/0x540
        iso_sock_connect+0x445/0x7e0
        __sys_connect_file+0xd5/0x100
        __sys_connect+0x11e/0x150
        __x64_sys_connect+0x42/0x60
        do_syscall_64+0x8d/0x150
        entry_SYSCALL_64_after_hwframe+0x6e/0x76

-> #0 (&hdev->lock){+.+.}-{3:3}:
        __lock_acquire+0x208f/0x3720
        lock_acquire+0x16d/0x3f0
        __mutex_lock+0x155/0x1310
        mutex_lock_nested+0x1b/0x30
        iso_sock_listen+0x305/0x8d0
        __sys_listen+0x106/0x190
        __x64_sys_listen+0x30/0x40
        do_syscall_64+0x8d/0x150
        entry_SYSCALL_64_after_hwframe+0x6e/0x76

        other info that might help us debug this:

Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
                                lock(&hdev->lock);
                                lock(sk_lock-AF_BLUETOOTH-BTPROTO_ISO);
   lock(&hdev->lock);

                *** DEADLOCK ***

1 lock held by iso-tester/2950:
0: ffff888197c39278 (sk_lock-AF_BLUETOOTH-BTPROTO_ISO){+.+.}-{0:0},
                at: iso_sock_listen+0x91/0x8d0

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 8af75d37b14c..5ca7bb0806b0 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1095,7 +1095,10 @@ static int iso_listen_bis(struct sock *sk)
 	if (!hdev)
 		return -EHOSTUNREACH;
 
-	hci_dev_lock(hdev);
+	/* To avoid circular locking dependency warnings,
+	 * use nested lock for hdev.
+	 */
+	mutex_lock_nested(&hdev->lock, SINGLE_DEPTH_NESTING);
 
 	/* Fail if user set invalid QoS */
 	if (iso_pi(sk)->qos_user_set && !check_bcast_qos(&iso_pi(sk)->qos)) {
-- 
2.39.2

