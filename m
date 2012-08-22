Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd v1 4/4] core: Remove redundant include errno.h
Date: Wed, 22 Aug 2012 22:05:54 +0530
Message-id: <1345653354-23720-4-git-send-email-s.syam@samsung.com>
In-reply-to: <1345653354-23720-1-git-send-email-s.syam@samsung.com>
References: <1345653354-23720-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
v1 => Corrected commit message typo

 src/server.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/server.c b/src/server.c
index 52f7f1e..16be849 100644
--- a/src/server.c
+++ b/src/server.c
@@ -31,7 +31,6 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <fcntl.h>
-#include <errno.h>
 #include <string.h>
 #include <inttypes.h>
 
-- 
1.7.4.1

