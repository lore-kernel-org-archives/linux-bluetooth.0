Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011057.outbound.protection.outlook.com [52.101.65.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4583303C8F;
	Fri, 28 Nov 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321343; cv=fail; b=lIy2yM8tIvwOtXUtDGk+JMkFaOBtz9RxmnoDl+qzMZtJITYKb8AsAwwD8W4bxDRAyoQs2CmZL91e1NIiDiuKmdrbWTn/SEgJnVpwoen1fXgbKzHp62IhfErW5CrKjCNNaE8WE7csX5pJkRmZiSIvwolHb2DlrUGGn5HKR5RSDMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321343; c=relaxed/simple;
	bh=StiBQANQU7vt8NOjtin5XGV1VnO960B2HpkkBwalbpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XD+kM9+JQzf+IhUBk2tO/s5rgwPvRV3aQVgfxpk6XC1H30SgjKzNJvszQfoa6yt3HfGvF+H+MPuUP4GylfSWlV/MW9l9wIDF3yhXahvewEM+LAUC+SDgQjeNQmuW9f/E5ltt1BDshsaF4w8PqY50GpIT+4tgaxrLvOjlXKZx2O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ulj7DHrz; arc=fail smtp.client-ip=52.101.65.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ulj7DHrz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBr3LHhPY6Oniq8qwRh7nahw59hWhDaEmQ751n6w7R334hQNySV1CUqTJwSxkZcbrUqYERkKnQWNSxubjGLJmfba3CiJN/sdWGk1lr2SB69o3we2bseDQZeJ9uFeHEVJSkPw35gpRUegb6I6zMRBZfRTgA+cyLqWH+uXNf/KvYmNitF4jeyZzP0MSvtL53PqTyxJemRe0Ci/vqx2nUv5iguod90GmowCQqCVLd/7Q7I+YZ5+qMAsQopgz6NJhlnqFvLmSuJ0vkwcYcIoVOD1sM6Rv+fRLbNL20BSapC/EnNLXj8QHbP+La7hXwW8Mg4M7WNzvqz4zczM91DU9BsnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1No6gPYUtemE3JSRUj6BRQbpjTe4PtRmpJnpoptkxBM=;
 b=i3103AB6EWETlZZ8KDa4tbSp4UCfq9g9M9+7qN+H+MZgYNw6veE4afuxv8D/axlIBxnLCh2i0D1kunlApfzi7ay2MlRr1sdJzLsCA2fCn5WOaXkXRvtz0B7cfw4Btwb6sbuV5h6TILUtWCAoXdKjjaS/hTXG+mtI2ikm3acpmFSo6Ex4cU23cwrGfFVoTsXy3L14DxQ3O6hMryUJ+Mow/OyH7KcQawX03DSuuKfMYULxkasnh4pVI8iWqIXorPIaYvubn1JzvROmMWQUvALyiKlG7qW2cwRUgiT7pec1EUzenvRISTcmxlzlMTt77fUJRGeCH1mbakuseg5dwToAaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1No6gPYUtemE3JSRUj6BRQbpjTe4PtRmpJnpoptkxBM=;
 b=Ulj7DHrzI7JgbcNMVSyJ8NiZBaIHkXJSoyBqVWBMtbI1uycA83m4kL2Y+WSv96WlOQEsulIg8keoJTd1ba5Dy36QrFiZphQFjfqnS+HyiutXThS3ICUiW6Q/nLXcmV5dqcKe8Zknl6nso8SodKaFu/wy9F/AQE62aa8y0mJ7/0Jk9RT+UihRd07HA+lEWMTul2UFrN9BGjuYBRQ6wgSFTbtwOe3D8i9442a0LkHXAzgQ/lMwphSNy8zr6yi3mICIFLqzIdTuHF0ZdQK1BI/EZNNEFG05tZqVUzhB0wjO5vqhCYwv+TP56y8Eom68hGRrS62hyfYWknSDbaPb6bQmeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 09:15:39 +0000
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d]) by DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:15:38 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 04/11] Bluetooth: btnxpuart: Implement TLS authentication crypto framework
Date: Fri, 28 Nov 2025 14:44:36 +0530
Message-ID: <20251128091443.2797316-5-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b48ae484-8f4a-4216-d210-08de2e5eb20f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hqxM7ExKynOsju3XgoYXeXeBAsrsBuU1WKw3aa4Qmw1Gy4sc/Yl+ir5hPwZU?=
 =?us-ascii?Q?hqSd7TcbGWfbJZfEUaTaD34b48+f/ce+d5KM0jWpUOpQ7qP3aD4YQgpDvPw4?=
 =?us-ascii?Q?sKzPf7EPHXL1WO7WvS0YH05OQDKjn+Gx/JcNviytDKNkUrtne4xOMFhNZ2KN?=
 =?us-ascii?Q?9r5i5Azx1PGVkIPsCvj/XC7C8G4G4ruWkvdySdqEzRusmnh9f3NeXD0q5TB1?=
 =?us-ascii?Q?tH5BzDVtPrvGVcmtvXmEqpRTiyxY+BkRkZVMisD9u9T7+huraLNvCXv72J8b?=
 =?us-ascii?Q?4eWHyxo2MJ9VoiJ5plV+3txPT1fqkZrfBbYpg6Cw4isJoEr8KkX09/mFqFMw?=
 =?us-ascii?Q?ZllUhGNWzX1qaaQnjXXmDM3gJNfZb4tBbIgmwqpNmMRmzo3xq8o3WdOgHupj?=
 =?us-ascii?Q?QZhEAZKA7qJdJwcWBcDPraRRIL1nRkTVawpxicQeYgMkcPRCGAMfQ4QmZH22?=
 =?us-ascii?Q?by60Lj8sK5EKhB76+CmGQnJjnIHYgXpx/2c9U2BqK1K2AfYueCA3dknbI/a/?=
 =?us-ascii?Q?/ZtgPKlfzH7UMtTeJkCPiJvvrg+oMG6kuqAn/HFEhDV6WJpom4rhf1sYhN7I?=
 =?us-ascii?Q?T3pkrGTViQb4304QwQVbQBiItrsCyrDiA6WXsEbGi/2F33QXXvVULsO/SmwM?=
 =?us-ascii?Q?GZjPPLwOEZmMFqSKpSh3CpNy43LcTnhA6xgIiuNXNIY8eO3Fnrd6/cv+URIw?=
 =?us-ascii?Q?CAirBaH1pQmcvpuzl6MZt9L2MF84gsjOPE0a3FuEE/QAlDUdbM4Vv6zVE19m?=
 =?us-ascii?Q?8onidTEakUHeut7bIeQzQb4DYTtjTu8Ia+cmsC4ak1oiuFJqyHVvwYF2bHHd?=
 =?us-ascii?Q?MfQwelMlohyMZafURvE8CckGCA0O7ZcchzRefV5jNL/35TNA4EG/xM6XHNPp?=
 =?us-ascii?Q?UGFmjJCFHSp7TnCC8DHVUiiJ9FZSitgfDTEMZY9ZLNF+PaRL+sgAXUhfAEen?=
 =?us-ascii?Q?eZHI/3fRYep1z/L+I9sWGXHDdPcsouOhnPdJNvXUwqI6g5ycqPM9DR1RXohi?=
 =?us-ascii?Q?qY0evxiOQz8EJfqgOBDr7qP51HRpGKgVQ4sFED9Es/lc6pYsE6/jZp91D19Q?=
 =?us-ascii?Q?yr4IyXMu+3rOasLr83J5QjhL+NOOSTqUGa5piWUM+UqyYAJ8dBFy9KOZGjjS?=
 =?us-ascii?Q?gqmvsKGVNo+UcJ0djDmFxw7swXeOquXL80sPu9MsIPtiIybvlafnEeAwJ2zu?=
 =?us-ascii?Q?OM1vwjUzqkmHEOQeFipx5QLzOcIswSTQpA4jgej3I8z4Ds3cXHWXt726b2Cq?=
 =?us-ascii?Q?UZYZQa13O1cZxxRS3RvT1OADNR64+T6DEOsVP7idYtuVlRMLgWZ3Qgy6hKz/?=
 =?us-ascii?Q?TdeT4uh2+kVdtWGOAkgyRo5B+2T+VhLBN2hKRTRDIjbJ9Ws0+1XSppt11TwS?=
 =?us-ascii?Q?DxXxrX3Wjsr/1vPSDq73/0xyjbB4AdYMdIfa9IzhHnb3qYbypbX53Q42mYze?=
 =?us-ascii?Q?hlMGGRIZejDm1STCj6K0kNyRntzPo4Z35MS+lwlba0S9v9CBuH+QhXdAstRl?=
 =?us-ascii?Q?0rJV4VZjtDiN7difDTGYia4/08USnCw0jJF9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7hTgfqEiLh1qwdnHQudus+Ulo/+dYIxPT5YBtNoZvi7XDxmz5s/KpBcIRv5y?=
 =?us-ascii?Q?RIgzDhVeMxPd8ym74Qrys2+v2TvlL42lPqw5t5zAF9kt0j1IL+XDvslSMZD1?=
 =?us-ascii?Q?ux7p0L8c4v0nqFoiLl9YZMcdAtx/n2E8KVymU8TryO/xOnv5Zzsk7U7Gp2bQ?=
 =?us-ascii?Q?ITqir1S+//ye7qklmfmiXpgsMHqw6rq6hAuGJaj5enDTH/plppnZbLzgnJgv?=
 =?us-ascii?Q?+J+sMmoUaXvmGMb0Ynd3iP7iz0vF2exLn7xuJ3TRW44bXv6QCmFaFVN6GqMB?=
 =?us-ascii?Q?YI6R+spC4xAEB9HGcXhULiDtrKmEFNAxGSArKgoWMzljIovm84LIl0W1PneN?=
 =?us-ascii?Q?HupHbB5P2y6/KBmsJVmACLc5iRsNdagSas8jgcNhSHAMk2WaBqGcBXRfRAWn?=
 =?us-ascii?Q?bvHbfHHSBBr5UMUPkt0JJyxJ2uoEHShXkX0Sj6ZEsQqOc60mQm1666ALNUhv?=
 =?us-ascii?Q?yR1vC5ZKQZrb0yFljbjvi/zcBR4wwTizcDW1F7i1kU3/lB09MTFcRew5laet?=
 =?us-ascii?Q?Dci9gFJ0m0Md8HrxIc5cSk6zh2d3z7R90qzG6DW/bnKiJP5f4PyfFENiX2xP?=
 =?us-ascii?Q?aGrb8QRvkZGFv0ujfetmYY+c9GypexfI3TOGKSJXTiYAq5faNL5c7pRwe96o?=
 =?us-ascii?Q?mXUyOuaMN8dewGR1dQedhZUO43seuUXBQ7SgZl8velih9pS+BM41oon6SwZX?=
 =?us-ascii?Q?WpBOVOlpASzzZWdCLXBo7yvZz/OiUsRPUrci3H+MGG7SQ9OKEIYPDFzq822b?=
 =?us-ascii?Q?Qp4HZIw+r6BIDnaCr2hW2uOQC4o65gepCv3HN766uwfxnHKYS2vrWyDEL0Vn?=
 =?us-ascii?Q?ro+H/KGWLKi+n4XZNDpPge6/B8CYwP+dQEO5XKT1MeJJUVqsHUn1MdN/t4R7?=
 =?us-ascii?Q?cUypDqmg3PGB6T4mQ3NTp65NGXjQJ6T7SFEBf0uv+6ZJ/P71FubjIXuqKQqY?=
 =?us-ascii?Q?RtIBwCBxz+qJbWDQbh+OES3ogOLWjwovmg289NoIW2h7NxwMQDR85G8J1wsS?=
 =?us-ascii?Q?nAvwk5kZ+1/6M3giuySRm46jPFoF2UKnZ5Hegc4IYi+ptYKleH2+hSW45gKX?=
 =?us-ascii?Q?pC1i9FMY5qTx66SyNn214a8uafSMvwv5p29FJqoqCsVU5XaOyHd7nrJJVpH0?=
 =?us-ascii?Q?hy9YitBxr09BMKufeEtp/T5uLZUbGU7NCcHKRPJzvDCXq33A86XhVOB2kZpQ?=
 =?us-ascii?Q?uznwaeSPs76vZ2ecxGaZ6samO/n4SkeR+spXO+I0tLRT9YQex8+/OkWQJlVk?=
 =?us-ascii?Q?SW6Ih22XL9C7SctI/Cau2kA5Ljd5fWDxY+uW2Ejp/ZkJ0bX4KWbdHm0o7cJK?=
 =?us-ascii?Q?geT+iETDP+rxiAEUUa1EmWvx3PiIbWUmka8LrysiyunhFDU3ARHsGV2iu87Z?=
 =?us-ascii?Q?i9q/0yq48OYF9cr55w/ldcc5M00SxCSBqXF7R31fmvCThCw7NvwNG0Bj9siz?=
 =?us-ascii?Q?TUkI21dBffQfJolqe0Dtcwr4WEKxuq8zwEgTWH1A+CMbxJ73PPchLG/JnY1E?=
 =?us-ascii?Q?qSmHmHn6SQzNYZy5ZVOWdy3ncAMrjwX+iFnBe3y//LORdGrcgFoCiQ4yLBw4?=
 =?us-ascii?Q?e/OE/1clJm05Tmz4QcytF5J4J3xV4uu4DTt/dguBE3DIhlvKOse+ABZEfxuZ?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48ae484-8f4a-4216-d210-08de2e5eb20f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:15:38.4522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MumUox4HJJrXC7VUOVDVZHfYVU+1/MNzI5cVIiCgj/cUXEZ/rmbi/xWjQ28CWJUZwb+OrwXPubkBXsYNPCdn2y6spDmxG+yZutTZrFQk2EM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

