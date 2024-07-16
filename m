Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010035.outbound.protection.outlook.com [52.101.69.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BE319CCE4
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139761; cv=fail; b=KOGtnjRMXZTF0EqHHMn5d0AXvAnTtxxglNpc5qQwKCX47uZqoY0c5D0nTCDMIoe28XoRo7LMD5VzIy96K0uQSGItqFw05G3ZKd3EA6UHZAxziJV4RJ+CCABIUPlIL6S1amnvmucW3L4WMIJEN3Cw8XRWvu2U0pd6b+/93as6VyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139761; c=relaxed/simple;
	bh=nQEWzxtRwgqCugh2NLKyYYz2Yd6l7JfB5kEl9aqvIfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YMqRrGaQCejumn2vWVS75xXzCi2Ht/6+bzVSlYiq2LZ6wYJ6wvIYHG5+jVjRyEZS4opAB/q6/AIvV20FYTNxxCskg16aT3ll0yg7x6f+0m4nfy/vSuKTNdXL/JkFGH3Go0rr9D/QrIrksECYko/sF1F6mpZJZ7uFsSgEAQ4WsIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fkDPvnk8; arc=fail smtp.client-ip=52.101.69.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fkDPvnk8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1wp15dz/jCLKNwu/nPQ6D97SK8a3Za+ScdZfskOkzywMKp///VjHm4CTS87vmh3cpaehnLWZLMy218ltDOayLoGecOB2YLoGH81Y9qLAXSBlPsYYAiI1wdr77n7S3VPg8/oXw0giTxAaOIe3tHfYAkpxbBNOzcogzmkY4LVsUYEOD/88kG8aBv4ZnRZH7qv68T/rNx5CHIqIRXn4x4MMUQ/eJRaD/JkUO35zZEtzbIU8lAK8CQ9HZ8DFWWqj2ebjQS9dYwgEN8zqszvGlQ9IYEHBfF9JGVB7oQsrjxA8RH3e6yE3sdRIFbbS3St5u+yhCj7GZndQ08cK1BIPxaScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1iW7okl0Vhw5cpPMCyNpN7kcen5M/3cvalRuK6PkM4Y=;
 b=H+jsT+HAz0vIkPc2EtFfM4hh1Fylg0Yg4cEvPhkuTqYO/wVY0MvNWO2mv5x6i7d6XFeMZUIm0ZX+qJVqyfD+nFlELTO+hRm789qMmVsWwxl5PmCKxdTB2vEVDswsIJPgPa0wq3Zp9m+6+PfEN46DJcXoNlCf+OjHcmtHPHc+4oOecGwWCN+8XyX6aZubb2jEiYrb7/JqV8kHgwhn6cERONCubqaw/GJ+qVMIscKNy0InFAA/e/qX0+W6B6DqtkkPiJhZsOhTFr2/5268AIxx53NJ+BLam39vXsHDn0mF+sF0HwvYR1qXbXa3cVPMWs8FWRG+QDVla2wqHhWLEtIQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iW7okl0Vhw5cpPMCyNpN7kcen5M/3cvalRuK6PkM4Y=;
 b=fkDPvnk8rvMaoTx2bnFHNnyD28y+eUe6NVKbXWqOIWLQCgrdVUKoo2gxS0Fvg+aGg6kDS2Lq+xgK9+qFWpyPhW8HmXkN9IMPq1Xba2kWd9n16fgvIjt5S3d1Xrcm6b44TGjgcvSSYqD5R9BniwFr4mBZCxroPNma1AgxsMl8tyk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:22:37 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:22:37 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 07/10] shared/bass: Add API to get GATT client reference
