Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/10] build: Add options for every plugin
Date: Fri, 11 Nov 2016 19:22:34 +0200
Message-Id: <1478884964-7543-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a build option for non-essential plugins so they can be
disable/enabled separately and leave options such as experimental only
for tools.

Plugins that were enabled by default were given a disable option, for
the option plugins behind experimental they are now supported with a
enable option and they continue to be build with bootstrap-configure.

This make one able to select exactly what plugins shall be build which,
so it is now possible to build bluetoothd without any BR/EDR profile
built-in which reduces the binary size of bluetoothd:

all options:
  text	   data	    bss	    dec	    hex	filename
1271889	 292976	 294144	1859009	 1c5dc1	src/bluetoothd

with --disable-a2dp --disable-avrcp --disable-network --disable-hid:
text	   data	    bss	    dec	    hex	filename
1003609	 227160	 226464	1457233	 163c51	src/bluetoothd

Luiz Augusto von Dentz (10):
  build: Add option to enable NFC pairing
  build: Add option to enable SAP profile
  build: Add option to disable A2DP profile
  build: Add option to disable AVRCP profile
  build: Add option to disable network profiles
  build: Add option to disable HID profile
  build: Add option to disable HoG profile
  build: Add option to enable health profiles
  build: Update experimental documentation
  build: Update bootstrap-configure with new build options

 Makefile.plugins    | 17 +++++++++++++++--
 bootstrap-configure |  3 +++
 configure.ac        | 34 +++++++++++++++++++++++++++++++++-
 3 files changed, 51 insertions(+), 3 deletions(-)

-- 
2.7.4

