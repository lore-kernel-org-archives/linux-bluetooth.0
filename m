Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0823613BC37
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 18:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550091; cv=fail; b=BJoh9azVWKqQt4CUrw60N6gMw6+dSg5HOwIA700r3NySAapTW7cgVeTCRQLqFD39mHiW//mWZNkZ1vT7mJ6x2d9R1n0VGJ/Wt9uuuCEH1707AOJO8PqLxwOEYWYtfKjz43eMBd1zXXqRZ947Of/r3T/EO6anLTFtvUhPz1rlZJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550091; c=relaxed/simple;
	bh=VWnUxMoA+a17nkbOg25taYBD1jlQPmJbpFjf5SMSStA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QGiedsAslGu3fAYJeLMCTsVXTKunc8x8Up6jwhxrBSo0bNm6HPzZdI/MViNfA+ZbPhLKPQJlXghnE98IdNkighnzyH5fPmENdGAr+T3KmxYcHE+hcQ/rEnTiikcbN+LIuh2txmLuiwOIPl+OGUKkna1YWbK9J7Qyd6+TmngB54E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pgtuiOyd; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pgtuiOyd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MyzGe2OI86lQKe3573LeZp/EZf69dQZH9zjo/lOZWt+jLV9tmdW8BtWJfDGtylgNaEx82uhtro7n/4wMr57cTTvAr7H7wfdumgUL367ck/rXLAuJRENDncmxzxIMgKKW3AT6YH9s12M8JC7UjxnHKEzWFikwmTZAY6pGJMrjVGDtsPPImW2OTA0uJU3j0/4oiVi7FY8HIY2uNLy+U0uPevHSCaUq/qjwCreWTZHwQYX3w8EDoJAwOGWGSlNRDSQ5ZWLDjJhPQREyRWWwyHKrHf/s1FX5SXuspO0IVQKPmbn6FKtsLYMFEhNl8XLtzmqKwIA189sPRiZ6hjkrbitEmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zVIfJg7ks9P2uyYIlFfEPRR2GWX9WMRZGAzSy42Jwk=;
 b=FFrIdmteERS596jkKmAFp3JziXeIro5eFY8SwVyogWinUoV4eKWusbsy3SlR5UII9r8+CnLrmzvjsFKv+gN9fVrNy7PX7BerN713LdkCU+6Q9QspXzo6aq3RNlzgfDFFrKnROTvRcIPkj0Iehi0kIJDCweu/NowD/mIDk2H5POGCC8XofKijZoRBO6kG2MrVqgoP4Sj8KXdrL5x3FDf4jiFrKqhAEIJrGFIDN/qtWq/aQTZc2IwtAQTt/Mvk98xJhNLlUB89ay6FUFAZgVceRJW+wunQp8NiysdlVj0Kwjy+X2Ft+6XFvWZxyr50DYNxb2hV2EpgKbdh+L9qUdahMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zVIfJg7ks9P2uyYIlFfEPRR2GWX9WMRZGAzSy42Jwk=;
 b=pgtuiOydibxSffRDeG0ezSKPOt7mYVTb5qXRdnpC3SEPrnLjDKeFZ7BTr6BP39q3XRZ/nETT/hcI794vykneY26D3ERQgisBedIX7HgQh2/Q/uAV+BudxIeHStX7b197KowKNhXhoDox3840lp0rsKhQYtUm36UMooafN44kF8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by PA1PR04MB10261.eurprd04.prod.outlook.com (2603:10a6:102:467::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.48; Fri, 19 Apr
 2024 18:08:06 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::fa84:407b:3889:82a2]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::fa84:407b:3889:82a2%5]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 18:08:06 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 4/5] shared/bap: In case of a BIS-PAC match return also the local pac
