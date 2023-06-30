Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E3CEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 15:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbjF3Pa3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 11:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbjF3PaJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 11:30:09 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062e.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1725245
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 08:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6z/MT7ROs7zaB/vDQbBBXkd0FEvechfP/A7qjpsI6l6dNmLqWPY0coZmDc/0A/S0Ka5/CqPYvkCjEN0zfYDiPCFxFnNLRipQFdysOZr8lY56ZQ+TLo5yz8NtwwMbUCMg9h+8egGgs+JDO5zX4lgEV6xCqmOMghnC2U6EWdTnWP2bgorEDcI7svBfVAliFsEew891AvO+OfLX6N81fVHgAjLvBPzsrKmMXJEk6ESKMJmhr8/AfYvaZSKXlrhjvBKQ+XxcFxBbQwUVGxC71+qXhxFHEB+yTw9fuqI7o0h/TXuBqoqUD/sOmQIyC27rc41O4yM42gS/1GrhC+GkZ0e6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/X7fPPrW5NSamPDBRyY984vki+C+ZLUp/h7mFxKtOI=;
 b=i1/WXSmRwj4y7qe2v5BaT8d+RvYaR0dxmv+OFjB+5iOpby+CG0rW0ZaTd+uGFtMZT3pM2/qNPUb0dxBEDeUOhAdGUhtKQgbT8t6og62ITI7J4sHTjxoahvsbwRgTx89QEWj6GSlSeCC96nmYFK2313LNluLgyl0h6Zc52vkXvaXvmIVGVKg3SApMV8N3faXjqldlQxHJD+bo0xUY8ZVa/SZFBgZqk5O7nwgwMTGqkc+o99k2HhRX6IfbF8ZpL7v4xwa1SMMmWbdoRWn/j99Br1UfAdEYK+0sIoLOpBE8hG7GtIfwmo+ET2jtcmm/SFuQtc9vN5r4MiEq8FtFUCum0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/X7fPPrW5NSamPDBRyY984vki+C+ZLUp/h7mFxKtOI=;
 b=d/AHDagLeLwyR7JZQYpUyUlbWU5PEBoEb6xVSbkUaKpYcpm7B9hZHv+okbKr5Whwa8Aw/3eCH4grb2+gXC/y2u/JHRjf1PSD7p8YWtJM9PavMcfY3BM8I/zkKMnaGc1y9k7LZeszGcR8oYKd6B4UMUSAIH9ILU+ZtS3lUCaGTYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM9PR04MB8306.eurprd04.prod.outlook.com (2603:10a6:20b:3e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 15:27:40 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 15:27:40 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com
Subject: Re: [PATCH v2 1/1] Bluetooth: ISO: Notify user space about failed bis connections
Date:   Fri, 30 Jun 2023 18:27:23 +0300
Message-Id: <20230630152723.302429-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZJY2Ht9b41dzGm1J0L+2XH=Jzf0a7hg50HsbTxrN4nDHg@mail.gmail.com>
References: <CABBYNZJY2Ht9b41dzGm1J0L+2XH=Jzf0a7hg50HsbTxrN4nDHg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0084.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM9PR04MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: d6bc2165-361a-419c-3f23-08db797e8ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b9dDmzy3IFEtX5OSod2zmTjKKHNHIgCrO4PsQHRuPpT9y4N9RvI2VdgKoGkVX8iMks7vjUrugpqmw+jmDQLR+LQMFTRLCQxWaVRr2N5Bpuk2sXtQ7eXT+889/wjc1fL3+YN0tvfg3/QtOheguxTrrIVdTmqHaKYvORgLrFugLCeslZCKwj8lNPAtWw4EM9A5LPkJjWRSdJ1EnIHJ9mefSlIDu9/FALgNkDGZN43t2ISyT79MwP83iv6sgf4jzwCv6DDG92T1fTLZ5GR5RCkcZbrSqrJ/mii8oDsX18oS/k/oGf3TucgYPIfP+46YH7aVoOnBYHPBu0BrBTSL00TcBwRHE39exW44FVNeopxQet9zomv9JrgIo6m3JUtLD3SDtHI1vFZK1Y7yYgey1OKjQu2DmAmSyDNvBh/enuKnpm0d5rme1Tl4fxhDFAdzHOISxe0CmeW71G6rQYiW+uYqY/B+S3LsJo47qNGfuVZzYFU3k0n50ynWvbAxAyDfeXezjo7BOOm7sntzdFZQO+FwgJJ90tKjByU84KfwfQvOpiJ8VlsHL0lJIacbJrFNddYO1mPk71HQ3XZ7lJRfR3ponjwTxyHsLZNsJVhlVnOWbH+IDjvTIVhPTUNo8UpsCcr/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(366004)(136003)(39860400002)(451199021)(86362001)(8936002)(8676002)(5660300002)(26005)(6506007)(1076003)(44832011)(55236004)(53546011)(6486002)(52116002)(478600001)(66946007)(66556008)(66476007)(6916009)(4326008)(6512007)(41300700001)(316002)(6666004)(186003)(2616005)(2906002)(83380400001)(30864003)(36756003)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XHjUT7UD7RT1ajAAU85feY7Ll7lXLNaBt3QPFDz2UIXmf7i6h966hJLfGZLZ?=
 =?us-ascii?Q?s/xbsDdMMx3IBLPkN2wBB/vH6oaKqWUQuoAsZaUO5raF/DwfB5ojqVr2y2vt?=
 =?us-ascii?Q?b6MxJEDC3mlrHSM573gz0ahwDvDA0Y2u4IGdakg1F+87Y6FBPZANJ93gnnLs?=
 =?us-ascii?Q?5nnbj+Gx/qGzvK9zgpYaSddMba5lsB+FKjjdXgWipvj6bswBMf3Fvx5pz+07?=
 =?us-ascii?Q?k3ugez3UotAYziBUcyEsgm38K6E/bKXfwkAtC9bVv1FbjnbCshLkmme5nt0j?=
 =?us-ascii?Q?Boh9G43kgSPwAZI8wWlhIV6y5YeZQifNbU7l9AcuSuynqoZT1W8k/lYbtSG0?=
 =?us-ascii?Q?/SVRZ04qqYOuWWr+d4mXiQ/CVDXjxqwIhuWWsCKsCydl8i1GYyKKNKY3yAHp?=
 =?us-ascii?Q?G+okaLqfkw0rb1yay+aFw8cEhcJgG5qmy8ifu1BYbhrf8rgf84BlooWHhc6s?=
 =?us-ascii?Q?kxho1N3fCgHS6OmBILaoWDUVcmF2z7trUXX+QmJVwmWvLUNbfZ1+WJErjzfA?=
 =?us-ascii?Q?TF1i6yx55GrQOB7dTFL4+ZcsONZgXOCsIYUmo5U0y6gAyN59gLM9pgpCMvuR?=
 =?us-ascii?Q?nDQZlJpDEri/4YBxEuwTp9Yr8L8eSk6ZyoISjaluqlS/chx7FFCTN9rKMITC?=
 =?us-ascii?Q?gLOoe+FVsfDz3LiDMfzIRLcFjDEu54s1kUTJOoy2MVb3fqZDBszsDnQ5vVKq?=
 =?us-ascii?Q?NmBc7AvlI0c0qUqXE0yokwJo5NzNcdWkDKRIPcUw/rZSHyt9X88RSupsFyoR?=
 =?us-ascii?Q?kxl42oZ9k6aR/bCgwwr20pmxLBDJT1CXqmGm+tYY2wMrH9tm4aQC8VvB8N/H?=
 =?us-ascii?Q?Y/i8CMCrSIr2yGW+m76ncvYmVf19nzBBz/unLpfw/uNW+U7RImZn0lDFWyzl?=
 =?us-ascii?Q?CMgK7i3Sz2mjQpkeNQLDbXMiNxdxL7tPPGFDqrbfjTcQGHFb96CCN5VM33WG?=
 =?us-ascii?Q?5zu+dmPxvKDXv+9r0MVaTGgBrMazM23iz9v38uvFmXgBYBjnNNcliDm2ExBB?=
 =?us-ascii?Q?3Ow+llsAfvigSqgvT85GXbFiGzGjY6z5GMl7LNCggBOQuNE5FW7PcLuQeF1z?=
 =?us-ascii?Q?3NqnLqwy6MNKo1C+LdVwrOMdT+XWytYvITtGEZ7D++c5e9t0hHIAUaQ13fkE?=
 =?us-ascii?Q?WBvsMwR1/7+5SIHer5lUIHMzFNinW6b4HQOiU9W/V22EqQT8XSdPefBj/wvX?=
 =?us-ascii?Q?YzftE0rL2iFSs/bwJtvpmV1lQ7d+56BH/ceBPEEdXvCWz8KYFB9kUUVeNEz5?=
 =?us-ascii?Q?5z228k4xZJvhUx/MQIQLjf7vSO1xsGhm2nWCSOW5zr2P/8FZH41IfA0EiMAS?=
 =?us-ascii?Q?13UUr3+ttgyWjIq8vbsfobg0S7AHqtYgG/2oto8+sNll7JYOtHQ1AKifYjvk?=
 =?us-ascii?Q?pDhcjlqLHOGqoNmvNRStNw29bG+Y69O9Z0JxjTGp8GQll67aq4wJZonFuKAS?=
 =?us-ascii?Q?Wtu6ZG/8n18PgN6rgzzckXEBwPLqx9JVWw2ID8ZtFXj3cn2SPGuJ56B0Toe9?=
 =?us-ascii?Q?oDPu0gtDl8Veaem6agxYM8vb/CivwBr1Ihtd1s4c888eVpkszBgCrmM9n/UA?=
 =?us-ascii?Q?NglhkNbHCGreTg1vpIcBoarwiy+Fx8eoDNSRgz0GneEi9m/q12FeSUZRnqn0?=
 =?us-ascii?Q?ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6bc2165-361a-419c-3f23-08db797e8ac2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:27:40.5774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NRNIrDjcWtBqyXJppgDXh3Gh+ucRFylR9q709HEJfvJpVmKCl7WkVBBcbw13rmzneMz1L8a30lrN5VRxObgZTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8306
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Thursday, June 29, 2023 9:58 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH v2 1/1] Bluetooth: ISO: Notify user space about
> failed bis connections
> 
> Hi Iulia,
> 
> On Wed, Jun 28, 2023 at 8:06 AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > Some use cases require the user to be informed if BIG synchronization
> > fails. This commit makes it so that even if the BIG sync established
> > event arrives with error status, a new hconn is added for each BIS,
> > and the iso layer is notified about the failed connections.
> >
> > Unsuccesful bis connections will be marked using the
> > HCI_CONN_BIG_SYNC_FAILED flag. From the iso layer, the POLLERR event
> > is triggered on the newly allocated bis sockets, before adding them to
> > the accept list of the parent socket.
> >
> > From user space, a new fd for each failed bis connection will be
> > obtained by calling accept. The user should check for the POLLERR
> > event on the new socket, to determine if the connection was successful
> > or not.
> >
> > The HCI_CONN_BIG_SYNC flag has been added to mark whether the BIG
> sync
> > has been successfully established. This flag is checked at bis
> > cleanup, so the HCI LE BIG Terminate Sync command is only issued if
> needed.
> >
> > The BT_SK_BIG_SYNC flag indicates if BIG create sync has been called
> > for a listening socket, to avoid issuing the command everytime a
> > BIGInfo advertising report is received.
> >
> > Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > ---
> >  include/net/bluetooth/hci_core.h | 25 ++++++++++++++++
> >  net/bluetooth/hci_conn.c         | 50 +++++++++++++++++---------------
> >  net/bluetooth/hci_event.c        | 21 +++++++++++---
> >  net/bluetooth/iso.c              | 37 ++++++++++++++++-------
> >  4 files changed, 95 insertions(+), 38 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > index 05a9b3ab3f56..f068a578ff59 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -978,6 +978,8 @@ enum {
> >         HCI_CONN_PER_ADV,
> >         HCI_CONN_BIG_CREATED,
> >         HCI_CONN_CREATE_CIS,
> > +       HCI_CONN_BIG_SYNC,
> > +       HCI_CONN_BIG_SYNC_FAILED,
> >  };
> >
> >  static inline bool hci_conn_ssp_enabled(struct hci_conn *conn) @@
> > -1288,6 +1290,29 @@ static inline struct hci_conn
> *hci_conn_hash_lookup_big(struct hci_dev *hdev,
> >         return NULL;
> >  }
> >
> > +static inline struct hci_conn *hci_conn_hash_lookup_big_any_dst(struct
> hci_dev *hdev,
> > +                                                       __u8 handle) {
> > +       struct hci_conn_hash *h = &hdev->conn_hash;
> > +       struct hci_conn  *c;
> > +
> > +       rcu_read_lock();
> > +
> > +       list_for_each_entry_rcu(c, &h->list, list) {
> > +               if (c->type != ISO_LINK)
> > +                       continue;
> > +
> > +               if (handle == c->iso_qos.bcast.big) {
> > +                       rcu_read_unlock();
> > +                       return c;
> > +               }
> > +       }
> > +
> > +       rcu_read_unlock();
> > +
> > +       return NULL;
> > +}
> > +
> >  static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev
> *hdev,
> >                                                         __u8 type,
> > __u16 state)  { diff --git a/net/bluetooth/hci_conn.c
> > b/net/bluetooth/hci_conn.c index 47e7aa4d63a9..491ca8e876f0 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -686,6 +686,19 @@ static void hci_conn_timeout(struct work_struct
> *work)
> >                 return;
> >         }
> >
> > +       /* Cleanup bises that failed to be established */
> > +       if (test_and_clear_bit(HCI_CONN_BIG_SYNC_FAILED, &conn->flags)) {
> > +               conn->state = BT_CLOSED;
> > +               hci_disconn_cfm(conn, hci_proto_disconn_ind(conn));
> > +               hci_conn_hash_del(conn->hdev, conn);
> > +
> > +               if (conn->cleanup)
> > +                       conn->cleanup(conn);
> > +
> > +               hci_conn_put(conn);
> > +               return;
> > +       }
> 
> I will be pushing some changes to how hci_abort_conn works, the code
> above shall probably be done inside the likes of hci_conn_failed though but
> first we need to add support for BIS into hci_abort_conn_sync.

