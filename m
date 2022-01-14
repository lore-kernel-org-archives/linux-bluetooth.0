Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58410C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jan 2022 13:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241187AbiANNTQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jan 2022 08:19:16 -0500
Received: from deltahqout.deltaww.com ([122.147.136.111]:40748 "EHLO
        deltahqout.deltaww.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiANNTQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jan 2022 08:19:16 -0500
X-Greylist: delayed 1406 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jan 2022 08:19:15 EST
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 14EA2F824E
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 20:55:42 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loytec.com;
        s=Delta2019; t=1642164943;
        bh=oC9pf2bK3F3MCvsj8bco5PRbqlE4uzuk8Q5sP4uXFR4=; h=From:To:Date;
        b=mKQ1NRq3K8JADjx1JFpu2TnEQIZa3oXASKvNJIdECwO4/U9Z7ibnWpJX2raXrBN6B
         zApZsU+PgKtRWytl1/6j8vpHqFw6BvUx1fQlfcTJ+R8pjcd9Mpi7IYSGxAfIxCrGi9
         PK/NscNbJM9EzVsAB/xJMLyr7dP5HPzIeXc0WHF0=
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1902F824D
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 20:55:41 +0800 (CST)
Received: from TWPJ1DLPDP01 (unknown [10.145.156.5])
        by deltahqout.deltaww.com (Postfix) with ESMTP
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 20:55:41 +0800 (CST)
Received: from TWPJ1DLPDP01.delta.corp (TWPJ1DLPDP01.delta.corp [127.0.0.1])
        by TWPJ1DLPDP01.delta.corp (Service) with ESMTP id B5A6D81A3B4B
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 20:55:40 +0800 (CST)
Received: from TWPJ1EXHYBRID04.delta.corp (unknown [10.145.157.228])
        by TWPJ1DLPDP01.delta.corp (Service) with ESMTP id A96E681A3B48
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jan 2022 20:55:40 +0800 (CST)
Received: from TWTPEEXHYBRID03.delta.corp (10.136.157.227) by
 TWPJ1EXHYBRID04.delta.corp (10.145.157.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.2308.20;
 Fri, 14 Jan 2022 20:55:41 +0800
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com (104.47.22.105)
 by TWTPEEXHYBRID03.delta.corp (10.136.157.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.2308.20
 via Frontend Transport; Fri, 14 Jan 2022 20:55:41 +0800
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::7) by
 GVAP278MB0709.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:45::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.10; Fri, 14 Jan 2022 12:55:36 +0000
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4581:b3de:6f25:8351]) by GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4581:b3de:6f25:8351%7]) with mapi id 15.20.4888.012; Fri, 14 Jan 2022
 12:55:36 +0000
From:   Isak Westin <karl.westin@loytec.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Mesh daemon uses the same sequence number for different segments in
 friend mode
Thread-Topic: Mesh daemon uses the same sequence number for different segments
 in friend mode
