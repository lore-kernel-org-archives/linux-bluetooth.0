Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 10/10] shared: Fix missing destroy callback in timeout_add
Date: Mon, 17 Mar 2014 10:37:43 +0100
Message-ID: <1395049064-9751-11-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1395049064-9751-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1395049064-9751-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/timeout-mainloop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/timeout-mainloop.c b/src/shared/timeout-mainloop.c
index bdc527a..ba72fa9 100644
--- a/src/shared/timeout-mainloop.c
+++ b/src/shared/timeout-mainloop.c
@@ -59,6 +59,7 @@ int timeout_add(unsigned int t, timeout_func_t func, void *user_data,
 
 	data->func = func;
 	data->user_data = user_data;
+	data->destroy = destroy;
 	data->timeout = t;
 
 	data->id = mainloop_add_timeout(t, timeout_callback, data,
-- 
1.8.4

