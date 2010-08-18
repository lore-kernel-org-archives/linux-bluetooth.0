Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 1/5] Add STANDARD and INTERLACED page scan definitions
Date: Wed, 18 Aug 2010 13:35:56 +0300
Message-Id: <1282127760-12655-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1282127760-12655-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1282127760-12655-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added standard and interlaced page scan type definitions. Used for
both read and write page scan type HCI commands.
---
 lib/hci.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index f31918d..0369ee2 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -992,6 +992,8 @@ typedef struct {
 #define OCF_READ_PAGE_SCAN_TYPE		0x0046
 
 #define OCF_WRITE_PAGE_SCAN_TYPE	0x0047
+	#define PAGE_SCAN_TYPE_STANDARD		0x00
+	#define PAGE_SCAN_TYPE_INTERLACED	0x01
 
 #define OCF_READ_AFH_MODE		0x0048
 typedef struct {
-- 
1.7.0.4

