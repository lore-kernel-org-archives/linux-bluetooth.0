Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77957EE49A3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 15:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236852AbjHWPLu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 11:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236854AbjHWPLt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 11:11:49 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE8710D
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 08:11:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbJ7xihVsMaQq2PFQZHSF8FEwMYxqqLmBKBT4K5qZldIxVcElW1yO0SAixs3raTnqx4Tmm1uBraLq2NFs/VgNh4hJAcqZZgAzW4csuIt7v230pActaaA9Iyog3ymApuWMEfCjktZ0dhlarFVc+HsayoEArMR1wlgoS8u/EvhpMgsdGbKCfje0ybm4OfA8NUI1vEjQgPP1BINzUTo4vcnCxsMdMDx7DzNUG5676Ly3nqWjZydyx1HtBQoYXRwkOYocw+ONNUQTNjTCGt/NtlXFS6a6y20fVIaVe92fUC7Q2V6vwQCbvgJqOhXvZ3rscdSTyzbspugpsKQb8y43ugcxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHvtNwJDmijXkVXeIQEuuoKreU3E3O0DydmNsJKh9mI=;
 b=ME8txXR8zJ4pbyEwszIJe37U6Y0g0WxFaxYX1Iuu3D1EMaFQMRHUENcjHoWetnhqjTEdMD0mdKH9FdFpFc0SQmldPRelbOrSK7MR5blbqxDsNjFJ6HG5psuoGQUG+99skc6IcHi/xMAz0gRFVKUOEI82pLZhRdCmXuu60DdCOJOoQFgduH5Ak3MAHfHzrz+yQ+KQHcB6fyAcqSC2xTyBEBFuHV1pggElrYfNckmWNwH5ibD/8kFXztqn9HbfrYFXpGi67C9BpH4Z/Yn85VhwQEqkmnHzEcSy3DCxG20xE67y8JTnTxH7scc+2jrs0QpGHmHSUUf13zKHeytbQcSRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHvtNwJDmijXkVXeIQEuuoKreU3E3O0DydmNsJKh9mI=;
 b=hDHaPLv6TLiEpeZBdOMbBQnt4JVml0aAEV41VZd0eAzo5PoKX8T6pn4uyD01I97VTCb4bnIEsNgHgJKN5lzrL8wa0Bc5YXLpg2Glcq2Jfg23sIM78zEtjGaHyKlk64hR5I/ye8pjhATMF0cD1/QxGSQLM9PZVsI/JCUDJu2j1/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB9190.eurprd04.prod.outlook.com (2603:10a6:20b:44d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:11:45 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6678.031; Wed, 23 Aug 2023
 15:11:45 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] isotest: Add defer setup support for Broadcast Receiver
