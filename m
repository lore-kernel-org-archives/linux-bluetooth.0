Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010003.outbound.protection.outlook.com [52.101.69.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03591361DBC;
	Tue, 18 Nov 2025 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475669; cv=fail; b=pG0zv2dnn1k/huV7D2pUPjV7JUfCO53enKi2400/eySw62dYsbsF1lEsC+YIqjQixIQtm00spSj9My9GFLDV8lKa8eU39z10fvktT5Beio0Y/vIqp9UDMPPCxGqiFVXrp/5jkVl/ONGG8jdeo2boh3uFXPZg026pEchU0M9sbRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475669; c=relaxed/simple;
	bh=0A0KplehZ5pmzQHow/MldKJbyWHQGpxoevJIfHuYJxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKq9CdYg8qE3FLOzepLvV08pXhPqudOFKwS6kViEwUIbpV2UVUOcvLfy4vWBhb5cu3eYd89EW1F0onRUVMIdn+BR+ljAvVmk/IMMcjaDL/Kw9wXuNE3IMBnIPMGZ7sTc/KxSVXD/25hXVoar5WZvL9JP8uCxj9LWjVe2mMQ6XCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cp3wzuTb; arc=fail smtp.client-ip=52.101.69.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cp3wzuTb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gOH2hjv1OXhePs/ZWuJh5BA7gpGZnXTdcZ98gYB/N3CzijksQKwL9EhKZaW6hS6xRQesstc9/XD4XSziQV9ZuXP0aGwgDG4ijznHycEHbtkPSjbZReQ4m8dHCQdBddMlpsyrszh22lrGALHHM/JEdt9/o/XwiBDLm0tzUbFuyBvWksyIPRGPOU4bXTwi6IgMeql0Lf2qBqiSOrIMxoBFcWUhg+W4YStdNcX+k8zfzM2BSY1+SDiIy9QB4m34K+E49p3A4CeGxlU9o/lzJriaF1PVGt8RQYlPzIpU8mizrRFSSJA47f5XeYg0nvUjm0bwxumrIhaQVDiDCCY/k8OfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0AAjYkjMGlLRRQ2kw3/VMLg5hAgmMhI4mwTjMUh5vc=;
 b=rThc0Mv22dGzflingjyjHLIFKamTs1hIyXEGFxOerBDCb2m2GMhfOtxX5qpC1ttnHcMfD/6EUaWdCrEJy6l01HKH9ln5cDFhpaa5SlunwIPP7CtlgBm0H9vFv+xgVu+QpX3gFIis1IKBh8w51K/9BbA4Jh23JVUEdbCntxTi/16nxtHVJWThaMtmitu1Otf4eWz54AmxP8FwaDFkNrGqv8833gxw4OSEXUljUJCXUdTYVPP3VJkFRsYf1pCcqC8nVpqcBFAyj8OFB13g5cBpsvTL5ogxifiKtgugAiLsdxr/hrpRIWAm1u22fAMNWs8nYJN47Ri1C5Ovrl7ONO36tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0AAjYkjMGlLRRQ2kw3/VMLg5hAgmMhI4mwTjMUh5vc=;
 b=Cp3wzuTbnCnMu7e/EDdMHT3d+9cA09a56cTPcNXdDXp6p+NxmIAFw1Jx9V+qLx8BkMAUefaePWDhOScQUF41B/kbPTMGYJ8IzFz0yrNywlhZENa3GEy8j+Kx1GrVLqvrkygxAEBTgrHyeceBfYv9N1IWXeDdccc/f6H0WOGL/QHkEqvbbAK4F7dqrvz6PBkctjE2v+Q+y7Z+BnrxPH1GsVPOcEFm3h2cneJvF7zv7H7LQydUxQ1wWgsfmYytJdYNRvOm+OmwjhUrCqh180YaRO941YfqUmUAXewXVOQ54+2lfQlTDqClv3V7PJCbtgvpqLFcbARtSaPyZ+5VIrONdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB9PR04MB9284.eurprd04.prod.outlook.com (2603:10a6:10:36c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 14:20:59 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:20:59 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 05/11] Bluetooth: btnxpuart: Add TLS host hello handshake implementation
Date: Tue, 18 Nov 2025 19:50:18 +0530
Message-ID: <20251118142025.1982263-6-neeraj.sanjaykale@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DB9PR04MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 505db066-91ed-4023-a063-08de26adb246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?omyDK9/xhKRunYybGUBvhrzi1tVQWHO8VxglgnSkgn1KbI521nQF88Bd9bBl?=
 =?us-ascii?Q?kMtLCIKmQ7nZJ9QSW3t4CO/l17MLeWPEaqMiDS4nX9OSlgBxvfsxLIyqY51s?=
 =?us-ascii?Q?wxyR+N4bzbJc00u4oXYWzqeFJJ4Hz5KGEORpWnNHr5mKasu4G71dAGTwdOhb?=
 =?us-ascii?Q?NWb9IUC9ij/HrM4nCDLzi+mhGLtA3Mp6rgkxkwMilFh6RoHhsgXpNhb67SvH?=
 =?us-ascii?Q?Mk+aMQNRa2MwHF1Wtlcuy8Ta5UquhLdapVZfNsfkIC+A6m+Kwx3g+m8PYCKa?=
 =?us-ascii?Q?8jKzAzHQYdBxHo0/99nvdN7QcvOFS6blpy6OJ1h5VvIWighfbv1LyJgxrop5?=
 =?us-ascii?Q?UfHzNNXvkhfTA0ewsO2I59ZokTLmHX3JHNoNdJ00Bj6/T+WXPPNe9GtG4YBP?=
 =?us-ascii?Q?ZNKpuvXosDdCdaMW6bxpnr867kTN53tqFNLf0jhGIOjmLCF88VefAvcAa7dK?=
 =?us-ascii?Q?JpQdpzc8YOyWAkHJKs8911/ucfwEgBfadOibOOMW9ZcobP6XRcS4hMaDBUx8?=
 =?us-ascii?Q?u6C2uFAAXdt10C99Z9hopiBA7gNykWL78TTrilAA+FaYrwp1PcU8vPy2iHu8?=
 =?us-ascii?Q?QEDUIZE6ALcmiuXbtVYOokKY4JfidAEt2YdAJDy3OAC7ANRF+sBRtbneHA8Q?=
 =?us-ascii?Q?E2ZU5lqY24YNthRQhdtqdFMgtapUJlqn+IvPnDhzVWILJCJPKF5bzl7WSJUu?=
 =?us-ascii?Q?Yu8w2s5S04/ie44vlgGQwK8GLgrR/iQR9AhnO+KQBCY9nVdWMSOzAnKh1tnB?=
 =?us-ascii?Q?0Zy0LbjJvk7NhZF8snW7nKge3CqVLztK8/as5+/0cw/fHm7RQT52/3fV4MqM?=
 =?us-ascii?Q?xWjIpPYgDoKPnarWlq88kp78gd9ikIvtNdIAbJdiY0guoYxIwYydYa87Qkbp?=
 =?us-ascii?Q?cfnbBGrqt6LBnLVbqU03jYaaiaKfe8H04wf7afCV/J9WgrAWoBihe1HQVms1?=
 =?us-ascii?Q?F1QsrezujBzyH3tLCQSP89qJ2622kWmEotPLM61u7rg0oX2kRGr0bJtubUly?=
 =?us-ascii?Q?5kL1KM6gnKeqvReTvchf5oKlcxFWYSCw8FsE++r0jmrXe8YvXT7KWcUMz5It?=
 =?us-ascii?Q?I4bWcOrDUpcUuAaL35I70B7JKT3KsFIBC6zAT0SvUZFje2pgtb/oGgItKs/7?=
 =?us-ascii?Q?EIE1wMM9+qT4rxzGD+o/iVLGJlH4VFQQbh+lwlazEjOI4dsXwe5zdjZ6HcJa?=
 =?us-ascii?Q?1uVId/2LshsA7jXGiuWNKmxUp8RBompogmy4AofyUSxMsqhHPIz/rm6zqj3F?=
 =?us-ascii?Q?W6mChyjQJpiS5MX8S51aqjRRGygdqa4xgUvezVpuR2CVHDYeNdthTHBtji6J?=
 =?us-ascii?Q?riAzt03LXPMfW2OPee01LaDg8f5j8o0yWbh6ug4hQDNR6PpE7CIocslVQNGl?=
 =?us-ascii?Q?MTF15dKF2D/Yeeihi9OXP3Z1LLCAVvinbsrYVrDIB03WQqlIJCa4kMLj4HN/?=
 =?us-ascii?Q?vt3RP0BANaMOEYKIlRWYWJDmnLfLHIUFI7/8Vagzh1718AI9z8kycNkYPoEz?=
 =?us-ascii?Q?jK1AP2tqod0zxEFk5EQZyr1uDFH4onTu+w2D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qcSx95d78TtWHinCsTwTW72bXxk8nQKbnu6HCmec7p5k0AgPmwggadv5Wk4F?=
 =?us-ascii?Q?w5oPsK4/X9oxGvDP1gORLI/EN3tTnwzSkVxop1MWP9b3LoKBLWEAnlVq8I9G?=
 =?us-ascii?Q?Dhl8acAJ6XoN6TMR2076310hAShLjMY/G2c/233YAPQztXBoU6mB4TkplvgD?=
 =?us-ascii?Q?MItN/eqR2nThkZPPsUWC9UG8lH5tixKGZEDqR9hTW+fg6CGFho9U5/0WKgWI?=
 =?us-ascii?Q?klBh/xle0R1qhKndx+p7jy69lnt2EcCTlpKesIagtFNwwi6LX0x+fTW+T126?=
 =?us-ascii?Q?SILGQSpwph+bc/GM4PuohLOyi9IfWdw5EksXj4w1Vn561y70eENxwMiZQxNQ?=
 =?us-ascii?Q?K6aLxIIPIQlgJ7VUBv1Q3Jhauud/7LogG1wLKuy5DWrlPwMISYvpspd04l3m?=
 =?us-ascii?Q?RjfJWRCDZLkbEw1HrI9dSfQWnu5S8L7YI3tsRnsLxTJjy19I6ldUur2EkRrF?=
 =?us-ascii?Q?Y9icd6wu750ncIL0DcZnj6i8Gfz5vYmFRkJvA1mBPlFFitRoest/VZ7Q/8xW?=
 =?us-ascii?Q?l1OExTeDiMxjcAXD/q12UdtleRQiDANBxBiz+aGoSBW6LG7881MY6oZkBX+X?=
 =?us-ascii?Q?rVzpK3XO2CmP5ijLQQhXJ234N6PpeCSYGmdQkCiMX2Rau5VHKzVhEnNol3fX?=
 =?us-ascii?Q?hfOGaxTP9mdFoSqmdOkAH1cGiZ4XstiWbZUhj9P451UDVZhh57CsRVY08l4k?=
 =?us-ascii?Q?sZ2QvhmDWMjTl4R8JniwY8HxMUkYqa0j81NB30fesnLwvKbX/xrZjVCGr7LW?=
 =?us-ascii?Q?lZPD0ozaiQ1FS9s7n2li2PVH7Gfug5ageQ8WYlsvqjUKRg0Jyrf/8Bg+9di9?=
 =?us-ascii?Q?t/MYfgFZc/mirGnrRitqmbqvG3Pu6DnqUrphg5Fq2MtMx/1pPm/JVTfdTqhh?=
 =?us-ascii?Q?ixvoOpK50ggOy/5KuLz6Yy4wGgM+hSdAN/ogpEuo9/MVam240MYxt/59JZue?=
 =?us-ascii?Q?Vtuwr4I/Jn0JJZKlMryHUpQGw2RwP/OdINJsPkwD7WF1XhcpjGVsHj7TeT/n?=
 =?us-ascii?Q?9Ru4tu62VJMIzWWDaChiE5kFPQ04NeVIFmH3OJomFcLdFsANd32eVghP/RgF?=
 =?us-ascii?Q?mHN/B2DhFZcG1pz2e4a/JkG4uWC6SUPz7FBZHAPMDBmiKbUr3AHSV4KGKPC7?=
 =?us-ascii?Q?ziQVDd3+792siUFFIjGBxvmvNvfMZQkj+fGP0D5unf6TBySobVhgTtADHIIS?=
 =?us-ascii?Q?x9Ze5W8sUk5KfWDHzgs+RJSzCwovtiRnlmhQYR01KhWMJXeb6Y7QQPYoHrkz?=
 =?us-ascii?Q?Kt7I3WjyBCFvr6L7C9vjVCx8Pg+utbMWfnZkz1fMNWhq3QNU0zkIvT+JWqKT?=
 =?us-ascii?Q?x5vQ/azjE1P46GyjyoE0LtIBxY1/J15+fbNO9wWB8DRr4Yy6l3GtSzEdt6ra?=
 =?us-ascii?Q?2QU5jFpeEXbCBojYp50CE7vvIz0c8ynxfVvObSzvPjI13HoSKKv/srEG4kSW?=
 =?us-ascii?Q?Tb10710qkJ7viYltIjwKGX8VbSsBT4Ew+E6JkSRuUhKPXWlxDHpw8svdrZHp?=
 =?us-ascii?Q?GqRtrg3yaGAskT3DcRjDMeG7jO0+dWNbROxMRw+oUHskQUZk2Lv+kxCtqZF0?=
 =?us-ascii?Q?FpkH/MKHZUFBjBGAj6ydSe4loCEeXXKH2IaNyx4SN84+QpsH/cIn/w3IO2x/?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 505db066-91ed-4023-a063-08de26adb246
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:20:59.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsP54PSc8iSp6p1Tq3eW8H5DQhu3H4qitieyj6ADEp63jWKVirnVnDjjJOOWPO3l5Ow4jmg4gF0BqdIrYhZl0pItjDLsmJKqK95rZbiEzJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9284

Implement TLS handshake initiation for secure interface authentication.
Includes ECDH public key generation, host hello message creation, and
handshake hash computation for secure chip authentication.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 189 +++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 3a8fa5266eca..44073eae0df3 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -26,6 +26,7 @@
 #include <crypto/sha2.h>
 #include <crypto/hash.h>
 #include <crypto/kpp.h>
+#include <crypto/ecdh.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -124,6 +125,8 @@
 #define HCI_NXP_IND_RESET	0xfcfc
 /* Bluetooth vendor command: Trigger FW dump */
 #define HCI_NXP_TRIGGER_DUMP	0xfe91
+/* Bluetooth vendor command: Secure Host Interface */
+#define HCI_NXP_SHI_ENCRYPT	0xfe9c
 
 /* Bluetooth Power State : Vendor cmd params */
 #define BT_PS_ENABLE			0x02
@@ -388,6 +391,55 @@ union nxp_set_bd_addr_payload {
 	u8 buf[8];
 };
 
+/* Secure Host Interface */
+#define NXP_TLS_MAGIC			0x43b826f3
+#define NXP_TLS_VERSION			1
+
+#define NXP_TLS_ECDH_PUBLIC_KEY_SIZE	64
+
+enum nxp_tls_signature_algorithm {
+	NXP_TLS_ECDSA_SECP256R1_SHA256 = 0x0403,
+};
+
+enum nxp_tls_key_exchange_type {
+	NXP_TLS_ECDHE_SECP256R1 = 0x0017,
+};
+
+enum nxp_tls_cipher_suite {
+	NXP_TLS_AES_128_GCM_SHA256 = 0x1301,
+};
+
+enum nxp_tls_message_id {
+	NXP_TLS_HOST_HELLO	= 1,
+	NXP_TLS_DEVICE_HELLO	= 2,
+	NXP_TLS_HOST_FINISHED	= 3,
+};
+
+struct nxp_tls_message_hdr {
+	__le32 magic;
+	__le16 len;
+	u8 message_id;
+	u8 protocol_version;
+};
+
+struct nxp_tls_host_hello {
+	struct nxp_tls_message_hdr hdr;
+	__le16 sig_alg;
+	__le16 key_exchange_type;
+	__le16 cipher_suite;
+	__le16 reserved;
+	u8 random[32];
+	u8 pubkey[NXP_TLS_ECDH_PUBLIC_KEY_SIZE]; /* ECDHE */
+};
+
+union nxp_tls_host_hello_payload {
+	struct {
+		u8 msg_type;
+		struct nxp_tls_host_hello host_hello;
+	} __packed;
+	u8 buf[113];
+};
+
 /* FW Meta Data */
 struct fw_metadata_hdr {
 	__le32 cmd;
@@ -1607,10 +1659,137 @@ static void nxp_get_fw_version(struct hci_dev *hdev)
 }
 
 /* Secure Interface */
+static int nxp_generate_ecdh_public_key(struct crypto_kpp *tfm, u8 public_key[64])
+{
+	DECLARE_CRYPTO_WAIT(result);
+	struct kpp_request *req;
+	u8 *tmp;
+	struct scatterlist dst;
+	int err;
+
+	tmp = kzalloc(64, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+
+	req = kpp_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		err = -ENOMEM;
+		goto free_tmp;
+	}
+
+	sg_init_one(&dst, tmp, 64);
+	kpp_request_set_input(req, NULL, 0);
+	kpp_request_set_output(req, &dst, 64);
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				 crypto_req_done, &result);
+
+	err = crypto_kpp_generate_public_key(req);
+	err = crypto_wait_req(err, &result);
+	if (err < 0)
+		goto free_all;
+
+	memcpy(public_key, tmp, 64);
+
+free_all:
+	kpp_request_free(req);
+free_tmp:
+	kfree(tmp);
+	return err;
+}
+
+static inline void nxp_tls_hdr_init(struct nxp_tls_message_hdr *hdr, size_t len,
+				   enum nxp_tls_message_id id)
+{
+	hdr->magic = cpu_to_le32(NXP_TLS_MAGIC);
+	hdr->len = cpu_to_le16((u16)len);
+	hdr->message_id = (u8)id;
+	hdr->protocol_version = NXP_TLS_VERSION;
+}
+
+static struct sk_buff *nxp_host_do_hello(struct hci_dev *hdev)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	union nxp_tls_host_hello_payload tls_hello;
+	struct nxp_tls_host_hello *host_hello = &tls_hello.host_hello;
+	struct ecdh p = {0};
+	u8 *buf = NULL;
+	unsigned int buf_len;
+	struct sk_buff *skb;
+	int ret;
+
+	nxp_tls_hdr_init(&host_hello->hdr, sizeof(*host_hello), NXP_TLS_HOST_HELLO);
+
+	host_hello->sig_alg = cpu_to_le16(NXP_TLS_ECDSA_SECP256R1_SHA256);
+	host_hello->key_exchange_type = cpu_to_le16(NXP_TLS_ECDHE_SECP256R1);
+	host_hello->cipher_suite = cpu_to_le16(NXP_TLS_AES_128_GCM_SHA256);
+
+	get_random_bytes(host_hello->random, sizeof(host_hello->random));
+
+	/* Generate random private key */
+	p.key_size = 32;
+	p.key = kzalloc(p.key_size, GFP_KERNEL);
+	if (!p.key)
+		return ERR_PTR(-ENOMEM);
+
+	get_random_bytes(p.key, p.key_size);
+
+	buf_len = crypto_ecdh_key_len(&p);
+	buf = kzalloc(buf_len, GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto free_key;
+	}
+
+	ret = crypto_ecdh_encode_key(buf, buf_len, &p);
+	if (ret) {
+		bt_dev_err(hdev, "crypto_ecdh_encode_key() failed");
+		goto free_buf;
+	}
+
+	ret = crypto_kpp_set_secret(nxpdev->crypto.kpp, buf, buf_len);
+	if (ret) {
+		bt_dev_err(hdev, "crypto_kpp_set_secret() failed");
+		goto free_buf;
+	}
+
+	ret = nxp_generate_ecdh_public_key(nxpdev->crypto.kpp, host_hello->pubkey);
+	if (ret) {
+		bt_dev_err(hdev, "Failed to generate ECDH public key: %d", ret);
+		goto free_buf;
+	}
+
+	ret = crypto_shash_update(nxpdev->crypto.tls_handshake_hash_desc,
+				  (u8 *)host_hello, sizeof(*host_hello));
+	if (ret) {
+		bt_dev_err(hdev, "Failed to update handshake hash: %d", ret);
+		goto free_buf;
+	}
+
+	tls_hello.msg_type = 0;
+
+	skb = __hci_cmd_sync(hdev, HCI_NXP_SHI_ENCRYPT, sizeof(tls_hello),
+			     tls_hello.buf, HCI_CMD_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Host Hello command failed: %ld", PTR_ERR(skb));
+		ret = PTR_ERR(skb);
+	}
+
+free_buf:
+	kfree(buf);
+free_key:
+	memset(p.key, 0, p.key_size);
+	kfree(p.key);
+	if (ret)
+		return ERR_PTR(ret);
+	else
+		return skb;
+}
+
 static int nxp_authenticate_device(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 	size_t desc_size = 0;
+	struct sk_buff *skb;
 	int ret = 0;
 
 	nxpdev->crypto.tls_handshake_hash_tfm = crypto_alloc_shash("sha256", 0, 0);
@@ -1634,12 +1813,20 @@ static int nxp_authenticate_device(struct hci_dev *hdev)
 	nxpdev->crypto.tls_handshake_hash_desc->tfm = nxpdev->crypto.tls_handshake_hash_tfm;
 	crypto_shash_init(nxpdev->crypto.tls_handshake_hash_desc);
 
+	skb = nxp_host_do_hello(hdev);
+	if (IS_ERR(skb)) {
+		ret =  PTR_ERR(skb);
+		goto free_kpp;
+	}
+
 	/* TODO: Implement actual TLS handshake protocol
 	 * This will include:
-	 * 1. Host/Device hello message exchange
+	 * 1. Handle Device hello message exchange
 	 * 2. Master secret and traffic key derivation
 	 */
 
+free_skb:
+	kfree_skb(skb);
 free_kpp:
 	crypto_free_kpp(nxpdev->crypto.kpp);
 	nxpdev->crypto.kpp = NULL;
-- 
2.43.0

