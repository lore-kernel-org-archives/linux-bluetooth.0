Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6184F3624D4;
	Tue, 18 Nov 2025 14:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475676; cv=fail; b=WwSkoLQ1ygLvmHxoQkhx/DquKzeFwQBQchxYrmqs19sNu2vrnCi79TJwGMpCzVX2omGKAxDv13FmWfA/Fa/DpmG2G6ztPssoCoH0WnGM/YN0bCBbzQX9fL7e978/zzRoXwFIOYO1s9PVrKKRPID2IJJnHXzxBcqVSd9buuWQ+P4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475676; c=relaxed/simple;
	bh=opNB1BubunudojSmXoKko2msvh7TJhk6IGQ6c5/amNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EtAlWuFsZD2/4/B4uwKjBt6GsRHHuMIAt4HpR5K7xd3mMw4/bh9Iym7v93+2QM5KKwVW/fy4fTa4BkiJRn4QK8u5OJRhK+qVr8XJMWLW5SbX/YcP3jbqBLDd4HnQvyUHD05uvyNkDairnKckYyoU/jPAcHM3N5qXvVL9axW7RjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X+D1QdaH; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X+D1QdaH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0mScU7PD6VwdKEkS8MSMgHKpctqGDvXhwIqlzynrgN4m8/+xh4527DUyHa3+OIR02LNDwwkmAViQud0inbIR+ZXUsoDLmZSyNqAMPn40VHizzvMfBds8ddIIn4Ws+SshfJBiUJDrXoABHMUwZ6yH2rO4MzW+QX+4+WIeY6essebOOafu5tW3Q/9XI3hYTNJbSpd0bww4Qlmav0jUdKqSZ7evSlMk3ZOpQG2YNpONNvAKlI74rn/wsNrrpaKN/jjJd385KNIMYz6dEQIvF/8go4jDhVVp13UFV7uRFsMEhQG28iRXRBtOJVjyYGOW26wC8TuC59G833vz8NfV7t9ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Csj3wiJVhQrREZznIxfuKMt0hP4fTOZZSylqn1Zl4KU=;
 b=a8QR5H4u1+9GghZux/Xu5lJxtU0laILWamsiLW4K5+9i30JN5h6G2zvYe3yv4CSIkdcNvnoCi9EfM80zuq42aJLUBMzXrIKzBU/tYbXqXGdRnb0Rbrt2q7rlBb7wSDMhlDvdpa/p7Whakc0jVHwUyee0WxfsH+Wd3yKBuugax5NdFjMnkNpZhrwNOAwJMh3QPSm0Huv3uzLiLme3a1iLl3V3ZVdZ5MqhMZNiPlSGu/0EnVX+E5qFaGPOfoUxBbFz3ZYhsxldeye9quXu2oqVAFDk16Pt2jRCZr5Wz0rR2qIom03XvwUYid++ImTr0sQzsSawy1DKDZsLarFofuNhDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Csj3wiJVhQrREZznIxfuKMt0hP4fTOZZSylqn1Zl4KU=;
 b=X+D1QdaHvWCYUUbcRcJ/Vp2WP4TnYK9NXytCTnBphe1irhUCgc/7Mv3/yqMazVL45FEBnwiNBVWWATCZAQeCTvvssnRIyhl6bqJJoTSyIQEp49J3nOe/tEfU5TtTeaOHlDaRQyCQvuxCqvBZZdxiwyVoUNEEWtZ1I6Ka42pwsKGn4CKdG4ivog9IhalaPmJov5/HsRoAhNQ91SUZALf3l/y5NnHwqg9cEHYGaUCMX15RFNnJDF1FhNdHktvdCiByIn1JBJnan7K8fS5P1Z/hL9U45omn2o5w22LYm3ZG5/x7/8BKo9Pa25pjSkQiII+MAOPkR//HGHFJMKUHqxWpWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB10179.eurprd04.prod.outlook.com (2603:10a6:102:460::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:21:08 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:21:08 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 09/11] Bluetooth: btnxpuart: Add command encryption for sensitive HCI commands
