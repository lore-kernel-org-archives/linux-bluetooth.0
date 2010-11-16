Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Tue, 16 Nov 2010 19:24:45 -0200
Message-ID: <AANLkTikGtkUDm=6iy8BvBtE=s4Ai05VfdN4wWGiD64nf@mail.gmail.com>
Subject: [RFC] Discover Primary Service by Service UUID
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Before I send an official request-pull I need feedbacks about the
changes in the bt_string2uuid function.

Commit 8774e6c1523707b01efd892c665baeeabad41ab4 of my branch "gatt"
extends the bt_string2uuid to support UUID16, this modification
changes the behavior of the method DiscoverServices(string pattern) in
the device. Now, pattern can be also a hex string value instead of
UUID128 and "friendly" service names only. Is it acceptable?

This change will be required to implement Discover Primary Service by
Service UUID and Characteristic Value Read using UUID.



git request-pull info:

The following changes since commit
8ef71548686b3e9e2152aed46177e6bfca749b09:

  Fix typos in adapter documentation (2010-11-16 13:39:43 +0000)

are available in the git repository at:
  git://git.infradead.org/users/cktakahasi/bluez.git gatt

Bruna Moreira (1):
      Implement Find by Type request encode/decoding

Claudio Takahasi (7):
      Add Find By Type Value Response encoding/decoding functions
      Implement Find by Type Value Request in the atttribute server
      Extend bt_string2uuid to convert hex strings to UUID16
      Add an extra parameter in the discovery primary to specify the
UUID
      Add uuid command line option on gatttool
      Implement Discover Primary Service by Service UUID in the
gatttool
      Fix corner cases of Discover Primary Service by UUID in the
server

 Makefile.am         |    3 +-
 attrib/att.c        |  121
++++++++++++++++++++++++++++++++++++++++++++++++++-
 attrib/att.h        |   11 ++++-
 attrib/client.c     |    8 ++--
 attrib/gatt.c       |   37 +++++++++++++---
 attrib/gatt.h       |    4 +-
 attrib/gatttool.c   |   63 +++++++++++++++++++++++++-
 src/attrib-server.c |   75 +++++++++++++++++++++++++++++++
 src/glib-helper.c   |   21 +++++++++
 9 files changed, 323 insertions(+), 20 deletions(-)

Claudio.
