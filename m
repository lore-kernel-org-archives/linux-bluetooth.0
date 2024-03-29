Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2116.outbound.protection.outlook.com [40.107.249.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4F11187
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Mar 2024 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711694155; cv=fail; b=Wv1MahV/6qjg4pFZk8QHyVXTxYMrGn0PQ4jgJIQ+kuJr8Lj0fAENGvB+4epMw/jkBLwFnNZfzKqwpPjI/7my+HyNMBOYasQN+SeXWwCUOjf/TENFj06PSeZA+Fw3fPuJPb49EirjU9QzoKPebRd27AeV70Y3X/QpDmFKnQQ9S8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711694155; c=relaxed/simple;
	bh=4UCSvsweLe6Z3vjxXL6Vp0aM9L73NuOtvqA2B3U3jkU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=DQ8rN6XGmnbs2MpJqBjUKDlZwMfYMu8IaMyzqf+Yj4bOHJuvc2+bpoDR+P5c8aWaE6sV0g3c/y9Z6Q6wKT66jh09/EkOIJKzSjD0GZqtWt6F4BDdsWXFPvdDWQ8zdt5qNgMC5DMlJ4yo+sqSDUz23zIM9aU0JKpxNCq0iojTBRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FKYhno6w; arc=fail smtp.client-ip=40.107.249.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FKYhno6w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UhWTafiRqxxWoyjqIRiQHwJCQSEljESJYuH34Rqct/Zjeo3iJrYQYXja/FaqJ4sGkeklIima5fKr7+G58NVrcC8ryCrhSaC4NFF+5Ljae1Mq1/JspiNg9TThz5gy4+9mA8j4jf9vcg/UhyN1PEcEl5j2XkMYzYeN9vnS/yMKBXCewFJyQBdoLArjeJBk7Pua5g0+mI/QI92+uklgQMQH2nIkD8ZJluyecEZB8794Yu7zrtAQFLeukYaAx6Rh2kxu3EE2Qce4kvMFIcivCCzQLM/aMuBTFOrmGuWhYq7NaIlp9sHXS+S2lhpgiMvSzdo33mFIBnj2SHoiSEJHHZ15qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyAHHiZme4Ts5mnzX3bpJP7o58TxH/GWJ4vo87IYqys=;
 b=LUtzJcKT5kZjaHS5gxSThx79eeDyytNY5aiN0KBOtvlJK+TpmO9sSkLofzqw9kRVZmVn8h801qmf8Ve+ZpTw+C6q3dkkIwykboAd5h139zUEger6+ivGlEw4oumb1k+Mq6mlOhrSTBDjXYvj+/kSSBXf9nivvKz+LvYs54GH2PkjBm7LmizUaI4xEZl6k1OZiS8DWNunbGVkWXm19sOJLlFjaoTRSUDGOIEe2VHY7AmjNY6QE3qKAzs2LMUORde+ZRfem/cYnWfitH1nXqhQAjB8PaXhSDp/J+ScYj3HqmL3xnhb1zbyZB6r4GgzvdDHyRBrPax1U7aCszc97SXh3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyAHHiZme4Ts5mnzX3bpJP7o58TxH/GWJ4vo87IYqys=;
 b=FKYhno6wD0cwYd2zyx/MbYcDc2i/73UBThBgPBIJdp0OCZKos5AiH1WlWly/NJggSz3+g7ywlI5SWRwSbFbcl/yk0QBW/kMf153YzHVnBvwu70urDVQ4DzlawASnzYXwrFKwGRycCpILfGTEmNqzyIuyJZc9V2yuZKkPMZKN3pg=
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by AM8PR04MB8017.eurprd04.prod.outlook.com (2603:10a6:20b:249::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Fri, 29 Mar
 2024 06:35:51 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e%3]) with mapi id 15.20.7409.028; Fri, 29 Mar 2024
 06:35:51 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH BlueZ v1 0/1] Autoconnecttimeout max value increased to 20000 msecs
