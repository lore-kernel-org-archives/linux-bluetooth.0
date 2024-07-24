Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F802D030
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831719; cv=fail; b=AWG711qCxlvERXVIEo1Orxq57VzZnAkffCFED3rcVF312ZeVO6d8xzuYk5Uu45RX1xxOgVej+xy+oGKsddhtzIYmGtYOvmpz1RlYnjCcCzNoIoRJMVwvi3HV2p3YCHwXlKoeKJ2f2zavEeo/eH/FBU4vkL/UElnVZ4CEKBvLfEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831719; c=relaxed/simple;
	bh=hwTl/k5FCHD8GY3RQef5b6zrkabjhWZXp7T5+IY+uoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UWIPDCFWvWFW8Ir5oh9DPRxA//uQIcuEhGQjJFOQVnnrfNc0M8f5wXPH17BrBBwsmW8HHNY+zsIMyTddciPavQ8lHWSrmfyGLf5WY8z2zYjy+eFiJr94fKQFFNZ7RwoEk6PEC4HxVD05Dv01XlwUHU8Fa290Fi1Pd8Kqamyw1F4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VlBnset1; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VlBnset1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GRqT5zaVT8jUPD0/jMGxEx4vTEuuRmWxGJBvQC+T7B4eKrfmLRdzKpWdUG023FH5kjJcnkHhfvnjvj4NHpb+cA/LaW2cbpM7X7SIbZg6Qpt1FBKrO4whANPp5D8A6o5bYHA6LhAmnyvyi5bdP42QFdxfybVDrp0VrRXintNJ6xqUHLPrN4YSICPHzBaH69cZIEmthre8DQn0I4aHaqFt2XDJYNnlQ05nBHSDQC13CJR7N/QJDXCw3Vd+bpxu29ABJxmnxAPF/KqNXYrkAEoOHUFy9Rv6AO9u3hCpSVgWWbFREXeKPHJYEYewmgYSHmfsANlaNAvBD0l/oBR0mDY2Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6RBqQ1diB/5McJByT4aF6OA/d+7zApibgUBVH4lRZw=;
 b=PzSd+GW+TP4de7KK8E/BH0hsMDI70rUE17fDNO8otRs1JmLEEE6zjwvMderhX+UhfqZhDwAbgzT0ouIo+6l7SX/8oI1UgfWJrqWsxQhAu3paVxLKeYeJzkqLsdPtuMwaiRU8DwNdueVjUDpKqLFmm4gL3dtXdHnZG8APKGeC5c96v5Rw80T2MFAgQtbpXKy+uKlhG8cVavvDrOWy2+XC/dRfk3qaH81DAj2fhEIJVqcx9jv1zMlTMhYHOYRYsZBE3SLKC+EyjRJgZZ0pmCqcC4Zu6eadnsAI1EliI8x4QBa63vHDvuGaBbTd5XxZbhW52VG0MZmYOgFzaPrCPCpy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6RBqQ1diB/5McJByT4aF6OA/d+7zApibgUBVH4lRZw=;
 b=VlBnset1pMffuyjy/EjUGQajLFzoyiGGkaS/ZUp+gkG7pHAy+TZqP1aFiltWkzQCzQEpIVuh8Oed8k0XuPj6Cdl7/DjRRldb78gCM9F/yPEXEPU1IFKVIqadglvNvnaqv4HFKJKizO6y3GTRQCm0MOyAgD1UtNeMF2cmdyszkFgfvUT7a/P/pxWaEBdrqAM9YGuK2AeCx3ShOk3iEP6Nm3eFtX7tw0+p3s/wZrD10HQtjluQW1SdIc8fF3pO7vbA0IOi90sd1ZZ7bfikebfVoxJEBiQ3k9Ktzy7yTOXVIs9qTGJ9rul7RbaSWE9E8NtlptHrIluWuppsYAu+v3wqDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS8PR04MB8024.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 14:35:14 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%2]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 14:35:14 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/4] transport: Add 'broadcasting' state
