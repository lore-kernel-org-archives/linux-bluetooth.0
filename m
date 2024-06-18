Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A2514B06C
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 10:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718706816; cv=fail; b=owApslLb76h14UkrpMMrOr8WS2/+ZpngZMUyKcGbtDTgrZDCPIgtDOUz0RzLYPZu+V+n1wer06wWIksjaj5U7JSAaPh06xZZxN+Lpwwk/2W/1ZMSSS0Fkd07UdGdUek1YU8r/MNlOsfsCf8fkhmfREi6M0iqdlmUWQJvr8XGIdY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718706816; c=relaxed/simple;
	bh=1YhfsDXfFhdcNMgKk7gcIgPjJp4cKT8bIeFcX3WirI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cGx1ZjW8Qvw/+jBIi5HqUTaWmyxMikEW3lAsjozntt6HjEIBeXvnXCQXWhXcGyl6JqD71vn/blKKVoIs3Hnfd2bwq1zoHlSHYqb8QN9M5e53niBhElxM3W4lFGNvoprboiRCp6gwTFv/1ZpnGcf5LN3UvkpufzFdA49OC5buOdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g4SqPT+D; arc=fail smtp.client-ip=40.107.6.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g4SqPT+D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3IkIdKlFqd0h59qt4Gw5DKQaqKfVeaOZkX9zLhP6OkmkNrQrTGw3uBM2Hsm2uOFDOzLMeyThBbTVdyMEdPY1kWeNU9cwxMWvluCXnAZjQGz6zaVYO7/Ds1GWwqFsYqpjhDhCkl8IoeErHyTD8nx4uJeNH0T8R7ye20H6zOpHYAEs5pxe7yBfiFTlz4EFld8X2mhzeMhpuNywrTUWE4GlkNINTcdAyqTdGPEdOgySBSxcdOHew+VliiOI6tbhJCP7MnzcZDBgbZ0RfVB9Uy9ZsiP5DjxsJlV9tYqj6NA06Y1/LTrcdJ5x1wRJYS/APqdD6qgpljNR6qOrXq0qWEYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1IJosmMIkb5BMbvricI6xjOc4fWVN/zG8npGMFTkyg=;
 b=LZfFwhFS/DG2TjLyyaSudqElbdTIK2pCq5mYoLJljZcj2AtJSaR0l8PLbUBhg7kmNPXaywZkiQRVVqksPeFG78V6EUYQA7Sr2+N8XlvGMKBKfkMmRTGsL5aA8cgN4S3LEqmEKMt66XLIaeIlJSaajaJ2aXgewlmyLGTA2CnuZRQXPGWDCkv6N2DVtrOonG3v8Wp36P+L05B/EZrK548HT7UDI46z61YrB4ySEVR7I4X7ltaoZDvEGPOp/KUb6kjkZVf+DApoQbkr2cDuwO+8QNgmsgrHEyR0BnagVSB0IUvce9cfB+IJycmFu2DrHaC+YXE5weiH4hItki2hDrGwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1IJosmMIkb5BMbvricI6xjOc4fWVN/zG8npGMFTkyg=;
 b=g4SqPT+DfqffnECOB6bypPteAqCjUEO0ZNp+cbaSi0U9kEh3EQOE70+w2q0sR+a0i9A2qNiQJY8WyWwiDnsqgRYiLDIcqXMLGfSfAKDjTQlBrAVGrLdxACKmulTRCw79SKSV7ejFx4JA65MPvQebxKyYRAJenyJeJueKe09YCx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8723.eurprd04.prod.outlook.com (2603:10a6:20b:42a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 10:33:31 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 10:33:31 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Check socket flag instead of hcon
Date: Tue, 18 Jun 2024 13:33:24 +0300
Message-Id: <20240618103324.15645-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240618103324.15645-1-iulia.tanasescu@nxp.com>
References: <20240618103324.15645-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0029.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::39) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: 30867b0b-b0b2-49c8-97f0-08dc8f82197a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SbK/12wDgEg4J4XbTpTUR/D7L2Op5jyvap4mQIVAj2ft85tfK6aWQfsh9MKT?=
 =?us-ascii?Q?T/Baz1O/z3Q7NiuPYrjEIAsbV7X+bTBBOu8bkkgEU96fnhiCTC0AYK3hlXuo?=
 =?us-ascii?Q?Iv6VzAPP3Vx83kG1Uy/BfgURfqr+NafaB4wZ9uXpUuaKJpXzpWEwz+2XedlJ?=
 =?us-ascii?Q?ROoHiTSptRzReQerb99Sb4op+fKlgVkrRlPfbfupjiaubtpnetR8ZVeXbQv2?=
 =?us-ascii?Q?l21YiHgJaijGRux7sYIj5ltS92fh0uxrVFMXc+shARGg13e+jjUxJwFUhVVW?=
 =?us-ascii?Q?PmdbNItoVOwF1VAaJxG7RfATHqmFdvxx6KcMpVrP42JkmoVearGnoeEZhQyw?=
 =?us-ascii?Q?m9svdY4IFAH6epYw/ipBHvxIQQfsPQwPd8n79LIKPpw1EI7ZdBi7zBJ9Juw0?=
 =?us-ascii?Q?VLRkaRoPGq2CXl6k1vzjrpFtoPWfakImGvsjjlyMu9wDyMPV9SVORgVih/9O?=
 =?us-ascii?Q?d2mtTn/Ca96DUEwvtLhwzfax+0V8kMnmNxNH5E/dZQsTQhnQrtMoT7F2C4Gd?=
 =?us-ascii?Q?9q+Hy9jdnzCKurMstWVfQ+ASitbLfgpvYtTm7ah/0v2cJzvsHeEGjjdQDJXr?=
 =?us-ascii?Q?MjhbgGv2MZnFX79SA08Na1Sw7CkCHkj3Mn6Q5nJcRVHSD3FC/rcMQaJ1XZ/h?=
 =?us-ascii?Q?zboYsdFYirzSgwvQBzlNgpJOStBBl9r8qgnsyW2cZY6AJ2R3SiJGeIu9afhr?=
 =?us-ascii?Q?xrJFUN4piWnntJ3a83Tg1oyC9ACTEDa0U41AqxKtRBDQyjV/lM06e7oJlTxA?=
 =?us-ascii?Q?XmA/xQpGlvlArpBIo/S+/MLYpy9b3PZYyeuSPCbY6U0TaSErNAnk5eCjcLVR?=
 =?us-ascii?Q?fmsbkz8wIE9Sntu9Mj8k6MRaexF/4jDsoj+iWLgHCf9gWI7Aj2IDhHHR906k?=
 =?us-ascii?Q?x8qv4fUc8lD9Tjtn7vRxUJUJQdalPsH3ZxNlJcwKBLqzGUzZa7g+G7EgWES/?=
 =?us-ascii?Q?wZdX8sIE0TbhisJE+yJWlKvqeAZ5wMtt5OUmUPL4u41B/yNSGQwbacaSwYZd?=
 =?us-ascii?Q?ay5B8/rlbRZmZtrJGlXZRLAZe/xyMjk2AVdMSR6r5ALOdsfhxml8Z1Mq2z+t?=
 =?us-ascii?Q?fgaLNI662KXHosOu6pkhCP/1LS5VDSquGI28MeWsKVZYFS+gF1wWKpShfdP2?=
 =?us-ascii?Q?nxA6VO/RrV2XvHpGXpxH3JgGZEtmWYi8+D/O3gJuDaR2GRI7XLSlBI5rmiOZ?=
 =?us-ascii?Q?RIoofeWa97qeyno7lyh55bIrGxIs8wMJkn7vFMR844BB4iA7lA/KuC3TZQxW?=
 =?us-ascii?Q?2rLceo6cvthn5XY/UelKRZa67XgvelI77Dq0168UGaEx9VBJXYrShm30zjyn?=
 =?us-ascii?Q?CbyibboAuW575euRuYqpaNcV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bp0OHkB/EMuntjoKXHRAc1UjE3xEKljYSfFtI7SxMadjQTi9qmT1Jw+KLBCV?=
 =?us-ascii?Q?0MI7Z0SCs0GaEan9ZIrddnnJX0W31A+Rr0kMcYzU1ZeOc6ahg6eUcS60Jcj8?=
 =?us-ascii?Q?wjzymYoYmTra505nBeQlTK6jOUB3mxcxbMiArZ1Gpnl8zj9qDfE9j6sRqa8N?=
 =?us-ascii?Q?StRviFHSynLvm3DfKxJgzyneO2ZSLAB0WBuHXXtji7ynjA+aYEWmMybelK9y?=
 =?us-ascii?Q?Eq5W9gwjEn4uQjVR8dwhNM9iVd+b12oa96zO9QiIFI4smp+Zlc1mo7hD3aeq?=
 =?us-ascii?Q?QyUSokaV8Tqqd3byqsi4jOyNzWBczN+Dt6+30MXsFjFg3Yi6PnB12ybdKprT?=
 =?us-ascii?Q?/L+BiZxFUw7HLWA8K5DIrLjjvyFe9t3hPjPbFompgp483IXrTJtykGrFmHE6?=
 =?us-ascii?Q?E/ijl0HMZ4jSaMLyPxHS9Sl0XSMJfQseGsJ9gJay11OZkPC5c3I5Wmh/Nyp0?=
 =?us-ascii?Q?pPhfMgEG52mKi8IaJl3m3M1FQXSgbMCP3PQPzta1IdIi+Old3VxXUuAHZD51?=
 =?us-ascii?Q?Yg/unHAP3cgfqTaHdc30mf+d56g7ZlPaaQpEiLjC/JZt4ocZ4l0qnCOIL3bL?=
 =?us-ascii?Q?TA/L0VHQX1oe9neWCMtorjCtTE3Ogk0ouPGSidT7COjhz79s9hUsxnkqYh3R?=
 =?us-ascii?Q?r6BMKaHnNUWoNNok+dRtrDt6LlgjJRbEWknV83lYrZD4YbDObAmDjHiozdKC?=
 =?us-ascii?Q?hhRbYIOZpJFToO35ruyRHA97AYZFrf+FRWUG8NK2IgcFL2w8jzSFzPD91QBX?=
 =?us-ascii?Q?6PTYAuUsN3Ds0POVhk0G5fINbr+sRmqh+/W4cxSYPlpUR6NO1yo7MmwgI5Dk?=
 =?us-ascii?Q?2Hq/IOQ2FWaABYHuwjpnOT7cuQLt7VBrs0nviMENB700GA79yNAvj52zI2b+?=
 =?us-ascii?Q?hVhmqNY9IC7UC5LGdOKkf1oYF5Cgaw+Ztlrlz0oy6MuX+7zkNzcl4W/f2BXq?=
 =?us-ascii?Q?kvvefO9Tu/LdZLZHv6voZHjemzS4fsnCr5JQgEKdF8sZUkpUnMpqADB2hXNz?=
 =?us-ascii?Q?lmr/tYCfoGRlbrcotQ0ojJpXR+fSdEaiNLjJqLfrM4bjW9KNqOVX3p/J/d6J?=
 =?us-ascii?Q?sE3BRWxF12Hz7rnUnW3lToV6dQnHE6WV+8XegUOJqi8w/sgrBrWUKz0VOq9K?=
 =?us-ascii?Q?0W3oG7mT4LnTK3D5f3M26V0W73nc35CmzzAYLA2cAGvMO+7k6XrUdQ7Hz/O8?=
 =?us-ascii?Q?7A21ELorDCFC/bQv/CpExFfY1tf+2c1pCEOpP+taVTi6MSXTtK5nADa8c0F/?=
 =?us-ascii?Q?rHLSnnTvqiDx+WyFfhYeQdNLr0gqExJRBT9EIoCQgKTKjAoTQasdjX7NCfaq?=
 =?us-ascii?Q?6eLexPMSLQQgXV+Aqgws8CvgKwJp6bZ/tsESsFVlxGuvPn/whGy3l21eNt7f?=
 =?us-ascii?Q?zLFk4ZACiXAvm7N/oZn7NGC4zjCfmuwBWGMQpy1gfgfvO52UDLz9N9YlPolq?=
 =?us-ascii?Q?1G7Veod79cxX5fgG+pQcmRuFd33CGAwYZQkmH1SxRuhGBiZVb1zjKWKTniCS?=
 =?us-ascii?Q?wZK8iLR8zWBZebSQ2KBzU/Kb0FOiLci9EfR1mCywguageZlYWofJE7dUqh79?=
 =?us-ascii?Q?h3C9WEXq4zJtKQ5E4qFSh4glblOPZS0wbrtyMGlrC3KzTJlI0acu/F3cUXBG?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30867b0b-b0b2-49c8-97f0-08dc8f82197a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 10:33:31.6632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRBFdzwMEXPwGsaUZ2ApqScGVkyAMCZ0GjlSc3OYhez91uW55kxCgSux9LIr/3pbmcc9Dvf0JUHBBx4l8bayXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8723

