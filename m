Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283FD318B8F;
	Tue, 13 Jan 2026 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290445; cv=fail; b=XY7Z7/WVLCWKoLUY3imMAlOdx4dePddMB/4fC8N9BV56BgtAb9BJqvlsSdYG8Iuk/JOVSpsY7Rw4dR1sv+RpoYhfegJMJ58pcB1JgFGlqVlXwY3q+lNcMu6f/WCmMppmigtcEis0i2vnp2OwgbREGPKjHvXoNFrz4zeHJpqfHd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290445; c=relaxed/simple;
	bh=MWhA2gh+XBoFj+Ck1/Hr91rPrUZ98eyGvCaYZWcV7OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W9Ku6dX+FRdQuNe/YkqUjic2EebmPJWfjz2Osfuopnc/OBbicIWYq/8Fiqq8SqEFTRizXhq0v8DmId5/Mx4ocj9t6X3ZQsWNbfkOiIQPVETSPOFPToR6TXSbTn0mKEWraBGM0Vyz7DRJpMYanPPK5Trv0hVY9/mFDsTGLwjFrIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=f8Pp6bKU; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="f8Pp6bKU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfhpxCz4znQeKR/fXfofeUwOSx1dAsBSld7OPvc6THrtSPs2pNH1QsaCYZaCjIP8U3wbGDrtTswD/jKJVQBiJavVTWGMsJR7EHIYqp/zxEmPLXQNcmI6BVopqRTXbze1jNqD0aG+Ubk3YT4p21KcWufpQ9NY+66IYzQNEGMB0ATJIKkMYgwhTC6cgn/M9Ft7iLDBl9bMHuNNzy37LHyT8PQ8LGmAOzI2sXg/+i0chdMxJAF3m4fzgPBjwqaZoiQ9NzD3/vWEsTSo2ZTvbZ/NNG4yzLtJmdURl2MAwV8CDaViYqMlIYdB4wX9DuCekJcr1MjxbPGTniaBUNNadL9Ing==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LzgoS5MjdutMLtDtQCIrAgjtRl8ZGvBSRk6aaJ+YRU=;
 b=qBVxIiX4xg6wF05uczpgZX7BrxHtsp0GbcgZ4UWk2LvFZIIajSvUS3Ka8XF4ju9GRUi647Aref9VCl20qOyWnnG2zNY/ZTL1AhKNvNI86QcHso8PwL2fYVGOzCswa4ru0qpw3sXTNeD2m0eKinM7Te3C4Zi/P38E1kd8ZxDe0Z9KInAkcToK5feObg+JXDlrtusFkjX2lD9jnWyZph0JoNLBtYMRtqvUki0ut/hrrZPhNi12ObSY6sFzZ9aQDIt2IR0VtlHb8jTVUCgMwIPVnOvVpnrRlbKb4Kyz+pz9777h5/7jE0Jyp9Yvq+OHwDdAx/yfIxKTyX/GG4xUZd4pLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LzgoS5MjdutMLtDtQCIrAgjtRl8ZGvBSRk6aaJ+YRU=;
 b=f8Pp6bKUlu8vx6HtKvfHuMfz5iEQLiP+n6IOTmmZsrsIEtO78/sWBaaObbaFgE+VXV5D5ay3nYJLaXlcQa6Rk7AxBTVNhOusPnJmnmMs/rhDpf+AkqvO+0xAcGHVDZgkW/DTXnhJ9caAk+UyA7BipfmaDReoDE8DbsD6MbjqSQ4gXmMQHmJef5e38e3g2uJhe2rAjp0y3UL9Ii6SjJJwlemqwf179h+yQe4d0S41NXdJ3wIb7q1DRAaQjAxNP3fQV6XUFmn37+zs1f4dzeQQMaL/lKg4P3yJrwMvsx7uGWU89L4pzHF8vfLCS8rzIh0B5v71BSXjDAXUV8zJYcyJEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 07:47:07 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 07:47:07 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] Bluetooth: btnxpuart: Add command encryption for sensitive HCI commands