Date: Fri, 29 Mar 2024 08:35:33 +0200
Message-Id: <20240329063534.56892-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0015.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::17) To AS5PR04MB9754.eurprd04.prod.outlook.com
 (2603:10a6:20b:654::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR04MB9754:EE_|AM8PR04MB8017:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TBoh32C6bGPvPQsz3EX0Y+YuM5uDVqmz0m4vuZFjLSuWaiSvX7B/26grI7iSVXoDbd8jrsmx6uZmkmLusBp/mFp3HpzN1YHyrif054AYoE2lqdnFIX6ZmBEd4nAQ/iH3/Veh5kCQEs5RPTQup+0SY7QkufKBT/rhJDQ33NpAh2ZiBgrdMDCEU/MLudnmtPEmsVc9WPKaswcGTgmHYfKpUIvaZuy+ZxhveRU601oiT/Xlpl2F/Ccbnne5ULUOAaTijQ3/3JZlAh4QhPQ/jTQ6H6/Ny7NzLKubmRCDNm3jF+mFFk+WRnDIeR0vR97Rrrx6+GM9U8aBThzjwC66SXMIJEn8zWoDBgmsPIYa+0J+b5mrb8eA+nPP42IOKJgHXxhhZ33MNhhf0gTZA1V13s4OIXStMxbpNX5JuSv2/hqoR919eJ1zvvJJ07/4hUe6bCmXgRgk5fUlZOU4JvUKT4vTS6jgy+cMubqnvtY5O21IvztwHtNIhpXvZcw1JShCTtTJfYH9us1er1DjFJ4/Bq9+uw32ZlkUmAqBWXXv93pSr4vaJZPtXRUk92/ZamBjNKEDvSpYZySIRnJWiTMhn/NUTjA9IRh7nk0Gpu9wu51LwOa1h6FVhpoiLVszFpcfw0285wCumi8Lv6j7h/yqTd0WboutAVauapBkCvxh02O/FzlHxAhbhjjBb/Ep3c3AMQbNlTLBaYNtCY1kvYnXOUas5A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jpHRwrMV6A6u3ELsbsaYu7SGlrjSD/hUKlrAQ+7uCYjFptcTXniUcNSXpu8O?=
 =?us-ascii?Q?diZUvT8XLPhKi2JAwZ2nL7J5/eX09oiCDMZOO8TZh2FC833XCEMRLQp4TMz5?=
 =?us-ascii?Q?/r88QvBxelbBFq/4hOtRDuGEafjVLapgKjahsil6Pf8KvHJomDiofbwDlUNF?=
 =?us-ascii?Q?m+ZXeQhUavHaaMEgTwYLZhTE44cukevKM9/OvAe9vJ4y3Pa+vSlFhu3IoXmn?=
 =?us-ascii?Q?8P5ni0Ii5eVwuSg7Ugi4Vr/ot8pTzLFmg4peYQEChEK37Cfs/T6IDMmZb9FC?=
 =?us-ascii?Q?lRKw0WENS+co+W1mMYpMp0IXu+1o+xZjFfGZjSPDY5v7+Y63fQtaFmBF+oOu?=
 =?us-ascii?Q?uuRzFGfBtvnuCIAJKqpGbErgVsEZNXR2QFWB29UBtgCSZPRuZp2ibxPowZh9?=
 =?us-ascii?Q?llaoL7JkDmPY7KqssR7+8Al5ZPrmyv/bj/lQ4GralqSpsbSkrOYOGRYM7LaJ?=
 =?us-ascii?Q?mqpuqmworgNjF0CfAgctjShHSbgetTrDp7KvSGo4ewGskFFuKfIHSPed8+O8?=
 =?us-ascii?Q?ef2EK+dFVjClTn/SDRhxku6v45N1zX4A0Jwb9C5U+Y+6ly4eZDVvekr1BK/L?=
 =?us-ascii?Q?DZPbgKojUn7pbH/Ym9axB9HDBliVMDHj/EkbqoDrx/pcmge8gtJuLCJ977SR?=
 =?us-ascii?Q?eAimbIylHZEI1ZUT4DvIPbEJWp3atexLKXNLsk6RiVYv1UeMCbXZrZJ0SnjC?=
 =?us-ascii?Q?ISME+p/pFE70wGt29kltl+QGv4knXhcWdSCNxvGz3QxbGjh3T/pv2wixg/Ll?=
 =?us-ascii?Q?PnRMMswVv9SZTKdr9tPXBncMLguUea6f7xhQc8nOPKwyeeJ/JJ2QlXCGiPLN?=
 =?us-ascii?Q?Q2eZQRZv7WDClXPFR4hX5bRJCoEabI1wPJMjiCw0SemuQQt0QI/SCH7DQi5M?=
 =?us-ascii?Q?40rEQqAYW1BivJGJHLDbcqFhfkDaxzAqVSs9WBu2KizCvB6FbP/K26M3nFG1?=
 =?us-ascii?Q?SqLAQLJDesixpEmZim2iFBSAWJ+eHQtx5dpTHb1EgWwAzKMuC/z+n5ZVWBg4?=
 =?us-ascii?Q?kD0KEWVja4tlg21y57vqc8EIEagbLXKdBRnnNwqTrcQOC5ZmaI2GmsctC/4Y?=
 =?us-ascii?Q?HsiZ9qq6mcQL/qEbOyIl8c9tdwgA5YY9loyo4/dIweG8jav5n4VCIhWL3URm?=
 =?us-ascii?Q?+uCFbJVLC4S0XboJnCatDBM3T2KwxaR4WjJM6ExAvhRHxEsRyj65PPYCqqFa?=
 =?us-ascii?Q?kbN0Npi56BYEqAmubgi19d25yJ+uPQzjCdCFPlsvvtF7Tj/VVIdVd4dZDFII?=
 =?us-ascii?Q?nGphnFd8yOCyouAsKhHcXw9dUOQyXO7cySlXV9KDBbYjxK65IGAZ7EM3t/Yf?=
 =?us-ascii?Q?hQBxP3lotMkVj27kRnwzm53cDFZUut7uyTAONRBf4skK4kLnMLn+zi6dcd7Z?=
 =?us-ascii?Q?zQaCfSGwQ0h/+CLio/6X2lgcJtmxbzH+l6p/7XCbe+J9ClWFQynqYOLIfu0x?=
 =?us-ascii?Q?K9BgWLhPMUxwaNJcmn3bLxinjSiOJj7Sy/tqHmI4i24+rZrp0UNh5lw4Y6Af?=
 =?us-ascii?Q?ArJprdivT/xgtRonTAltKwUd9sfTqstwh/wBeTErkI9bGs3VgGWogPGxzZH2?=
 =?us-ascii?Q?1qMGu4LMiPPv3WMehx3Vq7gbNO32Y0ruQ2Pe7dEzBf+HUK5zeHxezbvYZvK1?=
 =?us-ascii?Q?AA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08832594-0d04-48aa-883a-08dc4fba7a0b
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 06:35:51.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /0vWVX1qF5BfOSbSLhf0M3VXggJvVhK1dSSjPWfyV0sLMkqScc0Lkc9tqMwTq3R31srzE0FeAUMUgPQI9ChHoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8017

Hello Maintainers,

This Patch is for following point:
  In implementation Autoconnecttimeout max value is 16384 msecs.
  Increased this Autoconnecttimeout max value to 20000 msecs.
        
Thank you in advance for your review.

Thanks and regards,
Mahesh Vithal Talewad

Mahesh Talewad (1):
  Autoconnecttimeout max value increased to 20000 msecs from 16384 msecs

 src/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

