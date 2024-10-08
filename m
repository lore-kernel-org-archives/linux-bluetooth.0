Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008541E9095
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374536; cv=fail; b=BbUxBoC9EVcClGs3sQ0inonY87vkI9Y7Pn7RhQQZGrRbvcVSizdII3vVQ4l5b617liUWM9JX4yuE9VDm3wx/CCzlZWETAh4NUuTVINRmviZvH4YsD9dNgZ6hZdk2rvYm2wVjasjtOsJ/DS7kcDc5/Kw4BPXhx8JhLjWlTRVZ9Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374536; c=relaxed/simple;
	bh=yn1+bVwijqdXkvA7PQdr2/w/GO23aWkXnFp1RcLlNS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgTltpmAQeMmRWTsvoWbmu40v+jV65/AUVbN/cm02tBgxxul/tVH9eM8Nlb3vvcxlgTag7wdsosMAC/688X6KOFINMgUst7ZI/JPoEcT4zn/hPo2YWoJoS6sw1SMRf6j7UNqYZdTSu5JkgH+FfxayO147S6cLZjP+e5Aio5XZ/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=njXXEKF/; arc=fail smtp.client-ip=40.107.105.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="njXXEKF/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L90zVfYhTW4ZWC3lV5g7LcqlYSgFZZ4mu4fMfK9ejLCtXNRM7XOiLkYyGqtpD9GomxXv4/UsXXqnqzSdGwtXuyORTagiwlYmZ80rDKQrig7vll2zB+Gc9uGli0eeWVigaB7Ykd0ZRmrk8kRPTEy/hldrvyUvl1+ld/ZVKTCvqUdv+A+FK6pct0SvX4G3gt2+3yPRbkhmKCzgkKewfHMHgGe3YbQE8URB2d01lp+dN6DiyXxKU7xUxnrReEK4qDFDAoQ067qJ2KO62pMK8wYW0jJD35qwnhInz0DvhqaGUL65w6J+lMs7fu1UU63yImxl2dFwX41mjkU68vadlaWsBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3IysLvBjs9DRlc/1LbaYlRm/dPUSXztSNXbg7c7HI8=;
 b=XIPFdCNQ+jqkKrzMq1FK7ew1CeuHoo/5Z9Dd5LFLQIviJg3eSUQjTMoURcof6Y9QRs1faCJUiBb/7J2TFtDlzXIZsjY5bC7khp5+/tyyZIsVv5VPD+ubx8o7GRmo8g6DPR/rzG4SVBJejQmhL40xihG5fnl1QjT7H2en+6pSBAFWYEJ/kQakZObl5kKrwhQTk2zohMrQ5jZRBAwJpaAfIbKhaPZ+fXY0QrDsa/hNNfQRLN6+LZQT9p5vgvvrzNrERoOPC4LxK/wKF4EXmJySQsqb9hHsgyGQIHw9VbN5QJ3a71RGS4JAH96hAPVu/4fxwaJ0ycuFON1WxaMPWGkHAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3IysLvBjs9DRlc/1LbaYlRm/dPUSXztSNXbg7c7HI8=;
 b=njXXEKF/jIj4pkpnqxR9n/nyN4DC0oZUmPQvhB8pgpDgAm4JMsmfv+uvgWO4rboczENi2Sa5yNwEK5nQrZHzOcaEYzyR6HwnWiOtb61I1rpXo4EzLvo9gj6WZHpLihK3SicYyY+bvtTyfTYHd1ZIe2YFel5TKuqK2LZ2XKaYmbukTTGDc2wvzP2IlW+7Ah8IFJQa1wI5SHdOpwES9hVq/2O1r+DR11BAdjc8HfxZET7mtLkLoWyRg2x/pGvufqYYh2QiDtCFlITtcatjPGLXqUhwcCpH2Pb3AD35IICI3f5UQWBvrfwzPMgCQh3bDZaagtfYjxTiexOEOniQFrjQBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9343.eurprd04.prod.outlook.com (2603:10a6:102:2a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 08:01:58 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:01:58 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 4/7] shared/bass: Call cp handler for the Set Broadcast Code op
