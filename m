Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE431A0BD0
	for <linux-bluetooth@vger.kernel.org>; Tue, 22 Oct 2024 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612558; cv=none; b=l1e7f2maLOugjMV/gVNvGMOBi4xm/yU26GsjFJpVndMu4Z57BLczNvgJTGYGv7ej3Hluz82l4rzudMw3GjBm37GDtr28/7JjsNQe+GfNQ0ekmHPTkuQQZeP2D4iMtVQL9SBmC0gPOvP67aSgr4uDAPPktNPDq6aHgryXIXm+S1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612558; c=relaxed/simple;
	bh=SdJUhWME+HVSfL4t1h6vQ/QLAPmWuZMAts6FKWteWL8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IJrpJY3gtHUDxevFkfRSG2XjL8tJGX/Lepunck8IJB7+gR/iV9LU+cpJ772dnX+B6T/dwIRvz6j2FcGo0N1rQAFarU+32WEmhE9m7gQhJCDBEommArzp80KjhzryRLZlQYZPz+qXGe6H8TOFu5+c2ZvrPJUBNeVnn3dJqNBDjeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id E39741C0003;
	Tue, 22 Oct 2024 15:55:53 +0000 (UTC)
Message-ID: <09c18552c29d86868d1884fba81895828696080b.camel@hadess.net>
Subject: Re: [BlueZ v2 2/7] client: Use g_clear_pointer() to clean up menus
From: Bastien Nocera <hadess@hadess.net>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 22 Oct 2024 17:55:53 +0200
In-Reply-To: <CABBYNZJ1ffrQ1HqnGO-mcgFop1usa9jmLHx1cewep4iJ4C1YHQ@mail.gmail.com>
References: <20241022120051.123888-1-hadess@hadess.net>
	 <20241022120051.123888-3-hadess@hadess.net>
	 <CABBYNZJ1ffrQ1HqnGO-mcgFop1usa9jmLHx1cewep4iJ4C1YHQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net

On Tue, 2024-10-22 at 10:59 -0400, Luiz Augusto von Dentz wrote:
> Hi Bastien,
>=20
> On Tue, Oct 22, 2024 at 8:01=E2=80=AFAM Bastien Nocera <hadess@hadess.net=
>
> wrote:
> >=20
> > This would avoid warnings should the client be NULL.
> > ---
> > =C2=A0client/admin.c=C2=A0=C2=A0=C2=A0=C2=A0 | 5 ++---
> > =C2=A0client/assistant.c | 5 ++---
> > =C2=A0client/player.c=C2=A0=C2=A0=C2=A0 | 4 ++--
> > =C2=A03 files changed, 6 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/client/admin.c b/client/admin.c
> > index cd9af6f955da..9d48867bc1d7 100644
> > --- a/client/admin.c
> > +++ b/client/admin.c
> > @@ -191,7 +191,7 @@ static void proxy_removed(GDBusProxy *proxy,
> > void *user_data)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 admin_policy_status_removed(proxy);
> > =C2=A0}
> >=20
> > -static GDBusClient *client;
> > +static GDBusClient *client =3D NULL;
> >=20
> > =C2=A0static void disconnect_handler(DBusConnection *connection, void
> > *user_data)
> > =C2=A0{
> > @@ -215,6 +215,5 @@ void admin_add_submenu(void)
> >=20
> > =C2=A0void admin_remove_submenu(void)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_dbus_client_unref(client);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_clear_pointer(&client, g_dbus_c=
lient_unref);
>=20
> Don't think it is worth bumping the glib dependency just to add a
> NULL
> pointer check, in fact g_dbus_client_unref should be safe to be
> called
> with NULL pointers so I wonder if this is a false positive.

You're right, it's not the GLib gdbus. Feel free to skip this and the
preceding patch then. It should rebase cleanly, but I can send a v4 if
needed.

>=20
> > =C2=A0}
> > diff --git a/client/assistant.c b/client/assistant.c
> > index 16e94664a5c3..94052e26fd59 100644
> > --- a/client/assistant.c
> > +++ b/client/assistant.c
> > @@ -390,7 +390,7 @@ static const struct bt_shell_menu
> > assistant_menu =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {} },
> > =C2=A0};
> >=20
> > -static GDBusClient * client;
> > +static GDBusClient * client =3D NULL;
> >=20
> > =C2=A0void assistant_add_submenu(void)
> > =C2=A0{
> > @@ -409,7 +409,6 @@ void assistant_add_submenu(void)
> >=20
> > =C2=A0void assistant_remove_submenu(void)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_dbus_client_unref(client);
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client =3D NULL;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_clear_pointer(&client, g_dbus_c=
lient_unref);
> > =C2=A0}
> >=20
> > diff --git a/client/player.c b/client/player.c
> > index 188378175486..dea5922d56db 100644
> > --- a/client/player.c
> > +++ b/client/player.c
> > @@ -5694,7 +5694,7 @@ static const struct bt_shell_menu
> > transport_menu =3D {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {} },
> > =C2=A0};
> >=20
> > -static GDBusClient *client;
> > +static GDBusClient *client =3D NULL;
> >=20
> > =C2=A0void player_add_submenu(void)
> > =C2=A0{
> > @@ -5715,6 +5715,6 @@ void player_add_submenu(void)
> >=20
> > =C2=A0void player_remove_submenu(void)
> > =C2=A0{
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_dbus_client_unref(client);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_clear_pointer(&client, g_dbus_c=
lient_unref);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue_destroy(ios, transport=
_free);
> > =C2=A0}
> > --
> > 2.47.0
> >=20
> >=20
>=20
>=20

