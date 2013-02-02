Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 0/7] LE connection routine
Date: Fri,  1 Feb 2013 21:44:31 -0300
Message-Id: <1359765878-31409-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

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

Best regards,

Andre


Andre Guedes (7):
  Bluetooth: Add new connection states
  Bluetooth: Make hci_le_create_connection non-static
  Bluetooth: Setup LE scan with no timeout
  Bluetooth: Add LE scan type macros
  Bluetooth: Change LE connection routine
  Bluetooth: Handle hci_conn timeout in BT_SCAN state
  Bluetooth: Track the number of hci_conn in BT_SCAN

 include/net/bluetooth/bluetooth.h |  8 +++++++-
 include/net/bluetooth/hci_core.h  |  9 +++++++++
 net/bluetooth/hci_conn.c          | 16 ++++++++++++++--
 net/bluetooth/hci_core.c          | 19 +++++++++++--------
 net/bluetooth/hci_event.c         | 40 +++++++++++++++++++++++++++++++++++++--
 net/bluetooth/mgmt.c              |  5 ++---
 6 files changed, 81 insertions(+), 16 deletions(-)

-- 
1.8.1.1

