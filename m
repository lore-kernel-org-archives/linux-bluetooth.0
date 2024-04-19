Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538FC12F391
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538713; cv=fail; b=i6H9FUMlmHJRM/DnGb4IQ3N577T4P6rnm9Hqh5RJjMqhs8RzLaU3NsFvkEGn7hJfK2URFc8FDSAduqrPWY3qS5K2vSJCMoSdFn4SjJC20GqdBn0ab5Lth87AeNrLaWuCUmqFxFlcpcTCW3ti35qbcS35wrxfuE7DSekpEdCf0TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538713; c=relaxed/simple;
	bh=rpLsBN2ey7ILLtvbYTZCfm7fESxoNLzahDMwKOTeqtw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p4Ab2VMEN7Rc82aYYHOpEia5Ojhp4tl1rfmwkFkdJxW7jBliZ8WVPUcy0ZFRuOnBs3QXafrNVDvtWbFWZuWs6mDI6m/Ti5F5wn/luBDD9FeMGjHrb6qhoF+bn+0UHDvKl1eqTxUnE0qto5b6iO+NbI/kKJ3q33lVYuS0FXxCpt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mlyGYRNT; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mlyGYRNT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBE/f60OVXqvwiBkngoFjd4D1EZ5JiiPoRK78wXOPKooD1dstgGrv/h3j0fuf6LxtRsPSbycZZO9G2dpTX5JFzSkMxfUi2i0xs4K1t8qS470wnjt2hdoL/WcM0vzpG6sKA2MMin0sLWfrcLNN+obtAcYkXDy4OsjaMGAkpe9WodD2R9ib5jSrSUeWfF5Gdhus9eJz7PCzAuRFwLY+aKiT1u9zq0SL6qn9HAwxQ0AXjJo0KpHUZPXjDYdXxrKy54Qcamg8UwarkAVi6v9i5BEqD1nk9R54o1FbDfSVy1u+UBMAog4ki4k/uRNiwvH7KKzFWdWnfUWdQiipYrKWLoO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wA2B32r6c/vRwCTKcfTfZ0o7DlcEzcBUJOWvcnngspM=;
 b=Ln2TRgq7TQuSE9wrAhOa/cVvmSh0CQPVYQ4m8GF3QQG9g2+AQDZQMwrqhaAsfkLF4OwbhcikLRQBOtF4umSG7eFRp+8uT64yIZH6yLSOkatxZuKKlcmts1XjoOFtUYNN/2itYc1XR/J0yb3xdGdxx8P8adcib8IViY/zbrx87hlaWcrZxCMijhWPg/f5BEhBDcuEaicZegLF2fHzvVH9sw2KxcDTkttUvYNMXxopGGlwB4HJe2BLgxoLmCoc6VklX+e2arE2BZHD25DuAfsziTf9CEQghM2YxnXZ71OBUIXUJ8qcn0NJy7g7xMDDQI7JkJFYPC6g2/56tDCSzHh8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wA2B32r6c/vRwCTKcfTfZ0o7DlcEzcBUJOWvcnngspM=;
 b=mlyGYRNTa9Q4m7YFgw/sjATvDfbWzMCenfzg0KWuRF+cuGQAwpTpA0NZcXSuDijxC7cLLUUgH1joZmI/EEDQzR+XReqzrYjkESGSCPs/nCUrrUD8WYLgUNEeusqrXCSQwHWM7h57Z4+Wp/hZvO8DiqEM81RP8fgocSuHAHX6kJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by DUZPR04MB9947.eurprd04.prod.outlook.com (2603:10a6:10:4d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 14:58:29 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 14:58:29 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 1/1] client/player: Fix transport.send command's transfer of packets
