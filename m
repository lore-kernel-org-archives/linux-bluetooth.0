Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC 0/7] Store UUID-128 on host order
Date: Fri, 11 Feb 2011 18:36:59 -0200
Message-Id: <1297456626-22837-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following patches convert the internal UUID128 values representation
to host order. Currently, SDP functions use host order to store UUID-16
/UUID32 and network order to store UUID-128 values. The reason is not only
to keep the consistency, but re-use the UUID functions for ATT protocol
which uses little endian.

Claudio Takahasi (7):
  Move 64 and 128 bits byte order functions to bluetooth.h
  Use memcpy to convert from network to host order on BE hosts
  Use host byte order when converting UUID16/32 to UUID128
  Add att_get_u128
  Convert UUID128 value to host order when extracting SDP data
  Convert to network order before use it on sdp_uuid128_to_uuid
  Convert from host order to network order before to print UUID128

 attrib/att.c         |   12 ++++--
 attrib/att.h         |   10 +++++
 attrib/example.c     |    1 +
 attrib/gatt.c        |   14 ++++--
 attrib/gatttool.c    |    6 ++-
 health/hdp_manager.c |    1 +
 health/mcap_sync.c   |   17 --------
 lib/bluetooth.h      |   41 +++++++++++++++++++
 lib/sdp.c            |  107 +++++++++++++++++++-------------------------------
 lib/sdp.h            |    4 --
 src/glib-helper.c    |   14 ++++---
 src/sdp-xml.c        |    1 +
 test/hciemu.c        |   16 -------
 tools/sdptool.c      |   16 ++++---
 14 files changed, 132 insertions(+), 128 deletions(-)

-- 
1.7.4

