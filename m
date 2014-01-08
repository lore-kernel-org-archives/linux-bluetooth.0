Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 8 Jan 2014 14:24:37 +0530
Message-ID: <CAMLKGW41ex0z6Xei6BDdX4upGFW1s2z29ru261xTbqiUiR7ZNg@mail.gmail.com>
Subject: bluez Low Energy to RFCOMM data streaming and RFCOMM Server Just
 Works Pairing
From: code jug <codejug.cj@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Everyone,

I have a requirement where I have to
1.get data from bluetooth low energy peripheral.
2.send data to bluetooth classic Device. ( by setting up rfcomm server )
3.Use a single dongle to do both ( if possible ) I have IOgear GBU521

The whole setup needs to run on a raspberry pi "without any user
intervention" for pairing etc.

I have the means to get data from the peripheral..

I want to set a default password (like "1234") so that any device can just
connect to it and receive the data via rfcomm.

Pairing always generates a key on my phone, and there is a prompt on the
linux system. I want it to happen with a default password and not by
prompting. something like pairing to a JYMCU from a phone.

please help.

Regards,
cj
