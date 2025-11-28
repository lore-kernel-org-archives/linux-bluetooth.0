Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1F43064A9;
	Fri, 28 Nov 2025 09:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321361; cv=fail; b=kLOlbJMk50k9TmdEUCEQvIozP8NcfhpGg8LdcPtoD+46ctKzverf1dXtK0c9AhKo+8bZZeooBmJ/1PJfh5JLwLC1+xKVTD5YiON9eLu+1pqogxQ19NdxxI4HB7us4KlbImQwpHIinlTWIJz9/QJNWvcyYCAccea7aI/PILHnP+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321361; c=relaxed/simple;
	bh=ld4dHDieVhoBGqbVfX8kCxn2nSEbC/++Mj81SmoKolc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jDK8F6IX8a+m5lfCVKBJ41XS6PTDjmKaM6fWHLjCwYpDmkx0W4Il87livYjHup93jHblFeJ4sNRh7eyqB6O5bKHmpTUJM9Oy9dkjArdlt8wq9OTTgopLQt42k6nUX5hOo1A27QUAz/VwEHYSRyQtDbhOcV51MWcRaO8lNwXF5BU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k1xmx2kJ; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k1xmx2kJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaMKRStUsDeZPDksnQlAS70nPtGiLiwH4DW2NAHL51EKyJ6BDMszpEEaB/0/aADBe7zi3vdf3V2gC5ad4LAkAH2qkjXVyi65YX0JQ0VlDJyznqedZ+DMidUqGkmIGEq4B7TJSHMrGmQv8TlpYpTZsVNQfMopLpG15O7L5Hh2onVLlapwowFxmDAmBOB1R5qv2HYDEe8AgcJHfL6MEwWBVKZVzaNiJ4k23IEqtByzk0xSnznAgZWgeL87NoBhJgk52KojoKnQgzkzOj5f5/N3nMdzX4kl3KYWhS7QCGHEDUwUq3Elcv6/QMjSFhz7YulPUDxIr+sdDqIc4TXTvnuNIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zrUldR48FnQ2brLH2Y+7JdmbdO2K2Z1rocNuExRmEA=;
 b=hLckh1Poe6iMamWI1ebJy6fkUujEbQkBgdcizfIBYApmRWt3C6FhmboYLNuB9+tv9QzYmnr+PwPvWyvjsnGlgMXIK5YQKJ9enuI7RemMmeTO0VgV1/j42Fj3niO/i4tD9/Cc0hi7yfsE8nQyVqbkYjsdibh+UD15rflHcqZk8Zd0AeNhE+iRWWyWtNBS5gxTjnx+EtO4Tqzf7rMNf8HYshrarzYnNpy/ltPTLufwCME4hWLpod7MtHnSoYLuJ6hM/5W/AOYRf8Z1PbM+ptWzwwkHu497Rt7sXCimQkD30sUdM2CY+AdfHsBJ9c+k5HEBA7dEOo7Vsva+aXyABvhmoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zrUldR48FnQ2brLH2Y+7JdmbdO2K2Z1rocNuExRmEA=;
 b=k1xmx2kJ73ymuWKCekVb/3/EDY1XUOiTlJRPoPCDTqv/91q5O1yyFvBgfynhJTGC/roHT9K0UHytcNidqdROTrTKAYD9tKjCyf+4LNZiycVx4uyZkA5EuS6/6T3DyR64wKihl1TX3MiL9nY4FYdh25qvNPio6ndbfGSc6YcubqR9GG5GVTsQELnH1HYEpp16Y3O6sV3MUn5cXhgIGwufw84QgGYuynMA4VxHSjDxYWHWVOIElY3SAL5bnFto2EecqHm0UHbH2pQji8XrMyPFCdtHe3lmEtv4IG6i2lh7dbKLIc/RprblZn+WVy+rJ7/3LV+jTZDZT9FwL8tKwGMCbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 09:15:57 +0000
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d]) by DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:15:57 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 10/11] Bluetooth: btnxpuart: Add encrypted event handling
Date: Fri, 28 Nov 2025 14:44:42 +0530
Message-ID: <20251128091443.2797316-11-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251128091443.2797316-1-neeraj.sanjaykale@nxp.com>
References: <20251128091443.2797316-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To DB9PR04MB9676.eurprd04.prod.outlook.com
 (2603:10a6:10:308::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9676:EE_|DB9PR04MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c1230c0-1457-4a56-1ca3-08de2e5ebd1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ottbVAxA+DvVpCU/FKdz+aI5o13hRi0meOn5aHo/+2U9mPhAs13q7bbu4Sb2?=
 =?us-ascii?Q?JsrU8qJxa0cYwOuhYqr4597rscyIkvB8awxpVb0dpRl8o2pFwKScnnv2gYr8?=
 =?us-ascii?Q?Uk4SxnwQBwRMr/KLQUHb/bqP3+nRKe9wAGTlSPsXfMFV0Hatr1fy2rzMKqve?=
 =?us-ascii?Q?SUijOZZW7C/3P6pYWwQbkLBtTH/1ZGyG96GoEYvWGyJ6gdEUosbhYAaUtuHI?=
 =?us-ascii?Q?4rRsteCH4F9NSiOcGVuyQ4r/a24lVrgELOO2Vud83FcePu4+tT22lfes+kVC?=
 =?us-ascii?Q?wt8Ht9lF8uSingYIBf9ezl1B1gHzHK7SNV5hC8ZZqeaJ5H2LU+cd6oZtXdf8?=
 =?us-ascii?Q?wbHRHeXOaejU59uHorTpamMNCGwTeglEbBLlCcveMP+1iAdmoBYsc5NVM3RM?=
 =?us-ascii?Q?p4iCJnzdnnK/8239rYlTHntXgDGgj3OysMJCPegiscezq5j+3bpTXcGz8OQO?=
 =?us-ascii?Q?LdsgMLMN6l3tAEFF3iGNtvTA096x2tUmd0xJjGQ1Rz0KzAf2voZAesxsEsP6?=
 =?us-ascii?Q?N1XySHFqvowKJcpjmnQlIYVRAGNArwmQN1/ooy7vBllWww7sZgySEL0hQEsY?=
 =?us-ascii?Q?dt9mFl9cQ7r/4sI4IEMHTREVqlLviwwOUHykAjhHSRG50XxkjEEt9P3D2puL?=
 =?us-ascii?Q?aWoR3F85HQzTAAgqSEi0hJtnGaVZPAmp03Yb4rGZsQOweBTMaCDkaqgWrpSU?=
 =?us-ascii?Q?+naftHgz+/3Ik+vPDn8Mr+wgCJbK5v1p1qg6n9A52jy1f4b+D+BeGQCfNoCs?=
 =?us-ascii?Q?uPVjMEL74pTFva7o1AR3/GUuMtL1jf12+p8x7Ff2ZPMK5WxrIr20exDH+6FY?=
 =?us-ascii?Q?bQ5AxWpcTTyYN6yCln4OLCxDeO8f4DmbecSn+Nig1WrYb+yTKkiymUX9UAHl?=
 =?us-ascii?Q?zyPFhj7f9glVsVuXj1Iqa+wpVvwMZLOSGJWD+Ia7Cu99esT9Mp8MTEp70Z20?=
 =?us-ascii?Q?pN/OpL/Snqq117bQnwTsg+l8F+j0arsFCPVUxhsqOEY5nB19HI1rUE2pMR1z?=
 =?us-ascii?Q?479/P0W1CoAZDsMj78AIw5aNIBZTFtjpbRNIXVtCK3W4PbMrsmTimhguNRd1?=
 =?us-ascii?Q?8DfNK/rLqvi1tpaS9lM3AyNZjKneH7NDe5HqSuDrvsuC6CI3gcHwFAvmcZnv?=
 =?us-ascii?Q?CMvZNAjoOUvypWz2WyVxHSi6f6KUBfj24mZwUZjdF/8xszrhCskgBn+j38xU?=
 =?us-ascii?Q?yYSCMYtBXTSegPgPcowF7MWCvvPpVGF8s3WHvE7XwpoLgBqm286q2hX59xiN?=
 =?us-ascii?Q?MbNDRuNFx23AIObnwZsR04bm0ToJFS1ssY9Mj9vxF+t1PrAHjEirggG+hkYW?=
 =?us-ascii?Q?/BIdJMX5ufk3yUsUfDK32s0qjQEG7rJRqG+wmcYHBcHLmWFADjediFRz3biY?=
 =?us-ascii?Q?gwcScZTCeY5qsxWgCzEIlLiks2wG8eaXp0CQz+nWk2iCPQcwkIf87ESvBPKS?=
 =?us-ascii?Q?f68vl8xRZZqMzwNOmrialDEhjXzJ4qyJom/du5wjrMxOZkCjxpJfakxTJs45?=
 =?us-ascii?Q?QQK2/xuGlG08rqdprp5TIHJE7xV6AzVaE6HM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bZNP1IoMGCe7K4K3ygYGDcC2FxplHB7k9kP2+wmBXXmVaA5ZLew0h5oHBWie?=
 =?us-ascii?Q?/IQWFf1efrj6sULAIV7S/mRLW6f2ZfQxcaeXIC+ckD/75pzS28WpeuVqaJnO?=
 =?us-ascii?Q?gvd2H/KoISbXkOLJXCKC1R1clHprvdegZajmwnedCN2j71++z0Qi4mhSe6CL?=
 =?us-ascii?Q?qFo4yyMpnO2gur+wrBxHmYwCTGfTlbg9Lxc80opMbI2Uc3ZigOo9TmfnyhBc?=
 =?us-ascii?Q?NoN/vozbUJGYHLVQFwKdgMy/o67p4UWbwkPOCjTtpI3fnGU6EkGBTrKVA4BK?=
 =?us-ascii?Q?OayNhnEO3hr3crNFzV7R5VSdAb0JUE1STQBYVls1ah5C54Q9pKrga0Q+5wwq?=
 =?us-ascii?Q?jDuHXGRY/EtdhA+MGBz1y+0MZR//zF3LsAZL49umxmr7c8j9Yedrq47T3cNW?=
 =?us-ascii?Q?uXuyHx/Xzxc2sJ8aIhSFg4VCmaogmVpiDTp19g9SlB/+oB+wlI5+LVsPVD6N?=
 =?us-ascii?Q?2nJ7Ap5urIohLtN/jm5FV+Tny6NZpy5spGFnbBFrAEMhVixO5+exPCeeL5QF?=
 =?us-ascii?Q?uRnKOovr09oaIlKSbKnf7DtuWBq2HM4VOCs6AIphCK3pITWjOROYYncBer7I?=
 =?us-ascii?Q?sURoTd2dgKSfMdAEpI0aUmmgYdpnuUpsN49rZqkHQUajFQddJfFLwr6rtfrQ?=
 =?us-ascii?Q?rnhX26fW1UKJTkYLKN87qCyvtTWcmbeE4LuNXCadC7+Cy3nX0IzpQ25q0ESH?=
 =?us-ascii?Q?ZPICDHZXBtMZSk4HEiOKfyoAOiA5FMc5cFbulzY44DHoIrCLuh6riwyqWFG/?=
 =?us-ascii?Q?IFS7S4LtOdkMWTs66Dmdik+GtaZHb6Z1ZE+BvsHYYQpD9uf5DBCbL2hHNEZp?=
 =?us-ascii?Q?zg78KuVpLycFzHeH9QLFolYxAKV68ZLyPJ23dcPP3JuFPmEj9buTgzon5vOc?=
 =?us-ascii?Q?g9JK+s00iiOdkq4IkKa53VOlZsXPg6aPgFNLJ7FIv+pObIoDcS9WEZGASMip?=
 =?us-ascii?Q?qOJ00yuAyyWZYedYIOlDBLcTPOx8AsLtx+0ulUgg6YhkPPCzWHpgKiY4BeVq?=
 =?us-ascii?Q?slMSg+XvVD7n+jHF6KUMiP6RvHeO966EgicEDN05/w4FRbmkOU2zR0w8Fgzg?=
 =?us-ascii?Q?k5zvn0Z0ANWper4FRB2HcNE6Keh7gR+oOG13rGRpFiqKPg6KHZbMD5HeSyjp?=
 =?us-ascii?Q?dzelyL2XM8l7azsh/wxQBv1eAOV2zO7qbl3Igm0TWWHDZI6nxigXzgEyqFoU?=
 =?us-ascii?Q?hKSlqb7s53aNEI8Jpxx93xIzA/kf4CPjTqOMRXSCBjO62BiqIWKhltyideZD?=
 =?us-ascii?Q?mg2CxuZrrvWox1W4LctxdQBtbhqWUeROHmDVLpj9HILdNyiOcjAzbxw8r/As?=
 =?us-ascii?Q?7Va1+cIp2CZtMQmvrz7uCVoUisa7eX7HVVskmqmdZHTuKWBTBiVECmX6R+M6?=
 =?us-ascii?Q?tI4pq7zYarAn/1lgYSRbx/6w8cWkRzo1p5Ku3CK/eiRFsYPbJvZvGTgNLucg?=
 =?us-ascii?Q?prbqHP59rqveneABAnkPsrwZfxRzolmlhPwmnrhx4WuDDoXlLkhX5pusmIIL?=
 =?us-ascii?Q?mE9vu2DkV7xfGSPuay/SyKFHr3xGTgvehyGja3JcbiqczCGFdH+fmt46JQyU?=
 =?us-ascii?Q?XAd5mVGzL3xRu9MO/a2XYrxzWzQeFOhs7ES+WeLltl1pWHQ4ux6ivAyzTHmr?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c1230c0-1457-4a56-1ca3-08de2e5ebd1a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:15:56.9879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xcoRUaVivE/97briqnK2ISZbSMdB+/Ju7Vy42QQNxXJQP4sgUuSoKNQhEApGbo3ADEWvnYj33iHKinWCjaFotbdfIij2Zta/pTBSzZ0izDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

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

