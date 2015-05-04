Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 1/4] plugins/policy: Fix clang compile error
Date: Mon,  4 May 2015 16:28:11 -0700
Message-Id: <1430782094-18396-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1430782094-18396-1-git-send-email-armansito@chromium.org>
References: <1430782094-18396-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes the following error when bluez is compiled with clang:

plugins/policy.c:780:6: error: cast from 'int *' to 'size_t *' (aka 'unsigned long *') increases required alignment from 4 to 8 [-Werror,-Wcast-align]
(size_t *) &reconnect_intervals_len,
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
---
 plugins/policy.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/policy.c b/plugins/policy.c
index 8098689..7687203 100644
--- a/plugins/policy.c
+++ b/plugins/policy.c
@@ -61,19 +61,19 @@ struct reconnect_data {
 	GSList *services;
 	guint timer;
 	bool active;
-	int attempt;
+	unsigned int attempt;
 };
 
 static const char *default_reconnect[] = {
 			HSP_AG_UUID, HFP_AG_UUID, A2DP_SOURCE_UUID, NULL };
 static char **reconnect_uuids = NULL;
 
-static const int default_attempts = 7;
-static int reconnect_attempts = 0;
+static const size_t default_attempts = 7;
+static size_t reconnect_attempts = 0;
 
 static const int default_intervals[] = { 1, 2, 4, 8, 16, 32, 64 };
 static int *reconnect_intervals = NULL;
-static int reconnect_intervals_len = 0;
+static size_t reconnect_intervals_len = 0;
 
 static GSList *reconnects = NULL;
 
-- 
2.2.0.rc0.207.ga3a616c

