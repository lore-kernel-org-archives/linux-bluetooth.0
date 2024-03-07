Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C835212F379
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Mar 2024 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709827149; cv=fail; b=fjKxhQN1N7l93GuZ2OoR11RJy1gilPgwwQ1z6U44BFy+J1g0+j7BY5WTxQDg2R2pabrXbKyEkcDu7WWw/uK/NR2VbCYWV9yYbnlUI8z0FduSTa/gJbOId+yqWm6+A3H8g90LomDbE59gKeVskxxkwntjkOe7S/03v00s1iEr0EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709827149; c=relaxed/simple;
	bh=PXru5G2NI7QN61hxDRjr64v5d//1qjJxkCZ9Jk7pzaM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cz/wc1U4qfDei6l7z7QKSahm0S3QXX5NF349rxjgq4lnW9XnAseD0Nkou569y5npUF6hm8DEMUMRSSgOl7Gi91RAiCUovFv6Dy8s1foONu/RayD4Gc/kXfiqHrTLTQ5WYmRsgwMbM/4OUwJ3TJlIyv/bZJTOwmHBDFHSPfVxMUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mDS98szc; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mDS98szc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOIG4s/03fQI2/cn5OWRyuoF/ZyUSnbTnFSxNfgYwgON34hWJxRF//LBkDekl1mbpVMPWTMzOoEQJW3XPwEhuJbtWicfvMPY1+LJP1UUHfnspdK/1fPG9C3qWlA4l776avLw2/m7KcBFlBJalWLXOGBcYCk2GaN7jZjl1ECzQOErnciUxrNYuWh46yBFyaVoxwMSIgayleqos46u/Qkmhw/qDNYQQG54Eu6WQpyeG3h8AOValF+QaUOMJPU6k/zCOfHh0r/jx8rpM5hJylHyVkhN5OT3oycKLYMMp+Z6gqexH7hMyGrWuBbt3cwSIdR4SksukSGYqqgfntlVDrJq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcCvK5MCXoTruYZPgNVyWJsLiZ/cz2+7HaYYDCYSZUA=;
 b=Y19vn8Grq//wbftvX1hncTX4DJzyICxJ2EddktSAmC3sQ7i/RilpUzcML1t8aEPzFhUlaelt2Leg05+urcUQ4z0Ejrf/Tges9ULiKPqCal+qOtTvU8hcKx/X7VoUpdDDRFOI1I+9Fm8fmhXyrUwnCwXcYTxBK1lGJgwuLUFGWFKusLzrwK0vpj4GldkxUFE8tlxmb7s1IN+6zFvDmCnIr/f32/VEKMAYnys4qmT2WnfREv6HAginmgIPaXfsI8UjWD2mz7SgGpn1wJl4GIY0GO0I5zzSw5H/qyOGcY/Rt+wNzF3jEn47IJO21QMP2yPYf4GEIrI0xLOSW1K+CSiOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcCvK5MCXoTruYZPgNVyWJsLiZ/cz2+7HaYYDCYSZUA=;
 b=mDS98szcmz+10Ke9Rcznsg1KobKAZAFAermY8JFAozPuvqtUW8cY4EmRPkNbKZ4sq9w7ZsRE35T8JU09MqrW4+t1ogS/z4TP840ETlYSfc97AAI/jz+9PKO3XyG6/0XLrd0/okxPmgnt8ZhxjEfVmqp3kYEKJSHJcrLsyZdfnrw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Thu, 7 Mar
 2024 15:59:04 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::ecae:646f:ba80:b0f2%6]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 15:59:04 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/4] client/gatt: Quit shell after user input has been processed
