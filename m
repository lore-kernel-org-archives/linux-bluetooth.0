Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2261EB5FD;
	Tue, 13 Jan 2026 07:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290448; cv=fail; b=ijHJIni86BaFOnMPtCAoqXkoIyQHZtIxY/yU9vfPVVaq3Yx//F+ZidphlxiUKcZ2I9bvITl/XyB034jLXYIwYlE0KBzLHl/fIzOn2lj3O6+tyt1DtZDUrUpPStcvztewYrA2OtH0G2Ep8jzmw71U+Ayao391285g1ZwbX/A1doE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290448; c=relaxed/simple;
	bh=ld4dHDieVhoBGqbVfX8kCxn2nSEbC/++Mj81SmoKolc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cPRScfAtex8/HweL22Zpg9PeRB6yx/fRSSyZHV6w8+DwDolJe4Yb4Ic5jgfxbT9vLxWg8vj8dNwWy+Dd5ssg4xOiWGKHnMoLCxJZoVunBXdYZY54qutnm7QD3oLrpSCdlZGRVaJukhqsv7sTE/EWNpgB8cKuzhg9JCx4lNU8ksU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K0a/nJzf; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K0a/nJzf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QhypdzenEj4ZS7w3sCzh9mOjqQjgagFY4x8IJSAn33Pla1f43yBdJV9HgmfUu41XVkf36ZWXnfLWEC9JHqi3bM4vWvpj+zuKeeIqOITturhGQUzBd8MoaPiYHLFBCZaISGBatwWc8xqdkH7epT2lV5BB6wU9wF2oNyFqDGLN9aVx6ITjyygaFphD1KLp+bobN9ukSDasKuwmdFJxpTyAnfyiKzeBWYbCPKlF5vHbcWtIe+xE6r/UtQ/sQkXOIFC3hcScmnZz/8gFc7SlwfHNs2gtN96tUHyfIBKl8CgtP08p1PW5MzZHaN9reIaPgK7oyeS/2xvKFXpKp5C49uVCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zrUldR48FnQ2brLH2Y+7JdmbdO2K2Z1rocNuExRmEA=;
 b=PwJ6mNdhVyNQ2UH39/FYbaqCDhJIYuq7xdfmNisI/4PbYqqeNc1+bHYkqSg+YCxIUkdNQdI/ViX4i5fLKFlQcpngo+ZNQr/rUNa8+Ah4Gs1KUwT4yScRe+uRl1NYePqHhkFr/3H6DuYjpUOubRQDIW/pKruWN+1j47EZbg4GvkuQ4uTkc6k3TBT7YJ95YD+mvKl2/lKa0aTNG8ATf9cX0BfNoToe06kiMlfpfqS5bhXuQlNt4+lf2NYzdldC0NbXjY1bFSWweVwlJp2J6ecKDsRz4p8EPtc+DB3sYm1B5GP3wx9xVeQx9GmJ/9lnRF8cjFwUp4EON8hRI8YX4+bisA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zrUldR48FnQ2brLH2Y+7JdmbdO2K2Z1rocNuExRmEA=;
 b=K0a/nJzf2WTJZXuz3eRIlYw+wPhrspwYYZ5Qk5fHZDEQuF5Dd/3buiWy5OPQ6Hcqz6xQbZUeGWZo2BUz20ejSvA3Rx7IZKNG+aJ6UyNvp2e+58BD6GocseaeqHWi/viOTCnGxVzpw7pYqaRKXb/Ne/dlKRvwRgMC9rOJ/ryMzOYSFl4NS0Jkz658hTHUWVPY3aMZ3fm7uDG/w3bcTTbpcLE7rAPRep7nA3Nc8xL1CKCmCvWje6i++fTZS91lEsF2dCiYXuWFn241ic/b1i4KnXsv4+geD227si5Ec2Ac3gJqM0Uy/La3tjsNlApk+FvF0bIymJz9thVW6DIR9KqvOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 07:47:10 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 07:47:09 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] Bluetooth: btnxpuart: Add encrypted event handling
