Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2049.outbound.protection.outlook.com [40.107.247.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F73A23099A
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732200450; cv=fail; b=DDV0Q6PLCMbKCRprpnUs0DDMna4HDFlIThD3C/4RXbFNmrUs21s3uYfOojABMYtfRED06XvE4h1CeVYkj20+sAL68kgT9PBeCTVT/4V/R9e7P7/YcFPvUlw46XAo5IP0KcNLl96QY/4kR7qkoVTQpGZX1PO2UHASljdniYiQfpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732200450; c=relaxed/simple;
	bh=Zbx0ayaeQ8V/1+NWyFSiurG5LewbpYjMB/LkjNY53As=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=B6DnGC3IUHY9IwAV56VtCAnb+ZgfK3c/mEG/I/Odh7+++YRXf2hNd3eDFqgOoFfIVUlqGzgyByjPwxejSHCczp8l587bxR+kCViO9KaWayeMfpNTxeTbYUPydg+j2B08cNeNlZlmCu2Cl2GFt81Imb4o4V7GJ6q1cttJGQXhL0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fl0SnUgT; arc=fail smtp.client-ip=40.107.247.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fl0SnUgT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3cOcnBETVR/7plQfX5HYoMkLzHE/t0BefzpLUb6vacK2vAuZwZG8BmCVEKohrU4B/nYshvStq1V44rb1oQWLyzcxNW3d/3qNMtk5F1yq4gfRaqK69ObnDCe+0KHaZVlD+8ms+n/C3M1yPT9n7CKJNXHsArTfyVA7w8dRUxRXwudIX3u0euwmqM6x999trcLKpF129+1GipWdl1a4F7apbjELaOVQBKMx9+4rrVM5MHRI4qLRgfi62njPrNZ+YPE6CcEuH3I6heoBe5df4LkQjwDRs2RdVC5tZECzmEo8kcdEdJ8RYIIfnn4VUMXo58FjawrGsFgzUdYAtYpdQarRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QIpxzzmG308Wy2btorozS+9+ksa+IdZ/IJp1GExmfpg=;
 b=c7uLmwSqWUyvv/abyCv8pcmGewQM9DXRaNh646cl4UmJtR54EsYxQsgDy9ByUK6gGb3N9jqZ/pj+a2e1NuqLCZK446vObBBiHx5V/RleioquK/oGVw58LaZwrv7W8Hs/hIwdFBHehuLMeyYSkxDKWHCvEBpkXIISbM6LLQ7PiKsVhFq/8JViJOLryPLMxybaCmIn6NqgqcyOthQP2M+YK0an7F94DK96H+5MDEuIfUIWcDll/0D2FsVJAMGOKoZPVRU4b48gDHtii5kNZ/0dqlPEYRdcJ6Qm6GEdSojBKE/rL/hRfeskkvQF6qq0KnhCflZ+chh8OM1lE892/bX+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QIpxzzmG308Wy2btorozS+9+ksa+IdZ/IJp1GExmfpg=;
 b=fl0SnUgTNXwp4lBnc8Eqi7h+9BMi+TaHe9um78yPXWqfRttg+15t7BpaCB3WToQEgKN/sXAeal/rOdH/kKCqghdFmmqbwhV9h9bdzw93W8ecC63RhIQj3i8hKPiAul2Dbuur/pueSOrzu2f4UJtM+k3b0TA1CHOSPRGE0pFjOYeQMYvxJ/6GrHroBaQr1fvVz7HwIvVy9hQUyMSM/roWKEO2fXK7gVkPCXHi2lU3aF63GkO502syIkZJZYDK+YSq/lcMIJ4ccLi3l1r7TS2iJw53lff00oZcNXQefklwU+N+LQlMjmQt2e7CVaobDsasm4wW8dC2o9NTOCVPUCHJdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7873.eurprd04.prod.outlook.com (2603:10a6:20b:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Thu, 21 Nov
 2024 14:47:24 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 14:47:24 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] client/player: Rework transport select for encrypted streams
Date: Thu, 21 Nov 2024 16:47:07 +0200
Message-ID: <20241121144708.79707-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7873:EE_
X-MS-Office365-Filtering-Correlation-Id: c0cd844f-2ffd-4177-3da4-08dd0a3b693e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3hNALfGeCn+IVdTWpsCVbyPCg4zKkuPfSyV2xAEnpVx3frj2lmGn7sjCX4Hx?=
 =?us-ascii?Q?/KFmtYWNthR3ieOPHVzalmZrnfQwX2UF+kBO9I+s9v6oh9Drc0UuNaC/PjVw?=
 =?us-ascii?Q?ecj9mDtfNj04ppA3FuVTtnX9K1gZ3PPuUKmK+hnV7M8w/H13V+8imNBApRWJ?=
 =?us-ascii?Q?iCSW8G6D2VHBLVjIm5jlR7q7uUxN122/MaPtmLWJU0joTBG4h840+dRRYt3U?=
 =?us-ascii?Q?/H+no5bEEP+JiF2fJcO7SK43XnUI/1HHUEzkyMNjWs1QE+xSuehPhN+wv1RC?=
 =?us-ascii?Q?YQgMQh9pR1wO6CJgNGW1ij9JZa+6mJ6MllUWGx+j+5uKEyV5eV0q6Esye+F8?=
 =?us-ascii?Q?gLOsH9ywc6h8/hzDhlRNIuSi7/LGEeoIIakRDUFRceI4Q9C37abm4nwd7D9S?=
 =?us-ascii?Q?PgFyry6KlpE1bsK9hAYMghAGsPrPeIe3yK0kkSoqvFATEG4e5bWJZybR7X1n?=
 =?us-ascii?Q?qiaGOcQZdkXfRwD8t0xiS+9JtbE3qRVquoaJbX0IH0HRVIHAR+9kGVXQnEli?=
 =?us-ascii?Q?3RAql5ny790ezlAWELRmo9BqJPzJcadD89jWE+hcFGHbes9djmxPRVB58Rnz?=
 =?us-ascii?Q?caHt+HF8EtibAA7dACZQ+kaJP0nO8GCOf1avCcScE5j14liKgynA34cNNQZC?=
 =?us-ascii?Q?fJoX9cRD3ynocvv/TVmrmXvMPO7CP91e9C58UsZY8vTiDlO9L2mshLt3MZnt?=
 =?us-ascii?Q?6dX/4TjeIwd4vQdTgMsMXuLrae0D36C15x7dx6GUTDe0V7qSqBAeJXgKEEbp?=
 =?us-ascii?Q?M1Kc1RZ+RDlEm5D025rXtHTVQRw/ltEB+7ejzl/BWyT9IiNpxa8uVsmrlqUk?=
 =?us-ascii?Q?m82MBFz5o2HMpGJ/QQSISmOhCE+6egpO4l0J4dd4QJrmaoyFA1G/rOx0hILm?=
 =?us-ascii?Q?qFlMDc6T8OyEYCgDnLHruOtRpbBEZROsWPDdmOvR5Yl40DWH7re6jlhPNBmu?=
 =?us-ascii?Q?YR0pDrfXCq9KcgbMmXMdo8kla2jcjqJeypBvXCjam+meJQbmVo8twWcnIsQJ?=
 =?us-ascii?Q?SrJQ2ubOEGSS5FaBisfxLXYM2U0sTIdXjnmRa1/QrREAeLSIE9wX+6EcXwm+?=
 =?us-ascii?Q?lqs6a9QBHkLqM0sTY2nhR5/M28mEnvHR0GSQMcTvFdmKwTTWzhTXsljed07L?=
 =?us-ascii?Q?q9inljwvq3taplBmcVujDcJbUEOnKaYFiZl4553IJZzAo4lzDxd5su9L7iQH?=
 =?us-ascii?Q?UCNSG/2bM1vx5oULc5Ze+TTE5UUJuRP28waZkbfI58ssBVw9ZaRKP4/t3GZJ?=
 =?us-ascii?Q?MVTxtkk4p6MGimApayT72Ckw9rYxd9CHv+E1k8BQVUL8UNwBd6NpAtCozzfU?=
 =?us-ascii?Q?ZUCjv+ybTWdFICTkHAC1zwwQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R9PdhPhDQXdkDPs/oel/4oHKvf64YPW1n9+f7h4ZFQ2fjiX9061lJDQxifQH?=
 =?us-ascii?Q?fbxz6zIqQDE9xQ1kjgajybT98g1MKaxl02pwFngcb7I/71V+lzA1IuF2yXSM?=
 =?us-ascii?Q?elatrfpbLp9R97JGqBN4+1WdY6mE0lGMZwqae3U4RZWjQT7GeuEIlCPqSXTD?=
 =?us-ascii?Q?RtvbMLLBnWTlruL1kQkDER/DpabM2mLNsUntKyZJOpmp86nvv2yiCtbMmJBe?=
 =?us-ascii?Q?cG8Y2fmVfooYTLkpTTUxTN51b1Mdd/Ug3RekolVotKYhqjI3tQ8Sm5K+/+qk?=
 =?us-ascii?Q?bHMFe5TLXrFbDE6hGN5wa1AxvwC1YuUHYwVM9HVlObM5ZQqc3pVAQu74tdXo?=
 =?us-ascii?Q?xoZwru24E0FNje22AsJzinZ8cQR5LY5Lru3RNQzcagL6LI3VBnJqJ5+sh0dV?=
 =?us-ascii?Q?a/Prt7ecE/WWESHKREA9v6LglDQoVaNOeRAZIYPLDWia1e2vXDzGP2MPUKU8?=
 =?us-ascii?Q?H3UDErtpiBB9AS5dC4p/lpYNifOJOq2UQ72KTz3zFj43TmLtgQXQDDZbASV6?=
 =?us-ascii?Q?vCOuMgfmLV+uSCVXxRzrqnXLlcexsypy04vaYKYC407TS+R84RqiZTyq9q1h?=
 =?us-ascii?Q?2mJTSbi04o7ySiBo/S3zH/c3srFYmaT1+NxU0i5/tk7BRTlXGebI8kBNwhlo?=
 =?us-ascii?Q?HtPqX0v+54vLt5gsH/C6H64do+CJqI9vuVRd7ZQ3RovkuduZsuHvJrm42U+Q?=
 =?us-ascii?Q?Af9EKqaVo3jnqY8FG2qHwo/9fSl1QtglT0S5Isk5iXGWycse6bUvQpHs0WS3?=
 =?us-ascii?Q?h5Rkyid2gQxdmq0/lYJnBbrUZKk45WlsVwGIP/LEXa6wZ1YOUOoGchf1v+nO?=
 =?us-ascii?Q?aO948CeDxw9dkN+9tXGvDT5wtHfcKQN05TUL88A9p/8gKqz30vcnpZ7hhJjA?=
 =?us-ascii?Q?joPkCKIH78cN52pgkJtVGP1vUqTlAttLgYiJDwJL3PrZa4rsoxka1ml4rg1b?=
 =?us-ascii?Q?uqYTSsnug2lQkZSsf/D96gHGx/qbT3sNMNZiLIBeM78s4cJ90l62wL9z4Fe0?=
 =?us-ascii?Q?2HMn3j/SThqK7Zhko+sc/X0bteT55PqXtxs1V52xic2PCVKMcE2a05MyBiOX?=
 =?us-ascii?Q?0AcQg07O0KraDG93cbLkSDPGAtAuxxRCnMALGoSAyD8HBgjaDUQn6BJ8smaK?=
 =?us-ascii?Q?Aoo/biC2m+zKgghaGTC6gFKYdRG3bnq/Na57Mm/IIrc9AEoDaDdcGWwnMdp7?=
 =?us-ascii?Q?YCSTpB+SFDJbNHEjWwjWskZD0SmcFzIZ+n9OGUumhrnQ5M8CYyqEEA9hUlgS?=
 =?us-ascii?Q?zHvbYz7nY6BNLJ659ZHlNhgRFlOKLnfhUQLSw3Gpr5gAB0HqNUwQlkrfqB45?=
 =?us-ascii?Q?TmA8ef8ZLZLLKUqiZPPgxcFWC9g71diLDY/BsDcQTVUjjua8+dXoJpMTOfs1?=
 =?us-ascii?Q?a0maQOuzAh4IeM3CbNwksBaiQ9ai/iQzQCtx5lWVLQ+Cj6zqtfwmLHF/Wykl?=
 =?us-ascii?Q?nZFxt1PEMyv1+nRQV+pElh4f0dFShAnPpUtc7daoMg+qfID0M7B3MpvdyuBC?=
 =?us-ascii?Q?9/CFxixdIZhDtoPdiYbzZUaOe4d4L/RsbRP3Ei2XcQkLOOqKoqTehG2vfJek?=
 =?us-ascii?Q?tv+RTcEegCuHBW64BIVx2b8nWkmICatOCpwPO/w8nOa47oOP+789Ba6ynynN?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0cd844f-2ffd-4177-3da4-08dd0a3b693e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 14:47:24.7515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPEmkNNHheyGG+TFh87r9wJvJvEG7crDpRmgQl0bAo/sm1KY9cojNpybaSsQ1bWrkw83Ilq5ljZK+TFelBNH7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7873

This fixes the transport select flow in bluetoothctl: If the user tries
to select multiple encrypted transports, the prompts for the Broadcast
Code overlap, causing the UI to be distorted:

[11-AE-0A-C1-F4-30]# transport.select
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd0
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd1
[] Enter brocast code[value/no]: Successfully linked transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd1
[] Enter brocast code[value/no]: Borne House
(null)Setting broadcast code succeeded
(null)[CHG] Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd0
                     State: broadcasting
(null)Select successful
(null)

This commit updates the transport select command handler to first
link all transports before setting the Broadcast Code only on the
primary link (the Broadcast Code is common for all BISes in the BIG).
After the Broadcast Code is successfully set, each link is selected
one by one. The bluetoothctl log below shows the updated output:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 11:16:BD:36:58:3F 11-16-BD-36-58-3F
[11-16-BD-36-58-3F]# [CHG] Device 11:16:BD:36:58:3F Connected: yes
[11-16-BD-36-58-3F]# [NEW] Transport
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis1/fd0
[11-16-BD-36-58-3F]# [NEW] Transport
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis2/fd1
[11-16-BD-36-58-3F]# transport.select
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis1/fd0
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis2/fd1
[11-AE-0A-C1-F4-30]# Successfully linked transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
[] Enter brocast code[value/no]: Borne House
[11-AE-0A-C1-F4-30]# Setting broadcast code succeeded
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     State: broadcasting
[11-AE-0A-C1-F4-30]# Select successful
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     State: broadcasting
[11-AE-0A-C1-F4-30]# Select successful
[11-AE-0A-C1-F4-30]# transport.acquire
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
auto acquiring...
Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2 acquiring
auto acquiring...
Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3 acquiring
[11-AE-0A-C1-F4-30]# Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     acquiring complete
[11-AE-0A-C1-F4-30]# Acquire successful: fd 11 MTU 40:0
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     State: active
[11-AE-0A-C1-F4-30]# Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     acquiring complete
[11-AE-0A-C1-F4-30]# Acquire successful: fd 7 MTU 40:0
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     State: active

The BIG Create Sync command is sent with the correct Broadcast Code,
for the 2 acquired BISes:

< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Encrypted (0x01)
        Broadcast Code[16]: 426f726e6520486f7573650000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 2
        BIS ID: 0x01
        BIS ID: 0x02
> HCI Event: Command Status (0x0f)
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Success (0x00)

Iulia Tanasescu (1):
  client/player: Rework transport select for encrypted streams

 client/player.c | 159 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 127 insertions(+), 32 deletions(-)


base-commit: e59a915db9d8e274bc2aa8214a920c8abe72203f
-- 
2.43.0

