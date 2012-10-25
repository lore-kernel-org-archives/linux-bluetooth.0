Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv1 00/11] Handling physical and logical link
Date: Thu, 25 Oct 2012 15:20:41 +0300
Message-Id: <1351167652-12346-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350493622.26318.114.camel@aeonflux>
References: <1350493622.26318.114.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set of patches adding handling for physical and logical link
complete events.

Changes:
	* rfcv1: Rebased on top of Mat's patches, preserve Marcel's ack for
	not-changed-much patches only.
	* rfcv0: original 

Andrei Emeltchenko (11):
  Bluetooth: trivial: Remove unneeded assignment
  Bluetooth: Use helper function sending EFS conf rsp
  Bluetooth: AMP: Process Physical Link Complete evt
  Bluetooth: AMP: Process Logical Link complete evt
  Bluetooth: AMP: Add Logical Link Create function
  Bluetooth: AMP: Process Disc Logical Link
  Bluetooth: AMP: Process Disc Physical Link Complete evt
  Bluetooth: AMP: Remove hci_conn receiving error command status
  Bluetooth: Disconnect logical link when deleteing chan
  Bluetooth: Add put(hcon) when deleting hchan
  Bluetooth: AMP: Check for hs_hcon instead of ctrl_id

 include/net/bluetooth/amp.h   |    3 +
 include/net/bluetooth/l2cap.h |    2 +
 net/bluetooth/amp.c           |   70 ++++++++++++++++
 net/bluetooth/hci_conn.c      |    2 +
 net/bluetooth/hci_event.c     |  177 ++++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_core.c    |   41 ++++++----
 6 files changed, 276 insertions(+), 19 deletions(-)

-- 
1.7.9.5

