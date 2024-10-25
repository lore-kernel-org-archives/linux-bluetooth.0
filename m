Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C42D1F9431
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858936; cv=fail; b=d+N3d+xS/Y5gybjvJm69kGTFaZFjbjEyP+S2j/fIOqhc3kfvcjzTqOCXk9cWtjmv4snNgXC5jC+jIy4cRAjfu1vuFP0N3K1Cqje/eZSXSXwqWS4wFUwwRv6RoymOzHTIt7GBQkjAnfrCPaWs08j4I0Xl6ZXTRVCWwTqnLrgmIQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858936; c=relaxed/simple;
	bh=VvBUP/d9vYVyenWN6y1t6CRZW91spTXYambaQ+8tJEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HsBn5EpSYv40rrPya4xdC4Q4H1ztT5qftsmwhlKUSPeHz0Cm5k5bwsjDoMlyIw6IokQK6fJbmc87mv6HC2IEXbmrKqRS8fzgUhrXlOffezeRJ0aE7OvNOQunB+IsX5mDV2dmz7Zih5eRW8d/wJKAfAFtmOsVyg+OeDPGD721e5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YF83rTuM; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YF83rTuM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ho+wr7hZ9VSvFzsL+mDmHqNXCYr7x/M6xDRygGWzi8JE6ot6x2qdhGtKvPRmEZr9u6wYVdjJuOZO6Or+lCmghi46MNh3o2LtqWy58IULF2D5iXn047L0jZQBmZJ48dntYG8GlZBSSr9mC7cFMC2tU92KCJbEnE9wbEWD/ydOZpMH5mjqmUEAXaNu6gB89M+MVgkvzyzDDJ13Kr0km7RK0uxRYjOCJij99w+oeCOSM/e6XZBWgpjxbWTBCki6yg4SdXDivjlyykKIbu8HjwiaBFG0tfdzjKwvkRfysmejF1nkBgRhuhyWXiJyII9BRAy1Ddft1WQgKZrmSUGKW9nAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nss2NW3CS5VrO7WL0Yh+me8Jjq80bcy1adPB1vsExZA=;
 b=fP88cOphVGgoZtdqET/96gpy4kJW+zeaZeirDrrHqKBWmJQdy1MVL5Ho8bN3kmTgRYZytsTm5NRrLANouZPQ1RTMtSw9CgfSt6eqcHaer14V9JTFB0eMWsBcr7TmWB0hQj8sb6JByPop23fuDB8qhsF+fE7oiYn5P95tt+CzwkWzp92u9b6OLjs79VwA/lw+eqpt8fVQ00JBJgjxsLubr3tMKIWtLSpSh6s2YDtLjUuXGkpfRHnPpptlZKOeGVCB15Ekbktd708JS1/5cc3zFUylwEWM/87xlNJISo2LHaGIiHPe3XxHMKKlG8rCd5wbzCtXrbN9+W5eaM929sidgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nss2NW3CS5VrO7WL0Yh+me8Jjq80bcy1adPB1vsExZA=;
 b=YF83rTuMJAN9AdjxATFpvSZ56PljUrIhCzRUItfwrq32D29Y9kD3dhsqP0r71UyVze6zjOaH2A6XtKBRA/RUAfgteMlpd5QbL3m7clPiD/4eyqdwND80t3h6bAahfMm/O1NtQzizQq47KqOotd8G64cSs/k0sNZ8zEhn1RpvTnVRysFb6wagd1BhKg5FQAsLD+hQdkgtwJLShikahD4v66FaZW8s6/kkNk9pz59IN3O3k03/JHE8Om4ivyJTdHTnjrgJhO3dh0D13ozHnCsZHDiGbxa7bXIBGsiqSnNNP1mPZpAi+qTG+qzLJmbWkz7pz4oSc5bkzzT4eXpggrHZ1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:10 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:10 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 00/14] bap: Add support for Broadcast Sink AC 13
