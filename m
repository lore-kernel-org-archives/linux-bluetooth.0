Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2089.outbound.protection.outlook.com [40.107.241.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9292505AA;
	Thu,  3 Apr 2025 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743692430; cv=fail; b=efAPes9cvMtH7LM989eV08UVaLhiPXGjqPyWmmI335gJPezMGgh5Mb33kC1m11Mxj6IdiECQQLR3yhzJZZ9L1XgXhphtmqrssCSeOcwBLVbCS9YFMPNepMAFQYs9FGvR7LaKY01PHQxzyCkMCQLSeRJP+8SJcXtT2UlSB940Im4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743692430; c=relaxed/simple;
	bh=9kjlzt4eFueOwyfbIoTuNtM/Mzz8SxsQ3A6/gWxfr48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T8K4t4xXblRoSozdKYNkFTtsEgUpf/isLtH56ao2mV9eheVvBUndRR5Z2vJC2pvEAw5iQov+4tr21t+YK0ggn1rLmV/Ftz3FeNgqHXoJ5wTtMVpx6DC5H+9XMRzeSeJBD1U8S+pIZd2dkGjDw+4wi1K3dK733S2Pk4PiXiLrcQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RJQaUUlR; arc=fail smtp.client-ip=40.107.241.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RJQaUUlR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOl2FZ8m3XfJ2Uyqm3FZ5vkpDKJcJrPLQPBxqNM5zegXxHsuURb7uzn5VAeI8X9AIjiilTtDvRL3A9ZvzTDnR2ht5GnVu2r8z4cCCmO3CO1PHib0sqTe+ikaqmR2Tkid/jq9X2S0AfuQ5c2Xdc3d1TtLP89vvfUnzngOZqAgmFsps2tvvKNomLWIEJbf69Ne/FxLv950gycsgNub5+RL9BjIdU1EWsYPI58ZDZxw2lLVd1IadOLDC0WzNEExp6PjH0Pd1R5l1ke7I4NY82CS2fK2NwaBe9dHW3gHw2hycux/HIOD0R7wH1qZCrRDTsPVd0ABgtxaz076cv0aCOpayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMhFuhJvR4YElJGgvtSEvqtGeY6OgP5+4V8UfRQcwHY=;
 b=t7J+CmUYId/zTfAOj7LTRYFjb6rGM3nmrBXNV/thVGCnrYswEepHYXXKXMb8kLhE2uiWqMKnHSmNVnRFlIm/nnG+ChnBLzRo12KoKBEeKm7IxbvZBC4jsXWUiA3dk1ExD6fEVw8clTGt3+5Ig3PxYZIUoUE+ZPXb1yxvtHKnDrQsoaSWa023XgWQ9qzkJga1g0HXuEn4LeW4ja4XjbaQzDfE0/zbNXlZ4oYmB/oGR82+sZItZ2whte8QoJKXNr3qHrMILktfo0yuhEJNIulFz6q++K9HFJM3E2YTX4tqXDqEKBJ84kAHjQJQgiyh/11HbPg3piak8vyyY7lJw31TeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMhFuhJvR4YElJGgvtSEvqtGeY6OgP5+4V8UfRQcwHY=;
 b=RJQaUUlR1EvHX6rAfHLDpBUqS1O6YksibQQgK+HZJSORwP1VR5N3+fZMvwKWiI1GsVmuovxWh4DkQfXVOqHioJ0YNb3dPpe4YrseN5Ec93cCgi8ryehcDXqLA63Q5mpAEAe930URN4g/nul7GgmWCpzCh2On2vzFs7a5oWEKLJvPIadFvhEWWmfGzpzJCY4jVGbB4oWBkibIpAiVEu1JolrGfOtOY2ZF6/4p5lzLRkzHFC4wyWDoC1KRsD6V2f4QQP2RcLw/SJ48TPMkWNCBOCSCPwqas1ml1uJFAVB8rx8gx5hB0lFdUpWD7Be4NNWYTNgN3CKyPJLS3TJ/MU9Ylg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by PA4PR04MB7712.eurprd04.prod.outlook.com (2603:10a6:102:ec::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 15:00:22 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8534.043; Thu, 3 Apr 2025
 15:00:22 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com
Subject: [PATCH v1] Bluetooth: btnxpuart: Revert baudrate change in nxp_shutdown
Date: Thu,  3 Apr 2025 20:32:23 +0530
Message-Id: <20250403150223.4136-2-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250403150223.4136-1-neeraj.sanjaykale@nxp.com>
References: <20250403150223.4136-1-neeraj.sanjaykale@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0034.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::13) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|PA4PR04MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 7900b4a1-a72d-4730-e9ef-08dd72c041c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4bxLba9hQ31Ui9TXPXBrTLR0Jyi9b+pXw6OGs5byheLv3NTG3rfzhTrUvEbN?=
 =?us-ascii?Q?TZUBCbEQ7RllxG4rwdzuIPUr2dgNdPLcoQCQ6XxbPEXpxCkMdYNi/TYIutpu?=
 =?us-ascii?Q?wlBsACyWuJOYaxBtzE/8RGnYayqmVnB2TPP4u3DNI6FBZPH6+gOmlNnXLEPM?=
 =?us-ascii?Q?8TnFbE9o53Aj2OQFKJoyMk2ggIlIMiLw+UnCzPkyGqCa8mugJa+5FkZ7JoXU?=
 =?us-ascii?Q?JlQAW9GjNNaOtHo6Rf8GcO2p2re3gRNxn/oNxq5pGwEsPx8VxydMIoH0E61x?=
 =?us-ascii?Q?zArjK6ZuYiPAMnyUlOPhV3JaEsip6jZAAGQffTgsUV0sX3142Gf3zajJIDVL?=
 =?us-ascii?Q?xZF1FgL6mNs40CWjmp5knIbKQAE7doBuivpXg6RliyZHbKHc/kjQHPXz9TMB?=
 =?us-ascii?Q?qrhRqHoQvFPEbKrQ3JirLpyubGMHQL23iFbJI8CMQVKciv9GPkNWc3klykWC?=
 =?us-ascii?Q?A7xOMuCuuWASS8MmxZWYScZGsx+CayUDptKjzr8gnUDCrQs31Qm1sevZrkx/?=
 =?us-ascii?Q?DQQdmbF6oYVO4Pnj9vYD9kgpN+/hql58PmYpfP37jrqmncrlKoRoPUJ8iA71?=
 =?us-ascii?Q?CrADHYchOJibi6QT3U+9RtOWCym/9FDwx5QxPAwTO/F5WWGwq93IctJZmgLm?=
 =?us-ascii?Q?2PKiM8iQTsvSGgBJhDP2tAeFuRMxShFszigQ+0hzH9rLxra33jIqQ+MqnAIX?=
 =?us-ascii?Q?dRgByEQTIq7hQDVAiA/wZap3Uh0GjlPk66rLRhEJWd7qD0w0doqXlqq4/efA?=
 =?us-ascii?Q?RI4Um7xatfTrjtSMr8bsyD6Qga99R1KKFTlysLYEfIlSw7U+8TMi62hoSOx3?=
 =?us-ascii?Q?KDJNwidmuCBG9k5JG3PHynz9+QD2s9YyVNxKOWTUZEhVrIYpxxWX9luf9yZe?=
 =?us-ascii?Q?6wp5mA2dTg003676z30K1XGr1M9aAe3h7jcMH5ZzEf897Ebnw7pdj8Q/U7zL?=
 =?us-ascii?Q?4V+Nlkq3uXwGYy65gqa3gkKTmqxjcH3I6sHb46CPHXIfE8YhIC+p+tADB3nd?=
 =?us-ascii?Q?MOsDStI5InCYpo6GFazBED5UH8pMdByq7xSjihKqXO3+g+130nN1JIbI9Tou?=
 =?us-ascii?Q?pm3DkNc98kvYZ+Wbiv/mk8h9UCsS+XCiPafGJ/RFHkd/lGkuwsNcUekgIdUN?=
 =?us-ascii?Q?7V/Yn2vlIGsI7xDVgUOLRckyA10ruoDZuw3G7JnTdCDcRCwJv1RKeLPmaWz7?=
 =?us-ascii?Q?M6UdISgJ0ipR6hxIkSLbGmkHf1Rdc8L61o51r+Scv4agHDv242uysrdZPz00?=
 =?us-ascii?Q?1w9LHA3f24EVO9WYq/xMqm7oRLAHdmk32/QIEelPk6uLTKXoKtbIxjkRYd7b?=
 =?us-ascii?Q?8cwnfJ7DNvheVp/fMsuUrX24ui/Qhp+gq/N+/cOKQVb9ays/JwDoIkYEjsqU?=
 =?us-ascii?Q?AFjuuQJl0+SsYbGHX8uGWvW3U0FLhPJRRtA0xfGexrDoRKm6JPkOf0I49uhN?=
 =?us-ascii?Q?99LiIw4VST6C4P4iGfrc3+SlcYAKc+qc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bcFff5DaZTNRpF9gwZMBUkXZ6Jmj3Hor+RH9ITiLMAs/nMeuFa40tCHkE5GV?=
 =?us-ascii?Q?6vy2sCiH93c+LJw/JHe+yEAFqLhCTk3qIENOEyMLMYI1QdBylwlyW/jy7KKi?=
 =?us-ascii?Q?d0aUCQ2Hf6XaCanI/OFhLJby81Zz9Edrr68Nxere2SEMj+5j1qDIQcipSn/k?=
 =?us-ascii?Q?djHNYEUD4cJmJ5zcAI4XWpv3vUFpvR+kJW/ksdBX0dLnuZbKPg5bPyWBZGg7?=
 =?us-ascii?Q?rzTi1WqBbP3kChbJI/IS6pVuFsaE1LkfPyyBobWpUQu+TH3xH8PIqNhgGiI6?=
 =?us-ascii?Q?OvE5+U/3fMX0tb5C6bu6dMd9xo7CMcmCOhv23tnKoWI20EpU/iZs1Wmlngbz?=
 =?us-ascii?Q?CCZH0Txq5x9ZMbOWa5IJ/iu6Pf71Ej5ZYoPrGWZ1HWX3c2VSJ+8anzdaTtPn?=
 =?us-ascii?Q?eEHkBXQlOL7g7f3f+R7K9TQFy3bSjLhgeGuOvr2PwXlQfpFNNGeInFVYEKtU?=
 =?us-ascii?Q?f8hgC4yqQr3mVHJ27RPpMbd52VraOkrI8GNOZi6TdOzHL/d+VkLQorQY8WIe?=
 =?us-ascii?Q?rXaEqDCNmL0MG6Q/4RoFVmTV/1qf2WVg3CcTiz78+MVLcjAcEU0svl5cLZKN?=
 =?us-ascii?Q?/9YCcKUMM29OagJZ7HNKqCW8HjgGGk3ZQcoTsPnXoeQNLu5WF0fpKFNAZ/ka?=
 =?us-ascii?Q?d9Fosj11Sg8d/p22P6RYs9s3XwZS/HHuQlhQnxOEDu/MnormMwE0VcvAA4jM?=
 =?us-ascii?Q?1BjFJ40xHhQMIrpMDpWwKnRGOnT9YrvXuTAW54IwYGxELPcC1I3ioy8FSc8C?=
 =?us-ascii?Q?QHg1vki81cOSb/3Ma5Q6zUm7hIi5wjGRLQM8mQgD5hTww1nngpelpIOQIKvJ?=
 =?us-ascii?Q?560iefG721qZyD/FxxS0jtRh5U585na2vZfv8lwbYKguwlniYXjGxtJB4H34?=
 =?us-ascii?Q?P+CSgVjF3NIPbPsSCboTdKz+tdnd9YEwc/YMhIxUZ30Yrtc5mme3tz46NBHi?=
 =?us-ascii?Q?NAt5yfXr/26odoMSk0f0RVpdkSyY5b03czer91FC+jFIywXPc9Y+gbv8EiPl?=
 =?us-ascii?Q?7rk8VNMsUHjXcoUPK3wK04qPXO7OyvERsCrpz6BoDm/dmvJgeX8oDNL6PuyY?=
 =?us-ascii?Q?8BvMwGOnaKMVC2dbwsaRTvtA8vZHtdXSob5v3qCYF8J5bJK7rG7U8wikQGxa?=
 =?us-ascii?Q?s3C2YPizLRFr9TI2aS0dseNZW44IvDjMv+KMWTrTHhvMRqAINZRwdXO59ID9?=
 =?us-ascii?Q?QYSRD012sSFLOrfHnQCyrrdXMOOjcRPugq+g+OfB7TKP8RjlogImLtKJtaf4?=
 =?us-ascii?Q?ISo7WWL75lVnHV72x/9BzK2KB4UZlbqm/YKZT1G0jP8Hy/bmVKB6YXP8mBQb?=
 =?us-ascii?Q?CPVNyMt5KF3yXFyaZcSbWKHHRfhVx5AVltUnFkatvvd8n6MGKz4XO0/IF4/N?=
 =?us-ascii?Q?BmaD5JsWG8j+aE8vcu844XdDc6IMKPZOO393ZzdowqIQ0ACx270ZCEGskgyF?=
 =?us-ascii?Q?GAPVuECydGxp1ifxs3BNsHcARD3YHK0hGabWgFiCQgSsEYRqRLQ2VqXBKYFx?=
 =?us-ascii?Q?Ar4NskQk20jNB+Oxmc1BPDL8yj8idFsWDIVc30TKdOhiVdLqwY6bYIh4icNa?=
 =?us-ascii?Q?MGFsYJ+01GR0keSk2VETjgyp0iUDba4CB7HUtcQTLEw3gOcVKqa5+U+Ap1fA?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7900b4a1-a72d-4730-e9ef-08dd72c041c7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 15:00:22.2717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dyhbf/8q8DUyjHZZHK//EO6ZZ4Uhv3eGxyFk+M4vXHQsuEg+nPcTpBsRbuVR0kWadamJuotPN4Upu3viAOp7oTiE76D75A37KfvL8ekU6lM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7712

This reverts the change baudrate logic in nxp_shutdown.

Earlier, when the driver was removed, it restored the controller
baudrate to fw_init_baudrate, so that on re-loading the driver, things
work fine.

However, if the driver was removed while hci0 interface is down, the
change baudrate vendor command could not be sent by the driver. When the
driver was re-loaded, host and controller baudrate would be mismatched
and hci initialization would fail. The only way to recover would be to
reboot the system.

This issue was fixed by moving the restore baudrate logic from
nxp_serdev_remove() to nxp_shutdown().

This fix however caused another issue with the command "hciconfig hci0
reset", which makes hci0 DOWN and UP immediately.

Running "bluetoothctl power off" and "bluetoothctl power on" in a tight
loop works fine.

To maintain support for "hciconfig reset" command, the above mentioned fix
is reverted.

Fixes: 6fca6781d19d ("Bluetooth: btnxpuart: Move vendor specific initialization to .post_init")
Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 96dd098cee98..604ab2bba231 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1447,9 +1447,6 @@ static int nxp_shutdown(struct hci_dev *hdev)
 		/* HCI_NXP_IND_RESET command may not returns any response */
 		if (!IS_ERR(skb))
 			kfree_skb(skb);
-	} else if (nxpdev->current_baudrate != nxpdev->fw_init_baudrate) {
-		nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
-		nxp_set_baudrate_cmd(hdev, NULL);
 	}
 
 	return 0;
@@ -1801,13 +1798,15 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
 		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
 		wake_up_interruptible(&nxpdev->check_boot_sign_wait_q);
 		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
-	}
-
-	if (test_bit(HCI_RUNNING, &hdev->flags)) {
-		/* Ensure shutdown callback is executed before unregistering, so
-		 * that baudrate is reset to initial value.
+	} else {
+		/* Restore FW baudrate to fw_init_baudrate if changed.
+		 * This will ensure FW baudrate is in sync with
+		 * driver baudrate in case this driver is re-inserted.
 		 */
-		nxp_shutdown(hdev);
+		if (nxpdev->current_baudrate != nxpdev->fw_init_baudrate) {
+			nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
+			nxp_set_baudrate_cmd(hdev, NULL);
+		}
 	}
 
 	ps_cleanup(nxpdev);
-- 
2.25.1

