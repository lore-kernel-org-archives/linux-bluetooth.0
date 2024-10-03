Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4881A724D;
	Thu,  3 Oct 2024 15:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970265; cv=fail; b=bzQUTHHfOh3oWvoSJ+2FQX+QRmd3TlC6WyPW2O2KzO1f56Q860+bsjwo2un4GU8S85eLkVZfxn8w2r7AKHkidPHJY3APsQ+N3gF5RjrNbBVx9tHykYd/TVSe7hEwWhJXRy60IG9NCAZUl1B5i1ozjfJKG+OOIudxLQNDmCRmUiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970265; c=relaxed/simple;
	bh=FL5XW6E22qkOMTo8vI/ivCq1ZxxOjxs75S8IVl7MOsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u3jdcUpN+OGnG/9/Y6HjdmWY01UasenD1riAasRdSaQyD+IaXkQb9mNDJGS7WhKeW1Xn/N+mGrQwnJx6NFJFDHiJINzU08moNFcBytfdVEgBuNBrZZiy+G37YwQqsFCzhTpCkU2uKOcp60khZVEhKif6asG7aTNXiHe50LmuQAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ntInppcg; arc=fail smtp.client-ip=40.107.21.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ntInppcg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbKuLPUneg258Sh+PAwH2qXn43laE4R7S9ugfmnOlTWjGZE9uCppkv0M6MZAwktgqVeXZuarHzMO7IPFR9xSJiot4iqHYwZqy8g9dPM/e4/iv0qBDM/UfUFz7NGXsyJoeptl6fMOfzlTGsgAAPMVwFADmRB0hJHSqZxfkkIXrF76A6PmqOZ/xxULdQbFgc3ODdRnfm3Mr683zSHRGB8MX1SZdvn57qbk9Iv0JQpTd8zUG0NgAKp6P9gBfZBRrXmdJnfXm7M4MNSJQl9/+9DV+qRga8uwIi28iJE21SsWZ6Rx5zFa0xcuSs8mBBFU9MVkvsbhTk+0MmCyweFjBx9I8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEdspdPYJvRWLeKM4/BKX8hkqLqgRy0hVwf+e3YIk1g=;
 b=sCqCc9ohiBf+kGrtd9Ocpa5YdC4f3mLc1t4MWfGF+TYEdC6mUawM9LZO9gPbrCgKXaiF3xv/UbRWITqGbgnozdnPkdHSnZb2htECSMXdptdjmvZq/USJEUXU0nXe1ZbNFJ4MrHXUjgHXArholQIg0VCIOMnlK9aOmmgr85QpyfTqg2nIwCqNUSLIZCjXsAR97KsgYsqefXP56lBSPniL40GDI8wgfavRykFdebdxmZDphE8zMQ4p4moqRSTno3ewjj0k9SkgMcoe+wcJpoiybhV+HCRQ7sodOU9rtgZeHNu/P97zGpbrq74RQd6onWsLI5OmNYtTry6q/2xe5FkKGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEdspdPYJvRWLeKM4/BKX8hkqLqgRy0hVwf+e3YIk1g=;
 b=ntInppcgnXmh8h0FI7kTSc2EKsE+THYOAu0HVZLr2SVznwyw+LW9ajGqVDV43+BHKzbsCU34ieSUChQPt8nzwdvIePHi5nx/1yOvSYfkGfe60xvsY+Xi4Ic7nRDtFM9YKNB7RmmRsTPbet53uSxPE41gUDjE/zSMaFrQ/JT0Q8TpCdt1foruD82qG7GxUSOnWOwKgKgdUtERYh/VS90Qu1lVvpPaYi3V96cSXFmvS29zzNh96jsQrHkmv1pTBJorzooyuGgihbXaeJxrRtI/0PoS4R+RhPX+IzfIYq4TqezdNs6DLCjONrwnKk3PI1q54PkQvVNcFSFQlVdA40Qetw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS1PR04MB9558.eurprd04.prod.outlook.com (2603:10a6:20b:482::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Thu, 3 Oct
 2024 15:44:18 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 15:44:18 +0000
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
Subject: [PATCH v2 2/2] Bluetooth: btnxpuart: Add GPIO support to power save feature
Date: Thu,  3 Oct 2024 21:15:07 +0530
Message-Id: <20241003154507.537363-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241003154507.537363-1-neeraj.sanjaykale@nxp.com>
References: <20241003154507.537363-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0014.eurprd03.prod.outlook.com
 (2603:10a6:208:14::27) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AS1PR04MB9558:EE_
X-MS-Office365-Filtering-Correlation-Id: 8220803b-1e4d-47c1-0932-08dce3c23e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ch8hJQBmuFCPDpt3HhovCUSLJ4X9dyddIGzxmHqnU1VA3JaT+aQdcJKE/fWY?=
 =?us-ascii?Q?bcioRWIorB6qkflEdSLZRDPI4VnssVUVEwelNUj35QoSQXfsYwww/Dj0qkeN?=
 =?us-ascii?Q?kwgd52KhBbEcgl+XsJg+b2KQx6kWAjz6KfqW6oVkjIGiUMJ6O+wf1dIcsxmD?=
 =?us-ascii?Q?VzyJ0DsNSXuMKxSjviLQlVxB8423dBeUM00rcQpa5b3a3MP+2SH17Cjr5gYJ?=
 =?us-ascii?Q?VEwXf5XROwPw7rUCcVwnZsjXjzuFCu299Yi9RGDaXeh8jrNXr91iKiUOGm0x?=
 =?us-ascii?Q?wBV97GC4Dd6FJpb375w7SVvlqaLxtnkBUTL/UC3KLCVoef764M3UIHcgMurt?=
 =?us-ascii?Q?2b+HCiMBhAZaLjXbxBBMZp1ealtnZAYewbT4pmyAiS5bpv9m3dxHru57+7Df?=
 =?us-ascii?Q?2HXgIXVDIeSsqIWE727IWUp9218B/WRJIXJatju0lfdS4fSh9gVD5xsC3kZ7?=
 =?us-ascii?Q?z0rvaFw7vMO4hrKEXYmJn1Hw8EA2/oWcz/AT4TjVG1xX5NfM80qB6UOYpLar?=
 =?us-ascii?Q?ipCE6dkOcvsky6mfe24z5nd2D6yKeblkq+rUP3+27tFGXCgx8PilhuWqB9tH?=
 =?us-ascii?Q?G3wr6a/eh4Kl6Tie56hX1wT9DbHepqnPlSHV83NhY+ARHjIcddVOtxnq01ZW?=
 =?us-ascii?Q?HwH3+HJjgahTwTFIfDdHvCLNi3xPHj/DLh/jV1Et3jnChXxfyh5O8EHXDZ6f?=
 =?us-ascii?Q?i1j1LgQg60J1io+bgBX/NI9t2ycuibOlj6FLLr7OP3BoqiN31X95AQILHPAW?=
 =?us-ascii?Q?zqFGiP/0xRnaQ5Nrj4mZa29WgDMm2AOFJRewj0a8et0yEeSQ2H3keCzfjP9v?=
 =?us-ascii?Q?KS7Sp3PxzcvE03f/E1alD/djzDWrHXCR6M7tYO9Jw5bLa7xY72ijlnIWt3ok?=
 =?us-ascii?Q?j+5UFyIciJ0yC9i+qfRfYPO2+X+zvqpxql0YEs02xUIzJTjZkxOLVTxIspis?=
 =?us-ascii?Q?nhmIUAOVz1IsEXFMWgasOUKQ0EGKleAwMTui+P6HS6BdqtF4IemHyopckeYB?=
 =?us-ascii?Q?Z2mXzj99vRDtA/4j9u9ZkDJD47z4tVlRQsHz4NbrT26oEMU47dZLhw8sakBO?=
 =?us-ascii?Q?Bn7eo9juh5VaYIg8xNAh6wZ6OEyobsj0l1/Pp9UL6TXwwbnY769vjsuVLM5L?=
 =?us-ascii?Q?Jk19bb7zuYcH3DF8N4Dw2/HE5MIqIoxEFzwMH0ZUsnWlL8i8m1GVZ0NMGyYA?=
 =?us-ascii?Q?O2A8MKC7Svv56wbS004zJXqrdSOImO3KLiw9rB2CeBoQyFMYmsAXi+CSHiBJ?=
 =?us-ascii?Q?MKjVfFPtBtiOCZOY/iNQVU5KRYWE19Q5ZtHXD+tv8iTz8uH7QCumKYbUloOG?=
 =?us-ascii?Q?+bMk/vy9zXRJ+8q76Fg1Tomps/TP3K65/R4yziL5CmVQIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HPR2FhXcsWWQE+kF6s3DrNA3TXX3L5QZ0J2TzTitJuCM/BHIAaFBKu/12Tam?=
 =?us-ascii?Q?578vI1wms7IzPufPNpFSrhaxbhlu5+VouJPlIZKP59EtPpgepTeXN4GfF/AM?=
 =?us-ascii?Q?herzNRAJPsZ3sHf6yavAhfJ3tKX3Ug5pqjHDO5WbsWyB69Z682laAapbxVL5?=
 =?us-ascii?Q?DomuC9bdHn+xr8ReOQJjmK5Ma0v1NdUrsRSSxprz1r3dJKytJg8/ayJ5x5z8?=
 =?us-ascii?Q?sP5k+lfcNnBv/lPZrojyYs/rngLX8ZRFpaENNFoUEUq2FrUtdpzhpHv3v1Qt?=
 =?us-ascii?Q?ng61UllrDzfeiMHuK5o98/cwOCgIpvinp2Rugcbmdt0dbXhyFs7dysTq3ynR?=
 =?us-ascii?Q?7XMOVUorY7ToYCLIrEUPMS9fXa1Nr84A/xBrB0otz2bsOsgtJOB5bJMBXTyY?=
 =?us-ascii?Q?rE1qGzL+2BSWYZb9DYBFzjvE/cWCbFuACc1tuDIyzT8FdbW124KQME1jI3IL?=
 =?us-ascii?Q?czLTb7lOnAosMPP88GuFe7LlfscMOIDj05MktiBTMv9EPH4HxiZ1Yh1GnZr6?=
 =?us-ascii?Q?z2ST5OyL8RgjCU0MDebap/WbZpYPOgViKoSGADRpu9ZW9C2pMyJU0ZpJrYxi?=
 =?us-ascii?Q?Lh9gONU9QOhiI+MUFYqXThXx0cVoFrJtHtD6H1Ae+noSVR9lNDP3vFg4XA54?=
 =?us-ascii?Q?INDXZHCq3D4y/qbvDYhcCcq57izgGVI8+jNIVtqdKlsKv9k3bV/XKS/n6A1i?=
 =?us-ascii?Q?NaIs/jmh50aWuSPcgfEb2TDZfapORzAezAvR8rHJeNwdKhmIxWnQ6v6Gz4Ig?=
 =?us-ascii?Q?QNj9RnmvAaI19y3GCUzBSWJjU5tuPFVx5BucrKEVS8Y3X85TV++HVf/iZJwJ?=
 =?us-ascii?Q?iCHeHRd0SNi7Rz5W1flTmrMEKn8qFP4CYUvrYNn59Vgjh26dnKeZLAraN8k1?=
 =?us-ascii?Q?2qq6Aqn5q2jlPXKf361aM7U2i3fWwkW8JIT3iwQ4HJwkT9B5luUoHviyrmp1?=
 =?us-ascii?Q?D0RII+THHMZP0fXyK/Q1NAYJv6kJ9WUDmKie5Sgn0Y9f1jBekFc0Ow6VpGPa?=
 =?us-ascii?Q?L7nUqH8QGF/fbUrpDo3biN/LsClafIAOdXf3GtOfvio+SWQnHJfgQI6rQlfx?=
 =?us-ascii?Q?u68m+8eH3sNMfHCLDz0fiICMruWlBxpDmoupzKNRTr5c3flGY0yUqB3iUIfJ?=
 =?us-ascii?Q?fNycvWIp1W3MOSBLIwMq+f/9AMov5PK53dWQvEHwpqYbGsSdRdm+SlfOcVu4?=
 =?us-ascii?Q?NlXiyf2USW/g3PJYh/mv2GxpVnFkoOI92NtBLO7O38lWgylW6l740813amng?=
 =?us-ascii?Q?VsmXGEqy5CtE7ZwUEY/kWCUpzV6EFzsPHg4jXBtRO6uDdloBcT3Ryvg9Qvm0?=
 =?us-ascii?Q?xJedv9TdlNKDRtdK1VgSuaRiHSIZpV53kAnq7DvhxO2Bj/pZOnHEmfDeim0K?=
 =?us-ascii?Q?XfsKx+/EamED45YH6oQFQPopjixAmJN+Y0NXh6dpaO0KC/oY0R+NpsNLPfiW?=
 =?us-ascii?Q?sB9IGljJMbtx767NNSREP/5kWXguey/rGJcdi7rlcNniZOXGAXwFOf+yD36m?=
 =?us-ascii?Q?s2e0fOiH9416bMRmcmm17R1gRiorY3mIc66rid6/yjefx2WDvqTw41w4c/GV?=
 =?us-ascii?Q?kLbMGCclt/ICvConNSIaAIxiwhHGHfE7TRTwr5zmKJCXsn1ktcdLuBzngM/c?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8220803b-1e4d-47c1-0932-08dce3c23e16
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 15:44:18.6962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GCJnf0bGKsZbXW71mkNap/FkAbuYpVQVcUgplmGvl/DaM90bFkTyTLhsHt4v50M771F7Nbv50wZEXe30SG2n9icyq1+hCj/BvCTG+khDps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9558

This adds support for driving the chip into sleep or wakeup with a GPIO.

If the device tree property h2c-ps-gpio is defined, the driver utilizes
this GPIO for controlling the chip's power save state, else it  uses the
default UART-break method.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 36 +++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 2b8a07c745c9..327c86a0329c 100644
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
 
+	psdata->h2c_ps_gpio = devm_gpiod_get(&serdev->dev, "h2c-ps", GPIOD_OUT_LOW);
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
@@ -561,8 +579,19 @@ static void ps_init(struct hci_dev *hdev)
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
+		gpiod_set_value_cansleep(psdata->h2c_ps_gpio, 1);
+		usleep_range(5000, 10000);
+		gpiod_set_value_cansleep(psdata->h2c_ps_gpio, 0);
+		usleep_range(5000, 10000);
+		break;
 	case WAKEUP_METHOD_DTR:
 		psdata->h2c_wakeupmode = WAKEUP_METHOD_DTR;
 		serdev_device_set_tiocm(nxpdev->serdev, 0, TIOCM_DTR);
@@ -1279,6 +1308,9 @@ static int nxp_enqueue(struct hci_dev *hdev, struct sk_buff *skb)
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

