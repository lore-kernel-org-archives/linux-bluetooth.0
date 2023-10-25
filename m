Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084A9C07545
	for <linux-bluetooth@archiver.kernel.org>; Wed, 25 Oct 2023 14:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344265AbjJYOzf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 25 Oct 2023 10:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbjJYOze (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 25 Oct 2023 10:55:34 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CDFB0
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Oct 2023 07:55:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8V+NAGEpvrHa5Qrs//nbyAi+WqLRRdp3MwFxq3dpbiFrthSGkgkQ8zOlvoSW9v8tXaGJovLVlvhEU9WfMeKTB3lkqVteEZzPdVFb/lq05WHH7GSykkwzAa2lLDNXQ8LS5c3hxUyR7/9JxeLG7MSWtwcniJ3veLyU4d9y7p9354/Ze/w5V/z835qJhDyByTFnIpgUCxFU+4uK8O4lBiEdhIZKK1rM/5zOjmzK/zSEK1XhXAUHZf+3IhpmapGe5fl1i+BNZD8AtyqdlxQbzPeI3w8ZjDUr8OV+Z1jZWOz/yAYu1PyzMY5xcV9OAUrTTaPc5rvmTnSjYDvO9/MASMzPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDtjhWUNPIEbgo3w+H2lsIQojUT4glWYx5p2pTDzNXo=;
 b=aqhetn+A3I5rX6MbyoG7hIG/ckERxagg+1Dyqhiv+tAyuBiWg91oj6gIJrKTCi7lqLfbqdCzPuSUxOJ0s/J+oojvc27galls3KeVvBWi4vMmMLj31p64St6YQbys+EMdnYDZ1nRG+frcs/SJ1xiCzsmEGGUl+dZN63Qz7nvoCH4RxUaEfAg2reXvBeJ8FBmMosL5qKJmoRrhno0XxzFCisflhzX3GezMepbo0ASybzuUN/FFsdWx4NZaNRotRxC2MM9NpyTAdgLr2C7Hs/7EAqn20yScUZ/nwnpplT9fAoBQbLVJPHSi5Y6etj1tb6IAzcJugiIlnGUoc8vrL7Yr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDtjhWUNPIEbgo3w+H2lsIQojUT4glWYx5p2pTDzNXo=;
 b=FxnnNpvrII6qjBh1sBnoYmuiuTGUG3dHsgNRHjWZvMGKmNrbqUyR6K4QmQ7eaPY7HU9+1OgZNcIwY3B4T+P/oJGrRt1l9CTQdtNPSV8yQ8yG7WqFO6uOGR8GYbkPMBfOZvTFdWK+hixg2imGcMJ/X77QQES9r4lttPjA/PYkSIw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7614.eurprd04.prod.outlook.com (2603:10a6:102:ea::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.18; Wed, 25 Oct
 2023 14:55:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::b21b:d65f:6b00:34a0%6]) with mapi id 15.20.6933.011; Wed, 25 Oct 2023
 14:55:28 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 1/4] btio: Handle closed channel in server_cb
