Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2060.outbound.protection.outlook.com [40.107.20.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2A219E83C
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098396; cv=fail; b=RpUZg4K3atEvyIz/xSWUH/+iDOBFtGVH8XEN2j48V7tFieswqqNigLQ2jogVVcTlwHI1l+r43lcdUzWhzVpGH5R0LFh/fcuFbfIbyK109zfDZfdV6HzFJeZVZCpOCqm/Nb9VKqQEKAeTEQtME6xqoPgmtYBvv++8xgsuzW7bCnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098396; c=relaxed/simple;
	bh=e9A8adVogRYKLHOQg0wyMTii24iCAiTQAfzmt79cGo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TXAO4v6HUza63XK7E3JBwz7NUOlgQf4uD9wgRgis0BqzsqUrn0CN83JwRNJEgCQq0GA/J20EgdyGn1PVGt2y0AYoR7M151QkWlr563AyJ10kwBqi2Z6n6CfuQSIJfztpe6kCsaYfdGbbxbcvC3H/P2lUnHglaUn/0tQh5yOaHsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kwNl6F1Z; arc=fail smtp.client-ip=40.107.20.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kwNl6F1Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8Qo2V+FikhB942cv1Ch+uZgu3Isx+gyZUbGoumayyTcKxrW5sF+Us6NWAmKEP2CGNlCTX08JJ/RojCX1Sl0971EDF6RDKauGWL+rql/PLP2GhF5DILVjptxYV2H82WkfF2Qxzkz9R7fddIHumLKxVqNCJ3qTcRdgiAtyRvuagfqWALDFxI6/w3sYukLlEVGuIRnzntz8O9P5Bwv8V1J7u4nYtetIMEH8+76UMaqQNFxaZKjS00RqsjB4453ncx5zYwDsk9Lka4IHU5CHI2Eb6+VowVJ2qkV38WLGhndDk7+yc0fkxYJgkJ5UH7QOFSDXWLsmyZIisN+Lp/A+fp2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Mn5AcMQDTHgX25uYCRPEByq6rHWfTMpfjqIiC0wzcs=;
 b=IJqdr0zFoA/8bAbvEZrGH8YoXuFr3vyFdgMnuCyNwEqhif0L/0roXgxVTawjEPtPcUYgT3/qsOGXzSqP8ZnnrKN8V5ou6oiXHrii9Em6IgxNONUu0zLwrvihfqOEmCC9k0o4anK/ricXgVhqqIZU0pireSoBvBLuZl0SocpcaviIvA0SiX4+6kO4mVb0Ufrm8FsxNozoDpMtDOfkRDfMAV5PWCYiNxPEOym/N00W2Ox/Er00fZOJzvkuW4/mqr/aLbic6Vjlpt1V2FAnmrqi6yJy2izcwA6BUJvWaq6fmeLj/97wdyTVQ4cVOuEl0t4gmLDH0q1Em0OboakuM3gASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Mn5AcMQDTHgX25uYCRPEByq6rHWfTMpfjqIiC0wzcs=;
 b=kwNl6F1ZGdtXmqB0f0v13iVW7HNVvl10THBpWW7646Vmh4cRuNOtvErBXh8y72mCax3qszau27VLmwrtnuBc9caQG9AWfenk/DymervI0peRl/pqVNnS9O4GNvFoz2UkzfE72Ysf6U1jkCbCv2nj5yFwNF2xAundr4pqTZF1tKKMmtYtkDMMfrpR+XDFe30CEg1FV/9YT6h6Gbph5NU8piCKF+AXivljDx6rIfzm4eLIwqRTo00vANOIROtoYnY9APYshVpm4ZaTNdpP/6XuLJFyFW3+jnp5Qx8x+aR9wpl7lVbonPRlGs/uy630zZeF1TNEbTRVaoQIQmYFnCTpBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI0PR04MB10389.eurprd04.prod.outlook.com (2603:10a6:800:217::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 10:26:31 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 10:26:31 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 6/7] bap: Remove API to probe device from BASS
Date: Wed, 20 Nov 2024 12:26:00 +0200
Message-ID: <20241120102601.38415-7-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
References: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5db::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI0PR04MB10389:EE_
X-MS-Office365-Filtering-Correlation-Id: 093bd02a-ef2c-45d0-0586-08dd094dccf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sA+0TuoJKqVWdoctDOTVg4NWzoIeUFe0rEY64oZ0w8FOauoH6vQZoABt6CD0?=
 =?us-ascii?Q?cjAMWLYQzJpcD1dOVzwi1towNuD5adLr5DToGBXR7nQlHebwHGCxXuqFSLfG?=
 =?us-ascii?Q?0K2KyTbrc7srMQMwMo2ux7mNhs+zVrvxIUtIOQwBOEg3Kk6shkgIF/9ZxzBT?=
 =?us-ascii?Q?TsbC+iP2oCCdpO2OPrR2Cr7+SjmPWwqKC/SnVbwnZQ3p/1A81DLK1ccQQ8vw?=
 =?us-ascii?Q?pxLnjjp4Q5F0cYKXp/JnfxVKXC2gdIM2ogXSyx0yI9Gca2N1/RurFlSSNEnS?=
 =?us-ascii?Q?0xmG7KNUGBAGlwZxVgXirvbeXf4ieJTOHXemK9gXa9HzoD9WZ3fN51gYVknP?=
 =?us-ascii?Q?3J6+uz9PWLOlShdpsKKye4Lkg5MsRols1w5S5jpbdAdcgoePM0wXrKxmzZfT?=
 =?us-ascii?Q?RY96fpt56GdR5OHsSJJS+pmPX7FExVthnHmVVkBHP6xii6L9mg9uI614cYdu?=
 =?us-ascii?Q?xd3BukkrV8UeuE2TnjOLHTuzShNqnnuxIUvPynmZJHqfH1LZSyNhyF3DJ0pZ?=
 =?us-ascii?Q?mbTQXZlkp6wpw/QACliVCQWG6rdfLm0i/C6STqufCMymMDi6WZHFY7JIt7o4?=
 =?us-ascii?Q?VdKv3JA/hvVdSTvb8gMK/SLhtK4EXm9yVOdOUXbobK8RAWhm+Q9M+tdsd0Ht?=
 =?us-ascii?Q?89dV3S7mXjEXBSmAtaN7K+1ZqMTGWqCNhE29DHPK1V5fTOKB4cxNB0q9rovV?=
 =?us-ascii?Q?kMfeD6u6qu2THrXxD1MbvV1otSp3X7RAHKrZGjl5PmjrXkRv9mqdPEy69qu5?=
 =?us-ascii?Q?oSQlnK/vn/4l4WB9SyGxImIF/zNdU+KUX+HdpnWK/MlayTVWUQo2MbhrVeKH?=
 =?us-ascii?Q?zfCUH0T++DgksLZNgE4B2VXkSnquK2J7dddOgnUD+VUUJQ+Ac0yN02A+g+lh?=
 =?us-ascii?Q?N1dOVjgXRE5MhaSqVR2PlwyQqp4rpHYqi/va+VHCG7vLBfW927pdAOI0eN6W?=
 =?us-ascii?Q?UBgiY2Axnvf7fwP0V/H8tiFebPLLDRI8MlruGLpoctjTKTrl7lCb3ZhW/JIb?=
 =?us-ascii?Q?M1VkxoVIn9VuccJIzyO9R8jXxyC+bKjq3GvS8F4eMeoI8L/0cIRhdmjdm/Tf?=
 =?us-ascii?Q?YiAbxPTDS9QoYHcA9UBT3KQeh2JNish4aKNJBeHesZlgAEuL4cQP0VVxa/Gh?=
 =?us-ascii?Q?KI4PSCwRWI1RtWYCHzT3xDSCV4alrmQX8b/2yfZM8qmBJJdLVx7fViXIBLJA?=
 =?us-ascii?Q?59ceNC0uDN7DdWZMHSO2FZMOFr4Bd+7j+jrJCVHAm39vybqEjuXb2uIuIoo+?=
 =?us-ascii?Q?zs7i6V6Bn4CEeXzn+Je8b33KB/XDK5HNe5c8WO6xvdI14NaiDQ+6EA/tXmjU?=
 =?us-ascii?Q?PCq/IreeelyPntHkc3GkFSqg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6yCXk2X2zRRujWsHGRphD6CBvgd5bSa++6jOmQfkDYdLrp/V7BrU0JHWsKpn?=
 =?us-ascii?Q?JMacOkB7yWmbkKmGlNbGmXDJsBAtpDAdVT76MlKgg8CLkmEkaFEWB+AFAKFS?=
 =?us-ascii?Q?452hL1Sk3BvyjUU83RIo9he4C6kfbqUr02LYxTyYH+ujJ8rDZIVw/OjWkfWP?=
 =?us-ascii?Q?r6w5ML2WRfG6oGDq0GrBePL+Vgw8TkcayDnRgNLrX3w4o+g0Yrl9HdLmZIos?=
 =?us-ascii?Q?rENbsnjRADWYMow+mwnlPy5dS1hmewXjqfxAGamHkofDfOrp0r5yQ+DHxf4j?=
 =?us-ascii?Q?Dc6knK2vnNuEITsk6YD5NjfTnes5xkXgFVszVswuytCR/JiTCvdn9WuNTPMF?=
 =?us-ascii?Q?DBdcFI/iJUWS/GJeuI9u3u9/sUzK9H46lm4pYl9JsgW0CztHbjcw1RY7xL5W?=
 =?us-ascii?Q?LG9dZWBfMEo5w+htuXWlM5k2Uo8bA8+B/7Bc1rYdrEkD+CTEg7lsbdezRh0o?=
 =?us-ascii?Q?WEHqTR+T8/hK7ZBxHqpYbKCgPD8GFwCDc9ZbCxLka0rGqPLGEty7PCIAPXLP?=
 =?us-ascii?Q?W+AKMgFQR5FVwDs+Lf+k7xXX82VnQZ75CYHej40+kGRBmRH5S6We1Mxp2efV?=
 =?us-ascii?Q?ARqS+qr9N6AfwNACqrjSAs0e3St0MDNnKTMEz2TSMqqPWw30CYTpPkU0SqWS?=
 =?us-ascii?Q?zK6dNx5lIUC66aQ8BcAoT5Cu+2UC7K4Bcyf6QcBpEEk15CUoxKnxLQH9iQ2H?=
 =?us-ascii?Q?TPwmUhcv30WGKlFoalN+mlmFeJsZBqVK1+N3+cBJ1FGutwkCv9tkTFMWEIft?=
 =?us-ascii?Q?0ss2qz0MWH+o7894n6/zxsl6GFLprwDWuec5/nZnTJJ2M5joWqqz2FyA/HmY?=
 =?us-ascii?Q?jBqVFZmmC3HLOXZVRTVbTTCaazUWl3HMvpnaCBTbUHNNbnnWwepQdV3v4YUi?=
 =?us-ascii?Q?B/VVIVbmqd33PGsGJlz6h2WwDMXunV2Qa7Nq4KEmtftO7Yep85DGezOcc+RK?=
 =?us-ascii?Q?02gdZC0IwG9zHkjcNLBJKrtoInLoMoYLHd1WQfEg6m1waQKf+BJZIWqmOJT7?=
 =?us-ascii?Q?fkdLd/SRqv/OkaWtL5LY24dbVDIbMxI1O9O1I22aT8X5cj6fURnJfHH1yvI/?=
 =?us-ascii?Q?X7rILOOqiSjldwajG/GcVjR0L++aytY68HY4zj4sgWIpmaC8T0MzGZXvh+26?=
 =?us-ascii?Q?Ow6k3dG5OLbkyll1wOuVWghMkODIrjBo0bZ7SugKsQEJUzhKLn/XxZKApo41?=
 =?us-ascii?Q?qq80EltHdpTUwh2rhvyeCVJXHWriyHji6Ryq/3VuUKDoQTeS7bfpG17885sV?=
 =?us-ascii?Q?azy4znF78dpM/ma0nglwBLLlgZ2qkZqXmTVSAB111eocovFGOI1kMxrl99vD?=
 =?us-ascii?Q?k61uuqcP0E2F5O4kv4sa4mzmG7iB6nkrCXGafC8P8o8tMRNobPvFb5V0kxVw?=
 =?us-ascii?Q?N6A5kDA/9akI08zRQfupDKa6wEB1u/swtnnLVz42iXdDY1ZFqZQ5HG/clB3+?=
 =?us-ascii?Q?gXHtmvVuBRu3Up92u4BZ5EqOqYuugmljKyRQI2kKeZdDXcIAP6SHb1EoD4ir?=
 =?us-ascii?Q?DeTqTaL7ovXNXLDkVN05tYaUHSbOKPPuRxB5laeABOLuVmnz7pFYq7lujNVv?=
 =?us-ascii?Q?OqIrdUtIvGTawoi78y/qZVuW+82hNZ33WJWE5kGMoctY84nTf5l0SgN7H9BK?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093bd02a-ef2c-45d0-0586-08dd094dccf3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:26:31.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5GC9zHNNXGuldHN8YgfjmP1kqzI/ll2HUNa4ssdUp1EJxZ+e8VVLa2rMFmVzJ8TmzoEKmk+qq60vU639CFEhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10389

This removes the BAP API to probe broadcasters from BASS, since BASS is
now directly adding the Broadcast Audio Announcement Service UUID to the
broadcaster device, and it will internally handle the probe.
---
 profiles/audio/bap.c | 16 ----------------
 profiles/audio/bap.h |  1 -
 2 files changed, 17 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a1cb3aeae..c1111b625 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3112,22 +3112,6 @@ static bool match_bap_adapter(const void *data, const void *match_data)
 	return adapter->adapter == match_data;
 }
 
-void bap_scan_delegator_probe(struct btd_device *device)
-{
-	struct bap_data *data;
-
-	/* Create BAP session for the Broadcaster device */
-	data = bap_data_new(device);
-	data->device = device;
-
-	bap_data_add(data);
-
-	/* Add Broadcast Audio Announcement Service UUID
-	 * to device and probe service.
-	 */
-	btd_device_add_uuid(device, BCAAS_UUID_STR);
-}
-
 static int bap_bcast_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
diff --git a/profiles/audio/bap.h b/profiles/audio/bap.h
index fcc443dbb..522072340 100644
--- a/profiles/audio/bap.h
+++ b/profiles/audio/bap.h
@@ -10,7 +10,6 @@
 extern struct bt_iso_qos bap_sink_pa_qos;
 
 struct bt_bap *bap_get_session(struct btd_device *device);
-void bap_scan_delegator_probe(struct btd_device *device);
 
 void bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
 				struct bt_bap_qos *bap_qos);
-- 
2.43.0

