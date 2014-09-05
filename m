Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] gatt api V2
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25R9TExRdfuu+F0qktQPbSqbQfhS1Lwg-aN6f-Ogq+T94A@mail.gmail.com>
Date: Fri, 5 Sep 2014 10:46:46 -0700
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <3F2C370D-72F5-430C-A957-8FB5F6058E15@holtmann.org>
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com> <CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com> <3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com> <CAHrH25ThNCf0wy29Me6Kh5e6YzMKLSiaNiUpU4qg_=HcwaHVCA@mail.gmail.com> <3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com> <7926AF24-265F-454D-A502-C3554072752E@holtmann.org> <CAHrH25TvLZz+xS11UssE-xKx09UHX9w--Y7YoLdaOBx3LGHxaQ@mail.gmail.com> <FE1B2504-965C-4AAC-8489-2FC5A3A77819@holtmann.org> <CAHrH25SLJwNKcsAABVn=bLWuCd9_FJ+eYqPRQvUo+c=454+gZw@mail.gmail.com> <E0ACA3A9-ED9C-41FB-B3EB-DC77D7C51C64@holtmann.org> <CAHrH25R9TExRdfuu+F0qktQPbSqbQfhS1Lwg-aN6f-Ogq+T94A@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

>> actually we want to convert our Android support over to bt_gatt. We have the full PTS documentation and the guys are working on end-to-end test cases using the Android HAL APIs. So hopefully such a conversion will not cause any big issues. However that said, it is a conversion that we want. Sooner than later.
>> 
> 
> Of course, moving the Android code over to bt_gatt makes sense, though
> until then it's probably ideal not to cause any regressions in the
> GAttrib code path. My idea was to start using bt_gatt in the D-Bus
> daemon and get it unit tested first so that we can flush out any bugs
> and then start Android discussion once we have all the confidence that
> things work as intended.

sounds good to me.

>> I think the only problem is BtIO and that gives us a GIOChannel. However BtIO has caused us a few issues already in the past and we might need to take a step back and just take the file descriptor and free the GIOChannel after that. At the end of the day, GIOChannel has to be removed from the whole source code. So why not start with GATT. I think it is a perfect candidate for giving this a trial run.
>> 
> 
> Sounds good to me. Actually, for LE connections at least, is there a
> desire to move away from BtIO eventually? Why not just directly set
> the socket options and open the connection in device.c? What does BtIO
> do that I'm missing?

For LE ATT it is not doing much. The fixed channel for ATT is super easy to handle. Either you connect() on it or you listen() + accept() and that is it. Besides the elevation of security and telling the kernel about the new MTU, it does not do anything special.

That is why I am saying that for LE ATT, the file descriptor might be a lot easier than involving BtIO. However for GATT over BR/EDR, that story is not that simple. There we do not use a fixed channel and use instead a connection oriented channel.

Regards

Marcel

