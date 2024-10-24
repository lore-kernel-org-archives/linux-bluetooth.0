Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241A31CB509
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767801; cv=fail; b=l3hj4SMGA+1RhEGRgTDhXLLohCo4zWmXBqy3Qu4XH2D6KnSOh6Qr2f5jfi3qmvx0SNZVIjEx98cKsksLPX5vfSb3B5Er13L4wMuGy4LSJ+ECJTksN3KoGO8nxzlmEbWYBPioH1SLInJDJ1DN9U+OMINhSKONw9hAdHh72uuOofU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767801; c=relaxed/simple;
	bh=172d8i8/zHicvfv8mroJyrMbtl7MeOWvVjr2WBMQSH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vx9nH4IeBHIWf2o8ZE2StdYi+7ER+yZUSrucNp0+R4miXDRhyAsBOl+JFIz2iI5Af20InJJwIqxP79W0JB6B61px82ks+F1ZYfZFPDnoyWjHLShiYc30g6Nu8lpVYOjLiWzOI/Y6mpwJVTv2IQG1a0wS3yWO2EGm9RFtkhFcm+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a8g/E8Wv; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a8g/E8Wv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlBL+j3wug5x/cXKfchaPNiffVryJ3foXlIYEZpP5EghoZJZILbJ0bGjs55yxov9JylK1/fhiB5YUTQTZ6D4a8j8EbNklAjLB439ldXzan1VcffgqDydbD1vu59p7hp/SzFp4N+zxaBn1KYxefkvjM6pT0o18RQF6f4IdLJ9Lu5YQoafIEl7haK7Vhw7gzYmvAmeK+J4/yYVcAlakPKNnfTh1XzMLEqKilWWqAqMN5qY1OgIO9gNQNcg1jeKfL1pzbadoZ+scYUg4omLNlEwHzLOGXPaSAQrdotNmoPH33CE/xr+gadaSxEDxScrSyNLSXB2rJvXYtvYQqEvDzdtYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqvVCmP5C3DRSJ0975nWdThfMmLvqcPyJT8hORJkPrY=;
 b=hEfrxYuUjIY5O37m7j8FbgiUvEWV+qjyfMeyR93kjJNi1bCOVH5xa5gBQldSEIAEzE/rfjMoi2UrPUC9lhGpEYTs6mQKQFTdEpRPrk6tbb6z39Trxtf5OUM78I+mJKamA2+O42eliE2ZixSrvydlwYYfrdWGiln7WJ5Y0CRCNBdYhmZakwqlejgHK2AdxFEgHF9BzuR50PVWnQuya1FawDILCeCP0dufMI+g6N/ggCvivayImhXlyxMrsbIQjyxGnFiZHGkwYX3gXnNzaNtHTg6qu+hsqnFt2V5dr04ZbzXrAF7lKWTPJjh3/3K4DlPlbpIbbYiRvGyBN/INnfo8/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqvVCmP5C3DRSJ0975nWdThfMmLvqcPyJT8hORJkPrY=;
 b=a8g/E8WvbXoYlvH8OKJH4oxjCZyyLGyUtJHO4X9VrE3ZGhY08MR8X4Lk3qtAhiVC6kRFh3x2j/FRF/FxlZdE6ExHj0QVcOywWNhEVcXwh4q8bWvANl07XkSjw2+k36y0Xmn9iyvWfu8BNsh25soHzF+IHAcXsZco13oYVHChTxUsfLWZO2k4yp2US4AaNvTIAZ+jJJSaGNJNC9b/8m9AzcBod/3Ygh9ofhpKiBrlbcBUSic9ClNoBCa4BW+m9FiQ/TWazO9RihKVf3rqh4qwkr+mqZKUJBQbcWbDup3bXYEAHeVU0UZ6QaYDd5hblZXe+RzWNS4FwVz6quPnLPdevg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 11:03:12 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:03:12 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 12/14] client/player: Handle acquiring broadcast links
