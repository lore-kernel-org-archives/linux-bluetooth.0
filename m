Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD5B1AE860
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935773; cv=fail; b=uMKaWajNvFMJMMhL2i/kur7cD2Vt3D0aKb8oQh8xgJ1SqvQK/rwU9wE4iauboy60taQ0TSheCFnPXwFcK0TDg2BbJJpiCiENs4biva5o+sZquqQt+PcpTbXRo4ADEcsdaluboS9Xkgp88DPdXbGYDHPiQFzZtZmd0HvlgrN0mnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935773; c=relaxed/simple;
	bh=gKDyHTNpHEQoXhGeR0poSKbW+fu9XI6e02W16qKV1uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o5wIT6soZlCA73sgVj5ZK7+nuMWFnA5vtNcb6FiJLY8phnVb0eCPkkYkFBqhdTuZ/OUr+wLxGQpjHlt2GLgPBePe+1/X1+AOigvQv23+gfwC2TJCuO43dvEJUpAbu6gSNQ9INFxgJITpBL/dmE2Yigdw+v2luSgNr7At92uMxu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m+y417Yt; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m+y417Yt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBW/Z+h+GKnQHSFRyGz9OzYr+4LrrVAzsNymvD7O0Uhgnic99oVXm+7m3UHarFuiJfV0h0BG0h9E7C5PGjRyT+jN8rvkipjAKy1lzXY8isfaWRETxWrX+TK3lYH0T499nBTV6vNI0D3XWU/ErOUmgoL32nlN2/10jPAuQg7bMLB6+gFg55NeV7sEQop3yNW9zMsF5vv4dB2wh8b9GVYUeJs8k2Ohjcqv1JjCEpxnHWPS7G571eYy7Bmulcu8zcWgtGfYL/l9kC/UWmih2SAUBMxtqjxImV/icydhsdZpRQBKJNAFt+vPaKZ0IqG3ACDPe+/oQupsNkeysGYFpqIu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P78dLhEckEI7M9s756uuWK5zuiswAEtJxHVmG5ivHdI=;
 b=d8w5fwoKWsAwg7NDiFnL0HQ5lRH+lXg85usmTTwsmWOY36q3EI1Nst6eryiswAEq1+YGz1lpa1shkgafs6ESQWVI7c3C17a2XDWnDBbOPbkB+vIpndUDlNd63odL/ZKMR+1OATfywiUbQGLsuEGp4ZvL0IF3EckeVEhtJib+8UDheQM27HgpOF1GMjVQlJp/I1NYJyCussy+JkUr7fgybz5brhRGLW5SLp/NvdGOLfy2JXSUP404Bt8A1Y2jBI6N47lZ1KHC9GaPYC/W6i/a8zuVOy55x+3+4XhlTt8fKg7DcnnHzHfqyh6jTDS8FB6ygybt+1VDw/PfNPx7nGfrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P78dLhEckEI7M9s756uuWK5zuiswAEtJxHVmG5ivHdI=;
 b=m+y417YtMVeI4hBu1wy2eFn2y2sKF2DYGGAvqU1Zw1SMCMSpVSr5Oqx65uTk8CiFyxkCGqiuFvdmNCMbd11Gw6QCkYJZCpJ9uGMqEBPMly/QjIp01xWBSKA44euXC8PbiC2QZYtfYpYy7UCu/K315aYtqByafDfVnup7oEp1ZO7n9olLWFyMQtSRMUZmhdgUpF6ery/TSUTqUWKE3PvjUm/P5zH4lGBxjGwvpejOMt+GiBJN+YMNWw5ERcAGz0B5mGRN4dnS3+liGmVus1ZvGprKaDEwgX3wFLA6Sp3tn2sa1KbUzyvzlgAJNzdntRy6xdilx39m0f5tDk9h4e1fzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 12:49:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:28 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 01/16] shared/bass: Register ATT disconnect cb
