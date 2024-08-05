Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD3F155747
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722859488; cv=fail; b=pYb1PRVR/LTgasAJtdouhafikvfE8jElIRjEDz/AWx0Ch2oS1kDH5fe+VeqrJjsmmEzlJSWCrWcq6/YOJd+NT/YBx0ylnfakhM7IRtYL/1pxL6IA+/6QxLEdQFzgEWVxJ5dt355D8g+Chi9Mijlfauvc85YWUPUIdqc7gWxBDGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722859488; c=relaxed/simple;
	bh=u/DVDsUI2PhuBLsnQK8cISHem/kIW3LZyerUZkvlVc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N3DViilci6TMJEucbFV9OH40LKTdoykCKrK5SFbmK1ZfpHUpfc0j3oFaVuj1hR1U4L2YT/regeU+sxjIHUFwZaFiIU7YDQ1yZvYd1mAZ8qlqxCes3LYBXiQFDsoXTaGdQasVj7YpAgY4XnmK6Fbxw5078oYblzM7yUDrym/w4kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IfEM2g2Q; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IfEM2g2Q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0d4ezCtbn4TFvCtS47EClO/f6Y6m1kXBjGNtBXmsYhb6b4xeL976dRtvJurdNXt8pX50qmxwRNnKIlHwCdyg8gHaoKPI4YxVp+ITWqWFAE4Lu2qnFkqDKGYrmxoUgk4VaqgAqUQcZu7icXNJOH9RoODiirlVta4lW/5TmXoVx26ZaanXWLPTPKrRvYQQYjGsCD/ZyvxE5cbtINXsHo+udRzTa91UgzECXKm7R4NxwpVngh1Bb0zH11MP136Rnn+0Nlq5FIydx9TuApscHJL4W8XVz+PI6rVyhMRfstJNBC5iOQNaeX4EQDD6MfAwJqUkJtAQqY4wnErStleQRCjUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brBeZVYskFsi/K8ynm0D3tXWGxunNLJsYcaI2D+p9vc=;
 b=pS+A5HKUNE0JUfqi3yesUioSEA7FHufac1vFq5d5E+9IM2QGV9fW71yjsXBSMOrJMx9AxV8qolxBZ6E1CvsJpM6fDpSHpsDaeVyi9LfBXks9M/PWOhk3GbI5kQyAY7jmwk7uoPzqjehs6pJDiX+mJrAhVXEsGNidAVjJoaLXm5Y3fwUeRp/LXgGzbwcTAyVzoXiuTSUESRf0aKPcK9C6vyJNxD2Ev5nIbrWmm9MwbVRDxEFPS14LEWBNxlIUB8Z+JMAiYFdypvlilgBUjir8xc0TerP4hvvYL+pbI3IvCzbV9Ox7DeQgGKOSSzAwTkl87cXfxnwF29Zy9R8hhtfYZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brBeZVYskFsi/K8ynm0D3tXWGxunNLJsYcaI2D+p9vc=;
 b=IfEM2g2Q9TLDxNRAKneknMhsmQwBN4VKK7P/w+Vg4oZ6jH2BGq3ajDa74zNkvZjakpZFVQoU9dDwHBuF9VKUccEbEJ6URYek4Q+qFVJ3xlm6N7BVlgnRi6LNsf8Nz5nZ4EMLxuyQsq8kW2r32HP2dl6WFiPlUB2X5xKr37I5TP58M3qXj8v2o+NqJfocdfz4+RdJ/8/Xj6alQgZwLXmz+88EiBowAUM3PQ6PZf3BQc0r6wx0D3fy9cdbIiFb+0BHOOfVaDx3npeTYxiEVvPjx8F6hF1xB39rqZ3e9j2ARy1/AjMePUWud+BGuh8HyO3rBNDxS98G6hQPPzv3Pkq7Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10499.eurprd04.prod.outlook.com (2603:10a6:10:568::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:04:43 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:04:43 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/7] bass: Store Broadcast ID inside assistant struct
