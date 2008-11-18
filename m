Return-Path: <cyrus@holtmann.org>
Message-ID: <f86d2a880811181148x724e7ff8s474a1821d50c58e3@mail.gmail.com>
Date: Tue, 18 Nov 2008 14:48:20 -0500
From: "David Merrill" <dmerrill@media.mit.edu>
To: linux-bluetooth@vger.kernel.org
Subject: one "talker" multiple "listeners" possible for inquiry scan with RSSI?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello everyone -

I am getting to know bluez, reading the BT spec, playing with pybluez
- and I have a multi-adapter question I hope someone may know the
answer to.

I want to capture the RSSI from a mobile phone from several Bluetooth
radio dongles on a linux system, so I can try to estimate where the
mobile phone is. I find that when I have all radios doing inquiry
scans with RSSI at the same time, it generates a lot of radio traffic,
and WiFi in the area slows down.

So I'm wondering, can I have one radio initiate the inquiry scan with
RSSI, and have the other 5 radios just listen for the replies from the
mobile phone without "talking"? Could this be accomplished just by
setting the hardware address of the "listeners" to match the address
of the "talker", then they would receive the replies - or is there
some hand-shaking / delivery guarantee algorithm that is required that
would not be possible if the listeners remain quiet?

thanks!
-David Merrill
--
MIT Media Lab
dmerrill@media.mit.edu
http://web.media.mit.edu/~dmerrill/
