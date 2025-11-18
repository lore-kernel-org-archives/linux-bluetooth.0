Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDBE363C71;
	Tue, 18 Nov 2025 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475680; cv=fail; b=JHDqyJMJtlvp8Fzsred0F0XShhWXeF1wt0kMA5+Fstsc5uap1bgVeIZ1qzdh3YioBXEoiConkyuA6DAm4fP5NhzO5g77HMMPIbRaUmhz5S+pvZv/Q39kbl9cow75Ci9/bAVgvwBVK5qav/lt1GZvihwK6y/aDJy/XsiK3OpQGKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475680; c=relaxed/simple;
	bh=Gu56MVhkr79+EuXTu5e3gehhC4GgtrczjirM4+1vy04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBGbGuwpkAPuzQBMN9dWkFsHmFOzWtbh9zXRJ0pU8xlGe9XvJdiGYdeFDNRoD2zM1JIkzcm2XxtZKNZdUvjHBFsHrM07JP9HytwfTlziKEvzGMlGudMDY6sK2e++lyeFwH/BByrp7b9z0WLafyX4hxcVj6lML17upOghQQtpl7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OgOMcfK+; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OgOMcfK+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbCxsYkefZCjGjyWIogvVie6Urfp+R9sYes5sOZxhTlyxLvDls52p8+Torly/m/nk9BYX1yb5Do1+B5EnMfGHzgKy0LEnojTEI/q71cDA6oRkk9uX3bLaBswwwE/LW7hSV+GbbdDD3gHnAUKvWgZIFbE8aT6x7z6uPCOJONO+xvDf2bLYJXVjE0Td/ZOrDsuGyK2VFXX3cVsyppHLMNsrUlr34GzfdMOcTkvMCc90T/hxnZhKl4egbmSOUdZXG02+ckCzxE1+1dz+aoUXvm7b00dTRstcUP/jMe8l4qTd+2uPvyXOw86UMdy19sTErLoPGlCr+K6rh/yVR9Ktw92qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ku2nnUwIPY7ArI07ARGPZ4faDvCPWXa1vOG4aXgQcc4=;
 b=PY3wy8SE0MbbJw9XIvBJNMyO+2t+G9RAcgQzq/p2Bq40ImPDGCrAbahUKJv7tWD8OEz36nT0+1EMEhgqNQ8HaybHOmS/ghrXObWvRi2Ypzy4wSQwb1OX5mp4crpKwPvmIdYFFFOgLV4car9QeenmcJI+14fXd0W2Qqtw4Gh7T1EOtXPdCP8tnEjehoQ0yfJmBrPcHq7DhN/h5Z/U2zSlnlFaUQmLrPS1iAWEPXsttHIEsMTaMdfvP4TpNT9eXpjW6IuK33snV74XzmQVjcJ9kR12o1PaUMNDZqx1II5uX6ycZCikzy2cQj7mRpX2RjX6ofFpdKvqhSpWN0TBCWafUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ku2nnUwIPY7ArI07ARGPZ4faDvCPWXa1vOG4aXgQcc4=;
 b=OgOMcfK+MVnZddEH/ocO0lQAAqGoC93fhU3ijyJYXRxsLajcQFp3IJgResknU5woSJXKTRWPPNm9B/XAO8jlX+4QAkhnRsYV+/QZ86d03HFWyJE8hUH/mbUumz1ePP3XV+5g5MNcpZBE0Ccht+CbWftQAUOtoxfsPTkKBJBMk+L1FSFA7X3yqpr7xOk9d3l0V5saZJmtGienFLYI6RBl6K10JFRHOtxLrrDeNCtFIH+oSpH1NRChm9uahWBMTtBa7uN1K4A3OccGGqdxaAM43ZSLkYpWYd5+4N78ArFir7kLa+3Y/YCOxY7J1IHqMqV8DXh8fvrH2hmEtRHGnpwhNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB10179.eurprd04.prod.outlook.com (2603:10a6:102:460::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:21:10 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:21:10 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 10/11] Bluetooth: btnxpuart: Add encrypted event handling
