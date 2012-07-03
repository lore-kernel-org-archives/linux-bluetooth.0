Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH 00/21] HID over GATT plugin
Date: Tue,  3 Jul 2012 15:42:52 -0300
Message-Id: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is the plugin to support HID over GATT. It has the uHID module as a
dependency, which is now integrated on the HID maintainer's tree [1] and will
be part of the HID's 3.6 pull request. Right now a merge of the 'uhid' branch
of this tree witht the master branch of bluetooth-next is necessary to test
this plugin, with the uhid module compiled and loaded.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git

Known limitations:

- No characteristics / descriptors handle storage, we discover everything on
  every re-connection;

- Discovery doesn't work when there is a bonded non-connected HoG device. We're
  working to improve LE connection and discovery management in general, so this
  will be addressed soon.

Claudio Takahasi (8):
  hog: Register HID over GATT device driver
  hog: Add checking for 'EnableGatt'
  hog: Discover descriptors for all characteristics
  hog: Use real values for vendor and product IDs
  gatt: add Report Reference descriptor UUID
  hog: Add read Report Reference descriptor
  hog: Add HID Information Characteristic read
  hog: Use hardware country code

João Paulo Rechi Vita (12):
  hog: Register ATTIO callbacks
  hog: Load primary service handle
  hog: Discover all characteristics declaration
  hog: Discover the "Report Map" characteristic
  hog: Enable "Report" characteristic notifications
  hog: Add report notification handler
  hog: HID I/O driver
  hog: Prepend Report ID to the HID report
  hog: Add support for uHID events
  hog: Handle output reports
  hog: Handle output events
  hog: Handle feature reports

Paulo Alcantara (1):
  hog: Handle HID devices operating in Boot Protocol Mode

 Makefile.am        |    5 +
 acinclude.m4       |    8 +
 attrib/gatt.h      |    1 +
 configure.ac       |    2 +
 input/hog_device.c |  694 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 input/hog_device.h |   28 +++
 input/main.c       |   24 ++
 input/manager.c    |   38 +++
 input/manager.h    |    3 +
 9 files changed, 803 insertions(+)
 create mode 100644 input/hog_device.c
 create mode 100644 input/hog_device.h

-- 
1.7.10.4

