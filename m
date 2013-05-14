Return-Path: <cyrus@holtmann.org>
Message-ID: <51921667.9010500@gmail.com>
Date: Tue, 14 May 2013 11:48:07 +0100
From: "doa379@gmail.com" <doa379@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Input Device Connection Timeout in Bluez-4.99 Package
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm running the Bluez-4.99 service for Bluetooth under Debian.
I'm trying to get a HIDD device (Bluetooth input device) to 
auto-disconnect after timeout.

The setting IdleTimeout=XXX minutes is placed in 
/etc/bluetooth/input.conf. But it doesn't seem to have any effect. The 
device is still connected past the timeout.