Date: Tue, 18 Nov 2025 19:50:23 +0530
Message-ID: <20251118142025.1982263-11-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c2f6b5d3-1a23-465a-6892-08de26adb8b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?URg6ZgKEfsPp56XxwbgJrL317NMTcIHjii6g1wEayZolB0wOXAPwnjw1Bn3O?=
 =?us-ascii?Q?LQvd/0IS2xlANF+3QVcjv2x4XKs4g+FC8QnRSCaoa1D0OUwFRlq5vkt0KROF?=
 =?us-ascii?Q?Ox1SWDLJ2VtmxNrnTL3EFxcO/pw3g+pESoY7qscrcr3edlpmqw+S6J78GkjP?=
 =?us-ascii?Q?/mftd6/ph1onE8HZ39xlZf5GXIv63V6WBGnhKpP9c8nohAcG8HO3VuWZzJZr?=
 =?us-ascii?Q?xdZ4+5eS1bc0Lx+QFPyG5qutUvOWRaLLxO0RPhG+aWyxVPwRkLGx67DsbKDL?=
 =?us-ascii?Q?KuqVykvobY+A6v24BkShjIjDKvC1pnvp2VsJPDQCJ1YjZ25lJDJ2WnoqBNKG?=
 =?us-ascii?Q?pJ4zU7s7bPwhCeZPLX1IX+cQfwH80GELQD6U2gCv5PjZsHDcSt3NC8imEM7s?=
 =?us-ascii?Q?NpFOMLBO6CBrYY3q8x+VcqjCNcyuXf1c1bGn66ZUzD1TnlQNSc/v0hbXDkpI?=
 =?us-ascii?Q?KqOx9gUgfM0UzgqbfXTOPE9WY/spGXdqdVkA0qgEXhU/h7hRaXRTelYlhsE5?=
 =?us-ascii?Q?n+Ik99EdaO2MBwtBJi1ZAxPMStCFFWgm9oXfNwREfo41ERH7oenITbxrpgVr?=
 =?us-ascii?Q?h3X4y8pEvHrwcXxlCFfDkTgj1vbPkcdd8SY3GQ00pRl6iqojQMHeJ+Yqhjru?=
 =?us-ascii?Q?jYaMNnkCQcjN8kxfZjfpPp00ncNGg3oUcyudiwMCP+JG5W6NCiFgtc4wmOQg?=
 =?us-ascii?Q?5KkvkN4FZ/WgAubL04IgbwRB9389trHowWtjhwF6HdV1CvA8vgCTgtHwiuvt?=
 =?us-ascii?Q?IkkKjOCAF8Py0NPulzf+jQTktjV7Lvp2Q87MPUCWeUiFCBc0WU+wc1pkUf03?=
 =?us-ascii?Q?3gzyosHC362I4dm84Zo21+mNASn8blcJuXRPPvVWLhPu5ZEiJnr2aET8MlnQ?=
 =?us-ascii?Q?D1mJotZohFlhwdh5kjYZ28DqHQ0jf2Afy4Jq13H3VugRc1wAATVfo20iz/Bt?=
 =?us-ascii?Q?G5fjxJk1YCrLI6ziBPJLtUODEGOswRnB6rFsmLAs1zhzqeocudfMTCfewIuU?=
 =?us-ascii?Q?1zGYaTtohRjqKitIzFXYGl73apNm52WZvmH8/e986iG31CYBQRriHed8G97W?=
 =?us-ascii?Q?XJTCLvMICa1kDxR088rFvaidJiMw5WfKbSooPIEXY/PNgD/TSKpZlA4pIgjs?=
 =?us-ascii?Q?HzZkEQ4VGFLwpATq12TweZQGt5AfjdCmd3tqeF2GVDDUbrAf1+OrFu0F6lcB?=
 =?us-ascii?Q?JiRQMOA8ejeFu24ZsJtn5c5fF6U1kKF0TdJxyLxpjk1gc98/w2PjJe2trWAI?=
 =?us-ascii?Q?SO4Bjrv2dIe6mDFPcAXzhzBxHSN0XFqXQDTJUdbyK8uszchxbd8jMHOOfVDT?=
 =?us-ascii?Q?D1LbeqQ5AEanIBPHGn7cNS4KTgI9MGk59mJnryJoyAxvYWm3QjXvLVdGIljr?=
 =?us-ascii?Q?FHfl9kWnup/b8lFFU2Zsisn+5Wa+9v+trmWU+i3Qw+BB6suy1CYUdKRWGcYq?=
 =?us-ascii?Q?RvGA/4iArKdxQhKhB4OAHUYaSRpe9lkVIdpPX41rJGAaf4t492HQfPnaAPsU?=
 =?us-ascii?Q?gOAOx9lS00ljp+dQkiGZ+6kMY4jZB25FOFQP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5u4AWIAlYtiVhNRZ0WhD6J+BOpwxCXF6hulrrU8rWAoJKOrvbDcc3nq380di?=
 =?us-ascii?Q?Is8VlFtsCptDvPFgEC4HABndytM2VO03B4hstppzI66Wa20hOY2b4gFClElO?=
 =?us-ascii?Q?YeATV5QftUglGxxS/hlTpr8uxwZXSp7OstjPSyrnFXoQFBAktAW7aOoi39FS?=
 =?us-ascii?Q?7LUiORGmOAiHh3RMAK7gCmiNHaJyK4W+QxWCW/oajaSg3+olVJLvx5sFVKAp?=
 =?us-ascii?Q?RYljBiqJCRwJ5sd6scoRW3cpcMdA23J6ycB8Iyi/gQx/kTjvn9XsyAh3+DDP?=
 =?us-ascii?Q?/VO6mJm7Yyu+9l189CMbE6DcukrpjZKfOJ+fmU4OOP6crSn+33mDT1/Y/A3b?=
 =?us-ascii?Q?PmWcpCHuy5wT+shABnQkbBMqyBLg9rR+e2lrMZWNKKOUwPn1tTkiSh0hLkYS?=
 =?us-ascii?Q?psofP1sXZml318ILFYixKvgNgl0cI6iJsQSgIUDng6xn1ST3w/EZUIRsJ6MJ?=
 =?us-ascii?Q?mloS32bBSG43OpmWBEu+7no4QbSZgyQ8Tk2YEvmcqB/E3EjkSNdsqZUDnYle?=
 =?us-ascii?Q?uooYGJKrPAJ16sR3Hv2gA2AYfxXmCgMpVw2+L2I28Hp1Qi0DjCCtKY0bK7Ap?=
 =?us-ascii?Q?2PdXLaoW1wiYv78pOcnrH39ikTS6F5ID6+DCeFAQ/cW9056ghPRIbAVvq6ap?=
 =?us-ascii?Q?CGMY1Qg9Xf8o9uQlCPuuvIbZuZOtHEAnek8ce7z8tG117muGHP6ldUn+UQ/S?=
 =?us-ascii?Q?8aLasVbghhT4YK1ipyRrgx2WLc5+z+f+zepTFdoHs/gKbh6Fn91aEeP5xfSK?=
 =?us-ascii?Q?QCfuXxoCGIn3ZB2k6QKV3H9b2ApUJbEKol9uRVgXiFvLeXu6aQVFTQXtRCEx?=
 =?us-ascii?Q?K/ywqWNgmUf6qUokXjaLwc5n+uEQ66tc37T8bWmw4bRsdZyYuyGN40sKIIvb?=
 =?us-ascii?Q?NV9FKI24lsHDiuTMx+61JPvoYz89cnr3B1rDr5H6KoN/vhLmgAiVwPv+qJ4A?=
 =?us-ascii?Q?Hd7823ifkk2/UXsiKT3xa+3CMA9UaFRIdup2vkbw1d6eGLWg2g9+5yWF6eCu?=
 =?us-ascii?Q?zn5mSQXtIyaa1cZGR9ouAm4hZROKBNJHEf7EFYlYYnt+y1ul5xi134M/htRg?=
 =?us-ascii?Q?5dCNEKx+4VYZuvwj26oRF3oGdS3IKMYIyezlsiyjedQ8Sk71ANC0VDUFBVnq?=
 =?us-ascii?Q?Rc+m8/udyXVh7b5/0uB1pvUJjnHNy/KDi0Zi+gfZC5FIFG4KHnL/xPaRWg6/?=
 =?us-ascii?Q?YhD0FTf/L8B9w7NIajZ3vqBFehWcgXtmSrbqlPPaRffWJZvJcoTkbYnF4oX4?=
 =?us-ascii?Q?OhsD/TqakSDqF/7mClb81PuzOx7MkUwBz6vjfhnB+aToFZ8iAsWmMmtt8ApK?=
 =?us-ascii?Q?h2J+Fi9BcgIfbmOdhdS5/31atGHJ6/TN6aLKPxsSwvqf2BAneHV4UITfXC+g?=
 =?us-ascii?Q?SxNxQXv2sO3k1UmoEv1GcpqjRqOddUK66gK5JcLFALBq7tMcowVT+UhpwIKu?=
 =?us-ascii?Q?fCbAQGjw8ZhLGDKghiCNeftyVDnQoRVq1qf11/vNwZ3eiuEyuQ9Cl+n8m+D/?=
 =?us-ascii?Q?esHNiwiJED/xxsOsKaAjapGaOHQQWO+BC3VgniUEXIa9E2J0PDusnV0X0mwd?=
 =?us-ascii?Q?8aeNT5GkHY1mNarB2iVi09OpFwj/OYfVXJmKXx/YhevPgarTbOiCGphR1Zsi?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f6b5d3-1a23-465a-6892-08de26adb8b7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:21:10.5975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHZNpJzKTIbglyt/LOWCOmDxvbUAFOcOO7iIV+yZektJLEYmZKprncjc5b0UC5k7VqBxBiMP4kSB6Pd6AqHlxQRqf/H1zJhXAecQpn9EN0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10179

