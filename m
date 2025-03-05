Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012038.outbound.protection.outlook.com [52.101.66.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A9824BBF2;
	Wed,  5 Mar 2025 13:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741182258; cv=fail; b=sjEVoA+v1Wc8BNLHiKcjjPBecj12QPJZvxebtdG5WIQUq+UGLocrE2smc0sJwvpBRAF8n2QCkbFmYO23imMS52vRn9pdq9S6LrQfkTReKBQM+JFdyjDuglcBybiUiN1jJPzRVQlI7uqfp8hzrWXJ8jLjdTp9i9WxSXiOkK3RKtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741182258; c=relaxed/simple;
	bh=OAS4tiDCqh/KCmq2ZFiUokh7ieYJeBKlwjL72OvK3Dk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vAtFOXSIBylzKHo5Zzm60deTK7KD3zZqwMCKnlCrbps/FqS30LeSNbd1aR3MR3TMoCCexPlxbxtDUDl2SFd5lB8CBM77AfVXtiLYhlDVhRHO9BwrInvRXiuO6KEZRKeGA08b/zYryVDzE/3mSz3boFpCi2dBPf59OEVhFDK3Vww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dOpl0Yow; arc=fail smtp.client-ip=52.101.66.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dOpl0Yow"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cmrTaF33QZz0bQXo+sPGWoz+XT9BDS2YNTkOHQrW74lQ0Ok9Z06DQa2XrnmxG9k5EAl06sYglnBmpHndrBC2GU+p6d/fA0+3p76jQGBRIdekabXomyG8CR+ncYIS410xQXPJvaZ9iiKrtFOY9wthdQ/aOor48nunGP1t7iYKiZbKZDuk7s46oo5lgwKa0WHG77hAda/qzQ72GNGEGtxvzo1FxTyCLzXJEZo90rW7ZbMvKMEqmP8voiuvk8JywaU+j1VrdpzfrGKMh2U03JNqWm8q4Om6UCdINbEQE0V+YoK2c0QwRtXlIMaN+beXPNUOkBlaJmXnIoJp2y9VsWTCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsxETw81uy2sK6QNUYY/zk16nH3R7fgf/DKqzG9SXiY=;
 b=ffQyBTwcVfAOaJwaFJUU3JwezQZCVKvEz1UHx7xkxM/pz0XQ7QiYaAJ0eZSIbnezrJ1lU4ZiUu62sWBlSkltvNIZM+l717EhmkvCn3jBSWH8QoFC3cZKSR9q2wDup5IXRe9G2qlRjgNJoMQvv4vz9BNmch/bAR12cBouFIBDYUNJvUSoV7COVAu/NQ6YtuDU8AseDW/wx9e7b5KYFgtyFKrN5LafwKmpRe7GpeUuXfJUuLykXNrABmH9agN+Lmp8CBZUdQnPRI1vhVnHeXICCqpMd7PHVCOybdmObTBkx7ioLjpTRTa9sL3da1lZlX/hwEZkChHS7/rkhaDE3RL8bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsxETw81uy2sK6QNUYY/zk16nH3R7fgf/DKqzG9SXiY=;
 b=dOpl0Yoww+7rT0zJ01nVRoqFStPb+5xv5AivcNYVJnsjaBcF4cB/85uhzBJM61iMzA+ZmvEU8HigkTpsK7JfNNzdsP80QhpFn6LRmjvuQsIp4lO+HEWU6XgsqGCb7CK6F3AbnKdQUiGJr58DuGy9oQN4Y0V8L0A0Dtxg0o8IMJ+B558elVfrbttlckrwXwaiYOp8YtjEZ3kn08HDB2Vsk+AwtnunJzivMGUMY97YJgQ0hDn81wK/40f6ZokJb3Naae4c21djGMRn+x6ceVGymmdlGrUaeAMkaNSGbH1+OTqQLuyjn0SEZn+f+vSOIatg2dLQltgrV2YATCYh9vJz+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GV1PR04MB10965.eurprd04.prod.outlook.com (2603:10a6:150:207::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 13:44:12 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 13:44:12 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 2/3] Bluetooth: btnxpuart: Handle bootloader error during change baudrate
Date: Wed,  5 Mar 2025 19:15:22 +0530
Message-Id: <20250305134523.40111-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250305134523.40111-1-neeraj.sanjaykale@nxp.com>
References: <20250305134523.40111-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|GV1PR04MB10965:EE_
X-MS-Office365-Filtering-Correlation-Id: dbbb119d-5ddb-493b-16c7-08dd5bebcfc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ln9BoQDGomqGzYbDbzutfGUFt8BJ2+4K6HAfIIADhQu0hr+PS6VYh1phwEuL?=
 =?us-ascii?Q?t8txpf/+/8SkqsZSWGQyTJ4S4gCdqcYR1GGMk7TZmDDkjZQtTTNzYdPlEQzq?=
 =?us-ascii?Q?GR4alQ9VqLOOS5911V8ibLiiUx7LJvO7jEo9CcO/o2Wn+yQcnIW0VKQoxwTD?=
 =?us-ascii?Q?YQV/s2/qwN8w7aARiBvPHvoFKm16HcGcczcqP7W9HZRTqWhh6Im1RiStKgCp?=
 =?us-ascii?Q?5LRQBddhjo79Y2qvuCzLCu7YIGcvSa72MRNW8Aq5X/kxIJWihHCPRXixlB5p?=
 =?us-ascii?Q?VVGM4vZqxO8vGwnST9yT1FZ8uP4zclSxTIeputVohy67yJk+k+EyLlG6E7J8?=
 =?us-ascii?Q?V6Ab6gizuUiapTdsDOPxC+vQFXBu0QGinMZoxIxdsdid5u0qMCP11Y3S4pcG?=
 =?us-ascii?Q?PKf7Rk/FVIB6rIPilhXixfVHj/zyR87Lu9xzktKSKH1M/ofvOMD07e5Ql6Az?=
 =?us-ascii?Q?yR0l1Jn7iu+SWwDtXSkrnaXfLrQR1CLUZotUCp9FuTTbAGGHVcp7lKObhRYG?=
 =?us-ascii?Q?T2UXat2Vt0wM1IpL2Sof9uPtqta8NQWnOdj0zysDroZorMFqPuzPRRLRaEP5?=
 =?us-ascii?Q?MBhBzFrE0vkMnYGMq4lGdhcrqIrorH2luGV1r4Jrn3Cksl0GfeNW8QF1yL0o?=
 =?us-ascii?Q?YSkxsInKPiGQQm6GFSSUFI/ibf30t7CIIHWqeqxRrZaGb9RdC4tZIkgd8Y+f?=
 =?us-ascii?Q?GKpmf6H+kyThtHEQ7fyNXURWgX28sGkUNgGmj3tXBVcUb3eY0N2p9A+gvGsV?=
 =?us-ascii?Q?zVsLLG3nb6l15sQPIB0H6VSflCg/xw8JYkAZmrxEX1s4SiKkLOgHqLDhabB6?=
 =?us-ascii?Q?Sbxc65P24mi+vz1RIEW2X66FaRE5SWNXz9sf6TvjXkUZKLJtPARl2sGvS2D1?=
 =?us-ascii?Q?u6Iuae3wfR1RcbdGrIhzn93xlcrfEvAg4Y9/4NjfDfBxNAowACIWw0ehTif+?=
 =?us-ascii?Q?ZMTfvHeVpAdXsP3+1ipk9ARGCcEUn3ZZlJlgdVvQbnanrbRW9G4ebXwswZr/?=
 =?us-ascii?Q?2t+mW3eUzYOvZnWx1iKJIUrdMnNNoyX1yALzCIHBeEzyEcaM9yUq+PG+xTAn?=
 =?us-ascii?Q?A6tILpUF7OeQTLztbPu2Ykx/5i1+n8PRpaMBOP7hYKsNx9iQ3mU6xYKTZLhI?=
 =?us-ascii?Q?8c5+nEWnIyJZ00a7n7zCMl/sHrQ137IBzjsvW6JjZEsP/+4daoKBL/ZNn1Bd?=
 =?us-ascii?Q?IdP87xMIibL9PYecpaE96CV44jLaSf9YE8jk0JIrW+vdtPBFdtdblpBwKuvL?=
 =?us-ascii?Q?08ctf7EjPavqLltkCeDeo4XY/QKNpvRZLEfmQNJOAEAecSs9z7E8OjZYllr5?=
 =?us-ascii?Q?cvWkzqdG++oCUtw+i2jEeVLbpJdlB4vkPkYmiduSctzrer4TKeIE1rUS5k8F?=
 =?us-ascii?Q?jrsu0ur3G2+k7gL5d5x7dJyQYMk8WcStrgJ+zt4MOjxcXdTs7QurcB7Z9FQZ?=
 =?us-ascii?Q?W5ps1lJ5pzd302IQ3h7KOPbWk0Y2qv0k?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wofg4UEVoykZT43Aa3gS54PWVsHesuG9VmTblEHxf489I0vW6S2vo/yye9Hn?=
 =?us-ascii?Q?O/i85RznxbOnixyKiJRKRo9Yq/HdLHc6Rb/pPUf7UpON58gOjA+bK+Fbm8tP?=
 =?us-ascii?Q?oinqzQJi2+URMamgx13ZdaLusI+Y9Z8gRzcR+R9UiikandFZOn12MM3nC1rZ?=
 =?us-ascii?Q?Ht/mma4JsHaMdPl1rCU0wqOO/xfY4PRrInwBAX2SdJBMfbQEYufhzZI3APyO?=
 =?us-ascii?Q?e9WWbDMztvgzXxGSO0la9Xgg3OTQ83FuhaWv/G/ktSQETv2rEeZ18wbUJ0M4?=
 =?us-ascii?Q?PHDjJamimCvWDFvHt9nWk7NJI7EJpNQSXco3Rwyb85Uc2jFJWhRNYnMVzYuz?=
 =?us-ascii?Q?49B6WA41cRfATfnnL9Agl217Ancw8raSlWC9OmJJwor6HZn6/bvi/hzghNUR?=
 =?us-ascii?Q?IKlcowH/tHwOWpgrMGVmr3mriW7tEbhTN8YX6kS7uuHoOe39Qzlz3lSgPALP?=
 =?us-ascii?Q?AMziMYvmGm+lHQFztdGKknzBXxfzkiw8Nn1C93Ih9c5+FiYt4oPO+1fPxQzX?=
 =?us-ascii?Q?NQ/+/57f/jkbE6ne/nqIRwnmY2vA4Dby/rTQ9NtgCr6y55Epim7qq8AR061K?=
 =?us-ascii?Q?zhPoeVV7eJbygL3Zxk/9BQblljtsPgyj4Wf41RvE8rkbEZTQ6S69X6ZDDQrG?=
 =?us-ascii?Q?8WmmrlM6XMq5zZRToVFmVicLLIhb6+7htNrASTeWXFy8yysEao9FjQ+br6nq?=
 =?us-ascii?Q?Box7aai7Z3+CVEnqUCVSEgMIkMWecwxuHuVdAMSY/nRV9opT6GKYrLm6ieR5?=
 =?us-ascii?Q?buP/Jhulk8KXaA6offtJrKHLXVB+F7VIB4Ku/sO733Gylv4a1Ls0TfE5vOaU?=
 =?us-ascii?Q?rcvTgj2lhBiUmYvW1Cd3CrjG4Cu56U+sbePJu0UdBoajpmRhnYqkCfPYKsZm?=
 =?us-ascii?Q?9lai65o44W0yu3PMSFfI6SqaTWm1VxpanjL6r/iz9BlJb0WMAMVd0hSmEXxt?=
 =?us-ascii?Q?MWo7xJC2ZxL8BliVI2KceqCKbGd/bTju6CKSl0yuUgiJZy8TN1iWQ0MyuR9b?=
 =?us-ascii?Q?/ww9z9b7LfUdPmRhW9+xYoqBiWAH3E/z6905trXwN0mUgkl5gb49jMkJyMm+?=
 =?us-ascii?Q?+iBsQ53SUDCFHW/PcE03u9za0z1PjH3ekFDi9rEVxZWBDra/s07Ftkjm2oOd?=
 =?us-ascii?Q?+5cksYqwD+Mgd4Lgr/3ugrNL67DnhNQcRVB7AAxkY8SfG7Bw0yTn6LQVRaQK?=
 =?us-ascii?Q?/OIa+lY9Ph/RgS/PDnAqY5iNQecwjlH6/+PfVTyZpyaTOQmE+rleKdNxkAbZ?=
 =?us-ascii?Q?ncOkaIDMp0rwcdROAH6eOvxCbK0L/u8JC4+MvZ7YvlabFAQZDr2bPHmJNJAG?=
 =?us-ascii?Q?7FmDwKZPHU+FdzDwQqN0IeIiXi8WjKcN2OTCFVbZpj4JkMvaM1H16f3jKkoc?=
 =?us-ascii?Q?c5EdCtpT0PS9ZVXmfWSxU9jBFu3Tz83rqnfdjv5QufD750RnezfCfL75HY+y?=
 =?us-ascii?Q?024uqFcGJDgdaoP9jCrGFxNvONSQGOgy8v0y75haB+d1M0DC6HdrlpQQKTBb?=
 =?us-ascii?Q?Sp4k68LuQbClMw1/O8qr056m7f9nlkazMyu1BSNRaWHvsAKPdVYTm/TeKFpq?=
 =?us-ascii?Q?fA+1dFIjRiJh2tuJqHoU84C3yY4GFRez79JnDtcaZwKmvOvqBDBBnuxyAK2X?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbbb119d-5ddb-493b-16c7-08dd5bebcfc9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 13:44:11.9917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vegt7Jj024NjhmmKfhadstcWtLZ+YAr9PMdVfYG1L6K+Hh22vCYJx+UF0g0QcLSWChgz52IBX7yoYem3pcuF4gbfbGHeVO23uAm170oPNUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10965

This handles the scenario where the driver receives an error code after
sending cmd5 or cmd7 in the bootloader signature during FW download.
The bootloader error code is handled by the driver and FW offset is
corrected accordingly, and the cmd5 or cmd7 is re-sent to the controller.

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 55 +++++++++++++++++++++++++----------
 1 file changed, 39 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b8a00bf062e2..4367d59b4653 100644
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
@@ -1109,21 +1115,37 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 
 	if (!req->error) {
 		nxp_send_ack(NXP_ACK_V3, hdev);
+		if (nxpdev->timeout_changed == cmd_sent)
+			nxpdev->timeout_changed = changed;
+		if (nxpdev->baudrate_changed == cmd_sent)
+			nxpdev->baudrate_changed = changed;
 	} else {
 		nxp_handle_fw_download_error(hdev, req);
+		if (nxpdev->timeout_changed == cmd_sent &&
+		    req->error == NXP_CRC_RX_ERROR) {
+			nxpdev->fw_v3_offset_correction -= nxpdev->fw_v3_prev_sent;
+			nxpdev->timeout_changed = not_changed;
+		}
+		/* After baudrate change, it is normal to get ACK Timeout error */
+		if (nxpdev->baudrate_changed == cmd_sent &&
+		    req->error == NXP_CRC_RX_ERROR) {
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
@@ -1155,6 +1177,7 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 				nxpdev->fw_dnld_v3_offset, len);
 
 free_skb:
+	nxpdev->fw_v3_prev_sent = len;
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.25.1

