Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2074.outbound.protection.outlook.com [40.107.20.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5414D71B
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2024 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372836; cv=fail; b=P7Gnx805Bwks0fiAJGsC4/MGNaN5DWdgQB03TSmJSPv2Cq3bXFxyLG2ObXWxgMlgILmlh+HvEkWuPOvtfRrYh38zPrb6vEW8yywu+nZSQxCK73SWe0oL5bqppXXo7g+6pCInWsTCMtPpnusc8LOct6NVxqZw5E/2VXzGrr2kwmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372836; c=relaxed/simple;
	bh=pZ+ZTVYZAot6kKHV2+SDP1gN1atAvVv8UY0m/Mel0WQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K6C+vE5JNsujsIZoXME8rNzdG3YxUOYlkba+YjLAixoAzhUmIdXSZ5ZZvuhwpo8tabY5qDCbabj4qyeQ7OPKEvoko8XUXNtUcp5dSHJyZ2qLUAhb5Tn9Cz5pst0F7VA7o4GRmIEDLg/W2v8lBe9QAeP/G26QUh1bIdq72iFG7YQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mc5GCX61; arc=fail smtp.client-ip=40.107.20.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mc5GCX61"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbicKE6O7HZ+zpflR/nkQk3FCrUvn6DfquzksJS1Ivvhd99hWEusToZKJ5zcW0MMPQ1SDIy0oGMLbSAnPjyZ9bcVkmZlpwCTboqiQDhh6Ly/8ZsVpuVJh5nKOOoCEVIukES9pPQqXu/a5TSM0dfLaJ1cIcZCia7jbW16dgfuIuzQV2/oQKhTSiuvEbz9tlETE0VdmbYxncJdBu54ulOC/ty2GtX6pWgCv+qXFAb5Ylvh6yxoiN7g0YSuaSGX3k/uuRkHkL1BEzTPKnFl9h3W+bpa1b623EJNXe6cRjbe2ctNNO8W+wbKNVVIQto9jOQPMQPxW41/wJ6aBTX0pWETLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xk34m2+gEOBuXeyXrWmNrmbNdS4oWAP+qbfQgDqdjMk=;
 b=GEJTGQF4thYAPKT//94eD+WcnCUkrLaaNDogEbHxGr6Q4wyFw6770SqMipGfq2O0j/GNXuXp0CrxkEdR39MlSqYL7CmYjvjL64KuXdIXConZJKlGcMmUrPJIzkOA3hGG6/T7Vl8rGHu2Ltucc4L5d8VlPq9N1bL6HZpHqby+UpjNFm2gSEnuRu/S7IHRIbS37QGdrQSRQhd41NabFIssqzkbZcOP0avoka2TWX4NbrxomnzfgHJsxraAOmPDfxBwruVvfDr2Vgwr7Tkd5iwKCLIWsYhy8LgUV4mv+c3k9w0THA5gpv1osG7/Jfq/0Y0lpLqmcGQlVGNmjyr5xgiGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xk34m2+gEOBuXeyXrWmNrmbNdS4oWAP+qbfQgDqdjMk=;
 b=mc5GCX61EoMolosW+wMOTX0zxGJbV9VXD1AcagoeKB3avnJg7BK6uShM93H4/SNDGia6e0BicllTekhTSWEeudVjUZwTTJUoHtnMe+MpDmTKNJ9N7ReQBpCQdf+JKDH6Wc0aFBG1Y7KGLU+87PJfSwYeFIKfYNUQRDtNpbj8c8Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AS1PR04MB9238.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 13:20:30 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 13:20:30 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] bap: Fix setting adapter address type for unicast
