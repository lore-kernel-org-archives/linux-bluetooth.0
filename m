Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873D327584E
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381246; cv=fail; b=WcGnE+gz/G2XhA0OTkMyWklU2SxT+WIuJUg7wTPDfUG8yS+az97DiAZJVIbxjuwE1SnrfF4Yarme6DSbU7tApnfPH5ng1NuE0Ro4BwUD5C1oNm1yYkTxO93ewX081c/9n+y1E6Zk+85PqsFD7eegRQW1/ftiZMk6Jc9/KVD61P0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381246; c=relaxed/simple;
	bh=Vkc4V6CJAESZRZrmf/JLUMsGYfJaFHZmxGwYXxvPS0w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AXtpuqp4ckBf1R8En7Z4aonQAH7G47CgHo+47aT3Trv12GRysUwRx4cT7u3gXvU6NIFVVnkSr/S2i9buby/CxSMxM02nWUPYQO10ZpYvzmkxq3TQXIYIwfeUGildSSiPBGXedL7kdEIPht5GAELxthjmOVMeXSHUt+bBu7pWm1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=b9BpxOIS; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="b9BpxOIS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uqGXQXVZG8qN+zYF4RoCGOxMBugOMSwM0uvdJ8pEAEad9tfjmn4RbGkXFhPqWwoBG5cNyBDlwIUXtPuIn9vbvLQWL15sIVGMVjG9NZFqMznbqk+Leh2+JBECDsvGBOobVL270ZSKQF9p2pfWdX8I20HHYE8NUNBF8Y6fXkxZ6IfyfvRc4WbJ/fp9WCttB4r1OGHxeGBDvXGLqNe/5HeylsYN791LbrJsrpcbzmrnTRmIfHoVXNYMJOufalQNOPTC+WjhhKJyyOSnu9+RF+2CHDobSgMkGkjxirAUqSDRyjyOlPfn83HYNzoPzYyeZFxH/CBB0WQme1EuBSwzq4aKpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPpCiXMUcyq+yYShkdP6P8Vknfq4MjKoIwmmmETaOrk=;
 b=sDds16lNetlMpKpI7Wc0NDxha7+h8VL9+d4cGPEYAzRpplV1P/m2msJkufjntcXjldfcHdzLcwhaCar8vDcrqxSnbrgnnNt6H9qweV1aTfBgqeM1LE17IiECm49holgiywI8ee09qfIRnB3R9rey06gqe1JFTE/m6sgMV0ziX3vOe+0+QP5devLGj/1yU7h+8YOxj8MPzjI1iP3GsbkO27IhAF9PGb4TRwTZ9Nu6EORTJTYufgtL9DGkBBL7VvGk4oD69lqYuQTnntpLEsi8g32pQPtc0L3jddD+OgHaJmyYhtUDcUTlxsaz0hIxsppLK9oMUSzoQJ4mhiwl+TNLJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPpCiXMUcyq+yYShkdP6P8Vknfq4MjKoIwmmmETaOrk=;
 b=b9BpxOISmfjJlTV+TgenSjm74t+pa9rw87GRT11JSauaMxeMXyIIhXBS3v1Ib/l84hECJVupBBX5uuR8DncqBwRxsxpDCSWBVBMBhbrJgPkdTLGRsWL5YgyCw33bXRwpHtUR3Fd9g9VJ/vUfCofdm/8RDubgNfyoVAHl11WvJk8=
