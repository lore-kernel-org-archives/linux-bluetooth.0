Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094E712C527
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Mar 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711037584; cv=fail; b=ezKFlX87ctEOI1ipFWi0igCLnsU3d2HBhv+1HocmgSf+Ef9wnQ9PklrlZTiEUa2ajxKp3dSIiicdPb6k+LtKJj8770wX+45J3Ug/i2RCfTKixBJ62B9NrXbqQ2Gmhk4qm4gKoDU8DjO59+6eDz9VbupU3XDd2wy26OTa2Cf1hHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711037584; c=relaxed/simple;
	bh=AJuDOPP+hrdrQftXAbw0NZrWKG8sc/I1+JTPP1+km+8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YU1nyTUa8tm1QqeZEbd9c5sxTq9EZxqEQPzVKcr9D0ZYpd7pkniPATN8zb5Oh74HxUrHVRIDEjgH0kXzAvtYcL5thsqIH1kV9Nu7GEq61hG2mO4vMotiPyf+6Iup5qUT4O+1p6WVf+lkQVzRWFAw+0rTrJjgSWa8pCTNUrHgWzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fp2JW9OH; arc=fail smtp.client-ip=40.107.7.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fp2JW9OH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dll0kmLgjGKkfs4ydA9fVKSpj3q3Du5kdB5YjXtSTp72x7rBz8lHHIiJjavgxr7idtVrzoIyfsetb25FIxb8yo9He7gDkWI1lihypDfDqwROeC+bhVH5Ktm/J4qX8mxGjHK6/6wLz4Sk/+kn6XQ/EIHAWs6rDLt9mwxXtvT6R6Xc00+em5ylAO62HNQMs4UUqIP4vfmDuo88BHNa2q47KIE+JAwpaTerk/0ZVkORlxi/VnGya1jJPZSDaVAyOZ98Bv6MYzInovt/NW8g9U98pkNyxIgZvoIr5Km0HJzFfRyGEgElOhRK33fWlvMToz0ayRr/ux0SQSixg6Ja5DPGvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax46os2hy8mhWZthI34GWB9L21rLSsFX/Io6vw4MRLs=;
 b=Ax1iJCjbmHCX1w6JPNsHOf3G69zDOJ3iBDah1ipn2Smnmwey0yGF/CJ/g+tSr4jd2LGjyvw5SBtb3e9lJ9YpvUhxg1y0dkVn3ldfxHY3Qa4Xo2LtdlnZ15cruLG3h4QoZVD7iY0hg98wLNhVe9TJTw27h4Hl4K72OSXYE5mvyB+KaRJWIB01dLQmw+nQQO33LJbjSdBmCoO/pDf/PvWX8rc1YoNPWdxE0PlsTLyAGDAY8dJZTkNuz/6GSJ2c4Zzs45jrg0nnERdb1zAZG68RvfjHTf5CSwn7Eq+18RFGgp2IPpxzzrTz3h1oZiIrfwM3Mn6IB1ulmFm0PvjDynAK/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax46os2hy8mhWZthI34GWB9L21rLSsFX/Io6vw4MRLs=;
 b=Fp2JW9OHxX7vDv4WpRC0F2KmQ+wS/mQVN4+vCN//26Rt/eOfwG4sRnQ86xmkuOUCv80tPdRAgLUySsyeigqiNnz05u6wNBADA7FhI6QxG5VM/3oD2r4xYzWZud+eYu5uK4VNo4+/mkTDjkZeKfsMu906UkrCeQljEOzYHNHA14M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB9956.eurprd04.prod.outlook.com (2603:10a6:800:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.35; Thu, 21 Mar
 2024 16:12:59 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 16:12:59 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/1] Adjust SDU size based on the number of locations
