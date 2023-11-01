Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30070C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Nov 2023 15:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjKAPeu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Nov 2023 11:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjKAPet (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Nov 2023 11:34:49 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2072.outbound.protection.outlook.com [40.107.105.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9A4E4
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Nov 2023 08:34:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNmwYzzVdCuLtseqs7ZMTadWsq72/wuCB17ik3/SgvjLUGLnotgaIiZOzSMMqZlvf9bqi5liTHiR0RAh+Zzd+XGQ3dVSVribiWlGceBSK8l5ikVbjML1+gxK3Ww9cSVC5P2B/eXwLT+f8giXgHVFOm14Zv2AD0CiHnIg2ksH1/VqkOMwYbxyFLfgoLvUtCvwEWxCydLD03ByYgKmzIjCnop3e+YFAQDknh1AMFXfDsRpBmWeVcbFW9MPvnm6HR4TR0bRcoBrib/kW78bM0rQBYvrH4sDi3g4n7rWRiZT+ec8tSqy5gfY8+4cvmZPuoZqy3gFx7Ynd88F4Mg63uq00g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA1geaZpRodoV+E+go6mvXDDTlGcX0IG1YiXNvnrgUk=;
 b=PXIYk+lHQq9w/53ZksNquD8WFD7CSb354km8XB9w+/2avcdA5CkIjuV4fkWVOQJcI13Arp8waFsZccbWsWn6Q5jIZ+uzIgF6a1zQn6f3OkzLCAS5dxkxguephqrXZSSAqChTVT+NGz7v2H75R7e/H+J79eUorYVKsVCPI20foCFnEpq4VO742CatmH6vB6pPf8QhgeJrUzeCQiXOeYfkMLjUXCkaORIAfRawUBZsMQRC8gxEfV2Vcpi2NCqdZmv8vTBVTCt3SR8CoTdUkiHJDsP203CRb4xms/y/VSh3OiMsrKCOYeLKjkpMExHuN8uVELYC+t/lIKyAiGtJCGLuiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA1geaZpRodoV+E+go6mvXDDTlGcX0IG1YiXNvnrgUk=;
 b=PtxhHy88GhaOO7EUbpxkNkZeNLNIO+vLT1UhU2Trci2k5zV4FR/0jd8ouCcVgUeAIFEX0drLi9EoWWFTX7WADsCPFnkiYfJUyk7GadZfGQsbT05J9X8sC+5ArjVc3bBk3OpDVwCgg6rQIfzt2NilpnzJbEUpvmihyPic0Jg3NjY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9403.eurprd04.prod.outlook.com (2603:10a6:10:369::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 15:34:40 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::9294:43e2:390:2b6d%4]) with mapi id 15.20.6954.017; Wed, 1 Nov 2023
 15:34:40 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     pav@iki.fi
Cc:     iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: ISO: Reassociate a socket with an active BIS
Date:   Wed,  1 Nov 2023 17:34:37 +0200
Message-Id: <20231101153437.5727-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <96560beaf696de7c21e70b9bf6cd53bdcc29f29f.camel@iki.fi>
References: <96560beaf696de7c21e70b9bf6cd53bdcc29f29f.camel@iki.fi>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0038.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::15) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: f50ece9e-75c9-4b67-5295-08dbdaf01035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RYIJAGAamOqBY8XItKspT9UmzJhdekYKr01ODmUPEZtUU7Mer4udbDgitHy7YigTZ4L4PDjJYXXwvHAPuWsWGgeG889ye/vcP/cvV1mzOAZTEzs2h8V/E21YeVsLRt1wkwlekSjf6fw8AAxjIjoWQga0S67ssVrShNO3mxWwFIc9WbqHHcOdoMG5aeHGRekz1ybzqQWbrtpfF2ni/bJAs21QBNL4EMghys2oxO9hreEu5asefRvk65LpDrByW2K7Al5VaP++9tYwFDRdf3tQSgodPwKqFsAyDwGHchRKHxsuJ5CN6kG6vA27wD8HkB7CeAk5gqYugt4YNsCySWs3DZEWTtL4gN/EPCIkWfqteLw8j6cVCgP7Z+CGWtVfqENASwnPJAicNT32UejugKGUEH+Joejbul34BD9plt7QV7kNYVWA4iZXxoxV7V0vLkEIlDjFw7d9HWAcRQnvJDbPY4pMSy8hUOG/wZSrnFUgTa/DHoqRFTb6HjdtyviLDS6UZ2RSFltkEJ850b3mwQ2inqSZvdd093tIRi6SbkHP/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6666004)(6512007)(38100700002)(966005)(6486002)(6506007)(478600001)(53546011)(4001150100001)(2906002)(1076003)(36756003)(86362001)(2616005)(66556008)(66476007)(26005)(316002)(6916009)(83380400001)(5660300002)(4326008)(8676002)(8936002)(66946007)(44832011)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aVaAs/oZCKaU5DC0PvXnsQzlRekcxrfsNc87jCTUp/AvAUWQCq9xHQJof85G?=
 =?us-ascii?Q?1/J1di1tLQi9Bs/TI1qGU6PT5YQBEcsVK98FxMgcTnLOGWVulzFUr9h3j8PN?=
 =?us-ascii?Q?AC8Dr78P4xksgb64vuoA8hSCPc190DpLaCe7+IvIqmcvRGzBNZUNBhIZSwa2?=
 =?us-ascii?Q?+M5N0Q2grhVtC+EyfgD33mnjjboY7bPxzPya6XUGebGL1J6LaJj3edcyYoyM?=
 =?us-ascii?Q?xPouDF//Kha1DUrOOoMgIobVbfdctgEgIy/G2RT33ctr+NgXvnG1ra5TJbQU?=
 =?us-ascii?Q?pL7VitArtpawcKEBc2RT2MakxZBNoW1c0W3A2MbFmPKfO99dpyj4p6zBYVeQ?=
 =?us-ascii?Q?UyYr3U/Dd2/7SbSWFu2opdFbc07KMOKfFuW0sM/FFZls3j0d/GM6UyN/x40Y?=
 =?us-ascii?Q?ZhlHLM+spdi2SlmCgV294Iv84wZ1JgNUuBDGHchxu65HnU8vtmBFsplyY0/p?=
 =?us-ascii?Q?JfgKPPCiAupTR+Xsdyq59Dgl+zuOyLOqulqeTD62Unhq2KfO4hzJzoClBTro?=
 =?us-ascii?Q?87vPqFfOadKLjxKYKGHvqS0O5VHXiQtLguknYfm+nB7Utl8d13fa7AaQZKQ/?=
 =?us-ascii?Q?Kn+TVaRywdbYGJqGehO8PKGXtB+/L3JMPPWobTXTQ6TPLyAOjlEMWKJfK1OV?=
 =?us-ascii?Q?96YldKvbUnghk8wXOiXgzhAddYyIQEBi2DLgNc087rWqdikxGPoV9Bex6+WC?=
 =?us-ascii?Q?VAdhrlc+SjSC0HvI55c119upuur3rqtkqvTbvChJMnICwebg2jW9K8z3G+SG?=
 =?us-ascii?Q?Hc9VLeYOL8TSmRWGn5PRDZBF3kPFHqHh4rGqb3fe4QkxKXQeiViFWZh7upea?=
 =?us-ascii?Q?MBA0RW7z7e0xZ6VwttwkOuYwk2lpk3pt6vwioyVgQadm3yQhnUUrPif10CRo?=
 =?us-ascii?Q?XTi8ZR3CVaQaDHcje4r2IY/oKoLxF7MfE6psbWHx30v7tpPdLdUnpz1CsYrk?=
 =?us-ascii?Q?O6n01HTAWZeiT1mEm/5W77uKoDrAT7mHR9BMiBIwBBBiD4VL3kzYXztou+bi?=
 =?us-ascii?Q?Dcpe4DmDhhDu0toSsgooQyIh4y0gTLefkOamx8QTHc4C0gdcsW8bRbaWA/QI?=
 =?us-ascii?Q?o4AL40nIq62nqmVG2YDd5gBC93CSEbIBfGfaC+ktiQkcTSi2WL2ogkm80yCM?=
 =?us-ascii?Q?CGp/dYC6KKMcAvX1ONQpYYPmHwf4k99oiX0sgk/sdT+txlvbFdARGFakqwUq?=
 =?us-ascii?Q?HYGfQGC4kpzI3c5ureIlmx3VV3xrZcK9fF2DR6hpWXMB8XM5raydFQbK8TeS?=
 =?us-ascii?Q?OxTnVzJPlQfWIDfuKIg6dpfZJDV+b5n0jUYiq1F4BlWITpPSpGgsFjPUnLhz?=
 =?us-ascii?Q?yOCwIiV913DrnIP6UV+SgktpewcdAp0VK1e69zxHYzOcFcr4LGDwKLzZ8kRJ?=
 =?us-ascii?Q?g0QoCNCn5OLY/dG5/eqh3GNFm5SmmnZVcUEM4bfhtd8DzgNoP+sSmFWclcCU?=
 =?us-ascii?Q?df+CSzABIyXFj5THZZkIGQ9jPKPXNpR8Z1eNUIatVS0tT+gxJUl9BwZmH5Vy?=
 =?us-ascii?Q?yeGXKpgyZMADvO6NLql0MgbcnZSJN8l556mPNKYwjIO2TNHzppbzjn5IU+y2?=
 =?us-ascii?Q?cicdcZR6f1qPetQDLtn07Xcny3LevMqRcT9kgzusQczIpKh7XxlAOCzz+2Bq?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f50ece9e-75c9-4b67-5295-08dbdaf01035
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 15:34:40.3177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/UPp6PirxcZwDiO6okYg11nAFR29U6p1Jq7LHEEfWg5aMc23xoBze2B89X1eOxrJLSjDL8UGLxM+TWYEJZacQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9403
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

