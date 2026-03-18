Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011025.outbound.protection.outlook.com [40.107.130.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6950122541C
	for <linux-bluetooth@vger.kernel.org>; Wed, 18 Mar 2026 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773840797; cv=fail; b=OoP53/Wy+iZxO9IhXimDHwqBnA1Xm6j1YJx2x8UNykD3jVhH5pIDyDRZVv9S3F0zdp4uuvaPVO7thbvEVnTwYA1kGpSivIP5TxoPxywldF9IsfURypLBC9NngVPgsrgmIAGOTY97AnOrKPu4itFJFuZbCl0iL7xDFoz0+kyEeeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773840797; c=relaxed/simple;
	bh=qp2yXaOnrs7mLE3b7XASZtlkjyNoS0M9/nKwv+Zwydo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d/Xcr9cu1N8+FGvHHCXR4KES/5YVTp/9E7trkU7xxjGJ3cs7/4/9/wopYtjJAxF/7xmd6IRp5HBGRg0f/P3TzmkgYue8FrB8rnmOL6QgViZGNi04HVIhVf1f8w0X31t32aYOabhpeLRXIHbUpJmg0IE8nmO4zbnVnmiv2pc+kbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=q/YtlLGk; arc=fail smtp.client-ip=40.107.130.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="q/YtlLGk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAJIzpdXcjPziI8ygMr6MrTScIogUN6fGJJ1l6EveYPKZrx1yIYpGLVp93AOsTxayPFwXKBP+ljxBTvfMAHMIij69GWmbz1eJlh1hDWZpWMQ3vJpleqyCfuQXVCJVgXqy+7OgkbuwBw6nomZu7OVY0neTgTkf6bejlgt/C7Y48XRC70JiBu5sZnNpjKTZ3pA7GAQ0UcOTZ6YnobcTDvn7G+5TOdpFINyFfrnLx9kCcTwZPqR3ZtfibMstYO2jGiEnbqj/sYlvv5hczjmbsLEMuL1J47j+SvKFFoek6x7ie/V0VMcHPJo51i4YZ1cQfYMI4badU8wdJsG6X/2mIOBVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYdUdp1pwocldBTfagHBdpBGzcOH5XS6K9G5CYXuOcA=;
 b=QdBOoeo27rwYB4DhHrZDVCii8M4tVq8No1cXN9EJJD5yr9AQhZcUTa1glQqFdjFvBGZaHyq3aQ18NB0b55zCX7vvWVoGz+okKhtXCjsiKo5+IsC2HuX+bPu4d/fVwJ5b7c7ULRId+mI/CYssbqjXDpRjHANsnFzRoxOsi6MpCTf0cjvmpRiSrNFLUSESpcc1t0XykCzNWtqCLhb2qPBJcZb5VzDw9CnsOlw55UAtBCGzwSgxr8embudsPaYfHMserzgHamibaKaQ2R2BrKaOMDH6WNIMLOHkrWR1GnJ3CoABgA5omOPT0KDojuwKGA7U7zsKMgVCFjJox33p1UJp6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYdUdp1pwocldBTfagHBdpBGzcOH5XS6K9G5CYXuOcA=;
 b=q/YtlLGk4wuBK3zDavi7rf3G/y0/i5Maf5eY8IbdluCW9+L2UgPWDrJUmSojOXPEMmwEvTLFb5FYkKZl3vwfNwSDRS5HB5SlxvsxvVVgUwSciuW1duFsaP0Seucn09br1Qmk2b2vYfjIYB6zXy9bw6aqOD9mZglaEEqk2YXdFME=
Received: from AS4P251CA0030.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::18)
 by GV2PR03MB8607.eurprd03.prod.outlook.com (2603:10a6:150:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 13:33:05 +0000
Received: from AMS1EPF00000044.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::25) by AS4P251CA0030.outlook.office365.com
 (2603:10a6:20b:5d3::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 13:33:05 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS1EPF00000044.mail.protection.outlook.com (10.167.16.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 13:33:05 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 18 Mar
 2026 14:33:05 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Fix regressions caused by reusing ident
Date: Wed, 18 Mar 2026 14:33:04 +0100
Message-ID: <2351187.vFx2qVVIhK@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZLJe1CkOntxtvRUviTZwo4=O_x3jn9EM_8AYBN9ojPBfA@mail.gmail.com>
References: <20260317160258.194853-1-luiz.dentz@gmail.com>
 <CABBYNZLJe1CkOntxtvRUviTZwo4=O_x3jn9EM_8AYBN9ojPBfA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000044:EE_|GV2PR03MB8607:EE_
X-MS-Office365-Filtering-Correlation-Id: c1845791-3d8c-4322-9619-08de84f2e2de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|13003099007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	GjVsCxv24CKCJSE4ufTUyZ7hSNAIF6HB7huuCQUQcglp+TgpIC2zyczhZfxOrnDpYUH6lsypog74wJarEWm1fxuwWFYDBL2MTmOVD5B9xtWQvrPOEKNZ4tjLaAIDszV1puhWsNuPhVLEJR288JXdnlZe5ofbARzVReKdFSnOyrh7vlU7YWr47BPkqM21toeLCLeaoUAicsWANOZPslhVPVzDt/x+5pwv7z7UWZI69wyz9Kwgu5t1a61Ubph+6aJSo2aDE+kUcWhnRPP5mCX06B9eAesFQi2io9QY+j7+pKR3ACPwyBcrlFgB1zj7nHH+XJqcIZilYVBLyXPUy306iPeNPBdSqRsYXPDIzlpC1qMiw66RhEuPHeZFussEEGFkc/5F+F0iuzlTJ8iV5B2SIY6OecRvHgG26a8fp0NmxFW5ropgiZEaS3fzuzBdEwLEym7gY5dNtuyIO+LcIM3PcStSMAZs4sIsU7Z9kaLgT+evCvej1E1QzwZLj00W6Mdl6ea1QXgtC9fwAX4CHQQwmvlmara4ELFIBBSEQd9EAXBJp65LkM1LfYCTam3cxbEkRzdeg5dJxvBFGBNOSEsrdQHzJe15n1xrs2T/mA4Rfzj3z3aHynbjcTr4m8yB3s0+1E1wK4SZoD40+dX0fQV4GmT56sTldHZ/DKk/ESdLDxM0qJtdcq9SE+SzZYh+xsRFQAug9wxZblbHYj6ms+fQg6giwTdB6+PKlZFwzGUAoDClPvd410JzJG1vAeBvJX26oZI6584fYux9ABIqbVmivQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(13003099007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FF0NBCrmLYbTGgfd5Xz4N+Kjdr9uvscc28/mPLZmc421RMg2KRH0C5CFCHri+XUhcpfhSkIwfA3VUENMb+p9sRgvsdqj96srTqzgBzW9dVzVSwo5QhtepGBG/GmO3hJbLTvGu2p1s21FWpDl30ffmH1s8g8R5QrDUNSkQLMXFJhszWHYOb8WkcUr6CJMs7WVbnqEb3oEnmwH/eCksNgylwcIYtuIFJxkWFlTuu8AAE1POPEyJDkEhMzPoKQbGDyeL0xuzgnD8HcWIfeNK8u3qvcpqzkfosOGQ9Ef95Bq3Z80rMZD2K+DI6WJrZ+GscG6ozG5yC+53ufXRCTgxyj1v1h2RdYJcfL1wfbxyuNikuWPTABaAjNqVVmslNcxaIRJ8aJLDbpsswrfQNR8Yu5RDD6HX3mUcUJlXOVWokhr8kgVtTBa5diC90Nkt781Oghu
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:33:05.5916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1845791-3d8c-4322-9619-08de84f2e2de
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8607

Hi Luiz,

On Tuesday, 17 March 2026, 18:57:27 CET, Luiz Augusto von Dentz wrote:
> Hi Christian,
>=20
> On Tue, Mar 17, 2026 at 12:03=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > This attempt to fix regressions caused by reusing ident which apparently
> > is not handled well on certain stacks causing the stack to not respond =
to
> > requests, so instead of simple returning the first unallocated id this
> > stores the last used tx_ident and then attempt to use the next until all
> > available ids are exausted and then cycle starting over to 1.
> >
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221120
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221177
> > Fixes: 6c3ea155e5ee ("Bluetooth: L2CAP: Fix not tracking outstanding TX=
 ident")
> > Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > ---
> >  include/net/bluetooth/l2cap.h |  1 +
> >  net/bluetooth/l2cap_core.c    | 39 +++++++++++++++++++++++++++--------
> >  2 files changed, 31 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2ca=
p.h
> > index 010f1a8fd15f..5172afee5494 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -658,6 +658,7 @@ struct l2cap_conn {
> >         struct sk_buff          *rx_skb;
> >         __u32                   rx_len;
> >         struct ida              tx_ida;
> > +       __u8                    tx_ident;
> >
> >         struct sk_buff_head     pending_rx;
> >         struct work_struct      pending_rx_work;
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index ead51dc0f3f1..4dbd7b1bd72f 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -926,16 +926,37 @@ int l2cap_chan_check_security(struct l2cap_chan *=
chan, bool initiator)
> >
> >  static int l2cap_get_ident(struct l2cap_conn *conn)
> >  {
> > -       /* LE link does not support tools like l2ping so use the full r=
ange */
> > -       if (conn->hcon->type =3D=3D LE_LINK)
> > -               return ida_alloc_range(&conn->tx_ida, 1, 255, GFP_ATOMI=
C);
> > +       int ident;
> >
> > -       /* Get next available identificator.
> > -        *    1 - 128 are used by kernel.
> > -        *  129 - 199 are reserved.
> > -        *  200 - 254 are used by utilities like l2ping, etc.
> > -        */
> > -       return ida_alloc_range(&conn->tx_ida, 1, 128, GFP_ATOMIC);
> > +       /* LE link does not support tools like l2ping so use the full r=
ange */
> > +       if (conn->hcon->type =3D=3D LE_LINK) {
> > +               /* Allocate ident using min as last used + 1 (cyclic) */
> > +               ident =3D ida_alloc_range(&conn->tx_ida, ++conn->tx_ide=
nt,
> > +                                       255, GFP_ATOMIC);
> > +               /* Force min 1 to start over */
> > +               if (ident < 0)
> > +                       ident =3D ida_alloc_range(&conn->tx_ida, 1, 255,
> > +                                               GFP_ATOMIC);
> > +       } else {
> > +               /* Get next available identificator.
> > +                *    1 - 128 are used by kernel.
> > +                *  129 - 199 are reserved.
> > +                *  200 - 254 are used by utilities like l2ping, etc.
> > +                */
> > +
> > +               /* Allocate ident using min as last used + 1 (cyclic) */
> > +               ident =3D ida_alloc_range(&conn->tx_ida, ++conn->tx_ide=
nt,
> > +                                       128, GFP_ATOMIC);
> > +               /* Force min 1 to start over */
> > +               if (ident < 0)
> > +                       ident =3D ida_alloc_range(&conn->tx_ida, 1, 128,
> > +                                               GFP_ATOMIC);
> > +       }
> > +
> > +       if (ident > 0)
> > +               conn->tx_ident =3D ident;
> > +
> > +       return ident;
> >  }
> >
> >  static void l2cap_send_acl(struct l2cap_conn *conn, struct sk_buff *sk=
b,
> > --
> > 2.53.0
> >
>=20
> Do you have any capacity to test the above with L2CAP/COS/CED/BI-29-C?

Today my test system seems a little bit bitchy, so L2CAP/COS/CED/BI-29-C ev=
en
doesn't complete with my latest working version...

After applying this patch on top of my latest version (6.19.9 +=20
the BT patches I already submitted), I see a new error (log is below).
At 40344 ms, the connection request sent by the IUT has an identifier value=
 of
'0' (just after wrapping around) which is not a valid identifier as of=20
Core Vol 3, part A, chapter 4 (page 1122):

"Signaling identifier 0x00 is an invalid identifier and shall never be used=
 in any
command."

Any idea why the identifier used by the IUT wraps around from 255 to 0
instead of 1?

regards,
Christian



+40078 ms
Verdict Description:     Received CMD:LE Credit Based Connection REQ:=20
    Code: [20 (0x14)] Code
    Identifier: [254 (0xFE)]
    Length: [10 (0x000A)]
    SPSM: [128 (0x0080)]
    Source CID: [64 (0x0040)]
    MTU: [672 (0x02A0)]
    MPS: [23 (0x0017)]
    Initial Credits: [30 (0x001E)]



+40078 ms
Verdict Description:     Sent=3DLE Credit Based Connection RSP:=20
    Code: [21 (0x15)] Code
    Identifier: [0 (0x00)]
    Length: [10 (0x000A)]
    Destination CID: [79 (0x004F)]
    MTU: [64 (0x0040)]
    MPS: [64 (0x0040)]
    Initial Credits: [2 (0x0002)]
    Result: [0 (0x0000)] Connection Successful



+40078 ms
Send Event               HCI!ACL_DATA_REQ{
                           connectionHandle=3D0x0010,
                           boundary=3D0x00,
                           broadcasting=3D0x00,
                           length=3D0x0012,
                           p_data[0]=3D0x0E
                         }


+40250 ms
Receive Event            HCI?ACL_DATA{
                           connHandle=3D0x0010,
                           length=3D18,
                           boundaryFlag=3D0x02,
                           broadcastFlag=3D0x00
                         }


+40250 ms
Verdict Description:     ReceivePacket!
receive=3D0E00050014FF0A0080004000A00217001E00, CID=3D5



+40250 ms
Verdict Description:     Received CMD:LE Credit Based Connection REQ:=20
    Code: [20 (0x14)] Code
    Identifier: [255 (0xFF)]
    Length: [10 (0x000A)]
    SPSM: [128 (0x0080)]
    Source CID: [64 (0x0040)]
    MTU: [672 (0x02A0)]
    MPS: [23 (0x0017)]
    Initial Credits: [30 (0x001E)]



+40250 ms
Verdict Description:     Sent=3DLE Credit Based Connection RSP:=20
    Code: [21 (0x15)] Code
    Identifier: [0 (0x00)]
    Length: [10 (0x000A)]
    Destination CID: [80 (0x0050)]
    MTU: [64 (0x0040)]
    MPS: [64 (0x0040)]
    Initial Credits: [2 (0x0002)]
    Result: [0 (0x0000)] Connection Successful



+40250 ms
Send Event               HCI!ACL_DATA_REQ{
                           connectionHandle=3D0x0010,
                           boundary=3D0x00,
                           broadcasting=3D0x00,
                           length=3D0x0012,
                           p_data[0]=3D0x0E
                         }


+40344 ms
Receive Event            HCI?ACL_DATA{
                           connHandle=3D0x0010,
                           length=3D18,
                           boundaryFlag=3D0x02,
                           broadcastFlag=3D0x00
                         }


+40344 ms
Verdict Description:     ReceivePacket!
receive=3D0E00050014000A0080004000A00217001E00, CID=3D5



+40344 ms
Verdict Description:     Received CMD:LE Credit Based Connection REQ:=20
    Code: [20 (0x14)] Code
    Identifier: [0 (0x00)]
    Length: [10 (0x000A)]
    SPSM: [128 (0x0080)]
    Source CID: [64 (0x0040)]
    MTU: [672 (0x02A0)]
    MPS: [23 (0x0017)]
    Initial Credits: [30 (0x001E)]



+40344 ms
Verdict Description:     Sent=3DLE Credit Based Connection RSP:=20
    Code: [21 (0x15)] Code
    Identifier: [0 (0x00)]
    Length: [10 (0x000A)]
    Destination CID: [81 (0x0051)]
    MTU: [64 (0x0040)]
    MPS: [64 (0x0040)]
    Initial Credits: [2 (0x0002)]
    Result: [0 (0x0000)] Connection Successful



+40344 ms
Send Event               HCI!ACL_DATA_REQ{
                           connectionHandle=3D0x0010,
                           boundary=3D0x00,
                           broadcasting=3D0x00,
                           length=3D0x0012,
                           p_data[0]=3D0x0E
                         }


+40422 ms
Indecisive:              Received Identifier is not unique. Received=3D0



+40422 ms
Verdict Description:     Received Identifier is not unique. Received=3D0



+40625 ms
Send Event               HCI!HCI_RESET





