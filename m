Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/6] client: remove unused field
Date: Fri, 20 Jan 2012 11:49:57 +0200
Message-Id: <1327053001-9506-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
References: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 client/session.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/client/session.c b/client/session.c
index 5dfbd47..7de1492 100644
--- a/client/session.c
+++ b/client/session.c
@@ -100,7 +100,6 @@ struct obc_session {
 	guint watch;
 	GSList *pending;
 	GSList *pending_calls;
-	void *priv;
 	char *adapter;
 };
 
-- 
1.7.7.5

