Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2088.outbound.protection.outlook.com [40.107.22.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569DB26B957;
	Thu,  6 Mar 2025 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284468; cv=fail; b=Cb871f/4fq9+jnJ1rlDRGNBCHUssrDgeH7ui+G/ShG3ppfM8cD2BbLT3IMqltgXKSgNqbcH5S98veUmWPz2XiKICZxiWQ1IkocWlsRIJokSxjrGBzVVycmxeyfuJnht3GLyZVMsLBGloWnYh1JnReLfcCs0xfzCcBuHFFKwURaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284468; c=relaxed/simple;
	bh=JoUD4kW0Yz4/8yFfz4PSchDDoMAdgKaiqOpXGY5IRX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U3miei475/pkTANxjTT1UfO7DazQluiwLNa0FznfO52OeCdF/1WbyzZqgWh6z9R58NeMHBDPtiaRVnsRqMm9zaBm0cZh+2y8cz7J3DhVFOmLvIAjWSZCtWIYhOU86F0Q/cLLGn3eufV5/JBnRZ6vVl37rXlgX19fLR4z/cIFjgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BEaCJkhC; arc=fail smtp.client-ip=40.107.22.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BEaCJkhC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ED/8Hz7dzpYu4oNPz1GzGVviGBOf2xrabOkPKQsTTszupjrLpCVny2PKvrFNT5U3byY7Kp5Vgf7wMvuRM8Jmfeo1xVCuzw1nJJpKzt/f3YmbEUQCdOxUlSsxndhhPp2xjMhlrFS0LqrupO0L6bwW631X3oUJpl5dqDeQjv9qNxNUT3eH+SVFkzAFVBi7q+2tZDj0srVSPJFePcohIB53yiVvAl05BJr2k/X8vJXWG6NLUVokvJdQ0qXvYLLz0catzKE6PRbUbgePCTSh2BUgbg6OT92cxr9amSs8EJT/tW2Fl9k06yIAOb+NX6EQWKbHXA/ZghoFQ+XGYelaZAxIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgX/PJCw3QLIeinKF4aavnn+ueVGvlM53HOl7GuwAZM=;
 b=ldQWZ34S048MICgKlrIJWmb6Z8T1hVk5NmNArd6xWiizm37ImEijJmsKAlucXscm7fHDth+PkiULAIh5U+0U5c6bXxlhx2s9L7X6p2sK6eMq0E/WuC3bD2BqJdDVaUaTMC3m151UBMVOGSL6kpzlHt/+GdXTprXdg1UJicboSY5Qzj+ijEyFdHQh7o3E3s7c8hmPM6rYEAq5mabCV5DnIKMHs1RoxPBk6G/DpstvvxRDNzGSb5R1N1A9vI1tL2774Aecmuz6WWYdhYd0ZPl1iYrxvPKN4xrsqd4/zsMB7XLoYe+5v3IOXDsNkTFRBQ7qw5u+7YJzg7ICeGj0JHjt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgX/PJCw3QLIeinKF4aavnn+ueVGvlM53HOl7GuwAZM=;
 b=BEaCJkhC2hF/rK/sDOChrjlwnOtpARWsa48XkD1wdKCoPLBQy3/4j/XFPf5P6T/9qsqh6KUPNd12oohFHbhnG74uy3cTYbfHzcNqyNEDy7Rj55yp/YDIbPWi3AlErZWzQU1MKDEzdQUPx94NUqx/mk0CTs6uUbr0KOoxiw819FBkcP04jfjbZF9rl33gZhMjFBxpG1yC2xjqr76fPMCX2dnBmZ6X48EOC2w0/YojWbhkJAFRmDnRxpQFhVraT9pOzrlKSh3JkZ/PNF5MUCyhZqarm4tcH4rM7gG7JncN6kLTsIIJvyXV8mgcNwtJeyKO+xv9l5U/+oR7Z4zEcYn+gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB10603.eurprd04.prod.outlook.com (2603:10a6:102:484::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 18:07:43 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:07:43 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 2/3] Bluetooth: btnxpuart: Handle bootloader error during cmd5 and cmd7
Date: Thu,  6 Mar 2025 23:39:30 +0530
Message-Id: <20250306180931.57705-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250306180931.57705-1-neeraj.sanjaykale@nxp.com>
References: <20250306180931.57705-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::22) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PA1PR04MB10603:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1436de-7ee2-47a6-a668-08dd5cd9ca92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PzBKWW7cqmHXnQS0q8nsOOHMcGjgWRAJeTbO5ZhcrpWCJiJS9C0RsNuCY9uN?=
 =?us-ascii?Q?FBeglVuzvdl/cS943NSVV2+y7G3OG+55bkoN71HHcQQzjVtKIopfdDMAucPV?=
 =?us-ascii?Q?Oe/eXU02557KAS7HKUd3BAJbWQNtITLEQOYpFVM9z+1m6GEpvgeNMD95q3G2?=
 =?us-ascii?Q?CQFKBRKarvbxEDe4UufUVbK9GGAOoWOCDDCTURqXYmsBy7U8ajs98KBY62DD?=
 =?us-ascii?Q?2oK27qbEv0C/fVI5YdZQIq2D6EKxnV5CKLj/UEdT+2YpPnizo05jJiXPx8XD?=
 =?us-ascii?Q?O1H21MH5v26FZvnuD4ZtP3CZl+v/qPRjTzWQrJJbqGiz/xkdmvYxocxjWkHF?=
 =?us-ascii?Q?QUQZUIe/IkhO3QROpYAvtrw6wIfbaZVSFIk4bTG56BPvoaL5VbfqpwpBQh5/?=
 =?us-ascii?Q?GPTlg6HT9WPpJVgJYHSOmcFncEJnpEXnwIKGPoQv99T5WXc+baHSfa4p36+Y?=
 =?us-ascii?Q?nwG00pubNnebp+gY14cJNYH/xBstrLJs6PH0i4wFsHnC4+jXAB5/HaEZSdHp?=
 =?us-ascii?Q?jI1tBFUJ1usw0pzqvCDYD/r0bgqiaDZF7XxaceJAsojZJnQqY0spk+FfXDcN?=
 =?us-ascii?Q?hgYoIFM8pc0dlLFaXsFJC6qNmMHbHC+DZuH89hnuOF4bR+Z8nqNFKqM7hH+V?=
 =?us-ascii?Q?Tp52G/9FC1bfYmFxkbZmlFAHgy1QOkbNrQBvtiLdxkbPj8k5oZu3RfVIrnhU?=
 =?us-ascii?Q?kfVdEQlEFq+XVFMmSHagK1EgbK0/+Wap3uRTL44HiTUJiiE5lacnfxJM8Q26?=
 =?us-ascii?Q?MqTMD61m22gRwrmUr53IzCDrVye00oGt+zcGjb84HP9b1V+ioCQzb5RkmXR4?=
 =?us-ascii?Q?R0ttB2vlkTlsZUu7tHMjfvXWZVmKQzVg9d1VTjcPZoClj4MHKBset7wABgoH?=
 =?us-ascii?Q?/igEBOMJQQZWZOfLGQuV0jgSwx+fBeoeunwCu6RpBC9muBYQAtGO7WJ6olRc?=
 =?us-ascii?Q?ykbXGxrITc5OsZ3eM/fkm7UZ4N9cS/I5mNFq3YQN1X70VwKY8+hcoEGiUGFC?=
 =?us-ascii?Q?keSCZTqTebVnpfaRYjVd9yTOzL3ur7k3n0dQDhbDRwsmPh+gP7TIW5cHZMB5?=
 =?us-ascii?Q?gitiB8KPZ1I/TZ7Km6sNxuF5xEBxXB53tmDj/NzfpiwKuKaouT2ALiQYT7lt?=
 =?us-ascii?Q?cebULy907/jxWIwByjyfhFWQhqxGGNMvyj0otEIu+L2LGC7rgJPQfzLFD0cy?=
 =?us-ascii?Q?FKfze0NFlUMBgK9qmiJDrUodisOC0omPCcxeR2N/BxA5IQvDcUD8N+5MX+kn?=
 =?us-ascii?Q?KwJ5Ncgt8kcEjY8eiyRF7i/Uwk1hJbMetGoLR2fB9yL5XlheIgeXJTfeZayC?=
 =?us-ascii?Q?xtlhLwVggUD5HaRI5e1KWw72ASWoUNz3JhRMSVv6NiGIh4N8Pz5tdNkYYUXK?=
 =?us-ascii?Q?J4hDJ2wLp1qEwlaSkZui6yEvBatNheSvCf8iZimEaGGc2MuMEUTAJkzKvJxT?=
 =?us-ascii?Q?2M7PotwRKpJl30n5tw8QBJhoUTsTdJhW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qkZDmgO01C6h1ZWRrZGk3LE7KdwAwB4018AwlKW2XXW5KCUtTYrJbcnGAwo9?=
 =?us-ascii?Q?1DOQNFL+AaTM+dY3fh86xMfLJ11zxUZJo4CsvN/UKscX9XxEKFxFInK7uPs5?=
 =?us-ascii?Q?USJMphF6Z/vMrkyREG5FfYSJhG2VUIsHJqSsosUOVUNB1/q3PxY4DQclbU8G?=
 =?us-ascii?Q?i2Nmo/dQSQUGcJly3CiLXd2WHab36+SBDnOoGiZhp/qJ7BzfQebrKyCnCcl5?=
 =?us-ascii?Q?FzTRT/jpZ5y/PRqU+/ITh1u84n7ayfYX9S1/LAmNxxHTA4wuxNCVux313sQy?=
 =?us-ascii?Q?we9PoT6w7hm94NwKcxpWLkP0x4Tj7BT/joOgSwIFvD+M6+zvQICVLtPbX+Rh?=
 =?us-ascii?Q?5z/2zHgxVFsvqWo+wdW0/KuZlsLmT5km/oXnPrA0MvIJCirQoZfpUxus2CUo?=
 =?us-ascii?Q?lsDk4OfbklUwA+Pp/MUT3I5kaQK/1yLg8fX9pe1m20lYrEt3RUxEdJZAdvqu?=
 =?us-ascii?Q?Vwr+I3XV08zEMJmzr5kx2r7XqMNZjEaUI8VCHuVR66VZ4AKaSQSeTTjZgvGE?=
 =?us-ascii?Q?LqA4ZfJsvyLHzvVzkMjD2qHYv2ZpiI+EdysGXCm2QhRqfX7oh5/BW2G5S+sn?=
 =?us-ascii?Q?bLiVYp8vkCqVks0WNUJ3NPrs2syuNrKnv9gFN94FuutTsd8399nPg31iOpzf?=
 =?us-ascii?Q?cGWkunWhJrDVNRFnpFjlVOVPy6Z1Y6wjAsD4G0Bc8SUfURwTNpWPx6VpThqF?=
 =?us-ascii?Q?hjXVlNH6lunZbFtacc3exuUlEjdntu+An35ChRzOEc8e/ypKBdIXlMeeWqBs?=
 =?us-ascii?Q?JmKE1egab1rxPmMf/+64EBRC9BfMlhTNVab9Zp/wd8lLWshsi+phJ3VhEhlG?=
 =?us-ascii?Q?yJ5xTKdE9BZChe9Aj8KzTVdR7aToAif3uB6Iv+9eGjiYz/odeFOjAAesppPp?=
 =?us-ascii?Q?hcAf+i/Fie7pTtdylXI7o7ruLKCNn6jyXtKVfa28rjiDosq4/8dO2INodK/s?=
 =?us-ascii?Q?X+Uly1fgRzkrdsoSfLQD7ea/XDSQ2jvJZvZ2lhHevfAfkfF+ck0+d+3DR/UW?=
 =?us-ascii?Q?Dutjw7YSzSJytU25xUZL//lEjApbDQ4luCP+9lSbf/YkY3sXpKBAknw4koEr?=
 =?us-ascii?Q?cdhNaVQSdSqCITbx01WNO+52wRGqNHBIfDPEWn+gVmh798iICvN9HlC505bj?=
 =?us-ascii?Q?wkPzaLYf0bh6XEsiIp8KE69pHxrtA+GZIN2rD9nF3ut8donqXNKchPFfAF20?=
 =?us-ascii?Q?iJspPiboh+dOFKU4wk8NhUZOUo9ETslg82AoOJZR7zhyOBYcYHhwjWWp1hX2?=
 =?us-ascii?Q?75D2KaA731AT7H1NY65h2QWkJcMAbDBQjCNnJzOVkjjO/aOV64NFbg8Vnr2m?=
 =?us-ascii?Q?WtIy74CU/lYV8h1aYwsB2iuotTM7rpYlGq3YIp1OYkA2SKneHwnaGcHA/VWu?=
 =?us-ascii?Q?du7zBxRUjg28e84udjG5FSpipYK6uiZfPRv/ZH/3ngdmNj4pPxoOVF+l5kYe?=
 =?us-ascii?Q?TpQNjQP2yVDpLxgxl2qX9P4miFQhhVfJ8OeWN8U0ST/S2DhtZ3gTOZSlIcPZ?=
 =?us-ascii?Q?VmcOKjLy8s+MHoRPZiCJtYNwWAmqYVCP307tEaQhWfBwYiC1/21lasal+3eG?=
 =?us-ascii?Q?k/Dd4w1oprEdN3ydmkZNKVIIvU+DIPOj6wUN4sHgFWrIKofZdofOGJ+E1QjZ?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1436de-7ee2-47a6-a668-08dd5cd9ca92
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 18:07:43.4287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l/Gagsb6NNrqHHMzcbyuH6N3B738moGDWer2+6A1SEawV6i+TYGZMyWcSQjHWVmeE8nhYV/U0GhKp4zQJYVX4x4uFcd6P5N/Z/snEpY7c80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10603

This handles the scenario where the driver receives an error code after
sending cmd5 or cmd7 in the bootloader signature during FW download.
The bootloader error code is handled by the driver and FW offset is
corrected accordingly, and the cmd5 or cmd7 is re-sent to the controller
in case of CRC error.

Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Fix unused variable warning. (kernel test robot <lkp@intel.com>)
---
 drivers/bluetooth/btnxpuart.c | 57 ++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index b8a00bf062e2..a47181298e81 100644
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
@@ -1097,7 +1103,7 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct v3_data_req *req;
-	__u16 len;
+	__u16 len = 0;
 	__u32 offset;
 
 	if (!process_boot_signature(nxpdev))
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

