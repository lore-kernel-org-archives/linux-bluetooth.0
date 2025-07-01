Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011035.outbound.protection.outlook.com [52.101.65.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8395A272E48
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 19:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751398125; cv=fail; b=OxhAXw/rpLa7snnHmzighxzwGcFwJHJjDjpsTOSFrxp9mIfmlYKt7zCBaQSk63VccPgg0YaarHIidsa85J5jwmA/7LoJAbNf1zObn88O/+wAeBzPlNDRS/OpYQpGGjtHSBpcy6ZyqLpPAv/MM8VlfwHM/C7nZxjpFco6g0yAZn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751398125; c=relaxed/simple;
	bh=1fG4MbO5WKhXFKOcu2vRzYkA9lSbZkD/J/WbtyWsXyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlEBqUTBmQ822m3DdEIPTGwHcbntYHCe5Rwk6fxk93Y9+jHRqzxmo402knMVukB9qPA9K+HMxBpouKf2vHxnGQb/VCDizudHDb+MEaoRybmYC2hq47C4nRyYhaT17UQZRgOT5ay+B3rTGx5T9JR7Gy5BHKpSkZHvD6gLqoz6S+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=rHOV8bAb; arc=fail smtp.client-ip=52.101.65.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="rHOV8bAb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwjriFVSua3Z7yn1R+B2Xd8Y09i5/4nQrq/trlaLOLCL31LMdIopviD/ljV5PfOT42/97z0KlIEaD8s3inNb/IRlgPAPbHT57SzfzoyDNLfdtaoQ5IvsPCaH/SPCa8x6swASvtnqQbET0n7r4pP01PF/5fx4Z6TIw5BFZX2/5zAVeLHIq7Bui9DH896wc8l3IEe8P2/bN26fdqIrNSgVEHwS1fAFmgIVAX5gk5yItzFxkw16Ra7lItgF+262ITIbukmZghKegD0EpUsMCT6CrcUGK31Tg5uC3AtkHQ/qQwVz/xrkyGQ7JUujxEB3QbUECvkb63isRr6xStumYjPz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tys7tOmlmK9VXcjQZvma6nw2zgB6vkfJ8T8Qdx6WtJc=;
 b=bw5gax5I57rXnwiPbn8vCvW5nS3OZZBTH+CV2OLoc1ir2NtT+vqZyXBQbjVUyT6OKffZB433d6j8UxlQ4r5Ah33yAQTXTZ5F4/DcFzk8XIM95siJGKzF1YUpoJxLv0C2bCIgpw4DORgO8kFE9DZ5P8PE0KQ9W143LKtHJlPs52ifPYGeAfopOHuPX+35xaS/XGC+gRrMyMi+Y7nt+cVbByvaEHTTgstOWcJL7mij+JXeJ2F0MKtl6LrL0+khi9m+IARsfBae/KWHL5zG3FzYEPlIcH/xkYsyI4R4jzSb9wg6HjljA3Gg4wlqT3ps8/7xfFCDePtD8S8O9fmt1n9rhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tys7tOmlmK9VXcjQZvma6nw2zgB6vkfJ8T8Qdx6WtJc=;
 b=rHOV8bAbIJcKjl/vMl/L7kjRGnQTjA9G/idwJQ4/TJUepywVAi4H4GZ2FVOEdcTB1YGBrzCtSl3AS7yhLjTiW8J2hs1TWoBKmhrxR7OOtVrU2UbMnv/cFVpiU35Hzv5NPWzXu5R4wEwCo3GmiYvSZvjSbxFyJhK+rzr3qpffyFk=
Received: from AS8PR04CA0177.eurprd04.prod.outlook.com (2603:10a6:20b:331::32)
 by AM0PR03MB6289.eurprd03.prod.outlook.com (2603:10a6:20b:153::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Tue, 1 Jul
 2025 19:28:35 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:331:cafe::5e) by AS8PR04CA0177.outlook.office365.com
 (2603:10a6:20b:331::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.31 via Frontend Transport; Tue,
 1 Jul 2025 19:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 19:28:34 +0000
Received: from n9w6sw14.localnet (192.168.54.12) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.38; Tue, 1 Jul
 2025 21:28:34 +0200
From: Christian Eggers <ceggers@arri.de>
To: Brian Gix <brian.gix@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, Inga Stotland <inga.stotland@gmail.com>
Subject: Re: [RFC PATCH BlueZ 3/4] mesh: add GATT proxy service
Date: Tue, 1 Jul 2025 21:28:33 +0200
Message-ID: <22176325.4csPzL39Zc@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABUQxGwt8MjoYmx_8jF=A9qug24Dnx+rEX=5vDWP7+SGOERcMw@mail.gmail.com>
References: <20250701144647.19572-2-ceggers@arri.de>
 <20250701144647.19572-6-ceggers@arri.de>
 <CABUQxGwt8MjoYmx_8jF=A9qug24Dnx+rEX=5vDWP7+SGOERcMw@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B3:EE_|AM0PR03MB6289:EE_
X-MS-Office365-Filtering-Correlation-Id: 9face657-705c-4aa4-b702-08ddb8d5787e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enRFVThIZXZyb0xQRnd1aTNvZmlOZW5zSmczZi9tcW93QVhldld1WnZzelZY?=
 =?utf-8?B?ejlrTDFNeXRJVDZLZ1lDNWd0dGdJNkNnYzVmNG96OU51WDUyWHgrL1V2VmVp?=
 =?utf-8?B?dEViYjRjTGlUa3lPWEJQK2xjbExTM3g5M1ZhUzdJRDA0OENBUHZpUjdtYlFQ?=
 =?utf-8?B?UEV4V3FPMDF4L1JpbnBMWndrVi9IT3hZRXhiQ3RYY21ncVNSRUhieHhyMDFY?=
 =?utf-8?B?MGRrbFJlUmlHY3Ivb3d6dVE4SkR4MkVyaFlmVmQzMG50Q0Q3c1NlNEUzNmt0?=
 =?utf-8?B?ZWNseStNMmlObklUSTlHQmh0WG8rT1IzYVN2NU5EYzhYTVlvb1g2MjZ0cytE?=
 =?utf-8?B?T1F6SllpT2oxVXRMTzQ3dkhaZ1FRdjRKY2IvVEJidU0rczJERUJKN3E2eHU4?=
 =?utf-8?B?UkJ0M01RTW1mRkhUMDJsOFN0ellWaXFwK2xvU0orWVZKcTUvaVNhVDNSRldR?=
 =?utf-8?B?SFZCQ3o0a1VxcTVzT2Zmem4zSmlJakw0SlhGMzJ5VzRNUXAxTDc2S0prQi9Q?=
 =?utf-8?B?VG9EcTFYWDBYOGkrczFjYlBjR2tPWVh5VmNpQUVSbHlsZ0lPTHVqZXpVUkt0?=
 =?utf-8?B?K1ExSFd0VS82bll3MW5VVU9WbE1PR3BsUldyR2hPM3lxL095dU1qQ0xkZDY3?=
 =?utf-8?B?c05XMVA2Z1JzaTRhMGY3N0NWKzRQY1VxQ1IzdXFyeGZUZlhoMno2eU9pVW9T?=
 =?utf-8?B?ZlRqMHNXc1QwS0Q2bWZkV013SDd2ZVdaV25lWUs0WmZNcHNxUk9TaVVYTmwx?=
 =?utf-8?B?VGM0aGdtUHV5aGw3U2ozdWd2VkhvOGVZdmZnTUVKNDNoZnYzYlRUWUtSL2wv?=
 =?utf-8?B?akQ5MVp2VVVZRFV2Z2dIWlJsOU1MNExXVTV3TGFLbld2NXQ0TWZxVDFIQ2dr?=
 =?utf-8?B?RU1odTYzT0dpbnB2MVJpY2ZNOHRwUHdBcitrRlJncHp1VmJLbkR1Z3IxMFdH?=
 =?utf-8?B?TDBsUHo3RWI0YUhQQnlISFR1WDMrUHZZN281TC9RdHFRZ1FHTUt0SW9CRzdz?=
 =?utf-8?B?WkxoazFIbC9XeWI4bVFqTDVjNzdBSEV4dHNIYllnT1NLUUtVU3I3UnNGdDAw?=
 =?utf-8?B?aWNXeUt0WVNLU0RocWYwTWUvWS9yelRURFN6dlBvdk5BQXZheEZWUEhCSERi?=
 =?utf-8?B?VWlIWXpyNGtXZVFxWHl1c0x4aG41azQxWmNPa0daemxpWDlLTXpBNUs2d2Vp?=
 =?utf-8?B?Y1FNWHd2RkRpb3l6RVE1WlEzc2tXUnN6TEhEc3NoenM5eHl2eU1VV1Z0MmJL?=
 =?utf-8?B?TTQzaVhxc3Jhem0zTFpXelJNMWU4YXh3Vi9DNHZuNUwrWUdTd3hSbGJhOE9Y?=
 =?utf-8?B?OVFxd2dxelBJUStId2ZvTGZMZ0VBeDhnNXVUTzdadXdjQTdsb2RZOFI4cFJF?=
 =?utf-8?B?YW5nLzJQQW1aS3lKVWVWalJpanhnOTBVY2Z6c2NIYlMyclFhU1RhUVRic3VJ?=
 =?utf-8?B?ZUhXVGpCRGhoeE5IZWk5QVFhcUpjTFFCeVNSRTJPN204eEtDQjUvUXdHeEhP?=
 =?utf-8?B?eWZKTElxUll4OWFGS2J0OTJSK0JmOVUxbjErSEk1c291UXZ1Q2ovMGZQd2pz?=
 =?utf-8?B?RUd6UW93N3VmdjcrR2hZbnVlejZ1cDBtVklrRGVuTWZ5NElFVEdYN3NNVGtK?=
 =?utf-8?B?ZUxvTWZGbnM2K1BZWURYZWMvQ0F1enpuMTZhd3FRbjNNV3FoNUlUek1YdXNo?=
 =?utf-8?B?QzNSOVhUWmdqRk5UankweGNIUWk5T3hPaE9lMS9tR2ZmQnpycHRseG83dzR5?=
 =?utf-8?B?UFNWdkU1ZWN5UW95dG12NkNuK25oUmNyVU1lTmhreFB4YllMWVZBb0dkLzVX?=
 =?utf-8?B?Um9tSThUNWFLSS9zZ0pMRWk5b3ZGZGV4bVNpWlVpRDRrclRqQVZKRWNPYkwr?=
 =?utf-8?B?a1pYbzE3cHJaNEd2b2NpTmJCd1JpNjhhUHNLYmRoamtQRzlXSkZkTkRENFlx?=
 =?utf-8?B?WkdVeVZYOWhUSHlmdWlNeFNtUmUyMzFRb3VtWXU0eVJmSkhNakhKZ0k4VW94?=
 =?utf-8?B?bGNTdlNucGVMY1RFb3ZlOHpVRzdrcHp5RTlzd1BLYVFGeE5KWXYyRXB3dklq?=
 =?utf-8?Q?J1f2+P?=
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 19:28:34.5197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9face657-705c-4aa4-b702-08ddb8d5787e
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6289

Hi Brian,

thanks for looking for my patches :-)

On Tuesday, 1 July 2025, 20:52:35 CEST, Brian Gix wrote:
> Hi Christian,
>=20
> I have not yet reviewed your patch set, but I do have a few
> comments/questions to start off to learn the "theory of operation".
>=20
> GATT-Proxy mesh of course was always intended to be a temporary "Legacy
> Support" feature. =20
I think that the GATT specification was written in about 2017. It mentions=
=20
"Legacy phones" where the OS does not allow to send arbitrary ADV messages.
Has anything changed since then?=20

> There should never need to be support for a BlueZ/Linux
> based GATT Client, as the assumption is that if support for GATT-Proxy is
> added, that it would be for the Server side only...=20
I haven't thought about it yet... But as Linux is NOT a legacy system and a=
ll
Mesh nodes need to support MESH-ADV, there should be no need for a GATT Pro=
xy
Client under Linux (exception: I use meshctl for testing my GATT Proxy Serv=
er)
=2E..

> A server that could accept incoming GATT/ATT-ACL connections and then
> propagate GATT based mesh packets via ADV packets.
That's what I am currently working on (although I haven't implemented the
proxy's 'relaying' feature yet).

> Once it is decided that a GATT Proxy server is a valid use case for the
> mesh daemon, then it is also important the mesh daemon function as a fully
> compliant client of the bluetoothd daemon. All ACL traffic *MUST*  be
> centralized in the bluetoothd daemon, with the mesh daemon appearing as a
> standard dbus based client. Otherwise the concept of the GATT database of
> all services (not just the GATT Mesh Proxy service) totally falls apart.
I already expected that there must be a reason for a centralized GATT servi=
ce
per host.

> The only possible exception to this is if it is written for a
> multi-controler environment, where one BT controller is fully owned and
> controlled by the mesh daemon, and used for GATT-Proxy messages only, and
> the other BT controller(s) are shared with bluetoothd, and used for ADV
> traffic.  This is strongly discouraged however, because multi-controller
> operation becomes fraught when there is not central control of the pool of
> available controllers. And our main mission during mesh daemon development
> was near-Zero impact on "classic bluetooth" operation.
This is NOT what I intend (our embedded systems have only one Bluetooth
controller, this must be sufficient).


> So can you confirm that:
> 1. You intend to add *GATT Server only* to the mesh daemon (no GATT clien=
ts
> allowed)?
Yes, I do not intend to implement a GATT client in bluetooth-meshd (although
I mentioned this possibility in my previous answer to Luiz).

> 2. That the GATT Server itself is *hosted* in bluetoothd itself, with no
> ACL connections/L2CAP layer etc owned by the mesh daemon?
Yes, I use the GATT server facility of bluetoothd in bluetooth-meshd
(via D-Bus, not using non-documented interfaces).

> 3. There is a valid use case (Mesh GATT Proxy Clients that cannot for some
> reason issue Mesh ADV packets themselves)?
Yes, my assumption is that mobile phones still don't support MESH ADV
(at the the SMART+ app is a Mesh GATT Proxy Client).

> Regards,
> Brian Gix

regards,
Christian
>=20
>=20
> On Tue, Jul 1, 2025 at 7:48=E2=80=AFAM Christian Eggers <ceggers@arri.de>=
 wrote:
>=20
> > FIXME: net.c: determine whether data shall be sent via mesh_io or
> > gatt_proxy
> > ---
> >  Makefile.mesh         |   3 +-
> >  mesh/gatt-proxy-svc.c | 294 ++++++++++++++++++++++++++++++++++++++++++
> >  mesh/gatt-proxy-svc.h |  29 +++++
> >  mesh/main.c           |   3 +
> >  mesh/net-keys.c       |  61 +++++++++
> >  mesh/net-keys.h       |   4 +
> >  mesh/net.c            |  21 ++-
> >  mesh/net.h            |   4 +
> >  mesh/prov-acceptor.c  |  26 +++-
> >  9 files changed, 440 insertions(+), 5 deletions(-)
> >  create mode 100644 mesh/gatt-proxy-svc.c
> >  create mode 100644 mesh/gatt-proxy-svc.h
> >
> > diff --git a/Makefile.mesh b/Makefile.mesh
> > index 700d64fe9293..8a190f75de9d 100644
> > --- a/Makefile.mesh
> > +++ b/Makefile.mesh
> > @@ -40,7 +40,8 @@ mesh_sources =3D mesh/mesh.h mesh/mesh.c \
> >                                 mesh/rpl.h mesh/rpl.c \
> >                                 mesh/prv-beacon.h mesh/prvbeac-server.c=
 \
> >                                 mesh/mesh-defs.h \
> > -                               mesh/gatt-service.h mesh/gatt-service.c
> > +                               mesh/gatt-service.h mesh/gatt-service.c=
 \
> > +                               mesh/gatt-proxy-svc.h mesh/gatt-proxy-s=
vc.c
> >  pkglibexec_PROGRAMS +=3D mesh/bluetooth-meshd
> >
> >  mesh/mesh.$(OBJEXT): ell/internal
> > diff --git a/mesh/gatt-proxy-svc.c b/mesh/gatt-proxy-svc.c
> > new file mode 100644
> > index 000000000000..e24543de718c
> > --- /dev/null
> > +++ b/mesh/gatt-proxy-svc.c
> > @@ -0,0 +1,294 @@
> > +// SPDX-License-Identifier: LGPL-2.1-or-later
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2025  ARRI Lighting. All rights reserved.
> > + *
> > + *
> > + */
> > +
> > +#include <stdbool.h>
> > +#include <stdlib.h>
> > +#include <string.h>                    // memcpy()
> > +
> > +#include <ell/dbus.h>
> > +#include <ell/queue.h>
> > +#include <ell/timeout.h>
> > +#include <ell/util.h>                  // ell_new(), l_free(), l_mallo=
c()
> > +
> > +#include "mesh/gatt-service.h"
> > +#include "mesh/mesh-io.h"              // mesh_io_recv_func_t
> > +#include "mesh/net.h"                  // mesh_net_attach_gatt(),
> > +                                       // mesh_net_detach_gatt()
> > +#include "mesh/net-keys.h"             // net_key_fill_adv_service_dat=
a(),
> > +                                       // net_key_get_next_id()
> > +#include "mesh/util.h"                 // print_packet()
> > +#include "mesh/gatt-proxy-svc.h"
> > +
> > +#define MESH_GATT_PROXY_SVC_UUID "0x1828"
> > +#define MESH_GATT_PROXY_CHRC_DATA_IN  "0x2ADD"
> > +#define MESH_GATT_PROXY_CHRC_DATA_OUT "0x2ADE"
> > +
> > +#define MAX_PROXY_PDU_LEN 66  /* MshPRT_v1.1, section 7.2.2.2.7 */
> > +
> > +struct gatt_io_reg {
> > +       mesh_io_recv_func_t cb;
> > +       void *user_data;
> > +       enum proxy_msg_type msg_type;
> > +};
> > +
> > +struct gatt_proxy_service {
> > +       struct gatt_service *gatt_service;
> > +       uint32_t current_adv_key_id;
> > +       struct l_timeout *adv_key_cycle_to;
> > +       bool txing;
> > +       struct l_queue *tx_deferred;
> > +       struct l_queue *rx_regs;
> > +};
> > +
> > +struct process_data {
> > +       enum proxy_msg_type msg_type;
> > +       const uint8_t *data;
> > +       uint8_t len;
> > +};
> > +
> > +static struct gatt_proxy_service *gatt_proxy_service;
> > +
> > +struct tx_deferred {
> > +       enum proxy_msg_type msg_type;
> > +       uint16_t len;
> > +       uint8_t data[];
> > +};
> > +
> > +static struct gatt_io_reg *find_by_filter(struct l_queue *rx_regs,
> > +                                               enum proxy_msg_type
> > msg_type)
> > +{
> > +       const struct l_queue_entry *entry;
> > +
> > +       entry =3D l_queue_get_entries(rx_regs);
> > +
> > +       for (; entry; entry =3D entry->next) {
> > +               struct gatt_io_reg *rx_reg =3D entry->data;
> > +
> > +               if (rx_reg->msg_type =3D=3D msg_type)
> > +                       return rx_reg;
> > +       }
> > +
> > +       return NULL;
> > +}
> > +
> > +void gatt_proxy_service_register_recv_cb(struct gatt_proxy_service
> > *gatt_proxy,
> > +                                       enum proxy_msg_type msg_type,
> > +                                       mesh_io_recv_func_t cb,
> > +                                       void *user_data)
> > +{
> > +       struct gatt_io_reg *rx_reg;
> > +
> > +       if (gatt_proxy !=3D gatt_proxy_service || !cb)
> > +               return;
> > +
> > +       rx_reg =3D find_by_filter(gatt_proxy->rx_regs, msg_type);
> > +
> > +       l_free(rx_reg);
> > +       l_queue_remove(gatt_proxy->rx_regs, rx_reg);
> > +
> > +       rx_reg =3D l_malloc(sizeof(struct gatt_io_reg));
> > +       rx_reg->cb =3D cb;
> > +       rx_reg->msg_type =3D msg_type;
> > +       rx_reg->user_data =3D user_data;
> > +
> > +       l_queue_push_head(gatt_proxy->rx_regs, rx_reg);
> > +}
> > +
> > +void
> > +gatt_proxy_service_deregister_recv_cb(struct gatt_proxy_service
> > *gatt_proxy,
> > +                                               enum proxy_msg_type
> > msg_type)
> > +{
> > +       struct gatt_io_reg *rx_reg;
> > +
> > +       if (gatt_proxy !=3D gatt_proxy_service)
> > +               return;
> > +
> > +       rx_reg =3D find_by_filter(gatt_proxy->rx_regs, msg_type);
> > +
> > +       l_queue_remove(gatt_proxy->rx_regs, rx_reg);
> > +       l_free(rx_reg);
> > +}
> > +
> > +void gatt_proxy_service_send(enum proxy_msg_type msg_type,
> > +                                               const void *data, uint8=
_t
> > len)
> > +{
> > +       if (!gatt_proxy_service)
> > +               return;
> > +
> > +       if (!gatt_proxy_service->txing) {
> > +               gatt_proxy_service->txing =3D true;
> > +               gatt_service_tx(gatt_proxy_service->gatt_service, msg_t=
ype,
> > +                                                               data, l=
en);
> > +       } else {
> > +               struct tx_deferred *tx_deferred;
> > +
> > +//             print_packet("TX-Defer", data, len);
> > +               tx_deferred =3D l_malloc(len + sizeof(struct tx_deferre=
d));
> > +               tx_deferred->msg_type =3D msg_type;
> > +               tx_deferred->len =3D len;
> > +               memcpy(tx_deferred->data, data, len);
> > +               l_queue_push_tail(gatt_proxy_service->tx_deferred,
> > tx_deferred);
> > +       }
> > +}
> > +
> > +static void process_rx_callbacks(void *a, void *b)
> > +{
> > +       struct gatt_io_reg *rx_reg =3D a;
> > +       struct process_data *rx =3D b;
> > +
> > +       if (rx->msg_type =3D=3D rx_reg->msg_type)
> > +               rx_reg->cb(rx_reg->user_data, NULL, rx->data, rx->len);
> > +}
> > +
> > +static void gatt_service_rx(void *user_data, enum proxy_msg_type msg_t=
ype,
> > +                                               const void *data, uint1=
6_t
> > len)
> > +{
> > +       struct gatt_proxy_service *gatt_proxy =3D user_data;
> > +       struct process_data rx =3D {
> > +               .msg_type =3D msg_type,
> > +               .data =3D data,
> > +               .len =3D len,
> > +       };
> > +
> > +       if (gatt_proxy !=3D gatt_proxy_service)
> > +               return;
> > +
> > +       print_packet("RX", data, len);
> > +       l_queue_foreach(gatt_proxy->rx_regs, process_rx_callbacks, &rx);
> > +}
> > +
> > +static bool gatt_service_tx_cmplt(void *user_data)
> > +{
> > +       struct gatt_proxy_service *gatt_proxy =3D user_data;
> > +       struct tx_deferred *tx_deferred;
> > +
> > +//     l_info("gatt_service_tx_cmplt");
> > +
> > +       if (gatt_proxy_service !=3D gatt_proxy)
> > +               return false;
> > +
> > +       if (!gatt_proxy->txing)
> > +               return false;
> > +
> > +       gatt_proxy->txing =3D false;
> > +
> > +       tx_deferred =3D l_queue_pop_head(gatt_proxy->tx_deferred);
> > +       if (!tx_deferred)
> > +               return false;
> > +
> > +       gatt_proxy_service_send(tx_deferred->msg_type,
> > +                                       tx_deferred->data,
> > tx_deferred->len);
> > +       l_free(tx_deferred);
> > +       return true;
> > +}
> > +
> > +static bool gatt_service_fill_adv_service_data(void *user_data,
> > +                                       struct l_dbus_message_builder
> > *builder)
> > +{
> > +       struct gatt_proxy_service *gatt_service =3D user_data;
> > +
> > +       if (gatt_service !=3D gatt_proxy_service)
> > +               return false;
> > +
> > +       return
> > net_key_fill_adv_service_data(gatt_service->current_adv_key_id,
> > +                                                               builder=
);
> > +}
> > +
> > +static void gatt_proxy_service_cycle_adv(struct l_timeout *timeout,
> > +                                               void *user_data)
> > +{
> > +       struct gatt_proxy_service *gatt_proxy =3D user_data;
> > +       uint32_t next_adv_key_id;
> > +
> > +       if (gatt_proxy_service !=3D gatt_proxy)
> > +               return;
> > +
> > +       next_adv_key_id =3D
> > net_key_get_next_id(gatt_proxy->current_adv_key_id);
> > +       if (!next_adv_key_id)
> > +               return;
> > +
> > +       if (gatt_proxy->current_adv_key_id !=3D next_adv_key_id) {
> > +               gatt_proxy->current_adv_key_id =3D next_adv_key_id;
> > +               gatt_service_adv_updated(gatt_proxy_service->gatt_servi=
ce);
> > +       }
> > +
> > +       l_timeout_modify(gatt_proxy->adv_key_cycle_to, 3);
> > +}
> > +
> > +void gatt_proxy_service_set_current_adv_key(uint32_t id)
> > +{
> > +       if (!gatt_proxy_service)
> > +               return;
> > +
> > +       gatt_proxy_service->current_adv_key_id =3D id;
> > +       gatt_service_adv_updated(gatt_proxy_service->gatt_service);
> > +}
> > +
> > +void gatt_proxy_service_start(void)
> > +{
> > +       if (!gatt_proxy_service || gatt_proxy_service->gatt_service)
> > +               return;
> > +
> > +       gatt_proxy_service->gatt_service =3D gatt_service_create(
> > +                                       MESH_GATT_PROXY_SVC_UUID,
> > +                                       MESH_GATT_PROXY_CHRC_DATA_IN,
> > +                                       MESH_GATT_PROXY_CHRC_DATA_OUT,
> > +                                       MAX_PROXY_PDU_LEN,
> > +                                       NULL, NULL,
> > +                                       gatt_service_rx,
> > +                                       gatt_service_tx_cmplt,
> > +                                       gatt_service_fill_adv_service_d=
ata,
> > +                                       gatt_proxy_service);
> > +
> > +       gatt_proxy_service->adv_key_cycle_to =3D l_timeout_create(3,
> > +
> >  gatt_proxy_service_cycle_adv,
> > +                                               gatt_proxy_service, NUL=
L);
> > +
> > +       mesh_net_attach_gatt(gatt_proxy_service);
> > +}
> > +
> > +void gatt_proxy_service_stop(void)
> > +{
> > +       if (!gatt_proxy_service || !gatt_proxy_service->gatt_service)
> > +               return;
> > +
> > +       mesh_net_detach_gatt(gatt_proxy_service);
> > +       l_timeout_remove(gatt_proxy_service->adv_key_cycle_to);
> > +       gatt_service_destroy(gatt_proxy_service->gatt_service, NULL, NU=
LL);
> > +}
> > +
> > +void gatt_proxy_service_create(void)
> > +{
> > +       if (gatt_proxy_service)
> > +               return;
> > +
> > +       gatt_proxy_service =3D l_new(struct gatt_proxy_service, 1);
> > +       gatt_proxy_service->tx_deferred =3D l_queue_new();
> > +       gatt_proxy_service->rx_regs =3D l_queue_new();
> > +
> > +       /* Check whether we have at least one key */
> > +       if (!net_key_get_next_id(0))
> > +               return;
> > +
> > +       gatt_proxy_service_start();
> > +}
> > +
> > +void gatt_proxy_service_destroy(void)
> > +{
> > +       if (!gatt_proxy_service)
> > +               return;
> > +
> > +       gatt_proxy_service_stop();
> > +
> > +       l_queue_destroy(gatt_proxy_service->rx_regs, l_free);
> > +       l_queue_destroy(gatt_proxy_service->tx_deferred, l_free);
> > +       l_free(gatt_proxy_service);
> > +       gatt_proxy_service =3D NULL;
> > +}
> > diff --git a/mesh/gatt-proxy-svc.h b/mesh/gatt-proxy-svc.h
> > new file mode 100644
> > index 000000000000..5c640dc2c8ef
> > --- /dev/null
> > +++ b/mesh/gatt-proxy-svc.h
> > @@ -0,0 +1,29 @@
> > +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> > +/*
> > + *
> > + *  BlueZ - Bluetooth protocol stack for Linux
> > + *
> > + *  Copyright (C) 2025  ARRI Lighting. All rights reserved.
> > + *
> > + *
> > + */
> > +
> > +#include <stdint.h>
> > +
> > +enum proxy_msg_type;
> > +struct gatt_proxy_service;
> > +
> > +void gatt_proxy_service_create(void);
> > +void gatt_proxy_service_destroy(void);
> > +void gatt_proxy_service_start(void);
> > +void gatt_proxy_service_stop(void);
> > +void gatt_proxy_service_set_current_adv_key(uint32_t id);
> > +void gatt_proxy_service_register_recv_cb(struct gatt_proxy_service
> > *gatt_proxy,
> > +                                       enum proxy_msg_type msg_type,
> > +                                       mesh_io_recv_func_t cb,
> > +                                       void *user_data);
> > +void
> > +gatt_proxy_service_deregister_recv_cb(struct gatt_proxy_service
> > *gatt_proxy,
> > +                                               enum proxy_msg_type
> > msg_type);
> > +void gatt_proxy_service_send(enum proxy_msg_type msg_type,
> > +                                               const void *data, uint8=
_t
> > len);
> > diff --git a/mesh/main.c b/mesh/main.c
> > index 5b8af4bc7345..b423fe70b8bd 100644
> > --- a/mesh/main.c
> > +++ b/mesh/main.c
> > @@ -31,6 +31,7 @@
> >  #include "mesh/crypto.h"
> >  #include "mesh/dbus.h"
> >  #include "mesh/mesh-io.h"
> > +#include "mesh/gatt-proxy-svc.h"
> >  #include "mesh/util.h"
> >
> >  static const char *storage_dir;
> > @@ -94,6 +95,8 @@ static void mesh_ready_callback(void *user_data, bool
> > success)
> >                 l_error("Failed to initialize mesh D-Bus resources");
> >                 l_main_quit();
> >         }
> > +
> > +       gatt_proxy_service_create();
> >  }
> >
> >  static void request_name_callback(struct l_dbus *dbus, bool success,
> > diff --git a/mesh/net-keys.c b/mesh/net-keys.c
> > index 42d498ce0ede..62ea4208af98 100644
> > --- a/mesh/net-keys.c
> > +++ b/mesh/net-keys.c
> > @@ -20,6 +20,7 @@
> >  #include "mesh/util.h"
> >  #include "mesh/crypto.h"
> >  #include "mesh/mesh-io.h"
> > +#include "mesh/gatt-proxy-svc.h"
> >  #include "mesh/net.h"
> >  #include "mesh/net-keys.h"
> >
> > @@ -29,6 +30,12 @@
> >  /* This allows daemon to skip decryption on recently seen beacons */
> >  #define BEACON_CACHE_MAX       10
> >
> > +/* MshPRT_v1.1, section 7.2.2.2.1 */
> > +#define IDENTIFICATION_TYPE_NETWORK_ID     0x00
> > +#define IDENTIFICATION_TYPE_NODE_ID        0x01
> > +#define IDENTIFICATION_TYPE_PRV_NETWORK_ID 0x02
> > +#define IDENTIFICATION_TYPE_PRV_NODE_ID    0x03
> > +
> >  struct beacon_rx {
> >         uint8_t data[28];
> >         uint32_t id;
> > @@ -144,6 +151,9 @@ uint32_t net_key_add(const uint8_t flooding[16])
> >                 goto fail;
> >
> >         key->id =3D ++last_flooding_id;
> > +       if (l_queue_isempty(keys))
> > +               gatt_proxy_service_start();
> > +
> >         l_queue_push_tail(keys, key);
> >         return key->id;
> >
> > @@ -196,6 +206,9 @@ void net_key_unref(uint32_t id)
> >                         l_timeout_remove(key->observe.timeout);
> >                         l_queue_remove(keys, key);
> >                         l_free(key);
> > +
> > +                       if (l_queue_isempty(keys))
> > +                               gatt_proxy_service_stop();
> >                 }
> >         }
> >  }
> > @@ -663,6 +676,7 @@ bool net_key_beacon_refresh(uint32_t id, uint32_t i=
vi,
> > bool kr, bool ivu,
> >                         return false;
> >
> >                 print_packet("Set SNB to", key->snb, 23);
> > +               gatt_proxy_service_set_current_adv_key(key->id);
> >         }
> >
> >         l_debug("Set Beacon: IVI: %8.8x, IVU: %d, KR: %d", ivi, ivu, kr=
);
> > @@ -798,3 +812,50 @@ void net_key_cleanup(void)
> >         l_queue_destroy(beacons, l_free);
> >         beacons =3D NULL;
> >  }
> > +
> > +bool net_key_fill_adv_service_data(uint32_t id,
> > +                                       struct l_dbus_message_builder
> > *builder)
> > +{
> > +       uint8_t identification_type =3D IDENTIFICATION_TYPE_NETWORK_ID;
> > +       struct net_key *key;
> > +       int i;
> > +
> > +       key =3D l_queue_find(keys, match_id, L_UINT_TO_PTR(id));
> > +       if (!key)
> > +               return false;
> > +
> > +       l_dbus_message_builder_enter_array(builder, "y");
> > +       l_dbus_message_builder_append_basic(builder, 'y',
> > &identification_type);
> > +
> > +       for (i =3D 0; i < sizeof(key->net_id); i++)
> > +               l_dbus_message_builder_append_basic(builder, 'y',
> > +                                                       &(key->net_id[i=
]));
> > +       l_dbus_message_builder_leave_array(builder);
> > +
> > +       return true;
> > +}
> > +
> > +uint32_t net_key_get_next_id(uint32_t id)
> > +{
> > +       const struct l_queue_entry *entry;
> > +       struct net_key *key;
> > +       bool found =3D false;
> > +
> > +       /* Try to find next key (after the given key id) */
> > +       for (entry =3D l_queue_get_entries(keys); entry; entry =3D
> > entry->next) {
> > +               key =3D entry->data;
> > +
> > +               if (!found)
> > +                       if (key->id =3D=3D id)
> > +                               found =3D true;
> > +               else
> > +                       return key->id;
> > +       }
> > +
> > +       /* If not found, return id of first key */
> > +       key =3D l_queue_peek_head(keys);
> > +       if (key)
> > +               return key->id;
> > +
> > +       return 0;
> > +}
> > diff --git a/mesh/net-keys.h b/mesh/net-keys.h
> > index e73812481ddb..5a9d7868ab48 100644
> > --- a/mesh/net-keys.h
> > +++ b/mesh/net-keys.h
> > @@ -37,3 +37,7 @@ bool net_key_beacon_refresh(uint32_t id, uint32_t
> > iv_index, bool kr, bool ivu,
> >  void net_key_beacon_enable(uint32_t id, bool mpb, uint8_t refresh_coun=
t);
> >  void net_key_beacon_disable(uint32_t id, bool mpb);
> >  uint32_t net_key_beacon_last_seen(uint32_t id);
> > +
> > +bool net_key_fill_adv_service_data(uint32_t id,
> > +                                       struct l_dbus_message_builder
> > *builder);
> > +uint32_t net_key_get_next_id(uint32_t id);
> > diff --git a/mesh/net.c b/mesh/net.c
> > index 1cf74c892ca0..a64cfbde6f4e 100644
> > --- a/mesh/net.c
> > +++ b/mesh/net.c
> > @@ -27,6 +27,8 @@
> >  #include "mesh/net.h"
> >  #include "mesh/mesh-io.h"
> >  #include "mesh/friend.h"
> > +#include "mesh/gatt-service.h"         // PROXY_MSG_TYPE_NETWORK_PDU
> > +#include "mesh/gatt-proxy-svc.h"       // gatt_proxy_service_send()
> >  #include "mesh/mesh-config.h"
> >  #include "mesh/model.h"
> >  #include "mesh/appkey.h"
> > @@ -2306,7 +2308,9 @@ static void send_msg_pkt_oneshot(void *user_data)
> >         /* No extra randomization when sending regular mesh messages */
> >         info.u.gen.max_delay =3D DEFAULT_MIN_DELAY;
> >
> > -       mesh_io_send(net->io, &info, tx->packet, tx->size);
> > +//     mesh_io_send(net->io, &info, tx->packet, tx->size);
> > +       gatt_proxy_service_send(PROXY_MSG_TYPE_NETWORK_PDU,
> > +                                               tx->packet + 1, tx->siz=
e -
> > 1);
> >         l_free(tx);
> >  }
> >
> > @@ -3065,6 +3069,21 @@ struct mesh_io *mesh_net_detach(struct mesh_net
> > *net)
> >         return io;
> >  }
> >
> > +void mesh_net_attach_gatt(struct gatt_proxy_service *gatt_proxy)
> > +{
> > +       gatt_proxy_service_register_recv_cb(gatt_proxy,
> > +                                               PROXY_MSG_TYPE_NETWORK_=
PDU,
> > +                                               net_msg_recv, NULL);
> > +}
> > +
> > +void mesh_net_detach_gatt(struct gatt_proxy_service *gatt_proxy)
> > +{
> > +//     mesh_io_send_cancel(net->io, &type, 1);
> > +
> > +       gatt_proxy_service_deregister_recv_cb(gatt_proxy,
> > +
> >  PROXY_MSG_TYPE_NETWORK_PDU);
> > +}
> > +
> >  bool mesh_net_iv_index_update(struct mesh_net *net)
> >  {
> >         if (net->iv_upd_state !=3D IV_UPD_NORMAL)
> > diff --git a/mesh/net.h b/mesh/net.h
> > index d385ba16efdd..1389e5c78d15 100644
> > --- a/mesh/net.h
> > +++ b/mesh/net.h
> > @@ -14,6 +14,8 @@
> >
> >  struct mesh_io;
> >  struct mesh_node;
> > +struct mesh_io_recv_info;
> > +struct gatt_proxy_service;
> >
> >  #define DEV_ID 0
> >
> > @@ -258,6 +260,8 @@ bool mesh_net_get_key(struct mesh_net *net, bool
> > new_key, uint16_t idx,
> >                                                         uint32_t
> > *net_key_id);
> >  bool mesh_net_attach(struct mesh_net *net, struct mesh_io *io);
> >  struct mesh_io *mesh_net_detach(struct mesh_net *net);
> > +void mesh_net_attach_gatt(struct gatt_proxy_service *gatt_proxy);
> > +void mesh_net_detach_gatt(struct gatt_proxy_service *gatt_proxy);
> >  struct l_queue *mesh_net_get_app_keys(struct mesh_net *net);
> >
> >  void mesh_net_transport_send(struct mesh_net *net, uint32_t net_key_id,
> > diff --git a/mesh/prov-acceptor.c b/mesh/prov-acceptor.c
> > index f483c330953b..1d30f3593d3a 100644
> > --- a/mesh/prov-acceptor.c
> > +++ b/mesh/prov-acceptor.c
> > @@ -21,6 +21,8 @@
> >  #include "mesh/mesh-defs.h"
> >  #include "mesh/util.h"
> >  #include "mesh/crypto.h"
> > +#include "mesh/mesh-io.h"
> > +#include "mesh/gatt-proxy-svc.h"
> >  #include "mesh/net.h"
> >  #include "mesh/prov.h"
> >  #include "mesh/provision.h"
> > @@ -88,6 +90,11 @@ struct mesh_prov_acceptor {
> >
> >  static struct mesh_prov_acceptor *prov =3D NULL;
> >
> > +static void gatt_unreg_finished(void *user_data)
> > +{
> > +       gatt_proxy_service_create();
> > +}
> > +
> >  static void acceptor_free(void)
> >  {
> >         if (!prov)
> > @@ -100,7 +107,7 @@ static void acceptor_free(void)
> >         mesh_send_cancel(&pkt_filter, sizeof(pkt_filter));
> >
> >         pb_adv_unreg(prov);
> > -       pb_gatt_unreg(prov, NULL, NULL);
> > +       pb_gatt_unreg(prov, gatt_unreg_finished, NULL);
> >
> >         l_free(prov);
> >         prov =3D NULL;
> > @@ -704,8 +711,13 @@ failure:
> >  cleanup:
> >         l_timeout_remove(prov->timeout);
> >
> > -       /* Give PB Link 5 seconds to end session */
> > -       prov->timeout =3D l_timeout_create(5, prov_to, prov, NULL);
> > +       if (prov->transport =3D=3D PB_ADV) {
> > +               /* Give PB Link 5 seconds to end session */
> > +               prov->timeout =3D l_timeout_create(5, prov_to, prov, NU=
LL);
> > +       } else {
> > +               prov->timeout =3D NULL;
> > +               prov_to(NULL, prov);
> > +       }
> >  }
> >
> >  static void acp_prov_ack(void *user_data, uint8_t msg_num)
> > @@ -804,6 +816,14 @@ bool acceptor_start(uint8_t num_ele, uint8_t *uuid,
> >                 result =3D pb_adv_reg(false, acp_prov_open, acp_prov_cl=
ose,
> >                                         acp_prov_rx, acp_prov_ack, uuid,
> > prov);
> >
> > +               /*
> > +                * MeshPRT_v1.1, chapter 7: "A device may support the M=
esh
> > +                * Provisioning Service or the Mesh Proxy Service or bo=
th.
> > If
> > +                * both are supported, only one of these services shall=
 be
> > +                * exposed in the GATT database at a time."
> > +                */
> > +               gatt_proxy_service_destroy();
> > +
> >                 result =3D pb_gatt_reg(acp_prov_open, acp_prov_close,
> >                                         acp_prov_rx, acp_prov_ack, uuid,
> >                                         caps->oob_info, prov);
> > --
> > 2.43.0
> >
> >
>=20




