Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B521D3E6;
	Mon, 16 Jun 2025 15:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087647; cv=fail; b=qPkJ3E5DL1vJj9CxDXis8pn/a+YIwSThp9Iet0y/4V7jl9lXoNUv4POA8RYxwTmw0w1l4grcgyrzmSWvDgXHAstIlx/GKh4+mDdGVa/Y0lFzUzW5ipujuW28ojrD+RxqmiXRXo/N9rfk6TmwfMiyOWHLjZvwtREouKaz53oMBUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087647; c=relaxed/simple;
	bh=Y7cewbIFKq0LiDktdtCIi+I1RwNR3/cUUjZ+IdkQ6og=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SlpNF3YJsqs1LcC6KCAoxdKU48dgtChAHcxb9KEDqa0VhFbMUIfVYOauXXb7IMCYR07b6aO3Pew2eOqV92prtEsfcPXVjMkxcVj3tJn4YLR4SfUZB/DrQmYW3WyB/hNMCTRLDE5Bjsp51l8F5CkjMjzgoDLwYBlRzzvvrGWzdC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mhZxsPhh; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mhZxsPhh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IzTb/ieyUQGdX4kHSsqefv6opyMtKZsZPa2hSpjZnjkUiL+K0+uq8T+kOyF/2PotqcBoOiRE6fEGWIl8C9KyTajQFcNzQSAWEV0MBcFrb8uYvuK+c1tThxwLMmIk4T52m08tHPAUxyb98sXY2A/ap/tM2odiJvwDpG08MYe4V9m7S3VJHBKAKtdfabhf0CjJXXCXl70j3ZUu61WItUiTT4EFXrAD2K0CZKEH+2mKOsKev4v8hIiWJ1dtX/sv+qOIRqgFqKGSDwy5HlJ54tU5VNVNVE4+ShgioFOZG8p2wpUuTpaNvIfuRKRuWEEYACtIaPiuuwi946mn7ENcNgeEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7JAnWjghMlAmBKMQf/zl4a3Lob+Y4Bdn/F7tQeboUE=;
 b=KyugyrdZwUmy4SuMkN3E+Hh1r2cfRrVcfCLfVCf/sRAtfhkAOqdlx8iWMUREqTB25DfGoKK+1oHg/vjy5P4MDOhIOt5jO9hW0OxHOlV45A8NvBIZ0+ikhFbnMcxz/VSpUkYfZAZDHhWqtUgaCkJJ071/grUCScO6Hp50CFS9FJGX2weVCkuYldY3dSmEhHzEBbug2ME+J3CUJjW0QNrzi93/hXLi2CO0loAlimtOqJRfYhkT4dVzq7lZN/caQGuXV8YfRxWBuojlOErgAlgBNrZwCfmwcAFFH+tEOtehjflu+PPXMTPQr6Oop/j+D+SIjW/nXBd+4ckib15qPp4cgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7JAnWjghMlAmBKMQf/zl4a3Lob+Y4Bdn/F7tQeboUE=;
 b=mhZxsPhhj2yvkUc1rFYIO19/awc6k47y6X/cR0nPPDTVqOC1A8JWwpalfdh5jn8i6CktZHwtBKJ0+SViYb8g3rtvROgrko/cDKiB2g8L+7Smf74s1O2jQ+J3vL6AGEcmfzgOqfUZMHkrtZdOdtkEfyFymL8GNim6wxH1J7tYOslAA97fNS5wj3+xvGlMeGiDj2+TSBIXnhf8L4RU7oJEe4SvGrSOuAJN7JJnFH8CyEIcCY6stFi07SeiqnXfhdbTZoutPa5+TFP0gHpfZnbtTW4k4qaQCy6Qt5+/IoZtqw9Zk94gXMcR2mMWREtitx9h40Vch6p5RZ2NvhlRDCVMZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB9137.eurprd04.prod.outlook.com (2603:10a6:102:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 15:27:23 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 15:27:23 +0000
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
Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Add support for 4M baudrate
Date: Mon, 16 Jun 2025 20:39:19 +0530
Message-Id: <20250616150919.8821-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250616150919.8821-1-neeraj.sanjaykale@nxp.com>
References: <20250616150919.8821-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:4:197::13) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: b76eb656-6d6f-4c67-b6b4-08ddacea4ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wN65uD9cUrwU/pSqNbki51rZjxnANhZgMoYj/g0bv0ZP+hzLbQHGb71bvniN?=
 =?us-ascii?Q?uvHwZQ1qcfYMaJh53rQHISeA/VtfbpsW9A6gObIK1ZLZtWlV1HN0PNmqQqhZ?=
 =?us-ascii?Q?Khynia0BYCZHDi0JkV8oX3FgT6aAVsrhYVICuto+ixnM+TTg6myFTqPYQwUR?=
 =?us-ascii?Q?NoCqkcvVg6ZgP0w85rz2kqEOR/QdlUlj7OvNwSx3kHx2b27dfqCmFyAIC5ET?=
 =?us-ascii?Q?VS5/nZ+wR5vHydtUKj0eYBKb6pDxAF64CV9h6olzGbmwpjBbm1DIs4yydbg3?=
 =?us-ascii?Q?4RqLh9cH/4cp0ibfEf5NjfiSnqgSO2ttLwV4Ot6GNqX8+LJ0FBWihh+8dcW6?=
 =?us-ascii?Q?M1Rq/IT/4Sc5QjmWafHx1mX1Lyu3K/B1mISP3ByqjCZJN+nfK6oDWlPPahvc?=
 =?us-ascii?Q?syFSvviOWO4wPYNJ0/mSFF6cpDG9ENJEbmm2kAA6c2VBoBkzIfRsNOjJw5wU?=
 =?us-ascii?Q?piY3lvnCn8DY/VZb1xuwbOq8joUcU7IUWWBPooQO/Bs0rzx5wVw2SBCeLfqO?=
 =?us-ascii?Q?MU2jhjUnBAUAS0IwdMNYjP9PMvUEUNIC1SBGfxGNWbukRNRlty9sZ3U2kDAa?=
 =?us-ascii?Q?UiIoms5KhhGs7VRgVhbRGOgBnCIA43500ouqJ+MeJapEyPAL8UQgO1WODZJi?=
 =?us-ascii?Q?fIa+z2XjPE2Erppc0KRBu1Jz8deM2DS9xQHRBGV94McaBXOufIj3TNpmDclm?=
 =?us-ascii?Q?G8IfVKAyP9Safjqrfgr3DMKQaKUFbniR6P9Jpt1dhyGJvtVw5lSYJrtELbHj?=
 =?us-ascii?Q?BNNJM/kzS7QWmmAI65oeWxyLBBpzi5GYkTwr9wa/CImBHmUacQ1TLTsBBR5j?=
 =?us-ascii?Q?AEavLlM6BFYlP6Ng0tCYT3QNioYGSOd4ZMNwyG2IY3qKZjICLtkefPyU/jb9?=
 =?us-ascii?Q?SRKSpVnttFOPxbxQrqWbUjP/lEL99n0Fb7/Y3jItzYIt2k5IvTq5bcvtFrAm?=
 =?us-ascii?Q?5JKWVnu92YVorHqKIuEP/LUvawHK5UGicVrOJzayMHCoIFBo6bIJ0scCEaP0?=
 =?us-ascii?Q?COs+MJrNJRfgTg88VG7SRiSkwuCMyDhhi8hiSOii0gdEsaN6g5e7oG3H0cpP?=
 =?us-ascii?Q?89fxFwF+I9RuW8TN0l/O3iF9ojzw+pfAl41RaojXLPWRnGSV7aDVIVXw3kgH?=
 =?us-ascii?Q?1RrjG8HXVe+bCSe6Talf7BSUunzZ+j8IWO7mmwUUAPtrNfKmPvsSKXZa7SNF?=
 =?us-ascii?Q?fAvn8MKb/McpIT+i38TaH+DdcFitpwJjiygYkhap/e0C7/6d6nPMPnFPOCJD?=
 =?us-ascii?Q?HJLawny3BLPX3flEFmLwuGAeCmIiVA/7GAEIvm5eg3SrwKDfzMPA50jn/YLh?=
 =?us-ascii?Q?WdyFbUZlJ/EQAdMd6XAhIS4R1ZqDZIlR+SHQohco9kR6lIA4e7vUHmtidByj?=
 =?us-ascii?Q?35YgMZzxtAY4oxpTUpwAzI05SI+n5u0mrFnZq9PhkBvS/bL6snWRluu2pGPt?=
 =?us-ascii?Q?6IrbGf8sj02JlO0tcNMT50K/gy4V9/aybg8oqa++2pormFORLv4VAw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PZaegMKmDvLbsgmu4mHZH5fOR+zfK+mfIidIiwX/sMbC+LzCCDMFRuOiVAFG?=
 =?us-ascii?Q?2w4mKvCrWDtMzzUX3mVqIvCQrL7P6g/ZRU54MFyUSwlrKNvWeybgAC/8R7zz?=
 =?us-ascii?Q?RP4xBEXnXEHyveW2onMp/04owZZHJzBFnr9WqLicVZQrDOZKL6YE5sebW8F/?=
 =?us-ascii?Q?lOYrKKP+kDzn+Ir5JzGBOGcwQ5DUI3qhd8F7NQv685bbFkJglswcfctgUvb/?=
 =?us-ascii?Q?w6I2Mfa8KdPuN8J8MP5tE0cgsRsF11boyUZxF5bNPCOu9XlsUwZ791DL5kfm?=
 =?us-ascii?Q?4SsR18P1+weLLm90fgT+8bhSgrECGHr683pKUOF9nAVWl06JhMdkTfyjndzm?=
 =?us-ascii?Q?KCyiSnOW37gqYyjuYC2LnkgpdXokWhrLDdNdgP1L6zKjpbk9yDjejI7IYGim?=
 =?us-ascii?Q?Z0cfUpU0dtuOqWrcCI+dC8+1kX+S5wCw0ns02ctd7MXXt+mrs+JpfPU6hYHZ?=
 =?us-ascii?Q?vPXK/smsegOFIogrlxLaY7W1QA5S+p0JgzQX1SZ8p8slA48f0s9Zt2I9xexG?=
 =?us-ascii?Q?Wj+ptxalpCu+BSivMKnpFmtapiYQhydlpkXxFIheL7miI6E+m6w495tVyPe+?=
 =?us-ascii?Q?Vr3Qs8vzLYYcWw+xqnkWV12LBtPB9rrbRNg0Q04Wcdt3JfQsGxW1HESdjYA/?=
 =?us-ascii?Q?r55TDggHKgVYkFw2vnbYEMbnCevwW2ETVW1TXramrOGCJQW7h9gfo4b5FnNA?=
 =?us-ascii?Q?P/33lt5T8LmadnbZeZuzCbngRdww4iIG9buoAHxwQZR9eV3BCDisnY+31n/7?=
 =?us-ascii?Q?jEpLxqd3/6/fGYctqQK1JjucmlSBrlCckW9el3OeqJAp8jJ17a5eGptmGu1D?=
 =?us-ascii?Q?1vNUCht3dlCMqEGPZYtDjOMpU8HLIXXE4DoP+M9e/4icI2E/DqApXjUP8ZTJ?=
 =?us-ascii?Q?CEOIK3+3NjwCw0jy9b7U2WLAjrxBGptL2Sy3FSdDcG5kN1c/Z9/k5m5yZw7Q?=
 =?us-ascii?Q?1MZhFz2pL2knSK6+dpE31mWRJRn5wt3BQz51Ct6HWWE3gdRFZi0AGvozRa16?=
 =?us-ascii?Q?O56xEIfpgv1QG7n0WVu57+3Ixyp69gjCqCaog5eAR6gCXsU2+T7qDubkZcsY?=
 =?us-ascii?Q?gmVaRQpbXj97ma7xQpDEN2fosHBInwce3gtP1YsR+gzg6mxLOZXF7iWnbGA8?=
 =?us-ascii?Q?rzRD8SnAryzZsAnlrdA7mRHSMdbhJJksJJOr1ekzYSjoOkaki4NZCpSjRH6v?=
 =?us-ascii?Q?UebamXGhqOgZGmVwHdA2LSrM6rvpGPBqOST9mVPodLA/4Ulp+k4egx26BSNh?=
 =?us-ascii?Q?PmUm33VByKBWOo5l8rawG0Wl+0XvMH74RKffUvJdNRP48qpu3IDMscBA4EFS?=
 =?us-ascii?Q?GDHMSLTEvp4S95gcUQOg85Ws5hwWj7qBhzW+OW1C805FKU1qsew4oEjqZf+T?=
 =?us-ascii?Q?UvzmavxH0E1SGcRaE87PxkZKcoPlXAiol9Cx3NwjzMQyzlaOwtkl2cah5FqE?=
 =?us-ascii?Q?ntG0hebYZ+NEg508AHq8f4gNrMf06LVpKYLmBBBwSQIPageCeS5I3xQdqC22?=
 =?us-ascii?Q?3u17GqcvsCPp51k+lFfH2EdrbuextDAsDQlB+eDeh3Ae7sRt/dtn9cJinqA8?=
 =?us-ascii?Q?tzOHN+47i88OS++ihOtwFnW+8nRa/U16qY50Wpg9FQupc00yCrcf6mZljidq?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b76eb656-6d6f-4c67-b6b4-08ddacea4ad4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 15:27:23.6720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g83dT+zl0qwIvQbtVQudqx3F1fFZZEQN75PHY3xtjvFklHh/kbTKxkMKrLiGZO8zbldQDbTh7m9Y2iHMgz3cukQ4cLlrMRuf60UwVumovnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9137

