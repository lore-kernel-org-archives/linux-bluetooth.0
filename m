Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: andrei.emeltchenko@intel.com,
	Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH 0/4] Add parsing of BT 3.0+HS signalling
Date: Fri, 21 Oct 2011 16:29:58 -0700
Message-Id: <1319239802-22457-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset adds parsing and display of BT 3.0+HS signalling

Peter Krystad (4):
  Add parsing of L2CAP Create/Move Channel signals
  Add parsing of A2MP signals
  Add parsing of L2CAP Fixed Channel list
  Minor cleanup of indentation in output

 lib/amp.h       |  133 +++++++++++++++
 lib/l2cap.h     |   50 ++++++
 parser/hci.c    |   15 +-
 parser/l2cap.c  |  498 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 parser/parser.h |    1 +
 src/hcidump.c   |    1 +
 6 files changed, 693 insertions(+), 5 deletions(-)
 create mode 100644 lib/amp.h

-- 
1.7.7

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
