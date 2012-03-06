Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v4 2/2] Add a2mp.h to library_sources
Date: Mon,  5 Mar 2012 16:34:31 -0800
Message-Id: <1330994071-443-3-git-send-email-pkrystad@codeaurora.org>
In-Reply-To: <1330994071-443-1-git-send-email-pkrystad@codeaurora.org>
References: <1330994071-443-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index b419d84..12cb0b7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -58,8 +58,8 @@ plugin_LTLIBRARIES =
 
 
 lib_headers = lib/bluetooth.h lib/hci.h lib/hci_lib.h lib/mgmt.h \
-		lib/sco.h lib/l2cap.h lib/sdp.h lib/sdp_lib.h lib/uuid.h \
-		lib/rfcomm.h lib/bnep.h lib/cmtp.h lib/hidp.h
+		lib/sco.h lib/l2cap.h lib/a2mp.h lib/sdp.h lib/sdp_lib.h \
+		lib/uuid.h lib/rfcomm.h lib/bnep.h lib/cmtp.h lib/hidp.h
 local_headers = $(foreach file,$(lib_headers), lib/bluetooth/$(notdir $(file)))
 
 BUILT_SOURCES = $(local_headers) src/builtin.h
-- 
1.7.4.1

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
