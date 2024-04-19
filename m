Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128AC12F385
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538711; cv=fail; b=uBA7DclYNyeN3JwOYXA7UfHFJ1fWi7in3Zs1ycnbqy1I/39DM4NTi9e5c7qk+6onyaoRdrsFn6Gc5TLgm1k6sz4GNSCdyU6ZhIX2KUyO18naJvd5I/520eDiA3Ln0c+F3MHjS0UjYvko6qhKlmI6edz3oVJ3KhC3qBdTYiV3PpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538711; c=relaxed/simple;
	bh=0bRATgqwWqNLmEdV3Nx0urDEeYyxDBUS/yfkE8SbSD0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SBBbc66GhrwmaOgxjbpmJAnCxQTgbLQHRFZedr166JzoWNMPraItgABDy+lIBn6MkNc7VVueyTsg7yJe5nqYeZYJe9692EB/NwVyNd28bneBmlsSY3Q65z+JIWw8KWhD2BUD26kPWps9NhgCfFO9PbWTtHYVgeHT9pQ8DPulpLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J7ztxvpD; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J7ztxvpD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPJb4J3ucNXvf+FlBbG+f5tNa5Bs82TI6TFVcm0oqIy1BqsSupv4dli7IAtoFiYbasgdw2D5FFa1sHFYlk/grE/0O1pjwXFEhkD2HalIV2FySNpy4NysRyE4Y6cqzJxGEZ6js4wxKQbvUv0uyenlvgya1GQToRRa2ix1ffDi26c3ua5dQHztDaeSHdeo8fNbN+r8d+K6zQi1UixeSeCy96HTJhv6ldNhQBflgT82AfgqhJQCrWTkFuFR/1NSXLxneaCiXuIe+PCrt8VlbDS8Pcdoq28yJ7CDDHwea8wJLkYaNonOx0AKDr3BNOhgpPX7lDF4APkY9WYXJ6NnUZfx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pH6BAFQI9qW0uwWmM4qfxct4Yc2ehLKdhA6hen85rUk=;
 b=l1zCywdFHwZu1fPyxZvNJZdxgVjvRmHe0ZUXBZfOYQTWNXJlIAt1a2abzv4TO+UmQnjKZLdH85wpLbIB8UZNIaOI+76kk2pgJyLvn0yFvVG8Q1+OGbxxdNrFOKCEwStlveqmTylFbU02c8jEI0xFkWSyV6Nw5u/g5lSOwmBZ92vdiYVtqmbefBs2UPszTayKHkEMynnwkHyji0mFaFmVSNlI3ZBbqt9yPhOtW9ljxV/Vs+dtYRe1YbybpwqajMVvSJi3l4bbDqm+oqoDa9b/bh3enTeGJmHMdIDIv3ZFppCtOAJdfcQzwjVGKJnHvZkcfxeSNRtiSmd65mqfNeti+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pH6BAFQI9qW0uwWmM4qfxct4Yc2ehLKdhA6hen85rUk=;
 b=J7ztxvpD5H+FDS7hVPMrYI7c9Tv5+EYAbdx/KcTRVZELF0OAFtzDGZ82Y/uD5cYrXPM+xbQJmmdW/77QgYi40OiBQFkrnYbJQkyqr+ZD5je8ro/kA+wTTJbdMYgQkAja6X7be/rfsJdY2wQ5/dv6WwoxbtXMrTjiJYe/IWgagIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by DUZPR04MB9947.eurprd04.prod.outlook.com (2603:10a6:10:4d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 14:58:26 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 14:58:25 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 0/1] client/player: Fix transport.send command's transfer of packets
