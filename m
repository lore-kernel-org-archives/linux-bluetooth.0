Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE181D12EB
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252203; cv=fail; b=pYZQnfFVMtzl+/94zISxw93WCl599TXwhmw5+pcd9fL3LNfOwBTVoPiFAKuqmyQ3WP8T+4MPy+06kH6nLM/RiL9ACJUY3uf78CNVdoRqTUPeh1EPqqaYrMCI/FVjBQW6R5snpuikprCOsCo0AwUN5fEI5u7G83VeA5QwwzTDJ6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252203; c=relaxed/simple;
	bh=UMtvmE9KOFjO5DwYqccnDX+TnlLfO5YvRweUgpJywQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=vBJ5261qzGuCyDMeJGZ7mA7uzhOo/lao6SOQ//pMX+6S/SFEGkgCImQFn5MjwCSu/8q0HN2BVlowq+mz0t7skkBh0vyhWZp9isbtkaua+w6QGUbhjigEV3OOqbinuPv5Sd8Tjw6LfhNUhbzgqFuvc6FaN/FyFFqncQDyz39U/BQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PiefOYab; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PiefOYab"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HukO2+MExS3x1/DSnmJ566FVfrPWN8QP0620LutNRBC9WY1hlQe8eH1qH6viSKFg0zXyr0T/O2ee79qI7YzQT+AreAl3dRMYUFi2NrPH4U5DL7Wsemz4wgz3hsqHU6ugdf/v2imwa3UxFaBhDoh/oHpwm8n1Ez2/bDNfZFFmzBGtgh+oRuh+XvTad1p1BSkBsHsD5CYvYe5JaHO08fwp5zZBwwv4r4JCNgwHV9UZEKxHDTC6QV3w0Rxm1fMBy4oLX64BkLDYr1u15RSBgLHnjx1XNBPlOp53flAjXm56kcgKswsr3/sY+XB+82en5CXE0GfIEjs8d2iOoemojCKJBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zu+Xa/IKvjHCXjfnnrmisL5s66Wsc1W5UcZC56R2R+M=;
 b=HEcjhtpv+0m/CdOuoo7kfai7PqYObOsJHcDb5AIetKPtba7Z0t3mzENSkeLBU39uQEl76UTU3jhjvhqf4V68RCBgVyyAUQ8ZEPZ127t57k+dozHrSw0ss+UG0TsDjHyJ1tz8GTlrA3iGxGGSMcIfKKjBv5vpONpJV1qFpYNb6McRdlCauQ5i/ImEZ6/o1JP+HCZgfTQlAS1Wkq0QlyBLKLdzbRHCOC7UXcJ0m/tK8H6mGBD8tmodcYYInkxLIbG9mqbh9RzOTAf2ahpoWvIaqFa/vw7CTXGj4tb65KFLZ+6o8w8MY9VkWR6LcvsTH4NXEcjFz8uGxT0ndRlYanJYyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zu+Xa/IKvjHCXjfnnrmisL5s66Wsc1W5UcZC56R2R+M=;
 b=PiefOYabJKW5uypqjkv2aUvqYZ5S898LU5n7aF8ixoF2E5AnnRcLffy8p8Gi2rUku6pTx8ZZ27u+AyVSQyNzoLfdmXJQfKNp+rzkvAdrbJIgXEbR3op19Iel7YN3BmY7UJjI/SwkNufWsRKiB9O+wlZyWrOWeE91zPRIRp2/Meo4fZnWsd3rQzK6NeAurq8w5oRAaeBX/d33g+whqTxPpg+x9lQBmXER9mwO9OPoSW8O+1jnCR1VYfh8LVN5KCN0NSNwkGnfh2hps80S7gW+B8I3xcZQTV11yeaCXpkXBBaeL9e4REGy+RwcID7Pl2r3Yrwr53ROpAqoh/EICYmJpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB7618.eurprd04.prod.outlook.com (2603:10a6:20b:2dc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 14:56:36 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:36 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 09/14] bap: Probe Broadcasters with BASS
