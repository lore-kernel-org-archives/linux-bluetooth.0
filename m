Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCBC3F03@dnce01.ent.ti.com>
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
	<4EA6143E.4000606@googlemail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8D28@dnce01.ent.ti.com>
	<CAKT1EBeJB2FDrv6Xp_bGV3eFDEe5ecvnBN0rKniYxw5++Q9NfA@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA8F85@dnce01.ent.ti.com>
	<CAKT1EBcd6dQq3bzOsW3Fuwv=d8J=yDvsJjbp_ELEAQUjfyRx9g@mail.gmail.com>
	<7769C83744F2C34A841232EF77AEA20C01DCAA9265@dnce01.ent.ti.com>
	<alpine.DEB.2.02.1110270003090.30044@mathewm-linux>
	<7769C83744F2C34A841232EF77AEA20C01DCBC3F03@dnce01.ent.ti.com>
Date: Thu, 27 Oct 2011 16:31:09 +0300
Message-ID: <CABBYNZ+Hq4-AAg3TsLi-Vh0eC2p_ZtD2vthBfc3Unww+Km6-Mg@mail.gmail.com>
Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: "Ganir, Chen" <chen.ganir@ti.com>
Cc: Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"bgix@codeaurora.org" <bgix@codeaurora.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen,

On Thu, Oct 27, 2011 at 11:22 AM, Ganir, Chen <chen.ganir@ti.com> wrote:
> Hi Mat.
>
>> -----Original Message-----
>> From: Mat Martineau [mailto:mathewm@codeaurora.org]
>> Sent: Thursday, October 27, 2011 9:17 AM
>> Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
>>
>> Hi Chen -
>>
>> On Wed, 26 Oct 2011, Ganir, Chen wrote:
>>
>> > Hi.
>> >
>> > Here's my proposal for some modifications to the existing attribute-
>> api.doc file.
>> >
>> > These additions include :
>> > 1. Support for more properties, such as writable, readable, notify
>> > 2. Remove Value from the properties, and handle write/read with
>> specific functions. This was done since currently the value is only
>> read once from the server, and there is no way to refresh the value
>> using the dbus API. In addition, the value can be written in multiple
>> ways (we currently support write with response and write without
>> response, but future write methods include write reliable and write
>> signed, which may be required by profiles in the future).
>> >
>> > Here's the diff from the current docs/attribute-api.txt file :
>> >
>> > ---->8---------------
>> > diff --git a/doc/attribute-api.txt b/doc/attribute-api.txt
>> > index 98d7f30..fbc6957 100644
>> > --- a/doc/attribute-api.txt
>> > +++ b/doc/attribute-api.txt
>> > @@ -112,6 +112,17 @@ Methods                dict GetProperties()
>> >
>> >                     Possible Errors: org.bluez.Error.InvalidArguments
>> >
>> > +           array{byte} ReadValue()
>> > +
>> > +               Read the value of the characteristic.
>> > +
>>
>> One aspect of the current client implementation is that it caches the
>> read values within bluetoothd.  Do you prefer to completely eliminate
>> that storage and always have ReadValue fetch from the remote device?
>>
>> If there's still a use case for locally cached values (maybe there
>> isn't), a "method" parameter could specify the source of the data.  It
>> could also provide some future-proofing for ReadValue.
>>
>
> I do not see any reason why caching of data is required. Data should be read directly from the GATT server. Caching it may cause inconsistency. There is also no reason to read the values on characteristic object creation in the client.c file. I think the decision of reading the value should be by the user and not the system.
> In addition, Value is not a property of a characteristic.

Actually is the other way round, caching is the only way to maintain
data consistency otherwise we will never be able to do notifications
properly because clients can, and probably will, keep polling at
different rate, also this remove any possibility of doing power safe
not to me mention that we will have to queue the requests once one is
pending which can cause other problems like timeouts and etc.