Date: Fri, 19 Apr 2024 21:07:51 +0300
Message-Id: <20240419180752.96699-5-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
References: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0034.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::13) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|PA1PR04MB10261:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bced618-a16c-4577-2001-08dc609ba9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KBcfKzO93AgPglTV3q/CCxtCB2aG+oeoRMlXtHs93XLfk2fwFwMjLx2olBF4?=
 =?us-ascii?Q?A70yTdLqbn2k9X/V2xd8WbK8MHjWCQaon//4H+gZFn8c9cVxLXC+suyg2JNG?=
 =?us-ascii?Q?A329QMOBHNQB2rJAJfY6x0TyANu+mKbBq6LU/eGBH3EAN77yzk/oLER9VuUX?=
 =?us-ascii?Q?f8k9uqjCvQCz+COMhtbHcdWKQv86DFRzRcewQHNBzzwtbX6YlJAB0CnOQD3i?=
 =?us-ascii?Q?j76cak+n3Kh7OV2SmPZsupzXfAXg1e0zU+fDlKTgeCM1xS5/OyQMTWoyWIx7?=
 =?us-ascii?Q?koFXbtC1DsAQE4bpAygNn6r/ruk17vGWeLc6i0LjMQdxcmD2axJWXOl+exvJ?=
 =?us-ascii?Q?eZQ3K+Gg2kH8DQSzhzFyQB6zzDt2Lz9sjGuk0KTaaU3eFeewQE1ahlcKLZop?=
 =?us-ascii?Q?VzinNxF6J8phhwO14GKXfyAM/Fe+wnbyTJMY/nq1IRmmZITrPcXHfz4cbgN0?=
 =?us-ascii?Q?R9iwdhchkMzVehM4w1GHi91rfH66EsBySugU4cJcd9OQnpWlAcTfDigxervy?=
 =?us-ascii?Q?mEukQLaRDAGEqmlT8WJKsfxt3rChg7FdqdkWwfcLdB2c8p6GU9/TEN773nK9?=
 =?us-ascii?Q?8JCZ9gx2z5BuQl3jQ2SD0HkkZDTJIxuwiMbbTat1Ozr/PUl8oWq4reomYcUe?=
 =?us-ascii?Q?dVlRKiU1L+iKBLO77HSaTbdpVVBDIf9RfuMBYx7h7amj/flH+akbU8MrCSWV?=
 =?us-ascii?Q?jvRcmTc4ki72a2BL8yKmDFvWLO/v8+NN49nByETLYFa2Joyyurpa7UYCdKqq?=
 =?us-ascii?Q?ZkvZKYbbTCpPgbHYIvURXyVLobqloPrHBW9IYSleciNaDkUn5I/uGEcwFnon?=
 =?us-ascii?Q?U7oyckyzG73t/P3URlBxH9UcMw+5Wzle4aKWnnEQE9UWGAkRzN8DBggvyEMm?=
 =?us-ascii?Q?2EiIX0qA7GP9dB/wjBMNcO2+ncG4EcEg6XfJAv8clOUiCi2OTH9+BwyQnzZP?=
 =?us-ascii?Q?0bCJ53DrPT1Nm8x0qiaC15v2mygv9YS/r03Gi6q+7u7ol2ZryXuhGfJ3Z+JI?=
 =?us-ascii?Q?GEAzBMmkPO0LYI6rpOdb1GyyQGFK8IZSDTBL9vRxVf0ch4yxQpOHESe0Vu56?=
 =?us-ascii?Q?GljjHWKRWQ5Vdc9nnBQIvtZpCjc/6UlSFsJqQAFyQDLYmffmdU4P6a8wdWMj?=
 =?us-ascii?Q?FCcZMeGUS9dypes/cigMMtkr1/PUUZOzIyi4okzjsubU5iGo+HWqqP/DGQ9j?=
 =?us-ascii?Q?1/tWfB1KFhdcIYVdu3vxj78aqjtNCBc5N/J8OvGdvqTT8wkwi4TM4VUngHhO?=
 =?us-ascii?Q?4QrilccotFuVYPwjUvj9axgEW+nE9LXtlca0GH5X1A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XFdThSswGE5vjkB73iMQ9DkPn/o2BWHHM7ug9pDZgAwj0mNOOWDdo/bRBkz/?=
 =?us-ascii?Q?AoHwgZDRiH2p8BNNeS39IeqX5BfsYfCCG4P99TjOphnGRLvw0rzRZMzPEE+k?=
 =?us-ascii?Q?zG1Z6KDbGQPOg1glXZK2w1az8QgiSAMOs2zQYH6sf2fMd8HWkFw5qFskyfzB?=
 =?us-ascii?Q?qW9T/SYlL1aaIbpkLe9HJnVb79JExjwhHEhSFnMyv050pN3wKWM0u3+yiCFW?=
 =?us-ascii?Q?ydf9Sr+tiWOsc9a3sZ2Ri3CiVYjSw1MxZ+M1a29Knd2qSrDsKgVD4Ol77RyT?=
 =?us-ascii?Q?HK0tLGiyGEsGCUfcg/sSRSKLNmSRe/ct1L3dQgVXmErjhmnH64IZik9t9x75?=
 =?us-ascii?Q?yQVbho0EuyqwWBtURUiw755zSWO6Yq84wSCOsImu4B+pCoArP8QG5VuxXVc6?=
 =?us-ascii?Q?im31V6NJDaw+qEJAyqEWt2FIfPZ/05drDLXuTQoWYobgqhbyJDjpDxTMEPQM?=
 =?us-ascii?Q?QoUyn6ltEzO1F537zx1D31vZTBM4hQv4Dz9/PGO8AKOimRRgxAQpnyyXEL9j?=
 =?us-ascii?Q?SDOLIVfZnQrCZ6C+kZcjpnJPwIagFdzHjxMYzYS0HOzC4nJlWQ9sjH2CB7N3?=
 =?us-ascii?Q?QHQDojonxrd8WPObv297Ny/uWKcObMDQBVCZo7bKPH1EXzCfUq1H7U/7Dise?=
 =?us-ascii?Q?k7vzr9N2rmlodEk0ZzCjucwImZPKnSsPucGC4DamIVN8YATd4Th8j5q2xa4V?=
 =?us-ascii?Q?U2kgftLm5BeLHIByPtYtqkVlQzHtQHNEywtS8iaP4Bz6DoI+w+8xiGEvGeYK?=
 =?us-ascii?Q?VFbxjOI7haMV2QqWaKaoXCEDCtMOXSi7h42VhikvKNrjcQV8g9YlIR6up43t?=
 =?us-ascii?Q?2fpTypOcvxwqXjvBZB9q2G3iKvqr3OnxKJ6u7KbuumU8xrsxKQc6De+t1CGw?=
 =?us-ascii?Q?TVNr3ke2xPixkjpEB6U2SMAuEYKsUKnh7PVBAdwxWxlFVj3+XyQcU3FCv1AY?=
 =?us-ascii?Q?QdISWe1S346QbbxDcqdAPI9GhIdQZqXnN6R/M+3EWT8hfZkSLdzk8vDy61GO?=
 =?us-ascii?Q?O7ZZjP6C/mx7fmVGkOxLPnswEWYfkg8qktfUwZkH/W74n9Jr/nJ43FE8eclx?=
 =?us-ascii?Q?ijRI0gdW/sCpz3Dn+Xx5C4ofvCh9qrh6jRSVDSIO5CQZMJF89mZr2VFVTEdp?=
 =?us-ascii?Q?LkmI7W5i3c4hQbmz5fUpf5DFCKkj21FxDuGGRctqdAwcM35OZagHIG3kOlSz?=
 =?us-ascii?Q?Pk1/bEolw5GBSrSGeQSNGt15yT+JZsChHWovzt9tNYH1LgBOlSkTFqphJEga?=
 =?us-ascii?Q?+8qM2BUJIFKGg397bO3ELfoJ5jVnfh1oWJpXQzgJ6TrBS0CdpnOIMA1vl3vF?=
 =?us-ascii?Q?DcoY7j6gdCS/zKV1hI4YUke6BER5FS/XYYwJz7Zh9hqXxi/3PAasMhPV1pLm?=
 =?us-ascii?Q?ceUYOvB+/hJbG1pCx5DDH8/4/VCtEucRvFr46yNBsRIIMSfoGd7LDwzgCTHm?=
 =?us-ascii?Q?cI0L7HuPl2VndbARpODGE28ep5VNYA/f/+2cqTZUOevv5Un/RNpFM5wzfXwW?=
 =?us-ascii?Q?V+te0GyX13gjMaokNYo7QuzUrt+Kok1EUUBD5F6izUzWVGp2roYqHQDI7dfT?=
 =?us-ascii?Q?kxyILf7bf0k2AFwQfGKLR45znDulx09GgPr1BojXtNzNpEvsZP42eHk7W/Bd?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bced618-a16c-4577-2001-08dc609ba9f9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:08:06.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cYd/asv8mfgoAn7p70zEmUgybjM9JQff2DMSoiWKbRs/aVlgnUlBKc5hBtP7Ic6eHbiVQa62EWQAB0RW5LkWNW1IQkGzDSnIo7s++4OYzEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10261

