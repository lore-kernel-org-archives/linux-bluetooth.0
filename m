Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010060.outbound.protection.outlook.com [52.101.69.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA53B1B143D
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935815; cv=fail; b=mEaN/QkslESKW5taQe9A79F3iH+OGaTWKle48wZx+r6UPXZBzDyGvZTYYUEMWMOKQy84+0GfZUybPiatAz+glGDBdSAYLMfVMPwWV2t/NyFNM94/qfT1BFhtWXTdH7x8i8mETq/43RdSfhD15ssb/fUJbpsC9xv8wQs0GOS+yTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935815; c=relaxed/simple;
	bh=yFTlVrtkF7sODqtToEJm5nwDeXSwhWQ8t2zHv92UaR8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kx2C9shOX1qFfaZRiBVYolvlNbtCm8831koDs6IzW5uLia2jsW7AwBnkrkeRHCBsOr1GE6YgAfOc78pOqNAXTFhZRv88G+1gZXP5siurW9kdBb6VRBOwKHDiejqL446IcXRgtwXYSWWvC1gfbi94ZYgpQ4CuCEqmHIo9o8WKJ6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e0hBJaXY; arc=fail smtp.client-ip=52.101.69.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e0hBJaXY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqdeqFbusLED61zbhZJjHPIh6RLA4f7C7yTx/UWM6VZlJAJzacjiRZ2/F+rVMlfhRZp6kbS8A/c3s6rzu1xljvFHvFgqs51nXDo2x9Xk3MEXOeCMgcee7lwj57ECBcoYCoXEvX2uRKejk6B8tUVs56jeZNqHm+n7R1SVyp9UCVeJOXLc/NTEurzDXOARnBbDerULqdw/QMX5QJHuTQSfvOsuEJu7ZAVA4Axpsnq0IPSWnYRLeJSKlgBDOrRTY46FmXENPqudIh/lv1bodexvG/gqzwUp0trmku1tYTPJLBkqStHwohfCl5v86XIOJUMcfS5Wp1FjWDB26WgUSaeexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z9aXSYqpbopLkJfiDw/t1eqe2QY6IMXxltySSnoFTmo=;
 b=hgh+E/DfzTetcUkubPNK0gl6G5JpfA8usp4xhGH03uK8ba8A6ivh7srdvBsdsWM6DjGxPtKpO4OlbKbZoJmM5s1N9XRbQ7olGGpuT0rGABOsh27bqLeb+Pe1htNfS/i/5Nv5eeT6hAVj5KwSu2+YZmqXNaosNLGmgcvYEKG2Tmn2s6JbyYHoOVrpAN6Sk1RN7BuUn6PXqamOOQnIIU9DsU5qa7hSXGd4m258J34F0uxZ5httzhTCkZHeRaJOGJmqkhz0MIYnbyozziHw9fZh0/axF+JYYA1BU82hRzITl3L2N7t+9KO3SvCkO5ZFfzWjDiVyqUs7pxXGPiz2dzyePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z9aXSYqpbopLkJfiDw/t1eqe2QY6IMXxltySSnoFTmo=;
 b=e0hBJaXYC0O0jGhYPfyZSr1EhMDgciO0SbR4hVIC3/sEk2wykaNjdniMISPNbNjpP/5eOeow+8j+oA5o1daFAmANDvJGWeF89FQgllTVgzcMpazelXHMfTRxtqCm9R/SBBw2ruhqGQm5WbBYpg5Y2fgPWAgfcBRJ2HEWQkV29ATEfD3ZjbR74d7djuy1t3+tZcDmQqC/QNV9eQFiie57TOg55ryZBnmPlc8NcgPSy6lTUuzGmONVU+CuHyLmIDPCqbTRsI6Q/5MJLowsVfJVZM8kvuvh9PEQWOlH5iUoMbSkZFTMhrr5obCtNsOETEtcyufZZ0vuqemXQDcuMgouvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7939.eurprd04.prod.outlook.com (2603:10a6:20b:241::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 12:50:11 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:50:11 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 16/16] bap: Create streams for required BISes
Date: Thu, 29 Aug 2024 15:49:18 +0300
Message-Id: <20240829124918.84809-17-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: d0aedeb0-7733-48a5-edb7-08dcc8291ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e29uKiTcCxUYoKVNxvttvF3JJEB5c2zVImURKgKTmtC568InqpLSDCZdaUx2?=
 =?us-ascii?Q?e2Jx+mX/+XjetVt84ye85YXUa1c6RIMQLN2IPpIxe5erIWOdc0jLT+H3SEao?=
 =?us-ascii?Q?MUFRiDnfSJC2x2sPwDhbzD8OHRyQnC/NlaFHn4L3x69XtHBPCWeDmtdHDzGO?=
 =?us-ascii?Q?ge6N1oYX9f7flil1dWjQVi0ily0H2n8YK3ZxbKX1e8ajSTna/EfgBtXJmiad?=
 =?us-ascii?Q?qgvnif+s+ZVdDAXXQqsegXMfDVZtd2wG592pyR7NMFkafuGzmMGtqj17Uduk?=
 =?us-ascii?Q?6umEKG1OdjQFiNGPEDosGI7bPmSxx0esiAUEMRRuTKR6kEFcrZf0Cu8S78Ol?=
 =?us-ascii?Q?2LZsKAmYAnpeMeiwnMtUiW/vRtoGj1S+/b/7liWUZV6n+JVbZ2Vxwydqvjxv?=
 =?us-ascii?Q?HeGwyM9ZBgOYHnbg6+rYg2z1ZnZRBPaAQA6AboIgSII+QmmsL0LKgzzWqL2g?=
 =?us-ascii?Q?tcXhe4iVncf0J4ZBPnmdJTmBFfGXjbioLznnwqs1KHFDdzxPXEicH07mHAtV?=
 =?us-ascii?Q?DMGN4U2/nmMk+R8Qsli4FvmP/3yMCExGLLZ22geEUJYKA4jX2LEbayZ7a2gq?=
 =?us-ascii?Q?T9GpeA+ATQNu6yj7OzeHfx6bf75TuFFbyNYrmvFmxaMEoUGcmdPiVGwHxSek?=
 =?us-ascii?Q?nrypgbaHqEbuL4IGqCPMHjkSbDQj1jr8xb8FGRWDKemFMyNaQipymY4ftRLH?=
 =?us-ascii?Q?YeC3EvB5lgFHI27xro1YFfMX3Ew8aoXG7t1FAMz0M32THLvkhd790AbWwwPi?=
 =?us-ascii?Q?I9Eg+fmY7G0uA8SOjutQ2A4ipYKJtdXwXpm0BDrleyuYcK/eRQaHCG2dorNd?=
 =?us-ascii?Q?iV2EUg7V1huiibg29StD4wrBK7Ph9jo9wJGyMdJAw0M46lbRXKdeAc8AAE7b?=
 =?us-ascii?Q?B2if/4/VYwLNMUHyFcVF/5unoYXa7uTTqP4hVo0gBHFjuxk2Tkcf/QUJfp75?=
 =?us-ascii?Q?wpORaoyZ2erOTGwXrxMC5ZyC/7PGAsh1ug2l45GlGq1gGxwtsFmmth2wirnk?=
 =?us-ascii?Q?4ZVNGrcqYwVaMjBaqw0ZP2IxzrscgbcaE+xGtVFkrumurKaYowsODqY/ioe0?=
 =?us-ascii?Q?lfwzVafkHEY77KQGWZb1LXMrQKhBWgCAB7+Pojp0XQ/Jk/8nFJ5/yBBzWwJx?=
 =?us-ascii?Q?Z0zU+C6K73onqTt794Uro4EvnOgNCiKaaZHKjt2pIog8xAQN4h0ov/JRX6Im?=
 =?us-ascii?Q?37ReBkXftdFr5wE+Md693rFHMm45PO1lW3BwXNVXVwPHIfVWerpPmKaUIH68?=
 =?us-ascii?Q?CFkr5cYCRLrRg7uP22wnblOtdLG1QCxaheo6uMndfM2SB5sg8BJzdrfLsYLS?=
 =?us-ascii?Q?qzQTOfog6LRuMLtGDX7kOfg0XrDIkPhJam5aHiooeyR1Ow=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fb5Kj3lnnVB6pDErva6TjrmuHBoUnv6u4DUAk3Q5oj2Kjomuzut7s+mNsXxq?=
 =?us-ascii?Q?CcRyMa+Evaxbi+mIobIfVuiAESKlrzLUSy0qAG8STUw5HAts2MKwuuC0idq3?=
 =?us-ascii?Q?A5aRIpBm9B6XUMD/UilNlRd6LMULq+n5bYcWqITdPPC3xSX4GWsmzOW65qG7?=
 =?us-ascii?Q?+epl/8GkX4ix9cnL7wQchPjIM/AO267mbQRAhWmwcszCjTSaloy7qhAffFJN?=
 =?us-ascii?Q?veAa8ePpcFVESh/5L1sVcBzJH8cxYdD+TMRRgHujhuJDQdDvXxgZdp9pYLBF?=
 =?us-ascii?Q?CkAY8RmiilKMq1LiMoHaE+b35VXxKTRHh+3YQtOzsCkMTTdWHY5/H9beQz5x?=
 =?us-ascii?Q?QPgNsiMsILaYY+xDyiY4UK0umMm3gkTAIeOCyuCn7jroSP1MK/KSWGVG+xNx?=
 =?us-ascii?Q?IJLJ+jCWWft9gLvWb7I8o7UMMGR9YALEkxhSds/368geGTH4Ev2ivnpWm9DX?=
 =?us-ascii?Q?u94jKb40U9GvovtOjXqt+VLDJCUc4gx+OHr5X4ly0am42ajM2liO93g1/tRI?=
 =?us-ascii?Q?o3oSmFn7L6iystWgRxecH+l4/LYhg7qrh9w82D9z7fbGkCMYkP2x5bHd7Oty?=
 =?us-ascii?Q?x39f2g+k/N12hf/HCEmxplk3Wxln25iUUSkOXllGohA5LYLj+q80GckhWvQw?=
 =?us-ascii?Q?kGaFnQoIp5JpFIfGKfEaA/raQoeg3bPhkYUZNhC47eg5fiwOEz+Zxa4rhY1F?=
 =?us-ascii?Q?LkMCLv2Ufev7PHScWRONuR768OOchQKx7DNU8ezve0oFSTsuI8s86wISH8d8?=
 =?us-ascii?Q?HIQS1CdmHygVuEqwCsE4+zb276Y/Sb0U2BI/2S2UZJB8Sfbqh9Rd0/Him0+5?=
 =?us-ascii?Q?B8XwcNr815yPDZCUXYcByLcttV2Ipsx0xAZxnTbz2/JdVxfuX8RVK9fjW6LS?=
 =?us-ascii?Q?x+IYXucTzTZJ2eFDRzmRcP1jbP5Yvqwc72eRXxfcqyfGqTTpSZcNsS+tBLBS?=
 =?us-ascii?Q?mwA35n8p3awjsDKRwD1eFE6wIlB7OnX/dLSFV/dW6W+Pv0IxOTsRDLmdiNSC?=
 =?us-ascii?Q?lYMxXxs7IPugzBrMNF4yi0eP7tLd2YykuuZykq4uCZB5C/cMPqjFs3Kb4dUV?=
 =?us-ascii?Q?WMr20aXxvdn66TUZuqgyoKZgM95jy36Z8gfaWJe/5aYgdoEPgdAiFL5tLs8g?=
 =?us-ascii?Q?QKnctqflTg9p2caR+Bg0fPwQ5aO74C5dBSpEMxHITq4078RMX8nKTJAf5Z2u?=
 =?us-ascii?Q?/a5NfPPjKQKIYZfAyXqjO3CT0wcPh+fx5k/wR8UdYo77pP+pGLu52kdlNXDX?=
 =?us-ascii?Q?AQF/XOIuxtz2SUk+YjZCClcCpFjlM5OhH25cEvpySchai4k4Xrj1NR6d8+ig?=
 =?us-ascii?Q?rnoQG+DvbZw31MNt8kfH1DpB/3JK2oNj3CXigNTnvLmGCf3yi/QQe2PgACHY?=
 =?us-ascii?Q?C/riiYfcaMbGvQzf0r20/T6Jbk2aqzCKnu2BwWouvE01XLdVGbKHCIeb1joL?=
 =?us-ascii?Q?eMtWrf1No8x9lzedRtEia+he7bvLniCw/yiMgmN/1tB/xuJ14fLwK0/mN4Db?=
 =?us-ascii?Q?WURLFvQ+PqJ1w2YDFQKsHQWEJXpaaTHHalAD/X+W5MfUrEgAAXTdrNrbCdMJ?=
 =?us-ascii?Q?Pfpr+vylmJ2cuJl2plC6YsoaLsZ40FhLT3gNxIBztAfmFvloTikmfIV3wbnu?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0aedeb0-7733-48a5-edb7-08dcc8291ecc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:50:11.8094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gCot6uI0jpvQIAdI4BYXsmwyiQ0dwMSC+E6RAJJf2Epcj6AbNKDZl3JNsjX9CBdI5KRdFgHWK8h0w5VTCOlqxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7939

If a BAP Broadcast Sink is acting as a Scan Delegator and it has performed
long-lived PA sync with a Broadcaster added by a Broadcast Assistant, the
BASE should be parsed and streams need to be created only for BISes
requested by the Assistant.

This adds a BASS check inside parse_base, to filter out BISes that do not
require streams.

The bluetoothctl log below shows a Scan Delegator registering a Broadcast
Sink PAC and connecting to a Broadcast Assistant:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 3
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# advertise on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F

The btmon log shows the Scan Delegator receiving the Add Source command
from a Broadcast Assistant, requesting to sync to BIS index 2 of the
provided Broadcaster. After PA sync, the BASE shows that the Broadcaster
is streaming 2 BISes, both matching the audio capabilities supported by
the Scan Delegator:

> ACL Data RX: Handle 0 flags 0x01 dlen 1
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 02014605638ad50e004dda9b02ffff010200000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 0E:D5:8A:63:05:46
            Source_Adv_SID: 0
            Broadcast_ID: 0x9bda4d
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000002
> HCI Event: LE Meta Event (0x3e) plen 50
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: 127 dbm (0x7f)
        RSSI: -60 dBm (0xc4)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x2a
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 2
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
            Codec Specific Configuration: Sampling Frequency: 16 Khz
                                          (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000001
            Codec Specific Configuration: Location: Front Left
                                          (0x00000001)
              BIS #0:
              Index: 1
              BIS #1:
              Index: 2
              Codec Specific Configuration: #0: len 0x05 type 0x03
              Codec Specific Configuration: Location: 0x00000002
              Codec Specific Configuration: Location: Front Right
                                            (0x00000002)

Only one transport will be created, for BIS index 2, since it was
the only one requested in the Add Source command:

[00-60-37-31-7E-3F]# [NEW] Device 0E:D5:8A:63:05:46 0E-D5-8A-63-05-46
[00-60-37-31-7E-3F]# [NEW] Transport
    /org/bluez/hci0/dev_0E_D5_8A_63_05_46/bis2/fd0
---
 profiles/audio/bap.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 0daaae9fb..8d0be544c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1206,6 +1206,15 @@ static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
 			bass_add_stream(bap_data->device, meta, merged_caps,
 						qos, idx, bis_index);
 
+			if (!bass_check_bis(bap_data->device, bis_index)) {
+				/* If this Broadcast Sink is acting as a Scan
+				 * Delegator, only attempt to create streams
+				 * for the BISes required by the peer Broadcast
+				 * Assistant.
+				 */
+				continue;
+			}
+
 			/* Check if this BIS matches any local PAC */
 			bt_bap_verify_bis(bap_data->bap, bis_index,
 					merged_caps, &matched_lpac);
-- 
2.39.2

