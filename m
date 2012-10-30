Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 00/12] Handling physical and logical link
Date: Tue, 30 Oct 2012 17:52:52 +0200
Message-Id: <1351612384-12392-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1350493622.26318.114.camel@aeonflux>
References: <1350493622.26318.114.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Set of patches adding handling for physical and logical link
complete events.

Changes:
	* rfcv2: Added several new patches, fixing style issues.
	* rfcv1: Rebased on top of Mat's patches, preserve Marcel's ack for
	not-changed-much patches only.
	* rfcv0: original 

Andrei Emeltchenko (12):
  Bluetooth: trivial: Fix braces style and remove empty line
  Bluetooth: Save hs_hchan instead of hs_hcon in loglink complete
  Bluetooth: Return correct L2CAP response type
  Bluetooth: Derive remote and local amp id from chan struct
  Bluetooth: AMP: Add Logical Link Create function
  Bluetooth: AMP: Process Disc Logical Link
  Bluetooth: AMP: Process Disc Physical Link Complete evt
  Bluetooth: AMP: Remove hci_conn receiving error command status
  Bluetooth: Disconnect logical link when deleteing chan
  Bluetooth: AMP: Check for hs_hcon instead of ctrl_id
  Bluetooth: AMP: Use l2cap_physical_cfm in phylink complete evt
  Bluetooth: Process Create Chan Request

 include/net/bluetooth/amp.h   |    4 ++
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/amp.c           |   94 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c     |   95 +++++++++++++++++++++++++++++++++--------
 net/bluetooth/l2cap_core.c    |   82 ++++++++++++++++++++++++++---------
 5 files changed, 238 insertions(+), 38 deletions(-)

-- 
1.7.9.5

