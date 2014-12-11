Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20141211100158.GA21139@t440s.P-661HNU-F1>
References: <CAHrH25SS2x2fRc+av+dzQ=KvHiueHBFGAVKLrPC2+_baj5QFDQ@mail.gmail.com>
	<20141211100158.GA21139@t440s.P-661HNU-F1>
Date: Thu, 11 Dec 2014 07:35:19 -0800
Message-ID: <CAHrH25SNwui=yFdEOg7=7xp3guwLgisSAgjs58D8478--uWS2A@mail.gmail.com>
Subject: Re: D-Bus API for GATT Connect/Disconnect
From: Arman Uguray <armansito@google.com>
To: Arman Uguray <armansito@chromium.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Jonathan Dixon <joth@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> On Thu, Dec 11, 2014 at 2:01 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Arman,
>
> On Wed, Dec 10, 2014, Arman Uguray wrote:
>> For GATT, applications using bluetoothd currently need to use
>> Device1.Connect and Device1.Disconnect when they want to initiate a
>> connection to a peripheral, though these functions are really
>> primarily meant for UI usage. BlueZ already has a D-Bus API for BR/EDR
>> profiles such as ConnectProfile/DisconnectProfile and the
>> ProfileManager API which is more geared towards applications and I
>> think we'll need something for GATT as well. The basic features that
>> I'm thinking of are:
>>
>>    1. Sessions per D-Bus connection that provide a reference count for
>> the ACL connection.
>>    2. Correctly handling the reference count if the connection was
>> initiated via Device1.Connect or via auto-connect.
>>    3. This would be GATT only at first but it could perhaps expand to
>> connection-oriented channels eventually?
>>
>> I don't really have an RFC API proposal at this point but I wanted to
>> get this discussion going. What would make most sense here?
>
> I have nothing to directly contradict what Marcel already replied, but
> I'm curious why you've omitted the kernel-managed passive scanning based
> connection establishment from the description of the issue. I'd expect
> that to be the principal way of connecting to peripheral devices, I'd
> also expect this to work in the same way for bluetoothd-external
> applications as it does for bluetoothd plugins: the application declares
> its support for a UUID and bluetoothd then adds devices supporting the
> UUID to the kernel-side connect list.
>

I didn't specifically mention the passive scanning as I generally
pooled it under "auto-connect". But yes, that definitely counts. In
fact, most of the problems that I run into with connection behavior
stem from bluetoothd not properly managing which devices should remain
in the kernel-side connect list, such as calling
device_set_auto_connect with TRUE in add_attio_callbacks and never
setting it to FALSE on remove_attio_callbacks, or having this logic
work for even the most mundane profiles/plugins such as profiles/gatt
or for profiles that may not be immediately in use to warrant
auto-connections (such as profiles/heartrate).

So this API suggestion would definitely address that case as well, I
just used auto-connect as the term for it :) But as you say, passive
background-scanning based connections will especially apply to all
outgoing connections as we move forward with the previous fixes to
L2CAP connect that we discussed earlier (which I didn't get around do
write any patches for yet).

I'm hoping to revise how auto-connect should work for internal
plugins, by perhaps adding a flag to btd_device_add_attio_callbacks
(and btd_device_add_gatt_callbacks that I proposed in an earlier patch
set) that indicates whether this should enable auto-connect and keep a
reference count in btd_device to determine when it should be disabled
(when a service gets removed via "Service Changed" for instance).

> Johan

Arman