>
>
>> > +           int WriteValue(array{byte} value, int method)
>> > +
>> > +               Write the value of the characteristic, with specified
>> method :
>> > +               0: Write without response. Always return 0.
>> > +               1: Write with response. Return server response code.
>> > +               Other write methods will be added in the future.
>> > +

D-Bus does not have enum type, so please use string that describes the
method and the return response, actually for the response it would be
better to use void if success and use D-Bus error for invalid/error
responses.

>> This addresses the shortcomings we saw with SetProperty, and also
>> gives options for the future - seems like a great idea to me!
>>
>>
>> > Properties  string UUID [readonly]
>> >
>> >                     UUID128 of this characteristic.
>> > @@ -142,15 +153,58 @@ Properties    string UUID [readonly]
>> >                       uint16 | Description: Description of the
>> characteristic defined
>> >                              | in a high layer profile.
>> >
>> > -           array{byte} Value [readwrite]
>> > -
>> > -                   Raw value of the Characteristic Value attribute.
>> > -
>> >             string Representation (of the binary Value) [readonly]
>> >
>> >                     Friendly representation of the Characteristic Value
>> >                     based on the format attribute.
>> >
>> > +           boolean Broadcast [readwrite]
>> > +
>> > +               Indicates whether this characteristic is broadcasted or
>> not.
>> > +               If GATT Server Characteristic Configuration descriptor
>> > +               is not available for this characteristic, or if the
>> characteristic
>> > +               properties do not allow this, writing to this property
>> is not
>> > +               allowed.
>> > +
>> > +           boolean Indicate [readwrite]
>> > +
>> > +               Indicates whether this characteristic is notified or
>> not.
>> > +               If GATT Client Characteristic Configuration descriptor
>> > +               is not available for this characteristic, or if the
>> characteristic
>> > +               properties do not allow this, writing to this property
>> is not
>> > +               allowed.
>> > +
>> > +           boolean Notify [readwrite]
>> > +
>> > +               Indicates whether this characteristic is indicated or
>> not.
>> > +               If GATT Client Characteristic Configuration descriptor
>> > +               is not available for this characteristic, or if the
>> characteristic
>> > +               properties do not allow this, writing to this property
>> is not
>> > +               allowed.

Notify and Indicate are useless without a way to be notified, so Im
not sure what is really the point by removing the Value property it
cannot be signaled via PropertyChanged.

>> > +           boolean Readable [readonly]
>> > +
>> > +               Indicates wether this characteristic value can be read.
>> > +
>> > +           boolean WritableNoRsp [readonly]
>> > +
>> > +               Indicates whether this characteristic value can be
>> written without
>> > +               response.
>> > +
>> > +           boolean WritableRsp [readonly]
>> > +
>> > +               Indicates whether this characteristic can be written
>> with response.
>> > +
>> > +           boolean WritableSigned [readonly]
>
> The WritableSigned is going to be changed to WritableAuth (this is true for both Authenticated link or signed GATT Write commands).
>
>> > +
>> > +               Indicates whether this characteristic can be written
>> with signed
>> > +               authentication method.
>> > +
>> > +           boolean WritableReliable [readonly]
>> > +
>> > +               Indicates whether this characteristic can be written
>> with the
>> > +               reliable write procedure.
>> > +

Create an array of string WriteMethods which represents the methods
supported by the characteristic.

>> > Characteristic Watcher hierarchy
>> > ===============================
>> >
>> > --------8<-----------
>> >
>> > I would appreciate your comments on this.
>>
>> The additional properties also seem like nice additions, and work well
>> to provide clear differentiation between the characteristic value and
>> other metadata.
>>
>> Thanks for the proposal!

Write method is probably fine, and the new properties might be useful,
but IMO we need to keep the caching otherwise this will eventually
became o polling festival, also we have to keep in mind that this is
to be accessible by multiple applications simultaneously and by
application I mean end user application because intermediate layer
will only complicate things even more for no benefit, for Android you
guys should really consider writing a wrapper and exposing the
characteristics directly to the application.

-- 
Luiz Augusto von Dentz