Date:   Wed, 23 Aug 2023 18:11:25 +0300
Message-Id: <20230823151125.16100-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823151125.16100-1-iulia.tanasescu@nxp.com>
References: <20230823151125.16100-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0093.eurprd03.prod.outlook.com
 (2603:10a6:208:69::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB9190:EE_
X-MS-Office365-Filtering-Correlation-Id: 848abb9e-12a4-4ca7-5ebb-08dba3eb43c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1YrfHO2O8iUef4ItboHe4cFlWwWjs5iry2wMvBWPkWuXqi6qoIcYpnvmQd5nReXa+RvDvA+yLl8d/gGV7784mn+IyCxzrWZbj8rJLo+B2vW5oCfTU8Ntvj5dKY8h5kqJe/wvz3qLFINlOHiU9Z7BXMATFoGtfhqhHLXEifNfDurxWZiDuDdD7KPrMva9meahqWcpVQsmfpvf3CWRS4HnH2MYFQcAzZ1InX+9kq0alFaq34Oxk4ZniJ58exgofIHYKvLnxKLrevlN3ZR0TZGcVGgrUAAOzgcnP8YaLj7u+O/u0LsaU62MFY4slWsYiEKNobUd1YyU8OXgM1Tg8nJaYNPzYmSqCEAVxUk3cqb2q7k4n+HkZZR8ljPq6NEjTiVcv2cKP/4pO7lpwPTfqBU+ZrINV13yXi/kkmVSWm/sop8IWJ9p49JrUUOLgKkl6KN8+bYmRxSBYThBfIb4VRBa/KrSNtgzShCu5yn8eTCzPJuV6KloDzctaFCZjRYolUZVLQvRzpC+PCzw7KG0sf/pi4Zh3hgmXZ7gMS4JPMgDjY8Z8Yo2QAfa2CMtQoDxbA94H26QBkCrUsuBxCipUx3+CFLEjl7WQ2bbL5a8kwDYbkf8+mfGDzgyqwBK6LUXpV/1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(2906002)(38350700002)(52116002)(6506007)(38100700002)(55236004)(6486002)(83380400001)(5660300002)(44832011)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66556008)(66946007)(6512007)(6916009)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4P8lOw+nGQpt8p94mBd3fdiO/veTWTtyHLJLVqlNXZ68KZK2NpwCzWe2iFJ/?=
 =?us-ascii?Q?KCPT1z9pDj1m18BAAaFLxBTE12cvIJdOW2l+qYqlTQqdLonPTh3djcXpDhiz?=
 =?us-ascii?Q?1ZzwQNgwOWRrihMGhn9g0k3cHDNiXZz05KKIuVBf5fXlCXIzU4cs8xGPnwux?=
 =?us-ascii?Q?SLGJGiZXkzP7XYzyPxDZbnj/Qol7gADqgHBy+HhnMURNWLf3RIjIeFU1jxJx?=
 =?us-ascii?Q?IzyUag/nAyG+fd4m5rI3kezBcipQ3hfOEBitgn18YyJsDObU/H/tIcLXyPK0?=
 =?us-ascii?Q?HwAY7XaVgVndAMB8XGtpONpP7dCXxmUN/6ebdYOsf95oiUw0YhXFejKIZu52?=
 =?us-ascii?Q?y83bqttajg5Ixy3Dioou6kEmEeb8jnsb4I+Vvcy0L5QUonnwFIUUO55SXp9M?=
 =?us-ascii?Q?0wsMi1SEoky6NAA1WVVUGVp89idBO6xFcX02sGj0qWAxWceYwr0T1s7o9eAy?=
 =?us-ascii?Q?fE6peQDw+fsvHBg/9Ohq98fiBf2/Ef48nUb0+QFv2IA8LpOTW/IEUsZ7D0wk?=
 =?us-ascii?Q?M8xZVB3Ur/1REKLyya/exymlkMcU1kJHdLKgK0+Sr+US7jR3IrAhm2dT0Ckk?=
 =?us-ascii?Q?oX1EYCBdfzapgK8+ywwQJGtpHw4Lu+z0MrJwLUCT7tvUej6qvYTq+ZE5dPC9?=
 =?us-ascii?Q?Qf73bJ1TJ29HRTMuVsltuOHrlE8sbI6lcdfxN965EV5T/YTkxiVlNF5JsWLO?=
 =?us-ascii?Q?zZYAzx0PBU7vyupgGAIZSEoMByh7OyiPQukNCdN1Q6wP1uKbArOmT3iwVE8e?=
 =?us-ascii?Q?NsziAvZ2UlMdJ4srO9ufpNuYED7QmJnlchjbtjqsVNWeIXudMIu4bBz1tZdX?=
 =?us-ascii?Q?jIhjZmroJG6T3cE/s77OEhsVh9HG+yg66RaOkudWEymXTuuIQtJIOiSYQ/eJ?=
 =?us-ascii?Q?RpvxAV0Jhp6OW5Zi4rlB8JjC7MnQW5rWnZB2JYdlJZj1RpTnj2Zz0wpm+w+b?=
 =?us-ascii?Q?0DPg8NDMFadbUK7mvz+0VImuQ6BznS7zICN/lx4Bt+W2i9+I/udqWTkh6Wl4?=
 =?us-ascii?Q?BXiVoyTP5TqgN9kAJbwRqda9VT3Y0Fz33MtSiQvuJt6L7gxdl+wKQ5u3XL7c?=
 =?us-ascii?Q?fk35K6EyuWRe38ss5MNXPh+KRiGg0ugs+uGLHdSheOt7ATZicROthj+nm7v/?=
 =?us-ascii?Q?9BDi/TsF/0r65L/atjz0Wh8w74yAPHhUDt8iIEzuHgQy48KN7SuZQxo4MFAq?=
 =?us-ascii?Q?wPNmtcifjtEPcoXQH3Kx3YU03nwczlVrauxuoSMSk6l9slI2uBnN7mCF61Lv?=
 =?us-ascii?Q?l5eQ37RKj4V7tS1yijtMAQeZ7Ucc9vaABf0LjxJts+FQA1fXrJQvxt/ThzeX?=
 =?us-ascii?Q?p1Zz7s6rTWRQdtbueWrI61qIKiVTbXh0oSPKQ9c1c0NSbAqOmtUa76EML4h1?=
 =?us-ascii?Q?c+haaRuykWaHppqFA71n1gDxv1I/SaELAYW7zPRqPV3MkmF+4ve1IF1uRddg?=
 =?us-ascii?Q?knmE0uPBuuJ/0qLt4dIal3b38cUGqfBfp6c3doNLZvSlwcY5EnDLfj6u58wu?=
 =?us-ascii?Q?b9wX/7KUGYnyWYq/eChzZZsUPfsC+80L/0GAEjM1I1bwo9ZCtjy2Ay5lmLpU?=
 =?us-ascii?Q?Q/QgIeZ0AYsKEE9iVWjNizGgCrjlFBnss6PISi52P7FvprtI/pnuiZVdYLVw?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 848abb9e-12a4-4ca7-5ebb-08dba3eb43c6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:11:45.3982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCaNl2d7WYSOLhUwR15FM0qmeHJ61o24iaBSw1rV+P/pupcB8cLADwF+0TyE2nLg05hi9I+FBaIUYfFf1jjeww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9190
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds defer setup support for the Broadcast Receiver scenario.

