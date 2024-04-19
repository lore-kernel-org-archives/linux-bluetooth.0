Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475C5130A5B
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 18:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550085; cv=fail; b=P49CncJfMveOzfINvU9r40ZiOvqzeQeo6kZsLVi20EPbbmXDs/4TQiGfFqZV/F2DXTWRcf4dpO4QbXxxcqHXTeFGWUXO9p3T3dT0glRg0aZnv0gw+BfmjLAQVuAPj5mZoVE+SnwhbSf/rgfCZBjKmzH6EK2gGDvH4c4seRf/R0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550085; c=relaxed/simple;
	bh=apBN7mYa/wFxB+d5MbV2/te6+HcSHHT2Qwxz3r+PB04=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Dfttz82tiYhd8H3YMCViMToTszXKP9dYYXwRoCj87Rn7jO/8dQ33i2MoLX5j1YxxAugJjKM7/ifI7FXA2HSzs4Bskp29lwXOH+YPqBWQG9NI+qTtNZGegU+qMOmSuC/M/LXTaX3pcSVJcyBWPMCNYNAIlUVtU8qzNyBir0CGRK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rbyty7zX; arc=fail smtp.client-ip=40.107.8.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rbyty7zX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC1wNp23rH+bD7GjZcNngoHNA+has5b/4vzLIsFW4V5rNmrZRs+byVqL/JijTOO9u70GLtkS1ON/WV9cmE/VINk2AM1OQA5iwjAc7UtjmiywXBGB+hnSX3tTpQdo9JOIsy1MMGS7oPz6qL8oAa6HODwk5g2DBpTcjnWRRVf2c8W31iJI/cEonLUWT0RKEodFaVizZiVmC3LnT1NgPdgipavSRxBT64c4lZmUfx0YPk59LnI+cnqft21UWSVUvgY+IH1LgSIr37l48tXtps5rdL81/VVFf1BmMKxQ2Byc1vqBDX+G3XntIDX/ythg2/JObUjd0l6TAFxywRg7a+K6jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5YFdO0vBGmPPrSasv3w6yTgesb6FUUz5kAOGp7xUiA=;
 b=EDYEyqPHhNurwy9iMRatXPB4anwAMuXIMtj+QM9p/j1R8MiqcRYrKS0dxQhX6+5s16ITeY6m8PFTP32GgGxOqxj6zBUCU8UhY5Zgv+KeawG/CzXG+imSyoGjBGgCLLgRakclnuOQg+GErR63CV4AkCT108Rvip+/bLx5SX4aHCfXGcUDB5LLSwXI317aS66b/w2w+DF6yBW69LgL/2zuz5Ii5URNOhQMWSbsh5ZaLJLOUlRgjjKATI9kKaDjiT65J6p2IC36cE1ZvMnvjWZBnh/AGeFvUkSp7fow14ZmWl1WnMobWYS6rJPCS6MPue9tjh1kjTqzlac9VEtqAwQ5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5YFdO0vBGmPPrSasv3w6yTgesb6FUUz5kAOGp7xUiA=;
 b=Rbyty7zX7Ut43OFrfOTWtr1ZG0M1yrVazBzOTSeR4hID6+vL2FbNn5KGiRBrEOlulL/Lvvya6jC/Oj23exvPZWgSpzZl2GVgZfmFWKhPxFNttI5rkVmxWIA3YY1xT1b72zZY/buuLn4Ory108mhMsMNGWZ4+Y4kNw3g5k/HwSIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DBAPR04MB7381.eurprd04.prod.outlook.com (2603:10a6:10:1a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 18:07:59 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::fa84:407b:3889:82a2]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::fa84:407b:3889:82a2%5]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 18:07:59 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 0/5] Create transports for matching BISes
