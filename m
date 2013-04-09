Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] MAP client: Add notification dispatcher
Date: Tue,  9 Apr 2013 13:55:20 +0200
Message-Id: <1365508525-13251-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This patch set completes the two patch sets "Add Message Notification Service
(MNS) server" and "Read MASInstanceID for the current connection".
Therefore this patches require those sets as base.

The notification dispatcher component dispatches event reports that are
received by the MNS server to the correct MAS client instance.

The message access part of every client instance registers a notification
handler function. The MNS will call the associated handler for all received
event reports.

For now, the handler will only print a log message for the received
notifications. This is the starting point where we can add the necessary
DBus API parts.

Christian Fetzer (5):
  obexd: Add MAP notification dispatcher
  build: Add support for building MAP notification dispatcher
  obexd: Add function to get the destination from the obc_session
  obexd: Register notification handler in the MAP client
  obexd: Notify registered notification handlers in MNS

 Makefile.obexd                |   1 +
 obexd/client/map-dispatcher.c | 101 ++++++++++++++++++++++++++++++++++++++++++
 obexd/client/map-dispatcher.h |  48 ++++++++++++++++++++
 obexd/client/map.c            |  24 ++++++++++
 obexd/client/mns.c            |  13 +++---
 obexd/client/session.c        |   5 +++
 obexd/client/session.h        |   1 +
 7 files changed, 185 insertions(+), 8 deletions(-)
 create mode 100644 obexd/client/map-dispatcher.c
 create mode 100644 obexd/client/map-dispatcher.h

-- 
1.8.2.1

