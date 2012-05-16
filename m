Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v5 00/13] gdbus: Better D-Bus introspection
Date: Wed, 16 May 2012 20:33:00 -0300
Message-Id: <1337211193-18230-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v5: only rebase

Message from v4: 


	This is v4 of this series. The biggest difference from v3 is that we are not
	adding a decorated signature anymore. Instead we define the type GDBusArgInfo
	and add fields in_args, out_args and args into the tables.

	First 4 patches are the same as before and are independent from the others.

	Patches 5, 6, 7, 8 and 9 are split like this because gdbus is used in projects
	other than BlueZ, so the first 2 patches can be easily ported there.

	Patches 10 and 11 add annotations, just as in v3.

	Last 2 patches are minor fixes, because checking the same thing twice don't
	make it a stronger check.


Lucas De Marchi (13):
  gdbus: return if method signature is malformed
  gdbus: do not call memset for terminating NUL
  Constify GDBus method tables
  Constify GDBus signal tables
  gdbus: add argument info to methods and signals
  Convert GDBus methods and signals to use GDBusArgInfo
  gdbus: use GDBusArgInfo to generate introspection
  gdbus: loop over args to check message signature
  gdbus: remove signatures from tables
  gdbus: add Deprecated annotation in introspection
  gdbus: add Method.NoReply annotation in introspection
  gdbus: do not check signature twice
  adapter: do not check signature twice

 attrib/client.c           |   35 ++++++++----
 audio/control.c           |   33 +++++++----
 audio/device.c            |   23 +++++---
 audio/gateway.c           |   30 ++++++----
 audio/headset.c           |   93 +++++++++++++++++++------------
 audio/media.c             |   23 ++++++--
 audio/sink.c              |   37 ++++++------
 audio/source.c            |   24 ++++----
 audio/telephony-dummy.c   |   38 +++++++++----
 audio/telephony-maemo5.c  |    8 ++-
 audio/transport.c         |   30 +++++++---
 gdbus/gdbus.h             |   11 +++-
 gdbus/object.c            |  136 ++++++++++++++++++++++-----------------------
 health/hdp.c              |   69 ++++++++++++++++-------
 input/device.c            |   19 ++++---
 network/connection.c      |   23 +++++---
 network/server.c          |   11 +++-
 plugins/dbusoob.c         |   18 ++++--
 plugins/service.c         |   24 +++++---
 proximity/monitor.c       |   19 +++++--
 proximity/reporter.c      |   14 +++--
 sap/sap-dummy.c           |   18 ++++--
 sap/server.c              |   16 ++++--
 serial/port.c             |   17 ++++--
 serial/proxy.c            |   38 +++++++++----
 src/adapter.c             |   94 ++++++++++++++++++++-----------
 src/device.c              |   32 +++++++----
 src/manager.c             |   40 +++++++++----
 thermometer/thermometer.c |   35 ++++++++----
 29 files changed, 655 insertions(+), 353 deletions(-)

-- 
1.7.10.2

