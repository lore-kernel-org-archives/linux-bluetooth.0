Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D3D1EFFA8;
	Thu, 27 Feb 2025 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680678; cv=fail; b=E3/t/870WTD/XuoYIoBBozBbtgDy1L6JYNabnW15VDUj+4joCuZXztibrM2MJpsF6GLab87AsafTTDaLJMkj8FKXQ/F3LsQA4/0nXBX1bHOgNusp5+a9CC9EqyvfhqR1kT0yoD4s1erQbgoBzSXWC162odtJi5m4YF61MjwC+ko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680678; c=relaxed/simple;
	bh=G7FvNXQ4J1qkYtEtzISNu/oBugPb7psCmEicmB+TI6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D2nYnNUHbAsoaj5jT4nP7hcYM+TsYP0PPJcy/mfoj379oJVE/SWbIV0SmRSmg+WwLUq+niOHIHItUK/YcFJuf0AnpdckAE9ZoWddjDuf02qGa1jqmdj4T9d7Qz93ha3/yY4mdIT+9g6WdRnYUdZDF2/l/akMMs2KpDYuejPwWfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KqcTOZ9R; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KqcTOZ9R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfzSJCWR9kdIFmdXXhpXHApb1Qv0tPUNdOFZBm3Hy0i7wbck3YzBHfCbybccpIhCgZtF3UyYAIkem9B0k/zHPskTOjuyiWYET1oFFxm00h+V/6e0RAKc6VjYohV/oDodP+PKkDu6+GA77MNLRzwYk67tyhZk+lsBjqa5LEERkyV1g9Id/zwJYEEPs37S92LKwLDxN08y9yjq1TrFrpm3l9sC9OkDSUfThA8E82hW23LgpkDThVarKdbYvE+U55mfVxc9TzxsPKUYZwS5vwoS5gA4HiWgmeHwjdgpVC3N81yikA3w+v7EaeH34kOfpKoEub0G5F0t7MVw117ZePaOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9R6sXji0YFmUuIAlidjt3ghE3jJVX1irBk9zcsB3hu0=;
 b=oAPIEta8AriLKrOk8LXkuicIfOnvIrIPMqRcz0522QlUqlOrhCNcW2BmgA2FHaHB4G9RKYXAr8iq8y5tOVWTwe7OVEREb4u9QCCjTq6c/LGQ3Yn8aBIxroMacnd1eo0wgyjhZ2AiOI0jr5dQT85Q4YcTmATji4uofQJ4l0S0c+uYvfjl1NSZJGbj6BiusvKqqsz9WSDVvB39/HMkY8vL1gYLfrlEG2JD3pkGM+mr+bfBtXUeAO8ViUQ+zjN1P1/wHF/kM2Cnvr+wYzwtL+6HBuR5N1daUzx7tCE4XIihe9E5sQ4hiDo/iuzvjShpgzc6EOMBWZF7qrnkwLkOiNmYlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9R6sXji0YFmUuIAlidjt3ghE3jJVX1irBk9zcsB3hu0=;
 b=KqcTOZ9Rg/GIr1RYegxc8BGEsXQkQ2gdo7OnnOinBTmsQEMuxpAVjZ3HZepOAyvmP/EVcbBGS/NjabZVRc4DxLS8Pvy9S57p2Zz3F5H46PNxuT3LBtNmXoxBTWYjapd/rhTn8baEOQYIPvry/ScaY6jtH3J9UX0nhMYgpYrYOXoKRyoKASBGhU4sx4hz2rNCxfDPquKrqedA0+ztK2mwe5EeMRad/Z/CIe8oyO5Oz4wBToF9ZKxalQ/9sUK/+QWIScdKrpU4QAgT7ULd2sGVgNOV7x2dTgQAy0W0YrIv7lM7m3NvQ2sZqBhOb0TbfkmGUbxCVRCAgaETpaejGnR32Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS5PR04MB10044.eurprd04.prod.outlook.com (2603:10a6:20b:682::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 18:24:32 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:24:32 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	loic.poulain@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	manjeet.gupta@nxp.com
Subject: [PATCH v1 2/2] Bluetooth: btnxpuart: Add support for HCI coredump feature
Date: Thu, 27 Feb 2025 23:56:20 +0530
Message-Id: <20250227182620.740323-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250227182620.740323-1-neeraj.sanjaykale@nxp.com>
References: <20250227182620.740323-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0003.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::8) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|AS5PR04MB10044:EE_
X-MS-Office365-Filtering-Correlation-Id: d7af46b8-f4bc-42a7-3f9b-08dd575bfb3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jAAZBVwwHhUAjUoaxQCqheoIjcGyjUciNleJwGVpSOFDbIisidXUI8UpDXwS?=
 =?us-ascii?Q?YmT7HE9Y3IKoxYaARqGSi4gYp0GkqNvXYyyhw6afq9UilDyLGGlW4rH2SpGe?=
 =?us-ascii?Q?5t5EOQo5TBvC0+qKCeQoi5R4XwA+Je1O2KdBgZ+WHFx8YUtOq608KvzzeRY2?=
 =?us-ascii?Q?PYvSnC0BJhRwwSdJ9XeuqRKrmhG6gcEHdJm0uan04VqqsebPy8/7lQ7zv0ym?=
 =?us-ascii?Q?JJ/jAt9QShfw4Nfd0FrOrKbDjZWHvLnvVNuB5OVc0YLF4cRx6xJ2pyPkYTVz?=
 =?us-ascii?Q?9oGM49v26eYhodFSzGuTApJ2hE5xaOjEfgeaIMM0tndd/CighW7rIgaSx6YP?=
 =?us-ascii?Q?AmmyF9cG2y3wVaEicymGjzpZpF0kxqGxOJ4Ffmm7Y4R6mAjkrHwuD/KFPdEN?=
 =?us-ascii?Q?6jRrXPSsUFsBcaVXD7yrhfwRxkryiDN26w6ENkeEMbOmXonZagbddsvBtoKD?=
 =?us-ascii?Q?jJJDBJTCVRk7pz37SpizvA/yrCOljr70mU05sPM9MbavNVuR9XCTfeMR0v6Q?=
 =?us-ascii?Q?v/n4u3qspQyvFNb1WGCINx/af9YeJyNLxrY3/qzZx+QP8YSuX2b9iABmsom0?=
 =?us-ascii?Q?k1zetv9T5hQDKCkqcQnBY7vkstnNKthilXJEKxmTvKW76s6D+DrHjQwo7iu3?=
 =?us-ascii?Q?pjQQxGKp9GFhmMyeY3S+aLIR+Kk5iI89cAQ3+Kd2G9NZ/z6CVrtiAmLMRQFN?=
 =?us-ascii?Q?vUkpUjage9NMr6dLMwE6nQ/udwr1yHB0F3uuNtVIH79yQaxvuF+wnjxs9GPB?=
 =?us-ascii?Q?jXPB2/qooZgSl7hImDImlGoRo2pPyV7lXcs/yhSb2aNvAzgMYGCff5wCB/v3?=
 =?us-ascii?Q?M1JFKqrpxB/t1xVNp5b+mtSyiW3aIlRjHU/xNjHA1C4+YF5bBHlEGntWCbVx?=
 =?us-ascii?Q?ZN/s/h7rwPeXf+WXaCScpnxMq/P4qF8AYtSM8zrHIfqVnQV+JKsA2nKhXIfP?=
 =?us-ascii?Q?rHkBWFsdo8lUHWfjR5mRVYzNZDCjeYqiAfxkMwnN0T1X0JUFjhDgk7ApbENO?=
 =?us-ascii?Q?dxAGk+9lQhjXt8I/tx6CxleSYHpQIhVRY7jm7A07+NHoCxpGdFuxbKX7aY6O?=
 =?us-ascii?Q?A0hs5fAwpSJTFqeSi/BofxrAPyUc0OYGohb+1WQdYUa1Y27nJqqEg0E9s3gq?=
 =?us-ascii?Q?/GOJFaDhfALD89GsY7Vr9nSukEjQm3udo0A7yGKx6Q80gJ6RIRrXZg1O4JQF?=
 =?us-ascii?Q?tMQGaTgHxgFzmPG8QGZ8eY4DyGt9mKKPqJwDrmeABSiuB2wyYI4CJlzLv+Gy?=
 =?us-ascii?Q?OPQIzxmhfYuuuaXE0BK31PpHq+RjDU4vhwA7rSwEwDIYJZInsVHY89Q3syc2?=
 =?us-ascii?Q?OUKTvTAGSVR/F/613a4NHVxrGLRsHoElxwkorRfVPJBig7vDDk1niBdksPAx?=
 =?us-ascii?Q?eg8S+39qZ6YX3pHG1oXGdIQbHukyDwhfkxai8nns01rUb2bEx1tkTMkVcaiF?=
 =?us-ascii?Q?D8knQ572hP6W08wEc51cr/i9OvODHCOQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FkkYyPIQAQtSWTyyljbifb8+2cxXyYTCcHldSL1gg3x6QSMp5Lch845m48sy?=
 =?us-ascii?Q?xPMnDBHg6taPbmzKO1nN2EOnkmIrvKGQ2nkgKT63EsWyD2FWj7i1zyCfDGah?=
 =?us-ascii?Q?Pkw1HaKScVissjTyWCALKkS/z9oFHUx1fqsO+fVjHdFPvU2w/8uSplRqvqqm?=
 =?us-ascii?Q?R0SQURWc4B4Q5b45JxTCx38KXzs8ma2RUFj8tzuVv5B8jn2KaBpI/wUkeaRH?=
 =?us-ascii?Q?UYD772JpC2Yx3jkc2EPNSqMF/WOFJCWpG3v0CLu7jEVOJAZBKDROuoBeUROk?=
 =?us-ascii?Q?ZY0FZe3u0XPj7ud9UI723Box8yPaKi4c49FrKfgHnpr5/fKE7ROC1CAwaFah?=
 =?us-ascii?Q?gTicubdHHZgn20w8fQvJnAnVShgbuo/kGuqJL1C/LjRVUfUZUU5S8wbdg1GM?=
 =?us-ascii?Q?/gyzeiUFNJxRQmPpVYw7Knz5jVTMpKteKWxX3EpatiKyLybKgrpFEgTB3749?=
 =?us-ascii?Q?I5xLXkIeU2xz6Xa0MLiL0OyX/RNSSkpARfs6eYw1VBbidClFUhVmPsP9wZMN?=
 =?us-ascii?Q?Cv1E0ZQbeOstSob8CNpAif4BORpFDGrl1JMi6Fi2saP8ij8wFK15s7+X1eJo?=
 =?us-ascii?Q?8044TVHZI22EBB94Yyjin+HbAZ/zuCzT/W1RLqjiJUjNdBJ4/o1ZEMdRFRJI?=
 =?us-ascii?Q?pD3gIgd7DSKbxnR4fybgyzoLDLrZ9Ys05pVsfSQppV7SbYmf8ObzbNqhCJDY?=
 =?us-ascii?Q?TTHGMS0pXayWqvKy/c/Z1itEggqwnn7iGSxzdl/c8wFw7W09OBkYTMc70xDB?=
 =?us-ascii?Q?/F+td6S5GToBOFSYsLNQG28a2Wq8yNItQW6pgrcW+ux2eWcYbcOz0DMXRvWO?=
 =?us-ascii?Q?AJI8Tysnhk3duLekRenT5VD+Cnim+FwThnRjx+qGf3APmvBscMMLVXDoJN2F?=
 =?us-ascii?Q?cZRnZch3tjMJNvkjqIIBlN2Nl9N5R/EDMS+My/IG8MEVpCrcRkW2r85Ouy3u?=
 =?us-ascii?Q?F07gJMyzS9Sz4zIDS0CFP7cfUHdXIp2yBYY/pW6l0fAUn7izaHmpxiKdkdBz?=
 =?us-ascii?Q?4AO7xEmauvFxTgO+R2IBim1uBEYbErQObIAVdR/yo2lCcK0vGYMfDt+SwAem?=
 =?us-ascii?Q?o2kssUfNXB+lb8yJJAJUY9k512jHXk9vi51YXA/KKsEAvqPRYo3dkj6Rd7Fu?=
 =?us-ascii?Q?zOqxTwmIivushor/o0JdarnMtLoQTSnOrhnLWKsT4gWPaHN0q3qP+zeMlWDM?=
 =?us-ascii?Q?4VLPJzPzczig8m02NJrXbzl8WcyUrVENQWHzlsEBzFkeVM0werVtbW/Yf5Lv?=
 =?us-ascii?Q?L/uUm2KeEeGF2QULtgHNJqKlt3y818rrr9Fs+uFBcPeuBK/yulZCjr4Mssg4?=
 =?us-ascii?Q?Gm7/vIQTphgkUC9P9iPGCzUXOG8hOCT8sG8W2suf23qK7OXTpaspbPQTQiEp?=
 =?us-ascii?Q?ck+91tTlypJ1UVs8WZvoWr3PUIXvP0UxHHW0w9/7nhcZq+u+bIpS+8rifEzN?=
 =?us-ascii?Q?D+fMP9Io7CMwyYYGaAEEEh+pvhQoNWvQqb7fnYmNA33xgDSY0jAKI5yh5wlK?=
 =?us-ascii?Q?KfmrL1o6pP4kpTELDEC7e1NeQ7qtftzNc6t85qXPy6mhSWQs3CR2DlrQUGkP?=
 =?us-ascii?Q?XK+RkVv1fo0UbKBN38wDI1ZfF5D+zPhYWa+9DI90MkGm6Oy/h5szzeU4qHjP?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7af46b8-f4bc-42a7-3f9b-08dd575bfb3d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:24:32.7620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDeWADlJZSo71yxMew84pC+Bd1u/7PDq7POmr/ub/aoLMLwR0qSn67gZc+KqcppqQeY4eQzx6keXfXSecbKvm1nV2udDL4T9JIAYiu++CUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10044

