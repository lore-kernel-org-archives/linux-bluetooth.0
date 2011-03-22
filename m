Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v5 0/5] Support for OOB in mgmt interface
Date: Tue, 22 Mar 2011 13:12:18 +0100
Message-ID: <1300795943-6681-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes since v4:
- include comments from Anderson Lizardo
- use sizeof instead of hardcoded size in memcpy calls

BR,
Szymon Janc
on behalf of ST-Ericsson

Szymon Janc (5):
  Bluetooth: Rename cmd to param in pending_cmd
  Bluetooth: Allow for NULL data in mgmt_pending_add
  Bluetooth: Add read_local_oob_data management command
  Bluetooth: Add add/remove_remote_oob_data management commands
  Bluetooth: Enable support for out of band association model

 include/net/bluetooth/hci.h      |   24 +++++
 include/net/bluetooth/hci_core.h |   18 ++++
 include/net/bluetooth/mgmt.h     |   18 ++++
 net/bluetooth/hci_core.c         |   67 +++++++++++++++
 net/bluetooth/hci_event.c        |   57 ++++++++++++-
 net/bluetooth/mgmt.c             |  173 ++++++++++++++++++++++++++++++++++++--
 6 files changed, 349 insertions(+), 8 deletions(-)