When checking in local PACS for a BIS match return also the local PAC,
along with the status of the operation. This information is required
later when we create the stream.
---
 src/shared/bap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index d7a2f9381c53..8c4868f4bf9f 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6400,9 +6400,11 @@ static void check_local_pac(void *data, void *user_data)
 
 		/* We have a match if all selected LTVs have a match */
 		if ((bis_compare_data.data32 &
-			CODEC_SPECIFIC_CONFIGURATION_MASK) ==
-			CODEC_SPECIFIC_CONFIGURATION_MASK)
+				CODEC_SPECIFIC_CONFIGURATION_MASK) ==
+				CODEC_SPECIFIC_CONFIGURATION_MASK) {
 			compare_data->found = true;
+			compare_data->data = data;
+		}
 	}
 }
 
@@ -6427,7 +6429,8 @@ static void bap_sink_match_allocation(size_t i, uint8_t l, uint8_t t,
 		data->found = false;
 }
 
-static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec *bis_data)
+static struct bt_ltv_match bap_check_bis(struct bt_bap_db *ldb,
+	struct iovec *bis_data)
 {
 	struct bt_ltv_match compare_data = {};
 
@@ -6453,7 +6456,7 @@ static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec *bis_data)
 				&compare_data);
 	}
 
-	return compare_data.found;
+	return compare_data;
 }
 
 void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
@@ -6468,6 +6471,7 @@ void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
 	struct bt_bap_pac_qos bis_qos = {0};
 	uint8_t type = 0;
 	struct bt_ltv_extract merge_data = {0};
+	struct bt_ltv_match match_data = {0};
 
 	merge_data.src = l3_caps;
 	merge_data.result = new0(struct iovec, 1);
@@ -6483,7 +6487,8 @@ void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
 	/* Check each BIS Codec Specific Configuration LTVs against our Codec
 	 * Specific Capabilities and if the BIS matches create a PAC with it
 	 */
-	if (bap_check_bis(bap->ldb, merge_data.result) == false)
+	match_data = bap_check_bis(bap->ldb, merge_data.result);
+	if (match_data.found == false)
 		goto cleanup;
 
 	DBG(bap, "Matching BIS %i", bis_index);
-- 
2.40.1