This adds support for Bluetooth Coredump feature to BTNXPUART driver to
collect FW dumps on demand, or in case FW goes in a bad state.

To trigger manual FW dump, following command can be used:
echo 1 > /sys/class/bluetooth/hci0/device/coredump

Once FW dump is complete, it can be written to a file:
cat /sys/class/bluetooth/hci0/devcoredump/data > fw_dump

While FW dump is in progress, any HCI command will return -EBUSY.

After FW dump is complete, driver will give HCI_NXP_IND_RESET command
which soft-resets the chip, allowing FW re-download.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 147 ++++++++++++++++++++++++++++++----
 1 file changed, 132 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 5f07a57532cb..200ed95ff588 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -31,6 +31,7 @@
 #define BTNXPUART_SERDEV_OPEN		4
 #define BTNXPUART_IR_IN_PROGRESS	5
 #define BTNXPUART_FW_DOWNLOAD_ABORT	6
+#define BTNXPUART_FW_DUMP_IN_PROGRESS	7
 
 /* NXP HW err codes */
 #define BTNXPUART_IR_HW_ERR		0xb0
@@ -106,6 +107,8 @@
 #define HCI_NXP_SET_OPER_SPEED	0xfc09
 /* Bluetooth vendor command: Independent Reset */
 #define HCI_NXP_IND_RESET	0xfcfc
