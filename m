Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013045.outbound.protection.outlook.com [52.101.67.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3C1B1D4E
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252203; cv=fail; b=o8mDgUwYiRnRmBY9m4FIj99kE7XXaVwJ3dZevMurlwng+ritpBtCTeQ2rk3HCmSiEJa6Vg2tVYTQ1vVEkH0kUT6mbwHLmSvX+YVyjm2/wb8/EQWnm7jzM3fxo5EE/FN6kqNUJSrnleICn0tNSWtpWL4KZRABifoFe5tG9ChzE4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252203; c=relaxed/simple;
	bh=Xj0iuXMp4wmKPn2xSlhixHToEFcoUPboiEoVbnGWTnk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZPY1AN13uvR89/Emmb6wbTVKWY3t7v/WM3pP46be3PV9xSQrDHkJLaOLiR15HFmGL+HaZxpOOm41PighLSKYHGYsY58JERJ+ZKG35eb1bjdKayaJOTAv3910Izw8Y3YAZHu0piJSQmjxbtJi1EdNyFtNndeLQuY64iFZxw27zbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PplJo1o3; arc=fail smtp.client-ip=52.101.67.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PplJo1o3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJMF1rhf7ejAEm3gNNGH31DesdmSZPG2eGzCW/y0q0B1HToopDZ8KB/OXpJ/nDsgR8a0OmdYTGdPE9nNjaJrK73sETlbqp0Nusb9uQdfkIvRzdExxLu+0lg9dGm6mGqClpTpVpDrAb8KgiAvWQcJFUppT7tQTYn65G8Xh4yZiVuIb+uV1eq76Ulz9dCUeOIc2GTIs3Usl53F19oU0TNjQqlLyoWeb0JJYcUbEOOA8k5NB+VTGvJVZ6vUUM2pyuk7wNtdkk7slSxjqBncTEnWHDC5EP/mOzmW8P4NVa+ReaLRsdIbWDgv4i8NVeTSS1kU2RcHXjCr81fEG1Kr2GZKmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTUifbOiXRLSvfccmIcxkAcS1tj32YAhduDe53d0QDA=;
 b=W5crR2O9iDw3gltDTlCm16x9Uo+DyovLl/uEnDiQjl7oGjZ5keKjTywqK/iZeLHETM0xxvezmg2ktnES7QsKRTcWWbMeLLOFyGMzWJh/QTZK/2vn7WSoHJxd/ZOm8Xs1ZM05EwWCzXYSi6aO34MOAJL2aZcKyFM+KMufTeVoWSc4l2QgKgI8jGGUCAA4gwKDcnLK6Q3YRkjww9zlrxgTYiuN6DoILXc27B6hNkEXI+DEqtZ7SdtTx8K/oKWXxlWSmqKElbABcSOwQPsgY1FFiLNJvmOdlRuGA8EwE5MKkQinMsqJH6O0m/vCbTGJii5db/pFKso5BvySexYbxRAR5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTUifbOiXRLSvfccmIcxkAcS1tj32YAhduDe53d0QDA=;
 b=PplJo1o3w7EFu6/YA+sTEIm6FGlQnjOKzrC05qBlny4cXGBbE1nBiRG5pAd5hTpk4fsPrLxIuvrXzKH7EQ9ua02K4UEQOF2Rtok+4ED/n3YzGWNwJC1ub3cKjEulen9MsN1cUZec4ABaEHgOtxqqiPd4DK/Z+w8i2EP2pOxELAQo0b5sjOnDt7mKMAk9apLQNrRu1icn7Bz+CK4vyZlJnxYPXB49Byb87RYjdmwNVXhx2UKLunG4nC9QbD2jrg8YowRAJwz+dO2Dmg0kNjGmq8mf48RXRpogf75BEA27fTkeNZMYsj0g/i/mj/e83iGaSW5CIcMxYE7G3T6ZoKX/FA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 14:56:39 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:39 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 10/14] shared/bass: Add APIs to set/clear BIS sync bits