Date: Wed, 21 Aug 2024 17:55:57 +0300
Message-Id: <20240821145602.92083-10-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0022.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::32) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f69f11a-d84e-45bd-ff59-08dcc1f17482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XLgua2u3jw7kBRmW5IVH4iD4uH9hgoNKkZ2ev9kSWptIWYRIiP0xS3NFI2gj?=
 =?us-ascii?Q?ptQrKGz1C2puYS7r1PJv+oe1nkwi0U5E5O259l9BUS2wX7J1RFHvRaJV5I4B?=
 =?us-ascii?Q?V4vx0du5eZxFpjqb0ZPOTTpB/rU36t/fyfr/GTVy8CvAfUH1rHj+xnIJLK6G?=
 =?us-ascii?Q?VAwaVEZAtmwU0yi/S3l2bPIlYKu5XJ7O0WNOkmTOuz8RXHLGdJgaWXcTTJhL?=
 =?us-ascii?Q?NmNVNcaZxeiYUabS3qeE6JSSqbLTjBpXfaI4E92Va74SSSH2qtnYT/YNxlbY?=
 =?us-ascii?Q?QrnEOSxVXGwqnnJLluz/IP+viy3U6gxLKGUg+NWKz6UxrcFJntn+6Lfc3ok3?=
 =?us-ascii?Q?POzudPjt/cSSz/tCxKdjEgFoUcRE/VXYKoiPfFlf6euvFTpYM/V5NvjDKdDK?=
 =?us-ascii?Q?5krJVjKs82uIfNF74KZxnb6tSX7LGf0rGIhMzYs/zOcQpy2vXtcwK8FZzHFF?=
 =?us-ascii?Q?0PTWSUI54N2NqcesDt//N3DcmOL5+wbf/hJmRuJfvJDT4NRy9xMxlCnUrSIh?=
 =?us-ascii?Q?fy7TQ1JaZ9MidCFZt6VXtD50kl7RLJKj32gBEZR1hLrrSPPCN0yMaOfTYcs/?=
 =?us-ascii?Q?qwA+oE/rrmNDjyaAvQSKy7EbluPAR3CijxBMNadmtUFMCbUP/QWKoXIj9kSb?=
 =?us-ascii?Q?BNtBjsUKxo5n/EFfdJkrgKxSmkUMXwuZ2WzHQtUHuTQxCIN/Qa+YeLeRqR2W?=
 =?us-ascii?Q?BkGANR9vds4IGMKmU6XWABCbOl9vXdEsX8nrr9q8MWckCPiOWMdVZY28V/H5?=
 =?us-ascii?Q?R5ksY01lWXm0BU4FL1eTtZkXFjQrIBKxkhC3CZiXt8WC6RUKmzxtOVVEJAXF?=
 =?us-ascii?Q?nwxzCSg35Ey/k9v/rSArT94KSc4+70ImM/NSwPGZa1gAVySCAXy8NKhX9IBC?=
 =?us-ascii?Q?oMUylFKXWz4ad0Asnb8dLZXQkYan4TU0k17C4W7qoRAiQpUznfSXKUi+IIPD?=
 =?us-ascii?Q?q1EhHANXMad7D53R7j8HVCLkgwLxnve2CEp919TZII9OHXWmredu+VUFNwRB?=
 =?us-ascii?Q?zlm0/1+VNiTkOqooqLAnHFP7t6eyNCeJdTsBwrBgzB1BzFgTusf0zvqJWUtQ?=
 =?us-ascii?Q?JaX7kIvN7yH157U5gEnGZhCM9j5P3c7rS/yhV055mM0z4KcwxlyuwLqxLJ8Z?=
 =?us-ascii?Q?jOjpRW5x+Fp8CBlb7A0G6oXNhDyBuuOH+7VnjJub0ou1emRZcjUS4gpRRhST?=
 =?us-ascii?Q?dsnCCY3Ln4CgR4laSCO+iRnJ79Gh0EF0W2IbDdDh2RWiNhUTB0e5mdcruHaX?=
 =?us-ascii?Q?0fgsa4WL4k14AXTJkZdONwyAbo2k9+FSVYZIcNwHOrM/9LKWPi527LFyrTC1?=
 =?us-ascii?Q?f+CIE36+bbSaw1hwKSp00Rf51NzFOKVKqY8Y9g5/x+hayw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+bTooKdzIph+LzGCBj4gRugikegPbt9Z1m3V3w1LP1oVfTdYq+S5dxmfg500?=
 =?us-ascii?Q?aHEzRqOOTDo/inJ7j5eKLQJpX7SeBmIYjaucfCO9AA3IbjXIwB23fSYH1C1Z?=
 =?us-ascii?Q?1pE35csd4GWQ/dDTwgRPVu1GwNAsYuGhf2a5RAnxFg+N+H3RPyN8dCxhqmUm?=
 =?us-ascii?Q?US0jVEOK9r7FRZoGCXHLjbOpQZUVTBuR/4O1SxFwXZx87u253YSMZuQb8k7C?=
 =?us-ascii?Q?/cj3C1QBDfYtbaK6X38K4YWyDGBGsq2UwZkka+K37OXbrksArMbxESMrH19z?=
 =?us-ascii?Q?eZ1SINhoDvenuchUQqlFucdsdEYcs5aA5yrV2RudQGaLNwMU3ucpHIPX+t+A?=
 =?us-ascii?Q?rofdvLACH6pMM42JT1XvzKsOPkJkMiiBezsILcbxY949/s97EwPT8IaHY2dd?=
 =?us-ascii?Q?/gBhhyBRDHvEe9LjSs7Q8oWxLHKtKIp7Fy1E8A+Qnm0O+NyFiWuK9sQvXJNQ?=
 =?us-ascii?Q?3PkMUFTUIrE3eHRmZuN9SKY2r685E6s1FKIAmfgh6wu6Q4LFlo99jWE8/UhR?=
 =?us-ascii?Q?lVfhoZrbRZDmATzdVufV9CHjGPQiizU8i2A9Uy2JzmQRJuuDXrbN5dlwqr0U?=
 =?us-ascii?Q?ToRPAnqtKkuf60guLj7Km1nd+U/xrQnykmcA42iy6UIFYrlSU8BpMiOkX2x/?=
 =?us-ascii?Q?UFSzR6WX4jg+WQ+LDpxpuFYOxa6viIuDhw7Hw2LdLA+MrrQuFf0AdORXRm8x?=
 =?us-ascii?Q?VL+opkjVXcjQ6k3sLeMymSrboE/2Gat6Dbw3+kcH99ehTtKswNRPp7mZlPkN?=
 =?us-ascii?Q?GF+IjZFg7Xcr/UUyxjZx/CXGs7YlDXGTijHNSviW5zjJWrMR64RVAUphzYys?=
 =?us-ascii?Q?Fpje/TbO8wYz6DZ7GgXW2XkdJJVkG4vCXDdwvxOlF8XWdbH495yHHCYGBFnm?=
 =?us-ascii?Q?ooivbxjuvlnsd+ZIhzUP6z9ZCoBKJaUQ26WCz+yAY6q6EZXabZH1cZh7S8uY?=
 =?us-ascii?Q?UZSSWxgUXZB5iZAh08KYVD2kECYfpU3Yl4fv8e+U4Gwj1N4kkvvkY7ca/OLw?=
 =?us-ascii?Q?ESyivOJOZ6mDumeac2b5jW41FeC6p3bOnrk3M3Tl6Nxt53IEtU2EoyPDs6yi?=
 =?us-ascii?Q?PdOwZNYReC8AEzjsYXxU+hNGSXeQkOYGC0uduFH5wTZNYIWvzERwLiTwV0xX?=
 =?us-ascii?Q?sxuDRqDuQo93d77gGHqtlBbXMEWZ5ruVszOym4vtglr6UYz0xZcyGOUZ5t6U?=
 =?us-ascii?Q?hXSrSb7Dcwp6lvOQ2VFss8j3z09Rb2eSXUgUIiPO1ESbUqsNsmqsMsBskUXM?=
 =?us-ascii?Q?BaFHe8RHud9KkjXzHEEOlWO8jrxVm7thP2Bjghkql7CckJt579lEKSw5u81r?=
 =?us-ascii?Q?1+7KNAst4X+X/kYhDGahKhLw7SB5z1cC9rxj7uVQTpyzBSmk7TpQYJDR1Cvc?=
 =?us-ascii?Q?vNdcx9mIESuyL1JxX9GG/DZCcOi7fHD4ML1T88LFjqG8cO0VsNDFLALkdnQs?=
 =?us-ascii?Q?l4QR/moJPG6p7FTNBL8kAKORTkl8AB0/MXLm6EikeLHYUw7yZcso9bUUk7mS?=
 =?us-ascii?Q?H6+bD6W0XYRDbAA8HGgOLmL19B4onx6HEJ6oI8s4U9qj3OpvqSQrlnbLz/tD?=
 =?us-ascii?Q?5G+rAzFzJVcRBnq3ActwzLzQW15QrdmzImAyT2Ggb2bHzR1GNIMMjPjubG5/?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f69f11a-d84e-45bd-ff59-08dcc1f17482
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:36.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5jN70wycX+ZFOogNtUDQv1itKyJ16/o/e8sosH0vtK50lmyA2c/70r5iVP6K9A00AG/0iXgl/j/MbsiZ8vh9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7618