Date: Tue,  8 Oct 2024 11:01:23 +0300
Message-ID: <20241008080126.48703-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
References: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:208:136::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a4329b-9805-4d30-5004-08dce76f7bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bhNPKfCzDRU6ZRn9T1HYpkiwVTu0xWMUGL4DQZ5t/jqOXGocu4XJt/F+4n9E?=
 =?us-ascii?Q?P9uanVx9zSA2zqban5PHn93kNMNzrqKSKuPoPC+2/8IkNg5XcE9HoGO4s+UL?=
 =?us-ascii?Q?awUInB5kwTqJpvzyv0uh6zZ+oq4DbzfgcFf872BdNkZhRASa7aFGoVDmobTa?=
 =?us-ascii?Q?8NbhnyBF4L3lJ7fLDZDUVo1aQMsWDVzyO6tGyGMsgenriTZS/azRAG5Aj69a?=
 =?us-ascii?Q?ISZoqpHfhs+E9trN8nP8uyxcq7YJT+uuNoUiBu3FF58KwsIS/a1T+3kD+cYE?=
 =?us-ascii?Q?j+OUA4JsVgjBphR8X6O0p+he43EMOTCJMuSw5aqy6/mBf+XdKH0ziEqlQc9u?=
 =?us-ascii?Q?IOG2OBUjcePO54Q066YgH2WBKeRThSU3a/q6UU36R6m/hS6ClJE8o6BbgB/4?=
 =?us-ascii?Q?W1fuI81zomGbndT6rhHChwDmY6f0jHYTZOB0mxwnrsWoF6lAUBRmacCToowp?=
 =?us-ascii?Q?GWwoIQkJkNMiDQHpS1sH/NOSxb0DftDRgXuBDQJNZek6fwTJBp8chp/fq1ws?=
 =?us-ascii?Q?l5SjlQnTZboA/csavmUNWwcbfpxcTCHcZZunzcQaA/lZ1gTwBku9ppLJVYn2?=
 =?us-ascii?Q?GGafSygyS724TBXqMTN6tjZANNbPKAnIQ1NDwjwnr2LE7heDtoni+QMQWtP3?=
 =?us-ascii?Q?DqBLSXj+ZVzykPKzoaVTUUygIdLkvlU7HlqWjjU31a7gxBvxRYfTtoCpaF6U?=
 =?us-ascii?Q?RURizRW9ilWYbWYNMOS/4yI3Z0f6iVzmzaqao/RMwIX+3M2KTuuta/bUE6KV?=
 =?us-ascii?Q?ws5+k37n/OFvaB/SXsrUQz+aq288YZcZuVang+0DZwXjFXdbW95SxhWHuxGm?=
 =?us-ascii?Q?4VJIAJ+ZaLMj4EpOKgZ/jlp+y0ob/36pPF7V5Ge6gaiFYi6agUD+h0g+/tIp?=
 =?us-ascii?Q?GMJJZnvEiJixdd8ivjMLz2IEDwcGquSQn2jFpDg8oC4TTfUnY4oczFIBBxc2?=
 =?us-ascii?Q?+MUB7Fnlnq8oeS+G9d/WOb0s1ZWM8UxGXEv5k2eeCnOXHE94vYJZLOCNnYPm?=
 =?us-ascii?Q?QKStpenXUUJtFfv2JE6UIQpFLz94pVkqcwHaQ8L42EA2zSj5QY5vMtbmKkEy?=
 =?us-ascii?Q?CZlXb4I09caIqD7Ht8MNIstIWuJji1UA0m/gmWu2qZ4d1JKTeHHs48sPa7rw?=
 =?us-ascii?Q?z8dXN6l/xYnEUOVekV3J+eAt8SJ/Z/d3/4N9qsJwsuI655hngdP5RNHW0Cxi?=
 =?us-ascii?Q?lVjO+W36IPeoUhBXbakGrOH/rPphAJMoybDEZwaieDyZbj/DQEiYhJ18vC02?=
 =?us-ascii?Q?uVAXiS5j+4MZgETZf2sqOt1xUgvzMIKfuhbcLLa+8GlQNU6VsC8ms/jazBw+?=
 =?us-ascii?Q?nZDmDg1uLeq5MSRzu0aWwzFNGVK8V0DD32kg6Q8TmxF2qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bD+eEVuDhZjKMvLscyKFY61oJeSO//vQbQflTFTvwy88JmeB2EtKISH08G8z?=
 =?us-ascii?Q?4JyS/c8hcSuXXVTm8p9iEUtWRB4+HS4hTV2lyDvHXQr83lf4XGt5HxZeGW8p?=
 =?us-ascii?Q?OGbOofdojyxzvK+pfLqQHntAZpd2E9Uo/RBxqRoZUpDZV+WDqHqZFOXRKBPX?=
 =?us-ascii?Q?qLDeTtUq6IrlpSlrW0aeQMXURqSEJ4neqJHSJ58y64hOKwTZdQrvmBBMKMXk?=
 =?us-ascii?Q?yRso2u+PsWViZ729BSj1QkA/+u25qMM8a0wP97Fsy9AiMBGI7Ep9vtNNLKGm?=
 =?us-ascii?Q?iZ0YpVfR4oVk95TkleYrHp6N3nLLgG24FN6pcyDrY3noeQmuGFpeJ8+ntirz?=
 =?us-ascii?Q?mOLdRdnTLlfBTmEhHOWTaP9W3HQOoG5qiRt2p/TeUwuuIq8pWJ7xykYcPetk?=
 =?us-ascii?Q?AWMqhQeMDBzAZOQ/L/4o9Ke0meXtDxL4lqeLlEPLeOdJhIdvFHTBbce5C7e7?=
 =?us-ascii?Q?t1aCqZASY/WtruCKgkgHXDcl2Lpx7x5dmfw/pAFHm/NuWSCJU8GRPa/v1MwW?=
 =?us-ascii?Q?cR0M72tZjn1eFjtvLHxSJaoQ2xkBTQDQgvNQaXjPtVXHEhaInB5ZAC+tAk0p?=
 =?us-ascii?Q?bqqa106JNFj+vH3sydVsjdNqaxboiYYcie/FiNjoFS72qRpaT5RGol5BZI97?=
 =?us-ascii?Q?JPzwW5Yic9ndZNnWInbEmRTyojLVJDG//J/86pSjAliYa3RisMdo/3Fx1fX4?=
 =?us-ascii?Q?QpZUpZ19MUzixSJtrp7EQTOVDcNnzpHbqdYQU6KKB1cviJvToxAvB8atawXH?=
 =?us-ascii?Q?45jNPjcPgkvpbPApdiHTL863jWZg8r/YqCgVZPxphrlLZj0Xl7vinOzww0LU?=
 =?us-ascii?Q?IxdDLz4mRcDwsJ0Z7Reb/AeypJ/62kkwpfws6QlcQ1WDuswXQAPGovUdoK/E?=
 =?us-ascii?Q?GRvc+/UMNmqJrOT+bCjDi/vXALFY/WyTcva0p2tKEBUZGYtsX98V1FYnUTy0?=
 =?us-ascii?Q?6yqw06KcsptzNRBvA3/J1Qp/kZE11eMxkKQ9k0uviclA5R4WZQjFAVlP+r18?=
 =?us-ascii?Q?4jrpZSSNbqlFaWJVN0AmyO9RU3jk21IMxhkG2qRC2G+Dp7yubhR7fpLSAPxF?=
 =?us-ascii?Q?wKejYKwcGfZUt2pV+B7NAiVgtEyQSr/s6BxaKGUOW5AD4qfkE0sBhLXJBzom?=
 =?us-ascii?Q?cDivobMlr5xjMXndyqGGBTyclnSQDYjQW7O2qMmR3a+9eovPoeaBrI10/DJF?=
 =?us-ascii?Q?l9jAVIDLrdU4FKcoN8ww5jtd2B52ipQejVWE/612ImDSeaufOseFjBHQhwO8?=
 =?us-ascii?Q?234tJcFzXBKtDmxApxIhsd9mnsEzU5rRcDbN8cY9yF1wzXo21flPvF5Ua8kF?=
 =?us-ascii?Q?hTYe5zfaEKw1BdnBa2WEHDTVeTUvGDMandlO2YhN6npvH1DMB4pm4R9xVfyp?=
 =?us-ascii?Q?sY/PMg0jjUjDUzn6G28FLUgDiuYnmL6JHSOoDTbxeQO3Dzzl8bAMED0PWnMx?=
 =?us-ascii?Q?zX0k30+au9JQleZEU41yIe8vP1Qp6D0tesbYP0GXhxOLuQWglMsaYJXouP+j?=
 =?us-ascii?Q?9q28bJhHffa3dSPHzt1p303cfqnywiPhBSsqQfi50iBzAUwhGhCybpnLBqHP?=
 =?us-ascii?Q?506O1ZgwxYBQxDDMYCrJ9Dv1V7cmBcX0dlKdmG80oW6KAh9F9FJ5za2SIarJ?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a4329b-9805-4d30-5004-08dce76f7bc4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 08:01:58.4695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n33I6O5uEfcFDE8QiDRDOnys4QJcsVnnbX6c9chvuL6NtCji+vLE4EyhMJgGgXUWTx3QFiUUGCA2QzaaQTIgfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9343

