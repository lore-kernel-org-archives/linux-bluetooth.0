Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E17E2ECD3A
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 09:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098577; cv=fail; b=J0IxeTfMWrd7ETpVzTwi0UevX0V/KDqDYRHZKkC1PQVMvJ/0RLTKKI8gj42rdXj8dvDkYuSUgD3Zxnlf0WfTZzE/xQc3yNulSPLb4ehWaDS0GU5G8dzyiAZ43fNdzH2CmzMDx8W62wTzQlyEiEPT3HnyC/EezqO6OZPu+fzhUtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098577; c=relaxed/simple;
	bh=7m6miyakOCL/3QekmRYie3cP6Iw/13QgQLTUa+//3jI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nloay8PFafOM/HC1humfu4OhGWOeS6RiuN3r7IQrdyZNQCXfgz47QrIT3k0ABj0TpaBHXuvzJUbSmYYKPhjo4KRGTRyCWq7Raxo27Yao2E9EyjgCufazWA8q/iTRiApYLPrjDS8HZrJJVCjsYO/Evt7P0wsiyS2DGGvjPVrp2WQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=pCwzo2br; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="pCwzo2br"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYYsoDP7Csi/KO+YlqS438L4faWzJxm6Tol8J+sxABvXIYGc3hIO6SMbun+OjFbR1cuOf2f49x7a085VQipe/f7x4JXLzpTPBt8h7e8BZwtNjnkMm4Hkhi3sYYZiZvthT65gVtsneo1sRkxSgKKDhyMwiD/nMnoVefSgnjwe4NNHvnLb1X1OMZUqFCKRtGCJn5gaFedQo708TvbslL+khDOBlRvlHyjODMA2MZJNCKR3HTE0mJSliLjjwI3jtf+uj5/j2ZC3Sxjgfwsqny4oPRYtGEaU7HH01YkbyCXycHdSTqMOwjp/HztTTYZcAO2NDB1PTE/XryPLn7TSjsm8BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5z5hTJvluucvqwnCtc0faa1W7fRbzCnQX0l1IS1hhic=;
 b=jZ3D7inJcfVHckr9IbGjpVqhzg5pGqE5GAniDABwpR1aMWOrGea4QZjq1qDnZ7AQtHG2yxN2+BxwQ7Efk4Wkim0cSLtC3vI/0jvrher1hc3Pnfe6BdeN3e0RuhWbT/emHwEaqCm4Ez71BhdF+Wz5r9j+YJUwpNWZn3m1etg38PwFRqYRAv5Kt9K780cs86nxmdwpbD0uaZ9M4scuNBhN7Zdf4FNc+yGVMC86C5yeGfmnA+1D9G+kl13+2w+TfnDHUicyQJfxLOk50P9YJ+Ree0LlhNAMt02Zt+NYpoCMxOSWOekUc2B1ieCC767njwdN75icBVohqFksePugSd2yVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=gmail.com smtp.mailfrom=arri.de; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=arri.de; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5z5hTJvluucvqwnCtc0faa1W7fRbzCnQX0l1IS1hhic=;
 b=pCwzo2br+6THgEEL1FjtgP+vQFzZOInuS0ALN85FEuVYTxxHFdBJnn7I75WlA70rKMZ2Vyf39rakAwRy8SxrjU8EKs1pZXDiGmGDWmY1LyXB6P/gVawbra2l3hnM/M69OypW3iWeQLcQqbZVSWn80rCiVGilxPfZFAAHq0X4j8U=
