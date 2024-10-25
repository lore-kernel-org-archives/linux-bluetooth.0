Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4BA202F9D
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858966; cv=fail; b=iPnmJICVsmswmmt22Xr5+QZgZiOfH/x36Rsc0rGNr02kL9rwx833gm00pJwbaVv6g+TIEYER/apHP+rkF3rRISZugNGoPFQh0TNZkZJ/DM1dne2UEGh6ueLo8tWQK/Frc/KABSEyer1ETISmZhj7W6t2RjXvpghrjWjx0nhCtgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858966; c=relaxed/simple;
	bh=A0KlTM+60pSi/BKDq4BjaLDPFP2MgJPBvuFCET9441Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=myzaYtDmspVjuMEC7nE5t1Qrnsjr9rktGRDg2tsf3MUvrq/kzMTwEmpXf+RXdPNroxpZeNcmQECw+CJZCHI4RPF7tDRrkdoaeOIlnaLEH7cy1Kd+Jlowrnj/4S4kRwLL2hHi6+bLBp1SkzhrAIpGJYke0355P4vZKhB8kWamDng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lW0Mibz2; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lW0Mibz2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVetc+7tQFnxWuGBRGUkP0xJzO3HEI1vKlo5fi/jkUloPF4KbeFvEabRoRHKR5ugdqac7ueFIXkDmFt4lvBxhZqN/ZVlUBltgxL+9LSwmLcoRp+RFvdNKDO07+Da3uAAf+ABRFnnP3mLD+hO84Pj7dYTq4mKmZ7h9s43XvTuk6Wuqe/OFFYWhfAKiaD7nk4r4G1wilKPToAuFpdj9i+0RRXjaPKWLleMg/BHNy2t34EUmgd9R0BwyQSWVLecHQIGfrdCUWa4utooKohHNyKK+beilsNrICXomuxJO30gvd+siZNurlkh705Yl31tMa0aMzUdBh+pqI0vdNakOjvdtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjqyURUXzN1ULLwz0SXvnnDaimcQuKYmFBvTLDq0ePM=;
 b=tubO9Q1kPc+ri3QokMaB1yyJXXNg0naWtyxgyu/c5e1mNhjkCZ9CxMNWLsvOXzyS/rpPUm8zqM/mO9Sc2vi0ZIJV7aqRN+YNm0T7AGTayKA7NLUDCGxeiceNQaGoOfiSruRJ+UdOaicbC4bfEzDiBcWBBSnF/GIYC19S7ydBnVgdznBtyvjIqrJLVrRbb+IiH2FrZiUYo/pzDuBibD79+JZ4Oa95dRNvNBtpguvKCbj5kz0TAKNAV9sAsL0u1L/x0IVBbRdQnwEVQrCpmXtvhdpY3XtfRk4KtVfZZy9T6DP4u8eN69z6iRBeyb7ezwNOhtSj+32ZckU6GqT35BmxMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjqyURUXzN1ULLwz0SXvnnDaimcQuKYmFBvTLDq0ePM=;
 b=lW0Mibz29sZHAsQ6YGBI73PQr0krRHslGLGc+7LVW2YXHaUrbvV5LxiSkUPeDtiyBbD62mZSRVoWK+8tFS04YYBnE5KsEINifWurt4zeabE+U4Odjsv2M6Eew1hTWHpXpgWqRDcMxTbJG7XpKPaSsqHerWcFgO7SzZfo9ZuOYFO35+z3pNvSghmY6e2i5DlxNTy94/yHtUtTnG6NZqc8AZxkN8o+l1KEfCB5/wj3ewWV9LJr90cJru8iwOCHOaI6GAkMq/++5arz0yN6d0lNA1TI6rLz/owvDBxyNZVVZCHRHrV7HeE5nKyFq9FfH9h/8sE0/W/pVweT9mbIAlGaVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:36 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:36 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 13/14] client/player: Add support to select multiple transports
