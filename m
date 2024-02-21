Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2054.outbound.protection.outlook.com [40.107.14.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005A81752
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530876; cv=fail; b=WN/bzP2wW998WWiUp4TT8ZVbxbmiu7nKe9M4NrpG4yRVEZ7JIWKNGzbpiUzqS7V+vncKUnOuYJ0Z3D48qxpdzaeDIsgvv8IM1QkuGKwkh+BlD5wBTNWV66qjepPz8CqL7Q99aZxtUnrJoTRbhkLC8DmB6D2+wdscsRRY8d6HS20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530876; c=relaxed/simple;
	bh=VKn0HPkz+C+AaLiC50cYXAQazgaELMj3bKauu79xJ8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rz5tBpUak2bRFSRzPBxwS9dfY/ek63D1dPzZrgtp741jnZdeVSxwG/+ruxq6tRpKJ1T32++XYpTvTKFxRuM/WpmfHulOmM6WudnQdxCESxSRqDCqdMPpOh6nIbJiy2yM835OA7mVzZ7UzqFfi0AfR+vs0jHIKe0OZVTjwLZeviA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=irp3ueIG; arc=fail smtp.client-ip=40.107.14.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="irp3ueIG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG+wSKN/3JjDEbBWl8z8Fz0Wd4eIH3Klw70M/WJK4p8OvKuiBnBMVpeC1HzTYY7uyNe2Cw8SUfZsr1gyYH6RmSVb7qZ+7BBNNIrHntBTkBzGsUSUC2sNzNmkRWFf59Y7sp45IA02alJeziQJ1KyT15xzDOxSfQxV0jPp5LvH6DUDjpWdE43FlVYp65Fc9LzLI1s5qZg8HbH7f480bU8Y94VHZU55dPLlIkoo2/MgAZP8s4EO+Fzr4/KpAyBt3c+a/0LikCHBvfCWYwq5bp4AuhaqjnUVlm+2AmZ2+in0MFYQdNkVlWYxMENNj8uicskjVQmbCXgM+HY68EaspbKLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rdR1HUbOEoXgnkxHyKRXruTsxJxmLRXu/LAnwyeQKzU=;
 b=O2jhBqRSU5xZsmf2xGlv+l3P4zxS1HAFamFzw+3RL4Y567/snTk6WFiziIdy4sdW3vzr7RzpOrVnrNd9C8E0dngn0RokxyWOXM8N0C7M35uD61NUB0PEmx+TiLkWQUrqvxa8J6N1khezWfnmeeWN7fnFVwqM6j78PEzyq2h7Y3yPrtax6ih7GFRwA3Dd4A2YGbZh+MO2pjqK/YLpvj+uTsThoM4+sDCvm70NvhqEC7HCTWRyv5Of+GdmwQgP9pQ7l3mkWGjwJey0vZ3K1XBKBYf1KgJ9JC2TsszLQ5oRNXWjvcuRkDSFgY8osLfrPKOTGfgMpaXd1c0k1/VPFntaBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rdR1HUbOEoXgnkxHyKRXruTsxJxmLRXu/LAnwyeQKzU=;
 b=irp3ueIGavhciZiOF8fT/4EKpFSxC3uwkUszrK8CShGAxTbUrmvVNirL/lUGzhyvHPa00HlHgFzrUOzbMF0Oz5t0a2wrGsEXDTV2lJHr6it3VD0WEHjqRBZnMM9yI+Eeja2id7TKhLRMoDoYMShGcf0pB9D8X7S/3HqFGIpgmn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 21 Feb
 2024 15:54:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7292.029; Wed, 21 Feb 2024
 15:54:30 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com
Subject: Re: [RFC] Bluetooth: ISO: Reassemble fragmented BASE
Date: Wed, 21 Feb 2024 17:54:26 +0200
Message-Id: <20240221155426.3062-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZKB5DVODNrqxKzJ4=G=gdwRZ+RM_S-hZFeii+VqAPadCA@mail.gmail.com>
References: <CABBYNZKB5DVODNrqxKzJ4=G=gdwRZ+RM_S-hZFeii+VqAPadCA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0202CA0011.eurprd02.prod.outlook.com
 (2603:10a6:803:14::24) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7874:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5384c7-5e3a-4998-bf7a-08dc32f563f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3B+5bGeQHUd0yNSujzXba9wmI9d4KbdOi2VYfS73d/uTf1vc+QI+b+yt16aBPGe6I/AYwriSMH7DHboG/FXqjztsbDx5tXS+RguRieGb5YuOmvhvchJdQ58XS490yeMqhl4RtY14nSporautT+/Z9R0LlFx+HbTVeeeBStnL7vtQhq3algbhtdHa8PlPSyJEiIfB29gaYZjHSWGOueESfrmilcdxzWGeDGbdIgX2xdM0EbZPgOuHbpXkz/CRAOAs84QXJzgyKIxoZiZgmbf9DZUUD0qYTo07bThGTySbOX30ufEEwbxP7UROnnjaOYsiO289nLr4OO/jnRKEkNFEAqAi/id3+WZPPd2yC1tzh3HJDIEqmU5mYViSoQ/O3B6BMouKRDvl0av1GwaeaAvPeh+g1hfO9O6uTI3MF+ByQAt6rdNsXbctkbbElQd170glydYtPWaHWpc3HvvMw0wlvGPtxKHx5hrixtlant4LyOO6eh4nSE/UJVzaiBipEtnIpFJfGIzdCF/3WL7xfnlw22/G2TNB7NWEaoKJ4px8rVE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CKAXNewgbVuO9dIvbPz+Yi29FeZkmG//SJFtrhb9uQvwFHPa3A20v6qvbscF?=
 =?us-ascii?Q?sy4n90LfdLWJ/8CXUG3daAyevX9YRK1/O6jOwBJK7oprIF9Mv1n4S0x7SOgc?=
 =?us-ascii?Q?La24q0WYuvDWiwI061hDjg9MvAg5g6uPrw7/CX6sy1w3Kd9Lg/8n7FJo6pRj?=
 =?us-ascii?Q?i3pvC7xMIS+lN77mOF906uqnDi5lZNcwdqu7mJNy8iTnBIbLBb7DO3Rh0fe9?=
 =?us-ascii?Q?TR7O0NjqKe4u9IMITuK/e1Ol7UuQ0YIRic22SXPyEt9OwR86PaIQBhFfkiSE?=
 =?us-ascii?Q?iW05+BhQktu8OCVExgreqdv9dno1FZdH119jzTxuNbm8JhYH64scAWfSneDh?=
 =?us-ascii?Q?v4m+RBjUsb/3Led2MGQr5eY3pH7lx4Ptkmyuz8SHN5ilEk33so1I+q+ICSrX?=
 =?us-ascii?Q?cDZs6/xvuw9bHEqDXP+LyQNssgCl7afnRkGSObh8BlOHMKNTZ9FXRWqpEcoF?=
 =?us-ascii?Q?r/XjIcKUgjbjOrYH2lP0Ecx/QGs65/Gxo+LOM1ml6Uw7tU+lKBKOaPNe7Vz6?=
 =?us-ascii?Q?R7O7OzaXE6PmAzQeenc+6kNp1VnqDUzTFu4MNlRz1kuXzhU19186j2ZVKQOG?=
 =?us-ascii?Q?xOzyU1LB936JhDMQnpsi7m4vDbOB8e8PgOGVM9EeMZmOnNYVIPs0DBX62riN?=
 =?us-ascii?Q?HgAjRoniqMmWxXWP8jeW0Ac8L4NrTye+hY3moekItnyckhy3L9SOxLNBa8x/?=
 =?us-ascii?Q?ipz5n7csUsVpmwy37e78T4vL6e+HEXMrl+L99CJHBjPcDrbCN+8BSWIhqUNj?=
 =?us-ascii?Q?CCxh3Cyan5O4SXzKXcPRnRQM48ogUdyskZmlqpUp8pOnHgFT946IczsLQoer?=
 =?us-ascii?Q?TQxEHCI01+VJiOaQIUe5o+LIUAsUhvounz3BFa8ckeFMyWT9y7XuEMDTeNMa?=
 =?us-ascii?Q?Or+etA8/YcX+pL5na9fnQGEGFpWLUmC0DAJccWYCcUIlREHIuzPjCb1qDjaN?=
 =?us-ascii?Q?D+cmreS9L922uT+NLgzbVgoNcVCwEgaJvMUFFF8lqxdjXcjHWZ74WiExrm8k?=
 =?us-ascii?Q?Fitubu1gJxHeME22Q65Q8gwaL9pu1Lzy8r7oqCB458Nu4hSh3Q1vcJsToTMv?=
 =?us-ascii?Q?YWjtm0nzmdWHz6ofe002S2ck0zH+TyfQYnWTK+wN042JzySmnBcD2GoVqn2s?=
 =?us-ascii?Q?IMSt6OKuAd9Is7p5G7ct2AVCQ434C7pE9+N1ZeFQF52flFUSh8BMYWj1dc6M?=
 =?us-ascii?Q?c3xLukQH4hmTcfYzganAX9v1nV8Ba1lLjZFcs6bBjx4ONQPM7lXZlNEG9BpG?=
 =?us-ascii?Q?oJDO2sy4i+aQvhgOrSSIDCDBgwC5li0ou12z8Ni7+U7Z5nveobbOskh7/2w0?=
 =?us-ascii?Q?3JQD2KZJwdx17Y77CTFr7AB+BnFIC5K8QiWq44PhTZ+AWM8tLKy4ICEC1mMk?=
 =?us-ascii?Q?wkKYH0EQ0lNrrot/iddWQl+0riHUa3Q2UWRB/H0hWmRsMRNiRnjuafFvsVHr?=
 =?us-ascii?Q?LvUVQTxexvMjnGfnAV/ZGdNc/u6E7kQF4mhQpRt8HVPXej5V004PBMZMfSCd?=
 =?us-ascii?Q?nypLik7Gh4IN8QJtbLW5/DLweSEA5sm+et6hp7ClT0v1/cTtydxA6O8Sfzy1?=
 =?us-ascii?Q?qPbHlZYRjfN5pEeYLFb8uAriD8NarKniNh3Xg9imJsBRSVq6A8hjbOLd2Dri?=
 =?us-ascii?Q?Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5384c7-5e3a-4998-bf7a-08dc32f563f7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 15:54:30.6824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mfr9ryCb9QdBtJeFx+JHQeI/IO42KJDaxNmyQqWU3I1jy97pUPAnAeCEGAMz5kVs+3Ogl+/MuL3pZ5UqxCFGRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7874

Hi Luiz,

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Wednesday, February 21, 2024 4:44 PM
> To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> octavian.urzica@nxp.com>; Silviu Florian Barbulescu
> <silviu.barbulescu@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> Andrei Istodorescu <andrei.istodorescu@nxp.com>
> Subject: Re: [RFC] Bluetooth: ISO: Reassemble fragmented BASE
> 
> Hi Iulia,
> 
> On Tue, Feb 20, 2024 at 11:35 AM Iulia Tanasescu
> <iulia.tanasescu@nxp.com> wrote:
> >
> > For a Broadcast Sink, this adds support for reassembling fragmented PA
> > data. This is needed if the BASE comes fragmented in multiple PA reports.
> > After all PA fragments have been reassembled, the BASE can be retrieved
> > by the user via getsockopt.
> >
> > PA fragments could be reassembled inside hci_event.c and a complete PA
> > report could be indicated to iso.c, or like it is currently, if PA
> > fragments are indicated separately, reassembly would need to be done in
> > iso.c.
> >
> > For a Broadcast Source, the user sets the BASE via setsockopt. The full
> > PA data is built at bis bind, inside conn->le_per_adv_data. This array
> > would be fit to hold the reassembled PA data on the Sink side as well,
> > but a listening socket does not have an associated hcon...Currently for
> > the Broadcast Sink, a hcon is created only after the first BIGInfo report,
> > which arrives after the PA sync established event and all initial PA
> > reports. The hcon is notified to iso.c, a child socket is created and it
> > is notified to userspace, to mark the PA sync step as completed.
> >
> > I see 2 possibilities:
> >
> > 1. Keep a pa_data array inside the iso sock struct, use it to reassemble
> > PA fragments, and extract BASE from it when needed.
> >
> > 2. Instead of creating the hcon after the first BIGInfo report, the hcon
> > could be created when the PA sync established event is received. The
> > le_per_adv_data can be used to reassemble the PA fragments, and the
> hcon
> > will be notified to iso.c after the first BIGInfo report, when all
> > information necessary to create and populate the child socket is
> > available.
> >
> > In this patch I am showing the first idea, but I think the second one
> > may provide a design more in line with the broadcast source scenario,
> > when handling PA data and BASE.
> >
> > Are there any opinions about this?
> 
> I was actually going to ask about why we don't have an hcon at the
> early stages of PA Sync, Im doing some optimizations so we scan based
> on the QoS PHY which should be faster than scanning in all support
> PHYs like we do today, but at that point there is no hcon and
> therefore the is no visible QoS since the socket info is not public.

I agree, so similar to iso_connect_bis, I will create a hcon for the
parent socket at iso_listen_bis, and I will use hcon->le_per_adv_data
to reassemble PA reports.

> 
> > Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > ---
> >  include/net/bluetooth/hci.h |  7 +++-
> >  net/bluetooth/iso.c         | 79 +++++++++++++++++++++++++++----------
> >  2 files changed, 64 insertions(+), 22 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index 08cb5cb249a4..a856e88719d2 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -1,7 +1,7 @@
> >  /*
> >     BlueZ - Bluetooth protocol stack for Linux
> >     Copyright (C) 2000-2001 Qualcomm Incorporated
> > -   Copyright 2023 NXP
> > +   Copyright 2023-2024 NXP
> >
> >     Written 2000,2001 by Maxim Krasnyansky <maxk@qualcomm.com>
> >
> > @@ -2037,6 +2037,7 @@ struct hci_cp_le_set_per_adv_params {
> >  } __packed;
> >
> >  #define HCI_MAX_PER_AD_LENGTH  252
> > +#define HCI_MAX_PER_AD_TOT_LENGTH      1650
> >
> >  #define HCI_OP_LE_SET_PER_ADV_DATA             0x203f
> >  struct hci_cp_le_set_per_adv_data {
> > @@ -2797,6 +2798,10 @@ struct hci_ev_le_per_adv_report {
> >         __u8     data[];
> >  } __packed;
> >
> > +#define LE_PA_DATA_COMPLETE    0x00
> > +#define LE_PA_DATA_MORE_TO_COME        0x01
> > +#define LE_PA_DATA_TRUNCATED   0x02
> > +
> >  #define HCI_EV_LE_EXT_ADV_SET_TERM     0x12
> >  struct hci_evt_le_ext_adv_set_term {
> >         __u8    status;
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 04f6572d35f1..e9a3b4f74e2f 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -3,7 +3,7 @@
> >   * BlueZ - Bluetooth protocol stack for Linux
> >   *
> >   * Copyright (C) 2022 Intel Corporation
> > - * Copyright 2023 NXP
> > + * Copyright 2023-2024 NXP
> >   */
> >
> >  #include <linux/module.h>
> > @@ -70,8 +70,15 @@ struct iso_pinfo {
> >         unsigned long           flags;
> >         struct bt_iso_qos       qos;
> >         bool                    qos_user_set;
> > -       __u8                    base_len;
> > -       __u8                    base[BASE_MAX_LENGTH];
> > +       union {
> > +               __u8            base_len;
> > +               __u16           pa_data_len;
> > +       };
> > +       union {
> > +               __u8            base[BASE_MAX_LENGTH];
> > +               __u8            pa_data[HCI_MAX_PER_AD_TOT_LENGTH];
> > +       };
> > +       __u16                   pa_data_offset;
> >         struct iso_conn         *conn;
> >  };
> >
> > @@ -1573,7 +1580,7 @@ static int iso_sock_getsockopt(struct socket
> *sock, int level, int optname,
> >         struct sock *sk = sock->sk;
> >         int len, err = 0;
> >         struct bt_iso_qos *qos;
> > -       u8 base_len;
> > +       size_t base_len;
> >         u8 *base;
> >
> >         BT_DBG("sk %p", sk);
> > @@ -1612,13 +1619,20 @@ static int iso_sock_getsockopt(struct socket
> *sock, int level, int optname,
> >                 break;
> >
> >         case BT_ISO_BASE:
> > -               if (sk->sk_state == BT_CONNECTED &&
> > -                   !bacmp(&iso_pi(sk)->dst, BDADDR_ANY)) {
> > -                       base_len = iso_pi(sk)->conn->hcon->le_per_adv_data_len;
> > -                       base = iso_pi(sk)->conn->hcon->le_per_adv_data;
> > -               } else {
> > +               if (!bacmp(&iso_pi(sk)->dst, BDADDR_ANY)) {
> > +                       /* For a Broadcast Source, the BASE was stored
> > +                        * in iso_pi(sk)->base.
> > +                        */
> >                         base_len = iso_pi(sk)->base_len;
> >                         base = iso_pi(sk)->base;
> > +               } else {
> > +                       /* For a Broadcast Sink, the complete data received in
> > +                        * PA reports is stored. Extract BASE from there.
> > +                        */
> > +                       base = eir_get_service_data(iso_pi(sk)->pa_data,
> > +                                                   iso_pi(sk)->pa_data_len,
> > +                                                   EIR_BAA_SERVICE_UUID,
> > +                                                   &base_len);
> >                 }
> >
> >                 len = min_t(unsigned int, len, base_len);
> > @@ -1834,8 +1848,9 @@ static void iso_conn_ready(struct iso_conn
> *conn)
> >                 bacpy(&iso_pi(sk)->dst, &hcon->dst);
> >                 iso_pi(sk)->dst_type = hcon->dst_type;
> >                 iso_pi(sk)->sync_handle = iso_pi(parent)->sync_handle;
> > -               memcpy(iso_pi(sk)->base, iso_pi(parent)->base, iso_pi(parent)-
> >base_len);
> > -               iso_pi(sk)->base_len = iso_pi(parent)->base_len;
> > +               memcpy(iso_pi(sk)->pa_data, iso_pi(parent)->pa_data,
> > +                      iso_pi(parent)->pa_data_len);
> > +               iso_pi(sk)->pa_data_len = iso_pi(parent)->pa_data_len;
> >
> >                 hci_conn_hold(hcon);
> >                 iso_chan_add(conn, sk, parent);
> > @@ -1904,8 +1919,8 @@ int iso_connect_ind(struct hci_dev *hdev,
> bdaddr_t *bdaddr, __u8 *flags)
> >          * a BIG Info it attempts to check if there any listening socket with
> >          * the same sync_handle and if it does then attempt to create a sync.
> >          * 3. HCI_EV_LE_PER_ADV_REPORT: When a PA report is received, it is
> stored
> > -        * in iso_pi(sk)->base so it can be passed up to user, in the case of a
> > -        * broadcast sink.
> > +        * in iso_pi(sk)->pa_data so the BASE can later be passed up to user, in
> > +        * the case of a broadcast sink.
> >          */
> >         ev1 = hci_recv_event_data(hdev, HCI_EV_LE_PA_SYNC_ESTABLISHED);
> >         if (ev1) {
> > @@ -1961,16 +1976,38 @@ int iso_connect_ind(struct hci_dev *hdev,
> bdaddr_t *bdaddr, __u8 *flags)
> >
> >         ev3 = hci_recv_event_data(hdev, HCI_EV_LE_PER_ADV_REPORT);
> >         if (ev3) {
> > -               size_t base_len = ev3->length;
> > -               u8 *base;
> > -
> >                 sk = iso_get_sock_listen(&hdev->bdaddr, bdaddr,
> >                                          iso_match_sync_handle_pa_report, ev3);
> > -               base = eir_get_service_data(ev3->data, ev3->length,
> > -                                           EIR_BAA_SERVICE_UUID, &base_len);
> > -               if (base && sk && base_len <= sizeof(iso_pi(sk)->base)) {
> > -                       memcpy(iso_pi(sk)->base, base, base_len);
> > -                       iso_pi(sk)->base_len = base_len;
> > +
> > +               if (!sk)
> > +                       goto done;
> > +
> > +               if (ev3->data_status == LE_PA_DATA_TRUNCATED) {
> > +                       /* The controller was unable to retrieve PA data. */
> > +                       memset(iso_pi(sk)->pa_data, 0,
> > +                              HCI_MAX_PER_AD_TOT_LENGTH);
> > +                       iso_pi(sk)->pa_data_len = 0;
> > +                       iso_pi(sk)->pa_data_offset = 0;
> > +                       return lm;
> > +               }
> > +
> > +               if (iso_pi(sk)->pa_data_offset + ev3->length >
> > +                   HCI_MAX_PER_AD_TOT_LENGTH)
> > +                       goto done;
> > +
> > +               memcpy(iso_pi(sk)->pa_data + iso_pi(sk)->pa_data_offset,
> > +                      ev3->data, ev3->length);
> > +               iso_pi(sk)->pa_data_offset += ev3->length;
> > +
> > +               if (ev3->data_status == LE_PA_DATA_COMPLETE) {
> > +                       /* All PA data has been received. */
> > +                       iso_pi(sk)->pa_data_len = iso_pi(sk)->pa_data_offset;
> > +                       iso_pi(sk)->pa_data_offset = 0;
> > +               } else {
> > +                       /* This is a PA data fragment. Keep pa_data_len set to 0
> > +                        * until all data has been reassembled.
> > +                        */
> > +                       iso_pi(sk)->pa_data_len  = 0;
> >                 }
> >         } else {
> >                 sk = iso_get_sock_listen(&hdev->bdaddr, BDADDR_ANY, NULL,
> NULL);
> > --
> > 2.39.2
> >
> 
> 
> --
> Luiz Augusto von Dentz

Regards,
Iulia
