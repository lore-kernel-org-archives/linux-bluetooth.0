Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD6A4AEE8
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223701; cv=fail; b=LkpwUrSGeDcFe19M5DZDZpiwFl4gixI0d0+SDReUR222VxNW569UZnxiMpzHcgKnhbmS0ANjC4QNNzTvV64G/mod9d8SvwpH/av9La6LMn0fAKtWNLB/Iv/q6E+9pbiXYvtEfiDMcfdfHy6tGKi8OqSaQcDOnO++ayi3YG97Pwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223701; c=relaxed/simple;
	bh=DbZsCcEp/j6Yhje72iFyoT0oFo6AmJJggnbP5WvHSdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tIiA+uLhttasnGYCYn5NA0xcW+V7F83xD/Gjr164m/KWLViVElT0FzbDDj0MTvt3GYJpx8XaL0v2JMfCfYB42IQ4Uo6NeuA0xJV4NsXD3v3ZuE8f7lo5ozu93Mzrnpels3E1id4izx6J9j+F+uyzbk1ZPcf5ape6yNpJpDQXegg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=T/sJ7NVJ; arc=fail smtp.client-ip=40.107.7.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="T/sJ7NVJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TegSzKLoAt6EaK51lCS40CKOe9bNxYxuuoTzCtkICg6jm+QAiAUq9HnGtISJOhJllAIomuQjErAPz2wzz0CRiOM0ot0s9HKQDnzgrd1Zj5KbwxUdzdrB4lIyLJJco2ytqisb5uR4GNX1xXp3GfXL/bSOKQlEPZwYcttLQm3bqUERNeKtg5ASgT/2uVrYcs415DFC6nQlVA0eIsNHkb4MVnJ3rO+P9+CIv5sJVAimS/Bez/PxqUgflGgVgudry7yuDFgJjtSEyEsD1l/KlqtusBGi0EnEIxb84tkQuDwMceHNbypQUIAf2I2AgOMhVZj0l1/A/nuYSVW8e0ad5EYFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6EYDpwCy7j54Sm7LCgNnSMqLzgXqH+MfqZgaUDUlOY=;
 b=JQ7NxL8+C5j1jqLX68zrUImmdWqkFBla1DesJ2hSw2lh9VoidwUAKVAfa/SkzyXO4KX9YOcyoue5ZQOixxpzj4lu4pchGO+TqQ5WjATxGJYgkKYIRWoDbqhndrV8fzNyCBB2WoH2KyH3CSjYjfbCBkULvOYhpCmsFNxQ1j/Q2dWudx09x1xqOaF80GWOZR4aO3L7UxCzL8aP9RTBzKfosa4cHvJV7dbjA8eGsSjalQ+66DoilyR2n4eY3zr7gt040LtCbV0mLYKSnanrrGtJKdMusLrKdUyvl0TJgNjZdE1NM28tfnxUnJI//EWW0BuYubD7N+uaktXj7hV/CfL6YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6EYDpwCy7j54Sm7LCgNnSMqLzgXqH+MfqZgaUDUlOY=;
 b=T/sJ7NVJGaUl/hG94pxdC8ba2WGnarwO3z1nBiwL23P4iia1M+UufHN8aAu1JBtnoffc1id4uPrnw+8NyuzavCHTMsep8qlDryo9joxeUV7dz1tL+E+K7hLgamvRkb1rY1Ol/Fly7eQr2RUpzSnbcaufC+k8x5OuN3aWhCoQilw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 16:21:34 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 16:21:34 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/1] Add command to create local endpoint in bluetoolct
