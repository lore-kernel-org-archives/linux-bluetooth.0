Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] audio/a2dp: Fix server name typo
Date: Mon, 23 Feb 2015 09:59:44 +0200
Message-Id: <1424678384-25495-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1424678384-25495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424678384-25495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes typo in server name
---
 profiles/audio/a2dp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index ad21df3..6a86c19 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -1418,7 +1418,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	avdtp_server = find_avdtp_server(avdtp_servers, adapter);
 	if (!avdtp_server) {
 		avdtp_server = avdtp_server_init(adapter);
-		if (!server)
+		if (!avdtp_server)
 			return NULL;
 	}
 
-- 
2.1.0

