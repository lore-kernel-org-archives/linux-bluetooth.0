Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 00/26] Bluetooth: Create AMP physical link
Date: Fri, 17 Aug 2012 17:32:55 +0300
Message-Id: <1345214001-7053-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This set of patches enhances A2MP protocol and creates physical
link between AMP controllers. This is further iteration towards
Bluetooth High Speed.

Changes:
	* p1: Fixed locking issues, added basic logical link preparation.
	* v3: Remove workqueue from callback processing; change callback functions
	names according to reviewers recommendations; create global amp_mgr_list to
	have lookup to amp manager, physical and logical links so for those HCI events
	which might be identified by __handler__ we have lookup; remove extensive
	hexdump from gen_amp_key.
	* v2: Fix typos and bugs, add functionality: now physical connection
	might be established.
	* v1: Fix typos, change debug prints, refactor code for better
	splitting functionality.

Andrei Emeltchenko (25):
  Bluetooth: debug: Print refcnt for hci_dev
  Bluetooth: trivial: Remove empty line
  Bluetooth: Add HCI logical link cmds definitions
  Bluetooth: General HCI callback implementation
  Bluetooth: Add callback clear to ops->teardown
  Bluetooth: AMP: Use HCI callback for Read AMP Info
  Bluetooth: AMP: Use HCI callback to Read Loc AMP Assoc
  Bluetooth: A2MP: Process Discover Response
  Bluetooth: AMP: Physical link struct definitions
  Bluetooth: AMP: Remote AMP ctrl definitions
  Bluetooth: AMP: Use phylink in create/disc phylink req
  Bluetooth: A2MP: Process A2MP Getinfo Rsp
  Bluetooth: A2MP: Process A2MP Get AMP Assoc Rsp
  Bluetooth: A2MP: Create A2MP workqueue
  Bluetooth: Choose connection based on capabilities
  Bluetooth: AMP: Add AMP key calculation
  Bluetooth: AMP: Create Physical Link
  Bluetooth: AMP: Write remote AMP Assoc
  Bluetooth: A2MP: Add fallback to normal l2cap init sequence
  Bluetooth: A2MP: Create amp_mgr global list
  Bluetooth: AMP: Process Chan Selected event
  Bluetooth: AMP: Process physical link complete event
  Bluetooth: AMP: Send Create Chan Req
  Bluetooth: Set Exended Flowspec flag for HS chan
  Bluetooth: Add logical link create function

Dmitry Kasatkin (1):
  Bluetooth: Add function to derive AMP key using hmac

 include/net/bluetooth/a2mp.h     |   16 ++
 include/net/bluetooth/amp.h      |   28 +++
 include/net/bluetooth/hci.h      |   39 ++++-
 include/net/bluetooth/hci_core.h |   48 ++++++
 include/net/bluetooth/l2cap.h    |    3 +
 include/net/bluetooth/pal.h      |   58 +++++++
 net/bluetooth/Kconfig            |    1 +
 net/bluetooth/Makefile           |    2 +-
 net/bluetooth/a2mp.c             |  346 +++++++++++++++++++++++++++++++++++---
 net/bluetooth/amp.c              |  339 +++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_core.c         |  106 +++++++++++-
 net/bluetooth/hci_event.c        |  166 +++++++++++++++++-
 net/bluetooth/l2cap_core.c       |   75 ++++++++-
 net/bluetooth/pal.c              |  330 ++++++++++++++++++++++++++++++++++++
 14 files changed, 1526 insertions(+), 31 deletions(-)
 create mode 100644 include/net/bluetooth/amp.h
 create mode 100644 include/net/bluetooth/pal.h
 create mode 100644 net/bluetooth/amp.c
 create mode 100644 net/bluetooth/pal.c

-- 
1.7.9.5

