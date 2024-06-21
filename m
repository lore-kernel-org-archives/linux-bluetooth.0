Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D65126AD5
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 06:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952246; cv=fail; b=HmaF6b8jYeEkyAzVlYGyfbv9UHHANgDJnjhIge8uRPUnVNtV4qTF0qQYSFLroOIum4qTEvV9pOs7vgmjGhrjm2rIl3NbSyZmeOhcQ8zt5JHZAv9eZjEE+srItNNTsY0W8OPGvBtCHHaKfU24yVs3QP7nUGs4ZJ7XyUmpwnAYA9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952246; c=relaxed/simple;
	bh=9ygT/nw04k9o6+yGAiePs6EorYjO8PVnGEHRU4g09iA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Q1lBnmRth9YVM8itogB54FLm+urVG7uWl8Qx4WfsL7muPX8dSkhLJVfa05/8uSVGjn9iRr7sK6Ky3OGZVBdIQUUcrjteDNTaRB0JmT1HjlHlx+jWv4a9geQ/fd6lValX9rzEHJLLtpiOxRQU/B8zIhdjrSjukSbroft4mYK9+s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s90QFnFK; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s90QFnFK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YDB+jGZO+4FufzLHeVxLn1s3lCaX0v0BgXP4o+MGa6o0qgGdC0eXWK41iP5ke5uyx9BuHbXJ1FLrM2+qltqf2L9fpm+gW1JEvPscTKUGAItiyaVklDPW9R4uoja+nowssjGULFWzDkStjzeqaP2fWmYB9ythxSf+Pf3ZrgeOr3Cqebs1CZWuyjs9BmVtvqzpvVhkQ9EwWuBaVhO8vXV2yiTpNwyGtwBjM8unqvH+skTB7p01fy313UfTmyfk10cLAlJ/XSmha7vXs7lE/N0CDAA2dPyOyBLSJrY6iNzNQoayTSXfhyESJPs9zBA2utCMlJv6p05gaic47kGSVCQLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p9EqBfBIp5KYG3vtwyHy5c4GvPtnjlQ6SU7eZLgxbFk=;
 b=O4PlTim2D1LXhsJaR6qU9TqdG6LqBMoK/91N/QSMXmV6sKkY0d7+K8/ci2UC6l9diiKgfcn+vZkLRZo8uVgbq/ukI2KtEDuCvX0xjlm79WnWGn6f9Maz9zj8UOs6I/l8wnXrhc8xGxFPx6g+QiaZyPa3PqOMJp2E7ssKmtLL0y78c80F6aFL+DBonwLXq4gynBtKSooCYDDqkAHTjCNRAClqTsH5GfuIpf7x6eCMrTxGVyUFRQ/5rlFfpQOL/YqeYCxmGtrAdavicg8TDJeHbqRzxkdN200EXG4C+9ezEEJY3hcuurDvsdjupprpTZTrKprJ2L3M4cGyxTZ37BsF3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p9EqBfBIp5KYG3vtwyHy5c4GvPtnjlQ6SU7eZLgxbFk=;
 b=s90QFnFKD61U4WBeEL1CmjDR+s0t+DHCZXWxVY+rdLyN4I8ZJIkoFuwJZ8w/26bPzo7eU56C4OR7EFCh0PJ1BoAzYwuHVUluoiN+gj7JxBfnzWlXM1fZfEiltQwpuzoe0XVJ9XGg+NumSrb88RHwuvNwwyR/mUm0/I85kMy9g1I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 06:44:01 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 06:44:01 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com,
	vinit.mehta@nxp.com,
	mahesh.talewad@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v2 0/1] Fix null pointer dereference in util_ltv_foreach
