Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 0/5] core: gatt: Support enabling notifications
Date: Wed, 28 Jan 2015 18:10:58 -0800
Message-Id: <1422497463-32539-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

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
  core: gatt: Implement GattCharacteristic1.StartNotify
  core: gatt: Implement GattCharacteristic1.StopNotify
  core: device: Don't check ready in service_removed
  core: device: Add device_is_bonded_for_gatt
  core: gatt: Keep objects over disconnects

 src/device.c      |  31 +++-
 src/device.h      |   1 +
 src/gatt-client.c | 453 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 466 insertions(+), 19 deletions(-)

-- 
2.2.0.rc0.207.ga3a616c