Thread-Index: AdgJRfCQtALydM9BS06HisL25HmJnw==
Date:   Fri, 14 Jan 2022 12:55:35 +0000
Message-ID: <GV0P278MB0129987E8A49688F409638C995549@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=loytec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa5f25b0-84bc-4d21-fbc6-08d9d75d2890
x-ms-traffictypediagnostic: GVAP278MB0709:EE_
x-microsoft-antispam-prvs: <GVAP278MB070990085249583DB43E4BF695549@GVAP278MB0709.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rlrmJVx7vGrLX0EaWqGcHm/97dSH+NeawQ0xn1gqkpfZpaY1H511wu2YOgys3vDwzWWhmNk4JaAmO7Gqxb/1FS/uMtYNkwk27m5wx0BSSw07+TsX/gRPSYzYXVJ/U8FD/oNE2COEi3B/O8uE9qVZYR0ed5VB3WFSmRrozR2JIqF+su26yASVC/IN0wS+x8L1N6QAKnJlbZ16tUhbBtMw0UZYFsNdq/oY9n2RDjbMzHtRFjuO7iEwmxz6mkxMcN6tcQCwTsRFti0CKIXWLIO/5Mks6m5CccmNBbp7IkdhsYOnX5JV4YngTSHvC3QwUCUJIcQBBTvOeb9f+DmT+nJzA879h/ZR93gCEK5iwVcKB9Ok0ZaxLfsNNGX0d+cuzh8jgCQAUPJIxdtCbXJDmWhQYgD1gX8xyUlbkIG2rDfZru7Yl/4XdkzUH6oUXBVt/Pg1qNmHH8+zcxWYNO1jnxYsEHW1APjzVtc5TUfEUGmb1cPrSmMoejZt9cgEgnugcwNWL4w7zoseH9+hKWgOj0EEBAZtat7+UrxrcgF0xbsyHRPPTHcl312/Gx5w7+HAu9YDeHIBa9pCDlS6Q458syY4JzFwnq4jZhu4u5mkwzBuB0fl2snSYe2AQSkZwY32qS9bz2VbznT6YFO/gtRq72P0gZnkt3eiuS/hpkNNMdHs0wKOARIvp+FZDuKhp5xSkbnZl7Bp/yUS4bhp6VKjG8v5bZk9flkO+PmEezy3GlSJ0+3fzY4OdPDoI5ykgUfBgTjx4/Opsb9lb68h8appfq3bzIcaU2CqrGJ4exWPs7s4iS8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(6506007)(4744005)(186003)(6916009)(122000001)(2906002)(9686003)(7696005)(38100700002)(5660300002)(38070700005)(508600001)(55016003)(83380400001)(86362001)(33656002)(76116006)(66946007)(8936002)(52536014)(316002)(8676002)(66476007)(64756008)(66556008)(66446008)(966005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UT8hajE9CUH+7wekt8XGjhMuaedAGLeTxwV1KFYZMpIPhdV5H4KCq10zsv2x?=
 =?us-ascii?Q?IgbIJRkgtvtqWC0gnQMcdLC08fy1SHJ3OtKmkTKovduuG6Y11oPIyGES9cjc?=
 =?us-ascii?Q?DTBMMd7fVqq1lC90OteoKI4JVvg3I7rH/hxyauGqaOZpJq440cOjccG0/Hqq?=
 =?us-ascii?Q?SSTWNrgPSUsC0Z0jOeDw1lXwYgDV/PdIWegEGa4Si1m6iwOLgzV2dhjKgZwL?=
 =?us-ascii?Q?0kC8CPuGbNt4vLB3kt+SYSkmoy1BRzm3xfehzLJ7AvKGhLwFmKqFHFXTquAj?=
 =?us-ascii?Q?aePN0g4f8W9CIYA2pLxy7Xn2QDVDzklfcJ0Y4XpZoaCXKjqa9zbSni/1gwzC?=
 =?us-ascii?Q?6jgapxG/IamLPI9cjHXWQi8f3UxkwuUZy1+LSlGxSneEv25DTRRK0AVs9inn?=
 =?us-ascii?Q?9zF0vqqwWrBIM9AkzzDS5nZX+mUzUuJ5cuWfxGpSp/D98I6BE1csydyV/qQo?=
 =?us-ascii?Q?mwEjZImUH4eVVysPzE7+FHLSMi1Vf0NZf1AsB9FycnQY/lbiXLzrdOpvPjyK?=
 =?us-ascii?Q?RvLw/S1qBlBlado6ZX493CmAHG5nqOthFBmlYaq729pgPmV6/5AByisyWoKC?=
 =?us-ascii?Q?LTcLw9BF/RShxlDVokuAkQNglmVKALZ3/3AvEUgcm38pDTWOY+oT/R1b/cNZ?=
 =?us-ascii?Q?0bXKc8hVNGXmYI9eFK5UAmnAIK2znmmHiMwdmSKRlgEAQlFjNhr4JC6BoBhu?=
 =?us-ascii?Q?n/zATJpimb75adEp8K8tZGTEhmCloTUFySWjPDbb5Cx40LoDANDOWTSK2B1o?=
 =?us-ascii?Q?VKVFB66N9T3FJGhEvbj+UAYBcOTTqSupndwk9HhFOgwUqLssgd/rp3zDK3gp?=
 =?us-ascii?Q?JJh86MQdnmLumDAkVUBc/+Cp/5r5G5BmvLM8Ez5IjcZ0BXli8zbHAglhnUuu?=
 =?us-ascii?Q?NStySlo1Sbu3SBgUAui45vXcAEW0ZrvUfShglvrYaDCcWYYqOLonJPla84yT?=
 =?us-ascii?Q?F/ZAkvhWuuCmda7wjGV/xPqkeLf3gpHgcPHnzZA38O3fQToZMq0x273JmDiZ?=
 =?us-ascii?Q?+KkF1tam3xR3MD5EK0pLR7u0y5aGhwLtm8jFOeK4RNcDKJCOseRQFTKfxB83?=
 =?us-ascii?Q?WTRK8j+i35wrraKWUiGXRBh6y6wJmQM3VTpvuA6jVvGiGG3SQsYbUJ2LZe3X?=
 =?us-ascii?Q?hUPXKZQWsnRgnJDLg8SxuH3U3h5vTdt8Yp5cevzj2qRtQMiQ6Otg53AUYxJD?=
 =?us-ascii?Q?yuCOf+rKkZDyWLUdYp+496TpicZ9hiKr/6FE/pKjWEHsfPnzMPLwFyR1Kb/A?=
 =?us-ascii?Q?iEIKYcqkVH5mXy+KhcoIMseb7BxxXbvWnX0ZSc4afw3eau254cwrudG1G/we?=
 =?us-ascii?Q?eSNfH91ut0pQymzG2Rzvs6AQDmBJvapyTrAq5PUVkfeWasmRyYWSPHF+HwQF?=
 =?us-ascii?Q?hZiCJGSKZKXfsxJ1ILN/ADJNtjIQMpCW9EL7KO94SuTInfDAiI760Io2v4Qh?=
 =?us-ascii?Q?akxiL3sV1Sn3SY9C6CC7CLfiOitBNkF5p2F/M7w2FTYKBzRFpnOx8i0YzRm4?=
 =?us-ascii?Q?AJNL11/jVQIc2t7JnhOXQk4qPHHQSwnzQmgwpYrjVt85tPRby4RLQa15QiHK?=
 =?us-ascii?Q?zjAIZRgMAVWpFhtl1YGXQYH677TKVLBnJcuE0AMdX9BUClOcKggE2qhfb6sn?=
 =?us-ascii?Q?mGCUwuoyALWrxhJ8fZv412jBF+/i9YHjg2sJ+bxN9BtAz4kIKlNbzXMtGYcM?=
 =?us-ascii?Q?qgZeyQ=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3eBPBWw+5qbSO1yzo85/It80PayNV1p/0oWYGALJFQXHxo/YwVcjphHr/69RTTpg2qP1MUgygl/nwLHLXWKMa5/zV1+nd0UjjLBqPJPptS9At4bLbDep8shqmXX20G1gJwPXpmzpGcZf/OSMpyH3mEqqspkUm2PeE1mICXseT2Z7rWP3oS7zlYb3z6ItkwHEpCJMUrIS4tsDgvbtQCxjd0UPnTDhNqfckAorbvirIH1Ide+KqGmpnCGrpSq4AyeBSfBzrJtk/aE78URvDt7UPe/n5w5okImSICvmNlhEH2deW6QihzIsh+Fn81QV77k6Ybc7/FXajwGBs9gnSVxMQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gloZ3vEhSXFBzcmGyTKL5TSK83XIupHq2/uACzR/XxE=;
 b=oE10XYhSqiPsPOqaQAssbPL2grvOFGXIICclbApsP43WV8i8rEoKzhQJZDP4TIUf6eoftlUc06GIJXbNtnc8dYY4iolhgutdKwLbxizN5ttYvtvsZYTuyP1KvkMQZ47Wc44uuv87co8MNXqfib7PSw+lxjQe4aZYTcg9VuKuP4vjtxVt/iXJeEb9LyKlRwA/Z+U03qpdp0hphMMMkXeonbg57wNWe9eRg0oEsH1XIgD7XeG2yiTsU1bArtqC22Lr8UPN0ANOa7k0Lvr4xvQkHI6LqpPhJRQVnIzDip5vpOURI9/Og2oFbN1OQV0Yg8Xiu6U2HoTAmbSpFKWI9XO3sA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=loytec.com; dmarc=pass action=none header.from=loytec.com;
 dkim=pass header.d=loytec.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
x-ms-exchange-crosstenant-network-message-id: aa5f25b0-84bc-4d21-fbc6-08d9d75d2890
x-ms-exchange-crosstenant-originalarrivaltime: 14 Jan 2022 12:55:35.9030 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 19f25823-17ff-421f-ad4e-8fed035aedda
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: CQkMSG3hDCgwu4H0HtIqJMPe/FMM+cdjhzl9HVDsKdb1Voal6kVmkEecQPLZZPE95QJZy71aSrS6xathMgrUaQ==
x-ms-exchange-transport-crosstenantheadersstamped: GVAP278MB0709
x-originatororg: loytec.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.2090-8.6.0.1018-26652.007
X-TM-AS-Result: No--1.687-7.0-31-10
X-imss-scan-details: No--1.687-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.2090-8.6.1018-26652.007
X-TMASE-Result: 10--1.686600-10.000000
X-TMASE-MatchedRID: ARIvT180zhnE1y2P+M63h/bta0OAYFzyJDAZBInjo2YINpIFnbd6ml2d
        sxCRbuoBCIaa5JvsIzDVGk64c676Zhs7n0Ur0F2YGXGu0jdPFGT4qCLIu0mtIEj6h8vQeZP+bYd
        a9H3QEXXPQTwRqYgApAkGwqYyhbZgLph8juGPwgMBGmsibWGTbQMBHSGDSx7/p57Q1Fr8999YZK
        KbczehieLzNWBegCW2VKrJEzVga6HQLWxBF9DMQcRB0bsfrpPIx1FPlNAAmcC+pRddnFPoKEmNd
        rOkO2GC5C2fdYzYNvK9eyMneZ+C7p6oP1a0mRIj
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi linux-bluetooth developers,

I posted an issue a while ago in the Github-forum about that the bluetooth-=
mesh daemon uses the same sequence number for different segments when sendi=
ng a segmented message to a low power node.
Link: https://github.com/bluez/bluez/issues/250

I know there has been holidays and that no too much activity can be expecte=
d.
So I would just like to kindly remind you that I still can see this issue a=
nd that I would appreciate any help, especially to figure out whether or no=
t this is a bug.

Thank you for your time,
Isak

