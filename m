Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 58/60] Return a proper UNIX error instead of -1 in mcap_mdl_get_fd
Date: Thu, 22 Jul 2010 10:58:15 +0200
Message-Id: <1279789097-2420-10-git-send-email-sancane@gmail.com>
In-Reply-To: <1279789097-2420-9-git-send-email-sancane@gmail.com>
References: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
 <1279789097-2420-1-git-send-email-sancane@gmail.com>
 <1279789097-2420-2-git-send-email-sancane@gmail.com>
 <1279789097-2420-3-git-send-email-sancane@gmail.com>
 <1279789097-2420-4-git-send-email-sancane@gmail.com>
 <1279789097-2420-5-git-send-email-sancane@gmail.com>
 <1279789097-2420-6-git-send-email-sancane@gmail.com>
 <1279789097-2420-7-git-send-email-sancane@gmail.com>
 <1279789097-2420-8-git-send-email-sancane@gmail.com>
 <1279789097-2420-9-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 30a8d56..b3017fb 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -29,6 +29,7 @@
 
 #include <netinet/in.h>
 #include <stdlib.h>
+#include <errno.h>
 
 #include "mcap.h"
 #include "mcap_lib.h"
@@ -640,7 +641,7 @@ static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
 int mcap_mdl_get_fd(struct mcap_mdl *mdl)
 {
 	if ((!mdl) || (mdl->state != MDL_CONNECTED))
-		return -1;
+		return -ENOTCONN;
 
 	return g_io_channel_unix_get_fd(mdl->dc);
 }
-- 
1.6.3.3

