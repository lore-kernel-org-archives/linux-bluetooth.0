Return-Path: <cyrus@holtmann.org>
Message-ID: <9d6d1f835a39000a57424074f0ad2fc9.squirrel@zigo.org>
Date: Thu, 3 Sep 2009 08:31:29 +0200 (CEST)
Subject: Bluez killed my dell mouse
From: =?utf-8?B?RGVubmlzIEJqw7Zya2x1bmQ=?= <db@zigo.dhs.org>
To: linux-bluetooth@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the latest version of bluez my mouse no longer work. I noticed this
when my fedora 11 installation got a new version of bluez and then my
mouse didn't work anymore.

I found that in scripts/bluetooth-hid2hci.rules there is a rule like this:

ACTION=="add", ENV{ID_VENDOR}=="413c", ENV{ID_CLASS}=="mouse",
ATTRS{bmAttributes}=="e0", KERNEL=="mouse*", RUN+="/usr/sbin/hid2hci
--method dell -v $env{ID_VENDOR} -p $env{ID_MODEL} --mode hci"

that seem to be the problem. When I remove it I can use the mouse again.
The mouse is a Dell USB mouse with vendor id 413c and product id 3010.

/Dennis


