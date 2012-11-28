Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/2] adapter: Fix improper freeing with g_free in convert_config
Date: Wed, 28 Nov 2012 16:17:36 +0100
Message-ID: <1354115856-29301-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354115856-29301-1-git-send-email-szymon.janc@tieto.com>
References: <1354115856-29301-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Memory in textfile_get is allocated with malloc and it should be freed
with free not g_free.
---
 src/adapter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index d6f8a37..f134dfe 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2702,7 +2702,7 @@ static void convert_config(struct btd_adapter *adapter, const char *filename,
 			return;
 		}
 
-		g_free(converted);
+		free(converted);
 	}
 
 	if (read_local_name(&adapter->bdaddr, str) == 0)
-- 
1.7.9.5