Date: Thu, 29 Aug 2024 15:49:03 +0300
Message-Id: <20240829124918.84809-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0027.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 512c59e7-ba59-4287-497c-08dcc8290507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?boDyMaiR9VQag/PJTm15BFfrhOK+MAZ+k1FpGENdN4KJ8EErLNRODcWZ2Fkr?=
 =?us-ascii?Q?zj+3UUKdxbos7OErKsD29qo4rJo+y7B5tubrvgEzasmyJqTQoeEU4EEqvsFX?=
 =?us-ascii?Q?jFfsBVzbZ1uevK0xkZm5j/azJNaJAo+6jn3zURncEn2V4RrMsRfiZSNR6FfF?=
 =?us-ascii?Q?7RJbmA88wR63P6iPRktS5C6sSW4EPiIRBRz8m1FA4DQEpWiY1kFq98rHjYYR?=
 =?us-ascii?Q?DklW9FQN4Pm1HPLPfQS4m4WN5g6Fv8SFaVTk/RF5igw9XmAYu5uVBAJplJ9W?=
 =?us-ascii?Q?Lp4tMgpfvQZZqSPGEkcsb0OB3JCSFT/Q5coFdADYQDhoM5C/TaqQj0Clyp6Y?=
 =?us-ascii?Q?YUI7LJR1dr0o/L85o7llUcj35FZzKjxW2EuYN1DwNMo9UlOwkw0ZOl2KVT80?=
 =?us-ascii?Q?AlI9N2pGUkOivTiKPiH1x4gNFXNi1cu0XX48p9epA7umKlFHwbRqMO8ICFtb?=
 =?us-ascii?Q?wPIbcGJ5/AKq+ba+VQH0eUAxRkGDZIqyUiFV2GBh9ZkpGhu6WhYtAmbAb/ef?=
 =?us-ascii?Q?N3yFjQ3o2dirwrcuFW5GSzNjg0ZEWxlx+UjbXGp+1BuzoZCJ2dMuWUNtcAsM?=
 =?us-ascii?Q?/FoAFlxWa5m8oQNkR1X543rDShqS3KtBtA20HUf8cxJEPgtXmzWUo6ace21E?=
 =?us-ascii?Q?3ySQRCxoKygstp53SkgW5ZOXCi70MkX2mIMTn2akHTHz9jpHi5V8fvWmAVF7?=
 =?us-ascii?Q?KAMaqdFRfWcHEpCNyc31qLmyJv6T3ZvPaAlD9W/a6c5ZQ49Svyj16RwDY8BG?=
 =?us-ascii?Q?tmfUofit/onfdghdFEzusx/47QrqAnodk+qVlPnUD3qMkFnQP9KIW4QHnxtT?=
 =?us-ascii?Q?+JiT/5/dRzJ3MjhFAreLGHrbsF40RupryymsEqTD8gXIbnkXpvUWFCb/b9Jl?=
 =?us-ascii?Q?46xm4Y7u+G2Hp2GvNZUf5hJmElhDQ1GxMRP5G7go22MByVpzsCzmRu6bFtKH?=
 =?us-ascii?Q?I4q8sipRZ8Gj8/ulBs4lZxAGNDI8/2wNIjnsybmbi7ApJXqx5t6k44R7nw7i?=
 =?us-ascii?Q?cK56EIiHziVc3Q0fOBr4C/nPsdvrz1bvaExnDS2LyVBRQpXTNDovcFlvZgTv?=
 =?us-ascii?Q?+WaNyCGiypl4dD4W1fNrT/hW143qGEvVJpUYpBUEHFoyQwkGcljItePRQjBb?=
 =?us-ascii?Q?AjFgkCrcA9SO3hjBnrgg43mda1/Dh35SH7QwyInahOX6BTqjZ6+aRsmO5rSV?=
 =?us-ascii?Q?3ba40NiFR3+unfhf7exkghL2tt2Us7p3QgSooX28USelWq0izcBfqEg9ZewZ?=
 =?us-ascii?Q?rDN6LyE7lTz1KQY/wjjazpN/MCLL7feril9HYxxUgPn20yjO2s96MnhvL1Io?=
 =?us-ascii?Q?kiM1Cg2pv4C/U22Fxtek4kjS8bEymNnYwJuOYiKWtzrxTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lDAH67JvXVzIz5KN8aEz8f9UyPfUO1DxAVx9udBXk9j3zo1rdt3LWW8w7GQc?=
 =?us-ascii?Q?Z09habktWqjEkGxN5g2WjHaWxlK4c80N7i2YmybrmVIF7RW451oKvAU/zfpv?=
 =?us-ascii?Q?pJJiOUPjTcJwtZz/AjV8PXVDsNEpGU2Rxv7SkAEBGUUWyS/JEFFm8zfFsneF?=
 =?us-ascii?Q?jDAsggyKAhEUYeSlwCJpP0B1wR6XSsNTBWSPavsSuIP/vCnznD9A4lB3Ii2f?=
 =?us-ascii?Q?TmsnMpvjxrPpYsEEJE3PvQiR4DEo12DfX2sCvSwFHl6qQe+phBE084eG8J8H?=
 =?us-ascii?Q?nWwXpr6A/9uci2ACJxJoQG0Rtn7FqfXpJIRaZm1OMK/4hlNm0c3AS3qZ3SsV?=
 =?us-ascii?Q?p6mMRpdJjaKiKJ6k0sexP6kVA2jwYGECbmPdz2qBQ2VmEIoiQx/w4cM4rfbk?=
 =?us-ascii?Q?RUgQODfmqhdgixoubKOEW+FrD7KqkDGQbFYLewLJVcBc6dbk2X3agcNUMHvT?=
 =?us-ascii?Q?rsTY6bcObVr8nIPLKmCrhm7i4D7Er9WXCAKnKvSxejNwjPrERmeCRW36GI1V?=
 =?us-ascii?Q?x1dyLdl59J9CawpDkWqtKtZAu1geBf8FhBNUlCO/cSJqkLiobL1xRmhpzSc4?=
 =?us-ascii?Q?jQVx8FTirIRNRqnfB315im6Qj0F0S5KdxR6upW9CLYmgfWcxXGX6DqSDsnjm?=
 =?us-ascii?Q?8zjKySls/Cgkr12TvRkuO2xnrXlZEtQWJhO8xdJtS5co09j/uldqdf/LcYtL?=
 =?us-ascii?Q?k4qJlqql8X+53k5LZf5xdDJ91aP15On5YsTIwGsvFT7guA1GYBDCRdAoQNUA?=
 =?us-ascii?Q?M8AnhWvzOs9EkDoMehNTay5v1ZuKP0lCtWeM5f3LjGCRSPu3cbQ3dIAN7kLt?=
 =?us-ascii?Q?Mv8V7yiYFzLQyS9M9CFATa6JDST/YkeNKm6+0bmw9Vb2BNDD+pYCMDyrwQEw?=
 =?us-ascii?Q?Tx6wV3Eb3Ib1famY47BKUnfC1mJb2cQ34Hv+KGnlYlrbjas5lusf4PrYsi6S?=
 =?us-ascii?Q?2ocZShxqKwm32rXjYGs8kS5RfplZyAezFrUklZa27L3pcRhCbKpQRs6Qy7OY?=
 =?us-ascii?Q?VX0tTKPcG4nJsH/eEg46r1ICkJUXxes5kTo4NLTuJ5DCxvFOYTkxwRWtMzK/?=
 =?us-ascii?Q?88bkGJ2sfLkAv198jChqwyuHRKB7XxveUWoX7n7CEigFTD7KJlm/Suwf/v7v?=
 =?us-ascii?Q?Ozcn5LK+PlsV+GYo3aemohoBpn/HWbToyQAKttlh+cChYuN6Sp81C9oFnkCX?=
 =?us-ascii?Q?DWX7IG1i/ddut4u5z4Wqx2v7hqfhjeHdcTkCorFsLTZm3+zgFN8wKB002dMQ?=
 =?us-ascii?Q?C4i4tAxPj9F6cryIha0LrOpePIRg+tDuOZqOdfcTq6xE6SOyIDOh5eUwHaO2?=
 =?us-ascii?Q?4t3OXuQdTBolMtR/2y+/w/xpwpOvZ0kUldi+hjUhTTgnIVbsfkYluC5OTSXe?=
 =?us-ascii?Q?AEG14FKdBYWHpatzAQh7Rl3hyT+wKnsYMTUpZ6nLUsyTlOGwdVoFU0lP1Vlk?=
 =?us-ascii?Q?Qn5xyISa3ifkBeT9jOTPuheZHmtzCf+MXNanzhRHIZXoTCnPnvv/HqHPD1DU?=
 =?us-ascii?Q?SyHzRbMuLGsc/cCejkpba3Vdh7EH+d0pvCVROrGupeCEt63TOTwqZTbTOOTr?=
 =?us-ascii?Q?XYKwxzyVYPjwOW3c1yckrJBzlCGDmOkotwvRG+rPRBLXij3V8Qy26l2QfpmG?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 512c59e7-ba59-4287-497c-08dcc8290507
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:28.4466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7npcYYrSQfyl0T6QZTy7mLCM/AoY/drv6krQxRr8K3cB/D8NwXK68+z9KEz9m2Lkrne2v64kfsljNbjPKwmQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

