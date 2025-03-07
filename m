Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2077.outbound.protection.outlook.com [40.107.103.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7C21CFF6
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Mar 2025 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362328; cv=fail; b=VlCq/yN9wcdUoPZu3uUhrbuZ9ZMyXmn6VJ2ylIi4mce308sw/0ZdMSKiFAv0ihmn89/roc4HMHGELn4hwjHkbR7csp2goSoo9eGqpZef+O+mKPsGpH23nB8ItNVtIX9cJHvdAxGfTo8VUJeEp80YEZ5aCMSKh4uVgGxIQETsWLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362328; c=relaxed/simple;
	bh=NBe5WR+yHTyjIBQN8P8nebp7Y0EDMlyxKMhS69zUoM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m63o00V1VTigAF7/NrBlY+fbIAcjc+x05LbBEHhOr9azCAyzu8INeBalId42jHhLDL7/xbzeG+voAn7UdZM1PNoHUxoBSn+qFZClo+KCSOFmxQIBslfRDalqb5KZSjIjWo6wjBeXB5CtQcgI3Y2s4K6K0LT9aewPtNzmMYJiOWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nCPeJY17; arc=fail smtp.client-ip=40.107.103.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nCPeJY17"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ud+99hxC60a72FblKxquG7vk4CSt/1fU6jQJCGZVX6bYcLi+21TIJy8U8lflzCnWHoMySmJ1lOjl0m2KbvZtdo3jhza5fNyOd7kK7pSAYNqLpPr/Kp1DfY1+96K83Q3Zvha8QBltQVzKYCQNtZTh3n9W3j3Ff9SGcKHSbAhHBvsXD5CxhhgdYikaTLxL78/0TUfvakdU1I6pjV+Dwyn+203VXik5lFsdxLw4naIt6K2nAcbeyVmJ9z603GeokZR66kshO4BCNmKfTdOfquwph8FAj2HwvjHtkDovSX4/yil1p0VHNAZaGzc9ugEzhZ9c+mBFmuvJ4dV/F7xoxYKx/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klzS54mPzDu5VtpSQKpaLaDymBA6DTOaeg36c55yhvE=;
 b=FknDL7yuLv8LUrLmMC0sgY3Oo9P1PiMLvKMSodghe5GedUKPxsLh/qu7DH5yyn7qUgIPlOjNXeApTP/w19nqx8oA3ScU56DWcvGFPv/zkjBy34buI/D2OWBoR/JR2MZHUvbnxpLPBCcIsSJ35eAL630GySBqxcLqnzMP2/hWYSPsa13BXgmfWKJjn0zu/H50RhCzxdAYPKkqypJbJszWIzCdWdaa7yj07LkTEo4HTAFHPtFm4nBm5NEC/FVWHOomNrlzCUswN6De/nG1R/PcVSnLcwyvGCKv3oNorVuqIZ32RtgkNAnNmjtG9+Clmco80EpT86cFbqRgQ4uJbhETEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klzS54mPzDu5VtpSQKpaLaDymBA6DTOaeg36c55yhvE=;
 b=nCPeJY17B3KNOJ+0h5D48KaI6wylDdYUnLsPQZf2xCwnYC4uhY7KBoiwF7wwMyelFEmx0vguNKooX2ID+0Xw1aENDFONxxMT+sxaHZmWuILVbc7i8ukLmqWeBfy0uOaR+qwfC/BLwgc7hbIl9M/frJwXnj9CE9aR7xSTa/i8AqYBcPTir8KstiEdnblrEpFsRCMdc8EvDRmFZ2X4wE5AutxuASqoHE9O03aKz0urnXxCW03bNGpmFMEElLSyU/6zPk93bgIjFEVkb948bQOe3sG6asWFnI2nnTJrScGR5PXcT1P1bld/iAiUWjyI7C31yfxfVuik5T5sa7VNZ4X7Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Fri, 7 Mar
 2025 15:45:22 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 15:45:22 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/6] bap: Remove bap_get_session
