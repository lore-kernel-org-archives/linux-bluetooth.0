Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org, gustavo@padovan.org,
	Andrei.Emeltchenko.news@gmail.com
Cc: pkrystad@codeaurora.org
Subject: [RFCv0 00/21] L2CAP signaling for AMP channel create/move
Date: Wed, 25 Jul 2012 16:50:52 -0700
Message-Id: <1343260274-11953-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here are the changes that process commands on the L2CAP signaling
channel for setting up AMP channels.  There's still a lot of
integration to do as other AMP functionality is implemented.  I've
marked places that require this integration with "Placeholder"
comments (look for that string).

Many of the commit messages are still too short, I will expand on
those before changing this series from RFC to PATCH.  I didn't want to
delay Andrei's AMP work any further while I worked on commit messages.

Mat Martineau (21):
  Bluetooth: Add new l2cap_chan struct members for high speed channels
  Bluetooth: Factor out common L2CAP connection code
  Bluetooth: Add L2CAP create channel request handling.
  Bluetooth: Process create response and connect response identically
  Bluetooth: Lookup channel id for channel move
  Bluetooth: Channel move request handling
  Bluetooth: Add new ERTM receive states for channel move
  Bluetooth: Add move channel confirm handling
  Bluetooth: Move channel response
  Bluetooth: Add logical link confirm
  Bluetooth: Add move confirm response handling
  Bluetooth: Add state to hci_chan
  Bluetooth: Indentation fixes
  Bluetooth: Handle physical link completion
  Bluetooth: Enable data sends on AMP controller
  Bluetooth: Do not send data during channel move
  Bluetooth: Configure appropriate timeouts for AMP controllers
  Bluetooth: Ignore BR/EDR packet size constraints when fragmenting for
    AMP
  Bluetooth: Tie AMP link setup to connect/disconnect
  Bluetooth: Do not process ERTM reject during move
  Bluetooth: Start channel move when socket option is changed

 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |   7 +-
 include/net/bluetooth/l2cap.h    |  34 ++
 net/bluetooth/hci_conn.c         |   1 +
 net/bluetooth/l2cap_core.c       | 999 +++++++++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c       |   5 +
 6 files changed, 995 insertions(+), 52 deletions(-)

-- 
1.7.11.2

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
