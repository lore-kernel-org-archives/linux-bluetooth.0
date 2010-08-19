Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] btio: include bluetooth.h to use devid2ba
Date: Thu, 19 Aug 2010 22:21:15 +0800
Message-Id: <1282227676-15381-8-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
References: <1282227676-15381-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 btio/btio.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index eaf61c1..62efcb3 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -32,6 +32,7 @@
 
 #include <glib.h>
 
+#include "bluetooth.h"
 #include "btio.h"
 
 #define ERROR_FAILED(gerr, str, err) \
@@ -576,7 +577,7 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_SOURCE:
 			str = va_arg(args, const char *);
 			if (strncasecmp(str, "hci", 3) == 0)
-				hci_devba(atoi(str + 3), &opts->src);
+				devid2ba(atoi(str + 3), &opts->src);
 			else
 				str2ba(str, &opts->src);
 			break;
-- 
1.7.0.4

