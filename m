Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F0156984
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859484; cv=fail; b=Jl2oCWXfi5jiFnhvOMsIamve4K/KZTEaKLtyhloguWRMthTsQj5ps4cmZbOe847JSLpFzodPd1TPlyii0VArOP/WUJwRkJNtp7hWfd3sWr45pycFWbFz6OjNsuBLO6saSqKCgGgdKU7wsbi8GXqaS+jDo6WG2UZMolUj/+s2r7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859484; c=relaxed/simple;
	bh=Dm12jg2pSklaaacwSlbmlsh6UHqM89yOEzBpX2MEoWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h1huI0qvrBFdYn19o2zhnPQrwhJp2CriSOoHyCGHexkn0vuwQ7fs97ajQulIMZsFeElRnTQnzP3SxLqJnmJa7kxASmf5RgJRJePBk1dpRL3ERpq9GvfTjWGwD6zZ95yzf7r7LmNIZVmVbTnTCu4bIVrwVvHD+uFg37pEDpre0Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WFbmau/z; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WFbmau/z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u8/FeXIT6jShpU4KyZETMzBQkcnX16q0WDaSfU73Gbrs/PfaGizBZo02E7u2v6yktzY/uAW3l7BtR2S2+Lf9Urb3jI8RLzLK5jXVTUt9PuBrZpiim4MBQYOQW9WILKsdas6JweICiwxbJffQSNk+fB31VOJgX0aKyUywUzg4H+ngz4OJUewmGV+dQqBiwggEWF3qIwWa4qai0dEjbcW+m19W6yvdTNSTjX8HY2KeOYUxrSJuieBLqX4n+ZE55gNmnL7fVOjjld4F0LRkhsosDsmOxYhjqJwDxwN7iY06dj0u4u5z4a/gM3DIbRdqsriUAQkv8ApwF1uyV7GciQvlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTM+jvPG9/QfVnetjLd7Qn2KKAkjhBlo6TkN/w5IylE=;
 b=EMDoGQn4TdEgQuLw3Fx0uYCNlSqOO7OZxHQz5XK+GKYOS7LdIdAsx+A6M7+3wEJj3bqoFKlI/j1gUcXDVBjfgTJIIFJvj6kUK9A2nyUvwiNyV6xuEzsOU1J5w2wIrOnIIrTVeYOz+uL7mdP/7tnXyAXDFHp4POe1bbnIYc0NiDL93phPYo3lJLDs7eXAqU7mngpXOp3PTUW8Vxo7bYyn5ylJRoWQFoi0Qm5fxC1JlUncP/NrqgSaQp9Fj4LurjI3FgoB9zHR0HDyqOQJ6LozfF3sqIeqPe+m5dEMFbEPyl+A6Rq5ZcrVJUWW0IN5Coyeh5m6/cT3SlBsLB/8LYf6Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTM+jvPG9/QfVnetjLd7Qn2KKAkjhBlo6TkN/w5IylE=;
 b=WFbmau/zI5cQthqy4/TuI4KzVzikxtHWTwHIfvCLZibqCaqfatw7GNirXkrLcbc2/S1GO1lrToiqUKv1n71GkH0cQgFwEvRpu2PMzv+4iejHQ00Y9DPh/oy8LUgWSgsADx6lM7PVIw9d7j8XLZ9bCdVL5fbTAf9rza+0afJbbUhHJNZHtFjke9Row+H44iwFHK8rCD1I1eCQl2X4P4ujmAgeixkdUfPVb8MIUZ0PpTzd0He2LYXtkmyeTyNsz9TuKLDjtr1CqTR5JZQsnUzqYAK8TA5zALYy77g8oRlorBcssbSyK6sLmuBztJ13PYNAYhCdc6C+LB8JBMGzsl6r4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10499.eurprd04.prod.outlook.com (2603:10a6:10:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:04:38 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:04:38 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/7] shared/bass: Add API to send GATT write command
