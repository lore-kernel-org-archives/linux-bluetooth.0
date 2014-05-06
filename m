Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ao2@ao2.it>
To: linux-bluetooth@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Bastien Nocera <hadess@hadess.net>,
	Szymon Janc <szymon.janc@gmail.com>,
	Frank Praznik <frank.praznik@oh.rr.com>
Subject: [PATCH BlueZ 0/5] plugin/sixaxis: use the sysfs leds class
Date: Tue,  6 May 2014 12:06:11 +0200
Message-Id: <1399370776-5027-1-git-send-email-ao2@ao2.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

on kernels >= 3.14 the hid-sony driver exposes leds class entries in
sysfs for setting the Sixaxis LEDs, the patches in this set make BlueZ
use this interface as the default one and fall-back to hidraw in case
using sysfs fails (e.g. on older hid-sony versions).

Patch 1 is a cleanup, it's optional, feel free to reject it; the libudev
version bump is needed for patch 5 tho.

Patches 2,3 and 4 are refactorings in preparation of patch 5.

Patch 5 adds the actual support for the sysfs mechanism.

The changes have been tested with libudev-204 along with linux-3.13,
linux 3.14 and linux-3.15-rc4, however some more testing with different
libudev and kernel versions won't hurt :)

Thanks,
   Antonio

Antonio Ospite (5):
  plugins/sixaxis: simplify get_js_numbers()
  plugins/sixaxis: factor out a set_leds_hidraw() function
  plugins/sixaxis: factor out a calc_leds_bitmap() function
  plugins/sixaxis: add a get_leds_data() function
  plugins/sixaxis: add a set_leds_sysfs() function

 configure.ac      |   4 +-
 plugins/sixaxis.c | 256 ++++++++++++++++++++++++++++++++++++++++--------------
 2 files changed, 193 insertions(+), 67 deletions(-)

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
