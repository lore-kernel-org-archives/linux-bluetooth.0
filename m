Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2114.outbound.protection.outlook.com [40.107.8.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DDE84FCD
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073006; cv=fail; b=bzIYQNpDtgN92+N9Psj2DsHgDdP+/h9QBhMyCFu9PP6+SJLzwCS9vIwwhcqZc4ojQGtWjsSb0IUuNPMZBdPo7w2gLYX2QsrEKFblyLw1JI8txDjT+oEClfjb4WMBIqiH/l1oAsRroRMXJVdHB43nMXtViieCcTWoIj7b3MIImas=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073006; c=relaxed/simple;
	bh=odrF8EazAH/uOtZqjPjd50A3pKDRD3g/3gLlbhTpLAs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iwMtiOnJdv89nawZr11tos+GpktDsayKik33aTEHRP7/8KudfoZM/jbnTogOJFDPYAvQUI62fWJfrF9U/EkGeznorDNCGCElwI2QsypKNyWmTQoZIslbgCV57G00gaZBT0FtorW8yc8ymqnMasu+IIHGGzo34ENmBosYEGQ/uc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NVv1BLkx; arc=fail smtp.client-ip=40.107.8.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NVv1BLkx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKvyxsOeCMTyjf2dfXrOUoahZ63YL7AGgLs/qHVEDk+U8OWpA88hzj0k5f6tNVkTT+jM2fFGln2bJG6pSfEFyh6PWmzhfL7yRhmEuLrzC6yugkYrOe/rxDieBm9gjFk7XsacghBlEDNvkKKGYKXOqMg7aR2yapLViO+m2XHIc00A3U+5jE9qu/MHcL57REwsIHqOllj0R8GChCXd65KQThRNqFcqSrOaw4SzzRndTAeaOCxFiPxwLZNrji0YJeY6MboTxOHwaarP6p5v2dp5PoTAuhOBrhTgC1adjZDXBnoi1yyz70rIrDqzI2WQ7PLkD1c2yUfp5/m6csgdqciVhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbFFGH7fwvDWAJuV2z/ITF3bCyR6IfpUFL8cj9BPTyg=;
 b=U619MCNVR0vRBbiYT6mh1FGg7MvvC9GXO3aAH2phQC92QLPNK+NSPab9HX57CB4U1fxuscSdDXxaJ0E5cE4eGROQMoiSyoxpyfEV2Bz7CHYHN+XAiE+ZDnomKBcXdXlxzZzl+sNUWeQHUZEXcg2I6c5JknglGaTBhY9Y970PkwTmAIxNiE0aSPOtmAzsPw84ikIcektmJPGHOD31FYkJZSsHheIxo67lOzvFDSTpLsxOH/2zKH2WUGbxvYnHd93i8KptLoOceyvE081nQat5K+CU+zQhmANiACQzSl33bodvMY5uY+FMbw1tZDmCTwmMij0vYXf9W2FZcvrMCWKbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbFFGH7fwvDWAJuV2z/ITF3bCyR6IfpUFL8cj9BPTyg=;
 b=NVv1BLkx8XGNqdVgPX3pe0JQ3cxxhz3DU24tUHxOxM84kUgNNPX72+59hQeqIZTMMCJcMhDG7XyUczBjipnYtw9hgbht3Ad+A17vzP75Hc7q3h903as2nrqnKZo8cW6dRQT0EKeX+Nxb9BN0D/lMfwkuflSQQdxQozKhvYtF70k=
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by GV1PR04MB9198.eurprd04.prod.outlook.com (2603:10a6:150:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:49:59 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:49:58 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/1] bap: Fix endpoint unregister for BAP broadcast source
Date: Tue,  2 Apr 2024 18:49:54 +0300
Message-Id: <20240402154955.45229-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0179.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::16) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|GV1PR04MB9198:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hA1MiONziWDKCsWGaggNoJqMoy+vUzG/nsTUMFgZoOUEIBhn9rFDKcYFNVGs5wyUOYSCm8X4o2pH5jJu7qPe6cFpf32tWwSc0IhZNvesGU2PnlgFB5jgSTUAh9/h0YRldVqQHcG/7M4kQVcCyw3ttqNxGt7Y/ER060xYyt9WND11U+92LTG3T70nl2yCUQD7mpxv0B5bIaTEZ83EOWOaM8QYELIFQ+HqUWiEhXtFAUXC7ogFNqWYZW5EALZsTLh8umZwj9uZiVsaH6Xd4MWAOapzTFIaEihcEfdmdo61wlxQQHTDd6P02/uiQ+jrWNadWXseX1l2C6ldraZKnoZT6hUhNFwECGPoxcNSXemOCJNaultGgdeuRUX2kT6CNQz6bg1g+hyconbepewaYdmAxX79i6B0FlEmZva6wzg0Xqr2gM0TunVRw/P6L4hrr19DnE+cJ5eFQoS3RXVSyjDPmzELCBXIe7iHeBQq7v05B2g7s/756FT2ISbIVpSXeYSq/PsagPsWbjjIt+RFQMQnqy6q7S+pWjE2pIVVWQ1iPFePUtWJMhQC4qA3dErkFf5nVgxfF+CLHiUW9Rf9ptS4d2KnpaIYWkHFxkM6yG3qsgQ++KxslaO5a6OcS3qQy4Nf/peH8e/tqm90jijC2KmfSxA4k4yjYPBu2cjfQJtZgrg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r5FzhhDiOSPgim1UoM2nidtuxbgAdCJmyQYyBv4VePZdcTD+LzaLOGiB7U5g?=
 =?us-ascii?Q?HuqIO5DRRaObb3/3/adzJH2hxeL8/ujyF8eWOMwLXtXyVem2LyKeL1gHFP5q?=
 =?us-ascii?Q?BbB9OyT39MefoTmoILQ1L4nJ+nVN4q7OYxWVC6pCexoGh9SBCkuW+Svv3Ne5?=
 =?us-ascii?Q?9laeWLIa4OobVPfe4tElWro3u3inRlgt09FKClkU0nStDi86Wuo5oUNeS5Y2?=
 =?us-ascii?Q?dL5dQ+E1M+IXuBEPa8f4jc/bf5gn4L5hDGH2YtKmtfQbt9i3TXcGcW7OqoY+?=
 =?us-ascii?Q?u3qOZ211aHeVTpd7ToUyBbmjKeeicqxYs7nSagz3cjEq4OwAygqDlB7M2FhX?=
 =?us-ascii?Q?jtU4HtgWJ8CGSRisEP9pkFjnAEm0QidKANEtpqBuWEKj1lfzlu/Nr4tiYB7/?=
 =?us-ascii?Q?erNRB8qm9OMQEtk/hNavII0c+JBracJxQBB78CCUbkOXvOJNDy2b04k1khL5?=
 =?us-ascii?Q?86XlvYoL9SaLh01eXe7if05213GVQLVzJG15Y0g9OHW7YYKSbgYtbl5q90Ig?=
 =?us-ascii?Q?YqUiTUxJJUcOiZ7S5HtYka9PSUL/ZW6dFRCMESbfwo9mQu9YPg4Y8SJGZ3rN?=
 =?us-ascii?Q?wYBq1YbjKY8aWUm/FhiZdctrgk6VCgysnv8UdR3ltz7YRtHKZTZKmtc+S+5h?=
 =?us-ascii?Q?RZOvAN85Cr69VVdfmPrmytJukvN1YjORnMeP3mOSf01hx8/F5R9exL1rQVWJ?=
 =?us-ascii?Q?eL4hl9JsmQ0iMy2mW48iSWPNIOjsedrV5dVAjpHXuucp1bodX+J8Os4X9HBN?=
 =?us-ascii?Q?56zO1u9Zc4X6VUAnwsAlUbSlRyE6ZW1A3zEgrA3Q7MzBOmd/qs+RF72gI6oL?=
 =?us-ascii?Q?JQzv3kfM+aCcq6qbdgKz9B5GPYfJNet6QIqjaNOVt40yxfG7h/BXF0QPFaRI?=
 =?us-ascii?Q?iPQzpS/L92xWkBl1MUQzq292XHeW8ZHSpz5b9AGUBENUBUhcDcSQq9DmliXX?=
 =?us-ascii?Q?9l0VHVMCT6oxbQQQca7yf7U6X5h+m+nxCz20wo4/Th0/Z+i9U5yts73L7yGW?=
 =?us-ascii?Q?apbunRQyZgwATRh1r0HcrMOit/MBtyzPJOswp+I/KWj/nSWlasAWiNYlI6S+?=
 =?us-ascii?Q?ayoc5jtV61UnjSDzYQQrKAlq6tJyp6czcLfJV4G6JIP1u4uVHjSbG2jFxVL6?=
 =?us-ascii?Q?9j6b6ho9NBu1FrUrY1Q3YZQTGcJ+MsCOUUHEnAkSV2CxEJ/LcDM7/sq2V3YF?=
 =?us-ascii?Q?fBcfda4k3kez0GykxjZye7VUSOvez6hoEmPhTw21vSGQQMVapB8bYiNtU6jN?=
 =?us-ascii?Q?v1VEtsQgTJXOaBAGFrjy4jy2rctD9juO2qGet4bK32rp/6JJAIPGPOXejiiR?=
 =?us-ascii?Q?35BqfbZ9tPoeovllZliVGA9GbNDsGPzn0rUGYv8OhOH8G+z1+he/rGPM1Lla?=
 =?us-ascii?Q?cY10onATQRa3srI27waD2V0eHoDmFGLFCp0Fx+UhTJIu22th59LJtp5Fyc+E?=
 =?us-ascii?Q?fZqbqW0BvBPWyah3vq+avFPUjL/DJOoyMLiOhdEEksACgTH9G34YhE14pTKW?=
 =?us-ascii?Q?S9iZOaGeoikHOidz5MYH8oruYXH8ITa3SOLpjHwjZyfDK4lxSKiEtl+zG0cP?=
 =?us-ascii?Q?vUfV7kUtRkhvJXahGCh4+vztZFas8eoqpEHbIR5/1fKmLkfXHz19bYmzJSJg?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3062ae27-df10-4f49-a5f4-08dc532c8cb8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 15:49:58.5260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3racr02/CnOJptC4J3khgorReW9bYmRS06msuUwX2s/0Dd7jMsfbjWqovwyOXtN00Je1GEOFAaiwnICg29fU1JUFI6+9Zmq8EzR9/x4SGrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9198

