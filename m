Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234521C4A31
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767776; cv=fail; b=kcUXMNylii0KPx0NrqdQATvEXR5Vt0JrR/ueuSX482xKpsJ/ojcB2IbawYrIbvNUS1OU2mK58b2j9SZ598cBa0p8bWXpvgVdETdcWZKyWzP0HorIrZYOWIULcqpUFNJYn8I+lmseiHXdOZzc2ut7+Nkw0yIyOkxkC0O6S1FokP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767776; c=relaxed/simple;
	bh=ohXCDwDQLmrwa0iJWrY/IUma17CelhRDfNBad/yOYWc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OrbSllpoUcDiAisX1zYIHPN4rA5xbuicckvuN4TJ1p4JS0kuHmSZAwHvry6G0EzlYXOXDwCADeZ9hY1t9N0Lj85u1YFg604Fs1JEInogvPvxZvxenp0yBAVOy+N3VvTiOMfNBgCcSKSL/YCGQE4rVkL8yDvA2SG1s3K7jnm594o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=khri/ZqO; arc=fail smtp.client-ip=40.107.249.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="khri/ZqO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJhDQcxLBUaRWlqnkM+xWaH+4EJCeQQlkccZ/HzP6+EWD6YaKLBOOwdxnuZ2YhZ7L2Fm6vFKjN2YIlaJRD30RbrhPMB0iTS2SVn+rcYR3bPf2BDFcjpTUnAhR8LyD+pO9Dvgs/nPfYxNCB/CH1IFtbR1BOvtRSM+KmGbYo842ZSOJ6fwt714XNtvgYafTN09H3FCzTuDUESmYjgbLwYx+lvOEpKeJgttOxFJJ9TSBfBejqDEALe9K9j2nOF1FfykdlmLcXTcR1s3ac9h223YbxAnQ+jLiHKj0jGLVsf2LucGPgW6SwOqsYxPnIgBEJyrcbWKaWCbbBuqL1CrkHTAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8L+QijokxsJ0rneC9i5FjhrWUCIt3ewzrOHBFZVlCy8=;
 b=wKDXD7u2cQ+KQ5C+QhxruzmicrVOY5ln8dDfIMWhQvYVbcWyrHdOkbV6ArBG21eVNik4ZIa21ebl9G0jrxFRuytHOWUHnKl8OBBM71YrfsQzo28yNg88OcX1Be0Q8npBUcA/srPg8Yn8eDIfaENIyV7nWymVVfgRF2jh5vDFLmH31aI8zA8ZIqRyHlqEiv7DvQ6KLAwiq1epHVrcnFg8AaImMuZUhn3NTsnH+RkqUo9T0UrqiW2M+6w2XVSWkuwgkjSQ4Cjmzpl53VZy3GSyJ+D4jS9l9OT+gItEPuqbjHigi9J7G2cnXrF98adqTdm6NRlEYptJzC33yKTWZFFKeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8L+QijokxsJ0rneC9i5FjhrWUCIt3ewzrOHBFZVlCy8=;
 b=khri/ZqOe45tqs5xip48019a0VeucFREFxG1rCMs1X5OtybKcMj3iLZ/LFmqqlL10cJl6cFOdp9bvouw9YKeHH09NNl9hwgyDQD6B2HI/SgzH3IaCc4PA6FIT9FB8jCoW28Zce3Shv7jprscL6sBa2SLZhrG+SsqdzGDRA8+icxdlkSeCR9IOywWvsVsVNjBcFCLnfv9utxVo9tNljfs1K6DlV4jeephTMR3xpwv9kcXaPCjnqrRkxf5rRxFN6d4Nq5LNZ8yVAmHXNySZuaYJxGWmUGm7rUxjRkerZB2Unf09OmxLnStM/FZ36c5+RuIEqPKaiuqz72QVb3t+nOmYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9622.eurprd04.prod.outlook.com (2603:10a6:20b:4cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Thu, 24 Oct
 2024 11:02:50 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:02:50 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 00/14] bap: Add support for Broadcast Sink AC 13