Date: Tue, 16 Jul 2024 17:22:04 +0300
Message-Id: <20240716142207.4298-8-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
References: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:208:69::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 112a1193-70ee-486c-3e4b-08dca5a2be2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/oS5jQwoyxTH/4Aw2FgQu+LPcpqop+iWttztfXfC7yZbD/LNmvyJZUFRYXmK?=
 =?us-ascii?Q?dVv5EbCKK84ryq4Nd3Lp82nNWzdrOJQEGS14BYl4q/gYcK/Be6Fh7HMsedo/?=
 =?us-ascii?Q?5Glssfosmm+AueK6tqt7cqr+MOQgSCEB9o/LB5o3dqlY61LvBBn5YG4BJ4gA?=
 =?us-ascii?Q?paaRIhpMBIWz/An1YSj9VRda0DKUkjtd+nso9ThP4K6P3BS1vTQVF29cuTGj?=
 =?us-ascii?Q?EQpeG7KxE5K+Y2tKW1mmxTbIF8MpBZeg/SywV0PmKUEdYo9L4xHIUS0v75O/?=
 =?us-ascii?Q?QnEV8ma2NuYUb2DSdd0PmIPARste3hP8yhx4rPIJsQzD8tUqQSdtXGO6ODdT?=
 =?us-ascii?Q?IdtgajhYb9pTWcDpQNMXMWt2qagCofiDkn2/jYoSsQopNFts1UFcItrWZfR8?=
 =?us-ascii?Q?8cI8vUdIWjpkRyIaqJxb+ag1VbZa/LvP5Z78MNWQLBHIIlfglRlkTd+SZPOq?=
 =?us-ascii?Q?P197ZPdwyrlkioldY9zrEUqQY7/G2QFnmQlrxOP0uqOnexj0AMDwTrYEpXlD?=
 =?us-ascii?Q?aJnhwzShJpw++7c3MU8pQwnp+HC3ZlycMafGcLqvNuwJHCUSC3+P0NwVA2l2?=
 =?us-ascii?Q?02gEjC2zsQf/mhYdxII13tUG6dqPSq9o7HWXpX00G6DAJePR7gwwHU55twNz?=
 =?us-ascii?Q?O1EY+v3g9AfvjL8f6WlxkTGSlwLfJQ/QM+OK88fuzy8Sx7uHslGvrH+510jf?=
 =?us-ascii?Q?5+Mi5fRzSYNDDYMykTHGJfNtVrnRAkRuKLmFcpArvoDRpXtFf61bXURox6Fi?=
 =?us-ascii?Q?R6ZzObUUervP/jwB2THG31MedzVjMRDpE/bTohe1H20gEAbwH/uOZtom2tBz?=
 =?us-ascii?Q?sXIowig0PRAjOIwyumEA2IHAbqryKH5uCuRjIX7itlV7As67Rolt7IMOa1a4?=
 =?us-ascii?Q?DMxTrvuvKKTHWmC8EiA1Zesrm0uBonir+5JJxz12BdguyX53xAux0JOJ9aY3?=
 =?us-ascii?Q?XwJdw6G11VzhfmA4BuUr5Me/V0LkzSwyCfLFMyq3kgLk5MawxIrwc4hQAZhQ?=
 =?us-ascii?Q?lBfPLEzI9QnZ54KcIHY3P4ptd9LkX6HfGKQAHj+hGNBhjDyYY7KEA2usZ0rW?=
 =?us-ascii?Q?gzz3VJpsR4ovxVAsjmw+gZd9FwrOy2JhP/lpZ4wWxX+irTWXs9U1uXm2tiHn?=
 =?us-ascii?Q?Apb9JxAAJM1r1/TiwV5bDmeHjO5JQPDG7+vOov1Y376Zasop8GN/oblB0SR7?=
 =?us-ascii?Q?D4srIqNZlTLu4hxgq6gfV38gObyceVS1QuNT79520P7kmlDHPAnDO7cTTVI/?=
 =?us-ascii?Q?D3A1p1Hm1FINn8DeK/XLL1djK0VOzaQU/PEtdPw9pF+mLtGWuJjUnOgtdETH?=
 =?us-ascii?Q?qUNS3tFh84/QCpXrDEhhawWQSMzcqApHWBNyuviNoYMq0A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?63d6jxCmgp4d9Mv+iuqg05jXG5hUGmSWhI/yAfM07irAIKH72JK4hKgZXr9Z?=
 =?us-ascii?Q?4YM4ypk1dJdqZwf2UUYvXEydJNDKx4zSsclosdq18horl4rDXgDLYou0iQpO?=
 =?us-ascii?Q?r+bHQLUnVDktzKgszzfRl+BRVoCskXzmwZfvFUZ92hLT59sJaXJnEZ1v7/cX?=
 =?us-ascii?Q?KGec9bLFvkJJbpB+6vhY3/BqzEUgeZMh4xJCXIyOOlM3Pq7dhkVCab/ZPzIL?=
 =?us-ascii?Q?N/xY4CmTSR7ePZhaU0B44+RV8XkqwORKt/W3VB6eyoGTXfXBJqY2j5g260Sm?=
 =?us-ascii?Q?k9BHeclqVg6DudCAGumo/j5tCYt8vzFLmGhg9z5V+MZv1YM8EDkkN2dZzq+C?=
 =?us-ascii?Q?HInLKFPuCVacYrpBWTECZLCFbYMQoMC3FCUYgorIRe9ACsd7N6JMwNj9iAB/?=
 =?us-ascii?Q?LSLIjOfjVeG6OW1MXu+9jfuGyPxG3hjUUKoTDMdPitEUF1wLAIq/0MnavWOi?=
 =?us-ascii?Q?cZD2nrvNl2no4G38CXtNHl0sNrtZ/uDkpsDPlmMwQ3ixlAubR1aAWqpSUpIV?=
 =?us-ascii?Q?5PBO5QFxlr/oLgDIPYtl/xOKtHRraOhfxJTgXlJ8DrFVc8Ql0KmGfhpLv7IK?=
 =?us-ascii?Q?n0x1kxROC6FTtlWcCeQo1K8RIElZ4kPVkL1h0oVv4ihK7tm4hFKHChIidLOR?=
 =?us-ascii?Q?pf7/mw6MPxAPGOGdHEyydV5r9Vw+8iDtTRL4zTM09g5i47LxOMq7z7uBARAA?=
 =?us-ascii?Q?/ecwhVEO1XQr4iStGQ8SsMqJb8wYxtp06pbR6XVFIIVELSUxkpZV8WcTo7YR?=
 =?us-ascii?Q?uods340GeAb3ZB6mC1pAm9nGLGAB6P/y5RExCuOWw+k87ZDFYp4K2UjRv1qW?=
 =?us-ascii?Q?r5/PJBVoD7HAXw0eQtJmu5NW0T3CvUwYkyh2lf9dy/BwGOKvfNczPxCcUBt0?=
 =?us-ascii?Q?ztGain7bhtiRe54VJaDBlB2bIN7ocidax7jdx7qCbZC669ffkacrCN9lac6v?=
 =?us-ascii?Q?o/eZ4TEG3PSw0ZPq3voZgdJPZnEs0ETR/PBQv7qI8HWguYqKCwP1VF0pDHn1?=
 =?us-ascii?Q?nhQzpACl6bvOKBtofcsucilXuSL4DJ30o5viD1tjMUg1v5e+bfSODxmVWS9A?=
 =?us-ascii?Q?g0RTTaBnf7s8lLPUx28rVmUcsbW8mmv65hopxvJw7++bBZjTHldVgiA0IaUN?=
 =?us-ascii?Q?Q2otlgsWlYLp99mmp8GWmwvjTlwwfDTH2dea2SMolT3QIWN1EMEszNxNGari?=
 =?us-ascii?Q?eSPkP4Cy3mMkoVM3FqtY/Wi9LVEglb2BZHdJ4XR4XxYtyyrVumZWHvX+T8LA?=
 =?us-ascii?Q?o5eX3SpQp7gPTX/mFCPIRqnWbzioNJ8XIgi8eUri8ZA5BPDYYG1+7SXfldEN?=
 =?us-ascii?Q?053IEdDZc6qPmpqw/8CQR3xyA112+FmPEs8bHTGR9FzfZ/SbrqTC0SSAejAD?=
 =?us-ascii?Q?uTBx+bFd72N8kjv7FPTZp1VTgHYrlaWXjCs3gO5ANpR3wNP4yYf3rkXE2yBu?=
 =?us-ascii?Q?3Gam7UrgFh+g92D823HCu3cjS7ZmbtnW+AAwpE68peedQGnnjuQwcrC6reKQ?=
 =?us-ascii?Q?XQCz4xdZPbx5qTuHIURjsY/YXmHpcLLwVZJG8ZGsxr/Z4540sWDT/H7aA5R0?=
 =?us-ascii?Q?sD03mtApqs3sQuTI/vH7ngqO/FNt4Lu4uLHSOSlbnUePvId33OjylcqFQgUq?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112a1193-70ee-486c-3e4b-08dca5a2be2f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:22:37.4776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x5mw65LlTHryqeaYbXza+UhjG2us5qDeIHprpcEBEpk4gCumkZ7XQHTofJafkkgFMefcKy87pUH0Cx6wt2PaBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

