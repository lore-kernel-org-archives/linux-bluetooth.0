Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Sun, 25 Jan 2009 03:06:52 +0000
Message-ID: <108aa36c0901241906j284c53bwf755f95d0c45592e@mail.gmail.com>
Subject: Inquiry w/ RSSI ?
From: Francis Bernard <frantic.francis@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Francisco Bernardo <franxico@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

i would like to know if is possible to get the rssi, linq quality or
transmit power level values from remote devices that aren't connected.

I know this may sound nonsense, but i'm looking for someway to get a
proximity value of unknown devices ( that haven't paired or
established a connection previously ) that only appear on the scan
results. I tried out the hcitool, and inspite of discovering the
exceptional tool it is, i haven't found what i need.

I have checked "Host Controller Interface Functional Specification -
7.7.33 Inquiry Result with RSSI Event" on the latest Bluetooth
Specification, and it made me think this could probably be possible,
but i have no knowledge about your implementation and if this could be
or is implemented.

I saw some adapted code for hcitool.c, at
http://pysportslive.googlecode.com/svn/trunk/pyrssi/bluessid.c, and I
was wondering if by making some adaptations at this level, i would
achieve my needs.

Regards,

Francisco Bernardo