In order to create a Broadcast Receiver with the defer setup option,
the -W command line parameter should be used, as described in
isotest.rst.

---
 tools/isotest.c | 122 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 42 deletions(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index c71bc6fa0..68729d977 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -434,16 +434,60 @@ error:
 
 }
 
-static void do_listen(char *filename, void (*handler)(int fd, int sk),
-							char *peer)
+static int accept_conn(int sk, struct sockaddr_iso *addr, char *peer)
+{
+	socklen_t optlen;
+	int nsk, err, sk_err;
+	struct pollfd fds;
+	socklen_t len;
+
+	memset(addr, 0, sizeof(*addr) + sizeof(*addr->iso_bc));
+	optlen = sizeof(*addr);
+
+	if (peer)
+		optlen += sizeof(*addr->iso_bc);
+
+	nsk = accept(sk, (struct sockaddr *) addr, &optlen);
+	if (nsk < 0) {
+		syslog(LOG_ERR, "Accept failed: %s (%d)",
+						strerror(errno), errno);
+		return -1;
+	}
+
+	/* Check if connection was successful */
+	memset(&fds, 0, sizeof(fds));
+	fds.fd = nsk;
+	fds.events = POLLERR;
+
+	if (poll(&fds, 1, 0) > 0 && (fds.revents & POLLERR)) {
+		len = sizeof(sk_err);
+
+		if (getsockopt(nsk, SOL_SOCKET, SO_ERROR,
+					&sk_err, &len) < 0)
+			err = -errno;
+		else
+			err = -sk_err;
+
+		if (err < 0)
+			syslog(LOG_ERR, "Connection failed: %s (%d)",
+					strerror(-err), -err);
+
+		close(nsk);
+		return -1;
+	}
+
+	return nsk;
+}
+
+static void do_listen(char *filename,
+		void (*handler)(int fd, int sk, char *peer),
+		char *peer)
 {
 	struct sockaddr_iso *addr = NULL;
 	socklen_t optlen;
 	int sk, nsk, fd = -1;
 	char ba[18];
-	struct pollfd fds;
-	int err, sk_err;
-	socklen_t len;
+	int read_len;
 
 	if (filename) {
 		fd = open(filename, O_WRONLY | O_CREAT | O_APPEND, 0644);
@@ -519,41 +563,27 @@ static void do_listen(char *filename, void (*handler)(int fd, int sk),
 
 	syslog(LOG_INFO, "Waiting for connection %s...", peer ? peer : "");
 
-	while (1) {
-		memset(addr, 0, sizeof(*addr) + sizeof(*addr->iso_bc));
-		optlen = sizeof(*addr);
-
-		if (peer)
-			optlen += sizeof(*addr->iso_bc);
-
-		nsk = accept(sk, (struct sockaddr *) addr, &optlen);
-		if (nsk < 0) {
-			syslog(LOG_ERR, "Accept failed: %s (%d)",
-							strerror(errno), errno);
+	/* Handle deferred setup */
+	if (defer_setup && peer) {
+		nsk = accept_conn(sk, addr, peer);
+		if (nsk < 0)
 			goto error;
-		}
 
-		/* Check if connection was successful */
-		memset(&fds, 0, sizeof(fds));
-		fds.fd = nsk;
-		fds.events = POLLERR;
-
-		if (poll(&fds, 1, 0) > 0 && (fds.revents & POLLERR)) {
-			len = sizeof(sk_err);
-
-			if (getsockopt(nsk, SOL_SOCKET, SO_ERROR,
-						&sk_err, &len) < 0)
-				err = -errno;
-			else
-				err = -sk_err;
+		close(sk);
+		sk = nsk;
 
-			if (err < 0)
-				syslog(LOG_ERR, "Connection failed: %s (%d)",
-						strerror(-err), -err);
+		read_len = read(sk, buf, data_size);
+		if (read_len < 0)
+			syslog(LOG_ERR, "Initial read error: %s (%d)",
+						strerror(errno), errno);
+		else
+			syslog(LOG_INFO, "Initial bytes %d", read_len);
+	}
 
-			close(nsk);
+	while (1) {
+		nsk = accept_conn(sk, addr, peer);
+		if (nsk < 0)
 			continue;
-		}
 
 		if (fork()) {
 			/* Parent */
@@ -583,7 +613,7 @@ static void do_listen(char *filename, void (*handler)(int fd, int sk),
 			}
 		}
 
-		handler(fd, nsk);
+		handler(fd, nsk, peer);
 
 		syslog(LOG_INFO, "Disconnect");
 		exit(0);
@@ -598,11 +628,11 @@ error:
 	exit(1);
 }
 
-static void dump_mode(int fd, int sk)
+static void dump_mode(int fd, int sk, char *peer)
 {
 	int len;
 
-	if (defer_setup) {
+	if (defer_setup && !peer) {
 		len = read(sk, buf, data_size);
 		if (len < 0)
 			syslog(LOG_ERR, "Initial read error: %s (%d)",
@@ -625,14 +655,14 @@ static void dump_mode(int fd, int sk)
 	}
 }
 
-static void recv_mode(int fd, int sk)
+static void recv_mode(int fd, int sk, char *peer)
 {
 	struct timeval tv_beg, tv_end, tv_diff;
 	long total;
 	int len;
 	uint32_t seq;
 
-	if (defer_setup) {
+	if (defer_setup && !peer) {
 		len = read(sk, buf, data_size);
 		if (len < 0)
 			syslog(LOG_ERR, "Initial read error: %s (%d)",
@@ -1446,7 +1476,11 @@ int main(int argc, char *argv[])
 					}
 
 					/* Child */
-					dump_mode(-1, sk_arr[i]);
+					if (!strcmp(peer, "00:00:00:00:00:00"))
+						dump_mode(-1, sk_arr[i], peer);
+					else
+						dump_mode(-1, sk_arr[i], NULL);
+
 					exit(0);
 				}
 
@@ -1462,7 +1496,11 @@ int main(int argc, char *argv[])
 				sk = do_connect(argv[optind + i]);
 				if (sk < 0)
 					exit(1);
-				dump_mode(-1, sk);
+
+				if (!strcmp(peer, "00:00:00:00:00:00"))
+					dump_mode(-1, sk, peer);
+				else
+					dump_mode(-1, sk, NULL);
 			}
 
 			break;
-- 
2.34.1