Date: Wed, 21 Aug 2024 17:55:58 +0300
Message-Id: <20240821145602.92083-11-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P250CA0006.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:21c::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a1b1cf3-9aa9-4e9c-f9f8-08dcc1f17624
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pI+qsal6ifBfaWlV+9jxQaG/zgpONePGlFNjpqMGDGR2vq62llKTYq38P8g6?=
 =?us-ascii?Q?CyT7Cm18ST1+kxSpztOkB3282nOIhyMTFQniCcmfYu0WLsQ6LZPp+vJQJiI0?=
 =?us-ascii?Q?F4bBCTMngoApxEp59fGjrANO1stst9GR8/RE/iFAoXud/TybnFsC54gSSxHZ?=
 =?us-ascii?Q?hv27BaoiAMZC8zwhcpPcr2+mXLzL1AOSzKrH9gRwlTNmbVa/74hnIhjAN948?=
 =?us-ascii?Q?is3MtIaqCLdVyyYMA/Zw3pjS3nC8lSGivqbdSfH6nPACyJVtS4lATXvbXLPe?=
 =?us-ascii?Q?HqOWiLhXfKAwi07C2pBVUhqG/G+9HlvtSGx+dTih2Ax4paJ4jsEqSCGULZFp?=
 =?us-ascii?Q?tE5rR9v7wcA11CE52DHilpon7QvKgWvyQFVtjFd0V71krtHAXiVXWjit/N4N?=
 =?us-ascii?Q?mdry9sspaxt/M3XPZbFvwUZvOdzZp3YGZq91RLYewNfQdOvEAPmmk70syLjP?=
 =?us-ascii?Q?UIsNWHIMgZjIyafZliDt3m7U5oQ2zirN0BO0nAxy6mexfZFqzTcusF7/oxEl?=
 =?us-ascii?Q?5lWi8tNZLpyPBnEtz+BXaeFZsE6X7uci/fG72AGnKms4so2iS/5aRmZuBymA?=
 =?us-ascii?Q?7NVSHcTZUqZubBr66D6QRIw5T2Nuyz56Zjfy+EwpvRA4ES/NBbCww0TRm2u8?=
 =?us-ascii?Q?83I75UfFRIZGw796uqtuXz+4KPnMkkAMMuJ5aRq6dt3NusLL6xsx19DkOlll?=
 =?us-ascii?Q?O76MpKXGG6xaXqBY+MnB0mhxSP4YnU5+gzpQBs67bzDEc5xra1Do9st3UcKV?=
 =?us-ascii?Q?SS36kB6qzj1LlLGn8bAf0Q7CVGDCA/xH78WFx3JNjijLoPd7k6vXQdwUxfq3?=
 =?us-ascii?Q?zQkaTZSo2D8LvECmk7o0Jp8qUPm+idPmzi3Z9MLkhbnEKAEDNCmQ5rmYn8wb?=
 =?us-ascii?Q?beMuyUQetw/nwunuju7JqqmV4xiwwAwVJNAiCMvrBpQnh+NlR3qb9gsB5xtY?=
 =?us-ascii?Q?+Lxfcuoyuv9lAZPfFfMTn+kz1ESDthhrGRzR4Y2HtX5MMXKLZoNzO5/zbbua?=
 =?us-ascii?Q?GbL8HSq3h0GlxRpXOoDl+dIuYx8X5e8gqHFYTSMDPkxRu1+2HhOuAFvStXys?=
 =?us-ascii?Q?Rt33PSFOK2n4+5oa7kbpjgI/W2hBVfNnuNV4IzdWT/K9v0xk6Thmoi0qyY6O?=
 =?us-ascii?Q?z1jJD1W7iaho5JhhMSrpcvTQp8iuAU3YCTdNac7xHWBhZssvUqFqBfnh7uEk?=
 =?us-ascii?Q?+9UcrpqnQ9GrtOWip1mpkW3jchGpyz7kPJJ4Lo7UB1i2D+sLk8bIQhjf8/tj?=
 =?us-ascii?Q?PZ43fzSjo7576rpkeErbMCPppFxqg/SDzFVv1sQjrul8+sVVGn7uv8qoYvDk?=
 =?us-ascii?Q?ymKiIH+vTaP/+P1wPZEbSenXDV5b8SI9IDKVsxiJrYOFdQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c7U/TpCsOsQ2sLgJQfn+BuMCGXRGXf5N2pheiuiXcjj3JQkoUtb3AGwrubHD?=
 =?us-ascii?Q?iRZ9ukNyoM76fF06WEkf7uJGxiNGQxlB9a/KzGoQk+zHwrh+cx97XaV/Cajc?=
 =?us-ascii?Q?mdTJjnpb3zm9ZJ7tp9fWtcy12ZY/9gvvkTyMKEL4mAAx8+shd2/LuEOLx0NJ?=
 =?us-ascii?Q?nNp9iaNbUwv1wHIEBwKgTFog7mwQW35bmY0o3nRUz9MWoDRVjGriBzkatnrh?=
 =?us-ascii?Q?4OYFgy4xyvpDbVNZxAGtFgC7zvP848LWZoQioF+AqK7/LtI/lkn41te0hcOc?=
 =?us-ascii?Q?Ujq33l3yf7a4z50pr4cPWhjDhZwhEwKvp6VGKCbLOqVKm8W/YODsUp+JLX62?=
 =?us-ascii?Q?yVzRQG8EOrfdk0/hrOByavS+EAGXul3wQI/n93u9BOLlSx7G9qNBIeW8bMpZ?=
 =?us-ascii?Q?vrusinV2A+fFzNqIHlcKKBraR0H4B3nkoS9y6oC52mAFlmWknRePCphbWW81?=
 =?us-ascii?Q?SBmaTf/G+TlqBKEGAIEpfdmWbZF9RVum+TjYDNVkSh5EQjPu58PTUD8giw9j?=
 =?us-ascii?Q?0W2AFJGPOahMd0x30+GsG8LujYeavpvJIikP3aw3fpXar/7cAl6hPSL/MQFq?=
 =?us-ascii?Q?HGVVaaUq79p1EvVh2z9hd16eKLafftkyunTahjZ3qY/0bGcqHeocPaV5gvXS?=
 =?us-ascii?Q?G/oXLm7TNufkh7jBnuCW4gqErOIz40b2GZTW8HICBsmLyi4OparWLls4ywgx?=
 =?us-ascii?Q?X1AiCxnQTjFOagUxmnKHgpyqJhVlTxfk8sMYRZZ9A+iTbb/y0Es9Y8dTeeoQ?=
 =?us-ascii?Q?V95RnaAAeeeEVHoc8hIdxapyX3O9cqCUzJOnIGTmii71WeejWkjuwA6ZyFRx?=
 =?us-ascii?Q?itRuCBhfXq+f5Az7VZJKjvQYvVVXoBdeJaN+mx/RI6vNKSylRAEjcVrak54F?=
 =?us-ascii?Q?NH7v+GBnMBLNUK8RA9L6iAR8orTxw4Ru2/kgGIktyZGkXZvqWo/ZBXAzh+8O?=
 =?us-ascii?Q?1T4CR2uhq84BsCWu19NXaa9yRqBJ5bD8GYJQcckU2IV0ZPfeva1oJ6Rkj0Gg?=
 =?us-ascii?Q?oERgk+BITTduRColksVC4wcSJS+fSeibbft2I82ZOq1PYWFa3t3TNw5SUFdq?=
 =?us-ascii?Q?obssCZ5gVJO7mc7iL2dhjZfHckE4MMU8pKp2OxJMM4fmx6169t4MCreuLfUL?=
 =?us-ascii?Q?K32CDCrcgl9ZZi3tCwQ7SsvKMb98GXFDKXsyGf8woVFEAkXocb9kpjnA0sl0?=
 =?us-ascii?Q?FNDMQ0Q9ujg/3uhVKle8snivmpuy3hUsictz/BXnMkCXlQTHuspG8iurpfXB?=
 =?us-ascii?Q?RSgspdV5I9hZSdqO7gCnVZq2ozhV2AVeRvkvSsleeHbzajjbnfuFQ2aE2yXL?=
 =?us-ascii?Q?EwXYJuMr3GlIgmm9A+PC0Y/RORaYbO+0afyeSYCwvHYvNWFxUigfw4+KRYPj?=
 =?us-ascii?Q?dze/700QTO3wNWlPxMTdU39PLB5FIg5gc4AqVzQ1Lv2RqmS0OHCAkQ4Oia/6?=
 =?us-ascii?Q?GERYGuV/Ww4xVhUVtLZFrPzAClgtnQeguWvra3++nWJiM+5qqrDVKnbk8vfK?=
 =?us-ascii?Q?6zk4y9MR4oKBrWPQBK9XBS3xIP4MbQwZuMSGs8z/v3AjGag1Cxgi8CpSQi/a?=
 =?us-ascii?Q?UO95GI3UbtQDtvaWAnImasAfoHDVsXEY9m6p7qSymFxLeM6h3SXavXdsjyDj?=
 =?us-ascii?Q?MA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1b1cf3-9aa9-4e9c-f9f8-08dcc1f17624
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:39.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aM6DbV3hZUD6CGAYJ8t1Ur1fzXW4xszDlQbo/WEaYgRW5Snjhixx1D9MVSWdUUpklSlubUXtUaBv5R91n/kBfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753

