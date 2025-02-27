Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335F1E8344;
	Thu, 27 Feb 2025 18:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680675; cv=fail; b=dzCF8oynMSVp/EynHGg/PGPfKBuIe1nmH2wPxaDqK07h0xIVGjRlc5fvJ9eQfJX3pEeeKVdbDb+fKC8GsndOtWJdYxGtEdNwSyEcF/RToeZ2cmhjQ/m3Dfnz2PmmdGVk99ffjJRSFDRXTCnxba3dU22kOlZzHRDMJBVBqwSbBxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680675; c=relaxed/simple;
	bh=/588JXWUkTIwuDbEI2Z/ZxVm4HNjaZlbDKNxR57Bo0s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=JMiK+BuzeWTE15Y7KiRukOOzdO/zbA0h2p0G/ndW2uSsRJdT/4T5WGQ8iMZEzOcVhSsyVnblEouq0aUz2MC7BOvMBz/teRU67dB+ObKlo6HmzERpy0TwhGtvHsM4luTt0mQQd2/q4xAZoTXJYhLQbj4AlGJj7EM415IVZU4JbpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UASrzXar; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UASrzXar"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWwv4HuyzSMhKv+r/3yqUWB4BAyRrWcEcn2VHhimcasCwVGs7LLpZuoeBTbCW1Sg8kmFbEKacKP1q0mDJR3FSfqdZQQFtRnKqrA7yAKEDl2HBoUPrxFygPsZbC1kTUVFRK+t5PfGNhXMVj+hjVAWENp+hfvbnvzInTQsHnkmV9IudBzLS+sNCQOlzOYXgAPRiN8C1NAZ3yEwq80KCgFvpC0tIOsqHhcXdYu85S26OjS3/EtGoGKE3qX2AQHp3yer8fHcPz17zklhMUMQssDIGc3SotoPtYZpmSk4hSciniPvGmQlkTb4mD0pzA3IsmiQl0DndWXhvYqJahc67MFztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1X1sn4rf8KlC5zEyzuqP/GBNquUOdw8j9FVj06LjAM=;
 b=ZHq3S3sesJkB2LzbBNtnwtpt4wyY/xq03dVVSYuNmuY54WSkGcvfJR5EIoYNeuUNvRvOh/fhvE2FhZkk1aY9BViFnaIo5blxU/1mlzqtUoaOmIfTN0Hrjsn5LiMjcswkrIgB3FQHam2kdlv11L0Xz2K8d2S8ja5D7CTR7ea7CdOr/mnKDEuUwXWFW5yDVo3ksOnDFnkXsAVTO0pHkW05ItK0c80XdSRw/V4QxNTcuW+PoPE56SYCgavf/42OyRoR760pEaOJBH7EsM2oFET+Rk/dHibyOxzWRJ3dporHMMmUS/fo/byRmBoij7LEr5SvBKakwnTfJch/ABvdOfgMZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1X1sn4rf8KlC5zEyzuqP/GBNquUOdw8j9FVj06LjAM=;
 b=UASrzXarLRDMmt4cVBy3503BwzvEREboBOcqfqdkyd0zSXpuoD1NPXJvmpIzmxXg+G6sW0al0hiDnAm285G1MvZN3cXInvYa0WwTGdKSiyBJOvlAsGhADD0uN5ycdJC1muU9IsUMoxgbgSMiPnqc6kqCd2AZqTS/EKIGV7umVeJ/Y9usJW4KOMqvx4+ikkgDbrNeBZ9VvFEjRe9DAL3UfLYNdkE2ic+76YKpvy/Morxq8PyjsDQGJxnxw2FlugYkJ8HaKw4m99xSDFUVqnqHvuel6Km/E4n9khHl132MUiF2rrZLs4xv4DAubvkZ0H0/Zml0ZkS6wFQB7LOixHb7hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by AS5PR04MB10044.eurprd04.prod.outlook.com (2603:10a6:20b:682::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 18:24:30 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:24:30 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	loic.poulain@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	manjeet.gupta@nxp.com
Subject: [PATCH v1 1/2] Bluetooth: btnxpuart: Move vendor specific initialization to .post_init
Date: Thu, 27 Feb 2025 23:56:19 +0530
Message-Id: <20250227182620.740323-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-Office365-Filtering-Correlation-Id: c071099b-0a6a-4c5b-5ba3-08dd575bfa16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3j2UGUFc2OPGFN4ouOEDZdDvqbrfcXYNooGiELjoaFQkOFCsTW1g9JCz2SG7?=
 =?us-ascii?Q?dT0Uj6HtABtGH/MxDqTHnQ0kytPhiLwQSQOrlo2sJMGiTFwpPtQHty/w6SdF?=
 =?us-ascii?Q?BPdXi+w8XF4r6M+aNrsGkgvapTLBV6aVVQJo9eVc/xWlpa3QeZNqpvxeJnTa?=
 =?us-ascii?Q?Hbl5pasrOvFQKf5W1uwA4CLLPji+PdwrAj+ekFMS12wmP1+RDpsJlIWD9XnF?=
 =?us-ascii?Q?HRD3aT+k0XQ4L83RthmjahXdpSWjdVZjce6X+4E6O2nIdQ6iBArYEh9UQZqS?=
 =?us-ascii?Q?6DZSj2iEfYkxGBHknWPek1kM4Kih0YdQ1PFZxrvR1OmQLVXi1PhZxVSpFOF2?=
 =?us-ascii?Q?/CWrof0+FdWIesCi65bdwiG4MVx6kGAGefyPj9Rtp3u9yOoigI5MGqAgYv1g?=
 =?us-ascii?Q?GC6h6vHFDYWEbfqxa81n+XSZOpBk37oDi1i75WMVDjoVjj7VwaAsympp88GN?=
 =?us-ascii?Q?QphhC/lOZDc84QwbwJCuUoxdqN8EygeJCXmzzjMkx/DJ1dquBmbSAy7ODTeE?=
 =?us-ascii?Q?J6TNp6aYLc+9GSejd2d3PRFMkWAe4+in6rHQd99qIIypcxYkP5eoFmqefzcp?=
 =?us-ascii?Q?JnYIeC9RPuP3mwhe4YYs8Yuy3QsCF4BpZXTGlrfinJK9BsaZTqksgVBGjkvl?=
 =?us-ascii?Q?u/SVgQrVzydhw7u1wE6w4/CvwxM5IY8wNfdbLidDkC/k86/YLIGE0svwFJ7R?=
 =?us-ascii?Q?xw0873bH/4sNVeYZixaowqRJ1tJKKduEPdy9hPDSTeEL3gcRiQ00yE4YcK3T?=
 =?us-ascii?Q?q6UXeeD4l5wV8dm6z+qSkmewqzdaJq7c/3u07F4sGqZ3KDmZxR0/4yll4qtB?=
 =?us-ascii?Q?CyCmT41D67KZ5QZXbYfkWHgue3uM7cznrqoAJAsp9J0EmxnLSIs0LGDC+oh7?=
 =?us-ascii?Q?QPtwCoQuuj7HDu/KgGdytIDu/+hwWZhyBu+jEA8viU2kdhUrmBxyShFq+rZi?=
 =?us-ascii?Q?y0Ln3ylIKrxDo4XVg+mtWq8nmF2XDRF7174bo7QqHHzNi4uY25zn9p+S1ZS3?=
 =?us-ascii?Q?DlpEVWCPH5edxQMGBS7YCBWJ6+SoYRdL2wZ5DFc07yEY2nr6MLe9cvZeuVzp?=
 =?us-ascii?Q?1ZWf8HCeetD9LlQCD86D1S9eyNRon+nZi6kqG8cL7FPMziS3Amd3wiU1vYF8?=
 =?us-ascii?Q?MivV+7rm2fwkVj3Z1PhRzbN5O/Em7kA/BCIikXL37jhisASihaj8DQdwbiLo?=
 =?us-ascii?Q?x+8fGHOi4Fp/k2Od8nHehd2rjAV2MqeCSoH1iHXAYzMfZu8oKKcGN3E9Tnn1?=
 =?us-ascii?Q?5t3s9HSumYdwHQ4SwBuqqAbqz9rDfVTtOpk1JAHY7hAc531WS2kfIzKEGK2H?=
 =?us-ascii?Q?idjGsNJYVVffZzZ7k35H5Vo2QaEhkWCFnYqbHsiihfxAyy8KXNnkofetvctW?=
 =?us-ascii?Q?/TyMyPNZzTf3oHyG64UVbDtf6b2QrKmmoToDd3ujwzOFXIEn6tYsJ87bfI7w?=
 =?us-ascii?Q?6lKDXrfgH8ylUqt7zd+dNXTlBfh3jFDc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7lYVSgcn0gxrX+guBlIRqUim62dkhxqMPbQg4MzjXlCCUbngLeqoosbhUg9P?=
 =?us-ascii?Q?qHJBxaLHmRlJ7ld7xMhJ11GC0Qftcxkw4FyV5uXe1HUkQ7QUjH2HxMXKcN7n?=
 =?us-ascii?Q?d7I2pY9WK6xxsjywOxIgkflur1cRUnzaWCiWmgy9RxgVE4q0kfF+tM2mnpjh?=
 =?us-ascii?Q?+YNph0A2mf4vAkEZYcoT9f3VMaPbDDNvRrTCi9QxjT1Quvwde7+A7eNTCcb+?=
 =?us-ascii?Q?xNP+wQNjbt/Xyn1V5P64YeylGV5PWGDpmqyrbyzz61Su5fIHep4c79AR3mzl?=
 =?us-ascii?Q?c9LYj76o5xpEXKpfHwwmVIO3YUgJEVunManOAAZCjf9922SzGMLeRN2OdeWJ?=
 =?us-ascii?Q?Ag50s2Fzz3Ljge+Eo7QbVCZq/FPacTAaj1Hr8j1XlsFqmYTNzTI9MSCnpC5m?=
 =?us-ascii?Q?30BT3FEi+lLhiO51rqBoFuP64fkqNWRbiR4Daz7hOseCVnaa8xuS0Sdyky98?=
 =?us-ascii?Q?xLNDE3GDqVGLti5uUb0LB3V12oNlwFUDvhLvSDe7AKdfup6M8d360HqLo+wR?=
 =?us-ascii?Q?IyhYjaZp+BlfptzGkLx9NG4ZzDwOGK56c1wmGwuVOl9dKeqyC0TiqEzVz73f?=
 =?us-ascii?Q?aU7wIWFnG8TyA8EogcH5F1wVOWiKEKkA0wnz6Pp2hFwSXheIFgHt31z6RzZm?=
 =?us-ascii?Q?VRWUlLvQOtHgxW7ZE7Yau5Wb6ow27K+/VnpffXr+cltigQthRmw2jLaE6P1r?=
 =?us-ascii?Q?WnHu5Z631pyExcXj5rrdBpiF2Ctm5nj2b8cJFB2Dsy0sqNL9nVPmXZNMCNiK?=
 =?us-ascii?Q?3BrhiBD8m+TT9S7Dq6G8iLjWLSJ4eTtKFHcS92h8UoWhiq41QBPzu7z+cyKP?=
 =?us-ascii?Q?rPyL7HtbtyA4R2sBofaAFEGa3QqljIAJ66KrCrzW1nwfUvElS4aIxmgMUQ44?=
 =?us-ascii?Q?mT+P1E8WqfKH4NJgwOGiCAZ1v3eiRQZNPCfM+1UFV6sBx2cnF7o7t9kceNMM?=
 =?us-ascii?Q?UN1OgeahOMZNuKsmrz3tW3aQaagil5BGVi7b/GBSCDqXdrDVoGPugTTLmn12?=
 =?us-ascii?Q?v+Hpz6aO3uhdG21a/Z6r+7HdSioMp16gMmR6CM1K1i1Unhk9PQ+b+gQZ4S3U?=
 =?us-ascii?Q?F40N1ui5uBIZSXY2RwiRX2Zykk0hROkHXPPwRmqnqz+LN4wv4obIjlOp1Nhn?=
 =?us-ascii?Q?rvmQX9GnTItoZZyShx0aZzgrxF54zfd94Apl+qjLKTxBiQ9FqWAqarC+tZ12?=
 =?us-ascii?Q?6SQN6Dlaf19Nj+GOUN7XUv0C5voz+7K7/JZ6UhLghCX9H8XpwRihcGuInuc1?=
 =?us-ascii?Q?EMgieuSTBKD+r1/urC1bBGYfBphyLjz77qjh6camtiXYWNbuTQc0kqftctEx?=
 =?us-ascii?Q?2kxlI9oORTkGJZV/AqAOPNL1r8RR5wngdW7rQY2wKZFl7Fq3V+AY9WuQlGlj?=
 =?us-ascii?Q?rmYfVg3zVuPtjCaWSYCnmeF8x3tdRCkST+BEaDQ9V86wxvP/n5LJGDNjVNuq?=
 =?us-ascii?Q?BW7EA4cz7aFLAvHrkbHh4bj0vH8C20CXsw+luHtF9tCCBiUglzMsV1eLAc4I?=
 =?us-ascii?Q?pOLfS6kSzv6U6TXxi2eNDNUF3Uz/xNwqG2zXStDpIgFoyMnvq08AQg7C/7Xr?=
 =?us-ascii?Q?oWSrAF4d+lALTtWgrR7G6jBmwk0bCXXxO/Ko+8aKs/vCG37Mn8C6YkxwwF5F?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c071099b-0a6a-4c5b-5ba3-08dd575bfa16
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:24:30.8606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qANI/n+SKPkvlQxHtgR7SsgSC7c2j4xT45KaBvTrRNl+HLxQAMUaCJq3LCpO2PwBVOxNF0pQMCzTXpt/OIiQg0fPIq29N9noqNcWUjmPhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10044

This moves change baudrate and power save vendor commands from
nxp_setup() to nxp_post_init().

This also moves the baudrate restore logic from nxp_serdev_remove() to
nxp_shutdown() which ensure baudrate is restored even when HCI dev is
down, preventing baudrate mismatch between host and controller when
device is probed again next time.

In case of removal when the hdev is up and running, we have to call the
shutdown procedure explicitly before unregistering the hdev.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Co-developed-by: Loic Poulain <loic.poulain@linaro.org>
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/bluetooth/btnxpuart.c | 45 +++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 4f2f429c9800..5f07a57532cb 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -630,11 +630,6 @@ static void ps_init(struct hci_dev *hdev)
 
 	psdata->cur_psmode = PS_MODE_DISABLE;
 	psdata->target_ps_mode = DEFAULT_PS_MODE;
-
-	if (psdata->cur_h2c_wakeupmode != psdata->h2c_wakeupmode)
-		hci_cmd_sync_queue(hdev, send_wakeup_method_cmd, NULL, NULL);
-	if (psdata->cur_psmode != psdata->target_ps_mode)
-		hci_cmd_sync_queue(hdev, send_ps_cmd, NULL, NULL);
 }
 
 /* NXP Firmware Download Feature */
