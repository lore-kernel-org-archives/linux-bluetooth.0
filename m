Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v4 00/22] Implement AVRCP 1.3 for TG role
Date: Thu, 11 Aug 2011 12:53:11 -0300
Message-Id: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Change from previous version:

- MediaPlayer interface is created only if remote device is the controller (and
  thus we are TG) as suggested by Luiz.

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

 audio/control.c        | 1417 +++++++++++++++++++++++++++++++++++++++++++++++-
 audio/control.h        |    7 +-
 audio/device.h         |    4 -
 audio/manager.c        |   14 +-
 audio/manager.h        |    1 +
 audio/unix.c           |    1 +
 doc/control-api.txt    |   94 ++--
 test/test-media-player |  108 ++++
 8 files changed, 1580 insertions(+), 66 deletions(-)
 create mode 100755 test/test-media-player

-- 
1.7.6

