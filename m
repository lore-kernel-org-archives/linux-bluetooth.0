Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Robert Hancock <hancockrwd@gmail.com>
Date: Tue, 16 Jan 2018 21:46:03 -0600
Message-ID: <CADLC3L1A4PUfqigh0KMZ1nRj7SAZ4xkRwUh2itBODJ_e0XVWVg@mail.gmail.com>
Subject: Apparent bluez 5.48 regression: Headphones fail to reconnect after suspend/resume
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've come across an apparent regression in Fedora 27 as a result of an
update to bluez 5.48 with Intel 8265 Bluetooth and some Monster
Clarity HD headphones. After a suspend/resume of the laptop, the
headphones refuse to reconnect until either removing the device entry
and re-pairing or restarting bluetoothd. Downgrading bluez to 5.47
seems to fix the problem. I've added some hcidump output and log
output in Red Hat Bugzilla here:

https://bugzilla.redhat.com/show_bug.cgi?id=1534857

Any thoughts on what could be going on?
