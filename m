Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E48E18DF7F
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 11:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153524; cv=fail; b=QUDFl7Sntx8bw0B4dJPmbiXxv5EYGSF1EMDzT2OpOAEzUM48Zx+bfyN1wNc7cbfS981odv8mIcUpGwyMQ7HNCL1lg9wJUQPu/BE+/DaBQXqXAeGrZZpHcYahcz8YX1CBQXcAU44iY1/QBvwezRatDisvTPQql6w/sCE+JHNpqO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153524; c=relaxed/simple;
	bh=BxVSDg/Pv6eto9DcgnvVyE9mfyCXPDYb1q8OLkhowdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQjnY8+q8L+JZkH/stWPdeMo07rccm12Ip4g3Q7SHvgZkrR30ezy5IrSbg7a2ygshYCfTTYAbuCrl4O22x5qNWtXZCj09Io+jj2LGhr9vC50MaKZpoH5koj5a1VHnAPIbBxmpk3glzCIsgBa9fQ4TMhucjZEcLc9fjFJUnXyin8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GIyimcBW; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GIyimcBW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxDWOq/w/87R2RJoHCvx3SHtXMIMDhGXtDVytJ7K5lhwcJ6mxMu3HqpoaLs0XNH5lu9Yjj6yAbz4cKI1LLaPu69zqxwRmgn5Zq+sw0UFU4ZJSBnazHOl3sjxDLpGAzXA02eb+ghXqYH/ZhX9o6ELByPT19gHNspwZB+CA0Wd/wGXp45U4NxCTDyKrgY4cXEiaUs1oQ7ne0moeYnNjzvkK+OAbeqITpS3YqsN1HLD4YInMw3m6nAQU6xzde+XgopZS5CdxOQoYPI6T1tbvvlLuEb5G8wArHFu/0Hl3fpe+d2vZPCoVw5ic6WZ33KVlfPsqq5fmgLOwLgHfYHUXGV7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5GALXa3aqQZWi453HyFEu0wVCpAzcIZLQyaTd6SrYI=;
 b=ZEF9YtmLs5XmkOa7kriYkTPFirHkh/0uL5rGSIYCoM0vB305atGDw0TdKE6kIr/PDwKi8G8oXIHyEKiXXp9pSGPMga5CTxTXWB997JvfpnLiasIjeRL4JC/koSHZvcDSp1L6pdln5rioncBDiWKJ9neIT6zvAba9h3RpX4v7a00+dpxgh87b1LlZaruxxRGGaJZ4ryfrgtHiZI+sFlurzhfF1tU1WfZ3oOsPKvtTbkUkURy236Cs3daFWGCOnu5gBADw+oT6NAkPC+YdYS0PaPHfzpXPR4uZ76eSHqIEDTWyzMpIjZK6RJbAnrUbxmOHaofxpflWzTfPOpx+xDXSAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5GALXa3aqQZWi453HyFEu0wVCpAzcIZLQyaTd6SrYI=;
 b=GIyimcBW4jj3s2LPXSXVBBHAsX9ue0M/rXXYpmrKqNfId8+B/86ahRX4Oqs0WY/cnSypjjv0QpXrR/dwFEZF9wlwzWmR79yyZrVCEh2o6EyKbw7q6VYNBcJeCijxjAuIlPXu3KaptP3EIR6VPnbWIeex6GZ3tJ9WzX2NxwvJiekceUMJzqe9KA8+3z0aPfUqJxePKIlknRUh5kibwYyhQJVL4S7aV1RFWzL/aBK1i29DIT3RUSn8BuZGmr/e29k64oJpVB8FKcbO/ZvmGfeNzlnghl35pWXHbtwUYuNgHFZGd6pu/We/sN/S+Bu85tJgGu10z6J1jylfCkJG5PT/hQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB9993.eurprd04.prod.outlook.com (2603:10a6:150:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 11:32:00 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 11:31:59 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] client: Add bluetoothctl-assistant.1 man page