+/* Bluetooth vendor command: Trigger FW dump */
+#define HCI_NXP_TRIGGER_DUMP	0xfe91
 
 /* Bluetooth Power State : Vendor cmd params */
 #define BT_PS_ENABLE			0x02
@@ -310,6 +313,16 @@ union nxp_v3_rx_timeout_nak_u {
 	u8 buf[6];
 };
 
+/* FW dump */
+#define NXP_FW_DUMP_SIZE	(1024 * 1000)
+
+struct nxp_fw_dump_hdr {
+	__le16 seq_num;
+	__le16 reserved;
+	__le16 buf_type;
+	__le16 buf_len;
+};
+
 static u8 crc8_table[CRC8_TABLE_SIZE];
 
 /* Default configurations */
@@ -774,6 +787,16 @@ static bool is_fw_downloading(struct btnxpuart_dev *nxpdev)
 	return test_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 }
 
+static bool ind_reset_in_progress(struct btnxpuart_dev *nxpdev)
+{
+	return test_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state);
+}
+
+static bool fw_dump_in_progress(struct btnxpuart_dev *nxpdev)
+{
+	return test_bit(BTNXPUART_FW_DUMP_IN_PROGRESS, &nxpdev->tx_state);
+}
+
 static bool process_boot_signature(struct btnxpuart_dev *nxpdev)
 {
 	if (test_bit(BTNXPUART_CHECK_BOOT_SIGNATURE, &nxpdev->tx_state)) {
@@ -1175,7 +1198,7 @@ static int nxp_set_baudrate_cmd(struct hci_dev *hdev, void *data)
 static int nxp_check_boot_sign(struct btnxpuart_dev *nxpdev)
 {
 	serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_PRI_BAUDRATE);
-	if (test_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state))
+	if (ind_reset_in_progress(nxpdev))
 		serdev_device_set_flow_control(nxpdev->serdev, false);
 	else
 		serdev_device_set_flow_control(nxpdev->serdev, true);
@@ -1204,6 +1227,73 @@ static int nxp_set_ind_reset(struct hci_dev *hdev, void *data)
 	return hci_recv_frame(hdev, skb);
 }
 
