Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F95E1E522
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377657; cv=fail; b=EBe8w9rZSrg3fmOmwd/9Y3uzoxeItSAH5XDOeW9FlmtkcpHLh6MlYSESSBJ8VPC1FHDrPTe657VdqSAxzegn2R9dgK3qrKuwPsu9A6c+UyeqKUrQUi2KwLbFJtpuzyuhdAXoNqA69lAyueuKsvo9EGX/XeP4M280zXk+3PU7p3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377657; c=relaxed/simple;
	bh=Tl1/nvNW9yCHN77tZFKf7gsRwUA6odvY/8KcYTPys9s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IGDHqH9ELd//DBkGrEcJ1DGsqXywjd9F2S3mB+9Lp5TIgz8FKY1vLlErnDFw3/hKM+VH7npzoE6MtgyK64FZfI+GyEBSFRFGgZY2lK8ph4Nol6F/hwPOw1FwHzG4lsEj1pXvnXV44Mw65gheC9tkjEHp7WYd7rbtDd0fo8J/8+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Sb2/2QQg; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Sb2/2QQg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ifzkmh1O07wOS97tSQt1Iv7THq1/iqnbPtXQA5ib1iOlWj1tLLDSkJ7SAcMlnDzKWvsOjpouEeiaNrbuMRRoc4/emUki4d64mNdDxUtJjAE3A6mZ/HWY7ysYXBzhE20GORiyg98nhry9yAZO5P08gZurlSvqL0Ksv5YhRdY1E6RPlV0LJqrB/y3x2NLJy3Ih4iEG0mvFRchXhWVmHH2eMsrj2MBy9C9/QWJCokOudAipls9xNVYYosir2iPspp/mxagf1+NdML7Y8HweiGJb7Po1OVKI5LTsdOLMrlNR16l2U9cIkJxWLWB8NFaCxgFJbICZEFARgmh9hPb4alpTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q01aV8eH+hCvpvMNwjYcjt+49QgQwu3utweXaWtIb4k=;
 b=gh7BpSzXxlDTN4sA1gRgGK83tXoNETF+TZVqMuN75iG9aVZajOj0xTVCOZhhN4YecCVTi1HX1xXmUTrOcT5ywHMxJjst9RiICf+VA/Ye3kSsj9bdr+f6IwaJJ/fbmFax6GnmaXmKogBgZMOkIW8WjXF6w+B4EtJkJQJ9woAsciI+jxhU2GrzL/vD4RruiuuVLhGQaflCtXPxy6rDQHsuw/lnu8ULSKWPVC9UxQcVM7oYeaH3uwRMGHgekuAAh5FItjIRFSikM3ViEPSU15srWUtyLs6RJU0TerkAezEqhB69yBRlm9S4GhfNiEqvtxe3/0FJLyuOapbZEex188GYtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q01aV8eH+hCvpvMNwjYcjt+49QgQwu3utweXaWtIb4k=;
 b=Sb2/2QQgtG3sDC/4yFgy6JHv9Pn/EZgtqY607wnucrBDFc2609x0f/vwz832V5GyqPMgY04/WhDLKFifuoLzWGSt9/t+icDDbx9XfH51JbmkQmb1ijW0UJLX0gPT055RgO68Qx7w3RDY4LRse56KUQs7NCMDKnG4evctmavqKSU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AS4PR04MB9459.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.28; Mon, 25 Mar
 2024 14:40:52 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 14:40:52 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] client/player: Fix transport.send command's transfer of packets
