Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2044.outbound.protection.outlook.com [40.107.241.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F320B39
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fndYjAJC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fA/p7CmZrw+WXZmmtBOItP51B/CSl5Uqet7wE0bJ4Ok2W+2dtm7IYBWhNhysaCOUem7whpNJlIoqwYBO1eUTsAR8BPm5gZOVh87ygGkhsn7BbQkhNTVAdcNrf+EKkA3Aq5Ytm42P//k2g/Snmwwmihkk45WAoRCNCdtIaV8BeVDLb8v5il4pA1jxXZs2d856G5QTlCGQ344ZBUrqemVLVajTgpPRdBONq0s7vvbvwGAjf+mgj4uzNiJIU8hSQhKAMYWUqTcdjyx3jKPXrGhcWkrygKWhpyLZfdMeDku6K3XLh4rhree8q8+EDGjT/vKXTytkYAfP3Vfs/avpjUsHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hWc3F2JaIHOn3L/qQW0foZ9DAk2qXYnSkrSXTFjCneo=;
 b=gc96fsz0miZ8xLyOl5d293BYC/+IdFQ4rQY18z+mMvvvE12T8iF7gpMXNcgEP3WfBnMP02qeYCTpZRvCEjSnUBTnsdVDiUUbhAHb8ltDd6jVnRQorvV4PP0A7gBXHqLWY1LQdl68GKdnU/954hvLS0Jhlyrfex2zHiG4Jfuj07yUur0I3LlVJpfLqBdqGB+RtBLOfW0QHTMcz9o31nKxZGnmcjl9GGKi5lgDG4TdI09/WS4ho6d0bFh3+3YhgeY5/mPsRNEWvsJx9soPmAVWB1+T4m/ezkqwmJyyUt/c+eWJx15vFtcjWMGRvda41yI31q05g48uPxzm66Qvyk+SQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hWc3F2JaIHOn3L/qQW0foZ9DAk2qXYnSkrSXTFjCneo=;
 b=fndYjAJCHVN1OWSVgizMoVOra7g4N9hh54YbcqZ16OjcQN9TPrge5pHEnjzbzhlcvsP07XlTWPtxWXuQCwULiVZMkM9Ock+b9Urca7yAaqznM/yeI6nW8+hr8aRk9qCkgVdCzY09ZwizrJ1BEQghaRr80b7PRpu4vg2+7cwO01k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5214.eurprd04.prod.outlook.com (2603:10a6:803:62::21)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 10:21:42 +0000
Received: from VI1PR04MB5214.eurprd04.prod.outlook.com
 ([fe80::396c:f971:9798:7280]) by VI1PR04MB5214.eurprd04.prod.outlook.com
 ([fe80::396c:f971:9798:7280%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 10:21:42 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] client/player: Allow the user to control BIG encryption
Date: Wed, 20 Dec 2023 12:21:18 +0200
Message-Id: <20231220102119.74090-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To VI1PR04MB5214.eurprd04.prod.outlook.com
 (2603:10a6:803:62::21)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5214:EE_|AS8PR04MB8213:EE_
X-MS-Office365-Filtering-Correlation-Id: fe6e2fb1-842c-4eb0-5ed2-08dc014575df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2EKDwCH4hG9syXzhj3nvSSfWTZq0eV+vysAgH85m1HMfE7XoWM0iWosnzRsbsF+Kvp6SeTp07AJTCyNjOyWuEslHY9iw7TrkjZGLgy0utqtIm0WYbT6DplyH0KRmR9t7SsUmO74iVY2fiZL5HgT1ChYfhexghnhLwn1yXqhkYMaBlKBs3TyKQzUjt8LEsHzoJSrtYqfYhX9G/2i3JqbvEB9uiKSkPuLg/r1I9OjpHxGKolisSV/1Tr9DeCIl1XuL4GYtWNF5prx4/EtmbFwIKj+CZ88W5sBDTeHcZrP30lOk/DQDdmCsJJdH2pEh6TmlPwcIQ75tkExAZudD5gZQW29GyI2oL+BowDZwI8cRbheR30D+cncT894A8ZS/T6z9bXg+LY24U/M562pjsdK8QIMx/XOvNv4aMuOdD7J/6La0vTiDL10zLXTZDDAmQX4zFQaM4x8ODfusDZE0vxL66JUSg8r4UVHe1A4HkytwMTJ+fpTRYIaoA0XyCNYxdDrXxsNts6VFLXY5Hu1CCtmre9B0EhU+sRNfohIArcnXQ8iKN7N2hQ8FhuQTjyHIxPvGYLa4/r5wzehf92VlHka3L6lHWLtSWDEla0Xp/EUhF+azHi2ygIF+wc/xV6Tth73w
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5214.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(86362001)(6666004)(6506007)(6512007)(478600001)(1076003)(52116002)(26005)(6916009)(316002)(66476007)(44832011)(66946007)(66556008)(6486002)(83380400001)(38100700002)(5660300002)(36756003)(2906002)(4744005)(4326008)(8936002)(8676002)(38350700005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ankFACS8vkcrPH+OsLcV8B51AKXAJl67KBWkDuhRFnCsXLa3u7i7WG8q5oj8?=
 =?us-ascii?Q?6O+1hdtlxIafipjZCIAXiTBeWEZMWtJjUvdX7S7RvxgNZmPkWEOnkCTV5ELO?=
 =?us-ascii?Q?NDfKbT6p7TTFO3ojZ+MroRLuA6jTHq01qpLsiq9om6ICYyzKZeIA/ehXGZs2?=
 =?us-ascii?Q?du77k86N7WF/prSxx46TDzeT1sPLGYzBO/Jefo34TSF7auGYnF+8CECAcZlq?=
 =?us-ascii?Q?zCWULCQY/eryPMw1/DKQWsEvazF1afXSZAkxidfJEgzcufCygj04dwUINSDy?=
 =?us-ascii?Q?vuz0E49le+fruY/CthCUxXWGn8DWE64CCtBeNzayVJBBGYBylraxacns5Tza?=
 =?us-ascii?Q?LPIts0SR+iogpDFjon+86CaPvaKgQ4frUaAzCrHTN/We6v9CrdmjMRcoYeGm?=
 =?us-ascii?Q?GKS0Vwca+coNjvROBxfgWiyJLgvSLkZcC0Z707fwIVtzFqfoHCE5BN5aGahQ?=
 =?us-ascii?Q?9/nm0qxIJnQTbGLpx87BhO4qplc0FBmxpQNB4l/FMjU7WeY5+llieMY/v1Gw?=
 =?us-ascii?Q?1LABJ4bOY/XEgHAHpK+aV2JqM17zOkXOEbVyaI3gV8p56PsjHtKrbVLLko7h?=
 =?us-ascii?Q?33rEnZB4diQM0i29I5BtwUMrspJC36mjN1qVKrQ9v6ghs2YCa8xDxYssb07y?=
 =?us-ascii?Q?RVHuNEDvBIgVQrOUpE4TvlieVejJA3609XpC4k9a/z4RsgUYnT9qSJPoUVSr?=
 =?us-ascii?Q?OuvJVr9/d1A1iQp0TsAgUAlG+eEBHN7xFIpnDkzaARuV4ywCbFpnlwWYAZIC?=
 =?us-ascii?Q?WDMb7UErMuj/4VPduRp6VmfrLsFStFSNMpDDVRCs6bexPq43o1L2/S7YtIBf?=
 =?us-ascii?Q?HaOIowxmTIJVPxPjrJxcnrTDKrRDQsYfGWj7zQEcGYakdgGWiH9iUypnq4mF?=
 =?us-ascii?Q?AyDJqDq4UIeO9LD48zBibJWDUZ3SkCY8a+WMN8RAsv6SFrd/lSQ1kKtDlAbA?=
 =?us-ascii?Q?v7BWFj+fRO76+LCCCJswsN4oYMr8wHjCD4uXN4D3YTJXWj+t9TeYg6RMrBNW?=
 =?us-ascii?Q?4b+2mqrGIxLeLDYiGA/K0X1s9Y1N6EYo97Za1YlA3EkgYs3x7KpETRR4Ftug?=
 =?us-ascii?Q?OZmZupyOXwhLmoYnzPqzTz+OaWmSZRKGUo5ZFU9+aCUCozC3T+rx1yZjzUXs?=
 =?us-ascii?Q?jpojhtDEbMCp4oc/lVQrpfMlVqLVJIeRxVr3SduDHYy/77TIus6gloLqH1df?=
 =?us-ascii?Q?8zbMtEMJodriqh99LBuosQE1YgUkAztgpeN0lKLobhuL6gf8WV6ZfPai2sSj?=
 =?us-ascii?Q?QaDq+fJgQ4hKmcmzSAUONZPJJdqWqstgRdCQrJBAVSz8b1sTcjNK4rS1UFab?=
 =?us-ascii?Q?doxktqjXW8QP7MJWEWYWAMGdpg9GvXwtfpMpcKnyVGqxftWKEX/Ba+h5raKh?=
 =?us-ascii?Q?ZQEml+57J0mL5EUOs/UFpt8XBNhSHNYnU20SkBgoraOzrpuXszmWTc0x1S7j?=
 =?us-ascii?Q?QlEz7sDow5Oe8zHL7aYryWT7ziYvQ646tYHciEocTPH68CpIKaT66PVB+uQN?=
 =?us-ascii?Q?seR91ziFEI/Uz+a/mDG1m1bZqRCTCYjo77LfeDZiIiUiPOyGPFk0YJgE4hD5?=
 =?us-ascii?Q?gp0G1FRkaerN8YP6oxQbcbVPDj+qOZCRsnTCBfhy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6e2fb1-842c-4eb0-5ed2-08dc014575df
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5214.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 10:21:42.4241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4kKWWK55Ua0ww6C2GdpKIbPfXHwk6R02IiMkH6Q2psAMPnM+WfjeqK7LCQtsqnAgRfS64LXBJdBBS+SjDkzAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8213

This commit adds support for controlling the use of encryption and
setting the broadcast code. On the source side the user will be
prompted to choose if he wants to use the BIG mode 3 encryption,
and the Broadcast Code to be used (custom/default value). On the
sink side only the Broadcast Code option is displayed as the use
of encryption is set according to the BASE of the source.

Vlad Pruteanu (1):
  client/player: Allow the user to control BIG encryption

 client/player.c | 75 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 59 insertions(+), 16 deletions(-)

-- 
2.39.2