@@ -1228,11 +1223,6 @@ static int nxp_setup(struct hci_dev *hdev)
 	serdev_device_set_baudrate(nxpdev->serdev, nxpdev->fw_init_baudrate);
 	nxpdev->current_baudrate = nxpdev->fw_init_baudrate;
 
-	if (nxpdev->current_baudrate != HCI_NXP_SEC_BAUDRATE) {
-		nxpdev->new_baudrate = HCI_NXP_SEC_BAUDRATE;
-		hci_cmd_sync_queue(hdev, nxp_set_baudrate_cmd, NULL, NULL);
-	}
-
 	ps_init(hdev);
 
 	if (test_and_clear_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state))
@@ -1241,6 +1231,22 @@ static int nxp_setup(struct hci_dev *hdev)
 	return 0;
 }
 
+static int nxp_post_init(struct hci_dev *hdev)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct ps_data *psdata = &nxpdev->psdata;
+
+	if (nxpdev->current_baudrate != HCI_NXP_SEC_BAUDRATE) {
+		nxpdev->new_baudrate = HCI_NXP_SEC_BAUDRATE;
+		nxp_set_baudrate_cmd(hdev, NULL);
+	}
+	if (psdata->cur_h2c_wakeupmode != psdata->h2c_wakeupmode)
+		send_wakeup_method_cmd(hdev, NULL);
+	if (psdata->cur_psmode != psdata->target_ps_mode)
+		send_ps_cmd(hdev, NULL);
+	return 0;
+}
+
 static void nxp_hw_err(struct hci_dev *hdev, u8 code)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -1273,6 +1279,9 @@ static int nxp_shutdown(struct hci_dev *hdev)
 			set_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 		}
 		kfree_skb(skb);
