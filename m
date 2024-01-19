Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2063.outbound.protection.outlook.com [40.107.241.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7817354BC5
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jan 2024 15:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679251; cv=fail; b=FKr7PAjC6d0gMjr+a6Ggl1SSx7idAhQn4wW7bbJkQPo6ivlifAtW1MOXjHLrBvcxVvF3l+KJCQElPAgvKF8NN+GXQd8I4LuZtcnu1UQxyrJBsA6H9G2v8Ca9UAtkNbwrgO6hRdM/HrKU7UfUWVcyd+Pa7XhbN7Ov6WLFxS1iWgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679251; c=relaxed/simple;
	bh=cnDfOq2lMpzZV/lMO7yqlwqwRIQ/r1TMuw7Q457jF4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QKDV0xxRlj/qNi2Jdyult6k8TbHQFq1yEhmMtK/vp88zmzbbaK83uEeiBfIty5m8hq6DWrec+LWux+Ht5SuTKANQsjcczibUfh0Tc/sz4NI7oJ/fELOXEK6ZRKVznlblcob7URAnHbqqk+sac03aXQ1b/tqglA9ikPuUk4eWvSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=S/MgjbFK; arc=fail smtp.client-ip=40.107.241.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S/MgjbFK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvrTAgaLqsaXrM+3nGGCd0AcnjV/e3Dry2dq4vlnVvnHIpKbyGa2wXGgXlws9UcZRrJcJEI9Cph0RpY28S/LZ1+HJjRgkSVdOonn0Atq6XG1XjYEfq4fk+wZfR0fOAntENR2i1GqT51k4hk72gOhxMi8KBFLcPxZbOn+4O4ZWYBUiIOAicxNSnBprXW3v7xN3BsLuoH4lkBrAlXcg4fE3DZZ/QzaY6dyA8Xgxa1t3+rSCTYwLhfE0L4LJYmP5YZZEVaCyA7yitVi0PtnDD6crHOWdtIC8U80sPx5LWGpHj5JZuhvY2I4d1+N2WgpqBn9W42Be+5ltFmcR3HNpiCKtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pI1U7ZhxuVO5tNZaRC0E52k1w4A9gj6Gvyaib1KuwUs=;
 b=aN8RmE6duYdPyJq9d104oRrOxG1cUM8NCxZRAUFwKI496/etyqcT0JWhXQFD6Tt3rzTp7h85+W5wTE6OcyLGiQDSzbl/YvgY59uewTA3G45NrDRd3SLzr0xWQVzE+6X1M/iStFjEM/0g4/sFIBwQNnYfrNDRe2iP9QQDZSvMsqENpGGqbUoBJ9MnRNEZfhDOX85CCzgbk95x9zS0MNpWEaIJFCNxYIziC6PtD/eSWIl51bbq7k/5lQIex3V1frhUo0zEX6zVGGAlvrrF69YG5ll5Q/I5dVw3tB8wpA3YfNSkgVx3hBTQFVxOUGCENnUSiVvaOGi0PlFST35YqPP+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pI1U7ZhxuVO5tNZaRC0E52k1w4A9gj6Gvyaib1KuwUs=;
 b=S/MgjbFKW/olzmi6LXbsAfDf9fcqu43R1eyjLSqCSFS7L6TJeVVi90zd8XhzT3DqohJceZ28uxoauQv3iTY1pu82zVk5MNvfxzw436dsNE2oz0xeYsgu3IVmBf+ibEkwCV4vhfppTYQfN4pU1GCn5TPD5nyONRpPh7xWRV27rTI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9091.eurprd04.prod.outlook.com (2603:10a6:102:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 15:47:26 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 15:47:25 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 1/1] bap: Fix bcast endpoint config
Date: Fri, 19 Jan 2024 17:47:23 +0200
Message-Id: <20240119154723.4737-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZJduvCkv3F5VNJDmUn1sBDAvV5uXFaTOskc0Feg0xU14w@mail.gmail.com>
References: <CABBYNZJduvCkv3F5VNJDmUn1sBDAvV5uXFaTOskc0Feg0xU14w@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0105.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 87a7f5b6-0954-465a-7fd6-08dc1905ef18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QEX3Tn1VtYELEysovHgUXYMi9+RV3j37N8+D8GmTiJUpDziD2XfesftBRz3OXXwo5lB51bApFVlSnwC16N1sLRanHI4ySBd4SMS4kQasn40rJzD0ZX76sTgsRBRpYBcUuQqQj3RQ1WzefWBtmrKHSnfZsSVSFyiPu2o/JO5SIO2u4l9msypO0oQiJWLNG5qYrGmbE5yHPQBHS/IQ6Egve9EqRqcdPCqLMFDzyywX4E5O3bvq43gMUWq7lqJbveURhVjf3qa9CLhJpp0IJ09hVkNf7MJ5sKE0NCmgEpUHdgNyyGAkqUVfI0961+7BJ3YDuXxGJaGV4y9rXFqKvT+NFybaeNWXW7jRNftKvlJruAkgepfuVpxdxBLYCBAqr77/VJAE95fY7VN9eWb2quw524bPIl1jmho+P+tzMhMl0hmTu5jUfqCwntlX8xlfcQHwq+YzGdFEyWXxa9d38ZDccbukOTSOFf480vVHaQ7MD2sLcYR80HCgrOTXLRmxQcKFwV6qoSpM2tEyYsB5ruP4FThF3Aej/QxVgGOlncwdJyJBbxDFgDiLBFAcM4w06uJa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(478600001)(2906002)(38100700002)(36756003)(86362001)(41300700001)(66556008)(2616005)(6512007)(316002)(6506007)(6916009)(66476007)(45080400002)(53546011)(8936002)(966005)(6486002)(4326008)(26005)(66946007)(5660300002)(83380400001)(8676002)(44832011)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a6hhdbNpoVjYrFX9CjG7Yjzttyy66VjjKtBbYp7Mt8ylYx4enDha2khHuiyQ?=
 =?us-ascii?Q?JDa+SRrMGfZ87xb1zbQ+Z7M1con67YC94JB8BV6BGhEp2xK+yYA2WhAzDb26?=
 =?us-ascii?Q?AGMzzK9OQfM+j9O4f7mrTukR2rguK5gj0N1K4oLtwjINfgCAHnfbJVqL6TNd?=
 =?us-ascii?Q?6kw0ZbcObhgzwDoHuL/2qzM20rkezeM8ffNh+Le/AMVxxU0iMPJmgDSpzGY5?=
 =?us-ascii?Q?US/ZFHiHwLycIYSNfDrvI0EI8OEdp1ypEkIHOi5l9LmfQ2NH3Deuz/h2ORx/?=
 =?us-ascii?Q?yW+oXK1C+O1IcnJvk/x/MTGlqNH1ANo3y6MVm3CVP7B7aa4mO5mJOH3jbgOV?=
 =?us-ascii?Q?TOcToUrIkIe/OcpZp1lB9QI7rnzmKaJ2f7zXkb7MKk+0LifGYR1aJFR5xH8b?=
 =?us-ascii?Q?h0btx+uAPPHZXDym2x3AvztFvv7rW1RUtHrqckeEyTCdOzyhQHoGpMYWjqH5?=
 =?us-ascii?Q?Zq9/mz/lFd82vfqX4kpG75zAuG7Exo+f+jeMn1j2dDVApFTtku/sq9yieu+S?=
 =?us-ascii?Q?dTQk52AKlbP55eYos+f2xUqprXmn64PXESqNSwUr3GLK4Iev/ny/EYRhm6AU?=
 =?us-ascii?Q?qdPTo8lqCobNChr9ASB8zufkqpzOcmvr8NQKCo/eQ9Z9IOBZ7aRDuyPZQGGJ?=
 =?us-ascii?Q?yWObb4bZUM+j0pRTadRZ3Etl2YtFYs5Tvh9dGlNabB+VNjaAUN5uS2AWedX9?=
 =?us-ascii?Q?k1MFl/Lsj5kpDlheTlitCZID9EYz0a/2ePfdj7RGXx61MNs5V7LJIWE5LN40?=
 =?us-ascii?Q?4T4NAE6ToAWmjAzr1G6kDB/C40ZhT7/jUussZXWV8Txhe5Xd4r14zWY83oqe?=
 =?us-ascii?Q?zgLohNHLW3IO8FKI1Z8WQnyeFHcd16Z3l9YrU3Nw8gABhK+ocnJ0s4sKFo1K?=
 =?us-ascii?Q?Z/45OmPzHyAiAJDH1pxs+VvH7MChrK9IOhbKew/FUVNBSWYOGHe9fQg5RID6?=
 =?us-ascii?Q?FhuHH8PPFXPWw2V3xyLKJMXwyz9NGBGyHAAQyOJMK0/ujrmypQxIQlrX7mr/?=
 =?us-ascii?Q?Gv9oVsXo4F3aZi2YzT+r+Y62Qek8dFd22DlWu8KIaLqEp4vJYXBr0w9ZBFSs?=
 =?us-ascii?Q?pHOvznUxBIxq4HlCioDns8oZ7KRtcVDp8sizD8iNqCNuzrZKsXd+n//LK09t?=
 =?us-ascii?Q?b61GnlaMeBgl83a6rSJbSSS7qoP9Q9rxJSwirLbatA/wCO3/CkUhSKDHmtJP?=
 =?us-ascii?Q?vNsNin5bemMEm+6X4W0i40Gi/6PYfLGhMPT6JkUL8HYXcjpV/YIW8jZCRD6z?=
 =?us-ascii?Q?WPBSMkCSHAsR7kB43iYPxr+8107Zj/+GJ33hDIWRnhuR3ggfHWK6ICEHT9Rv?=
 =?us-ascii?Q?Bp+S2GXSSvFWP36gVQUzRKPWCflYmeTcvxY22Tlzim1XAlGtTI/6NU5PJ0aM?=
 =?us-ascii?Q?D+Ox7IPMy9aUmpSqhaVBqdTUMMXVOUrcv5mWm1AtmF9i9n+Ym9HUM8PNnq/l?=
 =?us-ascii?Q?PBTJM3+e3E0ykna1n7j7PJUdIQpq/IXSG40KvUm/DHNi9byGJUxHXfk5bhvC?=
 =?us-ascii?Q?uaQq09Zpz6eJM+0FtMKMWczS3rH7euOH353FzbfUW0WOgBAXN8sNwbqG+0wh?=
 =?us-ascii?Q?3q7EtXkylQgGZVYHjWfEON4J3aykK5E4p+Qd+7o0C0+h0Go9BF2n//QRHLs+?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a7f5b6-0954-465a-7fd6-08dc1905ef18
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 15:47:25.8407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Na90Tcmq7Bt7PxPJyVVGP3BbKLoHEBgb/k0qu1WbCXBDPpmgHkKLbqBB9LE5apxPv/o5EHC8RXNhCx1yoAdgBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9091

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Friday, January 19, 2024 5:12 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [PATCH BlueZ 1/1] bap: Fix bcast endpoint config
> 
> Hi Iulia,
> 
> On Fri, Jan 19, 2024 at 10:04 AM Iulia Tanasescu
> <iulia.tanasescu@nxp.com> wrote:
> >
> > This updates the way broadcast is differentiated from unicast
> > at endpoint configuration: Instead of checking if setup->base
> > is allocated, check lpac type.
> >
> > ---
> >  profiles/audio/bap.c | 39 ++++++++++++++++++---------------------
> >  1 file changed, 18 insertions(+), 21 deletions(-)
> >
> > diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
> > index b88876485..137ed7d39 100644
> > --- a/profiles/audio/bap.c
> > +++ b/profiles/audio/bap.c
> > @@ -4,7 +4,7 @@
> >   *  BlueZ - Bluetooth protocol stack for Linux
> >   *
> >   *  Copyright (C) 2022  Intel Corporation. All rights reserved.
> > - *  Copyright 2023 NXP
> > + *  Copyright 2023-2024 NXP
> >   *
> >   *
> >   */
> > @@ -617,15 +617,16 @@ static int parse_bcast_qos(const char *key, int
> var, DBusMessageIter *iter,
> >         return 0;
> >  }
> >
> > -static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
> > -                       struct iovec **base)
> > +static int parse_qos(DBusMessageIter *iter, uint8_t pac_type,
> > +                               struct bt_bap_qos *qos)
> >  {
> >         DBusMessageIter array;
> >         const char *key;
> >         int (*parser)(const char *key, int var, DBusMessageIter *iter,
> >                         struct bt_bap_qos *qos);
> >
> > -       if (*base)
> > +       if ((pac_type == BT_BAP_BCAST_SOURCE) ||
> > +               (pac_type == BT_BAP_BCAST_SINK))
> >                 parser = parse_bcast_qos;
> >         else
> >                 parser = parse_ucast_qos;
> > @@ -656,9 +657,9 @@ static int parse_qos(DBusMessageIter *iter, struct
> bt_bap_qos *qos,
> >         return 0;
> >  }
> >
> > -static int parse_configuration(DBusMessageIter *props, struct iovec
> **caps,
> > -                               struct iovec **metadata, struct iovec **base,
> > -                               struct bt_bap_qos *qos)
> > +static int parse_configuration(DBusMessageIter *props, uint8_t pac_type,
> > +                               struct iovec **caps, struct iovec **metadata,
> > +                               struct iovec **base, struct bt_bap_qos *qos)
> >  {
> >         const char *key;
> >         struct iovec iov;
> > @@ -686,6 +687,12 @@ static int parse_configuration(DBusMessageIter
> *props, struct iovec **caps,
> >
> >                         util_iov_free(*caps, 1);
> >                         *caps = util_iov_dup(&iov, 1);
> > +
> > +                       /* Currently, the base iovec only duplicates
> > +                        * setup->caps. TODO: Dynamically generate
> > +                        * base using received caps.
> > +                        */
> > +                       *base = util_iov_dup(*caps, 1);
> >                 } else if (!strcasecmp(key, "Metadata")) {
> >                         if (var != DBUS_TYPE_ARRAY)
> >                                 goto fail;
> > @@ -699,24 +706,13 @@ static int parse_configuration(DBusMessageIter
> *props, struct iovec **caps,
> >                         if (var != DBUS_TYPE_ARRAY)
> >                                 goto fail;
> >
> > -                       if (parse_qos(&value, qos, base))
> > +                       if (parse_qos(&value, pac_type, qos))
> >                                 goto fail;
> >                 }
> >
> >                 dbus_message_iter_next(props);
> >         }
> >
> > -       if (*base) {
> > -               uint32_t presDelay;
> > -               uint8_t numSubgroups, numBis;
> > -               struct bt_bap_codec codec;
> > -
> > -               util_iov_memcpy(*base, (*caps)->iov_base, (*caps)->iov_len);
> > -               parse_base((*caps)->iov_base, (*caps)->iov_len, bap_debug,
> > -                       &presDelay, &numSubgroups, &numBis, &codec,
> > -                       caps, NULL);
> > -       }
> > -
> >         return 0;
> >
> >  fail:
> > @@ -882,8 +878,9 @@ static DBusMessage
> *set_configuration(DBusConnection *conn, DBusMessage *msg,
> >                 setup->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
> >         }
> >
> > -       if (parse_configuration(&props, &setup->caps, &setup->metadata,
> > -                               &setup->base, &setup->qos) < 0) {
> > +       if (parse_configuration(&props, bt_bap_pac_get_type(ep->lpac),
> > +                               &setup->caps, &setup->metadata, &setup->base,
> > +                               &setup->qos) < 0) {
> >                 DBG("Unable to parse configuration");
> >                 setup_free(setup);
> >                 return btd_error_invalid_args(msg);
> > --
> > 2.39.2
> 
> I sort of did the same thing but end up refactoring the code in the process:
> 
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatch
> work.kernel.org%2Fproject%2Fbluetooth%2Flist%2F%3Fseries%3D817943&d
> ata=05%7C02%7Ciulia.tanasescu%40nxp.com%7Cdb1ba6b2414f4919bd7008
> dc190103cf%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6384127
> 39344015066%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata
> =ZlnSGD6GfP8JTCbNPkRck%2FAfUp4a5uKBnzg9ANpg7B4%3D&reserved=0
> 
> So it's worth checking if I didn't break it further.

I tested and it looks ok.

> 
> --
> Luiz Augusto von Dentz

Regards,
Iulia

