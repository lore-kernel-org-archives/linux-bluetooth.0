Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3202305962;
	Fri, 28 Nov 2025 09:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764321356; cv=fail; b=nFNGWp9twhdwbKMaDfs4QinBVFlOoezOuC2MW5HdL8Q/90Bvarjk576Bs2VYRI5nNZ1bfjx4WLssZ24E2gvI0OcybFtPGnYoWcsksZSWEp2rw2zATjS2IEvjnvlPB6PCJYDGcwfEfNLZp9wVoZ84XMgNNO55All7QeUEkLDSm+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764321356; c=relaxed/simple;
	bh=CmaiCwS45Me+s454rXQi2XdQHRTBGAPTV4b19nqDUGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YcWQElti1c8+OKH1pbUqr4BWfhapk8ulrMaGnXKtj1omqBbo7g1R2bQmxLQhlwLSNJV+eYLDeYSzJhA5yCyfvLhOS//aEI6pvxOCmdF/nxJm2YaQwnRh6gke2Uk8wjpXUFQefQGvCsT/ANNWLQ7YzX8SNFu82WdHPgedqlB2eHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yj6aoWU/; arc=fail smtp.client-ip=40.107.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yj6aoWU/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvhT8lyD8fn52D+arrThUbDvjOO/kQrEtX79dWbYTsPhKsXfpiwEwUkHg7Ys9QLCYDgrtqOTvhmWem8jiXN7+RusbHwd05nn8N1lcAzEKfN+/LiNiS57E/MYqvK3jcN30fSfdJIzPPkfgCGQKDKqxPqbE4t+DpZc15gH+AP6K2jplpeXI8aYDuJeinAPks/neiOrmMOhHc8d36czKdxLtd5hN1PVrLSIGWTVpw0/sS+6aKZYhwF19oEOVUpdROMP8Q5/f7sV3lnhIDD80tzVU39w5ZKoXYPRBs4EXIv+AuUeDAO1hAlnRmEN7uO4F7ZhDcXdZheQYMcuAs5fYNCnJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvyUPpjImRls9SVxtFgJP0Ji0abVMi7jLMTMOCKM3I8=;
 b=lewnfZG5J8c4NaLwSKz4ukjPLK3OXrEoypYN7JgVw7fLsXfD84zN0P0lmgj8t828I4qIRG80Wt5BYDdwIJ3YOXyZTwFgKhr4npkIKnd55HVrhKQda8L1tEW2M7ttUuuv7wVuioOuA/kBvRo7HadWcigUU/McWhhyK0yHOUOTDhFkAihAe+QvPUrlEJYkx0ku9eU/Se1t46ULD8RRg4JEsnSuPI73aSMY76x8KUp5C3kYheusaPrv2jqdZh0J5olzw1O37KCYMJMNnCxMszLuhY5QZ4uJuBgO0MJJFNFQZvA+QsPi6ygq1NckM+e4EpgnSkB20TlweKJRHDkDeg5dqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvyUPpjImRls9SVxtFgJP0Ji0abVMi7jLMTMOCKM3I8=;
 b=Yj6aoWU/Fw+SPL+tKcrR06aGRNUomV+gMYJp1m9pDPCEO3zOjd8ObeFtjD0TiIDOdsaP+cbT1ZuRgmU7psit89c25zXl3+1YdSlMM6Q4wc+MCk9yKj9Vu1ZAKmCXt/7FlR5yjhMISsY+7D/AbGvWm5ttVdAAkuMJuMq2i0G/f74l48vmhFkn/kBlR9tgKpiIhfcUsiMkqmllH0uMujR20GZ1G0MDckIYRV+ZBfiYlGjRLIjhRgDww63W674WXB2OQxmc0rer4+hogMWh77SHmFn/lWzykUnz7e2II6tgnILCTLXIrIg2VQpcDXaRJOPrECnK86x0N4lsioT1lOL1qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com (2603:10a6:10:308::13)
 by DB9PR04MB8252.eurprd04.prod.outlook.com (2603:10a6:10:24d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 09:15:51 +0000
Received: from DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d]) by DB9PR04MB9676.eurprd04.prod.outlook.com
 ([fe80::97c:438a:2968:465d%4]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 09:15:51 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v2 08/11] Bluetooth: btnxpuart: Derive traffic keys from TLS 1.3 handshake
