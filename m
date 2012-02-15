Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v4 0/5] Add parsing of BT 3.0+HS signals
Date: Wed, 15 Feb 2012 11:04:10 -0800
Message-Id: <1329332655-27394-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v4 - Content unchanged but A2MP definitions added to own file

Sending again after reading the send-email prompts more carefully...

Peter Krystad (5):
  Add L2CAP Create/Move Channel definitions
  Add A2MP definitions
  Add parsing of L2CAP Create/Move Channel signals
  Add parsing of A2MP signals
  Minor indentation cleanup and fix display of physical link key

 Makefile.am     |    2 +-
 lib/a2mp.h      |  115 ++++++++++++++
 lib/l2cap.h     |   45 ++++++
 parser/hci.c    |   15 ++-
 parser/l2cap.c  |  450 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 parser/parser.h |    1 +
 src/hcidump.c   |    1 +
 7 files changed, 623 insertions(+), 6 deletions(-)

-- 
1.7.4.1

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

