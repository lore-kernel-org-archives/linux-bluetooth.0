Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013028.outbound.protection.outlook.com [52.101.83.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3CC2701CF
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 18:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044805; cv=fail; b=GIXMVhupQ6DFzssZJ6Q/aqTbnMUgnmZu32SXE4qF/+BRygr2yxQfYu3AZ7enPT4OlM2p9hbXt2VGLh5knZ9J7WAU/xWSR/PGtC/qOLRGcv1UWbxH8Cp9IQEJuuAkHDYB9rdoKb8r4zKS9hyKuAdKLQnRXvYtpEoE2s46H3+pKbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044805; c=relaxed/simple;
	bh=6Cfpa2HZrIdDOw+c2asj7ySdsuTlOXsqvE1ciwWopGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q7UrArqVFSD5MrL0+X9NCvk5atLSzAP8URdj4lSJRtqZ33fnz3iXit94XzTBefU38vdYv2MphrO6Is4IUjIZILL8/QR1Iz44qXhFLCTXoWnwLrAYt2a5/ruHYLae5tF8DXKNJKb4HpAYEPi2ZjXBCK8NvNr1dv/Tz6SukVCC4Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=lM+tzbGT; arc=fail smtp.client-ip=52.101.83.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="lM+tzbGT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ct3L2brWcWz80VLxx30hOPIO9lL8G1JeBcgejxwBVtDKfV4M5IVttnSjAw1cxAOk6HfdKuTHcFBUNghD9WWj4Cdd+bBNdN7OzI3kUvWGjJKaGNWylT2WlngxnLfvLYww2H2IbicrGMfBnr1Mw9xtgXFS+BcHAHCFk4IQz4EhYqxCqt6Gq8gOqYlZFmnN9FXFg3L6VAqm1PZv9eRL6i6g0SNQa9bqesWBv5fyyIpduh1oLn48qU8Rkw2ndawiVl4u3OYXgLRAWp7hbVyy9c9/mbXee8GBbGiZo3MpmwNWvh1EFF99JpWE5vRz1wthL4xeZS/qFhnfbyy0c27xFc09gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SFTBuhNVgegU1+hqpjL4gYj12fKotcqdUGGeps9rfI=;
 b=xvLJesrje8CS9tCMuKHfUNZSY0NQv7i/VYTeg95a/FoqJok9cprJUpHq3xqw4kwvl7HidJkGMZMHUrTbqUJwvZZ8LE9Nh8E6o4jhPme9w1obVzrwR7Btb8DNkl2ydcVVI5CPW1+A4Urodsy7Bqg2A/G9ebNOU1AfMoHE7aA2e1ZkuTSZoCyUJhTDYeJgdQCPXGPYEMz7vHqigVK+HrzOzlK6nlhbDiW0IiszofXTT5ivxkS9qkthAECMfdeYv6GE/yCkBe9BNAVPJxQITeZGuZv1VkYn6+3Tdkikw1OSURsrrCiCxrC+9T0DlRWAi3ZVMxqem/+G4fPjzvzHnQNo3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SFTBuhNVgegU1+hqpjL4gYj12fKotcqdUGGeps9rfI=;
 b=lM+tzbGTuPTpMrEUKbD9xKEiqf/t4ZjCWQqho/oo7o1K4PPWQKpUhDu7DpWLe4NHe99husfM/qN6DHW6GC2aW5ln18ypDv0yCKe1hnnVOAcKhzrq/RXAjbwKdZcjtb2DNCfGw25AIdqwd1cJaALPcmrQ5/tFFoqj7BBfIBvQalc=
Received: from DU2PR04CA0235.eurprd04.prod.outlook.com (2603:10a6:10:2b1::30)
 by DBBPR03MB6857.eurprd03.prod.outlook.com (2603:10a6:10:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 18:38:45 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::7f) by DU2PR04CA0235.outlook.office365.com
 (2603:10a6:10:2b1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 18:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 18:38:42 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 19:38:42 +0100
From: Christian Eggers <ceggers@arri.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 11/12] agent: move defines and parsing for I/O capability to
 shared/mgnt
Date: Wed, 25 Feb 2026 19:38:42 +0100
Message-ID: <3672959.dWV9SEqChM@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZLgQWy_+gZmWXRmQx1g7P3pT3=ZLjFa7FuUnpWH4Huf3g@mail.gmail.com>
References: <20260225161715.20394-1-ceggers@arri.de>
 <20260225161715.20394-11-ceggers@arri.de>
 <CABBYNZLgQWy_+gZmWXRmQx1g7P3pT3=ZLjFa7FuUnpWH4Huf3g@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|DBBPR03MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 5080319a-0ca9-4bd2-8060-08de749d1a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	kxwxruW/HPyPnYhgUHIhG/XYVLYgmsmsSG5RXKFU5o1a96tdnTW7ns1fBJgrnXnjjJ8RGHh3o6yIZiOArBeITgui6uELltnxk+IWSNsB1D0dEKBQLhc356ivj5YH9502SOP4tA6/AN8VCmvXRb3cDb9bdud1ifFx5D8V+x7/ET1PLvnqwKUHyY7lMjNGAENuq321IEjJTjJw/OZ28q73YwIGzR2nSW5zfdTDDueA+5CAKTwGSqfG0/hzZxCHpPWvEYZRsJVe1JmsXnTiTiFpS9SlsfCfYfAIYJVFCOpmk9bsYaQcM36OSO8B6tPycEeDri5ShuBtDykGhnnrQo/ZprRSLvxqklhvGlgSVSmrcH0eb++2Xg/fg85Z4ie2fHRHEMszV2M7WtKmmbChvqpx8aNrj/2gmN13Ks+0wfQLHpPBOuJx3+1F8Tdcr1QKf7a6Nsv+qROxWtGNbLrtCQa2NdFE8z0kn89+NLed2WmJNoZZ/KBfiVCQkg0d3wpOQKnTy4IsSSqLaQ9IfD5wNqgaNprYnIt8tiXspTgIjF986yJozyhoZO9VYK507zZTK60A+LDrv2qW9nEq/e4ka3k7hQkwCDRTbbOZaqULVZMvyN27RSExnwGRYMre1wFiKPvU8pdh5fAArtf24FAs/OVRR70wkShQM157teaV/5jUcbrsrSpRrdKlvu/hMYv3/pR8opZY4kASPz+P+j4pDj+mLwh4CoN2MLRdg+eAOYYTF8cfUWo9HeO20U5AzUOSSYpOTSKTD8IJl5hiJ5/MXPLxmtZL1fasdbZ0uD6BuD5lzxvwtcUMeb/WIZQDk20jmSKghDVvqu/9bxCJUJYc5HQMbA==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0RsfsAJwJX5D++H4vmVE9EAAsW70uhgUmM2UFieOyDnx0FKq1zbtIHCVYYMdbGTWF9sdCx5iW9iPBypFVAFukNET8RTXuzt8b4HDHri3qI5y8M4Xnqa2kXstm69G1QLZfrZvVQBkyDr1uCJGxMwn8A7Yv1hNwpHxv6ZGF/837sSgsNYLwKTS3jw+goZbyxUeMp+1oayYxu621YOMh7+/hg1PKQ+FtCwR6ZCGvTCNod0Qlc7pr4y0XtmWwieDzkoBup8qJ4GWeKgugAbXuAoXIGlgYC6J3JQqd5nD2frCKNxs0oDqTau2jm6aQ/J1MZodjVgJGNcnG4QJV5QQuW84+oBjgVaJIE6TNIXlmYzjlzd1HoLlQ7UbdhDZEa+M0dDBPYNHICOaDJBKD/wyb02RN1rjezxgHwE2EekriZmTJyQYvQIlYNFARC5byjEdH43K
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 18:38:42.8837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5080319a-0ca9-4bd2-8060-08de749d1a16
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB6857

Hi Luiz,

On Wednesday, 25 February 2026, 17:38:49 CET, Luiz Augusto von Dentz wrote:
> Hi Christian,
>=20
> On Wed, Feb 25, 2026 at 11:22=E2=80=AFAM Christian Eggers <ceggers@arri.d=
e> wrote:
> >
> > Allow reusing in client/mgmt.c (next commit)
> > ---
> >  src/adapter.c     |  6 +++---
> >  src/agent.c       | 24 ++++--------------------
> >  src/agent.h       |  7 -------
> >  src/device.c      |  7 ++++---
>=20
> Shared changed should be sent separately since its license (LGPL) is
> different than the daemon (GPL).

done

>=20
> >  src/shared/mgmt.c | 32 ++++++++++++++++++++++++++++++++
> >  src/shared/mgmt.h | 10 ++++++++++
> >  6 files changed, 53 insertions(+), 33 deletions(-)
> >
> > diff --git a/src/adapter.c b/src/adapter.c
> > index 9bb1950a9f7d..bfabdf9a62ef 100644
> > --- a/src/adapter.c
> > +++ b/src/adapter.c
> > @@ -9156,7 +9156,7 @@ int adapter_set_io_capability(struct btd_adapter =
*adapter, uint8_t io_cap)
> >         struct mgmt_cp_set_io_capability cp;
> >
> >         if (!btd_opts.pairable) {
> > -               if (io_cap =3D=3D IO_CAPABILITY_INVALID) {
> > +               if (io_cap =3D=3D MGMT_IO_CAPABILITY_INVALID) {
> >                         if (adapter->current_settings & MGMT_SETTING_BO=
NDABLE)
> >                                 set_mode(adapter, MGMT_OP_SET_BONDABLE,=
 0x00);
> >
> > @@ -9165,8 +9165,8 @@ int adapter_set_io_capability(struct btd_adapter =
*adapter, uint8_t io_cap)
> >
> >                 if (!(adapter->current_settings & MGMT_SETTING_BONDABLE=
))
> >                         set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
> > -       } else if (io_cap =3D=3D IO_CAPABILITY_INVALID)
> > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > +       } else if (io_cap =3D=3D MGMT_IO_CAPABILITY_INVALID)
> > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> >
> >         memset(&cp, 0, sizeof(cp));
> >         cp.io_capability =3D io_cap;
> > diff --git a/src/agent.c b/src/agent.c
> > index 3696575b83e6..794f81ebf18a 100644
> > --- a/src/agent.c
> > +++ b/src/agent.c
> > @@ -35,6 +35,7 @@
> >  #include "adapter.h"
> >  #include "device.h"
> >  #include "agent.h"
> > +#include "shared/mgmt.h"
> >  #include "shared/queue.h"
> >
> >  #define REQUEST_TIMEOUT (60 * 1000)            /* 60 seconds */
> > @@ -131,7 +132,7 @@ static void set_io_cap(struct btd_adapter *adapter,=
 gpointer user_data)
> >         if (agent)
> >                 io_cap =3D agent->capability;
> >         else
> > -               io_cap =3D IO_CAPABILITY_INVALID;
> > +               io_cap =3D MGMT_IO_CAPABILITY_INVALID;
> >
> >         adapter_set_io_capability(adapter, io_cap);
> >  }
> > @@ -944,23 +945,6 @@ static void agent_destroy(gpointer data)
> >         agent_unref(agent);
> >  }
> >
> > -static uint8_t parse_io_capability(const char *capability)
> > -{
> > -       if (g_str_equal(capability, ""))
> > -               return IO_CAPABILITY_KEYBOARDDISPLAY;
> > -       if (g_str_equal(capability, "DisplayOnly"))
> > -               return IO_CAPABILITY_DISPLAYONLY;
> > -       if (g_str_equal(capability, "DisplayYesNo"))
> > -               return IO_CAPABILITY_DISPLAYYESNO;
> > -       if (g_str_equal(capability, "KeyboardOnly"))
> > -               return IO_CAPABILITY_KEYBOARDONLY;
> > -       if (g_str_equal(capability, "NoInputNoOutput"))
> > -               return IO_CAPABILITY_NOINPUTNOOUTPUT;
> > -       if (g_str_equal(capability, "KeyboardDisplay"))
> > -               return IO_CAPABILITY_KEYBOARDDISPLAY;
> > -       return IO_CAPABILITY_INVALID;
> > -}
> > -
> >  static DBusMessage *register_agent(DBusConnection *conn,
> >                                         DBusMessage *msg, void *user_da=
ta)
> >  {
> > @@ -979,8 +963,8 @@ static DBusMessage *register_agent(DBusConnection *=
conn,
> >                                                 DBUS_TYPE_INVALID) =3D=
=3D FALSE)
> >                 return btd_error_invalid_args(msg);
> >
> > -       cap =3D parse_io_capability(capability);
> > -       if (cap =3D=3D IO_CAPABILITY_INVALID)
> > +       cap =3D mgmt_parse_io_capability(capability);
> > +       if (cap =3D=3D MGMT_IO_CAPABILITY_INVALID)
> >                 return btd_error_invalid_args(msg);
> >
> >         agent =3D agent_create(sender, path, cap);
> > diff --git a/src/agent.h b/src/agent.h
> > index bd0502030fa0..03731756849c 100644
> > --- a/src/agent.h
> > +++ b/src/agent.h
> > @@ -9,13 +9,6 @@
> >   *
> >   */
> >
> > -#define IO_CAPABILITY_DISPLAYONLY      0x00
> > -#define IO_CAPABILITY_DISPLAYYESNO     0x01
> > -#define IO_CAPABILITY_KEYBOARDONLY     0x02
> > -#define IO_CAPABILITY_NOINPUTNOOUTPUT  0x03
> > -#define IO_CAPABILITY_KEYBOARDDISPLAY  0x04
> > -#define IO_CAPABILITY_INVALID          0xFF
> > -
> >  struct agent;
> >
> >  typedef void (*agent_cb) (struct agent *agent, DBusError *err,
> > diff --git a/src/device.c b/src/device.c
> > index 0ef7dcc244d2..f7a84b807878 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -43,6 +43,7 @@
> >  #include "src/shared/gatt-client.h"
> >  #include "src/shared/gatt-server.h"
> >  #include "src/shared/ad.h"
> > +#include "src/shared/mgmt.h"
> >  #include "src/shared/timeout.h"
> >  #include "btio/btio.h"
> >  #include "bluetooth/mgmt.h"
> > @@ -3375,7 +3376,7 @@ static DBusMessage *pair_device(DBusConnection *c=
onn, DBusMessage *msg,
> >         if (agent)
> >                 io_cap =3D agent_get_io_capability(agent);
> >         else
> > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> >
> >         bonding =3D bonding_request_new(msg, device, bdaddr_type, agent=
);
> >
> > @@ -6544,7 +6545,7 @@ static void att_connect_cb(GIOChannel *io, GError=
 *gerr, gpointer user_data)
> >         if (device->bonding->agent)
> >                 io_cap =3D agent_get_io_capability(device->bonding->age=
nt);
> >         else
> > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> >
> >         err =3D adapter_create_bonding(device->adapter, &device->bdaddr,
> >                                         device->bdaddr_type, io_cap);
> > @@ -7452,7 +7453,7 @@ static gboolean device_bonding_retry(gpointer dat=
a)
> >         if (bonding->agent)
> >                 io_cap =3D agent_get_io_capability(bonding->agent);
> >         else
> > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> >
> >         err =3D adapter_bonding_attempt(adapter, &device->bdaddr,
> >                                 device->bdaddr_type, io_cap);
> > diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> > index 6a7eb5798cb8..300abbae1c50 100644
> > --- a/src/shared/mgmt.c
> > +++ b/src/shared/mgmt.c
> > @@ -81,6 +81,20 @@ struct mgmt_tlv_list {
> >         uint16_t size;
> >  };
> >
> > +struct arg_table {
> > +       const char *name;
> > +       unsigned value;
> > +};
> > +
> > +static const struct arg_table iocap_arguments[] =3D {
> > +       { "DisplayOnly", MGMT_IO_CAPABILITY_DISPLAYONLY },
> > +       { "DisplayYesNo", MGMT_IO_CAPABILITY_DISPLAYYESNO },
> > +       { "KeyboardOnly", MGMT_IO_CAPABILITY_KEYBOARDONLY },
> > +       { "NoInputNoOutput", MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT },
> > +       { "KeyboardDisplay", MGMT_IO_CAPABILITY_KEYBOARDDISPLAY },
> > +       { NULL, 0}
> > +};
> > +
> >  static void destroy_request(void *data)
> >  {
> >         struct mgmt_request *request =3D data;
> > @@ -1039,3 +1053,21 @@ uint16_t mgmt_get_mtu(struct mgmt *mgmt)
> >
> >         return mgmt->mtu;
> >  }
> > +
> > +uint8_t mgmt_parse_io_capability(const char *capability)
> > +{
> > +       const char *arg;
> > +       int index =3D 0;
> > +
> > +       if (!strcmp(capability, ""))
> > +               return MGMT_IO_CAPABILITY_KEYBOARDDISPLAY;
> > +
> > +       while ((arg =3D iocap_arguments[index].name)) {
> > +               if (!strncmp(arg, capability, strlen(capability)))
> > +                       return iocap_arguments[index].value;
> > +
> > +               index++;
> > +       }
> > +
> > +       return MGMT_IO_CAPABILITY_INVALID;
> > +}
> > diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
> > index 2629fbd59cf6..a4c30075f7b7 100644
> > --- a/src/shared/mgmt.h
> > +++ b/src/shared/mgmt.h
> > @@ -13,6 +13,14 @@
> >
> >  #define MGMT_VERSION(v, r) (((v) << 16) + (r))
> >
> > +#define MGMT_IO_CAPABILITY_DISPLAYONLY         0x00
> > +#define MGMT_IO_CAPABILITY_DISPLAYYESNO                0x01
> > +#define MGMT_IO_CAPABILITY_KEYBOARDONLY                0x02
> > +#define MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT     0x03
> > +#define MGMT_IO_CAPABILITY_KEYBOARDDISPLAY     0x04
> > +#define MGMT_IO_CAPABILITY_INVALID             0xFF
>=20
> Perhaps this should be an enum to ensure things like switch statements
> do check for unhandled values.

also done. But now using an enum in src/adapter.h requires also including
"src/shared/mgmt.h" in every file where src/adapter.h is used. I've made
all these changes, but maybe we should really think about include guards.

Shall I resubmit the whole series or do you want to pick the fine commits
first?

regards,
Christian

>=20
> > +
> > +
> >  typedef void (*mgmt_destroy_func_t)(void *user_data);
> >
> >  struct mgmt;
> > @@ -89,3 +97,5 @@ bool mgmt_unregister_index(struct mgmt *mgmt, uint16_=
t index);
> >  bool mgmt_unregister_all(struct mgmt *mgmt);
> >
> >  uint16_t mgmt_get_mtu(struct mgmt *mgmt);
> > +
> > +uint8_t mgmt_parse_io_capability(const char *capability);
> > --
> > 2.51.0
> >
> >
>=20
>=20
>=20




