Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC437E583
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348113; cv=fail; b=GcqY9E7eJATEPv4zsHisBrQjkzvFgEGNuTyGFLCxnEc1MY2id+/4xIQdUSMCjolyL+lrndXx5ckA42iej/zr+SwWUhD0pyIvE7+93h+NIifRtF2wr0DrUwhNGw7/zvpT477oU7jInyqyttgcOc9lPs51QDM5n/HP8IHBfNeF6UQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348113; c=relaxed/simple;
	bh=fZW5qwjQludopIlECVUcmUJJza5cjmsyNIMSJI3zNjg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iMkPyLk8696dfabosNgRBMOUKYZDDuxMSGacy3kPhixLbors+GWpVcZNPxlJUVrnSFWoqTPAaiXDiKepn1wiNdlOBl4cJaFTfOaZA7vQd7hQy07RSs5pQiHA0RhGd9Cy4W3EcokrkM4vJlsmnnukZAxWJWJ/Cju0bb6j+3uNA7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=pXr8QCst; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pXr8QCst"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tzm1zMmI/fkWGcOpgHjX6DULXHUZiAHQFv6oNDP/gAqs9+vGXmjNmiAn4pEptfnhaduvl518q4SxfaBFeo11e6eRS9LR0r3Yav6JE587Njoq3p8T0nC/kLyGcRaP2Xp08B3+vYPrtdEL3/TWivMtJauXWYwjQTRqhR3nPZBGKnlTcq+r0UIaD28m5jzXIgtNhIy11noGRWaG6f9WP7TCXv2OHBj/hArgfg4xq0WoD8tmLKCjYzlRvUfA98n1dqgmYo/i6KcLDEPlJ6E33NQ8WDD7iWuR7dApeeW9us73c9XXgG+63yK5CbE1PNdy8ZL1u/737cMje4uQbwPOrk4HqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMoCpKjxfJ5U9BBmKnOIpUsx4NupHhMERWfLISccKkU=;
 b=iooi62tkrCWpE74xn7aZtPCXi3/6A4WKKDQ0aUA/kVZNgX4pg76wRa1aHx8nBCs546NdS0buJv5VJGV4U7h6kSFZDEc+j/srcwmMsS06v4SDz6bGpVbYNf2MXyDV1w6gSHfFEtz0PTyHjtV+38YtwiijLCo5G8BlBoht5a79Sc/uuOJLoASFXP5jNvb6VgZawB9NyarFTdJgTS5ZjgCBMSn2+oNSUvdkXFv6VU1MriamggQkOg+hJSCUDsBHskpIjbOyGm2NDw1PjPbvJvRFGM85QsaLh5U/yA2LbY29MqKrO12xFUtf0Md4+GJiYlkEXp8g3Rr4b/9INH/Sl9Iyag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMoCpKjxfJ5U9BBmKnOIpUsx4NupHhMERWfLISccKkU=;
 b=pXr8QCstcZkC/idxUhbnue2q2JN7T/2CioMXDpXjA6oAgDIQfIDcluk5dus52OsFtuLjsfig6H3ZunWZOxnLvmsfQYQVCw9UwbT39VckXB0OtuB5FIaBhO+YBn9MfKxuGlndZdDRzHTuON0/KZ4ZBo4nslvr+i/nqsJ9lwaWitk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB9192.eurprd04.prod.outlook.com (2603:10a6:20b:44f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:35:08 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 13:35:08 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 0/2] Create transports for matching BISes