Date: Fri, 25 Oct 2024 15:21:32 +0300
Message-ID: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI2PR04MB11052:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d184658-f0a8-4f98-63c4-08dcf4efa65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2y5hbvKfZ7PqyMsggS96oJQ3l2VQYXwK4iQhGH+IWzk6E1wm2n0Yqwss7teK?=
 =?us-ascii?Q?14jXc43XOy/YrrwE0a/r4KCTcY84ThBCVCGHb2Pnh+mQFJyqHRxeZrqsI9XM?=
 =?us-ascii?Q?jefvqfpTBlmu477T9+6o6xyD9f02ejGZE2XqXtTVmtu1720AkwU9lYO32p5L?=
 =?us-ascii?Q?nO2Xxfu3ar3ZLimNJGLvXeVQ38ru7ISjwknHkv9tpt/MnKvetFd1/XNCvxK+?=
 =?us-ascii?Q?C6PkPmhSeTlO0E2ZRCAqBorRORpNxJNXuGUyZCgDRyIjeliwqnp9fOcwTxly?=
 =?us-ascii?Q?FeJyElWiTezvrJi4FUsTniDIaDm6nzD83hDEILVQtKkxFnUkuDUcQ2I+8h7c?=
 =?us-ascii?Q?L1vpwRj9yWVZzQQk2BtVlU4D11hN4TltOdhxbglLL9BiEV25TJfMjwiVgh8o?=
 =?us-ascii?Q?NpYfZCsM1SFCFlxz45wcmty6PcYqVgTBGIfUzdVuAn8BiaoaT/Hrw3CHrVbj?=
 =?us-ascii?Q?ckGpBuXVcvj7hjIqfG3gckqi52yUfrob1r2TRbcA6iCYZLLpAIDNpVvBhy6A?=
 =?us-ascii?Q?pTusQLogMO+1wT8JuUOT+q/npKc69/nVeRtTuakdBbLLmK+qNClfpwkfkw6s?=
 =?us-ascii?Q?NnOY4WkC6oxKNWRxfjFic/USReyZgkKnIJ7V1HNAMZkCMdmhbSUC6SySmBd2?=
 =?us-ascii?Q?7hqFaNxw+Uv408ytzqVnKN1lbxGpttCeBvYVnQd16EiBzSCPkpO53w8ym7/q?=
 =?us-ascii?Q?6TWfLCmM0tgt98vsxHyRevAuReW0YolLVFFzfMJqHOeKBj8qd8QEPLJ9f/qM?=
 =?us-ascii?Q?9l6+s8d+LO22v7oQVIxSRnDh9anQKfevqkIjyW/nAadWXjjfOVauMjxjdGAD?=
 =?us-ascii?Q?B4LZ8giMfe7i2augI3fefbt0ZBkFVxMQdDTbbI9jPwdu58+aDIqDdObKIFFc?=
 =?us-ascii?Q?LPJvjuIeHpnDUU3f5hyOZdJLxNS1Y7VxvcWKLFlbj+PTAtbhuyGuqFQz7W8r?=
 =?us-ascii?Q?yWJf3e/cLsAO2VIJWvkXNRTYRn8vxF6iRwjNy8BorqJXP7e/RR8k+Edph+Cg?=
 =?us-ascii?Q?xvkLo22iG9o625Ly0lOdlMGkc03Sg2lm9D3mpenBPfbn4d+BM27DDHJ9apWT?=
 =?us-ascii?Q?pvjkOm4trfxGP1diuv7T7yKXSvccG/vDezECoP9cKwmn8wywfBH6I4x04zVq?=
 =?us-ascii?Q?Tsl2zeJ/MgjGXUbMQX33uFN0tmmlAn9CwG5IuiJ640KkcaTgoAvD5s+qzLc4?=
 =?us-ascii?Q?b0doKGcIbAl8mbqwQyLfHjOMJP9A4YChqfYq0zrnJLnSHz/XvfO+ez5RIV4r?=
 =?us-ascii?Q?oZcr2X+w/fKP+4AzRSNhgLJ0+0DXPYEfCgi3AtIGUCu3oqz1+J1tFsU9BGYB?=
 =?us-ascii?Q?jscCGiBzkmxZfMjsxVjO5m8OPPv+Vdgfp5S0U84Y9Z/MFu+a5XbO8wlxkwfV?=
 =?us-ascii?Q?9plIHS0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?By2Fb4E14cJZcDeZfe6tAIQLJSqZaYQkFRmPmeqBS699hBer03+kL73Gf1Qz?=
 =?us-ascii?Q?hk7g6DxnZcAKuvzl1dGxDeKrswdX5M0bjKhsNo3U8cr/WAOiGClcVeOeBTaV?=
 =?us-ascii?Q?6mv/BYbBWTmf0dDvs4/BEMiNWh0+QMECNdw6o84MJAhaUAdxpCW5OYTBCGIf?=
 =?us-ascii?Q?ZPdBBzo7uFL7COHi/XpqlzoG10iAJQPs6UdQS2UOG6mv8CKS+Vhm8M3q82dB?=
 =?us-ascii?Q?Zr9xv98KZhTbWaB8rj3TCfRRdvIaEWmiRUqyCEgFZl0F89vmRtb9y0qlFwd/?=
 =?us-ascii?Q?0Y799C96BeLznt1XOEmxsJZSfmn1GuKuM1FeFNOI8I+f3kUH/gxZYIoL5rN2?=
 =?us-ascii?Q?L5GVV6I7kO3LxT0XBA+QbsfgT7RF+hhHyFGwp/ubvZ6zDiQOuTVsDmyELy4X?=
 =?us-ascii?Q?QCqfbjVUYolzWDZPLS069+zFNAvTIBvZD61a5cU2ZHHaVlOfYysrVRGxHPUJ?=
 =?us-ascii?Q?Ifa5Zp6E4yTU9GFVJrIVMNUQbptum7CYiSoKbWE583PaKEKhRCv5VL9Q7PIA?=
 =?us-ascii?Q?DK6PRsT/Ii1NyFFFXknN8+nLgfae2NJw/2JbKzLlHZCCcW6s/uYupB1WOPBe?=
 =?us-ascii?Q?5sAY5kffEqim1eyz6Gs+HkwQTcZGDEitNscGBHGGSHzwnwxXNr/h2bDKMiAk?=
 =?us-ascii?Q?3OldKCfxmmKJ93/2n3grXDDJdvabOOk+bq26Hi0hEX3V7XjQR6rPSPSgjSyw?=
 =?us-ascii?Q?8Ms7HTBsNxhchnSDzoUDRd1JamungFdGulPkEFIU8aY3EdOcB1zVN4AZ0eae?=
 =?us-ascii?Q?wMQeoU7Lh+WbjO5Yji5FG2QWPXDsNNs3owbijspGpjBy6LICNYKrTa7XuoUT?=
 =?us-ascii?Q?HRL5WfbIQT2TU9g3PAy+NLNWvKeYrverpa14NofXWjz3xVeilA2R6iwunirA?=
 =?us-ascii?Q?jnK84Orul7JgAoGWkM58QihpWF3xSdvZid1+w+eDMIJevZNfNjkMkEfbOJj2?=
 =?us-ascii?Q?y9J4F01XdlvAS7mYnAADIHA9beobHD1/oxQ3iqu/E7T2KvrKsNBSuq5EoSrK?=
 =?us-ascii?Q?cM75tipIKDvFO3HB6OPzQqC+VN1XBzleVfNggj8OBntu97o9zSQoU8jcmQ7c?=
 =?us-ascii?Q?ebRiNxJcEGWwFrCJCIE5NOqY5ip39Jf3M7PkcxxIO+5bplWRxxWCKbUTa1Ck?=
 =?us-ascii?Q?gLqC9E74WKc8gwqELXUiytdydrtNHsaRcpr/N/adrgwpNNFeMVKCdO+QGd87?=
 =?us-ascii?Q?9zsQLNwidGU4jDUYfdqvhooA2d4iP52PjAA9N1M6bJ7WVn7aPopfCzigaYhm?=
 =?us-ascii?Q?qlxj7xyrjDb/bI1Twl/v8ixXyjfJszLx4+4yc5JDK+DzTu3tU1u8DgN9A3J+?=
 =?us-ascii?Q?6JinjVHujjQGG6yPBUqAHi5V38SHeCIGO50/FGm4+dVBoVqX8LNeH3UDlb7Y?=
 =?us-ascii?Q?tMbpkUJ+WLPe301k5W0uOfsjWUC4TVkzBUiryhoHXQY2g/hNWew1qjYra6aI?=
 =?us-ascii?Q?MLIhoZ7oApS5GeXPaHVwbdZFKA8n/+VDl6e1kV2P9VyEEkP6e90ME0Fc1+ZN?=
 =?us-ascii?Q?glA9rsNG1NPPcf3s7+iPJI3qO0RQF3E9gxxZKf5cD8awDWSeE/N37rvtuemn?=
 =?us-ascii?Q?uRkJhh7Z5riLQRZ63tdzW7kwbZO7zYNzpk8wkGEq6CURhZbztP5DXjqU+nMQ?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d184658-f0a8-4f98-63c4-08dcf4efa65e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:10.6927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VjKKj2hmre0ciqtKdw3rLP+L8zNVt61zjchFAUu+430axnFe2udm9NB0EF8MYIEf4JupF4DzB4bs11xRZ9brnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

