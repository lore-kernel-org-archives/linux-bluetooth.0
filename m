Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 5/7] proximity: Remove unnecessary check for GATT enabled
Date: Fri, 31 Aug 2012 14:48:31 +0200
Message-ID: <1346417314-25109-6-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1346417314-25109-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Proximity plugin won't be loaded if GATT is disabled so there's no point in
checking this once more when adapter is probed.
---
 profiles/proximity/reporter.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index c221fae..9b430f7 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -249,11 +249,6 @@ int reporter_adapter_probe(struct btd_adapter *adapter)
 {
 	struct reporter_adapter *radapter;
 
-	if (!main_opts.gatt_enabled) {
-		DBG("GATT is disabled");
-		return -ENOTSUP;
-	}
-
 	radapter = g_new0(struct reporter_adapter, 1);
 	radapter->adapter = adapter;
 
-- 
1.7.11.3

