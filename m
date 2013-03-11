Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/8] MAP client: notification support
Date: Mon, 11 Mar 2013 16:05:42 +0100
Message-Id: <1363014350-16114-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Changelog:
v3: Added user_data parameter to dispatcher. This is needed for accessing struct map_data
    in the notification handler.
v2: Rebased since the first patchset didn't apply cleanly anymore.

---

This patchset adds the necessary blocks for receiving notifications in the MAP client.
So far this covers only bluetooth protocol related additions, leaving out end user D-Bus API changes.

The patchset consists of the following parts:
- Message Notification Server (MNS)
  Once connected, the MNS will receive XML based event reports from the MSE and parse them into a struct
  for further processing.

- RegisterNotification function
  The function sends the SetNotificationRegistration command to the MSE which will then try to connect
  to the MNS.

- Notification dispatcher (that dispatches event reports by their MAS instance id to the correct client instance)
  The message access part of every client instance registers a notification handler function.
  The MNS will call the associated handler for all received event report.

Since the dispatching needs to be done on the mas instance id, the message access part of the client
needs to be aware of the instance id of the server it connects to. Unfortunately this information is only
available as SDP attribute.

Due to the current transport layer abstraction in obexd, the MAP client has no direct access to SDP.
Therefore I have extended obc_transport to allow concrete transports (like Bluetooth) to specify
a get_service_record function and made it available through obc_session_get_service_record.
This way, transports can provide additional service information to the client implementations.
The bluetooth transport will now always do a sdp lookup (if the driver's obc_driver->force_service_lookup is set).
In addition it will cache sdp record associated with the connection and make it accessible in get_service_record.

Christian Fetzer (8):
  obexd: Add get_service_record to obc_transport
  obexd: Provide SDP record in get_service_record
  obexd: Read MAP client SDP attributes
  obexd: Add Message Notification Server (MNS)
  obexd: Add RegisterNotifications function
  obexd: Add MAP notification dispatcher
  obexd: Register MAP notification handler
  obexd: Notify registered notification handlers

 Makefile.obexd                |   4 +
 doc/obex-api.txt              |   6 +
 lib/sdp.h                     |   2 +
 obexd/client/bluetooth.c      |  51 ++++++-
 obexd/client/driver.h         |   1 +
 obexd/client/map-dispatcher.c |  88 +++++++++++
 obexd/client/map-dispatcher.h |  47 ++++++
 obexd/client/map-event.h      |  42 +++++
 obexd/client/map.c            | 146 +++++++++++++++++-
 obexd/client/mns.c            | 346 ++++++++++++++++++++++++++++++++++++++++++
 obexd/client/session.c        |  11 +-
 obexd/client/session.h        |   2 +
 obexd/client/transport.h      |   2 +
 obexd/plugins/bluetooth.c     |   2 +
 obexd/src/obexd.h             |   1 +
 src/profile.c                 |  55 +++++++
 16 files changed, 795 insertions(+), 11 deletions(-)
 create mode 100644 obexd/client/map-dispatcher.c
 create mode 100644 obexd/client/map-dispatcher.h
 create mode 100644 obexd/client/map-event.h
 create mode 100644 obexd/client/mns.c

-- 
1.8.1.5

