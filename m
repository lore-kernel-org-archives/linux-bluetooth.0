Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v6 17/17] sbc: bump version number
Date: Wed,  6 Mar 2013 11:19:23 +0100
Message-Id: <1362565163-3567-18-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1362565163-3567-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1362565163-3567-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 configure.ac |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 30496ad..c052616 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1,5 +1,5 @@
 AC_PREREQ(2.60)
-AC_INIT(sbc, 1.0)
+AC_INIT(sbc, 1.1)
 
 AM_INIT_AUTOMAKE([foreign subdir-objects color-tests])
 AC_CONFIG_HEADERS(config.h)
-- 
1.7.9.5

