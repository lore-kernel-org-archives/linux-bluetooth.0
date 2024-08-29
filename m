Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC901B011D
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935792; cv=fail; b=O6Wx0H8kdxCLB5ovM9PC7tnMxwi3TPyYt9loECm3k50K/e6/hu3mERtcmIyzgvbbY7YXKbwtfYUSfs87wgaH9++WD92zhODPxUv8SvKzANY8J2KctcypUH0CmZaxKeqqulUXtB7GGfsPSTor25W+4hucE0LkFjdSZwVEGSoqXrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935792; c=relaxed/simple;
	bh=6g1Dx13eJLM1s2WPBaekNW6JBB2aR7+mKHVxZPj0ar8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fh8Z+cu8Lfmz81iBGE/JQUXsUh6TJUwxMkV4V1iibP1oRVeVFE8PuHW/9OuaBYVZT6fmfdPCb/BfCMrKW7xei4bz40wTGVvjVtLHnTc6fxCAh34HT/dBIBAO5JanD9EJDIxCe+4z9Z6qhe+sNhcUes/yz+sRe8De+8me7kp7/sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wpib8/7s; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wpib8/7s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UaGFwrVZ1h3uNNAnLUGPJFUTsXlMlVPS/pu1hXVNMeVARnu1avV0bj2Pul35ZB+ljkM7yg6ibIc0Ks77Bp5ykrC4Y6R6EmR1NDwq+XvmckvI33ar/QhHJl533ifhEgC/MkZLPNQHZJSIXBAjCZ+OlbepEWAyc1yxeStk4H3oXI/nIekIKAgsH7RFv+YK1Vk06uSwH7o4CMo0BFi+vuOA9+x+8tyGHUK9yd6PgsCe20Fg38Dd/yR3IYT+vqsNBhxFtocBYWkEPUuUomKvvBBVfbLR1gVGUOkEqKElSENrZ4fXIv2jGjC7NyCgK/BY7a0ES3FM/9bIJVkMa6q56mvq3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AC+5rePicT7S1P6urc4AjchrgpGKZsRii3Faz3R1V5E=;
 b=Lipygow2gmXl8/H24UockavmbGUrdMx/KqsQZkZFANRqAFuX6/TS0Y1assBTDKkEdN/1xmNEV3f8a1X7qPyJ5QKsY8+HuIOBgbRRTfxTj45ChiF7gXNNFSv7PCTv3SOjgFjzbHA+coQTs6OQPG4yg/QxirlUnxVGlQGY3yCoV6HNbSQkGGnaOjchK8/1NDIlxAW/iyc2ke1SxfuevwVqsYa+zvsxApIgaL3dODiDJwFHXgSXSY9nYBC5I3MzXYKdD3g+OmJ2UwjIq3SjWKg5YD4T/2iYVEqV9AlpGcyLA7QcUBS/171hiKmQ9r+o9u2wvqE0cVnYxPrscqoZ4Wpj2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AC+5rePicT7S1P6urc4AjchrgpGKZsRii3Faz3R1V5E=;
 b=Wpib8/7sj3FSPFm/s666S/MPKFA1MAAhkK9AHIkWrWHvMnIdtwI6lz9o0T6wGWGB2dZFCxQevIb8x+TubLBYcoZ0AAjrbJ0keagsGeLg6GIubf755d6Qzn5B/yDFYBg/yYVOgEalz5iGE/K8vsutvpG5+E1J0tA96D29pqsdR5PCFtRXeK2rJxJVj/IVDxgRl72Kgx27OdDtuKjuZN671Jb9LsP+ntbrn7ypA5F0C+gAoY/THl8U5mmSCpTX2UZZOvcrQWUA5fkHL8pa8iwejOiuPb9XSYmzil5+WauBNUyaecYZxgz3Gsmfx5DWIDKALoEWKgnpQ7rKzNXgHX4SRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 12:49:47 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:47 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 08/16] bass: Register cp handler for Add Source cmd
