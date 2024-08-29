Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72A1AE856
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935770; cv=fail; b=EOX3sZrNiqt9+smIM9BS0sKjNNQHYPSoaAfo29MdMCNbj1kbVwK+IbBAjONqlOANfj6/OdQQFof038bsoLt7+HMC1Oqn5cCVR7gTAuOTycUw7CGqVQQtXSrV0qfdAgi+vYKP+UE8ocmCH+4kifO4iKGgPe3ngPdJqJGs2iQUHx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935770; c=relaxed/simple;
	bh=E+uGf87c++i09TqSizLli+m+bAXZ6kqrA1tKbi6f0Qw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Wwc0CWpqW8TJHPCpV+J4oX4PIrgS1JUoFo65rbZnpFapSawRvqIhEuA7yhf/wdyxGA9DgNNlvG+deWlxhEYAbSqtA4l2LZfIeULNMXiihE14IHcCIy/4x2pY+y+0lBjk32klbEAQN1o7URY6SaXxmbNOo617fyWtVVL+oUJfSaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LAw0OXrj; arc=fail smtp.client-ip=52.101.69.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LAw0OXrj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBfUg3INY7rGNUIPO1i18Apil1hZiYx415r8mepe3UWIjzbR0yoxtHkUF7yEcq490n9qE6HjAMcRSy9KK02n/D77x4p5uDSHOUk1ljkaz4yl37VKCnAeF0qXkD/2hrfHGqcZXGDkVKxriTnkw5sUc76+FZPc5wYgEZLB/40G8S+jUx0pwzYJHGjYvsEO/Z3oIa78IuBNqlzlRXmzx6q0Ymsulk0eUhABo0soqsza+gY8nK853keopKv2SUKv/3V4d14Azpoeqyb/C0YZG6tWoJAjw8K2gjVqKjCJkmAWmt1GK4L4g/LDmnpcfDuLFzxC2MYTq0REly1cd0vy6EndGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZA7igX96HvCQAe5FzFgPqTZ0e/8xJN1PrMWW4RiIYzo=;
 b=imW7kP+XfiDZg6iYbXvx4VGiZLYYI+pD0Qm2MWCSV82H3Pwnj9agtuj6O43hIpdP05vmEEHoW9jgpOOH85fTbMVlCNr8cIHldHcwjOisUGOfShsd3KnpvVTG1UATSIjn+kPITVu3U4D3O/Tt5HTB1YsUvuOachQWWXtj/ld1nFrAnlFUAk9iYQ7HKRBdptI3XLl6EvSj9nb5D/Mtx/x81FLCzeQMjuFBTmJGOklFu0nu8KwormuB+rSRbIre1Ke0fLdv2PpDsHV+wm4aeiDUvmK9dyuZzmq86FeDvH/U8xROA9IJTR/T1I6LZxk1JMzkdfY+vkO8zT50yOTmlfL5KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZA7igX96HvCQAe5FzFgPqTZ0e/8xJN1PrMWW4RiIYzo=;
 b=LAw0OXrjiWP64oUDFY15eed1u+920eoy4y6YEkPcpi5mXK5WA08NLyaTvR0cjOxKnD9WGUqPuoFE6SCxO8a0O2n+OXzqMVOrfK3vl8DzMS8w561WqAp6vGtj9lsrsycOd9U2zp9rzZ75R6IidyAqgLupqxFnJChbsQa+axf5P3MkEMjHMSKmLePuc4AOSeVIEc+yMFSjFhU1XybIFfqUjrATC1ue5fulCPSVBbbDcSpDqMBJfzCTW2olknTlVQLyHEWbsv3dEiB1H/joDw209ScAI9PBd0qNck+99ifXqWP44WVqDjfouIoNXeHoXUnhFMyNhf8j6ZwvQ9d6H082Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 12:49:25 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:25 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 00/16] Add Scan Delegator support for Add Source op
