Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org
Cc: sunnyk@codeaurora.org
Subject: [RFCv1 00/20] L2CAP signaling for AMP channel create/move
Date: Tue, 11 Sep 2012 11:21:11 -0700
Message-Id: <1347387691-5285-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here are the changes that process commands on the L2CAP signaling
channel for setting up AMP channels.  There's still a lot of
integration to do as other AMP functionality is implemented.  I've
marked places that require this integration with "Placeholder"
comments (look for that string).

This patch set has some minor conflicts with Andrei's "Create AMP
physical link" patch set, and will need to be rebased after that is
merged.

Changes:
  * RFCv1 - Finished commit messages, fixed formatting/style issues
  * RFCv0 - Initial post

Mat Martineau (20):
  Bluetooth: Add new l2cap_chan struct members for high speed channels
  Bluetooth: Factor out common L2CAP connection code
  Bluetooth: Add L2CAP create channel request handling
  Bluetooth: Process create response and connect response identically
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

 include/net/bluetooth/hci.h      |    1 +
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/l2cap.h    |   32 ++
 net/bluetooth/hci_conn.c         |    1 +
 net/bluetooth/l2cap_core.c       | 1019 ++++++++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c       |    5 +
 6 files changed, 1010 insertions(+), 49 deletions(-)

-- 
1.7.12

--
Mat Martineau

The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
