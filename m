Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/4] plugins: Remove redundant incude sys/stat.h
Date: Wed, 22 Aug 2012 21:40:57 +0530
Message-id: <1345651858-23031-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1345651858-23031-1-git-send-email-s.syam@samsung.com>
References: <1345651858-23031-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/filesystem.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/filesystem.c b/plugins/filesystem.c
index e664fc5..1132a34 100644
--- a/plugins/filesystem.c
+++ b/plugins/filesystem.c
@@ -32,7 +32,6 @@
 #include <string.h>
 #include <unistd.h>
 #include <dirent.h>
-#include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/statvfs.h>
-- 
1.7.4.1

