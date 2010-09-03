Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH] Fix clean-local target
Date: Fri, 3 Sep 2010 13:33:33 +0200
Message-ID: <1283513613-6860-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The fix avoids failure of the second consequent call of 'make clean'.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 Makefile.am |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 5684e99..2fa03e1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -385,5 +385,5 @@ lib/bluetooth/%.h: lib/%.h
 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
-clean-local: lib/bluetooth
-	@$(RM) -r $<
+clean-local:
+	$(RM) -r lib/bluetooth
\ No newline at end of file
-- 
1.7.0.4

