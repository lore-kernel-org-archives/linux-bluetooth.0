Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58C47762B
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RxRahdos"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RvwprNBofM8zL3fys5cKyVdNd/sE99WSbLFwP342cFBuQqY4hZ04v/SUW46imHBYWLHxuwmGqXk4FD0Pj8+Ow2m9W5dfQbWY5gVUU6SSsUOLt2F+BnBdZhiXAFzVjU2rhfM0e2DzFZReq2nGmUH/iSd+nO61M02sflnkfjFJE24JGIlJLTdmXhr4h7WW9mx58ZMjmatXnDlLmNRHRvPA4Mz0VbyXm9cs1ovPwYBLdl+YJtA9qw5mhI56fcGwqYv3BxUNCUHiKq1L49ZSGZqsE08QuWuteNqBwNbTyZy7H4Dql+rlzVtHbJL01vEYJJVj2EtJ/VSyViwLLexFa5ZkvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2ep+VzvFmXawQTnmBhm4Z8NkTJJirPTBARYfsRiokw=;
 b=SFBRcgfwbsHvppQp7CLs6Qh8jfd3cwu201bnU6wZ32Q0eCKhs9x/1vUZNCf0mAOUFT9pX3glo79jFp7ui+rojlylzYHJ+Zv3Hq33+FCTN40RaGkc+zfOfGli5egVuJjI2Hx2IKcQtvSffl7REjY5eSTjPAh84Ibt0Yf43VYEY8z0kdsE+8PNodukI5P8B+w7OCTsL3CGqM3WS9pGXh2qK7GoozuPQJPnhAS05rdH2lt3ExFi486NPwcMh18yOqIE/Gy2B6WbTyDgI8cgHCXEabL9pXX04MefYdZ5LwsKBfIOxBODNOQNuwER3F9pYe/TlG6Ydd4GqCXvrOAdyG5NNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2ep+VzvFmXawQTnmBhm4Z8NkTJJirPTBARYfsRiokw=;
 b=RxRahdosUuqSx2fWf7vE5sPfSQYD853zYOPTwo6cVv2J9dnwPd56mqmypaL/OZvI/5pzuQJZk2VvLYGHHzzmHPpOZWFA9NaR/lotoiDXkIuEfhVIA34O6Zq/Oc+IpM1A7uZfAqdXKLBCrd7iipZOkxbj7MzLo+glpvM0YJzkLDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA4PR04MB9568.eurprd04.prod.outlook.com (2603:10a6:102:26e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 16:56:05 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 16:56:05 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 0/2] Add code to support dynamically generated BASE
