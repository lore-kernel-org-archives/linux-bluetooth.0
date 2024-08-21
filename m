Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ADD1B253C
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252218; cv=fail; b=b009JQkiS/iX1S+jvUiG0mcfMNc5XmxzvebcFd9umUGXNtZD240m4EusQW0g1G5yU6bG6kKUIZQy1dEjfJxYfmy2gNRyq0xDtlU03XsugqlSaqjaNFm4Y3bBtxjly/gWqPjveNOYcgZdV9M5jRRGu+/ouUY8U5bUimj/YfFHNCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252218; c=relaxed/simple;
	bh=6Q7Dp8ZpVufUn5nO/u6slhumENWaHaUR3cchai9fW6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fgxYCkXYUOGf6YmcULmj5hLZwkjYXJonZ7hOWdBvYp2Ct4dfWtaga2/NtzU7Gbs1UvOkRdHOxK6Zb6PDixNyfkoJ2DEcUI8m69JAYTjsl/CBtl74n7PiJDdtGmxKtWg92xMFwbRJrEMBiSz7HmwvG0NHW8IJEqbZhiwg1qfLWSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l652jIdi; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l652jIdi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lod5Ks2q0nchysQsC5QYDITUJGiF2zcVNzysnztuoWPkvYCh5ubpkPE9lcpEFlz1USt74ppzaSkd4Hlf8FIUXiqBLj6R2N/D588Hv1ToN6Mv+LhjTIZR9QtTErlR2Mv2mgS2G2VzyEO/1PmkJ1iFyU3tK0Q7CZlNvGpXD+UD6M2BBRNe0R4aoC03HORDtiUA/xp1L8rMTA8SDpLBEXF3os7fQj7pegCQFoEGabCS3L45ZgI77gAKLcFXRz5nKZbjSvDDnedm9beixwQcjUhu3kPfRbQEq+FZmzRMsnWQM9IzyC7eCGPwlKgY7rIxCs6J0q3WDXh0eeTitRPA/cpIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhYuc7zrrgJ0Y7owRYe1lR2JAnzLA44gESQxSuy4vg0=;
 b=Nqtum7zBg5ys5NoTiD5dqkzLWT2MYdK7UVmQgYeoye35T9YF4w0ZyQN/m988usRcdhXGTqCiCXd9fJ/gMKjEtsIG2dB2cMQLVqJfCjkcv7d5VfzdACCiCQLlf8SW7plJzuISJiClxpKhsEatTALFbfejmxiycFDTP05sCmfFof82y1//6Kt7xpXz2z6vgioaJW8FxI4+FZyI6gw4AYGl5QUV5cveEwZcuDWun/2Use7h41UoxlgcG7gpxDpFliaC4QTA7bJ0lt9ZEc2VrBixtP+J1DxPjU0Uarv4Qv/+Ts2u3yGMsjMzitv0cVm403VrRJ1/gdGv8VlVmvLJou2Zhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhYuc7zrrgJ0Y7owRYe1lR2JAnzLA44gESQxSuy4vg0=;
 b=l652jIdiIcO66XQ5k+vfvRbFDRBV3Bq/c1+2qPpbYNglXLV8V+KnRaVEagX0G99OIVYW2CtQDKBYifvF/zre8rkG6FVn5kTdG3lkfQiPgRJPA7jjHpyGXDctD1yM4QYwfnO3nkO7NmZXGK9ZttALXVde1zZQCxM6xuA8XUtXgrpd13/Y5HkYGtYqjvwSgRXGh2+tcEwKvhwFm+V0zcE/h0RTFpg1oxjkRQtBfTdD852gmORE94ChhaswASqnJXWfA/F1YV7rSmKien3QcUAzz+/VTZmgmdm2Zz2MPBprU9C5DJ6dbYE8FlkZM7Ju2lWOa+HdQEfm50azVrI2/cECHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 14:56:51 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:51 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 13/14] bass: Add API to check BIS required for sync
