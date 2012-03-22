Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 1/7] media: Remove unimplemented declaration
Date: Thu, 22 Mar 2012 17:37:49 +0100
Message-Id: <1332434275-25394-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1332434275-25394-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/media.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

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
1.7.5.4

