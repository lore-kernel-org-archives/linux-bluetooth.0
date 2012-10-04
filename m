Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 0/7] adapter and device bdaddr_t getters
Date: Thu, 4 Oct 2012 14:05:57 +0200
Message-ID: <1349352364-5491-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

I've noticed that in many places similar code was created to adapt to current
adapter/device_get_address API:

bdaddr_t addr;
adapter_get_address(adapter, &addr);
foo(&addr);

bdaddr is constant anyway and such code can be converted to more convenient
foo(adapter_get_address(adapter));

Thanks to this we reduce number of memcpy calls of data that is not going to
change. Also number of local variables is removed (in places where it reduced
number of consecutive get_address calls or due to code readibility local
pointers were left).

Since this leads to calls where return is passed directly as function parameter
adapter/device_get_address could also be renamed to shorter form e.g.
adapter/device_get_addr  (like device_get_addr_type is called now).
(this is not done in this patchset).

Comments are welcome.

Szymon Janc (7):
  adapter: Convert adapter_get_address into simple getter
  storage: Constify bdaddr_t pointers parameters
  adapter: Constify pointer returned by adapter_get_address
  device: Convert device_get_address into simple getter
  mgmt: Constify use of bdaddr_t pointer parameters
  adapter: Constify use of bdaddr_t pointer parameters
  device: Make device_get_address return const pointer

 attrib/client.c               |   42 +++++------
 audio/manager.c               |   50 +++++--------
 plugins/adaptername.c         |    4 +-
 plugins/dbusoob.c             |    8 +--
 plugins/neard.c               |   21 +++---
 plugins/service.c             |   57 +++++----------
 plugins/wiimote.c             |    7 +-
 profiles/alert/server.c       |    4 +-
 profiles/gatt/gas.c           |   34 +++++----
 profiles/health/hdp.c         |   18 +++--
 profiles/health/hdp_util.c    |   42 +++++------
 profiles/health/mcap.c        |    2 +-
 profiles/health/mcap_lib.h    |    2 +-
 profiles/input/device.c       |    8 +--
 profiles/input/manager.c      |   11 +--
 profiles/network/connection.c |    6 +-
 profiles/network/connection.h |    2 +-
 profiles/network/manager.c    |   13 ++--
 profiles/network/server.c     |    8 +--
 profiles/proximity/monitor.c  |   20 +++---
 profiles/sap/manager.c        |    5 +-
 profiles/sap/server.c         |    2 +-
 profiles/sap/server.h         |    2 +-
 src/adapter.c                 |   73 +++++++++----------
 src/adapter.h                 |   59 +++++++++-------
 src/attrib-server.c           |   18 ++---
 src/device.c                  |  157 ++++++++++++++++-------------------------
 src/device.h                  |    3 +-
 src/eir.c                     |    2 +-
 src/eir.h                     |    2 +-
 src/event.c                   |   27 +++----
 src/manager.c                 |    5 +-
 src/mgmt.c                    |   31 ++++----
 src/mgmt.h                    |   26 +++----
 src/profile.c                 |   47 ++++++------
 src/storage.c                 |   97 +++++++++++++------------
 src/storage.h                 |   95 ++++++++++++++-----------
 37 files changed, 451 insertions(+), 559 deletions(-)

-- 
1.7.9.5

