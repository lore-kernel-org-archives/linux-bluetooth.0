Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/6] MAP client: Read MASInstanceID for the current connection
Date: Fri, 12 Apr 2013 11:29:00 +0200
Message-Id: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

Changelog v2:
- Replaced get_service_record by get_attribute
- Removed force sdp lookup

--

This patch set allows the MAP client profile implementation to read the
instance id of the MAS server it is connected to.

This is a prerequisite for receiving event reports and distributing them to the
correct MAS client instance. The instance id is only available as SDP
attribute.

Due to the current transport layer abstraction in obexd, the MAP client has no
direct access to SDP. Therefore I have extended obc_transport to allow concrete
transports (like Bluetooth) to specify a getattribute function and made
it available through obc_session_get_attribute. This way, transports can
provide additional service information to the client implementations.

Christian Fetzer (6):
  obexd: Cache SDP record in bluetooth transport
  obexd: Add getattribute to obc_transport
  obexd: Add bluetooth_getattribute to Bluetooth transport
  obexd: Add obc_session_get_attribute to session
  lib: Add attributes MASInstanceID and SupportedMessageTypes
  obexd: Read service attributes when instantiating MAP session

 lib/sdp.h                |  2 ++
 obexd/client/bluetooth.c | 36 ++++++++++++++++++++++++++++++++++--
 obexd/client/map.c       | 31 +++++++++++++++++++++++++++++--
 obexd/client/session.c   | 11 +++++++++++
 obexd/client/session.h   |  3 +++
 obexd/client/transport.h |  1 +
 6 files changed, 80 insertions(+), 4 deletions(-)

-- 
1.8.2.1