This adds support for receiving and decrypting vendor events from secure
NXP chip and forwarding the decrypted sensitive HCI events to the BT
stack.

The NXP BT chip encrypts the Link Key Notification event that is usually
sent in plaintext over UART lines.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 99 ++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 452fff651d82..72b14cbe03f2 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -228,6 +228,7 @@ struct btnxpuart_crypto {
 	u8 handshake_secret[SHA256_DIGEST_SIZE];
 	u8 master_secret[SHA256_DIGEST_SIZE];
 	u64 enc_seq_no;
+	u64 dec_seq_no;
 	struct completion completion;
 	int decrypt_result;
 	struct nxp_tls_traffic_keys keys;
@@ -2749,6 +2750,102 @@ static struct sk_buff *nxp_crypto_encrypt_cmd(struct hci_dev *hdev,
 	return skb;
 }
 
+static int nxp_crypto_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	int ciphertext_size;
+	u8 *ciphertext;
+	u8 aes_gcm_tag[NXP_ENC_AUTH_TAG_SIZE];
+	u8 nonce[GCM_AES_IV_SIZE];
+	int ret;
+	struct sk_buff *event_skb;
+	struct nxp_tls_traffic_keys *keys = &nxpdev->crypto.keys;
+
+	if (skb->len < NXP_ENC_AUTH_TAG_SIZE) {
+		bt_dev_err(hdev, "Encrypted event too short: %d", skb->len);
+		return -EINVAL;
+	}
+	ciphertext_size = skb->len - NXP_ENC_AUTH_TAG_SIZE;
+	ciphertext = kzalloc(ciphertext_size, GFP_KERNEL);
+	if (!ciphertext)
+		return -ENOMEM;
+
+	memcpy(ciphertext, skb->data, ciphertext_size);
+	memcpy(aes_gcm_tag, skb->data + ciphertext_size, NXP_ENC_AUTH_TAG_SIZE);
+
+	nxp_data_calc_nonce(keys->d2h_iv, nxpdev->crypto.dec_seq_no, nonce);
+
+	ret = nxp_aes_gcm_decrypt(hdev, ciphertext, ciphertext_size,
+				  aes_gcm_tag, keys->d2h_key, nonce);
+	if (ret) {
+		kfree(ciphertext);
+		return ret;
+	}
+
+	event_skb = bt_skb_alloc(ciphertext_size, GFP_ATOMIC);
+	if (!event_skb) {
+		kfree(ciphertext);
+		return -ENOMEM;
+	}
+
+	hci_skb_pkt_type(event_skb) = HCI_EVENT_PKT;
+	skb_put_data(event_skb, ciphertext, ciphertext_size);
+
+	nxpdev->crypto.dec_seq_no++;
+
+	kfree(ciphertext);
+
+	/* Inject Decrypted Event to upper stack */
+	return hci_recv_frame(hdev, event_skb);
+}
+
+static int nxp_process_vendor_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct hci_event_hdr *vendor_event_hdr;
+	u8 *vendor_sub_event;
+
+	vendor_event_hdr = (struct hci_event_hdr *)skb_pull_data(skb,
+								 sizeof(*vendor_event_hdr));
+	if (!vendor_event_hdr)
+		goto free_skb;
+
+	if (!vendor_event_hdr->plen)
+		goto free_skb;
+
+	vendor_sub_event = skb_pull_data(skb, 1);
+	if (!vendor_sub_event)
+		goto free_skb;
+
+	switch (*vendor_sub_event) {
+	case 0x23:
+		break;	// Power Save Enable/Disable vendor response. Can be ignored.
+	case 0xe3:
+		if (nxpdev->secure_interface)
+			nxp_crypto_event(hdev, skb);
+		else
+			bt_dev_warn(hdev, "Unexpected encrypted event");
+		break;
+	default:
+		bt_dev_err(hdev, "Unknown vendor event subtype: %d", *vendor_sub_event);
+		break;
+	}
+
+free_skb:
+	kfree_skb(skb);
+	return 0;
+}
+
+static int nxp_recv_event_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	u8 event = hci_event_hdr(skb)->evt;
+
+	if (event == 0xff)
+		return nxp_process_vendor_event(hdev, skb);
+	else
+		return hci_recv_frame(hdev, skb);
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -3076,7 +3173,7 @@ static int btnxpuart_flush(struct hci_dev *hdev)
 static const struct h4_recv_pkt nxp_recv_pkts[] = {
 	{ H4_RECV_ACL,          .recv = nxp_recv_acl_pkt },
 	{ H4_RECV_SCO,          .recv = hci_recv_frame },
-	{ H4_RECV_EVENT,        .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,        .recv = nxp_recv_event_frame },
 	{ H4_RECV_ISO,		.recv = hci_recv_frame },
 	{ NXP_RECV_CHIP_VER_V1, .recv = nxp_recv_chip_ver_v1 },
 	{ NXP_RECV_FW_REQ_V1,   .recv = nxp_recv_fw_req_v1 },
-- 
2.43.0

