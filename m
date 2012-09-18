Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: mathewm@codeaurora.org,
	gustavo@padovan.org,
	marcel@holtmann.org
Subject: [PATCHv6 00/17] Bluetooth: Create AMP physical link
Date: Tue, 18 Sep 2012 17:28:12 +0300
Message-Id: <1347978509-12133-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1347437192-24694-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This set of patches enhances A2MP protocol and creates physical
link between AMP controllers. This is further iteration towards
Bluetooth High Speed.

Changes:
	* p6: Refactoring: moving code from pal.[ch] to amp.[ch]
	* p5: Fix issues reported by Mat in mailing list review
	* p4: Rebased against recent bluetooth-next, minor fixes
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

Andrei Emeltchenko (16):
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

Dmitry Kasatkin (1):
  Bluetooth: Add function to derive AMP key using hmac

 include/net/bluetooth/a2mp.h     |   22 ++
 include/net/bluetooth/amp.h      |   47 +++++
 include/net/bluetooth/hci.h      |   39 +++-
 include/net/bluetooth/hci_core.h |   11 +
 include/net/bluetooth/l2cap.h    |    4 +
 net/bluetooth/Kconfig            |    1 +
 net/bluetooth/Makefile           |    2 +-
 net/bluetooth/a2mp.c             |  423 +++++++++++++++++++++++++++++++++++---
 net/bluetooth/amp.c              |  348 +++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        |  106 +++++++++-
 net/bluetooth/l2cap_core.c       |   35 +++-
 11 files changed, 1000 insertions(+), 38 deletions(-)
 create mode 100644 include/net/bluetooth/amp.h
 create mode 100644 net/bluetooth/amp.c

-- 
1.7.9.5
