Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v5 10/10] shared: Fix missing destroy callback in timeout_add
Date: Thu, 20 Mar 2014 12:25:13 +0100
Message-ID: <1395314713-13104-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395314713-13104-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395314713-13104-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/timeout-mainloop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/timeout-mainloop.c b/src/shared/timeout-mainloop.c
index 37bb51c..77aaa63 100644
--- a/src/shared/timeout-mainloop.c
+++ b/src/shared/timeout-mainloop.c
@@ -65,6 +65,7 @@ unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
 	data->func = func;
 	data->user_data = user_data;
 	data->timeout = timeout;
+	data->destroy = destroy;
 
 	data->id = mainloop_add_timeout(timeout, timeout_callback, data,
 							timeout_destroy);
-- 
1.8.4

