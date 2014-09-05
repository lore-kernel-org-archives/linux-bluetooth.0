Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <E0ACA3A9-ED9C-41FB-B3EB-DC77D7C51C64@holtmann.org>
References: <1409295566-13583-1-git-send-email-chao.jie.gu@intel.com>
	<CABBYNZLqDtSk8h0-+BruH6i_+YxRrmoR8srf+KsAhvLvEq51-w@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F697D@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25ThNCf0wy29Me6Kh5e6YzMKLSiaNiUpU4qg_=HcwaHVCA@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112F6F57@SHSMSX104.ccr.corp.intel.com>
	<7926AF24-265F-454D-A502-C3554072752E@holtmann.org>
	<CAHrH25TvLZz+xS11UssE-xKx09UHX9w--Y7YoLdaOBx3LGHxaQ@mail.gmail.com>
	<FE1B2504-965C-4AAC-8489-2FC5A3A77819@holtmann.org>
	<CAHrH25SLJwNKcsAABVn=bLWuCd9_FJ+eYqPRQvUo+c=454+gZw@mail.gmail.com>
	<E0ACA3A9-ED9C-41FB-B3EB-DC77D7C51C64@holtmann.org>
Date: Fri, 5 Sep 2014 07:46:02 -0700
Message-ID: <CAHrH25R9TExRdfuu+F0qktQPbSqbQfhS1Lwg-aN6f-Ogq+T94A@mail.gmail.com>
Subject: Re: [PATCH] gatt api V2
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> actually we want to convert our Android support over to bt_gatt. We have =
the full PTS documentation and the guys are working on end-to-end test case=
s using the Android HAL APIs. So hopefully such a conversion will not cause=
 any big issues. However that said, it is a conversion that we want. Sooner=
 than later.
>

Of course, moving the Android code over to bt_gatt makes sense, though
until then it's probably ideal not to cause any regressions in the
GAttrib code path. My idea was to start using bt_gatt in the D-Bus
daemon and get it unit tested first so that we can flush out any bugs
and then start Android discussion once we have all the confidence that
things work as intended.


> I think the only problem is BtIO and that gives us a GIOChannel. However =
BtIO has caused us a few issues already in the past and we might need to ta=
ke a step back and just take the file descriptor and free the GIOChannel af=
ter that. At the end of the day, GIOChannel has to be removed from the whol=
e source code. So why not start with GATT. I think it is a perfect candidat=
e for giving this a trial run.
>

Sounds good to me. Actually, for LE connections at least, is there a
desire to move away from BtIO eventually? Why not just directly set
the socket options and open the connection in device.c? What does BtIO
do that I'm missing?

Cheers,
Arman
