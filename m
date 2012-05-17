Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v6 00/15] gdbus: Better D-Bus introspection
Date: Thu, 17 May 2012 15:19:57 -0300
Message-Id: <1337278812-4837-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes from v5:
	- Split patches related to gdbus/, without breaking git-bisetc
	- Create macros to ease the definition of GDBus tables

Lucas De Marchi (15):
  gdbus: return if method signature is malformed
  gdbus: do not call memset for terminating NUL
  Constify GDBus method tables
  Constify GDBus signal tables
  gdbus: add argument info to methods and signals
  gdbus: add and use helpers for table declarations
  Convert GDBus methods to use macro helpers
  gdbus: use GDBusArgInfo to generate introspection
  gdbus: loop over args to check message signature
  Do not set signature and reply in GDBus tables
  gdbus: remove signature and reply from tables
  gdbus: add Deprecated annotation in introspection
  gdbus: add Method.NoReply annotation in introspection
  gdbus: do not check signature twice
  adapter: do not check signature twice

 attrib/client.c           |   32 +++++++----
 audio/control.c           |   28 ++++++----
 audio/device.c            |   20 ++++---
 audio/gateway.c           |   25 +++++----
 audio/headset.c           |   81 +++++++++++++++------------
 audio/media.c             |   17 ++++--
 audio/sink.c              |   34 ++++++------
 audio/source.c            |   21 +++----
 audio/telephony-dummy.c   |   36 ++++++++----
 audio/telephony-maemo5.c  |    7 ++-
 audio/transport.c         |   27 ++++++---
 gdbus/gdbus.h             |   47 +++++++++++++++-
 gdbus/object.c            |  134 ++++++++++++++++++++++-----------------------
 health/hdp.c              |   65 ++++++++++++++--------
 input/device.c            |   18 +++---
 network/connection.c      |   18 +++---
 network/server.c          |   10 +++-
 plugins/dbusoob.c         |   19 +++++--
 plugins/service.c         |   23 +++++---
 proximity/monitor.c       |   16 ++++--
 proximity/reporter.c      |   11 ++--
 sap/sap-dummy.c           |   17 ++++--
 sap/server.c              |   13 +++--
 serial/port.c             |   14 +++--
 serial/proxy.c            |   37 +++++++++----
 src/adapter.c             |   88 ++++++++++++++++++-----------
 src/device.c              |   28 ++++++----
 src/manager.c             |   34 ++++++++----
 thermometer/thermometer.c |   32 +++++++----
 29 files changed, 594 insertions(+), 358 deletions(-)

-- 
1.7.10.2

