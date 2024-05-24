Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2102.outbound.protection.outlook.com [40.92.75.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFD986AD6;
	Fri, 24 May 2024 17:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716570743; cv=fail; b=dzLiIgcf5PgWoiXfOKgfTsPnYibHHPTa7O8G3L2mNDPD9T04gV8K8Ud1EcpGdMx9W+vwlHaPLZr9pwGiKnna8pLVObjqdB1qwguUKWF57h8YssrvXgrTPToRGZtnNaDVoP+4w7nLx0oSI6VhDVkkLcnmOzg8d9cKe0KMCXi0K9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716570743; c=relaxed/simple;
	bh=1UXLovxeAgzSjvDc2yXWbJPeeNh2gr6RKoMG0xB/eG8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N99+ezGUxtTfRCcLcVoH1PwArSIo30lTORrLQ1JxlLXkZZyXUX0DwV/0rxYokSACn3elUGlmBBRhFDkUExa0tcgaCsvuCeieCBkkeAIgBp3TawN1h6X4N+An4VmoFpADdy5/ELcUoPNhNasKnU93qzbw8lFq++sRvdkC76kqHz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cQIdqI1z; arc=fail smtp.client-ip=40.92.75.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cQIdqI1z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoQA9szjuhjkDUzJk7r9rlaNreBJ9UGCVA9CrAcNJqAFzfb7wBYczJ3LxFnUQZG0Wht+IPFERDL/QUyuSY7wHFhd2vWqynX/QZRUIlc4vsFLoQP4asJp4sqdYubfVDL1H/qtARG0T1PBi8aCI7ILuGjCdliW9NL/xs1QmAmz3JqQJL1FgEzxNZcAX8KzCf6F29gVMhUIq5y0OmGWHCUmcxzyUmux7u7pbCFcsH26FQgbzoePDxz6zUS5zYV73pD9MwYfIYYb8TEjqqBUUWqqBdHjDLv2EU8RLXaDMfKAfDmw3lEBMAVv+V+s8H83zzJvM/kKxnofNoTtGZYNElXtgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgKf7j3gWUPnLMX+JYaBNqSXKLBikjVcbfxnTjduWuY=;
 b=gCpEgiSFsOqDt4kh8CzQ6mLQd8cb2g1b9zB8TfyGpOjqKZMrClroKDBZpts6kCGEy7aYruF3PaEZs321CPdPMxaGJOq9R8uTsU8lDHtFskxh8MTJcLaZ1Ku7wIO5zKD9BvsP4a48y1MqlW+csi1fbY8JE6DjrS7iqrreUdSp9HlDVcdMI3qIsFLSIz56+01cTizqLTK+ZdVUFGcsJoRNhINSSN+WUj/WtoRKGW8f2sFQaZbt3SKwqFIyfMsd+On4fCDT2C4ERO+68ctbtO5PLBlDYgrbLRB5oL4aODFR5zwzJkRGCtqcXM4rwnGzYwSQ6gLXsx7xY+IACdbbvzp4VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgKf7j3gWUPnLMX+JYaBNqSXKLBikjVcbfxnTjduWuY=;
 b=cQIdqI1zhGTZBm9WD42v8GG1FD25ncwyfPr14CMIi/M5qUY9n9Gld3eY4zjtqEkShABzSeDASgWOxGKtqFTFoNVTcjsxTh/6+IBJED82D3VTxzhTczc1LbV4tKb41aAjIGMVvFgSF3uCf6lt3bG3ynFQTxV8aPfpGERVXCWlexqDtgKBYpFbhNnuy0sNETvTRdlzEjZrw6caXKL0GVDICf/u9IuEJDxeNzKzNjspNEieP5Gwl4x0NUHgIG5oc0/Y1Rpd7HpoMBtHVt1FpmEsCy90L/giTx1THgiCm1wL7uXzVjoNmAVB/042+5HaoV0AZU6Nm7xLJsC2xbd6txZmAA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PAXPR02MB7293.eurprd02.prod.outlook.com (2603:10a6:102:1c6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 17:12:18 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7611.025; Fri, 24 May 2024
 17:12:18 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] Bluetooth: Use sizeof(*pointer) instead of sizeof(type)
Date: Fri, 24 May 2024 19:11:51 +0200
Message-ID:
 <AS8PR02MB72373F23330301EA5B897D6E8BF52@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [B7y2UPhLhJelmJCbGHhwU6f4xaI/4ZGC]
X-ClientProxiedBy: MA3P292CA0002.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::17) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240524171151.15303-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PAXPR02MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: ac7af50d-89d8-404d-0fcd-08dc7c14a547
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	KF+VNRE++xU7tipDWsv8gd42QyHSuWkUUGMwPX1ylIWxQBpTGSNufkZuDdn6SJEJG04YkaOe8tylc4yBxDGl1tt3JjA9KLOX0rgOiXEW9yg4bUZjfrRQwdpUqAfSfS8jH1U83IVlqzVAC9J1z+kyF4rnrPIi5u1uaRNnyv1pIDJ4IEGwzXz1nRbV4kbryJI0KAvaFsoJMwAHqXvgXlq61B6jt3sS4dtQU8YyfcxW8N/2TIZ252nCbjrTHwHeVh5F7gpgNRVkF6AMp6OybT7cetEgDZ+YJ+8e+3hAQgUhc8ZJGNdHdtHCH3KhCwoxxm7HP+0/hpAYT5sAGVGRGNMkx8yVi4IJKVJXwqUsZqIJ6EMB3mq+Aas++da3iOtdwfjuxvYbJQfIDWFm3QM+YRG3rMDiVWmubTZCrh67DHDQJrHN8oOVzoruOiLgQeajRkllmXQfj+G5gGWaM2MEC4AqerBr4EpN6DO0yf1c18hb20d9tH9W4CqeHWcb8/cBEW7lyhFhW6RmzNXy/HCgThPMePeTLJd+FcH70gz2xxK9p6lAolSREzS92xaC3NFUCjvcPX5AcrSkMIq7S/7VwxFtS8WYB9qyLiuKhetZdvR3Zma6D8dl+oWQdxNWbJa6hFSg
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bOmJOFYIJ0gCOIYedNw9pnzTdChtoivx2ly9jB39vhAK2kjqkfc3yfJCM+04?=
 =?us-ascii?Q?zMl9KhNji8tq6/n2xNjiMioW+Szcr5U4tc2YL4bIGuL1S5M8YzC1Y0ARjyIU?=
 =?us-ascii?Q?HI6zJ5JIUiY8MceSk0MtvvYA23Wk/+BNHcz1hSZ4RJ3IID7XKw+NPl3o3VkJ?=
 =?us-ascii?Q?7TodeCGuyhh6BSYdX0qbtc6+E1mrVlDWLVTuZ6sAyhOZyI6XrJrz2SrN7pGt?=
 =?us-ascii?Q?9Kc0JKM95qhL6s21DxH1cpF33GvtRq9saxxSOfENVFoLw8RrLAaVXm6CVAHZ?=
 =?us-ascii?Q?BE1Sgw4RYh2jvA6q+52t6HUJaTkXqXRNufMMc/KNDNpBb2hXsU0Gkz4JTC1g?=
 =?us-ascii?Q?95HcepbPWoF65kyYwnxKBQ8MXrURR1PXALK3V5mkZR1x97miBzuqV0P3QyON?=
 =?us-ascii?Q?bwa/1FeXKBcnN3YGqI7TqgILUrVPEtEkHucqZpLdpXhjyCYagP5kCiLsXu6v?=
 =?us-ascii?Q?Vkgq84MLsYxlW1kLJRjWh7fzooTlHFJA2ryy3xvxbgsOn06Xix3LBCShO3PT?=
 =?us-ascii?Q?39F1h6/bdhrO3mA/T4iIOvurJnBUeVNZGYnronR///FvMJNbI7eCLl/qmtpJ?=
 =?us-ascii?Q?qPOaewYlPSLf45WlT82fypVtwoa3K73ZdNhE5aLBN1OYjVKZIi1DMjoRfl0y?=
 =?us-ascii?Q?AIE++DuQyr2iEKWC4Bc5yBh+7ScUfAPAT30YyMeHJuQag8QBlZNcr0uOAAgY?=
 =?us-ascii?Q?VFcR3k+wSnY/OA4rggmkjYkAFOpIpJ7f8Gjqp82yVE8BhRCGWAJJTAqwsAEo?=
 =?us-ascii?Q?nsKEOGjEKw5s3f4tZeGTCWVMClDErsS7aevc/xI/uylnVixuKbSz3MJbBLMU?=
 =?us-ascii?Q?1+A/Cj0YBLHAOmF3A6PubSc07pr2hLliBBlAxfUl1liQoFU/sxNfKegggb+V?=
 =?us-ascii?Q?z06eCDIa0Y1zDxr8RpztmSRhxrwYi/+C40xbI8vHnIeQNdQGy9OCxfvO1vGZ?=
 =?us-ascii?Q?o3FVdwbVt/3xS9U/sXUvaPtBXhLGWCCV4l1k/EPoJaKo/yodCmHHRoIQoVfw?=
 =?us-ascii?Q?fsRwlGHEMQR0hhCvGXxUj98im7givrrKJV3Y/yLNvsOve5gaFXkSMmV9Ortg?=
 =?us-ascii?Q?dqz0U+UhPg22oyP7ZViwtADKOM1QhX83omQy+rk6Y7SYrDyfERwYUmtKTvb6?=
 =?us-ascii?Q?H5QnhWfdIxNjtR0v5yMGLCxU2HCSqi7TRcC5BvW8BMIclQ8SqdGhM17+vEEi?=
 =?us-ascii?Q?xMsBD6bDwNVgx9UuphbJPuNCj/ygE1cq+psvFnCbFzAiwYFq9qy0q2li2BXz?=
 =?us-ascii?Q?NrQwCY5jh/Z5/XhK1syv?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7af50d-89d8-404d-0fcd-08dc7c14a547
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 17:12:13.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7293