Date: Fri, 19 Apr 2024 17:58:05 +0300
Message-Id: <20240419145805.46263-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419145805.46263-1-vlad.pruteanu@nxp.com>
References: <20240419145805.46263-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::17) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|DUZPR04MB9947:EE_
X-MS-Office365-Filtering-Correlation-Id: 17a486e9-a130-43ec-9ea2-08dc60812c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YaNHC4y5geLskxDL+XexWWABSiQu8aO94SZffxIJs/Fm0TcoJUG4souTIxo8xpePRqPhRXPJQCUN+GLqes8SMvhdDlWRFaol3izV0MmKm/kU/4t3eVFNoK1poapYd52yyS7L+Axj5B7GKNYD4/Ymy1+PGFvxN1IFu1PFUZ1HhrXgrf8DKoMB2lTveAEHDTOdEFiEeKW1L2yhvL6/oVe3KO1SnZYW7fA0d4BV3/FRPqsJ5TgUF0oheaPqGMfSEeCq4lS6gQg7+XYhldKIbkgH5UL0oyhn93GU8sp7n0peZJEBeo8+yzj5FnNNy92yZKhikEJ6F3v6HXLKIg2UMKVTgtM+ZycU/Bmmy9M6LiR2eSzrV+2BIQmYNsYoVU2gJx+OcXdJIaRnpkGtmj/Dv2ygLIzzAN+adCyvXWmjc+pWuFsotvnLee7ZxV1mRCD3/WdmqlSgqhNxfmAxgWQj26O4HGUklLdz/OvqL5LbzUwv2PUXbzJDTXPD7FELWvT263LDedDS1y3OsO6XW1gFyYcvzLvA02GHs9rbPMZl7i+l8Bfyr2Jt6Cix1bq9DK6aiWSGzEZme0+OvxdIZGWLSae9S9NGUBmvBlMtpKE1F0I5OLxx3Oj3DeWxZn7oJXIOcdSd/w8dleP6ggEKe7ihzJLduAoRXPbNgAJ+uUnUT/xT0/PLcjb4lId0gaNCXCky0P0w/VjSfX9a4V6n0AB/oK7J8hktIDbiD8i+RclB8bTsBy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qDSFycmT9VQDnvHCike2vkxqTI39JnYySIc4buszRPhuP0cctJXqE8vtBtkX?=
 =?us-ascii?Q?x43uLnk1LAdKZuHkEGdOCcXxNaa5WHmRSahDKb7FSvLwnMYeGluUtV7FnPD+?=
 =?us-ascii?Q?lOAO7gC/GnhetrGQ+9MTH/FJMbLIxwL9B2wIvFwxTc3WqwIc2JpJdXEPkzQT?=
 =?us-ascii?Q?9wM46Z1EmtkxT4KdME4qeqL5i8K+OOJL91SJkqG0B3OJwLbziqU4uZNL70yI?=
 =?us-ascii?Q?J1l30fI8nKMC2Pr5lAO3oXcs438EFjWnKvrdMCILi10JJqLOL/nx/1RYcCVU?=
 =?us-ascii?Q?rGZWqnT7bYyYZmflssNwQnPL73XM0oRgZg4hdry3x/COQ+oEBtvZ8FPqHp6L?=
 =?us-ascii?Q?VaLwnkCYKWGRDCWFSTzMFGsGHNnunYOspUfEDwQBmbBGei9uKhcIugzcQNoR?=
 =?us-ascii?Q?ueuufeRawoAPpEjxkfxDqkvK1K3nb3Aq2QdlDE6zFszlI7B0fXWCdTJipKgA?=
 =?us-ascii?Q?6vc5povV0hUKUsDVD05mRPI9q+5pI09HfpiFQXUcytGh1uXE3K4hUJi3vs2I?=
 =?us-ascii?Q?y1CeGHEm/UjnARcRtgRMhmQlvr2ojtZiK6HyUyVKtB+I0xAVpMUaYKItU+Ia?=
 =?us-ascii?Q?CcZTfQ5X7ULCXBxG+CUUJ40j48McRzXr93SvEEVyM/7n+BZw4z4AtqPovVFH?=
 =?us-ascii?Q?+bl7PD3yc+3RjAb++2qVtlWvffmWb4HvEIfKBQ8v7k67VD+y893U0pQB1112?=
 =?us-ascii?Q?A0W0ZluEdP4UIsr6M7xhGw6t3+1je/ZO/nAyQ6N1LUQBc2j4leeFRBVTNx90?=
 =?us-ascii?Q?1IVrjxrH7xOwX1eBT0EES5YFVuXGdr5Jk4R6Vc4TUC+tC+IjFTgxd5Q3JJ31?=
 =?us-ascii?Q?ooJdAXBKiDVZl2kIQaR9Gu7mQybG4IJ8lPRMlFB6S8zCwHNYr2xS4cM+LmId?=
 =?us-ascii?Q?iCYSgmouF1wPmZ1AQZM7Iz1GLFnQpJgkCLZ3nGqUptz35ilB76zS9VyB6Fdr?=
 =?us-ascii?Q?0jUctPNqc3NP2G39xP12c+/BSjko/Mf1mKXIIGbt5FnzQ6N93sliQNR/II4q?=
 =?us-ascii?Q?AhHOXAilD5qX8aLK+Ox3MBgXlcGopDYdBIYv5N5bywYs6206/IYB8lJFwQKD?=
 =?us-ascii?Q?md65o1gUTgMp4LxEpfPy50hx7bIIcVcmlbgcGnpZUb+RSc4rjdctGZNllgen?=
 =?us-ascii?Q?PLxDtxM2VvUpsN7D2bDrOofaSdr+3p96f+xekrWzL28QLZyHV2V7YNVW2hFa?=
 =?us-ascii?Q?UKvrOnACBn90LcixjA5oL3g19og4QGY81GfrMv9p6qUCwSZJkCR+rwvrteIX?=
 =?us-ascii?Q?RM1T7LCl2ZMhXq/W2Cvu9U01LZCOsSHERcmzEpc3mVOdHZ6O+EFZThS4OoRC?=
 =?us-ascii?Q?+xQ7lgF928OzSPMZiTxq1p4UR1oN7qBPajw9LKFyJf+DESjlIZEiWY/Gsdar?=
 =?us-ascii?Q?gQaXDu2VTqkeEZHdiW2jnR0jHQJenusqaSxgeONwJSvXa7nSO5w96kqE+xdS?=
 =?us-ascii?Q?lPLnh//UQQ+rbmWLgeXP8+6AOl0/Z5bddNyeB0il6gpi1gUhc7qQ7f38NiqA?=
 =?us-ascii?Q?OzWwiXS0eCE/uiPD082ox6vfdFZKajayLpFBBiig8xYi7WUrhRsY9s5h/PgJ?=
 =?us-ascii?Q?dBHmxYfkrctui6aTDUWrtVo5OFkjDJ+hw67NNluh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a486e9-a130-43ec-9ea2-08dc60812c8c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:58:29.5568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpxkcFznZTZIac7tglo75H/nyMar1GqhMFouGS15FJYErUvnOemvgaYSvH81lIIBskowWsKJ8pcOAKXbz9n2Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9947

