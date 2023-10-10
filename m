Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D13CD8CA5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 15:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjJJPpd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 11:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbjJJPpc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 11:45:32 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F4793
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 08:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KwFI5ewuUMEKvk2IlWbQx2VdWrDDFb3yyZ1qWtYlgxr82ssCJJ0YNZKlqV9tJfRD5KGhqoNpSrBk4C8ySqk4QomP8BRtXJWeXCgN3/Wts/H9v8bnho7wqHk/T9qEHbWYKmhSOMLcgfFSo+h79yzIGEqT961p8649S4UJ7XxfqYk+ESeI3Osriey2BhdE5h0Mjmcoq0p5MKBIypkkr1Zr9KKoS6lYv/LqUt7a6NsofwSChIoTcQNhxrYtZpWMevXNQvCbZnhmYHGhw+R56NYV8nVtOZKBEnMFM5Nyw80CsVNWUWxGoV6iQPWH+ECO6hPHKruc2VUeTcuALmXVjReDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIJgrJ+i6KAM7y9EOMN+ZD2YvN5ZZwi9Lvl1D6Saros=;
 b=UpkyXGEdSmUJLDtBB4LYk/MB9O0TBT80RV1ZqGPeDFKCOaxXSfwdOebLwfj1dgxWbk8W1Uf/ybhrh4UjpCZMqVpGkFDLfBGUhRpjqAAgrHTyTLIA4jlw4oUj80WDovHXzEUHjXimhJ+9TMU4uSb/j+a5umxOVj4rXWVVJv/gqAxiLt3ISaX4xX6UbYpW6VsXid3uDoep9l6dIXziQxoEDB3swwlaMEmcFdt/cgKZw+LS5ID7PjNAeYdime+rf/u8l0d9/v6HeWUkfPfPNFYaX5ummE8rm7EVYh7nSpErxTNYoulHCCv4b0uTXv482irBd6FntIi3hdqi52WDJ0enbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIJgrJ+i6KAM7y9EOMN+ZD2YvN5ZZwi9Lvl1D6Saros=;
 b=CGCvQMOD1Jsf5rUi2sQkrwVMUFRvfBowurLC5zlUQsUVtyuU5ZyM5kw3Q/qRN8FjawmUGENnom94EvRIgBoFVHUkJN70dG1uOTqO1UCrTm5oq8j9t0O1oz90tQlxxmTRnCM+GmWjWhcC9esI/0YUoa+vazj3gJ3jjIhwoaAwKaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB8569.eurprd04.prod.outlook.com (2603:10a6:20b:434::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 15:45:24 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 15:45:24 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 4/4] test-bass: Add unit tests for the SPE suite