After short-lived PA sync, this adds a call to probe the bap session
with the Broadcaster with BASS.

If the BAP Broadcast Sink has probed the Broadcaster autonomously,
the short lived PA sync io is closed immediately, since PA sync needs
to be terminated so other Broadcasters can be probed next. If the BAP
Broadcast Sink is acting as a Scan Delegator and the probed Broadcaster
was added by a Broadcast Assistant, PA sync needs to remain active (it
should be terminated only on Broadcast Assistant command).

This commit updates the way short-lived PA sync is handled in case of
a Scan Delegator use case: A reference to PA sync io is kept inside
data->listen_io, to keep the sync active. The PA sync request is also
kept in progress in the adapter queue, so that no other short-lived PA
syncs will be attempted. Once the BAP data is freed, the listen_io will
be closed and the PA sync request will be dequeued and freed as well.
Then, other Broadcasters will continue to be probed.

This also adds a call to notify BASS about a session with a Broadcaster
being removed, in bap_bcast_remove.

The bluetoothctl log below shows a Scan Delegator creating a media
transport for a BIS added by a Broadcast Assistant through the
Add Source command, and then disconnecting from the Broadcaster:

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
[00-60-37-31-7E-3F]# disconnect 03:E2:C0:11:57:DA
Attempting to disconnect from 03:E2:C0:11:57:DA
[00-60-37-31-7E-3F]# [DEL] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# [DEL] Device 03:E2:C0:11:57:DA 03-E2-C0-11-57-DA

