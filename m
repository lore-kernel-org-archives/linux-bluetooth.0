Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [BlueZ v3 00/10] gdbus: Better D-Bus introspection
Date: Fri, 27 Apr 2012 18:14:35 -0300
Message-Id: <1335561285-3332-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This series improves D-Bus introspection in gdbus to ease the life of people
using our interface: they can rely on binding generator available for QT, GTK
and others.

We are doing basically 3 things:

 - Adding the name of the arguments in methods and signals
 - Adding some annotations:
 	- deprecated
	- no-reply
 - Constifying the tables

First two patches were only 2 easy fixes during the development

Lucas De Marchi (10):
  gdbus: return if method signature is malformed
  gdbus: do not call memset for terminating NUL
  gdbus: save copy of undecorated signature
  gdbus: use argument name in method introspection
  gdbus: add decorated signature to arguments
  gdbus: add decorated signature to return values
  gdbus: add Deprecated annotation to introspection
  gdbus: add Method.NoReply annotation to introspection
  Constify GDBus method tables
  Constify GDBus signal tables

 attrib/client.c           |   14 ++--
 audio/control.c           |    6 +-
 audio/device.c            |    8 +-
 audio/gateway.c           |   12 +--
 audio/headset.c           |   22 +++---
 audio/media.c             |   10 +--
 audio/sink.c              |    8 +-
 audio/source.c            |    8 +-
 audio/telephony-dummy.c   |   18 ++---
 audio/telephony-maemo5.c  |    4 +-
 audio/transport.c         |   14 ++--
 doc/serial-api.txt        |    2 +-
 gdbus/gdbus.h             |    6 +-
 gdbus/object.c            |  178 ++++++++++++++++++++++++++++++++++++++++-----
 health/hdp.c              |   28 +++----
 input/device.c            |    8 +-
 network/connection.c      |   10 +--
 network/server.c          |    6 +-
 plugins/dbusoob.c         |    8 +-
 plugins/service.c         |   10 +--
 proximity/monitor.c       |   10 +--
 proximity/reporter.c      |    8 +-
 sap/sap-dummy.c           |    8 +-
 sap/server.c              |    8 +-
 serial/port.c             |    8 +-
 serial/proxy.c            |   20 ++---
 src/adapter.c             |   36 ++++-----
 src/device.c              |   12 +--
 src/manager.c             |   20 ++---
 thermometer/thermometer.c |   18 ++---
 30 files changed, 333 insertions(+), 195 deletions(-)

-- 
1.7.10

