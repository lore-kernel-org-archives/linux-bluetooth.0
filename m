Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v5 0/5] Add parsing of BT 3.0+HS signals
Date: Mon,  5 Mar 2012 16:35:46 -0800
Message-Id: <1330994151-488-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v5 - put Makefile.am change into separate commit

Peter Krystad (5):
  lib: Add A2MP definitions
  Add a2mp.h to library_sources
  Add parsing of L2CAP Create/Move Channel signals
  Add parsing of A2MP signals
  Minor indentation cleanup and fix display of physical link key

 Makefile.am     |    2 +-
 lib/a2mp.h      |  115 ++++++++++++++
 parser/hci.c    |   15 ++-
 parser/l2cap.c  |  450 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 parser/parser.h |    1 +
 src/hcidump.c   |    1 +
 6 files changed, 578 insertions(+), 6 deletions(-)

-- 
1.7.4.1

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
