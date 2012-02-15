Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v3 0/2] Add BT 3.0+HS definitions
Date: Tue, 14 Feb 2012 17:09:18 -0800
Message-Id: <1329268160-26330-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

v3 - Content unchanged but A2MP definitions added to own file

Peter Krystad (2):
  Add L2CAP Create/Move Channel definitions
  Add A2MP definitions

 Makefile.am |    4 +-
 lib/a2mp.h  |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/l2cap.h |   45 +++++++++++++++++++++++
 3 files changed, 162 insertions(+), 2 deletions(-)

-- 
1.7.4.1

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