Date: Wed, 24 Jul 2024 17:34:22 +0300
Message-Id: <20240724143425.165959-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240724143425.165959-1-vlad.pruteanu@nxp.com>
References: <20240724143425.165959-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AS8PR04MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 858e985c-a592-4d87-3ebd-08dcabedd46c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f0HgR8aGSqS/xXNDz7GiB5EAjtt/mQjikry4NzazmRvx9KIoFhO/tmq8mgG1?=
 =?us-ascii?Q?oDqOdx5HAhErhrqD76waay9nBPgVK+ahw0deIIh5PlGAikCgTAxm2z9yeXWI?=
 =?us-ascii?Q?SpFHRqqASG2NBlhDVOPLnpQWk6w8Q292i8GFUnieeaeL1yoCsLtufELMfqCW?=
 =?us-ascii?Q?OLwFlcANR5Va+qjEsEgXvjNw/wHA4U9sXiLTVAaEjn+11d3E3dzomD2JEbCF?=
 =?us-ascii?Q?WcL6tSHDwPNba3Ew+7bJOtugkunaJ5TeOGkmJ2skP5xTr6GcyyJmSwY63VYm?=
 =?us-ascii?Q?oUhA68MH2LAY5ddbI6uYDtOalRFb9+PmUFkg0UHVph+LMNl6T1aoo6fB9wEe?=
 =?us-ascii?Q?53FBkXKRErVJDCXTW80Eouyd8+0F/ecloLzEUUlxlVeiD1m/KImaHaeeLfLP?=
 =?us-ascii?Q?FnlpvcxB9HwAP6+4L5Zf4GwazLgrt41+dPRlMJvGwyJoaQABQVLk+nUQGOVt?=
 =?us-ascii?Q?l/xYBCihHs0atCOL30+Kn+OEil8DFJR74d/Ib8lu1j37809+JAwOZuCYQqxK?=
 =?us-ascii?Q?Yu4GhdlUOO45MhCdA4Ij3VU1Ui5fB0GX+fYiwrSTFA+cuZUeBBEtXoYUXX7P?=
 =?us-ascii?Q?+YZt76TeITEr60pRnG0yqp27EietSB9inSwT1MEbTVWrVKJ2WZfg4s2FW0rz?=
 =?us-ascii?Q?TOn9KC0KXkNqxIW89v5TfVA3ZvS4MUn1D5u8rDcZhq+RGQUAF4QxFvpr5idu?=
 =?us-ascii?Q?HKk/UDBk7MJsL3RTKGzvsL2lRc0IalufBLr+XKH8ZVItncdTWclAeAyDbuKh?=
 =?us-ascii?Q?hjYEHEiguhOSaOICndIMbjXGbXX+xHqipx+WwXuU2wf3IaEsbXbS2vWkIjSh?=
 =?us-ascii?Q?AKnaQ7jlo55Am5l4sVuUbSOj6/vl+gpuMWy5bu+alS9INc7FhDSRzVAoVTNH?=
 =?us-ascii?Q?jMqna+qwysli4E1fjr37atxOjX1Ghn56E1FgnquEvAD2mDURdkpmARQhe3ca?=
 =?us-ascii?Q?PcSwZC/UR//hIhauu82pMgIkhHLs29Q8ueVn/FV+MtqfI13FB4P7WXa8as1X?=
 =?us-ascii?Q?epiqqdsxqPlDvhl8OCAMe2tjnFbUsp/GGRB3CWzNKLb1bJlgGIiuR2jnCIFf?=
 =?us-ascii?Q?pfbjxZ3bOTPUIGcuX2l8hUo2lN7+suJTBj37MrfwYf0Bosq+wOW4/n3K7mAC?=
 =?us-ascii?Q?5Yt2x+x1OgTlfwGN+oEPi7WINd0JBdzsVIcKt+679ZuTcyVz3XYmLK7MsgvE?=
 =?us-ascii?Q?xlZlfZlq4CABMrKEKTTI/e4ZB+ld0hqBEICR6QjeNTcMNSi620NFu3HzPr9p?=
 =?us-ascii?Q?WI9DawvNyXro2ceZZ/UrdrNSMumDz0t9Dym0y8AWEMn6m9GO588CHmZHlubR?=
 =?us-ascii?Q?uhHUFLwLuhR/tio77qDx7SbgpDMTSY7IkdS3lrjo3xtjciw+gBOKzYwwndEn?=
 =?us-ascii?Q?FONl6O/NKnVSgH0JC+Hz4qdFRzPVG+OuqEByI4MJb5UEdZ7xqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bu6ZK/kxFi+dGFpvv8XKDT8qx0gIit5Wx2XJ9VsdJ5OkVwwivDGZDptQUOdu?=
 =?us-ascii?Q?y/6SxxdxrSDxTrtQr3i9zZya4+QC0uc/QMYuBihnLa3GfNvG6yZXnAb6kkj1?=
 =?us-ascii?Q?dpRbBHcJBDrVFFHA/VQwphVryqKUlJfFTAFHBog5/QNG/J/85DBQTrzmLqcG?=
 =?us-ascii?Q?/GxSFp3+eA3v2a++o2nvOFgGrbPtSrDtfkX0h9CzvQ7T50NRD4qSPADB8I82?=
 =?us-ascii?Q?Eav8Gmyx1n8c1t11FDCLlywmnpLXe+Dr5yzYqcL09Hd/k1sup6BaxwF4qac1?=
 =?us-ascii?Q?HQckAibUJ+1ffX1rDLgpnNeN6pEhDgw2KxNui1nLA6BOpGYbond16c1lrc14?=
 =?us-ascii?Q?BmnWgE2/L4A8ff61r4pRDmMp6Jv82Uo/r1ib6KrXWMrLdKE732P9ampfziA8?=
 =?us-ascii?Q?Hb8Sonct1MoeOyQoS1KFFYM1+9nJ+pOXcMWTCNMr1ODf7psW7HgKqqqZKIqU?=
 =?us-ascii?Q?9/dzlja+iAOjI8Aw0PJRjDbOeIEfbnkxxJSXbiWND261ye1PbQ970ERqE4kx?=
 =?us-ascii?Q?+8swGVBmi2rgC0S+ko4KBMoXLHPJjxTM91xmBpwvO8vMz89oHT+7XmO9h9nc?=
 =?us-ascii?Q?FuXDsvaev2Qch7LCpQink2keXyUynt3eRtkoGCp+cKCC0PX9YCsh0qEwce/o?=
 =?us-ascii?Q?d0RqyAxVxnlqRpMQIzPFocjN8VeWKg6a2LzC2sl1LNxHH9vie1zaZMklKo4o?=
 =?us-ascii?Q?/Sor19ci652OUpTLZM/nquAWGxUX3xSXy4raZwldOuOddFHv8YrwN8qy6os+?=
 =?us-ascii?Q?+fLvEVAkBRuhTnVraq+pEehAs5GTSRMgygQAWfBVbtu8tJlDUKcKNw8Xt9iL?=
 =?us-ascii?Q?AbJz84fxyAD4tHQTXS2Rr4D5Ove3vUrFSue2UwkxoynrJO9VtKpqyLBHUJfs?=
 =?us-ascii?Q?xZRQJqp13Ac5x6q5Txua2xh3bxcN7Nn0GpJqBHbq9QR/h818+22w0tlmOVf/?=
 =?us-ascii?Q?F1/5/VfwnY47TsAheCUax1uV0TCMiaf7RjjIWCa8s+c2QKxvA97IvzjfyrTI?=
 =?us-ascii?Q?JeQdShJPvLwuM8jtWrErqtHbZM1dzs3b3jy5accagWc+uwA5X9sC7Pz+ijA1?=
 =?us-ascii?Q?tqo3VZrENnBoQ6dH2Jsmy/sy85NsaJbd24Oue08JywesDyIWoZNeB5Wtkj2K?=
 =?us-ascii?Q?My5rXsJaELYKkrLVv6ACF9ewo7xNNvwhXvOwzsiUn4cyeYcejzQTifRikKlA?=
 =?us-ascii?Q?QTaZ3CRFAQVdv7AdlyDDYD7bRUmfi5k9HvBgnG1blzrxMKaFn/93Akk1VFiK?=
 =?us-ascii?Q?hhi/E8oGUKLHKg5hrsPiu+EixSbTuufBGyn0pmBNxOLyxChD5KWc0b1+bC5F?=
 =?us-ascii?Q?TTCW5413LJdJwHXWG35a/3l9i1mcbtnwTwLPZqC7iB8ZtRA28O86bfCl7swU?=
 =?us-ascii?Q?IGxcPwyhaGUGbdAbwjR64Fo+khBZM0cq0Hf5d3JEReMmJVllLRZlahVP9MFW?=
 =?us-ascii?Q?kwfG4bYxBrQOQkvsMgHXCMr51GkY12bVSTbwPYuLkHe6GPeXomIdWPfV+l5V?=
 =?us-ascii?Q?foV39ttNmMpcRnkiFsOtRosFyTfRdA9TrerGeHJy0DI4BsnyKT07pasFdLke?=
 =?us-ascii?Q?w3hZpt2HaNWoNhM30hOzYvMrIQRqqEkotfWvm0cw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858e985c-a592-4d87-3ebd-08dcabedd46c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 14:35:14.0968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/2f6v1Bvf002chl2OGEHoBnuJDg96BoyfkWVrNQR85tWM4DbVxuc3e4eVHYsZrjmfhb3Zs5TEIccZSW7l8LEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8024