This adds shared/bass APIs to set/clear bits inside the BIS sync bitmask
of Broadcast Receive State characteristics. Notifications are sent to the
peers each time the characteristic is updated.
---
 src/shared/bass.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bass.h |  2 ++
 2 files changed, 54 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 958b6f788..8f02086a1 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1766,3 +1766,55 @@ int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state)
 
 	return 0;
 }
+
+int bt_bass_set_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis)
+{
+	struct iovec *iov;
+
+	for (uint8_t i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *sgrp =
+				&bcast_src->subgroup_data[i];
+		uint32_t bitmask = 1 << (bis - 1);
+
+		if (sgrp->pending_bis_sync & bitmask) {
+			sgrp->bis_sync |= bitmask;
+
+			iov = bass_parse_bcast_src(bcast_src);
+			if (!iov)
+				return -ENOMEM;
+
+			bt_bass_notify_all(bcast_src->attr, iov);
+
+			free(iov->iov_base);
+			free(iov);
+		}
+	}
+
+	return 0;
+}
+
+int bt_bass_clear_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis)
+{
+	struct iovec *iov;
+
+	for (uint8_t i = 0; i < bcast_src->num_subgroups; i++) {
+		struct bt_bass_subgroup_data *sgrp =
+				&bcast_src->subgroup_data[i];
+		uint32_t bitmask = 1 << (bis - 1);
+
+		if (sgrp->pending_bis_sync & bitmask) {
+			sgrp->bis_sync &= ~bitmask;
+
+			iov = bass_parse_bcast_src(bcast_src);
+			if (!iov)
+				return -ENOMEM;
+
+			bt_bass_notify_all(bcast_src->attr, iov);
+
+			free(iov->iov_base);
+			free(iov);
+		}
+	}
+
+	return 0;
+}
diff --git a/src/shared/bass.h b/src/shared/bass.h
index a82d8f573..f3f708246 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -130,3 +130,5 @@ unsigned int bt_bass_cp_handler_register(struct bt_bass *bass,
 bool bt_bass_cp_handler_unregister(struct bt_bass *bass,
 				unsigned int id);
 int bt_bass_set_pa_sync(struct bt_bcast_src *bcast_src, uint8_t sync_state);
+int bt_bass_set_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis);
+int bt_bass_clear_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis);
-- 
2.39.2

