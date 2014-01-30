Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Thu, 30 Jan 2014 14:01:19 -0800
Message-ID: <CAD-ALXKinmbiAaH3FMA-b4byXo0CMEm1H0Dfc=bCDBwONqsfTA@mail.gmail.com>
Subject: BLE Peripheral on Ubuntu
From: Prashant R <ramapra@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

My goal is to be able to use a USB-BT adapter and make it behave like
a BLE peripheral.

So far I have been able to do LE advertising on it but would want to
add GATT services for this device.
I am unable to find documentation on how to control this as a BLE
Peripheral.Can someone point me to this?

- Is there currently a tool (opposite of  gatttool) that I can use to
publish services and characteristics ?

- My version of bluez is4.98-2ubuntu7 . I tried to upgrade to the
latest but it complains about D-BUS version being <Ver 1.6. My version
of DBUS  is  1.4.18
My question is if the GATT server support is present at the user level
using my version of 4.98-2ubuntu7?

Thanks for your help.