This patch adds support for Audio Configuration 13 for a
Broadcast Sink: A Broadcast Sink can synchronize to
multiple BISes transmitted by a Source.

Broadcast Sink streams are selected linked together.

The bluetoothctl log below shows a Broadcast Sink detecting
2 streams from a source and selecting both of them. After the
first transport is acquired, the link is created and the first
transport goes active.

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
Capabilities:
  03 01 ff 00 02 02 03 05 04 1a 00 f0 00 02 03 01
Metadata:
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 17:7A:80:64:A7:93 17-7A-80-64-A7-93
[17-7A-80-64-A7-93]# [NEW] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# [NEW] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# transport.select
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: broadcasting
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1 State: broadcasting
[17-7A-80-64-A7-93]# transport.acquire
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# [CHG] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
                Links: /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 acquiring complete
[17-7A-80-64-A7-93]# Acquire successful: fd 8 MTU 40:0
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: active

The btmon log shows that sync has been established with both BISes:

< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Unencrypted (0x00)
        Broadcast Code[16]: 00000000000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 2
        BIS ID: 0x01
        BIS ID: 0x02
> HCI Event: Command Status (0x0f) plen 4
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 19
      LE Broadcast Isochronous Group Sync Estabilished (0x1d)
        Status: Success (0x00)
        BIG Handle: 0x00
        Transport Latency: 0 us (0x000000)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 6
        Connection Handle #1: 7
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 6
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:
> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 6
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 7
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:
> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 7

