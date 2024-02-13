Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2068.outbound.protection.outlook.com [40.107.6.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629295F560
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839896; cv=fail; b=BcKTpKa+WoA/YwwUZSHHyelp2ZZU7d2DzeEwU3lO/kp1nwVf5i2YPmagd7DAwYkrQOs11TUwK9cj7tHQPOG9NlZ9Trf+z2FMC7faM9opaeBdeU5hRpooDokPXeeX9K+eVkQrKF8HOpRVW6hvXtqxBljZsdl80lopoOfr0LYFVPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839896; c=relaxed/simple;
	bh=OzNIyeZ7qrgvRUM4X7vQC+CFT08cqR3phBT86N0k7qI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=egVSEcntbDemO3pwruazyizvDvX5GWbF3SY8zZJz9cDyoSWekSjX4/NpzKjgvj1UTfKkydDaxmaQBVAvnExi3VVAeptVjnmUeauThYMyNPphG0j8FIZz+RLkptSiURXSIe/gIynSkZoPEPMnVSP4vVFSXMbK6GpPb/sPh8idw8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pjQ+ALBP; arc=fail smtp.client-ip=40.107.6.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pjQ+ALBP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Of+d1Km+UDnqIaqPs9mpsTQWbGsVhzoZwJwMhkOcXrrY3Sy8MeVK4rK5cuY5CXdCOLWK5DWbNFosR7NLcVE31BS0quERCABD1oDx04zy1c2myZgaroM0aXf+psjKAxYsn4wIFO1jRxjPj+cuMvBXFqxUdLmqhwP5S/hX10QO8FHCREDEwSr2L+vK6uF+qPVxcrGtL5PxlxnOe/jdy96hyUkDUL/GZiozs3l/MrVLoR6TFAqNa7vVDyMFWrqwW5/IFhdJhuvR/GyOKjzqPiIkJIzjV5AyBd2A6v39AeOuN+AEkTyrZrjfNC1CU/Y/uKqr64WOrDiiDpn8kmcUF36r9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQ7TC9boGx24zb7PdLDJVssTiuG6o7nOc5Fax6UI4MA=;
 b=HoFClD1d74ZE/sjOGvHiya6tKVg1x0Z82CNU2tzDKJ72J5hEroKPxVKf1XT9/XnqZKlze1WHcRs/iA7tusIUl1aebTOiFf1c8mFP6XXj/Qsy8VVi5LZ4ECRIQQ61tMvjsfi33odWh34hSDNEF9um/CTAHhCsXJDh4t8vIZzQpgDHOs44s+/UiGiYB6k1C0aju5X27sHc+AuQjbWcApV3YqC6/McDrTTJRr1qOJTXIbGIcGztaZ/ThlaUDzXEP+5mR3Esyf3ARP+qi+m69FkbVa7uvykGIh480EzgLxqGdS/ilKIOMtiodkxtHjlCvj7YsUcA56n4U6ZjEvxhg8NNVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQ7TC9boGx24zb7PdLDJVssTiuG6o7nOc5Fax6UI4MA=;
 b=pjQ+ALBPlqXLM0EiilOCtI0mUMqUaM/3fiDxWPuAyoJly//yZiBfc4+k8qK8sECxPcJWcSRwwZLbrPO1DACUTbWv8WtUjOXcjgYxQiroNFlVM26IOCwHkjYYJ+6/ydhmq1PnkQaIWT3fQbW50yC/YyS8mIO+Q7Wqr/utgKQmLJ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8149.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 15:58:13 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7249.041; Tue, 13 Feb 2024
 15:58:13 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] btdev: Fix set PA data array overflow
