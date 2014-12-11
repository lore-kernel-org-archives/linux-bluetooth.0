Return-Path: <cyrus@holtmann.org>
Date: Thu, 11 Dec 2014 12:01:58 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Arman Uguray <armansito@chromium.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Jonathan Dixon <joth@google.com>
Subject: Re: D-Bus API for GATT Connect/Disconnect
Message-ID: <20141211100158.GA21139@t440s.P-661HNU-F1>
References: <CAHrH25SS2x2fRc+av+dzQ=KvHiueHBFGAVKLrPC2+_baj5QFDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHrH25SS2x2fRc+av+dzQ=KvHiueHBFGAVKLrPC2+_baj5QFDQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

On Wed, Dec 10, 2014, Arman Uguray wrote:
> For GATT, applications using bluetoothd currently need to use
> Device1.Connect and Device1.Disconnect when they want to initiate a
> connection to a peripheral, though these functions are really
> primarily meant for UI usage. BlueZ already has a D-Bus API for BR/EDR
> profiles such as ConnectProfile/DisconnectProfile and the
> ProfileManager API which is more geared towards applications and I
> think we'll need something for GATT as well. The basic features that
> I'm thinking of are:
> 
>    1. Sessions per D-Bus connection that provide a reference count for
> the ACL connection.
>    2. Correctly handling the reference count if the connection was
> initiated via Device1.Connect or via auto-connect.
>    3. This would be GATT only at first but it could perhaps expand to
> connection-oriented channels eventually?
> 
> I don't really have an RFC API proposal at this point but I wanted to
> get this discussion going. What would make most sense here?

I have nothing to directly contradict what Marcel already replied, but
I'm curious why you've omitted the kernel-managed passive scanning based
connection establishment from the description of the issue. I'd expect
that to be the principal way of connecting to peripheral devices, I'd
also expect this to work in the same way for bluetoothd-external
applications as it does for bluetoothd plugins: the application declares
its support for a UUID and bluetoothd then adds devices supporting the
UUID to the kernel-side connect list.

Johan
