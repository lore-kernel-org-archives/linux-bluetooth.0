Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] btio: Remove blank line at EOF
Date: Thu,  9 Sep 2010 17:43:05 +0800
Message-Id: <1284025388-3831-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1284025388-3831-1-git-send-email-zhenhua.zhang@intel.com>
References: <1284025388-3831-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/btio.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/btio.c b/src/btio.c
index 93079ae..8b273ca 100644
--- a/src/btio.c
+++ b/src/btio.c
@@ -1297,4 +1297,3 @@ GQuark bt_io_error_quark(void)
 {
 	return g_quark_from_static_string("bt-io-error-quark");
 }
-
-- 
1.7.0.4

