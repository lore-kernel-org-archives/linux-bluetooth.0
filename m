Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011009.outbound.protection.outlook.com [52.101.70.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC281D4150;
	Mon,  7 Oct 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306745; cv=fail; b=Iv+lJsy1Y0RgVhunr5EkyFylzInn6xiXM4VjwlMHxm56Z3bIW3zjiGh/I1Gi3l/Xyi6ivPWuYJwD6GGrDt6Nfq+2nzKtnGT/I9bc2YgukXJTw3TVlIua50fqNNw6G+5zoxDydvPYRSRMS0XblKfF19mrmV1eNYlIOyEE/0qdEvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306745; c=relaxed/simple;
	bh=u1n5aegv+v+lJzlEzVoSmjgtnVgnFEzm1/TcaL6j58o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VCtXtRrPGHrB1hsGESP8UxeOGy/ALBQkCNJNzBlTems3IqOk9QIdiybsD87txmKiVcT830kDFB9V46oh8TlT9BOIoefoZJLqwbX+94/bX+qh1DySuUC1c9m65jWjoZGTPveCoFJKQ56PKk8IR4yNgF+T5vXNjmunnO+1Sspi+9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gtJxTVUo; arc=fail smtp.client-ip=52.101.70.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gtJxTVUo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9kwAkuJmuNZILy9w8wEnjcn4SwpacmjFUtJdX8dqDBzj/ri4WNZPG7BdCScArT8OYbLNQ+Fu+AldcM6ZQxeyX1eH7jKGrRyfCEN5oWXbg90apjIo+jeuy5Nu+CiaQe4+diE4OxKEQcqiLVQo6MDSt3GvZYRNrP/aMATGSKwxdHmK+fZESq06I4LZeo3p4xbR5VIx77Y6FBAsxP/QwYJLH1t7FUkoTtWQZ/Agl9LafIrdZmnK8bUVErjURXBtvTI6SIL/j6WB3SUUSs3MXKBwlWV01xECBdVeO07fNNMWQxgeSRB4HreUTAXgZyiBgQKQKtMQByB3hOuHDWfC5FeMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rkb6riXf7TVGW3KgRMzNRoihRsiBPuHwVgvJUug7jbE=;
 b=jMcTf7hDKrzHNtcktu4CvzmKBQBxLhoMUprDB9OeDHZTO+DcMt2dDPixeKsiu61/xbmkdxEm3PT3YT1tEYGKpcMTX4+MCMjt4LBCil7yKcgyB58LYWkLVSZ3c5swtN8x7l4NHNEDZ0fA66d+XTnQvfvxiSftGhHlYwBIxdLsHSWsGtUmxQw9GVBO798XQWo+dxgO+WDI1nfhm3KKX1qQ/CXs9FHP15jTasQlPCs38HkwDny/HizJOIkiAq96RmQfV7WMliFNmyM/jWkPxkbcBB483Y+tJx2g/Y7evz9Z01NirwuDOF1x1Lq8WOcvSqyrbqGuVpcFBO0gXufat62aVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rkb6riXf7TVGW3KgRMzNRoihRsiBPuHwVgvJUug7jbE=;
 b=gtJxTVUoleKRW+mo0qUvO70dSWYJXuEGg2XHMb1tkvwahadFntGyXPpj1DL3dTSyBYI5qIOP0kytyBAsR3IFak/NJV91vm4/lwvKrDOseU5FbO0s1kWDllDVYSmTSbq5CT7+YqGgkPM8YQxGr+ZQgNjXR1MNO/AihNT7IJ8U22wIkz/mF8oQa6UNHox5292XvFIu3BWEXLTvgyOQ06IEVMQ1PRjh9aXKsqBQ7ZP+fI2K2Bea7vYnZg6hgajMMY1STtVTpn6p3IYi2TylIKkQFG3LV6Q/yIz8UgSpiI2AZTevAdmVh46dKWFYgzfxqr0C7HB5vgtUdAMfgtmQw2TJCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB11036.eurprd04.prod.outlook.com (2603:10a6:102:48b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 13:12:22 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:12:22 +0000
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
	rohit.fule@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com,
	haibo.chen@nxp.com,
	LnxRevLi@nxp.com
Subject: [PATCH v4 2/2] Bluetooth: btnxpuart: Add GPIO support to power save feature
Date: Mon,  7 Oct 2024 18:43:16 +0530
Message-Id: <20241007131316.626690-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241007131316.626690-1-neeraj.sanjaykale@nxp.com>
References: <20241007131316.626690-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PA1PR04MB11036:EE_
X-MS-Office365-Filtering-Correlation-Id: c51ff22d-e318-4932-3b00-08dce6d1adeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7oXbXmFU6jpCuNFr1sY1Hbci3jR+jpWxb08gdGCmzNmFDJvH6ozMNhVQl1Tt?=
 =?us-ascii?Q?qNeKbt6WjQ3ClLhZz7PW/AuAkjy5fQ8RotMMjptMSIu2S1N3CQOqFjZyGqGO?=
 =?us-ascii?Q?nqI9d/ROt719f2R1j+9+gJI5rRktUjsmRG0LuFocsuP44WfbE6xW0/gNOIVE?=
 =?us-ascii?Q?zPGTT16ZgpdWTAjANoZ2ALmtdV0eL8TU2UE0ZY/z65DtvI8W7WHmQC2IlGMq?=
 =?us-ascii?Q?7Y8sUevta4EhBoqFeawfCEPEphKEa0ocHkVfqjNtsU7kuMjCwZuyacMMOR5I?=
 =?us-ascii?Q?cR8HsjlLbVzorOO7hmyalKLGWXQ5f38i0A0pLYVCjSO4zDV8r/XPzJo2AZkS?=
 =?us-ascii?Q?i1/cODI3hnxpowqJpPuhdx3q1yqlpYnXATxU7d5yqR0p75DW9L2vL2fJmA2P?=
 =?us-ascii?Q?IxAjMCf2cIOMjLdabBOF/PqBnRAD22hCUTVNnk4RXybqTJ+vB1OJP5NXFsXE?=
 =?us-ascii?Q?uacInBz6ixrimBEKtWmCp+MRt/7X3TiFBXAiS9TJgBE9kkWhzevjo+qhMrPC?=
 =?us-ascii?Q?8ZJOMGzO6x4JjZ1zmi+zhUrDPUbVjs/7y5UVxLqeutJaaMiBANdcfpACt77W?=
 =?us-ascii?Q?Zf4DhxpTOWRD1XiF9xSjPpCfSCXI1R16R6osFEqZuB7eTgZYZpSI8fLD/eu9?=
 =?us-ascii?Q?BR+oce3kbptdd3ajlGO/JBQAWTWtG6aobXjGuqWZ/lR8ycC4mrooEXMGA3zw?=
 =?us-ascii?Q?n6g982eq8E1VRu9FDUEptPg2lEfD+XeyYTjWxwlCTPby4IfroSKoAerV1hUh?=
 =?us-ascii?Q?Zd9mSt80CgNzu9fB3D3RSeIx+aNT54veWOPqAGpeBbBjxTJLt7ptQnwDRWqb?=
 =?us-ascii?Q?8jxCCdmLObpXDmqXp8945d2AEpdT7PsuCBLICoTWSFalRS45RcIy/pNAZlqU?=
 =?us-ascii?Q?PPgzQbFpXu7Bc4J0V27Hswe8rRz5yoGBorkjhWCveCrOO4WdNS35oCdcbm/i?=
 =?us-ascii?Q?iDbM1rspyf4CVXkV+UKoLEJNRaJsYrV3CwFWpA6X4dWhD3RHbgrLwR1sbmlt?=
 =?us-ascii?Q?XLQ6vrx1oXs+1JC5tMAESDIihh6qsW9dDTzhNzeOmZPbrjmN84yI3X2vkWcZ?=
 =?us-ascii?Q?GNVRaorBehXM40jryudnU+jcolEJgPqrr+cA6pRMjUgNlHBZ76E5QyfLmXVR?=
 =?us-ascii?Q?Zoza8Mre48hqYJxYLGlIn/X/CewAWoJWQW9xdX1vD6cfZih6rySMHm7dhpYS?=
 =?us-ascii?Q?m5RqDtQg4dj7zpIP673LYwASDcjrZSGtssH+jdguiiS7Vl1Dyxvfw9fKor+l?=
 =?us-ascii?Q?Cp7PX831jVa7u9UdVNxBwNN5JfHcFzM0pS6rrJTlmsIBuxwiONUnJd6oyTtD?=
 =?us-ascii?Q?8oaI0f5WTYIAmG/sSWZKNr8w31y5nJaNGDCzVcXUqMGH4g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BvL+GJsy0h6LKN8zCGY/5zNYuXZc51JFm9Ud10oLgzxIqZbNX/+tpUr7kKvB?=
 =?us-ascii?Q?ONh/gDIKjHIggduLvqm+ce2/qJ5ttzD8qn2UQU6ha9rYsQ1bB9UWne1la4wz?=
 =?us-ascii?Q?ci+JlTxYJgckl9SSEhVw0bps5SNzScL0xHn5TZlmxCtODS3FPDryBZKmlYt1?=
 =?us-ascii?Q?+PrDhsD+jxlZN+KdBGuJfnW8sleBw6Utczk+iFIfLUrwJU6XzHgfHAltv+X3?=
 =?us-ascii?Q?xd+dkf++PwlMAage+L9GGIpGaKnS5eh5ywRbOU1fKvdn849gVNTC4Fw8xaeE?=
 =?us-ascii?Q?4s+OAEvdjhsEX0ekazOmb95JH7QHENtvkM/4z1D/gX3riYQD5X9xtVSvX4Dy?=
 =?us-ascii?Q?pM2hnRn98mxJaKhJIjs/BdG3LamiYRBejh0XDR7KBbs02Z7dU1+DQMc+6OxF?=
 =?us-ascii?Q?COLJR4UauJ7B7tlo3NBTrt8LPRTDTKdVknPInHdnX7fOksFGCobtNAuU7xSB?=
 =?us-ascii?Q?MvrG6v7C6AbhEMtccZicOpjQOv5j0cI61K44WTEt0hkhQrXnZaAP88zU8RfI?=
 =?us-ascii?Q?GwwJXBIef7hz8kTQLKHCsdq/ubmODbKn+OZedhZxjc5SD/laOEisbIg4+RtY?=
 =?us-ascii?Q?fOoAWWS0iytnnnwMr2UxUb6I3Y5Z+m2L2h/J1j7LUWjbkUYycA8291BEDDNh?=
 =?us-ascii?Q?FowowszdQ9qDrE8aEfFGqe5UZgdh29Rn4nLU6OB9Kkms6DCnDAdy0fx3j0Dd?=
 =?us-ascii?Q?pK7YQ6Sb9COoGI9l+NjZgURzeeG8M9obtm8aiWFZPXxnizkD5e15H71PFvGA?=
 =?us-ascii?Q?zbBfNZJcePuq4hW9g7dp+u+ZqUQkHV1HLUtQlqbG97vR0Vi3sF+0mL77y5Nk?=
 =?us-ascii?Q?RpDYcEP2Ms2lpsZuf95wUx6GXwxrKQznXs1uNfWe4RjXlB5ejr0AsFHhpuWk?=
 =?us-ascii?Q?dPFogC9pTBshxveS20OHuNjmEdEOZZAvW94Wu0N1536kYVZo+GfLt6MVoDtx?=
 =?us-ascii?Q?tZQ4q4AW80I24e94ztE0jqq1LvN+OKfF7SzdBndr2hqfQ0LccOMCBaLpcWK3?=
 =?us-ascii?Q?hX0IKDWB/3yp264Ik2HEmrHM9bSACHj6HEJja9NbEwBGQvaAH7s5b8pdbXv8?=
 =?us-ascii?Q?KiqLEDFqO6oJxABd3ZHk3OTyDUwvzUqbYtS9R9CBJ91e9s+MWjaGm7+mjxyX?=
 =?us-ascii?Q?SvAkeemZMYukQWNmwWNZJxJpMfpQncZ1d8SJFJolwMiXGQWWWgZBBfsB7thP?=
 =?us-ascii?Q?lX3A/dohjy9qJ05yWBT6iSfcjjiNgWxqH1mQIBoO/Tc4eEKjcNe7fGI61+K5?=
 =?us-ascii?Q?jZfmRPrhWecvK13O39z/L8uGjuE48dimP4KGjq0yzgbk6/JEbySskvFppnx1?=
 =?us-ascii?Q?TneHQC94bj4SRtDh/w9c+5jProBUjMUQG6G80diYgUbkRTKS6Nrk1p4Vtkno?=
 =?us-ascii?Q?FZ9nm1OBKiI8k9WGwQASJPL2GQ1KM8Ya3zU5II1c28t4Sc4u++Fb7Ac7jGJm?=
 =?us-ascii?Q?aQduY0ilsuHhhgqPpwmqcxJW3VZeqN089uor9PgdYRn/JB1A4QAcBzh7Fh/N?=
 =?us-ascii?Q?wnZigRkNRSXuktgU6fQ+bs/O/wVcZW83WYwu86sXpYLVLOugvGLxiJLpsgqR?=
 =?us-ascii?Q?Sk/78WBKCJZiZsg2EbEPgLQsZ2sqBMqBK4yk9v/ceDZV9xfKz7Px+SgpSeni?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51ff22d-e318-4932-3b00-08dce6d1adeb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:12:22.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u7uBnUx89qr+phBproX74NL5bIixfQIBYSCoKtwYFhV7iNWHayQ/4V9NeTvL8vD+eNH0uALel4OHQoFAqGGwkLLgN2x2rlNxa33C9XSA4sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11036

This adds support for driving the chip into sleep or wakeup with a GPIO.

If the device tree property device-wakeup-gpios is defined, the driver
utilizes this GPIO for controlling the chip's power save state, else it
uses the default UART-break method.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v3: Remove GPIO toggling in ps_init(). (Shenwei Wang)
v4: Use devm_gpiod_get_optional() instead of devm_gpiod_get()
---
 drivers/bluetooth/btnxpuart.c | 57 +++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 2b8a07c745c9..83665f0b96c5 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -16,6 +16,7 @@
 #include <linux/crc8.h>
 #include <linux/crc32.h>
 #include <linux/string_helpers.h>
+#include <linux/gpio/consumer.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -82,6 +83,7 @@
 #define WAKEUP_METHOD_BREAK     1
 #define WAKEUP_METHOD_EXT_BREAK 2
 #define WAKEUP_METHOD_RTS       3
+#define WAKEUP_METHOD_GPIO      4
 #define WAKEUP_METHOD_INVALID   0xff
 
 /* power save mode status */
@@ -135,6 +137,7 @@ struct ps_data {
 	bool  driver_sent_cmd;
 	u16   h2c_ps_interval;
 	u16   c2h_ps_interval;
+	struct gpio_desc *h2c_ps_gpio;
 	struct hci_dev *hdev;
 	struct work_struct work;
 	struct timer_list ps_timer;
@@ -365,7 +368,7 @@ static void ps_control(struct hci_dev *hdev, u8 ps_state)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
-	int status;
+	int status = 0;
 
 	if (psdata->ps_state == ps_state ||
 	    !test_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state))
@@ -373,6 +376,14 @@ static void ps_control(struct hci_dev *hdev, u8 ps_state)
 
 	mutex_lock(&psdata->ps_lock);
 	switch (psdata->cur_h2c_wakeupmode) {
+	case WAKEUP_METHOD_GPIO:
+		if (ps_state == PS_STATE_AWAKE)
+			gpiod_set_value_cansleep(psdata->h2c_ps_gpio, 0);
+		else
+			gpiod_set_value_cansleep(psdata->h2c_ps_gpio, 1);
+		bt_dev_dbg(hdev, "Set h2c_ps_gpio: %s",
+			   str_high_low(ps_state == PS_STATE_SLEEP));
+		break;
 	case WAKEUP_METHOD_DTR:
 		if (ps_state == PS_STATE_AWAKE)
 			status = serdev_device_set_tiocm(nxpdev->serdev, TIOCM_DTR, 0);
@@ -422,15 +433,29 @@ static void ps_timeout_func(struct timer_list *t)
 	}
 }
 
-static void ps_setup(struct hci_dev *hdev)
+static int ps_setup(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct serdev_device *serdev = nxpdev->serdev;
 	struct ps_data *psdata = &nxpdev->psdata;
 
+	psdata->h2c_ps_gpio = devm_gpiod_get_optional(&serdev->dev, "device-wakeup",
+						      GPIOD_OUT_LOW);
+	if (IS_ERR(psdata->h2c_ps_gpio)) {
+		bt_dev_err(hdev, "Error fetching device-wakeup-gpios: %ld"
+			   PTR_ERR(psdata->h2c_ps_gpio));
+		return PTR_ERR(psdata->h2c_ps_gpio);
+	}
+
+	if (!psdata->h2c_ps_gpio)
+		psdata->h2c_wakeup_gpio = 0xff;
+
 	psdata->hdev = hdev;
 	INIT_WORK(&psdata->work, ps_work_func);
 	mutex_init(&psdata->ps_lock);
 	timer_setup(&psdata->ps_timer, ps_timeout_func, 0);
+
+	return 0;
 }
 
 static bool ps_wakeup(struct btnxpuart_dev *nxpdev)
@@ -516,6 +541,9 @@ static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
 	pcmd.c2h_wakeupmode = psdata->c2h_wakeupmode;
 	pcmd.c2h_wakeup_gpio = psdata->c2h_wakeup_gpio;
 	switch (psdata->h2c_wakeupmode) {
+	case WAKEUP_METHOD_GPIO:
+		pcmd.h2c_wakeupmode = BT_CTRL_WAKEUP_METHOD_GPIO;
+		break;
 	case WAKEUP_METHOD_DTR:
 		pcmd.h2c_wakeupmode = BT_CTRL_WAKEUP_METHOD_DSR;
 		break;
@@ -550,6 +578,7 @@ static void ps_init(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
+	u8 default_h2c_wakeup_mode = DEFAULT_H2C_WAKEUP_MODE;
 
 	serdev_device_set_tiocm(nxpdev->serdev, 0, TIOCM_RTS);
 	usleep_range(5000, 10000);
@@ -561,8 +590,17 @@ static void ps_init(struct hci_dev *hdev)
 	psdata->c2h_wakeup_gpio = 0xff;
 
 	psdata->cur_h2c_wakeupmode = WAKEUP_METHOD_INVALID;
+	if (psdata->h2c_ps_gpio)
+		default_h2c_wakeup_mode = WAKEUP_METHOD_GPIO;
+
 	psdata->h2c_ps_interval = PS_DEFAULT_TIMEOUT_PERIOD_MS;
-	switch (DEFAULT_H2C_WAKEUP_MODE) {
+
+	switch (default_h2c_wakeup_mode) {
+	case WAKEUP_METHOD_GPIO:
+		psdata->h2c_wakeupmode = WAKEUP_METHOD_GPIO;
+		gpiod_set_value_cansleep(psdata->h2c_ps_gpio, 0);
+		usleep_range(5000, 10000);
+		break;
 	case WAKEUP_METHOD_DTR:
 		psdata->h2c_wakeupmode = WAKEUP_METHOD_DTR;
 		serdev_device_set_tiocm(nxpdev->serdev, 0, TIOCM_DTR);
@@ -1279,6 +1317,9 @@ static int nxp_enqueue(struct hci_dev *hdev, struct sk_buff *skb)
 				psdata->c2h_wakeup_gpio = wakeup_parm.c2h_wakeup_gpio;
 				psdata->h2c_wakeup_gpio = wakeup_parm.h2c_wakeup_gpio;
 				switch (wakeup_parm.h2c_wakeupmode) {
+				case BT_CTRL_WAKEUP_METHOD_GPIO:
+					psdata->h2c_wakeupmode = WAKEUP_METHOD_GPIO;
+					break;
 				case BT_CTRL_WAKEUP_METHOD_DSR:
 					psdata->h2c_wakeupmode = WAKEUP_METHOD_DTR;
 					break;
@@ -1509,13 +1550,17 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 
 	if (hci_register_dev(hdev) < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
-		hci_free_dev(hdev);
-		return -ENODEV;
+		goto probe_fail;
 	}
 
-	ps_setup(hdev);
+	if (ps_setup(hdev))
+		goto probe_fail;
 
 	return 0;
+
+probe_fail:
+	hci_free_dev(hdev);
+	return -ENODEV;
 }
 
 static void nxp_serdev_remove(struct serdev_device *serdev)
-- 
2.25.1