Date: Tue, 20 Aug 2024 14:31:53 +0300
Message-Id: <20240820113153.25708-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240820113153.25708-1-iulia.tanasescu@nxp.com>
References: <20240820113153.25708-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0010.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::15) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB9993:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f9cf12-883c-4069-0466-08dcc10bb498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GOMINMOn4+0+6denM2IBeY6DDNgVgvtcZOsnCEX+u/a9cWQacrLQRu9cLuRl?=
 =?us-ascii?Q?YCFHWLy3Hzxx+zyLdSr/T8UvhDVzSpj3j/VnBVu+TDNK8DV+MhpSwd1vIX6z?=
 =?us-ascii?Q?Mv1TCo672VrKRlQAFBryhWpcfH51OspObCnaa3zRMQHTE0NjXNfZFp9Q6fu9?=
 =?us-ascii?Q?La+x3aZ6x848BUAfMoY1EMAS0rIWByoE+wqkkUV2HfFT1K1qtDX3vo1aVQ/H?=
 =?us-ascii?Q?mmMvIlJP+6s7/E5uup/505KHZorK0U9FGDDyIUZLJRvR+vugLo4VdpEB36bg?=
 =?us-ascii?Q?oegeDWKDPsOam5LyeohoJNCs1Qx9I7tZP8L2/JCRYIaWy2Vb/K5THIxKcKo8?=
 =?us-ascii?Q?N8Bb9qkbTHXUmBkQzmE2mg2Nwq0TUWiX9beAPmhqub5bpY7NA+SVSutT5BtR?=
 =?us-ascii?Q?dqAxHOfRlnZDMvPpUQy2d3Zoo+qC/VfbBWaN1Aq1j+gZ0M0aC0qdjssHos+O?=
 =?us-ascii?Q?n8rsd780Ja4rPp5bwnmwgf3r2AXeNumHZC/v7vdzTl5Muy1syyUCTA8QQU4M?=
 =?us-ascii?Q?3KhM/LFOaP4fm3QmuLfupYg0U9uv3DQCmVPQ7tElB/OIUEyIsHKeyDl2urPJ?=
 =?us-ascii?Q?sHYVQ4rQnr/Pv9seKLzIB/aaIvDDYqoPwwKE5c25w3ImhaSAtosLI9K2zt+2?=
 =?us-ascii?Q?ROSeygMPPCngLevfxk5iP6oE0nGSCfSzc2v2VttrgL4lRKO2t2D5k3FdnEri?=
 =?us-ascii?Q?6obmx8wgyuRt0twEoE16jN+qCbBNsFFnqqUchjUc6Zp3FlAIVk9DUYA2dflW?=
 =?us-ascii?Q?5FXvUb2FRWhrxlD+CD28+Bdg0sk+cipHyUghHhD9CHqZ8mXLEQo1E0Vr/DG6?=
 =?us-ascii?Q?5K2BRPO2c+kS9oF/w3uN8Uv0VHyT1e8hmCrpLth8ugaL1eVoTBjHEJqRnPPv?=
 =?us-ascii?Q?INmJnRAbACePrwSEnbDUmrimn5WCCjuL+08JscpzKW5X769VSys4kmFD3k7/?=
 =?us-ascii?Q?f7i4WSWo5++oy+HxfR4kBaIkUo/gj/M8ExmJSftgOpoE16RDz4P5W2raIbdM?=
 =?us-ascii?Q?045h0r9MhMxeBYH2MSUx1U8CCwn4KFC4npRwufvYRdQbtEczUXnLV2ROQSug?=
 =?us-ascii?Q?GxJf3wia2y66DO/H+ENOFy9KOKVHGZXWVEp8l9VR/drEJsG6Ay1TJzsDcLTJ?=
 =?us-ascii?Q?RrLLxsVYitjLKWhAD4gsUPOFJfizkUgIx57bdmifKEGVHP+/HtwIKIDthNiV?=
 =?us-ascii?Q?nwG6KKiSA0UfMmd6O46AkUNAmTFB9ADX6c1fRUUk+4fj9TNAyNuDgSQvcmSD?=
 =?us-ascii?Q?lamqc5DyhzD/LOPn21k1nkzEbmfs870+uEzeeqnNtbLmhCab2llXE7bFC6D7?=
 =?us-ascii?Q?4Lo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qNsnMiSs2wDkcS6P0AGrQsx7mdVgDzsLD9zRHqVvngeb9zuYZh11rAxNLR4f?=
 =?us-ascii?Q?rkCBkElMvbMRKVMG28MD7kjdvdgOwNQUdwHNs9DicsfmoKCKTJs2L+1evu0h?=
 =?us-ascii?Q?h7LkOnvqJb0Bsx15loAPAnPYWcsYWW6IR9gLzKn1oNPVCBG7CiD4VoM56+Hv?=
 =?us-ascii?Q?0pwhxLsdpkgbRoIkTMEt5CyfN7e4GlGTpZf14Tt05iReXTPhVHzhMyzcUq/L?=
 =?us-ascii?Q?sqISa3paPLyDWqG/LPMmoNCiGpz57auRC2XDmRdlorpPbuZy1/Jm5BgXjhwB?=
 =?us-ascii?Q?CQzRO+94dVVOEOUr2Sxju0QprYx48YB0BHeQQzd3MVpeFUqHfT3CJse4FDXY?=
 =?us-ascii?Q?iomiW89HDYvLrfikMR7ZbKzjnIimVb4gROV7nKqjAYVFrtu+SYMqqbOHVVSq?=
 =?us-ascii?Q?mfqCYQRRwy4Jv1BgmhjsHDRmE8HNZ+chNvfDOAbdngXFyiFKyVXZ2Bj09jaH?=
 =?us-ascii?Q?jX07/1NEp+H7S4/S7vsI92IRbIDzsx8mmqh8eFRSx5DLz1gKUpVr3tbbrDbc?=
 =?us-ascii?Q?bQDSuGBGUWQS5DPcbJLd1TpmN1+EUmyVtZuakvSdbbppVPrgmlNqPV7e5rNc?=
 =?us-ascii?Q?gNA9wyErD9K6DzUEYVGcfiIdgCluD2iXk6KNJo7rk7aX7z+trYR4XBgPyNRQ?=
 =?us-ascii?Q?u9Yjr1ofwldKWpsgUr6c5xUQhqPEtWXgwkhMjdHvE6tsEmIkJ4CBiBWkI9q0?=
 =?us-ascii?Q?/IoKOhev3/KXFoxcqfkk5jP/lJ2BO5d4s/U2WQ+Ye68zmb7O19RLReQufi+i?=
 =?us-ascii?Q?b9GzL5zFHAmIHmalw10QLvS3i0OU7zfN8UC+kzffOauZIpmtgQFxoe0mRLTv?=
 =?us-ascii?Q?gCG4uxLNwd41K0GZ0gvThzVGF9SHZoeOpr2p7gyEpWN0wwMWoB8VdgJ/Jz32?=
 =?us-ascii?Q?JrXhLbv8FJODLi4ac3ZJsQceB5fKzyCI425V4iKUC9CJRtX5TKNOFrvD3Zrb?=
 =?us-ascii?Q?d+qi9H17OPjpaUI6LDhCuJOIFTzOEBTXwkJvNg6A90dh4sy+OjsmJOVzyKmZ?=
 =?us-ascii?Q?he8A0DBOo2XBiNqqe6vWgXcLIxseV1Zs8X+I9GMJs1aRKyrTcyL8Cd1JwOqA?=
 =?us-ascii?Q?FDK5pqTBANObhbaU/BhRUKoJOmy8yujyHuo9Um1sslrKkJ1MI+I92Tw1vRFR?=
 =?us-ascii?Q?Vwn1z4B+wzisq5UDC1iIt7oMZdAUFG4cpCSK9Qy+i9JFKPhzvWKZ3uroU/Mg?=
 =?us-ascii?Q?M5abY6cCDK1Dhg3ZwMVEsoBN4lX6mCU2WsDLSiFZia8gxLiZYLCgCtoV9UyD?=
 =?us-ascii?Q?FlMvVvIgmAx7dqu7fsuwnVD85oMDPWfsEmnPbrkl1XGb1OJL6FfzMlvxfbX6?=
 =?us-ascii?Q?l134tvm0+a7WR/1P88m7UBaz8TP8jXqV9rHYmgPZA1IEPHvFrIN6pckRs5e8?=
 =?us-ascii?Q?yEILr00qTRLHNir7OroQI5o67LqYGyM+Wtq+KUhzO6IxbbTn+p2MdWsGikrx?=
 =?us-ascii?Q?rIDE9Lb/QrFE8anAyyk2+TaOsw8e27qcnN1vZ9ar9V1YDlzW7mb+ziztbBDn?=
 =?us-ascii?Q?VEwZQnap1TnmOpINAnpcWBs48bpDsyrBkJ12myD9K66pqBQajOUXPM0IJnfi?=
 =?us-ascii?Q?HZO9gKKLDHySvYKckIHT1I40BDL5VHrn+5qxckcgJiqumkotilxvXMMETHyY?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f9cf12-883c-4069-0466-08dcc10bb498
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 11:31:59.9177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/QOtX//zpNYxcpR7S2E2F6iT06/mmCJ6fr1ekYlK4n5XW3uX3PVVqlTnFWhuF3dOjBoWras84OY4tqhZGjANw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9993