This adds a new state for transports created by the Broadcast
Sink device as a result of scanning a Broadcast Source. Such
transports will remain  in the 'idle' state until the user
selects them using 'transport.select', at which point they will
be moved to 'broadcasting'.
---
 profiles/audio/transport.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 922911cf3..017e60fe9 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -51,6 +51,7 @@
 typedef enum {
 	TRANSPORT_STATE_IDLE,		/* Not acquired and suspended */
 	TRANSPORT_STATE_PENDING,	/* Playing but not acquired */
+	TRANSPORT_STATE_BROADCASTING,/* Bcast source waiting to be selected */
 	TRANSPORT_STATE_REQUESTING,	/* Acquire in progress */
 	TRANSPORT_STATE_ACTIVE,		/* Acquired and playing */
 	TRANSPORT_STATE_SUSPENDING,     /* Release in progress */
@@ -59,6 +60,7 @@ typedef enum {
 static const char *str_state[] = {
 	"TRANSPORT_STATE_IDLE",
 	"TRANSPORT_STATE_PENDING",
+	"TRANSPORT_STATE_BROADCASTING",
 	"TRANSPORT_STATE_REQUESTING",
 	"TRANSPORT_STATE_ACTIVE",
 	"TRANSPORT_STATE_SUSPENDING",
@@ -139,6 +141,8 @@ static const char *state2str(transport_state_t state)
 		return "idle";
 	case TRANSPORT_STATE_PENDING:
 		return "pending";
+	case TRANSPORT_STATE_BROADCASTING:
+		return "broadcasting";
 	case TRANSPORT_STATE_ACTIVE:
 	case TRANSPORT_STATE_SUSPENDING:
 		return "active";
@@ -679,7 +683,8 @@ static DBusMessage *try_acquire(DBusConnection *conn, DBusMessage *msg,
 	if (transport->state >= TRANSPORT_STATE_REQUESTING)
 		return btd_error_not_authorized(msg);
 
-	if (transport->state != TRANSPORT_STATE_PENDING)
+	if ((transport->state != TRANSPORT_STATE_PENDING) &&
+		(transport->state != TRANSPORT_STATE_BROADCASTING))
 		return btd_error_not_available(msg);
 
 	owner = media_owner_create(msg);
@@ -1281,7 +1286,8 @@ static void transport_update_playing(struct media_transport *transport,
 					str_state[transport->state], playing);
 
 	if (playing == FALSE) {
-		if (transport->state == TRANSPORT_STATE_PENDING)
+		if ((transport->state == TRANSPORT_STATE_PENDING) ||
+			(transport->state == TRANSPORT_STATE_BROADCASTING))
 			transport_set_state(transport, TRANSPORT_STATE_IDLE);
 		else if (transport->state == TRANSPORT_STATE_ACTIVE) {
 			/* Remove owner */
-- 
2.40.1

