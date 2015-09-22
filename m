Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Tue, 22 Sep 2015 10:41:03 +0200
Message-ID: <CAEZxfGPDdgjcSwS6vK46Q4tMwdoD=SjV-te8chiERM-wnEP00w@mail.gmail.com>
Subject: Disabling deviceinfo plugin on chromebooks?
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As the chromium team is building and testing the Web Bluetooth API to
let websites discover and interact with nearby Bluetooth devices
(https://developers.google.com/web/updates/2015/07/interact-with-ble-devices-on-the-web)
I would love to be able to access the Device Information Service
characteristics such as Serial Number String, Hardware Revision String
and so forth.

Sadly, from what I understood, this is not achievable for now on
Chromeboooks since Bluez comes with the deviceinfo plugin enabled by
default. I do wonder now what would be the implications of disabling
the deviceinfo plugin?

You will find more information at
https://code.google.com/p/chromium/issues/detail?id=532930

Thank you in advance,
Francois - a daily Bluez user.
