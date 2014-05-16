Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [RFC BlueZ 0/1] Introduce bt_gatt.
Date: Fri, 16 May 2014 13:37:15 -0700
Message-Id: <1400272636-31555-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bt_gatt implements GATT client operations and will be backed by bt_att. It is
effectively a rewrite of attrib/gatt, where it provides a more high-level
abstraction over GATT operation results (instead of returning raw PDUs) so that
ATT protocol level encoding/decoding is taken care of by the internal bt_att
instance. This is also meant to be a more thorough implementation of GATT
procedures, however some of them are omitted (for now):

  - "Read Using Characteristic UUID"
  - "Read Multiple Characteristic Values"
  - "Signed Write Without Response"
  - "Characteristic Value Reliable Writes"

These operations can be easily added in the future as needed, since bt_att will
provide all possible ATT protocol interactions.

bt_gatt doesn't implement attribute caching and is not a complete client
implementation on its own. It will be used together with gatt_db, where a higher
level abstraction will be responsible for managing lookups from the database vs
over-the-air and updating the database as needed. bt_gatt only provides the
hooks for performing all the necessary over-the-air GATT procedures.

Comments welcome.

Arman Uguray (1):
  src/shared/gatt: Introduce bt_gatt skeleton.

 Makefile.am       |   3 +-
 src/shared/gatt.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt.h | 189 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 383 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/gatt.c
 create mode 100644 src/shared/gatt.h

-- 
1.8.3.2

