Return-Path: <cyrus@holtmann.org>
Message-ID: <1384350278.5071.6.camel@nuvo>
Subject: Adapter name reset on suspend/resume
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Wed, 13 Nov 2013 14:44:38 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Heya,

After suspending and resuming my laptop, hci0's name is reset to what
looks like the factory name:
$ hciconfig -a | grep Name
	Name: 'BCM20702A'

This is the device in question:
Bus 001 Device 004: ID 0a5c:21e6 Broadcom Corp. BCM20702 Bluetooth 4.0 [ThinkPad]

And my laptop is a Lenovo X1 Carbon.

Neither udevadm nor btmon show the device going away on suspend and
coming back on resume.

Any ideas?

