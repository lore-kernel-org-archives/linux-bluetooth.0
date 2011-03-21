Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: 
Date: Mon, 21 Mar 2011 14:19:56 +0100
Message-ID: <1300713606-23523-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Subject: [PATCH 00/10] Use kthread API instead of kernel_thread in bluetooth

Use kthread API in bnep, hidp and cmtp.

Why: kernel_thread is a low-level implementation detail.  Drivers should
  use the <linux/kthread.h> API instead which shields them from
  implementation details and provides a higherlevel interface that
  prevents bugs and code duplication

Rest of patches are just cleanup work in touched files.


Comments are welcome.

BR,
Szymon Janc
on behalf of ST-Ericsson

Szymon Janc (10):
  Bluetooth: Opencode macros in bnep/core.c
  Bluetooth: Fix checkpatch errors and some code style issues in bnep
  Bluetooth: Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
  Bluetooth: Use kthread API in bnep
  Bluetooth: Fix checkpatch errors, code style issues and typos in hidp
  Bluetooth: Use kthread API in hidp
  Bluetooth: Do not use assignments in IF conditions
  Bluetooth: Use #include <linux/uaccess.h> instead of <asm/uaccess.h>
  Bluetooth: Fix checkpatch error in cmtp.h
  Bluetooth: Use kthread API in cmtp

 net/bluetooth/bnep/bnep.h |  148 ++++++++++++++++++++++----------------------
 net/bluetooth/bnep/core.c |   71 +++++++++++----------
 net/bluetooth/bnep/sock.c |    2 +-
 net/bluetooth/cmtp/capi.c |    6 +-
 net/bluetooth/cmtp/cmtp.h |   11 +---
 net/bluetooth/cmtp/core.c |   25 +++++---
 net/bluetooth/cmtp/sock.c |    2 +-
 net/bluetooth/hidp/core.c |   86 +++++++++++++-------------
 net/bluetooth/hidp/hidp.h |    6 +-
 net/bluetooth/hidp/sock.c |    7 +-
 10 files changed, 182 insertions(+), 182 deletions(-)

