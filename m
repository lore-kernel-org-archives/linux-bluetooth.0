Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 0/5] core: gatt: Support enabling notifications
Date: Thu, 29 Jan 2015 15:15:08 -0800
Message-Id: <1422573313-30825-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

*v1: Make bt_gatt_register_notify cancellable via bt_gatt_unregister_notify.
     notify_client_free now unregisters its notify id, which will cancel any
     pending CCC write, as well as unregister a registered notify callback.

This patch sets brings support for enabling notifications while in GATT
client-role. The changes that are introduced are:

  1. Implemented the StartNotify and StopNotify methods of the
     GattCharacteristic1 interface. This are internally tied to
     bt_gatt_client_register_notify and bt_gatt_client_unregister_notify.
     These also manage notification sessions on a per dbus sender basis.

  2. The exported GATT API objects are not removed in the event of a disconnect,
     if the devices are bonded. All notification sessions are also persisted and
     automatically re-enabled on reconnection. Also, adding new notification
     sessions via StartNotify is allowed during disconnects.

Arman Uguray (5):
  shared/gatt: Make register_notify cancellable
  core: gatt: Implement GattCharacteristic1.StartNotify
  core: gatt: Implement GattCharacteristic1.StopNotify
  core: device: Don't check ready in service_removed
  core: gatt: Keep objects over disconnects

 src/device.c             |  22 ++-
 src/gatt-client.c        | 435 +++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/gatt-client.c | 116 +++++++------
 src/shared/gatt-client.h |   7 +-
 tools/btgatt-client.c    |  17 +-
 5 files changed, 518 insertions(+), 79 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