Date: Thu, 29 Aug 2024 15:49:02 +0300
Message-Id: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0013.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::23) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 514d5cef-b174-49ce-9027-08dcc8290304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vy96HWrX6aeqnOx8VdObZozkcwcBfUflWYv/2KvRP36Fknfcdjg1nz9xTAp+?=
 =?us-ascii?Q?leuTjoy0dBcm29dgXmMtph3m9EkJvwWXoPEzE/Q1LvIGEezv/vJ7QckiYt+3?=
 =?us-ascii?Q?G83O7P2i2aoEAXv4hl6WuZWF3v8Bgfmbsw3fN0BHYfPFZlD7eBkg2SIQjAT5?=
 =?us-ascii?Q?iZmF7h2RfskQ8sAd63pQC1fliQA6+UjU8vC2pARLY62DDme4WJW8Uu9oCxBf?=
 =?us-ascii?Q?MvFJqoIlqkWNgynGBfyzjirVZUU1TvqPi8J/4imkAnL8Dd/hpjO+kzS8y2tZ?=
 =?us-ascii?Q?kIbg+let2rS8vpndEhzry4g97s4L0icIGy0MPuDgEy5lwXnt0IB/sSmasCVW?=
 =?us-ascii?Q?C9289o95fEzLV3QXpuXkIbdDrlB2CKTzAahj+9q3R/+x/IcF0RhDzw8X9EBb?=
 =?us-ascii?Q?rCAogHlDbO6TZoL4ZOQBSGDJEWUVSGMm4TZQLTXX/m6QimYLt9SXRk6nm2OS?=
 =?us-ascii?Q?BD2o73zbx7iSbuST9kgSwWMTYEQzxsH75OR29hcZRqxqpINmcbCpYI9Sw5RQ?=
 =?us-ascii?Q?Y0vrLK4t2dpxoHaklF4tkx7NyYFupZzBpJ4Yv8/Ih52HbUATTTLRa8TLc8xH?=
 =?us-ascii?Q?YfMNP/BMtjTKWzwt5x9kdltW0ApaegzJcDaY9Pk1ZGGhjHW4ta6krSvsdMfI?=
 =?us-ascii?Q?T5PxiLd5KrUqI1edG7YR8EdCI/R4aJLaxvn9tnQgoosP4bd4lc42OXkKSGu7?=
 =?us-ascii?Q?32vd55BMIBdtGZwDibUbi3McNLTHvCfPs9oK/750USxiK0GiqlwRMZDiH1YW?=
 =?us-ascii?Q?4DcCSSvaCJVHlpfU7Byx+YB4QAzLTvsFjvZeNQcv8vCsFgEeTBP2iwSEXFxP?=
 =?us-ascii?Q?XOPvRJAwLIeRfYArl45dVtkliyvGrROouHgh5bjd78Fh4B0bxPtn72D9191g?=
 =?us-ascii?Q?u5wOaozom101DsXfRqim+WsRHh6IvMqhCoPJi+f+0CshaMkuH6cTrDP/P1KM?=
 =?us-ascii?Q?5+OHD3xNEmFgMdsr9GnobxTpnxK/owd1a/4akFCpvT1Lll0gOr8qljT8iePU?=
 =?us-ascii?Q?qqN24WH8FBFtC/zuNLx8UYKWzY6cLssu7uEaAcDDH5SGPrtaX96yNHQlhfT2?=
 =?us-ascii?Q?68hnc3gSkw+5EojaYzUdkdz19wx5fIYGPj4sAIiXv3Rq7DIeWnasyT+ybeTE?=
 =?us-ascii?Q?j3gMIgyjq7cgF6Zywe0gnEHlW4GvB/Pte556onngEHcQGt4xFNBYiZ8gMuuV?=
 =?us-ascii?Q?IakGDmhtIYuS16IePxAD1E5iwZzvzXRxDkNMPzPVmg0ZlRI3iOmsjYM1nx6d?=
 =?us-ascii?Q?zkgY+6dXYjuFNgdZmypovvKJNkBzeZADWTNgCVP/NfpE3t2m6WmOT/zaEpUl?=
 =?us-ascii?Q?7smZpor6dK0QAWW9eOqoP1ASwBuUaKJjuH9bxW3MmQgmng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eVKMGHwEyZcHRI3ZMkzG7QipnuFf5/Y8Ww7xivXO/+JjksTtbQCnnqHc40BC?=
 =?us-ascii?Q?xJYgcl6cJ12rdT330E57Lkw07NU63raPtH2ShLkM3RWB1Ah1W+xViZB7bTHh?=
 =?us-ascii?Q?SM5mtw/26Jrn8zcxcR9Sf58P6c5pfBwVDyr2VlJTcx1Ot58rdZVWasRmeZAO?=
 =?us-ascii?Q?N+e7G3gcWeC3W5YQaCQF5TKBNNJdJ4jq8/aQT3xHzZKoRCq2bpJDOmHL3mW3?=
 =?us-ascii?Q?u89XXkq9qrX+oZUOjTEBRz47VWSsNzdBaBCzpa5BKRSaQmlgWHrqADrb3ZTu?=
 =?us-ascii?Q?+IElD3kN/oT4iMxbFQxsVJN7uZa1dQH7HVG8CfX8Qx1MdCItELICUPw1DT6O?=
 =?us-ascii?Q?UfhJ/CVwcOyq3AbMRY8cWu2l5dSBtUy6DGlWlNiCScJuMyZDdBD1qtuzvEvJ?=
 =?us-ascii?Q?w/N+YK/LHuCwRtnIX7cIgCFyJM5QO7U7HGcfjA94rOHKsdkjCQofQGXR101J?=
 =?us-ascii?Q?3XFWW2jEHY6VCJImkthM1tuHeJbBqDnbV15+gkEaC8OqSLd4tUVccto8j9M7?=
 =?us-ascii?Q?Vhf6Gro2IxiFKnHrJ6LGvcjxMKFpb9RF3fvjJbf5k64dG18aeXEWGNZbv/Sh?=
 =?us-ascii?Q?haV9PnDGKzeNTvbxtpWme8C1uSBTiDK1j7opn5d9mWGSgHIy38XPHOVHeZF2?=
 =?us-ascii?Q?3s+Ig7P0ArLUo2JNwbAfa2nfjXvmogpw/iJsYRv/E5B4UbDzoGyPt9NdQfjx?=
 =?us-ascii?Q?IWHIbpXifqa0igNeE7PVtzy12tOMwr//d0M3Wvuz2Kt2eR97z+ww54bGbAJ8?=
 =?us-ascii?Q?MzdNCS9f+djpoufZYqmFwk4JlmTLgKQbXjy87YxL8AnCkL8lGWYkYY7LN0Fk?=
 =?us-ascii?Q?vSsOVbdXmpSEhwRm4Uac95YeYptFAgbMvyi4aMi52qmIUqGW8e0vazmj+BMt?=
 =?us-ascii?Q?wEuAo6M0XtPdb2rJkyZMZyvno9KjFlsTMIqZoyjVvVxY8PRWvphbdqA9/Y5d?=
 =?us-ascii?Q?84I6PIDXkmE3pUJwdSBf19zv9PPHWsVyyUHxTeJsb0INWQlmmSVkvfTdDsws?=
 =?us-ascii?Q?o6cxPyoOhaoQH8NJFEiHfl7dtcFlPfBP9aEpvPjIPWZDd3ShnaVFWhWefrF+?=
 =?us-ascii?Q?zkJJ4sSWP7Y0xkCGxD+dUScRb6cOpfK2rP8f9eapncrlsIzpTUaC/kHDXB/o?=
 =?us-ascii?Q?iSDUQJQuQGutD3VZ4V7u9urWZpp4pFXHK5eaI/Oin19WJY+fnY9Nicee8ksd?=
 =?us-ascii?Q?kGrCFqgd+X5WKUnsX+jxfjAmTbX/EgbuVTkHfba3g3hfAhcRctKMQkpWuxM0?=
 =?us-ascii?Q?YKGmHxgnBYUDH0VkzX7izqiL6Xl15ciBMFXLExncCO1OKRmIicWundtGzp+C?=
 =?us-ascii?Q?aKQ4VstkC2+X4wCKEiPi9YvJZP0M+S1ogg4hWl2itJmOpb1HaQcOcRlOqcZ3?=
 =?us-ascii?Q?WF6HD/CbBWCRXSB6bA9wTKwcvp5vwzBwaoC17bKJXeAyfyqhMX0IXzAovyaF?=
 =?us-ascii?Q?fWUmoRvs7xNpH2VDZ0ba1Tl/DbBgVXj01J/cQZ6qhEL1ctf6JHn37JYVRFCz?=
 =?us-ascii?Q?opIoIv5Mpq7SFEDK5j2+pvrUrP6HHoFQXNApg71g/t4R/9f2tR0WwXucddAc?=
 =?us-ascii?Q?pYxk9esDqiaQaXNnE7+xo7/JcuQ4s/hy6yBMKcUwaWLlWgfRTJwVpm7B6xvy?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514d5cef-b174-49ce-9027-08dcc8290304
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:25.0384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdfFGsaY25LdFwEUzo4zAPcSpApx1cBiDFHko1dxWgKzOh8VnkWY1//JU1eKdw60yGYrd5a8fmP+uMzBd9Mf7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