Date:   Tue, 10 Oct 2023 18:45:21 +0300
Message-Id: <20231010154521.14031-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZ+XJZhtUp25CqKRbDav5jOQ5xNAsmFwCKBOb82iYbSWqg@mail.gmail.com>
References: <CABBYNZ+XJZhtUp25CqKRbDav5jOQ5xNAsmFwCKBOb82iYbSWqg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0258.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::31) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB8569:EE_
X-MS-Office365-Filtering-Correlation-Id: bed0c533-9034-437f-417c-08dbc9a7eade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zy3psLLDzV8+joxp7+H6wR/PjM5FXYnzDvR4Pu1vgEe1IHOG+5mbC91dGthbGz+MJedTIBxpfM0vMMd1/MI5rVK1QY57ea4K6t6r3ZNJLXs60EqIq8tkhD7CNZCkSvW3ciiEe4UQN4TBvTVtsk6Gc8fh21BcOWm+rSHM87Hf3A9sUmdEq+cHRiKQNQQEpefofU3ZcDJp4xyPd5Or9r7hsPFCKETpiMKQdqbHN/ErmUPLW3XJ4gMUSbUMbQoQL1X9ejzi/Q7sUibbxKDMiZo2U9JdJIgB9VZx4E1koYXMF+w3bbBVN+YjrWkagfjSoryF3T94hucWh8XUYgpeGW47fIxoaZuyVFh0gEifD1xA5ko8EypKm3WJJ5/fPUDPahL9iYSWC2irlQfNJtP3AUjEwrk/9KqX4UDs6GJWQIRPwGQz2f7Qjz4HNGtLmfkK4M+XQTVYkiA2njTsVAN9nfopK8VxioBifZ4un6MybkHPDZcnK87uRLTR119MOrUBKpdgoYMhZCKwPUOIHzZu/cIfQzTPm2Dk8xItNNe623/hl0wFl+tyOLveZLY2AlD9ZNGx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(6512007)(53546011)(1076003)(6506007)(2616005)(478600001)(6486002)(6666004)(83380400001)(26005)(44832011)(30864003)(2906002)(5660300002)(66556008)(66476007)(66946007)(6916009)(8676002)(8936002)(4326008)(316002)(41300700001)(36756003)(86362001)(38100700002)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jyc+ebl4+MDI9nLSGVJY65JKFbHHYeCscJfD1fV2/ZBf87S4pHXN/HRnLS3p?=
 =?us-ascii?Q?6iESVmQ43e9uD70a7u7xAkflAdZm2Qu3NQ9cH5FlwKk+KXYV3Jbqr08wr69c?=
 =?us-ascii?Q?VwetWYTkCvXnz873/Pk+Qm2cLC2PC7VHarz47CUZMvamf8V1NyGdBRgeWbV2?=
 =?us-ascii?Q?N7S17/7fVLL1guffnSknpRiask0r+AmEd1aMgZJPE0DvJzMqWURYiorL4fRR?=
 =?us-ascii?Q?TDUqnPFsUzMj0OQId+9DAqv4ACBZt8vxLZ8ekYccbiOMJ6h7CD8jdB7+1yTk?=
 =?us-ascii?Q?GM1V1qzPnfqCsicwrYmGAQZ+z8t3DC3fbG+xvh1Anf1i1MSzItez4ObFwFt1?=
 =?us-ascii?Q?Z7jLlGfHjgxGgJvoxzsu6MJGNp1vSh29BuczOr4gn3KWIw8SPZBupA1/nzVT?=
 =?us-ascii?Q?CxEw3w2o68u53kvgr023W+hWN2S65GCN4KTdUSxY3W3ZJWP7VnYpIf6pwzf/?=
 =?us-ascii?Q?nWG8DV3upxrr/2wF9PFBjiGc1V2Db9G+E0/pT2wJPdkVYJbCvYevGKZYyrug?=
 =?us-ascii?Q?Kq88HYTgKTJ2+tR+JaHL9oKghMYLVK02qWwhjcodvPHjJXandXYIIbSt+O6L?=
 =?us-ascii?Q?WCOWQqxVSZVXFkSUgnbfogg1+q30Zen3j5W6nZfG2+DkC/y0w8bzbqKTpMOb?=
 =?us-ascii?Q?Z+KQK2Gk0GakgAOv0yL4nTYPFbYn2IHnioWantYghRaYSemAwfJrKhjPv+eE?=
 =?us-ascii?Q?d0NVV6T0YtVLeg+Ar3X4FEiVmyi5eq5/4S25CZfcNwmP4PdHbwBjQdUePCia?=
 =?us-ascii?Q?0ug/RFfeBi9muvzhjz39gaTpbbQdeCkHzYp9DCObpk6wm4guRPytSqFhnpDG?=
 =?us-ascii?Q?zas51yCqfaG7uSGfHHO0CPbV0Uo1ErJzMSJoPecI/FerzAiEXk6PYvAG5rhP?=
 =?us-ascii?Q?TjSoKcy3TBd1UCs6U4dY/42hVsRJ5aWBMN9UW8OWmxKO2DpgGQhyXdpy/VMg?=
 =?us-ascii?Q?5fkX+i9XaRuP6EHMjZ6bQBxe+l549Px4ta0Dw32svYxRxwwJP6JL6Ht66heX?=
 =?us-ascii?Q?yRIs4fK08HgkkqnLEAOCBhwUW2h0Vt8ZWk80pQp0qKlfoa0piiYZMpvrb1sa?=
 =?us-ascii?Q?Et+BoC8IoNrZcIbVEnxRovGZjx9Q72OybaHrqunPIiUuGjEysMVhL/56HbV7?=
 =?us-ascii?Q?7dKeMRipaEImBBCqSanEt5Jr7+lYtBwRGMSqNg2kZiGGdaEE7N1VvrwlIVT5?=
 =?us-ascii?Q?CF7uhlKCuu/CbUaqb+kbhAOROr2rlWLL7YjaLKJZw6ljgZ+JpV1V12pqFM6K?=
 =?us-ascii?Q?Hd7Dvt1Hly4BXZqAxYeNp89cJa/+0ibFfYZ2P/KZr1ECeL12pm9hbKhpIC3D?=
 =?us-ascii?Q?vQnRSfcPmyYWvg/q1HIIKoQ+CQxh+Oe11vdYb9qLWf/MXCvL1afLxpA/zA6D?=
 =?us-ascii?Q?OhjKWpd6pzqQSf7M91UW5kKFBreLMakVIY+pXS1e4mdWU5m/vzLi1Wd8lP+Y?=
 =?us-ascii?Q?2b2GSTFws5Q1++fiv7AqF8XSmYn65vSPX1ZtWSIcJT/Mdat1Iq1Ah5a+TbRH?=
 =?us-ascii?Q?ftqsv5772S44ko/NxRaCMPNeU4whjaoMff6DQA86/L+i7ynNHoWDF+cflEXz?=
 =?us-ascii?Q?2cRtqk38+/qYGxPk/IWU8clNi3vMBXghWufcKqCn8U95hF/brIkX0YhomVUg?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bed0c533-9034-437f-417c-08dbc9a7eade
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 15:45:24.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAIjjUralNhZfEnbuVBVtwPHLRq40LQxJMOdF3GwuUICSXbot7xkKd3RW88oaatK7ZPOYW8UytIz375+O/xYew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8569
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Thursday, October 5, 2023 11:52 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH BlueZ 4/4] test-bass: Add unit tests for the SPE
> suite
> 
> Hi Iulia,
> 
> On Wed, Oct 4, 2023 at 8:32 AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > This adds BASS unit tests for the Service Procedures Error Handling
> > suite.
> >
> > Some unit tests require the BASS Server to synchronize to a broadcast
> > source, as instructed by a BASS Client. For this, a testing framework
> > was added similar to the one used by iso-tester, to emulate hardware.
> >
> > ---
> >  Makefile.am      |   7 +-
> >  unit/test-bass.c | 781
> > ++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 775 insertions(+), 13 deletions(-)
> >
> > diff --git a/Makefile.am b/Makefile.am index 30db74a0c..088f5aaef
> > 100644
> > --- a/Makefile.am
> > +++ b/Makefile.am
> > @@ -581,7 +581,12 @@ unit_test_bap_LDADD = src/libshared-glib.la \
> >
> >  unit_tests += unit/test-bass
> >
> > -unit_test_bass_SOURCES = unit/test-bass.c $(btio_sources)
> > +unit_test_bass_SOURCES = unit/test-bass.c $(btio_sources) monitor/bt.h
> \
> > +                               emulator/hciemu.h emulator/hciemu.c \
> > +                               emulator/vhci.h emulator/vhci.c \
> > +                               emulator/btdev.h emulator/btdev.c \
> > +                               emulator/bthost.h emulator/bthost.c \
> > +                               emulator/smp.c
> >  unit_test_bass_LDADD = src/libshared-glib.la \
> >                                 lib/libbluetooth-internal.la
> > $(GLIB_LIBS)
> >
> > diff --git a/unit/test-bass.c b/unit/test-bass.c index
> > 2ab61f760..4407bb4d3 100644
> > --- a/unit/test-bass.c
> > +++ b/unit/test-bass.c
> > @@ -18,13 +18,22 @@
> >  #include <sys/socket.h>
> >  #include <fcntl.h>
> >
> > +#include <stdbool.h>
> > +
> >  #include <glib.h>
> >
> >  #include "lib/bluetooth.h"
> >  #include "lib/uuid.h"
> > +#include "lib/mgmt.h"
> > +
> > +#include "monitor/bt.h"
> > +#include "emulator/bthost.h"
> > +#include "emulator/hciemu.h"
> > +
> >  #include "src/shared/util.h"
> >  #include "src/shared/io.h"
> >  #include "src/shared/tester.h"
> > +#include "src/shared/mgmt.h"
> >  #include "src/shared/queue.h"
> >  #include "src/shared/att.h"
> >  #include "src/shared/gatt-db.h"
> > @@ -39,6 +48,9 @@ struct test_data {
> >         struct queue *ccc_states;
> >         size_t iovcnt;
> >         struct iovec *iov;
> > +       struct mgmt *mgmt;
> > +       uint16_t mgmt_index;
> > +       struct hciemu *hciemu;
> >  };
> >
> >  struct ccc_state {
> > @@ -190,16 +202,397 @@ struct ccc_state {
> >         DISC_BCAST_AUDIO_SCAN_CP, \
> >         BASS_READ_CHAR_DESC
> >
> > +/* ATT: Write Request (0x12) len 4
> > + *   Handle: 0x0004 Type: Client Characteristic Configuration (0x2902)
> > + *     Data: 0100
> > + *       Notification (0x01)
> > + * ATT: Write Response (0x13) len 0
> > + * ATT: Write Request (0x12) len 4
> > + *   Handle: 0x0007 Type: Client Characteristic Configuration (0x2902)
> > + *     Data: 0100
> > + *       Notification (0x01)
> > + * ATT: Write Response (0x13) len 0
> > + */
> > +#define BASS_WRITE_CHAR_DESC \
> > +       IOV_DATA(0x12, 0x04, 0x00, 0x01, 0x00), \
> > +       IOV_DATA(0x13), \
> > +       IOV_DATA(0x12, 0x07, 0x00, 0x01, 0x00), \
> > +       IOV_DATA(0x13)
> > +
> > +/* ATT: Read Request (0x0a) len 2
> > + *   Handle: 0x0003 Type: Broadcast Receive State (0x2bc8)
> > + * ATT: Read Response (0x0b) len 0
> > + *   Handle: 0x0003 Broadcast Receive State (0x2bc8)
> > + * ATT: Read Request (0x0a) len 2
> > + *   Handle: 0x0006 Type: Broadcast Receive State (0x2bc8)
> > + * ATT: Read Response (0x0b) len 0
> > + *   Handle: 0x0006 Broadcast Receive State (0x2bc8)
> > + */
> > +#define BASS_READ_BCAST_RECV_STATE_CHARS \
> > +       IOV_DATA(0x0a, 0x03, 0x00), \
> > +       IOV_DATA(0x0b), \
> > +       IOV_DATA(0x0a, 0x06, 0x00), \
> > +       IOV_DATA(0x0b)
> > +
> > +#define BASS_CP_WRITE_CMD(_op, _args...) \
> > +       IOV_DATA(0x52, 0x09, 0x00, _op, _args)
> > +
> > +#define BASS_CP_WRITE_REQ(_op, _args...) \
> > +       IOV_DATA(0x12, 0x09, 0x00, _op, _args)
> > +
> > +/* ATT: Write Command (0x52) len 19
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 0401693C4572685526613465597073275455
> > + *       Opcode: Set Broadcast_Code
> > + *       Source_ID: 1
> > + *       Broadcast_Code: 0x55542773705965346126556872453c69
> > + * ATT: Write Command (0x52) len 2
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 0501
> > + *       Opcode: Remove Source
> > + *       Source_ID: 1
> > + */
> > +#define IGNORE_INVALID_SRC_ID \
> > +       EXCHANGE_MTU, \
> > +       BASS_FIND_BY_TYPE_VALUE, \
> > +       DISC_BASS_CHAR, \
> > +       BASS_FIND_INFO, \
> > +       BASS_WRITE_CHAR_DESC, \
> > +       BASS_READ_BCAST_RECV_STATE_CHARS, \
> > +       BASS_CP_WRITE_CMD(0x04, 0x01, 0x69, 0x3C, 0x45, 0x72, 0x68, \
> > +                       0x55, 0x26, 0x61, 0x34, 0x65, 0x59, 0x70, \
> > +                       0x73, 0x27, 0x54, 0x55), \
> > +       IOV_NULL, \
> > +       BASS_CP_WRITE_CMD(0x05, 0x01)
> > +
> > +/* ATT: Write Command (0x52) len 26
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 0200F2698BE807C0003412000610270200000000000000000000
> > + *       Opcode: Add Source
> > + *       Advertiser_Address_Type: Public Device or Public Identity Address
> > + *       Advertiser_Address: c0:07:e8:8b:69:f2
> > + *       Advertising_SID: 0x00
> > + *       Broadcast_ID: 0x001234
> > + *       PA_Sync: 0x06 (Reserved for Future Use)
> > + *       PA_Interval: 0x2710
> > + *       Num_Subgroups: 2
> > + *         Subgroup #0:
> > + *           BIS_Sync: 00000000000000000000000000000000
> > + *           Metadata_Length: 0
> > + *         Subgroup #1:
> > + *           BIS_Sync: 00000000000000000000000000000000
> > + *           Metadata_Length: 0
> > + * ATT: Write Command (0x52) len 26
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 0205F2698BE807C0003412000210270200000000000000000000
> > + *       Opcode: Add Source
> > + *       Advertiser_Address_Type: 0x05 (Reserved for Future Use)
> > + *       Advertiser_Address: c0:07:e8:8b:69:f2
> > + *       Advertising_SID: 0x00
> > + *       Broadcast_ID: 0x001234
> > + *       PA_Sync: Synchronize to PA (PAST not available)
> > + *       PA_Interval: 0x2710
> > + *       Num_Subgroups: 2
> > + *         Subgroup #0:
> > + *           BIS_Sync: 00000000000000000000000000000000
> > + *           Metadata_Length: 0
> > + *         Subgroup #1:
> > + *           BIS_Sync: 00000000000000000000000000000000
> > + *           Metadata_Length: 0
> > + * ATT: Write Command (0x52) len 26
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 0200F2698BE807C0003412000210270201000000000100000000
> > + *       Opcode: Add Source
> > + *       Advertiser_Address_Type: Public Device or Public Identity Address
> > + *       Advertiser_Address: c0:07:e8:8b:69:f2
> > + *       Advertising_SID: 0x00
> > + *       Broadcast_ID: 0x001234
> > + *       PA_Sync: Synchronize to PA (PAST not available)
> > + *       PA_Interval: 0x2710
> > + *       Num_Subgroups: 2
> > + *         Subgroup #0:
> > + *           BIS_Sync: 00000000000000000000000000000001
> > + *           Metadata_Length: 0
> > + *         Subgroup #1:
> > + *           BIS_Sync: 00000000000000000000000000000001
> > + *           Metadata_Length: 0
> > + */
> > +#define ADD_SRC_INVALID_PARAMS \
> > +       EXCHANGE_MTU, \
> > +       BASS_FIND_BY_TYPE_VALUE, \
> > +       DISC_BASS_CHAR, \
> > +       BASS_FIND_INFO, \
> > +       BASS_WRITE_CHAR_DESC,\
> > +       BASS_READ_BCAST_RECV_STATE_CHARS, \
> > +       BASS_CP_WRITE_CMD(0x02, 0x00, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0,
> \
> > +                       0x00, 0x34, 0x12, 0x00, 0x06, 0x10, 0x27, 0x02, \
> > +                       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
> > +                       0x00, 0x00), \
> > +       IOV_NULL, \
> > +       BASS_CP_WRITE_CMD(0x02, 0x05, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0,
> \
> > +                       0x00, 0x34, 0x12, 0x00, 0x02, 0x10, 0x27, 0x02, \
> > +                       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
> > +                       0x00, 0x00), \
> > +       IOV_NULL, \
> > +       BASS_CP_WRITE_CMD(0x02, 0x05, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0,
> \
> > +                       0x3F, 0x34, 0x12, 0x00, 0x02, 0x10, 0x27, 0x02, \
> > +                       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, \
> > +                       0x00, 0x00), \
> > +       IOV_NULL, \
> > +       BASS_CP_WRITE_CMD(0x02, 0x00, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0,
> \
> > +                       0x00, 0x34, 0x12, 0x00, 0x02, 0x10, 0x27, 0x02, \
> > +                       0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, \
> > +                       0x00, 0x00)
> > +
> > +/* ATT: Write Request (0x12) len 3
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: FF
> > + *       Opcode: 0xff (Reserved  For Future Use)
> > + * ATT: Error Response (0x01) len 4
> > + *   Write Request (0x12)
> > + *   Handle: 0x0009
> > + *   Error: Opcode Not Supported (0x80)
> > + */
> > +#define OPCODE_NOT_SUPPORTED \
> > +       EXCHANGE_MTU, \
> > +       BASS_FIND_BY_TYPE_VALUE, \
> > +       DISC_BASS_CHAR, \
> > +       BASS_FIND_INFO, \
> > +       BASS_WRITE_CHAR_DESC,\
> > +       BASS_READ_BCAST_RECV_STATE_CHARS, \
> > +       BASS_CP_WRITE_REQ(0xFF), \
> > +       IOV_DATA(0x01, 0x12, 0x09, 0x00, 0x80)
> > +
> > +/* ATT: Write Command (0x52) len 26
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 0200F2698BE807C000F5D983021027010000000000
> > + *       Opcode: Add Source
> > + *       Advertiser_Address_Type: Public Device or Public Identity Address
> > + *       Advertiser_Address: c0:07:e8:8b:69:f2
> > + *       Advertising_SID: 0x00
> > + *       Broadcast_ID: 0x83d9f5
> > + *       PA_Sync: Synchronize to PA (PAST not available)
> > + *       PA_Interval: 0x2710
> > + *       Num_Subgroups: 1
> > + *         Subgroup #0:
> > + *           BIS_Sync: 00000000000000000000000000000000
> > + *           Metadata_Length: 0
> > + * ATT: Handle Value Notification (0x1b) len 22
> > + *   Handle: 0x0003 Type: Broadcast Receive State (0x2bc8)
> > + *     Data: 0100F2698BE807C000F5D9830200010000000000
> > + *       Source_ID: 0x01
> > + *       Source_Address_Type: Public Device or Public Identity Address
> > + *       Source_Address: c0:07:e8:8b:69:f2
> > + *       Source_Adv_SID: 0x00
> > + *       Broadcast_ID: 0x83d9f5
> > + *       PA_Sync_State: Synchronized to PA
> > + *       BIG_Encryption: Not encrypted
> > + *       Num_Subgroups: 1
> > + *       Subgroup #0:
> > + *         BIS_Sync State: 00000000000000000000000000000000
> > + *         Metadata_Length: 0
> > + * ATT: Read Request (0x0a) len 2
> > + *   Handle: 0x0003 Type: Broadcast Receive State (0x2bc8)
> > + * ATT: Read Response (0x0b) len 20
> > + *   Handle: 0x0003 Broadcast Receive State (0x2bc8)
> > + *     Source_ID: 0x01
> > + *     Source_Address_Type: Public Device or Public Identity Address
> > + *     Source_Address: c0:07:e8:8b:69:f2
> > + *     Source_Adv_SID: 0x00
> > + *     Broadcast_ID: 0x83d9f5
> > + *     PA_Sync_State: Synchronized to PA
> > + *     BIG_Encryption: Not encrypted
> > + *     Num_Subgroups: 1
> > + *     Subgroup #0:
> > + *       BIS_Sync State: 00000000000000000000000000000000
> > + *       Metadata_Length: 0
> > + * ATT: Write Request (0x12) len 2
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 0501
> > + *       Opcode: Remove Source
> > + *       Source_ID: 1
> > + * ATT: Write Response (0x13) len 0
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + */
> > +#define RM_SRC_WHILE_SYNC \
> > +       EXCHANGE_MTU, \
> > +       BASS_FIND_BY_TYPE_VALUE, \
> > +       DISC_BASS_CHAR, \
> > +       BASS_FIND_INFO, \
> > +       BASS_WRITE_CHAR_DESC, \
> > +       BASS_READ_BCAST_RECV_STATE_CHARS, \
> > +       BASS_CP_WRITE_CMD(0x02, 0x00, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0,
> \
> > +                       0x00, 0xF5, 0xD9, 0x83, 0x02, 0x10, 0x27, 0x01, \
> > +                       0x00, 0x00, 0x00, 0x00, 0x00), \
> > +       IOV_DATA(0x1b, 0x03, 0x00, 0x01, 0x00, 0xF2, 0x69, 0x8B, 0xE8, \
> > +               0x07, 0xC0, 0x00, 0xF5, 0xD9, 0x83, 0x02, 0x00, 0x01, \
> > +               0x00, 0x00, 0x00, 0x00, 0x00), \
> > +       IOV_DATA(0x0a, 0x03, 0x00), \
> > +       IOV_DATA(0x0b, 0x01, 0x00, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0, 0x00, \
> > +               0xF5, 0xD9, 0x83, 0x02, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, \
> > +               0x00), \
> > +       BASS_CP_WRITE_REQ(0x05, 0x01), \
> > +       IOV_DATA(0x13)
> > +
> > +/* ATT: Write Request (0x12) len 5
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 006dfe
> > + *       Opcode: Remote Scan Stopped
> > + *       Extra Data: 0xfe6d
> > + * ATT: Error Response (0x01) len 4
> > + *   Write Request (0x12)
> > + *   Handle: 0x0009
> > + *   Error: Write Request Rejected (0xFC)
> > + * ATT: Write Request (0x12) len 5
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 006dfe
> > + *       Opcode: Remote Scan Started
> > + *       Extra Data: 0xa2c2
> > + * ATT: Error Response (0x01) len 4
> > + *   Write Request (0x12)
> > + *   Handle: 0x0009
> > + *   Error: Write Request Rejected (0xFC)
> > + * ATT: Write Request (0x12) len 25
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 0200F2698BE807C0003412000210270100000000000000
> > + *       Opcode: Add Source
> > + *       Advertiser_Address_Type: Public Device or Public Identity Address
> > + *       Advertiser_Address: c0:07:e8:8b:69:f2
> > + *       Advertising_SID: 0x00
> > + *       Broadcast_ID: 0x001234
> > + *       PA_Sync: Synchronize to PA (PAST not available)
> > + *       PA_Interval: 0x2710
> > + *       Num_Subgroups: 1
> > + *         Subgroup #0:
> > + *           BIS_Sync: 00000000000000000000000000000001
> > + *           Metadata_Length: 0
> > + *       Extra Data: 0x0000
> > + * ATT: Error Response (0x01) len 4
> > + *   Write Request (0x12)
> > + *   Handle: 0x0009
> > + *   Error: Write Request Rejected (0xFC)
> > + * ATT: Write Request (0x12) len 13
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 03000210270100000000001500
> > + *       Opcode: Modify Source
> > + *       Source_ID: 0x00
> > + *       PA_Sync: Synchronize to PA (PAST not available)
> > + *       PA_Interval: 0x2710
> > + *       Num_Subgroups: 1
> > + *         Subgroup #0:
> > + *           BIS_Sync: 00000000000000000000000000000001
> > + *           Metadata_Length: 0
> > + *       Extra Data: 0x0015
> > + * ATT: Error Response (0x01) len 4
> > + *   Write Request (0x12)
> > + *   Handle: 0x0009
> > + *   Error: Write Request Rejected (0xFC)
> > + * ATT: Write Request (0x12) len 20
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 0400B803EAC6AFBB65A25A41F153056802010000
> > + *       Opcode: Set Broadcast_Code
> > + *       Source_ID: 0x00
> > + *       Broadcast_Code: 0x0102680553f1415aa265bbafc6ea03b8
> > + *       Extra Data: 0x0000
> > + * ATT: Error Response (0x01) len 4
> > + *   Write Request (0x12)
> > + *   Handle: 0x0009
> > + *   Error: Write Request Rejected (0xFC)
> > + * ATT: Write Request (0x12) len 4
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 05008F13
> > + *       Opcode: Remove Source
> > + *       Source_ID: 0x00
> > + *       Extra Data: 0x138f
> > + * ATT: Error Response (0x01) len 4
> > + *   Write Request (0x12)
> > + *   Handle: 0x0009
> > + *   Error: Write Request Rejected (0xFC)
> > + */
> > +#define INVALID_LEN \
> > +       EXCHANGE_MTU, \
> > +       BASS_FIND_BY_TYPE_VALUE, \
> > +       DISC_BASS_CHAR, \
> > +       BASS_FIND_INFO, \
> > +       BASS_WRITE_CHAR_DESC,\
> > +       BASS_READ_BCAST_RECV_STATE_CHARS, \
> > +       BASS_CP_WRITE_REQ(0x00, 0x6D, 0xFE), \
> > +       IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFC), \
> > +       BASS_CP_WRITE_REQ(0x01, 0xC2, 0xA2), \
> > +       IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFC), \
> > +       BASS_CP_WRITE_REQ(0x02, 0x00, 0xF2, 0x69, 0x8B, 0xE8, 0x07, 0xC0, \
> > +                       0x00, 0x34, 0x12, 0x00, 0x02, 0x10, 0x27, 0x01, \
> > +                       0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00), \
> > +       IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFC), \
> > +       BASS_CP_WRITE_REQ(0x03, 0x00, 0x02, 0x10, 0x27, 0x01, 0x00, 0x00, \
> > +                       0x00, 0x00, 0x00, 0x15, 0x00), \
> > +       IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFC), \
> > +       BASS_CP_WRITE_REQ(0x04, 0x00, 0xB8, 0x03, 0xEA, 0xC6, 0xAF, 0xBB,
> \
> > +                       0x65, 0xA2, 0x5A, 0x41, 0xF1, 0x53, 0x05, 0x68, \
> > +                       0x02, 0x01, 0x00, 0x00), \
> > +       IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFC), \
> > +       BASS_CP_WRITE_REQ(0x05, 0x00, 0x8F, 0x13), \
> > +       IOV_DATA(0x01, 0x12, 0x09, 0x00, 0xFC)
> > +
> > +/* ATT: Write Request (0x12) len 20
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 0400B803EAC6AFBB65A25A41F153056802010000
> > + *       Opcode: Set Broadcast_Code
> > + *       Source_ID: 0x05
> > + *       Broadcast_Code: 0x0102680553f1415aa265bbafc6ea03b
> > + * ATT: Error Response (0x01) len 4
> > + *   Write Request (0x12)
> > + *   Handle: 0x0009
> > + *   Error: Invalid Source ID (0x81)
> > + * ATT: Write Request (0x12) len 4
> > + *   Handle: 0x0009 Type: Broadcast Audio Scan Control Point (0x2bc7)
> > + *     Data: 005
> > + *       Opcode: Remove Source
> > + *       Source_ID: 0x05
> > + * ATT: Error Response (0x01) len 4
> > + *   Write Request (0x12)
> > + *   Handle: 0x0009
> > + *   Error: Invalid Source ID (0x81)
> > + */
> > +#define INVALID_SRC_ID \
> > +       EXCHANGE_MTU, \
> > +       BASS_FIND_BY_TYPE_VALUE, \
> > +       DISC_BASS_CHAR, \
> > +       BASS_FIND_INFO, \
> > +       BASS_WRITE_CHAR_DESC, \
> > +       BASS_READ_BCAST_RECV_STATE_CHARS, \
> > +       BASS_CP_WRITE_REQ(0x04, 0x05, 0xB8, 0x03, 0xEA, 0xC6, 0xAF, 0xBB,
> \
> > +                       0x65, 0xA2, 0x5A, 0x41, 0xF1, 0x53, 0x05, 0x68, \
> > +                       0x02, 0x01), \
> > +       IOV_DATA(0x01, 0x12, 0x09, 0x00, 0x81), \
> > +       BASS_CP_WRITE_REQ(0x05, 0x05), \
> > +       IOV_DATA(0x01, 0x12, 0x09, 0x00, 0x81)
> > +
> > +static const uint8_t client_bdaddr[] = {0xF2, 0x69, 0x8B, 0xE8, 0x07,
> > +0xC0};
> > +
> > +static const uint8_t set_iso_socket_param[] = {
> > +       0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6, 0x85, 0x98, /* UUID - ISO Socket */
> > +       0x6a, 0x49, 0xe0, 0x05, 0x88, 0xf1, 0xba, 0x6f,
> > +       0x01,                                           /* Action - enable */
> > +};
> > +
> > +static const uint8_t reset_iso_socket_param[] = {
> > +       0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6, 0x85, 0x98, /* UUID - ISO Socket */
> > +       0x6a, 0x49, 0xe0, 0x05, 0x88, 0xf1, 0xba, 0x6f,
> > +       0x00,                                           /* Action - disable */
> > +};
> > +
> >  #define iov_data(args...) ((const struct iovec[]) { args })
> >
> > -#define define_test(name, function, _cfg, args...)             \
> > +#define define_test(name, pre_setup, setup, function, teardown,        \
> > +                                       post_teardown, args...) \
> >         do {                                                    \
> >                 const struct iovec iov[] = { args };            \
> >                 static struct test_data data;                   \
> >                 data.iovcnt = ARRAY_SIZE(iov_data(args));       \
> >                 data.iov = util_iov_dup(iov, ARRAY_SIZE(iov_data(args))); \
> > -               tester_add(name, &data, NULL, function, \
> > -                               test_teardown);                 \
> > +               tester_add_full(name, &data, pre_setup, setup, function, \
> > +                               teardown, post_teardown, 0, NULL,
> > + NULL); \
> >         } while (0)
> >
> >  static void test_complete_cb(const void *user_data) @@ -287,11
> > +680,282 @@ done:
> >         gatt_db_attribute_read_result(attrib, id, ecode, value, len);
> > }
> >
> > +static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
> > +                               unsigned int id, uint16_t offset,
> > +                               const uint8_t *value, size_t len,
> > +                               uint8_t opcode, struct bt_att *att,
> > +                               void *user_data) {
> > +       struct test_data *data = (void *)user_data;
> > +       struct ccc_state *ccc_state;
> > +       uint16_t val;
> > +       uint8_t ecode = 0;
> > +
> > +       if (!value || len > 2) {
> > +               ecode = BT_ATT_ERROR_INVALID_ATTRIBUTE_VALUE_LEN;
> > +               goto done;
> > +       }
> > +
> > +       if (offset > 2) {
> > +               ecode = BT_ATT_ERROR_INVALID_OFFSET;
> > +               goto done;
> > +       }
> > +
> > +       if (len == 1)
> > +               val = *value;
> > +       else
> > +               val = get_le16(value);
> > +
> > +       ccc_state = get_ccc_state(data,
> gatt_db_attribute_get_handle(attrib));
> > +       if (!ccc_state)
> > +               return;
> > +
> > +       /* If value is identical, then just succeed */
> > +       if (val == ccc_state->value)
> > +               goto done;
> > +
> > +       ccc_state->value = val;
> > +
> > +done:
> > +       gatt_db_attribute_write_result(attrib, id, ecode); }
> > +
> > +static void gatt_notify_cb(struct gatt_db_attribute *attrib,
> > +                               struct gatt_db_attribute *ccc,
> > +                               const uint8_t *value, size_t len,
> > +                               struct bt_att *att, void *user_data) {
> > +       struct test_data *data = user_data;
> > +       struct ccc_state *ccc_state;
> > +
> > +       ccc_state = find_ccc_state(data, gatt_db_attribute_get_handle(ccc));
> > +       if (!ccc_state || !(ccc_state->value & 0x0001))
> > +               return;
> > +
> > +       bt_gatt_server_send_notification(data->server,
> > +               gatt_db_attribute_get_handle(attrib),
> > +               value, len, false);
> > +}
> > +
> > +static void set_iso_socket_callback(uint8_t status, uint16_t length,
> > +                                       const void *param, void
> > +*user_data) {
> > +       if (status != MGMT_STATUS_SUCCESS) {
> > +               tester_print("ISO socket feature could not be enabled");
> > +               return;
> > +       }
> > +
> > +       tester_print("ISO socket feature is enabled"); }
> > +
> > +static void read_info_callback(uint8_t status, uint16_t length,
> > +                                       const void *param, void
> > +*user_data) {
> > +       struct test_data *data = (void *)user_data;
> > +       const struct mgmt_rp_read_info *rp = param;
> > +       char addr[18];
> > +       uint16_t manufacturer;
> > +       uint32_t supported_settings, current_settings;
> > +
> > +       tester_print("Read Info callback");
> > +       tester_print("  Status: 0x%02x", status);
> > +
> > +       if (status || !param) {
> > +               tester_pre_setup_failed();
> > +               return;
> > +       }
> > +
> > +       ba2str(&rp->bdaddr, addr);
> > +       manufacturer = btohs(rp->manufacturer);
> > +       supported_settings = btohl(rp->supported_settings);
> > +       current_settings = btohl(rp->current_settings);
> > +
> > +       tester_print("  Address: %s", addr);
> > +       tester_print("  Version: 0x%02x", rp->version);
> > +       tester_print("  Manufacturer: 0x%04x", manufacturer);
> > +       tester_print("  Supported settings: 0x%08x", supported_settings);
> > +       tester_print("  Current settings: 0x%08x", current_settings);
> > +       tester_print("  Class: 0x%02x%02x%02x",
> > +                       rp->dev_class[2], rp->dev_class[1], rp->dev_class[0]);
> > +       tester_print("  Name: %s", rp->name);
> > +       tester_print("  Short name: %s", rp->short_name);
> > +
> > +       if (strcmp(hciemu_get_address(data->hciemu), addr)) {
> > +               tester_pre_setup_failed();
> > +               return;
> > +       }
> > +
> > +       tester_pre_setup_complete();
> > +}
> > +
> > +static void index_added_callback(uint16_t index, uint16_t length,
> > +                                       const void *param, void
> > +*user_data) {
> > +       struct test_data *data = (void *)user_data;
> > +
> > +       tester_print("Index Added callback");
> > +       tester_print("  Index: 0x%04x", index);
> > +
> > +       data->mgmt_index = index;
> > +
> > +       mgmt_send(data->mgmt, MGMT_OP_READ_INFO, data-
> >mgmt_index, 0, NULL,
> > +                                       read_info_callback, data,
> > +NULL); }
> > +
> > +static void index_removed_callback(uint16_t index, uint16_t length,
> > +                                       const void *param, void
> > +*user_data) {
> > +       struct test_data *data = (void *)user_data;
> > +
> > +       tester_print("Index Removed callback");
> > +       tester_print("  Index: 0x%04x", index);
> > +
> > +       if (index != data->mgmt_index)
> > +               return;
> > +
> > +       mgmt_unregister_index(data->mgmt, data->mgmt_index);
> > +
> > +       mgmt_unref(data->mgmt);
> > +       data->mgmt = NULL;
> > +
> > +       tester_post_teardown_complete(); }
> > +
> > +static void read_index_list_callback(uint8_t status, uint16_t length,
> > +                                       const void *param, void
> > +*user_data) {
> > +       struct test_data *data = (void *)user_data;
> > +       struct hciemu_client *client;
> > +
> > +       tester_print("Read Index List callback");
> > +       tester_print("  Status: 0x%02x", status);
> > +
> > +       if (status || !param) {
> > +               tester_pre_setup_failed();
> > +               return;
> > +       }
> > +
> > +       mgmt_register(data->mgmt, MGMT_EV_INDEX_ADDED,
> MGMT_INDEX_NONE,
> > +                                       index_added_callback, data,
> > + NULL);
> > +
> > +       mgmt_register(data->mgmt, MGMT_EV_INDEX_REMOVED,
> MGMT_INDEX_NONE,
> > +                                       index_removed_callback, data,
> > + NULL);
> > +
> > +       data->hciemu = hciemu_new(HCIEMU_TYPE_BREDRLE52);
> > +       if (!data->hciemu) {
> > +               tester_warn("Failed to setup HCI emulation");
> > +               tester_pre_setup_failed();
> > +               return;
> > +       }
> > +
> > +       client = hciemu_get_client(data->hciemu, 0);
> > +
> > +       if (!hciemu_set_client_bdaddr(client, client_bdaddr)) {
> > +               tester_warn("Failed to setup HCI emulation");
> > +               tester_pre_setup_failed();
> > +               return;
> > +       }
> > +
> > +       tester_print("New hciemu instance created"); }
> > +
> > +static void test_pre_setup(const void *test_data) {
> > +       struct test_data *data = (void *)test_data;
> > +
> > +       data->mgmt = mgmt_new_default();
> > +       if (!data->mgmt) {
> > +               tester_warn("Failed to setup management interface");
> > +               tester_pre_setup_failed();
> > +               return;
> > +       }
> > +
> > +       mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE,
> MGMT_INDEX_NONE,
> > +                 sizeof(set_iso_socket_param), set_iso_socket_param,
> > +                 set_iso_socket_callback, NULL, NULL);
> > +
> > +       mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST,
> MGMT_INDEX_NONE, 0, NULL,
> > +                                       read_index_list_callback,
> > +data, NULL); }
> > +
> > +static void test_post_teardown(const void *test_data) {
> > +       struct test_data *data = (void *)test_data;
> > +
> > +       mgmt_send(data->mgmt, MGMT_OP_SET_EXP_FEATURE,
> MGMT_INDEX_NONE,
> > +                 sizeof(reset_iso_socket_param), reset_iso_socket_param,
> > +                 NULL, NULL, NULL);
> > +
> > +       hciemu_unref(data->hciemu);
> > +       data->hciemu = NULL;
> > +}
> > +
> > +static void client_connectable_complete(uint16_t opcode, uint8_t status,
> > +                                       const void *param, uint8_t len,
> > +                                       void *user_data) {
> > +       if (opcode != BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE)
> > +               return;
> > +
> > +       tester_print("Client set connectable status 0x%02x", status);
> > +
> > +       if (status)
> > +               tester_setup_failed();
> > +       else
> > +               tester_setup_complete(); }
> > +
> > +static void setup_powered_callback(uint8_t status, uint16_t length,
> > +                                       const void *param, void
> > +*user_data) {
> > +       struct test_data *data = (void *)user_data;
> > +       struct hciemu_client *client;
> > +       struct bthost *host;
> > +       uint8_t bcode[16] = {0x00};
> > +
> > +       if (status != MGMT_STATUS_SUCCESS) {
> > +               tester_setup_failed();
> > +               return;
> > +       }
> > +
> > +       tester_print("Controller powered on");
> > +
> > +       client = hciemu_get_client(data->hciemu, 0);
> > +       host = hciemu_client_host(client);
> > +       bthost_set_cmd_complete_cb(host, client_connectable_complete,
> > +                                                               data);
> > +       bthost_set_ext_adv_params(host);
> > +       bthost_set_ext_adv_enable(host, 0x01);
> > +
> > +       bthost_set_pa_params(host);
> > +       bthost_set_pa_enable(host, 0x01);
> > +       bthost_create_big(host, 1, 0x00, bcode); }
> > +
> > +static void setup_powered(const void *test_data) {
> > +       struct test_data *data = (void *)test_data;
> > +       unsigned char param[] = { 0x01 };
> > +
> > +       tester_print("Powering on controller");
> > +
> > +       mgmt_send(data->mgmt, MGMT_OP_SET_SSP, data->mgmt_index,
> > +                               sizeof(param), param, NULL, NULL,
> > + NULL);
> > +
> > +       mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
> > +                               sizeof(param), param, NULL, NULL,
> > + NULL);
> > +
> > +       mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data-
> >mgmt_index,
> > +                                       sizeof(param), param,
> > +                                       setup_powered_callback, data,
> > +NULL); }
> > +
> >  static void test_server(const void *user_data)  {
> >         struct test_data *data = (void *)user_data;
> >         struct bt_att *att;
> >         struct io *io;
> > +       bdaddr_t adapter_bdaddr = {{0, 0, 0, 0, 0, 0}};
> >
> >         io = tester_setup_io(data->iov, data->iovcnt);
> >         g_assert(io);
> > @@ -306,12 +970,22 @@ static void test_server(const void *user_data)
> >         data->db = gatt_db_new();
> >         g_assert(data->db);
> >
> > -       gatt_db_ccc_register(data->db, gatt_ccc_read_cb, NULL,
> > -                                       NULL, data);
> > +       gatt_db_ccc_register(data->db, gatt_ccc_read_cb, gatt_ccc_write_cb,
> > +                                       gatt_notify_cb, data);
> >
> > -       data->bass = bt_bass_new(data->db, NULL, BDADDR_ANY);
> > +       if (data->hciemu)
> > +               memcpy(&adapter_bdaddr,
> > +                     hciemu_get_central_bdaddr(data->hciemu),
> > +                     sizeof(adapter_bdaddr));
> > +
> > +       data->bass = bt_bass_new(data->db, NULL, &adapter_bdaddr);
> >         g_assert(data->bass);
> >
> > +       bt_bass_set_att(data->bass, att);
> > +       bt_bass_attach(data->bass, NULL);
> > +
> > +       bt_bass_set_debug(data->bass, print_debug, "bt_bass:", NULL);
> > +
> >         data->server = bt_gatt_server_new(data->db, att, 64, 0);
> >         g_assert(data->server);
> >
> > @@ -346,8 +1020,8 @@ static void test_sggit(void)
> >          * handle range of the request. The IUT reports all BASS
> >          * characteristics.
> >          */
> > -       define_test("BASS/SR/SGGIT/SER/BV-01-C", test_server, NULL,
> > -                                                       DISC_BASS_SER);
> > +       define_test("BASS/SR/SGGIT/SER/BV-01-C", NULL, NULL, test_server,
> > +                                       test_teardown, NULL, DISC_BASS_SER);
> >
> >         /* BASS/SR/SGGIT/CHA/BV-01-C [Service GGIT -
> >          * Broadcast Audio Scan Control Point]
> > @@ -359,8 +1033,8 @@ static void test_sggit(void)
> >          * handle range of the request. The IUT reports one instance of the
> >          * Broadcast Audio Scan Control Point characteristic.
> >          */
> > -       define_test("BASS/SR/SGGIT/CHA/BV-01-C", test_server, NULL,
> > -                                               DISC_BCAST_AUDIO_SCAN_CP);
> > +       define_test("BASS/SR/SGGIT/CHA/BV-01-C", NULL, NULL, test_server,
> > +                               test_teardown, NULL, DISC_BCAST_AUDIO_SCAN_CP);
> >
> >         /* BASS/SR/SGGIT/CHA/BV-02-C [Service GGIT -
> >          * Broadcast Receive State]
> > @@ -383,8 +1057,90 @@ static void test_sggit(void)
> >          * The IUT sends an ATT_Read_Response to the Lower Tester for each
> >          * ATT_Read_Request.
> >          */
> > -       define_test("BASS/SR/SGGIT/CHA/BV-02-C", test_server, NULL,
> > -                                               DISC_BCAST_RECV_STATE);
> > +       define_test("BASS/SR/SGGIT/CHA/BV-02-C", NULL, NULL, test_server,
> > +                               test_teardown, NULL, DISC_BCAST_RECV_STATE);
> > +}
> > +
> > +static void test_spe(void)
> > +{
> > +       /* BASS/SR/SPE/BI-01-C [Ignore Invalid Source ID]
> > +        *
> > +        * Test Purpose:
> > +        * Verify that the BASS Server IUT does not respond to a control point
> > +        * procedure call that uses an invalid Source_ID parameter.
> > +        *
> > +        * Pass verdict:
> > +        * The IUT does not send a notification of the Broadcast Receive State
> > +        * characteristic.
> > +        */
> > +       define_test("BASS/SR/SPE/BI-01-C", NULL, NULL, test_server,
> > +                               test_teardown, NULL, IGNORE_INVALID_SRC_ID);
> > +
> > +       /* BASS/SR/SPE/BI-03-C [Add Source - Ignore Invalid Values]
> > +        *
> > +        * Test Purpose:
> > +        * Verify that the BASS Server IUT ignores Add Source control point
> > +        * procedure calls that include an RFU or Invalid parameter.
> > +        *
> > +        * Pass verdict:
> > +        * The IUT does not send a notification of the Broadcast Receive State
> > +        * characteristic.
> > +        */
> > +       define_test("BASS/SR/SPE/BI-03-C", NULL, NULL, test_server,
> > +                               test_teardown, NULL, ADD_SRC_INVALID_PARAMS);
> > +
> > +       /* BASS/SR/SPE/BI-04-C [Opcode Not Supported]
> > +        *
> > +        * Test Purpose:
> > +        * Verify that the BASS Server IUT returns an Opcode Not Supported
> error
> > +        * response when the opcode written is not supported by the IUT or is
> > +        * within a range that is reserved for future use being written to the
> > +        * Broadcast Audio Scan Control Point.
> > +        *
> > +        * Pass verdict:
> > +        * The IUT sends an error response of OPCODE NOT SUPPORTED.
> > +        */
> > +       define_test("BASS/SR/SPE/BI-04-C", NULL, NULL, test_server,
> > +                               test_teardown, NULL, OPCODE_NOT_SUPPORTED);
> > +
> > +       /* BASS/SR/SPE/BI-05-C [Remove Source While Synchronized to a
> Source]
> > +        *
> > +        * Test Purpose:
> > +        * Verify that the BASS Server IUT, if synchronized to PA and/or BIS,
> > +        * does not accept the Remove Source operation request.
> > +        *
> > +        * Pass verdict:
> > +        * The IUT does not send a notification to the Lower Tester for the
> > +        * Broadcast Receive State characteristic.
> > +        */
> > +       define_test("BASS/SR/SPE/BI-05-C", test_pre_setup, setup_powered,
> > +                               test_server, test_teardown, test_post_teardown,
> > +                               RM_SRC_WHILE_SYNC);
> > +
> > +       /* BASS/SR/SPE/BI-06-C [Invalid Length]
> > +        *
> > +        * Test Purpose:
> > +        * Verify that the BASS Server IUT rejects writing of an opcode with
> > +        * an invalid length.
> > +        *
> > +        * Pass verdict:
> > +        * The IUT rejects the opcode.
> > +        */
> > +       define_test("BASS/SR/SPE/BI-06-C", NULL, NULL, test_server,
> > +                                       test_teardown, NULL, INVALID_LEN);
> > +
> > +       /* BASS/SR/SPE/BI-07-C [Invalid Source ID]
> > +        *
> > +        * Test Purpose:
> > +        * Verify that the BASS Server IUT returns an error when a control
> > +        * point procedure passing an invalid Source_ID parameter is called.
> > +        *
> > +        * Pass verdict:
> > +        * The IUT sends an ATT Error Response with the Error Code set to
> > +        * Invalid Source_ID.
> > +        */
> > +       define_test("BASS/SR/SPE/BI-07-C", NULL, NULL, test_server,
> > +                                       test_teardown, NULL, INVALID_SRC_ID);
> >  }
> >
> >  int main(int argc, char *argv[])
> > @@ -392,6 +1148,7 @@ int main(int argc, char *argv[])
> >         tester_init(&argc, &argv);
> >
> >         test_sggit();
> > +       test_spe();
> >
> >         return tester_run();
> >  }
> > --
> > 2.39.2
> 
> Some tests don't seem to be running:
> 
> BASS/SR/SPE/BI-05-C                                  Not Run
> 
> And if I try with sudo it just hangs, anyway make check is probably
> not required to run with sudo so Id consider removing the hciemu logic
> and just hardcode the expect HCI traffic has happened, anyway the idea
> of unit test suite is just to test the shared library portion, if we
> need a more complete end-to-end then it is probably better to have it
> run with test-runner so it run in its own vm with tester.config, etc.
> 

I understand, I removed the emulator framework and I submitted a new
patch with the tests that only require the shared library.

> 
> --
> Luiz Augusto von Dentz

Regards,
Iulia