Date: Fri, 25 Oct 2024 15:21:45 +0300
Message-ID: <20241025122146.17925-14-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
References: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: dd15d039-96f3-4d68-e962-08dcf4efb5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HYlqbBNlBIRo6I/rh4NpyuzTBmfPzM3BaajS9hJMDNQQlYZ8KFhIIpfyySls?=
 =?us-ascii?Q?taQNlLxiQ3PHR/1qgHyjpA8e0r7mHqH/lUxRlwp4ASbHKB9ZtYvr14deS6Of?=
 =?us-ascii?Q?1+iL359Tn99M9/DR0xS4PzJNaE6YlZsBs5VbwJXTV6rKt40uoajErJExXkfD?=
 =?us-ascii?Q?ZAV7Cf9YX5rjOe7r+HfXUIdeiRbsN76xiqKh5lnP3QtGgxM/yOxiEOqUvVvo?=
 =?us-ascii?Q?TiNOct8FydBSttZqq3VY9fEhnQXWRf2+F/gShlN+X5UpHKUJsA88rHomIuQ0?=
 =?us-ascii?Q?vN6SQFh0/20TDfu0S9f+XcXNHlhS6+5Grq1yY0T0GTubU9d857EZo5FfPvWW?=
 =?us-ascii?Q?kwDfmopMsJ45OaPOSypljPGtM6/bujvVPT+2nVt8vnJIb06FydZVA7NfvAUC?=
 =?us-ascii?Q?huH/SuK+Wrfcm1C/7PmCfC69ni/dAwlAex3plMUHL1hzhXpzQ6BQQqFTpOhm?=
 =?us-ascii?Q?VOvH3+fbLqBwKi32eCv/z0TFas3jSCgZr+TAgVK/wr9vDC7B8g94xJLkdOfB?=
 =?us-ascii?Q?8DxcJDkdqsmYW4wGs9+dw2TBA0WwGueW403OIz+Gx0Zw/kHk4g469sW4njU6?=
 =?us-ascii?Q?AwktbRoltgBzA7wIbA6/bnJXl6QvUUpJBQIaW6NMhAK3gSJDOfB8ESaBjymI?=
 =?us-ascii?Q?eCDJFUOWAd4VmQL/NyI1tGxhtMZJg1avkMKGd6jEJdhztUwdRBdbaoCjBRk9?=
 =?us-ascii?Q?SPAz5aAu5xG4ZuK0obBKvnllhsgsG1TV0e0Upu5iwITr5uIbhTAXGnzFrReC?=
 =?us-ascii?Q?vjpXAxuvs2DybO7uAu3KctvGgq9AyCLKCOccDOSUP2NMIahjn7Mde8rGi4il?=
 =?us-ascii?Q?yLsTaKyfI2DWrHJsi2NU9M2SR4pnBNa0HB/UcQrh0Slm+RfsT4VuLzttFSp6?=
 =?us-ascii?Q?oMHULNqO4Mp39t9DvHeyuef59jbCc6XINuC4Age//pYFxAAWOzzcqtBSQOKR?=
 =?us-ascii?Q?X9HV3QXGNqS9aPRTW5/WpGZe1bQwGEQAzgv9sOH3g1wLAXIoJT8WCqDWn3F6?=
 =?us-ascii?Q?SJcwrEcCz/u2BLqIEeAXATdeKufSrNJWOSaB+Wmw1h/t55YwCIL6IgRrQMtM?=
 =?us-ascii?Q?ZH7BuRAkdSSTq/EbKNzO5rykg2T6JL3tZvKlpD9pLfp4gnlg4gySXBPTKF/e?=
 =?us-ascii?Q?AT7ODehf4qApQKB+zCjO9jYL+lAADq2/NxjLOtLaTStE5xXcch3N3ToFHF2W?=
 =?us-ascii?Q?KIueqJr5mSGMN86P7e0RY+Rz36+BX2A8jKzB1tMjhI87hZtCoT0Z8JBdW0eu?=
 =?us-ascii?Q?+QHLEZX5Sk0IVZe6qwFsv17KD20aXfS4G6RMPS3e/8jg+dcrJJ07C7ftuKiO?=
 =?us-ascii?Q?XiFgQQo87pgE+7PMIqzB8eJJ4t573T3aAsH3v6tQb4W3jXFaOCqbQDse8o3w?=
 =?us-ascii?Q?rsiDL8A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NXGZ1w2BQX7uEcyfTN0JYVKUqBW+KL8tovwlalJhwU3mguc3e996RyXMwqIK?=
 =?us-ascii?Q?L6Djl2LINvE4zHyvHlL4ZlQwF/yp0yvkj6eyNd+pAY41sNfCBj2VDa872ADz?=
 =?us-ascii?Q?lDj0YP/iXTX83uwF0gM+15lsi8t5SOtJYarKmLLhadn1tzjQbrk04lMEHT+r?=
 =?us-ascii?Q?e+4tSHxgTC2mQmOgTs/jqD7P4P1bEI3AqQlil6NWSSCVXqa5USDKJ8s350wL?=
 =?us-ascii?Q?hq1cSmR7EiyAveh464FAhkjroUdY1GplYtjl4FCn75BE9da3r9DGoTWx71L2?=
 =?us-ascii?Q?Hf77JAVYdm13BMDWG6caO4dhWXZUqVngueUyPwHzGvIT6UUY9tt24usgKaNK?=
 =?us-ascii?Q?UY+3e0lYD4Ssy1gx7NgqQd91KVAlxvIcfkWTnAGmswRq6YEUacMbdb4+4xJ6?=
 =?us-ascii?Q?6+tG5Yoo2ouRWhnbNMUnMnco2phg3Lyt+wRfva/VgEPbSepPK3fqS5AFVgVR?=
 =?us-ascii?Q?5BPxFR9lHDCJD3EUfo/VLPdLDqpLNvCYsX2xvWCUtLgN1oK/ay6/QHsH3o8h?=
 =?us-ascii?Q?u1oSOyz5HowLb7mdi6SUs8H2dVcBHAYx2Dmz/pamCySiw7ZioqzPo/AydojH?=
 =?us-ascii?Q?WwA26uPHIgwrRQ7qCQGO4BIYwEbzNcU6iDWOZ2OncketBop+hy1MLtwtE8y7?=
 =?us-ascii?Q?h5c3Li4BCSJfCty006hZP40w/ImxM28mZltSD6AHl5SJQ8+wzSNQW/i3+iX5?=
 =?us-ascii?Q?v+IttdAgL9FL7EtJ+T2zo9kMrBPxjrynuVr0lIGgfcSiqaWm+rIibLgMysrN?=
 =?us-ascii?Q?izmeD/9XmghPbhejOdROsqs8SFke/5O6N9E4kkC0ReTsX65m3vDPHdkMJBy+?=
 =?us-ascii?Q?kleNGnAc+f/d4FJJrhDd+1rxypZhspoTrDDyGMmRBkdxxmD7nwFqMIgRmH96?=
 =?us-ascii?Q?+drHki5ZiAOx1xx6CtWyG5caOULkHiUCzADFzyy/CkJ0wmRWkMxt4g89405f?=
 =?us-ascii?Q?7jGlCQCO4vRIn1sjflAAd9VC6/wUS8R+silphns/3XRTtg51uvYSm83OHsUy?=
 =?us-ascii?Q?9LaR1yr39/MPgn6PLQJ4qN9sysywNCetTFFZiElooJ7oUvdZjcDqPzWbiNtk?=
 =?us-ascii?Q?pKJiSMx5UyEeqfTYocz5mdUwvS82ouZvmB7mXqzCFqlOlBl6Ud/JugS2Um32?=
 =?us-ascii?Q?bSMcSvS3jCao59DyPbk67ZqM1Y06ziPcmmXO8Wxxs6HuljRgsW22eY3UCRaj?=
 =?us-ascii?Q?veN328nf+PwqWiHXqF8tTYcdAMRwiOfCg579IsUplSqq0t+ZMTxSxHjaRqPO?=
 =?us-ascii?Q?XgaP9etrNLUT0g+J0wW7278kh6p1re2unWZZHXmQrjekFa6/TQc9ZiIPxk6y?=
 =?us-ascii?Q?6Mz1qa+yLF/aC5a7Mn1ZX5XvjK6lqFcWALT02i04vwS0T/fDpomNBNgYnP5n?=
 =?us-ascii?Q?w15t00iZ9AA3KPt7L2dMjVMqwcznzJeJK+eVPuaokyXoXMulLZsxza7ppDtC?=
 =?us-ascii?Q?b0BtEuTayGahSfMmoucWxu+xXyIUzXPYb1I4NzbkY6Qb5E9ICYpLRidhftPS?=
 =?us-ascii?Q?/lZKZje5uYfwvK0FzK+rUBo3qk2U0hEOwAEAGP+aUl6WWgCpEXQimNtgZNuE?=
 =?us-ascii?Q?6gLm+L3atseBu/g3GwKqKCp/dnfKO/BYupkzBp1j5gL7/+MJXoU/8EvvZ0r9?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd15d039-96f3-4d68-e962-08dcf4efb5a9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:36.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rd6ftjgtReq4GIpuq2A6ZM0pT9BG2HdHcqy/IQAbSGbi+3i5tvlfFy2Q2cEwYShmtJjCyaCiCQ2wlK0qSVcTQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

