Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 7/7] android: Add reasons for adding capabilites to process
Date: Thu, 28 Nov 2013 16:45:55 +0200
Message-Id: <1385649955-29276-8-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385649955-29276-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385649955-29276-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CAP_NET_ADMIN: Allow use of MGMT interface
CAP_NET_BIND_SERVICE: Allow use of privileged PSM
CAP_NET_RAW: Allow use of bnep ioctl calls
---
 android/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/main.c b/android/main.c
index bfd2a87..803d7a8 100644
--- a/android/main.c
+++ b/android/main.c
@@ -505,6 +505,9 @@ static bool set_capabilities(void)
 	header.version = _LINUX_CAPABILITY_VERSION;
 	header.pid = 0;
 
+	/* CAP_NET_ADMIN: Allow use of MGMT interface
+	 * CAP_NET_BIND_SERVICE: Allow use of privileged PSM
+	 * CAP_NET_RAW: Allow use of bnep ioctl calls */
 	cap.effective = cap.permitted =
 		CAP_TO_MASK(CAP_NET_RAW) |
 		CAP_TO_MASK(CAP_NET_ADMIN) |
-- 
1.8.3.2