Date: Mon, 25 Mar 2024 16:40:31 +0200
Message-Id: <20240325144031.335354-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325144031.335354-1-vlad.pruteanu@nxp.com>
References: <20240325144031.335354-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AS4PR04MB9459:EE_
X-MS-Office365-Filtering-Correlation-Id: 725d018a-32bc-47a5-e4c2-08dc4cd991f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aFzsAs3aZa7AYMsZIcW9ImaBs6ZQxSr9KioaljLbDqa5ZsxS+RJdKAFSsspB0eh3FoAG+eJSHLEfFLk+FDN7Djhu+XHEiomGpKyTLrubKwVsfzAHS3mI5VLSoQfv7lbwbF0ZQKEwi3HCgPhtnSVku0XXCbVI8hBTRNKgdes3I8oSEbkYW5HdlKsEjtK8dyffqCYEtyVq6lSfOa/y42xSm0xT0NJVkA6kS8LxBNNm5VOEUdzy6tIflJPTLk+NO34qjdRribCVFDh8s+KK7rp2zvOnifCNtnousq3NQ9YUma/0RM02i69a+VQYEXiq3ZgAgx1rQknYz2X87osJ98sNZm3h1yIqdBO9o5hxTAttuexucz+1dFdYIjVdi9EwbxrgvnLgG/jenjLNg0BJ71yQL3z3tF7AxBg+XiRAEeF3V74n0Bzq6QsbpTQdWPv8qHt9NKXNApR1H2upz/KsaFaQnZdzL/6I7zfuApf2PAhZ3Mwx/oa87FE7E5vrf48WmKK1Q3W1uMplvOVV2ocm92v6ngTPH01IzwKRnCs//qahi3wmANwDgYhGle9uAOlvVNF9NAQtGCONcsFsxXk22ZqmwTlcT0SdzHDVw112ihQqhiVUy2VKIL0ZPdEOa3X0tsoKesO5V0DDhI8Oq8kVeRGlFqpo/HNaKzkGf3wjHzVT7oZtE/MmMe0r3y2580/jpT0e9c0tWedhrYGbGgaa1NjUq6LprKBHxfCg1+5OG8Xmwtw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b4RmTJTA9QBoRij4jb/0QRI+vHE69UZLmPiIPibX5kmn2NFq9iHtaPLqw07X?=
 =?us-ascii?Q?EM5l7lJnOrfc3fh2Y+UnH5g3bOn5AjTf5FrisZqtiESAfqPJpLkU6qAEhYLq?=
 =?us-ascii?Q?5Wu3GA2WdeywC6Vz3qwCgWtZjAI3ETQr97N3k9pePwqQHcNOmrVEcNV7P53G?=
 =?us-ascii?Q?+CQ8oWZ/7rW40Vtn5z4jxp15GEnpo2YHZl9wRCBNPqcFCN98wt8ZXdmqYmdh?=
 =?us-ascii?Q?qwc7HjQpvuKmhlntzGa1uJZqRcbVPkpkuPHNp1jS26gZkUlCcirKzxODNcN8?=
 =?us-ascii?Q?xaBnqkhF1Bp7D6cLtsgpg9dvTEuTxHcSQgNhThOU+tapUpYTxBizSdkv84sP?=
 =?us-ascii?Q?55u6x3QzYTRGv9zfwab2x5A0ktAazdMnocAL5wnspeRxnoUrcBfFa4h38Nbe?=
 =?us-ascii?Q?RyZYpETp74lpi3S6K4/G6ndbVtLjSrM0/f1HMnHT/4o/7lZDyXjFnkzPKgQK?=
 =?us-ascii?Q?V7Q45wGckw8XjxZevxle5JGTsNi7/UZUU60cSoSsgDYUKvjCs4dzWVKtCg/T?=
 =?us-ascii?Q?KqHqW2IPxIu13NlLVWD2M6SC1mm0jqLbjHHDHTpNcwcW4xf8e/q1jSkoFwFb?=
 =?us-ascii?Q?4mldG5mIGgIv5iUGeGIvwF5+wp1Y8VATPdJlz2u7uvXN09Mx2aliSZtiJnje?=
 =?us-ascii?Q?snkVCBdaQSMccDj7q1T0YqcFJND3ZicJ2M7J28itIsEMAswnhiJXR3CwD1U5?=
 =?us-ascii?Q?fxisq0mLt+7o2HB7McaeFfRUhYEpd5SaaJj3Vo8EG0mRI87JxIPHxGSsiZsv?=
 =?us-ascii?Q?pQgbKN4swj+E2aaBoJJqbbU8ylj8CvrVsM3/3Mf36jOVqMMrq55oTMGGqRUj?=
 =?us-ascii?Q?9Hc28Br57/St6ffTuYk7VySwGl1GZZn8ukXhwm78u9z0NNsw1LwPB4X/+q5E?=
 =?us-ascii?Q?m/RXTzB/Prc41xCEBVCykdtEVomibAEqBOcHyVfHXcBdbCQMBCJgOBNRiw6k?=
 =?us-ascii?Q?+tRBe7BPZG+2fItOuXr2fBXt8XLAIZf/cJTLXSr0o0lt6nrFhSO1QG5/M8ld?=
 =?us-ascii?Q?Fxud7DtK88RSpFyqk+p1gWQfHGozFdBkrS71gy4zCbC3OJHYYm3nE8LRo9wc?=
 =?us-ascii?Q?GXY5pOMSmAX3U0TztE6q9AvahdACtLddaWGfik0yAQ0YmzaTjizVUoTpAhSD?=
 =?us-ascii?Q?z2mZLy3cMT4CPJMo/Uo09EMCbQty40ok+ZGNTS86pgrfb9OiWd76690kEMfO?=
 =?us-ascii?Q?hc5JJiAEqbcjyh4axEwIoA9EVsUjTxRCGnpOdUm0jbQPwf8uzcx5ptt31MQN?=
 =?us-ascii?Q?tkh4G2S93qBsExouGKSkAog9NxFcdAXHL1sefmUfKXq5aCij7V9Vw8UloqrR?=
 =?us-ascii?Q?4gfMFVJ0HBJgUaIhXASx2XZkWWsw2LUgxY6hVWmQbp3aSdnn6FvRlJyWyfGK?=
 =?us-ascii?Q?CEBrU5Qa0ax4g1mqlYeQdNF4nwcYKYCFfS4JAwYTNXdExuUCjPHGIQ4DTplh?=
 =?us-ascii?Q?ifpiiwN78fDg2WZoxZVMFPDI2GaXkFfvh8nxVthbp7Tn4UN5uBpH69a/WrGi?=
 =?us-ascii?Q?dAm9t6uPPEqpNkIZhQzzw/fdcZ4uuhPdVurmnbqghnbtsnuwJQuEI9dKwKmg?=
 =?us-ascii?Q?f2FX1RfPE2UUIeMr+BmQkmDLJdR7VTW9u4dho404?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 725d018a-32bc-47a5-e4c2-08dc4cd991f5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 14:40:52.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8VKfq43t7g4yiOTd9ZS4SRE9lFv8LYIAYan2gt2ugl2Kidc0SS/Wu4d1SOsxGNZpRa8EJCVElcj+hZybUwsLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9459

