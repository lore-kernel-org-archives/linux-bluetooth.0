Received: from outbound.mail.protection.outlook.com (mail-vi1eur04on2059.outbound.protection.outlook.com [40.107.8.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40FC37711
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710765457; cv=fail; b=HnBOKaubV2z6NDDKafiWeYjB+LomKaTzMpfvKBv1ESdeFM5HzSQYA37WovmyxqWQ3hG+BiBDWl2+o4fRFzxXSoh1vpUZ6b7Do6MzZoT3xp7Udkf5XWKZ4eA827sG3SXvGT/mx7uNezs5m8JqISxqoC007yApS0EZ+RlzxNICwCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710765457; c=relaxed/simple;
	bh=E7sl4DJ/MCUpPetSGZ8Nb40otNmK4EqJem3kp93NoEo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=XDtJV4TyIjVgWOjjek22OHBZughQrPYIHJhsxbpT1ehFgc4Xnz2faKXf8w1Gxp+xoS0urJvb4sDljb03p2khDkUs3mVy4pM+DEb/x3koLODrixboh3hLVBZpgVAAjHYNCKxQPiwVL93WjpCFpANWzF3bChAGVkiPUMR80K2koHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hkebKkcJ; arc=fail smtp.client-ip=40.107.8.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hkebKkcJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQQgTzVJ7aFt+JKUlz9uFRYzma/IJ8TiZwJHHUAgnZv1ZvFYmAUrzou2jpQNcO3Wmd9ytsDSQV6BX7VZHTM8rsZWvI/BMRAQURORG4GfYJlcwideAmdWBHLRkVNmO/nVydRz6j4gWdXhZfwnDNCcGp01y95AN7JNaOKeKehdh2l9sggIY7pXYyEBEcN1ibs2zqN/P73bWN0gn4K/72rX+dMhE2cq1d2WaPjv2omxRdYpZf4JpT+5VEL8mB75DEfVVpPmeX/K3q45N46NjXL1ezbK/3/eozzor/+RFO7m0ejmd+OWh6KqDW3H0tMiVcDOE1iGXz9nNgDrLQOSUYZLNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECdv/AZ5Wwy+eUuf1KyM5v0+65lO48oUaAJJkgPvLu0=;
 b=f1T/tdNRVmtCn+fqSsiur4/EooA/Kv+WMHyFpcH0qLpLPqTyZS/hoNeqjw3ImOgXMDb77sbzBrx+qtpJJHvIfxEcg2oI7ueChMlAF/XCidiDm9NzMiOd/c7Vq5owHmvrJBzACIu2Ln6kXnbvETAQHUKqxFRKohtlyWWi8s2oRFhWv78h1FUrik1p3kO7B/UY7nU84QzSLJ0KsNNRXnV+u0nMwfxLDx9mMeG36RALvILEWVXaZxOu9kdxV2EFSihm4sS9yUmD6FeuXnaZKGuQ42X/a4j0p2VQbosTxUV4JTHMjvhg6wBwXvbljTUsHgvSY+TdxdSsLwmUaOW7pJhg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECdv/AZ5Wwy+eUuf1KyM5v0+65lO48oUaAJJkgPvLu0=;
 b=hkebKkcJ+jHkqdLgZxo76Bs2Rs8BtTy0W4IjC5olEljvv7X0ZEAYF4eunXKpKfWPc0agw1wtpV4Z48xyR4DR7Lp+K8BstwyJn8bsBUt3Mp5AeR4w5bSKINwbVCoSJATW3vU2eeTMa8uPFrWWAhOwnHUb/YzG3tJT7EuVqmrwXaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by DU0PR04MB9227.eurprd04.prod.outlook.com (2603:10a6:10:352::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 12:37:31 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e%3]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 12:37:31 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	mahesh.talewad@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com
Subject: [PATCH BlueZ v1 0/1] LE Create Connection command timeout changed to 20 secs
Date: Mon, 18 Mar 2024 14:37:11 +0200
Message-Id: <20240318123712.9729-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0033.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::46) To AS5PR04MB9754.eurprd04.prod.outlook.com
 (2603:10a6:20b:654::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR04MB9754:EE_|DU0PR04MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c0c39a-f344-4850-d1c6-08dc47482e26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	62DRtfEAx13W5MGqAIik/NWfpdAFGf/LPRXMcNlqkL1U/1u9AJYlHMJZI0E80izNf5HA1IsOmqbly5hPaSqMM8V8G4ktZkIZwflt3aQIqlaGM7ClNCNkBU4x2fDNru0wNQdVTlyUOXCmNCmpv9vslfizfbB1i1Pc6K31hCWvOvp9XinouHDuiuC9DHHxyBxmobjnbtv+bnE1cSXyYGriF7YzAb5bkWxzHqQFZ54kTibzfjjmworm7wt+zweYtE3hRGUufFMlzeuSwHi54IehYpRKiDFlm8Bce7Ihpbzwmvq6XHogQqKXcGOLlqf9u4pkIJttWLOP5b46WXoZ9GGPRI0uY0C28dIbxQ40WIc1tOkC7Gjmja8dGf8bT2fgbFrQwsVhbNqBeJGhlT4H3HalyGS3sLk5tllK0y4gsidQiM4HdbLXw0CByqy1g7YUJ4SrE5Tq7wxztg5fwzInPFJlUmHbVFhlDt6KrRRbGCdkBiIUEJVUGOwIlyE0cOoAIvnQGIhvXRP4UYme0YRha1HBwZI9P7S8/Ri7+8lBNdHEmo4JJyd+NAQ2/BeYGQ8Gvn3hAtETeJeCfy5geY6bkqV6g0+whjWOhhigZfeBmX6FVJpooC/RtjRwUOdfcFx1bTEoUI2xi4zsMKbOhwa0p40RdyfcOQPpp3hj40HOzgpQtAL401Whs2hIYn8oNBQ1vj9ei3SBzTpO6HrnvGxIBMJmww==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7RI+y1PdCeAAIxeJCL8QK8cfu/bp8cLSCErt27Dlh0+4KCAmdsi15RRJLczB?=
 =?us-ascii?Q?sXakZ2Hs23UMM6a2459dLMxPPcVQ/tcUOXF0NFHb80F4852gTNWDUOi4Mdk/?=
 =?us-ascii?Q?VndS9SuDPKkmq8HHsQWfiJFKTmjEJsfjOFQWdu6QRgn+X5ynfvQ/SLk32H0C?=
 =?us-ascii?Q?KnI0H6A8vpJQ39Fe59+PmFzs5KER2HMDfhPJcwLei7Y0H9rEPtGP/yNAhoqD?=
 =?us-ascii?Q?/K5J6emMhkw9Eljbo6W87OGljPAGv9ACXo29nVDNJTvB1p+LkoAnNbGtUtBL?=
 =?us-ascii?Q?x+v/ZoISXCuMZuE+mTE4VxHG2jv38wFu8q/s2KQeTbJyH7E3auAXxHUHWT1d?=
 =?us-ascii?Q?TPoKeUham7Y3bsSkdTLVZ9ZSdMSnBPrQOOYogiXo+ZZtbwBJtghRdqHSOyZ+?=
 =?us-ascii?Q?vlFXmfOFaFVtE1lyLEkvTAKBqODAqtmP+ztRd08maY4fBTNGfXiB1CKqfrzJ?=
 =?us-ascii?Q?hUWdT4dNJvTKvRZXGyMlcct1jv90uTbrOqGW9RC2E0bcgn8aXNWPuRDG3y9G?=
 =?us-ascii?Q?TH1TakAEBbP8Mmx5XAZSQNG52pIyaVQ1txnMyawqORPmYZH8ak8SOBTNoptZ?=
 =?us-ascii?Q?rICm2GpWMGMOUx0+ZLwEBtTrNzREKsdULbXKXVBDF/R8wE/5XsX8G2ItLje+?=
 =?us-ascii?Q?s/ZjzzX0X6UUrT68EKTKha6D5LfAKx7emIBIZ+kn9LOeU7tPzxcvpR1N2Xk4?=
 =?us-ascii?Q?6pWZzDVUCPhU2eg5KKMwEORNiIPHU8mhmP0eVcSLpr/RmLZkfo8YsLkf9rR9?=
 =?us-ascii?Q?0Aippo3uKWG1X/lFIXJOsHQDNZQDLn/1gunQbnmEcIeZI46oFL/9PZ9jNPzF?=
 =?us-ascii?Q?onc1mLk51BjODqDR1IKlY2QE2Tju7frqGszrUYe0QsbAkGrNucTXWnVOHdpw?=
 =?us-ascii?Q?XAsmpF7gS4kVafLCKg9wvy2Ie6pIh6+xB1w80TpIv6pO/NjixYQf4CGM86xv?=
 =?us-ascii?Q?bIW//6N2LThVgBOqeaFxqMkHtqhouXAiiP/z89FfzKznnUV2F4L8WPY/y1Aq?=
 =?us-ascii?Q?SD2vaBvgNzWNbx4gQs/HeF9D9qKJqIQYgcPtds4xYpOGSJbLp7iCom0ro7pv?=
 =?us-ascii?Q?mcxZfIFnX7rJJWXTyhc7GXlSLITGihKzFPHsuW5QQzEtq4IxF54ddl5YVZTl?=
 =?us-ascii?Q?jNDeWJ7IlT1+a6BRheThrYTpHcBerv/tmlxJ6OVpNhOBhLVNxvCMSnhGnEpP?=
 =?us-ascii?Q?rL4DJWAzSNSIfKJHO9UK65PfJpHT0C2bZHlzHCzHmsbg8cgHlA7fsOrDixmz?=
 =?us-ascii?Q?5ifuWjflNk6CobbLpW6lebLy2MXzp1H/9SeldkcrTIUygt7wS3JsgtBJHlqW?=
 =?us-ascii?Q?skwpOXZEy5SW4SfpJi+1SjMTYzL6e0P27JVADfGY0iqV0r+GJChfrscETK7g?=
 =?us-ascii?Q?YgZX7heRShyG4O472lEVf4LSiMOIsf5Cyam9ukM52oAVimwwkGQRmBeuM9nC?=
 =?us-ascii?Q?1Jn3b2agoerx8Tel9b4VimooDzQ0h5AlLzE6lNv6BUIUbEAMS/HIkNSCF3VI?=
 =?us-ascii?Q?qocQJ5LYiTw8Km6h1NJX9MND2plvZLZ1IO4j5r3Q1DqUrrNqZkiaiHI9PmLF?=
 =?us-ascii?Q?BqHeaPj1vxD7XTVV3dHv2+e8HsAmlUcvNHv3e88KjZzDtEeihjZZqj4l4VR0?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c0c39a-f344-4850-d1c6-08dc47482e26
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 12:37:31.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Xh8OgHHnfSO9d9BVUDjnqeSFExgelyvtmC1s1LWJv6sskur7JmhlSK4jZ/ImjJWH5yg12jE2cyG/UUkhyH+Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9227

Hello Maintainers,

This Patch is for following point:
	Asper spec LE Create Connection command timeout is 20 secs.
	But in the implementation it is 4 secs. Hence LE Create Connection
	Command timeout changed to 20 secs from 4 secs.
	  
Thank you in advance for your review.

Thanks and regards,
Mahesh Vithal Talewad

Mahesh Talewad (1):
  LE Create Connection command timeout increased to 20 secs from 4 secs

 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

