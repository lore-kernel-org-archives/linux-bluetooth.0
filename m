Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <7926AF24-265F-454D-A502-C3554072752E@holtmann.org>
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com>
	<CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25ThNCf0wy29Me6Kh5e6YzMKLSiaNiUpU4qg_=HcwaHVCA@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com>
	<7926AF24-265F-454D-A502-C3554072752E@holtmann.org>
Date: Tue, 2 Sep 2014 14:42:29 -0700
Message-ID: <CAHrH25TvLZz+xS11UssE-xKx09UHX9w--Y7YoLdaOBx3LGHxaQ@mail.gmail.com>
Subject: Re: [PATCH] gatt api V2
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chao Jie,

You can start playing with the code by using tools/btgatt-client,
which got merged into the tree over the weekend. This basically
demonstrates how the tools & daemon can interact with
shared/gatt-client. Also take a look at shared/att,
shared/gatt-helpers, and shared/gatt-client where the new code is
implemented.

One of the TODOs you can initially look at is supporting signed writes
using shared/att. Given the necessary keys, we want struct bt_att to
automatically sign outgoing PDUs (for client) and verify the signature
of incoming PDUs (for server) when the "signed" bit of the opcode is
set to 1. There was an email conversation some time ago on how to
access the keys; feel free to dig that up and see what you can come up
with.

The TODO items marked as C1/C2 are fairly straightforward to
implement. The others require some discussion/API design. I think the
most complex task will be to migrate the daemon code from GAttrib to
shared/gatt-client, since a lot of the plugins use that code. We'll
likely need a new plugin probing interface for GATT, as the plugins
won't perform service discovery any more.

The main thing that makes this part difficult is that GAttrib and
bt_att cannot operate on the same socket fd, since they will likely
break the sequential protocol requirements of ATT, so the plugins
can't be easily converted one at a time. We may need a deprecation
strategy for this (e.g. perhaps initially have a shared/att-gattrib.c
of sorts, that internally uses the GAttrib from device.c and then we
switch to the struct io based one once all plugins have been
converted), or perhaps we just convert it all at once in one swooping
patch set. Either way, some discussion is needed on this (perhaps in a
separate email thread).

I hope this helps!
Arman
