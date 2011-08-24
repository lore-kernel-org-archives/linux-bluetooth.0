Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 4/4] Remove not referenced function
Date: Wed, 24 Aug 2011 16:09:50 -0300
Message-Id: <1314212990-13090-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1314212990-13090-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1314212990-13090-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    5 -----
 src/adapter.h |    1 -
 2 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b37441a..d3ba7a8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3355,11 +3355,6 @@ void btd_adapter_any_release_path(void)
 	adapter_any_path = NULL;
 }
 
-gboolean adapter_is_pairable(struct btd_adapter *adapter)
-{
-	return adapter->pairable;
-}
-
 gboolean adapter_powering_down(struct btd_adapter *adapter)
 {
 	return adapter->off_requested;
diff --git a/src/adapter.h b/src/adapter.h
index c33234f..1baa547 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -157,7 +157,6 @@ const char *adapter_any_get_path(void);
 
 const char *btd_adapter_any_request_path(void);
 void btd_adapter_any_release_path(void);
-gboolean adapter_is_pairable(struct btd_adapter *adapter);
 gboolean adapter_powering_down(struct btd_adapter *adapter);
 
 int btd_adapter_restore_powered(struct btd_adapter *adapter);
-- 
1.7.6

