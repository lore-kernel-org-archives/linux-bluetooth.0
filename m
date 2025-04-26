Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE31218C91F
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Apr 2025 09:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745660418; cv=pass; b=LwPmf4pkxkdjXFm/MRssS7UD4HChqYkG+y4erqzKPDD/NCP60y1R4dp3BTvp3tfMs6MgmpGRPn57dJ/bPYkbNKUlbG9TKFCBFtH7f/x6nT2cIKTm/w9+0QAcuv7DeW0W5wXk8/+V3JvoylaGStJb6dy3t8SRJ+cS9R8BWvo8pCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745660418; c=relaxed/simple;
	bh=aFeL4nb4/E2aKrRob9ujWJHukO5wS6xTrr8UJx2KKRw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c36f9O+czTQI0KcJ7IwfrLZAIoJ4Z64pB4sM1YT4VEponseCEDKHw5CkJhE1Z70GN+/+pw1ypYHVpL89o6K4jOeiJvS+AT0reG8gFm1mkvDz+tbohYMaypRdYfTGTtAA2FxlRRp798U8DiQyUPTX600I+bnEB+ZRGAeCjdPXKTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=ip3j/FCs; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="ip3j/FCs"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Zl4SQ4cNCz49Q47;
	Sat, 26 Apr 2025 12:40:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1745660407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ikF0ONaG8H75x5OiXPVw+QelcdEkBVlMWD2SHrMG9iU=;
	b=ip3j/FCsyyK8dmf0Pq4qmeXj+W+cGOzszhVru4sBCs2gm8O7DYfj9Krgo4DjI6lL0j9y7z
	msqSJiqHVlW5fghzCmOp3RpaWHGSNOKMh+Gj1jKHM9CTbU35P+Y5svkB20TP7Rur2iSj4V
	X+1YxaNYTh+PZQM3/Oys/x9GeLQ/5/pCzb25dEjr4DqoDUY//HdoYCoEqcBm2zmIfLuipj
	JIix226YYBCbb6zyx/qRnI1tGNn0RsKLqaUJflBWNcCF0kQ4uDJGo7FgDamhINQTe8n3xH
	WF97d3UxsVji0vxAShTttZgJqgtnGI8PKWJz2FTqJskRiXli4CAWODU/Hv8HBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1745660407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ikF0ONaG8H75x5OiXPVw+QelcdEkBVlMWD2SHrMG9iU=;
	b=M/PMEkUBVulXms34MW+5fWDAHXRypriZOpkNzXdrqqfofJ1JY7w3hMkAExCcWnlKzfRnpS
	J+fGOKr8H8VDvE7WEktSCG/IHi5CCQqsOzW6Aca/Xd7bCidil4KYqzFuwjnQMEpQmIt2dY
	1mLtbatBBrdtV0V5ztAsS2q0G81NR+NWzEVs8Rvc/w2ZoxWzQEuv3dsvfEdNhayfQLjJpW
	m6o4OGtvKY3eoigCvarBVdBKgxuaBkzjV6AUBzjkI9Dn/ddx5yw0dRKD0MEgcENAEGabhy
	YawAv5dUh1oJ59FT8beP1zd8MY5aZqz2nCN5f7BU4E+7BP2ckBhfYRCWEnARNQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1745660407; a=rsa-sha256;
	cv=none;
	b=VAq5eMWJTXLosVq+mOniutv+8LipHeGjeoFPVjH+4YlloLUDjktMxFVF2dqEL12z2njmtN
	uuG9EfzsydbgkouGnXwlOYd1JZGpd0DQPLfPsCShQJ+L26iO+WLsRq85fLblG0dX+XDaeq
	FhsKbHBwmAGjkD9e68W0biDm1MpZkiE/6KPFU6x7cbW+AQpzymCIvWdoZKGB30umln3vDY
	/gHPGwF8GlziGCSzHn0eORbtC0ysS07D4IAwglsJANL41wm/p2qiJpEowYGJ7oD6HEAmVX
	HJ6mUEL8dNkZKm9T7xXZVgQ4ySIzFKv/k/AMtdyUvF2/aRuk+Dm9W0aUPii5tg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <51d545c5a8110309953e59962a857b868f1630ec.camel@iki.fi>
Subject: Re: [PATCH BlueZ v3 4/5] obexd: Unregister profiles when the user
 is inactive
From: Pauli Virtanen <pav@iki.fi>
To: Andrew Sayers <kernel.org@pileofstuff.org>, 
	linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com