This fixes the following Smatch static checker warning:

net/bluetooth/iso.c:1364 iso_sock_recvmsg()
error: we previously assumed 'pi->conn->hcon' could be null (line 1359)

net/bluetooth/iso.c
1347 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
1348                             size_t len, int flags)
1349 {
1350         struct sock *sk = sock->sk;
1351         struct iso_pinfo *pi = iso_pi(sk);
1352
1353         BT_DBG("sk %p", sk);
1354
1355         if (test_and_clear_bit(BT_SK_DEFER_SETUP,
                                      &bt_sk(sk)->flags)) {
1356                 lock_sock(sk);
1357                 switch (sk->sk_state) {
1358                 case BT_CONNECT2:
1359                         if (pi->conn->hcon &&
                                     ^^^^^^^^^^^^^^ If ->hcon is NULL

1360                             test_bit(HCI_CONN_PA_SYNC,
                                         &pi->conn->hcon->flags)) {
1361                                 iso_conn_big_sync(sk);
1362                                 sk->sk_state = BT_LISTEN;
1363                         } else {
--> 1364                         iso_conn_defer_accept(pi->conn->hcon);
                                                       ^^^^^^^^^^^^^^
                                                       then we're toast

1365                                 sk->sk_state = BT_CONFIG;
1366                         }
1367                         release_sock(sk);
1368                         return 0;
1369                 case BT_CONNECTED:
1370                         if (test_bit(BT_SK_PA_SYNC,

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index e439c5d15092..d5e00d0dd1a0 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1356,8 +1356,7 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		lock_sock(sk);
 		switch (sk->sk_state) {
 		case BT_CONNECT2:
-			if (pi->conn->hcon &&
-			    test_bit(HCI_CONN_PA_SYNC, &pi->conn->hcon->flags)) {
+			if (test_bit(BT_SK_PA_SYNC, &pi->flags)) {
 				iso_conn_big_sync(sk);
 				sk->sk_state = BT_LISTEN;
 			} else {
-- 
2.39.2

