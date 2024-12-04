Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D71B218D
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733315359; cv=fail; b=fMkz/LlKG5EawdojbkI8RR9E/+MfpXtjWF2QlJb+VPvIc//iOZhteJn7FthgHXj1KhFrxe1CdeSwX+A0MLsfhUizuSv83dkxrTXrGZMpdxL9BshkfnoIoMF9TZOaWjh64X0yQIOtYFexKm3IkAMHqKSeO97jh5tCXYk6ExEAm3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733315359; c=relaxed/simple;
	bh=Fm0O1TFhfd7mqvhZCRYXdsyx6ZYHSr1aTzSQsJnLqqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MeiLq1nlVGEZgeaeSi97/RsdZKzKsO40rzXQO5j9Xzdo/JlfPQ4IXc6t+E+0b6DrxFcordTXa7JVy0IrUXsbH0Hds64x6Vf3A6OJN6GppY4cBe8HqVnSHmoPrcICLQcPrJvlx1mIwekno+NgFJ0133p6mD28epGdxmcHpPNPNgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aMUBxgG6; arc=fail smtp.client-ip=40.107.20.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aMUBxgG6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VyF8GDTRTi32NtEgVmG/IiULZrXl9jA3eP23BEeTBUVSdE3+43/d7jevq/R7UcXcOM1akuxnySffKQwKOB/8OxgAXOPT0W05ZhM7puaAA+KTeLu9lkbEi4wTiGNJuoLVhkqfPsrRKS+oP2Y+AbIyNPKA1uhn2+EDgK8IBuFbVk44YDc9ByRFZmnlKI0S7zkTeeyV3L0hT/D8i84wk5gtRJTQdgQJhDSj0Suc0q9B6GX07WBR/ipwnXvWbLUL6fbQn4B19GJYME5YH0cnqSh+6fL/nW/ly2HNAzZ0jY5TuZUfP04rEwJHdxfvLcoKKN6r7BXbhrze9IOshtnd7S4p+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceQTuQ3LVzADRCH8pv1jQbxGfTAcKlc+P7Ofm9S2lUk=;
 b=e08lWNFkSz8n+c3IULz8Kik96TSh3PdVF6nJ/VPabOmBLUacxQuHxsXTPF7tvU2MkVau0G34MUPKLaqS3fHoqKh8Jba0OhPqmbamzl9cviyp/a939v5N18teFziRVI6LV5Vq5xHqmnkEhIgBpVDHyv6bR0CPUTO/6EvF1o46xUyBP6Z7LbrQVyOebKLMLD6ORLpc7B6hBCgyNnbhEmpyI6mcp2n4f8ZeQauG22DUQ/bLgvZYVFVYazBFhUoCYSx9/4gSVM+kP7jZc0PVygU7epopEdUCD3x8pVXxnydzkm5dXvDox7qL2FdLuffBNmgMozVcMiS/AjjmwxJUTKto7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceQTuQ3LVzADRCH8pv1jQbxGfTAcKlc+P7Ofm9S2lUk=;
 b=aMUBxgG64PtdZ1MxxnGj9ug65bkkEJBSZZ2StZVFPxQRWLGX6ASQbJMKG8koy7MewEO09BJaeY+rr6366cBQhKLz+dubEAPGFBvHk771GVYRikSBtBJoetzrFnEi+bTIYbemNyt4QPzJNdiRjxcXXixrLtzxxYAO/v9+GwsFFT24D+svjdnMHQlifw8Eh+oeLqKaDmLqnuF1DUbWxdkGrPjWU4W+/SLHR+XgXcEuPWqtDCnvsl5GnVgNYpx6mwVv6qXTo4LZzyGrEm1V9bSHGWbRiSKNcFgz9Whqi8DPez/QsKQhu7A9PBDqxYx4b2oeZML/mahzNSlbiGCqKRUGhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7575.eurprd04.prod.outlook.com (2603:10a6:20b:29c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 12:29:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8230.008; Wed, 4 Dec 2024
 12:29:14 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 3/3] Bluetooth: iso: Fix recursive locking warning