Date: Thu, 29 Aug 2024 15:49:10 +0300
Message-Id: <20240829124918.84809-9-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0035.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: df5e8c9b-5e82-4379-a8ad-08dcc8291096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OFY6P3quO0Fqc20ut2cS0zKzr9mpzqzoGx6sBJYxldZjfrb2tgcrdHU4w5PR?=
 =?us-ascii?Q?5pMe33oFUxIi2FDPkNwtFr+PC6WFp9Yce0/LZ6kvibMuvScrrOsT0ZQuvw8w?=
 =?us-ascii?Q?9piSN0VCQWXK+UoaatRqKajCz6cfauRpinanl5sfJtSMMGrZ+ewqm/H7VzIx?=
 =?us-ascii?Q?eKsQ3MGQydlREUPPlW2+CpuXTa+9o+yZSPq1n1+1FGS6mWadFaDh03brGCCC?=
 =?us-ascii?Q?WZMpc926Iv2iivZI3U8j8duxYVrdJSh6jFFzEObxY8rWc24/eVXXyWElO5D8?=
 =?us-ascii?Q?6TXtuiArUdu9jFZH/kQTxCSkrpwj9hkD5oowlE4SmgnDD8Erhb4NvprKv3Qh?=
 =?us-ascii?Q?AprUFSznn0II1fLY7dCcGgauBpm2PkZsZlnkJRps8h1p5Y9dH43NEcrPQMiZ?=
 =?us-ascii?Q?Sv37m5OqRKEgaZ0ItW2SZBzrxI5TC/xJP6bhBvUCvMsDSIQBgec6YNzo6PlG?=
 =?us-ascii?Q?WQpnUY311CPwUQcjEXknPusXmkwViy/FbLRmjB7px0BmLq+XHiavzuAzTfVs?=
 =?us-ascii?Q?LPxZyhk1zb27x7FmgiCkE9VJeY82gYqknVNFmTHPt3c6R8sJ10uN6yYO8akf?=
 =?us-ascii?Q?YHlSRylQH0TJsHwCfS1rmG/JAQE6iPpsZKh3m3i4xiXUUYTAj10i3Hbv6dV5?=
 =?us-ascii?Q?Gm7/tRVD7BW7igQjd79KRQRhGA5jw2QrCeTYf3tTEN8gxw6dyLAvUPcMPQ/z?=
 =?us-ascii?Q?RWrFOsT5zL+/QQ8fsQXQXOzQ5C8p9U7P2UNzU6OttzNHHPqfmypiUf8TegPg?=
 =?us-ascii?Q?BjW3NXgaiwv5FR0ebZhcMVFoSIPMueR9arDJt2AMkBSwnexDq4MCoafZjwhU?=
 =?us-ascii?Q?SzSUG5/5ckGBEBwVipAPaa7S7YE5nkheH3AqM2aiTPh3BGxqBxbIFSIknzDS?=
 =?us-ascii?Q?FRX6g12fuXaxK4KfQKvtxMJC2Mh6Jecla/7JSMtAiln8MJvmHBeVByRoelzA?=
 =?us-ascii?Q?1IPy7IlzDHQUFZ9pF5tmO1vGAd7JZHBGMZFupBeckKBPYk3BDo/cQ7UxzJda?=
 =?us-ascii?Q?1qtT527yyy3bK6NHk+zh0dbzsFiE6c07dG6u62q+s8+aoX9uy+ZqC80qPB1z?=
 =?us-ascii?Q?QCteQuB10P4sln6JtENXGAoyKArhR+OQj83NbfLumN20aNgp9xnF/v+oSECq?=
 =?us-ascii?Q?YTaLJ5hnUQh5CiXStESF0WLgRTd85lVJ7KSoNfLaJ4bAF5FeKg3N94cBThjy?=
 =?us-ascii?Q?6QGIVqg2lqTkefY83HmW1nV4Dfyqpt/DuWNOB4etAxaLQUMxedH+k1oxgsrc?=
 =?us-ascii?Q?h3/le9HduJuKBlr52vzsBumXeTo5CkaatI2LqHSzPQCrKWvIHbXXdHhyCp3R?=
 =?us-ascii?Q?9KywkPDXA0GDaCdhlJnv5TCruatOPe0qeoYtH8zXUg6+IQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YPF9P/trfp3BvqaQjkHpKm5UIBUzVnkLTDfmk0r9QaNscwAe88Q6ZyBe8IvC?=
 =?us-ascii?Q?mQYSm22vGuoYj8ajd3cx4YJcUJJwECgTXj5E1TQEyWKBxc6r4cZhWVyh3lrA?=
 =?us-ascii?Q?xsua0JRo8Grx5ZRMAwr1zNNoAbfBpR4H05U09w2yFFKxfs0K8zPoBwKhwKL6?=
 =?us-ascii?Q?7IngBZTVYZFDFNbFDO6mOYwzYuVA2LvMJ7r/gOzLKrn1d0gHPYS+2fNw7iqT?=
 =?us-ascii?Q?pzoYRZLo8thexNZkPuE9xK730SlKBvhqUvGeeXuBmnozEh9dDsVH50NqwwiR?=
 =?us-ascii?Q?dV/NoVJw6ETkvtTTAHoN+PIn90gH1eqZ4VfgOYWbbWf1p1Rh5GJewAAVlkcB?=
 =?us-ascii?Q?9X2xJTtYrAzA5dwMyHLt2Upd7adBLkaW/JHZGeCG9YWGXcJUKdw7HfDXu8VY?=
 =?us-ascii?Q?VIGHTYk9XXL6xwY21Kqon3JY0adiMcVZmfiz69Zq3AVj5HyUKU8ze77thog0?=
 =?us-ascii?Q?DYsn4RH1f7Vxxgnn/6M5ZS9z1FpgnU7VUo3gAp3ks+cMWA4a7EXIisCYYh+C?=
 =?us-ascii?Q?qfxnylblLhERi9mjYVIHp2cf9MoSCnCN0EkQCRs57JjBUHQm4Rvl7v/mDKW8?=
 =?us-ascii?Q?JOMhb9CxgF/TgDnVLGpywD7U/wfAkLy2yhmNgLqDcIcM+rEoPDfVPcJKVD8K?=
 =?us-ascii?Q?xdmaCMSWjN2vp1IAnk/0HJErey/ky4GEtNGaDhSD5cKTacc33pADP7dGb8XU?=
 =?us-ascii?Q?S/32tXpeMtkfyzgu7IVxqch4dAN7qqlAE8x2qxAPwohpFJFiY3zEPOYrlMj1?=
 =?us-ascii?Q?UbcXzsGpCashuMHJSqPz2L+mEkHM9W6d8TVoKu7h1Y8krSO9hieeA2k6+AWS?=
 =?us-ascii?Q?TgGO9e+OKijBRb0xCZWhPtZxyCIWLmm/ZbTbwBbNSynyJAVmw2EE8lkdVVAe?=
 =?us-ascii?Q?9lMxv7PKnZwkCZ7WbpzM/Z2eOZ72/OhXmL9sTy08Og32T1D81hTiOged3a93?=
 =?us-ascii?Q?drubobrVENW7WA0hk84G3H5o0/UeXkjcOfTnnjKpM/NURSP6LGNX05+5qXBF?=
 =?us-ascii?Q?6EDZFSMAV3SD7ODLWSDgFbl6tHzk3XfsYyo8FwpkYeSMw1tyRlfMgvBQarhU?=
 =?us-ascii?Q?sS6PWLsm7p1NjFca6J5QszR0uc0K+9ifj6AYQBbhcRVeaicxdU6k3HwUuSHv?=
 =?us-ascii?Q?rNnDw/UcEUJRe7aRnCFmARxAcO2mv9zc3sYxD1VBR4u5BjrnB0nXgsSkuH/y?=
 =?us-ascii?Q?6zJcForEkgjn1zBsIRm3IBlx/eExWJNAbsvqO+bw6N8T+2s54ZZe4TcbZvYR?=
 =?us-ascii?Q?XOygrnkNkEjAghsEh8bWqr0F2Z+FEPQdEFdYwZMDtK3nZzhcyE7WS003BPyB?=
 =?us-ascii?Q?NlTBM6fg2JuuyfkYWdAtlD8BQXb8p4/1diQo9nsuHIPeWf23oXR68l1emN6L?=
 =?us-ascii?Q?C0vESmG6bSSbi7bVNOVz5+OZJNjpj8e/ERFI/BUnzL8m4KOZe7PnBloEQYv/?=
 =?us-ascii?Q?MtvnSg2aHA1V9RW94BOUiprSF+eK4z8RwvTWIHmKvd2kdt3zTuJwsdaCci0X?=
 =?us-ascii?Q?vEdpKVdZRrFcw+d0STWroSM8DXPtZwNtteAxqkSQRxebglzTnNL9cpS6zFV/?=
 =?us-ascii?Q?Q2B/hTGXwVhgImruf0SZKlTteJbqYfWAYJfOqUemOGtveeIxaipiVaiXjYM+?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df5e8c9b-5e82-4379-a8ad-08dcc8291096
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:47.8356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J8tLreXyjOt6VCk7siJlalP9Cs8iIx2JrGfNU0pbKN2zb1KgMGgPrVOUPN2zZNn1DqFFDvmwQA7AVDy/dDP0rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