+	} else if (nxpdev->current_baudrate != nxpdev->fw_init_baudrate) {
+		nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
+		nxp_set_baudrate_cmd(hdev, NULL);
 	}
 
 	return 0;
@@ -1566,6 +1575,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->close = btnxpuart_close;
 	hdev->flush = btnxpuart_flush;
 	hdev->setup = nxp_setup;
+	hdev->post_init = nxp_post_init;
 	hdev->send  = nxp_enqueue;
 	hdev->hw_error = nxp_hw_err;
 	hdev->shutdown = nxp_shutdown;
@@ -1597,16 +1607,15 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 		wake_up_interruptible(&nxpdev->check_boot_sign_wait_q);
 		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
-	} else {
-		/* Restore FW baudrate to fw_init_baudrate if changed.
-		 * This will ensure FW baudrate is in sync with
-		 * driver baudrate in case this driver is re-inserted.
+	}
+
+	if (test_bit(HCI_RUNNING, &hdev->flags)) {
+		/* Ensure shutdown callback is executed before unregistering, so
+		 * that baudrate is reset to initial value.
 		 */
-		if (nxpdev->current_baudrate != nxpdev->fw_init_baudrate) {
-			nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
-			nxp_set_baudrate_cmd(hdev, NULL);
-		}
+		nxp_shutdown(hdev);
 	}
+
 	ps_cleanup(nxpdev);
 	hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
-- 
2.25.1