> -----Original Message-----
> From: Pauli Virtanen <pav@iki.fi>
> Sent: Tuesday, October 31, 2023 12:13 AM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>; linux-
> bluetooth@vger.kernel.org
> Subject: Re: [PATCH 1/1] Bluetooth: ISO: Reassociate a socket with an
> active BIS 
> 
> Hi,
> 
> ma, 2023-10-30 kello 17:43 +0200, Iulia Tanasescu kirjoitti:
> > For ISO Broadcast, all BISes from a BIG have the same lifespan - they
> > cannot be created or terminated independently from each other.
> >
> > This links together all BIS hcons that are part of the same BIG, so
> > all hcons are kept alive as long as the BIG is active.
> >
> > If multiple BIS sockets are opened for a BIG handle, and only part of
> > them are closed at some point, the associated hcons will be marked as
> > open. If new sockets will later be opened for the same BIG, they will
> > be reassociated with the open BIS hcons.
> 
> Can you explain here a bit the new BIS hci_conn refcounting scheme, it's
> not straightforward to follow? Who owns their refcounts?
> 
> >
> > All BIS hcons will be cleaned up and the BIG will be terminated when
> > the last BIS socket is closed from userspace.
> >
> > Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > ---
> >  include/net/bluetooth/hci_core.h | 24 +++++++++++++
> >  net/bluetooth/hci_conn.c         | 27 ++++++++++++++
> >  net/bluetooth/iso.c              | 60 ++++++++++++++++++++++++++++++++
> >  3 files changed, 111 insertions(+)
> >
> > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > index 20988623c5cc..201c0809540a 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -1292,6 +1292,30 @@ static inline struct hci_conn
> *hci_conn_hash_lookup_big(struct hci_dev *hdev,
> >       return NULL;
> >  }
> >
> > +static inline struct hci_conn *
> > +hci_conn_hash_lookup_big_state(struct hci_dev *hdev, __u8 handle,
> > +__u16 state) {
> > +     struct hci_conn_hash *h = &hdev->conn_hash;
> > +     struct hci_conn  *c;
> > +
> > +     rcu_read_lock();
> > +
> > +     list_for_each_entry_rcu(c, &h->list, list) {
> > +             if (bacmp(&c->dst, BDADDR_ANY) || c->type != ISO_LINK ||
> > +                     c->state != state)
> > +                     continue;
> > +
> > +             if (handle == c->iso_qos.bcast.big) {
> > +                     rcu_read_unlock();
> > +                     return c;
> > +             }
> > +     }
> > +
> > +     rcu_read_unlock();
> > +
> > +     return NULL;
> > +}
> > +
> >  static inline struct hci_conn *
> >  hci_conn_hash_lookup_pa_sync_big_handle(struct hci_dev *hdev, __u8
> > big)  { diff --git a/net/bluetooth/hci_conn.c
> > b/net/bluetooth/hci_conn.c index 2cee330188ce..b8ab5c0cd48e 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -2228,7 +2228,17 @@ struct hci_conn *hci_bind_bis(struct hci_dev
> *hdev, bdaddr_t *dst,
> >                             __u8 base_len, __u8 *base)  {
> >       struct hci_conn *conn;
> > +     struct hci_conn *parent;
> >       __u8 eir[HCI_MAX_PER_AD_LENGTH];
> > +     struct hci_link *link;
> > +
> > +     /* Look for any BIS that is open for rebinding */
> > +     conn = hci_conn_hash_lookup_big_state(hdev, qos->bcast.big,
> BT_OPEN);
> > +     if (conn) {
> > +             memcpy(qos, &conn->iso_qos, sizeof(*qos));
> > +             conn->state = BT_CONNECTED;
> > +             return conn;
> > +     }
> >
> >       if (base_len && base)
> >               base_len = eir_append_service_data(eir, 0,  0x1851, @@
> > -2256,6 +2266,20 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev,
> bdaddr_t *dst,
> >       conn->iso_qos = *qos;
> >       conn->state = BT_BOUND;
> >
> > +     /* Link BISes together */
> > +     parent = hci_conn_hash_lookup_big(hdev,
> > +                                       conn->iso_qos.bcast.big);
> > +     if (parent && parent != conn) {
> > +             link = hci_conn_link(parent, conn);
> > +             if (!link) {
> > +                     hci_conn_drop(conn);
> > +                     return ERR_PTR(-ENOLINK);
> > +             }
> > +
> > +             /* Link takes the refcount */
> > +             hci_conn_drop(conn);
> > +     }
> 
> So the first hci_conn added in a BIG is assigned as "parent". How does the
> refcounting here work?
> 
> hci_conn_link takes refcount of the parent (cf. hci_conn_unlink), but it's not
> incremented here so I guess it may go negative.

When adding a new BIS hcon, hci_add_bis will take the refcount.

The first BIS in a BIG will be assigned as parent. When new BISes are added,
they will be linked to the parent and hci_conn_link takes an extra refcount
for children:
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_conn.c#n1724

This is why hci_conn_drop needs to be called for children BISes, to remove
the duplicate refcount.

> 
> hci_conn_unlink does not drop child connections, and they're not dropped
> by the socket closing below unless last, so I'm not sure if they are then
> cleaned up if closing sockets in any order.

If hci_conn_unlink is called for a child hcon, the child will be unlinked
and hci_conn_drop will be called on the parent:
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/hci_conn.c#n1130

hci_conn_unlink will then be called for the parent, and all other children
hcons will be cleaned up with hci_conn_cleanup_child.

So regardless if the parent is closed first or any child, all hcons will get
to be cleaned up.

> 
> This change will also expose BIS hci_conns to hci_conn_cleanup_child,
> which was written only for unicast, and might not be right for the use case
> here.

That is right, from the tests I performed I noticed the conditions in
hci_conn_cleanup_child are also met for BIS so it will reach
hci_conn_failed, but I submitted an updated patch to add a dedicated
condition for broadcast also, to cover all cases.

> 
> > +
> >       return conn;
> >  }
> >
> > @@ -2287,6 +2311,9 @@ struct hci_conn *hci_connect_bis(struct hci_dev
> *hdev, bdaddr_t *dst,
> >       if (IS_ERR(conn))
> >               return conn;
> >
> > +     if (conn->state == BT_CONNECTED)
> > +             return conn;
> > +
> >       data.big = qos->bcast.big;
> >       data.bis = qos->bcast.bis;
> >
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c index
> > e01b6abe36fb..13353d7dc4b1 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -587,6 +587,44 @@ static struct sock *iso_get_sock_listen(bdaddr_t
> *src, bdaddr_t *dst,
> >       return sk ? sk : sk1;
> >  }
> >
> > +static struct sock *iso_get_sock_big(struct sock *match_sk, bdaddr_t *src,
> > +                                  bdaddr_t *dst, uint8_t big) {
> > +     struct sock *sk = NULL;
> > +
> > +     read_lock(&iso_sk_list.lock);
> > +
> > +     sk_for_each(sk, &iso_sk_list.head) {
> > +             if (match_sk == sk)
> > +                     continue;
> > +
> > +             /* Look for sockets that have already been
> > +              * connected to the BIG
> > +              */
> > +             if (sk->sk_state != BT_CONNECTED &&
> > +                 sk->sk_state != BT_CONNECT)
> > +                     continue;
> > +
> > +             /* Match Broadcast destination */
> > +             if (bacmp(&iso_pi(sk)->dst, dst))
> > +                     continue;
> > +
> > +             /* Match BIG handle */
> > +             if (iso_pi(sk)->qos.bcast.big != big)
> > +                     continue;
> > +
> > +             /* Match source address */
> > +             if (bacmp(&iso_pi(sk)->src, src))
> > +                     continue;
> > +
> > +             break;
> > +     }
> > +
> > +     read_unlock(&iso_sk_list.lock);
> > +
> > +     return sk;
> 
> What keeps sk alive?
> 
> This pattern is used also in iso_get_sock_listen, but I don't understand why
> it's OK. In unix/ & netrom/ & ax25/ I see sock_hold before lock release in
> similar constructs.

It seems like it might be necessary to add sock_hold to make sure the
socket is kept alive while it is being processed, so I added this update
in the new patch version.

> 
> > +}
> > +
> >  static void iso_sock_destruct(struct sock *sk)  {
> >       BT_DBG("sk %p", sk);
> > @@ -639,6 +677,28 @@ static void iso_sock_kill(struct sock *sk)
> >
> >  static void iso_sock_disconn(struct sock *sk)  {
> > +     struct sock *bis_sk;
> > +     struct hci_conn *hcon = iso_pi(sk)->conn->hcon;
> > +
> > +     if (test_bit(HCI_CONN_BIG_CREATED, &hcon->flags)) {
> > +             bis_sk = iso_get_sock_big(sk, &iso_pi(sk)->src,
> > +                                       &iso_pi(sk)->dst,
> > +                                       iso_pi(sk)->qos.bcast.big);
> > +
> > +             /* If there are any other connected sockets for the
> > +              * same BIG, just delete the sk and leave the bis
> > +              * hcon active, in case later rebinding is needed.
> > +              */
> > +             if (bis_sk) {
> > +                     hcon->state = BT_OPEN;
> > +                     iso_pi(sk)->conn->hcon = NULL;
> > +                     release_sock(sk);
> > +                     iso_conn_del(hcon,
> > + bt_to_errno(hcon->abort_reason));
> 
> iso_conn_del must be called with hdev->lock held, that's assumed in
> iso_connect*.
> 
> Locks must be taken in order hci_dev_lock > lock_sock > iso_conn_lock.
> 
> Could this use iso_chan_del instead (plus maybe iso_sock_clear_timer)?
> Lifetime of iso_conn currently follows hcon, not sure if that needs to be
> changed?

I agree, I could use iso_chan_del here, so only the socket is cleaned up,
and the ISO conn will remain allocated as long as hcon is alive. I updated
in the new patch.

> 
> > +                     lock_sock(sk);
> > +                     return;
> > +             }
> > +     }
> > +
> >       sk->sk_state = BT_DISCONN;
> >       iso_sock_set_timer(sk, ISO_DISCONN_TIMEOUT);
> >       iso_conn_lock(iso_pi(sk)->conn);
> 
> Not related to this patch precisely, but I suspect the disconnect timeout is
> something that is not useful for ISO sockets and maybe we should remove it,
> since closing sockets is used for CIG/BIG management.

I think the disconnect timeout makes more sense for CIS management, because
when a CIS socket is closed, HCI_OP_DISCONNECT is first sent to controller
to disconnect the CIS, and only after HCI_EV_DISCONN_COMPLETE is received,
the hcon will be cleaned up and the CIG will be removed.

> 
> --
> Pauli Virtanen

Regards,
Iulia