Date: Fri, 19 Apr 2024 17:58:04 +0300
Message-Id: <20240419145805.46263-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0054.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:53::17) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|DUZPR04MB9947:EE_
X-MS-Office365-Filtering-Correlation-Id: 930142a4-91d5-4af7-e7a8-08dc60812a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RO6vUh29PK1qSiC5eBVTuLseVR0By7SfJbDRoSrNpltY4Svf7Z71Z8j9afZ7RSAzlywwUiPxGBDwoBoglCFCteUsZllWQ+guGu9lwQLKmkTMdssfE75OBdNNwMkl4JdbRFN/D1nMyDtMTGyCY6EukvrlqrMyw6E9eMIHlhFwKQX5kakC9n7Tb/+05rCcY8WRa8qP0u6Ohg3muoCTSdy15yDBY9q2O/RvsuB+53UImMphpS+ukJDEBXp0lklPvYmPlfBxtlYgqhKmf7T7GXbPVSb/DttSkPyak4tMEFg//90b4w9h7fRsFXk2K1/5uz7WzfpYEoKtEICDSrFRoySbDQyheDzwCdeY3UzoTMhKkb2lko433HEaVjmgFDAkDsFPbb7GCbCB+wefq9z4J+ZsjBJ/s2ZtV5KyGqQE4q3sx9SnkKvEzZwUQnr0Pe+rGCTZM288r7RyHRVbQXNkiR6PPPAAhChw9bW4/OcfJHTTtYwIaFa1wgPil+mW9QnEvxcWtowiXuNWXt3OqUMgmFjJV4kZg79n7pbn8OpUHJpv+Gj3KBYukoSv+otCo7TTEmqSO+OvHXUo6SauDQjALoMYlx1XhhBE3ZnDm9baQ5VP6yd+sYjrpKk77Lj95bgBy0IwMtdMx/+k0h4Vs0Z+QYzXPtOFhZKxLkHBULcWckAgVrphrsguiRAwh15S2P5bf5lBe/+xMkmW41yhmz/c0bjoxwAYc6xcAJ4rxzX8ky3PevI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oCkWfTwVkkWDz0koJsGdAqOWVi5t4DzirhdRIfBVIK4yT2N4U30CRMKxHsK8?=
 =?us-ascii?Q?gT9YaAZbcbPb0uqPKRVBZy+trR7rcY57B1cTS7V8LjqIQ+rMQBfTIs3KIgSb?=
 =?us-ascii?Q?SgJPLL/Mb0pKzdiuCtC181ojQucavewSREQLHJo8/OTEBnh7iqihrMTlkSNH?=
 =?us-ascii?Q?csn+rAF/1690l05QSouBOZ45p6u0bGzqdGjgT2n+l1pXAKsIeDqlW28x8kKD?=
 =?us-ascii?Q?oiruk+AyrcYBfIOisf8PB1l1NAvhBfrpVAkUo+BKFcfdOjw8O2uWDMBLPBBT?=
 =?us-ascii?Q?OciB+qhbcY9y5qXhvcX53MXePn7NL2QONTaggp+enep4OljXFqvUXdE89C1f?=
 =?us-ascii?Q?QC8ofeE3WLhkkMW8xO7OfRDGJk0U9e7FmC9nyAARvAJehmSD4V8qGCm2/1Nn?=
 =?us-ascii?Q?0/wUl0NRYz19POPB/4yQ6XeKE/E1pPGPIqIDeTAhSW1+oOoNmHf8BV/ulglh?=
 =?us-ascii?Q?ojH5H/n8M2EHOmN5jcsB3fOlgrnu3xY+mWkpTf30QgjCtVFwRpKpLGCTxRd/?=
 =?us-ascii?Q?ch0TPWa5Y9DERDxvVuYq7+8NjFSfQj3U7bQV1cqLqXXKYmTPuIa1sQyxpsQi?=
 =?us-ascii?Q?6m34rjJaoyRWYe+xyJjxGeRu4g3qC/hed4Ix8hQUl1TIDPOIpIRCiYWaHvvQ?=
 =?us-ascii?Q?WwceUvEnZ+/9/1zMskZ6M/IWjL/VY0omYLh3J5UPvLvS+YoL3mQGpZC82zoI?=
 =?us-ascii?Q?0irWd0k0iIWX0fX2zz33HriY67rucCTR5q2/FIvbXFb/upOiEfxDe1FjrJld?=
 =?us-ascii?Q?/dJA3e4R+7CMXjUxPUZ53eyJzQO0rVZcIiPa+z8skt0fNo6eSyZl5h6cOF8U?=
 =?us-ascii?Q?+82trwLWv5kQvEOFqydueuyXrS6SV91yeBmD6uDzBfwup0LMIZmuKBnJD4pK?=
 =?us-ascii?Q?CTGXYuSWbgYpk5SHhaBcGQToqAwSdzE+mzom7Noh9DMirJd9sEJkzNLuIh9I?=
 =?us-ascii?Q?B3ob3MAYxlT9FDMZ1C4BgC7ddd8+YZBlvDk4NHNyChMiEFWF8tfQ6TB70vYq?=
 =?us-ascii?Q?pmBnH464h8wqRT5JSG7pPtZqP5ja/GI12FUT3liUbJ8pRpAmagLnaa7f1FNH?=
 =?us-ascii?Q?dw0y3BdAO21C0u84jDXiM1P2Lq0HhCuOONNiEN1Rf1kgy/TV5ofT6J/o5BAk?=
 =?us-ascii?Q?xNQglShWohQ3gNMs+WjbDJMmyf856ZG2JmK64bM8qcdnfoz3gUxfAOvQOqyX?=
 =?us-ascii?Q?FVy2VXLJxJFJGX7xIabDDQU704LHLfwv9Q5LEuQBcAYDU9yAKVODF0LAz/ni?=
 =?us-ascii?Q?+q4ZZl7Z4fF0QUfD6yKUrgJXk/27YKoCH3tQVhysyQmuWNReIAq8WyiiSLMK?=
 =?us-ascii?Q?Zcx2TVCm/motbYEhU74wAvW+xoKAgRpCLkKyavp+yWRi6fcz+52Ofcg6ie8x?=
 =?us-ascii?Q?IqeixXGUjfq7Kd74wSOAXXWlZ70l70DvODE4khZxLMUudLqm3OaNMYj9KS8G?=
 =?us-ascii?Q?0vQ4B4GHq8FOJs+ihz/2qb/6K/XYC9KbdVSlZbIJGB4fUzPU9rB4WXswvvne?=
 =?us-ascii?Q?Pm3rlNTaz8OGW6ur1M0Fke0lylCSNlY5LGv+eP4VA15k1htXidEiQB4X44K+?=
 =?us-ascii?Q?8FK73isRhwFi545HeHMNzDAph94afbPk7pyF3qsB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930142a4-91d5-4af7-e7a8-08dc60812a1a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:58:25.6810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcX7pGq/lvllBNJG3w4fGSqRwDMGojpYT6N8xpi55VvLkyD61xdGR/sFZ7kWQ3oPAbbGBT2ukOGIdHg03NT88Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9947

The transport.send command sends a number num of packets at intervals of
transport latency.

Num is defined as qos.ucast.out.latency * 1000 / qos.ucast.out.interval.

Since this latency could be smaller than the SDU interval, the resulting
num could be 0, causing the file transfer to stop after the first packet.
In this case num will be set to 1 so that at least 1 packet is always sent.

It the transport send timer is set to a value smaller than that of SDU
interval, the available buffers for ISO Data will eventually become full.
Thus, if a packet can't be sent due to resource temporarily being
unavailable decrease the fd offset so that next time the same packet will
be sent.

This patch is a temporary fix until the appropriate solution that uses
number of completed packets to control the flow of ISO Data packets is
implemented.

Since both Unicast and Broadcast scenarios use the same transport functions
differentiate between the 2 cases when accessing the qos structures to get
the transport latency.

Vlad Pruteanu (1):
  client/player: Fix transport.send command's transfer of packets

 client/player.c | 55 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 49 insertions(+), 6 deletions(-)

-- 
2.40.1

