Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v5 0/7] core: Use shared/gatt-client
Date: Thu, 18 Dec 2014 17:24:32 -0800
Message-Id: <1418952279-16452-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v5:
  - Made probing a bit smarter, so that profiles are only probed once when
    necessary and they are removed if they no longer valid after non-bonded
    discovery.

*v4:
  - Removed gatt-callbacks in favor of using btd_profile probe and remove
    functions. Added the new btd_profile function "accept" to notify profiles
    that gatt-client is ready.

  - Using device_remove_profile to unregister btd_service's when services are
    removed from the client database. This happens on Service Changed events and
    on disconnection if the device is not bonded.

  - Removed immediated disconnection logic that triggers when no attio callbacks
    are registered after probe.

  - Other minor fixes to shared/gatt and shared/att.

*v3:
  - Renamed device_attach_att_transport to device_attach_att.

*v2:
  - Rebased.

*v1:
  - Addressed comments by Johan and Luiz.

Arman Uguray (7):
  core: device: Don't disconnect if attios not set
  core: device: Add getters for GATT db and client
  core: device: Make profile calls in GATT events
  profiles/gatt: Don't handle GATT service.
  profiles/gatt: Rename profile to gap.
  profiles/gap: Rewrite using bt_gatt_client.
  profiles/gap: Add Google copyright.

 Makefile.plugins    |   4 +-
 profiles/gap/gas.c  | 339 ++++++++++++++++++++++++++++++++++++++
 profiles/gatt/gas.c | 457 ----------------------------------------------------
 src/device.c        | 390 +++++++++++++++++++++++++++++++++++++-------
 src/device.h        |   2 +
 5 files changed, 676 insertions(+), 516 deletions(-)
 create mode 100644 profiles/gap/gas.c
 delete mode 100644 profiles/gatt/gas.c

-- 
2.2.0.rc0.207.ga3a616c

