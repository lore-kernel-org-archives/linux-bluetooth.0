Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v5 00/16] Add basic GATT characteristics
Date: Tue, 18 Mar 2014 17:26:15 -0300
Message-Id: <1395174391-27251-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394802800-8424-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394802800-8424-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset adds the following features:
  * register external characteristics
  * basic read or write external characteristics

Usage of glib is being avoided inside src/gatt.c. Remaining
put/get little-endian/big-endian helpers will be added in the
next patchset.

No matter the system, bt_uuid_t must use big-endian byte order (similar
to human-readable format). bt_string_to_uuid() & bt_uuid_to_string() are
still changing byte order, this issue will be also fixed in the next
patchsets.

TODO (missing features of this patchset and upstream code):
  * Properties/flags: operations and security
  * 32-bit UUIDs
  * Remove/free services
  * multiple services provided by the same client
  * remove att_put_* att_get_* helpers

Changes from v4 to v5:
  * avoid usage of uint128_t in the header util.h

Changes from v3 to v4:
  * keep LE <-> CPU helpers in lib/bluetooth.h (patches removing these
    helpers are being shifted to next patchset)

Changes from v2 to v3:
  * return put_uuid() definition to src/gatt.c
  * add put_le16(), put_le32(), put_le128() to src/shared/util.h

Changes from v1 to v2:
  * move put_uuid() and put_le16() to src/shared/util.h
  * check malloc0() and new0() return value

Changes from v0 to v1:
  * Use LE <-> CPU helpers defined in src/shared/util.h
  * remove patch "gatt: Add helper for reading characteristics" from
   this set.

Alvaro Silva (3):
  tools: Add Alert Level characteristic to gatt-service
  tools: Add reading Value property of gatt-service
  tools: Add setting Value property of gatt-service

Andre Guedes (2):
  gatt: Add function to create constant attributes
  gatt: Add helper for creating GATT characteristics

Claudio Takahasi (11):
  shared: Add bswap_128()
  gatt: Add characteristic to the database
  gatt: Add hash table of GDBusProxy objects
  gatt: Add read callback to btd_gatt_add_char helper
  gatt: Assign read callback for external services
  gatt: Add write callback to btd_gatt_add_char helper
  gdbus: Add g_dbus_proxy_set_property_array
  gatt: Assign write callback for external services
  gatt: Add result callback for Write Request
  gatt: Add Write Request handling for GDBusProxy
  tools: Emit property changed when Value changes

 gdbus/client.c       |  85 +++++++++++++++++++++++
 gdbus/gdbus.h        |   5 ++
 src/gatt-dbus.c      | 190 +++++++++++++++++++++++++++++++++++++++++++++++++--
 src/gatt.c           | 140 +++++++++++++++++++++++++++++++++++--
 src/gatt.h           |  44 ++++++++++++
 src/shared/util.h    |  10 +++
 tools/gatt-service.c | 156 ++++++++++++++++++++++++++++++++++++++----
 7 files changed, 608 insertions(+), 22 deletions(-)

-- 
1.8.3.1