This updates the Set Broadcast Code control point handler inside
shared/bass to call the handlers queued inside bt_bass.
---
 src/shared/bass.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 9ee13bf4a..6efacb2da 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -944,6 +944,8 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 	struct bt_bass_set_bcast_code_params *params;
 	struct bt_bcast_src *bcast_src;
 	struct iovec *notif;
+	const struct queue_entry *entry;
+	int ret;
 
 	/* Get Set Broadcast Code command parameters */
 	params = util_iov_pull_mem(iov, sizeof(*params));
@@ -978,7 +980,19 @@ static void bass_handle_set_bcast_code_op(struct bt_bass *bass,
 		return;
 	}
 
-	/* TODO: Call BASS plugin callback to sync with required BIS */
+	for (entry = queue_get_entries(bass->cp_handlers); entry;
+						entry = entry->next) {
+		struct bt_bass_cp_handler *cb = entry->data;
+
+		if (cb->handler) {
+			ret = cb->handler(bcast_src,
+					BT_BASS_SET_BCAST_CODE,
+					params, cb->data);
+			if (ret)
+				DBG(bass, "Unable to handle Set "
+						"Broadcast Code operation");
+		}
+	}
 }
 
 #define BASS_OP(_str, _op, _size, _func) \
-- 
2.43.0

