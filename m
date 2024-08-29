Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3D1B0138
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935800; cv=fail; b=WkHwqS+TvyXDnQK0tjuAn0q+I7wQ0t75gCSupJjgHGggQlFFMqPRp4Hae0Qg9A8IRASGsVoS8loviOEUmcijhyOdaRmowPt9vb2xgBYuUsITPhVaNdCeZc5K5TW4h2Jw9aLvMoR3ayLcA2NufYAWoN/e9Ey0AE9yXLtTd1OJ6f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935800; c=relaxed/simple;
	bh=gQ/sKGbq9Pq5HpYUoBWAVRiYG17NtQ4dKtd2VgJehNg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BaPIU/xbPIjsiZc+wELDQheTjmVEYcuLcRxGMYnt/lBE/a+93k42v6NHiWWcQl5K9tsPUArAe8vF9A+4uPae4dYJ7FFloSxbCyWYepaIoNPUKp9c8TIfeJp6LJtCK45WTBgFdNqQWvJqQ1M5Oa452+ThS9G5hl4tcf9t7TCZDnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mKQDKxbj; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mKQDKxbj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IPIDAy88eJB+uzsa5eWptJz1c+G8QTQzmHCiEtM0Qg4wLteC0bhzECKbZ1hm5BsaQLcUdN2hjzlfpYO/ovQxAjFWbeBoD59BeDZNAViBOC3S0joL5aNhFJ8ZXYwUUnYjZxhnZp3BHzvsZsOQEgbP4r9rP5tZp4LTfH9+Qu8NcMgkukS360JpMqlxDj1iPTDvGU9fmG2tibZ6weuuPaZPjVVxiNQV1xhOE+voNgrnAXPZ7+Bs9wHc6WjSVa9/peUyMeADpya3tvjwsH7wjqhPAOFUpqEFISoJHMs+ZWrVreYJN/SpvPN/tlXDopLAc4Hd6+05GHG9ux5J0gHD0eabkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZiAeQ+6qr9qHJ1ESsmm+AhEG1n4Cr3WY2eZEljg3aYc=;
 b=zAIdVDHe+79VhwgNi47Vc4DfEKVO10KUWqWR1dz0K2uwXlS401xCXa9534HFQShERwkAVKZmDehGnHTzLX9AW50UbbEOHAO84speMa2o/gH40kpRRhRFhp0WEQCHoGq6nrEu8FpEtHIx2dIzjZMuJlV+dG0vlp0wRCec4aXG7DcnWE6KPTP2pljHZu01Gn8MGgsJx2/jj407ldoQ11xseyE1gCsjusmTG0TtICVVXGiBAEemElb0vfyDUO+ueKekjZX6zRZuQavNZ66B6zljs0w7bajh7it8sv9dxn5/XWgXFfpXBnS3bU4ftJQMSOeMbZibpD81KjGUh5VuWFMLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZiAeQ+6qr9qHJ1ESsmm+AhEG1n4Cr3WY2eZEljg3aYc=;
 b=mKQDKxbjQ+fXA1Ip/9H8kXzVn3NUsWx97dlCm3VKRaKQDXw58tsWAoLfcj1pkyjoKedP/611MpEIhCRM2J9AMuvpKvP+drfIV22RCekGjsSD6A92uzxG60js0G3dgYkPzoU9oT25c4xiUTft4j/oDV2iKnzXkuwp9TdTQ1LKj+xN7s2GQHRKqi6uVP73yPJunVVY1T9UB1bIn1GKmyGwu88u89IblRBEBEAflg52JGH5N1GAC0mMYWn6ikvWygMrCVo/KINR5Iu5/4vQHTkvbfG72a8lx9D7AIRBe2c2ksQka0fOdoZxO9cvEF0HCZ6eq5FldrOI0+lJrujv2BUcUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 12:49:56 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:56 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 11/16] bap: Probe Broadcasters with BASS
