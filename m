Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3C122423B;
	Mon, 10 Mar 2025 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741608045; cv=fail; b=llKJpZ8ZW3ayf0A2fxF/rb0Ch8WeFpKQSKtsCun17VRiTScCIJ3IwgY4I2/yUa3hdH/91/C70OvDXKoEFL94mELzItVz5UMPj91jyrsnjiDIOeCvreHDECc2+7OHFBxPOI+arXVlQGdSSgas3BKsdcRdC+VpAm+7pN4DjMWyZWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741608045; c=relaxed/simple;
	bh=I6+JEEB4c1YzUFCDY1EIKTXd9l2nuWeCxAAp6fCrpCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t8IOsXVBbgF0+EGo8sFUhpdCggsoYeU+HHZng3nGwEmuvIrWrsUuraCZW6n9LloYqH47FONUDM9xEBMTgWQ89WfJRzFX1GCp635lb4HrzZFTCYWDkNygFrNl8nOGrW9pgLCsO6DYfee7b+DnuyRuN1S0r3xfhh8hvDWwUVidp7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cr2XOAxf; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cr2XOAxf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kXOYFI42JkWtblilPJdb0qvJld+xHRCMCUe3abqnSXZxqxBwKiY3+5bABiZo+UJVw+zfqtxLwfcYvyzntMBfCG9dRUUzP0SvC07Zk71VaoarKZhzh7vZpsEHGsMRWwoj3bzb4OKL1S1SW+UlUXvr5QxiJEH1CTmsut7UiCgUDse/3/yrlYcAwVAtOAGNrkCs6n7/UNtpOb/RlwANgo/h5JwkHTtLv0tPAuGOvlh5iCrYbvAvqMEZ/+GqTV/t+2l9xTakX0QNFtrbrj94TPelXhjOREsEBJ6zzoTUZ+SD1K3XJlz7Ts5QoWCtASoofV5T2ZWx50W042wxmR+vHvp+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ou8LVC7yWxYwXGStKxi+XVKVb4LtaKnQk1kD4N+Ye08=;
 b=yJhta7rZ/fJlFLzTa3mqADs+a95oxXoklurn4qsSQVvsz6EN1xDAx4FFsLuuh+bLN+Xs4J2rmuwXPtFFr3e2frpCtV5cwF2oVEbSJZlrjN5H4w1fRiUD2U7zbWHI8kbatWAx/0+k5XRyLmi2/epGAjq3/LaeHSrGCTde2R5SGWNCUw54fnb9Z9zUZsy7wvxJ92goI/JqzNZbzxIiZE86dJDPHI50y8PqYC9hvWtBgTM82XfWOLavmoa+jVAAi4aVvNwpWn3yNX0v2GU9rSWC4ZhRz/SQXkRCttG7CpOFZ0ql7e5rPgxbuqWvdk6Ddr4e1D9TMVz24q+bz/tXn3CZpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ou8LVC7yWxYwXGStKxi+XVKVb4LtaKnQk1kD4N+Ye08=;
 b=cr2XOAxfx6ueXR9h6f3L1trTsAlhj/GDS27v6gRhcnEGdSYDpFwLP4keLJDMOxGW2yUBVcBxTLKN6/tpr13q10/nmJMZ5hixvGZ2sBxnes7XuNrdDlf+Khi1/4R94ve1lmtNQMU22yQ1v3q2j8ZCeVVmEROf1feri8FPFms6upoCgooB0re2rLD4XhYQtjZ4amKB6La9b7vpTefJaSOvmy9SULW7pEThIUxS0w2adxY2WPPUFDqcKSH5n9cz/HvAD4BkWgTatrTwDdwL8w+1SppZaGqffcIkyzYuWW5CWz340T6UhkhoCRntAr/fi0ambyAKSZC10NRL4ZCo5H/fjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by PAXPR04MB9203.eurprd04.prod.outlook.com (2603:10a6:102:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Mon, 10 Mar
 2025 12:00:41 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a%3]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 12:00:40 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v3 2/3] Bluetooth: btnxpuart: Handle bootloader error during cmd5 and cmd7
