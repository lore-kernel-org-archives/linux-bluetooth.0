Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/8] adapter: Insert DeviceID record if setting DeviceID data to controller
Date: Thu, 19 Sep 2013 16:00:41 +0200
Message-ID: <1379599248-7923-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
References: <1379599248-7923-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

DeviceID is special since its record is registered on start by
sdpd-server and always has handle 0x10000.
---
 src/adapter.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 17f5508..62783a6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5621,9 +5621,13 @@ static int adapter_register(struct btd_adapter *adapter)
 
 	adapter->initialized = TRUE;
 
-	if (main_opts.did_source)
+	if (main_opts.did_source) {
+		/* DeviceID record is added by sdpd-server before any other
+		 * record is registered. */
+		adapter_service_insert(adapter, sdp_record_find(0x10000));
 		set_did(adapter, main_opts.did_vendor, main_opts.did_product,
 				main_opts.did_version, main_opts.did_source);
+	}
 
 	DBG("Adapter %s registered", adapter->path);
 
-- 
1.8.4

