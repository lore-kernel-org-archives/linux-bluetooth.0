Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013014.outbound.protection.outlook.com [52.101.67.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3519351C4A
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721117504; cv=fail; b=nSaEGRXqv++CI9dN++Ng91LD2O+pVtdXSh4ZxZ7bz/QGSZz20uXMfTWQKYt6LDFnabSBgTbfsahRRxmY1h+eikLZUBsyl4qdM5DIX5V3NzjvzGbF4nmTOPXOCPtnjGKcqtsjKLuMLzym8FM8GGwpeb4ROwISP/QDHeLv2Sh4Rbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721117504; c=relaxed/simple;
	bh=De5gq6TKl3yogVMc3gx7/SRuj3iDg2eoyqkeX3mB1/I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EPl0FjtWYuyLazzjZIARYaI1fYtc30ztwnr6cVK8Wb8VW0eWEGOQ3zzkM/xNmLMGCLHo0FYtXw0ykrO5+GHizhAL+6wtg/uSQ15XjDwxiolZN79gVjEQO9HDdja7ss21MsmtcAQa6D8ezaNf7ZZkD1dI67ekBeHOH8hBT34zWz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=SejzVtrW; arc=fail smtp.client-ip=52.101.67.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SejzVtrW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4FQ++/zBz2gqWduVI91qwQ5yM9J8KcES5v8ZNyAGEJpROREUY5OxUS0wAYYkd5zzxUhMOkQtzhjHaAcDoj8MqUzUfErf3rKkmk7XAqJ+/ZutQyX77CYyIjnqdHai+yDHsHpkqPYLONOiXhC+IJyeN1l91OVsp1GQnvAyXDw/k3Qg1WfYBlsyL5yZZ2NBfqGnFjFVg2kngJKM9/US9A2+2PEnkEo8DWenw5S9DtmGV0dfx9txLVF26oyF9FoRbXExQpsjjuZ+qfxMepuYp9wFUVgszENw9xAh/0KnImF/X4YVUOVVNaXoBwxG63NwtEvbE/mJbLEefF+seUXbogu8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijk4exJf5SKoRzcRmog0ITLQWZmpF/y9CEZ4FoNorFA=;
 b=s1YXekz1Y4Jnul6SOId5w5fsny306ZDnf77n4O8M7WFCoqnoyDw4f3hr7kg34tSPCazBzYztc8q39mjG1bUB8unk92605My0/6ZTygP3Y74AC+YrF6CyPOWbceY69TyY4EkywdJLmfDBHQ9YwRa0FionnzD4lrQawkqvAcNFj9VAlLZiS1CU/Ep9wDM+G8Z25iZPYX6hGBo3MrF4Mz7/EodvWypMLyA+SQm4LVEqklkMpWCYaFwIUtCjkqk3by87/01MXN8J4xmWrrKpM1OjPg/atoA7yVd1hKVzTsk6HV1CFR8EtgGx5mrPqNPmlRD9CfXJGMYyhAQM48EuhyQuNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijk4exJf5SKoRzcRmog0ITLQWZmpF/y9CEZ4FoNorFA=;
 b=SejzVtrWqteHmNPPLehXDXeVcqkKgwCyEyvdwad50fDgRchylnzy7O4bl6wGy0zkxsRy6n7Om5+WwZ853mYv9ookpHGbbNkQ+5UWvviedhp9UUHOpxD1C4iZu1aw/Tqr7jVzCmx1/5QoLJgReTnwaf8yJQrUbnB2Ai9ViWhx2dE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8903.eurprd04.prod.outlook.com (2603:10a6:10:2e2::9)
 by DBBPR04MB7881.eurprd04.prod.outlook.com (2603:10a6:10:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 08:11:39 +0000
Received: from DU2PR04MB8903.eurprd04.prod.outlook.com
 ([fe80::2cf:c259:f258:efa8]) by DU2PR04MB8903.eurprd04.prod.outlook.com
 ([fe80::2cf:c259:f258:efa8%5]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 08:11:39 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] bap: Fix crash in bap_bcast_remove
Date: Tue, 16 Jul 2024 11:11:30 +0300
Message-Id: <20240716081131.14893-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::15) To DU2PR04MB8903.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8903:EE_|DBBPR04MB7881:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f0b24c3-4600-4306-43c0-08dca56eeb75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dOCVnP2JPZCPDfs28TmbKkbM5oB/XxQiPzfAD7/Qv6ckcbF9KAzb6MRN6NyW?=
 =?us-ascii?Q?9eikOsJxWOYUH6VrQVJOrQ/Jc7yRgQqtc341sKkoWgYBYZWERrgUXvI2q4L8?=
 =?us-ascii?Q?xvK9VuOY6g3faqA71MWzqjM+2zXil0j//9v/H0C/MDADyZfH+eJkIKHN2uUL?=
 =?us-ascii?Q?Rzzcl1Kknk5S/JDUnII8Os3hM3YKGEmXJoERg1RBGskHGKEzyVqgeft45l8Y?=
 =?us-ascii?Q?qvvv+bcIifwAVPkw2la30o02kYAq9eCMeYhvU2SZDizeD+nU+c/dccb5UhcM?=
 =?us-ascii?Q?Di7G/ZTXpX8YUk3+XoWzU7JWqSEF/jFu5yvKKB7/V21f0dyMSeBx4L/ciZCF?=
 =?us-ascii?Q?hMjeSC79S36UMTTLg1G4Cc+V5IwVPt659Ou7Z9ZDZGU6iCbduZki/wJSFgwW?=
 =?us-ascii?Q?ckRbkrtIyyVr3q+PYsGpjXs2UsqE4hbtBw+wzjyLc9Ncl6csE0Jxyvg9DjqO?=
 =?us-ascii?Q?HBhCAWcEW4PqjMof0u5PtILQP+QSOG2FL+kGn8jTBgECUTuCWifSlWvwyNUB?=
 =?us-ascii?Q?l7NotBiyhTbDeDlpZKZ4h0NJVmctsWGodTPeEAmM9JBpfm9nN4ReMioM3Tcu?=
 =?us-ascii?Q?w8Dz/2440ZuvwvUTTiYEagmUuSPzTkCrVr/e9TusvfmXVtj4vju8Ngm3jQ2r?=
 =?us-ascii?Q?MzfEcIwSlN4hzmQmcGL0XXeCDxwgD18O3slwyhx2FftWxtJBxOgdIWNs7Z39?=
 =?us-ascii?Q?IHegLUEF5tCMDlc8xilZ0y1wca9qu1V/h6FrW9zVR8WyFBLzn5tZeZjmB7Eh?=
 =?us-ascii?Q?/9r+R9q6R9XP9QTHjHrNdmabSA1+OHGJWGAGAyjiW0ETzT+YhO+wIXvZbDP6?=
 =?us-ascii?Q?QA1rqBmwGtbhPqvBN1K3lBvqzBLWHzFVbclVIOIF/f/bMTkyH5h6+hhBKNHH?=
 =?us-ascii?Q?YPESl0MSVOgZdKqI3VgGtKWVb+ANLW6Zt39uJJlkEyqWvDsfmo7G4KE91Y62?=
 =?us-ascii?Q?gclPRYsyH3RPMN8Ef2s6C2sdUtLwdOuxcacpbWR+ir0FtY7H0E3mdjmFc7sy?=
 =?us-ascii?Q?OhLSvd28spWdvo/A0RwJFhI8RagfrKkUciPlqAwTbJEsW6mTlN0r3TmKI5r3?=
 =?us-ascii?Q?kSHsnNSZaz8SgqYVs7Wl1+POMNjbpg9KAIr1msbOMkAVxXzNjawhXXmoVj8G?=
 =?us-ascii?Q?nmkp1GYBQWpd+wwU4fDUX5UzxyanuYZiIWaOQpzbulSQEHL6jjDDWRr7aNA0?=
 =?us-ascii?Q?f1GLXE71Bst/09+/7bBqaWG1/5Bv2spv1rCJbBFERA+59BjrKTpeftKSeaKr?=
 =?us-ascii?Q?um6iKOUVY/yX5dQ7Mlhbf/CYxUEbzHRMhkMnW9pnUx2//VP6oKOmJ2lyVWx4?=
 =?us-ascii?Q?ETntuei1GlJsT2dE/iwp+FKPaawCl6VqYUp3mAeZuBk5jA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8903.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C8iqTHf7bA6/SDzIuCfugTD0yrO0xiyTJlX7ybaft+wrxmZQS9FhuZyOkJBO?=
 =?us-ascii?Q?7rxk/7SRQPvulCOUDriYhPA05lA8xybKYGIVsZjA+apdOw8as+9FYA987ppi?=
 =?us-ascii?Q?Q1lODfeuCqKWRzclslkMeP/r09l5qIdVbfkH0wWqcsvZ4ieEiKAWJl0dOM3i?=
 =?us-ascii?Q?V6iGRAa66GB2W24iaoLAcQKLhwjeOOVUqQJiG+wSlPbSaqAu2WTTaCF0kkhj?=
 =?us-ascii?Q?Rd2/DOEFpYwA4ut6HH5tIIokOSiZxbJQSYB2/9PgpMg9FCNe4Z0vB5WXSCv9?=
 =?us-ascii?Q?UsKmUUCPMykm1/n20kCDNlpOgmAwQEJr5wPUa4qrHTFJPG0hlInfhq/ypUYh?=
 =?us-ascii?Q?YEjKVJcsJ8SWv+5VxlZMCDcfEaPqr3ysoyESlNyUItFyKcPxO7sU9isX/u8W?=
 =?us-ascii?Q?LrkY2zsJtt/lqQJnhPXliw+3WnA//bbYsF6j8W+BTTljPoNt/8/HaVzkN/Ee?=
 =?us-ascii?Q?A/18YI5jPnnzSMeu5cTtk+p60bPw+QhNL95ssKKlrW8Vx+cv9jsDsj+xwa6W?=
 =?us-ascii?Q?clAUUT73KAVWsUnpsBpi4As/voUsp72jGR3yxzBZPJJuyufJO4Mgf3EOf6nN?=
 =?us-ascii?Q?TnHEIi2e609dghh/BmihTLU2gC7tTrEPN3Ou2mWS6vF9RVXyz++OPgpK7I1E?=
 =?us-ascii?Q?9NeRzB2yopUYcHmqBPlXtcNygi2JWy2iT+N6eP8TEAzpagCzeA5ngGUDHqpJ?=
 =?us-ascii?Q?7X7S16RzA9z1sM1Iq8rsJRx1mmE0o1nXrya7RGFjXJbadZ/XWqwXwuRucNTH?=
 =?us-ascii?Q?OZncVNuRKWSrq3t6QGqxJQ8tBMW4efQCZCAHB7i4hcFbd8r5qKVHqt+AXjWt?=
 =?us-ascii?Q?MevxJL2T/Rma5rWsSdq1nGMfeSlQortLSGfPeN+5MfGAFXF9mlO8D1GesUrr?=
 =?us-ascii?Q?IQvqS4GGkaeFB7g3h8yMB5SH1Ll1qKb1rZq1jBfALFAbqTbkg3bQrmIhzqXq?=
 =?us-ascii?Q?1EE3x9BrKioYXQqUNoxPob6GQMngLHjoVA8FjJM6VMp3+Su8/YCyyy/X6KAj?=
 =?us-ascii?Q?D6QpzlAmnPL/6DC6wh7F9jhJQ/ZzK8li/XLxZNpyI0iHj4J5BBEkFyTtbqzf?=
 =?us-ascii?Q?VUUPzJBCyDj3OqlKMSVL3EtvbD+QeMqXBhHUaY90o07DhoVorw7l/rCbOiTf?=
 =?us-ascii?Q?7S/rLtinaQR7EAeaNmHLOMfcDVV5mT+lv57FKurXOrmEeoqycVrMFg5/8O5X?=
 =?us-ascii?Q?8SjbWjoBWGxUjMQlkeVNx+jKVQ9sy84DPu8IMbtj3Om4pFj+8YBHSe2foiuh?=
 =?us-ascii?Q?DdEY95thyEnhmWp0+Sk7+DfEQxwB0pmZuTqxjl2Ub084HLskbdSDpum2zvi3?=
 =?us-ascii?Q?WFloy2tviN4QPBAoaUQbC2xgYjcYEs9eqlbMmwyoD6DlZh2F5wtKF0p24IjI?=
 =?us-ascii?Q?r2FohoZeksFwrnldqwHB0jMNhLLDFaPXVqq4aqaxDAibe9pf5rkaEdpPmN96?=
 =?us-ascii?Q?poHlT+VAQWroqjZ3BxUWiFccM08YHKoOQKmULnJCed00+enZ0SrYpjDPNK9T?=
 =?us-ascii?Q?MGWWGR3wvXftRSHOUhPeuLoIqQvSkRw4CPFjRsE9tD5IZxw7ctt8dXyoo1Vf?=
 =?us-ascii?Q?TVBbVoAHji0Jenv0o5JJXoetCxJRoLIAsDzQV5qv2c9VfVvIbd6sf0hnRahs?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f0b24c3-4600-4306-43c0-08dca56eeb75
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8903.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 08:11:39.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnXlIW4ACy1/833hygBqo8AQoj/sUnFbYesWzIP7zBiwQswpN+TdJUUekBOMhxo8Al9IEssl2lnNfpIk3Nhemw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7881

This adds a check for the PA request dequeued in bap_bcast_remove,
to avoid accessing a member within a NULL pointer.

Iulia Tanasescu (1):
  bap: Fix crash in bap_bcast_remove

 profiles/audio/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 73266377b0185c56c921b8cece257df428612d73
-- 
2.39.2