The second transport can then be acquired and it will go straight
to active, since the fd has already been set:

[17-7A-80-64-A7-93]# transport.acquire
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# [CHG] Transport
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
                Links: /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1 acquiring complete
[17-7A-80-64-A7-93]# Acquire successful: fd 9 MTU 40:0
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1 State: active

The transports can them be released one by one:

[17-7A-80-64-A7-93]# transport.release
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0
[17-7A-80-64-A7-93]# Transport fd disconnected
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis1/fd0 State: idle
[17-7A-80-64-A7-93]# Release successful
[17-7A-80-64-A7-93]# transport.release
                /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1
[17-7A-80-64-A7-93]# Transport fd disconnected
[17-7A-80-64-A7-93]# [CHG] Transport
    /org/bluez/hci0/dev_17_7A_80_64_A7_93/bis2/fd1 State: idle
[17-7A-80-64-A7-93]# Release successful

Iulia Tanasescu (14):
  shared/bap: Allow multiple links per stream
  shared/bap: Add support for handling broadcast links
  shared/bap: Fix broadcast set state
  shared/bap: Use enabling state for bcast sink streams
  bap: Add support for syncing to multiple BISes
  shared/bap: Handle multiple bcast sink streams
  transport: Unset transport owner before owner free
  transport: Add Links property for broadcast transports
  doc/media: Document Links property for broadcast
  transport: Set bap_update_links as transport op
  transport: Make transport_bap_set_state part of BAP_OPS
  client/player: Handle acquiring broadcast links
  client/player: Add support to select multiple transports
  transport: Unlink broadcast transport at release

 client/player.c                  |  75 +++--
 doc/org.bluez.MediaTransport.rst |  17 +-
 profiles/audio/bap.c             | 180 +++++++----
 profiles/audio/transport.c       | 192 ++++++++++--
 src/shared/bap.c                 | 498 +++++++++++++++++++++++++++----
 src/shared/bap.h                 |   4 +-
 unit/test-bap.c                  |   7 +-
 7 files changed, 788 insertions(+), 185 deletions(-)


base-commit: 806a552d53c787c0ddea9328a09b0ef124bca26e
-- 
2.43.0