Date: Thu, 24 Oct 2024 14:02:21 +0300
Message-ID: <20241024110223.77254-13-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB9964:EE_
X-MS-Office365-Filtering-Correlation-Id: a0ac9f17-7f7b-4e97-9048-08dcf41b73c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TVhBvdtFNdA6sxx5NKuDevl9JMQs4pfwozwc44Snvl7RzoF46yfEzvHUF23G?=
 =?us-ascii?Q?LBG77xfK1qbEMPm83/7WiDRdFoU4BOyQxIjuTG+ZTr14HmttHY24JFq2verm?=
 =?us-ascii?Q?/eqXvCVgBH23mCunfjLgeCCutydMgs5wgWJ6ANsCHTTmd2qnf3N/vAkXQDzY?=
 =?us-ascii?Q?lPYrM591KDKYbxPbpFCEVYBjm0wvr0nIrrgsDJiXHrmsjIo9kt9WVU1fZihr?=
 =?us-ascii?Q?YuGdcM9g3M8jGwkInrPIfWGqNTgvlY3lkXk1Vo56/7x2CL4kD7YmtpYPILIo?=
 =?us-ascii?Q?RxehNaWBey8og3nZ9iTlkbGwB940lXFSPzUmy3I0hreERe9qZxupCrnpFLpf?=
 =?us-ascii?Q?IRq+Tw2/LPam/fhnfUDjFU6Y/cKbp04xSTD76YpeeE/POaW7aczlbh4hKSIR?=
 =?us-ascii?Q?pMJQMin1gDrCFPM/wttWjSr8W33W2T0EWcVklA8tIvoKU+hcuI1uWhxoM+Ug?=
 =?us-ascii?Q?wV8lwXzgXN3iBPxZHLV4suAYi1M6y3XhgKZJxgV1izjMdG5awjWO6bt1I22v?=
 =?us-ascii?Q?LMSHkUC5A0uPg+Ft0aM+0Jv849ectrtI9oQ47Yk+JSmTcjrsXp4Q8LG0JGCf?=
 =?us-ascii?Q?DDoH0b8c+MeK5yqIJEt+QToAVruCtQruCkcgku2sfCE7ZqUTCcsUjKTgod5r?=
 =?us-ascii?Q?FSC9yZr/lpspsJg61DCmFM4pvCNpHwrx5ZQCsfd09P7+Ppz54WILj0XzTO5L?=
 =?us-ascii?Q?m0Cnoi0JoDwnJJazIuueW3cgmqY8y5epHPbMa3Owdx0mX2XI5zzX7so8h/cy?=
 =?us-ascii?Q?3/8pUypkMFfGk1LKjtyMIZBgnG/zcM/DOAIVACnQmJWeYlp9ojegwBTu5YYN?=
 =?us-ascii?Q?vrKw1Dg+cS3h1uqAqc4kJ/XgwbWxuj2IJ4qeuqapfFUWX13ixE3R8tzdcsrx?=
 =?us-ascii?Q?4fzTzSHPOr8YTmKM59Wx7wILCqfDQlvjA4utSjUdnCBWAtt/SjRnMhxYFddk?=
 =?us-ascii?Q?Wd58g9HXl8XapwxoCHXf7BqucBxA9/Stz6Lakl5gbMPZYTo1xxen7TDKh0yg?=
 =?us-ascii?Q?/MuiyV4D/OOx6BcmXHbPfI7hUDeUOXmhTd1D+SfAHGKS9hOmpKS/lRpZMzJn?=
 =?us-ascii?Q?7SJj1l53G0rTB8SBfauxizhGiq5xvcMC9PE5U9zacLm8h/428oZApZGg+P2Y?=
 =?us-ascii?Q?dTZoEyE/5OhCCaFrcG6A+TcTZo42gJ3CO7JeJG+xWKZvRr7VcmTWv3JS0Eto?=
 =?us-ascii?Q?ElbiLUJGcqk8NJDbFBBFrCdWiWGuzrcI2GuMxK/d0IenZOVanw+sjBUEQOCI?=
 =?us-ascii?Q?lYF2jlWYl32Cb7/7NTA4EYrCJ9KJFG3PLMq3PdoUIsntUkX1FiXGHqVly7Zy?=
 =?us-ascii?Q?XeRF1utTEV+BTwMcCPG65AkwN7GkCYOfzJXgZ6XeZXAgOM5Q5Cuj7+JqGk9q?=
 =?us-ascii?Q?mbZeRcA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xe/bz6yQkjjhSWsO1crfzedNshCgeeyNKoiQnPnM/PR99ytTKsPpIOx2oX1n?=
 =?us-ascii?Q?cCjl67VVx7lmQdWNvIfy7D1YYtOkVZiszwg24dyt4N6DJlDIca3jEAUOfmjm?=
 =?us-ascii?Q?RjhBO4NN4HSfbMlGuokrSye/bLkAMVMCAKbvRXcroWARWO24bQ+5mkrIIysG?=
 =?us-ascii?Q?SgZsl8wdRhaC7QzLkBZMSE9d99t5RVfBklm5xbs3d4bOqPQmyL7gJvhw4FUm?=
 =?us-ascii?Q?dMZfyuZyvzA99eHSZ8r7AMy/qRwHdK0vcNu/WsHZpgQCGkocn0uvuwIofcZM?=
 =?us-ascii?Q?4DMYftM7a/h8YotHDuC0P8du1WDV6uITANlSCUwPolIA/t5fsNeFVsUwSJog?=
 =?us-ascii?Q?CfmHMU4/QJbU6v2y2I6xoqQKnIMLcFPNhm39q3/6WG1oHh9bm2nGFdm2Bc63?=
 =?us-ascii?Q?uanyI4EyzT8FHJc5FqUR+63ggATWXUE4il7y4ix52hKCwquQUMehNWRnGxCl?=
 =?us-ascii?Q?+JD97LIrZek5fA2GkW9H6CLJTissntVJAj+quh4fDw4wRaXE6V3JXqw/dY9/?=
 =?us-ascii?Q?kuDg8mHhZxZXpHF76NUrl2snRiwYaSyxi7yGYKFBzcFIU8BBlXkcQk53v2si?=
 =?us-ascii?Q?FNdDxGro5F4yIJqHdTMVdZxrtkZjHQq867Vh8+t0HPO1Kf/VZ5KK1DZVeDJo?=
 =?us-ascii?Q?XIfjdFQDbobB3wpAnJAq1jnhAk9SGqKk3A9BNM86/d0Yo769Oh9GrQV+FVb4?=
 =?us-ascii?Q?WhU6Om6ZaUNOHs6AhqxcbCqUZ2HfCuxTm12X53RBxIGFmfbRCvuqTah7ZMkj?=
 =?us-ascii?Q?rgRgE0kN/DRWS2Bx7qIK35pKhljQT2eX9/kRLZVl0G44VyQq9O+7Hyg65qMH?=
 =?us-ascii?Q?TKdmcZFSIuHtsSLlpE+pSfKIQMk/bo9+nZcKEttFTkZxfkFgi3n7HLyFRFoJ?=
 =?us-ascii?Q?1e8mHy3+cMEM4x2gdykbhWzRiXdzX+SC2xuwWG4d8vry0Qm7EUo1Cd52g6ew?=
 =?us-ascii?Q?S8xBQJiYYCfbPtZUY1ebvXQvhNmKjbAtBA2Ry5ycMetf75NcpOdy68/Fl5ix?=
 =?us-ascii?Q?+lsGRRZO3aywgFx1TdRTtN/qDwCH/XLcrzrGnysZ2XnrjjCyT0QTkeCr+S8P?=
 =?us-ascii?Q?YzBhfhBW2aCn10V5YpF5SBPuG47DhicHOxK+Jrq7RPmTpn70azHS+Lehjcqz?=
 =?us-ascii?Q?V0z6xjXgRC7LG3WL3PTzlMRgv8e/GkbaVH5cnszRg69ueUuvW9AEBkFbqd/m?=
 =?us-ascii?Q?QPYVKjAGrr+jRCiEBvu5J9C8DxU2j+zztyo0AcKB7/Vy18J4l5/yKBnqJzyl?=
 =?us-ascii?Q?w066fysYR59S7ZjHkuc6h7hY9vofViQNNLInGF54HdGqXPM/c6xflNrHri2W?=
 =?us-ascii?Q?OVta3QCezgmw6oZ4txPJcsjVo9+Ju5zI5OawiCHVb+w7kS6xgf9KDH9fr8nM?=
 =?us-ascii?Q?eFFeWQu8b6+FSSqmGND5cLOP9YJ9+yNPZflzq/3Cz4v771dxGzic11b7GJkj?=
 =?us-ascii?Q?z6Y3wJkuxQHHiVfm4L1VX9a8Cgrx7mE/GOrK8IsA2DqVUCXlcdfPvCt/oHtM?=
 =?us-ascii?Q?3XHM5CHqoF6Tpe99CDQ/PjmTll8bgYUWpn9H6qwsx1y7JVhfG5G/jbUzK/kr?=
 =?us-ascii?Q?q/dzjszjkzr4ZC/InDsDR47iKflmVFj+MEkqK63yZ5hE8QYJS78jHG4w7lHw?=
 =?us-ascii?Q?bg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0ac9f17-7f7b-4e97-9048-08dcf41b73c3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:03:12.4572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjlIJW8FZCkj8nILlY+e58ceBG0XN4AAo9kHkdCZ0nlL2klq9NNa1IyIghgs6e7EnUCyWXPgzjghBXGwTJCRBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964