It is preferred to use sizeof(*pointer) instead of sizeof(type)
due to the type of the variable can change and one needs not
change the former (unlike the latter). This patch has no effect
on runtime behavior.

Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 drivers/bluetooth/btrtl.c     | 2 +-
 drivers/bluetooth/hci_ldisc.c | 2 +-
 drivers/bluetooth/hci_qca.c   | 5 ++---
 drivers/bluetooth/hci_vhci.c  | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 4f1e37b4f780..f2f37143c454 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -811,7 +811,7 @@ static int rtl_download_firmware(struct hci_dev *hdev,
 	struct sk_buff *skb;
 	struct hci_rp_read_local_version *rp;
 
-	dl_cmd = kmalloc(sizeof(struct rtl_download_cmd), GFP_KERNEL);
+	dl_cmd = kmalloc(sizeof(*dl_cmd), GFP_KERNEL);
 	if (!dl_cmd)
 		return -ENOMEM;
 
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 17a2f158a0df..30192bb08354 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -488,7 +488,7 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 	if (tty->ops->write == NULL)
 		return -EOPNOTSUPP;
 
-	hu = kzalloc(sizeof(struct hci_uart), GFP_KERNEL);
+	hu = kzalloc(sizeof(*hu), GFP_KERNEL);
 	if (!hu) {
 		BT_ERR("Can't allocate control structure");
 		return -ENFILE;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 0c9c9ee56592..384a2bbbf303 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -569,7 +569,7 @@ static int qca_open(struct hci_uart *hu)
 	if (!hci_uart_has_flow_control(hu))
 		return -EOPNOTSUPP;
 
-	qca = kzalloc(sizeof(struct qca_data), GFP_KERNEL);
+	qca = kzalloc(sizeof(*qca), GFP_KERNEL);
 	if (!qca)
 		return -ENOMEM;
 
@@ -1040,8 +1040,7 @@ static void qca_controller_memdump(struct work_struct *work)
 		}
 
 		if (!qca_memdump) {
-			qca_memdump = kzalloc(sizeof(struct qca_memdump_info),
-					      GFP_ATOMIC);
+			qca_memdump = kzalloc(sizeof(*qca_memdump), GFP_ATOMIC);
 			if (!qca_memdump) {
 				mutex_unlock(&qca->hci_memdump_lock);
 				return;
diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 28750a40f0ed..c4046f8f1985 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -633,7 +633,7 @@ static int vhci_open(struct inode *inode, struct file *file)
 {
 	struct vhci_data *data;
 
-	data = kzalloc(sizeof(struct vhci_data), GFP_KERNEL);
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
-- 
2.25.1

