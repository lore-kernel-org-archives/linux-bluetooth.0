Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C714158531;
	Fri,  4 Oct 2024 12:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044333; cv=fail; b=sA1+xkUslZF2uCjJ3JpFMcwsfud9RkFv614Nh8ghrx65kZUEUyp4A9Iia1pXElg021kQS7yxxOj3xBe+4W4rEZkaCRquGzJ2EEZPVNXEcYg4c6jLp5tby0WjHSY75M4Vf2Jr8YxGNjae6ifbS9JAo6ymJ9hceFsCpPw9efhNtvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044333; c=relaxed/simple;
	bh=k1iiNseEzEQV7Nm5rJ8OZ7bfkb56bye9KOao6z4vb4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uFuhZ1ngkHM5SEy/FVuR0ml2c89L3TfMGGC+FsbBzKtYSqvXMH79UJjg5BqKeC3F7zZezzPDhUfUd+m3fhwvcz5uUbbjRrW9Fcb7kiJHtdpYCpGqOxEPamfPIRLt/RZE13ygVZ6wUVV0vVZHauGhPNR3abm1hJfhAadruWK4ac8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NpnoR/g5; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NpnoR/g5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkjEpSWesA2wFI+iNneeKqna8Z1Cr4b/w7M0jls0bsY5YDGa3T23hY768EujrKqviheBfZt6TtqPHdBC7tGaF51fxlhxMLG7xFcPbFgyW42DdnFs/Rc+RHBkd8zBFnFzJ4kPJ0a5N/bvV+C5WCXDrx0fOft2OyXrP5026ESrjQOkMfyoBQGXiKknKgLgamE0Hn9E4H8TPcbixQ6XlRtSV1TUMy+MecdxC2kS1xsod/cLgpcFrohMvvl3UFkmXbQKCkFDlCRgPA+phnmot+E+yIKzrcxInoGzRvjSbfy713nH6sWatjPUlzqTlAonznc/7atEcvXOV1IMIcT3niLdWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+OAr0c1W0uSnDi68sMu/rsE9VRoTByEayn+yFgcInTU=;
 b=VhxLSXdyIzpOxKm6RCctSlWXaJu/veIzM1J79KEv9VmHKRlcoko/GorAeqj9JwHtv8fCRzDp0MMOIS/mWVuEzlewIulf8Qp6y77qNxyncgyi43LfRZa6IZA50FNjg5dtxK1kVOXNiwsjzmiRrJ8g2J8QLqFzHG9nAJbhphy0QKCk61aY2ugUUoFgosdwbYPhzBen4uV22MFdyd5jfRvdr4sKk98ZzVEGkkoNWwczslUkdKHanwgw5Q+nULkC9KlErLeqaxNZu/SPhyJcpZ7IMyN9A3dzR3q2dxhAILDR+m/giVR3CkGUHL1kI+Vyd9CEyRwyWyP2GmReAt23enCJhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+OAr0c1W0uSnDi68sMu/rsE9VRoTByEayn+yFgcInTU=;
 b=NpnoR/g5Nn/5ELQ9RymKIaWsSWFcRZPUhKQb6Q2fDIfLBW5/57CPtM4q4GFiLM/XuxUXgHl4f72nha3ZThGHfjEaadk+HATO1mOfdKFCJmFB+Kv0DsmVIz++vKKuIvhGfZ6sayvoe6wbhaim2maXDQHz0wMviOo2CzSlZxli3EK2zZu1NV+jhA7i+zh4FLCWqlL7m+fy7PqhLqYQ6Cp2ufCHn/Ztyxi3u9/+aiJ0sfDlhNLeDm/XUNKOZM7yUM0fNIGgg9rphfNkKZVhTKQy9RPKM4VgjYIh2V6oz1De0iCmcwcMluVq8w1aLRj33kabqVwx+OeLwzU4JejraSu5hw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GV1PR04MB10242.eurprd04.prod.outlook.com (2603:10a6:150:1a8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 12:18:48 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:18:48 +0000
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
Subject: [PATCH v3 2/2] Bluetooth: btnxpuart: Add GPIO support to power save feature
Date: Fri,  4 Oct 2024 17:49:41 +0530
Message-Id: <20241004121941.572539-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241004121941.572539-1-neeraj.sanjaykale@nxp.com>
References: <20241004121941.572539-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|GV1PR04MB10242:EE_
X-MS-Office365-Filtering-Correlation-Id: f19ef2c1-7616-4542-04f9-08dce46eb2da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qMFbKoBND2dQtCgYTHaINxftLcS5RUgzCaZUBklTTK/6R855jlCBKWY02nX3?=
 =?us-ascii?Q?cyExMOd7yVxUW8rEcNlPLJpnnbckDFw/5tytl5XCqXZxBq+XJx8S6uCa0TVA?=
 =?us-ascii?Q?9fvT+OdvHuxM3nglww/QMbiW96Ky7+3kF55DygqPwK/GAIwhdR+3gyNUU+vl?=
 =?us-ascii?Q?ZBe8+3FLV+Qd0YsBb5ZyW4Spe1m7fz2XfYU8bgio7hJeOHb+WDZR0BXCXRlI?=
 =?us-ascii?Q?qI9fSPqW+e6miucYrNB9ce9L7yQRGo7fNMh7a4t7EkbDmcdgM/v6mgqgIWGy?=
 =?us-ascii?Q?dPkIODfhH5aQ39Rxctzt6dsyMARsllk8dOsgIThg5b3iuIVQbNplP0OyZKcQ?=
 =?us-ascii?Q?LJq9b4eUYyumejtbWxRTy4c6LlDOcuFUynbkkcFTAh+e0GjMVoEQ4Xk5uMqh?=
 =?us-ascii?Q?PjPG5YnAQvDn8tplFaknH+mfvph4MXX0XSkbboDFY9beo1hknXzAv6TQT4e3?=
 =?us-ascii?Q?OrqXSrBKgC72gnLuBto7a5DQK8dtB6Y5DvZ4C8PDTRomtHO0ChKM8p5GH7DL?=
 =?us-ascii?Q?jul1iWMcuS+nDyizqXSwVffbxg2+jO5IbIMbOt1+dqNUfSYB3mTMYVLSfiqP?=
 =?us-ascii?Q?RjJKeF75OFoxV3B0YmZmdJUlK7t0EYcMiu5fezz5zgb1XXAHOf1FTQZ6T5vK?=
 =?us-ascii?Q?MZqWAOXLe8gswlUX7FVJ1/s1ZOOlobspaYlANthZKUvLSdNbczIw5p8OfXNA?=
 =?us-ascii?Q?RkJ5VOrqzkwnb0n42yiRrpJIvOnsGBX50+Zd+f0fSRdgyGay6xwHQgg8rsVN?=
 =?us-ascii?Q?8kCRTrsERitPaXQZtOur3tOK6tu0nFJ1j+4djcVZklspPci3wItq8wjB5BSi?=
 =?us-ascii?Q?+kJeKgCW0pJhHysEvQ/PSHiN0Egd+q8TXGPOomz6c7/MM04M537jzt5ztQ27?=
 =?us-ascii?Q?6RLrgLdKvjLy3501BaSjNBEkbyTlNjzy77VdC934GydjqWELkNjWxkbEKor7?=
 =?us-ascii?Q?v5NjSGh0cZFkeHOsMxzwhfAbCBlZb0pq9BwHUIjb97rzm7qURPJWNVhr8UWe?=
 =?us-ascii?Q?mjo3jiVVzX5h/27sAul84W0mgRgZNslGnxBG1D113P0Gr2lh8cPElWy/kUD8?=
 =?us-ascii?Q?OGjGSELMn1fFJ3Zppx3v562SX/YXco3uVsx0b2W8FtJDDvF9ePXIGJa7VBIw?=
 =?us-ascii?Q?/5eF62liFyVWvLjiwPFLcAVhLYr+awQ1tItAltDZEfSdWpHvgU520p/b5pPJ?=
 =?us-ascii?Q?sjmG76rqF/cyHpVo7+HjoCDVrZBCNHp81U+CJSQcC+K+Cc7bc3j9zxw4v5ml?=
 =?us-ascii?Q?WKBu5ByWF5RypV1mzS8m8xrlCJOxYACG1hLx9KFzo4G2WfByqe1/TDQp+TbJ?=
 =?us-ascii?Q?BSajQpwdwQyuewn+PpunbBzxtW3jMbPFznJgG7MPjQLu/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vLUpOCUMbkeTsogWB1OwAXLLPLBKJIs2fOcLHbDEFQeZ5cDdp6unom6SAAf1?=
 =?us-ascii?Q?fTvPkB+nZ5FUf6AVtKanm672nHM2WIak82xv4ZlpLJeuMlgB3yELjogPhzx8?=
 =?us-ascii?Q?bJWH55Xc2QDmyz7bewIQTtyuKAGlaYbliPtS7ShNsMh0XBw839sP2wt1sngP?=
 =?us-ascii?Q?tDbNO2chrUme6LE70pNdjAzM0gtvf24XnT61kU54jePbdXrOk8r7dftBPpEF?=
 =?us-ascii?Q?a2f7cuwhPjCUXMYb2FBUUgEWG69GwI5CWEQ7NScV0ROed+NsrLY3EeEwWXqg?=
 =?us-ascii?Q?ABnXHGqJcawYV2lz7Qi6jXeagEogNHWDOnz1wwmdhtVIvz4h1ddbxBZ6vrD0?=
 =?us-ascii?Q?git0bZI24zlCBS3dNf3KqsldoQGj29H3uHT25zv/x/I05rwvDftwGY6W1GO1?=
 =?us-ascii?Q?jb7bpKVaY0ODpt+cpU+wFWiaXcQsWtO0EL9BRnZtxnMGxb6XtJ9WPM663fCb?=
 =?us-ascii?Q?SnDaSr4wkzKcKgjgliuUJ/uBAqllbTTdzYVeJkmSrfMDY1KpHRIclSvZhsrR?=
 =?us-ascii?Q?1jwdn5zf/DFWQWDshup4QyqB90hbS3nJqomylgAc1o2tXskY9NuDYq0rywTk?=
 =?us-ascii?Q?gG1NVH7GHZUwFzXs5JMR77FFkhP5McDdPV82IPRdbd+OrH7NMzrkmJvLuyeI?=
 =?us-ascii?Q?1oFehC5lYIEfoQiCOELaMGlNP1uxaPnAVgk6wvuD+GSmANpCoPpEY6hFIJmu?=
 =?us-ascii?Q?b2GXhAhX3eryygCc210BP98B/DXEXBatehDgq8WhN81vm6uGQZ8TpJjb/2h3?=
 =?us-ascii?Q?vGM+jR14JqycJ3Y6bKBPHLsaqJzwObAtUhiIMd1wf9mTe1F3jF4UXw/D+sUt?=
 =?us-ascii?Q?tzBIIuzCD4U/uHpJEKyDv66rhw4pUd+1aBmdlFMFom0syA2Q/9HzMVmocg7H?=
 =?us-ascii?Q?H3s/eBVg1aMxywwusmmeEslPK67LmfrUlQoddQZjpYS86XPjAgbjX9APuCkc?=
 =?us-ascii?Q?sc7QottCCD/BX2i8fehYXxl1xkY/JEGW7N9aBim6hpIqtqPQuNM5LbCUb7Uz?=
 =?us-ascii?Q?OB7/TN+WTkRPvnabOGcQDcncd34t7qVsvmWuyqH9kCy74wBGyzP/7h4M4snp?=
 =?us-ascii?Q?FTg+U5jQcGy4AQifYFO+QIkSyCF4YQCZx/JuGI8KTHovCszyBMxw79XNKg8g?=
 =?us-ascii?Q?xaQr3RBs6cfg5qN6xbdHCgJIS7CcqjrX3QoHOxAmH5TI9lqLNeiTTPsdCo9r?=
 =?us-ascii?Q?X4uyRfAAj2BG2chGRv1gCyQEvRlOEvWu0cOqTs/cENoJDmOOHplqUK+qrSwY?=
 =?us-ascii?Q?6cFxrHHkDTxDfzlteRXITiUIWWUtwlFGv6pBC7lYYItR8rTCpvbFbUl0+KAJ?=
 =?us-ascii?Q?//YK97LuSSdoPgmqYaAeGvcuuMjuvqp7Is02OJ0nMKoqZWLj4vGAClvDBoEd?=
 =?us-ascii?Q?NR5m5ce8zOa7N4MsyzWobnwS1JkdYiVZuHnPrnQhT4PfsIUlexG3/eC2/GR8?=
 =?us-ascii?Q?29IbAEa71ayFq7/ojLBgF2niC5fGDmLbSfPNhdusLTU3ZUO3YDwLbA0QWbaC?=
 =?us-ascii?Q?uEF9cxgTOr8QZqfU1cXtdhUNNy8PTBKs0+62/UXJozWtBp9wsJtfEEOU9i3o?=
 =?us-ascii?Q?YnRIF2cD9u1wd4dxGGh6D5w34uB1C21uFsrvy/mAhD/CtF4GORWHwjYmo8mR?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19ef2c1-7616-4542-04f9-08dce46eb2da
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:18:47.9505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeiFjU3M7M1kZTg/KYpKFKHxXQugGQjET6Zz464UkDx5hNUN1RXZkSmRNh8qqOeeCjBslI5ZObRbGfZyt91A/rMj/IszlkKfG9+czdaOBf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10242

This adds support for driving the chip into sleep or wakeup with a GPIO.

If the device tree property device-wakeup-gpios is defined, the driver utilizes
this GPIO for controlling the chip's power save state, else it  uses the
default UART-break method.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v3: Remove GPIO toggling in ps_init(). (Shenwei Wang)
---
 drivers/bluetooth/btnxpuart.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 2b8a07c745c9..4b7e8b7c522a 100644
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
@@ -373,6 +376,12 @@ static void ps_control(struct hci_dev *hdev, u8 ps_state)
 
 	mutex_lock(&psdata->ps_lock);
 	switch (psdata->cur_h2c_wakeupmode) {
+	case WAKEUP_METHOD_GPIO:
+		if (ps_state == PS_STATE_AWAKE)
+			gpiod_set_value_cansleep(psdata->h2c_ps_gpio, 0);
+		else
+			gpiod_set_value_cansleep(psdata->h2c_ps_gpio, 1);
+		break;
 	case WAKEUP_METHOD_DTR:
 		if (ps_state == PS_STATE_AWAKE)
 			status = serdev_device_set_tiocm(nxpdev->serdev, TIOCM_DTR, 0);
@@ -425,8 +434,13 @@ static void ps_timeout_func(struct timer_list *t)
 static void ps_setup(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct serdev_device *serdev = nxpdev->serdev;
 	struct ps_data *psdata = &nxpdev->psdata;
 
+	psdata->h2c_ps_gpio = devm_gpiod_get(&serdev->dev, "device-wakeup", GPIOD_OUT_LOW);
+	if (IS_ERR(psdata->h2c_ps_gpio))
+		psdata->h2c_wakeup_gpio = 0xff;
+
 	psdata->hdev = hdev;
 	INIT_WORK(&psdata->work, ps_work_func);
 	mutex_init(&psdata->ps_lock);
@@ -516,6 +530,9 @@ static int send_wakeup_method_cmd(struct hci_dev *hdev, void *data)
 	pcmd.c2h_wakeupmode = psdata->c2h_wakeupmode;
 	pcmd.c2h_wakeup_gpio = psdata->c2h_wakeup_gpio;
 	switch (psdata->h2c_wakeupmode) {
+	case WAKEUP_METHOD_GPIO:
+		pcmd.h2c_wakeupmode = BT_CTRL_WAKEUP_METHOD_GPIO;
+		break;
 	case WAKEUP_METHOD_DTR:
 		pcmd.h2c_wakeupmode = BT_CTRL_WAKEUP_METHOD_DSR;
 		break;
@@ -550,6 +567,7 @@ static void ps_init(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct ps_data *psdata = &nxpdev->psdata;
+	u8 default_h2c_wakeup_mode = DEFAULT_H2C_WAKEUP_MODE;
 
 	serdev_device_set_tiocm(nxpdev->serdev, 0, TIOCM_RTS);
 	usleep_range(5000, 10000);
@@ -561,8 +579,17 @@ static void ps_init(struct hci_dev *hdev)
 	psdata->c2h_wakeup_gpio = 0xff;
 
 	psdata->cur_h2c_wakeupmode = WAKEUP_METHOD_INVALID;
+	if (!IS_ERR(psdata->h2c_ps_gpio))
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
@@ -1279,6 +1306,9 @@ static int nxp_enqueue(struct hci_dev *hdev, struct sk_buff *skb)
 				psdata->c2h_wakeup_gpio = wakeup_parm.c2h_wakeup_gpio;
 				psdata->h2c_wakeup_gpio = wakeup_parm.h2c_wakeup_gpio;
 				switch (wakeup_parm.h2c_wakeupmode) {
+				case BT_CTRL_WAKEUP_METHOD_GPIO:
+					psdata->h2c_wakeupmode = WAKEUP_METHOD_GPIO;
+					break;
 				case BT_CTRL_WAKEUP_METHOD_DSR:
 					psdata->h2c_wakeupmode = WAKEUP_METHOD_DTR;
 					break;
-- 
2.25.1

