Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42ACF30FC39;
	Tue, 13 Jan 2026 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768290427; cv=fail; b=JnZfxiX7n5Trxf91Z6hD7ZbRfvoXSav1oq9vuJyegRynFZVx79iinMs6O+fRO/rH2IW/nyWXBHLBPzdsU3xl7hEXrkLQkBQCkR9npS1wntSo3C4URDJolEustpEEJVMBRI7PsMOm6/uK7hsixbuC6cw4yUwerMNenykukTyntRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768290427; c=relaxed/simple;
	bh=kuW6D77+qQAlG7p9fmOjlK5DM8ij1Ty2Fgov5zgcUs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n21BE1yhkL0PxANb9w2yVNcKLU7/E4HIRWvr3j3RNNra8eN32WiL35ChJv5TwHCPdKtxox93J9V33VvogTcaLnsoaFGdak+9mguEYvJSyf1XcVuIgWN4PN9JSQGGQJWgxNgVhOJ+32bcecaGxQqLNBCO0gw7nF7TwFmVKoQoTOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jGwBxAnK; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jGwBxAnK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ExSl0R12fDK7TVKpxgPzhWwcGkNJcBblS1FV7ZcNH39ZOVMGe59oXrx4W5w80/dzNQV6XblddC1DHZZvRM6DXkHwyavTlgqXBYRA7cH5+5coaY+tDrGmXXWtES1uIrR2buGkBwBOQtVLrAfAV8tkilkbe1GHowKbNO901vpW9KbDJ0o167qDfRGClnOn+XC/x5sbSfG3s0RoiwvCx9SayR1fssuDCIH7YQmExfnSQpnHlZ1jidL0U6Ahvf8WzLduW1BwFfaPZXw8GgAN/+wpYwQit2cSPhNA1Dzo0DFtHxoXxoUteKQZDYTgwQAyjD3zFYU0l9P7T3R5Ux78TV0LNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Hv+RQnhYmcKQmQwtxr1nHWT5U1rIu5dXRon8Kc573E=;
 b=llsVEDM5mCRh3rNHgcB272kpdj46K5Fr1C7r+fgiV2Wd1QXNX745Tp14wC7y9dP98Wi7sRg9HvT++RrOUI8rBOyjubBx/yYMJ8xjHupylXT3gBiRQ6LKy0RSFqujmOfQOzcgrq9BCIAmL3ZKmdFjWegEhUSDPoPBdE9xAnQcw4/WrXMgVpqIAMy4crBuwp2s1YAbmiheIUx+HbshKt8RkXW0Ee8BzW8oe0j71jrKh1HGsiLZNIF28DoMcHA/ehT2MVPcH2PcVoABS1oghn2sVmvxct+PQWtFOEjYS81CYXwqoifwHoqNnp4Chj4h08Tfusr89+29AJAxXf7vhQ0/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Hv+RQnhYmcKQmQwtxr1nHWT5U1rIu5dXRon8Kc573E=;
 b=jGwBxAnKqFip2xQKLO4//YUbyR7xaGtjAa2WUm+AYL0TaN397j0ZcPrMoFETcccCp2uTgVEDzjb9DtQx+Hd05EvN+f7Dx0VXYX9wYaAJzB7xsZgCBvre+j406miTWWcacy30NdbQxg7S63HHAF5dn7yJ8mzVtPwzMchkJ9p7Yks92az4I2fcAtvAZYY2Ts3y9HZTvaj6Pi5jwqJ2BeNLlYnTSfYdCyQFD+gLimywLi1FwRSrR9DvtMRgjZ7lh8I9/VuBztvmlNAdRfTWJPHVtTXK2IobB4oWqa3ghDcDxhhF0vuu7A1MpUBSKzQUhgI9WfVuLIKlM9cg7jHGQWG+Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PAXPR04MB8144.eurprd04.prod.outlook.com (2603:10a6:102:1cc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Tue, 13 Jan
 2026 07:46:59 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 07:46:59 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] Bluetooth: btnxpuart: Add TLS host hello handshake implementation
