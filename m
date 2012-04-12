Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 12/19] adapter: Remove headers declared but not defined
Date: Thu, 12 Apr 2012 20:33:03 +0530
Message-id: <1334243001-17016-13-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/adapter.h b/src/adapter.h
index c47d180..f7fb9fa 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -113,8 +113,6 @@ void adapter_set_discovering(struct btd_adapter *adapter,
 uint16_t adapter_get_dev_id(struct btd_adapter *adapter);
 const gchar *adapter_get_path(struct btd_adapter *adapter);
 void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr);
-void adapter_set_state(struct btd_adapter *adapter, int state);
-int adapter_get_state(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 							bdaddr_t *bdaddr);
 void adapter_update_found_devices(struct btd_adapter *adapter,
-- 
1.7.4.1

