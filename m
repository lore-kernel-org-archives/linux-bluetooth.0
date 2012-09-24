Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 00/25] Add support for PASP and ANP server profiles
Date: Mon, 24 Sep 2012 14:00:36 -0400
Message-Id: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This series implement most of mandatory features for Phone Alert Status (PASP)
and Alert Notification (ANP) profiles. The only major mandatory feature
currently missing is support for ANP control point (which will be added on a
future series).

Note: for those planning to use ANP/PASP in BlueZ using these patches, it is
necessary to implement an "agent" that forwards platform events (SMS, calls,
e-mail, and ringer/display/vibra status) to BlueZ. See doc/alert-api.txt and
test/test-alert for more details. Alternatively, the components that generate
these events can register themselves and report alerts directly to BlueZ.

This implementation was tested against PTS and all tests passed (except for the
features not yet implemented). The D-Bus API was implemented accordingly to the
previously proposed Alert API (documented on the first patch).

Comments/suggestions are welcome.


Anderson Lizardo (11):
  doc: Introduce Alert API
  alert: Introduce manager abstraction layer
  alert: Initial profile registration
  alert: Initial Alert Notification
  alert: Add initial support for UnreadAlert D-Bus method
  alert: Add per adapter attribute handle information
  alert: Update Supported New/Unread Category characteristic values
  alert: Update new alert characteristic value
  alert: Update unread alert characteristic value
  alert: Implement MuteOnce command
  alert: Update Alert Status and Ringer Setting characteristic values

Bruna Moreira (4):
  alert: Add Phone Alert Status Service
  alert: Add Ringer Control Point characteristic
  alert: Add Ringer Setting characteristic
  alert: Add Alert Status characteristic

Eder Ruiz Maria (10):
  alert: Implement category registration in RegisterAlert()
  alert: Add initial support for NewAlert D-Bus method
  alert: Automatically unregister alert when agent leaves D-Bus
  alert: Add support for calling MuteOnce()
  alert: Add support for calling SetRinger()
  alert: Add test-alert script
  alert: Add support for ringer setting notification
  alert: Add support for alert status notification
  alert: Add support for new alert notification
  alert: Add support for unread alert notification

 Makefile.am              |    3 +-
 doc/alert-api.txt        |  124 ++++++
 profiles/alert/main.c    |    6 +-
 profiles/alert/manager.c |   40 ++
 profiles/alert/manager.h |   26 ++
 profiles/alert/server.c  |  944 ++++++++++++++++++++++++++++++++++++++++++++++
 test/test-alert          |  173 +++++++++
 7 files changed, 1312 insertions(+), 4 deletions(-)
 create mode 100644 doc/alert-api.txt
 create mode 100644 profiles/alert/manager.c
 create mode 100644 profiles/alert/manager.h
 create mode 100755 test/test-alert

-- 
1.7.9.5