Date: Mon, 25 Mar 2024 15:19:10 +0200
Message-Id: <20240325131910.324811-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325131910.324811-1-vlad.pruteanu@nxp.com>
References: <20240325131910.324811-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::9) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AS1PR04MB9238:EE_
X-MS-Office365-Filtering-Correlation-Id: a630aee9-5816-4660-ad18-08dc4cce57ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	doXccFf1yZ7iqEtA8qmwA6qOTFQo68HXReXvc1oChCtRslnkKlYQ35TIKbGiOuDzTecUuhUWR0Uh5xsCUYkE+0ya8di8C13lrexKjf34dUGqtZ7yquAIuFj1DmLvYl+KBgzPI3Wpf8mmJO44PHp8LJzqd6O3QWeSnThEOJs+UcwHrT4UTz9p0tslyk0JITFqQju2kvTYNCKs/zm1IGFCdjVUB8LShcmlFxx/jtWY8GEbwKOCMB+6vVb/yOtvbg63mlEZnRKu2i30OkmfYyFMBvUGSul+BrSYUU3cKCznEN91WYaebQ2aX0tFoKpLPp/Ct/O53htQxE4a1mXxPGelOL3sVM6crA2cN/P1Zm5lSxdsjRbIt4nxl5bKq/RTe15K2LtXSHVSA5V+HSmJiQiLXghq+4yzthc8JzcCLAzY9ju/TLeZVxuX9OV39eIYaDYLIkd/Sq3BQJ2wRlLE5vBLxhjZgQWQrYgaoZAGi86E7+YaJ1uGrIuG/rVYEjPoto0G/sYnf+dJHPMVvH1otBe+3YSlLcz0VN/TUB3csis+kDg3yyNOQ4itrj8Z+aJhYT6iVmNvZLpXQQJCnkIwx/EGHClJuqCYLfhPwcbLFCW6p3nvI9lQi+7hyPLkRMIDzyvJC7GzSrSfox2BdqeyU41+p6CwuIpT+Ypas5JkSr8CQqe18DJtHJnYCtu5d6dpdPolY80qOt+9JOfYIur+rk5WHeF3rhpBg5uAXDS2Jz+c6BU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MnIhMLcy4uzPJ5sXY3RRrdKcJPEK+kmRFMlTs2iyBapAR3+MqBQRbZ8lnzn9?=
 =?us-ascii?Q?LiJ5Ze8Ne5RG2CpZMvLzferBdlwzwOb5E5LtRdABKW2RHrLo2aHbSoPka9W7?=
 =?us-ascii?Q?ywrE05GxSaERZuvqtvDXWIGKShpRLP8AE8IwP6LRnxSqnzuiKEXmOC4iBBeJ?=
 =?us-ascii?Q?hn1ah4U9jqJmqvD0lq7hV4tM9iZF+n1Z611LuVp0MJMYW/2IXrDsqDT511Aq?=
 =?us-ascii?Q?Fkheu3u86qabCsqwhl2DUpxxMILiHrCnllV2wgl6oG1bn+BPUNfZETSzqFti?=
 =?us-ascii?Q?9aRiv69n4y29fw6DbBtGKvQ6uM2WMTBpgr3r07L+/3Pm9T3QYhIdWtZj2hsn?=
 =?us-ascii?Q?4VuXSSgEgrK8XX4JhgFDoYkcxx5YqDX+3IW4tRrtVqC7RrLjTVsj23SSH588?=
 =?us-ascii?Q?0Jqc6STLLb/qhZcWwc+Wpe2j2Skhyno6mLl0hJr8vA90mFlYOkXwG8cJRZ4X?=
 =?us-ascii?Q?VVjfyKTyKmgbdSEMkPAVV0MTK/RaH17LcmPCuH1HKLNiiepBf4LAwXqsnft5?=
 =?us-ascii?Q?yT3mvjIoMw6bLiZ4YwgzCAyqQAZo+7OWX1Fv5QlVvQL94sKS/fw5b8lH4kEi?=
 =?us-ascii?Q?CleMA6iBrSruzJuG6TxD7TE8YcEpTJW3nDpVvProRGUCeWPrFSdj8uuFVxnD?=
 =?us-ascii?Q?6096AJVrazEKPoHARbaUAFQzWc6PfvwEOoUvU3GunYWHPDTm5Jgg+ZgFhEjJ?=
 =?us-ascii?Q?XhFLbC/f/Yuw16eUgLynwiApPVzmSiIjUbQ6XHWubKg4bRaT3aanM0tO082c?=
 =?us-ascii?Q?SaOI+GmX8xoDXROBhSe7mvYJxKSIGHAR1S/uiMKuckm9EqW6vCAFnADHo9oP?=
 =?us-ascii?Q?BB/nIWMa22ts0WnR4R+ywTCoAi9VFUOcWxzWVrR3WfXw55IyV1L864KPUZda?=
 =?us-ascii?Q?EBNZCz3KjqJA/iJBTsGS5R/Ug/6X5QZAGq4ACr/+P0TfuDJ6EAplZcSQnfjn?=
 =?us-ascii?Q?0YEH365LwmonwECFnZbGQNQszI2tcw2NCp5vnZzOrRAoGgadwn329q9Sateg?=
 =?us-ascii?Q?RfVfI+4a3lEdMZtz3LaYdhRCyo0g6H0dIJVv5s6tmrLm/U9XlChyrb2NTLO+?=
 =?us-ascii?Q?mxQQhkzLjr/4NqTB/wSHhJ1Olo/ES4EagxSmyLLGYli4Xl9ICEcFM1buJRbC?=
 =?us-ascii?Q?ZrS4bTHmMGHfcctAj2UyR0oePwCtm4eXEPVuaObxKm9+u6ya+PENXFg4WMZV?=
 =?us-ascii?Q?t9IFugXrmXOXAS3/iIykG4wlV+qoBtsK6yJbRAcChL7HmH1H61dHQ4CO4sOB?=
 =?us-ascii?Q?lGGcxlEeF+kch4I0a63rU2WH66fpP3XtYzMFMl/wSeXd4DMAX3lOZqPnUVZC?=
 =?us-ascii?Q?GMgInEzFDRqvRUk4O7tE2SQpyToaHjmduUSerSxoHhv7BqXR9wr8Qv/Dafrs?=
 =?us-ascii?Q?ye5mXfvA+PhKMUGDgOJU7GxxFLGzkmrq4vC/2MZLAn3FopvWGUEIbLiJquxL?=
 =?us-ascii?Q?q+PC52khGnL4KsJ0YkAomaTMXiKIfiR2SAG6NK+KKLi2VQOk9T13zf456rfG?=
 =?us-ascii?Q?QrrDdHocul65zFdxi82OkU4ADe13I/CktMSe0nZunGf4pSo3oUFbYQHZc8eh?=
 =?us-ascii?Q?/nh5yVns5TD8han9HDs9plaUHqIgs9zZZl5MhsYo?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a630aee9-5816-4660-ad18-08dc4cce57ff
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 13:20:30.4681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOlJQQ6TiJ/VeCH47+SbqdIvlAzcEjhj3lsZyqQP33Ii3R34YiCVTbydfnEsgaKttlhFZn3FIzHHZlwNbLcaDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9238

