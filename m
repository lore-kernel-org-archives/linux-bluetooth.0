Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v2 hcidump 0/5] Add BT 3.0+HS parsing
Date: Wed,  2 Nov 2011 17:56:52 -0700
Message-Id: <1320281817-359-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds parsing and display of BT 3.0+HS signaling

v2 - updates to match revised a2mp.h from bluez

Peter Krystad (5):
  Add L2CAP Create/Move channel definitions
  Add A2MP definitions
  Add parsing of L2CAP Create/Move Channel signals
  Add parsing of A2MP signals
  Minor cleanup of indentation in output

 lib/a2mp.h      |  137 +++++++++++++++
 lib/l2cap.h     |   44 +++++
 parser/hci.c    |   15 +-
 parser/l2cap.c  |  495 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 parser/parser.h |    1 +
 src/hcidump.c   |    1 +
 6 files changed, 688 insertions(+), 5 deletions(-)
 create mode 100644 lib/a2mp.h

-- 
1.7.7

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
