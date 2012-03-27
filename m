Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 0/4] GAP device Appearance support
Date: Tue, 27 Mar 2012 09:29:34 -0400
Message-Id: <1332854978-26072-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

These patches implement the appearance of the device. It can be obtained via
GAP Appearance characteristic or via Advertising data. After getting the
appearance, the icon is set based in this information.

Currently, only a few Freedesktop.org icons map to GAP appearance values. We
can try to propose more icons to their standard, but it may take time and not
all icons may be accepted. Any ideas?

Comments are welcome.

BR,
Bruna Moreira.

Bruna Moreira (4):
  dbus-common: Map GAP Appearance characteristic to icon
  storage: Add storage to GAP characteristic
  device: Appearance characteristic from GAP service
  eir: Read GAP appearance from advertising data

 src/adapter.c     |   11 ++++++++
 src/dbus-common.c |   33 ++++++++++++++++++++++++
 src/dbus-common.h |    1 +
 src/device.c      |   72 ++++++++++++++++++++++++++++++++++++++++++++++++----
 src/eir.c         |    9 ++++++
 src/eir.h         |    2 +
 src/storage.c     |   38 ++++++++++++++++++++++++++++
 src/storage.h     |    2 +
 8 files changed, 162 insertions(+), 6 deletions(-)

-- 
1.7.5.4

