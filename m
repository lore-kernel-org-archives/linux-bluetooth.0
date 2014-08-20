Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 00/11] Introducing shared/gatt-client
Date: Wed, 20 Aug 2014 13:15:26 -0700
Message-Id: <1408565737-8187-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch set includes the initial implementation of shared/gatt-client, which
will provide a GATT client utility built on top of shared/att and
shared/gatt-helpers. These patches implement a subset of the long-term features
(some of which are listed in the introduced TODO file), including an abstraction
for GATT primitives (service, characteristic, descriptor, etc.) and the initial
attribute discovery process.

Comments are very much welcome.

Arman Uguray (11):
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

 Makefile.am               |   3 +-
 src/shared/TODO           |   8 +
 src/shared/att-types.h    |   2 +
 src/shared/att.c          | 161 +++++++++--
 src/shared/att.h          |   9 +-
 src/shared/gatt-client.c  | 663 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-client.h  | 104 ++++++++
 src/shared/gatt-helpers.c | 100 +++++--
 src/shared/gatt-helpers.h |  36 +--
 9 files changed, 1007 insertions(+), 79 deletions(-)
 create mode 100644 src/shared/TODO
 create mode 100644 src/shared/gatt-client.c
 create mode 100644 src/shared/gatt-client.h

-- 
2.1.0.rc2.206.gedb03e5

