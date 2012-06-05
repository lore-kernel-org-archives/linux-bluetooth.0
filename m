Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 00/23 v2] Change D-Bus namespace to org.bluez.obex
Date: Tue,  5 Jun 2012 16:02:48 +0300
Message-Id: <1338901391-17138-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The following patches changes the namespace from org.openobex to
org.bluez.obex, getting rid of the last remaining references to openobex
dependency.

This also serve as a fundation for the possible move of obexd inside BlueZ
repository.

v2: Fix invalid syntax on pbap-client

Luiz Augusto von Dentz (23):
  obexd-api: Change D-Bus namespace to org.bluez.obexd
  core: Change D-Bus namespace to org.bluez.obex
  core: Change D-Bus service file to use org.bluez.obex
  agent-api: Change D-Bus namespace to org.bluez.obexd
  core: Change agent interface to org.bluez.obex.Agent
  test: Use org.bluez.obex namespace in simple-agent script
  client-api: Change D-Bus namespace to org.bluez.obex.client
  client: Change namespace to org.bluez.obex.client
  client: Change D-Bus service file to use org.bluez.obex.client
  client-api: Rename session interface to org.bluez.obex.Session
  client-api: Rename ObjectPush interface to org.bluez.obex.ObjectPush
  client-api: Rename FileTransfer interface to
    org.bluez.obex.FileTransfer
  client-api: Rename PhonebookAccess interface to
    org.bluez.obex.PhonebookAccess
  client-api: Rename Synchronization interface to
    org.bluez.obex.Synchronization
  client-api: Rename MessageAccess interface to
    org.bluez.obex.MessageAccess
  client-api: Rename Transfer interface to org.bluez.obex.Transfer
  test: Use org.bluez.obex namespace in exchange-business-cards script
  test: Use org.bluez.obex namespace in list-folders script
  test: Use org.bluez.obex namespace in ftp-client script
  test: Use org.bluez.obex namespace in map-client script
  test: Use org.bluez.obex namespace in opp-client script
  test: Use org.bluez.obex namespace in pbap-client script
  test: Use org.bluez.obex namespace in get-capabilities script

 client/ftp.c                  |    2 +-
 client/manager.c              |    6 +++---
 client/map.c                  |    2 +-
 client/obex-client.service.in |    2 +-
 client/opp.c                  |    2 +-
 client/pbap.c                 |    2 +-
 client/session.c              |    4 ++--
 client/sync.c                 |    2 +-
 client/transfer.c             |    4 ++--
 doc/agent-api.txt             |    6 +++---
 doc/client-api.txt            |   30 ++++++++++++++---------------
 doc/obexd-api.txt             |   16 ++++++++--------
 plugins/syncevolution.c       |    3 +--
 src/manager.c                 |   42 ++++++++++++++++++++---------------------
 src/manager.h                 |    2 +-
 src/obexd.service.in          |    2 +-
 test/exchange-business-cards  |   11 +++++------
 test/ftp-client               |   27 +++++++++++++-------------
 test/get-capabilities         |    8 ++++----
 test/list-folders             |   10 +++++-----
 test/map-client               |   10 +++++-----
 test/opp-client               |   25 ++++++++++++------------
 test/pbap-client              |   38 +++++++++++++++++++++----------------
 test/simple-agent             |   37 ++++++++++++++++++------------------
 24 files changed, 149 insertions(+), 144 deletions(-)

-- 
1.7.10.2

