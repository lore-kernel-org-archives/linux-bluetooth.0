Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2049.outbound.protection.outlook.com [40.107.249.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FE81B251A
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252178; cv=fail; b=i1IZAWYKHBMmGGLk9OLoV3vrrHQF5yhMOT1aMEz7+6XroQRCpjGp0RpndMv794cU7YhwBostHZ6RI+hCb+7IFeUz7U8vatNxATQYuI6F6cel3TdZkIfd8PhSH0BdOZFdi6vMXYVgjSrkHa3s9D5t8n7Bt+8UUkkasjRCAokOsKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252178; c=relaxed/simple;
	bh=7wljWqM+DduSEhbGxSGUs9FE3cXVuqtg/9T3pA6eiw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HzLmrfikGR0sIyM+6pb8eLKMI27X0oy7RPvSkwjGkSBhAyoOqTMGSQsPwL32ozlv+8LUueNjJW9L1CLcW3goIZIrSEYLEEiFXnSzCaGL8KOMBV4mcwJXf9sRmErkqp524SI6nhdeonYzrzlYybXSCOr1r+6KpkP7/j70Bc7auXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mwCD3e/t; arc=fail smtp.client-ip=40.107.249.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mwCD3e/t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzflSlwsV/T8A55d6JaLg9HLoDMdfB/EImgo9DZDcX5TW/gmpOZiSDkgPk86UxvIgu3LGYfb4+8h7J28W7w8XyDE6HUI7ySEeltJF0ae5rnp74SmR75lIxcMsdhgs+Bl+i7FwX97TThobAri3FIrlkQlbxbXcbd5dDaVRy+BcBMafJUMPPvygkyWEI2UbG2PERgE6Zq7nUN3QhfKN7h1eRHIekBYYnA7oBe4U3ObcWrOU4nn1DRBya9rtbYUOzzLd0T8pjVf9Qn7PhuG141vj0nnof23fl9FK5uoD0gngmI+NwEfgcg8xorUXKcshZCwHkICAvdotILbNaA/HQ2i8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulpr4fd48cl9mn9/fvY7mhwDwyPXBEejMRlWynTaFq8=;
 b=w8r83jF7vFoOabYSopF/I9DR0g9LlxYLnVgYu47kJaWMGYxMckSPgCLWbgDjiSvJwuICLIYEMNd0SLFYJ0fEY7v/pviqKauXrhzUcaZQuHtY/8+uioNTTeIp0hp++lL7kuzi4aCLu18ORoB1wdG3VYcd29Dq1gTPJvbauVk7lRbojPLhQN6WFqDMlrDSIin7nnTGxJxRCfjq5HzDh5rr/NnBbPeAV4yw8XzgVcaq3ao+eNmqPxvUbWaOLJpCyFAJ3YuUHdwzGmFp8sMtbvNfwzsMSNfgqkQfnU2WvI6tbkVwMcstaI2xxVJKMHuO9Djs6dJKLneD26dX2PSUtRAEow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulpr4fd48cl9mn9/fvY7mhwDwyPXBEejMRlWynTaFq8=;
 b=mwCD3e/tIkzVe1QuyahiYDWq2wSUwZjH3cxpl8HtgW53079XzwL8FtymvELikoeIGxLCO7K2bdyxQLCd2f11TlbTdmteQf6HH/tltNK+amydKx9k8KJseRW6e+QJx49bFrHhDi6JiMuJQglaoxP8RxKBUtyXuhFKTtld8rviVciwoGb4HLo0+kYk28GhgcS64g5n+u5exvbj+DOmqNzz01svVmEQLJ2yxk3dxiwTxoYABgmcewutwdIyWwddsrld3s3rlbxEuSlQSDjXjC20FLqPTTAHTA5xXqntSV/qM85hxMJa2KDI5m27BR2RkJR8bL0N66D8C+CDXc9WG7J6hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 14:56:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:14 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 01/14] shared/bass: Register ATT disconnect cb
