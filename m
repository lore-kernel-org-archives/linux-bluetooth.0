Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] gatt api V2
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25SLJwNKcsAABVn=bLWuCd9_FJ+eYqPRQvUo+c=454+gZw@mail.gmail.com>
Date: Wed, 3 Sep 2014 09:46:42 -0700
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <E0ACA3A9-ED9C-41FB-B3EB-DC77D7C51C64@holtmann.org>
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com> <CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com> <3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com> <CAHrH25ThNCf0wy29Me6Kh5e6YzMKLSiaNiUpU4qg_=HcwaHVCA@mail.gmail.com> <3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com> <7926AF24-265F-454D-A502-C3554072752E@holtmann.org> <CAHrH25TvLZz+xS11UssE-xKx09UHX9w--Y7YoLdaOBx3LGHxaQ@mail.gmail.com> <FE1B2504-965C-4AAC-8489-2FC5A3A77819@holtmann.org> <CAHrH25SLJwNKcsAABVn=bLWuCd9_FJ+eYqPRQvUo+c=454+gZw@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> either we can convert GAttrib to use bt_att as underlying layer or we end up having to do the conversion all at once.
>> 
>> Actually an initial starting point here could be to see how much we actually need to rely on GIOChannel for GATT. Maybe it is worth while to move the GIOChannel into GAttrib itself and just create it from the file descriptor. Once GIOChannel is an internal detail, it might be easy to switch over to struct io. All things that can be explored and need to be done eventually anyway.
>> 
> 
> Yeah, actually this may not be so bad. We might be able to turn
> GAttrib into a simple wrapper around a bt_att initially. I was
> actually a bit hesitant to modify GAttrib at first, since I don't want
> to break the Android code but I'll follow whichever route is easier in
> the end.

actually we want to convert our Android support over to bt_gatt. We have the full PTS documentation and the guys are working on end-to-end test cases using the Android HAL APIs. So hopefully such a conversion will not cause any big issues. However that said, it is a conversion that we want. Sooner than later.

> I think the GIOChannel comes from bt_io_connect and just get passed to
> g_attrib_new and for the purposes of GAttrib it is already mostly an
> internal detail (afaict). We could change it so that GAttrib maybe
> takes in a bt_att in its constructor (or the raw fd directly). I'll
> start playing with this eventually and see how it goes.

I think the only problem is BtIO and that gives us a GIOChannel. However BtIO has caused us a few issues already in the past and we might need to take a step back and just take the file descriptor and free the GIOChannel after that. At the end of the day, GIOChannel has to be removed from the whole source code. So why not start with GATT. I think it is a perfect candidate for giving this a trial run.

Regards

Marcel

