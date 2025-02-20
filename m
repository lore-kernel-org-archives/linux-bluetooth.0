Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012036.outbound.protection.outlook.com [52.101.71.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214651EB1A3
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041920; cv=fail; b=LLtH5shshGLxbThk8l4/L30ouGRaKnrzvBtEGFX2mKBoBQZ/L7Tnoyd29p1iraA6o1vTHx32fKMoJIeQI3osAo3SVQpe+Jse3QRohqXcHrIhwBaYdTjfNP+zy08Lj11uxQJ1TFtNszM65m487mV9pWQciCQjfwImraObTQprKxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041920; c=relaxed/simple;
	bh=M59MNMSa6oGLImKXY584S1/FnyBndJT8Ppy60E2yk5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jCjpQHhPyOAxrTFjUYEQKgQZnfDbnMAEc/KhWZ+iBszYD+GbDShLGyCio9am7+UCOFA2AIps8GqDdMXdt0uUc7cG2+S6cNt8XEesWBaiXPrESRedraaYFHiAODC0ooDjzEn/oyB33tbktzdeF8qPZib47v/U+TYPnMEqWRiWquY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g0WEyr3b; arc=fail smtp.client-ip=52.101.71.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g0WEyr3b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lg71k9w2bgcqMwGOo7K82tjMvRqQb+zSPloqB9yHLg5UeqXhGJ2Zl0/fRq4n79YIp8zG05grk/cgzymgPFBZUSss1TJGlT1nZP68vs4pEVni3l+IrRlUIbjWL8KXNIJHesNUgWbkgiypG0UXAkxT8KOOovtxXV2dCOEd4RV+Uq8I+x/9Cgb46OSM9r/7HTU3Gi62+6l6dq29GzSIUR0mMPQ0ZwBtDh8O6SkKYK0YBwhJq71mFnByPWpMZ28uX8HzwxaDewWmbNXeIjbkaUwg7fgSfvLv2ub+vfgTKh9SnYbKd6ArgXx/Z/TFUKMYjIja6vZlGoNTN8cg1KMKcCWA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11C2qMOI4sCJG1bDcd6ecENqRE9aP50qTOmOz3MJ+ZI=;
 b=xbnsM+dXN1zTZzLWYDkb0ha4O+mpDcT5JiwedL/ceymmodIVGDJJSK5hvJwRL4xkwjG4RnqbtweTjMWO03TJyR35XyWbxv/K4IgljgsIyVpSkOmQ5cx+e3tWXkEm0JSWhKv5kRs/T8246JHSGP2aUnEhR5RPlD9FrmXVnTPWxgdctWQw7l2cclE+F75S31dQWEA0CPGPsXVBVGl7B7hfGUUW5G/mK/hlpvkRpOuzwGXSYdSdJyshsEKkRc3uHbVG7Sdvr7Lt7/C+WKrZ5DbuoMrMH7gS0HT4MG3NsLrYzM8aSuQELScRFFQR34VNJfGG4q6ueVRKKNkHymVhTtQSgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11C2qMOI4sCJG1bDcd6ecENqRE9aP50qTOmOz3MJ+ZI=;
 b=g0WEyr3bks2HhiAXP7q7t5sRmhKikk52rMAP3ZyPY9HDV0DfhTUCsnEhv/5NEAR9KGH2QGbKigw0CEbKufWTvdctP/ws1FczvPyKHgj2/XvsuT4A5jy+QLniOrEhaiDtKCdcC2NSSjnT1Bc1yZyRUJINZoQmHEx44iv2QG2lunUOYAo44oXd7F9zjqQu9JU7FeCdC+fWSftYcZ8Z4CmZLNWgwkAIw5vPUUnflKGSgHgbFFHKJ4NuV3tFEYj7+i5Ag7V2cfOEVadj84ka0yBE3CJgBjVM70APro13PkbiZPjaAeXu7LOW0oqRvYN5KwsmgV46Cl+0Yhh0j3iLwwxEVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9121.eurprd04.prod.outlook.com (2603:10a6:102:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 08:58:29 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8445.016; Thu, 20 Feb 2025
 08:58:29 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/3] bass: Add checks for bap user data
Date: Thu, 20 Feb 2025 10:58:11 +0200
Message-ID: <20250220085811.5033-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220085811.5033-1-iulia.tanasescu@nxp.com>
References: <20250220085811.5033-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0005.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::17) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: bc1b6100-e2fa-4cca-21b4-08dd518cbe8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZIC7zbZiFHXXa0QQVXIvqRDEpoiR9u892SwMU2LSVmMJoC5hWH/atjv/NoG3?=
 =?us-ascii?Q?yC0vpT8luqKa9UaMkWqrcQgsE+1UEn4yIdAu31wxOqNcoyUKLJqg11rIGMCX?=
 =?us-ascii?Q?VkHkh5O+gZx7wjjyk4Trt/XTi9RpSE9evRQHKJe79OQkXK4UhIzwgToJS3G0?=
 =?us-ascii?Q?X5SqUuQbSMUP5FfanlbC2yK+uPy9KTP7xc6qFhgxUm/R1dcQqXf55wsr3nZf?=
 =?us-ascii?Q?l2KwAYlLAq8vDh9Y7ByXxsuvCjLYl6bewu894eyEYlv8gYAZNSOHAmJDBWpk?=
 =?us-ascii?Q?eaVi/0OSXZapzD6zreT+Azm3qE5iYcVljHJ00Dov+Ni4J1T+TBLyqN4fZIUr?=
 =?us-ascii?Q?ZDE9mf3NHry1j3TatHw43KJDTY5NgL6MaRC2ra6167MqaW2Nd+sjHoUDiKSE?=
 =?us-ascii?Q?Au6fkhIJGQpo45FQMGMtIS4KXhpgF1M4WJLtROSZc2v+KkJGVu8Nv2wKqvEa?=
 =?us-ascii?Q?dK3liNAwSiA7xXlGThTZSgqzS5YVE/glM8vEnIXd4DWy/BqPiYJqM6aMqyJV?=
 =?us-ascii?Q?IOnrk59fOJttAbzxdRdBE3z4BLp0KUxWZ6ZKDqI5FZoaeCREYlvTNc/7b++3?=
 =?us-ascii?Q?R2s/dxv3DgtUbXF65WhvkqaJE2iBbKgmFcwltDhFG1xv49yJPWisQ8VJM1Gd?=
 =?us-ascii?Q?grarBlGq/aV4JNMfHYD1+OAqBrcoRXmUAjnaCLRLoGPuWkbHWaq2YeROdI5Z?=
 =?us-ascii?Q?uXXmlIG2bFJ78bSH0YTkDdMX1X76vvD4Y5w/0z1xFQ2KduMdge/GTssNM8lG?=
 =?us-ascii?Q?+4Cic22vShO5dlpm4ySL1Eeyoc+TirKC2f3esP03j8VxmxwcKuBX8BCoAqxn?=
 =?us-ascii?Q?wPFANI50F5YYADDPkkxh7gv9BUMQ5DimVYC2+9rLBClzQtcnPbgR4jfhkWev?=
 =?us-ascii?Q?4QeGV0y1gQk2mLJ15fHNxFNxdBREsfl0SonK3jgGATPYUQl/zcgrOXreSwZT?=
 =?us-ascii?Q?ZA0WjJrDqwccR91+QXiCC+ge/VIPrhPJ+mywVedxNsozsMMDBRo946n8ZLlu?=
 =?us-ascii?Q?JFFg3NAwzi38d1NEaVky8Vwa+t8SWKf57JQlYGjLOFHhlbj7vr1W2/kWLIIF?=
 =?us-ascii?Q?oM9+3HwMcdgZxN4EmroNk4b1vD9cS0P3xpUSNXwb7Xh8Hq/9KM1WVS3H4QlW?=
 =?us-ascii?Q?yPnDiwwr4f5CcDvSiPY69m97clUai4Q2M0ZbJ6TZiCaa1RdmFq00PM8u0s0v?=
 =?us-ascii?Q?ndeRIYcLLA1D76BV7I59DtNt+HDFVZNvOwr+LJDxvoVZVlyhsLd2J1SDRKk6?=
 =?us-ascii?Q?YQ+IundgsF8OdaTu2oqy2qbt8KtKKeHfpwqug/mBkMk04x6gLbIkjQc4+VDH?=
 =?us-ascii?Q?Jf2ozAqWmMofL69lsENyxZKTeTtJXTNVEHuJJ7FFAyBqQgHVrEXyHbkWubs9?=
 =?us-ascii?Q?pX0AwUNycpOsoNmQlw7TbEVua7Zh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?veihDL5+43f1MIBIyBPMNSP2I2R7hfFDqadeuoUacEXy8sn3/Tisxt8tsnXG?=
 =?us-ascii?Q?75/dOLqy8tQSuss1NNOyezvf16TuXyEJbvKRQBXzrY6yalRCNPOuJQilzLwI?=
 =?us-ascii?Q?vUGLIppTERVP197neDwaDUCzU8nVX3FAnmTp1DM9CxEcfCuAkRcrOcgQ8clU?=
 =?us-ascii?Q?GJlRZvYDdSY2p9bCNvwvMmrw2wKeruB8snMT7+Eu5mESrcDOhd6r/4Hgze+z?=
 =?us-ascii?Q?JeYI057E2wgSWVEQXCKTvetakI/zdTVlAgrZReLGMefokWdnLAkG2OzVFCVJ?=
 =?us-ascii?Q?RhC5/uD62fohDZsAgS8DPiqa+JIK2kIcz1lf0k0wm30qe6hpBsRoIgO3/6Xa?=
 =?us-ascii?Q?VhG5KhTOO2aZCZ3BOn3+pazFCtbx8YX8lA5QmZZd0CyxEXh90N8sdjvHrZ6Q?=
 =?us-ascii?Q?OTyhLgIcHtttV4BdY/dTPHW2OcrZWMF/iOt5vmJlohIrYhue63FOd2cZuVVk?=
 =?us-ascii?Q?xK8dk0QLC5zkXvyK++Rhe8tps2/YzENYrqUdHWTUwGCdmv3/RucgIzv3Zdzg?=
 =?us-ascii?Q?tS3c2T0HeBxDHwID/CooruUbwwmRZeVefLcfD9JDYRzvjL1XoRIkWxeHXFjd?=
 =?us-ascii?Q?UqDwwB5xRGqpzV6oO1aLjcmgUTDQz/2zVS/JMstvfdtAxEsZqWhyAwQjU9e8?=
 =?us-ascii?Q?Ds1J7mU+uY+GZpItg4TToPxux8yNeLps2H2tLipMYhePPbMnoNqxCMhJmeqr?=
 =?us-ascii?Q?EBoHNF/UkV6mnou9fxZF/0pUhiVp/52KnVfSRntQbhJ4u6irke18gIMe5MZx?=
 =?us-ascii?Q?XatHY6qq+RS4xejg3z0TuowrpbTTGMKUuVwKqCgk8P7sVporaRrhbaqj78VJ?=
 =?us-ascii?Q?US4CNxQOIFzlaKvTYDuNRAdyfi/r+xyhugWFAejzcUoAAsiPMWkiMtLmdYxi?=
 =?us-ascii?Q?3BEuQ8j45ocuh7SGsjN0+OPYyKX2KIy0pBVl9Ltxx2GWaXBkHX5cEOcI7G3A?=
 =?us-ascii?Q?xXxc795FVFoP4N3h5BeBi7GIrWTNTrhr+lyBxvMtMskijH9pE/I5tSIWf1cN?=
 =?us-ascii?Q?S1gwY9us4hwxtRG1T9eD8CbRdGIPpf2UqxGkspJhdmEwkVeygimvFoRftuf0?=
 =?us-ascii?Q?96YwAC3jP8RfNwP/KLgAooQsFQum3IvrJ5uMDNtG3Qtpo/iTiZbeXgv7IcRl?=
 =?us-ascii?Q?s1gk3NHGhP8l96PwG02wGsyzQcC0e5RosgP3zylgQeertUfAXj725e1UW4yv?=
 =?us-ascii?Q?dsagLFtnbVJDyvwTEXk/kBLubZgWmCxyB+pLzaTtC8LmZj4fLe3+B1KnDAge?=
 =?us-ascii?Q?5Xueb5YukER4Rhwat/VS9pIrD6I45eF+d9vTZmFzDsHavDb1SN3x4t+24lUb?=
 =?us-ascii?Q?5SGGF8Do4VWqeFGxuVxXTNUdb5ez2tR/sIpY6GCBkPimiE5swSz+trsjjri1?=
 =?us-ascii?Q?Qj1WdZebkwYmT86hHJp7v8Jx1+Ny5q1FkTcXv0nBX+0h6ys60Rwdf6/N6zi9?=
 =?us-ascii?Q?351yVsBFY+ZgKBpi50mScdBIbxuTNbkxv+xwIBf5+JWUfbTQO08NqXL51FJA?=
 =?us-ascii?Q?sNDQ2RcchfnKga5BdhVys3FfWTiRD7tZRf03rKD6/LxP8ykOBZDldnAeIb0x?=
 =?us-ascii?Q?PPYiQ5nBQtEwhm5whX8YQSppMl9G39zCD7seWZo5qdP/souXQvwNqw1Vf4Da?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc1b6100-e2fa-4cca-21b4-08dd518cbe8b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:58:29.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrr+uFH1CZ3wCCEobfMVTSJd8rtr2OUFUlyEd5JX8DZkdzR6zg+1Y3/HaUEAbQSC4SSDNR1DHzag4Gai1SD1TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9121

