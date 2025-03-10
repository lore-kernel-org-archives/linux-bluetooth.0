Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D2C226555;
	Mon, 10 Mar 2025 10:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741602265; cv=fail; b=byDyErcYsU8lQfWRzPAPoflXrrHZtIRvh8PLgVyuA76gryT/cnORomosQHzFNaS9tAFNr6rKJL8RJgXzPh3hQPcaPakyLW2xOVlvn0oqF3GkZX/fotFoq7BplCDjehIfs6Tu29KuepFjtt/IvLXAM4QMulFlAMursPRM0SzcMfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741602265; c=relaxed/simple;
	bh=M9Ymvn82YPrwlBjSIFbXig5+YVUXltEI2OlkGRwbQzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EY2/G0YKA6THXPHmis2r27SMSWOL1xOD4+4LgpuhvZwufT1vnx8YwcGZR+abHhdYjHFaoncya3euppzDCbNxZpPrA/D6UZ4a0vc5Z3nALRYOA0ccx/i2p0YlDfI45naN9Fi1v9d4l4b8WKxc1iLvfZRfztxdshEIhkSiQuNbN4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=P1LmtTF+; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="P1LmtTF+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYL38YcZ0XD8YBqoFJ9b+3yNzirMXDoyxsUaU1PcMfgq5Ey8UKWlbqd+40qlsATcNw7X6tejiZZeja7Ixt6k2mM9HcV3GLxkwvwBtciql+M1jdBoJ14l0ODxluF41ge4tZJ/LnYW3ODKQw9Wxts1aABh8BPUURcvdHmqh6+qBYjdf1E9KJu+q+bTEHfe1QaVI87Lg8ByB6whvm4TW/aUWVg5keN0XhCTpLa/W+9kKixVuXCugx+eBuHKn0Vq6eJFdbVSgJQ+25EDMjcdqLoB9IsVs3FTzFhZ1SWIFrV+WiYLNfXJWN76NYW7KhGXwzwMc/xHqHWAOpU+u4LW7G+f8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ou0R/TV7kNclcJ9AgJq8ldahDE2gupq5SaSN6jMwhuI=;
 b=Ok3xLrlLExrLnGRkJNfNQdkiU78pJdd88xglFduj5zSsf3TDjv9E06CgbGhH991F6lDU4MWEv4TGCWLMfFV1JeJThcXMCBDx9nnmTloDTHgw9k8tQEHU+N39+NPy+pJsx5GBG+8ixi5qzTlmA1eE1A2CESXUsd+Kh32WVJ0vuJw1YHrrFKvLPVMKHmOdCIk+BmXYFXRse/yGJfKyRkGmbX6kyesmm1PMfBWycWqefFGpVSAwxj+TeKASBiOn3p/UrOB+MBrv7Eu5RcUOAGaAZZjWk7YyhtnbNb2VYitX3rWZT4unq7ePKi9A+Igw4a/IwANmGqOhPMBjtNHyTvEJYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ou0R/TV7kNclcJ9AgJq8ldahDE2gupq5SaSN6jMwhuI=;
 b=P1LmtTF+gyP/4FxIJMdlIARWA6RaUJRr9eZuvjWPI7ENnY8+ybHvtpfompWx21Oulfm4LQApeFfQL6HWn7PJeNcwOht4MEz0/rZY9+ZMhQ6m4atesGnTYBUdWyFRFPrMSP5qttqxffV8yXUTaJAjT7xm5SiZazwpd0sbcC+KAXH3b1Es1XDKXjbmzM5QUxSx0g08cCQsLv/qkpnlZUN0FchpCx3olnbfhqPT3y3xVR53sEqLO3sqtCPpAlOwmd6qokH3MjSbvRcD+kw2TQtwZKkLQ7mT7tH5cqurqXbVV99ZcW7atdT4SEfr40m9ojbetLuLxJCmwOlOOgpsBb4ygA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB9234.eurprd04.prod.outlook.com (2603:10a6:10:372::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 10:24:18 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 10:24:18 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v3 2/3] Bluetooth: btnxpuart: Handle bootloader error during cmd5 and cmd7