Received: from DB9PR01CA0021.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::26) by DB9PR03MB9782.eurprd03.prod.outlook.com
 (2603:10a6:10:453::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 26 Feb
 2026 09:36:07 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:1d8:cafe::bd) by DB9PR01CA0021.outlook.office365.com
 (2603:10a6:10:1d8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 09:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Thu, 26 Feb 2026 09:36:07 +0000
Received: from n9w6sw14.localnet (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 26 Feb
 2026 10:36:07 +0100
From: Christian Eggers <ceggers@arri.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 11/12] agent: move defines and parsing for I/O capability to
 shared/mgnt
Date: Thu, 26 Feb 2026 10:36:07 +0100
Message-ID: <5771968.rdbgypaU67@n9w6sw14>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <CABBYNZLH7b+N8wpF0-Fs1G=n4Hwz3VE1A5L6wx05Lb5-mPkAhQ@mail.gmail.com>
References: <20260225161715.20394-1-ceggers@arri.de> <3672959.dWV9SEqChM@n9w6sw14>
 <CABBYNZLH7b+N8wpF0-Fs1G=n4Hwz3VE1A5L6wx05Lb5-mPkAhQ@mail.gmail.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FC:EE_|DB9PR03MB9782:EE_
X-MS-Office365-Filtering-Correlation-Id: 63098dd0-0ad3-4ff8-efbb-08de751a7825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	Mt7Fp6nOvw02fWVxgTY24ZkU6/l9ZCkwKH2nmNsLaQcKRnx+zQq9LVE9Q7z+TqLt2fHFjJS96yYkQg0ZovTXOEBNDQtD3Js013IrROL3/5pOoGSBKJAWgXx6PcCzO++o0UlTWBcy2UN84D6elsil+kb3sUbhmeJ04I839zdNGRt6kq4WsrON6ekft5Y9JecQ6QAg1S790UdyEj6Ki6l0OM4ECr4SqImSBsr8Jg88bDCgqKHOGCu8qf2o96sM+q43+T+CkT2Wfv6v6wfldl+URD8BIc6h8x0beJPRT295wffYjNWFaYkbULd6G2q66hjDJJrgajGY0ByZbRGuBAMyG8QLqkJXTvxehpTX0envzFww5eI+L3RCrky/kEIiHOOL+qdIZRiqN4Ty3r5e1Dchey7hBolUzjZNiBmb/2EpjiIgPHX/QuPTC8V1IKO0ZMhLLeUY7630cEUZbdGkndx480RYpGjTIACpAy68JMLH61KqO8q1yTzH26qpWi/g/IsICZks0A78A0VeMPxYVex30Gi+k1OMHug9EG6WtEhIfmsY5q2XHOvfVOsVxX5wnyfzQIHLGyXJbc8dekcEDALrtTzlfea6dfHnCbX6JU58RPu75OJC++NxpMd97oEwAB4LERXzCqfurGmD63agiql3V1JU5aSUQFkvwuCsiQ+s6FqfYNGLvzkW1BXFHU37MN4BSPfGbvymEISRMXDf3McU5OJU/LdmHdX7fdDKTj2ssTgIQi0prm7HrY7i5GxvFRJlvbKQBJfOick4syYKmUSqVvQGdFF3m+++fE2BD8FgdGrmf7bUxWHzg9W8ZuovqxnanmobEkK5SibOvSLMVTf7hw==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bI4QJCVGVJ3I1UQkrtpX8XSuA6eCCyJf8vZFIXvr7WE4dfF7AN3AQoO2ZTXXPhIsRMigWeRW1C7LymFU9CSVJycaAItxYMMIMAhWye8YWEZFQKhPkIkr95ORT+BqkvzI2LJmsDpzj714HS+Eiq36kfqB6fL3iZdacjJE2WuEwmbx4Ith1luFQDIKkKrbUtW6bzI0n9idFoN2LL8lGzwkRcCcIjpRMMsa5qmhguhCWsxi8IbEhFFzaUR1zISHn7w6CJPdd92S6GUtlaejOC2fqR11KZe5GfYaTI1y+qbkUIyWlmQjk10DUUxVAhuIoKK6b0GJEVRmbSb+sVk5Uf2Viy7cUjrLBLM+xU++j3G4uJ5aBsh2SLPB/PJESOzOXTu+ivZX4/RAVvjmnKHAInoIcOjnEho8OuyOpn4YaD0xt/TglEtxJNxdL8mt273V18mO
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:36:07.7794
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63098dd0-0ad3-4ff8-efbb-08de751a7825
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB9782

Hi Luiz,

On Wednesday, 25 February 2026, 19:42:26 CET, Luiz Augusto von Dentz wrote:
> Hi Christian,
>=20
> On Wed, Feb 25, 2026 at 1:38=E2=80=AFPM Christian Eggers <ceggers@arri.de=
> wrote:
> >
> > Hi Luiz,
> >
> > On Wednesday, 25 February 2026, 17:38:49 CET, Luiz Augusto von Dentz wr=
ote:
> > > Hi Christian,
> > >
> > > On Wed, Feb 25, 2026 at 11:22=E2=80=AFAM Christian Eggers <ceggers@ar=
ri.de> wrote:
> > > >
> > > > Allow reusing in client/mgmt.c (next commit)
> > > > ---
> > > >  src/adapter.c     |  6 +++---
> > > >  src/agent.c       | 24 ++++--------------------
> > > >  src/agent.h       |  7 -------
> > > >  src/device.c      |  7 ++++---
> > >
> > > Shared changed should be sent separately since its license (LGPL) is
> > > different than the daemon (GPL).
> >
> > done
> >
> > >
> > > >  src/shared/mgmt.c | 32 ++++++++++++++++++++++++++++++++
> > > >  src/shared/mgmt.h | 10 ++++++++++
> > > >  6 files changed, 53 insertions(+), 33 deletions(-)
> > > >
> > > > diff --git a/src/adapter.c b/src/adapter.c
> > > > index 9bb1950a9f7d..bfabdf9a62ef 100644
> > > > --- a/src/adapter.c
> > > > +++ b/src/adapter.c
> > > > @@ -9156,7 +9156,7 @@ int adapter_set_io_capability(struct btd_adap=
ter *adapter, uint8_t io_cap)
> > > >         struct mgmt_cp_set_io_capability cp;
> > > >
> > > >         if (!btd_opts.pairable) {
> > > > -               if (io_cap =3D=3D IO_CAPABILITY_INVALID) {
> > > > +               if (io_cap =3D=3D MGMT_IO_CAPABILITY_INVALID) {
> > > >                         if (adapter->current_settings & MGMT_SETTIN=
G_BONDABLE)
> > > >                                 set_mode(adapter, MGMT_OP_SET_BONDA=
BLE, 0x00);
> > > >
> > > > @@ -9165,8 +9165,8 @@ int adapter_set_io_capability(struct btd_adap=
ter *adapter, uint8_t io_cap)
> > > >
> > > >                 if (!(adapter->current_settings & MGMT_SETTING_BOND=
ABLE))
> > > >                         set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x0=
1);
> > > > -       } else if (io_cap =3D=3D IO_CAPABILITY_INVALID)
> > > > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > +       } else if (io_cap =3D=3D MGMT_IO_CAPABILITY_INVALID)
> > > > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > >
> > > >         memset(&cp, 0, sizeof(cp));
> > > >         cp.io_capability =3D io_cap;
> > > > diff --git a/src/agent.c b/src/agent.c
> > > > index 3696575b83e6..794f81ebf18a 100644
> > > > --- a/src/agent.c
> > > > +++ b/src/agent.c
> > > > @@ -35,6 +35,7 @@
> > > >  #include "adapter.h"
> > > >  #include "device.h"
> > > >  #include "agent.h"
> > > > +#include "shared/mgmt.h"
> > > >  #include "shared/queue.h"
> > > >
> > > >  #define REQUEST_TIMEOUT (60 * 1000)            /* 60 seconds */
> > > > @@ -131,7 +132,7 @@ static void set_io_cap(struct btd_adapter *adap=
ter, gpointer user_data)
> > > >         if (agent)
> > > >                 io_cap =3D agent->capability;
> > > >         else
> > > > -               io_cap =3D IO_CAPABILITY_INVALID;
> > > > +               io_cap =3D MGMT_IO_CAPABILITY_INVALID;
> > > >
> > > >         adapter_set_io_capability(adapter, io_cap);
> > > >  }
> > > > @@ -944,23 +945,6 @@ static void agent_destroy(gpointer data)
> > > >         agent_unref(agent);
> > > >  }
> > > >
> > > > -static uint8_t parse_io_capability(const char *capability)
> > > > -{
> > > > -       if (g_str_equal(capability, ""))
> > > > -               return IO_CAPABILITY_KEYBOARDDISPLAY;
> > > > -       if (g_str_equal(capability, "DisplayOnly"))
> > > > -               return IO_CAPABILITY_DISPLAYONLY;
> > > > -       if (g_str_equal(capability, "DisplayYesNo"))
> > > > -               return IO_CAPABILITY_DISPLAYYESNO;
> > > > -       if (g_str_equal(capability, "KeyboardOnly"))
> > > > -               return IO_CAPABILITY_KEYBOARDONLY;
> > > > -       if (g_str_equal(capability, "NoInputNoOutput"))
> > > > -               return IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > -       if (g_str_equal(capability, "KeyboardDisplay"))
> > > > -               return IO_CAPABILITY_KEYBOARDDISPLAY;
> > > > -       return IO_CAPABILITY_INVALID;
> > > > -}
> > > > -
> > > >  static DBusMessage *register_agent(DBusConnection *conn,
> > > >                                         DBusMessage *msg, void *use=
r_data)
> > > >  {
> > > > @@ -979,8 +963,8 @@ static DBusMessage *register_agent(DBusConnecti=
on *conn,
> > > >                                                 DBUS_TYPE_INVALID) =
=3D=3D FALSE)
> > > >                 return btd_error_invalid_args(msg);
> > > >
> > > > -       cap =3D parse_io_capability(capability);
> > > > -       if (cap =3D=3D IO_CAPABILITY_INVALID)
> > > > +       cap =3D mgmt_parse_io_capability(capability);
> > > > +       if (cap =3D=3D MGMT_IO_CAPABILITY_INVALID)
> > > >                 return btd_error_invalid_args(msg);
> > > >
> > > >         agent =3D agent_create(sender, path, cap);
> > > > diff --git a/src/agent.h b/src/agent.h
> > > > index bd0502030fa0..03731756849c 100644
> > > > --- a/src/agent.h
> > > > +++ b/src/agent.h
> > > > @@ -9,13 +9,6 @@
> > > >   *
> > > >   */
> > > >
> > > > -#define IO_CAPABILITY_DISPLAYONLY      0x00
> > > > -#define IO_CAPABILITY_DISPLAYYESNO     0x01
> > > > -#define IO_CAPABILITY_KEYBOARDONLY     0x02
> > > > -#define IO_CAPABILITY_NOINPUTNOOUTPUT  0x03
> > > > -#define IO_CAPABILITY_KEYBOARDDISPLAY  0x04
> > > > -#define IO_CAPABILITY_INVALID          0xFF
> > > > -
> > > >  struct agent;
> > > >
> > > >  typedef void (*agent_cb) (struct agent *agent, DBusError *err,
> > > > diff --git a/src/device.c b/src/device.c
> > > > index 0ef7dcc244d2..f7a84b807878 100644
> > > > --- a/src/device.c
> > > > +++ b/src/device.c
> > > > @@ -43,6 +43,7 @@
> > > >  #include "src/shared/gatt-client.h"
> > > >  #include "src/shared/gatt-server.h"
> > > >  #include "src/shared/ad.h"
> > > > +#include "src/shared/mgmt.h"
> > > >  #include "src/shared/timeout.h"
> > > >  #include "btio/btio.h"
> > > >  #include "bluetooth/mgmt.h"
> > > > @@ -3375,7 +3376,7 @@ static DBusMessage *pair_device(DBusConnectio=
n *conn, DBusMessage *msg,
> > > >         if (agent)
> > > >                 io_cap =3D agent_get_io_capability(agent);
> > > >         else
> > > > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > >
> > > >         bonding =3D bonding_request_new(msg, device, bdaddr_type, a=
gent);
> > > >
> > > > @@ -6544,7 +6545,7 @@ static void att_connect_cb(GIOChannel *io, GE=
rror *gerr, gpointer user_data)
> > > >         if (device->bonding->agent)
> > > >                 io_cap =3D agent_get_io_capability(device->bonding-=
>agent);
> > > >         else
> > > > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > >
> > > >         err =3D adapter_create_bonding(device->adapter, &device->bd=
addr,
> > > >                                         device->bdaddr_type, io_cap=
);
> > > > @@ -7452,7 +7453,7 @@ static gboolean device_bonding_retry(gpointer=
 data)
> > > >         if (bonding->agent)
> > > >                 io_cap =3D agent_get_io_capability(bonding->agent);
> > > >         else
> > > > -               io_cap =3D IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > > +               io_cap =3D MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
> > > >
> > > >         err =3D adapter_bonding_attempt(adapter, &device->bdaddr,
> > > >                                 device->bdaddr_type, io_cap);
> > > > diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> > > > index 6a7eb5798cb8..300abbae1c50 100644
> > > > --- a/src/shared/mgmt.c
> > > > +++ b/src/shared/mgmt.c
> > > > @@ -81,6 +81,20 @@ struct mgmt_tlv_list {
> > > >         uint16_t size;
> > > >  };
> > > >
> > > > +struct arg_table {
> > > > +       const char *name;
> > > > +       unsigned value;
> > > > +};
> > > > +
> > > > +static const struct arg_table iocap_arguments[] =3D {
> > > > +       { "DisplayOnly", MGMT_IO_CAPABILITY_DISPLAYONLY },
> > > > +       { "DisplayYesNo", MGMT_IO_CAPABILITY_DISPLAYYESNO },
> > > > +       { "KeyboardOnly", MGMT_IO_CAPABILITY_KEYBOARDONLY },
> > > > +       { "NoInputNoOutput", MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT },
> > > > +       { "KeyboardDisplay", MGMT_IO_CAPABILITY_KEYBOARDDISPLAY },
> > > > +       { NULL, 0}
> > > > +};
> > > > +
> > > >  static void destroy_request(void *data)
> > > >  {
> > > >         struct mgmt_request *request =3D data;
> > > > @@ -1039,3 +1053,21 @@ uint16_t mgmt_get_mtu(struct mgmt *mgmt)
> > > >
> > > >         return mgmt->mtu;
> > > >  }
> > > > +
> > > > +uint8_t mgmt_parse_io_capability(const char *capability)
> > > > +{
> > > > +       const char *arg;
> > > > +       int index =3D 0;
> > > > +
> > > > +       if (!strcmp(capability, ""))
> > > > +               return MGMT_IO_CAPABILITY_KEYBOARDDISPLAY;
> > > > +
> > > > +       while ((arg =3D iocap_arguments[index].name)) {
> > > > +               if (!strncmp(arg, capability, strlen(capability)))
> > > > +                       return iocap_arguments[index].value;
> > > > +
> > > > +               index++;
> > > > +       }
> > > > +
> > > > +       return MGMT_IO_CAPABILITY_INVALID;
> > > > +}
> > > > diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
> > > > index 2629fbd59cf6..a4c30075f7b7 100644
> > > > --- a/src/shared/mgmt.h
> > > > +++ b/src/shared/mgmt.h
> > > > @@ -13,6 +13,14 @@
> > > >
> > > >  #define MGMT_VERSION(v, r) (((v) << 16) + (r))
> > > >
> > > > +#define MGMT_IO_CAPABILITY_DISPLAYONLY         0x00
> > > > +#define MGMT_IO_CAPABILITY_DISPLAYYESNO                0x01
> > > > +#define MGMT_IO_CAPABILITY_KEYBOARDONLY                0x02
> > > > +#define MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT     0x03
> > > > +#define MGMT_IO_CAPABILITY_KEYBOARDDISPLAY     0x04
> > > > +#define MGMT_IO_CAPABILITY_INVALID             0xFF
> > >
> > > Perhaps this should be an enum to ensure things like switch statements
> > > do check for unhandled values.
> >
> > also done. But now using an enum in src/adapter.h requires also includi=
ng
> > "src/shared/mgmt.h" in every file where src/adapter.h is used. I've made
> > all these changes, but maybe we should really think about include guard=
s.
>=20
> Not following why would adapter.h requires it? Is adapter.h returning the=
 enum?

diff --git a/src/adapter.h b/src/adapter.h
index 7a7e5c8f9dfd..377c6a8789fb 100644
=2D-- a/src/adapter.h
+++ b/src/adapter.h
@@ -207,15 +207,18 @@ int btd_adapter_passkey_reply(struct btd_adapter *ada=
pter,
                                uint32_t passkey);
=20
 int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bd=
addr,
=2D                                       uint8_t addr_type, uint8_t io_cap=
);
+                                               uint8_t addr_type,
+                                               enum mgmt_io_capability io_=
cap);
=20
 int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t *b=