This updates transport select to link transports together before calling
the "Select" method for each of them.

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
---
 client/player.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/client/player.c b/client/player.c
index 81d967a28..66a26ef40 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5173,8 +5173,9 @@ static void set_bcode(const char *input, void *user_data)
 	g_free(bcode);
 }
 
-static void transport_select(GDBusProxy *proxy, bool prompt)
+static void transport_select(void *data, void *user_data)
 {
+	GDBusProxy *proxy = data;
 	DBusMessageIter iter, array, entry, value;
 	unsigned char encryption;
 	const char *key;
@@ -5220,28 +5221,62 @@ static void transport_unselect(GDBusProxy *proxy, bool prompt)
 	}
 }
 
+static void set_links_cb(const DBusError *error, void *user_data)
+{
+	GDBusProxy *link = user_data;
+
+	if (dbus_error_is_set(error)) {
+		bt_shell_printf("Failed to set link %s: %s\n",
+						g_dbus_proxy_get_path(link),
+						error->name);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Successfully linked transport %s\n",
+						g_dbus_proxy_get_path(link));
+}
 
 static void cmd_select_transport(int argc, char *argv[])
 {
-	GDBusProxy *proxy;
+	GDBusProxy *proxy = NULL, *link;
+	struct queue *links = queue_new();
+	const char *path;
 	int i;
 
 	for (i = 1; i < argc; i++) {
-		proxy = g_dbus_proxy_lookup(transports, NULL, argv[i],
+		link = g_dbus_proxy_lookup(transports, NULL, argv[i],
 					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
-		if (!proxy) {
+		if (!link) {
 			bt_shell_printf("Transport %s not found\n", argv[i]);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
-		if (find_transport(proxy)) {
+		if (find_transport(link)) {
 			bt_shell_printf("Transport %s already acquired\n",
 					argv[i]);
 			return bt_shell_noninteractive_quit(EXIT_FAILURE);
 		}
 
-		transport_select(proxy, false);
+		queue_push_tail(links, link);
+
+		if (!proxy) {
+			proxy = link;
+			continue;
+		}
+
+		path = g_dbus_proxy_get_path(link);
+
+		if (g_dbus_proxy_set_property_array(proxy, "Links",
+					DBUS_TYPE_OBJECT_PATH,
+					&path, 1, set_links_cb,
+					link, NULL) == FALSE) {
+			bt_shell_printf("Linking transport %s failed\n",
+								argv[i]);
+			return bt_shell_noninteractive_quit(EXIT_FAILURE);
+		}
 	}
+
+	queue_foreach(links, transport_select, NULL);
 }
 
 static void cmd_unselect_transport(int argc, char *argv[])
-- 
2.43.0

