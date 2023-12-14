Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="pUGUVXMG"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2074.outbound.protection.outlook.com [40.107.13.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3D311A
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Dec 2023 08:24:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByFMPFqZmL+CxmUcGw78ODn3VBcveXmd+LS+j9SKTL+RM5vHVhRq97Pjzua5Ersj4VQRKEF3wrzVn1pzwxyTV90xIRw6YmN4GCxBA2LKq8/HOIKxJTPqbRJYQBSjoIx6XUq13mQWrwcx9vhIEkDBVXawFANOIyjNsaDeNpbtYzqfjTEAd5Z/+KB6gyx/6rSjV/aRWYmX7scNHg9P8NNHPl6KKd8m25Io8/iLaWp8iJpCx1AvAqgKpnGsBBCqIB3SjKVjMTt77q8GARCGgHX1lL4RVblCgufvK/UFvd/kseqIN2/Hr9PZeleUI+UA/04vLCxNSUUtq7sn74tavJiIXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+ocbswktI7HhmJ+6Wc7D5n69Z/3uoZFBVsU9O/2juY=;
 b=axDgocr875iVYQILV2yMKZNaZ7AhKXk/oOtwVl6poMtX7DyDE0OWt1N9RMfSAijqbWEqnaKj2pCMddxa7AMQ2o1f1SXwMWhdvMAb88nSrRGHUKS4rwnYc8CTKT+VvSEWktAW2d83TsNLTSmN4UbaIlONJ93djQbPXVRjKUV5l8G8jPcY2zYXaRP5NXj7/sW+paCgjfQZ91PrjENAu9k5cjoue46ytTHH4lAAw6wc6VmJnallKrs6p1apYHOKwol1GDepPD5+N6r8Ikg9969l6d960AvSR6zJtbWP8mIM5UlANbSQuQMkmYmRue4sX6340rP8czcqAxfGuLU2401PSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+ocbswktI7HhmJ+6Wc7D5n69Z/3uoZFBVsU9O/2juY=;
 b=pUGUVXMGuQIxtMRss4n1YUiBQCvkPVcdEsIfsD+sAj7nxJFP/bkxwIpuvoNqnGjoPGSmhpLslUd/dfkFZouVoGPCJgh5XqtGkvU7TbMJEWkzArGoUrqSsZ7K+ZNeJP/Kw8XrfQEajUyq5znqyGJoSuh9qEEatLmAbxE/TbadVXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7504.eurprd04.prod.outlook.com (2603:10a6:102:e6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 16:24:36 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::25a:e1cd:f957:6e7d%3]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 16:24:36 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	silviu.barbulescu@nxp.com,
	andrei.istodorescu@nxp.com
Subject: Re: [BlueZ,v4,1/6] bap: Allow setup of multiple stream per endpoint
Date: Thu, 14 Dec 2023 18:24:31 +0200
Message-Id: <20231214162431.3068-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZKCnpr3D-nbZwMZDzuMz7CAOa_6e3+etjTiAfJTCKiU+w@mail.gmail.com>
References: <CABBYNZKCnpr3D-nbZwMZDzuMz7CAOa_6e3+etjTiAfJTCKiU+w@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0106.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: e450097b-3dce-4cc8-48e9-08dbfcc12996
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1CEE7QXz0Jz1KYBwn3PlObOt6M9WDO5pQ2kD9Bt/0ZJZUsDbWnYf3vBTrHOxP7RD/NALmvICIV9/xf7ManFYZ5IDiNjErt8Dq4zpM5R4KqoI+LA1kzkpfDA4ZgXYefx7Y+VYEDU3DKZ2s+sm+Ab5oEbHd4xeMEwrGYUomG9PbRavyd7AR+HEkSFZD3QpWWyJ9LAHJTOlrIeMoGeNT931rePmuM7gJPB7XKA3IwVlIEeNQ5GZ7e0cZ9iw6uwhpKCg2W/V7ML1ynX7sBqVPAM3qW6a3bALNjwPGQ7bvBFLoDZ3bR+bT7KuiC/Y9Bd5F+TVVnVLRrDwFws99u9cPHwX2ff8LKdpYmIkaBb42HSQy+mn/nsC6E/xfkF+YR28l+PWnTzQhKS96S/MW5WNkpFiX7jwQuGMhvP7hkAkrMpLgdfOqV36lx8Lv4+GxOei+NGkHTGNj85vao33a+M/+LzKfc8zPIRRunNwSBVqU8qKTrQPOKucnr/KZxRZTKCs4COX0avAtc1zsgKCSJ0wnMQ4ZZKqiZ/oPxKKl5AjbhtD639XblBTIso3MM/bQ1VKuCYq5zn4ZCbe5C7Uf7vD5qmy5+X73oHT1Iqau5zc+FWuovRZsuj0GF+LPqrNc20lz+62
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(6916009)(316002)(6486002)(478600001)(83380400001)(45080400002)(53546011)(66476007)(66946007)(66556008)(26005)(6506007)(6512007)(1076003)(966005)(4326008)(44832011)(8676002)(8936002)(6666004)(2616005)(5660300002)(2906002)(30864003)(38100700002)(86362001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kq8g3ZvYOzCJVWTV1pjLJIZ6qBVV0bbC3anSnjXPeiKTnBF4kqfOh4oi8/6M?=
 =?us-ascii?Q?a7gqutqVXflxq1F2TBrW+GoNGbxOu4YJlSAtzeYe7ukEU8muSPCjDbUSOM3C?=
 =?us-ascii?Q?7bbyDOIHEpRP+UlsXKAkCUSZ46Xf3kPuiSI4QNCeBqEHVY1hRAOxt7u2gET/?=
 =?us-ascii?Q?+ZDrGukB/9G2A5ljkVUbbfC9gSRQYV0ZggFlwCInrc8TdUHvvHBIo25tKxsh?=
 =?us-ascii?Q?9WXRhCAk5L9nW2lauk70AoIKIBDRodilN5/+eGO4ysC1ESd+JbB/fsASGhBe?=
 =?us-ascii?Q?3vZcvjRUaQ0tMvrKYBKzpIlqjDVUPn/S2V9FzMesswOBfJAJErQMUGyGMF8D?=
 =?us-ascii?Q?M9yFatX9dbQsFWR9WWO+o8v/OQz5p3teh1+jC/mjzWlX7O9KyUpkmvRPuTib?=
 =?us-ascii?Q?nesdB84VIjalxEfNZQys8bYAwoOZpfVZ4Q2gWsmZbnRhf7+kk04wTYq7bq6X?=
 =?us-ascii?Q?2eYEngnc/P/bVODTpZtfEG9RJCUuf+0hvqSCgF/MECPGXhHQoIXwDRiMhcSx?=
 =?us-ascii?Q?BkroqwioYDS4QpOI77Igi98TiMTJNJUH8ppx3ds37/aZky5cxdrQFIoJ9OpO?=
 =?us-ascii?Q?RhGUil6PCyw+KEVhsxLvr3WtGyHZyPDgJITYwM2MYiWtADgdvr9Yr9EgxcVn?=
 =?us-ascii?Q?4dgXMSrx7Hc1tZbQSbuVNpCpWGfEbVQKK2sxNoHc1DrDjd10EiDnAfuI3gI9?=
 =?us-ascii?Q?f5NdKaENJ9TMoinYIbu7FHU1o7/Zs1Om94Cc1kOsNgzplK/SozW3YdjhGbzK?=
 =?us-ascii?Q?yrlNIfS8b2x4aCsNWPVnj4VQmnCGoBPcXKEsSNFGEpoOt63N7MXkcdi4IcLq?=
 =?us-ascii?Q?2ebw+PJQZh+q3nVTU68pMagAytl5CbhVAe7J5TArgHtKDk9fAS4NBtC6maEI?=
 =?us-ascii?Q?rd5sSzD8VAAQ/g3oJLU9Pu+mlufTx2fKyvDtCCTFhraNbzZHKzfjVTm9KGl7?=
 =?us-ascii?Q?3fQIx7qYoe02CBN+x8vND9pHh//3YUlsBDe9auFjGKQ45b+7rmaiOQy2oqTU?=
 =?us-ascii?Q?1rXwY1kzmz9sflnPL6cqWHXhMJYp7Z+NlAQ7VeCNMCSqXfwFSVdgBWpxHnCL?=
 =?us-ascii?Q?K0fALyDgY5MTSqTmb5uIuPs/EZ1muPCurWXZYxQ7ASOMU7igqt14fXwFilDO?=
 =?us-ascii?Q?4piB7za9uQb6QaEUW8d0LLohhrCSxPaDhs7V4AjSswLz5kKf//Bxqr+Cwd4B?=
 =?us-ascii?Q?Wc6me1kLb8eefj2iPa5oBfuDtW0xpzx+BFiQlN4EI0rKypUGYQzzW3B7ZGAN?=
 =?us-ascii?Q?uL3W6/meQiYgXXzHMzitsjlfxlLgg1jH6vIBJ4lJIVinAWYxpAtyOuCwDeSH?=
 =?us-ascii?Q?fXIEw1/6ho12KGoky6uD3aXTrlBZWgZ5FPMs3LueGTcUAlBNa8kzKzUrSUiF?=
 =?us-ascii?Q?iRr1KQlKEvmw8VIlIjMDIp7vPE3RDQybxVsFn7rSZu5ob5m6z0RpLJexBBxB?=
 =?us-ascii?Q?6PK0wi4PdRLE8rEIyVhhdu52RCbB+bkInZlRLsaAoCwWeLNB0mi5S5meXZg9?=
 =?us-ascii?Q?DvqAr2uC7WXx2DXGPWo/krVRD8hEoMm/UE4apDYfYctvuWotUPBhH40ZcCWR?=
 =?us-ascii?Q?teod70Tzsj6iSFvtEcpRvNHUM1QY+NAhb3BWFPj2Vbr0C3xr3Ie3GN7h0Jr6?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e450097b-3dce-4cc8-48e9-08dbfcc12996
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 16:24:36.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CM0M/REkCKuJWUExiOlDQgqufygozDwB/xevtDERCm/t04n7+FnjSWxXVKoulTB+yTovZO6ipIO9OwUxtDRxEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7504

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Wednesday, December 13, 2023 6:08 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: Claudia Cristina Draghicescu <claudia.rosu@nxp.com>; linux-
> bluetooth@vger.kernel.org; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>
> Subject: Re: [BlueZ,v4,1/6] bap: Allow setup of multiple stream per
> endpoint
> 
> Hi Iulia,
> 
> On Wed, Dec 13, 2023 at 10:56 AM Iulia Tanasescu
> <iulia.tanasescu@nxp.com> wrote:
> >
> > Hi Luiz,
> >
> > > -----Original Message-----
> > > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > > Sent: Tuesday, December 12, 2023 7:54 PM
> > > To: linux-bluetooth@vger.kernel.org
> > > Cc: Iulia Tanasescu <iulia.tanasescu@nxp.com>; Silviu Florian
> Barbulescu
> > > <silviu.barbulescu@nxp.com>; Claudia Cristina Draghicescu
> > > <claudia.rosu@nxp.com>
> > > Subject: Re: [BlueZ,v4,1/6] bap: Allow setup of multiple stream per
> > > endpoint
> > >
> > > Hi,
> > >
> > > On Mon, Dec 11, 2023 at 6:31 PM <bluez.test.bot@gmail.com> wrote:
> > > >
> > > > This is automated email and please do not reply to this email!
> > > >
> > > > Dear submitter,
> > > >
> > > > Thank you for submitting the patches to the linux bluetooth mailing
> list.
> > > > This is a CI test results with your patch series:
> > > > PW
> > > >
> Link:https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2
> > > >
> > >
> Fpatchwork.kernel.org%2Fproject%2Fbluetooth%2Flist%2F%3Fseries%3D808
> > > 93
> > > >
> > >
> 8&data=05%7C02%7Ciulia.tanasescu%40nxp.com%7C75f2033d3e9447dbe67
> > > d08dbf
> > > >
> > >
> b3b5e2e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6383800
> > > 0462083582
> > > >
> > >
> 0%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> L
> > > CJBTiI6
> > > >
> > >
> Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=aKuHEA2BNmk3B%
> > > 2BztdPJ2Mhl
> > > > X1443Ki34d5537bCZuhE%3D&reserved=0
> > >
> > > Could one of you guys please verify that this set doesn't break anything
> > > related to broadcast.
> > >
> >
> > I tested this patch series for broadcast and I found two issues:
> >
> > First, in bap_find_setup_by_stream, for the
> BT_BAP_STREAM_TYPE_BCAST
> > case, the function returns a pointer to an endpoint, although it's
> > expected to return a pointer to the setup matching the stream.
> > So it should be something similar to the unicast case:
> >
> > ep = queue_find(data->bcast, match_ep_stream, stream);
> > if (ep)
> >    return queue_find(ep->setups, match_setup_stream,
> >                        stream);
> 
> Ok, I will fix that.
> 
> > Second, in set_configuration, after allocating a setup using
> > setup_new, you should also allocate setup->base:
> >
> > setup->base = new0(struct iovec, 1).
> 
> Doesn't the base use util_iov_dup? Perhaps we need an update to code
> to start using that.

Our patch for multiple bis support will include updates regarding
base processing, so this will be updated soon.

> 
> > Otherwise, the configuration will not be parsed correctly for
> > broadcast.
> >
> > We have also prepared a patch series for broadcast multiple BISes
> > support, but we will have to update our implementation based on
> > these patches.
> 
> While at it, perhaps it would be great to create a sample script to
> test broadcast with bluetoothctl.
> 
> > > > ---Test result---
> > > >
> > > > Test Summary:
> > > > CheckPatch                    PASS      2.70 seconds
> > > > GitLint                       FAIL      1.73 seconds
> > > > BuildEll                      PASS      24.71 seconds
> > > > BluezMake                     PASS      780.94 seconds
> > > > MakeCheck                     PASS      12.60 seconds
> > > > MakeDistcheck                 PASS      164.82 seconds
> > > > CheckValgrind                 PASS      225.11 seconds
> > > > CheckSmatch                   PASS      330.30 seconds
> > > > bluezmakeextell               PASS      103.81 seconds
> > > > IncrementalBuild              PASS      4181.08 seconds
> > > > ScanBuild                     WARNING   990.81 seconds
> > > >
> > > > Details
> > > > ##############################
> > > > Test: GitLint - FAIL
> > > > Desc: Run gitlint
> > > > Output:
> > > > [BlueZ,v4,2/6] shared/bap: Make bt_bap_select match the channel
> map
> > > >
> > > > WARNING: I3 - ignore-body-lines: gitlint will be switching from using
> Python
> > > regex 'match' (match beginning) to 'search' (match anywhere) semantics.
> > > Please review your ignore-body-lines.regex option accordingly. To
> remove
> > > this warning, set general.regex-style-search=True. More details:
> > >
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fjorisr
> o%2F&data=05%7C02%7Ciulia.tanasescu%40nxp.com%7Ca4106b62fbbc421
> ba8b408dbfbf5aeb3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> C638380804836966878%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> 7C&sdata=XrUOmCiSuOT8hJl4%2BSDQDcFReZKgwEzLJOIls5n18J0%3D&reserv
> ed=0
> > > overs.github.io%2Fgitlint%2Fconfiguration%2F%23regex-style-
> > >
> search&data=05%7C02%7Ciulia.tanasescu%40nxp.com%7C75f2033d3e9447
> d
> > > be67d08dbfb3b5e2e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > > %7C638380004620835820%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLj
> > >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> > >
> C%7C&sdata=GaHyvhsb4TOR1ksh3KcJ7f%2BLCN4JynFFoQdFs1cd2d8%3D&re
> s
> > > erved=0
> > > > 13: B3 Line contains hard tab characters (\t): "
> > > 0000a0201030202010304280001020206000000000a02010302020103042
> > > 8"
> > > > 14: B3 Line contains hard tab characters (\t): "
> > > 0002020206000000000a02010302020103042800"
> > > > [BlueZ,v4,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to
> > > > SelectProperties
> > > >
> > > > WARNING: I3 - ignore-body-lines: gitlint will be switching from using
> > > > Python regex 'match' (match beginning) to 'search' (match anywhere)
> > > > semantics. Please review your ignore-body-lines.regex option
> > > > accordingly. To remove this warning, set
> > > > general.regex-style-search=True. More details:
> > > >
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fjori%
> 2F&data=05%7C02%7Ciulia.tanasescu%40nxp.com%7Ca4106b62fbbc421ba8
> b408dbfbf5aeb3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> 380804836966878%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAi
> LCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&s
> data=5dVv5DQNrxG9SDq5M3hdYZA0w4zglb08FgIHpo0yfag%3D&reserved=0
> > > > sroovers.github.io%2Fgitlint%2Fconfiguration%2F%23regex-style-
> search&d
> > > >
> > >
> ata=05%7C02%7Ciulia.tanasescu%40nxp.com%7C75f2033d3e9447dbe67d08
> > > dbfb3b
> > > >
> > >
> 5e2e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6383800046
> > > 20835820%7
> > > >
> > >
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> T
> > > iI6Ik1
> > > >
> > >
> haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=GaHyvhsb4TOR1ksh3
> K
> > > cJ7f%2BLCN
> > > > 4JynFFoQdFs1cd2d8%3D&reserved=0
> > > > 1: T1 Title exceeds max length (81>80): "[BlueZ,v4,3/6]
> > > org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties"
> > > > [BlueZ,v4,6/6] client/player: Use ChannelAllocation given on
> > > > SelectProperties
> > > >
> > > > WARNING: I3 - ignore-body-lines: gitlint will be switching from using
> Python
> > > regex 'match' (match beginning) to 'search' (match anywhere) semantics.
> > > Please review your ignore-body-lines.regex option accordingly. To
> remove
> > > this warning, set general.regex-style-search=True. More details:
> > >
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fjorisr
> o%2F&data=05%7C02%7Ciulia.tanasescu%40nxp.com%7Ca4106b62fbbc421
> ba8b408dbfbf5aeb3%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> C638380804836966878%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%
> 7C&sdata=XrUOmCiSuOT8hJl4%2BSDQDcFReZKgwEzLJOIls5n18J0%3D&reserv
> ed=0
> > > overs.github.io%2Fgitlint%2Fconfiguration%2F%23regex-style-
> > >
> search&data=05%7C02%7Ciulia.tanasescu%40nxp.com%7C75f2033d3e9447
> d
> > > be67d08dbfb3b5e2e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> > > %7C638380004620835820%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4
> wLj
> > >
> AwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> > >
> C%7C&sdata=GaHyvhsb4TOR1ksh3KcJ7f%2BLCN4JynFFoQdFs1cd2d8%3D&re
> s
> > > erved=0
> > > > 13: B3 Line contains hard tab characters (\t): "
> > > 602020600000000100201030202010304280005030200000001020206000
> > > 0"
> > > > 14: B3 Line contains hard tab characters (\t): "
> > > 000010020103020201030428000503010000000202020600000000100201
> > > 0"
> > > > 15: B3 Line contains hard tab characters (\t): "
> > > 302020103042800050302000000"
> > > > ##############################
> > > > Test: ScanBuild - WARNING
> > > > Desc: Run Scan Build
> > > > Output:
> > > > src/shared/bap.c:4766:23: warning: Access to field 'type' results in a
> > > dereference of a null pointer (loaded from variable 'lpac')
> > > >                 if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
> > > >                                     ^~~~~~~~~~
> > > > 1 warning generated.
> > > > In file included from tools/mesh-gatt/crypto.c:32:
> > > > ./src/shared/util.h:228:9: warning: 1st function call argument is an
> > > uninitialized value
> > > >         return be32_to_cpu(get_unaligned((const uint32_t *) ptr));
> > > >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > ./src/shared/util.h:33:26: note: expanded from macro 'be32_to_cpu'
> > > > #define be32_to_cpu(val) bswap_32(val)
> > > >                          ^~~~~~~~~~~~~
> > > > /usr/include/byteswap.h:34:21: note: expanded from macro
> 'bswap_32'
> > > > #define bswap_32(x) __bswap_32 (x)
> > > >                     ^~~~~~~~~~~~~~
> > > > In file included from tools/mesh-gatt/crypto.c:32:
> > > > ./src/shared/util.h:238:9: warning: 1st function call argument is an
> > > uninitialized value
> > > >         return be64_to_cpu(get_unaligned((const uint64_t *) ptr));
> > > >                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > ./src/shared/util.h:34:26: note: expanded from macro 'be64_to_cpu'
> > > > #define be64_to_cpu(val) bswap_64(val)
> > > >                          ^~~~~~~~~~~~~
> > > > /usr/include/byteswap.h:37:21: note: expanded from macro
> 'bswap_64'
> > > > #define bswap_64(x) __bswap_64 (x)
> > > >                     ^~~~~~~~~~~~~~
> > > > 2 warnings generated.
> > > >
> > > >
> > > >
> > > > ---
> > > > Regards,
> > > > Linux Bluetooth
> > > >
> > >
> > >
> > > --
> > > Luiz Augusto von Dentz
> >
> >
> > Regards,
> > Iulia
> >
> 
> 
> --
> Luiz Augusto von Dentz


Regards,
Iulia

