Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150930043444.GA21773@t440s.P-661HNU-F1>
References: <CABOZqnjSPbO-cNkSryq5GXBKTqtE-1TPMKMgTAwtd9YoO4i-4A@mail.gmail.com>
	<20150929064937.GA26120@t440s.lan>
	<CABOZqnjj4hpAVLYKgC6CxwrFUaz7ZNn5Yhvz7DCk3u30Cp3urg@mail.gmail.com>
	<20150930043444.GA21773@t440s.P-661HNU-F1>
Date: Wed, 7 Oct 2015 10:16:02 -0700
Message-ID: <CABOZqnib8cEiVCvOcQiSQ1fMa+OihAh3QrMZEEOvTFkgworD-g@mail.gmail.com>
Subject: Re: SDP query via D-Bus?
From: Mark Spruiell <mes@zeroc.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Sep 29, 2015 at 9:34 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Mark,
>
> On Tue, Sep 29, 2015, Mark Spruiell wrote:
>> Thanks for the reply.
>
> No problem, but please don't top-post on this mailing list. Use in-line
> quoting instead.

Got it.

>> I understand how a server can use RegisterProfile to advertise its
>> UUID & RFCOMM channel with SDP (as demonstrated in test-profile).
>>
>> It's still not clear to me how a client can use D-Bus to establish an
>> RFCOMM socket connection given a device address & UUID. Can you point
>> me in the right direction?
>
> The same interface can be used for both client and server role. Take a
> look at the "Role" option for RegisterProfile (with test-profile you'd
> pass -c to it). This basically tells bluetoothd that your application is
> capable of supporting the client role of a certain profile.
>
> To actually connect to the profile (which should cause a NewConnection
> call to your application, giving it the socket) you'd use the usual
> ConnectProfile or Connect methods on the Device1 interface (see
> doc/device-api.txt, you can play with these e.g. using the "connect"
> command in bluetoothctl (with no parameters it maps to Device1.Connect
> and with one parameter (the UUID) to Device1.ConnectProfile).
>
> The ConnectProfile call should always work, whereas for your profile to
> be included in the set of profiles connected using Connnect you'd need
> to set the AutoConnect option to true when registering your profile.

Thanks, that helped a lot.

On a related note, I noticed that a server can specify a value of 0
for its RFCOMM channel when calling RegisterProfile and bluetoothd
seems to select an available channel. Is there any way for the server
to discover which RFCOMM channel was selected, aside from waiting for
the first incoming connection?

Mark
