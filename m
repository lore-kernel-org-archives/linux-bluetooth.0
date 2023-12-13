Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="f9j+LmVJ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD757B9
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Dec 2023 07:56:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aixz7EaFnQBFj7t9jMVIJrZWPNa65C4n7JxbXKQ7h0akEYIkI8shgujo3A1k0myBw9FEyfd382s+FFDg31QCwbUURCHZvcqgmcH9o26Kg3D7PWAc5ldCJ7WpsDdrnr/+4r3lP+O8Fz2amV0WuUJt10QVPkdTT4HhnSOWL/ZY/PRpoXhehCE+C/Yy2y6S//xT06rF6VT0e48LU2bxTWXhZ45SoRD0AVSkmQIeufmvCjlDb7VuZzgb8so2HN2ZOrwzS0aceHDlx/tl0wVkgB+MY0G0OdQywHwjjEIjEbf6f8mbjowUxGKJmUxnpIg0rF3fV0J062WT2WIq2CTqudthIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxtTfTYTBqImdfk3xZKushbl3YVM5gcZxNbfsNoTSp8=;
 b=JdkGuiAmD4xqz8iKNH8Jv70IqvlSOkknG09E08YEn3spH1P0GSHVSBQx8YqwTbWEZvhPgCacaLdKT7OBZd14NwfCwCfmdGusy2q96C1exaFNosJ8blDR28PMARScsmCdsfFwqvyXEazljVih1OzNq8KXRqnvGsCrXnl3O50StZ1lUxLf7sgBZffTPVpzGe3juqC5+XwlhSH4PhZFnPTXWP1e8h/Y4ZH5ZZn+nC2pZCfjxxuQuoq2hk4ObE7gxtQXDxpnj7K8EcFJegisyuswU4bNnOdmn7li51FBJrkhxEFIcQjk8YwqYuD/4QzKsKNk6CJu6bOKCFyxzsBjQcK4gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxtTfTYTBqImdfk3xZKushbl3YVM5gcZxNbfsNoTSp8=;
 b=f9j+LmVJDQJrxu7j9Ve7dFZUlF/UQCvhv4ZEqTIiV3E+9XBMDO7Hi94+0x/b2G5ITFfBXzcMJ5YzG3wle01tY7f0N7Lod3omqiMJoFFIOYTmSHe2kLOPUGvM2TmTinwkes1xwHaCQz1v7aRNmuUftft/BY0weeC459n8XQMNv3o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB6927.eurprd04.prod.outlook.com (2603:10a6:803:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:56:10 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d%3]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:56:10 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	silviu.barbulescu@nxp.com
