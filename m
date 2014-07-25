Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v2 00/11] Add shared/gatt-helpers
Date: Fri, 25 Jul 2014 15:08:32 -0700
Message-Id: <1406326123-10564-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* v2:
   - Addressed various style comments.
   - Changed status reporting from a single uint16 that encodes bluez defined
     errors and ATT protocol errors to a bool that indicates success/failure and
     a uint8 that contains ATT protocol errors. Removed all BT_GATT_ERROR_*.
   - Stopped returning discovery results in a struct queue. Instead, the code
     now uses a GATT-specific data structure as per Marcel's request. This
     structure is a simple singly linked list that doesn't allow external
     modification.

     I'm not quite sure this is the right way to do this; I didn't want to use
     any glib structures here so maybe in the future we can change this to
     simply use some library defined linked list structure that is shared among
     userspace code.

* v1:
   - Fixed 32-bit UUID encoding for the "Discover Primary Service by UUID"
     procedure.
   - Minor cosmetic fix in bt_gatt_exchange_mtu.

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
 src/shared/gatt-helpers.c | 1545 +++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-helpers.h |  127 ++++
 3 files changed, 1674 insertions(+), 1 deletion(-)
 create mode 100644 src/shared/gatt-helpers.c
 create mode 100644 src/shared/gatt-helpers.h

-- 
2.0.0.526.g5318336

