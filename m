Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09586CDB46E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Oct 2023 15:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378304AbjJLPJ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Oct 2023 11:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343837AbjJLPJ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Oct 2023 11:09:58 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D4990
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 08:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUeuWPZ88N5oPCZuTzTBOqOFNecZBquAi57REN+Zt63BremVJi4Yp6KZ0gcdVl8OtetmFp/msLj2MbC0tTH4yRxeK+JYuLrYg9uBeiLS7n3EOeDpayrDXuCc7pJkncKnKK0fG7rWwQm7nDQG7V6x5+s1b1ZbKdWXu8tKum/rxHS89k/aMLNVJxuKHJ++STg97x0BG/ui3pkzZFiXc/xRoC/rm9u/Syssz6JpRADGepG1OgrFG1kBUIB+vptXSm2UWhu9IDNZR5LoGJuy7qXCUT0+r2xEzY4o68jbETcQWARYAIqBINAU01Opf9v3150aQCX1yRwZidtTL/ZowsYQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziQ6uETIvvzVrNh/S3a+sJlmtz3ItypKw8hEkr0CiVM=;
 b=a3tK47yMfPQSK09BRL0IRosa5nJglVC7KQt23P0Ow2zu7U8DoSpJOvADuVpXagxzcVufZyo/1/waNqetjfj9vPMQ80nCtAI2yj23aWYCx0Wf/M4+yCzjvTItWeUYsc2O0Xzpczv/YR5G6ws5/VgfoXQCf6ze0SjI2PPtXjVH/I4Ge2PYG8d6EvmMFF5FLcRfvDVEzj58r0AWN37hzEtyiAvSe3Y9XrdvSAvFx0fdUdRAsvXP/BLz58XlXVrd/0+b1ibVSdqndNiCSKVhcyLM6WEiMZZMqglhAgKTNhk1SZwO8BE5vZTM2SE5LErixARnsRFV/0zKQbNFArRKss3D1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziQ6uETIvvzVrNh/S3a+sJlmtz3ItypKw8hEkr0CiVM=;
 b=D7a0EPNA9D4hmVEsrTBhinYRT4gc5xZeG2ZppRM/YXTdCv2NjLf3Raxy1CB1JAVpFy1CLIPL/Mf1RlrWZ57Rk7btog91yC2wPXosGCEmyxtor3qB7D0nD52exqjCUHpbIKpmjtcI2XtMumpvu7V0+xXN1BVlhBSY1SHmZFZPs6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBBPR04MB7642.eurprd04.prod.outlook.com (2603:10a6:10:207::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 15:09:53 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 15:09:53 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com
Subject: Re: [PATCH 2/2] Bluetoth: ISO: Fix broadcast event handling
Date:   Thu, 12 Oct 2023 18:09:48 +0300
Message-Id: <20231012150948.2939-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZ+0NPDrLGvpB3mU9RoCqRPmCOcLc0eszws8JXGgSWB==Q@mail.gmail.com>
References: <CABBYNZ+0NPDrLGvpB3mU9RoCqRPmCOcLc0eszws8JXGgSWB==Q@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::43) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBBPR04MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba753e2-1352-451f-4eb3-08dbcb354973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzIwRHZQm+SiTBcRGsUQC94Fx07t+RD4A6FIB7aVdoIAdlEFVw9roxi65W1/lqm9UgIAN60cIs+LySKcy00QisJ+V4Q8sG/4IQxnSbOOgiz7eEyWJ7zmGJDa+J3p3VmNdOYO6rQ49PbkjDtrR1AB6kgVtSxyC1CXf5OwRa2OzuvaxlsUnGuaDJTU2GQXA06g00nDFJPsWBQZvH3LIQ5CGBsRO4FLtlHcIsUsyfU8XlSyCjSu6YHlR0U2ACbhehft1TQ3JjSnyo91TEg8Y+Bz3LvE5SRhzLFUI8JJATqXFBMKaM9LAoplBnc6+V0xZ7WKqNPz4fDhkJ3xp8XksLHghuAL4+K63F4r5UwhOHtieETDhUmgbj22hovBIDD79TbY7U0p1bswN4xnl6IhRHhq9MpjuKS/2jEOXLcigP96iwyLyWn+EFKg4E8LM/H6gDv/M7SfvhlpaDwa1sA5bSe6ZIWrr6373tZcVZYiPRLdLeVrwb+AOHvjJBeco8aqbTTlMe2dwH7SniIzUbh2Q8PObeRqhnzfUi7Moc1AnbdsT4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(36756003)(86362001)(66476007)(41300700001)(66946007)(66556008)(6916009)(38100700002)(2616005)(83380400001)(316002)(26005)(1076003)(6512007)(6666004)(6506007)(53546011)(6486002)(966005)(2906002)(478600001)(4326008)(30864003)(5660300002)(8936002)(8676002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ARXUotGFdncd86HJ5cCKlwrX8bDRqJvs/yMzN9Et18ie09YdnAsNZvU8pJKp?=
 =?us-ascii?Q?sDY+IPe34cmatcWWlo16bZSkntQMZcXoX++TpeSUDUFSK/8i7BJGm7ac7sAu?=
 =?us-ascii?Q?fVOVKqGHrNp74+yKYlpF7VGkfHhO90Z0h8eyvFhczBM/3rDX2Fimwp4xnT81?=
 =?us-ascii?Q?4LsLES+rxM2SWKPWAcUKg8IJyzVBeuFi9FbNfZ0NJCeRO/mBw+luJpONOLGD?=
 =?us-ascii?Q?AnLGKwX1REXPidBXBcbjlbFf6ePxxsmKvogLI8OrxnYlvEXrsnhXrFZVI1Bs?=
 =?us-ascii?Q?ZUn+iMjzhdP6g6Yar8R/lKUGamdL6yo1B9JbZ9m/QRhbo/hmJd3IAcDLdPUJ?=
 =?us-ascii?Q?uK7Ga9hGfApZ0R0zZdVOTRDwVQ2UzzUbfBtTmQ1ilZW/nU+WmIzCwdIfDFr/?=
 =?us-ascii?Q?fr30x915VHpYpZujUW+xcdRfKJJUr6SfDXGBxYewam9QOzyqVelkjrJTHHNl?=
 =?us-ascii?Q?3Zz+PFKeToKTwSR1SoulbrwAxljCWyIu75kHXuASSBnEGseBohkPRMblKA3M?=
 =?us-ascii?Q?Xi4pupoFzqq7DRlLtKtyyXCGAU2J9lEyRYZo7xKhClqqGvC22pkupRv2eTdN?=
 =?us-ascii?Q?EuLd920AWgZxgLaQaIHi+hHOklw5hdmNMYGExqtUfg0r607s37T7UO01OfFy?=
 =?us-ascii?Q?BU1y7P8ZcYS33nutKZ3acjdEbz+tuj8h3Le2KagJdjEGFhgpVQr1dCO8M4uY?=
 =?us-ascii?Q?I6X+hh8OM/gjO35ds/cIIoy7mkQ66QpTX+N6jezVBGH3TkkLW6fttE5cJOP0?=
 =?us-ascii?Q?/civVghQYU4AS+tRhKZqcBCelE08DWbhm/4pAaGkcNbZyvHUVPIZq17aWREr?=
 =?us-ascii?Q?dlDcDftGkAmXpAZgF/lBuQdbBaeje9+0bqtuUTyNSrzRpQxz/SomPxmZEIDB?=
 =?us-ascii?Q?jYTruKZEZyqO2j6EFtOhkQ4/b7GJZ/BmD1Qtow0SKHX/p7tqmCB4IUfd/pRw?=
 =?us-ascii?Q?X6R3S+xdsLfcyaXc1y+pJaulsilK9mOuzNQX4UHIrvsUI7KPmroXly7BWOb8?=
 =?us-ascii?Q?bV+brm3qMdhO7r1EUbYeVseLM052qGhfclJqYFaSP7aZLZlJoCuAaHOQwrZO?=
 =?us-ascii?Q?ddRvIgmM5PHtTfgoiIBLRR2A91jtryfIFtuNH19f3n7wGcNrUq7dit0LCx6K?=
 =?us-ascii?Q?RDnn/Z1O4Qd6dqdzK8WYzwaN5Ozbn6aiu3h9XaGew3nYsKLyIQqLF/ih66am?=
 =?us-ascii?Q?cVa/p0kproa6z8fxKNcklaM17VPI8gZTuEsMu3rcF73mc6VCz6g0PnnHvS0e?=
 =?us-ascii?Q?c/+9gL4UWEwYyGkGN5VMxQFK85kMzgK4/FUsGMhu9ZE8PtbSpHM8lDHcxg/0?=
 =?us-ascii?Q?HtJDMOt8pxoF/U/VgUYUVfNDH84RkwUboFrPm8swaGXnZ+qyFAp9MZv3q1ZR?=
 =?us-ascii?Q?qpJtLXODUB+HI4Fm3zzjc/7NvFtIf6W2f+q8RNZcWY+PLwu6Xyk3YjGiTwGE?=
 =?us-ascii?Q?VHhk6DrhoFC8PZSRU8uJSEPlbWMx3hK6pRYzBWGPDdaVdzTXta740/yY0k9e?=
 =?us-ascii?Q?p5gT3kZRlmpIHrBcFghPc7zHEe+nu04GVH70F5hbZHezRjSbQnTISV3j7VVv?=
 =?us-ascii?Q?H772h6fGummfdTF/0ASGDQ82JhN+raQZBsUn+B7UOGdF0LIawGoGLEWisqbz?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba753e2-1352-451f-4eb3-08dbcb354973
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 15:09:53.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHtgKuvDf0PjU3LGMFHID5hJ3xdpecTwK5Jqd5wX8ZWaG6QzVK1sDIcEYMcvfjzuM03kVf6MD97GCtfj3ujh2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7642
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Wednesday, October 11, 2023 11:08 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH 2/2] Bluetoth: ISO: Fix broadcast event handling
> 
> Hi Iulia,
> 
> On Wed, Oct 11, 2023 at 7:24 AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > This fixes the way broadcast events are handled by the ISO layer:
> > A new slave BIS hcon is notified after the Command Complete for
> > LE Setup ISO Data Path is received, not after BIG Sync Established.
> >
> > The iso_match_pa_sync_flag function has been replaced with more
> > specific matching functions, depending on the event being handled.
> >
> > Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > ---
> >  include/net/bluetooth/hci_core.h |   3 +-
> >  net/bluetooth/hci_core.c         |  50 ++++++++++-----
> >  net/bluetooth/iso.c              | 101 +++++++++++++++++++++++++------
> >  3 files changed, 119 insertions(+), 35 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h
> b/include/net/bluetooth/hci_core.h
> > index 99865c23e461..a85c47abd88d 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -2127,7 +2127,8 @@ void hci_send_sco(struct hci_conn *conn, struct
> sk_buff *skb);
> >  void hci_send_iso(struct hci_conn *conn, struct sk_buff *skb);
> >
> >  void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
> > -void *hci_recv_event_data(struct hci_dev *hdev, __u8 event);
> > +void *hci_le_meta_evt_data(struct hci_dev *hdev, __u8 subevent);
> > +void *hci_cmd_complete_data(struct hci_dev *hdev, __u16 opcode);
> >
> >  u32 hci_conn_get_phy(struct hci_conn *conn);
> >
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 195aea2198a9..5ccc6ef1b66b 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -3120,10 +3120,11 @@ void *hci_sent_cmd_data(struct hci_dev
> *hdev, __u16 opcode)
> >         return hdev->sent_cmd->data + HCI_COMMAND_HDR_SIZE;
> >  }
> >
> > -/* Get data from last received event */
> > -void *hci_recv_event_data(struct hci_dev *hdev, __u8 event)
> > +/* Get data from last received LE Meta event */
> > +void *hci_le_meta_evt_data(struct hci_dev *hdev, __u8 subevent)
> >  {
> >         struct hci_event_hdr *hdr;
> > +       struct hci_ev_le_meta *ev;
> >         int offset;
> >
> >         if (!hdev->recv_event)
> > @@ -3132,21 +3133,42 @@ void *hci_recv_event_data(struct hci_dev
> *hdev, __u8 event)
> >         hdr = (void *)hdev->recv_event->data;
> >         offset = sizeof(*hdr);
> >
> > -       if (hdr->evt != event) {
> > -               /* In case of LE metaevent check the subevent match */
> > -               if (hdr->evt == HCI_EV_LE_META) {
> > -                       struct hci_ev_le_meta *ev;
> > +       if (hdr->evt != HCI_EV_LE_META)
> > +               return NULL;
> >
> > -                       ev = (void *)hdev->recv_event->data + offset;
> > -                       offset += sizeof(*ev);
> > -                       if (ev->subevent == event)
> > -                               goto found;
> > -               }
> > +       ev = (void *)hdev->recv_event->data + offset;
> > +       offset += sizeof(*ev);
> > +       if (ev->subevent != subevent)
> > +               return NULL;
> > +
> > +       bt_dev_dbg(hdev, "subevent 0x%2.2x", subevent);
> > +
> > +       return hdev->recv_event->data + offset;
> > +}
> > +
> > +/* Get data from last received Command Complete event */
> > +void *hci_cmd_complete_data(struct hci_dev *hdev, __u16 opcode)
> > +{
> > +       struct hci_event_hdr *hdr;
> > +       struct hci_ev_cmd_complete *ev;
> > +       int offset;
> > +
> > +       if (!hdev->recv_event)
> > +               return NULL;
> > +
> > +       hdr = (void *)hdev->recv_event->data;
> > +       offset = sizeof(*hdr);
> > +
> > +       if (hdr->evt != HCI_EV_CMD_COMPLETE)
> > +               return NULL;
> > +
> > +       ev = (void *)hdev->recv_event->data + offset;
> > +       offset += sizeof(*ev);
> > +
> > +       if (__le16_to_cpu(ev->opcode) != opcode)
> >                 return NULL;
> > -       }
> >
> > -found:
> > -       bt_dev_dbg(hdev, "event 0x%2.2x", event);
> > +       bt_dev_dbg(hdev, "command complete event for 0x%4.4x", opcode);
> >
> >         return hdev->recv_event->data + offset;
> >  }
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 8ab7ea5ebedf..76c186f951d1 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -1560,6 +1560,16 @@ struct iso_list_data {
> >         int count;
> >  };
> >
> > +static bool iso_match_big_flag(struct sock *sk, void *data)
> > +{
> > +       struct hci_evt_le_big_sync_estabilished *ev = data;
> > +
> > +       if (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
> > +               return false;
> > +
> > +       return ev->handle == iso_pi(sk)->qos.bcast.big;
> > +}
> > +
> >  static bool iso_match_big(struct sock *sk, void *data)
> >  {
> >         struct hci_evt_le_big_sync_estabilished *ev = data;
> > @@ -1567,15 +1577,28 @@ static bool iso_match_big(struct sock *sk, void
> *data)
> >         return ev->handle == iso_pi(sk)->qos.bcast.big;
> >  }
> >
> > -static bool iso_match_pa_sync_flag(struct sock *sk, void *data)
> > +static bool iso_match_conn_big_flag(struct sock *sk, void *data)
> > +{
> > +       struct hci_conn *hcon = data;
> > +
> > +       if (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
> > +               return false;
> > +
> > +       return hcon->iso_qos.bcast.big == iso_pi(sk)->qos.bcast.big;
> > +}
> > +
> > +static bool iso_match_conn_big(struct sock *sk, void *data)
> >  {
> > -       return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
> > +       struct hci_conn *hcon = data;
> > +
> > +       return hcon->iso_qos.bcast.big == iso_pi(sk)->qos.bcast.big;
> >  }
> >
> >  static void iso_conn_ready(struct iso_conn *conn)
> >  {
> >         struct sock *parent = NULL;
> >         struct sock *sk = conn->sk;
> > +       struct hci_rp_le_setup_iso_path *rp = NULL;
> >         struct hci_ev_le_big_sync_estabilished *ev = NULL;
> >         struct hci_ev_le_pa_sync_established *ev2 = NULL;
> >         struct hci_evt_le_big_info_adv_report *ev3 = NULL;
> > @@ -1590,29 +1613,56 @@ static void iso_conn_ready(struct iso_conn
> *conn)
> >                 if (!hcon)
> >                         return;
> >
> > -               if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags) ||
> > -                   test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
> > -                       ev = hci_recv_event_data(hcon->hdev,
> > -                                                HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
> > +               if (test_bit(HCI_CONN_BIG_SYNC, &hcon->flags)) {
> > +                       rp = hci_cmd_complete_data(hcon->hdev,
> > +                                                  HCI_OP_LE_SETUP_ISO_PATH);
> >
> > -                       /* Get reference to PA sync parent socket, if it exists */
> > -                       parent = iso_get_sock_listen(&hcon->src,
> > -                                                    &hcon->dst,
> > -                                                    iso_match_pa_sync_flag, NULL);
> > -                       if (!parent && ev)
> > +                       if (rp) {
> > +                               /* If defer setup was used to listen for this
> > +                                * event, get reference to the socket marked
> > +                                * with the BT_SK_PA_SYNC flag.
> > +                                */
> >                                 parent = iso_get_sock_listen(&hcon->src,
> >                                                              &hcon->dst,
> > -                                                            iso_match_big, ev);
> > +                                                            iso_match_conn_big_flag,
> > +                                                            hcon);
> > +
> > +                               if (!parent)
> > +                                       parent = iso_get_sock_listen(&hcon->src,
> > +                                                                    &hcon->dst,
> > +                                                                    iso_match_conn_big,
> > +                                                                    hcon);
> > +                       }
> > +               } else if (test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
> > +                       ev = hci_le_meta_evt_data(hcon->hdev,
> > +                                                 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
> > +
> > +                       if (ev) {
> > +                               /* If defer setup was used to listen for this
> > +                                * event, get reference to the socket marked
> > +                                * with the BT_SK_PA_SYNC flag.
> > +                                */
> > +                               parent = iso_get_sock_listen(&hcon->src,
> > +                                                            &hcon->dst,
> > +                                                            iso_match_big_flag,
> > +                                                            ev);
> > +
> > +                               if (!parent)
> > +                                       parent = iso_get_sock_listen(&hcon->src,
> > +                                                                    &hcon->dst,
> > +                                                                    iso_match_big,
> > +                                                                    ev);
> > +                       }
> >                 } else if (test_bit(HCI_CONN_PA_SYNC_FAILED, &hcon->flags)) {
> > -                       ev2 = hci_recv_event_data(hcon->hdev,
> > -                                                 HCI_EV_LE_PA_SYNC_ESTABLISHED);
> > +                       ev2 = hci_le_meta_evt_data(hcon->hdev,
> > +                                                  HCI_EV_LE_PA_SYNC_ESTABLISHED);
> >                         if (ev2)
> >                                 parent = iso_get_sock_listen(&hcon->src,
> >                                                              &hcon->dst,
> >                                                              iso_match_sid, ev2);
> >                 } else if (test_bit(HCI_CONN_PA_SYNC, &hcon->flags)) {
> > -                       ev3 = hci_recv_event_data(hcon->hdev,
> > -                                                 HCI_EVT_LE_BIG_INFO_ADV_REPORT);
> > +                       ev3 = hci_le_meta_evt_data(hcon->hdev,
> > +                                                  HCI_EVT_LE_BIG_INFO_ADV_REPORT);
> >                         if (ev3)
> >                                 parent = iso_get_sock_listen(&hcon->src,
> >                                                              &hcon->dst,
> 
> I really regret putting the handling of HCI in iso.c, it doesn't seem
> to be the right place to be processing HCI traffic and should be left
> to just handle socket related operations. The main problem with
> broadcast is that it requires multiples commands to setup but it
> should be possible to enclosure that into a cmd_sync function that
> properly serializes everything, we may need to do some cleanups first
> since he have been running cmd_sync callbacks in different files when
> that shall always be done hci_sync.c to make it simpler to reuse, then
> we can probably inline the sending of HCI_OP_LE_SETUP_ISO_PATH, etc,
> so we don't have to keep process them asynchronously via hci_event.c.

In iso_conn_ready HCI events are processed just to create child socket
and match with parent. Different events generate different socket types:
HCI_OP_LE_SETUP_ISO_PATH creates a BIS socket,
HCI_EVT_LE_BIG_INFO_ADV_REPORT creates a PA sync socket etc.

So the ISO layer needs to create new sockets and enqueue for accept
depending on event. I don't think this part can be moved somewhere else,
because it's related to socket handling.

The HCI state machine for setup is already enclosed in cmd_sync
functions, like hci_pa_create_sync:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_conn.c#n2149

> 
> > @@ -1700,6 +1750,16 @@ static bool iso_match_sid(struct sock *sk, void
> *data)
> >         return ev->sid == iso_pi(sk)->bc_sid;
> >  }
> >
> > +static bool iso_match_sync_handle_flag(struct sock *sk, void *data)
> > +{
> > +       struct hci_evt_le_big_info_adv_report *ev = data;
> > +
> > +       if (!test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags))
> > +               return false;
> > +
> > +       return le16_to_cpu(ev->sync_handle) == iso_pi(sk)->sync_handle;
> > +}
> > +
> >  static bool iso_match_sync_handle(struct sock *sk, void *data)
> >  {
> >         struct hci_evt_le_big_info_adv_report *ev = data;
> > @@ -1740,7 +1800,7 @@ int iso_connect_ind(struct hci_dev *hdev,
> bdaddr_t *bdaddr, __u8 *flags)
> >          * in iso_pi(sk)->base so it can be passed up to user, in the case of a
> >          * broadcast sink.
> >          */
> > -       ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
> > +       ev1 = hci_le_meta_evt_data(hdev,
> HCI_EV_LE_PA_SYNC_ESTABLISHED);
> >         if (ev1) {
> >                 sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr, iso_match_sid,
> >                                          ev1);
> > @@ -1750,11 +1810,12 @@ int iso_connect_ind(struct hci_dev *hdev,
> bdaddr_t *bdaddr, __u8 *flags)
> >                 goto done;
> >         }
> >
> > -       ev2 = hci_recv_event_data(hdev,
> HCI_EVT_LE_BIG_INFO_ADV_REPORT);
> > +       ev2 = hci_le_meta_evt_data(hdev,
> HCI_EVT_LE_BIG_INFO_ADV_REPORT);
> >         if (ev2) {
> >                 /* Try to get PA sync listening socket, if it exists */
> >                 sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
> > -                                               iso_match_pa_sync_flag, NULL);
> > +                                               iso_match_sync_handle_flag,
> > +                                               ev2);
> >                 if (!sk)
> >                         sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
> >                                                  iso_match_sync_handle, ev2);
> > @@ -1780,7 +1841,7 @@ int iso_connect_ind(struct hci_dev *hdev,
> bdaddr_t *bdaddr, __u8 *flags)
> >                 }
> >         }
> >
> > -       ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
> > +       ev3 = hci_le_meta_evt_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
> >         if (ev3) {
> >                 sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
> >                                          iso_match_sync_handle_pa_report, ev3);
> > --
> > 2.39.2
> >
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Iulia