Date: Fri, 10 May 2024 16:35:02 +0300
Message-Id: <20240510133504.26047-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:205::49)
 To AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2ea18f-a77e-4a89-7ce3-08dc70f60275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CQMLk4/lxOlxzpBFQTuVDGoFAMxndJcHP1bgeiObsn1/XK0/24WjcyN8j1I5?=
 =?us-ascii?Q?duFBHfQp2cVnFmVpMycbS2Gv9Ly8/LHe9gdhU3xVyufjTPFjfd30EOSQIY6s?=
 =?us-ascii?Q?yvs7/e1kuAviiuvDSFkI89aG2x4x0B7qz6bcYlIe5pnGpA/RLQZTt57gycCy?=
 =?us-ascii?Q?U1/GKHrM4+iDW7tNhDzB9DvYsL4fTQNiv71vMUFEfT2+T0BaEQYGi7p6VRzd?=
 =?us-ascii?Q?7iBfwfd6/iEhwYYgSxm49THkjKoAyut400NfIbNO6K9dB8KzYqW/5vSpIIyX?=
 =?us-ascii?Q?WqxGkGLnSsKRDGU+TnjKzIEq31bqOoiedTcOKNBI1Rm6tvKkELXcEbFoyZNf?=
 =?us-ascii?Q?g1QPVwKUgQBbUfGyG71/Obo5fu7eU0NlRnE2OVkHfwCPJN0Zr0Y6wQSxOKkt?=
 =?us-ascii?Q?oW0URg0VGHgUFmyXiLKgKnErsfAzvuHGZza1pSH/djbGMjl8C5X7wo/xYRrK?=
 =?us-ascii?Q?Tc2gYFoYPkxh4I7t4ezy8QD7pNJXANl9qrvo3cNQdwhNQcjfrAsGG4yikSwx?=
 =?us-ascii?Q?nFUAsTCmUKdIiao61PEiPSHHdw2Mjwggexw47Nr7t4EXf9JQHrI/BPQbo5+B?=
 =?us-ascii?Q?C8wZNdgyj5vr/bhHHTJIqoUZpHJW15ipekwIMyPf0o8GyV63hYoLUm43k5tP?=
 =?us-ascii?Q?P0HGANKinh3oQYqZk3n2Qr35kEPo4bhZxLzLZJLhsTYiqwf9M9dgbMz59VpH?=
 =?us-ascii?Q?/yFadKpX9ksdTpyEwHiAEBhYzYZ1+ZwiZMLyI8wPyXXoV6VN8KUJkeDY3pRq?=
 =?us-ascii?Q?724fjQvtKjrYGYcGgXLwZp3WAWg6tFxRUFVD4e/3TLmId3Wvp02MrnGoawiy?=
 =?us-ascii?Q?njxXKn3qU+NusIUx+n0Vjx+KlOJ5eCtivPtZZ4XAuLOGTmDHhxDGTXkFUg1A?=
 =?us-ascii?Q?6Z//79JQPedQ2UzDENAJt9VcfV+VHkVpowiq624PE/YGGckR89EEj6kjzytG?=
 =?us-ascii?Q?2OJx1Yr8skcUdeiGNQSSmXGY9q0d6KGzyOZ6fVx7XouhYK9BKv2yHXh0Xkg1?=
 =?us-ascii?Q?cZGaFNOj9IA7cj01tYNvfU060ps2NBrCVV7VgsTleslZsvmNZWGqDYJqr81t?=
 =?us-ascii?Q?rGUwrgIizTKlNIRwAK19ragzj8IwKSpeseI1IuS3k+JzVkZ4AG5LgDZnascz?=
 =?us-ascii?Q?hXe8DaWzNlJX1BAgdGrDnixcURgS8wYYCm8hmSuBD+fzh2hLdXGG0u+Ohioi?=
 =?us-ascii?Q?HM/E1TIj9P7+cFSsHAmbqv7+gVNwoHEDLDnPnHui8Yqw6G5fJVtDn9zhBMTr?=
 =?us-ascii?Q?dBaiLZzHOJTvlGf+/ZsWGEM9zNa+9wFeHkP+RTgLcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?suFVIdtxgiQBaBogRHyxZrK2N9oHvZoSje8Cjcuax10gOs6EzZAx3DUIIE+o?=
 =?us-ascii?Q?qbmb8JHMAosBIpVQxlS9fF7TPVF2KlfBA1uph5cFZIIXRhebKtd86F40gJnD?=
 =?us-ascii?Q?1V8dSJww7p2OUbpLFztEA8F0A4Tc4iHmLo5f+cCHt7sqaFUkCDPm7/FZt1mm?=
 =?us-ascii?Q?ZsFZ2cXqCnaMwmIPRV5zafCYkKJEqbwg56Z9UEewNc7ebRfEG4emlP2fnOhk?=
 =?us-ascii?Q?WWFb2lbQ7IrwYdsQI36oBQQaKnoRBpGg32gl1uUisY3lkiBo3oygveOD1fts?=
 =?us-ascii?Q?7s4fqLWx7E4IhRaFzKOfEF7VWgYBGoLwP6dkl1XAemFcJCxquy+zOsdqNDaz?=
 =?us-ascii?Q?tJATr8EQmNT6NDWO1WEADiqYdSvqJxE2ImTtFjHZsxNQ9G+yHAbt5iFNUv0i?=
 =?us-ascii?Q?SAZKKZBfCL9vSeHdlNB/vYE0XkZknObR+XsSeFNft7dSappPSuliFDfrJawI?=
 =?us-ascii?Q?K+eDH6UPVjgKJG7b9Hq8lnuFzQNPh6i99bAqVwwvZ5PQ0AvVYmQFT4ixr8b+?=
 =?us-ascii?Q?gk+oSfX9l7zeGob7cDoT4ehgq2lT2qe/sQrF9+CMdi7ck6HVEKy6Jloucw0c?=
 =?us-ascii?Q?qc00t/9mrJjK2OEFe2wXE7XWzNkRTebhWTcidzx4PN3iajJlNf9Dcwb2cdEX?=
 =?us-ascii?Q?u5+MtOkfzlHu1167IX+zqt7dpmKwVIZTCj2KiflAjeANpNym/DjSTDfKd5+0?=
 =?us-ascii?Q?0abZlnpnYHIvxx5ACiTTQ03ufxDqx6fTyqgEwEdCKFa+USr4hOuSjVWt4pBE?=
 =?us-ascii?Q?n3YRQM4JxeqKRNCZ0FtAMVAkgqF25D5YQOqvDIPGHfOXe6qbYzJUuIyGi3GJ?=
 =?us-ascii?Q?xto0XGHSlZ6OzwBpJNG86K3XvaQS63krDs64pZcWQsOyOJvNUyyxjuYsXijp?=
 =?us-ascii?Q?zaZ93qURGzPbgHO5tqNs4E7PGCtSBu6wSDuGSnqljiZpalA/rDsFKdUq9EQk?=
 =?us-ascii?Q?OK6c3cuzFiIKGPKkJx5uzcnXHpOl2Spq6ypXDLsVUzBpehCj8W9kKuzwz8b9?=
 =?us-ascii?Q?Kh2icf1nkEucp9f30xQRTOUnMkvL5pXywSntTIXxqLqqS2GL7vj2rAmL9Jy8?=
 =?us-ascii?Q?i8HJgyAhWnWky72rsnBupoF5Ceqm+H0JdcdeZh6russlcSNhi0w62koFxnrB?=
 =?us-ascii?Q?IArKpOwpuQTZfLpwISnjLYC9GD1hNUskwCzcChzOMCFXsoOo98nKY/GS7b7L?=
 =?us-ascii?Q?nYKsxJnfOMd4HveLcG5+0fTNrVsnduSXh0s61GGNpzyESzaY8B9yt7s4Qdjw?=
 =?us-ascii?Q?/rgZ0rwHb+MPITvzq52scnqBIalV3iuWPxiCbg7B60ZgYuUBQyRl1/1THydo?=
 =?us-ascii?Q?5fFjsZg1ayhOtG4SJQk+Z4F3JLWdPqaIC3WSdDb6RI//wl53Q6XOm5sO153H?=
 =?us-ascii?Q?XExS4vtEFuwVUYUf90xJfjw3zx9ZLV5iCcZWNf6Qz1826IMaae9sZgJoRUlM?=
 =?us-ascii?Q?ADYMByf4zNi25VAGQXnb69+dfRYaKBGdcm9vg2v9Cb0FEN/9fizH7qqYQGiu?=
 =?us-ascii?Q?YdHhtUtk3yYLGdXoq84WCxzFJKzEhj8mTS1P93/QS3sevhyv5wCX87XpU+3m?=
 =?us-ascii?Q?fn1Z4BQYYjwK6F/d1taLNHgCSx+aMqnyVqprhvI5J3RpwCh8s+6le+CVgrgY?=
 =?us-ascii?Q?sQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2ea18f-a77e-4a89-7ce3-08dc70f60275
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:35:08.6277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8Mr5jL4BetveG5kJOu8VE8hGnl6G7PtMOPB1RCU0kq8mg4sXoycESiP6rfOTzCtqCWoUe7yLjWo5X3UVlLoIMuWHVSv6FHyIrdli3vjEkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9192

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

Andrei Istodorescu (2):
  shared/bap: Update stream management to avoid PACs
  bap: Create transports for matching BISes

 profiles/audio/bap.c | 323 ++++++++++++++++++++++++++++++-------------
 src/shared/bap.c     | 290 ++++++++++++++++++--------------------
 src/shared/bap.h     |   6 +-
 3 files changed, 363 insertions(+), 256 deletions(-)

-- 
2.40.1

