Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43791B2ECB
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252192; cv=fail; b=uan+cCNVQ9l6H9TFHduouGTtVeVgWLzVGD+GJry9Qu7mkzVP4fV1diHOmXsODmAhNUVYxCg9sQJ79Ya7UTrC0zx5XN9v6bjb8wK6c1DbXm1A1RADdOwi3B9BwfnOqVfoE+zs6LheS5q5hXxgljVi4A4DiRQtunNUCB2LAIK1agM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252192; c=relaxed/simple;
	bh=95UH4s/foLAkT3QKsu3Buzf/TkhgaUTyMyaYD+vUJ8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GycKwDHSMqYuZTc7EVecU06ov2cDigkkLa2PStlg6kKYzwNJjwNdqGLwMgsNf4b+YXiDJzoDHYdy4szwKllb4VjXSiGuP5LztjAv0MEA+wuRJIieIhcT7/+F5yUqA3ue1vLzhrRzu7sUuH5qvZrfRbiR9+ZHwhAWu5RdkLr3H+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wxv89Vd7; arc=fail smtp.client-ip=40.107.249.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wxv89Vd7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+iYoFpu64L3H+VsaLhoDRN18TdVeoHJ3bkygEQBKgsLgIQzj7L7h4iovdtUHKQ7AUHxMpBTWrhAm43u0tBc4a9B9eArmty1bPUBhUPgdexacsz78wH9M1tDdJ+aKWAX0kYpqTlGCDJfenQfGD4l/hnGJk75dVszdvSHbtOchbIevCqdl0NLwV/tmkGOHbo3L0G7sZuRrhCKkMI03WlLnK09QvpgksApGhUSqoApMFqRqtTbMruG2ggVmwbyfd/z2NY5+subGVk/u//ZH+ageb9bwmYKCASJ2vffDYOghPH6z3kbYuVg6iBNbEvDy79niWUP3cGt10lhYLZEwgsdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPA9UyDUbYSnziAvlCyD2eNGoyv3i21ONWLjsV0Q9eM=;
 b=q3nMEY7MEEFpNOeHclBgeXCoh1mVxxU13Q0tIH2r8BBVJEFGba9k1lkx0yyQflB+r8oT7+Z/Xana5O1mmrRUKB1ZTViME2svz5nNRmSY584gpxZ1lrPndlDGDwHTPkD0/RAVdxfdKh7MgaZJ16rm23C6p8hbp2OV9Qa0gXW7/4lJgE1ExPZuZKZR3/We2JG8Cj8ta413ou/C3nJUv7XUN0GuFA2ERK7QBEWVxlJaZ1ogXooUcYgRmj9OFk0EOG7hJ6EdI0GV21VVFu8RGLkR5aaJbTHj1VKGiLtzE8maCT/H1Y/AgpLiLz9N0r+U6Oa4hGvWQTiW3OIeolcklNeWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPA9UyDUbYSnziAvlCyD2eNGoyv3i21ONWLjsV0Q9eM=;
 b=Wxv89Vd74pBOhRactiGF79IlhWAstp9A0i8O0lef/M6O7oniFNyrlvNic0Eik7OY3zPARpzNKub7RQH+9j9w1lx740L+9/xKQpSDpRaKAdRxG9oeK+W0KMZBVGg2zkO50ntTGsrtP95mXTROWoKHttwKxUcgyXRrjo2NHbnUMO8ThkwO6e89h/gpnqyEyJO9tux0no7+/KlLeWGycbyfPJim42VVZU0ie7n4HSRWME17a/RW14NvpAHMQqA+wuUEr0tyY0pgiv2+GR7mt9PpDRBawAeeRCtRDiACILodY8xTbUeSfbmT0wlrPVb6a+JSqehmBn64AsZATq/PZ+Nerw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 14:56:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:28 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 06/14] bass: Register cp handler for Add Source cmd
