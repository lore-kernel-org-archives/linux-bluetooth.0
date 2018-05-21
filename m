Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Mime-Version: 1.0
Subject: RE: Re: [PATCH] Fix improper usage of g_free
Reply-To: nagaraj.dr@samsung.com
From: Nagaraj D R <nagaraj.dr@samsung.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        SYAM SIDHARDHAN <s.syam@samsung.com>
In-Reply-To: <CABBYNZLuEuo+N7oYhcUMC2H-mB9f+WKM5FAuXGcFym_XWwLR0Q@mail.gmail.com>
Message-ID: <20180521113957epcms5p214510537221c910e5f939baabe7f22af@epcms5p2>
Date: Mon, 21 May 2018 17:09:57 +0530
Content-Type: text/plain; charset="utf-8"
References: <CABBYNZLuEuo+N7oYhcUMC2H-mB9f+WKM5FAuXGcFym_XWwLR0Q@mail.gmail.com>
        <1526615048-23393-1-git-send-email-nagaraj.dr@samsung.com>
        <CGME20180518034418epcas2p3b31813a79452e5934a438347b8edc82a@epcms5p2>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,=C2=A0=0D=0A=C2=A0=0D=0A>Hi,=0D=0A=C2=A0=0D=0A>On=C2=A0Fri,=C2=A0May=C2=
=A018,=C2=A02018=C2=A0at=C2=A06:44=C2=A0AM,=C2=A0Nagaraj=C2=A0D=C2=A0R=C2=
=A0<nagaraj.dr=40samsung.com>=C2=A0wrote:=0D=0A>>=C2=A0g_free=C2=A0should=
=C2=A0be=C2=A0used=C2=A0for=C2=A0only=C2=A0those=C2=A0memory=C2=A0allocatio=
ns=0D=0A>>=C2=A0done=C2=A0through=C2=A0glib=C2=A0APIs=0D=0A>>=C2=A0---=0D=
=0A>>=C2=A0=C2=A0client/advertising.c=C2=A0=7C=C2=A02=C2=A0+-=0D=0A>>=C2=A0=
=C2=A0src/adapter.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7C=C2=
=A02=C2=A0+-=0D=0A>>=C2=A0=C2=A02=C2=A0files=C2=A0changed,=C2=A02=C2=A0inse=
rtions(+),=C2=A02=C2=A0deletions(-)=0D=0A>>=0D=0A>>=C2=A0diff=C2=A0--git=C2=
=A0a/client/advertising.c=C2=A0b/client/advertising.c=0D=0A>>=C2=A0index=C2=
=A0045133a..5592be6=C2=A0100644=0D=0A>>=C2=A0---=C2=A0a/client/advertising.=
c=0D=0A>>=C2=A0+++=C2=A0b/client/advertising.c=0D=0A>>=C2=A0=40=40=C2=A0-75=
7,7=C2=A0+757,7=C2=A0=40=40=C2=A0void=C2=A0ad_advertise_local_name(DBusConn=
ection=C2=A0*conn,=C2=A0const=C2=A0char=C2=A0*name)=0D=0A>>=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0return;=0D=0A>>=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0g_free(ad.local_name);=0D=0A>>=C2=A0-=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0ad.local_name=C2=A0=3D=C2=A0strdup(name);=0D=0A>>=C2=
=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ad.local_name=C2=A0=3D=C2=A0g=
_strdup(name);=0D=0A>>=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0g_dbus_emit_property_changed(conn,=C2=A0AD_PATH,=C2=A0AD_IFACE,=C2=
=A0=22LocalName=22);=0D=0A>>=0D=0A>>=C2=A0diff=C2=A0--git=C2=A0a/src/adapte=
r.c=C2=A0b/src/adapter.c=0D=0A>>=C2=A0index=C2=A0c1c792a..07a4e42=C2=A01006=
44=0D=0A>>=C2=A0---=C2=A0a/src/adapter.c=0D=0A>>=C2=A0+++=C2=A0b/src/adapte=
r.c=0D=0A>>=C2=A0=40=40=C2=A0-2258,7=C2=A0+2258,7=C2=A0=40=40=C2=A0static=
=C2=A0bool=C2=A0parse_uuids(DBusMessageIter=C2=A0*value,=C2=A0struct=C2=A0d=
iscovery_filter=C2=A0*filter)=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bt_uuid_t=
o_uuid128(&uuid,=C2=A0&u128);=0D=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bt_uuid_t=
o_string(&u128,=C2=A0uuidstr,=C2=A0sizeof(uuidstr));=0D=0A>>=0D=0A>>=C2=A0-=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0filter->uuids=C2=A0=3D=C2=A0g_slist_prepend(filter->uuids,=
=C2=A0strdup(uuidstr));=0D=0A>>=C2=A0+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0filter->uuids=C2=A0=
=3D=C2=A0g_slist_prepend(filter->uuids,=C2=A0g_strdup(uuidstr));=0D=0A>>=0D=
=0A>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dbus_message_iter_next(&arriter);=0D=0A>>=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=7D=0D=0A>>=C2=A0--=
=0D=0A>>=C2=A01.9.1=0D=0A>I=C2=A0rather=C2=A0not=C2=A0use=C2=A0the=C2=A0g_s=
tr*=C2=A0then,=C2=A0so=C2=A0we=C2=A0might=C2=A0need=C2=A0to=C2=A0replace=C2=
=A0g_free=0D=0A>with=C2=A0free=C2=A0for=C2=A0local_name=C2=A0and=C2=A0also=
=C2=A0the=C2=A0filter.=0D=0A=C2=A0=0D=0AI=20agree.=20I=20will=20send=20a=20=
new=20patch
