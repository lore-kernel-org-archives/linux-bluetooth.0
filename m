Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH] audio: Remove unimplemented declaration
Date: Tue,  3 Jul 2012 17:39:11 +0200
Message-Id: <1341329951-4498-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/media.h |    2 --
 1 file changed, 2 deletions(-)

diff --git a/audio/media.h b/audio/media.h
index ee9a51e..84fc1bc 100644
--- a/audio/media.h
+++ b/audio/media.h
@@ -33,5 +33,3 @@ void media_unregister(const char *path);
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
 const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
-struct media_transport *media_endpoint_get_transport(
-					struct media_endpoint *endpoint);
-- 
1.7.9.5

