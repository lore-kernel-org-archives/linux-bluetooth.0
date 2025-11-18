Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011034.outbound.protection.outlook.com [40.107.130.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C535CB9B;
	Tue, 18 Nov 2025 14:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475661; cv=fail; b=Nq+x/LhBr67ZUtgm0+AkmmG0H277UCjdr01pCM3nJQ8MjhwB7B5O0PJm16+1fGJuw4zzVcCk61+gBE5hj7+uPIU/Hc08MKA2xR0GD1KY1iXRikvPV2Z/TPfhbQAFDyV3Krhn/US+j7IyeWk7WsvTZhS1Xi4iLLMJrntFYRWEKIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475661; c=relaxed/simple;
	bh=5C45XuMZheNZOmn8rt7gS9rOTQpVgNcMUnyiCQ8/RVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X2aRCgMKDgGW4cbgGtuSuAOK8NoNqFAKLZpXeV2dvtbRRo/DwdlFFc2bc2lquYfM0eKyE5+YkW6vI22cdR3KghpdVuOEW6GHA3L638PGDg2kKRwccaPIIOoRSK1CNsnB/NhVawjAHbmLNEUvkToZtCOd3SZWzbnCwdzPWrdSy4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ld5Kf+D7; arc=fail smtp.client-ip=40.107.130.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ld5Kf+D7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+Nh4Or9ostJtK0lc5YgGq+uVTFXNyI4bRHR/trxP8aOejJgxcvMHuKXKIbe+nlr6t2GJnFWVchJXWFgwQwDjAHkIqMafA+vvn/kekgyvdmMd30JFtWq1M8wMGyn3BS5ctlGDd9LcKre4DIF0zRK8DCKhG5MsnfNxTk8WZ2FFePlzfhBFvIn08tNWEMND1wu9hiKZANcAk07vgavl2Nt/Jd/OItQOwnJ8tHRbHSsU3LGWyNh86hg47Yj0UPp/ZPSXnhre2YU8GDjxI4RICYBgR0jjSTLpUqsZLlvZi5v6AADDavbd45z6a0YNN9vv9o9259opaim75MiY91DPEzevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5BJqMOKvax378kb/2opw+t4RyLJxUn4hge6a5lPjOE=;
 b=UzXpoK1PoKbt/GSqh0L4fCZLBCGUGoHj2W/Rw1AdkkTeENnv7yxxKZbskN+9h4OzIeKLAuMhLv5ptAMOMkkV2mIeyLNd+PR0Ss3dyGZJOaelQ53YK7Dzg1iStldJ0fX7/TEuEF8sXq3fhG10MTQZHBSDZgPnT4JNGpBZcAS0tX0KjnyuLEfEH7XOKh+vDlXa6K4t/3Z1zRzWo1296LBZ1f4/RGMgXJ2zwbYNg+ewll+jN4JYNT7agNoZlH64ddhD3mtMS1B07+sJ+s/xli2taq+bzeLO4cZkJAHDbevQgynd3rpRxe/0ka++3WDErrHa6iZYEsZXgbgxH2AHpibkKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5BJqMOKvax378kb/2opw+t4RyLJxUn4hge6a5lPjOE=;
 b=Ld5Kf+D7L+XW3gGVgukDjxHSBeB0yDIuwG/UvDu4A0c0Nwil0KkoieGKja9ER6IOidAv+8vm+Jffz0dgZSbn29vi3EWt1G4S3+KJN1jsA2KMOIF1rb3Io+eIX4DC+cbkMFX1jbTJdZT8sm6PQu819fROeKR4HTkpEwOlXAMzXPGI8hyQ9I720EU3eLI+rqraGk7zwJ863Esw7ztxq9Z8NnylQhdZ056dSaWKU0xt9ozPrGLhJ5SEiVm1U3MH67fzf+WQNZGqo10EoEXm4uZZfgOOyGG0BmNn8g3AdyYvpTsFf20HxwmuhIoiuDehk/dFi8jFqPVNweSnKlQ6YGNKDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA1PR04MB10179.eurprd04.prod.outlook.com (2603:10a6:102:460::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:20:55 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 14:20:55 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	sherry.sun@nxp.com,
	dmitrii.lebed@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1 03/11] Bluetooth: btnxpuart: Add secure interface TLS authentication support
Date: Tue, 18 Nov 2025 19:50:16 +0530
Message-ID: <20251118142025.1982263-4-neeraj.sanjaykale@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 20066121-e58b-4c84-6d7f-08de26adafa4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e3nHJYOIoVJ9a3ABNgtF0Lc2/f3cJFOLnytAJ5Pnn+mtWuOwpSRSWeOG7mD0?=
 =?us-ascii?Q?fWepjqwPRoEpHJvxIkvETJZK/9js6ZRBx3Oyz/ErMVMTJRDlv5MaoytwSPuN?=
 =?us-ascii?Q?XtGtma9/7/J7a8wp71Yffy0rbexFQIGBt/2HZXiWdD6Ggx9Hkc9Tcme0dIDC?=
 =?us-ascii?Q?K2OjrbEbxcLYdNjjMgB4X/BTEaBn24wCs+3/Hp0iK1aYa2dOvnw2JOnk7/3H?=
 =?us-ascii?Q?9DLMIwfJYQgr7U8y27P3izCMimnuwABBZ4Fbzj9jpu0WieDLR2kXgV9p1yzw?=
 =?us-ascii?Q?IUcdTWLWE720085gnVUTpXLuyEwHHsXt3CzIxm+4S9pTtdFVCZvWq4SflVEN?=
 =?us-ascii?Q?J1XHe7Gbi1scnHqvrxgPrJwQO+Qg7veZmsyxFbzRTNpPQMWoC/3aPSArSsWa?=
 =?us-ascii?Q?mgiGNhaRkZ1pQUmnMS5VYZA3+j0I5VXiL0FxC23o6ngdhzcq1b4qcpgOPSxk?=
 =?us-ascii?Q?wYxpl4oSpW/h7zfdaLTDeifOeeOgV+H/SPOSM03yL+cZUsYqfLkhTeWZ8D3V?=
 =?us-ascii?Q?VPld1HQFfPlTopmx9ZR2CBKEl7APX92mKmgbqkefyUCXLkwwvF8IyYylpkyn?=
 =?us-ascii?Q?HJ0U1wLh9mi5spkL3xCMjtiQhDJz+tmPJRHKBKFrhgiN6e+JBVd2Wk7Ok2TT?=
 =?us-ascii?Q?iYX3d9RnHCznmnomF67HoOgPSt+HhFgCau/NI1BiCK7AeOmmmCXvPsuPkQmt?=
 =?us-ascii?Q?eek3xj1ecRF49i3cT7Jj17i9RXglCMUaptCO5pkh6T63nhrodztgTUdEwehy?=
 =?us-ascii?Q?nxPmT+TkLqCNj5Z6NUvRGC0jQG0ZsUI7Fwn+yUN/+YCtmNhoACTFOiI58ACO?=
 =?us-ascii?Q?HtVpAfgRDPLWmYBwf9Yw0UynD10dRgY+FpM3CQA4XkiKSFLIdWieEkyc4I7Q?=
 =?us-ascii?Q?Ob/+nC2DeIbh/FNuJQutZ+c7zF6Etix2ZQYlHiQnMW30GM7JvxU96QDAEHNN?=
 =?us-ascii?Q?I2hCcN3n9gBR8Q8FljXZFK8FQArdNS9w8GKH1RaEF84kZwyCmrisSLYWFOMU?=
 =?us-ascii?Q?0k8HCS+I5PdAMXpFQiIE2F6io91ZdMv43XWQ+etuZa0c1q8QOIPW0LvQmxUT?=
 =?us-ascii?Q?bWITrNkp4QU2UgAFv7VjeRBEIbU4qCvF+SUzGR6iSWFzlF3y9fopFFETznCc?=
 =?us-ascii?Q?gkHEzES5nCEqEzw4DGez+6MXy8szmbAIDqP3hM+ywGJC1uc8eHM8s86ib1SL?=
 =?us-ascii?Q?fV5taKq1JaTmL2BUx5j1HFvWGTqyTk8ti18XCfqHRbBdTjXxKV3aaNSEcPn6?=
 =?us-ascii?Q?+OnDh9Uhfdo4CxzNvYL24z68WxB39FvPbblAdHbJwDOIgj97maTGra5EbPAO?=
 =?us-ascii?Q?YslufDV1vHQycQWl+OtNsffDRhcPtcufxr2sq87lrZMfGj8NdJjsy1E/2oo0?=
 =?us-ascii?Q?9pVSMaSb00cL+wP+d15ufdSdDE9uAPEgxkN8S3xgogivMuo6pjpg/I5BurHT?=
 =?us-ascii?Q?IA9kPy9bRA9CY3fJEtWUOjjUrx0SCDHt32CvBDDOQUlA+IzR19fswx7Zqgxr?=
 =?us-ascii?Q?NL71sxUtp6sOZmAylso0nRzS0rI4h0fk8xgB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?34vdhCFF+bWxQJwRMh77KonSMotmM4RmW6onyiD2Pp+Zhc84y2d+FQC4Roy4?=
 =?us-ascii?Q?J5k3up7ilbsaJikPI5LhsZgny6+SBEXG5eq19HL0UaLr9SPfp0EjyePkIg4w?=
 =?us-ascii?Q?FMUwiJSfPNhsgmo+RE8oi9PG9BOj6uwparsyi/sE3InG/q1NKRM8Ok92N4z0?=
 =?us-ascii?Q?rCvljUu+PHXOwmK03f4ZzH2YbklvGoBI021KRoECVX9tQAMuNtrCrT/ZwfaR?=
 =?us-ascii?Q?6XcNJkAUBd5USkW+xPaPLOrmqTqG0PSRfnjhG5EbgpTegGjoHnfWsXr4ahFC?=
 =?us-ascii?Q?wP6cetxHCcvLtSOdVLb5xOfLHqkP5gPSj1ERf7odvtnn5acyW4Z7hM3+wZ7i?=
 =?us-ascii?Q?YcybcNU+PNdb6BrCJajujgd6PfJGkqPzLeJ4jTAQLP95On9RZE6w5BQFqBqy?=
 =?us-ascii?Q?u1cUMupI0vjyONylY1iPrYeSIsMEX3iZAV8ey0vCKxdO91ggssupjH1XxgnF?=
 =?us-ascii?Q?WWWfdzILj4EX5tFs41p71WTvrHPGNkZeQfGTP5pS61Tf0RkYAfFOFEsPt8oA?=
 =?us-ascii?Q?QUJ9C/gkIg4LWP0DDu2O9JmhaJsHsMl/2BIqmbmlZSfYNnmWKHrcPFJXRjPo?=
 =?us-ascii?Q?ejKbnpHcYTg80k222IgNd9ToZ5vPl25kgvngtAdJv0uHh506KdbA7w7CI0wA?=
 =?us-ascii?Q?3aVTDJtao3Hh+O5UurtUodtXWCCYlCv9Aa4QHAjbUPIEqWqaR7A/LHVzaYTP?=
 =?us-ascii?Q?YGJf6xdq0B4OvuVMcIHPw/tN68WtZ+mIp0IDuU67NXO8m+m8ubeAFtZpn7l6?=
 =?us-ascii?Q?Z2j5Om7VgnWSJ3K/z7H0hMpibJGX38eAR4zhgjir16M97hXzts9Ypm+t+Pl+?=
 =?us-ascii?Q?kgmvrb/d6nA0u4+/+Tf6YlU91F7kBBImtDjlPWebSy9H51xo9gVgd+HwIPpT?=
 =?us-ascii?Q?0HMCzumbgTPjG6so2D4ZRollV9AOqBgXXa3KM1MiAykoj2Qg1e6YiLV0UMSO?=
 =?us-ascii?Q?Ee8GWnByfV1bMU1EzphmDPS/zWaFVcLgVogcKyH00fXPj+iYfiB1EGOE0h8w?=
 =?us-ascii?Q?iWUvnmuJ3eqoA3kS/v+QjHlASJvu09OunJ4pcb8YPhpohnU0psewTWH16Fsh?=
 =?us-ascii?Q?WLc19D4JD3hRNWaiNdy6221CoZ+IiqY5L2Ml9t1gUq+zIMxHNZ1hNRsVcS2c?=
 =?us-ascii?Q?eqrx7vus/05G/dUirU5aNJK4aFSFdUMCoOjGVyFAlk5X4CKqqffwOsRWSXO5?=
 =?us-ascii?Q?2gY4PBS0KYAPcvQdwg3zOk+sGnFRI65K/i/OIUkh1/U5r7UUiKfZ56exRxFf?=
 =?us-ascii?Q?yvW7vp46debzjrBnvP+/wAIIPbRfE84pRYXqfbmsIdHM0xJaN7cI87QVMexT?=
 =?us-ascii?Q?ykfJQXWA28tQIUaWhMa2c5R1vh/MzAr0+iIdy6Kt1XOCDtSU3WryJrEBSNfZ?=
 =?us-ascii?Q?znbjKPlx1An83znID9EqqGp8ZpXA7YDpSOuT4DvUh/ncvS5GJNkb601hJDfI?=
 =?us-ascii?Q?zKtKUq8rZ4mIYn9lmlykc5gLCEt1/fy380TDtqVsGHugaGZTGJGhAYl5D8ts?=
 =?us-ascii?Q?ELVqDqLZiLfr5d9kDiv7hehzbir0mHE8mY9jjcpdf5lf/3ISOG0mPjmir0Nt?=
 =?us-ascii?Q?pGHVSZnvmcy2UP3/9Yb3wrLQNFymQZDKux0exjJQYA8BQrVc7gPUKubSnHmU?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20066121-e58b-4c84-6d7f-08de26adafa4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:20:55.3960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0EzzMqZdTdP6YS+AMB3JXHipZzOqL4iQvSedpI+tY4xht1yJbiUSvsJPk///AtJik6J1LXm2BuywKpnV/w2y7e7lAHMwiXWk5yh79zbyrtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10179

This includes a placeholder nxp_authenticate_device() function if the
chip supports secure interface feature.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 483d812042df..084914e72c44 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1598,6 +1598,23 @@ static void nxp_get_fw_version(struct hci_dev *hdev)
 	kfree_skb(skb);
 }
 
+/* Secure Interface */
+static int nxp_authenticate_device(struct hci_dev *hdev)
+{
+	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
+	int ret = 0;
+
+	/* TODO: Implement actual TLS handshake protocol
+	 * This will include:
+	 * 1. Crypto allocation (SHA256, ECDH-P256)
+	 * 2. Host/Device hello message exchange
+	 * 3. Master secret and traffic key derivation
+	 * 4. Proper error handling and cleanup
+	 */
+
+	return ret;
+}
+
 /* NXP protocol */
 static int nxp_setup(struct hci_dev *hdev)
 {
@@ -1629,6 +1646,12 @@ static int nxp_setup(struct hci_dev *hdev)
 
 	nxp_get_fw_version(hdev);
 
+	if (nxpdev->secure_interface) {
+		err = nxp_authenticate_device(hdev);
+		if (err)
+			return -EACCES;
+	}
+
 	ps_init(hdev);
 
 	if (test_and_clear_bit(BTNXPUART_IR_IN_PROGRESS, &nxpdev->tx_state))
-- 
2.43.0