Date: Thu, 29 Feb 2024 18:21:19 +0200
Message-Id: <20240229162119.57523-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240229162119.57523-1-silviu.barbulescu@nxp.com>
References: <20240229162119.57523-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:208:1::47) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae897dd-91c6-4885-375f-08dc39427ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QHbNy9fmwnR/6/Eoo3lv0/ovqZJMvLTsvEJl4PZdSut+m7R8AKSFXk4kjcsfgRsrnEIvTRcHpHYqesTKM9jco6AVl7foJ6RYndVgHbsznBrEi50eZGeqjO+mMT9oGECNViCOcxNc7RKiv0JioeJzfNDydx5AY0TbNGokXVQSWNDasMAaDLenFXoht5fFxgnB3xjwwjBR2sAr9bKNoqxh+4qz+S3lb+gfDdPn/yRnFEinVtv0Osm9YmT+YqvLbWVTALjpUy0lUaE46n1XW6H1zfTsjDQi/ec+ImlEbWwQxUokjBC/twURacn+gYM1G+aGa9sTSE5JNTMEn9sjPabYudQ/CFKEVXO99YvwtyffUttzM2vpXVCWA8yMyO3YU2zdfz8t+B79jru/I3pOQJ479OXhbDQYZUv2tnt1i004Qbr5SNDcBRcVg3ISCc/rtp5tWcYjZeGHi6DBmhPzwvLTHl3pRnrjsYB+H3MHCSVhe9lMJEUTS6ABLL6gSklfQ/SycgVTGy6YlhAwgLDCSayI/aj9RTl8Lhlq9U7mqueVAIgJ4jS71D2OwScpy2uBbycavlLvd9mEUD+hR030hzsDS/ArlF3wOc7iyXsDIwoZjNPhXFHjIrYxyzj923FXn4vwcYmi8nUvN8+t5916VS3LZw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8+0PoYzDEzDcUfo4ye7+6fwC5JDyh6y92Yv8lGBElQxiwV6LH2ua7QGJTbJV?=
 =?us-ascii?Q?YalrYDWZUtyUIoZUbfbCPCLsa2MR15YC95AhObxkOhg9vibjHMaaViK458p+?=
 =?us-ascii?Q?dE9UbdCFVCPwvbrcxLtO9vs5wKH+gtfmi5hD7Jg1HZ8hJNOuRO9syTqU7X5a?=
 =?us-ascii?Q?T4D7YHvjhei/rqVLc179VNeCZzj14uiZ0xAq8s3f1276/sBFn+AQJx44Ao1w?=
 =?us-ascii?Q?RwUOYI/0o9TNsmu69wd/I3aCex0cji2N+hYDnITdZ0JIzIaFAbF5aYCPr3wE?=
 =?us-ascii?Q?ak72WsLHd1Z5OjKLHR0zmmQNlI6QupBi0dCssQfUGRxHZTfrMmgWX7Ox4jyX?=
 =?us-ascii?Q?0z1EBifPOVJbzu1olxgoGU0fK0YzlgV/9MI2DxDkB3JMZN4eqctJcRon/MXt?=
 =?us-ascii?Q?rb/VeYymewx7aUXZxFbDeVMUVSSPPyXqmaVpb7fKlj98nZT4bJGPk454n04b?=
 =?us-ascii?Q?kFJWA9xV7zB46tmMYr01TPVyCziSIKl/KSmQpisoM9A0y2lQnJsMImlb+I9p?=
 =?us-ascii?Q?aQb+KUhQ3VEZElecbeE1rshudLvknJCCZzgknG57NYgQ66mdOR2JWw/9jE4o?=
 =?us-ascii?Q?u8XyGAp+zuNEFjVDwO3Q/vdacYfcLyyQYkuNeb1kC2OhV5Pro0ZqZMqLO8Jt?=
 =?us-ascii?Q?WXbLtCDEy/Pwjr9ug+VCvmwmaT3+mDg8PH+k+gz4xP0IXxPEz/gXfql5YiuB?=
 =?us-ascii?Q?zXU8hxs2mNIyWZAfOEy4Ckq8BldxZOSr2ANoX8CWC2S6AmOeT5usbo7IF/ZG?=
 =?us-ascii?Q?MUYoeL+jXOcyKJ78QaVKEkTcaWmMBMnrt3EcQ4w0G9bztYB0ACeQim3nopmA?=
 =?us-ascii?Q?5cFIMkJe4TPGmWdBtKLB4eCmVOocV0xgbdXypIjtj+TTIm8rJhk6GKQkZ/zv?=
 =?us-ascii?Q?/BuPFAXCpU8lTSp93sdxfi6dB65SR0Xg0nyC7btj6FMNsGVVJDqxQxmhClNn?=
 =?us-ascii?Q?hwcGXNs/BbBac4/CKd+kg5t7waOAZgq/EVSCR1ie2l0mVi6LCZejY27qWw7O?=
 =?us-ascii?Q?xrdwwXlab8wSm/0/kYfXk99Zz7h+mtllSP0hXh9vid3tJlcehyMRIQ9n0q/o?=
 =?us-ascii?Q?XUvnNu55AeVt/ocSIjvD65ae/xUVibCT1451au6OcH9QiHss9LLtXem2pRcx?=
 =?us-ascii?Q?FPQ3MgGRoG1WVQIsYb0cyJQ+PR7lpOzp6oc14gJsmy69nYMs2DTRELmrPoxI?=
 =?us-ascii?Q?T3dDSAX9yK3Ja+iWqh4XqY0YKwg0nN5YkNp1sp/9u6wnG0qeuVi8b0iZ9GCa?=
 =?us-ascii?Q?FWRHf1cbO76i4/ZTvNquHd4//QxLajQuEtMZezvOamKRxGKvjA8FjDS/KHoo?=
 =?us-ascii?Q?e0ds9MXnA1pb/jjmNd3d/sqe/N/l69LAUdsVWQW+2SrafScQuKvp4w3a0I3x?=
 =?us-ascii?Q?FPnS9daOFqQlhbNo1YnTmzNKs+YDWUINese5FEQD8B4zaNdl3CRre8jTQFkU?=
 =?us-ascii?Q?LPUAITTecyredFrxkFaw+4biYs1wNgAsK52FFQepXgqIWO3wcKG52sD9oNUf?=
 =?us-ascii?Q?ip7a/rEdfFDtSz+Dh4GbAbQqjQkQHGx7OJrRci1oXw4Setvkg7Unemd2uDuc?=
 =?us-ascii?Q?1K8X7h+JageCIHIehX9lbEh9Ix2Ezxg2rU5AmuXtsr4pDGmLItg7SBVmMzui?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae897dd-91c6-4885-375f-08dc39427ef6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 16:21:34.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDFhw6l6IVyc/hoNd9hSzUb1QLEcR5wKAo+3Odr+13jqOpkR5mYvcvJ0jHsTn7aX/glEADis/isDlBkXlU9aUQ9Y4v9S6H94MQt+6RDDuww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

