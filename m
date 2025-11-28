Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6D7302140;
	Fri, 28 Nov 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321341; cv=fail; b=JFSaLjjU6OER4k8wNJGfRRpehKs8dIfESlSmwo13XPbB7qMz/p+WG0UIR1BQtjiKtK4WZwMs1LpUvDNBg9sG9hWgjyepa5sC9xD7+gO4Em8BdV1UFFgN4ubePE49+bEtZHJcL4nY9//MWecQah3cbvbqYIclc2qV+6fTv41maH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321341; c=relaxed/simple;
	bh=ApzEgVOqSCAomKHfljdpSEfKHeKoAocR4OcABaAZT58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/P+P97x6icTQvwrLoiSStaTqBY8jXj+060U4YGEFjoJLNGjw8zVkJj9yL7cfvadHUq1f00DPOSU/FI/lixUFRU4CyFP9DVc2a2BxklfFaqKGAs++Iut/py7eBnifVUrWqmOEEtwbh0kTaeAj0Y1zB6Orq4N7tJAswnTLy8+Etc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TFyiqDbK; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TFyiqDbK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knkLbbH7uYc0djCrO7RovoMXo8SdYaH1mc3YGya0/rhYOb5zT0QKhBIKTSKTSgU2AE5OTE9Ph6GWED4YWEGv+OkIlXUy4+h5ycGm+u4YGCJhkfYUkQzWoLIOAOsZH2cc5uMcnysuicA26TWocC53+Fr2LMyKcdorcV0biX2OjaKaysO/IH7VRL70hH/WFgXo+5uqkbC97Uv23a60NkmIFdFxcU1YIWI+U4Vycck5cYSsJVixClE64fyEZZrdzJEo/UApbdiv/Bx0ZdSzrf38I1SXIwUVM2JgFTMkUeBPp0D6KFzejRTS5TgNLp91DmOfoLba5AZlFYRGydL+NrqWwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0H57CLjJxcYbsxsHvSk6V6Q3ZtgYOSMNIPE0Y/lelWY=;
 b=jQsZW2wULA0u/bwsZn+1Y1lGOKi/TLbaGxAPOJpYxc3Xv5GN7Wq4M6Kd4XQFC8bB1S6Kz7NQwbRPeIFInN98omKxNCGC1tyYeuLbB36373UooppfbP73Z4sCj9OeQcvR65kdt9CYImdMSwyKE/mTIY2BtGMpvJdAeVjwpLa+/aNjQWvaWRp5i0xfkDqQZCFUgDfgI5Vpikc4dC/XKhrLUqC8JJIpOUWyXEJxZaAXMVAT4vwzWEghq9XUDEsZWaLsaL1vvmJz+LHVwKbbyw19TnKEcJHroLcUCFfLSffe85RcoNNzf0lqPjvpDLqtDSMMBxxDBa2Z8xVX+oG7qU03BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0H57CLjJxcYbsxsHvSk6V6Q3ZtgYOSMNIPE0Y/lelWY=;
 b=TFyiqDbK2jh1a+uFU2tk8WbGEf3az4njLkZbRgXk+vCumK4nYuTPjXQenfeC75x3IMTbMv8QVrKvOfLsZAfGysyoo5PlWFP1Aw5TowN6VTpKsVIctSmxgpIYDGYJSPXRz2+40EPNmt1qIt9EG9F/6Fd9U88KisCtUjgyc0SMwT64NrYqLlSWxUTB9MbUxWAZTjSxO7cXvpGzRIqtbrih/b9ZARzkVFE1gPw3Sc3DFV/RoIrcRI1cVY59Bqm+1lRQItHADhLnklmqIIx/UCf9GnSVOIA6QwmR8Jzyvi22wsfFraiGtEKIK4A9gEBvcrVm9ncvXAbtSGKHVomuQ5OeaA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 09:15:35 +0000
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d]) by DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:15:35 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 03/11] Bluetooth: btnxpuart: Add secure interface TLS authentication support
Date: Fri, 28 Nov 2025 14:44:35 +0530
Message-ID: <20251128091443.2797316-4-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128091443.2797316-1-neeraj.sanjaykale@nxp.com>
References: <20251128091443.2797316-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DB9PR04MB9676.eurprd04.prod.outlook.com
 (2603:10a6:10:308::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9676:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 02145246-57ea-430d-aa86-08de2e5eb04b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AKN4u2I+qaDCR0SHaurYvTR9mIWnEsvCtJ+20Up89EI0YMQueAYQx2ATgr4d?=
 =?us-ascii?Q?eI/GoufDGkqootSL57pKBuqPz2o74SdHSOXtBqIcaZSbG9TXYueBpG3QnrWX?=
 =?us-ascii?Q?t+CoqmMnYTEEafeDacXjLOT7+kV3AqnoO+qbA94SscBAYULtRTQFHCJ/emIU?=
 =?us-ascii?Q?AXeHRfUGMvZUIPk3WYecZ+xmAKRxzo2oHfUg5MBpiu3rJHYJVOZ1Ur4gglmY?=
 =?us-ascii?Q?fsggHeB8Wm9iDe78lGKCRDpJcMfIHDYJBcsYI6YqYSNqWwnWkiWgvbCrs1wh?=
 =?us-ascii?Q?I1DwS4PYoaIykOqTOhc85V92xF0uYn4l4Jtnb1tkUWdfnOsVJdfTRH9nWpt+?=
 =?us-ascii?Q?wJGWm136YF5NnGVHj/pRL1GZZO0IcLhi0Gg4Z37MEJa3tFF/5ExALnij+OlS?=
 =?us-ascii?Q?Jn+GHzBsYvBLlQOxSuDf+9/GxVhzB8w8w7cxqbPvduoBl+9930P8L3XWO/yE?=
 =?us-ascii?Q?ePfXNLn1rE+MTYeJRmsvq9q6XSQ+RN5xCP2aPCLsuLoYSegquZZTVUFoLl0G?=
 =?us-ascii?Q?Ch2fJz2jdj6cp6glFGNPIetQU/Frcp6JBde5UyvwdXFUqXRIWmTy0+AZvGu2?=
 =?us-ascii?Q?CBOE3RE7lpYuuKKUjwGRmHc2bZFNPNgWQDZLG/iF8H/5+yh+fe8J5N6vz4lP?=
 =?us-ascii?Q?7VhKfapzYFpB/uLnbX43e9v2aOFmY4Pp03/GnW3dfKOECwaIEIwrPpQAHbDQ?=
 =?us-ascii?Q?TXpnxcB3OzTvv2DLMxBDeV34LPuZ5fzE3zGrid+09g+zSUcdWEmRQi5t5EPs?=
 =?us-ascii?Q?UQip3b7PNdjzAtOhuv/aj5plQXS6BkooYepDOsxls2bwKwJgki/pp8M7GRCt?=
 =?us-ascii?Q?BAdVrUrrN0ukMCLkXY0zCuqc45Kk89HvLlwRZNEASm5U/kEXJraruAJXI2tY?=
 =?us-ascii?Q?o3MmgUwQbJpaT70U3QB+RPr4gCgKps9x9elYiLA1kXrtieeYbYm2XMLr3Waj?=
 =?us-ascii?Q?XFFu4QKcjTJVmB1cGJMU/215q2x9XvX/sLhdHhcs0FuP6rw7c+clM6dDk6AQ?=
 =?us-ascii?Q?tWNmY4RYp4hYhf1mPt4S1bZHUqGOh8us7j8bwevfM1+CpmmHKk0b/GoNkNTi?=
 =?us-ascii?Q?N5JZJztjGyHMIcIQ38LboHk/Heu1ELC2QyRpeYbiJHQ05Y1VdwtfYkbqVHEq?=
 =?us-ascii?Q?OO0tjP58e1nEBQ6dcHpamFQGJBCYWCcotQvoPWOFJ+Ha++8BAKHL23BqUgzr?=
 =?us-ascii?Q?rodntnbzym5PO2hcEIOVtmw9tDL7C0mxHAxO3UBFXB+/KracBNI0p9ETZ0bS?=
 =?us-ascii?Q?RasWqe5ygoo9eudBtwzEux3MIHH8rXkpdo/+7m5/qRfHvHlU4hYi2B4AAC5P?=
 =?us-ascii?Q?HM/339mLOJjB1gAw2/TUCg0PjnJs6mZ2xGeBn3l5BYQ6JowBjCb0s60aIJ7k?=
 =?us-ascii?Q?AEW9adQcO26dD1Fb79/bftbTuJEcB6W1q0Sf/4kZuDB43tFdq+aHZkUE6pg5?=
 =?us-ascii?Q?n4SlWDel/H2RTpZNA3lBH96RYjeu+kFSm6deIX4VvstenTAZoU5uTrCJN/ZJ?=
 =?us-ascii?Q?qGjaGW/3/tSl03GHmMfuTl3g8Y8s+XNoNByN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aiUMzgK2s1CX5fieYgDETF1kDHSxZ8UkURd2xyLnrc3KeZCb5sRxlN3wd3G3?=
 =?us-ascii?Q?IwyqpelmRwelfeounConILM9DzCa2Kv2yebb53fM7G/I3/rBAz9tfKktI9/4?=
 =?us-ascii?Q?aSHGCYYEsBLmoQlsePejzlR9Zlt/xGZ+vC2C5UW+R9ZwiP7qllywu7tOCVfr?=
 =?us-ascii?Q?ZcjtVg7NaQKcqVpR2Ci+XNWMERryXDZCw1UO58i3riD73HgefG/6Wo48o9YA?=
 =?us-ascii?Q?IbjtybeKeAdvRnhaPoupIIqS7xMV3mqQWsy/i3YlsahaZNjiqssrinquMeb+?=
 =?us-ascii?Q?G/T3ciHepqonOj/upFTEI4mfYwqc6Pw3YsbuqRAF0QwN6NsUgDBSC/oVf/4j?=
 =?us-ascii?Q?9qwVzoqx1RQakvxuXaT+mZ80dRi0db8g7A1fFhzx/+HCcGk7lNFqQx7AMyEe?=
 =?us-ascii?Q?XE+Zu9DbVBBYV5FTtCGfNPasG9H/j7tchcqDN9FAyylpKzVp0MADF6dFmCjO?=
 =?us-ascii?Q?CwpIqVAdKZlTDs2WfA/ZZ+OfCdD3wudltYFp81m+p4YuIwdp1R4hbQAQ50YJ?=
 =?us-ascii?Q?2m/m8FyA1v/BK+wy/wPbvDkYopT9E4mwn7ZdtATS1uPdVjvN4aUhFfSAbk3i?=
 =?us-ascii?Q?3/owqSUabpdGq2VIwERup1yrITAh91RII6jdbrO0cjXuMQEFdS/0XFDE0tqj?=
 =?us-ascii?Q?i3y0YTvRkbkn+hbuOwsjkwAne/iHnn1u6ubLcKCrBmPEKrKIYFy6upZfOO5e?=
 =?us-ascii?Q?DeyKNEbYpVU4PzQRxxtRr8YDYaDisH7ZY7my6TVoyzuB9llVY9jvFZ5N7gzm?=
 =?us-ascii?Q?S+IDkLtURMAH72z+v2CGPEK9+GoAtoUVWNzIizPNrkXDxSxKverPwCl1DbSu?=
 =?us-ascii?Q?d0+FUJmb1NiACmP6wrzbnUQXQCOfJ/RI+NZktrWfBd/HPEX29OUrBlITKYpU?=
 =?us-ascii?Q?aTogD/NgiROujsHvISuIHqiIUYEvXubwPUSnlQScABsphfMY8wWvXchAFk0Z?=
 =?us-ascii?Q?vwXeQ5yRvoZAaqS3HZtpWphvLhvl/5vxjR+9JpM3d2FmlSRcO/WMVHOiJUep?=
 =?us-ascii?Q?WJIPABaWsVFFKiWIcINVs76CxEclfjfIjES3NXZTR/+6MuWQDUVkJ/8I5VkA?=
 =?us-ascii?Q?OCy68Gb/p3tMQdZZpon2TLfTOPAG+KxH6/hx5PSqQsKan1+FYW7qF0lq9sh6?=
 =?us-ascii?Q?zW4AFHNW/emdIBifKivI7H9A9ub2nNvfW2mtsML3k1U22eJOd9vhfDqQtgOM?=
 =?us-ascii?Q?CKTUsyk/0ZntjxAFVAexaVRN8l++BA7xY8HVJbhFqSKCb4v10NnE7Djky2VC?=
 =?us-ascii?Q?aBCI2+GPv3yTX0kwfRM/qLhUpGmB5bBSqaFmz+KyLS4U6uiIrObmD1523fWA?=
 =?us-ascii?Q?0XRFMTGiC66QJQ2EQYXlZuhcryGyZMMspGGdu5orbPb2EcUnI8ZJu02Ou93k?=
 =?us-ascii?Q?IW9ZTcCeB/xN/tdesjPbYLfFCn6FuJ1kgzNzr2aNncr3ZDnDTsLHauGW6wHF?=
 =?us-ascii?Q?rz/uBcNQREmZ+jNypnkjNzNJYx9pTfy2HLYj3+JmTplyNLrV3RqKtyz6uuB0?=
 =?us-ascii?Q?b+iLIj8kpNgYL9VNdXYfCEZZtdllH6ca7nCeGWJCPmvD2c1hoitcrwmGRZCU?=
 =?us-ascii?Q?1TLdz/TEjrXveNgvfx6Z1EiIr7tdBei16Cpp5X6cMKD6eGt+HnuVQR2ffYHX?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02145246-57ea-430d-aa86-08de2e5eb04b
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:15:35.5408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIJK1JlJSvNzemfjcN3c3IdxiJj9gr4SVEvkAbr3NMfZeWCLV0bJpY9aXfXaayKNmqO+IYhH0f+5aEm1gkTZF6xAap31EUpqXbJHyPrqmNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

This includes a placeholder nxp_authenticate_device() function if the
chip supports secure interface feature.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index d2c79c462ebb..3455460d30f5 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1598,6 +1598,23 @@ static void nxp_get_fw_version(struct hci_dev *hdev)
 	kfree_skb(skb);
 }
 
+/* Secure Interface */
+static int nxp_authenticate_device(struct hci_dev *hdev)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	int ret = 0;
+
+	/* TODO: Implement actual TLS handshake protocol
+	 * This will include:
+	 * 1. Crypto allocation (SHA256, ECDH-P256)
+	 * 2. Host/Device hello message exchange
+	 * 3. Master secret and traffic key derivation
+	 * 4. Proper error handling and cleanup
+	 */
+
+	return ret;
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -1629,6 +1646,12 @@ static int nxp_setup(struct hci_dev *hdev)
 
 	nxp_get_fw_version(hdev);
 
+	if (nxpdev->secure_interface) {
+		err = nxp_authenticate_device(hdev);
+		if (err)
+			return -EACCES;
+	}
+
 	ps_init(hdev);
 
 	if (test_and_clear_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state))
-- 
2.43.0