This adds checks before parsing bt_bap user data in bap attached/detached,
to avoid accessing NULL pointers in case the user data has been cleared
or has not been set before attaching a BAP session.
---
 profiles/audio/bass.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 6c84fa1c3..67ee847b8 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -559,14 +559,21 @@ static void confirm_cb(GIOChannel *io, void *user_data)
 
 static void bap_attached(struct bt_bap *bap, void *user_data)
 {
-	struct btd_service *service = bt_bap_get_user_data(bap);
-	struct btd_device *device = btd_service_get_device(service);
-	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_service *service;
+	struct btd_device *device;
+	struct btd_adapter *adapter;
 	struct bass_delegator *dg;
 	GError *err = NULL;
 
 	DBG("%p", bap);
 
+	service = bt_bap_get_user_data(bap);
+	if (!service)
+		return;
+
+	device = btd_service_get_device(service);
+	adapter = device_get_adapter(device);
+
 	dg = queue_find(delegators, delegator_match_device, device);
 	if (!dg)
 		/* Only probe devices added via Broadcast Assistants */
@@ -620,12 +627,18 @@ static void setup_free(void *data)
 
 static void bap_detached(struct bt_bap *bap, void *user_data)
 {
-	struct btd_service *service = bt_bap_get_user_data(bap);
-	struct btd_device *device = btd_service_get_device(service);
+	struct btd_service *service;
+	struct btd_device *device;
 	struct bass_delegator *dg;
 
 	DBG("%p", bap);
 
+	service = bt_bap_get_user_data(bap);
+	if (!service)
+		return;
+
+	device = btd_service_get_device(service);
+
 	dg = queue_remove_if(delegators, delegator_match_device, device);
 	if (!dg)
 		return;
-- 
2.43.0

