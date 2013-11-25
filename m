Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/4] android: Add CAP_NET_RAW capability
Date: Mon, 25 Nov 2013 15:49:26 +0200
Message-Id: <1385387369-3015-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385387369-3015-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385387369-3015-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CAP_NET_RAW capability is required to up the bnep interfaces
in android environment.
---
 android/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/main.c b/android/main.c
index c9733f3..bfd2a87 100644
--- a/android/main.c
+++ b/android/main.c
@@ -506,6 +506,7 @@ static bool set_capabilities(void)
 	header.pid = 0;
 
 	cap.effective = cap.permitted =
+		CAP_TO_MASK(CAP_NET_RAW) |
 		CAP_TO_MASK(CAP_NET_ADMIN) |
 		CAP_TO_MASK(CAP_NET_BIND_SERVICE);
 	cap.inheritable = 0;
-- 
1.8.3.2

