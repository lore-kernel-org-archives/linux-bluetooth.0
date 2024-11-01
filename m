Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2079.outbound.protection.outlook.com [40.107.105.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0C219C54A
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461914; cv=fail; b=ADoz5YGoAVrOi1Rkl2SgE71SojkxBG/yd9S5Oq1Qx0WNnQMD44RXHfCZPAIXSwovgwFNJXr9UZlIQgNJcFDgyK9tSYS2vJnaiAYDk+pLv6KjGT0e8+MsITMoHN2E89j+qQw6Qv77H1iNjn/Cg76uIbRt7uRSM0Lgpr0mQ8zWByc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461914; c=relaxed/simple;
	bh=fmVg7XgrkQ0RmGn5WMTBWeDUIbvmWAl0cnmR5SkTtnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dUL8aZdwXYULraKV14lCJhGVFvMt3c9NXvRH/Lx93Vp165GzFTslpKszpfdb4crhfvOumA5y3dG8Zoc/96AsaEMcm+iKTzDSWCtxLCiEW4YDLg9OkKBXZFU3Xx193rXsoGSK9AHTeeNu3Jr0uQIdSIaYHqFwkGqDeTO5vi276go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=K/TSki+H; arc=fail smtp.client-ip=40.107.105.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="K/TSki+H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B/w4BdpXUrITaPq3UztImhPRO1laPP39rI5C70dLjdfpjMSfTUTAuK3SiSbyScerWs742EEzdpHBWvIZJ/ZTVpJtPBRql9cHKO86Nnf4F9/gUd7ZqA9ImMnD0txQwBlh2g4neqAHe4TAbiUmSZp4ie10MAhZ3ujHeh5387Y98ukSjrJnCSQ6AqiH7uf8EV8mBtfxjbe+wxRSfDpe9FoiOppnXO9T0R+41w4x3BGtcgqIW0dTZ46ppKsh7uYPG5li67CtNffCskfkm2EhGntFRHegxcsIV3s/xpdjVd4rO3v5imJgvJhidZtj3ipbjCL7iu6jCWOtWqYihSJBq5n9bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IscxfkjRIQH4lZLX4mtCT8uvJCa/qmHE+7gNHnkd61Y=;
 b=MGDMKAzHI72tOjxIflbOs4c1+CHpJKRfdmfVxfjLkFNVGMQ5MTS76qkVrk9XdsSb3g9cIJSA/zFxf1WbJ5Vi0OPlU6mFLIk1irrhpx7OXvgtFh+inY7DRKSNE0+M4T5wdDw6ubls9/756hNUcmp5UX9HXTh8Enms7XAoREe6TyoxK+Jsi673poFzsEb+t7CZ7ZXR7pliW5WHtd7wewVwrXzKXLv2x/FcH4uDrEp6EQNBlM5mLhMSDKMxH+DreBKC6LMLLG+RNmQBfMzIHX+ymCW0oBBSaEJhB9ifUlC1n+RTkzyVoGr53Lv/kRJOtcvuC5z4zXDtwYkXOmgt9MWeAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IscxfkjRIQH4lZLX4mtCT8uvJCa/qmHE+7gNHnkd61Y=;
 b=K/TSki+HycxQk9eNxYBWx4BS4EJrMNJCIxWyMSTDFESTmJq2k3o0KwBxTKQmHpcwhShdNMFSu1uvVPo2vrOVEBXQ5TGiYpfMjBgsBdc0syHLXk45sszfGYI7JfWma82fthWAKSf9lv/B2MaDQjemtQ/rGv1AtM5tW1pcWeR3od8xOdKXZ09xLURv+c1wPQqZr6DY0Q2iFdVawzNfBKKXkZv9ZsY/YWfjlRXsvinIx8Myh9sVhLUikv+lmUSG+7pmdfzhCPYfvtqDsywfJwfu0OJnRCIXEu3gZ0IMHArhh9LW1j7Yf+0LqJaojo+JJmRLdo65SRWsTJpkskNptkzVwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB6979.eurprd04.prod.outlook.com (2603:10a6:208:18b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 11:51:46 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 11:51:46 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 3/5] iso-tester: Fix memory leaks in iso_accept_cb
Date: Fri,  1 Nov 2024 13:51:16 +0200
Message-ID: <20241101115118.43891-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241101115118.43891-1-iulia.tanasescu@nxp.com>
References: <20241101115118.43891-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0089.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a40b3f-6cc0-46d2-160f-08dcfa6b8ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cl/hE5inU+cCvv4APJOBrsepGKxLDyH8jqe/LSI4trqGYIlRYaIJCXJarY3V?=
 =?us-ascii?Q?bYL0UgGM9PANGn1I0hbPChQ4IldfhazBImhXzY0cf4yZo+ktx8uH8T6qlCLV?=
 =?us-ascii?Q?iZe2vdXUbsijQ2WyJkaSxUMt0DDElshOaJV4JevJCs1CAujgimDSRWhyKQ+W?=
 =?us-ascii?Q?QODPFkcqNNCGqV0z6kiL4Oh4zQcmVEzCKIhKErfPq5rAYAbTaAdCTKIHYv9z?=
 =?us-ascii?Q?2Hk3O6uOcjI4wcAE/q3ORPHvFGKeUeJOngYrOFgl4QinHHYTsQHO3Ncq23IZ?=
 =?us-ascii?Q?cf0Y814gFA6ZKqhCbft2Poe6FXUV0pi7QJZcNJTtt70cDZbFT3rYk2mWpEGO?=
 =?us-ascii?Q?ICjt/+QxJ7PVEWfqXZUlCia7RQeP46Q0LggeyUDMe2UlqWb9ow2FM+lTGpwQ?=
 =?us-ascii?Q?pXJhDsiJHFdw9drLyb9BPUmxcEr48ApXXkPQoDH8N/bI/OSOWTXio8eZ8Msh?=
 =?us-ascii?Q?yqrlj6Vdd3ZKaFZrRP4pIGWtl5IrvIk+nO5TuqX4AvE5BACzffOSPWl5+YJD?=
 =?us-ascii?Q?TO66XepedX7NvMHCKSiJ4sICe/jwLtPAjnSfegCCVwg9Fs6CqfyCpvfGLrNu?=
 =?us-ascii?Q?L8hfnMkSz7g7paS1xoHNYUOyxOV86jcZnumd/mC4Kpdgo6pgz07Mygtcp6SG?=
 =?us-ascii?Q?3c5l+f9x9StNEIKmXnhIRclvJx4n1dI4pLmrb/aZmLGEi7sPQIzHOzgvoSNN?=
 =?us-ascii?Q?klJMqmoIIzjCzYQoE9zvLwaQT3PUIW5qLnTvYxslk+w5NRI/shY1thN1fWt5?=
 =?us-ascii?Q?pOl/03FsWuObm0uLP7kT8hTErVq0gNNL89qOg/1f3chZOhyrl3VOWZPAclVL?=
 =?us-ascii?Q?kRnnqyLIOKU3Clr9FBd1az7i27xO3LgLZiw0bLsy4B56zrW818KXjY/IKQPx?=
 =?us-ascii?Q?Wnzkxqtv9vNqUIdyhCAmOPUJSFIya4xosmXmLmD5EyavdGb02eO1rGUYuNdX?=
 =?us-ascii?Q?puUkwvpcvHvaSOKrDBxt20CKY+xALqCwsctGKbfOTJ1hz07ZQSeEMLkZxJ71?=
 =?us-ascii?Q?jWZy5knv3qydGB9CzmkYxHg6MCvkpvIMDCqGFZZwtq0fCV2zAILfP4y1V92O?=
 =?us-ascii?Q?yB4H2+paR7eQBaaMkzRDpq0P/hH7LD45MBUE/A4wgaHENLwoq0lwAXztorqG?=
 =?us-ascii?Q?sgy/DQbfM25BRqSHcbbhAOIIqGZXUoeQl+IMOpbdrCRa4C4icIJVSEjwQbin?=
 =?us-ascii?Q?+CdywB8LhXzF7+T1W/BVbgYl9w0vmyTVS/Y0fvbvh/BhOeuTM2JKhV1jPfoM?=
 =?us-ascii?Q?GQXX3OZIht9e/+tKr6Eje/kSORJE7JwJGWZiT75IEHljivTz9iKCL6PHjaam?=
 =?us-ascii?Q?l9qZLUzwFT4YNbS9/4xAqV3Xw+sqNhWoz88+MG8mVDb6QPiVSDrxL1JMrJTj?=
 =?us-ascii?Q?N33xeds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RVJK+cEI9r/wQuw7gflJOuRjm9bjFm0Or5mGGfnsJcBrjM1V1K+5gc0Aplzc?=
 =?us-ascii?Q?ZC3CH+/eKWdfrxDaRd5bbJBdJpj2XVGTiLGqULXiRiLf5udjoKV+ZfdlvGDI?=
 =?us-ascii?Q?O+asz0+4anSxONCYe3bXeSv+HXC9JBeNy3bo6bZ1jxCtTWNmRrqIx6OZ6LTe?=
 =?us-ascii?Q?4JNDoK6FdBJcNHIfJnURn/zH85MuUXFZFO5og1m1nNACV1kL8LymQ2m14UZ9?=
 =?us-ascii?Q?qghpSlw61qc/IS54Q7Ih/bKDpPrBdCfY+KcUiQAxLkMs26n62Z5wLQ3KPZV5?=
 =?us-ascii?Q?VgrfpmMBl4YbPrZD2qyQ5d2E9JWJTqSXAtn7BDGOhFE7OSUg/Bmtdk+DjAAp?=
 =?us-ascii?Q?ipMM6Cwp75eOD+ynJTxMH8T9jtkqH0w1RbSpEplEKHFCh2Z2FBrhGuEggH6Z?=
 =?us-ascii?Q?k7q4ZLgywTMf2AoqWN09Nr2RRmRG0WrFzA+VWU1ccdyeaYPaeIiSeH7/BJ/W?=
 =?us-ascii?Q?RSphrhRGeNf0MPq+VhTBy2yfcd/vC1v5cTKRFx4Vy4Om3LRp4BWqt0DknsEe?=
 =?us-ascii?Q?FEgyA7mdD5MlGnTKB9lJhVw9sWYYaoCHXIX8ensGS4bbiXrU8V+RCy6/h7nM?=
 =?us-ascii?Q?e/21jJ+aguzSzN86Q6u9Cre1oKdyNnA3FKgbhotkCa869bW6IxzcC27wEPce?=
 =?us-ascii?Q?Q6Uszf/ZhYHCF3ZhG/gEujkW87twMZVnG1K6ByZERm4S1E7bfgtkVvjxsvk+?=
 =?us-ascii?Q?kfPT6O0xIgiuwy7QRsPAAF+DZ+/+NOExf9ImkdW8UgczWGr95sk2iYLJ52yy?=
 =?us-ascii?Q?lw2hGlkDRMNB3CNu99+koJ2ngv1ZOpyASv7r3VXyIz5lQ8HsJ9DeUNV7ySSa?=
 =?us-ascii?Q?xZOZ2FmQolvlPDtjg3hS/bTo9mOGsdtmCrJQnhMdRrG95eQCt14UEBZeS1zc?=
 =?us-ascii?Q?g5q6exu7XnZJB04nR1GwO5L01eFwT8vCOiC29RQdUi2y+xlPqXdpb+msl5av?=
 =?us-ascii?Q?YxTJibbQzcWig/Y/ZLHnnsWwgqUVkc0R+IMcb6tbe64s9tzBtUXij+NBYcK2?=
 =?us-ascii?Q?WnV2yIDWmGvC1L02h+j9gybe2c+3bXTXYxQibiYiYa4ujdebTlr1Ongk+LAC?=
 =?us-ascii?Q?10+nCe/8M5CcjX5fjuLCnm8ZmLzmHlLZLI305h11mvz66WFAc3NponeEsROV?=
 =?us-ascii?Q?NjjaWI+FNlF8XJI6PNGOq+VDgh9GRZGb7MuQtLhIfwharq34IRFzfeb/nbOy?=
 =?us-ascii?Q?7vfK0APAUfLG/1pXfCjfYj/lf0Q5SXWhSLA9HvyZBZfiuOskAe1TPFxxJALj?=
 =?us-ascii?Q?p6ivBGUnICpe7gzFbzKakDiVE1RFAZM1YANjUjw893YolSBclZrEepvMH+4y?=
 =?us-ascii?Q?mI5XcezHVIDt9XfRVI6Ceqb4mEC7VWLCRtramgInqxWOSTP+s2gpffNoCZUP?=
 =?us-ascii?Q?ndZwyQwlvq8uwALoxFzlLpqDmsXOfS15srlVBMc1EJRzVHf51BAf+EChptvy?=
 =?us-ascii?Q?UCOEmBJwQSA+d6LLyltkQIccnBVCy6kf2E8qOz7XrUrQYTgv7952XpoDVbIZ?=
 =?us-ascii?Q?P+Cd35gTvqWas8ziOFVckiVEWH1RPqea6fM1sqwzSGjEewQYjS2USksomVlc?=
 =?us-ascii?Q?zU5+F4UROJ/1FrCnxA+Wfl9HSUg5olTsPFVfhxWyO7BIVK0z7L2ei80ACOMU?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a40b3f-6cc0-46d2-160f-08dcfa6b8ff1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 11:51:46.4537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/U25XE/0O7EMlVeC8tQr0H0+jB1NpeqsNdPHpOMbsmrbTHRAD3DeY+cvTfFleK8aNQO3OfYjskoZhZu0uzAqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6979

This fixes memory leaks that appear in iso_accept_cb because a new io
channel is allocated but never unreferenced at the end of the test.

=================================================================
==20460==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 120 byte(s) in 1 object(s) allocated from:
    #0 0x7dcddc8fbb37 in malloc ../../../../src/libsanitizer/asan/
                                asan_malloc_linux.cpp:69
    #1 0x7dcddc719af9 in g_malloc (/lib/x86_64-linux-gnu/
                                   libglib-2.0.so.0+0x62af9)
    #2 0x7dcddc7722bd in g_io_channel_unix_new
                         (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbb2bd
    #3 0x5d3fdfe28262 in iso_accept_cb tools/iso-tester.c:3004

Indirect leak of 6 byte(s) in 1 object(s) allocated from:
    #0 0x7dcddc8fbb37 in malloc ../../../../src/libsanitizer/asan/
                                asan_malloc_linux.cpp:69
    #1 0x7dcddc719af9 in g_malloc (/lib/x86_64-linux-gnu/
                                   libglib-2.0.so.0+0x62af9)
    #2 0x7dcddc70016f in g_io_channel_init
                         (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x4916f)
    #3 0x7dcddc7722c8 in g_io_channel_unix_new
                         (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbb2c8)
    #4 0x5d3fdfe28262 in iso_accept_cb tools/iso-tester.c:3004

SUMMARY: AddressSanitizer: 126 byte(s) leaked in 2 allocation(s).
---
 tools/iso-tester.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index e80c2159c..41d46f554 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -2987,6 +2987,7 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 	struct test_data *data = tester_get_data();
 	const struct iso_client_data *isodata = data->test_data;
 	int sk, new_sk;
+	gboolean ret;
 	iso_defer_accept_t iso_accept = isodata->bcast ?
 						iso_defer_accept_bcast :
 						iso_defer_accept_ucast;
@@ -3014,8 +3015,10 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 		if (isodata->bcast) {
 			iso_connect(io, cond, user_data);
 
-			if (!data->step)
+			if (!data->step) {
+				g_io_channel_unref(io);
 				return false;
+			}
 		}
 
 		if (!iso_accept(data, io)) {
@@ -3037,7 +3040,10 @@ static gboolean iso_accept_cb(GIOChannel *io, GIOCondition cond,
 		}
 	}
 
-	return iso_connect(io, cond, user_data);
+	ret = iso_connect(io, cond, user_data);
+
+	g_io_channel_unref(io);
+	return ret;
 }
 
 static void test_listen(const void *test_data)
-- 
2.43.0