Date: Mon, 10 Mar 2025 17:32:30 +0530
Message-Id: <20250310120231.263174-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250310120231.263174-1-neeraj.sanjaykale@nxp.com>
References: <20250310120231.263174-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0240.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::15) To PA4PR04MB9687.eurprd04.prod.outlook.com
 (2603:10a6:102:270::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9687:EE_|PAXPR04MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: c89d749a-03a5-4d1a-f071-08dd5fcb2d8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UX0KT2mx+duqzm23m1PPqcV7EuQxUwRggZoX8TPwBM8J5XSh2a2oTh4kTw4E?=
 =?us-ascii?Q?laaW3hqASb4CHMX/VeQmVWXf6jpOrrwxGTgxR7WkVMdxHS5JoX1MIlNHx3L4?=
 =?us-ascii?Q?L6aLnE165rd9yym44w6Tox81Y/wII0sh57AXtWTJlyMnEhhZDvOigdwswRj/?=
 =?us-ascii?Q?rjNEy0Tweu+8K+V62sChSquBxAQPFW5tcYtQR8V5SWrDqGBTypBsnP6/w+8K?=
 =?us-ascii?Q?p3ecw/QQUP+mmHUs4mGc8GPeIUEF+Ja4/vA5sTveEui1UKdBRuyrjq5yln/c?=
 =?us-ascii?Q?StDP3w7rEHe0tysGKsLrS1YTqrMeyxrg5AC30ePK0ABetqxjE2VmmUemn+sc?=
 =?us-ascii?Q?jtn3PpLCCoz1HuQsJ1LwMAGLeDP2YhP/jEA3W1JgWuhPliRLLyVgNrQwrafm?=
 =?us-ascii?Q?7ofMgB8lBmkupR3D3p2pTz8uL7jRrjsaTxNgNeiIIYIScqfZIMpIlER2eHHS?=
 =?us-ascii?Q?Is9aXWP/ZyJtMyBnS5z6sJ/NuT6uvUVGxjPLtytdp/4TmsSBkgIiHpj64S2q?=
 =?us-ascii?Q?h1B7F4K5ifBvkdPG18LLarVZNuxBXRuPaaVsBR/0oEgrAPJmDmXB77n6WvkD?=
 =?us-ascii?Q?LmhqJykx3758baN0NnKVpMo4niVFiO/nBx4zOgnM1W2WrLHBX0Gry5HQzQYN?=
 =?us-ascii?Q?taPy7w8xLa+0IxxHfiIXF4/Ahwa5myMGz2QmoFrk9V91YUcegYIJaU3cMOWp?=
 =?us-ascii?Q?a8YAOO0DdKueCbJbMmIpI1jVJx+qJ6HZqIEffsPk5UTeaFngVzAu6Ziph+Jy?=
 =?us-ascii?Q?rC9nzzLluKyn6NA7M3C9itCZKR29fdZplD27E6tYLkVBRNo1yw/+wZMpdpq8?=
 =?us-ascii?Q?zrBPy99craSlJBn/K22/tPvCviBpfN0kYmojJdpC4Tybhn+jGe9NtnCpoRkO?=
 =?us-ascii?Q?n8BIpIrB782uwOnof7RPYL4opM+4iYZtt0gC4feZNzk5Au4Pc7qxw1CVCKqJ?=
 =?us-ascii?Q?46HMkGWtFg9geUY4nCcHkLlFwe/hpnPQ+cZcjqXFdt/V0jF60YNJAcsZ9/5U?=
 =?us-ascii?Q?e0Cb9hoBhFHrt75Dqj3jE1s8OGxQuu4m7JJKTFci3+w4vFpUcB728D3dUUUg?=
 =?us-ascii?Q?9Er9xpJZdJbUsZwtXxkc5hobwDHLDB7KvRUpgOZESD4JXznzcf4cFhjK+jq9?=
 =?us-ascii?Q?OGggVfhbfWg5yDDcfKz8XpGQInzwUeNo0jcZJ1k6NwFl0DWhLiI5rk/2eI8c?=
 =?us-ascii?Q?mkzYL4CEFgtzA1CTrWUlBgyxeP0avzS5vu5x+QqwqHwuvd8s1yt9AhX1sfFO?=
 =?us-ascii?Q?zCjvzA7ygl46EsbimielihLVeLeLAhXUlOQbuANjYfL4oFyDYFpgV1h1AJMr?=
 =?us-ascii?Q?4nMtDTgkzezpeMhExuM9Ayz1d5ZMjlhKDKoXKJfWOMB8X7svWkx032S0TntX?=
 =?us-ascii?Q?JQbT3rhBSu8pqweWatWJoRYdwCSf7RAukvFIsiWzyiwjCRigiSQ63np/z46h?=
 =?us-ascii?Q?UoEiyrWR7dNNH+XaWjulSsWnODNgDxK9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mwmGIfQeQ+xaHT38qW62YSjrIFy0T62YDyOXwd1DJgHpWMn414iAo0/iX9Hr?=
 =?us-ascii?Q?AZG1ZydZpoRmSEANfTCsGbFXLkGue2jWTFktX/lYNfw1gz7vYQKGmQOXf6QI?=
 =?us-ascii?Q?vUN8UDZ5FrndCcMgKpRnt28M2aL8rvxM8G2WUkJ4VKaQr6qZZ/G5XjqXeHzr?=
 =?us-ascii?Q?RaBtUIsQmvWqCMsBGSSZbZpLvVAF04m1RTzMyOt3Ii1ips9j28BY0fK6wQWU?=
 =?us-ascii?Q?9gcvPnwJMe6FwbsSNlXYUe60vnQvk/20jCJ2HpSv9YnFLEdlPRGezBuhKCBv?=
 =?us-ascii?Q?Pv1d8f90URRO1z+H3Zeteoyf103i2UvPfCcZ8YZ6/6Vu9+b5Qs+DSfsVGmH7?=
 =?us-ascii?Q?VSNVVLF8KH2db6YQH4ekdVqrJwGq9hFn/bQ5izdL3wVg5LBY9p8l0T3z/Mwy?=
 =?us-ascii?Q?yEddjiGCuuXP6z2EPB9RITKtIUA0DgkrYx5LN8i2MiQfrs6RxaP1R+v0QVnV?=
 =?us-ascii?Q?5ugqLSufacEjg6mmw5wqgqhzC5ZAB3NpQTIt9GS16Dwt6+XJ8lzfHlyMJ91c?=
 =?us-ascii?Q?wYsCHcK6ZaSq9TlDEo0fTseWtBo4l59UL9ETFFxnBv/SPKcxQua6V3QPxgfW?=
 =?us-ascii?Q?x05EbZrxSJZEgmBpisDR0Xa3M0E4HvpcbYrOEqEtzu1j/2sVH9NfmZ55C82D?=
 =?us-ascii?Q?QfRCJcvYgkar9yRme6Ei9XQpnRykHfQYIavyJjTYBn25bDvLBXUAa20n75Qy?=
 =?us-ascii?Q?3xr/LmFT0J02jCnDD8NdU8A8CZZghEnHeWTD2aKIQR9uktlhMWoTngkWKxMM?=
 =?us-ascii?Q?PvCZfI45CVvrDqT25+kxgATzKvBqy61hRlvjxGMU6z2UD/HpzPr2lhjchIf/?=
 =?us-ascii?Q?awiehm896LyZ9RadnQ56r/SF8FGTRKMlYXwz4MCKDmWaKDrQg8/FRfklrhRk?=
 =?us-ascii?Q?QiwKjhf6sq792QIQGDLaXJYem9gqJka2IUdFbgSZh77KC3A2j8AjgSdqlGlX?=
 =?us-ascii?Q?IAlmGp0DALJW6VQ2LqAx1TxajfpHXBWVQIrzP0NVM7PAxBAkw4t76Wucf0sW?=
 =?us-ascii?Q?lCo+x+BfTbj9ZcIeYjLW0IrAqkEqAG09Q50HFrf34Ptb1OKczwMqgKFciIbd?=
 =?us-ascii?Q?z1kIHP8UA76UrAIRCAug22xLnaeUJNxIzD6o5Poly2syCvhMmV0tq5pB2X7O?=
 =?us-ascii?Q?Yrii2qOy2FWSMKFnd+Jy3KIeCYSSoh8EOPDaucMYxSid4hnF3rQcvuc0R0Bx?=
 =?us-ascii?Q?iLw+RvIvVlK/EdncrmQpzlnnZGmsKabqAxwTZ6YEd5/2MA5s03daE8idPzed?=
 =?us-ascii?Q?S5qnW84QlXORislUqVbfd5vf74teWF5vEfD8p56/HkCufwluZo6TNQyZB8cS?=
 =?us-ascii?Q?ah0yf4A4b8MxoHq/g5fK0fzo64//anVvMabZoO4ADjeDZL5KvK7zdUeuBoXG?=
 =?us-ascii?Q?Snz1E+MBPmuDmyebMZ9TApSTCXrZ32FhbcRjXo9iO3avhVAZrDfFr+9R+ySA?=
 =?us-ascii?Q?xMN7ZJBYepoI6Eh6bpeqVhrPjNyli5Oeg+shvR4+ANQn8Q1qUTURvLH3THSO?=
 =?us-ascii?Q?HjbeCjF3yVqa/sDBhSahQOJvcogvfVfHb8R0viHoowYb/afXqRCrwnAoskKp?=
 =?us-ascii?Q?pxgCthLg0SGGG20rijt1IclsHrJ4Q3TGKuw9VgvHtyBi2wkARS6+MCTMyqG4?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c89d749a-03a5-4d1a-f071-08dd5fcb2d8c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 12:00:40.7415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X072/JfUXsA0vIFSa2X1Yiv0aPPhmhfAYUvgltjWvehJdXsmOgELndHlHsr/V8xpgJKMFrME7hF5kSFcrsCVvLVYgVKQ67AjPHfMA6BwFgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9203

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
index 67c2bd409b75..1eaee4832b2e 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -168,6 +168,12 @@ struct btnxpuart_data {
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
@@ -183,6 +189,7 @@ struct btnxpuart_dev {
 	u32 fw_v1_sent_bytes;
 	u32 fw_dnld_v3_offset;
 	u32 fw_v3_offset_correction;
+	u32 fw_v3_prev_sent;
 	u32 fw_v1_expected_len;
 	u32 boot_reg_offset;
 	wait_queue_head_t fw_dnld_done_wait_q;
@@ -191,8 +198,8 @@ struct btnxpuart_dev {
 	u32 new_baudrate;
 	u32 current_baudrate;
 	u32 fw_init_baudrate;
-	bool timeout_changed;
-	bool baudrate_changed;
+	enum bootloader_param_change timeout_changed;
+	enum bootloader_param_change baudrate_changed;
 	bool helper_downloaded;
 
 	struct ps_data psdata;
@@ -680,8 +687,8 @@ static int nxp_download_firmware(struct hci_dev *hdev)
 	nxpdev->boot_reg_offset = 0;
 	nxpdev->fw_dnld_v3_offset = 0;
 	nxpdev->fw_v3_offset_correction = 0;
-	nxpdev->baudrate_changed = false;
-	nxpdev->timeout_changed = false;
+	nxpdev->baudrate_changed = not_changed;
+	nxpdev->timeout_changed = not_changed;
 	nxpdev->helper_downloaded = false;
 
 	serdev_device_set_baudrate(nxpdev->serdev, HCI_NXP_PRI_BAUDRATE);
@@ -913,15 +920,14 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -1127,7 +1133,8 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	struct v3_data_req *req;
-	__u16 len;
+	__u16 len = 0;
+	__u16 err = 0;
 	__u32 offset;
 
 	if (!process_boot_signature(nxpdev))
@@ -1137,23 +1144,40 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
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
@@ -1185,6 +1209,7 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
 				nxpdev->fw_dnld_v3_offset, len);
 
 free_skb:
+	nxpdev->fw_v3_prev_sent = len;
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.25.1