Date: Thu, 21 Mar 2024 18:12:54 +0200
Message-Id: <20240321161255.24892-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0019.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::32) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB9956:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e17fb67-e9f7-4cc5-c22d-08dc49c1c6ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TA9lyXyWzQTbxraE/ycQ/8TlK/TcjUiEKkR75VjSNYQDtlSgcCXRZET6ENDX/b5kp/9vAXVNFFm9ksCu9CLuicKepb5U8qQLsCVrR7JzKUHErp5jwUPXsru5u9VvguGwOvWnKtN85rK6n0uj6TWVf99V4jrYI7aOU/HhekWA61LuABk00bvwc78SAS6VGdgX/DZ9HtEF//2HRS3zyZGJeT6yQ4x5c4i3nSY5NJ6SBLYZQC6jdmt0VnF9u7JwYIvWCxKFNvOe/19C83eXSUgqbASy5UCjCfieFLJ+xWBEh2RC3XSmQRs/yYNw/FCvmhU2ydKVCH7QyirttoLXDWkbYUeauI1bmyOOZ+o06LSpDuA+Vuz76Zt/2wCsjsm67Tte9BpL4e1G8njjOnwqT6z3UljFyjTDRGWwVQ+COyMejsHVgoLJproOkuiHHWluaa79PAO4oCTD2AxWovqVyM9guOAJDZsP7XgG96MpxDwL6eNBHq5LgfQl24zV2CGy/rk5k8deSUQ9qlhOz45D/xW0fqXswLQPrJLVCDwSh2kKxFQIOk3YhUe1qof6A6OHGm7/yOkypNRSqibtkVUAZwUaK7Q9YPOJNnFwiwtee8S+MVmYbGspqePzvFlpCI0pMr9MPf63wO0uELw/HA1HYusV+cI1St5EuF/zzUk9dIf95ec=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2b4tOHdP6q7ec+gPet/TIBl6m2sWJ62oU49fNuHTLkyicWpMGTTFFCulYtUS?=
 =?us-ascii?Q?c/A2J6/qHD75QuEo8r7k9iP4RQ88wnMnqNcqxPOM6cY3SLCgnNfY+yj52KOf?=
 =?us-ascii?Q?Sc98h51ZyqMU78us+WI/u0C9LyzrkXwzIoAKujFuauO8TTdntj3mq2TBxMeQ?=
 =?us-ascii?Q?wVzpKhawxOPHQLByVyas5kHh+o7iE5Nbmp9rpagXPbkgKtj0PRNCaiHvTHYy?=
 =?us-ascii?Q?pgoFNl2We4gTZ1zcSpiHf3gY8IXrfO0XVXxFiBlIQ191mPdgEWlO11KSLgN1?=
 =?us-ascii?Q?mDFTnD6Eg33E0SnpuRTkIlJLj7fTirRKw2/wGokazKkPLnz7kazyBtuM83F7?=
 =?us-ascii?Q?sK8sKJNIdF1XMiTOpAVEKziTDa0XQiYc4KXmprbDtzHbJe3Rf9abCtpGOYJH?=
 =?us-ascii?Q?lC9F1RVTR3djc1ofQoqWeds1rFpvYR6Dzf2qrhsza66+uGNd6WXyvFAmUtV4?=
 =?us-ascii?Q?LHVmLaqOd2+rNooWLNi8vYHae81PnO0jXIPJaHPvdzAI1Htz10wzO+SA33/a?=
 =?us-ascii?Q?TxL80+rzxJBW8KAzNRC6xS2Gg+LEdQE4Y53kPVdvlGlDodRvKRMJifogNCfr?=
 =?us-ascii?Q?OJ1i6GJgtwKCbRBUAQyab2gre46hCQ666wyD7Apq5kfFBYI/MzfEmN+rco1v?=
 =?us-ascii?Q?M+IBTHP4X07XblZSF89cjaQDEEoP2tOtYf3TcSmXV95JfXZDoxr2NXi0uiuD?=
 =?us-ascii?Q?kX572O7uILNe7R7/Qu5sqHiXabJb7LJKX7qYtbvqz0Uxg/8tIs4kumd0FVO1?=
 =?us-ascii?Q?boiFTUvVZsXDlCpNHTTpn/bHlxecYFljMkSAdArQPI4GPRXm9Wn1YWH6YhNP?=
 =?us-ascii?Q?c6vNJQ/KCj3SgGk65GXmUfo4vYltOARLzdsosVlKBRemYd8dT70yKWAiv4ub?=
 =?us-ascii?Q?p/p8QKYYcPsJe/7gRRF1ESPRnXPdbRhlvdMuc77jjFhY7MsFT3usjavIEk4s?=
 =?us-ascii?Q?9APV7N6pJ6Nt4fJST4Azl/55qtx48PGlJqfz5QCIRCIcjGorKVUc3POBYj+X?=
 =?us-ascii?Q?AlaLa+GDBAyCD3zNbefo+1OEOrRgJ6LlQQceOtsCKhKiNL5YYXYaA26CFCD5?=
 =?us-ascii?Q?uvvCixY6MAoN95dPUdPQ3Y+FL/uMZmEr+ds7lmjQFcspNpM7Ne3lqpspCLD2?=
 =?us-ascii?Q?c4w9/7ktCA2OBwXuHc7kKwHsyLNBwICENjZZeaKBRx1RzxHIfGMI8GSLxYKO?=
 =?us-ascii?Q?Q0QEB9z/j0Jmmc5o9qcvF3Y028ApKbsT4Ntsux/L5QzT7aO6L8l2k3L67vxi?=
 =?us-ascii?Q?vcq96Q4lXPWZN2nhXqXr+aVvptxJyphhPgcFWE4+sRaamHfm83CnMxOxGlne?=
 =?us-ascii?Q?qFA/abvgnTXPb19Fb1RcDaqBlnrtVjAxYx+E4UmdxQGaag1DEPtyTfpXmpRT?=
 =?us-ascii?Q?CoRgC96dWehDA8aD3P1hYOD57+rGRgwOYX7BR4eRbuzlfjpwYX/WkBWZASxY?=
 =?us-ascii?Q?p0awPMuwu/t+Y6dYkZZZgmbz+SKjb3zgCzepvbOIL0UMBEECT/Xd8qBWTsSE?=
 =?us-ascii?Q?3WwWzzpl5wX9sXEj+gggWpN0kAfCOns1RsoXnLQQN0tDCGCDgnexnG9dPvzr?=
 =?us-ascii?Q?c0c9FbI1w9qvVbjvcegx5thCwdUKDbeiJDJTx7p+3d+RzuW9olpITBST0z5K?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e17fb67-e9f7-4cc5-c22d-08dc49c1c6ae
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 16:12:59.1765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zHpHGU6JAieIlYqNWZ4WRU8sfjPMv7ghsazETRig+brzdcrH48koMmJNh93eiEg35KuqgbX4Pyf5oyC8Z+Buqb6PEEp/XIEVxXxIHMJAT8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9956

