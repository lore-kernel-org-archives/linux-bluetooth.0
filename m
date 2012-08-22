Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/4] core: Remove redundant incude errno.h
Date: Wed, 22 Aug 2012 21:40:58 +0530
Message-id: <1345651858-23031-4-git-send-email-s.syam@samsung.com>
In-reply-to: <1345651858-23031-1-git-send-email-s.syam@samsung.com>
References: <1345651858-23031-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
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

