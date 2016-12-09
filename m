Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CA+LDafA2A4Jy8s4aYi8DiwZ=L6dNsQm5g6es5jXMu0pqB9fprA@mail.gmail.com>
References: <CA+LDafA2A4Jy8s4aYi8DiwZ=L6dNsQm5g6es5jXMu0pqB9fprA@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Dec 2016 11:43:55 +0200
Message-ID: <CABBYNZL2gRTEfn2TsLYn8WoxnOH=cdoG8L8FeJMQKtNT89Nqtw@mail.gmail.com>
Subject: Re: How BLE services could be remembered?
To: jose.bollo@iot.bzh
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

On Thu, Dec 8, 2016 at 4:40 PM, Jos=C3=A9 Bollo <jose.bollo@iot.bzh> wrote:
> Hello,
>
> I observe a strange behaviour of bluez dbus interface.
>
> I'm using Cinolink BT 4.0 USB Adapter (CSR BC8510 chipset), Bluez 5.43
> on debian and/or on fedora.
>
> When I first pair a BLE device, the services are correctly discovered
> and the GATT endpoints are created (a lot).
>
> Then I can use it as expected and it is nice. But when I turn off the
> computer and restart it, things become different.
>
> Because the devices are paired with LT key, they are still paired but
> the GATT services are not availables. I can connect to the device but
> it doesn't declares the GATT properties/attributes that I need. Also,
> the service advertises itself without effect.

The attributes should be saved in cache but they are only reloaded on
demand once a connection happens. Also if the database changes the
cache can be invalidated removing its attributes, this has been
changed so premature disconnections don't cause that anymore but in
case the database do actually change their attributes will be
invalidated. So if your device is known to cause premature disconnects
please try with upstream version.

> To be able to restore the attributes, I need to first remove the
> device using bluetoothctl (CancelPair doesn't seems to work) and to
> pair a new time.

CancelPair is for an ongoing pair not to actually remove an existing
one, perhaps the device is not reconnecting for some reason. Btw if
you are using privacy and the device uses directed advertising using
the identity/public address that could cause problems with
reconnections.

> Can you reproduce it? Is it the intended behaviour? How can I setup
> the system to have GATT properties+attributes present after an
> advertising? What dbus method should I call (ConnectService doesn't
> works)?

ConnectService? You mean Connect/ConnectProfile, those can be used in
case you want to force an active scanning + connect procedure,
otherwise the device shall be reconnected using passive scanning.

--=20
Luiz Augusto von Dentz
