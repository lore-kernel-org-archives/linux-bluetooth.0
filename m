Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com>
 <CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com>
 <3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com>
 <CAHrH25ThNCf0wy29Me6Kh5e6YzMKLSiaNiUpU4qg_=HcwaHVCA@mail.gmail.com> <3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com>
From: Arman Uguray <armansito@google.com>
Date: Tue, 02 Sep 2014 20:25:11 +0000
Message-ID: <CAHrH25SQT6gun7Q=jXcxgw-25qaqTw4i12p8VuVy7XVe15wt5g@mail.gmail.com>
Subject: Re: [PATCH] gatt api V2
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>, Arman Uguray <armansito@chromium.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Content-Type: multipart/alternative; boundary=089e013a05de9a3c9405021aea39
List-ID: <linux-bluetooth.vger.kernel.org>

--089e013a05de9a3c9405021aea39
Content-Type: text/plain; charset=UTF-8

Hi Chaojie,

The idea is to create a set of tools that can be shared among different
platform implementations (desktop, Android, etc.) without direct library
dependencies, such as glib. GAttrib is written in a way that directly
interacts with GIOChannel whereas the shared stuff use shared/io, which is
a simple abstraction that is compatible with GIOChannel and Glib mainloop,
as well as BlueZ's own mainloop implementation (monitor/mainloop.c).

Beyond removing the dependency issue, the shared code will provide a
stand-alone, functioning GATT server/client implementation that is not tied
to any daemon code. The idea is that you can instantiate a struct
bt_gatt_client, and that will do all the attribute discovery and caching
for you. The upper-layer won't need to know about the contents of ATT
protocol PDUs or explicit handling of "service changed" indications, etc
(similarly, there will be a shared/gatt-server to handle all the GATT
server magic).

Others can comment more on this, since I've been basically following
Marcel's suggestion :)

Cheers,
Arman

--089e013a05de9a3c9405021aea39
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<span style=3D"line-height:19.7999992370605px">Hi Chaojie,</span><br style=
=3D"line-height:19.7999992370605px"><br style=3D"line-height:19.79999923706=
05px"><div style=3D"line-height:19.7999992370605px">The idea is to create a=
 set of tools that can be shared among different platform implementations (=
desktop, Android, etc.) without direct library dependencies, such as glib. =
GAttrib is written in a way that directly interacts with GIOChannel whereas=
 the shared stuff use shared/io, which is a simple abstraction that is comp=
atible with GIOChannel and Glib mainloop, as well as BlueZ&#39;s own mainlo=
op implementation (monitor/mainloop.c).</div>
<div style=3D"line-height:19.7999992370605px"><br></div><div style=3D"line-=
height:19.7999992370605px">Beyond removing the dependency issue, the shared=
 code will provide a stand-alone, functioning GATT server/client implementa=
tion that is not tied to any daemon code. The idea is that you can instanti=
ate a struct bt_gatt_client, and that will do all the attribute discovery a=
nd caching for you. The upper-layer won&#39;t need to know about the conten=
ts of ATT protocol PDUs or explicit handling of &quot;service changed&quot;=
 indications, etc (similarly, there will be a shared/gatt-server to handle =
all the GATT server magic).</div>
<div style=3D"line-height:19.7999992370605px"><br></div><div style=3D"line-=
height:19.7999992370605px">Others can comment more on this, since I&#39;ve =
been basically following Marcel&#39;s suggestion :)</div><div style=3D"line=
-height:19.7999992370605px">
<br></div><div style=3D"line-height:19.7999992370605px">Cheers,</div><div s=
tyle=3D"line-height:19.7999992370605px">Arman</div>

--089e013a05de9a3c9405021aea39--