Received: from PR3P195CA0021.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:b6::26)
 by PA4PR03MB8246.eurprd03.prod.outlook.com (2603:10a6:102:26f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 14:47:18 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:102:b6:cafe::af) by PR3P195CA0021.outlook.office365.com
 (2603:10a6:102:b6::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 14:47:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.1 via Frontend Transport; Tue, 1 Jul 2025 14:47:17 +0000
Received: from N9W6SW14.arri.de (10.30.5.30) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 1 Jul
 2025 16:47:17 +0200
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Brian Gix <brian.gix@gmail.com>, Inga Stotland <inga.stotland@gmail.com>,
	Christian Eggers <ceggers@arri.de>
Subject: [RFC PATCH BlueZ 0/4] Initial support for GATT Proxy Service
Date: Tue, 1 Jul 2025 16:22:19 +0200
Message-ID: <20250701144647.19572-2-ceggers@arri.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|PA4PR03MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: 64000f35-5f32-47ad-dfc6-08ddb8ae2ce4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?juQSIGb6DNaI684vCNPSsJMk9FkTijOVai4fZdd5zqvNr3X1bYwxYoD0aDN4?=
 =?us-ascii?Q?Ukp4rByA3Jwke7cayS9q8fP0ocHp7Y1cVuUKR/nu1usdE1z013vo9FI5HzEt?=
 =?us-ascii?Q?UvG41aqGeyAz+L5JlVHTizLfzHYmID7kUxREJxc4w3f9uJFfr+HKj4Yw5vqG?=
 =?us-ascii?Q?BeWsWDVRIJZYW1TBxDanbOxN2Erf1qZjGurRsvC2C+jzFD70FCAuFmOsOnCh?=
 =?us-ascii?Q?9BPAEDWUalDwKLa4yG/+nQbRjfwzyYLXXPlgVm4Mcgpuu6rebz11AogegyEJ?=
 =?us-ascii?Q?xvocSQCtisieG0fVcXTY8/8oAKRyYQt9ucu5t8Ow67A+TpCd4ntJbkqkFwQx?=
 =?us-ascii?Q?4Zdk0YVAtdMzq0ljVA9BqCyPGlmq7kX69F0EETeGaWQVllzM1gGM2FK+W+qz?=
 =?us-ascii?Q?PWdpOaoDKJiLOkSGBWUc9FSLaC5/FdLx8RhCA2KN3nb3hM3TXKWY9ghfZwzF?=
 =?us-ascii?Q?VBw8QztfhNGVShInITibvxm5bgMRzAs9nrtPQfUJsjb96BNu2/HnKOBsbxYx?=
 =?us-ascii?Q?brD0IzqwbBwxEtX9B7ZWX4XGyLsNmyq8vnWB7qz1VbTpFSs5V3g3On/W10aX?=
 =?us-ascii?Q?bjwTddpWRE8oEjO/H6kBvHDL2csQtL+aFw9wtoiZDSL6gTgxQ0ck2gFHRtr6?=
 =?us-ascii?Q?mXAWhfQq6rZhAR7QgwzmZLibuXP1W6kOXIDpnAf0g0Fqxe81ucxW07QxFChm?=
 =?us-ascii?Q?GKjULGAAtz/rJyi1K6BIW24avkT7KXYNf47nOeV2Rllv3bfsswb05WgY+pjq?=
 =?us-ascii?Q?A2yOo/TwFhROsAp9gSt1x0d6xaqhHqZ0PbIUFfWitcINdvlSezICCxEwgLgO?=
 =?us-ascii?Q?ozeLijRBT/ITXpp92o8KPmLorQFFAY/sLSA9Z0tt6ELzExJzAQHxFbbNMR2l?=
 =?us-ascii?Q?gRHu0CauD3XItk9cEOXCyqGaSkhljm1BVkD+raI2wF6KdLGP5aTkb7UClxP7?=
 =?us-ascii?Q?UdNVSL/cqGG43bB8gO5ax5+sH1CGTkJ2BDixEquZcfGQ4bzP3RKwPMxtYuuT?=
 =?us-ascii?Q?OwYuussc6tANJr43uROLuI0ziIZ707isD2AicOwRurItk5swKROMjgXJQhmx?=
 =?us-ascii?Q?gAixJjomg44C44JJiA+djjw6rTn6Kpr8EIbgKUSctQAPW9Fc0cplKHXGlulJ?=
 =?us-ascii?Q?yCdlcxjnp2nlQ3sNd9qDTORE7H9kTPlq90una4cxFZFEA66vu0qe/+2ikOMt?=
 =?us-ascii?Q?eCH+JtJ91Oi/TvspI40775WRMa73FbtvLdBuhyQqcJebmKp6L9RAJmcELRpz?=
 =?us-ascii?Q?qEMg8eV1A8rdw9an48Or0yYRng8Pw931wBxIz7bx2LaoAl/qQQpb9qvNcGtB?=
 =?us-ascii?Q?3ld3EZNiDl9mOmTe8ygTfAZ918f04TpRlSXiScu49y0aY2WWUuZxlu4SZ5yS?=
 =?us-ascii?Q?ALVBMAUdrYSvOnmWr4mi/XzU3dPks5dViHEkTfb2MrkLeoZ838VUxZJw8lgC?=
 =?us-ascii?Q?h731br3DQPmu5LetQiW9iCmj5owODK9l0RA9FUM4+d3ueP6zssZOFrjYkKNB?=
 =?us-ascii?Q?C1CEuz5rBvIexW/Y5n7hgnc7HsQrIWz41gXz?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 14:47:17.3088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64000f35-5f32-47ad-dfc6-08ddb8ae2ce4
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR03MB8246

This series adds initial support for the GATT Proxy Service feature.
This allows provision and management of MESH devices from mobile phones.

Before continuing, I would be happy to get some feedback about this initial
part (and about what has to be done in order to mainline it). Any help for 
doing the missing features (e.g. relaying between GATT and ADV) would be 
highly appreciated.

What seems to work:
- Provisioning from another Linux computer via meshctl (sometimes I need
  to repeatedly enter 'discover-unprovisioned on' and 'provision <uuid>'
  if it doesn't work on the first try).
- Reading the composition (composition-get in meshctl). It looks like
  meshctl tries to connect to the GATT Proxy Service automatically after
  provisioning, but I have to enter 'connect' several times in order to
  get a connection. You also need to manually set the target unicast
  address ('target' command in 'config' menu).
- Adding extra network keys (Advertising for GATT Proxy Service cycles
  between different network ids every 3 seconds).
- Transferring and binding of application keys.
- Using the OnOff client in meshctl (you again have to set the unicast
  address in the 'onoff' menu).
- Provisioning and configuration of an OnOff device from iOS (using
  the SMART+ app from Ledvance). This app requires at least basic
  support for proxy configuration messages (patch 4/4).

What maybe added later:
- Proper selection of the output interface (GATT vs. ADV) when sending
  messages.
- Relaying of network messages / beacons between GATT and ADV
  interfaces (in order to access further devices via the proxy).

Note: I don't use the test-join script, because python3-pygobject is
(currently) not available on my (embedded) system. Instead, I use a
custom C++ program for the 'Join' and 'Attach' D-Bus calls.