Date: Wed, 21 Aug 2024 17:55:49 +0300
Message-Id: <20240821145602.92083-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 709d3565-455f-4ddd-db9c-08dcc1f16712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+wogUjWwkXEy1BGuzux25uTnverAAXn9MLPPmoOghlAlUhsj4+m/ik6ueIaI?=
 =?us-ascii?Q?+MlpLTTSpHSc+QXqFN3JRbhxZYG8eBHZIPEZobXtRVMibWIgqxHakfwgOMIs?=
 =?us-ascii?Q?lKpgl4hiTX/6k3r20DBrbgLg5J7ZAmBCGChpdTRjsVr1+0Um9krj7iCB/fNo?=
 =?us-ascii?Q?7WLVGH8e0udedL5gmzi8dRJH4GbnWcgmi9Kz2kRIwwLgs1L6E8AVE7Elon66?=
 =?us-ascii?Q?GyVefySe5fplo9LudS6wZmkT+9Znm5HWoeaIdfZhnA81dMKveLaztWTroYMy?=
 =?us-ascii?Q?fG25fr4mIB0xFOmtJ4ck2f2KP8NfL4axYK4l8wthFElVacRlrDULJKj6nDsy?=
 =?us-ascii?Q?wzwxxCdHWSKg2Qx3ypVYmEG34qJNJ2qKfxDmIz3w69iNQPDmq/B/sMnKUa9e?=
 =?us-ascii?Q?gOV1pjFggG+M7f+2/qBiAgX8Gz931KH0HPTUSVvE12XlQ6U85qzYAJZKQD3V?=
 =?us-ascii?Q?IKN1kExHjKzTmKOeJesE3BrRHLYK4p1SLJrxmCWRH9uuxvexO57uudf8xQ+9?=
 =?us-ascii?Q?Vj2PD/0guH8LzSHlwdq+wkiZhR9xyh4/qQW9yFe1vHy4NbEeEMCSghb2rFlR?=
 =?us-ascii?Q?4DqJkRWtCOS9W68eeRi9uLTfC/I3YV/IwV8JxUKPB4OmdZI26iioCVZXsrMN?=
 =?us-ascii?Q?/RpWAN2j6OaR7ixAJP3XXDpt1Xd5KWX6fiG6stnicPFnP67F0yd5n4bA5gMQ?=
 =?us-ascii?Q?JEU+RErc5/XtEoSv3vW+evgwBCI5VHv92rlScbx/pzV3SDeGYfKFzw/OqWsI?=
 =?us-ascii?Q?UdLh9z4N1VHZE6ICIkiZsfGq0+fKkpqhMggQebTITXuNVyrrACPB3vHiOEro?=
 =?us-ascii?Q?SARkiuJmEPmiAtxqrnZA2SHYDQn1JNx2Ja08CRhNaUnGRrdaKzB4/eVqIAmt?=
 =?us-ascii?Q?toNJrLgsYKROhE2i9SdbHyJj66lpRsndvzIEcfP9Oe53UMCNrlO+GkkZTZry?=
 =?us-ascii?Q?OzhiGY0wYosn2Qcg+TWy0CEOJGF+Qi/QnlwiC1QAN3eW2iy82SwmoYa94VUD?=
 =?us-ascii?Q?ybISWFWDGuqaakdQ5n0JFtI/Hh04JH1XZMMqlH58Jajniei1VkI/ouWdcUiR?=
 =?us-ascii?Q?YAIAtoRbKIiaN6j/WiONsD8ylTauROLc36VkfAbLmC5YzhzVhBOujJJftwAc?=
 =?us-ascii?Q?/PgCUtPp+UBtYJ2pwv3Pp8B5S0sTSVufxUxfIhZcmFyYM5AT9BXEtTjkOsNS?=
 =?us-ascii?Q?eKlk/Y845nWr4Q905CtmEp7AtRPTDhVBPZPGfOWrCVoTgrUFEg5ETSxZtkWl?=
 =?us-ascii?Q?rgzJopCh6sVx4Uzw2kx0hJj1PDPPdUSuuwoNOzBF4BQkPGXX4UUDMVugJ/zV?=
 =?us-ascii?Q?L04mh5eNIIqQNghXwNkb8QR3iuriDMhUdpkYd0tHC7fWbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P1Qo8hqGFF44ZM5W+4o3FqVr4GIFIax6qyHPPyf8j4No9bQpD/Hrc3K4AMZB?=
 =?us-ascii?Q?35/DakKSlU0BwidHdwhK/SLUwb39w/DcELdGIS5DDtNveSwz0tSTKIAh4Euy?=
 =?us-ascii?Q?+yJCayF4f1Swk9tG8ek5aW5sCCtBS50d+9RvIxhZWgpDMub03gDFjxQFUXa7?=
 =?us-ascii?Q?w7lZ5PfCHrVyXebdIxo61CJpj/24r7iS3m3qiUqCU2BBdlxRzpEpLhvHGpg+?=
 =?us-ascii?Q?Ubzc7x6l0IwLlZNkY7XGZnxz67pGCfi0cfQlrbXm/96siDQUsOgSjTQw0NBT?=
 =?us-ascii?Q?g/Lp7TlfSP2qzED9QmlcCEcTzn70Jtw6TdTtZLk2Spfmx8xYdHUpkdYQQb99?=
 =?us-ascii?Q?GpbF7D0hgJpUqIOVzDpOjv6ByWS1Ulf87cENeEvCAK43vWxO6jPMW7RYlEPm?=
 =?us-ascii?Q?OtYp7SoTRUrU3ntFnQE3g3k5FDervSl2CbJ64cjhS+S5jiIJXK7PUA6LU4BK?=
 =?us-ascii?Q?8RdJtZp0InG8F4Bzxw9u0mX4fcVL3PApyOkCcbk+7UChvo9/eA5Ozzu4g/9V?=
 =?us-ascii?Q?GucFwgQHeroHlBLL5fTfMyLUN1NBoRYPKiBEJffKFjlIxBPOKNeHEvmI+CXC?=
 =?us-ascii?Q?gjRllGIM3md0/+EyRWxvO3eHv2FatFYhKGuoUto8lOlaV/BdiEw90m+4a1Dm?=
 =?us-ascii?Q?l4vmEZNW2BRTNBRcmh5aEohtFt58OlPvIF0YFhdwhD73aJHIh07Z3M8lswWR?=
 =?us-ascii?Q?AY6QYEBkhtrgd4+T2KG/VsapJaB2cNmGX7FQ8WxtGnhipuaYahfYpQ1mQsPd?=
 =?us-ascii?Q?1i7L+B9QXPKC9K2Y2M/x4vvwNeUyFk9sM3+VR7j4RMYQ4tba+oJYaNqewU0b?=
 =?us-ascii?Q?SNKL+ujtmhFfMqN3hIDQvMICCfK2Xh05pTH6lBL+v5tSLrtJqY584lGLCPvD?=
 =?us-ascii?Q?E8orVwE/ZH9VRcZLKfef7F9e/jugUqvjuvdM010+cW8r7rx+nEkIfBEkHgSo?=
 =?us-ascii?Q?d86f5muBvZ0DQkMtXxsAHovi96Q+Uq/0x+DYmAZQBJy4YoQKtzqtbHt+GXA3?=
 =?us-ascii?Q?t+96KjElihqy1eE1Ph36RdDTW42hsPqf0Tu+4GldanDqrYNd2p+S//s2n4lu?=
 =?us-ascii?Q?CWem1zD9Ys0ofqpMgoDYEfIr5mIpQwpd/FFsDBWV7DGys+fWOZP4Wqw+tAit?=
 =?us-ascii?Q?DQiEQklSRt9KpW96x0KxwoGkIE0DUhO8O5qyJv/bZZ/hoVctMuCn5hP7H6sE?=
 =?us-ascii?Q?uZ/Ccz7AKoULdPmwTKdbTbF++ywz6xbS3mwySG7lVxLXir61qyzmuRVtv9wE?=
 =?us-ascii?Q?ayIUS4reMbAUhRApcHSmOKYoA83dB2ZeO8XmFRCNb3mvs2MWr83LO6CvcIFe?=
 =?us-ascii?Q?xfb9d2RrFN+7RUBW1FB/boiaAzyKerJGyVW9P4o8s6U2vfiwiB0Urt4xtZsw?=
 =?us-ascii?Q?tuPCI6jZGBbAIHaJ8zbVl86SXY0oL7L1tM52TD7en7yb0+UBWzVOV3PQwKWW?=
 =?us-ascii?Q?SduUSRmhEgHgLcNE99BGl/cKsoax0bKpsB29bnx+mMX0q/LErRoi2UqugVvb?=
 =?us-ascii?Q?fQdC9TeUBeXPMJEO8BMiv9ISBvv2TVpKkRJ6Ou3ynmlrcvNJd8RaLTvKebog?=
 =?us-ascii?Q?GtZkaS+cIhCh0tcRSu5Ghr0lfjAqIoo36CG4AotfqCQQKmaRXZ0tzqQWNkha?=
 =?us-ascii?Q?4A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709d3565-455f-4ddd-db9c-08dcc1f16712
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:14.1105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RNxpLs52EDf9buAjyNCYDcNO+lxZr75XkdHWfRmcnExKD669HVgSqHWP4OpZ+s3r7J4C1Ilga7tV7cngejXp6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618

This registers an ATT disconnect callback with bass, to properly
clean up the session if the ATT connection is removed.
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

