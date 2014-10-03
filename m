Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 00/19] Add PDU structs
Date: Fri,  3 Oct 2014 15:32:40 +0300
Message-Id: <1412339579-8292-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds structs for each PDU which should make it more clear which
size are expected, what fields does the PDU contains, etc and also make
pointer arithmetic simpler.

Luiz Augusto von Dentz (19):
  android/avrcp-lib: Add GetCapabilities structs
  android/avrcp-lib: Add ListPlayerAttributes structs
  android/avrcp-lib: Add ListPlayerValues structs
  android/avrcp-lib: Add GetCurrentPlayerValue structs
  android/avrcp-lib: Add SetPlayerApplicationSettingValue structs
  android/avrcp-lib: Add GetPlayerAttributeText structs
  android/avrcp-lib: Add GetPlayerValueText structs
  android/avrcp-lib: Add GetElementAttributes structs
  android/avrcp-lib: Add GetPlayStatus structs
  android/avrcp-lib: Add RegisterNotification structs
  android/avrcp-lib: Add SetAbsoluteVolume structs
  android/avrcp-lib: Add SetAddressedPlayer structs
  android/avrcp-lib: Add SetBrowsed structs
  android/avrcp-lib: Add GetFolderItems structs
  android/avrcp-lib: Add ChangePath structs
  android/avrcp-lib: Add GetItemAttributes structs
  android/avrcp-lib: Add PlayItem structs
  android/avrcp-lib: Add Search structs
  android/avrcp-lib: Add AddToNowPlaying structs

 android/avrcp-lib.c | 1021 ++++++++++++++++++++++++++++++++++-----------------
 android/avrcp-lib.h |    6 +-
 android/avrcp.c     |   20 +-
 unit/test-avrcp.c   |   33 +-
 4 files changed, 710 insertions(+), 370 deletions(-)

-- 
1.9.3