Date: Wed, 21 Aug 2024 17:55:54 +0300
Message-Id: <20240821145602.92083-7-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0030.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::40) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: a2581dbc-12ea-4124-fc72-08dcc1f16f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AK2R3U+v0PwN+oIiOsmv1lGpmsGI3XXexBBPNjcK4DRQ/HGvT2R/jshIQQBB?=
 =?us-ascii?Q?mphw/lnx6VIrx0QRxCX1904wgLrQtBHxNOWfeI4nakEBbWN/FUx+sES+j/vL?=
 =?us-ascii?Q?g6oXQKP4M8aJhaBjSnuyVK00B9lJQskuBDA2jk8cp0vfnaNcY6bBOvryzwN5?=
 =?us-ascii?Q?NnPO50Qe8ik3VDtOu3K9TcS6bdAMvYz5gZ65VUpTOaz07BNWhbE2ryvTla1H?=
 =?us-ascii?Q?iKRO2TJMNAD9w5J8v/G2rJZrRc7j3a+r20+IPYLm/w0QOG+W9t5vmuFUkGnQ?=
 =?us-ascii?Q?8KQrYYSVBS0IKT/2gOu56ezlkDAMHrLkqpHpE47xI+Q6GHA4HE45WVNZZf2H?=
 =?us-ascii?Q?pj281vGDlww6q8Ej2YP5nffJcucUb9PE8p8QDA/VS9vSs6tvaT4NWlJ1l9e6?=
 =?us-ascii?Q?U4hvA8bpeXV4r4TI1hsvyAr5Gdi0VsqPS/0b8XZM5pgEGKRVMLXt5Vfvtc1x?=
 =?us-ascii?Q?FhUEdyxnCHkDWEbAoWojmNZB8XpuTXgjy082K1n8wR76eTe0bBj+4PAQyK3r?=
 =?us-ascii?Q?c0OeuximRpHDuY4DRqrREg/wmk2BdpWx+YyBbEJBo3+GEgtzt1xLGQ//MhQ4?=
 =?us-ascii?Q?cy0Aqkeng+3KMUAhYDxCL7rTsllnCPTPqT4IMTBtxYQVYT1R9mTLRpCauDhZ?=
 =?us-ascii?Q?njb2+Wt0tBW7laXuMVjq6C1715OGEqc93eApvp/Pj7Va7DBXtzGnSdT/uO/t?=
 =?us-ascii?Q?jELHeRGZ3RKh0gpWV+Gigtmkn6PxV8zGDgNyZNUOrwOr2sYrkrOQLcwnmdJF?=
 =?us-ascii?Q?+Hs//q9BENxIMEulItlGwobpTo/wW/x5o27xG9rNSM3qMGlAecgt9YcaCyka?=
 =?us-ascii?Q?vHzLBQX9mTN5edVwsypEnUQ1bg37Ik7DVbhdx6/bmQnE3/iqfAJYKMD+6P8W?=
 =?us-ascii?Q?7ahn2zDmhj472zrzD4XnUDyPQ3PKy7/rxdwqoeh6/NP0BNEvx4Cl+Dyl+8R0?=
 =?us-ascii?Q?9lqtnkxCW9klD0tcTZB+GrhWgmVM1bvX1mkG1cAN+XvFIMNbfvbvnveBwVQP?=
 =?us-ascii?Q?0nsCHjQvXQcaj9tevbGgjG7bJsahtTIy4vD4MLMWsnO/w+Svkadsseb2+hFd?=
 =?us-ascii?Q?oJ8dDmbli05w31cJF/MVMMU2GAWOskHWRiro7GMIKIEDWFYo8fNDqAYAp6yc?=
 =?us-ascii?Q?RSayY5EHhiowZv8hdnOfmLgXRm8/KWBR88DQTttnA/gK6ASyd5ECFCsYbI59?=
 =?us-ascii?Q?EduSFrxVRl0a/yl01z1/afvG3zyRm9FcD8sy6BB5KZsW5tYtIthRTbvKvyQ6?=
 =?us-ascii?Q?FbCdruhT5SfFw1tFmc9RJ42g1RZZ/gXJSPFTrlTsjlFkb4tqPEoYWjnkqBKd?=
 =?us-ascii?Q?/OqOBywXNVz5ZVdAZgMBNK3lziY30XDspT5emkMSaLB3+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mxLtI3iMSsNUhV9aod30db92aqoqrv0WrbIl8FL44RReqExT8tUlYo3cxAi9?=
 =?us-ascii?Q?T3P6VcYOgnjxszj3c/I0IOAjO2IplEaTp65lt6T87Dfo+rqIJA0AfxlElhk6?=
 =?us-ascii?Q?sxyMhYmegrH6UsR/Uc7GbOJwm0cyLYP2msNmk+oxF0Qp3OvVynKE76dqIwxF?=
 =?us-ascii?Q?c+aA32yvu1yAl3373b7zJfVxqbSf/2pzUOBmMsTXbYFaF4PIGOasG/9Dy82G?=
 =?us-ascii?Q?2SWl2VNofIdsWMSeF+xGf5HMYBgKOrsjEZIRku9EU5iJrwbIBONkjxe9F87Z?=
 =?us-ascii?Q?JBr+iWm+EF3o4o79vdqT+BwMn4iGGmSatTur/QJg7lWoJIXkB34SDWGLPPfm?=
 =?us-ascii?Q?YQuVvR+jWYkmOafnlCl4TCQgj3Jg+pHSr6s5h41NukQp8Yst0E512Tx99oGm?=
 =?us-ascii?Q?WVrLQMafCfRG8oYqkjcbCNyrD/Axd0rmeTYN+myAWaecbo3WWtT6fippDUPx?=
 =?us-ascii?Q?BaKujk8upPyL7uOoNO5GUITLJk6EHY2dUL6w2WtHsD8o3OTy8zP+Y9/2OAyM?=
 =?us-ascii?Q?sq2wEpLz/FtmKNzCwjHL39pziIj27rEFBUFaZfeZcPpEbL85OR3Kp+ssrl2p?=
 =?us-ascii?Q?JisTwj6MB5ybEGvdzcGVm9wmhoqi+3olnMwTrzd0tHok6Q8RAEk75X5q62tU?=
 =?us-ascii?Q?1HJKiG/ObspyKtQiWsuZSwB2CqE9GTqQJUrKoBgzGdy1E/3LplsyBZbwcRBU?=
 =?us-ascii?Q?To4bBttmKLZtliDtblyUnZ17NwM31H5sls6T8/XJ1mLyj9YbP7CifkI6in2V?=
 =?us-ascii?Q?l+zJ4oQ/y3tMv7dSJLwZbKkKLQw/Vl8UmHRJqylvUmeY00YXELRl3aY9L0n2?=
 =?us-ascii?Q?b95oA+SH9n68XhuMXF3Ivtjkg0rJM+F3SEf6d2zd+mYslwSr9Cx+ICxLd1DM?=
 =?us-ascii?Q?LXKojlEpY9LXxNOWVACRy5KCSmmRS7qsEUazM6Q5NXW1BYVuktfSeydYM0zQ?=
 =?us-ascii?Q?7yt6opaV5+VWj6Ax3mdCny0ObcOd2xbFjsye5zGNKGDJgfexjCDAHC0nJfXI?=
 =?us-ascii?Q?bSqrMY+XS8OrN0pEldYyXnfoPGSaTHHsj6KWwCvfzc2Mv0ygTIk47WkYc29R?=
 =?us-ascii?Q?i2it/QSauJlOoegZQtPx103ybCMnOLod06gyO3S3i0diHSnSRVyq4Ru0ZV4o?=
 =?us-ascii?Q?V+yPz72T4SI3PCB9x+XFO9Znrmov6AO0zi2kkWJ4/OHC5rrhsspOMEoo+1f6?=
 =?us-ascii?Q?oXLRXm2oiFwaPY2MNQr3XV0QxNVlGPS36gJQdD2t+6LpvUT8C6t3W2lWVqWp?=
 =?us-ascii?Q?CxcUnQTmfrs7EJNLRLlpG0ntvnWQsEKSOxNCi3QIA/GW8/rRbYbEi6gt1Ol5?=
 =?us-ascii?Q?M4JGsuU0iTXgBWbnhbaQRB0cC6+tExnqJlTVKejKGmiFCf6NXiamiuQ/UJAb?=
 =?us-ascii?Q?botyTZfbrkgLw4QpaXz7AgVd7B26CaYIZRl805iKeF7vjET/4xvxPlrnoDri?=
 =?us-ascii?Q?1hNx5M2pJI8Lz03HCJJb9Goi4sygsIudG3h/LiOlPATVs9CY2Buc+1WiNAX7?=
 =?us-ascii?Q?SAlNQUUMptl29RfKDFPdm4tqfIguvloXmKUlYdvFIWM/cnBvYJkrkjh6vst+?=
 =?us-ascii?Q?Zcu9dwebJnu4vBn2/r1RXyVHpzH2PNFGxXpVFnDnZycSQu+u2S7PzhDy8QBy?=
 =?us-ascii?Q?FQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2581dbc-12ea-4124-fc72-08dcc1f16f8c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:28.3590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19SRran9v7RXGEY9dUZevAi4zcUh/9P4VsTYLUl0Cj3Uu08imiBZpRzCi/SBSYHrWB5nejf0xAvatG2Aaftyaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618