Date: Thu,  7 Mar 2024 17:58:47 +0200
Message-Id: <20240307155850.68395-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307155850.68395-1-iulia.tanasescu@nxp.com>
References: <20240307155850.68395-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::11) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|DU0PR04MB9417:EE_
X-MS-Office365-Filtering-Correlation-Id: adbb34bd-631f-4734-2da8-08dc3ebf8396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2uuDt0TwBCJVDKqwBwhsRHosl0ppD2MzEssLeSXuuv3BmXBIsQ7kEPy7Pa4MJCQEyHq9QweCqC+hAQBdSOAK//vHx3pww3RKn7JznZRIi/LSQPPYnZyqtNd3nt2fynehC8iJhvc5LSO357hCcjUUxgjkAgD0IH56hiHYG2hDv2k5FVGaBk7HCWQnnRKhp8ktxdpq+d0FhBFDmfow/aUOfRn718Rfz1f1EuwcOsAUizA31/nCO+GSLofZdMPxYXic4s1/yzOnlGqKAD9lVaWD6/CzYoWmbKyT4j93IyfEPr3737d3fFL0AAi8lKuQr5LFkk4dbgjtoNJOzst/kVEQmTbdN2lx99+FElD71R1U78mJ1Uxeh4njBhvpeGseKc9Dcp84ne+fbIor3m0BCx5DpI5v+jVawvyNddl9tspts3GFiqDlCg/FpOl7PXoxylQNBavAQYUHMNK02juH8B+E4kJGVIRjNZZwKVtDrhR4MU/iNsaKozNGMV9KqEqoTYvUOTMwvJsoa/bGbniqZ4DyYdkEV/Lu/xDbHPTVSw0yxgOxKPyZgywlVbLTfo5vj91xaK6D6gvNey2dQgDxYSGGjbWlTl2b+Ixl1dZyGnYOfyz72dOMuo0YzN00a7BJ76gpjZdhy2ohczpMPveHwG2UtVLIJmdxfvXp+WYhm/1lvPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xcu0PCpimq7qhGcxg17lvFLnwDJuUkyNkGw/mg08JA6ISS2ShZOzceokQZdF?=
 =?us-ascii?Q?lrmD2MiQFWH5S6G5X+rZzzy+K36IKe3pNTakVUthaE3hPhMHtcqVkq6mnQ7L?=
 =?us-ascii?Q?Gehu0ie7xuYpHUX8YxSqRgdxv0sV5GPi7SYGP9My09qe9b5yjoVuWXYast/r?=
 =?us-ascii?Q?vekjkcKdfRHarHUk4N/pKJJlt2DZ7CSFcBd1Rqqw9z2PBTSsTuVjzrM8hGnH?=
 =?us-ascii?Q?61JU235PJRhWWKtj5uGrkofmIPjdlff4Ih0F0I292sulhiHQeXEfzMOJD62v?=
 =?us-ascii?Q?CGUpzMuqwnF8Bux3tKpbpRpvjUHOhuE7udJfMKLDHPpmkvNI0A22ifwSUm45?=
 =?us-ascii?Q?v8dOhVtG0YMdlfE3K6n7XfwBJqJo5n+2Yf69NUife2Qb+8/ju9uZRo5f1y98?=
 =?us-ascii?Q?407fvndLiLT9sUfzLUjWqpFtZXxKxztN0CLUaFdtIobPvfSKMLLx6PDWDziU?=
 =?us-ascii?Q?qifaCrwVm3/u/vnduHq4lZV37e7bFbfQpoMZEjVtgxbxLiplfKgbb2KakSEL?=
 =?us-ascii?Q?cx8UTuS5QuJK9qEYMweKpZPk5LcQGlI8sKZcF4IrKc0NJ+LCY9LIiPaKUzg0?=
 =?us-ascii?Q?Zq970etMgFZ3zkKNlvNUV0bp1yD9mdPttmzcqBYZBmAs322v29ETYqb3mbVY?=
 =?us-ascii?Q?ld6Vm6Uo0sdQ8p8GIzJOWfrCzvvsZHkWbCyyUKI9DORS7QUNG7U8KQI+F2aQ?=
 =?us-ascii?Q?9sAYgokYfu3/4u6MgJrrzCR40wUqJVa2ZzuBNzjYhPG+nr22JcFKoSNW9NJA?=
 =?us-ascii?Q?ONGXgbBkbMuD8qAQem+g9Q6dcpIS6tDMeiR3yIr39BJlQ27I66ksV+DdMElA?=
 =?us-ascii?Q?LrV/MiSbhBwJM3Aqbr/6GEMYGi9gWynKdSCPqQEjCvfNXoLzILLY+TSuwlV4?=
 =?us-ascii?Q?FHOOrW4fLE4I7fl0R7b+BK9l+0exu+t60jEE/bIrHMfrJc69KEyCEMqteJxo?=
 =?us-ascii?Q?QWjbq47lLAlMsTEQEtddrdAqF81GhfmUQmWUtIgY+IpITJYJjgc4aJzWh/TQ?=
 =?us-ascii?Q?7le092ZCGwIhW2hpocf+wG5hNBQ83ABXx1okQTbTZ8PTS/Aw+FWKkWPYWVFt?=
 =?us-ascii?Q?h7WhklPUXI4K1A9dOpEfzXXO7C+A2w+EOLQCnZn8YYt0mZlqA//dszToA+0b?=
 =?us-ascii?Q?IEe4yr1Jp9ND+UfID390e0p5E4wkk9Wmfh9ZMHujltDmBXzUjLRHUWbK5kUs?=
 =?us-ascii?Q?pDORCRaSonUBhW7jmYh0/WZ6S1dc4RdMHYzyt6v7+Gi0n0eJbVL49UUKYc9L?=
 =?us-ascii?Q?ZlCHV7zHZeNr+KALfOiKKxspDMuCVSIDlU6z7xT9/ofC9G3JVCtgLktR1aDh?=
 =?us-ascii?Q?6GV/HHZdC3rUuMFIHaTGo/HsQMHMkhhKGGGuSRlq96LOEtxqziKcReRUrcfP?=
 =?us-ascii?Q?7xWLNRdcchAlbTPJhAmU3A+4KxlKXxS6HDRDECWuQcjsA5+tS3erge4Ee8L6?=
 =?us-ascii?Q?tsif0+3WySdb5QBZG/E7QjyinOsgU9pXsWJWvOsn+Unrjb+Fpf95MRRTxqgC?=
 =?us-ascii?Q?Eh4X22Gb92jCde0yh6aRiOZYJR+B1ZE3FL4/E/f5T/9uOuWqs40Z0dWrUwlR?=
 =?us-ascii?Q?8b24xsP9vWP7DKpym+9sNaQXuDNqc3RH2rdUieKPFRn36oGSxecAuLYw7JKD?=
 =?us-ascii?Q?rg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adbb34bd-631f-4734-2da8-08dc3ebf8396
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 15:59:04.8744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ga/N+DZIq+iQQF65bimKLi38XvZVjNMJHY2znjkX29bD97QG0tZkghOCuxLfnDvC37UNVzICzODLWXkbzJuYoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9417

