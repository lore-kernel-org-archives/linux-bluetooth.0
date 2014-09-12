Return-Path: <cyrus@holtmann.org>
From: Bharat Bhusan Panda <bharat.panda@samsung.com>
To: 'Arman Uguray' <armansito@chromium.org>
Cc: 'BlueZ development' <linux-bluetooth@vger.kernel.org>
References: <015d01cfc20a$c9160a00$5b421e00$@samsung.com>
 <024801cfcd86$58382520$08a86f60$@samsung.com>
 <CAHrH25RUK3HWQeysAti+BHVxQ4RSVnFfL3M-BNB_4xc_x71Fuw@mail.gmail.com>
In-reply-to: <CAHrH25RUK3HWQeysAti+BHVxQ4RSVnFfL3M-BNB_4xc_x71Fuw@mail.gmail.com>
Subject: RE: Query Regarding new Gatt server attribute database
Date: Fri, 12 Sep 2014 16:44:30 +0530
Message-id: <025c01cfce7a$c9e78900$5db69b00$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> > Is there any plan to update, gatt-dbus.c, or all the functionalities
> > are moving to src/shared/ ??
> >
> 
> Others can comment more but I don't think there is (or there will be) any
> work to maintain/develop what's in src/gatt-dbus and src/gatt, at least not
> the way that they're currently built. The plan right now is to move all core
> functionality into src/shared and then (re)build most of the daemon's D-Bus
> bits using the new shared code.
Thanks for your reply, 
One more thing to ask,The Gatt methods listed in gatt-api.txt "RegisterService" and "UnregisterService" and other GATT service interfaces, these are currently handled in gatt-dbus.c.
Is there any plan to move this to src/share and, what would be the design then?
Currently in att/share there are only gatt client code placed. If there is a plan to move server functionalities to src/share, Can I continue and implement the same?
 
> 
> I don't know how well the existing GATT D-Bus server stuff works at the
> moment but I was under the impression that none of that's feature-
> complete. Others can comment more.

Yes, this is not working currently, as the current code does not update the core attrib server db, it's storing in a local service list.

Thanks
Best Regards,
Bharat