Date: Mon,  5 Aug 2024 15:04:25 +0300
Message-Id: <20240805120429.67606-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
References: <20240805120429.67606-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0043.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10499:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d56a3b3-9997-49f3-fb65-08dcb546cac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q0ykqxTYTpJNOtmdHQHJgfoZV+nqXQ5Xug7vJyK6HFDMOBCS2cw1vTNBqR8/?=
 =?us-ascii?Q?wcQeimoTWzJ/v5e6WhYMYCl51CCwQsQzP/IDyq6a10W1kKlf/4DNJ/8LM6Dl?=
 =?us-ascii?Q?6XrWT60JqzSeT78tVD7EvYNAKEPWVs4zRDz1AzH1uaVkri+OF0liYsd+H9Uc?=
 =?us-ascii?Q?C1kldO07/rp6f8bGE1prAf6ePmER0+sYH/Y6rt2s5CwfiU5LvuYwY5TTf8iO?=
 =?us-ascii?Q?0bwepK8MUFvlmYHygTk0YhM0cQ3FQ07wIUy3uwZEHt5Y4CjIH9DgFYc+tHJT?=
 =?us-ascii?Q?vZfli95j0ncxf9tbWA2C4kl8UWRP5zp//B16x5XnIVakXXdorpEvQfO5Sv84?=
 =?us-ascii?Q?i1M9UTWeqcgC3+7h+klBlt8VN37X7q3bE56jr4Q36Vx2gKBapEwqwI7DsJ96?=
 =?us-ascii?Q?LzV7SDfR5/BZ48GacNMMLQZHUn452nY2r4fwRONBjfyd0bA4SO0/Qr2xfb39?=
 =?us-ascii?Q?Hwj3kpTbP8CySLExgL6ZyqwcnVorH0oR+/xwMxcttJ8DnxgwbB2CKqlG5X/f?=
 =?us-ascii?Q?abwvlYsjd4O8VJNVoAiC35u0dMAZOc7M3L4Op2RouNIO7o8hBnUW2S7jDW3D?=
 =?us-ascii?Q?yUtMF/W+b2+zvyk3XNI+CnI1MRekNz7NB3gARX7ugxEXe61mNz5ROLr+dvo+?=
 =?us-ascii?Q?Q7AApO7lGD53mw4qyBaTYJBrtHfEP5IBtuXM5TOINRBnKpRCviDupNww/D0f?=
 =?us-ascii?Q?6BJJxXkmwrzKnnq8VgkcajLUMkhfuLX9SH+fkBv173IQL4gN3vC75F3oE0PW?=
 =?us-ascii?Q?LbFvcWjhiRN4I0gB+GOD//3G1FkwXTHRFkHjtCJm2l1b01QxIhT6Ms8bJNAP?=
 =?us-ascii?Q?8GpfKZhzZDVEa7FNIxxakPyETxBpqEgN2z+mhHOmU+K5oEz7RLT0NQwQaZHm?=
 =?us-ascii?Q?rsbDQGnsBlCmQUmpEEtOmVqW2ygfxdGM1/jhh49Ywvs4wKhXcGEEDSrUPg8v?=
 =?us-ascii?Q?P5Ptmyo8mT5RlbrqCfOgUrJ+SKMMKS41Z6GcEvbhoY7g0mXenKIYu/v/91gk?=
 =?us-ascii?Q?zrrSoD/noP04aAhcejBizUD19F76VFJNNuwUEuOeKjXQmTrqln8d5vv2UHnm?=
 =?us-ascii?Q?2GhpgiNGGvfZKCO/uaCMGp9LUOVdYZjckW9pejmBiMsPO3Qk+pf8BKE+7v39?=
 =?us-ascii?Q?Mqx0Gobrp72FMTiNv772Z/OVYHWLB5MBAEkmSCuHVgVrl8zvO5JswCj8ofbS?=
 =?us-ascii?Q?fzkG9c6qLgAza3uu+b7nBY8Qm2bTHAlBdWdQd07tTdBUeZmPAuHlMZVtJFNh?=
 =?us-ascii?Q?374e/bZs+t8r0JNivHz+3mUaiORctLv6fDef3ZAn8iQ3gZd6iKFBcst9oPRb?=
 =?us-ascii?Q?dObfP+iaTBzQ7EqBYoAvShp87AsiHGaa1+L4c0Kyua3wBw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+urYs0Oi18TGVH/ZiEXuQshE0iOwBhUYnjrJ3Wvsc4/UvjKhjBdn/D7mf4yh?=
 =?us-ascii?Q?tA8KWtBQYc/CsRL7dtGHLc80kcx7puHXOdNftyR2Hyz6mpPnBCem1FLv4O8L?=
 =?us-ascii?Q?Dd5Pp6QJmf9RXwXHwONjuMEF08R27F+PTfwE9sBAted9q0rfu72T4yWigpvd?=
 =?us-ascii?Q?l+haNtSZKvRP9UltuYsvEDRXBdKLAg3y5bVfJUBgySUu329CYG8/YI1nn0TU?=
 =?us-ascii?Q?1HuU3cG0td8Zmrljcqzne4WwpXpd8zc+4sPp9ri73EYKHYYuzNIq9RKQUWHK?=
 =?us-ascii?Q?ePZAshzM9Fzgl5Ysp2JQGwd2bz7CJDGcRL2GX0EiFDrdZDKTP2iaOKt72UQ5?=
 =?us-ascii?Q?Dq/m9tq/kDJL27xczYeYfKkCty84ajH77SYT2cQsiHYNOGKNnYdaWxEEhFSI?=
 =?us-ascii?Q?KUET9lhML03N9fjT8WggaBB4a1IWmfCtBkkYVfvLhBnWvki2s+nWkZ73xvcg?=
 =?us-ascii?Q?oruSCScVZbTc9uCtJGfjzI1fhGZaQcHGPtR8bTNwdVRHmG8xSqC60IFDUo8/?=
 =?us-ascii?Q?CqlD4L5fm0sCxI1aLNej3ofjVf3ZiaimJq2aRtm6UQDt4oLJ20zIcsXhhY9T?=
 =?us-ascii?Q?g6j3F5dJrjIXW1LqzFiee4YBc2T0jgmQf7UBrYz6Sa353v8hwBY2Lt3Hfdoq?=
 =?us-ascii?Q?BhSalSKUAjd8pjhr0WTaNC/V7RSetHcvobiIB9MpZ7R3J5eMIBLkibacNTHO?=
 =?us-ascii?Q?F+fEVTEzQuKcJNHhD60wbHue5jIEzpzZXIrYByRNDKsHLtqVKXJZy3oIJXj/?=
 =?us-ascii?Q?u39nAKtionHSd3YnWcWkIu+777mpNCxoAt3vYvoqcq0JKq8gj+0jrWM3H1Nf?=
 =?us-ascii?Q?t1CbMlSQccF+XQwyTmfIQrhx54iPP5/uLf8mjcwObWjsayPtWmvOW1SeM+z9?=
 =?us-ascii?Q?kYZokGTjZSeoT9V3q9TNmNPeV8jinTKvfSDK6A4tdfADjKVZS/h/QN6ad+XP?=
 =?us-ascii?Q?y8eQ5YxBNb2+OMXLEhW4Q9Gdnx4QYXumzrsT4bRZHsSIrmKsAXmDbLuh+dMW?=
 =?us-ascii?Q?uhkr0sVtN1TIMuu90dSj2E6ExOAO1FRmT9CsLuWbmYnVBxKD76ZoAy1VAXoo?=
 =?us-ascii?Q?paa2IK9LPb8j6YkEIuPrOU8QYciF5d738gc9JI9IdJcgJIQFRRTbJxdswY98?=
 =?us-ascii?Q?cxA9Xkq2WULJueb+c25bGshH6Pjnk10jMsAXN1CJObNeglpmrIHgMfQuiGAD?=
 =?us-ascii?Q?8K4rpq3ztYD4vIvZRsm+Kus4hJ4UtWteSK3uR9+99nUSx7rkK+hiFhnTLxHT?=
 =?us-ascii?Q?pV3TN5jqkTByPo3AAK78vJFQ/7/QqmjjV5arpS88Ra6A1Ts7H2uJCoJpbtF0?=
 =?us-ascii?Q?gyRtKkIOaE28oCriOrxTiRx9KAYxCGVqmCrm2CJdzZn5bvaAAojXz2I2bBen?=
 =?us-ascii?Q?GbSy/pI/mi+kqJVEarqs15Gp3JqCJQpdS7I1MPpabDgXRoA06N5skdHmgkjP?=
 =?us-ascii?Q?nsAjgNNMfJ/TFgrOy4GgC44BZf9NFW1pX6NtmtB4Oe6POdiOvRavzwTFsmXl?=
 =?us-ascii?Q?w68wH9OOKd5UhlHxWaYRgJz6w/dwavvOFfaEwKQuMDFUA3b0GPyCQguZXKl8?=
 =?us-ascii?Q?Lpp8IGN05pNXsoeZcQNiJK98Yh/mYSTM0cG8GTZB6EyxlW0S4+gOqX0tpcLw?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d56a3b3-9997-49f3-fb65-08dcb546cac7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:04:43.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQI0HfrT0t0SoCMPTTQ6hZtXx2e7R42LMD9+2SRbN9/G2KrO51D8Jdo9xJ9Be7X12zjBa/sw23PQB08amvKUhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10499

