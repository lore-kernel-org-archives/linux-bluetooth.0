Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4B7C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 May 2023 06:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjE2Gaf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 May 2023 02:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjE2Gae (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 May 2023 02:30:34 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on061d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe02::61d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0D912A
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 May 2023 23:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApYcDB35yQqXfAy52KnG9RvMCZHJzbQoD8MtMCJMwbluijF8vTwZ35OQkfjqGLt/qyr7YXOWBiifspPvfQF5RnIgVfAv9/COsMcbC7cw80yvdX+jb20dylVQajEFP4npOJ+0A7yLqgzMGrUTqtL4maw1KxzsvLqf/1o0d5kM5h0uDCW7HAAiahrSBE661pDUPBJwGnDQN1n2KP0/U2xXCt+aq9wC6tyRaY/ZSjbTvVhsX0F/j5WO7teoGKCnpRxcUPhTkLtr48EJdo2LxzbYdMX7eGVJWNjZNDujcVfiP8hfI9Mp7s7kUXJcgfSoeWBfBsnjGmnAg3Unh5Uucnm8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iS7HL04Lj3yZ+CEQH2vwL6RS37GuXS/ssFSZthzI5pA=;
 b=XTBmoAE9i+HoVKfVWSsxrAKVn/CJOR1GFafarNusGmKvnEMtPdd5b6ZWOxR5TmgApOf4MMDNVAADCV0nldDsJrDX8Smg+Negqx1BDkgeVUGqho2OcyCNsEZVCvBvKGI4FVdL9TP6rzz+Bouau1ap0R7M7fObmnpHB0PjxPIF1nPgmc/0IypXAogLbGSa4zeBZ1MN0u2UFbj0uCAmvIBPKzK9ol+EkQgQlKmUN0vp0sePI+EVagWhDl+4Dn8SPIp8MC1yssN1oChvlQLANe7lJ1bVGMwc6o3pknrf2S/Xf4tcXR4X/dEt6EexiNcxEFpp9deYcp7xUJp8aaqiRsJUkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iS7HL04Lj3yZ+CEQH2vwL6RS37GuXS/ssFSZthzI5pA=;
 b=oQYItdocVkqi7mML4vbtpT0tPmOWoCxQaSArjvGprqJqW4pzPsXc+G2aJEKJiQIZfr2gq5orVrsfgc6++ffeFQLQlzCiVjMLZWXyvMpXLPZC1X84FsTQkOGBtmLgZVeEbhcmXm2xUinNFUqith/Et2zUN60x1BsEGfWFf5t+Y8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7028.eurprd04.prod.outlook.com (2603:10a6:208:19a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 06:28:20 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 06:28:20 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] isotest: Add support for creating/synchronizing to multiple BISes
Date:   Mon, 29 May 2023 09:27:34 +0300
Message-Id: <20230529062734.3685-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230529062734.3685-1-iulia.tanasescu@nxp.com>
References: <20230529062734.3685-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0077.eurprd04.prod.outlook.com
 (2603:10a6:208:be::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: a0b31436-38c3-4ead-69d4-08db600de545
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gT6s8e8y6Kq8hoxrYXz2k0+7gjGuM9NFXzPkjwjYpCWy2bNBS4ZyYF69zJyaHD0KFFAleVD3bKVj/DoaGmV9LULTCl/Ls5r+5y5JvXcXpwh1gWh7jUHm13JxVr0a3MrhrrdIwdh5QtL1jgIVBWSVG8VDBEqDJfVP6eHtTBowdFvpn2lflKcVegNQ2qz5IhlqTHAUiniD87FJXbUP7OkPv1v2oVs+XlDSkKrcGhWb7vD2sqfQvhvHMG3K33PTqq+TSothP4BnlxYkDeCopqtSk8qDz2ZKB6gcU4WaCx+h/j2c83ay1tWeTDFmxn8lHXMAJvUoG1RveOLnHrmdf/UXKMQ92jfL6MtDVTzVaTUkO/r/N3EDQCqwOHcIBdE0IstT2BUWFQX63VDfQFs7kjlShPJ+ac2K3vta1Ts1ZfRGGL0rec6IMTGGSKbPWTribw3YiKg7+IRrFqjTLbe7iL92ALof8KU/Nwm9CLi79IIyfk3HWPRPQ4qWJdFiaGpkjXVPe8krP9xibFtwMIn5bBpzfvcEtmz3VvvVxK6YNyGd+4vX3ZumK56RG2wnbYwg6nL9M30lSU2Sx8Lg00M9TVKqhyEoH+LYp3ywq4gr4FKwwPnmuYnAOw6RZkh3hcFhzA1s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(376002)(39860400002)(451199021)(26005)(6486002)(52116002)(1076003)(6512007)(6506007)(30864003)(2906002)(6666004)(316002)(186003)(5660300002)(44832011)(41300700001)(36756003)(8676002)(8936002)(478600001)(38350700002)(38100700002)(4326008)(6916009)(86362001)(2616005)(66946007)(66476007)(66556008)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dq9vMyh0OB2GfDGp3DnRepMnXw9yCL77UMkKLJhW1dMVnTVuw1FNmwVkVn1e?=
 =?us-ascii?Q?ifDn3ycIe21afSM1CDvTftwulMGznMG58iGTmbJwKpFo6d8zDx7wsPqboaCN?=
 =?us-ascii?Q?7Q3Q0rJir1UN2l4e0cuqHv+vOogQXsEmlsWOTR7k9SpX2wunsOrF4MsSPBXx?=
 =?us-ascii?Q?TGDcaNj2m2kn5yeQuvfPfD4yJXIwXlHrYNzdIoEtQiCY/75dHIkSUI8tAh8Z?=
 =?us-ascii?Q?QpGymmh6LmgxQ/I2FoMmnerk4STj7dABsq6lkDzlJRE2Gfhjdtc2XDBjAB8s?=
 =?us-ascii?Q?JFUuiV2BIxOZfqSvMTka93PdPyE0Eh++SgxQMsXs4vtTP8UCm2gT+UQDsGTu?=
 =?us-ascii?Q?oRmpyP+PxrroAaiHnF9c3hKP1UJnms/OfGlM8NTx/aMs/b0ZzQbmJPMZnypT?=
 =?us-ascii?Q?/yJ+/895SpfK+zjtcVx62B0T/N79hcHdQGpR+fHCX6m7z7wqzjIwD74L8UoU?=
 =?us-ascii?Q?wiseGA3y78d7RRMWzrPpZNoHJcmv8F8RL2AqF64MhUgoZ3odgoLvYaKzPERk?=
 =?us-ascii?Q?EzlCjBFh/dwfQvRCxyPJhSilK6FS3302omtmIxhj1KYenkPMp8OtY334tVck?=
 =?us-ascii?Q?jCloLIwzuHM4Rk3YEEzTGQti9m+CdvqFBp4sw230zD8iNFRNJZX0vzaz5z98?=
 =?us-ascii?Q?5vtlRo5HcYyNG3xUJEZvV4GkzjQ2MjnyyU6QndDN2Tf6W6YEFV003w7+DzwB?=
 =?us-ascii?Q?cPII8gQjpMFmfhP9ymLD7kU/HP0KQIe5O4Ypik7i1HC/x1IEUNRZ1+fps2lA?=
 =?us-ascii?Q?iaZv+tvrCoS3Bwr3cr5zaT77KpQyBZqCL3ZRSzcfKWz1EBB0umugNTlxJ0dJ?=
 =?us-ascii?Q?QWZc79ZE1UEZ2V6r89LiwTeksvKnmaouAnigVQh1InaTjAnHMwWjIhMl6WoO?=
 =?us-ascii?Q?ls3eZg2zPGsQM/2khvreDEHm6Mg3dIJphkqwNTRtiqxuiNnMCuBjH53MymWv?=
 =?us-ascii?Q?gqH2PwJtI1X+ZnNzNQwwM7O8gnbl2YAAjF8i5/AlGfhBWvo0dYrz92CmV1gI?=
 =?us-ascii?Q?gQfPLRll+HQgxaq/6tYALwISCcJPaX3L4lo1h2SMTSztjjKhJVIQ/hyRmY5q?=
 =?us-ascii?Q?4eWSP2q22zdbnugK4XW23rK4V78KBk5qtIyUKiX+GEEgxSLHcmYC5qYLzwQE?=
 =?us-ascii?Q?UJNKVbUGFDd0wSuWvTpWZl9Ou2iF6qzAyVaPn/GIH0hsquEnQp1gFcOZ2Tw8?=
 =?us-ascii?Q?fTMxH9gNUKLExEG9YmRFqBskBg8STdcsvdhov37Tbx2YW7vcNHWCX8q16gz5?=
 =?us-ascii?Q?MR5w9450Z1B4RGjsf3wZAVdzDhtnPjOtzQ60iVB3RSdrZpubs4VwgpLC5KLl?=
 =?us-ascii?Q?QQVNnb9Uj7rLrLevBg45q2YLYp0lGNSFrhzixxT07dB8l1ziY2NTaiPQlhCH?=
 =?us-ascii?Q?HscNmesOftV/eAXrg7Vv5wZyVpJExYIlLY3VIFsqgu/KHH3mDEM3q7BDaxjA?=
 =?us-ascii?Q?u+64IyYlxiV/ITakCXkGrvJkCaT0STIWbljaiV92eg/73ncRlQbKz4Eip41n?=
 =?us-ascii?Q?SoCUJPqPZ8FSyL/stsMyoOxQsYFNsdp98PPepAp5BHMsdbVZ9BLjrNcc1oEi?=
 =?us-ascii?Q?PFc3zn35z/AHtRwOlHjWHKzmBo7H5+iCT9qjvi0DpazJbSgWP0pUfwi1524d?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b31436-38c3-4ead-69d4-08db600de545
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 06:28:20.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQrLmgtg7hlPk/4B0nEDn0EVjlRmu+7bwhLTnH7pTfD/avihzedmu/AxrhZzdM5yb090a87qRQrebcTXwI4cBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7028
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds an additional command line option for the Broadcast exercise,
so that the user can indicate the number of BISes to create as part of a
BIG (Broadcast Source), or the number of BISes to synchronize
to (Broadcast Sink).

For the Broadcast Source exercise, issue the following command,
in order to create a BIG with handle 0x01, associated with the
advertising handle 0x01, with 2 BISes:

    tools/isotest -i hci0 -s 00:00:00:00:00:00 -N 2 -G 1 -T 1

The isotest and btmon logs will look something like this:

isotest[7178]: mgmt socket: fd 3
isotest[7178]: mgmt_set_le: err 0
isotest[7178]: mgmt_set_experimental: err 0
isotest[7179]: Exit
isotest[7178]: Connecting 00:00:00:00:00:00 ...
isotest[7178]: Connected [00:00:00:00:00:00]
isotest[7178]: QoS [BIG 0x01 BIS 0x01 Packing 0x00 Framing 0x00 Encryption 0x00]
isotest[7178]: Input QoS [Interval 10000 us Latency 10 ms SDU 0 PHY 0x00 RTN 2]
isotest[7178]: Output QoS [Interval 10000 us Latency 10 ms SDU 40 PHY 0x02 RTN 2]
isotest[7178]: Connecting 00:00:00:00:00:00 ...
isotest[7178]: Connected [00:00:00:00:00:00]
isotest[7178]: QoS [BIG 0x01 BIS 0x01 Packing 0x00 Framing 0x00 Encryption 0x00]
isotest[7178]: Input QoS [Interval 10000 us Latency 10 ms SDU 0 PHY 0x00 RTN 2]
isotest[7178]: Output QoS [Interval 10000 us Latency 10 ms SDU 40 PHY 0x02 RTN 2]
isotest[7183]: Sending ...
isotest[7183]: Number of packets: 1
isotest[7183]: Socket jitter buffer: 80 buffer
isotest[7183]: [seq 0] 40 bytes buffered 92 (3712 bytes)
isotest[7184]: Sending ...
isotest[7184]: Number of packets: 1
isotest[7184]: Socket jitter buffer: 80 buffer
isotest[7184]: [seq 0] 40 bytes buffered 92 (3712 bytes)
isotest[7178]: Exit

< HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068) plen 31
        Handle: 0x01
        Advertising Handle: 0x01
        Number of BIS: 2
        SDU Interval: 10000 us (0x002710)
        Maximum SDU size: 40
        Maximum Latency: 10 ms (0x000a)
        RTN: 0x02
        PHY: LE 2M (0x02)
        Packing: Sequential (0x00)
        Framing: Unframed (0x00)
        Encryption: 0x00
        Broadcast Code: 00000000000000000000000000000000

> HCI Event: Command Status (0x0f) plen 4
      LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
        Status: Success (0x00)

> HCI Event: LE Meta Event (0x3e) plen 23
      LE Broadcast Isochronous Group Complete (0x1b)
        Status: Success (0x00)
        Handle: 0x01
        BIG Synchronization Delay: 1974 us (0x0007b6)
        Transport Latency: 1974 us (0x0007b6)
        PHY: LE 2M (0x02)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 10
        Connection Handle #1: 11

< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 10
        Data Path Direction: Input (Host to Controller) (0x00)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration: 

> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 10

< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 11
        Data Path Direction: Input (Host to Controller) (0x00)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration: 

> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 11

< ISO Data TX: Handle 10 flags 0x02 dlen 44

< ISO Data TX: Handle 11 flags 0x02 dlen 44

> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 10
        Count: 1

> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 11
        Count: 1

For the Broadcast Sink exercise, issue the following command,
in order to synchronize to the BISes created by the source:

    tools/isotest -i hci1 -r 36:13:00:E1:1B:F0 -V le_random -N 2 -G 1

The flow is shown by the isotest log and the filtered btmon snippet below:

isotest[4033]: mgmt socket: fd 3
isotest[4034]: Exit
isotest[4033]: mgmt_set_le: err 0
isotest[4033]: mgmt_set_experimental: err 0
isotest[4033]: Waiting for connection 36:13:00:E1:1B:F0...
isotest[4036]: Connected [36:13:00:E1:1B:F0]
isotest[4036]: QoS [BIG 0x01 BIS 0x00 Packing 0x00 Framing 0x00 Encryption 0x00]
isotest[4036]: Input QoS [Interval 1974 us Latency 10 ms SDU 40 PHY 0x00 RTN 0]
isotest[4036]: Output QoS [Interval 0 us Latency 0 ms SDU 0 PHY 0x00 RTN 0]
isotest[4036]: Receiving ...
isotest[4037]: Connected [36:13:00:E1:1B:F0]
isotest[4037]: QoS [BIG 0x01 BIS 0x00 Packing 0x00 Framing 0x00 Encryption 0x00]
isotest[4037]: Input QoS [Interval 1974 us Latency 10 ms SDU 40 PHY 0x00 RTN 0]
isotest[4037]: Output QoS [Interval 0 us Latency 0 ms SDU 0 PHY 0x00 RTN 0]
isotest[4037]: Receiving ...
isotest[4037]: [seq 0] 280 bytes in 6.48 sec speed 0.34 kb/s
isotest[4036]: [seq 0] 280 bytes in 6.54 sec speed 0.33 kb/s
isotest[4037]: [seq 1] 280 bytes in 7.01 sec speed 0.31 kb/s
isotest[4036]: [seq 1] 280 bytes in 7.02 sec speed 0.31 kb/s
isotest[4037]: [seq 2] 280 bytes in 7.06 sec speed 0.31 kb/s
isotest[4036]: [seq 2] 280 bytes in 7.04 sec speed 0.31 kb/s

< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00
        Adv address type: Random (0x01)
        Adv address: 36:13:00:E1:1B:F0 (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 163840 msec (0x4000)
        Sync CTE type: 0x0000

> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
        Status: Success (0x00)

< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13
        Own address type: Public (0x00)
        Filter policy: Ignore not in accept list (0x01)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Passive (0x00)
          Interval: 60.000 msec (0x0060)
          Window: 30.000 msec (0x0030)
        Entry 1: LE Coded
          Type: Passive (0x00)
          Interval: 60.000 msec (0x0060)
          Window: 30.000 msec (0x0030)

> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 1
        Status: Success (0x00)

< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)

> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 1
        Status: Success (0x00)

> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 0
        Advertising SID: 0x00
        Advertiser address type: Random (0x01)
        Advertiser address: 36:13:00:E1:1B:F0 (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 10.00 msec (0x0008)
        Advertiser clock accuracy: 0x00

> HCI Event: LE Meta Event (0x3e) plen 8
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: 127 dbm (0x7f)
        RSSI: -47 dBm (0xd1)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x00

> HCI Event: LE Meta Event (0x3e) plen 20
      LE Broadcast Isochronous Group Info Advertising Report (0x22)
        Sync Handle: 0x0000
        Number BIS: 2
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

< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b) plen 26
        BIG Handle: 0x01
        BIG Sync Handle: 0x0000
        Encryption: Unencrypted (0x00)
        Broadcast Code: 00000000000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 163840 ms (0x4000)
        Number of BIS: 2
        BIS ID: 0x01
        BIS ID: 0x02

> HCI Event: LE Meta Event (0x3e) plen 19
      LE Broadcast Isochronous Group Sync Estabilished (0x1d)
        Status: Success (0x00)
        BIG Handle: 0x01
        Transport Latency: 1974 us (0x0007b6)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 10
        Connection Handle #1: 11

< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 10
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration: 

> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 10

< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 11
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration: 

> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 11

> ISO Data RX: Handle 10 flags 0x06 dlen 48

> ISO Data RX: Handle 11 flags 0x06 dlen 48

---
 tools/isotest.c   | 290 ++++++++++++++++++++++++++++++++++------------
 tools/isotest.rst |   4 +
 2 files changed, 218 insertions(+), 76 deletions(-)

diff --git a/tools/isotest.c b/tools/isotest.c
index caa711b2e..0eae3cdc1 100644
--- a/tools/isotest.c
+++ b/tools/isotest.c
@@ -32,6 +32,7 @@
 #include <linux/sockios.h>
 #include <time.h>
 #include <inttypes.h>
+#include <sys/wait.h>
 
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
@@ -45,6 +46,9 @@
 #define SEC_USEC(_t)  (_t  * 1000000L)
 #define TS_USEC(_ts)  (SEC_USEC((_ts)->tv_sec) + NSEC_USEC((_ts)->tv_nsec))
 
+#define DEFAULT_BIG_ID 0x01
+#define DEFAULT_BIS_ID 0x01
+
 /* Test modes */
 enum {
 	SEND,
@@ -72,6 +76,8 @@ static bool quiet;
 struct bt_iso_qos *iso_qos;
 static bool inout;
 
+static uint8_t num_bis = 1;
+
 struct lookup_table {
 	const char *name;
 	int flag;
@@ -316,8 +322,6 @@ static int do_connect(char *peer)
 	struct sockaddr_iso addr;
 	int sk;
 
-	mgmt_set_experimental();
-
 	/* Create socket */
 	sk = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_ISO);
 	if (sk < 0) {
@@ -390,6 +394,45 @@ error:
 	return -1;
 }
 
+static int *bcast_do_connect_mbis(uint8_t count, char *peer)
+{
+	int *sk;
+	uint8_t sk_cnt = 0;
+
+	sk = malloc(count * sizeof(*sk));
+	if (!sk) {
+		syslog(LOG_ERR, "Can't allocate socket array");
+		return NULL;
+	}
+
+	defer_setup = 1;
+
+	for (int i = 0; i < count; i++) {
+		if (i == count - 1)
+			defer_setup = 0;
+
+		sk[i] = do_connect(peer);
+		if (sk[i] < 0) {
+			syslog(LOG_ERR, "Can't create socket: %s (%d)",
+					strerror(errno), errno);
+
+			goto error;
+		}
+
+		sk_cnt++;
+	}
+
+	return sk;
+
+error:
+	for (int i = 0; i < sk_cnt; i++)
+		close(sk[i]);
+
+	free(sk);
+	return NULL;
+
+}
+
 static void do_listen(char *filename, void (*handler)(int fd, int sk),
 							char *peer)
 {
@@ -431,8 +474,11 @@ static void do_listen(char *filename, void (*handler)(int fd, int sk),
 	if (peer) {
 		str2ba(peer, &addr->iso_bc->bc_bdaddr);
 		addr->iso_bc->bc_bdaddr_type = bdaddr_type;
-		addr->iso_bc->bc_num_bis = 1;
-		addr->iso_bc->bc_bis[0] = 1;
+		addr->iso_bc->bc_num_bis = num_bis;
+
+		for (int i = 0; i < num_bis; i++)
+			addr->iso_bc->bc_bis[i] = i + 1;
+
 		optlen += sizeof(*addr->iso_bc);
 	}
 
@@ -584,6 +630,7 @@ static void recv_mode(int fd, int sk)
 							strerror(errno), errno);
 				if (errno != ENOTCONN)
 					return;
+
 				r = 0;
 			}
 
@@ -704,12 +751,66 @@ static int read_file(int fd, ssize_t count, bool rewind)
 	return len;
 }
 
-static void do_send(int sk, int fd, struct bt_iso_io_qos *out, uint32_t num,
-		    bool repeat)
+static void do_send(int sk, int fd, char *peer, bool repeat)
 {
 	uint32_t seq;
 	struct timespec t_start;
-	int len, used;
+	int send_len, used;
+	socklen_t len;
+	struct bt_iso_qos qos;
+	uint32_t num;
+	struct bt_iso_io_qos *out;
+
+	syslog(LOG_INFO, "Sending ...");
+
+	/* Read QoS */
+	if (!strcmp(peer, "00:00:00:00:00:00"))
+		out = &qos.bcast.out;
+	else
+		out = &qos.ucast.out;
+
+	memset(&qos, 0, sizeof(qos));
+	len = sizeof(qos);
+	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len) < 0) {
+		syslog(LOG_ERR, "Can't get Output QoS socket option: %s (%d)",
+				strerror(errno), errno);
+		out->sdu = ISO_DEFAULT_MTU;
+	}
+
+	/* num of packets = latency (ms) / interval (us) */
+	num = (out->latency * 1000 / out->interval);
+
+	syslog(LOG_INFO, "Number of packets: %d", num);
+
+	if (!sndbuf)
+		/* Use socket buffer as a jitter buffer for the entire buffer
+		 * latency:
+		 * jitter buffer = 2 * (SDU * subevents)
+		 */
+		sndbuf = 2 * ((out->latency * 1000 / out->interval) *
+							out->sdu);
+
+	len = sizeof(sndbuf);
+	if (setsockopt(sk, SOL_SOCKET, SO_SNDBUF, &sndbuf, len) < 0) {
+		syslog(LOG_ERR, "Can't set socket SO_SNDBUF option: %s (%d)",
+				strerror(errno), errno);
+	}
+
+	syslog(LOG_INFO, "Socket jitter buffer: %d buffer", sndbuf);
+
+	if (sndto.tv_usec) {
+		len = sizeof(sndto);
+		if (setsockopt(sk, SOL_SOCKET, SO_SNDTIMEO, &sndto, len) < 0) {
+			syslog(LOG_ERR, "Can't set socket SO_SNDTIMEO option: "
+				"%s (%d)", strerror(errno), errno);
+		} else {
+			syslog(LOG_INFO, "Socket send timeout: %ld usec",
+							sndto.tv_usec);
+		}
+	}
+
+	for (int i = 6; i < out->sdu; i++)
+		buf[i] = 0x7f;
 
 	if (clock_gettime(CLOCK_MONOTONIC, &t_start) < 0) {
 		perror("clock_gettime");
@@ -718,17 +819,17 @@ static void do_send(int sk, int fd, struct bt_iso_io_qos *out, uint32_t num,
 
 	for (seq = 0; ; seq++) {
 		if (fd >= 0) {
-			len = read_file(fd, out->sdu, repeat);
-			if (len < 0) {
+			send_len = read_file(fd, out->sdu, repeat);
+			if (send_len < 0) {
 				syslog(LOG_ERR, "read failed: %s (%d)",
-						strerror(-len), -len);
+						strerror(-send_len), -send_len);
 				exit(1);
 			}
 		} else
-			len = out->sdu;
+			send_len = out->sdu;
 
-		len = send(sk, buf, len, 0);
-		if (len <= 0) {
+		send_len = send(sk, buf, send_len, 0);
+		if (send_len <= 0) {
 			syslog(LOG_ERR, "send failed: %s (%d)",
 						strerror(errno), errno);
 			exit(1);
@@ -739,7 +840,7 @@ static void do_send(int sk, int fd, struct bt_iso_io_qos *out, uint32_t num,
 		if (!quiet)
 			syslog(LOG_INFO,
 				"[seq %d] %d bytes buffered %d (%d bytes)",
-				seq, len, used / len, used);
+				seq, send_len, used / send_len, used);
 
 		if (seq && !((seq + 1) % num))
 			send_wait(&t_start, num * out->interval);
@@ -748,11 +849,11 @@ static void do_send(int sk, int fd, struct bt_iso_io_qos *out, uint32_t num,
 
 static void send_mode(char *filename, char *peer, int i, bool repeat)
 {
-	struct bt_iso_qos qos;
-	socklen_t len;
 	int sk, fd = -1;
-	uint32_t num;
-	struct bt_iso_io_qos *out;
+	int *sk_arr;
+	uint8_t nconn = strcmp(peer, "00:00:00:00:00:00") ? 1 : num_bis;
+
+	mgmt_set_experimental();
 
 	if (filename) {
 		char altername[PATH_MAX];
@@ -769,6 +870,33 @@ static void send_mode(char *filename, char *peer, int i, bool repeat)
 			fd = open_file(filename);
 	}
 
+	if (nconn > 1) {
+		sk_arr = bcast_do_connect_mbis(nconn, peer);
+		if (!sk_arr)
+			exit(1);
+
+		for (int i = 0; i < nconn; i++) {
+			if (fork()) {
+				/* Parent */
+				continue;
+			}
+
+			/* Child */
+			do_send(sk_arr[i], fd, peer, repeat);
+			exit(0);
+		}
+
+		/* Wait for children to exit */
+		while (wait(NULL) > 0)
+			;
+
+		for (int i = 0; i < nconn; i++)
+			close(sk_arr[i]);
+
+		free(sk_arr);
+		return;
+	}
+
 	sk = do_connect(peer);
 	if (sk < 0) {
 		syslog(LOG_ERR, "Can't connect to the server: %s (%d)",
@@ -782,62 +910,13 @@ static void send_mode(char *filename, char *peer, int i, bool repeat)
 		sleep(abs(defer_setup) - 1);
 	}
 
-	syslog(LOG_INFO, "Sending ...");
-
-	/* Read QoS */
-	if (!strcmp(peer, "00:00:00:00:00:00"))
-		out = &qos.bcast.out;
-	else
-		out = &qos.ucast.out;
-
-	memset(&qos, 0, sizeof(qos));
-	len = sizeof(qos);
-	if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_QOS, &qos, &len) < 0) {
-		syslog(LOG_ERR, "Can't get Output QoS socket option: %s (%d)",
-				strerror(errno), errno);
-		out->sdu = ISO_DEFAULT_MTU;
-	}
-
-	/* num of packets = latency (ms) / interval (us) */
-	num = (out->latency * 1000 / out->interval);
-
-	syslog(LOG_INFO, "Number of packets: %d", num);
-
-	if (!sndbuf)
-		/* Use socket buffer as a jitter buffer for the entire buffer
-		 * latency:
-		 * jitter buffer = 2 * (SDU * subevents)
-		 */
-		sndbuf = 2 * ((out->latency * 1000 / out->interval) *
-							out->sdu);
-
-	len = sizeof(sndbuf);
-	if (setsockopt(sk, SOL_SOCKET, SO_SNDBUF, &sndbuf, len) < 0) {
-		syslog(LOG_ERR, "Can't set socket SO_SNDBUF option: %s (%d)",
-				strerror(errno), errno);
-	}
-
-	syslog(LOG_INFO, "Socket jitter buffer: %d buffer", sndbuf);
-
-	if (sndto.tv_usec) {
-		len = sizeof(sndto);
-		if (setsockopt(sk, SOL_SOCKET, SO_SNDTIMEO, &sndto, len) < 0) {
-			syslog(LOG_ERR, "Can't set socket SO_SNDTIMEO option: "
-				"%s (%d)", strerror(errno), errno);
-		} else {
-			syslog(LOG_INFO, "Socket send timeout: %ld usec",
-							sndto.tv_usec);
-		}
-	}
-
-	for (i = 6; i < out->sdu; i++)
-		buf[i] = 0x7f;
-
-	do_send(sk, fd, out, num, repeat);
+	do_send(sk, fd, peer, repeat);
 }
 
 static void reconnect_mode(char *peer)
 {
+	mgmt_set_experimental();
+
 	while (1) {
 		int sk;
 
@@ -856,6 +935,8 @@ static void reconnect_mode(char *peer)
 
 static void multy_connect_mode(char *peer)
 {
+	mgmt_set_experimental();
+
 	while (1) {
 		int i, sk;
 
@@ -989,7 +1070,8 @@ static void usage(void)
 		"\t[-B, --preset <value>]\n"
 		"\t[-G, --CIG/BIG <value>]\n"
 		"\t[-T, --CIS/BIS <value>]\n"
-		"\t[-V, --type <value>] address type (help for list)\n");
+		"\t[-V, --type <value>] address type (help for list)\n"
+		"\t[-N, --nbis <value>] Number of BISes to create/synchronize to\n");
 }
 
 static const struct option main_options[] = {
@@ -1019,6 +1101,7 @@ static const struct option main_options[] = {
 	{ "CIG/BIG",   required_argument, NULL, 'G'},
 	{ "CIS/BIS",   required_argument, NULL, 'T'},
 	{ "type",      required_argument, NULL, 'V'},
+	{ "nbis",      required_argument, NULL, 'N'},
 	{}
 };
 
@@ -1048,6 +1131,8 @@ int main(int argc, char *argv[])
 	char *filename = NULL;
 	bool repeat = false;
 	unsigned int i;
+	uint8_t nconn = 1;
+	char *peer;
 
 	iso_qos = malloc(sizeof(*iso_qos));
 	/* Default to 16_2_1 */
@@ -1058,7 +1143,7 @@ int main(int argc, char *argv[])
 		int opt;
 
 		opt = getopt_long(argc, argv,
-			"d::cmr::s::nb:i:j:hqt:CV:W:M:S:P:F:I:L:Y:R:B:G:T:e:k:",
+			"d::cmr::s::nb:i:j:hqt:CV:W:M:S:P:F:I:L:Y:R:B:G:T:e:k:N:",
 			main_options, NULL);
 		if (opt < 0)
 			break;
@@ -1224,6 +1309,23 @@ int main(int argc, char *argv[])
 					exit(1);
 			break;
 
+		case 'N':
+			if (optarg)
+				num_bis = atoi(optarg);
+
+			if (num_bis > 1) {
+				/* If the user requested multiple BISes,
+				 * make sure that all BISes are bound
+				 * for the same BIG and advertising set
+				 */
+				if (iso_qos->bcast.big == BT_ISO_QOS_BIG_UNSET)
+					iso_qos->bcast.big = DEFAULT_BIG_ID;
+
+				if (iso_qos->bcast.bis == BT_ISO_QOS_BIS_UNSET)
+					iso_qos->bcast.bis = DEFAULT_BIS_ID;
+			}
+			break;
+
 		/* fall through */
 		default:
 			usage();
@@ -1297,10 +1399,46 @@ int main(int argc, char *argv[])
 			break;
 
 		case CONNECT:
-			sk = do_connect(argv[optind + i]);
-			if (sk < 0)
-				exit(1);
-			dump_mode(-1, sk);
+			peer = argv[optind + i];
+
+			mgmt_set_experimental();
+
+			if (!strcmp(peer, "00:00:00:00:00:00"))
+				nconn = num_bis;
+
+			if (nconn > 1) {
+				int *sk_arr =  bcast_do_connect_mbis(nconn,
+								peer);
+
+				if (!sk_arr)
+					exit(1);
+
+				for (int i = 0; i < nconn; i++) {
+					if (fork()) {
+						/* Parent */
+						continue;
+					}
+
+					/* Child */
+					dump_mode(-1, sk_arr[i]);
+					exit(0);
+				}
+
+				/* Wait for children to exit */
+				while (wait(NULL) > 0)
+					;
+
+				for (int i = 0; i < nconn; i++)
+					close(sk_arr[i]);
+
+				free(sk_arr);
+			} else {
+				sk = do_connect(argv[optind + i]);
+				if (sk < 0)
+					exit(1);
+				dump_mode(-1, sk);
+			}
+
 			break;
 
 		case RECV:
diff --git a/tools/isotest.rst b/tools/isotest.rst
index 124dc71ab..fc5b3c56f 100644
--- a/tools/isotest.rst
+++ b/tools/isotest.rst
@@ -172,6 +172,10 @@ OPTIONS
 
 -k, --bcode=<BCODE>  Socket QoS Broadcast Code
 
+-N, --nbis=<NBIS>  Number of BISes to create as part of a
+                   BIG (BIS broadcaster) or to synchronize
+                   to (BIS broadcast receiver)
+
 EXAMPLES
 ========
 
-- 
2.34.1