This registers a control point handler with shared/bass, for each
eastablished BASS session. For now, only the Add Source opcode is
handled.

Using the parameters provided from shared/bass, a device
is created for the Broadcaster address. The device is then
probed with BAP, where long-lived PA sync will be established.
After parsing the BASE, transports are created for each BIS,
as if the Broadcast Sink scanned the Broadacaster autonomously.

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
shows the long-lived PA sync performed by BAP:

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
 profiles/audio/bass.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
index b3740f64e..ee378e141 100644
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
 
@@ -627,6 +636,70 @@ static void bass_detached(struct bt_bass *bass, void *user_data)
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
+	/* Probe device with BAP. */
+	bap_scan_delegator_probe(device);
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
@@ -652,6 +725,9 @@ static void bass_attached(struct bt_bass *bass, void *user_data)
 	data = bass_data_new(device);
 	data->bass = bass;
 
+	data->cp_id = bt_bass_cp_handler_register(data->bass,
+			cp_handler, NULL, data);
+
 	bass_data_add(data);
 }
 
@@ -780,6 +856,9 @@ static int bass_probe(struct btd_service *service)
 	data->src_id = bt_bass_src_register(data->bass, bass_src_changed,
 						data, NULL);
 
+	data->cp_id = bt_bass_cp_handler_register(data->bass,
+			cp_handler, NULL, data);
+
 	return 0;
 }
 
-- 
2.39.2

