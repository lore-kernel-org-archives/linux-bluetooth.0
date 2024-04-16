Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2050.outbound.protection.outlook.com [40.107.104.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116C2130491
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 15:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280076; cv=fail; b=AE7CfPKlajD8eZTZ5YNK8cEowVZYDqgTN2TR8TtAqWI2B2U6QUYkgplI6bRbyn9mjGYIqo+vGCesVDnM6DT5pMLPP5kQo7vJwzRQzgPx3Jt/GTIqR61X4M+tAIo+S82tU5OxxcGqv8LATK7kKWCAH/rhkqqPJRc231oujVrykTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280076; c=relaxed/simple;
	bh=gJv+PY0mhJwe0A6kAkeMHn0Uqs1I+ZrWPJ89HkPfbi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W5yqW8TmuUfnKsiQMOSyDmO9tvhl9NmAfoDGbjJnX6Y8uEJ+uw1jLn8DAdmwIpErE7aT0ejBcOYJtVACB4DDGfcY0fZrYDABabbGuqshUN7kffhENB1JnqvQXDmBSRluEolgvH4W4vGNy9Uj+mDQjRUiQdDYQ/DCgRsiwAX76dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=U9wvA52q; arc=fail smtp.client-ip=40.107.104.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U9wvA52q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dyb6pMGN+5kxy06VMO6E+wWXnXPNdjUZACxaBhRbTDou3xiz8OnEysZS96udsTGxvwvOFe6vy++jLo05LKapXJ8gwq/NvXqfXtqY3VzlvkhgInJPz3c2aCNIoLbryj+r4ZgAohmIwqEWg0U2JwpW6OflNf3Msc9S9C3ZH95kzpcy8BvZQGfdV5yMQxWKHbbSYl66owKWZPbUndxrzrqOch0RiY5cFAg2bc+yyVSmfel+wfjOxOL4MBgTlIE7lfuQzXMnXF/UGTILBIZ4HmwjSkpOzTIVSkj2hsU1YiO2jBnbmvnBdfNsvdCg5DlM8aW3WZDT9pplXlPkI+sqW8JvIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTgpDASHy7YHfBLQxUG/o0iFIV/3bQxViPO+F6s+R+8=;
 b=KLkwg2KZxeVQyvvZTlbG/gcuLUEldGa3u4UOXZs1NDg3m7RHOD9TY07G17W9UHeZC4gFJd3tJyCWNO/mCN8M+eUqwjw7VB50dMuXG9FIQ4fulK8HkwindPIrdM253f0REBm+/0PpLUhAfjEPSJBBey5RRAb2Xpz2FRpPsV8mIFssunX9GGmDa711JjigioNPu2j3i28iY875ZFf80jLQtc7BYAMig5CZFbm+nqGs2PwssMEWNabLh7Y0zMWI+ylGgEAK7TuvCgct2+dZ9k+f/B6lgVgTQj/ImjT+yEoXesFjWLNMPyIX0BkN3C+lcpxxCpQKlxyY7JuZ+dEYMC7ZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTgpDASHy7YHfBLQxUG/o0iFIV/3bQxViPO+F6s+R+8=;
 b=U9wvA52qCqJ+JzVnLYDF3YfHCyHz2z0NYlPu6U1kQZ1/SOdvsD/qmBDBxd0lKQ2sadZ/smjIjNG/NN6FhQUYIgXU97AgdcqmVtO+yL2fye74qlVJR0H+LtDkYZmfvGzLtEikorUCq0NKjTx+8towgxE6BfO5BrQ4yOiokzKPO+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by DU4PR04MB10337.eurprd04.prod.outlook.com (2603:10a6:10:562::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:07:53 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:07:53 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH v2 1/1] Bluetooth: hci_event: Fix setting of broadcast qos interval and latency
Date: Tue, 16 Apr 2024 18:07:32 +0300
Message-Id: <20240416150732.101088-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240416150732.101088-1-vlad.pruteanu@nxp.com>
References: <20240416150732.101088-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|DU4PR04MB10337:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c8e8e82-5269-4be4-d164-08dc5e26fd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mRAnWYfFLx86ky8suPsTdtsdxyaTzShUwnsBfyLTQ/1k/Uk/jI6ssS2yxVz/inbz67pkto+VVSRTJsSYKSKO8t2WzzkAGv+sg5yRvACHLLmfjJlFWU+EhV9BAhij/vqPEkizGE43ocO82EXSBIy39CdFLlkmy6PrE6X06lX458SVc9wghagIj4QfesAliZYxrqueRIGDDB8PRQWF4JdJTMX6VX32hZ3jQYs/17vdnMZHygVBmnqup0JpF5PSiDq3ZavPvtqkKCdg4UTgvW7GE8z7VsEBFxgwZqaNTcUIAPOyN43T3qhPiX8HgRDygLWLbPOzY8CsGWkMfnjXsNrXMBChJOJ4BPUs5Va9iFD7TubE9XaQTt9Rdh8scAlAhTDQJViDeFX+Ipu7mLBp5J2F6Jo1MnNN+grjR5xXfRPCOAxvbq5q3On/p4I3sk7x1JtD3YS9leWTr376IO+AldW1J/mLsrGgADQNSVPDbh5xr3H5pWXO0skQyIvH6VHCNzxepyD7YSljaEGG+kooN86LX3BJWqgguUnmjfeFw7xMIWBRTSKDCe8D4Ywq2jewuZhsylMCrkO673+VviHe/VJ6kSp0+s0NwDRYHyo0FISlozLXSx/SvIPgx+Jn7w8Jl+2AdeuR7f0hdve4f0D8VK6os+8eA8jKj4PSj1fjw9lj/ZxRBlSZsgeXh17yH4lta4C7TPIVFCu5H9y3TZvAQuwF/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VdYf5KZCH4s0LPl2ry8SH3O0z5Be7HJbtTWPJAIzOVH4Nu9dPNr1RKd461fW?=
 =?us-ascii?Q?oDJ6JmG2mACPhW/eiuz+P/HjU09rURxlT6K2yd9R8UFlJWJWCVqqv48FxUpQ?=
 =?us-ascii?Q?XLWr7XwUTDRwnCf+kyjJSR4+3sQ1T7ESeFJ8ouefTpWDyiM8C35vu6eRjaZm?=
 =?us-ascii?Q?CN50IHA9dv7v22bdApyXAHScrxqG6ZAgrs0RD0pz1+/13mv3ecMuQBHTWpMp?=
 =?us-ascii?Q?rTZ0KGCeBj3sG0+XhBTqHAX1vhBtcHkUFlxt9UKUrirpftDWKYPKrqvMQwTN?=
 =?us-ascii?Q?Murj5mLkfEfH7+XxrVo2pav5JxKAqe9sESNOvw0BeW0FVPCATUzuOVV5mcQD?=
 =?us-ascii?Q?hU6+iw6lJxAEdczTQawGMmT4MNqCgAnbw3JkkrsF/TeeJpEXOGYU9wOa4lr4?=
 =?us-ascii?Q?H0kZZTmEw0xpm50+UPI0awxvUuRV6NAMWYGLUgWMrHZ0R6+9qCeAq3/IpB23?=
 =?us-ascii?Q?8xeBUKreiWIogC/eoGjAY483rnCQqQYq58tI/7K53C91cVBJw2I6byQ8h7OF?=
 =?us-ascii?Q?Db+Wxt/+rYO3oQigSryRFc1juU++xkJHWMcjqnHzs3Lyjtzz5IBuJLybAVB6?=
 =?us-ascii?Q?4rko6GK8Mg9+d8v+r9vZNAFtf/75qIb47E1P3IxnH4kWcBwKX2f9yNW+DDPI?=
 =?us-ascii?Q?gLaVoP0BgGUfQl+qFhcTuRVbbIzofMWTdIHvzWhTwrmwkxbw69VE5dDLa0M9?=
 =?us-ascii?Q?EGziajI4TSNJFBL912kv7KXFnDOv4Fxy4x7uRvgLPHvsKqHN3YOTuY+5LQp7?=
 =?us-ascii?Q?eYqXZMXxW90Oowivvu0+wnC6LmmUwNvHB9dH/c/IiYBmk24JfLSPgOp+KMjH?=
 =?us-ascii?Q?xv9QMl24Yfd1B96H6O3ZxrN+U6b++aVSzW3iep2DhkaQ/4DHNLM6RhPOJqn/?=
 =?us-ascii?Q?HbvtOGkC1m3PLxA0MAhvf6vSLzBXhcCMyXAbCjMpoBElhZ/k1DkR16NmOMgr?=
 =?us-ascii?Q?+S4H4rIqVTTlSwuoLLll+bEB6P9XPLzwUHfRj+f3cYXRJF1jXrAaynbt6T2u?=
 =?us-ascii?Q?DZe+l0h+u+GoqXkoUvZ4cmZ0bnblWArcZOhpX2KuTSL1358oQ40jn+jT2NjL?=
 =?us-ascii?Q?nsWzFB+WRw6yf5qJ0enzMPCaeIdfRXuiK6SjTI1wsZraK5WebiayRmuwQacz?=
 =?us-ascii?Q?YG9vBCVdmbmTOOZ3cG+c3l38e6z5bvAhkcPk4F4Tf2cBI2+FWOHVxE8WYvjg?=
 =?us-ascii?Q?jvWJJTj2s5uR+6Vx+8ZMM+N+IBqlnCcFkZdTS6uJ02Ir7spoRTgIUyy9tqcR?=
 =?us-ascii?Q?ITrCYBwXkewvIoMs56Tc671ggzTsu0o8LTObd7pYccpSUHS9lk4zw/ZLDMyt?=
 =?us-ascii?Q?O0Uve/qyiRS9nRzE4tl7KsfG427Vm+FqfRPUbkSgqadxOtNiWAVm/NZWwFue?=
 =?us-ascii?Q?GzEOX/1SedZWwvvaw7YoQhC4OjHTLXbJaN5KdD0XfLwcmuJuwfH77stilMPd?=
 =?us-ascii?Q?dcTzRH3/00m3ePcDhJooIISHzvmzAg9dVm0onAKvFjEcw9QliUKbOCksoEvM?=
 =?us-ascii?Q?rzY67qyLIqUgG1ctRBezx0aTF3QCgqXCYn0XTOkWCvU8EIvAG0WvBfUsqbjz?=
 =?us-ascii?Q?Su32op/QCYzv1O8oRRQc+sXUXDkyNDS+Od3Z9SEB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c8e8e82-5269-4be4-d164-08dc5e26fd2b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:07:53.1001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EZdQY0oNxLOfl4+nFI7b7yUT9Py8Py0kP4RgnZ1KUUZOFoUyPf02oTs3hQGvq5CGR/Xu50KVtPTRhfCAEPnYYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10337

The latency parameter of the broadcast qos is calculated wrongly.
In fact, no calculation should be made. For broadcast sink the
latency should be taken directly from the BIG Sync Established
event and for the source it should be taken from the Create BIG
Complete event.

The interval parameter of the broadcast qos reffers to the SDU
Interval and shouldn't be set based on the latency. The Host will
read this value from the BASE.

Signed-off-by: Vlad Pruteanu <vlad.pruteanu@nxp.com>
---
 net/bluetooth/hci_event.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 868ffccff773..f34775059c17 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6983,6 +6983,11 @@ static void hci_le_create_big_complete_evt(struct hci_dev *hdev, void *data,
 
 		if (!ev->status) {
 			conn->state = BT_CONNECTED;
+			/* The transport_delay field of this event contains the transport latency
+			 * expressed in us, convert it to ms for consistency.
+			 */
+			conn->iso_qos.bcast.out.latency =
+				DIV_ROUND_CLOSEST(get_unaligned_le24(ev->transport_delay), 1000);
 			set_bit(HCI_CONN_BIG_CREATED, &conn->flags);
 			rcu_read_unlock();
 			hci_debugfs_create_conn(conn);
@@ -7029,7 +7034,6 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 	for (i = 0; i < ev->num_bis; i++) {
 		u16 handle = le16_to_cpu(ev->bis[i]);
-		__le32 interval;
 
 		bis = hci_conn_hash_lookup_handle(hdev, handle);
 		if (!bis) {
@@ -7044,11 +7048,12 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 			set_bit(HCI_CONN_PA_SYNC, &bis->flags);
 
 		bis->iso_qos.bcast.big = ev->handle;
-		memset(&interval, 0, sizeof(interval));
-		memcpy(&interval, ev->latency, sizeof(ev->latency));
-		bis->iso_qos.bcast.in.interval = le32_to_cpu(interval);
-		/* Convert ISO Interval (1.25 ms slots) to latency (ms) */
-		bis->iso_qos.bcast.in.latency = le16_to_cpu(ev->interval) * 125 / 100;
+		/* The latency field of this event contains the transport latency
+		 * expressed in us, convert it to ms for consistency.
+		 */
+		bis->iso_qos.bcast.in.latency =
+			DIV_ROUND_CLOSEST(get_unaligned_le24(ev->latency),
+					  1000);
 		bis->iso_qos.bcast.in.sdu = le16_to_cpu(ev->max_pdu);
 
 		if (!ev->status) {
-- 
2.40.1

