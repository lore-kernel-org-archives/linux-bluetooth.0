Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	=?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH 3/4] Create one SBC Sink when registering A2DP server.
Date: Mon, 13 Jul 2009 12:28:52 -0300
Message-Id: <1247498933-30609-4-git-send-email-jprvita@gmail.com>
In-Reply-To: <1247498933-30609-3-git-send-email-jprvita@gmail.com>
References: <1247498933-30609-1-git-send-email-jprvita@gmail.com>
 <1247498933-30609-2-git-send-email-jprvita@gmail.com>
 <1247498933-30609-3-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/a2dp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 87b2077..7b5632d 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1076,7 +1076,7 @@ static struct a2dp_server *find_server(GSList *list, const bdaddr_t *src)
 
 int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
 {
-	int sbc_srcs = 1, sbc_sinks = 0;
+	int sbc_srcs = 1, sbc_sinks = 1;
 	int mpeg12_srcs = 0, mpeg12_sinks = 0;
 	gboolean source = TRUE, sink = TRUE;
 	char *str;
-- 
1.6.0.4

