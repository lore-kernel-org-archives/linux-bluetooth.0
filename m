Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 00/19] Implement AVRCP 1.3 profile - TG role
Date: Tue, 19 Jul 2011 16:49:11 -0300
Message-Id: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series implement all the mandatory and some optional features in AVRCP 1.3
profile, target role.

It passed all the related PTS tests and it's slightly tested with a Sony
MEX-BT2900 car kit.

Current limitation:
 * It does not support message continuation in case the metadata
   doesn't fit one AV/C packet.
 * The D-Bus API doesn't use an agent. Thus it's possible that two applications
   screw up the data passed to the control interface. I made this on purpose,
   since it allows me to easily test the interface. Future versions shall
   remove this limitation.

I preferred the API written on doc/control-api.txt rather than the past tentatives
of using mpris. I'm not sure it's worth supporting it, but I'd like to hear
opinions. Considering both approaches need the client to be modified in
order to support the agent, maybe using mpris would just be too much hassle.

regards,
Lucas De Marchi



Lucas De Marchi (19):
  avrcp: handle query for company ids
  avrcp: implement ChangeSetting() method for TG role
  avrcp: handle ListPlayerApplicationSettingAttributes pdu
  avrcp: handle ListPlayerApplicationSettingValues pdu
  avrcp: handle GetCurrentPlayerAplicationSettingValue pdu
  avrcp: handle SetPlayerApplicationSettingValue pdu
  avrcp: handle commands for future extension
  avrcp: handle InformDisplayableCharacterSet pdu
  avrcp: handle InformBatteryStatusOfCT pdu
  avrcp: implement ChangePlayback() method
  avrcp: handle GetPlayStatus pdu
  avrcp: implement ChangeTrack() method
  Add script to test control interface
  avrcp: handle RegisterNotification pdu
  avrcp: answer query for supported events
  avrcp: handle GetElementAttributes pdu
  avrcp: send response for registered events
  avrcp: change TG record to use version 1.3
  avrcp: update copyright

 audio/control.c     | 1193 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 doc/control-api.txt |   18 +-
 test/test-control   |   67 +++
 3 files changed, 1268 insertions(+), 10 deletions(-)
 create mode 100755 test/test-control

-- 
1.7.6

