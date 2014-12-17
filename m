Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v4 00/10] core: Use shared/gatt-client
Date: Tue, 16 Dec 2014 18:07:08 -0800
Message-Id: <1418782038-10999-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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


This patch set integrates shared/gatt-client into bluetoothd. The following
items have been tackled here:

  1. src/device now uses shared/gatt-client to perform service discovery. State
  updates such as disconnections, service changed events, etc. are done using
  callback APIs of the new shared framework and attrib/gatt is no longer used to
  perform GATT operations directly. A GAttrib instance is maintained for
  backwards compatibility with profiles that haven't been converted yet.

  2. A new gatt-callbacks API has been added which mirrors the attio APIs for
  shared/gatt-client. Profiles/plugins are notified using these APIs when the
  bearer disconnects, when services change, and when gatt-client is ready.

  3. The profiles/gatt plugin has been rewritten. Since the GATT service is
  handled by shared/gatt-client, this profile no longer deals with service
  changed events performs out of place MTU exchanges, which used to get
  performed in an arbitrary order. The profile has been renamed to profiles/gap
  as it now only deals with the GAP service, and reads the "Appearance" and
  "Device Name" characteristics using the new shared stack.

Arman Uguray (10):
  shared/att: Guard against invalid ref in callbacks
  shared/gatt-client: Guard against invalid access
  core: service: Add start & end handle fields
  core: profile: Add accept function
  core: device: Don't disconnect if attios not set
  core: device: Add getters for GATT db and client
  core: device: Make profile calls in GATT events
  profiles/gatt: Don't handle GATT service.
  profiles/gatt: Rename profile to gap.
  profiles/gap: Rewrite using bt_gatt_client.

 Makefile.plugins         |   4 +-
 profiles/gap/gas.c       | 338 +++++++++++++++++++++++++++++++++++
 profiles/gatt/gas.c      | 457 -----------------------------------------------
 src/device.c             | 285 +++++++++++++++++++++++------
 src/device.h             |   2 +
 src/profile.h            |   2 +
 src/service.c            |  56 ++++++
 src/service.h            |   9 +
 src/shared/att.c         |   5 +
 src/shared/gatt-client.c |  34 ++--
 10 files changed, 663 insertions(+), 529 deletions(-)
 create mode 100644 profiles/gap/gas.c
 delete mode 100644 profiles/gatt/gas.c

-- 
2.2.0.rc0.207.ga3a616c

