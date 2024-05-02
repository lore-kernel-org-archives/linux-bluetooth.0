Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0C51016
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640514; cv=fail; b=ZxhknjYM7UvDLaHqd8eKPEf04dhC84QFQfXSTwyjqITWdhURmYNZ2ozyYG8z2vJ0De8Hm3hfsG2NLUKy1CQJWWUz/mkcFGN5YOXHzmCPkAztsF+OWMlm51I0h0Ewbt1PcDGhxWt1+dcEFTifK18UgE9vZX9cFSzdZ2oOUnK12Kg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640514; c=relaxed/simple;
	bh=9W/VFGgZ8NzlEwif3yKfy0WhI6emR0Y/+u/p4taYmEU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjJhTS4zH1gpsx/UVQk3OdA0RrI5HeXkn6L12teXVgBpNxhxi4gSdHVkyo5XsBiuZr5snKXX7Arn6YUGnZ8b/4s3nMUS+W2GQ0wNFJyXzs51q7ChjiBOtNBphqdwrTonJhEr0fwmn30tLsO+7Lseqh7zUZ6UPkmgXR2ZRF342+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PcSHv4Y4; arc=fail smtp.client-ip=40.107.20.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PcSHv4Y4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c1lIe+4kx0G0Naf/JahsNo18H96F4001EsnmLGKmnBLbljYitdBpiM93Q2RLM0CSenYx8aJEu014Uv1TiTwAEBFmP/bNg8L2CzVgK3jEV82jVtFSLHwY4OPNUPhyumjRkEVPRzgB9zZSQXWjPkHv/M0Ma7/zJrvkb9Iru9tQxV754F9/wUTiU1IIqTTkRcwOrqs/EwyrmEb2LGN7xuNdKZIpT/xfNmDd1hfFWQMZFIuPPV95VwkM9D+HvEBeZyI/20p2k2i19EwVc74j1cAOkyRjCYCXikexP4VR0qq65LeKsF2T8FLXWgJDHO8bmHgCzUduAFXejMqG5AJu8qzsWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q10oK3xj2o8Jb4rq1JbjHnR5Y0Kf9Csob6mpgrHRt/Y=;
 b=R6+oolmPJPdRGDqMUk+T2vnwJhWn7rp5oLpCUOKcgDMQ2aJfFlfpulNknb5PRZcQpb3Qd5TfdMuNbu/sc8wGz0+uEKzjL0zrKO7cJ9FkjFsEdKzMyjw634v8t8xPN1xXvFxYcDVZbbIYK2CWVDGUzIMkZYvl3hInhd8YDwFFswqMEUoH5/XKmpvBkuVizbhPDrbG4Reh++lLyGWtrVEOsliO676cry7hakXS7Oa++Typ1Y7q67ji/IMalfpzQyboi7BQNphOxqEcMnV/AQ3Rd+8AhmFlT32s01cmGbYiIpecIxbqrW89ofEOkfQ1YOqipm/IizojNxjk0TZj6CKFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q10oK3xj2o8Jb4rq1JbjHnR5Y0Kf9Csob6mpgrHRt/Y=;
 b=PcSHv4Y4EKvk7CZCoBOXYXVCsWt1Xkc9Qj9xWyO2aD2xAFgCT9+XU7//ypGl/lFW5h60aCAIazWcE54UWEaftneSpI6TVu9f7uVi8T2gbRTve2c4l3wgs0fhT2yRX0dVPTqfIETvRM/u9zp/Y1zbQlKSOyblbrS+RrsQKmhq2yM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by DBBPR04MB7932.eurprd04.prod.outlook.com (2603:10a6:10:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.24; Thu, 2 May
 2024 09:01:47 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2%3]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 09:01:47 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH Bluetooth v2 1/1] LE Create Connection command timeout increased to 20 secs
