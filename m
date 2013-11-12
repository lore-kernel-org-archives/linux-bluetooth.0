Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 0/5] Add support for registering local SDP records
Date: Tue, 12 Nov 2013 16:36:21 +0100
Message-ID: <1384270586-9853-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v3:
 - fixed Johan comments

V2:
 - don't use bt_uuid_t
 - few bugfixes

V1 cover:
This adds support for manipulating local SDP database with
bt_adapter_add_record and bt_adapter_remove_record functions. Those should
be called when HAL service is registered or unregistered.

This also adds DeviceID record as at least 1 local UUID is needed by Android to
properly handle remote device profiles.

Last but not least: With this serie it is possible to connect HID device from
Android UI (Settings application).   \O/

-- 
BR
Szymon Janc

Marcin Kraglak (3):
  android: Add and remove sdp records and uuids
  android: Clear adapter uuids during initialization
  android: Add support for getting UUIDs property

Szymon Janc (2):
  android: Remove not needed include
  android: Register DeviceID record when adapter is initialized

 android/adapter.c | 202 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 android/adapter.h |   3 +
 2 files changed, 192 insertions(+), 13 deletions(-)

-- 
1.8.4.2

