Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43749EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 15:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjF1PKh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 11:10:37 -0400
Received: from mail-db8eur05on2046.outbound.protection.outlook.com ([40.107.20.46]:18401
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229999AbjF1PKf (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 11:10:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ma3z6mGxAwxSaAmS/eD2zK/pkcIZQ+dbu5IMWfTcqLn6WycdohvQrkfQfwx7YamiC4m+3Q1UkuhRuEayXySOHPaJPbrBlthUMpNAIRYpEr8AyGw7tN5nGmQHfC+196PU5w04VQ/+6YSJkftw7VcPOLARD0QsIF98eTSjeGULEOQHhIlHhheM7/bZ8hE8zL8WLBD1oGZD4Y/1kPwH2vCbUUs3IGJx/EQwyUKe/ouIdIt9RzsL/fgkSG5aHgJoRJjWTU3JxsJSlDHE/RvcGzP7evuVygFLZfJrBJ/xc8wl4Y6YrOlq0lBaWR3KBKNn2jL+yYrJxb4UVWhkodMgLzxkew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AnKRAirzo0XCz8KppOj70qFrKC/K/OtlQ+W293Y4As=;
 b=AD3WMBt/uo657pmgCZhPck/74PyBVyrOvLBN7eyo9g02dFsg0Jr/THZRye8rqEwjXJi3j9W3NIE3ipLzimbbWYbFZcdWGshhmJt7FdJE2O3P3YtCZbhk28vRkwIK6Ljf1nLQFJ5WsaY8FqYQ1LfejcfqbOmRtTVzE02vltfrN/XpLdMkh6eTqueg7FeCor6jZt5nVV5Jlem+9JWsYAX3aoLHqGcSq3hxNbWYIAJfT7ccjOVjBvn3IJ/p/QwL6CiB8cA4aanvwEgtxnVfDYxneFjXe5fADq4GA+0r0zz04lZAspJRMSXv/bZAd+vInmIQhPTbQDsNrxjLfnPtd0Zx+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AnKRAirzo0XCz8KppOj70qFrKC/K/OtlQ+W293Y4As=;
 b=VcI3+GMig4BGIZ3AP94GL0zlTP3MNrp+XQZeQoRbFG+1InCB29o3Hz3zgvFeYMpjsWeNPFXfcgoO+fhbG2QwlZjNAI+boyrZ/QAO9bfxGKb6EP9tPjMiFE23jj/QIhy1QFfuq37Ayc0YCgDHPu+yL/gIzZQIyZaGxS/NCevNMx8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB8995.eurprd04.prod.outlook.com (2603:10a6:20b:42e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 15:10:32 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7526:7510:9b32:e1fe%7]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 15:10:32 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     andrei.istodorescu@nxp.com, claudia.rosu@nxp.com,
        iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com
Subject: Re: [PATCH 1/1] Bluetooth: ISO: Notify user space about failed bis connections
Date:   Wed, 28 Jun 2023 18:10:18 +0300
Message-Id: <20230628151018.254406-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZLnfFHEHHuK3=p1a3=361A7YEcPcSmbjz8z+9bn4wWuyw@mail.gmail.com>
References: <CABBYNZLnfFHEHHuK3=p1a3=361A7YEcPcSmbjz8z+9bn4wWuyw@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB8995:EE_
X-MS-Office365-Filtering-Correlation-Id: 76e84c8f-3eef-4624-323e-08db77e9d13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OyhvCnBa8Ug2RgYeS2xLT88eEMDcBqeUYeMFGx2w3ZixGvkpGMbceSt7tAPe3nidTs8qboJ6HDwzf/xVqTTLY1ZfM/hUKi+5uPAwDGWXPTYzYKVaPqMidYnnLnGeSnfC5peJeet7DkPZO6zxWrx1sBtHSjyF9bVCAdgPULn77qFvI44sEEZuiXTmLklR9gdB/XrOY0sp29fwOhwugcEbBIMKZjJ4dsDx1p08TeTKnFZcqNvxG7APCzuC9Egrnxio0og5BhIUX5N4FEURI4xyzBv4ODYFFsmJe8hOfK701al0RKzTCGJMx/OkCA8SidWgbP/2Xh76ATvRQgvDLHr0KRUFTRcU0hEHQJtBRsMp546Ef4HxA2DRfNbBSOrP+HBg4Pa9VY+V0mUNRkIg3pXUkUrET2LC2YroKq5fFT24Azko28mFMnAYYpXKXFD4HoSFFp1s9AzrrRCxHM8mQ94MxnOctXrIayM0n/g8oLQJDxTl0rGRnz3W+lRHlU9jkAQmIs7Ntlx1mNREUGrmjzWg3fnCcm8rFDV2VcjvoAUO+6q/1UKh94wo+PDNEOAfinOAmne+6PWVa4G+INzHvvo8X29KOFwZUC7RQLmKnnHqBn+iWQHmd2NbhTSgf4TMjjKX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(26005)(86362001)(41300700001)(6486002)(966005)(6666004)(52116002)(83380400001)(45080400002)(478600001)(2616005)(1076003)(186003)(6512007)(2906002)(6506007)(5660300002)(44832011)(36756003)(66556008)(66946007)(38100700002)(66476007)(38350700002)(30864003)(53546011)(8676002)(316002)(4326008)(8936002)(6916009)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bhAuIwv7fUGv8MFtCqFWHzlLlS/IsEBZQnJN7VHvkqfmK1Y58FcwdzmK2hCd?=
 =?us-ascii?Q?ZdWWYt72gwa/04/HIP00Uk9FezzGXu3warnZMzpiNq2Ah7qTTxyAvR+TE7RL?=
 =?us-ascii?Q?/oRneq7Q+9Yun+pfddAmrIeqe3odCb0IPOSNvdeQ+g2WxOAqsLZKoYI9/T0c?=
 =?us-ascii?Q?duSZIJdOJ0V3K3oITzuAFrzsCZhce6uhNq1oQrlFSPxXMf5KYFSDN6Vs1VjA?=
 =?us-ascii?Q?MyFrkKyCTXm0u0/MwSU1kBk7Yn8pmYnlysV8Ckg278zzrQVZ95R3f1HPIVQQ?=
 =?us-ascii?Q?Gho2OoSwYyyzH3aa7LKZbCSVjZcCghnT3FkuIiT6UCYLJQHOUXegccbiCuzK?=
 =?us-ascii?Q?L7vO+iZGYDJkwTB8VOKGa7byxMXuO2Ze36LvtV3tPlArgamPWG99j7FcgEav?=
 =?us-ascii?Q?WyUr6kqlE473aadhz/egbyDoh1HauDOR8GzBqZq5RZGdMBfwbi4HMv2QKLWj?=
 =?us-ascii?Q?VOWwGSJ/CJOeqvBLP8D2Eqi1FHSDWcTGiJzQn/ricG6ZNvxzW1x94Hd/eXQC?=
 =?us-ascii?Q?YnagccWyEBscOTSouKM2pQ2PYEsFbjXUD2OAUMY2VtGZ+/1/bE9V0KqDrq6K?=
 =?us-ascii?Q?gSGry4wX3Sf6NuprPqViXLDzVmvn4tri58UAlMrBSS+PVCG4HLuXXZ99TERm?=
 =?us-ascii?Q?0qqcD0f9wQxtmuGlmaralwblLmjIFtKVMzvOL3hgUu1ZxrCq+yUxy/iUSo0I?=
 =?us-ascii?Q?0SneKkXd07B2aU89TJujGOGC9xDaWB/4hgTwuQd2TWkQ68MtvWg5FBzujtiK?=
 =?us-ascii?Q?GUDCKcbdR0u9gjA1+yqo4CtZOKcNCcRMjsjgtTPYYZrsr8uBJhjOLwZSsBeX?=
 =?us-ascii?Q?rBStZlbOXKc424V+eJ4Q8ckUt+yK52fMKPBby1dpiZs4MRlCJPSHm7h6kPVw?=
 =?us-ascii?Q?tK/SWqqS2IZYyLoirpT6QkSlD11q9+6J9339fvHJ6ubBdXF5+YFBFv8S5Wb2?=
 =?us-ascii?Q?YmK4WnH69JR3oyc0jx++XzenD5t49cFVLf2NiYLqMZqZeQrgVYQIBKf//5D/?=
 =?us-ascii?Q?UOlOsao70SsE8PWdK+frXKxd5EKLiWu0NCfDM8Uc+vKLkrLywd5rJ7j2NXiO?=
 =?us-ascii?Q?4ABYbrlui8gVfUJXQJHvLrYSPNIskooAYGoPtqmjsSX0RRM5/BGM5YDc93D7?=
 =?us-ascii?Q?gjAbTGS7UUfMS8rf3psYSR1Temlf7Oy8fZPawg2LSion1pm+zD540Ziquww0?=
 =?us-ascii?Q?k0GNUf5fMUD6KcCVre4oHJly/SIMirmR4LD67ogyk3DhG6mMpFJ3dK7teSzl?=
 =?us-ascii?Q?Y8rk18Mx1CRkrfID+3BF04cZW7R6zKKKr8Y9bYcfVv81sZjOV7E7KJUMAfyR?=
 =?us-ascii?Q?wPRKX1Q7//sgH+IIguoOuTfbaQPH5kfODvpfkqDA5HiVFICvGw8MAyyavDdF?=
 =?us-ascii?Q?c0KbF8tiaeziBZejLv22sKlXXzWrJvahIDKvxqLQt9HhLjq8YyWGtyi8U28M?=
 =?us-ascii?Q?tfnUWXFTkgoGGDM4Xa1pM2+bldnQ+Dk8KCB+uGx4+nzjy5ZeWobXApEuunrc?=
 =?us-ascii?Q?kZQdZ2tKNsIRQ/Ml2kIHnGNd+SiHNgoGEOf1xcUBvFoAAVM+OKm+0Sl/08fx?=
 =?us-ascii?Q?Xsy/kAjfR5XtR46DDBwu4uTasv0DIVXN7tbpMWpGqc2GlXz6JQeZlrRwxP0H?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76e84c8f-3eef-4624-323e-08db77e9d13b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 15:10:32.6132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o2zGlftLrS+4sDqSmLEwNCwA7oplIg6OBJRgz24sjAUww8zUKegwwODJop7RPNjApRY/1oZKT8b1Z9rrAi5Rhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8995
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Monday, June 26, 2023 10:51 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH 1/1] Bluetooth: ISO: Notify user space about failed
> bis connections
> 
> Hi Iulia,
> 
> On Fri, Jun 23, 2023 at 12:43AM Iulia Tanasescu <iulia.tanasescu@nxp.com>
> wrote:
> >
> > Some use cases require the user to be informed if BIG synchronization
> > fails. This commit makes it so that even if the BIG sync established
> > event arrives with error status, a new hconn is added for each BIS,
> > and the iso layer is notified about the failed connections.
> >
> > Unsuccesful bis connections will be marked using the
> > BT_BIG_SYNC_FAILED state. From the iso layer, the POLLERR event is
> > triggered on the newly allocated bis sockets, before adding them to
> > the accept list of the parent socket.
> >
> > From user space, a new fd for each failed bis connection will be
> > obtained by calling accept. The user should check for the POLLERR
> > event on the new socket, to determine if the connection was successful
> > or not.
> >
> > To ensure proper cleanup of the unsuccessful bises, the le_bis_cleanup
> > work callback has been added, similar to le_scan_cleanup. The callback
> > deletes the hci connection and notifies the disconnect to the iso
> > layer, so the socket is also cleaned up.
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
> >  include/net/bluetooth/bluetooth.h |  5 +-
> > include/net/bluetooth/hci_core.h  | 25 ++++++++++
> >  net/bluetooth/hci_conn.c          | 78 +++++++++++++++++++++++++++++--
> >  net/bluetooth/hci_event.c         | 21 +++++++--
> >  net/bluetooth/iso.c               | 37 ++++++++++-----
> >  5 files changed, 145 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/net/bluetooth/bluetooth.h
> > b/include/net/bluetooth/bluetooth.h
> > index 34998ae8ed78..b05147cf4c57 100644
> > --- a/include/net/bluetooth/bluetooth.h
> > +++ b/include/net/bluetooth/bluetooth.h
> > @@ -292,7 +292,8 @@ enum {
> >         BT_CONNECT2,
> >         BT_CONFIG,
> >         BT_DISCONN,
> > -       BT_CLOSED
> > +       BT_CLOSED,
> > +       BT_BIG_SYNC_FAILED,
> 
> I would mess around with these states, they are generic for all sockets.
> 
> >  };
> >
> >  /* If unused will be removed by compiler */ @@ -317,6 +318,8 @@
> > static inline const char *state_to_string(int state)
> >                 return "BT_DISCONN";
> >         case BT_CLOSED:
> >                 return "BT_CLOSED";
> > +       case BT_BIG_SYNC_FAILED:
> > +               return "BT_BIG_SYNC_FAILED";
> >         }
> >
> >         return "invalid state";
> > diff --git a/include/net/bluetooth/hci_core.h
> > b/include/net/bluetooth/hci_core.h
> > index 05a9b3ab3f56..81e83ecdd267 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -761,6 +761,7 @@ struct hci_conn {
> >         struct delayed_work idle_work;
> >         struct delayed_work le_conn_timeout;
> >         struct work_struct  le_scan_cleanup;
> > +       struct work_struct  le_bis_cleanup;
> 
> Also not a fan of adding yet another work, le_scan_cleanup already have its
> own problems:
> 
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> work.kernel.org%2Fproject%2Fbluetooth%2Fpatch%2F45455ee45ccb3313618
> a48c01be714e14d372257.1687525956.git.pav%40iki.fi%2F&data=05%7C01%7
> Ciulia.tanasescu%40nxp.com%7Cf66a681e941d4d08f62a08db767ea5ce%7C6
> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638234058603291830%7
> CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=rrWS4LjpQkqlx
> e1oK94BAcwHQ5o%2BwqwtaEwSlmCQgZ0%3D&reserved=0
> 
> In fact Im not sure why we couldn't use conn->cleanup?
> 

I submitted a new version of the patch, where I removed the le_bis_cleanup
work and instead I am just cleaning up the connection by removing it from
the hash list and calling bis_cleanup. I think this should be enough and,
as far as I have tested, it doesn't seem to create any deadlocks or other
issues. If you think this version is still not safe, I could just call
conn->cleanup and maybe leave a TODO comment to apply a proper method to
clean the connection up when a solution is found.

> >
> >         struct device   dev;
> >         struct dentry   *debugfs;
> > @@ -978,6 +979,7 @@ enum {
> >         HCI_CONN_PER_ADV,
> >         HCI_CONN_BIG_CREATED,
> >         HCI_CONN_CREATE_CIS,
> > +       HCI_CONN_BIG_SYNC,
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
> > b/net/bluetooth/hci_conn.c index 62a7ccfdfe63..e4aa7731b987 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -207,6 +207,36 @@ static void le_scan_cleanup(struct work_struct
> *work)
> >         hci_conn_put(conn);
> >  }
> >
> > +static void le_bis_cleanup(struct work_struct *work) {
> > +       struct hci_conn *conn = container_of(work, struct hci_conn,
> > +                                            le_bis_cleanup);
> > +       struct hci_dev *hdev = conn->hdev;
> > +       struct hci_conn *c = NULL;
> > +
> > +       BT_DBG("%s hcon %p", hdev->name, conn);
> > +
> > +       hci_dev_lock(hdev);
> > +
> > +       /* Check that the hci_conn is still around */
> > +       rcu_read_lock();
> > +       list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
> > +               if (c == conn)
> > +                       break;
> > +       }
> > +       rcu_read_unlock();
> > +
> > +       if (c == conn) {
> > +               conn->state = BT_CLOSED;
> > +               hci_disconn_cfm(conn, hci_proto_disconn_ind(conn));
> > +               hci_conn_del(conn);
> > +       }
> > +
> > +       hci_dev_unlock(hdev);
> > +       hci_dev_put(hdev);
> > +       hci_conn_put(conn);
> > +}
> > +
> >  static void hci_connect_le_scan_remove(struct hci_conn *conn)  {
> >         BT_DBG("%s hcon %p", conn->hdev->name, conn); @@ -229,6
> > +259,28 @@ static void hci_connect_le_scan_remove(struct hci_conn
> *conn)
> >         schedule_work(&conn->le_scan_cleanup);
> >  }
> >
> > +static void hci_bis_remove(struct hci_conn *conn) {
> > +       BT_DBG("%s hcon %p", conn->hdev->name, conn);
> > +
> > +       /* We can't call hci_conn_del/hci_conn_cleanup here since that
> > +        * could deadlock with another hci_conn_del() call that's holding
> > +        * hci_dev_lock and doing cancel_delayed_work_sync(&conn-
> >disc_work).
> > +        * Instead, grab temporary extra references to the hci_dev and
> > +        * hci_conn and perform the necessary cleanup in a separate work
> > +        * callback.
> > +        */
> > +
> > +       hci_dev_hold(conn->hdev);
> > +       hci_conn_get(conn);
> > +
> > +       /* Even though we hold a reference to the hdev, many other
> > +        * things might get cleaned up meanwhile, including the hdev's
> > +        * own workqueue, so we can't use that for scheduling.
> > +        */
> > +       schedule_work(&conn->le_bis_cleanup);
> > +}
> 
> This is a bad idea, we are already dealing with the same shortcomings with
> respect to scan le, what we could probably do is to defer queue_sync, but I'd
> wait until we find a proper solution to scan so we apply here as well.
> 
> >  static void hci_acl_create_connection(struct hci_conn *conn)  {
> >         struct hci_dev *hdev = conn->hdev; @@ -686,6 +738,12 @@ static
> > void hci_conn_timeout(struct work_struct *work)
> >                 return;
> >         }
> >
> > +       /* Cleanup bises that failed to be established */
> > +       if (conn->state == BT_BIG_SYNC_FAILED) {
> > +               hci_bis_remove(conn);
> > +               return;
> > +       }
> > +
> >         hci_abort_conn(conn, hci_proto_disconn_ind(conn));  }
> >
> > @@ -793,6 +851,7 @@ struct iso_list_data {
> >         int count;
> >         struct iso_cig_params pdu;
> >         bool big_term;
> > +       bool big_sync_term;
> >  };
> >
> >  static void bis_list(struct hci_conn *conn, void *data) @@ -880,24
> > +939,26 @@ static int big_terminate_sync(struct hci_dev *hdev, void *data)
> >         if (d->count)
> >                 return 0;
> >
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
> > +994,14 @@ static void bis_cleanup(struct hci_conn *conn)
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
> > @@ -1067,6 +1134,7 @@ struct hci_conn *hci_conn_add(struct hci_dev
> *hdev, int type, bdaddr_t *dst,
> >         INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
> >         INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
> >         INIT_WORK(&conn->le_scan_cleanup, le_scan_cleanup);
> > +       INIT_WORK(&conn->le_bis_cleanup, le_bis_cleanup);
> >
> >         atomic_set(&conn->refcnt, 0);
> >
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index b1aefe4bb751..5629a118ece4 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -7020,9 +7020,6 @@ static void
> hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
> >                                 flex_array_size(ev, bis, ev->num_bis)))
> >                 return;
> >
> > -       if (ev->status)
> > -               return;
> > -
> >         hci_dev_lock(hdev);
> >
> >         for (i = 0; i < ev->num_bis; i++) { @@ -7046,9 +7043,25 @@
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
> > +                       bis->state = BT_BIG_SYNC_FAILED;
> > +                       hci_connect_cfm(bis, ev->status);
> > +               }
> > +
> >         hci_dev_unlock(hdev);
> >  }
> >
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c index
> > 84d238d0639a..a2571d8ea055 100644
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
> > +               if (ev && ((struct hci_evt_le_big_sync_estabilished *)ev)->status) {
> > +                       /* Trigger error signal on chilld socket */
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
> > +       if (!status || hcon->state == BT_BIG_SYNC_FAILED) {
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