Date: Tue, 13 Feb 2024 17:58:03 +0200
Message-Id: <20240213155803.3159-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240213155803.3159-1-iulia.tanasescu@nxp.com>
References: <20240213155803.3159-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0264.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::31) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: 69308995-230b-4a80-2497-08dc2cac9539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	66+vtbyXG+5V87IwW1bT7oOfcVtNLzIrDT6TlVB9ZFfu5TXyVoU8+WcGLDv/3TSq4JvGFPJ/fCslJd5yjXpywhKqhGNQtfB70JfJ/yXRS6H4LKmpWrJTAbtIXLxz5KPYWHKCevdtZPDXXVYK+4zF3+RL1U2ipr+qqxnWgH1JUkxQCkmgoH67wW9SHu33d0ZRGtmaZqat38+xFeXo9ZHC902fgF2yj+FKaJRvKMC6Uza4FkwHYSie2Zk7jzVsnX3j6LFqhJtQ6zPMG8/xQDexYjf+Gob+f78ruENLN1mIaBV+TbIfWVdAQJgwG5GkqaO5ZFwYpElzSnaoOlWaew/HXHC4bfAtQT/+nCWRwgzb2r7QKpjzqUzl1yNzV97V4dzgzjp2/WOEuuAcAnsDbN1DaCGpSf830fmxjsg/BY8p36rWySQs00m1gH66rABKQCztxThDIlUNGHUNQXsjjWd/Bekk7xSb0iV9Q8l4ofQ/k35Ss8GKjfSQ7X0aIYDmsAm4D94S90rOYZwxZeB4fM9rBXB0UBgzco1SMv37niCs70YI4YX3kMqiwm4apwem5Vip
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(316002)(4326008)(8936002)(66476007)(8676002)(6486002)(6506007)(6512007)(66556008)(66946007)(6916009)(2616005)(38100700002)(26005)(1076003)(86362001)(41300700001)(83380400001)(478600001)(36756003)(6666004)(2906002)(44832011)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?24iPxInk3Oep8ICMdpSW4U00q057m+v7zGx972H237IIiCI6yqfKC7QzMp9x?=
 =?us-ascii?Q?PV3nQsKEf47zH0XHSHhY7cdoubuoca+/AotREk8ZweB6DxQ0XfDOH0MZ0zk9?=
 =?us-ascii?Q?hGO1mp3o+6mwAd/TUMoOSZHfoMfN74oxbWlcx6XEhzaplHL6TGlXPW+YFeAX?=
 =?us-ascii?Q?CbktnMtRCoWgUbcg7UvZy+Y0AtFkPRInEFz8U/RuDUJqEzUj7iQDi2XTavwX?=
 =?us-ascii?Q?qZSHxhprNJkwLVKfZAWf+TRedPmQHkmhgnoATmtpq4gK0dCtrhEdwtuGJkSm?=
 =?us-ascii?Q?sSqh7aX/SciiXQ724+DsU3+9AkNS5q0jqLNr6pUE2OYl4dilWOAGE9MzIIZH?=
 =?us-ascii?Q?owdbVAQiKj4jjvThIT/yMOzjr1iqRSjXhnKAErpQcefTNj+DPbNDgXj/jHhP?=
 =?us-ascii?Q?crsYmHzzVk7zQW2uMywVk44UsuxGXBQ22bLcMUJ8VUZqSIpN921qZvT1G8wa?=
 =?us-ascii?Q?UbB6xZLz614IMbiCAU9Gvht4XGCtVKoOEtk/E8oaPhSu3Rb17VoZ9yoNmu1O?=
 =?us-ascii?Q?SRV2W80MMsYEOpoSC7Cy5/r/57quFpEmVC3l1ljWTphSxk760QahdokBRf+j?=
 =?us-ascii?Q?McR+VmM8p4+sYocjNymis8maCY2xcIG7ZjTM48VQfe791WVZdKtjo/2ur7PC?=
 =?us-ascii?Q?Yr0/L0BWyrhN8FOsn6/2TtE6ww3Bc+e0LBcnK264+6kxjy4+PxinjJQrL2qJ?=
 =?us-ascii?Q?TQLqfmejTZTt0p291Q2Pfv+QNwUw8Qs+xVs4D4Xg2rThiOisBrLTbshblsN8?=
 =?us-ascii?Q?UJTT0jnXbViN1/lQm2MLLZdkq/1fGraqkj/RTphZxXGcGCi5jo1jP0hewtom?=
 =?us-ascii?Q?tCeH5K7TIe46d2Czed+SOXS7lqPMr2AXc3ArmVQZEkLnoQcPA28UHW5G/8Wf?=
 =?us-ascii?Q?7P8h64TV8U7MCZ7OXJAWkkTUlfFCN/gxRIyFDvIPDc4q5Wqm2/ciDXVlbG+3?=
 =?us-ascii?Q?fkpXjJrWo7tMI7DsfmbxczFvqGR3VBIwJE1t5dArGlvuLh/Qp1t+fYJWDhYH?=
 =?us-ascii?Q?ICDGxCDkTDTWeeR8/gLKLblY2w4fjFQTy7FPDOaIZZM9vedWGkfgJIxtCTKa?=
 =?us-ascii?Q?4ZGd032s8Wx65W9ey4/aB3fcqhkBjRR+9HAec+1ROF1lat+VTafMTeJayiIZ?=
 =?us-ascii?Q?uhWtsvZ9FcN3YkQ7m2dkH6bKdA+X91XKwJIdHz54LcVi1+TeDQu/wqIeWP1K?=
 =?us-ascii?Q?BAyQhHqIxJlUzLVh/m3R6HAsyJeNDrbe8lxjFM83wXh1145tLgvcDxW0oW81?=
 =?us-ascii?Q?XUqKEHK421m0CGzdbXZugtselQeO6dFZ0kiIEU0t7bDcxqbYyXLyeWjf0J5F?=
 =?us-ascii?Q?KBrLqK2jviNLzk8BPRfkJ8wuBF6nO0F9vCeV+S8rTgM3zvtxRmIx3cChPBR9?=
 =?us-ascii?Q?Kf30FuHKqs+hoOYSo0MY2RdnEtzwzBpD0ji4Guogx86cCLn5ciN8HnIVWuyc?=
 =?us-ascii?Q?+Gv+ot5zzQH8xrj8b402VDLvwv8A+bgf70yRnBikuLX1UmVmwdAK56v+FfcV?=
 =?us-ascii?Q?JCjN0ByoLCSANVMTpUriRZdy+PMI7aGYFpvXrnxngbL3Eyal0tAn29xsmmne?=
 =?us-ascii?Q?o/MgKaun4COvLTDvK5pCwzBz2F7QBASTcYXWjHfEQrEr+g/dN8N3SxNjqPnA?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69308995-230b-4a80-2497-08dc2cac9539
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 15:58:13.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHaZ/vYFaYhJF+R0gHxxQOSRo85CyYbljRLCd0lQBmN+/8upvhlpxFzekuh9iEjdXJpZh1efBV+nk9usWm6iwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8149