Date: Mon, 10 Mar 2025 15:56:12 +0530
Message-Id: <20250310102613.261996-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310102613.261996-1-neeraj.sanjaykale@nxp.com>
References: <20250310102613.261996-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0016.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::26) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DB9PR04MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d30a5dd-6061-454b-d5f2-08dd5fbdb72c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2GUx3VXahK6u8Jn6Z+VYC3wBIdduOJabYxeyqlKOBYa+sP2Gz6L5dCfmbiTH?=
 =?us-ascii?Q?eW6KwWCIQJapaUurq2AM77LPLXjIQx0bbZi69Rbfmv8apdDx8IV3jiCX7/Rw?=
 =?us-ascii?Q?qf36TV2ZP6wU4J/prJ5aWkoQf8N2Dv1iBusv5Bpg1TlyixJrNrpvLd0sGyNO?=
 =?us-ascii?Q?/HrGJzWe0ewNEksWU29vXixBKivBPEglyOG8HBwWL6ISw5+2pVlZpxdgvxgI?=
 =?us-ascii?Q?Qr/yIc2KZfIrpsUTyFcQhKVUUsekRPR9IT8QCnSOHVFf9r8hCL5W2Glb5Czk?=
 =?us-ascii?Q?u5TBuX14IMtG96eSD/FEjE9WJGTYzoA5MzsPF3Q7oyq+22tLVI4p1qNn9C8y?=
 =?us-ascii?Q?GODhBL8qqD68hCcw2Ja6JYdwMU6t/rOg4De2coFfCQZjKzWyBRyudrqjedQq?=
 =?us-ascii?Q?15+nmH6z/O00RJfK1K55W8VNsLJ+uUzttjHP/lx6nc4HBLAV04Z+CwABfIZM?=
 =?us-ascii?Q?li2tURCWWTx6QBcInuT/qxqB1Rr4p0LOps5/vBh1507/fC57Pnb8o6YEcfDX?=
 =?us-ascii?Q?I5sUpI6EGVfFdT3g1a7bmZyqzVP5qLMt5HN+NiS5Z0kaTjk2J/v/2vdGxIvv?=
 =?us-ascii?Q?DGggG/x2o1bzNDNU8+UFCqPr4BBEfqqJCHkfGBXPIhe2bWlQwDf2Mvcy5Jgv?=
 =?us-ascii?Q?jsUTnNy3IN/9OOnlAhBByA0j7KJlGhKHC8JmH31yaucDQNTPuHjv5vvk9kuw?=
 =?us-ascii?Q?7Z4LZMj6e5eWNFDYSuFgDhDVqi7kEqwT35UcmsNbt6L5Zz/iTrs2VWivG044?=
 =?us-ascii?Q?AXZA64Z69IuODlvk6Gd7EPUPiSW+rFQ8u55QhSWpRRZIY3xfG3owNL7EIz9w?=
 =?us-ascii?Q?r6WouER8+DPfF5BoJTye/aY2k33Eu1oonU0hhMqDofGIjcPk+qhbG1L+GqaU?=
 =?us-ascii?Q?Q3g8zymqQQZL2dcM2fMcVS2/8mR7FDF7E+hX+//UA5ZL5SfRit9ARpWa8LKs?=
 =?us-ascii?Q?aVwiU29cqzuI8E20Ax4WhaEqYefwhBOt5jr//xASLLFHJI45uUDJZCkiV4Dx?=
 =?us-ascii?Q?e+uUKs4DnOk9bDSU8OeGCp2XFDesO/axTowwQZLHMSz1uMqweGL+WOwzMOR6?=
 =?us-ascii?Q?5barnFiCayZoOhciF0Nh8KiKNiNsDzRKj2ImvERhvivMQ6pyYuxIlN9gW995?=
 =?us-ascii?Q?8JhUdILSw/v/2F7jN20i1UpoWhSUdOd9B3FonOaHA+KsKRjfA/5/+5p6Nkz7?=
 =?us-ascii?Q?P/nW72xrucAk4KLeXJY2pebuVLtHI2zPe1E1JdJM2xuHD97RBm70e1/kIEuG?=
 =?us-ascii?Q?x1TPUkc5F30295DTvhTuytEOTpOhMqjSzwgM/3Y69rXnAuf7F5C6Be5Dp8uW?=
 =?us-ascii?Q?nO/BsUA96HusqEL5G9jJu8H5y6kqV0gZE603ynXO2YI3rE8e2hRAJHAOpdEH?=
 =?us-ascii?Q?yDL8gMg+flR8hZ7VDq7RGJ5WZ8LDWyCptKCnnm+eQ8XTaaMIPgdZzhd/Zqi/?=
 =?us-ascii?Q?X/UwptnwYfc6TR5LNBkMk/eV/Psf6/hs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tl+MHc988jmv9ER+RcTOjhUhkrh5n6xF3TWCq01YpMJtMScpVUUgE+8YupvK?=
 =?us-ascii?Q?VSKAvMGm6ZC/sEcAFYlvQlWDn569mu8AcufCtnca0syyDG/0cY+FgQXZpNYe?=
 =?us-ascii?Q?1bAqVEIh8P8MNIeM5S4PWm6iHq3/WLNec0quV6VSI2RcAqxvy7bJfttLgaox?=
 =?us-ascii?Q?aM+q0uyX7X2jal3cjCikpTTPAGNjLCN48fNEaIA7q+B2B0OQf+F4p7YsNv+a?=
 =?us-ascii?Q?AJwTAAprw7+tMgT1HWeScwkMjKklDf042gSYLpUpgOqCc3e86/C7l1DfaFL1?=
 =?us-ascii?Q?All2wpthHzm4SoVIwttubgso6m2Zd2GaqTrKeXZC8lDVnlN3mNz4RjpzQRkD?=
 =?us-ascii?Q?lPYTFub6zw4CP5FVu/43I/3dyLicETlkC3a9Q0pzaWSJiJxk7Oh26HFY4SEb?=
 =?us-ascii?Q?gyp520+9N0S+RbqpchoaI2hR2VNCEvPykdoito2UNkPXFJIbmRI2YeXiyPdZ?=
 =?us-ascii?Q?TlP+q+CmiROF+fzH4v4JC9yCLJt9c2lUn0qQP1hW84NA/C36AkCI7DZoErCK?=
 =?us-ascii?Q?LSnQV9L7TjUnGInmM+Z/5eHAx6E4k90blK2tR5dUd4Ur1hu2FYTRBACeWnyK?=
 =?us-ascii?Q?QBpNHQYC8EhHEUsW7+vjIAZXlg7nEPX/UcysdV/LYYNUjPhaozYUplKiLE6z?=
 =?us-ascii?Q?ZZMzXXWEhEbYjcgXOLhXaSS05kG0V5cWpeuzfg7NsFxWeLufy1S5rqL7wynH?=
 =?us-ascii?Q?V9fGTkJm+9vX579KKTRWGU4I0El4RCLyu0VF+61Jpg0xMtwK6WEYKFj66yVq?=
 =?us-ascii?Q?eerQiPTEvbfZMLieELEW+9mAvS4pKZBW6Llld6l4v48zwGdMDWexWHWfxRtN?=
 =?us-ascii?Q?YNX85hW6hKrpFZkB3Q5MqCRODnwdbV5hTEeiyPiBLSouJq1kGbO8EYZw4iV9?=
 =?us-ascii?Q?FwaPct+UqVYLMq2/p8QuG9KabZYkddYAcD1adXeD8cgi4mQw8eMsWFlESEXK?=
 =?us-ascii?Q?MY+C9v1Io0dHi4EaXTwoWdLuSY/NqfDJTXMgEOJ7Q1PR/HguXv8h8lAtGvWZ?=
 =?us-ascii?Q?QZRdWLwiGiSfwzhPlwKVqG7VfMnM4W0sVv3Cbh9LIDBG2v9rWzTVlTbx1WIP?=
 =?us-ascii?Q?j3ELUKLRSIu6FXJtFvvYEQYncYhuQC/EjzdgYCE3eLhhYYwFHgUMswF8IFbk?=
 =?us-ascii?Q?Wf+WneUZrh0kd3731mHyqk/WDuOj3+patcV05a0T57z+sLFTGpIYqViNvpWd?=
 =?us-ascii?Q?ugzDRB/k769HLUx5FaByl24KnrooR6f9lKO/Y+f7ARL30ThG6kkmaaynLbyg?=
 =?us-ascii?Q?HIOtRV6NTQ8IB+ESzDK8tZaZFW8fFD9F+etSjtYHDrTQIu3zYPqsmMlt12Mi?=
 =?us-ascii?Q?Jmp6K4xxGJH0LjscJCAzn5/hZuVeZL4nsbSKaldjoa0x/GgUUiQSghB2Y9zM?=
 =?us-ascii?Q?ePGntSh2g+rmfqL5grhWo6TOfN6zTthlPw3l6+81FHAsAJcYc/8YGKfUo6AF?=
 =?us-ascii?Q?IKLWEj0V/6gD/cpZToeLs3U7xfe7QW2emdoJhUEgi26Pq+NqH79iumOtnoOB?=
 =?us-ascii?Q?XP06F5q6UkKdX1JW7IRfButrUaOfI4k7ZXx8anLXvy3gyh9wJkX/JRP/i1ww?=
 =?us-ascii?Q?IvNRJHmW0epy+sawBwh4ZsyUIizD1O1gtncBbuuF+yj2K2bWyP5xu6d2iXMN?=
 =?us-ascii?Q?fQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d30a5dd-6061-454b-d5f2-08dd5fbdb72c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 10:24:18.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SbGE1UxIyrp+FtGH3Kju9sfOKEIweoxOs3yutohVCd4/rguqvRzfMrM1kH7o47JWXv4ndRwIgcrtSBajL4Ji9XqMQA3rMBujkxL/TcpMrLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9234

