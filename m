Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Date: Tue, 30 Aug 2011 09:22:17 -0400
Subject: [PATCH 0/2] Fix unsafe hci conn add/del
Message-ID: <1314710537.2232.9.camel@THOR>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These two patches address several problems relating to concurrent
access of the connection list and avail tx buffer counts when
hci connections are added and deleted.

Firstly, both the tx & rx tasklets must be disabled while the
unacked pkts are added back to the avail tx buffers counts during
a connection deletion (because the updates are not performed
atomically here or elsewhere -- yet).

Since hci_conn_del is called in both rx_task context and process
context, disabling the rx_task must be performed conditionally
so as to avoid deadlock (if the local cpu is in rx_task tasklet
context and attempts to disable the rx_task, it will wait forever
for the tasklet it's running to end).

Note that the re-enable of the rx_task is performed after the
connection list is modified. This is because hci_num_comp_pkts_evt
does not acquire the device lock while accessing the connection list.
Rather than claim the device lock (which would render useless efforts to
perform tx buffer count arithmetic atomically), instead disable the
rx_task tasklet while the hci connection list is updated.

Peter Hurley (2):
  Bluetooth: Fix unsafe tx buffer count updates
  Bluetooth: Fix unsafe connection list access

 net/bluetooth/hci_conn.c |   16 +++++++++++++---
 net/bluetooth/hci_core.c |    4 ----
 2 files changed, 13 insertions(+), 7 deletions(-)

-- 
1.7.4.1

