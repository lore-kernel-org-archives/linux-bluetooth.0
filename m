Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 00/17] RFC: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:02 +0200
Message-ID: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here's series of patches which makes handling of DBusConnection object
across code simpler and more consistent.

Problem with current implementation is that different modules handles
reference to D-Bus in a different way, e.g. some use dbus_bus_get() and
just store it in static variable, others pass this around via multiple
calls to finally store it in per-{adapter,device,request} structure or
some just use get_dbus_connection() call to have it immediately.

This creates a lot of redundant code which only (un)refs DBusConnection
and pass it around for no particular reason, because you can use global
reference which is exactly the same object.

What following patches do is:
(1) prefix get_dbus_connection() with btd_ so it can be used by external
    plugins
(2) make sure D-Bus is disconnected after all modules (agent, mamanger,
    plugins etc.) are shutdown
(3) remove any redundant internal references and function parameters that
    pass/store DBusConnection and just use btd_get_dbus_connection() where
    need to pass valid DBusConnection object (no need to ref it, there's
    one global ref and it's always valid as per #2)

This makes things with D-Bus really simple: you need to pass DBusConnection
object somewhere - call btd_get_dbus_connection() and you have it. No need
to store it, no need to ref it. Perhaps some downside of this approach is
that few files (hdp.c, telephony-maemo{5,6}.c) have quite a lot of such calls
but if this is something to avoid we can still add global static variable
and call btd_get_dbus_connection() once in *_init(), just like dbusoob plugin
does now.

Comments are welcome.


Andrzej Kaczmarek (17):
  Rename get_dbus_connection to btd_get_dbus_connection
  core: Make D-Bus connection valid for entire bluetoothd lifetime
  dbus-common: Remove conn parameter from emit_property_changed
  dbus-common: Remove conn parameter from emit_array_property_changed
  manager: Simplify DBusConnection object handling
  agent: Simplify DBusConnection object handling
  device: Simplify DBusConnection object handling
  adapter: Simplify DBusConnection object handling
  attrib: Simplify DBusConnection object handling
  audio: Simplify DBusConnection object handling
  health: Simplify DBusConnection object handling
  input: Simplify DBusConnection object handling
  network: Simplify DBusConnection object handling
  sap: Simplify DBusConnection object handling
  thermometer: Simplify DBusConnection object handling
  service: Simplify DBusConnection object handling
  dbusoob: Simplify DBusConnection object handling

 attrib/client.c                    |  41 +++----
 attrib/client.h                    |   3 +-
 audio/a2dp.c                       |   9 +-
 audio/a2dp.h                       |   2 +-
 audio/avrcp.c                      |   2 +-
 audio/avrcp.h                      |   2 +-
 audio/control.c                    |  17 +--
 audio/device.c                     |  22 ++--
 audio/device.h                     |   4 +-
 audio/gateway.c                    |  26 ++---
 audio/headset.c                    |  68 ++++++-----
 audio/main.c                       |  15 +--
 audio/manager.c                    |  23 +---
 audio/manager.h                    |   3 +-
 audio/media.c                      |  69 +++++-------
 audio/media.h                      |   2 +-
 audio/sink.c                       |  54 ++++-----
 audio/source.c                     |  30 ++---
 audio/telephony-dummy.c            |  17 ++-
 audio/telephony-maemo5.c           |  51 ++++-----
 audio/telephony-maemo6.c           |  36 +++---
 audio/telephony-ofono.c            |  25 ++---
 audio/transport.c                  |  51 ++++-----
 audio/transport.h                  |   3 +-
 plugins/dbusoob.c                  |  15 ++-
 plugins/service.c                  |  74 +++++-------
 profiles/health/hdp.c              | 182 ++++++++++++++----------------
 profiles/health/hdp.h              |   6 +-
 profiles/health/hdp_main.c         |  16 +--
 profiles/health/hdp_manager.c      |  15 +--
 profiles/health/hdp_manager.h      |   2 +-
 profiles/health/hdp_types.h        |   2 -
 profiles/health/hdp_util.c         |   6 +-
 profiles/input/device.c            |  35 +++---
 profiles/input/device.h            |   6 +-
 profiles/input/main.c              |  12 +-
 profiles/input/manager.c           |  10 +-
 profiles/input/manager.h           |   2 +-
 profiles/network/connection.c      |  70 +++++-------
 profiles/network/connection.h      |   2 -
 profiles/network/main.c            |  15 +--
 profiles/network/manager.c         |  16 +--
 profiles/network/manager.h         |   2 +-
 profiles/network/server.c          |  13 +--
 profiles/network/server.h          |   2 +-
 profiles/proximity/immalert.c      |   2 +-
 profiles/proximity/linkloss.c      |   2 +-
 profiles/proximity/monitor.c       |  22 ++--
 profiles/proximity/reporter.c      |   4 +-
 profiles/sap/main.c                |  16 +--
 profiles/sap/manager.c             |  17 +--
 profiles/sap/manager.h             |   2 +-
 profiles/sap/sap-dummy.c           |  19 +---
 profiles/sap/server.c              |  29 ++---
 profiles/sap/server.h              |   2 -
 profiles/thermometer/main.c        |  17 +--
 profiles/thermometer/manager.c     |  11 +-
 profiles/thermometer/manager.h     |   2 +-
 profiles/thermometer/thermometer.c |  30 +++--
 profiles/thermometer/thermometer.h |   3 +-
 src/adapter.c                      | 199 +++++++++++++++-----------------
 src/adapter.h                      |   8 +-
 src/agent.c                        |  44 +++-----
 src/agent.h                        |   3 -
 src/dbus-common.c                  |  12 +-
 src/dbus-common.h                  |   8 +-
 src/device.c                       | 225 +++++++++++++++++--------------------
 src/device.h                       |  29 +++--
 src/event.c                        |  17 +--
 src/main.c                         |  20 ++--
 src/manager.c                      |  41 ++++---
 src/manager.h                      |   4 +-
 72 files changed, 758 insertions(+), 1108 deletions(-)

-- 
1.7.11.3

