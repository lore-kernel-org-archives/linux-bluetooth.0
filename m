Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011054.outbound.protection.outlook.com [52.101.65.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A7C17C7C9;
	Tue,  8 Oct 2024 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378662; cv=fail; b=YHlsiGSf+SY66IH9ny86w63Lx5PBrvUJ+s7aXtJxPOqkh1LnVqXZNSMZq7smZF/MQaUa/4xgFTqaksmM2VIL/PZFDxg4npScSSpQhV4+7uK0VuSmFlHm/MP7zBkw25w56a2+yA9KUYOuVtlgmIVEiMfRNlDXRHhk+28dfOHig3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378662; c=relaxed/simple;
	bh=/c054IFxTP46+nz34Ct7/umyZ/AkGMOVKHhmNfoEbXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VBXywWSr7ojerlgykaL2rsbw42oMGBv7q5pu7z9XRbjA5HL7un0Q6s/AnjlWSiavIQiiKEVfUBolee5Vf+nHHAjB6AvIVSqJq6C/V2p55EdqkKgLT7BhpRtZdVrF6spvVTFKa6TbdoS9ad3ySj2trj2Of54OQ1prgWH1f5XoDao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JGvOqWs5; arc=fail smtp.client-ip=52.101.65.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JGvOqWs5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wco5OHuxQDREOb/A4JNhcCVHSjN/nwr7qkQHP2Vkb7m8O7orwcwGdERWuWs5UPVfkmgh8ZJvI4wcD/p1/yV9L/3S5Zu4MW1UAQuaPrwCaIj6V3TaPjh6cHP2l8gzq0DSWWmdC8j75PJc+uQgqerF43PZoCXHqknfuBHPU8V3kWBRs7cf3oEglGEVzK5fqUdzA/a/gkh6EdjWnPTS694cQ1EOq+lF/cejmw//R8Yow3QLzrSmje6+CNJh7wSMiSg4kU8LuVQWJeJ9ET5SVqECvPycFzCfgkbF+4TVM3EDZwm9D8DiJ9JLu2tyFEybob80EQ9gByjv6WHtgqkhwrM5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQbhR5yGG+mtWg5Yo3cCpXA8AQT9HOh0GceAekqococ=;
 b=pOYLk92Dsk5h8nW0Bq9VQmes+rPgPV3906qU56ZnFEsCAWcqxr13yx4LwxTkulX2qWgEk7LvDICMJtIZSKYonZpm6qj2ZisQ8fsfO+vhsa216bv8w8npHa7biIGqdQAQylTUhOw3hdnpsYLz9IbAOW3uUqzRBjlvvZE1rYAvTyPXv07ngRYEisAL2qXmhMNjUcLa12oA5tvjL9iKuHJMlEBnxpwwgSJlntjH9S3+c1D0eeBr743g2wHJQ1sMVOCJ/mQN1VDSd8NYfvd0HXYKsZyz0HNTUY8jcQhSTvw1Lki6GpJJZtgdh9HccurWwpPCIowA7S8qbHx9ggHv+xI4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQbhR5yGG+mtWg5Yo3cCpXA8AQT9HOh0GceAekqococ=;
 b=JGvOqWs5VMO3Ib7nOoYWsGpLjwa69ZfhDMn5MFvDzVU9+ZQ/emEYqiunaVTq2Ky0cUcwYVd644LJxgZSTP9LhDHlyW71TqF5IW0kcb/xsxySRsP8EqfOOcSZNs98uxliXdLa0juvRh7pK8ElX5+ufNgAF9J1yWAOHN1D1SSZma6j5Qxwnwz/HSI8CHw3W7f6hvLawNusx+9qLd1dkgOp7S+ycZhD8HoXRJX27CqsJ0E589GR0cu/CR7SdTteuq6BiEEpa4a1fcrGaV8ypi7a62RtkUpK33QZLs15YQKHBLYUBFzHNBYIZNitkmwEOoBh/9KsEe6X5kI4b9hCFg1SrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS8PR04MB7544.eurprd04.prod.outlook.com (2603:10a6:20b:23f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 8 Oct
 2024 09:10:56 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 09:10:56 +0000
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
Subject: [PATCH v5 2/2] Bluetooth: btnxpuart: Add GPIO support to power save feature
Date: Tue,  8 Oct 2024 14:41:59 +0530
Message-Id: <20241008091159.650531-3-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241008091159.650531-1-neeraj.sanjaykale@nxp.com>
References: <20241008091159.650531-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0047.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:656::11) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AS8PR04MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: 25538413-2911-4389-7c54-08dce7791e51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EcVKS2D9boQJqaJdO2XVkHjG+ZJoKYhZnxIjDAihfOueA9nQFYmi51fkLQ7P?=
 =?us-ascii?Q?DxUtTDFEdE7k5XbeWcbnacBYV22lsvmVgr+/SsfHwsY7yhHJm107ZVS2vwGQ?=
 =?us-ascii?Q?9Wnv+fjFWOM7muQiLA3aMOt+Nd2ga9WOM6B42JCo7bcw78k/PidHrnJ0Dfmx?=
 =?us-ascii?Q?j+wPLrTMCknA+b53lZV41yAiwuSltLXHsx9MP6YNgwYH5h+f/+KHfYbgzwJr?=
 =?us-ascii?Q?3g8iMedb0z0r0IezaazHUT2SS2/MAGZl/Fy4qvenqtzJSnWqCDaAyrCRQtn5?=
 =?us-ascii?Q?Tkt7bcZEJ63YZmUx8YQnL3WYJbg0PA5JnRPjpuLzOsHjFxBQziy47d9FpJ6M?=
 =?us-ascii?Q?0R6iOT6T4X994ocamZlCoLMO0MRGizQXDIE8LZfqb5+LQ+0NAolNC0LTorFY?=
 =?us-ascii?Q?RcZhuG9enZleoYXa6e/POSpAyzc0zD1WmxpeQW+FUt9gkb+20xPFk4dAkH5W?=
 =?us-ascii?Q?uBygeg+ZQ64WiOYrOonZug5rMZLNI0L6t7KOUlifrYW8jCywQpZPBoDTYnqR?=
 =?us-ascii?Q?ISTsjFOTnHrrVuHO/oZJy2zFtGyBM1UI0DNkeEjys8lCwaCv59H7DsnB+N15?=
 =?us-ascii?Q?ozWSQEZdP4l8/gCtrx8DohCUL91bVdjvBC+ENi4C7SV7LcU2zgrXKkQ4I/Ew?=
 =?us-ascii?Q?NH1CVYKZuc0myGHlQICn1QxZw1/WnJ9ZIH5LCF54ZJxRBsgVHyr6mjmCP4pG?=
 =?us-ascii?Q?XxPMervztaLM61WSQWpgzQA7CkbAoO0FD1mCIwuvRMEXD9lKCaA0cW8R+ree?=
 =?us-ascii?Q?SyNIU3nmz5FKmrxrxJGydg4PfoXqE2yJp0ljRsQsfCLUrtH7QsI92i+q4Een?=
 =?us-ascii?Q?5cbDz3mc6vtVGRBIUBTUC8lLg4D4aflvVMwB82m9qu7w6SQeHJ4e6DO3zFU+?=
 =?us-ascii?Q?SDrBlZXrPNUKMdoSZueR8Fur5zf/14JRrjRfkh1F5R8z4fwGOo+8fnmENHO4?=
 =?us-ascii?Q?Upo57kjtjGTqFvcFlz74UUHfQLw/aObQJ9ZI7NO70LMg4P1+lXOShO9Ad1np?=
 =?us-ascii?Q?p/RhkIE76GDJbnWNZaFVu/Mcxa/PpfwTEMt08P4xhwvcprD9S8oz2j02jogM?=
 =?us-ascii?Q?PA308aHzMK6tzn2X4HgLl4D3/OgO2UCJ4OiN0+9Yg2ti4646Em6/aA7ryBfQ?=
 =?us-ascii?Q?bp5Qwcx1FXYHoGoxn5zkB010x4ROdg8Nhvnd4VW+D32hUVMoD6bVZQcIewgg?=
 =?us-ascii?Q?UACITCyuAjR/QKHV9ZO3vAlK8D5VHqGnIQf/ixbmrG7S1wDLhw9bQC1ZsyJD?=
 =?us-ascii?Q?2RpDsHKeGNgWcsYGBjRDER7wPMv0yig1wsP81IgLtKctqKh3lbcIfV81ukqr?=
 =?us-ascii?Q?sdT/i1HJ+pHz7G910ggyQWp83moYjt5/TFJjMQkEcYI9tw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V+lUDrlz57FTxDBS4wzmZWgu2KRgC/cLGfxQqa7McKy8EdDKlOmi60jxVul8?=
 =?us-ascii?Q?nSu71rdg6JBSSaGowH4CoFgYEpwdon9BP1jCAYM8Qu2WhYtQ1cSXeLoAcSH5?=
 =?us-ascii?Q?Bhtk0NT7glDH/W0UGhsfYZqtgCrEcByHsQcP/08seKhpiaKamCCS6kSnWx7w?=
 =?us-ascii?Q?O2FbSTrSCNvax9FkLoSYxbfzDPizR4eiAn1dsJV3zIprHbmsNYrOD5DCRJUc?=
 =?us-ascii?Q?AEumcIF8wnHG6Qc1W1Dpp7EjGPBfzPpS0MJ6xMZo3zKgAwUxKM8PPrW8tVxK?=
 =?us-ascii?Q?Ye/F0rF2zARjDriyrx0qK7bcBpOCBoaNQ5jRs8P3pKbRPA+6NXh9f/2DOZ4Z?=
 =?us-ascii?Q?iGVqlZh8G8BN26c67X/h6PpSzfrDMq3w8EChAq85dKmBr9Bb1ao4nnp9afC9?=
 =?us-ascii?Q?OXAhxpZnSdryyRiR+uk1lshx8EslFYfJGY5pIzzSGKTVHSMd1m6Tdy3HSM1U?=
 =?us-ascii?Q?02deKBStevUZmKQ+aszDM2S37rnRkdfba0d/omKZMOnTg81yIo6Q5Nbtzr4p?=
 =?us-ascii?Q?8FLqYDvnnwjQ9outWSmMLYEM4XiDCJGYc3A5cV9JpaivHtRdQe1AmBVh1iyG?=
 =?us-ascii?Q?MFlvd8om1XPn3O1ysMsjwT59qk19gaoH1efoyC7a3HEcdxg0tnV14xV/EPb+?=
 =?us-ascii?Q?81T9pnEdzeNxrUntW3LbPtTiJQIuiq2/2yIYhsANL4DpJU285B53D/S82t/G?=
 =?us-ascii?Q?FjLXRxGfOdKEQujBn/p1AWqplUoAR3G3bMJ2BZJwTeZucAQNwEY/+1m2/E/m?=
 =?us-ascii?Q?QaKr3ymym1OHTzBZoTg5LQumhGU/9RRwO/pY5nJjtyRgsxrmwDMcHJ7HAbkl?=
 =?us-ascii?Q?n6Kpa2q+xFB+iGCKIgvgmOgol+x2JKCA/W6+6KN/syonwLSSb+CZkyNekELa?=
 =?us-ascii?Q?JwhnTsBOTkd9EL5OWRttLFY8E+cmmM0ebcm6Ws2YGgSMR2KWo3VMMQEwg42J?=
 =?us-ascii?Q?m/UmGuILM/FSyPMyRWBggmFibqwqPA2zAEuZzhq535dR4ilB8kOkqv1chXEE?=
 =?us-ascii?Q?W8TYNbNotsnkVw/bK4d3PFkjJWzlbVkEryitOWKhTrPLz/lTTdyC67VB/7+a?=
 =?us-ascii?Q?/9N8WsYxSvIAbSVzQq58PTwfJjRvXp+pjcPeQWA/r9+7jNPwDtWRL+wW8vuk?=
 =?us-ascii?Q?FVQ8r8XzXkfIkaSouJ8w1Dx16DMVvj9GjshWto0iLI1lGdkAe1/X2x8mOZZG?=
 =?us-ascii?Q?1kF7OFCZXC5PPztzZzWHLyq8x07icWcz0EvEKPx6zBNRrvZ5ODj8Pt2KLVoX?=
 =?us-ascii?Q?JqNKWA406zaGLuS8CdJC8/JoEJcBi07SWjeE3N9ePn5UccbuyU4Oxbszozu6?=
 =?us-ascii?Q?1ZIR8MwyQOrpKKB/EuHSwuJZPsC8gf8xW9Hdlz9EriFpTq8edUM/yz/yNXqY?=
 =?us-ascii?Q?fpfkP1okmarKEJB9eMk2RHQ8SZYqJs7i8OlSlrprRDXItxHIAwpGLVEgIOf0?=
 =?us-ascii?Q?zFmHNPhNVoy5P9luEYLfkxuQaFhWf/i3O9gGhM4IoB99/WMJ8TOWkrNKEMY4?=
 =?us-ascii?Q?oM6VcEuxbGI/epOLfZeKwEL/bqWPRdU7gj6wtoAabmhO1bhoLhnKcBBqkFc1?=
 =?us-ascii?Q?T/TfGmEMiKua/Jo9VqjdKEpce/5dJF1qOSo4AA05FUV7KyCtymCn1skrUyT4?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25538413-2911-4389-7c54-08dce7791e51
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 09:10:56.8224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Igvsrv+GY9GeWmV68swORV8TPyQc7rW/FFcg7ngrUWJYofgty+Jk46a1uhEkzQFO0KEvH7mtyIUhBkmu0QqgrnyxSxe6obcAatWj6Uc7CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7544

This adds support for driving the chip into sleep or wakeup with a GPIO.

If the device tree property device-wakeup-gpios is defined, the driver
utilizes this GPIO for controlling the chip's power save state, else it
uses the default UART-break method.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v3: Remove GPIO toggling in ps_init(). (Shenwei Wang)
v4: Use devm_gpiod_get_optional() instead of devm_gpiod_get()
v5: Fix compile error due to copy-paste. (kernel test robot
<lkp@intel.com>)
---
 drivers/bluetooth/btnxpuart.c | 57 +++++++++++++++++++++++++++++++----
 1 file changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 2b8a07c745c9..ff4acc7347a2 100644
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
+		bt_dev_err(hdev, "Error fetching device-wakeup-gpios: %ld",
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

