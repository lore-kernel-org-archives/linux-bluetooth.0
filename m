Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2080.outbound.protection.outlook.com [40.107.105.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D560C18E04A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724925163; cv=fail; b=Jh2DlecmeB9Sx7SQM4BaKOCi/lzfESFRQQuWZdt5Ii99PAexQ6tcHgQMmQkPaED8D974zlLaD+Ug3KJgmwvXCaReFu+d4Qu547gQp2lMg5dldVKco1TSh9NNzYfd5/ox3BXFtVG5FpGdCsKtlfV4yuYsWhFkmAxC1A8rr2n6GDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724925163; c=relaxed/simple;
	bh=NUSt1nJT7sKygv4xw0kO1WAyxC05uiXUoJ0VFDqIOHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lhAt0TGxpkn+r5xDh2qq9jP6BY8M+MX6xLZzrbDeC591SNr8nBj7VVBgidG7fqDYl6YlarDmOvh4pm900+cvxxjXGBfoFehZcjRzcn07QihCixxXlGO0/P6vT7hHzVckWViL7ijDmoUxwVPVzkMQW/MYUDjoCk11/JbdrrZSbck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MUrPvLiB; arc=fail smtp.client-ip=40.107.105.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MUrPvLiB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPpFEdSUzYFbH6nip4zWA1ZyAuYa0Az0bvOk6FgmkfjdwJPPdH1pTY5XvAVeIxeS1IrnEbmzti/tqsuyKwHiiOgDePUF9o4QqVWCHCpTwvFiT4b2st0zOmYdDUbUs27X6vZrbwqXy86zW0nFfPO5zWa0taN34ds/Rd59//iImPR7T+PKSIHcgb/woThdRbo+AcyQmhyPs5GSmCVCWX3r7/rGMofUg83HhOq5YpuBjDVqnSkv4sGIK2owT4dYj79UipZatZH1PAxpdAP1XdhrL0w0CWDT3HGmyfKKObN+liSvVGSany+bZSDEAokg72yTa4zTIcyEVpmH35AR8uErxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkVX4V+r82xNgWqE0GXl35HsaW2JcsXVuIgU9ldPBiw=;
 b=ra9WUxENFvd6NXv6dB1B5yDijHRlWCS+R1BdpYzamiZwUCKJoaBusf3JClhqV84J4s4LrhkyMjwd/P+UgibNC1ASO8OBISzp8Ch6548zaRATO/+RAn0UfS9uJs8bEkaIsSx7qtXvExHdGBghYwzQS4Bb9zUrmZdjH0XRo5aukYHYEWg8c2j9QGl1qqDQFetRhmCco+kzwqnGG9K73DMoGttpk65bS4I9Of3kuWLmcsOUsTKjB0ctKfhpwgb1vKcFKNtBh5KWFd+kZYi2e3xVVXzR4Y/mKnpHYVrJN5eSHF2A7oT3X5S6/erru6mrjh1BKjh9hp2jGYn+l1JXfQjtqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkVX4V+r82xNgWqE0GXl35HsaW2JcsXVuIgU9ldPBiw=;
 b=MUrPvLiBcW8W/6BW8ovsQAWv6dvQl5XAwleXsklGdVhfJotdzP+FbPQmSUgp6kXkquP4sS4KeuxLCzdDncd8r2tynbSj+Bj6Hbt8LU5x6+Hv8/JwCcWlIpPWLF0WucFQj9F4DJWvKhASOxfEbLqfHVur8V8xDmJPsn4oI3qennGVhiRgTNAkDZnsDsM/UWLxj5PKUeFXZX+plJLCVMGi+evbwMKgRlv3QNIF2Z5nDMCB1LiMDsENKgu9kVSW+tXvyHXSFG4W3CNnz4OSSvvHw39HiVpijB3jDuuFG4I6B+6x+XnLVwlTJw6gKw6oVuSn7bc+VeJxfQlPGznWWQF/JQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS8PR04MB7720.eurprd04.prod.outlook.com (2603:10a6:20b:299::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 09:52:39 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 09:52:39 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 2/8] transport: Make get_bcast_qos return the encryption flag
Date: Thu, 29 Aug 2024 12:52:00 +0300
Message-Id: <20240829095206.91150-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
References: <20240829095206.91150-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0196.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::22) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AS8PR04MB7720:EE_
X-MS-Office365-Filtering-Correlation-Id: 4954fa23-1eff-44b9-bc60-08dcc810514e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KiDGm/Jku8QSiLFrvTp3aKNyxDs55XOWjeKw0dXePoS0GIPdm7xYXRQNA/wR?=
 =?us-ascii?Q?qw0/UoiALsFZlI+dn94wdHq8eA9sPwVRZjNHOE3ekRVvSkDTpDcQIOgo4ZGj?=
 =?us-ascii?Q?SyNmGpr5zv/nqeYKP6nVzLgu3Qdd1FYAnjISUnHOdhrSlhzoOUxpP+i/5IZ6?=
 =?us-ascii?Q?8NTFnr0nDI7n2M/SfXz6OSiX9RSNNvRcJlqbec09V4gbtsAzfvXQEDr63z+n?=
 =?us-ascii?Q?jwE5PTzA5kGp9v8LACRrS8wAvYu3cq7piTj4JyanfRILBtTtcAdOxkGKQClQ?=
 =?us-ascii?Q?+fxTtk6A2sLUQN/1qGjrWQ6DTXEQUh0twmvRFpOZvADpAh+WwEkpzfLXQg5z?=
 =?us-ascii?Q?Md4aUPYP7JtDrCBZtSgkWvdAbftyKTemZiCLkU7u9NoC2ZuT/2p2TZPJHazQ?=
 =?us-ascii?Q?JvRnVFbc096g/REIGarxy22W6cbRQxYq4jOs44q+wkJqu3rIUyk+mrLfn0vt?=
 =?us-ascii?Q?gRE1xd1188N0063d7ycokI4450qNmAshv5VlJO5KcqCgbIxVIg7kP3/gDSA7?=
 =?us-ascii?Q?uWk5Cnx1Ky0Bi/ajllPs0Vk0rmCahqWJ4yA/RCEGstst0DnML4sByBR59sV2?=
 =?us-ascii?Q?4WBwnp83HJ/5gAQVic0rOO0ItfPJjTlfQnASz3hvGdKAK8a6lm1s6RlCqm+j?=
 =?us-ascii?Q?ykjjtWcrY07ANbhwRe3KG2kOqE9Z4ww0hRJLlTmHbvrhRGwrVOlc5bO+VGeE?=
 =?us-ascii?Q?vzeLDm0d0SqNcyCYt23uhTOY+GU2xX8eAxxU/XSBwPGNmcfTuM5GICL9Y9HI?=
 =?us-ascii?Q?Qhj2+Te6NjcaVbiahVHzrHjl9nyQbVA4DiJ+P1Vu77uyoE3DOgmnHitbZZyV?=
 =?us-ascii?Q?L5asMWq7N5B4Cj29NMSEM9CJnKTQ+yo+MDyTOu1tXuVpzhLxFja/QvxCgBYU?=
 =?us-ascii?Q?m+QcEYLQ2kbpjVLFt/KrgPHOV5RmD+njzoGMeIyYWTaffX2LNG9nuP4VvjAk?=
 =?us-ascii?Q?q1HoB2UtTbn63lRr7MW8YObeccCUEmjJfIJBWx8hCZ1qF+0j0KmFe3T2ZCoD?=
 =?us-ascii?Q?mZcuncmR6BgQx/2bSZl2R03PHrllzZdh+Nujdjga47GIxDihHzujY88L+3Ht?=
 =?us-ascii?Q?BgoaP79aJamAPNcbm2scDa7wL3EK1mDfstwvl7Ae9j8vTL29HWqwJGwc778y?=
 =?us-ascii?Q?84QpwAZijerFjbs7sWqwEGU+uAPZ3j1CCK38cuVOO9xD6YN/TxxlvIeiQy0g?=
 =?us-ascii?Q?rdYOGz8skvPmtJ9FzrLakIY4hzqwT4SE0gYqCiQy3QLq/uxFDXGSHbn8y4IZ?=
 =?us-ascii?Q?qPdLTvdEHr0oOAaFWAevnT+IHwI382aV6bQtJuH+jGSUpnmjedJ8WVaE605F?=
 =?us-ascii?Q?IVN3Fu51F2l8WXt6SXPcqor5Nk1UvlP2r3q3I+FHQfkbyYIU+Vj+kyCUlymh?=
 =?us-ascii?Q?3CZf+Gv5BCfxqSMARklQ0pUEpXZs6gXXZN/v2sjaZA2cvOEzJQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DTCtNr1RhYviZsXhPxr3sAcahy5YTkNMGJl3YWOKO5Y6V2OekxHPlP2cADGq?=
 =?us-ascii?Q?8gzbpeDKUfcPXeMWpaIrdwWqXbkaE17NLgyeAuoL3FyT9oeW3hP63EW7Er4l?=
 =?us-ascii?Q?YOky4U8OOLag/SJFi2PTXnqwNdUvHZSyjgNoc2G251EAYqdFgj5yQXRK3Djp?=
 =?us-ascii?Q?3eDa/0xxfr0ws5GFXwQa68O61ADeL/uc8/Lu9QunLK9pkCdGmaRequXoZbtM?=
 =?us-ascii?Q?ArQu5yMbJYcBkKsbje2NU2auu4nDT8e0n+6CKDvnrLUdbGLC8SOBwe/WdkZY?=
 =?us-ascii?Q?wTpLH16WHKqEKCCvh9C9Wf4YJtsf8/BHOTKGV2006IfmjR7tBghhXHUaLgS+?=
 =?us-ascii?Q?ksnc4h/TrvH0hbVw8rg+ZHoqYTHYyXVLwNAIqAi4OIo6YJ9Sk+ZH/Mj3in+F?=
 =?us-ascii?Q?b3z4bNFhWXqg03IaGf8oGtaLr7oz82XOBMqaZdZH7/kWqULat9IR2mWfqZ3O?=
 =?us-ascii?Q?hG44QWrCHuWb9K/qBROGDdFHkdxvfEqczAKtBR7PahA36/QQc7ly0bHLKiqI?=
 =?us-ascii?Q?70f5wUzXsF/j0shkgELdkJQ/jaJqUX3eJ59JTYc3M3+/OngJN7gjUc2ns/Cg?=
 =?us-ascii?Q?qSEQ/nnoJd+UnoEp7Kj457W9GyQreXtEMJbUt10neWL9ZYS39sxGwu2PcfrV?=
 =?us-ascii?Q?YCACRxpx42pKMgL3bqqKVBmbsvf3lgDnLoy0+HGHPv4pHXId1Uf4/oyBNqiS?=
 =?us-ascii?Q?wKiUU7TzzFKEYMGlLkXobMR/4UtmZD+ln+5u12QTpEfz8ei7ZPNxH96RplOm?=
 =?us-ascii?Q?Y5+gdG4Q+v/pxcU83hgnyoQumoPfpjEVO9Fje1ht/8iZk9BjlxQIIsMUYpsu?=
 =?us-ascii?Q?DT0ZTJl6ldvexF/iX2kHxkSJnmVtIKsc1UWuEptL9P+Iw8PpZsPQVoLS+DHT?=
 =?us-ascii?Q?vakWYP+Ub94rJyIX6+VjZqypVajRg3uWYjkfxDo6PoFgrYOP0RWd0Pg0rhuD?=
 =?us-ascii?Q?Atq4wCpU3VNvcmsfzu5KaqlXg/NGC4O4qMJRgbJ/fc2NM8GShR5/8LkaPVGV?=
 =?us-ascii?Q?hn1iaZMxdXqV+Vrdnh4s2x0Csv6Siah1tOdI2GR0XNmRgXnB5x1JPscCF4SC?=
 =?us-ascii?Q?RDQd9U9GeDJ9OJ8Rk03qImbLYyhe95gUjN8ioHq1DPgHWkcdX3xv0GRimQs9?=
 =?us-ascii?Q?yucm00/5sJwNAJsxHzjSxPIoklBxpnUwmFuuW5EfC86FL0p58xPlCww3KqGG?=
 =?us-ascii?Q?OX8X0SKZlGXCxSO140xCMOZ5/BALuHwcPd02nDrrOZBfNGNsVambWJGydH3n?=
 =?us-ascii?Q?3H6dhD5UNYoA8jzMLg1H7fNMJZ9OEQiSYHSHl/za6gU4XJiz3RUzqfczzCML?=
 =?us-ascii?Q?rgh3qw5s/XZHWVHvV/cyg3++hJy0ZIkm/UBTcAVQC65/mYTDjdFHcCHJG+u9?=
 =?us-ascii?Q?2mIcENsydhYruqTZpkmjBoLMVmcey+8pHiIdA+OOnpHQFXlkZ/ONzOjM2mCq?=
 =?us-ascii?Q?Xl2lOfjTk4MwPWHz8nCKOGj29BbsGKr+HpYFk2yCC7VrdkrqTailfvAq6ybf?=
 =?us-ascii?Q?crdokLGhCJ5KgtzZXmVDvcZxPKmpztzkHkrxWtsBjkdR23I1HqdQoTjcojrl?=
 =?us-ascii?Q?uEbr7ZQQy1UVYsUhlmBAT5W+6EG7Fs1x4PjbVnFC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4954fa23-1eff-44b9-bc60-08dcc810514e
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 09:52:39.1250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: miH1qAsaXvtpVzD9JrrOF2V+7Od6XqCt1bi5zMeIkuoe4OI/BZD1f+iKNvMiOvpN85bU+AQaNwVth6BxMcyiSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7720

This adds the encryption flag to the response returned by the
get_bcast_qos method.
---
 profiles/audio/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 300145794..e8915490d 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1174,6 +1174,8 @@ static gboolean get_bcast_qos(const GDBusPropertyTable *property,
 					&bap->qos.bcast.packing);
 	dict_append_entry(&dict, "Framing", DBUS_TYPE_BYTE,
 					&bap->qos.bcast.framing);
+	dict_append_entry(&dict, "Encryption", DBUS_TYPE_BYTE,
+					&bap->qos.bcast.encryption);
 	if (bap->qos.bcast.bcode)
 		dict_append_array(&dict, "BCode", DBUS_TYPE_BYTE,
 					&bap->qos.bcast.bcode->iov_base,
-- 
2.40.1

