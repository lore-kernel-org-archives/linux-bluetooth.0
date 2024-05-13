Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9623A14D29E
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601023; cv=fail; b=IgEgZa7uOeYt0smGGEc80s/WD8GibukhM7gCI14/yFP9qlL9mtWlxtDw79HWpNxXLtvxuXjPOZRgE+IhFQTH6ILsylVK/k3SaRvaIKdDNjpuxPHiKOcPZd/GBV1Gn0qPtXyv+VsD/kS26cmeUjqIBoA6hbgGg+ZPy5Raq1er8RY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601023; c=relaxed/simple;
	bh=3cZGyr2Cf5p/GY9rtel0bEpuerfeFdvnS83w0+hJcgg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SdkASXgbcb2u6bBkY1+XS40PfRWsSLKWtzcEEWcsWEl7VcRJLlLTaVEbEcIpVe63QCvYGhCyGpg7MeCo7083CxvDmoDzb/Y83sSqrgGVRdIe2egX2yMbYrCbQoEUFDavUKBcn/mE5osKCSwiRsBka9PhA4eR7C79pn+qQ7am7x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NmitfM/v; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NmitfM/v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc8YSf7SUnLR1lpsIKN/WBl1cu53Mo54HLerOFPgbET7ku3QhEJg9IeBTjoRD64Anh0XtN8oHzHbym0sl0uvO6gU0Xem8N9Wb87qVis+CC8H3Hk8ANzQQdbPHs//ExYN9QQX/NS/D415WCWwfkUdLJ9sNm37sJRs+ae9t0NOHbqKVi1vObkNKXj27n54oPPwMvua+c0anMWBladAs/Sb6Q58kg/wQ+L7kMey9z91uuPxHd+ewPh7TA8UJJYPTTeVYjRQqGrhxxgqh0e6aWc2dnvoisz0nT6m1EZOiC1k/COYqJKm2G0+HmMzbcmreS6z+ZRanxzXl29+PNPox9FEAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6egZSAGslvfUwNnG5MrH2rCjmL6QZmS3jSUBjUYE2Gk=;
 b=lHxYQT2KUFLPL5PTgoBQfoNj+WXzsEaBcL6t4laBnFSe4dWn/NmAA/UuEkKi1j9R3/+qivd2D2yT00szu8heND5CGVMVJdoPsV3J6DC8DAR2Bg7kObz9LEw/8kiihQvJc6082EtIveT1Dwe6iMbUypsfR8h9cElzHMkgx2LQD12j/+FhjZPQBzltMTPDXMzsIyt+hXz3631jklCbNUomKBwY7SjpTcqt/5chl1BYf2Pcz/jw8ZnqmsZVx4EnYcm8e0c2K5IK3YSTHeVnAPkBe5NuaZlUL4ajU8lrWvZDtAC2UVhXQaK6teTLj4K9T82P3s6kwdSmyRDw0nLdQb+38g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6egZSAGslvfUwNnG5MrH2rCjmL6QZmS3jSUBjUYE2Gk=;
 b=NmitfM/vROQq1RYF7GAexGsEcdv0kjdvf49b0nN+Ehms8jtlkDQjT55DDobtbJQBlSRLg94xQTR3ZpKF6fh5ljBinwmOqvTGZygcR0qcuaQdxInLsB5EH5f2MxptVhzR2tyAno1j0dpNKn8yd4XqaboIepcGzCfijt5Y/toU7bw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DB9PR04MB8430.eurprd04.prod.outlook.com (2603:10a6:10:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 11:50:18 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 11:50:18 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v3 0/2] Create transports for matching BISes
