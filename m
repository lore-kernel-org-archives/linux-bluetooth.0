Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ v2 05/16] audio: Get rid of gint
Date: Wed,  1 May 2013 02:27:59 -0300
Message-Id: <1367386090-24633-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int,
so it's safe to use it even for callbacks with glib.
---
 profiles/audio/media.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 59fc840..4c23960 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -368,7 +368,7 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
 	return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
 }
 
-static gint transport_device_cmp(gconstpointer data, gconstpointer user_data)
+static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
 {
 	struct media_transport *transport = (struct media_transport *) data;
 	const struct audio_device *device = user_data;
-- 
1.8.2.2