Thank you, I submitted a new patch version with these updates.

> 
> >         hci_abort_conn(conn, hci_proto_disconn_ind(conn));  }
> >
> > @@ -793,6 +806,7 @@ struct iso_list_data {
> >         int count;
> >         struct iso_cig_params pdu;
> >         bool big_term;
> > +       bool big_sync_term;
> >  };
> >
> >  static void bis_list(struct hci_conn *conn, void *data) @@ -810,17
> > +824,6 @@ static void bis_list(struct hci_conn *conn, void *data)
> >         d->count++;
> >  }
> >
> > -static void find_bis(struct hci_conn *conn, void *data) -{
> > -       struct iso_list_data *d = data;
> > -
> > -       /* Ignore unicast */
> > -       if (bacmp(&conn->dst, BDADDR_ANY))
> > -               return;
> > -
> > -       d->count++;
> > -}
> > -
> >  static int terminate_big_sync(struct hci_dev *hdev, void *data)  {
> >         struct iso_list_data *d = data; @@ -873,31 +876,26 @@ static
> > int big_terminate_sync(struct hci_dev *hdev, void *data)
> >         bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", d->big,
> >                    d->sync_handle);
> >
> > -       /* Check if ISO connection is a BIS and terminate BIG if there are
> > -        * no other connections using it.
> > -        */
> > -       hci_conn_hash_list_state(hdev, find_bis, ISO_LINK, BT_CONNECTED,
> d);
> > -       if (d->count)
> > -               return 0;
> > -
> > -       hci_le_big_terminate_sync(hdev, d->big);
> > +       if (d->big_sync_term)
> > +               hci_le_big_terminate_sync(hdev, d->big);
> >
> >         return hci_le_pa_terminate_sync(hdev, d->sync_handle);  }
> >
> > -static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, u16
> > sync_handle)
> > +static int hci_le_big_terminate(struct hci_dev *hdev, u8 big, struct
> > +hci_conn *conn)
> >  {
> >         struct iso_list_data *d;
> >         int ret;
> >
> > -       bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big,
> sync_handle);
> > +       bt_dev_dbg(hdev, "big 0x%2.2x sync_handle 0x%4.4x", big,
> > + conn->sync_handle);
> >
> >         d = kzalloc(sizeof(*d), GFP_KERNEL);
> >         if (!d)
> >                 return -ENOMEM;
> >
> >         d->big = big;
> > -       d->sync_handle = sync_handle;
> > +       d->sync_handle = conn->sync_handle;
> > +       d->big_sync_term = test_and_clear_bit(HCI_CONN_BIG_SYNC,
> > + &conn->flags);
> >
> >         ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
> >                                  terminate_big_destroy); @@ -933,8
> > +931,14 @@ static void bis_cleanup(struct hci_conn *conn)
> >
> >                 hci_le_terminate_big(hdev, conn);
> >         } else {
> > +               bis = hci_conn_hash_lookup_big_any_dst(hdev,
> > +
> > + conn->iso_qos.bcast.big);
> > +
> > +               if (bis)
> > +                       return;
> > +
> >                 hci_le_big_terminate(hdev, conn->iso_qos.bcast.big,
> > -                                    conn->sync_handle);
> > +                                    conn);
> >         }
> >  }
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 77cbf13037b3..30d0a6631e17 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -7039,9 +7039,6 @@ static void
> hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
> >                                 flex_array_size(ev, bis, ev->num_bis)))
> >                 return;
> >
> > -       if (ev->status)
> > -               return;
> > -
> >         hci_dev_lock(hdev);
> >
> >         for (i = 0; i < ev->num_bis; i++) { @@ -7065,9 +7062,25 @@
> > static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void
> *data,
> >                 bis->iso_qos.bcast.in.latency = le16_to_cpu(ev->interval) * 125 /
> 100;
> >                 bis->iso_qos.bcast.in.sdu = le16_to_cpu(ev->max_pdu);
> >
> > -               hci_iso_setup_path(bis);
> > +               if (!ev->status) {
> > +                       set_bit(HCI_CONN_BIG_SYNC, &bis->flags);
> > +                       hci_iso_setup_path(bis);
> > +               }
> >         }
> >
> > +       /* In case BIG sync failed, notify each failed connection to
> > +        * the user after all hci connections have been added
> > +        */
> > +       if (ev->status)
> > +               for (i = 0; i < ev->num_bis; i++) {
> > +                       u16 handle = le16_to_cpu(ev->bis[i]);
> > +
> > +                       bis = hci_conn_hash_lookup_handle(hdev,
> > + handle);
> > +
> > +                       set_bit(HCI_CONN_BIG_SYNC_FAILED, &bis->flags);
> > +                       hci_connect_cfm(bis, ev->status);
> > +               }
> > +
> >         hci_dev_unlock(hdev);
> >  }
> >
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c index
> > 84d238d0639a..e0386b12ea4e 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -48,6 +48,11 @@ static void iso_sock_kill(struct sock *sk);
> > #define EIR_SERVICE_DATA_LENGTH 4  #define BASE_MAX_LENGTH
> > (HCI_MAX_PER_AD_LENGTH - EIR_SERVICE_DATA_LENGTH)
> >
> > +/* iso_pinfo flags values */
> > +enum {
> > +       BT_SK_BIG_SYNC,
> > +};
> > +
> >  struct iso_pinfo {
> >         struct bt_sock          bt;
> >         bdaddr_t                src;
> > @@ -58,7 +63,7 @@ struct iso_pinfo {
> >         __u8                    bc_num_bis;
> >         __u8                    bc_bis[ISO_MAX_NUM_BIS];
> >         __u16                   sync_handle;
> > -       __u32                   flags;
> > +       unsigned long           flags;
> >         struct bt_iso_qos       qos;
> >         bool                    qos_user_set;
> >         __u8                    base_len;
> > @@ -1569,6 +1574,12 @@ static void iso_conn_ready(struct iso_conn
> *conn)
> >                 hci_conn_hold(hcon);
> >                 iso_chan_add(conn, sk, parent);
> >
> > +               if (ev && ((struct hci_evt_le_big_sync_estabilished *)ev)->status)
> {
> > +                       /* Trigger error signal on child socket */
> > +                       sk->sk_err = ECONNREFUSED;
> > +                       sk->sk_error_report(sk);
> > +               }
> > +
> >                 if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(parent)->flags))
> >                         sk->sk_state = BT_CONNECT2;
> >                 else
> > @@ -1637,15 +1648,19 @@ int iso_connect_ind(struct hci_dev *hdev,
> bdaddr_t *bdaddr, __u8 *flags)
> >                         if (ev2->num_bis < iso_pi(sk)->bc_num_bis)
> >                                 iso_pi(sk)->bc_num_bis = ev2->num_bis;
> >
> > -                       err = hci_le_big_create_sync(hdev,
> > -                                                    &iso_pi(sk)->qos,
> > -                                                    iso_pi(sk)->sync_handle,
> > -                                                    iso_pi(sk)->bc_num_bis,
> > -                                                    iso_pi(sk)->bc_bis);
> > -                       if (err) {
> > -                               bt_dev_err(hdev, "hci_le_big_create_sync: %d",
> > -                                          err);
> > -                               sk = NULL;
> > +                       if (!test_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
> > +                               set_bit(BT_SK_BIG_SYNC,
> > + &iso_pi(sk)->flags);
> 
> You can probably use test_and_set_bit instead above.

I updated this as well.

> 
> > +
> > +                               err = hci_le_big_create_sync(hdev,
> > +                                                            &iso_pi(sk)->qos,
> > +                                                            iso_pi(sk)->sync_handle,
> > +                                                            iso_pi(sk)->bc_num_bis,
> > +                                                            iso_pi(sk)->bc_bis);
> > +                               if (err) {
> > +                                       bt_dev_err(hdev, "hci_le_big_create_sync: %d",
> > +                                                  err);
> > +                                       sk = NULL;
> > +                               }
> >                         }
> >                 }
> >         } else {
> > @@ -1688,7 +1703,7 @@ static void iso_connect_cfm(struct hci_conn
> > *hcon, __u8 status)
> >
> >         BT_DBG("hcon %p bdaddr %pMR status %d", hcon, &hcon->dst,
> > status);
> >
> > -       if (!status) {
> > +       if (!status || test_bit(HCI_CONN_BIG_SYNC_FAILED,
> > + &hcon->flags)) {
> 
> Shouldn't it be !test_bit above?

Here, if HCI_CONN_BIG_SYNC_FAILED is set, I want to reach iso_conn_ready,
like it would be for the success case, so the failed bis connection will
be added in the accept queue of the listening socket and it will be woken
up in userspace, so the check should be positive.

> 
> >                 struct iso_conn *conn;
> >
> >                 conn = iso_conn_add(hcon);
> > --
> > 2.34.1
> >
> 
> 
> --
> Luiz Augusto von Dentz


Regards,
Iulia
