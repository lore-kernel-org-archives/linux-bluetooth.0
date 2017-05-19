Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: How to use GattProfile1
From: Krasi Georgiev <krasi.root@gmail.com>
In-Reply-To: <CABBYNZ+R7dV5i+BQowigf5eddB4yxSki+xLeLFYBrN4Sfe8mJA@mail.gmail.com>
Date: Fri, 19 May 2017 16:01:39 +0300
Cc: Barry Byford <31baz66@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Message-Id: <4AE62BC6-BD11-44C7-9A0E-BC3159ED80DF@gmail.com>
References: <4CF902B9-8221-45E7-9868-52BF18A5EC5D@gmail.com> <CAAu3APYsHqAK=Kk-fzQmhhBOfnayTDB_N_Q2yCuOhr+akvxfLg@mail.gmail.com> <C1394BB3-3C11-410C-916F-80A7863C0A2B@gmail.com> <969738CC-B335-4E2F-BF3C-441110279871@gmail.com> <CAAu3APard0ZM-+++qm8938+iWkUUfNkjvq1M9cLqngtZYJAzRg@mail.gmail.com> <F1876BDF-4DC0-4CB0-A20F-2E64E24A3B92@gmail.com> <CABBYNZ+R7dV5i+BQowigf5eddB4yxSki+xLeLFYBrN4Sfe8mJA@mail.gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Luiz

I think we are getting off track here so let me explain again :)

I am writing an application to autoconnect to a bluetooth iTag - =
http://www.bestfixcy.com/how-to/how-to-itag-bluetooth-tracker/

The tag has few GATT profiles and I can=E2=80=99t understand the logical =
steps how to setup to auto-connect when it is in range.=20

I will be using golang (godbus package- dbus bindings), but that is not =
important. I was hoping someone to give a very language agnostic code =
workflow example with direct dbus calls.

make a call to dbus=E2=80=A6. to register local profile using these =
parameters, than register the auto connect  by making a call t dbus=E2=80=A6=


=46rom al videos and readings I understand that I need to register a =
local profile and than register that profile using =
org.bluez.ProfileManager1.RegisterProfile with the UUID to which service =
I want to auto connect , but can=E2=80=99t find figure out any =
specifics.