Fix endpoint unregister command for BAP broadcast source
before fix endpoint is not deleted:
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x065f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 3
[/local/endpoint/ep0] Supported Context (value): 0
Capabilities:
03 01 ff 00 02 02 03 02 03 03 05 04 1a 00 f0 00 ................
Metadata:
[bluetooth]# [NEW] Endpoint /org/bluez/hci0/pac_bcast0
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
/local/endpoint/ep0 48_4endpoint.config /org/bluez/hci0/pac_bcast0
/local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 1
[/local/endpoint/ep0] Enter Metadata (value/no): n
.................
[bluetooth]# [NEW] Transport /org/bluez/hci0/pac_bcast0/fd0
[bluetooth]# Endpoint: SetConfiguration
[bluetooth]# Transport /org/bluez/hci0/pac_bcast0/fd0
[bluetooth]# Properties.Device: /org/bluez/hci0
[bluetooth]# Auto Accepting...
[bluetooth]# Endpoint /local/endpoint/ep0 configured
endpoint.unregister 00001852-0000-1000-8000-00805f9b34fb-00805f9b34fb
[bluetooth]# [DEL] Transport /org/bluez/hci0/pac_bcast0/fd0
[bluetooth]# Endpoint /local/endpoint/ep0 unregistered


after fix endpoint is deleted:
[bluetooth]# [CHG] Controller 00:AA:01:00:00:00 Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x065f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 3
[/local/endpoint/ep0] Supported Context (value): 0
Capabilities:
03 01 ff 00 02 02 03 02 03 03 05 04 1a 00 f0 00 ................
Metadata:
[bluetooth]# [NEW] Endpoint /org/bluez/hci0/pac_bcast0
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
/local/endpoint/ep0 48_4endpoint.config /org/bluez/hci0/pac_bcast0
/local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 1
[/local/endpoint/ep0] Enter Metadata (value/no): n
............
[bluetooth]# [NEW] Transport /org/bluez/hci0/pac_bcast0/fd0
[bluetooth]# Endpoint: SetConfiguration
[bluetooth]# Transport /org/bluez/hci0/pac_bcast0/fd0
[bluetooth]# Properties.Device: /org/bluez/hci0
[bluetooth]# Auto Accepting...
[bluetooth]# Endpoint /local/endpoint/ep0 configured
endpoint.unregister 00001852-0000-1000-8000-00805f9b34fb-00805f9b34fb
[bluetooth]# [DEL] Transport /org/bluez/hci0/pac_bcast0/fd0
[bluetooth]# [DEL] Endpoint /org/bluez/hci0/pac_bcast0
[bluetooth]# Endpoint /local/endpoint/ep0 unregistered

Silviu Florian Barbulescu (1):
  bap: Fix endpoint unregister for BAP broadcast source

 profiles/audio/bap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)


base-commit: 3403f65e266a0c40ace9cecc868fa96ad3335920
-- 
2.40.1