This adds support for acquiring linked broadacast transports: Each link
should be acquired separately, unlike unicast.
---
 client/player.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/client/player.c b/client/player.c
index 188378175..81d967a28 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4812,13 +4812,15 @@ static void transport_set_acquiring(GDBusProxy *proxy, bool value)
 
 	ep_set_acquiring(ep, proxy, value);
 
-	link = find_link_by_proxy(proxy);
-	if (link) {
-		ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
-		if (!ep)
-			return;
+	if (!ep->broadcast) {
+		link = find_link_by_proxy(proxy);
+		if (link) {
+			ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
+			if (!ep)
+				return;
 
-		ep_set_acquiring(ep, link, value);
+			ep_set_acquiring(ep, link, value);
+		}
 	}
 }
 
@@ -4919,12 +4921,14 @@ static void transport_acquire(GDBusProxy *proxy, bool prompt)
 	if (!ep || queue_find(ep->acquiring, NULL, proxy))
 		return;
 
-	link = find_link_by_proxy(proxy);
-	if (link) {
-		ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
-		/* if link already acquiring wait it to be complete */
-		if (!ep || queue_find(ep->acquiring, NULL, link))
-			return;
+	if (!ep->broadcast) {
+		link = find_link_by_proxy(proxy);
+		if (link) {
+			ep = find_ep_by_transport(g_dbus_proxy_get_path(link));
+			/* if link already acquiring wait it to be complete */
+			if (!ep || queue_find(ep->acquiring, NULL, link))
+				return;
+		}
 	}
 
 	if (ep->auto_accept || !prompt) {
-- 
2.43.0

