Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2083.outbound.protection.outlook.com [40.107.249.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089FD1D0B8C
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Oct 2024 14:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727878452; cv=fail; b=VSky+ul//ipKWXpsMR4eVgD+3d+GuxbgeTvYwLhwrtODZdDB+adCt9rB94e0vq9DWax6I+kkxSnHoMqmG5MuKeG5K3SpIpH2Y+egaTtR7lr/makUfv79stUqI8uE1rHhzSBzhldwJZUiB2wVmoCl2jbWUOUNrjAmH4y5/w0uzGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727878452; c=relaxed/simple;
	bh=OPlnktGzOHZRb1eLJ910PpYwikQF685vlMCd1R/lV7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NLIuBvY+AUt0IIBZnGpjQq5CaNpOW5Zi3NKXiUnl4pj2C5xdeGpUcQWyiFPe4Q/quzdrNyUwKdrqDyeJ3/nGoz+h/jJvm7KPjC/qDLLHp5H7wiPlI7jgvpsD5hCUT6shPLnUIhi15FvEnmCc9SF0slHMvqbHNs9Xn/fO97Z0+w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SD9zj2G0; arc=fail smtp.client-ip=40.107.249.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SD9zj2G0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo+tefmDagUwGb+DxItUxjk2/QRfwlrkMdnRcpJO0goACoQQTHDDbm8MJbwyKnzNxJleyrke2dZYTAqVICsTHHIQ92rMROKfGNpr/+v+WAHBqkJTh5heDaD3kkbGN2zeCOIsrIInR3JH8xL1yUE5Hv36nYxJOdKdVQV8OX0xxVyt7PjTv4VPrm3jKD7W80mHBrQXhh5k2ldELd3I/W5eCT7GQVCRbxUuxjMl9pCXl5BXxbiCfXkd/PV1jqarp6SViLo7rRIicsh/U5M14ThO7T02N6/XWc3PqckO3+pZGFhiR77E1zgj6BmA6S4bXxU3x6efPo//X8C9lK0wxyYYsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYXzk596IuZ6+cZc9P0830b73Y5NGUZPFbTiiThbCAc=;
 b=iV5tRcX0kp1rLokWnMOeEzw+SEwxG0d0bTc9nMaeoPUU+r1cNyeqkpUdlkQqT7cnkFzx+66g6yo/8POBcs27A4GOzT9MLQaqK6F/6xtbW0Om1PXfO5v4NN3rPkNxtB6BtBgLYKhAFgYc1fgtIk6Xika/WSp0SySkjabvj3yUrBCnMHe6rvPLdnJtjyyth2/ry18vgaiOmI73F6HviYafiIVeyZ1LFpJIRN8v0DCqEQrFIixyPrX5u+z5qPZ6bhc5f3YwfOUmsVWcR8AtUAvV3FWNEUo5kki+e/2/fJLQ122GT151pQe+G+DZIZfY6USUomHhmTRVrSIqXAtm58qV7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hYXzk596IuZ6+cZc9P0830b73Y5NGUZPFbTiiThbCAc=;
 b=SD9zj2G07NA7hti4sDqh6jZCpX+ifJIIii6S0QHHtOETxUMz69DeN3Ajy/gPMClE6FSahsYF4YtuG76j3U4aw/EDnRnN4sPl+0cYGbg+iijTEnYvdvLAAnDvaYwa5YZTXoSNoogAE1SlkRyFydYOlA9PrQlXGmKh3oUlPmkuBB9iqoyPQkgoJn30I3IVZm1jMPd5wG9qX6yufdkgSyeJsWQqPfdICObJeFqEhJZwaZteyqd5ISfW1PRj6qmRBl3EhShQWz6XUfPV33dLN+g6ZwVrpRrIqj3QbJshSCAJ15Hy1rdCflMip7SQkDoh5xoC9QLDm5O6eBOLQ+m+l8IMOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB8400.eurprd04.prod.outlook.com (2603:10a6:20b:3e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 14:14:08 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8026.014; Wed, 2 Oct 2024
 14:14:08 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] client: Add Broadcast Assistant/Scan Delegator scripts
Date: Wed,  2 Oct 2024 17:13:45 +0300
Message-ID: <20241002141345.27931-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002141345.27931-1-iulia.tanasescu@nxp.com>
References: <20241002141345.27931-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0056.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB8400:EE_
X-MS-Office365-Filtering-Correlation-Id: 538eac36-63ff-4fb2-c5ba-08dce2ec7abd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YTOh2XWLtHTHKUNKRKR+jcNnWlL/3eJpnwu28ayx5YPOZo+Q5TZqZD8orRz2?=
 =?us-ascii?Q?UJvA+50LzsjGhlMHBSd+pftNvyfxpGncZwKU4k3lBKXdhr4QqDOYvQQskFGo?=
 =?us-ascii?Q?ruhZ/CHnA9dI4mCXzzkExlL5Dqc2wLCAWwcgqQseWsbJ6fPjghH6wkhUyXVc?=
 =?us-ascii?Q?nPdtE7JoCRxyl7kA1H3qfucrNTYy9I4MF3i/exIm+zOTYbm2fzTku9BJvZUc?=
 =?us-ascii?Q?PFCVglIxWm6R7NbR3/7JlqlWx3D0qXofeZO+jPB5vMgGBe4qzWFU63TJCrdV?=
 =?us-ascii?Q?ttP8elW29DthCn12aqzenBgyoB4Pou6MgzaJzpBIjxsLcM7HLhjBOfT97PZz?=
 =?us-ascii?Q?mh1FbnIQC+fbgR5eZTumh32St1YZD/ApZXeXffd9ecxknfrILl7tg7nIAhmb?=
 =?us-ascii?Q?yUzMIqK+xraQpgRB4yT4FRzqCrSl2SFuGWqkgzsXRe3ETsJnIiL7nT7BIJWV?=
 =?us-ascii?Q?VBDWBNnANFt9P64Ck4EXKdxVmcAjW2rUewr/D/lNR6oXxXRaRQWHuLTb50cN?=
 =?us-ascii?Q?2qqAAS2RS6zObDJAjktdGAXgiNjhpP0aQ6XBty2jKDVoR5ub7mqDf4AhU+5M?=
 =?us-ascii?Q?YsvflFQaMVPz9jQPw7zjgQGaM8DLB3/nuWnlMG2VQtcPBGNZuXuXQzDyj9Pa?=
 =?us-ascii?Q?fyMW4GR43CV6rBnxe4+pTxl5DWfeoMGyTuar4tG5khvDclAmMJ6uXjwijBuu?=
 =?us-ascii?Q?+ZEP70527g9VhjdGRyWqLTVZFKHBhEkIkw0GtmOAdMAGEOPBHzAP4gD7h8jI?=
 =?us-ascii?Q?ZzMYDPxuEu4XwpdCMTV9riFz3pBfLS53l5fphgCIu4wjdUc2q0pRqhBVpPwa?=
 =?us-ascii?Q?/yZpq5+UF34c0kHqqWUgnPs3bnr5UkMKNlI0vxJT2OrikrYJaIoYFiSy5kVz?=
 =?us-ascii?Q?F3qLBgGuQnvCt0L7nsH062bqGORmxL4y50k1SmAyjMsbbojosOtbgCtLUPZp?=
 =?us-ascii?Q?6+mfqNqFv5CwUyq4Cbu07uKhuN+s+iS/wwvwzsNKDux6v73HjfZD3bx61QgD?=
 =?us-ascii?Q?FEWsJqjVyqyzL9NO0s6fvvIGeZBYvTVjFGopnQSuB6Fb3Q5RPqj6uGYv6wxb?=
 =?us-ascii?Q?jToQ0MZVHm7nuPKBfrgAG3r89rmCkRY4OVkMnr48DIzi0QRPsR/U6l7r6tE4?=
 =?us-ascii?Q?33lnk3POXKRr+n7Lhzd0lQIUrADWFxjlFTbcre2eA6iHsbkN+XIPGI3/MDS0?=
 =?us-ascii?Q?VL3yg0F3kk6hdrfI1RI7bCuDT1/pXIgjbjoI3CKXA8T3uWWGgH1j2Ek+qSfw?=
 =?us-ascii?Q?pH4erxcAxzjfnUl+llwF/eneqPM+MW+yEZRFHyMxHU1Aj4sGaaWYakgjksqc?=
 =?us-ascii?Q?DVBUoOwX948Q4yazFqxDO582VcwmCtsCogQmZ4ltgfMYQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mvNzDf9iFzNAKYd8c5NU46ol4YGvfPkGi8qORKv5rvuTBN05WgsfRrHnBPFp?=
 =?us-ascii?Q?ZJV2ZJpySxwtMna28kwdedyIGX5pTqvbmr1pQKdWpc5HG+CflqGq7RmH6x/O?=
 =?us-ascii?Q?5c8TxOe2AqXnfFcFuT+9f8M3iV+o27VqkjbRPVaZjx4pY9W5QjtCg4o8QSk2?=
 =?us-ascii?Q?7YKDyJat30gkx6EKFQ7WKOpXBk/6k3wT6ATyySRsl/C352L5OZVnnsdDKOXq?=
 =?us-ascii?Q?62mXiabbzbJJNa0mucDjdRFuJ4Ue36e+ypiER4zEpy3usC4oe/9z07ng+ZIb?=
 =?us-ascii?Q?Bbgt9BJNB1FhqEPwiBG391sJxuJ7vJadu2pPJjL3Vd18jYtqTB6Du3np3IjZ?=
 =?us-ascii?Q?6vS54nU06iSpndtL8pPNLwQPrlEogTD5SCuEwm6mqDVEqioknTM4RQk3PZEh?=
 =?us-ascii?Q?ywXC5GkoZ7XN1G5tyFJMTqUmFSG5aHXNYqYSuq+QjcOUtkZEwNiqOQEYuahq?=
 =?us-ascii?Q?zF975uGkw5GgoJLcvUoLzQVqd0vkRdjrvvvibPJw7pY2nblKDbjxWr/R3tOy?=
 =?us-ascii?Q?UNU8ipmhZsMos0FPuOCbwOuZcUHM6f5aHvp4fI9pBoNpNz1/7GPeXjZhHfUk?=
 =?us-ascii?Q?ZAAf53gInwYBPyZxEduVWAGSPktQ0pJ1DIx86SZMUXwKM2SGLR/eBQcQ0QHY?=
 =?us-ascii?Q?IfuGMgJpPUebh+PQJtJBiicHcJUmfMIDAiaknMeHnM8Ve0jjQf845GMUkcDj?=
 =?us-ascii?Q?Hqi7hBe17SUIP6bykTeQMEyrl1ab2fKGI+XITIN4DEunMHpZxCmYkMLF0FM2?=
 =?us-ascii?Q?npEhBQK6ZQtKl+VY9An9Q83ezVyu64UTRcMiL060/h0h+5ARUIp+IZd8cGvC?=
 =?us-ascii?Q?H7XHGKRjSTj97YwvNtd732J2YaDy4zqUVuL3z8vgFuqztyHPQw5VUf1vIQ6n?=
 =?us-ascii?Q?TxAyPzMotIhC3jBScJDEQ4K1aY2sTHzoH4ynPQF71prhw9eamsTUTfgXaC+9?=
 =?us-ascii?Q?HkmpQqYzsZSbk5nkiiGHPzx011jpGTa7pr8Yqv0vaoq8PKxwMke/A6Oyt+mC?=
 =?us-ascii?Q?uIM4qlkwXy1yLB7KVYBGK+k3mAiB51E9T4BmNXvQZPbCXLOG9v9AvGoqVcsb?=
 =?us-ascii?Q?wBHYxBsR5/nBG4T2GXNo4tsP4ESwUgeks6hs4G0Bjyq1qhiJDQRUABwTG3ax?=
 =?us-ascii?Q?+pzurpI5lgiWSzPtYQrh5TLuEvNoTqoKSqzqYqvEtHrAx/2qphMSm2vYnlUE?=
 =?us-ascii?Q?i7lzkahpsM4fHoJOdqrvKiQiKFfzrZGouhjnsJfSYbcOvslyhqC0A0vE1Sso?=
 =?us-ascii?Q?SlNUU0BxmJR4KWr5Osb1ievVsJS/15BN8msuXGvAXxsBzD7j8L0C/o7LBirA?=
 =?us-ascii?Q?Maz/KxcnS3Zi3urX3f2oL7QDiq7e/GqW7G6mU1yMSn7Iyz3fKtyG5qEiYoUr?=
 =?us-ascii?Q?HQHkWOdpapUATuHN4x0xERBejm0HC75blxCqBmeBw6tmeJKogPXl51E1585D?=
 =?us-ascii?Q?btMNMWQmTEnB8bCro/TABBzYUsyoX+S0Aw4eAXbuUwe/Z2mPH24U3c9ndVYW?=
 =?us-ascii?Q?RyAxymkriSbDj4F/Uo15l3qRp8B1lR7jPF/niumMFe7HkwPrGHOMHz4+/5+e?=
 =?us-ascii?Q?ZaK8TSxkTtt+QvKcI+1H0V7LQVPmPpSPzDZNsCiEc7dFzMdoUFR4vomD/tVI?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538eac36-63ff-4fb2-c5ba-08dce2ec7abd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:14:08.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +pfOaw6KpOSAEFvM8ZgRI+G2E2+X0jL8s3k1Bh3M2mVT1PdJtWYpSXmOsYdEqRGKgnl8QiKxQTt1fa37AHNCJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8400

This adds sample bluetoothctl scripts for the Broadcast
Assistant/Scan Delegator scenarios.

A test setup can be created using these 2 scripts and the
broadcast-source.bt script: The Broadcast Assistant connects
to the Scan Delegator and sends information about a broadcast
stream.
---
 client/scripts/broadcast-assistant.bt | 38 +++++++++++++++++++++++++++
 client/scripts/scan-delegator.bt      | 28 ++++++++++++++++++++
 2 files changed, 66 insertions(+)
 create mode 100644 client/scripts/broadcast-assistant.bt
 create mode 100644 client/scripts/scan-delegator.bt

diff --git a/client/scripts/broadcast-assistant.bt b/client/scripts/broadcast-assistant.bt
new file mode 100644
index 000000000..15e9d0980
--- /dev/null
+++ b/client/scripts/broadcast-assistant.bt
@@ -0,0 +1,38 @@
+power on
+#
+#
+# Start scanning to discover the Scan Delegator
+#
+scan on
+#
+#
+# After the Scan Delegator device is created, stop scanning
+# and connect to the address.
+#
+# scan off
+# connect xx:xx:xx:xx:xx:xx
+#
+#
+# After the connection has been established, restart scanning
+# to detect Broadcast Sources.
+#
+# scan on
+#
+#
+# As Broadcast Sources are scanned, MediaAssistant objects are
+# created for all BISes that match the audio capabilities of the
+# Scan Delegator. Select a stream to send to the Scan Delegator
+# using the "push" command from the assistant submenu. When asked
+# to enter stream metadata, the "auto" option will keep the LTV
+# values advertised by the Broadcast Source. By entering new LTV
+# values, the default metadata will be overwritten.
+#
+# assistant.push /org/bluez/hci0/src_yy_yy_yy_yy_yy_yy/dev_xx_xx_xx_xx_xx_xx/bis_n
+# [Assistant] Enter Metadata (auto/value): a
+#
+#
+# Wait for the MediaAssistant object to transition to "active"
+# state, to validate that the Scan Delegator has successfully
+# acquired the stream.
+#
+# [CHG] Assistant /org/bluez/hci0/src_yy_yy_yy_yy_yy_yy/dev_xx_xx_xx_xx_xx_xx/bis_n State: active
\ No newline at end of file
diff --git a/client/scripts/scan-delegator.bt b/client/scripts/scan-delegator.bt
new file mode 100644
index 000000000..68c7fb498
--- /dev/null
+++ b/client/scripts/scan-delegator.bt
@@ -0,0 +1,28 @@
+power on
+#
+#
+# Register Broadcast Sink endpoint
+#
+endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
+y
+a
+3
+4
+#
+# Start advertising and wait for a Broadcast Assistant
+# to connect.
+#
+advertise on
+#
+#
+# After the connection has been established, transports will
+# be created for streams added by the Bradcast Assistant that
+# match the audio capabilities chosen at endpoint register.
+# Acquire the desired transport to start receiving audio.
+#
+# transport.acquire /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/bis_n/fd_m
+#
+#
+# Check that the transport has transitioned to "active" state
+#
+# [CHG] Transport /org/bluez/hci0/dev_xx_xx_xx_xx_xx_xx/bis_n/fd_m State: active
\ No newline at end of file
-- 
2.43.0

