Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCHv3 0/4] Add BT 3.0+HS parsing
Date: Mon, 12 Dec 2011 22:02:33 -0800
Message-Id: <1323756157-15487-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds parsing and display of BT 3.0+HS signalling

v3 - same content but A2MP definitions placed in l2cap.h

Peter Krystad (4):
  Add L2CAP Create/Move channel and A2MP definitions
  Add parsing of L2CAP Create/Move Channel signals
  Add parsing of A2MP signals
  Minor cleanup of indentation in output

 lib/l2cap.h     |  159 +++++++++++++++++++-
 parser/hci.c    |   15 ++-
 parser/l2cap.c  |  449 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 parser/parser.h |    1 +
 src/hcidump.c   |    1 +
 5 files changed, 619 insertions(+), 6 deletions(-)

-- 
1.7.4.1
--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