Date: Mon,  5 Aug 2024 15:04:23 +0300
Message-Id: <20240805120429.67606-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
References: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0027.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10499:EE_
X-MS-Office365-Filtering-Correlation-Id: a770b237-a3d4-4d8d-5122-08dcb546c7c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KAq2P5Syv76mE3EoU3mRVmpi9OnNNQFsUQDlJiJIdzrg3aEBQVMVAlKbMxfi?=
 =?us-ascii?Q?uWdPtNAGaLpR8HMIqjXrYLu8BIk/rZHN5iDR9l5fLZGGvK1WcXYTZU6Mq2J+?=
 =?us-ascii?Q?a76jxpBdCqAdZ4cnAPNJmHn713zR+mAB/l4sOg5In5hSJzfRT3wBRI85FIpz?=
 =?us-ascii?Q?ETzwr5bFipTW+t0hBggg9i+esjbokZaUG8kYOoF1qM64Wk7BVqDLbi8afRPM?=
 =?us-ascii?Q?T5c+Bi3UFPwA5luS7212mY794gcEvhUDdwgBA9kqeG3M/a2+iE42Q2dGstXa?=
 =?us-ascii?Q?hOaAmx/TFgmMhj8d0poxrMKTnNaDhsB35oV5fedRGrFwJDGl70b7gmi0JLvo?=
 =?us-ascii?Q?BN8UbW5CYD0HtbL99+LCU/Mr8l491OovybzpILyRz7Zu1ya/agjfjzfPGwPN?=
 =?us-ascii?Q?eASN+0jffseHjx56YBKfWk0M1alyYcX1TlMmQEWFq7dLO8LiEejosl0WpqWs?=
 =?us-ascii?Q?BqYmyBNr1l/kB71ntDYnpdXbXeIOFXmRvhs8Qpk38Vvf/u86uQohw3Dp6TDO?=
 =?us-ascii?Q?gDADfGEjKC2Fk+XRxJ0GRCz31TDvHTwkm8Nnpf1aMkV21rmy7J0+lEMHQLzx?=
 =?us-ascii?Q?V9U04TLSOWuHzwtlWZQNniwNldHJSFR/YyadBd66BbPJ0W7Gy3dqo8gjqkI6?=
 =?us-ascii?Q?niLS3e1PviHEz4IcUAst7W7DeMovV+kYo3rjJS3C/Ft4RqDUXjEoqLxlgLOE?=
 =?us-ascii?Q?FqHQWvd6LE9VsxyERbcIepB6dg9CvgeyccZAcKSQc1vdBQh6u7DLQuhSi/DK?=
 =?us-ascii?Q?M5tF6CmRB1Ob7LUvJ8F++eC74okPyuds8C1PCMIdDlXZ+zvfM12BWaGc5sdD?=
 =?us-ascii?Q?qUTvvoJRN59GAPhDWnRwk1QpwO+fgzzmTGoy3XPjAOVHQSq85E8ZoFr+KZnY?=
 =?us-ascii?Q?w6rIIytBpy/HU6fNiiSpnjL1/nATqHujdlQ3sxZrFLT2LqYz0izQRxZYrkj3?=
 =?us-ascii?Q?Se/PdD97Flh4+a8PeXXSdvdrCUhLXCBT7i9leESr66xP2jhuX7TuEe6C7kx8?=
 =?us-ascii?Q?rcxkE6ZOio/sMRiIRy4D18/t6/P/asP3rbDs2q3ywisBIBkK7G8kAqBljDK8?=
 =?us-ascii?Q?jUChgTUg2uBQdBhaI+b2O6a5SD0ux/vjLEfRgGXEcwQVLgZ0U9fbeKXl5EeH?=
 =?us-ascii?Q?keJZFE6fO1xOiFnp5ok+sE0u3KBRj48Qf9OGPw5DB5asa9hqxs7HFR1ldsdh?=
 =?us-ascii?Q?r1uVPoGqvIbzCH7lVzYLEUU1TUey2hmBpHMp7NDRF2c+MMmrWDjYgePsRmtY?=
 =?us-ascii?Q?sNEO3WrH4EQHJw0rgSMUhsIrzTnbLeIxhpUi4zuTqYugOo+vPNMk3uhPxYTm?=
 =?us-ascii?Q?7kd/rNkol/9zXjC+RL1VLde2SBZP26Wk/P+zzzVTIvOG6w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Yr6ZVFycMbYRwpCYuscq2XNUlnKY7rkqfwM+8DK3aTvCvpEnhw8t3H9TzBO?=
 =?us-ascii?Q?dPPmNqIU92l2MFLVDcNeIpzkxzoN1gYgya7I7oAKazm2foaKM0+r52ta/Wsk?=
 =?us-ascii?Q?ObvTnYKUY+z2aaZlXMtuRcs3EYFn3L0o5/u8U2Vd8j/7GH09vDtmytwptqqD?=
 =?us-ascii?Q?n3GNzyA7O7lUexlpzlbMe5CIqzp9JXtskZ9xidvJTmHlB5IVepSju/azW/et?=
 =?us-ascii?Q?Ow1qSww7/09jYNonqONUzYrXM+LyHk0Mt076Naqi2F7jEGnk/uJUI3EUYaJB?=
 =?us-ascii?Q?Pmw3jujrqG6gPhcjTsqn28FHiWQF2des1fNyj7ziMkXC4eDY6NGg+vUdcqR0?=
 =?us-ascii?Q?3ju0Kz1f9xfL10RJ/FeB7oZPcG5T7p+GGTD+sHEdNKa4l7QoTBS8zllY+G90?=
 =?us-ascii?Q?Yqo1GEzWuhnLiwnJ6cQs+74KeJCGt7eMpUKXHeOkRkQbWXji7MJziTqYcoZn?=
 =?us-ascii?Q?oXpBHmH/vkgiSQ6tqmc/pDqkYRX6MLqxTy7o8aQiFgpKYWBdkFeZ1+q3G7dD?=
 =?us-ascii?Q?9PC4klfHK8m3BzfXfT2II4PWpUfkDDZQPjkq9aDi9RcKrTbAmdf1utvEx9dj?=
 =?us-ascii?Q?xPmcQgEahnbgj8DJdh0/wN5G1RsmKES0i4TxxpjoV1MiPnwwYX3d4jO75sQK?=
 =?us-ascii?Q?FLhqd9UitRGnzQqnT0S1HTCfkBvtjn1HZvqMJ1+oD91ndvbYN528+SQuv4cN?=
 =?us-ascii?Q?LgtIxd+8U73w0JIIVomj47U9owJ16b1S0OYu7eVcoWb0iti4h46u58Je5i9E?=
 =?us-ascii?Q?cGmOoq5+6vQEs3n3sPgo+w38Hv2AKZ2MNhtubexyu+p2SbLB0Nk6lZ9gXN9B?=
 =?us-ascii?Q?IwotORWp90Ugl1BwtlVhVxWNBogvgReHxCpnBbw1mGZsDsyH3K2sjbgFt/+7?=
 =?us-ascii?Q?mavzPdZ+gqLEphAQK6uBM2thav+HlhWVaScR2RJySTdnd+rwhRmPOV4vwpQl?=
 =?us-ascii?Q?ZJj80rtvupEK/O5gLupExGR3q8ayaTvzwxjPEmJtLkVONMpEw0w/vNNPUUX6?=
 =?us-ascii?Q?xzeVt1eNqB+4MnprpRmHhVF3/ClBE2TUrJF9e+JOLTJk43uLXpuTzVAOL3zm?=
 =?us-ascii?Q?coqnmYJR22+gUahcJSGuOUj45ZGhMDQ+2mHrIiyBiHeXx2NIcE3dLHzGvT36?=
 =?us-ascii?Q?YfitHSUNN2TcD/08Fg9AwyI1eqF1hZip+AbobtSRXb2QSyliG1QFsRgYHDGT?=
 =?us-ascii?Q?vdKpVYRxpmqX8iTikgfYcKEiL99CtgdTjEi00lq4Dz+hlfBMThhr87Cit+1I?=
 =?us-ascii?Q?kiHGWyYbDmKy2lCum+yxEMnNSi3d/8PRO18AyB3OXSvOYzgPuV71VWTrqk1K?=
 =?us-ascii?Q?pcyZK136YlhpkBQjCC5v4Dj+NBa2iq3vJyFd5yNxg9iai5ifoYOesuepee8Y?=
 =?us-ascii?Q?1lm2mrKJ9pA+fYMNUOuDFwImbP5F3wpj7F9L84Y1uyte5w3s8EVVSEmxV9UG?=
 =?us-ascii?Q?M/h4IlPoPxYzMfgfeBGN8Pjqa8ss5BPMziwmA4rlFMFfHSf7gzwAlCPHuBd2?=
 =?us-ascii?Q?+A/lzLHWcL/sSHfFsnH3MmYG2DnZ5Jizp7S0ucMZ9aEBl8rOUVbMxB45nNgJ?=
 =?us-ascii?Q?Y5XAz/9VW8m26c9wX2nOW2N3XdURG0drfPG1L5TzcEcnoegeESra4Gv6Wsfs?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a770b237-a3d4-4d8d-5122-08dcb546c7c7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:04:38.4675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7M4cYAhuhemEX+Y5fDpyLrE7USvK5n0hAVzZcGeL8EWa4jv0yNiQbH55m8dlsoSXcaiqghm7e8PsIEi5Ridvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10499

