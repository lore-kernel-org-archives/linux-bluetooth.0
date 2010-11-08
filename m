Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/9] Fixing DBus error system in BlueZ
Date: Mon,  8 Nov 2010 04:29:38 -0200
Message-Id: <1289197787-16715-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here are some patches that try to fix the mess of reporting error to
DBus inside BlueZ. It follows the oFono and ConnMan error system.

The goal is to get ride of any directly call to g_dbus_create_error()
inside bluez code, changing that to __btd_error_*. This patch set
doesn't fix all of them yet, but is a very good start. Please review.


Gustavo F. Padovan (9):
  Create __btd_error_invalid_args()
  Add __btd_error_already_exists()
  Add __btd_error_not_supported()
  Add __btd_error_not_connected()
  Add __btd_error_in_progress()
  Add __btd_error_not_available()
  Add __btd_error_busy()
  Add __btd_error_does_not_exist()
  Add __btd_error_not_authorized()

 attrib/client.c          |   28 ++++-----------
 audio/control.c          |   16 ++-------
 audio/device.c           |    6 +--
 audio/gateway.c          |   16 ++-------
 audio/headset.c          |   58 ++++++++++-----------------------
 audio/media.c            |   12 ++----
 audio/sink.c             |   10 ++----
 audio/source.c           |    7 +---
 audio/telephony-dummy.c  |   25 ++++++--------
 audio/telephony-maemo5.c |   11 ++----
 audio/telephony-maemo6.c |   11 ++----
 audio/transport.c        |   14 ++------
 health/hdp.c             |   58 ++++++++------------------------
 input/device.c           |    8 +----
 network/server.c         |    9 +----
 plugins/service.c        |   56 ++++++++------------------------
 serial/port.c            |   20 +----------
 serial/proxy.c           |   31 ++++-------------
 src/adapter.c            |   81 +++++++++++++++++-----------------------------
 src/device.c             |   49 ++++++++--------------------
 src/error.c              |   62 +++++++++++++++++++++++++++++++++++
 src/error.h              |   10 ++++++
 src/manager.c            |    7 ----
 23 files changed, 221 insertions(+), 384 deletions(-)

-- 
1.7.3.1

