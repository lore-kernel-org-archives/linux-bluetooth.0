Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1566E2405EB;
	Mon, 17 Aug 2026 02:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786933523; cv=fail; b=Q2ULVOjOoSN863+DeTKyMv2F4x1nxCBOepIWMtCQCOu/4WslzGTzNZs4FWDBcb8aAODzUqCofyiEg/W8SNNh6tfLmQDd6nzrMchLNrVpYDsMVjn0hfXkfNQ3jEhoe5JaalAASOQUE7OemOkRntvErtfKAndvllC6Wmd+G38A9s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786933523; c=relaxed/simple;
	bh=J8pY1hpw5eLKfFzS7oB4I0SbOYCleYmVkGqGaH9T1Ok=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=El6lPMy0U+arHsDJ9PWFjqZEiWtgRp+t26RM8HvNhGcw4qcMouqQ3WKEdjgKu3+saQyshWsmfuySTyUo2wbwJ+GjvQ4AKCPlD/lTywC1dLc/FSwwfeS4f9KNzgmyVAI2HqU3iga+clM/ck1S+BMtzhJPKTy9mDCFUMAYMNP9oww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=JeRJBR1/; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JeRJBR1/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHduzp1/zJOSUsDnvGK58cQWe70/3hNWxSdtIW/eCLn+QTT25SrqGwrKfIRUPzVdlwJR4czX9b6ek/BqEQr57jUjiYQXOvOctjwuroOoE1UyR3RfvQ3hBm5bU627FIKEfQ/if000DOrnTtcbWBmvf8JTYhK47QN7AYNdYs75KCE53gcEQTaui8u0Zb+YM5E1nYlUCnBCNvd23TtBulmWF2j42+cM5j5bRLtZO8E87N8GYTPvoumup2TpoqWKHr7mQgKSf66Gsf7NWKlrirxVXknuhvCtnBwFsdTpab48cMPugz+O9WaNGHpE0BSuiWF8DtfKwrjR4p9fmUIHUd1FQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exhXdWiokIMDCwCTawWVUAAyYUAfkMt98TRlfGDdXwQ=;
 b=Vw1s6slAGd6adsYNvBhHpCfxmThP0exL1Dv8uT5SFzu99t43u+2oxgU7QisXsC0D8frJnE2+Q88YvASVheiHkPVLvefNDwgVasYQN/jM5RxcKgtd1MNilGxD8jK5vRAmLGNMSgoM6oJMvI+xgr33+f4b2wSaa8XlvVnAudOF8xX1gEpQqyQRiBKUTHyVK0lGf93/sew1kfTrO9qGMLztX7p4EnCUnlfck4ycdq7kkYNYrwOtc2KEuxTn+Sw8M16oXsD29UqD5nkTIQPhjNMTJEWrzXjcLsCQ4V4ZGbDiXTc4esBB5177te2FlHLi5UP4YWGJyfbPKyPGTXYkr6Dxpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exhXdWiokIMDCwCTawWVUAAyYUAfkMt98TRlfGDdXwQ=;
 b=JeRJBR1/BWot4GbwPRk8Qo4Cq1Or+sD9RzbNq9KLBz8HDIe088hN3EV3tase/MoGxk4HkcJkL/GOypT3LAxNTx1cSNOQCbXhatPK7eFbTaxmWrMsd8eoSGP6rKX0CvadvkjE+AHRwLmDdqUCJB67grNieW+OZZOTals15s0WVj8XLPrz4Z5MNrfz7VpLZ1EzkjEaTunWgurvGBrA19hzuFbH/c2HEvjvCpbEyjYx3X3tRMqyyRXJ8b9UgQi5lm3tqT5qFGrYL5eG5xPgUoTwbz6tmVmtc76AtF3mmjdQbKHEXsk+y0DUgDlhndfmyrmSpQamLWVOG/514VD5SxzGVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by VI0PR04MB10101.eurprd04.prod.outlook.com (2603:10a6:800:24a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 02:25:18 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 02:25:18 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Date: Mon, 17 Aug 2026 10:27:39 +0800
Subject: [PATCH] Bluetooth: btnxpuart: Check remote M.2 connector
 availability before pwrseq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-btnxpuart_m2-v1-1-a23e51020794@nxp.com>
X-B4-Tracking: v=1; b=H4sIAJpxgmoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC0Nz3aSSvIqC0sSikvhcI91ESwtDE0szSwtzwyQloJaCotS0zAqwcdG
 xtbUA+L20bl4AAAA=
X-Change-ID: 20260817-btnxpuart_m2-a9814969871b
To: Amitkumar Karwar <amitkumar.karwar@nxp.com>, 
 Neeraj Kale <neeraj.sanjaykale@nxp.com>, 
 Marcel Holtmann <marcel@holtmann.org>, 
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sherry Sun <sherry.sun@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786933674; l=2800;
 i=sherry.sun@nxp.com; s=20260723; h=from:subject:message-id;
 bh=c5elpSoQBdJO65aTCBFFpfKdzpiBcPZORqvTL7AM1KQ=;
 b=PGU+zKgvOUaSKKA7dq1P+N9KM82HCKZ/Iy+3eldA2InsEiousCXDNr+Na+py9zFtCZfCdTxj7
 72mN/vmGEFdDLi7pbiiUfFX1tEsX/PW60svFw21saqEyMF+L/MZzOXx
X-Developer-Key: i=sherry.sun@nxp.com; a=ed25519;
 pk=YnYnIFJ2l+5v951x9shBVfHhminNi+3LTfFa3PxSdnI=
X-ClientProxiedBy: SI3PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::15) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|VI0PR04MB10101:EE_
X-MS-Office365-Filtering-Correlation-Id: 0971a511-c23b-4bb1-17bb-08defc06c768
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|19092799006|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	GsMVHm1IZ+x7Vd/ZgwRk/nzL0XzZUdjTxjL/fidN/YoqRUV7Lv/EtXfFNc2Vow2wond+U0gWDtQcC6XdZVxGaMSzZlYJkvtuO3d3+X9wwo/mZyKVcaBm2xEGYU4/vQVXtHjk6h0wHwE2RstK6AgQWdGpPC6sK0FpPssOr9vjsX5+d0Xg3+9BhIDp4vNUUDlT/QXI2tm8KwSj547NcWNiSa+arBfhdC+WXvH8Zt3slrmdeJ46DwypY9Iw1XN5tPcxXRcNtfZFFF/aioph1vbieuqEeIIKJcorUcIeIApE1lOUs9kt7YD5UiABb+CtH0pUI8PtuVU43WmXPpXI+foQ9hXwC2uUiCHEZnSbAEDwqVtr2/su4lfu9WlGe13qYJvEgGmRDChqOA46TlRl4wwzkSYFcudMIzjIntdkYHFT/CXlQHtffVlbCWRNoKciAry+fgjUbLFs/O9xEXywJFLt/xlQvWa8y1Ogm25J4E7B16dLt5FEBpmNw/+CfhMhEkdSpyDsKPAUjQsnH9/0W9TlrVZWDYQ4pvtwVATsdWaSzbQbOGbdtgC/rzIoVEgsr3guLqCeMqFh1dEWzpZlQ9A8h7WDbApJ26R3gO9EX/Yi5MrpbRStVR6CZ8UIL+yW2M4sa1SH6e1OF53SAANLRrh4KUMh51Ivj4k96CfvpUXCDE0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(19092799006)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cm4yaW1MU0xMYkg5T3RZZUE3ejVxN2x5OHNwWUUvM1ZRY29DdUlyVUdYQUVi?=
 =?utf-8?B?RlNtWFNIc3JvY2NQa3lvL2s2bXVSNXNGWklIUkNHcEdsS2NEbDlDSGZ4Y1pk?=
 =?utf-8?B?QzVra0REdUl1QjFYTGJmQkdTZ2ppeURoNlUxRVpKd2FSaHUxcURxZXVvaE16?=
 =?utf-8?B?dFJVczJLRzVrUXJqeit5Q2RqUjF3cXNGbEVtNHFabEhYV09DSVlKNW9kYUgz?=
 =?utf-8?B?YnhaZGR4eTU4YkhzT3k0Q0dBMno3MlVpYXQrWTdYcDFuUWY2Q2duSUxiL0RJ?=
 =?utf-8?B?VkZXWjZuOG5lTHVhbSs1WWV3eHVXVFhrZlVtU2JJS2RUck45L1oxY1RyQzYy?=
 =?utf-8?B?VVJUQXNxSG90SGM3RCtReGZBUjVOZEFoajVqd2I1NS93ZjVhZW1GQVRqUDJR?=
 =?utf-8?B?SGIyeUZ5eERySU1vcmxobHRkUW5XTkQ1enVoYSsvSDFBQXcwUTNJcmNENkFS?=
 =?utf-8?B?dUFoNmVWYVFDRWV2YTBRNmpRZklUam5McWxwMVZ6K1pKc2h6VUdEV3BnTWJT?=
 =?utf-8?B?Yjd4NHkzYmRwNTBIRlQrRkVmQnZlQVFFMngwVWJsaVpBWVJmR2ZWN1dPUkJD?=
 =?utf-8?B?NHhJQ09hSUhucldBSEI4NHlhcWJFK3pyYkdyV3ZLUWtDMHpSdmVwNWxzVTFv?=
 =?utf-8?B?MVY1cXRHb2NTVXAzbXlha0Ziam53QXpFUHJ4N1JDOG5QbkZjY010K3R5elRj?=
 =?utf-8?B?dkY3TUtPYmdtN0wwR1Y1d1NwcUJNYW1mZk1hU2hVdjdydmpWaEYvSG14ajU3?=
 =?utf-8?B?Ly9OQWcrdzdsbGV6SHd2OWF6SklvWStWY3FXcHhRNVBpY1dMQkF3bW5ZeVps?=
 =?utf-8?B?ZklZT09rMFBKWHJXcHJqMndnbXFNS245Q04vdUVtUVhSTnZ6cUgwUVBYWnQ1?=
 =?utf-8?B?VGk3Vy9NU3g3ZjV3MlFGQWRneGhFdmZ3aEo2OW9FNmhRcjg2Q3dDbWg4dXRQ?=
 =?utf-8?B?cVkvemFNVitjVGtSeC85SnJDOXQ5d3Nid0xmZXkvYXhZVStWazd6MUJsWWlt?=
 =?utf-8?B?Y0M4cktGL0hiSGd0Wmc3bUhZVE83Y050U1U1RXg1SW1HemRjNCtNbHVNbEJs?=
 =?utf-8?B?eE5YcXNmT3I0a3BBR3M5U3M3SWRkYTBld1RFbDFiQWdEOFhXUG1hZWllaE43?=
 =?utf-8?B?dHl2TVA5THR4ZHlxTUh3eDgycGcvNGhtRVpoZlJRUWozNUpuR0lkN0FPY2dL?=
 =?utf-8?B?aHVhWWY3U3d5Nzh4RFNnNlBSbG5BTDl5QTJQMDNUUWx6b1dVRHlRaWVKYTlL?=
 =?utf-8?B?c0pvNkRjSUhJOXF0MVgvMzJFYTNGZXlvMytnUWt6bFJ4TElBV3MycU1qYVZH?=
 =?utf-8?B?aFJTT0Z3WEZNdzJXRXlFVlQxWmw3Rk5oSmJwMlg3SE5nMkZLSGFMeFJXMk1U?=
 =?utf-8?B?Vy9qN2toRmd6RVU1WkJtT0ZjU3UzdzFVcGRSOE93WU4rM3FPdkxndDVtWWla?=
 =?utf-8?B?M1RMUzdmaEFZMmdHc05hZlBwN3NzNVdhbXE1VUJyeFdQbTkvdkEvbjNvNk1R?=
 =?utf-8?B?MHJnbzdpL2lFR2thVmpLMjVScU15eUk5ZmEwTERmMXBrR0dKdGE4V0xuL05P?=
 =?utf-8?B?b1cveHVKM2ltSFVTMHJJMUQ0Y0lEN2FBTXZibGwwbHQwa21ZTndNL09BUm5s?=
 =?utf-8?B?Y3Y2azdMUDI2ODhrMllENEdUeGtzMVVla1RvcmI5c0dTbEZROTE1cW9HUFZw?=
 =?utf-8?B?QzQydXFKRWJ6YXhKTWpOSmJteXh3S2N0WmpMa21qb2RiTjF0YzFFd0VsQ2gv?=
 =?utf-8?B?SWN3YVRFeFZyTXBoT1ExMWdwbzBUTHFjSEhPckc1WEdiMUpTMThrRnJEams1?=
 =?utf-8?B?eTBSSG44WjJXWW1XUEozQkpaS0x1dTdIQnRtSkgyUWNlcVlSNStDbmJsTXJN?=
 =?utf-8?B?blJ0dnQyU1BIYml2Sjl3SklrNW5UbGlETnZ3V0JkWFdTOUtTVXdrYWtLUGZY?=
 =?utf-8?B?UkJuek04VFg0aWNUaWk5Q2dTVjVkSEFTQXdaY29FMVdpMDM5aVk4WVcybnVM?=
 =?utf-8?B?R2lJbWxvQ2xVWi96a2hEQjdoaVAyU3J0RmQxR1N2TDNvYms4QnVoclgwemVx?=
 =?utf-8?B?QzhnR0R6NWM1c2xyU25YQmZGdnQxNmxpL3ZNeWRxcllsVzNHYzFtZkhmbnZS?=
 =?utf-8?B?ai9SWEY5eE1qY3FKUGhpL0xWdW1YdkkrTFVNcHdRYVdlU2lhUnlITmdGVVhM?=
 =?utf-8?B?WVE2MjNPQnpDQ29BemFRMmdCb21uUXg2WTdLUGtQUE1RNk1TVGxtdnV2dmlw?=
 =?utf-8?B?aHJ4SUtvV2tsZDhUdTBGWnlpWW5idXRxOEVlSkl6VE5TaXNmTWw5VHcrZi9J?=
 =?utf-8?B?MUtIVnFBSlFmUnpsZ0tKTVJCU0ljTGFVeW40NXlpekJDUnpveFo5Tkt3MXBK?=
 =?utf-8?Q?IoSkTMI7r53kdcBXLzC8/kPYTXI++H6ZUN3QU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0971a511-c23b-4bb1-17bb-08defc06c768
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 02:25:18.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yLNG4uV2rrVXZ1x7uZlA1AvPBqXR8peQU9FR6vh/hgLVu91NGd6XuKZSC+Z20PJhT+kSJJZqfccLQLoB7uWmV2s96cWBFafDf5+INpD8c5HyA8U9K2Dwi8c378e8a94T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10101

