Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: D-Bus API for GATT Connect/Disconnect
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAHrH25SS2x2fRc+av+dzQ=KvHiueHBFGAVKLrPC2+_baj5QFDQ@mail.gmail.com>
Date: Wed, 10 Dec 2014 22:11:53 +0100
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Jonathan Dixon <joth@google.com>
Message-Id: <68E1833E-A428-49C4-9D10-774813152877@holtmann.org>
References: <CAHrH25SS2x2fRc+av+dzQ=KvHiueHBFGAVKLrPC2+_baj5QFDQ@mail.gmail.com>
To: Arman Uguray <armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arman,

> For GATT, applications using bluetoothd currently need to use
> Device1.Connect and Device1.Disconnect when they want to initiate a
> connection to a peripheral, though these functions are really
> primarily meant for UI usage. BlueZ already has a D-Bus API for BR/EDR
> profiles such as ConnectProfile/DisconnectProfile and the
> ProfileManager API which is more geared towards applications and I
> think we'll need something for GATT as well. The basic features that
> I'm thinking of are:
> 
>   1. Sessions per D-Bus connection that provide a reference count for
> the ACL connection.
>   2. Correctly handling the reference count if the connection was
> initiated via Device1.Connect or via auto-connect.
>   3. This would be GATT only at first but it could perhaps expand to
> connection-oriented channels eventually?
> 
> I don't really have an RFC API proposal at this point but I wanted to
> get this discussion going. What would make most sense here?

the basic concept behind ProfileManager API that we used for BR/EDR worked out pretty nicely. So maybe extend the general idea with the agent and callbacks to GattManager.

When looking at the difference then we are talking about accessing remote GATT service via a local GATT profile. So what we want is implement that profile handling in an application.

If we want to avoid overloading we could use GattProfileManager and GattProfile as terms to implement that. However the general idea that you get the connection status via the callback (in this case it would be an object path and not a fd of course) seem still valid. Especially with LE we have to handle the auto-connect cases gracefully.

And if we have a connection oriented channel assigned with a GATT profile, then that could be just reported via an extra callback. In that case it would be exactly like we do within ProfileManager.

Regards

Marcel

