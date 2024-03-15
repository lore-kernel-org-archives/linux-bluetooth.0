Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2053.outbound.protection.outlook.com [40.107.14.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303AE3A1B5
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514945; cv=fail; b=OS3XUF4IrJwMV+V3qJ0A3TXmFIz4nTTjTaENN8CenNFFBbE6g07A0SPuq0CmHMLL2jUte5UQSiiZUVzXBj/hwzS79EHDKAjl6RbzRQoLnFV2fFjcyDrZH7/2xWIpIahJMtmy+mfc6Fb66AZxn/c16TQPVfH7Gr10vjulDobaiXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514945; c=relaxed/simple;
	bh=diZcbe/4DVTmrhAcDKRHpJ85BKSl7dS5TNNAlUnXjQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oqGbKNlHpdZRMugeWKqKAMDK2tzJmaoF8WykXMOhYgQQJ56h6e1iysQYvqADZ7O+l99B/DdH1omX5daBc7fREFGb/rwfN1YTMJ9OCotbFDzzP4Ab7RLWVO+xkd8Fg4OVjZMtXedc3+DLtqVNH4efNMhEHn7kvabSb4TzW7i6zCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=n8MX2aeg; arc=fail smtp.client-ip=40.107.14.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="n8MX2aeg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0D0DcFofg9/N8GWde0+4fDhDXgNBnfeGei1tgcGzcFqKCg870TFc08KyZXC2dFxCBgOmmjSVAnlsjcQDNId7FqxOl/8Cd9ZRcG4Eo3T0/ITZGzk3SWOiwwg6VS2BHoWJsseoasyrzWKBPrVbnRDh//c44PpbU47kKg96lBgUyeEANKIYWjfKFZSnmfe40T5JeVpZi0dpC+zH4GkIPa05WRYZ07H5FrDmXvSGfJGxUFEFxDFJd62V1MR02+6QwfEKJd7ZogxgdpbGYPmGdGoWN+0yT9ulK9F32jFJUUTpmF8ADkOQefZu+OcWixSmWs5B6fvBIxx4lngHEhoAHCVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdPRj07V4Nvi0AXGlCGhhGqk0UM3AgixBMBG/fYMU44=;
 b=lA04cy2KmXNQaucRV1Bx8wdRTj4CvIoIIKsdhMtvoK2yVDGR+rLhtdybmUY6ZVTLjbD9gs6JZrD2DmALFoCxsnPR1S6R+Ee3YgAWjaMreoe8vIiymjJP0mduFhq3iGROPEPqlCdVVBWGd//Jda/6qNVFPhAfnNshQ7uLoWYviW7XsMzcalWwHmw4h4fJAjEFB8FuLKGKzzdIL6UYeBcDYXN8sAUqaacpwQRkp4GYEvInGnz9i/rbhFDTc868fFqodnqEON4tzUIJaLhLtFpJvsS7u4DADNs2rC3aTQeK1w/2K34I34aEnM99aRernTQTyZ0r0Wn+XRzfM+bf7y/V1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdPRj07V4Nvi0AXGlCGhhGqk0UM3AgixBMBG/fYMU44=;
 b=n8MX2aegJRHI8xI8TZpWkX8K/tLYC1WA5SrMBiMbMFhK0vUzqt79r7uYPD82Xc9N1Szwo3H63OAHWURTwA51wDuvA8ocO+/bcJ26jVsbUX9V1bUz6N3hd/fWhS2Srft6XlBH2Ikopywc/9FafO1DPycxKeScb+c35AvOD8yL5Ec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 15:02:18 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 15:02:17 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 5/5] client: update bcast source script to support BIS reconfig
