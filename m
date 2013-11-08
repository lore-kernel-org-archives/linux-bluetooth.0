Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/4] Add support for registering local SDP records
Date: Fri, 8 Nov 2013 13:21:20 +0100
Message-ID: <1383913284-4032-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for manipulating local SDP database with
bt_adapter_add_record and bt_adapter_remove_record functions. Those should
be called when HAL service is registered or unregistered.

This also adds DeviceID record as at least 1 local UUID is needed by Android to
properly handle remote device profiles.

Last but not least: With this serie it is possible to connect HID device from
Android UI (Settings application).   \O/

Comments are welcome.

BR
Szymon Janc

Marcin Kraglak (3):
  android: Add and remove sdp records and uuids
  android: Clear adapter uuids during initialization
  android: Add support for getting UUIDs property

Szymon Janc (1):
  android: Register DeviceID record when adapter is initialized

 android/Android.mk |   1 +
 android/adapter.c  | 187 +++++++++++++++++++++++++++++++++++++++++++++++++----
 android/adapter.h  |   4 ++
 3 files changed, 180 insertions(+), 12 deletions(-)

-- 
1.8.4.2

