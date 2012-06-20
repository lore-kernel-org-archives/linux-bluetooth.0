Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 0/5] Broadcaster/Observer patch series
Date: Wed, 20 Jun 2012 14:05:13 -0400
Message-Id: <1340215518-6694-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series starts the DBus API for Broadcaster and Observer.

There are previous threads about this:
    "LE Broadcaster/Observer API proposal"
    "doc: Document Broadcaster/Observer API"

http://thread.gmane.org/gmane.linux.bluez.kernel/23846

Some parts are changed for a better user interaction.
For while, we will support only Manufacturer Specific Data and Service
Data, but it is flexible to add new fields in future.

Any comments are welcome.

Bruna Moreira (2):
  observer: Add python test script
  broadcaster: Add python test script

Jefferson Delfes (3):
  doc: Add Observer and Broadcaster DBus API documentation
  adapter: Add DBus API for Observer GAP Role
  adapter: Add DBus API for Broadcaster GAP Role

 doc/adapter-api.txt   | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.c         | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h         |  3 ++
 src/bluetooth.conf    |  1 +
 test/test-broadcaster | 84 ++++++++++++++++++++++++++++++++++++++++++++++
 test/test-observer    | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 355 insertions(+)
 create mode 100755 test/test-broadcaster
 create mode 100755 test/test-observer

-- 
1.7.11

