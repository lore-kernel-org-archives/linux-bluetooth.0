Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Sujay Sarkhel <ssarkhe@ncsu.edu>
Date: Fri, 14 Nov 2014 20:13:13 -0800
Message-ID: <CAE7yNv9vBFaBincdFbf=jRGMd1iD-biA4FRhwi5k4b2i2Wdt6Q@mail.gmail.com>
Subject: Thermometer D-Bus API Signature
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I was looking at the Health Thermometer Watcher hierarchy under
docs/thermometer-api.txt and I guess the signature for the following
method is incorrect:

           void MeasurementReceived(dict measurement)

In my opinion, it should be:

       void MeasurementReceived(object device, dict measurement)

i.e. same as the one defined under heartrate-api.txt

Unfortunately, I do not have an actual thermometer or an emulator to
verify this but looking at the source code:
https://git.kernel.org/cgit/bluetooth/bluez.git/tree/profiles/thermometer/thermometer.c
for the method update_watcher (line #277), it looks that way.

Can some developer kindly verify this please? Thanks!

Regards,
Sujay Sarkhel
