Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] gatt api V2
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25TvLZz+xS11UssE-xKx09UHX9w--Y7YoLdaOBx3LGHxaQ@mail.gmail.com>
Date: Tue, 2 Sep 2014 20:04:50 -0700
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <FE1B2504-965C-4AAC-8489-2FC5A3A77819@holtmann.org>
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com> <CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com> <3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com> <CAHrH25ThNCf0wy29Me6Kh5e6YzMKLSiaNiUpU4qg_=HcwaHVCA@mail.gmail.com> <3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com> <7926AF24-265F-454D-A502-C3554072752E@holtmann.org> <CAHrH25TvLZz+xS11UssE-xKx09UHX9w--Y7YoLdaOBx3LGHxaQ@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> You can start playing with the code by using tools/btgatt-client,
> which got merged into the tree over the weekend. This basically
> demonstrates how the tools & daemon can interact with
> shared/gatt-client. Also take a look at shared/att,
> shared/gatt-helpers, and shared/gatt-client where the new code is
> implemented.
> 
> One of the TODOs you can initially look at is supporting signed writes
> using shared/att. Given the necessary keys, we want struct bt_att to
> automatically sign outgoing PDUs (for client) and verify the signature
> of incoming PDUs (for server) when the "signed" bit of the opcode is
> set to 1. There was an email conversation some time ago on how to
> access the keys; feel free to dig that up and see what you can come up
> with.
> 
> The TODO items marked as C1/C2 are fairly straightforward to
> implement. The others require some discussion/API design. I think the
> most complex task will be to migrate the daemon code from GAttrib to
> shared/gatt-client, since a lot of the plugins use that code. We'll
> likely need a new plugin probing interface for GATT, as the plugins
> won't perform service discovery any more.
> 
> The main thing that makes this part difficult is that GAttrib and
> bt_att cannot operate on the same socket fd, since they will likely
> break the sequential protocol requirements of ATT, so the plugins
> can't be easily converted one at a time. We may need a deprecation
> strategy for this (e.g. perhaps initially have a shared/att-gattrib.c
> of sorts, that internally uses the GAttrib from device.c and then we
> switch to the struct io based one once all plugins have been
> converted), or perhaps we just convert it all at once in one swooping
> patch set. Either way, some discussion is needed on this (perhaps in a
> separate email thread).

either we can convert GAttrib to use bt_att as underlying layer or we end up having to do the conversion all at once.

Actually an initial starting point here could be to see how much we actually need to rely on GIOChannel for GATT. Maybe it is worth while to move the GIOChannel into GAttrib itself and just create it from the file descriptor. Once GIOChannel is an internal detail, it might be easy to switch over to struct io. All things that can be explored and need to be done eventually anyway.

Regards

Marcel

