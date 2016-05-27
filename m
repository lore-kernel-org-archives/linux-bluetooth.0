Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 27 May 2016 13:19:30 +0100
Message-ID: <CAAu3APZGhPCoLw3qykYb58V-UZAz+nzM5XsnowBj_vqZRo7MUQ@mail.gmail.com>
Subject: peripheral and broadcast avertisement
From: Barry Byford <31baz66@gmail.com>
To: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm looking to do some experiments with Eddystone-URL beacons using
the DBus interface from Python. The idea I'm exploring is to have an
Eddystone-URL beacon give a URL to a web bluetooth enabled site that
then connects to the advertised peripheral.

I have the BlueZ DBus advertising API working for one peripheral
service or one broadcast Eddystone-URL beacon. What I am unable to get
working with BlueZ DBus is to have the peripheral service and beacon
being advertised together.

I am not ruling out that this is an issue with how I've structured my
code but it would be good hear that someone else has been successful
in having a combination of peripheral and broadcast together with the
DBus API.

For reference my code is at:
https://github.com/ukBaz/python-bluezero/blob/master/examples/light_switch.py
https://github.com/ukBaz/python-bluezero/blob/master/examples/eddystone-url-beacon.py

Thanks in advance,
Barry
