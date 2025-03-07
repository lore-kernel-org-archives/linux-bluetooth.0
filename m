Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2065.outbound.protection.outlook.com [40.107.20.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE3157A48;
	Fri,  7 Mar 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741334839; cv=fail; b=Add0CkHGXuqRQ+0P4vt19WVVzp9Z+2efzBPWQW+D7FfTfegbcO1iD0hFlZ5kHRV83A95XFbITbphZBptmaj9ndFdziyxJqOtKgFnidDfyv3jKdQffBmVPxhA4U+AlXmOmNA3oOtq7MmboX1rc7/MNsNzsQP8dQkL1bvZScePEAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741334839; c=relaxed/simple;
	bh=d+liYDq3T8qFkMlz9VNl/lI0B9wUQS28qrEAbr/cn6w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sLMQfb64PcBwApOA7Y0Sl0Q2encNzdVSj2XlxmEIeIeHPSRaccV3od6GgE32hzWOtIxrCg/owI9AS29FKCIM7TUj1x43e2sIEf0zBxbpzpCO/j240UuxYnZ2ZVtuT2Z24CK6KAk9hfaLjbLYi24FJTUJuqt8S2dnYrSKnMi6CV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Z6xEkUDf; arc=fail smtp.client-ip=40.107.20.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Z6xEkUDf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEK5G+nxowMvczdd5v7pl7VNlI1RuB65E2/WEyYvvlB6tqyc+ADfmam3b31IjSGoJ30JBmqTulS1wFeQVlcooS4fP1KpVl3zeYPJOQguodpzvjKGh9C3IuTypNdT5dS7Kw/mcVk2sfdKmdkSoVGhDSXiwNwvCLIH9vY2G3iPsRufO0a3fbsz1cbX5pJrFujdyhlunC0/u50QzC0/9t/kL5Hoj9egV0orwrIzU8yqwh1Yva1s6MJyJoGjWhLRBogF4t0Z9w+RlOJyJjV7FoBquTJtRQvsIee1RN6HexNjlcRKQhc2LJCMMWKgsulA4gWrHhpgV5yRZKxHzdYDma/3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WmoSbAO9h2bdUx83N9vgNjgMZJBB9TwtYZhip/ymRE=;
 b=LhcV0vKnhV+vPcGPlpLfIBg2ALV480JNIt7MjsNdGAXnFQvtTx4dQANg6YA4W1CxooaX6MN3fKUa+mFdBFIatDQzauAYeXdfQCyLx1YOm7xWz8QuWeSktQrHniRdY4noo2NoBldrxnZpCtPfSHFdoxclL66zGnVH6ZidciXHmvZmiXj8ABXB/RY4V2xluHw39yZ6IHSR1vzg4/4oe5eb3GcsZaP5V6gCwb7QSFCAHwdPU6ss+26+XUUitnW4Wuswtjvu3s8jEsZwDctAo5xJnzhy6ukh//7avDi/PcxdT/gRV87TnEZmC9u2pX+iSu/IowZgr8GwYEMfgTzViTxjoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WmoSbAO9h2bdUx83N9vgNjgMZJBB9TwtYZhip/ymRE=;
 b=Z6xEkUDf+EiwzG8/yZpwNefEW0qZZBxZgjsGq9dHpQq7RSsKsNbfEu7Q8Zyh3Qfu7Qmu0a9fczCoG7EZ5tXYyTWHtMIqETx3O+uRTI81Bq1SeJ/pIFTiW7aE34KlnLKQqE+h6lHmVFzxmGpWEWyWVlCkbThf8BFzstgWdHzCymteAeD08YKk0u3Q3p65BOiwOazx0bndxukIp/2R8tdjM1x3z4VTnClZYbVHoItHUIIuCt0oAQgDpLn0ty7yogV/A4AWIUeOfcOMZT+ORu/9hboU4G9UVcPEEqRlhSV+IaXs0rMI0p8W9Exv3H16ey8301lzP+LXMgGWiiSsuF56qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GV1PR04MB9150.eurprd04.prod.outlook.com (2603:10a6:150:25::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Fri, 7 Mar
 2025 08:07:13 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 08:07:12 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Fix compile errors due to BTNXPUART
Date: Fri,  7 Mar 2025 13:39:07 +0530
Message-Id: <20250307080907.218398-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0084.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::25) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|GV1PR04MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c18d031-9c7d-4a1d-fdd1-08dd5d4f10f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8o1zyXnl9pIhCN+/bmA81D+X4/r63tXi16QlrPvPs0inT5opOeMa40UfTB2Q?=
 =?us-ascii?Q?9UgZat4xk+mDNEuKECcRTgSw7JSexFhryKGGSqaJBF8yWG/QfXmcZFda0kOa?=
 =?us-ascii?Q?1rUBMHxgiM1xIEWyXU+N63GTWxRhU3zXzTN2Ibo40xh2j+qED7mz7NPCycu3?=
 =?us-ascii?Q?EL4ez+p4424VXQFp4UICggl+BwQfMD+0aEnfC2lPdbkDtyPhzXyR4u0LQF56?=
 =?us-ascii?Q?nhLLZ3UlJ9WtAK36IB5ry0lG0UgPycoPuYqmGw5CzzyJ4V/hrwjSZtPShvrI?=
 =?us-ascii?Q?FFbFZuKDG8eR1uBEqAsDx2MO5YEbycmmHMR2CUCf86bmY3GMHcCLzF4+gdpW?=
 =?us-ascii?Q?0HbqK5I4saEliTZmwnWnHRxZBo1XVR0W2OPli4PUBrktVBHs+I4/GZnXjrX7?=
 =?us-ascii?Q?I3moaX4xg/KQc4YUumMp75fxR+wgIIC+aUO+BNCLkd132P2AbxNFKlO0RlKf?=
 =?us-ascii?Q?E9ms4fwd9lK/tUWtdkfsIdWIVg8BXJUVTG92+lvzGtj87Q7uf7InYFhKiBJp?=
 =?us-ascii?Q?+jUwIAlgMBkzWUDI4mYaGKaAMgbcCg87Ynzyn/2kSiQI44DltoJ55DWxi7Xu?=
 =?us-ascii?Q?ws2e2kn8QuFt81C52VTdgbjcZcAbAwaSO3tKfrr25nyBHK4h/NeIxU9LkrNs?=
 =?us-ascii?Q?bgdZyg87F+iW1lvhQzGWO/SQbKk6kVG6q94PxHCBJP2RuZlNciPicwWDNq8/?=
 =?us-ascii?Q?OMYNhyQVfiUDA/ifGT/7SAHce4MCZAeur6FdKLBamyJUFPufO6WOlrpVqnFQ?=
 =?us-ascii?Q?wy7KQqqMSTpRbpVf2I56lwxrSYXfApvkgGKrUP5EV+aZJwfIiz27RhwO+Wed?=
 =?us-ascii?Q?FVb+1Kd0sk07nXaYVxeRx4/fIhZShmuqksRzCZLHzdhZPtM9TIoLNvbgiLSi?=
 =?us-ascii?Q?TWAKsfFJxqfba7MBtfzUOMvynojtYf72zaxPjISfIf2CxJijqCY+CT62QRMd?=
 =?us-ascii?Q?7IfC7N1g0QhGzoSydEWxn6TUaSPti7OVZ64KtzQ8dC/E+zkpbR994ebcPim5?=
 =?us-ascii?Q?aZL52ypY7mInck2oiao/+moG24MMgDrk0wl8XSVey39R1zxU+IDRQmmUYmfy?=
 =?us-ascii?Q?/ip4SLMNQ/MNwruOevA2G3KX6oV7ztTZqIWONhRYPkTPyu0wSPIS7ouPibxO?=
 =?us-ascii?Q?jbvMcU/oZfvalKK11ChGdPpALttPmB+VRQaPMvvDWMmltZDXELsHfS/cEb9D?=
 =?us-ascii?Q?tEJJXXrOEzeNdSnm7NorB3SToKSob9zzoXkY6ZoOEEFrm/zroRCjXcJ84X2j?=
 =?us-ascii?Q?2lnIjHLcSeDZ9KUEYQNiyV3BCpQo/AC75NNxG4Y+L+S2bwcSDe51eLt/irHk?=
 =?us-ascii?Q?JI1VrcwqSLOFMYB0nrnppZAvQkS+T7BWFNzQjq4+I5GDPh+zimdBCgYgtjBJ?=
 =?us-ascii?Q?ZBfBV9RxLRdDTwvHMa4ZcAuV2tihpJwkl6/wR0izDJJeOO256ljDR9OVauey?=
 =?us-ascii?Q?RZ+rMYx2UEuUbLjRP88PVAJLTI1FzJ2IakbIagolCNlm772eyffzAQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dzA72aasKnOPWtvksJ/k/AWSxqtF1ZhzedlES2De2XmMyPHEioAIReSdlTwv?=
 =?us-ascii?Q?d6YX4LCQRmXzWQPWwAqSSr3DyGy7sQUJ6LCmcuxKDVLHPZv6xuf/PTT7Q+bo?=
 =?us-ascii?Q?5+5IMAqBWWsuKfvkPA4cjKUBUnNGpg3SIgPNQZVz+vq+IJ2VVi1Jnl+JsRMN?=
 =?us-ascii?Q?beAXlC8ReMbC2naCiPEgNIlUYe+SZrSMKxYPXTnw38VrdGT/CrHdz4f/JRU6?=
 =?us-ascii?Q?Ob8jSdUJ/axJHcA0fVwhvEaIhnPdurdb56ibxvFKL6kLMjOiQlL5MPmz3Lfb?=
 =?us-ascii?Q?b3B0T6/qtsOxuYGIFSo8ZjSrhv8boAcJHYqupHvNWsBJQ14E2XerRsUdZJF8?=
 =?us-ascii?Q?GOZi54kMELmh1nzmGDXf3RS1bxndfk5QIT2t6UFX7Ukls0fInLjYhgR83+QB?=
 =?us-ascii?Q?pRsLg2K1pI7A/oMLK1sKrRp120rho0LHz9mP0C5LnB2U+ILi10hAqDs4rkPu?=
 =?us-ascii?Q?ZGfFGdSmCDPHtrCokE3mIUEq8dSGsdgVIbJzCzlqYGHeMKF0C6MAJbcdkZpz?=
 =?us-ascii?Q?AI4fqcQ4AnhxjW0qvUpOTQpcfo/CQ1HIo0fpatY2VDhn674QWPN36fAO60YU?=
 =?us-ascii?Q?jf6qhHMj4izz7w1Gvnki6tj06IAjJVDp5X/LMxdDMtCXuNrwkcfm1YB08VPN?=
 =?us-ascii?Q?onhKcUP5hVpag62WvEw5VdrqQ4hvT/lgdOznHpzxikNZyYNQhMhXv/SafIta?=
 =?us-ascii?Q?be6grSzs1EBY0kLZ3qHKWdkH7//z6h3F6QkzxUdz6vSfS27fb03VThslX4dq?=
 =?us-ascii?Q?FWCXn0+qkfqRS2cTEqTiwv9qHBvUfwCDiE8gP8DWteuWpB8s3d3GsVjwcllB?=
 =?us-ascii?Q?5axsypMhLW2/zZfLYnz1rleID7RTGBKTHy84Nk5X3kyyPzzzhYscNpiiu3mn?=
 =?us-ascii?Q?mWcfSvnZWW6FEQetezTve3f6IS6XS0TK36fUa0Wm5Sr9ZlZSH5zRx4mpr+Un?=
 =?us-ascii?Q?qpWTy5HY+0jHbPY6KOYsWqfopyNholUp1HS834uKQTdfS1ssHFz4pJu79rDm?=
 =?us-ascii?Q?DiZ6+RWndD08x1rAIZtcxnsLUxLexxBA/pW7YfhpBBA7fkjQPBn6VMh7stfx?=
 =?us-ascii?Q?nnKYgdbQy+mgqTj5Bf9XhWk3TffowMEsEBRB/ZW2cXN1dSYCqfKkH4xXZbfN?=
 =?us-ascii?Q?YljjE4Kxc2I6yUyHjzKyQJRCc1x2lNg/OzG7lCnwtTMCyBuCPM9Z9p+s6rWx?=
 =?us-ascii?Q?fZ8Kaobq/ygOZshNgOTEJo5wktm8Q83bhD3XuWsb9EmQFn/soZ8hNjNV69R6?=
 =?us-ascii?Q?LXhpSwENnYm/puTO7iTGuIbkB0EYVFJt0DX5lscqmYP3I9pmi0Vx9fPE32/N?=
 =?us-ascii?Q?dHU6Ecmnf6wNVBAnmpzhAP1lu5EDiy8t7Yh0dFQIZxXS0ryzQtDbxX6C9UnX?=
 =?us-ascii?Q?BPPXBrFjAKqplv1URkuq69Doh+8UFgrKCLE+jVLfD/E0IM/5GlZMgz0JCIGC?=
 =?us-ascii?Q?ynKNEGBVjPAtar936bG+W+SiKrxVPkKVja+zi3JPp55rXxG6vTr+VJlQvo5D?=
 =?us-ascii?Q?5EelyMA9t1SGIgPlw6bUV45a1regbZf6IWGdPjELmsXq3c1NviE+Z2yT6ikp?=
 =?us-ascii?Q?zogpqlpk1O59aj9UkuCqnzXOMD75MBzI1au4BaxC9bdUYLU76/oclYXJRzpa?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c18d031-9c7d-4a1d-fdd1-08dd5d4f10f1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 08:07:12.7485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LfEgB1seXHNp+c6c5DhEQwLlmm5qoy9YiaqIL0eHrc6CqvaDqhgkXQwjJ+cwB/gw2hhIQgcMeWi8efVp0DqAdmCRQAwC/XTbqYnqoqVv9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9150

This fixes compilation errors seen due to merging recent patches.

hdev->cmd_timeout was recently renamed to hdev->reset in following
commit:
commit f07d478090b0 ("Bluetooth: Get rid of cmd_timeout and use the reset
callback")

Renamed nxp_cmd_timeout() to nxp_reset() accordingly.

In latest master, the check for "local-bd-address" device property seems
to be missing. Added the missing code in the patch.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503070951.EcxRrnHK-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202503071045.5Ac2pLEW-lkp@intel.com/
---
 drivers/bluetooth/btnxpuart.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index abe2ccd92604..b3454227c7c6 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1318,8 +1318,8 @@ static int nxp_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	/* BD address can be assigned only after first reset command. */
 	err = __hci_cmd_sync_status(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (err) {
-		bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%ld)",
-			   PTR_ERR(skb));
+		bt_dev_err(hdev, "Reset before setting local-bd-addr failed (%d)",
+			   err);
 		return err;
 	}
 
@@ -1422,7 +1422,7 @@ static bool nxp_wakeup(struct hci_dev *hdev)
 	return false;
 }
 
-static void nxp_cmd_timeout(struct hci_dev *hdev)
+static void nxp_reset(struct hci_dev *hdev)
 {
 	struct btnxpuart_dev *nxpdev = hci_get_drvdata(hdev);
 
@@ -1721,9 +1721,15 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 	hdev->shutdown = nxp_shutdown;
 	hdev->wakeup = nxp_wakeup;
 	hdev->set_bdaddr = nxp_set_bdaddr;
-	hdev->cmd_timeout = nxp_cmd_timeout;
+	hdev->reset = nxp_reset;
 	SET_HCIDEV_DEV(hdev, &serdev->dev);
 
+	device_property_read_u8_array(&nxpdev->serdev->dev,
+				      "local-bd-address",
+				      (u8 *)&ba, sizeof(ba));
+	if (bacmp(&ba, BDADDR_ANY))
+		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
 		goto probe_fail;
-- 
2.25.1

