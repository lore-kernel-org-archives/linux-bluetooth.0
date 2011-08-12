Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 5/7] Update g_strcmp0 to strcasecmp
Date: Fri, 12 Aug 2011 17:27:55 +0200
Message-Id: <1313162877-14945-6-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1313162877-14945-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1313162877-14945-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/media.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index ae2b471..5ab3eab 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -639,7 +639,7 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 		if (endpoint->sep == NULL)
 			goto failed;
 	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
-					g_strcmp0(uuid, HSP_AG_UUID) == 0) {
+					strcasecmp(uuid, HSP_AG_UUID) == 0) {
 		struct audio_device *dev;
 
 		endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
-- 
1.7.1

