Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 0/4] LE connection improvements
Date: Tue,  9 Aug 2011 19:52:36 -0300
Message-Id: <1312930360-30860-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Currently, in order to establish a LE connection, the user must actively scan
for LE devices (e.g. discovery or hcitool lescan command) before trying to
connect to any device.

This approach is fine in common discovery + connect scenario (the user lists
in-range devices and then choose one to connect to), but it isn't suitable for
LE GATT profiles. In this later scenario, we're not interested in performing
discovery because dual mode devices will waste 5.12 seconds performing inquiry
which results we're not interested at all.

To address this issue we've come up with some LE connection improvements which
we plan to take in two steps:
	1. Passive scan trigger
	2. Early stop scan

1. Passive scan trigger
During LE connection, the destination address (the address we want to connect
to) may not be in the advertising cache. Instead of returning error, we trigger
the LE passive scan.

The scan window and interval is 30 ms and 60 ms, respectively, and it runs for
3869 ms. These parameters were chosen based on some simulation results sent to
Bluetooth SIG mailing list (GATT Profile Architecture Working Group) in April
2011.

Once the passive scan is finished, we check if we have the advertising entry
from the destination device. If so, we create the connection, otherwise the
connection attempt fails.

2. Early stop scan
Once we find the LE advertising from the destination address, we don't need to
continue scanning LE devices. If that happens, we cancel the ongoing scanning
and create the connection.


After those improvements we'll have a sort of optimized version of the General
Connection Establishment Procedure describe in Bluetooth spec (volume 3,
session 9.3.6).

The optimization is done by always checking the advertising cache before
triggering the passive scan. The idea is: if we already have cached the
advertising report from the destination device we don't need to carry out the
passive scan. This way, we have faster LE connection establishment.

Those steps are a beginning effort to improve the LE connection establishment
procedure. This RFC series* implements the "Passive scan trigger" step.

Feedback are welcome.

Regards,

Andre Guedes.

[*] Patch 1/4 isn't originally part of this patch series, but it may be needed
to understand the following patches. We're waiting for discovery patches been
pushed upstream to send it to the ML.

Andre Guedes (4):
  Bluetooth: hci_cc_le_set_scan_enable() critical region
  Bluetooth: Add hci_do_le_scan() helper function
  Bluetooth: Extend hci_conn_check_pending()
  Bluetooth: LE passive scan trigger in hci_connect()

 include/net/bluetooth/hci_core.h |    4 ++-
 net/bluetooth/hci_conn.c         |   53 ++++++++++++++++++++++++++++++++-----
 net/bluetooth/hci_core.c         |   46 +++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |   35 +++++++++++++-----------
 4 files changed, 113 insertions(+), 25 deletions(-)

-- 
1.7.5.2