daddr,
=2D                                       uint8_t addr_type, uint8_t io_cap=
);
+                                               uint8_t addr_type,
+                                               enum mgmt_io_capability io_=
cap);
=20
 int adapter_cancel_bonding(struct btd_adapter *adapter, const bdaddr_t *bd=
addr,
                                                        uint8_t addr_type);
=20
=2Dint adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_ca=
p);
+int adapter_set_io_capability(struct btd_adapter *adapter,
+                                               enum mgmt_io_capability io_=
cap);
=20
 int btd_adapter_read_local_oob_data(struct btd_adapter *adapter);
=20

Compiler output:
In file included from plugins/autopair.c:28:
=2E/src/adapter.h:211:54: warning: =E2=80=98enum mgmt_io_capability=E2=80=
=99 declared inside parameter list will not be visible outside of this defi=
nition or declaration
  211 |                                                 enum mgmt_io_capabi=
lity io_cap);
      |                                                      ^~~~~~~~~~~~~~=
~~~~
=2E/src/adapter.h:215:54: warning: =E2=80=98enum mgmt_io_capability=E2=80=
=99 declared inside parameter list will not be visible outside of this defi=
nition or declaration
  215 |                                                 enum mgmt_io_capabi=
lity io_cap);
      |                                                      ^~~~~~~~~~~~~~=