Date: Thu, 24 Oct 2024 14:02:09 +0300
Message-ID: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9622:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d046ca-47c4-4b44-e7e0-08dcf41b6681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4O4TjdmZmWU7Hovn8/Lj+4gVWSVQ2ThXdghAs4/ozfiupfXSHFE9QWk2ZOFg?=
 =?us-ascii?Q?7SM/GmJgPVAVlKkeJdfW8JnMczlrNNJthfwgHyoK6uwQxfZ0PVDvU6Gxwawm?=
 =?us-ascii?Q?MpQCQHC556sdwpnVAHQpoyBO+DWWFr6RoRjRxJwdBa7ubdVt3A6RSDw9BOyr?=
 =?us-ascii?Q?ADq/dJ3joh8BCwkUoWzf8kN2O9xAqG/ATQDtSJbDys676MdV+/duZ/1cm5jl?=
 =?us-ascii?Q?EsWkRANZfPDZCMFVZquAOhlQe47bSVnYtHrQqeMX5qJzObk9eyLw6PoDeRDB?=
 =?us-ascii?Q?k+hXWn0kP86rTxkIJzzT92OpJ5c1BFkqKoqDletOaf19Dl1ofjlnYayPYWkj?=
 =?us-ascii?Q?DaPoNXgZbKUDDJ1bhXuRmxpTjvGX0t6B0Le5MbuFvbuswq0khTT+d/Y3BAz2?=
 =?us-ascii?Q?Yr1t70aL/FNFEUCaQ+ji6h43yNlw5i6FrHAjOsvU70y83nBq6TD9Hen+xSiG?=
 =?us-ascii?Q?gkLxlVCABcgOqCjTMF/k/T608MC74NH89eUWyrkpIWnSczTyu57Jd5QVrsuX?=
 =?us-ascii?Q?aINwNwTOtY02+4I3r7ekmSufpvQCcSKjm9Ke5DPItDMdyI977+5ePa5FNE+M?=
 =?us-ascii?Q?OKYMjNgM7KLIPYOCo5cCTFGezE0015T8nm8rlT8ne+gvJF2RKX0BS3k8qQAC?=
 =?us-ascii?Q?aEU+4h2zsa9I3fbOTZNEhNDDMx4eaeEujKkABX7fy1b5PYMxBcLxMQqg++LB?=
 =?us-ascii?Q?ouk4c4lzUFGtZmzXjPwwueFj82iAOY7kffm4vhDF1ks4FeShw8vGwSJWpCCD?=
 =?us-ascii?Q?KTO8jfk9m8WF6JMgQC3EjftQxpq5qZid74tGPB0VBoG0s6n5kO7zwK7Y/gKf?=
 =?us-ascii?Q?aHcKM9K0G7Qwn/mYASTqed+oljLTxdhl9XbLm0cTzYbfqRMQlvbL06P39hBn?=
 =?us-ascii?Q?0r2KRnUM6suhUUO7ItRCgzkKCyWfA/sjtJfAZOSbf6xqIegTsii8kTVusOW5?=
 =?us-ascii?Q?FnAFtpWaNATNpvA3OMFrx8hYKqkyC9mfKpy8827ekwC3LzId3S/HyOs0EKSC?=
 =?us-ascii?Q?9XEzE2C8dhJFmvE4sSV9V7kj8cXSEaLatXg3yK7OL93OTtqv2xqdFS/OrHqo?=
 =?us-ascii?Q?1osUSdDiX6HN6KVBw2sY+NozWUkEJmkU3kE8LBzFGrnDyAY1GVvGqf6QB8oo?=
 =?us-ascii?Q?GZMLniVj1M4t7oWHap4aMbZ3YvQjVYT59AaqrMkqHtsayBUAYii74zcyomBd?=
 =?us-ascii?Q?ogEa3ddoMh9IKwpSnCMJ2yC3xaAp+OK/409xmRK8zm6pj/eUYeDjGn1s6tyF?=
 =?us-ascii?Q?Upqe3XbvoTvV1RDzs4i7HfJTWvO+Fb9/trUvIY+GAOQ/FaFLYPGN50KH1SHy?=
 =?us-ascii?Q?yaUR2o0jurt3LGJDJHhcqtweCqqyEQRWILY5pa6yQQDzDuXsvJ2o4ZNt0pQQ?=
 =?us-ascii?Q?MjKQSRw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ls0kIsSsX6vuQZUEoQdWeOMlacmpCoe4jVyX5uthMnMgMEX5nkDzKH8/wjlZ?=
 =?us-ascii?Q?y0wlLek3CabdLdD05wrhpPLJQVk3+8B9+oODUwEfjZHnp1NiUHieEWHMHyXE?=
 =?us-ascii?Q?pZv4U6g8p/BSLHMYnqebJvBDuHd1hLAnbXW7ifCtSQaJnAmThHPNyyzApSl2?=
 =?us-ascii?Q?t9SsC6AMdNqOWpvarlYxXox1cPCxm+/5u+mJ8ttk3p8IVCZclzsqomGcuItV?=
 =?us-ascii?Q?PJcvY/aSSI8QglD2pSy/ggdvOBrz9ObIp2HiK4ikunCTDKohFQhBXPJz/Gew?=
 =?us-ascii?Q?6Ek4N8sMPcpnpC0IaJAp6Y3esPyKh8yS4YIyoqiv06HMDC1ikPRjt+h72x2u?=
 =?us-ascii?Q?6DyCpm3hxprYc94pweI8Ej7QXOFmPNbJaSUWtdjo/Gbmh8TkVNP+Kq0wDVec?=
 =?us-ascii?Q?pE+dN7DJwyx/eE3vFHe2vNF96q0Zw4cx4Z3cHXsRfpv6f0GDXZ5WRPhqeNRc?=
 =?us-ascii?Q?vNG+Mnzo5FPuZtogArwxjSAyG3AxRIw1KJXSnwRWgv9vG5Hq0BKd82hT7m6o?=
 =?us-ascii?Q?TMi1epExXbYVTajYu36GfljUxrJa5JP85tvYzt3tWkY6kbA4gHVSVc/SM5yX?=
 =?us-ascii?Q?V3JsS+TrwRBJ07Prn7gEpWx784VrovzWC3IhQYMnX6BidH5d4Ww7gwOH39WR?=
 =?us-ascii?Q?OoT0YNlNOj3mzcug08esQAQNGFG3v+I3Nc6KsIypowyfWNffYZUoR9pmojJb?=
 =?us-ascii?Q?I4vNHw8AbW+VpTcbz6EE0KzrcYDR8S9SYOoPbRwB7j+GJRLbZivclkFgLksI?=
 =?us-ascii?Q?gfT6GrfXNpnoTsPgtHhbSmB+Yslq53LSImwYDdO2ygj9fTJhIusR/TOGjlQa?=
 =?us-ascii?Q?5qGzlsMclLx2DFk/H8n+OOjYJEDkfU/IIY7XPE95qkBNeTKApRzWuxLEacgu?=
 =?us-ascii?Q?v+OcwXod3ByZTQ15vxP8LgxCuVjmgOyzTjfOiqQqjUrrfsG1F2k2kZd/Sehp?=
 =?us-ascii?Q?BP1F0Mv0iDNS1fYWWbn85GB6GF5H9UKyj9hf5hbbbHDG996Ww3tKKGKtg1zz?=
 =?us-ascii?Q?cIMazbO9yJFpI4TTSQg5AEq3vSdJpO54f4PB0PeM6r1c4fISoUVasD9EUAfW?=
 =?us-ascii?Q?NcADsHes/hytWf9RNClqhsK+WA7cQprNtmmI8Er4IwC6iHE0xA+Oyac44Znl?=
 =?us-ascii?Q?GcMzKbGEMI84aPISk5VAaIVCYvoRx5fpZ+q0Z8Ikur78x4fA9oE79kHEgY2e?=
 =?us-ascii?Q?HE+HzVRkYj1nVTOAfH2m9kvJFXX3eSYak5SFP7h87v+zDM5QO6Nm6bUNzC76?=
 =?us-ascii?Q?pXlX/Qq/ANfbdEcC84lyyBby71AgCgTQa/Ptt+gEy1UjfzEYG8oSRT216NrH?=
 =?us-ascii?Q?21topshzJGG7T3zEiu9ajnehn564NMIl+siHQ2uBOU3aUxecG4lmP2NAKjl6?=
 =?us-ascii?Q?f3psKWuR7d5DzCSwlUzY0GxTRzFPk3W1Q0WZKatnsOrHV+odoc0IvKOaGuHP?=
 =?us-ascii?Q?4QtL0oABkK1cpzVX1fadnIwHZmGZry/L7URFr255C29+DCM1JsC2K1g632uj?=
 =?us-ascii?Q?Z+nE+nAC5HEOM6jD+aqY92Ik0cbzlYCSswTLsyWC8HNVre8oOlK7QHM4jNrf?=
 =?us-ascii?Q?lYMNrUMqV0KWWK8dR59lQRGQzqdnNlcS6PwcUmktFzzjSYYA6hPMPG5hlisV?=
 =?us-ascii?Q?/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d046ca-47c4-4b44-e7e0-08dcf41b6681
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:02:50.2027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aXmMV30HeD+hIuwb8y2GDuI2Z10cBh0Z8U5WyCwfs5VK0wc6eWNpdueXyFlMRws3RzGjUzTchRC0nSbMR04I4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9622

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
  doc/media: Update Links property for broadcast
  transport: Set bap_update_links as transport op
  transport: Make transport_bap_set_state part of BAP_OPS
  client/player: Handle acquiring broadcast links
  client/player: Add support to select multiple transports
  transport: Unlink broadcast transport at release

 client/player.c                  |  75 +++--
 doc/org.bluez.MediaTransport.rst |   3 +
 profiles/audio/bap.c             | 174 +++++++----
 profiles/audio/transport.c       | 192 ++++++++++--
 src/shared/bap.c                 | 498 +++++++++++++++++++++++++++----
 src/shared/bap.h                 |   4 +-
 unit/test-bap.c                  |   7 +-
 7 files changed, 769 insertions(+), 184 deletions(-)


base-commit: ba98be0356215dd3fdfb0cd40d7bf4cde4d7359a
-- 
2.43.0