Date: Wed, 21 Aug 2024 17:56:01 +0300
Message-Id: <20240821145602.92083-14-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::7) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: fcf20039-8005-4d62-3b6f-08dcc1f17d44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tcNXHcQlMr6wKK/5dlgaVphB7KWQDHKgXzz9yqnJbx9rdwF4mOpK4rox+5KI?=
 =?us-ascii?Q?QsYgBP9NuT8X2NBSzuDkxHGEGhcY7fWb/d2lAIT28P0iBapUIB4U1gT+iVHU?=
 =?us-ascii?Q?+8VuKPhpVl3h64KKXy7mxiY7ku45g/rHJJzfZfH6+4LgA5SSZludTUSxFclf?=
 =?us-ascii?Q?UtRx1XqOmJ34wNSXVORDMWu3RJ4VJV6KoWvggLSnRYn0TwuLXPOLk6YXOy7+?=
 =?us-ascii?Q?KZEVEG5xgjOr7M7tmaYCT9Jr6fVU6whkQ7EyMPwenXwRMdTJqfkTgngtgTVT?=
 =?us-ascii?Q?qvJML+xA45/aO9G5ouRnL6fquTRVBBUZOSun99E8AySJ3/sue04iAnTknWc7?=
 =?us-ascii?Q?m7mIdmbb25woKdqnbpgjr8HX7a53A9225alkfCgsb14zYdjUZNYeGQ7cWE3Y?=
 =?us-ascii?Q?F0ca7JK6NSwl23J9SYX2P6xfjduPyalVEZChWahm39/h2/vcF3urgW9OpRZr?=
 =?us-ascii?Q?QNVid5/rd5vJSCe0f2knLW9dSeMaNJoQTdqW99Oagl1z/QYQNn/TRN/2dMWa?=
 =?us-ascii?Q?qor/26EkdTm+k9uqkJpBdz7ojGFG1HWNxIQlH8Kbd93Z2QvjSN8VQLxuEYFj?=
 =?us-ascii?Q?c4uYWb5JvMIfMSmb3Y48Mj1bOcOTLwZAZ+tnY4qRDyMR7I2pAgzag8HqPbzz?=
 =?us-ascii?Q?lTSLJ8Nk2uQ/WUkNo7txmZgDmJlSCUDlkYrTTO+aTgHza8Ra/zHGtXdMqEn6?=
 =?us-ascii?Q?n95rL0hr6m5gB9oC8uWMWzGXjSJ5pOzIGtfJM9qomll0TRr4vu9vBuOZ63nA?=
 =?us-ascii?Q?4BZv17GBAnryBsoYC7oJLFiqAxyGFRGvktDaEt3JTMRssLARBXdc2XaYcObC?=
 =?us-ascii?Q?REeS6AnLHG1v0DlPr0aC7L8wpuFxxknBYkmmXx2wXLxJ57zyxiNJ5QfhpPWZ?=
 =?us-ascii?Q?4bmSv7a3nKZw49AUFO+bNxOKoDmTkbMF0YIxIB+Dza8sHZhPrwL4Q8lyxluW?=
 =?us-ascii?Q?Dc5meASXdYfZe7Bnq2oSIM8lImSxSqfdwkvF0Z77l3Xt4hjHMIMVc0a33Eli?=
 =?us-ascii?Q?i51L2wt2SENqSJjCvkYsbkHyS0Wz05DopuQj6j8iEi+mfZIpggFa2Ig4kcD8?=
 =?us-ascii?Q?u1wXorjxOY87tmuQfYIcAIyYdIznfHjdjLiDMjJ2TAKUZoc30EqobtnVEyAA?=
 =?us-ascii?Q?084WwjUnHomhS5fw/ghlnq78neBJ5GXqjFKQ9LFH1oJInbb5rtL4IUJRErjY?=
 =?us-ascii?Q?GHD1ZjQuYxyii0TZ4+8+RXVQsy6tMyDY1tbI/Za5sBV1MGhWe++bAVgOiXIM?=
 =?us-ascii?Q?7ksegdaP1Bbu12GuKzzsOBGNxcoGqiOTTZjvnE73Vb1h5a5cqNYLdapp4mj6?=
 =?us-ascii?Q?GW8wwVXYMwmw1jT/M2zCXvUYvR8aUthZtNyqqM9Btlw3Yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K+5ByFMYaYVd64/ZQ/m5xgpjZ/x9sgtBP0jmngxQ6wQouoaOFFqg+/kKh4tC?=
 =?us-ascii?Q?O6YCUkpHK1K+MtXsgljViPNA4DacAn5G8v+dkxjaqIvTwt0Bb9Y4eqAZMw2z?=
 =?us-ascii?Q?g9UUjP1c90SMmvTJEjRYHL5+QtN4duU20TVY6uDv1artVZHwfJgkxoVrS+IE?=
 =?us-ascii?Q?lAG7cuPlRQ+8ChiAnCEamiDB7afziYM8DdcHp6KX1Eam/nYA64s/uQ31hP9r?=
 =?us-ascii?Q?o6wuGOekXbtP0Gt8CELAoK9vlcLDkeWEjWyF2pgZIC5vRvMSekkGYBASW6aQ?=
 =?us-ascii?Q?tiGT1bNMLkxCiSgFoZ4USgl0hR5Rag1aneFVrQ/YhLeaxpm45craLBb8z+UP?=
 =?us-ascii?Q?7zdg+Wo6agVihOQq2Y3jVMk55kvEvGj+cqUL+UbWbK5YvKxqazY6mld0nk5r?=
 =?us-ascii?Q?Wqfo/zuJJ1v7/Gsu4vc22BGPnIjEjIiKb3nfLRUrXUBcsjqAu2gnBEaqjEzX?=
 =?us-ascii?Q?f8ovkyq9MhQ+Gm9HjYceDVE0B3AEz+MSiiOKRCLsMQy8JkWJDQ5K42y0CJ0d?=
 =?us-ascii?Q?JM27+fben7QilEAogUE0EnmoYlblgNNx1c3u4a0Incw+GhdPVJmk+pB7RlFi?=
 =?us-ascii?Q?OHMO+tE5lkUz4sztkhpb2lD3vEvre54gLz78PLlJDowGBeerzAoEZjZxzKgp?=
 =?us-ascii?Q?pp8Bdk+sXOcj2QXOWiE7DgLwRUNBGlMvEzSCf2qHr5mAYEE3VjHD7/JkYQPw?=
 =?us-ascii?Q?ChZKbBODfXz4iy043CmPGZmMXqixFz/Zp1HiwCXP9JB4qoFRH9eRt9ltmheL?=
 =?us-ascii?Q?G5xM/erK42JwEErPQeVaceN+oHs8pHPv90oZdbsTDEjSp0eu2+cDB1t6QteK?=
 =?us-ascii?Q?q4n6YGhD0HQk6Q8NziTl3X9a28NmFowP+6fIzuAqpwhE7KQqAqdfkKtKjUGL?=
 =?us-ascii?Q?8V9NFGdZNqdiMzNAegsUF9oCmTX/Y4ACaz9uRWW6xNYohY7O5aWAznel86R2?=
 =?us-ascii?Q?ayniUDIaAK+d13ZpMQFUNN1jwTiS0RawArTg6clG/Wpf5kq9DkBguXnngILP?=
 =?us-ascii?Q?Wke+/kfb7JPirHh1EG07rKY1ma9aqAf5vKdmJkrB9seZAaBbKWHe4Jqvn1ek?=
 =?us-ascii?Q?hjxYmCMDDgJsxwOf08avQLdoFEC+Y0lfKPM9UEQ4SQjnVcRVO20zcH8hkLgB?=
 =?us-ascii?Q?yiD4fkVN4Zc/dTXPkAGDmhIQhQXD8dZ01AF6wzWl7hkziNSRdBy0lRdmE48a?=
 =?us-ascii?Q?D9UJWo6+42Tve+VD6mrau8UFRyaaMjY9ygz53IuGE6Fz1EvUIZNANCSEzYGA?=
 =?us-ascii?Q?98i3qk+wRURx+ranH+zGauyJi92SgqMLeYwysw2Fg78Fh+Gj1fnmyslEPRv4?=
 =?us-ascii?Q?InSM9nI9rTfCaRC4cMaO9DSewL2sNpIHtXqC+2Y3QZ1TqGXVBx0bVLhoN7L4?=
 =?us-ascii?Q?bL5WtTW868LkVSdjw60X/PsDdWBa0lVsmurqMBrRDgpvAOlkw9Q5U59soPcI?=
 =?us-ascii?Q?sM5bP/LdO9pW4wkDUolOTmpPg8DGC5uNpgqf3pRE7LFAnQuccZMKTex1jDZs?=
 =?us-ascii?Q?nL5W6EL9T2EL+pgmMVW2wOAFkBNofeoCHB//alKmDfyiQTNwrZXOCV1c1rIm?=
 =?us-ascii?Q?gq2yXgzShXJznz9Ydql2MV3FRM1JhWaXIC+3StqJYzniz7kU1/4q++kmEKVz?=
 =?us-ascii?Q?Yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf20039-8005-4d62-3b6f-08dcc1f17d44
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:51.3542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UB7DKj5I3zBxfrzraxJ6HpKL/g4UjeQ3kkkNrz4suHf+N6UD1gfcEfUoHUNqEBbYAhmt/ATB+P+EzuOLLYxlNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753

