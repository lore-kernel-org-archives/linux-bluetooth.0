Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2DC1B2EDE
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Aug 2024 14:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252220; cv=fail; b=I6ogLWi9dc4TgsoLCykP8bmXV0t2tqdhFUwtdRPiC86VoJqBMm6ib3eXCwsizqLIDUxHQjXLn4tdu/MD72hlwD2AtRfPv7etdvrDFJ9k9acn7wEccZZCdV2Q6TKJoSQvMETopgIHvzLAVse7VkK+SYAONm8qvqqGuwL5EgnijIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252220; c=relaxed/simple;
	bh=3870dVQT0bg8s166mnssLePIRVoYONnIUVlPwOpeSDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E+aYzdjnuhg+GTslT5p8JGmVLXmyPPF737xDEFJoaI2NLPcUlIsquEQn/5WNRZqP1kLszzqhUGXNCDhnJ3T0SfKvLg/K4C9RIENs9nisJX3yJImahWEQNLhymAWc4hqknk1Mc3KpXJFzzeLu+nugSOyD3+QbLxFaHpxohXqqYR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HPMkJzPa; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HPMkJzPa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wl4TIKPrE0xUjGDxoL87w+L/sbETyP8+lhv/P0UYtDDM9G6TKI20joKQD5pMu1bthXq9uqC4k2vfAVvS/cERxNge+THfzTxLXqSnWk31LlgnOFXJNaGCUntMObe/crOAAW9n67qT+WqOphbNyYO9547j5g7ZfEV/Fe02B6JZjYB8YYSbdTqfgvpKx81b8xpF97IBmkLtzeUucL4Qf83hOV7f7VS2uuUo5OUzpSZ+C9wlopww++QWlTNlOu+b7lXShon05wxG5Jky1CfYT4NAKQO6AGTnIBUlY2gZOrU05/BedBF5CLef4VapKIa62C7eYnNjPSrRvgSp0+RlWA1IDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKbbd849qvszLUfPUqVzWaD+9YNN/hToCsnyJjyyKnY=;
 b=WaasLZn9HwBWUi25o0utoapgP7r/fADPljyodUsDx4ayASmJuhj8UdAun4AfB1OccV1JXLvy3fCdSreYIgSAlhTrgpPl2efDotD3CYKWpsjiy3Pa2O/pFwAatM+Crp6weuRrd/bBymdbjD+Vnc2q04dJ5zXCKSyQB5Y4+B+K/5VKw0aiRlqntqs55ZSqXhM/3cpnzW8c9MwcCILOGObPTi1i4vC4TG3OEpu9Glr0cZ071K/i3edxB71GFal39NsvE1YRsO+wkYFx1kjOHSRFOLCBueMcC6MiV696zH94HeHPhONu0no/1Ly4WtEeEMCPetC4pHoIzCHxkMwpedEObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKbbd849qvszLUfPUqVzWaD+9YNN/hToCsnyJjyyKnY=;
 b=HPMkJzPaD+CvQcg+rfJErSS6nvSIIv1eHPfWus2CK9zu14Nwqyo1X2uOC7X6zjtUrmqLaKpZQZcfq8gETxyIy/WRp2mvAzoaywBhWg1LNY1v+r1rnFpNmiBJguTaz3D8hr9KiCaAvN86QBARUAQ1qnyJds1UHLYz7/Pcq+Jh5H/nwcTjh3HbqH+x6kDNGB3CDRU884hzfsTi4bgQko+MEjcpLk6BaVWtEUBhAKzYi5WAwFk5VBk7VaDZdUOy5odGhjcvc6m+b9ezXnvUcU5lrpPQvhk23/Cly/TFWZEvMMGHHR9r78423xwUl/z+25EZJPFoANk5ofA4K6An+rK1SA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8753.eurprd04.prod.outlook.com (2603:10a6:20b:42c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 14:56:54 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 14:56:54 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 14/14] bap: Create streams for required BISes
