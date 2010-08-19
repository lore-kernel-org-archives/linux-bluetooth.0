Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] btio: Remove blank line at EOF
Date: Thu, 19 Aug 2010 22:21:09 +0800
Message-Id: <1282227676-15381-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
References: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/btio.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/btio.c b/src/btio.c
index 485eec6..42a3bcd 100644
--- a/src/btio.c
+++ b/src/btio.c
@@ -1297,4 +1297,3 @@ GQuark bt_io_error_quark(void)
 {
 	return g_quark_from_static_string("bt-io-error-quark");
 }
-
-- 
1.7.0.4