Date: Fri, 19 Apr 2024 21:07:47 +0300
Message-Id: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0019.eurprd03.prod.outlook.com
 (2603:10a6:205:2::32) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DBAPR04MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: e71db18b-6cbd-45bf-0e7a-08dc609ba579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oHs7YFy8UHLR/k6NE8CdIFp4CUVl7KpAyq5YuFg5gJkPiq5F5nTyGP1cSuKuu9iWvUZprloZqV4l5l+aKndqarU6WMZN0hYBXUQpeXi4bS5a/Mfm4An5gKJl6G/kVWjQkPT44m7aeTJUN9B+NkxG7iBgZdo69pviVdkmWB0xn2a4jgfwRsXlKu6TsCHqQWGQKRkwBj0xAfN5zgO5T7ImgP8fALVmM/cC3UffWqilIxY2pZTt9KvmEcqSq8gN3oM5LccUGiVnwpa0dca2f5Ry0XXJpfMHg0bG2dfuEa3SRuDbYaiRFhuUnLtHJIweOIZPRAYkg456DfCQ1FlnUgpcrzrDPPSQzJLjKkCIOmQ6ssy9q7wT8VWGZNuwbaQCIM/AJt37jw3B2sdAjK2kPNOw8fVYYx9vFfAj5t2eRRl8995dyVC/PAphkUmhNgn5MtjlJobX76COgyTujQ9F2SKmZ7QMjeMoiOuMmlftV87Thk+0zQQ+edTf9xi01hS1pk1NzwW5l8Ta+cvCQ18xchBlZk7QcRExKdKhS4vHSgUqgfMFZWsvoT9naW7DglLxZqnQT0PrHEbPg7o2T9H5speymuhRVdls0XjPzhKEliq3yE+7hJqsm7MCNwoazTDFYTTOuDzYHWzusnRea9mH5OZcxhjX+4t36Ldx7YT4IvY9SkM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vygswr7FVPo5Pss9f5etoTDlWUH+md8BMtfrZNr8cDuonleAse/UYFz/0a42?=
 =?us-ascii?Q?Ypk/IIElyRgQhEppoax7By7Z4pztatAhZTtbTRuCssFKu1GxbvzOveYW3vwD?=
 =?us-ascii?Q?qpGILGib4sVaUD7IRnvFT1UGDcCNhv4iFaNzi8mi6JwTZ1IZmySbEGgZRYHL?=
 =?us-ascii?Q?ejIKRtCqgGbZ5XFe1ir3gIYqJMDs3/DrlWWBaQ7cEOpUJ+Sy5n6uhxngu/5e?=
 =?us-ascii?Q?SLRcspqAzhq02qYB2vyRIJln7AW1ayWisdEPVGeyX6Fkh/8KEDYg1GclrzQW?=
 =?us-ascii?Q?HqaeAz19ZjX/CzBUVfRLf+vYxhC0h+dAR7vTWF1RNVqzpNqP6lNYlBiuhQ7d?=
 =?us-ascii?Q?7N7wf/EpQhfoX78jFMGp+6Uw9Oo6wwfxRGdBPcVh/wJGbNsr6vHbdTa48FKG?=
 =?us-ascii?Q?6G08GfVNcyMEkqjekxId/3fL3tbLzMkW8WyNxIsRndT3KuFDVQ7ZM5aeyU8I?=
 =?us-ascii?Q?MleYLKL+1rUXlskFjhtagwvhwb9xn9E1tyFyXOcUM0xDiadeuR7GbtIEJwmN?=
 =?us-ascii?Q?59Rby658NQRdBPytNxed+7Bpsi2v1dD2A+FNGRlJ39scULYd8+jhxiYaVvZW?=
 =?us-ascii?Q?7nRUnBSxeJQ9q0Xxtsn3KCw+VujZi/4mvCsZ2wRaf5QTNohJ2WJI1EOwWJOu?=
 =?us-ascii?Q?qvAIrJYvoK7Dgw9S4oEhkShJfUBvQNmZES1JmqO2Z65ixvVEhhPsDYm/0+q5?=
 =?us-ascii?Q?zYa/ZInyYbwnSx5tutalE/UrMmd/52bjennKSsCjSsw+f2dPIWJ01qTBIXpH?=
 =?us-ascii?Q?iBa2dGJ39+eKSZeGOGinFmk+gqcQKHEkR7OnZv8WiUo9qKibjuixDvYEN9F3?=
 =?us-ascii?Q?ZHQQJoR4cKnlBnvTzKmYpOq4fOYNl8n9UAbz7nHw4hmr2NfYVE1ttL5puvx6?=
 =?us-ascii?Q?2ZcjmQjs85uJqEgcrsQ0nH7DQqX/jw8IVHW/6t2D/g0qMepcWRglKLRMnC87?=
 =?us-ascii?Q?S1nK7MaN5IouETlHHQXBF/sBwolWc8iWnMoLwV5ncPzSCDn0oGCCp9qubd/p?=
 =?us-ascii?Q?2ycgmolOfOPU+NRHG+H6hLXUBl31mgWvIvubEnMt96PYR+BRTQVjNOxlsJww?=
 =?us-ascii?Q?ZU8tg5NfXrcDUHzeCCy9RMs08nrXlCM8fLCXaNdWzNh73Te73/1S9hkIyCiP?=
 =?us-ascii?Q?46XtP6ZPybNlrpsYtobI7o6h7Ze38Blt5GjbP/T/CPBCRrtRMvUKGtDZUUVZ?=
 =?us-ascii?Q?5+LlkIDa9KCXFigea/2kKO+ZgIIHcQCBvPvmjgWgSwCG23uqZk92RgihLxYy?=
 =?us-ascii?Q?LaGau9xCT2SZ3fQbq6m43LIA/a+AWS5rC3E3vShl5/gVPMP2Pcb4U2KldxrI?=
 =?us-ascii?Q?dId7EJCyD8QfMqx18oBXoy/VIN7KRjqUIRrvEiSSlj8mrg5E5oSPLzCAV6Ci?=
 =?us-ascii?Q?DuzDcvrggF38cFPGC/PJ3TCY31ZFuXnmZfcewtyICMtr4peq0przqvgFV4/r?=
 =?us-ascii?Q?ryIxRc45nK0LcJ3bwP4ZzodlzZsFOuf6THFhRz6xmB4hZIyPb/6/IzARdV1B?=
 =?us-ascii?Q?YZIC8jCYXwnjRz9f5pdR+BC3wFQfrsSQv0unZbWgXOUf0EcVylEUwtiv+3ME?=
 =?us-ascii?Q?HOPxNYifNc2Z63I0SFkqRrloqeXgPkM/xRkHPwXYZNGrv3dudwRAxGI1szHW?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71db18b-6cbd-45bf-0e7a-08dc609ba579
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:07:59.4542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DO4xC5C0/2U0SHfCSNUcNxLRRke9P/ei7SfsdD9pcNg+ssW22B8u8YuG+2DHp5KgBRtRGlOYjjcVTXG1P8AJAjNigrtZzZhsvBdiNfJEORE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7381

