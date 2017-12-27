Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHU4CUJn-w2WNDu35YP-CxW5HK7xhVvuvkgRShfdZvDLReDwWA@mail.gmail.com>
References: <20171226035508.30625-1-ahmeds2000x@gmail.com> <20171226035508.30625-2-ahmeds2000x@gmail.com>
 <CABBYNZLmr7RJjoebXCgHSjqeUoeTdu1EmiQeBi_Ba-yyhojAFw@mail.gmail.com>
 <CABBYNZKOpW6rbptUrAMyAN6Su3rU+13z4P0+7CVghCRmjCmOUQ@mail.gmail.com>
 <CAHU4CU+3yOG1em1daEevrCjovxO28UO1ZTsm9y39n_TQWqmYig@mail.gmail.com> <CAHU4CUJn-w2WNDu35YP-CxW5HK7xhVvuvkgRShfdZvDLReDwWA@mail.gmail.com>
From: Ahmed Alsharif <ahmeds2000x@gmail.com>
Date: Wed, 27 Dec 2017 17:29:04 +0100
Message-ID: <CAHU4CUK=rz=HynZ9wSXib433a9tx3rSUqes1Wev2C7hfVcfbzA@mail.gmail.com>
Subject: Fwd: [PATCH BlueZ 1/1] Fix bug in characteristic_start_notify.
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi again,

On Tue, Dec 26, 2017 at 5:22 PM, Ahmed Alsharif <ahmeds2000x@gmail.com> wrote:
> Hi Luiz,
>
> On Tue, Dec 26, 2017 at 2:18 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Ahmed,
>> Note that StartNotify is intended to work offline, so when it connects it
>> will subscribe which seem this would prevent that to happen.
>
> Thanks for the clarification, this does indeed prevent that from
> happening, sorry for the silly mistake on my side.

I'm interested in hearing your thoughts on the following:
Isn't it a bit inconsistent, that when a device is connected, and a
characteristic is already notifying, no error is returned when trying
to subscribe to it again (bluez-5.43 and below used to actually return
an "Already notifying" error), but when a device is not connected, an
InProgress error is returned? This means that an InProgress error just
tells us that a device is not connected, which only adds ambiguity I
think.

Cheers:)