Adjust the SDU size based on the number of locations/channels
that is being requested.

Tested with patch [BlueZ,1/1] Fix crash in iov_append_ltv function
applied

Waiting to connect to bluetoothd...
[bluetooth]# Agent registered
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x065f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 3
[/local/endpoint/ep0] Supported Context (value): 0
Capabilities:
03 01 ff 00 02 02 03 02 03 03 05 04 1a 00 f0 00 ................
Metadata:
[bluetooth]# [NEW] Endpoint /org/bluez/hci0/pac_bcast0
[bluetooth]# Endpoint /local/endpoint/ep0 registered
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 3
[/local/endpoint/ep0] Enter Metadata (value/no): n
Configuration.#0: len 0x02 type 0x01
Configuration.Sampling Frequency: 48 Khz (0x08)
Configuration.#1: len 0x02 type 0x02
Configuration.Frame Duration: 10 ms (0x01)
Configuration.#2: len 0x03 type 0x04
Configuration.Frame Length: 120 (0x0078)
Configuration.#3: len 0x05 type 0x03
Configuration.Location: 0x00000003
Configuration.Location: Front Left (0x00000001)
Configuration.Location: Front Right (0x00000002)
BIG 0x00
BIS 0x00
BCode:
01 02 68 05 53 f1 41 5a a2 65 bb af c6 ea 03 b8 ..h.S.AZ.e......
Framing 0x00
PresentationDelay 40000
Interval 10000
PHY 0x02
SDU 240
Retransmissions 4
Latency 20
[bluetooth]# [NEW] Transport /org/bluez/hci0/pac_bcast0/fd0
[bluetooth]# Endpoint: SetConfiguration
[bluetooth]# Transport /org/bluez/hci0/pac_bcast0/fd0
[bluetooth]# Properties.Device: /org/bluez/hci0
[bluetooth]# Auto Accepting...
[bluetooth]# Endpoint /local/endpoint/ep0 configured
transport.acquire /org/bluez/hci0/pac_bcast0/fd0 c_bcast0/fd0
auto acquiring...
Transport /org/bluez/hci0/pac_bcast0/fd0 acquiring
[bluetooth]# Endpoint: SetConfiguration
[bluetooth]# Transport /org/bluez/hci0/pac_bcast0/fd0
[bluetooth]# Properties.Device: /org/bluez/hci0
[bluetooth]# Auto Accepting...
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.BIG: 0x00 (0)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.BIS: 0x01 (1)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.SyncFactor: 0x01 (1)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.Packing: 0x00 (0)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.Framing: 0x00 (0)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.BCode:
01 02 68 05 53 f1 41 5a a2 65 bb af c6 ea 03 b8 ..h.S.AZ.e......
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.Options: 0x00 (0)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.Skip: 0x0000 (0)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.SyncTimeout:
0x07d0 (2000)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.SyncType: 0x00 (0)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.MSE: 0x00 (0)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.Timeout: 0x07d0 (2000)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.Interval: 0x00002710
(10000)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.Latency: 0x0014 (20)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.SDU: 0x00f0 (240)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.PHY: 0x02 (2)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 QoS.Retransmissions:
0x04 (4)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 Codec: 0x06 (6)
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 Configuration:
02 01 08 02 02 01 03 04 78 00 05 03 03 00 00 00 ........x.......
Transport /org/bluez/hci0/pac_bcast0/fd0 acquiring complete
Acquire successful: fd 8 MTU 0:240
[CHG] Transport /org/bluez/hci0/pac_bcast0/fd0 State: active

Silviu Florian Barbulescu (1):
  player: Adjust SDU size based on the number of locations

 client/player.c | 8 ++++++++
 1 file changed, 8 insertions(+)


base-commit: b8ad3490a3507476844d6c6a87b2cb336f7d4eb9
-- 
2.39.2

