Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd v1 3/4] plugins: Remove redundant include sys/stat.h
Date: Wed, 22 Aug 2012 22:05:53 +0530
Message-id: <1345653354-23720-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1345653354-23720-1-git-send-email-s.syam@samsung.com>
References: <1345653354-23720-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
v1 => Corrected commit message typo

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

