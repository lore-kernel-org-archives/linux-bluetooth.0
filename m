Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 10 Dec 2014 13:00:06 -0800
Message-ID: <CAHrH25SS2x2fRc+av+dzQ=KvHiueHBFGAVKLrPC2+_baj5QFDQ@mail.gmail.com>
Subject: D-Bus API for GATT Connect/Disconnect
From: Arman Uguray <armansito@chromium.org>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Cc: Jonathan Dixon <joth@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

For GATT, applications using bluetoothd currently need to use
Device1.Connect and Device1.Disconnect when they want to initiate a
connection to a peripheral, though these functions are really
primarily meant for UI usage. BlueZ already has a D-Bus API for BR/EDR
profiles such as ConnectProfile/DisconnectProfile and the
ProfileManager API which is more geared towards applications and I
think we'll need something for GATT as well. The basic features that
I'm thinking of are:

   1. Sessions per D-Bus connection that provide a reference count for
the ACL connection.
   2. Correctly handling the reference count if the connection was
initiated via Device1.Connect or via auto-connect.
   3. This would be GATT only at first but it could perhaps expand to
connection-oriented channels eventually?

I don't really have an RFC API proposal at this point but I wanted to
get this discussion going. What would make most sense here?

Thanks,
Arman