This adds bluetoothctl-assistant.rst which is then converted to
bluetoothctl-assistant.1 using rst2man.
---
 Makefile.tools                    |  6 ++-
 client/bluetoothctl-assistant.rst | 63 +++++++++++++++++++++++++++++++
 client/bluetoothctl.rst           |  5 +++
 3 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100644 client/bluetoothctl-assistant.rst

diff --git a/Makefile.tools b/Makefile.tools
index f4f9e82dc..5b9034078 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -349,7 +349,8 @@ man_MANS += tools/rctest.1 tools/l2ping.1 tools/btattach.1 tools/isotest.1 \
 		client/bluetoothctl-monitor.1 client/bluetoothctl-admin.1 \
 		client/bluetoothctl-advertise.1 client/bluetoothctl-endpoint.1 \
 		client/bluetoothctl-gatt.1 client/bluetoothctl-player.1 \
-		client/bluetoothctl-scan.1 client/bluetoothctl-transport.1
+		client/bluetoothctl-scan.1 client/bluetoothctl-transport.1 \
+		client/bluetoothctl-assistant.1
 
 endif
 
@@ -481,7 +482,8 @@ manual_pages += tools/hciattach.1 tools/hciconfig.1 \
 			client/bluetoothctl-gatt.1 \
 			client/bluetoothctl-player.1 \
 			client/bluetoothctl-scan.1 \
