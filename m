Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-input@vger.kernel.org
Cc: jkosina@suse.cz, chen.ganir@ti.com, claudio.takahasi@openbossa.org,
	jprvita@openbossa.org, linux-bluetooth@vger.kernel.org,
	Vijaykumar.Dadmode@csr.com,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 0/1] User-space I/O driver for HID subsystem (Bluetooth-LE HIDP)
Date: Fri, 16 Mar 2012 15:53:36 +0100
Message-Id: <1331909617-22106-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

I have hacked together a small driver which allows user-space I/O drivers to
provide HID devices. This is needed for Bluetooth-Low-Energy HID devices as the
Bluetooth-LE protocol is parsed in user-space.

I have only compile-tested this driver, I haven't run it yet. It's just an
proposal how this could be implemented. It should also work as hint to the BT-LE
developers how such an interface will look-like.

Comments are welcome.
Regards
David

David Herrmann (1):
  HID: User-space I/O driver support for HID subsystem

 Documentation/hid/uhid.txt |   95 +++++++++
 drivers/hid/Kconfig        |   21 ++
 drivers/hid/Makefile       |    2 +-
 drivers/hid/uhid.c         |  502 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/uhid.h       |   71 +++++++
 5 files changed, 690 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/hid/uhid.txt
 create mode 100644 drivers/hid/uhid.c
 create mode 100644 include/linux/uhid.h

-- 
1.7.9.4