A Broadcast Source is uniquely identified by its Broadcast ID, which
is being advertised in the Extended Advertising Data.

After discovering a Broadcast Source, a BAP Broadcast Assistant needs
to internally store the Broadcast ID, which will be transmitted to the
peer Scan Delegator via the BASS "Add Source" operation.
---
 profiles/audio/bass.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index 083988358..795b4b80a 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -3,7 +3,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
- *  Copyright 2023 NXP
+ *  Copyright 2023-2024 NXP
  *
  */
 
@@ -40,6 +40,7 @@
 #include "src/adapter.h"
 #include "src/shared/bass.h"
 #include "src/shared/bap.h"
+#include "src/shared/ad.h"
 
 #include "src/plugin.h"
 #include "src/gatt-database.h"
@@ -80,6 +81,7 @@ struct bass_assistant {
 	struct bass_data *data;		/* BASS session with peer device */
 	uint8_t sgrp;
 	uint8_t bis;
+	uint32_t bid;
 	struct bt_iso_qos qos;
 	struct iovec *meta;
 	struct iovec *caps;
@@ -198,6 +200,21 @@ static void assistant_free(void *data)
 	free(assistant);
 }
 
+static void src_ad_search_bid(void *data, void *user_data)
+{
+	struct bt_ad_service_data *sd = data;
+	struct bass_assistant *assistant = user_data;
+	struct iovec iov;
+
+	if (sd->uuid.type != BT_UUID16 || sd->uuid.value.u16 != BCAA_SERVICE)
+		return;
+
+	iov.iov_base = sd->data;
+	iov.iov_len = sd->len;
+
+	util_iov_pull_le24(&iov, &assistant->bid);
+}
+
 static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 		struct btd_device *device, struct bass_data *data,
 		uint8_t sgrp, uint8_t bis, struct bt_iso_qos *qos,
@@ -221,6 +238,9 @@ static struct bass_assistant *assistant_new(struct btd_adapter *adapter,
 	assistant->meta = util_iov_dup(meta, 1);
 	assistant->caps = util_iov_dup(caps, 1);
 
+	btd_device_foreach_service_data(assistant->device, src_ad_search_bid,
+							assistant);
+
 	ba2str(device_get_address(device), src_addr);
 	ba2str(device_get_address(data->device), dev_addr);
 
-- 
2.39.2

