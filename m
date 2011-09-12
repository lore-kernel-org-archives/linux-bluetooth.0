Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 3/3] Return EALREADY if the adapter is already up/down
Date: Mon, 12 Sep 2011 09:06:32 -0300
Message-Id: <1315829192-30924-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1315829192-30924-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1315829192-30924-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7a5f7b3..7d0c63e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3405,7 +3405,7 @@ int btd_adapter_switch_online(struct btd_adapter *adapter)
 		return -EINVAL;
 
 	if (adapter->up)
-		return 0;
+		return -EALREADY;
 
 	if (adapter->off_timer)
 		off_timer_remove(adapter);
@@ -3419,7 +3419,7 @@ int btd_adapter_switch_offline(struct btd_adapter *adapter)
 		return -EINVAL;
 
 	if (!adapter->up)
-		return 0;
+		return -EALREADY;
 
 	if (adapter->off_timer)
 		return 0;
-- 
1.7.6

