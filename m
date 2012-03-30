Return-Path: <cyrus@holtmann.org>
From: Hemant Gupta <hemant.gupta@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: Naresh Gupta <naresh.gupta@stericsson.com>,
	Hemant Gupta <hemantgupta.ste@gmail.com>,
	Hemant Gupta <hemant.gupta@stericsson.com>
Subject: [PATCH] Adapter: Fix Discovering state while Powering Off
Date: Fri, 30 Mar 2012 19:44:52 +0530
Message-ID: <1333116892-31344-1-git-send-email-hemant.gupta@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the adater discovering state while powering off.
Without this fix, BlueZ sends incorrect discovering state to upper
layers while switching off.
---
 src/adapter.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f8f46f8..76fbe31 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -289,6 +289,12 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
 			return err;
 
 		adapter->off_requested = TRUE;
+                /*
+                 * Change the discovering state to FALSE, otherwise
+                 * inquiry fails to start if BT is switched off and then on
+                 * while inquiry is already active.
+                 */
+                adapter->discovering = FALSE;
 
 		goto done;
 	}
-- 
1.7.0.4