This adds a wrapper over bt_bass_check_bis, which receives a Broadcaster
device and a BIS index and checks is the Delegator has been instructed
to sync with the specific BIS transmitted by the Source.
---
 profiles/audio/bass.c | 14 ++++++++++++++
 profiles/audio/bass.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 47445b4b5..1c63bc163 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -125,6 +125,20 @@ static bool delegator_match_device(const void *data, const void *match_data)
 	return dg->device == device;
 }
 
+bool bass_check_bis(struct btd_device *device, uint8_t bis)
+{
+	struct bass_delegator *dg;
+
+	dg = queue_find(delegators, delegator_match_device, device);
+	if (!dg)
+		return true;
+
+	if (!bt_bass_check_bis(dg->src, bis))
+		return false;
+
+	return true;
+}
+
 static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
diff --git a/profiles/audio/bass.h b/profiles/audio/bass.h
index 7e20385e5..5e34db90a 100644
--- a/profiles/audio/bass.h
+++ b/profiles/audio/bass.h
@@ -14,3 +14,5 @@ void bass_remove_stream(struct btd_device *device);
 
 bool bass_bcast_probe(struct btd_device *device, struct bt_bap *bap);
 bool bass_bcast_remove(struct btd_device *device);
+
+bool bass_check_bis(struct btd_device *device, uint8_t bis);
-- 
2.39.2

