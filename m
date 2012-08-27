Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 00/22] alert: GATT ANP/PASP server role implementation
Date: Mon, 27 Aug 2012 13:11:44 -0400
Message-Id: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This series contain the current implementation for ANP/PASP server roles. The
D-Bus API was based on discussions on BlueZ meeting, and later improvements.

Note that this implementation is not finished yet, we are submitting now for
early feedback. Most importantly, it lacks support for notifications (essential
for ANP) and the enabling/disabling ANP alerts using the control point.

The series contain a test python script and API documentation.

Comments/suggestions are welcome.

Anderson Lizardo (11):
  doc: Introduce Alert API
  alert: Introduce manager abstraction layer
  alert: Add adapter driver
  alert: Initial Alert Notification
  alert: Add initial support for UnreadAlert D-Bus method
  alert: Add per adapter attribute handle information
  alert: Update Supported New/Unread Category characteristic values
  alert: Update new alert characteristic value
  alert: Update unread alert characteristic value
  alert: Implement MuteOnce command
  alert: Update Alert Status and Ringer Setting characteristic values

Bruna Moreira (4):
  alert: Add Phone Alert Service
  alert: Add Ringer Control Point characteristic
  alert: Add Ringer Setting characteristic
  alert: Add Alert Status characteristic

Eder Ruiz Maria (7):
  alert: Add initial support for RegisterAlert D-Bus method
  alert: Implement category registration in RegisterAlert()
  alert: Add initial support for NewAlert D-Bus method
  alert: Add support for automatic unregister when agent leave D-Bus
  alert: Add support to call MuteOnce()
  alert: Add support to call SetRinger()
  alert: Add test script

 Makefile.am              |    3 +-
 doc/alert-api.txt        |  124 ++++++++
 profiles/alert/main.c    |    6 +-
 profiles/alert/manager.c |   40 +++
 profiles/alert/manager.h |   26 ++
 profiles/alert/server.c  |  768 ++++++++++++++++++++++++++++++++++++++++++++++
 test/test-alert          |  167 ++++++++++
 7 files changed, 1130 insertions(+), 4 deletions(-)
 create mode 100644 doc/alert-api.txt
 create mode 100644 profiles/alert/manager.c
 create mode 100644 profiles/alert/manager.h
 create mode 100755 test/test-alert

-- 
1.7.9.5