Date: Fri,  7 Mar 2025 17:44:53 +0200
Message-ID: <20250307154457.85751-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
References: <20250307154457.85751-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PAZP264CA0117.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1ef::8) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 82ae9d02-cb36-465f-33c4-08dd5d8f11f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9/N+1KcbdGz0irXZ2ka2W+G6QOQXFWG3GDiTqzHGStIQyQ1hzsd1M8YDpAwk?=
 =?us-ascii?Q?dTnjPOdawr3DbDyOeyAY/1gI3uhRW6UtZg4WbuosmXnlIDTeHW/RO1CJPJ1/?=
 =?us-ascii?Q?LecNj9/0uqAMIKKr2uHQ5/PtrrlxuuKR5qALymVDPCgkJsz6qdibEAh5Owu/?=
 =?us-ascii?Q?rw79XO0Hcr9NyqxTCBPaEbG5MZaB/KdrrLGSjuU+nDyuAzonRW+bIN+4AaUi?=
 =?us-ascii?Q?+pzB4rr5RjLA830Bfk4vV7MrI7Tt2uoMXiilJUdndRqbv4y0G7KENYf18NA+?=
 =?us-ascii?Q?j8QLQmZGjAxhq8iIRMtrTlRff8sok++SPSgpCI4v+FtUxGOWs25bLj1LwGSp?=
 =?us-ascii?Q?apZnQv1jbKBm0hc7h779o7F5D0ZP+WZKVbocL0jFV8WR7ktUGZdswOL3Oo0d?=
 =?us-ascii?Q?2g3jb+79SWUDx53aVW3bNbAWHn+gYOsASAnopCPy7U1KuzW9wVhqCW6TdYqF?=
 =?us-ascii?Q?EM+T1r9NfoqC907zxmPZ9sCHRoT/HEuPqtsiayvTteHStTCDjZy/bIUtV9+G?=
 =?us-ascii?Q?UXhwlwg1f0WfV7mezIaj+tLmAbj55SRwF1alG+ZAEOfbDcysxtLPTPBnSpXD?=
 =?us-ascii?Q?Zum6b9ZKtOnjsFKmuyxUMo03l7/7W/7Y6PYRPf9Mcr1LaBvUQItjdm5xd7r+?=
 =?us-ascii?Q?8vDo8c0Gt0sSa+F6HqeJbd/7JpuS9dgbVlPrXdPOOlgBAoWXwI4SPLssqRi5?=
 =?us-ascii?Q?s0ACrQYniJPZIUZF/ihRxMqdP0hZBcMHEtX9e0b9KqYjcLe80l4Xvkzp1XKJ?=
 =?us-ascii?Q?Ok/o2Teq/23aWm9FRVGfI3/m5dr8KwH0D8dRBIMohqtZKonipNVO/8vQnq1C?=
 =?us-ascii?Q?dYMeP/19A4T8TKKy/5lsckOSN/ktxwJHafzrGBUgub/uWu+hNf74BqbMfGbW?=
 =?us-ascii?Q?XOkDgYfkPJ3GzJRWGppcYpdHlWR0EYurqqLd5hFKw7pVDxAVHdkDqHYemPPp?=
 =?us-ascii?Q?9/HG/tJN+ngslL/0PVO8KE4s2VRcgOX75BJq+rWmK3mFhH4rICUB27Gbn/gW?=
 =?us-ascii?Q?hnvDpk5guM8GQja6StWT4cBc8tcacxChcgDcntzlcgxluEi5HsysdVvzNmyu?=
 =?us-ascii?Q?ZoPXQyTYM9rZKbeZ0Vewssw3JcAofR9vhD8TRUSbtf0NxSSSPBsZI1yE0iVL?=
 =?us-ascii?Q?/Eynol5qts5Y88GVEHfvpS5i3Qv/IYv8xzl3g9HXNgaQWcWuFj5cKTiIKNAP?=
 =?us-ascii?Q?ctTa5FTwt6EZnGwgWOzJr81wkJJa5GEg5oDc1bP8+uVsgaNOlaBlNvu25m04?=
 =?us-ascii?Q?ut3BQLjRoGon3xUDwVsniYfVC/L+sJvTDPaggFjB1mKhvig6aG9gAVxX3U8Z?=
 =?us-ascii?Q?Ga5bp46EBlQ+iKklMbbz01Pq5hR18GQGIq2UxvMPFol9gNdltHPD5XM3amm/?=
 =?us-ascii?Q?hW5ASfK9Nvtu0kZIYwqIxhMbAAjh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WDbuEDxSyGT3p6RV5Es9v4CaoJtD3XQTSDYB7KCmyHBvrE5dUwOOBmSAlnOQ?=
 =?us-ascii?Q?twtdrR4Y5aFu9Fa1TDIFnNdZFkCUB869qVJ48ruI16w1EylQiNfHqSFS31EP?=
 =?us-ascii?Q?CgChH6g7WPBFeDB+RjKwmNMYjpJt1HmC78a8baZDQCue71SqeMQi1iObfjT+?=
 =?us-ascii?Q?Xf6sx0t6J8KppuNGWiCroNg2NmKKW5pmfd0AuG+xcrPwSc1mpOPvbX8boj3P?=
 =?us-ascii?Q?h9bZmUsEahoiIZzmyc+tZ/2kzu6RIwzbFZ1QOg/uB1HzmsIUGUSULqJde4FI?=
 =?us-ascii?Q?vZLOVK7iV1jkRXLsWpJD8vjiR/ESs4xh8Y442fRy5qjkxNiE5G511TH56Juz?=
 =?us-ascii?Q?cgwyJn/aqKuwqE75nLzvPpC9VNZdhr2boQVLQq+QyyhczmBAP++aBqljagXQ?=
 =?us-ascii?Q?iOBE5NPNyRHUfTuSU2eusbQXjZ/kEJb3xDnsFa9W+ttdPsH0qzn+4T0toyG+?=
 =?us-ascii?Q?pnzlvoun2UZ+9XFh+kKpYa4e6jV9ltN0OJuuI/v+iQAOI2voJ106PfeP+y+H?=
 =?us-ascii?Q?VUdfYnJatDiLnjUV34W4Ro2raje8UN3QZQedNV5Gyr+Gi5Ie3eLFJdoA/suQ?=
 =?us-ascii?Q?Ji5g8Jjs9097vOpTTKw7aD/DV4pmdA7Zrq3jviVedZwbZjiqWzKyg34kAb/N?=
 =?us-ascii?Q?XfDCFwMkp2+1w2Qzw3XoKJ1jSgX5Afm9sHBSiE+Ti2LdZc/xp1J0B/RICt3K?=
 =?us-ascii?Q?LSheWSeQY37/H3HqkZ8uBP7tD8J4gb5zRPSfr/xd8a4AZ0zontxTxgioal5r?=
 =?us-ascii?Q?FDmr6UISGe2EUAa+ik0j98vpPlSn0FqhJF+DrYkLJAXsESJ65/yNZObHVIpb?=
 =?us-ascii?Q?tpqLera2iaO9gaOUwV9v84+F8Z5W8XReMF5okCbOogoCZFEFZ3VagVXxKNiL?=
 =?us-ascii?Q?4gexcO5js6NCY4cFbNcdU+VcjSHvkZyjBR9gsb1/GVey7I/YfsodS4UFchbq?=
 =?us-ascii?Q?4gU41RpUChKxzFmxegCtns90jrEiPzC1cweCxCg0QFYSf1136hERRd8SSc94?=
 =?us-ascii?Q?wncoPQ95TE3DHlE8pbzlLo6wScrxRYiOHgh9ztFLZwfV/wmW5LDcixMqaKBw?=
 =?us-ascii?Q?OrIQJp2zxWMBHaJi0R5Phxd3iLCHuyRNX07ju14suaY804JzMYzFJY1djaOt?=
 =?us-ascii?Q?P4SBqsesU3mjN6/xgRYq/d2d69FUHwJ72hG7irtB2eHdN9UWoDsesKGgrjuu?=
 =?us-ascii?Q?8W0IKnm/v4EOzs71al2EJKeWV/+vK5ohPN6D4lN568Zpjxh2DJkMyWjE34Qy?=
 =?us-ascii?Q?XFBqq3pTHbaVgoohlEZWALzndgjaSsmVf1Gbl/UGzbWaErL4bsOg1ZztYgnv?=
 =?us-ascii?Q?PWLyX9+GwZeTf8dGdjWZP8HvEcOqL4ocQYn3U4ncQcz9QMkGavAXZoJat8gX?=
 =?us-ascii?Q?0yvelcAtwQ2Z4PEQvXnm/63SciNSF8Sa+Ll1IfrMIvjOeyJ3fOV44Mrpz3xo?=
 =?us-ascii?Q?hLX1dHAzDLlwb9DyOhtCvdWmYzOD76SSS6MRG12BcAZltj7V7b/+2kBnEjZh?=
 =?us-ascii?Q?EgozEtkCMLcN2h7MPeQZK86VmGAOS1mMgXo4yQHNCY+wK4kCiv4pa0vtj+Sb?=
 =?us-ascii?Q?XAxK2RNWG/hGyw/FPI1GHpBqdXEQqiNY1MXvCaPCE+N2uE1WtVtwsa7RbaQF?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82ae9d02-cb36-465f-33c4-08dd5d8f11f0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 15:45:22.0124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2n7B2iviPDNgkolWzwxagL9A0lcAru+wHatO5N36OvW8rtKSrEBYTlY+fgBSaMJrxaapx8DsMW91nt/vZpgAUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