This fixes the settin of the adapter address type for unciast
scenario. Currently the address type is searched in data->adapter
however, this pointer is null and leads to the crash listed at the
end of this message. Instead, the address type should be taken from
the adapter variable, which is initialised using device_get_adapter
at the beggining of the function.

==321444==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000016
(pc 0x5601d284e03e bp 0x000000000016 sp 0x7ffdb164b740 T0)
==321444==The signal is caused by a READ memory access.
==321444==Hint: address points to the zero page.
0 0x5601d284e03e in btd_adapter_get_address_type src/adapter.c:545
1 0x5601d27a3f78 in setup_connect_io profiles/audio/bap.c:1860
2 0x5601d27a3f78 in setup_create_ucast_io profiles/audio/bap.c:2053
3 0x5601d27a3f78 in setup_create_io profiles/audio/bap.c:2106
4 0x5601d27a57cd in bap_state profiles/audio/bap.c:2143
5 0x5601d29d30df in bap_stream_state_changed src/shared/bap.c:1250
6 0x5601d29d71e2 in bap_ep_set_status src/shared/bap.c:4395
7 0x5601d293d592 in queue_foreach src/shared/queue.c:207
8 0x5601d2975c84 in notify_cb src/shared/gatt-client.c:2257
9 0x5601d2964217 in handle_notify src/shared/att.c:1012
10 0x5601d2964217 in can_read_data src/shared/att.c:1096
---
 profiles/audio/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 315eff729..030aa6ffe 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1857,7 +1857,7 @@ static void setup_connect_io(struct bap_data *data, struct bap_setup *setup,
 				BT_IO_OPT_SOURCE_BDADDR,
 				btd_adapter_get_address(adapter),
 				BT_IO_OPT_SOURCE_TYPE,
-				btd_adapter_get_address_type(data->adapter),
+				btd_adapter_get_address_type(adapter),
 				BT_IO_OPT_DEST_BDADDR,
 				device_get_address(data->device),
 				BT_IO_OPT_DEST_TYPE,
-- 
2.39.2

