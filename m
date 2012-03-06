Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v4 0/2] Add BT 3.0+HS definitions
Date: Mon,  5 Mar 2012 16:34:29 -0800
Message-Id: <1330994071-443-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v4 - put Makefile.am change into separate commit

Peter Krystad (2):
  lib: Add A2MP definitions
  Add a2mp.h to library_sources

 Makefile.am |    4 +-
 lib/a2mp.h  |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 2 deletions(-)

-- 
1.7.4.1

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