Date: Tue, 13 Jan 2026 13:17:17 +0530
Message-ID: <20260113074718.2384043-11-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
References: <20260113074718.2384043-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0028.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::38) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PAXPR04MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: 211df568-e572-4c6b-4255-08de5277f4ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VcqcVPJju0k7Blev39nfXsMTrd/k9Ccb4R1yomysJ7COYmYmrjKqAQ4X1a0f?=
 =?us-ascii?Q?6D3VicVr36eTHWZ3dn5EJ/JiQljIMVk7t/U1pW7HQFmZ+pwG/s+fISjhG9fB?=
 =?us-ascii?Q?sj2WsJH9bG2nUwYIAHSzfsWUigQR7CPFvYeWhSAMFm7C2ZEZsTq5VyQVTdNu?=
 =?us-ascii?Q?APFko3gk3NOd+GZ2Z8Ot8VJmGGsh1uajU+p/AOu5Cfx5imkNAn+RD4901qgR?=
 =?us-ascii?Q?4U2g/5vBLYhoQtwOY7c9eXC/8CuOHKAi333slz3IF1OpQrWEcHhLbrrzFxrY?=
 =?us-ascii?Q?188Uf0KiB1AkdIo8R6CJN3T4wogaZGC+497IcIDXYeQfzvUUZWH/TtgzhTOh?=
 =?us-ascii?Q?pChz4jAUvU5qLINF73vR5R5Fnv1m/ltrBsYKzUcJjmTe/GPpMJ/EBL/LW8jx?=
 =?us-ascii?Q?BG1cQ0IffPsZWbikpdKP/hFgKYpSGee2hLqxFvBCh11yKYt8kcZyz7ODeHtG?=
 =?us-ascii?Q?mDT0ihpil8cZzfg2yZslH/9JjTgByXrZh4kHQUmmLFChRLbs2LpWmkyEPyya?=
 =?us-ascii?Q?zOO4cguPZ30GDoxQZFo0t5aUFvTwNALHXNRg0rw12Z63hhSo1Y+Nyu/eOMrq?=
 =?us-ascii?Q?+5EJc0p0rNY2x2pCnLSx9vUvcJ2e/HsdvfinDVQXDrGDu8qrneBabltDCDnw?=
 =?us-ascii?Q?cF5nDVXmSwCQ3GthDeIGM9Nv1l4QVwz9IlwdFw2UHZp3b8Zk85xdm6mnZqmn?=
 =?us-ascii?Q?V6zPdfPAdBu8X+p0ItWNMNN92zW/lyyV70rzPz4mPaqoe38uJaehNw1yPhMs?=
 =?us-ascii?Q?V6GKjEkQd2jcHBIapXQNhh5uZLF1qKItXVgGBVCUupsHR/dqaWelde7BZZpa?=
 =?us-ascii?Q?+f7s33qkHSGND5gtBaAm44ktPVkQQ3TH52Sv8tY0zOhOOa1Q6Ya9cA7aymeY?=
 =?us-ascii?Q?3Pl/b6lp/SF490g+6M7CKFrUsjDe0JDjDnyE2CtJ/VM4VpKmOlW9CmO55T6A?=
 =?us-ascii?Q?cJBStP+0ntjA06T6hMabLJ3mkkxJNkoYIXpyaHBDcbvgXAQH+BVZQ1l45Sms?=
 =?us-ascii?Q?xM/vv0MYzyZigb9N2yYNy0IBi/5wFp+QyJcFAwAUa2qJ1eb3IxvWvieQBTAE?=
 =?us-ascii?Q?sznsCfVEwl4xJvkD3LpgNsbBCAfO4k9caaf1O4n5BJ7Aa41Vlt3HhxVxpsJP?=
 =?us-ascii?Q?ancJ/e97VGtbTN1liG8r1v9m5vx8LKfyRAeJPEm5jtV8+hzYpYmr6jRuU1/p?=
 =?us-ascii?Q?wOBi5M2NGUoeTknlyOcFmzT7kGA2zoocbCEuslJ2MlNiWoaai1jPzN+dl1Vm?=
 =?us-ascii?Q?BbX7N6V1aMQtOkkL4luFPGUS00fpEArkivEbIhIU2Puc3i5NqqW4dc3mXIWv?=
 =?us-ascii?Q?TVyqN1h0efm+8saT++/buakZISdaXqBfRrVO+Wzslt+H/KreBbUQxnjdA2/X?=
 =?us-ascii?Q?EveMOzZG6JQ0i7LYcP5NDbzgi90iXRyosGshTkkcV4pWVjtfKZqdlnjsvA3W?=
 =?us-ascii?Q?gCdHyeWKkxvbSCpKx99dtDCkPJhNnpjYeljEI85WirPWmWRrvez3bRrRIOFK?=
 =?us-ascii?Q?ihzoU3rL6d7xv4y8J5KdtHqfJspxLodLFLT8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+F+RBHnm+pQk1DZTryDIKYxvsnF7znZTIEkRDcEy92NKmkV7qSxfgmuCsG7j?=
 =?us-ascii?Q?+Ng/U3hcY5DxnwwNZCmQECh/DsgLBHIgRB1+ehUNn3YDHbgP1Ov/RIhwsur4?=
 =?us-ascii?Q?5C8zL7moGuWcPUlCg4MSHId2vHgn9MsWAIdlEmOfPnmlbs2daYAoq+a9tST8?=
 =?us-ascii?Q?oFnS68UFzen4vUf4T3kn4BaalZBe8fsnvyHf0LS3r58eW9bFQhb2IxlKbg7b?=
 =?us-ascii?Q?8Yvj4RDRDAoaFIzTmvHuoRWDqN3OKJ6p3liEJu1+7hE1gTOL1ix1b08Wfte6?=
 =?us-ascii?Q?2xaQfxr1pH7zvp1oMODEwxmdup6ofXF6h8x1mrKc68MLW+p+IDpxKOZOH6qH?=
 =?us-ascii?Q?a/+xdqd7Onj/DkFODFw1brE+b0raHupHcgW9lgZkkRxtSz5nsehAOSerROUA?=
 =?us-ascii?Q?LMKDo5vtlx7AzzhiOa1PTACVuN1lL7v/4PmoB0X98bZXMZ1L1mui1rA+PdPt?=
 =?us-ascii?Q?0CxWSrOu6ts/lc9wwvrkXN6QBUJrOve64Ha6/iBae5gCU5Z0ZHYdG/cfc+T7?=
 =?us-ascii?Q?3aNY/Ofi0C5WLRT1HCBvzv0CKsMXBnf/w/GSF2RbrDpAAl8OBwDlAfaJoeN1?=
 =?us-ascii?Q?AVcEQokMgrbMvUBhvJOn0SX1QGBSVP8/LLDVfXdAljl1trYo6jOLulcaVdvK?=
 =?us-ascii?Q?yDb7W3d1KqB71muNB/UjK5hxEkgdkqjcpKk1JR8Ojrr3iLIOHvlyYAIiHPor?=
 =?us-ascii?Q?Qry0KU9ItlxPbSyDNA02ZRozeOjpKB1It2iDrTUGhlAkiCvBggXMLJhifDk6?=
 =?us-ascii?Q?/edeue1HWxGbreNPmv/fJBfUZVMx1kDItI8J8O/8LbK/Z7d97upTKi2mlBUW?=
 =?us-ascii?Q?nSkndLJa90lg4JcIKP3n47DEb0n1EihbeTH+33OM+3bcwmtiS0QReWqHqTgD?=
 =?us-ascii?Q?QAl3bMG7uqp2bjv2FbDRwJ1xf/kvuhRBlukk4de1cCfomhmg0nZyxeccgWso?=
 =?us-ascii?Q?9T2Kecqz4ysdCBWiGbk0iuhodGW+uLFAV7a6UAtRabw3EKkKlarFHE/ytKuj?=
 =?us-ascii?Q?O76DdrXNc1AMDBO8yFdH/diT2y7WlYXCjzBGUww1Af9kiBzEuApW5HNhezYl?=
 =?us-ascii?Q?Lw54BM1DJ3GVXrc4xL/g8tzwY3+FrDkRn6NKQXMFDKBKCKZ4iNrAc0lY2o0Q?=
 =?us-ascii?Q?tVb5MlVtOJ6FgjaGID6ABdB3KdNCo+KxsEpE1Qzhen0tEZH6KC/mhBAPPX3P?=
 =?us-ascii?Q?PofrprUFaYs0J4KVHp7GBGUeJitenkEQaBso6um9w8fSfudt+8JjjacD4fPw?=
 =?us-ascii?Q?T6SwKKt47sGn/81Pq9IrYmWvqAGc8KeLCVoPFBoTWTm/rveQLGofAj7imR+u?=
 =?us-ascii?Q?JZ15I3Z5MR3NCzOw8N8LW+RmYerfTOLZA4TX2zjOsFPo8Br/3911+rwNKXoo?=
 =?us-ascii?Q?l1ttXXl76uRS0iEocCpZQycWxMVMcnA2iFvdCZIfuTZ5clSDR4i4dIcQr2hZ?=
 =?us-ascii?Q?+fLQOwRiSBTQ6t/4WRlH5B7cVzHdwDAfkqyEaldGd3k69LhWAKZ10zLhpDeD?=
 =?us-ascii?Q?n8S6kFOhPL1PCTji8n3HaeGmPhNA5B02OA+U5CQgAV/s2nFDPWsD7frVmq41?=
 =?us-ascii?Q?DP3MOeevY1qmrSJLgYaF2PTkPKQys6KiqsS79hraTDIHbGMxvXyu2jK6R8ie?=
 =?us-ascii?Q?Bt+YXlGs0gPyKtIeUpaceDG+OBsyuJtrWwMtAEOcuWU5S1LYmK3vPJuORF8o?=
 =?us-ascii?Q?v09w7mINAZx/ZSt06CG6a/kQwpv6REltlwia4rwIZ//QHt0Er248A74BACbb?=
 =?us-ascii?Q?WOWKJ6keGJG/fClsQvSD/+ccHNp1ctk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 211df568-e572-4c6b-4255-08de5277f4ca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:47:09.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /N5j13hFnJjKr7xHDFlONSWJ9iY3akSioGgEa49ldh0ZoONkSQlBAA4asCCJ3LHb0FidN/JbnLQEREAycoFmhH32SQXKdfXwA24pMYK8m88=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

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
index e2be9012ef58..115f727c2572 100644
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

