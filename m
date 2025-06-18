Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013016.outbound.protection.outlook.com [40.107.159.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3722EBBB6;
	Wed, 18 Jun 2025 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257499; cv=fail; b=FBbd7gHgrO1EBfrkaOly0v2UktYb3bI/2jK+E2UiM29GoAaAOwogkhzG0kwDoLGYl7JPREbmCAzTpxOEYYsGMVAqAPMwP8mC6gUDTXyaGmiepZsBCbY5HgsJOOXy/fJ1x4SoOKWCoRQo+sMtv8vQUZI4VaCHJ2XZjYcRiI9vmvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257499; c=relaxed/simple;
	bh=K6WcjRMu34HiqkLfeEO3Dtl9nhyyyRRBkQHnkylT/eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qca+CXc6QA7YqzhwMoV04VkuHnbl1N+SuQrdsgwx+n1sGx0N+WHAAIOLN15VCDrrjOcfMluMw3yOfltgmH4QnMycZbQFoKUbpiMxElzHvg3rqYvmi8v3qbnvueAQy7t+fzS2XHqyZ5lhHelu3ZU65r73kGv9RujKGG7JJIgaf5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d1D+jCXK; arc=fail smtp.client-ip=40.107.159.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d1D+jCXK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWUm6H+HDOFsgwJFG+9oLjAyy5zHrLI8X3wN0B1A+h/HDdz6JZ33irx9wII2IaTwjzKkVWUNZqFIpz2omapH2xPYlqoZCryJ4uzu5s4KnQNs4tlozRGQ+PJAEW10NCeEkhQTJ6J3iNMRJpdSUIMaxBQaqb+f8mVGmIEL2uM0JILtdCQ5PqE1GQJS7TMv5hDVFLz1blJVhgJvH2CgntrEEGkbIQFU0baaYcCUy0PxisBPKG5756k04gGCCQ40rTA3s0vlDY5A7a/rKW+ClUJVC/3DQGAdEc9VjCZ83Pd33Szuw9UO6LaqB7c4MCZQFHVAh9wWpJXOTfiGOH9rod45Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+OiNZMlfSKR2MI8rtUCJBV2wTzP0ZBsn1MwEgVPn38=;
 b=TL35lm2StqLl1o6UG7uPD3CRmrPKVZQ9UAWQSMvsK34nKnWyN/jXnYj1VLvpPFJyTS3CGj/iaCNs2N+GekVJdB0e5eweTZA28t4ynaUEJGC8ndAxsc4w6LSCLPjFVKdR0ia1s83M4E1hc6WhHnrk43Z82OFXi9MrnWyYhYb7LT/ROrFIBspQBhJYVHozrpDIYyxYB6d03k8TEKe5njKqKRNBKnrRu3vOZxaECUUO3V3I9FDiWZ56HTEpLTEHXSupgz9iC9dzq/yB36wpVv81IiInd2/2TmiWLIc9TbS3II/AV2jUdxlfR8yr+7AaGlJ44cETuuCPlAPFbo+i9tAt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+OiNZMlfSKR2MI8rtUCJBV2wTzP0ZBsn1MwEgVPn38=;
 b=d1D+jCXKEQ2WSs6oee51UuTrmeE0thRYslfR8au+/FSbc8RdyE2EO4xQNGGQgr8iqPM0FH0NfsfvzyTHnZUncQzvxEmRGvbnXr92mB8xorZ81bjosQttGveUEP3lhVtyMuw6zyqOY7iqXFAKkY+gWZi0GueBrn0TT4t0xsVAToF6JMyiA7sleOv29fZ/ae+YJQpu2slFyzCQL0SE9PRqWl31SkbxW3k7DYXFJ7tBpHKvbJ1eWsJyVwqwCHYC7k0UyKQ8fJeLemIQSpk67tF9kaNpI55CQinVanPAtDOEwBv9msAdZCfagtwtXaDOXtsF6fYKP/345ain5JEaTnqwHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB9571.eurprd04.prod.outlook.com (2603:10a6:102:24e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 14:38:14 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 14:38:14 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	manjeet.gupta@nxp.com
Subject: [PATCH v2 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Date: Wed, 18 Jun 2025 19:50:12 +0530
Message-Id: <20250618142012.25153-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250618142012.25153-1-neeraj.sanjaykale@nxp.com>
References: <20250618142012.25153-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0017.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::6) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB9571:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d8eaf6-df5d-46cb-738a-08ddae75c166
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?edW513mInS0br56IWP3gZjdCv+FtMUl2foCRfsUd9EMav8ZSSPQD9nudH/oz?=
 =?us-ascii?Q?fQCYSh3oejgX5udffWuthc300B6sv4eUkwZSvRP9OPJg0rrE2n1stScPppS9?=
 =?us-ascii?Q?qBX4F3i1A/s85ZBT9sC70NMIMfAgIFR33JMgRdk2qfTC4DvkLnx+uur6y1AI?=
 =?us-ascii?Q?eI0FiSyjNzi/c4U77OKjbxJ1Uxlsr9TUw2PcUr6VJ4MTNWC8/VPZ1nlGO4+N?=
 =?us-ascii?Q?zgMNL3ekUKNtK5ESFT+OS953yq7WXpcnITSMZpl4rWIu4sdW952cUXUO0UKJ?=
 =?us-ascii?Q?dyX3QxmDIdOUUuoiRO7DqAp8IaiR+RF2XO+YG9bYj479Nb7Bb4ZOTPH8A1iS?=
 =?us-ascii?Q?dGS4afqhCMVdXqIPTDT4U8ylvlYAZmg9EkUAuGthDGpU/y+IKl7NHvGsdZ2M?=
 =?us-ascii?Q?n5K9pBaqYOePx0ST6IPFKCvYJ7SuVVCFGRxHCHasqdSbyH0Zux8znplqdzUV?=
 =?us-ascii?Q?1qTn8EHyi09BcpIQwCG/Xlh5q8PlUkfh2qsjxXNrUb95p82SqbWScM+/Gmtz?=
 =?us-ascii?Q?1bH0/pXRZTpWrFv9X/IZSWrr/rJu0xhUokz3RcJgeKsM/tO0X1MI/IwwIh1Y?=
 =?us-ascii?Q?GWm8KsZj/A5gT7bwtmfMiyS97jOSIAr6iNGFxYksaXtDuAqhHAksE3soDktD?=
 =?us-ascii?Q?xLXZuhvuxCMKeBK6jh2vAtBVX13WqGYYJ0xdA/U+HPLRrJVVimn8WblH14hV?=
 =?us-ascii?Q?TOpy3ozM580GVNoU/r4V2xMIcO1BFqeGZJ1Z5S7OfB6/QAoJx0hFecoyhtge?=
 =?us-ascii?Q?oPFD0OLk2MhcUfpbqgwMvcpiwPpKOZB1EYrjwnm5RRrcJxCcPDnbXuPE15ow?=
 =?us-ascii?Q?9jmpuuPZSMZ/JjSBy5vgfGLFtxL+ga/FKpP2KfW/sUcLeHsXX1pRorjJN0vY?=
 =?us-ascii?Q?8yGo3wjoNsiF48Fq2uiKa1puiNwC7TP8Bk6ZHpVWOK/UKnnobKr7vUpYI3tr?=
 =?us-ascii?Q?S/IEG27wgA/VagEZ//jDDw3e7o0ISZIyKaEGiha/ar8DWj6208b3mkNKvE4T?=
 =?us-ascii?Q?IKTzHVggZXoOs4YHt0xlHHEXhtYulEgTjhRJRhoUo7KB7asxGujttiNpXOI6?=
 =?us-ascii?Q?Rd1Vi4Zh+NCnrcWVjzvQ6lQ3mBzCm6M3lL9WoKGNX1aIaCdVnWStrxuTQWkO?=
 =?us-ascii?Q?iOdsNmqI8Iz/T95EkoOjRBkH6vj4Ior/C7ywg9zaF/shOaw/QMweWwrufs0F?=
 =?us-ascii?Q?Rrml1YY19wqgSqh+R0RGP+LbtLbJTlKhRyekCU5eURnh8xa/FGklsP6OCxGj?=
 =?us-ascii?Q?UJr8BUO7Wkv46kOEP+hO8aiolmXKVfocRKbA9YIGgJbzx/1D+slGuwihyR8T?=
 =?us-ascii?Q?ru3hOZlagRPwDoeYeOpt4t0ZOprL6Om+qnv33pLqYuOk2dozm36VDpJ8qYw1?=
 =?us-ascii?Q?GiIOhJTZ1XvBF8oAjtzwoILOfVtZbM7ilYz7+39xlKKWwDcmYhIIWx+/guFa?=
 =?us-ascii?Q?s5lqcx8tfJZC43sfbXudpSnaPo5onbIdLcNXuk+xzHXILUqDhy9pxg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YS472si9+Acak393OafU/NlPXF/W5JufC5IDpX40rsquJ1FPVb/FO+7stpEs?=
 =?us-ascii?Q?rsmmqVRVo6v5SPJcjD+d9TxSRZEpMgoIXDfQkx4PI9PFQieq4Mk4SzrJAS2u?=
 =?us-ascii?Q?cIeBa737i32hk5B9qCsH0Fvdqk/VidkBLvU4elfbqTOZ4gOFuM6MCHuMfQbe?=
 =?us-ascii?Q?DqFa2cptzu9bH0kqUAm0CHK/qjKBajcggdQb+YyHAnaJuL3FUm9Y6sY6/1y/?=
 =?us-ascii?Q?9SZPMF+mn0ulLmiqCrJApw4BL9zt+s7A0t9YDEW7aN9HWUy2bUlJUCPbBA5K?=
 =?us-ascii?Q?Oqu1+YTEVpwQOTphpc8lo2YYgBL9CzZWhNnoEXSA7Nj3J4lIESuyNFcTdEL4?=
 =?us-ascii?Q?RINlMeJU3SnyKGMEZLqSTPIN2+LfyGFmdCRq18tnKR4Csl0YLVZgtsLxskG1?=
 =?us-ascii?Q?0nb0MxEi3z/KOVHdFnmpYRnLXqJKsSfNcaWLyyJz4LD4OrU8uAOG6+TD3xC5?=
 =?us-ascii?Q?OYVq5Gk1/pe7nKOF+EmV397KSk9VnXcIkwafwvyfq4dtxHfq/roA6lKeE8/3?=
 =?us-ascii?Q?bIC+vQzMpZVRNVUfyI4UjVfJ135jHvGlW/0mrcfHFLOC+rup/KEkH/t3Xxie?=
 =?us-ascii?Q?IIjc+Px0wnuVDUh0cCkK88riquJ5tJ9CNqxYt5WXuGEyj8vUbQt5OqyVLtHs?=
 =?us-ascii?Q?BPgoL1F5pgqsZK9BHsholi3ta2ih00hGHwaNOcA3NEjysCrcsqUh8oJcDG1A?=
 =?us-ascii?Q?p1Ve65cCe9JbcwhW/J6Nd9XT3zN3UHbCtwyXjd1IWySPDnpWgKgGSGUvVqJC?=
 =?us-ascii?Q?7SfSbLzX5wZ1HT3+cPKNGzfLVFNmpfkVRG+X8pZI+MmpdkPhAgN3yYWYk4DG?=
 =?us-ascii?Q?UvavmuPPhBZnfheeidsyza2U8O8G38uFAxtnIrbbMsnn8e3GC6+f9MI0Vo5B?=
 =?us-ascii?Q?f5inhKF5UFO0Un0PjmvEC8p3uxiChewLmIRLiVdT0N8SuodRYytqATvsMXai?=
 =?us-ascii?Q?AU4VHy3yIbG1BvrEslv9Jt+Mac1CdHjTjyzxnvbf0krS8OXsJj6OOrMK5bVA?=
 =?us-ascii?Q?5rYEVOUHRrRAy5chduXKVdygAxgQMcDlUfZmcOiJQcJyEqK7meyJJhaRx0hK?=
 =?us-ascii?Q?KYeyfLCO/octMiYA+h5par1jn8DqpLtmy+12YU4d3HCnl4it9w3FcnOa0YZI?=
 =?us-ascii?Q?WOh8icOL4z5m+Dmuv/RuDrufjOaNzxMCZFLlUU89mGTTHALWSmcCWfeZohRv?=
 =?us-ascii?Q?WfrlIQG8xaxON5Df1Sv000GkDwuhkGJiz679i7kofFG4D0ItLTdrTv8wr9ph?=
 =?us-ascii?Q?sWuN7RrM+lO0JcDqqJyCW2eJDXXjuOSm4ZNS+jvOliuuz1+3BO5CUft+SrJw?=
 =?us-ascii?Q?w9vU+ypfV6qDrJQtdzTZxJhNqOlOoobl4QrTlaw837ek2o2BXIVZagrSxbM8?=
 =?us-ascii?Q?r1YRYrL9e8bIwLCYG/x/w0Qk/WuYfMu6MqPYneV/7y98oDqL5m2CrXLRQuGg?=
 =?us-ascii?Q?YDn1CkN+kDATb81lFQRdag/DVeiPyFsKC8FGjOZiDzFE7xWCvwU+8CbpB1p2?=
 =?us-ascii?Q?VeSzvNgMy3fyP+9wjWshtiOtvL3EOvytb3NNMV11y/LM65eR4lv3LQh5GJ8h?=
 =?us-ascii?Q?tHMsQJjwqZ7+AnXtrQYYZQi0EmW4G387+lOCAIrQmXhgB8XZFWPp4GI23QA+?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d8eaf6-df5d-46cb-738a-08ddae75c166
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 14:38:13.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXyb4pt8OV2wQuziVfBa//kkY9WXRkkxuQZab+zhpGzuu2xb++/xmJ44XQLDbcwem9Am1lwcCSRMqo/6AySTZwmqYrMu/nrP6amZwGxP5rQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9571

This adds support for 4000000 as secondary baudrate.
This value is selected from device tree property "max-speed"
which is then used to download FW chunks, and as operational baudrate after
HCI initialization is done.

This feature is applicable for all new V3 bootloader chips and w8987 V1
bootloader chip.

This property does not apply for w8997 compatible device, since it
downloads a helper.bin FW file that sets secondary baudrate as 3000000
only.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Change DT property to 'max-speed'. (Krzysztof)
    Add support for 4M baudrate to w8987. Update commit message.
(Sherry)
---
 drivers/bluetooth/btnxpuart.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 6b13feed06df..c9b3e158f438 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -73,7 +73,8 @@
 #define FW_AUTH_ENC		0xc0
 
 #define HCI_NXP_PRI_BAUDRATE	115200
-#define HCI_NXP_SEC_BAUDRATE	3000000
+#define HCI_NXP_SEC_BAUDRATE_3M	3000000
+#define HCI_NXP_SEC_BAUDRATE_4M	4000000
 
 #define MAX_FW_FILE_NAME_LEN    50
 
@@ -201,6 +202,7 @@ struct btnxpuart_dev {
 	u32 new_baudrate;
 	u32 current_baudrate;
 	u32 fw_init_baudrate;
+	u32 secondary_baudrate;
 	enum bootloader_param_change timeout_changed;
 	enum bootloader_param_change baudrate_changed;
 	bool helper_downloaded;
@@ -802,7 +804,10 @@ static bool nxp_fw_change_baudrate(struct hci_dev *hdev, u16 req_len)
 		nxpdev->fw_v3_offset_correction += req_len;
 	} else if (req_len == sizeof(uart_config)) {
 		uart_config.clkdiv.address = __cpu_to_le32(clkdivaddr);
-		uart_config.clkdiv.value = __cpu_to_le32(0x00c00000);
+		if (nxpdev->new_baudrate == HCI_NXP_SEC_BAUDRATE_4M)
+			uart_config.clkdiv.value = __cpu_to_le32(0x01000000);
+		else
+			uart_config.clkdiv.value = __cpu_to_le32(0x00c00000);
 		uart_config.uartdiv.address = __cpu_to_le32(uartdivaddr);
 		uart_config.uartdiv.value = __cpu_to_le32(1);
 		uart_config.mcr.address = __cpu_to_le32(uartmcraddr);
@@ -966,12 +971,13 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			goto free_skb;
 		}
 		if (nxpdev->baudrate_changed != changed) {
+			nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 			if (nxp_fw_change_baudrate(hdev, len)) {
 				nxpdev->baudrate_changed = changed;
 				serdev_device_set_baudrate(nxpdev->serdev,
-							   HCI_NXP_SEC_BAUDRATE);
+							   nxpdev->secondary_baudrate);
 				serdev_device_set_flow_control(nxpdev->serdev, true);
-				nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
+				nxpdev->current_baudrate = nxpdev->secondary_baudrate;
 			}
 			goto free_skb;
 		}
@@ -992,7 +998,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			nxpdev->helper_downloaded = true;
 			serdev_device_wait_until_sent(nxpdev->serdev, 0);
 			serdev_device_set_baudrate(nxpdev->serdev,
-						   HCI_NXP_SEC_BAUDRATE);
+						   HCI_NXP_SEC_BAUDRATE_3M);
 			serdev_device_set_flow_control(nxpdev->serdev, true);
 		} else {
 			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
@@ -1216,12 +1222,13 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (nxpdev->baudrate_changed != changed) {
+		nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 		if (nxp_fw_change_baudrate(hdev, len)) {
 			nxpdev->baudrate_changed = cmd_sent;
 			serdev_device_set_baudrate(nxpdev->serdev,
-						   HCI_NXP_SEC_BAUDRATE);
+						   nxpdev->secondary_baudrate);
 			serdev_device_set_flow_control(nxpdev->serdev, true);
-			nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
+			nxpdev->current_baudrate = nxpdev->secondary_baudrate;
 		}
 		goto free_skb;
 	}
@@ -1447,8 +1454,8 @@ static int nxp_post_init(struct hci_dev *hdev)
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 
-	if (nxpdev->current_baudrate != HCI_NXP_SEC_BAUDRATE) {
-		nxpdev->new_baudrate = HCI_NXP_SEC_BAUDRATE;
+	if (nxpdev->current_baudrate != nxpdev->secondary_baudrate) {
+		nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 		nxp_set_baudrate_cmd(hdev, NULL);
 	}
 	if (psdata->cur_h2c_wakeupmode != psdata->h2c_wakeupmode)
@@ -1773,6 +1780,11 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	if (!nxpdev->fw_init_baudrate)
 		nxpdev->fw_init_baudrate = FW_INIT_BAUDRATE;
 
+	device_property_read_u32(&nxpdev->serdev->dev, "max-speed",
+				 &nxpdev->secondary_baudrate);
+	if (!nxpdev->secondary_baudrate)
+		nxpdev->secondary_baudrate = HCI_NXP_SEC_BAUDRATE_3M;
+
 	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 
 	crc8_populate_msb(crc8_table, POLYNOMIAL8);
-- 
2.34.1