Date: Sat, 26 Apr 2025 12:40:05 +0300
In-Reply-To: <9a821a3d-ef4f-4a0b-b2b2-0d1d3a8f57d5@pileofstuff.org>
References: <20250425191846.639039-1-kernel.org@pileofstuff.org>
	 <20250425191846.639039-5-kernel.org@pileofstuff.org>
	 <f6b40e78d243906beef616c637a2e2cdf7ddaac9.camel@iki.fi>
	 <9a821a3d-ef4f-4a0b-b2b2-0d1d3a8f57d5@pileofstuff.org>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

la, 2025-04-26 kello 09:08 +0100, Andrew Sayers kirjoitti:
> On 25/04/2025 23:36, Pauli Virtanen wrote:
> > pe, 2025-04-25 kello 20:17 +0100, Andrew Sayers kirjoitti:
> > > Obexd is usually run as a user service, and can exhibit surprising
> > > behaviour if two users are logged in at the same time.
> > >=20
> > > Unregister profiles when the user is detected to be off-seat.
> > >=20
> > > It may be impossible to detect whether a user is on-seat in some case=
s.
> > > For example, a version of obexd compiled with systemd support might b=
e
> > > run outside of a systemd environment.  Warn and leave services
> > > registered if that happens.
> > >=20
> > > Obexd can be run as a system service, in which case this check makes =
no
> > > sense.  Disable this check when called with `--system-bus`.
> > >=20
> > > Obexd can also be run by a user that does not have an active session.
> > > For example, someone could use `ssh` to access the system.  There mig=
ht
> > > be a use case where someone needs Bluetooth access but can't log in w=
ith
> > > a keyboard, or there might be a security issue with doing so.  This i=
sn't
> > > handled explicitly by this patch, but a future patch could add suppor=
t
> > > by calling `logind_set(FALSE)` in the same way as is currently done
> > > with `--system-bus`.
> > >=20
> > > Unregister profiles by closing private connections instead of sending
> > > UnregisterProfile on the shared connection.  Pipewire has apparently
> > > found the latter to cause long shutdown delays, because bluetoothd
> > > may be shutting down and unable to handle this message.
> > >=20
> > > Based in large part on the wireplumber code mentioned by Pauli Virtan=
en:
> > > https://gitlab.freedesktop.org/pipewire/wireplumber/-/blob/master/mod=
ules/module-logind.c#L52
> > >=20
> > > Other services are likely to need similar functionality,
> > > so I have created a gist to demonstrate the basic technique:
> > > https://gist.github.com/andrew-sayers/1c4a24f86a9a4c1b1e38d109f1bd1d1=
e
> > >=20
> > > Suggested-by: Pauli Virtanen <pav@iki.fi>
> > > Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> > > ---
> > >   Makefile.obexd            |  10 ++
> > >   obexd/client/pbap.c       |  17 ++-
> > >   obexd/plugins/bluetooth.c |  14 ++-
> > >   obexd/src/logind.c        | 257 +++++++++++++++++++++++++++++++++++=
+++
> > >   obexd/src/logind.h        |  26 ++++
> > >   obexd/src/main.c          |   4 +
> > >   6 files changed, 323 insertions(+), 5 deletions(-)
> > >   create mode 100644 obexd/src/logind.c
> > >   create mode 100644 obexd/src/logind.h
> > >=20
> > > diff --git a/Makefile.obexd b/Makefile.obexd
> > > index 74dd977a0..b59cfaf8f 100644
> > > --- a/Makefile.obexd
> > > +++ b/Makefile.obexd
> > > @@ -67,6 +67,7 @@ obexd_src_obexd_SOURCES =3D $(btio_sources) $(gobex=
_sources) \
> > >   			obexd/src/main.c obexd/src/obexd.h \
> > >   			obexd/src/plugin.h obexd/src/plugin.c \
> > >   			obexd/src/log.h obexd/src/log.c \
> > > +			obexd/src/logind.h obexd/src/logind.c \
> > >   			obexd/src/manager.h obexd/src/manager.c \
> > >   			obexd/src/obex.h obexd/src/obex.c obexd/src/obex-priv.h \
> > >   			obexd/src/mimetype.h obexd/src/mimetype.c \
> > > @@ -96,6 +97,8 @@ obexd_src_obexd_LDADD =3D lib/libbluetooth-internal=
.la \
> > >  =20
> > >   if EXTERNAL_PLUGINS
> > >   obexd_src_obexd_LDFLAGS =3D $(AM_LDFLAGS) -Wl,--export-dynamic
> > > +else
> > > +obexd_src_obexd_LDFLAGS =3D
> > >   endif
> > >  =20
> > >   obexd_src_obexd_CPPFLAGS =3D $(AM_CPPFLAGS) $(GLIB_CFLAGS) $(DBUS_C=
FLAGS) \
> > > @@ -109,6 +112,13 @@ obexd-add-service-symlink:
> > >   obexd-remove-service-symlink:
> > >   endif
> > >  =20
> > > +if OBEX
> > > +if SYSTEMD
> > > +obexd_src_obexd_CPPFLAGS +=3D -DSYSTEMD
> > > +obexd_src_obexd_LDFLAGS +=3D -lsystemd
> > > +endif
> > > +endif
> > > +
> > >   obexd_src_obexd_SHORTNAME =3D obexd
> > >  =20
> > >   obexd_builtin_files =3D obexd/src/builtin.h $(obexd_builtin_nodist)
> > > diff --git a/obexd/client/pbap.c b/obexd/client/pbap.c
> > > index 90f8bdc02..51b523592 100644
> > > --- a/obexd/client/pbap.c
> > > +++ b/obexd/client/pbap.c
> > > @@ -27,6 +27,7 @@
> > >   #include "gdbus/gdbus.h"
> > >  =20
> > >   #include "obexd/src/log.h"
> > > +#include "obexd/src/logind.h"
> > >   #include "obexd/src/obexd.h"
> > >  =20
> > >   #include "transfer.h"
> > > @@ -1454,13 +1455,13 @@ static struct obc_driver pbap =3D {
> > >   	.remove =3D pbap_remove
> > >   };
> > >  =20
> > > -int pbap_init(void)
> > > +static int pbap_init_cb(void)
> > >   {
> > >   	int err;
> > >  =20
> > >   	DBG("");
> > >  =20
> > > -	conn =3D obex_get_dbus_connection();
> > > +	conn =3D obex_setup_dbus_connection_private(NULL, NULL);
> > >   	if (!conn)
> > >   		return -EIO;
> > >  =20
> > > @@ -1481,7 +1482,7 @@ int pbap_init(void)
> > >   	return 0;
> > >   }
> > >  =20
> > > -void pbap_exit(void)
> > > +static void pbap_exit_cb(void)
> > >   {
> > >   	DBG("");
> > >  =20
> > > @@ -1496,9 +1497,19 @@ void pbap_exit(void)
> > >   	}
> > >  =20
> > >   	if (conn) {
> > > +		dbus_connection_close(conn);
> > >   		dbus_connection_unref(conn);
> > >   		conn =3D NULL;
> > >   	}
> > >  =20
> > >   	obc_driver_unregister(&pbap);
> > >   }
> > > +
> > > +int pbap_init(void)
> > > +{
> > > +	return logind_register(pbap_init_cb, pbap_exit_cb);
> > > +}
> > > +void pbap_exit(void)
> > > +{
> > > +	return logind_unregister(pbap_init_cb, pbap_exit_cb);
> > > +}
> > > diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
> > > index 8cf718922..7ff27a8a8 100644
> > > --- a/obexd/plugins/bluetooth.c
> > > +++ b/obexd/plugins/bluetooth.c
> > > @@ -35,6 +35,7 @@
> > >   #include "obexd/src/transport.h"
> > >   #include "obexd/src/service.h"
> > >   #include "obexd/src/log.h"
> > > +#include "obexd/src/logind.h"
> > >  =20
> > >   #define BT_RX_MTU 32767
> > >   #define BT_TX_MTU 32767
> > > @@ -426,7 +427,7 @@ static const struct obex_transport_driver driver =
=3D {
> > >  =20
> > >   static unsigned int listener_id =3D 0;
> > >  =20
> > > -static int bluetooth_init(void)
> > > +static int bluetooth_init_cb(void)
> > >   {
> > >   	connection =3D g_dbus_setup_private(DBUS_BUS_SYSTEM, NULL, NULL);
> > >   	if (connection =3D=3D NULL)
> > > @@ -438,7 +439,7 @@ static int bluetooth_init(void)
> > >   	return obex_transport_driver_register(&driver);
> > >   }
> > >  =20
> > > -static void bluetooth_exit(void)
> > > +static void bluetooth_exit_cb(void)
> > >   {
> > >   	GSList *l;
> > >  =20
> > > @@ -462,4 +463,13 @@ static void bluetooth_exit(void)
> > >   	obex_transport_driver_unregister(&driver);
> > >   }
> > >  =20
> > > +static int bluetooth_init(void)
> > > +{
> > > +	return logind_register(bluetooth_init_cb, bluetooth_exit_cb);
> > > +}
> > > +static void bluetooth_exit(void)
> > > +{
> > > +	return logind_unregister(bluetooth_init_cb, bluetooth_exit_cb);
> > > +}
> > > +
> > >   OBEX_PLUGIN_DEFINE(bluetooth, bluetooth_init, bluetooth_exit)
> > > diff --git a/obexd/src/logind.c b/obexd/src/logind.c
> > > new file mode 100644
> > > index 000000000..2630aa361
> > > --- /dev/null
> > > +++ b/obexd/src/logind.c
> > > @@ -0,0 +1,257 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + *
> > > + *  Enable functionality only when the user is active
> > > + *
> > > + *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
> > > + *
> > > + *
> > > + */
> > > +
> > > +#ifdef SYSTEMD
> > > +
> > > +#include <assert.h>
> > > +#include <errno.h>
> > > +#include <poll.h>
> > > +#include <stddef.h>
> > > +#include <string.h>
> > > +#include <time.h>
> > > +#include <unistd.h>
> > > +#include <glib.h>
> > > +
> > > +#include <systemd/sd-login.h>
> > > +
> > > +#include "obexd/src/log.h"
> > > +#include "obexd/src/logind.h"
> > > +
> > > +static sd_login_monitor * monitor;
> > > +static int uid;
> > > +static gboolean active =3D FALSE;
> > > +static gboolean monitoring_enabled =3D TRUE;
> > > +static guint source;
> > > +
> > > +struct callback_pair {
> > > +	logind_init_cb init_cb;
> > > +	logind_exit_cb exit_cb;
> > > +};
> > > +
> > > +GSList *callbacks;
> > > +
> > > +static void call_init_cb(gpointer data, gpointer user_data)
> > > +{
> > > +	int res;
> > > +
> > > +	res =3D ((struct callback_pair *)data)->init_cb();
> > > +	if (res)
> > > +		*(int *)user_data =3D res;
> > > +}
> > > +static void call_exit_cb(gpointer data, gpointer user_data)
> > > +{
> > > +	((struct callback_pair *)data)->exit_cb();
> > > +}
> > > +
> > > +static int update(void)
> > > +{
> > > +	char *state;
> > > +	int res;
> > > +
> > > +	res =3D sd_login_monitor_flush(monitor);
> > > +	if (res < 0)
> > > +		return res;
> > > +	res =3D sd_uid_get_state(uid, &state);
> > This needs free(state) afterward.
>=20
> Good catch, will fix in the next version.
>=20
> `man sd_uid_get_state` doesn't officially say when `state` is allocated:
> https://www.freedesktop.org/software/systemd/man/latest/sd_uid_get_state.=
html
> So I'm planning to do `char *state =3D NULL`, then free() it even if res =
< 0.
>=20
> > > +	if (res < 0)
> > > +		return res;
> > > +
> > > +	if (g_strcmp0(state, "active")) {
> > > +		if (!active)
> > > +			return 0;
> > > +	} else {
> > > +		res =3D sd_uid_get_seats(uid, 1, NULL);
> > > +		if (res < 0)
> > > +			return res;
> > > +		if (active =3D=3D !!res)
> > > +			return 0;
> > > +	}
> > > +	active ^=3D TRUE;
> > > +	res =3D 0;
> > > +	g_slist_foreach(callbacks, active ? call_init_cb : call_exit_cb, &r=
es);
> > > +	return res;
> > > +}
> > > +
> > > +static gboolean event_handler(GIOChannel *source, GIOCondition condi=
tion,
> > > +				gpointer data)
> > > +{
> > > +	int res;
> > > +
> > > +	res =3D sd_login_monitor_flush(monitor);
> > > +	if (res < 0) {
> > > +		error("sd_login_monitor_flush(): %s", strerror(-res));
> > > +		return FALSE;
> > > +	}
> > > +	if (!monitoring_enabled)
> > > +		return TRUE;
> > > +	res =3D update();
> > > +	if (res < 0) {
> > > +		error("update(): %s", strerror(-res));
> > > +		return FALSE;
> > > +	}
> > > +	return TRUE;
> > > +}
> > > +
> > > +static gboolean timeout_handler(gpointer user_data)
> > > +{
> > > +	uint64_t timeout_usec;
> > > +	int res;
> > > +
> > > +	if (!event_handler(NULL, 0, NULL))
> > > +		return FALSE;
> > > +
> > > +	res =3D sd_login_monitor_get_timeout(monitor, &timeout_usec);
> > I think the g_io_add_watch() should be enough, there should not be need
> > for timer polling?
>
> The only documentation I've found about this is `man sd_login_monitor`:
> https://www.freedesktop.org/software/systemd/man/latest/sd_login_monitor.=
html
> It says "sd_login_monitor_get_timeout() will return a timeout value for
> usage in poll()", without further elaboration.=C2=A0 Presumably it's cove=
ring
> some edge case around using inotify over NFS, or it needs to do some
> internal housekeeping, or something.
>=20
> For the record, the patch replaces the timer every time because
> sd_login_monitor_get_timeout() returns a monotonic timestamp,
> which suggests it doesn't want to repeat on any useful schedule.

I think it's likely safe to just ignore get_timeout(),=C2=A0it's been
returning a dummy value since 2013 when it was added:

https://github.com/systemd/systemd/blob/main/src/libsystemd/sd-login/sd-log=
in.c#L1304

and appears to exist just for symmetry with other API

https://github.com/systemd/systemd/pull/33032#issuecomment-2305217592

> > > +	if (res < 0) {
> > > +		error("sd_login_monitor_get_timeout(): %s", strerror(-res));
> > > +		return FALSE;
> > > +	}
> > > +
> > > +	if (timeout_usec > (uint64_t)-1) {

This condition is always false?

> > > +		uint64_t time_usec;
> > > +		struct timespec ts;
> > > +
> > > +		res =3D clock_gettime(CLOCK_MONOTONIC, &ts);
> > > +		if (res < 0)
> > > +			return -errno;
> > > +		time_usec =3D (uint64_t) ts.tv_sec * 1000000 + ts.tv_nsec / 1000;
> > > +		if (time_usec > timeout_usec)
> > > +			return timeout_handler(user_data);
> > > +		g_timeout_add((timeout_usec - time_usec + 999) / 1000,
> > > +				timeout_handler, user_data);
> > > +	}
> > > +
> > > +	return FALSE;
> > > +}
> > > +
> > > +static int logind_init(void)
> > > +{
> > > +	GIOChannel *channel;
> > > +	int events;
> > > +	int fd;
> > > +	int res;
> > > +
> > > +	monitor =3D NULL;
> > > +
> > > +	DBG("");
> > > +
> > > +	if (!monitoring_enabled)
> > > +		return 0;
> > > +
> > > +	uid =3D getuid();
> > > +
> > > +	res =3D sd_login_monitor_new("uid", &monitor);
> > > +	if (res < 0) {
> > > +		monitor =3D NULL;
> > > +		goto FAIL;
> > > +	}
> > > +
> > > +	// Check this after creating the monitor, in case of race condition=
s:
> > > +	res =3D update();
> > > +	if (res < 0)
> > > +		goto FAIL;
> > > +
> > > +	events =3D res =3D sd_login_monitor_get_events(monitor);
> > > +	if (res < 0)
> > > +		goto FAIL;
> > > +
> > > +	fd =3D res =3D sd_login_monitor_get_fd(monitor);
> > > +	if (res < 0)
> > > +		goto FAIL;
> > > +
> > > +	channel =3D g_io_channel_unix_new(fd);
> > > +
> > > +	g_io_channel_set_close_on_unref(channel, TRUE);
> > > +	g_io_channel_set_encoding(channel, NULL, NULL);
> > > +	g_io_channel_set_buffered(channel, FALSE);
> > > +
> > > +	source =3D g_io_add_watch(channel, events, event_handler, NULL);
> > > +
> > > +	g_io_channel_unref(channel);
> > > +
> > > +	timeout_handler(NULL);
> > > +
> > > +	return 0;
> > > +
> > > +FAIL:
> > > +	sd_login_monitor_unref(monitor);
> > > +	monitoring_enabled =3D FALSE;
> > > +	active =3D TRUE;
> > > +	return res;
> > > +}
> > > +
> > > +static void logind_exit(void)
> > > +{
> > > +	if (source) {
> > > +		g_source_remove(source);
> > > +		source =3D 0;
> > > +	}
> > > +	sd_login_monitor_unref(monitor);
> > > +}
> > > +
> > > +static gint find_cb(gconstpointer a, gconstpointer b)
> > > +{
> > > +	return ((struct callback_pair *)a)->init_cb - (logind_init_cb)b;
> > > +}
> > > +
> > > +int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb)
> > > +{
> > > +	struct callback_pair *cbs;
> > > +
> > > +	if (!monitoring_enabled)
> > > +		return init_cb();
> > > +	if (callbacks =3D=3D NULL) {
> > > +		int res;
> > > +
> > > +		res =3D logind_init();
> > > +		if (res) {
> > > +			error("logind_init(): %s - login detection disabled",
> > > +				strerror(-res));
> > > +			return init_cb();
> > > +		}
> > > +	}
> > > +	cbs =3D g_new(struct callback_pair, 1);
> > > +	cbs->init_cb =3D init_cb;
> > > +	cbs->exit_cb =3D exit_cb;
> > > +	callbacks =3D g_slist_prepend(callbacks, cbs);
> > > +	return active ? init_cb() : 0;
> > > +}
> > > +void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_c=
b)
> > > +{
> > > +	GSList *cb_node;
> > > +
> > > +	if (!monitoring_enabled)
> > > +		return exit_cb();
> > > +	if (active)
> > > +		exit_cb();
> > > +	cb_node =3D g_slist_find_custom(callbacks, init_cb, find_cb);
> > > +	if (cb_node !=3D NULL)
> > > +		callbacks =3D g_slist_delete_link(callbacks, cb_node);
> > > +	if (callbacks =3D=3D NULL)
> > > +		logind_exit();
> > > +}
> > > +
> > > +int logind_set(gboolean enabled)
> > > +{
> > > +	int res =3D 0;
> > > +
> > > +	if (monitoring_enabled =3D=3D enabled)
> > > +		return 0;
> > > +
> > > +	monitoring_enabled =3D enabled;
> > > +	if (enabled) {
> > > +		active =3D FALSE;
> > > +		return update();
> > > +	}
> > > +
> > > +	active =3D TRUE;
> > > +	g_slist_foreach(callbacks, call_exit_cb, &res);
> > > +	return res;
> > > +}
> > > +
> > > +#endif
> > > diff --git a/obexd/src/logind.h b/obexd/src/logind.h
> > > new file mode 100644
> > > index 000000000..1a92a8b87
> > > --- /dev/null
> > > +++ b/obexd/src/logind.h
> > > @@ -0,0 +1,26 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + *
> > > + *  Enable functionality only when the user is active
> > > + *
> > > + *  Copyright (C) 2007-2010  Marcel Holtmann <marcel@holtmann.org>
> > > + *
> > > + *
> > > + */
> > > +
> > > +#ifdef SYSTEMD
> > > +
> > > +typedef int (*logind_init_cb)(void);
> > > +typedef void (*logind_exit_cb)(void);
> > > +
> > > +int logind_register(logind_init_cb init_cb, logind_exit_cb exit_cb);
> > > +void logind_unregister(logind_init_cb init_cb, logind_exit_cb exit_c=
b);
> > > +int logind_set(gboolean enabled);
> > > +
> > > +#else
> > > +
> > > +#define logind_register(init_cb, exit_cb) init_cb()
> > > +#define logind_unregister(init_cb, exit_cb) exit_cb()
> > > +#define logind_set(enabled) 0
> > > +
> > > +#endif
> > > diff --git a/obexd/src/main.c b/obexd/src/main.c
> > > index ca95a70de..df150973e 100644
> > > --- a/obexd/src/main.c
> > > +++ b/obexd/src/main.c
> > > @@ -35,6 +35,7 @@
> > >   #include "../client/manager.h"
> > >  =20
> > >   #include "log.h"
> > > +#include "logind.h"
> > >   #include "obexd.h"
> > >   #include "server.h"
> > >  =20
> > > @@ -283,6 +284,9 @@ int main(int argc, char *argv[])
> > >  =20
> > >   	__obex_log_init(option_debug, option_detach);
> > >  =20
> > > +	if (option_system_bus)
> > > +		logind_set(FALSE);
> > > +
> > >   	DBG("Entering main loop");
> > >  =20
> > >   	main_loop =3D g_main_loop_new(NULL, FALSE);

--=20
Pauli Virtanen
