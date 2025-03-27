Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A383215F56;
	Thu, 27 Mar 2025 18:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743099816; cv=fail; b=sNTAyWV1FDlzHfm/sfCgsp59hGhfEbCNB0Ke2inMmyReu5Jv/ImPqk5uslVAa5BZxlizQjm+1d6/GsLVP58KrEynVsfXKWirztV+I/L0nD/nzdusrrX6TrodE+E673hDhhCJ7e4itg2VegMV2yAxmNYPhfXgOxHsL9auzx/ZtCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743099816; c=relaxed/simple;
	bh=zT8d1FyoX1vmJnm2bVWAyFMtN+Pi2MTWbpqK7HDN43Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=c2I4rmXD81EUH9L0ApOqtqLbhwr4XU5zsQo00+0wtIXSx7eyjjqKk9iG1gBXWirkKljyBKBPcsJ3anVAl6pzKXVu+hCY655SBMiODHMrqGU+9III45Y1aBunt9/G4xvwOvqp/ZaQZAVE7w10ALjB1qbh0zJstIgeBgL8KQHka/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OuZtzbtB; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OuZtzbtB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGbr5reKxP4qjeQtHmanV0bcWqkDwuD1sKcst8F3RS7EZAEy6yaV8CRJQ6VT94V13NfRGp5Uqmvbn5xnWU2UVW4ip5G2VBfu9O4gm89CzDwB2iMq1Ffaude8jcs5ZwarrKGY3vrLzlu1zKj91NIglqwwZtU2HkkEAK/nfVff7FUNCnVhVAgfStkgxfOsC7+8fXww/HSEaHnbKXXLeR3lpShpR8iz60au020W1lb0IkoEUHQICG8VDpZjGkG1ZyWPauV4hc0JmA6oiYhMlzd1q60odvcvYXJTsV6G7Wd9hutRxiqKHMQNIJW0jLLT/mzbfeBoUxiEoUAS2o30VrvzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfAgDdDgQ92Vfc42diWxZchJVWDcSETjOVXCrOVurMY=;
 b=wPkBQGotoDWYFZY7n6ltOJqDmNAGM4XHjwoXwPzL27YWjfF/TfKKRg3Rg3gIKu49KK1563f5eF0irkdnVeKwAT98sEespHdri/ETubI0GGjrFpk9IMWd96vvU2mdb1H+3B2O6hzNAd+SXtjdKKJ+TrxtK9OFpCqgOJ8213O7UzHCQp6p5kDWuxQvnHLsLuelDNdHvv1QenLeiWhJZircSWmxwFgdCMBxa52LUSN7KKFW05gUIwB4E8AuXHoh7+b2quqe6QRIhmye5T7v/BXJvoFO6z5TnMmCe+p5Q+g4DPFBSMOze0guRowsjcomvsaFN0WSKysOy4fJf5g6YLOnbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfAgDdDgQ92Vfc42diWxZchJVWDcSETjOVXCrOVurMY=;
 b=OuZtzbtBGKB0bGDpgtdPtvCdOW4b5mIxgyNX/m8Pag56/AiuNGbFE5jNxOhz2anfysl2LZXOmnRcK8Uplw60I04alXZZ8yHo7x7AShHiUVMxv3cd6db58/A+pBHAn47ZH71kNKpphTnzV/3OcP/IacQ16xhqtw0QyPrUVuYcss4NNPJzSXIh79PhH6N/iBuWxN1AQ70kxw82N95JcK9u2wXv1s4O7SSetoK3Yy55m0iQ2Tev1vhPufWN+KIe6pDslU2E+S/IZcSDI9KnZ4nZf5PA1yY34zxd8R6dUbnDW0jJGdiudTEU8SrE2K7dIgE9c6GsthgwA6Smf9iP/p+gvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by DB8PR04MB7131.eurprd04.prod.outlook.com (2603:10a6:10:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 18:23:30 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 18:23:30 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com,
	neeraj.sanjaykale@nxp.com,
	sherry.sun@nxp.com
Subject: [PATCH v1 1/2] Bluetooth: btnxpuart: Add msleep() after changing the baudrate
Date: Thu, 27 Mar 2025 23:55:22 +0530
Message-Id: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To AS4PR04MB9692.eurprd04.prod.outlook.com
 (2603:10a6:20b:4fe::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9692:EE_|DB8PR04MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c6d0c1-26b5-4bb2-ed98-08dd6d5c79b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1AwFdcYwJQgdlaGZi24qAH67jqgNyHM2+0xJ0KZhsZuE448A7cWYYFp5EDmc?=
 =?us-ascii?Q?Nupil2NuBW2pAgIPSNk+BL4J0A9jTAJyUF3UCHbXrxU6usk2H+fNqUadgc98?=
 =?us-ascii?Q?X5NzfUyvGHHDLtpvpZrlNJGyGKzrK0FKrezGroUOrCKWoaXQnDJ0YzBJXliU?=
 =?us-ascii?Q?2i2vU3zlgS88DAKckKzLNBkYTGhMB+y2Q8F4qZ0DZCDPTCMOypiaKBNna8e/?=
 =?us-ascii?Q?AtK7ZoHXq+1bbtU6IieuPruTJXxeM4LLEhMk2KJGLtX0tH6g+3Hmxzie+mbs?=
 =?us-ascii?Q?G9jyHBpSU6ftiM8Qi8fHkhVaXpJ8Zu2PS0sZRUYGWfTV93dpUzDX6dwaasXU?=
 =?us-ascii?Q?srfw1mnHVTLouClya2fZg1v7F3e5BVbigLKltWSK8fxFl+B/daxl0n6mjpw9?=
 =?us-ascii?Q?gxMzhiftCb2Ff9wD/V/JOBdhSRijxOXhNU79VmKe6+8e1jquFPEp6c6KY4ew?=
 =?us-ascii?Q?aLOPOenZF9mIZKTd7UuaO/1jp73Ky8p8Bemuo/tHJtPrAEnnpmDqd9wV89uM?=
 =?us-ascii?Q?PUKLsT/2Hn3Fh4OAuhcfCBpqNvo2PvLxMaMn2F83yy107LGrLPGQoY6Ln0ts?=
 =?us-ascii?Q?jerm715JSc8OY/PfAYpzE8gUy8qNjeqK1EX1pkFsuaOc+O5laPlSZBEt6EY2?=
 =?us-ascii?Q?7mOEwk0AtF57GjqPLepnZA4ko2HArHtZz6SEIbbiKJSDzqP35cvVGv5s5Iwh?=
 =?us-ascii?Q?lOaB/4q+SXIkKG+L+lRRNKTsXNFfuwodINZkCRK7zIocw9XObamSoAvkS6qp?=
 =?us-ascii?Q?dF64iM6j/sNO/unBrWgfSFXmi0IbwjxuTbtqz0AcD9Yy5kxsv6dNCo6KMplc?=
 =?us-ascii?Q?m7ZIkhRd30LaLUQcZq/6SQrjnxR/9rEBPeoYexABYMZQbYru4m0G1gWW29V8?=
 =?us-ascii?Q?crwcCfKHZ8UthYaeK/+3QEBbTTTSZc+q58EMyn9Gts4iufEtGZN4EqrKgC4O?=
 =?us-ascii?Q?43IqMo7g3taQFfbUa8B8KGwIkHaWzzs6zeb65tzZVoPk/cqIyd8ybtCzkcqj?=
 =?us-ascii?Q?j3PLKJUM1wNHm+JRjISoV0S6W7EfFtNMFDu8DTJYsjRv/4O23iLNfIUYVgyp?=
 =?us-ascii?Q?rRVFMj0ImaWOG1cYUXTVkGOxF3njtXgLqzODj4lOoqR16pccu3NZYGjHH7bp?=
 =?us-ascii?Q?AmHVOyYwaPt9y/YzYAystSCrV3mmfr1bOs8dBSwnYjt8aDoKMzHaWoVC+ALj?=
 =?us-ascii?Q?CqnW4Po040o9NoOLFwSQTpozX1l5yPmIea0I1F/EpN8E/HTsUMUhI3eu221o?=
 =?us-ascii?Q?26c6w33moNwq1ua5uNDkRmztUviaJB8XHgqmB+oscBHtBIQ/nPbeBX1CJj5U?=
 =?us-ascii?Q?t12csIaT+O/uCTW+2ZoyD9hq27ifdQ39oJKU1ye5QIx/RD5qStVRFnVD4rOn?=
 =?us-ascii?Q?o2ZFcdLj4fFxls/IQq3iLeQ1hukasjjBIJ+4xQGOaH+XT/c+ukisxF9Oah1B?=
 =?us-ascii?Q?Tp5PZWz50qz4iZztsgFm2V2rPZLrqZQyQjo017V/s7hMQ0yP0yP/WlaJnII3?=
 =?us-ascii?Q?eUq/ZHIH1ST02cU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oCYM4RQM++tAfi/htUBOjVakEiJFo1KjKBIPcENbT99pgMSTE4nlHwfV/YN7?=
 =?us-ascii?Q?F1tqB3s6UNp09QOx1AE9m/dG12GLa2vbhl86LaQwqK17E11gCEHnXMQL4xWh?=
 =?us-ascii?Q?L89rV3IwEKxNaNCmYKp95YvP4svk/Mz1ZwfP1Lr2JjrLulP/zCuMJmWMrUpG?=
 =?us-ascii?Q?vFBy3fu19dVkCbzu1gXXxsKWJm2iJR1oXXqsbMCfc2V8LDrSG7sJKXpdZwr1?=
 =?us-ascii?Q?Tp0whk4UL4en8AQK97HZ4ezJCLslukBAVRQMy7lM5U+Bydsry7qBtavhLWkl?=
 =?us-ascii?Q?XSMRrTvIvqA75p8/xE5X1TO4qR1QQA19P/At+ItebUcq0ZpgUjjnyqeHiPN2?=
 =?us-ascii?Q?RM28di2AtMyJm8QkrU44pPu79i8XW+cSAPY90zrebb7LOzvC+0bnYXnq1q/D?=
 =?us-ascii?Q?DG4L0gvOvGjQOv6I5g580Ot+zndO5amd0YWXgl7T+SVCvcOr6nHyhbLz1GpR?=
 =?us-ascii?Q?r+GVTy8H7CObXLNa2yijAJoY+kkZhwD20HjTRxwywen+fIFe6i+u8/EOMXKh?=
 =?us-ascii?Q?FGQzgBtq1d4nYmgXWF/aJIQtylY3wlK9CwYa/xHqdillyUwEb7ikQHV1X7xT?=
 =?us-ascii?Q?M0o62uP/u/z0Rqbg/MZC4SqNDCdnwLLF/c9mh9/yVo4/gtUL04hXuRWvr5Ae?=
 =?us-ascii?Q?+FDiL/veC2PNfSJLW9KmQYQmINjwLiaw/dCs7KMAEG0jdyph4d89xbbzlKRN?=
 =?us-ascii?Q?VPKX1C3/OFD2gxUqwHS4DetpSip79UugZu941A5tE54Q9vI+k+PoBfgQw9Xw?=
 =?us-ascii?Q?O/imtQnAzpABiIsXZvLJySvSyKx2km8Q5cgpcNhkcm56Oow4FOGBqyVmnWso?=
 =?us-ascii?Q?ApMobUgl0Pjm7Dt8oc1kg6n2pXaiBfu+V03ts4vT7xlFXr0sAvnLriL4+U3B?=
 =?us-ascii?Q?b/8Gh5LvmslLBSieNrt5LF4oCZa/k2WnwlJXEBwSlGEbOPmqOvqpz8kd+j6q?=
 =?us-ascii?Q?LRw2MCPGfMpXFA9xUxt36uPva2nUpRbXuefAzcLI5HBjzbtUyygufvuQTeYu?=
 =?us-ascii?Q?mlVlxJJGG/WFKsGHhhRXQ2ie5PkS5w/ySshoM0E/jMCCDzDCXjE9blAseorB?=
 =?us-ascii?Q?0FG58ACcukuswy379TE2s3XMvIjfzGwZHxcOkvcrZCom23sYe2XYocOW6J2E?=
 =?us-ascii?Q?/3GYbjK9tmo/l2rVHi2asXELYWzY1CWZBs7OMSwVd5N758FsWf1kjClrBPNk?=
 =?us-ascii?Q?bLmL+R8ZrtnoPo8BzFGF6otyRbm6k4D1yMorUEEQwWRQHm96MCs15GdGqZov?=
 =?us-ascii?Q?Js/jV/Pl45fLmau5O+pvKkmnx9nHFVEswXL9+7l/WXaOh88gqx4GmRAgFh31?=
 =?us-ascii?Q?KPE4m8+HF1xYBiyNwo7T5K9+ojdyBnywErpNJba4J1CLW+rMySujW9EDqL3q?=
 =?us-ascii?Q?gLbh97iTpNpB7M3RjH7dj0oVDscSB7fXxhz/6y1+pu2Hc1SoV5C9jWSyyNc3?=
 =?us-ascii?Q?yhRk2j7qnCmrlGYxIvhxBco9dmehzddOzJgT7D/DgWLFniLTrlWQoSKvQweG?=
 =?us-ascii?Q?bCvx9ikZFk4Epg1cYicir2BJ5CqU3DYgkm/q1EjNSD2teinWZEy1sA+hviZ1?=
 =?us-ascii?Q?yzXRR/gHWzeG3VEwFyYSoIDDO2EUwRb8ZPKfWj3J0Y/6rBBRX1ugR9lvIBn/?=
 =?us-ascii?Q?sA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c6d0c1-26b5-4bb2-ed98-08dd6d5c79b0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 18:23:30.6154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Cy7EhfAso3iQI2k9DUJMHz4F0L54+5ovwi/9q4qM1mvew3SL/GD4MuuOBPZ4V6OX61/WPYp8WEfP0ZMcF04a6FWOoORu75OPPKLWcQ0i58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7131

This adds a 100 millisec sleep after change baudrate vendor command.

It is observed that when the baudrate change command changes the
baudrate from 3000000 to 115200, any immediate HCI command returns an
error -22 (Device Busy).

Adding a small delay after the change baudrate command complete event is
received helps fix the issue.

Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
---
 drivers/bluetooth/btnxpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
index 5091dea762a0..e26fabe8fb3d 100644
--- a/drivers/bluetooth/btnxpuart.c
+++ b/drivers/bluetooth/btnxpuart.c
@@ -1238,6 +1238,8 @@ static int nxp_set_baudrate_cmd(struct hci_dev *hdev, void *data)
 		if (*status == 0) {
 			serdev_device_set_baudrate(nxpdev->serdev, nxpdev->new_baudrate);
 			nxpdev->current_baudrate = nxpdev->new_baudrate;
+			/* Allow sufficiant time for chip to switch to new baudrate */
+			sleep(100);
 		}
 		bt_dev_dbg(hdev, "Set baudrate response: status=%d, baudrate=%d",
 			   *status, nxpdev->new_baudrate);
-- 
2.25.1