This fixes an array overflow that can happen if the user issues the
LE Set Periodic Advertising Data command with data length exceeding
31 bytes.

The PA data set by the user is copied in an array of fixed length
(31 bytes). However, the data length might exceed 31 bytes. This will
cause an array overflow when the PA data is later processed (for
instance, when sending PA reports).

According to specification, the data length provided at LE Set Periodic
Advertising Data command can be maximum 252 bytes. The stored data len
should also be true to the length copied in the array.
---
 emulator/btdev.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 4ddbae403..4c9f5d181 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2011-2012  Intel Corporation
  *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  *
  */
@@ -44,6 +44,8 @@
 #define BIS_SIZE		3
 #define CIG_SIZE		3
 
+#define MAX_PA_DATA_LEN	252
+
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
 #define has_le(btdev)		(!!((btdev)->features[4] & 0x40))
 
@@ -207,7 +209,7 @@ struct btdev {
 	uint16_t le_pa_min_interval;
 	uint16_t le_pa_max_interval;
 	uint8_t  le_pa_data_len;
-	uint8_t  le_pa_data[31];
+	uint8_t  le_pa_data[MAX_PA_DATA_LEN];
 	struct bt_hci_cmd_le_pa_create_sync pa_sync_cmd;
 	uint16_t le_pa_sync_handle;
 	uint8_t  big_handle;
@@ -5210,9 +5212,13 @@ static int cmd_set_pa_data(struct btdev *dev, const void *data,
 {
 	const struct bt_hci_cmd_le_set_pa_data *cmd = data;
 	uint8_t status = BT_HCI_ERR_SUCCESS;
+	uint8_t data_len = cmd->data_len;
+
+	if (data_len > MAX_PA_DATA_LEN)
+		data_len = MAX_PA_DATA_LEN;
 
-	dev->le_pa_data_len = cmd->data_len;
-	memcpy(dev->le_pa_data, cmd->data, 31);
+	dev->le_pa_data_len = data_len;
+	memcpy(dev->le_pa_data, cmd->data, data_len);
 	cmd_complete(dev, BT_HCI_CMD_LE_SET_PA_DATA, &status,
 							sizeof(status));
 
-- 
2.39.2