Date: Thu,  2 May 2024 12:01:23 +0300
Message-Id: <20240502090123.5177-2-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502090123.5177-1-mahesh.talewad@nxp.com>
References: <20240502090123.5177-1-mahesh.talewad@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0032.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::45) To AS5PR04MB9754.eurprd04.prod.outlook.com
 (2603:10a6:20b:654::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR04MB9754:EE_|DBBPR04MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d6b887f-18e6-4853-36bc-08dc6a867f81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|1800799015|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PvFwEd2gwWN1cTu4vVEm72+DFP/+QTxIUuBaxfMpxmRaiQd1TKccC5cEZGRJ?=
 =?us-ascii?Q?6h/foDx0+ol3Mh7T7fek2IozkleD/oAX8VjGVD3MyfsMNoF0Sahzt9AeGBoh?=
 =?us-ascii?Q?/aUjBkUYZGQoqrcBGDWfwm09tneNTThV5jf7lwULVCkQtHucxWORO33DfeUM?=
 =?us-ascii?Q?KqlHYdQfSoHLdRiYd5KPqb1bTkITJqUFLLexmxyzcl9CpVi+V+/+6h87H22M?=
 =?us-ascii?Q?pQpUixBtPoI9jR4IkrJkzBfhKN/WSeTs7jv310VU4SACEuGe8EKkmZVLEZpt?=
 =?us-ascii?Q?EteHQ6929/P7o0HnyeRVtvgqRzwqKT5K3BH5Kp0I/agTszeJnJzphEHXIsFd?=
 =?us-ascii?Q?o2Fp4z9JsLRPEBB/pae2m39q8VuLfdTqzHQt+97tG96GtbiXyg6ah6GpW57r?=
 =?us-ascii?Q?0WJ22eRsNMCRxZCyy5IUWkoNdJApqYybrYN2h5CM49j6hVJDcrYq3fJWP8h2?=
 =?us-ascii?Q?LlA4q6NBlHrI6EJXprdJ9O7dnSlx0Yq5js4vLHkGCJ4AEy5QM90taw//dLN3?=
 =?us-ascii?Q?lNQFD7GtnMComW0V8E1/exRwYsTFt9sDnxhOapbxDnCLAM1K5oxawL/onkyM?=
 =?us-ascii?Q?JtOi0wrxKK5/4Eqs4UVUl+DlpuQlS9vpCORc6ZS8FHL+2MCpVMgo+tqUbRM7?=
 =?us-ascii?Q?TIQaGDyuYEAOYClMNfCLtb8jBUbHxaRkkccjDcwjOcHl7m6q07d/N/Geiig4?=
 =?us-ascii?Q?YoKU0NJhu8SosWcC98Yxpf2VfDN0cSC58ewG3slgqqk/kyJvmdnKGN4RzwGp?=
 =?us-ascii?Q?KGKGoQvMac2beCakiE6WPXr5NFuSszFDfx2ZTVvpmvWf45o+I3NmBOkcigzD?=
 =?us-ascii?Q?he9AwcCXCkfsWr+bKuDJ8CAmG1y8MJZNwbXD9w2KLS/qgRa9W/eiSuVzNq0w?=
 =?us-ascii?Q?8HYYShRZmQZyMIrqBilCQaQsjlXj195RkcrpiQ6XrWSWTytZ9DoZ1oZ4V7wU?=
 =?us-ascii?Q?7bPoszWD4NY7lYoVhyF1kF6Hl3GaYYhyFelvdAFdzC19w/UWWMN5rqKdHnUi?=
 =?us-ascii?Q?azQ2UsYQsq2mgivVtDHWhZIM7+UzrowqBZmLmhDM07HoGMVWgE+QIV3aOxHR?=
 =?us-ascii?Q?YwfgVJsRW6o7OMlIj6BHj8VfT9DcE1Fxlh3HQoDTya9kG5Dp3yh3K1ElbIbC?=
 =?us-ascii?Q?Odk0xdDQBO/2S5fcgX0PsZhHfp0CsGuyWc72apLalJwUAWWnaLbMwKnA5aL3?=
 =?us-ascii?Q?yZ+w+z7e2xj0wDv45ZMZhc+/4jx6RFMEt+3W5q1XjS+33JD2juAxlOFr8MZD?=
 =?us-ascii?Q?MZKEL3+4CRUdCr8dXZc4LujtAUp0OEtHIDtVvxtTRlKULCjcNf576UPEVH54?=
 =?us-ascii?Q?4O3HVoxjF5vRBQiLJPP0tiWVGJca/X02yq9zKMN+p1NC3g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WLtvhloYEHsiI+LLaKBSAfr4hsRzPh6FbLuZOUpZ+C6oIkkA5wXCcb8eQaXJ?=
 =?us-ascii?Q?XHmKItH1v9UY8KGPfBmJ9VLsUafkQheVg4JT68sFIiIvwVKAI/7V7oM7HTv1?=
 =?us-ascii?Q?TlpQTDvI+0975cxBTDuOtxrXgv6poxsJQJv7Kc3AQiqycQz93wZwXjUDyTmz?=
 =?us-ascii?Q?WnOU//YRvA9vSmSwp+eEKHrf8Gxjbz54dg7mTLJsQ+Dwsu4EZu1V5oKZoMXY?=
 =?us-ascii?Q?02mmvtTOEbUyT7Mq73ATmWtTp0i2JRWXqXHOzRep1AuVO8i7xcNf8UcAufZc?=
 =?us-ascii?Q?KVBYiQ7OsrKWIquYHLenup8LhXBjOeLHhpP2p3SYoWuqIpfRYf2eoyJJwsft?=
 =?us-ascii?Q?sB1JhlUmApyif1I9Ae4qkNqf7r6/SOdMwk1Fubq5lbDnP6ku0ouct5JaVWky?=
 =?us-ascii?Q?FGr9j1jXcROTX25/zHqxXneGXeLVn0d+IH9u63rS2RcBfpvf9ioFRvPAod12?=
 =?us-ascii?Q?rafkDCmJWS1a8jaNJ6xa/7VC7p8AmDnYyZ0CMxp3TH9ylBwIoq3ybqFgjUZc?=
 =?us-ascii?Q?CX0c+bNVyLT+MZQbZ+/1/QpNJ4fRYxiRGmAgM/RdxyZidg0zFkbOuyvffgxn?=
 =?us-ascii?Q?XNVPDPcMBYRufzItq2k06mGl5lCuDWTpU/0RuXABqynHBOFaLYkpuPvHAAjK?=
 =?us-ascii?Q?H0+8j0S6rmAtkt/ZFxztwYwSeGeMeJfCJB35k5jhQxsPEtGyFKwADiyV4Up0?=
 =?us-ascii?Q?Gxamgo+fk1RJmtaPMw3T6as1yPM2ZcxaGz6K9BGLAhknw0iz1+PQ84A+SFBj?=
 =?us-ascii?Q?FvWHrHWJZ4WH6/JHz2WdchTl2WzhjCUKJUTc3qEP1lriJWRFpd7qceagGpLG?=
 =?us-ascii?Q?HVztCl14dqqBw3Owgw+vUFSi4zv+7/ACo6yOuR/ibNATE+Hz7n6Y87lAU8Tq?=
 =?us-ascii?Q?KqQpXKAXPHf2tBG10xIF1+CDL4PV/nBoNOxH+isELUxgqtYmbKnLptF+/L/Z?=
 =?us-ascii?Q?ye+MEj5rIgbvYhx34JIjZa/sxWDebN3oRxuaER+x/OS1+GQmU8WNEIg/Luzh?=
 =?us-ascii?Q?qK15oWU4fmsIZTLlDBlKngGeW6Btiw5kRX+F49LInuU0rWSq6hkiU12F8sNw?=
 =?us-ascii?Q?/vI91/4XG0/JoaJRHawdKq70WjpW7YWOb7RXBEshVTMJYqtsCYLHJfnQeSSb?=
 =?us-ascii?Q?nUU1LstMLfBB8eNOiF1ismVg37PLg2IbPd71YcWy7o2R9doLBhBQB5/fRN1H?=
 =?us-ascii?Q?fYTb2kG55wqDwQOb6yjjzWJdMMy42YEJ0Wll+UiEo+JIzQ7RDFKT4yxLWtyk?=
 =?us-ascii?Q?dCyq3IBcn7sRatt0C0PGK0KuzHLBFCWqCRFqcSmsBW1erY2jwnt4ZjF9ZCgf?=
 =?us-ascii?Q?dPgGSLVlygK50zn1v7cZhthD46rEDRoK58YLuaOIOZ2BweV0CSbWcMbxUarO?=
 =?us-ascii?Q?6lORDI5Pgj1qBVhIA/9RIgJPnmL1QbHIA3kQzm1z8L6sTxMmBkiYfXn7X2ar?=
 =?us-ascii?Q?G8How4E0qMn+5kdHhBd+SxNEH9CbQQ4tXjGGieNXP3mtE5qJOSfxO1gRI/RZ?=
 =?us-ascii?Q?4kyl83bUIAiB+O0HU4ovGtkzWsHQVk7g+J51d/lW4mh+eWQpBqA30kbiClo/?=
 =?us-ascii?Q?Hx+OJaiA/kQBTLt2SWcyhbnohy21VSzNaW+AfLygXgDBgM3+HrLO3dqvzcl0?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d6b887f-18e6-4853-36bc-08dc6a867f81
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 09:01:47.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vJCQlB+cEKns9MC99nfoBCfqHDTpaRhm9vsiK6dj7RPHekjOTGJ6WSr0oIIK15plpysvrDZ0jsI5ZF60UuSag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7932

On our DUT, we can see that the host issues create connection cancel
command after 4-sec if there is no connection complete event for
LE create connection cmd.
As per core spec v5.3 section 7.8.5, advertisement interval range is-

Advertising_Interval_Min
Default : 0x0800(1.28s)
Time Range: 20ms to 10.24s

Advertising_Interval_Max
Default : 0x0800(1.28s)
Time Range: 20ms to 10.24s

If the remote device is using adv interval of > 4 sec, it is
difficult to make a connection with the current timeout value.
Also, with the default interval of 1.28 sec, we will get only
3 chances to capture the adv packets with the 4 sec window.
Hence we want to increase this timeout to 20sec.

Signed-off-by: Mahesh Talewad <mahesh.talewad@nxp.com>
---
 include/net/bluetooth/hci.h | 1 -
 net/bluetooth/hci_core.c    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8701ca5f31ee..a0f13a213e12 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -447,7 +447,6 @@ enum {
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_ACL_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 #define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
-#define HCI_LE_AUTOCONN_TIMEOUT	msecs_to_jiffies(4000)	/* 4 seconds */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1690ae57a09d..f5aa7448de30 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2549,7 +2549,7 @@ struct hci_dev *hci_alloc_dev_priv(int sizeof_priv)
 	hdev->le_rx_def_phys = HCI_LE_SET_PHY_1M;
 	hdev->le_num_of_adv_sets = HCI_MAX_ADV_INSTANCES;
 	hdev->def_multi_adv_rotation_duration = HCI_DEFAULT_ADV_DURATION;
-	hdev->def_le_autoconnect_timeout = HCI_LE_AUTOCONN_TIMEOUT;
+	hdev->def_le_autoconnect_timeout = HCI_LE_CONN_TIMEOUT;
 	hdev->min_le_tx_power = HCI_TX_POWER_INVALID;
 	hdev->max_le_tx_power = HCI_TX_POWER_INVALID;
 
-- 
2.34.1

