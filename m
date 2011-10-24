Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH bluez 0/2] Add BT 3.0+HS signalling definitions
Date: Mon, 24 Oct 2011 16:06:17 -0700
Message-Id: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset adds definitions for BT 3.0+HS signalling

Peter Krystad (2):
  Add L2CAP Create/Move Channel definitions
  Add A2MP definitions

 lib/a2mp.h  |  131 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/l2cap.h |   44 ++++++++++++++++++++
 2 files changed, 175 insertions(+), 0 deletions(-)
 create mode 100644 lib/a2mp.h

-- 
1.7.7

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
