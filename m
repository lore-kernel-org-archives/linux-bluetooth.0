Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BC1EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 15:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjFSPD3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjFSPDJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 11:03:09 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2064.outbound.protection.outlook.com [40.107.105.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6015F1FFC
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 08:00:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyOPVdOgDQmtTGctikk58VkVHHNN8bUVp3vHTj8hGFn0RRoRSfI7n0s9kEN2uqc2rUVAHH1Oov7tKw1b1zy/epwLx+xA4XEuZRhioLVadAZ8Yjdu1t/fIbzq6fM7k9KClxdkkkXboX8y9SYIBd7ODqKPU3mxn5dW709TYKFh8iFLKXLXrlDmQkaJCyqUh7OWNVjiFrthCl993fR+Z65jqeHw0Cc3Nid2aNu88iItrOLk6nqRmqc4Ghvmf5nFgd8ZquZkkorfjZurSxfTYJLYwbw//aXJTGzeH3LX5t8ijA5pB7c2Vr08ndJ5DH0MweygW5KYx/yLN+7te5M9wqty1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=500fW/3hXdquOtGyaYeSTLM5yS0ZGh5w2cy9dPKLPYU=;
 b=g5DvpT1n4moQCnBQIyrYplDrRxejxTMa+v5P9a6ekWVofNGBoq7JUjz4/neJKn3GK4iIV80yOoOVKKkmFJyb85WAhoy/WrNhquooPQKvWQ0Bd2WakiHv7tNqc0scnbjgvBRVI+7Mr4AOuxG0Ph+OfkrarrYRairszBSNgdO+5zY0Hvc4o3i2x4BhZgY/FA0QW61dL++FtGvIhGqopdJbNmD3QzB1Z10cLC7FgOli27JA0tjo5N9n84gUdmZ6gWkO3vP41f5RYSjIKMCrUNlHYiTA8BF4xXS/EMZ1OuvO/KQ5198sGDCU6XwxzSufygN8DssqvsWn2F0SC0L4bhNy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=500fW/3hXdquOtGyaYeSTLM5yS0ZGh5w2cy9dPKLPYU=;
 b=c3Qmk1j9l1/uIWoD7fZkwRA7y4CY+xDD8v95ynoXwQ9+2GuYDbE388SUo0FyLVF1vbnRRWZVch5J2XGQpiPAz3zEENeBAHvzvhCQHo3bf/64GtACKvUaHaXq8T9tOohJCJ7tkDZ0V4u8i/asv3Rh4a40COV7fw2/jLlW6RTyREE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7027.eurprd04.prod.outlook.com (2603:10a6:208:191::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 15:00:22 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 15:00:22 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com
Subject: Re: [PATCH 1/1] Bluetooth: ISO: Support multiple BIGs
Date:   Mon, 19 Jun 2023 18:00:09 +0300
Message-Id: <20230619150009.3568-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZJhuteqCd8cam+_WDXAe2-ozLMhCRRKpO1WyYZx1JO+wQ@mail.gmail.com>
References: <CABBYNZJhuteqCd8cam+_WDXAe2-ozLMhCRRKpO1WyYZx1JO+wQ@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0007.eurprd03.prod.outlook.com
 (2603:10a6:208:14::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 08fb4850-e1a9-49e7-e41e-08db70d5e7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uLfooAJJmqRsmUNIlU1mMP1P4H/Ho2sqv/jCiPtel7053KTOqymkRDpZP+3xrwWzLdowE+S6R8HVa4B+k/QFFI2lJnsC5aeeW/suXaoIz2kUpkyrt8FB7ek6nqp4yqhReWuN4Fun1AUpj194BrgrJBSqcKIMNqoJVLSxW9sX1whgJhQdQs0z3yhE8LRitv4CIWgASeO9KXNkRalQ/94LPk7GkwIN3owQDH6kv6lJMGWd4W1PVz2QBi4pqbxjiFeZk84BbREH4dQ5Uw1THlpiZajrR0GJnJMqMBBn5DSDSvA2t7nW52w0onVgqMtb83Pt911ROf4XU3zb4kFGyPpWtAGLhoBIgbGGaGRe+jTUscbHZhf+4zRQkfXCIR3Q9kCTwu0LVudncqiYqyR9sxwCLKEJRL30HbzZyHo8gXxf6GkiJ1XR4vsNuuk7TLF2zliKNVeiBHBkIJE5LMW/jn6DufVBKcUc0uZ6CDjt6poroekweM9QljtUgEB99LaIHmGBJoWFqZs7NMrLf30eO3AtVPYK/m1lXPmoLYI4Fmm9OgMHdnSmUYz7ogJez3IYZR+aGWT8VEI6OiKShu6EyuQTjhJnL4/uXEXHQP39z67207iikJvWYvJepqqGFdzbQGsn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(451199021)(478600001)(66946007)(66556008)(66476007)(6916009)(8676002)(36756003)(4326008)(41300700001)(2616005)(83380400001)(38350700002)(38100700002)(44832011)(6486002)(86362001)(52116002)(2906002)(5660300002)(6666004)(8936002)(316002)(30864003)(26005)(6506007)(1076003)(53546011)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uooKqadHQR+ua4fvGvHdpGSneh8BzI6j1Q6jUgAg2Y4ZJdfCqhZTXJhmvAZ5?=
 =?us-ascii?Q?C4uvR5jJb3lhrmGw0tuPJgsIfEIUIeD1i20N4HAQ+wFTWOdczklwqfv3ezqW?=
 =?us-ascii?Q?SVZsf2VLfwx2MHWzKeySqScmS3ev5WWD5963UfUaXIAfh5g5kFq/IHyJ355v?=
 =?us-ascii?Q?M91iK5LK5yqDkTE00SYRyZXEc3ZR5PzgeNtsGFo/B2nTg7IAZ2i4lgTDeJv5?=
 =?us-ascii?Q?cSqp3TGepdf8szk7tzosCsilUeNTv1gvBpack4ji/3QLjTvZc16C2xKLjbAu?=
 =?us-ascii?Q?3sy7/93KGWsyRQ5Qny66azqYKVJv6vEwzkS3hHg/xhrIaIws08Vi+V2/8HTt?=
 =?us-ascii?Q?flRsbghpWEAQDhgWv+GBk+WPAPKZs9Es2LeAxWoAvXb6DESPm+usRRoaxnt5?=
 =?us-ascii?Q?wA0p9N9ArSrDFWQ2RWM/Xo8PB3iWO+y0kKpS81GxaTojhNdgy/MWh1t+KrWL?=
 =?us-ascii?Q?JWwe1vzVBT4bV9psQtmssXQKOBf6/LRY2gsqSkelf5U7ZOXoi1EhDYvN4hTF?=
 =?us-ascii?Q?YndKCsPptiFipPnQny+qEez6LgMG+oeAuvQvhbPiin4W6df9vPl8nsZsaWt4?=
 =?us-ascii?Q?uCbeTNPsA5SzOv2WK+nFaJXvTjuFCqqoJ/9swdUrgAJT/WEKYGZst2EN8YdB?=
 =?us-ascii?Q?hUS19paYxMSU2x0Y0NsKIkOZvFVxsJhaRoejv9gPeQYqr/nmJdk6sduOjNaT?=
 =?us-ascii?Q?AVI3GZx3aK1UssPe3MVrUbS//4+0gZaT/LKrbQJML+ze1XWKk+8TC3sYexpg?=
 =?us-ascii?Q?hDSGbLBWSWjCcuxz/slbxdTzesn7gyzYPCCMQCVHmgAoooLoNbffYboKlZ1H?=
 =?us-ascii?Q?uisoWvNo1an6wjhFqETRdNg/KYm3+eW1OpwO0rTeQxXmPvwyeOzfbUa7206O?=
 =?us-ascii?Q?apFSJ4NMKjq7rUrbIka57ALL+MzvOnTxNHJXv4sTMolbCp/ubHr7GcJPmXmv?=
 =?us-ascii?Q?WCLh6YI9crKKFpcxW0qmeyQNfbcx+5fjCl6gkMPmUHnmllrIFw9mWm2wCFVK?=
 =?us-ascii?Q?98PjJx+2JB1YgGNQW80haun6gkO5W4qXqpUar4RLzlwvb7gqglNNImwiAXP6?=
 =?us-ascii?Q?TmPwaXGlfe1Oqn6ytsE5BM4Pho314MDc4NkgqM6lbNnYHNmaE7SCxyAL5fou?=
 =?us-ascii?Q?mHpjfqJT3Q6ZOtmeb0w5eqIcBae41h/QHuLJrzjrq18roIgR1GA2DrKhwTcV?=
 =?us-ascii?Q?CmmqWTDFDOgaYlRHB3cQAGvKZ3LmppKiLvTmVW9js8eA6OPn+4+e+cMfeaKf?=
 =?us-ascii?Q?7brGO6Qr8QeBGyPAZ5/a/FmYOMfhkyqnDHHsaVPhqPAejIqIUIBIx9w9Udel?=
 =?us-ascii?Q?jcGbnOHhCgTrZBmNP8DBhxyPQf8mdPiVNwialWPrMeqkLCTahj9LQqopkBPj?=
 =?us-ascii?Q?Fjt5Tkm8KDlX49oLu57bxYM+7n2isHkbTHaubiegBo0IQYwQ0ObS55Ajnvui?=
 =?us-ascii?Q?RkvBVJIb4JlNS53UjwMG4SWb9uDvyjnnRRTsWQI7Jek+iSirZB3rMAs7BYnc?=
 =?us-ascii?Q?YTWZJgJESaJ/7RUy94yWEj969AU6lRJrjmmvrkr3WarvB1U51Yx4ZG23/fUi?=
 =?us-ascii?Q?Wl2bIUE1X//Q5MzibN4/7mdHE8SIMjNrOd5Q/Er4ijLbVBeVedSPDGBjdj2n?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08fb4850-e1a9-49e7-e41e-08db70d5e7dd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 15:00:22.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ew98J7SXwQMzbgvt4O7X6qbhHnpohf33PXrN3LxVHQRFMBndM83hhJZ0bP2sp/MdF8DyOR4Ww4tG9aGIR8/D2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7027
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Wednesday, June 14, 2023 8:05 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Andrei Istodorescu
> <andrei.istodorescu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>
> Subject: Re: [PATCH 1/1] Bluetooth: ISO: Support multiple BIGs
> 
> Hi Iulia,
> 
> On Tue, Jun 13, 2023 at 7:26AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > This adds support for creating multiple BIGs. According to spec, each
> > BIG shall have an unique handle, and each BIG should be associated
> > with a different advertising handle. Otherwise, the LE Create BIG
> > command will fail, with error code Command Disallowed (for reusing a
> > BIG handle), or Unknown Advertising Identifier (for reusing an
> > advertising handle).
> >
> > The btmon snippet below shows an exercise for creating two BIGs for
> > the same controller, by opening two isotest instances with the
> > following command:
> >         tools/isotest -i hci0 -s 00:00:00:00:00:00
> >
> > < HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068)
> plen 31
> >         Handle: 0x00
> >         Advertising Handle: 0x01
> >         Number of BIS: 1
> >         SDU Interval: 10000 us (0x002710)
> >         Maximum SDU size: 40
> >         Maximum Latency: 10 ms (0x000a)
> >         RTN: 0x02
> >         PHY: LE 2M (0x02)
> >         Packing: Sequential (0x00)
> >         Framing: Unframed (0x00)
> >         Encryption: 0x00
> >         Broadcast Code: 00000000000000000000000000000000
> >
> > > HCI Event: Command Status (0x0f) plen 4
> >       LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
> >         Status: Success (0x00)
> >
> > > HCI Event: LE Meta Event (0x3e) plen 21
> >       LE Broadcast Isochronous Group Complete (0x1b)
> >         Status: Success (0x00)
> >         Handle: 0x00
> >         BIG Synchronization Delay: 912 us (0x000390)
> >         Transport Latency: 912 us (0x000390)
> >         PHY: LE 2M (0x02)
> >         NSE: 3
> >         BN: 1
> >         PTO: 1
> >         IRC: 3
> >         Maximum PDU: 40
> >         ISO Interval: 10.00 msec (0x0008)
> >         Connection Handle #0: 10
> >
> > < HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068)
> >         Handle: 0x01
> >         Advertising Handle: 0x02
> >         Number of BIS: 1
> >         SDU Interval: 10000 us (0x002710)
> >         Maximum SDU size: 40
> >         Maximum Latency: 10 ms (0x000a)
> >         RTN: 0x02
> >         PHY: LE 2M (0x02)
> >         
cking: Sequential (0x00)
> >         Framing: Unframed (0x00)
> >         Encryption: 0x00
> >         Broadcast Code: 00000000000000000000000000000000
> >
> > > HCI Event: Command Status (0x0f) plen 4
> >       LE Create Broadcast Isochronous Group (0x08|0x0068) ncmd 1
> >         Status: Success (0x00)
> >
> > Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > ---
> >  include/net/bluetooth/hci_core.h |  6 ++---
> >  net/bluetooth/hci_conn.c         | 40 ++++++++++++++------------------
> >  net/bluetooth/hci_event.c        | 30 ++++++++++++++++++++----
> >  net/bluetooth/hci_sync.c         |  9 +++++--
> >  4 files changed, 52 insertions(+), 33 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > index 683666ea210c..b5af9be70771 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -240,6 +240,7 @@ struct adv_info {
> >         bool    enabled;
> >         bool    pending;
> >         bool    periodic;
> > +       bool    per_enabled;
> 
> Can't we just reuse the enabled flag or we really need to have 2 to track the
> EA and the PA states separately?

I added the extra per_enabled flag because I thought it would cover all cases if
I keep the 2 advertising states separate, but if periodic advertising is always
enabled/disabled along with extended advertising, I see that having both the
enabled and per_enabled flags is redundant. So I will keep extended and periodic
advertising coupled and I will use the same enabled flag for periodic instances
also. I submitted an updated patch.

> 
> >         __u8    mesh;
> >         __u8    instance;
> >         __u32   flags;
> > @@ -1096,8 +1097,7 @@ static inline __u8 hci_conn_lookup_type(struct
> > hci_dev *hdev, __u16 handle)  }
> >
> >  static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev
> *hdev,
> > -                                                       bdaddr_t *ba,
> > -                                                       __u8 big, __u8 bis)
> > +                                                       bdaddr_t *ba,
> > + __u8 bis)
> >  {
> >         struct hci_conn_hash *h = &hdev->conn_hash;
> >         struct hci_conn  *c;
> > @@ -1108,7 +1108,7 @@ static inline struct hci_conn
> *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
> >                 if (bacmp(&c->dst, ba) || c->type != ISO_LINK)
> >                         continue;
> >
> > -               if (c->iso_qos.bcast.big == big && c->iso_qos.bcast.bis == bis) {
> > +               if (c->iso_qos.bcast.bis == bis) {
> >                         rcu_read_unlock();
> >                         return c;
> >                 }
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c index
> > 7d4941e6dbdf..8cd2ef0ab1d0 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -927,9 +927,7 @@ static void bis_cleanup(struct hci_conn *conn)
> >                 /* Check if ISO connection is a BIS and terminate advertising
> >                  * set and BIG if there are no other connections using it.
> >                  */
> > -               bis = hci_conn_hash_lookup_bis(hdev, BDADDR_ANY,
> > -                                              conn->iso_qos.bcast.big,
> > -                                              conn->iso_qos.bcast.bis);
> > +               bis = hci_conn_hash_lookup_big(hdev,
> > + conn->iso_qos.bcast.big);
> >                 if (bis)
> >                         return;
> >
> > @@ -1449,25 +1447,23 @@ static int hci_explicit_conn_params_set(struct
> > hci_dev *hdev,
> >
> >  static int qos_set_big(struct hci_dev *hdev, struct bt_iso_qos *qos)
> > {
> > -       struct iso_list_data data;
> > +       struct hci_conn *conn;
> > +       u8  big;
> >
> >         /* Allocate a BIG if not set */
> >         if (qos->bcast.big == BT_ISO_QOS_BIG_UNSET) {
> > -               for (data.big = 0x00; data.big < 0xef; data.big++) {
> > -                       data.count = 0;
> > -                       data.bis = 0xff;
> > +               for (big = 0x00; big < 0xef; big++) {
> >
> > -                       hci_conn_hash_list_state(hdev, bis_list, ISO_LINK,
> > -                                                BT_BOUND, &data);
> > -                       if (!data.count)
> > +                       conn = hci_conn_hash_lookup_big(hdev, big);
> > +                       if (!conn)
> >                                 break;
> >                 }
> >
> > -               if (data.big == 0xef)
> > +               if (big == 0xef)
> >                         return -EADDRNOTAVAIL;
> >
> >                 /* Update BIG */
> > -               qos->bcast.big = data.big;
> > +               qos->bcast.big = big;
> >         }
> >
> >         return 0;
> > @@ -1475,28 +1471,27 @@ static int qos_set_big(struct hci_dev *hdev,
> > struct bt_iso_qos *qos)
> >
> >  static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
> > {
> > -       struct iso_list_data data;
> > +       struct hci_conn *conn;
> > +       u8  bis;
> >
> >         /* Allocate BIS if not set */
> >         if (qos->bcast.bis == BT_ISO_QOS_BIS_UNSET) {
> >                 /* Find an unused adv set to advertise BIS, skip instance 0x00
> >                  * since it is reserved as general purpose set.
> >                  */
> > -               for (data.bis = 0x01; data.bis < hdev->le_num_of_adv_sets;
> > -                    data.bis++) {
> > -                       data.count = 0;
> > +               for (bis = 0x01; bis < hdev->le_num_of_adv_sets;
> > +                    bis++) {
> >
> > -                       hci_conn_hash_list_state(hdev, bis_list, ISO_LINK,
> > -                                                BT_BOUND, &data);
> > -                       if (!data.count)
> > +                       conn = hci_conn_hash_lookup_bis(hdev, BDADDR_ANY, bis);
> > +                       if (!conn)
> >                                 break;
> >                 }
> >
> > -               if (data.bis == hdev->le_num_of_adv_sets)
> > +               if (bis == hdev->le_num_of_adv_sets)
> >                         return -EADDRNOTAVAIL;
> >
> >                 /* Update BIS */
> > -               qos->bcast.bis = data.bis;
> > +               qos->bcast.bis = bis;
> >         }
> >
> >         return 0;
> > @@ -1534,8 +1529,7 @@ static struct hci_conn *hci_add_bis(struct hci_dev
> *hdev, bdaddr_t *dst,
> >         /* Check BIS settings against other bound BISes, since all
> >          * BISes in a BIG must have the same value for all parameters
> >          */
> > -       conn = hci_conn_hash_lookup_bis(hdev, dst, qos->bcast.big,
> > -                                       qos->bcast.bis);
> > +       conn = hci_conn_hash_lookup_big(hdev, qos->bcast.big);
> >
> >         if (conn && (memcmp(qos, &conn->iso_qos, sizeof(*qos)) ||
> >                      base_len != conn->le_per_adv_data_len || diff
> > --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c index
> > 7c199f7361f7..45525963e932 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -3938,24 +3938,44 @@ static u8 hci_cc_le_set_per_adv_enable(struct
> hci_dev *hdev, void *data,
> >                                        struct sk_buff *skb)  {
> >         struct hci_ev_status *rp = data;
> > -       __u8 *sent;
> > +       struct hci_cp_le_set_per_adv_enable *cp;
> > +       struct adv_info *adv = NULL, *n;
> >
> >         bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
> >
> >         if (rp->status)
> >                 return rp->status;
> >
> > -       sent = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_PER_ADV_ENABLE);
> > -       if (!sent)
> > +       cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_PER_ADV_ENABLE);
> > +       if (!cp)
> >                 return rp->status;
> >
> >         hci_dev_lock(hdev);
> >
> > -       if (*sent)
> > +       adv = hci_find_adv_instance(hdev, cp->handle);
> > +
> > +       if (cp->enable) {
> >                 hci_dev_set_flag(hdev, HCI_LE_PER_ADV);
> > -       else
> > +
> > +               if (adv)
> > +                       adv->per_enabled = true;
> > +       } else {
> > +               if (adv)
> > +                       adv->per_enabled = false;
> > +
> > +               /* If just one instance was disabled check if there are
> > +                * any other instance enabled before clearing HCI_LE_PER_ADV
> > +                */
> > +               list_for_each_entry_safe(adv, n, &hdev->adv_instances,
> > +                                        list) {
> > +                       if (adv->per_enabled)
> > +                               goto unlock;
> > +               }
> > +
> >                 hci_dev_clear_flag(hdev, HCI_LE_PER_ADV);
> > +       }
> >
> > +unlock:
> >         hci_dev_unlock(hdev);
> >
> >         return rp->status;
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c index
> > 97da5bcaa904..2fd7ab377d30 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -3,6 +3,7 @@
> >   * BlueZ - Bluetooth protocol stack for Linux
> >   *
> >   * Copyright (C) 2021 Intel Corporation
> > + * Copyright 2023 NXP
> >   */
> >
> >  #include <linux/property.h>
> > @@ -1319,9 +1320,11 @@ int hci_start_ext_adv_sync(struct hci_dev
> > *hdev, u8 instance)  static int
> > hci_disable_per_advertising_sync(struct hci_dev *hdev, u8 instance)  {
> >         struct hci_cp_le_set_per_adv_enable cp;
> > +       struct adv_info *adv = NULL;
> >
> >         /* If periodic advertising already disabled there is nothing to do. */
> > -       if (!hci_dev_test_flag(hdev, HCI_LE_PER_ADV))
> > +       adv = hci_find_adv_instance(hdev, instance);
> > +       if (!adv || !adv->per_enabled)
> >                 return 0;
> >
> >         memset(&cp, 0, sizeof(cp));
> > @@ -1386,9 +1389,11 @@ static int hci_set_per_adv_data_sync(struct
> > hci_dev *hdev, u8 instance)  static int
> > hci_enable_per_advertising_sync(struct hci_dev *hdev, u8 instance)  {
> >         struct hci_cp_le_set_per_adv_enable cp;
> > +       struct adv_info *adv = NULL;
> >
> >         /* If periodic advertising already enabled there is nothing to do. */
> > -       if (hci_dev_test_flag(hdev, HCI_LE_PER_ADV))
> > +       adv = hci_find_adv_instance(hdev, instance);
> > +       if (adv && adv->per_enabled)
> >                 return 0;
> >
> >         memset(&cp, 0, sizeof(cp));
> > --
> > 2.34.1
> >
> 
> 
> --
> Luiz Augusto von Dentz


Regards,
Iulia
