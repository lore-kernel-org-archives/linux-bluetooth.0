Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v8 0/8] Add basic GATT characteristics
Date: Mon, 24 Mar 2014 10:30:01 -0300
Message-Id: <1395667809-17602-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395429403-493-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395429403-493-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remaining patches of "Add basic GATT characteristics" patchset.

This patchset adds the following features:
  * basic read or write external characteristics

TODO (missing features of this patchset and upstream code):
  * Properties/flags: operations and security
  * 32-bit UUIDs
  * Remove/free services
  * multiple services provided by the same client
  * remove att_put_* att_get_* helpers

Changes from v8 to v7:
  * fixed gatt.h write callback description

Changes from v7 to v6:
  * coding style: !foo and boolean

Changes from v6 to v5:
  * Use size_t instead of signed integer for
    g_dbus_proxy_set_property_array
  * Use negative value to denote an error (-ernno)

Changes from v5 to v4:
  * avoid usage of uint128_t in the header util.h

Changes from v4 to v3:
  * keep LE <-> CPU helpers in lib/bluetooth.h (patches removing these
    helpers are being shifted to next patchset)

Changes from v3 to v2:
  * return put_uuid() definition to src/gatt.c
  * add put_le16(), put_le32(), put_le128() to src/shared/util.h

Changes from v2 to v1:
  * move put_uuid() and put_le16() to src/shared/util.h
  * check malloc0() and new0() return value

Changes from v1 to v0:
  * Use LE <-> CPU helpers defined in src/shared/util.h
  * remove patch "gatt: Add helper for reading characteristics" from
   this set.

Alvaro Silva (3):
  tools: Add Alert Level characteristic to gatt-service
  tools: Add reading Value property of gatt-service
  tools: Add setting Value property of gatt-service

Claudio Takahasi (5):
  gatt: Add write callback to btd_gatt_add_char helper
  gatt: Assign write callback for external services
  gatt: Add result callback for Write Request
  gatt: Add Write Request handling for GDBusProxy
  tools: Emit property changed when Value changes

 src/gatt-dbus.c      |  84 +++++++++++++++++++++++++++-
 src/gatt.c           |   7 ++-
 src/gatt.h           |  28 +++++++++-
 tools/gatt-service.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 256 insertions(+), 17 deletions(-)

-- 
1.8.3.1

