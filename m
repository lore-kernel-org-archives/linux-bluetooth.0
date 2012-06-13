Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 00/21] BlueZ 5.0 patches
Date: Wed, 13 Jun 2012 17:43:22 -0300
Message-Id: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

BlueZ 4.100 was just tagged in git so let's start the work towards the
BlueZ 5.0 release.

Gustavo Padovan (21):
  remove compat daemons
  remove the hciops plugin
  headset: remove deprecated DBus methods
  sink: remove deprecated DBus method
  adapter: remove deprecated ListDevices() method
  manager: remove deprecated ListAdapters() method
  adapter: remove btd_adapter_encrypt_link()
  adapter_ops: remove disable_cod_cache
  manager: remove unused manager_add_adapter()
  adapter: make restore powered work again
  serial: remove SerialProxy interface
  serial: remove unneeded headers include
  input: remove unneeded header inclusions
  serial: remove old way to connect to a serial port
  emulator: move it to the tools folder
  btmgmt: move to tools folder
  alert: move alert to profiles dir
  deviceinfo: move to profiles folder
  proximity: move to the profiles folder
  thermometer: move to the profiles folder
  time: move to the profiles folder

 .gitignore                         |    4 +-
 Makefile.am                        |   45 +-
 Makefile.tools                     |   55 +-
 acinclude.m4                       |   18 -
 alert/main.c                       |   58 -
 alert/server.c                     |   38 -
 alert/server.h                     |   26 -
 audio/headset.c                    |  151 --
 audio/sink.c                       |   24 -
 bootstrap-configure                |    3 -
 compat/bnep.c                      |  339 ----
 compat/dun.c                       |  334 ---
 compat/dund.1                      |   72 -
 compat/dund.c                      |  645 ------
 compat/dund.h                      |   40 -
 compat/fakehid.c                   |  669 ------
 compat/fakehid.txt                 |  134 --
 compat/hidd.1                      |   41 -
 compat/hidd.c                      |  848 --------
 compat/hidd.h                      |   30 -
 compat/lib.h                       |   86 -
 compat/msdun.c                     |  153 --
 compat/pand.1                      |   77 -
 compat/pand.c                      |  811 --------
 compat/pand.h                      |   36 -
 compat/sdp.c                       |  706 -------
 compat/sdp.h                       |   39 -
 deviceinfo/deviceinfo.c            |  192 --
 deviceinfo/deviceinfo.h            |   24 -
 deviceinfo/main.c                  |   52 -
 deviceinfo/manager.c               |   80 -
 deviceinfo/manager.h               |   24 -
 doc/adapter-api.txt                |   10 -
 doc/audio-api.txt                  |   33 -
 doc/serial-api.txt                 |  138 +-
 emulator/btdev.c                   | 1076 ----------
 emulator/btdev.h                   |   38 -
 emulator/main.c                    |   73 -
 emulator/server.c                  |  288 ---
 emulator/server.h                  |   30 -
 emulator/vhci.c                    |  133 --
 emulator/vhci.h                    |   35 -
 input/device.c                     |   43 +-
 input/fakehid.c                    |    4 -
 input/manager.c                    |    3 -
 mgmt/main.c                        | 1933 ------------------
 plugins/hciops.c                   | 3943 ------------------------------------
 plugins/mgmtops.c                  |   28 -
 profiles/alert/main.c              |   58 +
 profiles/alert/server.c            |   38 +
 profiles/alert/server.h            |   26 +
 profiles/deviceinfo/deviceinfo.c   |  192 ++
 profiles/deviceinfo/deviceinfo.h   |   24 +
 profiles/deviceinfo/main.c         |   52 +
 profiles/deviceinfo/manager.c      |   80 +
 profiles/deviceinfo/manager.h      |   24 +
 profiles/proximity/immalert.c      |  290 +++
 profiles/proximity/immalert.h      |   26 +
 profiles/proximity/linkloss.c      |  338 ++++
 profiles/proximity/linkloss.h      |   26 +
 profiles/proximity/main.c          |   96 +
 profiles/proximity/manager.c       |  150 ++
 profiles/proximity/manager.h       |   26 +
 profiles/proximity/monitor.c       |  667 ++++++
 profiles/proximity/monitor.h       |   34 +
 profiles/proximity/proximity.conf  |    9 +
 profiles/proximity/reporter.c      |  306 +++
 profiles/proximity/reporter.h      |   42 +
 profiles/thermometer/main.c        |   70 +
 profiles/thermometer/manager.c     |   92 +
 profiles/thermometer/manager.h     |   24 +
 profiles/thermometer/thermometer.c | 1265 ++++++++++++
 profiles/thermometer/thermometer.h |   25 +
 profiles/time/main.c               |   58 +
 profiles/time/server.c             |  154 ++
 profiles/time/server.h             |   26 +
 proximity/immalert.c               |  290 ---
 proximity/immalert.h               |   26 -
 proximity/linkloss.c               |  338 ----
 proximity/linkloss.h               |   26 -
 proximity/main.c                   |   96 -
 proximity/manager.c                |  150 --
 proximity/manager.h                |   26 -
 proximity/monitor.c                |  667 ------
 proximity/monitor.h                |   34 -
 proximity/proximity.conf           |    9 -
 proximity/reporter.c               |  306 ---
 proximity/reporter.h               |   42 -
 serial/manager.c                   |   47 -
 serial/port.c                      |  210 +-
 serial/proxy.c                     | 1269 ------------
 serial/proxy.h                     |   25 -
 src/adapter.c                      |   48 +-
 src/adapter.h                      |    7 -
 src/manager.c                      |   45 -
 src/manager.h                      |    1 -
 thermometer/main.c                 |   70 -
 thermometer/manager.c              |   92 -
 thermometer/manager.h              |   24 -
 thermometer/thermometer.c          | 1265 ------------
 thermometer/thermometer.h          |   25 -
 time/main.c                        |   58 -
 time/server.c                      |  154 --
 time/server.h                      |   26 -
 tools/emulator/btdev.c             | 1076 ++++++++++
 tools/emulator/btdev.h             |   38 +
 tools/emulator/main.c              |   73 +
 tools/emulator/server.c            |  288 +++
 tools/emulator/server.h            |   30 +
 tools/emulator/vhci.c              |  133 ++
 tools/emulator/vhci.h              |   35 +
 tools/mgmt/main.c                  | 1933 ++++++++++++++++++
 112 files changed, 7884 insertions(+), 18978 deletions(-)
 delete mode 100644 alert/main.c
 delete mode 100644 alert/server.c
 delete mode 100644 alert/server.h
 delete mode 100644 compat/bnep.c
 delete mode 100644 compat/dun.c
 delete mode 100644 compat/dund.1
 delete mode 100644 compat/dund.c
 delete mode 100644 compat/dund.h
 delete mode 100644 compat/fakehid.c
 delete mode 100644 compat/fakehid.txt
 delete mode 100644 compat/hidd.1
 delete mode 100644 compat/hidd.c
 delete mode 100644 compat/hidd.h
 delete mode 100644 compat/lib.h
 delete mode 100644 compat/msdun.c
 delete mode 100644 compat/pand.1
 delete mode 100644 compat/pand.c
 delete mode 100644 compat/pand.h
 delete mode 100644 compat/sdp.c
 delete mode 100644 compat/sdp.h
 delete mode 100644 deviceinfo/deviceinfo.c
 delete mode 100644 deviceinfo/deviceinfo.h
 delete mode 100644 deviceinfo/main.c
 delete mode 100644 deviceinfo/manager.c
 delete mode 100644 deviceinfo/manager.h
 delete mode 100644 emulator/btdev.c
 delete mode 100644 emulator/btdev.h
 delete mode 100644 emulator/main.c
 delete mode 100644 emulator/server.c
 delete mode 100644 emulator/server.h
 delete mode 100644 emulator/vhci.c
 delete mode 100644 emulator/vhci.h
 delete mode 100644 mgmt/main.c
 delete mode 100644 plugins/hciops.c
 create mode 100644 profiles/alert/main.c
 create mode 100644 profiles/alert/server.c
 create mode 100644 profiles/alert/server.h
 create mode 100644 profiles/deviceinfo/deviceinfo.c
 create mode 100644 profiles/deviceinfo/deviceinfo.h
 create mode 100644 profiles/deviceinfo/main.c
 create mode 100644 profiles/deviceinfo/manager.c
 create mode 100644 profiles/deviceinfo/manager.h
 create mode 100644 profiles/proximity/immalert.c
 create mode 100644 profiles/proximity/immalert.h
 create mode 100644 profiles/proximity/linkloss.c
 create mode 100644 profiles/proximity/linkloss.h
 create mode 100644 profiles/proximity/main.c
 create mode 100644 profiles/proximity/manager.c
 create mode 100644 profiles/proximity/manager.h
 create mode 100644 profiles/proximity/monitor.c
 create mode 100644 profiles/proximity/monitor.h
 create mode 100644 profiles/proximity/proximity.conf
 create mode 100644 profiles/proximity/reporter.c
 create mode 100644 profiles/proximity/reporter.h
 create mode 100644 profiles/thermometer/main.c
 create mode 100644 profiles/thermometer/manager.c
 create mode 100644 profiles/thermometer/manager.h
 create mode 100644 profiles/thermometer/thermometer.c
 create mode 100644 profiles/thermometer/thermometer.h
 create mode 100644 profiles/time/main.c
 create mode 100644 profiles/time/server.c
 create mode 100644 profiles/time/server.h
 delete mode 100644 proximity/immalert.c
 delete mode 100644 proximity/immalert.h
 delete mode 100644 proximity/linkloss.c
 delete mode 100644 proximity/linkloss.h
 delete mode 100644 proximity/main.c
 delete mode 100644 proximity/manager.c
 delete mode 100644 proximity/manager.h
 delete mode 100644 proximity/monitor.c
 delete mode 100644 proximity/monitor.h
 delete mode 100644 proximity/proximity.conf
 delete mode 100644 proximity/reporter.c
 delete mode 100644 proximity/reporter.h
 delete mode 100644 serial/proxy.c
 delete mode 100644 serial/proxy.h
 delete mode 100644 thermometer/main.c
 delete mode 100644 thermometer/manager.c
 delete mode 100644 thermometer/manager.h
 delete mode 100644 thermometer/thermometer.c
 delete mode 100644 thermometer/thermometer.h
 delete mode 100644 time/main.c
 delete mode 100644 time/server.c
 delete mode 100644 time/server.h
 create mode 100644 tools/emulator/btdev.c
 create mode 100644 tools/emulator/btdev.h
 create mode 100644 tools/emulator/main.c
 create mode 100644 tools/emulator/server.c
 create mode 100644 tools/emulator/server.h
 create mode 100644 tools/emulator/vhci.c
 create mode 100644 tools/emulator/vhci.h
 create mode 100644 tools/mgmt/main.c

-- 
1.7.10.2