Date: Mon, 13 May 2024 14:50:12 +0300
Message-Id: <20240513115014.36484-1-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0100.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::41) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DB9PR04MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: a43cbf91-0a7b-4c2e-7745-08dc7342dc8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ns21zgombT6m7ESY8/TSdVhcPfb67AqtLDyah/DWz5LgXhp4cc4/s2S9pmg5?=
 =?us-ascii?Q?0noEiahKdlYkU98/qayPB6C+imRpGeZWny+c6gNMSl7/wSdGC6YGRiQD2qwt?=
 =?us-ascii?Q?dswSTESLrkJvroXdjbe1zoDQQ3T/piUhZYIWUSitBIue2YmYkJlFCe3cBzw6?=
 =?us-ascii?Q?11nOdl9ytHhe2kFdBQg8iZOSRPQi2OOYW8zP5pHCUWRNLldchq9niSsaqyxU?=
 =?us-ascii?Q?h9cOx5rUTG6O6uH2dIZYIgWSr4E0DZ3A5ANfNiAegUnTaJ/twSFJZKysX6L/?=
 =?us-ascii?Q?WNNew205Ua70l++nuOsC1tsKl28eO86dEi/t57pHGSFfFLMhfQxEO6OrGP25?=
 =?us-ascii?Q?0CymrCvbls3IhI7do2igdlWYtOn9q5WdrchlRFCQpn57wjK3h+KCUz3mMcz1?=
 =?us-ascii?Q?5Un5gH8nBp1Vdak+xtmfT8A1DmNISKO0nJrjHFZn8WGz/YhmD0+JkAm/EbBl?=
 =?us-ascii?Q?U5cKgr4WJR20I83H4rgFhMnG5oCrnK1Wr9n+89wiOv1lxVAhWYYIkKIRYaT3?=
 =?us-ascii?Q?DAVKxGxM7zz9lmBkzEl7/lQpa5MnIBz///yR17LZ+RVH41CqCAi/Ba3ZIQ9y?=
 =?us-ascii?Q?9U3vuA85SRSCnxVz/il/hI0OmUNGn/cl7o9GumeI65/WvmEzViGiqNDOgkol?=
 =?us-ascii?Q?VWUwn/iv++7C93x7kIL4PRU1OfW7uPZcPTuPaxLMhqAPdazULioVQ4/zRfac?=
 =?us-ascii?Q?MsxXWYnWtno7mdPM8CHhqRzdIeQB8iHtpSFUHDz1sJaybuYm+sNQuo1pwwix?=
 =?us-ascii?Q?t9MmHZ1L5Oc79mGrEfU3mNncJ57WCzkY6B7MNbM+7VzjF61cUkhzdxWc87Js?=
 =?us-ascii?Q?/e8EukgiF9324CGxCuiPc2bACWimZE456RTs27I6vB/rwyyqX6Tredr10Xip?=
 =?us-ascii?Q?MsusTEjRtPI+rOkLzbXsSrnhL/pwrnDJzOd8XNTctehzWbWsTO/VqC7NhStL?=
 =?us-ascii?Q?WDxiF798UuRBj6tfg6/lXWSQQ/xEFANTqRgKDHcE8tvcmLyzJTUt+ThN6ojM?=
 =?us-ascii?Q?feY1GbixzTplSNosmjj9qp0BjpHiEaEWGjYMuHsqWkXoGTglhd3XYwbx6S2E?=
 =?us-ascii?Q?NW2DmxeZ6BDRvFpgZX7XVLV0NG74SatJ3j22A37Jceqww38t/UtA72KTc6xU?=
 =?us-ascii?Q?dwp1vqYarF0vCCGlKY1xNml4Ce/jhq8XJdvQmk+ZRNF+6OgSLw8S2lWKrd0U?=
 =?us-ascii?Q?saTX/LD+ia/eUA/9/HYPg+fYFDhcEPCHir4FvGd10y7tRSY3csZOpgjFMXLZ?=
 =?us-ascii?Q?jqYpefZrFm16DbFKdImOS8Erxpazg9BYwXmXb1/MFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rBVrN1wp3w6U5/k2iVUfByqba2f+caapYcJhztMOy9wPPC4Ex7shSey1jI8t?=
 =?us-ascii?Q?uf/+MiqZGBr0ZLRhPusiK0mh3wajTZif0nY9BAGQSmDNOYAXkK4xQAwo/GcW?=
 =?us-ascii?Q?LyuA7QZy6L85mcvaa+AqkQXsAWfRLVb+JI6SAr7k8CavvL82UEnjKQG3e2Vn?=
 =?us-ascii?Q?zu3+wqHlhc51xHbxRdbsl1svoRhIDTPl79iyG+6tHyX+gg2YajwambLalK/D?=
 =?us-ascii?Q?6PYgRoFcvF1T7Rm3WIR1blmmUARzDC68tTlCUwH4k3RxWIRu81eBstJDAcvM?=
 =?us-ascii?Q?MMLp2Mrw2wo9CgK2LZyt8vxMVytoKJXfFRn1DATH/enRob1pSzCgCj7TUg7w?=
 =?us-ascii?Q?sKbUTLmOBb4EuQzrXxgtFOM0+v2xwWiMLJFw+1ZVAH0bz/Cw/iKVLoDS0UU9?=
 =?us-ascii?Q?m0A8bfo3ZBChKfue4wN7OnwckK5yIf6/TdGYAJnoXoeCLMw4FIwkqZips+sM?=
 =?us-ascii?Q?rhbSWyQ5kyrywvxoQ5E6zyK/PLRtA+YMZ6F4HdGQysXEC2t/AeHqpSFljBVH?=
 =?us-ascii?Q?cEC1vMY7Hgharx9NNT0m6ZW44qaeB+tT6OOOwNyHce8AvAON4Ty34J+RidWP?=
 =?us-ascii?Q?8vxEMN5UxhfydzxX1H5dIPC23KBVvAvePYssrpLEWadpfRdRcnUgXTreO+gB?=
 =?us-ascii?Q?1quUKkWasRDSZcSQNUpBgs/qJR9WEP0/hTLdTY8mInB3j9cUyCRkwMSwipfc?=
 =?us-ascii?Q?c6I0w+BPtjFJntHuVxIOqOk2uMpuxQsSPYMVxxtAi8IzLuYATwWRkCeAiHLp?=
 =?us-ascii?Q?ggnterJwq+nSlycLrysoUCo310smw4k6Rcvyo/iYvXa46q1ZQxObBlWuu5s3?=
 =?us-ascii?Q?RRIRvrXRTtMRdEMorTsCzJ2UAC4VfW3lmQYZLMroDhUa5c4neJZvyjoq36B7?=
 =?us-ascii?Q?qXE2lNAU8PjPnLRgUxC/rIgp0PnINI7rlUt/7EotwJnEoq+56kiN6HWZEb83?=
 =?us-ascii?Q?ETJCndY4HlEAcrf//7vnc0DAVf7k8hMmWOLsZ1R83rWY0CIBIQt8DRJnDEwp?=
 =?us-ascii?Q?C4wGOMLuE+oDuA0hrTnMDc7NGFMBwEutVhuRDPJbzbNcXDls/9UWgzKWxrYq?=
 =?us-ascii?Q?icUq0M0JLr4Iac5yNczWmAZHNTdk9oUHW86QtwWWaP56UzLyrdz75K8NeOTv?=
 =?us-ascii?Q?HHx5KRUBohCrYkKZzL2JJ2DKzan68rODsE7RaWiZHPjwsqSYNXdmsd1ZHft0?=
 =?us-ascii?Q?QBVtOaEFxXf3j2DXCWQihk1W9opoQv9BpZI6IGmvu9/btg+sc12M+R5aYpYA?=
 =?us-ascii?Q?2SDu0wKXfX1lJmmiw8JKwKnQqfeMvduFeDA0JOB59g+P7wkGM1O/j4d28Iu0?=
 =?us-ascii?Q?/9La6CG+nlz5UA2mq8v4xmNlwAQ32QleNkLPc2OkhfM+KtxqarKzsqIivde2?=
 =?us-ascii?Q?pYuCFVevcP5AGmW78guk75TNZsWsziRXaaZadVtnAe7NW2FVlCNJ5jCKHHtN?=
 =?us-ascii?Q?qeLBC6fd2GLumHjXZJOxMgLiLkoRyivjHe/kWB6BTURJ+kwRRKRexPwtjRze?=
 =?us-ascii?Q?RYps1hgzPh9O1+Pel/eLaK5AR7ocI+RTNknROY7iYc+nN9curSdB0LJTOvZn?=
 =?us-ascii?Q?cnZXNL7PT1gZkb1PA/h9aDe1T3Foei6EmpyQvI4/MFJLTxRPPnhZ/Q2mueag?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a43cbf91-0a7b-4c2e-7745-08dc7342dc8b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 11:50:18.6394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zz/4I/ZN26hXHjPS9Dy+8niS/jWLVarFJHG6dpGiyRUDzX2bAl5rnB0BEoa29+bwP7hrweixpV//9hRINi5bPXgplbhXkknqqJO9JlB2VrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8430

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

The difference from v2 patch is that match_data is not initialized any 
more, to overcome scan-build warning:
warning: Value stored to 'match_data' during its initialization is never
read struct bt_ltv_match match_data = {0}.

Andrei Istodorescu (2):
  shared/bap: Update stream management to avoid PACs
  bap: Create transports for matching BISes

 profiles/audio/bap.c | 323 ++++++++++++++++++++++++++++++-------------
 src/shared/bap.c     | 290 ++++++++++++++++++--------------------
 src/shared/bap.h     |   6 +-
 3 files changed, 363 insertions(+), 256 deletions(-)


base-commit: f4795bf64dbf8778fc765b7dad1b1bfb365b48d7
-- 
2.40.1