Date: Thu, 29 Aug 2024 15:49:13 +0300
Message-Id: <20240829124918.84809-12-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ffb2d7-9b4e-4b84-11bc-08dcc8291591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p3JR5Ga20E8dsuF3MZvUP/wyA/B2aoq4vzG8uSOKPG2fip5za2iQYHkVq3Om?=
 =?us-ascii?Q?C0AyhLM/lIQPkxP/HD3yCQVcbJKKU4S6f3p9oluCqxSO+aX3nEha7JhBHAMZ?=
 =?us-ascii?Q?7uh5nTbvu6Apj0DuUOIZ7mGMk7PqFAjTdoVodFs9wuLKMg7BNgf63G/+mUyG?=
 =?us-ascii?Q?GK+31enOXwucUIG9RzNwy4oBxph6hEGFV5v66d14IrXgKVxI/xRTocVpwVK7?=
 =?us-ascii?Q?zU+OKUD5zmIhKIFcE1Yk4QWeoR7Qzt+oS/PNir7yFhJjZdkt0hNXlomiu9C9?=
 =?us-ascii?Q?ch3nSRNr/vITlqHZvjvtd7Z0wZCekT0xC9vVD425/P/ilWEASF9JEKgBZuHQ?=
 =?us-ascii?Q?zPnvKavcg6V+TqoPZ9Jem1iGsXONTourld6kMps8nC8N3/+pDVVqkkU7vrJ5?=
 =?us-ascii?Q?tg+CbtxxqxPuU/9L+z0uLjPHFAYxZRJcIPgeUA2zgfaX+IGnu6s9q1wKxZKS?=
 =?us-ascii?Q?Lrd2PDrz7KGzRjDZb12xRPmEkE3ChlmOWRs2Q7dTk03pd7InlRWXoocJI2uO?=
 =?us-ascii?Q?llSMIOfI/qgpIuOkw34a7vSYsmQ8VbWX9itwve/KZE48yHGLA53mN+k0lQsJ?=
 =?us-ascii?Q?S4+SFkBgTkQCKukyie9qz+hytiMkYpe0FvcCSwbgOGs670f+vUNF1xcBReNQ?=
 =?us-ascii?Q?B7vI9JEQyvps/tBVqIQ8ysZEtUHj25B4LSXkOhWO034Ivp8JiFy9Qs3tk7QL?=
 =?us-ascii?Q?f6u9kvIo09ZK7Da92VtynddNmopArrgjIg6rWcFeCvcDH5giIzuvXliBsmVZ?=
 =?us-ascii?Q?1UkKLQLnK+VBWOiG2v18pluft1oPlg8C3LAzJ2UqCLyzU3Ug8IKxv9XV97Sk?=
 =?us-ascii?Q?8PsllYwt/a3P/EDbdZMxDqPntZjQdIl8miRzeUzBF1ebhRsOsXfqHbe8+5iu?=
 =?us-ascii?Q?2GZkhy18GA41VGG+r4X06deaxeto7xDP/n2b3WxTTgn++vdZ7Dsqz6iGwqNq?=
 =?us-ascii?Q?Pa9NY+6J18MfuJAAYa5kG53CxS1JTOep9jq3tg3WspTvzET0gllp3KMS5dhE?=
 =?us-ascii?Q?t6Ai9QJMIv87JvlQf2oRU5ZodV3K59aamWUgYyDjL6r/asucanZ5hY3JxbVv?=
 =?us-ascii?Q?DGrtFXxsPzyvPIsv2pjNqSLTIhmdV7zfAi+TJIhiKbJlfIRBUxhcen1Ljwt+?=
 =?us-ascii?Q?e6O6sgmna8SnbB3OnLtxOKg8wjTCOgyEXtzIaP5fjI6uDy9BS2Y+9ZUSenh+?=
 =?us-ascii?Q?jlhG/+l+O0mUyg8S2F6cJfnIbrfEqmb3eIbxo1Hb8fYOU36GrS3C7IT9o1tn?=
 =?us-ascii?Q?V+hw09Hq/i4pQoNmwgMV3MCo1GwiVkMuYhP426+S1iKcb9YqPIUro6/ltTbA?=
 =?us-ascii?Q?QXGevX5U9eATLKZwXEs9jXeml0b7n5GfZ1ImQdZmOBCrTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CxobE9E8MGtYw9nQgEoBfnlhf1NIQ6vvJg6aIW8NIGIc0Gh3dWtTmNKvBH2l?=
 =?us-ascii?Q?lNyR14a3/uPBapGxQvW7cmM4AKADYXqaWZQ6vfW5cqAMtTN2Tkksnc4h02AJ?=
 =?us-ascii?Q?7qOkzl3ALVNKDZk3polscfLBkU+iX8YwjK5H3tvy3qNex8vdoT4RQTNYQNjZ?=
 =?us-ascii?Q?dENMaGfGBlEWyGJRSfj+VC8tnilU3PvMDweY4C2jxX6tW4yknUIUvmbNyOXX?=
 =?us-ascii?Q?WtnhCYgbxGWhWZsNDSBgnRmA+C5gSebL8VjyJukyx6iikzkUr9yAn6vLePrh?=
 =?us-ascii?Q?1vdrHXmgV8nwZVajcXeNWdtMD2l4to1UkZNtzJgbNYMFksO+c+4mpj+gJsB8?=
 =?us-ascii?Q?DHM95yF5ZjwrOhiWuJR7sC6OfZbJ1+ke68HBIRayzRU5wmLbleopDYfcmKx1?=
 =?us-ascii?Q?gTWATn2q9d/sdZfV1xfMUKcRfxJlpjf4QiEHcrW/a2uGWXkPfBA7PYgmXbdt?=
 =?us-ascii?Q?bVXoZXBRPFcyyvry6YYD3xuZ+QzS9BKlv3G6Xo+M+FkjkrqzZCYnkoy6rPYj?=
 =?us-ascii?Q?jOP70EPP1cywDP01OqCCQw237BPxwAQpu4Aq6Ed1ppvl23j56GGU1z6Ro+wi?=
 =?us-ascii?Q?VJ30PEv6nEF6DdaFKJWRfpPnho7dc3Ax60ALGhM+T/FTivViH2Yb2nU4CZud?=
 =?us-ascii?Q?Z+VBlOolbw3Rk7lgcmIOP0mePt20rsKplmXjn3X7HSghouMbXJYduqMfbmEY?=
 =?us-ascii?Q?yfe5FPymQMK54xmkYu5oKvW1Pf1A+FNsZvwZ0egbUwcHx85Mrjh98m4Od1fX?=
 =?us-ascii?Q?pCgVl30KB9txdxGfUyxqPI4kWae85QUS9mDiP+w9HGDIn9K1XsDMRrbLZzoJ?=
 =?us-ascii?Q?VU+w14CCa/cyIBBYnUdxcNL3+WY89QA0WCU7UdC5CWlvMTRHs0ADOiKt+jWm?=
 =?us-ascii?Q?ZWbVgWbdlPvSZpt2GTMsE96njtpBx3qBweHpzguJfIj41qRE2hA4bldSHhmX?=
 =?us-ascii?Q?CZq/cFUsDclkUW9nj2wPI11MDHiZBcDj0AdvrOJ7yKi1fafHn5S6Ap6tPszD?=
 =?us-ascii?Q?uriTrbawvw0sippvUsldiQLDgOaH4iKlkxqYbu6QUmRQBxFRqBETaBuQWm8I?=
 =?us-ascii?Q?vQDkJJAS2+qyQwo4h5uG6luNZiQJ/owEllWHJGZZIi1S+LWsnHJnzBAGOVQK?=
 =?us-ascii?Q?Sc1NWfUGRSmaQpSLnYFv39AZVHkfRinR6f2Z9Y0v/EuYHR0Yt7J2qLkUiLof?=
 =?us-ascii?Q?ywzhySZPJLCNQQELmIQLg70XFFKnZMO1JedeqT5UZJDSY2+ShcmxSJJbhoQK?=
 =?us-ascii?Q?7t71qU+aM3IG7wsz+OuPQyFcJrTSF4NaK5my++prAFepKq7Jq+ynh7XRmrbo?=
 =?us-ascii?Q?wG0F53kdahF2E0Njg8Z9Lo6py9zGIWMWdaZoi6gWN/dWqvKYGKebtebl56sU?=
 =?us-ascii?Q?adqVSDDmOpAR8wqUSlvP1dxXNzAIGfpC0YWNzGUfyn55FTmd9Z+toE22ERQt?=
 =?us-ascii?Q?5de48MZ8Y0bY7918CGUHLWFlL1OQIjsaniiSSJwmqjk3zWGnZn9q4pWDlnjV?=
 =?us-ascii?Q?DW/qywZZCuizMXs0d9B7VKTWQaOQwjj/TpX99rBOd7USlskOcOpDKnkdJZoP?=
 =?us-ascii?Q?epVLsuQSgYUpL3C9GGcYXVLKvzKxmXdQjTZu92nK71SefK/cnXNhCMudfjzW?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ffb2d7-9b4e-4b84-11bc-08dcc8291591
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:56.1816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +N6n04xlnT5+V9oR5JFLi9HZYuIgiZXuGBEbMlclc98Lm3/bsRG0yRo3yz89ub9C9vjaPmLVplDJHe0ZmwQ27Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939