This adds support for the BAP Scan Delegator role to handle the
Add Source command received from a Broadcast Assistant.

The Broadcast Assistant informs a Scan Delegator about a Broadcaster
by sending a GATT write command for the BASS Broadcast Audio Scan
Control Point characteristic with the "Add Source" opcode. Using
the parameters received through GATT, the Scan Delegator creates
a device for the Broadcaster and probes it with BAP. The BAP plugin
will then perform long-lived PA sync and it will create streams
for each BIS required by the Assistant. The transports can then be
acquired/released, and the Assistant will be notified about each
change in the state of the streams.

The bluetoothctl and btmon logs below show an example of this scenario:

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
[00-60-37-31-7E-3F]# Endpoint: SetConfiguration
[00-60-37-31-7E-3F]# Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# Properties.Device:
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA
[00-60-37-31-7E-3F]# Auto Accepting...
[00-60-37-31-7E-3F]# transport.select
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 State: broadcasting
[00-60-37-31-7E-3F]# transport.acquire
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
auto acquiring...
Transport /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 acquiring
[00-60-37-31-7E-3F]# Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 acquiring complete
[00-60-37-31-7E-3F]# Acquire successful: fd 8 MTU 40:0
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 State: active
[00-60-37-31-7E-3F]# transport.release
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# Transport fd disconnected
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 State: idle
[00-60-37-31-7E-3F]# Release successful

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
< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Unencrypted (0x00)
        Broadcast Code[16]: 00000000000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 1
        BIS ID: 0x01