The transport.send command sends a number num of packets at intervals of
transport latency.

Num is defined as qos.ucast.out.latency * 1000 / qos.ucast.out.interval.

Since this latency could be smaller than the SDU interval, the resulting
num could be 0, causing the file transfer to stop after the first packet.
In this case num will be set to 1 so that at least 1 packet is always sent.

It the transport send timer is set to a value smaller than that of SDU
interval, the available buffers for ISO Data will eventually become full.
Thus, if a packet can't be sent due to resource temporarily being
unavailable decrease the fd offset so that next time the same packet will
be sent.

This patch is a temporary fix until the appropriate solution that uses
number of completed packets to control the flow of ISO Data packets is
implemented.

Since both Unicast and Broadcast scenarios use the same transport functions
differentiate between the 2 cases when accessing the qos structures to get
the transport latency.
---
 client/player.c | 55 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 6 deletions(-)

diff --git a/client/player.c b/client/player.c
index 1f56bfd27..ca169e58f 100644
--- a/client/player.c
+++ b/client/player.c
@@ -34,6 +34,7 @@
 
 #include "lib/bluetooth.h"
 #include "lib/uuid.h"
+#include "lib/iso.h"
 
 #include "profiles/audio/a2dp-codecs.h"
 #include "src/shared/lc3.h"
@@ -4972,11 +4973,23 @@ static int transport_send_seq(struct transport *transport, int fd, uint32_t num)
 		}
 
 		ret = send(transport->sk, buf, ret, 0);
+		/* If send failed due to the resource being temporarily
+		 * unavailable the controller's ISO data buffers are
+		 * full. Try sending the same packet next time.
+		 */
 		if (ret <= 0) {
-			bt_shell_printf("send failed: %s (%d)",
+			if (errno == EAGAIN) {
+				/* Decrease the fd's offset so that the same
+				 * packet is sent next time.
+				 */
+				offset = lseek(fd, -transport->mtu[1],
+								SEEK_CUR);
+			} else {
+				bt_shell_printf("send failed: %s (%d)",
 							strerror(errno), errno);
-			free(buf);
-			return -errno;
+				free(buf);
+				return -errno;
+			}
 		}
 
 		elapsed_time(!transport->seq, &secs, &nsecs);
@@ -5033,7 +5046,15 @@ static bool transport_timer_read(struct io *io, void *user_data)
 
 	/* num of packets = latency (ms) / interval (us) */
 	num = (qos.ucast.out.latency * 1000 / qos.ucast.out.interval);
-
+	if (num < 1)
+		/* The latency could be smaller than the interval resulting in
+		 * num being 0. If this is the case, set it to 1 so that packets
+		 * will still be sent.
+		 */
+		num = 1;
+	/* TODO: replace this timer based implementation with one that
+	 * uses the number of completed packets reports.
+	 */
 	ret = transport_send_seq(transport, transport->fd, num);
 	if (ret < 0) {
 		bt_shell_printf("Unable to send: %s (%d)\n",
@@ -5052,6 +5073,8 @@ static bool transport_timer_read(struct io *io, void *user_data)
 static int transport_send(struct transport *transport, int fd,
 					struct bt_iso_qos *qos)
 {
+	struct sockaddr_iso addr;
+	socklen_t optlen;
 	struct itimerspec ts;
 	int timer_fd;
 
@@ -5068,8 +5091,28 @@ static int transport_send(struct transport *transport, int fd,
 		return -errno;
 
 	memset(&ts, 0, sizeof(ts));
-	ts.it_value.tv_nsec = qos->ucast.out.latency * 1000000;
-	ts.it_interval.tv_nsec = qos->ucast.out.latency * 1000000;
+	/* Need to know if the transport on which data is sent is
+	 * broadcast or unicast so that the correct qos structure
+	 * can be accessed. At this point in code there's no other
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
+		/* Interval is measured in ms, multiply by 1000000 to get ns */
+		ts.it_value.tv_nsec = qos->bcast.out.latency * 1000000;
+		ts.it_interval.tv_nsec = qos->bcast.out.latency * 1000000;
+	} else {
+		/* Interval is measured in ms, multiply by 1000000 to get ns */
+		ts.it_value.tv_nsec = qos->ucast.out.latency * 1000000;
+		ts.it_interval.tv_nsec = qos->ucast.out.latency * 1000000;
+	}
 
 	if (timerfd_settime(timer_fd, TFD_TIMER_ABSTIME, &ts, NULL) < 0)
 		return -errno;
-- 
2.40.1

