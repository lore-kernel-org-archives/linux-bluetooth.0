Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013015.outbound.protection.outlook.com [52.101.127.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F43EFFDD;
	Fri, 10 Jul 2026 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783681628; cv=fail; b=ZNRtxUNl5XVcZi6WLyr5SwLhAH9tEzDuh+fDSauzaj3XM1/2h31vh1z4gF8M4KZT4CzQaisJ45E57knsterMnyAI8u+aroQp5apPC26Spx2VuR1wDsRaRGNAWDT2m29H1IWuPpFUtt1mQpg4oCOYKhsvhbL6hFu1MU4R1lkppTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783681628; c=relaxed/simple;
	bh=ioet4WqX0FHoCwiuSyjbWiYXwM+GofQ+8qacHjfHYbc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PakvDloW3TEqfnt71rcy6jMfSCo3BgEQ/tXZgeeqoHR82bZWZ0rcVmB5d+OKxT/KoYmVleEUEEzIAg5yH0+989NaGpm3OFHJvEajwdmeYU8ps2NApKGq4StxYY2GFbyu0XakI1FzMgjPOk7y/a8vzE3HhDURnZh+/xcssYXFmJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=OYGqas/u; arc=fail smtp.client-ip=52.101.127.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="OYGqas/u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ynby9ChPjNbcTHR8fIZg22li0JFNDChknl1ly7bTW5H2156f/FRQFFyQAJoC7STSNd0KLz8m7QUYLP0cz1bwLbUDTatlwG0iCyWNX3vUvUHMo9pgMPLdF7s4DcHDnpsEq0tqqHU1SptoOnD9mpX3l7v0e0xF8WIv0kF1G1tIjpRWo3Q8sXeQjZCCVsprHESN448VsanytGsSxDbIZYOoQoIi51eJPaSdJuOhDIgof3LyNYI59HXrcm4cHNkFmwBQDdY0XDXUmHa034lEKx8NlXh+bchWuN7NBj6BJmqMKYlZR0rY+w91QjmeHLwQZZPEZj1YjTW8nROe9isOF5uAww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XCaILtls6m83l9EE21f8rlhGosylgtfJws/YZN6GQ/o=;
 b=pJHqGNIZoJg0rxWRnC6YbmyNTlQIEP6elVyJnDnx9cOC0nuJU+7fmOP8hr9YBg8ob0uLI2uywN9hgTA68R4/EGFv1cYzCCV4+LOgjl7c47i0BmbN3LvnuOTVApn/9NnXjTqSkL3b5Cu0vDKj32T9PnpxnLMWDZxcK9sypmjN/aBvF5/oJVJL91Niz8BDXMvhNL5zK7Yq88//65eLpgwGOocNFGPAD0pli+tRQlvA5ba5qnnltefznNyDJtHEoimxBsqQ7iouG53Naq/fQTUlESnCHjWTKnvSKXg53J3ucdle4Wa1iRET32FOt3jvgsNhIY3TrL1+ZuAoTZBQ1nXN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCaILtls6m83l9EE21f8rlhGosylgtfJws/YZN6GQ/o=;
 b=OYGqas/uIIZgx7PvNDtOKVlnALS8jnS7RLCfHfkO1imV+BPdix/S0r/SHpHI+A1oq/grxg4tpbsqmF1PnN+HA+1gSv/Yz8CAScYIRe75bFJqOEm0KQP1k6blS77UcQxlukq9epTXGE9cceS9GjNuHQR7DoeUMVdvx6lgkuCdmrhAix/Rp2fd8Et1KRnsvqNDyzMFILoeFmLd+iri88dQQdAYTNMTejVT6SBJO/eCVZhlhv6R5PsBmkiD9vnL75RN/Pf0fKEXtiOHKLR0Iv99sZr+x/oz7KsQHJilL6hGW+vTr2j0Ug+23N+XZ7BYHPd3Ae+6IjqsewQnP4hSt4uPbQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SETPR06MB9021.apcprd06.prod.outlook.com (2603:1096:101:317::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 11:07:04 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.016; Fri, 10 Jul 2026
 11:07:04 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org (open list:BLUETOOTH DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH] Bluetooth: Remove redundant dev_err()
Date: Fri, 10 Jul 2026 19:06:50 +0800
Message-Id: <20260710110651.448373-1-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SETPR06MB9021:EE_
X-MS-Office365-Filtering-Correlation-Id: ae6929c4-d9e2-465d-2cde-08dede735f85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|23010399003|18002099003|11063799006|6133799003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	CJII+nqWUw8lz6WwCaUFXFZkxe5GXyAIpn6as11Y8Ua0EPDyUgzPWgeTcaYe3eUZ9nAXN3UngnsmW/ohMjJaLxyPOcoK8QhfqkxLVEJmSa7ZjExV8kX4HBMVTrIw/thq2aPS+93Y86Sy9zo8BUXPHLmREe21+bPtbWvMuOTyNMzS5sWUucxzbk9dUqZkLM061Vkuiteo3hAwZFKF3Ac/5PFKrKZhKsLnHY/ChJlCOLiFXs9cEBI4zEjs9cuTzfmvLbVMIrqvGedsOdwYJm5Zws/5jnOVbV3JtVp2rOG81xE3OpWWaTEmfDjrz1AlUrltoDyDJOlCI4j0IqF+VV8PKgYL6dB2hNDkIfJzR45UMjBul4AIaPAaE+820hHJMA2/mYUyEJzRKfhTxKcvtrSMTVdLPeti7ZAyHKtt92FxZ/Pb+tfo/NGrNL5PGaLTHzSSTGw94DfM5m6+lcuTR8e7VNVEZv4bsnpWTPkpVWAUMFu8l5D2fLZWVZtkS3DCc5YkqYalhw4cIFFOo2jICyeLc757fgaASyyhiVlNXllydDPh0j+VtqkPnEOtxRRLSUTfvvZu7Q7PkbjfpCgyFvbGugmR2NbtRczrQGfiXAIZAYrfaoBO/SnkVykVMnj11VXOJzmyRJYNpTvT9qHOiW6ZPRIBqxGsmYPes6klDKFJ9GzNx2QG4WhqV5o0cW9HKIe+wCJjjcO+YlqmY80e3apORNVC1j4Nyw45vKnJJUW50CQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(23010399003)(18002099003)(11063799006)(6133799003)(56012099006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0VPG0s7EE7UHAyUxF87kCL0YX5uyxdSKcVrYR33dJEf5ZMuMCCU4DnJ9vyAk?=
 =?us-ascii?Q?XJI+ZsXSdocsvcSocvwCu+hLBsu9g+UifTaK22aIXei6gz+GK58pHuFhxUoU?=
 =?us-ascii?Q?OaDmnCA/V+UOOpz8k9Wg0Rfjb6+AfS/JJBR2L19G/bnZKY5rLRLMBwWKD4EZ?=
 =?us-ascii?Q?2fSyEeZyplWkjq++DKTExD5ekzoUUiBKZ2Ed+2COFOhm9def26gQBqejXSro?=
 =?us-ascii?Q?sHRFMCw4HV2vxRsA6Wh2Ln0brIf+Vs8vcg48wm1iymLx0psm56cg4BK2+J9k?=
 =?us-ascii?Q?Ew+J1mUvSwDs2ajhOdj1kz1DlJBblTIuMQEHRLQlMOMnM6zlOImxwj5lI9fk?=
 =?us-ascii?Q?2U+74xpqqUwCMQC2pWN1X/yldVzeaiv243dAFmdi7RYyiZR4KrIN2kmVtO2a?=
 =?us-ascii?Q?WU7Ymn374ErUfyRHNrR/pwZOUHFarr1S+/J8tA/pckOphUcvtnE39e/K8zRC?=
 =?us-ascii?Q?uPpEZNczlregTL3iDjI2VT43QLB5VbFlnNCGwvo7S4Zw4ENa54eg0F32zHv5?=
 =?us-ascii?Q?vSqEb5EYKCqsM9RzRKnv35MTGnNY9lOry28LYjqXkMyV0/RCUnZFMTvwL/C/?=
 =?us-ascii?Q?5KfwRl0TrjKnpR6WoN2BQ3kilT3tfgIs9Q/U5RD5e+Uo65aKCwm5CsR3njCK?=
 =?us-ascii?Q?lb4nXQWBOtS3MjSbqzsK5j0d8x6o+/TnlvyTrZyAAnKtNbhrj08db6IKaTCE?=
 =?us-ascii?Q?FSB3YO48EkdGBbhEGPyNQ0Qgup6lAwWFVacoRnsjG4VuxhncDpsvdCZvU1pU?=
 =?us-ascii?Q?V39hrJ02D8hbAKxxNWDiqldKtEPOB7Agb0llC2EdD6cAQB8USPIouS0Sp/CL?=
 =?us-ascii?Q?GNLpz4FrSNuBVVbhzpsaQHf5APJcdiuFTV7ZNwGIbD49i/dyhlcc2euSLHNc?=
 =?us-ascii?Q?KYwKHI8/F2t3bRlY+NB94ep5ZphLN593DUf/ShCBRBmyDtgvdV17ZQJpHvAB?=
 =?us-ascii?Q?SUkeiJX07sdK4zczBuhqm66HNKmnTQbLjAv8irKNxOmy9AYknyl7hKOpDqU8?=
 =?us-ascii?Q?rst27tl0Nt7m4dMvIsYOQJZcmo4amn7OfAqAJYJs3sNBzNOxPE2myT47AiJT?=
 =?us-ascii?Q?WypGzT/0CFji5hEzl6a4snOQ7prrtcnA1Oeqi9+5lhJeUPJYKwRw0sotsUcG?=
 =?us-ascii?Q?I6r3pXhmZPSqGXWqpTFozgK6gRgWxL2E1myQvnaev5CBuxQcN02hdWNZnd63?=
 =?us-ascii?Q?Gm1CXXZrQ/x5yMnD6WNVW9UIoE/3VpOzp8xh2bD4yWXF6BluEbIbaVkKkHEI?=
 =?us-ascii?Q?TTuwGytpDYORBSyycAHv4vgdPpCd406FoTc8JsDA2r42smJbYp/f7/UYkqeC?=
 =?us-ascii?Q?cL4EIqgN5X0Y5ojNeiWa15o4jgYbH/tdMfKkP7faVvM69W/VOmiwOsHh7LZM?=
 =?us-ascii?Q?V8LledjT+vi/f0Hpu3G3/Pc69xdNd9WqekZ8VkH7nf2APzFU19RxOIOp94/T?=
 =?us-ascii?Q?bJTgo+uZOJ04JC3s3Vgf4zmIdN+lE2r9f4lCLzdIGom6VA6dDWPnH1xRg4IS?=
 =?us-ascii?Q?6UpgQhRHlnepdn9+i2O+ZMorE0lrYWcnUqujLhrPbIYGsxMYai07pRi2O/Ia?=
 =?us-ascii?Q?Zkt1kmX/EcRkQ3OlcetaH7Hl8gSlhVlmUaIREYX8DX/9p8AlYxXArs/1fU+d?=
 =?us-ascii?Q?u7Gdv2JGghq6mBJcxIA1IZWuGW6IJqNXIjSqiTrW9ichTiIz1unNvTlX9O8G?=
 =?us-ascii?Q?iPXzTgg9QOeB8a1Fqqk18RMEa5R9pusjy0uPVoVGXMImeIgfqUgsTXh/1Mvj?=
 =?us-ascii?Q?cSFeWQHGXA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae6929c4-d9e2-465d-2cde-08dede735f85
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 11:07:03.9964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tp/qCLTH5+UtxJDDMHDShxGv78DnZwMcNUh/pMrgpJUsvT81v10rRHy9Tkxo+Sw4WG56nTwuysW8xFoXJXwS+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9021

Since commit 55b48e23f5c4 ("genirq/devres: Add error handling in
devm_request_*_irq()"), devm_request_irq() and devm_request_threaded_irq()
automatically log detailed error messages on failure. Remove the
now-redundant driver-specific dev_err() calls.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/bluetooth/btmrvl_sdio.c | 5 -----
 drivers/bluetooth/hci_nokia.c   | 4 +---
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 93932a0d8625..a84275b8833a 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -93,11 +93,6 @@ static int btmrvl_sdio_probe_of(struct device *dev,
 			ret = devm_request_irq(dev, cfg->irq_bt,
 					       btmrvl_wake_irq_bt,
 					       IRQF_NO_AUTOEN, "bt_wake", card);
-			if (ret) {
-				dev_err(dev,
-					"Failed to request irq_bt %d (%d)\n",
-					cfg->irq_bt, ret);
-			}
 
 			/* Configure wakeup (enabled by default) */
 			ret = devm_device_init_wakeup(dev);
diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 1e65b541f8ad..2dc3d97bcca1 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -709,10 +709,8 @@ static int nokia_bluetooth_serdev_probe(struct serdev_device *serdev)
 		wakeup_handler,
 		IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 		"wakeup", btdev);
-	if (err) {
-		dev_err(dev, "could request wakeup irq: %d", err);
+	if (err)
 		return err;
-	}
 
 	btdev->wakeup_bt = devm_gpiod_get(dev, "bluetooth-wakeup",
 					   GPIOD_OUT_LOW);
-- 
2.34.1

