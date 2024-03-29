Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2104.outbound.protection.outlook.com [40.107.22.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3665611182
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726828; cv=fail; b=MLLL+KdFuDwm51ODQGuyA6FDdFqG/UWn1oN4X6aNDQ+ER81ie5YcslvAWm3StQA/8YDGFEoq3yKuMWFWx+pXSP2I91V8NLwe5c3BrplPzApIg7vBIeOvWY3Seb2P0v9zpVUQhOQmkznlUDGp9Xpjkh+NZ99dbIvvQgKeYirSnsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726828; c=relaxed/simple;
	bh=nbATSajLCulzJFuA1+HFf6l0ht6P45SUrBuhptqHQN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y6dhn7vT/SoQ56nuBoMHpPbtWaxR7C+M4Yf28q5NxvN2a8xzbLHKf8qtumQF50wnl5r7f9hbPqwFj8wtqb9FhTwyr3DesK/JHe05hQL9Ure/LpsSsJXxl2a/iMxNpRKxce5jzvuoT9CIFa/DA5H/zu5MPuoUm0XwnDwSN97UFx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=puV0Rdva; arc=fail smtp.client-ip=40.107.22.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="puV0Rdva"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RexhTalOd2BGxpTdX8HR+vWuhIicLaGe2+UgCJbwxzYYE7STk/LKZCUlEuHi0qCTlx4N2A9Qsy2ZhqGAOyHp5/WURFhqx6lMO7w5wJMPesfdkhw6GChP7BCPfORgeKvel/HQ0IjfcYqyaAok+UKO2ztlR2uDBaxtOtXQ7cJ0CBTYBys5w+NbKmaTkmqGuTeZGL2LpnbWNs2+Z5eMrPOpO6kydvZJTgfZBVEDcsS+m3e9vLGiqbJqC5ZVgHufSbwxYotQ8TODyvndcK17MsO9trXreHINWND97l/wRcGt6ZmwCtW0qJdkJaeSTp8pCBAHs2Dd2dq4eV8liD/IEvu2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Oa4zqzRKNEI58z77CYYcHfu/jzzp1xCicbsATLhYDE=;
 b=a4/ZApRESRPRv5ttp+pIydTKxVo40ery0Sxh2RxecXWb55hP8+Zc2a+AW5lf05c/j918tW1yQDLm/Id4HrUBumagsngQHH0F6Ms7B3Uekv3/eTz4MKVBkuchUEl0KvwJsSVcL8blK0204VxPZEC55OniJnfZJeoVSwUjQCRi9Cxg/IgWYxd8Da2480sSRK6TiGQTk2rC3kGl1OorNbNCDQHZIhCcpo4mKfqTZIilvONiHHRfKq7j00tOGB5k/LF5VG1icvdOwW2dikFFay+yZdyQ3UMWZYita96pgl5RDhXmfrxzdUyuN8nu1SgsKirG7mO7MnerjvmkIFstqW14Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Oa4zqzRKNEI58z77CYYcHfu/jzzp1xCicbsATLhYDE=;
 b=puV0RdvacbRaScqoL/YJeJL+r8vZia59zXqmVKMD3nqwY306aQ/maHpytuzCtNkg2h9gEh5MxSAUnKCbkJRFB8amoBolnIXoMsZCvt6XPV80VIWbTcXSIs7TuTU/uwcnChcqbZLRkWhdt7eK4rXCiIIrGi6kNhopo5sgRNn00BY=
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by VI2PR04MB10222.eurprd04.prod.outlook.com (2603:10a6:800:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 15:40:24 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 15:40:23 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] bap: Remove entry of deleted device from bcast_pa_requests queue
Date: Fri, 29 Mar 2024 17:40:00 +0200
Message-Id: <20240329154000.6056-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240329154000.6056-1-vlad.pruteanu@nxp.com>
References: <20240329154000.6056-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|VI2PR04MB10222:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8IVxY54WZxKU1NaJ4p61FZdSS4eLVjgwC0f0B03AeeS68NbQzGzHqt2P8EAtO2w444qEaXaYYx8XHTZUKSxgYuYeU/M/cQytLsQwjpGW5xTMMSzFsr2U3OaYCdSvSRir/c2wUH/Qa40OQWZpIGY8Sxn8xeRqgBfWaTFyhibQPLkDiTDgPBtT9qwybvrufyLbuoiGkbodpoEhoYYHXYsNQuOfgU7ERdsUSKek5RG7GumrBYSQx3LqE5gcyo+rqqZN6pbQGakBjh1gq2NqvzNb5iLYDgVuO8TVfI3nxCmGTU33ypw1R9L653g05LMrBrjhAPQK3HUhs0XoWUHSO+Zaqx87fPL0O4q5afbPiWCioGFZqDYiDn7fecJTS/ODB4SUJ6s/3rwRK/11O5urhkC10PWXYwXAA0rPHHP53zeDi6NWgNds6mz7z9NlI8X/aVjrFAl6FVYKZ5K1R0919+me4cfpNM6QfOuoxV+NYNS/Ui2egzy0LPK81+r18P6SsMVDZHPVSh6VkxL9cb0eUk+b2SxNdFiN0ZHaJFhtiusIeZS6bzgyDC5GZgYECn8903y91l6xKUvoQ7kFmYBwTydQSY78/ecf9PDAjOoX50NGgse+MbPcGJwDFtAPpc3gXW3AobwujX3GsQ1DvVe029W5yIODH+7wN2lsLq0VKv7bDdjVd5pQzHg/nAzj0QHtfeIDJlqo0QRSH7QouoF051HBpXXLJ4fQZHB7x5Y2BO07oNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OTKa1/O6gds4MfegUlcEZUY6zZXRuaHsHbUtnKXTL/cxA/egXcbcxUz2aDj/?=
 =?us-ascii?Q?Gk+5wJYzXEmlaa7GY3g7j+4iGPd1P7+qLRFwHpTQm82wqju+31zA/WWZd10b?=
 =?us-ascii?Q?cO4/Q237w5/hfrarfL+chgay/0XGAZ1fRe+QDQPAOW14ihc0tkm5D6Iuf3TJ?=
 =?us-ascii?Q?Cy/m3mFOqz/SdErBb5ylbaSticG8YJhQPruKtDhLOSBHbiIha11/V4UAf8f4?=
 =?us-ascii?Q?/vHfBhQDlct5rueUHf+RHHn7688t6o9n9Uoofopi1fknHepqyAOzvEU3SSE9?=
 =?us-ascii?Q?/TWq+fxbruCwx4TUMYTiznilnEDLoT/flc0QIq/9udymKXLhyggPvGyFyIf7?=
 =?us-ascii?Q?o5TsnaeqVAwF3UYXqn2xWmQAP2XIJj0X7vY0fuCohlcUq3pbNsH0LoZohiXX?=
 =?us-ascii?Q?QmUnXil0fTo6wZL2jbkG7bjb5Gr5YsCDXuKZPgoivOOynkbUenWfD9KNKZ1p?=
 =?us-ascii?Q?dzwYDCSE9cGmR1td6ZJ2braIbPCzJG6xBdLAjlv+tmhalIHLYLwOlLIrVGzg?=
 =?us-ascii?Q?y2s6tel9UQtvapOlV3NRTOjKNg9/HqaCqfMhavJky9kC+/zEQyiBTjDZdjqI?=
 =?us-ascii?Q?2G1eK1ZOOI+jIj+gxZz6QwX5Rk/QnNkpowbHjffjEEvx7kifVwkKXK1/n37e?=
 =?us-ascii?Q?jK2+UaRj9+ZcVarEqG7yBX0hy7xav0hK88v4Q98WV/7usrlcaVTSw2EF0Sci?=
 =?us-ascii?Q?547llF/FCccnJTC2KfLHtAfzHdUJQCf0vq125dFN6pQZ5cLekFsKrCToCKFC?=
 =?us-ascii?Q?CLE2MmOt2hOq3NpCyz24Fc2ODnviRwmafV0W2bMBtVhwwDaG6JWg7rJHkl1J?=
 =?us-ascii?Q?yNd8KTwf4jcQstiq8NLIubmA47Blx5AilPi5Eq2j20ydvEgDxB5mCMS39exD?=
 =?us-ascii?Q?FQCG743HXRaliWOwnk3JlqFpgOrPomB/jhbaf5cQlXn+l8Fe0XdJNsE8T86p?=
 =?us-ascii?Q?8BRgV71kL3SOEx4rRCVi80mDLd6BTzIYtjTjsNbRJnX+cUXM1d+DTAtKA4rW?=
 =?us-ascii?Q?iF1NEPBCIUp0R0EtX7eMMwhymwAX2H7K+wYoQnnlf5QABNOOBRL5IR1JXAyi?=
 =?us-ascii?Q?XwvXN6eIYia7LDhG8iBB+FWaXCLc3srvZLqP+cqveZvNPwCeZmPZYOlyYwgA?=
 =?us-ascii?Q?6brdpiN5Fuc+htcA6rdYaldFnPBrFQC3dl+sxn0y2VxOpRGZYhgTd4YCJ1GW?=
 =?us-ascii?Q?HUbsHlNepqs7PMkVt53Z7VTJ2mxS8hs4GUbizu83lrbHObkcb/GE3tzaDn3p?=
 =?us-ascii?Q?DECr5ozoFdHJdv81YQ6elgDOgX6ieD+2tDfMykLiixaCJ/KZNEGui+iEfq1o?=
 =?us-ascii?Q?Vaage1YCECE2Zccf0+adNU6pGOnsFv8nwOGUsmYwAZEBNOsY7K1CKhW3cGpn?=
 =?us-ascii?Q?ZOjZ1NbnUZWypI2r2YkHZuEcBXmG3r4NiQ6vyL6OZV+lWq5+CePNz3Z22MG1?=
 =?us-ascii?Q?nUr+PLqiApvmlI2jKm87/KNEDhhcSCD+DBlkERScYIDksHy2DLCCC0wyZ8B9?=
 =?us-ascii?Q?Fb2XYr9nvoi49q+L6k6ImKAfo4lEqSUGUMGopmuhE1e9nt+Kau5i3t910Vd3?=
 =?us-ascii?Q?HAjJbwi65KubYYl8GqMdSuh7rIjUqpLRxL3W/qMz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15fda8b3-69ee-4abd-1c4f-08dc50068c87
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 15:40:23.8780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Jpusf42qAsEtoeBlHT0AeqtbnLAOFaa7aBnjdhj65vXqUebVLSj1rW9RQIq2gvCqLrtVgD5GJJgQ4IzWSYriw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10222

Currently if Broadcast Source device is removed it's entry in
bcast_pa_requests remains active. Thus, if the removal is done before
short_lived_pa_sync is called, crashes such as the one listed below
can occur. This patch fixes this by removing the deleted devices
from the queue mentioned above.

==105052==ERROR: AddressSanitizer: heap-use-after-free on address
0x60400001c418 at pc 0x55775caf1846 bp 0x7ffc83d9fb90 sp 0x7ffc83d9fb80
READ of size 8 at 0x60400001c418 thread T0
0 0x55775caf1845 in btd_service_get_device src/service.c:325
1 0x55775ca03da2 in short_lived_pa_sync profiles/audio/bap.c:2693
2 0x55775ca03da2 in pa_idle_timer profiles/audio/bap.c:1996
---
 profiles/audio/bap.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 52a9f5e00..8953e9a57 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2907,12 +2907,23 @@ static int bap_bcast_probe(struct btd_service *service)
 	return 0;
 }
 
+static bool remove_service(const void *data, const void *match_data)
+{
+	struct bap_bcast_pa_req *pa_req = (struct bap_bcast_pa_req *)data;
+
+	if (pa_req->type == BAP_PA_SHORT_REQ &&
+		pa_req->data.service == match_data)
+		return true;
+	return false;
+}
+
 static void bap_bcast_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct bap_data *data;
 	char addr[18];
 
+	queue_remove_if(bcast_pa_requests, remove_service, service);
 	ba2str(device_get_address(device), addr);
 	DBG("%s", addr);
 
-- 
2.39.2

