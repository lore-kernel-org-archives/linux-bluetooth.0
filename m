Return-Path: <cyrus@holtmann.org>
From: Mat Martineau <mathewm@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: padovan@profusion.mobi, Mat Martineau <mathewm@codeaurora.org>
Subject: [PATCH v3 0/3] ERTM local busy enhancement
Date: Thu,  7 Jul 2011 09:39:00 -0700
Message-Id: <1310056743-2643-1-git-send-email-mathewm@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These patches change receiver-side handling of flow control. This new
approach will not keep very much incoming data beyond what fits in the
socket receive buffer, so memory use is more tightly controlled. When
incoming data does not immediately fit in the socket buffer, the L2CAP
socket layer will now only check for available space when the socket
is read from instead of polling on a workqueue thread.


Mat Martineau (3):
  Bluetooth: Move code for ERTM local busy state to separate functions
  Bluetooth: Use event-driven approach for handling ERTM receive buffer
  Bluetooth: Remove L2CAP busy queue

 include/net/bluetooth/l2cap.h |    6 +-
 net/bluetooth/l2cap_core.c    |  174 +++++++++++------------------------------
 net/bluetooth/l2cap_sock.c    |   65 ++++++++++++++-
 3 files changed, 108 insertions(+), 137 deletions(-)

-- 
1.7.6

--
Mat Martineau
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

