Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 0/4] Support for OOB in mgmt interface
Date: Tue, 1 Mar 2011 18:23:32 +0100
Message-ID: <1299000216-6570-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Patches rebased to match changes after moving index to mgmt_hdr.
Dropped patches already applied.

BR,
Szymon Janc
on behalf of ST-Ericsson

Szymon Janc (4):
  Bluetooth: Rename cmd to cmd_params in pending_cmd
  Bluetooth: Allow for NULL data in mgmt_pending_add
  Bluetooth: Add read_local_oob_data management command
  Bluetooth: Add add/remove_remote_oob_data management commands

 include/net/bluetooth/hci.h      |   26 ++++++
 include/net/bluetooth/hci_core.h |   18 ++++
 include/net/bluetooth/mgmt.h     |   18 ++++
 net/bluetooth/hci_core.c         |   76 ++++++++++++++++
 net/bluetooth/hci_event.c        |   56 ++++++++++++-
 net/bluetooth/mgmt.c             |  175 ++++++++++++++++++++++++++++++++++++--
 6 files changed, 361 insertions(+), 8 deletions(-)

