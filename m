Return-Path: <cyrus@holtmann.org>
From: anderson.briglia@openbossa.org
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>
Subject: [RFC 0/7] Implement Proximity Path Loss
Date: Wed, 15 Jun 2011 17:02:57 -0400
Message-Id: <4df91d68.0b73650a.190f.17a4@mx.google.com>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Anderson Briglia <anderson.briglia@openbossa.org>

The following changes intend to be used by Proximity Monitor (mainly).
Proximity Path Loss needs to track the RSSI and TX Power. The suggested
approach for RSSI and TX power is similar to adapter powered callbacks, a
client(Proximity Monitor in our case) will register a callback per remote to be
notified when the RSSI of the active connection changes. Tx power will be used
by the Proximity Reporter to update the Tx Power Characteristic of the active
connection.

In this first proposal, the adapter reads the RSSI and/or Tx Power on regular
intervals(2 seconds) using hciops or mgmtops if there is at least one callback
registered.  Callbacks(per remote) can be registered using
btd_adapter_register_rssi_callback/btd_adapter_register_txpower_callback
functions.  Results from the hciops or mgmtops are reported using btd_event_xxx
and the value is "routed" to the registered callbacks.

Comments are welcome.

Anderson Briglia

Anderson Briglia (1):
  Implement mgmt_read_rssi command

Bruna Moreira (2):
  Implement mgmt_read_tx_power command
  Update Management API documentation

Claudio Takahasi (3):
  Add current tx power read on hciops
  Add RSSI read callbacks
  Add transmission power callbacks

Sheldon Demario (1):
  Add read RSSI on hciops

 doc/mgmt-api.txt  |   20 +++++
 lib/mgmt.h        |   20 +++++
 plugins/hciops.c  |   82 +++++++++++++++++++++
 plugins/mgmtops.c |  106 +++++++++++++++++++++++++++
 src/adapter.c     |  204 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h     |   25 +++++++
 src/event.c       |   26 +++++++
 src/event.h       |    2 +
 8 files changed, 485 insertions(+), 0 deletions(-)

-- 
1.7.4.1