This patch refactors the flow for the BAP Broadcast Sink.
After observing the BASE information, streams and transports will be
generated for each BIS that matches local PAC capabilities.
Because endpoints are not available any more, local PAC (which contain
local registered capabilities) has a new list of setups. Each setup is 
generated based on the matching BIS observed.
Then, the setup is used to configure a stream which then generates a
MediaTransport.
The transport is in the TRANSPORT_STATE_IDLE state until someone
acquires it. The "Acquire" procedure results in creating the IO using
BIG Create Sync. The successful reply of it causes the transport to be
advanced in TRANSPORT_STATE_ACTIVE state.

bluetoothctl log with two transports being created and acquired:
endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 3
[/local/endpoint/ep0] Supported Context (value): 3
Capabilities:
  03 01 ff 00 02 02 03 02 03 03 05 04 1a 00 f0 00  ................
Metadata:
[bluetooth]# Endpoint /local/endpoint/ep0 registered

scan le

[bluetooth]# SetDiscoveryFilter success
[bluetooth]# hci7 type 6 discovering on
[bluetooth]# Discovery started
[bluetooth]# [CHG] Controller 00:60:37:A6:AE:22 Discovering: yes
[bluetooth]# [NEW] Device 07:34:BB:4B:6F:C3 07-34-BB-4B-6F-C3
[bluetooth]# hci7 07:34:BB:4B:6F:C3 type LE Random connected eir_len 0
[bluetooth]# [NEW] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis1/
fd0 
[bluetooth]# Endpoint: SetConfiguration
[bluetooth]# 	Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis1/fd0
[bluetooth]# 	Properties.Device: /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
[bluetooth]# Auto Accepting...
[bluetooth]# [NEW] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis2/
fd1 
[bluetooth]# Endpoint: SetConfiguration
[bluetooth]# 	Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis2/fd1
[bluetooth]# 	Properties.Device: /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
[bluetooth]# Auto Accepting...
[CHG] Device 07:34:BB:4B:6F:C3 Connected: yes