Date: Tue, 13 Jan 2026 13:17:12 +0530
Message-ID: <20260113074718.2384043-6-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 96198cc0-3378-48b2-c400-08de5277eeb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|19092799006|1800799024|38350700014|7142099003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W8OhTBqB3beyrOPfKxmbu+aiP81+NbNeoo2bHZLNytncdY1IcaL/o4BL2Be4?=
 =?us-ascii?Q?FHXvpjBdryTqBcRgAwx5CMTWIPfX3pCMWyjkYFHFa+EUbKyyZy3kquF+PsG4?=
 =?us-ascii?Q?KYyS3oK2Oqfw5hiczByk+CN6VYEUeCpOXWcGh+fXZZULq4YfDsYoe+FCwucn?=
 =?us-ascii?Q?7WQ3F/+tTu3U6Rce7QSthbBvohAmtw63elG4XzgUPSQPQMh39uTmV2ti+TT/?=
 =?us-ascii?Q?5pZm+HfXhSAXghKPPoi2uaIUSBEbg9ACpy0Y/8kkwd6YVbckArx/jSamLfbw?=
 =?us-ascii?Q?dDv0324ci7ljA3a4za+MShzu/3SFAwHkkBfaDWeV7mImdEDREwdJJ8YvXZR7?=
 =?us-ascii?Q?rOZmzyc3hVY5Higtlk5Xfx3Bz0dZ5uynIgQT05P9gyzYLi6M/Lozakrsb3+W?=
 =?us-ascii?Q?f8og7FAEDFWzG7hoM1ErUvzIhYtHXdOzycsqC/aZILxQ71a8CWDMvcWJF0uf?=
 =?us-ascii?Q?8JK4pvZugvxYv+A+WTidT4lrJAuatWPZRRrfj3Va/fBB7iiE7FR4ZKfhUgiZ?=
 =?us-ascii?Q?DF1pDAvKZHGfXapjz4siw1kqR8Jeko0Ei89v043lRuwNRs+fJRrFziNJhJI6?=
 =?us-ascii?Q?YBgO7X4erz5hsukGeVBPbp16HAuLDF0yMTIShcFoFnj+RU681WrlQUW2B4ty?=
 =?us-ascii?Q?Mz6DOCQ+7nOMNNSn/8zWzahgRZieCg1Kk2OP/6sqhEtXmyVeQ5EQ562jufbe?=
 =?us-ascii?Q?smXpDWLUYdVWKHW5WGjcx/VUmAzUttB3boFZoG/SFauI7HOV4mXOdal/QJyp?=
 =?us-ascii?Q?J13x5g/fTqlV0eYbJB6mTWNrIBJaw4LrLYrSZwSPlDuo/cBMkS2BeK9hDkhZ?=
 =?us-ascii?Q?d9/c6mCP/oy6Iyy2t8oLWIJ6V2C1bK08nHdu4o0RtONRxSxdikCXSrZkxFHF?=
 =?us-ascii?Q?R1Y5hixIqjncIV6Sg3LnXbeq7scz88vEtTKYESpWGsu/LcFCSHtuiZV615nT?=
 =?us-ascii?Q?2Ua68COiewxTs3KPk4soD/C8j9w+v7/xCBzUn6F2afJh7qqQHT/dt0XqU9WL?=
 =?us-ascii?Q?yrRlZWlTXLFrHap46i+V2Ltbu8u3m/XWj+4mEV6YZ4HdXjktI4L4wmG3mJ2a?=
 =?us-ascii?Q?galyT48w6o5g4gkPvwaOHsspXdEwDlg3ulTekvdZ2tWUHbUybtJevkFcMGUC?=
 =?us-ascii?Q?d6b/hwW+N9HNhorwBmOZSnn5j2uT4qwST3tL3i1hR1yA79kmM4Y4J6x5RMHf?=
 =?us-ascii?Q?RCBvs+wgBbCtC5S3oCvAJnBOttNMGewTYcBwq/CrkuopdOi94/gC3g/Cw1EM?=
 =?us-ascii?Q?t29ab76z81mEvvr34x84tDQ/O9V1O5djH+SwMb6TCjcg3d7HLGPX1poyiHHf?=
 =?us-ascii?Q?ws9pOUYk6hqsDK6dbadAp8UQda/MXT/OBc2vUi4hCJQ+1FY51jLjiCAN+SUT?=
 =?us-ascii?Q?FsuFkZRqIjAOAS50+tiw5LZRjyqoaxikdtSv0F8VX+Q7Awpp5WCtulLuerqC?=
 =?us-ascii?Q?sI3qPRM/REG8Kec51Nztf6TJPouX2HIvY0PNulL3zYoJddbO56Lg3E0S1Xmh?=
 =?us-ascii?Q?otTu5hXE4JSG9p6FzZ9NrgxqnRlCsl4Q0wvd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(19092799006)(1800799024)(38350700014)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+DxolZoZ8SoKSvC8vLzaLcy76Et7oQqdWz+tdFlAfjDaBVU3nKehJ31MZJXc?=
 =?us-ascii?Q?/jnK8mKg2/TRJ1PgHknNTtboC8NngnYs88Gw00cVtdDcMksP5Nvro17ZRTgs?=
 =?us-ascii?Q?/ZT0IMF5HVYljpsFBKhnOzSVKdRWGxTRZOUMg9OlezJEIuMF8JvgNvsL2rkw?=
 =?us-ascii?Q?Zr0JOiqzS0vCT+q1Zqt8pXyMuIC0gy2mR4NkT+0dEJAJy83KTSch3zJg1Fhu?=
 =?us-ascii?Q?jvLqo4KboOeDMYgcSZXMu12wM0Ot2N6IBtiHTjbjkCw647T4juxXoPMJqOIH?=
 =?us-ascii?Q?WIGjxzmpQdpgdJ8C6TikBs6Q4oAJ8PxSSvLugIYGEm2CZxz3NYx6DqfbQMxv?=
 =?us-ascii?Q?M+rSMTR+30jNy3dbeVspQsxN1PtV3Bhcw7Xz1Iy2wrR40z+0cyEMZYOhgad9?=
 =?us-ascii?Q?nITcANAzPATA8C1ZH2drUR/Ay7NfbpY/d2tiIofXVvVVcF5rnElMoFjIMiLd?=
 =?us-ascii?Q?2H+a8lnZBUY/4yeWLZxxK47y0HH4Oz4Ahdrgw7GSfae9A1DOFE/iC9xaSPhN?=
 =?us-ascii?Q?+oW+ntG3zYW/ahZx/sMgUYb0URjhMKcbJOLLVjgVBmbef3+ifKh4zyuEeksf?=
 =?us-ascii?Q?0vP31UmyD4nvN3QB2S+FMugp3nxKbvY9Eallu6clG9kMkv7LYgaqN9rLMskT?=
 =?us-ascii?Q?bHtjbWopA8RrkS3kXDaYDJdgNYGRZ0c+ZLtQsh1/uYiKm/ZyzOeP5YMMxWsd?=
 =?us-ascii?Q?m8oUIG+pK9Vd45am8awx2ImLzumoUwAwSx1Et4QV8cvzT6CDOqkZQlvo0quT?=
 =?us-ascii?Q?5cgoS6JIjN6SJeCXZ7Vv1NRw5+EcUM940FCv6+EYrtFXQAdIdmF8XrCcpt1o?=
 =?us-ascii?Q?kZY5MjDSaadUz4xV7MzX3FYYPtchJcCvp3e8hoxARohM/nXoncSVdiuwY3LK?=
 =?us-ascii?Q?WWMSzFZnW2GM+JAVbgKYsHA9wI373GOO3b4Fx7/lJWedt7OO4E/JLJLko/lE?=
 =?us-ascii?Q?ZKPD3DVQmp2ukhnk3CtrbP1HdQ8zUCQOmouHJw1hScKIiMNs634X1DTZ2SFN?=
 =?us-ascii?Q?CZEZTiAXtnnl7rGVTjUjr0W/PxxfIrmsm1bTFcMjVEPHV4ViL7FFM8KvML6t?=
 =?us-ascii?Q?EJ0n+baR4cf/egmuhmTSURo1gBjqeYOpWr+BOGq3Zt67MwRgzHnNm8EEyseZ?=
 =?us-ascii?Q?ZTQkgMtd6+fxcQb7Nd+xEdUn5nOEL+ih/6wTi+CsnrbYPHzox3nCKK0hw6Ol?=
 =?us-ascii?Q?G+FQGggAedN5YEvfK5Y89IuvZnowyQ5GUT/QjdyfPMw/Q8ybz7b84WklzQBW?=
 =?us-ascii?Q?AHYRWjixPyqfkFrqJBMY0RX3MGkDbE1gS4z5RU4HeUwWamv6cXiXr1vZkakn?=
 =?us-ascii?Q?GwfRphSeCuSVrWkHw6KlHnYb9hSvWrh6wEkiA9EgZbJ3oOQUvBU2OLuSMJwY?=
 =?us-ascii?Q?kJHv0SQJLRlSrhBc7gsenpBREnxFjMg3bys3xouioyp0Mh2xNmWgI3GK/Ub1?=
 =?us-ascii?Q?qEMtjBMoYuGGAJ59lgXE30duYoborNbY8T4P43/djo0auseQmC1fFuaAztKp?=
 =?us-ascii?Q?O/c1Td2BfTc7nfQCdDWfEYjUm3GiP0GVnYTDt0vCIV/YG3F1TiKS3PlXGEBD?=
 =?us-ascii?Q?taoYjP6KQ/wk4iwmkMCm1ImoZvzYCEAQ28A0yFZ9JzwAdu1ADwB+eXCjCXwe?=
 =?us-ascii?Q?G2bJL48D309yehZ85wVRtnQ8zn8ICONtnd+rp9ZRwiX/nVXMtoA1NOoKrO11?=
 =?us-ascii?Q?qLxQwxkh8YwyT0q31Q/QEbnz4DIFda7RHV7/MWTdxqDoqE2WXD25q6AXZIXw?=
 =?us-ascii?Q?LQMEUpXe/06LeI3Pl0OyMzW+4uja8Ek=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96198cc0-3378-48b2-c400-08de5277eeb1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 07:46:59.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1IHfP0k0N6HhB6Mdz2w4qc4Jx0xk9+fHSXf5xzlSLS4F8LPXaTT8LamEWGA1pJJ6bM57maeomd7AoAccjDdTX3rhLWYzQ6lgzd8MFCWLiDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8144

Implement TLS handshake initiation for secure interface authentication.
Includes ECDH public key generation, host hello message creation, and
handshake hash computation for secure chip authentication.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 189 +++++++++++++++++++++++++++++++++-
 1 file changed, 188 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 7c94d8ab94f3..8208b0748f97 100644
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

