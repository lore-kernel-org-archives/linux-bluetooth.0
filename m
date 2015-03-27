Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Damiano Albani <damiano.albani@gmail.com>
Date: Fri, 27 Mar 2015 15:57:36 +0100
Message-ID: <CAKys951DWG60ehow1kWWTrpup8GuRswyrY1QHR1uRu1hbFYC7g@mail.gmail.com>
Subject: SAP client implementation
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

While searching for information about support for SIM Access Profile
(SAP) in Linux, I've seen that there exists a SAP *server*
implementation in BlueZ.

But that's the piece of software that typically resides in a
smartphone — in a well designed one anyway, stock Android and iPhone
not fitting in that description...
In my case, what I'm trying to do is to make use of this SAP
capability found in smartphones, from a remote computer.
So I basically need a SAP *client* implementation, which BlueZ currently lacks.

Back in 2010, someone (Suraj Sumangala) did some work on this topic.
Here's the related discussion thread on the mailing-list:
http://comments.gmane.org/gmane.linux.bluez.kernel/7944
And the code stored in a (soon-to-disappear) Gitorious repository:
https://gitorious.org/sap-client/sap-client
The interesting bit is in "sap/device.{c,h}".

After several years of BlueZ making progress, could this SAP client
implementation still be adapted, enhanced and integrated in BlueZ?
The discussion mentioned in particular the questionable relevance of
using DBus for the transport of APDUs.
What do you think today? If not using DBus, what would be the best way to go?

Thanks,

-- 
Damiano Albani