The btmon log below shows that after PA sync is established inside
the BAP plugin, the Scan Delegator sends a GATT notification to
inform the Broadcast Assistant that PA sync has been established.
Once the Broadcaster device is deleted, PA sync is terminated and
the Scan Delegator once again notifies the peer about the update:

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
bluetoothd[70621]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101dd7c8046f72a00f863f00000010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 2A:F7:46:80:7C:DD
          Source_Adv_SID: 0
          Broadcast_ID: 0xf063f8
          PA_Sync_State: Not synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
< HCI Command: LE Periodic Advertising Terminate Sync (0x08|0x0046) plen 2
        Sync handle: 0x0000
> HCI Event: Command Complete (0x0e) plen 4
      LE Periodic Advertising Terminate Sync (0x08|0x0046) ncmd 1
        Status: Success (0x00
---
 profiles/audio/bap.c | 128 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 95 insertions(+), 33 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a2c5a546d..bf924932a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -182,6 +182,9 @@ static struct bt_iso_qos bap_sink_pa_qos = {
 	}
 };
 
+static bool match_service(const void *data, const void *match_data);
+static void iso_do_big_sync(GIOChannel *io, void *user_data);
+
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
 {
 	if (!data)
@@ -211,6 +214,8 @@ static void setup_free(void *data);
 
 static void bap_data_free(struct bap_data *data)
 {
+	struct bap_bcast_pa_req *req;
+
 	if (data->listen_io) {
 		g_io_channel_shutdown(data->listen_io, TRUE, NULL);
 		g_io_channel_unref(data->listen_io);
@@ -230,6 +235,22 @@ static void bap_data_free(struct bap_data *data)
 	bt_bap_state_unregister(data->bap, data->state_id);
 	bt_bap_pac_unregister(data->bap, data->pac_id);
 	bt_bap_unref(data->bap);
+
+	if (data->adapter) {
+		/* If this is a Broadcast Sink session with a Broadcast Source,
+		 * remove any pending PA sync requests from the adapter queue,
+		 * since the session is about to be deleted.
+		 */
+		req = queue_remove_if(data->adapter->bcast_pa_requests,
+						match_service, data->service);
+		if (req && req->io_id) {
+			g_source_remove(req->io_id);
+			req->io_id = 0;
+		}
+
+		free(req);
+	}
+
 	free(data);
 }
 
@@ -1004,9 +1025,11 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 
 	DBG("BIG Sync completed");
 
-	g_io_channel_unref(setup->io);
-	g_io_channel_shutdown(setup->io, TRUE, NULL);
-	setup->io = NULL;
+	if (setup->io) {
+		g_io_channel_unref(setup->io);
+		g_io_channel_shutdown(setup->io, TRUE, NULL);
+		setup->io = NULL;
+	}
 
 	/* This device is no longer needed */
 	btd_service_connecting_complete(bap_data->service, 0);
@@ -1258,9 +1281,25 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 	/* Close the io and remove the queue request for another PA Sync */
 	g_io_channel_shutdown(data->listen_io, TRUE, NULL);
 	g_io_channel_unref(data->listen_io);
-	g_io_channel_shutdown(io, TRUE, NULL);
 	data->listen_io = NULL;
 
+	if (bass_bcast_probe(data->device, data->bap)) {
+		/* If this Broadcast Source was successfully probed inside
+		 * BASS, it means that the Broadcast Sink acting as a Scan
+		 * Delegator performed short-lived PA sync as a request from
+		 * a Broadcast Assistant. The Scan Delegator should keep PA
+		 * sync active until instructed otherwise by the Assistant.
+		 * Keep a reference to the PA sync io to keep the fd open.
+		 */
+		data->listen_io = io;
+		g_io_channel_ref(io);
+	} else {
+		/* Unless it is required by a Broadcast Assistant, PA sync is
+		 * no longer needed at this point, so the io can be closed.
+		 */
+		g_io_channel_shutdown(io, TRUE, NULL);
+	}
+
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
@@ -1268,9 +1307,18 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 
 	service_set_connecting(req->data.service);
 
-	queue_remove(data->adapter->bcast_pa_requests, req);
 	req->io_id = 0;
-	free(req);
+
+	if (!data->listen_io) {
+		/* If PA sync has been terminated, dequeue request to be able
+		 * to probe other Broadcasters. Otherwise, keep this request
+		 * in progress to avoid probing other Broadcasters as long as
+		 * PA is active with the current one. The request will be
+		 * dequeued and freed when the PA sync io will be shutdown.
+		 */
+		queue_remove(data->adapter->bcast_pa_requests, req);
+		free(req);
+	}
 
 	return FALSE;
 }
@@ -2236,6 +2284,26 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 	struct bap_bcast_pa_req *req = new0(struct bap_bcast_pa_req, 1);
 	struct bap_adapter *adapter = data->adapter;
 
+	req->type = BAP_PA_BIG_SYNC_REQ;
+	req->in_progress = FALSE;
+	req->data.setup = setup;
+
+	if (data->listen_io) {
+		/* If there is an active listen io for the BAP session
+		 * with the Broadcast Source, it means that PA sync is
+		 * already established. Go straight to establishing BIG
+		 * sync.
+		 */
+		iso_do_big_sync(data->listen_io, req);
+		return;
+	}
+
+	/* Add this request to the PA queue.
+	 * We don't need to check the queue here, as we cannot have
+	 * BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
+	 */
+	queue_push_tail(adapter->bcast_pa_requests, req);
+
 	/* Timer could be stopped if all the short lived requests were treated.
 	 * Check the state of the timer and turn it on so that this requests
 	 * can also be treated.
@@ -2244,15 +2312,6 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 		adapter->pa_timer_id = g_timeout_add_seconds(PA_IDLE_TIMEOUT,
 								pa_idle_timer,
 								adapter);
-
-	/* Add this request to the PA queue.
-	 * We don't need to check the queue here, as we cannot have
-	 * BAP_PA_BIG_SYNC_REQ before a short PA (BAP_PA_SHORT_REQ)
-	 */
-	req->type = BAP_PA_BIG_SYNC_REQ;
-	req->in_progress = FALSE;
-	req->data.setup = setup;
-	queue_push_tail(adapter->bcast_pa_requests, req);
 }
 
 static void setup_create_ucast_io(struct bap_data *data,
@@ -3030,10 +3089,17 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	const char *strbis = NULL;
 
 	DBG("PA Sync done");
-	g_io_channel_unref(setup->io);
-	g_io_channel_shutdown(setup->io, TRUE, NULL);
-	setup->io = io;
-	g_io_channel_ref(setup->io);
+
+	if (setup->io) {
+		g_io_channel_unref(setup->io);
+		g_io_channel_shutdown(setup->io, TRUE, NULL);
+
+		/* Keep a reference to the PA sync io until
+		 * BIG sync is established.
+		 */
+		setup->io = io;
+		g_io_channel_ref(setup->io);
+	}
 
 	/* TODO
 	 * We can only synchronize with a single BIS to a BIG.
@@ -3086,14 +3152,14 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	memcpy(&qos.bcast.out, &setup->qos.bcast.io_qos,
 			sizeof(struct bt_iso_io_qos));
 
-	if (!bt_io_set(setup->io, &err,
+	if (!bt_io_set(io, &err,
 			BT_IO_OPT_QOS, &qos,
 			BT_IO_OPT_INVALID)) {
 		error("bt_io_set: %s", err->message);
 		g_error_free(err);
 	}
 
-	if (!bt_io_bcast_accept(setup->io,
+	if (!bt_io_bcast_accept(io,
 			iso_bcast_confirm_cb,
 			req, NULL, &err,
 			BT_IO_OPT_ISO_BC_NUM_BIS,
@@ -3211,7 +3277,6 @@ static void bap_bcast_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct bap_data *data;
-	struct bap_bcast_pa_req *req;
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
@@ -3222,17 +3287,9 @@ static void bap_bcast_remove(struct btd_service *service)
 		error("BAP service not handled by profile");
 		return;
 	}
-	/* Remove the corresponding entry from the pa_req queue. Any pa_req that
-	 * are in progress will be stopped by bap_data_remove which calls
-	 * bap_data_free.
-	 */
-	req = queue_remove_if(data->adapter->bcast_pa_requests,
-						match_service, service);
-	if (req && req->io_id) {
-		g_source_remove(req->io_id);
-		req->io_id = 0;
-	}
-	free(req);
+
+	/* Notify the BASS plugin about the removed session. */
+	bass_bcast_remove(device);
 
 	bap_data_remove(data);
 
@@ -3393,8 +3450,13 @@ static void bap_adapter_remove(struct btd_profile *p,
 	DBG("%s", addr);
 
 	queue_destroy(data->adapter->bcast_pa_requests, free);
+
+	if (data->adapter->pa_timer_id)
+		g_source_remove(data->adapter->pa_timer_id);
+
 	queue_remove(adapters, data->adapter);
 	free(data->adapter);
+	data->adapter = NULL;
 
 	if (queue_isempty(adapters)) {
 		queue_destroy(adapters, NULL);
-- 
2.39.2