Date: Fri, 15 Mar 2024 17:01:58 +0200
Message-Id: <20240315150158.79715-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240315150158.79715-1-silviu.barbulescu@nxp.com>
References: <20240315150158.79715-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::33) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: ecb08890-33cf-414a-7762-08dc4500e836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MjcYp+WT/EMpB4q/aoYsrUfDA67TbmpUYsVrmaPb2gUL/8oWZ+ZY7Elpx3J0DKHjIgLP9HgEoIG+Zycaf4ANKBor+B21sYC6cI542HQkrUGzQJ4TPKG6zXAaxnti6au7UASuxwHuCbPS+rUoRMECRAbL5bX3YwBPgoCikuiuUpmc9eWJzxVpm73Zqf+7iGDv/cw+i5ENxn8VPChXBQqERLsx1kxfVWAHqHyP2StY8DjyM/mV60zXjvg0TrxkmUkE0dfVJdzt8Srd2H2BwqHI2W2MgkXMs6QUs88dJLH/8jK1qe/MqyDwjInWxP2kNVgFd5gnbx2l0lF2DmJrHqM0dJep0ZkpiD+kZUsS9+kBHYNua/HMOmdcnc0PYNKGke3QmgjxfNjzcy2sWdANj7abAg1n1wHuB0BJE3Oo3DEZHmyZftAlGbpAE+vDC2la6Y/MWy06DHeTYOrgosvoH3j4LmQ6V6ZBMQPkk27EIL4hH7HWLnjej1SGZzhMLEiqJyRSFLKUnZ8pkOY/2X5Tger1SDFmeqCyedyzT7M8EvVuMUOJ+ZsPyaqSkl//1h5PG0hJtTqqsWAjQhLrOYiEFYX0Bet5frtYaszGoHoaAFcoOgIANVqaqx2onAXNyanUcd+6GSx4elIxBAdWMt/xk+X4UzWMWdAUlG+N6hiU4dbagBU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZuY2UtzxWgtJzk0BCim6QuAst6QAAB4hcxLwXMyW8SY3xSXKFpovdHtros+W?=
 =?us-ascii?Q?8Cpiv0R/KNoVLO32kMGjPZUnN4iWWOHr58Sv/jHflGd0QuBLIPT8DvA4vT1h?=
 =?us-ascii?Q?zCtmq9Dacangx2+f0rPCXFXFOXY5+z2t9w71FCuiNRcGtdamBUUYTdt93KGg?=
 =?us-ascii?Q?uBmq4Frv/GI0WpO07iEwdK4VhPWC6dSYWcoV4I9N9+mWYPBkSFNBhnRQCW24?=
 =?us-ascii?Q?QVQq17jTfxht009vbCUbLzLhOmYYja0yYCxTW55twOFNktd5ELrK78nZvGUk?=
 =?us-ascii?Q?8q6xWpIyZuZWUV8wN6B1/tsdCaVfo6pzeUgBSwgmS6xnPcrxiWXJNxvrCIIm?=
 =?us-ascii?Q?g6jAXOfChLBb962VuRJhGoCLtUNXmbTs7gT2u7NvNHtH6R9dQhzxc/jaN/F8?=
 =?us-ascii?Q?c/zv1/+aQMDRzlgDJrjoGpxabOE58a6QNsGZ6+inh+Wf8sGu0t0QO2R+XHPL?=
 =?us-ascii?Q?VH9ReQFljcy8uHzXry5CaPQzcLrPWJWvW78GaZAx8/Gp4MlFRO5ET+4Qo6BF?=
 =?us-ascii?Q?/CZU2bSgMZWf4ADbWFzIhtHcEAT5hZpEKBrL84JS4/ZKp0eAxDm6hb3QbAic?=
 =?us-ascii?Q?Q2BSb+f5Bu9XNfr5ebEQhx7+ei8z8Xhstq8iCIv6eK58cxuxsX7LhGIwHcGB?=
 =?us-ascii?Q?+AabmJuccCiQ+/1zjoTL+36TgvYbXUFslUQDa44CMivTxjt6f2u/gI1qmlGM?=
 =?us-ascii?Q?Cds3o/3CD1EqWWBYAZT1nlQ1VgWwFD4bUQvO6K8jZMo0eCtp4Oax3uO18LiD?=
 =?us-ascii?Q?r/zlU6F6niyRaH+FxpwIypPrPL70Bc4a/1RnhvueoJ2bZf4fsyi22YmYeSDa?=
 =?us-ascii?Q?jXXVbBAu6+OcSlgI+QFG1aZk2yc1kVAwxZd6deptHXzGUIDrcJ8PDer7QZXq?=
 =?us-ascii?Q?ai51E0MVKls2dgtnd3xXLlOuXEq5I8wvjurt9AC3C+BJ6YBCUKhgpHBs6sf7?=
 =?us-ascii?Q?i067p34+aU0ujoHbhD6UbLqK0cNhPmyAtw+/w8/7fJ9hwwRPiZeHrv9pt0Ji?=
 =?us-ascii?Q?01XkBcghUyxPtTt2StG334F/7pzN1ZV8xgcdS3m2O6LU1fu09Fc2vyslwVLa?=
 =?us-ascii?Q?+HOMDh7+bN6yLjpj7JlQxT65qgwu7L/LqgdBlzKemAx4oxPr4va3HXZ+c+cI?=
 =?us-ascii?Q?gDVC0G583d3Vu7jG/kU8kT9RMxSJCCdpCnpu+6ev1epypP36mTp65jWYVYX7?=
 =?us-ascii?Q?klNuy9jWqHEee9UkT2ruW/3JjfKGen7FY9sH44LIeBd2ZCg7Q1uUdovQM1QN?=
 =?us-ascii?Q?shTnwhhnnso3sDthHy9pXiYcxEJyjbJ9HT4ss9MWOityWJatzltL4xMCWmGw?=
 =?us-ascii?Q?qpiaMor92Yz3yqA38zKO6RLUp7kd3UlT2GhtJ97f6FOAkOvMUHCTQj2gpYx+?=
 =?us-ascii?Q?doqZ4hiZBXPgvEE3h1sIRm7sgxLAoPXz34DtyXo08KMwqWYb1wMxgP+UzCkY?=
 =?us-ascii?Q?8Z/JS6A2wKDaG9E8B6d5tc68TTzronY7O87tz1f5Fa0WgMFOshfqR8Ik2W8e?=
 =?us-ascii?Q?PJu1f1L9vWFi4xBS1VR8PLBV0ZSMDKzsI8UPygPN8ar+hFS4cp5dcanCFNxF?=
 =?us-ascii?Q?Pl/gg0h6dq772D9t+PXLWAPhjkbOYO7gEhZ292+6c/bd4GDSZp6khAYzG4+J?=
 =?us-ascii?Q?7w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecb08890-33cf-414a-7762-08dc4500e836
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 15:02:17.8961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /HERGKP0yJK7BHmKRzs7Iz5skAzzwYCy4gq77oXgwCSgn7rjDOp8qHquaAdWg7hEGdxDMvbUyrk2prpxrloTonUrL061f1kVWtEMAPrf2gw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

update broadcast source script to support the BIS reconfiguration

---
 client/scripts/broadcast-source.bt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/client/scripts/broadcast-source.bt b/client/scripts/broadcast-source.bt
index 6da9e23e2..4fb0c3920 100644
--- a/client/scripts/broadcast-source.bt
+++ b/client/scripts/broadcast-source.bt
@@ -5,7 +5,15 @@ a
 3
 4
 endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
+0
+1
 1
-3
 0x03 0x02 0x04 0x00
-transport.acquire /org/bluez/hci0/pac_bcast0/fd0
\ No newline at end of file
+transport.acquire /org/bluez/hci0/pac_bcast0/fd0
+transport.release /org/bluez/hci0/pac_bcast0/fd0
+endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
+1
+1
+2
+0x03 0x02 0x04 0x01
+transport.acquire /org/bluez/hci0/pac_bcast0/fd0
-- 
2.39.2

