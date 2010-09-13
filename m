Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] Introduce headset_get_inband
Date: Mon, 13 Sep 2010 17:15:34 +0300
Message-Id: <1284387337-18822-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
References: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/headset.c |   10 ++++++++++
 audio/headset.h |    1 +
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index cdb3370..dad0716 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -2701,6 +2701,16 @@ gboolean headset_get_nrec(struct audio_device *dev)
 	return hs->slc->nrec;
 }
 
+gboolean headset_get_inband(struct audio_device *dev)
+{
+	struct headset *hs = dev->headset;
+
+	if (!hs->slc)
+		return TRUE;
+
+	return hs->slc->inband_ring;
+}
+
 gboolean headset_get_sco_hci(struct audio_device *dev)
 {
 	return sco_hci;
diff --git a/audio/headset.h b/audio/headset.h
index 8b7c738..29dc02c 100644
--- a/audio/headset.h
+++ b/audio/headset.h
@@ -90,6 +90,7 @@ int headset_get_channel(struct audio_device *dev);
 
 int headset_get_sco_fd(struct audio_device *dev);
 gboolean headset_get_nrec(struct audio_device *dev);
+gboolean headset_get_inband(struct audio_device *dev);
 gboolean headset_get_sco_hci(struct audio_device *dev);
 
 gboolean headset_is_active(struct audio_device *dev);
-- 
1.7.1

