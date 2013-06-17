Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/6] MAP client: Add notification dispatching
Date: Mon, 17 Jun 2013 10:35:25 +0200
Message-Id: <1371458131-2741-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Changelog:
v2:
  - Implement dispatching in map-event.c
  - Rename map_acquire_mns to map_register_event_handler
  - Pass obc_session directly instead of copying address
--

This patch set completes the two patch sets "Add Message Notification Service
(MNS) server" and "Read MASInstanceID for the current connection".

The notification dispatcher component dispatches event reports that are
received by the MNS server to the correct MAS client instance.

The message access part of every client instance registers a notification
handler function. The MNS will call the associated handler for all received
event reports.

For now, the handler will only print a log message for the received
notifications. This is the starting point where we can add the necessary
DBus API parts.

Christian Fetzer (6):
  obexd: Add function to get the destination from the obc_session
  obexd: Add MAP notification dispatching
  build: Add support for building MAP notification dispatcher
  obexd: Register notification handler in the MAP client
  obexd: Notify registered notification handlers in MNS
  obexd: Fix crash when retrieving multiple MAP event reports

 Makefile.obexd           |   1 +
 obexd/client/map-event.c | 112 +++++++++++++++++++++++++++++++++++++++++++++++
 obexd/client/map-event.h |  29 ++++++++++++
 obexd/client/map.c       |  25 +++++++++++
 obexd/client/mns.c       |  18 ++++----
 obexd/client/session.c   |   5 +++
 obexd/client/session.h   |   1 +
 7 files changed, 181 insertions(+), 10 deletions(-)
 create mode 100644 obexd/client/map-event.c

-- 
1.8.2.3

