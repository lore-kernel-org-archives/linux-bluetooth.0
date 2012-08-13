Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 0/3] HoG: Add support for non-HID services encapsulated in the HID protocol
Date: Mon, 13 Aug 2012 09:23:13 -0300
Message-Id: <1344860596-30617-1-git-send-email-jprvita@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The HID protocol support encapsulating non-HID service data as reports. This
patches adds support for this feature for HoG devices.

João Paulo Rechi Vita (3):
  gatt: Add a new descriptor UUID
  hog: discover External Report Reference descriptor
  hog: discover the non-HID service characteristic

 attrib/gatt.h               |  1 +
 profiles/input/hog_device.c | 96 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 83 insertions(+), 14 deletions(-)

-- 
1.7.11.2

