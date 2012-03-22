Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 6/7] media: implement media_endpoint_find function
Date: Thu, 22 Mar 2012 17:37:54 +0100
Message-Id: <1332434275-25394-7-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/media.c |   16 ++++++++++++++++
 audio/media.h |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index c0fd0c3..05019f3 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -1782,3 +1782,19 @@ uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint)
 {
 	return endpoint->codec;
 }
+
+struct media_endpoint *media_endpoint_find(const char *path)
+{
+	GSList *l;
+	struct media_endpoint *endpoint;
+
+	for (l = adapters; l; l = l->next) {
+		struct media_adapter *adapter = l->data;
+
+		endpoint = media_adapter_find_endpoint(adapter,
+							NULL, path, NULL);
+		if (endpoint)
+			return endpoint;
+	}
+	return NULL;
+}
diff --git a/audio/media.h b/audio/media.h
index 84fc1bc..6747fc2 100644
--- a/audio/media.h
+++ b/audio/media.h
@@ -33,3 +33,4 @@ void media_unregister(const char *path);
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
 const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
+struct media_endpoint *media_endpoint_find(const char *path);
-- 
1.7.5.4