Date: Fri, 28 Nov 2025 14:44:40 +0530
Message-ID: <20251128091443.2797316-9-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f8ead2e8-148b-42c9-f3f5-08de2e5eb99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y4Fn2SVtQud/Aoly8v4zRTTRSUP8zcJCXd6xjXpsYf9+FrLVzA8foiv4kS0l?=
 =?us-ascii?Q?BT4ZAn+i3N5YKbCQAD6VAyz+oH9Vc14A0VcrHJznnEQvaYFTz4LWV4cfk+Bp?=
 =?us-ascii?Q?uS5kscv7AP2QToUGWzmH8uG4SwKFLz9SRKUzhqONEvSXk0wTupKlXMUXa2Sg?=
 =?us-ascii?Q?kc8G/d2K1SQk2bPi4d/5o/XNleR/LjN9sRotBlKJ1ms/aOt8XdU+C3/21uwE?=
 =?us-ascii?Q?Y9Q0ZlaYrPFK8ZqdkKqRgkLRKLW1nPVwMF/9yDZUxuO/duLYKDsOrfBlpmBs?=
 =?us-ascii?Q?yCql6m0+xqJwe12MvSUyVosqFo7sLzdy+9Eo/qvoJSbgdV4MEH0FqtlrFqcr?=
 =?us-ascii?Q?7J0OwgdmerLDGGSqrs4nCDbRJALEQLrZaRcP2DOd9c4Lh0eAOsCp16Uf68Uy?=
 =?us-ascii?Q?k4f39mcXjeLEelPaRSpKMNvT7WejLsiwSr/WzOUMV6bK28m1aKK+4dbLVi7G?=
 =?us-ascii?Q?RCLgO0JsHfQkMThL4XsFFG4hfU16nxqXsElE3anWyb2Paf238gUqWW1gkJij?=
 =?us-ascii?Q?dqcBwA8aE+ntKDy7EHXs+ztbkkr7Oj/thhjLR7aNUMWg+036w6u2We5vuUag?=
 =?us-ascii?Q?XO4ekCjJmZg1G2CqKeoq3o1bgjKfLkHmA/jJmabPtlcplIP9fpz5QOh3R7pP?=
 =?us-ascii?Q?ywkbgsURYLqOiqYbBxVuhRRfmW1hQxuq9HwvOQFXljjTNQ5LqONCJhfZ7gOa?=
 =?us-ascii?Q?wuNoWbB7oyGPU0PATpLMUeAJ2KS5Jco8orruwqBS/VKChQ8YiRGcp/9YwZkl?=
 =?us-ascii?Q?LUAu5F4nOR9YPSQ2kGre9EGHYAjyGJG5M27GFg+ewCzJ62hmgvK4NTRFjXkj?=
 =?us-ascii?Q?T7y782hViKXSnoJOnBQ4fxTmDphVphorF4AhZ5XtEQ/mpqciAcF/7jvKGssv?=
 =?us-ascii?Q?vl2/RFphZszHkxQ48fKCKl4mTOvy0Q6j3KJdkCpAmmxtluX8BlOAyjVEW9UM?=
 =?us-ascii?Q?6IfmdIGMhKTUn9u9wMunzgocWGb8t3cbbEba8kzBv6romKzM18EDCQjO/Q1S?=
 =?us-ascii?Q?BylYGY70Z3Jv/kfly2yXz4QPhD8HSP38oQs+DXDhgRytb0+WiBc9+IGrU14z?=
 =?us-ascii?Q?Bd5kYnlSJZyLjXs4DczllJMotz0JPgUgTcc0qqSiGV35THeMktSkKKtCvTGI?=
 =?us-ascii?Q?XAVzUE7YZd2yTlodDtoKwjhfY6dexJfWoDyX0tlv05vkIs+RK9FTEKc+rChO?=
 =?us-ascii?Q?18ImQfSVe/CTGu62lqYaC3b1O+B5hRD5LTXIUvwbhzfApSDIWZ++wA+Ccrky?=
 =?us-ascii?Q?6Jz4BdV/8WN91ocpWI8IqN5nn0ezTIZYTdH6Fuke8T45JFafJK4IZarsGm3z?=
 =?us-ascii?Q?SLUt+b1isJclLeWM/Bd3fK9uBXaItv9mhkOmwgoSqxAcuW9l2Y0LwC6B+iES?=
 =?us-ascii?Q?x6Yl+UiYi5Cima1dqmCIgNSxZ2a/O6Odv0v5DuIaW9kEwWV2M7wdyIdWBF3b?=
 =?us-ascii?Q?aL0VTZtP3so3qJQBcfl9xcuExrJ77EtDyBO8tF0dEQqaIRNcZaxOE6HlOFyQ?=
 =?us-ascii?Q?p6y2BOrASPRy5L8M5kXmNpHIisBn3ldu9P9c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P2B5irTPp8Hs5iVQ3bqHwKMkNQZA5FzM2/Vp4NQaAM0EqBJaHZuOBxjDjuEc?=
 =?us-ascii?Q?jDMtYqiEqdx6uZxypI8tOgtUPfSur+2LMoMQ6wqTaZIwz0/GYGJ3ebwxmc6R?=
 =?us-ascii?Q?Ai6W4YqcJHCtItaZawOb1djF1nrbN88qk9GPy2QZPZWWxx3jY3QPDckVh3xF?=
 =?us-ascii?Q?99IliAhdvGm0VBl76j1+NGaJXl8U/XKLhleqkQwI+/NCh0zaQz5q/j9qO5t3?=
 =?us-ascii?Q?iFoK9YJDMQH4av917DlyEzDbavCd3lRdJeFM8pDtzoIB2WqJMP48p4/smSSm?=
 =?us-ascii?Q?tSkRhujtLWGftGjy31EdNrengNJ0DuTT4YGMneFhQTxpkQKJ54tMHmLD4jsk?=
 =?us-ascii?Q?5PQKzDwHsiAg6pliXZQtUxriTR2gsjfKINbzNLxrdK+7PrXoUaIeG7mpJEU1?=
 =?us-ascii?Q?Hh+H0IZ0tabI+BFDnFIKTy2wojnKXGpLGxlgiNShpDis0WljSCkwXuYfI0YW?=
 =?us-ascii?Q?4ZacTMeZW/79jrgoaD8tgERcKgcg68Bv+z9z2P5DsYiUGhNCl7Xn8FjCdfFJ?=
 =?us-ascii?Q?k7PH7havNbzSguuUiDyOWxYV1R7+due6pKoQzDMXo8vl4g1ghdJnJ/SH7DA7?=
 =?us-ascii?Q?fB4d5JOovrr7si9G7D5HziM9k8dgYcdBjgiH3T38Odn83tNBRc+o6z20egdt?=
 =?us-ascii?Q?murJNn7sLw8emDsCeMLjMWdkv/mKm/IzI+jD/q6kkKoA88/A1bfPaWBHsj/3?=
 =?us-ascii?Q?vrYG8QxkzODaZYYH74+kHMFcQPTn2ps56xw3ZEdNG3hmTove+j8A0dbOMWZ2?=
 =?us-ascii?Q?o/nn+IaVe68vdtXXRKZEmMkb8xvZHpry5+LUEOKUYQmb11wkxk1ByIsuwHPu?=
 =?us-ascii?Q?KRxW1ax0Z8ugOuLo26fSqmKPRh6rY576mZfDuoc3S3AZChYhdLS+YvYacBYc?=
 =?us-ascii?Q?sNkegL6FgoRMKuzkSu7Eqt6k/nNqL5aSvDaAyF3Lh1EJGvvHTI328JB34UQR?=
 =?us-ascii?Q?gLnbJd3vFNwor+g46vh1gXRil7YG1xMe5Q3R+Xl1o14PY25jrLUjXwx7aqPH?=
 =?us-ascii?Q?btKUvqHkEkalo7yGVWQe+0PTjxqcCjKS9yE4reagg7jzmT/CCr6MMtQzZxvN?=
 =?us-ascii?Q?Wu/jfcQijbA/SY9ndWKkl9l53Ff7ARYSN74o5VQ040Tf54xoNsVa16xh2X2w?=
 =?us-ascii?Q?xR6DyVOAlHmtD2Vv3qLaWRb/9ICTv+1GmchNSJvNWRBemWLPypoaqsdxCQTo?=
 =?us-ascii?Q?HurjG4V2vTyGMyzjw9NzArlg5mYutyL3Oo/FuAo8XZX5daBmW9XsLgOAOqHD?=
 =?us-ascii?Q?nE6kf+AeuUddnXjDoXTy/f8ioZMY0EQxuW6KezFe0mzcY85Nlc3LE8c3GGsT?=
 =?us-ascii?Q?x0Wh/S+tI5D9HATUWzCEckzLcVUiluG8uEwnbR0Qnd7DINQ+csXU46CdqrKj?=
 =?us-ascii?Q?4WiXJ9+KOtzHNC50N6PeK/YAXbC+MUkchqmVDNiWF0KT+G1AUSjpdGz700wy?=
 =?us-ascii?Q?2DdXsx7bJp4EZwd898HlmSr7tNzqe0alCd4Lv8fEV3y9ga2sr+SM7uSEPH/G?=
 =?us-ascii?Q?encRj0SPIxlrZCY4krn3s9RfggwIv14zh2tP51Ub8zGlGRHeD2nDrJtnjLlE?=
 =?us-ascii?Q?tlLxqjYaCN3e9gXb3q6FXKf2XIssjoCXjInKX1weOjaABf9cfeeJsF9HWV2q?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ead2e8-148b-42c9-f3f5-08de2e5eb99f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 09:15:51.1072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETRgU05dp/4YtVbJMEcGHogjgMM07P8HSg/AcRfKXqOV83tnSQ6XKDD60wtgsjzwAowZL0vaCeOlLrI4dJIprKOfdxBfpGXPvSWoyPoWx18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8252

