Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v3 bluez 0/2] Add BT 3.0+HS definitions
Date: Wed,  2 Nov 2011 17:36:44 -0700
Message-Id: <1320280606-32677-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patchset adds BT 3.0+HS signaling definitions

v3 - remove typedefs from lib/a2mp.h

Peter Krystad (2):
  Add L2CAP Create/Move Channel definitions
  Add A2MP definitions

 lib/a2mp.h  |  137 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/l2cap.h |   44 +++++++++++++++++++
 2 files changed, 181 insertions(+), 0 deletions(-)
 create mode 100644 lib/a2mp.h

-- 
1.7.7

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
