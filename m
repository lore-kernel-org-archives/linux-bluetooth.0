Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] adapter: Minor whitespace fix in btd_adapter_set_class
Date: Mon, 19 Nov 2012 16:02:44 +0100
Message-ID: <1353337366-21590-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353337366-21590-1-git-send-email-szymon.janc@tieto.com>
References: <1353337366-21590-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Indent with tab not spaces.
---
 src/adapter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index 8b599da..5c17a6e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -181,7 +181,7 @@ static gboolean process_auth_queue(gpointer user_data);
 int btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 							uint8_t minor)
 {
-       return mgmt_set_dev_class(adapter->dev_id, major, minor);
+	return mgmt_set_dev_class(adapter->dev_id, major, minor);
 }
 
 static const char *mode2str(uint8_t mode)
-- 
1.7.9.5

