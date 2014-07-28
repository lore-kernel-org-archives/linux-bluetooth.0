Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Sender: armansito@google.com
In-Reply-To: <3D02B219753AD44CBDDDE484323B1774112D2C2C@SHSMSX104.ccr.corp.intel.com>
References: <1405986034-29122-1-git-send-email-armansito@chromium.org>
	<1405986034-29122-2-git-send-email-armansito@chromium.org>
	<3D02B219753AD44CBDDDE484323B1774112D2C2C@SHSMSX104.ccr.corp.intel.com>
Date: Mon, 28 Jul 2014 13:52:43 -0700
Message-ID: <CAHrH25QAR=y6Dtn4Y-t=EX1h6Oxn9ir7rWft2m+mVsBHfab1Wg@mail.gmail.com>
Subject: Re: [RFC v1 1/1] doc/gatt-api: New API properties and methods for the
 GATT D-Bus API.
From: Arman Uguray <armansito@chromium.org>
To: "Gu, Chao Jie" <chao.jie.gu@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Marcel Holtmann (marcel@holtmann.org)" <marcel@holtmann.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chaojie,


>         In this weekend, I think about this API again , and there is one =
question for you:
>         In your new proposal , bluez offer two ways for application to re=
ad characteristic value, one is to get property array of value, the other i=
s to use ReadValue method.
>         For applications, in which condition they use property array of v=
alue and in which condition they use ReadValue ? will it cause a confusion =
for user when offer two ways for user at the same time?
>

In this new proposal, the "Value" property simply stores the most
recently cached value after the most recent read procedure or
notification/indication. So, Get will simply return this cached value.
If an application wants to issue a read request to the remote
peripheral, then they will call ReadValue.


> You said "What if the characteristic doesn't support notifications but it=
's value can change?" It means cached array of value cannot be trusted in t=
he condition you said exist if this value changes happen not result from wr=
iting to the remote end device.

This is why the property is optional and wouldn't exist if the value
cannot be read or notified.

> So in my understanding, there is no worth to read characteristic value by=
 property array of value, the property's role is just to emit propertychang=
ed signal when write/read/notification operation changes its value. If so, =
we just define a signal such as ValueUpdated to tell user value has been ch=
anged is ok.
>

I only added this property back after initial feedback, which seemed
to suggest that having this cached property might have some value for
certain profile implementations. In short, if an application is always
interested in the latest, most accurate characteristic value, then
yeah, they would use ReadValue and not bother with the property at
all, as you said. I personally find that caching the value after a
write request is a bad idea, since bluetoothd can only guess what the
new value of the remote characteristic is based on the write value
that it just sent. My proposal is to only set this property and emit a
PropertiesChanged after a successful read request and on
notifications/indications. If we use PropertiesChanged this way, then
there wouldn't be a need for ValueUpdated.

I agree that this might be confusing, especially for applications that
didn't issue a read request. If one application performs a read, all
applications will then receive a PropertiesChanged signal, yet it is
not clear to them if this was due to a notification or because
somebody performed a read.

This is why, in my initial proposal, I removed the "Value" property
entirely, since any caching needed by an application can be performed
directly by them as necessary, since most apps will be interested in
getting the value directly from the remote peripheral via a call to
ReadValue anyway. Then we would just have a ValueUpdated (or
ValueNotified) signal which would only be emitted on
notifications/indications. Marcel, any thoughts on this?


> So there are two API design can be used:
> 1. array of value property  Get/Set  (This design just happen only one co=
ndition that client write the value to remote, not in which remote change i=
ts value itself spontaneously and not send notification.)
> 2. ReadValue /WriteValue method and signal ValueUpdated
>
> However, in the conclusion, array of value property and ReadValue/WriteVa=
lue can not be coexist, otherwise that design will result in ambiguity and =
not make sense.
>


Aside from the ambiguity that I mentioned above, these CAN nicely
coexist. Again, the latest proposal is to add a read-only "Value"
property which represents the cached value and have
ReadValue/WriteValue for the remote procedures on the peripheral. Set
is not allowed in this scenario and no read semantics are bound to
Get/GetAll.


-Arman
