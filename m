Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011037.outbound.protection.outlook.com [52.101.65.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B71CC8AE;
	Tue,  1 Oct 2024 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727804391; cv=fail; b=HXPnWjrP5Ijv/sbCZUcPzQfSFbhVwjSB+PV01wElri0+kPd4puP7VqjHGsYnP8Nwx+4zr/93Xfe8tzue6PU83FeiSJmgnVg6v/gfXAKcOzOT/Kfpp7Y7GaWm9bT7X0CsAgHxa+FjbAu8XKGPbHt1eNe7OE82hNAyYLkh+Rt28pI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727804391; c=relaxed/simple;
	bh=FL5XW6E22qkOMTo8vI/ivCq1ZxxOjxs75S8IVl7MOsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=owICIn7PKi6F3LN+yBy4RlvtgoDKPjSsDLW29kbEb1Ukfs8wrkRGtxZqWAZF7nZhppDJJ3SpkboGC0SdGPFqpGHYH5YOevMkvERGR0kGTnCAYCOpu9HAm8w6T7NCLtWMjc5tGKJqMuQI5SFNj7BAfFgKG8T/WXwFKY1kbVd8ztE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fprpMhHD; arc=fail smtp.client-ip=52.101.65.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fprpMhHD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8pnQP0BbVv6OXoh0txtAnDWVUC4iwSJNsnlrFSi/QmaRp+fiBhAfuCGhkT7aCltS5iF9gyVzf3vUjKbr5PXIyPn8mzaUeraqb4/Y5ZeLGTzyZsacZo0t6ecqS2V6nWwSdVMBdZwYIN0f6FHVJ5Dgby9ARoc9o079E4mpzhOa9M0M6BZkrvYfQZuJcxjLqMHZkShYKFeT86hsoM2WgfB8VgOMYnBmDS9X+CHDIS5K4LyM6FQsYsUovM7+dKMTw35lK6K9723JfLdb/zM5KEiR8yRaiNRRXNumwDDAfa9+SfbAEq94N4bvekcgsMLvEfJtbllgfre4fgrFwlkjE5Fsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEdspdPYJvRWLeKM4/BKX8hkqLqgRy0hVwf+e3YIk1g=;
 b=YTGWnwRyyF8rxiwUwZxuTG4WRcW9yGgQeSYyq/z6LFD+djKJcPCCIvYiEaLfkMQTvJhtWZnbPnz0YdnMEIOvqKvCtN1U9ZK8Y5sKVpcDr9ZwS++/g0P1mtHfxI18Os2+vhKjbulRzIW+49ydsLb57LGOJyygXFPxJI1rND8iki4du3VTkVOnUetK40iSwZ6JNMxdvfDjcnfb6aahmp+8Ei///umah9AU3tkiq76oisrnCEqws44GTSO411LsbPMm7j1fT5h9Y63t/a4hRepJoQf01/ExVd5IEx2a+3lEXsQOlC0uhNlhgBA2xq91JwW68v92jV5gWkmn9zADM8tkDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEdspdPYJvRWLeKM4/BKX8hkqLqgRy0hVwf+e3YIk1g=;
 b=fprpMhHDVRMAHxmrRijNEqFMO4l/kKGEd6IV7Sb1K/su6uJ2SBaXVTXqCJYnHnnq2UHLbJFe6GauvuJw65c0HO2cVYed96tBSF0ytld15Eg2AO9NqM/gUSljSvPPNGOHhSKnKQOC5oR4218kl7LOGNG4XU66HiMr0YYIAGDOGSMxlwAjbcnhPS1gujINeWwACB4Dfb6dimaTvrdKda47XLphawB/ZrxOD3SjVMl9OQnKIc/QCkhcSWR9u5oGwKu1DRj8xjadko7h00civeK5n3d/cZPMAb0NmM6sUmM4nsRxZm8/3AZ1/xS9pBF11RNs7QDIuDK+rZ/+09GaL2z76A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PR3PR04MB7260.eurprd04.prod.outlook.com (2603:10a6:102:8c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Tue, 1 Oct
 2024 17:39:45 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 17:39:45 +0000
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
Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Add GPIO support to power save feature
Date: Tue,  1 Oct 2024 23:10:21 +0530
Message-Id: <20241001174021.522254-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241001174021.522254-1-neeraj.sanjaykale@nxp.com>
References: <20241001174021.522254-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0130.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::27) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PR3PR04MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 515864a5-130e-4e65-2aca-08dce24009e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dYyO1YO6BR6QvM8CSBy2+jJ4IaAo8/DtHqIbeN32lhHSPh1P0Rt/ktWB4+t0?=
 =?us-ascii?Q?cVhNMefKa/B0rXShHN/nqCn1mwEi6kXoNSrBxauBvCL84j5LkrGIy/ksa1vm?=
 =?us-ascii?Q?Frnyaycpky9+xAoTNybkLLoZfVLdFUPxaJTLIk2YssFZn7BPsXGZ5FQJGsz1?=
 =?us-ascii?Q?3oi8KznpUiAnFdgWbBhKyPi7HxrFl8LcB0l8xgUKLgP5nuB+b7ttyiPeAl1P?=
 =?us-ascii?Q?EhBvLac73o5Q4ORVzXVJ3haJlqlpBlu0N8FzSc1/cNtjDS9pbdVtzby/TfY+?=
 =?us-ascii?Q?NkpbP5LlAhAvfS3m6ofKg/SO2HZJrx4KgU7mn5HRV1rE15NywcbGIkihrqC9?=
 =?us-ascii?Q?o1O+84x+jGmrjZgGFc8AcUSNvHtFFCPdNsO0W32MRfq4yK6Vf04ZCsoor1WS?=
 =?us-ascii?Q?XmD7JdYKySPEJbn1gOpX/7De+CxVcbmaSYMW/JyryVJ9vhQSq5NkMFu1E/E8?=
 =?us-ascii?Q?6bdqJpNE9tk+bRp0WwB33fTyI3nrzwSw95CtjmJ1/6DFuZ1eqT8b1cfrSm9e?=
 =?us-ascii?Q?AERSrBjYJE8Q6XKqhIy/v6xq+5guEj6vJ8oci6505JhWLJt0Kr1Ox5kGY8ye?=
 =?us-ascii?Q?iRajoh35VfKtwcWuon8IIc0K7TK2Hk0JC9xqNoHldaBWrQNBQzLmlaAERzFm?=
 =?us-ascii?Q?zf7vleS2VKQtsumdqZxr6sOolG3jj1qkJ8o0fKN1Hvp13VIhtr0jI388NQ2E?=
 =?us-ascii?Q?sKHEHoitMtt+ZjogGJG9jAC5y6vj4OGDLcnEjFJntQzE/s+TH4+i9qFnszLI?=
 =?us-ascii?Q?GT5jvjGhS4FsokqnwZmqNdjbGL47c4WD3l8wSVaDa0pJCa3uMeilVL7JHTpZ?=
 =?us-ascii?Q?Ig0myHa2XGmCgESuJjUeg9hC3Ex/qr0T81da2rmTe/glzU/Pk9IacUyRcM2a?=
 =?us-ascii?Q?PqS0/lU6Q8JtYD3hgKhB9XByz+JlfqPUemO1R0ccu1/zBLeDBpJ9VU1DQqfB?=
 =?us-ascii?Q?4XHtRPF3d6PY3QLPqzhsj4pXqRKfPktSqb6ADucT4lFZlT9O35dK4+ehBSiG?=
 =?us-ascii?Q?9E2jMG3yDFJZZ7DXnmh2Zr0yUkZJWPPUX/ed1c9LsGaeIEt3lHXoSYnOYt7b?=
 =?us-ascii?Q?AOKnNBade7gHPeskts4q2e3/zcM7HngZ2thRYKrxRzcZ568e4cs840VaTp3Z?=
 =?us-ascii?Q?6zbgimzDG3tHSM4fj8JzTzb0f1e8Q6zRFAO+HpBLDn1aqgzKIG4Mciq0/xiK?=
 =?us-ascii?Q?1UQz4wHyIX8UTFll9zcgLJDv354bqenDD50KALR91zUpVLn7MVLPgMnmWFyw?=
 =?us-ascii?Q?E2oIMn9G9pJ2JK2P10SVYWbokGIR5lsmevaQEJwVT0wN/qZnXivmlqOjwMDM?=
 =?us-ascii?Q?Ds8piE3SrkjQoG3x43K+f0AXxWz9FObitfUTVUoeh/qZmQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N1Umodkp23grQlfRNn+gZsOrQg5+9pKZupHUJ96P46SUREvC96l5sIHBwPvG?=
 =?us-ascii?Q?YlZ/uRdWn6S5aS64fJmKVD4BGCLyV/NnaMY/O7m5U0HtbkpG/ir/0ffu665w?=
 =?us-ascii?Q?mLJTDtGe4hiuDiLoW0eK757FNjcaJ35vVDhV71gXnBcumLxTYalzRERe4jvQ?=
 =?us-ascii?Q?+0H+du8TZdGMTMvuJVn3W/ygvODFS2IV6WKDEUtZPdHFbU1Smla/zAms0jDS?=
 =?us-ascii?Q?NBbPI1TCS/cjRizoCWKaz51Q2NHny9pWR/Xedr9U8kJEBJ+cauQEP5sf/b5r?=
 =?us-ascii?Q?y62rfoa47ZZNzQFC2XqDygJv+8ctMog2d1K4rtavNl92iZBbRCtd95iH4lIB?=
 =?us-ascii?Q?Jck1pE6YYnMEJFP/0nChfBcCcQYIkz4sriIgK9gm4LbDbrz14HXXoHRuLT9m?=
 =?us-ascii?Q?ejz8olK/FGaxHrCtu/bviLxEKL4fC5ThQTdaFmk2EavDwjAw+PdBN8jm2bUd?=
 =?us-ascii?Q?hE+FEx/Y06JBDKmTAqYf92GKWNvSVvHIBEw/C/o87HqNi9AS8nORx44eAJ6F?=
 =?us-ascii?Q?zaJQj2DdTEDfzQQc3ummj8S6HJ9HjITf/VcXX17lTd/Jd26wnWCstHpXXAHJ?=
 =?us-ascii?Q?bsp1JyQ5CcFXHbiGD/p6GWrN4seFjX9FOX0n668S+9lh/iZEodCC0WehVKMX?=
 =?us-ascii?Q?ptPwBi6j5BjCgaS5M3kMjYPnatqEPg0+nT6XzCMfnohgmMxw7yMLquCl3ByJ?=
 =?us-ascii?Q?M4CbRJth5+YKfKnXRrK3ZJueoq1MRHc1ZYkgaGhDadMfT0ebCsp7fWlPnqYA?=
 =?us-ascii?Q?fbHAjllwkPvKGxR9Peg93HYmRbeDSXXznPSjN8P+9pkWb2SxyVpps4/OhYOM?=
 =?us-ascii?Q?f/cd3IRJHrslc7tkAgd0Mp7KJteHkZSzjNG+bByFEorRQtDOP5GlbC92hBDU?=
 =?us-ascii?Q?o47gJOMQoejXoaelN5KsCkxKErXr302yc++3HIvfiT22Xd6LBdRQTVldOrfn?=
 =?us-ascii?Q?OCy9uFo4G2z9f3qcKhSHWGCfb4NduSQKy5Y2A1dYal2O021SJTZY1KSVrlAB?=
 =?us-ascii?Q?2pqM71Bid0murxflj3GhneKVk9fYtYD+yljHFqMYMyx/dB7MHyrHXWAvgRLu?=
 =?us-ascii?Q?4QteLm8N1TI0NzCZ2xNE3qgWzk95p3WEK2q15SR09oQC+m2MoTezn4ow1mFX?=
 =?us-ascii?Q?Kx6Hes7InPptI7TcIMmhhZB+MRTDCxVpJY63KIE8zisTxHbAcxTyZsKyz9fl?=
 =?us-ascii?Q?S8bctxSbMabX9f+U/Rk4p2JE4FCBnCW0eRKEt0jCAoEaUCd8gNqrRUUbvF5p?=
 =?us-ascii?Q?gGfTeQlXGhHmrxpNbx/8DbtF1+08L59AL8nXMj/ua+i3yawa/Wmv1coQ7U/V?=
 =?us-ascii?Q?HL29151bJJZib5dtQFkvaTYUIDHUskL04jFWuxu4vzAMzWMKju7hbg8zP2WO?=
 =?us-ascii?Q?3aBK6MlQBkKE4oQFWcf7nQXt3/5k7pIeqeIrKiLVj/ECHtatxdGHu5n9PDIO?=
 =?us-ascii?Q?kPDm3p7xsYb8WpEOGvK5+imkamYuKt3UNf2lnaJzlT0xF7vfR/UYhUawLKZ6?=
 =?us-ascii?Q?fK//dOP1jEmU+S0aHvEhZgZn+P8e1wjVTjjGjmFx3ScLGJYq9+jRUoG/BKbM?=
 =?us-ascii?Q?AhUA60oc+CXQfln54tfT3J32NNBLNc5j1U1QHbuRDjSPE1sc55XZB51oH/iL?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515864a5-130e-4e65-2aca-08dce24009e6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:39:45.5479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4EF4ODYfK5pJ6LwzZqEtD3NplIfLKtgZK+amb4yQ0mUtSnwb5EEfUkZIFUJ0vE2ciQe3eMbn7t2sKaxpq2UlG1ICbz1VGUQtMZA3HuI60hE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7260

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

