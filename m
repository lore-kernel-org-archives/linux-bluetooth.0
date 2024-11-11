Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45D1946C2
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 11:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325643; cv=fail; b=Lq+beaMvJFSyFmFD1CUGYw6F6gcadYLlXMVdbYxneeOU1rvK2Px8RETEZQQrxInnbVdBivx3eAbHEIULtv61WhTp4bmQNxriXN9vlpy8Wg+Us3PZhAd6TNbogMCNiNM/txuHlRDVGifXZy+vpS7f2aRjj4sI/gAUfmTWbvKVThc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325643; c=relaxed/simple;
	bh=8XQzQFP46h7cge+IbGAxuw+tll40gVGkrxSQZIVJKnw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lwW+wCumNG+nRu0Vli2BumGFknd9iF6cokWZkOSY0UYnhqMoC+Bj4xwg9rc68EPNzTPWWVDgYnSfrC/EpWngAwf5fTWBkZydnotqnEKjFrhqLuhj7kQoBDA+HX7tAFzw9EdEgc/gJallYfhkIjCkHN0Y4j3e9JZ+Gv3pJbjC824=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UISa+/0K; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UISa+/0K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9dsJX6NcINMntYErBjdwL/+x5zQqKola9uE6r36Vc8FOPttTD/Sdj356vj2KZnbTLO5VYPd7iCS04hcgMOiXxjX65EKC7zjYFYqIZ5Z1Eo5RLH527AGCOxTKzUV2bJ65d7l+B6yCxNuL/UymuQI7VjJrjrMf2PEuSVf8/rUkW28l0cixFzcNXQeXpg4FjZDHtOBoDC2YkcxV+QeXHUi5+20ZbkD0zf8uTbvBtfzxq/5j/FvwRaIhb8mejLaIldMhiKiOAe2ia1ZlFHSu+Wa0KdIYet0qhCh3AK3McfcZXHGQdHCg0fNhYPGrSpxQCGTdBhGPremHBDdepM/WUr0YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iuMo9p2MNrYYpMyYpz324JbErVFdXzhGjCVGMM/ja0=;
 b=VKVjrkR1a5Xg23n8h6SKhYhCsDcWbKd+A6BPnmj1ffqTbZjqY9MlM0eRhivcpQykv1H8RI6kC3jIvp2XUFPfmq7vKamPlOEpu0HtNfhUdPlkq032Ve5zoK1GKq2UbPAGHT9pOTG8xUZffE+P8tSBrr6B6yzD4QgzSeJtOZI12BG9gzvSdig9Ln5VpUFSF8wptPjZqSXMDAop/EMeQWnsG5qfNG3cremVkfSNTehWf0mJy693iQe69ajzcapwWRl1E2YQMt+z/uEClz4fOCapx7FC7syTACXJV8jbIL0g2v5ilr+dg8M1qP4BJEsGuPoE9cE5jjLwEtZfai81ZzqZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iuMo9p2MNrYYpMyYpz324JbErVFdXzhGjCVGMM/ja0=;
 b=UISa+/0KVZCSltA8wcYZIq8gtQLzEla3uWUv1nwWUgiiXYt4aNMcJWza8XCjaJ1ZEkwf5apzeh3tUfuvxL85G5gFYd36biKOScm/QfKPjAT9Ce6IWzxIM160OvW80sXlOUZ8G9iwUJHKgFRh98ZDh2X4WD9FblN1gUrFg8tbgAnvn6zK/kJhDvBXAsYCXbRj28UiRtVE7PHYUJ3ehAIgzJSgC2RXYw5MDMLlE3TQyW3Y7vPQ4DmeURZgHhhAt5NqZtLpHlvZwzvCAIgys6VeIldQ/XPcByk+PmxkSyuyuw8zdhtkKw8Do7YqA/+2o24mq4GkhvovGD1Ysr4W+cmdZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS5PR04MB9998.eurprd04.prod.outlook.com (2603:10a6:20b:67e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Mon, 11 Nov
 2024 11:47:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8137.027; Mon, 11 Nov 2024
 11:47:14 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/2] Bluetooth: ISO: PA/BIG sync fixes
