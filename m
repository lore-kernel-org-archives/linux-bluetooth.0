Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 00/22] Implement AVRCP 1.3 for TG role
Date: Wed, 10 Aug 2011 10:06:14 -0300
Message-Id: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes from previous version:
- Removal of patch to use C99 instead of gcc extension
- Use of heap instead of relying on VLA to use memory from stack
- Coding style fixes
- SettingChanged signal and ChangeSetting method were renamed to
  PropertyChanged and SetProperty in order to use the common infrastructure
  already present in BlueZ.


regads,
Lucas De Marchi



Lucas De Marchi (22):
  audio: move interface declarations to their headers
  avrcp: add skeleton of MediaPlayer interface
  avrcp: implement SetProperty() method of MediaPlayer
  avrcp: implement ChangePlayback() method
  avrcp: implement ChangeTrack() method
  avrcp: handle query for company ids
  avrcp: handle ListPlayerApplicationSettingAttributes pdu
  avrcp: handle ListPlayerApplicationSettingValues pdu
  avrcp: handle GetCurrentPlayerAplicationSettingValue pdu
  avrcp: handle SetPlayerApplicationSettingValue pdu
  avrcp: handle commands for future extension
  avrcp: handle InformDisplayableCharacterSet pdu
  avrcp: handle InformBatteryStatusOfCT pdu
  avrcp: handle GetPlayStatus pdu
  avrcp: handle RegisterNotification pdu
  avrcp: handle query for supported events
  avrcp: handle GetElementAttributes pdu
  avrcp: send response for registered events
  avrcp: change TG record to use version 1.3
  avrcp: update copyright
  Add script to test MediaPlayer interface
  Update Control documentation

 audio/control.c        | 1399 +++++++++++++++++++++++++++++++++++++++++++++++-
 audio/control.h        |    4 +-
 audio/device.h         |    4 -
 audio/manager.c        |   11 +-
 audio/manager.h        |    1 +
 audio/unix.c           |    1 +
 doc/control-api.txt    |   94 ++--
 test/test-media-player |  108 ++++
 8 files changed, 1562 insertions(+), 60 deletions(-)
 create mode 100755 test/test-media-player

-- 
1.7.6