~~~~
=2E/src/adapter.h:221:54: warning: =E2=80=98enum mgmt_io_capability=E2=80=
=99 declared inside parameter list will not be visible outside of this defi=
nition or declaration
  221 |                                                 enum mgmt_io_capabi=
lity io_cap);
      |                                                      ^~~~~~~~~~~~~~=
~~~~


So, `enum mgmt_io_capability` is not used as a return value, but also using=
 it
as function argument requires prior declaration.

AFAIK, forward declaration of C-style enum is not possible. So if=20
`enum mgmt_io_capability` is declared in shared/mgmt.h, this header must be
included prior src/adapter.h

Currently, src/adapter.h is included by 56 files. In nearly all of them, I =
had
to add inclusion of src/shared/mgmt.h.

regards,
Christian
>=20
> > Shall I resubmit the whole series or do you want to pick the fine commi=
ts
> > first?
>=20
> Ive already applied the changes that I didn't have any comments, so
> please rebase and send as a new set.
>=20
> > regards,
> > Christian
> >
> > >
> > > > +
> > > > +
> > > >  typedef void (*mgmt_destroy_func_t)(void *user_data);
> > > >
> > > >  struct mgmt;
> > > > @@ -89,3 +97,5 @@ bool mgmt_unregister_index(struct mgmt *mgmt, uin=
t16_t index);
> > > >  bool mgmt_unregister_all(struct mgmt *mgmt);
> > > >
> > > >  uint16_t mgmt_get_mtu(struct mgmt *mgmt);
> > > > +
> > > > +uint8_t mgmt_parse_io_capability(const char *capability);
> > > > --
> > > > 2.51.0
> > > >
> > > >
> > >
> > >
> > >
> >
> >
> >
> >
>=20
>=20
>=20