This removes the bap_get_session API from the BAP plugin interface and
replaces the call inside BASS with the shared/bap API.
---
 profiles/audio/bap.c  | 11 -----------
 profiles/audio/bap.h  |  2 --
 profiles/audio/bass.c |  2 +-
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 0489f6655..0dc5b4004 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2708,17 +2708,6 @@ static bool match_device(const void *data, const void *match_data)
 	return bdata->device == device;
 }
 
-struct bt_bap *bap_get_session(struct btd_device *device)
-{
-	struct bap_data *data;
-
-	data = queue_find(sessions, match_device, device);
-	if (!data)
-		return NULL;
-
-	return data->bap;
-}
-
 static struct bap_data *bap_data_new(struct btd_device *device)
 {
 	struct bap_data *data;
diff --git a/profiles/audio/bap.h b/profiles/audio/bap.h
index 522072340..554670d4a 100644
--- a/profiles/audio/bap.h
+++ b/profiles/audio/bap.h
@@ -9,8 +9,6 @@
 
 extern struct bt_iso_qos bap_sink_pa_qos;
 
-struct bt_bap *bap_get_session(struct btd_device *device);
-
 void bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
 				struct bt_bap_qos *bap_qos);
 void bap_qos_to_iso_qos(struct bt_bap_qos *bap_qos,
diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 44320a78a..6f68b80f3 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -1113,7 +1113,7 @@ static void bis_probe(uint8_t bis, uint8_t sgrp, struct iovec *caps,
 			/* Only client sessions must be handled */
 			continue;
 
-		bap = bap_get_session(data->device);
+		bap = bt_bap_get_session(bt_bass_get_att(data->bass), NULL);
 		if (!bap)
 			continue;
 
-- 
2.43.0