The transport.send command sends a number num of packets at intervals
specified by the transport latency reported by the CIS Establsihed event.
Num is defined as qos.ucast.out.latency * 1000 / qos.ucast.out.interval.
Since this latency could be smaller than the SDU interval for some presets,
the resulting num would be 0, causing the file transfer to stop after the
first packet. Instead, one packet should be sent at SDU interval distance
apart.
---
 client/player.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/client/player.c b/client/player.c
index 1f56bfd27..f579d9904 100644
--- a/client/player.c
+++ b/client/player.c
@@ -34,6 +34,7 @@
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
+#include "lib/iso.h"
 
 #include "profiles/audio/a2dp-codecs.h"
 #include "src/shared/lc3.h"
@@ -5007,7 +5008,6 @@ static bool transport_timer_read(struct io *io, void *user_data)
 	struct bt_iso_qos qos;
 	socklen_t len;
 	int ret, fd;
-	uint32_t num;
 	uint64_t exp;
 
 	if (transport->fd < 0)
@@ -5031,10 +5031,7 @@ static bool transport_timer_read(struct io *io, void *user_data)
 		return false;
 	}
 
-	/* num of packets = latency (ms) / interval (us) */
-	num = (qos.ucast.out.latency * 1000 / qos.ucast.out.interval);
-
-	ret = transport_send_seq(transport, transport->fd, num);
+	ret = transport_send_seq(transport, transport->fd, 1);
 	if (ret < 0) {
 		bt_shell_printf("Unable to send: %s (%d)\n",
 					strerror(-ret), ret);
@@ -5052,6 +5049,8 @@ static bool transport_timer_read(struct io *io, void *user_data)
 static int transport_send(struct transport *transport, int fd,
 					struct bt_iso_qos *qos)
 {
+	struct sockaddr_iso addr;
+	socklen_t optlen;
 	struct itimerspec ts;
 	int timer_fd;
 
@@ -5068,9 +5067,30 @@ static int transport_send(struct transport *transport, int fd,
 		return -errno;
 
 	memset(&ts, 0, sizeof(ts));
-	ts.it_value.tv_nsec = qos->ucast.out.latency * 1000000;
-	ts.it_interval.tv_nsec = qos->ucast.out.latency * 1000000;
 
+	/* Need to know if the transport on which data is sent is
+	 * broadcast or unicast so that the correct qos structure
+	 * can be accessed. At this point in code there no other
+	 * way of knowing this besides checking the peer address.
+	 * Broadcast will use BDADDR_ANY, while Unicast will use
+	 * the connected peer's actual address.
+	 */
+	memset(&addr, 0, sizeof(addr));
+	optlen = sizeof(addr);
+
+	if (getpeername(transport->sk, &addr, &optlen) < 0)
+		return -errno;
+
+	if (!(bacmp(&addr.iso_bdaddr, BDADDR_ANY))) {
+		/* Interval is measured in us, multiply by 1000 to get ns */
+		ts.it_value.tv_nsec = qos->bcast.out.interval * 1000;
+		ts.it_interval.tv_nsec = qos->bcast.out.interval * 1000;
+	} else {
+		/* Interval is measured in us, multiply by 1000 to get ns */
+		ts.it_value.tv_nsec = qos->ucast.out.interval * 1000;
+		ts.it_interval.tv_nsec = qos->ucast.out.interval * 1000;
+
+	}
 	if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0)
 		return -errno;
 
-- 
2.39.2

