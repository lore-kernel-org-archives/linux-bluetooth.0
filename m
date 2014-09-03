Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <FE1B2504-965C-4AAC-8489-2FC5A3A77819@holtmann.org>
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com>
	<CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25ThNCf0wy29Me6Kh5e6YzMKLSiaNiUpU4qg_=HcwaHVCA@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com>
	<7926AF24-265F-454D-A502-C3554072752E@holtmann.org>
	<CAHrH25TvLZz+xS11UssE-xKx09UHX9w--Y7YoLdaOBx3LGHxaQ@mail.gmail.com>
	<FE1B2504-965C-4AAC-8489-2FC5A3A77819@holtmann.org>
Date: Wed, 3 Sep 2014 08:00:11 -0700
Message-ID: <CAHrH25SLJwNKcsAABVn=bLWuCd9_FJ+eYqPRQvUo+c=454+gZw@mail.gmail.com>
Subject: Re: [PATCH] gatt api V2
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> either we can convert GAttrib to use bt_att as underlying layer or we end=
 up having to do the conversion all at once.
>
> Actually an initial starting point here could be to see how much we actua=
lly need to rely on GIOChannel for GATT. Maybe it is worth while to move th=
e GIOChannel into GAttrib itself and just create it from the file descripto=
r. Once GIOChannel is an internal detail, it might be easy to switch over t=
o struct io. All things that can be explored and need to be done eventually=
 anyway.
>

Yeah, actually this may not be so bad. We might be able to turn
GAttrib into a simple wrapper around a bt_att initially. I was
actually a bit hesitant to modify GAttrib at first, since I don't want
to break the Android code but I'll follow whichever route is easier in
the end.

I think the GIOChannel comes from bt_io_connect and just get passed to
g_attrib_new and for the purposes of GAttrib it is already mostly an
internal detail (afaict). We could change it so that GAttrib maybe
takes in a bt_att in its constructor (or the raw fd directly). I'll
start playing with this eventually and see how it goes.

Cheers,
Arman
