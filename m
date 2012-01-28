Return-Path: <cyrus@holtmann.org>
Date: Sat, 28 Jan 2012 21:12:02 +0100
From: Tino Keitel <tino.keitel@tikei.de>
To: linux-bluetooth@vger.kernel.org
Subject: C++ build failure in recent bluez headers
Message-ID: <20120128201202.GA8510@x61.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

is there an accepted patch for the build failure in recent Bluez
headers with C++ applications? This issue was brought up by Patrick
Ohly in the thread "bluez 4.97: build failure when used in C++ apps".
It seems to me that the patch suggested by Patrick did not receive a
final comment so far.

Currently I can't fix Syncevolution bugs for Debian because building
Syncevolution will fail due to broken Bluez headers.

Regards,
Tino
