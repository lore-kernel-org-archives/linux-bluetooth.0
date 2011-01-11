Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Fix memory leak when calling endpoint to select capabilities
Date: Tue, 11 Jan 2011 16:42:27 +0200
Message-Id: <1294756947-11714-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294756947-11714-1-git-send-email-luiz.dentz@gmail.com>
References: <1294756947-11714-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

When passing allocated memory to avdtp_service_cap_new it needs to be
freed since avdtp_service_cap_new copies the memory.
---
 audio/a2dp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index c5da708..c1d82bb 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1833,6 +1833,7 @@ static void select_cb(struct media_endpoint *endpoint, void *ret, int size,
 						sizeof(*cap) + size);
 
 	setup->caps = g_slist_append(setup->caps, media_codec);
+	g_free(cap);
 
 done:
 	finalize_select(setup);
-- 
1.7.1