In the case of using BlueZ with Pipewire to start a BAP broadcast source,
Pipewire will do the register endpoint but bluetoothctl is still required
to configure the broadcast streams, but no local broadcast endpoint is defined
in bluetoothctl.
To resolve this problem I added the new_local_ep that will create a local
 endpoint that can be used to configure the Bap broadcast source\sink.
Example how to configure a BAP broadcast source:

endpoint.new_local_ep 00001852-0000-1000-8000-00805f9b34fb 0x06
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1

---
 client/player.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/client/player.c b/client/player.c
index a40bf66e3..e6041b4d0 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3582,6 +3582,26 @@ static void cmd_register_endpoint(int argc, char *argv[])
 	}
 }
 
+static void cmd_new_local_endpoint(int argc, char *argv[])
+{
+	struct endpoint *ep;
+	char *endptr = NULL;
+
+	ep = g_new0(struct endpoint, 1);
+	ep->uuid = g_strdup(argv[1]);
+	ep->codec = strtol(argv[2], &endptr, 0);
+	ep->cid = 0x0000;
+	ep->vid = 0x0000;
+	ep->path = g_strdup_printf("%s/ep%u", BLUEZ_MEDIA_ENDPOINT_PATH,
+					g_list_length(local_endpoints));
+	local_endpoints = g_list_append(local_endpoints, ep);
+
+	ep->broadcast = true;
+	ep->auto_accept = true;
+	ep->preset = find_presets_name(ep->uuid, argv[2]);
+	bt_shell_printf("Endpoint %s registered\n", ep->path);
+}
+
 static void unregister_endpoint_setup(DBusMessageIter *iter, void *user_data)
 {
 	struct endpoint *ep = user_data;
@@ -4287,6 +4307,10 @@ static const struct bt_shell_menu endpoint_menu = {
 						cmd_presets_endpoint,
 						"List available presets",
 						uuid_generator },
+	{ "new_local_ep",  "<UUID> <codec[:company]>",
+						cmd_new_local_endpoint,
+						"Create local endpoint",
+						uuid_generator },
 	{} },
 };
 
-- 
2.39.2

