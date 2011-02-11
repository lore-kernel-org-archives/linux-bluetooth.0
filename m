Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi,
	Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC 0/3] LE Connection Parameter Update Procedure
Date: Fri, 11 Feb 2011 19:28:53 -0200
Message-Id: <1297459736-24514-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The following patches implement the support for LE Connection Parameter
Update procedure started by the LE slave/peripheral device. Procedure
started by the master will be addressed later when the requirements
become more clear, Bluetooth Core SPEC and GAP test specification are
not matching.

Patches are rebased using Vinicius SMP patches, repo:
git://git.infradead.org/users/vcgomes/linux-2.6.git for-next

LE signaling channel can receive the following L2CAP commands(only):
  - Command Reject
  - Connection Parameter Update request
  - Connection Parameter Update response

Claudio Takahasi (3):
  Bluetooth: Add LE signaling commands handling
  Bluetooth: Add connection parameter update response
  Bluetooth: Send LE Connection Update Command

 include/net/bluetooth/hci.h      |   11 ++
 include/net/bluetooth/hci_core.h |    2 +
 include/net/bluetooth/l2cap.h    |   17 +++
 net/bluetooth/hci_conn.c         |   20 ++++
 net/bluetooth/l2cap_core.c       |  213 ++++++++++++++++++++++++++++---------
 5 files changed, 211 insertions(+), 52 deletions(-)

-- 
1.7.4

