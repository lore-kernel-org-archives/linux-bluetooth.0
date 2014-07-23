Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <D03CCCE3-51B5-4B3F-AB2D-AA9D766DCCCC@holtmann.org>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
	<20140722085507.GA29664@t440s.lan>
	<CAHrH25SR83cXq-xGQz4x7axjcW=CUL_VCcAfhny_RyZ+t0oZ-g@mail.gmail.com>
	<3D02B219753AD44CBDDDE484323B1774112D121F@SHSMSX104.ccr.corp.intel.com>
	<CAHrH25RpdMCS=eizPUa5S-y0qBHyWQk6co1sJcwAQO9iC0xL=Q@mail.gmail.com>
	<D03CCCE3-51B5-4B3F-AB2D-AA9D766DCCCC@holtmann.org>
Date: Wed, 23 Jul 2014 13:39:27 -0700
Message-ID: <CAHrH25TQUw0yb=5dL4eXMqrv8DL=LTUBs+oHHeDFwisd7i1KKw@mail.gmail.com>
Subject: Re: [RFC v1 0/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Arman Uguray <armansito@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gu, Chao Jie" <chao.jie.gu@intel.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>, Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

> since InterfacesAdded is per object path, the extra Characteristics array=
 makes sense. However that really only applies to application passively mon=
itoring the bus objects and properties. The initiator of service discovery =
should only return from that method call when all other object signals have=
 been send out. Similar to what we are doing with pairing or other potentia=
l long run asynchronous method calls.
>

That makes sense. Then again we don't really have a clear method for
this yet other than org.bluez.Device1.Connect. We are going to have to
figure out the behavior of that method when plugins and the GATT DBus
API are involved as we build the new stack. I also have in mind a
separate, application-specific method for creating a GATT connection
(something like ConnectGatt), where the system UI would call the old
Connect/Disconnect methods but applications would have to use a
ConnectGatt/DisconnectGatt API that keeps track of the different dbus
connections/sessions, but that's a subject for another discussion and
I haven't fully thought this through yet.

Coming back to your point, yes, the application that called Connect
should receive InterfacesAdded for all objects before the call
returns, as you said. Other applications might be passively observing
these events, so they can also wait for PropertiesChanged on
"Characteristics" to know that object creation for a particular
service is complete.

Cheers,
Arman
