Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: pkrystad@quicinc.com, Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCHv4 0/1] Add BT 3.0+HS definitions
Date: Mon, 12 Dec 2011 21:57:15 -0800
Message-Id: <1323755836-15357-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset adds BT 3.0+HS signalling definitions

v4 - same content but A2MP definitions placed in l2cap.h

Peter Krystad (1):
  Add L2CAP Create/Move Channel and A2MP definitions

 lib/bluetooth.h |    5 ++
 lib/l2cap.h     |  158 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+), 0 deletions(-)

-- 
1.7.4.1

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