[07-34-BB-4B-6F-C3]# transport.acquire /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis1/fd0 
auto acquiring...
Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis1/fd0 acquiring
[07-34-BB-4B-6F-C3]# hci7 07:34:BB:4B:6F:C3 type LE Random connected 
eir_len 0
[07-34-BB-4B-6F-C3]# hci7 07:34:BB:4B:6F:C3 type LE Random connected 
eir_len 0
[07-34-BB-4B-6F-C3]# Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/
bis1/fd0 acquiring complete
[07-34-BB-4B-6F-C3]# Acquire successful: fd 8 MTU 40:0
[07-34-BB-4B-6F-C3]# [CHG] Transport /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis1/fd0 State: active
hci7 type 6 discovering offm[seq 0] recv: 0 bytes #            1
hci7 type 6 discovering on9m[seq 146] recv: 0 bytes #              7
hci7 type 6 discovering offm[seq 149] recv: 0 bytes #             50
hci7 type 6 discovering on
[seq 2446] recv: 0 bytes #transport.release /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis1/fd0 
[07-34-BB-4B-6F-C3]# [CHG] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
/bis1/fd0 State: idle
[07-34-BB-4B-6F-C3]# Release successful

[07-34-BB-4B-6F-C3]# transport.acquire /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis2/fd1 
auto acquiring...
Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis2/fd1 acquiring
[07-34-BB-4B-6F-C3]# hci7 07:34:BB:4B:6F:C3 type LE Random connected 
eir_len 0
[07-34-BB-4B-6F-C3]# hci7 07:34:BB:4B:6F:C3 type LE Random connected 
eir_len 0
[07-34-BB-4B-6F-C3]# Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3/bis2
/fd1 acquiring complete
[07-34-BB-4B-6F-C3]# Acquire successful: fd 9 MTU 40:0
[07-34-BB-4B-6F-C3]# [CHG] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
/bis2/fd1 State: active
hci7 type 6 discovering off
hci7 type 6 discovering on
[seq 1330] recv: 0 bytes #transport.release /org/bluez/hci7/
dev_07_34_BB_4B_6F_C3/bis2/fd1 
[07-34-BB-4B-6F-C3]#   1;39m[seq 1331] recv: 0 bytes #Transport fd
disconnected
[07-34-BB-4B-6F-C3]# [CHG] Transport /org/bluez/hci7/dev_07_34_BB_4B_6F_C3
/bis2/fd1 State: idle
[07-34-BB-4B-6F-C3]# Release successful

Andrei Istodorescu (5):
  shared/bap: Allow NULL bap endpoint in streams
  shared/bap: Get broadcast channel location from stream capabilities
  shared/bap: Update stream management to avoid PACs
  shared/bap: In case of a BIS-PAC match return also the local pac
  bap: Create streams and transports for each matching BIS

 profiles/audio/bap.c | 184 ++++++++++++++++++++--------
 src/shared/bap.c     | 280 +++++++++++++++++++++----------------------
 src/shared/bap.h     |   6 +-
 3 files changed, 279 insertions(+), 191 deletions(-)

-- 
2.40.1

