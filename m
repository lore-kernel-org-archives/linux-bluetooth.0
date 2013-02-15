Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 0/8] LE Connection Routine
Date: Fri, 15 Feb 2013 20:27:00 -0300
Message-Id: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

This v2 RFC series address Marcel's comment regarding a separated state
machine for handling LE connection attempts. So in this series it was
introduced a new state machine for carrying out the general connection
establishment procedure.

>From the previous cover letter:

In order to better support LE connection requirements, such as multiple
connections and re-connections, we should support the general connection
establishment procedure in kernel side. Today, we support only the direct
connection establishment procedure which has some limitations and, therefore,
requires extra connection management at user-space.

According to the spec (Vol 3, Part C, section 9.3.6), the general procedure is
described as follows: The host starts scanning for LE devices, once the device
we want to connect to is in-range, the host stops scanning and initiates a
connection. The procedure is terminated when the connection is established or
when the host terminates the procedure.

This RFC series implements the basic support for general connection procedure.
The first patches do simple changes required to implement this new LE
connection routine. It has not been well tested, but the basic LE connection
and disconnection cases have been covered.

This is an initial work, so it doesn't support multiple LE connection attempts
at the same time (current kernel doesn't support too) and doesn't handle
concurrent device discovery properly.

The next steps are the following:
1. Cover some corner cases in this series.
2. Add support for multiple LE connection attempts.
3. Handle concurrent LE connections and device discovery
4. Add better support for controller which a capable of scanning and initiating
LE connection at the same time.
5. Add API so userspace is able to configure connection parameters.
6. Remove LE connection management code from bluetoothd.

Feedback is welcome.

Regards,

Andre


Andre Guedes (8):
  Bluetooth: Setup LE scan with no timeout
  Bluetooth: Add LE scan type macros
  Bluetooth: LE connection state machine
  Bluetooth: Add hci_conn helpers
  Bluetooth: Change LE connection routine
  Bluetooth: Handle hci_conn timeout in BT_CONNECT
  Bluetooth: Count pending LE connection attempts
  Bluetooth: Initialize some hci_conn fields earlier

 include/net/bluetooth/hci_core.h |  25 +++++++++
 net/bluetooth/hci_conn.c         | 111 ++++++++++++++++++++++++++++++++++++---
 net/bluetooth/hci_core.c         |  19 ++++---
 net/bluetooth/hci_event.c        |  30 ++++++++++-
 net/bluetooth/mgmt.c             |   7 ++-
 5 files changed, 171 insertions(+), 21 deletions(-)

-- 
1.8.1.2

