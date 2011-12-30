Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 4/4] gatt-example: Fix memory leak.
Date: Fri, 30 Dec 2011 12:45:09 +0100
Message-Id: <1325245509-14359-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1325245509-14359-3-git-send-email-sancane@gmail.com>
References: <1325245509-14359-1-git-send-email-sancane@gmail.com>
 <1325245509-14359-2-git-send-email-sancane@gmail.com>
 <1325245509-14359-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove the example-plugin data element from the list whenever an adapter
is removed.
---
 plugins/gatt-example.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/plugins/gatt-example.c b/plugins/gatt-example.c
index 5af07ea..701c1d7 100644
--- a/plugins/gatt-example.c
+++ b/plugins/gatt-example.c
@@ -541,6 +541,7 @@ static void gatt_example_adapter_remove(struct btd_adapter *adapter)
 		return;
 
 	gadapter = l->data;
+	adapters = g_slist_remove(adapters, gadapter);
 	gatt_example_adapter_free(gadapter);
 }
 
-- 
1.7.8.1

