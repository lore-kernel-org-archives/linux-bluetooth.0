Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v2 bluez 0/2] Add BT 3.0+HS definitions
Date: Thu, 27 Oct 2011 17:28:37 -0700
Message-Id: <1319761719-16363-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset adds BT 3.0+HS signalling definitions

v2 - Use A2MP/a2mp nomenclature

Peter Krystad (2):
  Add L2CAP Create/Move Channel definitions
  Add A2MP definitions

 lib/a2mp.h  |  133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/l2cap.h |   44 +++++++++++++++++++
 2 files changed, 177 insertions(+), 0 deletions(-)
 create mode 100644 lib/a2mp.h

-- 
1.7.7

-- 
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
