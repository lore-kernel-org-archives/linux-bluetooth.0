Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [RFC v2 00/16] HoG plugin
Date: Wed, 18 Apr 2012 19:08:08 -0300
Message-Id: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Second draft of the HoG plugin. Code went through a lot of refactoring and is
much cleaner now. The report descriptor parsing (to get the report id) is
hackish and it doesn't support more than one device simultaneosly, probably
due to a kernel bug (reports come from the wrong socket). We're investigating
it.

People wiling to test it should use the 'integration' branch of our
development kernel tree [1], since LE pairing is broken on bluetooth-next atm.
It also contains David's uHID implementation.

[1] git://git.infradead.org/users/cktakahasi/bluetooth-next-2.6.git

Comments are very welcome, as always.

Claudio Takahasi (8):
  HoG: Register HID over GATT device driver
  HoG: discover descriptors for all characteristics
  HoG: Use real values for vendor and product IDs
  GATT: Add Report Reference Descriptor declaration
  HoG: Add read Report Reference descriptor
  GATT: Rename Characteristic Configuration constants
  GATT: Move GATT assigned numbers to GATT header
  HoG: Register only one notification callback

João Paulo Rechi Vita (8):
  HoG: register ATTIO callbacks
  HoG: load primary service handle
  HoG: discover all characteristics declaration
  HoG: discover the "Report Map" characteristic
  HoG: enable "Report" characteristic notification
  HoG: add report notification handler
  HoG: HID I/O driver
  HoG: Prepend report id to the HID report

 Makefile.am               |    5 +
 acinclude.m4              |    8 +
 attrib/att.h              |   27 ---
 attrib/gatt-service.c     |    3 +-
 attrib/gatt.h             |   29 +++
 configure.ac              |    2 +
 input/hog_device.c        |  484 +++++++++++++++++++++++++++++++++++++++++++++
 input/hog_device.h        |   28 +++
 input/main.c              |   15 ++
 input/manager.c           |   38 ++++
 input/manager.h           |    3 +
 plugins/gatt-example.c    |    1 +
 proximity/immalert.c      |    3 +-
 proximity/linkloss.c      |    3 +-
 proximity/reporter.c      |    3 +-
 src/attrib-server.c       |    3 +-
 thermometer/thermometer.c |    6 +-
 time/server.c             |    3 +-
 18 files changed, 628 insertions(+), 36 deletions(-)
 create mode 100644 input/hog_device.c
 create mode 100644 input/hog_device.h

-- 
1.7.7.6

