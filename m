Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <409335B4-82B3-40D2-970A-D39416F02591@holtmann.org>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
	<1405986034-29122-2-git-send-email-armansito@chromium.org>
	<3D02B219753AD44CBDDDE484323B1774112D2C2C@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25QAR=y6Dtn4Y-t=EX1h6Oxn9ir7rWft2m+mVsBHfab1Wg@mail.gmail.com>
	<409335B4-82B3-40D2-970A-D39416F02591@holtmann.org>
Date: Mon, 28 Jul 2014 16:31:45 -0700
Message-ID: <CAHrH25To=NvJC+4E6U-2S5pMc1qORvKOpbG2atY9=CFn4Zwcew@mail.gmail.com>
Subject: Re: [RFC v1 1/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Arman Uguray <armansito@chromium.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,


> I think one detail that has to be clear os that most likely nobody is cal=
ling Get directly. I will be available, but mostly all applications will ge=
t the value from calling GetManagedObjects.
>
> So lets say we talk about standard service like Device Information or Bat=
tery Status etc., every application gets these information in one go. This =
is comparing to x number of application calling ReadValue for each value in=
dividually. For values that do not change at all or change only every x day=
s this is something that makes sense and I really want. It means that appli=
cations do not have to do anything extra for these values. They are just av=
ailable and they are most likely recent or recent enough.
>

Fair enough, this was enough to sell this to me :)

> I think this depends a little bit. Most values will be return the exact s=
ame value that you write into it. That is what they are suppose to do anywa=
y. The only exception here are control endpoints. So I would agree that for=
 control endpoints we do not expose the Value property at all.
>

Yes, we shouldn't expose the Value property if the characteristic
properties field doesn't contain "read", "notify", or "indicate". With
respect to caching the value before a write operation, I'm still
hesitant towards making any assumptions about the value. I wouldn't
want to cache the value until after the write operation has completed
successfully (which is only possible to determine with the "write
request" and "reliable long write" procedure) and there may be some
race conditions where a characteristic might immediately change it's
value and send a notification before we had a chance to store the
write value. In this case the latest cached value would be incorrect.
I understand that this is an edge case but it's enough to raise some
concern.

Anyway, we can start out by caching the write value and if people run
into any issues in the field, we can then change the behavior in the
future.


Cheers,
Arman