Date: Wed,  4 Dec 2024 14:28:49 +0200
Message-ID: <20241204122849.9000-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204122849.9000-1-iulia.tanasescu@nxp.com>
References: <20241204122849.9000-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0044.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::8) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0adcd5-1f6a-4263-6222-08dd145f4399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vgIWkBO+lrMXmc8zQxz4jC5exA4gvUkBmlNKWyAfKj1OGlkYA77KSu24NTUm?=
 =?us-ascii?Q?ZRoG4ILU5WoXruwvytL6B//PW5JfcPVwjiWRZWWkf0dJ+rppRL/dzhz2ZE0M?=
 =?us-ascii?Q?D1ThCFNpm+IeBVpyU/DGXfJROsugY6JykhBFI1DGJLUAQ3sWeWk4m+yDyLAc?=
 =?us-ascii?Q?ZtW1lUAJ7X1DXqL6a9547mWCLCF6o7UNi9HqZzM9HfijsM3qPtEbhHmW0rY2?=
 =?us-ascii?Q?jCol7yd6n74Pt402EWpj7FIkoysikKr7u0SkRE0xnevxBIrM9g4ygwnMkcv8?=
 =?us-ascii?Q?9CPMGE2XLDc1KnnI1//MwNZOVUsLa5GMFAVtjJgEekB2Ksiy4oD+0D7H9c0P?=
 =?us-ascii?Q?XCiatb0hDao2mR0pkFf9SiH6+JWrKJC07r7t6uXJRoxHonvLKBj70C8yZNqA?=
 =?us-ascii?Q?prQd1N2TI3T5h3uUg5lt/ig8Fez+RpDT2qN6m8WESjulcyjGMjmCBZ+7oMMH?=
 =?us-ascii?Q?oA5m8Z3VwCuUCN+DHvT7la0riYMEg6FHpZNeHTHbdid9kLkv53Ha7gNmrqKb?=
 =?us-ascii?Q?lcmwOLTEPBsKMoJG1afUPapCWl6tZiAAd4UG0Z/P/dmAae7IB7fTw5QgtAbY?=
 =?us-ascii?Q?l0BrZbWjmcbJoAnm3i6+HcOshYLwhWmgCOAihTNP58wC2ew6j6t3QRRUlVNS?=
 =?us-ascii?Q?BBX6QGqifiiy/lNoLOq5y5AbiFz2+m2ysppXndbagwh1CVDOPgXd+ePCqX12?=
 =?us-ascii?Q?9b/osRjCHIF36FD8FTxMKkASDWbNwgZgL56iByoinziGiuSQbf67VZi5tRoR?=
 =?us-ascii?Q?jm2n77qSxe0+Np6xvZbtum3ZLHgCkwCRkFXDcyjvYtmtb1GShCwT2zcCaVjU?=
 =?us-ascii?Q?/sJe40fcyi83UzzgFKhG8iDSWUiz+aLygLbPRszhKX6teS2LYOdoI+ihHhK5?=
 =?us-ascii?Q?c0GdXRhdmtW8qL0yS3y4P2Ax1LAiYnwOW5WnO6D5eXrOa6sKB5Qj/MLlZwZf?=
 =?us-ascii?Q?imTSJq+J3EblHPrHsp95IObL7Sc2X9yXAMhg6e9Lm5JZmbgezVqa4OTqX41s?=
 =?us-ascii?Q?KxC8aVIBXX3yql6jy1L1MzgHmeZYJ9DwYAXdxlFl2CKGARrGdorEvo8DAnfj?=
 =?us-ascii?Q?XWHZg2Gbj1I925pogvazMvRjAwjkxZpYNSS9ZWhU6XsxIyIYVPl8L7oCDbWO?=
 =?us-ascii?Q?C5jghfHLluKvPnbVrJ1PIj/UpyLu7oCl2X1YSbiJBWqCGCT8/8kuAXstwbOb?=
 =?us-ascii?Q?Ng3l89gKJTXMO/CILRpQ0ONFHvdigxoJyIytUlEhflrU9n9mv5XT3M9KuqSM?=
 =?us-ascii?Q?eIODpKQAQvHDg4IAdBZQE1+CfXAHFmCnM7kdGdfuS0GMxahEhlbLmmWnDhhr?=
 =?us-ascii?Q?knZRFkJywuyhQqz+5x4fJ2YhyS93AfUUcd7I8QepoU46yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l7oEBO3cFYryfYcMzdZZmNAYehgCh6q+HL30B740vlg3WLeQ8v7mdi7OcUZO?=
 =?us-ascii?Q?t3Wv5tBFjTCrPtR5yTu9JxhLnKmvEU/UuACnfxUa5IY0EIradHYuyFgbGkIr?=
 =?us-ascii?Q?C559HkC//B5ob3QzpN85DiZHN76R0bXpZilv3y0+BqTCIAR5HDyRF+ofFpPU?=
 =?us-ascii?Q?ozaRnt3q2Mbhi864yLoE5P+sT4Dg9DFfNyvi+SavDWPxfLOhnmf/0I2AyzEc?=
 =?us-ascii?Q?47myQlFIYw+NOqgY1wvruweC2C4OIb9+B8cyQ3OcbvI4WOpPZY4MwBUXsERU?=
 =?us-ascii?Q?MjajCvDTbbncc3+vTKjTjDK1y8rjjBOVyn6NhG02BTzd9IOcmhCc2AviJsUC?=
 =?us-ascii?Q?VByNgApDV5NZzZ8YmE77aUrrphKZCnW8pMTz5apSb3Dp2ZcWoU5dqw/XlPUC?=
 =?us-ascii?Q?HJWH7+2D6TwVMlORSjzuXbKqKs28m/9zlIY6yslT/yzdnVEyZUp4q7KTKeCr?=
 =?us-ascii?Q?3TpBMF8maki3PneT+BLWdE7TWBxRInlPGZ6oFla3lyFcEPriN81uSeW1eKwU?=
 =?us-ascii?Q?+LAnE/ZfOhiz1dA4pNCj+O4UHEJAdFhX6mlv8MKFtmNbg4Yx1HfPzRCccbWI?=
 =?us-ascii?Q?NQVHaLit6rHghNeOO/35lCy6wPIIyy7ratHSpVgFfykTuXYifsJC1GqxTj0S?=
 =?us-ascii?Q?2pPQzUfh0Nj8KMOWDGtQTL0IHnbz7m9ZWTmUWXpAr2vNv1+msbBxCOJ8pOyz?=
 =?us-ascii?Q?H1OEE3E041e1SCCVeEKln1a9DHWvpnpBFsVvJ5zE10Dg3k6aswR0djJcq1T4?=
 =?us-ascii?Q?GIgZwbJkS5KtPg7HlAtPWSq59I7JBRbnfMSmGVVGE6sZT4AtBhbscXV9+zEa?=
 =?us-ascii?Q?EhIM/8wvzUiV+3mGNVE4hrj2Y52IeX3WHAhwg1VnKSJQ8XV4TmbYWOlbUnxL?=
 =?us-ascii?Q?iXO3zNFdD9+YueOHM3gnIyfN/+MQF8L818PaI9yOirvY7qsRR5j8ZbkEXxUk?=
 =?us-ascii?Q?1lEdb8nlAlbI/Z7LXR2YGBy+3V9iFsXdbTmeU8K+1SNie3/aXvHIBYWKYXyM?=
 =?us-ascii?Q?SgDLXui3GMq26mY+vUegEO/PTVvcG38G82M1X9rLhOAl2eochyVDAMin1CQJ?=
 =?us-ascii?Q?KRBiuoInF0J7am1fWRCMH4M5VOyjTB3OvU2l34EoHBQMebcOC0hedcnjdPCc?=
 =?us-ascii?Q?boHzlRt5LMBadd5Zw+xIongKU9n3wyF1z+ChPCx3QPU48eXM+YmeOxrLgy8U?=
 =?us-ascii?Q?I0NVLviHW8doNOz+Ts2Aj3Lp+RZz8z9HOJE/qKwgGqNYrOOZEe55up09Mecm?=
 =?us-ascii?Q?R/Nv/Sy05N6L26J6kpGGfGtyBRO+fuAEMVuIUEsLYX4RsLqwfNRuATkJ0A0T?=
 =?us-ascii?Q?eUcOdir2ayhaSpnwlkb6dj36SHpLSwxHJ6zaL/6Z59WmnZROo4Ijlw7myUsy?=
 =?us-ascii?Q?XMAMOALB5ayOCBIzglIi55Loy5xnUq0try4kV8RLYiPfzIZG21lj2XFc5Nrj?=
 =?us-ascii?Q?+VLjbnuXkiVe8G/3UBXKqD43+AfiJHqSZFUfHuxQHxZhl3Mlohn3kE98z/DW?=
 =?us-ascii?Q?X0+QCLee9O0FQpAOhrrjYL0pkmbVhEhl6x222CPdFS9FF9xLgMBI6HikZFC1?=
 =?us-ascii?Q?3pT7MqJaJ00AiVno3o5Z0N1qOfXRfw6DPVsikGrixOAaEeR+4v3I3HXJnR5X?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0adcd5-1f6a-4263-6222-08dd145f4399
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 12:29:14.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5XCajlNVyT+CjRp18m0qaHvNLUkOjVNnvxnBFStwNaXmDp+/RLswLaTWrIJ4LIsvLC7EMgYzaMj3MYHz6ezpxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7575

