Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 00/11] Add shared/gatt-helpers
Date: Fri, 18 Jul 2014 14:13:46 -0700
Message-Id: <1405718037-15401-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch-set introduces src/shared/gatt-helpers, which provides helper
functions for client-side procedures defined for the Generic Attribute Profile.
These helpers are useful, since most of them are performed over several ATT
protocol requests over a wide attribute range (all discovery and long read/write
procedures). These functions also handle the encoding/decoding of the ATT
protocol PDU involved in these requests.

All GATT client procedures except the "Signed Write Without Response" have been
implemented, as this requires signed PDUs to be handled correctly by
bt_att_send, which will be implemented in a future patch-set.

Arman Uguray (11):
  shared/gatt: Introduce gatt-helpers.h skeleton.
  shared/gatt: Implement bt_gatt_exchange_mtu.
  shared/gatt: Implement "Discover All Primary Services" procedure.
  shared/gatt: Implement "Discover Primary Service by UUID" procedure.
  shared/gatt: Implement "Characteristic Discovery" procedures.
  shared/gatt: Implement "Descriptor Discovery" procedure.
  shared/gatt: Implement "Read" procedure.
  shared/gatt: Implement "Read Long Characteristic Values" procedure.
  shared/gatt: Implement "Write Value" and "Write Without Response"
    procedures.
  shared/gatt: Implement "Write Long Values" procedure.
  shared/gatt: Implement notification/indication helper.

 Makefile.am               |    3 +-
 src/shared/gatt-helpers.c | 1445 +++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-helpers.h |  135 +++++
 3 files changed, 1582 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/gatt-helpers.c
 create mode 100644 src/shared/gatt-helpers.h

-- 
2.0.0.526.g5318336