Subject: Re: [BlueZ,v4,1/6] bap: Allow setup of multiple stream per endpoint
Date: Wed, 13 Dec 2023 17:56:06 +0200
Message-Id: <20231213155606.3610-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZ+17-4r5XGnGkV5Mnd_ZzsKL0xNwhHbS0tdri9D7=U-1A@mail.gmail.com>
References: <CABBYNZ+17-4r5XGnGkV5Mnd_ZzsKL0xNwhHbS0tdri9D7=U-1A@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VE1PR03CA0059.eurprd03.prod.outlook.com
 (2603:10a6:803:118::48) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 717a86f8-9f38-4ece-a6d3-08dbfbf40698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ulqz15BcT/EeTYIkipF+ONFp0VjcO2kNevbpWqR+sFLjHRLc8dRTgsPYvPQsnFXCXjPKVMZc/imZeEvZV3w6IY0KTzgzywIRwVSQNbGFbltvEj4gzJcwrZjEAEFCYQH1e8r0ZBwcKCqQQKddbnVQdLho3VQ7FMO96xoACTIvLpveCdI8kf1SeJGwB8Oziq9TI9yg2zlAkOoJ7FGiG5Teo1WULb7HjQDnBYJPC+1vd1tDGfBpXv4KGlWF6PxkD2JvrORXm5fmwBUoxJw/9Q76FTTTgmb2QvUl2H8x3w/G79OHCZ1LPnajGZD50LP2wPfynIuOgbrQXbOC9UYeB8NHw2AAvTIi75/EW0Q2tasPlfI/iXMv+a13Jg1O1KpF15cvNZ6DxtyRzjGVn7Wz9VnhM0Z9VHPWYkJ6b1g1d6UVVAJMu5RcFNiSZr4ZP8kKxL7viZSArKdy3jzdLQQ2tmbgwNQuk7baT6ESpLx24nEYOu1dRJDqka+oUPsbEX0F8o2ALKc9J+0s5Uubt6vAousrgyUoko5lwenqaaXc2bUIfBQIPiICNaSzmldTjeC8bILddWb017AGcdqKt0neWZVJISxfyKqrvBuifQyrqGhypUXkLT+8QBupVnJcjdHuUb65
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39860400002)(376002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(64100799003)(186009)(451199024)(1076003)(2616005)(26005)(6506007)(6512007)(6666004)(53546011)(83380400001)(8676002)(45080400002)(5660300002)(966005)(44832011)(4326008)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(6916009)(66946007)(66556008)(66476007)(86362001)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tK9q5LLxLtr2mhlzS7+KWfJMJPiAsuaMMbwMc1TTo0NUl37NYrCeja1Yfe5F?=
 =?us-ascii?Q?qCgMUwgNuKjGiqqXICMfJVDrAlqOH44cZ9XCW3zq87sU+xamKVBlZdVct5Ae?=
 =?us-ascii?Q?og6MLAStvGjSMApXM2VR/OjNaBG+ACfp2rBG2oASWNwA6XUIkJ5Vf22O9Uh2?=
 =?us-ascii?Q?9RXuRkcZmaEdwD0mElpSdlQCkpJKdldWTeBWm5jmeXUR579HTUiVogjCqZUT?=
 =?us-ascii?Q?+6X6amtjfV52GVk83P2rhOZUFAneaRffHBbeTxJYQ0CutAx2aWGDanBwqgQz?=
 =?us-ascii?Q?YthKfxT2SBzBZtpEkgSMA2Qp+Rhs8oy4MhLcJYN4XVm6e7iPME8/iWJ6RaN+?=
 =?us-ascii?Q?OyfzTL0/IsoRiQuGpQPRJufvafMrdnXiMdCZaBeiGCDOiAkLEV1XeCIZkDDK?=
 =?us-ascii?Q?9Z005oCg2oH9ex2o3QOPIMjmA139E+Cy9pjCvazD821Rn0GFq8nVEHZ8Y5f6?=
 =?us-ascii?Q?gJc6TAImQu4lLLkVd40dJVpBK++d2Dz7q8ErRg3/D49WeqdqrKUy+RlzrtOW?=
 =?us-ascii?Q?8Ln+HRIMfYjS3+xmB0XQ0GzgEAfOpEocQLYj3a+h3Gh4xAe7mxTmQtj4pElk?=
 =?us-ascii?Q?QxFeTWljAjlYO85rFaTzhFOfiwyE0YMLBTYfqFIEYA7KG4q2564L6ES6537v?=
 =?us-ascii?Q?Rk9j3OXPpZQElCMPy/+ga+QOAQhnkW07F7CnIdQL0OQERhofT2FxRXkbfKWR?=
 =?us-ascii?Q?0A23KI5Z4d88weW+T5R/5N7EcyS90wW85C6ya7ULTl98p/CQVKOmE5LCkukH?=
 =?us-ascii?Q?Ob7OJLnGjdRy/gShoWbULvB+7lezRBWHjKvtc+kx/6NW5M/Op32SUqEXpHLB?=
 =?us-ascii?Q?v6zZhfwABcX6I1jtoy2ghWHk9FK5wd9JXC3U+OrYAVlF+x9VBGieM7ytunvV?=
 =?us-ascii?Q?Rp2BOoDIEUYfR3I689+SJsd2QczCuEotIZB25x7T+cTNcE1WQ50jzVKQ4lJ+?=
 =?us-ascii?Q?Cx605knbjosMACd+KoqxYztX3qwc7NRWRB5Gvd25canvwICyCdNct1PH9lnz?=
 =?us-ascii?Q?p/49Z9bZb2YMkkXvtKCISc1BogiKfcvSrCiU6r31RaJz1Wlefyl39Z3y4PRC?=
 =?us-ascii?Q?AWACDTYIBC5wHDwfi8YB0VEzGP7vCN//OQ3OpZ2+WBhM9mtsWVtSrqL9c2U5?=
 =?us-ascii?Q?xwzyOFMAT5RVw7QE7iB1MdSdxdGUI9XH+cBmXuBXGB2vKARlwYHTkCkpmd7+?=
 =?us-ascii?Q?lHiVdRO1BKAx+IqzL4S9zc36kbvLajETrpgJrrM72kxOR0ih+PETg/EgNe3R?=
 =?us-ascii?Q?/v/a1iMqFwxwwdP2aADqz8lMLJcr8Gpv4Bz+T7V2TFTuoVYb5zfZR79j+dGU?=
 =?us-ascii?Q?sYby4BCx4ZIERQVsPUcmkq92YuPT1du85JiInzsvIl5Lz2FKCCOoxvtWamgo?=
 =?us-ascii?Q?aCUHT1JnW0/XEAFnjAld9V1srWjT6o9RfJJQswJM35e/38CGWm/77qffW8Nl?=
 =?us-ascii?Q?lVjmu/HZs/wSzrGdvqgPrL2gqBSbLyRb/VWyzyQsoW/P8NVo6nAO/x0mdKRF?=
 =?us-ascii?Q?7I+hQjrXic+n+44yGiH8gYtitCptSkH/40gk2aZ0PnlVYZP5UlknFhqMhAZ/?=
 =?us-ascii?Q?gb8XdZ2IS6ePgBtwLXX79Jveg69FoABOHGGXw/Zkj6vg3tmQvd4wv40L1eyt?=
 =?us-ascii?Q?gw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717a86f8-9f38-4ece-a6d3-08dbfbf40698
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:56:10.5718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6+UH9HNaJ9OruGU9TwcKzv+1cn4OvKd8JNLBaI6DeVBPk3m0g3oDdGCZ4oMtzCmSGJ6uYZzZwbpphgmsXTUgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6927

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Tuesday, December 12, 2023 7:54 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Iulia Tanasescu <iulia.tanasescu@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>
> Subject: Re: [BlueZ,v4,1/6] bap: Allow setup of multiple stream per
> endpoint
> 
> Hi,
> 
> On Mon, Dec 11, 2023 at 6:31 PM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW
> > Link:https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2
> >
> Fpatchwork.kernel.org%2Fproject%2Fbluetooth%2Flist%2F%3Fseries%3D808
> 93
> >
> 8&data=05%7C02%7Ciulia.tanasescu%40nxp.com%7C75f2033d3e9447dbe67
> d08dbf
> >
> b3b5e2e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6383800
> 0462083582
> >
> 0%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiL
> CJBTiI6
> >
> Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=aKuHEA2BNmk3B%
> 2BztdPJ2Mhl
> > X1443Ki34d5537bCZuhE%3D&reserved=0
> 
> Could one of you guys please verify that this set doesn't break anything
> related to broadcast.
> 

I tested this patch series for broadcast and I found two issues:

First, in bap_find_setup_by_stream, for the BT_BAP_STREAM_TYPE_BCAST
case, the function returns a pointer to an endpoint, although it's
expected to return a pointer to the setup matching the stream.
So it should be something similar to the unicast case:

ep = queue_find(data->bcast, match_ep_stream, stream);
if (ep)
   return queue_find(ep->setups, match_setup_stream,
	               stream);

Second, in set_configuration, after allocating a setup using
setup_new, you should also allocate setup->base:

setup->base = new0(struct iovec, 1).

Otherwise, the configuration will not be parsed correctly for
broadcast.

We have also prepared a patch series for broadcast multiple BISes
support, but we will have to update our implementation based on
these patches.

> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    PASS      2.70 seconds
> > GitLint                       FAIL      1.73 seconds
> > BuildEll                      PASS      24.71 seconds
> > BluezMake                     PASS      780.94 seconds
> > MakeCheck                     PASS      12.60 seconds
> > MakeDistcheck                 PASS      164.82 seconds
> > CheckValgrind                 PASS      225.11 seconds
> > CheckSmatch                   PASS      330.30 seconds
> > bluezmakeextell               PASS      103.81 seconds
> > IncrementalBuild              PASS      4181.08 seconds
> > ScanBuild                     WARNING   990.81 seconds
> >
> > Details
> > ##############################
> > Test: GitLint - FAIL
> > Desc: Run gitlint
> > Output:
> > [BlueZ,v4,2/6] shared/bap: Make bt_bap_select match the channel map
> >
> > WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python
> regex 'match' (match beginning) to 'search' (match anywhere) semantics.
> Please review your ignore-body-lines.regex option accordingly. To remove
> this warning, set general.regex-style-search=True. More details:
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fjorisro
> overs.github.io%2Fgitlint%2Fconfiguration%2F%23regex-style-
> search&data=05%7C02%7Ciulia.tanasescu%40nxp.com%7C75f2033d3e9447d
> be67d08dbfb3b5e2e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C638380004620835820%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> C%7C&sdata=GaHyvhsb4TOR1ksh3KcJ7f%2BLCN4JynFFoQdFs1cd2d8%3D&res
> erved=0
> > 13: B3 Line contains hard tab characters (\t): "
> 0000a0201030202010304280001020206000000000a02010302020103042
> 8"
> > 14: B3 Line contains hard tab characters (\t): "
> 0002020206000000000a02010302020103042800"
> > [BlueZ,v4,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to
> > SelectProperties
> >
> > WARNING: I3 - ignore-body-lines: gitlint will be switching from using
> > Python regex 'match' (match beginning) to 'search' (match anywhere)
> > semantics. Please review your ignore-body-lines.regex option
> > accordingly. To remove this warning, set
> > general.regex-style-search=True. More details:
> > https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fjori
> > sroovers.github.io%2Fgitlint%2Fconfiguration%2F%23regex-style-search&d
> >
> ata=05%7C02%7Ciulia.tanasescu%40nxp.com%7C75f2033d3e9447dbe67d08
> dbfb3b
> >
> 5e2e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6383800046
> 20835820%7
> >
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBT
> iI6Ik1
> >
> haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=GaHyvhsb4TOR1ksh3K
> cJ7f%2BLCN
> > 4JynFFoQdFs1cd2d8%3D&reserved=0
> > 1: T1 Title exceeds max length (81>80): "[BlueZ,v4,3/6]
> org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties"
> > [BlueZ,v4,6/6] client/player: Use ChannelAllocation given on
> > SelectProperties
> >
> > WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python
> regex 'match' (match beginning) to 'search' (match anywhere) semantics.
> Please review your ignore-body-lines.regex option accordingly. To remove
> this warning, set general.regex-style-search=True. More details:
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fjorisro
> overs.github.io%2Fgitlint%2Fconfiguration%2F%23regex-style-
> search&data=05%7C02%7Ciulia.tanasescu%40nxp.com%7C75f2033d3e9447d
> be67d08dbfb3b5e2e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C638380004620835820%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLj
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> C%7C&sdata=GaHyvhsb4TOR1ksh3KcJ7f%2BLCN4JynFFoQdFs1cd2d8%3D&res
> erved=0
> > 13: B3 Line contains hard tab characters (\t): "
> 602020600000000100201030202010304280005030200000001020206000
> 0"
> > 14: B3 Line contains hard tab characters (\t): "
> 000010020103020201030428000503010000000202020600000000100201
> 0"
> > 15: B3 Line contains hard tab characters (\t): "
> 302020103042800050302000000"
> > ##############################
> > Test: ScanBuild - WARNING
> > Desc: Run Scan Build
> > Output:
> > src/shared/bap.c:4766:23: warning: Access to field 'type' results in a
> dereference of a null pointer (loaded from variable 'lpac')
> >                 if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
> >                                     ^~~~~~~~~~
> > 1 warning generated.
> > In file included from tools/mesh-gatt/crypto.c:32:
> > ./src/shared/util.h:228:9: warning: 1st function call argument is an
> uninitialized value
> >         return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./src/shared/util.h:33:26: note: expanded from macro 'be32_to_cpu'
> > #define be32_to_cpu(val) bswap_32(val)
> >                          ^~~~~~~~~~~~~
> > /usr/include/byteswap.h:34:21: note: expanded from macro 'bswap_32'
> > #define bswap_32(x) __bswap_32 (x)
> >                     ^~~~~~~~~~~~~~
> > In file included from tools/mesh-gatt/crypto.c:32:
> > ./src/shared/util.h:238:9: warning: 1st function call argument is an
> uninitialized value
> >         return be64_to_cpu(get_unaligned((const uint64_t *) ptr));
> >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ./src/shared/util.h:34:26: note: expanded from macro 'be64_to_cpu'
> > #define be64_to_cpu(val) bswap_64(val)
> >                          ^~~~~~~~~~~~~
> > /usr/include/byteswap.h:37:21: note: expanded from macro 'bswap_64'
> > #define bswap_64(x) __bswap_64 (x)
> >                     ^~~~~~~~~~~~~~
> > 2 warnings generated.
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
> >
> 
> 
> --
> Luiz Augusto von Dentz


Regards,
Iulia

