Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 00/19] Bluetooth: Create AMP physical link
Date: Thu,  6 Sep 2012 15:19:38 +0300
Message-Id: <1346933997-14369-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1340981212-21709-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This set of patches enhances A2MP protocol and creates physical
link between AMP controllers. This is further iteration towards
Bluetooth High Speed.

Changes:
	* p3: Use hci_conn for representing physical link(type AMP_LINK) instead of
	struct phy_link, refactoring.
	* p2: Remove HCI callbacks and use amp_mgr global list, refactor code.
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

Andrei Emeltchenko (18):
  Bluetooth: Add HCI logical link cmds definitions
  Bluetooth: A2MP: Create amp_mgr global list
  Bluetooth: AMP: Use HCI cmd to Read AMP Info
  Bluetooth: AMP: Use HCI cmd to Read Loc AMP Assoc
  Bluetooth: A2MP: Process Discover Response
  Bluetooth: AMP: Physical link struct and heplers
  Bluetooth: AMP: Remote AMP ctrl definitions
  Bluetooth: AMP: Handle create / disc phylink req
  Bluetooth: A2MP: Process A2MP Getinfo Rsp
  Bluetooth: A2MP: Process A2MP Get AMP Assoc Rsp
  Bluetooth: Choose connection based on capabilities
  Bluetooth: AMP: Add AMP key calculation
  Bluetooth: AMP: Create Physical Link
  Bluetooth: AMP: Write remote AMP Assoc
  Bluetooth: A2MP: Add fallback to normal l2cap init sequence
  Bluetooth: AMP: Process Chan Selected event
  Bluetooth: AMP: Send Create Chan Req
  Bluetooth: AMP: Process physical link complete event

Dmitry Kasatkin (1):
  Bluetooth: Add function to derive AMP key using hmac

 include/net/bluetooth/a2mp.h     |   20 ++
 include/net/bluetooth/amp.h      |   29 +++
 include/net/bluetooth/hci.h      |   39 +++-
 include/net/bluetooth/hci_core.h |   35 ++++
 include/net/bluetooth/l2cap.h    |    2 +
 include/net/bluetooth/pal.h      |   40 ++++
 net/bluetooth/Kconfig            |    1 +
 net/bluetooth/Makefile           |    2 +-
 net/bluetooth/a2mp.c             |  414 +++++++++++++++++++++++++++++++++++---
 net/bluetooth/amp.c              |  159 +++++++++++++++
 net/bluetooth/hci_event.c        |  147 +++++++++++++-
 net/bluetooth/l2cap_core.c       |   57 +++++-
 net/bluetooth/pal.c              |  202 +++++++++++++++++++
 13 files changed, 1108 insertions(+), 39 deletions(-)
 create mode 100644 include/net/bluetooth/amp.h
 create mode 100644 include/net/bluetooth/pal.h
 create mode 100644 net/bluetooth/amp.c
 create mode 100644 net/bluetooth/pal.c

-- 
1.7.9.5