Some use cases require the BASS plugin to differentiate between client and
server BASS sessions - for example, the BAP Broadcast Assistant role only
considers client BASS sessions.

This adds a BASS API to obtain a reference to the bt_gatt_client structure
attached to the bt_bass session.
---
 src/shared/bass.c | 8 ++++++++
 src/shared/bass.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index d82c043ac..268e3bd86 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1683,6 +1683,14 @@ struct bt_att *bt_bass_get_att(struct bt_bass *bass)
 	return bt_gatt_client_get_att(bass->client);
 }
 
+struct bt_gatt_client *bt_bass_get_client(struct bt_bass *bass)
+{
+	if (!bass)
+		return NULL;
+
+	return bass->client;
+}
+
 bool bt_bass_set_debug(struct bt_bass *bass, bt_bass_debug_func_t func,
 			void *user_data, bt_bass_destroy_func_t destroy)
 {
diff --git a/src/shared/bass.h b/src/shared/bass.h
index c4b5b76ba..1674146bc 100644
--- a/src/shared/bass.h
+++ b/src/shared/bass.h
@@ -121,6 +121,7 @@ typedef void (*bt_bass_destroy_func_t)(void *user_data);
 typedef void (*bt_bass_debug_func_t)(const char *str, void *user_data);
 
 struct bt_att *bt_bass_get_att(struct bt_bass *bass);
+struct bt_gatt_client *bt_bass_get_client(struct bt_bass *bass);
 unsigned int bt_bass_register(bt_bass_func_t attached, bt_bass_func_t detached,
 							void *user_data);
 bool bt_bass_unregister(unsigned int id);
-- 
2.39.2

