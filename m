Return-Path: <cyrus@holtmann.org>
From: Peter Krystad <pkrystad@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Peter Krystad <pkrystad@codeaurora.org>
Subject: [PATCH v5 2/5] Add a2mp.h to library_sources
Date: Mon,  5 Mar 2012 16:35:48 -0800
Message-Id: <1330994151-488-3-git-send-email-pkrystad@codeaurora.org>
In-Reply-To: <1330994151-488-1-git-send-email-pkrystad@codeaurora.org>
References: <1330994151-488-1-git-send-email-pkrystad@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index c0e362b..b0aaf79 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -2,7 +2,7 @@
 AM_MAKEFLAGS = --no-print-directory
 
 library_sources = lib/bluetooth.h lib/bluetooth.c \
-			lib/hci_lib.h lib/hci.h lib/hci.c lib/l2cap.h
+			lib/hci_lib.h lib/hci.h lib/hci.c lib/l2cap.h lib/a2mp.h
 
 parser_sources =  parser/parser.h parser/parser.c \
 					parser/lmp.c \
-- 
1.7.4.1

--
Peter Krystad
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