This adds nxp_authenticate_device() function that sets up cryptographic
resources for TLS handshake authentication. Allocates SHA256 hash and
ECDH-P256 key exchange with proper cleanup after handshake completion
to maintain only traffic keys.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 48 ++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 3455460d30f5..7c94d8ab94f3 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -22,6 +22,11 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 
+#include <linux/crypto.h>
+#include <crypto/sha2.h>
+#include <crypto/hash.h>
+#include <crypto/kpp.h>
+
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
@@ -192,6 +197,9 @@ enum bootloader_param_change {
 };
 
 struct btnxpuart_crypto {
+	struct crypto_shash *tls_handshake_hash_tfm;
+	struct shash_desc *tls_handshake_hash_desc;
+	struct crypto_kpp *kpp;
 	u8 ecdsa_public[NXP_FW_ECDSA_PUBKEY_SIZE];	/* ECDSA public key, Authentication*/
 	u8 fw_uuid[NXP_FW_UUID_SIZE];
 };
@@ -1602,16 +1610,48 @@ static void nxp_get_fw_version(struct hci_dev *hdev)
 static int nxp_authenticate_device(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	size_t desc_size = 0;
 	int ret = 0;
 
+	nxpdev->crypto.tls_handshake_hash_tfm = crypto_alloc_shash("sha256", 0, 0);
+	if (IS_ERR(nxpdev->crypto.tls_handshake_hash_tfm))
+		return PTR_ERR(nxpdev->crypto.tls_handshake_hash_tfm);
+
+	desc_size = sizeof(struct shash_desc) +
+		    crypto_shash_descsize(nxpdev->crypto.tls_handshake_hash_tfm);
+	nxpdev->crypto.tls_handshake_hash_desc = kzalloc(desc_size, GFP_KERNEL);
+	if (!nxpdev->crypto.tls_handshake_hash_desc) {
+		ret = -ENOMEM;
+		goto free_tfm;
+	}
+
+	nxpdev->crypto.kpp = crypto_alloc_kpp("ecdh-nist-p256", 0, 0);
+	if (IS_ERR(nxpdev->crypto.kpp)) {
+		ret = PTR_ERR(nxpdev->crypto.kpp);
+		goto free_desc;
+	}
+
+	nxpdev->crypto.tls_handshake_hash_desc->tfm = nxpdev->crypto.tls_handshake_hash_tfm;
+	crypto_shash_init(nxpdev->crypto.tls_handshake_hash_desc);
+
 	/* TODO: Implement actual TLS handshake protocol
 	 * This will include:
-	 * 1. Crypto allocation (SHA256, ECDH-P256)
-	 * 2. Host/Device hello message exchange
-	 * 3. Master secret and traffic key derivation
-	 * 4. Proper error handling and cleanup
+	 * 1. Host/Device hello message exchange
+	 * 2. Master secret and traffic key derivation
 	 */
 
+free_kpp:
+	crypto_free_kpp(nxpdev->crypto.kpp);
+	nxpdev->crypto.kpp = NULL;
+free_desc:
+	kfree(nxpdev->crypto.tls_handshake_hash_desc);
+	nxpdev->crypto.tls_handshake_hash_desc = NULL;
+free_tfm:
+	crypto_free_shash(nxpdev->crypto.tls_handshake_hash_tfm);
+	nxpdev->crypto.tls_handshake_hash_tfm = NULL;
+	if (ret)
+		bt_dev_err(hdev, "Device Authentication failed: %d", ret);
+
 	return ret;
 }
 
-- 
2.43.0