Date: Mon, 11 Nov 2024 13:47:06 +0200
Message-ID: <20241111114708.10722-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0030.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS5PR04MB9998:EE_
X-MS-Office365-Filtering-Correlation-Id: 65c7ea53-2874-48f1-1239-08dd024695bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N7HdrKc9C2EanklNs/AWGDCpBmrMo8+CGLCKvteU65GqhdBZ38H3Jqlu/v5p?=
 =?us-ascii?Q?Sg9tFlAc5BE3b20LrfCYAXYMUUnWsBQJeZ2OVuU7Gmxya5ACV9IT27L/QD18?=
 =?us-ascii?Q?/XEm4rBTQp86b7GXxgPK8sff4p1Z5y9WToogQTb6HLoybDrroSqQe9BZF5Vx?=
 =?us-ascii?Q?KyWgVyFwsQCThpwcuNhE7zn07Lfit06kHVWYQmven5rd3M80qQeHQ04PWent?=
 =?us-ascii?Q?73PW4OEliyRZwUM0/L8r3Jjgqd2xvnUhVMu3TSSqoY9s0clvYxEzXcHd0FZP?=
 =?us-ascii?Q?qWhNxxdQwyI/dHDI0hZ+4fMBTLxE7bCubl2FghnPmyR9BdViZo+rYRZztD0C?=
 =?us-ascii?Q?Ct/RF5BCJUdTeEEpIqE3sdfdc1Chh1g9vbutq2JoDS2rnliJzkO5mRWBW9CJ?=
 =?us-ascii?Q?t0pAYreRsS5wrLBIpTQmI8EaI8z4MVl+s1215nYnRKeHbjcqVIpauBnOlmtZ?=
 =?us-ascii?Q?2zFnTq5VkGjo5FC58fYEepmTyLt/ftmQTURTxuKY7fk9k+/SGHzA21OHZyEm?=
 =?us-ascii?Q?RuCyV1osga6Tqh50jjr0xQ/pK3MP8gnHJhPTjp43fCyq3RYMX7eEoCCwv2Pa?=
 =?us-ascii?Q?BnvTkZrAqhUmEjEL+Bv7L4PjYIoqiJN2jLG6BPrizui6Hl4pzD4JzS5HJ6/f?=
 =?us-ascii?Q?qu14vwr5AEGNiv62RaYJpQCdPUOifZfdNZpnEcng16jOtvhphgD7ZdrPZyEj?=
 =?us-ascii?Q?KLjeFtnxaKyninG63D3aE5w0GYA7jIwmBqxrzivwh9kB7a1fPwvdrFNpOoNu?=
 =?us-ascii?Q?cJ53ZpPYSPm2H2P3NEqINgHnmrRPPHLZiHvgo5JycB/KweEcIVdVBo2Lg614?=
 =?us-ascii?Q?M7VtuV0FKl2VEn3zOn7qlpDlxgHy8Z1snUOOaqmolyooHzHn+eZkLu5UZGPD?=
 =?us-ascii?Q?aCvyCptaScXU3wN+pkgNnjTQFd3eTRBuQ7Un0D/JQxh1bnZD2UIay079eIu4?=
 =?us-ascii?Q?l31cqwmCRZjnPWbdItlF+NEj8ZCzMJ9jo7W9+m/K4O21roYV/r2PTyCUzvFZ?=
 =?us-ascii?Q?gGUJPmGbXZDgYLEakZawZ+LICClICtcX56DNjM04vgWVOPJqNdWPPZXovFF8?=
 =?us-ascii?Q?cEIaai5w7ndvd5HhGtuvRTy8tO2+Mtr9oRrWuoJ2mFvDXAS+22FwCX6xCVog?=
 =?us-ascii?Q?E3KvO0sR6dQU89tZ6BbGoPVOD/Pak9VaIlPdxyPZl4SiM0LFG5LtgFF9u2aY?=
 =?us-ascii?Q?4oukaK/nHz8EcIZltq12x4T1ny8/XkF5RKVTTslg/8rPUleZT6lvwDZGmBR8?=
 =?us-ascii?Q?omMMnK9SWN9NzXOIUQwejykI9T+dtq8/CggZ499rI6xH+eA+hTeW8vUsLqER?=
 =?us-ascii?Q?guD5aHpe59YC2FuotREujZQD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jxsf33I5Cm/ONHY79QDDuvfDq0W5iZT9isXjXHApRRlIGQLqYaQHREZ1oSuz?=
 =?us-ascii?Q?Ib7sICJC1V9m+9InY4tACn3ZrD2Ptjo5NmVrNfDBP9aOg2tocR4tOiY9zUkJ?=
 =?us-ascii?Q?Ok+cI8oEjvWubt3S3yWPd12KVEGXJkl4kj77/f8/6pewlDuXy5M8CNbUuhF/?=
 =?us-ascii?Q?eUTKlWwQAZfGPJIjljGMPViwPott6qxYKjbUEwmLApsO9heL7fVkBegAaiML?=
 =?us-ascii?Q?cCtRKMADuzWloSaI6m83Rw/GsBKjxAWjccCsduuDhb3+QSNDL0hudCJ7ZHjg?=
 =?us-ascii?Q?wL9aGBmS752bimK6Qsg78XZUNy8SOjKDDbYwhnz1JjYVyp4U2nFWEEKh+6tj?=
 =?us-ascii?Q?DYDfmlFt+tKMIbcmNfz8kZhluKaPIzU93yNfdlgGLDjMWde6KNHke2rEBH+t?=
 =?us-ascii?Q?cjuWL7tCESqrcfq/81yv/kOcIILRs+weH8MLnubBEjXUSwC2GdrYNGWj/QJd?=
 =?us-ascii?Q?k/PoONSGOewEO7uHSEsCyQQI3QFPUqzsVcbbGWTW39l/bi/OkYb81qWlkqPk?=
 =?us-ascii?Q?Y2T/LOBavdoYh2lc5I7iBmlxuwjnJ5VHA/8hYeLHe49JA6oXBLWR7/oMKWm2?=
 =?us-ascii?Q?Xxq4qT7TaJ07LfTSWwgMqxCxwYLRN1ZTdhiWf+hYQmZJcGFD0Crytq+dv/Jp?=
 =?us-ascii?Q?AEw8TYkWSLHYloDGoSe1gNuRTbf5BGp3PUehDaVyJEHPm5D3ACL04XVoA8g7?=
 =?us-ascii?Q?pvDRyQE5Q4ljMAp2738Y/gmuFKYkUUwQ+nZIEtfu9eaKAETKEiY6AL5x2CzW?=
 =?us-ascii?Q?i6M3iy7TXKFtwkGVPv558vo9H4E5iLFLxmB1M49YkNRaYHJk0nkR1tO8emHB?=
 =?us-ascii?Q?EXnqRZR5yoALEFCS3imz0gdXnK6ojMs/pFG84/Ev5zwg3PWrHFFx5Ouai/9U?=
 =?us-ascii?Q?OJNFCLn8Xh6HPctFKTE0gIM3HGNyRi0f7zZV5wvGSpwUP3s/5WuSOMxql7cV?=
 =?us-ascii?Q?W7eIF8A1TOr13ekKXrw/CCHipRzOMbz21+whOfr2BeVMq5k/d2m7YESLwo+Y?=
 =?us-ascii?Q?6IJEFDgA6BvLG03N0nPNzM1d5JOK2XXxJ5lLKHJlJAKTIiHrO70oK0LmQ8O2?=
 =?us-ascii?Q?N+Zcjud7CpUJV5nh7bMRi1KR+FT2V4y35IDGj+DRei0zMJBMLN849mqof0iw?=
 =?us-ascii?Q?ZP8bxqjeRl9IO8ffbbyZVEJ1HDgs18eb8pNU3sC76JZfzxNZnDf238Udyiil?=
 =?us-ascii?Q?7ffyJVVjR4xx0q74//kvOswvuRCNLN+I3tscnMoAp46Vuvz828YEyZyot7tw?=
 =?us-ascii?Q?wbirE/ygkaWe78Vg0Ii/l0BAUE+CJ9edmd0aXQg67dZf7Q9l89md3EKk8Pfr?=
 =?us-ascii?Q?sF3thmYcdUUw8QdwB5QM3WSlWHqfxAjWmU44HgnvfhcDvzLzFYljrxPwSmm9?=
 =?us-ascii?Q?FfnvLVCXmXyQUWo8lbd7Sigtc/v3aFXAHjeV8m/h1vwBuI5EnqU01Ex4x3zs?=
 =?us-ascii?Q?6fhZvvUPpR2WvhpEN2SmvIlRneQzUT1LzxKatVkggRHTCOw824E/2G4hWR7W?=
 =?us-ascii?Q?PTuXuhfCDCz/sPZqypnnPebe6R50cWtNQxKodnQ2Mw6HYFlZxqkiu8I2GV0J?=
 =?us-ascii?Q?Vp3GMtTdaTYFkk/EZIv/jTewEcVEHk6HweaBo69MVS9Nw6Cp472TFEoke9A5?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c7ea53-2874-48f1-1239-08dd024695bc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 11:47:14.1028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xupkRkX29MzJWCQrKnxOvb4eaQVNV+pNePtwttwmUGDszqJV9y2QCbsFcBvf4u/9nfwKA9T7HkNSU5ISoYdHWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9998

This adds a fix for the following BUG message, caused by alloc
inside critical section in create_pa_sync:

BUG: sleeping function called from invalid context at
include/linux/sched/mm.h:321

This also adds a fix for the LE BIG create sync command, which
is sent dirrectly via hci_send_cmd, instead of being submitted
to the cmd_sync_work, causing ordering issues with other
commands.

This patch fixes comments from the previous version.

Iulia Tanasescu (2):
  Bluetooth: hci_conn: Remove alloc from critical section
  Bluetooth: ISO: Send BIG Create Sync via hci_sync

 net/bluetooth/hci_conn.c | 45 +++++++++++++++++++++++-----------------
 net/bluetooth/iso.c      |  9 ++++++++
 2 files changed, 35 insertions(+), 19 deletions(-)


base-commit: 2336a5b48954512198205ea38a73ca50c6714446
-- 
2.43.0