This registers a control point handler with shared/bass, for each
eastablished BASS session. For now, only the Add Source opcode is
handled.

Using the parameters provided from shared/bass, a device
is created for the Broadcaster address. The BCAA service UUID is
then added to this device and the service is probed inside BAP, as
if the Broadcast Sink scanned the Broadcaster device autonomously.
The BAP plugin will then perform short-lived PA sync and it will
create streams for each BIS found inside the BASE.

Below is a bluetoothctl log which shows a Scan Delegator starting
to advertise, connecting to a Broadcast Assistant, receiving the
Add Source command for a Broadcaster streaming one BIS, creating
a device for the Broadcaster and then creating a transport for
the BIS:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# advertise on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[00-60-37-31-7E-3F]# [NEW] Device 03:E2:C0:11:57:DA 03-E2-C0-11-57-DA
[00-60-37-31-7E-3F]# [NEW] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0

The btmon log below shows the GATT write command with the Add Source
opcode, which was received from the Broadcast Assistant. It also
shows the short-lived PA sync performed by BAP:

> ACL Data RX: Handle 0 flags 0x01 dlen 1
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 0201da5711c0e203001a2d5602ffff010100000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 03:E2:C0:11:57:DA
            Source_Adv_SID: 0
            Broadcast_ID: 0x562d1a
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044)
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00
        Adv address type: Random (0x01)
        Adv address: 03:E2:C0:11:57:DA (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000
> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 0
        Advertising SID: 0x00
        Advertiser address type: Random (0x01)
        Advertiser address: 03:E2:C0:11:57:DA (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 10.00 msec (0x0008)
        Advertiser clock accuracy: 0x07
> HCI Event: LE Meta Event (0x3e) plen 42
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: 127 dbm (0x7f)
        RSSI: -64 dBm (0xc0)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x22
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
            Codec Specific Configuration: Sampling Frequency: 16 Khz
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000001
            Codec Specific Configuration: Location: Front Left
              BIS #0:
              Index: 1
> HCI Event: LE Meta Event (0x3e) plen 20
      LE Broadcast Isochronous Group Info Advertising Report (0x22)
        Sync Handle: 0x0000
        Number BIS: 1
        NSE: 3
        ISO Interval: 10.00 msec (0x0008)
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        SDU Interval: 10000 us (0x002710)
        Maximum SDU: 40
        PHY: LE 2M (0x02)
        Framing: Unframed (0x00)
        Encryption: 0x00
---
 profiles/audio/bass.c | 81 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index b3740f64e..5aadb0dc8 100644
--- a/profiles/audio/bass.c
+++ b/profiles/audio/bass.c
@@ -54,6 +54,7 @@
 #include "bap.h"
 
 #define BASS_UUID_STR "0000184f-0000-1000-8000-00805f9b34fb"
+#define BCAAS_UUID_STR "00001852-0000-1000-8000-00805f9b34fb"
 
 #define MEDIA_ASSISTANT_INTERFACE "org.bluez.MediaAssistant1"
 
@@ -82,6 +83,7 @@ struct bass_data {
 	struct btd_service *service;
 	struct bt_bass *bass;
 	unsigned int src_id;
+	unsigned int cp_id;
 };
 
 struct bass_assistant {
@@ -97,8 +99,14 @@ struct bass_assistant {
 	char *path;
 };
 
+struct bass_delegator {
+	struct btd_device *device;	/* Broadcast source device */
+	struct bt_bcast_src *src;
+};
+
 static struct queue *sessions;
 static struct queue *assistants;
+static struct queue *delegators;
 
 static const char *state2str(enum assistant_state state);
 
@@ -582,6 +590,7 @@ static void bass_data_free(struct bass_data *data)
 	}
 
 	bt_bass_src_unregister(data->bass, data->src_id);
+	bt_bass_cp_handler_unregister(data->bass, data->cp_id);
 
 	bt_bass_unref(data->bass);
 
@@ -627,6 +636,72 @@ static void bass_detached(struct bt_bass *bass, void *user_data)
 	bass_data_remove(data);
 }
 
+static int handle_add_src_req(struct bt_bcast_src *bcast_src,
+			struct bt_bass_add_src_params *params,
+			struct bass_data *data)
+{
+	struct btd_adapter *adapter = device_get_adapter(data->device);
+	struct btd_device *device;
+	struct bass_delegator *dg;
+
+	/* Create device for Broadcast Source using the parameters
+	 * provided by Broadcast Assistant.
+	 */
+	device = btd_adapter_get_device(adapter, &params->addr,
+						params->addr_type);
+	if (!device) {
+		DBG("Unable to get device");
+		return -EINVAL;
+	}
+
+	DBG("device %p", device);
+
+	/* Probe Broadcast Source, if it has not already been
+	 * autonomously probed inside BAP.
+	 */
+	if (!btd_device_get_service(device, BCAAS_UUID_STR))
+		goto probe;
+
+	return 0;
+
+probe:
+	dg = new0(struct bass_delegator, 1);
+	if (!dg)
+		return -ENOMEM;
+
+	dg->device = device;
+	dg->src = bcast_src;
+
+	if (!delegators)
+		delegators = queue_new();
+
+	queue_push_tail(delegators, dg);
+
+	DBG("delegator %p", dg);
+
+	/* Add Broadcast Audio Announcement Service UUID
+	 * to device and probe service inside BAP.
+	 */
+	btd_device_add_uuid(device, BCAAS_UUID_STR);
+
+	return 0;
+}
+
+static int cp_handler(struct bt_bcast_src *bcast_src, uint8_t op, void *params,
+		void *user_data)
+{
+	struct bass_data *data = user_data;
+	int err = 0;
+
+	switch (op) {
+	case BT_BASS_ADD_SRC:
+		err = handle_add_src_req(bcast_src, params, data);
+		break;
+	}
+
+	return err;
+}
+
 static void bass_attached(struct bt_bass *bass, void *user_data)
 {
 	struct bass_data *data;
@@ -652,6 +727,9 @@ static void bass_attached(struct bt_bass *bass, void *user_data)
 	data = bass_data_new(device);
 	data->bass = bass;
 
+	data->cp_id = bt_bass_cp_handler_register(data->bass,
+			cp_handler, NULL, data);
+
 	bass_data_add(data);
 }
 
@@ -780,6 +858,9 @@ static int bass_probe(struct btd_service *service)
 	data->src_id = bt_bass_src_register(data->bass, bass_src_changed,
 						data, NULL);
 
+	data->cp_id = bt_bass_cp_handler_register(data->bass,
+			cp_handler, NULL, data);
+
 	return 0;
 }
 
-- 
2.39.2

