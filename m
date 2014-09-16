Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <025c01cfce7a$c9e78900$5db69b00$@samsung.com>
References: <015d01cfc20a$c9160a00$5b421e00$@samsung.com>
	<024801cfcd86$58382520$08a86f60$@samsung.com>
	<CAHrH25RUK3HWQeysAti+BHVxQ4RSVnFfL3M-BNB_4xc_x71Fuw@mail.gmail.com>
	<025c01cfce7a$c9e78900$5db69b00$@samsung.com>
Date: Tue, 16 Sep 2014 08:11:29 -0700
Message-ID: <CAHrH25QJ0iAvpyAG_avN10caxH_WH3cqJ5ZN6cGdVHc34tvvYw@mail.gmail.com>
Subject: Re: Query Regarding new Gatt server attribute database
From: Arman Uguray <armansito@chromium.org>
To: Bharat Bhusan Panda <bharat.panda@samsung.com>
Cc: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

> One more thing to ask,The Gatt methods listed in gatt-api.txt "RegisterService" and "UnregisterService" and other GATT service interfaces, these are currently handled in gatt-dbus.c.
> Is there any plan to move this to src/share and, what would be the design then?
> Currently in att/share there are only gatt client code placed. If there is a plan to move server functionalities to src/share, Can I continue and implement the same?

Yes, the current plan is to implement a shared/gatt-server (just like
we have a shared/gatt-client) and implement the server code using
that. The actual structure of the code needs some discussion and
design which I'm planning to get going in the next couple of weeks.

shared/gatt-server will act as the attribute database and handle
everything regarding ATT protocol translation so most of the data
structures internal to gatt-dbus will likely go away. We might
actually end up changing the way the D-Bus API code itself is
structured (maybe splitting it into src/gatt-client and
src/gatt-server) but that needs some design and discussion as well.
All of this will happen in the following months and I prefer not to
rush any of it so that we get all of this right.


>> I don't know how well the existing GATT D-Bus server stuff works at the
>> moment but I was under the impression that none of that's feature-
>> complete. Others can comment more.
>
> Yes, this is not working currently, as the current code does not update the core attrib server db, it's storing in a local service list.
>

I'm not super familiar with the GATT server D-Bus code the way it
currently is. As I said, I don't want to rush the shared code
implementation though I understand that you may not want to be blocked
on our progress/plans. Once we've got the design of shared/gatt-server
down, I will come up with a set of TODOs for server which you can help
with. The more people we have on board the faster this'll get done.

Cheers,
Arman
