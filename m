Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A62305E3B;
	Fri, 28 Nov 2025 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321358; cv=fail; b=rkRDNZ5RktdfGvFOk5SyJZN6sfDLnjHXsaAl61II7jizeKIoeBEXUjxvJVWMWc7cdSVwUYrtRP4HaQzt1MksM26lxa9NOjdsBLaDJnd0l2ghoiytbx5c2yosplmS/Nr7saXBUIvorsWbu/CQxKkfWRHu4v9kcmzagFBZvP/Fp6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321358; c=relaxed/simple;
	bh=MWhA2gh+XBoFj+Ck1/Hr91rPrUZ98eyGvCaYZWcV7OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YSOipowWyuaAeHHTcAUpGVBU4EymLuhRG6Bs97fQNHmgUCJ8L2docLSHLIaq78GgFCIzU1CWiuvOqyiyB5p97iqb5Xs94DNRr9nj8ga8m0fAqjKXogX3o+A/9WDg5EokipiOltrPn1TyYWLaGsKKyPb0Sa5v/Q6P2Fvog/gXmE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WjYb4LCT; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WjYb4LCT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltLCufKWRMyTXMklC1qtIMpWY5/yjbprsDkTauO9vfOIamK8pClUWKPg2KOWB+SgiZR1ATZHlCijXnbdX4mkC+OynIg++unP05OJ1JyNd+lxHzHKsqJ3sEPmgNuhAi+nkwW2iNiCHSCN9U1UjgbYrb8tBv+fyDKgA52OShVFQAUC1JUo1+2VjTrUJtSHgIljS0W2sqcsHbbgIjWbsmltdS49vEN3Y/z7PyC0Fr3pDyCvKkdQmK5YECtF6gMuFG9HEcj6/cy/xsILFTOFpJgCf6qFvq5dI+XcGutsLFXNKoQPZfljhcNG6+oNPvQ5vPjQvIxgeX84p8NVh+OhzG2NoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LzgoS5MjdutMLtDtQCIrAgjtRl8ZGvBSRk6aaJ+YRU=;
 b=zKTjC6TgiPuutRuZ9MawK1NXzgkbyfBqWkSijyq4O9cB1c0EiU9B+fl8j61AZV/GsCqs4S9tLy2sG7osJlBZAhcO+YWFImv37hpfBar5Jte+pQL+llfntq6ALxTQq/b3AvnK00i2lciqs0JJykfRjHwKC8V72H0PT/No+XJYyKCa0fzth+5voyIICuxeW6Sb7zwQc8An4KWgjwlul1E9B2sv0L86UKDD0Kp+d2Ah6lZwB1v0C70OEql8GGLAvwbMK7UGKZn9ZCo1pguGtc7L2RT3SQFfSfqm0R1U5ARbQweLHga+/zkgUwOmyUziavWFCv3wdeE/fSMgkgQQl2f2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LzgoS5MjdutMLtDtQCIrAgjtRl8ZGvBSRk6aaJ+YRU=;
 b=WjYb4LCTG0I9xYFWIYObguFte2yCw/G1/BwL5RsIuWD0JyVdSzq3Ky1YbC+mTjTg/nSvIrrGRiMvPkT9OjcIP7kFUIYgjczvmqr9SZEiVxv8oHzYop4G7hHkoCuJ118OhdVRZUkWRYbI4fRFetxSOvhSWWpckjmrvJk8QHCxUpskDC7fiQ9DZqEmoxs+evcAA7j4Jq5dXdXUkvjTtd9mSraZVCj+IB6K/ziudFl9NSG6ssRh319P6ExwwNtlmfiQHueTvPmU/404ounFZpNeQf5gUeFSzAMSHX2i5Lkvi1p61n1aj+6OU0v0WcqnaRifcD9SQ9NUHLpMLlSGnFLvog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 09:15:54 +0000
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d]) by DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:15:54 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 09/11] Bluetooth: btnxpuart: Add command encryption for sensitive HCI commands
Date: Fri, 28 Nov 2025 14:44:41 +0530
Message-ID: <20251128091443.2797316-10-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d4deb8f4-6a31-4d03-6bbf-08de2e5ebb50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3ionOYAihNyVpg6yvc8tJZm8tW385xXIUF5xM2kpQsDIb0H9g/BYycXqgept?=
 =?us-ascii?Q?oGFZW6u8cn0pqOy3ae3UfF4n4QuQNZwhtc9Wq5y1+0IvXZOGyeX+TprahKLU?=
 =?us-ascii?Q?JGNdt+ph6oZRbuTn4DEQSJVTejUHGAvdmHtnySfrJUhWbJtyJUzqmnQ/hjjl?=
 =?us-ascii?Q?YZxtQ6c08T9Rr1JEf5z2vjyMCD8XcOLU3lOKOxNKhN3hVuo4DLELnN103vLk?=
 =?us-ascii?Q?K6RtSwRuSCm0fLPqm1lFieQDDu7ojH8LkvVwvQisHyiGXoqdscxTg/H6SI/I?=
 =?us-ascii?Q?jTMP/tF7wiJP1mrDiazyxNz0oZIN9OY9ad3f8GALWIdMtml2vXi1DduZz8xY?=
 =?us-ascii?Q?bdrwkuRWfWd7cXZj7v4+IlaN5HJ1gJbfc34YgA/y19J8HdrXmUz8VUqCE9km?=
 =?us-ascii?Q?XDA7DG7GYUwI8UbJzwQ9UdtRxvCQx4mU8s3vpYztZ5GBxCp3Fa88+mGWlIhp?=
 =?us-ascii?Q?qu0WvCNycuJPv1u5wVO/s7/5cntWo8wpy9q9sFvm9i5g+BkaF8wvdqkCBDbE?=
 =?us-ascii?Q?jPYWM3MXNzqyPFA69+o4etQsfE0NrbNW2o9IX26Z019JZoE2VvgIA+e4gx0J?=
 =?us-ascii?Q?W7eocLEKKItlCDR0GOdzKC2X9d8H335MBvBoWbRRcXnnd2nVb6NYKA5Y/0Wh?=
 =?us-ascii?Q?5tVRkVOoUKzfptmlnkAcn8ty/dJdmume7VYmABgP2Mly3J97CP2eFnEpuWip?=
 =?us-ascii?Q?NwJWGd25VCCLUWYrK8OZWV9WVdSsEmoekWvxuo0/w58pfZs5/2ms12Y582TV?=
 =?us-ascii?Q?EsYdyIJcWymV9iw6JTyFMYsx7ZlKCwXy0TFJa1lK6HQ8xf7C3NaEldbvDvee?=
 =?us-ascii?Q?vvY/+P11IHIQl2cqCB8VwR2yr2oZ6aBtyitk4qGJefHYiwHUDPfFpO0cQnMe?=
 =?us-ascii?Q?/d10ZIW/cnaOMGXJxOaGUXdY2SKoWAIj4wQsZjh6km9kjYnTFxhkN1XJDofu?=
 =?us-ascii?Q?2AY8Z8fDcylAPU0Qs9DX+96bKMvoFuOOA1cANkN4uQf6gTf0BZYSNsP19vTW?=
 =?us-ascii?Q?PYYZO/MUXC2Uf71nWUQ9nnNAy6APv/tVE9qJDjm7W8qKlJWAmxtcadYCK2ez?=
 =?us-ascii?Q?OikV5s4Cz5FHeDFV1Wn4klrikwAzqXpLden6sbCJKYMwRJZfQ7zf5mnYHGdx?=
 =?us-ascii?Q?9hK4/EnKWNDs30zIg/KDQ5BtQPcEmN4bbuq9X4D/JS/6muhs0I1faS8H2grj?=
 =?us-ascii?Q?VadbUPtaogrcjZi6+8zARrZOteYBie31jQmya4SGEa8bIENoMweDja9AOGSn?=
 =?us-ascii?Q?m5MRAMlLuQpd40HN7Rud+20dBdAUDVV8AjsjDLSuARLUfJrNzKhOcK9yvd28?=
 =?us-ascii?Q?SL9dUIa2Sk1n2UEkspm91YfeKH49nu134V0jkhvbUpRFFsmuNXNW0guf0W3L?=
 =?us-ascii?Q?N5eVodVAf5U3hyci0Y/1jxaMh+OJPLpz+N6jvjBXf4J1wMfadHyGVSkDyjU7?=
 =?us-ascii?Q?aBHUuNLxLXI+CqwOQLJZbdYJkwBCOzPFC/wn/ZQLF6WSBnM5a3HArWIqWZEp?=
 =?us-ascii?Q?uYXgy5LHGsAq+xKZVkkMGYLKBxQ8vRLhY4AE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z1u8m/7J256ncLc+DMuINDkL3+Z0Cdgq0e5M6ZoOGCi8ukvZgafK/kyAoZsC?=
 =?us-ascii?Q?g1sUPmQzrZWK+Ycdj6THc+daU1rf4tAUUh/S9D0TC2f1lMFitu/NNLlZfx0L?=
 =?us-ascii?Q?k6SmYuYNNG+sYmTx4e94LJI7gjuM5XHVdDX+3NN2ynjBusx4vFPd2haI8JLF?=
 =?us-ascii?Q?qt1gUDT4p6w9McUwpe7wmjbwvQSeoOtOVTZAo+L0vdyEFqYnaLxqF0AHPvGk?=
 =?us-ascii?Q?K627INNfgl0dIDFbPK0V+BR1vRKaAHpEpy3Ijnpf4dEwqu2RRscasoRqga4l?=
 =?us-ascii?Q?QdAAO4odSEBxgA2EQlRJ/vl84kPffEdGEpPYiH6V7Uq7LKNi809yur0XrKg3?=
 =?us-ascii?Q?sHExDNC/DnY93vluSWSmTZR9WTNGkBtEsfzGeIidaNlI2k8rh4xjqPoz4EIY?=
 =?us-ascii?Q?h5XdA2GM2c4mfxLqwo5/xyAwvYLBMlGEY5PK5h6IQR8sCxFRFKwGHTYvUq74?=
 =?us-ascii?Q?C1NGXzwY6nInYuPMao3C1cMOjosW+lS7oYf13PDgYlyzrO+aqEpLArXAAxOK?=
 =?us-ascii?Q?vBPHS37MqD9ktF+dyUzhRaa0/TyNEB4ihVwv9g9PYmnwSzGk/Y0xLec7hHyr?=
 =?us-ascii?Q?LIGqbEd0XxiHeQivzr35Vl5jS2YvnbsAm4RvwH5AlQRH3IalmDRa1so+XaRu?=
 =?us-ascii?Q?QxRVmnEk++vOogoQJ84nQQiEapPw1sFl4EkcyMQrsw9NNwHoQY/9NXk/MOOO?=
 =?us-ascii?Q?mlnolWt3DuARBpkh4C2zzFL7kSEAC/U3h4KgJHXvKm0vsdN1q0SE59iixNrs?=
 =?us-ascii?Q?Lnd2xbzMpm0NWyqRvcylX/nmfN9fqmavjXqvfzhNUKda7QMl3hrPl54miBRP?=
 =?us-ascii?Q?yWqyJGh2EnOaIwM0g81e79PHk1ZPaVdfq0K8q/3tJWUWLpYIOx4uXttNDs9+?=
 =?us-ascii?Q?5gII4ErfAqPB3vl3RWYf8TEXqgl/TzlcLChqLqMetsGU9jr7XyGkStlalZS3?=
 =?us-ascii?Q?S9azMl8MfC6UUYhZV4YWvxtPpUVMS6gJNTXQm8qoeCbmfv3FDBfjZRdBLkJZ?=
 =?us-ascii?Q?pukxXqFqpOZyToWiCqOGKMfZIePLoDS9Aw3USBBO9xNtTrs+xqMRpl/WnHyh?=
 =?us-ascii?Q?k28iluE97H5PBYGJtl3l5DBaTtSer3j7I5pVfzwJecM5kHAMQ3MtZFO89U3J?=
 =?us-ascii?Q?nwUfaPkrEeHdb+UEV7aRJkM3ZiElJTnQ08HSAOZ9Z9/4R5N93W5kfdtdM6sy?=
 =?us-ascii?Q?wvJHEe8Cmww+b/MANXvsYOJl43zkV5YZ1Mi59Op96iDPDit/YfM0gkbSD1hK?=
 =?us-ascii?Q?jZJ7LGFf6KV4i861/hal9ZcjIYA7CwBn4cfcp5eZornHb5nrPfBFix9DSvkB?=
 =?us-ascii?Q?CNCzgT+i7NY/DdQI1aMfE2eTDueQandeetHy3xJSFWyNNXvd2pV6n56aLaKy?=
 =?us-ascii?Q?p9i4iDUG0aPK7RwQVUIFzZjwqxreHDXNl/DRW1vuK/P4rSZ5ekurog9s0ELS?=
 =?us-ascii?Q?IiPaW/HBPew83V4SaNyTJtcVh9igDitFDg9ei914zBIm+fDTLmWZwwaoP8HX?=
 =?us-ascii?Q?+IhOdybhzrtjZLCbODz39zTquMvQpxsX1LIv1t56L949rFTeR8HwRsN99Nxr?=
 =?us-ascii?Q?bc5jW1Cv3Mzo8B6pMBvmvz8zGppoDkyKfmbf1lWRnw+1167zXeEfy1l/5dhe?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4deb8f4-6a31-4d03-6bbf-08de2e5ebb50
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:15:54.0649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1aYlu89Gg3h6uCD3nX8twE2CirbEbQUbjktMtKo1RaW+f3+CHscyGr4x67TpEZLLH9ZOLMz3x8RNWmKuWyf1ht+SIpks7gbGUaPaInu9C00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

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

