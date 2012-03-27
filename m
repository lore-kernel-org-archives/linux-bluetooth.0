Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@googlemail.com, chen.ganir@ti.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [RFC 0/8] HoG Plugin
Date: Tue, 27 Mar 2012 19:31:19 -0300
Message-Id: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a first draft of the HoG plugin. This RFC is mainly to give feedback
to other people working on HoG-relate stuff, like DIS, UHID, etc.

There are quite a few "magic" hardcoded values around the code, which will go
away as soon as we implement the discovery of all characteristics from the
device. It has been tested only with one specific keyboard model and support
for output reports is not implemented yet.

Comments are welcome.

Claudio Takahasi (1):
  HoG: Register HID over GATT device driver

João Paulo Rechi Vita (7):
  HoG: register ATTIO callbacks
  HoG: enable report characteristic notification
  HoG: load primary service handle
  HoG: discover report characteristic
  HoG: add report notification handler
  HoG: print the report map on debug output
  HoG: HID I/O driver

 Makefile.am        |    5 +-
 input/hog_device.c |  324 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 input/hog_device.h |   30 +++++
 input/main.c       |   13 ++
 input/manager.c    |   36 ++++++
 input/manager.h    |    3 +
 6 files changed, 409 insertions(+), 2 deletions(-)
 create mode 100644 input/hog_device.c
 create mode 100644 input/hog_device.h

-- 
1.7.7.6

