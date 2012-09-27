Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 00/27] Add support for PASP and ANP server profiles
Date: Thu, 27 Sep 2012 14:36:09 -0400
Message-Id: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
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

Changes since v1:

* Rebase against latest btd_profile changes
* Add test-alert to Makefile.tools and alert-api.txt to Makefile.am
* Add org.bluez.AlertAgent to D-Bus policy file (patch 27/27)
* Implement Release() agent method (patch 26/27)
* Remove Suspend()/Resume() from documentation (they are not implemented, and
  they are optimizations that can be added later if necessary).


Anderson Lizardo (13):
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
  alert: Implement Release() agent method
  alert: Add org.bluez.AlertAgent to D-Bus policy file

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

 Makefile.am              |    5 +-
 Makefile.tools           |    3 +-
 doc/alert-api.txt        |  109 ++++++
 profiles/alert/main.c    |    6 +-
 profiles/alert/manager.c |   40 ++
 profiles/alert/manager.h |   26 ++
 profiles/alert/server.c  |  962 ++++++++++++++++++++++++++++++++++++++++++++++
 src/bluetooth.conf       |    1 +
 test/test-alert          |  180 +++++++++
 9 files changed, 1326 insertions(+), 6 deletions(-)
 create mode 100644 doc/alert-api.txt
 create mode 100644 profiles/alert/manager.c
 create mode 100644 profiles/alert/manager.h
 create mode 100755 test/test-alert

-- 
1.7.9.5

