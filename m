Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org, marcel@holtmann.org
Subject: [PATCH 00/19] L2CAP signaling for AMP channel create/move
Date: Mon, 15 Oct 2012 08:33:49 -0700
Message-Id: <1350315248-7690-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here are the changes that process commands on the L2CAP signaling
channel for setting up AMP channels.  There's still a lot of
integration to do as other AMP functionality is implemented.  I've
marked places that require this integration with "Placeholder"
comments (look for that string).

Changes:
  * PATCHv1 - Rebased after AMP physical link patch set, incorporated
              mailing list feedback.
  * RFCv1 - Finished commit messages, fixed formatting/style issues
  * RFCv0 - Initial post

Mat Martineau (19):
  Bluetooth: Add new l2cap_chan struct members for high speed channels
  Bluetooth: Add L2CAP create channel request handling
  Bluetooth: Remove unnecessary intermediate function
  Bluetooth: Lookup channel structure based on DCID
  Bluetooth: Channel move request handling
  Bluetooth: Add new ERTM receive states for channel move
  Bluetooth: Add move channel confirm handling
  Bluetooth: Add state to hci_chan
  Bluetooth: Move channel response
  Bluetooth: Add logical link confirm
  Bluetooth: Add move confirm response handling
  Bluetooth: Handle physical link completion
  Bluetooth: Flag ACL frames as complete for AMP controllers
  Bluetooth: Do not send data during channel move
  Bluetooth: Configure appropriate timeouts for AMP controllers
  Bluetooth: Ignore BR/EDR packet size constraints when fragmenting for
    AMP
  Bluetooth: Send create channel request instead of connect for AMP
  Bluetooth: Do not retransmit data during a channel move
  Bluetooth: Start channel move when socket option is changed

 include/net/bluetooth/hci_core.h |   1 +
 include/net/bluetooth/l2cap.h    |  32 ++
 net/bluetooth/hci_conn.c         |   1 +
 net/bluetooth/l2cap_core.c       | 954 +++++++++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c       |   5 +
 5 files changed, 956 insertions(+), 37 deletions(-)

-- 
1.7.12.3

--
Mat Martineau

Employee of Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