Inside gatt_register_service and gatt_register_chrc,
bt_shell_noninteractive_quit should be called after
the input was processed.
---
 client/gatt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index f03fc1526..84b7f3f49 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -4,6 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *  Copyright 2024 NXP
  *
  *
  */
@@ -1685,6 +1686,8 @@ static void service_set_primary(const char *input, void *user_data)
 		g_dbus_unregister_interface(service->conn, service->path,
 						SERVICE_INTERFACE);
 	}
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static uint16_t parse_handle(const char *arg)
@@ -1737,8 +1740,6 @@ void gatt_register_service(DBusConnection *conn, GDBusProxy *proxy,
 
 	bt_shell_prompt_input(service->path, "Primary (yes/no):",
 		 service_set_primary, service);
-
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static struct service *service_find(const char *pattern)
@@ -2761,6 +2762,8 @@ static void chrc_set_value(const char *input, void *user_data)
 	}
 
 	chrc->max_val_len = chrc->value_len;
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static gboolean attr_authorization_flag_exists(char **flags)
@@ -2817,8 +2820,6 @@ void gatt_register_chrc(DBusConnection *conn, GDBusProxy *proxy,
 	print_chrc(chrc, COLORED_NEW);
 
 	bt_shell_prompt_input(chrc->path, "Enter value:", chrc_set_value, chrc);
-
-	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
 static struct chrc *chrc_find(const char *pattern)
-- 
2.39.2