Date:   Wed, 25 Oct 2023 17:55:26 +0300
Message-Id: <20231025145526.3027-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZJ21w6h_hvBWsEwwDTevYqiZqY7oOOf8oEXDRmDPxmHYA@mail.gmail.com>
References: <CABBYNZJ21w6h_hvBWsEwwDTevYqiZqY7oOOf8oEXDRmDPxmHYA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0152.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::36) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe540ba-5492-43da-c019-08dbd56a6d70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0olHpoWziUhHHKqv3zaaW+HgsHaNnGo7T5HH4s1FnWi6sUU4i0wpLKpDLqAt09iQp+bz5aEKfgvhb3nT95lxRunn1B9Y5Hq8MYytt9m4qBU8+kTSfSbJUlbLHnFhSftip3gtZn8IQY3KEh96X3vjLMyxyrXEzMW7BDHejesmjC2A7qADS1BTCjWggXQSw3/H0yFn5a5G+w03wJDGRglQFl3QjP+PWPQyH5RUJ6eMeYeXp/Cn+BJb2ubpYhXLX0X6kDh0/TxLV7WIrVV75LHH1ZJ5Tnx4Qq0AbNgtIIkkSUyQHRnmAFsnPCW2UNdQ0IsvdT9nWUPJ9nWVy3rRIHta6nIHFHthxK0CyIFNsuxARusIg+RpVO4yol476eAAawRAtFgwN9ZPCfXHebPz97/AvuLup5lf7Vg8HfmJtfwFuhls4s4dvLdm9Nr99N0Z2qt2HdnVaYg5Fkyptg7JN7CQZDqxbtnDO726t2WhRk3plqiClx0O/t0stVKIfdkFRR2zKpcT58Ptr+n4JIqMNtwz1QOv+Y8r2pB2VzgJTjuiryTAuz0zs5vXTF2UsmHTKNyx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(53546011)(6506007)(1076003)(2616005)(26005)(6512007)(8936002)(5660300002)(4326008)(2906002)(8676002)(44832011)(478600001)(6486002)(66556008)(86362001)(316002)(66946007)(6916009)(41300700001)(66476007)(38100700002)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?elRxrohS2qdoIQlRK3gdV6SViy3qhIELO/HdJSvivvd3FP9XSjcDE1v9LVzz?=
 =?us-ascii?Q?1T6xz6cHKI9v+jE4339pNTjUEEZDnyUIYvWTizfqCeFNv6EYdcIYrMapNo4v?=
 =?us-ascii?Q?2Jqo+N35MnSJz3MyH7tQqhfin133uPHKReF2vJJRizEJHJqqfz7SuSBBlptm?=
 =?us-ascii?Q?4e/fLYa26/nTNHmR3s5wLCBt2vPrstORCWitSk5PvSx8peEyrSp1AWkeik6l?=
 =?us-ascii?Q?k46RhLnZs3lGZ0APtOPHvH9IgD6v3kdmjM1xv7rgKCIIlN/oZxJEEQxP1Lz2?=
 =?us-ascii?Q?Q/X5QOYs7SRhJP7l38oBRN9kk/EeZ055xpOxCyzjsq5YVRFknD5PVLV13Ilq?=
 =?us-ascii?Q?QqugZutOCjJQOFFbtSeQ8nIsC1dBhnRDIoaDjw3B7i7bR7jTGoBOsUc4Y1CK?=
 =?us-ascii?Q?G3HDKUKZ6piziz0Q77IpO/KGtI1ksssYiLS45ksENxJTCdzff5H3psqr+dcY?=
 =?us-ascii?Q?Z0ECO+OYRIOuWrnsC7g3z30xLxz2wYuzIMNNt5GkllOr7vnMLmKkdJDVybxF?=
 =?us-ascii?Q?w+ASbHg7N8l0LW2HzjtVchDeO2MJ8FXSYF6Z6EIl8aD1nAv1EdxahhGuQXj4?=
 =?us-ascii?Q?LCsxx1S++cvyRmQC3sje+MpmQOuCmZUYrmxcVfgUA0f7giD/oMR0iBmmT1FG?=
 =?us-ascii?Q?HHwIUx/SM0gU+lO5T2OCGL9LzY2ldIvCZ0KteQ4DDLVkYqHirG+1Qd0Lzqs4?=
 =?us-ascii?Q?OVtyEgqWTdO7PjSoG1d2YdkAJgnU20Dj9fySf0shOTzUSwwn/xeIjfumU9cc?=
 =?us-ascii?Q?T9Fpy2SxXnyT2A/oW7kCRUhEQrU5jQORn9RG6NjX90vhLi5JgAFx/NX6ys9G?=
 =?us-ascii?Q?iZ3T/3dwl1gKI4ZruHzyAmQRQJW4Ou7Z/zrSAFATcCh8xHKSuwTcW3dnw6UT?=
 =?us-ascii?Q?kZlomldcWhdXCwfCNslInHK4SJtZL5gyrWEo2sWfANO/hu8qMWj/bMtuQbcW?=
 =?us-ascii?Q?azSt53pTLqN/1/RmRlimOKvGOp1KJdfQqHH9xdwIRFawSpjI9c/7q+ox3bdL?=
 =?us-ascii?Q?Dshl3M550lmyBaXrm7lxDd/UehY0XNPBYS4SNiR1CGdxBgnvs5Lv4du0A1ng?=
 =?us-ascii?Q?Gw9u4CuxrhYmfEQLubwwcJjsYthVnQ1rjtzy15MCsQFO9xwul3B+RRjL0XAC?=
 =?us-ascii?Q?/NdLWT8BmmPueJ0G0+a0UPNv08oMhQzyek7oBGzwL9/6dffNcKfhsCe0I3JP?=
 =?us-ascii?Q?D0P93frG93hSDYRCOuCboQGys2AUScm6mFCl6/NrjTdjbsSNGxdCvDT82Cpk?=
 =?us-ascii?Q?rh78LnnYQqG39dj1pjpUPg64/m0waXGskbFgcFpmLhNB9dZwmRW5VXKXciVm?=
 =?us-ascii?Q?B+e7jy7o/TbEYX+9zw5P3xFZv8DMTLTYK4XQQ/0HP/QEbr5GsYg9tOQrlxav?=
 =?us-ascii?Q?B9ZlQN97L1AaZmz+P+QeN0kpdKGFii0qyIUEykgtBvNkuRLIJQYWp3fi1rA9?=
 =?us-ascii?Q?5824+m7AE2SFIqMgTtLC5IK1/QRHicrkdOx9rqjnA0g+r+H9H+hcwGiernk/?=
 =?us-ascii?Q?ZGwSgXyUTLALxRF5Csd74vDtVCqqvxKgrJm1LjYXuFb607HKpRI/FAyENQLl?=
 =?us-ascii?Q?Lr4lrfmt1SSjNFYXj+nYEFi/3kohQDgKa+4lp8kHyNp8MBpDEY9nWy5t+7T9?=
 =?us-ascii?Q?7Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe540ba-5492-43da-c019-08dbd56a6d70
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 14:55:28.3570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RnZ3H0n6ssgMUwlBlQftli141LHivdsME3NZXGbRX8Rv3kCOWBmVZVqv/TgydJ3qD/fDO8R4fvdP0t2Yplf7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7614
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Monday, October 16, 2023 8:01 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH BlueZ 1/4] btio: Handle closed channel in server_cb
> 
> Hi Iulia,
> 
> On Mon, Oct 16, 2023 at 8:49 AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > This handles G_IO_ERR and G_IO_HUP conditions in server_cb
> >
> > ---
> >  btio/btio.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/btio/btio.c b/btio/btio.c index d45b8240d..c63a6d1df
> > 100644
> > --- a/btio/btio.c
> > +++ b/btio/btio.c
> > @@ -247,7 +247,8 @@ static gboolean server_cb(GIOChannel *io,
> GIOCondition cond,
> >         GIOChannel *cli_io;
> >
> >         /* If the user closed the server */
> > -       if ((cond & G_IO_NVAL) || check_nval(io))
> > +       if ((cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) ||
> > +                       check_nval(io))
> 
> I believe this was done on purpose to only check for NVAL, the other
> conditions shall probably be notified back via callback so it can process the
> error reported.
> 

It seems that server_cb is supposed to accept an incoming connection on
server io and pass the child io through the confirm or connect callbacks.
But if the condition is G_IO_HUP for example, we shouldn't get to the point
of calling accept.

> >                 return FALSE;
> >
> >         srv_sock = g_io_channel_unix_get_fd(io);
> > --
> > 2.39.2
> >
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Iulia