This adds a BASS API to send a GATT write command for the
Broadcast Audio Scan Control Point characteristic.
---
 src/shared/bass.c | 38 +++++++++++++++++++++++++++++++++++++-
 src/shared/bass.h |  5 ++++-
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 268e3bd86..d9ab210b7 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -3,7 +3,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  */
 
@@ -1754,3 +1754,39 @@ void bt_bass_add_db(struct gatt_db *db, const bdaddr_t *adapter_bdaddr)
 {
 	bass_db_new(db, adapter_bdaddr);
 }
+
+int bt_bass_send(struct bt_bass *bass,
+		struct bt_bass_bcast_audio_scan_cp_hdr *hdr,
+		struct iovec *params)
+{
+	struct iovec req = {0};
+	uint16_t handle;
+	int err = 0;
+
+	if (!bass || !bass->client || !bass->rdb)
+		return -EINVAL;
+
+	DBG(bass, "bass %p", bass);
+
+	req.iov_base = malloc0(sizeof(*hdr) + params->iov_len);
+	if (!req.iov_base)
+		return -EINVAL;
+
+	util_iov_push_mem(&req, sizeof(*hdr), hdr);
+	util_iov_push_mem(&req, params->iov_len, params->iov_base);
+
+	if (!gatt_db_attribute_get_char_data(bass->rdb->bcast_audio_scan_cp,
+			NULL, &handle, NULL, NULL, NULL)) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (!bt_gatt_client_write_without_response(bass->client, handle,
+					false, req.iov_base, req.iov_len))
+		err = -EINVAL;
+
+done:
+	free(req.iov_base);
+
+	return err;
+}
diff --git a/src/shared/bass.h b/src/shared/bass.h
index 1674146bc..864b01637 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -3,7 +3,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  */
 
@@ -135,3 +135,6 @@ bool bt_bass_attach(struct bt_bass *bass, struct bt_gatt_client *client);
 bool bt_bass_set_att(struct bt_bass *bass, struct bt_att *att);
 void bt_bass_detach(struct bt_bass *bass);
 void bt_bass_add_db(struct gatt_db *db, const bdaddr_t *adapter_bdaddr);
+int bt_bass_send(struct bt_bass *bass,
+		struct bt_bass_bcast_audio_scan_cp_hdr *hdr,
+		struct iovec *params);
-- 
2.39.2

