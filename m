Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 00/23] Add GATT Client Messages
Date: Wed, 26 Feb 2014 09:40:58 +0100
Message-Id: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset adds GATT's Client part of ipc messages data.

v2 changes:
  * moved msg structs and opcodes up to message opcodes section of hal-msg.h
  * fixed typo and renamed few struct members to better match those in HAL hdrs
  * corrected tlv field types
  * [PATCHES 14-23/23] added opcodes and structs for the rest of Client messages

Regards,
Jakub Tyszkowski (23):
  android/hal-gatt-api: Add missing opcodes in GATT Service
  android/hal-gatt-api: Add Client Register
  android/hal-gatt-api: Add Client Unregister
  android/hal-gatt-api: Add Client Scan
  android/hal-gatt-api: Add Client Connect Remote
  android/hal-gatt-api: Add Client Disconnect Remote
  android/hal-gatt-api: Add Client Listen
  android/hal-gatt-api: Add Client Refresh Remote Cache
  android/hal-gatt-api: Add Client Search Service
  android/hal-gatt-api: Add Client Get Included Service
  android/hal-gatt-api: Add Client Get Characteristic
  android/hal-gatt-api: Add Client Get Descriptor
  android/hal-gatt-api: Add Client Read Characteristic
  android/hal-gatt-api: Add Client Write Characteristic
  android/hal-gatt-api: Add Client Read Descriptor
  android/hal-gatt-api: Add Client Write Descriptor
  android/hal-gatt-api: Add Client Execute Write
  android/hal-gatt-api: Add Client Register for Notification
  android/hal-gatt-api: Add Client Deregister for Notification
  android/hal-gatt-api: Add Client Read Remote RSSI
  android/hal-gatt-api: Add Client Get Device Type
  android/hal-gatt-api: Add Client Set Advertising Data
  android/hal-gatt-api: Add Client Test Command

 android/hal-ipc-api.txt | 324 +++++++++++++++++++++++++++++++++++++++++-------
 android/hal-msg.h       | 186 +++++++++++++++++++++++++++
 2 files changed, 466 insertions(+), 44 deletions(-)

--
1.9.0

