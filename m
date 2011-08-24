Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 3/4] Remove leftover function declaration
Date: Wed, 24 Aug 2011 16:09:49 -0300
Message-Id: <1314212990-13090-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1314212990-13090-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1314212990-13090-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/src/adapter.h b/src/adapter.h
index f1f546c..c33234f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -107,7 +107,6 @@ const gchar *adapter_get_path(struct btd_adapter *adapter);
 void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_set_state(struct btd_adapter *adapter, int state);
 int adapter_get_state(struct btd_adapter *adapter);
-int adapter_get_discover_type(struct btd_adapter *adapter);
 struct remote_dev_info *adapter_search_found_devices(struct btd_adapter *adapter,
 						struct remote_dev_info *match);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-- 
1.7.6