This updates iso_sock_accept to use nested locking for the parent
socket, to avoid lockdep warnings caused because the parent and
child sockets are locked by the same thread:

[   41.585683] ============================================
[   41.585688] WARNING: possible recursive locking detected
[   41.585694] 6.12.0-rc6+ #22 Not tainted
[   41.585701] --------------------------------------------
[   41.585705] iso-tester/3139 is trying to acquire lock:
[   41.585711] ffff988b29530a58 (sk_lock-AF_BLUETOOTH)
               at: bt_accept_dequeue+0xe3/0x280 [bluetooth]
[   41.585905]
               but task is already holding lock:
[   41.585909] ffff988b29533a58 (sk_lock-AF_BLUETOOTH)
               at: iso_sock_accept+0x61/0x2d0 [bluetooth]
[   41.586064]
               other info that might help us debug this:
[   41.586069]  Possible unsafe locking scenario:

[   41.586072]        CPU0
[   41.586076]        ----
[   41.586079]   lock(sk_lock-AF_BLUETOOTH);
[   41.586086]   lock(sk_lock-AF_BLUETOOTH);
[   41.586093]
                *** DEADLOCK ***

[   41.586097]  May be due to missing lock nesting notation

[   41.586101] 1 lock held by iso-tester/3139:
[   41.586107]  #0: ffff988b29533a58 (sk_lock-AF_BLUETOOTH)
                at: iso_sock_accept+0x61/0x2d0 [bluetooth]

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index df523a09ca9a..fb15f53e2ce5 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1241,7 +1241,11 @@ static int iso_sock_accept(struct socket *sock, struct socket *newsock,
 	long timeo;
 	int err = 0;
 
-	lock_sock(sk);
+	/* Use explicit nested locking to avoid lockdep warnings generated
+	 * because the parent socket and the child socket are locked on the
+	 * same thread.
+	 */
+	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
 	timeo = sock_rcvtimeo(sk, arg->flags & O_NONBLOCK);
 
@@ -1272,7 +1276,7 @@ static int iso_sock_accept(struct socket *sock, struct socket *newsock,
 		release_sock(sk);
 
 		timeo = wait_woken(&wait, TASK_INTERRUPTIBLE, timeo);
-		lock_sock(sk);
+		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 	}
 	remove_wait_queue(sk_sleep(sk), &wait);
 
-- 
2.40.1

