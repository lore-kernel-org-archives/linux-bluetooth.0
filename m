Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 00/13] Introducing shared/gatt-client
Date: Fri, 22 Aug 2014 17:47:34 -0700
Message-Id: <1408754867-13313-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* v1:
  - Moved the TODOs to the top-level TODO file in a new ATT/GATT section.
  - Removed bt_gatt_client_init. Instead, added a
    bt_gatt_client_set_ready_handler to set up a handler which gets called when
    discovery is over. Discovery is initiated in bt_gatt_client_new instead.
  - Removed bt_gatt_client_get_att.
  - Removed the (un)register_service_changed functions for now.
  - Removed bt_gatt_client_destroy in favor of ref/unref functions.
  - Dropped "_handler" from bt_att_(un)register_disconnect_handler functions.

Arman Uguray (13):
  TODO: Add items for tasks involving the new shared ATT/GATT stack
  shared/gatt-helpers: Remove service, characteristic, descriptor
    structures.
  shared/gatt-helpers: Added result count functions.
  shared/gatt-client: Added initial skeleton and simple functions.
  shared/att: Support multiple disconnect handlers.
  shared/att: Add BT_ATT_DEFAULT_LE_MTU macro.
  shared/gatt-helpers: Fixed typo in callback args.
  shared/gatt-client: Add bt_gatt_client_set_debug.
  shared/gatt-client: Implement initial service discovery.
  shared/gatt-client: Add service iterator functions.
  shared/gatt-client: Implement characteristic discovery.
  shared/gatt-client: Implement descriptor discovery.
  TODO: shared/gatt-client has been defined and discovery implemented

 Makefile.am               |   3 +-
 TODO                      |  90 ++++++-
 src/shared/att-types.h    |   2 +
 src/shared/att.c          | 161 ++++++++++--
 src/shared/att.h          |  11 +-
 src/shared/gatt-client.c  | 652 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-client.h  |  90 +++++++
 src/shared/gatt-helpers.c | 100 +++++--
 src/shared/gatt-helpers.h |  36 +--
 9 files changed, 1064 insertions(+), 81 deletions(-)
 create mode 100644 src/shared/gatt-client.c
 create mode 100644 src/shared/gatt-client.h

-- 
2.1.0.rc2.206.gedb03e5

