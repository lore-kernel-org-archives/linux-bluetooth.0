Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 2/5] build: Fix typo
Date: Tue, 10 Jul 2012 15:08:21 -0300
Message-Id: <1341943704-23633-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1341943704-23633-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1341943704-23633-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"ptofiles" should have been "profiles"
---
 Makefile.am |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index d65b28c..db8e7ae 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -128,7 +128,7 @@ mcap_sources =
 
 if MCAP
 mcap_sources += profiles/health/mcap_lib.h profiles/health/mcap_internal.h \
-		ptofiles/health/mcap.h profiles/health/mcap.c \
+		profiles/health/mcap.h profiles/health/mcap.c \
 		profiles/health/mcap_sync.c
 endif
 
-- 
1.7.10.4