This registers an ATT disconnect callback with bass, to properly
clean uo the session if the ATT connection is removed.
---
 src/shared/bass.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index b54bf3094..bf739526c 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -73,6 +73,8 @@ struct bt_bass {
 
 	struct queue *src_cbs;
 
+	unsigned int disconn_id;
+
 	void *user_data;
 };
 
@@ -1579,6 +1581,32 @@ static void bass_attached(void *data, void *user_data)
 	cb->attached(bass, cb->user_data);
 }
 
+static void bass_disconnected(int err, void *user_data)
+{
+	struct bt_bass *bass = user_data;
+
+	bass->disconn_id = 0;
+
+	DBG(bass, "bass %p disconnected err %d", bass, err);
+
+	bt_bass_detach(bass);
+}
+
+static void bass_attach_att(struct bt_bass *bass, struct bt_att *att)
+{
+	if (bass->disconn_id) {
+		if (att == bt_bass_get_att(bass))
+			return;
+
+		bt_att_unregister_disconnect(bt_bass_get_att(bass),
+							bass->disconn_id);
+	}
+
+	bass->disconn_id = bt_att_register_disconnect(att,
+							bass_disconnected,
+							bass, NULL);
+}
+
 bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 {
 	bt_uuid_t uuid;
@@ -1590,8 +1618,11 @@ bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 
 	queue_foreach(bass_cbs, bass_attached, bass);
 
-	if (!client)
+	if (!client) {
+		if (bass->att)
+			bass_attach_att(bass, bass->att);
 		return true;
+	}
 
 	if (bass->client)
 		return false;
@@ -1600,6 +1631,8 @@ bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client)
 	if (!bass->client)
 		return false;
 
+	bass_attach_att(bass, bt_gatt_client_get_att(client));
+
 	bt_uuid16_create(&uuid, BASS_UUID);
 	gatt_db_foreach_service(bass->rdb->db, &uuid, foreach_bass_service,
 				bass);
@@ -1626,12 +1659,23 @@ static void bass_detached(void *data, void *user_data)
 
 void bt_bass_detach(struct bt_bass *bass)
 {
+	struct  bt_att *att;
+
 	if (!queue_remove(sessions, bass))
 		return;
 
+	if (bass->client)
+		att = bt_gatt_client_get_att(bass->client);
+	else
+		att = bass->att;
+
+	bt_att_unregister_disconnect(att, bass->disconn_id);
+
 	bt_gatt_client_unref(bass->client);
 	bass->client = NULL;
 
+	bass->att = NULL;
+
 	queue_foreach(bass_cbs, bass_detached, bass);
 }
 
-- 
2.39.2