Date: Fri, 21 Jun 2024 12:13:41 +0530
Message-Id: <20240621064342.33664-1-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.21.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To AS1PR04MB9630.eurprd04.prod.outlook.com
 (2603:10a6:20b:475::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9630:EE_|PA4PR04MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f18ef64-ba58-4233-86c6-08dc91bd88b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0mprGEi1uzRgTbwhEPEMl6Pazpt28WbwFSVrjfu+il2siKNSZxLCNeKzC3GZ?=
 =?us-ascii?Q?IofKIebS65Ldnza+NxXc+AcORhQGlhiUPz5nTSSADaaEcxurAQOI4qjVwjeN?=
 =?us-ascii?Q?QiAm1z2bt9IG3onW4/jtlRTNXsloyXBmeAdLhYo0E8TzqajE9a0S6QL07Auj?=
 =?us-ascii?Q?c81xGCIl5gb/CT1zRr4cRlvDhndDO4KB472JNG1ExMQx6sh546KwRdQdGFVY?=
 =?us-ascii?Q?CFZ9g61BEBpcN6/bJ1ymmDA02PKQG5MULLiHT0O3tma6xb8vxnvJXkcjCLts?=
 =?us-ascii?Q?jjuFG36xpVTPY60aBcAMVHmHSw4iiJLNwyOaOWd3aoLgBj3DA7HwPSAVv7Mk?=
 =?us-ascii?Q?MvgDVdaKzVXozGtE0zHZz0MQH8hHkPBVniSjIMWjd2t4QmBlR/++6kQL18Oi?=
 =?us-ascii?Q?AA91RPMEkwZd9lWCfso7UXiTL6LR22ZEF7+sDQ0uP773OdW5527IzHpvRy6p?=
 =?us-ascii?Q?4fmclV2w3ISM6RUJkO3zuguXQmdGg2p1g35FDxOjAZJcLGBnl9GofRUHikAQ?=
 =?us-ascii?Q?zbutKaThH/WUD57KlIF+W8WyaSzuZvsi4elCXyWWjQDZPjqubLUPXryw4PUE?=
 =?us-ascii?Q?kaL2ziQ0r1pmhCNB1hYUYz8yoXCdbeQYvPFB0hMSwyU3ea5NrkARzPDMqTka?=
 =?us-ascii?Q?RPDkAcBgvyaFEzIaWjdw1hr55cYxB2RGidWu4ze8WMqySPeBGQeds+R1/J69?=
 =?us-ascii?Q?caHnzLyea/uHMPtNTm5mz3wTjyIS2K0502BUAmijQr0f0b5BvS7JIWO4U5SH?=
 =?us-ascii?Q?siadwKsqib4RM5XRkZ7In48jTdI0ASDwXTznH0om4KumF5fwo4hXZJLj5HrC?=
 =?us-ascii?Q?1Jrz3HfRO6bsaSWuGrroFPfcKQFD/wCLDdTL4aOf60XG/p8oGe0KdkI9/EMN?=
 =?us-ascii?Q?Yo1w/kKCvYmx4rw8ZArtpxU/QZ66QMh5mqGig7IUooGrCOg7btEnMvOP62ue?=
 =?us-ascii?Q?gBRd3Ix58kXgNfvjii7XdYrlBQIt9u8OtzQZX3U4I/r7OXIrl8KX5rcdHdAw?=
 =?us-ascii?Q?vEfqJs71toUyTATZt8hwH6yDKFWd5vFFh9ZQLtPt1qiam+eXzZRuNXIj1qtG?=
 =?us-ascii?Q?s92cN7cXb8Te6/x52TajBap2lnnEHe+1hhmYlPXY4pss4je2d6C5HSfxfxuy?=
 =?us-ascii?Q?XPmpzdkuzzT+KhPfIl7NrutBDPunh+l0wGnH46c5Hzj091zkIKX62CFitBSZ?=
 =?us-ascii?Q?75YOHTQJdsRol0Q7CugTkGavgnyyLe+yMxrh3vPlYSqqAxPyyjSfDVsI+2Wf?=
 =?us-ascii?Q?ALJqOUWMlrkTqDMkB6T/aw3NWvON+8+y8w2zHewnq2Pho24xkz++BcYGtWq6?=
 =?us-ascii?Q?hrEFZHckshrxRhexuKDJD7RNLOoqek9dMoWBZ9luWI7G02DkS5a8NRhGar7S?=
 =?us-ascii?Q?591XE5k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l4Xi2/9cnT3AtPuI+lRckNfz1TM5rXcILVUez6FIxGe5oPF954/k67uhwMIy?=
 =?us-ascii?Q?2dhbx/kDB0I7XXNbDYUJkKmvuMa28FAvipIgfg9Ny3VTpaxMAoa+mdpd2HQG?=
 =?us-ascii?Q?/5rgX//azAjJX54uvTzKlFj0owqCRppjkNlhCjSqHdS+ILGOE7sf/WQRY6Tf?=
 =?us-ascii?Q?TE7Lg+8VSQxMK/miVlQ3YfTiO9z3cgcgLEq0lLY1MuOOsRk9vcINyhDMs+gT?=
 =?us-ascii?Q?ZEzWseN41Eivv9DEPupUAEIguvfKWnjLEPbi2Cp1O/t+SCJrjgZiDm9K8cHj?=
 =?us-ascii?Q?LuLQq5QzB3sKp1POMMMiqsuykVZCNLO04+DLcqlDo7053c0LJlA9svTAaQX4?=
 =?us-ascii?Q?dY0BIn+bLGAgzb1mPXJ+Az/dlKox6MducMFWl6r1lOanRe1xGO3zdMHOZmIQ?=
 =?us-ascii?Q?p6yPg28BhWGecn8svB+lhu9OqkERZKEr8tHQFKGlomxgP3FNP+A/MKOFdVdg?=
 =?us-ascii?Q?WeyIAZw4js0iv3wbuR4rj2Uzla9VfFhLxzPt9sm3ectZZtc5F6FFJiiFMEE+?=
 =?us-ascii?Q?hsmXmH68I+HzmyNQDFIdKFGZPfQT59OEmGzQPRUzbaTlXDGoMmFDGSYNRraE?=
 =?us-ascii?Q?iTu4vUPlJ+CSU6InTk47tYC4/zsd2QlQwRhgSoIHAn/JVS1ABQTGTMeDtfm5?=
 =?us-ascii?Q?JALEZswkqF+yAdKXQs15TvGG3ibtkQvHAbfVWzA0AfWq7nLOIVulkOU4c09+?=
 =?us-ascii?Q?+3jdHn9ZOnxITOff2pP1E55RPBhGneLrCOl5zqPwY3BF3d2J7DHs2B4mEYbo?=
 =?us-ascii?Q?w4p+kk/SsBc0eBM6budui7CROYyjfzYDtuJ4freRpWFmCzAkJLZ2rFU7l4SX?=
 =?us-ascii?Q?uuSq6aBB+d9g/IKpHPmC9n9i+JNI3EEZEr/bdZMukxijXKLVpwBnYLmd9/sZ?=
 =?us-ascii?Q?jAS1HOxJ8VCDrVltLYxrv9oIJLNlb9PoxIVTHxXrFoYyHKa5qX41YIsWseVi?=
 =?us-ascii?Q?vXa4iksmX/wfv1Q8KObuTzj5tTyT+9uvH6HqnTUwIa3m06dgNq4m17uB8C2w?=
 =?us-ascii?Q?kHdoAvgKiiWbG5EtsOea1W+0ObLezUAVjHDCsAtEgXdI0xwxuP1Be34BZ487?=
 =?us-ascii?Q?TfWQhvLuvOmRmdDHFBnjBwwqKATHz5oM8H4B1BBRxL9eEl1xHMasi5PwUlRc?=
 =?us-ascii?Q?ivFcRlDcxavm325xKk+SrOrNgpBR1JoctpXeAhB/q4oD+wgQ1SoTgIz3I5e/?=
 =?us-ascii?Q?8/xjVwB1vZSibRaSRB47t4i4Fml/M4SuqSxIDfE8mv9tKcYTh4H29WL/tV0b?=
 =?us-ascii?Q?O3150mF7dkL8LwZXp3DWG1hXpxSUCVrHYeD4uWHqgUfmY0zTls9XGPmLhZsL?=
 =?us-ascii?Q?MJtAsSZgI8SQvrxcVwhpdEnbqD8ythdw4BBJVmu6X0RqMBkqheYRYgOPzm11?=
 =?us-ascii?Q?ObCtlT6WcxCEc1XxdcHuH8VO7Jr9k6dXM0QmOnB98ZreVUrOOt+e0Ed2PmY5?=
 =?us-ascii?Q?RfTTnKjDLDN0SFshuWfmY39qp+dLIdZ4vDny8CttaqXyZZtzuoLD26hDW6qC?=
 =?us-ascii?Q?Pn7j5G48RDiBGmLffw6YvS5/nzL4gHot0JpJr/0RFqWAj85OcXT8xPY2cmDe?=
 =?us-ascii?Q?xfw9aQfKcQyDyFfeCitRhINHmPVKjkIXQO/k1HCfwcnzWwZgL10Yvc+g3jjH?=
 =?us-ascii?Q?1Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f18ef64-ba58-4233-86c6-08dc91bd88b9
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 06:44:01.2508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nf2BYC+MHBWXuvzaUqVLhLrD0xwCb4b4fhV+96tFKv0ksJ1Ux3BUlwB+AWEMNMSx3PeVUDWBMM1gwZR0ZqSmFoBkMus/j8iPf6EizhcY5iU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461

In the existing code, iov structure is initialized with iov.iov_base = (void *)
data. If data is NULL,casting (void *) NULL to iov_base results in a null 
pointer dereference.Inside the loop of util_ltv_foreach, 
util_iov_pull_u8(&iov, &l) is called to pull uint8_t values from iov.
If iov.iov_base (derived from data) is NULL,attempting to dereference it in 
util_iov_pull_u8 will cause a segmentation fault.

Added NULL pointer check for data so it will presvent null pointer dereference



Sarveshwar Bajaj (1):
  shared/util: Fix null pointer dereference in util_ltv_foreach()

 src/shared/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.21.0.windows.1