Date: Wed, 21 Aug 2024 17:56:02 +0300
Message-Id: <20240821145602.92083-15-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
References: <20240821145602.92083-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0126.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::23) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 98410cb2-5c51-419f-3e18-08dcc1f17efe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BccbpsluWc5yCEleCWuCfUoif2cWo85OXGsybjGdPRB9+v8dMB0flELd53IS?=
 =?us-ascii?Q?1oDQadi0MXQVjCGxL+6Apkjzkm4s+UFC15TvV5eyUdlHepbruee1n88qVR9N?=
 =?us-ascii?Q?4jVrRjDDci63LNRzab53DFgbTPU086fmWUQ7iwP20J+TgSljrKkPaftDiAzg?=
 =?us-ascii?Q?gk7NYS+A6IIPnuo3YskK5CsTTpZnLwbMUiCg3kOqsybC6v5Xy5ohJQcJvcqn?=
 =?us-ascii?Q?X2DQoKnyoGg7a0+3IK2Ju08HS7K4iUlBy4pZuylNfgXV0hT2z/qLjr7j3rxN?=
 =?us-ascii?Q?r3xYs9UHU9sXLZfm0HLLQD8XvifYRZDkkPDXGd6BVZWqCDyizSPYkyoWSxNd?=
 =?us-ascii?Q?gXfJ2k/H9O2ffOpaOuZC6idFdFCwmiy4tnoVoqpihghhWFil24h6521Xgbga?=
 =?us-ascii?Q?zZNBJLq0JtNZnGyl48ZgMMvs9dVJkqdI3zeJ2iFf7+QxsTWut+uniTStU3tf?=
 =?us-ascii?Q?6vdDzrvyLIVqJutXlt+oqLTTeY6j+ChP1sVcgmd/B7WiXAq2CkIucqS96+iu?=
 =?us-ascii?Q?10ayXaXzI64Y1/V/ysYIX2VcplzWZ3SCI7dCuFUVv9xRpWd+E/gAtBnmhN2q?=
 =?us-ascii?Q?UB54Uv337F6BnoI/fNkzjmRh6Cppe20meFkwmTXGu2rajsqKe4flstM9266l?=
 =?us-ascii?Q?fQ+g6KXGJbY4idUNA7SWseBL3ljnJWUNAZmET8sLIspDtVhiLByJTuhIhhvy?=
 =?us-ascii?Q?jTbuo5Ms+dEi2QOCfK6TPtyilkcAIAJLa9FalxIg2OHb3cjQn3dZ/gY9eM2x?=
 =?us-ascii?Q?yOv30WK39mlR/hK1bbGosCOGNyEC69WiF1HyzQRXNaeTwGZpJzqvM/2Pq/7x?=
 =?us-ascii?Q?vDSfR1W8XtM9NWvcByMXe+o9WHGgejMioEczkY3vJ6mkB5AzgT9xCRQQ3VWl?=
 =?us-ascii?Q?cGDlULcMdeLAEUVuJO1w2n6t2FlRzTKaEJh9ZtZdYPFPE6j+WDcgK+0OX9LL?=
 =?us-ascii?Q?iUCzSawD80d9s+1HOSiqetyZ0+m97GvImnJdcZupfrFOIBWuQE/qSKUbsv9X?=
 =?us-ascii?Q?xPxsOxM0VIaGGnBuGMFPDbjvJQEEGfydSXrpCkmH3uIDarYJeoqf5SBJFcu4?=
 =?us-ascii?Q?Tb3oIky3VDJ4Iqrpyln8jYZE4OY9JsUL2QIheb6k8t3hyPTxL+LsI1IeynmR?=
 =?us-ascii?Q?8emz3b0ltatGzf0W1/2b/Vkyl2flq6YSeUZbhS5ATRJ+t2OS/vvGUs9AwZxs?=
 =?us-ascii?Q?R6M7DKMr/zmGmcKrRJI8GU8IZWn+E4fBlksMq3a5ixM3VSSyie3p2sBXSQK+?=
 =?us-ascii?Q?ZWtkiuus7EGglTZQ3y/d/uV0y+qqaS9LXOveFES3FEtC9ZxPzlajHYZBLiWS?=
 =?us-ascii?Q?4uFKx39iM9rjjaLiR8GsMkcSZc40Q6ndnGufRB0gcPcHcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FqrJGV7Ju+hJk5wMOOmZ+HVo0jemPIaLFKsZ9u1j7nzAoEqDneDjV+jyHtja?=
 =?us-ascii?Q?Xcra4+PePbg+YkFbdmdpmn+jMX8sz3uIHhEWKFVvXvFpNsvnROiNX0ydZE3n?=
 =?us-ascii?Q?xhlSKdUUVJ5IlE7WsJesUE7qZxak49pBwrLiN/Hmei9SrETrnxhIYXAGaVrL?=
 =?us-ascii?Q?TD6Sp+MLACEZxod7eQQZuEL4ToBTUIEYk/LybffjSCv9UYVw//vwXsgtg0gs?=
 =?us-ascii?Q?2geKkPYLW+SRdsXU7evvz/Tmexo6cA5okz7hewwVCXe6+SRYDKneZQcgweBR?=
 =?us-ascii?Q?CzRijG4dUymptnusm/Hu3zTn7M13PUORb5yzaOaXj5KWMepR2xLBwpgmtQTJ?=
 =?us-ascii?Q?3t46ct5GW3RubnuL7Fmz8cD38OXel1hO4DhmcI3S+llwMXd5U5/isjBg0oBv?=
 =?us-ascii?Q?ZHTmTYfKTCPGKEdlK5dGs0qBjgLAdd62+wnSX3cgBZSfQ03eJt4ZqfVY6L4n?=
 =?us-ascii?Q?1dJ29W05zebqrq7AmYSi3pwKi/t5d+UkbqThl+3B2yqKc9ep96puTBBTTvyF?=
 =?us-ascii?Q?97XPG4f/BECupgpLcAgRAS0uPFJJwxlNl8sPTDgL0niCsxaXU+pLmB6oJIH7?=
 =?us-ascii?Q?A/nR8raZG1FC2FfZLWB+kH/BE2Yy7zCA2Rk+8PMNa7/Xgpby0OBVxJn4/xgj?=
 =?us-ascii?Q?uUbTJOjK1QMCuUgC5bS7bOLGvFevs3sp0HQa7jqxyZT5my603htaYnnQ/aaW?=
 =?us-ascii?Q?L1s1rzTfFLXt5flf0c+0wkcaq75IEOfPFZZTsZxInhB0mKnn3uZeMAygXpGn?=
 =?us-ascii?Q?PYQmSx92u9wG+GazCTD5c7P7sJiKrHEWK2i2hW2pCpFQUKy4r1YSgR06KIBX?=
 =?us-ascii?Q?0x23tXZSWaA9RIEVnzYrtl7K2viDHJ3JW+bUPIodItbKCfyRF2pLJc+PJTzO?=
 =?us-ascii?Q?b8P4Eg22jHipRZSop71hzijUYnFwzctP9/qJo7rA4Ll2CMuekyd01c62J4ml?=
 =?us-ascii?Q?ztgiOk17CAjx0prAdUKagaG+45vO1dBLIeC5pr2UYP2hW6J8HI9I5Ejbq2rA?=
 =?us-ascii?Q?qjDYeV7G7tfg1Oi4B0LP98MCqwv0GTH/qtcLtcr1QsD+9L05U1jTXtSMaxwI?=
 =?us-ascii?Q?K8VTKwk3YSUA7PB0I9TB/vqjSLgldQ9NQgkicNCP54wOQE0Gg9uvnW+qWOwJ?=
 =?us-ascii?Q?g4TmTIeLQHLKuXY1mA1/fze69+VBiZhte6+kp1LD2QAEc6jcXUcqvomEYT/x?=
 =?us-ascii?Q?Otz0v/AUV7vxKuNMqB/rZPbdS8uUozLMFsOWQo5CXKBlrLsowBICLtbRBV3f?=
 =?us-ascii?Q?iN9xmzCzhfKadIUM1WOS5zHfjOsZPjoDDklRhuWdTQpHhQi2sWtaj328DUV3?=
 =?us-ascii?Q?1dCIU1nva8mdKkOiBG9Bre+apYUWF8bTh1+vbXSksOBoCGY3Sd9PLcrCG/i4?=
 =?us-ascii?Q?isEAfc0GXaCkA6ln9QdYX921Jqq9yqEoAhJHpvsyx46bXcug8/p1aHYXXLyj?=
 =?us-ascii?Q?3dzF35zAtPtQUKmY+TsbFyPstVJIGidUOFmWNXGOoOfNMrPV/jneeG3lg+Wa?=
 =?us-ascii?Q?UVXF/zZA7xMQX1PSRHnOGSmwA3dwxx7TRsD1nITUnhHz4zvPzAGZODs/5BHO?=
 =?us-ascii?Q?/oCBNYgaUOGKC4umuPGQKAo/vmi5YOWOA/OQ82/9Rad04ZSOlaWnde/regw+?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98410cb2-5c51-419f-3e18-08dcc1f17efe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 14:56:54.3315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CUcoHdPXSc4LyzjxYKBBclwL78b/6U6gAFZah7IGTN+iXZCyEGQ6ANBi85BHAQJssnKx5CCd++VN6w+oebVIwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8753

If a BAP Broadcast Sink is acting as a Scan Delegator and it has performed
short-lived PA sync with a Broadcaster added by a Broadcast Assistant, the
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
index bf924932a..a6a9f5818 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1226,6 +1226,15 @@ static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
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