+/* Firmware dump */
+static void nxp_coredump(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	u8 pcmd = 2;
+
+	skb = nxp_drv_send_cmd(hdev, HCI_NXP_TRIGGER_DUMP, 1, &pcmd);
+	if (!IS_ERR(skb))
+		kfree_skb(skb);
+}
+
+static void nxp_coredump_hdr(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/* Nothing to be added in FW dump header */
+}
+
+static int nxp_process_fw_dump(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_acl_hdr *acl_hdr = (struct hci_acl_hdr *)skb_pull_data(skb,
+									  sizeof(*acl_hdr));
+	struct nxp_fw_dump_hdr *fw_dump_hdr = (struct nxp_fw_dump_hdr *)skb->data;
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	__u16 seq_num = __le16_to_cpu(fw_dump_hdr->seq_num);
+	__u16 buf_len = __le16_to_cpu(fw_dump_hdr->buf_len);
+	int err;
+
+	if (seq_num == 0x0001) {
+		if (test_and_set_bit(BTNXPUART_FW_DUMP_IN_PROGRESS, &nxpdev->tx_state)) {
+			bt_dev_err(hdev, "FW dump already in progress");
+			goto free_skb;
+		}
+		bt_dev_warn(hdev, "==== Start FW dump ===");
+		err = hci_devcd_init(hdev, NXP_FW_DUMP_SIZE);
+		if (err < 0)
+			goto free_skb;
+
+		schedule_delayed_work(&hdev->dump.dump_timeout,
+				      msecs_to_jiffies(20000));
+	}
+
+	err = hci_devcd_append(hdev, skb_clone(skb, GFP_ATOMIC));
+	if (err < 0)
+		goto free_skb;
+
+	if (buf_len == 0) {
+		bt_dev_warn(hdev, "==== FW dump complete ===");
+		clear_bit(BTNXPUART_FW_DUMP_IN_PROGRESS, &nxpdev->tx_state);
+		hci_devcd_complete(hdev);
+		nxp_set_ind_reset(hdev, NULL);
+	}
+
+free_skb:
+	kfree_skb(skb);
+	return 0;
+}
+
+static int nxp_recv_acl_pkt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	__u16 handle = __le16_to_cpu(hci_acl_hdr(skb)->handle);
+
+	/* FW dump chunks are ACL packets with conn handle 0xfff */
+	if ((handle & 0x0FFF) == 0xFFF)
+		return nxp_process_fw_dump(hdev, skb);
+	else
+		return hci_recv_frame(hdev, skb);
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -1265,20 +1355,15 @@ static int nxp_shutdown(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct sk_buff *skb;
-	u8 *status;
 	u8 pcmd = 0;
 
-	if (test_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state)) {
+	if (ind_reset_in_progress(nxpdev)) {
 		skb = nxp_drv_send_cmd(hdev, HCI_NXP_IND_RESET, 1, &pcmd);
-		if (IS_ERR(skb))
-			return PTR_ERR(skb);
-
-		status = skb_pull_data(skb, 1);
-		if (status) {
-			serdev_device_set_flow_control(nxpdev->serdev, false);
-			set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
-		}
-		kfree_skb(skb);
+		serdev_device_set_flow_control(nxpdev->serdev, false);
+		set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
+		/* HCI_NXP_IND_RESET command may not returns any response */
+		if (!IS_ERR(skb))
+			kfree_skb(skb);
 	} else if (nxpdev->current_baudrate != nxpdev->fw_init_baudrate) {
 		nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
 		nxp_set_baudrate_cmd(hdev, NULL);
@@ -1298,6 +1383,16 @@ static bool nxp_wakeup(struct hci_dev *hdev)
 	return false;
 }
 
+static void nxp_cmd_timeout(struct hci_dev *hdev)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+
+	if (!ind_reset_in_progress(nxpdev) && !fw_dump_in_progress(nxpdev)) {
+		bt_dev_dbg(hdev, "CMD Timeout detected. Resetting.");
+		nxp_set_ind_reset(hdev, NULL);
+	}
+}
+
 static int btnxpuart_queue_skb(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -1318,6 +1413,9 @@ static int nxp_enqueue(struct hci_dev *hdev, struct sk_buff *skb)
 	struct wakeup_cmd_payload wakeup_parm;
 	__le32 baudrate_parm;
 
+	if (fw_dump_in_progress(nxpdev))
+		return -EBUSY;
+
 	/* if vendor commands are received from user space (e.g. hcitool), update
 	 * driver flags accordingly and ask driver to re-send the command to FW.
 	 * In case the payload for any command does not match expected payload
@@ -1486,7 +1584,7 @@ static int btnxpuart_flush(struct hci_dev *hdev)
 }
 
 static const struct h4_recv_pkt nxp_recv_pkts[] = {
-	{ H4_RECV_ACL,          .recv = hci_recv_frame },
+	{ H4_RECV_ACL,          .recv = nxp_recv_acl_pkt },
 	{ H4_RECV_SCO,          .recv = hci_recv_frame },
 	{ H4_RECV_EVENT,        .recv = hci_recv_frame },
 	{ H4_RECV_ISO,		.recv = hci_recv_frame },
@@ -1508,11 +1606,13 @@ static size_t btnxpuart_receive_buf(struct serdev_device *serdev,
 	if (IS_ERR(nxpdev->rx_skb)) {
 		int err = PTR_ERR(nxpdev->rx_skb);
 		/* Safe to ignore out-of-sync bootloader signatures */
-		if (!is_fw_downloading(nxpdev))
+		if (!is_fw_downloading(nxpdev) &&
+		    !ind_reset_in_progress(nxpdev))
 			bt_dev_err(nxpdev->hdev, "Frame reassembly failed (%d)", err);
 		return count;
 	}