From: Sherry Sun <sherry.sun@nxp.com>

The current code uses of_graph_is_present() to decide whether to enter
the pwrseq path. However, of_graph_is_present() only checks for the
structural presence of a port/ports sub-node and does not check the
status property. This causes problems when a DT overlay disables the
remote M.2 connector node (e.g., switching from PCIe WiFi to SDIO WiFi):
the port node still exists, so of_graph_is_present() returns true, but
the pwrseq provider never registers because the connector is disabled,
leading to an infinite -EPROBE_DEFER loop.

Replace of_graph_is_present() with a new helper that traverses the OF
graph to the remote port parent (the M.2 connector node) and checks
of_device_is_available(). When the remote connector is disabled, the
pwrseq path is skipped, allowing the BT driver to fall through to the
direct bluetooth child node path.

Fixes: 3c48135c1397 ("Bluetooth: btnxpuart: Add M.2 Bluetooth device support using pwrseq")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 81cdd8da5636..e2b8f7997e4e 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1809,6 +1809,28 @@ static void nxp_coredump_notify(struct hci_dev *hdev, int state)
 	kobject_uevent_env(&serdev->dev.kobj, KOBJ_CHANGE, envp);
 }
 
+/*
+ * Check if the remote M.2 connector device linked via OF graph is present
+ * and available. This is used to determine whether the pwrseq path should
+ * be taken. When the remote connector node is disabled (e.g., by a DT
+ * overlay switching from PCIe WiFi to SDIO WiFi), the pwrseq path is
+ * skipped, allowing the BT driver to use a direct bluetooth child node
+ * instead.
+ */
+static bool nxp_m2_connector_is_available(struct device *dev)
+{
+	struct device_node *ep __free(device_node) =
+		of_graph_get_next_endpoint(dev_of_node(dev), NULL);
+
+	if (!ep)
+		return false;
+
+	struct device_node *remote __free(device_node) =
+		of_graph_get_remote_port_parent(ep);
+
+	return remote && of_device_is_available(remote);
+}
+
 static int nxp_serdev_probe(struct serdev_device *serdev)
 {
 	struct hci_dev *hdev;
@@ -1863,7 +1885,7 @@ static int nxp_serdev_probe(struct serdev_device *serdev)
 		return err;
 	}
 
-	if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+	if (nxp_m2_connector_is_available(&serdev->ctrl->dev)) {
 		struct pwrseq_desc *pwrseq;
 
 		pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");

---
base-commit: 4477a78374a57c3809b172ad30cceabda48c47c6
change-id: 20260817-btnxpuart_m2-a9814969871b

Best regards,
-- 
Sherry Sun <sherry.sun@nxp.com>