Date: Tue, 18 Nov 2025 19:50:22 +0530
Message-ID: <20251118142025.1982263-10-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118142025.1982263-1-neeraj.sanjaykale@nxp.com>
References: <20251118142025.1982263-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0036.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::29) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PA1PR04MB10179:EE_
X-MS-Office365-Filtering-Correlation-Id: af09358c-ecfa-4ab1-cd03-08de26adb735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0qWQup1J3qgUHKZETDre12SCcE3Ipm3GxyyuZ7fhd97XPXAPTmYSh4FDywDW?=
 =?us-ascii?Q?P2iGmpKSp/LuFuh3QsgfEJ+X5JQlu6+0kPrPSyBhDnn7bnyUQzHvflv6D6dB?=
 =?us-ascii?Q?sCgfqxG98MN7FKCGKSYTptdNcFG50l3cdLXRHRoHcArnUQtrLsbIlVh3FxiH?=
 =?us-ascii?Q?I2rsWb5iac1tp7vbeivvN0c3merudkdnELcBnc8uZdIGdiGWmkpDcMOF86Ha?=
 =?us-ascii?Q?I2IbMS3y3aZI5lmqtKmw4G6uiofCV9A7XbSd0OtG/L7UwkFwA+rJBUN9HZuy?=
 =?us-ascii?Q?/lS6dJ1YrsBaxNVy7WVZWgBD7C2sLK7apFYb9IyJ/1itKCQy6L0wP2THkLvg?=
 =?us-ascii?Q?fygcJ1nAfhPXCSQu50cgZuXkQ76NjuRpObagQ7XRBh6RtIUXFhq9ULJrbJpV?=
 =?us-ascii?Q?+xf0JGMYuX2StHRAgfOWElLBFcmRohspp5bMqkxR8tpizXU2aPoTDcnUMvRa?=
 =?us-ascii?Q?KgUDOBWWmZt8Y6mZtJYoU1YCyB2Z671M8CiQSwNg31LVBjfVHguJe1NPRvLL?=
 =?us-ascii?Q?/f1F+dK6wlJvmVkrKQVLDVJOGmrQTagrSrj7KMhPV7U/AK1+7XajTzSAXtwi?=
 =?us-ascii?Q?Izh7PkiUSyb2mws8Z+7Y2+vQb7M1VUqB0GFCr+p2svJfOlx8st2K/yW0u3iE?=
 =?us-ascii?Q?yqRvCdOnKG0PgjJvzS8C7HEzfle83bVt55k8/qjIam7lihVssiztV8tP4HiM?=
 =?us-ascii?Q?QrL23nd4ro/R1jBcPlTXTwhUsLWx/mkYf0+CALD/kEa3ZKbGAjuRZS2VeBi2?=
 =?us-ascii?Q?bQZ24S25ql2ISOg5jA/ANKg9NB6TAo+LRiA15itaS1TMsvNRNoSH24fnlWS/?=
 =?us-ascii?Q?Muc8B9/PHuVBF2v7OibNlRSIn7w9zniWhcRnBrndMdYt7jANWV5VtgFlBjAW?=
 =?us-ascii?Q?3Kw+oe+67mmGkQYyy6bhDox95eKYc/v5StxYZUSlt6cu4qSh2Mbv/oYcoWxw?=
 =?us-ascii?Q?wdRPVRTgDZWpgF4PN3DNgIKDIunR247fkSpzuyY9Rxd9jVwDd6a5f4HvTMxw?=
 =?us-ascii?Q?WpMS1UcAKzX3wlMQOsWqqgexAIVTRjvqVYpjz8oyTuCbrZYMSVMFs0NFIaTo?=
 =?us-ascii?Q?c5HRkUTM9L15qOj/koZ/zbvxbAWrxK93O4R1jgEGa+Ez8hoH9vFaOXZz3vBA?=
 =?us-ascii?Q?1oyfeTk05Fej84sr86MHl/yXUI4nayK42kJjDbYfKOAqtDyaOXd1Ox6F5/2y?=
 =?us-ascii?Q?n0210XsL72beQ5dTkX4VijxCIgJ7hIaUkjIwitwR5g+AKF8bmDgtHFN/Y4uN?=
 =?us-ascii?Q?PpnA9vP303DA9zZzEC76moLFFFu5nkWJYwz5WxmxiWRO4p15RTej0eszPT35?=
 =?us-ascii?Q?nop0Th8zuzIqsxZ/FwUahURmAcRuh4zs3valQrg/eFmCT4avie2rXzmiavAE?=
 =?us-ascii?Q?HMyLM6htLhAZYgJaVAyD220KZ/NEpYjE5PnRxdZtjlVUIhw7OjKjtV0lSuYr?=
 =?us-ascii?Q?SPiAaEyZx8kQK0XGpKgxyrric9E/v8aND0tWKj42KRLQwbMl9gED1GhjGaB+?=
 =?us-ascii?Q?XfgJy4qabdb+1pp7h1w7v3m50ksmMr6J3jTd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xrd9vhxXlP41Q7bs7mkgTmiLi3Rtuz6C1bzfwZtbZgVRBEPwsPVruR6udy2K?=
 =?us-ascii?Q?3Pc5ZZB+5YOYk0K5Too/QCtxS9peaLFYEDNQ2ybNmmySm1i0Gnm9fkY46SSh?=
 =?us-ascii?Q?+Zr8UD1usKY/yl7ewqDUsObtNrm0tBtbkFL6XPXyxV9QDIPWqvqHwoUJVH+s?=
 =?us-ascii?Q?buAxh0q895mm/YSqSx1GPKUsOLDg4tFfjKlixdbgIiF83wMwpXzubQizhSuu?=
 =?us-ascii?Q?tnhncVofQ9aaMJLLOzng42Txm5hqePB/FL53FXJd0KPuN9rAZcEfKhdQt4PV?=
 =?us-ascii?Q?bT3+xoFH5/dSLLX2AzCtLmnI1OSMY5mx2DmQqMPz4EEpRLQI2eqWkko1VyXj?=
 =?us-ascii?Q?gywSVrsNzT7bFRzZkvGpSaRbkDwyRRtZL9lBOhlVaj7Fc5thRye6wZB7hqXP?=
 =?us-ascii?Q?uoyP0iX8L4dP/44iwdZ1o/p2CFxCrFJxFG6ETHbNPUskXdQuwaHy09iGm+X5?=
 =?us-ascii?Q?mKFLlNG2wymqE+ycWPvipWQ5HBHhUzn9N4I3ad3pYpFzcOZq2cisF5Mzk1+L?=
 =?us-ascii?Q?+zS8H1OGRqDVKG3O234ZDLCUAIT2OdZXCkd0WY7kpTn2441YrV+sLJ6sYS2/?=
 =?us-ascii?Q?MvS+x/GlUVuWdEUvEhsxi/TDt3ilOH+e1m8NbXc3kai6xxhXmMenJ9oWbiyJ?=
 =?us-ascii?Q?EqO60RmtNHPSJU4zFkYJgaQSl8WBkZqWca4EuQz3T9MtJ7Y8kfoxICdgE29/?=
 =?us-ascii?Q?RtSyD9kTbfjVbvp+5jlb3R3IEzMuVbrn7hHaXnM8QfZIluLgd51Pv0oaToXb?=
 =?us-ascii?Q?YYTZ53TnCZcw7jZtCUZPQhA2c9Ksyj6tsk+SyFnyPJe1mN0ZpNc/9Wv3CWuM?=
 =?us-ascii?Q?izQPDBg6CyXrcX4bZIvRSQssF0vniteQnvi93nGG8AA5vphA4uQbOT924GWH?=
 =?us-ascii?Q?W5IsplBfUc5O1oys8tsFRpuFLxnWgFXOoqTAEZJP0wmomb7Y/xfEpenlOv4r?=
 =?us-ascii?Q?vlEPTQFJ6dl/EvyadBURR6VVqTnbb3DcoAlLsaeIGHy5cFV6ZhLBQTcQGx2+?=
 =?us-ascii?Q?y7zZ9Gn3fnPJRMyXN7vWzYtaOBSi35ZaDJOrKSwrblg1l5FbdUK2MvZZPi6o?=
 =?us-ascii?Q?V4Rgg5yk6egT+x1ERh1lpiBx9fWR7fPB7ce/2iZY/zmoSWMrXbUhuQlpOa6L?=
 =?us-ascii?Q?sNNc4PI0TjUQN88vZpitRctuketN4ocTcKz4pGA0HPCKe6T/+aOtaW0f7Urr?=
 =?us-ascii?Q?NfDh8piNEmLFyr60BhZgr00BrgzW99YcR3scvs6vI8oaSKCf32+q7Lumi/Zk?=
 =?us-ascii?Q?DJruHeIhiJ2q/cCXkk1A5WVjEu2dv2OO3e5v/bksV8SUKAXZ0HJ8AgjfYpCv?=
 =?us-ascii?Q?gpqqJ04klQ5H7yCplZmCiE/ZweXmv08fN0X2uZXsbvkDJdap/PyQ6FDlJY28?=
 =?us-ascii?Q?rBESmM+1gYT3Rn6j9YrdVdpr+jdgDOrSnlv1a92Huyo0GkcueA94Iu/Yjn4a?=
 =?us-ascii?Q?fwNMfX85vg03EMc/leqvTAtIZJAF8DUnsqPIDQJxHKi4xNVsYDwV2LCGzXyW?=
 =?us-ascii?Q?zbgSXOdnw0HrYDFBTC0qC/0Jlf0nPJfuk3pU7lHezjc0RxM+soPBNU4WQS88?=
 =?us-ascii?Q?9m0jgZZp/s3mFuW5qJ8jWOenJUPdWrAEJn/LmbrK3KqzKdqZJOiDWZDMg6kP?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af09358c-ecfa-4ab1-cd03-08de26adb735
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:21:08.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6nIeuzgJgO+UaudRWPTAJW6wN6BDSi0BESiAuTUB4dIhiYgWON4kLrSAtRQYoE5S3Yz7lDQQxWBvn8dI3X6Q3XUCVndEIH/BqhN5LxtrRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10179