Date: Fri, 12 Jan 2024 18:55:59 +0200
Message-Id: <20240112165601.134073-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::11) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA4PR04MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 1620b168-efbc-49a6-aa8c-08dc138f5d9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	03jyZALjscevbmbEm0WY7uWa2AkI3vSHb38jguee3j9GzSH6KRGykrG7mWWoIeIZh3S2pNRhQZFPPdTeGN8UOnVWbZktzuSxgoeSWS3h4+urZd8NI8/om+X1in/LrdYNPixbcwxjI2JyO3dhwmRQ9e9gJr1ae05GE11sGbYT4EMR6oRkDgIHsB0wbT9zt42L60L9oRPTnsE1cDRiLZH8SqAWib+2skTd/QdqbKE364jcnKa6lROhYNna9wsglE8zgUhomkRcxEz5J6A8lvbaD8ccFGwHsr7Aw+anEyZ3FjX38rg+H5ayhVr0hodLBWk/twpunth5RFB7NAusf5iW0tXjM0QXvcJGDGXViGIYOj+bmHTUBV2u5MyquJtpnqvUkL79na0/xUBjbAykeQt9lAIsKRVJG2lLg+rSkIGtMSzCtPfduAGNq5y5ptxwwy1WsQSGL4r+gWxePt/g0kTt9ayqMWWjzmbBh8E3RND8gBZvjI9fUghjR/d2DytGLRMuOUIRs3ky4+uVQbk0qzJzREbrj5am1EZuDmEUxOPKhP8vsthzN9Nv2ns48jnN5Hv4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(136003)(39860400002)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(6916009)(316002)(66476007)(66556008)(66946007)(2616005)(1076003)(26005)(6486002)(478600001)(6666004)(6506007)(6512007)(41300700001)(5660300002)(2906002)(4744005)(38100700002)(8936002)(8676002)(4326008)(86362001)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?237i3AfJfTi4eqAWhj3XaDeWC2H9yZFber9fXTDu14ZEJGQX86PBopAx1qYw?=
 =?us-ascii?Q?q2nCLYDspt3mrhZ99icuNqNn3AzUi70fQVod05O1MAzrdR/VAjh5rFXOtJKo?=
 =?us-ascii?Q?Gzg/yooBEthlM1/yxTiGhxBUwXA//QpL9OzaLA0q2URA+vGo75Gk8yLj0dtk?=
 =?us-ascii?Q?YXIPow1gjA0Y0jdkpJV2hxzjRIJiwxirRnMiSPDS9qLmphVrMveLzfnoefUS?=
 =?us-ascii?Q?gLMmUCrgx75pV4wfW3Tx9kkr1EhWc2bTyH8QbNoWpaSmDNmROxdI+o5bTfqQ?=
 =?us-ascii?Q?oX2BVAxyNxh1NMq18MeDZszB/409Vw008xrmXJNrzw5R31n7R8ECBZ5II4B8?=
 =?us-ascii?Q?v6CShoCG1bMazIRj5r0B3tOUFwHwDEYJkDQFXGEw9ad8gWW9xlBfXrPRFmMm?=
 =?us-ascii?Q?2FTgvwg41K14/QKYo5k7ecqVsoMC8kS6ybY645Zxpmr4k5w81OKnx8VRqbiE?=
 =?us-ascii?Q?Ji8zsldc13JThXD58cq11c+H4oP3Rj1y8IgyfX5U4Hiu4W9IsoP4+v5G/yUe?=
 =?us-ascii?Q?sAFAMkcpsjSj7Q+eVeE41zaA2ScpvWsqrLJy9kj4ESbjW1jLhpEiKtqeHUtS?=
 =?us-ascii?Q?+5FE39VjQ/DXMi1aju+3oExYVdNfVxlxLnqhOzooGt6ipYSGWmcWCL+tp87p?=
 =?us-ascii?Q?YqnnMMl8ZYhmEnkOZelGe07CXKXvIvLr+kHcUodiKcpPrupwgvP/K3yxGm6i?=
 =?us-ascii?Q?5MUCoxyA4T6pM9BuVow5kxbGXnxvoC2bICsoCVZI2fAfAD1vhbanJvBN/P/p?=
 =?us-ascii?Q?lMcXYO1cMfAUeDQWZ+mAkSGtCxwriU0IpMDWsz0f+jcHf/cG8yOC/IEEf4gv?=
 =?us-ascii?Q?zrMAZ50PcBgwi9pS+H5jYvHxCiWZteWar7DZghCqVQqFqa4VDVTQ0e7JxxeC?=
 =?us-ascii?Q?gwiIrjqdP727sgQxFgSXD2COTnu9n2gTbvX8BWH45l2SI6kgGC1AxAq1e4xK?=
 =?us-ascii?Q?3u42Hs0Yhnfg+cKpngmgspObbGdZ/7vagwuE570bBL5L2nkxG2mFh4fDOUbq?=
 =?us-ascii?Q?6pCLpWoylQb0+Qr1djVV9WDGXJnepZNGDsPR/1QI62WQggRifTWFuQxSiJT/?=
 =?us-ascii?Q?IjhvQectWadg8z7NbHZ7ezHmzFWC93PzPsn7IZhYTp+tYn7mz2Fjv5K2OdXP?=
 =?us-ascii?Q?r2swW4ART0c0X8S+y9/Dk70xJ1No7VD11EbtOuPK2JvOLOVFwDxA8xzvHOj7?=
 =?us-ascii?Q?329fgFVoNrgRD5l7Z83v0MeNPuBf4dvtg2ixEuXyiYGB5/Gxet2eGPwQcLNn?=
 =?us-ascii?Q?Zn5QQXRz2m+b234q6T8YehWlL41t85ruPv9Q247WjfJ9jcs6GqR31vpZqRTl?=
 =?us-ascii?Q?1F41EY/Le5aGiufp0t7aKBVc62fmbQ8Y9Q6qiBaivK+2cwNZX6lMxgkMhv+m?=
 =?us-ascii?Q?1XH+fgmLh+KF6+nt+Mu6p+vOFAvrxqOMv2ha8N7SHoXKNz5qBTuaIIxszyeH?=
 =?us-ascii?Q?YRzJQNNTkRzYPbqP7JDl5odyedMaLFn3ts3PYqbsESqT4Mi7u5JorvD5Id87?=
 =?us-ascii?Q?SbCW8Kv0O/D6IgrqUtC6PdQtUr1fGyLClxTaHVOav9sc3tZ2tdaE5lzrku6r?=
 =?us-ascii?Q?0ct+G/yvumaNaHwvJkUI84EbqjZNlpGES16Rbk9swusg6j/ICNZ1uCAyEiT/?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1620b168-efbc-49a6-aa8c-08dc138f5d9c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 16:56:05.2639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tuY4KDZGZdJqX8lrBqzTgQn6ERPOUyZiolEkStQj/IpGlCGAZSuJW03fFYafdK+Gzf0qpaQacT5fBeMUGkvQx1f67ZCB5n018uPhDlE+E4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9568

Added code that will be used to generate the BASE dynamically in Bluez.
This code will help when will remove the base_lc3_16_2_1 from player.c
so we can use the preset from the endpoint.config command.

Added fix for ScanBuild error: Dereference of null pointer

Silviu Florian Barbulescu (2):
  shared/bap: Fix ScanBuild error: Dereference of null pointer
    src/shared/bap.c	bt_bap_stream_new
  shared/bap: Add code to support dynamically generated BASE from
    presets

 src/shared/bap.c | 494 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/bap.h |   2 +
 2 files changed, 495 insertions(+), 1 deletion(-)


base-commit: c85546cba715afee020e61bd0a44499e618d0371
-- 
2.39.2

