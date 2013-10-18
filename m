Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ] core: Remove leftover adapter_get_default()
Date: Fri, 18 Oct 2013 09:32:30 -0300
Message-Id: <1382099552-5562-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/adapter.h b/src/adapter.h
index 5d124e7..80c5f77 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -82,7 +82,6 @@ void adapter_shutdown(void);
 
 struct btd_adapter *adapter_find(const bdaddr_t *sba);
 struct btd_adapter *adapter_find_by_id(int id);
-struct btd_adapter *adapter_get_default(void);
 void adapter_foreach(adapter_cb func, gpointer user_data);
 
 bool btd_adapter_get_pairable(struct btd_adapter *adapter);
-- 
1.8.3.1

