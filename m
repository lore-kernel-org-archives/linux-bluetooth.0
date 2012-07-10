Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 3/5] Build: Fix make distcheck
Date: Tue, 10 Jul 2012 15:08:22 -0300
Message-Id: <1341943704-23633-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1341943704-23633-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1341943704-23633-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

plugins/hal.c should not be present in the distribution.
---
 Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index db8e7ae..f9caeb8 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -242,7 +242,7 @@ endif
 builtin_modules += formfactor
 builtin_sources += plugins/formfactor.c
 
-EXTRA_DIST += plugins/hal.c plugins/formfactor.c
+EXTRA_DIST += plugins/formfactor.c
 
 builtin_modules += storage
 builtin_sources += plugins/storage.c
-- 
1.7.10.4

