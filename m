Return-Path: <eu@felipetonello.com>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: [PATCH v5 BlueZ 0/4] Connection Update improvements
Date: Thu, 13 Apr 2017 13:21:59 +0100
Message-Id: <20170413122203.4247-1-eu@felipetonello.com>
List-ID: <linux-bluetooth.vger.kernel.org>

These changes implements compliant Bluetooth support for any possible way to
update a connection parameter. Missing functionality is required to be
implemented in user-space, which this patchset allows it.

Changes from v4:
 * Handle Slave Connection Interval Range AD in kernel instead of
   user-space
 * Removed new MGMT command, it is unnecessary since it was only supposed
   to be used for the Slave Connection Interval Range support, which now
   has been implemented in the kernel.

Changes from v3:
 * Remove role check in refactored function
 * Added handler for Connection Parameter Update Response
 * Use Update Request when updating the connection parameters in slave
 * Fix MGMT command name to ADD instead of UPDATE

Changes from v2:
 * Added new MGMT command
 * Roll back to first socket option implementation, details are on the
   patch iself.

Changes from v1:
 * Use simpler user-space API
 * Added refactor function

Felipe F. Tonello (4):
  Bluetooth: L2CAP: Refactor L2CAP_CONN_PARAM_UPDATE_REQ into a function
  Bluetooth: L2CAP: Add handler for Connection Parameter Update Response
  Bluetooth: L2CAP: Add BT_LE_CONN_PARAM socket option
  Bluetooth: Handle Slave Connection Interval Range AD

 include/net/bluetooth/bluetooth.h |   8 +++
 include/net/bluetooth/l2cap.h     |   5 ++
 net/bluetooth/l2cap_core.c        |  78 +++++++++++++++++++++++----
 net/bluetooth/l2cap_sock.c        | 110 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c              |  53 ++++++++++++++++++
 5 files changed, 243 insertions(+), 11 deletions(-)

-- 
2.12.2
