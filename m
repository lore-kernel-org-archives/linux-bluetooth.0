Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH RESEND BlueZ v6 00/13] Better D-Bus introspection
Date: Fri, 18 May 2012 00:23:24 -0300
Message-Id: <1337311417-1245-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The last time "Constify GDBus method tables" was mixing gdbus/ with the other
patches. Since the gdbus/ part was already applied, just rebase on top of is
already there.


Lucas De Marchi (13):
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
 audio/control.c           |   28 +++++----
 audio/device.c            |   20 ++++---
 audio/gateway.c           |   25 +++++----
 audio/headset.c           |   81 +++++++++++++++------------
 audio/media.c             |   17 ++++--
 audio/sink.c              |   34 +++++------
 audio/source.c            |   21 +++----
 audio/telephony-dummy.c   |   36 ++++++++----
 audio/telephony-maemo5.c  |    7 ++-
 audio/transport.c         |   27 ++++++---
 gdbus/gdbus.h             |   47 +++++++++++++++-
 gdbus/object.c            |  137 +++++++++++++++++++++------------------------
 health/hdp.c              |   65 +++++++++++++--------
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
 serial/proxy.c            |   37 ++++++++----
 src/adapter.c             |   88 ++++++++++++++++++-----------
 src/device.c              |   28 +++++----
 src/manager.c             |   34 +++++++----
 thermometer/thermometer.c |   32 +++++++----
 29 files changed, 593 insertions(+), 362 deletions(-)

-- 
1.7.10.2