-	if (!is_fw_downloading(nxpdev))
+	if (!is_fw_downloading(nxpdev) &&
+	    !ind_reset_in_progress(nxpdev))
 		nxpdev->hdev->stat.byte_rx += count;
 	return count;
 }
@@ -1580,6 +1680,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->hw_error = nxp_hw_err;
 	hdev->shutdown = nxp_shutdown;
 	hdev->wakeup = nxp_wakeup;
+	hdev->cmd_timeout = nxp_cmd_timeout;
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
 	if (hci_register_dev(hdev) < 0) {
@@ -1590,6 +1691,8 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	if (ps_setup(hdev))
 		goto probe_fail;
 
+	hci_devcd_register(hdev, nxp_coredump, nxp_coredump_hdr, NULL);
+
 	return 0;
 
 probe_fail:
@@ -1641,6 +1744,17 @@ static int nxp_serdev_resume(struct device *dev)
 }
 #endif
 
+#ifdef CONFIG_DEV_COREDUMP
+static void nxp_serdev_coredump(struct device *dev)
+{
+	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
+	struct hci_dev  *hdev = nxpdev->hdev;
+
+	if (hdev->dump.coredump)
+		hdev->dump.coredump(hdev);
+}
+#endif
+
 static struct btnxpuart_data w8987_data __maybe_unused = {
 	.helper_fw_name = NULL,
 	.fw_name = FIRMWARE_W8987,
@@ -1671,6 +1785,9 @@ static struct serdev_device_driver nxp_serdev_driver = {
 		.name = "btnxpuart",
 		.of_match_table = of_match_ptr(nxpuart_of_match_table),
 		.pm = &nxp_pm_ops,
+#ifdef CONFIG_DEV_COREDUMP
+		.coredump = nxp_serdev_coredump,
+#endif
 	},
 };
 
-- 
2.25.1