This adds support for command encryption for sensitive HCI commands when
secure interface is enabled. This commands containt sensitive data such
as Link Key in plain text over UART lines.

AES-GCM encryption is used to encrypt sensitive commands using
encryption key and IV derived from traffic keys.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 82 +++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 4b03b0321e82..452fff651d82 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -159,6 +159,7 @@
 #define NXP_FW_UUID_SIZE		16
 #define NXP_FW_ECDH_PUBKEY_SIZE		64
 #define NXP_FW_ECDSA_PUBKEY_SIZE	65
+#define NXP_MAX_ENCRYPT_CMD_LEN		256
 
 struct ps_data {
 	u8    target_ps_mode;	/* ps mode to be set */
@@ -226,6 +227,7 @@ struct btnxpuart_crypto {
 	u8 handshake_h2_hash[SHA256_DIGEST_SIZE];
 	u8 handshake_secret[SHA256_DIGEST_SIZE];
 	u8 master_secret[SHA256_DIGEST_SIZE];
+	u64 enc_seq_no;
 	struct completion completion;
 	int decrypt_result;
 	struct nxp_tls_traffic_keys keys;
@@ -2681,6 +2683,72 @@ static int nxp_authenticate_device(struct hci_dev *hdev)
 	return ret;
 }
 
+static void nxp_data_calc_nonce(u8 iv[GCM_AES_IV_SIZE], u64 seq_no,
+				u8 nonce[GCM_AES_IV_SIZE])
+{
+	u64 tmp;
+
+	/* XOR sequence number with IV to create unique nonce */
+	memcpy(&tmp, iv, sizeof(tmp));
+	tmp ^= seq_no;
+	memcpy(nonce, &tmp, sizeof(tmp));
+	memcpy(nonce + sizeof(tmp), iv + sizeof(tmp),
+	       GCM_AES_IV_SIZE - sizeof(tmp));
+}
+
+static struct sk_buff *nxp_crypto_encrypt_cmd(struct hci_dev *hdev,
+					      struct sk_buff *skb)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	__le16 vendor_opcode = __cpu_to_le16(HCI_NXP_SHI_ENCRYPT);
+	u8 nonce[GCM_AES_IV_SIZE];
+	u8 tag[NXP_ENC_AUTH_TAG_SIZE];
+	u8 *enc_data;
+	u8 sub_opcode = 0x10;
+	int ret;
+	u32 plen, enc_data_len;
+	struct nxp_tls_traffic_keys *keys = &nxpdev->crypto.keys;
+
+	if (skb->len > NXP_MAX_ENCRYPT_CMD_LEN) {
+		bt_dev_err(hdev, "Invalid skb->len: %d", skb->len);
+		return skb;
+	}
+
+	nxp_data_calc_nonce(keys->h2d_iv, nxpdev->crypto.enc_seq_no, nonce);
+
+	enc_data_len = skb->len;
+	enc_data = kzalloc(skb->len, GFP_KERNEL);
+	if (!enc_data)
+		return skb;
+	memcpy(enc_data, skb->data, skb->len);
+
+	ret = nxp_aes_gcm_encrypt(hdev, enc_data, enc_data_len, tag,
+				  keys->h2d_key, nonce);
+	if (ret) {
+		kfree(enc_data);
+		return skb;
+	}
+
+	kfree_skb(skb);
+
+	plen = enc_data_len + NXP_ENC_AUTH_TAG_SIZE + 1;
+	skb = bt_skb_alloc(plen, GFP_ATOMIC);
+	if (!skb) {
+		kfree(enc_data);
+		return ERR_PTR(-ENOMEM);
+	}
+	hci_skb_pkt_type(skb) = HCI_COMMAND_PKT;
+	skb_put_data(skb, &vendor_opcode, 2);
+	skb_put_data(skb, &plen, 1);
+	skb_put_data(skb, &sub_opcode, 1);
+	skb_put_data(skb, enc_data, enc_data_len);
+	skb_put_data(skb, tag, NXP_ENC_AUTH_TAG_SIZE);
+
+	nxpdev->crypto.enc_seq_no++;
+	kfree(enc_data);
+	return skb;
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -2884,6 +2952,20 @@ static int nxp_enqueue(struct hci_dev *hdev, struct sk_buff *skb)
 				goto free_skb;
 			}
 			break;
+		case HCI_OP_LINK_KEY_REPLY:
+		case HCI_OP_LE_START_ENC:
+		case HCI_OP_LE_LTK_REPLY:
+		case HCI_OP_LE_ADD_TO_RESOLV_LIST:
+			if (nxpdev->secure_interface) {
+				/* Re-alloc skb and encrypt sensitive command
+				 * and payload. Command complete event
+				 * won't be encrypted.
+				 */
+				skb = nxp_crypto_encrypt_cmd(hdev, skb);
+				if (IS_ERR(skb))
+					return PTR_ERR(skb);
+			}
+			break;
 		default:
 			break;
 		}
-- 
2.43.0