Date: Tue, 13 Jan 2026 13:17:16 +0530
Message-ID: <20260113074718.2384043-10-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c340f0a-8db1-44fd-d5d6-08de5277f394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sa2C7vGWiCKx09C1Vu/zk366ROrqJJ+Wd1/rhykBSLAXwiKDrwWyg5gAy2eC?=
 =?us-ascii?Q?ZfnZLn9kfoSeTC5EGpohnx2SyaceWHksbaDLONGYbtS0t4uetyo5kIHrelwK?=
 =?us-ascii?Q?TNoVhhEBJmIzEPWGzEy4Jk6cnhoFsRYpZJ/deM+oer4EeiqojCYncpMswfdH?=
 =?us-ascii?Q?gWv0PYOA5haPihus+FbzZ/alggmOeSa82TFvsXH2m3krHK/x5xfDLbi2O01S?=
 =?us-ascii?Q?2RHZwBx8eSKy35lBHckDxS6UD3zkWO4Hh//DJfEe3cXbXH54dJp1BKCaMTFQ?=
 =?us-ascii?Q?2ACnoMzw4dnXknzbaaEmqEkUPzigIyZ1i0AqutV0XGxgkIIMXkv8hF2AXiPr?=
 =?us-ascii?Q?JCEWXAeFBvD5ZNbWfpPaixq/x3yj+jvJyZpp1mGeHtJue7VMq1YVI4D3ftD5?=
 =?us-ascii?Q?jEQe+JjFoJfLIjoCcCHYWrb9Lt3vWgMHs8M9+LVP1dRMfI9Z+YSPHf+VEZJ4?=
 =?us-ascii?Q?crwliyJG+w+QyblkbHtxplJQvOm1xM4D3Oc6+7MdEYGXDpKnPEIshh1lzuGT?=
 =?us-ascii?Q?PlXm8PBy3VClAk/NBOVEgfjE9L/wmj/tFikvDkhDSb2H2q2P2AcxBngcFByi?=
 =?us-ascii?Q?aEB0bWIWh7Y7e1NnwjsJxRXjIHYxTX2FySwzcP5HZ3SavASytAXdDHdxgME5?=
 =?us-ascii?Q?WnBTVgTDrswHEqrrDzxP9nv1z8PYcbJPTmFhBYhRSaoS0eXl3Hb2p3O7S4yJ?=
 =?us-ascii?Q?3h0evYmpZpZTcIInBVR4bnVYDTGt117P4OA5cJt9YzNRIbAU5zXXQZukMeYj?=
 =?us-ascii?Q?7A4OTEX2dowewgAnme6Ul0yA1SZlAP3B9wDWfcM8T5/LNbZQ31JpaKVk7aII?=
 =?us-ascii?Q?RccVMvPKv/0cNY5uaN3EavV4m4nBJL1XvUOZxgYXVL9DWFGnyVdAEFpVOXpR?=
 =?us-ascii?Q?WC8BUNuU3ep8XKLETcAEpzMrJS1nZ6aC7SHYSQ7+Vy9A2L6hYv9udDfnKFoq?=
 =?us-ascii?Q?xqaAxXJRXFzBvZ3O6Liv5cR5hfN+wyz8mZ2dBYZrQ7jSPq3lHNA65s/USIrM?=
 =?us-ascii?Q?CpxyOQUG0QGsjFmNfR2c5RYQ3r4rK/OWlVboJyp27kiEJ7JrYtuT9ptnlB2a?=
 =?us-ascii?Q?IeBZmg+0pUUvHDsRQl0tlxGlJFoHCMXtr0MptN+lkqu+nShFq6X6pW2bxy+K?=
 =?us-ascii?Q?v6Reh8v2ytz3AB0g66qAaMTQLpej+TET63eAW5pavU7qKhpeUSZP1q3Nqmtz?=
 =?us-ascii?Q?pYRbdG/1MvRD/JCF1x7krGjVp2cYddoP5E+B8CPHawP2g0iYednxz5Hyy1rc?=
 =?us-ascii?Q?/iEb7tu7lpSnkvz0h21kLqAkeoeErUNBifs/bPnT2brWb09aO0uPAAdp059u?=
 =?us-ascii?Q?kt2qmZFGE5MI9RwRGbLrO7bn96Rlg9cL/ufLl8SkTRO04yjpAEveeDfj/fwq?=
 =?us-ascii?Q?CSAiBD13KfZisSJMBQXeCJjxyBpAUwCTLQ5VzOT3DSPk7pJ0Twv2Mv4tnPP0?=
 =?us-ascii?Q?UM/SK+izqVWwkJbeVx5LfN8vC/0vYg6SSVmPgLDPrSL5AZmYSflxiuSrP7DM?=
 =?us-ascii?Q?KiAB+1jR8Bx7pc4mKnmFIk3399FrdhbtIYAg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YS2BgVCOTbl1Pb6wIEEYA3V+Pjy+/z8Gb3rxa0pU33CjUZuo8IynnZiktTIy?=
 =?us-ascii?Q?OlUngppNsKzgLc5BCwwfRuiz4HVjgMassUs/tTgCeuPFLTlsaYTTimZ8mJSQ?=
 =?us-ascii?Q?faoLrnJHNAwmDwMIumLlYCwzXS6rGPpXo2MJ6nO4zqgmLlhnKO97N+ZxGcKK?=
 =?us-ascii?Q?Z7VpolqNWqT80PslZDrUWqlg5QlaYLepk002LQF3XcfOsbXFGaR4/Q46MG7S?=
 =?us-ascii?Q?WKlWhQSX/B6XTCaEWypsXkNIJKhqlR/sZxIiHW7UccybY61Vtdz+NOgrwIED?=
 =?us-ascii?Q?CpDxpWfaBaRWy7UUcfrQgWE+f7iIqJR+2OhK6ajHQoRg4WOirgWTUXvg0Ykq?=
 =?us-ascii?Q?2bqLV1JD79LPnLsaYixczfLHHl8pBL41nU2687tG5dmkeY7CnfN1NWOJYMfe?=
 =?us-ascii?Q?vFNE4nYPLCjnTCcePBe8lUVrc1iVTX0vLJtXilYIFAkzu9piasBuH5D7oS86?=
 =?us-ascii?Q?dZusHEoEYXxnVRGZLkc94gP8OIdQS8IV40LU//q1nMhcExAEYKLmBDMuE6GN?=
 =?us-ascii?Q?X7Uio6M2BbK5vjrpXWsQsbQGXvpQfPnEB3kf2nUbvPBgi65tH/GoR05HzqC6?=
 =?us-ascii?Q?SwGR2aoSu1ZLaZhOWiPPsy6gDKLl/XTTYmLAecmk6XPFItXk77e6jZ3nYO3r?=
 =?us-ascii?Q?7rwIBxX3MB7NEpEcggK+XRVTdPxinyJHBu7mfckA0FuyDk15Dq5jgMStSeGK?=
 =?us-ascii?Q?p5xUTevXN5h6tGibjDTH3h788XrZWaBws0DoBbFozKJg85Tc5tHC8JlpgHIf?=
 =?us-ascii?Q?1gqYsnv2SswdIR1mjODukJqPG+3PFtE7G2ujY+qEPQsfTpqZDm8cCIR8PdG9?=
 =?us-ascii?Q?HoxA/tVvbADU4veS0dAbGM98AtkM7o95KAsrRl4zK9VOxlzeJIewaCPPQIxx?=
 =?us-ascii?Q?FQ88fNzVgoIpArFxgNBsIWdIW8vhI6WAlDIATOIFs+NMWSCT00IGWdipkBlA?=
 =?us-ascii?Q?SXEfcAB82NeE1iFRwZMFWvSVzMZ0xAZbj8FIPYM/EGeNJipVMy0/igIb7/Qd?=
 =?us-ascii?Q?8RH/o8jhFyvPv93pGPP8mUNatQEubtBNmls0lr86mVEbPLzGcCLGQvqi1Rb5?=
 =?us-ascii?Q?5jZ3/4DIJRnvluy3zn341/Pk9lrQSGVGxe14m6jEDiMgMIik+UroyAkoYNQi?=
 =?us-ascii?Q?Kf7PTYi0sSsilEMh62veEvnvHIS8dm7Drt8Za8Qv9gkBpzkE30TkcKV2AKLh?=
 =?us-ascii?Q?xgwXfoVpbn8e+wZc8bCfRjOmqT6T3gOvfdgE6mpaikt/8KODA5dYHDHD/RoV?=
 =?us-ascii?Q?uiMEsIKLhOExwaeH1KnBxy4kU7w/goDrWtyxbNcppsmJOvZewtUNUULKWaNV?=
 =?us-ascii?Q?Tq3gFg/mfFMzZyty98t5LjgKVSVIcdJIzteRtg2nHmmM9YNZ11M2GRcIEWfc?=
 =?us-ascii?Q?sSW3xWbcA5tHSVvIm93mEeggOiqkQG8mp+ncX0n26sUam5IcR6NamAQqo3Zs?=
 =?us-ascii?Q?DSkCvj6MOQbh+6UH8m4+yg3bW1dbFaJAb5dXA4waH1hWOYV0K7r5rFcaru43?=
 =?us-ascii?Q?dW6nszLhfLVndpf4AB0bwzK11SucyTLyuJnHIi5Hry/Hg/ao4kZ3Qakx3Yix?=
 =?us-ascii?Q?T4cBg95/Y2PTYta8u9P8imxj6e6rJgoNkjUpVZ+uihw4sIG/TBF+zqOKjnjv?=
 =?us-ascii?Q?nziXoiOmhxBVhCDAe+Esv+xssMdubMqGyXREYW+s9QNg9sVh0JsWkrqCJmPt?=
 =?us-ascii?Q?Zlf55qpFpbw+uFtMJlW5KfQBH4aBA+QuJ8xxjrPBTDA4pR18Csh+ICbEJVQc?=
 =?us-ascii?Q?mL8kBkAiaJuElwNMtwzo4YfCsOsRi9s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c340f0a-8db1-44fd-d5d6-08de5277f394
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:47:07.7146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BGEtVBU+g3mhGP32kjVu4QXQbBGCn6X0Sxhem8R0+XVcoRgGOkQm/i+kaHASJZz90xKVYqkgVgVsWarcjnKRiyuCLiRuk/m0QgvN8gzI+9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

This adds support for command encryption for sensitive HCI commands when
secure interface is enabled. This commands containt sensitive data such
as Link Key in plain text over UART lines.

AES-GCM encryption is used to encrypt sensitive commands using
encryption key and IV derived from traffic keys.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
v2: Fix cocci warnings. (kernel test robot)
---
 drivers/bluetooth/btnxpuart.c | 81 +++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index cabed02e0964..e2be9012ef58 100644
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
@@ -2682,6 +2684,71 @@ static int nxp_authenticate_device(struct hci_dev *hdev)
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
+	enc_data = kmemdup(skb->data, skb->len, GFP_KERNEL);
+	if (!enc_data)
+		return skb;
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
@@ -2885,6 +2952,20 @@ static int nxp_enqueue(struct hci_dev *hdev, struct sk_buff *skb)
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