This completes the TLS handshake implementation by adding master secret
derivation and traffic key generation. These traffic keys will be used
to encrypt/decrypt sensitive HCI commands, response and events.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 88 +++++++++++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 9ed4cece7e42..cabed02e0964 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -206,6 +206,16 @@ enum bootloader_param_change {
 	changed
 };
 
+struct nxp_tls_traffic_keys {
+	u8 h2d_secret[SHA256_DIGEST_SIZE];
+	u8 d2h_secret[SHA256_DIGEST_SIZE];
+	/* These keys below should be used for message encryption/decryption */
+	u8 h2d_iv[GCM_AES_IV_SIZE];
+	u8 h2d_key[AES_KEYSIZE_128];
+	u8 d2h_iv[GCM_AES_IV_SIZE];
+	u8 d2h_key[AES_KEYSIZE_128];
+};
+
 struct btnxpuart_crypto {
 	struct crypto_shash *tls_handshake_hash_tfm;
 	struct shash_desc *tls_handshake_hash_desc;
@@ -215,8 +225,10 @@ struct btnxpuart_crypto {
 	u8 fw_uuid[NXP_FW_UUID_SIZE];
 	u8 handshake_h2_hash[SHA256_DIGEST_SIZE];
 	u8 handshake_secret[SHA256_DIGEST_SIZE];
+	u8 master_secret[SHA256_DIGEST_SIZE];
 	struct completion completion;
 	int decrypt_result;
+	struct nxp_tls_traffic_keys keys;
 };
 
 struct btnxpuart_dev {
@@ -416,7 +428,10 @@ union nxp_set_bd_addr_payload {
 #define NXP_TLS_KEYING_IV_LABEL		NXP_TLS_LABEL("iv")
 #define NXP_TLS_KEYING_KEY_LABEL	NXP_TLS_LABEL("key")
 #define NXP_TLS_FINISHED_LABEL		NXP_TLS_LABEL("finished")
+#define NXP_TLS_DERIVED_LABEL		NXP_TLS_LABEL("derived")
 #define NXP_TLS_HOST_HS_TS_LABEL	NXP_TLS_LABEL("H HS TS")
+#define NXP_TLS_D_AP_TS_LABEL		NXP_TLS_LABEL("D AP TS")
+#define NXP_TLS_H_AP_TS_LABEL		NXP_TLS_LABEL("H AP TS")
 
 enum nxp_tls_signature_algorithm {
 	NXP_TLS_ECDSA_SECP256R1_SHA256 = 0x0403,
@@ -2526,6 +2541,71 @@ static int nxp_host_do_finished(struct hci_dev *hdev)
 	return ret;
 }
 
+static void nxp_handshake_derive_master_secret(u8 master_secret[SHA256_DIGEST_SIZE],
+					       u8 handshake_secret[SHA256_DIGEST_SIZE])
+{
+	u8 zeros[SHA256_DIGEST_SIZE] = {0};
+	u8 dhs[SHA256_DIGEST_SIZE];
+
+	/* Derive intermediate secret */
+	nxp_hkdf_expand_label(handshake_secret, NXP_TLS_DERIVED_LABEL,
+			      NULL, 0, dhs, sizeof(dhs));
+	/* Extract master secret from derived handshake secret */
+	nxp_hkdf_sha256_extract(dhs, SHA256_DIGEST_SIZE, zeros,
+				sizeof(zeros), master_secret);
+
+	memset(dhs, 0, sizeof(dhs));
+}
+
+static int nxp_handshake_derive_traffic_keys(struct hci_dev *hdev)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	struct nxp_tls_traffic_keys *keys = &nxpdev->crypto.keys;
+	u8 hash[SHA256_DIGEST_SIZE];
+	int ret = 0;
+
+	ret = crypto_shash_final(nxpdev->crypto.tls_handshake_hash_desc, hash);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_derive_secret(nxpdev->crypto.master_secret,
+				     NXP_TLS_D_AP_TS_LABEL, hash, keys->d2h_secret);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_expand_label(keys->d2h_secret,
+				    NXP_TLS_KEYING_KEY_LABEL, NULL, 0,
+				    keys->d2h_key, AES_KEYSIZE_128);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_expand_label(keys->d2h_secret,
+				    NXP_TLS_KEYING_IV_LABEL, NULL, 0,
+				    keys->d2h_iv, GCM_AES_IV_SIZE);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_derive_secret(nxpdev->crypto.master_secret,
+				     NXP_TLS_H_AP_TS_LABEL, hash, keys->h2d_secret);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_expand_label(keys->h2d_secret,
+				    NXP_TLS_KEYING_KEY_LABEL, NULL, 0,
+				    keys->h2d_key, AES_KEYSIZE_128);
+	if (ret)
+		return ret;
+
+	ret = nxp_hkdf_expand_label(keys->h2d_secret,
+				    NXP_TLS_KEYING_IV_LABEL, NULL, 0,
+				    keys->h2d_iv, GCM_AES_IV_SIZE);
+	if (ret)
+		return ret;
+
+	memset(hash, 0, sizeof(hash));
+	return ret;
+}
+
 static int nxp_authenticate_device(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
@@ -2580,10 +2660,10 @@ static int nxp_authenticate_device(struct hci_dev *hdev)
 	if (ret)
 		goto free_skb;
 
-	/* TODO: Implement actual TLS handshake protocol
-	 * This will include:
-	 * 1. Master secret and traffic key derivation
-	 */
+	nxp_handshake_derive_master_secret(nxpdev->crypto.master_secret,
+					   nxpdev->crypto.handshake_secret);
+
+	nxp_handshake_derive_traffic_keys(hdev);
 
 free_skb:
 	kfree_skb(skb);
-- 
2.43.0