-			client/bluetoothctl-transport.1
+			client/bluetoothctl-transport.1 \
+			client/bluetoothctl-assistant.1
 
 if HID2HCI
 udevdir = $(UDEV_DIR)
diff --git a/client/bluetoothctl-assistant.rst b/client/bluetoothctl-assistant.rst
new file mode 100644
index 000000000..b4f7d039b
--- /dev/null
+++ b/client/bluetoothctl-assistant.rst
@@ -0,0 +1,63 @@
+======================
+bluetoothctl-assistant
+======================
+
+-----------------
+Assistant Submenu
+-----------------
+
+:Version: BlueZ
+:Copyright: Free use of this software is granted under ther terms of the GNU
+            Lesser General Public Licenses (LGPL).
+:Date: August 2024
+:Manual section: 1
+:Manual group: Linux System Administration
+
+SYNOPSIS
+========
+
+**bluetoothctl** [--options] [assistant.commands]
+
+Assistant Commands
+==================
+
+push
+----
+
+Send stream information to peer.
+
+This command is used by a BAP Broadcast Assistant to send
+information about a broadcast stream to a peer BAP Scan
+Delegator.
+
+The information is sent via a GATT Write Command for the
+BASS Broadcast Audio Scan Control Point characteristic.
+
+After issuing the command, the user is prompted to enter
+stream metadata LTVs to send to the peer. If the auto
+option is chosen, the Broadcast Assistant will send the
+default metadata discovered about the stream. Otherwise,
+the default metadata will be overwritten by the LTVs
+entered by the user.
+
+If the stream is encrypted, the user will also be prompted
+to enter the Broadcast Code. This is a 16 bytes array which
+will be used by the peer to decrypt the stream. If the auto
+value is chosen, a zero filled array will be sent to the peer.
+Otherwise, the bytes entered by the user will be sent.
+
+:Usage: **# push <assistant>**
+:Example: | **# push /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1**
+          | **[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00**
+          | **[Assistant] Enter Broadcast Code (auto/value): 0x01 0x02 0x68 0x05 0x53
+                          0xf1 0x41 0x5a 0xa2 0x65 0xbb 0xaf 0xc6 0xea 0x03 0xb8**
+
+RESOURCES
+=========
+
+http://www.bluez.org
+
+REPORTING BUGS
+==============
+
+linux-bluetooth@vger.kernel.org
diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
index 7e00ae3ac..7454c1d08 100644
--- a/client/bluetoothctl.rst
+++ b/client/bluetoothctl.rst
@@ -334,6 +334,11 @@ Management Submenu
 
 See **bluetoothctl-mgmt(1)**
 
+Assistant Submenu
+==================
+
+See **bluetoothctl-assistant(1)**
+
 AUTOMATION
 ==========
 Two common ways to automate the tool are to use Here Docs or the program expect.
-- 
2.39.2