> HCI Event: Command Status (0x0f) plen 4
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Success (0x00
> HCI Event: LE Meta Event (0x3e) plen 17
      LE Broadcast Isochronous Group Sync Estabilished (0x1d)
        Status: Success (0x00)
        BIG Handle: 0x00
        Transport Latency: 912 us (0x000390)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 10
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 10
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
        Handle: 10
bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101da5711c0e203001a2d560200010100000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 03:E2:C0:11:57:DA
          Source_Adv_SID: 0
          Broadcast_ID: 0x562d1a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001
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
< HCI Command: LE Broadcast Isochronous Group Terminate Sync (0x08|0x006c)
        BIG Handle: 0x00
> HCI Event: Command Complete (0x0e) plen 5
      LE Broadcast Isochronous Group Terminate Sync (0x08|0x006c) ncmd 1
        Status: Success (0x00)

Iulia Tanasescu (16):
  shared/bass: Register ATT disconnect cb
  shared/bass: Make bt_bcast_src private
  shared/bass: Remove io handling
  shared/bass: Add support to register cp handlers
  shared/bass: Call cp handler for the Add Source cmd
  bap: Add support for long-lived PA sync
  bap: Add API for Scan Delegator probe
  bass: Register cp handler for Add Source cmd
  shared/bass: Add API to set PA sync state
  bass: Add APIs to probe/remove Broadcasters
  bap: Probe Broadcasters with BASS
  shared/bass: Add APIs to set/clear BIS sync bits
  bass: Register BAP state changed cb
  shared/bass: Add API to check BIS required for sync
  bass: Add API to check BIS required for sync
  bap: Create streams for required BISes

 profiles/audio/bap.c  | 124 +++++++--
 profiles/audio/bap.h  |   1 +
 profiles/audio/bass.c | 202 +++++++++++++++
 profiles/audio/bass.h |   5 +
 src/shared/bass.c     | 587 +++++++++++++++++++-----------------------
 src/shared/bass.h     |  43 +---
 6 files changed, 590 insertions(+), 372 deletions(-)


base-commit: 32a0811685c5dd290f1152bef2dfbde3b2848446
-- 
2.39.2