This adds support for 4000000 as secondary baudrate.
This value is selected from device tree property "secondary-baudrate"
which is then used to download FW chunks, and as operational baudrate after
HCI initialization is done.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 6b13feed06df..e2cd568bdffe 100644
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
@@ -969,9 +974,9 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			if (nxp_fw_change_baudrate(hdev, len)) {
 				nxpdev->baudrate_changed = changed;
 				serdev_device_set_baudrate(nxpdev->serdev,
-							   HCI_NXP_SEC_BAUDRATE);
+							   HCI_NXP_SEC_BAUDRATE_3M);
 				serdev_device_set_flow_control(nxpdev->serdev, true);
-				nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE;
+				nxpdev->current_baudrate = HCI_NXP_SEC_BAUDRATE_3M;
 			}
 			goto free_skb;
 		}
@@ -992,7 +997,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 			nxpdev->helper_downloaded = true;
 			serdev_device_wait_until_sent(nxpdev->serdev, 0);
 			serdev_device_set_baudrate(nxpdev->serdev,
-						   HCI_NXP_SEC_BAUDRATE);
+						   HCI_NXP_SEC_BAUDRATE_3M);
 			serdev_device_set_flow_control(nxpdev->serdev, true);
 		} else {
 			clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
@@ -1216,12 +1221,13 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -1447,8 +1453,8 @@ static int nxp_post_init(struct hci_dev *hdev)
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
 
-	if (nxpdev->current_baudrate != HCI_NXP_SEC_BAUDRATE) {
-		nxpdev->new_baudrate = HCI_NXP_SEC_BAUDRATE;
+	if (nxpdev->current_baudrate != nxpdev->secondary_baudrate) {
+		nxpdev->new_baudrate = nxpdev->secondary_baudrate;
 		nxp_set_baudrate_cmd(hdev, NULL);
 	}
 	if (psdata->cur_h2c_wakeupmode != psdata->h2c_wakeupmode)
@@ -1773,6 +1779,11 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	if (!nxpdev->fw_init_baudrate)
 		nxpdev->fw_init_baudrate = FW_INIT_BAUDRATE;
 
+	device_property_read_u32(&nxpdev->serdev->dev, "secondary-baudrate",
+				 &nxpdev->secondary_baudrate);
+	if (!nxpdev->secondary_baudrate)
+		nxpdev->secondary_baudrate = HCI_NXP_SEC_BAUDRATE_3M;
+
 	set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 
 	crc8_populate_msb(crc8_table, POLYNOMIAL8);
-- 
2.34.1

