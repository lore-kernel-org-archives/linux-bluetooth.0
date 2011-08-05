Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 00/23] Implement AVRCP 1.3 for TG role
Date: Fri,  5 Aug 2011 15:25:56 -0300
Message-Id: <1312568756-21712-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

[ Sorry, I forgot to send this cover letter before the other patches. Any way,
  here it is. ]

This is an updated version of AVRCP 1.3 patches for TG role. Changes from
last verion:

- As asked I separated the methods from Control to an experimental interface
  named MediaPlayer;
- Some refactoring to decouple the media player from the control. This will
  ease future changes to the MediaPlayer interface;
- There were some bug fixes thanks to the new patches for parsing AVRCP 1.3 on
  hcidump;
- Revamped script for testing MediaPlayer interface;
- Improvements in the way we deal with Player settings;

PDU continuation is not implemented but it's very easy to get it implemented. I
just don't want to maintain this pile of patches while implementing it.


Regards,
Lucas De Marchi

Lucas De Marchi (23):
  audio: move interface declarations to their headers
  avrcp: use C99 instead of gcc extension
  avrcp: add skeleton of MediaPlayer interface
  avrcp: implement ChangeSetting() method of MediaPlayer
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
  Add script to test control interface
  Update Control documentation

 audio/control.c     | 1439 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 audio/control.h     |    4 +-
 audio/device.h      |    4 -
 audio/manager.c     |   11 +-
 audio/manager.h     |    1 +
 audio/unix.c        |    1 +
 doc/control-api.txt |  101 ++--
 test/test-control   |  108 ++++
 8 files changed, 1607 insertions(+), 62 deletions(-)
 create mode 100755 test/test-control

-- 
1.7.6

