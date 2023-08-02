Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4414EC04A6A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 14:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbjHBOp0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 10:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjHBOpX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 10:45:23 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2041.outbound.protection.outlook.com [40.107.20.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B61B1FCB
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 07:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G09gTHH09O0rz9GBkmgWIlBDGN7rqSYyKgXDU0D1yqlBzLgmTlT3RcQYz36+yv4KXMnPMSxSWC5y6Gj6IY1miFaNUy0Mj6ShDYRzXagUAw/JdrifB/FQ1J7Q4uNiptjRRAxjb/Z8WPGM9Mj9fsu0L39NnXhKYbf0HD41QlCcve4awzdem4cJsn4v9cMAzI3X14Ps7L68ByaeEKFEsnWTYegj57u2rRjamsWKJN/KCV8AX7LHyjhENqCrFz5VODvlK0cuJPA0Rz92vFF0RqEHVgcR0K5ZdRzGkBCJXo29c2NLqDekmVHkzEfKtYV+HMp98F1AbGQCo0n1KSe5H8VZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHvtNwJDmijXkVXeIQEuuoKreU3E3O0DydmNsJKh9mI=;
 b=Lj1QxCFWc3VIXQicafmC8sDv2AvQNVtmvqIk+yogT700HTWqcazzArralvMBzUVwAx0gjxTPIFu669hF8LdXkMjSvtq4CvHP5ja83O+GR8zA2QM6UNxdYOZutV2L2JXWFSAGr7f+XsaZ4zdXhI0bCRRf54flngu7hDfcxGftimB+y/AQPpBfsI88SvpIUtHcF/8sLAJDTgp94rv92+PcgA/0AXAAO02ZDCIyW+fdn5LeJ7gxf0UswLywANkgKGNRj6I0mj1b+Pa6MY2WR6VDHY7KDNfrhKfMKO38RAHmv91BONxBAPK7tCN1gGP9WYbK9kM8wyOFYmiJ9suylJN8vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHvtNwJDmijXkVXeIQEuuoKreU3E3O0DydmNsJKh9mI=;
 b=lXq4dIHtme4hn+xNAxZtjMifwQsb/9U+TraWDJIg9sJeFEdNnIzqbisM1AhcFEwLMC7V8rB9TcM6FzRHiasaD1bA5sOnbQyLj48U00fCz4LZkFnO6VXH6WDGkW6Z5widk6sfH1Ww7qGA6OZhn7CDQ8Xt0DahZPwbTJbcPUnUHtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU0PR04MB9669.eurprd04.prod.outlook.com (2603:10a6:10:316::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:45:18 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:45:18 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] isotest: Add defer setup support for Broadcast Receiver
Date:   Wed,  2 Aug 2023 17:44:47 +0300
Message-Id: <20230802144447.59985-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802144447.59985-1-iulia.tanasescu@nxp.com>
References: <20230802144447.59985-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0197.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU0PR04MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: bb20a3fb-b9c6-480e-7158-08db9367172b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WzkifRs7acoJ5kOG6KBWLCJmxK/e43uL95HZSBkcKfZyQZyS3vTbIuzdagAkb3dSVMOyIGM7D2m012lfRewUhsr92Rnxmt+3fglu6Vum+b61jobuSlUez0xkzoQNGkUmW06oJT70iWSmdt3VzPHLBrjYfnw1U2kwoqJRzV3OUPj5Rp1pTKtIUAUW7THBssnjUthhvr1kdoH504kKimvM/VF5AkCtcsNpOYnAFMhtlqP+JT6drsm6qz3SwWOpixCSfEzhIi98nIwaoMytEuBgoEgNjjqondX1JIc2aOb/x0l46GHJH6zbaJQyNZp/3C1VoJ8FJwtBq8HYxlJaTsMpOBqNxOXY5+FHssfUVyfsyrsGHTgTpRAepdnyF8E32MWBguRBLjZH1w0peFW6UDR1KCqbydUNQMFq6QKsVUqMuzWOf+XlqaYHm+9UcInRzg+EDbZjFWv5FYcTWGVNDfCmxbAcHCqpjYgS2s8FDVywNCHCxeq3sgepNESSqc5J/8k/itH0Xv1FDwsRgrYiMo5OwTt98y9bV/V8KjOwmQE/VYZV4HpWA7Z4bk1HDPGn2yqDhVXmnK8W0yrbEleNF0xomozeGs9wOi8dty57Xvsniuia7juevJmFV6sdUKzqt9Iu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199021)(6486002)(52116002)(8936002)(8676002)(6666004)(478600001)(316002)(66476007)(66946007)(66556008)(4326008)(6916009)(83380400001)(6512007)(38100700002)(41300700001)(44832011)(186003)(5660300002)(6506007)(36756003)(1076003)(26005)(86362001)(2906002)(38350700002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M0wCzbMnV8Ue7LJLwoP/bZf+0rdQPf20BphLn7uJHN/XOzPVEOsfI/vmohYM?=
 =?us-ascii?Q?F9btyMenLHxEgW61vNke1jTIZ04AUCibTWkvm9WFLGO9Cvmp/2nHk6PYilkK?=
 =?us-ascii?Q?obUGV5JxeEryjeDLBQm2EWAeb/M7RGlcQMmP8pKosQ1jwO9zD9eNdB26xZuF?=
 =?us-ascii?Q?YreIeI8AhnaOJYyZCTvgeteb+cGjmsxUi8UeHs2y9OpOxAwPeKuWyR3XNdi3?=
 =?us-ascii?Q?mywXGALQS4EBGh5RPvJIVreKfFI+WBNG+kF/zpYahvL2gJF1QbFaKP4LdDbh?=
 =?us-ascii?Q?AlV/cmBrZiwiZomg4QqEbkyzgXLzO5SZKpz/fIEQBVieN0efwvapNfQEUStv?=
 =?us-ascii?Q?9XQ/t2dRSU3/L4EtsY4S3L+ArcGOiYDjNACfGhsEyuJAjS4RvmCxrOBpcti0?=
 =?us-ascii?Q?6bBNlTaIXYwi81wM9MD2bVGi8EvfHWvxQo0Qr2amt9t8ASmrrvTOKo2U+3w5?=
 =?us-ascii?Q?UdFap+XxxbABjBSwD8I91NAtCzUGNr6NEk9bThjqtyYosxYI/RvfDuHIoVqu?=
 =?us-ascii?Q?ce3arVVPvVE+KEtd6BTMa/wGadJ7pzfwTkspkIkMVuIRLpfhKgrWYYjnpLgz?=
 =?us-ascii?Q?0LYJgQWjRO8az+mNH+/BNmK1rBSZQa8gxUiEI+VSlcwY24OATu0idvMQD4v7?=
 =?us-ascii?Q?8py6MKgIgwWyFyIu1TkMW/RNcsLfaCa5A6gMJBQXCiC1on85vKh2JqyFq0Wl?=
 =?us-ascii?Q?92n37ESz/lUOzGEOIhUi3Hu847AvfbUgFt582KYlHFhFty2K7sBk6rr0Z1ei?=
 =?us-ascii?Q?eHBW1V0Zt4A/0S+G2/vBXBQqvpC4SFCQnbCR2SHmzAYLJDeyGOLC8L62mQzA?=
 =?us-ascii?Q?7br5tcjqOeFW8FwXSzOyNgwKSmy0NE1emnaKNLCv7N6oPJRudhFqJIuM1ntW?=
 =?us-ascii?Q?PSosFlj+sKOFLUrROvJn82rXeBPAuOexiFZ/N8N65sidHHDMEwXZ+TM8z48N?=
 =?us-ascii?Q?+CJptIMp6yuDc3D0mwe+91MPU2/XDC/NrCmH6NJB2hGwNYsSS5nJKEwfuY9q?=
 =?us-ascii?Q?KqcJ0a2th+jaYFpyEH83hvp04oBEdi+sFeG3dZswPjwOYfC2Oje1CGtw61wq?=
 =?us-ascii?Q?vnwD4niJtIN+Tor3j2zHCS4Eg9bCAzq9onglbBS+EpnPWMEWwcPhsxf4EML6?=
 =?us-ascii?Q?DN5eqATKMulDhJWAI0c6lH7G9wOHGOVBg5wilBoaPrfLsYAq/JMrdJA3XWaO?=
 =?us-ascii?Q?u8EFNgpht8eCXGEd5EfXh1DpbuPvp1ibA+LvBrrbWPLM6kvXnBpM+5J+Frx/?=
 =?us-ascii?Q?cI7uCHKVBn44Oi/34g6Wvt+vb/rMNRXRlMr6oI1U3h9b700ke5etfvlx/bU1?=
 =?us-ascii?Q?hI133UKNGk94kfoGZBsa1Z0fQV+TmSx/xzACEddEWb5b3XdOMXQ6LcYCdE3t?=
 =?us-ascii?Q?VkCGUR+JoDpXxAmU3lW6pxdSSMd7gGUM4E7vRVUqf1tWHsqad6gc19IoXZSC?=
 =?us-ascii?Q?6lD00JIzg0B2JS+TU+YM7JLGYjgzlpR8hk4ck9iafzIxvgmHsPg/ozdFxNaS?=
 =?us-ascii?Q?y4JG9QXp9KjMHZuf1KKl953zcYmy3JvvXeNWJbjLw38kxx6Q0GHRrlkV6HhU?=
 =?us-ascii?Q?y12K4FIHXGEJpMS3efh5Ye91lBF3c2GVTDZ05pLSo6KEA//tB0/1kfRpsKZp?=
 =?us-ascii?Q?FA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb20a3fb-b9c6-480e-7158-08db9367172b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:45:18.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtWVBBWlyi7wyCNpSNYWrSr4pwWPAnOQ680KGPSAv/BcY5HkjauvsbK3Xq8Dzb/voiW1tg+w5Ra+OXCKZRgfUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9669
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

