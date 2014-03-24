Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 00/22] Cleanup: Byte order
Date: Mon, 24 Mar 2014 16:25:21 -0300
Message-Id: <1395689143-11091-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395326607-27068-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes from v1 to v0:
  * Macros declared in lib/bluetooth.h should not be removed
  * Fix creating 128-bit uuid_t based on GATT service

This patchset contains the following changes:
  * Replace att_get_* and att_put_* by util.h helpers
  * Replace bt_get_* and bt_put_* by util.h helpers
  * Represent 128-bit bt_uuid_t using BIG-ENDIAN format
    (human-readable format)

Claudio Takahasi (22):
  Replace bt_get_be16() by get_be16()
  Replace bt_get_be32() by get_be32()
  Replace bt_get_be64() by get_be64()
  Replace bt_put_be16() by put_be16()
  Replace bt_put_be32() by put_be32()
  Replace bt_put_be64() by get_be64()
  lib: Remove ntoh128() from bt_string_to_uuid128()
  lib: Remove hton128() from bt_uuid_to_string()
  lib: Fix UUID 16/32-bits to 128-bit conversion
  unit: Fix 128-bit UUID format
  attrib: Use LE helpers defined in src/shared/util.h
  Replace att_get_u32() by get_le32()
  Replace att_put_u32() by put_le32()
  Replace att_put_uuid16() by put_le16()
  Replace att_get_uuid16() by get_le16()
  Replace att_get_u16() by get_le16()
  Replace att_get_uuid128() by bswap_128()
  Replace att_put_uuid() by util.h helpers
  Replace att_put_u16() by put_le16()
  tools: Use unaligned access macros from util.h
  core: Fix creating 128-bit uuid_t based on GATT service
  attrib: Minor code optimization

 android/avrcp-lib.c                  |  23 +++---
 android/avrcp.c                      |   7 +-
 attrib/att.c                         | 148 +++++++++++++++++++++--------------
 attrib/gatt-service.c                |  24 +++---
 attrib/gatt.c                        | 112 ++++++++++++++++----------
 attrib/gattrib.c                     |   3 +-
 attrib/gatttool.c                    |  18 +++--
 attrib/interactive.c                 |  18 +++--
 lib/uuid.c                           |  45 +++++------
 monitor/sdp.c                        |  62 ++++++++-------
 plugins/gatt-example.c               |  73 ++++++++---------
 profiles/audio/avrcp.c               |  72 ++++++++---------
 profiles/cyclingspeed/cyclingspeed.c |  27 ++++---
 profiles/deviceinfo/deviceinfo.c     |   5 +-
 profiles/gatt/gas.c                  |  13 +--
 profiles/heartrate/heartrate.c       |  19 ++---
 profiles/input/hog.c                 |   9 ++-
 profiles/network/bnep.c              |   9 ++-
 profiles/proximity/reporter.c        |   7 +-
 profiles/sap/server.c                |   5 +-
 profiles/scanparam/scan.c            |  11 +--
 profiles/thermometer/thermometer.c   |  29 +++----
 profiles/time/server.c               |   3 +-
 src/attrib-server.c                  |  52 +++++++-----
 src/sdpd-request.c                   |  40 +++++-----
 src/sdpd-service.c                   |  19 ++---
 tools/parser/hci.c                   |   1 -
 tools/parser/l2cap.c                 |   1 -
 tools/parser/parser.h                |   9 +--
 tools/parser/ppp.c                   |   2 +-
 unit/test-uuid.c                     |   9 ++-
 31 files changed, 488 insertions(+), 387 deletions(-)

-- 
1.8.3.1