After long-lived PA sync, this adds a call to probe the bap session
with the Broadcaster with BASS.

This also adds a call to notify BASS about a session with a Broadcaster
being removed, in bap_bcast_remove.

The bluetoothctl log below shows a Scan Delegator creating a media
transport for a BIS added by a Broadcast Assistant through the
Add Source command, and then disconnecting from the Broadcaster:

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
[00-60-37-31-7E-3F]# disconnect 03:E2:C0:11:57:DA
Attempting to disconnect from 03:E2:C0:11:57:DA
[00-60-37-31-7E-3F]# [DEL] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# [DEL] Device 03:E2:C0:11:57:DA 03-E2-C0-11-57-DA

The btmon log below shows that after PA sync is established inside
the BAP plugin, the Scan Delegator sends a GATT notification to
inform the Broadcast Assistant that PA sync has been established.
Once the Broadcaster device is deleted, PA sync is terminated and
the Scan Delegator once again notifies the peer about the update:

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
bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101da5711c0e203001a2d560200010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 03:E2:C0:11:57:DA
          Source_Adv_SID: 0
          Broadcast_ID: 0x562d1a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
bluetoothd[70621]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101dd7c8046f72a00f863f00000010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 2A:F7:46:80:7C:DD
          Source_Adv_SID: 0
          Broadcast_ID: 0xf063f8
          PA_Sync_State: Not synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
< HCI Command: LE Periodic Advertising Terminate Sync (0x08|0x0046) plen 2
        Sync handle: 0x0000
> HCI Event: Command Complete (0x0e) plen 4
      LE Periodic Advertising Terminate Sync (0x08|0x0046) ncmd 1
        Status: Success (0x00
---
 profiles/audio/bap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 3b2a742c4..0daaae9fb 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1276,6 +1276,9 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 		g_io_channel_shutdown(io, TRUE, NULL);
 	}
 
+	/* Notify the BASS plugin about the session. */
+	bass_bcast_probe(data->device, data->bap);
+
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
@@ -3297,6 +3300,9 @@ static void bap_bcast_remove(struct btd_service *service)
 	}
 	free(req);
 
+	/* Notify the BASS plugin about the removed session. */
+	bass_bcast_remove(device);
+
 	bap_data_remove(data);
 
 	bass_remove_stream(device);
-- 
2.39.2