This handles the scenario where the driver receives an error code after
sending cmd5 or cmd7 in the bootloader signature during FW download.
The bootloader error code is handled by the driver and FW offset is
corrected accordingly, and the cmd5 or cmd7 is re-sent to the controller
in case of CRC error.

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Fix unused variable warning. (kernel test robot <lkp@intel.com>)
v3: Fix sparse warning __le16 degrading to integer. (kernel test robot
<lkp@intel.com>) 
---
 drivers/bluetooth/btnxpuart.c | 61 ++++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b8a00bf062e2..2b7fd864dde1 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -162,6 +162,12 @@ struct btnxpuart_data {
 	const char *fw_name_old;
 };
 
+enum bootloader_param_change {
+	not_changed,
+	cmd_sent,
+	changed
+};
+
 struct btnxpuart_dev {
 	struct hci_dev *hdev;
 	struct serdev_device *serdev;
@@ -177,6 +183,7 @@ struct btnxpuart_dev {
 	u32 fw_v1_sent_bytes;
 	u32 fw_dnld_v3_offset;
 	u32 fw_v3_offset_correction;
+	u32 fw_v3_prev_sent;
 	u32 fw_v1_expected_len;
 	u32 boot_reg_offset;
 	wait_queue_head_t fw_dnld_done_wait_q;
@@ -185,8 +192,8 @@ struct btnxpuart_dev {
 	u32 new_baudrate;
 	u32 current_baudrate;
 	u32 fw_init_baudrate;
-	bool timeout_changed;
-	bool baudrate_changed;
+	enum bootloader_param_change timeout_changed;
+	enum bootloader_param_change baudrate_changed;
 	bool helper_downloaded;
 
 	struct ps_data psdata;
@@ -660,8 +667,8 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 	nxpdev->boot_reg_offset = 0;
 	nxpdev->fw_dnld_v3_offset = 0;
 	nxpdev->fw_v3_offset_correction = 0;
-	nxpdev->baudrate_changed = false;
-	nxpdev->timeout_changed = false;
+	nxpdev->baudrate_changed = not_changed;
+	nxpdev->timeout_changed = not_changed;
 	nxpdev->helper_downloaded = false;
 
 	serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_PRI_BAUDRATE);
@@ -883,15 +890,14 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
 	len = __le16_to_cpu(req->len);
 
 	if (!nxp_data->helper_fw_name) {
-		if (!nxpdev->timeout_changed) {
-			nxpdev->timeout_changed = nxp_fw_change_timeout(hdev,
-									len);
+		if (nxpdev->timeout_changed != changed) {
+			nxp_fw_change_timeout(hdev, len);
+			nxpdev->timeout_changed = changed;
 			goto free_skb;
 		}
-		if (!nxpdev->baudrate_changed) {
-			nxpdev->baudrate_changed = nxp_fw_change_baudrate(hdev,
-									  len);
-			if (nxpdev->baudrate_changed) {
+		if (nxpdev->baudrate_changed != changed) {
+			if (nxp_fw_change_baudrate(hdev, len)) {
+				nxpdev->baudrate_changed = changed;
 				serdev_device_set_baudrate(nxpdev->serdev,
 							   HCI_NXP_SEC_BAUDRATE);
 				serdev_device_set_flow_control(nxpdev->serdev, true);
@@ -1097,7 +1103,8 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct v3_data_req *req;
-	__u16 len;
+	__u16 len = 0;
+	__u16 err = 0;
 	__u32 offset;
 
 	if (!process_boot_signature(nxpdev))
@@ -1107,23 +1114,40 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 	if (!req || !nxpdev->fw)
 		goto free_skb;
 
-	if (!req->error) {
+	err = __le16_to_cpu(req->error);
+
+	if (!err) {
 		nxp_send_ack(NXP_ACK_V3, hdev);
+		if (nxpdev->timeout_changed == cmd_sent)
+			nxpdev->timeout_changed = changed;
+		if (nxpdev->baudrate_changed == cmd_sent)
+			nxpdev->baudrate_changed = changed;
 	} else {
 		nxp_handle_fw_download_error(hdev, req);
+		if (nxpdev->timeout_changed == cmd_sent &&
+		    err == NXP_CRC_RX_ERROR) {
+			nxpdev->fw_v3_offset_correction -= nxpdev->fw_v3_prev_sent;
+			nxpdev->timeout_changed = not_changed;
+		}
+		if (nxpdev->baudrate_changed == cmd_sent &&
+		    err == NXP_CRC_RX_ERROR) {
+			nxpdev->fw_v3_offset_correction -= nxpdev->fw_v3_prev_sent;
+			nxpdev->baudrate_changed = not_changed;
+		}
 		goto free_skb;
 	}
 
 	len = __le16_to_cpu(req->len);
 
-	if (!nxpdev->timeout_changed) {
-		nxpdev->timeout_changed = nxp_fw_change_timeout(hdev, len);
+	if (nxpdev->timeout_changed != changed) {
+		nxp_fw_change_timeout(hdev, len);
+		nxpdev->timeout_changed = cmd_sent;
 		goto free_skb;
 	}
 
-	if (!nxpdev->baudrate_changed) {
-		nxpdev->baudrate_changed = nxp_fw_change_baudrate(hdev, len);
-		if (nxpdev->baudrate_changed) {
+	if (nxpdev->baudrate_changed != changed) {
+		if (nxp_fw_change_baudrate(hdev, len)) {
+			nxpdev->baudrate_changed = cmd_sent;
 			serdev_device_set_baudrate(nxpdev->serdev,
 						   HCI_NXP_SEC_BAUDRATE);
 			serdev_device_set_flow_control(nxpdev->serdev, true);
@@ -1155,6 +1179,7 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 				nxpdev->fw_dnld_v3_offset, len);
 
 free_skb:
+	nxpdev->fw_v3_prev_sent = len;
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.25.1

